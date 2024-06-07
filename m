Return-Path: <linux-wireless+bounces-8672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5168FFF94
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07541C21219
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3778C9A;
	Fri,  7 Jun 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MFqvTOaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8A12E1C1
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752774; cv=none; b=S7XGMWW0zJb1q6q266x0kzKAD9/8DaRCgAXukncIW+bhkZ2Y0je0T0N4HgqT5DpFQ+qVKkDE40zcu/E97enmKR8Mk33IXpPBS9z5Xl9Lb04jTDG6rtSx0TO6tuTeUMJ/hbd7wg8IkalmANrlNPbGnt3C7zSQkBWqrQ9KxzVmi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752774; c=relaxed/simple;
	bh=w65lxOtJy3AUrfzDNltlSjXfUA8MPLYFUal35gi2TkA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSh7JYIGtLlMA2rFZofx84WbW9wc7crrOciUsBw9Dqi+hbVSPDWFJ5rhkMpmRsBb6WUDIsbxUiBdTNtBwH7RwCaxE6R6TOJKPyT8TrICHWXiytEADlo4FmAgw5z05bXjRbHhrmbsIwhBbxw//hQ+LCop3tenD2fMNeFgwo8JZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MFqvTOaA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wNDpLAZwU/EYJiwT4OGqCeCzsKMxMr8tNN7YDNbfUtI=;
	t=1717752769; x=1718962369; b=MFqvTOaAWKJg8pdwDQhBHIYy9SYq/19kB8+uPsDTGM0dETW
	JVyEkz36V+Pj2X2H0RFQKThH4+FkLM578OGbByozY30HG8W2xeUGP0vbmfVzYprOMzef3pA1DJCBd
	FR1g2zlqTUgpEx6B66VypmCL8cx3rlzvobg7eoY+xlkfDsA8yuqunLSflExyjEtESULxJPTNgH5nD
	e88ptkiE14zK+QHLv+8308/YSHtgbSk/iOIf/FvZcqWor8yzDJ80gN5nBh7CbRKtWsGJ35OXhBhcE
	fFt2AFCXMEm1YBid8TaUPEhl2Xo05+2qVX5mMLMR3GMuFZXfa7uGw2MupiANC0SA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFVxl-00000000rzy-3mMt;
	Fri, 07 Jun 2024 11:32:46 +0200
Message-ID: <65e01dcab3e934b1295fe64d9d311bd1fbdd2665.camel@sipsolutions.net>
Subject: Re: [RFC v3 3/8] wifi: cfg80211: extend interface combination check
 for multi-radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 07 Jun 2024 11:32:45 +0200
In-Reply-To: <754815488294f5b7f599b2adba085f1889b53b1a.1717696995.git-series.nbd@nbd.name>
References: 
	<cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
	 <754815488294f5b7f599b2adba085f1889b53b1a.1717696995.git-series.nbd@nbd.name>
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

On Thu, 2024-06-06 at 20:07 +0200, Felix Fietkau wrote:
>=20
> @@ -4577,6 +4579,7 @@ struct mgmt_frame_regs {
>   *
>   * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
>   * @set_ttlm: set the TID to link mapping.
> + * @get_radio_mask: get bitmask of radios in use
>   */
>  struct cfg80211_ops {
>  	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
> @@ -4938,6 +4941,8 @@ struct cfg80211_ops {
>  				    struct cfg80211_set_hw_timestamp *hwts);
>  	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
>  			    struct cfg80211_ttlm_params *params);
> +	int	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev,
> +				  u32 *mask);


not sure I see the point of this being a callback rather than being
passed in?

(Also, if really needed, do you actually expect a device with 32 radios?
if not you can use a return value instead of u32 *mask out pointer :) )


> +DEFINE_EVENT(wiphy_netdev_evt, rdev_get_radio_mask,
> +	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
> +	TP_ARGS(wiphy, netdev)
> +);

and if we do need it that really should trace not just the fact that it
happened but also the return value and mask

>  static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beac=
on_int,
>  				       u32 *beacon_int_gcd,
> -				       bool *beacon_int_different)
> +				       bool *beacon_int_different,
> +				       const struct wiphy_radio *radio)
>  {
> +	struct cfg80211_registered_device *rdev;
>  	struct wireless_dev *wdev;
> +	int radio_idx =3D -1;
> =20
>  	*beacon_int_gcd =3D 0;
>  	*beacon_int_different =3D false;
> +	if (radio)
> +		radio_idx =3D radio - wiphy->radio;

This can go oh so wrong ... and technically even be UB. I'd rather pass
the index from the driver, I guess, and validate it against n_radios.
=20
> +	rdev =3D wiphy_to_rdev(wiphy);
>  	list_for_each_entry(wdev, &wiphy->wdev_list, list) {
>  		int wdev_bi;
> +		u32 mask;
> =20
>  		/* this feature isn't supported with MLO */
>  		if (wdev->valid_links)
>  			continue;

Are we expecting this to change? because the premise of this patchset is
MLO support, and yet with real MLO we won't get here?

Or is that because non-MLO interfaces could be created on this wiphy?

> =20
> +		if (radio_idx >=3D 0) {
> +			if (rdev_get_radio_mask(rdev, wdev->netdev, &mask))
> +				continue;


here: given that 'radio'/'radio_idx' is passed in, not sure I see why
the mask couldn't also be passed in?

> +			if (!(mask & BIT(radio_idx)))
> +				continue;

that could use a comment

> -	for (i =3D 0; i < wiphy->n_iface_combinations; i++) {
> -		const struct ieee80211_iface_combination *c;
> +	if (radio) {
> +		c =3D radio->iface_combinations;
> +		n =3D radio->n_iface_combinations;
> +	} else {
> +		c =3D wiphy->iface_combinations;
> +		n =3D wiphy->n_iface_combinations;
> +	}
> +	for (i =3D 0; i < n; i++, c++) {

that c++ is a bit too hidden for my taste there, but YMMV and I guess if
I wasn't reading the diff it'd be more obvious :)

johannes

