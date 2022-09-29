Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780C55EFEC7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiI2UlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiI2UlH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 16:41:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6C482766
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=r2A2qFAPaVr0x0VEmz7urn30WMwsOGyu18dU5FkOp6E=;
        t=1664484060; x=1665693660; b=x+2tA6xeTFGohhc5ZE+qIANw84zk07+d1BMYUieDor7S5tn
        rFE49mij8Qq6gDZLSku/BzDbyUgzofrWMBNXf17I42eC8zAo2s2QTz1ctXTTu8fXlnzyF53sm67vn
        xLN7Vp3yOZgiHlK4bQj+eJ/wdp6DxF34LFIBuKPbMFPqe3ZaceKdrR4xl8QJNvDyIzLf12dFb11m2
        KJZWpvFgWmtOZMFb987Cp1x0YaIOqgWUKZ7K4iLGWKSwq7hezgKe04bPjroW1y/ktqQrrPnJERH50
        UjkLyyS73KWNDRpTLNPGQBvAljEy/9AYUb8iY3LlCnMFMxA+psjO+3oCALg9RS7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oe0L2-00BIKJ-0v;
        Thu, 29 Sep 2022 22:40:56 +0200
Message-ID: <da810136f6cf0608167cc8297ce73d11b83974d6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Thu, 29 Sep 2022 22:40:55 +0200
In-Reply-To: <20220926161303.13035-1-alexander@wetzel-home.de>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
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

Thanks for doing this!

It's a bit bad timing right now, so I'll only have a chance to look at
this in the next couple of weeks, but that also doesn't matter that much
since 6.0 release is imminent (will likely be Sunday).

Just wanted to comment on this one thing for now:

On Mon, 2022-09-26 at 18:13 +0200, Alexander Wetzel wrote:
> A short look at the in-tree drivers seems to confirm, that mac80211
> drivers are indeed not directly calling netif_stop_queue(). Which is no
> longer undesired but outright wrong after this patch.
> So I *think* we should be fine on that front, too.
>=20

They really couldn't, they don't have (easy) access to the netdev. There
are ways of getting to the netdev, but they're (intentionally) difficult
and doing that would've been wrong even previously since mac80211 has
its own reasons for stopping netdev queues sometimes.

So unless a driver is already broken, this can't be an issue.

> I did not try very hard to identify now obsolete code fragments and
> kept this as simple as possible.

That's nice enough for now, do you want to do follow-ups to clean up
more?

> I've also have a rough draft to move PS (multicast and unicast) to iTXQ
> we should look at later. That seems to be way more invasive than what we
> do here. But once PS also has been sorted out moving everything to iTXQ
> should be straight forward.

Ohhh! I'm excited about this :-)

johannes
