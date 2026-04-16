Return-Path: <linux-wireless+bounces-34865-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO6KJXQ44GmDdgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34865-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 03:16:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4704096AB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 03:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19F45301A911
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F81A0BF1;
	Thu, 16 Apr 2026 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HIXMvazY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13013B58C;
	Thu, 16 Apr 2026 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302136; cv=none; b=bwQYLLGxl/Ka1UWl+jFEP2VI9WVvbnOmcDZ8qvIedWb1Bkghidk7g6vhFNDJaChhLkGMdtqvKJcqgln9XwDQqiV/mJnnVxXqhsXUf/EeZ22nTMJcTTA2meC5mo1To30BAB86Um7/V1QbhsBSRhZQlZb/9iFZOdTPWddWCGyEifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302136; c=relaxed/simple;
	bh=6rpIlthnziVf8Ug3AExWRV5iyYSRGsSymSZYaibhPOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nxcF3Xgh+qsVnVJ8sTDd5jkhRJrjwLqHl9knOAMkXgRSkUvAxuoc4l4cJE3NTs0IwxF3pE0DvnqZqODUVvNdXLTpHWQNqSmOqePhaJS2IYi5/Y4vr1y1PqVW997pk8/ObEh3M0iuggH+bNOyPJpyeh/CoGuu+ZPzJRxHw7YaCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HIXMvazY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63G1FUCw8966965, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776302130; bh=6rpIlthnziVf8Ug3AExWRV5iyYSRGsSymSZYaibhPOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HIXMvazYW/Se4IblR6JfCBj7ZGwP3Li091IRfcuAH2UfriwEE/zjjBUXUAjlmLYck
	 5dJ+3Ye+qB7PY1yWz/0JrZj5FeRdOSYBKve1GQc5w8xx2JY5ACxU8sZQhD4K2dS6OX
	 e9RQM56g8INmaWEGltPMLWlJhkEYPCodC3rXOykL51m3k/V4Q1Zi2fqiXtjQ+lszor
	 tyRVqG6SC5+/XwcpPwzUhwAZgs2N3O37E0sTKEBm9X/rcbTbEZjnEeybQA0gV56mUs
	 SbO1PcuE6yRoiflLpUA97eRQ/3Fa7gtkmdmFTXieSmd23at8i+i6iwwFhrufEb98VR
	 dlunS2WU4ttww==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63G1FUCw8966965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 09:15:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 16 Apr 2026 09:15:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Thu, 16 Apr 2026 09:15:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Louis Kotze <loukot@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: phy: increase RF calibration timeouts for
 USB transport
Thread-Topic: [PATCH v2] wifi: rtw89: phy: increase RF calibration timeouts
 for USB transport
Thread-Index: AQHczMj0YKDOnI/XvkW6agjVe6FnpbXg4Rdg
Date: Thu, 16 Apr 2026 01:15:30 +0000
Message-ID: <1a90ff00d83c47b995cf75165b2a304b@realtek.com>
References: <20260410080017.82946-1-loukot@gmail.com>
 <20260415111339.453602-1-loukot@gmail.com>
In-Reply-To: <20260415111339.453602-1-loukot@gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34865-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E4704096AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TG91aXMgS290emUgPGxvdWtvdEBnbWFpbC5jb20+IHdyb3RlOg0KPiBVU0IgdHJhbnNwb3J0IGFk
ZHMgc2lnbmlmaWNhbnQgbGF0ZW5jeSB0byBIMkMvQzJIIHJvdW5kLXRyaXBzIHVzZWQNCj4gYnkg
UkYgY2FsaWJyYXRpb24uIFRoZSBleGlzdGluZyB0aW1lb3V0IHZhbHVlcyB3ZXJlIGRlc2lnbmVk
IGZvciBQQ0llDQo+IGFuZCBhcmUgdG9vIHRpZ2h0IGZvciBVU0IsIGNhdXNpbmcgImZhaWxlZCB0
byB3YWl0IFJGIERBQ0siLA0KPiAiZmFpbGVkIHRvIHdhaXQgUkYgVFNTSSIgYW5kIHNpbWlsYXIg
ZXJyb3JzIG9uIFVTQiBhZGFwdGVycy4NCj4gDQo+IEFwcGx5IGEgNHggdGltZW91dCBtdWx0aXBs
aWVyIHdoZW4gdGhlIGRldmljZSB1c2VzIFVTQiB0cmFuc3BvcnQuDQo+IFRoZSBtdWx0aXBsaWVy
IGlzIGFwcGxpZWQgaW4gcnR3ODlfcGh5X3Jma19yZXBvcnRfd2FpdCgpIHNvIGFsbA0KPiBjYWxp
YnJhdGlvbnMgYmVuZWZpdCB3aXRob3V0IGNoYW5naW5nIGFueSBjYWxsIHNpdGVzIG9yIFBDSWUN
Cj4gdGltZW91dCB2YWx1ZXMuDQo+IA0KPiBUaGUgNHggbXVsdGlwbGllciB3YXMgY2hvc2VuIGJh
c2VkIG9uIG1lYXN1cmVkIGRhdGEgZnJvbSB0d28NCj4gaW5kZXBlbmRlbnQgdGVzdGVycyAoUlRM
ODkyMkFVLCA2R0h6IE1MTyBhbmQgMi40LzVHSHopOg0KPiANCj4gICBDYWxpYnJhdGlvbiAgIFBD
SWUgdGltZW91dCAgIE1heCBtZWFzdXJlZCAoVVNCKSAgIDR4IHRpbWVvdXQNCj4gICBQUkVfTlRG
WSAgICAgICAgICAgNW1zICAgICAgICAgICAgICAxbXMgICAgICAgICAgICAgIDIwbXMNCj4gICBE
QUNLICAgICAgICAgICAgICA1OG1zICAgICAgICAgICAgIDcybXMgICAgICAgICAgICAgMjMybXMN
Cj4gICBSWF9EQ0sgICAgICAgICAgIDEyOG1zICAgICAgICAgICAgMzc0bXMgICAgICAgICAgICAg
NTEybXMNCj4gICBUU1NJIG5vcm1hbCAgICAgICAyMG1zICAgICAgICAgICAgIDI0bXMgICAgICAg
ICAgICAgIDgwbXMNCj4gICBUU1NJIHNjYW4gICAgICAgICAgNm1zICAgICAgICAgICAgIDE0bXMg
ICAgICAgICAgICAgIDI0bXMNCj4gICBUWEdBUEsgICAgICAgICAgICA1NG1zICAgICAgICAgICAg
IDE4bXMgICAgICAgICAgICAgMjE2bXMNCj4gICBJUUsgICAgICAgICAgICAgICA4NG1zICAgICAg
ICAgICAgIDUzbXMgICAgICAgICAgICAgMzM2bXMNCj4gICBEUEsgICAgICAgICAgICAgICAzNG1z
ICAgICAgICAgICAgIDMwbXMgICAgICAgICAgICAgMTM2bXMNCj4gDQo+IFRlc3RlZCB3aXRoIFJU
TDg5MjJBVSBvbiA2R0h6IE1MTyAoNUdIeiArIDZHSHogc2ltdWx0YW5lb3VzKToNCj4gMjUgY29u
bmVjdC9kaXNjb25uZWN0IGN5Y2xlcyB3aXRoIHplcm8gZmFpbHVyZXMuDQo+IA0KPiBJbiByZXNw
b25zZSB0byByZXZpZXcgZmVlZGJhY2sgb24gdjEsIA0KDQpDYW4gd2UgcmVtb3ZlIHRoaXMgcGhy
YXNlPyBObyBuZWVkIHRvIG1lbnRpb24gdjEgaW4gY29tbWl0IG1lc3NhZ2UuIA0KDQo+IHRoZSA0
eCBtdWx0aXBsaWVyIHdhcyBhbHNvDQo+IHJlLXZlcmlmaWVkIHVuZGVyIGFkdmVyc2UgaG9zdCBj
b25kaXRpb25zIG9uIDVHSHouIDUgY3ljbGVzIHBlcg0KPiBzY2VuYXJpbywgc3RyZXNzLW5nIGFz
IHRoZSBsb2FkIGdlbmVyYXRvciwgbWF4IG9ic2VydmVkIHRpbWUgcGVyDQo+IGNhbGlicmF0aW9u
Og0KPiANCj4gICBDYWxpYnJhdGlvbiAgUENJZSAgNHggICBCYXNlbGluZSAgQ1BVIHN0cmVzcyAg
TWVtIHN0cmVzcyAgQ29tYmluZWQNCj4gICBQUkVfTlRGWSAgICAgICA1ICAgMjAgICAgIDAgICAg
ICAgICAwICAgICAgICAgICAwICAgICAgICAgICAxDQo+ICAgREFDSyAgICAgICAgICA1OCAgMjMy
ICAgIDcxICghKSAgICA3MSAoISkgICAgICA3MSAoISkgICAgICA3MSAoISkNCj4gICBSWF9EQ0sg
ICAgICAgMTI4ICA1MTIgICAgMjMgICAgICAgIDIyICAgICAgICAgIDIyICAgICAgICAgIDIzDQo+
ICAgSVFLICAgICAgICAgICA4NCAgMzM2ICAgIDUzICAgICAgICA1MyAgICAgICAgICA1MyAgICAg
ICAgICA1Mw0KPiAgIERQSyAgICAgICAgICAgMzQgIDEzNiAgICAyMyAgICAgICAgMjMgICAgICAg
ICAgMjYgICAgICAgICAgMjMNCj4gICBUU1NJICAgICAgICAgIDIwICAgODAgICAgIDYgICAgICAg
ICA5ICAgICAgICAgIDE0ICAgICAgICAgICA5DQo+ICAgVFhHQVBLICAgICAgICA1NCAgMjE2ICAg
IDE2ICAgICAgICAxNiAgICAgICAgICAxNiAgICAgICAgICAxNg0KPiANCj4gTGVnZW5kOiAoISkg
PSBleGNlZWRzIFBDSWUgYnVkZ2V0IGJ1dCB3aXRoaW4gNHggYnVkZ2V0Lg0KPiANCj4gVHdvIG9i
c2VydmF0aW9ucyBmcm9tIHRoYXQgbWF0cml4Og0KPiANCj4gMS4gREFDSyBleGNlZWRzIHRoZSBz
dG9jayBQQ0llIGJ1ZGdldCAoNThtcykgaW4gYmFzZWxpbmUgb24gNUdIeg0KPiAgICBvbiB0aGlz
IGhhcmR3YXJlLiBXaXRob3V0IHRoZSA0eCBtdWx0aXBsaWVyLCBEQUNLIGZhaWxzDQo+ICAgIC1F
VElNRURPVVQgZGV0ZXJtaW5pc3RpY2FsbHkgb24gZXZlcnkgY29ubmVjdCwgbm8gc3RyZXNzDQo+
ICAgIG5lZWRlZC4gVGhpcyBpcyB0aGUgc3BlY2lmaWMgYnVnIHRoZSBwYXRjaCBmaXhlcy4NCg0K
SSdtIG5vdCBzdXJlIHRoaXMgc2hvdWxkIGJlIGNhbGxlZCAiYnVnIiwgYXMgQml0dGVyYmx1ZSBo
YXMgbm90IGFkanVzdGVkDQp0aGVzZSB0aW1lb3V0IHRpbWUgYnkgZWFybGllciB2ZXJzaW9uLiAN
Cg0KPiANCj4gMi4gQ2FsaWJyYXRpb24gdGltZXMgYXJlIEkvTyBib3VuZCAoVVNCIEgyQy9DMkgg
cm91bmQtdHJpcA0KPiAgICBsYXRlbmN5KSwgDQoNCkknbSBhbHNvIG5vdCBzdXJlIGlmIHRoaXMg
aXMgY29ycmVjdC4gVGhlIGNhbGlicmF0aW9uIHRpbWUgb2YgREFDSyBtaWdodA0KcmVseSBvbiBX
aUZpIGhhcmR3YXJlIGFuZCBleHRlcm5hbCBjb21wb25lbnRzLCBub3Qgb25seSBJL08gc3BlZWQu
IA0KDQo+IG5vdCBDUFUgb3IgbWVtb3J5IGJvdW5kLiBEQUNLIHN0YXlzIGF0IDcxbXMgYWNyb3Nz
DQo+ICAgIGFsbCBmb3VyIHNjZW5hcmlvcy4gSG9zdC1zaWRlIHN0cmVzcyBoYXMgZXNzZW50aWFs
bHkgemVybw0KPiAgICBlZmZlY3Qgb24gb2JzZXJ2ZWQgY2FsaWJyYXRpb24gZHVyYXRpb24uIEJ1
bXBpbmcgdGhlDQo+ICAgIG11bHRpcGxpZXIgYWJvdmUgNHggd291bGQgbm90IGFkZHJlc3MgYSBm
YWlsdXJlIG1vZGUgdGhhdA0KPiAgICB0aGlzIHN0cmVzcyBtYXRyaXggcHJvZHVjZXMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBMb3VpcyBLb3R6ZSA8bG91a290QGdtYWlsLmNvbT4NCg0KT3RoZXJ3
aXNlLCBwYXRjaCBjb250ZW50IGxvb2tzIGdvb2QgdG8gbWUuDQoNCkFja2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

