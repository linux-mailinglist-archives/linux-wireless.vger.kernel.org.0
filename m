Return-Path: <linux-wireless+bounces-20201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9825A5D41E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 02:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1785E176B8C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BBF78F30;
	Wed, 12 Mar 2025 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tB7cP+KI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9FA31;
	Wed, 12 Mar 2025 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743751; cv=none; b=mYCUbIkUY1jvzToZTYGhrpTfmIfB7IzIvRsZS9D8ry4ibfFGS+EWCf7DAlhI/uENxzPfttbnyVkVLBwxswo5++qv/esDuLtqtjktbIBlmosZ4Yy+o/LfGdvOvJ8g6HhvGiyTikLA2CxpT8ZP+bu2p7SSxQeAcGj+sPFZf+hxNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743751; c=relaxed/simple;
	bh=3ZNFjzKaBKAoPjUtV1RfIwNaccwh2ftQTmUm0kMYKgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsxyNcA+fKo3wFnxNgswfzoKWCcpfTubsf28H9ai6urPqAAuq0MEKNoRXZMbAU198vsg7z/h+fnCZKxXXOsFr+wWMR/qWlAv9N/uXrrX9NgFmX0XFzDY+uuNhK9jsb2p7IdjHdm1kBmVjgMXgq/sku3prh4w4eClF8G9W2Awqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tB7cP+KI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52C1fHAN12736145, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741743677; bh=3ZNFjzKaBKAoPjUtV1RfIwNaccwh2ftQTmUm0kMYKgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tB7cP+KIKykrkT1bMvFu8rnhBDAmHxKh41Aysgnh+G/ILx4E1ZWJqY9GQGgUhkigN
	 0AnfKId6/hkVLbDwVsX8jyWr+ba+H9y4hQ8v9V/PSs1ixmMulcpAIKAZvHPBIs0O1B
	 nwqWQ3/Xm5xEzRcUOB9OIqBpvHTa1p5Hqy7ZT8DQVQFhIFzfBAlVHMDxQLiFuXb1rl
	 roRARmiCY2kADz+KMnRji1oWhXfj1Q0BX5CzjNmOCBxg/pNhoMwtPa5JH/WKoknbnx
	 4/c1MAD+ZKguM0yxNFdPJmgaCEGBsfm3FdLJLjIV9u6fqXOuG3MGKrHzvOWelF1vP0
	 QMchfrfCKSX0A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52C1fHAN12736145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 09:41:17 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Mar 2025 09:41:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Mar 2025 09:41:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 12 Mar 2025 09:41:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shengyu Qu <wiagn233@outlook.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com"
	<ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        Peter Chiu
	<chui-hao.chiu@mediatek.com>
Subject: RE: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
Thread-Topic: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
Thread-Index: AQHbhR5aH07pByuLs0WROQG/lfQWAbNtNTQAgAEaIBA=
Date: Wed, 12 Mar 2025 01:41:15 +0000
Message-ID: <e144d2ffe9924d81a7b60f38cdcf516a@realtek.com>
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
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

U2hlbmd5dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5jb20+IHdyb3RlOg0KPiANCj4gSGkgU2hpaCwN
Cj4gDQo+IENhbiB5b3UgYWxzbyBnaXZlIHRoaXMgcGF0Y2ggYSByZXZpZXc/IFNlZW1zIEkgYWxz
byBuZWVkIHRvIGNvbnZlcnQgdG8NCj4gcmV2ZXJzZSBYbWFzIHRyZWUgb3JkZXIgZm9yIHRoaXMg
cGF0Y2gsIHdpbGwgZG8gaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpZZXMuIFBsZWFzZSBkbyBpdC4N
Cg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBTaGVuZ3l1DQo+IA0KPiDlnKggMjAyNS8yLzIyIDE5
OjM4LCBTaGVuZ3l1IFF1IOWGmemBkzoNCj4gPiBUaGUgdG9rZW4gaWQgaW4gUnhETUFEIG1heSBi
ZSBpbmNvcnJlY3Qgd2hlbiBpdCBpcyBub3QgdGhlIGxhc3QgZnJhbWUNCj4gPiBkdWUgdG8gV0VE
IEhXIGJ1Zy4gTG9va3VwIGNvcnJlY3QgdG9rZW4gaWQgYnkgcGh5c2ljYWwgYWRkcmVzcyBpbiBz
ZHAwLg0KPiA+DQo+ID4gRG93bnN0cmVhbSBwYXRjaCBsaW5rOg0KPiBodHRwczovL2dpdDAxLm1l
ZGlhdGVrLmNvbS9wbHVnaW5zL2dpdGlsZXMvb3BlbndydC9mZWVkcy9tdGstb3BlbndydC1mZWVk
cy8rLzczNzM0MDMyMmFiMjJiMTM4ZmQyMDBlMDINCj4gMGQ2MWZmZGJlM2UzNmE5L2F1dG9idWls
ZC9hdXRvYnVpbGRfNS40X21hYzgwMjExX3JlbGVhc2UvbXQ3OTg4X3dpZmk3X21hYzgwMjExX21s
by9wYWNrYWdlL2tlcm5lbC9tdDc2DQo+IC9wYXRjaGVzLzAwNjItbXRrLXdpZmktbXQ3Ni1tdDc5
MTUtd2VkLWZpbmQtcngtdG9rZW4tYnktcGh5c2ljYWwtYS5wYXRjaA0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRlay5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogU2hlbmd5dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5jb20+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2RtYS5jIHwgMjUgKysrKysr
KysrKysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvZG1hLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L2RtYS5jDQo+ID4gaW5kZXggODQ0YWYxNmVlNTUxLi41YmY2MzAxNDI2M2MgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCj4gPiBAQCAtNDQ0
LDkgKzQ0NCwzMiBAQCBtdDc2X2RtYV9nZXRfYnVmKHN0cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1
Y3QgbXQ3Nl9xdWV1ZSAqcSwgaW50IGlkeCwNCj4gPiAgIAltdDc2X2RtYV9zaG91bGRfZHJvcF9i
dWYoZHJvcCwgY3RybCwgYnVmMSwgZGVzY19pbmZvKTsNCj4gPg0KPiA+ICAgCWlmIChtdDc2X3F1
ZXVlX2lzX3dlZF9yeChxKSkgew0KPiA+ICsJCXUzMiBpZCwgZmluZCA9IDA7DQo+ID4gICAJCXUz
MiB0b2tlbiA9IEZJRUxEX0dFVChNVF9ETUFfQ1RMX1RPS0VOLCBidWYxKTsNCj4gPiAtCQlzdHJ1
Y3QgbXQ3Nl90eHdpX2NhY2hlICp0ID0gbXQ3Nl9yeF90b2tlbl9yZWxlYXNlKGRldiwgdG9rZW4p
Ow0KPiA+ICsJCXN0cnVjdCBtdDc2X3R4d2lfY2FjaGUgKnQ7DQo+ID4gKw0KPiA+ICsJCWlmICgq
bW9yZSkgew0KDQpCZWNhdXNlIG9mIHNjb3BlLCBzaG91bGQgZGVmaW5lICdmaW5kJyAob3IgJ2Zv
dW5kJz8pIGFzIGJvb2wgaGVyZS4NCg0KPiA+ICsJCQlzcGluX2xvY2tfYmgoJmRldi0+cnhfdG9r
ZW5fbG9jayk7DQo+ID4gKw0KPiA+ICsJCQlpZHJfZm9yX2VhY2hfZW50cnkoJmRldi0+cnhfdG9r
ZW4sIHQsIGlkKSB7DQoNCmlkcl9maW5kKCkgY2FuIG9ubHkgZ2V0IGEgcG9pbnRlciBhc3NvY2lh
dGVkIHdpdGggdGhlIElELiBOb3Qgc3VyZSBpZiBpdCBjYW4NCmhhdmUgYSByZXZlcnNlIHdheSAt
LSBnZXQgSUQgZnJvbSBwb2ludGVyLiBXaXRoIHNlcXVlbnRpYWwgc2VhcmNoIGluIGRhdGEgcGF0
aCwNCmNvc3QgaXMgaGlnaGVyLg0KDQpNYXliZSB5b3UgY2FuIGNvbnNpZGVyIHRvIGJ1aWxkIGFz
c29jaWF0aW9uIGJldHdlZW4gYXJndW1lbnQgJ2lkeCcgYW5kDQpwb2ludGVyL3Rva2VuIGJ5IGFu
b3RoZXIgcGF0Y2guDQoNCkJ1dCBsb2dpYyBpcyBva2F5IHRvIG1lLg0KDQo+ID4gKwkJCQlpZiAo
dC0+ZG1hX2FkZHIgPT0gbGUzMl90b19jcHUoZGVzYy0+YnVmMCkpIHsNCj4gPiArCQkJCQlmaW5k
ID0gMTsNCj4gPiArCQkJCQl0b2tlbiA9IGlkOw0KPiA+ICsNCj4gPiArCQkJCQkvKiBXcml0ZSBj
b3JyZWN0IGlkIGJhY2sgdG8gRE1BKi8NCj4gPiArCQkJCQl1MzJwX3JlcGxhY2VfYml0cygmYnVm
MSwgaWQsDQo+ID4gKwkJCQkJCQkgIE1UX0RNQV9DVExfVE9LRU4pOw0KPiA+ICsJCQkJCVdSSVRF
X09OQ0UoZGVzYy0+YnVmMSwgY3B1X3RvX2xlMzIoYnVmMSkpOw0KPiA+ICsJCQkJCWJyZWFrOw0K
PiA+ICsJCQkJfQ0KPiA+ICsJCQl9DQo+ID4gKw0KPiA+ICsJCQlzcGluX3VubG9ja19iaCgmZGV2
LT5yeF90b2tlbl9sb2NrKTsNCj4gPiArCQkJaWYgKCFmaW5kKQ0KPiA+ICsJCQkJcmV0dXJuIE5V
TEw7DQo+ID4gKwkJfQ0KPiA+DQo+ID4gKwkJdCA9IG10NzZfcnhfdG9rZW5fcmVsZWFzZShkZXYs
IHRva2VuKTsNCj4gPiAgIAkJaWYgKCF0KQ0KPiA+ICAgCQkJcmV0dXJuIE5VTEw7DQo+ID4NCg0K

