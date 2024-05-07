Return-Path: <linux-wireless+bounces-7274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905408BDEEA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 11:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCEBB24D97
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6A9149C6F;
	Tue,  7 May 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KFpv1AIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225414D71E
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075259; cv=none; b=nJdH58q+/z4K5pv1tDQXsaVMbWuJlIcVybwD0xWufAfWMrD8kCytBqqxmdDzbQgEsKbsj63iWF3hYRoB1c5xmaKeFO2Zv5285jAZZrQBj0B3BqvQ0/ey7HnBRwvtmb7A8dMK9uewZ9f7y9kGLNg4i2Gy1xHGfnSK+MWC5+FRt1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075259; c=relaxed/simple;
	bh=fuGTSRW6exK5kNAnCoIRnIaz4h9RDFvQTI/YCnvBrYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB2nOLz013QIkxWHm13Zhu+LjdTSHYIhaeg2RNZ4YAAXIVdla30YR2oT5lsQbgw7eKp+7lJxXdrZ7kLezmN7Zqqo6uvTXRco3rIMT4fbwGTY5PfDVsEzpVjTrNsgvyGGCf9Rv4DTeloWm/ml1/L90AXKVMZRqAxg3LbjKlEKpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KFpv1AIG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LurN0AoXVs7lJP5qznIj0mIEYvw7HLt7cU3TzpWPjkM=;
	t=1715075253; x=1716284853; b=KFpv1AIG6wQdPQZrjywcDnK9komAeTTuwLBsSk9Fcw9L4WH
	hNXuwChmMZlZJPmtLtYouLcBB5Ot9v0gy9Ni5J5PBkrqUgtS+6aPPN9pxgiZzEWcERNLM03aFEHAu
	cdS2alzmQZZtQNnoYv8QKbe2QSTzrle2I/uHKwhp1OETye0pKhFDkADj73qfICiVt442C1k0pb5vL
	VYKt1ZR67XH5/J2/CsStq7peeUOqeTmaiJyytkMGsK9YDg8Qxu06ruCzV4HV65I4JlWaUUUjvwrKM
	+2VR/+tUc9Zt7uny9lCt8qi+6sYa00fhcLhHHpMp1gGlpWrnBR688mSX/d/6iQuw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s4HQ2-00000009TjX-09pz;
	Tue, 07 May 2024 11:47:30 +0200
Message-ID: <3f8e4d6d0f2facde80ad82b5b3060eb0af0958a4.camel@sipsolutions.net>
Subject: Re: [PATCH RFC] wifi: cfg80211: Refactor interface combination
 input parameter
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 07 May 2024 11:47:29 +0200
In-Reply-To: <20240427031503.22870-1-quic_periyasa@quicinc.com>
References: <20240427031503.22870-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-04-27 at 08:45 +0530, Karthikeyan Periyasamy wrote:
> Currently, the interface combination input parameter num_different_channe=
ls
> and iftype_num are directly filled in by the caller under the assumption
> that all channels and interfaces belong to a single hardware device. This
> assumption is incorrect for multi-device interface combinations because
> each device supports a different set of channels and interfaces. As
> discussed in [1], need to refactor the input parameters to encode enough
> data to handle both single and multiple device interface combinations.
> This can be achieved by encoding the frequency and interface type under
> the interface entity itself. With this new input parameter structure, the
> cfg80211 can classify and construct the device parameters, then verify th=
em
> against the device specific interface combinations.

^^ This should probably mention _something_ about links too :)


> [1]: https://lore.kernel.org/linux-wireless/ca70eeb3cdee1e8c3caee69db595b=
c8160eb4115.camel@sipsolutions.net/
>=20
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>=20
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>  drivers/net/wireless/ath/wil6210/cfg80211.c   |  44 +++++--
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  60 +++++++--
>  .../net/wireless/quantenna/qtnfmac/cfg80211.c |  32 +++--
>  include/net/cfg80211.h                        |  37 +++++-
>  net/mac80211/util.c                           | 124 +++++++++++++++---
>  net/wireless/util.c                           |  56 ++++++--
>  6 files changed, 276 insertions(+), 77 deletions(-)
>=20
> diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wi=
reless/ath/wil6210/cfg80211.c
> index 8993028709ec..3f9f5f56bd19 100644
> --- a/drivers/net/wireless/ath/wil6210/cfg80211.c
> +++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
> @@ -625,17 +625,25 @@ static int wil_cfg80211_validate_add_iface(struct w=
il6210_priv *wil,
>  {
>  	int i;
>  	struct wireless_dev *wdev;
> -	struct iface_combination_params params =3D {
> -		.num_different_channels =3D 1,
> -	};
> +	struct iface_combination_params params =3D { 0 };

nit: just use "=3D {}".

> +	ifaces =3D kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
> +	if (!ifaces)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(pos, &cfg->vif_list, list) {
> +		if (params.num_iface >=3D total_iface)
> +			continue;

??
Seems like that should be a WARN_ON or something?

> +	struct iface_combination_interface *ifaces =3D NULL;
> +	u16 total_iface =3D 0;
> +	int ret;
> =20
>  	list_for_each_entry(pos, &cfg->vif_list, list)
> -		params.iftype_num[pos->wdev.iftype]++;
> +		total_iface++;
> =20
> -	params.iftype_num[new_type]++;
> -	return cfg80211_check_combinations(cfg->wiphy, &params);
> +	ifaces =3D kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);

No point in "=3D NULL" if you overwrite it immediately.


> +/**
> + * struct iface_combination_iface_link - Interface combination link para=
meter
> + *
> + * Used to pass link specific interface combination parameters
> + *
> + * @freq: center frequency used for verification against the different c=
hannels
> + */
> +struct iface_combination_iface_link {
> +	u32 freq;
> +};
> +
> +/**
> + * struct iface_combination_interface - Interface parameter for iface co=
mbination
> + *
> + * Used to pass interface specific parameter for iface combination
> + *
> + * @iftype: interface type as specified in &enum nl80211_iftype.
> + * @links: array with the number of link parameter used for verification
> + * @num_link: the length of the @links parameter used in this interface
> + */
> +struct iface_combination_interface {
> +	enum nl80211_iftype iftype;
> +	struct iface_combination_iface_link links[IEEE80211_MLD_MAX_NUM_LINKS];
> +	u8 num_link;

Might be simpler (for the producers at least, but not really much more
difficult for the consumer) to just remove num_link, use the link ID as
the index, and declare freq=3D=3D0 means unused?

> - * @num_different_channels: the number of different channels we want
> - *	to use for verification
>   * @radar_detect: a bitmap where each bit corresponds to a channel
>   *	width where radar detection is needed, as in the definition of
>   *	&struct ieee80211_iface_combination.@radar_detect_widths
> - * @iftype_num: array with the number of interfaces of each interface
> - *	type.  The index is the interface type as specified in &enum
> - *	nl80211_iftype.
>   * @new_beacon_int: set this to the beacon interval of a new interface
>   *	that's not operating yet, if such is to be checked as part of
>   *	the verification
> + * @ifaces: array with the number of interface parameter use for verific=
ation
> + * @num_iface: the length of the @ifaces interface parameter
>   */
>  struct iface_combination_params {
> -	int num_different_channels;
>  	u8 radar_detect;
> -	int iftype_num[NUM_NL80211_IFTYPES];
>  	u32 new_beacon_int;
> +	const struct iface_combination_interface *ifaces;
> +	u16 num_iface;

The "new_beacon_int" also needs to be for a specific link, witha a
specific freq, so you can check for *that* part of the wiphy? Similarly
for radar_detect?

> +	if (iftype !=3D NL80211_IFTYPE_UNSPECIFIED || chandef) {
> +		struct iface_combination_interface *iface;
> +
> +		iface =3D &ifaces[params.num_iface];
> +		iface->iftype =3D iftype;
> +
> +		if (chandef && cfg80211_chandef_valid(chandef)) {
> +			iface->links[0].freq =3D chandef->chan->center_freq;
> +			iface->num_link++;
>  		}

Not sure I understand this.

> @@ -4009,14 +4029,37 @@ int ieee80211_check_combinations(struct ieee80211=
_sub_if_data *sdata,
>  					    wdev_iter->iftype, 0, 1))
>  			continue;
> =20
> -		params.iftype_num[wdev_iter->iftype]++;
> +		iface =3D &ifaces[params.num_iface];
> +		iface->iftype =3D wdev_iter->iftype;
> +
> +		rcu_read_lock();
> +		for_each_vif_active_link(&sdata_iter->vif, link_conf, link_id) {
> +			struct ieee80211_chanctx_conf *chanctx_conf;
> +			struct iface_combination_iface_link *link;
> +
> +			chanctx_conf =3D rcu_dereference(link_conf->chanctx_conf);
> +			if (chanctx_conf &&
> +			    cfg80211_chandef_valid(&chanctx_conf->def)) {

Why the valid check, btw? How could that possibly *not* be valid?

> +				link =3D &iface->links[iface->num_link];
> +				link->freq =3D chanctx_conf->def.chan->center_freq;
> +				iface->num_link++;
> +			}
> +		}
> +		rcu_read_unlock();

when you also have this?

But maybe separating out actual logic changes in mac80211 to a separate
patch would be good.

>  	list_for_each_entry_rcu(sdata, &local->interfaces, list)
> -		params.iftype_num[sdata->wdev.iftype]++;
> +		total_iface++;
> +
> +	if (!total_iface)
> +		goto skip;
> +
> +	ifaces =3D kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
> +	if (!ifaces)
> +		return -ENOMEM;
> +
> +	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> +		struct iface_combination_interface *iface;
> +
> +		if (params.num_iface >=3D total_iface)
> +			continue;
> +
> +		iface =3D &ifaces[params.num_iface];
> +		iface->iftype =3D sdata->wdev.iftype;
> +
> +		rcu_read_lock();
> +		for_each_vif_active_link(&sdata->vif, link_conf, link_id) {
> +			struct ieee80211_chanctx_conf *chanctx_conf;
> +			struct iface_combination_iface_link *link;
> +
> +			chanctx_conf =3D rcu_dereference(link_conf->chanctx_conf);
> +			if (chanctx_conf &&
> +			    cfg80211_chandef_valid(&chanctx_conf->def)) {
> +				link =3D &iface->links[iface->num_link];
> +				link->freq =3D chanctx_conf->def.chan->center_freq;
> +				iface->num_link++;
> +			}
> +		}
> +		rcu_read_unlock();
> +
> +		params.num_iface++;
> +	}

Please don't add the same code twice.


johannes

