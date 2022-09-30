Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6F5F07CD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiI3Jl6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 05:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiI3Jl5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 05:41:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF817BC91D
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=x98eaU4yEJxd/BgfiNKV6VqqgLBTgEGKnVS49Daop1M=;
        t=1664530915; x=1665740515; b=RmyCXJ0Aw7Xb+cI+Oh2K0/UKXfbRnLmCl7LgAYMAVj7p0zG
        tDhCXM6O3rGuf9QKskCzqtjRBZyfzR1TMZ7GDFULpF61wcK1ZfKz7UNFOKIhIUNXeANGJsyX7Xb6m
        hWiIefiZXwdt7xT2U3VcLjH2NNUdlIqgGIi+FrDs1+nwZJrp6b9ZoWU1WnYHuI6GZdX6P8pBQ/nBY
        EC92DPTl1ZBNXGtxSTRARtEEg/PWx4DaXqJtYWGL7C3P3w/m1cN8Hh8M31I1n0QZ2t757HQa8WaPY
        2IXsZL3SLAVL9wLcL2D9ycI5cFi9bGmRQgPKJ/T8nTVat/KKU5kC+5E6Nk2EyQHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oeCWn-00BtM7-18;
        Fri, 30 Sep 2022 11:41:53 +0200
Message-ID: <98c184b456e0dc1b0bb59f2e479e1739f4dbed79.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Fri, 30 Sep 2022 11:41:52 +0200
In-Reply-To: <79161904-1e56-3046-b381-705e4af11e84@wetzel-home.de>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
         <da810136f6cf0608167cc8297ce73d11b83974d6.camel@sipsolutions.net>
         <79161904-1e56-3046-b381-705e4af11e84@wetzel-home.de>
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

On Fri, 2022-09-30 at 11:08 +0200, Alexander Wetzel wrote:
> On 29.09.22 22:40, Johannes Berg wrote:
> > Thanks for doing this!
> >=20
> > It's a bit bad timing right now, so I'll only have a chance to look at
> > this in the next couple of weeks, but that also doesn't matter that muc=
h
> > since 6.0 release is imminent (will likely be Sunday).
> >=20
>=20
> Thanks for the warning. I'll then send a v2 to correct skb_get_hash()=20
> handling in the next days.

I probably won't merge it much before ~2 weeks from now, so take your
time :)

> The general plan so far is, to move everything to iTXQ first and then=20
> see what we an throw out. I'll prepare a patch cleaning up that a bit=20
> more. Don't think that will be much at this stage, so maybe I just add=
=20
> that into the v2 of the patch...

No, separate patches are fine - was more wondering if you were planning
to do it, or if I should think about finding someone else ;-)

> I'm basically working with the plan you outlined some years ago:
> https://lore.kernel.org/linux-wireless/1507217947.2387.60.camel@sipsoluti=
ons.net/

:)
I can't even remember it that much, to be honest.

> It just turned out to be simpler to start with unifying the TX paths.

Makes sense.

Thanks!

johannes
