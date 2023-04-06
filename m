Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290326D8C9E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDFBQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 21:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFBQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 21:16:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06250F1
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 18:16:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3361G7b84028517, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3361G7b84028517
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 09:16:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 09:16:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 6 Apr 2023 09:16:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 6 Apr 2023 09:16:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Clean up some messy ifs
Thread-Index: AQHZZA3VOb/3C7mk9kGPYLUdN/MokK8df2cQ
Date:   Thu, 6 Apr 2023 01:16:26 +0000
Message-ID: <04d4ca3e27924ea6b2ad6e5b00ddb424@realtek.com>
References: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
In-Reply-To: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxLCAy
MDIzIDQ6MTcgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIHdpZmk6IHJ0bDh4eHh1OiBD
bGVhbiB1cCBzb21lIG1lc3N5IGlmcw0KPiANCj4gQWRkIHNvbWUgbmV3IG1lbWJlcnMgdG8gcnRs
OHh4eHVfZmlsZW9wcyBhbmQgdXNlIHRoZW0gaW5zdGVhZCBvZg0KPiBjaGVja2luZyBwcml2LT5y
dGxfY2hpcC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFj
ZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCg0KWy4uLl0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KPiBpbmRl
eCBjMTUyYjIyODYwNmYuLjYyZGQ1M2E1NzY1OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gQEAgLTE5
MTYsNyArMTkxNiw3IEBAIHN0YXRpYyBpbnQgcnRsOHh4eHVfc3RhcnRfZmlybXdhcmUoc3RydWN0
IHJ0bDh4eHh1X3ByaXYgKnByaXYpDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBJbml0IEgy
QyBjb21tYW5kDQo+ICAgICAgICAgICovDQo+IC0gICAgICAgaWYgKHByaXYtPnJ0bF9jaGlwID09
IFJUTDg3MjNCIHx8IHByaXYtPnJ0bF9jaGlwID09IFJUTDgxODhGIHx8IHByaXYtPnJ0bF9jaGlw
ID09IFJUTDg3MTBCKQ0KPiArICAgICAgIGlmIChwcml2LT5mb3BzLT5pbml0X3JlZ19obXRmcikN
Cj4gICAgICAgICAgICAgICAgIHJ0bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfSE1URlIsIDB4MGYp
Ow0KPiAgZXhpdDoNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiBAQCAtMzg2NCwxMSArMzg2NCw4
IEBAIHZvaWQgcnRsOHh4eHVfaW5pdF9idXJzdChzdHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikN
Cj4gICAgICAgICBydGw4eHh4dV93cml0ZTgocHJpdiwgUkVHX0hUX1NJTkdMRV9BTVBEVV84NzIz
QiwgdmFsOCk7DQo+IA0KPiAgICAgICAgIHJ0bDh4eHh1X3dyaXRlMTYocHJpdiwgUkVHX01BWF9B
R0dSX05VTSwgMHgwYzE0KTsNCj4gLSAgICAgICBpZiAocHJpdi0+cnRsX2NoaXAgPT0gUlRMODcy
M0IgfHwgcHJpdi0+cnRsX2NoaXAgPT0gUlRMODcxMEIpDQo+IC0gICAgICAgICAgICAgICB2YWw4
ID0gMHg1ZTsNCj4gLSAgICAgICBlbHNlIGlmIChwcml2LT5ydGxfY2hpcCA9PSBSVEw4MTg4RikN
Cj4gLSAgICAgICAgICAgICAgIHZhbDggPSAweDcwOyAvKiAweDVlIHdvdWxkIG1ha2UgaXQgdmVy
eSBzbG93ICovDQo+IC0gICAgICAgcnRsOHh4eHVfd3JpdGU4KHByaXYsIFJFR19BTVBEVV9NQVhf
VElNRV84NzIzQiwgdmFsOCk7DQo+ICsgICAgICAgcnRsOHh4eHVfd3JpdGU4KHByaXYsIFJFR19B
TVBEVV9NQVhfVElNRV84NzIzQiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJpdi0+Zm9w
cy0+YW1wZHVfbWF4X3RpbWUpOw0KDQpTaG91bGQgaXQgYmUgDQoNCmlmIChwcml2LT5mb3BzLT5h
bXBkdV9tYXhfdGltZSkNCiAgICB2YWw4ID0gcHJpdi0+Zm9wcy0+YW1wZHVfbWF4X3RpbWU7DQoN
CnJ0bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfQU1QRFVfTUFYX1RJTUVfODcyM0IsIHZhbDgpOyAv
LyB0aGlzIGxpbmUgZG9lc24ndCBjaGFuZ2U/DQoNCkJlY2F1c2Ugb3JpZ2luYWxseSB2YWw4IGlz
IHJlYWQgZnJvbSBSRUdfSFRfU0lOR0xFX0FNUERVXzg3MjNCIGFuZCBhZGQNCkhUX1NJTkdMRV9B
TVBEVV9FTkFCTEUgYml0Lg0KDQouLi4gSSByZXZpZXcgZnVydGhlciBhbmQgd2FudCB0byBhZGQg
c2ltaWxhciBjb21tZW50LiBJIHdvbmRlciB5b3UgZG8gdGhpcw0KaW50ZW50aW9uYWxseSwgc28g
SSBmaW5kIHJ0bDh4eHh1X2luaXRfYnVyc3QoKSBpcyBvbmx5IHVzZWQgYnkgdGhyZWUgY2hpcHMN
ClJUTDg3MjNCLCBSVEw4NzEwQiBhbmQgUlRMODE4OEYuIEknbSBub3Qgc3VyZSBpZiBvdGhlciBw
ZW9wbGUgY291bGQgbWlzdXNlIA0KdGhpcyBmdW5jdGlvbiBpbiB0aGUgZnV0dXJlLCBhbnkgaWRl
YT8NCg0KPiAgICAgICAgIHJ0bDh4eHh1X3dyaXRlMzIocHJpdiwgUkVHX0FHR0xFTl9MTVQsIDB4
ZmZmZmZmZmYpOw0KPiAgICAgICAgIHJ0bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfUlhfUEtUX0xJ
TUlULCAweDE4KTsNCj4gICAgICAgICBydGw4eHh4dV93cml0ZTgocHJpdiwgUkVHX1BJRlMsIDB4
MDApOw0KPiBAQCAtMzg3NiwxNiArMzg3Myw4IEBAIHZvaWQgcnRsOHh4eHVfaW5pdF9idXJzdChz
dHJ1Y3QgcnRsOHh4eHVfcHJpdiAqcHJpdikNCj4gICAgICAgICAgICAgICAgIHJ0bDh4eHh1X3dy
aXRlOChwcml2LCBSRUdfRldIV19UWFFfQ1RSTCwgRldIV19UWFFfQ1RSTF9BTVBEVV9SRVRSWSk7
DQo+ICAgICAgICAgICAgICAgICBydGw4eHh4dV93cml0ZTMyKHByaXYsIFJFR19GQVNUX0VEQ0Ff
Q1RSTCwgMHgwMzA4NjY2Nik7DQo+ICAgICAgICAgfQ0KPiAtICAgICAgIC8qDQo+IC0gICAgICAg
ICogVGhlIFJUTDg3MTBCVSB2ZW5kb3IgZHJpdmVyIHVzZXMgMHg1MCBoZXJlIGFuZCBpdCB3b3Jr
cyBmaW5lLA0KPiAtICAgICAgICAqIGJ1dCBpbiBydGw4eHh4dSAweDUwIGNhdXNlcyBzbG93IHVw
bG9hZCBhbmQgcmFuZG9tIHBhY2tldCBsb3NzLiBXaHk/DQo+IC0gICAgICAgICovDQo+IC0gICAg
ICAgaWYgKHByaXYtPnJ0bF9jaGlwID09IFJUTDg3MjNCKQ0KPiAtICAgICAgICAgICAgICAgdmFs
OCA9IDB4NTA7DQo+IC0gICAgICAgZWxzZSBpZiAocHJpdi0+cnRsX2NoaXAgPT0gUlRMODE4OEYg
fHwgcHJpdi0+cnRsX2NoaXAgPT0gUlRMODcxMEIpDQo+IC0gICAgICAgICAgICAgICB2YWw4ID0g
MHgyODsgLyogMHg1MCB3b3VsZCBtYWtlIHRoZSB1cGxvYWQgc2xvdyAqLw0KPiAtICAgICAgIHJ0
bDh4eHh1X3dyaXRlOChwcml2LCBSRUdfVVNUSU1FX1RTRl84NzIzQiwgdmFsOCk7DQo+IC0gICAg
ICAgcnRsOHh4eHVfd3JpdGU4KHByaXYsIFJFR19VU1RJTUVfRURDQSwgdmFsOCk7DQo+ICsgICAg
ICAgcnRsOHh4eHVfd3JpdGU4KHByaXYsIFJFR19VU1RJTUVfVFNGXzg3MjNCLCBwcml2LT5mb3Bz
LT51c3RpbWVfdHNmX2VkY2EpOw0KPiArICAgICAgIHJ0bDh4eHh1X3dyaXRlOChwcml2LCBSRUdf
VVNUSU1FX0VEQ0EsIHByaXYtPmZvcHMtPnVzdGltZV90c2ZfZWRjYSk7DQo+IA0KPiAgICAgICAg
IC8qIHRvIHByZXZlbnQgbWFjIGlzIHJlc2V0ZWQgYnkgYnVzLiAqLw0KPiAgICAgICAgIHZhbDgg
PSBydGw4eHh4dV9yZWFkOChwcml2LCBSRUdfUlNWX0NUUkwpOw0KPiBAQCAtNDEwMiw3ICs0MDkx
LDcgQEAgc3RhdGljIGludCBydGw4eHh4dV9pbml0X2RldmljZShzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodykNCj4gICAgICAgICAgICAgICAgIFJDUl9BUFBFTkRfUEhZU1RBVCB8IFJDUl9BUFBFTkRf
SUNWIHwgUkNSX0FQUEVORF9NSUM7DQo+ICAgICAgICAgcnRsOHh4eHVfd3JpdGUzMihwcml2LCBS
RUdfUkNSLCB2YWwzMik7DQo+IA0KPiAtICAgICAgIGlmIChwcml2LT5ydGxfY2hpcCA9PSBSVEw4
MTg4RiB8fCBwcml2LT5ydGxfY2hpcCA9PSBSVEw4NzEwQikgew0KPiArICAgICAgIGlmIChmb3Bz
LT5pbml0X3JlZ19yeGZsdG1hcCkgew0KPiAgICAgICAgICAgICAgICAgLyogQWNjZXB0IGFsbCBk
YXRhIGZyYW1lcyAqLw0KPiAgICAgICAgICAgICAgICAgcnRsOHh4eHVfd3JpdGUxNihwcml2LCBS
RUdfUlhGTFRNQVAyLCAweGZmZmYpOw0KPiANCj4gQEAgLTQxODcsOCArNDE3Niw3IEBAIHN0YXRp
YyBpbnQgcnRsOHh4eHVfaW5pdF9kZXZpY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+ICAg
ICAgICAgaWYgKGZvcHMtPmluaXRfYWdncmVnYXRpb24pDQo+ICAgICAgICAgICAgICAgICBmb3Bz
LT5pbml0X2FnZ3JlZ2F0aW9uKHByaXYpOw0KPiANCj4gLSAgICAgICBpZiAocHJpdi0+cnRsX2No
aXAgPT0gUlRMODE4OEYgfHwgcHJpdi0+cnRsX2NoaXAgPT0gUlRMODE4OEUgfHwNCj4gLSAgICAg
ICAgICAgcHJpdi0+cnRsX2NoaXAgPT0gUlRMODcxMEIpIHsNCj4gKyAgICAgICBpZiAoZm9wcy0+
aW5pdF9yZWdfcGt0X2xpZmVfdGltZSkgew0KDQpPcmlnaW5hbGx5LCA4MTkyRSBkb2Vzbid0IGRv
IHRoaXMuIEp1c3QgbWFrZSBzdXJlIHlvdSB3YW50IHRvIGRvIGl0Pw0KDQo+ICAgICAgICAgICAg
ICAgICBydGw4eHh4dV93cml0ZTE2KHByaXYsIFJFR19QS1RfVk9fVklfTElGRV9USU1FLCAweDA0
MDApOyAvKiB1bml0OiAyNTZ1cy4gMjU2bXMgKi8NCj4gICAgICAgICAgICAgICAgIHJ0bDh4eHh1
X3dyaXRlMTYocHJpdiwgUkVHX1BLVF9CRV9CS19MSUZFX1RJTUUsIDB4MDQwMCk7IC8qIHVuaXQ6
IDI1NnVzLiAyNTZtcyAqLw0KPiAgICAgICAgIH0NCj4gLS0NCj4gMi4zOS4yDQo+IA0KPiAtLS0t
LS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUt
bWFpbC4NCg==
