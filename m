Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B739E605489
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 02:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJTAju (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 20:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJTAjn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 20:39:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68D672B63B
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 17:39:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29K0crlO7016200, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (ews2016.realtek.com[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29K0crlO7016200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Oct 2022 08:38:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 20 Oct 2022 08:39:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 20 Oct 2022 08:39:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb]) by
 RTEXMBS04.realtek.com.tw ([fe80::add3:284:fd3d:8adb%5]) with mapi id
 15.01.2375.007; Thu, 20 Oct 2022 08:39:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     James Hilliard <james.hilliard1@gmail.com>,
        Josh Boyer <jwboyer@kernel.org>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes Sorensen" <jes.sorensen@gmail.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] rtlwifi: update firmware for rtl8192eu to v35.7
Thread-Topic: [PATCH] rtlwifi: update firmware for rtl8192eu to v35.7
Thread-Index: AQHY39DGlvsa0sCTgkyhHB1F58c9da4VIasAgAAWe4CAAT0qAA==
Date:   Thu, 20 Oct 2022 00:39:24 +0000
Message-ID: <f4f48fa5df844d9d8d270fb4310e9ff1@realtek.com>
References: <20221014132729.2107129-1-james.hilliard1@gmail.com>
 <CA+5PVA5gLBAxbR4qUSUu3vs+nunM+igokVxd=oAQ7OMD2oGiWg@mail.gmail.com>
 <CADvTj4pF_DqwYofL-PU5os7Dco=XyWJ3fY3C1Wxq35pSe=QqFQ@mail.gmail.com>
In-Reply-To: <CADvTj4pF_DqwYofL-PU5os7Dco=XyWJ3fY3C1Wxq35pSe=QqFQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzE5IOS4i+WNiCAwNjo0NTowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgSGlsbGlhcmQg
PGphbWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAx
OSwgMjAyMiA5OjMwIFBNDQo+IFRvOiBKb3NoIEJveWVyIDxqd2JveWVyQGtlcm5lbC5vcmc+DQo+
IENjOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGxpbnV4LWZpcm13YXJlQGtl
cm5lbC5vcmc7IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVzDQo+IFNvcmVuc2Vu
IDxqZXMuc29yZW5zZW5AZ21haWwuY29tPjsgQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHJ0bHdpZmk6IHVwZGF0ZSBmaXJt
d2FyZSBmb3IgcnRsODE5MmV1IHRvIHYzNS43DQo+IA0KPiBPbiBXZWQsIE9jdCAxOSwgMjAyMiBh
dCA4OjEwIEFNIEpvc2ggQm95ZXIgPGp3Ym95ZXJAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBGcmksIE9jdCAxNCwgMjAyMiBhdCA5OjI3IEFNIEphbWVzIEhpbGxpYXJkDQo+ID4gPGph
bWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgdjM1
LjcgZmlybXdhcmUgZm9yIHRoZSBydGw4MTkyZXUuDQo+ID4gPg0KPiA+ID4gVGhpcyBhZGRzIDIg
bmV3IGZpcm13YXJlIHZhcmlhbnRzIGV4dHJhY3RlZCBmcm9tIHZlbmRvciBkcml2ZXJzIHRoYXQN
Cj4gPiA+IHdlcmUgbm90IHByZXZpb3VzbHkgcHJlc2VudDoNCj4gPiA+IHJ0bDgxOTJldV9hcC5i
aW4NCj4gPiA+IHJ0bDgxOTJldV9uaWNfc2V0dXBib3guYmluDQoNCkkgdGhpbmsgdGhlc2UgdHdv
IGFyZSBub3Qgc3VpdGFibGUgdG8gcnRsOHh4eHUsIHNvIEkgc3VnZ2VzdCB0byBpZ25vcmUgdGhl
bS4NCg0KPiA+ID4NCj4gPiA+IFRoZXNlIGZpcm13YXJlIGZpbGVzIG9jY3VycyBhcyBkYXRhIHN0
YXRlbWVudHMgaW4gdGhlIGxhdGVzdCBSZWFsdGVrDQo+ID4gPiB2ZW5kb3IgZHJpdmVyIEkgZm91
bmQgZm9yIHRoZSBydGw4MTkyZXUgaW4gYWRkaXRpb24gdG8gc29tZSBvbGRlcg0KPiA+ID4gdmVu
ZG9yIGRyaXZlciByZWxlYXNlczoNCj4gPiA+IHJ0bDgxOTJFVV9XaUZpX2xpbnV4X3Y1LjExLjIu
MS0xOC1nOGU3ZGY5MTJiLjIwMjEwNTI3X0NPRVgyMDE3MTExMy0wMDQ3DQo+ID4NCj4gPiBJIGhh
dmUgbm8gaWRlYSB3aGF0IHRoaXMgaXMsIG5vciBpcyB0aGVyZSBhbnkgaW5kaWNhdGlvbiB0aGF0
IFJlYWx0ZWsNCj4gPiB3YW50cyB0aGVzZSBwdWJsaXNoZWQgdG8gdGhlIGxpbnV4LWZpcm13YXJl
IHJlcG8gdW5kZXIgcmVkaXN0cmlidXRhYmxlDQo+ID4gbGljZW5zZSB0ZXJtcy4gIFlvdSd2ZSBl
eHRyYWN0ZWQgZmlybXdhcmUgZnJvbSBlbHNld2hlcmUgYW5kIGFyZQ0KPiA+IGFzc3VtaW5nIGl0
IGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBleGlzdGluZyBsaWNlbnNlLCBidXQgdGhlcmUncyBubw0K
PiA+IGluZGljYXRpb24gdGhhdCdzIGFjdHVhbGx5IHRoZSBjYXNlLiAgVGhlIHByb3ZlbmFuY2Ug
b2YgdGhpcyBmaXJtd2FyZQ0KPiA+IGlzIHF1ZXN0aW9uYWJsZS4NCj4gDQo+IEkganVzdCBleHRy
YWN0ZWQgdGhlbSBmcm9tIHRoZSB2ZW5kb3IgZHJpdmVyIHNhbWUgYXMgbGFzdCB0aW1lOg0KPiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9maXJtd2FyZS9s
aW51eC1maXJtd2FyZS5naXQvY29tbWl0L3J0bHdpZmkvcnRsODE5MmV1X24NCj4gaWMuYmluP2lk
PTkxZDVkZDEzNjE1M2UwYTE5OWQ3YmYzMGZkMDM3NjNkODM1ODZiNzMNCj4gDQo+IFRoZSB2ZW5k
b3IgZmlsZSBsaWNlbnNlIGp1c3Qgc2F5cyBHUEx2MjoNCj4gaHR0cHM6Ly9naXRodWIuY29tL2Ns
bmh1Yi9ydGw4MTkyZXUtbGludXgvYmxvYi81LjExLjIuMS9oYWwvcnRsODE5MmUvaGFsODE5MmVf
ZncuYw0KPiANCg0KSSdtIG5vdCBhIGxhd3llciwgbm8gaWRlYSBhYm91dCB0aGlzLiBJIGhvcGUg
c29tZW9uZSBjYW4gY29tbWVudCB0aGlzLiANCg0KPiA+DQo+ID4gSSd2ZSBjb3BpZWQgUGluZy1L
ZSBTaGloIGluIGNhc2UgdGhleSBoYXZlIHNvbWUgaW5zaWdodCBoZXJlLCBidXQgSQ0KPiA+IGNh
bid0IHJlYWxseSB0YWtlIHRoaXMgcGF0Y2ggYXMgaXQgaXMgYmFzZWQgb24gd2hhdCBpcyByZXBy
ZXNlbnRlZA0KPiA+IGhlcmUuICBBbiBhY2sgb3IgU2lnbmVkLW9mZi1ieSBmcm9tIHNvbWVvbmUg
YXQgUmVhbHRlayB3b3VsZCBnbyBhIGxvbmcNCj4gPiB3YXkuDQoNCkkgdGhpbmsgSSBjYW4gdGFr
ZSBwYXRjaGVzIHJlbGF0ZWQgdG8gUmVhbHRlayBmaXJtd2FyZSB0byBteSBnaXRodWIgdHJlZSwN
CmFuZCBzZW5kIG91dCBwdWxsLXJlcXVlc3QgYWZ0ZXIgY2hlY2tpbmcgY29udGVudCBvZiBmaXJt
d2FyZSBwYXRjaC4NCkRvZXMgaXQgd29yayB0byB5b3UsIEpvc2g/DQoNCj4gPg0KPiA+IGpvc2gN
Cj4gPg0KPiA+ID4gTm90ZSB0aGF0IHRoZSBleGlzdGluZyBydGw4MTkyZXVfYXBfd293bGFuLmJp
biBmaXJtd2FyZSBoZWFkZXINCj4gPiA+IGluZGljYXRlcyBpdCBpcyBhY3R1YWxseSB2MTguMCBh
bmQgbm90IHYxOS4wIGFzIGluZGljYXRlZCBieSB0aGUNCj4gPiA+IGNvbW1pdCB0aGF0IGludHJv
ZHVjZWQgaXQgOTFkNWRkMTM2MTUzZTBhMTk5ZDdiZjMwZmQwMzc2M2Q4MzU4NmI3MywNCj4gPiA+
IGFzIHN1Y2ggaXQgaXMgbWFya2VkIGFzIHZlcnNpb24gMTguMC4NCj4gPiA+DQo+ID4gPiBTbyBm
YXIgSSBoYXZlIG1hbmFnZWQgdG8gZmluZCB0aGUgZm9sbG93aW5nIGZpcm13YXJlIHZlcnNpb25z
IGZvciB0aGUNCj4gPiA+IHJ0bDgxOTJldSBpbiB2YXJpb3VzIHZlbmRvciBkcml2ZXIgcmVsZWFz
ZXM6DQo+ID4gPiB2MTguMA0KPiA+ID4gdjE5LjANCj4gPiA+IHYyNy4wDQo+ID4gPiB2MzUuNw0K
PiA+ID4NCj4gPiA+IFRoZSBydGw4MTkyZXVfYXBfd293bGFuLmJpbiBmaXJtd2FyZSBkb2VzIG5v
dCBhcHBlYXIgdG8gaGF2ZSByZWNlaXZlZA0KPiA+ID4gYW55IHVwZGF0ZXMgdW5saWtlIHRoZSBv
dGhlciBydGw4MTkyZXUgZmlybXdhcmUgdmFyaWFudHMuDQo+ID4gPg0KPiA+ID4gUHJldmlvdXMg
ZmlybXdhcmUgbG9hZCBpbiBydGw4eHh4dToNCj4gPiA+IHJ0bDh4eHh1OiBMb2FkaW5nIGZpcm13
YXJlIHJ0bHdpZmkvcnRsODE5MmV1X25pYy5iaW4NCj4gPiA+IEZpcm13YXJlIHJldmlzaW9uIDE5
LjAgKHNpZ25hdHVyZSAweDkyZTEpDQo+ID4gPg0KPiA+ID4gVXBkYXRlZCBmaXJtd2FyZSBsb2Fk
IGluIHJ0bDh4eHh1Og0KPiA+ID4gcnRsOHh4eHU6IExvYWRpbmcgZmlybXdhcmUgcnRsd2lmaS9y
dGw4MTkyZXVfbmljLmJpbg0KPiA+ID4gRmlybXdhcmUgcmV2aXNpb24gMzUuNyAoc2lnbmF0dXJl
IDB4OTJlMSkNCj4gPiA+DQo+ID4gPiBDYzogSmVzIFNvcmVuc2VuIDxqZXMuc29yZW5zZW5AZ21h
aWwuY29tPg0KPiA+ID4gQ2M6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwu
Y29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFtZXMgSGlsbGlhcmQgPGphbWVzLmhpbGxpYXJk
MUBnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBXSEVOQ0UgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA5ICsrKysrKysrLQ0KPiA+ID4gIHJ0bHdpZmkvcnRsODE5MmV1X2FwLmJp
biAgICAgICAgICAgfCBCaW4gMCAtPiAyNTgxNiBieXRlcw0KPiA+ID4gIHJ0bHdpZmkvcnRsODE5
MmV1X25pYy5iaW4gICAgICAgICAgfCBCaW4gMzE4MTggLT4gMzIyODYgYnl0ZXMNCj4gPiA+ICBy
dGx3aWZpL3J0bDgxOTJldV9uaWNfc2V0dXBib3guYmluIHwgQmluIDAgLT4gMjg1NTQgYnl0ZXMN
Cj4gPiA+ICBydGx3aWZpL3J0bDgxOTJldV93b3dsYW4uYmluICAgICAgIHwgQmluIDI1ODc4IC0+
IDI5MDA4IGJ5dGVzDQo+ID4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgcnRsd2lmaS9ydGw4MTkyZXVf
YXAuYmluDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHJ0bHdpZmkvcnRsODE5MmV1X25pY19z
ZXR1cGJveC5iaW4NCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvV0hFTkNFIGIvV0hFTkNFDQo+
ID4gPiBpbmRleCA4MTZjZjdjLi5lN2FlNzhhIDEwMDY0NA0KPiA+ID4gLS0tIGEvV0hFTkNFDQo+
ID4gPiArKysgYi9XSEVOQ0UNCj4gPiA+IEBAIC0zMjU3LDEyICszMjU3LDE5IEBAIEZpbGU6IHJ0
bHdpZmkvcnRsODcyM2J1X3dvd2xhbi5iaW4NCj4gPiA+ICBGaWxlOiBydGx3aWZpL3J0bDg3MjNi
dV9hcF93b3dsYW4uYmluDQo+ID4gPg0KPiA+ID4gIEluZm86IHJ0bDgxOTJldSB0YWtlbiBmcm9t
IFJlYWx0ZWsgZHJpdmVyDQo+ID4gPiAtICAgICAgcnRsODE5MkVVX2xpbnV4X3Y0LjMuMS4xXzEx
MzIwLjIwMTQwNTA1DQo+ID4gPiArICAgICAgcnRsODE5MkVVX1dpRmlfbGludXhfdjUuMTEuMi4x
LTE4LWc4ZTdkZjkxMmIuMjAyMTA1MjdfQ09FWDIwMTcxMTEzLTAwNDcNCj4gPiA+ICAgICAgICBG
aXJtd2FyZSBpcyBlbWJlZGRlZCBpbiB0aGUgZHJpdmVyIGFzIGRhdGEgc3RhdGVtZW50cy4gVGhp
cyBpbmZvDQo+ID4gPiAgICAgICAgaGFzIGJlZW4gZXh0cmFjdGVkIGludG8gYSBiaW5hcnkgZmls
ZS4NCj4gPiA+ICBGaWxlOiBydGx3aWZpL3J0bDgxOTJldV9uaWMuYmluDQo+ID4gPiArVmVyc2lv
bjogMzUuNw0KPiA+ID4gK0ZpbGU6IHJ0bHdpZmkvcnRsODE5MmV1X25pY19zZXR1cGJveC5iaW4N
Cj4gPiA+ICtWZXJzaW9uOiAzNS43DQo+ID4gPiAgRmlsZTogcnRsd2lmaS9ydGw4MTkyZXVfd293
bGFuLmJpbg0KPiA+ID4gK1ZlcnNpb246IDM1LjcNCj4gPiA+ICtGaWxlOiBydGx3aWZpL3J0bDgx
OTJldV9hcC5iaW4NCj4gPiA+ICtWZXJzaW9uOiAzNS43DQo+ID4gPiAgRmlsZTogcnRsd2lmaS9y
dGw4MTkyZXVfYXBfd293bGFuLmJpbg0KPiA+ID4gK1ZlcnNpb246IDE4LjANCj4gPiA+DQo+ID4g
PiAgTGljZW5jZTogUmVkaXN0cmlidXRhYmxlLiBTZWUgTElDRU5DRS5ydGx3aWZpX2Zpcm13YXJl
LnR4dCBmb3IgZGV0YWlscy4NCj4gPiA+DQoNClsuLi5dDQoNCg==
