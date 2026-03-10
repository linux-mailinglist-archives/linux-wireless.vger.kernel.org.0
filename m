Return-Path: <linux-wireless+bounces-32803-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIFUN5Z9r2kXZwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32803-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 03:10:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA17244109
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 03:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D7E30E8AE6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382722F83AC;
	Tue, 10 Mar 2026 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GEbK0R2j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F202E973A;
	Tue, 10 Mar 2026 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108174; cv=none; b=e+UK5Sy4xXQYFHu8ucWZ2VFykE8YOLh0xV0pfPwF/RIRxYoSJQoUngExd0fQ1dT90ckUHO2Je2ML/bT0bXTyvXL9lxVFJ6+6d26o3vVllKvmkB6I0DcZozKstJcVXipAWYb9/LUV4Q9+sBS9mSesr4mImE/9/WD8X1Nj7TuWtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108174; c=relaxed/simple;
	bh=51fo2dT4oK7P/ktJvDV4VlfWJxRukdDZPGMcQIMcd9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqLFagMZ4CZZ0j3+kYaELxGPxSSeawP0HESnfNzaSXJLAEi5dxdeIcpVKzO9azM87hA22S7A2POU50ivYnuACWZBCvTO0SvSTarr3MGPHvJ3Zw98ccU0d9PFTu2juG7mMBAmZB5gHQjX4zRuJG7l9uFJR9nDGNIgaAoQFoWsOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GEbK0R2j; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A22mrdE1666025, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773108168; bh=51fo2dT4oK7P/ktJvDV4VlfWJxRukdDZPGMcQIMcd9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GEbK0R2jYxah9voj1WJ2p6EurxUzzKWl3cgWp5xrq+uv3cSwla4eAbqafGpSz35hr
	 6OydzB34xC91ry+rjbmPz3TUKTPGeo+wM8vsimd1r49TpezNx2FcKCnw8vDJcKg7CD
	 YyHEUcRgWeJ97rnLeoXLQ9w9GLbu8WW7y/x3sdtCwUrr7vnuEgPQ1QUqCbmXwm12Hy
	 mjCrcaNHsGPSCk15mCLXbUqf+K9wxDfWWc5h3zr1N2yofQ6GGXVwus+pOh8VzjRd8H
	 Ma7EbDXyj7u57ebLcd3tksbYZdUnXtkcqntbFaxCJJE74KkelBFPDJ+8r4yVq2H5KI
	 wVTmBivNUYIyA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A22mrdE1666025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 10:02:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 10:02:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 10 Mar 2026 10:02:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9w
Date: Tue, 10 Mar 2026 02:02:47 +0000
Message-ID: <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
In-Reply-To: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: 5AA17244109
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32803-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Action: no action

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBIaSBQaW5nLUtlLA0KPiANCj4gSSBh
bSB3cml0aW5nIHRvIGZvcm1hbGx5IHJlcG9ydCBhIGNyaXRpY2FsIGJ1ZyB0aGF0IGNhdXNlcyBh
IGhhcmQNCj4gc3lzdGVtIGZyZWV6ZSBvbiBsYXB0b3BzIGVxdWlwcGVkIHdpdGggdGhlIFJUTDg4
MjFDRSBXaUZpIG1vZHVsZSwgYW5kDQo+IHRvIHByb3Bvc2Ugc29sdXRpb25zLg0KPiANCj4gRGVz
Y3JpcHRpb246DQo+IE9uIGFuIEhQIGxhcHRvcCBlcXVpcHBlZCB3aXRoIGEgUmVhbHRlayBSVEw4
ODIxQ0UgODAyLjExYWMgUENJZQ0KPiBhZGFwdGVyIChQQ0kgSUQ6IDEwZWM6YzgyMSksIHRoZSBz
eXN0ZW0gZXhwZXJpZW5jZXMgYSBoYXJkIGxvY2t1cA0KPiAoY29tcGxldGUgZnJlZXplIG9mIHRo
ZSBVSSBhbmQga2VybmVsLCBzeXNycSBkb2Vzbid0IHdvcmssIHJlcXVpcmVzDQo+IGhvbGRpbmcg
dGhlIHBvd2VyIGJ1dHRvbikgd2hlbiB0aGUgV2lGaSBhZGFwdGVyIGVudGVycyB0aGUgcG93ZXIN
Cj4gc2F2aW5nIHN0YXRlLg0KPiANCj4gVGhpcyBpc3N1ZSBvY2N1cnMgY29uc2lzdGVudGx5IGFj
cm9zcyBtdWx0aXBsZSBMaW51eCBkaXN0cmlidXRpb25zIGFuZA0KPiBrZXJuZWwgdmVyc2lvbnMg
KHJlcHJvZHVjZWQgb24gdXBzdHJlYW0ga2VybmVsIDYuMTMgYW5kIDYuMTktcmMpLg0KPiANCj4g
U3RlcHMgdG8gUmVwcm9kdWNlOg0KPiAxLiBVc2UgYSBzeXN0ZW0gd2l0aCBSVEw4ODIxQ0UgKHBj
aToxMGVjOmM4MjEpLg0KPiAyLiBFbnN1cmUgTmV0d29ya01hbmFnZXIgaXMgY29uZmlndXJlZCB3
aXRoIHdpZmkucG93ZXJzYXZlID0gMyAob3INCj4gcG93ZXIgc2F2aW5nIGlzIGVuYWJsZWQgdmlh
IFRMUC9pdykuDQo+IDMuIENvbm5lY3QgdG8gYSBXaUZpIG5ldHdvcmsgYW5kIGxldCB0aGUgc3lz
dGVtIGlkbGUuDQo+IDQuIFRoZSBzeXN0ZW0gd2lsbCBldmVudHVhbGx5IGZyZWV6ZSBjb21wbGV0
ZWx5Lg0KDQpDYW4geW91IGRpZyBrZXJuZWwgbG9nIChieSBuZXRjb25zb2xlIG9yIHJhbW9vcHMp
IGlmIHNvbWV0aGluZyB1c2VmdWw/DQpJJ2QgbGlrZSB0byBrbm93IHRoaXMgaXMgaGFyZHdhcmUg
bGV2ZWwgZnJlZXplIG9yIGtlcm5lbCBjYW4gY2FwdHVyZQ0Kc29tZXRoaW5nIHdyb25nLiANCg0K
PiANCj4gV29ya2Fyb3VuZHMgdGhhdCBzdWNjZXNzZnVsbHkgcHJldmVudCB0aGUgZnJlZXplOg0K
PiAqIFBhc3NpbmcgZGlzYWJsZV9scHNfZGVlcD15IHRvIHJ0dzg4X2NvcmUuDQo+ICogUGFzc2lu
ZyBkaXNhYmxlX2FzcG09eSB0byBydHc4OF9wY2kgKG9yIHBjaWVfYXNwbT1vZmYpLg0KPiAqIERp
c2FibGluZyBXaUZpIHBvd2VyIHNhdmUgdmlhIE5ldHdvcmtNYW5hZ2VyLg0KDQpBcmUgdGhlc2Ug
dG90YWxseSBuZWVkZWQgdG8gd29ya2Fyb3VuZCB0aGUgcHJvYmxlbT8gT3IgZGlzYWJsZV9hc3Bt
IGlzDQplbm91Z2g/DQoNCkknZCBsaXN0IHRoZW0gaW4gb3JkZXIgb2YgcG93ZXIgY29uc3VtcHRp
b24gaW1wYWN0OiAodGhlIHRvcG1vc3QgaXMgbG93ZXIgaW1wYWN0KQ0KICAxLiBkaXNhYmxlX2Fz
cG09eQ0KICAyLiBkaXNhYmxlX2xwc19kZWVwPXkNCiAgMy4gZGlzYWJsZSBXaUZpIHBvd2VyIHNh
dmUNCg0KSWYgeW91IGNhbiBkbyBleHBlcmltZW50cyBvbiB5b3VyIHBsYXRmb3JtLCB3ZSBjYW4g
YmUgZWFzaWVyIHRvIGRlY2lkZQ0Kd2hpY2ggd29ya2Fyb3VuZHMgYXJlIGFkb3B0ZWQuDQoNCj4g
DQo+IFRlY2huaWNhbCBBbmFseXNpczoNCj4gVGhlIHJvb3QgY2F1c2UgYXBwZWFycyB0byBiZSBh
biB1bmhhbmRsZWQgcmFjZSBjb25kaXRpb24gb3IgaGFyZHdhcmUNCj4gYnVnIGJldHdlZW4gdGhl
IGFkYXB0ZXIncyBMb3cgUG93ZXIgU3RhdGUgKExQUykgRGVlcCBtb2RlDQo+IChMUFNfREVFUF9N
T0RFX0xDTEspIGFuZCB0aGUgUENJZSBBY3RpdmUgU3RhdGUgUG93ZXIgTWFuYWdlbWVudCAoQVNQ
TQ0KPiBMMSkgbWVjaGFuaXNtLg0KPiANCj4gV2hlbiB0aGUgZmlybXdhcmUgZHJvcHMgaW50byBM
UFNfREVFUF9NT0RFX0xDTEsgY29uY3VycmVudGx5IHdpdGggdGhlDQo+IFBDSWUgYnVzIGVudGVy
aW5nIEFTUE0gTDEsIHRoZSBjaGlwIGZhaWxzIHRvIGhhbmRsZSBQQ0llIFdha2UNCj4gc2lnbmFs
aW5nIGNvcnJlY3RseS4gV2hpbGUgdGhlcmUgaXMgYW4gZXhpc3Rpbmcgd29ya2Fyb3VuZCBpbg0K
PiBydHdfcGNpX25hcGlfcG9sbCAocGNpLmM6MTgwNikgdGhhdCBzZXRzIGBydHdwY2ktPnJ4X25v
X2FzcG0gPSB0cnVlYA0KPiBkdXJpbmcgTkFQSSBwb2xsIGZvciA4ODIxQ0UsIHRoaXMgcG9sbGlu
ZyB3cmFwcGVyIGlzIGluc3VmZmljaWVudC4gVGhlDQo+IGRlYWRsb2NrIG9mdGVuIG9jY3VycyBk
dXJpbmcgaWRsZSBzdGF0ZXMgd2hlbiBwb2xsaW5nIGlzbid0IGFjdGl2ZWx5DQo+IGRpc2FibGlu
ZyBBU1BNLCBidXQgdGhlIHN5c3RlbSBzdWRkZW5seSBuZWVkcyB0byB3YWtlIHRoZSByYWRpby4N
Cg0KYHJ0d3BjaS0+cnhfbm9fYXNwbSA9IHRydWVgIHdhcyBhbm90aGVyIHdvcmthcm91bmQgeWVh
cnMgYWdvIG9uIGNlcnRhaW4NCnBsYXRmb3JtLiBJJ2Qgc2F5IEFTUE0gaGFzIG1hbnkgaW50ZXJv
cGVyYWJpbGl0eSBwcm9ibGVtcywgZXZlbiB5ZWFycyBhZ28uDQoNCkJ1dCB3aGF0IGRvZXMgJ2Rl
YWRsb2NrJyBtZWFuPyBBcyBJIGtub3cgTkFQSSBwb2xsIGlzIHNjaGVkdWxlZCBieSBJU1IsDQph
bmQgZ29pbmcgdG8gcmVjZWl2ZSBwYWNrZXRzLiBUaGUgcnhfbm9fYXNwbSB3b3JrYXJvdW5kIGlz
IHRvIGZvcmNlbHkgdHVybg0Kb2ZmIEFTUE0gZHVyaW5nIHRoaXMgcGVyaW9kLiANCg0KPiANCj4g
UHJvcG9zZWQgU29sdXRpb25zOg0KPiBHaXZlbiB0aGF0IExQU19ERUVQX01PREVfTENMSyBzZWVt
cyBmdW5kYW1lbnRhbGx5IHVucmVsaWFibGUgb24gODgyMWNlDQo+IFBDSWUgdmFyaWFudHMgd2hl
biBwYWlyZWQgd2l0aCBzdGFuZGFyZCBXaW5kb3dzLWVyYSBBU1BNDQo+IGltcGxlbWVudGF0aW9u
cyBvbiBsYXB0b3BzIChIUCwgTGVub3ZvLCBBU1VTIGFyZSBhbGwgYWZmZWN0ZWQpLCB0aGUNCj4g
bW9zdCByb2J1c3Qgc29sdXRpb24gaXMgdG8gc3RyaXAgdGhlIHVuc3VwcG9ydGVkIGRlZXAgc2xl
ZXAgZmxhZyBmcm9tDQo+IHRoZSBoYXJkd2FyZSBzcGVjLg0KPiANCj4gYGBgZGlmZg0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIxYy5jDQo+IEBAIC0xOTk5
LDcgKzE5OTksNyBAQCBzdHJ1Y3QgcnR3X2NoaXBfaW5mbyBydHc4ODIxY19od19zcGVjID0gew0K
PiAuYnRfc3VwcG9ydGVkID0gdHJ1ZSwNCj4gLmZidGNfaGFzX2V4dF9jdHJsID0gdHJ1ZSwNCj4g
LmNvZXhfaW5mb19od19zdXBwb3J0ZWQgPSB0cnVlLA0KPiAtIC5scHNfZGVlcF9tb2RlX3N1cHBv
cnRlZCA9IEJJVChMUFNfREVFUF9NT0RFX0xDTEspLA0KPiArIC5scHNfZGVlcF9tb2RlX3N1cHBv
cnRlZCA9IDAsIC8qIERpc2FibGVkIGR1ZSB0byBBU1BNIEwxIGhhcmQgbG9ja3MgKi8NCj4gLmRw
a19zdXBwb3J0ZWQgPSB0cnVlLA0KPiAucHN0ZG1hX3R5cGUgPSBDT0VYX1BTVERNQV9GT1JDRV9M
UFNPRkYsDQo+IC5iZmVlX3N1cHBvcnQgPSBmYWxzZSwNCj4gYGBgDQo+IA0KPiBBbHRlcm5hdGl2
ZWx5LCBhIFBDSSBTdWJzeXN0ZW0tYmFzZWQgcXVpcmsgc2hvdWxkIGJlIGludHJvZHVjZWQgaW4N
Cj4gcnR3X3BjaV9hc3BtX3NldCgpIHRvIHJlZnVzZSBBU1BNIEJJVF9MMV9TV19FTiB0cmFuc2l0
aW9ucyBmb3INCj4gYWZmZWN0ZWQgaGFyZHdhcmUgSURzLCBzaW1pbGFyIHRvIGhvdyBDTEtSRVEg
aXNzdWVzIGFyZSBoYW5kbGVkIGZvcg0KPiA4ODIyQyB2aWEgZWZ1c2UtPnJmZV9vcHRpb24uDQoN
CkknZCBhZGQgYSBxdWlyayB0byB5b3VyIHBsYXRmb3Jtcywgc28gb3RoZXIgcGxhdGZvcm1zIGNh
biBzdGlsbCBoYXZlDQpiZXR0ZXIgcG93ZXIgY29uc3VtcHRpb24uIA0KDQo+IA0KPiBDcm9zcy1S
ZWZlcmVuY2UgQW5hbHlzaXMgb2Ygb3RoZXIgUlRMODgyMUNFIEJ1Z3M6DQo+IEFmdGVyIGFnZ3Jl
Z2F0aW5nIHJlY2VudCBvcGVuIGJ1ZyByZXBvcnRzIGZvciB0aGUgODgyMWNlIGNoaXAgb24NCj4g
QnVnemlsbGEgKGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZyksIGl0IGlzIGFwcGFyZW50IHRo
YXQgYWxtb3N0IGFsbA0KPiBvZiB0aGVtIGFyZSB2aWN0aW1zIG9mIHRoZSBleGFjdCBzYW1lIHVu
ZGVybHlpbmcgcmFjZSBjb25kaXRpb24uDQo+IDEuIEJ1ZyAyMTUxMzE6IFN5c3RlbSBmcmVlemUg
cHJlY2VkZWQgYnkgJ3BjaSBidXMgdGltZW91dCwgY2hlY2sgZG1hDQo+IHN0YXR1cycuIFdvcmth
cm91bmQgdXNlZDogZGlzYWJsZV9hc3BtPTEuDQo+IDIuIEJ1ZyAyMTk4MzA6IExvZyBzaG93cyAn
ZmlybXdhcmUgZmFpbGVkIHRvIGxlYXZlIGxwcyBzdGF0ZScgYW5kDQo+ICdmYWlsZWQgdG8gc2Vu
ZCBoMmMgY29tbWFuZCcuIEEgZGlyZWN0IHNtb2tpbmcgZ3VuIGZvciBMUFMgRGVlcCBtb2RlDQo+
IGZyZWV6aW5nLg0KPiAzLiBCdWcgMjE4Njk3ICYgQnVnIDIxNzQ5MTogRW5kbGVzcyAndGltZWQg
b3V0IHRvIGZsdXNoIHF1ZXVlJyBmbG9vZHMuDQo+IDQuIEJ1ZyAyMTc3ODEgJiBCdWcgMjE2Njg1
OiBSYW5kb20gZHJvcG91dHMgYW5kIGxvdyB3aXJlbGVzcyBzcGVlZC4NCj4gDQo+IEdpdmVuIHRo
ZSB2b2x1bWUgYW5kIGFnZSBvZiB0aGVzZSB1bnJlc29sdmVkIHJlcG9ydHMsIGRpc2FibGluZw0K
PiAubHBzX2RlZXBfbW9kZV9zdXBwb3J0ZWQgKG9yIHJlc3RyaWN0aW5nIEFTUE0gTDEpIHNwZWNp
ZmljYWxseSBmb3INCj4gMTBlYzpjODIxIGlzIGRlc3BlcmF0ZWx5IG5lZWRlZC4NCj4gDQo+IFN5
c3RlbSBJbmZvcm1hdGlvbjoNCj4gLSBIYXJkd2FyZTogSFAgTm90ZWJvb2sgKFNLVTogUDNTOTVF
QSNBQ0IsIEZhbWlseTogMTAzQ181MzM1S1YpDQo+IC0gQ1BVOiBJbnRlbCBDb3JlIGkzLTUwMDVV
DQo+IC0gV2lGaSBQQ0kgSUQ6IDEwZWM6YzgyMSwgU3Vic3lzdGVtOiAxMDNjOjgzMWENCj4gLSBL
ZXJuZWw6IDYuMTMgLyA2LjE5DQo+IC0gRHJpdmVyIG1vZHVsZTogcnR3ODhfODgyMWNlDQo+IA0K
PiBJIGFtIGhhcHB5IHRvIHRlc3QgYW55IHBhdGNoZXMgcHJvdmlkZWQgb3IgZm9ybWFsbHkgc3Vi
bWl0IHRoZSBwYXRjaA0KPiBhYm92ZSBpZiBtYWludGFpbmVycyBhZ3JlZSBpdCBpcyB0aGUgcmln
aHQgYXBwcm9hY2guIFRoYW5rIHlvdSENCg0KV2UgaGF2ZSBub3QgbW9kaWZpZWQgUlRMODgyMUNF
IGZvciBhIGxvbmcgdGltZSwgc28gSSdkIGFkZCB3b3JrYXJvdW5kDQp0byBzcGVjaWZpYyBwbGF0
Zm9ybSBhcyBtZW50aW9uZWQgYWJvdmUuIA0KDQpQaW5nLUtlDQoNCg==

