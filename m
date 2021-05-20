Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD45389B26
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 04:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhETCJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 22:09:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37700 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhETCJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 22:09:21 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 14K27bpW6007653, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 14K27bpW6007653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 May 2021 10:07:37 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 20 May 2021 10:07:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 20 May 2021 10:07:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74]) by
 RTEXMBS04.realtek.com.tw ([fe80::1d8:ba7d:61ca:bd74%5]) with mapi id
 15.01.2106.013; Thu, 20 May 2021 10:07:36 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "ccchiu77@gmail.com" <ccchiu77@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tehuang@realtek.com" <tehuang@realtek.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "reto.schneider@husqvarnagroup.com" 
        <reto.schneider@husqvarnagroup.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How does the rate adaptive mask work on Realtek WiFi driver
Thread-Topic: How does the rate adaptive mask work on Realtek WiFi driver
Thread-Index: AQHXRXeJ96JiGH6RoUuehd+sRUk43arifRnQgAigzwCAAAi9AA==
Date:   Thu, 20 May 2021 02:07:36 +0000
Message-ID: <89395bf88c4cee3986928440bb934093457a85a9.camel@realtek.com>
References: <CANgQ54dicgKSZFm3w9sbAYztFw9xBHZnt8aQMNCEfMn_twBbWQ@mail.gmail.com>
         <89da58fc162b46558d60495110fcf75f@realtek.com>
         <CANgQ54cKA5N1h1kMgS52N1acrp+pJzV3e+8vd61miSS0_VVD7Q@mail.gmail.com>
In-Reply-To: <CANgQ54cKA5N1h1kMgS52N1acrp+pJzV3e+8vd61miSS0_VVD7Q@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.16.17.72]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzUvMjAg5LiK5Y2IIDEyOjA1OjAw?=
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8B4F2F5C3B55349AD3E64257B9A073C@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 05/20/2021 01:56:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 163775 [May 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 446 446 0309aa129ce7cd9d810f87a68320917ac2eba541
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, text}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2021 01:59:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTIwIGF0IDA5OjI4ICswODAwLCDpgrHlkI3noqkgd3JvdGU6DQo+IFBr
c2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiDmlrwgMjAyMeW5tDXmnIgxNOaXpSDpgLHkupQg5LiL
5Y2IMjowOOWvq+mBk++8mg0KPiA+IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IOmCseWQjeeiqSBbbWFpbHRvOmNjY2hpdTc3QGdtYWlsLmNvbV0NCj4gPiA+
IFNlbnQ6IE1vbmRheSwgTWF5IDEwLCAyMDIxIDQ6MzYgUE0NCj4gPiA+IFRvOiBQa3NoaWg7IEFu
ZHkgSHVhbmc7IExhcnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ7IA0KPiA+ID4ga3ViYUBrZXJuZWwu
b3JnOyBrdmFsb0Bjb2RlYXVyb3JhLm9yZzsgUmV0bw0KPiA+ID4gU2NobmVpZGVyOyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IA0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiA+ID4gU3ViamVjdDogSG93IGRvZXMgdGhlIHJhdGUgYWRhcHRpdmUgbWFzayB3b3Jr
IG9uIFJlYWx0ZWsgV2lGaQ0KPiA+ID4gZHJpdmVyDQo+ID4gPiANCj4gPiA+IEhpIGd1eXMsDQo+
ID4gPiAgICAgSSBoYWQgYSBwcm9ibGVtIHdoaWxlIHZlcmlmeWluZyB0aGUgYW1wZHUgdHggdGhy
b3VnaHB1dCB3aXRoDQo+ID4gPiB0aGUNCj4gPiA+IHJ0bDh4eHh1IGRyaXZlciBvbiBSVEw4MTg4
Q1VTIG1vZHVsZS4gVGhlIHRocm91Z2hwdXQgbnVtYmVyIGlzDQo+ID4gPiByZWxhdGl2ZWx5IGdv
b2QsIDM5fjQyTWJwcyAgVENQIG9uIDIuNEdIeiBjaGFubmVsLiBIb3dldmVyLCB0aGUNCj4gPiA+
IHJldHJhbnNtaXNzaW9uIHJhdGUgaXMgaGlnaCwgaXQncyAxNSUgfiAyMSUgd2l0aCBydGw4eHh4
dSBkcml2ZXINCj4gPiA+IGFuZA0KPiA+ID4gSXQncyBhbG1vc3QgdGhlIHNhbWUgcmVzdWx0IHdp
dGggdGhlIHJ0bDgxOTJjdSBkcml2ZXIuIEkgY2FuIGdldA0KPiA+ID4gYXZlcmFnZWx5IDd+MTAl
IHJldHJhbnNtaXNzaW9uIHJhdGUgaW4gdGhlIHNhbWUgdGVzdCBiZWQgd2l0aA0KPiA+ID4gUmVh
bHRlaw0KPiA+ID4gdmVuZG9yIGRyaXZlci4NCj4gPiA+IA0KPiA+ID4gICAgIEZyb20gdGhlIGFp
ciBjYXB0dXJlLCBJIGNhbiBzZWUgdGhlIHJ0bDh4eHh1IGRyaXZlciBrZWVwDQo+ID4gPiBzZW5k
aW5nDQo+ID4gPiB0aGUgYWdncmVnYXRlZCBmcmFtZXMgaW4gTUNTNyBhbmQgZG9lc24ndCBldmVu
IGZhbGwgYmFjayB0byBsb3dlcg0KPiA+ID4gTUNTDQo+ID4gPiBpbmRleCBpbiB0aGUgc3Vic2Vx
dWVudCByZXRyaWVzLiBJIGNhbiBvbmx5IHNlZSB2ZXJ5IGZldyByZXRyaWVkDQo+ID4gPiBwYWNr
ZXRzIGJlZW4gc2VudCB3aXRoIE1DUzAgb3IgNk1icHMgZ3JhdGUuIE9uIHRoZSB2ZW5kb3IgZHJp
dmVyLA0KPiA+ID4gSSdsbA0KPiA+ID4gc2VlIHRoZSByZXRyaWVkIGFtcGR1IHBhY2tldHMgd2l0
aCBNQ1M0IGFmdGVyIDMgcmV0cmllcyB3L28gYWNrDQo+ID4gPiBmcm9tDQo+ID4gPiB0aGUgcmVj
ZWl2ZXIuDQo+ID4gPiANCj4gPiA+ICAgICBGcm9tIHRoZSByYXRlIG1hc2sgY29tbWFuZCBpc3N1
ZWQgYnkgdGhlIGgyYyBjb21tYW5kLCBJIGZvcmNlDQo+ID4gPiBib3RoDQo+ID4gPiB0aGUgcnRs
OHh4eHUgZHJpdmVyIGFuZCB2ZW5kb3IgZHJpdmVyIHRvIHVzZSB0aGUgc2FtZSByYXRlbWFzaw0K
PiA+ID4gMHhmZmZmZg0KPiA+ID4gKE1DUyAwLTcgYW5kIGIvZyByYXRlIGluY2x1ZGVkKSBhbmQg
bGVhdmUgdGhlIGFyZzAgYXMtaXMgKG1vc3RseQ0KPiA+ID4gMHhhMCkNCj4gPiA+IGFuZCBJIGV4
cGVjdCBib3RoIGRyaXZlcnMgY2FuIGRvIHRoZSByYXRlIGFkYXB0aXZlIHRoaW5nIGluIHRoZQ0K
PiA+ID4gc2FtZQ0KPiA+ID4gd2F5LCBidXQgaXQgc2VlbXMgdG8gbWFrZSBubyBkaWZmZXJlbmNl
LiBUaGUgcnRsOHh4eHUgZHJpdmVyDQo+ID4gPiBzdGlsbA0KPiA+ID4gc2VuZHMgdGhlIHBhY2tl
dHMgd2l0aCBoaWdoZXN0IE1DUy4NCj4gPiA+IA0KPiA+ID4gICAgIENhbiBhbnlvbmUgdGVsbCBt
ZSB3aGF0IHNob3VsZCBJIGV4cGVjdCB0aGUgcmF0ZSBhZGFwdGl2ZSB0bw0KPiA+ID4gd29yaw0K
PiA+ID4gd2l0aCB0aGUgcmF0ZSBtYXNrIDB4ZmZmZmYgYW5kIDB4ZjAwMDA/IERvZXMgdGhlIDB4
ZjAwMDAgbWVhbnMNCj4gPiA+IHRoYXQgaXQNCj4gPiA+IHdpbGwgcGljayB1cCBhIHR4IHJhdGUg
b25seSBiZXR3ZWVuIG5yYXRlIE1DUzQgdG8gTUNTNz8gSSBuZWVkIGENCj4gPiA+IGJhc2UNCj4g
PiA+IGxpbmUgc28gdGhhdCBJIGNhbiBqdWRnZSBpdCdzIHNpbXBseSBhIHJhdGUgbWFzayBwcm9i
bGVtIG9yIG1heWJlDQo+ID4gPiB0aGUNCj4gPiA+IGgyYyBjb21tYW5kIGlzIG5vdCB3cml0dGVu
IGNvcnJlY3RseS4gUGxlYXNlIGtpbmRseSBzdWdnZXN0IHdoYXQNCj4gPiA+IEkNCj4gPiA+IHNo
b3VsZCBkbyBuZXh0LiBUaGFua3MNCj4gPiA+IA0KPiA+IA0KPiA+IFRoZSByYXRlIG1hc2sgaW5k
aWNhdGVzIHdoaWNoIHJhdGVzIHdpbGwgYmUgdXNlZCBieSByYXRlIGFkYXB0aXZlDQo+ID4gbWVj
aGFuaXNtLg0KPiA+IEknbSBub3Qgc3VyZSB0aGUgZXhhY3QgYml0IGFsbG9jYXRpb24gZm9yIEND
Sy9PRkRNL01DUywgbWF5YmUNCj4gPiAweDAwMDBmLzB4MDBmZjAvMHhmZjAwMDAgZm9yIENDSy9P
RkRNL01DUyByZXNwZWN0aXZlbHksIGJ1dCB5b3UgY2FuDQo+ID4gdHJhY2UNCj4gPiB2ZW5kb3Ig
ZHJpdmVyIHRvIGtub3cgdGhlIGRldGFpbC4NCj4gPiANCj4gPiBJIHN1Z2dlc3QgeW91IGNhbiB0
cnkgdG8gc2VuZCBvbmx5IE9GRE0gcmF0ZSBtYXNrLCBhbmQgZXhwZWN0IHRvDQo+ID4gc2VlIE9G
RE0NCj4gPiByYXRlIG9ubHkgYnkgeW91ciBzbmlmZmVyLiBJZiBpdCdzIHN0aWxsIGtlZXAgb24g
TUNTNywgcmF0ZQ0KPiA+IGFkYXB0aXZlIG1heQ0KPiA+IG5vdCB3b3JrIHByb3Blcmx5Lg0KPiA+
IA0KPiBUaGFua3MuIFRoYXQncyBteSBleHBlY3RhdGlvbiBhbmQgSSdsbCB0cnkgdG8gdmVyaWZ5
IGl0IG9uIHZlbmRvcg0KPiBkcml2ZXIgYW5kIHVwc3RyZWFtIHJ0bDgxOTJjdSBkcml2ZXIuDQo+
IA0KPiA+IEFsc28sIHlvdSBjYW4gY29tcGFyZSB0aGUgY29udGVudCBvZiByYXRlIGFkYXB0aXZl
IEgyQyB3aXRoIHZlbmRvcg0KPiA+IGRyaXZlciB0bw0KPiA+IHNlZSBpZiB0aGUgZm9ybWF0IGlz
IGNvcnJlY3QuDQo+ID4gDQo+ID4gQW5vdGhlciB0aGluZyBpcyB0byB0cnkgJ2ZpeF9yYXRlJyBp
biB0eF9kZXNjLiBDaGVjayB0aGUgdmVuZG9yDQo+ID4gZHJpdmVyIHRvDQo+ID4ga25vdyB0aGUg
dXNlX3JhdGUvcmF0ZS9idyBmaWVsZHMgb2YgdHhfZGVzYy4gVGhlbiwgdHJ5IHRvIGZpeCB0aGUN
Cj4gPiByYXRlIHlvdQ0KPiA+IHdhbnQuDQo+ID4gDQo+IElmIEkgc2V0IHRoZSBmaXhfcmF0ZSBp
biB0eF9kZXNjLCB3aWxsIHRoZSByYXRlIG1hc2sgaW4gSDJDIGNvbW1hbmQNCj4gYmUNCj4gaWdu
b3JlZD8gT3IgdGhlIHVuZGVybHlpbmcgZmlybXdhcmUgd2lsbCBkbyB0aGUgdHggcmF0ZSBmYWxs
YmFjayBmb3INCj4gdGhlIHJldHJ5IHBhY2tldHM/DQo+IA0KDQpUaGUgcHJpb3JpdHkgb2YgZml4
IHJhdGUgaW4gdHhfZGVzYyBpcyBoaWdoZXIgdGhhbiByYXRlIG1hc2sgaW4gSDJDDQpjb21tYW5k
OyB5ZXMsIEgyQyBpcyBpZ25vcmVkLiBCdXQgaXQgc3RpbGwgZG9lcyByZXRyeSByYXRlIGZhbGxi
YWNrDQp1bmxlc3MgeW91IGRpc2FibGUgaXQgaW4gdHhfZGVzYy4NCg0KSSB0aGluayB5b3UgY2Fu
IGNsYXJpZnkgd2hldGhlciB0aGUgcmF0ZSBpcyBjb250cm9sbGVkIGJ5IGZpcm13YXJlDQpyYXRl
IGFkYXB0aXZlIG1lY2hhbmlzbSBmaXJzdC4NCg0KLS0NClBpbmctS2UNCg0KDQo=
