Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13FD7AE9CC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjIZKAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjIZKAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 06:00:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF52193
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YMkWUhPMi5MlgEJx/17dv5tGxomlRYsOBLSY0nriJC8=;
        t=1695722424; x=1696932024; b=YwM/gTTf1R07V69YE00JJh2zEouI2y2aWa1j4jYA72kWylz
        k/hLzCEHDjPBCn37HNNSbRvn/Cemet8ijCWy8m8Oi7JC8v1A5SNM9adPR1vxak8iUDUbthsqYoVZW
        2oH08mjWRgUz3zg5KAVT9lf0rgZn5Em4BCf7HrtJjdhK0yyzlS90HFN+lnefaydqmpcCmOP4Yhji0
        Vfwxr+IS/cruiIzwj2SxU8zYDaAtxlUk7Q3nd5n8tIAbVkXKxNNQg1WvtaPoiTpqIS45ZSd5+SvTW
        mHmF7SieBJtEjR/bYO6dXcKZijmgL8lIWwSLDc+n94r1TlgKilETSqc9dXGOSEfw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ql4rd-005SgD-1e;
        Tue, 26 Sep 2023 12:00:21 +0200
Message-ID: <6892f4026a275756eecf36f46711442882aac7fd.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] wifi: mac80211: add support to allow driver to set
 active link while connection for station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Tue, 26 Sep 2023 12:00:20 +0200
In-Reply-To: <96ae3c1d-274b-00b1-cb19-a9a301b6aa56@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
         <20230906103458.24092-3-quic_wgong@quicinc.com>
         <4b597bba9dc13c3260f174826de38b4f1bc3bf6e.camel@sipsolutions.net>
         <96ae3c1d-274b-00b1-cb19-a9a301b6aa56@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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


> For ieee80211_set_active_links(), driver need save and install pairwise
> keys for the other links as you said in link below. But driver do not
> save the key data currently. So driver could not install the pairwise
> keys by itself.
> https://lore.kernel.org/linux-wireless/50719d34bc48d816d00b56d3d9efdb59e3=
e51a16.camel@sipsolutions.net/

Well it can still easily iterate the keys, but OK, I can buy this
argument. You should probably mention it all in the commit log though.

> > > @@ -166,6 +167,13 @@ static void ieee80211_set_vif_links_bitmaps(stru=
ct ieee80211_sub_if_data *sdata,
> > >   		WARN_ON(dormant_links);
> > >   		break;
> > >   	case NL80211_IFTYPE_STATION:
> > > +		active_links =3D drv_calculate_active_links(sdata->local, sdata,
> > > +							  valid_links & ~dormant_links);
> > > +		if (active_links) {
> > > +			sdata->vif.active_links =3D active_links;
> > > +			break;
> > > +		}
> > >=20
> > I also _really_ don't think this should operate at this low-level
> > infrastructure.
>=20
> I really want to know the reason why active *only* the assoc link for=20
> station, but
>=20
> active *all* links for AP here=F0=9F=98=81?

Well, fair point.

I was somehow anyway thinking that it should be the other way around, I
mean, in the sense that this code here is just mechanism, and the policy
should've been in higher-level code ... but somehow that's not what we
ended up doign here.


It really feels wrong to me to have the driver involved in this low-
level infrastructure, but OTOH that really is how it works now?


Maybe really what you want is a driver flag saying
IEEE80211_HW_MANAGES_ACTIVE_LINKS or something, and then from a mac80211
perspective you don't set active links at all? Though I'm not sure that
works with TTLM, for instance? And maybe you'd still want the debugfs?

But in fact, if you do still want something from mac80211 for debugfs or
TTLM, then this code here is not really right, since you'd interact with
_all_ attempts in mac80211 to activate or deactivate links - when all
you really wanted was the very first one.

Which today mac80211 achieves by bailing out
"if (sdata->vif.active_links)", and while you could do the same in the
driver, it feels really brittle / error-prone to me.


I think it'd be better than all these callbacks to encode the specific
behaviour you need in a flag, e.g. "activate all STA links on assoc" or
something?

johannes
