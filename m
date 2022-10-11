Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1B25FAD72
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJKH07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKH06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:26:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A51E719
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wXvmb5jXrcLN6sR1/eCh8edF92ghBU2PeyOgob5hdWY=;
        t=1665473217; x=1666682817; b=iy5bbqrJ3jOt3k5cRmmfT5Ni2xvvarqBkpaLAVo31z9M/Iy
        K5ZMKSQQmxsORaXTQGHBGaFLSMdHfLapQp6pgWQuxAkYjbmXiLGvfMwS8gFax7St6wkdbSOb9AVWI
        JnqDawXXqdgotlBKlKsUa04+G3G0WRTj/ESZngVET56vvVkCMxjAfwnDDDX6CVUWITlk7w2PZ+XPH
        IO6ZQJRZJtI8Z38eRsHOvhtzTpSbB3vtciraRrW4vHyjQFnDR4+D3vQPGtfZpDOlWLX+3FQVcVNG/
        38nCNh0rqpg46dDLbkA0sPFWXqewMPl9VsY0V5uQ2JTVy3lj0s6+y0efFJQmXB1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oi9fC-003s4e-1e;
        Tue, 11 Oct 2022 09:26:55 +0200
Message-ID: <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 11 Oct 2022 09:26:53 +0200
In-Reply-To: <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
         <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
         <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
         <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
         <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
         <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
         <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
         <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
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

On Tue, 2022-10-11 at 12:07 +0800, Wen Gong wrote:
> On 9/28/2022 11:28 PM, Johannes Berg wrote:
> ...
> >=20
> > > May I know some more info/status about the "incoming=C2=A0 new method=
 to let
> > > drivers set the link address"?
> > >=20
> > I wasn't actually planning to work on that myself, FWIW.
> >=20
> > johannes
>=20
> OK. So has some body will work for that now?=F0=9F=98=81
>=20

Yes, I don't personally have a need for anything other than what we have
right now.

Btw, I also merged pretty much all the things into wireless-next now, I
think only maybe some debugfs updates are still not upstream, and a few
minor bugfixes perhaps.

johannes
