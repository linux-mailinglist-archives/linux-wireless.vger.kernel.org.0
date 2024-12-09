Return-Path: <linux-wireless+bounces-16047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C1D9E962C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 14:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C727163A08
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABB23872F;
	Mon,  9 Dec 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN8Ca6cj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8E233D7F
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749628; cv=none; b=AJ2ke8fqOGnkhn7I8C6giXg0iUMIxPizy9yT1W5I/Dx2G/4Qz2pUdy2l32gOH4fqqUAAeg8eYmp6qix91ZtC0C9ZVyCpQacI+oX1kIh3WsLxQdHA/baVjGCy8wPoNDhJYmQUKKTaHGQzmsQLU7FVmUO1j0FZjzcVfzuT0XqrzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749628; c=relaxed/simple;
	bh=9Z1Cy2anDz0HAw/5Tw9Wb58QkDW/mnPO9GaPuFYE3VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTXpn9lFoqJlf7rx/GMeZX6gdQaOYZhTHi2wZI+tjnzKoYFfgiVGRqYS/oFaL7c7k3a6NsWjqEJnyytxvo1fpr85IF7Db4FhozaE9EZC4X03FkLqbJp214KvgvBaM0QKsz9KjmqGM6axq5HcQdWUlxAUtYvM/VMN1j0uH/sISq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BN8Ca6cj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiILKR2a3QjvArtxAPrSG5MTRD3aI59eir0l7Eg71/Q=;
	b=BN8Ca6cj59vvXYYuhNe3ZKRRHZFODoFZicp6sHJevZdTUj1dosBljMlI8PFM+TVsZ6M7Oq
	S2XD0gdXl7i6le2eVMUqcS557SBG3WGlzN2QJvNw1S+HuWWOxmHBkeuNbMuR0BWFGIe8aA
	8wv1KhdLOSN9vwsmKuZKP4qzlyawzPU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-HvnEwfTTPpua24P6YwRg6g-1; Mon, 09 Dec 2024 08:07:03 -0500
X-MC-Unique: HvnEwfTTPpua24P6YwRg6g-1
X-Mimecast-MFC-AGG-ID: HvnEwfTTPpua24P6YwRg6g
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e03f54d0so1754320f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 05:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749622; x=1734354422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiILKR2a3QjvArtxAPrSG5MTRD3aI59eir0l7Eg71/Q=;
        b=sB69SaYTRAffVz3LpohctwOKDuFF172vdRneaQjIOD7fqtqYhUgCN1Tv/TjeadgTMQ
         wgvM2a8C17HZcP2QHbz/UbK+Ay5UleeqmwJ6QkSuyzH0hoozXmR0YbCsDctiruBJQl4i
         53v5OlT1MXLs1ImGW5c5iB3YHw2Wlk3w9TA8N4EL1Ym5XtZlawYoBQLT5eE2AX6j9ZyZ
         An0NKlO1qrj8xePhw6YyXgfI8zrPUX/t+tyrNNtPghJVsQZ9zhnvs9DOTJVZOfv6RRmr
         K4m8oo0ZAz/bOyKOXDAllkQz7ZMJdIukhpFkCqdMbNFDHtl2qIgdU7gYYzvKE3vZsGYN
         zqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxE0ihDdDzx1QHwEZiZmPf9Tw6sMvNJ8kLqZ5LRG6qkzhAeX4Gocup8fGFHbnIBM0tLWhYs0RGgeCjF3iPxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRKVuHo5U+4R/Up83+bDg4v+UenfGb6YvGcAXHmUAAds/zun3
	U7s+FpbMqN9I/j9Az0X70FAh+d8tRWhwKUKG4f8ZAluLyj+biyTq+EqoynlMp8Bq/5Ba5YOIYY5
	3lgQwfCCSLFUiiqzmopkiZ6HyE3g/Ur6VGrSGR2ufIqZuf4esX7TAUNuDx2DDCks7
X-Gm-Gg: ASbGnctyXw/lnU1aM2c5VW748u6H7T8DiGaNwAsZwsz1XjOwncY7qcyBJmrXkbhqwct
	3j0dQxPRrIXo5c99nzF3lSQftr0y5YcVDAg7l5YlB1XLX0FOP2i5b0xdVJz0b3qPmjDYx+BmXe4
	/TPR8NWM6wZv+tVkX5Ae/hutQ1PVjFFeoPa3eT3lHnankiYqH9MyjmqB1c/yH/FR1gw1I1YQGmN
	9FgtLvgjtphoPbzkGrA/ovZQ1uCRyiHGeHsbXbqI44h2vnc1q092vBve1D3n9ba2T4p9fpbS50Y
	EI5N4vyV
X-Received: by 2002:adf:e18a:0:b0:385:e3b8:f331 with SMTP id ffacd0b85a97d-3862b355ed9mr8982779f8f.14.1733749621864;
        Mon, 09 Dec 2024 05:07:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEcWIoVaHlqXXOi6I/o8U0Sx4v85WRQCbXdmf3r6S4bXIGyWlICGFsXbMo+gcSn1pLdSeKWw==
X-Received: by 2002:adf:e18a:0:b0:385:e3b8:f331 with SMTP id ffacd0b85a97d-3862b355ed9mr8982697f8f.14.1733749621414;
        Mon, 09 Dec 2024 05:07:01 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:07:01 -0800 (PST)
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
Subject: [PATCH v3 07/11] PCI: MSI: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:29 +0100
Message-ID: <20241209130632.132074-9-pstanner@redhat.com>
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

MSI sets up its own separate devres callback implicitly in
pcim_setup_msi_release(). This callback ultimately uses pci_intx(),
which is problematic since the callback of course runs on driver-detach.

That problem has last been described here:
https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com/

Replace the call to pci_intx() with one to the never-managed version
pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/api.c | 2 +-
 drivers/pci/msi/msi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b956ce591f96..c95e2e7dc9ab 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -289,7 +289,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			 */
 			if (affd)
 				irq_create_affinity_masks(1, affd);
-			pci_intx(dev, 1);
+			pci_intx_unmanaged(dev, 1);
 			return 1;
 		}
 	}
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..53f13b09db50 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 {
 	if (!(dev->dev_flags & PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG))
-		pci_intx(dev, enable);
+		pci_intx_unmanaged(dev, enable);
 }
 
 static void pci_msi_set_enable(struct pci_dev *dev, int enable)
-- 
2.47.1


