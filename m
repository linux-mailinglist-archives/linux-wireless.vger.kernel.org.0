Return-Path: <linux-wireless+bounces-22648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BD5AAB952
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 08:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7D73A48DB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D6284B4C;
	Tue,  6 May 2025 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CjF8urrS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1862F54DD
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496452; cv=none; b=bqXFQrS3IyKYrtF7kzPFdzwbuJxoHt7JKga9Pa0OJYhpvSU0ep2f+a2Ga2ACuAIZcTsoXNmM4Hz5LvUi7wmdQ0frkfjJC1R00dCVma0tN0uEu02lBoNZdVR3dWcxyZTAzQLLIszq2O9/u8KcySFtifa4/h3LNYwZxzeSSXsPe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496452; c=relaxed/simple;
	bh=FK06ZL06rMbaJGdHo/wPRuWc6VmX/Z8DH1P9NP+cY/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IXuA6JOVoXtZRs/pAumwTMeifmhV1yW94vK3RsPuMLl6K/OvVn0xaQseRiWhFPWXDGy6pGlbMDFbfCInzPNhcoMf010OMrm9oyy07s/WOMLPoug2MtW0dafRUMrm/n74aknniaXWCOjw8I5TW8aJAIIGsU0KiT8Q61O2XJKURN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CjF8urrS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5461s3SH11543372, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746496444; bh=FK06ZL06rMbaJGdHo/wPRuWc6VmX/Z8DH1P9NP+cY/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CjF8urrSmJ+eFjGw1QOd4h0CBXJ5pBymjUUbi4Yn151Rx2P9Oy1rnA8n19OME9Yhw
	 /3VYPpfuASe1xeDseCuPb6B0UWKylM/LrKEs7pw8BisLKvq0dTFrGRhUQ/N/TnB7Ci
	 dpwh/qQUETWsogXJAA4jOqAA80+tiDxdCNIDMfL5w+wi2Hbit+uxIrSHUAiS9pkniW
	 OfgX3iKGxXMXZ6PwbuQmyc1Lt7CJ2fUnRCgpn57NDaYoSI7+MNaIOgaT0TOkiwgBjT
	 3dxCnADR5bqk6FXa5fZKRhvV+g85jm5lp+yA/2Tkb41lT0gLQ/Sdf940SDCIb81xap
	 PbgD8mw3Nzy9g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5461s3SH11543372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 09:54:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 09:54:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 May
 2025 09:54:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: pci: configure manual DAC mode via PCI config API only
Date: Tue, 6 May 2025 09:53:56 +0800
Message-ID: <20250506015356.7995-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

To support 36-bit DMA, configure chip proprietary bit via PCI config API
or chip DBI interface. However, the PCI device mmap isn't set yet and
the DBI is also inaccessible via mmap, so only if the bit can be accessible
via PCI config API, chip can support 36-bit DMA. Otherwise, fallback to
32-bit DMA.

With NULL mmap address, kernel throws trace:

  BUG: unable to handle page fault for address: 0000000000001090
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0002 [#1] PREEMPT SMP PTI
  CPU: 1 UID: 0 PID: 71 Comm: irq/26-pciehp Tainted: G           OE      6.14.2-061402-generic #202504101348
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  RIP: 0010:rtw89_pci_ops_write16+0x12/0x30 [rtw89_pci]
  RSP: 0018:ffffb0ffc0acf9d8 EFLAGS: 00010206
  RAX: ffffffffc158f9c0 RBX: ffff94865e702020 RCX: 0000000000000000
  RDX: 0000000000000718 RSI: 0000000000001090 RDI: ffff94865e702020
  RBP: ffffb0ffc0acf9d8 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000015
  R13: 0000000000000719 R14: ffffb0ffc0acfa1f R15: ffffffffc1813060
  FS:  0000000000000000(0000) GS:ffff9486f3480000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000001090 CR3: 0000000090440001 CR4: 00000000000626f0
  Call Trace:
   <TASK>
   rtw89_pci_read_config_byte+0x6d/0x120 [rtw89_pci]
   rtw89_pci_cfg_dac+0x5b/0xb0 [rtw89_pci]
   rtw89_pci_probe+0xa96/0xbd0 [rtw89_pci]
   ? __pfx___device_attach_driver+0x10/0x10
   ? __pfx___device_attach_driver+0x10/0x10
   local_pci_probe+0x47/0xa0
   pci_call_probe+0x5d/0x190
   pci_device_probe+0xa7/0x160
   really_probe+0xf9/0x370
   ? pm_runtime_barrier+0x55/0xa0
   __driver_probe_device+0x8c/0x140
   driver_probe_device+0x24/0xd0
   __device_attach_driver+0xcd/0x170
   bus_for_each_drv+0x99/0x100
   __device_attach+0xb4/0x1d0
   device_attach+0x10/0x20
   pci_bus_add_device+0x59/0x90
   pci_bus_add_devices+0x31/0x80
   pciehp_configure_device+0xaa/0x170
   pciehp_enable_slot+0xd6/0x240
   pciehp_handle_presence_or_link_change+0xf1/0x180
   pciehp_ist+0x162/0x1c0
   irq_thread_fn+0x24/0x70
   irq_thread+0xef/0x1c0
   ? __pfx_irq_thread_fn+0x10/0x10
   ? __pfx_irq_thread_dtor+0x10/0x10
   ? __pfx_irq_thread+0x10/0x10
   kthread+0xfc/0x230
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x47/0x70
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Fixes: 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/ccaf49b6-ff41-4917-90f1-f53cadaaa0da@gmail.com/T/#u
Closes: https://github.com/openwrt/openwrt/issues/17025
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 34 ++++++++++++++++--------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c2fe5a898dc7..b5cdc18f802a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3105,17 +3105,26 @@ static bool rtw89_pci_is_dac_compatible_bridge(struct rtw89_dev *rtwdev)
 	return false;
 }
 
-static void rtw89_pci_cfg_dac(struct rtw89_dev *rtwdev)
+static int rtw89_pci_cfg_dac(struct rtw89_dev *rtwdev, bool force)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+	int ret;
+	u8 val;
 
-	if (!rtwpci->enable_dac)
-		return;
+	if (!rtwpci->enable_dac && !force)
+		return 0;
 
 	if (!rtw89_pci_chip_is_manual_dac(rtwdev))
-		return;
+		return 0;
 
-	rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_L1_CTRL, RTW89_PCIE_BIT_EN_64BITS);
+	/* Configure DAC only via PCI config API, not DBI interfaces */
+	ret = pci_read_config_byte(pdev, RTW89_PCIE_L1_CTRL, &val);
+	if (ret)
+		return ret;
+
+	val |= RTW89_PCIE_BIT_EN_64BITS;
+	return pci_write_config_byte(pdev, RTW89_PCIE_L1_CTRL, val);
 }
 
 static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
@@ -3133,13 +3142,16 @@ static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
 	}
 
 	if (!rtw89_pci_is_dac_compatible_bridge(rtwdev))
-		goto no_dac;
+		goto try_dac_done;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
 	if (!ret) {
-		rtwpci->enable_dac = true;
-		rtw89_pci_cfg_dac(rtwdev);
-	} else {
+		ret = rtw89_pci_cfg_dac(rtwdev, true);
+		if (!ret) {
+			rtwpci->enable_dac = true;
+			goto try_dac_done;
+		}
+
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			rtw89_err(rtwdev,
@@ -3147,7 +3159,7 @@ static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
 			goto err_release_regions;
 		}
 	}
-no_dac:
+try_dac_done:
 
 	resource_len = pci_resource_len(pdev, bar_id);
 	rtwpci->mmap = pci_iomap(pdev, bar_id, resource_len);
@@ -4302,7 +4314,7 @@ static void rtw89_pci_l2_hci_ldo(struct rtw89_dev *rtwdev)
 void rtw89_pci_basic_cfg(struct rtw89_dev *rtwdev, bool resume)
 {
 	if (resume)
-		rtw89_pci_cfg_dac(rtwdev);
+		rtw89_pci_cfg_dac(rtwdev, false);
 
 	rtw89_pci_disable_eq(rtwdev);
 	rtw89_pci_filter_out(rtwdev);
-- 
2.25.1


