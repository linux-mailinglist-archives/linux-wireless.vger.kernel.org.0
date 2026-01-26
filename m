Return-Path: <linux-wireless+bounces-31174-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI8LNepJd2mLdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31174-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:03:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 773C887755
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC4CA3002E7B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51043321D7;
	Mon, 26 Jan 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pE4c1CWw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685763321D8
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425268; cv=none; b=QF0etdhRuI1nfiMNvf//qoQbVA7ZLuo/p4MNgPfaG8UJX6NWBdl7ceWop6kiWV3bOHFMXWEXC8DreL6V4WsRybEatbZI7QvNt7xlvGbT4lcT/4zKqvRM3EYN+ocYghpH+ED+m1qiks8crkpDtPRIcCN+cBxGs4Z6RISU4yTxHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425268; c=relaxed/simple;
	bh=qr+0oWF8WBfT++tu5B6igd3I6zb6hkxamk/HJp01UPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozVpJibXlXKgHsutmbG4L7Pg2kW1jX9aA4/Jlfama+O/nySf6DDOpit0bbeW7V+MXh1WoEZeEnel8AKC6BlkS84IWDIPpGG59bEP9RaA+CXjkeQAIv3DzDioPjd+XBAEa6eJGOVZrb1eLcuP74cwV3gV0N68zBYEM4/u2SSGT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pE4c1CWw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XvJrcXtn8iRvKT6VDEN9miPmbI0CvZ2DRzSRmtrceIs=;
	t=1769425266; x=1770634866; b=pE4c1CWwRcKJ+Yt0o2Sf8FTktifQysvV5dG7QnWg0gAfbkl
	wexNcalex88jj7G8W7XbKF6qIGpFCmjFhhRyt/DeHm7RPFncjUpJzMVU4y9wC1I1gE9AYXeF2H+Gn
	UwBFN/Ddv7+8TvwHgBRp9VLHElSFjVUjRrUN4OPlyCPGPGnWXb+gd/ht+aBPBiI0MIiWa/LluzelI
	fAC6lZgWgZm3SmpUbSvWwWMmWvEZW/JxUv2d88P4W7O3fHkOF4CSBuIoNGFLLFU77Ql33pgzsqOW3
	xI7NGoojwxqG5Qby2+2DCxzFFvxBgVtAyqsuqBdS4ITKF/wqFCgr9Q35/0mntFYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vkKL7-000000047Xj-15mx;
	Mon, 26 Jan 2026 12:01:01 +0100
Message-ID: <01e62344994a34daae0666b3873aa98e72fb5850.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/2] wifi: mac80211: Add eMLSR/eMLMR
 action frame parsing support
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, Shayne
 Chen	 <shayne.chen@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 26 Jan 2026 11:59:45 +0100
In-Reply-To: <20260125-mac80211-emlsr-v2-1-466329d61c88@kernel.org> (sfid-20260125_115209_143463_EFDC87D8)
References: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
	 <20260125-mac80211-emlsr-v2-1-466329d61c88@kernel.org>
	 (sfid-20260125_115209_143463_EFDC87D8)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31174-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,mediatek.com,gmail.com,collabora.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 773C887755
X-Rspamd-Action: no action

On Sun, 2026-01-25 at 11:51 +0100, Lorenzo Bianconi wrote:
>=20
> +static inline u8 ieee80211_get_emlsr_pad_delay_update(u8 param)
> +{
> +	u8 pad_delay =3D FIELD_GET(IEEE80211_EML_EMLSR_PAD_DELAY, param);

I generally prefer the typed versions and mac80211 (mostly?) uses those,
i.e. u8_get_bits() and friends, since they also cover endian conversions
where needed. Is there any reason you use FIELD_* versions here?

> +	if (pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
> +		pad_delay =3D 0;

Seems that should use a constant, rather than =3D0?

Also, is that really the right thing to do (also below) to just silently
cap it? Maybe that should be up to the caller? In some(/most/all)? cases
we should probably even just _reject_ frames that carry an invalid
value, which you can't do with this helper?

> +static inline u32 ieee80211_get_emlsr_trans_delay_update(u8 param)
> +{
> +	u16 trans_delay =3D FIELD_GET(IEEE80211_EML_EMLSR_TRANS_DELAY, param);
> +
> +	if (trans_delay > IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
> +		trans_delay =3D 0;
> +
> +	return trans_delay;

why does that use _three_ different types? Wouldn't u8 be sufficient?

> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1902,6 +1902,21 @@ enum ieee80211_offload_flags {
>  	IEEE80211_OFFLOAD_DECAP_ENABLED		=3D BIT(2),
>  };
> =20
> +struct ieee80211_eml_params {
> +	u8 control;
> +	u16 link_bitmap;
> +	union {
> +		struct {
> +			u16 emlsr_pad_delay;
> +			u16 emlsr_trans_delay;
> +		};
> +		struct {
> +			u8 mcs_map_count;
> +			u8 mcs_map_bw[9];
> +		};
> +	};
> +};

Maybe add kernel-doc? Also not sure the union really is worth it? It's a
tiny thing. Especially since you don't even label it - maybe if the
parts were labled emlsr and emlmr, and then you had emlsr.pad_delay?

(I'd label them anyway, of course, even if not a union.)

Also now the emlsr pad/trans delay are duplicated in the station info,
is that worth doing? You have to and do track them there too, anyway, as
we discussed on IRC, could just have the driver use them from there?

Per spec I'm also not sure what the MCS map should be when it's not
included in the frame?

> + * @set_eml_op_mode: Configure eMLSR/eMLMR operation mode in the underla=
y
> + *	driver according to the parameter received in the EML Operating mode
> + *	notification frame.

Maybe describe the link_id here, or move it to the params and describe
it in kernel-doc there?

> +static inline int drv_set_eml_op_mode(struct ieee80211_sub_if_data *sdat=
a,
> +				      struct ieee80211_sta *sta,
> +				      unsigned int link_id,
> +				      struct ieee80211_eml_params *eml_params)
> +{
> +	struct ieee80211_local *local =3D sdata->local;
> +	int ret =3D 0;

Shouldn't that be -EOPNOTSUPP?

> +static void
> +ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
> +				 struct ieee80211_mgmt *req, u8 act_len)
> +{
> +	int hdr_len =3D offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
> +	struct ieee80211_local *local =3D sdata->local;
> +	struct ieee80211_mgmt *mgmt;
> +	struct sk_buff *skb;
> +
> +	skb =3D dev_alloc_skb(local->tx_headroom + hdr_len + act_len);
> +	if (!skb)
> +		return;
> +
> +	skb_reserve(skb, local->tx_headroom);
> +	mgmt =3D skb_put_zero(skb, hdr_len);
> +	mgmt->frame_control =3D cpu_to_le16(IEEE80211_FTYPE_MGMT |
> +					  IEEE80211_STYPE_ACTION);
> +	memcpy(mgmt->da, req->sa, ETH_ALEN);
> +	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
> +	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
> +
> +	mgmt->u.action.category =3D WLAN_CATEGORY_PROTECTED_EHT;
> +	memcpy(&mgmt->u.action.u.eml_omn, &req->u.action.u.eml_omn, act_len);
> +	mgmt->u.action.u.eml_omn.control &=3D
> +		~(IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE |
> +		  IEEE80211_EML_CTRL_INDEV_COEX_ACT);
> +	ieee80211_tx_skb(sdata, skb);

It seems to me that it'd be better to not copy the request, but rather
build the response. It's not _that_ much data, and from the spec it
seems to me that e.g. the MCS map should be included in the response,
but you do that now, I think?

> +void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
> +				    struct sk_buff *skb)
> +{
> +	int hdr_len =3D offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
> +	enum nl80211_iftype type =3D ieee80211_vif_type_p2p(&sdata->vif);
> +	struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
> +	const struct wiphy_iftype_ext_capab *ift_ext_capa;
> +	struct ieee80211_mgmt *mgmt =3D (void *)skb->data;
> +	struct ieee80211_local *local =3D sdata->local;
> +	u8 control =3D mgmt->u.action.u.eml_omn.control;
> +	u8 *ptr =3D mgmt->u.action.u.eml_omn.variable;
> +	struct ieee80211_eml_params eml_params =3D {};
> +	struct sta_info *sta;
> +	u8 act_len =3D 3; /* action_code + dialog_token + control */
> +
> +	if (!ieee80211_vif_is_mld(&sdata->vif))
> +		return;
> +
> +	/* eMLSR and eMLMR can't be enabled at the same time */
> +	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) &&
> +	    (control & IEEE80211_EML_CTRL_EMLMR_MODE))
> +		return;
> +
> +	if ((control & IEEE80211_EML_CTRL_EMLMR_MODE) &&
> +	    (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE))
> +		return;
> +
> +	ift_ext_capa =3D cfg80211_get_iftype_ext_capa(local->hw.wiphy, type);
> +	if (!ift_ext_capa)
> +		return;
> +
> +	if (!status->link_valid)
> +		return;
> +
> +	sta =3D sta_info_get_bss(sdata, mgmt->sa);
> +	if (!sta)
> +		return;
> +
> +	if (control & IEEE80211_EML_CTRL_EMLSR_MODE) {
> +		if (!(ift_ext_capa->eml_capabilities &
> +		      IEEE80211_EML_CAP_EMLSR_SUPP))
> +			return;
> +
> +		if (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE) {
> +			u16 eml_cap =3D sta->sta.eml_cap;
> +			u8 pad_delay, trans_delay;
> +
> +			/* Update sta padding and transition delay */
> +			pad_delay =3D
> +				ieee80211_get_emlsr_pad_delay_update(ptr[3]);
> +			trans_delay =3D
> +				ieee80211_get_emlsr_pad_delay_update(ptr[3]);

It seems to me you're missing a bunch of input validation?

> +
> +			eml_cap &=3D ~(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY |
> +				     IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
> +			eml_cap |=3D FIELD_PREP(IEEE80211_EML_EMLSR_PAD_DELAY,
> +					      pad_delay) |
> +				   FIELD_PREP(IEEE80211_EML_EMLSR_TRANS_DELAY,
> +					      trans_delay);
> +			sta->sta.eml_cap =3D eml_cap;

Same comment about typed bitfield accessors, and u8_replace_bits() would
even shorten that quite a bit.

> +	if (skb->len < hdr_len + act_len)
> +		return;

bit late that :)

johannes

