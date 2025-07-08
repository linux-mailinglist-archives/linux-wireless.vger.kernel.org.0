Return-Path: <linux-wireless+bounces-24923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDBAAFC884
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB81BC06AE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B720B1F4;
	Tue,  8 Jul 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bEcKk2z1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F72256C89
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971106; cv=none; b=UqS5TRa23YYvHDiLM6N3rQ0vksTfrB+V4il+u7eoTEBQajWUZXCbYHk/5Ksag2R7HAdo+hVqy9UKp6HveqstalW3061RyaxTK4iwSO9ZhL2cAoMb+5XTSk/3X8MNJqHdSioCM+xjXwsX9J7vfL6ewpWvmn9H8pDEV7sAPfT2Z+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971106; c=relaxed/simple;
	bh=uBeg+/7Kqgw/PFMgwmWpAYtcpERvRGAMUbVXbcofLRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WE5c2GvIEbnAeo5+yWD2566Fii0gk7IQAKBnCYvSii+ZUXw0MHqgcoB2zdvbbGg5DT915fx2pJhB5i+UmgQFc2WIyK51okKGb85A14z+muVE8J+/icvzQJPf2pdNfXVusGGJrcxYRF+BQbAJSqwMuzFRndaECMFqbbzzKS4+y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bEcKk2z1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iWS4dkqaIhekd98Lz4c1Pwoik7Nui+qNRP3FbO5Ia6o=;
	t=1751971105; x=1753180705; b=bEcKk2z1P7Jo2Pq6LTCCCkapS+WlegIFbUw/9cx2TfVChou
	eKkWEWfd9UpnJE8vh9SUiP3tfia8Be2KSoXXj6HVPm13i6+c+w65eh96khicYR9uC98r9/z6ELi5n
	FxBsFfhw1nzZuTOgS5b9MZ/L/8U/qW25cx14hxxngbEA6+Eei7kgi3UKyt+h6kQR/NWcupQWpTlTY
	z4HWDWHqsPvtuvSKvfSnJCJtNZXB15Si7EleA8vgRMpzjD3JtBKu5z+GvvA/n9BNjTjqW6UhS7Rrx
	TNUs91uLGI9RJ9fC1WlppbiaEw2PnooH7sRoQVwShw7PRXqqao5hprOxzmDXpekw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ5iO-0000000Bojx-3AKz;
	Tue, 08 Jul 2025 12:38:21 +0200
Message-ID: <0616e6d71eed66c5aaaa526fdac31c3237d50680.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: fix off channel operation
 allowed check for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Aditya Kumar Singh
	 <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 12:38:19 +0200
In-Reply-To: <20250701141308.733013-1-quic_amitajit@quicinc.com>
References: <20250701141308.733013-1-quic_amitajit@quicinc.com>
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

On Tue, 2025-07-01 at 19:43 +0530, Amith A wrote:
> +++ b/net/wireless/nl80211.c
> @@ -9758,6 +9758,7 @@ static bool cfg80211_off_channel_oper_allowed(struc=
t wireless_dev *wdev,
>  {
>  	unsigned int link_id;
>  	bool all_ok =3D true;
> +	int radio_idx;
> =20
>  	lockdep_assert_wiphy(wdev->wiphy);
> =20
> @@ -9765,10 +9766,16 @@ static bool cfg80211_off_channel_oper_allowed(str=
uct wireless_dev *wdev,
>  		return false;
> =20
>  	if (!cfg80211_beaconing_iface_active(wdev))
> -		return true;
> +		return all_ok;
> +
> +	if (wdev->valid_links) {
> +		radio_idx =3D cfg80211_get_radio_idx_by_chan(wdev->wiphy, chan);
> +		if (radio_idx < 0)
> +			return !all_ok;

Why? Do you have a code style that says "don't return constants" or
something? I feel like I comment on this repeatedly - please don't use
variables for constant (return) values, it just makes it harder to read
and easier to modify the wrong way.


> @@ -9777,20 +9784,33 @@ static bool cfg80211_off_channel_oper_allowed(str=
uct wireless_dev *wdev,
>  	/* we cannot leave radar channels */
>  	for_each_valid_link(wdev, link_id) {
>  		struct cfg80211_chan_def *chandef;
> +		int link_radio_idx;
> =20
>  		chandef =3D wdev_chandef(wdev, link_id);
>  		if (!chandef || !chandef->chan)
>  			continue;
> =20
> +		if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
> +			continue;
> +
>  		/*
> -		 * FIXME: don't require all_ok, but rather check only the
> -		 *	  correct HW resource/link onto which 'chan' falls,
> -		 *	  as only that link leaves the channel for doing
> -		 *	  the off-channel operation.
> +		 * chandef->chan is a radar channel. If the radio/link onto
> +		 * which this radar channel falls is the same radio/link onto
> +		 * which the input 'chan' falls, off-channel operation should
> +		 * not be allowed. Hence, set 'all_ok' to false.
>  		 */
> =20
> -		if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
> +		if (wdev->valid_links) {
> +			link_radio_idx =3D cfg80211_get_radio_idx_by_chan(wdev->wiphy,
> +									chandef->chan);
> +			if (link_radio_idx < 0 ||
> +			    link_radio_idx =3D=3D radio_idx) {
> +				all_ok =3D false;
> +				break;
> +			}
> +		} else {
>  			all_ok =3D false;
> +		}

It seems you could simplify this a lot by just unconditionally assigning
the "radio_idx", possibly to -1, and then if it matches you refuse?

I don't see how link_radio_idx<0 could even happen, with a multi-radio
interface that's _already operating_ on that chandef?

johannes

