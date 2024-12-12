Return-Path: <linux-wireless+bounces-16336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42809EFCBB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 20:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E571882120
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3019995A;
	Thu, 12 Dec 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjOL4fMq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659C18A6A3
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032966; cv=none; b=fZ20CsXKevOPYeCXNe48+6xn7qXeaHGUqcB04WhryYFN7jPosUviEvcPVNB+UR4m/Xa5n38uXT/4A9rQtqpUa4MjqYRR9qst7jf9ziUnnvQ882vk8abRRoOQbX/6E4GWjgWiSMirwmbbm0YvCab22wf3wvcDxU9XIzNLq+grfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032966; c=relaxed/simple;
	bh=c0lIVwJsvJS8Q8StF7zcpZ/c/aEc5d0bbzatxAJuRSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiRCnQ5gyqjak7NKUpUSfQKjC1yJzSQuR8cax0PVla02TgrlBcbn9BR/5uR1bwKRzRe08kWOW46Qrk6qkmCDZPFpNCyhu6R4s2HV9f6Wf4hk5PwGXOUoGgLUOfSHBrmeZ/utOb9AeLx1kIjfZHLmmBnpzRKTwM5YIrPcrZcBnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjOL4fMq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734032963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBiPw5OuI7dlO4Z4t4oS+jtz5kPmxd4ZnxuDxig2hUM=;
	b=gjOL4fMqzHZ/IO3tgHl8lojM40em91HWsjhswwEkjgbgXAikWI9wt319d7d6BhryRyrxqm
	U8bs5vPMtxGGa+G4RZvgeBjb8Q04zJU94syrREkfOpe37B4YCEaOQq1abGQ8RldEtWu4ew
	69ZGaFqQRIWJB2FvH5E8/xoT5Y/JYto=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-HutegGcaP9u2lKKXKjoXTw-1; Thu, 12 Dec 2024 14:49:22 -0500
X-MC-Unique: HutegGcaP9u2lKKXKjoXTw-1
X-Mimecast-MFC-AGG-ID: HutegGcaP9u2lKKXKjoXTw
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841a803534fso10477239f.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 11:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032961; x=1734637761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBiPw5OuI7dlO4Z4t4oS+jtz5kPmxd4ZnxuDxig2hUM=;
        b=t0bJLskbqXVTQ79ivuR0+6axYRY/HOv6Mv6dGgymb7kxY43vRu7ImyjdZka7yRhpcg
         ZN/PgWYxuvwM5t9HJisMdDSXwvx+XiQ3A36UFXjt1ctDyc28kYtvBGZ8PuqBCib0Nf0X
         L8IGZoCLy7d95xRe8uyL3NYtdGHl2vgTrZXwUb9LW1/0jKVcSvmE7BbKCXQMYPdyAXeP
         +vwCoOfPX417vkf5mXTrm1FE0bB8lAXs4EqQZckzGjKkD0nKpRaxJcJ0ppJWkV0/KJwv
         X2SyySpyZUb6rcf296dn8ORR8B7qYv7SS+ER1T69+KcrvvfTUnYsJiz7svLtf0/rr4C6
         tP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCViMdzQboDsvTVBkIzYHzY0g4iTUK5u8PNHyc/e8crvpXIwxP6+TeVNLcugzcQrY4IZtl4RJARgi54suO0Skw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtwVm9NLlDfyFZ1JfJVN5Zs8BbjAQMl4m+khuDsrdAit9aLR1
	UsFuM4e6DWa6vV4BDO3++IszfAADkrHBcmM2vUt4QUKXaciJ6KTGjQWETNFSNYwE9z94iv4WsSG
	YMi0Cm2B2f/D70fH4m281sxty76iW/tLpcbl9usqTq6n1vLLqrH0TsFOFtsStP7E6
X-Gm-Gg: ASbGncvkb60Fi66D1VYx6VgEXWHA126Svfidkqp6nTDsNbR7osusn47pxpRpr73/qMd
	0zdhf7c8ISNjcqGaEh2iMw9WF3kj5OyxKPVSkdLF4sm7rqNP5x90m63gt9Qd0ZGW5oqp5Z/V6M5
	iWYSCrDZjos+045uN2fBsTZFoNFpn2ovGj58mfcCNqrMChbrr9tgtIjpyUm8dAVbLL0VSr1R38D
	vGAoBOXFa26CqNYBR5hPECvZ6LgXqAlR1rpXBeOBWyMASPWm9a18LZ6X1Hm
X-Received: by 2002:a05:6602:1593:b0:83a:acc8:5faf with SMTP id ca18e2360f4ac-844e8a3f0b7mr2642339f.5.1734032961310;
        Thu, 12 Dec 2024 11:49:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERcvaNomxn8th3z3SWMQIAn0f18rUBb5b4dBUVRvcRJcJEoHv6gpei7+xXPBScGwtQKEbPgQ==
X-Received: by 2002:a05:6602:1593:b0:83a:acc8:5faf with SMTP id ca18e2360f4ac-844e8a3f0b7mr2638439f.5.1734032960861;
        Thu, 12 Dec 2024 11:49:20 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844737bc5e7sm434751139f.7.2024.12.12.11.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:49:20 -0800 (PST)
Date: Thu, 12 Dec 2024 12:49:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Philipp Stanner <pstanner@redhat.com>, amien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Chen Ni <nichen@iscas.ac.cn>, Ricky Wu
 <ricky_wu@realtek.com>, Al Viro <viro@zeniv.linux.org.uk>, Breno Leitao
 <leitao@debian.org>, Thomas Gleixner <tglx@linutronix.de>, Kevin Tian
 <kevin.tian@intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Mostafa Saleh <smostafa@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, Kunwu Chan
 <chentao@kylinos.cn>, Dan Carpenter <dan.carpenter@linaro.org>, "Dr. David
 Alan Gilbert" <linux@treblig.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 06/11] vfio/pci: Use never-managed version of
 pci_intx()
Message-ID: <20241212124918.0dd284fe.alex.williamson@redhat.com>
In-Reply-To: <20241212192130.GA3359535@bhelgaas>
References: <20241209130632.132074-8-pstanner@redhat.com>
	<20241212192130.GA3359535@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 13:21:30 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [cc->to: Alex W]
> 
> On Mon, Dec 09, 2024 at 02:06:28PM +0100, Philipp Stanner wrote:
> > pci_intx() is a hybrid function which can sometimes be managed through
> > devres. To remove this hybrid nature from pci_intx(), it is necessary to
> > port users to either an always-managed or a never-managed version.
> > 
> > vfio enables its PCI-Device with pci_enable_device(). Thus, it
> > needs the never-managed version.
> > 
> > Replace pci_intx() with pci_intx_unmanaged().
> > 
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>  
> 
> Not applied yet, pending ack from Alex.

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> 
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c  |  2 +-
> >  drivers/vfio/pci/vfio_pci_intrs.c | 10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 1ab58da9f38a..90240c8d51aa 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -498,7 +498,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
> >  		if (vfio_pci_nointx(pdev)) {
> >  			pci_info(pdev, "Masking broken INTx support\n");
> >  			vdev->nointx = true;
> > -			pci_intx(pdev, 0);
> > +			pci_intx_unmanaged(pdev, 0);
> >  		} else
> >  			vdev->pci_2_3 = pci_intx_mask_supported(pdev);
> >  	}
> > diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> > index 8382c5834335..40abb0b937a2 100644
> > --- a/drivers/vfio/pci/vfio_pci_intrs.c
> > +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> > @@ -118,7 +118,7 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
> >  	 */
> >  	if (unlikely(!is_intx(vdev))) {
> >  		if (vdev->pci_2_3)
> > -			pci_intx(pdev, 0);
> > +			pci_intx_unmanaged(pdev, 0);
> >  		goto out_unlock;
> >  	}
> >  
> > @@ -132,7 +132,7 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
> >  		 * mask, not just when something is pending.
> >  		 */
> >  		if (vdev->pci_2_3)
> > -			pci_intx(pdev, 0);
> > +			pci_intx_unmanaged(pdev, 0);
> >  		else
> >  			disable_irq_nosync(pdev->irq);
> >  
> > @@ -178,7 +178,7 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
> >  	 */
> >  	if (unlikely(!is_intx(vdev))) {
> >  		if (vdev->pci_2_3)
> > -			pci_intx(pdev, 1);
> > +			pci_intx_unmanaged(pdev, 1);
> >  		goto out_unlock;
> >  	}
> >  
> > @@ -296,7 +296,7 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
> >  	 */
> >  	ctx->masked = vdev->virq_disabled;
> >  	if (vdev->pci_2_3) {
> > -		pci_intx(pdev, !ctx->masked);
> > +		pci_intx_unmanaged(pdev, !ctx->masked);
> >  		irqflags = IRQF_SHARED;
> >  	} else {
> >  		irqflags = ctx->masked ? IRQF_NO_AUTOEN : 0;
> > @@ -569,7 +569,7 @@ static void vfio_msi_disable(struct vfio_pci_core_device *vdev, bool msix)
> >  	 * via their shutdown paths.  Restore for NoINTx devices.
> >  	 */
> >  	if (vdev->nointx)
> > -		pci_intx(pdev, 0);
> > +		pci_intx_unmanaged(pdev, 0);
> >  
> >  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
> >  }
> > -- 
> > 2.47.1
> >   
> 


