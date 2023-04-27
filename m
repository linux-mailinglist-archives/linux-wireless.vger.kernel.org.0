Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F66F0318
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbjD0JKI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbjD0JJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED32120
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:46 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=503AmHFJCUNZ9ebANqBvvtynjVKTNuo7BsluOwvOddA=;
        b=Z1LrZENTfYO31Ezgm7/7Ev4t8HUQ8SfaGOq95lYCKj2N5jyqQxVTnwHmjrYj0ssuBoL2gi
        SM7SeI+I1C4VY4qk2qV81uEUYhldvFEDhvaNyYg5uX7UnweJPV0xlGgfCIgMThakT/Rl74
        nFyL5wY2mY6U12NHf3/2/a/quuCF9nYwTKv/FIb/J6/6aksE7uZW1PagOEvCEZUY4nKNtc
        4/m0XcvED3d4U8K4f8nSGyTQ8cPKXXIYwQK/pXmz/lmjA96IoOG74iekNwKN1Hsx3e4mIp
        eCul9h00fk1Y18JxjAo4blfwJdcGGjl1iWbPcWjdAvEul1sc9nXOFvC9ZHndlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=503AmHFJCUNZ9ebANqBvvtynjVKTNuo7BsluOwvOddA=;
        b=QHKRwA2CksRnZdI4B3WYH7ImZKKZ43nIrFEbRzzsMpf+GNM6upfxKvLeM71qnbN0eC1ira
        hSCGsOm6Li7lpTBA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 02/18] wifi: rtl8xxxu: Select correct queue for beacon frames
Date:   Thu, 27 Apr 2023 11:09:06 +0200
Message-Id: <20230427090922.165088-3-martin.kaistra@linutronix.de>
In-Reply-To: <20230427090922.165088-1-martin.kaistra@linutronix.de>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index b8fcf911c072e..9dc6f3ec7a305 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5010,7 +5010,9 @@ static u32 rtl8xxxu_queue_select(struct ieee80211_hdr *hdr, struct sk_buff *skb)
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

