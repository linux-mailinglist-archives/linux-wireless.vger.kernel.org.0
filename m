Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733BB5384FB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiE3PdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 11:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiE3PdQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 11:33:16 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 07:36:19 PDT
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF7139AD4;
        Mon, 30 May 2022 07:36:18 -0700 (PDT)
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 440C42008F;
        Mon, 30 May 2022 16:19:06 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3B13620054;
        Mon, 30 May 2022 16:19:06 +0200 (CEST)
Message-ID: <c1c3472427080716c69ad99ebe5d1954db44f03f.camel@freebox.fr>
Subject: Re: [PATCH v7 4/9] ath11k: Add register access logic for WCN6750
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, mka@chromium.org
Date:   Mon, 30 May 2022 16:19:06 +0200
In-Reply-To: <c57e8791-b6ce-0752-52ca-a1cb938187d7@quicinc.com>
References: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
         <20220429170502.20080-5-quic_mpubbise@quicinc.com>
         <bd6d97a4cc6665d0ee632444f75e3480160387ec.camel@freebox.fr>
         <c57e8791-b6ce-0752-52ca-a1cb938187d7@quicinc.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 30 16:19:06 2022 +0200 (CEST)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Thu, 2022-05-26 at 09:12 +0530, Manikanta Pubbisetty wrote:

> 
> Thanks for letting me know about this, IIRC I don't remember 
> encountering this problem in my testing. Just for my understanding,
> have you reverted this change and confirmed that these errors go away
> ?

I first confirmed the register location was indeed incorrect, then I
fixed it like this:

--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -143,7 +143,7 @@ EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
 static inline u32 ath11k_pcic_get_window_start(struct ath11k_base *ab,
 					       u32 offset)
 {
-	u32 window_start = 0;
+	u32 window_start = ATH11K_PCI_WINDOW_START;
 
 	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
 		window_start = ab->hw_params.dp_window_idx * ATH11K_PCI_WINDOW_START;
@@ -170,8 +170,12 @@ void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 		iowrite32(value, ab->mem  + offset);
 	} else if (ab->hw_params.static_window_map) {
 		window_start = ath11k_pcic_get_window_start(ab, offset);
-		iowrite32(value, ab->mem + window_start +
-			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		if (window_start == ATH11K_PCI_WINDOW_START &&
+                    ab->pci.ops->window_write32)
+			ab->pci.ops->window_write32(ab, offset, value);
+		else
+			iowrite32(value, ab->mem + window_start +
+				  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 	} else if (ab->pci.ops->window_write32) {
 		ab->pci.ops->window_write32(ab, offset, value);
 	}
@@ -200,8 +204,12 @@ u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 		val = ioread32(ab->mem + offset);
 	} else if (ab->hw_params.static_window_map) {
 		window_start = ath11k_pcic_get_window_start(ab, offset);
-		val = ioread32(ab->mem + window_start +
-			       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		if (window_start == ATH11K_PCI_WINDOW_START &&
+		    ab->pci.ops->window_read32)
+			val = ab->pci.ops->window_read32(ab, offset);
+		else
+			val = ioread32(ab->mem + window_start +
+				       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 	} else if (ab->pci.ops->window_read32) {
 		val = ab->pci.ops->window_read32(ab, offset);
 	}

-- 
Maxime



