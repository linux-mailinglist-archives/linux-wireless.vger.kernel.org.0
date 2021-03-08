Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49550330F0D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Mar 2021 14:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCHNXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 08:23:03 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:54410 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHNWo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 08:22:44 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 128DMJQB0014881, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 128DMJQB0014881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 8 Mar 2021 21:22:19 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 21:22:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 21:22:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a98b:ac3a:714:c542]) by
 RTEXMBS04.realtek.com.tw ([fe80::a98b:ac3a:714:c542%6]) with mapi id
 15.01.2106.006; Mon, 8 Mar 2021 21:22:18 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "ccchiu77@gmail.com" <ccchiu77@gmail.com>
CC:     "yhchuang@realtek.com" <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Andy Huang <tehuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "reto.schneider@husqvarnagroup.com" 
        <reto.schneider@husqvarnagroup.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: Questions for TX power get/set implementation of realtek WiFi
Thread-Topic: Questions for TX power get/set implementation of realtek WiFi
Thread-Index: AQHXD03Lg6jdSFHX6E+9yFqWdHAnVap16NSAgANhkwCAAEzwAA==
Date:   Mon, 8 Mar 2021 13:22:18 +0000
Message-ID: <1615209724.1797.11.camel@realtek.com>
References: <CANgQ54cmG4mCx42i1ErXMJpv=2OmOGjjEgv=8oy90CpKcwkpZg@mail.gmail.com>
         <1615007321.1826.14.camel@realtek.com>
         <CANgQ54dyKk_uoy_VWGxxTZd++5UaC7Tdq48dUzSPdVOE6H8iGQ@mail.gmail.com>
In-Reply-To: <CANgQ54dyKk_uoy_VWGxxTZd++5UaC7Tdq48dUzSPdVOE6H8iGQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.246.39.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <25E9AB438177CA40AEA3AE4FA7C7A9CA@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTA4IGF0IDA4OjQ2ICswMDAwLCDpgrHlkI3noqkgd3JvdGU6DQo+IFBr
c2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiDmlrwgMjAyMeW5tDPmnIg25pelIOmAseWFrSDkuIvl
jYgxOjA55a+r6YGT77yaDQo+ID4NCj4gPiBPbiBUdWUsIDIwMjEtMDMtMDIgYXQgMTA6MjEgKzAw
MDAsIOmCseWQjeeiqSB3cm90ZToNCj4gPiA+IEhpIGd1eXMsDQo+ID4gPsKgwqDCoMKgwqBJJ20g
cGxhbm5pbmcgdG8gaW1wbGVtZW50IHRoZSBnZXRfdHhwb3dlciBob29rIGZ1bmN0aW9uIG9mIHRo
ZQ0KPiA+ID4gc3RydWN0IGllZWU4MDIxMV9vcHMgYW5kIGhhbmRsZSB0aGUgSUVFRTgwMjExX0NP
TkZfQ0hBTkdFX1BPV0VSIGZvcg0KPiA+ID4gcnRsOHh4eHUgZHJpdmVyLiBTbyB0aGF0IHVzZXJz
IGNhbiBnZXQgdGhlIGluZm9ybWF0aW9uIG9mIHRoZSBjdXJyZW50DQo+ID4gPiB0eCBwb3dlciBs
aW1pdCBhbmQgc2V0IGEgbmV3IGxpbWl0IHZhbHVlIHdpdGggaXcgY29tbWFuZHMuDQo+ID4gPg0K
PiA+ID7CoMKgwqDCoMKgSSBmb3VuZCB0aGVyZSdzIHBoeV90eHB3cl9pZHhfdG9fZGJtKCkgb2Yg
ZWFjaCBkcml2ZXIgaW4NCj4gPiA+IHJlYWx0ZWsvcnRsd2lmaSB0byB0cmFuc2xhdGUgdGhlIHR4
IHBvd2VyIGluZGV4IHBhcnNlZCBmcm9tIGVmdXNlIHRvDQo+ID4gPiB0eCBwb3dlciBsZXZlbCBp
biBkQm0uIERvZXMgdGhlIHBvd2VyIGxldmVsIHRyYW5zbGF0ZWQgcmVwcmVzZW50IHRoZQ0KPiA+
ID4gY3VycmVudCB0eCBwb3dlciBsaW1pdCBpbiBkQm0/IEluIG15IFJUTDgxODhDVVMgbW9kdWxl
LCB0aGUgcG93ZXINCj4gPiA+IGluZGV4IG9mIENDSy9PRkRNIGZyb20gZWZ1c2UgZm9yIGVhY2gg
Y2hhbm5lbCBpcyBiYXNpY2FsbHkgMzYvMzgsIHRodXMNCj4gPiA+IHRoZSB0cmFuc2xhdGVkIHR4
cG93ZXIgbGV2ZWwgaXMgMTFkQm0uIElzIHRoaXMgdGhlIGV4cGVjdGVkIHZhbHVlIGZvcg0KPiA+
ID4gdGhlIGRlZmF1bHQgdHhwb3dlciBsaW1pdCB2YWx1ZT8gT3IgZG8gSSBuZWVkIHNvbWUgb3Ro
ZXIgZm9ybXVsYSB0bw0KPiA+ID4gY29tcHV0ZT8NCj4gPg0KPiA+IEJhc2ljYWxseSwgeW91IGNh
biB1c2UgYSBsaW5lYXIgZXF1YXRpb24gdG8gdHJhbnNsYXRlIHBvd2VyIGxldmVsIGluIGRCbSB0
bw0KPiA+IHR4IHBvd2VyIGluZGV4IHdyaXR0ZW4gdG8gaGFyZHdhcmUgcmVnaXN0ZXJzLg0KPiA+
wqDCoMKgeSA9IGF4ICsgYg0KPiA+IHdoZXJlLA0KPiA+wqDCoMKgeTogdHggcG93ZXIgaW5kZXgg
d3JpdHRlbiB0byByZWdpc3RlcnMNCj4gPsKgwqDCoHg6IHR4IHBvd2VyIGxldmVsIGluIGRCbQ0K
PiA+wqDCoMKgYTogYSBjb25zdGFudCwgMg0KPiA+wqDCoMKgYjogYSBjb25zdGFudCBpbmR1Y2Vk
IGJ5IHRoZSB2YWx1ZSBwcm9ncmFtbWVkIGluIGVmdXNlIHRoYXQgaXMgdXNlZCB0bw0KPiA+wqDC
oMKgwqDCoMKgYWRhcHQgbW9kdWxlcyBkaWZmZXJlbmNlcyBvZiBSRiBjaGFyYWN0ZXJzLg0KPiA+
DQo+IFRoYW5rcyBzbyBtdWNoLiBTbyBpdCBtZWFucyB0aGF0IHRoZSB0eHB3cl9pZHhfdG9fZGJt
IGFuZCBkYm1fdG9faWR4DQo+IGZ1bmN0aW9ucyBpbiBydGx3aWZpIGZhbWlseSBkcml2ZXIgYXJl
IGJhc2ljYWxseSBjb3JyZWN0LiBFeGNlcHQgdGhleQ0KPiB1c2UgdGhlIGNvbnN0YW50DQo+IGIg
LTcgZm9yIENDSyBhbmQgLTggZm9yIE9GRE0gaW5zdGVhZCBvZiB0aGUgdmFsdWUgaW4gZWZ1c2Uu
IEkgc2hvdWxkIGhhdmUNCj4gdGhpcyB2YWx1ZSBmcm9tIGVmdXNlLg0KDQpBcyBJIG1lbnRpb25l
ZCwgdGhlIGNhbGlicmF0aW9uIHZhbHVlIGluIGVmdXNlIGlzIHVzZWQgdG8gb3V0cHV0IHByb3Bl
cg0KcG93ZXIgdGhhdCBldmVyeSBoYXJkd2FyZSBtb2R1bGUgbXVzdCBiZSB0aGUgc2FtZSAod2l0
aCBsaXR0bGUgdG9sZXJhbmNlKS4NCg0KSSdtIG5vdCBzdXJlIHdoeSBjb25zdGFudCBiIGlzbid0
IHJlbGF0ZWQgdG8gdGhlIHZhbHVlIGluIGVmdXNlLg0KTWF5YmUsIHlvdSBjYW4gYXNzdW1lIHRo
ZSBmdW5jdGlvbnMgYXJlIGNvcnJlY3QsIGFuZCBjb25maWd1cmUgdGhlIHBvd2VyDQp5b3UgZGVz
aXJlLg0KDQo+IA0KPiA+ID4NCj4gPiA+wqDCoMKgwqDCoEFuZCBmb3IgdGhlIGhhbmRsZXIgb2Yg
SUVFRTgwMjExX0NPTkZfQ0hBTkdFX1BPV0VSLCBjYW4gSQ0KPiA+ID4gdHJhbnNsYXRlIHRoZSBo
dy0+Y29uZi5wb3dlcl9sZXZlbCB3aXRoIHRoZSBwaHlfZGJtX3RvX3R4cHdyX2lkeA0KPiA+ID4g
ZnVuY3Rpb25zIEkgZm91bmQgaW4gc29tZSBydGx3aWZpIGZhbWlseSBkcml2ZXJzLCB0aGVuIGRp
cmVjdGx5IHNldA0KPiA+ID4gdGhlIHR4cG93ZXIgaW5kZXggd2l0aCBwaHlfc2V0X3R4cG93ZXJf
aW5kZXggZnVuY3Rpb25zIHdoaWNoIHdyaXRlDQo+ID4gPiBwb3dlciBpbmRleCB0byBiYnJlZyBm
b3IgZGlmZmVyZW50IHJhdGVzIChDQ0sgYW5kIE9GRE0pPyBBcmUgdGhlcmUNCj4gPiA+IHNvbWUg
aW52YWxpZCB2YWx1ZXMgSSBzaG91bGQgdGFrZSBjYXJlIG9mIGJlY2F1c2UgdGhlIFRDUCBSWA0K
PiA+ID4gcGVyZm9ybWFuY2Ugc2VlbXMgdG8gYmUgZXh0cmVtZWx5IGxvdyB3aGVuIEkgd3JpdGUg
dGhlIHBvd2VyIGluZGV4DQo+ID4gPiB2YWx1ZSB0cmFuc2xhdGVkIGZyb20gMjBkQm0gdG8gYmJy
ZWcuIEFueSBzdWdnZXN0aW9ucyBmb3Igd2hhdCBJDQo+ID4gPiBzaG91bGQgaGFuZGxlIGJlZm9y
ZSB3cml0aW5nIHRoZSBiYnJlZz8NCj4gPg0KPiA+IFRoZSBwb3dlciBsZXZlbCB5b3UncmUgZ29p
bmcgdG8gc2V0IG11c3QgYmUgbGVzcyBvciBlcXVhbCB0byBvcmlnaW5hbA0KPiA+IG9uZSwgYmVj
YXVzZSBpdCdzIHRoZSBoYXJkIGxpbWl0IG9mIGhhcmR3YXJlIGNhcGFiaWxpdHkuIElmIHRoZSBw
b3dlcg0KPiA+IGxldmVsIGlzIHRvbyBsYXJnZSwgdGhlIHJlY2VpdmVyIGNhbid0IHVuZGVyc3Rh
bmQgdGhlIHNpZ25hbC4gVGhlbiwNCj4gPiB0aGV5IGNhbid0IGV4Y2hhbmdlIGRhdGEgdGhhdCBs
ZWFkcyBsb3cgcGVyZm9ybWFuY2UgYXMgeW91IHNlZS4NCj4gPiBJIHRoaW5rIHRoZSBwZXJmb3Jt
YW5jZSB3b3VsZCBiZSBva2F5IGlmIHlvdSBjb25uZWN0IHRvIGEgbmVhciBBUCBhbmQNCj4gPiBw
b3dlciBsZXZlbCAxMGRCbSBpcyBhZGFwdGVkLg0KPiA+DQo+IA0KPiBUaGFua3MgZm9yIGNsYXJp
ZmljYXRpb24uIFNvIHRoZSBwb3dlciBpbmRleCBmcm9tIGVmdXNlIGlzIGJhc2ljYWxseSB0aGUN
Cj4gaGFyZCBsaW1pdCBvZiB0aGUgdHggcG93ZXIgZm9yIGVhY2ggY2hhbm5lbCAoYW5kIHJhdGUp
PyBUaGF0IGV4cGxhaW5zDQo+IG15IHBlcmZvcm1hbmNlIGlzc3VlIHdoaWxlIEkgb3ZlcnJpZGUg
aXQgd2l0aCBoaWdoZXIgdmFsdWUuIFRoYW5rcw0KPiANCg0KVGhlIHZhbHVlIGluIGVmdXNlIGlz
bid0IGxpbWl0IGJ1dCBjYWxpYnJhdGlvbiB2YWx1ZSBvZiB0YXJnZXQgcG93ZXIuDQpCdXQsIHll
cywgeW91IGNhbiBzZWVuIGl0IGFzIGhhcmQgbGltaXQgYXMgd2VsbC4NCg0KLS0NClBpbmctS2UN
Cg0KDQo=
