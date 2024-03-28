Return-Path: <linux-wireless+bounces-5487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3189082B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBB7B21063
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4681AAA;
	Thu, 28 Mar 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LdiqOYTU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A212C18F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650201; cv=none; b=Wx6qn/tXZ7jpWXJvxuDXoleD+BN7RvxL4yG7Fa/ncXEqvFkXz6t0EmvOPK4cdcr0qR3PzPWp4riefxSiIEOp6KxDnC9ZD3xT+yCkstneJPLHXeazBpvQkL6TuuB3VqyCCNHlI1Ya6sCqOm7RK6Gi681vc+aRO7phJ0eN6tYs7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650201; c=relaxed/simple;
	bh=QSgmME2J6uhuRZWBQdVwMkKxTAsAIa4zM5ULoJLck0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHLQn0cVLCCiyQEaW+e51T/deykNij/IZrk4XAWjLG39dCFYja8ZU9pD0m+30SVQdnw1xgZVrm8jdlXMg94VVVKe75uXYWUCY/8tm9Vrgu3zaoxkU0oeHPlHIRqTU0nvIAWG7I2/VuAeXWmUZcV4mshqrSmebX71vvazl3O3gyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LdiqOYTU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gX5i6kQcc4wcaG2Vb+4D3mmuB9agF0nM5XqRS2bTYrw=;
	t=1711650199; x=1712859799; b=LdiqOYTUrfY+6ttO/1SP28LGpA2eepBZ3MIljp/yRn500Yl
	m90FMZUqheiNbBhLbFWQ53rJxjMNN+HGufk0BcVyAJRFy6dwlYCVj32R1+WFHC4rx4otMtkBfdlHY
	2SKk3wSqMpbD2YyApPFwsSK+ijmTSgA3rTlqmyeAfLC8Kb9kjUI3byGxjMnFygWf+CZb7bRpArd2i
	G2yY40kXI2HweYKXTvEZUlycZY0CLt2QOkE7XGDOg7D1sfib9zIOgvoj6+YGGtRmJhhEdSw+MuFJr
	7RGgMviVCoATo0Iw0GMrMq4n0Fo8ALUDSDURvYi/mtUn8KWcC6M9iC1X6xJtCZUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpuPE-00000001DeD-155z;
	Thu, 28 Mar 2024 19:23:16 +0100
Message-ID: <3f77e4e0455fbfdec7e14777cf116175eae32f49.camel@sipsolutions.net>
Subject: Re: [RFC 2/2] wifi: mac80211: Add support for link reconfigure
 removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 28 Mar 2024 19:23:14 +0100
In-Reply-To: <20240328055235.3034174-3-quic_mdharane@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
	 <20240328055235.3034174-3-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 11:22 +0530, Manish Dharanenthiran wrote:
>=20
> +int __ieee80211_link_reconfig_remove(struct ieee80211_local *local,
> +				     struct ieee80211_sub_if_data *sdata,
> +				     const struct cfg80211_link_reconfig_removal_params *params)
> +{
> +	struct ieee80211_link_data *link;
> +	int ret;
> +
> +	if (!ieee80211_sdata_running(sdata))
> +		return -ENETDOWN;
> +
> +	if (sdata->vif.type !=3D NL80211_IFTYPE_AP)
> +		return -EINVAL;
> +
> +	link =3D sdata_dereference(sdata->link[params->link_id], sdata);
> +	if (!link)
> +		return -ENOLINK;
> +
> +	ret =3D drv_link_reconfig_remove(local, sdata, params);
> +
> +	return ret;

Again ... remove the 'ret' variable, it serves no purpose at all.

> +}
> +
> +int ieee80211_update_link_reconfig_remove_status(struct ieee80211_vif *v=
if,
> +						 unsigned int link_id,
> +						 u8 tbtt_count, u64 tsf,
> +						 enum ieee80211_link_reconfig_remove_state status)
> +{
> +	struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
> +
> +	if (vif->type !=3D NL80211_IFTYPE_AP) {
> +		sdata_err(sdata, "Discarding link reconfig status for unsupported vif =
type\n");

Uh, no. Remove that message please.

> +TRACE_EVENT(drv_link_reconfig_remove,
> +	    TP_PROTO(struct ieee80211_local *local,
> +		     struct ieee80211_sub_if_data *sdata,
> +		     const struct cfg80211_link_reconfig_removal_params *params),
> +
> +	TP_ARGS(local, sdata, params),
> +
> +	TP_STRUCT__entry(LOCAL_ENTRY
> +			 VIF_ENTRY
> +			 __field(u32, link_id)
> +			 __field(u16, count)
> +			 __dynamic_array(u8, frame, params->ie_len)
> +	),

All the same things about indentation apply here.

johannes

