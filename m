Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8A72F721
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbjFNH7K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 03:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjFNH7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 03:59:06 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C65CD
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 00:59:04 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2d23:0:640:2dd6:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 2F9D460137;
        Wed, 14 Jun 2023 10:59:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id owVk0cNWxSw0-mdOT1Vws;
        Wed, 14 Jun 2023 10:59:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686729542;
        bh=T3af1EX5TOSDHmdi4O+2cmbHadtXfJLEHnRUhWJsa24=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ZFoB2mbmlE7TtWVsb9OF2bBPJPsLSzMql9u60S8IYwhVWNPEAtD7Sr7kjWbyLTMwG
         +kYOBRcPeL388jaN9SilUgIXR3Az8XaYJdFht31twrVZuajjhneL2dSglmJEiy/b12
         vjF2ynM1ersQ0hhAMvEKdnrzBYgio6pcLhBQbcn8=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] [v2] wifi: brcmfmac: handle possible MSI enabling error
Date:   Wed, 14 Jun 2023 10:58:48 +0300
Message-Id: <20230614075848.80536-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614075848.80536-1-dmantipov@yandex.ru>
References: <20230614075848.80536-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle possible 'pci_enable_msi()' error in
'brcmf_pcie_request_irq()', adjust related code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: rebase against wireless-next tree
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 80220685f5e4..f7d9f2cbd60b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -965,6 +965,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
 
 static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 {
+	int ret;
 	struct pci_dev *pdev = devinfo->pdev;
 	struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
 
@@ -972,16 +973,19 @@ static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 
 	brcmf_dbg(PCIE, "Enter\n");
 
-	pci_enable_msi(pdev);
+	ret = pci_enable_msi(pdev);
+	if (ret)
+		return ret;
 	if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
 				 brcmf_pcie_isr_thread, IRQF_SHARED,
 				 "brcmf_pcie_intr", devinfo)) {
 		pci_disable_msi(pdev);
 		brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
-		return -EIO;
+		ret = -EIO;
+	} else {
+		devinfo->irq_allocated = true;
 	}
-	devinfo->irq_allocated = true;
-	return 0;
+	return ret;
 }
 
 
-- 
2.40.1

