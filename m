Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308756F1B1C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346264AbjD1PIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346253AbjD1PIs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC23C33
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:40 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=503AmHFJCUNZ9ebANqBvvtynjVKTNuo7BsluOwvOddA=;
        b=q8qxz4xhaHdHusvRDjXuhCv6BnC3TEkVJQ6Vp/fJ5bqU378e5z2nRnPHDlDgKfZYIPrLG5
        p/ku+LDIao0uEsY+7mVWqe8dlZFVqnrQr66yXBKPrG7Q0ekTksMknsgajpztje2KmAA2ZP
        7qaqzUqqJzpalakCq+dub74W+8Yi7D5Z9rxTuGXE+wmPMR+BSrGXrzFeq1yhOkZP6r6mgy
        lSQDa1mQfgSpY+eNLF0euhn3hHDs4axd+QJPwvFX76wWKKeSL1HMv5U3vUJu5P+qcKAbts
        Vna45mQAUo9JVSZ/M9VFtHAazwaH1goXCPdu7SJbFriWSrk0OgcbLwBFkeFy/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=503AmHFJCUNZ9ebANqBvvtynjVKTNuo7BsluOwvOddA=;
        b=u+8nFtlXma8NSLtzzHr1kITgRoK4xwD2G989S28g4ay2yZfSxUaUnd3u/1gRlNwVprTdUL
        gWoBP6x+EGSTV8AA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 02/18] wifi: rtl8xxxu: Select correct queue for beacon frames
Date:   Fri, 28 Apr 2023 17:08:17 +0200
Message-Id: <20230428150833.218605-3-martin.kaistra@linutronix.de>
In-Reply-To: <20230428150833.218605-1-martin.kaistra@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
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

