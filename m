Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429C6EC2F5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 00:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDWWjE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Apr 2023 18:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWWjC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Apr 2023 18:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B822AE6E
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 15:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BE3D61372
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 22:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B6FC433EF;
        Sun, 23 Apr 2023 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682289540;
        bh=H1tU+nDuBSDu9Hz8FWKRs7NfOSak2YZ5duCBuITkF1o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TpD2IGP8uIbI09mEbGnmVM2wA0fzntNFAllF9ynuYOL8IgnmVZHwUp9urQomRp7rF
         NsS552qQN2owOIONB0ObhCromJCgDu3JkLYiU1lfgXVuoat4dXRTf20lN1r06DecnT
         wg4yB66K2szfejnSCBU0Jgw05/0+fT7N3A33CAXW93/WxgEwUorpvzUbUCuFRcyj8S
         QYkMf9jPFRMsD5Gv8Lz1v4W7GMsmpyF5//Z1ruEwuYdbaehl3TIazzL6gAUf4rton7
         X0VZiHKd7+DAUMgEA0HoLxJZF7luxErVll4Q+z2HLN/MWo41EFVouv9D8vX7N66ZfE
         KrdIKdy1O4WgQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0CB63AA9B72; Mon, 24 Apr 2023 00:38:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "mh+debian-user-german@zugschlus.de" 
        <mh+debian-user-german@zugschlus.de>,
        "exp-311223@news.muster.net" <exp-311223@news.muster.net>,
        "tychokirchner@gmail.com" <tychokirchner@gmail.com>,
        "rene@debian.org" <rene@debian.org>,
        "Juergen.bausa@online.de" <Juergen.bausa@online.de>,
        "sebastian.suchanek@gmx.de" <sebastian.suchanek@gmx.de>
Subject: Re: iwlwifi in German ICE4 trains
In-Reply-To: <c0153e5dd0459d351807002df7cef9eb30b04e86.camel@intel.com>
References: <20230423085510.xpmcuzfhzqa4dyhs@pengutronix.de>
 <c0153e5dd0459d351807002df7cef9eb30b04e86.camel@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 24 Apr 2023 00:38:58 +0200
Message-ID: <87edoakyv1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Greenman, Gregory" <gregory.greenman@intel.com> writes:

> On Sun, 2023-04-23 at 10:55 +0200, Uwe Kleine-K=C3=B6nig wrote:
>> Hello Gregory,
>>=20
>> there is a thread on debian-user-german@lists.debian.org[1] about
>> broken wifi on Thinkpads when they are supposed to be connected to the
>> hotspots available in ICE4 trains. The mailing lists language is German
>> and the thread is long, so I sum up the problem:
>>=20
>> - It only affects the wifi equipment in ICE4 trains, the older ones work
>> =C2=A0 fine.
>>=20
>> - Can be seen at least on
>> =C2=A0 - J=C3=BCrgen's laptop (Intel Corporation Wireless 8260 [8086:24f=
3] (rev 3a))
>> =C2=A0 - Marc's Thinkpad X260 (Intel Corporation Wireless 8260 [8086:24f=
3] (rev 3a))
>> =C2=A0 - Uwe's Thinkpad T460p (Intel Corporation Wireless 8260 [8086:24f=
3] (rev 3a))
>>=20
>> - Other Thinkpads with a Realtek-Chip doesn't show the problem
>>=20
>> - Works on puppy-Linux with 4.19.23, however Debian with 4.19.0-18 is
>> =C2=A0 also broken.
>>=20
>> - The OP provided a syslog dump at
>> =C2=A0 https://lists.debian.org/msgid-search/75ad7ff2-ef25-90cd-2cb3-1f4=
9f3e4909e@online.de
>>=20
>> =C2=A0 I don't reproduce it here, but the gist seems to be:
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Jun 23 15:44:53 lina ker=
nel: [ 1006.011129] wlp1s0: deauthenticated from 3c:51:0e:56:32:80 (Reason:=
 2=3DPREV_AUTH_NOT_VALID)
>>=20
>> - it seems to help to do:
>> =C2=A0 $ cat /etc/modprobe.d/iwlwifi.conf
>> =C2=A0 options iwlwifi 11n_disable=3D1 swcrypto=3D0 bt_coex_active=3D0 p=
ower_save=3D0
>> =C2=A0 options iwlmvm power_scheme=3D1
>> =C2=A0 options iwlwifi d0i3_disable=3D1
>> =C2=A0 options iwlwifi uapsd_disable=3D1
>> =C2=A0 options iwlwifi lar_disable=3D1
>>=20
>> I added all participants of said thread to Cc, in case I forgot
>> something relevant.
>>=20
>> Tomorrow I might have the opportunity to test and reproduce the problem
>> (I don't know if my train will be an ice4 or one of the older ones
>> though.)
>>=20
>> I wonder if there is something you want me to test. Without further
>> input I will try with the modprobe options and check for a minimal
>> subset of them that makes the problem disappear.
>>=20
>> Is there something I can do to make the problem better understandable
>> for someone who knows about the hardware? Or to find out the critical
>> detail about the wifi hotspot that triggers the problem?
>>=20
>> Best regards
>> Uwe
>>=20
>> [1] https://lists.debian.org/msgid-search/da8c1552-6bcb-14c3-0e86-abcb83=
5ec350@online.de
>>=20
>
> Hi Uwe,
>
> Based on the log, I can understand that it had successfully connected
> to the AP (supplicant management interface state: associating ->
> completed); then there're some DHCP errors and eventually the AP sends
> a deauth.

If it's DHCP failing it could be an issue with multicast traffic? I've
definitely seen multicast failing on busy networks because it is set to
too low a rate and gets overwhelmed, which leads to DHCP (and ARP)
failures while unicast traffic works fine.

It's probably not (only) a network issue if it works fine with other
drivers, but maybe there's some kind of interaction between the driver
and multicast? Just a thought :)

-Toke
