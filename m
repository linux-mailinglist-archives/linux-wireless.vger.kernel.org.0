Return-Path: <linux-wireless+bounces-15252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA669C6FA1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48B7B27EF0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F7205127;
	Wed, 13 Nov 2024 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUBUb2sJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638820370E
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501766; cv=none; b=khE3dUJ84zoGG3cSyD1VncS2n+Mc+yOF9HtYGnTgfzSOFGaLXhuKfG4WxDAPjaXUcqBibNMn/Gi4cew8AkiuTSArpsDNw5Qz/Vc08YsdcrEk1cipkh8NuRA4IZl+MGdfTbZq7GIHADsrNloVYStaT+TrZjUGgHCTHZffIHXuBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501766; c=relaxed/simple;
	bh=FwPT6FGBHOp4TzyWZ+h6yZzXXEFY9IxzClXNmK7SQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKuN8BgFPe4hh3NaYzYLaqxj1hSxJ7MkneLOmdF+2ffubMX2OH10VBHLj8HWeVN+sZXjt2+29jTzzo32nTsyFxW/ct+/6mI4s8TKwo4M2O/000U+J5hIWXzcdGOZZpH8FalPekaV6DMhNADLxZe4+0v9xH4sxJbyq1TffXNvGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUBUb2sJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gh5xBESPiuO8YtWqrs+YzUNc8fkB81YlCR9KwN+kONI=;
	b=JUBUb2sJ6lmLtjD2P+zpgM/hMKmQgPxZ4LkmPmnHXriC5evhoMxhguZvZCUSzt5LXTBkMV
	kxS0VS4tADjKCdYYzfzQjpg3kd1zAcYOQvrFl2xFPXEMciBavlInIrQ5SfxS5+wkxzRi1D
	xCrriWhrIBToFTdElOFVSdjBfCPDOSI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-ePLnQqx6Mw2lxDXNujXLHg-1; Wed, 13 Nov 2024 07:42:40 -0500
X-MC-Unique: ePLnQqx6Mw2lxDXNujXLHg-1
X-Mimecast-MFC-AGG-ID: ePLnQqx6Mw2lxDXNujXLHg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-381d07c377cso5245814f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 04:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501759; x=1732106559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gh5xBESPiuO8YtWqrs+YzUNc8fkB81YlCR9KwN+kONI=;
        b=jN1VPMP03ihR4hL8xAKtDKiYlmzq7AXBfbM+zQ0on85sAYJ3o0RwoY7A3EjxbEwO15
         6VaayyF7W86qySOu47QpZ7eHqOgHo5tCY/LKibhmER3AZy2DVsB9YIJTnyrtKgdTZK/d
         yIr1+jQaSITtHXo9Bvl4GQCeo3NYZKbHlfs2JjTXLT6XO8Z4r/cYx3W02EuNuhClsTTH
         dlCwew9GWQhvBBpYUcfTx7CHn1zQErxqr/Dx9whEYjXMln+MZiSfGbN2/67Ums+ujKed
         DzztfOMdvImf9+JaGvDTpyGoIaD3LYUIYJCzM8lBuvXQjV9otRjWN4AeSapqeAWMmgq8
         lV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXPBAgIlAQ2fkucODeoLIrnw9QVBFRaxYn2SdnJgaSEKeL8XE6fbseI2SGt2hEUaVUQ9/HuOlaXCR/hrJiqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS1DNehIVmLSFH1JwcUHHir/ekxZ1KlxmFB2LZZxYciWCVKHui
	JLQOYWhsBGedlEwFH4xioqQWeSi3nmzW2iRZvaUluLGsAxv1tzoZNx/Zg2Uto07VEXSxR1Neq/A
	PD3/i7/mekLESvTKHDN8tfSQ25sgB64qI5QdCN9tipTaKLwFEUl5wyGgngSaLU+v8
X-Received: by 2002:a05:6000:1868:b0:37c:d1ea:f1ce with SMTP id ffacd0b85a97d-381f1871ae1mr21127520f8f.25.1731501759605;
        Wed, 13 Nov 2024 04:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjSkicOa2vHaglKeMl2d4NOiMMxDq6ITRAVtvhVhWcLJvAFiM/FAEZ/6qNVryGFEz3sYUTmQ==
X-Received: by 2002:a05:6000:1868:b0:37c:d1ea:f1ce with SMTP id ffacd0b85a97d-381f1871ae1mr21127442f8f.25.1731501759149;
        Wed, 13 Nov 2024 04:42:39 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:38 -0800 (PST)
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
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 04/11] net/ntb: Use never-managed version of pci_intx()
Date: Wed, 13 Nov 2024 13:41:52 +0100
Message-ID: <20241113124158.22863-6-pstanner@redhat.com>
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

hw/amd and how/intel enable their PCI-Device with pci_enable_device().
Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com> #for ntb_hw_amd.c
---
 drivers/ntb/hw/amd/ntb_hw_amd.c    | 4 ++--
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78..b146f170e839 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -791,7 +791,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
 err_msi_enable:
 
 	/* Try to set up intx irq */
-	pci_intx(pdev, 1);
+	pci_intx_unmanaged(pdev, 1);
 
 	rc = request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
 			 "ndev_irq_isr", ndev);
@@ -831,7 +831,7 @@ static void ndev_deinit_isr(struct amd_ntb_dev *ndev)
 		if (pci_dev_msi_enabled(pdev))
 			pci_disable_msi(pdev);
 		else
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 	}
 }
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 079b8cd79785..9ad9d7fe227e 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -445,7 +445,7 @@ int ndev_init_isr(struct intel_ntb_dev *ndev,
 
 	/* Try to set up intx irq */
 
-	pci_intx(pdev, 1);
+	pci_intx_unmanaged(pdev, 1);
 
 	rc = request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
 			 "ndev_irq_isr", ndev);
-- 
2.47.0


