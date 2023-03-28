Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A438F6CBA6E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjC1JYG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 05:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjC1JYE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 05:24:04 -0400
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD305FF2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 02:24:01 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Pm44Z4HtyzMqKxP
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 11:23:58 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Pm44Z2BbyzMqmNM
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 11:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1679995438; bh=4ba78suVH5BCk/pT1Aw/f9HveXrg0Z+HKhSJMcyxDYM=;
        h=Date:Subject:From:Reply-To:To:References:In-Reply-To:From;
        b=4XqLSJejLYcvX77xD7g9f8XwPFgbXz8du99HKccdtLqxPfT4MIJLl2ohFqDecgqTB
         nEqAHrqP3WcTnvg14cMCbHUaleAgAyH0nl/DvrS8cxYkYZEcjNFNoZTGfmOO34aTzb
         XateHQ4Ag4/YCwsgIh5Kw9gjqVcnqKO6Ed3Jparg=
Message-ID: <943d0ea35c97f2e8076f127dbb43f5bf@mail.infomaniak.com>
Date:   Tue, 28 Mar 2023 11:23:54 +0200
Subject: Re: wifi: mt76: mt7915e: mt7916 monitor ampdu id is invalid
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6ImFQWitJYXdBWTRxK1pVNk5TQmcvMXc9PSIsInZhbHVlIjoiT2pGd0liVXJjNWRYRjlXeUdyT3N2Zz09IiwibWFjIjoiMjFjYTBkMzNlZDFhMWI3MWUyNTQ1MmViZjMxMWI0ZjIzMGQxNGI5ZDQyYWU0ZmNiMDZiNjczZThlZTgzZGNmNSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IjR6dTZ4eTh0MGZQREtwdVE2cTJlZHc9PSIsInZhbHVlIjoiRFZUeG1LUk91d0FsZU5vcU1sUUZVQT09IiwibWFjIjoiM2E4MTIxYTQwOWViMjc4Y2YyMWI4OGRkYjIwNGY0M2FkN2I4ZDY1ZWY4MGIzOWYwNzM3NWY4OTZmYTViYmM1MCIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.472)
References: <c7fc198f2a4ed9c1345a05c0397a9fc5@mail.infomaniak.com>
 <2f3ea768bc27a26918a4e8a4363b8c97@mail.infomaniak.com>
In-Reply-To: <2f3ea768bc27a26918a4e8a4363b8c97@mail.infomaniak.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>  Hi all,
>=20
> Using a mt7916 in monitor mode, I see that the AMPDU reference number is =
incremented for each part of a single AMPDU. Instead it should be constant,=
 and ideally, the last subframe field should be set on the last part of the=
 AMPDU. Capturing the same traffic with an intel AX200 show each parts of t=
he AMPDU with the same id as expected.
>=20
> This issue is still present using kernel from tag wireless-testing-2023-0=
3-16.
>=20
> How can I be of any assist investigating and fixing this issue?
>=20
> Thanks,
> Florian

Replying to myself, it look like a firmware issue.=20

I dived a bit in the code. Toying with the code snippet below (from mt7915/=
mac.c), show that the firmware actually does something incorrect. It never =
increment the ampu_ref. This would be okay because the code below increment=
 the ampdu_ref when the timestamp are the same for all parts of the ampdu, =
unfortunately, the firmware put a different timestamp to each part of the A=
MPDU. Because of those two conditions, the ampdu_ref is simply incremented =
by the driver for every single packet even when parts of the same AMPDU.

/* all subframes of an A-MPDU have the same timestamp */
if (phy->rx_ampdu_ts !=3D status->timestamp) {
=09dev_warn(dev->mt76.dev, "AMPDU Timestamp diff: ref:%d t1:%d t2:%d\n",
=09=09=09 phy->ampdu_ref, phy->rx_ampdu_ts, status->timestamp);
=09if (!++phy->ampdu_ref)
=09=09phy->ampdu_ref++;
}

I guess I could maybe do some hack around this myself finding some relation=
 between timestamp of the ampdu, computing the end time of the previous par=
t of the AMPDU, but this would be really hacky and complicated for a workar=
ound to what look like a firmware issue.

Is there any mediatek dev around with access to firmware sources to help wi=
th this?

Thanks,
Florian
