Return-Path: <linux-wireless+bounces-15524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A69D32BC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 04:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731ABB21F9C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 03:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4118E2914;
	Wed, 20 Nov 2024 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cCprHR4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A16149C42
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074112; cv=none; b=tVHPatKt0bsIecYCRDUCeFdRHBE3AuE53kRNzIRiT6M//cUdBu068Q3+wN7OGcYfcPoyrL7xWebFHnRWsfIsfz2BkpDNK6WylcBBhl4nZAI283lJ4gqoKyFhZkm1FevRQr5EKGZdUwYo36BUgT0jtmGnqPUvl4+vZ1xRRBeC6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074112; c=relaxed/simple;
	bh=o3IB+NgeC1PF1hF1UF+qgZcGGTpDldT/RPvGjt0daT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBMYSYfx7eR7tNEl2bizbf56yNcjf6f6flGlTid21iR+ME7mOWeeeKccd7vKvw02rZpAmnw6cTEglj/73XnZ1p0H/zQOuugTOoidN8y963W0RfREbq8I+nurtuLZfC9shq6eZmqX5Q5FLMGUDMVcwaZhouru2wduKjgis6Qf1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cCprHR4z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK3flnP73465171, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732074107; bh=o3IB+NgeC1PF1hF1UF+qgZcGGTpDldT/RPvGjt0daT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cCprHR4z1k1wMqdzTOLDzMglQge7305EcRW80oqNEJI7/ZFMEH8XcvRvw1RPtMTYp
	 Yk9RNalUHUrbKXLj94fvdw0fRHSQmHG4KkPSKSeN3hCsqIWXz49coSOIvy29H2DttN
	 /7i91MBkiu+W+IAqrqn/dNvfmmkOJt0lJ5a62fMhUvs8oViZl0DBEcmmg4fY0b0XOj
	 NoV9ZM5DPe4S14BmsiDxJC2ClUXWdGjBKEhGrvbxH8LCGax1rzDd4Bbkn99rzXp+pb
	 XQrqz4ZO8B5kWEF/HqUCMituN0qr2FG/XXl6g1TTE4Rjn60QqCJtUum6b29l71l3RV
	 JlU60Q+msWjgQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK3flnP73465171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 11:41:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:41:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Nov
 2024 11:41:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH v3 4/6] wifi: rtw89: apply MLD pairwise key to dynamically active links
Date: Wed, 20 Nov 2024 11:40:52 +0800
Message-ID: <20241120034054.13575-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120034054.13575-1-pkshih@realtek.com>
References: <20241120034054.13575-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In MLD connection, a pairwise key should work on all active links. And, we
take just one entry in security CAM for one pairwise key. (It means we will
reuse one single entry for all links.) Originally, we already applied the
security CAM entry of pairwise key to deflink's address CAM.

However, links can be activated dynamically. So now for pairwise keys, each
rtw89_sta records the IDs of the security CAM entries. Then, when driver is
notified that some links are active via change_sta_links(), we apply target
pairwise keys to them according to the record.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 32 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/cam.h      |  5 +++
 drivers/net/wireless/realtek/rtw89/core.h     |  4 +++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 16 ++++++++++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8ef59994c0db..8fa1e6c1ce13 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -135,8 +135,8 @@ static int rtw89_cam_get_avail_sec_cam(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_cam_get_addr_cam_key_idx(struct rtw89_addr_cam_entry *addr_cam,
-					  struct rtw89_sec_cam_entry *sec_cam,
-					  struct ieee80211_key_conf *key,
+					  const struct rtw89_sec_cam_entry *sec_cam,
+					  const struct ieee80211_key_conf *key,
 					  u8 *key_idx)
 {
 	u8 idx;
@@ -246,8 +246,8 @@ static int __rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 static int __rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 				      struct rtw89_vif_link *rtwvif_link,
 				      struct rtw89_sta_link *rtwsta_link,
-				      struct ieee80211_key_conf *key,
-				      struct rtw89_sec_cam_entry *sec_cam)
+				      const struct ieee80211_key_conf *key,
+				      const struct rtw89_sec_cam_entry *sec_cam)
 {
 	struct rtw89_addr_cam_entry *addr_cam;
 	u8 key_idx = 0;
@@ -286,6 +286,22 @@ static int __rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+int rtw89_cam_attach_link_sec_cam(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_sta_link *rtwsta_link,
+				  u8 sec_cam_idx)
+{
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	const struct rtw89_sec_cam_entry *sec_cam;
+
+	sec_cam = cam_info->sec_entries[sec_cam_idx];
+	if (!sec_cam)
+		return -ENOENT;
+
+	return __rtw89_cam_attach_sec_cam(rtwdev, rtwvif_link, rtwsta_link,
+					  sec_cam->key_conf, sec_cam);
+}
+
 static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta,
@@ -306,6 +322,9 @@ static int rtw89_cam_detach_sec_cam(struct rtw89_dev *rtwdev,
 
 	rtwvif = vif_to_rtwvif(vif);
 
+	if (rtwsta)
+		clear_bit(sec_cam->sec_cam_idx, rtwsta->pairwise_sec_cam_map);
+
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
 		rtwsta_link = rtwsta ? rtwsta->links[link_id] : NULL;
 		if (rtwsta && !rtwsta_link)
@@ -369,6 +388,8 @@ static int rtw89_cam_attach_sec_cam(struct rtw89_dev *rtwdev,
 			return ret;
 	}
 
+	set_bit(sec_cam->sec_cam_idx, rtwsta->pairwise_sec_cam_map);
+
 	return 0;
 }
 
@@ -410,6 +431,9 @@ static int rtw89_cam_sec_key_install(struct rtw89_dev *rtwdev,
 	sec_cam->len = RTW89_SEC_CAM_LEN;
 	sec_cam->ext_key = ext_key;
 	memcpy(sec_cam->key, key->key, key->keylen);
+
+	sec_cam->key_conf = key;
+
 	ret = rtw89_cam_send_sec_key_cmd(rtwdev, sec_cam);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send sec key cmd: %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 3134ebf08825..8fd2d776408e 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -578,4 +578,9 @@ int rtw89_cam_sec_key_del(struct rtw89_dev *rtwdev,
 void rtw89_cam_bssid_changed(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link);
 void rtw89_cam_reset_keys(struct rtw89_dev *rtwdev);
+int rtw89_cam_attach_link_sec_cam(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif_link *rtwvif_link,
+				  struct rtw89_sta_link *rtwsta_link,
+				  u8 sec_cam_idx);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bcfefd7fa01e..409cbdc6b92a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3359,6 +3359,8 @@ struct rtw89_sec_cam_entry {
 	u8 spp_mode : 1;
 	/* 256 bits */
 	u8 key[32];
+
+	struct ieee80211_key_conf *key_conf;
 };
 
 struct rtw89_sta_link {
@@ -5761,6 +5763,8 @@ struct rtw89_sta {
 	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
 	DECLARE_BITMAP(ampdu_map, IEEE80211_NUM_TIDS);
 
+	DECLARE_BITMAP(pairwise_sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
+
 	u8 links_inst_valid_num;
 	DECLARE_BITMAP(links_inst_map, __RTW89_MLD_MAX_LINK_NUM);
 	struct rtw89_sta_link *links[IEEE80211_MLD_MAX_NUM_LINKS];
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a4e47ef22b9b..bf7a674bce28 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -509,6 +509,7 @@ static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
 
 	skb_queue_head_init(&rtwsta->roc_queue);
+	bitmap_zero(rtwsta->pairwise_sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
 
 	rtwsta_link = rtw89_sta_set_link(rtwsta, sta->deflink.link_id);
 	if (!rtwsta_link) {
@@ -1656,6 +1657,7 @@ static int __rtw89_ops_set_sta_links(struct rtw89_dev *rtwdev,
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_sta_link *rtwsta_link;
 	unsigned int link_id;
+	u8 sec_cam_idx;
 	int ret;
 
 	for_each_set_bit(link_id, &set_links, IEEE80211_MLD_MAX_NUM_LINKS) {
@@ -1682,6 +1684,20 @@ static int __rtw89_ops_set_sta_links(struct rtw89_dev *rtwdev,
 		}
 
 		__rtw89_ops_bss_link_assoc(rtwdev, rtwvif_link);
+
+		for_each_set_bit(sec_cam_idx, rtwsta->pairwise_sec_cam_map,
+				 RTW89_MAX_SEC_CAM_NUM) {
+			ret = rtw89_cam_attach_link_sec_cam(rtwdev,
+							    rtwvif_link,
+							    rtwsta_link,
+							    sec_cam_idx);
+			if (ret) {
+				rtw89_err(rtwdev,
+					  "%s: failed to apply pairwise key (link id %u)\n",
+					  __func__, link_id);
+				return ret;
+			}
+		}
 	}
 
 	return 0;
-- 
2.25.1


