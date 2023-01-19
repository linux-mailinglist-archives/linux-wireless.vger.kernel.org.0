Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30112673D22
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjASPJv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjASPJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:09:49 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4769239
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fSwHA9PomlSjQpLyQfCb4Of4h1G5qH8wXJrataBuYyM=;
        t=1674140988; x=1675350588; b=g9Jx7aqxXRxy0pdnzWN9iRv0ii79zNA4R7T4MpFz/WladQC
        /l6sJeNOBK32qTMxz+bCqxsk8XuGi6kEyG+zBnkMAG25xbWpzPbKcrPEngLLf3BGQDeRsy10FQkaB
        rGkHtfDpZ0CzwkRbdolZnHZX9HJVg5wVYG7/iFZBpBsuKFVhugDzKMuV/as+YRS+4WhQNYrZTk6qZ
        oVogoTe/2NDsQZ0WNfmsZzdLTqkiaQaa3DtLgwMXp016hV//lR3ws7v4e2qgtKgAOH+kU2hSmJG9t
        APU9nuRC1a1LP9TwiG/bs02DMaEPJEG041n6DjPYWvN9GLFJrRuzYJL9Nw2izdAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIWXy-006YUq-2H;
        Thu, 19 Jan 2023 16:09:46 +0100
Message-ID: <3e269bce8d73577fb1183697655d6ad66edf866f.camel@sipsolutions.net>
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date:   Thu, 19 Jan 2023 16:09:45 +0100
In-Reply-To: <951FA42C-E52F-4FDB-AB73-AEF76435380C@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-6-jelonek.jonas@gmail.com>
         <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
         <951FA42C-E52F-4FDB-AB73-AEF76435380C@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Thu, 2023-01-19 at 15:32 +0100, Jonas Jelonek wrote:
> >=20
> > Not sure I like this either - I think we should probably create the
> > wiphys dynamically for most features these days?
>=20
> just to make sure I got it correctly: so you propose that these
> params, that are=20
> currently done with module_param(), should be switched to a dynamic
> netlink approach, or only for TPC and RCTBL for now?

We do have dynamic parameters for all the module parameters I believe,
but we've shied away from actually removing the existing module
parameters for legacy/compatibility reasons.

However, I think that for new parameters, there's really no good reason
to provide module parameters, since the test scripting etc. can
dynamically create wiphys with the necessary capabilities. Even the
hostap/hwsim tests can and do already do that :)

> As a first step I focused on providing a proof-of-concept
> implementation in hwsim for my
> TPC proposal, implementing netlink to set tx power and other could be
> part of the next step.
> Do you think this could be fine or do you propose something different?

I'm not quite sure what you mean by that, tbh. I guess I kind of thought
you were going to adjust minstrel to do TPC automatically.

We already have netlink support for setting per-station TX power which I
guess this should then listen to? See NL80211_ATTR_STA_TX_POWER_SETTING
and NL80211_ATTR_STA_TX_POWER etc. I think it's not supported in
mac80211, but probably could easily be after your patches?

johannes
