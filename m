Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93485162101
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 07:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgBRGh4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Feb 2020 01:37:56 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42000 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgBRGh4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Feb 2020 01:37:56 -0500
Received: by mail-ed1-f45.google.com with SMTP id e10so23501183edv.9
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2020 22:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WefOljf8fdhmjWPE5xhjjCetqPi5nsbB6AvHzk0HJ3g=;
        b=milyCRdePcZEV76StfhQxZv1SbR0Ww9badKvRcFCd0+FJEm9oZCLy97bqi/fVapN7q
         C5N8iatUtbzCVRDNk/0bGzngNS1eWXOugNnzwqSpwJ2bFAhnBW2oiwzmZDFWUmlltZSO
         T6UZpx5bmPWJr0hbyQTq1F8P/3qjwL2uQMDwNLeznwmfwPaVa/WZZGrokxCrz1t5NqpV
         zbfIU0Lsn4VDV0LH/JH5MV+TEWWHMcKk4HWFFun33IDvx6iUeBq0RBfxQ2ySPeeXXjtr
         lxXjD5kdu4IJOb/cY6p5IvDBZOtl+Fr/fEVaSGUWtWh68RT7Vdr2yCEVWL9dLr7MiZvb
         qlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WefOljf8fdhmjWPE5xhjjCetqPi5nsbB6AvHzk0HJ3g=;
        b=t581umJ4//i+Myhmpu0nbf9asgRsxm61o3opm8Ryy+XUC+SQtYrC1NN7CFI+scRnjA
         Ec1ozk2Axhi2zwTJL/aLhmB1QNamI56wZ4nClDVwv9JUGOkzomu7B77+20fjmWOZ6GE9
         Z3fW2y7KBQvttJ3G7yhWMJDiNsynU/nH7Tu05ZmzU1LUqJFCA3h6tsGBdVRsyXlkCOak
         NdYfsYYaFZ8cwRlWObHe6VVd2HC8ueOJ1dzwUXw0wk/zSGYanGDbgbh1+eG8xhZebSVV
         o7wdvjjoHTL99bCFTcE1BUsOBmGHSjtSDPcKbAK3zVGXlycvEVisITNu1U7h0P7sXd4s
         AkFg==
X-Gm-Message-State: APjAAAUhayROpToWE0CX6Y+qjqsE4B/7lyScXDJ8niFr40nkjkinHzia
        joikfoFeFmnFParnLNCBUmL3FRwZrZQJnCq2Dbo=
X-Google-Smtp-Source: APXvYqzoTQoAxeXWAJlgpBBzqpoJGTz4kgwTP7iOZv+FJnkh+V75pB+m7sIHaMLuXtf5bQt1b9HzU4KEmfCFtK8sDxo=
X-Received: by 2002:a50:ab5b:: with SMTP id t27mr17383922edc.229.1582007872419;
 Mon, 17 Feb 2020 22:37:52 -0800 (PST)
MIME-Version: 1.0
References: <CAA=hcWTDqhJEE7MXFY9rvN93nf8=nWvshLoXKF3EMXYGLmZGbA@mail.gmail.com>
In-Reply-To: <CAA=hcWTDqhJEE7MXFY9rvN93nf8=nWvshLoXKF3EMXYGLmZGbA@mail.gmail.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Tue, 18 Feb 2020 07:37:41 +0100
Message-ID: <CAAfyv34yO7bSR9GBod1bXpD0sFnsSETsJQAzcmSgyY0orGtfcg@mail.gmail.com>
Subject: Re: [yocto] Change RO rootfs failed RF Kill Switch Status and Failed
 to start Run pending postinsts
To:     JH <jupiter.hce@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Yocto discussion list <yocto@yoctoproject.org>,
        Patches and discussions about the oe-core layer 
        <openembedded-core@lists.openembedded.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Feb 18, 2020 at 2:00 AM JH <jupiter.hce@gmail.com> wrote:
>
> Hi,
>
> Apologize for the cross posting.
>
> I am running kernel 4.19.75 on iMX6 customized device with WiFi and 4G
> LTE, it was running well in an RW rootfs. After I have just changed
> rootfs to RO UBIFS partition, it failed RF Kill and postinsts I
> suspect both try write to the RO and failed, any advice how to fix it?
> Despite it failed RF Kill and postinsts, it was still working.
>
> [    6.097762] UBIFS (ubi0:2): UBIFS: mounted UBI device 0, volume 2,
> name "rootfs-volume", R/O mode
> ..............
> [    6.151932] VFS: Mounted root (ubifs filesystem) readonly on device 0:13.
> .................
> [  OK  ] Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
>          Starting Load/Save RF Kill Switch Status...
> [FAILED] Failed to start Load/Save RF Kill Switch Status.
> See 'systemctl status systemd-rfkill.service' for details.
Can you pls provide output of systemctl status systemd-rfkill
There should be some more info what issue is.
>
> [FAILED] Failed to start Run pending postinsts.
> See 'systemctl status run-postinsts.service' for details.
Pls this one also: systemctl status run-postinsts
> ...............
> root#
>
> Thank you.
>
> Kind regards,
>
> - jh
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
>
> View/Reply Online (#48463): https://lists.yoctoproject.org/g/yocto/message/48463
> Mute This Topic: https://lists.yoctoproject.org/mt/71363457/900721
> Group Owner: yocto+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto/unsub  [marek.belisko@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-

BR,

marek
