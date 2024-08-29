Return-Path: <linux-wireless+bounces-12208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7788964AEE
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6521C20FD4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F961AD3E2;
	Thu, 29 Aug 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZfsrnMM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C81A7062
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947407; cv=none; b=Swvr2QzUCyS6+ylXgJCalqeLs3iZU8zoV7PPHFMHMGaRTgvIyZXpLftsPv7/4mjFLpk6vo0zynV74GKJMfh6lf8Whl4dslLWaAPeUur4K8aJ+X1tkaKvhm9s9PyLgt0Ok5acZ2Ji820se1D85poAyU9NGGZlR3oC8YMk4EJMpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947407; c=relaxed/simple;
	bh=53YNKfgte+24/t/dorec3jtfFV/G2QTfF3vy/1JfTqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JHzu6LnpUoZiHsrpUMl58aK7p6nt7ugzjk7Gfq38cIqacpdtzj6RTpR7SFVemzqjODPqH65xsTx5M8x2cuRu0fx3Jvh4aaPyeOa1yCW4KIjTr2EVbG6LhWoUUJE/IHMryZ3b2L6EFYAcxSLhmCs7k/lTJufAVJWQSrnEW7mEwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZfsrnMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B0DC4CEC1;
	Thu, 29 Aug 2024 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947406;
	bh=53YNKfgte+24/t/dorec3jtfFV/G2QTfF3vy/1JfTqY=;
	h=From:Date:Subject:To:Cc:From;
	b=gZfsrnMMSOoehJATSLyJCjhydNwi3gygTQyzJ7C2IIsPwf96DTeoMRARA0wC2aQ4M
	 s4Q9zkvubVuN7mXKQkFMd3LTpXMQInVAavLTGCNZzIjqkiSv8RBH09QHdd/twhl7Ir
	 Ma4O2KEN8ydHJm5nf5r8X1lzK8k1D1Rg3ZmfivrseINh4SFtPL6Pzs+8wwk8Pg6W6n
	 aK36MdIPIuymMvO4jM/DMRivB9M2QvFEqe2LzILN1m62vA0FfyjGnQ8FH9/O6SZEHV
	 eeB9O4j6u+T0GVr0241YUVh48gECsT8aygc/+Ka8wFwtSJk4d6PeA9QK5vbcY83wbB
	 ICEop13fDWUPA==
From: Simon Horman <horms@kernel.org>
Date: Thu, 29 Aug 2024 17:03:23 +0100
Subject: [PATCH] wifi: cfg80211: wext: Correct spelling in iw_handler.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wifi-spell-v1-1-e0a8855482a9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMqb0GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3fLMtEzd4oLUnBxd4zRLE6Nkc1NzC0tzJaCGgqLUtMwKsGHRsbW
 1AP2MBKxcAAAA
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in iw_handler.h.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/iw_handler.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index b2cf243ebe44..f7f4c2a79b9e 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -23,7 +23,7 @@
  * to handle wireless statistics.
  *
  * The initial APIs served us well and has proven a reasonably good design.
- * However, there is a few shortcommings :
+ * However, there is a few shortcomings :
  *	o No events, everything is a request to the driver.
  *	o Large ioctl function in driver with gigantic switch statement
  *	  (i.e. spaghetti code).
@@ -38,13 +38,13 @@
  * -------------------------------
  * The new driver API is just a bunch of standard functions (handlers),
  * each handling a specific Wireless Extension. The driver just export
- * the list of handler it supports, and those will be called apropriately.
+ * the list of handler it supports, and those will be called appropriately.
  *
  * I tried to keep the main advantage of the previous API (simplicity,
  * efficiency and light weight), and also I provide a good dose of backward
  * compatibility (most structures are the same, driver can use both API
  * simultaneously, ...).
- * Hopefully, I've also addressed the shortcomming of the initial API.
+ * Hopefully, I've also addressed the shortcoming of the initial API.
  *
  * The advantage of the new API are :
  *	o Handling of Extensions in driver broken in small contained functions
@@ -84,7 +84,7 @@
 
 /* ---------------------- THE IMPLEMENTATION ---------------------- */
 /*
- * Some of the choice I've made are pretty controversials. Defining an
+ * Some of the choice I've made are pretty controversial. Defining an
  * API is very much weighting compromises. This goes into some of the
  * details and the thinking behind the implementation.
  *
@@ -140,7 +140,7 @@
  * example to distinguish setting max rate and basic rate), I would
  * break the prototype. Using iwreq_data is more flexible.
  * 3) Also, the above form is not generic (see above).
- * 4) I don't expect driver developper using the wrong field of the
+ * 4) I don't expect driver developer using the wrong field of the
  * union (Doh !), so static typechecking doesn't add much value.
  * 5) Lastly, you can skip the union by doing :
  *	static int mydriver_ioctl_setrate(struct net_device *dev,
@@ -459,7 +459,7 @@ int iw_handler_get_thrspy(struct net_device *dev, struct iw_request_info *info,
 void wireless_spy_update(struct net_device *dev, unsigned char *address,
 			 struct iw_quality *wstats);
 
-/************************* INLINE FUNTIONS *************************/
+/************************* INLINE FUNCTIONS *************************/
 /*
  * Function that are so simple that it's more efficient inlining them
  */


