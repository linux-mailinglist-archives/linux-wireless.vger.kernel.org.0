Return-Path: <linux-wireless+bounces-3026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C5846FF6
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729071F24DA8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09137140764;
	Fri,  2 Feb 2024 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIrRIrOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CC13F009
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876196; cv=none; b=dkqoAuh7fBoqYUX8nACpMPrpTrK2OWabKOmMMqFrc55sCEub1K1/lQ/MVQVQVXkN1epTQhXzvoViPLo9yvncU/0qQ+RbUrLiYZlS9JbHP5u2euKrvCwn14aY3FaUhMFOk+2lgjiDg85hzeJAsLvVYy+aa8/dDe7XgN1l12WwFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876196; c=relaxed/simple;
	bh=vsCTrypPgQBUy+UjcZZL2T6JpKJkNjDRlOAk0xfL4jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQPxzOq8//HWOBecb9QFTkNuaBNtEV40Ic5/y6spfAlUgpIANlyk1i+Zw/te00+ifgkhRcIiY5pYxWiqrd9u+dEy15llXAmZ84+mNFoVi7IpKdnX/BVxleCbYRGNHjHcNIh0qL6I9+YwNKw3yV0qj+VtqIq/OcakD1SwyZNWg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIrRIrOX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1925326a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Feb 2024 04:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706876194; x=1707480994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3WrQlKWmTzgxXM9Xq7iWZ37ybL6PQV7GmW6fl32Nxz8=;
        b=gIrRIrOXzN66tTmD0rsNEr6q38mTrpXW6jzRWQKe4xSdB3huy/YsBxqB8FVpFwBilv
         uzmLF2uXjCHRBLHFGGsRDTNUMTcAMiA3wyhDX+yIYrr28xNgl8XkBAkfH7l/9kWI93rS
         yMXJKY/5XCrlxXlzqnoICwYIwPtjHFas5ldAkS0G1HlDvPcGmEV9ix4EEzpp6ImuMfhU
         X3ndRMuRlTGc3gEtfZu75yj6k1FwP/1VVrFaWN4Ydydw/C/gY26ViCxgFusrrvjp095V
         Jhm2HcW7KxYhx6+4TBLna+X3tnSj5oeLZmnBfMb0Fb3Evi1l/s4vn+D+gIYZ/E0diwYj
         8r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876194; x=1707480994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WrQlKWmTzgxXM9Xq7iWZ37ybL6PQV7GmW6fl32Nxz8=;
        b=mNmK7Jad3WAUScb+iBHZJP+X3maA+u16sE0fggu2mK0WiM1zuNsG2tcNPVuT3lvgeN
         ehCl4e4kXzTXCaG8Pd6j2ikTK37A1207J5AglhupJyDuxWjUZfrnuzcXXRCNuH44Z+uz
         eDaIQrHKEnHkqYQMK9zUQ7rkvfIwCsktDKdd/8InsuBpFSLQcqHB4lMex+ms0tbWgoDL
         xobEx0FmljXj3L7183CrNfYRgoLAQwPn9ZO+i/rwYkVRETXGfOU+D72zP5gZHG2Rf6kM
         LfLFY6sN+VWHWCIkB61U3ZIDnZu3rMnsP/Y54YHqD3BcyGHDB/wlMNX/tpFRScqNkLjo
         N7yg==
X-Gm-Message-State: AOJu0Yx0LpaVDnvhAeABl9jOMMOOKKCbhrsh2hD1uVaDlSLhi2M3Yumo
	H2DXppereTPj2K7be4ObuEGeFyTQoI3yhn3Ok3THVTO5DvSyPKAtbvuI8RZ5Aw==
X-Google-Smtp-Source: AGHT+IFSwEV2m0Gdmgd6lEedpwK/MfSLND1vfenzThu++22xu2B5azEXkWVeQKf2qKJSz4JPkb0iug==
X-Received: by 2002:a05:6a20:7d83:b0:19e:3c7f:cbbe with SMTP id v3-20020a056a207d8300b0019e3c7fcbbemr6479540pzj.9.1706876194527;
        Fri, 02 Feb 2024 04:16:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIbd9h/zN8zW55YNPgvoxkUt0iVLXCIPcM/ljKjrL3w8GQ/vvoo5s6qZJFJUuatnCU7xjeeTWtjCJ/+6TQew2LXihhqmXW6rmhgxOtd54sMqN9Tu9sJayCep52VVQM/7WlK+NkLmBy9lcoYgWqkKefIxYDPRsDbZg72ZQiE6Cp
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id b19-20020a63eb53000000b005cda7a1d72dsm1439531pgk.74.2024.02.02.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:16:34 -0800 (PST)
Date: Fri, 2 Feb 2024 17:46:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, mhi@lists.linux.dev,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/8] bus: mhi: host: add new interfaces to handle
 MHI channels directly
Message-ID: <20240202121630.GC8020@thinkpad>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-3-kvalo@kernel.org>
 <20240130181938.GB4218@thinkpad>
 <d002afe9-3c01-413c-82d2-353db0356802@quicinc.com>
 <20240201100040.GB17027@thinkpad>
 <07668be1-8366-43b5-83ca-bf66d0d8087b@quicinc.com>
 <20240202071011.GA2961@thinkpad>
 <34e80f19-8804-4505-b134-f099e087b53e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34e80f19-8804-4505-b134-f099e087b53e@quicinc.com>

On Fri, Feb 02, 2024 at 06:49:19PM +0800, Baochen Qiang wrote:
> 
> 
> On 2/2/2024 3:10 PM, Manivannan Sadhasivam wrote:
> > On Fri, Feb 02, 2024 at 02:42:58PM +0800, Baochen Qiang wrote:
> > > 
> > > 
> > > On 2/1/2024 6:00 PM, Manivannan Sadhasivam wrote:
> > > > On Wed, Jan 31, 2024 at 03:39:26PM +0800, Baochen Qiang wrote:
> > > > > 
> > > > > 
> > > > > On 1/31/2024 2:19 AM, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Nov 27, 2023 at 06:20:16PM +0200, Kalle Valo wrote:
> > > > > > > From: Baochen Qiang <quic_bqiang@quicinc.com>
> > > > > > > 
> > > > > > > When using mhi_power_down_no_destroy() MHI hosts need to unprepare MHI channels
> > > > > > > by themselves.  Similarly, MHI stack will also not create new MHI device since
> > > > > > > old devices were not destroyed, so MHI hosts need to prepare channels as well.
> > > > > > > Hence add these two interfaces to make that possible.
> > > > > > > 
> > > > > > > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > > > > > > 
> > > > > > > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> > > > > > > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> > > > > > > ---
> > > > > > >     drivers/bus/mhi/host/main.c | 107 ++++++++++++++++++++++++++++++++++++
> > > > > > >     include/linux/mhi.h         |  20 ++++++-
> > > > > > >     2 files changed, 126 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> > > > > > > index d80975f4bba8..3f677fc628ad 100644
> > > > > > > --- a/drivers/bus/mhi/host/main.c
> > > > > > > +++ b/drivers/bus/mhi/host/main.c
> > > > > > > @@ -1669,6 +1669,58 @@ int mhi_prepare_for_transfer_autoqueue(struct mhi_device *mhi_dev)
> > > > > > >     }
> > > > > > >     EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
> > > > > > > +static int ____mhi_prepare_for_transfer(struct device *dev, void *data)
> > > > > > 
> > > > > > "__mhi_prepare_all_for_transfer"
> > > > > 
> > > > > This is to prepare one single child device, I don't think a name like
> > > > > __mhi_prepare_all_for_transfer (with 'all' inside) make sense, right?
> > > > > How about changing to "mhi_prepare_dev_for_transfer" or
> > > > > "mhi_prepare_single_for_transfer"?
> > > > > 
> > > > 
> > > > I think most of the checks in this function can be moved inside
> > > > mhi_prepare_for_transfer() API. With that you can just reuse the API without
> > > > adding a new helper.
> > > > 
> > > > For autoqueue channels, you can add another API
> > > > mhi_prepare_all_for_transfer_autoqueue() just like
> > > > mhi_prepare_for_transfer_autoqueue() to maintain uniformity.
> > > > 
> > > > - Mani
> > > If we do that, we need to call two APIs together, does it make sense? From
> > > the view of an MHI user, what we want is an API to prepare all channels, no
> > > matter whether a channel is configured as autoqueue or non-autoqueue, we
> > > don't care about it.
> > > 
> > 
> > You are calling this API from a wrong place first up.
> > mhi_{prepare/unprepare}_transfer* APIs are meant to be used by the client
> > drivers like QRTR. Controller drivers should not call them.
> > 
> > What you need here is the hibernation support for QRTR itself and call these
> > APIs from there.
> 
> OK, I got your point. QRTR is the right place to manage MHI channels, not
> ath11k it self.
> And we even don't need these two APIs if change to do it in QRTR.
> 
> > 
> > > And besides, I don't think there is a scenario where we need to use them
> > > separately. So if we always need to use them together, why not merge them in
> > > a single API?
> > > 
> > 
> > A single controller driver may expose multiple channels and those will bind to
> > multiple client drivers. So only the client drivers should manage the channels,
> > not the controller drivers themselves.
> Exactly.
> 
> Great thanks for the proposal, Mani. Will change accordingly in next
> version.
> 

And you can drop the RFC tag in the version.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

