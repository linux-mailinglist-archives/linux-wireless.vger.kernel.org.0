Return-Path: <linux-wireless+bounces-32724-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jV/kOgYbrmlu/gEAu9opvQ
	(envelope-from <linux-wireless+bounces-32724-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 01:57:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D8232F83
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 01:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF97D3007C8E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17235958;
	Mon,  9 Mar 2026 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bxv3Sdcu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6E286A4
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017859; cv=none; b=mN3soRLCpl5AnwUfeO5vZitLVKon/cb66nH2AtNNHXywvfxZSO3cCDHWEZvkdZCGNqYwcaFLcOaBLOab4J67P9qkYrLqXcQpRg12l8uRzbyh4tRWn0O2QHI9WtaJTWC/EvBeoIvCbbQS/0Uc/pHNbXdB6MSOqBSGFvCrTjbAiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017859; c=relaxed/simple;
	bh=X3CuSsS/fJOa/bWxIWB2s7I3ewC03xehiQDybJ75Beg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXVSXx03aCZd9B0XI20zv1BonqjFQYIeys9oChoWlxAZHUCUvruniOj56uS9/1ly7e5u3QS7aoEx1bcxuODjQifKM04y92bMwE0iYvfHgb6LQ++f5TEAvpPjRpyWG7OGhyyVgyBWPWaRa2pCTO2DCS/8rjMg3UsALpYZiRk54Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bxv3Sdcu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6290vYH713698292, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773017854; bh=X3CuSsS/fJOa/bWxIWB2s7I3ewC03xehiQDybJ75Beg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bxv3SdcuydJ1obesFsAeV5qlhfcmIVSNi0RFgzrlRzzH1aeRYkn3U//MqEt+uXdk+
	 XFi4Vh8Bkow0ihs1dGAZ55jJFuMMAmf6E2hY5n7K5SNqvPBWkuoNsOtOLkPg0jUCPu
	 vlnWHgka7BWd+mRUVGp4p9Wt59pIU/du5HE+Am6m2VrYBGmOSnZoW1Tw8jlmUxSuua
	 WvHor6+dUIe023lWxcOtOREJnXV2/qLFR/GjgkFfgapF7bQD5tpS3cd9FC9zbE9ZDp
	 Rla5Ro8miqXxpfTAUFaVaq/NS4TaIIt44hIM2uWh80+yJOhUDNrFrNwz2ldsS7wNB0
	 AWKrS0P8IZ/4A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6290vYH713698292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 08:57:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 9 Mar 2026 08:57:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 9 Mar 2026 08:57:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sergio <srg.llorente.bn@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: rtw89_8852ce firmware crash (SER catches error) on kernel 6.18.13
Thread-Topic: rtw89_8852ce firmware crash (SER catches error) on kernel
 6.18.13
Thread-Index: AQHcrWWJCh3euS4kVEigf8rKOCGX3bWlYwpg
Date: Mon, 9 Mar 2026 00:57:34 +0000
Message-ID: <00237e65e9834097b85442d22465f435@realtek.com>
References: <CAEhwkO8XDDT-TWsL4Mo=qc8NedojvA7JNB-PA_XiAxfk-bPWsg@mail.gmail.com>
In-Reply-To: <CAEhwkO8XDDT-TWsL4Mo=qc8NedojvA7JNB-PA_XiAxfk-bPWsg@mail.gmail.com>
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
X-Rspamd-Queue-Id: 3F3D8232F83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32724-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

U2VyZ2lvIDxzcmcubGxvcmVudGUuYm5AZ21haWwuY29tPiB3cm90ZToNCj4gSGkgYWxsLA0KPiAN
Cj4gSSBhbSBleHBlcmllbmNpbmcgZnJlcXVlbnQgZmlybXdhcmUgY3Jhc2hlcyBhbmQgbWljcm8t
ZGlzY29ubmVjdHMgd2l0aA0KPiBteSBSVEw4ODUyQ0UgV2ktRmkgY2FyZC4gVGhlIHN5c3RlbSBz
ZWVtcyB0byBiZSByZXBlYXRlZGx5IHJlY292ZXJpbmcNCj4gZnJvbSBpbnRlcm5hbCBlcnJvcnMg
KFN5c3RlbSBFcnJvciBSZWNvdmVyeSksIHdoaWNoIGNhdXNlcyBsYWcgc3Bpa2VzDQo+IGFuZCBj
b25uZWN0aW9uIGRyb3BzLg0KPiANCj4gSGVyZSBpcyBteSBzeXN0ZW0gYW5kIGhhcmR3YXJlIGlu
Zm9ybWF0aW9uOg0KPiANCj4gKiBLZXJuZWw6IExpbnV4IGZlZG9yYSA2LjE4LjEzLTIwMC5mYzQz
Lng4Nl82NCBbY2l0ZTogMV0NCj4gKiBIYXJkd2FyZTogUmVhbHRlayBTZW1pY29uZHVjdG9yIENv
LiwgTHRkLiBSVEw4ODUyQ0UgUENJZSA4MDIuMTFheA0KPiBXaXJlbGVzcyBOZXR3b3JrIENvbnRy
b2xsZXIgWzEwZWM6Yzg1Ml0NCj4gKiBTdWJzeXN0ZW06IExlbm92byBEZXZpY2UgWzE3YWE6NTg1
Ml0NCj4gKiBGaXJtd2FyZTogbG9hZGVkIHJ0dzg5L3J0dzg4NTJjX2Z3LTIuYmluIFtjaXRlOiAy
XQ0KPiAqIEZpcm13YXJlIHZlcnNpb246IDAuMjcuMTI5LjQgKDNmMWE1MzAyKSBbY2l0ZTogMl0N
Cj4gDQo+IEhlcmUgaXMgYSBicmllZiBzbmlwcGV0IG9mIHRoZSBkbWVzZyBvdXRwdXQgZHVyaW5n
IHRoZSBjcmFzaDoNCj4gDQo+IFsxMjM5MS4yMjI3MDddIHJ0dzg5Xzg4NTJjZSAwMDAwOjAyOjAw
LjA6IFNFUiBjYXRjaGVzIGVycm9yOiAweDEwMDEgW2NpdGU6IDldDQo+IFsxMjM5MS4yMjM0OTdd
IHJ0dzg5Xzg4NTJjZSAwMDAwOjAyOjAwLjA6IEZXIHN0YXR1cyA9IDB4NmEwMDgxMDggW2NpdGU6
IDldDQo+IFsxMjM5MS4yMjM1MjFdIHJ0dzg5Xzg4NTJjZSAwMDAwOjAyOjAwLjA6IFtFUlJdZncg
UEMgPSAweDIwMTQ2NWM4IFtjaXRlOiA5XQ0KPiBbMTIzOTEuMjIzNzMzXSBydHc4OV84ODUyY2Ug
MDAwMDowMjowMC4wOiBTRVIgY2F0Y2hlcyBlcnJvcjogMHgxMDAyIFtjaXRlOiAxMF0NCj4gDQo+
IEkgaGF2ZSBhdHRhY2hlZCB0aGUgZnVsbCBkbWVzZyBjcmFzaCBsb2cgZm9yIHlvdXIgcmV2aWV3
Lg0KDQpBcyBhdHRhY2hlZCBsb2csIHRoZSBTRVIgb25seSBoYXBwZW5lZCBvbmNlIGFuZCBpdCB3
YXMgYSBMMSBTRVIsIHdoaWNoDQpJIHN1cHBvc2UgZmlybXdhcmUgcmVjb3ZlciB0aGUgc3RhdGUg
d2l0aG91dCBjb25uZWN0aW9uIGxvc3MuIA0KDQpBcyB5b3UgbWVudGlvbmVkIGF0IGJlZ2lubmlu
ZyB0aGF0IGl0IGhhcHBlbnMgcmVwZWF0ZWRseSwgY291bGQgeW91IHNoYXJlDQpob3cgZnJlcXVl
bnQgaXQgZG9lcz8gDQoNCkNvdWxkIHlvdSB0cnkgdG8gdHVybiBvZmYgcG93ZXIgc2F2aW5nIGJ5
ICdpdyB3bGFuMCBzZXQgcG93ZXJfc2F2ZSBvZmZgIHRvDQpzZWUgaWYgaXQgY2FuIGJlY29tZSBz
dGFibGU/IEFuZCwgcGxlYXNlIGRpc2FibGUgQlQgZGV2aWNlIGVudGlyZWx5IHRvDQpjbGFyaWZ5
IHByb2JsZW0uIA0KDQpQaW5nLUtlDQoNCg==

