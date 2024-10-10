Return-Path: <linux-wireless+bounces-13838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7260998104
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 10:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4227C1F21359
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF301BC9F9;
	Thu, 10 Oct 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7rHUI8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D401CBE86
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550215; cv=none; b=KQImApRusF4zSAg+LEUj+N2nwQJSSaNFfTrD5abS4cIYcdrNsAtDarz19QWylEUxl3VGkQOnqhL+455+tW/hj6VZrWEjpkTy8JsI+59V/r8Ge1O0W51MWQzR4+JSOHGoy0ilkNqYpBd6JPskcehjQAx4aETzEMrpF7STiG77oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550215; c=relaxed/simple;
	bh=5P2PH/oY2rjXr+pjKB8ZtV9oiV2N7F1zJjEPh3Cadzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl8kmcAFV3sjoa6qzByjy+1Qx/IT92O51d5L0joTmWOg86YFG60AzjYIJmZMKjYUqFUDrZ9LXrOhseqoqqyrSbXFSvy9zw16wtb1ZK5cC3v0qK+enrQGvSWj13fsDh2+rmWyn+MlQTSF6tn/tHV3ODYWldZw4VtrvSEGDmVL3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y7rHUI8D; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43115b31366so5411715e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728550211; x=1729155011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C28wmYcjpWumVpaF4ufJJPgnJaeWt/0xGrgSlXatWFI=;
        b=Y7rHUI8DGsR8kdC+otSD3I1BDaoUJUGWMMXLr6ZEVxhkvQdUp1auB1Edn4anMo7GnR
         dyOTmGTrwIsdANSmPYm5HayxHF76118n8uuieZSc3W6//oSFUMreIiYsLMglRkzX0RbT
         KAIGJGiG6MZw6ks+I279HPQvGSDzI+cvIgnfQ90erHsH9VZNgIMZ5koXyjn3AY0GlJqr
         m0U2X4IlsQZ68U037M8u925gcWI8rO/Pxhz68DtDsz67QHXHUcv2ON35jLwyTuBlGbDr
         jwcOKZPvGrVRvCFGfnRia8chvU0zxWMVU3txFRglUcB/Yb2YmMKwd13uRzLzuImk4q+k
         tEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550211; x=1729155011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C28wmYcjpWumVpaF4ufJJPgnJaeWt/0xGrgSlXatWFI=;
        b=XNQlFueVQtDZgG0ZnMmQ4gog6zTKqL8R5Caq4SK5zjXhBeX8b7YCyBNw5pcsLRAMJI
         b+E9VJD94U04adp7AO/bH4nMv4Qzb40GR2JNYzAOliB/F1O9TUGomlP2pLWC/iC+shmG
         otZ+xHfI3H9nWAkbF9DmnhoqqvPFKv+IVJMmnZZmw76QLdwddkEikh+CjB5zRzZKnRit
         XDN1lV6PHMnd26sMX88Cp9qV+sOdKLJDVT6RAQjJi7MwMFuSnmwzQBxBvFCTLMVwgMZe
         epdnqCLtjOthSx300rJGAVrGDUq5Do3t83W/tP2TaE7ag888EhN9WYMjrWt79OaS9sYk
         o7uw==
X-Forwarded-Encrypted: i=1; AJvYcCWOt0kbBnjhIYuCcGqEDoJIsAxO5AuF0ykYzMEMJoow37q2R5ILLNSfC4fiMC6UXUdwMBgDWU+Q487c4+QTHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDbb8pgjYZ3H9ug/qe6otcjYUz3hm23+1k7YkTxIoHhA98u8b
	oAg/0Y/Rtr+VOOyXy5sAO/jsKZ8qAkbh5Qa13sd3oNb6c9IkyBAm2KplpKYG+ts=
X-Google-Smtp-Source: AGHT+IFucfSES3j62KAzEm41LuUqQRM3VySAkjPe4+iZpB8R8Lb977wIeQTSTeOu3TgGseFk0hICSw==
X-Received: by 2002:a05:600c:4b95:b0:431:1a98:cb40 with SMTP id 5b1f17b1804b1-4311a98cc3dmr1671235e9.18.1728550211283;
        Thu, 10 Oct 2024 01:50:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43117ff5930sm9483515e9.0.2024.10.10.01.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:50:10 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:50:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
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
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] Remove devres from pci_intx()
Message-ID: <7f624c83-115b-4045-b068-0813a18c8200@stanley.mountain>
References: <20241009083519.10088-1-pstanner@redhat.com>
 <20241009083519.10088-14-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009083519.10088-14-pstanner@redhat.com>

On Wed, Oct 09, 2024 at 10:35:19AM +0200, Philipp Stanner wrote:
> pci_intx() is a hybrid function which can sometimes be managed through
> devres. This hybrid nature is undesirable.
> 
> Since all users of pci_intx() have by now been ported either to
> always-managed pcim_intx() or never-managed pci_intx_unmanaged(), the
> devres functionality can be removed from pci_intx().
> 
> Consequently, pci_intx_unmanaged() is now redundant, because pci_intx()
> itself is now unmanaged.
> 
> Remove the devres functionality from pci_intx(). Remove pci_intx_unmanaged().
> Have all users of pci_intx_unmanaged() call pci_intx().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

I don't like when we change a function like this but it still compiles fine.
If someone is working on a driver and hasn't pushed it yet, then it's probably
supposed to be using the new pcim_intx() but they won't discover that until they
detect the leaks at runtime.

Why not leave the pci_intx_unmanaged() name.  It's ugly and that will discorage
people from introducing new uses.

regards,
dan carpenter


