Return-Path: <linux-wireless+bounces-32612-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHn3GjiZqmkxUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32612-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:07:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FE21D9BF
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C469A302411D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA933AD91;
	Fri,  6 Mar 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QQsBorjg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CD3264E1;
	Fri,  6 Mar 2026 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787899; cv=none; b=s2RUXnPvradaGmRm9lFIHSMFr/YiYw6bMNZWthGAGiLHU1HnfIq8ALiBP0YXi7gC8t4k0oz0jeveynVVq5LwcvEG9RH2K/yG3dRJNGHi3HvYsKYHPEJuu5I3D/ulE5+yoBpOiNUQvbAwWjCjSsRKbvWpJ033DeyhruH5aT3MilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787899; c=relaxed/simple;
	bh=RabxqyO2kHGqotR+whNmAB6DypHrCmeUvkmmAyh8Hrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AL+xCyMIq31/Os6WjqmS45ZQrWDK+ihciN5lq2ABMXdADIMJq9Uvuz/YJ/z7Ect+zvqlj93r02ytwXqG3fLABVXDAIveN2IV153Jv0zGoqkzWddP5UuzCIGnCQDFnx/eW3RzoeEMPS5DkLgNoh1CDSFGDNi/LaJFX1UzO9WXmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QQsBorjg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=foGTOnvfxWXN18BTJvhG+i9JithTiTUkvu2Z7Hh4DXs=;
	t=1772787897; x=1773997497; b=QQsBorjgdDnKbFIHoylm6vbB1X+QJS1OUQWtHy7SSPZoGw+
	vkjx7pActFFWAXdiAjTZ+iLyDx2ylWrieL+nsugE3dEbwB+zGi9+/LOczgwmhfL5aPETKbqUlCcmS
	tkgMGEANnMcOPreRxx/Yx42k9c8fAaUs5KlvmUbtXajeAVt26z0KG4lZmyctIKmsv2Qm+m8p3Dg7U
	jPellDfF5bKBg9QlkDoGf71sIW6q4fuvxGqzaJIr+19KVC6hz1qVICzC2PB/k65SBHKaEaNCD8A5A
	uC/0wTSGnQNOVq64D9Xp21gtPg5m/VN59pjDNwgfgfRZWorkWAsBZ6SCPI3W6lvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vyR77-0000000A07A-3zSU;
	Fri, 06 Mar 2026 10:04:54 +0100
Message-ID: <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>, 
 Nathan Chancellor
	 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Mar 2026 10:04:53 +0100
In-Reply-To: <20260227041108.66508-15-lachlan.hodges@morsemicro.com> (sfid-20260227_051319_753159_902A846C)
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
	 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
	 (sfid-20260227_051319_753159_902A846C)
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
X-Rspamd-Queue-Id: D05FE21D9BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32612-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[morsemicro.com,kernel.org,gmail.com,google.com];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 15:10 +1100, Lachlan Hodges wrote:
>=20
> +static int mm81x_mac_ops_hw_scan(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif,
> +				 struct ieee80211_scan_request *hw_req)
> +{
> +	int ret =3D 0;
> +	struct mm81x *mm =3D hw->priv;
> +	struct cfg80211_scan_request *req =3D &hw_req->req;
> +	struct mm81x_hw_scan_params *params;
> +	struct ieee80211_channel **chans =3D hw_req->req.channels;
> +

> +	mutex_lock(&mm->lock);

Seeing this, I wonder about two things:

 1) Do you even need a mutex, given that the wiphy mutex covers all of
    this pretty much? I can say from experience that a _lot_ of things
    get quite significantly simpler without a separate driver mutex.

 2) Are you going to incur the wrath of mm/ folks, where instances of
    'struct mm_struct' are commonly called 'mm'? I can find a few
    examples of others (struct drm_buddy *mm, struct mqd_manager *mm),
    but you'd double the instances.

> +	UNUSED(hw);
> +	UNUSED(ctx);

I think you should remove these (and the macro.)

> +	/*
> +	 * mm81x only support changing/setting the channel
> +	 * when we create an interface.
> +	 */
> +	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
> +		mm81x_err(mm, "Changing channel via chanctx not supported");

Wait, what, why do you have chanctx support then? This seems highly
questionable, how do you not run into this all the time?

If it just has a single, wouldn't the chanctx emulation suit the driver
better, and that'd make this more obvious? Hmm, but you _do_ support
multiple vifs? I'm confused.

> +static int mm81x_mac_ops_sta_state(struct ieee80211_hw *hw,
> +				   struct ieee80211_vif *vif,
> +				   struct ieee80211_sta *sta,
> +				   enum ieee80211_sta_state old_state,
> +				   enum ieee80211_sta_state new_state)
> +{
> +	u16 aid;
> +	int ret =3D 0;

nit: that =3D0 assignment is unused. I (we?) tend to not add them so the
compiler can warn if the remaining code changes.

> +		WARN_ON((key->flags & IEEE80211_KEY_FLAG_PAIRWISE));

nit: extra parentheses

> + * The firmware passes up NULL vifs for broadcast management frames. Fin=
d
> + * the first interface that best fits the frame we are rx'ing. This
> + * has the clear downside if we have two vifs with the same interface ty=
pe
> + * the 2nd vif will never be targeted. For now, this will have to do.

Why do you need this? Curious, because mac80211 ought to sort out the
right vif (or even send it to multiple) anyway?

The only user _appears_ to be mm81x_rx_h_update_sta() which seems you
could just skip entirely for broadcast mgmt frames, since it's just
statistics?
Or look up the STA not the VIF (ieee80211_find_sta_by_ifaddr() can take
a NULL ifaddr)?

Anyway, not really important.

> +	ieee80211_rx_irqsafe(hw, skb);

This seems a bit pointless, you're coming from a worker already, so why
jump through a tasklet again? Seems ieee80211_rx() would do, unless you
have some assumptions on how fast the work must process? (but then you
should probably document those.)

(I'm not going to look in this much detail at the other stuff, this just
because of the mac80211 interface.)

johannes


