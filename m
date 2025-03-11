Return-Path: <linux-wireless+bounces-20130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20142A5B56E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 01:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C2216605D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864531E511;
	Tue, 11 Mar 2025 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HNU6/GNg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219AEEB3;
	Tue, 11 Mar 2025 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654170; cv=none; b=l6JRTTHFaJ/8qw0k6hg+UTMCrd6TW/bI6bNFcf1xaHMgdvnOOzWdZaRJ0HUQ0zg7JdCQIlHamXFv8qpt1nt60VpsbJ/YTtH+c9ETLjVamNqdtIAE82FOmnrprDu725THMK6LOv+bguPdrD5fajolFQtNqCqXA+RqbK39cjOF5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654170; c=relaxed/simple;
	bh=+gTXWp+ww/bQZiZ1qPqZqiG7Y3Y9dJMleapgR+3VQUw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHYjnqeW2K9v46EGA4lxg+EiJxfZkE6+w1YBkaIHC7wkAZA38Q4IuJoUIgn6Ro36oJzXNhsKBz1p7lu6jNGhvJuhmX5qESwm7Tx9d50u4K5Nh0kLBhRyMXCE2t2RE+5gsWOih/UwyH+7n8LVHjo12oB+sDznCtpe7C4Bp+dAee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HNU6/GNg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52B0m0Mq94021580, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741654080; bh=+gTXWp+ww/bQZiZ1qPqZqiG7Y3Y9dJMleapgR+3VQUw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HNU6/GNg9C/iGzEooeDotXPwLi/O81eRZLVpyRVDbyexTPHx3dWjJu976j1npf6LT
	 weZGyAcSvGrU7b8N8T+kewwHKtmKBOwhA5uUGPaKmja7S76VdLfLIvFJ6oNHyldTss
	 Ddq+fD4urmNyzQZh7W6Oydw9BJStD+hpenH3PSzgKXj8VuGAsJL++KTQsXmCRToVd9
	 CI4VTY2EAsGvgmOOJC2Ui/PTp/TTU+Jkdf2XMYUslfrB8o02ppmUSAFTRAcXhYvzzt
	 4IOjE89W9AXRHKC1w6BsbmBy9D2ZseGtmo46ovAVAZWpVFZP+tQUnIthX7BG8lAMNz
	 qkk9upL4ED4/w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52B0m0Mq94021580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 08:48:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 08:47:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Mar 2025 08:47:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 11 Mar 2025 08:47:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shengyu Qu <wiagn233@outlook.com>, Felix Fietkau <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com"
	<ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
        "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
        "greearb@candelatech.com" <greearb@candelatech.com>,
        "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
        "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
        "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
        "sujuan.chen@mediatek.com"
	<sujuan.chen@mediatek.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed is enabled
Thread-Topic: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed
 is enabled
Thread-Index: AQHbkD+97GjFG0DhG0q+h/KT1ZUhfbNrhPNAgAAkR4CAAAIEAIAAIakAgADK8rA=
Date: Tue, 11 Mar 2025 00:47:57 +0000
Message-ID: <349d0fbe197a40068377e889a2311cb2@realtek.com>
References: <TYCPR01MB84376C7074C566865654F05098D42@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <b6b52bfcdb614137ac63fddfdaf9cb97@realtek.com>
 <OSZPR01MB843481965BA47B030566DF2698D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <71ed8398-4619-4793-804d-77cad36e7402@nbd.name>
 <OSZPR01MB84345D44294ACA75A863ED6B98D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB84345D44294ACA75A863ED6B98D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

U2hlbmd5dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5jb20+IHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+
IEkgbW9kaWZpZWQgdGhlIHBhdGNoIGFzIHlvdSB0d28gYWR2aWNlZC4gSWYgeW91IHRoaW5rIGl0
J3Mgb2ssIHBsZWFzZQ0KPiB0ZWxsIG1lIGFuZCBJJ2xsIHNlbmQgYSB2MTAgcGF0Y2guDQo+IA0K
PiBNb2RpZmllZCBwYXRjaCBpcyBhdHRhY2hlZCBiZWxvdy4NCg0KU2luY2UgeW91IHdhbnQgcGVv
cGxlIHJldmlldyB3aG9sZSBwYXRjaCwgd2h5IG5vdCBqdXN0IHNlbmRpbmcgdjEwPw0KDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IFNoZW5neXUNCj4gDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oICAgICB8IDE1ICsrKysrKw0KPiAgIC4uLi9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jICB8IDUzICsrKysrKysrKysrKysr
KysrLS0NCj4gICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICAg
fCAxOCArKysrKy0tDQo+ICAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuaCAgIHwgIDEgKw0KPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvdXRp
bC5jICAgICB8IDM3ICsrKysrKysrKysrLS0NCj4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L3V0aWwuaCAgICAgfCAgMiArLQ0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTE1IGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCj4gaW5kZXggMTMyMTQ4ZjdiMTA3Li5iZDk0M2I4YjIwYmMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5o
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQo+IEBA
IC0yOCw2ICsyOCw5IEBADQo+IA0KPiAgICNkZWZpbmUgTVQ3Nl9UT0tFTl9GUkVFX1RIUgk2NA0K
PiANCj4gKyNkZWZpbmUgTVQ3Nl9XRURfV0RTX01JTiAgICAyNTYNCj4gKyNkZWZpbmUgTVQ3Nl9X
RURfV0RTX01BWCAgICAyNzINCj4gKw0KPiAgICNkZWZpbmUgTVRfUUZMQUdfV0VEX1JJTkcJR0VO
TUFTSygxLCAwKQ0KPiAgICNkZWZpbmUgTVRfUUZMQUdfV0VEX1RZUEUJR0VOTUFTSyg0LCAyKQ0K
PiAgICNkZWZpbmUgTVRfUUZMQUdfV0VECQlCSVQoNSkNCj4gQEAgLTczLDYgKzc2LDEyIEBAIGVu
dW0gbXQ3Nl93ZWRfdHlwZSB7DQo+ICAgCU1UNzZfV0VEX1JST19RX0lORCwNCj4gICB9Ow0KPiAN
Cj4gK2VudW0gbXQ3Nl93ZWRfc3RhdGUgew0KPiArCU1UNzZfV0VEX0RFRkFVTFQsDQo+ICsJTVQ3
Nl9XRURfQUNUSVZFLA0KPiArCU1UNzZfV0VEX1dEU19BQ1RJVkUsDQo+ICt9Ow0KPiArDQo+ICAg
c3RydWN0IG10NzZfYnVzX29wcyB7DQo+ICAgCXUzMiAoKnJyKShzdHJ1Y3QgbXQ3Nl9kZXYgKmRl
diwgdTMyIG9mZnNldCk7DQo+ICAgCXZvaWQgKCp3cikoc3RydWN0IG10NzZfZGV2ICpkZXYsIHUz
MiBvZmZzZXQsIHUzMiB2YWwpOw0KPiBAQCAtMTE2NSw2ICsxMTc0LDEyIEBAIHZvaWQgbXQ3Nl93
ZWRfZG1hX3Jlc2V0KHN0cnVjdCBtdDc2X2RldiAqZGV2KTsNCj4gICBpbnQgbXQ3Nl93ZWRfbmV0
X3NldHVwX3RjKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAq
dmlmLA0KPiAgIAkJCSAgc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwgZW51bSB0Y19zZXR1cF90
eXBlIHR5cGUsDQo+ICAgCQkJICB2b2lkICp0eXBlX2RhdGEpOw0KPiArDQo+ICtzdGF0aWMgaW5s
aW5lIGludCBtdDc2X3djaWRfYWxsb2ModTMyICptYXNrLCBpbnQgc2l6ZSkNCj4gK3sNCj4gKwly
ZXR1cm4gX19tdDc2X3djaWRfYWxsb2MobWFzaywgc2l6ZSwgTVQ3Nl9XRURfREVGQVVMVCk7DQo+
ICt9DQo+ICsNCj4gICAjaWZkZWYgQ09ORklHX05FVF9NRURJQVRFS19TT0NfV0VEDQo+ICAgdTMy
IG10NzZfd2VkX2luaXRfcnhfYnVmKHN0cnVjdCBtdGtfd2VkX2RldmljZSAqd2VkLCBpbnQgc2l6
ZSk7DQo+ICAgaW50IG10NzZfd2VkX29mZmxvYWRfZW5hYmxlKHN0cnVjdCBtdGtfd2VkX2Rldmlj
ZSAqd2VkKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21haW4uYw0KPiBpbmRleCAzYWEzMWM1Y2VmYTYuLjA3YzJjZTUxOGQ5NyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4u
Yw0KPiBAQCAtNzQ1LDggKzc0NSwxNSBAQCBpbnQgbXQ3OTE1X21hY19zdGFfYWRkKHN0cnVjdCBt
dDc2X2RldiAqbWRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCj4gICAJc3RydWN0IG10
NzkxNV92aWYgKm12aWYgPSAoc3RydWN0IG10NzkxNV92aWYgKil2aWYtPmRydl9wcml2Ow0KPiAg
IAlib29sIGV4dF9waHkgPSBtdmlmLT5waHkgIT0gJmRldi0+cGh5Ow0KPiAgIAlpbnQgaWR4Ow0K
PiArCXU4IGZsYWdzID0gTVQ3Nl9XRURfREVGQVVMVDsNCg0KSW4gcmV2ZXJzZSBYJ21hcyB0cmVl
IG9yZGVyLg0KDQo+IA0KPiAtCWlkeCA9IG10NzZfd2NpZF9hbGxvYyhkZXYtPm10NzYud2NpZF9t
YXNrLCBNVDc5MTVfV1RCTF9TVEEpOw0KPiArCWlmIChtdGtfd2VkX2RldmljZV9hY3RpdmUoJmRl
di0+bXQ3Ni5tbWlvLndlZCkgJiYNCj4gKwkgICAgIWlzX210NzkxNSgmZGV2LT5tdDc2KSkgew0K
PiArCQlmbGFncyA9IHRlc3RfYml0KE1UX1dDSURfRkxBR180QUREUiwgJm1zdGEtPndjaWQuZmxh
Z3MpID8NCj4gKwkJICAgICAgIE1UNzZfV0VEX1dEU19BQ1RJVkUgOiBNVDc2X1dFRF9BQ1RJVkU7
DQo+ICsJfQ0KPiArDQo+ICsJaWR4ID0gX19tdDc2X3djaWRfYWxsb2MobWRldi0+d2NpZF9tYXNr
LCBNVDc5MTVfV1RCTF9TVEEsIGZsYWdzKTsNCj4gICAJaWYgKGlkeCA8IDApDQo+ICAgCQlyZXR1
cm4gLUVOT1NQQzsNCj4gDQoNClsuLi5dDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCj4gaW5kZXggOWQ3OTBmMjM0ZTgyLi4xOTFm
OTY2YzNmMzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L21jdS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L21jdS5jDQo+IEBAIC0yMzg1LDEwICsyMzg1LDIwIEBAIGludCBtdDc5MTVfbWN1
X2luaXRfZmlybXdhcmUoc3RydWN0IG10NzkxNV9kZXYgKmRldikNCj4gDQo+ICAgCW10NzZfY29u
bmFjX21jdV9kZWxfd3RibF9hbGwoJmRldi0+bXQ3Nik7DQo+IA0KPiAtCWlmICgobXRrX3dlZF9k
ZXZpY2VfYWN0aXZlKCZkZXYtPm10NzYubW1pby53ZWQpICYmDQo+IC0JICAgICBpc19tdDc5MTUo
JmRldi0+bXQ3NikpIHx8DQo+IC0JICAgICFtdGtfd2VkX2dldF9yeF9jYXBhKCZkZXYtPm10NzYu
bW1pby53ZWQpKQ0KPiAtCQltdDc5MTVfbWN1X3dhX2NtZChkZXYsIE1DVV9XQV9QQVJBTV9DTUQo
Q0FQQUJJTElUWSksIDAsIDAsIDApOw0KPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX05FVF9NRURJ
QVRFS19TT0NfV0VEKQ0KDQpJbiBNVDc2LCB0aGVyZSBhcmUgdHdvIHN0eWxlczoNCiAgI2lmIElT
X0VOQUJMRUQoQ09ORklHX05FVF9NRURJQVRFS19TT0NfV0VEKQ0KICAjaWZkZWYgQ09ORklHX05F
VF9NRURJQVRFS19TT0NfV0VEDQoNCkkgdGhpbmsgYm90aCBhcmUgY29ycmVjdC4gSnVzdCB3b25k
ZXIgd2h5IG5vdCBtYWtpbmcgdGhlbSBjb25zaXN0ZW50LiANCg0KPiArCWlmIChtdGtfd2VkX2Rl
dmljZV9hY3RpdmUoJmRldi0+bXQ3Ni5tbWlvLndlZCkpIHsNCj4gKwkJaWYgKGlzX210NzkxNSgm
ZGV2LT5tdDc2KSB8fA0KPiArCQkgICAgIW10a193ZWRfZ2V0X3J4X2NhcGEoJmRldi0+bXQ3Ni5t
bWlvLndlZCkpDQo+ICsJCQlyZXQgPSBtdDc5MTVfbWN1X3dhX2NtZChkZXYsIE1DVV9XQV9QQVJB
TV9DTUQoQ0FQQUJJTElUWSksDQo+ICsJCQkJCQkwLCAwLCAwKTsNCj4gKwkJZWxzZQ0KPiArCQkJ
cmV0ID0gbXQ3OTE1X21jdV93YV9jbWQoZGV2LCBNQ1VfV0FfUEFSQU1fQ01EKFNFVCksDQo+ICsJ
CQkJCQlNQ1VfV0FfUEFSQU1fV0VEX1ZFUlNJT04sDQo+ICsJCQkJCQlkZXYtPm10NzYubW1pby53
ZWQucmV2X2lkLCAwKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJfQ0K
PiArI2VuZGlmDQo+IA0KPiAgIAlyZXQgPSBtdDc5MTVfbWN1X3NldF9td2RzKGRldiwgMSk7DQo+
ICAgCWlmIChyZXQpDQoNCg0KDQo=

