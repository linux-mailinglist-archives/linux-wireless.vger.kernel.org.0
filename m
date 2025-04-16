Return-Path: <linux-wireless+bounces-21599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27FA8B66D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 12:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39765174ACC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7E8236430;
	Wed, 16 Apr 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="gB3cwKN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A6243968
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798191; cv=none; b=rqULHvHsC9ebyzC1cGYqXnjIfc+wIgeHg7sDGusaa7dv2iCn9GbdD0rbSl67NPQ1YXy+ccqo9i1DVacMeTrnJISDwxEgyTs4EQukbIn93gyWJxYJxeom/pVRp5mU92ImML/mrTTf4fqKpiZWL3GYmEqjCir9vc9OoC3ywQdjxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798191; c=relaxed/simple;
	bh=LYxbcIEMVNqJkEO9EAzYyEtQU1ryFSO7Ekf7PtNTwTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0EmWPbYsLvLkW4sxmK7V2Hcfk4vvZ3S/S4Et5StrKRixeg9/FQzYG3Q5jHaZ2YHkmab6aibDnDFDQjMvMtmUACZ7RS+aQ6kq54eZBYQtr9BoT7ZjqJ1GfRH6bSCRyAxERhpdH5WErsulCiaii3eAZtmevjTlbXXxkq6eFACa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=gB3cwKN4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso64707905e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1744798186; x=1745402986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=543g44xea+VkS5dgpNjg5ImV/Iq2la3ZwMFisqth3UU=;
        b=gB3cwKN4Dd7d26Pd3WFHF9m2Zqvl+JyQ3Tiwiw6+g2WJxXj/5C6y0yex4adYy14qnb
         qA0Qw7gboK4ZNb9jhCuJ13//Mzywrn7dFYAGfu+qf0YeCauDfyeyhk8y6yKyIjvQ4I17
         RZtHsWFyX5iYLSD31XDZ+20SWZIBW2E5ZzPoBSVS2JDRx9rVidSXpdOtdm1tWuqTzvlr
         ue0OahsDQoUt0B98OH6Tu9cERNpK5KSQ5mktfp07TTJMigilfD+8W70H/hhfYQmxflzz
         JtECKcvfRV6dRg6rIuL+ckYj05wlYUyUTpChNkMChDa2pvmZGGzwMA33rVGI8hbkB0cX
         gE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798186; x=1745402986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=543g44xea+VkS5dgpNjg5ImV/Iq2la3ZwMFisqth3UU=;
        b=nohuzryMAIEEGJqAWfLVXzS9qbwYtj1Ffur+VgPHnupEMtY0DrXY0uY1EkgcWvmEr0
         fuzsPn3B7WzG+eRt1Rubggkq5M75e0T33xnCz37oPSmEq7itm4GWPilKv7/YN+QFgZA3
         G6mq5DjXXCRldmrzAFHbsKgebMNIAasIvGerTArWhGHq+5qvVhx38rnBo79sYuzA0oJj
         V8OvlcvHVUSktMbr+bBuAPY0KjX1VmcXgAyu12Gt/FSp7+DpGj8gjYT5CQtbu67658zp
         jh5+ezpr3UaqDx7JEHxTk/QQ/2xW+60kZ7bugXWU7zpYSkUKrFV7tL7MLdPt5loecMRZ
         PaEQ==
X-Gm-Message-State: AOJu0Ywnp3l6Q3/kt5W17GV4rkmjGJuu9nBJszDxoaL6GbGCJkEmhwv/
	ktNqG69ADLgDMV/XiGQ6RqpZSs9aCjhyVCCqEgghw06rJq6c45eLWgzzAVavhmI=
X-Gm-Gg: ASbGnctUWCoQcu6ZOnDF0mKVQwOfZcUVGKoJpstvDYk04qTrKvg8zpJBlGRjcUvYxMa
	+alH5SMQYhD26vC7pFmFe+1fZMiBLhBuLkQIW5vrcakhjK85QJGHG0Ci+B+wD/w/dRuQj7NH9QK
	HteY0UbeeYwwB3OMmq7RmroHnQ+D5eCTh/4LtbN7vOJ0VfveuvNn/5i2YT+EJAXz5WHxHWj0ySe
	mWRm91cSxyUVnVTtVhjYeOF0Te03BuiQY8qHFLOvBPlcMdInLnQximApVFgTac6U8P2SFD3iYmY
	NGUgUrOCPz1qArJx/zJ9ex6Vi+J9I9bk8uGvV8f4AsUq+N4QTLf7qSeaDVrRP922dea7i/meZ3F
	9qVxchs0q52vp+b5xrz1N7pQDFQ==
X-Google-Smtp-Source: AGHT+IGwQ3IXzcguNuHXUXMsKyJBwB6sWZPhOqSpcFC9W5QC8DJ5RR8zkrsi+bOfsec4FmA9/kCOrQ==
X-Received: by 2002:a5d:64a7:0:b0:39e:cbe1:8d68 with SMTP id ffacd0b85a97d-39ee5b10f0amr1143077f8f.6.1744798186117;
        Wed, 16 Apr 2025 03:09:46 -0700 (PDT)
Received: from localhost.localdomain (288080060.box.freepro.com. [130.180.210.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf447777sm16458263f8f.100.2025.04.16.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:09:45 -0700 (PDT)
From: balsam.chihi@moment.tech
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	Balsam CHIHI <balsam.chihi@moment.tech>
Subject: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload with QCN9074 PCIe WiFi 6 modules
Date: Wed, 16 Apr 2025 12:09:39 +0200
Message-ID: <20250416100939.282481-1-balsam.chihi@moment.tech>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Balsam CHIHI <balsam.chihi@moment.tech>

This patch addresses a crash issue that occurs when unloading the
ath11k_pci driver with QCN9074 PCIe WiFi 6 modules.
The crash is caused by the driver attempting to perform reset
operations during unload, leading to a synchronous external abort
and kernel panic, as indicated by the error log:

[ 5615.902985] Internal error: synchronous external abort: 0000000096000210 [#1] SMP
...
[ 5616.056382] CPU: 7 PID: 12605 Comm: procd Tainted: G O 6.6.73 #0
...
[ 5616.069876] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 5616.076841] pc : ath11k_pci_get_msi_irq+0x18b4/0x1914 [ath11k_pci]
[ 5616.083035] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[ 5616.163712] Call trace:
[ 5616.166153] ath11k_pci_get_msi_irq+0x18b4/0x1914 [ath11k_pci]
[ 5616.171993] ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[ 5616.177583] ath11k_pcic_read32+0x30/0xb4 [ath11k]
[ 5616.182391] ath11k_pci_get_msi_irq+0x528/0x1914 [ath11k_pci]
[ 5616.188143] ath11k_pci_get_msi_irq+0x147c/0x1914 [ath11k_pci]
[ 5616.193983] ath11k_pci_get_msi_irq+0x1764/0x1914 [ath11k_pci]
[ 5616.199822] pci_device_shutdown+0x34/0x44
[ 5616.203923] device_shutdown+0x160/0x268
[ 5616.207847] kernel_restart+0x40/0xc0
[ 5616.211512] __do_sys_reboot+0x104/0x23c
[ 5616.215436] __arm64_sys_reboot+0x24/0x30
[ 5616.219447] do_el0_svc+0x6c/0xfc
[ 5616.222761] el0_svc+0x28/0x9c
[ 5616.225817] el0t_64_sync_handler+0x120/0x12c
[ 5616.230174] el0t_64_sy
[ 5616.233839] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
[ 5616.239932] ---[ end trace 0000000000000000 ]---
[ 5616.244547] Kernel panic - not syncing: synchronous external abort: Fatal exception in interrupt
[ 5616.253343] Kernel Offset: disabled
[ 5616.256827] CPU features: 0x0,00000000,00020000,1000400b
[ 5616.262138] Memory Limit: none
[ 5616.265188] Rebooting in 3 seconds..
[ 5620.268926] Unable to restart system
[ 5620.272503] Reboot failed -- System halted

The fix involves adding a conditional check for the power state before
performing the reset operations in the ath11k_pci_sw_reset function.
This ensures that the reset functions are only called when loading the driver,
preventing the crash during driver unload.

Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
---
 drivers/net/wireless/ath/ath11k/pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 78444f8ea1535..b9c8963c17047 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -368,9 +368,12 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	}
 
 	ath11k_mhi_clear_vector(ab);
-	ath11k_pci_clear_dbg_registers(ab);
-	ath11k_pci_soc_global_reset(ab);
-	ath11k_mhi_set_mhictrl_reset(ab);
+
+	if (power_on) {
+		ath11k_pci_clear_dbg_registers(ab);
+		ath11k_pci_soc_global_reset(ab);
+		ath11k_mhi_set_mhictrl_reset(ab);
+	}
 }
 
 static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
-- 
2.43.0


