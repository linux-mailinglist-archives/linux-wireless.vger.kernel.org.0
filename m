Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4781677DBC5
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbjHPIJ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbjHPIJx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:09:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876C268F
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4TGVjZM+ugamDX5aj4K1PcIJTCREtD/yGzRx6ur7eVU=;
        t=1692173381; x=1693382981; b=fA6qr75qEsnQgjUEricXxFsX2Lo4ZRREb73kde8EzK4qlPc
        mXfWSG36cLa1cStt2ffwVYbHtG794BYIf+vAf8J8vz2ZndptiWgOL/1b29UtSAcAstyZ/cw7HfWQc
        P8gq/ICF+FBwmygIsPgMWSDmiCm4nalYy4iF3iOLqInPzc61X3OBZqAT3Dq2zBZYJDx/N8p4D5x1K
        rUOzP+dINImZSdl1Ns7zJRLon8wlhqVnRfW+FrJ/gS50j7dd/9ppwNEPJ5jpyCZwfq5ioU8dnJBZu
        EoYC2n3gFqD+8sd6GXDiCrx7RiQi/FDgA3V44hZ3oa1Kakoa4iXQvoz7ocVOVPyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWBb1-00Abo6-0e;
        Wed, 16 Aug 2023 10:09:39 +0200
Message-ID: <4d51d5ec9f1a86b099900934661e1bbdefa269c7.camel@sipsolutions.net>
Subject: Re: WARNING in __ieee80211_beacon_get
From:   Johannes Berg <johannes@sipsolutions.net>
To:     syzbot <syzbot+18c783c5cf6a781e3e2c@syzkaller.appspotmail.com>,
        linux-wireless@vger.kernel.org, ramonreisfontes@gmail.com,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 16 Aug 2023 10:09:37 +0200
In-Reply-To: <000000000000bf21d705b0e8674c@google.com> (sfid-20201005_103824_554037_2DE34A31)
References: <000000000000bf21d705b0e8674c@google.com>
         (sfid-20201005_103824_554037_2DE34A31)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Yeah, I know this is old ... still happening though, so I've been
looking at it a bit.

> The issue was bisected to:
>=20
> commit 7dfd8ac327301f302b03072066c66eb32578e940
> Author: Ramon Fontes <ramonreisfontes@gmail.com>
> Date:   Thu Oct 10 18:13:07 2019 +0000
>=20
>     mac80211_hwsim: add support for OCB

I'm not sure that make sense, FWIW. There isn't even any OCB? The syz
script just contains a channel switch command.

> WARNING: CPU: 1 PID: 6900 at net/mac80211/tx.c:4875 __ieee80211_beacon_ge=
t+0xb59/0x1aa0 net/mac80211/tx.c:4875

I also can't reproduce this though.

Is there a chance that somehow there's some scheduling problem and
workers aren't being scheduled, and then ieee80211_csa_finalize_work()
doesn't work between the last pre-CSA and first post-CSA beacon?

I _can_ reproduce this if I just make ieee80211_csa_finalize_work() do
nothing instead of doing what it should, hence the question.

johannes
