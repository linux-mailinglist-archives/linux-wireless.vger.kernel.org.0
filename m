Return-Path: <linux-wireless+bounces-23804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7AACFF68
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C45B173F8C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB21F4701;
	Fri,  6 Jun 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rebNEyMv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21527468;
	Fri,  6 Jun 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202641; cv=none; b=U+XHgXusNW3GqcvzC885ylMiMOg3R7gAK1gKVtIl96ifeREZBWFXqTYRFURzVJqSnj7xbWD/0ydmoexjEZy3rbr+UUobwuXN98jnat/gqCobLwq3Ii7LjR6nzta0/HQvbEfPWVkcbza9ENN+MPgqgG2WZoHcRjdiUIH0RB6aXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202641; c=relaxed/simple;
	bh=a9Zg/DhoRqaLyi2gmTsRz1QWED8HUHhMKVYw0b0MLaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHsgwz1Ajv0f0weaBl/s6XRi2MeY+wf5ZiqKNPlsZrnJDA9ZEJo6XGZN+yLRRDWbZGFmQrmFKkc804vMBquacGrhUXNJp13Cud7GAbH6+VPgIMFA36DPDgOUY3XcbTOcWcATfihgRNdKzdtF2zx+8r2iZsHf8g+uWWjXO39FDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rebNEyMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49711C4CEEB;
	Fri,  6 Jun 2025 09:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749202640;
	bh=a9Zg/DhoRqaLyi2gmTsRz1QWED8HUHhMKVYw0b0MLaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rebNEyMvMYlywgjkjaA5J0/uuXWIXSLc6zgj/dGdlsiZosql0U8UEzlkhGdOrCVNX
	 QCXkyKhmNvG2S2OOL06l1ptZqqFIXan8fEZRpHD0UUDEIo8GaWElcz1dbOSkCQvV9b
	 Z0JnD890NNQllDqryXTiJTi+U2FJbDWB1aTIG/oNWpi2I7S5YkS/qxJDnlVS/CbUx8
	 bVrW39gEB8/2iP+ubx8Z87KowkPOKTbscLbefMienA/R00FgW4FJK57I8QNsXlfKDc
	 dIfs1B1R+N+4fSeymzZK+RCQQLjqZNhRA/LGfCoNIT9cUlIbSO1esjVy75z3tw5l5t
	 HreKk1oTkY6WQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uNTVj-0000000039m-1X7v;
	Fri, 06 Jun 2025 11:37:16 +0200
Date: Fri, 6 Jun 2025 11:37:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Remi Pommarel <repk@triplefau.lt>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] wifi: ath12k: fix dest ring-buffer corruption
 when ring is full
Message-ID: <aEK2y8mMSQtbsKq2@hovoldconsulting.com>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-5-johan+linaro@kernel.org>
 <a8236639-2448-4552-ac21-db7e7370e23e@quicinc.com>
 <aEKylLhbfLusD3Kq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEKylLhbfLusD3Kq@hovoldconsulting.com>

On Fri, Jun 06, 2025 at 11:19:16AM +0200, Johan Hovold wrote:
> On Fri, Jun 06, 2025 at 03:27:04PM +0800, Miaoqing Pan wrote:
> > On 6/4/2025 10:45 PM, Johan Hovold wrote:
> > > Add the missing memory barriers to make sure that destination ring
> > > descriptors are read before updating the tail pointer (and passing
> > > ownership to the device) to avoid memory corruption on weakly ordered
> > > architectures like aarch64 when the ring is full.
> 
> > > @@ -2184,6 +2187,10 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
> > >   					   srng->u.src_ring.hp);
> > >   		} else {
> > >   			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> > > +			/* Make sure descriptor is read before updating the
> > > +			 * tail pointer.
> > > +			 */
> > > +			mb();
> > 
> > Is rmb() sufficient, since MMIO write already includes wmb()?
> 
> No, rmb() only orders reads against later reads.
> 
> [ The wmb() itself orders reads against later writes on aarch64, but
> that's not generally guaranteed and hence should not be relied on in
> driver code. ]

Sorry, I meant to say: an rmb() would order reads against later writes
on aarch64 (but that's not generally guaranteed and hence should not be
relied on in driver code).

Johan

