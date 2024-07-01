Return-Path: <linux-wireless+bounces-9766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F0A91DEB7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 14:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E61228305E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC284D02;
	Mon,  1 Jul 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YrMCdazq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3071494DA
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835493; cv=none; b=N2LZXjIh+KMw61ecyk65Q/RQP1lKEZop//Um/HRDihqzjyDby24ppcO83rJTwFB9mfvC0Dr4+46+L3MEMuxt4uiaDwrvOxOp/YxObxwrHMPaHnn+w4rXVbbTfUJ0w7YxAcITOX26FDQBDdDNtX4vEkrdhMb4f+gI8RsD009yP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835493; c=relaxed/simple;
	bh=MZ2xMHTHUvXjsaTB/ceZwLcBtpRY4UXLugj+3VCaJYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKFD6h8Ucp1H1BdfBC4H8J0dSyCCjIXBsetOfYxL1D67Bais5srPBrPd7saPHQevKv89rOlbVSMpXDr4MV6vQqL2HvnvqyOJAfjj1KMre3+AQcuWe15UCyBHf3QUPQlYVvUyBVUJJ2bP7pUCJnFiA3sbvllsYABpxa1affJX/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YrMCdazq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UJILTiXHMWzTg3uHaRJKYQCdP/JUg7GP7I9ysmxqugI=;
	t=1719835486; x=1721045086; b=YrMCdazqVsWCLXOupOkzYB1kImUeZGJv0QU9N78q1ofVLnf
	kW93p3/nkfIrAIGu9w0xjzCoUVtxKlTZiAW9kSRAiei5kx4qHkcSP+9T+U9uKmC4h9i8PdG+3yIoC
	jt6pDDj+RsBORlqhosT+z/jm8i5KSY3eeRwlyuY9pjPHIVgRXW2r7wdq35RyKz7yi+GWD87J9Zf9p
	yDg9VqixQIplalyGkkYo11eDLq++9NdtqrfOzlVU777ahvuUK42QJ1c6fcVuOhlHm48ThXTUs4UJr
	+5q4Opyg0mGkIpWSRjeJw5V7aVZ3zNn/ozEmMF+YxnmKO0uarH+gkqng26b/R05g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOFlz-000000025y8-0AgX;
	Mon, 01 Jul 2024 14:04:43 +0200
Message-ID: <73665af6175acf9f264c076824b65d2b24476cde.camel@sipsolutions.net>
Subject: Re: [PATCH v2 02/10] wifi: cfg80211: add support for advertising
 multiple radios belonging to a wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Mon, 01 Jul 2024 14:04:42 +0200
In-Reply-To: <52f91e3121547ec50a9ea1fa1b7f395a96da52df.1719733819.git-series.nbd@nbd.name>
References: 
	<cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
	 <52f91e3121547ec50a9ea1fa1b7f395a96da52df.1719733819.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Oops, forgot one thing already:


> +static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, i=
nt idx)
> +{

...

> +		const struct wiphy_radio_freq_range *range =3D &r->freq_range[i];
> +		int ret;
> +
> +		freq =3D nla_nest_start(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE);

need to check freq

> +		ret =3D nla_put_u32(msg, NL80211_WIPHY_RADIO_FREQ_ATTR_START,
> +				  range->start_freq) ||
> +		      nla_put_u32(msg, NL80211_WIPHY_RADIO_FREQ_ATTR_END,
> +				  range->end_freq);
> +		nla_nest_end(msg, freq);
> +
> +		if (ret)
> +			goto nla_put_failure;

and this 'ret' business is pointless? You can just 'goto
nla_put_failure' even in the middle of the nested, it will be unwound
properly on a higher level.

johannes


