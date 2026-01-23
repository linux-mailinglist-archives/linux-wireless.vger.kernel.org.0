Return-Path: <linux-wireless+bounces-31094-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E5KCsfRcmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31094-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 985836F31F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F031430156D5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E736CDF2;
	Fri, 23 Jan 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iBrUwvMv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA52EB859
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132474; cv=none; b=YC2ua9OQqxXrZE7DBDtg7iZ9rvxlQPRKmMYZdZXMydU4bBPP3XAvtePfwhAG9o3ev7dRpT92xG/YUOlgZgAJwv+W/2QRaTwBBJ+NUyjCT2AMdMNCUy70DbxiNt9XFTJNKEXBZ6Y3BqH7qfkMUN8WuBfJ75CkQjdT9J2wo8O51Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132474; c=relaxed/simple;
	bh=V+CvZ/AI7ITRs8DlTKbEAy1KfDHtwaOt3BLboZkOf1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJK/0eP9RbHKTld4MBngbo0gTTbjWIMSr8bFYUle2zhrC4ZMdmVA/ZtRcOkyCny5kDcLJvfmQycZD3B0Niaj1MSWnrFCr/41wgPlODjrKVs+kJApMqGr7PWajIR/ZzH0V7+IfgDK6H7vuvBzqO+MiCr+/0oi1MAVjxE+xmHQe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iBrUwvMv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1f2owD2206804, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132462; bh=qvepXkSNfq7JA3zowpBXYiXTsloicMuUTaOIl7juIcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iBrUwvMvPNRJ3xswlT8NaUhs1Ft7Z+evdQK4t0sOBHST8cjipVBBj+0xeiVWN42Jf
	 fWXuDWkIFRIdSeviJnO1aoa4xH/zNzx+DDF4RGrEFaUigOWmeKMF41cjV+oEJ9+xiJ
	 HKT0XSZndJEA4n4xmyUg7ZWkZ+ScX4IPIN/bf9Y/kHK9sfcqUrkh2p2eaEadUc5OOj
	 1zW24fjgPMxJzZR+ZPK6vSjRSeRCw7lepgpPZG9IhoaqtxKTyqDOttKTuxxUzZamAM
	 fR1IELk40azb1ylUtCVgEEQgWUVNqfNi+74iVRimuQOes7kF4EpKjd7RJAPEMtb7Un
	 gsLse70E5tMLQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1f2owD2206804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:41:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:41:01 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:41:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/11] wifi: rtw89: rfk: update RFK report format of IQK, DACK and TXGAPK
Date: Fri, 23 Jan 2026 09:39:51 +0800
Message-ID: <20260123013957.16418-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123013957.16418-1-pkshih@realtek.com>
References: <20260123013957.16418-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31094-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 985836F31F
X-Rspamd-Action: no action

The report formats of IQK, DACK and TXGAPK are changed. Update them
accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 24 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/phy.c | 30 +++++++++++++++++++-----
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4fa982cbac49..e4dbcd899ddb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5005,12 +5005,16 @@ struct rtw89_c2h_rf_iqk_rpt_log {
 	u8 rsvd;
 	__le32 reload_cnt;
 	__le32 iqk_fail_cnt;
+	__le32 rf_0x18[2];
 	__le32 lok_idac[2];
 	__le32 lok_vbuf[2];
-	__le32 rftxgain[2][4];
-	__le32 rfrxgain[2][4];
-	__le32 tx_xym[2][4];
-	__le32 rx_xym[2][4];
+	__le32 rftxgain[2][6];
+	__le32 rfrxgain[2][6];
+	__le32 tx_xym[2][6];
+	__le32 rx_xym[2][6];
+	__le32 rx_wb_xym[2][32];
+	bool is_radar;
+	u8 rsvd1[3];
 } __packed;
 
 struct rtw89_c2h_rf_dpk_rpt_log {
@@ -5053,6 +5057,7 @@ struct rtw89_c2h_rf_dack_rpt_log {
 	u8 dack_fail;
 	u8 wbdck_d[2];
 	u8 rck_d;
+	u8 adgaink_ex_d;
 } __packed;
 
 struct rtw89_c2h_rf_rxdck_rpt_log {
@@ -5079,12 +5084,14 @@ struct rtw89_c2h_rf_txgapk_rpt_log {
 	u8 is_txgapk_ok;
 	u8 chk_id;
 	u8 ver;
-	u8 rsv1;
+	u8 d_bnd_ok;
+	__le32 stage[2];
+	__le16 failcode[2];
+	u8 rsvd[4];
 } __packed;
 
 struct rtw89_c2h_rf_txiqk_rpt_log {
 	u8 fw_txiqk_ver;
-	u8 rsvd;
 	u8 iqk_band[2];
 	u8 iqk_ch[2];
 	u8 iqk_bw[2];
@@ -5093,13 +5100,14 @@ struct rtw89_c2h_rf_txiqk_rpt_log {
 	bool txiqk_en;
 	bool lok_en;
 	bool lok_fail[2];
-	u8 rsvd2;
+	u8 rsvd[2];
 	__le32 iqk_times;
 	bool txiqk_nctldone[2];
-	u8 rsvd3[2];
+	u8 rsvd2[2];
 	__le32 txgain[2][6];
 	__le32 tx_iqc[2][6];
 	__le32 tx_xym[2][6][14];
+	__le32 kidx[2];
 } __packed;
 
 struct rtw89_c2h_rf_cim3k_rpt_log {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 11f45e30d76d..41a8ce3aaffc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3512,6 +3512,8 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 				    i, iqk->iqk_ch[i]);
 			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->iqk_bw[%d] = %x\n",
 				    i, iqk->iqk_bw[i]);
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->rf_0x18[%d] = %x\n",
+				    i, le32_to_cpu(iqk->rf_0x18[i]));
 			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->lok_idac[%d] = %x\n",
 				    i, le32_to_cpu(iqk->lok_idac[i]));
 			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->lok_vbuf[%d] = %x\n",
@@ -3520,22 +3522,30 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 				    i, iqk->iqk_tx_fail[i]);
 			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] iqk->iqk_rx_fail[%d] = %x\n",
 				    i, iqk->iqk_rx_fail[i]);
-			for (j = 0; j < 4; j++)
+			for (j = 0; j < 6; j++)
 				rtw89_debug(rtwdev, RTW89_DBG_RFK,
 					    "[IQK] iqk->rftxgain[%d][%d] = %x\n",
 					    i, j, le32_to_cpu(iqk->rftxgain[i][j]));
-			for (j = 0; j < 4; j++)
+			for (j = 0; j < 6; j++)
 				rtw89_debug(rtwdev, RTW89_DBG_RFK,
 					    "[IQK] iqk->tx_xym[%d][%d] = %x\n",
 					    i, j, le32_to_cpu(iqk->tx_xym[i][j]));
-			for (j = 0; j < 4; j++)
+			for (j = 0; j < 6; j++)
 				rtw89_debug(rtwdev, RTW89_DBG_RFK,
 					    "[IQK] iqk->rfrxgain[%d][%d] = %x\n",
 					    i, j, le32_to_cpu(iqk->rfrxgain[i][j]));
-			for (j = 0; j < 4; j++)
+			for (j = 0; j < 6; j++)
 				rtw89_debug(rtwdev, RTW89_DBG_RFK,
 					    "[IQK] iqk->rx_xym[%d][%d] = %x\n",
 					    i, j, le32_to_cpu(iqk->rx_xym[i][j]));
+
+			if (!iqk->iqk_xym_en)
+				continue;
+
+			for (j = 0; j < 32; j++)
+				rtw89_debug(rtwdev, RTW89_DBG_RFK,
+					    "[IQK] iqk->rx_wb_xym[%d][%d] = %x\n",
+					    i, j, iqk->rx_wb_xym[i][j]);
 		}
 		return;
 	case RTW89_PHY_C2H_RFK_LOG_FUNC_DPK:
@@ -3691,8 +3701,16 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 			    le32_to_cpu(txgapk->chk_cnt));
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt ver = 0x%x\n",
 			    txgapk->ver);
-		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt rsv1 = %d\n",
-			    txgapk->rsv1);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt d_bnd_ok = %d\n",
+			    txgapk->d_bnd_ok);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt stage[0] = 0x%x\n",
+			    le32_to_cpu(txgapk->stage[0]));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt stage[1] = 0x%x\n",
+			    le32_to_cpu(txgapk->stage[1]));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]failcode[0] = 0x%x\n",
+			    le16_to_cpu(txgapk->failcode[0]));
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]failcode[1] = 0x%x\n",
+			    le16_to_cpu(txgapk->failcode[1]));
 
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt track_d[0] = %*ph\n",
 			    (int)sizeof(txgapk->track_d[0]), txgapk->track_d[0]);
-- 
2.25.1


