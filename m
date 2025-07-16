Return-Path: <linux-wireless+bounces-25503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEAB06A5F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 02:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB047564649
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 00:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28515D1;
	Wed, 16 Jul 2025 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PE1KMgtJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE72F50
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625047; cv=none; b=c8C6IT7H7kG1gt1DG1PjRgkes1kjcLEmL8j4PvCah1MIg93UQuHHcOzXFE/rS4b29bKmQbiaDtCL2atvjSlzFaG9poffggkS88U6ovDtNDXpe5zJCIN1UefD/R0S2lVTEQdbYb5Vh9NJ70KmQ5xnc0N6uMU1WuUSahuK/5NoyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625047; c=relaxed/simple;
	bh=rVz6ePMOXKefj+9FhYfRNUyvOoHTJhfyWeLzCpbsGFA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTJA24AQXGXenDchuWY7KefEfeuAcHmE4idnRzyjjrbcaUfSsjDeW3cZERGldz6LuUdxWYb8akXK0YRhkOKK9H8KKapowEPa1U3p1qJZRdg7LvpdVtVdElI66R863LwWuRmv5gNU9DSvWrqKEJOYGgZlobEqmdLSaFi5syIff68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PE1KMgtJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56G0HJUY01484796, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752625039; bh=rVz6ePMOXKefj+9FhYfRNUyvOoHTJhfyWeLzCpbsGFA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PE1KMgtJPrDm1zPUFxE5N/QvjNCqXtHoYHiAwI1lXg4+0wqL52Jk6RrB0FUUe0Bgx
	 /mlRqz10QZgwP3lrzZTtnWO5RI3P4hmDeMI6pNtO9peqGIyNIgk+ocI+5BeTmJ9MFH
	 PpjZbkDM/ZomgFneqngqDMqwdCuwGgtY3RrImToRrPP76bEuEb5iu6ZglWLr87d5nG
	 eFs/GwIhb6OhmO0oa13/nzSnLJBBYWc0eI+HvgiE7QYOSgOVaMdgQjF6n4pjPs3Htd
	 12ZXM0U/loyQ5ip6wU6HPgILbqo2VzW/Uzclx5EK8vp7oTT5EiaTxWOQws/iPJJBRu
	 gJhMr9Ucq4IsA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56G0HJUY01484796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 08:17:19 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 08:17:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 16 Jul 2025 08:17:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Wed, 16 Jul 2025 08:17:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 1/2] wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
Thread-Topic: [PATCH rtw-next v2 1/2] wifi: rtw89: Lower the timeout in
 rtw89_fw_read_c2h_reg() for USB
Thread-Index: AQHb9cDvTeQ1hJc5tUKW4VZya+p+RbQz4dmw
Date: Wed, 16 Jul 2025 00:17:19 +0000
Message-ID: <e3db33c50a7b4729947816551c5eba17@realtek.com>
References: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
In-Reply-To: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYygpIHdpdGggYSBkZWxheSBvZiAxIMK1cyBhbmQgYSB0
aW1lb3V0IG9mDQo+IDEwMDAwMDAgwrVzIGNhbiB0YWtlIH4yNTAgc2Vjb25kcyBpbiB0aGUgd29y
c3QgY2FzZSBiZWNhdXNlIHNlbmRpbmcgYQ0KPiBVU0IgY29udHJvbCBtZXNzYWdlIHRha2VzIH4y
NTAgwrVzLg0KPiANCj4gTG93ZXIgdGhlIHRpbWVvdXQgdG8gNDAwMCBmb3IgVVNCIGluIG9yZGVy
IHRvIHJlZHVjZSB0aGUgbWF4aW11bSBwb2xsaW5nDQo+IHRpbWUgdG8gfjEgc2Vjb25kLg0KPiAN
Cj4gVGhpcyBwcm9ibGVtIHdhcyBvYnNlcnZlZCB3aXRoIFJUTDg4NTFCVSB3aGlsZSBzdXNwZW5k
aW5nIHRvIFJBTSB3aXRoDQo+IFdPV0xBTiBlbmFibGVkLiBUaGUgY29tcHV0ZXIgc2F0IGZvciA0
IG1pbnV0ZXMgd2l0aCBhIGJsYWNrIHNjcmVlbg0KPiBiZWZvcmUgc3VzcGVuZGluZy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KPiAtLS0NCj4gdjI6DQo+ICAtIExvd2VyIHRoZSB0aW1lb3V0IGZvciBVU0IgaW5zdGVhZCBv
ZiBpbmNyZWFzaW5nIHRoZSBkZWxheS4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L2Z3LmMgfCA5ICsrKysrKystLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9mdy5oIHwgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9mdy5jDQo+IGluZGV4IDczYTRlYzk4OGQxNi4uYjc3NGEzMjllN2M3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+IEBAIC02NzU1LDEzICs2NzU1
LDE4IEBAIHN0YXRpYyBpbnQgcnR3ODlfZndfcmVhZF9jMmhfcmVnKHN0cnVjdCBydHc4OV9kZXYg
KnJ0d2RldiwNCj4gICAgICAgICBjb25zdCBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvICpjaGlwID0g
cnR3ZGV2LT5jaGlwOw0KPiAgICAgICAgIHN0cnVjdCBydHc4OV9md19pbmZvICpmd19pbmZvID0g
JnJ0d2Rldi0+Znc7DQo+ICAgICAgICAgY29uc3QgdTMyICpjMmhfcmVnID0gY2hpcC0+YzJoX3Jl
Z3M7DQo+IC0gICAgICAgdTMyIHJldDsNCj4gKyAgICAgICB1MzIgcmV0LCB0aW1lb3V0Ow0KPiAg
ICAgICAgIHU4IGksIHZhbDsNCj4gDQo+ICAgICAgICAgaW5mby0+aWQgPSBSVFc4OV9GV0NNRF9D
MkhSRUdfRlVOQ19OVUxMOw0KPiANCj4gKyAgICAgICBpZiAocnR3ZGV2LT5oY2kudHlwZSA9PSBS
VFc4OV9IQ0lfVFlQRV9VU0IpDQo+ICsgICAgICAgICAgICAgICB0aW1lb3V0ID0gUlRXODlfQzJI
X1RJTUVPVVRfVVNCOw0KDQpTaG91bGQgd2UgaGF2ZSBkaWZmZXJlbnQgdGltZW91dCB0aW1lcyBm
b3IgVVNCMiBhbmQgVVNCMz8gDQpUaGUgc2FtZSBxdWVzdGlvbiBmb3IgcGF0Y2ggMi8yLg0KDQpP
dGhlcndpc2UsIGxvb2tzIGdvb2QgdG8gbWUuDQoNCg0KPiArICAgICAgIGVsc2UNCj4gKyAgICAg
ICAgICAgICAgIHRpbWVvdXQgPSBSVFc4OV9DMkhfVElNRU9VVDsNCj4gKw0KPiAgICAgICAgIHJl
dCA9IHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYyhydHc4OV9yZWFkOCwgdmFsLCB2YWwsIDEsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJUVzg5X0MySF9USU1FT1VU
LCBmYWxzZSwgcnR3ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB0aW1lb3V0LCBmYWxzZSwgcnR3ZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjaGlwLT5jMmhfY3RybF9yZWcpOw0KPiAgICAgICAgIGlmIChyZXQpIHsNCj4g
ICAgICAgICAgICAgICAgIHJ0dzg5X3dhcm4ocnR3ZGV2LCAiYzJoIHJlZyB0aW1lb3V0XG4iKTsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuaCBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuaA0KPiBpbmRleCA5OGJlN2U3
MmM2ODUuLmE3MzFjMjQyZjM4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9mdy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvZncuaA0KPiBAQCAtMTE1LDYgKzExNSw4IEBAIHN0cnVjdCBydHc4OV9oMmNyZWdfc2No
X3R4X2VuIHsNCj4gICNkZWZpbmUgUlRXODlfQzJIUkVHX0hEUl9MRU4gMg0KPiAgI2RlZmluZSBS
VFc4OV9IMkNSRUdfSERSX0xFTiAyDQo+ICAjZGVmaW5lIFJUVzg5X0MySF9USU1FT1VUIDEwMDAw
MDANCj4gKyNkZWZpbmUgUlRXODlfQzJIX1RJTUVPVVRfVVNCIDQwMDANCj4gKw0KPiAgc3RydWN0
IHJ0dzg5X21hY19jMmhfaW5mbyB7DQo+ICAgICAgICAgdTggaWQ7DQo+ICAgICAgICAgdTggY29u
dGVudF9sZW47DQo+IC0tDQo+IDIuNTAuMA0KDQo=

