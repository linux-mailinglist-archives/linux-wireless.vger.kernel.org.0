Return-Path: <linux-wireless+bounces-15327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD29CF060
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38096288F0C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FFB1D54C7;
	Fri, 15 Nov 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C40dr8q9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DexVQlk5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE41D517E;
	Fri, 15 Nov 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684918; cv=none; b=hdlQRX9+3fjQCictF7tkGQDpqJuDnuKD6UVeiGvmQpjXz0La0Gta51yd1DSKM7jPAaearQzaMurY82XeMoKGoNes0TlOeIsWQLDw+HbOZmWiUfBG477RUOcPGm2bQbB+9bibigRoueAVlSMj4HaK8S3w4s/4yI/13tZnx1wWDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684918; c=relaxed/simple;
	bh=yU1G2hIrLcZlXd3LaebeyKYONXTnd34hSfRSQEHJ1yU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m/pI1vZAQ9gxkkrLO4Ck9+wP9LbxWHNLTrhIlgyWxvHYEzuYsWqKH43sexoA3BbGj7kQl9pEwxtFlUBhKoXMYEr3MPsrKTXACWNVH2K83g8VfSZbA+QAphVFxiaJU71bVjVC2mmG1w6Z5DxdTlmomxVVMcXRL/fQCj5cluVl7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C40dr8q9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DexVQlk5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731684914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yU1G2hIrLcZlXd3LaebeyKYONXTnd34hSfRSQEHJ1yU=;
	b=C40dr8q9ADx3mdyM9aZWGfyNweZhURE5tGHsnoEPOBZ904QoHc4A1GcjWf/GhDl0Adlgrf
	69L3PJoNzAzHniCsGBlfwosD15LDHvc8ITSwBMRd+5Sbe41oaOOiaEZlNe1GflVWe7uMmn
	Kzt8nWpH6yNOxLgVHZos2j37vQf3hzemX8dtqEeaHa/T8/Znh9DDC8Ece7mjtCtQQT3Ujv
	KD9bNcHp4TJd//4bZGwhCHqCSvgB4uI1kMAvZ+ldC3dONiNJGi2r2u0iSkzbPxxKe4NX3O
	SQh1dzqAsqbj2vzeJBJM/qwLDpY3Q9H6tWI4KQY8TUCGPS3qaekoi9YVTk7kCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731684914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yU1G2hIrLcZlXd3LaebeyKYONXTnd34hSfRSQEHJ1yU=;
	b=DexVQlk5YViUHETMQnzqsi81sHcgKGKaG/NWsxoB8OfZI81poTF211mDX/o0kNLPLWaOEC
	Apumdsb73YjhwXBQ==
To: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
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
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam
 Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave
 Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Alex Williamson
 <alex.williamson@redhat.com>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Philipp Stanner <pstanner@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Chen Ni
 <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Mostafa Saleh <smostafa@google.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, Kunwu Chan
 <chentao@kylinos.cn>, Ankit Agrawal <ankita@nvidia.com>, Christian Brauner
 <brauner@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Eric
 Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 07/11] PCI: MSI: Use never-managed version of pci_intx()
In-Reply-To: <20241113124158.22863-9-pstanner@redhat.com>
References: <20241113124158.22863-2-pstanner@redhat.com>
 <20241113124158.22863-9-pstanner@redhat.com>
Date: Fri, 15 Nov 2024 16:35:22 +0100
Message-ID: <87y11kzf0l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 13 2024 at 13:41, Philipp Stanner wrote:
> pci_intx() is a hybrid function which can sometimes be managed through
> devres. To remove this hybrid nature from pci_intx(), it is necessary to
> port users to either an always-managed or a never-managed version.
>
> MSI sets up its own separate devres callback implicitly in
> pcim_setup_msi_release(). This callback ultimately uses pci_intx(),
> which is problematic since the callback of course runs on driver-detach.
>
> That problem has last been described here:
> https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com/
>
> Replace the call to pci_intx() with one to the never-managed version
> pci_intx_unmanaged().
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

