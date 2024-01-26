Return-Path: <linux-wireless+bounces-2544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9183D784
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8757298219
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B942321376;
	Fri, 26 Jan 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fEHQ7RCZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFA2137C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261469; cv=none; b=VzL1be/VbRRLF1z2/rn98ZiSyxnTn4EwIK2dtvcUhpEvJYhKFV4wFcYT2zyfCONpAEPrAqG+5CwhSuaAmawDEa3T+ocqQqTNS53iLjaFSKmy1Qm8CBQrkTe0JEHQtRj9IQITEQ+0rNMKrnqBKoJ4KdD3pwwZn5l6ZY7sop4SZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261469; c=relaxed/simple;
	bh=DUeBnE8t5o/IANwUdzcrAWH1gJkDJGvEqfFAKz7IEuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPRnCzeznINraDv7a0RKOkW2OUf7chMiCxXfDEoF1SK69NbnMGFRdmYz6bGsmrBGDOVjc7ByRUgbj0vv9PLKYU3n8/3yZKgPrt7zWdvklz+7uHvsWNH7LeFdvQazDOTjxqd+Rd1JyktwYsxs/jvGXfGd14vaVA30NNJOuDtTcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fEHQ7RCZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Zynk4HDhT+uttHidxUCO3JOx8UKJ0a2TFSafw2kJVSw=;
	t=1706261465; x=1707471065; b=fEHQ7RCZa+LhfSEvhg+q2INDJQpTf9ZNhK7otcdMGwH2+F/
	7gCQkvSm51/miEKCdwrdSY/xKBBE6wVL3JhnmPmKPTzrkZ1y8Iyi44FSlasB6a8W7BHxXAlv6z3AM
	3EM9EI9Mlc5YJjbVlmJTyeDUc3G06HQylFIWXJg8tfTdUBvrAHwbyjI51rQQ+TQq2XUACpDSgyuea
	96JpLXmYxiZaipkODySFqemHh6ZEmh2rU5alvKiqaS9CMxBP5xLAFUJ89p6ooPOOjm80EiBcFzZQb
	o2lXZeqP8kTykE6sYJtqMFJB7mqOy/vGshvgyjrEMCLGhn05FlK0KMOVMmXwB3Aw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rTIYA-000000014uz-0dvP;
	Fri, 26 Jan 2024 10:31:02 +0100
Message-ID: <d4e77541479560147d453b7b5c06de3f940bad35.camel@sipsolutions.net>
Subject: Re: [PATCH v5 2/3] wifi: mac80211: add support for AP channel
 switch with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 26 Jan 2024 10:31:01 +0100
In-Reply-To: <20240125130410.827701-3-quic_adisi@quicinc.com>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
	 <20240125130410.827701-3-quic_adisi@quicinc.com>
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

On Thu, 2024-01-25 at 18:34 +0530, Aditya Kumar Singh wrote:
> Currently, during channel switch, deflink (or link_id 0)

The parenthetical is wrong: deflink isn't even a valid/used link *at
all* in MLD data structures. Speaking about "link_id 0" would be a valid
thing to do even for MLD, but speaking about "deflink" isn't.


> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -2285,7 +2285,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 =
*mac,
>  	}
> =20
>  	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
> -		ieee80211_csa_finish(vif);
> +		ieee80211_csa_finish(vif, link_id);

Might make sense to keep the actual logic changes out of this patch?
It's pretty big, and this is pretty hidden...

> +++ b/net/mac80211/cfg.c
> @@ -1588,6 +1588,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, s=
truct net_device *dev,
>  		link->csa_block_tx =3D false;
>  	}
> =20
> +	wiphy_work_cancel(wiphy, &link->csa_finalize_work);

You don't _really_ need that here (if it runs, it'll just find
csa_active=3D=3Dfalse), and I'd feel better about it if we actually had thi=
s
in ieee80211_link_stop() in some way, that's called from
ieee80211_tear_down_links() and then it's really obvious to see that
this is removed before freeing the link.

> -	if (sdata->vif.bss_conf.eht_puncturing !=3D sdata->vif.bss_conf.csa_pun=
ct_bitmap) {
> -		sdata->vif.bss_conf.eht_puncturing =3D
> -					sdata->vif.bss_conf.csa_punct_bitmap;
> +	if (link_conf->eht_puncturing !=3D link_conf->csa_punct_bitmap) {
> +		link_conf->eht_puncturing =3D link_conf->csa_punct_bitmap;
>  		changed |=3D BSS_CHANGED_EHT_PUNCTURING;
>  	}

Hm. I'm going to send some patches soon that remove the puncturing stuff
and move it into the chandef (as we discussed elsewhere), but just
noting that - doesn't need to concern you here, I think.

> @@ -3875,16 +3894,23 @@ __ieee80211_channel_switch(struct wiphy *wiphy, s=
truct net_device *dev,
>  	if (sdata->wdev.cac_started)
>  		return -EBUSY;
> =20
> -	if (cfg80211_chandef_identical(&params->chandef,
> -				       &sdata->vif.bss_conf.chandef))
> +	if (WARN_ON(link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS))
> +		return -EINVAL;
> +
> +	link_data =3D wiphy_dereference(wiphy, sdata->link[link_id]);
> +	if (!link_data)
> +		return -ENOLINK;
> +
> +	link_conf =3D link_data->conf;
> +
> +	if (cfg80211_chandef_identical(&params->chandef, &link_conf->chandef))
>  		return -EINVAL;

Also another thing unrelated to your patch - I'm thinking about removing
that identical() check entirely - you might want to switch to the same
channel with quiet=3D1. At least for testing that'd be really useful, and
I don't think it really serves any purpose to forbid it.

johannes

