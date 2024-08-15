Return-Path: <linux-wireless+bounces-11495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20D9538E0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFDC1F26264
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9085C1B3F2F;
	Thu, 15 Aug 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lMloe+68"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF101AED29
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742380; cv=none; b=ghi+7ZqOxntZYtuzReXnL1oKBszlI84ChnHdlUgTi0UkUDxWKwcxy5Jhc75e/3VweJ/D2m35kaO2aNL1MncB7K6EAfg1e+Ml38kgW413C9GOpiGWB/2N4wOB9MBhYHucNlMPXTJs60NlJG9CWV8TwoKeXDfr0O5UUvVLwqLb8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742380; c=relaxed/simple;
	bh=dafIEuKWl+LEXkEWjZkUgjPP9oOtLFYUT9TqZFovKRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip7GMI5n4PR3o7BMnyN4GD9ISk9CDLHqJ86DQI9l8tzHcPwj2IZyTucibUZ4RZZrxXJ7iTemlDKTSrFNwMsASHez5CMka1pAj93tvIgUIijrk8KJBieYy0B6M2/exoEKvZJShwkoHRubH5+l/UwG5ixcQZKQSY/kQfhKAa7uMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lMloe+68; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a4df9dc885so94347885a.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723742377; x=1724347177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqaSFAda1BULnUkvbkqjvUbbEFCCq1QGyMDyl6SYwo8=;
        b=lMloe+68KABd9t2vuZ1OxXKCUr9StX+LZExERozHIBpzmUwJSqasvcO2/MwrqtXhOG
         nYveWbxZMiNmy6fa/25syXn2pig9c4X5OI9iKWtv3lNpP4vtOO+5l1TalTZLvUo7tViR
         FrEDvyHCqhm+kOP65/lKlA599SZVC65ke+PKstTcvyZAuzUb6H8S/Oa5uElyT3YQ1JHE
         /LB5iXM/cpe1p6BNTBm+AxjjB3nxv0Hs6kt/o+GMmZcViAiTSuGQwj8kBqHweqFAaPU3
         Q1ykD/TKw/Y8qTyelLktAMHMtJmqBO9vwP6QHdm9CWGxnU2wRybBcBNnKt4hlEzXVVAf
         ITJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742377; x=1724347177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqaSFAda1BULnUkvbkqjvUbbEFCCq1QGyMDyl6SYwo8=;
        b=sEPjXTfJUEsapfLxCG4E2/vQk+LhjoPGMH4GlXz178koOIZl84uJdeBVvtIxoKpBVR
         NvmWOB7QUQ2Hq9H6By7cinqr1DPVYOBwby57stuRZvaU4GDwYoOhyPPYwhih0priZeMe
         K2GNbQevXsOGDaHxgigVApkEeuKzzKVyW88bnc2Sjmtqo09jnUTuYnjdfux7PiIHjyiw
         SANY4dlo/OZmVCiMm0L9riwpSCpEGkQhGB188GaBSr/fKZYnEiBWbA0VXoO8tXZhZBT0
         DBC63Mth2u9ehAIsj6y23BfjW0gIvMirAPjPiZaChFobejdVMpkKpEJgaaO2QSR1KLDj
         LtSw==
X-Forwarded-Encrypted: i=1; AJvYcCUAzE1UjRirMas4ReCg2pBXeYSt4abEjQJrXSZmF5dka6NjwE9EoDQ8/iDoEV+KfJjFtDB8VPQuNx+0GkqtnaWvzQPWyV9kbiLTHq2D5SQ=
X-Gm-Message-State: AOJu0YxzaY+S72JLU3oEKoCjLmozWDVrjlG3c3WLGKjdMQgAFxdwcYpK
	k5CCduSfWLUNxVTUVgVttATVFxNoUOxOXy0YczXJEBNhfYh7JPvOjJ91+NoZZrE=
X-Google-Smtp-Source: AGHT+IGEGC1/A/48dBre5gaeZ0zHau3OBx975u/klzSPGEReClcShxi3bAXTedaOfHOOcJfdHkXOVA==
X-Received: by 2002:a05:620a:294c:b0:79e:f745:5445 with SMTP id af79cd13be357-7a506ff0efbmr18473085a.31.1723742377586;
        Thu, 15 Aug 2024 10:19:37 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0dcac4sm80966585a.84.2024.08.15.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1see8N-004EaT-MX;
	Thu, 15 Aug 2024 14:19:35 -0300
Date: Thu, 15 Aug 2024 14:19:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
	kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240815171935.GO3468552@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815105905.19d69576.alex.williamson@redhat.com>

On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:

> > This is probably the only way to approach this, trap and emulate the
> > places in the device that program additional interrupt sources and do
> > a full MSI-like flow to set them up in the kernel.
> 
> Your last sentence here seems to agree with this approach, but
> everything else suggests disapproval, so I don't know where you're
> going here.

Trapping and emulating is fine.

My concern is really only about skipping SET_IRQ.

That works because of the assumption that the IMS sources are going to
re-use addr/data pairs setup in the MSI CAP.

That assumption is frail, and won't work at all under the proper IMS
support Linux now has.

I really don't want to go down the road and have someone tell Thomas
he can't convert the Linux driver to use irq_domain IMS because it
will break this stuff here.

> I have no specs for this device, nor any involvement from the device
> vendor, so the idea of creating a vfio-pci variant driver to setup an
> irq_domain and augment a device specific SET_IRQs ioctls not only sounds
> tremendously more complicated (host and VMM), it's simply not possible
> with the knowledge we have at hand.  

It seems like you have reverse engineered alot of the necessary
information though??

Maybe there is a more generic approach than a variant driver. If you
wanted to use IMS from userspace generically you could imagine some
kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
needed irq_domains and pass the addr/data pair back to userspace?

> I observe that the device configures MSI vectors and then writes that
> same vector address/data elsewhere into the device.  Whether the device
> can trigger those vectors based only on the MSI capability programming
> and a secondary source piggybacks on those vectors or if this is just a
> hack by Qualcomm to use an MSI capability to acquire some vectors which
> are exclusively used by the secondary hardware, I have no idea.

Well at least that should be testable - but it seems crazy if the
device has registers for an addr/data pair and then somehow doesn't
use the values that get put in them??

Copying from the MSI is almost certainly a SW hack because IMS support
has never really existed in an OS until now. I think your guess for
why it is like this is pretty good.

> I do not believe that introducing a vfio device feature that disables
> virtualization of the MSI address/data _only_ at the vfio interface
> (not to a QEMU VM) provides some implicit support of this device
> behavior.  These values are already available to a privileged user in
> the host and the same is available for an MSI-X use case by directly
> reading the MSI-X vector table.  

To be clear, I'm not really worried about showing the data to
userspace.

Userspace just shouldn't be using it to implement an IMS technique!

Jason

