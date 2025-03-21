Return-Path: <linux-wireless+bounces-20649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24029A6B884
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 11:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB7B7A736C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE01F3B97;
	Fri, 21 Mar 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3UFHg53"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5E1E1DF1;
	Fri, 21 Mar 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551827; cv=none; b=PD+4i/YymMFsey9+jKHKClx+Npqijuq1cXJloEVZFO48fFwX12YhuKlDzLinyVYer5vj/L3UIrTzzNReiS6KKuq2beZ6Jup2VEfLk6dvIUE/6TmSTZpHpBbroPVzKL8tDCzjpB/stugvI1BCh2hZIlvZFDo7uhHttEsfwMJx0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551827; c=relaxed/simple;
	bh=YH7fJ3j+cxz0C85hFBF2iuhtOqEPJCUhbKdA9IRCfXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIy23j5UHTj1dI6Szb6+Yw4qUSkN4wLaC/iU2cttNH81uri4GiFO1i7a+q57HMLrFF8iaip8O1GIA7wJ2qtulE3qZbOQ0yTpn4AmMo4z7UGerCLM3bV6QQ/LGBkbC3YfQ8Seiq7rN4dP1Ae5q10+Kf/9LNyET4YSTYhMBBXJdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3UFHg53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651EEC4CEE3;
	Fri, 21 Mar 2025 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742551826;
	bh=YH7fJ3j+cxz0C85hFBF2iuhtOqEPJCUhbKdA9IRCfXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3UFHg53voc1NcSSosyBQlcYVGP2BnAOGZmo9ULUEr9fxMwUbemnjLqDJN0eB1mi5
	 fwQKQxMJvxvw3ZYpgl2kgoUN8+TIXo4251vri90DEwBa9iVb15wQycA8FPx7nZ6sHw
	 qxMImHkGk+Yrs4kBDrJpkaHRsvV88aYHdfJz08QQ1V+eIy2e54TUrvFa85bmN6VX3b
	 tPG4dKxm2pOr152PaDPH5fTY4ejiPP3K7ydlNZI8LVuEDrHXU4ayuvGAa+XssYu87E
	 luncr8XHXQBK1Bm8T2m+nBxt7fs6Z6M4GyGFNhvc0O5owso4K3VvB+sw0v2vlcDSPQ
	 ow4vpZ1EuXPIg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tvZKe-000000005Uu-2F5b;
	Fri, 21 Mar 2025 11:10:28 +0100
Date: Fri, 21 Mar 2025 11:10:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v4 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z907FGWBV_MNlTcE@hovoldconsulting.com>
References: <20250317072036.2066518-1-quic_miaoqing@quicinc.com>
 <20250317072036.2066518-3-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317072036.2066518-3-quic_miaoqing@quicinc.com>

On Mon, Mar 17, 2025 at 03:20:36PM +0800, Miaoqing Pan wrote:
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
> again next time. Also, skip updating the length field of the
> descriptor when it is 0, because there's a racing update, may
> never see the updated length.
> 
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

As I've argued elsewhere, I think this should be fixed by adding the
missing memory barrier which is needed to prevent ordering issues like
this on aarch64:

	https://lore.kernel.org/lkml/Z90yyrZcORhJJgNU@hovoldconsulting.com/

The fact that this alone does not seem to be sufficient to address the
issue on qcs615 (and qcs8300) suggests that there are further issues
with these platforms that need to be properly understood before adding
workarounds in one place in one driver.

I've just posted my fix, a version of which users have been running now
for a week without hitting the corruption (that some used to hit
multiple times a daily), here:

	https://lore.kernel.org/lkml/20250321094916.19098-1-johan+linaro@kernel.org/

> @@ -387,18 +387,26 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
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
> -	if (*nbytes == 0) {
> +	if (unlikely(*nbytes == 0)) {
> +		/* A relatively unusual race condition occurs between host
> +		 * software and hardware, where the host sees the updated
> +		 * destination ring head pointer before the hardware updates
> +		 * the corresponding descriptor. Temporarily skip processing
> +		 * the current descriptor and handle it again next time.
> +		 */
>  		ret = -EIO;
>  		goto err;

Your tests suggested that you always see the correct length the next
time you process the ring buffer, but AFAICT that is not guaranteed to
happen (i.e. if you hit this on the last transfer).

Johan

