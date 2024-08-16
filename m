Return-Path: <linux-wireless+bounces-11526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77E954446
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F6DB26CFB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FBC158DBF;
	Fri, 16 Aug 2024 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO7wR0Q3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E091581E1
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796621; cv=none; b=lPEwBjf42naVHpk4/Mnkwx4spZd9lKGK/lXEKg4Zh1bG+cp0cTiSMdhz5C3Ux4eQ2OcIONkhvBW+M9g8MNEJnrQCSzL8Ubq4hYFEy1L91+AM0ueCSRjkqdqAZAoY9vwmxJKxSzHMyf/TCEqSkIcun3xltG+h0gcbLoEsm1Orqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796621; c=relaxed/simple;
	bh=WeLrRQQZMB+M17UvRJFKdDj0pyrJSBe8hp5JfipVdgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWsvkwY2DES03ambP89OpJuIllMab3Bxuse8yirLLZUpfxmUwKmxWKYYO0pbnoj//hOjvgrjyDNgtzBGJRgsN2/FKi3VpO5ir4SflhTDi/5KTQOIgAaD8uZhNxOId+ICXINEgxgD7cE/JWmZ2AGc/vkLaI/zH50bkYwly9LMYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO7wR0Q3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9KK4cPQPxfE3+CuptPMI06hfd7cwzBu3NuXzthoA3A=;
	b=DO7wR0Q3cpKMkfzmOpBB8sAVIAOEG8hR3ijsbphU9HdbsIlsIbfsjOZrgaXl1tJTMAedUL
	j+RD1DqvalI5d+8cxmvTGK3IW26OhkMK1Bupf13mzeNDeQpCYKsAoiQulVjh89anulVVb4
	noNgaE+1PFKTnZ/x8n91pcFvryZEC8E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-2uQvctzZMR-D8Yw5BJycJw-1; Fri, 16 Aug 2024 04:23:34 -0400
X-MC-Unique: 2uQvctzZMR-D8Yw5BJycJw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428f1b437ecso2842305e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796613; x=1724401413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9KK4cPQPxfE3+CuptPMI06hfd7cwzBu3NuXzthoA3A=;
        b=aZRTOFBKHtsrbo5zQ/MeKvS/QmIeOMMCXWURwMFi4/eZaWYBRL87jmhxnVRGR4TjYn
         AUJmfecpTRLK+m8VNwYn5fEhrnCKKn6oF5gtFxPKkVur3MVdpfONhXjpi9uc9MxjU0FQ
         /7OHANRJ7VD+Co/GHbykH6V1Y7s0CDGjNRTcpyO1EULyj3p2Mf4wlFKz3c7amMBIklmB
         9GMga4rxEA3ll3DP6mDKBPrHFxlQU9VGhOkuKdz50c2XzOihiXokzqvkvorVkPJ0cGxu
         IXlwDw0gDfUhVlbvvtif7tDLVFlf/qk79lnE71aeLtxh0nj8AnJYH3Fv7UclZS/q/G/i
         x+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdkVHa1qax18IIbtjWcxskSfFcQwYOUYWvrCp32HAp6CfzHpOXnGpKYsc9jRFhm1OChpm6deuMWlgLGtiBdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytYjTRSVUoPsURzWmsWIzK+3i6VaCqyzIqo3WDpjJ6r4rK01FN
	84HxfJcI8WInyYSNnCoZvydinC1QGvVM7Np8iJPRrlkvbKTcSDmw6ThwwX/jm4dICrSUpUwuhzG
	4vZoYLZ9Fq2Zx2+f9Bbm5wt5fwG5DMyDYCrPPk8ykHUvz8NqO/WwJVVKpOyqmTzRk
X-Received: by 2002:a05:600c:3b0f:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-429ed7f72ccmr7955895e9.4.1723796612923;
        Fri, 16 Aug 2024 01:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1K45T6n4GqAA7kRJ9Z9vLdlCmjYbo94PMhiOgANbOu7cQ9323rvUxQ+wVpplvzg2GKSCyg==
X-Received: by 2002:a05:600c:3b0f:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-429ed7f72ccmr7955535e9.4.1723796612453;
        Fri, 16 Aug 2024 01:23:32 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:32 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 10/10] PCI: Remove pcim_iomap_regions_request_all()
Date: Fri, 16 Aug 2024 10:23:02 +0200
Message-ID: <20240816082304.14115-11-pstanner@redhat.com>
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

pcim_iomap_regions_request_all() had been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

All users of this function have been ported to other interfaces by now.

Remove pcim_iomap_regions_request_all().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/pci/devres.c                          | 56 -------------------
 include/linux/pci.h                           |  2 -
 3 files changed, 59 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index ac9ee7441887..895eef433e07 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -394,7 +394,6 @@ PCI
   pcim_enable_device()		: after success, all PCI ops become managed
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
-  pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
   pcim_iounmap()		: do iounmap() on a single BAR
   pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 0ec2b23e6cac..eef3ffbd5b74 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -952,62 +952,6 @@ int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 }
 EXPORT_SYMBOL(pcim_request_all_regions);
 
-/**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
- *			(DEPRECATED)
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to iomap
- * @name: Name associated with the requests
- *
- * Returns: 0 on success, negative error code on failure.
- *
- * Request all PCI BARs and iomap regions specified by @mask.
- *
- * To release these resources manually, call pcim_release_region() for the
- * regions and pcim_iounmap() for the mappings.
- *
- * This function is DEPRECATED. Don't use it in new code. Instead, use one
- * of the pcim_* region request functions in combination with a pcim_*
- * mapping function.
- */
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name)
-{
-	int bar;
-	int ret;
-	void __iomem **legacy_iomap_table;
-
-	ret = pcim_request_all_regions(pdev, name);
-	if (ret != 0)
-		return ret;
-
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (!mask_contains_bar(mask, bar))
-			continue;
-		if (!pcim_iomap(pdev, bar, 0))
-			goto err;
-	}
-
-	return 0;
-
-err:
-	/*
-	 * If bar is larger than 0, then pcim_iomap() above has most likely
-	 * failed because of -EINVAL. If it is equal 0, most likely the table
-	 * couldn't be created, indicating -ENOMEM.
-	 */
-	ret = bar > 0 ? -EINVAL : -ENOMEM;
-	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
-
-	while (--bar >= 0)
-		pcim_iounmap(pdev, legacy_iomap_table[bar]);
-
-	pcim_release_all_regions(pdev);
-
-	return ret;
-}
-EXPORT_SYMBOL(pcim_iomap_regions_request_all);
-
 /**
  * pcim_iounmap_regions - Unmap and release PCI BARs
  * @pdev: PCI device to map IO resources for
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5b5856ba63e1..8fe5d03cdac4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2294,8 +2294,6 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
-- 
2.46.0


