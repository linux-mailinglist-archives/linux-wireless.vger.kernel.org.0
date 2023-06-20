Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8B7365BF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjFTIJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTIJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 04:09:17 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85AC7
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 01:09:14 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:31b:0:640:fdf8:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id D23E146CFD;
        Tue, 20 Jun 2023 11:09:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id v8cEIqsDXeA0-ZESfpdsS;
        Tue, 20 Jun 2023 11:09:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687248550;
        bh=4X98IAt8BnmV2EhvdQ72Hn+z05n9QJIs5V8E2HcE+is=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=EtcRnr+095w2ADzZc39FqdGxK3qJqXiechGA5VsKoNbU29zNmkxRxukv+frqA6FZd
         Nt53YwBU/mY7bPI/af36VCBVmJ2NCxFhj1bsY7Dqj4AYToR3o+OEz6ZdayO5LpLZ/S
         7ZfTfR4+j3wVcQlAQikgdGbTSYRwS9XXr1HhUpx4=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] [v2] wifi: ath9k: fix fortify warnings
Date:   Tue, 20 Jun 2023 11:08:41 +0300
Message-ID: <20230620080855.396851-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620080855.396851-1-dmantipov@yandex.ru>
References: <20230620080855.396851-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=y,
I've noticed the following:

In function ‘fortify_memcpy_chk’,
    inlined from ‘ath_tx_complete_aggr’ at drivers/net/wireless/ath/ath9k/xmit.c:556:4,
    inlined from ‘ath_tx_process_buffer’ at drivers/net/wireless/ath/ath9k/xmit.c:773:3:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In function ‘fortify_memcpy_chk’,
    inlined from ‘ath_tx_count_frames’ at drivers/net/wireless/ath/ath9k/xmit.c:473:3,
    inlined from ‘ath_tx_complete_aggr’ at drivers/net/wireless/ath/ath9k/xmit.c:572:2,
    inlined from ‘ath_tx_process_buffer’ at drivers/net/wireless/ath/ath9k/xmit.c:773:3:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In both cases, the compiler complains on:

memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);

which is the legal way to copy both 'ba_low' and following 'ba_high'
members of 'struct ath_tx_status' at once (that is, issue one 8-byte
'memcpy()' for two 4-byte fields). Since the fortification logic seems
interprets this trick as an attempt to overread 4-byte 'ba_low', silence
relevant warnings by using the convenient 'struct_group()' quirk.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: prefer struct_group() over offsetof() (Johannes Berg)
---
 drivers/net/wireless/ath/ath9k/mac.h  | 6 ++++--
 drivers/net/wireless/ath/ath9k/xmit.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index af44b33814dd..f03d792732da 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -115,8 +115,10 @@ struct ath_tx_status {
 	u8 qid;
 	u16 desc_id;
 	u8 tid;
-	u32 ba_low;
-	u32 ba_high;
+	struct_group(ba,
+		u32 ba_low;
+		u32 ba_high;
+	);
 	u32 evm0;
 	u32 evm1;
 	u32 evm2;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 8babaaacacf5..4e939dcac1c9 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -470,7 +470,7 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
-		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+		memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 	}
 
 	while (bf) {
@@ -553,7 +553,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	if (isaggr && txok) {
 		if (ts->ts_flags & ATH9K_TX_BA) {
 			seq_st = ts->ts_seqnum;
-			memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+			memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 		} else {
 			/*
 			 * AR5416 can become deaf/mute when BA
-- 
2.41.0

