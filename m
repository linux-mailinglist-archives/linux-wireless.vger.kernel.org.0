Return-Path: <linux-wireless+bounces-13841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE69099821A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD915B22632
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1F1C1755;
	Thu, 10 Oct 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+sBxVBc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B881BFE0B
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551601; cv=none; b=ixBQhdn7dqVX/oO3EXo+p/li799eswZtRS7GprdehVosr2aIH2F8LKmMWT4rgOarUigAaNJnBv5vmZ/9RLtXadQrCA05vYJg5vT57P1B4+Fstw7CQIfT7C+DUYmlHqGd6VtBBEWKzpwbm5px5vBV6g8wF03jsCC2oRbBNfEcZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551601; c=relaxed/simple;
	bh=v4XN18e+CyZcuqWrnUyls/e8CpJTrCIwM8PKMvwb8/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDhaqf5YDGhY3oOSAU1G38/6iYMSNqqaJvlPZw1A1/lTHz0zIsxgDeV9piotI4LQab6Gpm+RO/x/4iKgWHkyd8WgDRMnxTXfYVrCd1dXmiK9fLvvfUu39aLRBTGXD1rXWigS1wHJsQGRPS+xvxVhG+3jZ4bn3Zz1XvBJ1zZn1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+sBxVBc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728551598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4XN18e+CyZcuqWrnUyls/e8CpJTrCIwM8PKMvwb8/g=;
	b=c+sBxVBclE/ad3VRFgfdnV6lw9VVrxCPgaSVROvHtI5oDNs1IsiGnWxxxpg4IAAWz4oxiN
	ga94eI0u5olM9rsRPsSYWkGlkHBbFU4gkg6kC4ZoGa8kZ5jhT/nMnpknEtKUz+EkcUIn5J
	qUMOUv4vYjmUUmUk8abV0pxi1PFfkIM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-kC-ILte3NjmfKU3vVlBfig-1; Thu, 10 Oct 2024 05:13:16 -0400
X-MC-Unique: kC-ILte3NjmfKU3vVlBfig-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e123d3d22so862136b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 02:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551595; x=1729156395;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4XN18e+CyZcuqWrnUyls/e8CpJTrCIwM8PKMvwb8/g=;
        b=X/Crrs+JfwzzCsn3b+83svn/XgJ+sDc2/Xw4SGsEI0B1sXtpMJaJxYTVKZlLP/khx/
         Oj/OX7EXtg8nsO4R3nZMXCCwhlJdGBU6KYwB9rBWCgxgCPMxKF3n/xvC6bSVgUzIYMaQ
         BjJvgEIctpL2JkwcEWITD6kte85VJg2ImpRNyeAcsxv0CQ5mbSCe7oVpfRBapgZaxTvy
         q5E7QqEV3AJaO2IGW/TPqjFaKQCYn/R8XZi9/6RMocduIMp6HiCwE6OiBtkV0LHLgbGr
         JP72SXoE4/KPRs2rvrX3nIS3w45u/6X+Ov+zOHUOu55J5XcCN2D9Eup1buKKJ5WbMQAb
         WQHw==
X-Forwarded-Encrypted: i=1; AJvYcCWMNwzfd7jNScCRB9SE860qKYRJGzPWybUkld6Ko/PXlcfyhPb1k3n0UnoGktcBIVN72KPA4ir/78rYMFDy8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcerBElin8mp25zYSnpbSO1BR+H0L62APK+TiEhi61zismTCNG
	FU5o5Lng/pDao0Ew7Op3cZfLq3kyKsH21hlZLZG36oo3ojGFZ6JCuE2UUIat0uVvkyWs1o9QE9/
	mJSTaKGg5cCzXEoyYqAC3pIpgN/dDivDRd32Ojq+bHX+p0ZfAD2Ej40RHQGAvNQrY
X-Received: by 2002:a05:6a00:3e12:b0:71e:cc7:c511 with SMTP id d2e1a72fcca58-71e1dbc7610mr9332052b3a.23.1728551594977;
        Thu, 10 Oct 2024 02:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGep+sT+xfvdEWHCwKXB/cVXFvEo8d4o8Uec70ymXyXBB7IFwxFmp57q9aFEQPPEpGRMx5+Ug==
X-Received: by 2002:a05:6a00:3e12:b0:71e:cc7:c511 with SMTP id d2e1a72fcca58-71e1dbc7610mr9331963b3a.23.1728551594451;
        Thu, 10 Oct 2024 02:13:14 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0a617sm642626b3a.192.2024.10.10.02.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:13:14 -0700 (PDT)
Message-ID: <306f4f0c8c966647170cf7fdab11285dba976ea1.camel@redhat.com>
Subject: Re: [RFC PATCH 10/13] staging: rts5280: Use always-managed version
 of pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov
 <s.shtylyov@omp.ru>, Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Alex Dubov <oakad@yahoo.com>, Sudarsana Kalluru
 <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, Chen
 Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi
 Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-input@vger.kernel.org,
 netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-staging@lists.linux.dev, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Thu, 10 Oct 2024 11:12:33 +0200
In-Reply-To: <2024101006-chump-image-e65c@gregkh>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-11-pstanner@redhat.com>
	 <2024100936-brunette-flannels-0d82@gregkh>
	 <411f3c94-58b5-471e-bc58-e23d89d2078f@gmail.com>
	 <b57dbf0c83125d58e4e2b488b5b5f71410fd8d6a.camel@redhat.com>
	 <2024101006-chump-image-e65c@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 11:03 +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 10, 2024 at 10:03:30AM +0200, Philipp Stanner wrote:
> > On Wed, 2024-10-09 at 21:41 +0200, Philipp Hortmann wrote:
> > > On 10/9/24 11:38, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 09, 2024 at 10:35:16AM +0200, Philipp Stanner
> > > > wrote:
> > > > > pci_intx() is a hybrid function which can sometimes be
> > > > > managed
> > > > > through
> > > > > devres. To remove this hybrid nature from pci_intx(), it is
> > > > > necessary to
> > > > > port users to either an always-managed or a never-managed
> > > > > version.
> > > > >=20
> > > > > rts5208 enables its PCI-Device with pcim_enable_device().
> > > > > Thus,
> > > > > it needs the
> > > > > always-managed version.
> > > > >=20
> > > > > Replace pci_intx() with pcim_intx().
> > > > >=20
> > > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > > ---
> > > > > =C2=A0 drivers/staging/rts5208/rtsx.c | 2 +-
> > > > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >=20
> > >=20
> > > Hi Philipp,
> > >=20
> > > this driver (rts5208) will be removed soon - patch is send in.
> > >=20
> > > Discussion about removal:
> > > https://lore.kernel.org/linux-staging/2024100943-shank-washed-a765@gr=
egkh/T/#t
> >=20
> >=20
> > Alright, thx for the heads up.
> >=20
> > I'm not entirely how best to deal with that, though. I could drop
> > this
> > patch, but then the driver would end up with an unmanaged
> > pci_intx().
> >=20
> > Might this be a problem for users if my series lands sooner than
> > the
> > removal, say in v6.13 and your removal in v6.14?
>=20
> The removal will happen in 6.13, I'm going to be queueing it up right
> now.

Alright, thx. Then I drop patch #10.

P.

>=20
> thanks,
>=20
> greg k-h
>=20


