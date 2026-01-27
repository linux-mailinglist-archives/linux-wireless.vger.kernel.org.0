Return-Path: <linux-wireless+bounces-31238-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC4oDIXneGmHtwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31238-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:27:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873EE97C1D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8247C30160EE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF09E22A7E4;
	Tue, 27 Jan 2026 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HHUSAedm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A4243951
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531254; cv=none; b=F6quBmsupII9QnxXrR7InlDM2fxmp5I5hoSBIT7RAvVn5QnQansrGJPqMOYxftX0+1zzomOmh8lMyfwBlcsA+xgBsmaxmSrQP1FyoqV+/0qo0/OiB4vMlf2V283jdWQabdufevQp4M76Dm409mv7jkZCeGZCEWS7mX0H5L78vSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531254; c=relaxed/simple;
	bh=wFR6oYei0hA5qkGiSJ81kZMal9eEBK8tCDpi4X8wxsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NleE8jgledlEV6l/Wtn6TxD3+QqBENb3YlM3vxAOy/5lAEfpmmaE2ETtur2Cch1wobDt6lHOrSutL2tX8brnMBm/LMNr1q0sUCnZEDBe5lY2DzByVF3xd4BfkbSfsbh9xY5U7KYQorI4y5mx8eoARYcUQEuWft1AxPEL0K2WrgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HHUSAedm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IC61uJnWjoxTsOrevC30zWaSgGuRpaR3Rt5ifukdits=;
	t=1769531253; x=1770740853; b=HHUSAedmGX1JWnjfFYTyoXp3CIKX4p+1L9Ituo0Fq3EFeKw
	Uqqs8eMqELEKZohNGmD8+hpOxr03O8KctBhVf8iijT0MIG03lOChPA+3n561Aq9B8gNRNM8YTcZ/b
	libf/wCDBBeHNoV50Rf+BOkSv8/jbHDd9R3qQB+gRCIWt70/oOpJaIzzVtn3AJoI+ZF/1KefW14QL
	9uz357F75SDtNUgCvbHYpm5e9qc875orhcR2884jYrwHLDpiEFgF6Uuj6m8MB+nvWakjsAVIICB+/
	qd3JNBRgoXsum1jFrIy8B5Um+NDTpGHBRhw5iuZV9U3aQXW3HRx5dNZa0yKBfLAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vklud-000000054LU-06Sm;
	Tue, 27 Jan 2026 17:27:31 +0100
Message-ID: <71915f491ec27e2a13bf291e3dfeb729fda398f1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 1/3] wifi: ieee80211: add some initial
 UHR definitions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Date: Tue, 27 Jan 2026 17:27:30 +0100
In-Reply-To: <55abccdc-3752-4bb6-b022-42901a8b303f@freebox.fr> (sfid-20260127_160821_325299_080AAAB6)
References: <20260127141005.583581-5-johannes@sipsolutions.net>
	 <20260127151005.7681c4f95202.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
	 <55abccdc-3752-4bb6-b022-42901a8b303f@freebox.fr>
	 (sfid-20260127_160821_325299_080AAAB6)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31238-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873EE97C1D
X-Rspamd-Action: no action

On Tue, 2026-01-27 at 16:08 +0100, Pablo MARTIN-GOMEZ wrote:
>=20
> > +#define IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN		0x000000FF
> So I understand you've changed the NPCA channel to be 8bits instead of=
=20
> 4. I see it's 8bits in D0.3 but it has been updated to 4bits in both=20
> D1.0 and D1.2, so I would believe 4bits is the correct value

Hmm. Four bits are clearly not enough to hold a "channel number" as
described in the text in D1.2, and had been told that it's going to be
changed to 8 bits. It's also inconsistent between this and 9.4.2.360.3
where it says it's 8 bits, but the interpretation is the same as here.
Clearly not possible.

However, now asking around again it seems that there's a chance it'll
just remain four bits places, defining this as the location of the NPCA
primary channel within the overall BSS bandwidth. But then the text
needs to be updated, the field should be renamed to "... Location", and
the 8 bit field in the update needs to be changed to four bits ...


Also, yes, I haven't updated this to D1.2 yet, not sure there's much
value in doing that at this point. Mostly we need this for the code and
the netlink attributes etc. at this point so Qualcomm can also base
their other changes on _something_.

> > +#define IEEE80211_UHR_MAC_CAP0_ML_PM_SUPP		0x08
> FYI this has been converted in Reserved for D1.2

Noted.

> > +#define IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV	0x1C
> I would choose between shrinking `Interval` into either INTV or INTVL=20
> but not use both
> > +#define IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTVL_LOW	0xE0

Heh, fair.

> > +
> > +#define IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTVL_LOW	0x03
> IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTVL_HIGH
> > +#define IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE		0x04
> You are missing the bit for Bounded ESS (B34) [BTM Assurance is B35]
> > +
> > +struct ieee80211_uhr_capa_mac {
> > +	u8 mac_cap[5];
> > +} __packed;
> DBE Capability Parameters is not handled yet? [it's defined in figure=20
> 9-aa8, even if the title of the figure is wrong in D1.0]

Seems plausible that the title of the figure confused me, or at least I
didn't trust it :)

> > +
> > +struct ieee80211_uhr_capa {
> > +	struct ieee80211_uhr_capa_mac mac;
> > +	u8 variable[];
> > +} __packed;
> > +
> > +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_LE80		0x01
> This is specifically for sounding NDP, I would name them=20
> IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_XXX instead

Yeah, good point.

> > +	WLAN_EID_EXT_BSS_TRANS_PARAMS =3D 155,
> This is specific for SMD, I feel like WLAN_EID_EXT_SMD_BSS_TRANS_PARAMS=
=20
> is more appropriate

fair

johannes

