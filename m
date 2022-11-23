Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61576353A6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 09:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiKWI5T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 03:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiKWI5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 03:57:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A411FDD8F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 00:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1XEi+6J+BzArOO+SOJsrvu5K7v4LoKwRET7+3GPTPKQ=;
        t=1669193823; x=1670403423; b=DY/GCXoJ6ezOpKqQiiN65EC+0R9NAIspgyjycLN/ub3ogXo
        ps6rwYMjaEDYuA1pE1AMAuNuUTMSVd0I6F9GhYAmNEc6SqpmnV7FVF+EMRuNkLYgkfe9fCkBR2m/k
        lHzYcOVLr310mwXj8JV/K0v/ar+1xRx8X14xNZNF/PQtlAsMpVxl6QCt4dt3fdn0WF17g1FwFyct+
        m3lXuBcVzCKvlsGLiXjsbSkzBD0b6+bwuFn0eJ2Oe62jkGibvNBzLowS2LIj5I1/lYznpgSB4b+3+
        n3egp8bYseY41cQVmI4QUAH1NbLfIIo1AVzr1cc2Zf9g5XS21cxImU/p0X0G7bJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oxlYx-00780E-2u;
        Wed, 23 Nov 2022 09:56:59 +0100
Message-ID: <5729983cd02a82d36fed42dcd133e7713fe3aa53.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] mac80211: mlme: Handle Puncturing information
 received from the AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kang Yang <quic_kangyang@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Aloka Dixit <quic_alokad@quicinc.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        "Carl Huang (QUIC)" <quic_cjhuang@quicinc.com>,
        Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Date:   Wed, 23 Nov 2022 09:56:58 +0100
In-Reply-To: <76266a0b-d371-53c1-9ad0-fbff7a506d0c@quicinc.com>
References: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
         <e4db49e4-6363-0c8d-10dd-a1a564da2542@quicinc.com>
         <95ad4207e62b4990476d867bd240fef3ede31369.camel@sipsolutions.net>
         <76266a0b-d371-53c1-9ad0-fbff7a506d0c@quicinc.com>
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

Hi,

> > > > +static bool ieee80211_config_puncturing(struct ieee80211_sub_if_da=
ta *sdata,
> > > > +					const struct ieee80211_eht_operation *eht_oper,
> > > > +					u64 *changed)
> > > > +{
> > > > +	u16 bitmap, extracted;
> > > > +	u8 bw;
> > > > +
> > > > +	if (!u8_get_bits(eht_oper->present_bm,
> > > > +			 IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
> > > > +		bitmap =3D 0;
> > > > +	else
> > > > +		bitmap =3D get_unaligned_le16(eht_oper->disable_subchannel_bitma=
p);
> > > > +
> > > Should check initial bitmap here.
> >=20
> >=20
> > What do you mean by "initial" here?
>=20
>=20
> "Initial bitmap" is the original bitmap that AP send in beacon . STA=20
> will extract it according to the negotiated BW. So i call it "Initial=20
> bitmap".


Ah, that was referring to the below comment, got it.

> > Anyway the more fundamental thing we have to figure out here (and thank=
s
> > for bringing this back) is how we treat the puncturing - QCOM's AP-side
> > puncturing patch treated it as part of the chandef, but that's not
> > working well for client side ...
> >=20
>=20
>=20
> Yes, to my understanding, I think it's more appropriate to define it=20
> like you in "ieee80211_bss_conf".

:-)

Forgot to say: thanks for the review.

> But this should be discussed by people like you. I'm just responsible=20
> for developing according to these definitions.

Heh :)

Well Aloka is back - Aloka maybe you have some comments?

Adding Maha too.


I suppose I could post a new patch with bugs fixed, but not sure that'll
get us anywhere on the semantic discussion.


I can somewhat understand why you might want puncturing to be part of
the chandef for an AP, especially for configuration, though I'm honestly
not sure what the use cases are; perhaps some other use for that
bandwidth (perhaps cellular?), but then does that really mean we should
refuse configurations that aren't in line with it?

If we put puncturing into the chandef that might not even mean we
*refuse* configurations, it would initially just mean we need another
channel context (if supported, otherwise refused) when we add two.


But given that the primary use case seems to be different use for the
part of the spectrum that's being punctured - maybe we should set it up
in a wholly different way and have some way of "carving out" reserved
spectrum?

So you could, say, reserve channel 40, and then to have an 80 MHz AP on
channels 36-48 you'd have to puncture 40 there. We wouldn't have to
store it as part of the chandef/chanctx because the validation is now
done against the reservation; or we could even store it as part of the
chandef/chanctx but say it only applies to beaconing modes or such, and
not handle it as part of the chandef equality comparison.

And really that's the thing that matters to the client here, the client
never has a choice, so if it's part of the equality comparison on the
client, then the client might not be able to simultaneously connect to
two BSSes (or need two chanctxs to do it) if both have 80 MHz on channel
36, but one has puncturing and the other doesn't. That doesn't really
make sense IMHO.

If we treat the puncturing as a more global "reserved spectrum" case,
then we can still put the puncturing into the chandef, say it applies to
beaconing modes only (I suppose AP is the only relevant one, perhaps
someone will care about mesh in the future?), not have it as part of the
=3D=3D comparison. All APs would have to adhere to that.

That still leaves a corner case of concurrent client + AP functionality
which can only be handled if hardware can deal with different puncturing
settings per interface? Which again argues for *not* storing it as part
of the chandef, I'd say.

Any other thoughts?

johannes
