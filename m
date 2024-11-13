Return-Path: <linux-wireless+bounces-15256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1119C6FD8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 13:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D5EB2DBEB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9235206060;
	Wed, 13 Nov 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMVLuTmA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540620606D
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501773; cv=none; b=Z28O3Upq97JcSMAZhTuiegAWkIDLTBk2hP0a6fBSfBHfpOmQe68TalXVOojzViIUYdwCTaHqvq86rfyNJiVakiOn99gbckrcFMq5GKu9Izx7sfRXN18We1EOy/Euix4aqcq4D78m4BSi+T8Wj0nz5Zwqtz5PNFVuSeSrGgvyBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501773; c=relaxed/simple;
	bh=MUiRmak5FNTX4BeqThw6CC4zJAkFAsefAFRx+ZXrFxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovKRG2uo+XquqFfiqKabG54/cABiDpF+oC3spswGyItb0Tdy27fLhfGg0UC0J5Nsz67YZ/SkQsa/TNTf5mEGKpumX10dx+00AhwH+a58wBj3yKXJAXiAvqpZP3QeRNtB6WbFcG25Rvklv30HLt5p83JyLUF/5rQmIPp+lLPJX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMVLuTmA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5TnIcD2VuI/o8JjOCySaF7mhNl7bXEt7dRvprez4ds=;
	b=DMVLuTmA0kuh2jx7qyVMqg6NHUoDUxiqlWTE5R60UCm3EfyfsD0qmRDwLvOaJifTpQCXP0
	FJZyOsn7RJcqgZV7z1lhKyPz0wUBQ8zFLJiD8L+m8tt+UY5YBeBsnOpUWSwS5pwVD0jplE
	pBR6m2WDAhRfVC/d6LvLoFvTxZbDtAk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-xUNu7fy3MNKH5xyL_8AnkA-1; Wed, 13 Nov 2024 07:42:49 -0500
X-MC-Unique: xUNu7fy3MNKH5xyL_8AnkA-1
X-Mimecast-MFC-AGG-ID: xUNu7fy3MNKH5xyL_8AnkA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4af408dcso3517869f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 04:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501768; x=1732106568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5TnIcD2VuI/o8JjOCySaF7mhNl7bXEt7dRvprez4ds=;
        b=kFPPfFc+tNeASIAJVYMBD9I/BfWvXUYCxDwzoHL8beaEczdqJ+ev1nf3cPZ/7TQiOJ
         mWnP8VN46ksYBM+dfOtk2MpdeBVuHG1NAfosTdAorfV4quDfonJP2sbOdFghKEtNUZSJ
         y3y2jKSx3C4p96jp2PXfixVz0a1AvK3PH9i0iPx22XMcPPSMzirjM2DhI5LBhGpCUXKC
         1upCKHO0A8HJP2ftoLkAkTG0GocHOuRz78/Mljw0T4dvXe1g6oSuP3HSIC4KzSNHrTQ5
         MjwMckNhxiLbcbASQn0E89fZ1NLzdAnxbnZ43liyOksr9mL04ZhggBKVWQY2gyzqM+xR
         OKLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7lhoY+hKV9qd1X6b0ShI6f23ulapRXlqpSh3vehnxTwfPAVh1q5KHaZnkn1k38DQcd/DqRNluLTrkyvGzKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpszOifUlgreSgvN3XrLaLrZ5V0DYncLSbqs3Qt0xttNXweKcO
	IW9nHLQTvpIC8R/u4jNtgvSomhXmIKh7kmVH2RV88xqxbPb0u882m+OHtoBMlwmq8Vqm+I2XZQl
	LjGcobYRpx2EnpLiZqWZ1Ai2/RCObEwxjQcC3k7jeh10E+FKK1OVMd6AG9KKUNqZ7
X-Received: by 2002:a05:6000:1849:b0:37d:4fab:c198 with SMTP id ffacd0b85a97d-381f1872412mr16049027f8f.26.1731501768606;
        Wed, 13 Nov 2024 04:42:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENWR7lbl0r7wQqB6gDJ8hrTMl+DYmwC3EqYiDIUkKDx+oOeWHz/jLeLc4U+c0kMvjHX7biQA==
X-Received: by 2002:a05:6000:1849:b0:37d:4fab:c198 with SMTP id ffacd0b85a97d-381f1872412mr16048957f8f.26.1731501768174;
        Wed, 13 Nov 2024 04:42:48 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:47 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 08/11] ata: Use always-managed version of pci_intx()
Date: Wed, 13 Nov 2024 13:41:56 +0100
Message-ID: <20241113124158.22863-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113124158.22863-2-pstanner@redhat.com>
References: <20241113124158.22863-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

All users in ata enable their PCI-Device with pcim_enable_device(). Thus,
they need the always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c       | 2 +-
 drivers/ata/ata_piix.c   | 2 +-
 drivers/ata/pata_rdc.c   | 2 +-
 drivers/ata/sata_sil24.c | 2 +-
 drivers/ata/sata_sis.c   | 2 +-
 drivers/ata/sata_uli.c   | 2 +-
 drivers/ata/sata_vsc.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 45f63b09828a..9273ff3d4732 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1985,7 +1985,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
 		/* legacy intx interrupts */
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 	}
 	hpriv->irq = pci_irq_vector(pdev, 0);
 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 093b940bc953..d441246fa357 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1725,7 +1725,7 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * message-signalled interrupts currently).
 	 */
 	if (port_flags & PIIX_FLAG_CHECKINTR)
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 
 	if (piix_check_450nx_errata(pdev)) {
 		/* This writes into the master table but it does not
diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index 0a9689862f71..09792aac7f9d 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -340,7 +340,7 @@ static int rdc_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	host->private_data = hpriv;
 
-	pci_intx(pdev, 1);
+	pcim_intx(pdev, 1);
 
 	host->flags |= ATA_HOST_PARALLEL_SCAN;
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 72c03cbdaff4..b771ebd41252 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1317,7 +1317,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (sata_sil24_msi && !pci_enable_msi(pdev)) {
 		dev_info(&pdev->dev, "Using MSI\n");
-		pci_intx(pdev, 0);
+		pcim_intx(pdev, 0);
 	}
 
 	pci_set_master(pdev);
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index ef8724986de3..b8b6d9eff3b8 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -290,7 +290,7 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_set_master(pdev);
-	pci_intx(pdev, 1);
+	pcim_intx(pdev, 1);
 	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &sis_sht);
 }
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 60ea45926cd1..52894ff49dcb 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -221,7 +221,7 @@ static int uli_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_set_master(pdev);
-	pci_intx(pdev, 1);
+	pcim_intx(pdev, 1);
 	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &uli_sht);
 }
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index d39b87537168..a53a2dfc1e17 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -384,7 +384,7 @@ static int vsc_sata_init_one(struct pci_dev *pdev,
 		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
 
 	if (pci_enable_msi(pdev) == 0)
-		pci_intx(pdev, 0);
+		pcim_intx(pdev, 0);
 
 	/*
 	 * Config offset 0x98 is "Extended Control and Status Register 0"
-- 
2.47.0


