Return-Path: <linux-wireless+bounces-14856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E79BAF96
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4A21C21370
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506C1AD3E5;
	Mon,  4 Nov 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hs7Ppm7w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C86FC5
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712419; cv=none; b=lKPkSwYKe6nkn/hZCXqRsukoObX19rL9ljZwrRBpNX1kQwM4SyyrbrnxSy3JMtokiFHQ+cIQjvsvhW1yMdlXM0WmX+n9BmvP+WH/Rfbn0ExU/p5G6ZmS8ePViawVYCB11Qxy+qDXeU8G0BMt++AjMQ6D4gERC2M4oeuwujGwecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712419; c=relaxed/simple;
	bh=M7ueN/LQ529FLGouL/3BXVgrjx8tY87847WIrlhrom4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+Wap/Mri/ThOu1eEwhOmyCCflaqN7kH1m8lWiIruZh251B7DWg70SXHw3c6cXpBn7ISMTPITTDFz8mjrDc/eBu6oeVQMUMjiGZmdSvgn7NWQNmmtFlAAP4FoGqGgT6kc0JDB5ZlooO9zxIlQwafMfbNdVtCkizAGJvBiU1+dHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hs7Ppm7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730712417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7ueN/LQ529FLGouL/3BXVgrjx8tY87847WIrlhrom4=;
	b=hs7Ppm7wXaEwXylZk3WlnuRhOBVi9EZFeFaHA5C2kpvSH/VjkVm6K0TiNsnRe0z8Kj9ISO
	QeHbTMdAtNM8OMz7ZsX56g97CaQyWzdOZ7ETkNzghr2NW+8F20RyIMZTCqi56KBYvwZI4U
	2b2TxZfnuV5aUNIoqBdGJ9P5nVrVU+4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-henS2Ao_OfeOAyd6rSyiMQ-1; Mon, 04 Nov 2024 04:26:56 -0500
X-MC-Unique: henS2Ao_OfeOAyd6rSyiMQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d563a1af4so1892486f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 01:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712415; x=1731317215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7ueN/LQ529FLGouL/3BXVgrjx8tY87847WIrlhrom4=;
        b=naN8CAq/5IiiWsZPFqA5r6YuKEiM2U5ro1mRQEtPy4k6EALoDTp0uuoEDBgtqVOBdE
         IIQrtAgUYOzQ4WQSJb26ePtt1gFH8M8k98o5HPYNYIFY+0FuN7dk6wStvBBbsI1JjByo
         o8r9d0xiQ8h/VI4nUBCdY1iYoI9u8KGUPU0EQw4oQo226EXFxopm9L6kbktyoICZhzzf
         p+2rz1WIhSyyaD1w7LJwocjWs25cmLr3S36LgA1lCipwqOYODD5jc6hca/u/nANzCSkW
         gBg/rzuag0AkcjrvIMz/my3IGu0ZcLFLWXf8/7WFfE7EzLdyGOwF9BVg7WLKt71FJbFp
         hEjA==
X-Forwarded-Encrypted: i=1; AJvYcCU+4d8DR4oBhT7F6XKRQHpWLwwaIHMvcFouUtA6psLyPLFC/NjCKcyJa/MK2/A4oeChRXCr19cscrko7aoj6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+e85vG6emmRBvoJZrTnImA+rR3FQ2Odaf1YUuh8ZdjYlxzKL
	Z3Imzl6Sd+cmdn5Bq0SW9ePM5L7zIsMzEqzlZqGstLD7G56yzOQ8NKCOfULn4qDvJ7O9rH80Ztk
	EGsxuPLR8UpxvFH8qRvvMzUqH7ACzeYLJmA0XcpP6uo6/nH6UGay+qmTiGfq8tUGV
X-Received: by 2002:a5d:5f54:0:b0:37d:373c:ed24 with SMTP id ffacd0b85a97d-381c7a3a49cmr8192672f8f.4.1730712414707;
        Mon, 04 Nov 2024 01:26:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUG4i3r4RT/0mDz+U1cY7m40dZcu2ijC6eEouX1uNQBldOHTZd5hoduIq2TUsnjYO3wLrnew==
X-Received: by 2002:a5d:5f54:0:b0:37d:373c:ed24 with SMTP id ffacd0b85a97d-381c7a3a49cmr8192628f8f.4.1730712414212;
        Mon, 04 Nov 2024 01:26:54 -0800 (PST)
Received: from ?IPv6:2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f? (200116b82d7fe40007f8722cbb2ebb7f.dip.versatel-1u1.de. [2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d20sm12817150f8f.7.2024.11.04.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:26:53 -0800 (PST)
Message-ID: <a8d9f32f60f55c58d79943c4409b8b94535ff853.camel@redhat.com>
Subject: Re: [PATCH 01/13] PCI: Prepare removing devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov
 <s.shtylyov@omp.ru>, Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Dubov <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Chen Ni <nichen@iscas.ac.cn>, Mario Limonciello
 <mario.limonciello@amd.com>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Mostafa Saleh <smostafa@google.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, Christian
 Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, Reinette Chatre <reinette.chatre@intel.com>, Ye
 Bin <yebin10@huawei.com>, Marek =?ISO-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.dev>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Mon, 04 Nov 2024 10:26:51 +0100
In-Reply-To: <87cyjgwfmo.ffs@tglx>
References: <20241015185124.64726-1-pstanner@redhat.com>
	 <20241015185124.64726-2-pstanner@redhat.com> <87cyjgwfmo.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-31 at 14:45 +0100, Thomas Gleixner wrote:
> On Tue, Oct 15 2024 at 20:51, Philipp Stanner wrote:
> > +/**
> > + * pci_intx - enables/disables PCI INTx for device dev, unmanaged
> > version
>=20
> mismatch vs. actual function name.

ACK, will fix

>=20
> > + * @pdev: the PCI device to operate on
> > + * @enable: boolean: whether to enable or disable PCI INTx
> > + *
> > + * Enables/disables PCI INTx for device @pdev
> > + *
> > + * This function behavios identically to pci_intx(), but is never
> > managed with
> > + * devres.
> > + */
> > +void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
>=20
> This is a misnomer. The function controls the INTX_DISABLE bit of a
> PCI device. Something like this:
>=20
> void __pci_intx_control()
> {
> }
>=20
> static inline void pci_intx_enable(d)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __pci_intx_control(d, true);
> }
>=20
> .....
>=20
> makes it entirely clear what this is about.

Well, I would agree if it were about writing a 'real' new function. But
this is actually about creating a _temporary_ function which is added
here and removed again in patch 12 of this same series.

It wouldn't even be needed; the only reason why it exists is to make it
easy for the driver maintainers concerned by patches 2-11 to review the
change and understand what's going on. Hence it is
"pci_intx_unmanaged()" =3D=3D "Attention, we take automatic management away
from your driver"

pci_intx() is then fully restored after patch 12 and it keeps its old
name.

Gr=C3=BC=C3=9Fe,
Philipp


>=20
> Hmm?
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20


