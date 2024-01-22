Return-Path: <linux-wireless+bounces-2325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AB8362BC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86AB2995CD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FDA3B198;
	Mon, 22 Jan 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cznQeIYe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE43A8F5
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924760; cv=none; b=YCPBzoekw5YXO/2jcsQq0IXBrLKKULwukVNsioSohdtcivEqmFyTIoTi9XFbND005isMkmiN7awlu8s3yjaG5/WBRqIWLAzLp//iEHWITFczftX3vSc318kE+UEaqK4fXnn25iZIhKgTBe+xc1e2u9FRJAEFZ1PzFSPfnAX/Icc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924760; c=relaxed/simple;
	bh=Huv2kCm8YDja61KX9wU5fTjWn3aG2BpUVHQWy+Gc8AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NU/EtTSBWptpxBz3Bf6QvtGLnwI8s5ZZEoAKvgCUdcPEyLFUy34AH4BDkjqV4Z3b1GlkZSsq5aTEYOWgChNdjgx/QkQvwpb5smp3xOJFPVCvM+ZXiqXs5OJlOgm+woHvGcJjEKUo/p4834VaCJ2N6dVbM9YlfCkN+kdPEaZJO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=cznQeIYe; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 9A5016649C
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 14:59:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2e14:0:640:2cd1:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTPS id 26C2460911;
	Mon, 22 Jan 2024 14:59:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wwPajqcAWKo0-CRuNCKaG;
	Mon, 22 Jan 2024 14:59:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705924741; bh=+1PWKl1LsQy1CAMxKEL8TW08Qy7sKzfy7KiVAJUQK8Y=;
	h=In-Reply-To:Cc:References:To:Message-ID:Date:Subject:From;
	b=cznQeIYe/57cY1hTBdto5HR6LtIz7xAOfWGr1HYlpVsH8v5ey5owAEE3J+o9UTvEI
	 fcgyxDEwlOYxwQY7jD46Ezn3Uov6YMo+arckAhN5Au9I1Lf2kxKy4aek4amtNdhKdA
	 s3V2DdfgW960f6LQD8iKDte6Cr5eBQmr7Y2Ia880=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] [v3] wifi: brcmfmac: handle possible PCIE irq handling errors
Date: Mon, 22 Jan 2024 14:57:25 +0300
Message-ID: <20240122115749.67682-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122115749.67682-1-dmantipov@yandex.ru>
References: <4cc44b07-13bd-49d0-b10f-b88875380f8c@broadcom.com>
 <20240122115749.67682-1-dmantipov@yandex.ru>
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
v3: switch to 'pci_{alloc,feee}_irq_vectors()' per Bjorn's review
v2: rebase against wireless-next tree
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 80220685f5e4..0f77d94f34a3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -965,6 +965,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
 
 static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 {
+	int ret;
 	struct pci_dev *pdev = devinfo->pdev;
 	struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
 
@@ -972,11 +973,14 @@ static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
 
 	brcmf_dbg(PCIE, "Enter\n");
 
-	pci_enable_msi(pdev);
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
 	if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
 				 brcmf_pcie_isr_thread, IRQF_SHARED,
 				 "brcmf_pcie_intr", devinfo)) {
-		pci_disable_msi(pdev);
+		pci_free_irq_vectors(pdev);
 		brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
 		return -EIO;
 	}
@@ -997,7 +1001,7 @@ static void brcmf_pcie_release_irq(struct brcmf_pciedev_info *devinfo)
 
 	brcmf_pcie_intr_disable(devinfo);
 	free_irq(pdev->irq, devinfo);
-	pci_disable_msi(pdev);
+	pci_free_irq_vectors(pdev);
 
 	msleep(50);
 	count = 0;
-- 
2.43.0


