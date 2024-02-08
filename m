Return-Path: <linux-wireless+bounces-3333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53684E20C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 14:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86673282731
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09DD762F0;
	Thu,  8 Feb 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="itHMInCZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA2763EC
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399354; cv=none; b=h/t7z+MGrXFYVv0oA7kuTQYTYdhe6dVLVt4tLCGbMFV9e1SE6A3ptlyAxdlw1z9uT6Rkod6AEa54MuGJ6OrcKtv5kjj/SDkyzHUwIskIjbVXCvW3bcsmrRmj4Jd3z097x7D9/CX3cvammI8xexHOzFWZS6x6kGI8iB5gWs2o17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399354; c=relaxed/simple;
	bh=hP305+Afo2wbGGXrExtos8KS4x99SmFFbo3z1s+hvFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ofS6x9hKb1KuCtNdf/jd0SiqNqTEliawF3Mh3afog5S3g0Rbg0HRJbqQVc6aIzStGMmuPvkuhYPvX1T4MQndA5OAKys/RRx3Fnj4Q3MY5bzIIyrKg0O3gG0wumLTl3m5jQeduG6/JnH/NfwwLirmg8BxLLk/khwagMX7q8y28iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=itHMInCZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r17q1U4BSEBGcEVJq5z9iZi13EGZhxsJ18ERvTeuATs=;
	t=1707399350; x=1708608950; b=itHMInCZMb5lMxoLEziI9i6SKnf4WGP9ODqWOqLRYY7uN8e
	78ygeK66oOKh6ocW7NXLo0pCZO8dyNlnDc2/4f3wiMAfBZciAwFbkPHNAY2lVnJt/L1BEIU01jfL/
	+sOIj5EjYtbYo1fkhQGYom9c+blx6Jx7nmw5eWOLwV4QEEv6wencmGBRYbQTnJOOWFLZ0RrEveS1c
	erelUzPswHX+XCuUzowmoqDt2hWKOjAaWYZVpZLWzUhYHjTHiOc2vtv38VlnIXr+V67iT6oRRVaGX
	RbrCpWMBcATc6J03T70fokOeSLA7dL8xgRHXGl9sX6LzujOeO38uMQ3fP+gSyLwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rY4Z7-0000000HUJa-2rLW;
	Thu, 08 Feb 2024 14:35:45 +0100
Message-ID: <b74f21d22a41b2ca635e64f04c06d5db6d38d920.camel@sipsolutions.net>
Subject: Re: [v4,2/2] wifi: mac80211: refactor STA CSA parsing flows
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>, linux-mediatek
 <linux-mediatek@lists.infradead.org>
Date: Thu, 08 Feb 2024 14:35:44 +0100
In-Reply-To: <20231222010914.6521-3-michael-cy.lee@mediatek.com>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
	 <20231222010914.6521-3-michael-cy.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So ... I foolishly applied my other changes first, so I had to rebase
this - please do check.

Couple of questions/notes, if anything needs changing please send
another patch.

> +	he._oper.he_oper_params =3D cpu_to_le32(u32_encode_bits(1,
> +					IEEE80211_HE_OPERATION_6GHZ_OP_INFO));

(I changed this to le32_encode_bits, FWIW)

> +	/* if data is there validate the bandwidth & use it */
> +	if (new_chandef.chan) {
> +		if (conn_flags & IEEE80211_CONN_DISABLE_320MHZ &&
> +		    new_chandef.width =3D=3D NL80211_CHAN_WIDTH_320)
> +			ieee80211_chandef_downgrade(&new_chandef);
> =20
>  		if (conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
> -		    new_vht_chandef.width =3D=3D NL80211_CHAN_WIDTH_80P80)
> -			ieee80211_chandef_downgrade(&new_vht_chandef);
> +		    new_chandef.width =3D=3D NL80211_CHAN_WIDTH_80P80)
> +			ieee80211_chandef_downgrade(&new_chandef);
> +
>  		if (conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
> -		    new_vht_chandef.width =3D=3D NL80211_CHAN_WIDTH_160)
> -			ieee80211_chandef_downgrade(&new_vht_chandef);
> -	}
> +		    new_chandef.width =3D=3D NL80211_CHAN_WIDTH_160)
> +			ieee80211_chandef_downgrade(&new_chandef);
> =20


Shouldn't that have (had!) an 80 MHz handling case? Or maybe a loop a la
the one in ieee80211_config_bw():

        /*
         * Downgrade the new channel if we associated with restricted
         * bandwidth capabilities. For example, if we associated as a
         * 20 MHz STA to a 40 MHz AP (due to regulatory, capabilities
         * or config reasons) then switching to a 40 MHz channel now
         * won't do us any good -- we couldn't use it with the AP.
         */
        while (link->u.mgd.conn.bw_limit <
                        ieee80211_min_bw_limit_from_chandef(&chanreq.oper))
                ieee80211_chandef_downgrade(&chanreq.oper, NULL);


Feels like this should be the same here.

Also note how this uses ieee80211_chandef_downgrade() - we really need
to track the "chanreq.oper" vs. "chanreq.ap" in this code as well for
puncturing - can I ask you to take a brief look at that? I'll anyway
probably have to look at that soon though.

johannes

