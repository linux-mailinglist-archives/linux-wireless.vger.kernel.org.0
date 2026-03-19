Return-Path: <linux-wireless+bounces-33444-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEHuGqlRu2lMigIAu9opvQ
	(envelope-from <linux-wireless+bounces-33444-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:30:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445F2C4723
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B69630333E0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A72BD5BD;
	Thu, 19 Mar 2026 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ijH109tq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE329E110
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883778; cv=none; b=RUS7/65+Cwq7hiKgAoJFFvqBQ3/QNYwKPkVTNN13camEYuC83G3zQLa552FHJwFdzAb5Wossx5HmvkhrKUw2o5hfeLyLXzm5pw05X9imx+i6Lv+h0G557ENoucmfQaFPSqBJ3W5cLAGMhFvRVkDGMgBtz2C8kQrADeaG5BoPg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883778; c=relaxed/simple;
	bh=WJia53sRbaU6iOoa9O4TONjm15J3yfvydA3oPk53oJU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgRr8kOfEsJCMfavRdnskn3joD1i5BLmFCM0K6tcka0iKSt0tgds5sFxP2tpsDnw3uqnKPIWeGC59IWB717z1ZEHYvSetnH81/1LhrKnVK49Ytwj+NGTL3NDD0YFnVkbJfKZ5k2q7b7VV6/XEzKvICBIYyT+6rsLaLjRsu2G7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ijH109tq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62J1TWbV42758806, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773883772; bh=WJia53sRbaU6iOoa9O4TONjm15J3yfvydA3oPk53oJU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ijH109tqbof3pVzV5cn7FXhJD62ymj6ufKF+Q8Vqy0Mu6kn2vG5ysOCMZR1bC/dLs
	 veGi4fb/0XV3FN9/tGh5Qls9yoDOzZIDCBfv+IFXUp+zHaHKvn6WEZUnTC52QsT5Rb
	 S/xtOueA+YvkBpnO+wfeEoofD/1jI6hgmUbhyUC1WaJuuhGMlMS0ybwKc7MIJTXRda
	 IV/igXOKMjeQGPPr2E2PtoT/CTUvKOVKGAsNgo3cVPiDsz2WbaHf0aJZr5mzwC7mqW
	 sBIrI73v0xCdZ4bPBs0vgA2cwBBZ6KGsuUOnmRR0iwE2dYQ8WmOdtMKcoXXb4mRtle
	 Jox1xYtcagvXg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62J1TWbV42758806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 09:29:32 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 09:29:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 19 Mar 2026 09:29:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 19 Mar 2026 09:29:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2] wifi: rtw88: TX QOS Null data the same way as
 Null data
Thread-Topic: [PATCH rtw-next v2] wifi: rtw88: TX QOS Null data the same way
 as Null data
Thread-Index: AQHctv7+ZiuUzcA5HkiBrnEe6HGKxrW1EYqw
Date: Thu, 19 Mar 2026 01:29:31 +0000
Message-ID: <cbbcb5eb1603481388897578a556b369@realtek.com>
References: <2b53fb0d-b1ed-47b6-8caa-2bb9ae2acb80@gmail.com>
In-Reply-To: <2b53fb0d-b1ed-47b6-8caa-2bb9ae2acb80@gmail.com>
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
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-33444-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0445F2C4723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBXaGVu
IGZpbGxpbmcgb3V0IHRoZSBUWCBkZXNjcmlwdG9yLCBOdWxsIGRhdGEgZnJhbWVzIGFyZSB0cmVh
dGVkIGxpa2UNCj4gbWFuYWdlbWVudCBmcmFtZXMsIGJ1dCBRT1MgTnVsbCBkYXRhIGZyYW1lcyBh
cmUgdHJlYXRlZCBsaWtlIG5vcm1hbA0KPiBkYXRhIGZyYW1lcy4gU29tZWhvdyB0aGlzIGNhdXNl
cyBhIHByb2JsZW0gZm9yIHRoZSBmaXJtd2FyZS4NCj4gDQo+IFdoZW4gY29ubmVjdGVkIHRvIGEg
bmV0d29yayBpbiB0aGUgMi40IEdIeiBiYW5kLCB3cGFfc3VwcGxpY2FudCAob3INCj4gTmV0d29y
a01hbmFnZXI/KSB0cmlnZ2VycyBhIHNjYW4gZXZlcnkgZml2ZSBtaW51dGVzLiBEdXJpbmcgdGhl
c2Ugc2NhbnMNCj4gbWFjODAyMTEgdHJhbnNtaXRzIG1hbnkgUU9TIE51bGwgZnJhbWVzIGluIHF1
aWNrIHN1Y2Nlc3Npb24uIEJlY2F1c2UNCj4gdGhlc2UgZnJhbWVzIGFyZSBtYXJrZWQgd2l0aCBJ
RUVFODAyMTFfVFhfQ1RMX1JFUV9UWF9TVEFUVVMsIHJ0dzg4DQo+IGFza3MgdGhlIGZpcm13YXJl
IHRvIHJlcG9ydCB0aGUgVFggQUNLIHN0YXR1cyBmb3IgZWFjaCBvZiB0aGVzZSBmcmFtZXMuDQo+
IFNvbWV0aW1lcyB0aGUgZmlybXdhcmUgY2FuJ3QgcHJvY2VzcyB0aGUgVFggc3RhdHVzIHJlcXVl
c3RzIHF1aWNrbHkNCj4gZW5vdWdoLCB0aGV5IGFkZCB1cCwgaXQgb25seSBwcm9jZXNzZXMgc29t
ZSBvZiB0aGVtLCBhbmQgdGhlbiBtYXJrcw0KPiBldmVyeSBzdWJzZXF1ZW50IFRYIHN0YXR1cyBy
ZXBvcnQgd2l0aCB0aGUgd3JvbmcgbnVtYmVyLg0KPiANCj4gVGhlIHN5bXB0b20gaXMgdGhhdCBh
ZnRlciBhIHdoaWxlIHRoZSB3YXJuaW5nICJmYWlsZWQgdG8gZ2V0IHR4IHJlcG9ydA0KPiBmcm9t
IGZpcm13YXJlIiBhcHBlYXJzIGV2ZXJ5IGZpdmUgbWludXRlcy4NCj4gDQo+IFRoaXMgcHJvYmxl
bSBhcHBhcmVudGx5IGhhcHBlbnMgb25seSB3aXRoIHRoZSBvbGRlciBSVEw4NzIzRCwgUlRMODgy
MUEsDQo+IFJUTDg4MTJBLCBhbmQgcHJvYmFibHkgUlRMODcwM0IgY2hpcHMuDQo+IA0KPiBUcmVh
dCBRT1MgTnVsbCBkYXRhIGZyYW1lcyB0aGUgc2FtZSB3YXkgYXMgTnVsbCBkYXRhIGZyYW1lcy4g
VGhpcyBzZWVtcw0KPiB0byBhdm9pZCB0aGUgcHJvYmxlbS4NCj4gDQo+IFRlc3RlZCB3aXRoIFJU
TDg4MjFBVSwgUlRMODcyM0RVLCBSVEw4ODExQ1UsIGFuZCBSVEw4ODEyQlUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0K
QWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

