Return-Path: <linux-wireless+bounces-33442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IP+EzJIu2kliQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 01:49:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 550652C431A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 01:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D2E23002507
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D701F3D56;
	Thu, 19 Mar 2026 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HTe03mGZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED140DFB2;
	Thu, 19 Mar 2026 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881389; cv=none; b=lRn+HoqK7N1zZBDRGlLi2Db2f2cLuS9AnPBipjQG80GUVSXNapchaUm/wbIGfZw9/q1wpwrVw8bZcw3sbnp4VMazuygl9fvi1madcIbAvcM4xOxGJxLo5x7vfTvT9HdsELoXpY+tkDkJe2iGIC8CDBpfHE4MhM3TBrekLP2MDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881389; c=relaxed/simple;
	bh=SBK5K1jKJ4P0dbtMkTr7pHbYswyxwYh0VXbHjyvwiyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LIgqu4JeyV44ruX2o00HKqKIC8FvO9l2JtWadPlQCCsEBDwDGLJPMeWK+iWBgJ06u6EDGijFzugoapceXNNX+Wj1jMkYSr6SHiRt9tm1aRVtDMfqsFqZphX+z8IfTJPQ7TxFrlWSq0Wl1HiglBV8Mojcu8E6fCSJ3qx9PbKAmJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HTe03mGZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62J0ngZM32698014, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773881383; bh=SBK5K1jKJ4P0dbtMkTr7pHbYswyxwYh0VXbHjyvwiyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HTe03mGZKqeVrW9pyBhb4yjOSzvQX7qAP4REMZYuFkQ18pF+08hsrQq4Ph0hh2sT+
	 ct5wgYLa3HNXhEdCo+h+xSKtlIqYN62xqWltkAnaEYP5iYsd2PtwbK+7MzYZ1p2WNU
	 cl07EO0yNZSoIEHYQUJytCvIrAw4eHiQ2AnbrDkCLaz9LD+KnTrTjJzIe7ZwPzKW6b
	 TnCMXcAzJC1aG3vVqGB0a6EmqlTfw4619deihV6wMvToJu7PGpjtX4oKayHcRw4PN5
	 4zHRy8QQOvOIZIn6bdLVgIF5yjnPGGn0tQVTisbNv0x6B16i5dw37NoYkYTiD427BP
	 6/GmTXku59AtQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62J0ngZM32698014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 08:49:42 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 08:49:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 08:49:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 19 Mar 2026 08:49:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMIAA+6oAgAAHnYCAAIx7YA==
Date: Thu, 19 Mar 2026 00:49:43 +0000
Message-ID: <0709aa3f3d67430c8392537a489f3d36@realtek.com>
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
 <CALdGYqS-wYLsH8zuW-Kbd6OqEuwXOaBWLTupMD8tpekagj=jjA@mail.gmail.com>
In-Reply-To: <CALdGYqS-wYLsH8zuW-Kbd6OqEuwXOaBWLTupMD8tpekagj=jjA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33442-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 550652C431A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBIaSBQaW5nLUtlLA0KPiANCj4gSSBz
dWNjZXNzZnVsbHkgY29sbGVjdGVkIHRoZSBvdXRwdXQgd2l0aCB5b3VyIGRpYWdub3N0aWMgcHJp
bnRrLg0KPiANCj4gSGVyZSBpcyB0aGUgZXhhY3QgbG9nIGVudHJ5IHRyaWdnZXJlZCB3aGVuIHRo
ZSB3YXJuaW5nIGZpcmVzOg0KPiANCj4gWyAgMTgwLjQyNDE0Nl0gVkhUIE5TUz0wIHBrdF9zdGF0
LT5yYXRlPTB4NjUgcnhfc3RhdHVzLT5iYW5kPTENCj4gcnhfc3RhdHVzLT5yYXRlX2lkeD0wDQo+
IFsgIDE4MC40MjQxNTddIFdBUk5JTkc6IG5ldC9tYWM4MDIxMS9yeC5jOjU0OTEgYXQNCj4gaWVl
ZTgwMjExX3J4X2xpc3QrMHgxNzcvMHgxMDIwIFttYWM4MDIxMV0NCj4gDQo+IExvb2tpbmcgYXQg
dGhlIHJ0dzg4IHNvdXJjZSBjb2RlLCB0aGlzIHBlcmZlY3RseSBleHBsYWlucyB3aHkgYG5zc2Ag
aXMgMDoNCj4gMS4gVGhlIGhhcmR3YXJlL2Zpcm13YXJlIHJlcG9ydHMgYHBrdF9zdGF0LT5yYXRl
ID0gMHg2NWAgKDEwMSBpbiBkZWNpbWFsKS4NCj4gMi4gYHJ0d19yeF9maWxsX3J4X3N0YXR1cygp
YCBjaGVja3MgaWYgYHBrdF9zdGF0LT5yYXRlID49DQo+IERFU0NfUkFURVZIVDFTU19NQ1MwYCAo
d2hpY2ggaXMgYDB4MmNgKS4gU2luY2UgYDB4NjUgPj0gMHgyY2AsIGl0DQo+IGNvcnJlY3RseSBz
ZXRzIGByeF9zdGF0dXMtPmVuY29kaW5nID0gUlhfRU5DX1ZIVGAuDQo+IDMuIEl0IHRoZW4gY2Fs
bHMgYHJ0d19kZXNjX3RvX21jc3JhdGUocGt0X3N0YXQtPnJhdGUsDQo+ICZyeF9zdGF0dXMtPnJh
dGVfaWR4LCAmcnhfc3RhdHVzLT5uc3MpYC4NCj4gNC4gSW5zaWRlIGBydHdfZGVzY190b19tY3Ny
YXRlKClgLCB0aGUgdmFsdWUgYDB4NjVgIGZhbGxzIGNvbXBsZXRlbHkNCj4gb3V0c2lkZSBhbnkg
a25vd24gYm91bmRzLiBUaGUgaGlnaGVzdCBkZWZpbmVkIHJhdGUgaW4gYGVudW0NCj4gcnR3X3Ry
eF9kZXNjX3JhdGVgIGlzIGBERVNDX1JBVEVWSFQ0U1NfTUNTOWAgKGAweDUzYCkuIFRoZSBIVCBy
YW5nZQ0KPiAoYERFU0NfUkFURU1DUzBgIHRvIGBERVNDX1JBVEVNQ1MzMWApIGVuZHMgYXQgYDB4
MmJgLg0KPiA1LiBCZWNhdXNlIGAweDY1YCBtYXRjaGVzIGFic29sdXRlbHkgbm9uZSBvZiB0aGUg
YGlmL2Vsc2VgIGJyYWNrZXRzIGluDQo+IGBydHdfZGVzY190b19tY3NyYXRlKClgLCB0aGUgZnVu
Y3Rpb24gc2ltcGx5IHJldHVybnMgd2l0aG91dCBtdXRhdGluZw0KPiBgbWNzYCBhbmQgYG5zc2Au
DQo+IDYuIFNpbmNlIGByeF9zdGF0dXNgIHdhcyBpbml0aWFsaXplZCB3aXRoIGBtZW1zZXQocnhf
c3RhdHVzLCAwLCAuLi4pYA0KPiBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBmdW5jdGlvbiwgYHJ4
X3N0YXR1cy0+bnNzYCByZW1haW5zIGAwYC4NCj4gDQo+IFNvIG1hYzgwMjExIGNvbXBsYWlucyBi
ZWNhdXNlIHRoZSBydHc4OCBkcml2ZXIgZG9lc24ndCBrbm93IHdoYXQgcmF0ZQ0KPiBgMHg2NWAg
bWVhbnMsIGxlYXZlcyBOU1MgYXQgMCwgYnV0IHN0aWxsIGZsYWdzIGl0IGFzIGEgVkhUIHBhY2tl
dC4NCj4gDQo+IEFueSBpZGVhIHdoYXQgYDB4NjVgIHJlcHJlc2VudHMgZnJvbSB0aGUgaGFyZHdh
cmUncyBwZXJzcGVjdGl2ZT8gSXMgaXQNCj4gYSBmaXJtd2FyZSBidWcgb3IgYSBwcm9wcmlldGFy
eSBjb250cm9sL21hbmFnZW1lbnQgZnJhbWUgcmF0ZSBpbmRleD8NCj4gDQo+IExvb2tpbmcgZm9y
d2FyZCB0byB5b3VyIHRob3VnaHRzIQ0KDQpOb3Qgc3VyZSB3aGF0IGhhcmR3YXJlIGdldCB3cm9u
Zy4gTGV0J3MgdmFsaWRhdGUgcmF0ZSB3aGVuIHJlYWRpbmcgZnJvbQ0KaGFyZHdhcmUuIFNpbmNl
IDFNIHJhdGUgY2FuIG9ubHkgMjBNSHosIEkgc2V0IGl0IHRvZ2V0aGVyLiANCg0KUGxlYXNlIGhl
bHAgdG8gdGVzdCBiZWxvdy4gSSBzdXBwb3NlIHlvdSBjYW4gc2VlICJ3ZWlyZCByYXRlPXh4eCIs
IGJ1dCANCiJXQVJOSU5HOiBuZXQvbWFjODAyMTEvcnguYzo1NDkxIiBkaXNhcHBlYXJzLiANCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnguYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnguYw0KaW5kZXggOGIwYWZhYWZmYWEw
Li4zZDVlNDgyNjRmYzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3J4LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcngu
Yw0KQEAgLTI5NSw2ICsyOTUsMTIgQEAgdm9pZCBydHdfcnhfcXVlcnlfcnhfZGVzYyhzdHJ1Y3Qg
cnR3X2RldiAqcnR3ZGV2LCB2b2lkICpyeF9kZXNjOCwNCg0KICAgICAgICBwa3Rfc3RhdC0+dHNm
X2xvdyA9IGxlMzJfZ2V0X2JpdHMocnhfZGVzYy0+dzUsIFJUV19SWF9ERVNDX1c1X1RTRkwpOw0K
DQorICAgICAgIGlmIChwa3Rfc3RhdC0+cmF0ZSA+PSBERVNDX1JBVEVfTUFYKSB7DQorICAgICAg
ICAgICAgICAgcHJpbnRrKCJ3ZWlyZCByYXRlPSVkXG4iLCBwa3Rfc3RhdC0+cmF0ZSk7DQorICAg
ICAgICAgICAgICAgcGt0X3N0YXQtPnJhdGUgPSBERVNDX1JBVEUxTTsNCisgICAgICAgICAgICAg
ICBwa3Rfc3RhdC0+YncgPSBSVFdfQ0hBTk5FTF9XSURUSF8yMDsNCisgICAgICAgfQ0KKw0KICAg
ICAgICAvKiBkcnZfaW5mb19zeiBpcyBpbiB1bml0IG9mIDgtYnl0ZXMgKi8NCiAgICAgICAgcGt0
X3N0YXQtPmRydl9pbmZvX3N6ICo9IDg7DQoNClBpbmctS2UNCg0KDQo=

