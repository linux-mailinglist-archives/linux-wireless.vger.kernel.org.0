Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77C2F11CB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbhAKLrE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbhAKLrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:47:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64BDC061786
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 03:46:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e25so14804029wme.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jan 2021 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XSf3cATVnfXU2DHec2iv9P/oWqfxNRXAiyDBkuQGH6g=;
        b=zr73rtWTUTRpgsggCjbRLLAfX6pwJ2FeDLhUwTquaDJa8Wf2z+u0brqiy+Ciiq5JnH
         jKkoceI+FsEObixhCogn3p00EIQCrxUHY6bFN9M/rduVrk5VbyLpl9Rtok24a4TB3g8V
         +m0hBVsWcGQgy0PzNKMW6EZnebzflMiuJ3jQAbZ20btRu06Fn8pJZ2MIfKT4JHW8QssJ
         NjdT5wMt728QEyjoLYku3E08s3cYlN5SzTeQNL0YV8tXI3DSb1m+WBvvpZaeoX07jHpD
         1PVj0YIEJi2dBRhwzFJ6nwIaMZnIKa8Tb12TfPZO2CAdAK77q2w/aG85C1BPR649d42R
         0vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XSf3cATVnfXU2DHec2iv9P/oWqfxNRXAiyDBkuQGH6g=;
        b=INMoIBUDCmMuvYm2X3iScqr3h5qHuvCxd57eOBcxdYebd/g0wPCDhmwl6skitK/N4/
         fkUUYomILtMBYanugQVe2UikEKzhMi7rbusgRwFbTayY0/ss64JSSNgyiK+Tw4OuPIi4
         uZ3jwJOEObUbaX54z9YbrDfKus5iFq74QQ90goVB73mfvFwhdWXC36Jcsd//dd/M1BEc
         3m56n8FbD5h9umxej+B0QcCRjbyKJBUdFS7e1IOAs1lW1gZnQV10TSKDhP0tf02I6Jvq
         uq+emBk/oMvyIEKsSix1b/xjY0oHIm7W2bMDxnGqJOHB4FE3la98RadNe4W1i7iaCFMF
         I/VQ==
X-Gm-Message-State: AOAM531GoE++znFQaUDjliZp5CDkbHqHIjxyXe5hBqmTvT7zF/ErFa1m
        +j8uVaP+/Gla22Hz1wT8a+mk9Q==
X-Google-Smtp-Source: ABdhPJwPzIdMvHEDHkyaHbdp0KMiNY2Cz9nsTrlZaGHdjXktUUxNQX/MOZol9PHIS6SBRhKddr4cVw==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr14318503wmi.91.1610365582544;
        Mon, 11 Jan 2021 03:46:22 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z63sm22392997wme.8.2021.01.11.03.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:46:21 -0800 (PST)
Subject: Re: [PATCH 10/13] wcn36xx: Add GTK offload info to WoWLAN resume
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
 <20201228162839.369156-11-bryan.odonoghue@linaro.org>
 <874kjnlnl7.fsf@codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <88abab57-7ed7-392a-77cc-dc7cb3d6e4d7@linaro.org>
Date:   Mon, 11 Jan 2021 11:47:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <874kjnlnl7.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/01/2021 11:28, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> 
>> Having enabled GTK rekey in suspend, we need to extract the replay counter
>> from the firmware on resume and perform a ieee80211_gtk_rekey_notify() so
>> that the STA remains verified from the perspective of the AP.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/net/wireless/ath/wcn36xx/hal.h  |  4 +-
>>   drivers/net/wireless/ath/wcn36xx/main.c |  5 +-
>>   drivers/net/wireless/ath/wcn36xx/smd.c  | 72 +++++++++++++++++++++++++
>>   drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
>>   4 files changed, 81 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
>> index 1f3c2e840232..455143c4164e 100644
>> --- a/drivers/net/wireless/ath/wcn36xx/hal.h
>> +++ b/drivers/net/wireless/ath/wcn36xx/hal.h
>> @@ -4919,7 +4919,7 @@ struct wcn36xx_hal_gtk_offload_rsp_msg {
>>   struct wcn36xx_hal_gtk_offload_get_info_req_msg {
>>   	struct wcn36xx_hal_msg_header header;
>>   	u8 bss_index;
>> -};
>> +} __packed;
>>   
>>   struct wcn36xx_hal_gtk_offload_get_info_rsp_msg {
>>   	struct wcn36xx_hal_msg_header header;
>> @@ -4943,7 +4943,7 @@ struct wcn36xx_hal_gtk_offload_get_info_rsp_msg {
>>   	u32 igtk_rekey_count;
>>   
>>   	u8 bss_index;
>> -};
>> +} __packed;
> 
> Why __packed? Commit log mentions nothing about that.
> 

Because the __u8 at the end aligns to 4 bytes.

I'll add this to the log desc
