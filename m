Return-Path: <linux-wireless+bounces-12376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6996998D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 11:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2120B23E40
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667531865FA;
	Tue,  3 Sep 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NuwLQKZG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18019F42D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357255; cv=none; b=lpja4FzGGg2SXgMXFVUJFKE35kdkBLs5080klrWqdWsPvtLrPNuEKt0szto3kkHkarpoDv3WKv+Om1HlGjO46AhzK25CP7gfllBFl0kZpSu/Kh3TWcSjI5AynsyBeE2xLMDVUERr0Ui7pVNzluZnSj11UVt8Pzq+KhOSuWdz6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357255; c=relaxed/simple;
	bh=xgpjhaAhFPk4A3AIV+a/7iPwolrf1B04b7oKlb2iDRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FyO5xSCftdyJJZOphr2ymkCIn3Swz7SlE7EM9u+bJxlo4rY1DaaGU4N0AxrAZSqJlO6Wlk54IliPy3OebU2zKFaSjFFiY+2HHYY62gjq43R4BFDWrcZg6/uzKPHuGZaEgTzyJhpIGC2joLE4q+kdnQBIh2LDYQRfFHMs+ZsBVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NuwLQKZG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kfbNMu4qzEGnRP1FtA/ifbNQtdpnxCg+iWqeb8rLTUM=;
	t=1725357253; x=1726566853; b=NuwLQKZGBXWYGj/PnmDNKx/DQQGEJWiU+zA+BriHzEMGCCl
	zAuBzIi7mlgQKWuyiZH79IMcA7OBdFlD4HLfUy/hXKh5fjmDn6Nzy/ZhRHVekTzvpFPcQng4BZrDi
	pUatnLyUs2B9VTIhF+lP1cF2ppR+4B3afE2vgM1FP8f1GGTXPjOsAtQMQcyX2RlOhF4ihH9y/eoGo
	2nXb13+yOZ1T7DpAmSCsf2kV36cQ9mGNxLIJrhg+prjgbxNCEiJvYs5HVWUgoMdgOPBlaq0rV8+MP
	MmZcP1w2T8iMhgrgiO1ATJe9Apsq2eBPENeJc3sIMQ+ei0Izz4A6+MioapU35tpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slQEc-00000002BQ8-3nPF;
	Tue, 03 Sep 2024 11:54:03 +0200
Message-ID: <d7d8b63a1c13fb3770a521155b10b964dfa6b74a.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: introduce EHT rate support in AQL
 airtime
From: Johannes Berg <johannes@sipsolutions.net>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, jonas.gorski@gmail.com, 
	nbd@nbd.name, lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, 
 Leon.Yen@mediatek.com, Michael.Lo@mediatek.com, Eric-SY.Chang@mediatek.com,
  km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com, 
 posh.sun@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
 Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>
Date: Tue, 03 Sep 2024 11:54:01 +0200
In-Reply-To: <20240902054428.13273-1-mingyen.hsieh@mediatek.com>
References: <20240902054428.13273-1-mingyen.hsieh@mediatek.com>
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

On Mon, 2024-09-02 at 13:44 +0800, Mingyen Hsieh wrote:
>=20
> +	EHT_GROUP(1, EHT_GI_08, BW_20),
> +	EHT_GROUP(2, EHT_GI_08, BW_20),
> +	EHT_GROUP(3, EHT_GI_08, BW_20),
> +	EHT_GROUP(4, EHT_GI_08, BW_20),
> +	EHT_GROUP(5, EHT_GI_08, BW_20),
> +	EHT_GROUP(6, EHT_GI_08, BW_20),
> +	EHT_GROUP(7, EHT_GI_08, BW_20),
> +	EHT_GROUP(8, EHT_GI_08, BW_20),
> +	EHT_GROUP(9, EHT_GI_08, BW_20),
> +	EHT_GROUP(10, EHT_GI_08, BW_20),
> +	EHT_GROUP(11, EHT_GI_08, BW_20),
> +	EHT_GROUP(12, EHT_GI_08, BW_20),
> +	EHT_GROUP(13, EHT_GI_08, BW_20),
> +	EHT_GROUP(14, EHT_GI_08, BW_20),
> +	EHT_GROUP(15, EHT_GI_08, BW_20),
> +	EHT_GROUP(16, EHT_GI_08, BW_20),

This is really long and repetitive - maybe we can have a macro that does
the 1..16, and gets the other two arguments? Then we only have 16 lines
for the macro, and 16 invocations, rather than 256 new lines ...

> -	if (WARN_ON_ONCE((status->encoding !=3D RX_ENC_HE && streams > 4) ||
> -			 (status->encoding =3D=3D RX_ENC_HE && streams > 8)))
> +	if (WARN_ON_ONCE((status->encoding =3D=3D RX_ENC_EHT && streams > 16) |=
|
> +			 (status->encoding =3D=3D RX_ENC_HE && streams > 8) ||
> +			 (status->encoding < RX_ENC_HE && streams > 4)))

However, you also seem to consistently assume that 16 streams are
possible with EHT ... why?! That's not even supported by the spec, much
less being practical...

Fixing that would already halve the number of lines needed, though it
might still be good to have nested macros.

johannes

