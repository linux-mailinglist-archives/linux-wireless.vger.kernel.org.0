Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D178D9C7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbjH3SeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbjH3Hlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 03:41:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A6CD8
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Wjxbsf3a/dlWEaU6hBd96eOkhzJ1ChDslhr8mQExZKY=;
        t=1693381296; x=1694590896; b=Ummz8TTKizS3kf+l0A2et8x/XSE2Upmrb72IjFeEyyR3iXL
        fEi+oZf8sjWEqa8xWrY5CTjpis9FDWhrywYsZbsdbnn/eIhfeNTIM2hty/n9TiUIwrKe7rYPKezxF
        zXW7YlxwQqYZ6gZ85GOh6yk4+Zo3N2UloWVrUWSGzsD/Bl4T3kUG6RFbkH8EvqJY4oWOr2lyQcvIN
        HxssvWmhlr/FwOOi3i9XhfYjKNHWQmGUV8uLzVwONy4vnnadJqj4IZfCU1oNBsKvargCLIuYrLTZr
        g01uBbZOtX02C9Epudcl8dYPrxJvOb/s7V/Rtja9tcDqDw0wJygQUL3o/GeTTZPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qbFpV-002o1g-0R;
        Wed, 30 Aug 2023 09:41:33 +0200
Message-ID: <321872041974a787db71bbbf660adeb40c494d71.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/9] wifi: cfg80211: add NL command to set 6 GHz
 power mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Aug 2023 09:41:32 +0200
In-Reply-To: <d3740fa2-a59e-d6e2-394c-9b289564b832@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
         <20230315132904.31779-5-quic_adisi@quicinc.com>
         <59e2364e9085f725c03d05e3f720f8fae7b336ce.camel@sipsolutions.net>
         <d3740fa2-a59e-d6e2-394c-9b289564b832@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-30 at 10:35 +0530, Aditya Kumar Singh wrote:
> On 8/29/23 23:21, Johannes Berg wrote:
> > On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:
> > >=20
> > > +	{
> > > +		.cmd =3D NL80211_CMD_SET_6GHZ_POWER_MODE,
> > > +		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> > > +		.doit =3D nl80211_set_6ghz_power_mode,
> > > +		.flags =3D GENL_UNS_ADMIN_PERM,
> > > +		.internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV |
> > > +					 NL80211_FLAG_MLO_VALID_LINK_ID),
> > > +	},
> >=20
> > Why is this even a new command, rather than a parameter to start AP or
> > similar?
> >=20
> A new command was introduced because to give user space a knob to change=
=20
> power mode as and when required. Let's suppose AFC response has not yet=
=20
> arrived, AP could be started in Low Power mode. Now once AFC rules are=
=20
> applied (not going in detail here how that will happen) and user space
> knows about it, it can send command to switch to Standard Power Mode righ=
t?

At least for AP that could also be a beacon update, like most other
operational parameters. You have to update the beacon _anyway_ since you
indicate in the beacon what you're doing.

So that by itself doesn't really introduce the requirement to have a
separate command.

> > Why do we even set it in client mode from userspace?

And you didn't comment on this - what userspace do you expect to use it
in client mode? I can see hostapd in AP mode, I guess, but in client
mode I don't see how this could be used? Anyway you're tied to what the
AP is doing, no?

> > >   static struct genl_family nl80211_fam __ro_after_init =3D {
> > > @@ -17409,7 +17473,7 @@ static struct genl_family nl80211_fam __ro_af=
ter_init =3D {
> > >   	.n_ops =3D ARRAY_SIZE(nl80211_ops),
> > >   	.small_ops =3D nl80211_small_ops,
> > >   	.n_small_ops =3D ARRAY_SIZE(nl80211_small_ops),
> > > -	.resv_start_op =3D NL80211_CMD_REMOVE_LINK_STA + 1,
> > > +	.resv_start_op =3D NL80211_CMD_SET_6GHZ_POWER_MODE + 1,
> > >=20
> >=20
> > Obviously, this should not be done.
> If this hunk is not there, the command was not going through. Upon=20
> digging further found out that the number of commands declared in the=20
> array and the count provided here has some relation. And that too with=
=20
> the last element added. Since a new element was added, modified it=20
> accordingly.

No no, that wasn't a discussion. I'm telling you, this is wrong, and I
will not apply a patch that does this. If you needed it, you did
something wrong in userspace.

johannes
