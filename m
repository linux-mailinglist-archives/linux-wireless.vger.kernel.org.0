Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2742654A88
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 02:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLWBye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 20:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWByd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 20:54:33 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B22425C52
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 17:54:30 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BN1rYrP5004328, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BN1rYrP5004328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 23 Dec 2022 09:53:34 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 23 Dec 2022 09:54:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 23 Dec 2022 09:54:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 23 Dec 2022 09:54:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Fix memory leaks with RTL8723BU, RTL8192EU
Thread-Topic: [PATCH] wifi: rtl8xxxu: Fix memory leaks with RTL8723BU,
 RTL8192EU
Thread-Index: AQHZFftFIPJrHZp1W06doTDBOlwx+K56tt5g
Date:   Fri, 23 Dec 2022 01:54:25 +0000
Message-ID: <276dce90fa934767884cf35e25460843@realtek.com>
References: <03b099c1-c671-d252-36f4-57b70d721f9d@gmail.com>
In-Reply-To: <03b099c1-c671-d252-36f4-57b70d721f9d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIyIOS4i+WNiCAxMDowMDowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAy
MiwgMjAyMiA3OjQ4IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IHJ0bDh4eHh1OiBG
aXggbWVtb3J5IGxlYWtzIHdpdGggUlRMODcyM0JVLCBSVEw4MTkyRVUNCj4gDQo+IFRoZSB3aWZp
ICsgYmx1ZXRvb3RoIGNvbWJvIGNoaXAgUlRMODcyM0JVIGNhbiBsZWFrIG1lbW9yeSAoZXNwZWNp
YWxseT8pDQo+IHdoZW4gaXQncyBjb25uZWN0ZWQgdG8gYSBibHVldG9vdGggYXVkaW8gZGV2aWNl
LiBUaGUgYnVzeSBibHVldG9vdGgNCj4gdHJhZmZpYyBnZW5lcmF0ZXMgbG90cyBvZiBDMkggKGNh
cmQgdG8gaG9zdCkgbWVzc2FnZXMsIHdoaWNoIGFyZSBub3QNCj4gZnJlZWQgY29ycmVjdGx5Lg0K
PiANCj4gVG8gZml4IHRoaXMsIG1vdmUgdGhlIGRldl9rZnJlZV9za2IoKSBjYWxsIGluIHJ0bDh4
eHh1X2MyaGNtZF9jYWxsYmFjaygpDQo+IGluc2lkZSB0aGUgbG9vcCB3aGVyZSBza2JfZGVxdWV1
ZSgpIGlzIGNhbGxlZC4NCj4gDQo+IFRoZSBSVEw4MTkyRVUgbGVha3MgbWVtb3J5IGJlY2F1c2Ug
dGhlIEMySCBtZXNzYWdlcyBhcmUgYWRkZWQgdG8gdGhlDQo+IHF1ZXVlIGFuZCBsZWZ0IHRoZXJl
IGZvcmV2ZXIuIChUaGlzIHdhcyBmaW5lIGluIHRoZSBwYXN0IGJlY2F1c2UgaXQNCj4gcHJvYmFi
bHkgd2Fzbid0IHNlbmRpbmcgYW55IEMySCBtZXNzYWdlcyB1bnRpbCBjb21taXQgZTU0MmU2NmI3
YzJlDQo+ICgid2lmaTogcnRsOHh4eHU6IGdlbjI6IFR1cm4gb24gdGhlIHJhdGUgY29udHJvbCIp
LiBTaW5jZSB0aGF0IGNvbW1pdA0KPiBpdCBzZW5kcyBhIEMySCBtZXNzYWdlIHdoZW4gdGhlIFRY
IHJhdGUgY2hhbmdlcy4pDQo+IA0KPiBUbyBmaXggdGhpcywgZGVsZXRlIHRoZSBjaGVjayBmb3Ig
cmZfcGF0aHMgPiAxIGFuZCB0aGUgZ290by4gTGV0IHRoZQ0KPiBmdW5jdGlvbiBwcm9jZXNzIHRo
ZSBDMkggbWVzc2FnZXMgZnJvbSBSVEw4MTkyRVUgbGlrZSB0aGUgb25lcyBmcm9tDQo+IHRoZSBv
dGhlciBjaGlwcy4NCj4gDQo+IFRoZW9yZXRpY2FsbHkgdGhlIFJUTDgxODhGVSBjb3VsZCBhbHNv
IGxlYWsgbGlrZSBSVEw4NzIzQlUsIGJ1dCBpdA0KPiBtb3N0IGxpa2VseSBkb2Vzbid0IHNlbmQg
QzJIIG1lc3NhZ2VzIGZyZXF1ZW50bHkgZW5vdWdoLg0KPiANCj4gVGhpcyBjaGFuZ2Ugd2FzIHRl
c3RlZCB3aXRoIFJUTDg3MjNCVSBieSBFcmhhcmQgRi4gSSB0ZXN0ZWQgaXQgd2l0aA0KPiBSVEw4
MTg4RlUgYW5kIFJUTDgxOTJFVS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBFcmhhcmQgRi4gPGVyaGFy
ZF9mQG1haWxib3gub3JnPg0KPiBUZXN0ZWQtYnk6IEVyaGFyZCBGLiA8ZXJoYXJkX2ZAbWFpbGJv
eC5vcmc+DQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MjE1MTk3DQo+IEZpeGVzOiBlNTQyZTY2YjdjMmUgKCJydGw4eHh4dTogYWRkIGJsdWV0b290
aCBjby1leGlzdGVuY2Ugc3VwcG9ydCBmb3Igc2luZ2xlIGFudGVubmEiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMgfCA4ICsr
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggZmQ5N2MwNDA5NDhhLi4wM2ZmYjk5ZGE3ZTIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eHUvcnRsOHh4eHVfY29yZS5jDQo+IEBAIC01NzAyLDkgKzU3MDIsNiBAQCBzdGF0aWMgdm9pZCBy
dGw4eHh4dV9jMmhjbWRfY2FsbGJhY2soc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCWJ0
Y29leCA9ICZwcml2LT5idF9jb2V4Ow0KPiAgCXJhcnB0ID0gJnByaXYtPnJhX3JlcG9ydDsNCj4g
DQo+IC0JaWYgKHByaXYtPnJmX3BhdGhzID4gMSkNCj4gLQkJZ290byBvdXQ7DQo+IC0NCj4gIAl3
aGlsZSAoIXNrYl9xdWV1ZV9lbXB0eSgmcHJpdi0+YzJoY21kX3F1ZXVlKSkgew0KPiAgCQlza2Ig
PSBza2JfZGVxdWV1ZSgmcHJpdi0+YzJoY21kX3F1ZXVlKTsNCj4gDQo+IEBAIC01NzM3LDEwICs1
NzM0LDkgQEAgc3RhdGljIHZvaWQgcnRsOHh4eHVfYzJoY21kX2NhbGxiYWNrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCj4gIAkJZGVmYXVsdDoNCj4gIAkJCWJyZWFrOw0KPiAgCQl9DQo+IC0J
fQ0KPiANCj4gLW91dDoNCj4gLQlkZXZfa2ZyZWVfc2tiKHNrYik7DQo+ICsJCWRldl9rZnJlZV9z
a2Ioc2tiKTsNCj4gKwl9DQo+ICB9DQo+IA0KPiAgc3RhdGljIHZvaWQgcnRsODcyM2J1X2hhbmRs
ZV9jMmgoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsDQo+IC0tDQo+IDIuMzguMA0KPiANCj4g
LS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhp
cyBlLW1haWwuDQo=
