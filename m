Return-Path: <linux-wireless+bounces-14725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1F9B61A4
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A75B23900
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501891EF086;
	Wed, 30 Oct 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri9SWFz1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6131EB9F8
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287711; cv=none; b=Ppm6oQGxTv1E8MApuc/IWvJbxixg+rlJeYpYW31Ke+xFCHSfCODDGterFH3hXDBOfpyBtjz3F7kmIP7XI6PTKPbyKC07x4QPZlflrAEO2MHZGlhWmKNuB8rdfwOw2AhEDMfEaPz0C8CvVYxJqRsyzokzxg8Up3NvqxXD4sGgKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287711; c=relaxed/simple;
	bh=QqrTki7e9vRgulG4RoLLB4/C1pX/5pt58FH2V8wlJVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iV/Oct2hlm3zFVn9frcDqazZxgqaJfsEQqRwjEbZzqCri99qQW01ECHqJikELBIfdR0TTY69L/onlnF616E3XoaMoIXgMAV3qOQ9IzmZw+ldInUBp02EChhSP+mpgh9ILcWD/an04OUmPV+5QMx499IjjL9efvhEf1wplRMBvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri9SWFz1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2mjAvsnCtejFog6952WPlUz5OJHFOOlk35n7fKqpM4=;
	b=Ri9SWFz1aJRSBSnkW4sLfD6m6vNgHDQn/heNqYtJPseE2sz9f5N/6KgMyGuNEUQ+pOa93M
	riEL+m3N+/vnLwZ7yOycTK4WXpoR9EeU0zPR1RwYR2KLV1kucAwyNoih79vw2RPmpUSQhk
	d5BVQNhATfWNoXzVtLoZ3wo3LYfKUQg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-qNRs6c6BNHmlEF2BkTu-BA-1; Wed, 30 Oct 2024 07:28:26 -0400
X-MC-Unique: qNRs6c6BNHmlEF2BkTu-BA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a0d8baa2cso78093866b.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 04:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287705; x=1730892505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2mjAvsnCtejFog6952WPlUz5OJHFOOlk35n7fKqpM4=;
        b=P7GRzBzLbmGHMlwP/upLTtdDSHCVFy4JIDDmeeuhCGvIWrBAqneN/F5G6sCRdyS8a4
         dLgqrQ2AWUA9/BoaHZUQDdn6Cd/Gw+1pKFRIbA9fVM7bwdRn7eOLARi9+6G05Low7Kqz
         li1nJsVA18J4ji8GpZaHwhX9kmU/kzl4RYkpy3lbmO7fPM2xw80TggoL8oHekqVheIKB
         MKZgMF0Wl9+xG+mHQlv+1PGTHjfgz5qln/UPcv9xssiPZuGviG8Ba8UJFwSa5rHXmUGb
         92NjwdypplKuePpDmO+902v0UYXfi1rCKbky/swF4nVRlYcy9VDBqm6Aia982XEHBcs2
         57GA==
X-Forwarded-Encrypted: i=1; AJvYcCWrjlp8VJIgGb/OfAPoxw/H3ye+78rk9q9wwjcZQGsz10vy2i69hI4nxXkqBUgabiaQ2NO4g8sbr0k+Me7dDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLAsYH/rUmPqzOCrXcp4i+IL6tJfzlxvlhEvdBo+gk+wgmzEx
	bEMHc5qgNVbJbzqV8or9o6PMhxjtTpg3OhN7DSn1hvtQ6HHzHkZuM3UEb2vSflyvcozbpDTpoFi
	wh9v5mNztwO9x9e36k6cV6Sz3Drd3dWG7yWFpEnOgWjm9/GsuSmx0UAjxFFHRtDm4
X-Received: by 2002:a17:907:9628:b0:a9a:4101:597b with SMTP id a640c23a62f3a-a9e2b38c911mr465274566b.9.1730287704831;
        Wed, 30 Oct 2024 04:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ON6XbTaySPnV3R7K/gjgoiYFn4kvGUkKymLGG4I2FjjIR+75rc4iLvNfjp7Xook5FqfydQ==
X-Received: by 2002:a17:907:9628:b0:a9a:4101:597b with SMTP id a640c23a62f3a-a9e2b38c911mr465271166b.9.1730287704397;
        Wed, 30 Oct 2024 04:28:24 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:23 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
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
Subject: [PATCH v6 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:39 +0100
Message-ID: <20241030112743.104395-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
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
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3b9943eb6934..4839dcb199c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	void __iomem * const *table;
 	u32 bar0;
 
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
@@ -3659,22 +3658,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	}
 
-	ret = pcim_iomap_regions_request_all(pdev, BIT(0), DRV_NAME);
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret) {
-		dev_err(&pdev->dev, "pcim_iomap_regions_request_all failed\n");
+		dev_err(&pdev->dev, "Requesting all PCI BARs failed.\n");
 		goto out_no_pci;
 	}
 
-	table = pcim_iomap_table(pdev);
-	if (!table) {
-		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
-		ret = -ENOMEM;
-		goto out_no_pci;
-	}
-
-	trans_pcie->hw_base = table[0];
+	trans_pcie->hw_base = pcim_iomap(pdev, 0, 0);
 	if (!trans_pcie->hw_base) {
-		dev_err(&pdev->dev, "couldn't find IO mem in first BAR\n");
+		dev_err(&pdev->dev, "Could not ioremap PCI BAR 0.\n");
 		ret = -ENODEV;
 		goto out_no_pci;
 	}
-- 
2.47.0


