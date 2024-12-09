Return-Path: <linux-wireless+bounces-16080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A189E9B0C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F352829BA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26900481D1;
	Mon,  9 Dec 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="kWJJo8yb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E2139597
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759970; cv=none; b=mA0OQlhAS8b4A+N8h8Px3+709CbgKA2vvN9CKWuBaEtveFajunenWbTnm/gDhVX01jOzrw6FM3aFDqg/xpCJpzVGu+MvO0OVm74q2sBKfhU+G7ILvZ/i5inz9E0NasGw9QhojCMllb6JyKgyLoDetvClL9ZgdWEISBL8PJNFhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759970; c=relaxed/simple;
	bh=wInLD2g9IfLbZkB0O0KuHlBaYyC9sU2UZoyZLRMKzI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ijv3gJZpAQpidX/QrGtdE5jNGMHlBJ7K0TFYuvg8BUHFRF35bo5pWwwIYhhMa5FcuTn4oArRgAAkHFRZ5pyEM5WT2iA2sKn8lDZIAKEHfjjx4gjS9Zc0NNPiuZfR5xMLD7l07NeB5QexoGRJU7LpVz2XCaSnR18HOLCRMCImA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=kWJJo8yb; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward203d.mail.yandex.net (Yandex) with ESMTPS id 44312652B4
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:51:13 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:694a:0:640:6efd:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id A952E609A9;
	Mon,  9 Dec 2024 18:51:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3pnjm14OceA0-Yv6FoHP4;
	Mon, 09 Dec 2024 18:51:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733759464; bh=B8ehczkvDY3Px2yT2Ne0JhrvudSHkkNqroFJ/mLOOQ8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=kWJJo8ybjrIjN+t3UHWXTRP79KA+Fr0q/D3dVg404qZX2lhGjnbiju1HwGmOZ5qUS
	 i18IBms8ee71snzip2cqA++wl0B7vcUrTm+bQZwYvG1kOLAZRl6GyhAqylvNfjhyEX
	 ZcS8kuJP65YrG6zpNXFuGS7o8S3ZK9n5EbtXy//Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] wifi: ath9k: cleanup ath_txq_skb_done()
Date: Mon,  9 Dec 2024 18:50:25 +0300
Message-ID: <20241209155027.636400-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'txq' argument of 'ath_txq_skb_done()' is actually
(mis|un)used, convert the former to local variable and
adjust all related users. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 35aa47a9db90..fae96e3d66dd 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -208,10 +208,10 @@ static void ath_set_rates(struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				       ARRAY_SIZE(bf->rates));
 }
 
-static void ath_txq_skb_done(struct ath_softc *sc, struct ath_txq *txq,
-			     struct sk_buff *skb)
+static void ath_txq_skb_done(struct ath_softc *sc, struct sk_buff *skb)
 {
 	struct ath_frame_info *fi = get_frame_info(skb);
+	struct ath_txq *txq;
 	int q = fi->txq;
 
 	if (q < 0)
@@ -294,7 +294,7 @@ static void ath_tx_flush_tid(struct ath_softc *sc, struct ath_atx_tid *tid)
 		fi = get_frame_info(skb);
 		bf = fi->bf;
 		if (!bf) {
-			ath_txq_skb_done(sc, txq, skb);
+			ath_txq_skb_done(sc, skb);
 			ieee80211_free_txskb(sc->hw, skb);
 			continue;
 		}
@@ -962,7 +962,7 @@ ath_tx_get_tid_subframe(struct ath_softc *sc, struct ath_txq *txq,
 			bf->bf_state.stale = false;
 
 		if (!bf) {
-			ath_txq_skb_done(sc, txq, skb);
+			ath_txq_skb_done(sc, skb);
 			ieee80211_free_txskb(sc->hw, skb);
 			continue;
 		}
@@ -2379,7 +2379,7 @@ int ath_tx_start(struct ieee80211_hw *hw, struct sk_buff *skb,
 
 	bf = ath_tx_setup_buffer(sc, txq, tid, skb);
 	if (!bf) {
-		ath_txq_skb_done(sc, txq, skb);
+		ath_txq_skb_done(sc, skb);
 		if (txctl->paprd)
 			dev_kfree_skb_any(skb);
 		else
@@ -2514,7 +2514,7 @@ static void ath_tx_complete(struct ath_softc *sc, struct sk_buff *skb,
 	}
 	spin_unlock_irqrestore(&sc->sc_pm_lock, flags);
 
-	ath_txq_skb_done(sc, txq, skb);
+	ath_txq_skb_done(sc, skb);
 	tx_info->status.status_driver_data[0] = sta;
 	__skb_queue_tail(&txq->complete_q, skb);
 }
-- 
2.47.1


