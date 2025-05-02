Return-Path: <linux-wireless+bounces-22360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A857AA7A8B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 22:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F583AB444
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324D91F4615;
	Fri,  2 May 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="CDSfpHGf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3E10A1F
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216271; cv=none; b=uW2nMeA/ng5ne9Fxc9fzQDC6MayM+R5+ooagDJA6TVdmfNnY8tNTJT78ngalj5xHpANhWnhr7Qpmqk8SkwV1qKDQ0crrfly+Olj3hxeF05jcP38GLN/l8cbVtkt0V7GDlvBzgHO5zIQ/TtW/8a2t/kxsKdQNM9UW8r4ckevUG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216271; c=relaxed/simple;
	bh=Ytm/GvlCXo1rzdBBm9nHFFC0YSOj7VcNOCaaHJVVRPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dp5lqCv3aFVKUdcykHdyVpHGCtQenXnX8NHXShiaL7O3kAanmZYHwZ58b2+BassIjqkoiwWIRtbgRtUgGDKKAPbHSjaeV/LI5mzxc6iEfm0reOuNv4gSkJBqKyym/wznWPawdmTR3rFkKPe+9KTIeQKOURYONpyqX1wbnc3lS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=CDSfpHGf; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 49005 invoked from network); 2 May 2025 22:04:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1746216265; bh=4uXnc6THj5050EedKYJrhkloNDi/wDIkoo7Dg956Prg=;
          h=From:To:Cc:Subject;
          b=CDSfpHGfaGKtlC/4IzyxCtgJ0uTMLbyNgLpPMEEf6pdEf0Tn2XmaGl8IL+wqfVqQD
           je4XRQ7g4HufICG1uhzuszg0fWIFkTGWBJaLYs8sTD4u5OCPE+3+72F4ZX4UePaYV6
           6WT/THtxfY7SjSL4DtXn7BGsHr23Cilcp6M8jvs3TLDO7V+C38Id8NOLjDMmE7ln35
           EcMW0bF4DF4ckbVX21AvyOxq9wZCvu3dWa4j7PotFJhNK2EjSFJ3ouTCcrLWRA2Bbu
           mLLZZzK+FvVy2pl97TDjh7cjNn/NhHtyAfZ6bnZ3NegS5vvXo9i+TSPOajf6MGjfDL
           4+IsVHnOENK7w==
Received: from 83.5.150.21.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.150.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes.berg@intel.com>; 2 May 2025 22:04:25 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw] util: rename hz to Hz vol 2
Date: Fri,  2 May 2025 22:04:24 +0200
Message-Id: <20250502200424.3492403-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 44d60f18ebb128d826032c567aa0246a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [wfO0]                               

In most places, the Hz unit is used. This commit changes
hz to Hz in other places.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util.c b/util.c
index c6d5974..1ebb19e 100644
--- a/util.c
+++ b/util.c
@@ -1630,7 +1630,7 @@ static void __print_eht_capa(int band,
 	    !(he_phy_cap[0] & ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8))) {
 		static const char * const mcs[] = { "0-7", "8-9", "10-11", "12-13" };
 
-		printf("%s\t\tEHT-MCS Map (20 Mhz Non-AP STA) (0x", pre);
+		printf("%s\t\tEHT-MCS Map (20 MHz Non-AP STA) (0x", pre);
 		for (i = 0; i < mcs_len; i++)
 			printf("%02x", ((__u8 *)mcs_set)[i]);
 		printf("):\n");
@@ -1644,8 +1644,8 @@ static void __print_eht_capa(int band,
 	} else {
 		static const char * const mcs[] = { "0-9", "10-11", "12-13"};
 
-		/* Bit 1 corresponds to 2.4Ghz 40Mhz support
-		 * Bit 2 corresponds to 5/6Ghz 40 and 80Mhz support
+		/* Bit 1 corresponds to 2.4GHz 40MHz support
+		 * Bit 2 corresponds to 5/6GHz 40 and 80MHz support
 		 * If no Channel Width bits are set, but we are an AP, we use
 		 * this MCS logic also.
 		 */
-- 
2.39.5


