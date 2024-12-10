Return-Path: <linux-wireless+bounces-16180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298539EBB53
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 21:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64CC28452E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2222B5B2;
	Tue, 10 Dec 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="OArvQjGJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833122B5AE
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864333; cv=none; b=mN82jxSMISLs3fRbiIFdMXCQ2XgT8bGnrKdBNdTPX2CagtjATmh/gqHOrnWj54ypE1ciZ0p87V/71r96DosaDxJzRpBlUnzM59iOc7vu3mdaSi78q3BxPwiIc+G49WEQTkKRwjoofnwcq5nIrcoOc6Evu2hweMApvoo6n+0iRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864333; c=relaxed/simple;
	bh=v2raCaWN3IG/5w/aOn1R+icWgs90NdTA6z+LvPlbe1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJSJAB2rM8leJ37M3hyXc44k672SHniHtGKtZhfDxtB+Fn73GD0Y9EVwnq9B95SSczLoW2/JQMHJrmVJLOPkrSkaZvZJFBN93W7pmaABUMYj8NB8ITrCBu6Ew/y/bWrstii5e0B31xjc6V3D66sz9Oa1o96e8lGlGcuZ/7yRnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=OArvQjGJ; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1733864319; bh=v2raCaWN3IG/5w/aOn1R+icWgs90NdTA6z+LvPlbe1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OArvQjGJNCmsOR94itS7QtZxcp/cZbSiLL9l9fSA0rrBt/8AXT1jSbc4cR2z8/tmu
	 1OzHqoh/vyDUAvJO7k1U6X5GXLog723yXC4mTWoDS0MOcv3AQfM9k2Sx3jjwloZ71z
	 BJnUzK6U9fS7nmNLBOvNl79OkdEsMlcJsg8qscN6mXFA0cxSmoNYNm62Fr2pC8KJhA
	 DaPqaqh8iks88o7wNFLMB2egi+bjH/NNJ7XPCv01GBJk7F7+OlW5dXWJWb9UZ/ypPn
	 38GOlhRVE6h2BXvmB1t0vkE0dhZinC6zfiX6RILZsYfInwKQSBZT0dJYqbVTeIO0Sl
	 4uCGz0UmVaKh4K5GmsKgJaXrheMibsSf3lW/X0rykBE/T+WAG37xLZHRLoeRAmUgo6
	 jXpbjwPiRNXtNQSLfaWfT4o2kGb1miFj/K//+StV37fC504TFutA/7srb4uuBm6HNt
	 4uoWH6xj++V6Ww60iAdApQ4NP/juEavaqXe1irj7DMakfHS/heWNjb0fKIXcFYfqAt
	 s4fnyzQH3M4+0dqeUYgPqWvPm3OUEa3BWNYkFP+LDd/69lx8qM8mowTL6tuCZoRyGx
	 260VYLC+EvbzBe6PWSshjA8r4jWtxnRE5P5IyjVbkq2ok59tp00cENA332NYBu6Ao8
	 vgn92l7uTueQ93G4xp4pM3ow=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 1D46118E519;
	Tue, 10 Dec 2024 21:58:34 +0100 (CET)
Message-ID: <bfd41680-060f-4bd8-a289-f4ef69429c30@ijzerbout.nl>
Date: Tue, 10 Dec 2024 21:58:31 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] wifi: ath12k: move struct ath12k_hw from per device
 to group
To: Kalle Valo <kvalo@kernel.org>, ath12k@lists.infradead.org,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 Harshitha Prem <quic_hprem@quicinc.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
References: <20241204163216.433795-1-kvalo@kernel.org>
 <20241204163216.433795-6-kvalo@kernel.org>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241204163216.433795-6-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 04-12-2024 om 17:32 schreef Kalle Valo:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>
> Currently, hardware abstractions (ah) of different radio bands are tightly
> coupled to a single device (ab). But, with hardware device group abstraction
> (ag), multiple radios across different devices in a group can form different
> combinations of hardware abstractions (ah) within the group. Hence, the mapping
> between ah to ab can be removed and instead it can be mapped with struct
> ath12k_hw_group (ag).
> [...]
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> [...]
> -void ath12k_mac_destroy(struct ath12k_base *ab)
> +void ath12k_mac_destroy(struct ath12k_hw_group *ag)
>   {
>   	struct ath12k_pdev *pdev;
> +	struct ath12k_base *ab = ag->ab[0];
> +	int i, j;
>   	struct ath12k_hw *ah;
> -	int i;
>   
> -	for (i = 0; i < ab->num_radios; i++) {
> -		pdev = &ab->pdevs[i];
> -		if (!pdev->ar)
> +	for (i = 0; i < ag->num_devices; i++) {
> +		ab = ag->ab[i];
> +		if (!ab)
>   			continue;
>   
> -		pdev->ar = NULL;
> +		for (j = 0; j < ab->num_radios; j++) {
> +			pdev = &ab->pdevs[j];
> +			if (!pdev->ar)
> +				continue;
> +			pdev->ar = NULL;
> +		}
>   	}
>   
>   	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
> @@ -10942,26 +10945,59 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
>   	}
>   }
>   
The new ath12k_mac_destroy() looks suspicious with respect to "ab".
Here is the new function with comments.

void ath12k_mac_destroy(struct ath12k_hw_group *ag)
{
         struct ath12k_pdev *pdev;
         struct ath12k_base *ab = ag->ab[0];
==> here ag->ab[0] is used before checking if ag->num_devices is greater 
than zero
==> If ag->num_devices will never be zero then this first assignment 
will be repeated in the next for-loop
==> if ag->num_devices can be zero then you need to confirm that 
ag->ab[0] is non-NULL

         int i, j;
         struct ath12k_hw *ah;

         for (i = 0; i < ag->num_devices; i++) {
                 ab = ag->ab[i];
                 if (!ab)
=>> This if check indicates that ab can be NULL
                         continue;

                 for (j = 0; j < ab->num_radios; j++) {
                         pdev = &ab->pdevs[j];
                         if (!pdev->ar)
                                 continue;
                         pdev->ar = NULL;
                 }
         }

==> Now ab is going to be used, but as shown above, ab can be NULL
         for (i = 0; i < ath12k_get_num_hw(ab); i++) {
                 ah = ath12k_ab_to_ah(ab, i);
                 if (!ah)
                         continue;

                 ath12k_mac_hw_destroy(ah);
                 ath12k_ab_set_ah(ab, i, NULL);
         }
}

-- 
Kees

