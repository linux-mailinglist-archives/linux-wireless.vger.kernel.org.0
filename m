Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DA6E76FF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjDSKC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjDSKCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A349E19B9
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:12 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exuMm+bddySeIvoR2hVGEeArp9snx7hybGttDvRfkqE=;
        b=NOAMDIyAzgj4bhm7FtidSE4piFH5XdEFTtMO28DtWWek8yB2Z/qovXNPESrGyLqJyPt/GP
        5A04C1vz35ahekCKZgAQdyfPpjJ9lSbuoWBf5/G82ImzhvJ2kwGFxYIW6km0pmyK+m6fw/
        yeV8Lv9ItU3Mhx65oz2ZeP9Of30DEummCcOXSdxhLD1ZldzNPV702AIuLtxUODln7Re+EA
        QVcvDZd37GqXN3YTUdhParB5ryrZZjfhxvCkKx7h1UmAxbk7bvQPZ3+rw7RQKQHyUs64gw
        oXgo6xGKVTpkzWW6rzPfn/SF0QXUc2X1mEJGBsNnXoWussuxIpXhzW309NcEGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exuMm+bddySeIvoR2hVGEeArp9snx7hybGttDvRfkqE=;
        b=PBnN3akVEArHESvo7UCP1KvsV289n6GdeF01xGuBM76yqj7JGfINwh5SvsuIbzhZovbazm
        TeXmMTlheq1F3NBA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 02/18] wifi: rtl8xxxu: Select correct queue for beacon frames
Date:   Wed, 19 Apr 2023 12:01:29 +0200
Message-Id: <20230419100145.159191-3-martin.kaistra@linutronix.de>
In-Reply-To: <20230419100145.159191-1-martin.kaistra@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the special beacon queue for beacon frames instead of the management
frame queue. They will be put in a special area called reserved page and
send out periodically when in AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index b2be89c35d914..2c2513cee3a63 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4931,7 +4931,9 @@ static u32 rtl8xxxu_queue_select(struct ieee80211_hdr *hdr, struct sk_buff *skb)
 {
 	u32 queue;
 
-	if (ieee80211_is_mgmt(hdr->frame_control))
+	if (unlikely(ieee80211_is_beacon(hdr->frame_control)))
+		queue = TXDESC_QUEUE_BEACON;
+	else if (ieee80211_is_mgmt(hdr->frame_control))
 		queue = TXDESC_QUEUE_MGNT;
 	else
 		queue = rtl8xxxu_80211_to_rtl_queue(skb_get_queue_mapping(skb));
-- 
2.30.2

