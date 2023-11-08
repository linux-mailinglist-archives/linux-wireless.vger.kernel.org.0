Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1A7E5B0C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 17:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKHQVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 11:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjKHQVk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 11:21:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE41FC8
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yo89hIGpsYEXZ9A+LUgrf3vGs3alPjPbPfbYz5nYKww=;
        t=1699460498; x=1700670098; b=WLyZ2xQQvfF1wSKPI/nYnBQLuxP02miIIgCnoES4pKRsIT0
        AOV+4MEe5Xo9vG+N2E0YQ5eh+GOpclrTaDidStghjrDLN3E6HvOmvrXN2p9ptv5t4XTW3TtbFTUik
        HTn2GX0CftNEqfzIo/ezIREFr6WmCia3ir2Rb9le4rG3w/HHntNKGAnb89MoVDA8t5qV3K6WfSsta
        5trxzxsNzuYHLqpL1BviCTa9ZLqav3Tae03SlWIGaeGtQ0hjkk8EB1CubBOBpeEr/jjuV2PQa8nvV
        9NWO/731aXtceWHFJ0hCpxPrFucusLcS5AFPv/ax9zRPac3nqIug9zGNCD1JS06g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0lJA-00000000c3S-1HuQ;
        Wed, 08 Nov 2023 17:21:36 +0100
Message-ID: <63879a52c28d0140730d8504889c3da17738fe2e.camel@sipsolutions.net>
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
Date:   Wed, 08 Nov 2023 17:21:35 +0100
In-Reply-To: <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
         <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
         <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
         <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-11-08 at 16:44 +0100, Johannes Berg wrote:
>=20
> > I have been running similar code for...like 15 years, and haven't seen =
this particular
> > deadlock before, so I think it is at least exacerbated by the locking c=
hanges.  Or maybe
> > I had particularly bad luck yesterday....
>=20
> Oh, it almost certainly did get at least worse or perhaps introduced by
> (a) moving everything to a single lock and (b) moving debugfs file
> removal under the lock.
>=20

FWIW, the debugfs remove was under lock before, but we didn't acquire
much locks in the debugfs itself (only sta mtx and only in aql write,
and that mutex isn't held in remove) ... So indeed it couldn't happen.

I added that to call into drivers with the wiphy mutex though, can't
really remove that, I think.

johannes
