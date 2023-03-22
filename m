Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E341E6C5242
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCVRUL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCVRTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB49667707
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:35 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0awDbNe7WfoBmz83PWLYWgodgMNnR2l1+km1lsMkXbQ=;
        b=tVMKmG4N+tlgYrwDUQ9ejRZC9Hf0XDMKizvnBFbY3IZkqVga9SOW8XdT/2zGzAThFLUmlW
        a5+hBMRhWTcSgTCgr7do1nkIP+LvQifoStP8dQhGiT+O2fYxQWSV4rFWWx8uQgEe2CNUc+
        92be5rxGyAF2fyHx65055nt3ZPiMO6uEuiV7stKnNUPNvtmQI+OWuROqaxU1c2AkFSqMbW
        7aTRmy6XzHWPZRvhIpT/Pur6yHxt51F+EpNhukCl64w7GNYWJRpuF2YYKXhQg//9lfOiGx
        6uCkXgHSxnvb0dXBNzJYY97D7JbRD3uoRdvcwnc7bUCpb+aUYm4zvHzGWskqxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0awDbNe7WfoBmz83PWLYWgodgMNnR2l1+km1lsMkXbQ=;
        b=ISq2LVuyknD0QnVMoJ4MkQgi9aoQdKvTmUKVVHDsc75EwUXktfnnp6MhSl8tzY7MnsAyoh
        5pQ0L5EgfUSW9LCA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 02/14] wifi: rtl8xxxu: Select correct queue for beacon frames
Date:   Wed, 22 Mar 2023 18:18:53 +0100
Message-Id: <20230322171905.492855-3-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-1-martin.kaistra@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the special beacon queue for beacon frames instead of the management
frame queue, so that the HW sends them periodically instead of only
once.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 90b98b9dcbd9d..daeaa7d6864f9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4941,7 +4941,9 @@ static u32 rtl8xxxu_queue_select(struct ieee80211_hdr *hdr, struct sk_buff *skb)
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

