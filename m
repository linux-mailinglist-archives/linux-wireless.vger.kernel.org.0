Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15713B01A3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFVKpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVKpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 06:45:18 -0400
X-Greylist: delayed 144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Jun 2021 03:43:02 PDT
Received: from mail.as201155.net (mail.as201155.net [IPv6:2a05:a1c0:f001::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1BC061574
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 03:43:02 -0700 (PDT)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:33158 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1lvdpY-0008O0-0v; Tue, 22 Jun 2021 12:40:32 +0200
X-CTCH-RefID: str=0001.0A782F1A.60D1BE20.005B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID; bh=K6MK0aDhuaw1B1wUsJ1mmkUEPm11a5nEG6tFJiFq8/o=;
        b=fJg+Lnit/jUTSmJTIttmnsjsE2xRAUGA2ale8xtSyrpayat9pdOJqxsCkHkEiXpiY9DqNCKByjT7wUPh0L3a864Xc2Yj7iMdRSvbH5qW04PsuJwulyPhLx4UmLyIA0uKc1tTe2ZvW73/SUq+FhirHe4/gofay4/lQ+80NQsDUpg=;
Message-ID: <b98ffbe2-7995-9783-c74f-af1b5f32f575@dd-wrt.com>
Date:   Tue, 22 Jun 2021 12:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Petrosilius <petrosilius@posteo.de>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>,
        linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [81.201.155.134] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1lvdpY-000DSY-0M; Tue, 22 Jun 2021 12:40:32 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

just some cents from me. i modified the algorithm a long time ago since 
the dynack way ath9k was going was not correct.
i will look if it can make a patch out of my experiences, but dont 
expect it within the next 2 days.

Am 22.06.2021 um 12:12 schrieb Petrosilius:
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
>
>
