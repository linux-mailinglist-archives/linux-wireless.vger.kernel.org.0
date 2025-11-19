Return-Path: <linux-wireless+bounces-29121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8DBC6D12C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F9BB35291C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462B313297;
	Wed, 19 Nov 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7RLml3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7831280B;
	Wed, 19 Nov 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536640; cv=none; b=MRoYN/uMFvDFJKGF8KPF7P9tTrcYgFvRi2CuOZ49y5Y8N7yhQzgNr7+3c+/h+FCkm48Z3CoxMaPCoq1LW+vRXTExpYlTlAFZJXcaLk5XEz4GFLU2nQzVScplf0u7JXCGTaIbZfUOZ8WUhZcqzRoZvUMgbd0j3sDuiRyihpRY3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536640; c=relaxed/simple;
	bh=8NMC8I0I/Fo4Vea6TgExaeRpD8kYsIAdTAVF/dOl/48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0bk2BPWY5M6Ou1kgv5KnAI0XGPSEG7ULVFAJS+yGrlXf7eXEx+gGyFKUT5LQdOlWEGwuGQkQQw2nqugXgdTM5KGSOvh149bcHadgBz2Rbyhdc5XdL/Iwf0pDha5ZvnlfBRaMUPBM9aiI72jQ99pSod2TtV56ORnWm50ucqqtlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7RLml3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A23C113D0;
	Wed, 19 Nov 2025 07:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763536640;
	bh=8NMC8I0I/Fo4Vea6TgExaeRpD8kYsIAdTAVF/dOl/48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M7RLml3gVUXo2YrRoHeYvVRYE6AvitMboeSr+ZEltH6tWYPdVz6ufcFqokY4Ljr5w
	 78hSKu8AkikINw1Kocl9V0DkGx6xi88m14OBiLryow5MoyuLRXf4Su6KcDTODwjh7r
	 5WkMT3REIf0iKjbSyEofUhIlFEi9xg13hs4MHFc2SoG5FsL3OxLO5eEUjTGE0q71tB
	 fVse23yRqKyIZLdLfr0URIXGh4O3btGu1/H+mdbMuR69Nm4ZwRsW0j/fM47Nh8ix99
	 PeQKxBw1EpAxXRCGVup/mWvj2pnaBN920K8mGhTdE1BZWG3s2a059404s2A8v6Snj5
	 ENICm4tzm+zJQ==
Message-ID: <543fd250-5ac2-46a4-9c7f-e0ec6550b78d@kernel.org>
Date: Wed, 19 Nov 2025 08:17:15 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath5k: do not access array OOB
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org, Vincent Danjean <vdanjean@debian.org>,
 1119093@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-wireless@vger.kernel.org
References: <20251119071201.792814-1-jirislaby@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20251119071201.792814-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 11. 25, 8:12, Jiri Slaby (SUSE) wrote:
> Vincent reports:
>> The ath5k driver seems to do an array-index-out-of-bounds access as
>> shown by the UBSAN kernel message:
>> UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath5k/base.c:1741:20
>> index 4 is out of range for type 'ieee80211_tx_rate [4]'
>> ...
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x5d/0x80
>>   ubsan_epilogue+0x5/0x2b
>>   __ubsan_handle_out_of_bounds.cold+0x46/0x4b
>>   ath5k_tasklet_tx+0x4e0/0x560 [ath5k]
>>   tasklet_action_common+0xb5/0x1c0
> 
> It is real. 'ts->ts_final_idx' can be 3 on 5212, so:
>     info->status.rates[ts->ts_final_idx + 1].idx = -1;
> with the array defined as:
>     struct ieee80211_tx_rate rates[IEEE80211_TX_MAX_RATES];
> while the size is:
>     #define IEEE80211_TX_MAX_RATES  4
> is indeed bogus.
> 
> Set this 'idx = -1' sentinel only if the array index is less than the
> array size. As mac80211 will not look at rates beyond the size
> (IEEE80211_TX_MAX_RATES).
> 
> Note: The effect of the OOB write is negligible. It just overwrites the
> next member of info->status, i.e. ack_signal.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reported-by: Vincent Danjean <vdanjean@debian.org>
> Link: https://lore.kernel.org/all/aQYUkIaT87ccDCin@eldamar.lan
> Closes: https://bugs.debian.org/1119093

I forgot:
Fixes: 6d7b97b23e11 ("ath5k: fix tx status reporting issues")
Cc: stable@vger.kernel.org

Do you want me to resend?

> ---
> Cc: 1119093@bugs.debian.org
> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Cc: Nick Kossifidis <mickflemm@gmail.com>,
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> ---
>   drivers/net/wireless/ath/ath5k/base.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
> index 4d88b02ffa79..917e1b087924 100644
> --- a/drivers/net/wireless/ath/ath5k/base.c
> +++ b/drivers/net/wireless/ath/ath5k/base.c
> @@ -1738,7 +1738,8 @@ ath5k_tx_frame_completed(struct ath5k_hw *ah, struct sk_buff *skb,
>   	}
>   
>   	info->status.rates[ts->ts_final_idx].count = ts->ts_final_retry;
> -	info->status.rates[ts->ts_final_idx + 1].idx = -1;
> +	if (ts->ts_final_idx + 1 < IEEE80211_TX_MAX_RATES)
> +		info->status.rates[ts->ts_final_idx + 1].idx = -1;
>   
>   	if (unlikely(ts->ts_status)) {
>   		ah->stats.ack_fail++;

thanks,
-- 
js
suse labs

