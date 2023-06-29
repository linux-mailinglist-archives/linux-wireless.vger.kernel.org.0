Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F7F7429A3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjF2P2d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjF2P2a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 11:28:30 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3C297B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 08:28:23 -0700 (PDT)
Date:   Thu, 29 Jun 2023 15:28:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1688052500; x=1688311700;
        bh=FXd9YwzbO+u4WtPJ3Iy09Mel2eSuWtSSjRiblCUl8Ck=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=oCvsFxmPMHpD4OFJ7PrCIOjbasu39nPvd6QAyYIKP2jGCimdSBPfSbDciCJiU3iSl
         m0a8B8O3tO9vi6AOqcjxVJhtyrlZb+yC6/qvJE1FfQwyMNPIXQhRVJh3/MPXzYRO6e
         UjY37p6dqpx5imIiUD9SCx6tqC6p2smZxaVo3hO6ikEsnWNZgCPWI568j8mHheL8em
         Mzl0D/IynurV8NtJq1TrP9DYNlLn16eUqPCDPsJ2kvjN9nGI9iPycKXpPZRV3eaoQd
         fog5IrCqP7BMQ2qj+YZPUH0LYIKaeDHVyfChJdCALci9/Z7UlAo1cNUwAUpvNp+PL3
         +GuERA6zrPEHQ==
To:     Thorsten Leemhuis <regressions@leemhuis.info>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: iwlwifi: AX201 misdetected as AX101
Message-ID: <BgFi95lMulZVgv9IMN9yIzwTaSjvUWnYbQo1U5KT9-G8Dsxuuv4ENVy9iTx8Z8YamXBVPX-K3PYgVBSwgjGY5qXoEsQNpaVXip595AQO584=@protonmail.com>
In-Reply-To: <3270268e-c926-01e6-65e1-02aa6abfd0db@leemhuis.info>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com> <FFsiCdZPcJ2FItvpkX6E-0LT-gc1m-7JdRKTZ0NB9s7AmhtFt09wmR8fItdeT5xaYybsKsC_cjXuh5i_V97rgq4fJgKOmBmKytjCwSKlnAU=@protonmail.com> <3270268e-c926-01e6-65e1-02aa6abfd0db@leemhuis.info>
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


2023. j=C3=BAnius 29., cs=C3=BCt=C3=B6rt=C3=B6k 13:31 keltez=C3=A9ssel, Tho=
rsten Leemhuis <regressions@leemhuis.info> =C3=ADrta:

> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>=20
> On 27.06.23 23:55, Barnab=C3=A1s P=C5=91cze wrote:
> >
> > 2023. m=C3=A1jus 26., p=C3=A9ntek 19:55 keltez=C3=A9ssel, Barnab=C3=
=A1s P=C5=91cze <pobrn@protonmail.com> =C3=ADrta:
> >>
> >> I have an Acer Aspire A315-58 laptop[0], which, according to lspci has=
 the following intel wireless chip:
> >>
> >>    Device:=0900:14.3
> >>     Class:=09Network controller [0280]
> >>    Vendor:=09Intel Corporation [8086]
> >>    Device:=09Wi-Fi 6 AX201 [a0f0]
> >>   SVendor:=09Intel Corporation [8086]
> >>   SDevice:=09Wi-Fi 6 AX201 [0244]
> >>       Rev:=0920
> >>    ProgIf:=0900
> >>    Driver:=09iwlwifi
> >>    Module:=09iwlwifi
> >>
> >> However, in the kernel message buffer, the following message is writte=
n:
> >>
> >>   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101=
, REV=3D0x351
> > [...]
> >
> > For the record, I have done a git-bisect[1], and that turned up
> >
> >   d2ccc5c1526396aef5196e4dd2ec8538994e5072
> >   wifi: iwlwifi: Update init sequence if tx diversity supported
> >
> > as the first good commit[0].
> >
> > Sadly, that patch (or even the series) does not appear to be easily bac=
kportable,
> > so it seems likely that current stable kernels won't be able to support=
 this device.
>=20
> Thx for bisecting.
>=20
> Thing is: 6.3 will be EOL in about two or three weeks anyway. And Arch
> will likely switch to 6.4 (which works -- or did I get this wrong?)
> within a week or two. Makes be wonder if it's the best solution for
> everyone involved to not resolve this and move on.
>=20
> Ciao, Thorsten

Yes, 6.4 seems to work. I mainly meant LTS releases. Nonetheless, lspci
and iwlwifi still disagree on what device it actually is.


Regards,
Barnab=C3=A1s P=C5=91cze

>=20
> > [0]: https://lore.kernel.org/all/20230413102635.c2121c8694a7.Ibee3dd876=
5ef4b7504660fa228a7c7eff78920af@changeid/
> > [1]:
> >   git bisect start
> >   # status: waiting for both good and bad commits
> >   # new: [b6dad5178ceaf23f369c3711062ce1f2afc33644] Merge tag 'nios2_fi=
x_v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux
> >   git bisect new b6dad5178ceaf23f369c3711062ce1f2afc33644
> >   # status: waiting for good commit(s), bad commit known
> >   # old: [457391b0380335d5e9a5babdec90ac53928b23b4] Linux 6.3
> >   git bisect old 457391b0380335d5e9a5babdec90ac53928b23b4
> >   # new: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next=
-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> >   git bisect new 6e98b09da931a00bf4e0477d0fa52748bf28fcce
> >   # old: [088e0c188513b58a0056a488cf5b7df094a8a48a] Merge tag 'platform=
-drivers-x86-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86=
/platform-drivers-x86
> >   git bisect old 088e0c188513b58a0056a488cf5b7df094a8a48a
> >   # new: [ca288965801572fe41386560d4e6c5cc0e5cc56d] Merge tag 'wireless=
-next-2023-04-21' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless=
/wireless-next
> >   git bisect new ca288965801572fe41386560d4e6c5cc0e5cc56d
> >   # old: [d56417ad1133fc41752bb9fe37da7ae3187395a4] net: phy: smsc: cle=
ar edpd_enable if interrupt mode is used
> >   git bisect old d56417ad1133fc41752bb9fe37da7ae3187395a4
> >   # old: [c54876cd5961ce0f8e74807f79a6739cd6b35ddf] net/sched: pass net=
link extack to mqprio and taprio offload
> >   git bisect old c54876cd5961ce0f8e74807f79a6739cd6b35ddf
> >   # new: [3288ee5844b74cebb94ed15bc9b5b9d3223ae038] Merge ath-next from=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
> >   git bisect new 3288ee5844b74cebb94ed15bc9b5b9d3223ae038
> >   # new: [d0b6f86fdbefa62fd4ad2acd1aea6c45f9b518ba] wifi: mt76: mt7996:=
 let non-bufferable MMPDUs use correct hw queue
> >   git bisect new d0b6f86fdbefa62fd4ad2acd1aea6c45f9b518ba
> >   # new: [a0e97ae3f3320a246a79db7372fc23a38556014e] wifi: rtw89: add ie=
ee80211::remain_on_channel ops
> >   git bisect new a0e97ae3f3320a246a79db7372fc23a38556014e
> >   # new: [d00800a289c9349bb659a698cbd7bc04521dc927] wifi: mac80211: add=
 flush_sta method
> >   git bisect new d00800a289c9349bb659a698cbd7bc04521dc927
> >   # old: [413be839bfca9a4f6b32b92807ecdc2c2c182d94] wifi: iwlwifi: add =
a validity check of queue_id in iwl_txq_reclaim
> >   git bisect old 413be839bfca9a4f6b32b92807ecdc2c2c182d94
> >   # old: [e305a408c5f9c8df06a58e09a23375fd257f081c] wifi: iwlwifi: mvm:=
 move function sequence
> >   git bisect old e305a408c5f9c8df06a58e09a23375fd257f081c
> >   # new: [217f3c52f00d3419ecdd38a99a7eceecb11679b2] wifi: iwlwifi: mvm:=
 don't set CHECKSUM_COMPLETE for unsupported protocols
> >   git bisect new 217f3c52f00d3419ecdd38a99a7eceecb11679b2
> >   # new: [5caa82529eabff044c5f3eb254f3a7ff00e9170d] wifi: iwlwifi: Upda=
te configurations for Bnj-a0 and specific rf devices
> >   git bisect new 5caa82529eabff044c5f3eb254f3a7ff00e9170d
> >   # new: [d2ccc5c1526396aef5196e4dd2ec8538994e5072] wifi: iwlwifi: Upda=
te init sequence if tx diversity supported
> >   git bisect new d2ccc5c1526396aef5196e4dd2ec8538994e5072
> >   # first new commit: [d2ccc5c1526396aef5196e4dd2ec8538994e5072] wifi: =
iwlwifi: Update init sequence if tx diversity supported
> >
> >
> >>
> >> I then noticed that firmwares 75-77 are available and that there were =
recent changes
> >> to the iwlwifi module that increased IWL_22000_UCODE_API_MAX, so I gav=
e it a go,
> >> and built the kernel at ae8373a5add4ea39f032563cf12a02946d1e3546 and n=
ow firmware 77
> >> is loaded, and that seems to work, at least I did not notice any issue=
s so far.
> >>
> >> The full logs and other information about the laptop can be found here=
[0].
> >>
> >>
> >> Regards,
> >> Barnab=C3=A1s P=C5=91cze
> >>
> >>
> >> [0]: https://linux-hardware.org/?probe=3D43069955ee
