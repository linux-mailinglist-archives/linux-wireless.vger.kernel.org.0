Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C065EC879
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKAS3Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 14:29:24 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41847 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKAS3Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 14:29:24 -0400
Received: by mail-oi1-f179.google.com with SMTP id e9so5059749oif.8
        for <linux-wireless@vger.kernel.org>; Fri, 01 Nov 2019 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xawj13KIKFKMerCJ+/cuGELNxxmya+EW4C9ud6IbweM=;
        b=FbQ0+fsMYYOuU6Z0a6kYxOwupY4wfSD9mavR3x5+5OCAGBLYKrWKLVPEVSyw8qiHq0
         jHl/AqHp/MptvV9Rckx5Jo8+/iSqq9g3pL1c1Zip3VqvyGULzRR/s8Hh8PjhNUvNBrBN
         gyFFVhNHlcwvvOfJ1m+anZw7eRb8LCzCnyMSkb9DmCWpz0WLgnMwbTZ2WB7F2bKkDIV/
         m7p6grqMSVJokE5R1Yui9wbe/rcHB8xFopvo04MIOW49TSuoZhRSlKWTGpUjtOemIo3n
         bwfF+v7Q+D2g0Ws5PcIRkqCWlPA7ApSWGBNY2Lz4dhMSCj1YEi7pBTMkLNfz1BZkSRaB
         jxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xawj13KIKFKMerCJ+/cuGELNxxmya+EW4C9ud6IbweM=;
        b=hxXAQth1mmyBCCTXPzdn4DhIIOwoK5MF579JGzGSExKToSznRXn1aFhBvBPWpZhpaH
         eHcmAGtcaPLNSIyVLOdWzVoVUOuegC1Ui5vpi7YsaKHV9MnSk4v5lxlwxgRVw+vQpjzG
         7/gPiXTLtjA4FtR70PmHg+cRt/SU852t0auNLvEr3FF/lXi98iDYkFX+Wl7tNG7o42uq
         LBnpmgBgfliSdYgCxRfRvsxZ8uL24OPlEMw1paY41Wr8YAXWSLBWRX9EuyEpKkh+jx4B
         E6j3Xctzk7LaG12PDLHoIggNkbUz3s+1JzvMhuad/lEdNPM88ngfmXczY1gjQ+ZBbfFx
         cX1w==
X-Gm-Message-State: APjAAAWdOoYgZ4LE6OPdDcSNKVNi5oHysD5GMzplHkKqRdXfpLpaJCjE
        p8diIkuTFJKwiiLz/AAlGad3Yu53J5of0PjYDiU=
X-Google-Smtp-Source: APXvYqygsTOoW7wosXBWxbhW/hMcqRBkVD+eqZQPjkUxYDPJ0drFAw5j6H3vPmjHvmgc3pEnCMFntiJYO5pVYwQBjjo=
X-Received: by 2002:aca:39d5:: with SMTP id g204mr2016146oia.50.1572632962144;
 Fri, 01 Nov 2019 11:29:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7511:0:0:0:0:0 with HTTP; Fri, 1 Nov 2019 11:29:21 -0700 (PDT)
In-Reply-To: <bb62015e-d097-f54c-56ce-000d0b18a5ac@candelatech.com>
References: <CAKR_QVJ2eHrESLOEqiKxbjr0SoZh3oJydtgcebBOXSpspbquWA@mail.gmail.com>
 <bb62015e-d097-f54c-56ce-000d0b18a5ac@candelatech.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Fri, 1 Nov 2019 19:29:21 +0100
Message-ID: <CAKR_QVK8EUnL-dUt9K-1H6Ah7=ZTxs=Eq=gwvk5R_zeEQX0eeQ@mail.gmail.com>
Subject: Re: [RFC] ath10k: interface combination with monitor
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tried this fw: https://www.candelatech.com/downloads/firmware-2-ct-full-community-21.bin
Used ath10k driver as there is no ct driver for 5.4 yet.

Same as with QCA firmware

On 01/11/2019, Ben Greear <greearb@candelatech.com> wrote:
> On 11/1/19 10:03 AM, Tom Psyborg wrote:
>> Hi
>>
>> Is there a way to run monitor mode interface independent on STA/AP
>> interface presence or their state?
>> I am using airodump-ng/airmon-ng and I've noticed that while mon
>> interface is brought up airodump-ng is unable to find any beacons
>> unless sta interface is brought down. That is with QCA9880 devices,
>> while with QCA9377 airodump-ng only finds beacons if the sta interface
>> is associated to an AP.
>> Does this need firmware change to work or driver changes are sufficient?
>>
>
> I would expect it to work.  Have you tried -ct firmware on 9880 in this
> manner?
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>
