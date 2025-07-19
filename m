Return-Path: <linux-wireless+bounces-25679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217CEB0B0BE
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EFB562686
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D27F477;
	Sat, 19 Jul 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4f8Z14i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DC1EB3D;
	Sat, 19 Jul 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752940342; cv=none; b=OXK/XLf933WLixd7CUB3DslDtQX1Wue6sEncSCuAJfclL5fcuAFhymac+TopL2VGkEwIiO+ThwjvmiHdQ5jwnAT9ZhwBLmhuPr7PB9a7+Az61K21yIfzSsE+2QP1KYdgTxIOatHB9vNdxiB/5rakyC+EQ+2LemkPnxwmgM3A854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752940342; c=relaxed/simple;
	bh=cin655EQGH7FsjcGWRKN7CQ3dY5XGKAhN0J9RkHwm8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qHnHtKW2s2/SRnSVkaIOfBdrcbexlmGvLH2Tw0lm8gKjLBip9yuP0wd/erpkhRiQc1IgrxlY5dHxGBe8+Yf3IzQOEEqCDZxas9JaBhrKKhzNKSI0bX6YEJEUycctNpKshvWSpapQWGuxJWC9L+dnvGXYt3Kjc0RUqDSSkKM3d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4f8Z14i; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e182e4171bso326306185a.3;
        Sat, 19 Jul 2025 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752940339; x=1753545139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNgvgnp9VW65TFUHyeSpqBiDH6x3REnx6kZhnFLQurA=;
        b=O4f8Z14igGBe0oQDq+G5cN77P0wWSylhVkSbZDopXrnqv/4memzgZJkqquGbhFwunq
         MWFTryiSOcmLqZJADg5CsTjW/ngYhzd531ZFl02POySIVRx8kDjhMwb9meEjpcAr9NeH
         u353gfolQ4QnFHC44BBt/OmCcbu5PyUh/NMBzLmb0vmtPHUsZmSSenxYOpAnmEOaeDdC
         CDbA71kVyqfJUrdkN6cy4/SFaHC54s6WOclYRdCuVMe10okSS8mAvRzLfwDSYC04B0rr
         y1NAnFPgbzrTK4+33iEn6PSbRooVn3U3UpKb+Nn3DINypW04vrxRKdrh2wqtjmSTCpFw
         8sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752940339; x=1753545139;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNgvgnp9VW65TFUHyeSpqBiDH6x3REnx6kZhnFLQurA=;
        b=KQYrkbPvi3PV3dSWEt4kVg9RMer01R/FBSTkmJmnEh/7tQ3MM4hJ7aOzeYRgzgosbc
         7KTwsoqQcDn2AhWLm+R6c1ZHzegMhp56GI10EKxENikMgzfcLGKDXVAZG5L13YhkJED2
         gWOvGaPnQnLJTKGzp/NqDSasstbJ21eTBbDl1+37g6WuNcecllZMsMMHHJ35Cr9TGZs2
         Bf8ex4rYUsU9Tdk+QVlE+QLW8FTWvBRvHxkAKVIaEfX2K+ppKBLEmZ2ZijvLA8vZIJ2z
         SXor/Cx8DhUn8gAJc+cV6rvcvzBBcQgp3q4BYrHOxDE/Essz6MgFf+NwrK1x/OaTazyj
         pBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU8CBE8mM/hgILiqXsj606rkzuU/GWJF1VZ0ri6pHN+eJXIpfibaRcZr957A5eLv7F3OnNPBc+QU0aP0s=@vger.kernel.org, AJvYcCXLS+k+8/UGlkTtHv5gl/KIvYxwOnq08U9O+VSfA1ME69DkQyGNl9GgQ4LENDLGbE7ghzN6YJ8RIR0fprcm78Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdUoeHRU/YpU220I9Apq1mxwYBMB/eH8puH/j5RHjOpr2C0yc
	zCCKdrTX3olb/WghpFBniPXIzvj7ooRxy2bZIdFPt2y192Jsu6owL5r2a7GfvMEC
X-Gm-Gg: ASbGncvNtXUt3oKxemwVZjgGVr8fU8AWEr9BBPsEbEFYcVFJ6dZefy6d6wwvSf4FTkr
	iXlCojkOtjGaNR8UMO9GETdEGl9V4g6FP4w2zuAX+29dZLjU+QjwpagMU1Sp0qzBBSCfhubIvIm
	gnfhZaSFwJIgEln2gQGZvzO3FsSCy4WbOu2C7JOi3B3hT7uA8GuGCDmP1UhmVlOXHiq5wqx0X7D
	N1tthVl9Q579+33PlaN07S2ZZlRewDVARjIYIcNXf7dXoz2PloPCWXuLXRTtCzH1LpyhfGXJl4c
	cOZre0Q3HidiVYH6Vhcq+57emcYgjPC1ICB56ORDrWgG1C0x+zk0d2vbebjZH+NyEY1RljpKfYn
	ajLSHJkMn/U19
X-Google-Smtp-Source: AGHT+IHAUTIRWkoe+CDTlju6sOUvxj0pxoPNUZXb0JQMt1ClqQcAJ5JYjALPlQQGFDxfIfNV/Gsvgw==
X-Received: by 2002:a05:620a:6088:b0:7e3:6270:ab59 with SMTP id af79cd13be357-7e36270ac35mr454657185a.57.1752940339392;
        Sat, 19 Jul 2025 08:52:19 -0700 (PDT)
Received: from pc ([196.235.236.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b2a976sm210185985a.13.2025.07.19.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 08:52:19 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:52:16 +0100
From: Salah Triki <salah.triki@gmail.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v2] bcma: Use managed APIs
Message-ID: <aHu_MHDYB7-Vuua_@pc>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHuvCpFcC2DwBU1P@pc>

Replace pci_* with pcim_* and kzalloc() with devm_kzalloc() so that no
need to worry about freeing resources and disabling the device.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
    -Delete the inclusion of serdev.h since it is not needed

 drivers/bcma/host_pci.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/bcma/host_pci.c b/drivers/bcma/host_pci.c
index 960632197b05..8cdb546ce697 100644
--- a/drivers/bcma/host_pci.c
+++ b/drivers/bcma/host_pci.c
@@ -161,22 +161,23 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
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
@@ -188,17 +189,16 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
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
@@ -214,7 +214,7 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 	/* Scan bus to find out generation of PCIe core */
 	err = bcma_bus_scan(bus);
 	if (err)
-		goto err_pci_unmap_mmio;
+		return err;
 
 	if (bcma_find_core(bus, BCMA_CORE_PCIE2))
 		bus->host_is_pcie2 = true;
@@ -226,19 +226,11 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 
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
 
@@ -247,10 +239,6 @@ static void bcma_host_pci_remove(struct pci_dev *dev)
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


