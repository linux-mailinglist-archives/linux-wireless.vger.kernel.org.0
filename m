Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE3705CCE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 04:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEQCG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 22:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjEQCGW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 22:06:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77E44A2
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 19:06:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34H25neC6014842, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34H25neC6014842
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 17 May 2023 10:05:49 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 17 May 2023 10:05:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 May 2023 10:05:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 17 May 2023 10:05:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: RE: wifi: rtw88: questions about adding support for RTL8723DS/RTL8723BS
Thread-Topic: wifi: rtw88: questions about adding support for
 RTL8723DS/RTL8723BS
Thread-Index: AQHZiBUHd0S4VV0iKkiPBKMPZ9aJLa9drFkQ
Date:   Wed, 17 May 2023 02:05:57 +0000
Message-ID: <5a47af41569c4f0b91d6d2bc054586d0@realtek.com>
References: <CAFBinCD=HVyedXpqRfAC=m3A=wstDbtQfLDZqjHufSawdLKwiw@mail.gmail.com>
In-Reply-To: <CAFBinCD=HVyedXpqRfAC=m3A=wstDbtQfLDZqjHufSawdLKwiw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTWFydGluLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcnRp
biBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xlbWFpbC5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgTWF5IDE3LCAyMDIzIDEyOjQwIEFNDQo+IFRvOiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0PjsgdG9ueTA2MjBlbW1h
QGdtYWlsLmNvbTsgamVybmVqLnNrcmFiZWNAZ21haWwuY29tDQo+IFN1YmplY3Q6IHdpZmk6IHJ0
dzg4OiBxdWVzdGlvbnMgYWJvdXQgYWRkaW5nIHN1cHBvcnQgZm9yIFJUTDg3MjNEUy9SVEw4NzIz
QlMNCj4gDQo+IEhlbGxvIFBpbmctS2UsDQo+IA0KPiBhcyBhIG5leHQgc3RlcCBJIHdhbnQgdG8g
YWRkIHN1cHBvcnQgZm9yIFJUV19XQ1BVXzExTiBTRElPIGNhcmRzIHRvDQo+IHRoZSBydHc4OCBk
cml2ZXIuDQo+IEN1cnJlbnRseSBvbmx5IG9uZSBSVFdfV0NQVV8xMU4gY2hpcCBpcyBzdXBwb3J0
ZWQ6IFJUTDg3MjNEIGJ5IHRoZQ0KPiBydHc4OCAoUENJZSBhbmQgVVNCIEhDSXMpLg0KDQpPcmln
aW5hbGx5LCB3ZSBpbnRlbmRlZCB0byBhZGQgODcyM0QgdG8gcnRsd2lmaSwgYmVjYXVzZSBpdCBp
cyBhIDgwMi4xMW4gY2hpcA0KYW5kIHZlcnkgc2ltaWxhciB0byA4NzIzQkUuIEhvd2V2ZXIsIGl0
cyBQQ0llIEhDSSBpcyBjaGFuZ2VkIHRvIHVzZSBjaXJjdWxhcg0KcmluZyBpbnN0ZWFkIG9mIG93
biBiaXQsIGxpa2Ugb3RoZXIgY2hpcHMgaW1wbGVtZW50ZWQgaW4gcnR3ODguDQoNCj4gDQo+IE15
IGZpcnN0IHF1ZXN0aW9uIGlzIHZlcnkgaG9wZWZ1bGx5IGEgc2ltcGxlIG9uZToNCj4gSXQgc2Vl
bXMgdGhhdCBSVEw4NzIzRFMgaGFzIHR3byBTRElPIElEczogMHhkNzIzIGFuZCAweGQ3MjQuDQo+
IERvIHRoZXNlIGhhdmUgdGhlIHNhbWUgbmFtZSBvciBpcyB0aGVyZSBzb21lIGtpbmQgb2YgInJl
dmlzaW9uIiAobGlrZQ0KPiByZXYgMiwgcmV2aXNpb24gQiwgLi4uKSBpbnRlcm5hbGx5Pw0KDQow
eGQ3MjMgaXMgZHVhbCBhbnRlbm5hLCBhbmQgMHhkNzI0IGlzIHNpbmdsZSBhbnRlbm5hLiBTaW5j
ZSA4NzIzRCBpcyBhDQoxeDEgV2lGaSBCVCBjb21ibyBjaGlwLCAweGQ3MjMgY2FuIGhhdmUgYSBk
ZWRpY2F0ZWQgYW50ZW5uYSBmb3IgQlQuDQpUaGUgbWFpbiBkaWZmZXJlbmNlIHdpbGwgYmUgQlQt
Y29leCBjb2RlLg0KDQo+IA0KPiBNeSBzZWNvbmQgcXVlc3Rpb24gaXMgbW9yZSBhYnN0cmFjdDoN
Cj4gQmFzZWQgb24gbXkgdW5kZXJzdGFuZGluZyBvZiB0aGUgdmVuZG9yIGRyaXZlcnMgZm9yIFJU
TDg3MjNCUyBhbmQNCj4gUlRMODcyM0RTIGJvdGggc2VlbSB2ZXJ5IGNsb3NlIGluIHRlcm1zIG9m
IHJlZ2lzdGVycy4gaW5pdGlhbGl6YXRpb24NCj4gc2VxdWVuY2UsIC4uLg0KPiBTbyBJIGFtIGhv
cGluZyB0aGF0IGl0J3MgcG9zc2libGUgdG8gYWRkIFJUTDg3MjNCUyBzdXBwb3J0IHRvIHRoZSBy
dHc4OCBkcml2ZXIuDQo+IFRoZXJlJ3MgdHdvIG1haW4gZGlmZmVyZW5jZXMgdGhhdCBJIGZvdW5k
IHNvIGZhcjoNCj4gLSBydHdfZHVtcF9od19mZWF0dXJlKCkgZG9lc24ndCB3b3JrIGJlY2F1c2Ug
UkVHX0MySEVWVCBoYXMgYW4NCj4gaW5jb3JyZWN0IHZhbHVlIChDMkhfSFdfRkVBVFVSRV9SRVBP
UlQgaXMgZXhwZWN0ZWQgYnV0IGl0IHN0aWxsDQo+IGNvbnRhaW5zIEMySF9IV19GRUFUVVJFX0RV
TVApLiBJdCBzZWVtcyB0aGF0IHRoaXMgaXMgYSBmaXJtd2FyZSBpc3N1ZS4NCg0KTm90IGFuIGlz
c3VlLiBBdCB0aGF0IG1vbWVudCBvZiBkZXZlbG9waW5nIDg3MjNCLCBhcHBsaWNhdGlvbnMgYXJl
IHNpbXBsZSwgc28NCndlIGRvbid0IHJlYWQgZmVhdHVyZSBmcm9tIGZpcm13YXJlLCBzbyBqdXN0
IGlnbm9yZSB0aGlzIGZvciA4NzIzQi4NCg0KPiAtIFRoZSB3aG9sZSBsdGVjb2V4IHN1cHBvcnQg
KG15IHVuZGVyc3RhbmRpbmcgaXM6IHRoaXMgaXMgcGFydCBvZiB0aGUNCj4gQmx1ZXRvb3RoIDQu
MiBzcGVjIGJ1dCBSVEw4NzIzQlMgd2FzIG9yaWdpbmFsbHkgZGV2ZWxvcGVkIGZvciB0aGUNCj4g
Qmx1ZXRvb3RoIDQuMCBzcGVjKSBzZWVtcyBtaXNzaW5nIGluIHRlcm1zIG9mIGFsbCByZXF1aXJl
ZCByZWdpc3RlcnMuDQo+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIGEgaGFyZHdhcmUgb3IgZmly
bXdhcmUgdG9waWMuDQoNClNlZWluZyBCVC1jb2V4IG9mIHJ0bHdpZmkgb3IgdmVuZG9yIGRyaXZl
ciwgeW91IGNhbiBmaW5kIGVhY2ggY2hpcCBoYXMNCml0cyBvd24gQlQtY29leCBmaWxlcyBvZiAx
LzIgYW50ZW5uYS4gV2hlbiBkZXZlbG9waW5nIHJ0dzg4LCB3ZSB0cnkgdG8NCmludGVncmF0ZSB0
aGVtIHRvZ2V0aGVyLiBTbywgeW91IG1pZ2h0IHRha2UgdGltZSB0byBjb21wYXJlIEJULWNvZXgg
Y29kZQ0Kb2YgdmVuZG9yIGRyaXZlciBiZXR3ZWVuIDg3MjNCIGFuZCA4NzIzRCwgYW5kIHRoZW4g
aW1wbGVtZW50IHRoZWlyDQpkaWZmZXJlbmNlLiBJIHN1Z2dlc3QgeW91IGNhbiBwZW5kaW5nIHRo
aXMgd29yayBhcyB0aGUgbGFzdCBzdGVwLg0KDQo+IA0KPiBIYXZlIHlvdSBjb25zaWRlcmVkIGFk
ZGluZyBSVFc4NzIzQiBzdXBwb3J0IHRvIHRoZSBydHc4OCBkcml2ZXI/DQo+IERvIHlvdSBoYXZl
IHNvbWUgaW5pdGlhbCBzdWdnZXN0aW9ucyBvbiB3aGF0IHdvdWxkIGJlIG5lZWRlZCB0byBkbyBz
bw0KPiAoaXMgbXkgbGlzdCBmcm9tIGFib3ZlIGNvbXBsZXRlLCB3aGF0IGRvIGRvIGFib3V0IHRo
ZXNlIHBvaW50cywgLi4uKT8NCg0KQXMgbXkgY29tbWVudCBhYm92ZSwgODcyM0JFIHVzZSBkaWZm
ZXJlbnQgUENJZSBkZXNpZ24sIGFuZCBydGx3aWZpDQpoYXMgYmVlbiBzdXBwb3J0ZWQgaXQsIHNv
IEkgZG9uJ3QgaGF2ZSBwbGFuIHRvIHN1cHBvcnQgODcyM0JFIGluIHJ0dzg4Lg0KQnV0LCB0byBh
ZGQgODcyM0JTIHRvIHJ0dzg4IHNlZW1zIHdvcmthYmxlLiANCg0KVG8gYWRkIDg3MjNCLCB5b3Ug
Y2FuIG1ha2UgYSBjb3B5IGZyb20gODcyM0QgYW5kIGNoYW5nZSBzZXR0aW5ncyBhbG9uZw0Kd2l0
aCB2ZW5kb3IgZHJpdmVyLiBUaGUgbWFpbiB0aGluZ3MgeW91IG5lZWQgdG8gcmV2aWV3IGFyZToN
CjEuIFBDSSBwcm9iZSB3aGVuIHBsdWdnaW5nIHdpZmkgY2FyZA0KMi4gaGFyZHdhcmUgaW5pdGlh
bGl6YXRpb24gd2hlbiBpbnRlcmZhY2UgdXANCjMuIFJGIGNhbGlicmF0aW9uIHdoZW4gc3RhcnRp
bmcgY29ubmVjdGlvbiAoeW91IG1heSBwdXQgdGhpcyB3b3JrIGxhdGVyKQ0KNC4gY29ubmVjdGlv
biBzZXR0aW5nIGFmdGVyIGNvbm5lY3RlZA0KNS4gQlQtY29leCB5b3UgaGF2ZSBtZW50aW9uZWQg
DQoNCg0KVG8gbWFrZSBydGx3aWZpIHN1cHBvcnQgU0RJTyBpcyBhbm90aGVyIHdheS4gSXQgc2Vl
bXMgbGlrZSBhZGQgYSBIQ0kgaXMNCmVhc2llciB0aGFuIGFuIG5ldyBjaGlwLCBhbmQgd2UgY2Fu
IGhhdmUgYSBzaW1wbGUgc3VwcG9ydCBsaXN0IG9mIHJ0bHdpZmkNCmFuZCBydHc4OCBldmVudHVh
bGx5LCBsaWtlDQoNCiAgICAgICAgcnRsd2lmaSAgICAgICBydHc4OA0KODcyM0JFICAgIG8NCjg3
MjNCUyAgICBvPw0KODcyM0RFICAgICAgICAgICAgICAgICAgbw0KODcyM0RTICAgICAgICAgICAg
ICAgICAgbw0KDQo+IA0KPiBUaGVyZSdzIGEgaHVnZSBudW1iZXIgb2YgYm9hcmRzIHdpdGggUlRM
ODcyM0JTIG91dCB0aGVyZSBhbmQgSSB0aGluaw0KPiB0aGV5IGNvdWxkIGJlbmVmaXQgZnJvbSB0
aGUgcnR3ODggZHJpdmVyIChhbmQgc28gd2UgY2FuIGZpbmFsbHkgZ2V0DQo+IHJpZCBvZiBkcml2
ZXJzL3N0YWdpbmcvcnRsODcyM2JzLykuDQoNCkFncmVlLiBUaGF0IHdpbGwgYmUgaGVscGZ1bCBm
b3IgTGludXggdXNlcnMuDQoNClBpbmctS2UNCg0K
