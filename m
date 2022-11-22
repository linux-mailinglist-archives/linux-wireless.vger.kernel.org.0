Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595606341C6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiKVQoV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 11:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiKVQoE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 11:44:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873D725E0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 08:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8Lc0u507HrdvqGzH6arePQyMKi1cqvhnv7saDo8AjMc=;
        t=1669135431; x=1670345031; b=UXpb/GGxO+Ggcp1l2PkQBxamay/QgrerNe8ax6rtrjckcNp
        SBFzY3AiFYfIkFh2cxkBM8uXGRiJQwjcjSzKg6lGvHOa+WVHIjEBK8KXxTkZgzq0WZc9bAwtg88Jz
        W6JnSDYLDQHGbPZvRhMoIyhVHl9TUbdMRf/4hmzm5I8h7WhUrpJEXbVyo7rarK0Qdbl+HXeoFJ6eP
        AX6r+TMqmLGjkqBQO5Egk9fxZgE6xWlrKRVpHLnFaeb5OSVWHnrnjS23y+33FrBfiMQeA7Fka6GjN
        0IoMQN+ZasgLu6mOCFtGkmQxag5v7qbTiCstxtM9hkDIsw5nTz/ChJsAjmoCN66w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oxWN8-006PNE-2o;
        Tue, 22 Nov 2022 17:43:46 +0100
Message-ID: <95ad4207e62b4990476d867bd240fef3ede31369.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] mac80211: mlme: Handle Puncturing information
 received from the AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kang Yang <quic_kangyang@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Aloka Dixit <quic_alokad@quicinc.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        "Carl Huang (QUIC)" <quic_cjhuang@quicinc.com>
Date:   Tue, 22 Nov 2022 17:43:45 +0100
In-Reply-To: <e4db49e4-6363-0c8d-10dd-a1a564da2542@quicinc.com>
References: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
         <e4db49e4-6363-0c8d-10dd-a1a564da2542@quicinc.com>
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

On Mon, 2022-11-21 at 15:29 +0800, Kang Yang wrote:
> Hi:
> 	1.Do you have any new version about this RFC patch?

Not really, no.


> 	2.I have some questions about this patch:

(a couple of blank lines and some trimming of the context really would
help ... please try next time)

> > +static u16
> > +ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation =
*eht_oper,
> > +				 struct cfg80211_chan_def *chandef, u16 bitmap)
> > +{
> > +	int sta_center_freq =3D ieee80211_channel_to_frequency(eht_oper->ccfs=
,
> > +							     chandef->chan->band);
> > +	u32 center_freq =3D chandef->chan->center_freq;
> The shift is calculated by the difference of old and new channel center
> frequency.The new channel center frequency should be=20
> "chandef->center_freq1" after BW negotitaion.
> "chandef->chan->center_freq" is the primary channel frequency.


Yeah I think we did fix a couple of bugs in this area later.

> > +	u8 sta_bw =3D 20 * BIT(u8_get_bits(eht_oper->chan_width,
> > +					 IEEE80211_EHT_OPER_CHAN_WIDTH));
> > +	u8 bw =3D 20 * BIT(ieee80211_chan_width_to_rx_bw(chandef->width));
> > +	int sta_start_freq =3D sta_center_freq - sta_bw / 2;
> > +	int start_freq =3D center_freq - bw / 2;
> > +	u16 shift =3D (start_freq - sta_start_freq) / 20;
> > +	u16 mask =3D BIT(sta_bw / 20) - 1;
> The mask is used to extra the valid bit according to the new BW,
> but current algorithm is using the old bandwidth.


:)

> > +	while (chandef->width > NL80211_CHAN_WIDTH_40) {
> > +		extracted =3D
> > +			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
> > +							 bitmap);
> > +
> > +		if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
> > +							      chandef->width))
> Here extract the bitmap according new negotiated BW. After extracting,=
=20
> check whether it is valid.
> I think you should use "&extracted"  instead of "&bitmap"

Yeah I guess that makes sense.

I don't know what fixes we have and what version of this patch this is.

> > +static bool ieee80211_config_puncturing(struct ieee80211_sub_if_data *=
sdata,
> > +					const struct ieee80211_eht_operation *eht_oper,
> > +					u64 *changed)
> > +{
> > +	u16 bitmap, extracted;
> > +	u8 bw;
> > +
> > +	if (!u8_get_bits(eht_oper->present_bm,
> > +			 IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
> > +		bitmap =3D 0;
> > +	else
> > +		bitmap =3D get_unaligned_le16(eht_oper->disable_subchannel_bitmap);
> > +
> Should check initial bitmap here.


What do you mean by "initial" here?

> > +	extracted =3D ieee80211_extract_dis_subch_bmap(eht_oper,
> > +						     &sdata->vif.bss_conf.chandef,
> > +						     bitmap);
> > +
> > +	/* accept if there are no changes */
> > +	if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
> > +	    extracted =3D=3D sdata->vif.bss_conf.eht_puncturing)
> > +		return true;
> > +
> > +	bw =3D u8_get_bits(eht_oper->chan_width, IEEE80211_EHT_OPER_CHAN_WIDT=
H);
> > +
> > +	if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap, bw)) {
> > +		sdata_info(sdata,
> > +			   "Got an invalid disable subchannel bitmap from AP %pM: bitmap =
=3D 0x%x, bw =3D 0x%x. disconnect\n",
> > +			    sdata->u.mgd.associated->bssid, bitmap, bw);
> > +		return false;
> > +	}
> The initial bitmap received from the AP is checked here.
> I think it should be carried out before the extraction above.

Ah, yes I guess that makes sense.


Anyway the more fundamental thing we have to figure out here (and thanks
for bringing this back) is how we treat the puncturing - QCOM's AP-side
puncturing patch treated it as part of the chandef, but that's not
working well for client side ...

johannes
