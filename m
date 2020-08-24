Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3424FA7A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgHXJ4i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgHXJ4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 05:56:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F75C061573
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 02:56:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r15so7985993wrp.13
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NUyYs+yT6DMLv1Wfu0LNRH+QPv/EaW4t1A1ZYkB7MVA=;
        b=K0SqdOU1Shs7CqSFziqBkb0io+ojMrYkRRVnI3PTIOLpVS5sP/hq3eC2ctlNtGE3nM
         hu1ikyNUYMKMr0eQIAaALueYSvIgnmPo4Zju3mBjnga2hyFbTJQgYb+KNY1BQwucSbCs
         kmiGZfhIpcBUca9m3W8FVqFD3Nkw84Qfyiv9wi0jv9vcN67t1IUrkZCJa1mtbusSJPnF
         jFyeNnH4klJmAQCAHOvVs8ToTXekaSVJVziWFQX94hGkns0DrCZnxvO1SoEZauH50j5i
         nPSFDaLoNhzXSWmU1r85pVQsOBsGte9pBRQEEqSDle4uNfqGJ5icoATowCeC/3rup8tT
         v12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUyYs+yT6DMLv1Wfu0LNRH+QPv/EaW4t1A1ZYkB7MVA=;
        b=NBJZOZNqm82M+y/n1bh1epEDkAuVc/bnLl+EqjaTfzJbMhGUszeRNrS3OvgHOwe30L
         2R8FtKqhpDWlsLTTX5E+sfyMYvBGWHJ696J5s5yDKSHSme5BPsAoQC2vKxFA8ZirXwxm
         a53ZNjQabhO2V6Rnq8VuRU96bwbp6OVv1tZIIYNc/WS2R8VE7HC1wJIxztLUdWiNxMB1
         VgcMPXmsvGSuepYbIYg7qziHj//clrW4vw3CHi9hA/tSs5oVIKHfeCCNTl/nuTwq5xYg
         oQG/LoR7ZvwMO0jbLsParrsRUSkku9QPM9Ddu2f1OjiJ47IZUfviaT0SD75eKM30BtqY
         cSAA==
X-Gm-Message-State: AOAM532ZDuKP3H2/IIyHrFi7rFEsE0tzPBgxmoobbCYp7c1rl2p02mFU
        Ezrdh+xVIfGsdu0/MH4VDOiplV1s2lRA09TN
X-Google-Smtp-Source: ABdhPJyPduK4LB4GT1+1/7pTUI7drZichQw2LEWeOKiMvA2Lempn8DPBeLqUF/vMn9GnnV4tYKZ6jA==
X-Received: by 2002:adf:d092:: with SMTP id y18mr4843523wrh.145.1598262989825;
        Mon, 24 Aug 2020 02:56:29 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p11sm11836029wrw.23.2020.08.24.02.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:56:29 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
 <db8adbab-bf1a-0552-0dce-af4acee9719e@linaro.org>
 <CAMZdPi8KRJ3Jb129xAqR8fnfc7tKaVvLZH00DF_z+Vx+wOD3Ow@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <5fc88e36-385c-68eb-091f-f53edac7ca29@linaro.org>
Date:   Mon, 24 Aug 2020 10:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi8KRJ3Jb129xAqR8fnfc7tKaVvLZH00DF_z+Vx+wOD3Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 24/08/2020 08:51, Loic Poulain wrote:
> Hi Bryan,
> 
> On Mon, 24 Aug 2020 at 03:45, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 17/08/2020 17:01, Loic Poulain wrote:
>>> For software-driven scan, rely on mac80211 software scan instead
>>> of internal driver implementation. The internal implementation
>>> cause connection trouble since it keep the antenna busy during
>>> the entire scan duration, moreover it's only a passive scanning
>>> (no probe request). Therefore, let mac80211 manages sw scan.
>>>
>>> Note: we fallback to software scan if firmware does not report
>>> scan offload support or if we need to scan the 5Ghz band (currently
>>> not supported by the offload scan...).
>>>
>>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>
>> OK.
>>
>> TL;DR included diff fixes the performance issue.
>>
>> I've poked about with the old scan, and this new scan and I've managed
>> to find to find where the new scan is killing performance.
>>
>> Please see below.
>>
>> @@ -792,6 +792,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
>>    {
>>           struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
>>           struct wcn36xx_hal_finish_scan_req_msg msg_body;
>> +       u8 oper_channel;
>>           int ret;
>>
>>           mutex_lock(&wcn->hal_mutex);
>> @@ -802,7 +803,9 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
>>                   /* Notify BSSID with null data packet */
>>                   msg_body.notify = 1;
>>                   msg_body.frame_type = 2;
>> -               msg_body.oper_channel = channel;
>> +               oper_channel = WCN36XX_HW_CHANNEL(wcn);
>> +               if (oper_channel != channel)
>> +                       msg_body.oper_channel = channel;
> 
> Is this condition ever satisfied? I mean, finish_scan is normally always
> called with operating-channel as channel parameter.

I had a debug statement and never saw it run, so I think no is probably 
the answer to that.

Basically though the msg_body.oper_channel needs to be left at zero. 
Whatever the firmware does with non-zero is not correct @ 80Mhz/5ghz


>> 2. Performance is as expected
>>      I see throughput oscillate between 30 mbit and 100 mbit
>>      - Android runs a scan every 15 seconds
> 
> With scanning app in the foreground, right?
> While connected to an AP, Android 'should' only background scan if
> RSSI becomes too low (for roaming).

Foreground scanning yes, I'm forcing a constant interleaving.
