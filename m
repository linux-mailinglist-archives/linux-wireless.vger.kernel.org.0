Return-Path: <linux-wireless+bounces-11381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FB950E46
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 23:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424732846D7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E01A705B;
	Tue, 13 Aug 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1JJQ8Ne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718961A2C22
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583008; cv=none; b=D423rmqyn2UtvODLaQyvZNnNoxcWc1pdZGRiOtqFd/Aa3xO/H3bKhn2DWryXwkjqqO2HBo9HSOdtWks0YBKzMosc5uG4VE3yLbeatdXRbhl8/c/7k0wHxgDbHDXGRaM3/nsdMXcQJz2aPZnUx99atPecYw7MrCcrRTZ1NUqjjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583008; c=relaxed/simple;
	bh=S1wGFKTAEjSQsbf68k5RXdglIXflEszFnfO6eF1HbfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWCX/mO9r1Om5aQY9vZjIibWP81WdchULTNpvQn4j8GOM5YAw8kFNR+orT6axqMRrQsoIFUf996rU40HN5MnrB4LOMOeOAN5cBmp0Xfux8HN5nKIaRqUm9hHsWLbqvjD1e87B+6AGQmNTV+gOqyUedD2FZT1MIh0vjmadwZGbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1JJQ8Ne; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723583006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UOf/e3HcQ+l94OWXrCwdSK3TbHtvFPHwqfrVahjAnI=;
	b=h1JJQ8NeKnYI+KpVrixAz35Kp9WMTMxgMjn5cXurb7JbDrj803gs1in0zc9mvV5epTMB18
	LcB+sqy9x32axlag2ewlUFMUFJ7SPpn2LP3YLWJ9C4b5dKNwgUenInyAU65CFBqcbIruVT
	a0b4CzCybZshBGeH7JZ8jYC2cMWQE6k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-fjgsGiCaPZyLVvZL2Q1TYw-1; Tue, 13 Aug 2024 17:03:24 -0400
X-MC-Unique: fjgsGiCaPZyLVvZL2Q1TYw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c78cc66so773885739f.2
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 14:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723583004; x=1724187804;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UOf/e3HcQ+l94OWXrCwdSK3TbHtvFPHwqfrVahjAnI=;
        b=vDXV4I4rtb2eY18b9znHqj+f5iwOFtkTlMGySnM+nzqL8rQ7RBCIASDxJDYpIGAP7o
         zg+e3WUlbMP8OciBclkW5RKASzLTl56cxcrIJMkxd9sJ2g6yu3JsKTFDctKCflZTtigS
         3T/dnkTuPRHvenII9pue0nNDJK421bUGoCQVg75miy6Y9Mrazq2zJ5GMxQIF9YYrkLGS
         fdSeIEK5/gQXDiBzeiQ3Aq2ZfADkZLS8JbLKm/P75gzTNkjj0O8trncSA+pD7957Ny0B
         FzVxsNsu2dss3qT3dsa4wScPvtdDcRHvtkqfZv2dh4o0lW3y1NLmoqrquu2kvYF2XL6H
         Hzcg==
X-Forwarded-Encrypted: i=1; AJvYcCV3znL2NvMHy3J//EH5ExDsui1WqUxlH2XOLW1/naGtfUwL4GTnb8mSTTz5gP3XQTwMbQ1P8Us6bsiayxhNPA89rnW699VnFjp03brd7Vk=
X-Gm-Message-State: AOJu0YxrjzoaMyj8MMBMEUx3S33BMpKRmnVLFIKjptYUl8okt1/nLNgU
	lE5t679uD+oe/AsPKCC3U9k76c1mEvCRmp5YwFdZ8GaAboSxmkPg6fnTcZjB7f8tGmYSoCYMW10
	IfG4bNad6MVmoTLoY9S4xySRHarP1V1YrjzVClwAJmhM55KVgblMPbEsy3XxwQp86
X-Received: by 2002:a05:6602:14d2:b0:804:9972:2f8c with SMTP id ca18e2360f4ac-824dad04265mr122543539f.8.1723583003652;
        Tue, 13 Aug 2024 14:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUG+Ra/4MLDKrpbcdWTsiFMgCKM25UlSCbFVfALG5nTggblaB3Mjb05rv1rYcf1nGj/+3LVA==
X-Received: by 2002:a05:6602:14d2:b0:804:9972:2f8c with SMTP id ca18e2360f4ac-824dad04265mr122539339f.8.1723583003274;
        Tue, 13 Aug 2024 14:03:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca76910393sm2733107173.7.2024.08.13.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:03:22 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:03:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, prestwoj@gmail.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240813150320.73df43d7.alex.williamson@redhat.com>
In-Reply-To: <20240813164341.GL1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<20240812170045.1584000-1-alex.williamson@redhat.com>
	<20240813164341.GL1985367@ziepe.ca>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 13:43:41 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Aug 12, 2024 at 11:00:40AM -0600, Alex Williamson wrote:
> > These devices have an embedded interrupt controller which is programmed
> > with guest physical MSI address/data, which doesn't work.  We need
> > vfio-pci kernel support to provide a device feature which disables
> > virtualization of the MSI capability registers.  Then we can do brute
> > force testing for writes matching the MSI address, from which we can
> > infer writes of the MSI data, replacing each with host physical values.
> > 
> > This has only been tested on ath11k (0x1103), ath12k support is
> > speculative and requires testing.  Note that Windows guest drivers make
> > use of multi-vector MSI which requires interrupt remapping support in
> > the host.  
> 
> The way it is really supposed to work, is that the guest itself
> controls/knows the MSI addr/data pairs and the interrupt remapping HW
> makes that delegation safe since all the interrupt processing will be
> qualified by the RID.
> 
> Then the guest can make up the unique interrupts for MSI and any
> internal "IMS" sources and we just let the guest directly write the
> MSI/MSI-X and any IMS values however it wants.
> 
> This hackery to capture and substitute the IMS programming is neat and
> will solve this one device, but there are more IMS style devices in
> the pipeline than will really need a full solution.

How does the guest know to write a remappable vector format?  How does
the guest know the host interrupt architecture?  For example why would
an aarch64 guest program an MSI vector of 0xfee... if the host is x86?

The idea of guest owning the physical MSI address space sounds great,
but is it practical?  Is it something that would be accomplished while
this device is still relevant?

> > + * The Windows driver makes use of multi-vector MSI, where our sanity test
> > + * of the MSI data value must then mask off the vector offset for comparison
> > + * and add it back to the host base data value on write.  
> 
> But is that really enough? If the vector offset is newly created then
> that means the VM built a new interrupt that needs setup to be routed
> into the VM?? Is that why you say it "requires interrupt remapping
> support" because that setup is happening implicitly on x86?
> 
> It looks like Windows is acting as I said Linux should, with a
> "irq_chip" and so on to get the unique interrupt source a proper
> unique addr/data pair...

The Windows driver is just programming the MSI capability to use 16
vectors.  We configure those vectors on the host at the time the
capability is written.  Whereas the Linux driver is only using a single
vector and therefore writing the same MSI address and data at the
locations noted in the trace, the Windows driver is writing different
data values at different locations to make use of those vectors.  This
note is simply describing that we can't directly write the physical
data value into the device, we need to determine which vector offset
the guest is using and provide the same offset from the host data
register value.

I don't know that interrupt remapping is specifically required, but the
MSI domain needs to support MSI_FLAG_MULTI_PCI_MSI and AFAIK that's
only available with interrupt remapping on x86, ie.
pci_alloc_irq_vectors() with max_vecs >1 and PCI_IRQ_MSI flags needs to
work on the host to mirror the guest MSI configuration.  Thanks,

Alex


