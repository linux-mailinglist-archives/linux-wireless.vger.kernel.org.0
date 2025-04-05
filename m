Return-Path: <linux-wireless+bounces-21161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE194A7CB8B
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4E317419C
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Apr 2025 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8C19F422;
	Sat,  5 Apr 2025 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="IY4eatyj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18417A303
	for <linux-wireless@vger.kernel.org>; Sat,  5 Apr 2025 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743878901; cv=none; b=tmGNrPoJbWEgMumEl1aeVJHi82sge7kdk0zVTWbnzENktF6pbWLalcUGsAte0BnOnIRN9M1eY34Hcw+NJLH8TvcAEkv3qqZFXPHjS8qgJRXgH9W9LiGAc1FBoJz/bHZJCXKo3JDo52ahsh6DBb7b1pBXsjy0V+Sl78SVkwHYS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743878901; c=relaxed/simple;
	bh=r7Z9lOOkSxpN+ucW+Gp2u+rGkC79BlG1EH70EKPgKrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8n39Ib1RO4wzLatH+3mz30TPjOsOUYrZ0mtP/xz56xdN7u/k0p8zRqC0Qp0uJMrqBlzRYyyKi9qzcG72QustOyG5OwmJM08F6roKlE36CTBq9ElBtUtPq3mYCKgHmh3H0OUO1D0NNpHPDmLLLS6rxHX5EUKRrXdoWB7B8QUz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=IY4eatyj; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36002 invoked from network); 5 Apr 2025 20:48:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1743878896; bh=8900mW7m6CxNPXhte/uesbW94QRwJGoXjpY9qylqeaI=;
          h=From:To:Cc:Subject;
          b=IY4eatyjNNyH/kBUrEcFC7/EebYKxVmHw34qA0CtJq6a3YAQ9723UNrXqBgrB9zui
           DHxv26QOxMo+KYgyRkk+CUUKfsPY3fTnbftf7FKc9WQdmM6odg/eUXmD5k+5F8ejVS
           U1ZdflSAB7gWBIGrPXz2OaqoPwyZJkSVvnNgnpDoUrvnJ/Yc4hHtrh0ARdGgzMhzBl
           7KPo38/c8AFnUHDDCbxb5TZEGcu2T5EeMFC1lTCByDsC4L6KJkl4pBLWvvms9lpRBK
           a6ZiRNl7pC+KUokLAVRIxs6ipdapVWEBXtKicylbgIra8GEPM7ZW7RGlc/2XWANSqE
           bgh04St8JZCMA==
Received: from 83.5.244.88.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.244.88])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 5 Apr 2025 20:48:16 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes@sipsolutions.net,
	ilan.peer@intel.com,
	christopher.a.wills@intel.com,
	slakkavalli@datto.com,
	john@phrozen.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw,v2 2/3] iw: fix HE operation on Big Endian platforms
Date: Sat,  5 Apr 2025 20:48:06 +0200
Message-Id: <20250405184807.701728-3-olek2@wp.pl>
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
X-WP-MailID: 1fb8fe2d7877ab1a9e4aa322aa28f15f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [wbKh]                               

IE fields are encoded in Little Endian and are not correctly
printed on Big Endian platforms.

Fixes: 422419e06d55 ("scan: Add printing of HE Operation Element")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util.c b/util.c
index 6502788..1870393 100644
--- a/util.c
+++ b/util.c
@@ -1755,7 +1755,7 @@ void print_he_operation(const uint8_t *ie, int len)
 {
 	uint8_t oper_parameters[3] = {ie[0], ie[1], ie[2] };
 	uint8_t bss_color = ie[3];
-	uint16_t nss_mcs_set = *(uint16_t*)(&ie[4]);
+	uint16_t nss_mcs_set = le16toh(*(uint16_t *)(&ie[4]));
 	uint8_t vht_oper_present = oper_parameters[1] & 0x40;
 	uint8_t co_hosted_bss_present = oper_parameters[1] & 0x80;
 	uint8_t uhb_operation_info_present = oper_parameters[2] & 0x02;
@@ -1768,7 +1768,7 @@ void print_he_operation(const uint8_t *ie, int len)
 		printf("\t\t\tTWT Required\n");
 
 	printf("\t\t\tTXOP Duration RTS Threshold: %hu\n",
-	       (*(uint16_t*)(oper_parameters)) >> 4 & 0x03ff);
+	       le16toh((*(uint16_t *)(oper_parameters))) >> 4 & 0x03ff);
 	if (oper_parameters[1] & 0x40)
 		printf("\t\t\tVHT Operation Information Present\n");
 
-- 
2.39.5


