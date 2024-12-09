Return-Path: <linux-wireless+bounces-16045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76C9E961E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 14:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9141887FEC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A0F231C9D;
	Mon,  9 Dec 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVmZoDxx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D21ACEA3
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749621; cv=none; b=AafLCWJDp8J2TzbdzbACuip1MXkS7s88MVAPtj0SgdetXbn0Pner/XVQXG1ZcEcZxVuDgaMJqULM+iQ9Y/W1GqOnAMfQCwa42EdPJxhMwNWX33zeXZPkNvRVGK9tMe6V69WBktiTRjup6MA9a3yQ21jMmUx8UkF77H2S54je8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749621; c=relaxed/simple;
	bh=MrbDrpIsvZ1dKVLDYervP0Vycy2eBw/58VpDKwA2pz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWBJZsHnKJxz/+5MeZKpAYiBqx4fAxmIYDAgSjMyQ3x4L911uwMCCbVBxYGQEq+tLCUx4xDKJ3ciZm4al9YiX2PyomoYuTowlsHkKvtDQtr4/Lg8Ufaqiu8GixG7IuzVHdbJ8XV8/Og9vcGwDZoCZ9vZpDshlL+08TFjP3NcSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVmZoDxx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVrHbQL/WtPUoVmg5iNOH6KPahEUlaDR0JYKoVLlaPE=;
	b=CVmZoDxxLkgeW2Xciu8YccLjLIIODkY5hN3b++wZztr2oYUDtwpiP3rmyXK1keATkbZRK9
	hR1Ih2Rw/k+cVNxmATkBgwXdJ+b1CsO7pW3KGJ61naC4LTIcpIhsv0z0oWPw93QYIHppC/
	73KFpcf316eXHcjgUB3CLbhxqNcREkM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-OK81uMNSN_q2Tnn7gDFHMA-1; Mon, 09 Dec 2024 08:06:56 -0500
X-MC-Unique: OK81uMNSN_q2Tnn7gDFHMA-1
X-Mimecast-MFC-AGG-ID: OK81uMNSN_q2Tnn7gDFHMA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434ffe724d6so920595e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 05:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749615; x=1734354415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVrHbQL/WtPUoVmg5iNOH6KPahEUlaDR0JYKoVLlaPE=;
        b=Pwie+L7wK+bISP8nJg5E7i+DPAwAmTsGv8iqv8u3Ix+6X53F9aN/S+/pvLWeIFZJRW
         HzAd78sg9c17qjl0vyGxQojB9ruAzHKcWu7zi+NqqHZeHGl/GkdVSbg9JHTcMbIf5lN3
         +arbeRX0ABYBX9+7ebT+sm4xGZ1S7AC6EOFSfLIsKdmJWXoap1N0T4P/MRkD8ZPtBpsz
         DuMKjWr+oG0QPk3qRGpkVCbL3z9AmiCQZN+jUy1rlZ3/11BTNsTa7R5Ow1sAwtcFillo
         ODHVZdJHP0AQci8qiQ4o14UEg8rKqgrlZ2W/Jj76d/5P8laQ0o5+1ryESOfjjpFc1GPX
         X33g==
X-Forwarded-Encrypted: i=1; AJvYcCUgZiaVVy/XjArcOUQ6ktMS+EOTzsGFwBoUKaHf0ik6PpBEL8sB9IziOxolKlV2HgO4ptDQoj3zmGiWiUPPhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmtzeJ8xXh5+dtpTiQT+e/tukEmOzUZoYspTQuVzqdvbVW5Dr
	MMox1iUdqOcNsO+6MH5UNoOE0ke3XHkNcLlOho8PO0HiVzK6DBOptiTJVVvEiuKPzs4SB1HjRoc
	rVb2qobeP7tb66R5Klc8DzHgj7Z7W3UEaD6QyT1W1bw0479OjePG5S4KIkJFaqRMt
X-Gm-Gg: ASbGnctldEgbOd14kDtBDD3lrrYKzyywDBppxMvXAgvoVkzRmmmbb76qc2q4ktDhdMc
	h+ORwsfvAa09CzLrUm1QHyr1gaGz4Gw1UjcSg7hKRm8H8yZUsjbl/RBMVeVJQe1t0c1iS37BVvF
	ezyBbR+OvzAoIcIbt0EMgl8B8mx61RxOyeYz8eH1eQC1y5FgM/koJmcCY86c2Ff1kQ6VVW+/yFy
	w1/UvvpPlLUwOguVZWQAaOFJwdjnGqhyM9EC/O5pZOY8z3xR/drnuj86DtkLYM93bMnjXGgtp5j
	5R8fAijD
X-Received: by 2002:a05:600c:3544:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434ddeade70mr103095315e9.2.1733749615445;
        Mon, 09 Dec 2024 05:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8dWBtsXMwPpsQh4FEW+o80sVo3gsVutdK8rZwCICXTNWn24DfDXUekpZhDfdomYwt5/+rkA==
X-Received: by 2002:a05:600c:3544:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434ddeade70mr103094435e9.2.1733749614932;
        Mon, 09 Dec 2024 05:06:54 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:54 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: amien Le Moal <dlemoal@kernel.org>,
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
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ankit Agrawal <ankita@nvidia.com>,
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
Subject: [PATCH v3 04/11] net/ntb: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:26 +0100
Message-ID: <20241209130632.132074-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209130632.132074-2-pstanner@redhat.com>
References: <20241209130632.132074-2-pstanner@redhat.com>
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
Acked-by: Dave Jiang <dave.jiang@intel.com> # for ntb_hw_gen1.c
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
2.47.1


