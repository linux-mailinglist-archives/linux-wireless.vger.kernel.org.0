Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB56C9DFB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 10:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjC0IhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjC0Igw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 04:36:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7179ED7
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IdKpgzCNbwY7lFmHxBGsQD8N7vPJ1zfocoC/XEPb14I=;
        t=1679905894; x=1681115494; b=qoXusFsF4SsSRRixY3WUGixUzCSN4a/P6DiIK2JcHYYyK1H
        +UVxAG1vPCRvr5/Dd2zZ3ngMTdZRoTxQx57dnsL+fO4Z7JLPpdgUezrS4dso+zQEk/Tcv2+7X8jhM
        GysyslwwvIEC35VJQQTu07gH1aDIXZcplIfDDWiE3ge6soe2ApibJ5rW3vPWjZmFz9AcHPXIClnf4
        uqeyc3jp2bvAd4MklFt9VlvWh1bl24Csysv13VEyCewwaV9INh9n11HkKZoOJ8hTJqgUjEHTGa2Wr
        19xFCxBuJWogfs8wn/lNvSwW69qb21he5ZDBe4V+L7PXNdgJhdueiUTshjwOK2Cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pgiGD-00Faeu-2T;
        Mon, 27 Mar 2023 10:31:25 +0200
Message-ID: <50719d34bc48d816d00b56d3d9efdb59e3e51a16.camel@sipsolutions.net>
Subject: Re: [PATCH 24/27] wifi: mac80211: implement link switching
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Mon, 27 Mar 2023 10:31:24 +0200
In-Reply-To: <ca5177fe-3b9f-2309-9afd-1d5e827540f7@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
         <ca5177fe-3b9f-2309-9afd-1d5e827540f7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > +	list_for_each_entry(sta, &local->sta_list, list) {
> > +		if (sdata !=3D sta->sdata)
> > +			continue;
> > +		ret =3D drv_change_sta_links(local, sdata, &sta->sta,
> > +					   old_active,
> > +					   old_active | active_links);
> > +		WARN_ON_ONCE(ret);
> > +	}
> > +
> > +	ret =3D ieee80211_key_switch_links(sdata, rem, add);
>=20
> I see ieee80211_key_switch_link() only handler the per-link(link_id >=3D=
=20
> 0) keys,
>=20
> So I think lower driver also install the pairwise keys(link_id =3D -1) fo=
r=20
> the added links at this moment?

Well from mac80211 POV they're already installed, so we can't really
install them again. We'd have to remove them but that's racy, obviously.
So I think the low-level driver just has to handle that, e.g. when the
station links are updated (and the key belongs to the station.)

> > +	WARN_ON_ONCE(ret);
> > +
> > +	list_for_each_entry(sta, &local->sta_list, list) {
> > +		if (sdata !=3D sta->sdata)
> > +			continue;
> > +		ret =3D drv_change_sta_links(local, sdata, &sta->sta,
> > +					   old_active | active_links,
> > +					   active_links);
> > +		WARN_ON_ONCE(ret);
> > +	}
> > +
>=20
> I see 2 times to call drv_change_sta_link() above, and with sequence=C2=
=A0=20
> old_active->old_active | active_links->active_links
>=20
> May I know is it has some design here?

The problem is that we can't really have no links active even as an
intermediate step, so you can't just deactivate old and then activate
new.

> > +	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
> > +		struct ieee80211_link_data *link;
> > +
> > +		link =3D sdata_dereference(sdata->link[link_id], sdata);
> > +
> > +		ret =3D ieee80211_link_use_channel(link, &link->conf->chandef,
> > +						 IEEE80211_CHANCTX_SHARED);
>=20
> For the 1st link of MLO connection/NON-MLO connetion, ieee80211_link_use_=
channel() is called before drv_change_sta_link(),
> And now it is after drv_change_sta_link(), May I know is it also has some=
 design here?

Hmm, probably not really, at least I don't remember anything about that.

Not sure it makes a huge difference? But I suppose we could change it, I
don't really see why not either.

> Also I see commit(8fb7e2ef4bab mac80211_hwsim: always activate all links)=
 and ieee80211_if_parse_active_links()
> will use ieee80211_set_active_links(), so I think ieee80211_set_active_li=
nks() has passed test case with some type lower driver/chip?

Yes, we have this working on iwlwifi/mvm.

johannes
