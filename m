Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA212BE0
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 12:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfECKxE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 06:53:04 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59113 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECKxE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 06:53:04 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43AquRr016252, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43AquRr016252
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 18:52:56 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Fri, 3 May
 2019 18:52:55 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
Thread-Topic: [PATCH 5/6] rtw88: mac: remove dangerous while (1)
Thread-Index: AQHVAZ3Pc+Obl4OrnkWOg3YkXAd45KZZOU1Q
Date:   Fri, 3 May 2019 10:52:55 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17E85EB@RTITMBSVM04.realtek.com.tw>
References: <1556879502-16211-1-git-send-email-yhchuang@realtek.com>
         <1556879502-16211-6-git-send-email-yhchuang@realtek.com>
         (sfid-20190503_123228_124010_1BC9DA36)
 <315fea6071bc29c20b3f71f8e725433c64ad195d.camel@sipsolutions.net>
In-Reply-To: <315fea6071bc29c20b3f71f8e725433c64ad195d.camel@sipsolutions.net>
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

PiANCj4gT24gRnJpLCAyMDE5LTA1LTAzIGF0IDE4OjMxICswODAwLCB5aGNodWFuZ0ByZWFsdGVr
LmNvbSB3cm90ZToNCj4gPg0KPiA+ICsJd2hpbGUgKChjbWQgPSBjbWRfc2VxW2lkeF0pKSB7DQo+
IC4uLg0KPiA+ICsJfTsNCj4gDQo+IFRoYXQgc2VtaWNvbG9uIGlzIHByZXR0eSBwb2ludGxlc3Mg
dGhlcmUgOi0pDQo+IA0KPiBqb2hhbm5lcw0KPiANCj4gDQoNCk1pc3NlZCBpdC4gV2lsbCBzZW5k
IHYyLg0KVGhhbmtzIQ0KDQpZYW4tSHN1YW4NCg0KDQo=
