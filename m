Return-Path: <linux-wireless+bounces-8370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A468D6F3C
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229EE28366A
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECA1CD15;
	Sat,  1 Jun 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+RyA/S1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC780635;
	Sat,  1 Jun 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717235984; cv=none; b=WRkvgsr0UxeTGMA/KkDFvBBAdqeiGeIBdCah5EK4LfhQktwYoJb6yeO4Isa1hc60T5ID7SeJk4t4jKZloSfhwuBzlFq9Tj5qY/FFarSyYCCkWaNyC5m8ebZEdZTxN2NwziOYc+YKBbl7fIE2wAA0UrCwLOrFVWvQD4DVqXfP8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717235984; c=relaxed/simple;
	bh=9u8gq+9PyBB4mSrF7hivzYp+QdvvifwLDjqpZQOf3W0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aplNdBFqtvx+AzmfeYzqpW0Ng8UP4dCHNHjRVTN+llojHWZ6EPPiKszhgzsX5RNwF7KCRIih66Iad+izt1WTzTHQDbvMDGClGu6w+WjWb4wSlDgb9ZbcaA+f8bikuGkdO5QhvgRQJWW+Ro7L9WzqeoXigYJBB6btb5FREV3yxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+RyA/S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF7C116B1;
	Sat,  1 Jun 2024 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717235984;
	bh=9u8gq+9PyBB4mSrF7hivzYp+QdvvifwLDjqpZQOf3W0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=i+RyA/S1DiRdlPVFTlIAzT+fVvin1ANRNpleEHEbE7K65NxZY7z3ENqBZv+NU2Rna
	 t8IzrksliUvBMiMQZpCbG1WF4ex+3nVrRSwVA1QX+3XtscaMzkXdUpnH0rpSHfvjg3
	 LIu4OMyXdYUTMKMRVbek+voBvyLcaLitfHpQvuPrXI9tiZfBOg9q3SE190i33ENFAp
	 ZGPhmzdFZ6Ozq80w+m2b2xwEqd3vH7E+qKtCx5qvta6BU0LwIZXqr9M1W4wQG92rVW
	 5Q+MegA0k09yHs27FZm9cHbG9vSN9ASysBB86xIgsoakF9ptEDaNwkG3wEzaaz7y4d
	 pIHHsobG+7T/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wireless 1/3] Revert "wifi: wilc1000: convert list
 management to RCU"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240528-wilc_revert_srcu_to_rcu-v1-1-bce096e0798c@bootlin.com>
References: <20240528-wilc_revert_srcu_to_rcu-v1-1-bce096e0798c@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171723598053.967328.11354175525825246331.kvalo@kernel.org>
Date: Sat,  1 Jun 2024 09:59:42 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> This reverts commit f236464f1db7bea80075e6e31ac70dc6eb80547f
> 
> Commit f236464f1db7 ("wifi: wilc1000: convert list management to RCU")
> replaced SRCU with RCU, aiming to simplify RCU usage in the driver. No
> documentation or commit history hinted about why SRCU has been preferred
> in original design, so it has been assumed to be safe to do this
> conversion.
> Unfortunately, some static analyzers raised warnings, confirmed by runtime
> checker, not long after the merge. At least three different issues arose
> when switching to RCU:
> - wilc_wlan_txq_filter_dup_tcp_ack is executed in a RCU read critical
>   section yet calls wait_for_completion_timeout
> - wilc_wfi_init_mon_interface calls kmalloc and register_netdevice while
>   manipulating a vif retrieved from vif list
> - set_channel sends command to chip (and so, also waits for a completion)
>   while holding a vif retrieved from vif list (so, in RCU read critical
>   section)
> 
> Some of those issues are not trivial to fix and would need bigger driver
> rework. Fix those issues by reverting the SRCU to RCU conversion commit
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-wireless/3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain/
> Fixes: f236464f1db7 ("wifi: wilc1000: convert list management to RCU")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

3 patches applied to wireless.git, thanks.

ebfb5e8fc8b4 Revert "wifi: wilc1000: convert list management to RCU"
3596717a6fbd Revert "wifi: wilc1000: set atomic flag on kmemdup in srcu critical section"
596c195680dc wifi: wilc1000: document SRCU usage instead of SRCU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240528-wilc_revert_srcu_to_rcu-v1-1-bce096e0798c@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


