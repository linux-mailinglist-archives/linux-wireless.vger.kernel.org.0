Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8952A77BB6D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjHNOWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjHNOVl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 10:21:41 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA6BE3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 07:21:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5faf:0:640:dd1b:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 1935E600D1;
        Mon, 14 Aug 2023 17:21:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5LfxSnYWveA0-Kx2pdKdg;
        Mon, 14 Aug 2023 17:21:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692022867;
        bh=KVS4EIzNHnZBTAHE6j93OB/rR3iVMcFpONad5nDuO+Q=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=i5WjbhwE0bZcqDkKG9fCr8wy0O1fMspM37e8/ZdqyJOBhjnC1aA9SWQ1k0JuXTKwj
         HB8SJmZF/J9LxM3VPURyUpaSxrovuVZqsDdqX11xa8AkGB2Nmd2ccImtCKTU+NitDa
         MrJP1OQrQRDutM4eiZHv2QiQnsVWGnwUK2tunB7g=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: mwifiex: fix comment typos in SDIO module
Date:   Mon, 14 Aug 2023 17:19:05 +0300
Message-ID: <20230814142101.60308-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814142101.60308-1-dmantipov@yandex.ru>
References: <20230814142101.60308-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix comment typos around ' mwifiex_deaggr_sdio_pkt()'
and 'mwifiex_host_to_card_mp_aggr()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index a24bd40dd41a..38aff45b56f6 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1556,7 +1556,7 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 }
 
 /*
- * This function decode sdio aggreation pkt.
+ * This function decodes sdio aggregation pkt.
  *
  * Based on the data block size and pkt_len,
  * skb data will be decoded to few packets.
@@ -2266,7 +2266,7 @@ static int mwifiex_host_to_card_mp_aggr(struct mwifiex_adapter *adapter,
 		ret = mwifiex_write_data_to_card(adapter, card->mpa_tx.buf,
 						 card->mpa_tx.buf_len, mport);
 
-		/* Save the last multi port tx aggreagation info to debug log */
+		/* Save the last multi port tx aggregation info to debug log. */
 		index = adapter->dbg.last_sdio_mp_index;
 		index = (index + 1) % MWIFIEX_DBG_SDIO_MP_NUM;
 		adapter->dbg.last_sdio_mp_index = index;
-- 
2.41.0

