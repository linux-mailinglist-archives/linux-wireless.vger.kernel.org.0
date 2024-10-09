Return-Path: <linux-wireless+bounces-13792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD3996372
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1932F1C23F34
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5B1990A1;
	Wed,  9 Oct 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1lljdRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1A199EA1
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463105; cv=none; b=HPT/l4O4N5xvwtwNzDTeDghTKUJVhxvoXpAWuFv6AHNM/ukvT86fyuEd+Z6GD8IdnxMA3ZkAgkz409ITxNh7n3jtsyT16rfGX5fVEjX4WIS7SN8TQLUk1hJsMVvVOjQq945p2Lz/8a34xW2snTQouhwrl8nHJqmF9uWeMh8WIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463105; c=relaxed/simple;
	bh=j+VCbR/KiPKDGLB6duXvKzwDAwEJ7m2zrLvdpz2kZb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abb1K0MPurpwJ3Prg0NU2s6b4nGmle05VBlhG3tpdSa6yB+eeX2Ag8Zu+eMq7xzo/cJLlE+oz8WnR6AArHagEPXNf2NQoVCPWXDrO90y73kbOaltR81B0rJezcrQEtLvuV0p0Uf5tqeBNc6ymzrmYzJ5GSxGwiKo5JvWaFA8vE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1lljdRH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728463103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ4XyKRMzVRAPh09Ypw2QkYDvdqyB5dqjRwvTDPzI5M=;
	b=B1lljdRHM8pOlU7oUla9Aw1rKryjqENaItp+lDG2oLploSRFayTjOEfrf7MiVJkYjiSpU0
	HbtO8TDYX36bUnJvXGd+eyElTkwOWKZuQRw3T+OC8bHGRFUUMQ/tE5E2fviaKr3FqruXbL
	xx8oNC7rTO8T4dyuV0lZTljZ8nwqCGw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-l6dAR3f6PKGxsMGsLcfJNQ-1; Wed, 09 Oct 2024 04:38:20 -0400
X-MC-Unique: l6dAR3f6PKGxsMGsLcfJNQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9a71b17a3so1133298785a.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2024 01:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463100; x=1729067900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ4XyKRMzVRAPh09Ypw2QkYDvdqyB5dqjRwvTDPzI5M=;
        b=Hi9Cb5OEnIsUXvpZWhtHUkp2NF4V8EhlN++hGIzlGR3uwL9me6c9lpRpKHNv5obAyX
         hj5VnBWWwTpyLJJafgM1iZj4ZbgNp/x45FTvcsqceSMb4Vlxba728GNg4kQhPEUT4l3I
         LpaeKeq5+rpPUvWzqgEJqDjhPjXPXE9Sk1baXbUQhYTboserJ8TGOW8b7OQBiombq30X
         Jma4UhubLosp0ALk4Ssz6DUNMmdZ05BnKZ8gPmfzPln5b9kFbxyhYjVuUm4VCnVwRzAE
         UeqCdOCb5Qs90wrIeBwkNXup3SmJbJAa7AhcATFyF3dBOzF8l7KB5sLICgluxxk7Zga2
         xGlw==
X-Forwarded-Encrypted: i=1; AJvYcCXbbomZxf8bZ6Vw5LLfdvpw/pOxicbaM/pmGXd8REOZPG1EwdPUjWz2bCWcWQG3XGbs6E5WCxjdig5Y5Z0xOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8QJtJCPDNw3Kvt+Uqh+KJ0t6MTV8uyWv2SbHIhXxRFe6cAnt
	i/c8H1A9SclvvpVJgyGddi44lhNmRW5Z3wOEJkGbKk5ii6qn/+BRWGr8VciTrE2HiQFhvPr2zZb
	+HHZeuIpfu/FHYhq1eQDmMJkJMChm5TokCXMk50dKm7J0mIJpdPGGY3pxV/kCxEeD
X-Received: by 2002:a05:620a:191e:b0:7ae:5c5b:a3ee with SMTP id af79cd13be357-7b07954eaf1mr214936985a.30.1728463099823;
        Wed, 09 Oct 2024 01:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEohpGdz3FQCfvuYPGv1Kgp6VmjNVq/mWsuKLRVQIwcRgXug1EQeuW78e0HsYLtO7HnORD33g==
X-Received: by 2002:a05:620a:191e:b0:7ae:5c5b:a3ee with SMTP id af79cd13be357-7b07954eaf1mr214929685a.30.1728463099420;
        Wed, 09 Oct 2024 01:38:19 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm439643585a.14.2024.10.09.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:38:19 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [RFC PATCH 11/13] wifi: qtnfmac: use always-managed version of pcim_intx()
Date: Wed,  9 Oct 2024 10:35:17 +0200
Message-ID: <20241009083519.10088-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241009083519.10088-1-pstanner@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
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

qtnfmac enables its PCI-Device with pcim_enable_device(). Thus, it needs the
always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index f66eb43094d4..3adcfac2886f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -204,7 +204,7 @@ static void qtnf_pcie_init_irq(struct qtnf_pcie_bus_priv *priv, bool use_msi)
 
 	if (!priv->msi_enabled) {
 		pr_warn("legacy PCIE interrupts enabled\n");
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 	}
 }
 
-- 
2.46.1


