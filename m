Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE374347
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 04:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbfGYC0y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 22:26:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57944 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389085AbfGYC0y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 22:26:54 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6P2QkOr002456, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6P2QkOr002456
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Jul 2019 10:26:47 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Thu, 25 Jul
 2019 10:26:46 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Brian Norris" <briannorris@chromium.org>
Subject: RE: [RFC PATCH] rtw88: use txpwr_lmt_cfg_pair struct, not arrays
Thread-Topic: [RFC PATCH] rtw88: use txpwr_lmt_cfg_pair struct, not arrays
Thread-Index: AQHVORrdzwsI0XBcs027K+5Cn7dZRqbZK/8AgAGBnXA=
Date:   Thu, 25 Jul 2019 02:26:45 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D187DDAE@RTITMBSVM04.realtek.com.tw>
References: <20190713013232.215138-1-briannorris@chromium.org>
 <20190724112304.7DDF960909@smtp.codeaurora.org>
In-Reply-To: <20190724112304.7DDF960909@smtp.codeaurora.org>
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

PiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4gd3JvdGU6DQo+IA0KPiA+
IFdlJ3JlIGp1c3QgdHJ1c3RpbmcgdGhhdCB0aGVzZSB0YWJsZXMgYXJlIG9mIHRoZSByaWdodCBk
aW1lbnNpb25zLCB3aGVuDQo+ID4gd2UgY291bGQgZG8gYmV0dGVyIGJ5IGp1c3QgdXNpbmcgdGhl
IHN0cnVjdCBkaXJlY3RseS4gTGV0J3MgZXhwb3NlIHRoZQ0KPiA+IHN0cnVjdCB0eHB3cl9sbXRf
Y2ZnX3BhaXIgaW5zdGVhZC4NCj4gPg0KPiA+IFRoZSB0YWJsZSBjaGFuZ2VzIHdlcmUgbWFkZSBi
eSB1c2luZyBzb21lIFZpbSBtYWNyb3MsIHNvIHRoYXQgc2hvdWxkDQo+ID4gaGVscCBwcmV2ZW50
IGFueSB0cmFuc2xhdGlvbiBtaXN0YWtlcyBhbG9uZyB0aGUgd2F5Lg0KPiA+DQo+ID4gUmVtYWlu
aW5nIHdvcms6IGdldCB0aGUgJ3ZvaWQgKmRhdGEnIG91dCBvZiB0aGUgZ2VuZXJpYyBzdHJ1Y3QN
Cj4gPiBydHdfdGFibGU7IGFsbCBvZiB0aGVzZSB0YWJsZXMgcmVhbGx5IGRlc2VydmUgdG8gYmUg
dGhlaXIgb3duIGRhdGENCj4gPiBzdHJ1Y3R1cmUsIHdpdGggcHJvcGVyIHR5cGUgZmllbGRzLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1
bS5vcmc+DQo+IA0KPiBUbyBtZSB0aGlzIGxvb2tzIGxpa2UgYSBjbGVhciBpbXByb3ZlbWVudCBh
bmQgSSdtIGluY2xpbmVkIHRvIGFwcGx5IGl0LiBUb255LA0KPiB3aGF0IGRvIHlvdSB0aGluaz8N
Cg0KSSB0aGluayBpdCBpbmRlZWQgaXMgYmV0dGVyIHRvIHVzZSBzdHJ1Y3QgaW5zdGVhZCBvZiBh
cnJheXMgdG8gYWNjZXNzIHRoZSB0YWJsZS4NCkJ1dCB3aGF0IEkgYW0gdHJ5aW5nIHRvIGRvIGlz
IHRvIGZpZ3VyZSBhIHdheSB0byB3cml0ZSBhIHByb3BlciBzdHJ1Y3QgZm9yDQpyYWRpb19bYWJd
IHRhYmxlcy4gU2luY2UgdGhlIHBhcnNpbmcgbG9naWMgaXMgbW9yZSBjb21wbGljYXRlZCB0aGFu
IG90aGVycy4NCg0KT25jZSBJIGZpbmlzaGVkIHRoZW0sIEkgd2lsbCBzZW5kIGEgcGF0Y2ggdG8g
Y2hhbmdlIHRoZSB0YWJsZXMuDQoNCllhbi1Ic3Vhbg0K
