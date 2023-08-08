Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD347741E3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjHHRaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjHHR3n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 13:29:43 -0400
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7BD8C0A8
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:12:47 -0700 (PDT)
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by forward202b.mail.yandex.net (Yandex) with ESMTP id 64B4962F14
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 11:45:31 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3093:0:640:c702:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 943A260101;
        Tue,  8 Aug 2023 11:45:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SjTo0t0WnW20-BmoRCLcC;
        Tue, 08 Aug 2023 11:45:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1691484329;
        bh=3Z7EfjOimrw5nKbR408apLwVaPGfKT/U+sWuFHkeH5w=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=YmOYngv9aE6GAsYMowLuiGfpLeo7po3OyzC/Zbib3KPXPMJurkjtyikXYP8TejvT/
         RPZKI6G/VtaQzckIo/QQggegzUaZRs/Pa1odUwtq1z0IQHre8ezB5Gupzz9IuZW+Eo
         ic/V2TAb7kNjLHvZTlDxWfs1GO3gQ3yqIn0f78Mw=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mwifiex: avoid possible NULL skb pointer dereference
Date:   Tue,  8 Aug 2023 11:44:27 +0300
Message-ID: <20230808084431.43548-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'mwifiex_handle_uap_rx_forward()', always check the value
returned by 'skb_copy()' to avoid potential NULL pointer
dereference in 'mwifiex_uap_queue_bridged_pkt()', and drop
original skb in case of copying failure.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 838e4f449297 ("mwifiex: improve uAP RX handling")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 04ff051f5d18..454d1c11d39b 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -252,7 +252,15 @@ int mwifiex_handle_uap_rx_forward(struct mwifiex_private *priv,
 
 	if (is_multicast_ether_addr(ra)) {
 		skb_uap = skb_copy(skb, GFP_ATOMIC);
-		mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		if (likely(skb_uap)) {
+			mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			mwifiex_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+			priv->stats.tx_dropped++;
+			dev_kfree_skb_any(skb);
+			return -1;
+		}
 	} else {
 		if (mwifiex_get_sta_entry(priv, ra)) {
 			/* Requeue Intra-BSS packet */
-- 
2.41.0

