Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA9F78673E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 07:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbjHXFyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 01:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjHXFyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 01:54:14 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9C10E0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 22:54:07 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:287:0:640:7dd6:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 46AE0600C2;
        Thu, 24 Aug 2023 08:54:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3sDNeg0WnqM0-akqvJSOX;
        Thu, 24 Aug 2023 08:54:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692856444;
        bh=ViNyuKby6APPsFdcPz/t0WI7uk0vYoOjhkTYc2bDucE=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ePc5tJz+bKJY1GRLGp7Yz35q3j+ea/ffvEN75K9PYBfEm4BjbhIUmMhjlXXoPDFzF
         rqyckpUrE7XWL5fmpRWZx4mL2GcUyY7xEUwkC/RihcELzuVJGvy9203KR4R+VYG5nK
         S4gZ4Q/vuo+BBNW+unj6LhPv/s67bczTOr5KOVNg=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/6] [v3] wifi: ath10k: cleanup CE ring initialization
Date:   Thu, 24 Aug 2023 08:51:06 +0300
Message-ID: <20230824055117.42309-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
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

Commit 25d0dbcbd5c7 ("ath10k: split ce initialization and allocation")
changes 'ath10k_ce_init_src_ring()' and 'ath10k_ce_init_dest_ring()'
so these functions can't return -ENOMEM but always returns 0. This way
both of them may be converted to 'void', and 'ath10k_ce_init_pipe()'
may be simplified accordingly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: split to smaller units per Jeff's suggestion
v2: change 'ath10k_ce_alloc_rri()' to return -ENOMEM in case
of 'dma_alloc_coherent()' failure and fix error handling in
'ath10k_snoc_hif_power_up()'
---
 drivers/net/wireless/ath/ath10k/ce.c | 38 ++++++++--------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index c27b8204718a..ace92c636733 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1352,9 +1352,9 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar)
 }
 EXPORT_SYMBOL(ath10k_ce_enable_interrupts);
 
-static int ath10k_ce_init_src_ring(struct ath10k *ar,
-				   unsigned int ce_id,
-				   const struct ce_attr *attr)
+static void ath10k_ce_init_src_ring(struct ath10k *ar,
+				    unsigned int ce_id,
+				    const struct ce_attr *attr)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
@@ -1389,13 +1389,11 @@ static int ath10k_ce_init_src_ring(struct ath10k *ar,
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "boot init ce src ring id %d entries %d base_addr %pK\n",
 		   ce_id, nentries, src_ring->base_addr_owner_space);
-
-	return 0;
 }
 
-static int ath10k_ce_init_dest_ring(struct ath10k *ar,
-				    unsigned int ce_id,
-				    const struct ce_attr *attr)
+static void ath10k_ce_init_dest_ring(struct ath10k *ar,
+				     unsigned int ce_id,
+				     const struct ce_attr *attr)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
@@ -1427,8 +1425,6 @@ static int ath10k_ce_init_dest_ring(struct ath10k *ar,
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "boot ce dest ring id %d entries %d base_addr %pK\n",
 		   ce_id, nentries, dest_ring->base_addr_owner_space);
-
-	return 0;
 }
 
 static int ath10k_ce_alloc_shadow_base(struct ath10k *ar,
@@ -1662,25 +1658,11 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
 int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
 			const struct ce_attr *attr)
 {
-	int ret;
-
-	if (attr->src_nentries) {
-		ret = ath10k_ce_init_src_ring(ar, ce_id, attr);
-		if (ret) {
-			ath10k_err(ar, "Failed to initialize CE src ring for ID: %d (%d)\n",
-				   ce_id, ret);
-			return ret;
-		}
-	}
+	if (attr->src_nentries)
+		ath10k_ce_init_src_ring(ar, ce_id, attr);
 
-	if (attr->dest_nentries) {
-		ret = ath10k_ce_init_dest_ring(ar, ce_id, attr);
-		if (ret) {
-			ath10k_err(ar, "Failed to initialize CE dest ring for ID: %d (%d)\n",
-				   ce_id, ret);
-			return ret;
-		}
-	}
+	if (attr->dest_nentries)
+		ath10k_ce_init_dest_ring(ar, ce_id, attr);
 
 	return 0;
 }
-- 
2.41.0

