Return-Path: <linux-wireless+bounces-30144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E7CE5297
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56B523008D40
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACAB211A14;
	Sun, 28 Dec 2025 16:04:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3521CC79
	for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937866; cv=none; b=chsFSNoM3988urXLV0szMwKTltIcHdZpsGasnNdyY7s1HxIqNLB5Pv3ais7aFXxZNBxU7iRPkVZPXIQLBXsuHEJuOsEP87YS5Me0shECQaAX/MxPliwhOmfchFF/IuXVB5Kvg2bWQNnX0YsXGBKM6hRkVZqXdGQCB7Kv2No3pP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937866; c=relaxed/simple;
	bh=WdKXvbrW7989w8Ls4d6QL4BI3AXUZfJgkIGw0BGWBYw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=W89I4g6vihGbstK47ypfwJqT4AxXPd6ZKP6rZLrot7WopwA6w/n8ei47AHZrWYV2PUNZGFlw1kS5olGEDsFbh5oKSaXwKj/bRGsHlpzO5pP2yK9YqyBAhTdXc2FUeowmlThRa2z2FgrhhTJHzQZZY52cGZydQEwza2sQbsYMjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id B4701B97E
	for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 16:54:28 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id A82A4B97D; Sun, 28 Dec 2025 16:54:28 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 3D09ABAD2
	for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 16:54:26 +0100 (CET)
Date: Sun, 28 Dec 2025 16:54:25 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: linux-wireless@vger.kernel.org
Subject: [RFC PATCH] wifi: wlcore: allocated packets tracking mechanism may
 get broken
Message-ID: <476e02ce-4592-b08a-fcc9-c1b151500bb9@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1130933901-1766936024=:180263"
Content-ID: <a0fda3d8-1e2a-70ae-2121-87da0d9bd1b4@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1130933901-1766936024=:180263
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <a6f5863d-825f-1735-a874-344abc7ea85c@lysator.liu.se>


According to 
https://git.ti.com/cgit/wilink8-wlan/build-utilites/commit/?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7 
the patch below should be used with firmware 8.9.1.0.2 . Does it make 
sense to include this in upstream kernel? I cannot really say if it 
improves stability or not: I don't have the possibility to run WFA test 
5.2.27, and I am still seing issues with firmware 8.9.1.0.2 and 6.6 kernel 
(with all 80211 fixes). Testing of this patch with older wl18xx firmware 
is ongoing. 


From ac0695f9bf6810ae91cd0e441199102f0c16e507 Mon Sep 17 00:00:00 2001
From: Itzhak <shlomii@ti.com>
Date: Thu, 28 Dec 2023 08:47:58 +0200
Subject: [PATCH 25/27] allocated packets tracking mechanism may get broken

 It is observed that at some scenarios, the best effort queue
 that should always show positive or 0 count, may show negative. This cause
 the best effort queue to look full to the network stack and thus causing the
 network stack to push less packets than to other QoS queues. It would cause
 specific WFA tests like 5.2.27 to fail.

Signed-off-by: Itzhak <shlomii@ti.com>
---
 drivers/net/wireless/ti/wlcore/tx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index b6e19c2d66b0..02727bb9bc50 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -27,6 +27,19 @@
  */
 #include "../wl12xx/reg.h"
 
+/* mapping tid to AC queue
+ */
+static const int ieee802_tid_to_ac[8] = {
+	CONF_TX_AC_BE,
+	CONF_TX_AC_BK,
+	CONF_TX_AC_BK,
+	CONF_TX_AC_BE,
+	CONF_TX_AC_VI,
+	CONF_TX_AC_VI,
+	CONF_TX_AC_VO,
+	CONF_TX_AC_VO
+};
+
 static int wl1271_set_default_wep_key(struct wl1271 *wl,
 				      struct wl12xx_vif *wlvif, u8 id)
 {
@@ -287,6 +300,18 @@ static void wl1271_tx_fill_hdr(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	/* queue */
 	ac = wl1271_tx_get_queue(skb_get_queue_mapping(skb));
 	desc->tid = skb->priority;
+	
+	/* check that tid is aligned with ac, if not, align with ac */
+	if ( (desc->tid >= 0) && (desc->tid <= 7) && (ieee802_tid_to_ac[desc->tid] != ac) )
+	{
+		/* decrement the wrong allocated ac and increment according to tid */
+		wl->tx_allocated_pkts[ac]--;
+		wl->tx_allocated_pkts[ieee802_tid_to_ac[desc->tid]]++;
+		
+		wl1271_debug(DEBUG_TX,
+			     "tx_fill_hdr: tid: %d. ac: %d",
+			     desc->tid, ac);
+	}
 
 	if (is_dummy) {
 		/*
-- 
2.25.0.windows.1




Br,
Peter Åstrand
--8323329-1130933901-1766936024=:180263--

