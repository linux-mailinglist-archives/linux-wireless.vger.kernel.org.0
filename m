Return-Path: <linux-wireless+bounces-2440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3AA83A592
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D83B2E2BC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2618917C61;
	Wed, 24 Jan 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BGt/Glqm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767417C6C
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088912; cv=none; b=nKKABLtCvhn+NavN5D7DFwiLwzoAQw5yxRVrP4RUDwIu+B3laNvxhC4610+n3WSLhF/v3VjY+3NjAkFVwOavWTk0423pSI4qbPPAubsfA3vuHVVEFllRGjyQhSESILy+UX0UPNBbh+T279pzJ/v42hLQVG2omDJ76Xp+kSU86Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088912; c=relaxed/simple;
	bh=yRcifRrtNWfdlBTleMgow/seVYvpWcqtJchW2aF/qzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+ZjU2vnZoKoZbu38m0AEUBMKptfjiz20p+QuEgQrdhHfeIEGsvkzhcnv6Dn6RzAiM3emSRPYwGxqAgBKo1+Kk+i5Rqj/PqH0cKW6YZnu7xVgQHgbaMicBfkPpgV30SqqDHoVle45GMcWhgJJ2CWzV5zT8UR6GmJVE2Ge85W1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=BGt/Glqm; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward204a.mail.yandex.net (Yandex) with ESMTPS id 94D7B654FB
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 12:28:47 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:60a:0:640:350:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id A650160B02;
	Wed, 24 Jan 2024 12:28:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bSPeea8tBW20-mwjdcx7m;
	Wed, 24 Jan 2024 12:28:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706088519; bh=nQpItN+A/S3kBce8ijgjq4QSrgh7Lj2nkweMq53uBhg=;
	h=In-Reply-To:Cc:References:To:Message-ID:Date:Subject:From;
	b=BGt/GlqmB7ukG5DaZw0YSa8925EXQSpMelTk06+TPmYaXm2A09BrSjJdk0wNk9x5o
	 cwiMUW43oa8B0qbjee5XqRX60AsRY8mhM0FXaZBxkHj+4IHDQtVhB9tZozlIEZxAL8
	 Zzu8lmGFLg8jx2C2BO0Rx60GfhSfSbMONfOjogBI=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] [v4] wifi: brcmfmac: handle possible PCI irq handling errors
Date: Wed, 24 Jan 2024 12:27:10 +0300
Message-ID: <20240124092738.186493-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124092738.186493-1-dmantipov@yandex.ru>
References: <18d3a47bb20.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20240124092738.186493-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to newer 'pci_{alloc,feee}_irq_vectors()' API and handle
possible errors in 'brcmf_pcie_request_irq()'. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: prefer devm_{devm_request_threaded_irq,free_irq}()', use
'pci_irq_vector()' and fix title (Arend, Bjorn)
v3: switch to 'pci_{alloc,feee}_irq_vectors()' per Bjorn's review
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


