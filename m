Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC73473649C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 09:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjFTHcv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFTHcu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 03:32:50 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADBDDF
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 00:32:48 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 5DC4A6011D;
        Tue, 20 Jun 2023 10:32:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UWb0SEqDfiE0-gyPtXFwZ;
        Tue, 20 Jun 2023 10:32:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687246365;
        bh=NijMV3+E8XkZYhvELiFDZ8763krT3D51AnOa5G+Egmg=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=c8x6xaGFOnlhhNwuIeeTyw4TBlpjiINAg65ice+8Yy7wfkTuj2BpLvguLlY4u8PhD
         fISfsLhCJ6kNsuPlm6243/yjvjF5gOqUfSnoKViiIX3pVW6lcR0D2BMpz73eCLzla+
         hHwggxT4yONILT9Eu97bIdQfAJhcezTmVg126JXA=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: ath9k: fix fortify warnings
Date:   Tue, 20 Jun 2023 10:31:58 +0300
Message-ID: <20230620073228.363207-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620073228.363207-1-dmantipov@yandex.ru>
References: <20230620073228.363207-1-dmantipov@yandex.ru>
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
'memcpy()' for two 4-byte fields). Since the fortification logic
seems interprets this trick as an attempt to overread 4-byte 'ba_low',
relevant warnings may be silenced by specifying source buffer with
'offsetof()' of the 'ba_low' instead of using an address of the latter.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 8babaaacacf5..5a70395a3a2a 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -470,7 +470,8 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
-		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+		memcpy(ba, ts + offsetof(struct ath_tx_status, ba_low),
+		       WME_BA_BMP_SIZE >> 3);
 	}
 
 	while (bf) {
@@ -553,7 +554,8 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	if (isaggr && txok) {
 		if (ts->ts_flags & ATH9K_TX_BA) {
 			seq_st = ts->ts_seqnum;
-			memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+			memcpy(ba, ts + offsetof(struct ath_tx_status, ba_low),
+			       WME_BA_BMP_SIZE >> 3);
 		} else {
 			/*
 			 * AR5416 can become deaf/mute when BA
-- 
2.41.0

