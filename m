Return-Path: <linux-wireless+bounces-11358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3C950A2A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5D91F26913
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204D4433AB;
	Tue, 13 Aug 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OhNEcY6W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDA1990C4
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566658; cv=none; b=F6er4w8zXC+SKVbmfT8pwuj+lYWlkS/CuQ6hPhFtkJPnEPJ1ofBoKFcLqWzKPBYEroMM26SR9+gOdroby0uGtIGHrLHd0aAgDhtGhtjvSiE/AZUkPOPbwreXrRPSvpiIcfnjaOeACu3/V7MV4hSznCyl84JOls30P+WIP6OpHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566658; c=relaxed/simple;
	bh=jyBfJvAdoA8JEsDnsbRpPAxmQXgY/t1XQm7toOCkJFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVO05778CE7tvOu//W7OMZdWajorgdWfT3OrZgP7Y64F2kJcva9rwWs+O/igZ57QQcepzZy/J28QO3WydkehCMwCIk9P01etAFafhFCDbo06j0NE2gLwvddwJLcxiliJQUJBH4hdfnBvO3ZINWSo8jSZeqDViSanUiVHPXVFpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OhNEcY6W; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bbc1cee9b7so33736026d6.3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723566655; x=1724171455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMSdQnQ3FhCUpwpbbmmBUO0/ktrEqcKJdvt6utUH29g=;
        b=OhNEcY6Wj2zyBxOkvfWXp3vwzp5IaKh8hUMD737E0uDiShYMXEoVINWTgDLx2G78CM
         1/9RDVxG4WhknMtWbiClz/BB+ghRiU/91am2VGDq50QR8qLLlmFXSryceXiHKM0fPRT0
         uZSkNmneVbGuMSioGAbe7U4kV0RVqD9xZLT0pdX1DuXk0m4KUMQGI3uFTvGZUylRYNqb
         vsj2Z1j+g69RxKEOcRRSlibtnsiSIZnosq67PwvfXGOWqCGilTztIC8s1p14mbEIkFLe
         08pN2Wn9wjbtWR99DNBFGXCtU2zKacDF/tR2CRo3EXyacQGwyEjiTxqkLziija8kBnx/
         cx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566655; x=1724171455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMSdQnQ3FhCUpwpbbmmBUO0/ktrEqcKJdvt6utUH29g=;
        b=EhrGHFLt45LxTKK0LMMBHoD7SgemUIWWhgzw40SwV+VF599IgqSutFzjCRwG9oJG5F
         JwDlj3DTQ8iL6Gr9YPXjqjd5K1XQHQUuSpbU6no3RyqkvsmHThrxC47PldB1YgqB+p93
         hBIUtQoQO61cqQQLdpA0UvYrlYEnFzUl225aCY6Mc2fISNw/nLsnaDqJuIniu/O2s1Hr
         dLXcPbG7i/gU323IU/OD22ZrHjCCLR4CzeF8n6gR7Xm0SDgmYp1orszxtTg+VIZSNt7i
         X7dkhlGTeK8OI/9u6vEaCU7HtRzk6DLbNocJnwi6Wky81h7xVqPM7shjT28qDQ4x9HDJ
         jbjA==
X-Forwarded-Encrypted: i=1; AJvYcCWe75QSbW0yEPyCjVVaAVZPFZ7dO45RA1QWjse8cGIDVWridQS1aeM6aJSszSqa6Sqf9x59JrkG75nkDj/dBjw6+DIIVUmRdCeT6rUCeRE=
X-Gm-Message-State: AOJu0Yxh16IAZWArI33RdR7VA2Aok0vjWwyKUn/KRS18yVfwvinDaSi/
	jNLUE9T2EqnWw+XmEB5TCKpcNMNghqQHncqNtduEkvOQYmU/+MbSGdojwzvoQmQ=
X-Google-Smtp-Source: AGHT+IEUMd+MI71+yLFL74PJx8nGR3hiS2e4En+zj4fQF+nZvpu8tgHoyU3czsWLPNshCo8zsk0ICA==
X-Received: by 2002:a05:6214:4601:b0:6b5:dfd8:ece2 with SMTP id 6a1803df08f44-6bf5d1e2142mr320686d6.30.1723566655248;
        Tue, 13 Aug 2024 09:30:55 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c80132sm35284326d6.42.2024.08.13.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:30:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sduQ9-008QZt-Jo;
	Tue, 13 Aug 2024 13:30:53 -0300
Date: Tue, 13 Aug 2024 13:30:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org, quic_bqiang@quicinc.com, kvalo@kernel.org,
	prestwoj@gmail.com, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240813163053.GK1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812170014.1583783-1-alex.williamson@redhat.com>

On Mon, Aug 12, 2024 at 10:59:12AM -0600, Alex Williamson wrote:
> vfio-pci has always virtualized the MSI address and data registers as
> MSI programming is performed through the SET_IRQS ioctl.  Often this
> virtualization is not used, and in specific cases can be unhelpful.
> 
> One such case where the virtualization is a hinderance is when the
> device contains an onboard interrupt controller programmed by the guest
> driver.  Userspace VMMs have a chance to quirk this programming,
> injecting the host physical MSI information, but only if the userspace
> driver can get access to the host physical address and data registers.
> 
> This introduces a device feature which allows the userspace driver to
> disable virtualization of the MSI capability address and data registers
> in order to provide read-only access the the physical values.

Personally, I very much dislike this. Encouraging such hacky driver
use of the interrupt subsystem is not a good direction. Enabling this
in VMs will further complicate fixing the IRQ usages in these drivers
over the long run.

If the device has it's own interrupt sources then the device needs to
create an irq_chip and related and hook them up properly. Not hackily
read the MSI-X registers and write them someplace else.

Thomas Gleixner has done alot of great work recently to clean this up.

So if you imagine the driver is fixed, then this is not necessary.

Howver, it will still not work in a VM. Making IMS and non-MSI
interrupt controlers work within VMs is still something that needs to
be done.

Jason

