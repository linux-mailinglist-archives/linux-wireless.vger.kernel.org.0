Return-Path: <linux-wireless+bounces-13634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3FE99362F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602071C23B44
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F01DE2A1;
	Mon,  7 Oct 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eR5i0dVS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD71DDC3A;
	Mon,  7 Oct 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325638; cv=none; b=SGuOUi5lgbz5tBz55Ysz4JQbDDmUjlJswj65f0iU7xuykFWXNc4aJinF95H3Mtmgn5LomCzsgSLgsZu2dpPTOkcSMQVB5CNr3QjPTap00MoacF4mZgdKFpjRs5vy//xSPEZ84n+lQGMSB9K20wgaStTpll6SutmYYYkQSPOscuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325638; c=relaxed/simple;
	bh=vOS3CNpInEAWidrCYi/+mZ0zBIlulId+pqKY59+tv6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFd5hougLewULsjRkGeCzZ37EJ1K90M8gQcUmk5tNGOd2LGmXDjS+GFSMX5f41Us4j0krJV8MdWCEu9EOmQR9A0cmcU3a120D9A3at3KH/xBUF/4MMBoTVH38zlnAWt5QsWTzNZV3rNNwN3fE615YDwEvNtegQuJNaJaBhYACqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eR5i0dVS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W6RyVJ9jW7ViTKosrMxL/e7Imn79jNwRFuDlinlgUI8=;
	t=1728325637; x=1729535237; b=eR5i0dVSGFzRX2XQmzq1o0P8IqGY1wV6lfaVtbev561uaiB
	wCWuYB281byL11A5J2xbr8WIYkLc9grvi0w3aWcgwNol3OukCeAVPkpkiaVuNFtFDAbKp3KwZnG9U
	FxDsQ2Q73XhNCdPUdZQY2DfTmd+CaRNw4s77VejSKfe/GeNbbiUo1TUytrn2wXSpxFHOLkwr9JYEh
	pGBKU5Hki+GVw9w1NfzPMEPMPxVZ4xnCTZW+KH+1OuQxi0s0+7R2cRS0pe8DE1daySDI/xd5Jt7d6
	Ewx5aHIpbHUtoirEOLciszh/iCFO34ySqOSgSWLHr1tDjceo+GD9SHZAYhGRoVSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsRu-00000003U6n-1ZkE;
	Mon, 07 Oct 2024 20:27:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 6/6] staging: don't recommend using lib80211
Date: Mon,  7 Oct 2024 20:26:56 +0200
Message-ID: <20241007202707.87481ddcfc00.I2cfb9940807e9c5017a052efcd3d1f2b6dc15fb1@changeid>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007182706.66888-8-johannes@sipsolutions.net>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

No longer document drivers should switch to lib80211,
they really should never have done that. While at it,
also remove the recommendation to use cfg80211, if it
switches to mac80211 then it implicitly uses cfg80211
but doesn't need to do anything about that, normally.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/staging/ks7010/TODO    | 2 --
 drivers/staging/rtl8712/TODO   | 1 -
 drivers/staging/rtl8723bs/TODO | 1 -
 drivers/staging/vt6655/TODO    | 1 -
 drivers/staging/vt6656/TODO    | 1 -
 5 files changed, 6 deletions(-)

diff --git a/drivers/staging/ks7010/TODO b/drivers/staging/ks7010/TODO
index 80c97543b977..8ad05b6e3947 100644
--- a/drivers/staging/ks7010/TODO
+++ b/drivers/staging/ks7010/TODO
@@ -27,9 +27,7 @@ Now the TODOs:
 - fix the 'card removal' event when card is inserted when booting
 - check what other upstream wireless mechanisms can be used instead of the
   custom ones here
-- Switch to use LIB80211.
 - Switch to use MAC80211.
-- Switch to use CFG80211.
 
 Please send any patches to:
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/drivers/staging/rtl8712/TODO b/drivers/staging/rtl8712/TODO
index 847c8c41f4f7..5aed36efa7cb 100644
--- a/drivers/staging/rtl8712/TODO
+++ b/drivers/staging/rtl8712/TODO
@@ -1,6 +1,5 @@
 TODO:
 - merge Realtek's bugfixes and new features into the driver
-- switch to use LIB80211
 - switch to use MAC80211
 - checkpatch.pl fixes - only a few remain
 
diff --git a/drivers/staging/rtl8723bs/TODO b/drivers/staging/rtl8723bs/TODO
index 3d8f5a634a10..4c413f9d3df0 100644
--- a/drivers/staging/rtl8723bs/TODO
+++ b/drivers/staging/rtl8723bs/TODO
@@ -5,7 +5,6 @@ TODO:
 - checkpatch.pl fixes - most of the remaining ones are lines too long. Many
   of them will require refactoring
 - merge Realtek's bugfixes and new features into the driver
-- switch to use LIB80211
 - switch to use MAC80211
 
 Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
diff --git a/drivers/staging/vt6655/TODO b/drivers/staging/vt6655/TODO
index 63607ef9c97e..7f6870f2ee5d 100644
--- a/drivers/staging/vt6655/TODO
+++ b/drivers/staging/vt6655/TODO
@@ -8,7 +8,6 @@ TODO:
   - abstract VT3253 chipset specific code
 - add common vt665x infrastructure
 - kill ttype.h
-- switch to use LIB80211
 - switch to use MAC80211
 - verify unsigned long usage for x86-64 arch
 - reduce .data footprint
diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
index 876cdccb6948..cca78d2d3cfe 100644
--- a/drivers/staging/vt6656/TODO
+++ b/drivers/staging/vt6656/TODO
@@ -8,7 +8,6 @@ TODO:
   - abstract VT3184 chipset specific code
 - add common vt665x infrastructure
 - kill ttype.h -- done
-- switch to use LIB80211
 - switch to use MAC80211
 - use kernel coding style
 - sparse fixes
-- 
2.46.2


