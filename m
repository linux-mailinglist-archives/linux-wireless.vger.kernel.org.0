Return-Path: <linux-wireless+bounces-22359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D692AA7A5D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 21:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043999A75B9
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 19:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FEB1F4162;
	Fri,  2 May 2025 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="N/8AKUe6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339641A5B87
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746215053; cv=none; b=FcmMHMca2u+aI1N8gDtQNcMQh7pA/sNaJZuNZ0YBOpHwqHhVgcBsY2eqvBIPfaZPNPLykfgqBXipv/w1KRL+jBpXbtBKIpqt0eUDTIUy+JJMDyK4HE+h8bm9nr/pxh4IO5V0AmzMahgGT4xlE/OXinD9Ora4hPZ0WlEBMAc5gm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746215053; c=relaxed/simple;
	bh=u7M8GWj4IaX6mHqj2i5wR0WVsdjlkUXEkduLTA39lkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=teaf5+qDIn58pTkGaPnruUAiP75i8Had7hawWdirSHqUhqGEXoU0WLdJAvgHdaiM7RZGZyay1BRUIm8Vpy0G0AcF8IQB88dKlRJyR3BNJzeg5HW+x0O5PFcdyeP6oZBCwKxoTjzHsPOWquG4Zl1s7xRd/SxjAsl+C+kXK3JP/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=N/8AKUe6; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 515 invoked from network); 2 May 2025 21:44:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1746215047; bh=M8iujvxQGOpd8snMonMxwTWSoEQvZ8kYbB55eRI/Mo0=;
          h=From:To:Cc:Subject;
          b=N/8AKUe6Injy9Ohy5Wkyyu/L+NPlcfznrBAkLB8+T9oV+0O+5Vn9y6Nap6W+piWxk
           fXoabanY3CIrc+3IHpmAQUNZOMnT1mjFqdR+rorFGs9zaJ8skIsKPs3RS73sFr/vZq
           /Gys/YVPdza1NRBe/68jItaqRypxg6Gc3Nm2iThM9aRpxGLmdQ42yNioZbgRgLKXbF
           Cbh8Hu9ta/9V8GXXir2lUYnzM6Q/S0czV3LOJ35dDLqXMwAw110wugXnjCImLOtmZo
           hUu3+jys4dwBeyevSYmq0Ov9j2WxWSLjrZR937ijgSFSNjGfJz/6/ri8Q1K6VSZSWp
           XZT93LH+6cXyQ==
Received: from 83.5.150.21.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.150.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes.berg@intel.com>; 2 May 2025 21:44:07 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw,v2] iw: fix EHT capabilities on Big Endian platforms
Date: Fri,  2 May 2025 21:44:05 +0200
Message-Id: <20250502194405.3489240-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 2b1ff6474733ec445ba36c34ed366773
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [EcME]                               

IE fields are encoded in Little Endian and are not correctly
printed on Big Endian platforms.

Fixes: 5a71b722270c ("iw: Print local EHT capabilities")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/util.c b/util.c
index c6d5974..9403528 100644
--- a/util.c
+++ b/util.c
@@ -1538,22 +1538,31 @@ static void __print_eht_capa(int band,
 	unsigned int i;
 	const char *pre = indent ? "\t" : "";
 
-	#define PRINT_EHT_CAP(_var, _idx, _bit, _str) \
+	#define PRINT_EHT_MAC_CAP(_idx, _bit, _str) \
 	do { \
-		if (_var[_idx] & BIT(_bit)) \
+		if (mac_cap[_idx] & BIT(_bit)) \
 			printf("%s\t\t\t" _str "\n", pre); \
 	} while (0)
 
-	#define PRINT_EHT_CAP_MASK(_var, _idx, _shift, _mask, _str) \
+	#define PRINT_EHT_MAC_CAP_MASK(_idx, _shift, _mask, _str) \
 	do { \
-		if ((_var[_idx] >> _shift) & _mask) \
-			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
+		if ((mac_cap[_idx] >> _shift) & _mask) \
+			printf("%s\t\t\t" _str ": %d\n", pre, \
+			       (mac_cap[_idx] >> _shift) & _mask); \
+	} while (0)
+
+	#define PRINT_EHT_PHY_CAP(_idx, _bit, _str) \
+	do { \
+		if (le32toh(phy_cap[_idx]) & BIT(_bit)) \
+			printf("%s\t\t\t" _str "\n", pre); \
 	} while (0)
 
-	#define PRINT_EHT_MAC_CAP(...) PRINT_EHT_CAP(mac_cap, __VA_ARGS__)
-	#define PRINT_EHT_MAC_CAP_MASK(...) PRINT_EHT_CAP_MASK(mac_cap, __VA_ARGS__)
-	#define PRINT_EHT_PHY_CAP(...) PRINT_EHT_CAP(phy_cap, __VA_ARGS__)
-	#define PRINT_EHT_PHY_CAP_MASK(...) PRINT_EHT_CAP_MASK(phy_cap, __VA_ARGS__)
+	#define PRINT_EHT_PHY_CAP_MASK(_idx, _shift, _mask, _str) \
+	do { \
+		if ((le32toh(phy_cap[_idx]) >> _shift) & _mask) \
+			printf("%s\t\t\t" _str ": %d\n", pre, \
+			       (le32toh(phy_cap[_idx]) >> _shift) & _mask); \
+	} while (0)
 
 	printf("%s\t\tEHT MAC Capabilities (0x", pre);
 	for (i = 0; i < 2; i++)
@@ -1627,7 +1636,7 @@ static void __print_eht_capa(int band,
 	PRINT_EHT_PHY_CAP(2, 1, "Rx 4096-QAM In Wider Bandwidth DL OFDMA Supported");
 
 	if (!from_ap &&
-	    !(he_phy_cap[0] & ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8))) {
+	    !(le16toh(he_phy_cap[0]) & ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8))) {
 		static const char * const mcs[] = { "0-7", "8-9", "10-11", "12-13" };
 
 		printf("%s\t\tEHT-MCS Map (20 Mhz Non-AP STA) (0x", pre);
@@ -1649,8 +1658,9 @@ static void __print_eht_capa(int band,
 		 * If no Channel Width bits are set, but we are an AP, we use
 		 * this MCS logic also.
 		 */
-		if (he_phy_cap[0] & ((BIT(1) | BIT(2)) << 8) ||
-		    (from_ap && !(he_phy_cap[0] & ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8)))) {
+		if (le16toh(he_phy_cap[0]) & ((BIT(1) | BIT(2)) << 8) ||
+		    (from_ap && !(le16toh(he_phy_cap[0]) &
+		    ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8)))) {
 			printf("%s\t\tEHT-MCS Map (BW <= 80) (0x", pre);
 			for (i = 0; i < 3; i++)
 				printf("%02x", ((__u8 *)mcs_set)[i]);
@@ -1665,7 +1675,7 @@ static void __print_eht_capa(int band,
 		}
 		mcs_set += 3;
 
-		if (he_phy_cap[0] & (BIT(3) << 8)) {
+		if (le16toh(he_phy_cap[0]) & (BIT(3) << 8)) {
 			printf("%s\t\tEHT-MCS Map (BW = 160) (0x", pre);
 			for (i = 0; i < 3; i++)
 				printf("%02x", ((__u8 *)mcs_set)[i]);
@@ -1680,7 +1690,7 @@ static void __print_eht_capa(int band,
 		}
 
 		mcs_set += 3;
-		if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
+		if (band == NL80211_BAND_6GHZ && (le32toh(phy_cap[0]) & BIT(1))) {
 			printf("%s\t\tEHT-MCS Map (BW = 320) (0x", pre);
 			for (i = 0; i < 3; i++)
 				printf("%02x", ((__u8 *)mcs_set)[i]);
@@ -1695,7 +1705,7 @@ static void __print_eht_capa(int band,
 		}
 	}
 
-	if (ppet && ppet_len && (phy_cap[1] & BIT(11))) {
+	if (ppet && ppet_len && (le32toh(phy_cap[1]) & BIT(11))) {
 		printf("%s\t\tEHT PPE Thresholds ", pre);
 		for (i = 0; i < ppet_len; i++)
 			if (ppet[i])
-- 
2.39.5


