Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAC5FF5E5
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Oct 2022 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJNV7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 17:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNV7p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 17:59:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958575FF8
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DxZkuGrBmdeoGvN3qertur75O6+jLRIfMPoSkeNImjc=;
        t=1665784781; x=1666994381; b=BP4NDt3NqqJUbo4XO4+GqFTroBAwTY3cT6Bov2aOZwZqbnz
        rkBrPd5AFKtiuwd3RGkKm3pZrRakRqcgyFo2exQE+NRbr6Un9rn37dPDCvlgsXtkVeDo30GHaqaZ8
        DBnvhqRBFBD8pWRvHWseg5YRZ/+wLQlfkLPtH5cI4/FloT6JNT3QJEwMbdQqX+zPaxxawdFkw51ne
        FD93ZsODFPQlHAPmy66WZ06ECWyo4nTQFgRKthAhNJN1vMRbaGeICo1yC/RBtL82pOUOYsgJR77OQ
        fy6B/hl30aK2V52aAN/cIjM3FR8JK3U5z7nqhiBkNYkkRQuRfwGel5e3QQZefONQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ojSiQ-006mpT-0K;
        Fri, 14 Oct 2022 23:59:38 +0200
Message-ID: <a1e799946f166d6c7ca9b8dd85835c023ebf29c7.camel@sipsolutions.net>
Subject: Re: Splat from net/wireless/wext-core.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 14 Oct 2022 23:59:33 +0200
In-Reply-To: <41d85c23-2735-ed7a-21b9-36b9f7be5439@lwfinger.net>
References: <988d4c5c-a9a4-2f16-aa3c-e15778c04d46@lwfinger.net>
         <5da63402ee109ab6df3e0cdbaab3ddaa2156ab8c.camel@sipsolutions.net>
         <41d85c23-2735-ed7a-21b9-36b9f7be5439@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-10-14 at 15:16 -0500, Larry Finger wrote:
> On 10/14/22 11:57, Johannes Berg wrote:
> > On Fri, 2022-10-14 at 11:49 -0500, Larry Finger wrote:
> > > Hi,
> > >=20
> > > With a recent pull from kernel mainline, I am getting a log splat sho=
wn below:
> > >=20
> > > [   29.369446] ------------[ cut here ]------------
> > > [   29.369447] memcpy: detected field-spanning write (size 16) of sin=
gle field
> > > "&compat_event->pointer" at net/wireless/wext-core.c:623 (size 4)
> >=20
> >=20
> > Yeah fixed by commit e3e6e1d16a4c ("wifi: wext: use flex array
> > destination for memcpy()") I think?
>=20
> Sorry for the noise. That commit was merged when I did a new pull on main=
line.=20

No worries!

> My log is clean now.
>=20

Good to hear, I haven't built a kernel in the right way so far to see
this :)

johannes
