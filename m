Return-Path: <linux-wireless+bounces-22437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDBAAA8CFC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998B118918B8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24031C84B8;
	Mon,  5 May 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ps/QHGW/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E31DF75D
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429919; cv=none; b=UGyCF9TJUS3HtiEZRQgqr/4VzKVXTHXYfwg1ofleUkqhSMm44hFh83YL3NxrELTqCyv9zOtbKohIVpvxQltcjkmgiFllpsEaIivQ3m+r5+qEq5s+7rmrqe1LUJwPZxuKoxrHYiT1JqDdWyoSPFO1IGSCt8OmQjTFBqiVYlyx5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429919; c=relaxed/simple;
	bh=o8O4QQk0KWgapgGpbTv/k9YFYY1kg1+4vfF5GWCzRd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIRH3syePKjQ8q5MUMKa8lyzKQl4eNjf/UzOcFjh4ClpZMIZZ52QhO6Wuv9b8yPk+IJef0Ry2bYLHVbfCb9QdsdBcy+9Z1ZeiW2zptqKuvdC5OXMVulGTGvfYYGXYM9OT1KAcd2PjpI3JPECOZ/SX1N2mNu36t/ziIKU/YtVtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ps/QHGW/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457PG0L03831280, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429916; bh=o8O4QQk0KWgapgGpbTv/k9YFYY1kg1+4vfF5GWCzRd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ps/QHGW/nnOFK5W6j+3eYMzw6c2ovZ49BxHwEbII/7reczv3+TAdNE9MXw9NI4gon
	 Ww+nYya/LL27OZqAv47hZVFk7bN1kF2SAHXpdQMiMPbm9F9jR/SUSZ3YRvF5RzG+K4
	 jHiK21jAWaH/5j4Envq6vXxkYeIK5r4M98pMvFkQGHa5qw43ZbjttUEZC/CKoAPYXJ
	 sCTKD3vPaAZt107LFqyO6dYzckt7CvcN++FaqbhoNJifIJ/DVYbsDLYU+ZEEGBIUXz
	 cui4ymuH+LO3kaNDPVo0wvfVmYjDqdm1LJ6loBP/AldCHEal2nBFbLCm4Z79VI9afC
	 365pjNAV4Z4zQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457PG0L03831280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/11] wifi: rtw89: debug: extend dbgfs for MLO
Date: Mon, 5 May 2025 15:24:36 +0800
Message-ID: <20250505072440.45113-8-pkshih@realtek.com>
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

Extend dbgfs vif/sta info to show current designated link.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 24 ++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 10e011827379..5442e3c9cbb7 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3971,14 +3971,16 @@ static int rtw89_dump_pkt_offload(char *buf, size_t bufsz, struct list_head *pkt
 
 static int rtw89_vif_link_ids_get(struct rtw89_dev *rtwdev,
 				  char *buf, size_t bufsz, u8 *mac,
-				  struct rtw89_vif_link *rtwvif_link)
+				  struct rtw89_vif_link *rtwvif_link,
+				  bool designated)
 {
 	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif_link->bssid_cam;
 	char *p = buf, *end = buf + bufsz;
 
 	p += scnprintf(p, end - p, "    [%u] %pM\n", rtwvif_link->mac_id,
 		       rtwvif_link->mac_addr);
-	p += scnprintf(p, end - p, "\tlink_id=%u\n", rtwvif_link->link_id);
+	p += scnprintf(p, end - p, "\tlink_id=%u%s\n", rtwvif_link->link_id,
+		       designated ? " (*)" : "");
 	p += scnprintf(p, end - p, "\tbssid_cam_idx=%u\n",
 		       bssid_cam->bssid_cam_idx);
 	p += rtw89_dump_addr_cam(rtwdev, p, end - p, &rtwvif_link->addr_cam);
@@ -3995,15 +3997,19 @@ void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 		(struct rtw89_debugfs_iter_data *)data;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_vif_link *designated_link;
 	struct rtw89_vif_link *rtwvif_link;
 	size_t bufsz = iter_data->bufsz;
 	char *buf = iter_data->buf;
 	char *p = buf, *end = buf + bufsz;
 	unsigned int link_id;
 
+	designated_link = rtw89_get_designated_link(rtwvif);
+
 	p += scnprintf(p, end - p, "VIF %pM\n", rtwvif->mac_addr);
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
-		p += rtw89_vif_link_ids_get(rtwdev, p, end - p, mac, rtwvif_link);
+		p += rtw89_vif_link_ids_get(rtwdev, p, end - p, mac, rtwvif_link,
+					    rtwvif_link == designated_link);
 
 	rtw89_debugfs_iter_data_next(iter_data, p, end - p, p - buf);
 }
@@ -4033,7 +4039,8 @@ static int rtw89_dump_ba_cam(struct rtw89_dev *rtwdev,
 
 static int rtw89_sta_link_ids_get(struct rtw89_dev *rtwdev,
 				  char *buf, size_t bufsz,
-				  struct rtw89_sta_link *rtwsta_link)
+				  struct rtw89_sta_link *rtwsta_link,
+				  bool designated)
 {
 	struct ieee80211_link_sta *link_sta;
 	char *p = buf, *end = buf + bufsz;
@@ -4047,7 +4054,8 @@ static int rtw89_sta_link_ids_get(struct rtw89_dev *rtwdev,
 
 	rcu_read_unlock();
 
-	p += scnprintf(p, end - p, "\tlink_id=%u\n", rtwsta_link->link_id);
+	p += scnprintf(p, end - p, "\tlink_id=%u%s\n", rtwsta_link->link_id,
+		       designated ? " (*)" : "");
 	p += rtw89_dump_addr_cam(rtwdev, p, end - p, &rtwsta_link->addr_cam);
 	p += rtw89_dump_ba_cam(rtwdev, p, end - p, rtwsta_link);
 
@@ -4060,16 +4068,20 @@ static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 		(struct rtw89_debugfs_iter_data *)data;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
+	struct rtw89_sta_link *designated_link;
 	struct rtw89_sta_link *rtwsta_link;
 	size_t bufsz = iter_data->bufsz;
 	char *buf = iter_data->buf;
 	char *p = buf, *end = buf + bufsz;
 	unsigned int link_id;
 
+	designated_link = rtw89_get_designated_link(rtwsta);
+
 	p += scnprintf(p, end - p, "STA %pM %s\n", sta->addr,
 		       sta->tdls ? "(TDLS)" : "");
 	rtw89_sta_for_each_link(rtwsta, rtwsta_link, link_id)
-		p += rtw89_sta_link_ids_get(rtwdev, p, end - p, rtwsta_link);
+		p += rtw89_sta_link_ids_get(rtwdev, p, end - p, rtwsta_link,
+					    rtwsta_link == designated_link);
 
 	rtw89_debugfs_iter_data_next(iter_data, p, end - p, p - buf);
 }
-- 
2.25.1


