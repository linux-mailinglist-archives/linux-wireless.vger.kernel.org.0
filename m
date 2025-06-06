Return-Path: <linux-wireless+bounces-23802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C3ACFF16
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 11:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CFD16D9A4
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574912857EE;
	Fri,  6 Jun 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNMRrAiK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D42857DE;
	Fri,  6 Jun 2025 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201562; cv=none; b=pYs1btsnHbbWg5DRiTI0oe1HlzA6SzZ/USVuBAPisQRwG6wgYvMT4HvOcwvDaTrXs/rX3U/mAWjEo+h0g51NUihS+y2zW69oAjOw1hKQzSQjNgPujG9mxWvchULb1xN+Onr35DNq2X8WDOys8vpKiZ53YAdsBhyJ3v15Atd0Us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201562; c=relaxed/simple;
	bh=frCW/vBzCrEGCM+6G/qXfkE8FGMEPfIpWzwPqLwytyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG4DfuNWCHZp7r9qxZcc8Ji0zlHbBlXR2k5tZ+ZsLIcOgKe9NZgfc7Ltd2IlpKCPgQ49A/QXwD2MCDtp/v/K1mWcXhUMvvxE0PvYTFKKABxyY0/OBkUT6M93d+Mi3vJFuO+quVLxbnCSjPiVsk76Sr2qqUdsh4ofNKGcn3AV4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNMRrAiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F5FC4CEEB;
	Fri,  6 Jun 2025 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749201561;
	bh=frCW/vBzCrEGCM+6G/qXfkE8FGMEPfIpWzwPqLwytyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNMRrAiK7jsc5fKcq1zGRPDz0tUULP8frmSPSUyrliQr9nTOq9lm/pvPb76qqYiaf
	 5Q2Z88dU8DOOcCdIOeH+4u/AiM895Vcj9u9rlLRTYZtRYIWiFT6+vU4sawpMVSGcyP
	 K+p6ztCNAyQQ+HDKGOq1hSSSc8kXTfW36Zn0QcQxEiinFKsjXMIYf9ebYVt8+2uA2W
	 Ujwh1kzvKNTiHyhsELFWsUFDeqYesP02NwLadObbhMyY/mlQFtDwsZUOJjoam/2mDp
	 1rABr00hoTzQMGi276EpHhGktvXp3tLFFEKBH41LQJ37ditQY1CfG6eV2FT55L+UT+
	 DLtUVRiTiQHPA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uNTEK-000000007mi-1Oin;
	Fri, 06 Jun 2025 11:19:17 +0200
Date: Fri, 6 Jun 2025 11:19:16 +0200
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
Message-ID: <aEKylLhbfLusD3Kq@hovoldconsulting.com>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-5-johan+linaro@kernel.org>
 <a8236639-2448-4552-ac21-db7e7370e23e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8236639-2448-4552-ac21-db7e7370e23e@quicinc.com>

On Fri, Jun 06, 2025 at 03:27:04PM +0800, Miaoqing Pan wrote:
> On 6/4/2025 10:45 PM, Johan Hovold wrote:
> > Add the missing memory barriers to make sure that destination ring
> > descriptors are read before updating the tail pointer (and passing
> > ownership to the device) to avoid memory corruption on weakly ordered
> > architectures like aarch64 when the ring is full.

> > @@ -2184,6 +2187,10 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
> >   					   srng->u.src_ring.hp);
> >   		} else {
> >   			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> > +			/* Make sure descriptor is read before updating the
> > +			 * tail pointer.
> > +			 */
> > +			mb();
> 
> Is rmb() sufficient, since MMIO write already includes wmb()?

No, rmb() only orders reads against later reads.

[ The wmb() itself orders reads against later writes on aarch64, but
that's not generally guaranteed and hence should not be relied on in
driver code. ]

> >   			ath12k_hif_write32(ab,
> >   					   (unsigned long)srng->u.dst_ring.tp_addr -
> >   					   (unsigned long)ab->mem,

Johan

