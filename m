Return-Path: <linux-wireless+bounces-248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2437FFA72
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CD1C20FCF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3F39AE5;
	Thu, 30 Nov 2023 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="glQyclz3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA5B9
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1mZwmuNrX1XZCTolturnka409we6fnCrGdbywyYe9/A=;
	t=1701370489; x=1702580089; b=glQyclz36MwCxOiESQjIq+Dw7Nrax0HZW7/IsRAcxXjJ5r5
	Hv2Ot84qwZhsqtQ1aQ1d9uRUR/cWpsHqGUSg/O0KwaJwI31Lv6J/zu9fGBUmVX3NhX9aMMdNW/q/n
	lodtEIh5g8q9YiLgofSo0NXG8sYGAlIQCnwrlnCgl6aduJQi1xSshe8ojx4Ggfr6oolmIWhigGMK0
	yIu/HCoN9R7WUbtOj9gyJbkEYWrcojS+CuiBkXRBLidxA1z11fi0z9jFs/rn79Y/jE7KfzqaJ0Hxo
	1RPpVW7C20pCeLDpEmAzoMGUL/bqmFtSalG8CbYBzJWQUEeJhGRHDkRxMaO7f62Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8mBP-0000000A9Pi-0vNM;
	Thu, 30 Nov 2023 19:54:43 +0100
Message-ID: <1cddf5467c79c0d3ab1e9ba67266d302f63b3fa4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Walle
 <mwalle@kernel.org>,  lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-wireless@vger.kernel.org,  Max Schulze <max.schulze@online.de>
Date: Thu, 30 Nov 2023 19:54:41 +0100
In-Reply-To: <202311301050.C4BFFB9837@keescook>
References: <202311090752.hWcJWAHL-lkp@intel.com>
	 <202311090752.hWcJWAHL-lkp@intel.com>
	 <1c37d99f722f891a50c540853e54d4e36bdf0157.camel@sipsolutions.net>
	 <fc1dbe4a-a810-445c-9398-60a5e55990a2@quicinc.com>
	 <202311301016.84D0010@keescook>
	 <01e3663e9e1418a183ee86251e0352256494ee28.camel@sipsolutions.net>
	 <202311301050.C4BFFB9837@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-30 at 10:52 -0800, Kees Cook wrote:
>=20
> I was able to see it with Ubuntu's GCC 12.3.0 and their config. This
> fixed it for me:

OK. I guess kernel tree also mattered somehow, and I got confused
because I'd applied the patch on wireless, where the robot did it on
wireless-next. Not sure how that's different, but OK.


> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index d0f499227c29..7735d178a393 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -12845,7 +12845,7 @@ static int cfg80211_cqm_rssi_update(struct cfg802=
11_registered_device *rdev,
>  }
> =20
>  static int nl80211_set_cqm_rssi(struct genl_info *info,
> -				const s32 *thresholds, int n_thresholds,
> +				const s32 *thresholds, u32 n_thresholds,
>  				u32 hysteresis)
>  {
>  	struct cfg80211_registered_device *rdev =3D info->user_ptr[0];
> @@ -12948,7 +12948,7 @@ static int nl80211_set_cqm(struct sk_buff *skb, s=
truct genl_info *info)
>  	    attrs[NL80211_ATTR_CQM_RSSI_HYST]) {
>  		const s32 *thresholds =3D
>  			nla_data(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
> -		int len =3D nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
> +		u32 len =3D nla_len(attrs[NL80211_ATTR_CQM_RSSI_THOLD]);
>  		u32 hysteresis =3D nla_get_u32(attrs[NL80211_ATTR_CQM_RSSI_HYST]);
> =20
>  		if (len % 4)
>=20
>=20
> If that's sensible, I can send a proper patch?

Sure, that seems reasonable.

> (Oh, it looks like nla_len is actually u16 ... should I use that instead
> of u32?)

Yeah it's a 16-bit field in the message format. Doesn't really matter?

johannes

