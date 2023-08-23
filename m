Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2B7854A6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjHWJxt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjHWJwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 05:52:23 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289271FCF
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 02:50:29 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3990:0:640:62ef:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id E2B3F6010E;
        Wed, 23 Aug 2023 12:50:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LoGi0T0DTa60-yC5vvhzy;
        Wed, 23 Aug 2023 12:50:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692784226;
        bh=q+qPcbN7au+g9saLrQ1D84cB6n5FhSrF4VZ0aZgeSIc=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=JyTcsDASHoWuw2Mlonae6sSJpuog9+2QCJZJg31bybBcgDM4GnejV/cUU/HINVAkU
         JmUTvifc13bd0poKybyD/24iVlnrCCoiKUhXi7UKYfs1VrmrIfvEEH0/ApjzbtDxxs
         9oiA54LnguC5MJ6ErUXvMi0iYieiWgfQZv0VA+Ok=
Authentication-Results: mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v2] wifi: ath10k: simplify ath10k_pci_pm_suspend()
Date:   Wed, 23 Aug 2023 12:50:05 +0300
Message-ID: <20230823095008.50515-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823095008.50515-1-dmantipov@yandex.ru>
References: <20230823095008.50515-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'ath10k_pci_suspend()' always returns 0, it may be converted to
'void' and 'ath10k_pci_pm_suspend()' may be simplified accordingly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
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

