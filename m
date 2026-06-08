Return-Path: <linux-wireless+bounces-37491-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L17SLH9yJmqTWgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37491-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:42:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87FB653A64
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=GdJkj5nV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37491-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37491-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FC7630028E4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECD36DA18;
	Mon,  8 Jun 2026 07:42:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49B38F945
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 07:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904568; cv=none; b=gxnpVV57tVWoMAsh40W7qTz+81HapJO1V/p0PW491tB06qPVkFwU+YhF5TmBM0+xPgQT2n8HFBFrieXFKbkvLk3myHQYTtiFjmhZpFshJxiLzdhNLPHofgmC6ApbEvAfbTc0LfHaz0APkUpo0tblNWQ5T3lnU8tOPs8Bj2r73kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904568; c=relaxed/simple;
	bh=NKW8uXKChpH7ZwaUIBE9cXLDKB5rJ+mePdXf/C639gY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHtdcFKl/9sKGm61ppLwItYl4j5gVjG+8v73/AZowCfpGojQzp6uWXViStMCM1drXwGzi6f5vTYZHepNgMez5pTs+J2Ulfl0I0xBrKSnILXdmB4oMvJaDBPMhkyTgThKOcG6M86VtlDyT/f5wOeCVsmLAfuB1gMGNhog6GFh2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GdJkj5nV; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uhDeRmileUJXcl1fvdlAJxA6CEwCjrZVRNbCymhRyUU=;
	t=1780904567; x=1782114167; b=GdJkj5nV0nr1l6v+ss/5d/RfpQfnpxutH5S62NJzAXKFBPs
	+qeZQ18CZdq8WFWoWs2olJq76HMUK/yJ4PALmY/gsJNndXxFsXB2MJgv/L8UOyvRV8mVrR1Th+HYs
	OxU2kXJsJrZXkjiRBm9zH6aLg47YYJ2dS4N/QUlkWUynGFmjvql3W0KhC8bl+PHvylhsZ+mxAnHc3
	CYQlU0OtYcWxCVB9PfKrLN0eGcZqJf75qgIOOzdf7SLP9A3n/nKLcr979rNTs6c6Vujj7u7cFOpPP
	ZLXlxqrzUui7yo/SvLSBbt5YRDbmeJfAMIcepWndyzcm25o9lMnGuRn2qVe7uhMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wWUd9-00000005Zjo-3oQp;
	Mon, 08 Jun 2026 09:42:44 +0200
Message-ID: <88c183f827eb184e6d471964662b7ee89caf63ad.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 4/5] wifi: cfg80211: Fragment per-link
 station stats in nl80211_dump_station()
From: Johannes Berg <johannes@sipsolutions.net>
To: P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Mon, 08 Jun 2026 09:42:43 +0200
In-Reply-To: <20260607175912.2266215-5-praneesh.p@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
	 <20260607175912.2266215-5-praneesh.p@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37491-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praneesh.p@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: D87FB653A64

On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
>=20
> =20
> +static int nl80211_fill_link_station(struct sk_buff *msg,
> +				     struct cfg80211_registered_device *rdev,
> +				     struct link_station_info *link_sinfo)
> +{
> +	struct nlattr *bss_param, *link_sinfoattr;
> +
> +#define PUT_LINK_SINFO(attr, memb, type) do {				\
> +	BUILD_BUG_ON(sizeof(type) =3D=3D sizeof(u64));			\
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
> +	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
> +			     link_sinfo->memb))				\
> +		goto nla_put_failure;					\
> +	} while (0)
> +#define PUT_LINK_SINFO_U64(attr, memb) do {				\
> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
> +	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
> +			      link_sinfo->memb, NL80211_STA_INFO_PAD))	\
> +		goto nla_put_failure;					\
> +	} while (0)
> +
> +	link_sinfoattr =3D nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);

See previous note about _noflag() in all of this code - that shouldn't
be there.

> +static int nl80211_send_link_station(struct sk_buff *msg,
> +				     struct netlink_callback *cb,
> +				     struct cfg80211_registered_device *rdev,
> +				     struct wireless_dev *wdev,
> +				     const u8 *mac_addr,
> +				     struct station_info *sinfo,
> +				     int link_idx)
> +{
> +	void *hdr;
> +	struct nlattr *links, *link;
> +	struct link_station_info *link_sinfo;
> +	struct nlattr *sinfoattr;
> +	int err;
> +
> +	hdr =3D nl80211hdr_put(msg, NETLINK_CB(cb->skb).portid,
> +			     cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +			     NL80211_CMD_NEW_STATION);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if ((wdev->netdev &&
> +	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
> +	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
> +			      NL80211_ATTR_PAD) ||
> +	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
> +	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation)) {
> +		err =3D -EMSGSIZE;
> +		goto err_cancel;
> +	}
> +
> +	sinfoattr =3D nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
> +	if (!sinfoattr) {
> +		err =3D -EMSGSIZE;
> +		goto err_cancel;
> +	}
> +
> +	link_sinfo =3D sinfo->links[link_idx];
> +	if (!link_sinfo) {
> +		err =3D -ENOENT;
> +		goto err_cancel;
> +	}
> +
> +	nla_nest_end(msg, sinfoattr);
> +	if (!is_valid_ether_addr(link_sinfo->addr)) {
> +		err =3D -EADDRNOTAVAIL;
> +		goto err_cancel;

That seems really odd? why even bother going into the whole thing if
it's invalid? Also, doesn't that ENOENT get propagated all the way and
it aborts? I guess it does but it should never happen because of
valid_links? Still seems a bit odd.

>=20
> @@ -8354,13 +8616,22 @@ static int nl80211_dump_station(struct sk_buff *s=
kb,
>  	struct wireless_dev *wdev;
>  	struct nl80211_dump_station_cb *cb_data =3D (void *)cb->ctx;
>  	struct nl80211_dump_station_ctx *ctx =3D cb_data->ctx;
> +	struct nlattr **attrbuf =3D NULL;
>  	int err, ret;
> =20
>  	NL_ASSERT_CTX_FITS(struct nl80211_dump_station_cb);
> =20
> -	err =3D nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
> -	if (err)
> +	if (!ctx) {
> +		attrbuf =3D kzalloc_objs(*attrbuf, NUM_NL80211_ATTR);
> +		if (!attrbuf)
> +			return -ENOMEM;
> +	}
> +
> +	err =3D nl80211_prepare_wdev_dump(cb, &rdev, &wdev, attrbuf);
> +	if (err) {
> +		kfree(attrbuf);
>  		return err;
> +	}
> =20
>  	/* nl80211_prepare_wdev_dump acquired it in the successful case */
>  	__acquire(&rdev->wiphy.mtx);
> @@ -8369,15 +8640,22 @@ static int nl80211_dump_station(struct sk_buff *s=
kb,
>  	if (!ctx) {
>  		ctx =3D kzalloc_obj(*ctx);
>  		if (!ctx) {
> +			kfree(attrbuf);

perhaps better to __free(kfree) instead of doing all these kfree()
calls?

> -	/* Phase 0: dump aggregated station info */
> -	if (ctx->phase =3D=3D NL80211_DUMP_STA_PHASE_AGGREGATED) {
> -		while (true) {
> +	while (true) {
> +		/* Phase 0: dump aggregated station info */
> +		if (ctx->phase =3D=3D NL80211_DUMP_STA_PHASE_AGGREGATED) {

changing it now also kind of argues for not having it in the first patch
in the first place ;-)

>  			memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
>  			for (int i =3D 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
>  				ctx->sinfo.links[i] =3D
> @@ -8428,15 +8706,45 @@ static int nl80211_dump_station(struct sk_buff *s=
kb,
>  				goto out_err_release;
>  			}
> =20
> -			/* Reset ctx for next station */
> -			cfg80211_sinfo_release_content(&ctx->sinfo);
> -			ctx->sta_idx++;
> +			ctx->phase =3D NL80211_DUMP_STA_PHASE_PER_LINK;
>  		}
> -	}
> =20
> -	ctx->phase =3D NL80211_DUMP_STA_PHASE_AGGREGATED;
> -	err =3D skb->len;
> -	goto out_err;
> +		/* Phase 1: dump per-link station info */
> +		if (ctx->phase =3D=3D NL80211_DUMP_STA_PHASE_PER_LINK &&
> +		    ctx->dump_link_stats && ctx->sinfo.valid_links) {
> +			while (ctx->link_idx < IEEE80211_MLD_MAX_NUM_LINKS) {
> +				if (!(ctx->sinfo.valid_links &
> +				      BIT(ctx->link_idx))) {
> +					ctx->link_idx++;
> +					continue;
> +				}
> +
> +				ret =3D nl80211_send_link_station(skb, cb, rdev,
> +								wdev,
> +								ctx->mac_addr,
> +								&ctx->sinfo,
> +								ctx->link_idx);
>=20

I think conceptually this code is structured a bit strangely. It would
seem a lot simpler to me to do something like


	// not literally such a macro, just the while (true) loop
	for_each_station_starting_from_idx(...) {
		if (ctx->phase =3D=3D 0) {
			// fill sinfo etc.
		}

		// common stuff
		nl80211hdr_put()
		nla_put_u32(msg, NL80211_ATTR_IFINDEX...)
		nla_put_u64_64bit(msg, NL80211_ATTR_WDEV..)
		nla_put(msg, NL80211_ATTR_MAC...)
		nla_put_u32(msg, NL80211_ATTR_GENERATION...)

		switch (phase) {
		case 0:
			nl80211_put_sta_info_common(...);
			phase++;
			ctx->link_id =3D 0;
			break;
		case 1:
			if (!multi-phase-requested)
				break;
			nl80211_put_link_station(..., ctx->link_id);
			ctx->link_id++;
			if (link_id =3D=3D NUM_LINKS)
				ctx->phase =3D 0; // next sta
			break;
		}
	}


or something like that, more like we handle wiphy dump with all the
messages, for example?

I think it'd be better to have just one place that creates the header
and all the common info.

But maybe it's just my brain pathways being trained for that scheme.

johannes

