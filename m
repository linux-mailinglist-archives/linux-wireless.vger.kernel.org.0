Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED23934C0A5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Mar 2021 02:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhC2Al3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Mar 2021 20:41:29 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com ([40.107.21.137]:60961
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231805AbhC2AlT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Mar 2021 20:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH646dB6OVasYwFbc28Xy/uiLRHHwy2hm18epfmD/746oLCaEN8MqIz4Q5tplNUAeaSGrYjbndBSMSIqxBqBtSicjY8QkBLFnwBfiggVUa7mYngLizlvirmXIKhKJr1fBM0Fsu51CPN5ixV0P2SjyWkUzdCJHyJYsJQomo8WfAJqIUp36XUGSO95iJ4SRumZ2K/k6p0N0ZL9ZecFpuiCT0pkf1C/SS5bHGsJpBghNVSIV9wCvduUOP42whKZjMR1bxgTiNuowzzYzPqwXw8QbjBJuQlqIUR9gGD4To5ZziuDcCZSyBoXvg5W1DVgYGVMEpvleotWpBtP28HLBcyM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7yAtJOuSg7Mie5RQchjWbdMTnrroOqwpJNTMfdNvbI=;
 b=lklZoKmrNdMNwpGSnk8T5Se7gJocwfI5vLkk4eUU8F/Pu3ph5FgTqe/BaNuiRkAxeHUlCfQ9kSeiC5689qA1dLfTgu6Y/s69bD4e+jcctinHG6UsPuJf8T64oxE3hsAuUlOGrm80FQjZ4Y/mNHvoqiynNd7GTsPc3ruAa/g9AYPW4vcKi6I6o7NEa0iMiu+0fAcH0RlLUS2IgMPnzNwRl19Dz4kZFXj58/GIlTlJpJEy+rWOMjIuQ2JjO1BFKd6D+Ob1kcpxleAguNIFSuka5Y3mZar34d1ucz+NLfAaqBHqd/cx4QrpQPfQw4hqhV7oaiV7AAb8+gwMTwotX7JpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7yAtJOuSg7Mie5RQchjWbdMTnrroOqwpJNTMfdNvbI=;
 b=Mz/9OvhA6gxGmgJ9LKtppHVTLFhb6KFP6tiRWWtz4lR2O0DC0damyXlgoIbQzuy5qldjbldzaxz1kf+wFOphcee6/kJ6l0CkrvRuR/r0KQLvQYDSjAiSeyW+ooGyvhRuWSQgvP02RMJndsTsMbThOG3ptdsnh3dy3WTKDGc04MM=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR03MB6173.eurprd03.prod.outlook.com (2603:10a6:800:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 00:41:17 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 00:41:16 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: cfg80211: adding API for triggering a survey
Thread-Topic: cfg80211: adding API for triggering a survey
Thread-Index: AQHXJDQ6mZvLyuwx3k2SWR1yJ5BMGw==
Date:   Mon, 29 Mar 2021 00:41:16 +0000
Message-ID: <96652669-0cad-8cdb-fbe1-4df0f7161102@bang-olufsen.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=bang-olufsen.dk;
x-originating-ip: [80.71.142.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aba7544-c220-495e-5897-08d8f24b5cd9
x-ms-traffictypediagnostic: VI1PR03MB6173:
x-microsoft-antispam-prvs: <VI1PR03MB61736362E2BC8393D0D472C5837E9@VI1PR03MB6173.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkIsRv9BBCumrgcKPjBr7EzWSP1NUEBKlut5BvGCQy6K+W7Xjsz/36ozkfnKxGHIYd6+lQaLYCWMbIP/mXy4GkSnLP55DMIkak0SBo1arUI35TDaDn1ZcdzhtGhqd3wLf75xi7dKZSQPBYOQfdHeOYBbpvKdqd3z9RQTWIynGVXJQULpW309RSo4TzHW9JDsrkajcAr+NEoYAq3OFSJpr7EirmzYzz3CmIjJE5fJbBSdmFXY92kFzCoG4/O5W1ULkFymRPjvOLmyziHnFYYrjhL2cG+7fkpJzs2knTvd2tnfQg62MemtslHibdO/QeRTZPMac+Qvlf8iTp/ckL5T75OG6NCUWuicPz4JpH32O1/PKxzYYxCi7Hb+I1nnI17PplLudkLy+bl3g16iNHA1bgqgs6rhGNbxEeuRf8bgdF6XPrPbV3xGX6I7JuTiGOxPCbsMe7PJy+X8ZH3s0XZ3SX4R12mBcmLQgle83lp4cV0IGK3v+7R/s5Jm7u47zeYwhJcGBpX0ssc6yL5PR3J05TqQAtQUsFL7LcaFIk9xnwyE0949BkdtVJRv+3eGFoYNDpCqvWZfudljft1fGjtAGzAyBz52hv3MU7Bj168pegepp/a38EajUK8AjsKbrV0aPFm1hg8pp9vql27HRwuI+kbG/tsGdaS7S4FXsg3q+8Uk+ea1uboi/gxQO7Ocpl+MWZHDTatzj7aheEmC05q6Nk9TKzeDlYN7kvflSdBCxyo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39830400003)(366004)(38100700001)(8976002)(6506007)(31686004)(2616005)(8676002)(86362001)(186003)(66476007)(6512007)(76116006)(71200400001)(31696002)(316002)(83380400001)(66946007)(478600001)(36756003)(110136005)(6486002)(5660300002)(85182001)(2906002)(8936002)(26005)(66446008)(91956017)(85202003)(66556008)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MTVaTEx4UTRiQ3FqSkozMTdlOHFqTlpiTzI5SVQ1UTByN0hMeTRXMkdGYlcv?=
 =?utf-8?B?ZVZzaHlFdlRWOHRsQUZZbVpJL2NnVTh5ditlWjd1WmgxU29RdnNDeU15UU5H?=
 =?utf-8?B?TDcyTVRSZjZCVVIyOW8vQkVXd0gySnVBQ3ErbzdycUN4YkMvYWM5SmZJSWhy?=
 =?utf-8?B?VWRlRE1SS2Q4aFUwRkhPbXp3cC8xSVZ4cU1tSkVwa1hQMlNzQVduTi9IUndy?=
 =?utf-8?B?dmpSTlY5c3dYc0g3ZkpkMExwYmpSZkxtZkcrK29GVGx1ZHVrcHRHTEduZ1Jl?=
 =?utf-8?B?emQyWThDRkZhait6QjZjeWN5ejZSYXRoczhyZnorcXExZExnZ3FibjFldEZx?=
 =?utf-8?B?dFJsRFpOK040ZG55Q1NHWWZFSnhwc0Y0Y3IzMTdiQWMxT1Y2clVwNFVBR2JY?=
 =?utf-8?B?aHhMejRUaFVWVy8xYlRqSlUzZjd2bFZvWjN3WkZQSDNPMzYyWHBtRnFMaWJV?=
 =?utf-8?B?QTZzbm9VZHpKSkttcUsvNDRjeVVWZWk5WlNpSm9EamthREY3eTRTRlVPMXAz?=
 =?utf-8?B?Y2pjTmRXYkV6QlRkcDFwek5JZHVXOXZwZTVWZlVWeGRpUHhvZFM0YkNEUHlI?=
 =?utf-8?B?UEVURllERk40eTR0dHE0ZTByYXZXakF4TG5EaW5PT1NhcWRoSVV2aFgyK08r?=
 =?utf-8?B?aTdoaWE3Q05lRldGZDBjNHBnajYrblBrTUFHL0JnSXRoc0Vld1VPdS9oMjBQ?=
 =?utf-8?B?UGJQN1hlNElzS25XMm9mRlZZTTVZdi8wcGFZWER5bnZvaFRveWR6b054M2RJ?=
 =?utf-8?B?MFVremdtV05FR1pVUlhyOG92TFNSMnBKamxvN2VMa1RSWkVQVk0vVFdLQTRR?=
 =?utf-8?B?THJMaVpPOTF3MDlBa0tYd0YrdVdXR1Jyb1J5cGlFZnRJMXFtMUhBM3lLR0Yw?=
 =?utf-8?B?c1p1MVVTanVvNXY0d1U4ZWtRSDM0SHRReHZ0Mlh6aCtrcFVyMXZMa1cvMndW?=
 =?utf-8?B?ek84eFIxbERKeUZ5NmpidmdDanp0VkNFQnFiQ3JoUXYxSDlXd2dNZjVhc1d5?=
 =?utf-8?B?WC90N2JjWERON1Z5TmYwQ0kxdG1kNGt1dXNqK3lWaWM4RkN2N3VmakVnRmFJ?=
 =?utf-8?B?cUVvNURIeHlhUTFUR2xJd1BWREY2UnJCTG93OHR6MUhtbHRVQmthVVVXa1hp?=
 =?utf-8?B?STBmYVR6eGhKRk1Rd3BrVlZYUEZJTXVNNGhvM1oyeTBKcU9tSkNIVEcrdUN4?=
 =?utf-8?B?UmFKQTNteUV0b3JNZVlLQXJiQlJrSzNxZkNxZzllUXlhM1p6YXROUUp4YndY?=
 =?utf-8?B?T2JKL2lqQmVtQUxIQy9meXN2OFY3QmVFTVJFd0lhUm1JaldhRG5NUUUrMllt?=
 =?utf-8?B?N2I1VU1sNTNQbkc1K2tOckt2TmVGWFFIMjdiSUFSY3lVeVY2eFRDZmNPN09H?=
 =?utf-8?B?VzJNako0NnhtT2wwSWx2RTB0S3dORUw0VnlJUjE2MTg5NmpILysxZ0lGcm45?=
 =?utf-8?B?cnltcU83dTlueEd6OHFzOXpuSWM2dkNLNGx4VDJ6Vk1KUVRKNHdwZWxHM0Zr?=
 =?utf-8?B?TFlMYWw5ajRnUDVkblR1VDZRSFJzVkF0eWwwTjlkbW5KcW9hSWVidCtvWHNH?=
 =?utf-8?B?Tko5QUhEWTRVa29hWm92T3JWQmszK01ENkNYangzZU52SXRZNjVENWplNEQ3?=
 =?utf-8?B?VG4wVlE5ajJXYkJkZE1MZHpxQktXZlRjZFoxczAzYW5LZ3pOeXg3Z254T0lM?=
 =?utf-8?B?VjE3UnZQYmdUcUJrVEdoNWYzclhjcUJhTWJSdkNFbVRYUE5GbkpFMEVvY3I1?=
 =?utf-8?Q?U6L51GDxhehcJl+lIPXRzvnuakU/rKbzFi4adVp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFEBD295F5D86D4E8BD33A456CCF14AA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aba7544-c220-495e-5897-08d8f24b5cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 00:41:16.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1rw8JDwKAIrDYBVE9jNnoB8Ev76ZCcc7iPBm8xXH5KorbhdJL+sWHxT2U4atjW2y5dflH8pjV21VIM80K6Ajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6173
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGVsbG8sDQoNCkN1cnJlbnRseSB0aGVyZSBpcyBubyBleHBsaWNpdCBjZmc4MDIxMS9ubDgwMjEx
IEFQSSBmb3IgdHJpZ2dlcmluZyBhIA0KY2hhbm5lbCBzdXJ2ZXkuIEl0IHNlZW1zIHRoYXQgYWxs
IG1haW5saW5lIGRyaXZlcnMgd2hpY2ggaW1wbGVtZW50IHRoZSANCmR1bXBfc3VydmV5IHJkZXYg
b3AgbWFuYWdlIHRvIGdhdGhlciBzdXJ2ZXkgaW5mb3JtYXRpb24gZHVyaW5nIGEgbm9ybWFsIA0K
c2Nhbi4gV2hpbGUgaXQgc2VlbXMgdG8gd29yayBwZXJmZWN0bHkgZmluZSBpbiB0aGVzZSBjYXNl
cywgdGhpcyANCmFzc3VtcHRpb24gY2Fubm90IGJlIG1hZGUgZm9yIGFsbCBkZXZpY2VzLg0KDQpG
b3Igc29tZSBjb250ZXh0OiBJIGFtIGxvb2tpbmcgaW50byBhZGRpbmcgc3VydmV5IHN1cHBvcnQg
Zm9yIHRoZSANCmJyY21mbWFjIGRyaXZlciwgYW5kIHRoZSBmaXJtd2FyZSBpbnRlcmZhY2UgaGFz
IGEgc2VwYXJhdGUsIGV4cGxpY2l0IEFQSSANCmZvciB0cmlnZ2VyaW5nIGEgc3VydmV5IGFuZCBy
ZWFkaW5nIGJhY2sgdGhlIHJlc3VsdHMuIFRoZXJlIGFwcGVhcnMgdG8gDQpiZSBubyB3YXkgdG8g
Z2F0aGVyIHN1cnZleSBkYXRhIHRocm91Z2ggYW4gb3JkaW5hcnkgc2Nhbi4NCg0KQWRkaW5nIGEg
ZHVtcF9zdXJ2ZXkgb3AgdG8gYnJjbWZtYWMgaXMgbm90IGltcG9zc2libGUgd2l0aGluIHRoZSBi
b3VuZHMgDQpvZiB0aGUgY3VycmVudCBjZmc4MDIxMSBBUEksIGJ1dCBpdCBkb2VzIHByZXNlbnQg
c29tZSBpc3N1ZXMuIEZvciANCmV4YW1wbGUsIHNvbWUgdmFyaWFudHMgb2YgdGhlIG91dC1vZi10
cmVlIGJjbWRoZCBkcml2ZXIgc2ltcGx5IHRyaWdnZXIgDQp0aGUgc3VydmV5IGluIHRoZSBkdW1w
X3N1cnZleSBmdW5jdGlvbi4gQnV0IGRvaW5nIGl0IGxpa2UgdGhpcyBtZWFucyANCnRoYXQgYSB0
eXBpY2FsIHN1cnZleSB3aWxsIGhvbGQgdGhlIFJUTkwgbXV0ZXggZm9yIGFib3V0IDUgc2Vjb25k
cyAtIHlpa2VzIQ0KDQpTbyBteSBxdWVzdGlvbiBpczogY291bGQgdGhlIEFQSSBiZSBleHRlbmRl
ZCB0byBzdXBwb3J0IGV4cGxpY2l0bHkgDQp0cmlnZ2VyaW5nIGEgc3VydmV5PyBBbmQgaWYgc28s
IGhvdyBzaG91bGQgaXQgbG9vaz8NCg0KVGhlIG9yaWdpbmFsIGNvbW1pdCAoNjFmYTcxM2M3NTE2
ICJjZmc4MDIxMTogcmV0dXJuIGNoYW5uZWwgbm9pc2UgdmlhIA0Kc3VydmV5IEFQSSIpIGludHJv
ZHVjaW5nIHRoZSBkdW1wX3N1cnZleSBBUEkgbm90ZXM6DQoNCiA+IEluIGZ1dHVyZSwgdGhlcmUg
d2lsbCBlaXRoZXIgYmUgYSBzdXJ2ZXktdHJpZ2dlciBjb21tYW5kIC0tLSBvciB0aGUgDQpleGlz
dGluZw0KID4gc2Nhbi10cmlnZ2VyIGNvbW1hbmQgd2lsbCBiZSBlbmhhbmNlZC4gVGhpcyB3aWxs
IGFsbG93IHVzZXItc3BhY2UgdG8NCiA+IHJlcXVlc3Qgc3VydmV5IGZvciBhcmJpdHJhcnkgY2hh
bm5lbHMuDQoNClRoZSBlYXNpZXN0IHNvbHV0aW9uIHdvdWxkIGJlIGp1c3QgdG8gYWRkIGFuIGF0
dHJpYnV0ZSB0byANCkNNRF9UUklHR0VSX1NDQU4gLSBzYXkgTkw4MDIxMV9BVFRSX1NDQU5fU1VS
VkVZIC0gdG8gaW5kaWNhdGUgdG8gdGhlIA0KZHJpdmVyIHRoYXQgaXQgc2hvdWxkIGNvbGxlY3Qg
c3VydmV5IGluZm9ybWF0aW9uIGlmIHBvc3NpYmxlLiBFeGlzdGluZyANCmRyaXZlcnMgd291bGQg
YmUgdW5hZmZlY3RlZCAoc2luY2UgdGhleSBhbHJlYWR5IGRvIHRoaXMgaW1wbGljaXRseSkgDQp3
aGlsZSBhIGRyaXZlciBsaWtlIGJyY21mbWFjIGNvdWxkIHRlbGwgdGhlIGZpcm13YXJlIHRvIGRv
IGFuIGV4cGxpY2l0IA0Kc3VydmV5IGluc3RlYWQuIFRoZSBvbmx5IGlzc3VlIEkgc2VlIHdpdGgg
dGhpcyBpcyB0aGF0IHRoZXJlIHdvdWxkIGJlIG5vIA0KbmV3IHNjYW4gcmVzdWx0cyB0byBzZW5k
IGJhY2suIEkgd29uZGVyIGlmIHRoYXQgbWF0dGVycz8NCg0KT3RoZXJ3aXNlIGEgbmV3IENNRF9U
UklHR0VSX1NVUlZFWSBjb3VsZCBiZSBhZGRlZCwgYW5kIHRoZSBkcml2ZXIgY291bGQgDQplbWl0
IENNRF9ORVdfU1VSVkVZX1JFU1VMVFMgd2hlbiB0aGUgc3VydmV5IGlzIGNvbXBsZXRlLiBJIGd1
ZXNzIHRoZSANCmltcGxlbWVudGF0aW9uIGhlcmUgd291bGQgbG9vayBhIGxvdCBsaWtlIHdoYXQg
d2UgYWxyZWFkeSBoYXZlIGZvciANCnNjYW5uaW5nLiBJJ20gbm90IHN1cmUgaG93IGZhciB0byB0
YWtlIHRoaXMgdGhvdWdoIC0gc2hvdWxkIGNmZzgwMjExIA0KYWxzbyBjYWNoZSB0aGUgc3VydmV5
IHJlc3VsdHMgbGlrZSBpdCBkb2VzIGZvciBzY2Fucz8gSW4gdGhhdCBjYXNlIGl0IA0KbWlnaHQg
YWxzbyByZXF1aXJlIGNoYW5nZXMgdG8gZXhpc3RpbmcgZHJpdmVycyB3aGljaCBjdXJyZW50bHkg
cG9wdWxhdGUgDQp0aGUgc3VydmV5IGR1bXAgb24gZGVtYW5kLg0KDQpJJ20gcXVpdGUgaGFwcHkg
dG8gc2VuZCBzb21lIHBhdGNoZXMgZm9yIHRoaXMgYW5kIEkganVzdCB3YW50ZWQgdG8gZ2V0IA0K
c29tZSBmZWVkYmFjayBmaXJzdC4gSSdtIGxlc3MgY29uZmlkZW50IGFib3V0IGltcGxlbWVudGlu
ZyB0aGUgbGF0dGVyIA0KYXBwcm9hY2gsIHBhcnRpY3VsYXJseSBpZiBpdCBpbnZvbHZlcyBzZW5k
aW5nIHBhdGNoZXMgZm9yIGRyaXZlcnMgSSANCmNhbm5vdCB0ZXN0IChhbmQgZm9yIGEgcmF0aGVy
IG5pY2hlIGZlYXR1cmUgYXQgdGhhdCkuIEJ1dCBpZiBJIGNhbiBnZXQgDQpzb21lIG1vcmUgY2xh
cml0eSBvbiB3aGF0IHN1Y2ggYW4gaW50ZXJmYWNlIHNob3VsZCBsb29rIGxpa2UsIEknbGwgc2Vl
IA0Kd2hhdCBJIGNhbiBkby4NCg0KVGhhbmtzIGluIGFkdmFuY2UuDQoNCkFsdmlu
