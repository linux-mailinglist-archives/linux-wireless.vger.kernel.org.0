Return-Path: <linux-wireless+bounces-21164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB3AA7CB8F
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 20:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898F1188ED74
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727501AA795;
	Sat,  5 Apr 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="EkhOm7eb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F01A3168
	for <linux-wireless@vger.kernel.org>; Sat,  5 Apr 2025 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743878903; cv=none; b=RhmrlVYGvK4Zn3v/tCgv163sBVsv1hYhKZOvlpS5yfQlRvTwb5HbhKQWaK12xTziiw5fpAnK8qjmZvTa3NlYj72HjQRoKeD+Veff81TzoAHCgHUPursmOuX9xkGyX8bp3iOLc4SEo6nqH3ONWHhADZ8b1AbAm0uuGG723ULBubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743878903; c=relaxed/simple;
	bh=Aw0Fjl2LGfjmnj6jsCLXEfIc+aXrL/Jx39Jr17fsb1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gF5jQpTpVL1UDkclsrKqPDWOaaKeGeMPbYy6i4LwgNkaU8EoPQZRZAl/zaeF2hcpXCs8AOGolbqCMsuwuxc8wismT1wOgDV5gGoFez7+xiHBZltka8NKfVnWuZtKLw+uDK2+jJduU3rJtOC667m+G6SaA/H6ZBqxnPtuY/giuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=EkhOm7eb; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 35058 invoked from network); 5 Apr 2025 20:48:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1743878894; bh=/dtxDq+GKagSWsFC89cjsqL1xKgQwJW78+dbI6wLr5w=;
          h=From:To:Cc:Subject;
          b=EkhOm7ebbVZhmAgH8ueYuXTSFMmi6OsDxMKf/ZDYHMtelwqE+JerbeU9A0f8BGQUQ
           S5Y2DPahbGW9v1tgvrwMlDzngNH70RWpUL+vI/P99FrO+6vt/Pj0A0EuGR37k/7WRV
           8EehL/hsAD4wnYIFAWhrF26N2Bzejyzu1bQJG7S9ztdDUatcgG8HwMrcgOQQaPbQZX
           cbpz5CI19C6fspHw8DggelehGMcQvkyFpl8aVV8sojV3w456S2RV6LkszUH057UFsl
           jJ3HpbzkMjG+ekobrSuAdZrwANwN2gBLiabQ09HlHyRgVetDkEXY05uu2VyPanYq8i
           PcVthNMCc1EEQ==
Received: from 83.5.244.88.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.244.88])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 5 Apr 2025 20:48:13 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes@sipsolutions.net,
	ilan.peer@intel.com,
	christopher.a.wills@intel.com,
	slakkavalli@datto.com,
	john@phrozen.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw,v2 1/3] iw: fix HE capabilities on Big Endian platforms
Date: Sat,  5 Apr 2025 20:48:05 +0200
Message-Id: <20250405184807.701728-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250405184807.701728-1-olek2@wp.pl>
References: <20250405184807.701728-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 14c5875161ffd2af919c11b87cd50322
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wRPk]                               

IE fields are encoded in Little Endian and are not correctly
printed on Big Endian platforms.

Fixes: c741be9f6ca3 ("iw: print HE capabilities")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/util.c b/util.c
index dc84886..6502788 100644
--- a/util.c
+++ b/util.c
@@ -1262,14 +1262,15 @@ static void __print_he_capa(const __u16 *mac_cap,
 
 	#define PRINT_HE_CAP(_var, _idx, _bit, _str) \
 	do { \
-		if (_var[_idx] & BIT(_bit)) \
+		if (le16toh(_var[_idx]) & BIT(_bit)) \
 			printf("%s\t\t\t" _str "\n", pre); \
 	} while (0)
 
 	#define PRINT_HE_CAP_MASK(_var, _idx, _shift, _mask, _str) \
 	do { \
-		if ((_var[_idx] >> _shift) & _mask) \
-			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
+		if ((le16toh(_var[_idx]) >> _shift) & _mask) \
+			printf("%s\t\t\t" _str ": %d\n", pre, \
+			       (le16toh(_var[_idx]) >> _shift) & _mask); \
 	} while (0)
 
 	#define PRINT_HE_MAC_CAP(...) PRINT_HE_CAP(mac_cap, __VA_ARGS__)
@@ -1280,7 +1281,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 
 	printf("%s\t\tHE MAC Capabilities (0x", pre);
 	for (i = 0; i < 3; i++)
-		printf("%04x", mac_cap[i]);
+		printf("%04x", le16toh(mac_cap[i]));
 	printf("):\n");
 
 	PRINT_HE_MAC_CAP(0, 0, "+HTC HE Supported");
@@ -1394,18 +1395,18 @@ static void __print_he_capa(const __u16 *mac_cap,
 		char *bw[] = { "<= 80", "160", "80+80" };
 		int j;
 
-		if ((phy_cap[0] & (phy_cap_support[i] << 8)) == 0)
+		if ((le16toh(phy_cap[0]) & (phy_cap_support[i] << 8)) == 0)
 			continue;
 
 		/* Supports more, but overflow? Abort. */
-		if ((i * 2 + 2) * sizeof(mcs_set[0]) >= mcs_len)
+		if ((i * 2 + 2) * sizeof(le16toh(mcs_set[0])) >= mcs_len)
 			return;
 
 		for (j = 0; j < 2; j++) {
 			int k;
 			printf("%s\t\tHE %s MCS and NSS set %s MHz\n", pre, j ? "TX" : "RX", bw[i]);
 			for (k = 0; k < 8; k++) {
-				__u16 mcs = mcs_set[(i * 2) + j];
+				__u16 mcs = le16toh(mcs_set[(i * 2) + j]);
 				mcs >>= k * 2;
 				mcs &= 0x3;
 				printf("%s\t\t\t%d streams: ", pre, k + 1);
@@ -1428,7 +1429,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 			ppet_len = 0;
 	}
 
-	if (ppet_len && (phy_cap[3] & BIT(15))) {
+	if (ppet_len && (le16toh(phy_cap[3]) & BIT(15))) {
 		printf("%s\t\tPPE Threshold ", pre);
 		for (i = 0; i < ppet_len; i++)
 			if (ppet[i])
-- 
2.39.5


