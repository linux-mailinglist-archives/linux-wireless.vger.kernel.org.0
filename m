Return-Path: <linux-wireless+bounces-36678-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHTYMHIEDWrXsAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36678-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 02:46:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6281A5865AB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 02:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42D7A304C9F0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 00:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200B2475D0;
	Wed, 20 May 2026 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IBaRrVZQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785A213E9C
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237983; cv=none; b=Xvi5O55YoPlPKVoYUJYMC3KZNFA9vpZOBu8VYSYmUsFHQQjosD9/6i9r4GB8ZyyA8WdVtcAgVAfqlnnK1jq06Ux1yFFFXnkMsVTk4olKjZUmG47XnIF3EEfgKpHwgAG6h83iEnFnyO0jHeFigGdaSg4Oz/qLweS51qaaZxgziPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237983; c=relaxed/simple;
	bh=MZFbhBsCYnQH/C1kq1L2FHLqrvV8aXnLdHNtYKeNdZo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oH9ZLnQ322jk/IA1IZMDx8RTEQeZmb4dRlDE7hb+zJy1RnluiJ8PeT3XYcQiH4+4ugy6BRTi+5ncGfLa2kQnUL417Ddw+bXwYMRur1nOjs6I7dx7PhYLW7knWjoQ9bsDz7NlN49Erb+siqS/c38o5zDevf0JVvtu7CZGsGSdePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IBaRrVZQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64K0kH8K13767316, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779237977; bh=MZFbhBsCYnQH/C1kq1L2FHLqrvV8aXnLdHNtYKeNdZo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IBaRrVZQMh73mKbn8I9ouEC+pG0Auks6hMl9Hct9LCDTbW5MP1YA9vobQiHra6LiL
	 QUADZPrjOxEadO9yEu7tabmPamBl5WM7cJp3iWopbpiHDbpGLtld5JbNAhC9IIjlck
	 sBUmLWtIRHPTv90Ec49VjwrVF+puhMoT73W4n29d0zx30HoMSNMTDM09YoPo+SWrVW
	 jfsi5hAdPKU06Hert22qDqIiSkUhIR/LrY8g9boxF7iJirQDnIP68VCPrv2IUjS2Kk
	 pmwL2LHlugcLJJQVfFN2MoOY0LTJ7EAco3bmG+Rer1dNSh8gt1AmEgngR8ePy6MsXy
	 0Oe7/8reQZf+g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64K0kH8K13767316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 08:46:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 08:46:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 08:46:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 20 May 2026 08:46:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3] wifi: rtw89: usb: Support switching to USB 3
 mode
Thread-Topic: [PATCH rtw-next v3] wifi: rtw89: usb: Support switching to USB 3
 mode
Thread-Index: AQHc5TJ2jt4wT7BMb0ihQX+ES4ddkbYTaOAwgAGQgQCAAR/zcA==
Date: Wed, 20 May 2026 00:46:17 +0000
Message-ID: <97ff1c5305b9454eae55ec58db09158c@realtek.com>
References: <fcdde81a-97ec-458f-8e70-ac024938f1d7@gmail.com>
 <5fc263787831471f87585fb90a9b0fcb@realtek.com>
 <b4da28cd-17e0-46f2-a73c-e77d9c96cca1@gmail.com>
In-Reply-To: <b4da28cd-17e0-46f2-a73c-e77d9c96cca1@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36678-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6281A5865AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
OC8wNS8yMDI2IDEwOjUxLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGUgUmVhbHRlayB3aWZp
IDYvNyBkZXZpY2VzIHdoaWNoIHN1cHBvcnQgVVNCIDMgYXJlIHdlaXJkOiB3aGVuIGZpcnN0DQo+
ID4+IHBsdWdnZWQgaW4sIHRoZXkgcHJldGVuZCB0byBiZSBVU0IgMi4gVGhlIGRyaXZlciBuZWVk
cyB0byBzZW5kIHNvbWUNCj4gPj4gY29tbWFuZHMgdG8gdGhlIGRldmljZSwgd2hpY2ggbWFrZSBp
dCBkaXNhcHBlYXIgYW5kIGNvbWUgYmFjayBhcyBhDQo+ID4+IFVTQiAzIGRldmljZS4NCj4gPj4N
Cj4gPj4gSW1wbGVtZW50IHRoZSByZXF1aXJlZCBjb21tYW5kcyBpbiBydHc4OS4NCj4gPj4NCj4g
Pj4gQWRkIGEgbmV3IGZ1bmN0aW9uIHJ0dzg5X3VzYl93cml0ZTMyX3F1aWV0KCkgdG8gYXZvaWQg
dGhlIHdhcm5pbmdzDQo+ID4+IHdoZW4gd3JpdGluZyB0byBSX3tBWCxCRX1fUEFEX0NUUkwyLiBF
dmVuIHRob3VnaCB0aGUgd3JpdGUgc3VjY2VlZHMsDQo+ID4+IHVzYl9jb250cm9sX21zZygpIHJl
dHVybnMgLUVQUk9UTywgcHJvYmFibHkgYmVjYXVzZSB0aGUgVVNCIGRldmljZQ0KPiA+PiBkaXNh
cHBlYXJzIGltbWVkaWF0ZWx5LiBUaGlzIHJlc3VsdHMgaW4gc29tZSBjb25mdXNpbmcgd2Fybmlu
Z3MgaW4NCj4gPj4gdGhlIGtlcm5lbCBsb2cuDQo+ID4+DQo+ID4+IFdoZW4gYSBVU0IgMyBkZXZp
Y2UgaXMgcGx1Z2dlZCBpbnRvIGEgVVNCIDIgcG9ydCwgcnR3ODkgd2lsbCB0cnkgdG8NCj4gPj4g
c3dpdGNoIGl0IHRvIFVTQiAzIG1vZGUgb25seSBvbmNlLiBUaGUgZGV2aWNlIHdpbGwgZGlzYXBw
ZWFyIGFuZCBjb21lDQo+ID4+IGJhY2sgc3RpbGwgaW4gVVNCIDIgbW9kZSwgb2YgY291cnNlLg0K
PiA+DQo+ID4gQXMgd2UgYWx3YXlzIHRyeSB0byBzd2l0Y2ggVVNCIDMsIGlzIGl0IG5lZWRlZCB0
byBhZGQgYSBoaW50IHRvIHVzZXJzDQo+ID4gdG8gcGx1ZyBVU0IgMiBwb3J0IGlmIGhlIGhhcyBh
IGJhZCBwZXJmb3JtYW5jZSBvbiAyR0h6IGJhbmQ/DQo+ID4NCj4gDQo+IEkgY2FuIGFkZCBhIG1l
c3NhZ2UgbGlrZSAiMi40IEdIeiBwZXJmb3JtYW5jZSBtYXkgYmUgYmV0dGVyIGluIGEgVVNCIDIN
Cj4gcG9ydCIuDQoNCkkgc3VwcG9zZSB3ZSBzaG91bGQgdXNlIHJ0dzg5X2luZm8oKS4gDQoNCkkn
bGwgd2FpdCBmb3IgdjQuIA0KDQo=

