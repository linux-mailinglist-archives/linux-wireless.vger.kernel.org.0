Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049AA1E788A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2Ikr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2Ikr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 04:40:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA3C03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 01:40:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so2380874wmh.5
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mrnSlBqjdrlRFZbyGF+1XBS7NqKFeuIz3NiADPPTJF4=;
        b=Egq92YjYPpXulXwim+fncQ15GMAiadAdE4yXiXxjDxNKAI/hzHRYQh8AKvgeVhtCoi
         XKRLhTBRhlZo9A5lsLFRG/iqPrZe8w+fCqmacdlA1YGRc8wCF5LeAoo5nbFqudgLrHNV
         g50Pdtk42geELKmY6cu9clvrZnORKIGiEbBME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mrnSlBqjdrlRFZbyGF+1XBS7NqKFeuIz3NiADPPTJF4=;
        b=fd+Mh76fTr1CyvuIujtAjjV/zwg8COau0dNTspc39aBQytRgHa3j7Mlev8bB/sl31N
         EKhMcQedeE4OooHE/oiQVqLTaOLhdYef+lUmmnysxotmmQpRf3FIR08g328sDsqbizy4
         Ur8R5/NzVIvuZtvZYcW8uRroDXeWkBwOR287GHJ8TVAZ/kYY7KwFBR1MawBfqQc5rubT
         eF1wtHSpphKC89aNimCLr1SSwB10SjPQ81a5EjMOAqf5/KXMXogiiMN32hUiJVWJ5g35
         AeE9n+vueksTruTHwrhXrj8FgKB8HeaQR4ZfnxWNzySDjIhaliH0VXCUXAgF24jsZFRm
         sb2A==
X-Gm-Message-State: AOAM530ZtGMVLN5jyOwm53/uBGQetx8TZ77xwlrsLqtWfUUzndGv1x+2
        lv46dp8KlnZK54MpR9pNTKiONg==
X-Google-Smtp-Source: ABdhPJywQHk+BIn58XxzAePuecsaGKrDZbjMAfiKYojXujAZwlWU9ktRTH9N8rq4B3NUgKKIlfEj/g==
X-Received: by 2002:a1c:55c4:: with SMTP id j187mr7077740wmb.75.1590741645612;
        Fri, 29 May 2020 01:40:45 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id i74sm9104154wri.49.2020.05.29.01.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 01:40:45 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: adapt to new channelization of the 6GHz band
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <j@w1.fi>
References: <1590053692-237138-1-git-send-email-arend.vanspriel@broadcom.com>
 <cbc3a214-db0d-18d4-b878-80277c210956@broadcom.com>
 <8dc9a15d50a28aea21cf452b5abe8487a542ae8e.camel@sipsolutions.net>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5732ba1c-ee47-dcfd-292a-fe2ae7ab0b6d@broadcom.com>
Date:   Fri, 29 May 2020 10:40:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <8dc9a15d50a28aea21cf452b5abe8487a542ae8e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/29/2020 10:19 AM, Johannes Berg wrote:
> On Fri, 2020-05-29 at 10:16 +0200, Arend Van Spriel wrote:
>> The 6GHz band does not have regulatory approval yet, but things are
>> moving forward. However, that has led to a change in the channelization
>> of the 6GHz band which has been accepted in the 11ax specification.
>>
>>    	case NL80211_BAND_6GHZ:
>> -		/* see 802.11ax D4.1 27.3.22.2 */
>> +		/* see 802.11ax D6.1 27.3.23.2 */
>> +		if (chan == 2)
>> +			return MHZ_TO_KHZ(5935);
> 
> I think Jouni said this was operating class 136?
> 
>> +	/* 6GHz, channels 1..233 */
>> +	if (freq >= 5935 && freq <= 7115) {
>> +		switch (chandef->width) {
>> +		case NL80211_CHAN_WIDTH_20:
>> +			*op_class = 131;
>> +			break;
>> +		case NL80211_CHAN_WIDTH_40:
>> +			*op_class = 132;
>> +			break;
>> +		case NL80211_CHAN_WIDTH_80:
>> +			*op_class = 133;
>> +			break;
>> +		case NL80211_CHAN_WIDTH_160:
>> +			*op_class = 134;
>> +			break;
>> +		case NL80211_CHAN_WIDTH_80P80:
>> +			*op_class = 135;
>> +			break;
>> +		case NL80211_CHAN_WIDTH_5:
>> +		case NL80211_CHAN_WIDTH_10:
>> +		case NL80211_CHAN_WIDTH_20_NOHT:
>> +		default:
>> +			return false;
>> +		}
> 
> If so, isn't that missing here?

At least should indeed take it into account here. However I can not get 
my hands on the 6.1 spec (yet). I have the document with editor 
instructions and operating class for channel 2 is marked as <ANA> in 
table Annex E-4. 136 would be the logical value, but without the 6.1 
spec I am not sure. I will resend the patch.

Regards,
Arend
