Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04DB5FD7A2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJMKKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJMKKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 06:10:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D7EA6B1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=k/Xe9KwX5Y4b5mC0pJMb1NN4xvxbcXamSs4YqywcTD0=;
        t=1665655836; x=1666865436; b=YaTx1VVAqrznPbSpgTZYMdoThCQkQFxEdqHsyWOejeV7DoT
        7jQbDZtjdg0B9+Ac70eLBbwE+hAhxFPhBJWWYx83OKCwL39gqyt4N5JXD1k2mult9i/2sKvgzAIC5
        gJpCZfZhK1iZy0YpCuTGKZANLWoTebPvz4Lxc3r8XLTiV4bLzitf6/Em6Wpwgw/d5wbBAYRzaw3vP
        08L8Zj2Et8OgCe2Cg62iPhMzZjR1MCk/LRl6eAGSZG13/jnsaXxUM9i7AmWNoUFuKFj3GxgP8bxwp
        cGEZlnameA1eu2Y/UrEsJx0ND8++w5D2VAd48X6l3SAWGcxTLmb2cqJVeh0YygBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oivAd-005eEw-0G;
        Thu, 13 Oct 2022 12:10:31 +0200
Message-ID: <2269de3ebe54777f1b752804df073262f3b4eed4.camel@sipsolutions.net>
Subject: Re: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment
 sparse warning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     Ajay.Kathat@microchip.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, lkp@intel.com,
        hostap@lists.infradead.org
Date:   Thu, 13 Oct 2022 12:10:29 +0200
In-Reply-To: <20221013094011.GB3862@w1.fi>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
         <87v8rik8vp.fsf@kernel.org>
         <2b432ae1-48fc-5a70-0afe-2b9f788f14e4@microchip.com>
         <e677e3cd1b5c34146017a65f28fabdb673a91d23.camel@sipsolutions.net>
         <20221013094011.GB3862@w1.fi>
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

On Thu, 2022-10-13 at 12:40 +0300, Jouni Malinen wrote:
> On Thu, Oct 13, 2022 at 09:39:56AM +0200, Johannes Berg wrote:
> > On Wed, 2022-07-27 at 17:32 +0000, Ajay.Kathat@microchip.com wrote:
> > > I think, there is an another way to handle this issue. 'key_mgmt_suit=
e'=20
> > > element in 'cfg80211_external_auth_params' struct should be converted=
 to=20
> > > '__be32' type(like below code snippet) because wpa_s expects the valu=
e=20
> > > in big-endian format . After this change, the type case can be avoide=
d.=20
> > > Though I am not sure if these changes can have impact on other driver=
.
> > >=20
> >=20
> > Ugh. I think maybe it would be better to fix wpa_supplicant?
>=20
> Assuming you are referring to what sme_external_auth_trigger() does,
> yes, the use of RSN_SELECTOR_GET() there on an unsigned int variable is
> clearly wrong.

Right, that's what I meant.

> As a workaround, it could be modified to accept both the
> big endian and host byte order since the risk of conflicting with a
> vendor specific AKM suite here would be very minimal..=C2=A0

True.

> > Thing is, we use the NL80211_ATTR_AKM_SUITES attribute here for it, and
> > even wpa_supplicant mostly uses that in host endian:
>=20
> By the way, that use of a u32 attribute (or an array of such) in an
> interface is quite confusing for suite selectors (both AKM and cipher)
> since a suite selector is really a four octet binary string that starts
> with three octet OUI that is followed with a single octet integer
> value. nl80211.h does not seem to provide any documentation on what the
> exact value is supposed to be.

I guess we should fix the documentation then, but basically, for a
selector of

 O-U-I:D

we use

 (O << 24) | (U << 16) | (I << 8) | D

for the ID. If we had consistently used be32 then that'd actually at
least match the four octet binary string and it'd be irrelevant, but ...
we clearly didn't.

> I can understand use of u32 and native byte order as an implementation
> internal thing, but it should not really be used in an interface since
> it is just waiting for this type of issues to show up.

Yeah, can't really disagree with that, though I think it's a bit late
now, unfortunately.

johannes
