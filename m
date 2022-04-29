Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD125152A6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379752AbiD2RuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379365AbiD2RuM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:50:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1822B32
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 10:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEDC9B8376A
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 17:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72581C385AE;
        Fri, 29 Apr 2022 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254410;
        bh=uJDd/n2LaMKoOouIk+NOw2K/Es5hcm1dmLHd+mCx3SA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5zoo4UuDRhlSFfaWzBK9TZ+3KZA9fq18jtSMly8mJtfaOdk3qs8lb7+QsOcaOmKU
         4ivM2+QsqqAAxBsUW05STiskLbAJEH/TxiIyBe9DoHjpjNmRlptWw+9lGSOP8OlFMU
         WnivSzl34orqcrJLDgEPOfP0gOlENtcN/F3TGDg1Hc1vp23+4UFEpBjM+RUpKk9VVx
         EpvwN31L9NoW73HtIns4bISyudk8EpxGZixbbWDGQ7MoKzqW2Y1VYBc/sKLHPYROjk
         hqmYdIhFjoXDGlWLr68uOL9cDYT5rFVywuDvfr8skJPTI/HA2HFdM/ozVuPXZUI6hE
         MZK2WZc6mYeSw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        ath10k@lists.infradead.org
Subject: [PATCH wireless-next 2/3] wifi: ath10k: remove a copy of the NAPI_POLL_WEIGHT define
Date:   Fri, 29 Apr 2022 10:46:42 -0700
Message-Id: <20220429174643.196994-3-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429174643.196994-1-kuba@kernel.org>
References: <20220429174643.196994-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Defining local versions of NAPI_POLL_WEIGHT with the same
values in the drivers just makes refactoring harder.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kvalo@kernel.org
CC: ath10k@lists.infradead.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath10k/core.h | 3 ---
 drivers/net/wireless/ath/ath10k/pci.c  | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
 drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 9f6680b3be0a..8bfabbcfdb14 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -59,9 +59,6 @@
 #define ATH10K_KEEPALIVE_MAX_IDLE 3895
 #define ATH10K_KEEPALIVE_MAX_UNRESPONSIVE 3900
 
-/* NAPI poll budget */
-#define ATH10K_NAPI_BUDGET      64
-
 /* SMBIOS type containing Board Data File Name Extension */
 #define ATH10K_SMBIOS_BDF_EXT_TYPE 0xF8
 
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 4d4e2f91e15c..bf1c938be7d0 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3216,7 +3216,7 @@ static void ath10k_pci_free_irq(struct ath10k *ar)
 void ath10k_pci_init_napi(struct ath10k *ar)
 {
 	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_pci_napi_poll,
-		       ATH10K_NAPI_BUDGET);
+		       NAPI_POLL_WEIGHT);
 }
 
 static int ath10k_pci_init_irq(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 73693c66cef1..24283c02a5ef 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2532,7 +2532,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 	}
 
 	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll,
-		       ATH10K_NAPI_BUDGET);
+		       NAPI_POLL_WEIGHT);
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "sdio new func %d vendor 0x%x device 0x%x block 0x%x/0x%x\n",
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 8328966a0471..607e8164bf98 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1243,7 +1243,7 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 static void ath10k_snoc_init_napi(struct ath10k *ar)
 {
 	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_snoc_napi_poll,
-		       ATH10K_NAPI_BUDGET);
+		       NAPI_POLL_WEIGHT);
 }
 
 static int ath10k_snoc_request_irq(struct ath10k *ar)
-- 
2.34.1

