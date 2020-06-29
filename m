Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97120E468
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 00:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgF2VZM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 17:25:12 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34467 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgF2SuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:08 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05T6958H0015445, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05T6958H0015445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 14:09:05 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 14:09:05 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 14:09:05 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Mon, 29 Jun 2020 14:09:05 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "joe@perches.com" <joe@perches.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH 2/2] rtlwifi: 8821ae: remove unused path B parameters from swing table
Thread-Topic: [PATCH 2/2] rtlwifi: 8821ae: remove unused path B parameters
 from swing table
Thread-Index: AQHWTcWkH20KDhxPNkWJ1dHHa2mXhKjuiIgAgAANQoA=
Date:   Mon, 29 Jun 2020 06:09:04 +0000
Message-ID: <1593410915.25527.3.camel@realtek.com>
References: <20200629032937.17374-1-pkshih@realtek.com>
         <20200629032937.17374-2-pkshih@realtek.com>
         <be95d3c3e40e3670ed368b0df4ba397a@perches.com>
In-Reply-To: <be95d3c3e40e3670ed368b0df4ba397a@perches.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <365ED840EA4CE749BE198A6F1ED7A49A@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIwLTA2LTI4IGF0IDIyOjIxIC0wNzAwLCBKb2UgUGVyY2hlcyB3cm90ZToNCj4g
T24gMjAyMC0wNi0yOCAyMDoyOSwgcGtzaGloQHJlYWx0ZWsuY29tIHdyb3RlOg0KPiA+IEZyb206
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+wqANCj4gPiA4ODIxQUUgaXMg
YSAxeDEgY2hpcCwgc28gc3dpbmcgcGFyYW1ldGVycyBmb3IgcGF0aCBCIGFyZW4ndCBuZWNlc3Nh
cnkuDQo+IA0KPiBUaGVuIGFsbCB0aGUgbm93IHVudXNlZCBhcnJheXMgY291bGQgYmUgcmVtb3Zl
ZCBhcyB3ZWxsLg0KPiANCg0KTXkgZ2NjIGRvZXNuJ3Qgd2FybiB0aGlzLiBDb3VsZCBJIGtub3cg
aG93IHlvdSBmaW5kIHRoZW0/DQoNCg0KSSBoYWQgc2VudCB2MiwgYnV0IEkgY2FuJ3Qgc2VlIGl0
IGluIHBhdGNod29yay4NCklmIGl0IHN0aWxsIG5vdCB0aGVyZSwgSSdsbCB0cnkgdG8gcmUtc2Vu
ZCB2MyBsYXRlci4NCg0KLS0tDQpUaGFuayB5b3UNClBLDQoNCg==
