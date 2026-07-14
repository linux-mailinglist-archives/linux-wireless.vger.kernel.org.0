Return-Path: <linux-wireless+bounces-39018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RS57IOr0VWqAwwAAu9opvQ
	(envelope-from <linux-wireless+bounces-39018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:35:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97075275A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:35:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=iE7YkLTZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39018-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39018-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68A3B3008085
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E73F076E;
	Tue, 14 Jul 2026 08:35:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80D2FD7D3
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 08:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018103; cv=none; b=jy2rO6h5KP17bLfPqXcmlz7ZkprTPLmqMQGANMAY7us7utvN8+fXVDBWdkqRzDAlo+L7Mq7gQvS3dx+pwh6KZBEq0uCvq18rSSAYJGPRoGMXxBpURTHAh/GewG653X/bbATn3xudeGXbEUzvgz7+f4I1JGCamseG/31jvEhT+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018103; c=relaxed/simple;
	bh=anohmil5eqin5hpTlBhsDUhn9AsCErEhzlMd0wYwiKE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uh+jZ/1kBHmXRVkyZONOdrzEHQqnoc6CPZwPpt8+/VAmeVTHP4XpcE0cvN7BxP0G3jFa5558tguqygM47tRlZrGA9KWntH6n8USF9rVqABwTAyo9c90pkLBXxaU+pqP0ke5yGRfP6hmAQ3ECXHQkTxLoxMEdHm095445ztT4qvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iE7YkLTZ; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66E8YiJwA1996529, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784018085; bh=anohmil5eqin5hpTlBhsDUhn9AsCErEhzlMd0wYwiKE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iE7YkLTZTRZQEyBVFmru1Lp94yQoFswwbu4fVAjRkBGuNlmPkgFvAuzK8L8uR34nW
	 WCPLqyA+s5SMkE8DM9x9dmtStrirlJBJfdX4iMJ1MXe/j5GFoorH9ez14y6CnyVyF3
	 tq1vP0qp2wL4nPIRAHkUwTeia3DzXEWFhZxmpQttmVAy7hMYmCnfGEs9mii3tqb4rl
	 wdEJN32Rcr1+wLOzvRsF2/N7cF6wAXp6JAPc++0r+j4Ivrk9V0Dh8lnTx22sEFCaWS
	 CV6mdjPqJ+UWf2RwR66bDhsQmujKgPn3X6S4KVqrhfEp8JCpbQgMgGN59lzAijvzJk
	 Op6FppqnMhK6w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66E8YiJwA1996529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 16:34:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Jul 2026 16:34:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 14 Jul 2026 16:34:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "nurofen55@meta.ua" <nurofen55@meta.ua>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [BUG] rtw89: 8852be intermittent 2.4GHz packet loss regression
 7.0.12 -> 7.1.x
Thread-Topic: [BUG] rtw89: 8852be intermittent 2.4GHz packet loss regression
 7.0.12 -> 7.1.x
Thread-Index: AQHdE2Rw9KdsAqec0kK7K9sExxb/MLZspjHw
Date: Tue, 14 Jul 2026 08:34:42 +0000
Message-ID: <2b6ef871262942fb82ffd350fb7977bd@realtek.com>
References: <60828.185.222.23.114.1784014990.metamail@mail.meta.ua>
In-Reply-To: <60828.185.222.23.114.1784014990.metamail@mail.meta.ua>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39018-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nurofen55@meta.ua,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[meta.ua,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,meta.ua:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E97075275A

bnVyb2ZlbjU1QG1ldGEudWEgPG51cm9mZW41NUBtZXRhLnVhPiB3cm90ZToNCj4gSGksDQo+IEkn
ZCBsaWtlIHRvIHJlcG9ydCBhIHJlZ3Jlc3Npb24gaW4gdGhlIHJ0dzg5IGRyaXZlciAoUlRMODg1
MkJFKSBhZmZlY3RpbmcgMi40R0h6IHN0YWJpbGl0eSwgaW50cm9kdWNlZA0KPiBzb21ld2hlcmUg
YmV0d2VlbiBrZXJuZWwgNy4wLjEyIGFuZCA3LjEueC4gVGhpcyB3YXMgb3JpZ2luYWxseSBmaWxl
ZCBvbiBvcGVuU1VTRSBidWd6aWxsYSAoYnVnIDEyNzEzNTkpLA0KPiBhbmQgSmlyaSBTbGFieSBz
dWdnZXN0ZWQgSSBmb3J3YXJkIGl0IGhlcmUgZm9yIHZpc2liaWxpdHkgd2l0aCB0aGUgZHJpdmVy
IG1haW50YWluZXJzOg0KPiBodHRwczovL2J1Z3ppbGxhLm9wZW5zdXNlLm9yZy9zaG93X2J1Zy5j
Z2k/aWQSNzEzNTkNCj4gU3VtbWFyeToNCj4gDQo+IEFmdGVyIHVwZGF0aW5nIGZyb20ga2VybmVs
IDcuMC4xMiB0byB0aGUgNy4xLnggc2VyaWVzICh0ZXN0ZWQgb24gNy4xLjIgYW5kIDcuMS4zKSBv
biBvcGVuU1VTRSBUdW1ibGV3ZWVkLA0KPiBpbnRlcm1pdHRlbnQgY29ubmVjdGl2aXR5IGlzc3Vl
cyBhcHBlYXIgc3BlY2lmaWNhbGx5IG9uIHRoZSAyLjRHSHogYmFuZC4gT24ga2VybmVsIDcuMC4x
MiwgYm90aCAyLjRHSHoNCj4gYW5kIDVHSHogYmFuZHMgd2VyZSBlcXVhbGx5IHN0YWJsZSBhdCB0
aGUgc2FtZSBwaHlzaWNhbCBsb2NhdGlvbi4gT24ga2VybmVsIDcuMS54LCB0aGUgNUdIeiBiYW5k
IHJlbWFpbnMNCj4gZnVsbHkgc3RhYmxlIGF0IHRoZSBzYW1lIGxvY2F0aW9uLCB3aGlsZSB0aGUg
Mi40R0h6IGJhbmQgZXhoaWJpdHMgaW50ZXJtaXR0ZW50IGhpZ2gtbGF0ZW5jeS9wYWNrZXQtbG9z
cw0KPiBldmVudHMuDQo+IEhhcmR3YXJlOg0KPiANCj4gLSBMYXB0b3A6IExlbm92byBJZGVhUGFk
IFNsaW0gMyAxNUFSUDEwDQo+IA0KPiAtIENQVTogQU1EIFJ5emVuIDcgNzczNUhTDQo+IA0KPiAt
IFdpLUZpOiBSZWFsdGVrIFJUTDg4NTJCRSAocnR3ODlfODg1MmJlKSwgUENJZQ0KPiANCj4gLSBG
aXJtd2FyZTogcnR3ODkvcnR3ODg1MmJfZnctMi5iaW4sIHZlcnNpb24gMC4yOS4yOS4xOCAoOWUz
ZDc3N2YpIC0gdW5jaGFuZ2VkIHRocm91Z2hvdXQgYWxsIHRlc3RpbmcNCg0KUGxlYXNlIGNoZWNr
IHRoZSBrZXJuZWwgdG8gc2VlIHRoZSBmaXJtd2FyZSBpdCBhY3R1YWxseSBsb2FkZWQuDQoNClRo
ZSBjb21taXQgMWQ2N2YxZjhlOWEwICgid2lmaTogcnR3ODk6IDg4NTJiOiB1cGRhdGUgc3VwcG9y
dGVkIGZpcm13YXJlIGZvcm1hdCB0byAyIikNCmFkZGVkIGJ5IDcuMSBpcyBjaGFuZ2VkIHRvIHN1
cHBvcnQgLTIgZmlybXdhcmUuIFRoYXQgbWVhbnMga2VybmVsIDcuMCBsb2Fkcw0KcnR3ODkvcnR3
ODg1MmJfZncuYmluIGluc3RlYWQuDQoNCj4gKHJ1bGVkIG91dCBhcyBhIGZhY3RvcikNCj4gU3Rl
cHMgdG8gcmVwcm9kdWNlOg0KPiANCj4gMS4gQm9vdCBpbnRvIGtlcm5lbCA3LjEueCAocmVwcm9k
dWNlZCBvbiBib3RoIDcuMS4yIGFuZCA3LjEuMykNCj4gDQo+IDIuIENvbm5lY3QgdG8gdGhlIDIu
NEdIeiBTU0lEIGF0IGEgbG9jYXRpb24gd2l0aCBtb2RlcmF0ZSBzaWduYWwgKGFyb3VuZCAtNzAg
ZEJtKQ0KDQpJZiB5b3UgbG9jYXRlIHlvdXIgbGFwdG9wIG5lYXJieSB0aGUgQVAgKHN0cm9uZ2Vy
IHNpZ25hbCksIHdpbGwgaXQgYmUgaW1wcm92ZWQ/DQoNClBsZWFzZSBhbHNvIHRyeSB0byB0dXJu
IG9mZiBwb3dlciBzYXZlIGJ5DQogICBzdWRvIGl3IHdsYW4wIHNldCBwb3dlcl9zYXZlIG9mZg0K
dG8gc2VlIGlmIGFueXRoaW5nIGNoYW5nZXMuIA0KDQo+IA0KPiAzLiBSdW4gY29udGludW91cyBt
b25pdG9yaW5nIChtdHIvcGluZykgd2hpbGUgdXNpbmcgdGhlIGNvbm5lY3Rpb24gbm9ybWFsbHkN
Cj4gDQo+IDQuIEludGVybWl0dGVudCBwYWNrZXQgbG9zcyAvIGxhdGVuY3kgc3Bpa2VzIG9jY3Vy
OyB0aGUgc2FtZSBsb2NhdGlvbi9jb25kaXRpb25zIG9uIHRoZSA1R0h6IFNTSUQgc2hvdw0KPiBu
byBzdWNoIGlzc3VlDQo+IENhcHR1cmVkIGV2aWRlbmNlIG9mIG9uZSBldmVudCAoa2VybmVsIDcu
MS4zKSwgbXRyIG91dHB1dCBkdXJpbmcgdGhlIGRyb3A6DQo+IEhPU1Q6IGxvY2FsaG9zdC5sb2Nh
bGRvbWFpbiAgICBMb3NzJSAgIFNudCAgIExhc3QgICBBdmcgICBCZXN0ICBXcnN0ICBTdERldg0K
PiANCj4gMS58LS0gMTkyLjE2OC4wLjEwOSAgICAgICAgICAgIDIwLjAlICAgIDEwICAgMzAxOC4g
IDk1OC42ICA5LjAgIDMwMTguIDEyMzQuNg0KPiANCj4gICAgICAxOTIuMTY4LjAuMQ0KPiBBIHNp
bmdsZSBwYWNrZXQgc2hvd2VkIGFib3V0IDMwMTggbXMgbGF0ZW5jeSB3aXRoIDIwJSBsb3NzIHJl
Y29yZGVkIGR1cmluZyB0aGUgc2FtcGxlLg0KPiBOb3RhYmx5LCBubyBjb3JyZXNwb25kaW5nIGVu
dHJpZXMgYXBwZWFyIGluIGRtZXNnL2pvdXJuYWxjdGwgZHVyaW5nIHRoaXMgZXZlbnQgLSBubyBk
ZWF1dGgsIG5vIGRyaXZlcg0KPiBlcnJvciwgbm8gZmlybXdhcmUgdGltZW91dC4gaXcgZGV2IHds
cDJzMCBzdGF0aW9uIGR1bXAgaW1tZWRpYXRlbHkgYWZ0ZXIgc2hvd2VkIHRoZSBsaW5rIGFzIGZ1
bGx5IGhlYWx0aHk6DQo+IDAgdHggcmV0cmllcywgMCB0eCBmYWlsZWQsIGJlYWNvbiBsb3NzIDAu
IFRoaXMgc3VnZ2VzdHMgdGhlIHBhY2tldCBsb3NzIGhhcHBlbnMgYXQgYSBsZXZlbCBub3Qgc3Vy
ZmFjZWQNCj4gYnkgZHJpdmVyIGxvZ2dpbmcgKHBvc3NpYmx5IGludGVyZmVyZW5jZSBoYW5kbGlu
ZywgY2hhbm5lbCBjb250ZW50aW9uLCBvciBwb3dlci1zYXZlIGxvZ2ljIHNwZWNpZmljDQo+IHRv
IDIuNEdIeiksIHJhdGhlciB0aGFuIGEgbGluay1sYXllciBkaXNjb25uZWN0Lg0KPiBFeHBlY3Rl
ZCBiZWhhdmlvcjoNCj4gDQo+IDIuNEdIeiBzdGFiaWxpdHkgbWF0Y2hpbmcga2VybmVsIDcuMC4x
MiBiZWhhdmlvciAoZXF1aXZhbGVudCB0byBjdXJyZW50IDVHSHogc3RhYmlsaXR5IG9uIDcuMS54
KS4NCj4gQWN0dWFsIGJlaGF2aW9yOg0KPiANCj4gSW50ZXJtaXR0ZW50IGhpZ2gtbGF0ZW5jeS9w
YWNrZXQtbG9zcyBldmVudHMgb24gMi40R0h6IG9ubHksIHdpdGgga2VybmVsIDcuMS54OyBub3Qg
cmVwcm9kdWNlZCBvbiA1R0h6DQo+IHVuZGVyIHRoZSBzYW1lIGNvbmRpdGlvbnM7IG5vdCByZXBy
b2R1Y2VkIG9uIDIuNEdIeiB1bmRlciBrZXJuZWwgNy4wLjEyLg0KPiBBZGRpdGlvbmFsIGluZm86
DQo+IA0KPiBLZXJuZWwgNy4wLjEyIGlzIG5vIGxvbmdlciBpbnN0YWxsYWJsZSB2aWEgenlwcGVy
IGluIHRoZSBjdXJyZW50IFR1bWJsZXdlZWQgT1NTIHJlcG8sIHNvIEknbSBjdXJyZW50bHkNCj4g
dW5hYmxlIHRvIGRvIGZ1cnRoZXIgZGlyZWN0IEEvQiB0ZXN0aW5nIGFnYWluc3QgNy4wLjEyIC0g
dGhpcyByZXBvcnQgaXMgYmFzZWQgb24gdGVzdGluZyBkb25lIHdoaWxlDQo+IDcuMC4xMiB3YXMg
c3RpbGwgYXZhaWxhYmxlLiBJIHVuZGVyc3RhbmQgb2xkZXIgYnVpbGRzIG1heSBzdGlsbCBiZSBh
dmFpbGFibGUgdmlhDQo+IGRvd25sb2FkLm9wZW5zdXNlLm9yZy9oaXN0b3J5IGlmIGEgZnJlc2gg
Y29tcGFyaXNvbiBpcyBuZWVkZWQuDQo+IEknbSBoYXBweSB0byB0ZXN0IHBhdGNoZXMsIHJ1biBi
aXNlY3Rpb24gZ3VpZGFuY2UsIG9yIGdhdGhlciBhbnkgYWRkaXRpb25hbCBkZWJ1ZyBvdXRwdXQg
KGRlYnVnZnMsDQo+IGV0aHRvb2wgc3RhdHMsIGV0Yy4pIGlmIHRoYXQgd291bGQgaGVscCBuYXJy
b3cgdGhpcyBkb3duLg0KDQpUaGUgY29tbWl0IGJkYTI5NGVkMGVkMCAoIndpZmk6IHJ0dzg5OiBE
cm9wIG1hbGZvcm1lZCBBTVBEVSBmcmFtZXMgd2l0aCBhYm5vcm1hbCBQTiIpDQppbnRyb2R1Y2Vk
IGJ5IDcuMCB3aXRoIGEgYnVnLCBzbyB3ZSBoYXZlIGFub3RoZXIgY29tbWl0DQo2M2NjZGZhYzg2
NzcgKCJ3aWZpOiBydHc4OTogY29ycmVjdCBkcm9wIGxvZ2ljIGZvciBtYWxmb3JtZWQgQU1QRFUg
ZnJhbWVzIikNCnRvIGZpeCBpdC4gDQoNCkNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgNjNjY2RmYWM4
Njc3IHRvIDcuMS54PyANCg0KU2luY2UgSSBoYXZlIHJldmlld2VkIGNoYW5nZXMgYmV0d2VlbiA3
LjAgYW5kIDcuMSwgaWYgdGhlc2Ugc3VnZ2VzdGlvbnMNCmRvbid0IHdvcmssIHBsZWFzZSBoZWxw
IHRvIGJpc2VjdCB0aGUgY2F1c2UuIA0KDQpQaW5nLUtlDQoNCg==

