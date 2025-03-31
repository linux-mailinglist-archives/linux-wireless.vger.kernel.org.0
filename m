Return-Path: <linux-wireless+bounces-21005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0BA76DAE
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 21:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E72A18899A2
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1F215F5D;
	Mon, 31 Mar 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="e3tbuOof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78D214A90
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450743; cv=none; b=tTkgoH9a02Mn7kyHGPm5xaY6GkiwLdmDklm5WNi73m1vtRxBP9qKlIk7Jd3Eo1pg/DJk+02dz3VQyQ2LOUkHf8va+LDqJ9PVAjj8vgc2a6FeWix3li7colIgV1ewXIy7YT5Scf+Y43Ii/I3i2OMfeggrsbvLG0pjEBhqvYb9tzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450743; c=relaxed/simple;
	bh=DRUU2pNYeJJJUzwnkyf6OahAXjw+xb6h0x9gKA8kw88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dpWhjTNmOrltr/l1EsoLCkDSWqHSB4aaSsT5xAvEf7/J5SW+2obwKjY5HkcN/SGcC926oZCdvgN+DbfFNgNmLk2CVzslpRLrMYeKge/ClSrF6ERyXXBNTNBzFoKyDBWq76fv3R3M8NDROTFGLa/5k5Gh+fdgZ/lXhXv1+DRfDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=e3tbuOof; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 5709 invoked from network); 31 Mar 2025 21:45:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1743450338; bh=bzYp1a9JujIir3+dFelCBWZSQnKsjs5IU9fJyIRJ3as=;
          h=From:To:Cc:Subject;
          b=e3tbuOofBgJ8k2hIqfI7eSLadYP+mZNlxIpg51vzWcCkRHWQRIG08Rkh9fpx9xxRI
           2fE1Y9LZJ4IvG1ZVCtldfJ28NAaTnVC0vDUzTsXpsiwzch/c+zf0lrXN7rjo/LQcc8
           gT8rh07YVJH+TPUoUH7KhOzR9Es//zJaZbQBqpGvgM+nIg3b20XWfRVYfkMSd3URCu
           OjNPKXYwlwa4exAWX7hkq9R0FEj/HLrOpYgoOT4YMS1l8rt8+Y20RcRgYla1+m+++A
           zpwSsIfSFKSeq1hvC0WvW9n0X1GvTilS8F0X9VuxzLMMvpvHR4QWIJ3ZBdOyt51/PG
           4rKDRWW8GieJQ==
Received: from 83.5.244.88.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.244.88])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 31 Mar 2025 21:45:38 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw 1/2] iw: fix HE capabilities on Big Endian platforms
Date: Mon, 31 Mar 2025 21:45:16 +0200
Message-Id: <20250331194517.4840-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 8427da6a13d57a6c7f0a6ee75ae056f8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [wSNU]                               

IE fields are encoded in Little Endian and are not correctly
printed on Big Endian platforms.

Fixes: c741be9f6ca344 ("iw: print HE capabilities")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/util.c b/util.c
index dc84886..04e8089 100644
--- a/util.c
+++ b/util.c
@@ -1262,14 +1262,14 @@ static void __print_he_capa(const __u16 *mac_cap,
 
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
+			printf("%s\t\t\t" _str ": %d\n", pre, (le16toh(_var[_idx]) >> _shift) & _mask); \
 	} while (0)
 
 	#define PRINT_HE_MAC_CAP(...) PRINT_HE_CAP(mac_cap, __VA_ARGS__)
@@ -1280,7 +1280,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 
 	printf("%s\t\tHE MAC Capabilities (0x", pre);
 	for (i = 0; i < 3; i++)
-		printf("%04x", mac_cap[i]);
+		printf("%04x", le16toh(mac_cap[i]));
 	printf("):\n");
 
 	PRINT_HE_MAC_CAP(0, 0, "+HTC HE Supported");
@@ -1394,18 +1394,18 @@ static void __print_he_capa(const __u16 *mac_cap,
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
@@ -1428,7 +1428,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 			ppet_len = 0;
 	}
 
-	if (ppet_len && (phy_cap[3] & BIT(15))) {
+	if (ppet_len && (le16toh(phy_cap[3]) & BIT(15))) {
 		printf("%s\t\tPPE Threshold ", pre);
 		for (i = 0; i < ppet_len; i++)
 			if (ppet[i])
-- 
2.39.5


