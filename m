Return-Path: <linux-wireless+bounces-730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479F81095C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 06:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BAA1C2095A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 05:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D9C2DA;
	Wed, 13 Dec 2023 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="l0P5TSw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC273CF
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 21:16:00 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:319f:0:640:2485:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTP id D01EA60A78;
	Wed, 13 Dec 2023 08:15:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uFbMwoMXueA0-IcbID8SR;
	Wed, 13 Dec 2023 08:15:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702444557; bh=AKtpUD4MttzDaNOer4++Hl0rSP6BYC5B80tifDB1dqM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=l0P5TSw0LNY1w3wxyYSaHUTPvXiLg5XRREsaIGhCicmVtL9kqCOug2RFkxJNVf045
	 J/tQUU/yySpNoSCet21yzJKUc7tFCHxNxz+Jfuc7+c9cfO0t5IXvGcCjpsPubr6EqK
	 Nwle2f7wT47KTKFB15B2cS7mc+FNNcDYEVrO17Mk=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Kalle Valo <kvalo@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	lvc-project@linuxtesting.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: rt2x00: remove useless code in rt2x00queue_create_tx_descriptor()
Date: Wed, 13 Dec 2023 08:14:43 +0300
Message-ID: <20231213051449.126963-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87il53nvqc.fsf@kernel.org>
References: <87il53nvqc.fsf@kernel.org>
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
table entry, and the return value is not actually used. Compile
tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: avoid scoped locals (Kalle Valo)
---
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
index 98df0aef8168..013003777fee 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -416,9 +416,6 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
 			__set_bit(ENTRY_TXD_RTS_FRAME, &txdesc->flags);
 		else
 			__set_bit(ENTRY_TXD_CTS_FRAME, &txdesc->flags);
-		if (tx_info->control.rts_cts_rate_idx >= 0)
-			rate =
-			    ieee80211_get_rts_cts_rate(rt2x00dev->hw, tx_info);
 	}
 
 	/*
-- 
2.43.0


