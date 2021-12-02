Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC1A465A88
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 01:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354059AbhLBATh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 19:19:37 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38594 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354057AbhLBATg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 19:19:36 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B20G4RZ0031585, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.139])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B20G4RZ0031585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 2 Dec 2021 08:16:04 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36503.realtek.com.tw (172.21.6.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 08:16:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 1 Dec 2021 19:16:03 -0500
Received: from RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa]) by
 RTEXMBS04.realtek.com.tw ([fe80::e095:6756:b2cf:3baa%5]) with mapi id
 15.01.2308.015; Thu, 2 Dec 2021 08:16:03 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Jeff Clay <jeffclay@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Latency spikes in rtw89
Thread-Topic: Latency spikes in rtw89
Thread-Index: AQHX5h7gz1lunSxdRkC17cf5rz61Cqwc15RAgABbKgCAAC+oAIAA9LOQ
Date:   Thu, 2 Dec 2021 00:16:03 +0000
Message-ID: <9214bf22984642549219cd1810dca88f@realtek.com>
References: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
 <74887ec8f49846f5ae8b40b4c213d2da@realtek.com>
 <CACJOGMOBaQ+vc37dnpS8JYEnE4v4bufSkw+_Or5FEzkTiKXfBQ@mail.gmail.com>
 <5dc56416-7564-6a11-d477-9841b27a7123@lwfinger.net>
In-Reply-To: <5dc56416-7564-6a11-d477-9841b27a7123@lwfinger.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzEg5LiL5Y2IIDEwOjU1OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnJ5IEZpbmdlciA8bGFy
cnkuZmluZ2VyQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIExhcnJ5IEZpbmdlcg0KPiBTZW50OiBU
aHVyc2RheSwgRGVjZW1iZXIgMiwgMjAyMSAxOjM5IEFNDQo+IFRvOiBKZWZmIENsYXkgPGplZmZj
bGF5QGdtYWlsLmNvbT47IFBrc2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogbGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBMYXRlbmN5IHNwaWtlcyBp
biBydHc4OQ0KPiANCj4gT24gMTIvMS8yMSAwODo0OCwgSmVmZiBDbGF5IHdyb3RlOg0KPiA+IFRo
YW5rIHlvdSBmb3IgdGhlIGluZm9ybWF0aW9uLiBXb3VsZCB0aGUgaXNzdWUgcGVyc2lzdCBpZiBJ
IHdlcmUgdG8NCj4gPiBkaXNhYmxlIHdpcmVsZXNzIHBvd2VyIG1hbmFnZW1lbnQ/DQo+IA0KPiBU
aGF0IGlzIGFuIGVhc3kgZXhwZXJpbWVudCB0byB0cnkuIFVzZSB0aGUgImRpc2FibGVfcHNfbW9k
ZT15JyBtb2R1bGUgb3B0aW9uIGZvcg0KPiBydHc4OWNvcmUuDQo+IA0KDQpBbm90aGVyIHdheSBp
cyB0byB1c2UgJ2l3IHdsYW4wIHNldCBwb3dlcl9zYXZlIG9mZicuDQoNCi0tDQpQaW5nLUtlDQoN
Cg==
