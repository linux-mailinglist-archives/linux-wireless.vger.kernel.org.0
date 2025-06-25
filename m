Return-Path: <linux-wireless+bounces-24466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3CAE7DA2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 11:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B1B16B812
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935212DCC1D;
	Wed, 25 Jun 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPmh68vn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA32DCC10;
	Wed, 25 Jun 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844052; cv=none; b=pDdLXbwVxhD/oVd8ugVqzWnZcT6pXDiXUiaZz0mIY/PP7GJWGPvnoTurnTn7aixCsnLfxQevFIrCflLCS6Un/JM7w9sdcZfqprl/Q13DXZuPmGJ5+xHBvDUiclourGFIs5Lu8Yn8U9Q64HqegpEFD5pPls7KFi5vCfM+mLl4r6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844052; c=relaxed/simple;
	bh=0/e6LfauK0af41XU2bytum4b2Y0CVYm09/82M2rDCw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJFLutCPNISSBlK4eNOiTWzKp1bYAchvNIkSeUqFZLez+yU/+b3JdPxORe3prKb/Li8WYtnnjjYFw9heYVz+T/b7TOJh6Rc2GQgO7zu05+tU/CnYi02c9444DdTYGlg9ma6a0YDHBqYWVwqklnKN/3esUCELnGSEkdh/hdkIAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPmh68vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE93C4CEEA;
	Wed, 25 Jun 2025 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750844051;
	bh=0/e6LfauK0af41XU2bytum4b2Y0CVYm09/82M2rDCw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPmh68vn27DxyA8uVhf+aO8kwJDiumL6JUbvKDVxUKb6+JovY+T8mRPi6v7EduP1n
	 6ifjZP7ERDt/hBpHsLODXoPvD66mMys0fsLCeshhe8WFDcXl8CbNCm4QsbLIofT3H/
	 ivHuWk6VjA/sbr3aCrFSBRCN23fVVL8x0HmkHvtfVNWONUUb4HlhQ1K24Z2PJtrPT1
	 eHby9thPS0Mr3feclGr56JfLchNgnFhpznASqWqz2lUJIPoH7f7cWwJwwYgHHEcgUw
	 +0Dd5RPFaEqmmUpubP6OUCsxQ6HGFZ9N/03FfWQ9YYrIGYMpKVsESfpe3pTff5y0Jy
	 LUSgtuWaw5iew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUMWA-000000000LN-3gtA;
	Wed, 25 Jun 2025 11:34:10 +0200
Date: Wed, 25 Jun 2025 11:34:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Message-ID: <aFvCkiJCRmwtqhWt@hovoldconsulting.com>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <70b25ff3-b366-4e2d-a52a-0b2d50ce88c4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b25ff3-b366-4e2d-a52a-0b2d50ce88c4@quicinc.com>

On Wed, Jun 25, 2025 at 10:06:21AM +0800, Baochen Qiang wrote:
> On 5/26/2025 7:48 PM, Johan Hovold wrote:
> > Add the missing memory barriers to make sure that destination ring
> > descriptors are read after the head pointers to avoid using stale data
> > on weakly ordered architectures like aarch64.
> > 
> > Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> > 
> > Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> > Cc: stable@vger.kernel.org	# 5.6
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> > diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> > index 8522c67baabf..549d17d90503 100644
> > --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> > +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> > @@ -700,6 +700,9 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
> >  
> >  	ath11k_hal_srng_access_begin(ab, status_ring);
> >  
> > +	/* Make sure descriptor is read after the head pointer. */
> > +	dma_rmb();
> > +
> >  	while ((ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) !=
> >  		tx_ring->tx_status_tail) &&
> >  	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, status_ring))) {
> 
> Johan, dma_rmb() is put inside _srng_access_begin() for ath12k, but here inside each
> caller. Can we achieve consistency between two drivers?

I moved into into the helper also for ath11k in v2:

	https://lore.kernel.org/lkml/20250604143457.26032-2-johan+linaro@kernel.org/

Johan

