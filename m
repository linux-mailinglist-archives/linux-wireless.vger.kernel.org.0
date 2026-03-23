Return-Path: <linux-wireless+bounces-33706-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YImEBesYwWn5QQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33706-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:41:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D72F05D8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A6B3052894
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4597638BF92;
	Mon, 23 Mar 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TXhN+AaW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187E36A023
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262130; cv=none; b=F3LL6I+2sPltCqGyUSoalU4sBkiPhrenJzNX97KAQZFaJD40xOTUlW5H6J3MqLCQ40NOoM1/jRV+yKv6pidVTMLvzSphrMUQgGt/yIx6ro9LdMWn5B6YyK2JhjS09I62CK2tZoBdYYWm8qandP8y4DOIM5saDX+o1yTOop1jvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262130; c=relaxed/simple;
	bh=qBwd8/hSrXhuKbRuU2js2LTmJD/TPMiNn/LQuB/GlCM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q4JO3a3CnHKUsgPOFQXLgbX5YAGvLvnzi0nuN2M5OIgLbj/xU6gHu6rTyMzoZyKbLqhqPAke0+b5AD8Zg+P+4H9LckTJkFsyb+ieZDiA+iyuYw2p+lQwwvnl23kOAIqKzGLHqexMaG/+ZjaLgAo5JIeSaHYXS+RoIDGoDNtcuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TXhN+AaW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2Usu7qZEA9xWiOLCeP0sTIJPaf8p6BpULdkVNzEwTTk=;
	t=1774262129; x=1775471729; b=TXhN+AaW24mZmgV0n2WvvUy0xlPOFZaGK0qsJz7v+dQPn99
	EBXMgXj0sSQrB6gZFI3QosEVPobqNPr9egppCYAuEmoVLgozv03cyl/8T49KuxB/zPHbE7ykWQyAo
	+F3u8jAK+XOJknHwNbg0t+EQUI/COkkl3BaMH0wfLyhsjiSmqqqVO1iANhEj9V8HQfeJW7fvxuyJP
	Wi/+FxNWYuNAlSO6p7p/ntHpHcrWU0qI24f9ixVpEO3WHrrg078K87HBYzq8zUb3eC8ivfchHZfTc
	gj1wPCJhTmjBhHOZS2e6RLbxroEiCcLECc1X4twftxRpdyg/3iHu1v0O/9yLZ0ow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4cd4-00000009hzA-2bvx;
	Mon, 23 Mar 2026 11:35:26 +0100
Message-ID: <bff61ac12183fe1382e2ed00afa2bb6b5a9d8187.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] wifi: mac80211: estimate expected throughput if not
 provided by driver/rc
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Mon, 23 Mar 2026 11:35:25 +0100
In-Reply-To: <20260323101954.874299-2-nbd@nbd.name>
References: <20260323101954.874299-1-nbd@nbd.name>
	 <20260323101954.874299-2-nbd@nbd.name>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33706-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nbd.name:email]
X-Rspamd-Queue-Id: 6A0D72F05D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 10:19 +0000, Felix Fietkau wrote:
> Estimate the tx throughput based on the expected per-packet tx time.
> This is useful for mesh implementations that rely on expected throughput,
> e.g. 802.11s or batman-adv.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/mac80211/sta_info.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index 4259e9c13ed7..912f00d905b8 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -2978,6 +2978,27 @@ static void sta_set_link_sinfo(struct sta_info *st=
a,
>  	}
>  }
> =20
> +static u32 sta_estimate_expected_throughput(struct sta_info *sta,
> +					    struct station_info *sinfo)
> +{
> +	struct ieee80211_sub_if_data *sdata =3D sta->sdata;
> +	struct ieee80211_local *local =3D sdata->local;
> +	struct rate_info *ri =3D &sinfo->txrate;
> +	struct ieee80211_hw *hw =3D &local->hw;
> +	struct ieee80211_chanctx_conf *conf;
> +	u32 duration;
> +	u8 band =3D 0;
> +
> +	conf =3D rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
> +	if (conf)
> +			band =3D conf->def.chan->band;

Double indentation, but 'u8 band =3D 0' is also really strange. Enum? And
should have a justification for assuming =3D0?

> +	duration =3D ieee80211_rate_expected_tx_airtime(hw, NULL, ri, band, tru=
e, 1024);
> +	duration +=3D duration >> 4; /* add assumed packet error rate of ~6% */
> +
> +	return ((1024 * USEC_PER_SEC) / duration) * 8;

this divides by zero.

> @@ -3202,6 +3223,8 @@ void sta_set_sinfo(struct sta_info *sta, struct sta=
tion_info *sinfo,
>  		sinfo->sta_flags.set |=3D BIT(NL80211_STA_FLAG_TDLS_PEER);
> =20
>  	thr =3D sta_get_expected_throughput(sta);
> +	if (!thr && (sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)))
> +	    thr =3D sta_estimate_expected_throughput(sta, sinfo);

Wrong indentation too ...

johannes

