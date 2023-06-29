Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F6742E21
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjF2UEJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjF2UDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 16:03:42 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F73C01
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 13:03:16 -0700 (PDT)
Date:   Thu, 29 Jun 2023 20:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1688068994; x=1688328194;
        bh=g4QWBEy1zgzBDhjQke9f5CW/d2l1TLARH4+S+S8WRzw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kh4aZXKgduzn64jbe2p5658SF+oZuYh8ZA9AVCVFv11XxkFLR4e2psL1TocBt7QT2
         EBPhdfBfhMt6hndtbrZOWyPOOfWMlWUJUo7DsfeSadvpvLkVP4+dSySOHxFbbTVoQC
         Zqc7Q5lWdV1ex19+C0OPo+Og994FBsrF6AUm+It0kQQR6Bgv9jIvMaGcIefPsCN43Q
         5l/9++DV5pzyE7FINYlXzOGcfzBDMhObtn3gk3eve8Tc8KfEgXEFzxjK7PI3WE4ZFA
         GqNME1J1Qkf24Udb+xnXPm3gNEfdX7180aM6KtgEsCMlN5fb6Y0HxlEXlD8UmsTzWp
         XFyF9TIoGpPVA==
To:     Greg KH <gregkh@linuxfoundation.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: iwlwifi: AX201 misdetected as AX101
Message-ID: <adF9i7U7wq5cWC7pfnSajyc08F0bnYGoTw7RWvyvgA2M9gRCMIaZ_XXRUBdTCaSWM-MB_XUSWxXNsI_esArpQHqkG7BNnLgw2_O_B6yz6Ws=@protonmail.com>
In-Reply-To: <2023062914-upcoming-turmoil-a443@gregkh>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com> <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com> <3270268e-c926-01e6-65e1-02aa6abfd0db@leemhuis.info> <BgFi95lMulZVgv9IMN9yIzwTaSjvUWnYbQo1U5KT9-G8Dsxuuv4ENVy9iTx8Z8YamXBVPX-K3PYgVBSwgjGY5qXoEsQNpaVXip595AQO584=@protonmail.com> <0d3db91c-f071-009a-952a-bd109b16a352@leemhuis.info> <Up7ODaGLOvtHrl4bj_ev71C6sR5WLequE6TkRsH208_NGRQiZ-f8xdP25L7n9zTZD4bQPMH9aVbfagEh8lbzVlSQRc1mMQFvbIfKAlEU4uA=@protonmail.com> <2023062914-upcoming-turmoil-a443@gregkh>
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


2023. j=C3=BAnius 29., cs=C3=BCt=C3=B6rt=C3=B6k 20:46 keltez=C3=A9ssel, Gre=
g KH <gregkh@linuxfoundation.org> =C3=ADrta:

> On Thu, Jun 29, 2023 at 05:30:34PM +0000, Barnab=C3=A1s P=C5=91cze wrote:
> > Hi
> >
> >
> > 2023. j=C3=BAnius 29., cs=C3=BCt=C3=B6rt=C3=B6k 18:50 keltez=C3=A9ssel,=
 Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> =
=C3=ADrta:
> >
> > > On 29.06.23 17:28, Barnab=C3=A1s P=C5=91cze wrote:
> > > > 2023. j=C3=BAnius 29., cs=C3=BCt=C3=B6rt=C3=B6k 13:31 keltez=C3=
=A9ssel, Thorsten Leemhuis <regressions@leemhuis.info> =C3=ADrta:
> > > >> On 27.06.23 23:55, Barnab=C3=A1s P=C5=91cze wrote:
> > > >>> 2023. m=C3=A1jus 26., p=C3=A9ntek 19:55 keltez=C3=A9ssel, Barnab=
=C3=A1s P=C5=91cze <pobrn@protonmail.com> =C3=ADrta:
> > > >>>> I have an Acer Aspire A315-58 laptop[0], which, according to lsp=
ci has the following intel wireless chip:
> > > >>>>
> > > >>>>    Device:=0900:14.3
> > > >>>>     Class:=09Network controller [0280]
> > > >>>>    Vendor:=09Intel Corporation [8086]
> > > >>>>    Device:=09Wi-Fi 6 AX201 [a0f0]
> > > >>>>   SVendor:=09Intel Corporation [8086]
> > > >>>>   SDevice:=09Wi-Fi 6 AX201 [0244]
> > > >>>>       Rev:=0920
> > > >>>>    ProgIf:=0900
> > > >>>>    Driver:=09iwlwifi
> > > >>>>    Module:=09iwlwifi
> > > >>>>
> > > >>>> However, in the kernel message buffer, the following message is =
written:
> > > >>>>
> > > >>>>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6=
 AX101, REV=3D0x351
> > >
> > > Gregory who is CCed since the start of the thread might care to look
> > > into this. According to a quick search lspci is right, but this needs
> > > expects. Maybe it's just a cosmetic problem.
> > >
> > > >>> [...]
> > > >>> For the record, I have done a git-bisect[1], and that turned up
> > > >>>   d2ccc5c1526396aef5196e4dd2ec8538994e5072
> > > >>>
> > > >>> as the first good commit[0].
> > > >>>
> > > >>> Sadly, that patch (or even the series) does not appear to be easi=
ly backportable,
> > > >>> so it seems likely that current stable kernels won't be able to s=
upport this device.
> > > >>
> > > >> Thx for bisecting.
> > > >>
> > > >> Thing is: 6.3 will be EOL in about two or three weeks anyway. And =
Arch
> > > >> will likely switch to 6.4 (which works -- or did I get this wrong?=
)
> > > >> within a week or two. Makes be wonder if it's the best solution fo=
r
> > > >> everyone involved to not resolve this and move on.
> > > >
> > > > Yes, 6.4 seems to work.
> > >
> > > #regzbot inconclusive: unlikely to be fixed in 6.3 before EOL, but 6.=
4 works
> > >
> > > > I mainly meant LTS releases.  Nonetheless, lspci
> > > > and iwlwifi still disagree on what device it actually is.
> > >
> > > Not sure if I properly understand this.
> > >
> > > Is this broken in 6.1.y as well, but working in earlier kernels? Then=
 it
> > > needs a separate report.
> >
> > There are two issues:
> >
> >  * lspci and iwlwifi disagreeing about the device (AX201 vs AX101), and
> >  * the device not working until the aforementioned commit.
> >
> > This email was originally intended to be about the first one since the =
device
> > does work with 6.4.
> >
> > But out of curiosity I wanted to find the commit that made the device w=
ork to
> > see if maybe it could be easily backported to 6.3, 6.1, etc.
> >
> > In conclusion:
> >
> >         device does not work        device is misdetected
> > 6.1          present                       present
> > 6.3          present                       present
> > 6.4           fixed                        present
> >
> > Since the commits that fixed it don't appear to be easily backportable,
> > the only thing remains to be seen is why lspci and iwlwifi disagree abo=
ut the
> > name of the device. That issue is still present in 6.4.
>=20
> This isn't a regression then, it's never worked, but now it works in
> 6.4, so yeah!  And we don't generally backport new hardware enablement
> to stable kernels unless it's a simple device id table update.

I was hoping the change is just a couple lines of bug fixing, which I imagi=
ne,
would've been a good candidate for backporting. To be fair, the commit that=
 made
it work is in fact a couple lines, but it has many dependencies...


>=20
> As for naming, realize that iwlwifi and lspci get the names of the
> device from different places, so perhaps those userspace databases just
> are not in sync yet?
> [...]

Yes, I am aware of that. Another thing I have realized is that I could just=
 open
the laptop to see what's written on the chip to determine who is right. As =
it turns
out, I did not even have to do that because it says right on the back that

  The Device Contains WLAN + Bluetooth Module
  AX101NGW

I really should've thought of this before. So if this label is to be believ=
ed,
then iwlwifi is right, and lspci is incorrect. So sorry everyone for this w=
aste
of time. For some reasons I really thought that iwlwifi was in the wrong.
I submitted the info to the pci-ids project: https://pci-ids.ucw.cz/read/PC=
/8086/a0f0


Regards,
Barnab=C3=A1s P=C5=91cze
