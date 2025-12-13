Return-Path: <linux-wireless+bounces-29724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63496CBA73E
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E66EA3067302
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3A1A2C0B;
	Sat, 13 Dec 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ciYkIJen";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eEPWgltI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3371182D2;
	Sat, 13 Dec 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765615687; cv=pass; b=jrHqHbLNXFBaIuidPYVebcHq/jMTfx02pkWa60r9PPYJ2sG2ABMiR2FqBmxXzjc1GhDhoqJTjFXcxvCV0VlnVRf715rDJLqqFiI/+jZ4NptQR8VvQsf22H8OoNkO+3/6r/UTa7ztr1TOBA6IygLMrqRVJP5ETqLLsxkHhpfog/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765615687; c=relaxed/simple;
	bh=w0AP2MvOSzY2StnZhZwikWc213GoFGRuWI+QaGzrItg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWjfEHHRKQtsCoIwzEnYgPe3uhKirgt+dxR7MY1mPkcBxnTjxSFgF7+LPoTmXTbifauuOCOm+BDpwDOPCm9RVfybiCSh3SNefx/AoCOIgBC360R3D4duqHkoPhdACJ9lufsuJpdC29k4KdaeIsbpllyj1IBrBJLtqaZd1mVmqTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ciYkIJen; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eEPWgltI; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1765615304; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NO4UpnHoDGJYpO7+1oSvv7WoTImml07inka1oOqk6OtPtzRf3Yukxy0kqlKRDdaol+
    to6nEDxF8XwBjESmxrI1tmiyJvF9etC3v5aB4kg0j2K0c6M5sdd06oRc443vtVmUW3eK
    CpiiZ2yO6bWWT+rGiN6yqhX4/vtZ7IGB0V0p2CQaj5Xu5cs54beswWW6TftgnYrSdZB1
    QFG1jy8mtVxqywbwpHxamZazUvZ4rNzD0gGuu2fCvMjcr2yVak1saBMA2OFsWlkASOUB
    8WteBbCF8rSC6UddrJfKcMkAWN7uun6tXhCnsZCLQnLmFX08qDIjY1dMxlOB8WkgAdmy
    0tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1765615304;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sjyaFnAVrn6yJFe2WQ0FAcxBNWbILjXKtPmIJdvEZ68=;
    b=RvnTY7Z4HURF7VbCjaHUTAv0yemXEpgNuahfUK/OE+J076mzPN/hIhXxcUxwWfRRVt
    foQkrHVr8yH7qFEZz8Q+WQMDcqaO9WIEpLcY+Pc6FHRKFe3q0YpFd3DAE0k9of6hiNZX
    y/diQE6b5/wRzxNcJoRcS6IylSej1goxtgSpZpmssCeTMQ5/N6cSBvA0EVPeprXmnM4V
    uA16qi0uNPQIHxDvdxBFIkS5V0h3GNjR9Hn2HfpgjDJdgqadLHws7kKkmN8G2FnVLNVI
    jZ2x91REwtJu/VsXgTK7Gxc7PMH/cCSwJV0P/nQxSLtPlpzfvUmAHTXsJxdRjVkKivCC
    mv9w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1765615304;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sjyaFnAVrn6yJFe2WQ0FAcxBNWbILjXKtPmIJdvEZ68=;
    b=ciYkIJen0eXV6zu9svWhhnXxQdIupL+vTrZk1zkFEmdc4n/h/H6VqOhyTjotGp2pya
    M8GWCcWgh9hlFWFip83dnNnMihLrYTxIkwHv+ax7OMwMu4Ply2vK8mFgfGEiFx/pHamR
    xHLvfExzSdg15EXVJLGXYyoM0S59y2cj2+y+VWgID+OrhY/X2PFnb0pw4ZmYO3KGI8es
    oBIUvb0sBiyYdiUrs/dEjz42c8Vi0urjjaNruBJDr9BajDvYjlTTFIBC3SKfD7XpHLrV
    L5kiOjL5sdJlX3PSRVEESh83zGyYx5wVpZNYL95LZlq6+XjAP4ccJttgq+aup2WmZj1C
    pCQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1765615304;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sjyaFnAVrn6yJFe2WQ0FAcxBNWbILjXKtPmIJdvEZ68=;
    b=eEPWgltIArZuPdnTJwsF/Dn23vvPuOTLvax/CLrk6oBkj5DjZt6b2Ossis7JTfBiV0
    nG3IyTJcfnbsDaO3yFBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b1BD8fhmjc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 13 Dec 2025 09:41:43 +0100 (CET)
Message-ID: <6f183d9b-183f-46df-bbf2-f9ace1455404@hartkopp.net>
Date: Sat, 13 Dec 2025 09:41:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
To: Yao Zi <ziyao@disroot.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 Daniel Gabay <daniel.gabay@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
 Kexy Biscuit <kexybiscuit@aosc.io>, Nathan Chancellor <nathan@kernel.org>
References: <20251204123204.9316-1-ziyao@disroot.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04.12.25 13:32, Yao Zi wrote:
> Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> required ops are NULL"), PTP clock registered through ptp_clock_register
> is required to have ptp_clock_info.settime64 set, however, neither MVM
> nor MLD's PTP clock implementation sets it, resulting in warnings when
> the interface starts up, like
> 
> WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> 
> I don't find an appropriate firmware interface to implement settime64()
> for iwlwifi MLD/MVM, thus instead create a stub that returns
> -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> be registered.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

I can see no progress that this patch gets upstreamed.
Who is picking up this fix?

Best regards,
Oliver


> ---
>   drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 7 +++++++
>   drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> index ffeb37a7f830..231920425c06 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
> @@ -121,6 +121,12 @@ static int iwl_mld_ptp_gettime(struct ptp_clock_info *ptp,
>   	return 0;
>   }
>   
> +static int iwl_mld_ptp_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static int iwl_mld_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>   {
>   	struct iwl_mld *mld = container_of(ptp, struct iwl_mld,
> @@ -279,6 +285,7 @@ void iwl_mld_ptp_init(struct iwl_mld *mld)
>   
>   	mld->ptp_data.ptp_clock_info.owner = THIS_MODULE;
>   	mld->ptp_data.ptp_clock_info.gettime64 = iwl_mld_ptp_gettime;
> +	mld->ptp_data.ptp_clock_info.settime64 = iwl_mld_ptp_settime;
>   	mld->ptp_data.ptp_clock_info.max_adj = 0x7fffffff;
>   	mld->ptp_data.ptp_clock_info.adjtime = iwl_mld_ptp_adjtime;
>   	mld->ptp_data.ptp_clock_info.adjfine = iwl_mld_ptp_adjfine;
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> index 06a4c9f74797..ad156b82eaa9 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
> @@ -220,6 +220,12 @@ static int iwl_mvm_ptp_gettime(struct ptp_clock_info *ptp,
>   	return 0;
>   }
>   
> +static int iwl_mvm_ptp_settime(struct ptp_clock_info *ptp,
> +			       const struct timespec64 *ts)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static int iwl_mvm_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>   {
>   	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
> @@ -281,6 +287,7 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
>   	mvm->ptp_data.ptp_clock_info.adjfine = iwl_mvm_ptp_adjfine;
>   	mvm->ptp_data.ptp_clock_info.adjtime = iwl_mvm_ptp_adjtime;
>   	mvm->ptp_data.ptp_clock_info.gettime64 = iwl_mvm_ptp_gettime;
> +	mvm->ptp_data.ptp_clock_info.settime64 = iwl_mvm_ptp_settime;
>   	mvm->ptp_data.scaled_freq = SCALE_FACTOR;
>   
>   	/* Give a short 'friendly name' to identify the PHC clock */


