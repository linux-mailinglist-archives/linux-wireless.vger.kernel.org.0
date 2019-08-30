Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4279AA350F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 12:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfH3KkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 06:40:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50870 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3KkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 06:40:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so6798918wml.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JjCGk953Wcxs0Gns8eITBhEGK4wipyV/zJbSLGtTENw=;
        b=BbrWwki/Fpi650/waZ8y2mrYZweWZJ6dZBFUqCrvE0H8xzYfNUsZ3gGJo4V++UiYBN
         sP1U3DvpfcLt1I2ehDFznhbplv8xCtqnfaeC+Dv5uhdr1Jw4SIXSSSZqarrVo6QbosE6
         La2IBTrg+GJlKRebcEPWd9gta0L6ftelr1mvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JjCGk953Wcxs0Gns8eITBhEGK4wipyV/zJbSLGtTENw=;
        b=BRw8fFD8SHvTnLqT3a99ydyXIU03crTh+mFLRJn/oveM3nZvW69XJXC0T5MMSRjThS
         OkwKzuwPTHpRZ/70aFYVG5+7PW+dVovHMbcpTaKGm+ExfPDYe/BZ10DvlBmCN2xhO+K9
         70SdqQMxogxyZcnjaEDFQd2wDL+GX19S+V+K8pAGsoip1N6bLuFe7XgWJ98Qr05hnLHo
         Pd3DK7MdXyT5Tnj7YTv6x1JHAu4P6d2AMyP5j6wdKloFCaN3Y3iz0zqmjp1pdtxMMDsO
         0+iP9/FVwn7R+g3lNZuWP8AeDX/gVNn9d4ccdRUtgSB0H1KO0Hz1GvYh08cumvvi2hyR
         +f8w==
X-Gm-Message-State: APjAAAWLLOS4q5LQLwtYOF5xJKAnNUyhkva5BoOx7/PZAd/MYKwwRMSY
        erHn+ghHqUQQzQhVThHo1UP6SQ==
X-Google-Smtp-Source: APXvYqwsiqEA7cNNg03VqSAMyz/r0eDF0hhMDXWNFrG7yLAhbFGAh0QRVnAAEjQZKQjbE05eXaMaFg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr18258664wmh.34.1567161621645;
        Fri, 30 Aug 2019 03:40:21 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id u6sm5254220wmm.26.2019.08.30.03.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 03:40:21 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: Add new helper function for channels
To:     Amar Singhal <asinghal@codeaurora.org>, jouni@codeaurora.org
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        jjohnson@codeaurora.org, rmanohar@codeaurora.org
References: <1567115381-7831-1-git-send-email-asinghal@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <01082dca-8d71-c674-1f61-ab5d7e07c007@broadcom.com>
Date:   Fri, 30 Aug 2019 12:40:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567115381-7831-1-git-send-email-asinghal@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/2019 11:49 PM, Amar Singhal wrote:
> Add new helper function to convert (chan_number, oper_class) pair to
> frequency. Call this function ieee80211_channel_op_class_to_frequency.
> This function would be very useful in the context of 6 GHz channels,
> where channel number is not unique.

That 'unique' statement does not apply to 6GHz by itself. The addition 
of 6GHz channels makes channel numbers across bands not unique.

The funcion
> Signed-off-by: Amar Singhal <asinghal@codeaurora.org>
> ---
>   include/net/cfg80211.h | 10 ++++++++++
>   net/wireless/util.c    | 23 +++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 6467b60..decafba 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4914,1 +4914,1 @@ static inline void *wdev_priv(struct wireless_dev *wdev)
>   int ieee80211_channel_to_frequency(int chan, enum nl80211_band band);
> 
>   /**
> + * ieee80211_channel_op_class_to_frequency - convert
> + * (channel, operating class) to frequency
> + * @chan_num: channel number
> + * @global_op_class: global operating class
> + *
> + * Return: The corresponding frequency, or 0 if the conversion failed.
> + */
> +int ieee80211_channel_op_class_to_frequency(u8 chan_num, u8 global_op_class);
> +
> +/**
>    * ieee80211_frequency_to_channel - convert frequency to channel number
>    * @freq: center frequency
>    * Return: The corresponding channel, or 0 if the conversion failed.
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 9aba8d54..7f64b4a 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -144,6 +144,29 @@ struct ieee80211_channel *ieee80211_get_channel(struct wiphy *wiphy, int freq)
>   }
>   EXPORT_SYMBOL(ieee80211_get_channel);
> 
> +int ieee80211_channel_op_class_to_frequency(u8 chan_num, u8 global_op_class)
> +{
> +	if (global_op_class >= 131 && global_op_class <= 135)
> +		return (5940 + 5 * chan_num);
> +	else if (global_op_class >= 115 && global_op_class <= 130)
> +		return (5000 + 5 * chan_num);
> +	else if (global_op_class >= 112 && global_op_class <= 113)
> +		return (5000 + 5 * chan_num);
> +	else if (global_op_class >= 109 && global_op_class <= 110)
> +		return (4000 + 5 * chan_num);
> +	else if (global_op_class >= 83 && global_op_class <= 84)
> +		return (2407 + 5 * chan_num);
> +	else if (global_op_class == 81)
> +		return (2407 + 5 * chan_num);
> +	else if (global_op_class == 82)
> +		return (2414 + 5 * chan_num);
> +	else if (global_op_class == 180)
> +		return (56160 + 5 * chan_num);
> +	else
> +		return 0;
> +}
> +EXPORT_SYMBOL(ieee80211_channel_op_class_to_frequency);

The function ieee80211_operating_class_to_band() uses ranges within 
switch statement, eg.:

         case 128 ... 130:
                 *band = NL80211_BAND_5GHZ;
                 return true;

For consistency it might be good to do the same here.

Regards,
Arend
