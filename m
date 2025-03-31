Return-Path: <linux-wireless+bounces-21006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5836FA76E8A
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 22:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3767A4693
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 20:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549B21ADD4;
	Mon, 31 Mar 2025 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="oh0ryBj3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2A21ABCF
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451949; cv=none; b=OKUzNmm4YPthJg5cilnTbQipxSxH6ywWI/Hwcuus3YcIY4wpvMNqsWZsVwOvrWufBLULxwVDtWHAQAu+/N9+42T598a8XaWz4xTqaz2KP5YLWaX8nyopGFQk0cwvGig0442Z0zJU/AJrzS0dPtsI/9GUHsb4O6iWJEf1RJu3RpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451949; c=relaxed/simple;
	bh=r+0mJPkQml/7o0+Cf4h5xg6fkGFziWm1S87wBIG7mAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qpni+j/dKnDlh3xOZwag5htUpD6Yq74LqFUp2nLcsuT47cDelaJv5Tjgm0nSy/hyHrd9rv5iby7O16G5eQ0ftlfUeRPJ1GCenZn74a9peKE9H84SXma160tUAhrzkerd4N0iguVpBT+HIfX+3InZRJ2DdoW7xY4ARSARur7sWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=oh0ryBj3; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 9173 invoked from network); 31 Mar 2025 21:45:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1743450342; bh=zy3iRFVcMUECf6m0bESJWROY0fRqSakPfJFQnm7jWmc=;
          h=From:To:Cc:Subject;
          b=oh0ryBj3pkxoP3+mWC16mkZSuC6n6iDHb3yulCcghxcezUv6owoYpyTNkvp+DRzto
           LHzQA3IHojra1M07af4zkkwu22ZXjV9tbRqxrHWgeP+Va5LY6vQzkcp8tPhlKQc0ny
           cxURwfdZxgUyLxCvmg5hlwvMNwFyNovdMHFtdQYzqAt2hbPWtih2ZAGYyz+DyyZb/7
           3eB02d9lM0oLhQZLXoBYyEHrMTOdaXc1QmUap8APomA0r4Zf7BmtippcZ6uAVm4+4F
           j75vVwi0Hj/BNAgfRCniEgrrhJ/pNLSbvn9lj5MzJgqSOx5XCqR8b8oQvWFxPcau3Q
           zRCq+OQ9BIK4g==
Received: from 83.5.244.88.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.244.88])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 31 Mar 2025 21:45:42 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw 2/2] iw: fix HE operation on Big Endian platforms
Date: Mon, 31 Mar 2025 21:45:17 +0200
Message-Id: <20250331194517.4840-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331194517.4840-1-olek2@wp.pl>
References: <20250331194517.4840-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 4a48a5eb39774ccac4b77b1e627e709d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [wZIB]                               

IE fields are encoded in Little Endian and are not correctly
printed on Big Endian platforms.

Fixes: 422419e06d55a7 ("scan: Add printing of HE Operation Element")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util.c b/util.c
index 04e8089..73ca500 100644
--- a/util.c
+++ b/util.c
@@ -1754,7 +1754,7 @@ void print_he_operation(const uint8_t *ie, int len)
 {
 	uint8_t oper_parameters[3] = {ie[0], ie[1], ie[2] };
 	uint8_t bss_color = ie[3];
-	uint16_t nss_mcs_set = *(uint16_t*)(&ie[4]);
+	uint16_t nss_mcs_set = le16toh(*(uint16_t*)(&ie[4]));
 	uint8_t vht_oper_present = oper_parameters[1] & 0x40;
 	uint8_t co_hosted_bss_present = oper_parameters[1] & 0x80;
 	uint8_t uhb_operation_info_present = oper_parameters[2] & 0x02;
@@ -1767,7 +1767,7 @@ void print_he_operation(const uint8_t *ie, int len)
 		printf("\t\t\tTWT Required\n");
 
 	printf("\t\t\tTXOP Duration RTS Threshold: %hu\n",
-	       (*(uint16_t*)(oper_parameters)) >> 4 & 0x03ff);
+	       le16toh((*(uint16_t*)(oper_parameters))) >> 4 & 0x03ff);
 	if (oper_parameters[1] & 0x40)
 		printf("\t\t\tVHT Operation Information Present\n");
 
-- 
2.39.5


