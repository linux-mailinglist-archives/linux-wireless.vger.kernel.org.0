Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341786FC9DE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbjEIPIZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjEIPIY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 11:08:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C23C3E
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 08:08:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so24742095e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 May 2023 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683644901; x=1686236901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAV2HyYBiHbrlGsX4s+W32rpj8bdmrk58tXh9A7mC8A=;
        b=XyBCY+Ut6U0BLyk8DuugajxmUlfwxcUReD00HqAfKju4RpaRQW5upFhOzmbhFgTM2t
         G6gDp7MgVgpkgcv3++z+GRG/6LFJNPObjbZhmfXk8EKPbBRX6846W72dXD/9RTuKsU1C
         VpmK8r1HotMjkMCJkTQrEHQN9gRq+/bOdgIt0En6iteXnCel2L1oK7YgSt7RSAjU0tBc
         XIwpVo6kj85bxFIV8iMDSLSEfiSAJ2t/I+GABcZ4S0Gmu8tVakbV/NKiSBA1panRNtHi
         4C/wxgdk0z809bVQW9oIV8G3siIkgFCgiWl9SxrjKpKn1dGxoam7Qy7UFv7Wij1EvKRM
         AynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683644901; x=1686236901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAV2HyYBiHbrlGsX4s+W32rpj8bdmrk58tXh9A7mC8A=;
        b=Pp1Sf6FLt2UeIKWKBbrG45s2Y4Z7t8gHRr6HzKtQVZjZ8f+7eGp9rhag7XY13FM89M
         V7biK557Jv/7BW6iWjKjw68xUIlnPZubLjG8ZphwPs/WWJ8xh5chUtZ1Gp+LxLf2bktt
         cmXsCEei36Uts5+nmIOXhqPDbg0u2HZcR5HFuo5KspsuUaO7gJ+hnNs3ofh7ajXLCLRW
         9MULJpLqwc8VZLhirYeukmj4ngqzH49O6toDnXtqgF84bjI6R+gVTUjgDzFquBYgwg2u
         LSjUCMBI5+bKBNItYjmXReXUg90N/Hnx+0jBkxXzUNg7zz5SAC0jYqhwPNH3Uc1yMgWT
         Zniw==
X-Gm-Message-State: AC+VfDwaqeROmVWH8cPc7fTQum0sfpWwxVuepOLHs4yxJ0Wb0Lcb3qR0
        latVtOEdCs0U0KxVRYmnn0Gp0i7PFBlpeiIa1PA=
X-Google-Smtp-Source: ACHHUZ4gecs1+MjpgVjAjEcjqva39r6tc2mNtr5TuNQyZ2ZCEXl/UdkXI7XIfi8iCYzuPhgHEEL1GvafXvuGW8Wsz7I=
X-Received: by 2002:a05:600c:383:b0:3f1:93c2:4df6 with SMTP id
 w3-20020a05600c038300b003f193c24df6mr9763060wmd.12.1683644901398; Tue, 09 May
 2023 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230508134626.GZ29365@pengutronix.de> <20230509074350.2862571-1-petter@technux.se>
 <20230509090841.GE29365@pengutronix.de>
In-Reply-To: <20230509090841.GE29365@pengutronix.de>
From:   Gabriel Tisan <gabriel.tisan@gmail.com>
Date:   Tue, 9 May 2023 17:08:09 +0200
Message-ID: <CAD9ZU8BHTOA9=V7NQvkGBLK4DV2NRvk2rDxJX6qr6unZsg-QdA@mail.gmail.com>
Subject: Re: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Petter Mabacker <petter@technux.se>,
        linux-wireless@vger.kernel.org, pkshih@realtek.com,
        tony0620emma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Actually there is a recent firmware 9.9.15.
Petter use that, is displayed in the first email.

I have also an LM482 with 9.9.15 firmware. I used iperf with TCP and I
could not reproduce that.
I will try iperf with UDP like in your case.
How do you use LM482 when running iperf ? As station or AP ?

Gabriel

On Tue, May 9, 2023 at 11:18=E2=80=AFAM Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
>
> On Tue, May 09, 2023 at 09:43:50AM +0200, Petter Mabacker wrote:
> > >> I'm working with a Linux 6.1 based track, but with all the mentioned=
 bug fixes cherry-picked to that track. They have all made the LM842 a lot =
more stabile, but the issue I see with "tx report failed" is currently bloc=
king me from using the LM842, since the mender upgrade is a crucial part fo=
r my use-case.
> > >>
> > >> I have been trying to find a better way to reproduce the issue, with=
out any success so far. For me it takes just 10-30 sec with above mention f=
looding using iperf to at least trigger a similar case.
> > >>
> > >> ...
> > >> [  671.908527] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> > >> [  671.914632] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> > >> [  671.920750] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> > >> [  671.926792] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> > >> [  671.932924] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
> >
> > >I am still not sure what to do about this. It happens with high RX loa=
d.
> > >One way would be to just drop the log level of this message.
> > >Otherwise this message should be harmless.
> >
> > Like stated in earlier mails, the initial problem was found during a
> > mender upgrade (streaming a ~200MB file). In that case the problem
> > occurs without any high RX load warnings. So that is not really
> > related (at least I don't think so).
> >
> > The real problem is that the driver ends-up in a not working state
> > after this. Not even hot-plugging the dongle will help. Instead a
> > reboot or reset of the driver (rmmod/insmod etc) is required.
> >
> > >>
> > >> [  694.709045] rtw_8822cu 1-1:1.2: failed to get tx report from firm=
ware
> > >>
> > >> [  710.169496] rtw_8822cu 1-1:1.2: firmware failed to report density=
 after scan
> > >> [  717.701235] rtw_8822cu 1-1:1.2: failed to send h2c command
> > >>
> > >> I can also mention that I'm running this in a i.MX6 SoloX based boar=
d.
> > >>
> > >> I will let you guys know if I find a better way to reproduce the
> > >> issue. But if you have any good ideas what above error (that brings
> > >> down the entire interface) really mean (for example does it indicate
> > >> kernel or firmware issue), please feel free to share some informatio=
n
> > >> about it and it might help me in troubleshooting the issue further.
> >
> > >Please try reproducing this with a recent mainline vanilla kernel. It
> > >shouldn't be too hard to bring up a i.MX6 board with a vanilla kernel.
> >
> > Just to be sure, I have tried this using latest kernel tree as you sugg=
ested:
> >
> > ~# uname -r
> > 6.4.0-rc1-g5ca44e46dff4
> >
> > However I get the very same behavior (in this case it's from the failed=
 mender upgrade):
> > [  724.788270] rtw_8822cu 1-1:1.2: failed to get tx report from firmwar=
e
> > [  728.499480] rtw_8822cu 1-1:1.2: failed to send h2c command
> > [  758.558511] rtw_8822cu 1-1:1.2: firmware failed to report density af=
ter scan
> > May 09 06:48:17 iotgw mender[643]: time=3D"2023-05-09T06:48:17Z" level=
=3Derror msg=3D"Download connection broken: read tcp 192.168.68.113:54072->=
52.239.140.42:443: read: connection timed out"
> > [  796.975782] rtw_8822cu 1-1:1.2: firmware failed to report density af=
ter scan
> > [  835.251656] rtw_8822cu 1-1:1.2: firmware failed to report density af=
ter scan
> > [  843.586421] rtw_8822cu 1-1:1.2: failed to send h2c command
>
> Unfortunately it looks like this very often when something goes wrong in
> the RTW88 driver. These messages seem to be a general sign for the
> device to say that we have touched it wrong somehow and it's stuck now.
>
> >
> > When I try to hotplug the dongle (that still don't solve the issue). I
> > can see below printout, any ideas what it really mean? (I never see
> > this before the problem occurs, only when hotplugging after the
> > problem occurs):
> >
> > [ 2298.729359] wlx34c9f08deb60: Limiting TX power to 23 (23 - 0) dBm as=
 advertised by 1c:3b:f3:55:59:93
> >
> > Since you cannot reproduce the similar (perhaps not even the same root
> > issue) issue I saw using iperf, I will focus on trying to reproduce it
> > using something similar as the streaming procedure done by mender. Any
> > other suggestions from your side, or any logs etc that could be of
> > interest?
>
> You could verify that you are using a recent firmware. The driver prints
> it during initialization. It should be 9.9.11.
>
> Other than that I don't have any good idea, sorry.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
