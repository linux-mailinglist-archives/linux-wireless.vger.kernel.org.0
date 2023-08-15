Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77477CEC3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbjHOPNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjHOPMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 11:12:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B21986
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Ype1+gZzKCovsfdmhEAYpWK1hn1M8Ke9wrhCay8tDtg=;
        t=1692112363; x=1693321963; b=F6md31gj1L1aj0VEQZe7sKAlR7KZrD+0MKU8GTrRN+wbS21
        r6mjVkczp3Vz8fCqPfLLiqdYB3aipAO0Hilqi1s0x9Fi/KxR0n6vAkmihvcW64uzML5RcemCr3kEN
        RJ/I3tLZW74SeYz1wh5C0zgjfpHGOLmozfYgFZWFBw7b9Qjan4mgq3V4DpFZE2l7CjNA1fOwDHRuo
        lb+B4YuzhwLoVbq27JDh4f643BaiZ684ssdx9tFejqi6WkPO6zGopKwd+XRP5PLEZxQzgkwwiJk23
        JUvW+Yg1i2BmTjkIFx3ZPlJg6r7y2U7krjnKPt/MUOCpP6HmnSTimiMLv6CZYNew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVviq-008xZ3-1K;
        Tue, 15 Aug 2023 17:12:40 +0200
Message-ID: <d2bd82291f6588c75aa17d43086ecd14f25f691f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: beacon EHT rate support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 15 Aug 2023 17:12:39 +0200
In-Reply-To: <1aa6178f-2041-797e-fcb8-78fe2c08de24@quicinc.com>
References: <20230329000902.17992-1-quic_alokad@quicinc.com>
         <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
         <312f1476-b78b-b7f0-26f9-512a7dc2b6b7@quicinc.com>
         <3abb2d127eaa3b76a8f4f34c795ddd6d502ce470.camel@sipsolutions.net>
         <1aa6178f-2041-797e-fcb8-78fe2c08de24@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry, I completely dropped the ball on this.

On Fri, 2023-03-31 at 10:55 -0700, Aloka Dixit wrote:
> > How is ieee80211_set_bitrate_mask() related, it's in mac80211?
> >=20
> > Oh you mean it doesn't need to be changed to support EHT? Looks like to
> > me that it would have to be changed, and even HE today only works in
> > non-mac80211 drivers that implement it correctly?
> >=20
> > But again set_bitrate_mask() isn't even related to beacon rate?
> >=20
> >=20
> > Regarding beacon rate, it looks like mac80211 _only_ accepts legacy
> > rates, and then also _only_ in start_ap(), so I'm not sure how the whol=
e
> > thing even works ...??
> >=20
>=20
> I agree with all of your points and as said above, I mainly tested by=20
> checking the final mask generated in nl80211.c.
>=20
> Do you remember a similar discussion when HE code was added (I wasn't=20
> the submitter). May be that will have some pointers regarding how it was=
=20
> tested.
>=20
> Do you think we can continue with this EHT support for non-mac80211=20
> drivers similar to HE for now?
> Or should we just skip this patch?

I don't know? I guess you need it somehow? Can we fix mac80211? Or maybe
just make it clear that it won't work there? To be honest, it's not
really in my head anymore now, unfortunately.

What exactly do you need? Maybe we can work back from that.

johannes
