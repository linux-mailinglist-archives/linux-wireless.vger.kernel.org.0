Return-Path: <linux-wireless+bounces-16043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D19E960E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CBB188A3B3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8321ACEA1;
	Mon,  9 Dec 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXbKeAaR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F422E416
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749618; cv=none; b=h+Oat5bk+xYgiV2emnsYA9dWTROtDwwVntr/ERu7tgwKtmgG8ueTvdNEm4L3sRT7Q64dlSwzVsxhA6TWzYsdfqtMO+VJLxtHSsUssrVwgwCqY4ihqCz+V+3ZzToqsBYlOCjkzz2HPFANwmdwpR8v1acKZ//u2yNETb7FTQIGSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749618; c=relaxed/simple;
	bh=lb7GonT3+ZCBn5vd8Htudn5MDz8T66fffMcfmzxL9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JURlTpmarStRaSTHtaKWzgfAJaIuCiT8s6a0dKwPiuZGE7d2adUgpVGeFAbiDDydMJN7Bq22pifDRwi+4LR1tGyVCsZY1XaCuGdS0hRS3c5zmPZ1ieQBxnADtoUFVqYWUiO57fVT4+A+Ifc8n//WPDIgBQibbDiHn9onzguH3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXbKeAaR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
	b=bXbKeAaReOFvPWc6VB9+BphR+cbYcTDDePuyUNZGJ+KvUVlAT2MUkTlyJQWuP11IyiFsgc
	46s8Y+tEa6N16xcNK0SJItUEgKPyfiHFayCi+/O2fC+3r4xuP9Sn3Ss89fuk0/KfwB+hWC
	vMTHgRRVb3k28j+KjCHTmAj/Un+rlT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-EVg34Wu-N7mBBDDIN4ZlPw-1; Mon, 09 Dec 2024 08:06:52 -0500
X-MC-Unique: EVg34Wu-N7mBBDDIN4ZlPw-1
X-Mimecast-MFC-AGG-ID: EVg34Wu-N7mBBDDIN4ZlPw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-386333ea577so774608f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 05:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749611; x=1734354411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
        b=avBzcJ8C8krUkMrFZeoAxT0mY4e1I+hmU4zbil4jUDl3ntz6qVBBdPt9cJhfB4wJ+H
         9tkvSij0/rNr9FP4PC0vAVqOWvPNTcaKgwD3CPUUsKRJnnqIizWwO4+HBemTFmoTVGyc
         JolHqS02Kq8Zhl2EQZim6lVKS8YS/VOf8CoJM08mQRlbZCJc+hQzax4VajX0a2IkF2kc
         MdI3HpG2240qSCrNWVtTdQt1cGbdA1aRsdCurAGo5nViRJVDb1WYMpJHCsv+45/s/eXo
         CkSB5WQwVzZgEB+0LM6xUVZiZrerh8+yNm8stRk2+kABhvD6lZp+w+nG+6VKyB3O/BB3
         q8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUEWTv4rapO1rUDSWj1NV+3qgDfHP3bDFmTOV0dda1sQQQHDuOXbSxlWAhse0r3jR4kU70GO9WFDlwmJO82bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1Aknyy+y69Oa0/DAAWFq30JJVoELFgeLt4qLZbYQ5un/DT+B
	KlroYK3OJO9ssTNEg0kD8dcdY6Odk2uu0F2n8EYmNI0OjU8U9KawLFxcNVGFbaZ5Y6Fk4VGBtCH
	VnpGI+09SIyvdbbv0J3+UeUYbdRGjZlfnYU3oS9tGHaLuYWUK9UNcpIhTT0TLqcws
X-Gm-Gg: ASbGnctt/QPmPw+RhMG7upm1R+ZTbhQXkTOxDJ32i/gcOdgCKr+UuVraCBEsdtozzHI
	rIZe5PS9QqXxQ6jA+Rr6fJuPPTlfx0+LUnAxfSW3sZcVho+BdWWLO9/GFkkzZvYv03d8eoXkCR2
	G54ucpCDjiRR0UpaTjw7W3J1Y7D87Tkhy3ezbBJgQ6+b6DLC/y+gK49YqYmXR4PD7VQ9H3SPCHc
	Ng/DdzY4cMs0ZqGbHI+KIq53HclvNH4Dl8ymJsjfQ1p2O6WuFs4Vh/vwg6qpkE1gZrWaS7iqCwJ
	Ti4EM+lH
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224934f8f.47.1733749611231;
        Mon, 09 Dec 2024 05:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYLGzMuES8pL8UNwc6rduiHNSssmgKFMI0arqDxmQvwrHwV9r5BJKNGyDbmmGP7hHm3hITRA==
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224791f8f.47.1733749609723;
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
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
Subject: [PATCH v3 02/11] drivers/xen: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:24 +0100
Message-ID: <20241209130632.132074-4-pstanner@redhat.com>
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
2.47.1


