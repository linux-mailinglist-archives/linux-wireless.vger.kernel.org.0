Return-Path: <linux-wireless+bounces-12490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5448A96C150
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38561F22E03
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221F61DB94D;
	Wed,  4 Sep 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS5fXJjb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EC1DA608;
	Wed,  4 Sep 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461634; cv=none; b=cjictIhCqwho9Dx344JLbWotX1tcdpailaxZOyhfSc+a2vz0OmLu5cOJGZdUiAPofP+tPQzQ1SL1VDfdWpoXWsz0hVpBpuXbNi1ZzxVGkj1GAZHrVlm/5idvX74ZVIgI5L29Z6N1sT6uR7o4JwwdEVlRRLTLp52CNWscvzsJA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461634; c=relaxed/simple;
	bh=x949IdhBGiEjjv/A0ydxf0MZtvlczgR0jv1B5+4oj/I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrAUANg0u9qiAwnDQnfaNW/An1ocvtEzmS3dmkUDL3AED65RcUTCLrbK1h/3IkGccgMOyyUM9Get5xIKs5ZQC5LVvG+4mBvLYBjlbJXkZfFFMLyWyHPnqoIM3rxGEKhbzHpG1mxb8ySYNFYTW2kuv8LxltiqE2AxcZ+KAefgmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS5fXJjb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86abbd68ffso164971466b.0;
        Wed, 04 Sep 2024 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725461631; x=1726066431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maoPS4oxSTuZ9S/xU0gayMwVs7HWVgQua2YIMDRQrMc=;
        b=QS5fXJjbcNi3OiWF0bdmfqtnTzaCoTKXrBB0DulylfNZxO5hx5kS5CwV25knFPfDmi
         VlSlY3fwB1XOVitzvyiBW3JMcP+dn59qK7/mD6Gk5oyFxp8IG1TbKvwVqF5obCp0JRKT
         ISnvcvXsG9m5mc5fYaMNhxZSkfeR3S+WYeaMRiUaNx8PtFrz2vh1uyQSQn9sylnYC2kY
         e31K2KWVKFjN3ehfvMqBKgRqDq0C1pkhJlDQu04nwndHS52+KHGJuqg8IdaFTP8jn/Tl
         DopXDtrCJRtl18C6gwghxBzRbNyxkx+zUWTu0jiVFUPsgT+suK2io9RX3qRTIKxQRY49
         eBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461631; x=1726066431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maoPS4oxSTuZ9S/xU0gayMwVs7HWVgQua2YIMDRQrMc=;
        b=Jnn/IMM5sJwG3EbxsnC0gRLf15MeR4EJaYWCgJ1qSsEO70ytchoWNUZwoBNp5ml2zJ
         xNWakuGjm8XBbGnUYBjF2ta02LjFsxWCT7H4nUl3WwpF22EixGi7e1KxyU2ZuK43aG+0
         WAup0qsjfNVCuxXqlFUYEQrd8NlCfpVGyvWpBzDSuNalK+vQfKP1Gu3hXi1qEaY5HJti
         NnVzsu+ltlSZEAoH/OvtSJPmccWYYrbPr4CHVzYZ5Z7tJBoAwBB/r9xFYvqoffu5EQIc
         zttjmutGThi+rmrLGP/C1DOwDQwX4PKKM51Va0nXE2mgfzS/wjTwLzzYdRhtqL5T4Mp9
         S8qg==
X-Forwarded-Encrypted: i=1; AJvYcCU4nNjoXPJMNG+T8nirT1IJV6ScSla+YKSSlUWVNUWu9R6cVXX2BtQc3utkyvAeCYj7Rk8K5wAGURg/@vger.kernel.org, AJvYcCUzAtlaW7f4xkLy4qDBl66FIRDL57vZtRx1cmy4wRPlya0Ertzl3ydMTizo3K/IfjBVVWOm6UY7QRbfzBfTpwM=@vger.kernel.org, AJvYcCXPJKRIU+2uSw45sBHqV2U2tWjKK4Cv/VGbdc0OUmLyxBiYglEZRp1LeRHz0lViP2GHEmCBUhXf@vger.kernel.org, AJvYcCXuy5oLHNQj1ejWBRYWQi5LvJBDi1VfAsiNbi34fC7q5uqb/949IWqDoLfMIoJE0iJcr2guLzuB56hDjVxE@vger.kernel.org
X-Gm-Message-State: AOJu0YwomhNdNcqXwH5MLugqp3ysukZosgOtY4UW4qy/2DIQcKaVdhrD
	N/GPAUGVaRyIx3ro4fPZDkfAK4X3Wo98J08UUh5U/4u2wxo5qkg+
X-Google-Smtp-Source: AGHT+IEFoTw35/FdxNCVm+/H9zZa+NzgrnOff+RYNxn8b2GRrl1sC4DkdjOCWReulr0J2guyrg1gNw==
X-Received: by 2002:a17:907:3a95:b0:a7a:a4cf:4f93 with SMTP id a640c23a62f3a-a8a4319cf62mr156412066b.32.1725461629930;
        Wed, 04 Sep 2024 07:53:49 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62037380sm2240566b.47.2024.09.04.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:53:49 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 4 Sep 2024 16:53:46 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, linux@armlinux.org.uk,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	nico@fluxnic.net, arend.vanspriel@broadcom.com, kvalo@kernel.org,
	robh@kernel.org, saravanak@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 6/7] wifi: wlcore: sdio: Make use of
 irq_get_trigger_type()
Message-ID: <20240904145346.GA68482@vamoiridPC>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-7-vassilisamir@gmail.com>
 <ZtchHGEBtn-BVB-l@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtchHGEBtn-BVB-l@smile.fi.intel.com>

On Tue, Sep 03, 2024 at 05:45:48PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 03, 2024 at 12:55:33AM +0200, Vasileios Amoiridis wrote:
> > Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> > simple irq_get_trigger_type(irq).
> 
> ...
> 
> >  	memset(res, 0x00, sizeof(res));
> >  
> >  	res[0].start = irq;
> > -	res[0].flags = IORESOURCE_IRQ |
> > -		       irqd_get_trigger_type(irq_get_irq_data(irq));
> > +	res[0].flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> >  	res[0].name = "irq";
> 
> 
> >  	if (wakeirq > 0) {
> >  		res[1].start = wakeirq;
> > -		res[1].flags = IORESOURCE_IRQ |
> > -			       irqd_get_trigger_type(irq_get_irq_data(wakeirq));
> > +		res[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(wakeirq);
> >  		res[1].name = "wakeirq";
> >  		num_irqs = 2;
> 
> Since you are touching a lot here, consider also using macros from ioport.h,
> i.e. DEFINE_RES_IRQ_NAMED().
> 
> This will become something like
> 
> 	res[0] = DEFINE_RES_IRQ_NAMED(irq, "irq");
> 	res[0].flags |= irq_get_trigger_type(irq);
> 
> 	if (wakeirq > 0) {
> 		res[1] = DEFINE_RES_IRQ_NAMED(wakeirq, "wakeirq");
> 		res[1].flags |= irq_get_trigger_type(wakeirq);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Hi Andy,

Thank you very much for reviewing this, I will check this out
and apply the proposed changes to this and the next one.

Cheers,
Vasilis

