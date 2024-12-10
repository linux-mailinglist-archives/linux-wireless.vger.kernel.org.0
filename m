Return-Path: <linux-wireless+bounces-16133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6BB9EA937
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 08:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CC28419E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 07:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AAB15C158;
	Tue, 10 Dec 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LQyhqPHh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663622617C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814218; cv=none; b=nz3QULpF4sY6xR6dI169PwB2yaH2tWeAE8FjXisMub5TNbAVd56QeIflBQ2jYUP8KMBOtzK8okHvYxU8/VfQ0sESRdrrnBs3eVT0p3BOQhpgimEf0OEYxqHowFqljvCsAt+Yfv+xLWZntPV+FjmPxq1TKWXOXS6QET8TlJ8AXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814218; c=relaxed/simple;
	bh=2T/my89Nwxxm4xJlVyG+VFmgZEyQAl1yZJ7q0gDPOEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faATd28yS/cb6Au56eTrkgpzippKe9TSvsGnN4FONfIuj1TBEWBsxAmnM8PCGXp1NYZ9WIdsO6c49Zsk7k5HOhq6LDesaSsL1gYPoyp7c/ckglE+pJr0/VWsw0by5uYevlwGLgLc+dLdiY8V+56TdvNV5pUgjLIvrv2721hRoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LQyhqPHh; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:13a7:0:640:c5cd:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 057BA60E27;
	Tue, 10 Dec 2024 10:03:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id O3gRpJ7Ol0U0-IEWUIoQW;
	Tue, 10 Dec 2024 10:03:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733814205; bh=MyfwT5xqs+4KXSPn7kqvv6bOxVko7c35TySEj+ma8Bc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LQyhqPHhikfcFwwPlZJ6f7DTrqVKU9gSBE3uexKzyBEH9BhQ2xxjoEGpTT8ii2lcI
	 DyCt/sssvyxZz3F7+lVDR8zJR4vODb4pGrgly+pkMZ0zXIQfcUvz6IkQSG66ZaeJpW
	 N7HigNRl+NxLMj+W4zTbCIHuw35dDmcTX9q8P2RE=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmfmac: handle possible pci_enable_msi() error
Date: Tue, 10 Dec 2024 10:03:20 +0300
Message-ID: <20241210070320.836260-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generally it's a good idea to handle error which may be returned from
'pci_enable_msi()', so add relevant check to 'brcmf_pcie_request_irq()'
and adjust the latter to return actual 'request_threaded_irq()' error
instead of hardcoded -EIO. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index e4395b1f8c11..f0e05cb0cfa7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -963,6 +963,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
 
 static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 {
+	int ret;
 	struct pci_dev *pdev = devinfo->pdev;
 	struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
 
@@ -970,16 +971,21 @@ static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 
 	brcmf_dbg(PCIE, "Enter\n");
 
-	pci_enable_msi(pdev);
-	if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
-				 brcmf_pcie_isr_thread, IRQF_SHARED,
-				 "brcmf_pcie_intr", devinfo)) {
+	ret = pci_enable_msi(pdev);
+	if (ret)
+		return ret;
+
+	ret = request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
+				   brcmf_pcie_isr_thread, IRQF_SHARED,
+				   "brcmf_pcie_intr", devinfo);
+	if (ret) {
 		pci_disable_msi(pdev);
 		brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
-		return -EIO;
+	} else {
+		devinfo->irq_allocated = true;
 	}
-	devinfo->irq_allocated = true;
-	return 0;
+
+	return ret;
 }
 
 
-- 
2.47.1


