Return-Path: <linux-wireless+bounces-17632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73181A14B85
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 09:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A1F3A2ED6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F651F8AE1;
	Fri, 17 Jan 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="C2K94LvR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859811F754C
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104184; cv=none; b=WgTYSL9rY2FRJ1JW5uC5JsahRxCNlcw3IfxzZ5hyMvGAwayzKQKZbo4w9UUkAGWhNKo7EaIAJSN0LPfrOSo/R3Z8N5cQtbiXH0VkjxVf3IPFX7wOhl4i6Ud9f0OyVwEhgsxExT3UwigoL6gkYV73FNbafuVCmMAs36d8v0wu7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104184; c=relaxed/simple;
	bh=G6JUsXejjHZnrm6b7QLTD2i5yBXyc93gChgla8tzwTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhwYZJ+L+kjxnGfMQfn8z05AS5jo/4x7WGpDRHPWLsP3pE0Z1LPuS8R/YkoTCjqI7m6A5WnKLt7AVoGPNYT5pIG38eXqIejXLZcrkIfIzqc4QDVT/srMhQr58VpvwH3Ij6IOGgMLUokXwTYqkN3LAokZjtykseve7kBZqNlhJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=C2K94LvR; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id 9B32B6AC99
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 11:48:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3b0d:0:640:b15b:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 1C4C760AFC;
	Fri, 17 Jan 2025 11:48:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XmNUnd6OmqM0-heSJT8RA;
	Fri, 17 Jan 2025 11:48:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1737103714; bh=zX/JPX/ilw9PA/foig/tl9XreUocd7cMLrZuhYTJlBo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=C2K94LvRvOMUelaXB2Jx/6NofRXfRpJOWV37KMdzQJlrB+OpaDLsv77X4YQ4wF6nc
	 qFwJKrURKhnCy1fNblVgDAyLOgdFiv1FPCpZmq8k8fDfPsv2aR7gJFzFptOy5CaazF
	 JDakuBbaSxOyMl15AOgCIHWQzwFp5X8np7W95AW8=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: adjust ath9k_rx_prepare() and simplify ath9k_rx_tasklet()
Date: Fri, 17 Jan 2025 11:48:23 +0300
Message-ID: <20250117084823.1193083-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust 'ath9k_rx_prepare()' to fill skb control buffer directly rather
than using temporary 'struct ieee80211_rx_status' in 'ath9k_rx_tasklet()',
thus making both temporary and 'memcpy()' redundant. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index ce9c04e418b8..acbcb37150eb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -969,13 +969,12 @@ static void rx_status_htc_to_ath(struct ath_rx_status *rx_stats,
 }
 
 static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
-			     struct ath9k_htc_rxbuf *rxbuf,
-			     struct ieee80211_rx_status *rx_status)
-
+			     struct ath9k_htc_rxbuf *rxbuf)
 {
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_hw *hw = priv->hw;
 	struct sk_buff *skb = rxbuf->skb;
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	struct ath_hw *ah = common->ah;
 	struct ath_htc_rx_status *rxstatus;
@@ -1081,7 +1080,6 @@ void ath9k_rx_tasklet(struct tasklet_struct *t)
 {
 	struct ath9k_htc_priv *priv = from_tasklet(priv, t, rx_tasklet);
 	struct ath9k_htc_rxbuf *rxbuf = NULL, *tmp_buf = NULL;
-	struct ieee80211_rx_status rx_status;
 	struct sk_buff *skb;
 	unsigned long flags;
 	struct ieee80211_hdr *hdr;
@@ -1103,13 +1101,11 @@ void ath9k_rx_tasklet(struct tasklet_struct *t)
 		if (!rxbuf->skb)
 			goto requeue;
 
-		if (!ath9k_rx_prepare(priv, rxbuf, &rx_status)) {
+		if (!ath9k_rx_prepare(priv, rxbuf)) {
 			dev_kfree_skb_any(rxbuf->skb);
 			goto requeue;
 		}
 
-		memcpy(IEEE80211_SKB_RXCB(rxbuf->skb), &rx_status,
-		       sizeof(struct ieee80211_rx_status));
 		skb = rxbuf->skb;
 		hdr = (struct ieee80211_hdr *) skb->data;
 
-- 
2.48.1


