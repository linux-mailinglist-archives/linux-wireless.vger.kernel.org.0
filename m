Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66C363850E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 09:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKYIQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 03:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKYIQw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 03:16:52 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7072303D5
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 00:16:51 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AP8G4u04032120, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AP8G4u04032120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Nov 2022 16:16:04 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 25 Nov 2022 16:16:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Nov 2022 16:16:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Fri, 25 Nov 2022 16:16:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Topic: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
Thread-Index: AQHY/4LYAwFnH2Rc4ECh6z0I+CxFRa5PSOhwgAAD5nA=
Date:   Fri, 25 Nov 2022 08:16:47 +0000
Message-ID: <9837ba7eda3b4bec83e1630591bfc956@realtek.com>
References: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
 <5992feea33944726b62d63951f118e7e@realtek.com>
In-Reply-To: <5992feea33944726b62d63951f118e7e@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI1IOS4iuWNiCAwNjowMDowMA==?=
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI1LCAyMDIyIDQ6MDUg
UE0NCj4gVG86IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPjsgbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3Jl
bnNlbkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8yXSB3aWZpOiBydGw4eHh4
dTogRml4IHRoZSBjaGFubmVsIHdpZHRoIHJlcG9ydGluZw0KPiANCj4gDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgy
MWNlcmZlMkBnbWFpbC5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI0LCAyMDIy
IDU6MzEgQU0NCj4gPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6
IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT47IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KPiA+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIHdpZmk6IHJ0bDh4eHh1
OiBGaXggdGhlIGNoYW5uZWwgd2lkdGggcmVwb3J0aW5nDQo+ID4NCj4gPiBUaGUgZ2VuIDIgY2hp
cHMgUlRMODE5MkVVIGFuZCBSVEw4MTg4RlUgcGVyaW9kaWNhbGx5IHNlbmQgdGhlIGRyaXZlcg0K
PiA+IHJlcG9ydHMgYWJvdXQgdGhlIFRYIHJhdGUsIGFuZCB0aGUgZHJpdmVyIHBhc3NlcyB0aGVz
ZSByZXBvcnRzIHRvDQo+ID4gc3RhX3N0YXRpc3RpY3MuIFRoZSByZXBvcnRzIGZyb20gUlRMODE5
MkVVIG1heSBvciBtYXkgbm90IGluY2x1ZGUgdGhlDQo+ID4gY2hhbm5lbCB3aWR0aC4gVGhlIHJl
cG9ydHMgZnJvbSBSVEw4MTg4RlUgZG8gbm90IGluY2x1ZGUgaXQuDQo+ID4NCj4gPiBPbmx5IGFj
Y2VzcyB0aGUgYzJoLT5yYV9yZXBvcnQuYncgZmllbGQgaWYgdGhlIHJlcG9ydCAoc2tiKSBpcyBi
aWcNCj4gPiBlbm91Z2guDQo+ID4NCj4gPiBUaGUgb3RoZXIgcHJvYmxlbSBmaXhlZCBoZXJlIGlz
IHRoYXQgdGhlIGNvZGUgd2FzIGFjdHVhbGx5IG5ldmVyDQo+ID4gY2hhbmdpbmcgdGhlIGNoYW5u
ZWwgd2lkdGggaW5pdGlhbGx5IHJlcG9ydGVkIGJ5DQo+ID4gcnRsOHh4eHVfYnNzX2luZm9fY2hh
bmdlZCBiZWNhdXNlIHRoZSB2YWx1ZSBvZiBSQVRFX0lORk9fQldfMjAgaXMgMC4NCj4gPg0KPiA+
IEZpeGVzOiAwOTg1ZDNhNDEwYWMgKCJydGw4eHh4dTogRmVlZCBjdXJyZW50IHR4cmF0ZSBpbmZv
cm1hdGlvbiBmb3IgbWFjODAyMTEiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21p
dGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8IDEwICsrKysrKystLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gPiBpbmRleCAyOGYxMzYwNjQyOTcuLjFjMjlkMGJmMDll
MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+ID4gQEAgLTU1NjksNyArNTU2OSw2IEBAIHN0YXRp
YyB2b2lkIHJ0bDh4eHh1X2MyaGNtZF9jYWxsYmFjayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
DQo+ID4gIAkJCXJhcnB0LT50eHJhdGUuZmxhZ3MgPSAwOw0KPiA+ICAJCQlyYXRlID0gYzJoLT5y
YV9yZXBvcnQucmF0ZTsNCj4gPiAgCQkJc2dpID0gYzJoLT5yYV9yZXBvcnQuc2dpOw0KDQpBZGRp
dGlvbmFsIG9uZSBxdWVzdGlvbiBhYm91dCBzbWFsbCBzaXplIG9mIHJlcG9ydCAoc2tiKS4NCklz
IGl0IHBvc3NpYmxlIHlvdSBjYW4ndCBhY2Nlc3MgLnNnaSBhbmQgLnJhdGUgdG9vPw0KDQo+ID4g
LQkJCWJ3ID0gYzJoLT5yYV9yZXBvcnQuYnc7DQo+ID4NCj4gPiAgCQkJaWYgKHJhdGUgPCBERVND
X1JBVEVfTUNTMCkgew0KPiA+ICAJCQkJcmFycHQtPnR4cmF0ZS5sZWdhY3kgPQ0KPiA+IEBAIC01
NTg2LDggKzU1ODUsMTMgQEAgc3RhdGljIHZvaWQgcnRsOHh4eHVfYzJoY21kX2NhbGxiYWNrKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiAgCQkJCQkJUkFURV9JTkZPX0ZMQUdTX1NIT1JU
X0dJOw0KPiA+ICAJCQkJfQ0KPiA+DQo+ID4gLQkJCQlpZiAoYncgPT0gUkFURV9JTkZPX0JXXzIw
KQ0KPiA+IC0JCQkJCXJhcnB0LT50eHJhdGUuYncgfD0gUkFURV9JTkZPX0JXXzIwOw0KPiA+ICsJ
CQkJaWYgKHNrYi0+bGVuID49IDIgKyA3KSB7DQo+IA0KPiBJIHRoaW5rIDIgaXMgaGVhZGVyIGxl
bmd0aCBvZiBDMkgsIGFuZCA3IGlzIHNpemVvZihjMmgtPnJhX3JlcG9ydCksIHNvIHdlIGNhbg0K
PiBoYXZlOg0KPiAjZGVmaW5lIFJUTDhYWFhVX0MySF9IRFJfTEVOIDINCj4gDQo+IFRoZW4sIHJl
cGxhY2UgdGhpcyBzdGF0ZW1lbnQgd2l0aA0KPiANCj4gaWYgKHNrYi0+bGVuID49IFJUTDhYWFhV
X0MySF9IRFJfTEVOICsgc2l6ZW9mKGMyaC0+cmFfcmVwb3J0KSkNCj4gDQo+IEJ5IHRoZSB3YXks
IEkgZm91bmQgJ3N0cnVjdCBydGw4NzIzYnVfYzJoJyBtaXNzICdfX3BhY2tlZCcuDQo+IA0KPiAt
LQ0KPiBQaW5nLUtlDQo+IA0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9u
bWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
