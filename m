Return-Path: <linux-wireless+bounces-31132-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RyOSLSfMc2kCywAAu9opvQ
	(envelope-from <linux-wireless+bounces-31132-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:29:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E23F7A26D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2C83011C6A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B2017B50F;
	Fri, 23 Jan 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LJKNhfL6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F838A95E
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196580; cv=none; b=OmZwcZ3GKICxfzcDG56LLEuKuKj870EDxMjgOZ5wy4hTsAroxPrS575BwwqwxCBDpHEaVH+Xb9bn8IiIsyZXu23nBX2RV9k4/+BdEFjjYHlapxPQ7hTy5eI1zC+Dy9lSr3u58t614xY8l7g7y2apsrZ5OlmJaJd/XLJtTZlad/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196580; c=relaxed/simple;
	bh=iWXsXOLXvqmasNKhCbCh9Qd/7WBIer3pMJ8xCxwRu2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7mbQGFXKYPbx0jJ5qW6qJHrReNwn8amNlM/fJN048ptydZ/UT5d/idVwUBIiKd3tmhKf+TTzlrdM3xNPEVEQuNuhHjtfTWfL4q33BtGVQ8PeTYxfUokw8BpOMlRbEhrGNlQzmcOWQ2yXFKPJTmUmdyTdZQ2iQ4KTpFIGbirUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LJKNhfL6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iasUyJbQU10Eo04yeCkcyUA+uV2FuBVjSWwwbEHdGXM=;
	t=1769196579; x=1770406179; b=LJKNhfL6VX+DFhtwGoxqviX+lgZWocQP6KDcAcGk0xEGwZy
	i/5sNI/Qsug5NEcTwnf+JxaaKZgwFy6sm74PWGOY3ZlS7PNa/x1cx+c09EHyFMcp4zgm4FXW55Gw4
	bmxgwCG75O1DnGbQ5mUc7Ux7Z+To2j9Vnu5glI1qWiBHHJ+0DHYzHKDhCWFhhyI75IdPlPRSjIo2n
	vQhy7VjkWknfKZMTMjV6fVrvVi7PCBlWy5TwBny+OAG42gegHyX9phqOKHTZhwVomxGxV0kOwf4D6
	ePwpPgFH4A6n1HRE2ZUCJBe5oplVPzVrBanlR52GjCzx5pZgoIRXn5kgsluBThXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vjMqc-00000001q8x-2luF;
	Fri, 23 Jan 2026 20:29:35 +0100
Message-ID: <26bfd810c1dabc9ed86d4ba68cd20f6434c1d3a2.camel@sipsolutions.net>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, Nicolas Escande
	 <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Fri, 23 Jan 2026 20:29:33 +0100
In-Reply-To: <b0e79f6c-36d7-4e49-9d43-8e305a598201@freebox.fr> (sfid-20260123_202122_653000_95B55B92)
References: <20260123144224.2216923-1-nico.escande@gmail.com>
	 <d26ee979-b5d5-4f50-b423-f8783122f603@freebox.fr>
	 <bfed10db742d29f0609acb04d3354695f87b24e2.camel@sipsolutions.net>
	 <b0e79f6c-36d7-4e49-9d43-8e305a598201@freebox.fr>
	 (sfid-20260123_202122_653000_95B55B92)
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31132-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[freebox.fr,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E23F7A26D
X-Rspamd-Action: no action

On Fri, 2026-01-23 at 20:21 +0100, Pablo MARTIN-GOMEZ wrote:
>=20
> > > > +	} else {
> > > > +		phy_cap[0] &=3D ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
> > > > +		phy_cap[1] &=3D ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MAS=
K;
> > > > +		phy_cap[2] &=3D ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK=
;
> > > > +		phy_cap[6] &=3D ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
> > > > +	}
> > > If you want to clear all 320 MHz fields, you'll also have to clear
> > > IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ and
> > > IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ (not sure why it is not d=
one
> > > in mac80211)
> > >=20
> > This is, effectively, a firmware workaround. It doesn't belong into
> > mac80211. All other drivers just have their capabilities managed in the
> > driver anyway.
> >=20
> > johannes
>=20
> I wasn't talking about putting this patch in mac80211 (I've seen the=20
> discussion on the patch Nicolas sent on linux-wireless), I'm talking=20
> about the function `ieee80211_put_eht_cap` clearing the Beamformee SS=20
> and Sounding Dimension fields but not the Non-OFDMA UL MU-MIMO and MU=20
> Beamformer fields for each bandwidth.

Ah, you're asking why mac80211 doesn't clear those bits ... I guess it
just doesn't matter. If you're not on 320 MHz I'd guess the bits are
never checked, so it's not really relevant at all, although then could
argue that you only need the first line here as well.

johannes

