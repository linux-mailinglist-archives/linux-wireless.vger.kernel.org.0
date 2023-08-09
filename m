Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA716775AE9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjHILMg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjHILMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 07:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A57210F3;
        Wed,  9 Aug 2023 04:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 380D463155;
        Wed,  9 Aug 2023 11:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4D2C433C7;
        Wed,  9 Aug 2023 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579554;
        bh=EooU9pkdh78sepSZ+YKbrwYOxqe0XEKeQ1A7NibNZ6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9feNP2uvndRXRpmTNU2pU5gN2uUWXiOppMLGHGUvxCAGgw9qfGpMR1DmdVbadCSG
         BIKcOTkFKC//QdEzVb7IA7MqPZGTOytFKxJjcp1N47YUOTYzUG5MxoNJbJbLd6qMwh
         BMT8nyjEeTAkpFAYHT4s/x+QdlnTYplVKEFHGT5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Fox Chen <mhchen@golf.ccl.itri.org.tw>,
        de Melo <acme@conectiva.com.br>,
        Gustavo Niemeyer <niemeyer@conectiva.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/323] wl3501_cs: Fix misspelling and provide missing documentation
Date:   Wed,  9 Aug 2023 12:37:50 +0200
Message-ID: <20230809103659.588179963@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

[ Upstream commit 8b8a6f8c3b50193d161c598a6784e721128d6dc3 ]

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/net/wireless/wl3501_cs.c:57:
 drivers/net/wireless/wl3501_cs.c:143: warning: Function parameter or member 'reg_domain' not described in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:143: warning: Excess function parameter 'reg_comain' description in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:469: warning: Function parameter or member 'data' not described in 'wl3501_send_pkt'
 drivers/net/wireless/wl3501_cs.c:469: warning: Function parameter or member 'len' not described in 'wl3501_send_pkt'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Fox Chen <mhchen@golf.ccl.itri.org.tw>
Cc: de Melo <acme@conectiva.com.br>
Cc: Gustavo Niemeyer <niemeyer@conectiva.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20201102112410.1049272-25-lee.jones@linaro.org
Stable-dep-of: 391af06a02e7 ("wifi: wl3501_cs: Fix an error handling path in wl3501_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/wl3501_cs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 5b2383270627c..c6d1a320e244f 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -133,7 +133,7 @@ static const struct {
 
 /**
  * iw_valid_channel - validate channel in regulatory domain
- * @reg_comain: regulatory domain
+ * @reg_domain: regulatory domain
  * @channel: channel to validate
  *
  * Returns 0 if invalid in the specified regulatory domain, non-zero if valid.
@@ -457,11 +457,9 @@ static int wl3501_pwr_mgmt(struct wl3501_card *this, int suspend)
 /**
  * wl3501_send_pkt - Send a packet.
  * @this: Card
- *
- * Send a packet.
- *
- * data = Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
+ * @data: Ethernet raw frame.  (e.g. data[0] - data[5] is Dest MAC Addr,
  *                                   data[6] - data[11] is Src MAC Addr)
+ * @len: Packet length
  * Ref: IEEE 802.11
  */
 static int wl3501_send_pkt(struct wl3501_card *this, u8 *data, u16 len)
-- 
2.39.2



