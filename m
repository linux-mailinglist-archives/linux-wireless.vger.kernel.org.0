Return-Path: <linux-wireless+bounces-14268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830699A69CE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 15:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16361C21E80
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF91F1314;
	Mon, 21 Oct 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mTnaxfWa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D571E906C
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516462; cv=none; b=SWWTdvWm6zeq65OxP6fhCU6WUzmkUzPibj6F+6tKMvse/qrEx3qw+HP1Gc82fzgvHB5fsDN3p/foRTKohTWGXaOKYZEzRZ3e8YvYpL+uT555yo4gKHfUjepbNE2hDckAfrXczuZuGdzOLCSgigxGrDZCDpN9znJygczwiUYWsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516462; c=relaxed/simple;
	bh=/vMOoYf2A818i3zKh4GHEWJZ3TxCL8U9lglv8zhsWtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMuk4bd3JRVEU7o1cjddEO1dZDfpKt92miYs92u9I0CXUZ5P8HytaXRrBkfrNiG/MP51q7A0xuRunfFQ532sMN7ly4HbbI7F5kNNmOFHLNhz2MaDfvp7jJxfDp3wvufImRawFRy35ulhZucwtjN/ZttOcLEQImp8pBBks7YSTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mTnaxfWa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=xgsfPJ6RdwItBRaof5N/ebxuGf7UJua1cT3kbeAw6NI=; t=1729516460; x=1730726060; 
	b=mTnaxfWaN9q5iE0LRy4H25oiSvYN7I3ECC6x2/hKXmA69x3lknRZigg6ryleg3AH/+xXdx/R/y9
	GnwIa0bOMofCfio/7vJfGgFPuv+wM4ZH56HA6eFJQbpnCpxYelNydHslNAYRRFN8KWzvjnA6/dQsA
	h22LoQbkLmQ2+VUejm7Ivr3PQwwIOVLUN4ee0wWxA16Ydcs6+x6evtwJ4k3rT6ML+AgwUg0obNioj
	ip2BFY9pLnwLMBao6f61h3FCVpidREr2mob2WFr9t1U11kk6KIk04AwQl/zMFAXHDErGiHxSAymnE
	ENS4UhoApRKG0R4oAOYlek29glY20vtJ8SGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2sEi-00000000oKq-3EOu;
	Mon, 21 Oct 2024 15:14:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Jouni Malinen <j@w1.fi>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: remove misleading j_0 construction parts
Date: Mon, 21 Oct 2024 15:14:14 +0200
Message-ID: <20241021151414.798ceb7a5896.Ic57751edad228d56865ecf7433fef469e5e0a4aa@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The GCM algorithm implementation in the kernel assumes that
a 12-byte IV is passed, not the actual J_0 from the GCM spec.
Don't rename, that'd be messy, but also don't fill the bytes
beyond the IV that aren't used, since otherwise it looks as
though j_0[12] is used uninitialized.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/wpa.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 293afa3f57c5..40d5d9e48479 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -598,9 +598,6 @@ static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad,
 
 	memcpy(j_0, hdr->addr2, ETH_ALEN);
 	memcpy(&j_0[ETH_ALEN], pn, IEEE80211_GCMP_PN_LEN);
-	j_0[13] = 0;
-	j_0[14] = 0;
-	j_0[AES_BLOCK_SIZE - 1] = 0x01;
 
 	ccmp_gcmp_aad(skb, aad, spp_amsdu);
 }
-- 
2.47.0


