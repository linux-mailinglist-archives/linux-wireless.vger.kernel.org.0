Return-Path: <linux-wireless+bounces-34141-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEBqBRTnyWl43QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34141-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:59:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE3354EEB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 04:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF6603002B0F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC337F75E;
	Mon, 30 Mar 2026 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JgHnNWPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6965313E05
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774839567; cv=none; b=BHQoSk2v0Gw33c9f3wqjo9eBRXP6+lfVxF1cF9JM5FBcCOqDvlTAYdeS1C+5tsPhh7mwrnpwue7c8hi0A/XEcp7MvxSIFsLXBEmeC28YqQAXG1T4GPevdwFnUepXxiNAXfpB71NRX+w33uP1DwHBUm/RkgeT0ExrptARGopcr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774839567; c=relaxed/simple;
	bh=ae+2VetodwNOh6COJXYuuVcZadUQX6C9EwkoKSiGgq8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DLYwUwB/oj1O6QuMTv5cFtT7q+CD5+FGXl7v6pooMoHv4den8cQ1chbjlK4WW4K8k+EG48z9rgDdSzoKvhVAgB3WNDKqbueqi8ucF43gcy7XDW+WTT0l6zp0yRjdME2TtbboYdRvKahAIoGiPw8LATdgBAkqebEnciTjLva/7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JgHnNWPH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U2xLNL1201253, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774839561; bh=ae+2VetodwNOh6COJXYuuVcZadUQX6C9EwkoKSiGgq8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JgHnNWPHDOgY0Mp3kuIG7fye1DpsSilc2UyNFu25QM4xOgCMsLX5vb92R4UTf59AZ
	 WahEvJZLNN72/42g0gmS2fwccMzOS4Gg343HfnZpvxzOvc5j9T5UX/gmiALcJaSn/d
	 Ui3LoNWctd8sEXYyJueEPlrmXikhvlnfcWZ/fhSPPe5ni9RSOiFm0B97sD70YGItMa
	 5yvMxDWpvvIvmboyEjcEl9aAcw3p5zQ78Ok4M9+R33DP6fMdrzXybiRLo0CryKXlrn
	 BOdnKXs8w2VgwO0y1UDyKIzK9tRq1ffBcXBIW38uvNCBwMs4eSSYCRRS/0eDmZb7i7
	 FFJRa4/+678qA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U2xLNL1201253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 10:59:21 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 10:59:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 30 Mar 2026 10:59:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 10:59:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 01/12] wifi: rtw89: usb: Disable MLO for now
Thread-Topic: [PATCH rtw-next 01/12] wifi: rtw89: usb: Disable MLO for now
Thread-Index: AQHcvUJ8zbuMUkM/fk6VkX/GCcGq4rXGZsFA
Date: Mon, 30 Mar 2026 02:59:13 +0000
Message-ID: <dbd41cc160504b8daeb93b7967101c7f@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <eb447efe-466d-4494-86c2-2e4d2b882fce@gmail.com>
In-Reply-To: <eb447efe-466d-4494-86c2-2e4d2b882fce@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34141-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9CAE3354EEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJdCdz
IG5vdCB5ZXQgY2xlYXIgaG93IHRoZSBUWCBxdWV1ZS9jaGFubmVsIHNlbGVjdGlvbiBpcyBzdXBw
b3NlZCB0bw0KPiB3b3JrIGZvciBSVEw4OTIyQVUgd2l0aCBNTE8sIGFuZCBJIGNhbid0IHRlc3Qg
TUxPIGFueXdheS4NCg0KQ3VycmVudGx5LCBydHc4OSB3b3JrIGluIE1MU1IgbW9kZSBieSBkZWZh
dWx0LCB3aGljaCBtZWFucyBpdCB3b3JrcyBsaWtlDQpsZWdhY3kgbW9kZSwgc28gaXQncyBwcm9i
YWJseSBmaW5lIHRvIGVuYWJsZSBNTE8uDQoNClRoZSBkZWJ1Z2ZzIGNhbiBzd2l0Y2ggZU1MU1Ig
bW9kZSwgYnV0IGl0IGRvZXNuJ3Qgd29yayB2ZXJ5IHdlbGwgZm9yIG5vdy4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS91c2IuYyB8IDQgKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMNCj4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3VzYi5jDQo+IGluZGV4IDU4MWI4YzA1ZjkzMC4uN2E0
NmFjZTM0YzI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5L3VzYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNi
LmMNCj4gQEAgLTEwMjksNiArMTAyOSwxMCBAQCBpbnQgcnR3ODlfdXNiX3Byb2JlKHN0cnVjdCB1
c2JfaW50ZXJmYWNlICppbnRmLA0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ICAgICAgICAgfQ0KPiANCj4gKyAgICAgICBydHc4OV9kZWJ1ZyhydHdkZXYsIFJUVzg5X0RCR19D
SEFOLA0KPiArICAgICAgICAgICAgICAgICAgICIlczogZGlzYWJsZSBNTE8gZm9yIG5vd1xuIiwg
X19mdW5jX18pOw0KPiArICAgICAgIHJ0d2Rldi0+c3VwcG9ydF9tbG8gPSBmYWxzZTsNCj4gKw0K
PiAgICAgICAgIHJ0d3VzYiA9IHJ0dzg5X3VzYl9wcml2KHJ0d2Rldik7DQo+ICAgICAgICAgcnR3
dXNiLT5ydHdkZXYgPSBydHdkZXY7DQo+ICAgICAgICAgcnR3dXNiLT5pbmZvID0gaW5mby0+YnVz
LnVzYjsNCj4gLS0NCj4gMi41My4wDQoNCg==

