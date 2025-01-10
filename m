Return-Path: <linux-wireless+bounces-17306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15126A08BB7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518AE188D836
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DD20A5F5;
	Fri, 10 Jan 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J41KTYi4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09E20A5F9
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500925; cv=none; b=pa0vxxNyyFwX6XqDqdtYSPXndLJfEkPaZw4Ex6njXCjiqoUO4aP53WoiIjvsnLSb/KSvrCtLW7p4XuoNAb15A2AoCP0drs26rvUCFIv7GiionIktsSa+3gylAJF3iEDRG/sSMQQPRp7IzS0nobAa+FHncDTvkNZM/0CNiLDdolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500925; c=relaxed/simple;
	bh=NS9qaooJ7fLT5Yq29YwDe65iKOSl2gcvhk4ZpuBkScI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDU2b8n+vDj5YUdvTdlaumvOEXbJsd24KLCX/ihc6PAddUxyxLzt15xvCRLW0Nb+/uz6tvymz2I0Dm5nScMwm3AKQtHqYmOwALmwM24uty5WkupCkYDps9wWEd5ZHelkoXWTjiJdbMHR/uM24nvCQRQ1EOh5a7wlhHxkEsfP02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J41KTYi4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zp97pPT7KD5Z0ribC1S8RgNVbV4sX7WvDV9O6JkkRq4=;
	t=1736500924; x=1737710524; b=J41KTYi4Q2Ft1w5E60E0adqnDZHrNVuVw/oreqQWEg8BmeE
	jmZey/VXJ9cIqpQy6GnDOiwKNM6qokByLHWS/xwkJoDPPlamfgLs8mmyvwzZ+lGtRj9Wa8IPp5iZb
	bblZ/EVlR9qgjL1FKQIikdSIMegIZSS8zS1r9DGlGlNzHg9mDzhEfhEdzUPwejPTXcWemGPbkW0/O
	MaRMHb5usWNn3vfBO/kohJUWT4sS9Xf7vQ8vsU48wqZbcDfzxiy5LAyfE6C4Wi3tBw6NQ0AyoPVoT
	fpjas65Sz1Sy8O5PPIea06fwGD+iuTDA3909XQtYD0ujZswev0oTlqrrUJCSqo2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWBDM-0000000ASkz-0Ke7;
	Fri, 10 Jan 2025 10:22:00 +0100
Message-ID: <2728f8c0527d47a8a02852815326508909a17b70.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 3/7] wifi: cfg80211: extend statistics for link
 level in sinfo
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Jan 2025 10:21:59 +0100
In-Reply-To: <20250110042449.1158789-4-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
	 <20250110042449.1158789-4-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>=20
> The statistics could be embedded into NL message as below:
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
> 		link_id-1 | nested
> 		NL80211_ATTR_MLO_LINK_ID,
> 		NL80211_ATTR_MLD_ADDR,

Using the MLD_ADDR attribute here seems really odd?

Also I think you got the indentation wrong.

> 			NL80211_ATTR_STA_INFO | nest flag
> 				NL80211_STA_INFO_RX_BYTES,
> 				NL80211_STA_INFO_TX_BYTES,
> 				..........etc.

johannes

