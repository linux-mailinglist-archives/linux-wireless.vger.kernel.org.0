Return-Path: <linux-wireless+bounces-14771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F091F9B777A
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A9B1C217F7
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B9197A6A;
	Thu, 31 Oct 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCABTsmQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74719408B
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366921; cv=none; b=ndZOzIUUrJBo6VW036q9kA9VoZt/FhcVqLX0smCK5i7gRssbm5eoIiHtddX4KEjvd0i2Yues5X2saXcDLGOsM/CnTUvrzGz9fnCmqBIevVpiyRdA/+cfJtHdUClYURsbacbmW/HVSEfP3NreASrC1Ediww3ukIakBkZV0NzuhlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366921; c=relaxed/simple;
	bh=d6wn1lKONgblnZ++1qSDC4UeXUH/h7Owd02AbOfZVIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o12qd2E3vO1k3wwxHIlTASTB/4h32VVFfVvCYZthc/i2vmdpT9h7fs7BXpBRJ4l7nLC26msEIfvegFvQrOEmvLFgNxGO3fxZkurEpfemK0cSeIprY0hCodPc+s1LFOkaSLIFQNa6iY69kSL1tB3+gdgAB1paSeogZHKfklM5Zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCABTsmQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730366918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6wn1lKONgblnZ++1qSDC4UeXUH/h7Owd02AbOfZVIQ=;
	b=DCABTsmQrlrqZPPC8obhqarMKF6G/CAJS7qc5NNpwMiMvoKhAJrqkJ2rRJVOdK086ArbgF
	GtGT0Df/MSUFQmBhPQIAaj/eNGr2TT12SWRcpooAXH7XLDutptpnRQnTrg7Y5Vp43pxVP0
	tmJW2c2lsjnCPirM6rya5ZzdoqhOkgU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Wne8Kqa4ODynRB2UwF7frg-1; Thu, 31 Oct 2024 05:28:35 -0400
X-MC-Unique: Wne8Kqa4ODynRB2UwF7frg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fcd9765852so3882731fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 02:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730366914; x=1730971714;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6wn1lKONgblnZ++1qSDC4UeXUH/h7Owd02AbOfZVIQ=;
        b=g4QfTChcvTv5Obhw9rgqRfGHdbL7ZwbjeKotMrK+RNUaJNTiRoBovjmv9g6ewk97mi
         2tjISk+Zzy/BN8g2AjAw7obYAZntMTumSOk+GxpjiBUx//9X3HtEmq+tFgK4BBbpSmNu
         jmBZEt0nQVJxgw42IsyxxQ2wp57aigM8Cvx7HZt3o6P0WtXh3dY8jp/0bAX8CWkZCnuz
         2teXmI0989ibcMqZRr3W7qpsud+cB9uI2FAQmq47p2dwd4PU56IdKvvleCn95OIB9Fwl
         kgjUa7vJvE2/FeWOuIjThUW3B2GVwQ0x4IZJBnZvLLUyIcDH7jwAaoXmRb+lw4W3fo1K
         c2sA==
X-Forwarded-Encrypted: i=1; AJvYcCWE8OqJzS5rKADzTOl3NT78DQ8cc39CmmJr8A88eutwIHTppDfTPWD7gDeWiWvJfZ8rs/sh3jDKY+lMsTFv4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LCMJ9YH8gS5FXKqxXzFxMXhl7UaEED01t+3Ch1nExeneGY7+
	JlN9JHboPaKt0j9PDNHa7X/higIc8pVJLDZiktNbApGmPXyEHEZgomOexl4uo7i9tiS5oHUfB1A
	t9u5jmYFB+9UyT0up15tIxuk1rdYggAJB/LeB3xRRGXsx8jxdqBBR6Bxb05/L2ofO
X-Received: by 2002:a2e:b8cf:0:b0:2fb:58b1:3731 with SMTP id 38308e7fff4ca-2fd058fbda2mr43395221fa.6.1730366913711;
        Thu, 31 Oct 2024 02:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEinR4wm9boDAsEkZ9V3ivoUKK9VQmKYoIEQNVXO7Y2sjsmX4v4AmQcNIDCbC3ckt5R0LeFLA==
X-Received: by 2002:a2e:b8cf:0:b0:2fb:58b1:3731 with SMTP id 38308e7fff4ca-2fd058fbda2mr43394381fa.6.1730366913125;
        Thu, 31 Oct 2024 02:28:33 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e94cdsm18626575e9.28.2024.10.31.02.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:28:32 -0700 (PDT)
Message-ID: <f13c91f2d1e7672e1d9983425117eeb6347c0ea1.camel@redhat.com>
Subject: Re: [PATCH 00/13] Remove implicit devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>,  Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Chen Ni <nichen@iscas.ac.cn>, Mario Limonciello
 <mario.limonciello@amd.com>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu
 <yi.l.liu@intel.com>,  Christian Brauner <brauner@kernel.org>, Ankit
 Agrawal <ankita@nvidia.com>, Eric Auger <eric.auger@redhat.com>, Reinette
 Chatre <reinette.chatre@intel.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Rui Salvaterra <rsalvaterra@gmail.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Thu, 31 Oct 2024 10:28:29 +0100
In-Reply-To: <87plngwrws.wl-tiwai@suse.de>
References: <20241015185124.64726-1-pstanner@redhat.com>
	 <20241030221737.GA1223682@bhelgaas> <87plngwrws.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-31 at 10:19 +0100, Takashi Iwai wrote:
> On Wed, 30 Oct 2024 23:17:37 +0100,
> Bjorn Helgaas wrote:
> >=20
> > On Tue, Oct 15, 2024 at 08:51:10PM +0200, Philipp Stanner wrote:
> > > @Driver-Maintainers: Your driver might be touched by patch
> > > "Remove
> > > devres from pci_intx()". You might want to take a look.
> > >=20
> > > Changes since the RFC [1]:
> > > =C2=A0 - Add a patch deprecating pci{m}_intx(). (Heiner, Andy, Me)
> > > =C2=A0 - Add Acked-by's already given.
> > > =C2=A0 - Export pcim_intx() as a GPL function. (Alex)
> > > =C2=A0 - Drop patch for rts5280, since this driver will be removed
> > > quite
> > > =C2=A0=C2=A0=C2=A0 soon. (Philipp Hortmann, Greg)
> > > =C2=A0 - Use early-return in pci_intx_unmanaged() and pci_intx().
> > > (Andy)
> > >=20
> > > Hi all,
> > >=20
> > > this series removes a problematic feature from pci_intx(). That
> > > function
> > > sometimes implicitly uses devres for automatic cleanup. We should
> > > get
> > > rid of this implicit behavior.
> > >=20
> > > To do so, a pci_intx() version that is always-managed, and one
> > > that is
> > > never-managed are provided. Then, all pci_intx() users are ported
> > > to the
> > > version they need. Afterwards, pci_intx() can be cleaned up and
> > > the
> > > users of the never-managed version be ported back to pci_intx().
> > >=20
> > > This way we'd get this PCI API consistent again.
> > >=20
> > > Patch "Remove devres from pci_intx()" obviously reverts the
> > > previous
> > > patches that made drivers use pci_intx_unmanaged(). But this way
> > > it's
> > > easier to review and approve. It also makes sure that each
> > > checked out
> > > commit should provide correct behavior, not just the entire
> > > series as a
> > > whole.
> > >=20
> > > Merge plan for this is to enter through the PCI tree.
> > >=20
> > > [1]
> > > https://lore.kernel.org/all/20241009083519.10088-1-pstanner@redhat.co=
m/
> >=20
> > I *think* this series depends on resolution of Takashi's "Restore
> > the
> > original INTX_DISABLE bit by pcim_intx()" patch [2], right?
>=20
> IIUC, it's not really dependent, as pcim_intx() has been used in
> pci_intx() internally when the PCI device is already managed.
> My patch is to correct the already existing behavior.

IOW, pcim_intx() does not behave correctly, independently from removing
the call to it in pci_intx().

> =C2=A0 So I guess you
> can take this series, and I'll post the revised patch later (sorry, I
> was too busy for other tasks).
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> >=20
> > For now I'm postponing this series, but let me know if that's not
> > the
> > right thing.

There are still several reviews / acks missing from the respective
driver maintainers, so there's no hurry with this series regarding your
side ;)

Regards
P.


> >=20
> > [2] https://lore.kernel.org/r/20241024155539.19416-1-tiwai@suse.de
> >=20
> > > Philipp Stanner (13):
> > > =C2=A0 PCI: Prepare removing devres from pci_intx()
> > > =C2=A0 ALSA: hda_intel: Use always-managed version of pcim_intx()
> > > =C2=A0 drivers/xen: Use never-managed version of pci_intx()
> > > =C2=A0 net/ethernet: Use never-managed version of pci_intx()
> > > =C2=A0 net/ntb: Use never-managed version of pci_intx()
> > > =C2=A0 misc: Use never-managed version of pci_intx()
> > > =C2=A0 vfio/pci: Use never-managed version of pci_intx()
> > > =C2=A0 PCI: MSI: Use never-managed version of pci_intx()
> > > =C2=A0 ata: Use always-managed version of pci_intx()
> > > =C2=A0 wifi: qtnfmac: use always-managed version of pcim_intx()
> > > =C2=A0 HID: amd_sfh: Use always-managed version of pcim_intx()
> > > =C2=A0 Remove devres from pci_intx()
> > > =C2=A0 PCI: Deprecate pci_intx(), pcim_intx()
> > >=20
> > > =C2=A0drivers/ata/ahci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/ata/ata_piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/ata/pata_rdc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/ata/sata_sil24.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/ata/sata_sis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/ata/sata_uli.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/ata/sata_vsc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A0drivers/hid/amd-sfh-hid/amd_sfh_pcie.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> > > =C2=A0drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |=C2=A0 2 +-
> > > =C2=A0.../wireless/quantenna/qtnfmac/pcie/pcie.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> > > =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 +++++--------
> > > ------
> > > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 ++++--------
> > > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0sound/pci/hda/hda_intel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> > > =C2=A014 files changed, 26 insertions(+), 47 deletions(-)
> > >=20
> > > --=20
> > > 2.47.0
> > >=20
>=20


