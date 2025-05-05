Return-Path: <linux-wireless+bounces-22432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46163AA8CF4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BBB1890D41
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCCE1C84B8;
	Mon,  5 May 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="unFRC+uM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579014B965
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429904; cv=none; b=Jkn5AOxe8XynsO1DiATTtFhusP9LVKpt1ZkTMwOFeIqHrmgnURfRxgs7kJdaM3rSUyvPcpvp/VvQmYkUR38FT+hrTt8yZhv1Hra0JsCmhvfM5g0VFT23xiIQTRERFMRSii9zfv6BtwsYa+5/sIjbB+xXOH2Po+utayY1Jq2SbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429904; c=relaxed/simple;
	bh=zeGUfPB041rzO65JvDrsfj3WyentEhxZVpREngNiyl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/pBxhO0dhenlPcE31azXbMtPg2vFf/PoKEVKDl9vFo2xeso0YRR8IQoFf+x1j1HoCRA2VPX/lskKZQL2ko2VWt8WcBNx3xhXJF10gJZRdftF+xspj7oavlJdYRE854mZBoC6/KWvPxuCzgSp3exFgQeZVQapiGmjDGuzGdDtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=unFRC+uM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457OxY123831127, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429900; bh=zeGUfPB041rzO65JvDrsfj3WyentEhxZVpREngNiyl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=unFRC+uM7sn4Qs8C2NAdIRPfwXej3irKlPv88bixj3dYqrBsB9DImVkqUVrliL+xO
	 bKp/oTYiCNT7C5YVVxM2soRR8ES1hwYHyMcF2nytrAznBlJrmvX2iblA+ZmwJrpyrm
	 tHOlenWRrxsNLx/GyooumEliib68fd2AaqMuhnNaxp4hyugat05ydIhuQiWLmmf3hu
	 Kc8o/r3lUOzHqNXyQ8Fb5jscJTLAEhrgfz7lJIk/SbqNNNeYmO+8hkkmMyf9X1Co9M
	 ozmp3wBsZyw1bW9m3PpGWrNhAPSc6MHhCFWAv6ukRIrc2CIi3A71y9fFtSokGBZfF5
	 kEUuzl0ooxMag==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457OxY123831127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:24:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:24:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/11] wifi: rtw89: allow driver to do specific band TX for MLO
Date: Mon, 5 May 2025 15:24:31 +0800
Message-ID: <20250505072440.45113-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Po-Hao Huang <phhuang@realtek.com>

For data packets that can be sent on any band, fill in main mac_id
and let HW decide. For packets that we wish to transmit on specific
band, fill in sw_mld field so HW would only send it on that band.
Main mac_id is the corresponding mac_id on band 0.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 17 ++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0fd902eef05b..c8b00f790829 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -658,9 +658,17 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
 				   struct rtw89_core_tx_request *tx_req)
 {
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct rtw89_vif_link *rtwvif_link = tx_req->rtwvif_link;
 	struct rtw89_sta_link *rtwsta_link = tx_req->rtwsta_link;
 
+	if (desc_info->mlo && !desc_info->sw_mld) {
+		if (rtwsta_link)
+			return rtw89_sta_get_main_macid(rtwsta_link->rtwsta);
+		else
+			return rtw89_vif_get_main_macid(rtwvif_link->rtwvif);
+	}
+
 	if (!rtwsta_link)
 		return rtwvif_link->mac_id;
 
@@ -1126,7 +1134,7 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link,
-				    struct sk_buff *skb, int *qsel)
+				    struct sk_buff *skb, int *qsel, bool sw_mld)
 {
 	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
@@ -1139,6 +1147,7 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.sta = sta;
 	tx_req.rtwvif_link = rtwvif_link;
 	tx_req.rtwsta_link = rtwsta_link;
+	tx_req.desc_info.sw_mld = sw_mld;
 
 	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, true);
 	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, true);
@@ -1181,7 +1190,7 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		}
 	}
 
-	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel);
+	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel, false);
 }
 
 static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
@@ -1411,7 +1420,9 @@ static __le32 rtw89_build_txwd_body2_v2(struct rtw89_tx_desc_info *desc_info)
 
 static __le32 rtw89_build_txwd_body3_v2(struct rtw89_tx_desc_info *desc_info)
 {
-	u32 dword = FIELD_PREP(BE_TXD_BODY3_WIFI_SEQ, desc_info->seq);
+	u32 dword = FIELD_PREP(BE_TXD_BODY3_WIFI_SEQ, desc_info->seq) |
+		    FIELD_PREP(BE_TXD_BODY3_MLO_FLAG, desc_info->mlo) |
+		    FIELD_PREP(BE_TXD_BODY3_IS_MLD_SW_EN, desc_info->sw_mld);
 
 	return cpu_to_le32(dword);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index dfc578ad8c64..4e44cbd6cc53 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1175,6 +1175,7 @@ struct rtw89_tx_desc_info {
 	bool ldpc;
 	bool upd_wlan_hdr;
 	bool mlo;
+	bool sw_mld;
 };
 
 struct rtw89_core_tx_request {
-- 
2.25.1


