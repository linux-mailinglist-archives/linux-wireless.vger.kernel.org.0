Return-Path: <linux-wireless+bounces-28486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9CC2A524
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 08:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CF24ECCF7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4F729B20A;
	Mon,  3 Nov 2025 07:26:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298051E8836;
	Mon,  3 Nov 2025 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154816; cv=none; b=Dk0GI08m9YlwwNCM87OVxLVvrqzUuXoo85RSv7E410JC4Gh+1tBm+CnYld+c2RTe/dRqdKlBONPXnFUsf/9o3avxqgyK0LDdgG5CKP0M4WDXUz+5of+NbGjrv02CN8SbvXnjJcdGikyxYSxfdLFH+YWS90EiK3YLuMx3PxHftE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154816; c=relaxed/simple;
	bh=+GOZtumJAdEc90mqb1rS76zM1WObYGvJRY5hd4EJ5k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUHD6Yyn7XviqBOBqdmlm8y+9wFJHYvYzGd9BM+4RSnMxDlbo73OmVJ/91dAX8VM9OcBl/ENsXD5Bhqj21eYvU6YAaiW7JbejpEJh/aOBGAY2MY3glz3Yzzk9eoerscm0npXjS3lAxn6cupjePSRXKsAjs+42qQMUoH1yG3d4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 8AC3AA1C4E;
	Mon,  3 Nov 2025 08:26:46 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DGiRmJBlDaM4; Mon,  3 Nov 2025 08:26:46 +0100 (CET)
Received: from eyak.inrialpe.fr (freebox.danjean.fr [82.64.217.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 693B9A03EC;
	Mon,  3 Nov 2025 08:26:46 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by eyak.inrialpe.fr (Postfix) with ESMTP id 27C191A04D6;
	Mon, 03 Nov 2025 08:26:46 +0100 (CET)
Message-ID: <871fce95-f7e4-439b-be4c-4037d4f0088b@debian.org>
Date: Mon, 3 Nov 2025 08:26:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UBSAN array-index-out-of-bounds in ath5k driver
To: Jiri Slaby <jirislaby@kernel.org>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 1119093@bugs.debian.org
References: <aQYUkIaT87ccDCin@eldamar.lan>
 <791a9e59-7819-4d63-b737-65ff1de6d73d@kernel.org>
 <c41cf4eb-cabc-4345-8476-cd7a4d2c4202@kernel.org>
From: Vincent Danjean <vdanjean@debian.org>
Content-Language: fr
Autocrypt: addr=vdanjean@debian.org; keydata=
 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
 tlMEro7WXly/MLE0qaRWgbV5yZCe7hwCzPE=
In-Reply-To: <c41cf4eb-cabc-4345-8476-cd7a4d2c4202@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/11/2025 à 08:04, Jiri Slaby a écrit :
> This™:
> --- a/drivers/net/wireless/ath/ath5k/base.c
> +++ b/drivers/net/wireless/ath/ath5k/base.c
> @@ -1738,7 +1738,8 @@ ath5k_tx_frame_completed(struct ath5k_hw *ah, struct sk_buff *skb,
>          }
> 
>          info->status.rates[ts->ts_final_idx].count = ts->ts_final_retry;
> -       info->status.rates[ts->ts_final_idx + 1].idx = -1;
> +       if (ts->ts_final_idx + 1 < IEEE80211_TX_MAX_RATES)
> +               info->status.rates[ts->ts_final_idx + 1].idx = -1;
> 
>          if (unlikely(ts->ts_status)) {
>                  ah->stats.ack_fail++;
> 
> Vincent, can you test this?

It is not easy for me: the computer with this wifi card is in my parent's home.
I won't go back there until Christmas.

I will see if I can test remotely.

   Regards,
     Vincent

>> FWIW, the effect of the UB is it just overwrites the next member of info->status, i.e. ack_signal.
>>
>> thanks,
> 


