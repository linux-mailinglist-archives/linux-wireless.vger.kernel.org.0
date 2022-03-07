Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D14CEF21
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 02:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiCGBeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Mar 2022 20:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiCGBeV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Mar 2022 20:34:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812513EAB
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 17:33:26 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2271XAvR4026551, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2271XAvR4026551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 09:33:10 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Mar 2022 09:33:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 09:33:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e]) by
 RTEXMBS04.realtek.com.tw ([fe80::35e4:d9d1:102d:605e%5]) with mapi id
 15.01.2308.020; Mon, 7 Mar 2022 09:33:10 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw89: declare HE capabilities in 6G band
Thread-Topic: [PATCH] rtw89: declare HE capabilities in 6G band
Thread-Index: AQHYL5pveK8yIm6OP0GDxInK9zbCNayubKIAgAS6apA=
Date:   Mon, 7 Mar 2022 01:33:09 +0000
Message-ID: <70c84df91e244987a657948ef440edb1@realtek.com>
References: <20220304073443.27730-1-pkshih@realtek.com>
 <050529f958bb628ee6e2819c944b42951b621893.camel@sipsolutions.net>
In-Reply-To: <050529f958bb628ee6e2819c944b42951b621893.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNiDkuIvljYggMTA6MDA6MDA=?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggNCwgMjAyMiA1
OjIwIFBNDQo+IFRvOiBQa3NoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IGt2YWxvQGtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBydHc4OTogZGVjbGFyZSBIRSBjYXBhYmlsaXRpZXMgaW4gNkcgYmFuZA0KPiANCj4g
T24gRnJpLCAyMDIyLTAzLTA0IGF0IDE1OjM0ICswODAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
ID4gVG8gd29yayBwcm9wZXJseSBpbiA2RyBiYW5kLCBkZWNsYXJlIEhFIDZHIGNhcGFiaWxpdGll
cy4gV2l0aG91dCB0aGlzIGZpeCwNCj4gPiBpdCBjYW4gb25seSBUWC9SWCB3aXRoIE9GRE0gcmF0
ZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9j
b3JlLmMgfCA5ICsrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OS9jb3JlLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuYw0KPiA+
IGluZGV4IGEwMDg2YjE0NTUwYTguLjgxYzFjMjhlNmU5MmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuYw0KPiA+IEBAIC0yMzgzLDYgKzIzODMs
MTUgQEAgc3RhdGljIHZvaWQgcnR3ODlfaW5pdF9oZV9jYXAoc3RydWN0IHJ0dzg5X2RldiAqcnR3
ZGV2LA0KPiA+ICAJCQloZV9jYXAtPmhlX21jc19uc3Nfc3VwcC50eF9tY3NfMTYwID0gY3B1X3Rv
X2xlMTYobWNzX21hcCk7DQo+ID4gIAkJfQ0KPiA+DQo+ID4gKwkJaWYgKGJhbmQgPT0gTkw4MDIx
MV9CQU5EXzZHSFopIHsNCj4gPiArCQkJX19sZTE2IGNhcGE7DQo+ID4gKw0KPiA+ICsJCQljYXBh
ID0gdTE2X2VuY29kZV9iaXRzKDAsIElFRUU4MDIxMV9IRV82R0haX0NBUF9NSU5fTVBEVV9TVEFS
VCkgfA0KPiA+DQo+IA0KPiBsZTE2X2VuY29kZV9iaXRzKCk/IEkgZ3Vlc3Mgc3BhcnNlIHdvdWxk
IHRlbGwuDQo+IA0KPiBCdXQgaXQgbG9va3Mgd2VpcmQgd2l0aCB0aGUgY29uc3RhbnRzLCBJIGd1
ZXNzIHlvdSBtZWFuDQo+IA0KPiBsZTE2X2VuY29kZV9iaXRzKElFRUU4MDIxMV9IVF9NUERVX0RF
TlNJVFlfTk9ORSwNCj4gCQkgSUVFRTgwMjExX0hFXzZHSFpfQ0FQX01JTl9NUERVX1NUQVJUKSB8
DQo+IGxlMTZfZW5jb2RlX2JpdHMoSUVFRTgwMjExX1ZIVF9NQVhfQU1QRFVfMTAyNEssIC4uLikg
fA0KPiAuLi4NCj4gDQo+ICh0aGVyZSdzIGRvY3VtZW50YXRpb24gaW4gaWVlZTgwMjExLmggd2hp
Y2ggdmFsdWUgZW51bXMgc2hvdWxkIGJlIHVzZWQpDQo+IA0KDQpUaGFua3MgZm9yIHBvaW50aW5n
IG91dCB0aGVzZS4NCkkgaGF2ZSBmaXhlZCB0aGVtIGFuZCBzZW50IHYyLg0KDQotLQ0KUGluZy1L
ZQ0KDQo=
