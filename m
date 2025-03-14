Return-Path: <linux-wireless+bounces-20373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCDA60B2D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 09:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0134614C2
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92571A2545;
	Fri, 14 Mar 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvofsQ9o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1F1A3153;
	Fri, 14 Mar 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940457; cv=none; b=PdhR37op8ZFqgtHUdZiJQffqXfuMeel8/XYjLiHRtkKu46p/MA8N4C9eHLsgFCYYW10NXxX2eJXMYy+JNnv+XGHgni2ToGpFkYZHHg7OW9vMGi/Wz/Yw2qrx/ixUL9IZPZQx7wEmCZS3glofrjYe10+m27z4e1IPePROIsvWzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940457; c=relaxed/simple;
	bh=f/kStw48aQBGQy35frF+7V2aEEA00ieAtTWKjV0l8cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g51a9oPHKpnd1bzyaljSBmKWP8+4CJ99woNhLu0mCkYhUWt9ZEoZXTQ2wQQ7tMVfs1fUsFPXcwzmKMODWRVLgQPeewXb156YejBEBkJ+hCn9EOs5cL0vbW04BVS+bqc1Q6BwKCSV5/nNxhOJKlDDUhenIhX8xGNKBpS7oFRwDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvofsQ9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C887C4CEE3;
	Fri, 14 Mar 2025 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940457;
	bh=f/kStw48aQBGQy35frF+7V2aEEA00ieAtTWKjV0l8cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvofsQ9olLoE2wHocil0BEsP7JID4FC94pY7TNU+FzdCexy/ZRjuBqDuRRxTCuD4V
	 HGChAh+uSkdnuF24sOIJB0AAhrGn65lsZblrgEa8czF/E2c4aTXh5eZlMzdkeMCMuj
	 1GhCQbRNVhVXR4GYB9bjNaMQ2//WLJrK3I5ukrqOY/5xaXbjPGtkwJQUchGs0QfZ6B
	 MUVm/InIbotLdROlmorA9Uf+ehWYIO9hFE2Gm9pXYSMSjDJSmaO5pyzBHVOISJPad6
	 jKs1kEyJjQonXU2NlldsB6QFrVr5U+CHi0VRs2e/mDvZfl49qeqiCDdJD5LS+CtMIz
	 m1Z19QZz5CWXw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tt0Hn-0000000032G-0Xpi;
	Fri, 14 Mar 2025 09:20:55 +0100
Date: Fri, 14 Mar 2025 09:20:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v3 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z9Pm56Xx7kYZl8fk@hovoldconsulting.com>
References: <20250314061353.106194-1-quic_miaoqing@quicinc.com>
 <20250314061353.106194-3-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314061353.106194-3-quic_miaoqing@quicinc.com>

On Fri, Mar 14, 2025 at 02:13:53PM +0800, Miaoqing Pan wrote:
> A relatively unusual race condition occurs between host software
> and hardware, where the host sees the updated destination ring head
> pointer before the hardware updates the corresponding descriptor.
> When this situation occurs, the length of the descriptor returns 0.
> 
> The current error handling method is to increment descriptor tail
> pointer by 1, but 'sw_index' is not updated, causing descriptor and
> skb to not correspond one-to-one, resulting in the following error:
> 
> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> To address this problem and work around the broken hardware,
> temporarily skip processing the current descriptor and handle it
> again next time. However, to prevent this descriptor from
> continuously returning 0, use the skb control block (cb) to set
> a flag. If the length returns 0 again, this descriptor will be
> discarded.
> 
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

> @@ -387,18 +387,36 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
>  
>  	ath11k_hal_srng_access_begin(ab, srng);
>  
> -	desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
> +	desc = ath11k_hal_srng_dst_peek(ab, srng);
>  	if (!desc) {
>  		ret = -EIO;
>  		goto err;
>  	}
>  
>  	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);

As I mentioned elsewhere, this function also sets the length field in
the descriptor to zero. So if there's a racing update, you may never see
the updated length.

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

If you add the memory barrier and make sure not to clear the length
field above, do you still see the length sometimes always reading zero
if you retry more than once (i.e. drop the is_desc_len0 flag)?

Perhaps the device is really passing you a zero-length descriptor that
can simply be discarded straight away?

Johan

