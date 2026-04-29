Return-Path: <linux-wireless+bounces-35541-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMilItRT8WkugAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35541-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 02:41:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F072048DCD1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 02:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77BD530360B9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 00:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16921773D;
	Wed, 29 Apr 2026 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hd4gF/tn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810051DD0D4;
	Wed, 29 Apr 2026 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423308; cv=none; b=EtAdau46NEs9/7PPtO6KaTHuyFpTo0AHUOVdXSg2j6mpnGcPmL45B9BKiF6SUaUZUpMBUwQSOG4xxskFXx38/QG7HudC/ZkCRtiBcawJBZoO9h1XY1Z2g0e/zh2YODTGiwPgMXxMtVSkHI4Qymf09KH6UI1s4k36ruLllKzPz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423308; c=relaxed/simple;
	bh=YQkVH7lirlYNBMaQ3LoLyoQpPlONIc2D3c8S5pNufuA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E+5svuubvj8p1uBS+Z48TmUKkIFF5kLTQwgaP1qLkalnxssTByfgTChi5LcXyA1qWQ2ZFWGvGM0fqBTKOmxkTtV78YSoHy488fqQZPN7Y66Wek49RZHNgZnUCG81rX1PiFU+VkCdv5NPk0WxzrVeAAhqZ2p4/keAFUk2CjAUyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hd4gF/tn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T0eQy75850035, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777423226; bh=YQkVH7lirlYNBMaQ3LoLyoQpPlONIc2D3c8S5pNufuA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Hd4gF/tnrGNSK0f4tEtSVhJIA/ckn7mucHDFLDFkjor7nufQbBpxJyk26DFueplr1
	 H/kFO8EOYyrby+PZbEO7Llashb8Az5mbb8NiZ+JBZopF218JQBLBzWxWnSmcQeYMcG
	 FE77Y5ZKQlUGv+v2el9rMqThvoL5BC/ktpVpBeukQ4miy2H5PEHRs+ilB2AdatZwrs
	 Ef2dQUlKv+aju2AKz3inMgiYBJzaQmzqoFN7b1RZd4igd5kp0HJ78Ot0nlgQUxdpWb
	 Wyf4YFkj8/hdebMyteQLs8kXpOTps7SaiG37U8B2OQAhSTs7lHMg/eNrTdpe4vHI9k
	 EUJloqTHPgnQg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T0eQy75850035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 08:40:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 08:40:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Wed, 29 Apr 2026 08:40:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
        "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        David Laight
	<david.laight.linux@gmail.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede
	<hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Salah Triki <salah.triki@gmail.com>,
        "Achim
 Gratz" <Achim.Gratz@Stromeko.DE>,
        Ben Collins <bcollins@watter.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: RE: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Thread-Topic: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Thread-Index: AQHc1o6xWsc4T9bdAkGO0jI3Cj/ORbX1Mn/A
Date: Wed, 29 Apr 2026 00:40:26 +0000
Message-ID: <571202270b0f4811b18cbd6c9381522c@realtek.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
 <20260427214127.406067-8-ynorov@nvidia.com>
In-Reply-To: <20260427214127.406067-8-ynorov@nvidia.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: F072048DCD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35541-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,gmail.com,analog.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,realtek.com:email,realtek.com:dkim,realtek.com:mid]

Yury Norov <ynorov@nvidia.com> wrote:
> Switch from sign_extend32(FIELD_GET()) to the dedicated
> FIELD_GET_SIGNED() and don't calculate the fields length explicitly.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


