Return-Path: <linux-wireless+bounces-18119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271AAA2185C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 08:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B1E3A3F55
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6644155C8C;
	Wed, 29 Jan 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DaKgoGTc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C02F30
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137337; cv=none; b=J7r7v7CvI1/w8Q3bm/jJUJUh9dpoYduzqrHVxw5yIKTOZiGW18k58rCdiGJ3UmiL5IWcQiXJpdwtfSvwMz+R7IGDuGxM1+JlxifMvUo5GGe3gRMOLzBR1n+LVf6FSc9IBk2Mb5+/d6J8Isz/karItBB7D4V4QXMwmwkIqi4RQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137337; c=relaxed/simple;
	bh=hfdrK3HZh/gVaBrjTIpes7PCiDS5awHDLsQUIcydi7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjnwRLWcVovsE5Qj2GSZEuOdmHuBH8NM24v3Dz/oGYEjdtQPqZQBPwgSKpopWxQwxQOScl2Kmxkfv1i1A5IClLlB+zddgZErSHMoI8gQxmuk7lwJOto1XdjCACPAsi2ENepBYWba5BNPp9MOw5YgeijtFQKZEN6P6yNqTPDyL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DaKgoGTc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ca6h6FlQEg4PBhQRT0RmJ4pKrJz6YZQg9lazmJHCDbA=;
	t=1738137336; x=1739346936; b=DaKgoGTcha5knzzQONGreBbpqC4IleHzXNXdiNEDtRFyW+o
	udZUkjkJ4yB4eDc/RxOy5qY4jKAQLLHsV7SO0kEIZZmrAiovaEVnBIhbkDWu3ozwIRlDsGTgsTQs8
	oQ3FmQIJqFaZXdB0y2IZA8EWKmurTNhAH9jvqEat/37S98H0T+9v3Ze5RVDb4SOLo2Nf4yaxA1sQS
	GfRIb9w1pc+uzQ8tjKxjoFaxARmiCps37Zo597/9Pxu7JJaI9YwPumaVRGR60+gbk3MXbnuuBRVCt
	GYJvopf5LycvMY31Md0kDEssHGqqhYAcThzbuO5x/PEPfRN3qyY1KrUobQISkZFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1td2v5-0000000DqjD-35ow;
	Wed, 29 Jan 2025 08:55:32 +0100
Message-ID: <03d0cf2612d6bb5e4a6d5e50650be12c81702ffb.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 06/13] wifi: mac80211: Add new TX queues to replace
 legacy TX
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 29 Jan 2025 08:55:31 +0100
In-Reply-To: <20250127162625.20747-7-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
	 <20250127162625.20747-7-Alexander@wetzel-home.de>
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

On Mon, 2025-01-27 at 17:26 +0100, Alexander Wetzel wrote:
>=20
> +++ b/net/mac80211/iface.c
> @@ -1124,11 +1124,63 @@ static void ieee80211_sdata_init(struct ieee80211=
_local *local,
>  	 * MLD connection, we get a separate allocation for it.
>  	 */
>  	ieee80211_link_init(sdata, -1, &sdata->deflink, &sdata->vif.bss_conf);
> +
> +	for (int i =3D 0; i < NUM_NL80211_BANDS; i++) {
> +		struct ieee80211_supported_band *sband;
> +
> +		sband =3D local->hw.wiphy->bands[i];
> +		sdata->rc_rateidx_mask[i] =3D
> +			sband ? (1 << sband->n_bitrates) - 1 : 0;


Feels like this code move should perhaps be in a separate refactoring
patch?

> +static void ieee80211_vif_txq_init(struct ieee80211_sub_if_data *sdata,
> +				   int txq_offset, int txq_size, int num_queues)
> +{
> +	void *buffer =3D (char *)sdata + txq_offset;

That seems ... awkward at best, my first instinct would be to say this
must be wrong.

Do we really need to do this dynamically just to save two a bit of
memory for VLAN and (virtual) monitor interfaces?

Would probably be better to use pointers to a TXQ array instead of
embedding them then, or otherwise just embed enough for all kinds of
interfaces and just not use them.

> -void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
> +static void ieee80211_purge_txqs(struct ieee80211_sub_if_data *sdata)
>  {
> -	struct ieee80211_txq *txq =3D sdata->vif.txq[IEEE80211_VIF_TXQ_MULTICAS=
T];
> +	struct sta_info *sta;
> =20
> +	list_for_each_entry(sta, &sdata->local->sta_list, list) {
> +		if (sdata !=3D sta->sdata)
> +			continue;
> +		ieee80211_purge_sta_txqs(sta);
> +	}
> +
> +	for (int i =3D IEEE80211_VIF_TXQ_MULTICAST;
> +	     i <=3D IEEE80211_VIF_TXQ_FALLBACK;
> +	     i++) {
> +		if (sdata->vif.txq[i])
> +			ieee80211_txq_purge(sdata->local,
> +					    to_txq_info(sdata->vif.txq[i]));
> +	}
> +
> +	synchronize_rcu();

You should keep the synchronize_rcu() outside this function. It's
expensive, and

> @@ -2300,6 +2342,8 @@ void ieee80211_remove_interfaces(struct ieee80211_l=
ocal *local)
>  	list_for_each_entry_safe(sdata, tmp, &unreg_list, list) {
>  		bool netdev =3D sdata->dev;
> =20
> +		ieee80211_purge_txqs(sdata);
> +
>  		/*
>  		 * Remove IP addresses explicitly, since the notifier will
>  		 * skip the callbacks if wdev->registered is false, since

can be amortized across all interfaces in this case.

> @@ -3803,7 +3818,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee802=
11_hw *hw,
>  	struct ieee80211_vif *vif =3D txq->vif;
>  	int q =3D vif->hw_queue[txq->ac];
>  	unsigned long flags;
> -	bool q_stopped;
> +	int qsr;

Should be "unsigned long qsr", to match queue_stop_reasons, I guess.

> +		/* Drop off-channel frames if queues are stopped for any reason
> +		 * other than off-channel operation. Never queue them.
> +		 */
> +		if (unlikely(txq->tid =3D=3D IEEE80211_TXQ_NOQUEUE)) {
> +			WARN(1, "mac80211: Drop noqueue TX. qsr=3D%i\n", qsr);
> +			ieee80211_txq_purge(local, txqi);
> +			return NULL;
> +		}

if (WARN_ON(...)) { ... }

Perhaps better just "if (WARN_ON_ONCE())", since it's in TX.

> +static void __ieee80211_wake_txq(struct ieee80211_local *local,
> +				 struct ieee80211_txq *txq)
> +{
> +	struct txq_info *txqi =3D to_txq_info(txq);
> +	struct fq *fq =3D &local->fq;
> +
> +	if (WARN_ON(!txq))
> +		return;
> +	if (test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags)) {
> +		spin_unlock(&fq->lock);
> +		drv_wake_tx_queue(local, txqi);
> +		spin_lock(&fq->lock);
> +	}
> +}

I really don't like dropping locks in the middle - if that's *really*
needed there better be a very good reason and a good comment indicating
why it's safe, including a comment in the caller that says this happens.

> +	/* %IEEE80211_VIF_TXQ_NOQUEUE must be ignored here */

No need for % outside kernel-doc.

> +
> +	if (ac =3D=3D IEEE80211_AC_VO) {
> +		__ieee80211_wake_txq(local,
> +				     vif->txq[IEEE80211_VIF_TXQ_FALLBACK]);
> +	}

nit: no need for braces

Why is VO special, not sure I understand the logic of checking the AC?

> +	if (ac =3D=3D IEEE80211_AC_BE && vif->txq[IEEE80211_VIF_TXQ_MULTICAST] =
&&
> +	    (!ps || !atomic_read(&ps->num_sta_ps)))
> +		__ieee80211_wake_txq(local,
> +				     vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);

Also here, why BE?

>  	list_for_each_entry_rcu(sta, &local->sta_list, list) {
>  		if (sdata !=3D sta->sdata)
>  			continue;
> =20
> -		for (i =3D 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
> +		/* IEEE80211_TXQ_NOQUEUE must be ignored here. */

some of these comments should probably say _why_ too

johannes

