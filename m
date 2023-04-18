Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C676E5E7A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjDRKTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 06:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjDRKTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 06:19:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F19D6EBD
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=F5GtC/Ug8FVHmzGkdMDsWJgCnt1hLX/XyGMcykgns/M=;
        t=1681813139; x=1683022739; b=joDVo1JK7xXsc4AGxcGzfHzZM2M7FCyjpzTdwAIC8QWu6xp
        xeHuhpQaUraDRO0HZaAWXRszaFchOhLAARng7gJIDHsUZbMstlJBwdgP9dvKtu6IJ5fsjmM2kYZML
        ei6LvdWGcZpWKX1cKRvYmpbNI6dh1eQOhGXww/kJu+FoSTEl3QycDbRJ1zikB5vPyiQwrh0pI7EK6
        b+rwIzKN1eaGR2G4YB6dFGDnhrKiy4N5ePjjnwvRxUiy7fBQZg9kvKZzmhGUYu6zq/wB3vHu3ZjwZ
        Vq5RR3VKM/LA3Z57gGObHXREkj4FaEtKmYp/NFsIwbJXIdu3FyfFPR5vn+AcbMCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1poiQK-001aBp-0x;
        Tue, 18 Apr 2023 12:18:56 +0200
Message-ID: <949040e5e573acef1a56269983a0e930951986ca.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 18 Apr 2023 12:18:55 +0200
In-Reply-To: <a371eb4f-7d79-eeb4-5208-f9a342798021@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
         <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
         <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
         <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
         <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
         <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
         <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
         <edfc26b5-f6d1-2ab7-f3cc-60a74c8c334d@quicinc.com>
         <61268d31f8a6dd4eea10fcb6048d39244bc584e2.camel@sipsolutions.net>
         <870ce439-85b1-f02c-70e5-2d424fd73372@quicinc.com>
         <34ed0938b69ead648da1aa250a2e081054fb49d4.camel@sipsolutions.net>
         <34212873-0b71-7f39-b064-6b50d8e514b4@quicinc.com>
         <09b156b1ef05377ca7fa0db35e8e13beb5c60e2c.camel@sipsolutions.net>
         <13980456-11a6-384c-7be2-63c005410267@quicinc.com>
         <ab8f9ed0f04873cafb81cc1c9f5d5c804b146aa9.camel@sipsolutions.net>
         <a371eb4f-7d79-eeb4-5208-f9a342798021@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-04-18 at 17:44 +0800, Wen Gong wrote:
> On 4/18/2023 5:38 PM, Johannes Berg wrote:
> > On Tue, 2023-04-18 at 17:37 +0800, Wen Gong wrote:
> >=20
> >=20
> > > > > the sdata->u.mgd.assoc_data is NOT empty,
> > > > >=20
> > > > > and the sdata->u.mgd.assoc_data->link[link_id].addr is valid,
> > > > >=20
> > > > > it is addr by eth_random_addr(assoc_data->link[i].addr) in
> > > > > ieee80211_mgd_assoc().
> > > > >=20
> > > > Exactly, so we've already decided on the address long before we act=
ually
> > > > add the link data structure, so your callback would be much too lat=
e.
> > > > We'd need to have it called from ieee80211_mgd_assoc() already?
> > > For the 2nd link, is it OK for me to use the random addr which is set=
 in
> > > ieee80211_mgd_assoc().
> > >=20
> > > I only need to set the 1st assoc link in low driver.
> > >=20
> > Ah. But does it make sense to restrict the API for that? I mean, if you
> > just change the prototype a little bit and call it without the link
> > conf, you can easily solve this problem too, no?
> Sorry, I am not sure how to solve this problem by remove the link conf=
=20
> in prototype.

Why, then you can have an output parameter for the address, and call it
in mac80211 wherever it calls eth_random_addr() today, no?

johannes
>=20
