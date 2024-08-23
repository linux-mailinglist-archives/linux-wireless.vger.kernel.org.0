Return-Path: <linux-wireless+bounces-11854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48C95D228
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5BBB23EED
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96018BBB9;
	Fri, 23 Aug 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttC93zR8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA118BBB1
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428517; cv=none; b=bL/i2FwVUpWHfh2tW1KkSYa3W2CnDLz2icHHbWKxkI1cpE/9d6s2g2euchNptq5937ykPHD1nZY0nvPEjFfgjnelGUjhyEzrMqS9SXGSSbFqH9/99vjrnMRZYWHvFqS7uyS6AI4z0qd764l5w+BpUlEtSqfr+QsL4aIH9iC2Sa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428517; c=relaxed/simple;
	bh=ePvfybwsiMnF/F9NOskCIksnUV52Y6+64BJ0Rc4npY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GW7aTbHo9TljqBMuok7aEG4yL1BTxTGMlN1kuNsuAoAlh5Ac47BamGPxTBYYdRjfdCXn2pr91gxMped2kSCmkHz/yDb9c5nUA73g/c601/dRSR7jP2Xy0zZ53TtzSnwB3YeJoWgGJyXWwsrGOER2os4VAhX+vWyZfitN/FRF4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttC93zR8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2020ac89cabso20572585ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428514; x=1725033314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h1sMGva4zvk+DO1CjXNG0vRsRviBRjI6p9NW+fVQK8=;
        b=ttC93zR8iD8yjBhEppCADprC9Fph+xnVABKdPIUIKVr1EgYxP8AhpbkCC1neT73RVi
         +/2B5LaSAPfQAxD67D/91nZIAPcly8ffhd5gzbrmWxGqI82bW3if+k7ogZLY+nd6rjSe
         /YeWHUpvPk4DX4V6ntWOgTweEFfvpYWYzHr46vvo8EWJuJvAbASg9vg/izQqQvdtGrAD
         v5w6w3bieKFbtAePwatNoozU4sS0uu7d9kD67uBxXomXjPmZ6DEX3R+AcfE2oqquFLV8
         Xv5SqS687BbMCNogaBe3bF588+ehC4V+Jq+VLHEnhGqIHyN/MPuB9iYJSPHu6N84wqNU
         cKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428514; x=1725033314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h1sMGva4zvk+DO1CjXNG0vRsRviBRjI6p9NW+fVQK8=;
        b=uT1Xb/Et14PvqUybaifZLH6gqm8Pc5xjLNbSNr7DFH58RRsXK7AG5BxqSIY+RuIHPE
         hO2AOj9l8FFK27h/cQ8bPS3ksX6mfmg/tr8hGYWWutJYnJoWYDTR/SHsrO+3Jgv6UEiQ
         Jrp0PbNwjNVGhDMbKSRl3y9yJfH18EimCP/83iSOCxPsjGJAa8rUP6w3a0RgZnb2NsmJ
         IEhvw8WN6/gY1LilXHDcf4CYxG2T5VfLht35KwqkYITUEteeNQWxPvUn6vZaK+WqIoP9
         FUzAG4RMr+SIbArxtzS2yMMmxge88cCNz96439PBGdaZDYcD1+HTISKYqyhWYgFpFN1P
         3NPA==
X-Gm-Message-State: AOJu0Yz65P9rRm0TPUGycL/3CN3TLPMNOJLwhHewnZroyBepTUd63r0/
	Q6doXsKP/ktn+gLEtAQ/wq/+z9lXFPIeE8WB/h7yqEL2tCVae7F15qM1GV2Tpw==
X-Google-Smtp-Source: AGHT+IHZT5UpGBKD3IsG3QWdp8UwkgHmxBD8wtk0Tk5ZI4z0cspx07kEdT1GkMzCcaK4JYmk/BQ8mA==
X-Received: by 2002:a17:902:a705:b0:1fc:2e38:d3de with SMTP id d9443c01a7336-2039e443915mr21530405ad.7.1724428514080;
        Fri, 23 Aug 2024 08:55:14 -0700 (PDT)
Received: from localhost.localdomain ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556649bsm29824005ad.49.2024.08.23.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:55:13 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH 1/3] wifi: ath11k: Set IRQ affinity hint after requesting all shared IRQs
Date: Fri, 23 Aug 2024 21:25:00 +0530
Message-Id: <20240823155502.57333-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a shared IRQ is used by the driver due to platform limitation, then the
IRQ affinity hint is set right after the allocation of IRQ vectors in
ath11k_pci_alloc_msi(). This does no harm unless one of the functions
requesting the IRQ fails and attempt to free the IRQ. This results in the
below warning:

[   29.804276] ath11k_pci 0000:01:00.0: failed to power up mhi: -110
[   29.810564] ath11k_pci 0000:01:00.0: failed to start mhi: -110
[   29.816566] ath11k_pci 0000:01:00.0: failed to power up :-110
[   29.847202] ath11k_pci 0000:01:00.0: failed to create soc core: -110
[   29.853735] ath11k_pci 0000:01:00.0: failed to init core: -110
[   29.859745] ------------[ cut here ]------------
[   29.864486] WARNING: CPU: 7 PID: 349 at kernel/irq/manage.c:1929 free_irq+0x278/0x29c
[   29.872529] Modules linked in: snd_soc_hdmi_codec ath11k_pci(+) venus_dec venus_enc ath11k videobuf2_dma_contig videobuf2_memops nb7vpq904m lontium_lt9611uxc mcp251xfd mac80211 can_dev libarc4 hci_uart
 btqca btbcm ax88179_178a usbnet option leds_qcom_lpg usb_wwan led_class_multicolor usbserial crct10dif_ce qcom_pmic_tcpm tcpm venus_core aux_hpd_bridge qcom_spmi_adc_tm5 v4l2_mem2mem qcom_pon qcom_spmi_a
dc5 videobuf2_v4l2 bluetooth videobuf2_common msm qcom_spmi_temp_alarm rtc_pm8xxx qcom_vadc_common ocmem snd_soc_sm8250 gpu_sched snd_soc_qcom_sdw videodev drm_exec phy_qcom_qmp_combo drm_display_helper s
nd_soc_qcom_common qcom_stats mc i2c_qcom_geni llcc_qcom spi_geni_qcom drm_dp_aux_bus aux_bridge icc_bwmon typec qcom_rng coresight_stm coresight_tmc coresight_replicator stm_core coresight_funnel soundwi
re_qcom qrtr pci_pwrctl_pwrseq qcrypto pci_pwrctl_core soundwire_bus snd_soc_lpass_va_macro pinctrl_sm8250_lpass_lpi snd_soc_lpass_wsa_macro authenc lpass_gfm_sm8250 coresight slimbus pinctrl_lpass_lpi
[   29.872610]  snd_soc_lpass_macro_common qcom_q6v5_pas libdes qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common pwrseq_qcom_wcn qcom_glink_smem mdt_loader pwrseq_core icc_osm_l3 qmi_helpers qcom_wdt socin
fo display_connector drm_kms_helper cfg80211 rfkill fuse drm backlight ip_tables x_tables ipv6
[   29.990067] CPU: 7 UID: 0 PID: 349 Comm: (udev-worker) Not tainted 6.11-rc4 #50
[   29.997564] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
[   30.004446] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   30.011591] pc : free_irq+0x278/0x29c
[   30.015355] lr : free_irq+0xb4/0x29c
[   30.019030] sp : ffff800081f236e0
[   30.022441] x29: ffff800081f236e0 x28: ffff64630d260000 x27: ffffd8d89a8c3458
[   30.029764] x26: ffff64630d26ac00 x25: 00000000000000d6 x24: ffff6463029c58dc
[   30.037086] x23: ffff6463029c5990 x22: ffff64630d261c58 x21: 0000000000000000
[   30.044408] x20: ffff646301431c00 x19: ffff6463029c5800 x18: 0000000000000010
[   30.051730] x17: 0000000000010108 x16: ffffd8d8f1d8b840 x15: 0763072007740769
[   30.059051] x14: 000000000000030d x13: ffff646306b35ae8 x12: ffffd8d8f3852b80
[   30.066374] x11: ffff646306b356c0 x10: 0000000000000000 x9 : 00000000000000d6
[   30.073696] x8 : 000000000000000f x7 : 1fffec8c605626a1 x6 : ffffd8d8f2e602b8
[   30.081017] x5 : 0000000000000030 x4 : ffff646302b13580 x3 : ffff646301431c98
[   30.088339] x2 : 0000000000200880 x1 : ffff646301431c00 x0 : ffffd8d8f2b2c1b8
[   30.095662] Call trace:
[   30.098183]  free_irq+0x278/0x29c
[   30.101595]  ath11k_pcic_free_irq+0x70/0x10c [ath11k]
[   30.106800]  ath11k_pci_probe+0x800/0x820 [ath11k_pci]
[   30.112081]  local_pci_probe+0x40/0xbc
[   30.115934]  pci_device_probe+0x1d4/0x1e8
[   30.120049]  really_probe+0xbc/0x268
[   30.123727]  __driver_probe_device+0x78/0x12c
[   30.128204]  driver_probe_device+0x40/0x11c
[   30.132505]  __driver_attach+0x74/0x124
[   30.136445]  bus_for_each_dev+0x78/0xe0
[   30.140383]  driver_attach+0x24/0x30
[   30.144059]  bus_add_driver+0xe4/0x208
[   30.147910]  driver_register+0x60/0x128
[   30.151849]  __pci_register_driver+0x44/0x50
[   30.156238]  ath11k_pci_init+0x2c/0x6c [ath11k_pci]
[   30.161242]  do_one_initcall+0x70/0x1b8
[   30.165182]  do_init_module+0x5c/0x1f0
[   30.169034]  load_module+0x19f0/0x1abc
[   30.172884]  init_module_from_file+0x88/0xc8
[   30.177273]  __arm64_sys_finit_module+0x1c4/0x2b0
[   30.182102]  invoke_syscall+0x44/0x100
[   30.185953]  el0_svc_common.constprop.0+0xc0/0xe0
[   30.190783]  do_el0_svc+0x1c/0x28
[   30.194196]  el0_svc+0x34/0xdc
[   30.197335]  el0t_64_sync_handler+0xc0/0xc4
[   30.201635]  el0t_64_sync+0x190/0x194
[   30.205399] ---[ end trace 0000000000000000 ]---
[   30.432731] ath11k_pci 0000:01:00.0: probe with driver ath11k_pci failed with error -110

The warning is due to not clearing the affinity hint before freeing the
IRQ.

So to fix this, let's set the IRQ affinity hint after requesting all the
shared IRQ. This will make sure that the affinity hint gets cleared in the
error path before freeing the IRQ.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1

Cc: Baochen Qiang <quic_bqiang@quicinc.com>
Fixes: e94b07493da3 ("ath11k: Set IRQ affinity to CPU0 in case of one MSI vector")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 8d63b84d1261..0c22e18e65c7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -886,16 +886,10 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_pci_disable_msi;
 
-	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
-	if (ret) {
-		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
-		goto err_pci_disable_msi;
-	}
-
 	ret = ath11k_mhi_register(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to register mhi: %d\n", ret);
-		goto err_irq_affinity_cleanup;
+		goto err_pci_disable_msi;
 	}
 
 	ret = ath11k_hal_srng_init(ab);
@@ -916,6 +910,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
+	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
+		goto err_free_irq;
+	}
+
 	/* kernel may allocate a dummy vector before request_irq and
 	 * then allocate a real vector when request_irq is called.
 	 * So get msi_data here again to avoid spurious interrupt
@@ -924,17 +924,20 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ret = ath11k_pci_config_msi_data(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 
 	ret = ath11k_core_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init core: %d\n", ret);
-		goto err_free_irq;
+		goto err_irq_affinity_cleanup;
 	}
 	ath11k_qmi_fwreset_from_cold_boot(ab);
 	return 0;
 
+err_irq_affinity_cleanup:
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 err_free_irq:
 	ath11k_pcic_free_irq(ab);
 
@@ -947,9 +950,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 err_mhi_unregister:
 	ath11k_mhi_unregister(ab_pci);
 
-err_irq_affinity_cleanup:
-	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
-
 err_pci_disable_msi:
 	ath11k_pci_free_msi(ab_pci);
 
-- 
2.25.1


