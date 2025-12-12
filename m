Return-Path: <linux-wireless+bounces-29715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B877CB8CE8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 13:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDAA306453C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426B322B86;
	Fri, 12 Dec 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LvKxBFil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B41F3B85
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542634; cv=none; b=J3xyCOh9Icr3kEIHtfbWWjqaaZAJyCRbrHdAL1DSvxaTZXPUcYSrzxQO9S/WNyVwEEwF+reKAawuO7aF5HLhEolTlCcNyAlVbrweZ1qb3IzNAjJuq8+bBeEZefoORyK6uriqmDj0kyDgwubmcoGMXiKyWqAH/rXkjPhOlse+pgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542634; c=relaxed/simple;
	bh=8zeqF5j8aXEu4JWelNm1ky6qLxGDQKk/MCR+V9Fga7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jrIu/7RP5yiRM4LtnKST/c/IsYc5Aw1K/19NJSKmqIF6SrEfmXjxsu5Rh+IHpqCG4Rw/WLPw2FHO3BXf58MuktWcm7SAAa0LNKNnyi/9D5FRxub25ov14nfaS3xChaWbTlMKHYOgcCLH6mw8THGIw+AkECxfDqEMk9BiLK0eIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LvKxBFil; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ss91gu8hfLuJkXgkzvPEGrWjiXfE324M3rexDh1Dd1U=;
	t=1765542632; x=1766752232; b=LvKxBFilW86qclwDRZILMRTenggI8zNemHnn3C3DmlTfgXr
	x4jhwt5cHgyXBSYyHDif3jvdz3kVGOq0mOW7H+sz8APFSJonArf95o5USyOLVzQGJ6LjypvSGz0oz
	TS84LB3JDXRvdQTZqMR0+G1G9ZomwJ4u8VdhCiDpXm1R/OjUaVffRhez+thSWRHoMOHS0fYrxnL6d
	5MMmWY50ylLcwdNDr+UT5xXojEWZ8AgaA2oaaBZQwd3fTPF2Aco1jRvi50jaAq4oqSVkThBRZ+Z8t
	FgZ+nyp1CfNw6GTJWNaW/kxDqhXpsu019moyCspMEcez0DZA3ad3S1z4t73lbbFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vU2I1-00000003T5S-0R9z;
	Fri, 12 Dec 2025 13:30:29 +0100
Message-ID: <b6c7ce2d4fbe1b2c2db1dadcaf99b77a738d7944.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 05/14] wifi: mac80211: allow key
 installation before association in =?UTF-8?Q?non=E2=80=91AP?= STA mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 12 Dec 2025 13:30:28 +0100
In-Reply-To: <1da46c84d32dfa1458dc3c60e18f16d3a6defaf7.camel@sipsolutions.net>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
		 <20251211124051.3094878-6-kavita.kavita@oss.qualcomm.com>
	 <1da46c84d32dfa1458dc3c60e18f16d3a6defaf7.camel@sipsolutions.net>
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

(Sorry, keyboard handling error with my hands ;))

On Fri, 2025-12-12 at 13:29 +0100, Johannes Berg wrote:
> On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
> >=20
> > +++ b/net/mac80211/cfg.c
> > @@ -680,12 +680,29 @@ static int ieee80211_add_key(struct wiphy *wiphy,=
 struct net_device *dev,
> >  		 * association has completed, this rejects that attempt
> >  		 * so it will set the key again after association.
> >  		 *
> > +		 * With (re)association frame encryption enabled, cfg80211
> > +		 * may deliver keys to mac80211 before the station has
> > +		 * associated. In that case, accept the key if the station
> > +		 * is in Authenticated state in non=E2=80=91AP STA mode.
> > +		 * If (re)association frame encryption support is not present,
> > +		 * cfg80211 will not allow key installation in non=E2=80=91AP STA mo=
de.
> > +		 *
> >  		 * TODO: accept the key if we have a station entry and
> > -		 *       add it to the device after the station.
> > +		 *	 add it to the device after the station associates.
> >  		 */
> > -		if (!sta || !test_sta_flag(sta, WLAN_STA_ASSOC)) {
> > -			ieee80211_key_free_unused(key);
> > -			return -ENOENT;
> > +		if (!sta)
> > +			goto fail;
> > +
> > +		switch (sdata->vif.type) {
> > +		case NL80211_IFTYPE_STATION:
> > +			if (!test_sta_flag(sta, WLAN_STA_AUTH) &&
> > +			    !test_sta_flag(sta, WLAN_STA_ASSOC))
> > +				goto fail;
> > +			break;
> > +		default:
> > +			if (!test_sta_flag(sta, WLAN_STA_ASSOC))
> > +				goto fail;
> > +			break;
>=20
> I don't understand why you (later) introduce this asymmetry between AP
> and client modes? Couldn't mlme.c just set the (introduced later)=20

... sta.epp_peer flag, and then the code can - regardless of mode - just
be whatever you add in patch 12 for AP only?

johannes

