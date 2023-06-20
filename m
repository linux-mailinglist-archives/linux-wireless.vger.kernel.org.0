Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16A973649A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjFTHct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFTHcs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 03:32:48 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9711D
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 00:32:46 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 756AC6004B;
        Tue, 20 Jun 2023 10:32:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UWb0SEqDfiE0-AGNkaZ9G;
        Tue, 20 Jun 2023 10:32:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687246364;
        bh=s67ry7Co9MPhktxsgxXhz8/DBce/8Tak4qy6/Iz1lww=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=EtmzobNtIVFrceZeSKxv4ZJbLRBsLbEEhLwDE3Cu5s61KPFkzQLJPW4Rtiw5NHgnD
         BsXd099p1JskoPsBWiKy7dw6JZWjWnbHrlip5jAKFf5W9pemHcsO6Qi6KZVfLiFO3e
         w/l4e3XNErD/ZifyRTdcuMm14kA4SHcBqBsXs+6Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: ath9k: avoid using uninitialized array
Date:   Tue, 20 Jun 2023 10:31:57 +0300
Message-ID: <20230620073228.363207-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

In 'ath_tx_count_frames()', 'ba' array may be used uninitialized, so
add 'memset()' call similar to one used in 'ath_tx_complete_aggr()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index f6f2ab7a63ff..8babaaacacf5 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -466,6 +466,8 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 	*nframes = 0;
 
 	isaggr = bf_isaggr(bf);
+	memset(ba, 0, WME_BA_BMP_SIZE >> 3);
+
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
 		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
-- 
2.41.0

