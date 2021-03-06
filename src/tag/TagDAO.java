package tag;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import tag.Tag;
import bbs.Bbs;
public class TagDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	Bbs bbs = new Bbs();
	public TagDAO() {
		try {
			String dbURL = "jdbc:mysql://blazingcode.asuscomm.com:6000/whoever?useSSL=false";
			String dbID = "whoever";
			String dbPassword = "Whoever12#";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();	
		}
	}
	
	public int getNext() {
		String SQL = "SELECT tag_id FROM tag ORDER BY tag_id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch(Exception e){
			e.printStackTrace();
		}
	
		return -1;
	}
	
	public int getBbs() {
		String SQL = "SELECT bbs_id FROM BBS ORDER BY bbs_id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
			return 1;
		} catch(Exception e){
			e.printStackTrace();
		}
	
		return -1;
	}
	
	
	public int Hashtag(String[] tagArray) {
		String SQL = "INSERT INTO tag VALUES (?, ?, ?)";
		try {
			
			
			for(int i = 0; i<tagArray.length; i++) {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, i+1);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, tagArray[i]);
			pstmt.setInt(3, getBbs());
			pstmt.executeUpdate();
			//pstmt.setInt(8, getNext());
			//pstmt.executeUpdate();
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	
		return -1;
	}
	public Bbs getBbs(int bbs_id) {			// 글을 클릭해서 보기
		String SQL = "SELECT * FROM BBS WHERE bbs_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbs_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbs_id(rs.getInt(1));
				bbs.setBbs_title(rs.getString(2));
				bbs.setUser_id(rs.getString(3));
				bbs.setBbs_date(rs.getString(4));
				bbs.setBbs_content(rs.getString(5));
				bbs.setBbs_available(rs.getInt(6));
				bbs.setBbs_type(rs.getString(7));
				//pstmt.setString(7, bbs_type.toString());
				return bbs;
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	
		return null;
	}
	
	/*public Tag getTag(int bbs_id) {
		String SQL = "SELECT * FROM tag where _bbs_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbs_id);
			//pstmt.setInt(1, getNext() - );
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Tag tag = new Tag();
				//tag.setTag_id(rs.getInt(1));
				//category.setCategory_name(rs.getString(2));
				tag.setTag_name(rs.getString(2));
				//tag.set_bbs_id(rs.getInt(3));
				return tag;
				} 
			}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}*/
	public String getTag(int bbs_id) throws SQLException {
		String SQL = "SELECT tag_name from tag where _bbs_id = " + bbs_id;
		int cnt = 0;
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		//pstmt.setInt(1, bbs_id);
		rs = pstmt.executeQuery(SQL);
		//String SQL = "SELECT tag_name FROM tag where _bbs_id = ?";
		String tag = null;
		String tag2 = "";
		try {
			//PreparedStatement pptmt = conn.prepareStatement(SQL);
			
			//pstmt.setInt(1, getNext() - );
			//rs = pstmt.executeQuery();
			while(rs.next()) {
			//	String[] tagArray = new String[cnt];//rs.getString("tag_name");
				
				/*for(int i = 0; i < cnt; i++){
					tag = rs.getString("tag_name");
					tagArray[i] = tag;
					tag2 = tag2 + tag;
				}*/
				tag = rs.getString("tag_name");
				if(cnt == 0) {
					tag2 = tag;
				}else {
					tag2 = tag2+ " " + tag;
				}
				
				//tag.setTag_id(rs.getInt(1));
				//category.setCategory_name(rs.getString(2));
				//tag = rs.getString("tag_name");
				//tag2 = tag2 + tag;
				cnt++;
				//tag.set_bbs_id(rs.getInt(3));
				} 
			System.out.println("태그 : "+ tag2+ " " + cnt);
			return tag2;
			}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	
	public ArrayList<Tag> getHash() {
		String SQL = "SELECT * FROM tag";
		ArrayList<Tag> list = new ArrayList<Tag>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext() - );
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Tag tag = new Tag();
				tag.setTag_id(rs.getInt(1));
				//category.setCategory_name(rs.getString(2));
				tag.setTag_name(rs.getString(2));
				tag.set_bbs_id(rs.getInt(3));
				list.add(tag);
				} 
			}catch(Exception e){
			e.printStackTrace();
		}
	
		return null;
	}
	
	public int update(String[] tagArray, int bbs_id) {
		String SQL = "INSERT INTO tag VALUES (?, ?, ?)";
		
		try {
			
			
			for(int i = 0; i<tagArray.length; i++) {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			//pstmt.setInt(1, i+1);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, tagArray[i]);
			pstmt.setInt(3, bbs_id);
			pstmt.executeUpdate();
			//pstmt.setInt(8, getNext());
			//pstmt.executeUpdate();
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	
		return -1;
	}
	
	public int delete(int bbs_id){
		String SQL = "DELETE FROM TAG where _bbs_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbs_id);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
