Return-Path: <linux-wireless+bounces-13645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE269937D2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 22:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8798FB2359E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053AA1DE3DD;
	Mon,  7 Oct 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wyIsKlOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DED1DE3DE
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331210; cv=none; b=EzLrDDBoWYO8SiHoI6bkMalFU9GfV9Xe7xnhnqVJacft1JW5fPdb/5OEjZc2BWXIUwvjVziao+R5TzkQodDQtxz0JJbH84DP7+nP4wEzEeQKRA6GqIjyUnGere725PEN1xsw7QtxennJrbKC9Q1MgGMwaoWfnXoKPri8CPgFSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331210; c=relaxed/simple;
	bh=8t8wy9Mr2uMVO82QWv6BFsgu1Hq0m2O+Rs9chdwborI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQRA6FvjIzGWcbnypJ/dBqFbu3yEgm2DzEjxWFdzn7RE7HF5G+5SP60lidHjn1XmkbBr3gu7MfNjciFlEJ4U0bzFDs9DzM7+Vtfk5CBCoyerLnOoUTPTEKA1PJy6OGcQFYY+eaHGo7yFN+c203GQpld47mIhXhsrDGGM7o0BzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wyIsKlOM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=G7TLga9TAkQVflgjPREs1kTKkN4aYcfNzMzdLRTVXJk=; t=1728331208; x=1729540808; 
	b=wyIsKlOMAa72fBcp5eNg0g7VtW//tmHTp4B6bydocsUAwYPU+MaTqW88R+rKxQYHhif71WYHqtP
	l7mU7PwmpSPtLZ8grEu8He+ZEX0RfJyLlf0I/KkYK6LBpyMGNyBLYC8qJDxb2Pa2+/i3ZxkpiZSpy
	PHmTMFLD6MmQUeec9LwLitTVnqt2uf7Y0XpsNupRmkCsB8FFdWXA7iyrRdhUicbYUxcrcuH29VOc8
	erxXMPvvL91Rag3zpeo40QY/KeCx4yKwAgYtVUSbx1IHnPMltxG+0QKkoxN6CCPAvM0mM6qOZfJ6N
	bDU4RYwZQGHSoVmAJMRNBkXN5ObzUJ4D7Ifg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxttk-00000003WFA-3rNx;
	Mon, 07 Oct 2024 22:00:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wireless: wext: shorten struct iw_ioctl_description
Date: Mon,  7 Oct 2024 22:00:03 +0200
Message-ID: <20241007220003.309bd52fa763.I9a1229fa7f2be53d4f50e63671ed441d0968bb41@changeid>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need for "future" extensions in an internal
struct, and we don't need a u32 for flags, use just a
u8. Also remove the unused IW_DESCR_FLAG_WAIT flag.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/iw_handler.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index 804587b7592b..c9b46b996197 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -279,8 +279,6 @@
 #define IW_DESCR_FLAG_RESTRICT	0x0004	/* GET : request is ROOT only */
 				/* SET : Omit payload from generated iwevent */
 #define IW_DESCR_FLAG_NOMAX	0x0008	/* GET : no limit on request size */
-/* Driver level flags */
-#define IW_DESCR_FLAG_WAIT	0x0100	/* Wait for driver event */
 
 /****************************** TYPES ******************************/
 
@@ -373,11 +371,10 @@ struct iw_handler_def {
  */
 struct iw_ioctl_description {
 	__u8	header_type;		/* NULL, iw_point or other */
-	__u8	token_type;		/* Future */
+	__u8	flags;			/* Special handling of the request */
 	__u16	token_size;		/* Granularity of payload */
 	__u16	min_tokens;		/* Min acceptable token number */
 	__u16	max_tokens;		/* Max acceptable token number */
-	__u32	flags;			/* Special handling of the request */
 };
 
 /* Need to think of short header translation table. Later. */
-- 
2.46.2


