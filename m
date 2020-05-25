Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84AF1E075E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 08:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbgEYG4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 02:56:39 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43622 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388385AbgEYG4i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 02:56:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590389797; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=Me3GjJcJUW2Ik2X6lU5cKB4Pphg+XjttBxGjgK4qBO8=; b=Q7yS6uf0bf0Azbgz6M5hw/341/uUYyMbTbScR0cz/pbIKAPxHkN/vdrKsRX269uxCOM5DedA
 Fkv3FAPyvp7G0qh0uL2qSt0RyxaHGFbm22tFSpc4jhecqL16+K5dX/MwKSqUF8Qd/WfuAtW2
 vrqdHYWFOPi4B81xV5aKGgvFscU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ecb6c23.7f82d4197030-smtp-out-n05;
 Mon, 25 May 2020 06:56:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DF75C433CB; Mon, 25 May 2020 06:56:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC1F4C433C9;
        Mon, 25 May 2020 06:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC1F4C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>,
        b43-dev <b43-dev@lists.infradead.org>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
        <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
        <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
        <20200521124608.4b5c78f2@wiggum>
        <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
        <20200521134011.656381ad@wiggum>
        <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
        <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
        <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
        <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
        <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
        <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net>
        <20200522121910.254aefc1@wiggum> <87a720gpfb.fsf@tynnyri.adurom.net>
        <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
        <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net>
        <CALjTZvZV4kwLgoTijxsC2AYcxGeT1R_fsTdh3Gb=M03Rn_RsAg@mail.gmail.com>
        <8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net>
        <CACna6rzHyyTRUL-Qat0URMoRQpn7HHT9fiZH9jSKRrKA1Meoqg@mail.gmail.com>
Date:   Mon, 25 May 2020 09:56:30 +0300
In-Reply-To: <CACna6rzHyyTRUL-Qat0URMoRQpn7HHT9fiZH9jSKRrKA1Meoqg@mail.gmail.com>
        (=?utf-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22's?= message of "Sat, 23 May 2020
 23:17:14 +0200")
Message-ID: <87o8qca4f5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> writes:

> On Fri, 22 May 2020 at 23:06, Larry Finger <Larry.Finger@lwfinger.net> wr=
ote:
>> On 5/22/20 3:40 PM, Rui Salvaterra wrote:
>> > On Fri, 22 May 2020 at 19:02, Larry Finger <Larry.Finger@lwfinger.net>=
 wrote:
>> >>
>> >> Rui,
>> >>
>> >> Does this one-line
>> >> patch work for WPA3 without setting the nohwcrypt option?
>> >
>> > Ok, so it "works", but I don't know what actually happened (I didn't
>> > do any performance testing yet). I got this relevant output on my
>> > kmsg=E2=80=A6
>> >
>> > rui@mcnugget:~$ dmesg | awk '(/80211/ || /b43/ || /wlan0/)'
>> > [    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinux-5.7.0-rc6+
>> > root=3DUUID=3D849bbef3-007e-491e-b187-9e259680c2e2 ro mitigations=3Doff
>> > b43.qos=3D0 b43.verbose=3D3 usbhid.mousepoll=3D16 quiet splash
>> > [    0.035705] b43-pci-bridge 0001:10:12.0: enabling device (0004 -> 0=
006)
>> > [    0.210299] b43-pci-bridge 0001:10:12.0: Sonics Silicon Backplane
>> > found on PCI device 0001:10:12.0
>> > [    3.361908] b43-phy0: Broadcom 4318 WLAN found (core revision 9)
>> > [    3.454235] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>> > [    3.454259] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision
>> > 8, Version 0
>> > [    3.485125] ieee80211 phy0: Selected rate control algorithm 'minstr=
el_ht'
>> > [   28.697945] b43-phy0: Loading firmware version 666.2 (2011-02-23 01=
:15:07)
>> > [   28.730381] b43-phy0 debug: Chip initialized
>> > [   28.731389] b43-phy0 debug: 32-bit DMA initialized
>> > [   28.731400] b43-phy0 debug: QoS disabled
>> > [   28.792272] b43-phy0 debug: Wireless interface started
>> > [   28.820318] b43-phy0 debug: Adding Interface type 2
>> > [   33.944771] wlan0: authenticate with 04:f0:21:24:28:44
>> > [   33.970449] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
>> > [   34.026222] wlan0: authenticate with 04:f0:21:24:28:44
>> > [   34.026241] wlan0: send auth to 04:f0:21:24:28:44 (try 1/3)
>> > [   34.028522] wlan0: authenticated
>> > [   34.043256] wlan0: associate with 04:f0:21:24:28:44 (try 1/3)
>> > [   34.046946] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=3D0x4=
31
>> > status=3D30 aid=3D1)
>> > [   34.046964] wlan0: 04:f0:21:24:28:44 rejected association
>> > temporarily; comeback duration 1000 TU (1024 ms)
>> > [   35.122051] wlan0: associate with 04:f0:21:24:28:44 (try 2/3)
>> > [   35.125547] wlan0: RX AssocResp from 04:f0:21:24:28:44 (capab=3D0x4=
31
>> > status=3D0 aid=3D1)
>> > [   35.125808] wlan0: associated
>> > [   35.268256] b43-phy0 debug: Using hardware based encryption for
>> > keyidx: 0, mac: 04:f0:21:24:28:44
>> > [   35.268762] b43-phy0 debug: Using hardware based encryption for
>> > keyidx: 2, mac: ff:ff:ff:ff:ff:ff
>> > [   35.358586] wlan0: failed to set key (5, ff:ff:ff:ff:ff:ff) to hard=
ware (-22)
>> > [   35.358977] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>> > [   87.283220] wlan0: failed to set key (4, ff:ff:ff:ff:ff:ff) to hard=
ware (-22)
>> > [   87.283521] b43-phy0 debug: Using hardware based encryption for
>> > keyidx: 1, mac: ff:ff:ff:ff:ff:ff
>> > rui@mcnugget:~$
>> >
>> > Meanwhile, iw list shows all the possible software cyphers:
>> >
>> >      Supported Ciphers:
>> >          * WEP40 (00-0f-ac:1)
>> >          * WEP104 (00-0f-ac:5)
>> >          * TKIP (00-0f-ac:2)
>> >          * CCMP-128 (00-0f-ac:4)
>> >          * CCMP-256 (00-0f-ac:10)
>> >          * GCMP-128 (00-0f-ac:8)
>> >          * GCMP-256 (00-0f-ac:9)
>> >          * CMAC (00-0f-ac:6)
>> >          * CMAC-256 (00-0f-ac:13)
>> >          * GMAC-128 (00-0f-ac:11)
>> >          * GMAC-256 (00-0f-ac:12)
>> >
>> > What I'm not sure is if b43 is doing all the cyphers it supports in
>> > hardware and falling back to software just for the unsupported ones,
>> > or if it's doing everything in software.
>>
>> It will do supported ciphers in hardware, and unsupported using software=
. The
>> patch tells mac80211 that we will accept the newer ciphers, then in the
>> set_key() callback, we tell it whether the current type will be handled =
in
>> hardware. Operations will be transparent. I will keep the nohwcrypt opti=
on just
>> in case someone has a hardware malfunction that prohibits hardware use f=
or all
>> ciphers, but it will not be needed in cases like yours. Performance will=
 be as
>> you did earlier.
>
> Nice work Larry, thank you!

Indeed, this is a perfect solution.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
