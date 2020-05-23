Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366EA1DFB1F
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 23:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgEWVR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 May 2020 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbgEWVR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 May 2020 17:17:27 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE14C061A0E
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 14:17:26 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id r23so2727263ybd.10
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2020 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JLqHLg7jE9fD4cf0fKA2yrUDcwGrJXd29V4hmwSHA4w=;
        b=D3rlJd4tBakt7gdP+KhCrJ6Q+mHtayhT77WNPO5+s82D09DRxyy3xXJKweKuQPAEBx
         r6kJOU+gTd15l5VJHuh5ormCORW/mtkuntnUncxglvCkI1IiiRqR/n1T+NXmjdCgeYTN
         zfFkA1RwqHUgZOY8+7yIcfLNtK7VMGbPP5+5iRjE0S+9wBR6Bg+wkBL38K4hfxPmQPSN
         xbNH7yPz+wRcMbkXVJBJJ/LEwu4QoPdu/9MBtB9C2M04X8FlnncviEfYo8OHygtcimiJ
         hPGKPzAxynJNOXo10WJ+3SH+kgwiUgMVH5k80gljwIjBbsbpOQQFF9nANt9t2JzdpNyK
         u15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JLqHLg7jE9fD4cf0fKA2yrUDcwGrJXd29V4hmwSHA4w=;
        b=maFky9yzEQJ/TskJ9uTb/Z6H/Trf9J2iX5RrMd8HXafn9jNqCZYEYDJFeK1sLgJoQL
         9Typ5/yOcozIE4PH+gAHOZ8P2Di16kGz6FB4oD2mV4W2lZiMi/hS+K/6KCrBd2B2Vrkl
         NPGP/2G4m79n4g2G9ZpPaV+Xyqs2lX5CFai05DJiI1Rax88+qrJvG58yf/ofUeKUx4Ra
         mLuVhjPJRwNPXMLAZDh4uLXh9e4ZkT9kHMfMTo+x2iZV1bEC/SyrfS7Golh7SWfSqXvo
         mNyzNJA0UvIXFmomzia7r5a9MpN8LiRnigpKCxm8pqFa8xG0isdH4CfpSEDIFHgyLhZr
         +VFg==
X-Gm-Message-State: AOAM532AHcfokwiVKoagUuzmXEUyIpBCicZYquI4VrhyAkXglT+rYTTk
        5mNqWEHNWc18mZxtBe9LB85l0bYefq/m1RGp5II=
X-Google-Smtp-Source: ABdhPJw0nU40qpJozklxfYHRHqCXIE2KFOUme45GrOcQdg5i5Slz+6pgK9lW+GI/wt2bfFTV84Xs5S6Fvf/mDwfjt6Q=
X-Received: by 2002:a25:c1c5:: with SMTP id r188mr32692127ybf.240.1590268645891;
 Sat, 23 May 2020 14:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net> <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net> <20200522121910.254aefc1@wiggum>
 <87a720gpfb.fsf@tynnyri.adurom.net> <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
 <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net> <CALjTZvZV4kwLgoTijxsC2AYcxGeT1R_fsTdh3Gb=M03Rn_RsAg@mail.gmail.com>
 <8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net>
In-Reply-To: <8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sat, 23 May 2020 23:17:14 +0200
Message-ID: <CACna6rzHyyTRUL-Qat0URMoRQpn7HHT9fiZH9jSKRrKA1Meoqg@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        Kalle Valo <kvalo@codeaurora.org>,
        b43-dev <b43-dev@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 22 May 2020 at 23:06, Larry Finger <Larry.Finger@lwfinger.net> wrot=
e:
> On 5/22/20 3:40 PM, Rui Salvaterra wrote:
> > On Fri, 22 May 2020 at 19:02, Larry Finger <Larry.Finger@lwfinger.net> =
wrote:
> >>
> >> Rui,
> >>
> >> Does this one-line
> >> patch work for WPA3 without setting the nohwcrypt option?
> >
> > Ok, so it "works", but I don't know what actually happened (I didn't
> > do any performance testing yet). I got this relevant output on my
> > kmsg=E2=80=A6
> >
> > rui@mcnugget:~$ dmesg | awk '(/80211/ || /b43/ || /wlan0/)'
> > [    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinux-5.7.0-rc6+
> > root=3DUUID=3D849bbef3-007e-491e-b187-9e259680c2e2 ro mitigations=3Doff
> > b43.qos=3D0 b43.verbose=3D3 usbhid.mousepoll=3D16 quiet splash
> > [    0.035705] b43-pci-bridge 0001:10:12.0: enabling device (0004 -> 00=
06)
> > [    0.210299] b43-pci-bridge 0001:10:12.0: Sonics Silicon Backplane
> > found on PCI device 0001:10:12.0
> > [    3.361908] b43-phy0: Broadcom 4318 WLAN found (core revision 9)
> > [    3.454235] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
> > [    3.454259] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision
> > 8, Version 0
> > [    3.485125] ieee80211 phy0: Selected rate control algorithm 'minstre=
l_ht'
> > [   28.697945] b43-phy0: Loading firmware version 666.2 (2011-02-23 01:=
15:07)
> > [   28.730381] b43-phy0 debug: Chip initialized
> > [   28.731389] b43-phy0 debug: 32-bit DMA initialized
> > [   28.731400] b43-phy0 debug: QoS disabled
> > [   28.792272] b43-phy0 debug: Wireless interface started
> > [   28.820318] b43-phy0 debug: Adding Interface type 2
> > [   33.944771] wlan0: authenticate with 04:f0:21:24:28:44
> > [   33.970449] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
> > [   34.026222] wlan0: authenticate with 04:f0:21:24:28:44
> > [   34.026241] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
> > [   34.028522] wlan0: authenticated
> > [   34.043256] wlan0: associate with 04:f0:21:24:28:44 (try 1/3)
> > [   34.046946] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=3D0x43=
1
> > status=3D30 aid=3D1)
> > [   34.046964] wlan0: 04:f0:21:24:28:44 rejected association
> > temporarily; comeback duration 1000 TU (1024 ms)
> > [   35.122051] wlan0: associate with 04:f0:21:24:28:44 (try 2/3)
> > [   35.125547] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=3D0x43=
1
> > status=3D0 aid=3D1)
> > [   35.125808] wlan0: associated
> > [   35.268256] b43-phy0 debug: Using hardware based encryption for
> > keyidx: 0, mac: 04:f0:21:24:28:44
> > [   35.268762] b43-phy0 debug: Using hardware based encryption for
> > keyidx: 2, mac: ff:ff:ff:ff:ff:ff
> > [   35.358586] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hardw=
are (-22)
> > [   35.358977] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> > [   87.283220] wlan0: failed to set key (4, ff:ff:ff:ff:ff:ff) to hardw=
are (-22)
> > [   87.283521] b43-phy0 debug: Using hardware based encryption for
> > keyidx: 1, mac: ff:ff:ff:ff:ff:ff
> > rui@mcnugget:~$
> >
> > Meanwhile, iw list shows all the possible software cyphers:
> >
> >      Supported Ciphers:
> >          * WEP40 (00-0f-ac:1)
> >          * WEP104 (00-0f-ac:5)
> >          * TKIP (00-0f-ac:2)
> >          * CCMP-128 (00-0f-ac:4)
> >          * CCMP-256 (00-0f-ac:10)
> >          * GCMP-128 (00-0f-ac:8)
> >          * GCMP-256 (00-0f-ac:9)
> >          * CMAC (00-0f-ac:6)
> >          * CMAC-256 (00-0f-ac:13)
> >          * GMAC-128 (00-0f-ac:11)
> >          * GMAC-256 (00-0f-ac:12)
> >
> > What I'm not sure is if b43 is doing all the cyphers it supports in
> > hardware and falling back to software just for the unsupported ones,
> > or if it's doing everything in software.
> It will do supported ciphers in hardware, and unsupported using software.=
 The
> patch tells mac80211 that we will accept the newer ciphers, then in the
> set_key() callback, we tell it whether the current type will be handled i=
n
> hardware. Operations will be transparent. I will keep the nohwcrypt optio=
n just
> in case someone has a hardware malfunction that prohibits hardware use fo=
r all
> ciphers, but it will not be needed in cases like yours. Performance will =
be as
> you did earlier.

Nice work Larry, thank you!

--=20
Rafa=C5=82
