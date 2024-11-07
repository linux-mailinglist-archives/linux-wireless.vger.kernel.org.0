Return-Path: <linux-wireless+bounces-15086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922619C0797
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C7B22A18
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3C20F5B1;
	Thu,  7 Nov 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J102/wJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CF2114
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986424; cv=none; b=chCd8uf4oRYQxwsCZ+7cRrhzWIRrC9iTFxt0FPM2vTjkql5oN8W8D4HiWsGlFhKmyfhmruZCn56UtaPcD3MVh5yKJ+KEZirgEJ55BvfXSpvDz7D1gZwrkp9eb/K+pOhejnNXuBAOw6E7WJOiC/R9tkPO8nPn18UgcSmi3c7oA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986424; c=relaxed/simple;
	bh=qmyB7RvdNqhL2/+qnrBNdaUlxHQQWE3vlW1VezqLvis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0gCY5p3PVmEjDIQqOh6SXglj4+EIONK3nbB7omBjsDhw/3Ys4KhBQJaFTTdQf462UXNrxWkoAXQIuh1ZVgPtLEElIOoCKqOL32t540oFa3RhxJxmihzUiWbOQsq1qWIa99QWq8Ghd8a15e7eMLaQU59AG04Wc7fhrCISWt9ERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J102/wJs; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LYDXE076F/eAzArSQ+e5oOtPnWZO9qzk5KrLH/ONKm8=; b=J102/wJsHWOKpgqUSN+3lX3Pt/
	p6bh77QkutAXPs4z/AGnDrNTYv0AABzNNHA+exVtY7D0P6+QmS7loOWH4AQGXPaD4Frk/zlKoU0u4
	SbOYyuU490Jn6wmuKWcZpcfSnOZv4CNrhSexVFHoVy79MTJwlsrLU7rnMCAHbE98yKs0fUW9+iw+q
	eXYVXjJmIsybSpgaaLlrYW6hL8WOSFKSZxArN2Fc7ZphwPY4l2hYGQbuCAwnPd529cJqv86fPnyiG
	uW1PBRuioF3soSWF4GeyOkyrb43W/j+q5a6V3Z1u4MEuPNgvgg/ETKeYFHZOHcOBDyzSgd+4FvK/J
	fARSBk+Q==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t92dm-003Zsz-F8; Thu, 07 Nov 2024 14:33:39 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net 1/5] wifi: rtlwifi: do not complete firmware loading needlessly
Date: Thu,  7 Nov 2024 10:33:18 -0300
Message-Id: <20241107133322.855112-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107133322.855112-1-cascardo@igalia.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only code waiting for completion is driver removal, which will not be
called when probe returns a failure. So this completion is unnecessary.

Fixes: b0302aba812b ("rtlwifi: Convert to asynchronous firmware load")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 11709b6c83f1..40fc3c297a8a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -2266,7 +2266,6 @@ int rtl_pci_probe(struct pci_dev *pdev,
 		pci_iounmap(pdev, (void __iomem *)rtlpriv->io.pci_mem_start);
 
 	pci_release_regions(pdev);
-	complete(&rtlpriv->firmware_loading_complete);
 
 fail1:
 	if (hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index d37a017b2b81..c3aa0cd9ff21 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1040,7 +1040,6 @@ int rtl_usb_probe(struct usb_interface *intf,
 error_out2:
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(udev);
-	complete(&rtlpriv->firmware_loading_complete);
 	kfree(rtlpriv->usb_data);
 	ieee80211_free_hw(hw);
 	return -ENODEV;
-- 
2.34.1


