Return-Path: <linux-wireless+bounces-15250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0AB9C6F57
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 13:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100DC1F21D4F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECE2022CA;
	Wed, 13 Nov 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY2zWb8g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB73200CB6
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501760; cv=none; b=FapwRixZC9iNTGX/6Wd2usMyuhnIboBVoVA0jFYXTd7tuC7Egr7plxqFwxUDzQqqM7pwO+gEPnkd5COCJPVcZEtpER2fgDQDVxzzEVcXk3ISRieTtKNAOzG1NmCqNLnI7Bx4n8++Ziird2yTZvyls0ixdQiwbgPQrNaISSXp5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501760; c=relaxed/simple;
	bh=dO0Bt5S9xKcwhKAQUQyexaV6kggyDnL6IVx7RfRRupg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOiiy9GehZwc5SEnfrASSjI6RTBXtZwOZqch5skwvLxm9q3SfD+3Wxpwdxmg2TMP1HUYfwBjOc6s1kz3WQymlLFAnUn9QSgejGV3HeISqczn1NoeCZ3cWqAZK/7CvY56vLE1eeb4r+QmXnfvGIe4ANx5HrendAoaXCnNY3bbg9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VY2zWb8g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UdUsG2Ce2FuhD+Vr0J1b3PhjfLKCU3S+xUJ9DfCqJQ=;
	b=VY2zWb8gPbG6gXH1s73Fkb6J4iDC2pyaem5dDS5/hZ/uR24q90F4I3ex6CkPcRSDXm87/E
	enWzJMRXv3t2fIskDTeGK3nKeqt/DU59vYW6cD09CBrqtSC2N6p9oXXN8QNe+exScjnryR
	i4CubUKKO/veMEoCOirm0gY1J0WP8Ck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-67ZSbiz_Pyy6_9DI0qqKbQ-1; Wed, 13 Nov 2024 07:42:36 -0500
X-MC-Unique: 67ZSbiz_Pyy6_9DI0qqKbQ-1
X-Mimecast-MFC-AGG-ID: 67ZSbiz_Pyy6_9DI0qqKbQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d49887a2cso378735f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 04:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501755; x=1732106555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UdUsG2Ce2FuhD+Vr0J1b3PhjfLKCU3S+xUJ9DfCqJQ=;
        b=AVg30bmp8vHbhBtyHCG/CqeAlPbgcyi1kzgUmTFmDT7Yfbym2cJM4QKe96kMpr1KyZ
         Bmp4m47MeMgkFYjT8YIuwlXOZK89HFwVQp2LEg719bqKsgHA5x0gE0sJZEMPdKDO9EnW
         zMNNnn+5DDlFAtj+JXOgDoWzKW9EednRzeaA/shCJfb0hcq1MgP1/VbKPvoHoMHIM4r4
         vctjFIWQLZJQyPOlURYKQcIG5RpwRqSG8qKSp7nHY3hMIvE2U33YilV78HGJT3/jqi2r
         NipUbWrfJHNSojuqgewD56/+IDUhMBk8s/jPH+gqKCr+m3ywJlT+BbDB5oD9Pivo35dg
         tqcA==
X-Forwarded-Encrypted: i=1; AJvYcCWaq/KWLlvVkVXWk7EYh3kq3587kru8vIAMLdEpEqWlS/H7i512OvpGehtOgnW3NOaMLDYIq14Cvt2rwMPz0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgQETzKV24Nf9JaKVFFNqhQp9eOdu55uxOCpgLKzbrA8z1c2W
	iek6r9BlhkGqNOIlCXI3AIEDZvCAlt2bLlNY3CyfF5ECzMYz4gTzboD+A1a4PhmeF7IlPXmX5yI
	O6/Eyj3Wza2Eyoyde8zC/pHNpkSNm0I8ZWtwxgfRKKxHHlwxqzBE6HmGdGowXGJbQ
X-Received: by 2002:a05:6000:2d84:b0:381:f443:21c6 with SMTP id ffacd0b85a97d-381f44325dbmr11520860f8f.0.1731501755011;
        Wed, 13 Nov 2024 04:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpGOsc1jx0uRyavECo6HCq0VfxiOW2oXCFxduoG1UVcDJiaH+xI1Ywem/WU8zILNl7MjLF9A==
X-Received: by 2002:a05:6000:2d84:b0:381:f443:21c6 with SMTP id ffacd0b85a97d-381f44325dbmr11520807f8f.0.1731501754619;
        Wed, 13 Nov 2024 04:42:34 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:34 -0800 (PST)
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
Subject: [PATCH v2 02/11] drivers/xen: Use never-managed version of pci_intx()
Date: Wed, 13 Nov 2024 13:41:50 +0100
Message-ID: <20241113124158.22863-4-pstanner@redhat.com>
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

xen enables its PCI-Device with pci_enable_device(). Thus, it
needs the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xen-pciback/conf_space_header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index fc0332645966..8d26d64232e8 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -106,7 +106,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 
 	if (dev_data && dev_data->allow_interrupt_control &&
 	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
-		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
+		pci_intx_unmanaged(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
-- 
2.47.0


