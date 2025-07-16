Return-Path: <linux-wireless+bounces-25537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE3B075A9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 14:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF501C2445D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F652F5081;
	Wed, 16 Jul 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aiVRsAWQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809522068F
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668991; cv=none; b=JAlnbWvnwgjJBiUkmHskDa9640qSN5zJWTg3eiHYt50jL8Uoax8rH4gxj6xVU1+Ds9SWey3Y/pPU97asBJBSbVZ5vngbKASBkXQs/htpdJPS62dPcM6cZhhId3R7PyFWvZlvCCA++DEWpMNwW9HZht2WNGSXftldR7OREDpCsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668991; c=relaxed/simple;
	bh=JYweOJsgF/+DiThAwrWa/lopfhJ6zIRL1vo55aiCYq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VtxM7aZaRsve4+nrikRMVLoGelDsexiACwgJSZk9UK0bESAv3KtGVYCGVLDHmoxNtyUHdMZ/KKPRCtylncBeVQeAoqzWrWCUYjNAPlef0EVcqO0d3T3yjx/W9zd6tqOBzcEHvc1HFH89QNdw5q0OGDisRYP6DKy2r4hDj9RG4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aiVRsAWQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56GCTjbyE2353414, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752668985; bh=gAfrbPcsRGiXovvbeqwqrm4ySpKcgdHwahR/9zpMkY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=aiVRsAWQv9EM2xUHJ5bwdCYKItJt1a+FmTbY+icVORO60D8wKvu8Y6JkVlJQISJqa
	 acy9hjcBqIHY68ztwLmHoLqVV+vN/MOv3tU7izyVvNchnPPUn6jM5PX4mmXfGCc/32
	 rWbG0i0CZVpUMJ1HCJ3z55F5lNmu4vYFIK1GEU779ZkQKcTj8/WwaVrHXtQPr9gUO2
	 BM29f1STggkV0fvOqrSX9zfgYkH7892oe4tNAPwk/OIo6rUUwxMFp8WD2nrExaAklZ
	 xG+8/hXrU5oxZ7Kf3WzJ0JDPDPOmjanzMhi6p0becD4cxXQ7h2Xv511/g4TXM5DE5u
	 /arkP7q3gSiXw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56GCTjbyE2353414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 20:29:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 20:29:45 +0800
Received: from [127.0.1.1] (10.22.225.195) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Jul
 2025 20:29:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH rtw-next] wifi: rtw89: wow: Add Basic Rate IE to probe request in scheduled scan mode
Date: Wed, 16 Jul 2025 20:29:26 +0800
Message-ID: <20250716122926.6709-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Chin-Yen Lee <timlee@realtek.com>

In scheduled scan mode, the current probe request only includes the SSID
IE, but omits the Basic Rate IE. Some APs do not respond to such
incomplete probe requests, causing net-detect failures. To improve
interoperability and ensure APs respond correctly, add the Basic Rate IE
to the probe request in driver.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 4f759c75389e..2ef9117fdd6e 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1412,6 +1412,8 @@ static void rtw89_fw_release_pno_pkt_list(struct rtw89_dev *rtwdev,
 static int rtw89_pno_scan_update_probe_req(struct rtw89_dev *rtwdev,
 					   struct rtw89_vif_link *rtwvif_link)
 {
+	static const u8 basic_rate_ie[] = {WLAN_EID_SUPP_RATES, 0x08,
+		 0x0c, 0x12, 0x18, 0x24, 0x30, 0x48, 0x60, 0x6c};
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct cfg80211_sched_scan_request *nd_config = rtw_wow->nd_config;
 	u8 num = nd_config->n_match_sets, i;
@@ -1423,10 +1425,11 @@ static int rtw89_pno_scan_update_probe_req(struct rtw89_dev *rtwdev,
 		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif_link->mac_addr,
 					     nd_config->match_sets[i].ssid.ssid,
 					     nd_config->match_sets[i].ssid.ssid_len,
-					     nd_config->ie_len);
+					     nd_config->ie_len + sizeof(basic_rate_ie));
 		if (!skb)
 			return -ENOMEM;
 
+		skb_put_data(skb, basic_rate_ie, sizeof(basic_rate_ie));
 		skb_put_data(skb, nd_config->ie, nd_config->ie_len);
 
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
-- 
2.25.1


