Return-Path: <linux-wireless+bounces-25678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124CB0B085
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05A41AA5355
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4928726A;
	Sat, 19 Jul 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeridxFc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2495479B;
	Sat, 19 Jul 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752936208; cv=none; b=BalEFsKsw7wmowyhiF6QdY9feVHUUpNdjZlYTr7JUHCYS69B7qw/9HPxjdGEHWqSMrr3LLmNiemCtj5gUwxOQJyLZeWG0l9AHoXrfiSqw/F2ZQFQyiIsPPf9tf72zfxV/BYXmqClrifoW36q8dCoe70IepFEjI2aix4XV3g41/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752936208; c=relaxed/simple;
	bh=kiYYKb9OBftr0y8ZJPDKJAyQyL662fXoi9F6AXSCTTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JL6Xc/s6ITHBFL+G5XaDa55NErJ8/6xW+g8/d7VGLs8R9b+VHT6yGH9qQlogEzTX9qr37xKUjdM6DLoU7oyQ3HLRaQKXW3CS+o10aiosUZtMlKKxHwwDbDYv2bCbo0tDu3G9rM+7LGNySQpZrxWxFUHnee43Mz50dRZRhfkA0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeridxFc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e334de8df9so337978085a.0;
        Sat, 19 Jul 2025 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752936206; x=1753541006; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhWUdLMBkHa/VmL6SvN8zMUj9EPv2Ix6mJIXJQMgHG0=;
        b=KeridxFctqcNrgrd0c2mdIySOPIJIWetxDpipsbrI+u9H2q4AtpXkUaVHdctdKCgge
         hfDJtTQdpNgYeP9tnTGUD3km3diXom0DtvFnhsebOTQFFyj/Y4v7dZZTx4HM3fQg8R71
         LrhsJaXokruJrcYGbmHvjS3uV4UIY836XbNxKVVMZT0NGYk6KJX/4wzRqYDeLxau9WMl
         hxkPHOM2s4bohf8YRxDMMBDkUquzDO9Z2a/UTZ1yFwNjKp+IQ1FgZSviqrxixZqrcQO5
         eMKfWRSTNZ57i4NAS9RjWFGPzDwX93m7beMii7V4QJXiLnTYqolYGtGYE8xoejN7yMMN
         u9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752936206; x=1753541006;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhWUdLMBkHa/VmL6SvN8zMUj9EPv2Ix6mJIXJQMgHG0=;
        b=ROdQ8xRIBMdS2Qd3tzgaOCzqhXmGCBE+x8Qqoloih/LvQyuuH7HyPHHEUaezvpSazG
         57/YjiSZQ5W8elmkt5ZTo8026Q2erxs0SJjNMnlktswqVKQ78ZzQEQ9rEXV1Ypz/+/rR
         FQB1rXQK3/5H9+mK7HmPHRDR6OHlerudi9UAy35AOextpzeT/iCyc2Cwa5QhsQokX/nk
         6sqkby/tDMarvBoh7TRe1WSMsFzyDa0RNc8gUtc7N7DwOV7y2x/AoHRQKeLX5KFL+Fpr
         EoOfS+BqJ9G3K18kNOyL2ObBjzA+e0DalP4NRVSX0muL5nqojb6rQcF33ltx+NaK7jPG
         32Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWynGILs3x3sDnJkmEU2fAAa2LsVVcDj8To13zOaKuGcd/6K103ceFLKy9VOxA+jnS9KdBAbV9+2AbzuXE=@vger.kernel.org, AJvYcCX9CUl/mDz5HAlaE5w5aa2WXqfYm29VUYCPHNehR4k0SIIe/8XRcjahEWCuNWQ88r0XGvftp4nUMhKHfOZh60Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NBRtkdjcB1Sh3N9yd4s4e8DYxKEy6gU4pYI+5qA0qhm9n/Fk
	gy0hyMCZa+xke52+Vz9k7qP/mommU045TVSGwBfqUmeKOmEoRiDdSbfK
X-Gm-Gg: ASbGncvS/Zxtd4A2gv5JyrHD8tJNHNLBy+F6AidfFRzoFBXAQluA0N+/Wv+TaVUqgB7
	+2w8G4ZSVFKgSvTxv149rayul7JGF16sC8TVyKm7TAALIOpipPQy8NNwlnzGgphosKNTPFmzxa4
	KvkY/UDHrr3JnVgaaalaiMkKWVxc0g17cAGKe6RK9Qjfxx4xnRcpXaWAnFMvDdF8R9NHfIKu/qU
	ON5syhl7q4yMsvCfFnSlt+aoVxHA4/f/9u+e5h1wUw3L3Ym95kJ/v5xUAW+4uE8n8gmArajc5G2
	I8op9KX0H5mY5uHm6cICDL24saX2qsIa9ZsrmPWdgtsiBUEqvRkwa6GJVS7/ci2+8sTPncbc/OJ
	8L9M+ChQ75XlxoXxPCutZ66w=
X-Google-Smtp-Source: AGHT+IF/dNLtRi00UDiSBMjTUuhj3EXijLt6s9DftrDL+2bf5nBduUOw0gFg6rlzRxfrQJkTppmmOw==
X-Received: by 2002:a05:620a:8013:b0:7df:dea8:63a1 with SMTP id af79cd13be357-7e34357af07mr1804323685a.23.1752936205969;
        Sat, 19 Jul 2025 07:43:25 -0700 (PDT)
Received: from pc ([196.235.236.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356ca2c5dsm202612785a.103.2025.07.19.07.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:43:25 -0700 (PDT)
Date: Sat, 19 Jul 2025 15:43:22 +0100
From: Salah Triki <salah.triki@gmail.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] bcma: Use managed APIs
Message-ID: <aHuvCpFcC2DwBU1P@pc>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace pci_* with pcim_* and kzalloc() with devm_kzalloc() so that no
need to worry about freeing resources and disabling the device.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/bcma/host_pci.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/bcma/host_pci.c b/drivers/bcma/host_pci.c
index 960632197b05..665990b8afb5 100644
--- a/drivers/bcma/host_pci.c
+++ b/drivers/bcma/host_pci.c
@@ -10,6 +10,7 @@
 #include <linux/bcma/bcma.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/serdev.h>
 
 static void bcma_host_pci_switch_core(struct bcma_device *core)
 {
@@ -161,22 +162,23 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 			       const struct pci_device_id *id)
 {
 	struct bcma_bus *bus;
-	int err = -ENOMEM;
+	int err;
 	u32 val;
 
 	/* Alloc */
-	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+	bus = devm_kzalloc(&dev->dev, sizeof(*bus), GFP_KERNEL);
 	if (!bus)
-		goto out;
+		return -ENOMEM;
 
 	/* Basic PCI configuration */
-	err = pci_enable_device(dev);
+	err = pcim_enable_device(dev);
 	if (err)
-		goto err_kfree_bus;
+		return err;
 
-	err = pci_request_regions(dev, "bcma-pci-bridge");
+	err = pcim_request_all_regions(dev, "bcma-pci-bridge");
 	if (err)
-		goto err_pci_disable;
+		return err;
+
 	pci_set_master(dev);
 
 	/* Disable the RETRY_TIMEOUT register (0x41) to keep
@@ -188,17 +190,16 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 	/* SSB needed additional powering up, do we have any AMBA PCI cards? */
 	if (!pci_is_pcie(dev)) {
 		bcma_err(bus, "PCI card detected, they are not supported.\n");
-		err = -ENXIO;
-		goto err_pci_release_regions;
+		return -ENXIO;
 	}
 
 	bus->dev = &dev->dev;
 
 	/* Map MMIO */
 	err = -ENOMEM;
-	bus->mmio = pci_iomap(dev, 0, ~0UL);
+	bus->mmio = pcim_iomap(dev, 0, ~0UL);
 	if (!bus->mmio)
-		goto err_pci_release_regions;
+		return err;
 
 	/* Host specific */
 	bus->host_pci = dev;
@@ -214,7 +215,7 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 	/* Scan bus to find out generation of PCIe core */
 	err = bcma_bus_scan(bus);
 	if (err)
-		goto err_pci_unmap_mmio;
+		return err;
 
 	if (bcma_find_core(bus, BCMA_CORE_PCIE2))
 		bus->host_is_pcie2 = true;
@@ -226,19 +227,11 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 
 	pci_set_drvdata(dev, bus);
 
-out:
 	return err;
 
 err_unregister_cores:
 	bcma_unregister_cores(bus);
-err_pci_unmap_mmio:
-	pci_iounmap(dev, bus->mmio);
-err_pci_release_regions:
-	pci_release_regions(dev);
-err_pci_disable:
-	pci_disable_device(dev);
-err_kfree_bus:
-	kfree(bus);
+
 	return err;
 }
 
@@ -247,10 +240,6 @@ static void bcma_host_pci_remove(struct pci_dev *dev)
 	struct bcma_bus *bus = pci_get_drvdata(dev);
 
 	bcma_bus_unregister(bus);
-	pci_iounmap(dev, bus->mmio);
-	pci_release_regions(dev);
-	pci_disable_device(dev);
-	kfree(bus);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.43.0


