Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB8123A80
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 00:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfLQXIY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 18:08:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33478 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfLQXIY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 18:08:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id v140so72699oie.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 15:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fU5IHlx78AQs5QCUnGS43vSZRdjyN6MDI5BLWy9e78s=;
        b=rp30uwiN0NxTsRtfnsuPZkdrxSsBzYSQM4iNfbmE9Fk5A7lTTScwZGjmFwpe7+7Fge
         v3RPh947Tps4hksx9IEbjFasxD44Xj8SIYmaNPF/u98bkSkhLVHhL7o8wmCsX8qjNnRH
         RVRsx2bXfqF9U+8n+9OXc96gSdqEom4+2gFQwmu+aSEazmMw9dgsedNTzQfD3fztJUld
         0cOhrz3E8axbUz2cV+Npxf/+wN+v286asfRr9iI9SWswfwG/US6/1IrGBYFhM/65KMDr
         qT0qNs/CbHNyKFp74i5SqpRkm7CLPASpNsgRsA7cK1/IWdo2NItGM0FCXkY3+uc4zIeP
         cyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fU5IHlx78AQs5QCUnGS43vSZRdjyN6MDI5BLWy9e78s=;
        b=WrGj22qdB/XII9cWbLZMfCVC58UhRUS9GToeOqnipxrJS4W5SPsoTxstu2TyUQbI0n
         W8kEunTN8Ew36BQql/qqlUarDe1uChCxlXiWC4iFzoy5iM8gQtwFg45Oz5GtlEm4Blc0
         i6nSdltzft1vyq4UlC47BxukO/erISK31ZGqVrX8m+rZ9VV6mJiu+sx0cZvDu6ONOTNY
         mO0RKT/aRIoUPM6i7Y31sWSR0Noa8/xB56yLCVGlJ2U7pRyJDMhbt1p1Cq30yhAvWr/l
         c/lu+XuMVowmCohChfBNFXfjRRmvUoxJmguRwCjhVOWPeMPfNj4nT2mwm+nwGtUQFXH+
         p1JA==
X-Gm-Message-State: APjAAAUCU+wMjVb5+asrZvKNUdrwSyOJom+oRi9QHOE4gIfKUqJtAbTA
        nzjkmKIlJu23knjbxDoN0e3P8EKACfa8edR2rac=
X-Google-Smtp-Source: APXvYqz/5TUzQF3bB2ujv2tTjnjk/nkX0oTGW6C3drIZ2wY5CHd82F39wUUYz15X3krJ5ifVQAZPhVnJ/KF0hCN9LP4=
X-Received: by 2002:aca:180e:: with SMTP id h14mr2203423oih.24.1576624103312;
 Tue, 17 Dec 2019 15:08:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Tue, 17 Dec 2019 15:08:22 -0800 (PST)
In-Reply-To: <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com>
References: <20191216220747.887-1-greearb@candelatech.com> <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de> <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de> <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com> <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
 <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 18 Dec 2019 00:08:22 +0100
Message-ID: <CAKR_QVL0P4qYidtqLwhhacCOpx2iq+4RRhTXbGhfRnf2PUj5tA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Ben Greear <greearb@candelatech.com>
Cc:     Justin Capella <justincapella@gmail.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/12/2019, Ben Greear <greearb@candelatech.com> wrote:
> On 12/17/19 10:29 AM, Tom Psyborg wrote:
>> On 17/12/2019, Ben Greear <greearb@candelatech.com> wrote:
>>> On 12/17/19 8:23 AM, Justin Capella wrote:
>>>> I believe someone recently submitted a patch that defined noise floors
>>>> per band (2/5).
>>>
>>> I looked at using the real noise floor.  Our radio was reporting a noise
>>> floor of around -102,
>>> where the hard-coded default is -95.  This of course would make the
>>> reported
>>> RSSI lower by 7db
>>> in that case.  I am not sure that is correct.
>>>
>>
>> Hi
>>
>> I am getting similar NF values with all my ath10k devices, I thought
>> default was changed since ath9k from -95 to -115 just like in the
>> vendor driver? There were some discussions about it on mailing list.
>> On some channels (5Ghz) the value goes down to about -107, even saw
>> -110 once.
>>
>
> If you use ath9k and ath10k on same channel/environment, do you see similar
> RSSI reported (especially with the ath10k patch I just posted)?
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

Nope. RSSI values are quite different between two cards. Applying this
patch also made no difference on ath10k card, but this might be due to
the fact the network wasn't setup (so no data passed through) in order
to keep tx rx rates at 6 Mbps.

First I put AR9462 card in Archer C7 and connect to Litebeam5AC (CH36,VHT80)

commands output from archer:

iwinfo:

signal: -65dBm noise: -94dBm txpower: 14dBm

iw wlan1 station dump:

signal: -65 [-69, -67] dBm
signal avg: -65 [-68, -67] dBm

with the default 14dBm power the RSSI in Litebeam was -72dBm

Then I put QCA9880 in archer and connected to the same AP:

commands output from archer:

iwinfo:

signal: -58dBm noise: -102dBm txpower: 23dBm

iw wlan0 station dump:

signal: -59 [-65, -64, -62] dBm
signal avg: -58 [-65, -63, -62] dBm

RSSI of the card reported in Litebeam -63dBm (very inconsistent
between wifi restarts on archer, -65, -67 even -69 dBm, and no
software reboot would restore card's full power, only cold boot)

next I lowered the power of the card to 14dBm to match AR9462

iwinfo:

signal: -57 dBm noise: -101 dBm txpower: 14 dBm

iw wlan0 station dump

signal: -57 [-62, -62, -61] dBm
signal avg: -57 [-62, -62, -61] dBm

now the RSSI in litebeam dropped to approx. -75dBm
