Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064B3742B3B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjF2Raq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF2Rap (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 13:30:45 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87107B9
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 10:30:41 -0700 (PDT)
Date:   Thu, 29 Jun 2023 17:30:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1688059838; x=1688319038;
        bh=12oqgHfgrTbDGE9Rb/KgdeyWfoOkV35gPR48iFAaEC8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=YF/KtvdzopTeu7m5G4RG4oaI8fFsm1HtIS/yoFlM1gLQw5mgTfEiU6C4zMZ1h15ox
         EC4BvhGiU5fFTSc3sCvlLOV3fSHL9Whd2YfzG8qJXCYv08EhfzeJbh6RdEk+Fdv4eb
         aGtUy+klijVM6HcXNj6QFrl+qqhwccbb46X4JOlc4NjcTm6m2z7KsclS4FKajC08/n
         xaX9uCktP+o8uPudjvKCFEZLRdkT3WJRS1hr7cm0h0cJTl9o4tmGPROX9+co7hO7ai
         MoCVaUM2Vzx+Du4E27lBxGkqqXuIpl7Gm1lxP9ffcGhap/bFIFjGs+oxiEjmb0ZB/+
         Dsv4Z8zQjgTmQ==
To:     Linux regressions mailing list <regressions@lists.linux.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: iwlwifi: AX201 misdetected as AX101
Message-ID: <Up7ODaGLOvtHrl4bj_ev71C6sR5WLequE6TkRsH208_NGRQiZ-f8xdP25L7n9zTZD4bQPMH9aVbfagEh8lbzVlSQRc1mMQFvbIfKAlEU4uA=@protonmail.com>
In-Reply-To: <0d3db91c-f071-009a-952a-bd109b16a352@leemhuis.info>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com> <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com> <3270268e-c926-01e6-65e1-02aa6abfd0db@leemhuis.info> <BgFi95lMulZVgv9IMN9yIzwTaSjvUWnYbQo1U5KT9-G8Dsxuuv4ENVy9iTx8Z8YamXBVPX-K3PYgVBSwgjGY5qXoEsQNpaVXip595AQO584=@protonmail.com> <0d3db91c-f071-009a-952a-bd109b16a352@leemhuis.info>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi


2023. j=C3=BAnius 29., cs=C3=BCt=C3=B6rt=C3=B6k 18:50 keltez=C3=A9ssel, Lin=
ux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> =
=C3=ADrta:

> On 29.06.23 17:28, Barnab=C3=A1s P=C5=91cze wrote:
> > 2023. j=C3=BAnius 29., cs=C3=BCt=C3=B6rt=C3=B6k 13:31 keltez=C3=A9ssel,=
 Thorsten Leemhuis <regressions@leemhuis.info> =C3=ADrta:
> >> On 27.06.23 23:55, Barnab=C3=A1s P=C5=91cze wrote:
> >>> 2023. m=C3=A1jus 26., p=C3=A9ntek 19:55 keltez=C3=A9ssel, Barnab=
=C3=A1s P=C5=91cze <pobrn@protonmail.com> =C3=ADrta:
> >>>> I have an Acer Aspire A315-58 laptop[0], which, according to lspci h=
as the following intel wireless chip:
> >>>>
> >>>>    Device:=0900:14.3
> >>>>     Class:=09Network controller [0280]
> >>>>    Vendor:=09Intel Corporation [8086]
> >>>>    Device:=09Wi-Fi 6 AX201 [a0f0]
> >>>>   SVendor:=09Intel Corporation [8086]
> >>>>   SDevice:=09Wi-Fi 6 AX201 [0244]
> >>>>       Rev:=0920
> >>>>    ProgIf:=0900
> >>>>    Driver:=09iwlwifi
> >>>>    Module:=09iwlwifi
> >>>>
> >>>> However, in the kernel message buffer, the following message is writ=
ten:
> >>>>
> >>>>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX1=
01, REV=3D0x351
>=20
> Gregory who is CCed since the start of the thread might care to look
> into this. According to a quick search lspci is right, but this needs
> expects. Maybe it's just a cosmetic problem.
>=20
> >>> [...]
> >>> For the record, I have done a git-bisect[1], and that turned up
> >>>   d2ccc5c1526396aef5196e4dd2ec8538994e5072
> >>>
> >>> as the first good commit[0].
> >>>
> >>> Sadly, that patch (or even the series) does not appear to be easily b=
ackportable,
> >>> so it seems likely that current stable kernels won't be able to suppo=
rt this device.
> >>
> >> Thx for bisecting.
> >>
> >> Thing is: 6.3 will be EOL in about two or three weeks anyway. And Arch
> >> will likely switch to 6.4 (which works -- or did I get this wrong?)
> >> within a week or two. Makes be wonder if it's the best solution for
> >> everyone involved to not resolve this and move on.
> >
> > Yes, 6.4 seems to work.
>=20
> #regzbot inconclusive: unlikely to be fixed in 6.3 before EOL, but 6.4 wo=
rks
>=20
> > I mainly meant LTS releases.  Nonetheless, lspci
> > and iwlwifi still disagree on what device it actually is.
>=20
> Not sure if I properly understand this.
>=20
> Is this broken in 6.1.y as well, but working in earlier kernels? Then it
> needs a separate report.

There are two issues:

 * lspci and iwlwifi disagreeing about the device (AX201 vs AX101), and
 * the device not working until the aforementioned commit.

This email was originally intended to be about the first one since the devi=
ce
does work with 6.4.

But out of curiosity I wanted to find the commit that made the device work =
to
see if maybe it could be easily backported to 6.3, 6.1, etc.

In conclusion:

        device does not work        device is misdetected
6.1          present                       present
6.3          present                       present
6.4           fixed                        present

Since the commits that fixed it don't appear to be easily backportable,
the only thing remains to be seen is why lspci and iwlwifi disagree about t=
he
name of the device. That issue is still present in 6.4.


Regards,
Barnab=C3=A1s P=C5=91cze

>=20
> Or do you mean the disagreement? Maybe mentioning Gregory's name above
> will do the trick to make the Intel folks look into this.
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
