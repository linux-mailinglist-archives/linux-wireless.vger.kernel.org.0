Return-Path: <linux-wireless+bounces-19584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED1DA49A59
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1AE18943CC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7B260385;
	Fri, 28 Feb 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l7jr1LfQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCEE26B96C
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748570; cv=none; b=pyiTfCRqMRd58jjSYaj+DWNxCK6Bq9OB/r6iS5R3S1S1Jou7qVYDX+1QhlM7NIRq9povXvJV351HaF6Kmaa29Z93NPyaVTuqbVdCNck6PwXNq4uCyPxzCTiseedAdE6EQ4LiRrjLgBDGOSX+Cf+0Gyo4/zZ20wAfKrO0oL6qJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748570; c=relaxed/simple;
	bh=qZwY6N0PceFwIDk6aLaT8Ls033oUm6ifDXhJiAsYB8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXIDjdGSY0YiQsRLjdFaXnqL9bOfyaRQdeXUhacJFXxcYp6dpFjTpvOkiq6NmAZ52TXOpQY63lr/xtB1CAAzcifQzxoDmAS1uCioYJ0v48sYq7SImK6UpYmAteSe4Ke4ECcNUaWX1zCh8+RW7RYy1AjWJBxbL7xbvEbIECjDTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l7jr1LfQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/8IKjghX0ae++1FQWsxK/kTlOr7Vb66IETKu1PWG7JU=;
	t=1740748568; x=1741958168; b=l7jr1LfQjuYefFmWiUYC7a6IfrH2pWLWzY/h7LeXRG/Ok2V
	HX+IkxfB7c4EuWJWOJ49bac578iwgXWbABwym5hMN3CO5ikKr8APaSTwlcqedu4QEg4zyiJl39JYw
	+WJMw6KcvvtqvmhOwWixcKt4aLtyCB8kkmGaCDvogcxM7L9e02gDrjLlDb3AYI/Zgn+c7d/pne9Cl
	frgGn7vM7NYzBM/9+6pOetPk8xGc1K3z092YHhYHcQz+iIlEaPxGoTCDDRC16rEjl7+aaH5KV/Yfj
	3liZQ6fae4Flm/NujupWU2Fw1WPUDCgPyZ3bU42OReqbSZIMdE/0Xb8FlwmkttTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to0Dl-0000000Dktk-1syr;
	Fri, 28 Feb 2025 14:16:05 +0100
Message-ID: <38d1d5f8be439e8553cddd2df03bf3553bafb82f.camel@sipsolutions.net>
Subject: Re: [PATCH v3 03/12] wifi: mac80211: add support towards MLO
 handling of station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:16:04 +0100
In-Reply-To: <20250213171632.1646538-4-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
	 <20250213171632.1646538-4-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
>=20
> -	if (!sta->deflink.pcpu_rx_stats)
> +	if (link_id < 0)
> +		link_sta_info =3D &sta->deflink;
> +	else
> +		link_sta_info =3D
> +			rcu_dereference_protected(sta->link[link_id],
> +						  lockdep_is_held(&sta->local->hw.wiphy->mtx));

We have all kinds of helper macros for that? Even this very specific
case: link_sta_dereference_protected()

> +	stats =3D &link_sta_info->rx_stats;

Should you check that link_sta_info even exists, just in case some link
IDs get mixed up? Not sure.

> -unsigned long ieee80211_sta_last_active(struct sta_info *sta)
> +unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_i=
d)
>  {
> -	struct ieee80211_sta_rx_stats *stats =3D sta_get_last_rx_stats(sta);
> +	struct ieee80211_sta_rx_stats *stats =3D sta_get_last_rx_stats(sta, lin=
k_id);
> +	struct link_sta_info *link_sta_info;
> +
> +	if (link_id < 0)
> +		link_sta_info =3D &sta->deflink;
> +	else
> +		link_sta_info =3D
> +			rcu_dereference_protected(sta->link[link_id],
> +						  lockdep_is_held(&sta->local->hw.wiphy->mtx));
> =20
> -	if (!sta->deflink.status_stats.last_ack ||
> -	    time_after(stats->last_rx, sta->deflink.status_stats.last_ack))
> +	if (!link_sta_info->status_stats.last_ack ||
> +	    time_after(stats->last_rx, link_sta_info->status_stats.last_ack))
>  		return stats->last_rx;
> -	return sta->deflink.status_stats.last_ack;
> +
> +	return link_sta_info->status_stats.last_ack;
>  }

This seems wrong, if you ask for -1 you get deflink but that's no longer
updated at all, so you break the current/updated sta_set_sinfo() usage
with this since you just use -1 statically there now (with this patch.)

>  static void sta_update_codel_params(struct sta_info *sta, u32 thr)
> diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
> index 07b7ec39a52f..7e600c82a6e1 100644
> --- a/net/mac80211/sta_info.h
> +++ b/net/mac80211/sta_info.h
> @@ -947,7 +947,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info =
*sta);
>  void ieee80211_sta_ps_deliver_poll_response(struct sta_info *sta);
>  void ieee80211_sta_ps_deliver_uapsd(struct sta_info *sta);
> =20
> -unsigned long ieee80211_sta_last_active(struct sta_info *sta);
> +unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_i=
d);
> =20
>  void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
>  					   const u8 *ext_capab,
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index f6b631faf4f7..1e2cb33030da 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -3276,14 +3276,28 @@ int ieee80211_put_srates_elem(struct sk_buff *skb=
,
>  	return 0;
>  }
> =20
> -int ieee80211_ave_rssi(struct ieee80211_vif *vif)
> +int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id)
>  {
>  	struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
> +	struct ieee80211_link_data *link_data;
> +	int rssi;
> =20
>  	if (WARN_ON_ONCE(sdata->vif.type !=3D NL80211_IFTYPE_STATION))
>  		return 0;
> =20
> -	return -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal=
);
> +	if (link_id < 0)
> +		link_data =3D &sdata->deflink;
> +	else
> +		link_data =3D
> +			rcu_dereference_protected(sdata->link[link_id],
> +						  lockdep_is_held(&sdata->local->hw.wiphy->mtx));
> +
> +	if (WARN_ON(!link_data))
> +		return -99;
> +
> +	rssi =3D -ewma_beacon_signal_read(&link_data->u.mgd.ave_beacon_signal);
> +
> +	return rssi;

what's the point in the trivial intermediate 'rssi' variable? It's not
even for line length since "rssi =3D " is the same length as "return "?

johannes


