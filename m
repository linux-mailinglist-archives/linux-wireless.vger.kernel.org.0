Return-Path: <linux-wireless+bounces-14449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420549ADD06
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 09:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F321F2138F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 07:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320E18A6A8;
	Thu, 24 Oct 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VCcMAuk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E2189F55
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753492; cv=none; b=YnZlEkq4CH/Eplvvx8pZmIPQyyBb/oFU49sjf3wxHgC4GytjtC94g01hqoi8mp738nAzRG2XhVJHwgbPaFxEOKFQnri5I446jwczSaGlGDNR3AyWtcEp2Qi2u5ve03YaxWBffs1fvdCnoYakH1LCGE1R+T8pZnfKwA9UNj/5d7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753492; c=relaxed/simple;
	bh=DwaWByNhRaydZed67t37HG/y4mA5xgRBc177Dx3GKpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnAiuuoytQGBTg+Sg7E0afv8YLfnywflh1psKL4SFLWlhoSPc8nTxKmZV7DcWbVs2fSvupsZyD8LS6i/MZ4YUJ/ql37/zsHJe70iUsWGNsdd/Hqkyi6NAD5Q/5UIPF6U/r/ShgsFay/cQ6PCZDcI41lF2qFnLYYg0U6W5hagrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VCcMAuk9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rk4wVIwey0Ggy8MlSIaJ76rlL6drCE/idaKrX4SIiIw=;
	t=1729753490; x=1730963090; b=VCcMAuk9uVZB5LErVsBGZGwPBQmn/JgIELArENZJGCoWPFj
	tO1mzTAcJl4z7ofHtcwp7M7XgQfpbRf+nenwWHK0XztXGk/tYMD113WNW0h/Nx3Cr3AndVJFH822h
	Fj82Pd+oEf6jRoC9wdVrzY93zeC43dPCzCPxg//ELkUMCoeKxR/KqR5WreWaOlhsPPiqwRNLiBOpL
	Qi2NMiUqhXeXI8Ke0xzK1dODGBKJJjFO3mgR5uQzLJt2YXGVZr5XKR+8JK3kNikgeeeKoxgFDu/i2
	wL4YWDqQJXIRHEpSIuSY8wAv8fMDqcB2sSkzWCZw9/noNu5a95PBBvUskbHVyGlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3rtm-00000003VJr-2xUJ;
	Thu, 24 Oct 2024 09:04:46 +0200
Message-ID: <a8dbb6cdbe4bd308a00a89597cb056073219f1be.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Add ADDBA Extension element parsing
 logics
From: Johannes Berg <johannes@sipsolutions.net>
To: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai
 <evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>, 
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Peter
 Chiu <chui-hao.chiu@mediatek.com>
Date: Thu, 24 Oct 2024 09:04:45 +0200
In-Reply-To: <20241024022105.6810-1-MeiChia.Chiu@mediatek.com>
References: <20241024022105.6810-1-MeiChia.Chiu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-10-24 at 10:21 +0800, MeiChia Chiu wrote:
> Add ADDBA Extension element parsing logics in ADDBA request/response
>=20
> To support BA size of 1024,
> the ADDBA Extension element is needed in ADDBA request/response.
> Therefore, parsing logics is added for this missing piece.

Ah yes, we had this only for the RX side, I guess.

> +++ b/net/mac80211/agg-tx.c
> @@ -66,10 +66,12 @@ static void ieee80211_send_addba_request(struct ieee8=
0211_sub_if_data *sdata,
>  	struct ieee80211_local *local =3D sdata->local;
>  	struct sk_buff *skb;
>  	struct ieee80211_mgmt *mgmt;
> +	struct ieee80211_addba_ext_ie *addba_ext;
> +	u8 ext_size =3D agg_size >=3D 1024 ? 2 + sizeof(*addba_ext) : 0;
> +	u8 *pos;
>  	u16 capab;
> =20
> -	skb =3D dev_alloc_skb(sizeof(*mgmt) + local->hw.extra_tx_headroom);
> -
> +	skb =3D dev_alloc_skb(sizeof(*mgmt) + local->hw.extra_tx_headroom + ext=
_size);

probably much simpler to just make that unconditional?
Like in ieee80211_send_addba_resp().

> +	if (agg_size >=3D 1024) {
> +		pos =3D skb_put_zero(skb, ext_size);
> +		*pos++ =3D WLAN_EID_ADDBA_EXT;
> +		*pos++ =3D sizeof(struct ieee80211_addba_ext_ie);
> +		addba_ext =3D (struct ieee80211_addba_ext_ie *)pos;
> +		addba_ext->data =3D u8_encode_bits(agg_size >> IEEE80211_ADDBA_EXT_BUF=
_SIZE_SHIFT,
> +						 IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
> +	}

Maybe we can reuse ieee80211_add_addbaext()?

Also you only described "parsing" in the commit message, so this isn't
really part of it ;-) Please complete the commit message.

> @@ -460,8 +471,11 @@ static void ieee80211_send_addba_with_timeout(struct=
 sta_info *sta,
>  	sta->ampdu_mlme.addba_req_num[tid]++;
>  	spin_unlock_bh(&sta->lock);
> =20
> -	if (sta->sta.deflink.he_cap.has_he) {
> +	if (sta->sta.deflink.eht_cap.has_eht) {
>  		buf_size =3D local->hw.max_tx_aggregation_subframes;
> +	} else if (sta->sta.deflink.he_cap.has_he) {
> +		buf_size =3D min_t(u16, local->hw.max_tx_aggregation_subframes,
> +				 IEEE80211_MAX_AMPDU_BUF_HE);
>  	} else {

That's related, but not precisely part of what you describe in the
commit message. Just make the commit message more general, I guess, such
as "support EHT 1024 aggregation size in TX" or so?

> @@ -970,6 +986,25 @@ void ieee80211_process_addba_resp(struct ieee80211_l=
ocal *local,
>  	amsdu =3D capab & IEEE80211_ADDBA_PARAM_AMSDU_MASK;
>  	tid =3D u16_get_bits(capab, IEEE80211_ADDBA_PARAM_TID_MASK);
>  	buf_size =3D u16_get_bits(capab, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
> +	ext_elem_len =3D len - offsetof(struct ieee80211_mgmt,
> +				      u.action.u.addba_resp.variable);
> +
> +	if (ext_elem_len) {
> +		elems =3D ieee802_11_parse_elems(mgmt->u.action.u.addba_resp.variable,
> +					       ext_elem_len, true, NULL);
> +
> +		if (elems && !elems->parse_error) {
> +			if (sta->sta.deflink.eht_cap.has_eht && elems->addba_ext_ie) {
> +				u8 buf_size_1k =3D u8_get_bits(elems->addba_ext_ie->data,
> +							     IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
> +				buf_size |=3D
> +					((u16)buf_size_1k) << IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT;
> +			}
> +		}
> +
> +		kfree(elems);
> +	}

This is all also very similar to ieee80211_process_addba_request(), so
again perhaps it could be reused - would have to pass 'ext_elem_len' and
the buffer to a function.

johannes

