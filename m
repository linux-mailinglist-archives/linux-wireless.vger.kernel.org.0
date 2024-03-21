Return-Path: <linux-wireless+bounces-5090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072FC885926
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 13:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4F91F212B9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADD0763E0;
	Thu, 21 Mar 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="pTRm3stU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net [178.154.239.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D367F7D9
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024441; cv=none; b=VLzB2pgu0dl4NLKkelBGoRTFv0i8SIv1AqPJJV/uKrkq2NmXnbh0kAR7fKmChQTXH201WNM3Y5VjE5ywNI5NshWfrWZBi+mqsB8STGdw0oymrES1uhidPOO6dC1EbAwOsSumPV3dIgX/qhhhkaoArCaR5RZnP5WFQRZu/RukMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024441; c=relaxed/simple;
	bh=PtDqehgiZjGqaYRLJ1LInswJsoMujpL93mYoWMmHjaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAfIXxGKsTnJWReYXLBKt8Q+GuKfxvRPOXsYq06hotzSU394YuepH65E7GBnMfrhmikTLfstz84Uj3Fw2RpSSH2DPEbutdOGOZIgLKXZfwChS8fcRVGRhjXOJJ12z/XnQmWSgwhGjqI70zfG3cWKNs6fdCWnidt1TZgMr2TbQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=pTRm3stU; arc=none smtp.client-ip=178.154.239.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
	by forward204b.mail.yandex.net (Yandex) with ESMTPS id AC07B68525
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 15:26:53 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5199:0:640:a94b:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTPS id 827226090B;
	Thu, 21 Mar 2024 15:26:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id iQFJU6D5SKo0-F39a4S8e;
	Thu, 21 Mar 2024 15:26:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711024004; bh=ikBKJe8G+BSFYuRMygFBfR6VFJStppmJ7luUz8EciC4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=pTRm3stUGj6W/4Z6gOfvqhBhL5nW05uHfbcC5g2QGCKsoq4U/zZta6V3nPWG3OvGs
	 j4UYIU2IvoCuOlkCyeb06MOdc2ZoH8O9uv/oIcK3ZWKoPmamV5RqfQnXpQkrX663Ny
	 DbJXlEkigAwPK1a1T0eqzUaphNUuxl5DlflNzV88=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: cleanup ath_tx_complete_aggr()
Date: Thu, 21 Mar 2024 15:26:42 +0300
Message-ID: <20240321122642.175645-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'skb', 'tx_info' and 'fi' are actually used within
buffers processing loop only, move them inside the latter
and avoid some redundant initialization at the beginning
of 'ath_tx_complete_aggr()'. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index d519b676a109..657862be45e5 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -491,8 +491,6 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 				 struct ath_tx_status *ts, int txok)
 {
 	struct ath_node *an = NULL;
-	struct sk_buff *skb;
-	struct ieee80211_tx_info *tx_info;
 	struct ath_buf *bf_next, *bf_last = bf->bf_lastbf;
 	struct list_head bf_head;
 	struct sk_buff_head bf_pending;
@@ -501,15 +499,11 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	int isaggr, txfail, txpending, sendbar = 0, needreset = 0, nbad = 0;
 	bool rc_update = true, isba;
 	struct ieee80211_tx_rate rates[4];
-	struct ath_frame_info *fi;
 	int nframes;
 	bool flush = !!(ts->ts_status & ATH9K_TX_FLUSH);
 	int i, retries;
 	int bar_index = -1;
 
-	skb = bf->bf_mpdu;
-	tx_info = IEEE80211_SKB_CB(skb);
-
 	memcpy(rates, bf->rates, sizeof(rates));
 
 	retries = ts->ts_longretry + 1;
@@ -571,14 +565,13 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	ath_tx_count_frames(sc, bf, ts, txok, &nframes, &nbad);
 	while (bf) {
 		u16 seqno = bf->bf_state.seqno;
+		struct sk_buff *skb = bf->bf_mpdu;
+		struct ath_frame_info *fi = get_frame_info(skb);
+		struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 
 		txfail = txpending = sendbar = 0;
 		bf_next = bf->bf_next;
 
-		skb = bf->bf_mpdu;
-		tx_info = IEEE80211_SKB_CB(skb);
-		fi = get_frame_info(skb);
-
 		if (!BAW_WITHIN(tid->seq_start, tid->baw_size, seqno) ||
 		    !tid->active) {
 			/*
-- 
2.44.0


