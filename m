Return-Path: <linux-wireless+bounces-11519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7FE95441C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299081F211E7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06542145B32;
	Fri, 16 Aug 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH+6kEOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147071411DF
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796607; cv=none; b=kg8RogeDPrx9Z6+zn3cxtC+H05vx/BKRoVxR4Bzvdruppr3cahSuRJuSVsK2TSWleEFtlNfsDRqtw7LgstuyIphmhYHPqmGRZuRYZRP8EssTvMELRp5FioxgeAgH87IV5vCHY1Fd/wLPnailhW33AG6q6wmWUIDupyJktfcjeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796607; c=relaxed/simple;
	bh=wM05ae8D3UuZifrUxCpIru2FFRjjTKagh2EM//t8yrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwSp6u75M6MSRh6isOsZ+TjbAHonYpXsjgh3mGZYHlD92H/LS14l5/lkZKPUBNiXvVYRK3QiFbXjAZkYf7hdISgSH1fqWtG4v1cnu36qmbcPLV9dG7L6pUQw2dwKvPVJ35Tnr2+ruNGmhqzTjmtkHlZyR0ne0XCJsikkG+ZNqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH+6kEOI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fpJy1lqrVe6gM2rEMBvOKeSve8p82wXsKs5wR8bnTE=;
	b=WH+6kEOIKkeKhhtVTHr575oCNZTvEMuz+NAIOI6pSbeWDYV6yYryvYc5/afj+oN58CIFG6
	simRMVaJsjXGXrCShYx5fufy0Kw/R7JNW+6c4Wsv4plU+UfEVNOXDA8cgzuFTP6INCfxuO
	DC+Vnk0vZZPbJVqoobE74zvPhUUuWDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-N6HZ41LGOTSdHmVyvl0hsQ-1; Fri, 16 Aug 2024 04:23:23 -0400
X-MC-Unique: N6HZ41LGOTSdHmVyvl0hsQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-429e937ed37so2344665e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796602; x=1724401402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fpJy1lqrVe6gM2rEMBvOKeSve8p82wXsKs5wR8bnTE=;
        b=j05ScGFX+JLEytwQSEgPAfI4BUXwA/kpwXnt5NBVLLmSlMXdzyeaS2WNt3LASVgKFh
         hw8EqaJXd/LZvJzF2nqVH/BJmLigyuUds/kOuvXKqXH7UOdI63Ks001YI2UJ0Y1IRwtp
         p6y70/D+suyDTVFGroppTfwPrMvbL1/wZrL2IfI8WFLSdgX1vHNwH1Vv/01z/48TbIu3
         nUKaY4WA6+O/8vtf5Q2W/JJDdfGdexo6gxqlxWSVmi2NwQxG9Bvciq02UDDy7AYjdlqd
         id9jWkfmiNqgI47UtkIDjuToX3EdN3e0V+kvWa001uT7mt58EwK5LAF9ESdv/r0DY9/J
         Ziaw==
X-Forwarded-Encrypted: i=1; AJvYcCV/FSyYFe1MOGwX8gMAdpC9xDGF/+YVCSm+embEqc/+p2kHUuHe33lCumPDkG1rGkQLlsh2Vq17d6KPt4vUlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyDNks1BkTgsqy9zYw5C2PW6SA2PZ2ragJuqd2JReqstfyOts
	zwblR3r9r0rKSgm7uzAdS5pcRJi7Vun3mwCQqrQTxe1Q+uVVhO1MiJgSVSTkE/k2dvy+5gHmY6F
	Kqm6bBFIWKAJx03FvpydAqoGnU+jX4Id4PmPck11fUDlqsfv+q9/BqFfQjThIu2ce
X-Received: by 2002:a05:600c:1caa:b0:428:f17:6baf with SMTP id 5b1f17b1804b1-429ed804c49mr7811915e9.5.1723796601795;
        Fri, 16 Aug 2024 01:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUuXgUmb6wsgxs0xbUjuA+/5zZucO0eruF9dJY3Cca3/xum+COZyAHgME34FsQCOC4m52Ppg==
X-Received: by 2002:a05:600c:1caa:b0:428:f17:6baf with SMTP id 5b1f17b1804b1-429ed804c49mr7811555e9.5.1723796601388;
        Fri, 16 Aug 2024 01:23:21 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:21 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 03/10] crypto: qat - replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:22:55 +0200
Message-ID: <20240816082304.14115-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816082304.14115-1-pstanner@redhat.com>
References: <20240816082304.14115-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c | 11 ++++++++---
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c  | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
index 2a3598409eeb..c9edae8fdb04 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
@@ -129,16 +129,21 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Find and map all the device's BARS */
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
 
-	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
+	ret = pcim_request_all_regions(pdev, pci_name(pdev));
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to map pci regions.\n");
+		dev_err(&pdev->dev, "Failed to request PCI regions.\n");
 		goto out_err;
 	}
 
 	i = 0;
 	for_each_set_bit(bar_nr, &bar_mask, PCI_STD_NUM_BARS) {
 		bar = &accel_pci_dev->pci_bars[i++];
-		bar->virt_addr = pcim_iomap_table(pdev)[bar_nr];
+		bar->virt_addr = pcim_iomap(pdev, bar_nr, 0);
+		if (!bar->virt_addr) {
+			dev_err(&pdev->dev, "Failed to ioremap PCI region.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	pci_set_master(pdev);
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index d26564cebdec..18d8819f1795 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -131,16 +131,21 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Find and map all the device's BARS */
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
 
-	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
+	ret = pcim_request_all_regions(pdev, pci_name(pdev));
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to map pci regions.\n");
+		dev_err(&pdev->dev, "Failed to request PCI regions.\n");
 		goto out_err;
 	}
 
 	i = 0;
 	for_each_set_bit(bar_nr, &bar_mask, PCI_STD_NUM_BARS) {
 		bar = &accel_pci_dev->pci_bars[i++];
-		bar->virt_addr = pcim_iomap_table(pdev)[bar_nr];
+		bar->virt_addr = pcim_iomap(pdev, bar_nr, 0);
+		if (!bar->virt_addr) {
+			dev_err(&pdev->dev, "Failed to ioremap PCI region.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	pci_set_master(pdev);
-- 
2.46.0


