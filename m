Return-Path: <linux-wireless+bounces-11517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E2954411
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C41D1F2394B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70250143751;
	Fri, 16 Aug 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gslm1Z99"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFD1411FD
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796605; cv=none; b=ufaWxow2KyrDsNYeh8PvHki5puvuKKHPdalmVFc56ioFK4F8HsOGb4xGNdHiOdJk6AYaGHK5PmloP8PNOcCPPDl4LUYYz4V4ISHgL7WMKdGMoD3GKxr71vW1EcMaEDJrPrKXam4uLMAr0cKMKO/iZildgdxxsnaMJYaOC6VnZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796605; c=relaxed/simple;
	bh=zVpmTTp3nHIzVMoh7ZTo5T9lcWciVJTr4ZCcBW5jOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6hEwk+WFCxlV/8ESBQ+I+cBDaPdn555ZUBQNRJR9g4ElsMCI5Fwq7mvtS92DeRze3LTo1TQYLUrcTBR1krgFfZi6HMIhZyUEzAdnGcbaUx9XrX+ccSncoHtP0JpUqNpaeSHoF4OYI0iXw+b7W7uSQL2EBrYDOmEsINDLZUMwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gslm1Z99; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzzbkcE2piNg6xzdXbcpa+EEzchmMoLeUr0sOfHpsDw=;
	b=Gslm1Z99ht0Mo9R3X+VkIn61al+De5R2Jg9dSHOzXIu5xoC94gn4DqeS3Z5eHgLax+wwea
	JFE8i34FcJ+tFCo+5FOkUYpix2ivbKVUkILdZnrRjbGoRb7xlMVMrS4G/OylhJWHP4Bwr3
	U1JoXUSoSdZbFSkevjhW140Z5c8JY34=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Rs6z8rEoMo-d5HLY9vAADw-1; Fri, 16 Aug 2024 04:23:20 -0400
X-MC-Unique: Rs6z8rEoMo-d5HLY9vAADw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-532ffe0530fso251129e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796599; x=1724401399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzzbkcE2piNg6xzdXbcpa+EEzchmMoLeUr0sOfHpsDw=;
        b=G0l3U0U71Mq6ej13QrBQE8a1gdzTbkN+uV6Dl1dfCxGdz0CCJIvYRGj3+7hK/7Ji/c
         PZxhBpfeo7rFm9UwDef5ierrXyMhaT0ejVXZilHGteqj4dcc8NFFVfVqohLhTCJ8r0DU
         SF+wATcGZSV3CFNeX9yntzz9w5qf2kJppgxMYjoUnrPbUrpPi6A4F2TiaVXt+xlDR6H8
         DnK5Aux9eRK5OvGwGRYT8TaIZe9fRNyruwpF2InJ8RWIcomBgPIE7lXro/C3FkimDLd9
         iIMLu8xJlhffKzWWdl7C8g8Kui+pGs3dtiVUSsUHjgji+69VfbCrKVGdcDWFJODIms9L
         FFWg==
X-Forwarded-Encrypted: i=1; AJvYcCU/U8oSbCBbGLiAFEdBp5El2gQpzzltZkp5BAMXi9uZvSPtTWtaxgbt71w2wsAsFMGU110JQPbytZ4Rya0JSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGRv2+OQeSaStk3ERh73VP3Ryt30NDy8QROGCgvAxBoBwGLad
	DPv5PW+YcukV67R+qIUDY32MKsqjPJdoOCx+VUVeAvnCYLUq+0GgxY8TXaDe3PR14cGSY+80TgB
	wVmfZD0e4INFsC+mCpliEvwJ3oMOU/sX4xjNflVZyaZUKvJaGb2VvTX0eEo7xTACb
X-Received: by 2002:a2e:a99c:0:b0:2ef:2b1f:180b with SMTP id 38308e7fff4ca-2f3be617274mr8424531fa.8.1723796598801;
        Fri, 16 Aug 2024 01:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF2FO8TTO68hZ1mL0fNAPSpkGVq8q42PLCiERNm/y+Oi4rSP5Phgl2zzK0/6kEjJzXbloZGQ==
X-Received: by 2002:a2e:a99c:0:b0:2ef:2b1f:180b with SMTP id 38308e7fff4ca-2f3be617274mr8424331fa.8.1723796598136;
        Fri, 16 Aug 2024 01:23:18 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:17 -0700 (PDT)
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
Subject: [PATCH v3 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Fri, 16 Aug 2024 10:22:53 +0200
Message-ID: <20240816082304.14115-2-pstanner@redhat.com>
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

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..0ec2b23e6cac 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -950,6 +950,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..5b5856ba63e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2289,6 +2289,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
-- 
2.46.0


