Return-Path: <linux-wireless+bounces-31697-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDnbBKI5i2ksRwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31697-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:58:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40211BA4C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4926F3013EE5
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D6342CA7;
	Tue, 10 Feb 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rVVRAywm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4F14A0BC
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731681; cv=none; b=AU+8T2l/ZGYSIol2GfTlj8S2r8HGXwYL7mSzEp9ck26ZJRVdDkYSz47/Jr59v8J5awGRNkNHVaUdJvSl93rboCxhnO/bR1ofzHfMZii4eap3g7N24kP9TD7+mPNjW6wC7BBZQSWkrQQAS7L6SW60f9jaPLavyONsT2PVGlaKjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731681; c=relaxed/simple;
	bh=FbOMCHujQ2K7483kfzVeX0OaHz9pdrZo5FdEvpxwJ+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRt5R62xNzH2ax7DVRXkALuJguT8Vnq9xi/q7U0uK5WBHM8XL0+8z8wwHz9NBzq+mMWYSsbMAdAEYJy9Sn6R+5CLq3a4fdkiZbZxa7Aqiyfd5JzCWSirUK3ZeBthgVVqqb1UmZtFvhuP3pRiatWAZcv94rQYevLuDpXCpfO4HGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rVVRAywm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FbOMCHujQ2K7483kfzVeX0OaHz9pdrZo5FdEvpxwJ+0=;
	t=1770731679; x=1771941279; b=rVVRAywmMd4ybwyqEkJsYZFQLLZAe0JhVkNnokBScBPkhFA
	mHuzHzVFP0fhkrUHc+RJx8hHbBcVCv4Px2ZNM9LczdUZhTRyhlTXmT5eTxlzQiZxZ5o2JJmjE2Sqj
	iKhGY3m9vlRS1Sjbs9m8xSAhABE5+keMB1ZsuEt88DjUuJKtDjnTYyWeKubFW1e5+vt8SuKwAW5Ck
	3gvEFbPGKlzjktnHbVCORKBBDjNRWQNXmh1o2cYNh9B1pvu9hE4+L+ZXCEtoDnBXLAZpxayQK2nmH
	+3E/JWQgMxQYvU9CMJVahjFUpWfR7jtOqfxNgTzlip1fdIZRtJji0/JbjvYaUgeg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vpoCD-000000045nE-3GkN;
	Tue, 10 Feb 2026 14:54:30 +0100
Message-ID: <6609efc1d2a97f748bee9b5f4d8f800baf62b556.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Fix AAD/Nonce
 computation for management frames with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Tue, 10 Feb 2026 14:54:29 +0100
In-Reply-To: <4a7f19a4-97bf-4dae-9020-27da3297fc68@oss.qualcomm.com>
References: <20260208081854.1080048-1-sai.magam@oss.qualcomm.com>
	 <ff9330f7e17da9c7c1ba87b9400051a9bec29aa4.camel@sipsolutions.net>
	 <4a7f19a4-97bf-4dae-9020-27da3297fc68@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31697-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sipsolutions.net:server fail,tor.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:url,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 7D40211BA4C
X-Rspamd-Action: no action

On Tue, 2026-02-10 at 18:30 +0530, Sai Pratyusha Magam wrote:
>=20
> > If I restrict hwsim [1] to only pairwise and CCMP/GCMP (clearly it
> > doesn't handle TKIP due to Michael MIC, WEP is irrelevant, BIGTK isn't
> > handled in hwsim), then it mostly works without all of that extra logic
> > for me for the tests. Maybe need to think about IGTK here though, some
> > tests are still failing.
> >=20
> > [1] https://p.sipsolutions.net/d101bc31582cadcf.txt
> >=20
> Hi Johannes, Thank you for [1], yes the extra logic I had added=20
> (IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD) to prevent offload for=20
> AES-CMAC/AES-GMAC, i.e, MMIE addition for beacons(BIGTK) and broadcast=
=20
> robust management frames(IGTK) and for WEP/TKIP cases was not needed and=
=20
> the correct return value in the set_key ops was all that was needed to=
=20
> selectively offload encryption for CCMP/GCMP. I missed that.

Well, you couldn't do management frames only, so in that sense the flag
IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD was needed - at minimum hwsim
also needs/needed to invoke the encrypt_tx_skb() function before address
translation for data frames.

> Today, I tried with [1] , removed the redundant logic around the=20
> additional key flag this patch=20
> introduced(IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD) and data tx=20
> encryption offload, i.e ieee80211_encrypt_tx_skb() before address
> translation.
>=20
> I was able to pass the existing hwsim test cases that include test cases=
=20
> for beacon protection, broadcast robust mgmt, WEP/TKIP, unicast/bcast=20
> data and encrypted Assoc (EPP)

OK cool, so maybe I did something wrong in my quick attempt to figure
out if we could get away without IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD.


> > But if we do that (even if I don't like it, I'd rather fix the remainin=
g
> > issues), then you need to document reason for it.
> >=20
> sorry, I did not follow this?

Sounds like we don't need IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD now,
but I meant that if we _do_ need it, the commit message should explain
why exactly.

johannes

