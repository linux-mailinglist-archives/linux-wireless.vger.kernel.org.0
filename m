Return-Path: <linux-wireless+bounces-26924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EABDB3F6E4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 09:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EA23BB89A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B41D61B7;
	Tue,  2 Sep 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="X8vcnnrQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E032F758
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799186; cv=none; b=H9H+NPqF1gx1yxpxHffW1NrP9eIo8QgcIpWwhwOsJo6bizejTKF9BE6Gk0ovpqlicZIwL0AB4F17rXZvBC5m5eH87dgV0jbwlmo4QEWe0XqCiCy+mIfI8i9XWuAGuA4UbC0csYE/SKGVqjA11xVLlO/pxxQscaEdzWv7vfs5/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799186; c=relaxed/simple;
	bh=CFlYaM4vyuydrdaCIOT8uj2tS9ukziqUIG10ei9Pg2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRMs5q4FGQwG/2TCBxADKZLxGcrBrELpCV4HxwFfYo4TBTB1yXMNkc3l3Ux7ECgLtTOSDPuKDVw9JJnqy+Y7qtcsxSsU10jBsJ4/lpPgFAEaSYUhYwzAIhTJ4bYh0YYyXOxIXD5OQtXDWB/NLKLdlaaXx17D5zFnvAUpp/fJ8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=X8vcnnrQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5827kBJk92925003, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756799171; bh=CFlYaM4vyuydrdaCIOT8uj2tS9ukziqUIG10ei9Pg2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=X8vcnnrQtq6WPlSFgDGI19+QxshW/1BYhsiF3Cl+BCN6/Yfx9zHiVQXDD7gs25Mwo
	 QxNB5OTuohM47+x6FKk3ygNRWPa4lU7UlttY3+Se2i+NPGoSJI/+Tw9TG02Tc9QNrp
	 TZxZ5gtdalDiojencREuWkGRAMbt+aA3I0RYVsnIaV7EFoniCbSU2dhv4c4R3vpUjv
	 2pnrTiLkF+jvyEf8cpUwgCsGbSpv/YNwlAUIolaRJ9j9CSEoNkKPXaS7Tf6T5XbTCo
	 MlDXoYjnvqDQbWLncZPSdwGhHZAkrnTaueEkehGuRzYbPlB3j3Z+rD4aKMT5+/SaMS
	 uYgYlJHpYqYRg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5827kBJk92925003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 15:46:11 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 2 Sep 2025 15:46:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 2 Sep 2025 15:46:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 2 Sep 2025 15:46:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH rtw-next v2] wifi: rtl8xxxu: expose efuse via debugfs
Thread-Topic: [PATCH rtw-next v2] wifi: rtl8xxxu: expose efuse via debugfs
Thread-Index: AQHcGzo8qOIpbQ+8S06Pa/OAUmY/8LR/FiDw///nRYCAAIctYA==
Date: Tue, 2 Sep 2025 07:46:11 +0000
Message-ID: <34b0594314cc4451a445222fb270cdfe@realtek.com>
References: <20250901121613.1876109-1-martin.kaistra@linutronix.de>
 <a2bc752666524249b19dfafb7912f6cc@realtek.com>
 <515e5d08-5315-415a-a406-2493871c76e6@linutronix.de>
In-Reply-To: <515e5d08-5315-415a-a406-2493871c76e6@linutronix.de>
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

TWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiBB
bSAwMi4wOS4yNSB1bSAwMzoxMiBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPiBNYXJ0aW4gS2Fp
c3RyYSA8bWFydGluLmthaXN0cmFAbGludXRyb25peC5kZT4gd3JvdGU6DQo+ID4+IFRoZSBlZnVz
ZSBjb250YWlucyB0aGUgbWFjIGFkZHJlc3MgYW5kIGNhbGlicmF0aW9uIGRhdGEuIER1cmluZw0K
PiA+PiBtYW51ZmFjdHVyaW5nIGFuZCB0ZXN0aW5nIGl0IGNhbiBiZSBuZWNlc3NhcnkgdG8gcmVh
ZCBhbmQgY2hlY2sgdGhpcw0KPiA+PiBkYXRhLg0KPiA+Pg0KPiA+PiBBZGQgYSBkZWJ1Z2ZzIGlu
dGVyZmFjZSB0byBtYWtlIGl0IGF2YWlsYWJsZSB0byB1c2Vyc3BhY2UuDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IE1hcnRpbiBLYWlzdHJhIDxtYXJ0aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRl
Pg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4g
Pj4gLS0tDQo+ID4+IENoYW5nZXMgaW4gdjI6DQo+ID4+IC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGNv
bW1lbnQNCj4gPj4gLSB1c2UgZGVidWdmc19zaG9ydF9mb3BzDQo+ID4+DQo+ID4+ICAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMgfCAyMiArKysrKysrKysrKysr
KysrKysrKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+ID4+DQo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L2Nv
cmUuYw0KPiA+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5j
DQo+ID4+IGluZGV4IDgzMWI1MDI1YzYzNDkuLmFlYTcwNmYwMjUxZDggMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+ID4+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jDQo+ID4+IEBA
IC0xOTAxLDYgKzE5MDEsMjcgQEAgc3RhdGljIHZvaWQgcnRsOHh4eHVfZHVtcF9lZnVzZShzdHJ1
Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgcHJp
di0+ZWZ1c2Vfd2lmaS5yYXcsIEVGVVNFX01BUF9MRU4sIHRydWUpOw0KPiA+PiAgIH0NCj4gPj4N
Cj4gPj4gK3N0YXRpYyBzc2l6ZV90IHJlYWRfZmlsZV9lZnVzZShzdHJ1Y3QgZmlsZSAqZmlsZSwg
Y2hhciBfX3VzZXIgKnVzZXJfYnVmLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQo+ID4+ICt7DQo+ID4+ICsgICAgICAgc3Ry
dWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYgPSBmaWxlX2lub2RlKGZpbGUpLT5pX3ByaXZhdGU7DQo+
ID4+ICsNCj4gPj4gKyAgICAgICByZXR1cm4gc2ltcGxlX3JlYWRfZnJvbV9idWZmZXIodXNlcl9i
dWYsIGNvdW50LCBwcG9zLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwcml2LT5lZnVzZV93aWZpLnJhdywgRUZVU0VfTUFQX0xFTik7DQo+ID4+ICt9DQo+ID4+
ICsNCj4gPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGVidWdmc19zaG9ydF9mb3BzIGZvcHNfZWZ1
c2UgPSB7DQo+ID4+ICsgICAgICAgLnJlYWQgPSByZWFkX2ZpbGVfZWZ1c2UsDQo+ID4+ICt9Ow0K
PiA+PiArDQo+ID4+ICtzdGF0aWMgdm9pZCBydGw4eHh4dV9kZWJ1Z2ZzX2luaXQoc3RydWN0IHJ0
bDh4eHh1X3ByaXYgKnByaXYpDQo+ID4+ICt7DQo+ID4+ICsgICAgICAgc3RydWN0IGRlbnRyeSAq
cGh5ZGlyOw0KPiA+PiArDQo+ID4+ICsgICAgICAgcGh5ZGlyID0gZGVidWdmc19jcmVhdGVfZGly
KCJydGw4eHh4dSIsIHByaXYtPmh3LT53aXBoeS0+ZGVidWdmc2Rpcik7DQo+ID4+ICsgICAgICAg
ZGVidWdmc19jcmVhdGVfZmlsZSgiZWZ1c2UiLCAwNDAwLCBwaHlkaXIsIHByaXYsICZmb3BzX2Vm
dXNlKTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+DQo+ID4gQ291bGQgeW91IHBsZWFzZSB0cnkgaWYg
dGhpcyB3b3VsZCBlbmNvdW50ZXIgYnVpbGQgZXJyb3Igd2l0aG91dA0KPiA+IENGRzgwMjExX0RF
QlVHRlM/DQo+IA0KPiBCdWlsZHMgYW5kIHJ1bnMgd2l0aG91dCBlcnJvcnMgd2hlbiBDRkc4MDIx
MV9ERUJVR0ZTIGlzIGRpc2FibGVkOg0KPiANCj4gIyBscyAvc3lzL2tlcm5lbC9kZWJ1Zy9pZWVl
ODAyMTEvcGh5MC8NCj4gcnRsOHh4eHUNCj4gDQo+IEkgYWxzbyBkb24ndCBzZWUgYW55IGJ1aWxk
IGVycm9ycyB3aGVuIERFQlVHX0ZTIGlzIGRpc2FibGVkIGNvbXBsZXRlbHkuDQoNClRoYW5rcyBm
b3IgdGhlIHRlc3QuIA0KDQoNCg==

