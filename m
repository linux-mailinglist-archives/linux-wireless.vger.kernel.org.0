Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6B42C1BE
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJMNxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 09:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJMNxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 09:53:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA4AC061570
        for <linux-wireless@vger.kernel.org>; Wed, 13 Oct 2021 06:51:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so12294991lfu.5
        for <linux-wireless@vger.kernel.org>; Wed, 13 Oct 2021 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JWM7HJQktc4hfQyaBNIUbVvEde2pNZAzhiGnMp7nK0s=;
        b=ov5gCm1YYpdupd2FjKo4Y4gPWSO3yMT/MhGdnusqWiwAsMvnGJL1yEgLp+OAX8qTwQ
         t3z2VdVP81gT0gWJOKLRhl92yO4ECAH5vCmiAwqaGg2aVIJAaejMjnyn0tivRMcybIRT
         RQYEnTxMvycJVy81aOa4t0Ss9WIVY36enKUBXZPgJE8b2SjhFIjKgewfdsLICJXvv36D
         kD3VBm6gbx6Pa4NEgdg/tvEo4F9V5VKTmwIfyhPFRu6B7ZWOY7RCXzOQKfgL49FK5M7L
         F9u5kaNRhZHRgrv89bVERu8V8Ty3E4ncCphwEt6+RLYRNXeyHGWVbx9myUAB3reqgQa+
         hrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JWM7HJQktc4hfQyaBNIUbVvEde2pNZAzhiGnMp7nK0s=;
        b=Kbh90jYglVQSE/TYd0Hz81G3/0J/pk48qnGVntqv29cQCozguU9q0MKgXtXBF+8dYh
         RWGs8cX1wb8tbdFp/ds51yB8u4BzRREAl1R6AT0z3BOxrTG1RemGVtZwcqcVCWDjQ6Ol
         swA98FGy+H7PamfDWQIZkku0mmmlvueCKXcmBvuhDSygX3cRrMAPwhaDN2AvyN8MMCm/
         4Oor3ecPlNwTybwofas65olzuCDuKhIgx0CNJcz8b+aPKRGUzgDkbSpNT4/dqyoejL5q
         tSOsM1sxetJQ/9wY1QU+tKJGa9pP8o+I8ronJc+Yjl8lD3kjx8P51wA8DXPdBipudtLE
         33dg==
X-Gm-Message-State: AOAM531hRLOvtns5hH2DKUTEcl4vH9hMZCLKbEm0C/084JEsnQTu+Zum
        E9DUt5oJkwJEukJxJqw9lwaPa3WQhd4UlPTVWP3vcnb/uwA=
X-Google-Smtp-Source: ABdhPJzLv9tMskdmSF5XmHZXO4svV0hg5MKYzdqVe0IbTytKhvGz2nVrE9Xv7QTLx+wpK+exeXzub73dCj8VnT1Fpvc=
X-Received: by 2002:ac2:5fef:: with SMTP id s15mr38821985lfg.190.1634133069493;
 Wed, 13 Oct 2021 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <CALOm-MsEcY7=MwfoEzhCQqSUM6qANy=oP5xYmoPqHAaADcscwA@mail.gmail.com>
 <1c9e0038-d40d-40a0-ac70-5bfcc8d8b95d@westermo.com>
In-Reply-To: <1c9e0038-d40d-40a0-ac70-5bfcc8d8b95d@westermo.com>
From:   =?UTF-8?B?TcOhdGjDqSBLb3Bww6FueQ==?= <mathekoppany@gmail.com>
Date:   Wed, 13 Oct 2021 16:50:57 +0300
Message-ID: <CALOm-Mug=Js5HUhpdJH_djDjPm9u-x-6dYrNMCOLP5gaRBYQZA@mail.gmail.com>
Subject: Re: ath9k: unable to connect to hidden SSID on DFS channel
To:     Matthias May <matthias.may@westermo.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Matthias,

Thanks for your fast and detailed answer.

Could imagine my goal is something not allowed, or at least not the
standard way. However, I still wonder what other devices do for
achieving connection. Thought that this is just a limitation of the
ath9k, but maybe they do something like you suggest.

From your hints, I'd look into:
[*] wonder why probing on DFS channels would be illegal?
My understanding was that this is prohibited only if there was no
beacon received from the AP before.
But if the client receives a beacon from the AP (no matter if it
contains a SSID or not) this shows that the channel is "clear" from
any radar signal, and that the client is allowed to send.
Is my understanding wrong?

[**] would inspect the passive scanning code of ath9k, to see what my
possibilities are to implement the above. Could you indicate some code
to look into? I could not find it easily. Eventually, is some layer
above ath9k also influencing the passive scanning?

Regards,
Koppany

On Tue, Oct 12, 2021 at 10:30 AM Matthias May <matthias.may@westermo.com> w=
rote:
>
> On 10/11/21 12:46 PM, M=C3=A1th=C3=A9 Kopp=C3=A1ny wrote:
> > Hello,
> >
> > I have a project where I want to establish Wi-Fi connection to a
> > hidden SSID, on DFS channel.
> >
> > I am running wpa_supplicant 2.9 on a device with:
> > "Linux 4.9.51-yocto-standard armv7l" and
> > "Network controller: Qualcomm Atheros AR958x 802.11abgn Wireless
> > Network Adapter (rev 01)"
> >
> > Sounds an old project, I know, but want to bring this alive, if
> > possible. Unfortunately, connection to a hidden SSID on DFS channel
> > seems not working.
> >
> > However, it works on a different, newer device, which has
> > "Linux raspberrypi 5.10.17-v7l+ armv7l" and
> > "PCI bridge: Broadcom Limited Device 2711 (rev 10)".
> >
> > The wpa_supplicant on the two devices is mostly idem: same v2.9, same
> > runtime configuration, almost all config variables (wpa_cli dump)
> > match (not seen relevant difference). There might be compile option
> > difference, but don't think they are relevant.
> > The only thing I see is with driver flags, where the newer device
> > supports flags like DFS_OFFLOAD, BSS_SELECTION, or
> > 4WWAY_HANDSHAKE_PSK, but the older device does not offer these.
> >
> > So I suspect the issue is due to some of the above missing features in
> > my ath9k driver (have default driver provided by kernel).
> >
> > Questions:
> > - is it possible to enable the above driver flags/features for ath9k?
> > If so, how to enable and are there patches for these?
> > - any hint where to look in ath9k driver for passive scanning
> > implementation? Is there another module/location where passive
> > scanning is implemented?
> > - any suggestions for a solution to my issue?
> >
> > Thanks,
> > Koppany
> >
>
> Hi
>
> Clients not being able to find hidden APs on DFS frequencies is not a bug=
, but by design.
>
> Facts:
> * When enabling hidden SSID on an AP, the SSID is not sent in the beacons=
.
> * Clients (non-master devices) are not allowed to transmit on a DFS frequ=
ency unless an AP (master device) tells them it
> is ok.
>
> This means that a client can find new APs only by scanning passively.
> Since the beacons do not contain the SSID, the client will never find the=
 AP it is looking for.
>
> Some ways around:
> * Your client is a master and does radar detection (with all its downside=
s), thus it is allowed to probe actively
> * You hack your beacons and add a custom SSID which allows the client to =
get the SSID passively (hack both sides)
> * Your device behaves illegal and sends probe requests on DFS frequencies
> * ???
>
> BR
> Matthias
>
