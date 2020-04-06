Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067CB19F123
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDFHrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 03:47:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47203 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFHrV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 03:47:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0367l7S71019689, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0367l7S71019689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 6 Apr 2020 15:47:07 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Apr 2020 15:47:07 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Apr 2020 15:47:07 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <timlee@realtek.com>
Subject: [PATCH] rtw88: add more check for wowlan pattern
Date:   Mon, 6 Apr 2020 15:47:05 +0800
Message-ID: <20200406074705.25022-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Previously the mask of wowlan pattern is not checked,
and it may lead to wrong pattern match. We fix it and
add wildcard type for the pattern whose DA is not masked.
Besides, if user pattern is an invalid type for us,
show the error in kernel log, and then wowlan will
not work.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/wow.c | 101 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw88/wow.h |  13 ++-
 2 files changed, 86 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index 2fcdf70a3a77..d87f6b13d2a0 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -74,6 +74,9 @@ static void rtw_wow_pattern_write_cam_ent(struct rtw_dev *rtwdev, u8 id,
 	case RTW_PATTERN_UNICAST:
 		wdata |= BIT_WKFMCAM_UC | BIT_WKFMCAM_VALID;
 		break;
+	case RTW_PATTERN_WILDCARD:
+		wdata |= BIT_WKFMCAM_VALID;
+		break;
 	default:
 		break;
 	}
@@ -131,17 +134,47 @@ static u16 rtw_calc_crc(u8 *pdata, int length)
 	return ~crc;
 }
 
-static void rtw_wow_pattern_generate(struct rtw_dev *rtwdev,
-				     struct rtw_vif *rtwvif,
-				     const struct cfg80211_pkt_pattern *pkt_pattern,
-				     struct rtw_wow_pattern *rtw_pattern)
+static int rtw_wow_pattern_get_type(struct rtw_vif *rtwvif,
+				    const u8 *pattern, u8 da_mask)
+{
+	u8 da[ETH_ALEN];
+	u8 type;
+
+	ether_addr_copy_mask(da, pattern, da_mask);
+
+	/* Each pattern is divided into different kinds by DA address
+	 *  a. DA is broadcast address
+	 *  b. DA is multicast address
+	 *  c. DA is unicast address same as dev's mac address
+	 *  d. DA is unmasked. Also called wildcard type.
+	 *  e. Others is invalid type.
+	 */
+	if (!da_mask)
+		type = RTW_PATTERN_WILDCARD;
+	else if (is_broadcast_ether_addr(da))
+		type = RTW_PATTERN_BROADCAST;
+	else if (is_multicast_ether_addr(da))
+		type = RTW_PATTERN_MULTICAST;
+	else if (ether_addr_equal(da, rtwvif->mac_addr) &&
+		 (da_mask == GENMASK(5, 0)))
+		type = RTW_PATTERN_UNICAST;
+	else
+		type = RTW_PATTERN_INVALID;
+
+	return type;
+}
+
+static int rtw_wow_pattern_generate(struct rtw_dev *rtwdev,
+				    struct rtw_vif *rtwvif,
+				    const struct cfg80211_pkt_pattern *pkt_pattern,
+				    struct rtw_wow_pattern *rtw_pattern)
 {
 	const u8 *mask;
 	const u8 *pattern;
 	u8 mask_hw[RTW_MAX_PATTERN_MASK_SIZE] = {0};
 	u8 content[RTW_MAX_PATTERN_SIZE] = {0};
-	u8 mac_addr[ETH_ALEN] = {0};
 	u8 mask_len;
+	u8 type;
 	u16 count;
 	int len;
 	int i;
@@ -149,20 +182,15 @@ static void rtw_wow_pattern_generate(struct rtw_dev *rtwdev,
 	pattern = pkt_pattern->pattern;
 	len = pkt_pattern->pattern_len;
 	mask = pkt_pattern->mask;
-
-	ether_addr_copy(mac_addr, rtwvif->mac_addr);
+	mask_len = DIV_ROUND_UP(len, 8);
 	memset(rtw_pattern, 0, sizeof(*rtw_pattern));
 
-	mask_len = DIV_ROUND_UP(len, 8);
+	type = rtw_wow_pattern_get_type(rtwvif, pattern,
+					mask[0] & GENMASK(5, 0));
+	if (type == RTW_PATTERN_INVALID)
+		return -EPERM;
 
-	if (is_broadcast_ether_addr(pattern))
-		rtw_pattern->type = RTW_PATTERN_BROADCAST;
-	else if (is_multicast_ether_addr(pattern))
-		rtw_pattern->type = RTW_PATTERN_MULTICAST;
-	else if (ether_addr_equal(pattern, mac_addr))
-		rtw_pattern->type = RTW_PATTERN_UNICAST;
-	else
-		rtw_pattern->type = RTW_PATTERN_INVALID;
+	rtw_pattern->type = type;
 
 	/* translate mask from os to mask for hw
 	 * pattern from OS uses 'ethenet frame', like this:
@@ -208,6 +236,35 @@ static void rtw_wow_pattern_generate(struct rtw_dev *rtwdev,
 	}
 
 	rtw_pattern->crc = rtw_calc_crc(content, count);
+
+	return 0;
+}
+
+static int rtw_wow_parse_patterns(struct rtw_dev *rtwdev,
+				  struct rtw_vif *rtwvif,
+				  struct cfg80211_wowlan *wowlan)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw_wow_pattern *rtw_patterns = rtw_wow->patterns;
+	int i;
+	int ret;
+
+	if (!wowlan->n_patterns || !wowlan->patterns)
+		return 0;
+
+	for (i = 0; i < wowlan->n_patterns; i++) {
+		ret = rtw_wow_pattern_generate(rtwdev, rtwvif,
+					       wowlan->patterns + i,
+					       rtw_patterns + i);
+		if (ret) {
+			rtw_err(rtwdev, "failed to generate pattern(%d)\n", i);
+			rtw_wow->pattern_cnt = 0;
+			return ret;
+		}
+	}
+	rtw_wow->pattern_cnt = wowlan->n_patterns;
+
+	return 0;
 }
 
 static void rtw_wow_pattern_clear_cam(struct rtw_dev *rtwdev)
@@ -769,9 +826,7 @@ static int rtw_wow_set_wakeups(struct rtw_dev *rtwdev,
 			       struct cfg80211_wowlan *wowlan)
 {
 	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
-	struct rtw_wow_pattern *rtw_patterns = rtw_wow->patterns;
 	struct rtw_vif *rtwvif;
-	int i;
 
 	if (wowlan->disconnect)
 		set_bit(RTW_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags);
@@ -788,15 +843,7 @@ static int rtw_wow_set_wakeups(struct rtw_dev *rtwdev,
 		return -EPERM;
 
 	rtwvif = (struct rtw_vif *)rtw_wow->wow_vif->drv_priv;
-	if (wowlan->n_patterns && wowlan->patterns) {
-		rtw_wow->pattern_cnt = wowlan->n_patterns;
-		for (i = 0; i < wowlan->n_patterns; i++)
-			rtw_wow_pattern_generate(rtwdev, rtwvif,
-						 wowlan->patterns + i,
-						 rtw_patterns + i);
-	}
-
-	return 0;
+	return rtw_wow_parse_patterns(rtwdev, rtwvif, wowlan);
 }
 
 static void rtw_wow_clear_wakeups(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/wow.h b/drivers/net/wireless/realtek/rtw88/wow.h
index 289368a2cba4..bbb8cdab34c7 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.h
+++ b/drivers/net/wireless/realtek/rtw88/wow.h
@@ -11,7 +11,7 @@ enum rtw_wow_pattern_type {
 	RTW_PATTERN_BROADCAST = 0,
 	RTW_PATTERN_MULTICAST,
 	RTW_PATTERN_UNICAST,
-	RTW_PATTERN_VALID,
+	RTW_PATTERN_WILDCARD,
 	RTW_PATTERN_INVALID,
 };
 
@@ -52,6 +52,17 @@ static inline bool rtw_wow_no_link(struct rtw_dev *rtwdev)
 	return (rtwvif->net_type == RTW_NET_NO_LINK);
 }
 
+static inline void ether_addr_copy_mask(u8 *dst, const u8 *src, u8 mask)
+{
+	int i;
+
+	eth_zero_addr(dst);
+	for (i = 0; i < ETH_ALEN; i++) {
+		if (mask & BIT(i))
+			dst[i] = src[i];
+	}
+}
+
 int rtw_wow_suspend(struct rtw_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw_wow_resume(struct rtw_dev *rtwdev);
 
-- 
2.17.1

