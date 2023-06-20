Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E617368DF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjFTKKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjFTKKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:10:01 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0053BFC
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:09:57 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 4869D6005A;
        Tue, 20 Jun 2023 13:09:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id d9eIllrDZ0U0-0DuOcOoj;
        Tue, 20 Jun 2023 13:09:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687255790;
        bh=TdL1ODdSnmobHyWQ9cr10ORS2I4JdZUnqRsLqz3p2YU=;
        h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
        b=qwlnT78Kwy94SHGwlRb7RufB+RA5JQiEJj74DjuwgcgR6iEFChbab3QrTEEpKKZST
         ql1TeL9hb6aK3OERH0Wv6XlxRg6WrfZRnnv6skL6mD3yWMbdL3hi73fw9CwWGNxlzX
         xEjFeqaFPx6iP/ftY1B2Ow9CHClwQ7vO+wj/ehog=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] [v2] wifi: mwifiex: fix fortify warning
Date:   Tue, 20 Jun 2023 13:07:37 +0300
Message-ID: <20230620100803.519926-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620100803.519926-1-dmantipov@yandex.ru>
References: <20230620100803.519926-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=y,
I've noticed the following:

In function ‘fortify_memcpy_chk’,
    inlined from ‘mwifiex_construct_tdls_action_frame’ at drivers/net/wireless/marvell/mwifiex/tdls.c:765:3,
    inlined from ‘mwifiex_send_tdls_action_frame’ at drivers/net/wireless/marvell/mwifiex/tdls.c:856:6:
./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler actually complains on:

memmove(pos + ETH_ALEN, &mgmt->u.action.category,
	sizeof(mgmt->u.action.u.tdls_discover_resp));

and it happens because the fortification logic interprets this
as an attempt to overread 1-byte 'u.action.category' member of
'struct ieee80211_mgmt'. To silence this warning, it's enough
to pass an address of 'u.action' itself instead of an address
of its first member.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 97bb87c3676b..5a2941965757 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -762,7 +762,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 		mgmt->u.action.u.tdls_discover_resp.capability =
 							     cpu_to_le16(capab);
 		/* move back for addr4 */
-		memmove(pos + ETH_ALEN, &mgmt->u.action.category,
+		memmove(pos + ETH_ALEN, &mgmt->u.action,
 			sizeof(mgmt->u.action.u.tdls_discover_resp));
 		/* init address 4 */
 		eth_broadcast_addr(pos);
-- 
2.41.0

