Return-Path: <linux-wireless+bounces-14533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40299B06BD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A101C21A25
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90C208209;
	Fri, 25 Oct 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA6neiaP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D8185B4C
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868450; cv=none; b=b0ozFgoPPUsAt4kBEeSQn7YcdZQparmAlWYUJATRiFa60ym7CqioitDp0lhrcvWGblYBKr2w1pGvgRgvZFx5AJv/yRqrb0rYO2pCKOdwI1YeP2Asryf/lqhDk79SgdNlgBvy3qTFyr97r28sGnzk96cynTjBvo906giQRSi4T/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868450; c=relaxed/simple;
	bh=YCSleCRL8+zgmB0F5bhpOuGHDhDr1YVS5o/lIBwlqhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baEkGvho+XjQHDjNQg7RVvjxnbXIvqgIe2z/8/cDkGlPJZpzSb0A9JwpyANIfIGUeo+xkRkLhNYfuIOAmrVg40ptWbTBNqUa/7ellbJpY3UNJ1qR7z92PTrrOW19tkLYBDk3IOoyNQty9P4iRxpfsI9lN10LkQowYgZOmrfUSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA6neiaP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8Pv00ipT6Qdh9I20/5aALEzhWkgYoXaIfeUPDxIxig=;
	b=KA6neiaPBqnoRKFTAcRAYcFH+6JOEEpN0zwJqx1xLw13CwhzwHGwkYX5r5O7kggy6e6pNp
	ZImS6zBaS+ntVdOWu6KUcTQnWlVSD6puwTGL7vqyit3aX9Bm7LDaRuAn/F14FBMqHhOajy
	ZUmw5qNfkhvcFmdCtcQ0Neclq01aa7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-_ksxLdXONfy9VnurexeoTA-1; Fri, 25 Oct 2024 11:00:43 -0400
X-MC-Unique: _ksxLdXONfy9VnurexeoTA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d603515cfso1009373f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868442; x=1730473242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8Pv00ipT6Qdh9I20/5aALEzhWkgYoXaIfeUPDxIxig=;
        b=dnx3GtN+xadv5g/42xQbK5/CxnisXGkfUGf5Fn2HiVUp2AkC8/E2AgRn3F3crsQHn3
         CvdFogvkrRRswv2zqefXYLA7DlOneTfHMTCJ0BVFCp+cDysshJrqZDjNNqeBCcQkuDgQ
         CVwHmplFXsBZNf3PTWyTJkhoaKxrmKylN+KPDQKaxfj3BbHdiOdV/GaOmP4uuAWT1guG
         LgLH3jgLAoIbSmf0no63HSwTOklCHtGcuMOY94+b6s7x5swWpxzUtWcJHr5/v51xfKgh
         KHmU9F1G145gXhFkcssWlevhM6otarANcbJZyeTCsIgpamuf9qPjWqXDqNW8UqSeWdyF
         rlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn9TIuyfZG2xoowyRRfMHtpdGT76voYZYO5WieloFKf+R6kKtKZ4SgISH4tzyxG+f3/n9Kpl7Bb6U8nCByJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUw+9KHj34LH8t9KYodjHCY/HONmBrodDaxxrphDBA+akDxPzE
	DYCk8bo4CW+pUOuNFnxT4FM+TZUrghU7f2izjB2KEQ4v3EdG3S9zL+3dnPMF1TST0YHStZcPrqK
	442ZwTp4ZABefyS6QM+wFMFjTHzXWpsk87nmuMPKYFR3QyaXl2z481oNR2z6cobrp
X-Received: by 2002:a5d:6604:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-37efcf15f2amr6047537f8f.26.1729868441626;
        Fri, 25 Oct 2024 08:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFseA1GnH6pKk4l885xPTSVzTwbgSgavQh+OieTeQi98Ek+SEn6EQGbHopZP84s8uTkOnT8ug==
X-Received: by 2002:a5d:6604:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-37efcf15f2amr6047433f8f.26.1729868440625;
        Fri, 25 Oct 2024 08:00:40 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:40 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 03/10] crypto: qat - replace deprecated PCI functions
Date: Fri, 25 Oct 2024 16:59:46 +0200
Message-ID: <20241025145959.185373-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025145959.185373-1-pstanner@redhat.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
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
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c | 11 ++++++++---
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c  | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
index f49818a13013..788a11cdb34b 100644
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
index 659905e45950..115eabfd1f6b 100644
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
2.47.0


