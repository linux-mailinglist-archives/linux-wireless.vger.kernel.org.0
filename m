Return-Path: <linux-wireless+bounces-9770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4791E0F8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283131F23214
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2214B96C;
	Mon,  1 Jul 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DJn5reAZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561801E49B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841185; cv=none; b=ejaBGnseT8mOdIpymNIP3unRVDbYD/ISLe8D9ZeBIDQzD5uScWsZ8lf6TM5jhxvvxSgtWKdgrgS//sFJ8BVaGk094Utx2IJDKv7MAAho/G2biA9vqkxHI6/LJImRNA0owcJEZVOFTJwJqPdZNoPRbHqf9rIaBGtC8oZEZIyjveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841185; c=relaxed/simple;
	bh=sV+UYGXeiYa0qB+4k8DJcPj8PKsE+2hNL50FHIQL2pU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=scSaSTalkyvvRvEunkz5WXuOrNA+8qfo6osBdZYhgKK3deoW3v31nnCwLSpOBEX8BHLZ580h0MdiRTwV2kA/DnYw2Ywsbx8JsczGBpwUsGJok9rgkVTw2KLAyfLtqerTLFkT1QfuCj0DEovI7JpZRI0XefcpdGaIjFCdq5pjOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DJn5reAZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lv/xWp67jD+3LKhR3cr2e3EDo3WK450xk+C/um+LvvM=;
	t=1719841183; x=1721050783; b=DJn5reAZizLNmP4dSxL0zoGeL6UogbmW7P7xT4EB6dhG6BR
	MhdAcbe/5XYWHcBP/W1mVwuLIQzCFTb6QNKl2722s0sYGDENnFpeSt1tJL3l/UldD/WHFSSAiFJTe
	lgNhuM74T6AnV/tbatqmv/pzHsk86G1ymj83MWJAM5NTsFsv2vlRp5IHVn8zKIgCa4ucPwUhzZWNX
	1fKwZpBsHK4IuSKYPabGY1MLcdFOfKpV8GRTFDiZIAT7BeiyzxPc2S78iVQnIcNb04kANZPOZZjbY
	zC8nQxd3feqDL+P0WzNROHeiiCf9foH3uvoNSuLaIxq8H4kYASgTSEellupzY3mA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOHFq-00000002HCB-30iR;
	Mon, 01 Jul 2024 15:39:39 +0200
Message-ID: <5912f046e25d33ca429904483d95c2a648db5962.camel@sipsolutions.net>
Subject: Re: [PATCH v2 07/10] wifi: mac80211: extend ifcomb check functions
 for multi-radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Mon, 01 Jul 2024 15:39:37 +0200
In-Reply-To: <b136fe952d4a202da8831b18f3b17012354372c6.1719733819.git-series.nbd@nbd.name>
References: 
	<cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
	 <b136fe952d4a202da8831b18f3b17012354372c6.1719733819.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-06-30 at 09:50 +0200, Felix Fietkau wrote:
>=20
> +++ b/net/mac80211/ieee80211_i.h
> @@ -2043,6 +2043,7 @@ static inline bool ieee80211_sdata_running(struct i=
eee80211_sub_if_data *sdata)
>  {
>  	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
>  }
> +u32 ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev=
);

nit: I feel like maybe there's a better place, and even if not there
should be a blank line? :)

> =20
>  /* link handling */
>  void ieee80211_link_setup(struct ieee80211_link_data *link);
> @@ -2640,8 +2641,8 @@ void ieee80211_recalc_dtim(struct ieee80211_local *=
local,
>  int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>  				 const struct cfg80211_chan_def *chandef,
>  				 enum ieee80211_chanctx_mode chanmode,
> -				 u8 radar_detect);
> -int ieee80211_max_num_channels(struct ieee80211_local *local);
> +				 u8 radar_detect, int radio_idx);
> +int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_=
idx);
>  void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
>  				       struct ieee80211_chanctx *ctx);

but maybe just put it next to ieee80211_max_num_channels()?

> +static u32
> +__ieee80211_get_radio_mask(struct ieee80211_sub_if_data *sdata)
> +{
> +	struct ieee80211_bss_conf *link_conf;
> +	struct ieee80211_chanctx_conf *conf;
> +	unsigned int link_id;
> +	u32 mask =3D 0;
> +
> +	for_each_vif_active_link(&sdata->vif, link_conf, link_id) {
> +		conf =3D rcu_dereference(link_conf->chanctx_conf);
> +		if (!conf || conf->radio_idx < 0)
> +			continue;
> +
> +		mask |=3D BIT(conf->radio_idx);
> +	}
> +
> +	return mask;
> +}
> +
> +u32 ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev=
)
> +{
> +	struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev);
> +
> +	return __ieee80211_get_radio_mask(sdata);

Here's the context stuff I was talking about - you're using
rcu_dereference() when it almost seems it should be sdata_dereference()
(or so, it's all equivalent now with wiphy dereference)?

I'm not sure how this even gets to be in an RCU critical section, e.g.
when called via

> +static bool
> +ieee80211_sdata_uses_radio(struct ieee80211_sub_if_data *sdata, int radi=
o_idx)
> +{
> +	if (radio_idx < 0)
> +		return true;
> +
> +	return __ieee80211_get_radio_mask(sdata) & BIT(radio_idx);
> +}

...

> +static void
> +ieee80211_fill_ifcomb_params(struct ieee80211_local *local,
> +			     struct iface_combination_params *params,
> +			     const struct cfg80211_chan_def *chandef,
> +			     struct ieee80211_sub_if_data *sdata)
> +{

...

> +	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
> +		struct wireless_dev *wdev_iter;
> +
> +		wdev_iter =3D &sdata_iter->wdev;
> +
> +		if (sdata_iter =3D=3D sdata ||
> +		    !ieee80211_sdata_running(sdata_iter) ||
> +		    cfg80211_iftype_allowed(local->hw.wiphy,
> +					    wdev_iter->iftype, 0, 1))
> +			continue;
> +
> +		if (!ieee80211_sdata_uses_radio(sdata_iter, params->radio_idx))
> +			continue;


here?

Also the list_for_each_entry_rcu() seems weird (although I see that we
even have pre-existing code like that now), because e.g.

 ieee80211_open()
-> ieee80211_check_concurrent_iface()
-> ieee80211_check_combinations()

is called outside RCU critical section? There's an existing
list_for_each_entry_rcu() inside of it which seems like it should be a
problem, so maybe I'm missing something?

... investigates a bit ...

yeah I can't get even CONFIG_PROVE_RCU_LIST to spit out warnings, but
checking manually, we (generally) aren't in RCU critical section here,
at least not unconditionally.

johannes


