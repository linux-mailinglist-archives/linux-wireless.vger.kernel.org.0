Return-Path: <linux-wireless+bounces-19986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60306A562F8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 09:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551D13AADAE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8261AF4C1;
	Fri,  7 Mar 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfVtOAt9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4C14D283;
	Fri,  7 Mar 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337488; cv=none; b=ObgHrZSVLb2d1HlLASIl5lFSdwewH2mVuH/3KQijcsBZfx3BLeI0oRAxEtDrvcZ4mFHOdOmPoY1QEaY+jUYANDnXv+hJME99URsHJW/x3CByLGkBD23ygO/AuucrM8MgbI82Z8VpNpp5LK3XiEUGFpA2nhapf43sImH/d4AzdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337488; c=relaxed/simple;
	bh=vpJCeiOgrIUkNzDLmzUQdmvKE38vOGJtILsPmcYctyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eol0e8JIdxqMLZECfWsQU0T2qDudWJrfq4cWBxb391pcQkkAKjc2/hnGg77DAdzIF08Dx9g0IcORZ4OMaZh1jIqlYWByiS9Op8J4CT36w1lSPtydwd0xOUr51Rt8EfYiZuVaKsnGEHWMr8p4yrp8H8QFlAI56IlN5tsMnHsEFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfVtOAt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA53C4CED1;
	Fri,  7 Mar 2025 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337487;
	bh=vpJCeiOgrIUkNzDLmzUQdmvKE38vOGJtILsPmcYctyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfVtOAt9wH6sxqq51gbzk0XjY/RUpaBfQJBa0YBABWuGeFhQGBKpMBCszkdzv0r6r
	 3w6D9wukUEI3yk3dTlkoD0KDiTHh6lLNyRwkLNiZ5K5usMwN13HHaWpRtvIRfZAl7A
	 r5ozrazsxkHQ0tXYbzyF541qHqAP8uBsdKG/ocyvNndh0VoAjtpj27JtShyF18nbbO
	 WgyRabhjbR8+xfTHihdrM5xwGGHB00xNE5HqQ7ZtFH66a1s02vbBxpcnzMPURIHazs
	 qWD5zHiivXmFUwnN/tfH6ei/VR3IGM9hVLKyujOIX+RkI8Qwk9Z0Ci4q1dL3jnF/yr
	 /BL46ReGi1kjg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tqTQT-000000005jN-2TiY;
	Fri, 07 Mar 2025 09:51:25 +0100
Date: Fri, 7 Mar 2025 09:51:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ath-next 2/2] wifi: ath11k: fix HTC rx insufficient length
Message-ID: <Z8qzjeUE1L5GxFq_@hovoldconsulting.com>
References: <20250307040848.3822788-1-quic_miaoqing@quicinc.com>
 <20250307040848.3822788-3-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307040848.3822788-3-quic_miaoqing@quicinc.com>

Hi Miaoqing,

and thanks a lot for looking into this.

On Fri, Mar 07, 2025 at 12:08:48PM +0800, Miaoqing Pan wrote:
> A relatively unusual race condition occurs between host software
> and hardware, where the host sees the updated destination ring head
> pointer before the hardware updates the corresponding descriptor.
> When this situation occurs, the length of the descriptor returns 0.

Can you explain how this race comes about?

I worry that you may just be papering over a driver or firmware bug here
so it would be good to understand how the host can see the updated
pointer before the descriptor.

Also do you have any suggestions for how to reproduce this more easily?
Some users of the X13s (aarch64) hit this very frequently, while I've
only seen it a few times. At least one user hit this consistently when
roaming, and another mentioned seeing this while driving his car with
the laptop on (and presumably seeing a lot of APs go by).

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
> 
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Please also include:

Reported-by: Johan Hovold <johan+linaro@kernel.org>

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

Johan

