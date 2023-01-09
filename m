Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A0662274
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 11:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjAIKHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 05:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjAIKGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 05:06:45 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E38D186C8
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 02:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WZWeJLEzMsm5772nG/08xGtisx6me5lL7YIJqPjIX/k=;
        t=1673258712; x=1674468312; b=TjV9yF7mPlksQMbAgCvY9UNEkHAJQOGSE8b6aRO6VT571FW
        52snoH3W17gE9jbVJMiLaZrnQi09dpMDUCxFTUjyDX5z2P3jCEAnD4Nc9kiAReOoyMgVPEv+filio
        NvELhVGL87y5nobp7mt0IW5IBvPMZZev/4mWnDs4C3+hos+dyICUdep8eY65quhfc5YPdSwD5Qxuf
        LRW9dSP+JyPpW1l4gXxWZkUDmvune39KAg5sC9FvNHOkRl2SwCCaG9lmkBpSLL4ib6q61bvs4z/al
        GqLe5Rj/BoWKQZKhQbtv2vCaXNJdIIQUJTqY3rLdYaUetfcWFMqLbuvn9y6NNUBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pEp1f-00EE9O-0B;
        Mon, 09 Jan 2023 11:05:07 +0100
Message-ID: <6187b1566674ba2e0d7d5413af5475688d8421b3.camel@sipsolutions.net>
Subject: Re: [PATCH v10 3/5] cfg80211/mac80211: move interface counting for
 combination check to mac80211
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Luciano Coelho <luciano.coelho@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     michal.kazior@tieto.com, sw@simonwunderlich.de,
        andrei.otcheretianski@intel.com, eliad@wizery.com,
        ath11k@lists.infradead.org
Date:   Mon, 09 Jan 2023 11:05:06 +0100
In-Reply-To: <4de1f964-b623-2b31-c044-60cc188fc134@quicinc.com>
References: <1394547394-3910-1-git-send-email-luciano.coelho@intel.com>
         <1394547394-3910-4-git-send-email-luciano.coelho@intel.com>
         <4de1f964-b623-2b31-c044-60cc188fc134@quicinc.com>
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

On Mon, 2023-01-09 at 17:39 +0800, Wen Gong wrote:
> On 3/11/2014 10:16 PM, Luciano Coelho wrote:
> > ...
> > +int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
> > +				 const struct cfg80211_chan_def *chandef,
> > +				 enum ieee80211_chanctx_mode chanmode,
> > +				 u8 radar_detect)
> > +{
> > +	struct ieee80211_local *local =3D sdata->local;
> > +	struct ieee80211_sub_if_data *sdata_iter;
> > +	enum nl80211_iftype iftype =3D sdata->wdev.iftype;
> > +	int num[NUM_NL80211_IFTYPES];
> > +	struct ieee80211_chanctx *ctx;
> > +	int num_different_channels =3D 1;
> > +	int total =3D 1;
> > +
> > +	lockdep_assert_held(&local->chanctx_mtx);
> > +
> > +	if (WARN_ON(hweight32(radar_detect) > 1))
> > +		return -EINVAL;
> > +
> > +	if (WARN_ON(chanmode =3D=3D IEEE80211_CHANCTX_SHARED && !chandef->cha=
n))
> > +		return -EINVAL;
> > +
> > +	if (WARN_ON(iftype >=3D NUM_NL80211_IFTYPES))
> > +		return -EINVAL;
> > +
> > +	/* Always allow software iftypes */
> > +	if (local->hw.wiphy->software_iftypes & BIT(iftype)) {
> > +		if (radar_detect)
> > +			return -EINVAL;
> > +		return 0;
> > +	}
> > +
> > +	memset(num, 0, sizeof(num));
> > +
> > +	if (iftype !=3D NL80211_IFTYPE_UNSPECIFIED)
> > +		num[iftype] =3D 1;
> > +
> > +	list_for_each_entry(ctx, &local->chanctx_list, list) {
> > +		if (ctx->conf.radar_enabled)
> > +			radar_detect |=3D BIT(ctx->conf.def.width);
> > +		if (ctx->mode =3D=3D IEEE80211_CHANCTX_EXCLUSIVE) {
> > +			num_different_channels++;
> > +			continue;
> > +		}
> > +		if ((chanmode =3D=3D IEEE80211_CHANCTX_SHARED) &&
> > +		    cfg80211_chandef_compatible(chandef,
> > +						&ctx->conf.def))
> > +			continue;
> > +		num_different_channels++;
> > +	}
> > +
> > +	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
> > +		struct wireless_dev *wdev_iter;
> > +
> > +		wdev_iter =3D &sdata_iter->wdev;
> > +
> > +		if (sdata_iter =3D=3D sdata ||
> > +		    rcu_access_pointer(sdata_iter->vif.chanctx_conf) =3D=3D NULL ||
> > +		    local->hw.wiphy->software_iftypes & BIT(wdev_iter->iftype))
> > +			continue;
> > +
> > +		num[wdev_iter->iftype]++;
> > +		total++;
> > +	}
> > +
> > +	if (total =3D=3D 1 && !radar_detect)
> > +		return 0;
> > +
>=20
> should also check with cfg80211_check_combinations() when total =3D=3D 1 =
and=20
> num_different_channels > 1 ?
>=20
> When MLO is enabled, it could have 2 channels for one ieee80211_sub_if_da=
ta.
>=20

Heh. You're commenting on a patch from 2014, well before MLO :-)

Not sure what happens in the code now?

johannes
