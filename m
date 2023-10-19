Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298257CF0C6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 09:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjJSHI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344910AbjJSHIh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 03:08:37 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4C11B
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 00:08:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id B55FB60975;
        Thu, 19 Oct 2023 10:08:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id B8gBfIQW1Cg0-L7fRSbfS;
        Thu, 19 Oct 2023 10:08:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697699292; bh=wlmV/2sYnf79wVrjzIAMKySox4ihNFq0naaLhcKL3WI=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=FgWi4kD6b60JVb/b8Q0lk3zwrH4mx+KFjRyu13kOPwPuZ4XSzU4e2GP1CaRgncWZi
         cOr6X8JDeU7Fj5lOz0N37uq8ye2CvkWa3tTin1LRnh1XUzL24k1/nGdEcG+MYW1nan
         wFZdy7PK/wsRHjrt/g950HlOd1ICJjaHl0qQFo9c=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rt2x00: simplify rt2x00crypto_rx_insert_iv()
Date:   Thu, 19 Oct 2023 10:06:09 +0300
Message-ID: <20231019070750.17911-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'rt2x00crypto_rx_insert_iv()', added alignment can't exceed 3
bytes and ICV size is either 4 or 8 bytes, so skb space adjustment
may be simplified. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c b/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
index ad95f9eba301..1000fbfb94b8 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
@@ -197,10 +197,7 @@ void rt2x00crypto_rx_insert_iv(struct sk_buff *skb,
 		transfer += header_length;
 	} else {
 		skb_push(skb, iv_len + align);
-		if (align < icv_len)
-			skb_put(skb, icv_len - align);
-		else if (align > icv_len)
-			skb_trim(skb, rxdesc->size + iv_len + icv_len);
+		skb_put(skb, icv_len - align);
 
 		/* Move ieee80211 header */
 		memmove(skb->data + transfer,
-- 
2.41.0

