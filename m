Return-Path: <linux-wireless+bounces-37490-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cLGcLjZwJmoKWgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37490-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:33:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A87653901
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=WLxUD0YC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37490-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37490-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB6530254AE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A572EEE67;
	Mon,  8 Jun 2026 07:30:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41E38F938
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 07:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903850; cv=none; b=N43l2t/l2uTHL2NLFCdWWidF1xG7pFuFAUbQHFfI1PpnVRBPug6yyQQw1giLJ65fYF6wLRc5ZjGPHS25ObCxXZ4Sdnkp46eDIungvrf3fq6edRePDx09V2oSvyNR+9zq+R1I2hqdafKvxUccRy2hpXNIrrhrniqJTNCmlh/82YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903850; c=relaxed/simple;
	bh=G+NJlSbabxnkRbE1W48V1WYZLjMDjijNvinKVGMZaag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQcYAPIJLvV2a9Au97uoVx0Vuel+f+kzElTyCRDycNXzchyDbZFIxLVcoeMvvx3gEsaOvUOqJZWLslPh9kqCe5ROUFWpQm4rwIZinNhqs62Hb0Vj/CgvjdspymnZkM1gpsOWczCEQ/bcVd7bBhK5DS+lltwMrQbTEvlj6HEGUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WLxUD0YC; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IGAs3kf3DqIJWdQ39BL7xCjyKdgupdA/VtxFLplKKMU=;
	t=1780903848; x=1782113448; b=WLxUD0YCY1L0JN1P1yv9jSpGElHhgn0NG6cr0fQyvmaaSkm
	c+umr9k5mxCTCVtLJt/q1PSdeRrkltojRWwQUWjXpQMaCMe+HEQPdJQjbW5XMGBLSv2GL51wm6lIG
	SzVqxxLtXanQ1ECD0pUDzbzNFeuWqtvonG7/fJGUa807bqr/3pe+f8mIo0//OYuoJ1R4pTHIF+Ufr
	NA+3pBLpPvM7feCPYggRJZu8zdjUwICdisG4rWxJhfwXR8ggz5l5NDBs9hdx043+sJNOUboPXivzz
	tMGr42le2pIbsUkuTS00CObeydyGn89bDgDiA+dIqsfRSRTV6jr6JxVfclus44Ow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wWURZ-00000005ZMS-1EVx;
	Mon, 08 Jun 2026 09:30:45 +0200
Message-ID: <39d12d9ae3b18495ed634715c93ede2f68c5bbf0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 3/5] wifi: cfg80211: Refactor
 nl80211_dump_station() to prepare for per-link stats
From: Johannes Berg <johannes@sipsolutions.net>
To: P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Mon, 08 Jun 2026 09:30:44 +0200
In-Reply-To: <20260607175912.2266215-4-praneesh.p@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
	 <20260607175912.2266215-4-praneesh.p@oss.qualcomm.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37490-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praneesh.p@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34A87653901

On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
>=20
> +++ b/net/wireless/nl80211.c
> @@ -39,6 +39,39 @@ static int nl80211_crypto_settings(struct cfg80211_reg=
istered_device *rdev,
> =20
>  /* the netlink family */
>  static struct genl_family nl80211_fam;
> +/**
> + * enum nl80211_dump_station_phase - station dump fragmentation phases
> + * @NL80211_DUMP_STA_PHASE_AGGREGATED: send aggregated (MLO-combined) st=
ation
> + *	statistics for the station entry
> + * @NL80211_DUMP_STA_PHASE_PER_LINK: send per-link statistics for each a=
ctive
> + *	MLO link of the station; only used when dump_link_stats is set
> + */
> +enum nl80211_dump_station_phase {
> +	NL80211_DUMP_STA_PHASE_AGGREGATED =3D 0,
> +	NL80211_DUMP_STA_PHASE_PER_LINK   =3D 1,
> +};

[snip]

probably nicer to move this stuff to closer to the dump code that needs
it; at the very least it's missing a blank line.

Also I think the whole 'phase' introduction etc. seems to more belong to
patch 4 instead of this one? We can still do the structure allocation
etc. here.

> +struct nl80211_dump_station_ctx {
> +	int sta_idx;
> +	enum nl80211_dump_station_phase phase;
> +	u8 mac_addr[ETH_ALEN];
> +	struct station_info sinfo;
> +};
> +
> +/**
> + * struct nl80211_dump_station_cb - state stored in netlink_callback::ct=
x
> + * @wiphy_idx: args[0] - wiphy index from nl80211_prepare_wdev_dump
> + * @wdev_id: args[1] - wdev identifier from nl80211_prepare_wdev_dump
> + * @ctx: args[2] - dump station context pointer
> + *
> + * args[0] and args[1] are reserved by nl80211_prepare_wdev_dump().
> + * The ctx pointer must live at args[2] to avoid corrupting those fields=
.
> + */
> +struct nl80211_dump_station_cb {
> +	long wiphy_idx;
> +	long wdev_id;
> +	struct nl80211_dump_station_ctx *ctx;
> +};

I'm not sure I'm happy with this - better to just use args[2] directly
for a pointer to struct nl80211_dump_station_ctx?

>  static int nl80211_dump_station(struct sk_buff *skb,
>  				struct netlink_callback *cb)
>  {
> -	struct station_info sinfo;
>  	struct cfg80211_registered_device *rdev;
>  	struct wireless_dev *wdev;
> -	u8 mac_addr[ETH_ALEN];
> -	int sta_idx =3D cb->args[2];
> -	bool sinfo_alloc =3D false;
> -	int err, i;
> +	struct nl80211_dump_station_cb *cb_data =3D (void *)cb->ctx;
> +	struct nl80211_dump_station_ctx *ctx =3D cb_data->ctx;

This doesn't really seem better than just doing

	struct nl80211_dump_station_ctx *ctx =3D cb->args[2];

given the overlay with generic code.

Alternatively we could change the _whole_ nl80211 code (as a separate
commit, perhaps even converting other things later) to have

struct nl80211_dump_cb {
	long wiphy_idx;
	long wdev_id;
	union {
		long wiphy_filter;
		int mpath_idx;
		int reg_idx;
		int bss_idx;
		int survey_idx;
		//...

		// and later add
		struct nl80211_dump_station_ctx *sta_ctx;
	};
};

or so, and then we don't have the args[0]/... problem at all.

But I'm not convinced mixing the structs with "must have this type at
this offset" etc. is a good idea if it's going to stay this way.

> +	/* Phase 0: dump aggregated station info */
> +	if (ctx->phase =3D=3D NL80211_DUMP_STA_PHASE_AGGREGATED) {
> +		while (true) {
> +			memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
>=20

if you have this memset, why do you need this one:

> +out_err_release:
> +	cfg80211_sinfo_release_content(&ctx->sinfo);
> +	memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));

Seems a bit odd?

johannes

