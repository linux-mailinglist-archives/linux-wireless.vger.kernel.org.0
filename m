Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58513CB110
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jul 2021 05:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhGPDUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 23:20:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37480 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDUy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 23:20:54 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16G3HnrtE018295, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16G3HnrtE018295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Jul 2021 11:17:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 16 Jul 2021 11:17:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 16 Jul 2021 11:17:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91]) by
 RTEXMBS04.realtek.com.tw ([fe80::5bd:6f71:b434:7c91%5]) with mapi id
 15.01.2106.013; Fri, 16 Jul 2021 11:17:48 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Difficulty connecting to AP using rtw89
Thread-Topic: Difficulty connecting to AP using rtw89
Thread-Index: AQHXedzEvSHwSXSC2EGxNTyUmGxj/atE4Ccw
Date:   Fri, 16 Jul 2021 03:17:48 +0000
Message-ID: <d74a6a489b2f466eb66df3f5f965a1fa@realtek.com>
References: <f2ee1dbd-28b5-a1e6-8f41-e7ed8dfc2521@lwfinger.net>
In-Reply-To: <f2ee1dbd-28b5-a1e6-8f41-e7ed8dfc2521@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTUg5LiL5Y2IIDA3OjIxOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: multipart/mixed;
        boundary="_002_d74a6a489b2f466eb66df3f5f965a1farealtekcom_"
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTYgpFekyCAwMTowNzowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/16/2021 02:57:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165062 [Jul 15 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {Tracking_susp_attach_format}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/16/2021 03:00:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_002_d74a6a489b2f466eb66df3f5f965a1farealtekcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnJ5IEZpbmdlciBbbWFp
bHRvOmxhcnJ5LmZpbmdlckBnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBMYXJyeSBGaW5nZXINCj4g
U2VudDogRnJpZGF5LCBKdWx5IDE2LCAyMDIxIDg6NTIgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNz
DQo+IFN1YmplY3Q6IERpZmZpY3VsdHkgY29ubmVjdGluZyB0byBBUCB1c2luZyBydHc4OQ0KPiAN
Cj4gSGksDQo+IA0KPiBJIGFtIHRyeWluZyB0byBoZWxwIHNvbWUgdXNlcnMgb2YgbXkgR2l0SHVi
IHJlcG8gZm9yIHJ0dzg5LiBTZXZlcmFsIGFyZSBoYXZpbmcNCj4gcHJvYmxlbXMgdHJ5aW5nIHRv
IGNvbm5lY3QgdG8gdGhlaXIgQVBzLiBXaGVuIHRoZWlyIEFQIHNjYW4gbGlzdHMgdGhlIGZvbGxv
d2luZzoNCj4gDQo+IFdQQToJICogVmVyc2lvbjogMQ0KPiAJICogR3JvdXAgY2lwaGVyOiBUS0lQ
DQo+IAkgKiBQYWlyd2lzZSBjaXBoZXJzOiBUS0lQDQo+IAkgKiBBdXRoZW50aWNhdGlvbiBzdWl0
ZXM6IFBTSw0KPiBSU046CSAqIFZlcnNpb246IDENCj4gCSAqIEdyb3VwIGNpcGhlcjogVEtJUA0K
PiAJICogUGFpcndpc2UgY2lwaGVyczogQ0NNUA0KPiAJICogQXV0aGVudGljYXRpb24gc3VpdGVz
OiBQU0sNCj4gCSAqIENhcGFiaWxpdGllczogMS1QVEtTQS1SQyAxLUdUS1NBLVJDICgweDAwMDAp
DQo+IA0KPiBJIGhhdmUgbm8gcHJvYmxlbXMuIE15IHNjYW4gcmVzdWx0cyBzaG93Og0KPiANCj4g
ICAgICAgICAgUlNOOiAgICAgKiBWZXJzaW9uOiAxDQo+ICAgICAgICAgICAgICAgICAgICogR3Jv
dXAgY2lwaGVyOiBDQ01QDQo+ICAgICAgICAgICAgICAgICAgICogUGFpcndpc2UgY2lwaGVyczog
Q0NNUA0KPiAgICAgICAgICAgICAgICAgICAqIEF1dGhlbnRpY2F0aW9uIHN1aXRlczogUFNLDQo+
ICAgICAgICAgICAgICAgICAgICogQ2FwYWJpbGl0aWVzOiAxNi1QVEtTQS1SQyAxLUdUS1NBLVJD
ICgweDAwMGMpDQo+IA0KPiBBdCBsZWFzdCBvbmUgb2YgdGhlbSBjYW4gY29ubmVjdCB0byBhIGhv
dHNwb3QgY3JlYXRlZCBvbiBoaXMgcGhvbmU7IGhvd2V2ZXIsIGl0DQo+IGFsc28gc2hvd3MgQ2Fw
YWJpbGl0aWVzOiAxNi1QVEtTQS1SQyAxLUdUS1NBLVJDICgweDAwMGMpLiBJIGhhdmUgdHJpZWQg
dG8NCj4gZGlzY292ZXIgd2hhdCBjYXVzZXMgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGlzIHZh
bHVlIGFuZCB0aGF0IG9mIENhcGFiaWxpdGllczoNCj4gMS1QVEtTQS1SQyAxLUdUS1NBLVJDICgw
eDAwMDApLiBObyBtYXR0ZXIgaG93IEkgc2V0dXAgbXkgQVBzLCBJIGFsd2F5cyBnZXQNCj4gMTYt
UFRLU0EtUkMuDQo+IA0KPiBDYW4gYW55b25lIGhlbHAgbWUgdW5kZXJzdGFuZCB0aGlzIHByb2Js
ZW0/DQo+IA0KDQpIaSBMYXJyeSwNCg0KSSdtIG5vdCBzdXJlIGlmIHRoZSBwcm9ibGVtIHRoZSB1
c2VycyBtZXQgaXMgcmVsYXRlZCB0byBzZWN1cml0eSBvciBub3QuDQpCdXQsIHdlIGhhdmUgYSBz
b2x1dGlvbiB0byBkZWFsIHdpdGggc2ltaWxhciBzeW1wdG9tLiANClBsZWFzZSBhcHBseSBhbmQg
dHJ5IGF0dGFjaGVkIHBhdGNoIHRvIHNlZSBpZiBpdCBpcyBoZWxwZnVsLg0KDQotLQ0KUGluZy1L
ZQ0KDQoNCg==

--_002_d74a6a489b2f466eb66df3f5f965a1farealtekcom_
Content-Type: application/octet-stream;
	name="20210702_00_init_tp_regs.patch"
Content-Description: 20210702_00_init_tp_regs.patch
Content-Disposition: attachment; filename="20210702_00_init_tp_regs.patch";
	size=1389; creation-date="Fri, 16 Jul 2021 02:27:03 GMT";
	modification-date="Fri, 16 Jul 2021 02:27:03 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3JlZy5oIGIvcmVnLmgKaW5kZXggNTFiNTk2OS4uYmJiMGZmMCAxMDA2NDQK
LS0tIGEvcmVnLmgKKysrIGIvcmVnLmgKQEAgLTEzNzksNiArMTM3OSw4IEBACiAjZGVmaW5lIFJf
QVhfUFdSX0xNVF9NQVggMHhEMzM4CiAjZGVmaW5lIFJfQVhfUFdSX1JVX0xNVCAweEQzM0MKICNk
ZWZpbmUgUl9BWF9QV1JfUlVfTE1UX01BWCAweEQzNjgKKyNkZWZpbmUgUl9BWF9QV1JfTUFDSURf
VEFCTEUwIDB4RDM2QworI2RlZmluZSBSX0FYX1BXUl9NQUNJRF9UQUJMRTEyNyAweEQ1NjgKIAog
I2RlZmluZSBSX0FYX1RYUFdSX0lNUiAweEQ5RTAKICNkZWZpbmUgUl9BWF9UWFBXUl9JTVJfQzEg
MHhGOUUwCmRpZmYgLS1naXQgYS9ydHc4ODUyYS5jIGIvcnR3ODg1MmEuYwppbmRleCA3NzY5ZThi
Li43MGM5NjBiIDEwMDY0NAotLS0gYS9ydHc4ODUyYS5jCisrKyBiL3J0dzg4NTJhLmMKQEAgLTEw
OTcsNiArMTA5NywxNSBAQCBzdGF0aWMgdm9pZCBydHc4ODUyYV9iYl9yZXNldChzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYsCiAJcnR3ODlfcGh5X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9QMV9UU1NJ
X1RSSywgQl9QMV9UU1NJX1RSS19FTik7CiB9CiAKK3N0YXRpYyB2b2lkIHJ0dzg4NTJhX2JiX21h
Y2lkX2N0cmxfaW5pdChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsCisJCQkJCWVudW0gcnR3ODlf
cGh5X2lkeCBwaHlfaWR4KQoreworCXUzMiBhZGRyOworCisJZm9yIChhZGRyID0gUl9BWF9QV1Jf
TUFDSURfVEFCTEUwOyBhZGRyIDw9IFJfQVhfUFdSX01BQ0lEX1RBQkxFMTI3OyBhZGRyICs9IDQp
CisJCXJ0dzg5X21hY190eHB3cl93cml0ZTMyKHJ0d2RldiwgcGh5X2lkeCwgYWRkciwgMCk7Cit9
CisKIHN0YXRpYyB2b2lkIHJ0dzg4NTJhX2JiX3NldGh3KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rl
dikKIHsKIAlydHc4OV9waHlfd3JpdGUzMl9jbHIocnR3ZGV2LCBSX1AwX0VOX1NPVU5EX1dPX05E
UCwgQl9QMF9FTl9TT1VORF9XT19ORFApOwpAQCAtMTExNyw2ICsxMTI2LDggQEAgc3RhdGljIHZv
aWQgcnR3ODg1MmFfYmJfc2V0aHcoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQogCXJ0dzg5X3Bo
eV93cml0ZTMyX2lkeChydHdkZXYsIFJfTUFDX1NFTCwgQl9NQUNfU0VMX01PRCwgMHgwLCBSVFc4
OV9QSFlfMSk7CiAJcnR3ODlfcGh5X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9ORFBfQlJLMCwgQl9O
RFBfUlVfQlJLKTsKIAlydHc4OV9waHlfd3JpdGUzMl9zZXQocnR3ZGV2LCBSX05EUF9CUksxLCBC
X05EUF9SVV9CUkspOworCisJcnR3ODg1MmFfYmJfbWFjaWRfY3RybF9pbml0KHJ0d2RldiwgUlRX
ODlfUEhZXzApOwogfQogCiBzdGF0aWMgdm9pZCBydHc4ODUyYV9iYnJzdF9mb3JfcmZrKHN0cnVj
dCBydHc4OV9kZXYgKnJ0d2RldiwK

--_002_d74a6a489b2f466eb66df3f5f965a1farealtekcom_--
