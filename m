Return-Path: <linux-wireless+bounces-31716-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vgmSGYEmjGliiQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31716-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 07:49:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB865121B14
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 07:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0504D3031EAE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095029C338;
	Wed, 11 Feb 2026 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i9ffwr2u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417323AB8D
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770792574; cv=none; b=rp1Ib/govDH+76taT/Osy6hMDrC1Wvd2sjBZdrJjsDBNrPhBNUyj6MsG05I7Vs1bRvW0Aan/aBeOylPLRc782DotK76PF0yUjc5efe+GWr1GeoTmznI0+y+WM2jW5NzEbgleQMWbRPEnFphjBJMTrSoDyBKi+iMzc29n52TerEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770792574; c=relaxed/simple;
	bh=ThIi6CxhfyJmG7Nivm3jieuCnwX7Id5AEOMisb4ECDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0tizuJlPhhjWGsZO4KZyu1XhoXfnZNl/xw26ccNXOvXcur27MLEcScaWN2C6qj1Wc2dim9trR3JCsKYKNT5zzNepRX8/gnoMBUtfTD6HEIpEeWCY9Wb4Mbn6PI0cH0lbvtajPHe4pCvV20iI/NIs7aCsdDu8Q9xSGV0HJzUuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i9ffwr2u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61B6nI9T11244477, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770792558; bh=DW3ofiIJtTtt7cJPeU8Yf5E6wGWESDax6l6aX+zxoV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i9ffwr2uYEaUe/SniilYybbYW0mBeKnC9B5FhaYeE+xIAZ4lB6ZXXXMHsINMLoZDu
	 +M+dgXF3AOOlD9Dj6PIJ+AnI3qPB39tRyM/AhzPMJzeokoUybzA0iYHF17fF0qr0nm
	 1Lvw15xQSwEBohniOqcOKI3okIARkCVrWMn+JSUCx3Dgeo1KfP0nF2wV/bYwRlOFU0
	 3RILr/AOph7j4XVdbfsLudeeKuoD/sBrPu0NP3NPyuNgYy06ajT5HAngTZIx/UMbMs
	 u++U/WzF1nnUK7kVkYhazqb/6ISPlReWrG6ij1v4ODK0/IesNOxa2C+seijWQ7/HkX
	 rqzAjd7eF2seQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61B6nI9T11244477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 14:49:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Feb 2026 14:49:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Feb 2026 14:49:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 11 Feb 2026 14:49:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
Subject: RE: [PATCH 2/2] wifi: mac80211: improve station iteration ergonomics
Thread-Topic: [PATCH 2/2] wifi: mac80211: improve station iteration ergonomics
Thread-Index: AQHcgK2+R3yb7dwFmU+rH/x0FQyqUbV9Py0w
Date: Wed, 11 Feb 2026 06:49:19 +0000
Message-ID: <fb7526f0a2e64e229446e3faa03edc3a@realtek.com>
References: <20260108143431.f2581e0c381a.Ie387227504c975c109c125b3c57f0bb3fdab2835@changeid>
 <20260108143431.d2b641f6f6af.I4470024f7404446052564b15bcf8b3f1ada33655@changeid>
In-Reply-To: <20260108143431.d2b641f6f6af.I4470024f7404446052564b15bcf8b3f1ada33655@changeid>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31716-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:mid,realtek.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BB865121B14
X-Rspamd-Action: no action

Hi Johannes,

> +/**
> + * for_each_station - iterate stations under wiphy mutex
> + * @sta: the iterator variable
> + * @hw: the HW to iterate for
> + */
> +#define for_each_station(sta, hw)                                      \
> +       for (sta =3D __ieee80211_iterate_stations(hw, NULL);             =
 \
> +            sta;                                                       \
> +            sta =3D __ieee80211_iterate_stations(hw, sta))
> +

I'm going to use for_each_station() in rtw89 driver, and the code in driver=
 side
looks very simple! Thanks for this new API.

However, without other callers rather than ieee80211_iterate_xxx(), I'd lik=
e
to know if it is expected that driver uses for_each_station()? Since help
text is added, I think it can be, right?

Another question is that adding ieee80211_ prefix would be consistent with
other API? If you agree, I can make patches.

As well as for_each_interface().

Ping-Ke


