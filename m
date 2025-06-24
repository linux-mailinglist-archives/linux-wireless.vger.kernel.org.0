Return-Path: <linux-wireless+bounces-24442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522DAE6CE6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 18:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBAD27B1665
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293D26CE00;
	Tue, 24 Jun 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCG5ZcjX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1F26CE2C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783858; cv=none; b=CeVFWF2relQYssEX/PsLmu/wEzpcbMWh/lMp3/MLvWxA/7VaiWDlorMe6L4BhTxhaTGWu149uemt0/hmG27mf0EWmtKgdeEU65NfAhNRuTU3ARAl93iPpl/SxcYseyPAASPnle7Jo7UmCDLzcS2tqvUwMrZH5iRqaB5r8YmW8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783858; c=relaxed/simple;
	bh=aeF9Q5weFRGVp+apn8QnkD0UW5dhUAJG5Z6LqGZoxSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2LhW3Ae0AUHINojB/ze7f8+3CP+AGp0jAQFKyrQwoaJanD9Flxb3Fzm1IWfeMqpePHEUsbh88Pb6gfx2a4BB0BEC7seHM4kf5MeWQhW16s/H4BZle6sidWp5Kc4S2e6U9tkPrq7DPR8K7sZ6VGax2h4glee3tc89KmOrHcudvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCG5ZcjX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ce671a08so36507335e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750783855; x=1751388655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHFqrr/kNilRxKIzI+lsKlq6Egg4F7XUceUPXNKtTSQ=;
        b=HCG5ZcjXYs8pfbG/kAbKNTB/3ga084nCo2f0z0ftXUBL5GKNZHFbPuw5i+cGjem0KU
         dzxJT3oOi6nOxKbdAYzz5uEIPP+0yQug+3Twy1sb+esAsfFHjzV4palnEy9G66yjVKD5
         w4e6T/vflGnYWUhk3z28t/NE39SpcqC1VvU+aA/CvPEmtsYLM9bOfF4SGiht7Gp746iv
         YGQUpbYe5zH4XR2uAqQEkmA2vblKJN3r40XMjRvBmOYN5fnSyjYtetu2UF8fLk+syve5
         vIK87eFqI7eV1fnlDSOyod2BnqNZfNtzR5t5zLuPczY6f9UHpe7WnwazmIbMDmXa1EEP
         Uhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750783855; x=1751388655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHFqrr/kNilRxKIzI+lsKlq6Egg4F7XUceUPXNKtTSQ=;
        b=aO9GsAyu/e7SBy/VRyNw8EtEVq5d2ZKo7rtbN0A5K/HOXTqneGpsKnRsZH7sSjxySV
         kUGjAgExtqkmMCgruhh2Pgd1aj70jEAbzH/pRFBgtzW+lZa5tDBHEVLlYvgffNwJS/gN
         UrfiQlugByKlh9Llh+Idm8ir2UJUsgbvYXuwJoKzyQDDf3yQ3WfJR8sflFqgnpZGDERZ
         V5Q6Qi2hU8uvpP7OZQzH/h/lSM4k5SJytxOFi8cpoQfFQXpPoZIEZtfIKljqakARpLEh
         eUcf5uATywrCvZyIXgmV6tV0Jb4CPg4B+Y1itEs6ZPbTTgYC1K/spRJZ/wGQSbkq1QdN
         S+qw==
X-Gm-Message-State: AOJu0Yw6KQ9CGdafpPlAgNssPcxaDV2euGUgF8+iWmf1a0rot6U4ee3n
	KFXfBD7Gl6vK6DomLi/Tm1mf22zh6b3VJv8cLSLcC5Mi8HqSbJ6cyVEo
X-Gm-Gg: ASbGnctl6DxdOSA/NcyF/Ivd3KNcOoJBdnQOyt4LnjvzAQ3hZVDGpwBCl5qs7KVtEsJ
	o+suE+R8hMXtZXv3cryumSVWQ8FtX27ykcjkUTkn3bgJWiqHmzrZKe5Za0YAPDxQTWWnOXPe7cb
	WH7bx906A8qhvOFESomII4J8S3+JSQT7pB1WU7mxtQCPH3ceOLhphkctDMPjTi1i5h0SxJkjd6L
	aF8VPNAzEj3zIxMzipSXUS3acex8fPdIUhYpcbQL/xLF+cVAQeZNuSnKmxsg1C7NtX4KrRCSAVH
	su83oeeNNHmHdhYVejrWwHxFakxBtWmNz883NRqI3ELwn6mhFsvXnrA5hgPzSvhpPmQkQFVMNTE
	XcS9YOD+RSfNNMVFlC2xWE7Uqlmo=
X-Google-Smtp-Source: AGHT+IFwQc4zbsyjGnbBX2eygzyIbIn2JHqWT8OfveOdOyrkeTPZP3hcBq0rOTK6GxlfyWpx9ffnVg==
X-Received: by 2002:a05:600c:45cb:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-453656c2c49mr150048265e9.26.1750783854821;
        Tue, 24 Jun 2025 09:50:54 -0700 (PDT)
Received: from govindsingh-ThinkPad-P1-Gen-3.tii.local ([2001:8f8:1d0a:b6eb:5d08:e639:26e7:bf0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45369eae840sm120723675e9.38.2025.06.24.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:50:54 -0700 (PDT)
From: Govind Singh <govind.sk85@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	Govind Singh <govind.sk85@gmail.com>
Subject: [PATCH] ath12k: add module param to control MSI mode and address width
Date: Tue, 24 Jun 2025 20:50:31 +0400
Message-Id: <20250624165031.58616-1-govind.sk85@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds two module parameters to the ath12k PCI driver.

 - ath12k_msi_mode: Allows selecting the MSI allocation mode.
   * 0 = multi-vector MSI (default)
   * 1 = single-vector MSI

 - ath12k_32bit_msi: Forces the use of 32-bit MSI addressing
   by setting pdev->no_64bit_msi = 1 before IRQ vector allocation.

These options are useful for working around hardware or platform
limitations(ex:  i.MX 8M Plus) where 64-bit MSI or multi-vector MSI
allocations fails or cause stability issues.

The original MSI allocation logic remains unchanged unless the
parameters are explicitly set via modprobe or kernel boot options.

Tested-on: QCN9274 hw2.0 WLAN.WBE.1.4.1-00103-QCAHKSWPL_SILICONZ-1 with
           i.MX 8M Plus SOC
Signed-off-by: Govind Singh <govind.sk85@gmail.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 25 +++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/pci.h |  5 +++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 1f3cfd9b89fd..4f58cb1e03f6 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -45,6 +45,14 @@
 #define DOMAIN_NUMBER_MASK		GENMASK(7, 4)
 #define BUS_NUMBER_MASK			GENMASK(3, 0)
 
+int ath12k_msi_mode;
+module_param(ath12k_msi_mode, int, 0644);
+MODULE_PARM_DESC(ath12k_msi_mode, "MSI mode: 0 = multi-vector (default), 1 = single-vector");
+
+bool ath12k_32bit_msi;
+module_param(ath12k_32bit_msi, bool, 0644);
+MODULE_PARM_DESC(ath12k_32bit_msi, "Force 32-bit MSI addressing");
+
 static const struct pci_device_id ath12k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
@@ -773,10 +781,19 @@ static int ath12k_pci_msi_alloc(struct ath12k_pci *ab_pci)
 	int num_vectors;
 	int ret;
 
-	num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
-					    msi_config->total_vectors,
-					    msi_config->total_vectors,
-					    PCI_IRQ_MSI);
+	/* Set 32-bit MSI flag early if requested */
+	if (ath12k_32bit_msi)
+		ab_pci->pdev->no_64bit_msi = 1;
+
+	/* Force single MSI mode if requested */
+	if (ath12k_msi_mode == ATH12K_MSI_VEC_SINGLE) {
+		num_vectors = -EINVAL; /* Force fallback path */
+	} else {
+		num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
+						    msi_config->total_vectors,
+						    msi_config->total_vectors,
+						    PCI_IRQ_MSI);
+	}
 
 	if (num_vectors == msi_config->total_vectors) {
 		set_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index d1ec8aad7f6c..4fa8bb619cd9 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -92,6 +92,11 @@ enum ath12k_pci_flags {
 	ATH12K_PCI_FLAG_MULTI_MSI_VECTORS,
 };
 
+enum ath12k_msi_mode {
+	ATH12K_MSI_VEC_AUTO = 0,
+	ATH12K_MSI_VEC_SINGLE = 1,
+};
+
 struct ath12k_pci_ops {
 	int (*wakeup)(struct ath12k_base *ab);
 	void (*release)(struct ath12k_base *ab);
-- 
2.34.1


