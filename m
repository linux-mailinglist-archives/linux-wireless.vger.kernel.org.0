Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD078673F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 07:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbjHXFyg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 01:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbjHXFyS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 01:54:18 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80910FD
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 22:54:11 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:287:0:640:7dd6:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 4126660085;
        Thu, 24 Aug 2023 08:54:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3sDNeg0WnqM0-2om0aCjB;
        Thu, 24 Aug 2023 08:54:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692856448;
        bh=FFUKQ6Ei7zGjYQOVccY1E3Qkz/VJ+5CuzK3HFA+l6nM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=PyhyFKAwGVChDnygN7Cdkc4SeIxoiCn+WFnHq/u9Mbohcs6miTbwXWV6Z6mgu5VmY
         INqIfNQFW3HgN1VOuzRrWTE/hQgCh71hYp0iAlj+G0LDbjZpA0Bsl27imR7GoKb6jq
         asBM9H2XYbIMIA0kuGQXn0FW4KGCysJsoYcbY0Z8=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6/6] [v3] wifi: ath10k: simplify ath10k_pci_pm_suspend()
Date:   Thu, 24 Aug 2023 08:51:11 +0300
Message-ID: <20230824055117.42309-6-dmantipov@yandex.ru>
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

Since 'ath10k_pci_suspend()' always returns 0, it may be converted to
'void' and 'ath10k_pci_pm_suspend()' may be simplified accordingly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: add Acked-by: otherwise unchanged
v2: adjust to match series
---
 drivers/net/wireless/ath/ath10k/pci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index f6988075cd83..16037e77264b 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2871,7 +2871,7 @@ static int ath10k_pci_hif_suspend(struct ath10k *ar)
 	return 0;
 }
 
-static int ath10k_pci_suspend(struct ath10k *ar)
+static void ath10k_pci_suspend(struct ath10k *ar)
 {
 	/* The grace timer can still be counting down and ar->ps_awake be true.
 	 * It is known that the device may be asleep after resuming regardless
@@ -2879,8 +2879,6 @@ static int ath10k_pci_suspend(struct ath10k *ar)
 	 * device is asleep before proceeding.
 	 */
 	ath10k_pci_sleep_sync(ar);
-
-	return 0;
 }
 
 static int ath10k_pci_hif_resume(struct ath10k *ar)
@@ -3734,13 +3732,9 @@ MODULE_DEVICE_TABLE(pci, ath10k_pci_id_table);
 static __maybe_unused int ath10k_pci_pm_suspend(struct device *dev)
 {
 	struct ath10k *ar = dev_get_drvdata(dev);
-	int ret;
 
-	ret = ath10k_pci_suspend(ar);
-	if (ret)
-		ath10k_warn(ar, "failed to suspend hif: %d\n", ret);
-
-	return ret;
+	ath10k_pci_suspend(ar);
+	return 0;
 }
 
 static __maybe_unused int ath10k_pci_pm_resume(struct device *dev)
-- 
2.41.0

