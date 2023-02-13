Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EAB693D1C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBMDnM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Feb 2023 22:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBMDnK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Feb 2023 22:43:10 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396BCC2C
        for <linux-wireless@vger.kernel.org>; Sun, 12 Feb 2023 19:43:04 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31D3gnKM3023053, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31D3gnKM3023053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 13 Feb 2023 11:42:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 13 Feb 2023 11:42:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 13 Feb 2023 11:42:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 13 Feb 2023 11:42:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Gary Chang <gary.chang@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>, Paul Gover <pmw.gover@yahoo.co.uk>
Subject: RE: Resume after suspend broken, reboots instead on kernel 6.1 onwards x86_64 RTW88
Thread-Topic: Resume after suspend broken, reboots instead on kernel 6.1
 onwards x86_64 RTW88
Thread-Index: AQHZPUq9LL7Q0TEotEGymQfrGPQA4q7MPidg
Date:   Mon, 13 Feb 2023 03:42:14 +0000
Message-ID: <0024ebe795eb48969380d442b24fc4be@realtek.com>
References: <3739412.kQq0lBPeGt.ref@ryzen> <3739412.kQq0lBPeGt@ryzen>
 <10a47408-3019-403d-97b1-c9f36e52e130@leemhuis.info>
In-Reply-To: <10a47408-3019-403d-97b1-c9f36e52e130@leemhuis.info>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzIvMTMg5LiK5Y2IIDAxOjA3OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXgga2VybmVsIHJl
Z3Jlc3Npb24gdHJhY2tpbmcgKFRob3JzdGVuIExlZW1odWlzKSA8cmVncmVzc2lvbnNAbGVlbWh1
aXMuaW5mbz4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxMCwgMjAyMyA4OjI1IFBNDQo+IFRv
OiBHYXJ5IENoYW5nIDxnYXJ5LmNoYW5nQHJlYWx0ZWsuY29tPjsgWWFuLUhzdWFuIENodWFuZyA8
dG9ueTA2MjBlbW1hQGdtYWlsLmNvbT4NCj4gQ2M6IHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRl
djsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBMaW51eCBrZXJuZWwgcmVncmVzc2lv
bnMgbGlzdA0KPiA8cmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2PjsgS2FsbGUgVmFsbyA8a3Zh
bG9Aa2VybmVsLm9yZz47IFBhdWwgR292ZXIgPHBtdy5nb3ZlckB5YWhvby5jby51az47DQo+IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFJlc3VtZSBhZnRlciBzdXNwZW5k
IGJyb2tlbiwgcmVib290cyBpbnN0ZWFkIG9uIGtlcm5lbCA2LjEgb253YXJkcyB4ODZfNjQgUlRX
ODgNCj4gDQo+IFthZGRpbmcgQ2hpaC1LYW5nIENoYW5nIChhdXRob3IpLCBLYWxsZSAoY29tbWl0
dGVyKSBhbmQgTEtNTCB0byB0aGUgbGlzdA0KPiBvZiByZWNpcGllbnRzXQ0KPiANCj4gW2FueW9u
ZSB3aG8gcmVwbGllcyB0byB0aGlzOiBmZWVsIGZyZWUgdG8gcmVtb3ZlIHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gZnJvbSB0aGUgcmVjaXBpZW50cywgdGhpcyBpcyBhIG1haW5saW5lIHJlZ3Jl
c3Npb25dDQo+IA0KPiBbVExEUjogSSdtIGFkZGluZyB0aGlzIHJlcG9ydCB0byB0aGUgbGlzdCBv
ZiB0cmFja2VkIExpbnV4IGtlcm5lbA0KPiByZWdyZXNzaW9uczsgdGhlIHRleHQgeW91IGZpbmQg
YmVsb3cgaXMgYmFzZWQgb24gYSBmZXcgdGVtcGxhdGVzDQo+IHBhcmFncmFwaHMgeW91IG1pZ2h0
IGhhdmUgZW5jb3VudGVyZWQgYWxyZWFkeSBpbiBzaW1pbGFyIGZvcm0uDQo+IFNlZSBsaW5rIGlu
IGZvb3RlciBpZiB0aGVzZSBtYWlscyBhbm5veSB5b3UuXQ0KPiANCj4gT24gMDkuMDIuMjMgMjA6
NTksIFBhdWwgR292ZXIgd3JvdGU6DQo+ID4gU3VzcGVuZC9SZXN1bWUgd2FzIHdvcmtpbmcgT0sg
b24ga2VybmVsIDYuMC4xMywgYnJva2VuIHNpbmNlIDYuMS4xDQo+ID4gKEkndmUgbm90IHRyaWVk
IGtlcm5lbHMgYmV0d2VlbiB0aG9zZSwgZXhjZXB0IGluIHRoZSBiaXNlY3QgYmVsb3cuKQ0KPiA+
IEFsbCBzdWJzZXF1ZW50IDYsMSBrZXJuZWxzIGV4aGliaXQgdGhlIHNhbWUgYmVoYXZpb3VyLg0K
PiA+DQo+ID4gU3VzcGVuZCB3b3JrcyBPSywgYnV0IG9uIFJlc3VtZSwgdGhlcmUncyBhIGZsaWNr
ZXIsIGFuZCB0aGVuIGl0IHJlYm9vdHMuDQo+ID4gU29tZXRpbWVzIHRoZSBzY3JlZW4gZ2V0cyBy
ZXN0b3JlZCB0byBpdHMgY29udGVudHMgYXQgdGhlIHRpbWUgb2Ygc3VzcGVuZC4gYnV0DQo+ID4g
bGVzcyB0aGFuIGEgc2Vjb25kIGxhdGVyLCBpdCBzdGFydHMgcmVib290aW5nLg0KPiA+IFRvIHJl
cHJvZHVjZSwgc2ltcGx5IGJvb3QsIHN1c3BlbmQsIGFuZCByZXN1bWUuDQo+ID4NCj4gPiBHaXQg
YmlzZWN0IGJsYW1lcyBSVFc4OA0KPiA+IGNvbW1pdCA2YmYzYTA4MzQwN2I1ZDQwNGQ3MGVmYzNh
NWFjNzViNDcyZTVlZmE5DQo+IA0KPiBUV0lNQywgdGhhdCdzICJ3aWZpOiBydHc4ODogYWRkIGZs
YWcgY2hlY2sgYmVmb3JlIGVudGVyIG9yIGxlYXZlIElQUyINCj4gDQo+ID4gSSdsbCBhdHRhY2gg
YmlzZWN0IGxvZywgZG1lc2cgYW5kIGNvbmZpZ3MgdG8gdGhlIGJ1ZyBJJ3ZlIG9wZW5lZA0KPiA+
IAlodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzAxNg0KPiA+
DQo+ID4gZG1lc2cgZnJvbSB0aGUgZm9sbG93aW5nIGJvb3Qgc2hvdyBhIGhhcmR3YXJlIGVycm9y
Lg0KPiA+IEl0J3Mgbm90IHRoZXJlIHdoZW4gdGhlIHN5c3RlbSByZXN1bWVzIG9yIHJlYm9vdHMg
d2l0aCA2LjAuMTMsDQo+ID4gYW5kIGlmIEkgZG9uJ3Qgc3VzcGVuZCAmIHJlc3VtZSwgdGhlcmUg
YXJlIG5vIHJlcG9ydGVkIGVycm9ycy4NCj4gPg0KPiA+IFRoZSBwcm9ibGVtIG9jY3VycyB1bmRl
ciBib3RoIFdheWxhbmQgYW5kIFgxMSwgYW5kIGZyb20gdGhlIGNvbW1hbmQgbGluZSB2aWENCj4g
PiBlY2hvIG1lbT4vc3lzL3Bvd2VyLnN0YXRlDQo+ID4NCj4gPg0KPiA+IFZhbmlsbGEga2VybmVs
cywgdW50YWludGVkLCBjb21waWxlZCB3aXRoIEdDQzsgbXkgc3lzdGVtIGlzIEdlbnRvbyBGV0lX
LCBidXQgSQ0KPiA+IGRvIG15IG93biBrZXJuZWxzIGRpcmVjdCBmcm9tIGEgZ2l0IGNsb25lIG9m
IHN0YWJsZS4NCj4gPg0KPiA+IENvdWxkbid0IGZpbmQgYW55dGhpbmcgc2ltaWxhciB3aXRoIEdv
b2dsZSBvciB0aGUgbWFpbGluZyBsaXN0cy4NCj4gPg0KPiA+ICoqSGFyZHdhcmU6KioNCj4gPg0K
PiA+IEhQIExhcHRvcCAxNS1idzB4eA0KPiA+IEFNRCBBOS05NDIwIFJBREVPTiBSNSwgNSBDT01Q
VVRFIENPUkVTDQo+ID4gU3RvbmV5IFtSYWRlb24gUjIvUjMvUjQvUjUgR3JhcGhpY3NdDQo+ID4g
NCBHQiBtZW1vcnkNCj4gPiBSVEw4NzIzREUgUENJZSBhZGFwdGVyDQo+ID4NCj4gPiAqKktlcm5l
bCoqDQo+ID4NCj4gPiBLZXJuZWwgY29tbWFuZCBsaW5lOg0KPiA+IHBzbW91c2Uuc3luYXB0aWNz
X2ludGVydG91Y2g9MSBwY2llX2FzcG09Zm9yY2UgcmRyYW5kPWZvcmNlIHJvb3Rmc3R5cGU9ZjJm
cw0KPiA+IHJvb3Q9TEFCRUw9Z2VudG9vDQo+ID4NCj4gPiBDT05GSUdfUlRXODg9bQ0KPiA+IENP
TkZJR19SVFc4OF9DT1JFPW0NCj4gPiBDT05GSUdfUlRXODhfUENJPW0NCj4gPiBDT05GSUdfUlRX
ODhfODcyM0Q9bQ0KPiA+ICMgQ09ORklHX1JUVzg4Xzg4MjJCRSBpcyBub3Qgc2V0DQo+ID4gIyBD
T05GSUdfUlRXODhfODgyMkNFIGlzIG5vdCBzZXQNCj4gPiBDT05GSUdfUlRXODhfODcyM0RFPW0N
Cj4gPiAjIENPTkZJR19SVFc4OF84ODIxQ0UgaXMgbm90IHNldA0KPiA+ICMgQ09ORklHX1JUVzg4
X0RFQlVHIGlzIG5vdCBzZXQNCj4gPiAjIENPTkZJR19SVFc4OF9ERUJVR0ZTIGlzIG5vdCBzZXQN
Cj4gPiAjIENPTkZJR19SVFc4OSBpcyBub3Qgc2V0DQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXBv
cnQuIFRvIGJlIHN1cmUgdGhlIGlzc3VlIGRvZXNuJ3QgZmFsbCB0aHJvdWdoIHRoZQ0KPiBjcmFj
a3MgdW5ub3RpY2VkLCBJJ20gYWRkaW5nIGl0IHRvIHJlZ3pib3QsIHRoZSBMaW51eCBrZXJuZWwg
cmVncmVzc2lvbg0KPiB0cmFja2luZyBib3Q6DQo+IA0KPiAjcmVnemJvdCBeaW50cm9kdWNlZCA2
YmYzYTA4MzQwN2INCj4gI3JlZ3pib3QgdGl0bGUgd2lmaTogcnR3ODg6IHJlc3VtZSBicm9rZW4g
KHJlYm9vdCkNCj4gI3JlZ3pib3QgaWdub3JlLWFjdGl2aXR5DQo+IA0KPiBUaGlzIGlzbid0IGEg
cmVncmVzc2lvbj8gVGhpcyBpc3N1ZSBvciBhIGZpeCBmb3IgaXQgYXJlIGFscmVhZHkNCj4gZGlz
Y3Vzc2VkIHNvbWV3aGVyZSBlbHNlPyBJdCB3YXMgZml4ZWQgYWxyZWFkeT8gWW91IHdhbnQgdG8g
Y2xhcmlmeSB3aGVuDQo+IHRoZSByZWdyZXNzaW9uIHN0YXJ0ZWQgdG8gaGFwcGVuPyBPciBwb2lu
dCBvdXQgSSBnb3QgdGhlIHRpdGxlIG9yDQo+IHNvbWV0aGluZyBlbHNlIHRvdGFsbHkgd3Jvbmc/
IFRoZW4ganVzdCByZXBseSBhbmQgdGVsbCBtZSAtLSBpZGVhbGx5DQo+IHdoaWxlIGFsc28gdGVs
bGluZyByZWd6Ym90IGFib3V0IGl0LCBhcyBleHBsYWluZWQgYnkgdGhlIHBhZ2UgbGlzdGVkIGlu
DQo+IHRoZSBmb290ZXIgb2YgdGhpcyBtYWlsLg0KPiANCj4gRGV2ZWxvcGVyczogV2hlbiBmaXhp
bmcgdGhlIGlzc3VlLCByZW1lbWJlciB0byBhZGQgJ0xpbms6JyB0YWdzIHBvaW50aW5nDQo+IHRv
IHRoZSByZXBvcnQgKHRoZSBwYXJlbnQgb2YgdGhpcyBtYWlsKS4gU2VlIHBhZ2UgbGlua2VkIGlu
IGZvb3RlciBmb3INCj4gZGV0YWlscy4NCj4gDQo+IENpYW8sIFRob3JzdGVuICh3ZWFyaW5nIGhp
cyAndGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlcicgaGF0KQ0KDQpTaW5jZSBy
dHc4OCBjYW4gc3VwcG9ydCA4NzIzREUsIDg4MjFDRSwgODgyMkJFIGFuZCA4ODIyQ0UsIGRvIHlv
dSBoYXZlIGNoaXAgb3RoZXINCnRoYW4gODcyM0RFIHRvIGdpdmUgYSB0cnk/IE9yLCBpbnN0YWxs
IDg3MjNERSB0byBhbm90aGVyIHBsYXRmb3JtPyANCg0KSSBoYXZlIGFkZGVkIG15c2VsZiB0byBr
ZXJuZWwgQnVnemlsbGEsIHNvIHdlIGNhbiBkaXNjdXNzIGZ1cnRoZXIgdGhlcmUuDQpXZSB3aWxs
IHRyeSB0byByZXByb2R1Y2UgdGhpcyBwcm9ibGVtLCBhbmQgd2lsbCB1cGRhdGUgdG8gQnVnemls
bGEgaWYgYW55IGZpbmRpbmcuDQoNClBpbmctS2UNCg0K
