Return-Path: <linux-wireless+bounces-38235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6sp/AyfUQWp8uwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:10:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEC66D5790
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:10:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=RKWw+LKR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38235-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38235-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB1D300C581
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064292D3A7C;
	Mon, 29 Jun 2026 02:10:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B131175A94
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699043; cv=none; b=Bt5KyihM7bh2U2e0uiH7IEuD4WSEWPa/AE8XtzqbYeQnO3dg+PpnBYIEKwde2hxdLMZyiLnPO4/9rADSrdbDiIPiRRkmAExNi5VqGASDUVJS0ie7M7cq8dD8KBYTGvCA6H6gnou/8qBhtMWBfKwO7RRlh5NoF1IIAvoyvGs517k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699043; c=relaxed/simple;
	bh=8ze6lvETJAdn9fh4UeU8zw2acgAPkEplS+DFoU+TkxM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tTh+CKgw5ZDx/sLd649b3TASJ8CUO6GMQWuAuEzg9RWq3Xd8MdqDR/K23OnQjVHZiW4Z24P0edboxfjvqKRwnVj+EGEQ8Zvr6dAWk6skdYTyMeml0OltZfBL8BGN9X/kd6Hx0nBZRq7n9ZcMD5QKakhDf4cSd7A6LQaL8gSoUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RKWw+LKR; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T2Ac2rA3314233, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782699038; bh=8ze6lvETJAdn9fh4UeU8zw2acgAPkEplS+DFoU+TkxM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RKWw+LKR2YHqKANtq6PV2kG4WBmF/UtIZe3cZhdaoV7GFYTbDSFnPr137ivQ5UcSf
	 ncgge/7y/411cLLQ2o/6bimwUpBI1C9aAQSspv2ysQNwCH619qcY2zD+NBFYpURXJ5
	 2NRhWkI+TcaimQqCx3zjJyQfszmVZUQ8xlV8jV1RW6oV3kYLMavXerKkOTqTIfMacq
	 AbY8MqHmif/qz0cREM8cgC868HNeXDh/oGLq+7laiOJzpx3Qcg3VoyPrbShPRwvhF1
	 UDZ/nLz1LztUdY4eAE7G00lgkLKQDtGCY3TzHJ1an7vzh7ljsLaREd5+HpJB2WGQSD
	 vMwlXUeuOsBag==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T2Ac2rA3314233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 10:10:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 10:10:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 10:10:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 29 Jun 2026 10:10:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Doug Brewer <brewer.doug@gmail.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: rtw89: RTL8852BE P2P-device iftype and STA+P2P interface
 combination
Thread-Topic: rtw89: RTL8852BE P2P-device iftype and STA+P2P interface
 combination
Thread-Index: AQHdBsiUWEi4pimYHEaDlfxBkcAE67ZUyXVQ
Date: Mon, 29 Jun 2026 02:10:38 +0000
Message-ID: <54e7877f76944bd29e57d6eafe5e3811@realtek.com>
References: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
In-Reply-To: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:mid,realtek.com:from_mime,vger.kernel.org:from_smtp];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brewer.doug@gmail.com,m:linux-wireless@vger.kernel.org,m:brewerdoug@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38235-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EEC66D5790

RG91ZyBCcmV3ZXIgPGJyZXdlci5kb3VnQGdtYWlsLmNvbT4gd3JvdGU6DQo+IEhpLA0KPiANCj4g
SSdtIGV4cGVyaW1lbnRpbmcgd2l0aCBXaS1GaSBEaXNwbGF5IChNaXJhY2FzdCBzaW5rKSBjb25j
dXJyZW50IHdpdGggYW4NCj4gU1RBIGNvbm5lY3Rpb24gb24gYW4gUlRMODg1MkJFIChQQ0llKSB1
c2luZyB0aGUgbWFpbmxpbmUgcnR3ODkgZHJpdmVyDQo+IChrZXJuZWwgNi4xOC4zNykuDQo+IA0K
PiBpdyBwaHkgcmVwb3J0czoNCj4gU3VwcG9ydGVkIGludGVyZmFjZSBtb2RlczoNCj4gICAgKiBt
YW5hZ2VkLCBBUCwgUDJQLWNsaWVudCwgUDJQLUdPDQo+ICAgIChubyBQMlAtZGV2aWNlKQ0KPiBp
bnRlcmZhY2UgY29tYmluYXRpb25zIGFyZSBub3Qgc3VwcG9ydGVkDQo+IA0KPiBJbiBwcmFjdGlj
ZSB0aGlzIGJsb2NrcyB0aGUgc3RhbmRhcmQgUDJQIGZsb3c6IHRoZXJlIGlzIG5vIFAyUC1kZXZp
Y2UNCj4gaWZ0eXBlIGZvciBhIGRlZGljYXRlZCBkaXNjb3ZlcnkgY29udGV4dCwgYW5kIG5vIGFk
dmVydGlzZWQgaW50ZXJmYWNlDQo+IGNvbWJpbmF0aW9uIGZvciBtYW5hZ2VkICsgUDJQLWNsaWVu
dCBjb2V4aXN0ZW5jZS4NCj4gDQo+IE15IHF1ZXN0aW9uczoNCj4gMS4gaXMgUDJQLWRldmljZSBp
ZnR5cGUgc3VwcG9ydCBwbGFubmVkIGZvciBydHc4OSBvbiBSVEw4ODV4PyBJcyB0aGVyZSBhDQo+
ICAgICBrbm93biB0ZWNobmljYWwgYmxvY2tlciwgb3IgaXMgaXQgc2ltcGx5IG5vdCB5ZXQgaW1w
bGVtZW50ZWQ/DQoNCldlIGFyZSBwbGFubmluZyB0byBhZGQgUDJQLWRldmljZSBpZnR5cGUuIEl0
IG5lZWRzIHRvIGNvbnNpZGVyIHRoZSBjYXNlcyBvZiANCmNoYW5uZWwgY29udGV4dCwgY29uZGl0
aW9ucyBvZiBwb3dlciBzYXZlLCBhbmQgZXRjLiBJdCB3aWxsIHRha2Ugc29tZSB0aW1lLiANCg0K
SSB0aGluayBpdCB3b3VsZCBiZSBva2F5IHRoYXQgeW91IHVzZSBTVEEgaW50ZXJmYWNlIHRvIGRv
IFAyUCBuZWdvdGlhdGlvbiwNCmFuZCB0aGVuIGNyZWF0ZSBQMlAtY2xpZW50IG9yIFAyUC1HTyBp
ZnR5cGUgdGhlbi4NCg0KPiAyLiB3b3VsZCBhZHZlcnRpc2luZyBhIG1hbmFnZWQgKyBQMlAtY2xp
ZW50IGludGVyZmFjZSBjb21iaW5hdGlvbg0KPiAgICAgKHNpbmdsZSBjaGFubmVsKSBiZSBmZWFz
aWJsZSBvbiB0aGUgY3VycmVudCBydHc4OT8NCg0KVGhpcyBpcyBhIFNDQyB3aGljaCBpcyBzdXBw
b3J0ZWQuDQoNCj4gMy4gaXMgTUNDICgjY2hhbm5lbHMgPiAxKSBvbiB0aGUgcm9hZG1hcCwgb3Ig
Y29uc2lkZXJlZCBvdXQgb2Ygc2NvcGU/DQoNCkN1cnJlbnQgc3VwcG9ydCBNQ0MgYXMgd2VsbC4g
SG93ZXZlciwgd2UgYXJlIGNvb2tpbmcgbmV3IGZpcm13YXJlIHRvIHN1cHBvcnQNCmh3X3NjYW4g
d2l0aCB0d28gb3BlcmF0aW9uIGNoYW5uZWxzIC0tIHdoaWNoIGRvZXNuJ3QgbWF0dGVyIGlmIHlv
dSBkb24ndCBuZWVkDQp0byBkbyBzY2FuIHdoZW4gTUNDIGlzIG9wZXJhdGluZy4NCg0KUGluZy1L
ZQ0KDQo=

