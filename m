Return-Path: <linux-wireless+bounces-20371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA7A60ABE
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 09:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DCB16A9CA
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3519006B;
	Fri, 14 Mar 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuWxy3xg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCD12CDBE;
	Fri, 14 Mar 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939599; cv=none; b=fQyq7mrCcs2OIuziUB/pA0SMAwKqorHhffUymEJa7PhRrhXOsUxUL10SVLT7AI8FMC/wch8n2T3vFCmsQR16XNT4aNnnMoNLMZIqYDj60dg94Zcx+TU9V+zRZURpJU3BCElpE4+3zECvbQtIcFrzEgIBGNyZNU7KIi+W7MfN8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939599; c=relaxed/simple;
	bh=VyYjw56OkcWtxGlsD1Q0pmAELcgjWDeg6Y0yjbO9MKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0aF4kiWLZNDY7gQWOHmUzbVRtsO2BdlKs10783wFJH7TOjs/SndHBjusM2agCl3DhrNBG3+3LZAN6K8LkyZDU337VA1uIRHU/oF+G/K0Z6bBTwWajTN6wrdq/XII85d1ufHLvta/yeo/gjH7l7B4KsS+9gBW/G/rNTuFqwLgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuWxy3xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD46C4CEE3;
	Fri, 14 Mar 2025 08:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741939598;
	bh=VyYjw56OkcWtxGlsD1Q0pmAELcgjWDeg6Y0yjbO9MKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuWxy3xgJeaO5EBV2HlXILrL+kHOV1RsZOepnzBUvYpucbXwS8QguJHxwNUsBQKZ3
	 0ZhwQG097dpKueC6gfdUH7ByDZBrpnK9XMZQLeTyjsyxKT/9g1QUrXxFzXT0t6Owze
	 LNZBqxdX6FYyLsazVhYR2UIOtLzdraToYfAjdNbT/IRlbgPHstGIHUZxWzvcCSZiAG
	 cuaJvOdx25qiAa/Rj0cN370XNrZ+d7TPJqdvGtsMZDTFWQkWAEC3OMY5RlEKEobBO+
	 hUv7zi+WmdM9cBNO6MjwYxYjGY2wl+XlPkjkXKlINbcn3c/P3zmh1PZ/et1vW9V4Nu
	 EVVxwb4lZldFg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tt03w-000000002hh-0wbN;
	Fri, 14 Mar 2025 09:06:36 +0100
Date: Fri, 14 Mar 2025 09:06:36 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
 <Z9METTzUJe9yqVEI@hovoldconsulting.com>
 <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>

On Fri, Mar 14, 2025 at 09:01:36AM +0800, Miaoqing Pan wrote:
> On 3/14/2025 12:14 AM, Johan Hovold wrote:
> > On Thu, Mar 13, 2025 at 09:31:56PM +0800, Miaoqing Pan wrote:
> >> On 3/13/2025 12:43 AM, Johan Hovold wrote:

> >>> +	/* Make sure descriptor is read after the head pointer. */
> >>> +	dma_rmb();
> >>> +
> >>>    	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
> >>>    	if (*nbytes == 0) {
> >>> +		WARN_ON_ONCE(1);	// FIXME: remove
> >>>    		ret = -EIO;
> >>>    		goto err;
> >>>    	}
> >>
> >> This issue can still be reproduced.
> >>
> >> [ 3283.687469] WARNING: CPU: 0 PID: 0 at
> >> /drivers/net/wireless/ath/ath11k/ce.c:405
> >> ath11k_ce_per_engine_service+0x228/0x3e4 [ath11k]
> > 
> > Thanks for verifying.
> > 
> > Which platform are you testing on and which kernel are you using?
> > 
> > I'm still waiting to hear back from some people testing my patch on the
> > X13s (sc8280xp).

> qcs615-ride, kernel 6.6.65.

Ok, so a downstream vendor kernel?

qcs615-ride does not even have PCIe enabled in mainline yet, but I
assume that's what you use here?
 
> I think the hardware has already ensured synchronization between 
> descriptor and head pointer, which isn't difficult to achieve. The issue 
> is likely caused by something else and requires further debugging.

Yeah, but you still need memory barriers on the kernel side.

It could be that we are looking at two different causes for those
zero-length descriptors.

The error handling for that obviously needs to be fixed either way, but
I haven't heard anyone hitting the corruption with the memory barriers
in place on the X13s yet (even if we'd need some more time to test
this).

Johan

