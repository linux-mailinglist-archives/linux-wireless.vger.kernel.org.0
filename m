Return-Path: <linux-wireless+bounces-27512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5086B88A4E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 11:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AE17BF281
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD472634;
	Fri, 19 Sep 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G+TSvjnQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A01990C7
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275263; cv=none; b=BvBm+8DS5HNKPXo3JYypEuqzUI4islhSeVPvdnhVLPJxjM80+BSstW3HMiZ1tPwIpTq+TmRu710PvtopJzN2W2y5v2lVNcqiUApGJIDIP98vrdIzjd4+wuhE08UAfOlbO2aZSOvdGht1O0TL6MIcBScXj5kkWZUj0JMxGbid5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275263; c=relaxed/simple;
	bh=yS22sKIRC3bUMzs1vDUfuyYBG/4h0Gs2CRz770Kxjz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1GrcgSIsqK8WUKIPCyi1Z/xKcjH05Udtgfb5N7C/252H9m45M0YO1tUWPtPnRqBnVbZnIiA/vWmgDgsC3ZgCM8pm097lPq+cFFDnOHQL4W2MVfm+5PU130SPGKj53hyZVMAIyisCi3jXoTeTLFTkcINyhnrEdyWpFZA2Lg0jiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G+TSvjnQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wpmsJcN8QwExAlG8lju3X7G8E7NzD3/EGs3OG5j3vkk=;
	t=1758275261; x=1759484861; b=G+TSvjnQOs9ccUZnTrPdxidyaYddCbeirGl120k0SKQF4Mw
	HQ/pnjAxVZP3PMdbhQFbrKvPnU9QQDfp6/14apzF4KVdOZEw0+F6G7jUMZ+1Lp/PLn8mWpADN7g+K
	wiaJfhet1OTJHqdZh9IPYV5OzVDUpwdxC0kkgRVGApn+zwSsonSWs9uCqaylL2Q9Hi3P4KUcc18pS
	51tLSsY0sHS03R4bqMccWkX4RvtMyVtWFOAv3y/uL0vKT+1ZmRQ6wE3sqzQe95oFq3tdkRICSoEwx
	YlTSQ4WlvmV58DqM6Ud+JIX6H7kCMPD+mFA1iwcpol0/DlsNnVM2VYkYIiqUsTgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzXiL-0000000FeNO-3T5Z;
	Fri, 19 Sep 2025 11:47:38 +0200
Message-ID: <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>,  Aditya Kumar Singh
 <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 11:47:36 +0200
In-Reply-To: <20250912032105.714949-3-quic_amitajit@quicinc.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
	 <20250912032105.714949-3-quic_amitajit@quicinc.com>
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

On Fri, 2025-09-12 at 08:51 +0530, Amith A wrote:
>=20
> =20
> +void ieee80211_incumbent_signal_detected_work(struct wiphy *wiphy,
> +					      struct wiphy_work *work)
> +{
> +	struct ieee80211_local *local =3D
> +		container_of(work, struct ieee80211_local,
> +			     incumbent_signal_detected_work);
> +	struct ieee80211_chanctx_conf *conf;
> +	struct ieee80211_chanctx *ctx;
> +
> +	lockdep_assert_wiphy(local->hw.wiphy);
> +
> +	list_for_each_entry(ctx, &local->chanctx_list, list) {
> +		if (ctx->replace_state =3D=3D IEEE80211_CHANCTX_REPLACES_OTHER)
> +			continue;
> +
> +		if (!ctx->conf.incumbt_sig_intf_bmap)
> +			continue;
> +
> +		conf =3D &ctx->conf;
> +		cfg80211_incumbent_signal_detect_event(local->hw.wiphy,
> +						       &conf->def,
> +						       conf->incumbt_sig_intf_bmap,
> +						       GFP_KERNEL);
> +	}
> +}
> +
>  void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
>  				       struct wiphy_work *work)
>  {
> @@ -3592,6 +3618,19 @@ void ieee80211_radar_detected(struct ieee80211_hw =
*hw,
>  }
>  EXPORT_SYMBOL(ieee80211_radar_detected);
> =20
> +void ieee80211_incumbent_signal_detected(struct ieee80211_hw *hw,
> +					 struct ieee80211_chanctx_conf *chanctx_conf,
> +					 u32 incumbt_sig_intf_bmap)
> +{
> +	struct ieee80211_local *local =3D hw_to_local(hw);
> +
> +	chanctx_conf->incumbt_sig_intf_bmap =3D incumbt_sig_intf_bmap;
> +
> +	trace_api_incumbent_signal_detected(local, chanctx_conf);
> +	wiphy_work_queue(hw->wiphy, &local->incumbent_signal_detected_work);
> +}
> +EXPORT_SYMBOL(ieee80211_incumbent_signal_detected);

I don't understand why you need the massive complexity here to jump
through the workqueue, if you have everything right here in hand to call
the cfg80211 API?

And if I'm missing why it's needed and it indeed _is_ needed, then you
don't need the gfp argument for the cfg80211 API, at least at this point
(until some other driver shows up using it) but as I said, why?

johannes

