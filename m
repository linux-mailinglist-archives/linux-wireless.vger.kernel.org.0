Return-Path: <linux-wireless+bounces-20153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BF8A5BDA7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C255A3AA65E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F23230BF3;
	Tue, 11 Mar 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tlFlCdfT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204C233725
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688429; cv=none; b=N6snJTVTNWDw08ntiHo6PeyeUxOHGsXfXKvgqVr5qJAB4aAdmzFxQurb8vyYi4sfrzvZFttKIHqlIKgKdhSZYyNyQp84Ckn3lPL3/TNjb5hP6fO8XkbcwD52QdpdxLMQdxdIPrI/QuTR0qB1rqQkayHD81q42uGBpeCIDy+Gw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688429; c=relaxed/simple;
	bh=XbqcDnyf2HNvuHhkinyP/laFl2H+DxYFR0NJcVlXYQw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=ocKcI9D7lrh/Ii9S/4KrrtbZ5Ov4HHSsdGA9HeYl2h0VFvTctiwRePscD3oJceoPZTvTznGFr0105YNpTYHrAvPT2hxmdNOfX+TKUFm9M8uVFYXERdfhDwfIP2jN9L+vaSU8LBaHRPAwQuFi8e2fBTqCGWT4MrUam7Qrq3SRsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tlFlCdfT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Date:MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Cc:To:From:Subject:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ak/6gHLFtxLiBPZaYRNIFIndlh/sye4y350MTKklSIA=;
	t=1741688427; x=1742898027; b=tlFlCdfTN7adGJCsY8HUrW54tE4u/ePYjo93b5fJBoe2x5q
	Ib8WRBeE8PkWnWo+iiXQ6MbLT+G6AoV/dh26m5mzJuQe0YZln8USaxyOiBKclfgHosEnP1Ubqo+hZ
	4DRM8hN9lqQhdxcQN2o7BMTyOIVrTinY7V4cWg+1Y4w6f91F6IbOaAr+dV1390IOkPt3m7xqqydEI
	RPRDAF2q8yfa3mA5nMgUkOB0Pxbjx1/JkONv0ZBOO18xzeVjaupSGLcin4ibfpj1Xny4AZdp4cSoZ
	0dG2kilcIeD351fOmKSgxZIyO9ZJrZCktAQZqd6/9LJA95FvIwWVrhSiGk0WGLrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trwil-00000007nF5-3kmC;
	Tue, 11 Mar 2025 11:20:24 +0100
Message-ID: <7cdc6950ba188625d691e8fd4726ef6872f6afa1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 1/4] wifi: cfg80211: Add support to
 get EMLSR capabilities of non-AP MLD
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, Ramasamy
 Kaliappan <quic_rkaliapp@quicinc.com>
In-Reply-To: <20250306062157.1185769-2-quic_ramess@quicinc.com>
References: <20250306062157.1185769-1-quic_ramess@quicinc.com>
	 <20250306062157.1185769-2-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Mar 2025 10:48:04 +0100
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-malware-bazaar: not-scanned

> =20
> @@ -7095,7 +7096,8 @@ int cfg80211_check_station_change(struct wiphy *wip=
hy,
>  		if (params->ext_capab || params->link_sta_params.ht_capa ||
>  		    params->link_sta_params.vht_capa ||
>  		    params->link_sta_params.he_capa ||
> -		    params->link_sta_params.eht_capa)
> +		    params->link_sta_params.eht_capa ||
> +		    params->eml_cap_present)
>  			return -EINVAL;
>  		if (params->sta_flags_mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
>  			return -EINVAL;
>=20

EMLSR doesn't make sense for TDLS stations either, does it?

johannes

