Return-Path: <linux-wireless+bounces-33671-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOEGBfuewGnrJAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33671-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 03:01:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE402EBC79
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 03:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795223002E29
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 02:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBFA1E492D;
	Mon, 23 Mar 2026 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CYTfRq+b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44027470;
	Mon, 23 Mar 2026 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231288; cv=none; b=PkPWGZq1b0rFl5KMqzXaio5ue6dvtbg/yMTEFeHngIr3Esu2768OUbxKS8rdrpIMXbM5UeuXs+EfxuwieWzeIWmfI4NpUU/zB44EYk8HdrVrJL+tCFeGiD+s7xf9dAJePXBxmMQhAtNR43/kYB1M2B6vseD+cF1b3dUqaL2MERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231288; c=relaxed/simple;
	bh=2xkvpcF3giw45LVJKVERaECcgY90n8wnh/S+mFvDeNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BoMG6xGWzNqCm6wBAMFo+8cSNqGeLcdblDcW36OWc/8r3AgcfEtGvg7cr5HM+4uWNRdSqkP5Dqp3DSFBI1xU8ExQFjP3WnK1cTzTz+pXoJrykYmx9JuM9OSs/R/cdWg4gXJ3HwsRXHIw2xbHfkxxp4zPdZ2fP0+bZQitpJHZW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CYTfRq+b; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N21Nl342239595, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774231283; bh=2xkvpcF3giw45LVJKVERaECcgY90n8wnh/S+mFvDeNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CYTfRq+bgADZMRngAPppjEsty9EXE73XzezZrBJsCpQL2Ptj18R3SFp0YAhRu09Vi
	 RtdBEJSXzvyn23raQRH1HzacEv7GwcyC1dysfCHEXUW9dbhS5NrKVdUR9ISHX3nYk5
	 3joxwUJVRmuEKWbcd1cNNfhqMsCYqop2XygIBYmQsoCXBVsWmUId1Kmnk1Y7Qt0IRv
	 2Z2MtTBdQhsAKEckR5pCxQP1VT0DQNii2ZlNrCwsTjrwegXX/dycLL2oy7IfenZbvc
	 hlqkT9tdzoondl1KMMqR8B5d+4Ggzz1n+f2dWm0pWXveEwBVhaXGOH4k1F3Jg33EFa
	 7ZjRkHV25TMHA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N21Nl342239595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:01:23 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 10:01:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 10:01:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 23 Mar 2026 10:01:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: LB F <goainwo@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Topic: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
Thread-Index: AQHcsA6WTRRnBRFJhEKVxaR7JwwWq7Wm+M9wgAAbfgCAAX9nAIAAB6mAgAAK64CAAElZAIABMBnAgADMOgCAACdjAIAAB1+AgAJAYICAAB3nAIAAxOYAgAJBRiCAAKEnAIAA2QBQgAD06wCAAJVNMIAA+6oAgACVvSCAAP1VgIAAC/kAgACJQ/D//4GPAIAAkThggAG2LgCAAwD/wA==
Date: Mon, 23 Mar 2026 02:01:21 +0000
Message-ID: <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
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
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
In-Reply-To: <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33671-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7EE402EBC79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TEIgRiA8Z29haW53b0BnbWFpbC5jb20+IHdyb3RlOg0KPiBQaW5nLUtlIFNoaWggPHBrc2hpaEBy
ZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gSSdsbCBzZW5kIGZvcm1hbCBwYXRjaCAoQ2MgeW91KSBm
b3IgdGhlIGludmFsaWQgVkhUIE5TUz0wLCBidXQgbm90DQo+ID4gdG8gaGFuZGxlICJ1bnVzZWQg
cGh5IHN0YXR1cyBwYWdlIi4gUGxlYXNlIGdpdmUgbWUgVGVzdGVkLWJ5IHRhZyBvbg0KPiA+IHRo
ZSBwYXRjaCBhZnRlciBJIHNlbmQgaXQuDQo+IA0KPiBIaSBQaW5nLUtlLA0KPiANCj4gSnVzdCBh
IHF1aWNrIHVwZGF0ZSB0byBrZWVwIHlvdSBpbmZvcm1lZCAtLSBubyBydXNoIG9uIGFueXRoaW5n
Lg0KPiANCj4gTXkga2VybmVsIHVwZGF0ZWQgZnJvbSA2LjE5LjcgdG8gNi4xOS45LCB3aGljaCB3
aXBlZCB0aGUgcHJldmlvdXNseQ0KPiBpbnN0YWxsZWQgb3V0LW9mLXRyZWUgbW9kdWxlcy4gSSBy
ZWJ1aWx0IGFuZCByZWluc3RhbGxlZCBib3RoIHBhdGNoZXM6DQo+IA0KPiAgIDEuIFRoZSB2MiBE
TUkgcXVpcmsgKG1haW4uaCArIHBjaS5jKSBkaXNhYmxpbmcgQVNQTSBhbmQgTFBTIERlZXANCj4g
ICAgICBNb2RlIGZvciB0aGUgSFAgUDNTOTVFQSNBQ0IgU0tVLg0KPiAgIDIuIFRoZSByYXRlIHZh
bGlkYXRpb24gcGF0Y2ggKHJ4LmMpIGNsYW1waW5nIG91dC1vZi1ib3VuZHMgcmF0ZQ0KPiAgICAg
IHZhbHVlcyBiZWZvcmUgdGhleSByZWFjaCBtYWM4MDIxMS4NCj4gDQo+IEJvdGggcGF0Y2hlcyBh
cHBseSBjbGVhbmx5IGFuZCB0aGUgc3lzdGVtIHJlbWFpbnMgZnVsbHkgc3RhYmxlIG9uDQo+IDYu
MTkuOS4gVGhlIERNSSBxdWlyayBpcyBjb25maXJtZWQgYWN0aXZlIHZpYSBzeXNmcyAoZGlzYWJs
ZV9hc3BtPVksDQo+IGRpc2FibGVfbHBzX2RlZXA9WSkgd2l0aCBubyBtYW51YWwgbW9kcHJvYmUg
b3ZlcnJpZGVzLg0KPiANCj4gSSBhbSBsb29raW5nIGZvcndhcmQgdG8geW91ciBmb3JtYWwgcGF0
Y2ggZm9yIHRoZSBWSFQgTlNTPTAgaXNzdWUgYW5kDQo+IHdpbGwgcHJvdmlkZSBhIFRlc3RlZC1i
eSB0YWcgYXMgc29vbiBhcyBpdCBhcnJpdmVzLiBUaGFuayB5b3UgYWdhaW4NCj4gZm9yIGFsbCB5
b3VyIHdvcmsgYW5kIHBhdGllbmNlIHRocm91Z2hvdXQgdGhpcyBwcm9jZXNzLg0KDQpJIHNlbnQg
dGhlIFZIVCBOU1M9MCBwYXRjaCBbMV0uIFBsZWFzZSBoZWxwIHRvIGdpdmUgaXQgYSB0ZXN0Lg0K
VGhhbmtzLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAy
NjAzMjMwMTU4NDkuOTQyNC0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1DQoNClBpbmctS2UNCg0K
DQo=

