Return-Path: <linux-wireless+bounces-11382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE9950F07
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 23:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA3C1C20BA4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4681AB523;
	Tue, 13 Aug 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZnIOvir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458691AAE17
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583647; cv=none; b=DvAV6ZMKlLL3fCk7p3EHfmdOJ86VVAl7Wqe5iDzUAhU3OxBaEo/N9geYWDu7+CygmGyJD2xIlluzVAIYTdETOd6W+DsgL2arb3+DWTG68FPDkUvVfQf/W33UCbjV/jie2fEKsM9YY7JHmEmyQ4uE2jD6AvnJ+BaHl1+kJgOLhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583647; c=relaxed/simple;
	bh=3gSe/cVBbpVPgF+9SDAdjXm4H1D+qaetKJRmI3rmOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9w5Iou5YIpi+6rJotsf8Fi6rYiKW8JLjDiQOB80FC/NzZoeIeL0VTcsTCVJi34TbBh7pSm/2Q83YKMEpEe7eMP13klLQHtPP65Ug3QDSM8IrjytPnlF8DLcGpZPy94MrMyiCOBznpUbcI5I4VjoNr0Ue6EpMlAEmknk60v0PuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZnIOvir; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723583645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLndxOVhMGnGk0ZQ33snLsOErJZzv8Txl/Ym94gCWEQ=;
	b=cZnIOvirxhfADjqx3lB2xCkA5PYNgM8hWW4AR4ME7J9PJPQVHbyo96E8Qvkz3zo6GVTbiG
	soVVW2W5pLB7/7L5C0XXih2c4a+aaqmnRyk5GkCbkPkzTnOOPlggbyaeeWLhDvg5LeiFEs
	U++0aLk8+NMvGRTpTuC4OuuJJTHznng=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-N82F37hxOCGzq0t_CCS5-Q-1; Tue, 13 Aug 2024 17:14:04 -0400
X-MC-Unique: N82F37hxOCGzq0t_CCS5-Q-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b391cf336so2701045ab.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 14:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723583643; x=1724188443;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLndxOVhMGnGk0ZQ33snLsOErJZzv8Txl/Ym94gCWEQ=;
        b=Hg9OWFQEdHdDJv1rMbg81Tiib3allT/5UoWRgZ6T0EGUmuv72nlyll+jFLVgiAZmVD
         YGzx8bd+itIkH0Yl49Jficvw49A25KUHr2oGsqDMrhqE56n6tXn6oOK34miHk5cKVR7Q
         s2pxT/MxkofYtStmzbNKRzEbQUAK4gUH7Qz8n929UPhrvZnfk8cUsF8q9N/xwCQ661nu
         D62D5Og/iIJ6qm0q/Lm0rWTnXKjzT/sQkdPfkPmXu9JjM9EYwvcyS29J+okVolm2NsaL
         5ioRcAkROjYoKKZ5eMD/MXij0dUI+TUOoQyP9W6wpqWbyR/200jz6RoD8xhOo/2q3kzx
         w/qg==
X-Forwarded-Encrypted: i=1; AJvYcCUJOS/s7BKbtPp4prsZOPeKzlfCAX2N+V8HwsBJYTi8oaEyLYZPDHvoNT+7djEpwMnXsba6vDAqmdURZaUcHSAkMJZo0IIggokXfRM34LQ=
X-Gm-Message-State: AOJu0YzphLQIJ+ZC8CgJfqNpaHP5vl67U708alVL+d8/f3QzSqurnR2a
	XD24pxjEiO614U0kzFLPjZyB7VDof2AQBnd68wCtFsTqTiLeDTuWg2BdVmuA0OlbZpJKhzYXn8N
	t3mfv+arozIkufmMZrEz7esoXjVBjo1y4tx7J7a6rVqLB0heEl6OxTdO+Bp2DWYIn
X-Received: by 2002:a05:6e02:1c48:b0:399:4525:c2bc with SMTP id e9e14a558f8ab-39c48dccd95mr35434795ab.10.1723583643363;
        Tue, 13 Aug 2024 14:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG80cLRVSOvRn9w9qz+VrLxVLNgcf2C34EALlspiOzLOxMt0M7/SH6xPKbhukHFZiTHKZOB1A==
X-Received: by 2002:a05:6e02:1c48:b0:399:4525:c2bc with SMTP id e9e14a558f8ab-39c48dccd95mr35434605ab.10.1723583642975;
        Tue, 13 Aug 2024 14:14:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769102d4sm2731540173.36.2024.08.13.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:14:02 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:14:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
 johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240813151401.789c578f.alex.williamson@redhat.com>
In-Reply-To: <20240813163053.GK1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<20240812170014.1583783-1-alex.williamson@redhat.com>
	<20240813163053.GK1985367@ziepe.ca>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 13:30:53 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Aug 12, 2024 at 10:59:12AM -0600, Alex Williamson wrote:
> > vfio-pci has always virtualized the MSI address and data registers as
> > MSI programming is performed through the SET_IRQS ioctl.  Often this
> > virtualization is not used, and in specific cases can be unhelpful.
> > 
> > One such case where the virtualization is a hinderance is when the
> > device contains an onboard interrupt controller programmed by the guest
> > driver.  Userspace VMMs have a chance to quirk this programming,
> > injecting the host physical MSI information, but only if the userspace
> > driver can get access to the host physical address and data registers.
> > 
> > This introduces a device feature which allows the userspace driver to
> > disable virtualization of the MSI capability address and data registers
> > in order to provide read-only access the the physical values.  
> 
> Personally, I very much dislike this. Encouraging such hacky driver
> use of the interrupt subsystem is not a good direction. Enabling this
> in VMs will further complicate fixing the IRQ usages in these drivers
> over the long run.

Clearly these _guest_ drivers are doing this regardless of the
interfaces provided by vfio, so I don't see how we're encouraging hacky
driver behavior, especially when it comes to Windows guest drivers.

> If the device has it's own interrupt sources then the device needs to
> create an irq_chip and related and hook them up properly. Not hackily
> read the MSI-X registers and write them someplace else.

This is how the hardware works, regardless of whether the guest driver
represents the hardware using an irq_chip.

> Thomas Gleixner has done alot of great work recently to clean this up.
> 
> So if you imagine the driver is fixed, then this is not necessary.

How so?  Regardless of the guest driver structure, something is writing
the MSI address and data values elsewhere in the device.  AFAICT the
only way to avoid needing to fixup those values is to give the guest
ownership of the address space as you suggested in the other patch.
That also seems to have a pile of issues though.

> Howver, it will still not work in a VM. Making IMS and non-MSI
> interrupt controlers work within VMs is still something that needs to
> be done.

Making it work in a VM is sort of the point here.  Thanks,

Alex


