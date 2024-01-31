Return-Path: <linux-wireless+bounces-2890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDDB844360
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228B91F25871
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FA384A57;
	Wed, 31 Jan 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sGOTRKzI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E212A14C
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716150; cv=none; b=JicGCxm9syoT/23m10nHlwxitDhqtbFQHPPNrb9pq/krwOLWW6HbNNiTi2YOZdwFfGcedIp99pxCDfNMkfuPJSx6gOk0Nhw1jNJ1oy5ymKLced4eykGLGbEqUHgCYKrUb+7RH+VrlKed+pUmwBlukcYZjtVdfcPPqw9GJdLo6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716150; c=relaxed/simple;
	bh=yREoDjsqh6dtmJrdQJLG/aS3aa72KKX++9ckY/7sRhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUoSJjtpLeW1CA2tGjgTjcCGBVwj8gf+XnSpKM3toNAYbR+DctnmdjukhMsWkqJU49e2odlQUWPeLyhOGRGIbCbpXjn8V9mbigP1du+zQgh/7wf2qSALffGckuHajjLp9QW3Fpx7AXmMJY+iCrfjwdfec3pcibOYIe7vqMxjI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sGOTRKzI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Tr3Ud1W06RjTFYmGRDbdXScNEdgPp2NzrHiPUv56EQE=; t=1706716148; x=1707925748; 
	b=sGOTRKzIiSgcIBDA4arS/TpMOYdklrr6CJCz10UbTzW8+rGGDynu8WoIeeOShn36bGVHfW7Tk8j
	mwFX920Cq4chPQoFlj/sK7w0TVvcAG2nRWdl0aI0Yg7gXBhZieRwoKWsv6+iU3qR6F8+wCW8sdpoe
	h9q/jRq6sBZVghL4Yr67siihZouo5/xxOE1cN2qnqaQl/A6zZKnQ5UCm4ReT9Cp7iX1Oo4mlwyf+C
	19BgjC5G3ylAv7EM3afF2HStjBpPG1eVBvl7Mat8i6ja78w4lwSwVe7hw+5Y3bNM7DxM/FWQlBj0Z
	E8WM1DCcHaqxLajQrfxbcs+JF/DqEtUEwmwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVCpl-00000007JBz-2KHQ;
	Wed, 31 Jan 2024 16:49:05 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: remove extra shadowing variable
Date: Wed, 31 Jan 2024 16:49:04 +0100
Message-ID: <20240131164903.e9746a5cfe0e.I30348fe77593057ac3fe8e2afa3d7a97de6d04d0@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Not sure how this happened or how nothing complained, but
this variable already exists in the outer function scope
with the same value (and the SKB isn't changed either.)
Remove the extra one.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1ee00547c0a4..9902ea69af0a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5231,7 +5231,6 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			 */
 
 			if (!status->link_valid && pubsta->mlo) {
-				struct ieee80211_hdr *hdr = (void *)skb->data;
 				struct link_sta_info *link_sta;
 
 				link_sta = link_sta_info_get_bss(rx.sdata,
-- 
2.43.0


