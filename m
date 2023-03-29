Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9626C6CCEC5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC2A2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 20:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC2A2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 20:28:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C710C9
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 17:28:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32T0Re1F2017978, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32T0Re1F2017978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 29 Mar 2023 08:27:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 08:27:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 29 Mar 2023 08:27:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 29 Mar 2023 08:27:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
Thread-Topic: [RFC PATCH 13/14] wifi: rtl8xxxu: Clean up filter configuration
Thread-Index: AQHZXOKfVcPO2JHGpUSER0+v9g/H+68N5jlwgAHiOYCAASdOIA==
Date:   Wed, 29 Mar 2023 00:27:57 +0000
Message-ID: <c464836af0a9470e895bbd421b21e9bc@realtek.com>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-14-martin.kaistra@linutronix.de>
 <ab74ec9f73b741f7b0dd3b8a498d7e32@realtek.com>
 <7e1c9cd8-cb1e-197a-16b4-379647589ff4@linutronix.de>
In-Reply-To: <7e1c9cd8-cb1e-197a-16b4-379647589ff4@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI4
LCAyMDIzIDEwOjQ3IFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMu
U29yZW5zZW5AZ21haWwuY29tPjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IEJpdHRl
cmJsdWUgU21pdGgNCj4gPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPjsgU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQ
QVRDSCAxMy8xNF0gd2lmaTogcnRsOHh4eHU6IENsZWFuIHVwIGZpbHRlciBjb25maWd1cmF0aW9u
DQo+IA0KPiBBbSAyNy4wMy4yMyB1bSAwNDowNiBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPg0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcnRpbiBL
YWlzdHJhIDxtYXJ0aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRlPg0KPiA+PiBTZW50OiBUaHVyc2Rh
eSwgTWFyY2ggMjMsIDIwMjMgMToxOSBBTQ0KPiA+PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnDQo+ID4+IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+
OyBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsgUGluZy1LZSBTaGloDQo+ID4+IDxwa3No
aWhAcmVhbHRlay5jb20+OyBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNv
bT47IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3INCj4gPj4gPGJpZ2Vhc3lAbGludXRyb25peC5k
ZT4NCj4gPj4gU3ViamVjdDogW1JGQyBQQVRDSCAxMy8xNF0gd2lmaTogcnRsOHh4eHU6IENsZWFu
IHVwIGZpbHRlciBjb25maWd1cmF0aW9uDQo+ID4+DQo+ID4+IEluIEFQIG1vZGUsIFJDUl9DSEVD
S19CU1NJRF9NQVRDSCBzaG91bGQgbm90IGJlIHNldC4gUmVhcnJhbmdlIFJDUiBiaXRzDQo+ID4+
IHRvIGZpbHRlciBmbGFncyB0byBtYXRjaCBvdGhlciByZWFsdGVrIGRyaXZlcnMgYW5kIGRvbid0
IHNldA0KPiA+PiBSQ1JfQ0hFQ0tfQlNTSURfQkVBQ09OIGFuZCBSQ1JfQ0hFQ0tfQlNTSURfTUFU
Q0ggaW4gQVAgbW9kZS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+ID4+IC0tLQ0KPiA+PiAgIC4uLi93aXJl
bGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDE5ICsrKysrKysrKystLS0t
LS0tLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gPj4gaW5kZXggODJmYmU3NzhmYzVl
Yy4uYjZmODExYWQwMTMzMyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gPj4gQEAgLTY1OTcs
MjMgKzY1OTcsMjQgQEAgc3RhdGljIHZvaWQgcnRsOHh4eHVfY29uZmlndXJlX2ZpbHRlcihzdHJ1
Y3QgaWVlZTgwMjExX2h3ICpodywNCj4gPj4gICAgICAgICAgICogRklGX1BMQ1BGQUlMIG5vdCBz
dXBwb3J0ZWQ/DQo+ID4+ICAgICAgICAgICAqLw0KPiA+Pg0KPiA+PiAtICAgICAgIGlmICgqdG90
YWxfZmxhZ3MgJiBGSUZfQkNOX1BSQlJFU1BfUFJPTUlTQykNCj4gPj4gLSAgICAgICAgICAgICAg
IHJjciAmPSB+UkNSX0NIRUNLX0JTU0lEX0JFQUNPTjsNCj4gPj4gLSAgICAgICBlbHNlDQo+ID4+
IC0gICAgICAgICAgICAgICByY3IgfD0gUkNSX0NIRUNLX0JTU0lEX0JFQUNPTjsNCj4gPj4gKyAg
ICAgICBpZiAocHJpdi0+dmlmLT50eXBlICE9IE5MODAyMTFfSUZUWVBFX0FQKSB7DQo+ID4NCj4g
PiBJIHRoaW5rIG1hYzgwMjExIGNvbmZpZ3VyZSBmaWx0ZXJzIGRlcGVuZHMgb24gb3BlcmF0aW5n
IGNvbmRpdGlvbnMsIHNvIGl0IHdvdWxkDQo+ID4gYmUgcG9zc2libGUgdG8gYXZvaWQgY2hlY2tp
bmcgdmlmLT50eXBlLg0KPiANCj4gSXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIHJlbW92ZSB0aGUg
dmlmLT50eXBlIGNoZWNrIGZyb20NCj4gRklGX0JDTl9QUkJSRVNQX1BST01JU0MgY2hlY2ssIGJ1
dCBJIHdvdWxkIHN0aWxsIG5lZWQgaXQgdG8gcmVtb3ZlIHRoZQ0KPiBDSEVDS19CU1NJRF9NQVRD
SCBiaXQgaW4gdGhlIEFQIG1vZGUgY2FzZS4gT3RoZXJ3aXNlIEkgc2VlbSB0byByZWNlaXZlDQo+
IG5vIGRhdGEgZnJhbWVzLg0KPiANCj4gDQo+IGlmICgqdG90YWxfZmxhZ3MgJiBGSUZfQkNOX1BS
QlJFU1BfUFJPTUlTQykNCj4gICAgICAgICByY3IgJj0gfihSQ1JfQ0hFQ0tfQlNTSURfQkVBQ09O
IHwgUkNSX0NIRUNLX0JTU0lEX01BVENIKTsNCj4gZWxzZQ0KPiAgICAgICAgIHJjciB8PSBSQ1Jf
Q0hFQ0tfQlNTSURfQkVBQ09OIHwgUkNSX0NIRUNLX0JTU0lEX01BVENIOw0KPiANCj4gaWYgKHBy
aXYtPnZpZiAmJiBwcml2LT52aWYtPnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfQVApDQo+ICAgICAg
ICAgcmNyICY9IH5SQ1JfQ0hFQ0tfQlNTSURfTUFUQ0g7DQo+IA0KPiBBbm90aGVyIHdheSB3b3Vs
ZCBiZSBsaWtlIGluIHRoZSBydHc4OCBkcml2ZXIsIHdoZXJlIHRoZSBCSVRfQ0JTU0lEX0RBVEEN
Cj4gaXMgbm90IHNldCBhZ2FpbiBpbiB0aGUgZWxzZSBjYXNlLCBidXQgSSBhbSBub3Qgc3VyZSwg
dGhhdCBpcyB0aGUgcmlnaHQgd2F5Lg0KPiANCg0KcnRsOHh4eHUgc3VwcG9ydCBzaW5nbGUgb25l
IHZpZiwgc28geW91ciBwcm9wb3NhbCB3aWxsIGJlIGZpbmUuIA0KDQpXaXRob3V0IEJJVF9DQlNT
SURfREFUQSwgZHJpdmVyIHdpbGwgcmVjZWl2ZSB1bm5lY2Vzc2FyeSBkYXRhIGZyYW1lcywgc28N
Cml0IHdpbGwgaW5jcmVhc2UgdHJhZmZpYyBvZiBidXMsIGJ1dCBpdCB3aWxsIGJlIGZpbmUgZm9y
IHVzZXJzLiANCg0K
