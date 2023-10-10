Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4E7BFF8D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjJJOrf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 10:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjJJOrd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 10:47:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C46CC
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fVnY/vPKWuSe5iTNEB38fQy6nx0rgZg8LeS5g/9IyiE=;
        t=1696949252; x=1698158852; b=chj3g8td9MFUTqXyqdp4o/K2xHWulP+8RviHLMh+tk7NZZd
        VimgsDiZzrZsbfHqiG9tBTLlDrY+bPnfEvlaGJwXF8shv6dNEKCh6VFl8+Ys9HZCmHnUT8CxoA6Jz
        uznLIbL0r8OTB8+6vjYrV/uPdhu3ccnl/fkhScjRvXGnClcwRiorv0WoNDwHELqWBQNRIUU9HvK90
        3iFkR1X9otyWObZeZFNyfc7+Y2mVGqLkCNh7qSsrM3iwNlVnwPWTV3rZJVUfMvTOg9g7IONNG1dll
        C5t62oj2W+s3IMDLeNllbYw4EQdFZ049Mt3jjBVjKCMYgLN0HmwrIljZZ2Mi5QSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqE1B-00000000SUy-0mmc;
        Tue, 10 Oct 2023 16:47:29 +0200
Message-ID: <ac1f3d9b81dbca244bdc8262e9d2ee44220f78c1.camel@sipsolutions.net>
Subject: Re: removing OCB/WAVE/802.11p
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Rostislav Lisovy <lisovy@gmail.com>, chrisshen@skku.edu,
        bienaime@skku.edu, pauljeong@skku.edu,
        carloaugusto.grazia@unimore.it
Date:   Tue, 10 Oct 2023 16:47:28 +0200
In-Reply-To: <90fcfe15-de1b-4371-a316-574ac7a03eda@quicinc.com>
References: <ec69aa2722b07bffd6184d687861cc7e5ae9c1ef.camel@sipsolutions.net>
         <90fcfe15-de1b-4371-a316-574ac7a03eda@quicinc.com>
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

On Fri, 2023-10-06 at 16:15 -0700, Jeff Johnson wrote:
> On 9/28/2023 8:38 AM, Johannes Berg wrote:
> > Hi,
> >=20
> > CC'ing lots of people who touched or used this in the past in hopes of
> > triggering some reaction somewhere ...
> >=20
> > I'm trying to do some cleanup in IBSS and following that some other
> > cleanups wrt. station allocation etc., but OCB pretty much copied the
> > IBSS code in this area, and I don't know how to use it, how to test it,
> > who's using it, if anyone is actually maintaining it, etc.
> >=20
> > Also, it only ever got implemented for ath9k, so I'm guessing it's not
> > getting any traction in new products/devices.
> >=20
> > So I'm probably going to remove it.
> >=20
> > Any takers to help maintain it instead?
>=20
> Do you have an estimate on the footprint of this logic? Do you have a=20
> proposed patch?

Neither. It's actually not really big, and I was just putting out
feelers.

The particular reason was that we had a patch a long time back:
https://patchwork.kernel.org/project/linux-wireless/patch/20180216161301.29=
339-3-luca@coelho.fi/

which was rightfully rejected. But I was looking at it recently again,
thinking I should revive it (and I may still), and then I thought if I
do that, I can remove the gfp_t argument to sta_info_alloc(), but OCB
identically copied this code ...

Now, I suppose OCB doesn't have much in the way of station
discovery/connection process (like auth) since that's kind of the
_point_, but maybe doing something else would work here?

> In addition to ath9k I know there is out-of-tree usage of this=20
> functionality, and I'm trying to see if I can find someone to maintain=
=20
> this. But how would that actually work?

Well for starters it'd be nice to actually have some tests with hwsim, I
guess, and someone who knows how to use it, how to test things if there
are relevant changes, etc.

johannes
