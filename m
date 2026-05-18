Return-Path: <linux-wireless+bounces-36594-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKRkC2zNCmq18QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36594-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:27:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD7A568BA0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFD39308D62E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBB3E1D14;
	Mon, 18 May 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pE2KaWml"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3A3D6CA7
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092117; cv=none; b=k652UVaNhQeVF/sQ+ARdfGAGAcl7VKWpup6H+Z/9lyAI1u1iKlozwibymqr1Op97/nP74d7lRS6Qr/1EfkxUVz95URkfBlanZXw2ogdN+wiNcL57hXblD1f9XE4ajHudjXNmpN0EKF6NJdNtJbV2egMmtnVxHECqfpp91D+2+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092117; c=relaxed/simple;
	bh=B+HbwpgGhEUiShNqqqKSUH8N3YoqnoUHCls7VLSy548=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=et6iwvVR0UOQkaXhwzUbkFPNfrSnKwSyBcrb5zfxbUQQ6QtHNXFtz316R/Eg6dL+5yDs7omQLB7A7yCdsvr0HDfCLq/uECynZWrWwECqSL73h2obnrdoHNgX1yL+uikvYAxzPIe2vYn3pSN5ChDYQ3XaUM/gcUkxhhLGehpoIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pE2KaWml; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64I8ExcC61679503, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779092099; bh=B+HbwpgGhEUiShNqqqKSUH8N3YoqnoUHCls7VLSy548=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pE2KaWmlAczBlB8fxWvOZURZWO2xKy0GRUPqQ99j6isT2XcyXzpaRHFPXDZzjBZ+D
	 mK0VJ2gebQSCPhI6DxyaKWMz78ZRse6nQI6dXAh9hp4gzLun0qZV06kQkRrC1cgHiB
	 ZpD5jj19/Czppwjat7FGoLiQgTovUKDCbDu14M1MOQO/o6GQclktiiz3OZoH+QVFlW
	 6ispqYMYG4LSE0v2PgHg7+cBcJLJlr+pqN2ZK8wfKNz52RACO4OrC3mwxDvt1znWnx
	 JzrA5sS2vOf1NaVKeTz/oI3yUC9M7ifRe16cf6U9w+BcWFnVtIi8XKe0NxkdV3IBf+
	 HzB9PqENCjH8g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64I8ExcC61679503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 16:14:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 May 2026 16:14:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 18 May 2026 16:14:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: LB F <goainwo@gmail.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Fiona Klute <fiona.klute@gmx.de>,
        "andrej.skvortzov@gmail.com" <andrej.skvortzov@gmail.com>,
        "anarsoul@gmail.com" <anarsoul@gmail.com>,
        Zhen XIN
	<zhen.xin@nokia-sbell.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Add more validation for the RX
 descriptor
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Add more validation for the RX
 descriptor
Thread-Index: AQHc5UJ+mQkQD4L530GtpNHFNKt6ebYTbXVw
Date: Mon, 18 May 2026 08:14:59 +0000
Message-ID: <1d0efa51a4214ee8b65d7f3ff9d52097@realtek.com>
References: <a237ba9e-9f05-451f-9dfc-9aa8b11b7bc4@gmail.com>
In-Reply-To: <a237ba9e-9f05-451f-9dfc-9aa8b11b7bc4@gmail.com>
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
X-Rspamd-Queue-Id: 2AD7A568BA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36594-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,googlemail.com,gmx.de,nokia-sbell.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTb21l
IFJUTDg4MjFDRSBjYXJkcyBjYW4gcmV0dXJuIGZyYW1lcyB3aXRoIGNvcnJ1cHRlZCBSWCBkZXNj
cmlwdG9yLA0KPiBjYXVzaW5nIHdhcm5pbmdzIGFuZCBjcmFzaGVzIGlmIHRoZXkgYXJlIHBhc3Nl
ZCB0byB0aGUgdXBwZXIgbGF5ZXJzLg0KDQpOb3Qgc3VyZSBpZiB0aGlzIGlzIHRoZSByZWFzb24g
TGFycnkgdXBsb2FkZWQgYSBjb3B5IG9mIHZlbmRvciBkcml2ZXINCnRvIGhpcyByZXBvc2l0b3J5
IFsxXS4gDQoNClJlY2VudGx5LCB3ZSByZWNlaXZlZCB2dWxuZXJhYmlsaXR5IHJlcG9ydCBvZiBy
dHdfbXBfZWZ1c2Vfc2V0KCkgaW4NCnZlbmRvciBkcml2ZXIuIEknZCBsaWtlIHRvIGtub3cgaWYg
cGVvcGxlIGFyZSBzdGlsbCB1c2luZyB0aGUgdmVuZG9yDQpkcml2ZXIgWzFdLiBJZiBub3QsIGlz
IGl0IHBvc3NpYmxlIHRvIHJlbW92ZSBpdD8gSWYgcGVvcGxlIHN0aWxsIG5lZWQgaXQsDQpJIHdp
bGwgc2hhcmUgdGhlIGZpeCBtYWRlIGJ5IG91ciBpbnRlcm5hbCBsYXRlci4NCg0KWzFdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydHc4OC90cmVlL21hc3Rlci9hbHRfcnRsODgyMWNlDQoN
Cj4gDQo+IFRoZSBQSFkgc3RhdHVzIHNpemUgZmllbGQgaXMgNCBiaXRzIHdpZGUsIGJ1dCBpbiBy
dHc4OCBpdHMgdmFsdWUgc2hvdWxkDQo+IG9ubHkgYmUgMCBvciA0LiBDaGVja2luZyB0aGlzIGNh
dGNoZXMgbW9zdCBvZiB0aGUgY29ycnVwdCBmcmFtZXMuDQo+IA0KPiBJZiBhIFBIWSBzdGF0dXMg
aXMgcHJlc2VudCwgdGhlIFBIWSBzdGF0dXMgc2l6ZSBzaG91bGQgbm90IGJlIDAuDQo+IA0KPiBU
aGUgZnJhbWUgc2l6ZSBzaG91bGQgbm90IGJlIGxlc3MgdGhhbiBvciBlcXVhbCB0byA0IGFuZCBz
aG91bGQgbm90DQo+IGV4Y2VlZCAxMTQ1NC4NCj4gDQo+IERpc2NhcmQgdGhlIGZyYW1lIGlmIGFu
eSBvZiB0aGVzZSBjaGVja3MgZmFpbC4NCj4gDQo+IENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjEyODYNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVy
Ymx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KWy4uLl0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9yeC5jIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9yeC5jDQo+IGluZGV4IGQ5ZTExMzQzZDQ5OC4uNjVmNmRiM2Q3ZmNi
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9yeC5jDQo+IEBAIC0z
LDYgKzMsNyBAQA0KPiAgICovDQo+IA0KPiAgI2luY2x1ZGUgIm1haW4uaCINCj4gKyNpbmNsdWRl
ICJtYWMuaCINCj4gICNpbmNsdWRlICJyeC5oIg0KPiAgI2luY2x1ZGUgInBzLmgiDQo+ICAjaW5j
bHVkZSAiZGVidWcuaCINCj4gQEAgLTI2MSw5ICsyNjIsOSBAQCBzdGF0aWMgdm9pZCBydHdfcnhf
ZmlsbF9yeF9zdGF0dXMoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwNCj4gICAgICAgICB9DQo+ICB9
DQo+IA0KPiAtdm9pZCBydHdfcnhfcXVlcnlfcnhfZGVzYyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2
LCB2b2lkICpyeF9kZXNjOCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcnR3
X3J4X3BrdF9zdGF0ICpwa3Rfc3RhdCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAqcnhfc3RhdHVzKQ0KPiAraW50IHJ0d19yeF9xdWVyeV9y
eF9kZXNjKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHZvaWQgKnJ4X2Rlc2M4LA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHJ0d19yeF9wa3Rfc3RhdCAqcGt0X3N0YXQsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAqcnhfc3Rh
dHVzKQ0KPiAgew0KPiAgICAgICAgIHUzMiBkZXNjX3N6ID0gcnR3ZGV2LT5jaGlwLT5yeF9wa3Rf
ZGVzY19zejsNCj4gICAgICAgICBzdHJ1Y3QgcnR3X3J4X2Rlc2MgKnJ4X2Rlc2MgPSByeF9kZXNj
ODsNCj4gQEAgLTMwMywxMiArMzA0LDI1IEBAIHZvaWQgcnR3X3J4X3F1ZXJ5X3J4X2Rlc2Moc3Ry
dWN0IHJ0d19kZXYgKnJ0d2Rldiwgdm9pZCAqcnhfZGVzYzgsDQo+ICAgICAgICAgICAgICAgICBw
a3Rfc3RhdC0+YncgPSBSVFdfQ0hBTk5FTF9XSURUSF8yMDsNCg0KRG8geW91IHRoaW5rIGlmIHdl
IHNob3VsZCByZXR1cm4gLUVJTlZBTCBmb3IgdGhpcyBjYXNlIHRvbz8NCg0KPiAgICAgICAgIH0N
Cj4gDQo+ICsgICAgICAgaWYgKHVubGlrZWx5KHBrdF9zdGF0LT5kcnZfaW5mb19zeiAmJg0KPiAr
ICAgICAgICAgICAgICAgICAgICBwa3Rfc3RhdC0+ZHJ2X2luZm9fc3ogIT0gUEhZX1NUQVRVU19T
SVpFKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsgICAgICAg
aWYgKHVubGlrZWx5KHBrdF9zdGF0LT5waHlfc3RhdHVzICYmICFwa3Rfc3RhdC0+ZHJ2X2luZm9f
c3opKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKyAgICAgICBp
ZiAodW5saWtlbHkocGt0X3N0YXQtPnBrdF9sZW4gPiBJRUVFODAyMTFfTUFYX01QRFVfTEVOX1ZI
VF8xMTQ1NCkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiAgICAg
ICAgIC8qIGRydl9pbmZvX3N6IGlzIGluIHVuaXQgb2YgOC1ieXRlcyAqLw0KPiAgICAgICAgIHBr
dF9zdGF0LT5kcnZfaW5mb19zeiAqPSA4Ow0KPiANCj4gICAgICAgICAvKiBjMmggY21kIHBrdCdz
IHJ4L3BoeSBzdGF0dXMgaXMgbm90IGludGVyZXN0ZWQgKi8NCj4gICAgICAgICBpZiAocGt0X3N0
YXQtPmlzX2MyaCkNCj4gLSAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiArDQo+ICsgICAgICAgaWYgKHVubGlrZWx5KHBrdF9zdGF0LT5wa3RfbGVu
IDw9IEZDU19MRU4pKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAg
ICAgICAgIHBoeV9zdGF0dXMgPSByeF9kZXNjOCArIGRlc2Nfc3ogKyBwa3Rfc3RhdC0+c2hpZnQ7
DQo+ICAgICAgICAgaGRyID0gcGh5X3N0YXR1cyArIHBrdF9zdGF0LT5kcnZfaW5mb19zejsNCg0K
Wy4uLl0NCg0K

