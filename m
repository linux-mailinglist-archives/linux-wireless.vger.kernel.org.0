Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133323B034B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFVLyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhFVLyY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 07:54:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B1C061574
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 04:52:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gt18so34046148ejc.11
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=rJ4wPDvtTgJMrdisnP4rPDokQ99jm91/9/4U5bX0CZQ=;
        b=r2IPtf8AIdfA7AgLDy7L3iQQvhCdguUT3nIEOsiC4L1YhCod/805KU6DSmJU9Xf+rd
         kHgvUBfq5obQKOgOtRBlOa5crfVfVV1vHhFeOZTsGYt4AmoVpv6fj+ZP6OIFBcnMn/LJ
         +3RDaB/aJDxnaQkOHbPxMZzeHOeON3/XMuWYtEdBLfibUm6lOA2fmrjzueW+BKJtDVJ3
         +3yJna32rCAAnxtg5FynAxKZ+vtYCws7SuHWxF58qpvnFPP1wZRXF54ff2rbTxeSjJ6n
         Yp9EFd03PfPDs7lW9bOVrtdHuB1D1Jo8EvWQuxRams+RilxDczkj4f83wjtjEPKX16OL
         PRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rJ4wPDvtTgJMrdisnP4rPDokQ99jm91/9/4U5bX0CZQ=;
        b=rMxkoXhSdtCLWRyex1jXf6W9A8KbXUpJ2ukFfQl5xAZjWoDZ6mi00/ITJem4UZllV7
         6mIdVvWY/d9W1nWjWDTvIrju2IIDedZvhczbLgus06n9QubwQB/TFdmwlg+bB9ymDoSX
         XErjifsaaXkFWiEFluFATPA+0DdWTVr3vdNVBrXGYn7J+onM8VoGrjjla1fpZuIVVzov
         9QfLVkBCp4x+0eXnM1CN43ZgDVqxrKMd3m5FDvFtFUa5kEYJ690aErTBRKhL48JXiQF9
         G9L8FtvtU7vm/7FNd9Q3cxHVvc1dlcT6iV5Ig7Hk2VKvVGL/z5aWBZ3ICWYBOwBF+O3T
         FZ3Q==
X-Gm-Message-State: AOAM533uu3g7Utlc4KUIN5vf07H8+FiUS5dvFpwUpzzxrK4bwVICTfXF
        Z1c60CL2yl8Z1KEuuaP9rUf3WVia9MMx9c6Y
X-Google-Smtp-Source: ABdhPJyS/2525R9ggnAbk1KERbmhNpmrHtAFMwl8e8OQ4j1tABpAfPVcR22Fxu9TEi3i5t8S2ccsvQ==
X-Received: by 2002:a17:906:c141:: with SMTP id dp1mr3707606ejc.87.1624362727212;
        Tue, 22 Jun 2021 04:52:07 -0700 (PDT)
Received: from [192.168.5.225] (178-116-168-169.access.telenet.be. [178.116.168.169])
        by smtp.gmail.com with ESMTPSA id cw10sm5950924ejb.62.2021.06.22.04.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 04:52:06 -0700 (PDT)
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Petrosilius <petrosilius@posteo.de>, linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Message-ID: <8a3718e1-e988-c24a-d94f-34ba0f5349f4@citymesh.com>
Date:   Tue, 22 Jun 2021 13:52:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 22.06.21 12:12, Petrosilius wrote:
> On 22.06.21 11:54, Koen Vandeputte wrote:
>> On 18.06.21 13:13, Petrosilius wrote:
>>> Hello Lorenzo Bianconi,
>>>
>>> we are running a set of R11e-2HPnD devices and having trouble getting
>>> dynack working properly.
>>> Setup:
>>> * linux-5.4.123
>>> * OpenWRT (current development branch) with wireless backports-5.10.34-1
>>> * distance 2m between ap and sta
>>> * Low ambient noise wifi environment
>>> We experienced some non working dynack or low performance in the
>>> connection due to too high calculated ackto's.
>>>
>>> Here is a ath9k debug output example for a non working dynack @ 10Mhz
>>> BW:
>>>
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500427] ath: phy0:
>>> {48:8f:5a:3c:bb:03} tx sample 44905341 [dur 8720][h 29-t 30]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500437] ath: phy0:
>>> ack_ts 44844835 st_ts 44905341 st_dur 8720 [17-29]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500445] ath: phy0:
>>> ack_ts 44923425 st_ts 44905341 st_dur 8720 [18-29]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554642] ath: phy0: rx
>>> sample 44977693 [h 18-t 20]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554701] ath: phy0:
>>> {48:8f:5a:3c:bb:03} tx sample 44964984 [dur 6032][h 30-t 31]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554710] ath: phy0:
>>> ack_ts 44923425 st_ts 44964984 st_dur 6032 [18-30]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554718] ath: phy0:
>>> ack_ts 44977693 st_ts 44964984 st_dur 6032 [19-30]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577890] ath: phy0: rx
>>> sample 45000939 [h 19-t 21]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577946] ath: phy0:
>>> {48:8f:5a:3c:bb:03} tx sample 44998471 [dur 912][h 31-t 32]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577956] ath: phy0:
>>> ack_ts 44977693 st_ts 44998471 st_dur 912 [19-31]
>>> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577964] ath: phy0:
>>> ack_ts 45000939 st_ts 44998471 st_dur 912 [20-31]
>>>
>>> THe above output is generated in dynack.c by
>>>
>>>           ath_dbg(ath9k_hw_common(ah), DYNACK,
>>>               "ack_ts %u st_ts %u st_dur %u [%u-%u]\n",
>>>               ack_ts, st_ts->tstamp, st_ts->dur,
>>>               da->ack_rbf.h_rb, da->st_rbf.h_rb);
>>>
>>> The ackto is afterwards calculated by
>>>
>>>           if (ack_ts > st_ts->tstamp + st_ts->dur) {
>>>               ackto = ack_ts - st_ts->tstamp - st_ts->dur;
>>>
>>> Filling in the values of the first sample:
>>>
>>> (ack_ts > st_ts->tstamp + st_ts->dur) ?
>>> (44844835 > 44905341+8720) ?
>>> (44844835 > 44914061) ? ... not given
>>>
>>> Therefore a new ackto is not calculated and i can also see that in the
>>> ack_to file:
>>>
>>> 600 A
>>> 600 A
>>> 600 A
>>> ...
>>>
>>> These look like the default values to me (and do not change), but
>>> ath_dynack_get_max_to() should return 750 A for our 10MHz BW case - this
>>> looks also suspecious to me.
>>>
>>> For 5 MHz bandwidth there is a ackto calculated (~382 A, looks a bit too
>>> high to me) but the performance is way below expectation (<1MBit)
>>> For 20 MHz bandwidth there is a ackto calculated (51 A) and the
>>> performance is fitting the expectation.
>>> If you want to take a look at the logs for each of these cases for ap
>>> and sta, you can download them here:
>>> https://cloud.hs-augsburg.de/s/eworxkJoL6JXYzZ
>>>
>>> Did anyone else experience such a behaviour on non 20MHz Channels or
>>> does anyone have an idea on where this behaviour might originate from?
>>> I am not experienced in the ath9k driver code, but a uneducated guess
>>> might be that the ring buffer where the dynack algorithm is taking its
>>> frame-samples from is not behaving as expected for the 5&10MHz case.
>>>
>>> regards,
>>> julian dorner
>> Are you stressing the link?
>> I'll try to simulate this later on
>>
>> Regards,
>>
>> Koen
>>
> Hi Koen,
>
> we didnt stress the link that much.
>
> There was only SSH from the ap to the sta running to get access to the sta.
>
> regards,
>
> Julian

Hi,

Please retry while sending data over the link (iperf or so) and let me 
know the results. :)

Thanks,

Koen

