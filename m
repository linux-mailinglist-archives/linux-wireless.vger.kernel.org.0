Return-Path: <linux-wireless+bounces-33268-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sITyFEVxt2n8RAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33268-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:56:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1964294493
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A414300FC7F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 02:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12F31E106;
	Mon, 16 Mar 2026 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aff7WXGo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D931D74B;
	Mon, 16 Mar 2026 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773629762; cv=none; b=LlLNYPbscM3m4ZKy9D8udancGjyMJsYIDrcFR66Uu4zpPomOV62TH/0zWBiKlMyDHOw4T2KYSM1ByS8Zq6GQPolgVlehK2V8ronH6xSR1E+85Dv4c8yURUqrkAlExA3Sezx9pSQKCMG8YnMOYLsnXz9yOk9crHKqGNFngH6Pcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773629762; c=relaxed/simple;
	bh=t9EMOkpUKCB5lgpkLVheDOaYvd0pKe2yXYxER1IPvoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNpkr97F30WGCEbKmGuiFw2lvmSMCmSW4qf4zmxThPyXm4V0o407UazB4a1qs7iz1e10i661n6WE4ppWD3DppsHgFNavUAZhsOywI7Gf65JZUnyqOpiZCfQ8s6yBRA9bt9sDcr0K4Tv70y8iaDirkukc0DZmeIxZbj5NO2WIEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aff7WXGo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G2tvIiB1056371, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773629757; bh=t9EMOkpUKCB5lgpkLVheDOaYvd0pKe2yXYxER1IPvoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aff7WXGoJ4/CHheQsoquHaGqYA/V5MEi8ESUvAxB9M0fKO2DkVPdfmjdILgPWXpsU
	 JNfKQptUr2/23H0MWVF/oWOafnMIaTJqC3R/t05PzrsKJOIitIIvwKLF1QeEO19rCd
	 usHgzv6ELg+6VfI9zx+OQOs7/XWLuyTnr1uOr25jKcbyZm+npGbXJwneXvO2bYMVYv
	 YTmdCmwzTXkzzfIyvzxmvJHBjsBAfK5kKNszWBFMAg1H4vRiOHGF1Eooi2XbtnuaLI
	 BvxlHpHZmUy5UUlJ0hyZ3Mf26l4nkOFFePgHhWvaXvT+f0IuFZFP7vXj6EjB5uC3GS
	 hN23h2ZdsCScQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G2tvIiB1056371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 10:55:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 10:55:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 16 Mar 2026 10:55:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiA=
Date: Mon, 16 Mar 2026 02:55:57 +0000
Message-ID: <1bd495ffe57c47eb827eec084729afa2@realtek.com>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com>
 <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com>
 <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com>
 <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
In-Reply-To: <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-33268-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1964294493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT2xla3NhbmRyIEhhdnJ5bG92
IDxnb2FpbndvQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gQWZ0ZXIgZXh0ZW5kZWQgdGVzdGluZyB3
aXRoIHlvdXIgRE1JIHBhdGNoIGFwcGxpZWQsIHRoZSBoYXJkIGZyZWV6ZSBpcw0KPiA+IGdvbmUu
IEhvd2V2ZXIsIHdpdGggQVNQTSBkaXNhYmxlZCBidXQgTFBTIERlZXAgc3RpbGwgYWN0aXZlLCBJ
IG9ic2VydmUNCj4gPiBwZXJpb2RpYyBoMmMgdGltZW91dHMgZHVyaW5nIGlkbGUgd2hpY2ggY2F1
c2Ugb2NjYXNpb25hbCBXaUZpIHRocm91Z2hwdXQNCj4gPiBkcm9wcyBhbmQgQmx1ZXRvb3RoIGF1
ZGlvIHN0dXR0ZXJpbmcuIFdoZW4gSSBhZGRpdGlvbmFsbHkgc2V0DQo+ID4gZGlzYWJsZV9scHNf
ZGVlcD1ZLCBhbGwgc3ltcHRvbXMgZGlzYXBwZWFyIGNvbXBsZXRlbHkuIFRoaXMgY29uZmlybXMN
Cj4gPiB0aGF0IGNvbWJpbmluZyB0aGUgQVNQTSBxdWlyayB3aXRoIGR5bmFtaWMgTFBTX0RFRVBf
TU9ERV9OT05FIHdvdWxkIGJlDQo+ID4gdGhlIGNvbXBsZXRlIGZpeC4gUmVhZHkgdG8gdGVzdCBh
biB1cGRhdGVkIHBhdGNoIGlmIHlvdSBkZWNpZGUgdG8NCj4gPiBpbmNsdWRlIHRoaXMuDQo+IA0K
PiBIaSBQaW5nLUtlLA0KPiANCj4gV2hpbGUgbW9uaXRvcmluZyBsb2dzIHdpdGggdGhlIGN1cnJl
bnQgcGF0Y2ggYXBwbGllZCwgSSBub3RpY2VkIHR3bw0KPiB0aGluZ3MgdGhhdCBtaWdodCBiZSB1
c2VmdWwuDQo+IA0KPiBGaXJzdCwgdGhlIGZvbGxvd2luZyBtZXNzYWdlIGFwcGVhcnMgZWFjaCB0
aW1lIHRoZSBkcml2ZXIgbG9hZHM6DQo+IA0KPiAgIHJ0dzg4Xzg4MjFjZSAwMDAwOjEzOjAwLjA6
IGNhbid0IGRpc2FibGUgQVNQTTsgT1MgZG9lc24ndCBoYXZlIEFTUE0gY29udHJvbA0KPiANCj4g
VGhpcyBzdWdnZXN0cyB0aGUgQklPUyByZXRhaW5zIGNvbnRyb2wgb3ZlciBBU1BNIGFuZCBwcmV2
ZW50cyBhbnkNCj4gT1MtbGV2ZWwgb3ZlcnJpZGUgdmlhIHBjaV9kaXNhYmxlX2xpbmtfc3RhdGUo
KS4gVGhlIHN5c3RlbSByZW1haW5zDQo+IHN0YWJsZSByZWdhcmRsZXNzLCB3aGljaCBjb25maXJt
cyB0aGF0IHRoZSBydHdfcGNpX2Rpc2FibGVfYXNwbSBmbGFnDQo+IGFwcHJvYWNoIGluIHlvdXIg
cGF0Y2ggaXMgdGhlIGNvcnJlY3QgYW5kIGVmZmVjdGl2ZSBtZXRob2QgaGVyZS4NCg0KTm90IHN1
cmUgaWYgdGhpcyBpcyBiZWNhdXNlIFBDSUUgYnJpZGdlIGhhcyBubyBBU1BNIGNhcGFiaWxpdHk/
DQoNCj4gDQo+IFNlY29uZCwgZHVyaW5nIG5vcm1hbCBvcGVyYXRpb24gSSBvYnNlcnZlIHRoaXMg
d2FybmluZyBwZXJpb2RpY2FsbHk6DQo+IA0KPiAgIFdBUk5JTkc6IG5ldC9tYWM4MDIxMS9yeC5j
OjU0OTEgYXQgaWVlZTgwMjExX3J4X2xpc3QrMHgxNzcvMHgxMDIwIFttYWM4MDIxMV0NCg0KTE41
NDkxIChrZXJuZWwgdjYuMTkuNikgaXM6DQoNCiAgICAgICAgICAgICAgICBjYXNlIFJYX0VOQ19W
SFQ6DQogICAgICAgICAgICAgICAgICAgICAgICBpZiAoV0FSTl9PTkNFKHN0YXR1cy0+cmF0ZV9p
ZHggPiAxMSB8fA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhc3RhdHVz
LT5uc3MgfHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzLT5u
c3MgPiA4LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiUmF0ZSBtYXJr
ZWQgYXMgYSBWSFQgcmF0ZSBidXQgZGF0YSBpcyBpbnZhbGlkOiBNQ1M6ICVkLCBOU1M6ICVkXG4i
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMtPnJhdGVfaWR4
LCBzdGF0dXMtPm5zcykpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZHJv
cDsNCiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KDQpMb29rcyBsaWtlIGRyaXZlciBy
ZXBvcnRzIGltcHJvcGVyIFZIVCBuc3MvcmF0ZT8gQnV0IHRoaXMgd2FybnMgb25jZSwgYW5kDQp5
b3UgbWVzc2FnZSBpc24ndCBsaWtlIHRoaXMuIA0KDQpDb3VsZCB5b3UgY2hlY2sgdGhlIHNvdXJj
ZSBjb2RlIExONTQ5MSB5b3UgYXJlIHVzaW5nPw0KDQpQaW5nLUtlDQoNCg0K

