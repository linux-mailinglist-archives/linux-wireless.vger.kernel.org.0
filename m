Return-Path: <linux-wireless+bounces-15276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E443F9C7863
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 17:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A917128CBF3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26ED1DEFC1;
	Wed, 13 Nov 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFU1h/Mw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE316E86F
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514308; cv=none; b=kJcgPMAZDS40gFjqWMRi6WDSK+5jaZ7ZHHFixHaaKo0X7IKBaKDaulCLmV2I+leSnWQ7yzNmmk0vv7KZ/8eRchBgCyHxSxhPCZsX3lu6S8RyLqj2Zkde+QgkH89GKvcGK60erAd9k6K7GeupEU9ag2f1E35EAvQWLF2zGbe8b/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514308; c=relaxed/simple;
	bh=8JShsxBODe/ZYse/45GbByklsWCzNPukdA1ZXffLLLQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJJoJenOtbZo3GoPg9XBQnRuv3blzpBAXoeJQgBbzids1wCWmktuvB1+rzRGj5bocZSR/Sg4zzCwuDWKtHG7VuKizy098W5GvZEs5PFWyfjA9UcMA/XqnMNnTacNpVS7cXMOTBMB9o63gGDaOBeJX6sHttlP6RkuJfQarXRtpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFU1h/Mw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731514305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JShsxBODe/ZYse/45GbByklsWCzNPukdA1ZXffLLLQ=;
	b=SFU1h/Mwr7lIShqUGeYhB3lrs/uUp0HY161hgBtSN0ff/Z2hRKt25aHM2/4qwLMRRETThb
	E7jlOoMTD/bCMQAfVVnK6bP3eYh+zjrGuYSvjzDDb/QAOCq4lzTDv/BkoeSLI7mGKP5CM5
	U3uevNOjLemhJZRrm3u13v0aL0rdd0Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-HlOBXgAGN02XPSmvc2tE7A-1; Wed, 13 Nov 2024 11:11:41 -0500
X-MC-Unique: HlOBXgAGN02XPSmvc2tE7A-1
X-Mimecast-MFC-AGG-ID: HlOBXgAGN02XPSmvc2tE7A
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d38310949cso117695466d6.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 08:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514301; x=1732119101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JShsxBODe/ZYse/45GbByklsWCzNPukdA1ZXffLLLQ=;
        b=ZofXHZugiGh5XmyGSUKO2QWjm7juqav7SV2U6vS0sQXEpFj+GxXsqhOuhufkNKwHlw
         RbhCLYnRdmYTfJZQqoUGqzRCPfV9CpeYYCOi7bqGigGaAQchcfPuLs+RDJW3Schnj2F3
         243k6g1UuOCe/OOuQs0NO2T+7dcvzxaVNUdFlyszKiQibtaJKC6YGc3tU4PdtPUOT0iM
         iojy0e1qC8CXE+It5lbeEbB/iRV3VdWFD7iMPiaFFQpK76FOeenAJ7bkfCddBh+a23OB
         LY4HZCg58Pkv1Yoow9HA2Y+lh0aQBsdnxUezfz91ueviksdEMt5+bExWC0jaDJxbYgDt
         HMqg==
X-Forwarded-Encrypted: i=1; AJvYcCUg+heFiStu5KyUK0o3bZqVHioiV9VHWvDVbsqy7O9LJXgB46kSV2LD5B5H0Xs2i+TbpR9eZrfFd59QTqbj8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuBA3e7PA9CqLXrUYhVUAov0UMiYt+qaegDVR1bkhZX7mgUgU
	2M55KA36hOJULoylEfNLaahHPjDzYn2Hn5x1BV7WuWSzH+2d34QFiwlPbHgZgOJX+SPvdHFHXqO
	z+oe11raIf3tB+hkk86EClMK/ArCTQgTgD/98KR2Z98TWVLMk8gRrL7Qa4aKkktS2
X-Received: by 2002:a05:6214:5987:b0:6d3:68df:f62d with SMTP id 6a1803df08f44-6d39e10946emr297207866d6.2.1731514300849;
        Wed, 13 Nov 2024 08:11:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnbeg7ogUgcEGRAzWAPJHQLp75DRK8IjefSxWG9p6JZ9o7VJOC4JF6vdJYqufewnJd395bRA==
X-Received: by 2002:a05:6214:5987:b0:6d3:68df:f62d with SMTP id 6a1803df08f44-6d39e10946emr297207096d6.2.1731514300322;
        Wed, 13 Nov 2024 08:11:40 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3966303e6sm86017386d6.99.2024.11.13.08.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:11:39 -0800 (PST)
Message-ID: <2f94dd0f0bfef8d51f1ced78a9b5db8e2ce48429.camel@redhat.com>
Subject: Re: [PATCH v2 01/11] PCI: Prepare removing devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>,  Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>,  GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>,  Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Chen Ni <nichen@iscas.ac.cn>, Ricky Wu
 <ricky_wu@realtek.com>,  Al Viro <viro@zeniv.linux.org.uk>, Breno Leitao
 <leitao@debian.org>, Kevin Tian <kevin.tian@intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, Kunwu Chan
 <chentao@kylinos.cn>, Ankit Agrawal <ankita@nvidia.com>, Christian Brauner
 <brauner@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Eric
 Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Wed, 13 Nov 2024 17:11:29 +0100
In-Reply-To: <87plmzktn3.ffs@tglx>
References: <20241113124158.22863-2-pstanner@redhat.com>
	 <20241113124158.22863-3-pstanner@redhat.com> <87plmzktn3.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-13 at 17:04 +0100, Thomas Gleixner wrote:
> On Wed, Nov 13 2024 at 13:41, Philipp Stanner wrote:
> > +/**
> > + * pci_intx_unmanaged - enables/disables PCI INTx for device dev,
> > + * unmanaged version
> > + * @pdev: the PCI device to operate on
> > + * @enable: boolean: whether to enable or disable PCI INTx
>=20
> Except that the argument is of type int, which really should be type
> bool.

True, but this is a *temporary* copy of pci_intx(), a ~16 year old
function. Older C programmers had the habit of for some reason using
32-bit integers for a true/false boolean all the time.

We _could_ think of changing pci_intx()'s parameter to a boolean, but I
think it wouldn't really improve things very much

see also below

>=20
> > + * Enables/disables PCI INTx for device @pdev
> > + *
> > + * This function behavios identically to pci_intx(), but is never
> > managed with
> > + * devres.
>=20
> behavios?

-> behaves. Will fix.

>=20
> > + */
> > +void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
>=20
> I find this function name mildy confusing. This _unmanaged suffix is
> not
> really telling me anything. And the reference that this behaves
> identically to pci_intx() makes it even worse.
>=20
> This function is about controlling the PCI INTX_DISABLE bit in the
> PCI_COMMAND config word, right?
>=20
> So naming it pci_intx_control() would make it entirely clear what
> this
> is about, no?

We had this conversation last week. I answered on that already, maybe
you have overlooked it:

https://lore.kernel.org/all/a8d9f32f60f55c58d79943c4409b8b94535ff853.camel@=
redhat.com/


Please also take a look at patch 11, then you'll see the full picture

Danke,
Philipp

>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20


