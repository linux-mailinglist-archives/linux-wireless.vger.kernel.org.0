Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46EA7265A0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 18:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjFGQQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFGQQm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 12:16:42 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE6F1BF8
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 09:16:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id EF1C560045;
        Wed,  7 Jun 2023 19:16:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KGX7fTADXSw0-rF2zrjxU;
        Wed, 07 Jun 2023 19:16:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686154598;
        bh=cZjh3SNsHicEetTbgG/03B9ec8uS3ctpisatKaG6ePU=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=DOnLbSusrLhFJEVU5kDThvzwHvORI6dNFMvXebkKbRRwOcxwk2rl4jM4lKEuf3eVo
         R29AWfvczFYFdEebw4lXfAgI8TAcmu29LjUbbo0ZJvlPoPLOhcJysA8DWn9ZTmsbZ1
         feaghkCzE9/NhW4358TirOt//QOc1cUp6+dKnfrk=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] wifi: brcmfmac: handle possible MSI enabling error
Date:   Wed,  7 Jun 2023 19:16:10 +0300
Message-Id: <20230607161611.85106-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607161611.85106-1-dmantipov@yandex.ru>
References: <20230607161611.85106-1-dmantipov@yandex.ru>
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
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 80220685f5e4..4d61f241cfaf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -965,6 +965,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
 
 static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 {
+	int ret;
 	struct pci_dev *pdev = devinfo->pdev;
 	struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
 
@@ -972,16 +973,20 @@ static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 
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
+		ret = 0;
 	}
-	devinfo->irq_allocated = true;
-	return 0;
+	return ret;
 }
 
 
-- 
2.40.1

