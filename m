Return-Path: <linux-wireless+bounces-12373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904539696EA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5891C23887
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B511D67AC;
	Tue,  3 Sep 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a31UbAi2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079045003
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351711; cv=none; b=fJArxgtr3oRcZF1M508VRX+TyunkJxlTF6bXkEuMjGAOl1T/W91hZRxrxqjWg2ewkt+c/9R04d31byHO/PC4OLn8GtM3kw9HbO7zeeLCMHcaq+xf1hR8ECBFGfzeXMfXZPS45PAUfBUtYZoYt5EsHOZQbWPu5gGa01qPquL9cuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351711; c=relaxed/simple;
	bh=+2Ji8GP7OuPchjEcpgO2dlCj5S2zBkVC9JC/brf2ECM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GNKWAjbGR7yrvOfUJmrXZyge1t+7kxNp1LLv4Ue3gqonnCkJyJGwBnsbk+V/7faNiBTtGVTOvZFreUmL3TafwMdnoPuA3U71TzN8yafJpncE8igBZVmXXZeBt4lQ6WRh3sAMV1BBqc1J/pPUezzuAvHwD62moyhX99igpPGcpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a31UbAi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD73C4CEC4;
	Tue,  3 Sep 2024 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725351711;
	bh=+2Ji8GP7OuPchjEcpgO2dlCj5S2zBkVC9JC/brf2ECM=;
	h=From:Date:Subject:To:Cc:From;
	b=a31UbAi2QuSnQufkPY9pFTGvi9FPqKGdne4/WZPZ9D26nctkUn+1Yah0BT/9U/Ytp
	 9lL7SXugpzXZldfWCVSwyN7FS8RhQuK9j2koTEakr9JR+derywZemfsMrsuCt8Rbf4
	 lmhllnARjwmAvzDShbBUOA6KMTF/J+H/gElPvVHiYM6AzsWTA9gAkn/hwVpy/j90qt
	 rCSVHiUGY5lFBYpD8HJyyO9SLofDifDZ0zV04Tw3UlysPS/wDax2bwAioh50R3Q/M6
	 PetJUgs+B6WjLfQVp9ws7/PDlbmbScEUwQl+ibkfWUqMd9L+pdvnwKDFgysOKedlvv
	 siLS+n/KEs9uw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 03 Sep 2024 09:21:44 +0100
Subject: [PATCH v2] wifi: cfg80211: wext: Update spelling and grammar
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-wifi-spell-v2-1-bfcf7062face@kernel.org>
X-B4-Tracking: v=1; b=H4sIABfH1mYC/23MQQ6CMBCF4auQWTsGRhpaV9zDsGhwChMJkKlBD
 endraxd/i953w6RVTjCtdhBeZMoy5yDTgX0o58HRrnnBiqpLi05fEkQjCtPE16Cq6lvTGNdA/m
 wKgd5H9ityz1KfC76Oeyt+q1/ma3CCrn01hpTW/KufbDOPJ0XHaBLKX0Bb18eT6UAAAA=
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in iw_handler.h.
As reported by codespell.

Also, while the "few shortcomings" line is being updated,
correct it's grammar.

Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Also correct grammar of "few shortcomings" line (Johannes)
- Link to v1: https://lore.kernel.org/r/20240829-wifi-spell-v1-1-e0a8855482a9@kernel.org
---
 include/net/iw_handler.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index b2cf243ebe44..7af1082ea9a0 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -23,7 +23,7 @@
  * to handle wireless statistics.
  *
  * The initial APIs served us well and has proven a reasonably good design.
- * However, there is a few shortcommings :
+ * However, there are a few shortcomings :
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


