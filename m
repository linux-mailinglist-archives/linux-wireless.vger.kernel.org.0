Return-Path: <linux-wireless+bounces-710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D37880F4B3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 18:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD93F28158E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606AC7D8A2;
	Tue, 12 Dec 2023 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="L3pbz1Z4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF67B7
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 09:35:37 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e96:0:640:734b:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTP id 2E3274230E;
	Tue, 12 Dec 2023 20:35:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YZm9jT2OlGk0-W1Ypg9aR;
	Tue, 12 Dec 2023 20:35:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702402534; bh=HnPj+3UUwtYbAybm62XaSvEnjwzf1mi3XwkCwZ9ZoME=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=L3pbz1Z4fjtxqjmlWQ4ywg7RkAnoGrs4HccJBw93UWmXUjXCuHjpXtqMYXrzG9bRE
	 cdUKYrADnwoZwn+Z4Xiw/nrtNZ8uUJKtNvJRKDBV9PdrmaV3iaZlCwQNqVZCaxlzGW
	 6JnO/REuYyAxEQ6YUZ7nTjeL+vHX62NOXHe8IfrI=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@kernel.org>,
	lvc-project@linuxtesting.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rt2x00: remove useless code in rt2x00queue_create_tx_descriptor()
Date: Tue, 12 Dec 2023 20:34:18 +0300
Message-ID: <20231212173421.119136-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'rt2x00queue_create_tx_descriptor()', there is no need to call
'ieee80211_get_rts_cts_rate()' while checking for RTS/CTS frame
since this function returns NULL or pointer to internal bitrate
table entry, and the return value is not actually used. This way,
'rate' becomes block-scoped later when determining the modulation.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
index 98df0aef8168..7f9955deb204 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -389,7 +389,6 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_rate *txrate = &tx_info->control.rates[0];
-	struct ieee80211_rate *rate;
 	const struct rt2x00_rate *hwrate = NULL;
 
 	memset(txdesc, 0, sizeof(*txdesc));
@@ -416,9 +415,6 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
 			__set_bit(ENTRY_TXD_RTS_FRAME, &txdesc->flags);
 		else
 			__set_bit(ENTRY_TXD_CTS_FRAME, &txdesc->flags);
-		if (tx_info->control.rts_cts_rate_idx >= 0)
-			rate =
-			    ieee80211_get_rts_cts_rate(rt2x00dev->hw, tx_info);
 	}
 
 	/*
@@ -463,7 +459,8 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
 	else if (txrate->flags & IEEE80211_TX_RC_MCS)
 		txdesc->rate_mode = RATE_MODE_HT_MIX;
 	else {
-		rate = ieee80211_get_tx_rate(rt2x00dev->hw, tx_info);
+		struct ieee80211_rate *rate =
+			ieee80211_get_tx_rate(rt2x00dev->hw, tx_info);
 		hwrate = rt2x00_get_rate(rate->hw_value);
 		if (hwrate->flags & DEV_RATE_OFDM)
 			txdesc->rate_mode = RATE_MODE_OFDM;
-- 
2.43.0


