Return-Path: <linux-wireless+bounces-16041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A89F9E95DD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 14:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A8E28238A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8800235970;
	Mon,  9 Dec 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dul4uRSR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46835943
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749612; cv=none; b=B6Ms6Ay6g9QWyvLLECYr4JdZXdrQSOIP5CH/NGJGSA9sDG7cQM1eF8QkGS4/wxTSX5HYbWDFsj6DSSVNkj1JUWRw+PjlFTeHKBAvRdZRIwMGdBFJ2bL1xvByX0VJBmXqSw8ps+tR8ejpN53VbDcANGrToBhROe49hvGu7VHUSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749612; c=relaxed/simple;
	bh=Uqm9vlD4EuHqqogtqTHA9FO+0cpdFzd1I9e7PeN+AqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9nH8b5f8rhL6xytgUAReBb1+tOD0VWa7X/JQvpOl0qV8kgUPlqqG3tZ+H1sHwfQXkWzT0uuQELJU2/xKhnJ+SnEgRoVhDjk5FMhyo8N50nT/K+hdJPTQpm4TmnVHvAfDRxeiZEriXF67OvfIKaIv2Z+2R7LicDzz9PLoTI155g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dul4uRSR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChZary8egFvw+XcfiLo4meSQA+SNlXlrlIPLWf6ynjo=;
	b=dul4uRSRqZUyXyCECmoAsglbPjeFBjncpDnCDTaCEOrPWS6FW5fODFsnTnxbmJ/9CSNua3
	RF+ng7NGnz6vRmEszLZXvtYKSZyJYG2EZTDEvHr2PdPrWItVIgwhOnvraWzauqIy9uDr4y
	IoCb9pVhhWALD2Q6GPuwU/sw+756qpc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ZAXuFpwHOcShBtMC4xBkZA-1; Mon, 09 Dec 2024 08:06:47 -0500
X-MC-Unique: ZAXuFpwHOcShBtMC4xBkZA-1
X-Mimecast-MFC-AGG-ID: ZAXuFpwHOcShBtMC4xBkZA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so1674087f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 05:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749606; x=1734354406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChZary8egFvw+XcfiLo4meSQA+SNlXlrlIPLWf6ynjo=;
        b=jrlA/CYwlVkwJxK2B3I7cEZx9v50XuqvXH2X6mg7HHqcPeD330gchHyd4ma33dvu5d
         zpKA0UWwCKAzDE5XccJNV6cPRrIVR+mcTt1dOQ8If47oaVPbhwxwNT7u/8DfMqmVU2mS
         MW3bop7Wd3qqqB03OdPQALDidOPbugQ9yOMI2SMpqWwvqNwwXYlQsq5WZD0fCzFqaH6U
         EAUNo1upICbVHwNqO12YCr0OIMQW3RWP+70L5FARdCMk3b1RGWXkGPk6TB2+dbzqN9p2
         4KHPwgdnG3Et6lXkv7+x5qN2/i0mGU5EKtephCo2bvvLrIpRUmzUzEaOTwomDa5VIYL3
         4OeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOlG+hnP6i/cc7soC39TbKIMB61aP8uCNRo4Y2KMMq3c9mJEbz7G8a0gCzEGgL4Btwr+HW2ueurps5L/53rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQn50rK4PBx2/Y9caWifkN834Mv6ZJF+dS6suRxro7rGZp5fHR
	/sJTrxgW7ch0Oz8qEPlpWg3DCohRRBDs191/Rc/TV9MWT5pzWB+7NPCxF/MpsSQ/TpSbTmkxZWe
	ZLUE6kCLmtE/dAZrFlxMGQNnXCoIrJKumm0xe7MosiDU0eZP2zHu2cMqU08WAj9Bm
X-Gm-Gg: ASbGnct91K45ciG1FtgCioSJ3b3lBI/EzmTWOLDAcCYma0Vu/MlzNzuvlIn+KsxzK+6
	kVpfwzqv2IFa9pzGoK3FUUwKua5uiCAwWStUEWa1Az5JOnr+oCuGUvWzDW/BrN3K1VfPMMbAECZ
	VM1Dy844o+o3Ix5o7etSHEew09Q7QhNFXSsmViPNvrk/Vy2Jf3mW61hPul/jm2Zo5Xbo05g+rYY
	sixIppnJJog38atZZNpR+WIY3mkMqhRmqNGFHBxCh7BwJk0jJAnPyVX5TS9K8+Bt6OgwT2hIvLK
	65oAuL/V
X-Received: by 2002:a5d:5886:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-3862b355e4bmr9451309f8f.13.1733749605746;
        Mon, 09 Dec 2024 05:06:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3aZqcp+qWXyKCP+s6A/eeOG43m5kb4cM7P1FP5MJVsW/bqky4A5d7q1L7C7R7quzo+4CpVg==
X-Received: by 2002:a5d:5886:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-3862b355e4bmr9451253f8f.13.1733749605217;
        Mon, 09 Dec 2024 05:06:45 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:44 -0800 (PST)
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
Subject: [PATCH v3 00/11] Remove implicit devres from pci_intx()
Date: Mon,  9 Dec 2024 14:06:22 +0100
Message-ID: <20241209130632.132074-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@Driver-Maintainers: Your driver might be touched by patch "Remove
devres from pci_intx()". You might want to take a look.

Changes in v3:
  - Add Thomas' RB.

Changes in v2:
  - Drop pci_intx() deprecation patch.
  - ata: Add RB from Sergey and Niklas.
  - wifi: Add AB by Kalle.
  - Drop INTx deprecation patch
  - Drop ALSA / hda_intel patch because pci_intx() was removed from
    there in the meantime.

Changes since the RFC [1]:
  - Add a patch deprecating pci{m}_intx(). (Heiner, Andy, Me)
  - Add Acked-by's already given.
  - Export pcim_intx() as a GPL function. (Alex)
  - Drop patch for rts5280, since this driver will be removed quite
    soon. (Philipp Hortmann, Greg)
  - Use early-return in pci_intx_unmanaged() and pci_intx(). (Andy)

Hi all,

this series removes a problematic feature from pci_intx(). That function
sometimes implicitly uses devres for automatic cleanup. We should get
rid of this implicit behavior.

To do so, a pci_intx() version that is always-managed, and one that is
never-managed are provided. Then, all pci_intx() users are ported to the
version they need. Afterwards, pci_intx() can be cleaned up and the
users of the never-managed version be ported back to pci_intx().

This way we'd get this PCI API consistent again.

Patch "Remove devres from pci_intx()" obviously reverts the previous
patches that made drivers use pci_intx_unmanaged(). But this way it's
easier to review and approve. It also makes sure that each checked out
commit should provide correct behavior, not just the entire series as a
whole.

Merge plan for this is to enter through the PCI tree.

[1] https://lore.kernel.org/all/20241009083519.10088-1-pstanner@redhat.com/


Regards,
P.

Philipp Stanner (11):
  PCI: Prepare removing devres from pci_intx()
  drivers/xen: Use never-managed version of pci_intx()
  net/ethernet: Use never-managed version of pci_intx()
  net/ntb: Use never-managed version of pci_intx()
  misc: Use never-managed version of pci_intx()
  vfio/pci: Use never-managed version of pci_intx()
  PCI: MSI: Use never-managed version of pci_intx()
  ata: Use always-managed version of pci_intx()
  wifi: qtnfmac: use always-managed version of pcim_intx()
  HID: amd_sfh: Use always-managed version of pcim_intx()
  Remove devres from pci_intx()

 drivers/ata/ahci.c                            |  2 +-
 drivers/ata/ata_piix.c                        |  2 +-
 drivers/ata/pata_rdc.c                        |  2 +-
 drivers/ata/sata_sil24.c                      |  2 +-
 drivers/ata/sata_sis.c                        |  2 +-
 drivers/ata/sata_uli.c                        |  2 +-
 drivers/ata/sata_vsc.c                        |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  4 ++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |  2 +-
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |  2 +-
 drivers/pci/devres.c                          | 24 +++----------------
 drivers/pci/pci.c                             | 16 +++----------
 include/linux/pci.h                           |  1 +
 13 files changed, 18 insertions(+), 45 deletions(-)

-- 
2.47.1


