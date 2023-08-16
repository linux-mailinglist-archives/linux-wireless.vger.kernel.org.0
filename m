Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950177E32B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbjHPOCW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbjHPOB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 10:01:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E7926B2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HSDnkl9WHHOU9lJLom8JbLEWFovKI9ZwfdFp3laa00k=;
        t=1692194518; x=1693404118; b=ta62D5VpZBxJ0dszyvMdtChQar0VeUZZS6bZKfpsfkMZ5II
        ORFwPExbu9xXOdFxH2LDzYUX8QqoiH/FhqU67QPJnhKd+yme0B1pCcR67zjq/UJTZPUw0A8BPB+R5
        vkTyvt6doJk+COeE80qZjESRMX3UGqOriiOdskYtAK4ZPs0Wj3q1cQSlXs5J5CAVPeluFTKgTjM+v
        0Ityj55l+55bIRMp6VGljqNbau5KsIQwWJKZGWAgHSacHS6Y3/3P5ktcI07dbMCItHuJiUi60R32c
        WYQXgxFGE2t8EH37ytu0IDAzosM5p/mzhh5rBpsSk6LKTkDxomdEdON95znmqQfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWH5u-00Azyy-32;
        Wed, 16 Aug 2023 16:01:55 +0200
Message-ID: <bd2427a1c4ea30682c45c22c5f452e3dd8e674fb.camel@sipsolutions.net>
Subject: Re: WARNING in __ieee80211_beacon_get
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com>,
        linux-wireless@vger.kernel.org, ramonreisfontes@gmail.com,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 16 Aug 2023 16:01:53 +0200
In-Reply-To: <CANp29Y7MS5q=HVRuz-eXx4=9FxpuFJr3GkikG6MrKegxH6cO2A@mail.gmail.com>
References: <000000000000bf21d705b0e8674c@google.com>
         <4d51d5ec9f1a86b099900934661e1bbdefa269c7.camel@sipsolutions.net>
         <CANp29Y7MS5q=HVRuz-eXx4=9FxpuFJr3GkikG6MrKegxH6cO2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-16 at 15:39 +0200, Aleksandr Nogikh wrote:
> On Wed, Aug 16, 2023 at 10:09=E2=80=AFAM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >=20
> > Hi,
> >=20
> > Yeah, I know this is old ... still happening though, so I've been
> > looking at it a bit.
> >=20
> > > The issue was bisected to:
> > >=20
> > > commit 7dfd8ac327301f302b03072066c66eb32578e940
> > > Author: Ramon Fontes <ramonreisfontes@gmail.com>
> > > Date:   Thu Oct 10 18:13:07 2019 +0000
> > >=20
> > >     mac80211_hwsim: add support for OCB
> >=20
> > I'm not sure that make sense, FWIW. There isn't even any OCB? The syz
> > script just contains a channel switch command.
> >=20
> > > WARNING: CPU: 1 PID: 6900 at net/mac80211/tx.c:4875 __ieee80211_beaco=
n_get+0xb59/0x1aa0 net/mac80211/tx.c:4875
> >=20
> > I also can't reproduce this though.
>=20
> Did you try to run the kernel attached in the assets?
> https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#run=
-a-c-reproducer
>=20
> I've just followed the instructions from there and the C repro did
> crash the kernel in ~20 seconds:
>=20
> [   56.809692][    C1] ------------[ cut here ]------------
> [   56.810656][    C1] WARNING: CPU: 1 PID: 5358 at
> net/mac80211/tx.c:5011 __ieee80211_beacon_get+0x1495/0x16e0
>=20

To be fair, I didn't, I figured the reproducer was simple enough to just
have a go at it with my own test infra.

Is there an easy way to rebuild the kernel for it?

johannes
