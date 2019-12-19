Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16770125DF0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 10:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLSJpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 04:45:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34242 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 04:45:23 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBJ9jFDW003133, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBJ9jFDW003133
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 17:45:15 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 19 Dec 2019 17:45:15 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Dec 2019 17:45:15 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Thu, 19 Dec 2019 17:45:15 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] ath10k: allow dynamic SAR power limits to be configured
Thread-Topic: [PATCH 2/2] ath10k: allow dynamic SAR power limits to be
 configured
Thread-Index: AQHVtbqgmfC7L3CRJUO4KPQhAXkz/6fAsHQA
Date:   Thu, 19 Dec 2019 09:45:14 +0000
Message-ID: <1576748714.7758.18.camel@realtek.com>
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
         <1576684108-30177-3-git-send-email-kvalo@codeaurora.org>
In-Reply-To: <1576684108-30177-3-git-send-email-kvalo@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.95]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E4378CAE2EA9E4480D1745429D99BF2@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTE4IGF0IDE3OjQ4ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBG
cm9tOiBXZW4gR29uZyA8d2dvbmdAY29kZWF1cm9yYS5vcmc+DQo+IA0KPiBBZGQgc3VwcG9ydCBm
b3IgYSB2ZW5kb3IgY29tbWFuZCBmb3IgU1RBVElPTiwgdGhlIGNvbW1hbmQNCj4gUUNBX05MODAy
MTFfVkVORE9SX1NVQkNNRF9TRVRfU0FSX0xJTUlUUyB3aGljaCBpcyBhbHJlYWR5IGRlZmluZWQg
aW4NCj4gZ2l0Oi8vdzEuZmkvaG9zdGFwLmdpdCAoc3JjL2NvbW1hbmQvcWNhLXZlbmRvci5oKS4g
VGhpcyBhbGxvd3MgdXNlcg0KPiBzcGFjZSB0byBjb25maWd1cmUgcG93ZXIgbGltaXRzIGZvciAy
LjQgR0h6IGFuZCA1IEdIeiBiYW5kcy4NCj4gDQo+IGF0aDEwayBzZXQgcGRldiBwYXJhbWV0ZXIg
V01JX1BERVZfUEFSQU1fVFhQT1dFUl9MSU1JVDJHIGFuZA0KPiBXTUlfUERFVl9QQVJBTV9UWFBP
V0VSX0xJTUlUNUcgdG8gZmlybXdhcmUsIHRoZSAyIHZhbHVlIHdpbGwNCj4gYmUgdXNlZCBhcyBv
bmUgaW5wdXQgc291cmNlIHRvIGFmZmVjdCB0aGUgdHggcG93ZXIuDQo+IA0KPiBXaGVuIFFDQV9O
TDgwMjExX1ZFTkRPUl9TVUJDTURfU0VUX1NBUl9MSU1JVFMgc2V0IHRvIGF0aDEwaywgaXQgd2ls
bA0KPiBiZSBzYXZlZCB0aGUgMi40RyBhbmQgNUcgbGltaXQgdmFsdWUsIElmIFNUQVRJT04gaXMg
Y29ubmVjdGVkIG1lYW53aGlsZSwNCj4gdGhlbiB0aGUgMi40RyBhbmQgNUcgV01JIGNvbW1hbmQg
d2lsbCBiZSBzZXQgdG8gZmlybXdhcmUsIG90aGVyd2lzZQ0KPiBpdCB3aWxsIG5vdCBzZXQgdG8g
ZmlybXdhcmUgYXQgdGhpcyBtb21lbnQuIFdoZW4gU1RBVElPTiBjb25uZWN0DQo+IG5leHQgdGlt
ZSwgaXQgd2lsbCBzZXQgdG8gZmlybXdhcmUuDQo+IA0KPiBUZXN0ZWQgd2l0aCBRQ0E2MTc0IFNE
SU8gd2l0aCBmaXJtd2FyZSBXTEFOLlJNSC40LjQuMS0wMDAyOS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFdlbiBHb25nIDx3Z29uZ0Bjb2RlYXVyb3JhLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS2Fs
bGUgVmFsbyA8a3ZhbG9AY29kZWF1cm9yYS5vcmc+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2F0aC9hdGgxMGsvTWFrZWZpbGUgfMKgwqDCoDEgKw0KPiDCoGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2F0aC9hdGgxMGsvY29yZS5jwqDCoMKgfMKgwqDCoDIgKw0KPiDCoGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2F0aC9hdGgxMGsvY29yZS5owqDCoMKgfMKgwqDCoDIgKw0KPiDCoGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvaHcuaMKgwqDCoMKgwqB8wqDCoMKgMyArDQo+IMKgZHJp
dmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway9tYWMuY8KgwqDCoMKgfMKgwqA2NCArKysrKysr
KysrKysrKysrKw0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvbWFjLmjCoMKg
wqDCoHzCoMKgwqAyICstDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway92ZW5k
b3IuYyB8IDExNA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway92ZW5kb3IuaCB8wqDCoDEzICsrKysNCj4gwqBkcml2
ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTBrL3dtaS5owqDCoMKgwqB8wqDCoMKgNiArKw0KPiDC
oDkgZmlsZXMgY2hhbmdlZCwgMjA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway92ZW5kb3Iu
Yw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTBr
L3ZlbmRvci5oDQo+IA0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9hdGgvYXRoMTBrL3dtaS5oDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEw
ay93bWkuaA0KPiBpbmRleCA5NzJkNTNkNzc2NTQuLmYwY2FkYWExMjM5OSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway93bWkuaA0KPiArKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9hdGgvYXRoMTBrL3dtaS5oDQo+IEBAIC0zNjk1LDYgKzM2OTUsMTIgQEAg
c3RydWN0IHdtaV9jc2FfZXZlbnQgew0KPiDCoCNkZWZpbmUgVkRFVl9ERUZBVUxUX1NUQVRTX1VQ
REFURV9QRVJJT0TCoMKgwqDCoDUwMA0KPiDCoCNkZWZpbmUgUEVFUl9ERUZBVUxUX1NUQVRTX1VQ
REFURV9QRVJJT0TCoMKgwqDCoDUwMA0KPiDCoA0KPiArLyogdGhlIG1hc2sgb2YgNCBzdWIgYmFu
ZCBvZiA1RyBmb3IgU0FSIHBhcmFtZXRlcnMgKi8NCj4gKyNkZWZpbmUgQVRIMTBLX1dNSV9TQVJf
NUdfMF9NQVNLIEdFTk1BU0soNywgMCkNCj4gKyNkZWZpbmUgQVRIMTBLX1dNSV9TQVJfNUdfMV9N
QVNLIEdFTk1BU0soMTUsIDgpDQo+ICsjZGVmaW5lIEFUSDEwS19XTUlfU0FSXzVHXzJfTUFTSyBH
RU5NQVNLKDIzLCAxNikNCj4gKyNkZWZpbmUgQVRIMTBLX1dNSV9TQVJfNUdfM19NQVNLIEdFTk1B
U0soMzEsIDI0KQ0KPiArDQoNClRoZXNlIG1hc2tzIGFyZW4ndCB1c2VkLg0KRG8geW91IHVzZSAn
dTMyJyBhcyBmb3VyICd1OCcgU0FSIHBvd2VyIGxpbWl0IGZvciBmb3VyIGJhbmRzPw0KDQo+IMKg
c3RydWN0IHdtaV9wZGV2X3BhcmFtX21hcCB7DQo+IMKgCXUzMiB0eF9jaGFpbl9tYXNrOw0KPiDC
oAl1MzIgcnhfY2hhaW5fbWFzazsNCg==
