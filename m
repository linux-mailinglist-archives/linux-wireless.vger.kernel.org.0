Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB577E2C5
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbjHPNkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 09:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245615AbjHPNjy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF16326A5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:39:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so74315e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692193191; x=1692797991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLqmE7Lh8pfz24theeIUBcxQnCYx5636CwHKivlGS60=;
        b=Gcbhlvx0IrtNwQjI+VJv8TD5pPdyOevECqsMiEMAAU3dalPtFwuzl1bD/Icomo6OD/
         T/7cGUw/DLfDnL7MI/+5IHPxYqMZZefLrzIB/x4jDpVRmyyLQYNvggEznVkveUuVqPVM
         oN4TLya5yGjOjqGrgw5oDnw3QqMa0lu4T/kVvtD1SrCl3pa/gU4/bPbRWwKXDxoxIuvh
         2wee0z1HTJpbyKlfNBETsQRiu52kbnnJy8D4EQEANTesx1tnz3RlM1ls71OzenOUNsqC
         iCq3K+TwzBJDDRAOWb6U8n565fcfi52t1/UDsbk2qLrCpSPJ3E+06O3qtaEn5slp/FGg
         KpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193191; x=1692797991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLqmE7Lh8pfz24theeIUBcxQnCYx5636CwHKivlGS60=;
        b=lON0QmwBQZApImmUvPWJpVb2XaVSuhQkiKp81w2olOY7+vQfQc+hLPf8GwE2owbTH5
         0Qc1unmg1vLswCuglHziSA0Uvgvr4Qf6uFeNhvaSm2PqIE8ae2j/ffu0aUBLHD7mpcQD
         fikwVzKROLeS61BV0jmv/JDTFThjHB1ZCTAMs681IKKv7KwXUi58TICrNilADc4ZK1UF
         psEykW0/x96vxd5GB7UJuRWeTFNF3DeZFtA5TPrOG8aTy6UtPDcD2Awr48f1lJNfChUj
         M/mSXYR4Aheo9RkXZWbR3vqrBVDdD+7Ynf4xmfrBkeSAbBiYeil/kVtEfQfKnhNdZlp1
         ItPQ==
X-Gm-Message-State: AOJu0YwqJKUjYD8BwAM+RW2X7n/cuhtSTkEYCw19F0E9EEPOanEaAw0I
        XypYkbeocujwaVTW4XvEHgjGCE8f+hIp96v7T8dKqw==
X-Google-Smtp-Source: AGHT+IEaOVNnJWbR+QVJOlrbALJU2daBAKAKFShaof6aJk+i1cDT1DpV0D29tRDPZEP5aNe50G0M/RG+EQIOPpFjEvo=
X-Received: by 2002:a05:600c:35c7:b0:3fd:e15:41e3 with SMTP id
 r7-20020a05600c35c700b003fd0e1541e3mr113776wmq.2.1692193191331; Wed, 16 Aug
 2023 06:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bf21d705b0e8674c@google.com> <4d51d5ec9f1a86b099900934661e1bbdefa269c7.camel@sipsolutions.net>
In-Reply-To: <4d51d5ec9f1a86b099900934661e1bbdefa269c7.camel@sipsolutions.net>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 16 Aug 2023 15:39:39 +0200
Message-ID: <CANp29Y7MS5q=HVRuz-eXx4=9FxpuFJr3GkikG6MrKegxH6cO2A@mail.gmail.com>
Subject: Re: WARNING in __ieee80211_beacon_get
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     syzbot <syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com>,
        linux-wireless@vger.kernel.org, ramonreisfontes@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 16, 2023 at 10:09=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi,
>
> Yeah, I know this is old ... still happening though, so I've been
> looking at it a bit.
>
> > The issue was bisected to:
> >
> > commit 7dfd8ac327301f302b03072066c66eb32578e940
> > Author: Ramon Fontes <ramonreisfontes@gmail.com>
> > Date:   Thu Oct 10 18:13:07 2019 +0000
> >
> >     mac80211_hwsim: add support for OCB
>
> I'm not sure that make sense, FWIW. There isn't even any OCB? The syz
> script just contains a channel switch command.
>
> > WARNING: CPU: 1 PID: 6900 at net/mac80211/tx.c:4875 __ieee80211_beacon_=
get+0xb59/0x1aa0 net/mac80211/tx.c:4875
>
> I also can't reproduce this though.

Did you try to run the kernel attached in the assets?
https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#run-a=
-c-reproducer

I've just followed the instructions from there and the C repro did
crash the kernel in ~20 seconds:

[   56.809692][    C1] ------------[ cut here ]------------
[   56.810656][    C1] WARNING: CPU: 1 PID: 5358 at
net/mac80211/tx.c:5011 __ieee80211_beacon_get+0x1495/0x16e0

The disk image I used:
https://storage.googleapis.com/syzbot-assets/c18b40f6d56d/disk-cacc6e22.raw=
.xz
The C repro:
https://syzkaller.appspot.com/text?tag=3DReproC&x=3D135c0c63a80000

>
> Is there a chance that somehow there's some scheduling problem and
> workers aren't being scheduled, and then ieee80211_csa_finalize_work()
> doesn't work between the last pre-CSA and first post-CSA beacon?
>
> I _can_ reproduce this if I just make ieee80211_csa_finalize_work() do
> nothing instead of doing what it should, hence the question.
>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/4d51d5ec9f1a86b099900934661e1bbdefa269c7.camel%40sipsoluti=
ons.net.
