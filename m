Return-Path: <linux-wireless+bounces-11384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5195105D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 01:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED111F21E39
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4183C1A707C;
	Tue, 13 Aug 2024 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fpmwQCVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695F153BF6
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591007; cv=none; b=qzVP/icNlxH5v+dUNv2foYO7kzmuP0IcipazA0Cs9FTAld/+Urf5ahxhsV3b5Pfbc/ZoeHU0nmToFSmQ07M0ANfN3i522ggTDPKL/qiFj4yvEA6I63cSljvZIVhg3LYvDWFgeWUXsq4BLpKeKH5wtEEzhlKfP5DaNWCKbkN1TnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591007; c=relaxed/simple;
	bh=52yg3c8Z+sROtWrD7KOvWboHFKaZJVMGxS4XIgnp2mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSapWgNR3AkeSELRfMFxlReE9PgZilZfSpnHIIfxKBIcTuGXL84GJtaoMLM1xT5z5oZ4QFuL6DcZJCtkphHC59WHq8JkvLnzk/wI4ac4w+tHpnOAFaFK/ZfsK7mzzhgQKnUexZNF4h/S+bw002FMQRH7weQUx+uGSglLdIwsVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fpmwQCVN; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-810177d1760so1999140241.2
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723591004; x=1724195804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9bxAIpVX1riLRh+ADxS60pDEc8y/s/U7SNAzk7+y9E=;
        b=fpmwQCVNiXmLAACHcP4S1sg/TcoQz0k11HYk6h8t/lDfLwd9AfXPT4khXuxdvlvFi9
         rXauFr9OunM/8+vlDt+vU+o/FijLpKtXfkJfdG2RUxQ5sUnxL65th8M7C1f797+SavAj
         RbuYUmV0EUDFRTKVJJjDHAv523BXywdMj3YfS0tLujF8hLLlBdy8wvZJdNNKg7Wd9vQf
         e+6GN6nPXoRKZS2Upww1Xj/4c+Q2FpgRrRU19FqcXZ8oPdLL19SVWJYPorpiAy9rQ2u0
         WC6EC1JSL1/bTo8mnIy03DBAU8rx/jAjZiR1AvXvQWT4FcbO3zrc5oul2iREq/zM3kT+
         UBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723591004; x=1724195804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9bxAIpVX1riLRh+ADxS60pDEc8y/s/U7SNAzk7+y9E=;
        b=xMwrIRD7azDc3bi8pXztos4jSIpdxz2WEbMzW0vwfGc9twLojVZ2FyfNKxD1amg3FS
         XjIwQT7+qxhKHpq8bX6ZKds2Fq4PnhrTEgQaireEshmEC8KzItyAYkmryx/F215baFMy
         POdn/cbmIxuA3129UY8PXkrfNeBDnlr5goscI6NC/e6JTVHegFybqxWLXaHjwPCfmjDW
         R18lYIeQz+uQoGHKe8cQRPKYveIi1YMX65WAwtS37GK+mV0DRXpyeNZkNY5UyVr9czl2
         w2KENSwJ+BerJMajbgmZduqMracC9nPtfQQN18npAr3j8rkRWd4g2rhJECvn7AaFsRXt
         VC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtyrKkdHhZMb3G7QO1MuvJhlNz76Kp1q9rzFZS0luvEnw2XEZIacGka7Fqq3/LLVSVitq4YPXdLsUvh6Ui8L0Pt502uza71mVRI/SjVP0=
X-Gm-Message-State: AOJu0YxfLQdAxS4Fhf2hUHYFzcbiFp35J2J/WL3r5HleFlm0gdf2LYsE
	cHwk2+rVD99n3dOUitss8BveqCWv5EDPnpB6ph6Wq+i4gAVKEEjiPVXkk6E6I8Q=
X-Google-Smtp-Source: AGHT+IGoFDoTtoRoD3WRlWY/s4rTnkFYy3lRwr/J9OksbksRZd84IshvgLRkB13t/Qhd5u1Rki87Bw==
X-Received: by 2002:a05:6102:c4c:b0:491:f22:3a8 with SMTP id ada2fe7eead31-497599bc0efmr1522313137.29.1723591004199;
        Tue, 13 Aug 2024 16:16:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e0ddfasm379556485a.126.2024.08.13.16.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:16:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1se0ks-00AITY-S3;
	Tue, 13 Aug 2024 20:16:42 -0300
Date: Tue, 13 Aug 2024 20:16:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240813231642.GR1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <20240813151401.789c578f.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813151401.789c578f.alex.williamson@redhat.com>

On Tue, Aug 13, 2024 at 03:14:01PM -0600, Alex Williamson wrote:

> > Personally, I very much dislike this. Encouraging such hacky driver
> > use of the interrupt subsystem is not a good direction. Enabling this
> > in VMs will further complicate fixing the IRQ usages in these drivers
> > over the long run.
> 
> Clearly these _guest_ drivers are doing this regardless of the
> interfaces provided by vfio, so I don't see how we're encouraging hacky
> driver behavior, especially when it comes to Windows guest drivers.

Because people will then say the Linux driver can't be fixed to
properly use an irq_domain/etc as the only option that works in VMs
will be the hacky copy from MSI-X approach :\

> > Thomas Gleixner has done alot of great work recently to clean this up.
> > 
> > So if you imagine the driver is fixed, then this is not necessary.
> 
> How so? 

Because if the driver is properly using the new irq_domain/etc
infrastructure to model its additional interrupt source then this
patch won't make it work in the VM anyhow, so it is not necessary..

Your other patch would be the only short term answer.

Jason

