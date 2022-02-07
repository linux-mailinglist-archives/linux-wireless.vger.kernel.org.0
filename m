Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77314AB5FD
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiBGHhd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 02:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiBGH1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 02:27:35 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0EC043181
        for <linux-wireless@vger.kernel.org>; Sun,  6 Feb 2022 23:27:34 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2177RFr04003183, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2177RFr04003183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Feb 2022 15:27:15 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 15:27:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Feb 2022 23:27:15 -0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Mon, 7 Feb 2022 15:27:15 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Reto Schneider <code@reto-schneider.ch>,
        "chris.chiu@canonical.com" <chris.chiu@canonical.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: RE: rtl8xxxu: Performance findings and questions
Thread-Topic: rtl8xxxu: Performance findings and questions
Thread-Index: AQHYF83Dlowakr+OI0WDZFOkfd8ap6yHsXvA
Date:   Mon, 7 Feb 2022 07:27:15 +0000
Message-ID: <f5e7e5e373f0468abffd87af2dcbde97@realtek.com>
References: <2e5161a6-d273-4f76-429a-12dc2a6c7322@reto-schneider.ch>
In-Reply-To: <2e5161a6-d273-4f76-429a-12dc2a6c7322@reto-schneider.ch>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvNyDkuIrljYggMDM6NTI6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmV0byBTY2huZWlk
ZXIgPGNvZGVAcmV0by1zY2huZWlkZXIuY2g+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkg
MiwgMjAyMiA4OjQyIEFNDQo+IFRvOiBjaHJpcy5jaGl1QGNhbm9uaWNhbC5jb207IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVzLlNvcmVuc2VuQGdtYWlsLmNvbQ0KPiBDYzogUGtz
aGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IHJ0bDh4eHh1OiBQZXJmb3JtYW5j
ZSBmaW5kaW5ncyBhbmQgcXVlc3Rpb25zDQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBXaGlsZSB0cnlp
bmcgdG8gaW1wcm92ZSB0aGUgcmV0cmFuc21pc3Npb24gcGVyY2VudGFnZSBvbiBteSBydGw4MTg4
Y3VzDQo+IGRldmljZXMsIEkgZm91bmQgdGhlIGZvbGxvd2luZzoNCj4gDQo+IHJ0bDh4eHh1X3R4
KCkgdGFrZXMgZXZlcnkgc2tfYnVmIGhhbmRlZCBieSBtYWM4MDIxMSBhbmQgcmVsYXlzIGl0IHRv
IHRoZQ0KPiBydGw4MTg4Y3VzIHJpZ2h0IGF3YXkuIFRoaXMgcmVzdWx0cyBpbiAxMGsrIFVSQnMv
cywgZWFjaCB+MTUwMCBieXRlcyBpbg0KPiBzaXplIG9uIG15IHg4NiB3b3Jrc3RhdGlvbi4gT24g
bXkgbG93LWVuZCBBUk12NSBkZXZpY2VzIHRoZSBVUkJzIHBlYWsNCj4gb3V0IGF0IH41ay9zLCB3
aXRoIGxvd2VyIHRocm91Z2hwdXQgYW5kIGhpZ2hlciByZXRyYW5zbWlzc2lvbiByYXRlcw0KPiAo
fjMwJSBpbiBhIHNoaWVsZGVkIFJGIGJveCwgfjEwJSBmb3IgbXkgd29ya3N0YXRpb24pLg0KDQpE
byB5b3UgbWVhbiBsb3ctZW5kIGRldmljZSBoYXMgaGlnaGVyIHJldHJhbnNtaXNzaW9uIHJhdGVz
IHRoYW4geDg2Pw0KSXQgbG9va3Mgbm8gcmVhc29uYWJsZS4gQ291bGQgSSBrbm93IHRoZSBkcml2
ZXIgYW5kIGhhcmR3YXJlIGluY2x1ZGluZw0KYW50ZW5uYSBhcmUgYWxsIHRoZSBzYW1lPw0KDQo+
IA0KPiBUaGUgUmVhbHRlayA4MTkyY3UgYnVuZGxlcyB0aGUgVFggZnJhbWVzIFsxXSBhbmQgc2Vu
ZHMgdXAgdG8gMThrQiBzaXplZA0KPiBVUkJzLCByZXN1bHRpbmcgaW4ganVzdCAxayBVUkJzL3Mu
IFRoZSByZXRyYW5zbWlzc2lvbiByYXRlcyB3aXRoIHRoaXMNCj4gZHJpdmVyIGFyZSBiZWxvdyAx
JS4NCg0KSWYgeW91IHB1dCA4MTkyY3Ugb24geW91ciBsb3ctZW5kIGRldmljZSwgaXMgdGhlIHJl
dHJhbnNtaXNzaW9uIHJhdGUgc3RpbGwNCmxvdz8NCg0KPiANCj4gUXVlc3Rpb25zOg0KPiAtIEFu
eSBjaGFuY2UgdGhpcyBVUkIgInNwYW0iIGlzIHRoZSByb290IGNhdXNlIGZvciB0aGUgcnRsODE4
OGN1cyBiZWluZw0KPiAgICB0b28gc2xvdyB0byBBQ0sgcmVjZWl2ZWQgZnJhbWVzIGluIHRpbWUs
IGNhdXNpbmcgcmV0cmFuc21pc3Npb25zIGJ5DQo+ICAgIHRoZSBBUD8NCg0KQUNLIGlzIHNlbnQg
YnkgaGFyZHdhcmUgKG5vdCBmaXJtd2FyZS9kcml2ZXIpLCBzbyBJIHRoaW5rIFVSQiBkb2Vzbid0
IA0KYWZmZWN0IGl0Lg0KDQo+IC0gSXMgaW1wbGVtZW50aW5nIHdha2VfdHhfcXVldWUoKSB0aGUg
cHJvcGVyIHdheSB0byBpbXByb3ZlIHRoaXM/DQoNClVzZSB3YWtlX3R4X3F1ZXVlKCkgY2FuIGJv
b3N0IE1BQyBlZmZpY2llbmN5LCBidXQgbm90IHN1cmUgaXQgY2FuIGltcHJvdmUNCml0LiBBTVNE
VSBjYW4gc2VuZCBhIGNvbnRpbnVhbCBhbmQgbG9uZ2VyIGRhdGEgaW4gdGhlIGFpciwgc28gaXQg
aXMNCnBvc3NpYmxlIHRvIGdldCBoaWdoZXIgdGhyb3VnaHB1dCwgYnV0IGl0IGlzIGFsc28gcG9z
c2libGUgdG8gaGF2ZSBoaWdoZXINCmNvbGxpc2lvbiByYXRlLiANCg0KU2luY2UgeW91IGhhdmUg
bWVudGlvbmVkIHJldHJhbnNtaXNzaW9uIHJhdGUsIEkgZ3Vlc3MgeW91IHVzZSBhbm90aGVyDQpk
ZXZpY2Ugd29ya2luZyBhdCBtb25pdG9yIG1vZGUgdG8gY2FwdHVyZSBwYWNrZXRzLCByaWdodD8g
SSB0aGluayB5b3UgY2FuDQphbHNvIGludmVzdGlnYXRlIHRoZSByZWxhdGlvbiBiZXR3ZWVuIFRY
IFBIWSByYXRlIGFuZCByZXRyYW5zbWlzc2lvbi4NCg0KQW5vdGhlciBleHBlcmltZW50IGlzIHRo
ZSBkaXN0YW5jZSB2cy4gcmF0ZS4gV2l0aCBzaG9ydCBkaXN0YW5jZSwNCml0IG1heSBnZXQgd29y
c2UgdGhyb3VnaHB1dCBiZWNhdXNlIHNpZ25hbCBpcyB0b28gc3Ryb25nLiBPcHBvc2l0ZWx5LA0K
aWYgVFggc2lnbmFsIGlzIHRvbyB3ZWFrLCBtb3ZpbmcgZGV2aWNlIGNsb3NlciB0byBBUCBtYXkg
YmUgaGVscGZ1bC4NCg0KLS0NClBpbmctS2UNCg0K
