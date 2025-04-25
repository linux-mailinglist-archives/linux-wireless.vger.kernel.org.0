Return-Path: <linux-wireless+bounces-22040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E4A9C033
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EBE3AED9E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD08231A41;
	Fri, 25 Apr 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Txj4nB84"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9A2CCA5
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567880; cv=none; b=nVmS5Pe+wEiW/yLugElUKbhpiLiCu8ON27WMm+qZTnmMTyQzjWteGGwRGN5OHPpnjK9OmLYp7Za8DsYCeMTi7PFwagOQZvGDFwgVigdJjSWOJYI4O30nZgNDKXAydWmf2kJdpDXFToAv/POcl1KgtQ9q4gNE793dbeibUBJ88S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567880; c=relaxed/simple;
	bh=FvUWT221dIHt2QfvfDBP9IKDJaR7CLs+HzKLt1tWKjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYh6LpdMHYT0+1r/Ffql5P8j3OD6RUI3PV/WlDEIaswlO56M50wMvRi/gT0bG8dsuwDmzvnKHvHjA9rE5Ib+R8Y3E+eYksPIGR/ooTsIJ/yHQIGsV6es1eolCrkr9EV39mohs8ZOKcej7WM36CIm9jgSvbZCUTjgRFkPCKBzA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Txj4nB84; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so1175722a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745567877; x=1746172677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DSih8e9iQB1tIgyd1ZrSA9pdnOt2MEkgMDhIDfW7cdo=;
        b=Txj4nB84EGd1rkb+60W2KR2fUyUcMBUEYZCTmreD6j3pxbbiP8aERbsItQ5wqYYcSr
         HEPDb8Cjctz2bzfIVww+vAuKqcSY1vEtfWbCrZzdgfZBqV6pvIVZ2adqS4XO6cheoIGB
         97Kz2TjEkEEyAC/cj99N/6t5li9lkdUYTUeVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745567877; x=1746172677;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSih8e9iQB1tIgyd1ZrSA9pdnOt2MEkgMDhIDfW7cdo=;
        b=Z6+9YfQ86xpLcURpik9xF1zNhAeEP7d+Oa54HI8Ic3twITMdj7+dId1Sn/CmPebzTk
         hnaSjRB5YpWSfpMXGX33qDcNxpWulKwpFHrknTIVwhLxahkscnfZO/qG7zlRHZYuRV/o
         TH4AtNLGqVlpcioiAckk78nM2Qvn8R0FP0ySXd9PJEBOsthV4TXdS5vBc1bru9oyyhHo
         IIhnHvBzEEzJt28p5BijY+/QnzGM+DM+y7OwgS1FJk69aLjqyyIC8AW9vbkdo3gBhfFm
         tdiPGPxqKw7T37kZIH4RLS76gH+6NhB6M26MIDHWPBHupgS8zLDhi/mTbLhcpHAcAUo6
         wL2w==
X-Gm-Message-State: AOJu0Yw3fY5D4ivZqpDTR5ny56FKOP4re0nvmajTSp+9uGC/+/mmXqTh
	9DQDNv8cms0xKMZLhXQxPMyNTw82Uj0rYCik5WLvltE9v0kfDWaY91vx7KhZh7hGiEmhfNJYFuo
	SBQ==
X-Gm-Gg: ASbGncu4ZJNHH6g3CZ9ucA/dH4X76PzI5w0uadoju0n5lh15nRysEsypbymvswMXATi
	9dGCvfp+LMT45cnP5Uh6k8g8WoDWWbeSkagUWZLY4xNHZF2wDUqZ/DJRaw53a06oRM//+jGYNcK
	edAMVfeRtSHp2L71okme117s4m/eaQ+4/LgH2959ojvEmGx60rJbDWtue+6xh/+mUmRyQdwSPdp
	AGik5wieXsfK0MsV7mtJ3IauE07YOJ7MiMrDNAV+r9VRvZhUW4J97anfFHggVqhsoWaAFdxHWxX
	4csaq6oyj0UNOaHjrdSp2a9sDcYbecLshw5nNzfrf1v6sI5B7Tpmd6aTzAGM0bQ08ON2HBUzvmQ
	2rXccHlxPbGqxMDqyQ2D/2hi/Iko=
X-Google-Smtp-Source: AGHT+IFbNPi6jq9HmwStIHJmFtFZtWYwBZoeKc2/uE9YhMToRHNo+7zyNGwEFKc0iCM5tBMSIaI5Vg==
X-Received: by 2002:a17:907:1b09:b0:acb:a7f6:3b7a with SMTP id a640c23a62f3a-ace5a27b3f6mr492585066b.10.1745567876821;
        Fri, 25 Apr 2025 00:57:56 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf8cb3sm92578666b.93.2025.04.25.00.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 00:57:56 -0700 (PDT)
Message-ID: <850b42ab-a637-4dd9-af18-e12523983ded@broadcom.com>
Date: Fri, 25 Apr 2025 09:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 4/4] wifi: brcmfmac: Fix structure size for
 WPA3 external SAE
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Ting-Ying Li <tingying.li@cypress.com>,
 Ting-Ying Li <tingying.li@infineon.com>, James Prestwood <prestwoj@gmail.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
 <20250424194239.2825830-5-arend.vanspriel@broadcom.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250424194239.2825830-5-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2025 9:42 PM, Arend van Spriel wrote:
> From: Ting-Ying Li <tingying.li@cypress.com>
> 
> Add pmkid parameter in "brcmf_auth_req_status_le" structure to
> align the buffer size defined in firmware "wl_auth_req_status"
> structure.
> 
> Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>

Hi Johannes,

checkpatch issued a warning about From: and SoB: difference, but how to 
resolve it. Both emails are stale so it does not matter, but I lean 
towards using the infineon email address as that is likely the most 
recent identity used given the company history. Please advice.

> [arend: adapted path to apply to per-vendor variant]
> Tested-by: James Prestwood <prestwoj@gmail.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h    | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> index 18129adb5dc2..1cbe66526d82 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> @@ -54,6 +54,7 @@ struct brcmf_auth_req_status_le {
>   	u8 peer_mac[ETH_ALEN];
>   	__le32 ssid_len;
>   	u8 ssid[IEEE80211_MAX_SSID_LEN];
> +	u8 pmkid[WLAN_PMKID_LEN];

Sure like the wifibot checks. Do run checkpatch and compile test for 
every patch before sending it out, but no kerneldoc. Will need to add 
kerneldoc for this struct field.

Regards,
Arend

>   };
>   
>   /**


