Return-Path: <linux-wireless+bounces-31443-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOjdHJ1ggGlj7AIAu9opvQ
	(envelope-from <linux-wireless+bounces-31443-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 09:30:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D467CC9B0E
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 09:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 963E73006B3B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510CB353EFA;
	Mon,  2 Feb 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ttuVNxI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246034F263
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020836; cv=none; b=i75LEMn7JYGXoWAri/EsGFH6pkbMrf2E3yBzNmG9RkXqrCZY+otRSyHrlc3x/yyuwwZV3bDqVAC5MBSPHYZnlo4Is9oj6zVoMibFK+um0jjivkalXqrjNRhtiFWQT9z/u32j56KWha6mZyLHhk097kjMetZC6/WtufcjkErB+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020836; c=relaxed/simple;
	bh=vsZAmM8tJJ1IJUNcPSt/R6di46IrRLZvQWgTNviYPbU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glG6ABu1tMRnKpAyJu4+VMVhwvMW+GHdDovPFJgV4zki1ggKXsdOkzfQvdZsc1yWtuA6pJNfqrH8owj0xoO1hD775BEnbeE8ai3CdbjsuSafNzVsv56kyIKYRg7vkaUDvpAORqMSaHxSN10YZ81f2iACnqabNLkjs0l19huSCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ttuVNxI+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mLS4JFnGk86za0ejaTRaOAH6elcT+Hux15avYj4723g=;
	t=1770020834; x=1771230434; b=ttuVNxI+QRAh9VxeeKkmMnT5oXdoxC1eGT0g8BGFkikLXxH
	BkPNK6I7F86UoHcKqAxeTuQ7/OIxg0Hd0wpr6bRCHp4qVkTOCULkQLGAybNXqCRLYSS4Xjq7Uz8HH
	wu9/70NE3Gob+sXG2SGGwSww6MMmg0pCH4/oIkTL43QxVYZXFDEQHYVhIx3McKqGtsqoo8dazu1nr
	w/YWyf5+JN+HNFvd44IqmICrSLe1bRQEctqO6cl4PzKIkkix9wxPJHv1imHBKjsOLn+62E45nil5I
	BKLEqGJ/6LBB32bYwgRnmnf6lD+gxJZkN4nmcwODnFGN9brbOiUwrhSrYlxHjY6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vmpGy-0000000BMPD-3UgS;
	Mon, 02 Feb 2026 09:27:05 +0100
Message-ID: <b0eac13e1778566fbd52bac2f29d8ab5810badb6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 3/3] wifi: mac80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Date: Mon, 02 Feb 2026 09:27:04 +0100
In-Reply-To: <009232c6-2a67-4df4-9309-71c9d5788c73@freebox.fr> (sfid-20260130_192945_783004_468158C1)
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <20260130164259.7185980484eb.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
	 <009232c6-2a67-4df4-9309-71c9d5788c73@freebox.fr>
	 (sfid-20260130_192945_783004_468158C1)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31443-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D467CC9B0E
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 19:29 +0100, Pablo MARTIN-GOMEZ wrote:
>=20
> > +void
> > +ieee80211_uhr_cap_ie_to_sta_uhr_cap(struct ieee80211_sub_if_data *sdat=
a,
> > +				    struct ieee80211_supported_band *sband,
> > +				    const struct ieee80211_uhr_cap *uhr_cap,
> > +				    u8 uhr_cap_len,
> > +				    struct link_sta_info *link_sta)
> > +{
> > +	struct ieee80211_sta_uhr_cap *sta_uhr_cap =3D &link_sta->pub->uhr_cap=
;
> > +	bool from_ap;
> > +
> > +	memset(sta_uhr_cap, 0, sizeof(*sta_uhr_cap));
> > +
> > +	if (!ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif))
> > +		return;
> > +
> > +	sta_uhr_cap->has_uhr =3D true;
> > +
> > +	sta_uhr_cap->mac =3D uhr_cap->mac;
> > +	from_ap =3D sdata->vif.type =3D=3D NL80211_IFTYPE_STATION;

> My knowledge of mac80211 is quite limited so I might be very well wrong=
=20
> but it feels that either this is wrong and it should be `sdata->vif.type=
=20
> =3D=3D NL80211_IFTYPE_AP`

If we _are_ the AP then we won't parse data coming _from_ the AP, so
it's correct.

> or this is correct but it won't work with mesh=20
> point for example and that=C2=A0 `sdata->vif.type !=3D NL80211_IFTYPE_AP`=
 would=20
> be better.

Also no, according to the spec, I even quoted it the other day. But I
guess if someone wants UHR on mesh they have a bunch of work anyway, so
it doesn't even matter.

johannes
>=20

