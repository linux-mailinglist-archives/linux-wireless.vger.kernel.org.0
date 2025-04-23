Return-Path: <linux-wireless+bounces-21925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36323A99361
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2B21BA2ADB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12529B774;
	Wed, 23 Apr 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ya1aihqx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAE2957DA;
	Wed, 23 Apr 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422010; cv=none; b=AH2KQ41XIp6CF4dBOhgZ1/PC8XVeTxBJsIfIjNZa5WD98ihtlaWiK6331pzlBqLXjYTlXzxkAqYnA0Pqi48QmGbq2lE4LIvX59AMaxx9Yzt8lGTl3Du+82qRaX3sUip934obrwXfcyUan+fSKc7w7yccrT9pnUHhT7anPprDEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422010; c=relaxed/simple;
	bh=+kPnZjhBBB1Rt9Nq0FKcQiPKW0BdYWzvUk4a9LrGmAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mmQgf4q5zT2oso9Z+LvcOhci0EmO6eWplzWC4BqYD+L3d+dBDCLyX/ISrPMD4KAfyr3rySQ5ZVoJRFpCS9bhcBzDiohs35nK5NEndm0XOir9sn+XoGgNQFgWrA7Pt6b8Wp+y++fMx/hhhv1QZBlrA+CHZLMOnEerud45JKvbYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ya1aihqx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6NAKdQJVuUOHz5Vip7qDSn/LDlbtFntB9GC/kqf4AAc=;
	t=1745422009; x=1746631609; b=ya1aihqxTx3n24Vrax7S0kwBCc03zjb4rCBJxQXm4JBDb/2
	1Eg28VBaN2BLcmlJoeFiPxB2+uruCo60wiUbZk+mPPxgcW4x2xab2PCchENduEMsmeq4hggnR056T
	qPtvx+ziSMuq6l98kHd59fWjM4OmGlrP2o5XPAOGoO8YPmLMaxAq4Wf2r9ByvnEjpE1PusgYVh7kN
	JLeMtq+XbOarwQRSxsUF7NNBHqFEyRWjoyRrt/fmzIW4lt7FvxidQtEeK/5CIXXhhnO9TxKN47+uq
	B8843QXKnanky5TRtTQUe59kWlzioBL7Gtbs2qCJuKL0IUzgw/Bpz+gi32JhHKnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7bzo-0000000En4C-3POE;
	Wed, 23 Apr 2025 17:26:44 +0200
Message-ID: <4ed3cfbc1a5b80bb3577f73b8c2b19ce830eeff5.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Prevent disconnect reports when no
 AP is associated
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com
Date: Wed, 23 Apr 2025 17:26:44 +0200
In-Reply-To: <20250314120614.4032434-1-quic_zhonhan@quicinc.com>
References: <20250314120614.4032434-1-quic_zhonhan@quicinc.com>
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

On Fri, 2025-03-14 at 20:06 +0800, Zhongqiu Han wrote:
>=20
> +++ b/net/mac80211/mlme.c
> @@ -4433,6 +4433,10 @@ static void ieee80211_report_disconnect(struct iee=
e80211_sub_if_data *sdata,
>  		.u.mlme.data =3D tx ? DEAUTH_TX_EVENT : DEAUTH_RX_EVENT,
>  		.u.mlme.reason =3D reason,
>  	};
> +	struct sta_info *ap_sta =3D sta_info_get(sdata, sdata->vif.cfg.ap_addr)=
;
> +
> +	if (WARN_ON(!ap_sta))
> +		return;

You're adding a WARN_ON() that's now guaranteed to trigger, no?
Shouldn't the caller (also) be fixed?

> @@ -8090,7 +8094,7 @@ static void ieee80211_sta_timer(struct timer_list *=
t)
>  void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
>  				   u8 reason, bool tx)
>  {
> -	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
> +	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] =3D {0};
>=20

And that's not needed then? And perhaps should be {} if it is.

johannes

