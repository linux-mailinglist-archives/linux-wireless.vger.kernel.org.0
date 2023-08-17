Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B177F4D8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350177AbjHQLPa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 07:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350206AbjHQLPW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 07:15:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4132D71
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IYxrqtsKA9dKJqqqz/fFTZrzX3qJxLM9OdKFr+jqdRM=;
        t=1692270921; x=1693480521; b=u9lEhbvKMoX8JiLTtTFMxOzyJwUGJ/bvU4tS9PcbwJgqtRj
        yaLEWm6tzf11XevhMUkEaRbLid/NQCW9wUScaWdp724aUt9Q2k+m40euRgh74od0Oz4Oqew7jZi01
        No5sHC/L3jdVosdCcfpdFBR90Y3EZ/GoRSBA1N3OwtSmwDEGozdprZQ97LMz3UZ7rzj9vE7S7Nvvx
        8MExSq9tbad9cVOq8ae080TaYfqTtajIicQhGCUA/tMHOolgv/jYptvTgn6duUK0KWXg9y0SNXXho
        Nuu7RD0+HYB9Jds+pdaFpbVrED8+GySNpvgXOzd1fasbMbdpD0qT7svVUHALqbyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWayC-00CpU3-2d;
        Thu, 17 Aug 2023 13:15:17 +0200
Message-ID: <0cfced7eae055fe0f0831b830af16b4d19dabaab.camel@sipsolutions.net>
Subject: Re: WARNING in __ieee80211_beacon_get
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com>,
        linux-wireless@vger.kernel.org, ramonreisfontes@gmail.com,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 17 Aug 2023 13:15:15 +0200
In-Reply-To: <3e34b44f06a7b21a6148bec8750ebc3d4e78b284.camel@sipsolutions.net>
References: <000000000000bf21d705b0e8674c@google.com>
         <4d51d5ec9f1a86b099900934661e1bbdefa269c7.camel@sipsolutions.net>
         <CANp29Y7MS5q=HVRuz-eXx4=9FxpuFJr3GkikG6MrKegxH6cO2A@mail.gmail.com>
         <bd2427a1c4ea30682c45c22c5f452e3dd8e674fb.camel@sipsolutions.net>
         <CANp29Y7TVNRFpcN1qSSurwWAtbBn90z_eUet3UdOcdDdUZ7zrg@mail.gmail.com>
         <3e34b44f06a7b21a6148bec8750ebc3d4e78b284.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-16 at 23:04 +0200, Johannes Berg wrote:
> Then I had to leave for a while so I only got to try it now, and indeed
> I can reproduce it with a kernel built/booted that way, so I can make
> changes for debugging.

But wow, this is complicated, even creating the same interface names in
different network namespaces ...

This is what I got from debug:

[   49.036423][    C0] [ffff88801a9c1d00] wlan1: __ieee80211_beacon_update_=
cntdwn:5010: counter in ffff88801cd6d800 now 1
[   49.040155][    C0] [ffff88801a9c1d00] wlan1: ieee80211_csa_finish:3589:=
 queue csa_finalize_work

That's fine, what it should be - although I don't see why there are 4ms
between those two lines.

[   49.042665][    C1] [ffff88804ad0ba00] wlan1: __ieee80211_beacon_get:541=
5

unrelated wlan1 in a different network namespaces (the [pointer] is the
network namespace pointer). I'll skip these for the rest of the log.

[   49.082269][   T11] [ffff88801a9c1d00] wlan1: ieee80211_csa_finalize_wor=
k:3732
[   49.084809][   T11] [ffff88801a9c1d00] wlan1: ieee80211_csa_finalize_wor=
k:3740
[   49.086646][   T11] [ffff88801a9c1d00] wlan1: ieee80211_csa_finalize_wor=
k:3744
[   49.088336][   T11] [ffff88801a9c1d00] wlan1: ieee80211_csa_finalize:371=
7
[   49.089932][   T11] [ffff88801a9c1d00] wlan1: __ieee80211_csa_finalize:3=
651
[   49.091642][   T11] [ffff88801a9c1d00] wlan1: __ieee80211_csa_finalize:3=
670
[   49.093661][   T11] [ffff88801a9c1d00] wlan1: __ieee80211_csa_finalize:3=
679
[   49.097030][   T11] [ffff88801a9c1d00] wlan1: ieee80211_link_chanctx_res=
ervation_complete:1211: queue csa_finalize_work

That continues running as it should, but ... it took forever! By now,
just to go through a few function calls, it took 57ms?

[   49.130990][   T11] [ffff88801a9c1d00] wlan1: ieee80211_csa_finalize_wor=
k:3732
[   49.132892][   T11] [ffff88801a9c1d00] wlan1: ieee80211_csa_finalize_wor=
k:3740

and another 33ms to actually start the worker again

[   49.137404][    C0] [ffff88801a9c1d00] wlan1: __ieee80211_beacon_get:541=
5
[   49.137462][    C1] [ffff88804ad09d00] wlan1: ieee80211_beacon_cntdwn_is=
_complete:5111
[   49.138897][    C0] [ffff88801a9c1d00] wlan1: __ieee80211_beacon_update_=
cntdwn:5010: counter in ffff88801cd6d800 now 0
[   49.139480][    C0] ------------[ cut here ]------------
[   49.142567][    C0] WARNING: CPU: 0 PID: 5215 at net/mac80211/tx.c:5013 =
__ieee80211_beacon_get+0x1604/0x1a10

And the worker doesn't finish fast enough, so we get to 0, warn and
crash.

So what I said before about scheduling still seems like it could be the
case.

I'm not sure what we could do here - we can't delay the beacon, so if
the update work didn't run ... and in general, I think we _do_ want this
reported to see that something is broken, just that maybe with the
single-core setup (two threads) and so much happening in the system, we
don't get this running fast enough?

Maybe we need to make our workqueue high priority? Testing ... no,
doesn't even help.

So not sure. Seems in reality this won't really happen since you have
usually 100ms or so to execute the thing, and only a single (or handful
maybe) interface(s).

johannes
