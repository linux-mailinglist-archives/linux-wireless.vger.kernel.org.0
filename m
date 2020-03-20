Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAD518C8DC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCTISp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 04:18:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53129 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgCTISo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 04:18:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so5502991wmo.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2020 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jMdZS8t0gIMnGa6oVB9bq1XLXhKvkHcxFNcv46iMLs=;
        b=T/VI5H5PlFB6Y/PcOqdPuuOEIlZOYq9nOtfa+jENhMAjM0uR/GtkBu99C35SWxCcWz
         WDElQlGskP5KuwNOU9q0YHe4XIY7lR+C1p6IpiF0ExG/Qf8qkSC2J1ZylnpRkfJuFlQD
         +YbiNlW9SJ0yzz8Gv0QdpW/S4EQjZE/GreZcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jMdZS8t0gIMnGa6oVB9bq1XLXhKvkHcxFNcv46iMLs=;
        b=KHS47tAgz6dQOeB8m3Img0Y589IZrKicbbZktXPs8aM0DfK1MeIZRAZo0xlGRNcrWr
         1t0obf6y+lDKtNe4ythseEWL8eXHcD9xFqS/rc1I7dUpHCoPMbNCZ0rsYSN+ydFexWdX
         1bEGAIWXNEE6LqZUqpUXxji1kE8drY/8PSYgx0rynOuAB4tGSTtuR25I5XBcFcNB+P3b
         7sn/J3fvCUQxaspdgt7Cur7BDmT25RO+AYeidNHvrUPpPRiy9mcaH9/5mviRUto2Jsro
         wmqbGphwY/HSnVU4Ku/6i815tj9kslWc3uWdLgdqGgAMFjTFxYX6YaT9FfPoMJGdfdt1
         PISw==
X-Gm-Message-State: ANhLgQ3CU//x97kctUjjCoHnrhWC4foFp3AZ9G6+LrkXvGiRcAVM5IIO
        Na0tSv8WFXOTvixGITdAmvhyMQ==
X-Google-Smtp-Source: ADFU+vuSXfgyZJmrDFq9vhXuMKetXIHiEuyfiBpJdOPSDMZFvtP4EGOZvL9zeydEY4f2wym438hFXw==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr8951689wmj.170.1584692322172;
        Fri, 20 Mar 2020 01:18:42 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id f14sm6036758wmb.3.2020.03.20.01.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 01:18:41 -0700 (PDT)
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
To:     Wright Feng <wright.feng@cypress.com>, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, tj@kernel.org
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <d220ae51-9613-5b0a-2006-e9250603fd42@broadcom.com>
Date:   Fri, 20 Mar 2020 09:18:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/20/2020 9:08 AM, Wright Feng wrote:
> 
> 
> Arend Van Spriel 於 3/19/2020 4:55 PM 寫道:
>> + Tejun - regarding alloc_workqueue usage
>>
>> On 3/19/2020 8:53 AM, Wright Feng wrote:
>>> With setting sdio_wq_highpri=1 in module parameters, tasks submitted to
>>> SDIO workqueue will put at the head of the queue and run immediately.
>>> This parameter is for getting higher TX/RX throughput with SDIO bus.
>>>
>>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>>> ---
>>>   .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  5 +++++
>>>   .../wireless/broadcom/brcm80211/brcmfmac/common.h  |  2 ++
>>>   .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 
>>> ++++++++++++++--------
>>>   3 files changed, 21 insertions(+), 8 deletions(-)
>>>
>>
>> [...]
>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> index 3a08252..885e8bd 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> @@ -4342,9 +4342,21 @@ struct brcmf_sdio *brcmf_sdio_probe(struct 
>>> brcmf_sdio_dev *sdiodev)
>>>       bus->txminmax = BRCMF_TXMINMAX;
>>>       bus->tx_seq = SDPCM_SEQ_WRAP - 1;
>>> +    /* attempt to attach to the dongle */
>>> +    if (!(brcmf_sdio_probe_attach(bus))) {
>>> +        brcmf_err("brcmf_sdio_probe_attach failed\n");
>>> +        goto fail;
>>> +    }
>>> +
>>>       /* single-threaded workqueue */
>>> -    wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
>>> -                     dev_name(&sdiodev->func1->dev));
>>> +    if (sdiodev->settings->sdio_wq_highpri) {
>>> +        wq = alloc_workqueue("brcmf_wq/%s",
>>> +                     WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND,
>>> +                     1, dev_name(&sdiodev->func1->dev));
>>
>> So two things changed, 1) WQ_HIGHPRI flag added *and* 2) use 
>> allow_workqueue basically dropping __WQ_ORDERED. Not sure which one 
>> contributes to the behavior described in the commit message.
> 
> The combination of Unbound and max_active==1 implies ordered, so I 
> suppose we don't need to set __WQ_ORDERED bit in flags.

My reason for asking was the idea to only determine flags in the 
if-statement and have following by one alloc_wq call, ie.:

wq_flags = WQ_MEM_RECLAIM;
if (sdio_wq_highpri)
	wq_flags |= WQ_HIGHPRI
wq = alloc_ordered_workqueue(..., wq_flags,...);

Regards,
Arend
