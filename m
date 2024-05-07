Return-Path: <linux-wireless+bounces-7273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0538BDBE1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 08:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE21C21591
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1178C74;
	Tue,  7 May 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qNrME2Il"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851078C7D
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064624; cv=none; b=TuveYDqdG33um8X+64JNk2T2VN7AxJsnIywh6Ex618KN5wAKtvkDoIbcfuQMeDqUYV/OLUgGRy8+7iKSC1pZVwH7eV5P6xOzBvZ315Wh3AWm46Cz45MFLVbeTxp0TC7xPUiE6/tB/JZxEVJMQRnZEV+E7U/19WBXg7Ko/B8kBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064624; c=relaxed/simple;
	bh=hiVXl6Zs3I+gKART1Qcd9Ia52CNU9XstUN8S7Eq9yDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbwKs1xzqt7+8bfV0DHB8DW09+fHS4IoeOuudUvWXzvg10bjNF6ym15zcLXoB0hhH2BsZDGt+vWchcRvb/+cw3ky+kkU8vpa07UbtdpvA+z6exf4CiqFmwuUZTXZ3GO9+kTNEizl1SlJvnU6b+ffCJJKbOd5FYx2ExgKk46ogjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qNrME2Il; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CzGqrqDqoQw5XhAIiEmjuj+fWKN7rSWhsH+wcgZOK9s=;
	t=1715064607; x=1716274207; b=qNrME2IlKQmh+YSFROlbC8YGR6Mx3Pz6eBmQiw81UeRPq8U
	Z4SuQJJmeY/T04CZ2EBpinK2X2dE2G8CoDcpZqpK+mdzs4g16KJonhvIfn2NPa8PmjEjXGB6qmrXP
	bKTDav4kNeEJKLFW5He4OKauYtnv0QPxBnJ6yMUFPWFphiZRGM98oPWVoMc5Y0ZvO/hX8bhBYb5pu
	E9RjXdf5qVdqhnI5R2RoIs7bjt3cd38xgpAq4WliIpyFL7nZtprbVgY+pRfhew9oAxG2yai3PLWb5
	nCdb77X9JlplAFezpJf6O9LJba79gXLB0oRIEv07iLAm+q3AAVvysIj/EuOI9Gzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s4EeI-00000009L9R-27FK;
	Tue, 07 May 2024 08:50:02 +0200
Message-ID: <b84e761a1e3e1d1bb31802926be8717bf015f9c5.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211: VLAN unicast packets take 8023 xmit
 path
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Gautham Kumar Senthilkumaran
	 <quic_gauthamk@quicinc.com>
Date: Tue, 07 May 2024 08:50:01 +0200
In-Reply-To: <20240506212014.670423-3-quic_msinada@quicinc.com>
References: <20240506212014.670423-1-quic_msinada@quicinc.com>
	 <20240506212014.670423-3-quic_msinada@quicinc.com>
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

On Mon, 2024-05-06 at 14:20 -0700, Muna Sinada wrote:
>=20
> +	if (sta && sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN) {
> +		ap_sdata =3D container_of(sdata->bss,
> +					struct ieee80211_sub_if_data, u.ap);
> +		if (ap_sdata->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED &&
> +		    !is_multicast_ether_addr(skb->data)) {
> +			key =3D rcu_dereference(sta->ptk[sta->ptk_idx]);

Why is that line there, and why is it necessary? Is it even correct?

I see you need a key pointer on the next line, but still... that doesn't
seem right.

johannes


