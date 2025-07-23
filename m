Return-Path: <linux-wireless+bounces-25923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2EB0EDFA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483AD18854F4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53C27BF80;
	Wed, 23 Jul 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bOp3VSMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E673248F4D
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261330; cv=none; b=pEMUvUykblgUjMmDjLICHbXJdySP57QGugD+TR3cVIghUBB/Sx8iaJom+7E2ivHnPGG6wIgffdQTbfXZhbclQWhqxECH+j5gd0Y72SFOo4MHnb19E0Kp8PHIrHDCHL5ABb6ns5CmE8QvjIVmIsOX3aZXeXaKwtcRs4RCBM2O6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261330; c=relaxed/simple;
	bh=JzFRSXxGOMwBf+W7Jn7rg+ofD5FRIP6Ml+BUZ0F67o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siqRQHNvLYBLLHFOJ/Y3j8BUpFLcv1QlWrh7O0ikbd2DCpAdOBsZHRL9fFhYDLLhr9CANEDrJofQFui+jdflAqPtLQ6pdrM52DDSraKbj72ppcgntEO7RQbCHEWQoboYf2VVoPIukCE3FLCllhl+rMTA2AJq2YJTWa6coYHIlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bOp3VSMx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab6416496dso76019281cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753261327; x=1753866127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=34yyXrbJiebHJH3BcKsmw5LM+MuUrsFjZeMy8NZDjuU=;
        b=bOp3VSMxrUdhIDFy98QpQe9ePYMT8YlNVcDGfCAld9BFmD4L4NRY8gqYFUzKT5j65k
         22DrEcMwId5WNNiJV68f2VYKZF8Er5G6EslDTCg5Bzn6Wb0FABaZcB4ksRoD2LqKzjLx
         Nwg9gwSF+C8hKaQMexISOiyX1EtWz6oOmHFmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261327; x=1753866127;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34yyXrbJiebHJH3BcKsmw5LM+MuUrsFjZeMy8NZDjuU=;
        b=uzjh9NomzfW3t/R0sMlE7VZc0efIFqmygCFQcQ9YU5nYc2CHzDLB3iCSuqq22Q7cvP
         YO7v/+zNwj6Gu7WyJzivvOzar2J3QIRrf/u6yarQCTuZKpmNuS0QwZrpXEcXI2cpQ+mx
         o9Sgaza0DZIqIs/ixunokAqoKg63GIfuhnUV9S/DTO7gZd7UAE3XmZpoFZ4tfe15IreW
         gEtlL86jcza18atwSahTziJqVgKwRBtnT2PX7PA7eGbxaaUb0CU61ol/eFhEcGbGtLHU
         2OeCipneApFPDRBA90kpX3HslVjmSwPF8K8qJUJzTfgjvCLgcIwiOunuY9Yxm5DTp7ag
         xvzg==
X-Gm-Message-State: AOJu0Yzy/ArdJuj+KaO7YG18LbdyvuJMwqFyuR/R8nCIyoaaa020IcEH
	s3bPqQ3xiVr19X63QInO44V4Rf7dtCMwxD7h9ie2m9GpxLx3cjLecAenOGq+NxjsxA==
X-Gm-Gg: ASbGncvJHfMYNnfXzD2UqCOprMkZIh5Knstvuf5grZIwgQqP37GB4Ig65uZOySVlTQc
	VkKUCvY/tFj/OAfnBFs66Elo+CX07a86yVAotYDe6PhyEacKmGg2kbZSIH+QfRB3gGmUgqkxc84
	Q4I9cv/9ynQNxflWM9BBKZ1s3QuO+3XTcXq/Knti1MBqcXEZ1Pp2AFkBwJXkrGj/pYVy3OjS1U+
	vcpOeUWOIFfzZ4rHuuRpoFwI5pmcL68BXVMM9ZVGpgqXTe4QdJdYAcop/aBj6sCSJTXmfpH/iLA
	9U0q7Iu7fAXrEj1Ixs1jXoemIkbGuNVrysV/3VQ5+UinQ+2X4NNxVV2HGfsM8b6pPmb/LUuRmv9
	A5zOsYJKOgKQ0HoZS7hdSSCl4GOnNRJaXMWD+xwJYBLe6FKTLZpUS
X-Google-Smtp-Source: AGHT+IE+Trecs0D2BsuJyd/Yn74jAR0xiicEanPWK2kFhcPlshqfPcvBVfRl16o7huLnyVhKcAKmkg==
X-Received: by 2002:a05:6214:808b:b0:707:9a8:7f66 with SMTP id 6a1803df08f44-70709a880f8mr2620246d6.29.1753261327007;
        Wed, 23 Jul 2025 02:02:07 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c44d69sm622777885a.58.2025.07.23.02.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:02:06 -0700 (PDT)
Message-ID: <faa64fa7-beaa-458a-9fc9-e6b33533f534@broadcom.com>
Date: Wed, 23 Jul 2025 11:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3] wifi: brcmfmac: fix EXTSAE WPA3
 connection failure due to AUTH TX failure
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250709120454.5332-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250709120454.5332-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/2025 2:04 PM, Gokul Sivakumar wrote:
> From: Ting-Ying Li <tingying.li@cypress.com>
> 
> For WPA3-SAE Connection in EXTSAE mode, the userspace daemon is allowed to
> generate the SAE Auth frames. The driver uses the "mgmt_frame" FW IOVAR to
> transmit this MGMT frame.
> 
> Before sending the IOVAR, the Driver is incorrectly treating the channel
> number read from the FW as a frequency value and again attempts to convert
> this into a channel number using ieee80211_frequency_to_channel().
> 
> This added an invalid channel number as part of the IOVAR request to the FW
> And some FW which strictly expects a valid channel would return BAD_CHAN
> error, while failing to transmit the driver requested SAE Auth MGMT frame.
> 
> Fix this in the CYW vendor specific MGMT TX cfg80211 ops handler, by not
> treating the channel number read from the FW as frequency value and skip
> the attempt to convert it again into a channel number.
> 
> Also fix this in the generic MGMT TX cfg80211 ops handler.
> 
> Fixes: c2ff8cad6423 ("brcm80211: make mgmt_tx in brcmfmac accept a NULL channel")
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
> 
> v3:
>    * Fixed the "warning: incorrect type in assignment (different base types)"
>      properly now, after kernel test robot reported it again.
> 
>    * Used brcmf_fil_cmd_data_get() instead of brcmf_fil_cmd_int_get() util
>      for reading the channel number from the firmware as __le32 / __le16
>      type instead of s32 type.
> 
> v2:
>    * Fixed wifibot "warning: incorrect type in assignment (different base types)"
>      in cyw/core.c file.
> 
>    * Fixed >80 line length checkpatch warning by reducing variable name len
>      in cfg80211.c file.
> 
>    * Handled the return value of the BRCMF_C_GET_CHANNEL IOCTL Read operation
>      in cfg80211.c & cyw/core.c files.
> 
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 33 ++++++++++++-------
>   .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 29 ++++++++++------
>   2 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 40a9a8177de6..54b1f0c8117e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

[...]

> @@ -5606,25 +5606,36 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   		/* Add the channel. Use the one specified as parameter if any or
>   		 * the current one (got from the firmware) otherwise
>   		 */
> -		if (chan)
> -			freq = chan->center_freq;
> -		else
> -			brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
> -					      &freq);
> -		chan_nr = ieee80211_frequency_to_channel(freq);
> -		af_params->channel = cpu_to_le32(chan_nr);
> +		if (chan) {
> +			ch = ieee80211_frequency_to_channel(chan->center_freq);
> +			af_params->channel = cpu_to_le32(ch);

When we have the chan instance we can simply do following instead:

			af_params->channel = cpu_to_le32(chan->hw_value);

> +		} else {
> +			err = brcmf_fil_cmd_data_get(vif->ifp,
> +						     BRCMF_C_GET_CHANNEL,
> +						     &hw_ch, sizeof(hw_ch));

I understand the motivation to use brcmf_fil_cmd_data_get() here, but it 
may confuse people reading the code. So how about this incorporating the 
previous comment:

		if (chan) {
			hw_ch = cpu_to_le32(chan->hw_value);
		} else {
			err = brcmf_fil_cmd_data_get(vif->ifp,
						     BRCMF_C_GET_CHANNEL,
						     &hw_ch, sizeof(hw_ch));
> +			if (err) {
> +				bphy_err(drvr,
> +					 "unable to get current hw channel\n");
> +				goto free;
> +			}
> +		}
		af_params->channel = hw_ch;
>   		af_params->dwell_time = cpu_to_le32(params->wait);
>   		memcpy(action_frame->data, &buf[DOT11_MGMT_HDR_LEN],
>   		       le16_to_cpu(action_frame->len));

[...]

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> index c9537fb597ce..2cbb4a809ca7 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> @@ -112,8 +112,8 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   	struct brcmf_cfg80211_vif *vif;
>   	s32 err = 0;
>   	bool ack = false;
> -	s32 chan_nr;
> -	u32 freq;
> +	s32 ch;
> +	__le16 hw_ch;
>   	struct brcmf_mf_params_le *mf_params;
>   	u32 mf_params_len;
>   	s32 ready;
> @@ -143,13 +143,20 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   	mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
>   	mf_params->frame_control = mgmt->frame_control;
>   
> -	if (chan)
> -		freq = chan->center_freq;
> -	else
> -		brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
> -				      &freq);
> -	chan_nr = ieee80211_frequency_to_channel(freq);
> -	mf_params->channel = cpu_to_le16(chan_nr);
> +	if (chan) {
> +		ch = ieee80211_frequency_to_channel(chan->center_freq);
> +		mf_params->channel = cpu_to_le16(ch);
> +	} else {
> +		err = brcmf_fil_cmd_data_get(vif->ifp, BRCMF_C_GET_CHANNEL,
> +					     &hw_ch, sizeof(hw_ch));
> +		if (err) {
> +			bphy_err(drvr, "unable to get current hw channel\n");
> +			goto free;
> +		} else {
> +			mf_params->channel = hw_ch;
> +		}
> +	}
> +

proposing similar construct here.

Regards,
Arend

