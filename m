Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E424B1DF0B4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 22:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgEVUke (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbgEVUke (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 16:40:34 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17930C061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 13:40:34 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b28so4747753vsa.5
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KFIo3mDu4y6EiEk0hm8xiQGnnT3v4pdhAa/7YGqK9eU=;
        b=rbYBd5GtuQNEC2yGKIiRfTH2zhWC8mZOVi+F0MvGPRqCfnYx6IoR8lU7nEjq6qSL8g
         6dpzfjh8Sc4fXNRCj1ClnAx1cem3B4jeBqPj59sv5eqJfmmfZB0Pt6xr3NOtM72W14Ew
         FKYTfZIqVnq7gyX3UN0d6AifqiRWwa6vSPbRf8ZmY1qhaIM9kjPWzKQRxFHUhu0l7lJG
         CWUnhAaAZ15j8RYie9r9x7CiVpny9IyRoEgdlxndS3sXaXiZlAR4FKwXfmN2tqd7jvcE
         +v0z6wD2h8MFvnGJtAGV2mQOeyvdqr5kezWoH1ABnGFD13f1D2f021044ui7i9CNToU5
         DZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KFIo3mDu4y6EiEk0hm8xiQGnnT3v4pdhAa/7YGqK9eU=;
        b=p8KcYFc8fXmIR3Ps51a1khqjsSiSUPWH4CTgR76NZB8+FqqjGshTClV9KNJmJPXp8c
         KUvFpOsnysT4kAxKh0nBDmIDHA4kk0fmzvCX0FGpecykia/dFcuJa29Xzjhqt7FYV+qp
         xN06m42nbH2H7kP0Be0sFwUFpWCYHRKuhegur4xyNO+PBvnAvm1d775TGrn1YPTi/nOg
         tNPh8vZwEfGqc9WzM0Xsi8Y0Sp4TPVlQl479f9IldffrVJGCFOP41pRZJZKmaEHYeN+j
         T3JvbuzIYWQKcB4mJnngEXz94jiDXhtTv5wngjF8nPBxRjjrv66B7AuIamXg+PRXVu8F
         X7Xw==
X-Gm-Message-State: AOAM533uriTdpGLOl+4SjXmUbugnmAjOnTegjOIWttk8QmB1na9mht9i
        8DY605TfCQ7JJCF7dvm95Zm1dvePfZXnGw3sf/CCB24Fvq47
X-Google-Smtp-Source: ABdhPJwOWAaYQ1ZHK6q1Pk8wdt9Jg9DJZyl7FRKh8ua8dLxz6x4lO4cscPtDRcZHRVAZe5Ym2gisJH4AvyApizOLXX8=
X-Received: by 2002:a67:f64a:: with SMTP id u10mr12511885vso.202.1590180033253;
 Fri, 22 May 2020 13:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net> <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net> <20200522121910.254aefc1@wiggum>
 <87a720gpfb.fsf@tynnyri.adurom.net> <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
 <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net>
In-Reply-To: <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 22 May 2020 21:40:22 +0100
Message-ID: <CALjTZvZV4kwLgoTijxsC2AYcxGeT1R_fsTdh3Gb=M03Rn_RsAg@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 22 May 2020 at 19:02, Larry Finger <Larry.Finger@lwfinger.net> wrot=
e:
>
> Rui,
>
> Does this one-line
> patch work for WPA3 without setting the nohwcrypt option?

Ok, so it "works", but I don't know what actually happened (I didn't
do any performance testing yet). I got this relevant output on my
kmsg=E2=80=A6

rui@mcnugget:~$ dmesg | awk '(/80211/ || /b43/ || /wlan0/)'
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinux-5.7.0-rc6+
root=3DUUID=3D849bbef3-007e-491e-b187-9e259680c2e2 ro mitigations=3Doff
b43.qos=3D0 b43.verbose=3D3 usbhid.mousepoll=3D16 quiet splash
[    0.035705] b43-pci-bridge 0001:10:12.0: enabling device (0004 -> 0006)
[    0.210299] b43-pci-bridge 0001:10:12.0: Sonics Silicon Backplane
found on PCI device 0001:10:12.0
[    3.361908] b43-phy0: Broadcom 4318 WLAN found (core revision 9)
[    3.454235] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
[    3.454259] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision
8, Version 0
[    3.485125] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht=
'
[   28.697945] b43-phy0: Loading firmware version 666.2 (2011-02-23 01:15:0=
7)
[   28.730381] b43-phy0 debug: Chip initialized
[   28.731389] b43-phy0 debug: 32-bit DMA initialized
[   28.731400] b43-phy0 debug: QoS disabled
[   28.792272] b43-phy0 debug: Wireless interface started
[   28.820318] b43-phy0 debug: Adding Interface type 2
[   33.944771] wlan0: authenticate with 04:f0:21:24:28:44
[   33.970449] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
[   34.026222] wlan0: authenticate with 04:f0:21:24:28:44
[   34.026241] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
[   34.028522] wlan0: authenticated
[   34.043256] wlan0: associate with 04:f0:21:24:28:44 (try 1/3)
[   34.046946] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=3D0x431
status=3D30 aid=3D1)
[   34.046964] wlan0: 04:f0:21:24:28:44 rejected association
temporarily; comeback duration 1000 TU (1024 ms)
[   35.122051] wlan0: associate with 04:f0:21:24:28:44 (try 2/3)
[   35.125547] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=3D0x431
status=3D0 aid=3D1)
[   35.125808] wlan0: associated
[   35.268256] b43-phy0 debug: Using hardware based encryption for
keyidx: 0, mac: 04:f0:21:24:28:44
[   35.268762] b43-phy0 debug: Using hardware based encryption for
keyidx: 2, mac: ff:ff:ff:ff:ff:ff
[   35.358586] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hardware =
(-22)
[   35.358977] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   87.283220] wlan0: failed to set key (4, ff:ff:ff:ff:ff:ff) to hardware =
(-22)
[   87.283521] b43-phy0 debug: Using hardware based encryption for
keyidx: 1, mac: ff:ff:ff:ff:ff:ff
rui@mcnugget:~$

Meanwhile, iw list shows all the possible software cyphers:

    Supported Ciphers:
        * WEP40 (00-0f-ac:1)
        * WEP104 (00-0f-ac:5)
        * TKIP (00-0f-ac:2)
        * CCMP-128 (00-0f-ac:4)
        * CCMP-256 (00-0f-ac:10)
        * GCMP-128 (00-0f-ac:8)
        * GCMP-256 (00-0f-ac:9)
        * CMAC (00-0f-ac:6)
        * CMAC-256 (00-0f-ac:13)
        * GMAC-128 (00-0f-ac:11)
        * GMAC-256 (00-0f-ac:12)

What I'm not sure is if b43 is doing all the cyphers it supports in
hardware and falling back to software just for the unsupported ones,
or if it's doing everything in software.
