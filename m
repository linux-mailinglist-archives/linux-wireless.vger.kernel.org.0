Return-Path: <linux-wireless+bounces-20328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B528FA5FB2B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 17:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A309D18933B1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5C3268FFE;
	Thu, 13 Mar 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3ILvSVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7CD77104;
	Thu, 13 Mar 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882449; cv=none; b=SWjxCLs4n2+bJ9frLWFZP9a+4ACauwCbjB+i1A0IRz3eY2SIydpjRLPz2qvJpRiRhSc4P8WzutOo/3IREJdccbkNvxmD+JhNxTrGMVIlERImnIZLp5Iy6hqXRnbiLxST2e0NhUDF2IwAVuMxbcaito57UTlrh09Fd153bFtti5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882449; c=relaxed/simple;
	bh=kVIx3poAd8OW3CFGk9U2phX4eDoS4t+1NFLX/Hlc1pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckXQG/eerux2HWfOT8d54Vd6I5DSXlPSKnO9MqIrv5ns1OIJq4KhP3e3IZ7ahH+4osZDQQQoHcVmn23R9+UBEroAN3NnoyoghFcIoQ2zEHPqt+a3sQlRHXTIpKFBQu9bznOSvUcKJLVedEjEoq5qjE7k8lraSvvEZCblq2BqUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3ILvSVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E72C4CEDD;
	Thu, 13 Mar 2025 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882448;
	bh=kVIx3poAd8OW3CFGk9U2phX4eDoS4t+1NFLX/Hlc1pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3ILvSVdjvltJY5TAkSIGJLsm90dXJMo1cCW7jVod3QaKlVR248Tyy4SWj3pfrW/k
	 ZAdMDvgIKudqgO3z6zXzKrLpnDrjecypY5YDKmRk+blojfDQVQfIc4HOJWykrWPl5y
	 kjHor3ltS0EnB7oPfm5KB+B+1lza9saKjbTLt01hSPSTIkO/tx+EC1C7bbOLelX3KQ
	 wxANO0E47bx926Cevku1AyqdMWmx7/D3dNmXY0yGs7EGEo9wWFaLA5R8vVob8Q9oTB
	 wX7tRu2PRPeKEmelIBgyZYdw1ULpfz0nTdp/EyMklez35o25vglBAunEzW5ma046Uz
	 G2g4fyBv9UNjQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tslC9-000000000xS-3nxk;
	Thu, 13 Mar 2025 17:14:06 +0100
Date: Thu, 13 Mar 2025 17:14:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z9METTzUJe9yqVEI@hovoldconsulting.com>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>

On Thu, Mar 13, 2025 at 09:31:56PM +0800, Miaoqing Pan wrote:
> On 3/13/2025 12:43 AM, Johan Hovold wrote:
> > On Wed, Mar 12, 2025 at 09:11:45AM +0800, Miaoqing Pan wrote:
> >> On 3/11/2025 11:20 PM, Jeff Johnson wrote:

> >>> That didn't answer Johan's first question:
> >>> Are there ever any valid reasons for seeing a zero-length descriptor?
> >>
> >> The events currently observed are all firmware logs. The discarded
> >> packets will not affect normal operation. I will adjust the logging to
> >> debug level.

Have you looked at the device side of things as well? Could it be that
the firmware is doing something wrong when forwarding the logs?

How sure are you that you only see this with firmware logs?

> > I've taken a closer look at the driver and it seems like we're missing a
> > read barrier to make sure that the updated descriptor is not read until
> > after the head pointer.
> > 
> > Miaoqing, could you try the below patch with your reproducer and see if
> > it is enough to fix the corruption?
  
> > +	/* Make sure descriptor is read after the head pointer. */
> > +	dma_rmb();
> > +
> >   	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
> >   	if (*nbytes == 0) {
> > +		WARN_ON_ONCE(1);	// FIXME: remove
> >   		ret = -EIO;
> >   		goto err;
> >   	}
> 
> This issue can still be reproduced.
> 
> [ 3283.687469] WARNING: CPU: 0 PID: 0 at 
> /drivers/net/wireless/ath/ath11k/ce.c:405 
> ath11k_ce_per_engine_service+0x228/0x3e4 [ath11k]

Thanks for verifying.

Which platform are you testing on and which kernel are you using?

I'm still waiting to hear back from some people testing my patch on the
X13s (sc8280xp).

Johan

