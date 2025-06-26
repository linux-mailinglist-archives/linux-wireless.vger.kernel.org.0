Return-Path: <linux-wireless+bounces-24544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E2AE9DC3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7331316E020
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975521CA18;
	Thu, 26 Jun 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fN0VrDgc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F181EB2F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941979; cv=none; b=uGxCjZs7HXqTv5kJNgXZrA0liEA/uZBAyE9I6StfkXSrn4rh1DeKmXnnV1WIvXnvkXgum3tI26w/nJzti1UubNF50jKID/OZdEFcTurTmOmWRfYkSOt4MdXhJyV3EAuA5ztR595nYgFcJl3QJaYywYEySbsuUbHyOPyMha0csbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941979; c=relaxed/simple;
	bh=g2hqAew2KcyvRs0qg/WeOf9Mmedze2U/3UUJ0t4ql24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mm+96227veP25YMCXXJa/D0Cu0Rjgw4zh5/AsJxEYasKkrIvhDluRoIrY555siuXUpHRpGIlYVWSgeay7unf1Pdm4f8n61sOjmn0DoWFl1Iqmn580F2TuAf14o+ZIhGFmihFsF8tFDEEb8z5LjIeHGnloiTcHwY5SVenxOv1bIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fN0VrDgc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BjpbYn5KC5fcA1frvlYurkHCT8TfX07S70ZDyyJOVs4=;
	t=1750941978; x=1752151578; b=fN0VrDgcEYZcwSQBraCVydK4TChaQukxVwjv2v6V0cb2Rol
	QhpD1BKMU/GQsCSsVk43UNAMEKNK5h8yl3AP6xVdaHpqlwRcoS3AbO8Hx4H/iynR0+BAJ1G4LIPGX
	BODPvUpm9/zsVoW/+Q+sEwg522q4+xPm6mi0Xxb+yJtXWaad2/NYLILVxgrUbGFStvk7lCSLlzzrO
	7JMbWBrxY7LMIC2Spfl1fPdynKt3bNcRxz3lbQi9TM25mMzlCOfcmXmSf/mMqtUH4guUuwi4W5kBb
	5wdX4qnYmNvhftX0CMPc41qD1e5mTqPzNOcoJkYvVauuZKQUlHVymZHT6JqU6kig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUlza-0000000BXXt-3S78;
	Thu, 26 Jun 2025 14:46:15 +0200
Message-ID: <e39611e7990541138e7d82809fee924433274912.camel@sipsolutions.net>
Subject: Re: [RFC 1/5] wifi: nl80211: Add more configuration options for NAN
 commands
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 26 Jun 2025 14:46:14 +0200
In-Reply-To: <20250622222444.356435-2-andrei.otcheretianski@intel.com> (sfid-20250623_002839_326397_7F85850C)
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
	 <20250622222444.356435-2-andrei.otcheretianski@intel.com>
	 (sfid-20250623_002839_326397_7F85850C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-06-23 at 01:24 +0300, Andrei Otcheretianski wrote:
>=20
> + * @rssi_close: RSSI close threshold used for NAN master selection. If n=
ot
> + *	specified (set to 0), default device value is used. The value should
> + *	be greater than -60 dBm (unsigned).
> + * @rssi_middle: RSSI middle threshold used for NAN master selection. If=
 not
> + *	specified (set to 0), default device value is used. The value should =
be
> + *	greater than -75 dBm and less than rssi_close.

I think these are not described well, and I also don't understand why we
shouldn't use negative values in the APIs? I know the iwlwifi firmware
doesn't like to do it, but that's not a good reason not to do it in
other places?

> +	struct cfg80211_nan_band_config low_band_cfg;
> +	struct cfg80211_nan_band_config high_band_cfg;
> +	bool enable_hb_scan;

When we have "nan_supported_bands", it seems to me these should really
be by arbitrary band, and bitmap of bands to enable scan on, or
something like that ... also this really applies to the nl80211 API.

> +	u8 *extra_nan_attrs;
> +	u8 *vendor_elems;

const u8 *, presumably

> +	size_t vendor_elems_len;

Also not sure I see a need for size_t here, it's certainly going to be
limited to a netlink attribute (u16?) anyway?

> + * @NL80211_NAN_BAND_CONF_CHAN: Discovery channel.=C2=A0

> Ignored on 2.4GHz band.

Shouldn't be ignored. Either require a correct value, or reject the
presence of the attribute.

> + *	Either 44 or 149 for 5 GHz band.

We should use frequencies.

A lot of these are missing docs about their attribute type too.

> + * @NL80211_NAN_BAND_CONF_RSSI_CLOSE: RSSI close for NAN cluster state c=
hanges.
> + *	This is unsigned 8-bit value in dBm (absolute value).

Nah, see above.

> +	/* Check if the channel is allowed */
> +	if (!cfg80211_reg_can_beacon(wiphy, &def, NL80211_IFTYPE_NAN))
> +		return false;
> +
> +	return true;

return cfg80211_reg_can_beacon()?

> +	if (!conf->low_band_cfg.chan) {
> +		/* If no 2GHz channel is specified, use the default */
> +		conf->low_band_cfg.chan =3D
> +			ieee80211_get_channel(wiphy, 2437);
> +		if (!conf->low_band_cfg.chan ||
> +			!nl80211_valid_nan_freq(wiphy, 2437))
> +			return -EINVAL;

code style

> +static int nl80211_start_nan(struct sk_buff *skb, struct genl_info *info=
)
> +{
> +	struct cfg80211_registered_device *rdev =3D info->user_ptr[0];
> +	struct wireless_dev *wdev =3D info->user_ptr[1];
> +	struct cfg80211_nan_conf conf =3D {};
> +	int err;
> +	u32 changed =3D 0;

what's that 'changed' even doing?

johannes

