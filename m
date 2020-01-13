Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1011138C81
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 08:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMHtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 02:49:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:35391 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgAMHtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 02:49:09 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00D7n6s9025323, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00D7n6s9025323
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 15:49:06 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 13 Jan 2020 15:49:06 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 13 Jan 2020 15:49:05 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Mon, 13 Jan 2020 15:49:05 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: RE: [rtw88] purge skb(s) not reported by firmware
Thread-Topic: [rtw88] purge skb(s) not reported by firmware
Thread-Index: AQHVxgumpbelFNHZSEWWibZh50EtlafoNYPw
Date:   Mon, 13 Jan 2020 07:49:05 +0000
Message-ID: <fe3cd3c3d4364ef4bfb14b5ac3fcee1d@realtek.com>
References: <CABXGCsNu+nih5nZkuavoYot0eo5pF7quD4JviN+vWctPdmbu=A@mail.gmail.com>
In-Reply-To: <CABXGCsNu+nih5nZkuavoYot0eo5pF7quD4JviN+vWctPdmbu=A@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBTdWJqZWN0OiBbcnR3ODhdIHB1cmdlIHNrYihzKSBub3QgcmVwb3J0ZWQgYnkgZmlybXdhcmUN
Cj4gDQo+IEhpIGZvbGtzLg0KPiBJIHJlY2VudGx5IGpvaW5lZCB0ZXN0aW5nIHRoZSBydHc4OCBk
cml2ZXIuDQo+IEluIGp1c3QgYSBmZXcgZGF5cywgSSBhbHJlYWR5IGNhdGNoZXMgc3VjaCBXQVJO
SU5HIHR3aWNlIHRpbWVzOg0KPiANCj4gDQo+IFsgNDg5OS42MDE2NTZdIHJ0d19wY2kgMDAwMDow
NTowMC4wOiBmYWlsZWQgdG8gc2VuZCBoMmMgY29tbWFuZA0KPiBbIDkwODQuNjYxMzgyXSBydHdf
cGNpIDAwMDA6MDU6MDAuMDogZmlybXdhcmUgZmFpbGVkIHRvIHJlc3RvcmUgaGFyZHdhcmUNCj4g
c2V0dGluZw0KPiBbIDkwODUuMTY3MzY0XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0t
LS0tLS0NCj4gWyA5MDg1LjE2NzM3MF0gcHVyZ2Ugc2tiKHMpIG5vdCByZXBvcnRlZCBieSBmaXJt
d2FyZQ0KPiBbIDkwODUuMTY3NDE3XSBXQVJOSU5HOiBDUFU6IDkgUElEOiAwIGF0DQo+IGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdHguYzoxNTUNCj4gcnR3X3R4X3JlcG9ydF9w
dXJnZV90aW1lcisweDIwLzB4NTAgW3J0dzg4XQ0KPiBbIDkwODUuMTY3NDE5XSBNb2R1bGVzIGxp
bmtlZCBpbjogdWlucHV0IHJmY29tbSB4dF9DSEVDS1NVTQ0KPiB4dF9NQVNRVUVSQURFIHh0X2Nv
bm50cmFjayBpcHRfUkVKRUNUIG5mX25hdF90ZnRwIG5mX2Nvbm50cmFja190ZnRwDQoNCi4uLg0K
DQo+IFsgOTA4NS4xNjc1OTZdICBkb19pZGxlKzB4MWU0LzB4MjgwDQo+IFsgOTA4NS4xNjc1OTld
ICBjcHVfc3RhcnR1cF9lbnRyeSsweDE5LzB4MjANCj4gWyA5MDg1LjE2NzYwM10gIHN0YXJ0X3Nl
Y29uZGFyeSsweDE2Mi8weDFiMA0KPiBbIDkwODUuMTY3NjA2XSAgc2Vjb25kYXJ5X3N0YXJ0dXBf
NjQrMHhiNi8weGMwDQo+IFsgOTA4NS4xNjc2MTBdIC0tLVsgZW5kIHRyYWNlIGY3MzRmMmIxYmM0
MGViZGIgXS0tLQ0KPiBbMTIxMTEuNTA1OTAxXSBydHdfcGNpIDAwMDA6MDU6MDAuMDogZmFpbGVk
IHRvIHNlbmQgaDJjIGNvbW1hbmQNCj4gWzEyMTExLjUwNTk1Nl0gcnR3X3BjaSAwMDAwOjA1OjAw
LjA6IGZhaWxlZCB0byBzZW5kIGgyYyBjb21tYW5kDQo+IA0KPiANCj4gWWVzLCBpdCBzZWVtcyBs
aWtlIG5vdGhpbmcgYmFkIGhhcHBlbmVkLCBleGNlcHQgZnJlcXVlbnQgbmV0d29yayBkaXNjb25u
ZWN0Lg0KPiBVbmZvcnR1bmF0ZWx5IEkgZG9uJ3Qga25vdyBob3cgZXhhY3RseSByZXByb2R1Y2Ug
aXQuDQo+IEJ1dCBJIHRoaW5rIGlmIHNvbWVvbmUgcHJvcG9zZSBwYXRjaCBhbmQgdGhpcyBXQVJO
SU5HIGFmdGVyIGFwcGx5aW5nDQo+IGRpZG4ndCBhcHBlYXJzIGFnYWlubiBhdCBsZWFzdCBhIHdl
ZWsgdGhlbiB3ZSBjYW4gYXNzdW1lIHRoYXQgdGhlDQo+IHByb2JsZW0gaXMgZml4ZWQuDQo+IA0K
DQpJdCBzZWVtcyBsaWtlIHRoZSBmaXJtd2FyZSBpcyBub3QgcmVzcG9uc2l2ZSwgYW5kIGlzIG5v
dCByZXBvcnRpbmcgVFgNCnN0YXR1cyBvciBjb25zdW1pbmcgSDJDIGNvbW1hbmRzLg0KVGhlIGZp
cnN0IHRyYWNlIGR1bXAgInB1cmdlIHNrYihzKSBub3QgcmVwb3J0ZWQgYnkgZmlybXdhcmUiIHdp
bGwgYmUNCnByaW50ZWQgd2hlbiBkcml2ZXIgdGltZWQtb3V0IGZvciBUWCBzdGF0dXMgcmVwb3J0
LiBJdCBjb3VsZCBoYXBwZW4NCnNvbWV0aW1lcyB3aGVuIGRyaXZlciB0dXJucyBwb3dlciBvZmYg
dG9vIHF1aWNrbHkgYWZ0ZXIgZGUtYXV0aCBzZW50Lg0KT3IgZmlybXdhcmUganVzdCBtaXNzZWQg
aXQuIE9yaWdpbmFsbHkgSSB3YXMgdGhpbmtpbmcgdGhhdCB0aGUgVFggc3RhdHVzDQptaXNzaW5n
IG1lYW5zIHRoYXQgdGhlIGZpcm13YXJlIGlzIG5vdCB3b3JraW5nLCBidXQgc2VlbXMgaXQncyBu
b3QNCnRydWUuIFNvIEkgdGhpbmsgSSBtaWdodCBsb3dlciB0aGUgcHJpbnQgbGV2ZWwgKFdBUk4o
KSAtPiBydHdfd2FybigpKS4NCg0KQnV0IGZyb20geW91ciBrZXJuZWwgbG9nIEkgY2FuIHNlZSB0
aGF0IHRoZSBoMmMgY29tbWFuZHMgZmFpbGVkIHRvDQpiZSBzZW50IHRvIGZpcm13YXJlLCB3aGlj
aCBtZWFucyB0aGVyZSdzIGFub3RoZXIgdGhpbmdzIHRoYXQgY2F1c2UNCmZpcm13YXJlIHRvIHN0
YWxsLiBJdCB3aWxsIGJlIGJldHRlciBpZiB5b3UgY2FuIHR1cm4gdGhlIGRlYnVnIG1hc2tzIG9u
LA0KYW5kIHJlcHJvZHVjZSBpdCwgdG8gaGVscCBtZSBzbyBzZWUgd2hhdCBoYXBwZW5lZC4NClRv
IHR1cm4gdGhlIGRlYnVnIG1hc2tzIG9uOg0KJCBlY2hvIDB4ZmZmZmZmZmYgPiAvc3lzL21vZHVs
ZS9ydHc4OC9wYXJhbWV0ZXJzL2RlYnVnX21hc2sNCg0KWWFuLUhzdWFuDQo=
