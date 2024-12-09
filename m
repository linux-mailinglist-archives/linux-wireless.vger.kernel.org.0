Return-Path: <linux-wireless+bounces-16044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A29E9619
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 14:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B467F160851
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71735230D28;
	Mon,  9 Dec 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Au9aChgh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07223099E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749620; cv=none; b=amhLOYulFFe7qhgPAzSKXU60qV0ZOolWvQhqx+ZPxTeOCM1bULkLP51wh1RM2grupEiLQBMjCV5L6vWht2toNmjq9BZt3J6K1tIS38CbOMbIsY3CRtFnJJbY0nd15N+/l10ny9ZngHudVhAJiUgH019P1Z42D+tjLBkfUzCla7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749620; c=relaxed/simple;
	bh=mRkzqov/CYtFiWjgkuQOlRqwmB3d1pt6U/jB6t5Syi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmgw3d5I1rkPkmukHzL1NOhHHHuR27Q+LJwZIsFVboklGu++8hSXoT/eJmkAqTCR8vCf2Rrx93kqCRu10sNCD7HxAHgJQXhdP8FPKOtwzN9zsvuUVsUxlSGzfWe+Y0pDQzbGJDcJHFOEq97/vw1MajU9R3gcYIgKpuLnBXExRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Au9aChgh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
	b=Au9aChghEyoUtTRyNim+qcYV+dp+W1H1GKtS8cMFRPK8nIizjrcbVB3xrnN6Q11bB2z1ZL
	Zmwtoh8PUkQrr6cS2Zx6eh/yHzgqMAIFDDQ3Mak+hgR0+r4/xjOG7tzOEc68j4GY5ZjYl+
	w9sVCp2Vd5ajw2bdb3Cxdy6mLyK+2lk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-zFZnTYTtPLqQxP7DyZyIug-1; Mon, 09 Dec 2024 08:06:55 -0500
X-MC-Unique: zFZnTYTtPLqQxP7DyZyIug-1
X-Mimecast-MFC-AGG-ID: zFZnTYTtPLqQxP7DyZyIug
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385f0829430so2934811f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 05:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749613; x=1734354413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
        b=kKZHrjIgOy5VT5ShxSZPaF31r15cgP/73fmJRK60kvDTgRYLNUHWgzBA9Gy8isGGNX
         72PKZPCEtPIvdfyF2U73gdjM/jV744mXLQ0TcPeVEhmuYVWzP2tKw7OQqDEBXQjrpD66
         ZPGzz7/QJt90AjqmWtajCRVb8NU5Ck2qCGAiy0x4LzF9Hdi7Hnd/Z39nVQDLD6Pq37z5
         URVahZrPREVJ+IcxpHumwGF1OHziRhsS9gkBd0epcpoR1kAUiR3YS6/mfYp84ZupAdF3
         dbIGsKdIY+sHLNHsCwuhmTV/0319EjLTalQmYPs5WodK36b1SxdLWKqpE8ZbK+IWvTa4
         omrA==
X-Forwarded-Encrypted: i=1; AJvYcCVn30odtXHtfK0rG3b0P735dN7nu63qAAvgwDotda0xN1sNSxUPiwA7lAQzTim8CT/EwGFSW1vzesnTuhjLNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpWP2TqF/K4AtZ6fcHN/jbOAIU+ftOOLVskUqh3jaiUHTvZ/O
	aYLDWswRDTFMIDQMmrzFev6EeF9Z7Pm61eZkycUmD7lw1Fnofln41SS3l8F0vh8CIpBG/w4tQhi
	LqmB7e5gYEXXAUjwPyIUpOsNFoyegat8kMUuR/CCqe3LiPTRjtK9jEWiHuBFaoeTD
X-Gm-Gg: ASbGncvnTquBAigNLgAMCyUZURGgBXMGBdlCfDzoRaGJYkPQZzt+4s7XEuOPhBAUoWw
	fCl0I97UZu89ZtZ3VSDvvUxa6qcCXBtLkjY1WYiAuUz+x5AFRYFiquZC+YIsewjamBFJEc8zOEY
	/q7pNu1dAf0rryKTsGlPiAs96YdnhXhdfKBRHBT73rRJ9Pe7120aQDLuAInYSnYvPB/rZcrIsms
	pnQBGe8HaEsv7HyEyBNri1qWOFjS+Zmz54mlmw3HNCLRtFe3kP0m3awD8yd7vnJ6Ybth7IYBN2S
	xkBPSo4d
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188127f8f.54.1733749613295;
        Mon, 09 Dec 2024 05:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj1wppsmKOkdvfdKSfuff+I9JjxqlZHOEEdHEk5K3zylRh/0qa/2JfnJnGp4etqXepLTEqow==
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188043f8f.54.1733749612866;
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
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
Subject: [PATCH v3 03/11] net/ethernet: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:25 +0100
Message-ID: <20241209130632.132074-5-pstanner@redhat.com>
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

broadcom/bnx2x and brocade/bna enable their PCI-Device with
pci_enable_device(). Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 drivers/net/ethernet/brocade/bna/bnad.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 678829646cec..2ae63d6e6792 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -1669,7 +1669,7 @@ static void bnx2x_igu_int_enable(struct bnx2x *bp)
 	REG_WR(bp, IGU_REG_PF_CONFIGURATION, val);
 
 	if (val & IGU_PF_CONF_INT_LINE_EN)
-		pci_intx(bp->pdev, true);
+		pci_intx_unmanaged(bp->pdev, true);
 
 	barrier();
 
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index ece6f3b48327..2b37462d406e 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2669,7 +2669,7 @@ bnad_enable_msix(struct bnad *bnad)
 		}
 	}
 
-	pci_intx(bnad->pcidev, 0);
+	pci_intx_unmanaged(bnad->pcidev, 0);
 
 	return;
 
-- 
2.47.1


