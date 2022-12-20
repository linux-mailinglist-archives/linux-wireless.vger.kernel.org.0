Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8556651A77
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 07:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiLTGAf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 01:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiLTGA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 01:00:29 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0687911474
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 22:00:28 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BK5xXb65009060, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BK5xXb65009060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 20 Dec 2022 13:59:33 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 20 Dec 2022 14:00:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 20 Dec 2022 14:00:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Tue, 20 Dec 2022 14:00:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: RE: [PATCH v3 4/5] wifi: rtl8xxxu: Support new chip RTL8188EU
Thread-Topic: [PATCH v3 4/5] wifi: rtl8xxxu: Support new chip RTL8188EU
Thread-Index: AQHZEiJxQN0cgVjgGESme+CMNU7Yt652TFNQ
Date:   Tue, 20 Dec 2022 06:00:24 +0000
Message-ID: <bdc09e5caec744e8b72f44397efb4f73@realtek.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
 <3aad60f6-23f9-81e8-c741-4bd51e99f423@gmail.com>
In-Reply-To: <3aad60f6-23f9-81e8-c741-4bd51e99f423@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIwIOS4iuWNiCAwMjoyNDowMA==?=
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAx
NywgMjAyMiAxMDoxOCBQTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+OyBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFuZHJlYSBNZXJlbGxvDQo+IDxhbmRyZWEubWVyZWxsb0Bn
bWFpbC5jb20+OyBUYWVoZWUgWW9vIDxhcDQyMDA3M0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MyA0LzVdIHdpZmk6IHJ0bDh4eHh1OiBTdXBwb3J0IG5ldyBjaGlwIFJUTDgxODhFVQ0K
PiANCj4gRnJvbTogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPg0KPiANCj4g
VGhpcyBjaGlwIGlzIGZvdW5kIGluIGNoZWFwIFVTQiBkZXZpY2VzIGZyb20gVFAtTGluaywgRC1M
aW5rLCBldGMuDQo+IA0KPiBGZWF0dXJlczogMi40IEdIeiwgYi9nL24gbW9kZSwgMVQxUiwgMTUw
IE1icHMuDQo+IA0KPiBDaGlwIHZlcnNpb25zIG9sZGVyIHRoYW4gIkkgY3V0IiBuZWVkIHNvZnR3
YXJlIHJhdGUgY29udHJvbC4gVGhhdCB3aWxsDQo+IGJlIGluIHRoZSBuZXh0IGNvbW1pdC4gVW50
aWwgdGhlbiBNQ1M3IGlzIHVzZWQgZm9yIGFsbCBkYXRhIGZyYW1lcy4NCj4gDQo+IFRoZSAiSSBj
dXQiIGNoaXBzIGFyZSBub3Qgc3VwcG9ydGVkLiBUaGV5IHJlcXVpcmUgZGlmZmVyZW50IGZpcm13
YXJlDQo+IGFuZCBpbml0aWFsaXNhdGlvbiB0YWJsZXMuIFN1cHBvcnQgY2FuIGJlIGFkZGVkIGlm
IHNvbWVvbmUgaGFzIHRoZQ0KPiBoYXJkd2FyZSB0byB0ZXN0IGl0Lg0KPiANCj4gQ28tZGV2ZWxv
cGVkLWJ5OiBBbmRyZWEgTWVyZWxsbyA8YW5kcmVhLm1lcmVsbG9AZ21haWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZWEgTWVyZWxsbyA8YW5kcmVhLm1lcmVsbG9AZ21haWwuY29tPg0KPiBD
by1kZXZlbG9wZWQtYnk6IFRhZWhlZSBZb28gPGFwNDIwMDczQGdtYWlsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogVGFlaGVlIFlvbyA8YXA0MjAwNzNAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKZXMgU29yZW5zZW4gPEplcy5Tb3JlbnNlbkBnbWFpbC5jb20+DQo+IENvLWRldmVsb3BlZC1i
eTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpSZXZp
ZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+IFNv
IHRoaXMgcGF0Y2ggaXMgNTIgb2YgdGhlIDU3IHBhdGNoZXMgZm91bmQgaGVyZSwgc3F1YXNoZWQg
dG9nZXRoZXI6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2plcy9saW51eC5naXQvbG9nL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4
eA0KPiB1P2g9cnRsOHh4eHUtODE4OGV1DQo+IA0KPiBTdGFydGluZyBmcm9tIGMzZjg0ZGVkNmY3
NiAoInJ0bDh4eHh1OiBBY2NlcHQgZmlybXdhcmUgc2lnbmF0dXJlIDB4ODhlMCIpDQo+IHVwIHRv
IGE5YjA1YzA1OTUxMCAoInJ0bDh4eHh1OiBBZGQgcnB0X3NlbCBlbnRyeSB0byBzdHJ1Y3QgcnRs
OHh4eHVfcnhkZXNjMTYiKS4NCj4gDQo+IFRoZXNlIHBhdGNoZXMgd2VyZSBub3QgbmVlZGVkOg0K
PiAzMTcwNjIyY2NiNjEgKCJydGw4eHh4dTogRGV0ZWN0IDgxODhldSBwYXJ0cyBjb3JyZWN0bHki
KQ0KPiA4ZmI1YmM5MmJjZTAgKCJydGw4eHh4dTogSW5pdGlhbGl6ZSBHUElPIHNldHRpbmdzIGZv
ciA4MTg4ZXUiKQ0KPiA2YWI2NDZhZGI1ODUgKCJydGw4eHh4dTogSW1wbGVtZW50IHJ0bDgxODhl
X3NldF90eF9wb3dlcigpIikNCj4gMmNjZDFmMWZjNDgwICgicnRsOHh4eHU6IHByb3Blcmx5IGRl
dGVjdCBSVEw4MTg4RVUgZGV2aWNlcyIpDQo+IDgwOWEyZTAwMGNhYiAoInJ0bDh4eHh1OiBEbyBu
b3Qgc2V0IGF1dG8gcmF0ZSBmYWxsYmFjayBvbiA4MTg4ZXUiKQ0KPiANCj4gT24gdG9wIG9mIHRo
YXQsIEkgbWFkZSB2YXJpb3VzIGNoYW5nZXMgcmVxdWlyZWQgZm9yIHRvZGF5J3Mga2VybmVsLA0K
PiBwbHVzIGNoYW5nZXMgdG8gbWF0Y2ggdGhlIG5ld2VyIHZlbmRvciBkcml2ZXIgbW9yZSBjbG9z
ZWx5LCBwbHVzIHNvbWUNCj4gYnVnIGZpeGVzLg0KPiANCj4gdjM6DQo+ICAtIEltcGxlbWVudCBz
dWdnZXN0aW9uIGZyb20gUGluZy1LZSBTaGloOg0KPiAgICAtIFJldHVybiAtRU9QTk9UU1VQUCBk
aXJlY3RseSBpbnN0ZWFkIG9mIHVzaW5nIGdvdG8gaW4NCj4gICAgICBydGw4MTg4ZXVfaWRlbnRp
ZnlfY2hpcCgpLg0KPiAgLSBSZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSBodCBpbiBy
dGw4MTg4ZXVfY29uZmlnX2NoYW5uZWwoKS4NCj4gICAgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0
IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gdjI6DQo+ICAtIEltcGxlbWVudCBzdWdnZXN0
aW9ucyBmcm9tIFBpbmctS2UgU2hpaDoNCj4gICAgLSBBZGQgX19wYWNrZWQgdG8gc3RydWN0IHJ0
bDgxODhldV9lZnVzZS4NCj4gICAgLSBVc2UgdTMycF9yZXBsYWNlX2JpdHMoKSBpbiBydGw4MTg4
ZXVfY29uZmlnX2NoYW5uZWwoKS4NCj4gICAgLSBNYWtlIGZ3X25hbWUgY29uc3QgY2hhciouDQo+
ICAgIC0gVXNlIHRoZSBtYXNrcyBkZWZpbmVkIGluIHBhdGNoIDMvNSBpbiBydGw4MTg4ZV9jY2tf
cnNzaSgpLg0KPiAgLSBVc2UgdTMyX2dldF9iaXRzKCkgaW4gYXNzaWdubWVudCB0byBiaXQgZmll
bGQgcHJpdi0+cGlfZW5hYmxlZC4NCj4gIC0gUmVtb3ZlIHRoZSBlZnVzZSBkdW1waW5nIGNvZGUu
IEl0J3Mgbm90IG5lZWRlZCBhZnRlciBwYXRjaCAxLzUuDQo+ICAtIFVwZGF0ZSB0aGUgbW9kdWxl
IGRlc2NyaXB0aW9uLg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
OHh4eHUvS2NvbmZpZyB8ICAgIDIgKy0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9NYWtlZmlsZSAgICB8ICAgIDMgKy0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dS5oICB8ICAgNjcgKy0NCj4gIC4uLi9yZWFsdGVrL3J0bDh4eHh1L3J0
bDh4eHh1XzgxODhlLmMgICAgICAgICB8IDEyODAgKysrKysrKysrKysrKysrKysNCj4gIC4uLi9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1XzgxODhmLmMgICAgICAgICB8ICAgIDQgKy0NCj4gIC4u
Li93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYyB8ICAyMDEgKystDQo+
ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9yZWdzLmggfCAgIDQwICst
DQo+ICA3IGZpbGVzIGNoYW5nZWQsIDE1NzIgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0p
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9ydGw4eHh4dV84MTg4ZS5jDQo+IA0KDQpbLi4uXQ0KDQo=
