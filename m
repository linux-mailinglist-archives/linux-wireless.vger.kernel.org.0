Return-Path: <linux-wireless+bounces-4334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FD86FB35
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 08:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B36B20F4A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BB1643E;
	Mon,  4 Mar 2024 07:57:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kevlo.org (mail.kevlo.org [220.134.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4512B6F
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.134.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539074; cv=none; b=Gkem13VHKCJBzKcdP95hC/pLUFDm/wpbK5ajJPNaD6p2bv1yQFs4KO/G6lILHrNYzlfOurDNvMxxhdBa7pLluZT7F3WDDbclUZZVVb1eT4oRjXl9fRN6WedTwC8gQra0g1gOTTDQWuO247hoeKS4lU/JnFbDFhZTxlc1iVECGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539074; c=relaxed/simple;
	bh=KjS06WIqd8wWrDQave92sl2oqsONgMkpkC/jKPzCR3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iE8TWiqZqFOTE4WMxJY8swdSgbo4uNWNw7+XJIPqYe7asrvwRYn2uM+fZv383vsr6INDsZCkIH0BPPUlOR0C381TwuK2XGj1lXVT2Wdt83iV4ZWuAsMh3NBbaWtZQghvOkUphiS77sSLTlO31zdJ7KQab2I+ulV8u4XqpM6iutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kevlo.org; spf=pass smtp.mailfrom=kevlo.org; arc=none smtp.client-ip=220.134.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kevlo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevlo.org
Received: from localhost (ns.kevlo.org [local])
	by ns.kevlo.org (OpenSMTPD) with ESMTPA id c0ab81eb;
	Mon, 4 Mar 2024 15:57:42 +0800 (CST)
Date: Mon, 4 Mar 2024 15:57:42 +0800
From: Kevin Lo <kevlo@kevlo.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath11k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: adjust a comment to reflect reality
Message-ID: <ZeV+9tS5qZAyDJwc@ns.kevlo.org>
References: <Zd1Muyd8mtA1Hih7@ns.kevlo.org>
 <6bdcffce-e657-4990-bd60-5dd67abbb9c9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bdcffce-e657-4990-bd60-5dd67abbb9c9@quicinc.com>

On Fri, Mar 01, 2024 at 08:16:16AM -0800, Jeff Johnson wrote:
> 
> On 2/26/2024 6:45 PM, Kevin Lo wrote:
> > In ath11k_mhi_set_mhictrl_reset(), I observed on QCA6390/QCN9074/WCN6855,
> > MHISTATUS has SYSERR bit always been set after SOC_GLOBAL_RESET.
> > 
> > Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> > ---
> > diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> > index 3de7fa6f88d0..1198e80d9dff 100644
> > --- a/drivers/net/wireless/ath/ath11k/mhi.c
> > +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> > @@ -158,8 +158,8 @@ void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab)
> >  
> >  	ath11k_dbg(ab, ATH11K_DBG_PCI, "mhistatus 0x%x\n", val);
> >  
> > -	/* Observed on QCA6390 that after SOC_GLOBAL_RESET, MHISTATUS
> > -	 * has SYSERR bit set and thus need to set MHICTRL_RESET
> > +	/* After SOC_GLOBAL_RESET, MHISTATUS has SYSERR bit
> > +	 * always been set and thus need to set MHICTRL_RESET
> >  	 * to clear SYSERR.
> >  	 */
> >  	ath11k_pcic_write32(ab, MHICTRL, MHICTRL_RESET_MASK);
> 
> Unless you've verified this is always true for every supported chipset

Only PCIe devices trigger the call to ath11k_mhi_set_mhictrl_reset(),
and I've verified this on the QCA6390, QCN9074, and WCN6855 chips.

> I'd rather more accurately say something like:
> After SOC_GLOBAL_RESET, MHISTATUS may still have SYSERR bit set and thus...

Okay, I'll update the comments as per your suggestion, thanks.

