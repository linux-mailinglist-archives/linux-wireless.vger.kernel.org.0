Return-Path: <linux-wireless+bounces-25681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B76B0B0E3
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A52189CE0B
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CF22126C;
	Sat, 19 Jul 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+ruJbJU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4621A7AE3;
	Sat, 19 Jul 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752941969; cv=none; b=E0hgoociQtSyIzf/2b7f9NkzXSSHgBGUZNo6NaZHDx66HUr0Xp1ZSMGlfU1ykMCkofKrzBqNREdHoQUlK4hE+oToOhDS9V1YaDLwPjIxpkNZKtgL65N5HaPvratg2BjoGFYnzSCTvwrLrdxxgcYj03tsyAKhqZkm+O2PCrB3MTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752941969; c=relaxed/simple;
	bh=eRrYhUwv0Q8QXZ+9crlgpBy0ZnaD1uh6JOu7a0/OM0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Am3CKhgGmvZ998JXVbJtYjopJOndqlbqfy0YkJ5qij+UgwVEnn7PPZLMW2JYxY6xr2nIPBnukdXqZU8fJyQLDDu0NwHZAKC8w45gVVQjw79b9TvV9AMn1c1ILeAfvcFZgTqjOMiQWQFAh6vC+Lf7ECdGe8MQwjmRYWAvQvmolRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+ruJbJU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7048c49f1f1so25788316d6.0;
        Sat, 19 Jul 2025 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752941967; x=1753546767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRTB4j7mrP4UvJCyIZq8WoHPJ7oIcNpPXB6bCvL5FDA=;
        b=k+ruJbJUYPpUPA6SnsQSKOih2jJbF0QUmLt+1dQ5xNA9vJr565CpdosI3KLIkrY1lS
         JJHsR8CvuKiG0Vpq+OMo/aNTtITd1CiGmXVh8AA4qvrtK5FnId/vbXzyQp2opXFd1ls+
         Pk1TGVPIRWWk2d6xLFIq8NHZLkYOs3NH+JqTXtfQsQGjmKUNHNOOYRh9lwWZ0+f4z1Jk
         /XlYgOHTyBNL21S1p1wHqMmonX/0BNA9ZEzp5f2NCT+FJvCXZjIKL/S9kA7w/x2Pszcb
         DLR3dyR5wx5H6qMGukEWNDBgc7gFI4be+csaTARE1T/sc7vxS5wFSgB4WsscYp84ixPA
         KngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752941967; x=1753546767;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRTB4j7mrP4UvJCyIZq8WoHPJ7oIcNpPXB6bCvL5FDA=;
        b=DmM9Z69gtUH0bU5KUWyFKIYJTd3c7uTifS3v80ZpRCwTLkWDxyknT5GrDJkOJwsRfs
         NqaEE3wdmS0aNteMrjUUlf9KFcVxeLwqK0iO6mwplzGzfISMJFuwErGuJvFzrO8Fe1aB
         IrwvD0RLXnR9LV+WHB/JkpvwUijhN5nth9Gwqh5wTD8OM660ocbiMotIv5tZMNgf+vo0
         y7IpPk0L6PAvD9Q33e2lYGGAvHvaNx7afsj1UU0IbFgnA+fW0Va2vhsdYq8tmImJQEBl
         4ZPQfpuoLMA4TE8bJJxo5r1Vg+rJex4zrndY3nRYlRNcosKm7Gy1a32hylI+wunmiXaN
         SiFA==
X-Forwarded-Encrypted: i=1; AJvYcCVpb4g5SEuF2M9YGEEjRaNBnrn/cx0I9zvtSP56YwDERzzZiyyECLiiBHzqokbMBu59+mkMdZSBWJhMKZY=@vger.kernel.org, AJvYcCWVniVy3XZ6Ex83GchL/Xi5VvWjOPj9Cpa4Qp+3ShC6ytnjOW2WacnpePoe9qysqmytD+g6we4P1db7ilzuhX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNi4AAtAB/nUlruZBECqcNLJ64EwH3DPnE5vE0vRXx3bBeE59w
	bpWXNPErXBEjm39W3e7yLK11ZliXG+KWpTBIXI7gbe0YBaEujUAF02Re
X-Gm-Gg: ASbGnct0tZCSzfaKJrX+J49DjVWERMkabB4qfz/W+5O0knz3w8mO4zLiBZNKO0eaH4d
	brhziEfGDsTYm70fv43/wX+q3+c5CZxZHT44gNMcM0j2arCc7g/qEHTgyLin+Nzoguuxp/XwEW2
	kUxeovmlw+VfMMRrD/chwU57L551IgaQAlyQvsSX2djdLHpLMlg9sH3GcqpysI3oL86OS2bMUau
	wnankQKWNO2HFqqkXBil8oBmBXTex0jRB/iPJbtXnqPng2/0ouUXBmuKXSzzi+68i6UETwqiKo8
	+mCjwYg+5D49QerFbm+IMTMCGq8FL5x/f/+yHhDem5pbRTHEpZEjPcKoir4l/AW94/FfcLdMvND
	ADQsMqZbs/nLD
X-Google-Smtp-Source: AGHT+IHL/0kYvdBSdmSXWBhfVK6C4imEZdQE1EUdb4L/qGcKDVlXtHgEel8jW7E6n3cSFILX9NedyQ==
X-Received: by 2002:a05:6214:5d87:b0:704:f956:667a with SMTP id 6a1803df08f44-704f95668bfmr162808846d6.49.1752941966777;
        Sat, 19 Jul 2025 09:19:26 -0700 (PDT)
Received: from pc ([196.235.236.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc220sm20217986d6.3.2025.07.19.09.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 09:19:26 -0700 (PDT)
Date: Sat, 19 Jul 2025 17:19:23 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v3] bcma: Use managed APIs
Message-ID: <aHvFi5PMXFxGwd1W@pc>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f027d2a957ac3d035f8a81f2dd6dd20a5a6207.camel@sipsolutions.net>

Replace pci_* with pcim_* and kzalloc() with devm_kzalloc() so that no
need to worry about freeing resources and disabling the device.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Tested-by: Compile only
---
Changes in v3:
    -Add the tag Tested-by

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


