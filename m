Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8236AE38C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 16:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCGPAM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 10:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCGO7p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 09:59:45 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333F4AFC6
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 06:43:51 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m25-20020a05683026d900b006941a2838caso7261427otu.7
        for <linux-wireless@vger.kernel.org>; Tue, 07 Mar 2023 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678200230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fBeRSSqjdrNMlYLzhf9myf1h0M15v7Y4qn25Y5LdwSA=;
        b=NaLfd0CWVuYqW9QCm7uYsZD3DV2VqN3cnRluy7y6zeMMu9nJpx9/gsLprsdo9ZH7wl
         GY3z3HhxydQzY9WEOqQvpIzIONERRB4iy4jyAxGbUKnTKgVczV3lOmFQfoVyTqKry4tH
         r+Q8SmZ0CaljJs+84FZiQGJvhna79FT/WkkjyhLO2MfNakuxCKWrN3UV6lt8CYv3zL/J
         fhtn9idxLhujMFRqeAD472aI4BpVYZCnmk0ntYtBJACRlOASAV+5Fw+Zvak4p8JeaVAa
         aTVlGf1JD5MgksgyaEIVk56lcQ3yNF7qbVV7Ox2uG+at3UyHt+IukIi85idLvmJZeXF+
         GMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBeRSSqjdrNMlYLzhf9myf1h0M15v7Y4qn25Y5LdwSA=;
        b=Bl4EUldOFO7vkn5gTi69z6D9G/mZSkjawxgOlOha2e+H8ptBEOYP/OqjSnqNOBpJUe
         gHO3cpKeb84gk7NlB3MscaanOaSjQ36FTpydoM12vUbzbgcRWQfk0GOx/LkWFYqTEqz2
         urVTv9j09ZYZ5Z52PCY1WgQMU2GytIENsGVsQaX5hCN/pv7G51esMEy6ZGz4SUBUasQb
         TtVef/MlZAddb5N529qP68teoyPclNzBd8s3lcd9oQCQNJMVZrhD7YTqgaWBD2gWsMmt
         WBLbb6/7pLMAjd2pRw7oh8+wWx5D62LDZBs3yC+yRUC6VrsO3iEKDl0qyoNHSNyoeWCA
         rWNQ==
X-Gm-Message-State: AO0yUKUa+51EcVhJoj9L3tA8zYSt97SnyIp2kvuPo6tScwfZpaNiDtSI
        1gbYVIRbbQxB6nypmMsUcbK1w9s5L9s=
X-Google-Smtp-Source: AK7set8kbcYPjjQk0DRmalvvRrGL7TGNXjYLEFPU/YQynXqtrixp18M9l/y8nuxfXWGkIkmzg0ic0g==
X-Received: by 2002:a9d:610:0:b0:694:359e:b9c8 with SMTP id 16-20020a9d0610000000b00694359eb9c8mr6388196otn.22.1678200230634;
        Tue, 07 Mar 2023 06:43:50 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q24-20020a05683031b800b0068bc48c61a5sm5368025ots.19.2023.03.07.06.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:43:49 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <2064a549-ef7a-98bf-cc24-a25b8571877f@lwfinger.net>
Date:   Tue, 7 Mar 2023 08:43:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Performance of rtw88_8822bu
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
 <20230306091845.GC27249@pengutronix.de>
 <20230306125944.GD27249@pengutronix.de>
 <6ed1239f8c404dcb9d571771c230b69b@realtek.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <6ed1239f8c404dcb9d571771c230b69b@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/6/23 19:39, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>> Sent: Monday, March 6, 2023 9:00 PM
>> To: Larry Finger <Larry.Finger@lwfinger.net>
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; linux-wireless <linux-wireless@vger.kernel.org>
>> Subject: Re: Performance of rtw88_8822bu
>>
>> On Mon, Mar 06, 2023 at 10:18:45AM +0100, Sascha Hauer wrote:
>>> Hi Larry,
>>>
>>> On Sat, Mar 04, 2023 at 08:52:26PM -0600, Larry Finger wrote:
>>>> Sascha an Ping-Ke,
>>>>
>>>> I have been testing the RTW8822BU driver found in my rtw88 GitHub repo. This
>>>> code matches the code found in wireless-next. I created 9 files of 5.8 GiB
>>>> each and used a for loop to copy them from the test computer to/from my
>>>> server. The wireless connection is on the 5 GHz band (channel 153) connected
>>>> to an ax1500 Wifi 6 router, which in turn is connected to the server via a
>>>> 1G ethernet cable. The connection has not crashed, but I see strange
>>>> behavior.
>>>
>>> What chipset are you using? Is it a RTL8822bu or some other chipset
>>> reported by the driver?
>>>
>>>>
>>>> With both TX and RX, the rate is high at 13.5 MiB/s for RX and 11.1 MiB/s
>>>> for TX for about 1/3 of the time, but then the driver reports "timed out to
>>>> flush queue 3" and the rate drops to 3-5 MiB/s for RX and 2-3 MiB/s for TX.
>>>> These low rates are in effect for 2/3 of the time. The 5G bands are
>>>> relatively unused in my house, thus I do not suspect interference.
>>>
>>> I've received a very similar report this weekend. About 3-4 messages per
>>> second, "timed out to flush queue 3", but driver continues to work.
>>> I've also seen it this morning by accident and once again while writing
>>> this mail. This was on a RTL8821CU.
>>>
>>> So far I have no idea what the problem might be.
>>
>> The "timed out to flush queue %d\n" message comes from
>> __rtw_mac_flush_prio_queue(). Here some registers are read which show
>> the number of reserved pages for a queue and the number of available
>> pages of a queue. I used the debugfs interface to observe these
>> registers from time to time:
>>
>> f=$(echo /sys/kernel/debug/ieee80211/phy*/rtw88/read_reg); for i in 0x230 0x234 0x238 0x23c; do echo "$i
>> 4" > $f; cat $f; done
>>
>> This is what they show:
>>
>> reg 0x230: 0x00230040
>> reg 0x234: 0x00400040
>> reg 0x238: 0x00400040
>> reg 0x23c: 0x00000000
>>
>> The upper 16bit contain the number of available pages and the lower
>> 16bit contain the number of reserved pages (Note these are the registers
>> on a RTL8822CU, on other chipsets the number of available pages is
>> lower, like 0x10 on RTL8821CU). Register 0x230 is the interesting one
>> for us, it has the values for queue 3.
>>
>> What I can see is that for the other queues the number of reserved pages
>> usually matches the number of available pages. It happens sometimes that
>> the number of available pages goes down to 0x3f, but with the next
>> register read it goes back to 0x40. For 0x230 this is different though.
>> Here the number of available pages continuously decreases over time and
>> never goes back up.
>>
>> I don't know what this is trying to tell me. It seems that things queued
>> to queue RTW_DMA_MAPPING_HIGH are sometimes (always?) stuck.
>> Unfortunately I also don't know how the different priority queues relate
>> to the different USB endpoints and how these in turn go together with
>> the qsel settings. Maybe Ping-Ke can shed some light on this.
>>
> 
> To quickly check if RTW_DMA_MAPPING_HIGH get stuck, changing qsel_to_ep[]
> to different priority queue would be helpful to identify the problem.
> If only this queue works not well, we may dig MAC settings. Otherwise,
> it may be a RF performance problem.
> 
> 0x240 is another queue called public queue. If 0x230/0x234/0x238/0x23c
> become full, packets are queued into this queue. From view of MAC circuit,
> it fetches these queues in specific order (from high to low conceptually;
> I'm 100% sure.), and apply EDCA contention parameters for internal and
> external contention.
> 
> I don't have much useful ideas to this problem for now.

Ping-Ke and Sasha,

I made a discovery this morning. I set up a transfer from my NFS server to the 
computer over an rtw8822bu link using rsync with the --progress option. In a 
second window, I ran Sasha's register dump in a loop using a 5 second delay 
between readouts. A third window showed was running 'dmesg -w'.

The transfer ran to completion on a 5.8 GiB file with all incremental speeds 
reported as 11-12 MB/s. No timeouts on flushing the queue were logged, until I 
opened the NetworkManager applet! At that point, I got many queue timeouts 
logged, and the instantaneous throughput dropped to 2-3 MB/s as I reported 
earlier. Surprisingly, there were no changes in the registers when the errors 
happened.

The NM applet is going to be reading the transfer rate from the device, which 
apparently messes up the data flow to/from the device.

As long as I do not cause the NM applet to display the connections, I get 
nothing logged.

Larry


