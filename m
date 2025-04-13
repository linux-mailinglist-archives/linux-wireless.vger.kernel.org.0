Return-Path: <linux-wireless+bounces-21475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF0A871E2
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE843B9B93
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Apr 2025 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9761A3161;
	Sun, 13 Apr 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ha97VOjR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E3D984
	for <linux-wireless@vger.kernel.org>; Sun, 13 Apr 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744544249; cv=none; b=EMe0PLxVQdQiYRPyKmXPxXvhyRm87jm+8xz6mDu0EvvrzPcKYSfhI/ha3EvTSHMPdX5TQLUDs5fwlStPDvEuxNaf3HLu5+pxQYdvGogqUdOgxNbLnPvsSgUBlgdVKpIjYjvS9Oi0oboSJLqMuWmjj7Uu2Sa2BZsRoZSd8XzPkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744544249; c=relaxed/simple;
	bh=uR9BO48fn9wwixojAfz4H5Z6KbqgCsgKLx3T1aE6KF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NNI2BPn2zHd18TPw+n59cF024Qs6rnTkhu5eDQqP5YosaTm/nEpe2PcZ0tLlQb0WA+STmTpCArLBf2SnIb0zZEva6w2L+Ec7VabySCKylCCxST/CYqNxlUz80riNAZiZWJsNIXMg/j2fPgcqOIBGRduVqjWWgxUmTJOOC7yhDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ha97VOjR; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 12767 invoked from network); 13 Apr 2025 13:37:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1744544242; bh=o/eQAucZuZseFJJR/uB56HK/m9TTLIl+jqZ6TJBXMEA=;
          h=From:To:Cc:Subject;
          b=ha97VOjR/rRws8tmUU6bE6FWXnEV0r1tGHG5DzRthblEfNQuQmFxsWwK88xV4xiS4
           Knznvzfw3V21AwIfMeYon6owRIUEheDqmEwiRM+PMpZdpEH9PvbvSxqyZEhvXU39hF
           IgEKtt/3FJmQzmOY8vnpKXVK2HKkOSbCdAKVAIVnuvTvoyXDHgW7NW6tqEKD1Zkh43
           vlj/HXvosZfRF5+WwybKHhW4Q8k/2K6I/f+kFOSFwEFWw/ThBuaJgPLNixZ9Sg2xse
           14igFBeorlNa+uzbDiPINVutXnfa4d8tpPwONcHasCBJN/PmjE2I+YIujztxzvjIpr
           Nqy3S9ixQndOQ==
Received: from 83.24.142.208.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.24.142.208])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 13 Apr 2025 13:37:22 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw] util: rename hz to Hz
Date: Sun, 13 Apr 2025 13:36:53 +0200
Message-Id: <20250413113653.29050-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: d35eba65a50ed6ca4d4936ebbc53e0b1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MUP0]                               

In most places, the Hz unit is used. This commit changes
hz to Hz in other places.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/util.c b/util.c
index dc84886..cc48571 100644
--- a/util.c
+++ b/util.c
@@ -1192,11 +1192,11 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 		case 2: printf("160 MHz, 80+80 MHz\n"); break;
 		}
 	} else {
-		print_nss_ratio("20Mhz", false, nss_tbl->bw_20);
-		print_nss_ratio("40Mhz", false, nss_tbl->bw_40);
-		print_nss_ratio("80Mhz", false, nss_tbl->bw_80);
-		print_nss_ratio("160Mhz", false, nss_tbl->bw_160);
-		print_nss_ratio("80+80Mhz", false, nss_tbl->bw_80_80);
+		print_nss_ratio("20MHz", false, nss_tbl->bw_20);
+		print_nss_ratio("40MHz", false, nss_tbl->bw_40);
+		print_nss_ratio("80MHz", false, nss_tbl->bw_80);
+		print_nss_ratio("160MHz", false, nss_tbl->bw_160);
+		print_nss_ratio("80+80MHz", false, nss_tbl->bw_80_80);
 		printf("\n");
 	}
 
@@ -1351,11 +1351,11 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_PHY_CAP(2, 7, "SU Beamformer");
 	PRINT_HE_PHY_CAP(2, 8, "SU Beamformee");
 	PRINT_HE_PHY_CAP(2, 9, "MU Beamformer");
-	PRINT_HE_PHY_CAP_MASK(2, 10, 0x7, "Beamformee STS <= 80Mhz");
-	PRINT_HE_PHY_CAP_MASK(2, 13, 0x7, "Beamformee STS > 80Mhz");
+	PRINT_HE_PHY_CAP_MASK(2, 10, 0x7, "Beamformee STS <= 80MHz");
+	PRINT_HE_PHY_CAP_MASK(2, 13, 0x7, "Beamformee STS > 80MHz");
 
-	PRINT_HE_PHY_CAP_MASK(3, 0, 0x7, "Sounding Dimensions <= 80Mhz");
-	PRINT_HE_PHY_CAP_MASK(3, 3, 0x7, "Sounding Dimensions > 80Mhz");
+	PRINT_HE_PHY_CAP_MASK(3, 0, 0x7, "Sounding Dimensions <= 80MHz");
+	PRINT_HE_PHY_CAP_MASK(3, 3, 0x7, "Sounding Dimensions > 80MHz");
 	PRINT_HE_PHY_CAP(3, 6, "Ng = 16 SU Feedback");
 	PRINT_HE_PHY_CAP(3, 7, "Ng = 16 MU Feedback");
 	PRINT_HE_PHY_CAP(3, 8, "Codebook Size SU Feedback");
@@ -1828,7 +1828,7 @@ void print_he_operation(const uint8_t *ie, int len)
 		} else {
 			const uint8_t control = ie[offset + 1];
 
-			printf("\t\t6 Ghz Operation Information: 0x");
+			printf("\t\t6 GHz Operation Information: 0x");
 			for (uint8_t i = 0; i < 5; i++)
 				printf("%02x", ie[offset + i]);
 
-- 
2.39.5


