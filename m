Return-Path: <linux-wireless+bounces-8154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294CA8D1315
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 05:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3511F23585
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 03:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C45F44C8C;
	Tue, 28 May 2024 03:52:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D14436C
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868339; cv=none; b=e7HymfKw9C/jxJDbnkYSwbRhYNz0LH9dy3gmZzH5irxJ94aJxSZhGfhVBsqSMytMWpY8TZDlfHydMach7v6Qa2ayTMnMDfrqYU6+0II445eadAZcoVhFYzfy8fB6gLVPLZD/12vEAqyyjc/FQTeOuYFBVakh9zgWpEnpHIvdl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868339; c=relaxed/simple;
	bh=y+nP7OwPyWPY3NdMuJmudGrD0LXFt414Z2UDUeVg6YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edKUxaWwnM6WNiQ2hiLrEBwsdpsZFbWj8ZUNFfGbfaAUWlsccRX5DINg5QumWxXOrDsU/5ukbkDprx47RXZ2ZU9SYCHndVxLcHIm0o3s8kUHHNduWmcsJJFbNLPXZl7I0Xwrk3Ld/3Txp762jF/20H4bxf32RghZF1wKEj2PeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44S3q3b051927021, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44S3q3b051927021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 11:52:03 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 11:52:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 11:52:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 28 May 2024 11:52:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>
Subject: RE: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
Thread-Topic: wifi: rtw88: 8821CU hangs after some number of power-off/on
 cycles
Thread-Index: AQHasFw+pvHPaxxLgUK305GcfZdkyrGsA2eA
Date: Tue, 28 May 2024 03:52:03 +0000
Message-ID: <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
In-Reply-To: <20240527173454.459264-1-marcin.slusarz@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: yes
Content-Type: multipart/mixed;
	boundary="_002_9bfc8f01e99b43e485b2afc6ae4fd661realtekcom_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_9bfc8f01e99b43e485b2afc6ae4fd661realtekcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
SSBmb3VuZCBvdXQgdGhhdCB0aGUgcmVhc29uIGZvciB0aG9zZSBoYW5ncyBpcyBhIHBvd2VyLW9m
ZitvbiBzZXF1ZW5jZSB0aGF0J3MNCj4gdHJpZ2dlcmVkIGJ5IHRoZSBhYm92ZSBzdGVwcy4NCg0K
VG8gYXZvaWQgcG93ZXItb2ZmL29uIHNlcXVlbmNlIG9uY2UgZGV2aWNlIGJlY29tZXMgaWRsZSwg
SSB3b3VsZCBsaWtlIHRvIGFkZA0KYSBpcHNfZGlzYWJsZWQgaGVscGVyLiBQbGVhc2UgcmV2ZXJ0
IHlvdXIgY2hhbmdlcyBhbmQgYXBwbHkgbXkgYXR0YWNoZWQgcGF0Y2guDQoNCg0K

--_002_9bfc8f01e99b43e485b2afc6ae4fd661realtekcom_
Content-Type: application/octet-stream;
	name="0001-wifi-rtw88-8821cu-disable-idle-power-save-for-8821CU.patch"
Content-Description: 0001-wifi-rtw88-8821cu-disable-idle-power-save-for-8821CU.patch
Content-Disposition: attachment;
	filename="0001-wifi-rtw88-8821cu-disable-idle-power-save-for-8821CU.patch";
	size=3624; creation-date="Tue, 28 May 2024 03:48:58 GMT";
	modification-date="Tue, 28 May 2024 03:48:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMTI4NDVmMWY2YWFiNjM5Mzc1YzVmYTVlMTU2ZDQxNDc0NTcyYjkyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4KRGF0
ZTogVHVlLCAyOCBNYXkgMjAyNCAxMTo0ODoxMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6
IHJ0dzg4OiA4ODIxY3U6IGRpc2FibGUgaWRsZSBwb3dlciBzYXZlIGZvciA4ODIxQ1UKTUlNRS1W
ZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRl
bnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoaXMgY2hpcCBmYWlscyB0byByZWxpYWJseSB3
YWtlIHVwIGZyb20gcG93ZXIgb2ZmLgoKQ2hhbmdlLUlkOiBJMjk1ZGUzYzcxZmU5MWFmMzdlOGNj
MzliNzA3MjhhOGJhN2U5NGIyZgpSZXBvcnRlZC1ieTogTWFyY2luIMWabHVzYXJ6IDxtYXJjaW4u
c2x1c2FyekBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPgotLS0KIG1hYzgwMjExLmMgfCAyICstCiBtYWluLmMgICAgIHwgNCArKy0tCiBt
YWluLmggICAgIHwgMiArKwogcHMuYyAgICAgICB8IDUgKysrKy0KIHBzLmggICAgICAgfCAyICst
CiB1c2IuYyAgICAgIHwgMyArKysKIHdvdy5jICAgICAgfCAyICstCiA3IGZpbGVzIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbWFjODAyMTEu
YyBiL21hYzgwMjExLmMKaW5kZXggNzgwNzhkNjVjODhmLi41MjAyYmE3NGMyMGEgMTAwNjQ0Ci0t
LSBhL21hYzgwMjExLmMKKysrIGIvbWFjODAyMTEuYwpAQCAtOTksNyArOTksNyBAQCBzdGF0aWMg
aW50IHJ0d19vcHNfY29uZmlnKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1MzIgY2hhbmdlZCkK
IAlpZiAoKGNoYW5nZWQgJiBJRUVFODAyMTFfQ09ORl9DSEFOR0VfSURMRSkgJiYKIAkgICAgKGh3
LT5jb25mLmZsYWdzICYgSUVFRTgwMjExX0NPTkZfSURMRSkgJiYKIAkgICAgIXRlc3RfYml0KFJU
V19GTEFHX1NDQU5OSU5HLCBydHdkZXYtPmZsYWdzKSkKLQkJcnR3X2VudGVyX2lwcyhydHdkZXYp
OworCQlydHdfZW50ZXJfaXBzKHJ0d2RldiwgZmFsc2UpOwogCiBvdXQ6CiAJbXV0ZXhfdW5sb2Nr
KCZydHdkZXYtPm11dGV4KTsKZGlmZiAtLWdpdCBhL21haW4uYyBiL21haW4uYwppbmRleCA1Njdm
OWQ0MzczYzQuLjljOWVjZGRiNTA0NiAxMDA2NDQKLS0tIGEvbWFpbi5jCisrKyBiL21haW4uYwpA
QCAtMzA2LDcgKzMwNiw3IEBAIHN0YXRpYyB2b2lkIHJ0d19pcHNfd29yayhzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspCiAKIAltdXRleF9sb2NrKCZydHdkZXYtPm11dGV4KTsKIAlpZiAocnR3ZGV2
LT5ody0+Y29uZi5mbGFncyAmIElFRUU4MDIxMV9DT05GX0lETEUpCi0JCXJ0d19lbnRlcl9pcHMo
cnR3ZGV2KTsKKwkJcnR3X2VudGVyX2lwcyhydHdkZXYsIGZhbHNlKTsKIAltdXRleF91bmxvY2so
JnJ0d2Rldi0+bXV0ZXgpOwogfQogCkBAIC02NjAsNyArNjYwLDcgQEAgZnJlZToKIAlydHdfaXRl
cmF0ZV9zdGFzX2F0b21pYyhydHdkZXYsIHJ0d19yZXNldF9zdGFfaXRlciwgcnR3ZGV2KTsKIAly
dHdfaXRlcmF0ZV92aWZzX2F0b21pYyhydHdkZXYsIHJ0d19yZXNldF92aWZfaXRlciwgcnR3ZGV2
KTsKIAliaXRtYXBfemVybyhydHdkZXYtPmh3X3BvcnQsIFJUV19QT1JUX05VTSk7Ci0JcnR3X2Vu
dGVyX2lwcyhydHdkZXYpOworCXJ0d19lbnRlcl9pcHMocnR3ZGV2LCB0cnVlKTsKIH0KIAogc3Rh
dGljIHZvaWQgcnR3X2Z3X3JlY292ZXJ5X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQpk
aWZmIC0tZ2l0IGEvbWFpbi5oIGIvbWFpbi5oCmluZGV4IGQ5YWZiNTg1ZDQyMy4uNjU5YmM4NjJk
NGNhIDEwMDY0NAotLS0gYS9tYWluLmgKKysrIGIvbWFpbi5oCkBAIC0yMjgzLDYgKzIyODMsOCBA
QCBzdHJ1Y3QgcnR3X2RldiB7CiAJYm9vbCBiZWFjb25fbG9zczsKIAlzdHJ1Y3QgY29tcGxldGlv
biBscHNfbGVhdmVfY2hlY2s7CiAKKwlib29sIGlwc19kaXNhYmxlZDsKKwogCXN0cnVjdCBkZW50
cnkgKmRlYnVnZnM7CiAKIAl1OCBzdGFfY250OwpkaWZmIC0tZ2l0IGEvcHMuYyBiL3BzLmMKaW5k
ZXggYjE3MWU2MmQyZDU3Li40MWRlNGVjYzliYzMgMTAwNjQ0Ci0tLSBhL3BzLmMKKysrIGIvcHMu
YwpAQCAtMjQsOCArMjQsMTEgQEAgc3RhdGljIGludCBydHdfaXBzX3B3cl91cChzdHJ1Y3QgcnR3
X2RldiAqcnR3ZGV2KQogCXJldHVybiByZXQ7CiB9CiAKLWludCBydHdfZW50ZXJfaXBzKHN0cnVj
dCBydHdfZGV2ICpydHdkZXYpCitpbnQgcnR3X2VudGVyX2lwcyhzdHJ1Y3QgcnR3X2RldiAqcnR3
ZGV2LCBib29sIGZvcmNlKQogeworCWlmICghZm9yY2UgJiYgcnR3ZGV2LT5pcHNfZGlzYWJsZWQp
CisJCXJldHVybiAwOworCiAJaWYgKCF0ZXN0X2JpdChSVFdfRkxBR19QT1dFUk9OLCBydHdkZXYt
PmZsYWdzKSkKIAkJcmV0dXJuIDA7CiAKZGlmZiAtLWdpdCBhL3BzLmggYi9wcy5oCmluZGV4IDVh
ZTgzZDI1MjZjZi4uOTIwNTdkMDFjYmVjIDEwMDY0NAotLS0gYS9wcy5oCisrKyBiL3BzLmgKQEAg
LTE1LDcgKzE1LDcgQEAKICNkZWZpbmUgTEVBVkVfTFBTX1RSWV9DTlQJNQogI2RlZmluZSBMRUFW
RV9MUFNfVElNRU9VVAltc2Vjc190b19qaWZmaWVzKDEwMCkKIAotaW50IHJ0d19lbnRlcl9pcHMo
c3RydWN0IHJ0d19kZXYgKnJ0d2Rldik7CitpbnQgcnR3X2VudGVyX2lwcyhzdHJ1Y3QgcnR3X2Rl
diAqcnR3ZGV2LCBib29sIGZvcmNlKTsKIGludCBydHdfbGVhdmVfaXBzKHN0cnVjdCBydHdfZGV2
ICpydHdkZXYpOwogCiB2b2lkIHJ0d19wb3dlcl9tb2RlX2NoYW5nZShzdHJ1Y3QgcnR3X2RldiAq
cnR3ZGV2LCBib29sIGVudGVyKTsKZGlmZiAtLWdpdCBhL3VzYi5jIGIvdXNiLmMKaW5kZXggYTAx
ODg1MTEwOTlhLi45Y2EwNmRiNjMwMmYgMTAwNjQ0Ci0tLSBhL3VzYi5jCisrKyBiL3VzYi5jCkBA
IC04NTQsNiArODU0LDkgQEAgaW50IHJ0d191c2JfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2Ug
KmludGYsIGNvbnN0IHN0cnVjdCB1c2JfZGV2aWNlX2lkICppZCkKIAlydHdkZXYtPmhjaS5vcHMg
PSAmcnR3X3VzYl9vcHM7CiAJcnR3ZGV2LT5oY2kudHlwZSA9IFJUV19IQ0lfVFlQRV9VU0I7CiAK
KwlpZiAocnR3ZGV2LT5jaGlwLT5pZCA9PSBSVFdfQ0hJUF9UWVBFXzg4MjFDKQorCQlydHdkZXYt
Pmlwc19kaXNhYmxlZCA9IHRydWU7CisKIAlydHd1c2IgPSBydHdfZ2V0X3VzYl9wcml2KHJ0d2Rl
dik7CiAJcnR3dXNiLT5ydHdkZXYgPSBydHdkZXY7CiAKZGlmZiAtLWdpdCBhL3dvdy5jIGIvd293
LmMKaW5kZXggYzg2Y2ZjNDczNjFhLi4yMTYzZTFkYWI2MzAgMTAwNjQ0Ci0tLSBhL3dvdy5jCisr
KyBiL3dvdy5jCkBAIC02NzcsNyArNjc3LDcgQEAgc3RhdGljIGludCBydHdfd293X3Jlc3RvcmVf
cHMoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikKIAlpbnQgcmV0ID0gMDsKIAogCWlmIChydHdfd293
X25vX2xpbmsocnR3ZGV2KSAmJiBydHdkZXYtPndvdy5pcHNfZW5hYmxlZCkKLQkJcmV0ID0gcnR3
X2VudGVyX2lwcyhydHdkZXYpOworCQlyZXQgPSBydHdfZW50ZXJfaXBzKHJ0d2RldiwgZmFsc2Up
OwogCiAJcmV0dXJuIHJldDsKIH0KLS0gCjIuMjUuMQoK

--_002_9bfc8f01e99b43e485b2afc6ae4fd661realtekcom_--

