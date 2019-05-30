Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385312EAB2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 04:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfE3C3Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 22:29:24 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37292 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfE3C3X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 22:29:23 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4U2TBix003932, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4U2TBix003932
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 30 May 2019 10:29:11 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Thu, 30 May
 2019 10:29:11 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 01/11] rtw88: resolve order of tx power setting routines
Thread-Topic: [PATCH 01/11] rtw88: resolve order of tx power setting routines
Thread-Index: AQHVFfPQj7cTtmsick2V2quSGI+CHaaBsQ0AgAFBMkA=
Date:   Thu, 30 May 2019 02:29:10 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17FABBF@RTITMBSVM04.realtek.com.tw>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
 <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
 <f5bd9ab0-c32c-dcc6-9451-09e6b7f50a96@lwfinger.net>
In-Reply-To: <f5bd9ab0-c32c-dcc6-9451-09e6b7f50a96@lwfinger.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFycnkgRmluZ2VyIFtt
YWlsdG86bGFycnkuZmluZ2VyQGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mIExhcnJ5IEZpbmdlcg0K
PiBTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAxOSAxMToxNyBQTQ0KPiBUbzogVG9ueSBDaHVh
bmc7IGt2YWxvQGNvZGVhdXJvcmEub3JnDQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMS8xMV0gcnR3ODg6IHJlc29sdmUgb3JkZXIg
b2YgdHggcG93ZXIgc2V0dGluZyByb3V0aW5lcw0KPiANCj4gT24gNS8yOS8xOSAyOjU0IEFNLCB5
aGNodWFuZ0ByZWFsdGVrLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBZYW4tSHN1YW4gQ2h1YW5nIDx5
aGNodWFuZ0ByZWFsdGVrLmNvbT4NCj4gPg0KPiA+IFNvbWUgZnVuY3Rpb25zIHRoYXQgc2hvdWxk
IGJlIHN0YXRpYyBhcmUgdW5uZWNlc3NhcmlseSBleHBvc2VkLCByZW1vdmUNCj4gPiB0aGVpciBk
ZWNsYXJhdGlvbiBpbiBoZWFkZXIgZmlsZSBwaHkuaC4NCj4gPg0KPiA+IEFmdGVyIHJlc29sdmlu
ZyB0aGVpciBkZWNsYXJhdGlvbiBvcmRlciwgdGhleSBjYW4gYmUgZGVjbGFyZWQgYXMgc3RhdGlj
Lg0KPiA+IFNvIHRoaXMgY29tbWl0IGNoYW5nZXMgbm90aGluZyBleGNlcHQgdGhlIG9yZGVyIGFu
ZCBtYXJraW5nIHRoZW0gc3RhdGljLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWFuLUhzdWFu
IENodWFuZyA8eWhjaHVhbmdAcmVhbHRlay5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGRvZXMgbm90
IGFwcGx5LiBVc2luZyBxdWlsdCB0byBzZWUgd2hhdCBpcyB3cm9uZywgdGhlcmUgYXJlIDYNCj4g
Y2hhbmdlcw0KPiB0aGF0IGhhdmUgYWxyZWFkeSBiZWVuIGFwcGxpZWQuDQo+IA0KPiBMYXJyeQ0K
PiANCg0KDQpUaGVzZSBwYXRjaGVzIGFyZSBiYXNlZCBvbg0KDQpodHRwczovL2tlcm5lbC5nb29n
bGVzb3VyY2UuY29tL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9rdmFsby93aXJlbGVzcy1kcml2
ZXJzDQpicmFuY2ggbWFzdGVyDQoNCmNvbW1pdCA2YWNhMDk3NzFkYjQyNzdhNzg4NTNkNmFjNjgw
ZDhkNWYwZDkxNWUzDQpBdXRob3I6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4N
CkRhdGU6ICAgU2F0IE1heSA0IDE4OjMyOjI0IDIwMTkgKzA4MDANCg0KICAgIHJ0dzg4OiBNYWtl
IHNvbWUgc3ltYm9scyBzdGF0aWMNCg0KDQpJdCBzaG91bGQgYXBwbHksIGRpZCBJIG1pc3Mgc29t
ZXRoaW5nPw0KDQoNCllhbi1Ic3Vhbg0K
