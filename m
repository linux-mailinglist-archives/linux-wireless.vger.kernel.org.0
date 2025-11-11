Return-Path: <linux-wireless+bounces-28829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F10C4C228
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 08:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8314B4E44C9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C932ABC7;
	Tue, 11 Nov 2025 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CttToAai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA731BC80;
	Tue, 11 Nov 2025 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846710; cv=none; b=KeCsVvcZIZRmZUlnPrQ1YvFgUhMAH+NvzF34CwVXpqR5IGn6tHOYLnPKAgxuiD8yq8TCJL08A1dvyI1hAY4KftCFFehyYk7gBo1aGqLwYN8voG7+7fRknusn1xo1Jouy1cbevloHneLTZmxLqTrVQV3XWTI6ArFEDN8A1MekZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846710; c=relaxed/simple;
	bh=VKTPDuSDo0PtjYw5zIV5J3qmh6jlvOMhRaVGjBC5vPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/B9CdFqg7tEoF45dC3sR33MTbIyIq4/npDCdw0Giuj8bNzfbrVBda5D8n6QKpfTTE0LJH9+/GNxfkEh3fQ3TVIh7sIhg95TKHHh/GdmSjn0ZpmaJheOBDmfJj7eBZ+VHodTZYPTiTlqKcvMKJwe6fNXwrFtcV+eqfokX1WOPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CttToAai; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cPwUdaWPpIPK5nkTowJRXHUPIqrByqhdlgfyB0JObBc=;
	t=1762846708; x=1764056308; b=CttToAaiAuGjBLGVvhUyE/f6ldG+UYHylFLNHFpqdZ+ZNWP
	Gc8sffNaCo0IaZVQP1YK939ayyWY+V06Us6quNb/lExFjdHwooFh+OEcqI0cEpv3vdwA2nbAL+wcx
	GEzGQj65DC+Kij2up1R3SbjbOPL17hosLSmaVy03dp1XNnZVc30/YTA3JwDjWSU8tfaNvNm/YwuRb
	s9zT5sKZ8ehrS31JS7nvQAC/2pmc4GLIe16u9q2ZiR65vGJ4sZOVQP9GNqCGQsZu1zTCo9401BXxQ
	qAH+5M6Z9fFUGGEm+pJRIWhIL3QwPDaA5GH+4lXGvnIRc41riY3kx4si8pyHL6RA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIixG-0000000EzUb-3xIg;
	Tue, 11 Nov 2025 08:38:19 +0100
Message-ID: <01be9a3b952fbcfe26d4a4d487a51d26ba07b13f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mwl8k: inject DSSS Parameter Set element into
 beacons if missing
From: Johannes Berg <johannes@sipsolutions.net>
To: Pawel Dembicki <paweldembicki@gmail.com>, linux-wireless@vger.kernel.org
Cc: Antony Kolitsos <zeusomighty@hotmail.com>, Thomas Fourier	
 <fourier.thomas@gmail.com>, Roopni Devanathan <quic_rdevanat@quicinc.com>, 
	linux-kernel@vger.kernel.org
Date: Tue, 11 Nov 2025 08:38:18 +0100
In-Reply-To: <20251111073134.2774120-2-paweldembicki@gmail.com>
References: <20251111073134.2774120-2-paweldembicki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> ---
> V2:
>   - added "wifi:" prefix to commit title
>   - renamed "DS Params" -> "DSSS Parameter Set"
>   - Insert WLAN_EID_DS_PARAMS after WLAN_EID_SSID, WLAN_EID_SUPP_RATES
>     and WLAN_EID_EXT_SUPP_RATES

FWIW, per spec it should be between them:

- SSID
- Supported Rates
- DSSS Parameter Set
- TIM
- Country
- ...
- Extended Supported Rates

so actually Extended Supported Rates is also in the _tail_ part of the
cfg80211 API.


> ---
>  drivers/net/wireless/marvell/mwl8k.c | 71 ++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/=
marvell/mwl8k.c
> index 891e125ad30b..914a566d700a 100644
> --- a/drivers/net/wireless/marvell/mwl8k.c
> +++ b/drivers/net/wireless/marvell/mwl8k.c
> @@ -2966,6 +2966,52 @@ mwl8k_cmd_rf_antenna(struct ieee80211_hw *hw, int =
antenna, int mask)
>  /*
>   * CMD_SET_BEACON.
>   */
> +
> +static bool mwl8k_beacon_has_ds_params(const u8 *buf, int len)
> +{
> +	const struct ieee80211_mgmt *mgmt =3D (const void *)buf;
> +	int ies_len;
> +
> +	if (len <=3D offsetof(struct ieee80211_mgmt, u.beacon.variable))
> +		return false;
> +
> +	ies_len =3D len - offsetof(struct ieee80211_mgmt, u.beacon.variable);
> +
> +	return cfg80211_find_ie(WLAN_EID_DS_PARAMS, mgmt->u.beacon.variable,
> +				ies_len) !=3D NULL;
> +}
> +
> +static void mwl8k_beacon_copy_inject_ds_params(struct ieee80211_hw *hw,
> +					       u8 *buf_dst, const u8 *buf_src,
> +					       int src_len)
> +{
> +	const struct ieee80211_mgmt *mgmt =3D (const void *)buf_src;
> +	static const u8 before_ds_params[] =3D {
> +			WLAN_EID_SSID,
> +			WLAN_EID_SUPP_RATES,
> +			WLAN_EID_EXT_SUPP_RATES,
> +	};

nit: seems on tab would be nicer?

> -	cmd =3D kzalloc(sizeof(*cmd) + len, GFP_KERNEL);
> +	if (!ds_params_present)
> +		/*
> +		 * mwl8k firmware requires a DS Params IE with the current
> +		 * channel in AP beacons. If mac80211/hostapd does not
> +		 * include it, inject one here. IE ID + length + channel
> +		 * number =3D 3 bytes.
> +		 */
> +		final_len +=3D 3;
> +

another nit: I'd probably add braces

johannes

