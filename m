Return-Path: <linux-wireless+bounces-11435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83220951E6D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 17:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D591C22D38
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB81B4C38;
	Wed, 14 Aug 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Aipv7Dl3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E71B4C28
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648830; cv=none; b=uMgoY1PiVtCPEpIDTzJK/87UCsnxMBmra3MVJwzDZXyLG/E+F3/EJ2jLS9uY+HqMqAmbA+QAACzR06iIPzn+m3y7P7To98hHNl/r9wot6wwdQSYbcNNFy0Ttn/DBvnDY5By/SipbLj1gxwZ7ZRgXHcd8vbMrSPCxkfuj87zYBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648830; c=relaxed/simple;
	bh=hcduPUJ63plKYFg5sMgJaJoxpYnUDTuhe5B+9+bWdAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9hnvCR6GfQLu+nN0WdY5STfmnufa6y0r0sznS1v7g+/waGUonKnWMC3GO/BL+0PzhOR/9SKoKMw2oTG7BkDNglrRkVhkXR80wq73GCs+Emu6qghia8yIjckqNiRFW1ZHCZBSW+8AwQvOnxpCVvKl/8RNh1AeEb1vK192YdMeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Aipv7Dl3; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7b28442f9so73979596d6.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723648827; x=1724253627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg23CNEDMD4zHjO1hlkwyk+loYx0YTVZ8r/y6/PQnrA=;
        b=Aipv7Dl35A35n50CHlvE2Ny2Rcf5RG1ObGB6eBe2bwytvgn6GuzVO/07MTV2HVdZQP
         nw9iaMHh+1JxaHnggMdkHiEMXCz+l4lOXl+Mbz2l27L9AagE99qRGppvVEOnVRKBzrTi
         RSd2q/XoyAihwP2WR3bAzIa0nrJwJuXjDvQViDoloHqpU//SwwkIJbuvEBQu0gvP3pAI
         Cy8b6AqicfkZmaUj3dzdDVdZGF7KdGyzLLwAfMDa9G6ZgXESa7Eq/DPpgWaOjL0nC3tX
         0dgViQFXyz/bITfJa4K6GIDwEzvxFT7wnsxyrQ9bFIkS9mLQ6T+O/XxeGccfs5F233yL
         D26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648827; x=1724253627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg23CNEDMD4zHjO1hlkwyk+loYx0YTVZ8r/y6/PQnrA=;
        b=ihImRU69mPVv12k5TzDLrxnjoRKisDHtbA9zcAZI5rZbjbgfMt4qBZghRzNeWbUBE6
         HWb/5uoZNNUxpU7F0cR0ntnu3+Ne6GUpzq5STZA1pbWZD0T0a3iGg5Yq/gATXOG7MGE/
         5blXzCmX+EFIHwkqeOQ3CLKereeubFr1sEwJb4HK/EgrLUMPUu+h7vLddU8rGCmtwg/X
         FnxFXdWIkX5F2maLH2jfdLQN7F59JUy19cJqTLsMIf/UvGXafytRyLtKiQNW+Yxs741q
         uuzwblnUzy90hvdioCTOAklUaRwqPbrpt+tsoPGTrliTPriBXCetLIYLEPUsyF+MO4sB
         G02Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDDRw0xhCyc5hWhi7Lr1I6n3tAyKSaDXRsJcQQAZXN7uN+aqfBF+eY3O1On5na5QuCr4CvTuGihYEdK1pcyye94NsUZCGXosuAKKUMxy0=
X-Gm-Message-State: AOJu0YwTJMgbOL9OEyN+o8ZzjJh62Oi8B1/g/Z2f4daKAsNw8kHtVCXU
	4coqBuzsiVuDv1uZ20TX+M/mrQZhXwocfd6YO0WtabJ6HpCdTvw4/4sAa9YH3h0=
X-Google-Smtp-Source: AGHT+IFs/BQEZjr8h6unAsrJ2o06RGnXrm/il5j+/wDCwXIvEtQlOlvpOhTjJBqTcjF825DsnYbpEw==
X-Received: by 2002:a05:6214:3c9f:b0:6bd:6ff2:bb3c with SMTP id 6a1803df08f44-6bf5d056a6dmr44429756d6.0.1723648826791;
        Wed, 14 Aug 2024 08:20:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e4e5d3sm44550136d6.110.2024.08.14.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:20:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seFnV-00EfQF-Mk;
	Wed, 14 Aug 2024 12:20:25 -0300
Date: Wed, 14 Aug 2024 12:20:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240814152025.GA3468552@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <20240813151401.789c578f.alex.williamson@redhat.com>
 <20240813231642.GR1985367@ziepe.ca>
 <20240814085505.60819623.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085505.60819623.alex.williamson@redhat.com>

On Wed, Aug 14, 2024 at 08:55:05AM -0600, Alex Williamson wrote:
> Let's imagine the guest driver does change to implement an irq_domain.
> How does that fundamentally change the problem for the VMM that guest
> MSI values are being written to other portions of the device?

If changed to irq_domain the VM will write addr/data pairs into those
special register that are unique to that interrupt source and will not
re-use values already set in the MSI table.

This means the VMM doesn't get any value from inspecting the MSI table
because the value it needs won't be there, and alos that no interrupt
routing will have been setup. The VMM must call VFIO_DEVICE_SET_IRQS
to setup the unique routing.

These two patches are avoiding VFIO_DEVICE_SET_IRQS based on the
assumption that the VM will re-use a addr/data pair already setup in
the MSI table. Invalidating that assumption is the fundamental change
irq_domain in the VM will make.

> The guest driver can have whatever architecture it wants (we don't
> know the architecture of the Windows driver) but we still need to
> trap writes of the guest MSI address/data and replace it with host
> values.

Yes you do. But the wrinkle is you can't just assume one of the
existing MSI entries is a valid replacement and copy from the MSI
table. That works right now only because the Linux/Windows driver is
re-using a MSI vector in the IMS registers.

I suggest the general path is something like:

 1) A vfio variant driver sets up an irq_domain for the additional
    interrupt source registers
 2) Somehow wire up VFIO_DEVICE_SET_IRQS so it can target vectors in
    the additional interrupt domain
 3) Have the VMM trap writes to the extra interrupt source registers
    and execute VFIO_DEVICE_SET_IRQS
 4) IRQ layer will setup an appropriate unique IRQ and route it to the
    guest/whatever just like MSI. Callbacks into the variant driver's
    irq_domain will program the HW registers.

Basically exactly the same flow as MSI, except instead of targetting a
vector in the PCI core's MSI irq_domain it targets a vector in the
variant driver's IMS IRQ domain.

Then we don't make any assumptions about how the VM is using these
interrupt vectors, and crucially, SET_IRQs is called for every
interrupt source and we rely on the kernel to produce the correct
addr/data pair. No need for copying addr/data pairs from MSI tables.

> As noted above, this does not provide any visible change to a QEMU
> guest, it only enables QEMU to implement the quirk in the other
> patch.

I see, I definitely didn't understand that it only reaches qemu from
the commit message..

Jason

