Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67753B00D1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVJ46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 05:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJ46 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 05:56:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8566C061574
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 02:54:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gt18so33520961ejc.11
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=sSj2vekDbd3D/LMIPzyXUoP01DmgS/p6A/hWdCDNf30=;
        b=u95cQlLpdK4+brHuozMMhs+ZIPyK2h0s068CgziPoruvMWhAYBandklkPopzEDH68l
         z8CeC43D+bFBCvswNkHfFxgqSdaBgy/uYOPQIFFnNJrOW6g6Js5vrBfvark8U15VLQmF
         kqFj+jojVbSzMFEWubg8dAb+tQpywF5N2m8CmrGC8zkcmdpcsTQ0KHtQAkCUzFenauS9
         Z0mMv8muY6VSI8N/eXkF761KMREdS+HWzpAKk8RMaFiq+LmfRiLbehRVlNHUuzrpeG8o
         xsyVYo13PIRP7pEpI/ye9IviBPD0Q3m+KXmgyEnv8XuJo/PkocgPXGmvoaOFesLupoPq
         CFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sSj2vekDbd3D/LMIPzyXUoP01DmgS/p6A/hWdCDNf30=;
        b=Z2GzmPypJAxY2/TujYYttQtQYgIQto3SVR6Z9ukZeRgt1O1yGsB0BI1u0r0tArx+LK
         rYAOZ/h3kzuvwkggfCNAicnWinkxHjFEIFnRlxVR/wq8Xi0aVH6LqhCCx/hJW+Zz5aNB
         tJ0hdBxn0KC0MEYmM6o86L9z2hX5v/3o/1UJ+KHM2Z2g221l1aZ7duLMzPvb8+GZ0nSB
         +nCoiLedok8gppBx/rNAN65uK2Pf6nPO+83WdIPAllxJlp0RQz4NWLAmDCgjNEPZwbTz
         rx1nr8cR/zGhX/g8R1E5Gx3dFKkR6GOHs1EYdfaMMYOfyB986gWdg69IXvMkwCYEPOGh
         RJEw==
X-Gm-Message-State: AOAM533NuNfiz8Oc45ZoobUJvdzWeeVbZes4CwpTxluSd5vmxKNOdvVq
        yW6KYqca1YjE3mKm4jnL6ZQr6JTFj27k/imk
X-Google-Smtp-Source: ABdhPJyJLv60Fu75E4EktZAZzgznaY9Mkvg8S6FEJrdutv0DralYg/Cgmr3hmcEIpjVpmqD5DlXUnQ==
X-Received: by 2002:a17:906:af0f:: with SMTP id lx15mr3158474ejb.324.1624355680084;
        Tue, 22 Jun 2021 02:54:40 -0700 (PDT)
Received: from [192.168.5.225] (178-116-168-169.access.telenet.be. [178.116.168.169])
        by smtp.gmail.com with ESMTPSA id by23sm5751875ejc.85.2021.06.22.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 02:54:39 -0700 (PDT)
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Petrosilius <petrosilius@posteo.de>, linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Message-ID: <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
Date:   Tue, 22 Jun 2021 11:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 18.06.21 13:13, Petrosilius wrote:
> Hello Lorenzo Bianconi,
>
> we are running a set of R11e-2HPnD devices and having trouble getting
> dynack working properly.
> Setup:
> * linux-5.4.123
> * OpenWRT (current development branch) with wireless backports-5.10.34-1
> * distance 2m between ap and sta
> * Low ambient noise wifi environment
> We experienced some non working dynack or low performance in the
> connection due to too high calculated ackto's.
>
> Here is a ath9k debug output example for a non working dynack @ 10Mhz BW:
>
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500427] ath: phy0:
> {48:8f:5a:3c:bb:03} tx sample 44905341 [dur 8720][h 29-t 30]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500437] ath: phy0:
> ack_ts 44844835 st_ts 44905341 st_dur 8720 [17-29]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.500445] ath: phy0:
> ack_ts 44923425 st_ts 44905341 st_dur 8720 [18-29]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554642] ath: phy0: rx
> sample 44977693 [h 18-t 20]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554701] ath: phy0:
> {48:8f:5a:3c:bb:03} tx sample 44964984 [dur 6032][h 30-t 31]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554710] ath: phy0:
> ack_ts 44923425 st_ts 44964984 st_dur 6032 [18-30]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.554718] ath: phy0:
> ack_ts 44977693 st_ts 44964984 st_dur 6032 [19-30]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577890] ath: phy0: rx
> sample 45000939 [h 19-t 21]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577946] ath: phy0:
> {48:8f:5a:3c:bb:03} tx sample 44998471 [dur 912][h 31-t 32]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577956] ath: phy0:
> ack_ts 44977693 st_ts 44998471 st_dur 912 [19-31]
> Wed Jun  2 19:08:50 2021 kern.debug kernel: [  400.577964] ath: phy0:
> ack_ts 45000939 st_ts 44998471 st_dur 912 [20-31]
>
> THe above output is generated in dynack.c by
>
>          ath_dbg(ath9k_hw_common(ah), DYNACK,
>              "ack_ts %u st_ts %u st_dur %u [%u-%u]\n",
>              ack_ts, st_ts->tstamp, st_ts->dur,
>              da->ack_rbf.h_rb, da->st_rbf.h_rb);
>
> The ackto is afterwards calculated by
>
>          if (ack_ts > st_ts->tstamp + st_ts->dur) {
>              ackto = ack_ts - st_ts->tstamp - st_ts->dur;
>
> Filling in the values of the first sample:
>
> (ack_ts > st_ts->tstamp + st_ts->dur) ?
> (44844835 > 44905341+8720) ?
> (44844835 > 44914061) ? ... not given
>
> Therefore a new ackto is not calculated and i can also see that in the
> ack_to file:
>
> 600 A
> 600 A
> 600 A
> ...
>
> These look like the default values to me (and do not change), but
> ath_dynack_get_max_to() should return 750 A for our 10MHz BW case - this
> looks also suspecious to me.
>
> For 5 MHz bandwidth there is a ackto calculated (~382 A, looks a bit too
> high to me) but the performance is way below expectation (<1MBit)
> For 20 MHz bandwidth there is a ackto calculated (51 A) and the
> performance is fitting the expectation.
> If you want to take a look at the logs for each of these cases for ap
> and sta, you can download them here:
> https://cloud.hs-augsburg.de/s/eworxkJoL6JXYzZ
>
> Did anyone else experience such a behaviour on non 20MHz Channels or
> does anyone have an idea on where this behaviour might originate from?
> I am not experienced in the ath9k driver code, but a uneducated guess
> might be that the ring buffer where the dynack algorithm is taking its
> frame-samples from is not behaving as expected for the 5&10MHz case.
>
> regards,
> julian dorner

Are you stressing the link?
I'll try to simulate this later on

Regards,

Koen

