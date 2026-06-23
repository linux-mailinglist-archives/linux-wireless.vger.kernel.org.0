Return-Path: <linux-wireless+bounces-37988-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rE9+CETeOWqByQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37988-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 03:15:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE56B31AB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 03:15:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=smBR6P7n;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37988-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37988-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 343123026FE8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487EC21CA0D;
	Tue, 23 Jun 2026 01:15:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661C171AF
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 01:15:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177346; cv=none; b=RGUqbEeHh0qK3rhoq3IxAuvJpjwlHG/Vt4USypT04b0HCtXokzWEoOkWTAQ87fAqjw9wVGvBamoLblddblYl6GscCm9XbUfP4Gg2TX3M0wV0dztfB3jiH5vw+HGwWab0Et8Z4XzVwINkuUCZfXVt/nCUeBo0RE/GvYbn5FPxvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177346; c=relaxed/simple;
	bh=qapYuEm6z+1WJtqQJ1PH+YP4BBGgwPe7g9rx5WSAaU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KPt+nDhMxZpgV+MW2Kf72Qw4XRqessZrcIkDSj9p40c88P9zjxqnHPhKLRTq2ZCvJ4gdMfP6FIv+Ay6B/CF6ZxUAfkq/HAFu8Kzc9dhwQuxSUStc6JkLnWsW8eQc9SQOVJhYcACLwZxjfs/HrrpTuULq/3UdS8SUmKBWM54UpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=smBR6P7n; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65N1FXQq82995751, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782177333; bh=qapYuEm6z+1WJtqQJ1PH+YP4BBGgwPe7g9rx5WSAaU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=smBR6P7nGbl1x+4Jh6DGVazsAtHhgsXaRZeuD7ZEiV267YeGGq/zjBTJ/dKAH4xMV
	 LRE5nWCaX72KBw+XaO0ao8HZzE1j85yZfV69xeOC/+fsTJyoxW4hZcxfVBc2tAkTG3
	 oFqPt1uqMTe6riOUjFZza55ELVLelO826L0LtHKEcGqhDzpvbWAqyg5XGRqqPPMX6q
	 x0r3qf6N2p8ZQYRZbtlUm/2FnW0dMrn46uIPqFCQS+KkWUekq3zlu/Ftlry0l//o2q
	 P+dta6YBmmZWd33orfRH5QHVQd6b7cWNQeP1mw0nY5Jmf+7fV0UH5FNGak7PdFz77j
	 m4j5vp8E6H5iw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65N1FXQq82995751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jun 2026 09:15:33 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Jun 2026 09:15:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Jun 2026 09:15:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 23 Jun 2026 09:15:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: =?utf-8?B?R2VvcmcgQmnDn2VsaW5n?= <georg.bisseling@sea-gmbh.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Enable receiving control frames in
 monitor mode
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Enable receiving control frames in
 monitor mode
Thread-Index: AQHdAmj1TAcJ9FrazUmywt1BNrR//LZLT9zw
Date: Tue, 23 Jun 2026 01:15:33 +0000
Message-ID: <7f12ff0969754a9fa4d78b0ae3d2409e@realtek.com>
References: <2a52d718-9e46-47f2-84a1-d8e7b1ed89a8@gmail.com>
In-Reply-To: <2a52d718-9e46-47f2-84a1-d8e7b1ed89a8@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rtl8821cerfe2@gmail.com,m:linux-wireless@vger.kernel.org,m:georg.bisseling@sea-gmbh.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37988-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7FE56B31AB

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBGcm9t
OiBCaXR0ZXJibHVlIFNtaXRoIChTLkUuQS4gRGF0ZW50ZWNobmlrIEdtYkgpIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4NCj4gDQo+IEJ5IGRlZmF1bHQgUlRMODcyM0QsIFJUTDg3MDNCLCBSVEw4
ODEyQSwgUlRMODgyMUEsIGFuZCBSVEw4ODE0QSBhcmUNCj4gY29uZmlndXJlZCB0byBmaWx0ZXIg
b3V0IGFsbCBjb250cm9sIGZyYW1lcyBleGNlcHQgUFMtUG9sbCwgZXZlbiBpbg0KPiBtb25pdG9y
IG1vZGUuDQo+IA0KPiBIYW5kbGUgRklGX0NPTlRST0wgaW4gcnR3X29wc19jb25maWd1cmVfZmls
dGVyKCkuIFdoZW4gaXQncyBzZXQsDQo+IGNvbmZpZ3VyZSBSRUdfUlhGTFRNQVAxIHRvIGxldCBh
bGwgY29udHJvbCBmcmFtZXMgdGhyb3VnaC4gV2hlbiBpdCdzDQo+IHVuc2V0LCByZXN0b3JlIHRo
ZSBvcmlnaW5hbCB2YWx1ZS4gQmVjYXVzZSBzb21lIGRyaXZlcnMgY29uZmlndXJlDQo+IFJFR19S
WEZMVE1BUDEgZGlmZmVyZW50bHksIGtlZXAgdHJhY2sgb2YgaXRzIHZhbHVlIGluIGEgbmV3IG1l
bWJlciBvZg0KPiBzdHJ1Y3QgcnR3X2hhbC4NCg0KQWxsIGJlaGF2aW9ycyBhcmUgdW5jaGFuZ2Vk
IGZvciBub24tbW9uaXRvciBtb2RlLCByaWdodD8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0
dGVyYmx1ZSBTbWl0aCAoUy5FLkEuIERhdGVudGVjaG5payBHbWJIKSA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNCk9uY2UgeW91IG1pZ3JhdGUgdG8geW91ciBjb21wYW55IG1haWwsIG1heWJl
IHlvdSBjYW4gYWRkIGFuIGVudHJ5IHRvIC5tYWlsbWFwLCANCndoaWNoIG9ubHkgYWZmZWN0cyB0
aGUgb3V0cHV0IG9mIGdpdC1zaG9ydGxvZyB0aG91Z2guDQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

