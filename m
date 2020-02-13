Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7130315BC4C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgBMKDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 05:03:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50451 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgBMKDC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 05:03:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so5500873wmb.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 02:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s7LSy1tmkqbzfvEB1iJ91YiD2JB+vmE5dOdmSeGnrWY=;
        b=gA0kIY/X2/j1y0EprKXAqs7etyi4vRiyAw5APBg7xIzfFxZilaBayhPwRe3vjRKWf3
         2xiEuDZ94SiqLiYTntUuuq7JEwZDOAXk1Ok0ExHHAFySQqzXssc86LJ+Tamz5B1UZey3
         yrjDlu83zynF5RuF1M7RzUZ5BAvpD9nIscVcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s7LSy1tmkqbzfvEB1iJ91YiD2JB+vmE5dOdmSeGnrWY=;
        b=tMEivvt5thWKHFR0mHUq7HJ6T7sX6SV7obIqFqIzaSNsFoeR/kBH2nY0fiGQIDZIuV
         MonCrlds3FmD1R/iZnOiMa3erYOptcf1ntt+oai+PhWbuGKssV8x/qEHpSenEP7T7Lkt
         oOdTMKV35PB3SXVo4wb+D6KXA6xNWTvCXa+bAPQ2R7Uky7rWp3PCAmRTxc59BXLzS3sD
         BUo+BLSBONshZi3e74Z8FvuuQv07hKhVQNtLVLtRRGG6cPqPYdsavtPMwJsEQGUIC/SU
         hSs9uk22q2LRPeNMyqyWxAUb4rMmkLlo6PsXfudQoSMlM34mVa7QwHmpnZNiM5ORRYBf
         S+dw==
X-Gm-Message-State: APjAAAXhsV0DZfZilaxuvfa6UA/eKEQdB85TEK5ttTtjQZFxlL/SZFEJ
        uzd8NNW/YILHMcHlCf+JnlnAFQ==
X-Google-Smtp-Source: APXvYqykOau8TVEeWioxYKAGQ5oPKPnMpotlsvjVF7wk+bnrwy2QNSe9rvxRM1LmPyB2pKYLJPBjfw==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr4876912wml.186.1581588178743;
        Thu, 13 Feb 2020 02:02:58 -0800 (PST)
Received: from [10.176.68.75] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id c9sm2143609wrq.44.2020.02.13.02.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 02:02:58 -0800 (PST)
Subject: Re: [PATCH] rtw88: set WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL, mac80211
 supports it
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        anbeltra@microsoft.com
References: <20200213050819.13467-1-yhchuang@realtek.com>
 <3121eb67-f303-01e4-a006-a39947381175@broadcom.com>
Message-ID: <c02f6e1f-c345-0ca0-0a7b-0997926d3860@broadcom.com>
Date:   Thu, 13 Feb 2020 11:02:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3121eb67-f303-01e4-a006-a39947381175@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/13/2020 10:56 AM, Arend Van Spriel wrote:
> 
> 
> On 2/13/2020 6:08 AM, yhchuang@realtek.com wrote:
>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>
>> Set wiphy flag WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL, because mac80211
>> actually supports it. With the flag set, driver can accept ROC
>> event from wpa_supplicant or some other user space tools.
> 
> This does not seem right. mac80211 does set this flag itself when the 
> driver provides remain_on_channel callback. Does that mean you already 
> have that callback? This patch is either wrong or unnecessary.

Re-reading the commit message I guess it is ok to claim 
remain-on-channel support when using sw_scan. If this is true it seems 
better to extend the condition in ieee80211_alloc_hw_nm() for setting 
the flag.

Regards,
Arend
