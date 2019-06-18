Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871284993E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfFRGrm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 02:47:42 -0400
Received: from mail-eopbgr780119.outbound.protection.outlook.com ([40.107.78.119]:1258
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfFRGrl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsedbcA4qMGfLe0gMs71IZs977j/9bgRay6RYA7JRwM=;
 b=Sc0JgWbVWExYac61d0mqqGrcQZPXoXnetNlBQXdQ9xd4qL5wdvAfKe+I9JzU3SS9q41aohyWJWFiKzQ/1jlYxoHLgYAmVeMWNSeYkmwl7Fmnl1vcJ9DWlYNitlP7AvM/jE1feC5W2epWYTJWpbVIE70E1KIQ346N23g7HoEjh4k=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB6345.namprd06.prod.outlook.com (20.178.28.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Tue, 18 Jun 2019 05:33:21 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::8cc7:f8b2:c735:8992]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::8cc7:f8b2:c735:8992%4]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 05:33:21 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Stefan Wahren <wahrenst@gmx.net>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
Thread-Topic: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
Thread-Index: AQHVI5wQ1zsNjjpn8Ea8hZQgX/OX3aac9kYAgAKJGwCAAGzAAIAA+0mA
Date:   Tue, 18 Jun 2019 05:33:20 +0000
Message-ID: <d6bfe313-3aa7-82bb-dfac-25e6261dbf63@cypress.com>
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
 <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
 <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
In-Reply-To: <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
Reply-To: Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [61.222.14.99]
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-clientproxiedby: TYAPR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::28) To DM6PR06MB5804.namprd06.prod.outlook.com
 (2603:10b6:5:1a6::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4691709-a378-4c54-cefe-08d6f3ae793e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(49563074)(7193020);SRVR:DM6PR06MB6345;
x-ms-traffictypediagnostic: DM6PR06MB6345:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR06MB63452062D7521CDB2DDFBBAEBBEA0@DM6PR06MB6345.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(3846002)(43066004)(66556008)(102836004)(6506007)(386003)(6916009)(5660300002)(5024004)(256004)(14444005)(446003)(478600001)(64126003)(2616005)(476003)(71200400001)(73956011)(66476007)(66946007)(64756008)(486006)(66446008)(26005)(53546011)(71190400001)(11346002)(7736002)(99286004)(305945005)(65826007)(52116002)(186003)(86362001)(76176011)(31696002)(8936002)(6436002)(81156014)(81166006)(2906002)(6116002)(8676002)(6246003)(229853002)(58126008)(66616009)(36756003)(54906003)(3450700001)(31686004)(6512007)(6306002)(316002)(25786009)(4326008)(53936002)(6486002)(72206003)(966005)(107886003)(99936001)(14454004)(65956001)(66066001)(65806001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB6345;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uPgs3DiAA4tL3AB3cvUFURFTy2dmY+1H7n6K9aj45tEByamRVBzAsoJyi9oVtmbmR48J3cRZ+s1jDn9JsC3ddoDg5WFPjGX1Ck4wRePD5C8ZHNfFk+pFvzB+l43Vyro9d8syPBGvpfnGdWfknsWFIDHQNOUBqWrCbSEvWxtX6lxvVhEG7amZHFzSpDxKlADulP0RgQA/tMruuZp1rCqnHXOECGTRGFd2z/aRhb6P4yMP+0TBWyiPljwpaeFpEAzQkGz5rApMneHXAvDpJ4Wd2SXcYD0OjLtUeH1aiHGla1EO2O6oEzoVKJ+O6IHmmk60MxsDgmkJl//l4BaZUjqeiudnZTlUZeCOwfFgOEXeDl+4pPXz9RWh6H6p5/ogbVdyTEGGHOpTzk19Ea2z+liRCKPeJBq9O9T6Rg0HDqKD3zA=
Content-Type: multipart/mixed;
        boundary="_002_d6bfe3133aa782bbdfac25e6261dbf63cypresscom_"
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4691709-a378-4c54-cefe-08d6f3ae793e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 05:33:21.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chln@cypress.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6345
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--_002_d6bfe3133aa782bbdfac25e6261dbf63cypresscom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBF08493617BA248A15598F39F760B4D@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64

DQoNCk9uIDA2LzE3LzIwMTkgMTA6MzMsIE1hcmNlbCBIb2x0bWFubiB3cm90ZToNCj4gSGkgQ2hp
LWhzaWVuLA0KPiANCj4+Pj4gaSB3YXMgYWJsZSB0byByZXByb2R1Y2UgYW4gKG1heWJlIG9sZGVy
IGlzc3VlKSB3aXRoIDQtd2F5IGhhbmRzaGFrZQ0KPj4+PiBvZmZsb2FkaW5nIGZvciA4MDIuMVgg
aW4gdGhlIGJyY21mbWFjIGRyaXZlci4gTXkgc2V0dXAgY29uc2lzdHMgb2YNCj4+Pj4gUmFzcGJl
cnJ5IFBpIDMgQiAoY3VycmVudCBsaW51eC1uZXh0LCBhcm02NC9kZWZjb25maWcpIG9uIFNUQSBz
aWRlIGFuZCBhDQo+Pj4+IFJhc3BiZXJyeSBQaSAzIEErIChMaW51eCA0LjE5KSBvbiBBUCBzaWRl
Lg0KPj4+DQo+Pj4gTG9va3MgbGlrZSBSYXNwYmVycnkgUGkgaXNuJ3QgdGhlIG9ubHkgYWZmZWN0
ZWQgcGxhdGZvcm0gWzNdLCBbNF0uDQo+Pj4NCj4+PiBbM10gLSBodHRwczovL2J1Z3ppbGxhLnJl
ZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE2NjU2MDgNCj4+PiBbNF0gLSBodHRwczovL2J1Z3pp
bGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwMjUyMQ0KPj4NCj4+IFN0ZWZhbiwNCj4+
DQo+PiBDb3VsZCB5b3UgcGxlYXNlIHRyeSB0aGUgYXR0YWNoZWQgcGF0Y2ggZm9yIHlvdXIgd3Bh
X3N1cHBsaWNhbnQ/IFdlJ2xsDQo+PiB1cHN0cmVhbSBpZiBpdCB3b3JrcyBmb3IgeW91Lg0KPiAN
Cj4gSSBob3BlIHRoYXQgc29tZW9uZSBpcyBhbHNvIHByb3ZpZGluZyBhIGtlcm5lbCBwYXRjaCB0
byBmaXggdGhlIGlzc3VlLiBIYWNraW5nIGFyb3VuZCBhIGtlcm5lbCBpc3N1ZSBpbiB1c2Vyc3Bh
Y2UgaXMgbm90IGVub3VnaC4gRml4IHRoZSByb290IGNhdXNlIGluIHRoZSBrZXJuZWwuDQoNCk1h
cmNlbCwNCg0KVGhpcyBpcyBhIGtlcm5lbCB3YXJuaW5nIGZvciBpbnZhbGlkIGFwcGxpY2F0aW9u
IFBNSyBzZXQgYWN0aW9ucywgc28gdGhlIA0KZml4IGlzIHRvIG9ubHkgc2V0IFBNSyB0byB3aWZp
IGRyaXZlciB3aGVuIDQtd2F5IGlzIG9mZmxvYWRlZC4gSSB0aGluayANCkFyZW5kIGFkZGVkIHRo
ZSBXQVJOX09OKCkgaW50ZW50aW9uYWxseSB0byBjYXRjaCBhcHBsaWNhdGlvbiBtaXN1c2Ugb2Yg
DQpQTUsgc2V0dGluZy4NCg0KWW91IG1heSBhbHNvIHJlbW92ZSB0aGUgd2FybmluZ3Mgd2l0aCB0
aGUgYXR0YWNoZWQgcGF0Y2gsIGJ1dCBsZXQncyBzZWUgDQp3aGF0IEFyZW5kIHNheXMgZmlyc3Qu
DQoNCg0KQXJlbmQsDQoNCkFueSBjb21tZW50Pw0KDQoNClJlZ2FyZHMsDQpDaGktaHNpZW4gTGlu
DQoNCg0KPiANCj4gUmVnYXJkcw0KPiANCj4gTWFyY2VsDQo+IA0KPiAuDQo+IA0K

--_002_d6bfe3133aa782bbdfac25e6261dbf63cypresscom_
Content-Type: text/plain;
	name="0001-brcmfmac-remove-WARN_ON-for-invalid-pmk-set.patch"
Content-Description: 0001-brcmfmac-remove-WARN_ON-for-invalid-pmk-set.patch
Content-Disposition: attachment;
	filename="0001-brcmfmac-remove-WARN_ON-for-invalid-pmk-set.patch"; size=1896;
	creation-date="Tue, 18 Jun 2019 05:33:20 GMT";
	modification-date="Tue, 18 Jun 2019 05:33:20 GMT"
Content-ID: <955D8DC093821148957E14FBF251E9BE@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBhNTRjMGU3ZGNkODE1YTVlZjMxYmRiYWJlNDQ3OTJmMmNlZGNlMGUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGktSHNpZW4gTGluIDxjaGktaHNpZW4ubGluQGN5cHJlc3Mu
Y29tPgpEYXRlOiBNb24sIDE3IEp1biAyMDE5IDIzOjQyOjIzIC0wNTAwClN1YmplY3Q6IFtQQVRD
SF0gYnJjbWZtYWM6IHJlbW92ZSBXQVJOX09OKCkgZm9yIGludmFsaWQgcG1rIHNldAoKMjUyNmZm
MjFhYTc3YygiYnJjbWZtYWM6IHN1cHBvcnQgNC13YXkgaGFuZHNoYWtlIG9mZmxvYWRpbmcgZm9y
IDgwMi4xWCIpCmFkZGVkIFdBUk5fT04oKSB0byBjYXRjaCBpbnZhbGlkIFBNSyB1c2FnZS4gUmVt
b3ZlIHRoZW0gYW5kIGtlZXAgdGhlCmVycm9yIHJldHVybiBFSU5WQUwuCgpTaWduZWQtb2ZmLWJ5
OiBDaGktSHNpZW4gTGluIDxjaGktaHNpZW4ubGluQGN5cHJlc3MuY29tPgotLS0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jIHwgNiAr
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21m
bWFjL2NmZzgwMjExLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEv
YnJjbWZtYWMvY2ZnODAyMTEuYwppbmRleCBlOWM4YjIxMDkxYTEuLjA4YjVmYWQzODMwNyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFj
L2NmZzgwMjExLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjEx
L2JyY21mbWFjL2NmZzgwMjExLmMKQEAgLTE5MzgsNyArMTkzOCw3IEBAIGJyY21mX2NmZzgwMjEx
X2Nvbm5lY3Qoc3RydWN0IHdpcGh5ICp3aXBoeSwgc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsCiAJ
fQogCiAJaWYgKHNtZS0+Y3J5cHRvLnBzaykgewotCQlpZiAoV0FSTl9PTihwcm9maWxlLT51c2Vf
ZndzdXAgIT0gQlJDTUZfUFJPRklMRV9GV1NVUF9OT05FKSkgeworCQlpZiAocHJvZmlsZS0+dXNl
X2Z3c3VwICE9IEJSQ01GX1BST0ZJTEVfRldTVVBfTk9ORSkgewogCQkJZXJyID0gLUVJTlZBTDsK
IAkJCWdvdG8gZG9uZTsKIAkJfQpAQCAtNTE3Myw3ICs1MTczLDcgQEAgc3RhdGljIGludCBicmNt
Zl9jZmc4MDIxMV9zZXRfcG1rKHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsCiAKIAkvKiBleHBlY3QgdXNpbmcgZmlybXdhcmUgc3VwcGxpY2FudCBmb3IgMVggKi8K
IAlpZnAgPSBuZXRkZXZfcHJpdihkZXYpOwotCWlmIChXQVJOX09OKGlmcC0+dmlmLT5wcm9maWxl
LnVzZV9md3N1cCAhPSBCUkNNRl9QUk9GSUxFX0ZXU1VQXzFYKSkKKwlpZiAoaWZwLT52aWYtPnBy
b2ZpbGUudXNlX2Z3c3VwICE9IEJSQ01GX1BST0ZJTEVfRldTVVBfMVgpCiAJCXJldHVybiAtRUlO
VkFMOwogCiAJaWYgKGNvbmYtPnBta19sZW4gPiBCUkNNRl9XU0VDX01BWF9QU0tfTEVOKQpAQCAt
NTE4OSw3ICs1MTg5LDcgQEAgc3RhdGljIGludCBicmNtZl9jZmc4MDIxMV9kZWxfcG1rKHN0cnVj
dCB3aXBoeSAqd2lwaHksIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCiAKIAlicmNtZl9kYmcoVFJB
Q0UsICJlbnRlclxuIik7CiAJaWZwID0gbmV0ZGV2X3ByaXYoZGV2KTsKLQlpZiAoV0FSTl9PTihp
ZnAtPnZpZi0+cHJvZmlsZS51c2VfZndzdXAgIT0gQlJDTUZfUFJPRklMRV9GV1NVUF8xWCkpCisJ
aWYgKGlmcC0+dmlmLT5wcm9maWxlLnVzZV9md3N1cCAhPSBCUkNNRl9QUk9GSUxFX0ZXU1VQXzFY
KQogCQlyZXR1cm4gLUVJTlZBTDsKIAogCXJldHVybiBicmNtZl9zZXRfcG1rKGlmcCwgTlVMTCwg
MCk7Ci0tIAoyLjEuMAoK

--_002_d6bfe3133aa782bbdfac25e6261dbf63cypresscom_--
