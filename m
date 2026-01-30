Return-Path: <linux-wireless+bounces-31360-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN/+LeKdfGkLOAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31360-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 13:02:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B32BA4F7
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 13:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 399183003725
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38A36B066;
	Fri, 30 Jan 2026 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JrIt5DbD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496C2E54CC
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774558; cv=none; b=edvIca3Dmtu63dkG7opuAHp8mr9FNkdSZrISdNLahbvwUcHuC0jAvKd1UQHgZqJLCSzOscW0dRSlO3Azf1H7aPyqSW/emIVxmmje++k5IIcJCey+5vCxqWHqwpUAoznZlXrJbwFq3SSNa9GCkMkXqKuOPyklABIXyzCO3WUeRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774558; c=relaxed/simple;
	bh=hGrStW5HfOJPbwYREyDs4CtneJ7zKfocLz1D7E1Q4qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdkeBw5U6UjYgeORf0U1Plw5Cn68854FpxWZotWm9B2tYJyTyL/8NBwVv7912XIWkO3eE2NWFwUr43458I9+tQ6l3s93lz9ayEfD3dJffnS9lRTfkjpAeJa0praxy71dKY+VuzVq2MnJgnM7sktF3ZfCo3XYV8P4ymsHGeN1f94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JrIt5DbD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4zHO4E1EM1vkkw/HUUrmbVCwSUox894Kng1gmicHCGI=;
	t=1769774556; x=1770984156; b=JrIt5DbDzU7mDOJKpaU2ftbwBZiA/PgwVskMHnAuxoUYtDr
	xeW+FJ8WTpC266H5BD8AGys0Roog+HR5s6PdncArboKxjncskMhIWOPbNfBc0b0mBHUPdxlkOCw3u
	AjgkdEBZxSskdfnqQqT3kH0kREQOYWJ9p8ifNvG9MpgvlUuUqRomNAKic9bZm9VDY4TlSejPjenPV
	BbHEVsv7HNkS1A6OgqqoV46DVgcHDdGR8SEV4ehy9tdGHKUoHmra03YudbByS1L/jrzP8fRqPR7Yl
	sVGirZ/g1I4NFKyIfDaT67I2sJv3MRE5B+OC8VmJ9QWlmOeK/c84apngUPdPRynw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vlnCk-00000007qva-26y3;
	Fri, 30 Jan 2026 13:02:26 +0100
Message-ID: <97511b524cecf4862d8a83038017c23bc7d715b8.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/3] AP: Always re-add stations that use MLO
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, 
	hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Andrei Otcheretianski
	 <andrei.otcheretianski@intel.com>
Date: Fri, 30 Jan 2026 13:02:25 +0100
In-Reply-To: <fcef3c86-5384-4211-9f6b-be6ef562cef5@oss.qualcomm.com> (sfid-20260129_182648_996565_D2417D31)
References: <20260126160300.2600380-5-benjamin@sipsolutions.net>
		 <20260126160300.2600380-7-benjamin@sipsolutions.net>
		 <612a2814-216d-435b-a58a-1f17169a944b@oss.qualcomm.com>
		 <707fe82d66e77aed06002c529322eb9689db027b.camel@sipsolutions.net>
		 <fcef3c86-5384-4211-9f6b-be6ef562cef5@oss.qualcomm.com>
		 (sfid-20260129_182648_996565_D2417D31)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31360-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0B32BA4F7
X-Rspamd-Action: no action

Hi,

On Thu, 2026-01-29 at 22:56 +0530, Rameshkumar Sundaram wrote:
> On 1/29/2026 3:38 PM, Benjamin Berg wrote:
> > [SNIP]
> > That said, to properly fix this we need an nl80211/mac80211 API that
> > permits us to disable address translation for the frame. Otherwise we
> > would still get the address translated to the old link address should
> > the new link address match the MLD address.
> >=20
>=20
> That's true=E2=80=94even probe responses get translated when the old link=
=20
> address matches the new link MLD address.
>=20
> Few other cases I encountered:
> Consider an ML STA with ML address M associated with link A and link B,=
=20
> using link addresses X and Y respectively. If the STA sends an=20
> authentication frame with address Y on link A, it gets translated to M=
=20
> (even though link A has no STA with address Y) and forwarded to link B.=
=20
> As a result, hostapd is unaware of the actual TA and queues the=20
> authentication reply to the MLD address on link B. This frame will=20
> eventually be transmitted over the air on link B with address Y.

Honestly, that type of link confusion seems like a bug. We should be
able to avoid that as we hopefully know on which link the frame was
received.

> This will be true even if STA associated in one link and tries to roam=
=20
> to other link of MLD using same link and ML addresses.
>=20
> There also cases where an ML STA roams/re-associates as legacy (non-ML)=
=20
> STA with ML address as link address. The reply would go out with old=20
> link address.

Yes, I think that case is similar a station using its MLD Address on
the association link and returning on another link.

> It seems that address translation at the driver/mac80211 level for=20
> management frames could be avoided for both TX and RX, allowing hostapd=
=20
> to handle these frames and their replies more efficiently in cases of
> roaming and address reuse.

Doing address translation in the TX path is required if the
hardware/driver should decide on which link to TX the frame. For RX, it
seems sensible to me to do the translation when it is possible.

I talked a bit to Johannes about this today, and my current proposal
would be add a new flag that is set when mac80211 did not find (RX) or
should not use (TX) a STA for the frame.

More specifically I think that we could:
 * Fix the link address based STA lookup to only work when the frame
   was received on the correct link (the bug from above).
 * Make sure we drop robust management frames without a STA as we do
   not want to get into trouble with the next change.
 * Change ieee80211_rx_for_interface so that it uses only
   link_sta_info_get_bss if we are an MLD and sta_info_get_bss
   otherwise.
   Right now, we will find the station if we see the MLD Address in the
   frame even when it is not a valid link address.
 * Add a new nl80211 attribute NL80211_ATTR_FRAME_NO_STA to be used
   together with NL80211_CMD_FRAME for both TX and RX.
    - In the RX case, add the attribute if we have no station. If the
      attribute does not exist, then hostapd should assume the address was
      translated.
    - In the TX case, plumb the information through to mac80211 and avoid
      doing a station lookup based on the address.

I think this would be enough to then solve the problem in hostapd.

Benjamin

