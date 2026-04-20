Return-Path: <linux-wireless+bounces-35015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBIoFkzi5WnfowEAu9opvQ
	(envelope-from <linux-wireless+bounces-35015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:22:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3642816E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 10:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E885302B753
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD04388360;
	Mon, 20 Apr 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lNFzWvg7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61D386421
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673230; cv=none; b=ZGRqNqY8j81AsxBmf3/et0SvC1/NmhcjNA8PgEw6CD8ZR6T8SABRXJfruS/pdhuutUPnOx1NOtzU5+BfeM5r6xIvPHXCab+BXKREIMN/ryjN4dj2oa/2gag5StxB5XFSWukn7wU10K3ZtpnHgTqM+u4cgFPh1FzuBG2mtT+Ofp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673230; c=relaxed/simple;
	bh=asNj2v7NkPAv4bblMe+ArA+c8J2X+KPC2IhJ3KCTiw8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nf0EwDu3qJr7yqdfoGmdTMDsFjUQgh0IQZBHxpuaZRowWl41+5LqYiot5QCPje7f9v7kITDMS1MXtLksgQ0OeczMWGu1tcUCuqH01YMEXxJ0yiOLkdwfDhkmEp1D9NKGjWjWb5GUD9R+J4pvQDGgnPY/zKUg5bqbM6ZJnoXc4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lNFzWvg7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K8KPlW4815862, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776673225; bh=asNj2v7NkPAv4bblMe+ArA+c8J2X+KPC2IhJ3KCTiw8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lNFzWvg73123J015kX7qzxDRzCpqkZDMpwD6Dp4x252Toz7i0sioCzJ0Jrn0ky0s0
	 kX36Kd/0q7DL9r264Crvl6htVYWn3Oejlls82ghPdoe1+SAW3s++G1DW2dfqljkIrA
	 ACNj+oI74A4OrdN6x27gAQqEvXYi1+YFZ/n5hf5ARbCFPJINslv1sM2RRg0Gidwfd4
	 8xIAV9i38g5WciIPVpD+rIpH6nBbRyjHK6nwEvYjBI1pQjVfEhI9x2+pZ5fZWcLcYO
	 AiwCBPzQDhibiedZYjuQT0keF7xYYArpBHbPIQSQ7ax3JYXNCTwFH9tMTr2KtVmdf+
	 AmRTJyMM+CeJA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K8KPlW4815862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 16:20:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 16:20:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 16:20:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 20 Apr 2026 16:20:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
Thread-Topic: [PATCH rtw-next v2 00/11] wifi: rtw89: Add support for RTL8922AU
Thread-Index: AQHc0AH0GCGMzHZNQkut68u1SnpP1rXnnM9Q
Date: Mon, 20 Apr 2026 08:20:24 +0000
Message-ID: <6c97027e16a5407da0031eb503219a25@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
In-Reply-To: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35015-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AEE3642816E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IFR3
byBwZW9wbGUgaGF2ZSB0ZXN0ZWQgTUxPIHNpbmNlIHYxLiBJdCBkb2Vzbid0IGV4cGxvZGUsIHNv
IEkgZHJvcHBlZA0KPiB0aGUgcGF0Y2ggdG8gZGlzYWJsZSBNTE8uIChJdCBkb2Vzbid0IHdvcmsg
dmVyeSB3ZWxsIHdpdGggTUxPLCBidXQNCj4gwq9cXyjjg4QpXy/CrykNCg0KQ291bGQgeW91IHNo
YXJlIHRoZSBsaW5rIHRoZXkgZGlkPyBXZSBjYW4gY2hlY2sgdGhlbSBpbnRlcm5hbGx5Lg0KDQpQ
aW5nLUtlDQoNCg0KDQo=

