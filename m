Return-Path: <linux-wireless+bounces-20104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3066A590CA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4227F188D3C9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDCF2253E6;
	Mon, 10 Mar 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Y00iF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A92248A8;
	Mon, 10 Mar 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601399; cv=none; b=hZ19c0K+moufS3PXMJnzCkC0dZ8XxxZzcywaYDqc7S7S5FwJGKXUO4EWv08pTfhO0qcSaLZWw0sLRxkU7TvXhpsm8L+ciXoH2/MXkcGI+ZdtjG6fRAlEtCDqKDvxbBuZdVTzr0WRr7VvOcDN83b98rYWgnGXkRwnAcHeCEXNwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601399; c=relaxed/simple;
	bh=lfgb+4yconhWI0GihEGvBTzUmrfm3IiGF84oD4PW/BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfcD7XJVdxDhPtU4sH9x0WU0H06p1pCcmgGIRnsuU7UDgfCICjP1WLw2I/nM8hdAEzx54nMjeVAfOF4EvCowS09cDMjgWAbyL4H0WLHIjpcl3ex3g782oRM7X1rI5dkb7tv8LDqXw+oQ+CBrVNjqhPRoY4UM+SNQfm8De6ZbaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Y00iF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D14FC4CEE5;
	Mon, 10 Mar 2025 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741601397;
	bh=lfgb+4yconhWI0GihEGvBTzUmrfm3IiGF84oD4PW/BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4Y00iF/XZiFLpxSZjMhOXUB3swUXhsjOtQn11daJRKHt/bIiWQSILaMpudvcGeTT
	 kF4YXcjvEQOj5xrMM5VbsNBimcQvXmc0cdk9dHbiQrJSI3LDy5zcfMjPNBBKQGz6C/
	 3YfkL3pnsQrek9w0uvkFGJflrKFjQcWH82XHXOYr1L5zjOD5eYC3AzWc0ieIiQXMKW
	 xbc2b9xRgmbaQYEG6PiMKIH8wcJs09Cz1hMeq5Muxx6zHn1wPGa6fxDQtJfdD+NjyJ
	 BqIoLzPvbnShbwYYEtlFuKOqW50LyMG0fZKyEGQsN7I6QREtJiES1tad6fhf8nV435
	 BoVFCe9UC99tQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tra52-000000006bM-3NnW;
	Mon, 10 Mar 2025 11:09:52 +0100
Date: Mon, 10 Mar 2025 11:09:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z866cCj8SWyZjCoP@hovoldconsulting.com>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310010217.3845141-3-quic_miaoqing@quicinc.com>

On Mon, Mar 10, 2025 at 09:02:17AM +0800, Miaoqing Pan wrote:
> A relatively unusual race condition occurs between host software
> and hardware, where the host sees the updated destination ring head
> pointer before the hardware updates the corresponding descriptor.
> When this situation occurs, the length of the descriptor returns 0.

I still think this description is too vague and it doesn't explain how
this race is even possible. It sounds like there's a bug somewhere in
the driver or firmware, but if this really is an indication the hardware
is broken as your reply here seems to suggest:

	https://lore.kernel.org/lkml/bc187777-588c-4fa0-ba8c-847e91c78d43@quicinc.com/

then that too should be highlighted in the commit message (e.g. by
describing this as "working around broken hardware").

> The current error handling method is to increment descriptor tail
> pointer by 1, but 'sw_index' is not updated, causing descriptor and
> skb to not correspond one-to-one, resulting in the following error:
> 
> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> To address this problem, temporarily skip processing the current
> descriptor and handle it again next time. However, to prevent this
> descriptor from continuously returning 0, use skb cb to set a flag.
> If the length returns 0 again, this descriptor will be discarded.

The ath12k ring-buffer handling looks very similar. Do you need a
corresponding workaround in ath12k_ce_completed_recv_next()? Or are you
sure that this (hardware) bug only affects ath11k devices?
 
>  	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
> -	if (*nbytes == 0) {
> -		ret = -EIO;
> -		goto err;
> +	if (unlikely(*nbytes == 0)) {
> +		struct ath11k_skb_rxcb *rxcb =
> +			ATH11K_SKB_RXCB(pipe->dest_ring->skb[sw_index]);
> +
> +		/* A relatively unusual race condition occurs between host
> +		 * software and hardware, where the host sees the updated
> +		 * destination ring head pointer before the hardware updates
> +		 * the corresponding descriptor.
> +		 *
> +		 * Temporarily skip processing the current descriptor and handle
> +		 * it again next time. However, to prevent this descriptor from
> +		 * continuously returning 0, set 'is_desc_len0' flag. If the
> +		 * length returns 0 again, this descriptor will be discarded.
> +		 */
> +		if (!rxcb->is_desc_len0) {
> +			rxcb->is_desc_len0 = true;
> +			ret = -EIO;
> +			goto err;
> +		}
>  	}

I'm still waiting for feedback from one user that can reproduce the
ring-buffer corruption very easily, but another user mentioned seeing
multiple zero-length descriptor warnings over the weekend when running
with this patch:

	ath11k_pci 0006:01:00.0: rxed invalid length (nbytes 0, max 2048)

Are there ever any valid reasons for seeing a zero-length descriptor
(i.e. unrelated to the race at hand)? IIUC the warning would only be
printed when processing such descriptors a second time (i.e. when
is_desc_len0 is set).

Johan

