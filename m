Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2043657A10
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 05:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF0De0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 23:34:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37131 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfF0De0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 23:34:26 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so1581114iok.4
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2019 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxDvf2EckOFsaWAF+zMj7Hm50/dc6nb7LsEYeMsZ3hk=;
        b=eRpWdlfuu+A6OEdiV1qhT5guPlgtKctbQ69jxdFyllFS8wVAtikTN1jV75K1tHllvl
         oPbmqXpeotzEtekJuCxzrBY8c05Wsowzx2L8q7SbWOHqshv7buY6RHMabcD1vWnDm5+G
         nALVQfH1sqX/nVC2ZmuMhgiXZyU0t7tJmMoHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxDvf2EckOFsaWAF+zMj7Hm50/dc6nb7LsEYeMsZ3hk=;
        b=ECQdDjtdpgz+OnVAzIWu7+yeS8+UW5TvziZeia5XrypWQSEaPChcscUubORx2QuGSc
         tIutgg+wy7cToDTvki6ZDtc//BxpKsuKKBt+gqazdxIzFK0woBINUsHPGfg0WYFacMo6
         TnODd8E9k7gs9RzSHL742ACCpZ3WzWxDwT1kpe+OHuUamO1/yR5Hg8d+joZIRD24YZL2
         pfJeV0FSTNZPo5Nb1y/l3C8qa4Bsxk55J68dKBeNqkgJ5oHc9EA0BUS/7wTQF6LVPzgU
         DN9GRzVEYYbnGIWF/k2V9Ij3A644zlSRqafB9yrXrUCTGQAeIFyvTqxaU8jOk7plmxWx
         0MTg==
X-Gm-Message-State: APjAAAWi30iW/rVxpYSCY911GCcuYOEyawHLqAXXGPzQSlx1/lhBUMgw
        kDMp57FVQSrlvMjC13tQU8TWYg==
X-Google-Smtp-Source: APXvYqwZIRB3Q5ITjsBX19z9dZ8zAt/ttB279IMyg/3OvEyjlzYQ3nsra3lQHVmCioNv5HA6mQiqAg==
X-Received: by 2002:a5d:8195:: with SMTP id u21mr2064521ion.260.1561606465802;
        Wed, 26 Jun 2019 20:34:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t19sm652941iog.41.2019.06.26.20.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 20:34:25 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined behavior
 in bit shift
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        johannes@sipsolutions.net, Shuah Khan <skhan@linuxfoundation.org>
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
 <20190627032532.18374-4-c0d1n61at3@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
Date:   Wed, 26 Jun 2019 21:34:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627032532.18374-4-c0d1n61at3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/26/19 9:25 PM, Jiunn Chang wrote:
> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
> significant bit to unsigned.
> 
> Changes included in v2:
>    - use subsystem specific subject lines
>    - CC required mailing lists
> 
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> ---

Move version change lines here. They don't belong in the commit log.

>   include/uapi/linux/nl80211.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 6f09d1500960..fa7ebbc6ff27 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -5314,7 +5314,7 @@ enum nl80211_feature_flags {
>   	NL80211_FEATURE_TDLS_CHANNEL_SWITCH		= 1 << 28,
>   	NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR		= 1 << 29,
>   	NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR	= 1 << 30,
> -	NL80211_FEATURE_ND_RANDOM_MAC_ADDR		= 1 << 31,
> +	NL80211_FEATURE_ND_RANDOM_MAC_ADDR		= 1U << 31,
>   };
>   
>   /**
> 

thanks,
-- Shuah
