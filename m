Return-Path: <linux-wireless+bounces-7285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B68FF8BE158
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 13:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669451F23636
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E552152516;
	Tue,  7 May 2024 11:47:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4E1509B0;
	Tue,  7 May 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082478; cv=none; b=dihIOtBUe9AVpSjhV1dJs7NI87aZJH0TLREoONs/00uYN4k/7S4uDEcWv9pI6XbfjPxe3TkmWoRUsd1k923ePFDuubbCoXJqTE9RU4q3Iz7Ft6vf6Uwzpd4kLi1wYplYcTVLo1UkoVOABZExm6p30FJn9R1N9vjzQEJIY5nDnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082478; c=relaxed/simple;
	bh=XqlqWqzc0jKPJNnekKf3D+PXT+EfBlOh48x0/iVs4u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A75Mg5cQ3U3pWk0nehGNI5DJbE6i0VApkbHfGq4Badvc546Cc+QgSA9VzL271blwAAY3kuboKBaFY1Q6yOn93uKJFjq+hIaH/f93ppxhJ13C2n4e3TCkWTC/CiVXE5l6Dn0BoAOsNBJKETo6vcTuDRAZ49JuGELtHDzJ2XHGz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a8f0d941so788326166b.2;
        Tue, 07 May 2024 04:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082475; x=1715687275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k04Up16rP/5vnkGUyojQtkSmv1wgKlps2LzusSKSQYk=;
        b=IKx5g40HHAhYVmeVexb4j5H+dXZYriWQjV9ZeHUVBz20hYdbsZmZlqAIGgAQy/lw8c
         aWlbkx2aq/Qur7cAdRQEN668qo+HqWOsOE+IPOrY4mvj3P20+nqOSlUd4RWt+3KKqbCu
         jNuxz/d//+RgWu8qPEk+LR0zjCHaMtwZ8rUuImtSg1Qy+Vfdk2JizKtTy2TIY10jWaDT
         o5Xj/qCoU/iXK9FE0fOofux6kIuAzCe+tpjDhmkA6tDOX4JJgpubQE8bW56ejbmfo3MV
         qT2ZqTiYnFJaRjNbGH8IXvwDjS6tfeUV1F9T1TYvmWN1VsH3VkovvmYpnc8V+PnE/d+i
         +aRA==
X-Forwarded-Encrypted: i=1; AJvYcCXmQf4Quy1nEeAUq1upZF5ZF8d9v9vxQ7KyzsCDI01YT/4QiK+Q60if3pnqTdsouiY/L0f1F5HHFytikDEcaKBuRC4kOF3RjMVkepHMsuRZyBt+kPzpWxVvAIJtoVSFNZBTJd5jhxWK94OPfa8h8p7fGwv63ZTAPtKaTdaOZQmJO9Q7aMg=
X-Gm-Message-State: AOJu0Yzi0s5uhpRf1eycqW3wlg6+U2gsjFYxgqCfzLkM4vLkudcCSLKu
	VlHtwddwoxdAtJv00Kuq/4aKWEIxOO/FiI4CkFefkzUYATRj48xn
X-Google-Smtp-Source: AGHT+IF+jRz13mw2CthmQbfiIayM4aAbgQsi5cdBiGDdmT/1uTLoBricrLnfUPg0MRZUBxs4F8x0Pw==
X-Received: by 2002:a17:906:c144:b0:a59:c62c:212d with SMTP id dp4-20020a170906c14400b00a59c62c212dmr4721731ejc.14.1715082475016;
        Tue, 07 May 2024 04:47:55 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709067c9800b00a59ad48a8b2sm3852649ejo.0.2024.05.07.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 04:47:54 -0700 (PDT)
Date: Tue, 7 May 2024 04:47:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: ath12k: allocate dummy net_device
 dynamically
Message-ID: <ZjoU6NuVga6PuAK2@gmail.com>
References: <20240503100440.6066-1-leitao@debian.org>
 <20240504145523.GC2279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504145523.GC2279@kernel.org>

On Sat, May 04, 2024 at 03:55:23PM +0100, Simon Horman wrote:
> On Fri, May 03, 2024 at 03:04:39AM -0700, Breno Leitao wrote:
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> > 
> > Un-embed the net_device from struct ath12k_ext_irq_grp by converting it
> > into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
> > the net_device object at ath12k_pci_ext_irq_config().
> > 
> > The free of the device occurs at ath12k_pci_free_ext_irq().
> > 
> > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > 
> > This is *very* similar to the same changes in ath11k commit
> > bca592ead82528b ("wifi: ath11k: allocate dummy net_device dynamically")
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> ...
> 
> > diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> 
> ...
> 
> > @@ -577,8 +578,11 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
> >  
> >  		irq_grp->ab = ab;
> >  		irq_grp->grp_id = i;
> > -		init_dummy_netdev(&irq_grp->napi_ndev);
> > -		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
> > +		irq_grp->napi_ndev = alloc_netdev_dummy(0);
> > +		if (!irq_grp->napi_ndev)
> > +			return -ENOMEM;
> 
> Hi Breno,
> 
> Will returning on error here leak resources allocated by
> alloc_netdev_dummy() in previous iterations of this loop?

very good catch. Thanks!

> If so, I suggest jumping to unwind handling which
> can be shared with the error path in the hunk below.

Agree. let me spend some time and propose a V2.

Thanks

