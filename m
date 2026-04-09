Return-Path: <linux-wireless+bounces-34544-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA7UGq2m12noQwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34544-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:16:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA453CAECB
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 626FB300D4D6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CE33D6466;
	Thu,  9 Apr 2026 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GnssyZlC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB823D47CC
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740471; cv=none; b=a7RR1pOCMDSPRtD5eXg+5FhjXovfaI6sXAlsQ82zNUxNwKJ9zl3b84lwER8BHkJD7OgFe7fVwR8eWsadvo/87q7IMMfPpCUzs9koASdjw6U2yY6eFqbDRZBhgYgDM/NmItaE6B35C3lV4y3vY4xxIsyVjCndgjUrgIfHYbMVfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740471; c=relaxed/simple;
	bh=vPeVCZrRy3CR9kSECxeYl6h4FeX1/nd3Ov3nuDTDYHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WK9rUPeOwFBMju5EhdZ3ntddROOfjo5wSrh8yMDhkZgGamwTjEM6PZJBrZeYZgcsvSumeiHTBeVduENFSM2bKyT9TZtSs+Rq5uGazkJqCRHpSgXMGro9+m23FS9X+huCdHReMPkDPVbv/FLF9MAokbdqHsOcflPyQTHfOO4R7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GnssyZlC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vPeVCZrRy3CR9kSECxeYl6h4FeX1/nd3Ov3nuDTDYHc=;
	t=1775740469; x=1776950069; b=GnssyZlCiNsneEy8rW4aq3WBEiBd+pFq5fUDPMB/qkU31Ac
	2DvzoyjakCactM7D35/0wvJV/Fv2xL/Fpts54aWPNoi0n8wk2QeJcHVp1srqoipu1y2FrOWrv+xn2
	s9Q6DpLTXBNMMBCNO5GB+ayr4m3Je5+KCxpWygKshJ1DOu+SaMDqa+CJAo6K3IuqXV1RJUhdwri5Y
	yvU15p2c3xPsC8Lst/1h/9GD+NbCiON45rZEhhxEuG7ATCPhoVHL52Aifxt3zgdn91rjo5GF9MQJT
	qeaQS+i9j8iO5gpxvUnlBkwzeLQRfG5lJwSND42aXVuzjfFCKP7Xdk1KgYb5YQpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wApDG-0000000FySw-188O;
	Thu, 09 Apr 2026 15:14:26 +0200
Message-ID: <8467ef16e27bf5d2d7bf5bb0f6654be2034834bd.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] wifi: Transition/Padding delay subfields are for
 both EMLSR and EMLMR
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 09 Apr 2026 15:14:25 +0200
In-Reply-To: <1fdb014e-9b40-4e89-b90d-b4283338fd91@freebox.fr> (sfid-20260409_110433_663128_2C435C6B)
References: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
	 <20260327201135.905852-4-pmartin-gomez@freebox.fr>
	 <6900294c6c10fb7336e8ca6c7217e970db2cc3a1.camel@sipsolutions.net>
	 <822a3036-1cc0-460f-ad04-d711606afd4c@freebox.fr>
	 <f60497d95314a9a595d0830cf47de8533674e811.camel@sipsolutions.net>
	 <1fdb014e-9b40-4e89-b90d-b4283338fd91@freebox.fr>
	 (sfid-20260409_110433_663128_2C435C6B)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34544-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EFA453CAECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-09 at 11:04 +0200, Pablo MARTIN-GOMEZ wrote:
>=20
> What about `IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY`? It also has
> two tables for EMLSR (9-417i) and EMLMR (9-417k) but they have the same
> content (as of 802.11be). Do I just rename
> `IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_XUS` to
> `IEEE80211_EML_CAP_EML_PADDING_DELAY_XUS` or do I split it in two
> identical `IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_XUS` &
> `IEEE80211_EML_CAP_EMLMR_PADDING_DELAY_XUS` to future proof it in case
> of a change in a future amendment?
> >=20

It isn't going to change, this field will need to stay around like this
forever, only thing the spec could do is add new values (i.e. use some
currently reserved values), but even that is tricky ... So I don't think
we need to consider future changes here. I'd probably just rename it,
but it doesn't matter all that much?

johannes

