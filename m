Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE55F596B9A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiHQIsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiHQIsI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 04:48:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04A0C753A8
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 01:48:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27H8llDvB018593, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27H8llDvB018593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Aug 2022 16:47:47 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Aug 2022 16:47:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 17 Aug 2022 16:47:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97]) by
 RTEXMBS04.realtek.com.tw ([fe80::d902:19b0:8613:5b97%5]) with mapi id
 15.01.2375.007; Wed, 17 Aug 2022 16:47:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     =?utf-8?B?RnJhbmsgU2Now6RmZXI=?= <fschaefer.oss@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw88: "timed out to flush queue 1"
Thread-Topic: rtw88: "timed out to flush queue 1"
Thread-Index: AQHYsa2PUbznPlUGg0ebP1SP/U4JzK2yxuAg
Date:   Wed, 17 Aug 2022 08:47:59 +0000
Message-ID: <004699d134ee41aeb2ed0e31c2517b76@realtek.com>
References: <6415466b-f745-df14-2a0b-40861bd1ea10@googlemail.com>
In-Reply-To: <6415466b-f745-df14-2a0b-40861bd1ea10@googlemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTcg5LiK5Y2IIDA2OjAwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBTY2jDpGZl
ciA8ZnNjaGFlZmVyLm9zc0Bnb29nbGVtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1
c3QgMTcsIDIwMjIgNDoxOCBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogcnR3ODg6ICJ0
aW1lZCBvdXQgdG8gZmx1c2ggcXVldWUgMSINCj4gDQo+IEkgdHJpZWQgd2lyZWxlc3MtdGVzdGlu
ZyB0b2RheSB0byBzZWUgaWYgdGhlIHJlY2VudCBydHc4OCBwYXRjaGVzIGFyZQ0KPiBmaXhpbmcg
dGhlIHByb2JsZW1zIEknbSBmYWNpbmcgd2l0aCBteSBydHc4ODIxY2UgZGV2aWNlLg0KPiBUaGUg
ZGV2aWNlIG5vdyBhc3NvY2lhdGVzIG11Y2ggZmFzdGVyIGFuZCB0aGUgdG9ucyBvZiAiZmFpbGVk
IHRvIGdldCB0eA0KPiByZXBvcnQgZnJvbSBmaXJtd2FyZSIgbWVzc2FnZXMgYXJlIGdvbmUuDQo+
IEhvd2V2ZXIsIHRoZSBkZXZpY2UgZGlzY29ubmVjdHMgdmVyeSBvZnRlbiBhbmQgdGhlIGxvZyBz
aG93cyBsb3RzIG9mDQo+IA0KPiBbwqDCoCAyMC45MDA3ODZdIHJ0d184ODIxY2UgMDAwMDowMjow
MC4wOiB0aW1lZCBvdXQgdG8gZmx1c2ggcXVldWUgMQ0KPiANCj4gbWVzc2FnZXMsIHdoaWNoIGlz
IG5ldy4NCj4gDQo+IA0KPiBBIHR5cGljYWwgc2VjdGlvbiBmcm9tIHRoZSBkbWVzZyBvdXRwdXQ6
DQo+IC4uLg0KPiBbwqDCoCAxMy4wOTkwMjhdIHdsbzE6IGF1dGhlbnRpY2F0ZSB3aXRoIGY4OmQx
OjExOnh4Onh4Onh4DQo+IFvCoMKgIDEzLjEyODgzM10gd2xvMTogQWxsb2NhdGVkIFNUQSBmODpk
MToxMTp4eDp4eDp4eA0KPiBbwqDCoCAxMy4xMjg4NDZdIHdsbzE6IEhFIG5vdCBzdXBwb3J0ZWQs
IGRpc2FibGluZyBIRSBhbmQgRUhUDQo+IFvCoMKgIDEzLjEyODg0OF0gd2xvMTogRUhUIG5vdCBz
dXBwb3J0ZWQsIGRpc2FibGluZyBFSFQNCj4gW8KgwqAgMTMuMTI4ODQ5XSB3bG8xOiBiYWQgVkhU
IGNhcGFiaWxpdGllcywgZGlzYWJsaW5nIFZIVA0KPiBbwqDCoCAxMy4xMjg4NTJdIHdsbzE6IFZI
VCBvcGVyYXRpb24gbWlzc2luZyAvIFZIVCBub3Qgc3VwcG9ydGVkDQo+IFvCoMKgIDEzLjYzNDgx
Ml0gd2xvMTogSW5zZXJ0ZWQgU1RBIGY4OmQxOjExOnh4Onh4Onh4DQo+IFvCoMKgIDEzLjc3Mjgw
M10gd2xvMTogc2VuZCBhdXRoIHRvIGY4OmQxOjExOnh4Onh4Onh4ICh0cnkgMS8zKQ0KPiBbwqDC
oCAxMy43NzU0OTNdIHdsbzE6IGF1dGhlbnRpY2F0ZWQNCj4gW8KgwqAgMTMuNzc1NTAxXSB3bG8x
OiBtb3ZpbmcgU1RBIGY4OmQxOjExOnh4Onh4Onh4IHRvIHN0YXRlIDINCj4gW8KgwqAgMTMuNzc1
Njc2XSBydHdfODgyMWNlIDAwMDA6MDI6MDAuMCB3bG8xOiBkaXNhYmxpbmcgSFQvVkhUL0hFIGFz
DQo+IFdNTS9Rb1MgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgQVANCj4gW8KgwqAgMTMuODEyODE1
XSB3bG8xOiBIRSBub3Qgc3VwcG9ydGVkLCBkaXNhYmxpbmcgSEUgYW5kIEVIVA0KPiBbwqDCoCAx
My44MTI4MjJdIHdsbzE6IEVIVCBub3Qgc3VwcG9ydGVkLCBkaXNhYmxpbmcgRUhUDQo+IFvCoMKg
IDEzLjgxMjgyNl0gd2xvMTogSFQgb3BlcmF0aW9uIG1pc3NpbmcgLyBIVCBub3Qgc3VwcG9ydGVk
DQoNCkRvZXMgeW91ciBBUCBzdXBwb3J0IEhUIG9yIFZIVD8gDQpDYW4geW91IGNoYW5nZSBhbm90
aGVyIEFQIHRoYXQgc3VwcG9ydCBWSFQ/DQoNCg0KPiBbwqDCoCAxNC4zMTg5NTVdIHdsbzE6IGFz
c29jaWF0ZSB3aXRoIGY4OmQxOjExOnh4Onh4Onh4ICh0cnkgMS8zKQ0KPiBbwqDCoCAxNC41NjEz
MjRdIHdsbzE6IGFzc29jaWF0ZSB3aXRoIGY4OmQxOjExOnh4Onh4Onh4ICh0cnkgMi8zKQ0KPiBb
wqDCoCAxNC41NzEwMTJdIHdsbzE6IFJYIEFzc29jUmVzcCBmcm9tIGY4OmQxOjExOnh4Onh4Onh4
IChjYXBhYj0weDQzMQ0KPiBzdGF0dXM9MCBhaWQ9MSkNCj4gW8KgwqAgMTQuNTcxMDUyXSB3bG8x
OiBtb3ZpbmcgU1RBIGY4OmQxOjExOnh4Onh4Onh4IHRvIHN0YXRlIDMNCj4gW8KgwqAgMTQuNTcx
MjA4XSB3bG8xOiBhc3NvY2lhdGVkDQo+IFvCoMKgIDE0LjY0OTI1Ml0gSVB2NjogQUREUkNPTkYo
TkVUREVWX0NIQU5HRSk6IHdsbzE6IGxpbmsgYmVjb21lcyByZWFkeQ0KPiBbwqDCoCAxNC42NDk2
MTBdIHdsbzE6IG1vdmluZyBTVEEgZjg6ZDE6MTE6eHg6eHg6eHggdG8gc3RhdGUgNA0KPiBbwqDC
oCAyMC45MDA3ODZdIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiB0aW1lZCBvdXQgdG8gZmx1c2gg
cXVldWUgMQ0KPiBbwqDCoCAyMS4zOTI3ODRdIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiB0aW1l
ZCBvdXQgdG8gZmx1c2ggcXVldWUgMQ0KPiBbwqDCoCAyMS45MDQ3NzldIHJ0d184ODIxY2UgMDAw
MDowMjowMC4wOiB0aW1lZCBvdXQgdG8gZmx1c2ggcXVldWUgMQ0KPiBbwqDCoCAyMi4wNDQ3NzBd
IHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiB0aW1lZCBvdXQgdG8gZmx1c2ggcXVldWUgMQ0KPiBb
wqDCoCAyMy4zMTI3NzZdIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiB0aW1lZCBvdXQgdG8gZmx1
c2ggcXVldWUgMQ0KPiBbwqDCoCAyNS40NDQ4MDNdIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiB0
aW1lZCBvdXQgdG8gZmx1c2ggcXVldWUgMQ0KPiBbwqDCoCAyNS45NjA4MTZdIHJ0d184ODIxY2Ug
MDAwMDowMjowMC4wOiB0aW1lZCBvdXQgdG8gZmx1c2ggcXVldWUgMQ0KPiBbwqDCoCAyNy4yNDky
OTBdIHdsbzE6IGNhbmNlbGxpbmcgQVAgcHJvYmUgZHVlIHRvIGEgcmVjZWl2ZWQgYmVhY29uDQo+
IFvCoMKgIDMxLjE2ODc4MV0gcnR3Xzg4MjFjZSAwMDAwOjAyOjAwLjA6IHRpbWVkIG91dCB0byBm
bHVzaCBxdWV1ZSAxDQo+IFvCoMKgIDMxLjYwNDk0NV0gcnR3Xzg4MjFjZSAwMDAwOjAyOjAwLjA6
IHRpbWVkIG91dCB0byBmbHVzaCBxdWV1ZSAxDQo+IFvCoMKgIDMyLjU3Mjc2N10gcnR3Xzg4MjFj
ZSAwMDAwOjAyOjAwLjA6IHRpbWVkIG91dCB0byBmbHVzaCBxdWV1ZSAxDQo+IFvCoMKgIDMzLjgz
Mjg1Nl0gcnR3Xzg4MjFjZSAwMDAwOjAyOjAwLjA6IHRpbWVkIG91dCB0byBmbHVzaCBxdWV1ZSAx
DQo+IFvCoMKgIDM2LjQ2MTAyNV0gcnR3Xzg4MjFjZSAwMDAwOjAyOjAwLjA6IHRpbWVkIG91dCB0
byBmbHVzaCBxdWV1ZSAxDQo+IFvCoMKgIDM3LjQwNTA3MV0gcnR3Xzg4MjFjZSAwMDAwOjAyOjAw
LjA6IHRpbWVkIG91dCB0byBmbHVzaCBxdWV1ZSAxDQo+IFvCoMKgIDM3Ljg4OTAzMV0gcnR3Xzg4
MjFjZSAwMDAwOjAyOjAwLjA6IHRpbWVkIG91dCB0byBmbHVzaCBxdWV1ZSAxDQo+IFvCoMKgIDM5
LjY0MTQxN10gd2xvMTogY2FuY2VsbGluZyBBUCBwcm9iZSBkdWUgdG8gYSByZWNlaXZlZCBiZWFj
b24NCj4gW8KgwqAgNDkuMjkzMzE1XSB3bG8xOiBjYW5jZWxsaW5nIEFQIHByb2JlIGR1ZSB0byBh
IHJlY2VpdmVkIGJlYWNvbg0KPiBbwqDCoCA1OC44NjEzMTldIHdsbzE6IGNhbmNlbGxpbmcgQVAg
cHJvYmUgZHVlIHRvIGEgcmVjZWl2ZWQgYmVhY29uDQo+IFvCoMKgIDY4LjY2OTMzMF0gd2xvMTog
Y2FuY2VsbGluZyBBUCBwcm9iZSBkdWUgdG8gYSByZWNlaXZlZCBiZWFjb24NCj4gW8KgwqAgNzgu
MjA1MzIxXSB3bG8xOiBjYW5jZWxsaW5nIEFQIHByb2JlIGR1ZSB0byBhIHJlY2VpdmVkIGJlYWNv
bg0KPiBbwqDCoCA4MC43OTMwNDJdIHdsbzE6IGRldGVjdGVkIGJlYWNvbiBsb3NzIGZyb20gQVAg
KG1pc3NlZCA3IGJlYWNvbnMpIC0NCj4gcHJvYmluZw0KPiBbwqDCoCA4MC44MjQ0MjRdIHdsbzE6
IE5vIGFjayBmb3IgbnVsbGZ1bmMgZnJhbWUgdG8gQVAgZjg6ZDE6MTE6eHg6eHg6eHgsDQo+IHRy
eSAxLzINCj4gW8KgwqAgODAuODUxODUxXSB3bG8xOiBObyBhY2sgZm9yIG51bGxmdW5jIGZyYW1l
IHRvIEFQIGY4OmQxOjExOnh4Onh4Onh4LA0KPiBkaXNjb25uZWN0aW5nLg0KPiBbwqDCoCA4MC44
ODkwNjBdIHdsbzE6IG1vdmluZyBTVEEgZjg6ZDE6MTE6eHg6eHg6eHggdG8gc3RhdGUgMw0KPiBb
wqDCoCA4MC45MDUyMDJdIHdsbzE6IG1vdmluZyBTVEEgZjg6ZDE6MTE6eHg6eHg6eHggdG8gc3Rh
dGUgMg0KPiBbwqDCoCA4MC45MDUyMzBdIHdsbzE6IG1vdmluZyBTVEEgZjg6ZDE6MTE6eHg6eHg6
eHggdG8gc3RhdGUgMQ0KPiBbwqDCoCA4MC45MDUyMzNdIHdsbzE6IFJlbW92ZWQgU1RBIGY4OmQx
OjExOnh4Onh4Onh4DQo+IFvCoMKgIDgwLjkwNTMzOF0gd2xvMTogRGVzdHJveWVkIFNUQSBmODpk
MToxMTp4eDp4eDp4eA0KPiAuLi4NCj4gDQo+IEZXIHZlcnNpb24gaXMgMjQuMTEuMC4NCj4gSSB0
cmllZCB3aXRoIGFuZCB3aXRob3V0IGRpc2FibGVfbHBzX2RlZXAgLyBkaXNhYmxlX2FzcG0sIGJ1
dCB0aGF0IG1ha2VzDQo+IG5vIGRpZmZlcmVuY2UuDQo+IA0KPiBBbnkgaWRlYXMgPyBBbnl0aGlu
ZyBJIGNhbiBkbyA/DQo+IA0KDQpJdCBzZWVtcyBsaWtlIGxpbmsgcXVhbGl0eSBpc24ndCBnb29k
LiBQbGVhc2UgdHVybiBvZmYgcG93ZXIgc2F2aW5nDQpieSAnaXcgd2xvMSBzZXQgcG93ZXJfc2F2
ZSBvZmYnIHRvIHNlZSBpZiBpdCBjYW4gaGVscC4NCkFuZCwgdXNlICdpdyB3bG8xIHN0YXRpb24g
ZHVtcCcgdG8gY2hlY2sgbGluayBxdWFsaXR5Lg0KSWYgJ3NpZ25hbDonIGlzIGxvd2VyIHRoYW4g
LTYwLCBpdCB3aWxsIGJlIGJhZC4NCg0KUGluZy1LZQ0KDQo=
