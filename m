Return-Path: <linux-wireless+bounces-14008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FED199F640
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E36B21092
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB301FC7EC;
	Tue, 15 Oct 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TerFS54Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663D1FAF1F
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018320; cv=none; b=Q4NrAXgNDEYSf6GyXoLa/XR0AkpaEYmbVu+Vl92+1IR7MFP31zXB86l7B74e1sDAQBmmuV41v0hlpWS3aXY0xNBGJwmjRsq8njTvzhAzIfaWXD3u/f5px7RF7iT8/vm1lttPhJMcnUl2CgrGdnUXNi2WlLEKDeb+HCbb/3yK7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018320; c=relaxed/simple;
	bh=aUCGLjcQl9VmrAUkFfZbWR6faxCWERPxZ3SRIvsnn3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqCk5bavMPU4P0p/hlmeh0o2Pw3WAbVk5x1bHemqmTFcNFCmGKffzMgyimdbz0f5IGsbYVGODjfYMWAr2nIZB/WYKgAtN/0G8ZvxhyVMqN6Iw9Z6iffB7QWcJoZ3zSIMAf3ChRKw3pbfFVEjBWWw2weCx4Tqj10VVvA267lQ8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TerFS54Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZ3Ct+htOyFcNtVrHcgotVRsHQNuDZcXgRKY/qB2q+Y=;
	b=TerFS54ZvZomU4AWPkC52dl2cqTF0U6/XCJwmvWvleIzLsmxgw7xD1jpKBAtnsXQwbyTxZ
	844sM3jhBrBhL+nz3MNfh20flTcVxA67aas9z9Be8p21KCryVbPEbabV5xZ02RN9Y4WXRw
	P8QsbIechyzSHprQnZ2Jd1LVY6gdcDk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-EdXeZ8gFNAmtqIntlQLUjA-1; Tue, 15 Oct 2024 14:51:54 -0400
X-MC-Unique: EdXeZ8gFNAmtqIntlQLUjA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c94862c3adso3615914a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 11:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018314; x=1729623114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZ3Ct+htOyFcNtVrHcgotVRsHQNuDZcXgRKY/qB2q+Y=;
        b=BkvRpaQ8nQbL3xVPyyv4v6UPrpc23bgPlCN6zWHwj0v5+rusrlBdLDIRRlcyQsdgzM
         YAqiW71SehTLs5X2YujcozwB49E0VwYOx5yZZxLm5FZIdlI216+CdaKQ9e8sIsIJEZce
         HY02PWp/OO+A6zd/p2JB20IT392SPGxC6IX2dahhnNHIN8qUD8lPkuQnj5bYhqxZA8OB
         od/BthrV1F3c46USs+ILkYqsnz9K+54HkD5I8WoQHmsETeeHuvsls3V8xH0fec81AHIo
         XullxwQMdtVaBa+pHAS1ptlMcEmYHChcKx9EsUXmTdEt5bEAuOu4VLWZBYjb5jUkU7lQ
         lR9w==
X-Forwarded-Encrypted: i=1; AJvYcCXBDJGxpHlrXyHMpGXo42yEQqtoqSAGZQEGWKcdQpTHEN7k1tlgpadLecGlhK7MGfILYcu3VqRb/d2pljfatQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmU3GXG4flW4a0kzAUYYECmyF71kiYyWbXt8FpIqy22/0Ja0ME
	prac3YaESUhkzRZU2H29UqEYtt7I24XbIiflll4rvBazkvSnNgDJalk/v1SnYGraU+t7H2AnT07
	TcY11fURn+8KVHC8VN1isInFsTTW1mGcmnNXfRQHqQQZY1rztSHFtmiXEmnKwIK4c
X-Received: by 2002:a05:6402:42d4:b0:5c5:c4b9:e68f with SMTP id 4fb4d7f45d1cf-5c948c8832bmr14419448a12.5.1729018313605;
        Tue, 15 Oct 2024 11:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6NP2MgEjIAHT9QVnzMFvrKhBgwp9yW28QIpF4WXIKBiXqmi8eGjYmTWyuU93CIou+fVZW2Q==
X-Received: by 2002:a05:6402:42d4:b0:5c5:c4b9:e68f with SMTP id 4fb4d7f45d1cf-5c948c8832bmr14419400a12.5.1729018313119;
        Tue, 15 Oct 2024 11:51:53 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:51:52 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
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
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 04/13] net/ethernet: Use never-managed version of pci_intx()
Date: Tue, 15 Oct 2024 20:51:14 +0200
Message-ID: <20241015185124.64726-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015185124.64726-1-pstanner@redhat.com>
References: <20241015185124.64726-1-pstanner@redhat.com>
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
2.47.0


