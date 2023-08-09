Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D2A775AE5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 13:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjHILMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjHILMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 07:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7708ED;
        Wed,  9 Aug 2023 04:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8536E63154;
        Wed,  9 Aug 2023 11:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3D1C433CA;
        Wed,  9 Aug 2023 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579549;
        bh=yNkkAd/TOLhU/L4JhK0RzFlNx/oiY0ALWPBkXaq1tWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NT9EGW6YsFRhe/GSMAnorHibIXn7vT28h2e3uI8mzkuToo7sqTQ0C3II8my3i+K7o
         FkPf9Gau2viFev/kAh3DchLvpo0arXuo28CRM/6HAWh2DTx6ziBHVrXJfMC5IzKnEg
         pv9zF6iZTpZv7i/2lNWTSOP1wpZYPWf6+kdyStPE=
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
Subject: [PATCH 4.19 030/323] wl3501_cs: Fix a bunch of formatting issues related to function docs
Date:   Wed,  9 Aug 2023 12:37:48 +0200
Message-ID: <20230809103659.504968914@linuxfoundation.org>
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

[ Upstream commit 2307d0bc9d8b60299f255d1771ce0d997162a957 ]

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/net/wireless/wl3501_cs.c:57:
 drivers/net/wireless/wl3501_cs.c:143: warning: Function parameter or member 'reg_domain' not described in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:143: warning: Function parameter or member 'channel' not described in 'iw_valid_channel'
 drivers/net/wireless/wl3501_cs.c:162: warning: Function parameter or member 'reg_domain' not described in 'iw_default_channel'
 drivers/net/wireless/wl3501_cs.c:248: warning: Function parameter or member 'this' not described in 'wl3501_set_to_wla'
 drivers/net/wireless/wl3501_cs.c:270: warning: Function parameter or member 'this' not described in 'wl3501_get_from_wla'
 drivers/net/wireless/wl3501_cs.c:467: warning: Function parameter or member 'this' not described in 'wl3501_send_pkt'
 drivers/net/wireless/wl3501_cs.c:467: warning: Function parameter or member 'data' not described in 'wl3501_send_pkt'
 drivers/net/wireless/wl3501_cs.c:467: warning: Function parameter or member 'len' not described in 'wl3501_send_pkt'
 drivers/net/wireless/wl3501_cs.c:729: warning: Function parameter or member 'this' not described in 'wl3501_block_interrupt'
 drivers/net/wireless/wl3501_cs.c:746: warning: Function parameter or member 'this' not described in 'wl3501_unblock_interrupt'
 drivers/net/wireless/wl3501_cs.c:1124: warning: Function parameter or member 'irq' not described in 'wl3501_interrupt'
 drivers/net/wireless/wl3501_cs.c:1124: warning: Function parameter or member 'dev_id' not described in 'wl3501_interrupt'
 drivers/net/wireless/wl3501_cs.c:1257: warning: Function parameter or member 'dev' not described in 'wl3501_reset'
 drivers/net/wireless/wl3501_cs.c:1420: warning: Function parameter or member 'link' not described in 'wl3501_detach'

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
Link: https://lore.kernel.org/r/20200826093401.1458456-21-lee.jones@linaro.org
Stable-dep-of: 391af06a02e7 ("wifi: wl3501_cs: Fix an error handling path in wl3501_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/wl3501_cs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index cfde9b94b4b60..78c89e6421f97 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -133,8 +133,8 @@ static const struct {
 
 /**
  * iw_valid_channel - validate channel in regulatory domain
- * @reg_comain - regulatory domain
- * @channel - channel to validate
+ * @reg_comain: regulatory domain
+ * @channel: channel to validate
  *
  * Returns 0 if invalid in the specified regulatory domain, non-zero if valid.
  */
@@ -153,7 +153,7 @@ static int iw_valid_channel(int reg_domain, int channel)
 
 /**
  * iw_default_channel - get default channel for a regulatory domain
- * @reg_comain - regulatory domain
+ * @reg_domain: regulatory domain
  *
  * Returns the default channel for a regulatory domain
  */
@@ -236,6 +236,7 @@ static int wl3501_get_flash_mac_addr(struct wl3501_card *this)
 
 /**
  * wl3501_set_to_wla - Move 'size' bytes from PC to card
+ * @this: Card
  * @dest: Card addressing space
  * @src: PC addressing space
  * @size: Bytes to move
@@ -258,6 +259,7 @@ static void wl3501_set_to_wla(struct wl3501_card *this, u16 dest, void *src,
 
 /**
  * wl3501_get_from_wla - Move 'size' bytes from card to PC
+ * @this: Card
  * @src: Card addressing space
  * @dest: PC addressing space
  * @size: Bytes to move
@@ -454,7 +456,7 @@ static int wl3501_pwr_mgmt(struct wl3501_card *this, int suspend)
 
 /**
  * wl3501_send_pkt - Send a packet.
- * @this - card
+ * @this: Card
  *
  * Send a packet.
  *
@@ -722,7 +724,7 @@ static void wl3501_mgmt_scan_confirm(struct wl3501_card *this, u16 addr)
 
 /**
  * wl3501_block_interrupt - Mask interrupt from SUTRO
- * @this - card
+ * @this: Card
  *
  * Mask interrupt from SUTRO. (i.e. SUTRO cannot interrupt the HOST)
  * Return: 1 if interrupt is originally enabled
@@ -739,7 +741,7 @@ static int wl3501_block_interrupt(struct wl3501_card *this)
 
 /**
  * wl3501_unblock_interrupt - Enable interrupt from SUTRO
- * @this - card
+ * @this: Card
  *
  * Enable interrupt from SUTRO. (i.e. SUTRO can interrupt the HOST)
  * Return: 1 if interrupt is originally enabled
@@ -1113,8 +1115,8 @@ static inline void wl3501_ack_interrupt(struct wl3501_card *this)
 
 /**
  * wl3501_interrupt - Hardware interrupt from card.
- * @irq - Interrupt number
- * @dev_id - net_device
+ * @irq: Interrupt number
+ * @dev_id: net_device
  *
  * We must acknowledge the interrupt as soon as possible, and block the
  * interrupt from the same card immediately to prevent re-entry.
@@ -1252,7 +1254,7 @@ static int wl3501_close(struct net_device *dev)
 
 /**
  * wl3501_reset - Reset the SUTRO.
- * @dev - network device
+ * @dev: network device
  *
  * It is almost the same as wl3501_open(). In fact, we may just wl3501_close()
  * and wl3501_open() again, but I wouldn't like to free_irq() when the driver
@@ -1415,7 +1417,7 @@ static struct iw_statistics *wl3501_get_wireless_stats(struct net_device *dev)
 
 /**
  * wl3501_detach - deletes a driver "instance"
- * @link - FILL_IN
+ * @link: FILL_IN
  *
  * This deletes a driver "instance". The device is de-registered with Card
  * Services. If it has been released, all local data structures are freed.
-- 
2.39.2



