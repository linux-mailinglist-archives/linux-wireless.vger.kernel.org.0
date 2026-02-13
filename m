Return-Path: <linux-wireless+bounces-31814-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIxKOfn4jmnbGAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31814-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:12:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ADB134EED
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8951030413EC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A234FF6E;
	Fri, 13 Feb 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="km96JzG6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148E1DE4CD
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977507; cv=none; b=UYtn9qle6A+TZgfSIm4FlqfuM4df9qKKf8DJRwUVGSFTBQH58jWT+7Hs6qne7jSzwGSyzYCnA4f0X1dyy/KF8/VouMbp5cSqDX0JhRR3oj9hJXpDF0m2uUdQR0lmtM7uMdfps65NcFj1Za+/FUnin9l4md34RN04k/y/pviJbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977507; c=relaxed/simple;
	bh=NEo4QtErZOJrFZSq7RsP/sQYZjQ0K7DEJRG6c4CpbGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2uqBQnALqK1z9Mlv+rWC5SeWuli2MwZ085UB48ZXJBSvguELCehT0THgfrF/KFWovXhrbz2PiL7JlOievHHTBZGaAzLCaWqC8cYIMqrrOzJJY+ays1Il8sS2OBQlegeBBSgGQ39fz16LjJvt6xUuQwnpktoItsy9SbAYz0ca3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=km96JzG6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r7vFpQOfTHePGlyR51/ZG3a/vz4y8aVNFBUYzTqAQOU=;
	t=1770977505; x=1772187105; b=km96JzG6izMIifizrJO+DkmpoSiIe+f3Ckpao0hPg/PohNU
	kjvbZdR+Ij/8H8NnscIClXlePGrPH7tJcasxk8/qqdxfiMS0en4Ono7ha+aJ6yBScpA5mmEmOxWls
	xVoZN6Ae4Hjg7TwmVjh1jkvS7cJ8f7C6nHAKnkT6ThB1vGOrpxSLrFrLtvDYKbY50Gb2I9wjSpJlz
	wqEj+M7IzwUgN1d2hllZHqkraf/q7uKJVmMTL8yZfaCH6dcip1Yltr2R+wi4qDPsl86BYLFLf/7Ex
	vtllzEcjWk17JkIPjDjLs4f1zyqvR9/oSNtNcOR1HQjlUh2wGhz1n0LMtD2PaWhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vqq9E-00000007MW0-2KMi;
	Fri, 13 Feb 2026 11:11:40 +0100
Message-ID: <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Harshitha Prem <harshitha.prem@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	vasanthakumar.thiagarajan@oss.qualcomm.com, Lorenzo Bianconi
 <lorenzo@kernel.org>, 	ath12k@lists.infradead.org, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>,  Ping-Ke Shih <pkshih@realtek.com>
Date: Fri, 13 Feb 2026 11:11:39 +0100
In-Reply-To: <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
	 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
	 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31814-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 94ADB134EED
X-Rspamd-Action: no action

Hi Harshita,

> > Should we add a separate netlink attribute for the UHR operation, which
> > hostapd would fill with the _full_ data like it appears in association
> > response etc.?
> >=20
> > That way, hostapd doesn't need to build a separate data/attribute
> > structure but can just use hostapd_eid_uhr_operation(..., false) for it=
.
> >=20
> > An alternative would be to add more attributes for everything, but it's
> > probably more complicated on both sides?

> Thank you for the suggestions.
>=20
> We feel that using separate nested attributes for each feature is the bet=
ter approach, as this allows us to reuse the attributes for the Enhanced BS=
S Parameter Critical Update procedure, where similar information is carried=
 in the UHR parameters update element.

Heh, I'll admit I'm surprised - I'm usually the one advocating for
finer-grained attributes, and here I didn't ;-)

> While this approach is slightly more verbose, we believe it offers better=
 extensibility for the future.

Does it actually, though?

I had sort of expected hostapd to add the UHR Parameters Update element
to the beacons, and configure some way of having firmware set the
countdown ("Countdown Timer"). Turns out this is not only in beacons but
also in probe response, (re)association response and (UHR? [1]) link
reconfiguration response frames.

[1] the spec says "Link Reconfiguration Response" but I think it should
say "UHR Link Reconfiguration Response"

But I guess this is going to end up a continuation of the previous wifi7
discussion from last year [2] which hadn't really completed. And Lorenzo
just posted another thing on this [3].

[2] https://lore.kernel.org/linux-wireless/20250717045540.27208-1-aditya.ku=
mar.singh@oss.qualcomm.com/
[3] https://lore.kernel.org/linux-wireless/20260212-mt7996-link-reconf-v1-0=
-2b110340d6c4@kernel.org/


So I think maybe we need to figure out how we will do all of this first?

Naively, I would've said ... something stupid. I'm reading the spec as
I'm writing this ;-) The UHR Parameters Update element is actually
included in all the beacons across the entire AP MLD.

Maybe we need to take a step back from our previous discussion as well,
and introduce a broader concept here?


I could imagine, for example, something where you say in the nl80211 API
some variation of

 1) Let's start a new update operation ("NL80211_CMD_START_MLD_BSS_UPDATE")=
,
    I guess already with some parameters saying:
     - the updated affiliated AP (link)
     - the number of beacon intervals you want to do it for
     - the post-update UHR operation (?)
       (or the new channel if it's CSA? etc.?)

     - maybe - more critical if we use it for CSA - already the beacon
       templates for all the links? with all the things I say in (2)
       below, but that's more complex maybe?

       the reason I say this is that there's a difference here in how
       the counter is done - for CSA etc. the things have to disappear
       from the beacon immediately, for UHR updates they stick around
       and the counter indicates "in the past"

    returning a cookie for the operation.

 2) hostapd updates each link's beacon now including the UHR Parameters
    Update element(s), for each currently ongoing update it includes -
    indexed by the cookie - a list of offsets where the counters are
    updated.

    Thing is that this depends on the operation - CSA will already need
    the post-switch beacon template so the flow can continue without
    involving hostapd, hostapd may however need to update the beacon in
    the interim (both pre- and post-switch ones!) and need to refer
    again to where the counters are filled in ...


Either way, it feels like we've reached the end of where the current
design with CSA and BSS color updates will take us. Lorenzo already gave
up and put the parsing into the driver to find the offsets, but I
personally think that's very inflexible.

Some operations such as link removal may not need to have perfect
timing, but some others like CSA really do want the updates to happen at
the precise moment.

In some way, it's almost good that we haven't completed the WiFi7 part
since the UHR part throws another curveball with the counters
decrementing below zero - for past updates - in a sense.


johannes

