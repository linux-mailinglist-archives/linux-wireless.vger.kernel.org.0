Return-Path: <linux-wireless+bounces-11386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 408879510AA
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 01:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEDC1C20DBE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C951AC42A;
	Tue, 13 Aug 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WpTb0Dd6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC022EEF
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592382; cv=none; b=t/D/AOFYk6QOTdKjI+Rzv5b29sVLIYsVWx7Z7Ig3Dsnt6KV3n229j+IM1IM+DAKaljVwzI3qDplTkj3OekJxUSZgjLwfHxmcL6GMtBt0RF/fzyhlFQAzYtgOu1cf63qh18trRHPKsLLu69tpX2sQ1mF7FLITJKpwIB75eXxXEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592382; c=relaxed/simple;
	bh=Pd3HOMguHxSzpPeuDioCvnrJlFHD/UK1bGXz5hdR1fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbMUcg153A+5ygyiFo8txWWJXuHkjcCOvAaOmWO5Ukdj8qcTk0pnwZ7lIht0YXRncL8lHnZlne7QOY0Wua8D2RtkPDm7UEvXXw4sJoic+KbCloCBXJ+ELnmUzCoTlRPUWgYQwYso2daRXGzOW3zAdNFwas+y27gEtGhrqL6I6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WpTb0Dd6; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-820f7c6eaa5so2126705241.3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723592380; x=1724197180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98OTBv0aioFqa8eP+pfN2QrHRSjQQBWkH6KFwlgEV7s=;
        b=WpTb0Dd6NjwUza5QGEsdiAJcn2waNH/7GQM+nR037OH9nQUplH9vn/ms2Ib6synhCt
         3YClsehnYi5ozpXql/iWSY8eGgXR4NhUwThsXYNJnBZAJ6iz7AUNm+eIk19EQ44L8UmL
         SuDu2HIgy+ZKlPgScbjwSIGb5uutc8GCHUTb/yRKeubc2jO8FRVxqLNthMPJEs5oUXU4
         qIUpvct5btfjN1P1WtLmpVQG1w8CJ/l/WgXb/9ZHgYuVDu+xTQU2h25Jm8CVRxeR5V+6
         slaOoaX8FNCyIdGLaJB+P7H0B/3uFA6V9tqJQpXC5NiMRWiPDky0qPWO2tmxv/iPAlUK
         JnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723592380; x=1724197180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98OTBv0aioFqa8eP+pfN2QrHRSjQQBWkH6KFwlgEV7s=;
        b=VjnaAdicWYMJ/Ws2CuLc96R8O8eCnMPQ4h+9DIngfFDPCYlOUlDIa5VuBv6a7iYNaD
         SXAIXJ89wwuN2zYIDRW7iEt2dEws3vVtt577VneioAILOr/7MOULmVeYIJ/HN43Qgd18
         FQ4bqejHi3fdLdOv49Vbg6ohiwQ2hS9GkgkTkY4Mype8sphJJ3/INi5IBDB8o77Ge21H
         5yZeMHTORgDSEqjllHNWBhMonyTW40kGO1BVQW+zP0sd2Gb/V0JkkqERBTR19lLmsE8z
         1gPVRbbcaANkka5av5i/GSA+bFtaUCKmeaaE6BUqO3G/bOa9+yrpD7NXDZJrXi/Dq9wn
         fRZg==
X-Forwarded-Encrypted: i=1; AJvYcCU8GTH10+rwRQfbHPm3aW6rV3SvCTtXmWMb/etyzT+hXouBz0Vq2U/xz5QFU35RunyYNX2g57KcaLGDt44bAZYn3YtZWbs9UnhXaZav+5k=
X-Gm-Message-State: AOJu0Yyw2W7zuliA0vHr7Yasr5xsMjKnEN4e1DF1w9rR21G2VjDPEHG0
	mPy8NVMNxROuJVwMy5MJ/60LazihazV9R/+uo09y/OgpR4CeYOhl2u3cnNlIuPM=
X-Google-Smtp-Source: AGHT+IE48TPAx7DnvwgaTUAY+Kff+tTrcpLLhWszaW51zZJR6kZlFg0WGCb5G5Fvkt7muunVnyyQLw==
X-Received: by 2002:a05:6102:6ce:b0:48f:df47:a4a8 with SMTP id ada2fe7eead31-497599e66c9mr1595703137.29.1723592379937;
        Tue, 13 Aug 2024 16:39:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca1ab5sm37630276d6.62.2024.08.13.16.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:39:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1se175-00AOnT-0P;
	Tue, 13 Aug 2024 20:39:39 -0300
Date: Tue, 13 Aug 2024 20:39:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240813233939.GT1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <87r0aspby6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0aspby6.ffs@tglx>

On Tue, Aug 13, 2024 at 07:30:41PM +0200, Thomas Gleixner wrote:
> > Howver, it will still not work in a VM. Making IMS and non-MSI
> > interrupt controlers work within VMs is still something that needs to
> > be done.
> 
> Sure, but we really want to do that in a generic way and not based on ad
> hoc workarounds.
>
> Did the debate around this go anywhere?

No, it got stuck on the impossible situation that there is no existing
way for the VM to have any idea if IMS will work or is broken. Recall
Intel was planning to "solve" this by sticking a DVSEC in their
virtual config space that said to turn off IMS :\

So using IMS in the real world looked impractical and interest faded a
bit.

But the underlying reasons for IMS haven't gone away and more work is
coming that will bring it up again...

Jason

