Return-Path: <linux-wireless+bounces-21163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED69AA7CB8E
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 20:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010DE188F1E0
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2331A9B53;
	Sat,  5 Apr 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="q7/Jvgi8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42019ADBA
	for <linux-wireless@vger.kernel.org>; Sat,  5 Apr 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743878903; cv=none; b=TfZBBMwYVbxtgUnnWWD81Qt964Pr1bpjmnaz9M+DLQQY36HU2gh6/6Bye8fk6jIK7onrnIHUUWkPav8BTd1VX/7ccZnDTHyyteE/t/N4MtaSTpJkv/YuZqX9cgFjXA2i+hTGvPQY+6Uv7/kaTNWSLTRVhdZRAfk0X2HgbX0s1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743878903; c=relaxed/simple;
	bh=nxiecPsmoFgWBEWbqtYIWuBltuSENEpmnmMMU0Henmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4d8tO/zW5iOLUoeR5aZ4T0n5rJaPIqxlHvAJTVUu8BO2UKlbWUuf09acpLOasj6dT4FbCuWDyngfR/ZsU2SGArA1+J9EC9Y0JNfeu0rs5de+Y9Nkg3UNMGKlHcS7c6H6DOJCe5e022YxvA1B7yPukMHrU4aajZB+8GVYH3AoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=q7/Jvgi8; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36638 invoked from network); 5 Apr 2025 20:48:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1743878898; bh=WuK/7uUTFYCOAJEY3KIz03StC1UqnJ+Dxx7t0VFtJU8=;
          h=From:To:Cc:Subject;
          b=q7/Jvgi8Y7Ezq1Z094NzCc82b2pKr9dn8A5p72Lnhb52AqkDpB8FnwdxR4OYbd956
           26/BivpEZ5yu7oeXYE8EQHGM/sDgjjdUA4QlYGDKcvUfw8jSJo7fSvWbnVukluJRAK
           gSDgvojikdfIM9MkDr82ZjIPS7Dt33VsU2SuzD2++wv3UMoILsp46i7MR33piCZpkU
           LW5u5JQUjHPUcPEOZHH1neNIW57E/xhxF4NtCwRRKiBynVi1tcS78eWoZz3HoxuF3F
           BaGQ4PLCStQvMpTSd34eMuqH1pvPfPVFp99FluKcbSru4U91vflfW/SXBYn7Bkp7Pb
           7qsgnZJ5wwMhQ==
Received: from 83.5.244.88.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.244.88])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 5 Apr 2025 20:48:17 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes@sipsolutions.net,
	ilan.peer@intel.com,
	christopher.a.wills@intel.com,
	slakkavalli@datto.com,
	john@phrozen.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw,v2 3/3] iw: fix EHT capabilities on Big Endian platforms
Date: Sat,  5 Apr 2025 20:48:07 +0200
Message-Id: <20250405184807.701728-4-olek2@wp.pl>
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
X-WP-MailID: e04155a1f1dd2da3e5f435d7b4bec152
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kaPE]                               

IE fields are encoded in Little Endian and are not correctly
printed on Big Endian platforms.

Fixes: 5a71b722270c ("iw: Print local EHT capabilities")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/util.c b/util.c
index 1870393..f105e07 100644
--- a/util.c
+++ b/util.c
@@ -1538,21 +1538,24 @@ static void __print_eht_capa(int band,
 	const char *pre = indent ? "\t" : "";
 	const char *mcs[] = { "0-7", "8-9", "10-11", "12-13"};
 
-	#define PRINT_EHT_CAP(_var, _idx, _bit, _str) \
+	#define PRINT_EHT_MAC_CAP(_idx, _bit, _str) \
 	do { \
-		if (_var[_idx] & BIT(_bit)) \
+		if (le32toh(mac_cap[_idx]) & BIT(_bit)) \
 			printf("%s\t\t\t" _str "\n", pre); \
 	} while (0)
 
-	#define PRINT_EHT_CAP_MASK(_var, _idx, _shift, _mask, _str) \
+	#define PRINT_EHT_PHY_CAP(_idx, _bit, _str) \
 	do { \
-		if ((_var[_idx] >> _shift) & _mask) \
-			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
+		if (phy_cap[_idx] & BIT(_bit)) \
+			printf("%s\t\t\t" _str "\n", pre); \
 	} while (0)
 
-	#define PRINT_EHT_MAC_CAP(...) PRINT_EHT_CAP(mac_cap, __VA_ARGS__)
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
@@ -1617,13 +1620,13 @@ static void __print_eht_capa(int band,
 		printf("%02x", ((__u8 *)mcs_set)[i]);
 	printf("):\n");
 
-	if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
+	if (!(le16toh(he_phy_cap[0]) & ((BIT(2) | BIT(3) | BIT(4)) << 8))) {
 		for (i = 0; i < 4; i++)
 			printf("%s\t\tEHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
 			       pre, mcs[i],
 			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
 	} else {
-		if (he_phy_cap[0] & (BIT(2) << 8)) {
+		if (le16toh(he_phy_cap[0]) & (BIT(2) << 8)) {
 			for (i = 0; i < 3; i++)
 				printf("%s\t\tEHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
 				       pre, mcs[i + 1],
@@ -1631,7 +1634,7 @@ static void __print_eht_capa(int band,
 		}
 		mcs_set += 3;
 
-		if (he_phy_cap[0] & (BIT(3) << 8)) {
+		if (le16toh(he_phy_cap[0]) & (BIT(3) << 8)) {
 			for (i = 0; i < 3; i++)
 				printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
 				       pre, mcs[i + 1],
@@ -1639,7 +1642,7 @@ static void __print_eht_capa(int band,
 		}
 
 		mcs_set += 3;
-		if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
+		if (band == NL80211_BAND_6GHZ && (le32toh(phy_cap[0]) & BIT(1))) {
 			for (i = 0; i < 3; i++)
 				printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
 				       pre, mcs[i + 1],
@@ -1647,7 +1650,7 @@ static void __print_eht_capa(int band,
 		}
 	}
 
-	if (ppet && ppet_len && (phy_cap[1] & BIT(11))) {
+	if (ppet && ppet_len && (le32toh(phy_cap[1]) & BIT(11))) {
 		printf("%s\t\tEHT PPE Thresholds ", pre);
 		for (i = 0; i < ppet_len; i++)
 			if (ppet[i])
-- 
2.39.5


