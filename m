Return-Path: <linux-wireless+bounces-33532-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD9oKD2cvGnW1QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33532-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:00:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE52D4895
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EDA30ADD66
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AC2175A7D;
	Fri, 20 Mar 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dHxALf81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCF40DFD4;
	Fri, 20 Mar 2026 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968442; cv=none; b=u2BQwWJaKGTrwYTfKkcvIeJssdR34bJyvrza1FbtF3IYgFiozJBi5m9vc6XsWlom8ZnWhK6ncpzCiDk4XRON+u3rhgMOQE6p3s1L2ZaS4g3s5lPWX3mFHr5NIyYCSiZEp1GY3ENMeE4GfGM6ovBHkpllKLjb8sFiX8KRTbnQJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968442; c=relaxed/simple;
	bh=j3b8Osuh2GjD/ycoMPivH/+pqzhtCWgJNWPZ8hc9MzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZP5KOwHEWopaFaLBxMGVqE1v31VzE2oUvgnWjAOEPOjGqI2/8oVZ4ngb5XTeFLf0paCFDCx49tAN/R9CsXf/Y6EG3Poy9BJ8VI6SjJlT32U16kQO5RbDzc5VjQ6s1IztQ+sH9mOChigwYSJhoFxWBsMw+e0WC4GvtK+nv0Uyvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dHxALf81; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62K10Y8f8556445, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773968434; bh=j3b8Osuh2GjD/ycoMPivH/+pqzhtCWgJNWPZ8hc9MzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dHxALf81Ag1IgrsuaTDdHbvPBhrmT8r+SZwwmEBYCb/R/B024hYXJgNfpTi89+xAt
	 MLzK2x8kjU8vCSook7h3StxUKV8Ly8VCjeGLktZxisveb1D3IVH28AR1AKGUmYHp0k
	 j79I4y2VsZv+cMWa080qWsKeEFhQMCFUHjgff0aC7ee/WCE1ZF7RsHL7HFPNKmclPt
	 aMUx4beDp25Q6Y6KcBr/J1gl2UgxoNcwFQ2rh19nZoURQIXq7f6E3TSll7iu97dz0X
	 H6hrT2HPvmKMKP64+JCeweRZ/x7RoYe8H9pel/59mnxEC0SXOd4mVNyXE5bdAzCG11
	 Ynyaz+0a2z2NA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62K10Y8f8556445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 09:00:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 20 Mar 2026 09:00:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 20 Mar 2026 09:00:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 20 Mar 2026 09:00:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMIAA+6oAgACVvSCAAP1VgIAAC/kAgACJQ/A=
Date: Fri, 20 Mar 2026 01:00:35 +0000
Message-ID: <b231d63665334ac786e808610fe4a1e9@realtek.com>
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
 <1bd495ffe57c47eb827eec084729afa2@realtek.com>
 <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com>
 <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
 <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
In-Reply-To: <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-33532-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3BE52D4895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gTm90IHN1cmUgd2hhdCBoYXJkd2FyZSBnZXQgd3Jvbmcu
IExldCdzIHZhbGlkYXRlIHJhdGUgd2hlbiByZWFkaW5nDQo+ID4gZnJvbSBoYXJkd2FyZS4NCj4g
DQo+IEhpIFBpbmctS2UsDQo+IA0KPiBPbmUgYWRkaXRpb25hbCBvYnNlcnZhdGlvbiB3aGlsZSBt
b25pdG9yaW5nIGxvZ3Mgd2l0aCB5b3VyIHJhdGUNCj4gdmFsaWRhdGlvbiBwYXRjaCBpbnN0YWxs
ZWQuDQo+IA0KPiBEdXJpbmcgbm9ybWFsIHVzYWdlIHdpdGggV2ktRmkgY29ubmVjdGVkIGFuZCBh
IEJsdWV0b290aCBBMkRQIGRldmljZQ0KPiBjb25uZWN0aW5nIHRvIHRoZSBzeXN0ZW0sIHRoZSBm
b2xsb3dpbmcgbWVzc2FnZSBhcHBlYXJlZCBpbiBkbWVzZzoNCj4gDQo+ICAgWzE4MC40MjAwMDBd
IHJ0d184ODIxY2UgMDAwMDoxMzowMC4wOiB1bnVzZWQgcGh5IHN0YXR1cyBwYWdlICgxMSkNCj4g
DQo+IExvb2tpbmcgYXQgcnR3X3J4X2ZpbGxfcGh5X2luZm8oKSBpbiByeC5jLCB0aGlzIG1lc3Nh
Z2UgaXMgZW1pdHRlZA0KPiB3aGVuIHRoZSBmaXJtd2FyZSBzZW5kcyBhIFBIWSBzdGF0dXMgcmVw
b3J0IHdpdGggYSBwYWdlIG51bWJlciB0aGF0DQo+IHRoZSBkcml2ZXIgZG9lcyBub3QgcmVjb2du
aXplLiBJbiB0aGlzIGNhc2UgcGFnZSAxMSBhcHBlYXJlZCBhdCB0aGUNCj4gbW9tZW50IHRoZSBC
bHVldG9vdGggZGV2aWNlIHdhcyBlc3RhYmxpc2hpbmcgaXRzIGNvbm5lY3Rpb24uDQoNCkl0IHNl
ZW1zIGxpa2UgaGFyZHdhcmUgcmVwb3J0cyBpbmNvcnJlY3QgYWJvdXQgdGhlIFBIWSBzdGF0dXMs
IHdoaWNoDQpvbmx5IDAgb3IgMSBpcyBleHBlY3RlZC4gSSBkb24ndCBrbm93IGhvdyBpdCBjb3Vs
ZCBiZS4gTWF5YmUsIHdlDQpjYW4gaWdub3JlIHRoaXMgbWVzc2FnZSwgb3IgY2hhbmdlIGl0IHRv
IGRlYnVnIGxldmVsIGlmIGl0IGFwcGVhcnMNCmZyZXF1ZW50bHkgYW5kIHlvdSBkb24ndCB3YW50
IHRvIHNlZSBpdC4NCg0KPiANCj4gV2UgaGF2ZSBub3Qgb2JzZXJ2ZWQgYW55IHN0YWJpbGl0eSBp
c3N1ZXMgb3IgY29ubmVjdGl2aXR5IGRyb3BzDQo+IGFzc29jaWF0ZWQgd2l0aCB0aGlzIG1lc3Nh
Z2UgLS0gdGhlIGRyaXZlciBhcHBlYXJzIHRvIGhhbmRsZSBpdA0KPiBncmFjZWZ1bGx5IGJ5IGln
bm9yaW5nIGl0LiBXZSBhcmUgbm90IHN1cmUgd2hldGhlciB0aGlzIGlzIHJlbGF0ZWQNCj4gdG8g
dGhlIHJhdGU9MHg2NSBpc3N1ZSBvciBpcyBzaW1wbHkgYSBzZXBhcmF0ZSBhcnRpZmFjdCBvZiBC
VC9XaS1GaQ0KPiBjb2V4aXN0ZW5jZSBvbiB0aGlzIGNoaXAuIFdlIHdhbnRlZCB0byBtZW50aW9u
IGl0IGluIGNhc2UgaXQgaXMNCj4gdXNlZnVsIGNvbnRleHQuDQoNClR3byBtZXNzYWdlcyBsb29r
IGxpa2UgaGFyZHdhcmUgZ29lcyB3ZWlyZC4gVGhlIHJlcG9ydCB2YWx1ZXMgYmVjb21lDQp1bnBy
ZWRpY3RhYmxlLiBNYXliZSB3ZSBuZWVkIG1vcmUgdmFsaWRhdGlvbi4uLi4gSG93ZXZlciwgZHJp
dmVyDQp3aWxsIGJlY29tZSB2ZXJ5IGRpcnR5IHNpbmNlIEkgY2FuJ3QgY29uY2x1ZGUgYSBzaW5n
bGUgcnVsZSB0bw0KYWRkcmVzcyB0aGVtLg0KDQpQaW5nLUtlDQoNCg==

