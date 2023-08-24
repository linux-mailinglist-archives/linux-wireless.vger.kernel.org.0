Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C759478673C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 07:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbjHXFye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 01:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbjHXFyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 01:54:14 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6108710F9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 22:54:09 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:287:0:640:7dd6:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 04E0F60063;
        Thu, 24 Aug 2023 08:54:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3sDNeg0WnqM0-xGsbjdQd;
        Thu, 24 Aug 2023 08:54:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692856447;
        bh=oh9W3M7y187CgNixsmZzPqmL/X2eyKM3vT2RWq4pKSs=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=op8PSicThLMUl5cZdH/QKdjJwPi3ixcCK5DkGXYKqjN86Cg2eZlziAkHJ/sHbs0LS
         JWaQbGh4lbZjEE3Swe7PPXLk5rnfZ3iyRZSRVD7l9kiL8LtJYXzyU32ib5Ca15r61x
         ZUiwzxNRJtpsjoGlZh/Ufcp7ziOQszyZO2bT2qR0=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 4/6] [v3] wifi: ath10k: do not ignore possible dma_alloc_coherent() error
Date:   Thu, 24 Aug 2023 08:51:09 +0300
Message-ID: <20230824055117.42309-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824055117.42309-1-dmantipov@yandex.ru>
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
 <20230824055117.42309-1-dmantipov@yandex.ru>
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

Change 'ath10k_ce_alloc_rri()' to return -ENOMEM in case
of 'dma_alloc_coherent()' failure and fix error handling in
'ath10k_snoc_hif_power_up()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: split from the larger v2 patch
---
 drivers/net/wireless/ath/ath10k/ce.c   | 6 ++++--
 drivers/net/wireless/ath/ath10k/ce.h   | 2 +-
 drivers/net/wireless/ath/ath10k/snoc.c | 9 ++++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 73aa3632b23c..d7275dcc1f99 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1906,7 +1906,7 @@ int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id,
 }
 EXPORT_SYMBOL(ath10k_ce_alloc_pipe);
 
-void ath10k_ce_alloc_rri(struct ath10k *ar)
+int ath10k_ce_alloc_rri(struct ath10k *ar)
 {
 	int i;
 	u32 value;
@@ -1919,7 +1919,7 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
 					   &ce->paddr_rri, GFP_KERNEL);
 
 	if (!ce->vaddr_rri)
-		return;
+		return -ENOMEM;
 
 	ath10k_ce_write32(ar, ar->hw_ce_regs->ce_rri_low,
 			  lower_32_bits(ce->paddr_rri));
@@ -1934,6 +1934,8 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
 		value |= ar->hw_ce_regs->upd->mask;
 		ath10k_ce_write32(ar, ce_base_addr + ctrl1_regs, value);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL(ath10k_ce_alloc_rri);
 
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index a0b408176f7f..c90c00316356 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -262,7 +262,7 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar);
 void ath10k_ce_dump_registers(struct ath10k *ar,
 			      struct ath10k_fw_crash_data *crash_data);
 
-void ath10k_ce_alloc_rri(struct ath10k *ar);
+int ath10k_ce_alloc_rri(struct ath10k *ar);
 void ath10k_ce_free_rri(struct ath10k *ar);
 
 /* ce_attr.flags values */
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 815df15f58fb..b3acb6ad6f45 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1074,10 +1074,17 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 		goto err_hw_power_off;
 	}
 
-	ath10k_ce_alloc_rri(ar);
+	ret = ath10k_ce_alloc_rri(ar);
+	if (ret)
+		goto err_snoc_wlan_disable;
 
 	ath10k_snoc_init_pipes(ar);
 
+	return 0;
+
+err_snoc_wlan_disable:
+	ath10k_snoc_wlan_disable(ar);
+
 err_hw_power_off:
 	ath10k_hw_power_off(ar);
 
-- 
2.41.0

