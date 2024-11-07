Return-Path: <linux-wireless+bounces-15098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9D9C08DD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4AA283E58
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3EF212164;
	Thu,  7 Nov 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k/7T0C50"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5029CF4
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989662; cv=none; b=OgLneFZRnqGkHmg+tWKpX6z7ANvXykMUE2bGId9x5PnfrZNa87awBB0+i/GWDCikRJxAzbAHKEDSZ0NIganaxX4lJesuO9c6Gs8opbAeKaoBu5Tw+Vhm6vjyPNn6YGzTTnkzPg4ZTCS1HPhRaJvlfxibo3rlz2WXn8RD1bJ8y5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989662; c=relaxed/simple;
	bh=aNG6Em7lHPnigCNUOAeIXCJO5DUJNa8lHK4za2TMaHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mmvm/VI/h8ax0Nngy/qv2M8nPZZQnQfZYSux9K05FljMDtSF/XseTMwJgrWdX4aRGlXqBYqc39+ItV5foVtsbEUjAe6gdC7H779DDD6fgORifp+Z5VdqBzfFcJQy8459TWDXQghixBr/vnvQLA2OhQJt3h403kG8I31bkS9Hb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k/7T0C50; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gr9sNLNmBx5Qe21s13KccHsdL8XkpXpb/tTPabEY9M4=;
	t=1730989660; x=1732199260; b=k/7T0C50PRkUElZkwI9TPRIKgPRI1XKy3X+wKbPs/jQ96SH
	QHFuGGmZHbEyRsCx4ipeNv8/cBsVRGq+py8bfU843KP+gEtpEhskzkbxu4/D1SJ2LyhX0AefPuq9d
	ZRn9LNLSPYG2PgbSPKSVYFbOv9kFDhXgSJTWNtwlgyySxaMPZjqcB2XmrUrstJlBwUj19ud17/lhU
	IsxQytK4sQxzdYFL7TcS1lSLCLU0Cj/uZz6zW6B8gSvnm1bj5LNQHHFQ8pvRiYA6OmDzzt6IB7r6v
	FAUsWE62915rcLTw6I40Vg0sFL9Ffg2iTZqH2FgkbnXDV+4P9tc+mTHjzgGfomNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93U0-0000000GS6l-2NqP;
	Thu, 07 Nov 2024 15:27:36 +0100
Message-ID: <1a2ab64996bb76b3503362696cfc1b935ec57c9e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: iw: Add support to display  max number of
 simultaneous links in phy info
From: Johannes Berg <johannes@sipsolutions.net>
To: Mohan Raj <quic_mrajraje@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 07 Nov 2024 15:27:35 +0100
In-Reply-To: <20241105064809.2091332-1-quic_mrajraje@quicinc.com>
References: <20241105064809.2091332-1-quic_mrajraje@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

First, iw patches don't need "wifi:" prefix :)


>         MLD Capability: 0x44
>                 Max Number of Simultaneous Links: 4

I think we should print the other MLD capabilities too?

>         hw_idx 0 channel list:
>                 1 2 3 4 5 6 7 8 9 10 11 12 13 14
>         hw_idx 1 channel list:
>                 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128=
=20
> 		132 136 140 144 149 153 157 161 165 169 173 177
>         hw_idx 2 channel list:
>                 1 2 5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73
>                 77 81 85 89 93 97 101 105 109 113 117 121 125 129 133=20
> 		137 141 145 149 153 157 161 165 169 173 177 181 185 189
> 		193 197 201 205 209 213 217 221 225 229 233

I don't believe this exists upstream, so not sure why you included it in
the example.

>  	if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
>  		printf("\tMaximum associated stations in AP mode: %u\n",
>  		       nla_get_u32(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
> +	if (tb_msg[NL80211_ATTR_IFTYPE_EXT_CAPA]) {

blank line before that would be nice

> +		int rem_ext =3D 0;
> +		struct nlattr *tb1[NL80211_ATTR_MAX + 1];
> +		struct nlattr *ext_attr;
> +		__u8 max_simul_links;
> +		__u16 mld_cap;
> +
> +		nla_for_each_nested(ext_attr, tb_msg[NL80211_ATTR_IFTYPE_EXT_CAPA], re=
m_ext) {
> +			nla_parse(tb1, NL80211_ATTR_MAX, nla_data(ext_attr),
> +				 nla_len(ext_attr), NULL);

there's some bad indentation here and later

> +	}
> +

And here you didn't need an extra blank line.

johannes

