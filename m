Return-Path: <linux-wireless+bounces-19586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67382A49A66
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC61895DC0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFD72580D7;
	Fri, 28 Feb 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YGCPQz9D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246A1D555
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748925; cv=none; b=PvPE06dvQUMADM7lUq9va70r++yx/AuxzTxvwfmoksoeDItQT0pKLlx2z557LR0oGZCDbrac3CPlKWY9j6CdwTDEtXiH6sCPhyd5n62z1llSiJyhk8GdnQ19pwmeyVB/gHh6H39S6sdliRx9p/n1tu4qWbpj2gzPft8K0k6hmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748925; c=relaxed/simple;
	bh=XioyILH4dBroRw+Bs0jJeHj2kb/0gIXkWXHUTKXX/GI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LvDjkckn7pjJK040uYvhdOgOM9a3Mx4wnxrVQGdmqtvLqHy64TpMDS1jfweanhGdWkD5pvzfAwYP1C6VYAMrSHbQcCwHsaJd6uw685WuH7MEJZHkz8mGmJj1YS/BL1RWO+wkzmai5ZE/n1o2PbFWPrr6nKSG3X/iSMO+djcTcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YGCPQz9D; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xNOfvyWSiQQyt3OJKfK8wyb9SbyZf+p0JHLMxs+Xj6Y=;
	t=1740748924; x=1741958524; b=YGCPQz9DgrJOwi1tueXoa9z6WbNjUb1jnSYx4xfxWCQ4kEx
	TNIGV4zADVOgtkIq5iwWBBv0JoMfhhSqgWab88r+27/0uj2d57yWjk9xuTbPeym3CrbTIay68eg1X
	XjKfPDlWETnmetU8CFR7lN3pklvgbzH473O1IweTJlc+oqZSxOf5bgXHdyHLSfibDHw+/+sOtdoJM
	fFt2zfJ8dRJCIRgl9pSSeIOh6FrMuGa5/90Bo6JHQ1Rd3lcJuXHjpB8dF61PckUZFedexUBJFFUe7
	hsD5/io0UlReDJfRqvXMsY6bVu3+nChWVeTmbk4NiTQ8WaTWY/Dx8Zd1ukBX467Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to0JU-0000000Dl8Y-2foA;
	Fri, 28 Feb 2025 14:22:00 +0100
Message-ID: <6c6be5e9552d32d0598af6aee55ceae450209f7e.camel@sipsolutions.net>
Subject: Re: [PATCH v3 07/12] wifi: cfg80211: extend statistics for link
 level in sinfo
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:21:59 +0100
In-Reply-To: <20250213171632.1646538-8-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
	 <20250213171632.1646538-8-quic_sarishar@quicinc.com>
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

On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
> Currently, statistics is supported at deflink( or one of the links)
> level for station. This has problems when applied to multi-link(ML)
> connections.
>=20
> Hence, add changes to support link level statistics in sinfo structure.
> Additionally, remove mlo_params_valid from the sinfo structure and
> add valid_links to indicate bitmap of valid links for MLO.
>=20
> This will be helpful to check the link related statistics during MLO.
>=20
> The statistics could be embedded into NL message as below:

"could be"?

> For MLO:
> cmd ->
> 	NL80211_ATTR_IFINDEX
> 	NL80211_ATTR_MAC
> 	NL80211_ATTR_GENERATION
> 	.......etc
> 	NL80211_ATTR_STA_INFO | nest flag
> 		NL80211_STA_INFO_CONNECTED_TIME,
> 		NL80211_STA_INFO_STA_FLAGS,
> 		........etc
> 	NL80211_ATTR_MLO_LINK_ID,
> 	NL80211_ATTR_MLD_ADDR,
> 	NL80211_ATTR_MLO_LINKS | nested

you're being inconsistent with "| nested" and "| nest flag" but I'm not
sure it's necessary anyway?

> 		link_id-1 | nested
> 		NL80211_ATTR_MLO_LINK_ID,

And that should be indented further, perhaps? Maybe not use tabs then
but just 4 spaces or so :)
>=20
> Station 00:03:7f:04:31:78 (on wlan0)
> 	authorized:     yes
> 	authenticated:  yes
> 	associated:     yes
> 	preamble:       long
> 	WMM/WME:        yes
> 	MFP:            yes
> 	TDLS peer:      no
> 	connected time: 383 seconds
> 	associated at [boottime]:       93.740s
> 	associated at:  93685 ms
> 	current time:   340046 ms
>         MLD address: 00:03:7f:04:31:78

the indentation seems odd, but maybe that's just a copy/paste thing?

>         Link 0:
>                 Address: 00:03:7f:04:31:78
>                 inactive time:  330120 ms
>                 rx bytes:       116
>                 rx packets:     3
>                 tx bytes:       0
>                 tx packets:     0
>                 tx retries:     0
>                 tx failed:      0
>                 rx drop misc:   0
>                 signal:         -95 dBm
>                 tx bitrate:     6.0 MBit/s
>                 tx duration:    2669 us
>                 rx duration:    0 us
> 	        DTIM period:    2
> 	        beacon interval:100
>         Link 1:
>                 Address: 00:03:7f:04:31:79
>                 inactive time:  81268 ms
>                 rx bytes:       1323
>                 rx packets:     12
>                 tx bytes:       1538
>                 tx packets:     8
>                 tx retries:     0
>                 tx failed:      0
>                 rx drop misc:   0
>                 signal:         -95 dBm
>                 tx bitrate:     6.0 MBit/s
>                 tx duration:    2669 us
>                 rx bitrate:     6.0 MBit/s
>                 rx duration:    0 us
> 	        DTIM period:    2
> 	        beacon interval:100

This looks like it's missing the roll-up to the global counters and
timestamps? Why would that not break backward compatibility?

>  static inline void cfg80211_sinfo_release_content(struct station_info *s=
info)
>  {
> -	if (sinfo->links[0]) {
> -		kfree(sinfo->links[0]->pertid);
> -		kfree(sinfo->links[0]);
> +	int link_id;
> +
> +	if (sinfo->valid_links) {
> +		for_each_valid_link(sinfo, link_id) {
> +			if (sinfo->links[link_id]) {
> +				kfree(sinfo->links[link_id]->pertid);
> +				kfree(sinfo->links[link_id]);
> +			}
> +		}
> +	} else {
> +		if (sinfo->links[0]) {
> +			kfree(sinfo->links[0]->pertid);
> +			kfree(sinfo->links[0]);
> +		}
>  	}

Don't be so complicated ... check what "for_each_valid_link()" does if
valid_links is 0.

johannes

