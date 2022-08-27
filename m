Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841EC5A3827
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Aug 2022 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiH0OqU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Aug 2022 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0OqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Aug 2022 10:46:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC72315F
        for <linux-wireless@vger.kernel.org>; Sat, 27 Aug 2022 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lmrmDkvaAS6Djy9p7dIBcApJPPilZINP1K5eU/pl69g=;
        t=1661611576; x=1662821176; b=QDK8DRukCKnnLkXhUTTkrLP6YogBqfsTYHRwsgykFErWIpr
        CzcIRTBpFcpNVtU6hdKX4JrhupY/+r/hv3p/e1gBBv88wi3GUNFroT0ZMJuZLTbzqx3zrscqiabqQ
        p68yHI3lQOd409fenB5m6+3QtTbMzbpTLTX+wSP59V7NVkJs16JYBZvQyRj0EMKO4fB3moQ71Yhnh
        E+Pc/sBo/Z5htynIjBBVzK4ysr+XqNlBC3KG6zZf7M8KDK80r+8MjrRiW2KqcNcxmGoS0f0xHTpqM
        e3SMOkdlRUR/XUdqdYPilueY4aVzM/HxKeVS+OdOaZt5ouYzaydh9lkmzBMPif7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRx4f-001Crb-0u;
        Sat, 27 Aug 2022 16:46:13 +0200
Message-ID: <199f2ac280a1e1a195add45290411a9c1dc519fc.camel@sipsolutions.net>
Subject: Re: Automatically adding OCI in mac80211
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Sat, 27 Aug 2022 16:46:12 +0200
In-Reply-To: <432703ce83ac979ba06e2b85d6dc500f246c6a76.camel@gmail.com>
References: <432703ce83ac979ba06e2b85d6dc500f246c6a76.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-08-26 at 14:12 -0700, James Prestwood wrote:
> Long ago support for multiple authenticated BSS's was removed due to
> its complexity.=C2=A0
>=20

Well, actually, you can still authenticate with multiple BSSes, we just
don't really track it.

> CMD_AUTHENTICATE now changes state/channel, and is not
> recoverable if authentication fails (i.e. disconnect).=C2=A0

It never did anything else though, IIRC? Anyway, doesn't matter much
now.

> The spec
> actually allows/intends for multiple authentications to be supported
> and FT specifically can really benefit from this.

Sure, and with FT especially you can do some things over the DS too -
but the kernel no longer cares, which is the part that was removed, if
you try to assoc without ever authenticating it doesn't matter as far as
the kernel is concerned.

> As a workaround we started playing around with using
> CMD_FRAME/offchannel for authentication, bypassing the kernels state.
> This works, and we can authenticate, fail, try another BSS etc. all
> without the kernel knowing, then proceed to association.

Should work, yeah.

> The small problem is dealing with OCV. Prior, we would call
> CMD_AUTHENTICATE (channel changes), then GET_INTERFACE in order to
> obtain the channel/operating class to build the OCI element. Now, since
> authentication is done offchannel we cannot use GET_INTERFACE. Deriving
> the OCI based on capabilities is certainly possible, after all this is
> what the kernel does, but rather than trying to mirror/maintain that
> code I thought it would be great if the kernel could append the OCI
> automatically to the association request. This would also save a round
> trip since GET_INTERFACE wouldn't be needed.

I don't understand. You already have to know the channel in order to
even *do* this (off-channel TX)? The kernel doesn't really know much
about operating classes, so that part seems a bit tricky.

Also note that this is not going to work so well with MLO due to the
link and MLD addresses, and the kernel currently inserting the ML
element, so not sure you're going to want to go this route now.

johannes
