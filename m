Return-Path: <linux-wireless+bounces-2474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4D83C266
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276FD1F216F1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD24502D;
	Thu, 25 Jan 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="by8Bq9r+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205c.mail.yandex.net (forward205c.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA764502F
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184980; cv=none; b=J6HRp2kUYDFc24uV4NiEINbjd/7y6K+7rVz/jB6BkKZIc+Z9m1zDWFGIG9fwtiokQ8NPFbefHk5t3ghye+Z2ycfEi9wNpho5EHRzdJPoqXXHOqFF94iLtwoho3/clzaeK1vFfWTea4cc/csIxKq3dKy81LdH/ITXLSnyOHVx/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184980; c=relaxed/simple;
	bh=jWNcpm0HjnW055yLJwBcXPpXJcJ2Zto1bGFTojAsGqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inVdczs5ywcJITN6hR8RAEqIGdhPiqJ+7B9kmixNLVIRzfipM7i25lUmfiqoZh+iYk1+jECHsrm5stCViytQzpXpu7JZCQAuZrPorbrc8nRuGDhOHqzRIVk4c+nakEbeeiqXSdaJFr7p45Ys5SXU7qPDUAld1kDh7JDMuM6FZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=by8Bq9r+; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
	by forward205c.mail.yandex.net (Yandex) with ESMTPS id 8455665727
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 15:08:33 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2a0c:0:640:2804:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTPS id 729FE608F3;
	Thu, 25 Jan 2024 15:08:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M8TQNP9f9Os0-W4GaREYl;
	Thu, 25 Jan 2024 15:08:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706184504; bh=DhAGgHSQg3iaRjZyPsuDKQG2aidSJSftuw6sxVV6ZuA=;
	h=In-Reply-To:Cc:References:To:Message-ID:Date:Subject:From;
	b=by8Bq9r+KibpppFx51VmMKGYlZBPP0ZYY1Ezs94zQpNGTALZ9/vSjmwFaZ70qNUJI
	 McSQXXdTwWs96shztPAJuWDSJrjsS1ycFcPcPi3Pj4AINsz0OMAvHu84BbC4lNxhNV
	 qRDEamJKcrXeTvwbF9QP17Tdcjey6GtyNz7Qrkwg=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] [v4] wifi: brcmfmac: handle possible PCI irq handling errors
Date: Thu, 25 Jan 2024 15:07:29 +0300
Message-ID: <20240125120740.111330-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125120740.111330-1-dmantipov@yandex.ru>
References: <20240124133331.GA351271@bhelgaas>
 <20240125120740.111330-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to newer 'pci_{alloc,free}_irq_vectors()' API and handle
possible errors in 'brcmf_pcie_request_irq()'. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: prefer devm_{devm_request_threaded_irq,free_irq}()', use
'pci_irq_vector()' and fix title (Arend, Bjorn)
v3: switch to 'pci_{alloc,free}_irq_vectors()' per Bjorn's review
v2: rebase against wireless-next tree
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 80220685f5e4..17b855164025 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -965,6 +965,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
 
 static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 {
+	int ret;
 	struct pci_dev *pdev = devinfo->pdev;
 	struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
 
@@ -972,11 +973,16 @@ static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 
 	brcmf_dbg(PCIE, "Enter\n");
 
-	pci_enable_msi(pdev);
-	if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
-				 brcmf_pcie_isr_thread, IRQF_SHARED,
-				 "brcmf_pcie_intr", devinfo)) {
-		pci_disable_msi(pdev);
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
+	if (devm_request_threaded_irq(&pdev->dev,
+				      pci_irq_vector(pdev, 0),
+				      brcmf_pcie_quick_check_isr,
+				      brcmf_pcie_isr_thread, IRQF_SHARED,
+				      "brcmf_pcie_intr", devinfo)) {
+		pci_free_irq_vectors(pdev);
 		brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
 		return -EIO;
 	}
@@ -996,8 +1002,8 @@ static void brcmf_pcie_release_irq(struct brcmf_pciedev_info *devinfo)
 		return;
 
 	brcmf_pcie_intr_disable(devinfo);
-	free_irq(pdev->irq, devinfo);
-	pci_disable_msi(pdev);
+	devm_free_irq(&pdev->dev, pdev->irq, devinfo);
+	pci_free_irq_vectors(pdev);
 
 	msleep(50);
 	count = 0;
-- 
2.43.0


