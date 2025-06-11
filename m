Return-Path: <linux-wireless+bounces-23999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB09AD5C77
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9A51719DB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D291FE45A;
	Wed, 11 Jun 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="y+U4KD3t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92D1C8632
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660022; cv=none; b=IFKWxuUxt5y7U8iiCFG/aKyagLFd87tfssgK7LsekQnZKVvZQFAAga8O1Vw+ey9jEf/21vvY1RfUNGJ6LgH+OiVWgN3bvO7aIzjMxjJkUi8/SZ4k0INbVKBZTiCRZEPSC/Lr6GTKuJpuIK4WZsq5nwFLzD898otceRR1xkhtcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660022; c=relaxed/simple;
	bh=OllCvvlTLc+b0HxiIdtuK6rR9WGYjQDgTDP5iJcsR1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jc68IOwt3zD7ZBWLCcLYq30tIjrWmM5CeJfeUBQ6rjtamHvYheHNKHciezjw1Ha6OCRM/sTAFqeA6Wb/BwhrwH8gEFKTvM6RZKUKbyL5WW1AA4G0xa7ldTmywa1bArIyqhTzbamlcdxaAfxE803KPJxUotx4NMc4ornYnO+LZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=y+U4KD3t; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso44678685e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1749660016; x=1750264816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpIIr412h6qi7YHWKmAJOkUa0XBDTSw1GCUKcTFMnYg=;
        b=y+U4KD3tRexKrD6u8PAGjsKLebtVBxhU499tDslZEHJUzuOu/gITwHZNZm0ZyM6h3z
         fFvGTSdtUchGu5msLXmXcAQtNhdGfzR5wtHfcUQtRQtcQiRDDiRRMgurSBQ3SaRdoF0z
         74NpIRQXlf4qbU8uMIZ3dkGKWkEhQDLODM9sTvqrn1sZ9Eldr3ArxSsnryv1xEkykFDP
         m/Pjbv7I7jSyhJP8PuKanWFlKwtSQytl2K8gguZaW3hqzeob4NfEBx09UMh/jXM3SMSC
         Hb26kkCxZ+IlT3tAY4Uq6vmxxMjxdJ5st5rgg5RkdZ8IRSDrRCCl0l1k3buNQlMAT+rB
         hZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660016; x=1750264816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpIIr412h6qi7YHWKmAJOkUa0XBDTSw1GCUKcTFMnYg=;
        b=aC0TgcIU3O916jrABExkwB/zbdboUgYw/LrflI/ySrpsMzZh1V5W8T7TTY/ER/ake/
         xw7dhMPk1bHVYFb2FzjSRWEk2RDLb3NhDG9wyDMxetFFiYeY2wUiG6DjFo8u6+yvyKkI
         6R4Toamtd1B6gQnzzDWVEJQA0jTdHYAimh55lfBudnNeG4aIlIcX6Imzvvbk3y59zy1r
         sTOsZewpxRHJRFLlXEWO/4ohUGVz4M0GpSW5PqJd+xRoCsLcWEnLzp+hJBiW3IKASKBj
         4BrTjUa9VsQYpJyU5jrs9hnDT90QnO3Fq0Sba7Vdh+wzSUz1+n26ohv1G91zx4N7vb10
         JkMg==
X-Gm-Message-State: AOJu0Yzbo+Dg+vAknnGBVzCH1YBg1f9vwUbu2/joW422Ngzjd3pYtFMp
	Mv0AQCVpmZKevZFamIaFZkRo0Isz1MCbDIWXqATbfw8gZzot9/5D8SwSbXyXAlIjJS031jzB4Dz
	pRbzwtuE=
X-Gm-Gg: ASbGncuv1wFhBm9kUsR489AKHAbVNqK9EOG6TxQjJHfowDWv/tHr7TCMuSWoksvWMxV
	qubxLvhugCrrZuOZ2tspkjpaJ3GRLUDHH/3THhKR10D8xY9hkDa1sSfLwOzCRX4A3L8DvSU8Djj
	5aPIz/LlTvNW+LaBgdlqp3vNJHtJMvpx+sI/3cWORTDr2ZoTj2/WUtOHGGCoTJzM4QpyIbK1C51
	kKeBPyV4+iECcO3hRLaBnSncRauGyTBu21WZ89VEmR/bSHtpQhHVFZslRhsePNXExOdHLb8QjVi
	HfsuFTq+klQixJBBWLp4FpCxCbwwOn+9NAdSgrXT/cuMHJnkLbsj7fiAXlativGtrq2/Ew29TQG
	HlbF+JwDXPb7DKuZ+QAx/lA==
X-Google-Smtp-Source: AGHT+IExmN5nKKRM3cMk/QnLRlHaydJ/Cszjs13vnlBuajVpdmmRJFpfo/it2FNx38EQznXuFXW3vQ==
X-Received: by 2002:a05:600c:3586:b0:440:6a37:be0d with SMTP id 5b1f17b1804b1-4532b8c2c9amr5327405e9.15.1749660016157;
        Wed, 11 Jun 2025 09:40:16 -0700 (PDT)
Received: from Ubuntu24x64.. (288080060.box.freepro.com. [130.180.210.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532461211sm15561599f8f.86.2025.06.11.09.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:40:15 -0700 (PDT)
From: balsam.chihi@moment.tech
To: linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	Balsam CHIHI <balsam.chihi@moment.tech>
Subject: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
Date: Wed, 11 Jun 2025 18:40:04 +0200
Message-ID: <20250611164004.38580-1-balsam.chihi@moment.tech>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Balsam CHIHI <balsam.chihi@moment.tech>

During system reboot or module removal (rmmod), a crash was observed
due to a synchronous external abort caused by invalid register access
in ath11k_pci_clear_dbg_registers(). This happens when the device is
already powered off and the driver attempts to read debug registers.

The crash log shows:
root@OpenWrt:~# reboot
[  343.663492] Internal error: synchronous external abort:
0000000096000210 [#1] SMP
[  343.670992] Modules linked in: [...]
[  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G O 6.6.86 #0
[  343.849746] Hardware name: LS1088A
[  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
[  343.870125] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[...]
[  343.950800] Call trace:
[  343.953241]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
[  343.959080]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[  343.964671]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
[  343.969477]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
[  343.975230]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
[  343.981068]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
[  343.986906]  pci_device_shutdown+0x34/0x44
[  343.991004]  device_shutdown+0x160/0x268
[  343.994928]  kernel_restart+0x40/0xc0
[  343.998594]  __do_sys_reboot+0x104/0x23c
[  344.002518]  __arm64_sys_reboot+0x24/0x30
[  344.006529]  do_el0_svc+0x6c/0x100
[  344.009931]  el0_svc+0x28/0x9c
[  344.012986]  el0t_64_sync_handler+0x120/0x12c
[  344.017344]  el0t_64_sync+0x178/0x17c
[  344.021009] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
[  344.027102] ---[ end trace 0000000000000000 ]---

This patch adds a `power_on` flag to conditionally skip debug register
reads when the device is not powered, preventing invalid memory access.

With this change, the system no longer crashes on reboot or rmmod,
and the driver continues to function correctly when reloaded.

Tested-on: QCN9074 hw2.0 PCIe on LS1088A
Tested-on: OpenWrt 24.10.1
Fixes: crash on reboot/rmmod due to invalid register access
Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
---
 drivers/net/wireless/ath/ath11k/pci.c | 36 ++++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 78444f8ea153..0c1b55957557 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -203,16 +203,18 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 		ath11k_warn(ab, "link down error during global reset\n");
 }
 
-static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
+static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab, bool power_on)
 {
-	u32 val;
+	if (power_on) {
+		u32 val;
 
-	/* read cookie */
-	val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);
+		/* read cookie */
+		val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
+		ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);
 
-	val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+		val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
+		ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+	}
 
 	/* TODO: exact time to sleep is uncertain */
 	mdelay(10);
@@ -223,14 +225,18 @@ static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
 	ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
 	mdelay(10);
 
-	val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+	if (power_on) {
+		u32 val;
 
-	/* A read clear register. clear the register to prevent
-	 * Q6 from entering wrong code path.
-	 */
-	val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
+		val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
+		ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+
+		/* A read clear register. clear the register to prevent
+		* Q6 from entering wrong code path.
+		*/
+		val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
+		ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
+	}
 }
 
 static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
@@ -368,7 +374,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	}
 
 	ath11k_mhi_clear_vector(ab);
-	ath11k_pci_clear_dbg_registers(ab);
+	ath11k_pci_clear_dbg_registers(ab, power_on);
 	ath11k_pci_soc_global_reset(ab);
 	ath11k_mhi_set_mhictrl_reset(ab);
 }
-- 
2.43.0


