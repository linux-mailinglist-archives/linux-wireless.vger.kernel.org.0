Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F972F11E2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbhAKLss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbhAKLss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:48:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A7FC061786
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 03:48:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d26so16044184wrb.12
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 03:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5vvBcopCCAUDgRwgiZwXKXt8dYIYRzBa8YHZ2gi46JU=;
        b=s6V6edxlk9pUPSjGHo7yfAaCa3SxbEzaAD/9oFGBMXUBNo3OUqt+svRjgea3IjuP08
         alnRWvQ2b8MYx32r+SHXD3X4eyz1MoF2bPLpAMbb8W2QelJ47ZqpbiGDIkfmZLpCkClq
         vG0IQjrPAYgtL1Vk4A2pjb3ijGC2HOCIu8VMHzFiKQG0MXQfj+sD+Rmjtx4RiB4falO8
         rtieFBpr70gGd6zveET8Q9Rr4kQ1Mb3TudvxGJBF/6bxNv6aSXt0JEVAoIP4IjbbVeVI
         kCDm9PqxghQMXSKpq4ktKOYVqSVb4MNFqLrmtWQQy+plh2Eo4jVG6l26euARreY84bgs
         CvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5vvBcopCCAUDgRwgiZwXKXt8dYIYRzBa8YHZ2gi46JU=;
        b=QLdwMidUCFnBcqPyXszE3nxb9LFpWai/ORBIx5lgMVUkiVEO+zWN9ZOPGEJUKnHDxj
         8Y02a4NM44cpKuIHH9NEFz38uPUhYcWbAswK7Xvss1EwAQPvlmM99BoVMrj9Ybpm6+qf
         keXMB9wBtgcyxlHRBYifwH0q21pHe/afzIiI+WcXdEBzU4ze5/QT4WmvtTJGvV7a2N6B
         q3Y8aGouHzXbwsjQjy8ztANQll2FJju2mqWKy8N+wMnaK1LL+yHZiImXiGjmHZ+ZnTd3
         jIZALAkLulo0pqvK2yKlZPHnMFNTodKzhfL6rtHjBZDaIT/3A8qavQ77ljPCWerk7IKi
         CDXw==
X-Gm-Message-State: AOAM5313PtbXvAV4Mvt8lzpuYEMuyQAOgA5hskrgaz/vrG0+q8FAaqOr
        Y6Mj7Oz8Nm7X183ccZl/xMQutg==
X-Google-Smtp-Source: ABdhPJytzuoohgvcJFXvupFwPQPFQd0moV063vFjYdToxOREDsTu1aOXXs0oTbixMlUMh7brRYRrag==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr16237104wrt.204.1610365686422;
        Mon, 11 Jan 2021 03:48:06 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w4sm21555661wmc.13.2021.01.11.03.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:48:05 -0800 (PST)
Subject: Re: [PATCH 07/13] wcn36xx: Flag WIPHY_WOWLAN_MAGIC_PKT
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
 <20201228162839.369156-8-bryan.odonoghue@linaro.org>
 <87o8hvk8k9.fsf@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <9f714ca3-d101-86f8-d590-93f74cd8f88d@linaro.org>
Date:   Mon, 11 Jan 2021 11:49:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87o8hvk8k9.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/01/2021 11:38, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> 
>> Set a flag to indicate magic packet wakeup support on wcn36xx.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/net/wireless/ath/wcn36xx/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c
>> b/drivers/net/wireless/ath/wcn36xx/main.c
>> index 579bb7f4db9c..cfa2e2d20a20 100644
>> --- a/drivers/net/wireless/ath/wcn36xx/main.c
>> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
>> @@ -173,7 +173,7 @@ static struct ieee80211_supported_band wcn_band_5ghz = {
>>   #ifdef CONFIG_PM
>>   
>>   static const struct wiphy_wowlan_support wowlan_support = {
>> -	.flags = WIPHY_WOWLAN_ANY
>> +	.flags = WIPHY_WOWLAN_ANY | WIPHY_WOWLAN_MAGIC_PKT
>>   };
> 
> Shouldn't this be the last patch so that we don't enable the feature
> until it's fully implemented? This makes a difference when doing a
> bisect, for example.
> 

Sure, I'll add the flags from the subsequent patch and stack on-top so 
the enable is the last patch for magic packet and gtk rekey
