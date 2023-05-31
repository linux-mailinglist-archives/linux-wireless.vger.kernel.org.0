Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605FB718566
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjEaO5p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 10:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjEaO5m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 10:57:42 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C0C0
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 07:57:39 -0700 (PDT)
Date:   Wed, 31 May 2023 14:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685545057; x=1685804257;
        bh=8zTj/82OxDUBg5xoeFOTRsmD34cezYNZytzZOZeFQIs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cIeVJp1DomA3t4ayiCAh8UoMJV0YEyi6Q6qcdxXCt+ZURDEEIgaai6/URhVIDI4aI
         FS6hd6+FBaKe2rkqgb5G6XdtEGJEMJomgXsEyuj3gcvu38TqAA2xceUv49p6PBWGCh
         Hvk8GwVdNuj3X/IgvIGeVciIhBV8VXbzCo1wMCPRl+VNpMonWrt3SCObINQUrTTce9
         fcnL2Wv8zBvD51tjN6T5n99j5wiBSJx4oMtWbj6ofVC7eV14KU3Gv71Ht+M92v0V/C
         HsfOVnk30lEWQvwRWRobWmfByDYVLavrLVXxYfruLqkFb9I5LKLXSDnHBQtqIFoOIG
         xM3R4jRTnHBTA==
To:     Bagas Sanjaya <bagasdotme@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: Re: iwlwifi: AX201 misdetected as AX101
Message-ID: <tt8XGPkozS94lVKC4a5DnjtjLgrhAfI6hltVj5L7wphtw6673aYz5tbQPSNOEI3isryQCqQd2u_kS4LFOYspd9NSCfj5wsSYBNK_x4PD_pA=@protonmail.com>
In-Reply-To: <ZHdSrGmyN-TjYxEO@debian.me>
References: <gAwMzXEPlQZUgbc6n3yYY2soROKl4-D_JfWwoHW8CMx-LDkDEeAlwcyjOMy767W3eEVxS-e7oEihVh1PNHT-_iznSKneJjW0vu0PN7aQ9K8=@protonmail.com> <ZHdSrGmyN-TjYxEO@debian.me>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi


2023. m=C3=A1jus 31., szerda 15:59 keltez=C3=A9ssel, Bagas Sanjaya <bagasdo=
tme@gmail.com> =C3=ADrta:

> On Fri, May 26, 2023 at 05:55:48PM +0000, Barnab=C3=A1s P=C5=91cze wrote:
> > Hi all,
> >
> > I have an Acer Aspire A315-58 laptop[0], which, according to lspci has =
the following intel wireless chip:
> >
> >    Device:=0900:14.3
> >     Class:=09Network controller [0280]
> >    Vendor:=09Intel Corporation [8086]
> >    Device:=09Wi-Fi 6 AX201 [a0f0]
> >   SVendor:=09Intel Corporation [8086]
> >   SDevice:=09Wi-Fi 6 AX201 [0244]
> >       Rev:=0920
> >    ProgIf:=0900
> >    Driver:=09iwlwifi
> >    Module:=09iwlwifi
> >
> > However, in the kernel message buffer, the following message is written=
:
> >
> >   [    3.633490] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101,=
 REV=3D0x351
> >
> > Also, this chip did not work with the 6.3.3 Arch Linux kernel, the driv=
er loaded the
> > `QuZ-a0-hr-b0-74.ucode` firmware:
> >
> >   [    6.516505] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigge=
r 13 fired (delay=3D0ms).
> >   [    6.517615] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> >   [    6.517616] iwlwifi 0000:00:14.3: Transport status: 0x0000004A, va=
lid: 6
> >   [    6.517617] iwlwifi 0000:00:14.3: Loaded firmware version: 74.a5e9=
588b.0 QuZ-a0-hr-b0-74.ucode
> >   [    6.517619] iwlwifi 0000:00:14.3: 0x00000084 | NMI_INTERRUPT_UNKNO=
WN
> >   ...
> >   [    6.861510] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
> >
> >
> > I then noticed that firmwares 75-77 are available and that there were r=
ecent changes
> > to the iwlwifi module that increased IWL_22000_UCODE_API_MAX, so I gave=
 it a go,
> > and built the kernel at ae8373a5add4ea39f032563cf12a02946d1e3546 and no=
w firmware 77
> > is loaded, and that seems to work, at least I did not notice any issues=
 so far.
>
> Does 6.3.x work with your v77 firmware? 6.4-rc4 with previous v74 firmwar=
e?
>
> Seems like moving all parts at once here, hence I asked above to
> isolate possible reason why your above case works.

      |  v74       v77
------+----------------
6.3.3 | crash      n/a
6.3.5 | crash      n/a
git   |   ok        ok

(git ~ commit ae8373a5add4ea39f032563cf12a02946d1e3546)
(n/a ~ the driver does not support the firmware, i.e. IWL_22000_UCODE_API_M=
AX is too low)

So it appears that some commits might need to be backported for it work.

But every time it is detected as an AX101. I am more concerned about the mi=
sdetection.
Who is mistaken? lspci or iwlwifi? What are the potential consequences?


> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
