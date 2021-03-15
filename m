Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E922133C6CB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCOT0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 15:26:17 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com ([40.107.8.131]:53625
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233523AbhCOTZ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 15:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNAvaKMq/4WOePql00uKpsBwuXs0q4Psw4rxBgXV1Jo8dvwbQC1oPrtpxdg08bzEK7E+tPWZOyBd6GHhYFL8j9tUqG9H/RXoUTvYsZ6jNv1ki6ytypsYVRmhhdO1nWtUjnmnrxtTTNO//KMrKugyI3EhckF/Om/G7UchhEh8z2t54iPUG7SEf9YCF6VZatTPg3ULOZhh/naVJ+8f3uoecvVxV8nnj2i6NU+0e33Q+S7r0glmC7WWxvcxb2M4bjejYCjTcYzpum9Pcc96uBBegPrlvuOC63GDbMZixsw+95TQnA+RhGgHCz/w9ZeITQZrUGKYyS8WVi0WZaI4eInGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FFGh433boK38Q6Xafd4R+40KZn2OZ+dHc6a+SUY4/o=;
 b=fwwUECIfVUNxw8M7B25LZlZ95iRwYQbfWFVlqsYViS5HyHcavn/nFVDtiUtukJ73Z5TcykB3KfIzzEthJOYOecJXyA00IeQ/SxmIyWR/Y0eXRwU9G99HnbhwhSzuEr69sX39NxuB2pchzL/xeff1fWWI0CGcIKaG+x2fcbyMlef6H0xjGJG0VwHSNPpyyYPyzXC/i9HdE2q6PQsrQTlPbiB5qoAwRQzPeAVySOw4KOd1+RPVyMKTTEXcJEMLnYP8UD6VyNfrNu1R/Ve+rTpiBQTsB/5jJzEY+lub//lylXcIN8zDS3DeffEzCOJH8QfxXU6pjdqsW4jzxLlVkaRSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FFGh433boK38Q6Xafd4R+40KZn2OZ+dHc6a+SUY4/o=;
 b=LVfFPJIjDR1hCPdZtBAbJvVjKzkuUxHcsFSnQTJo6JW/kdGiaNKJspAbpmIiK++LCDFaBG9XeBwt4+4XNGj5ch3cA6M6NPaXFBtcO8CnVJWxCZtALCLb/LGuNezHtAFLms1aMzbkMTXC3oXAB4UqpSpE4rbbOT5OQR5jtF12JjE=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR03MB6222.eurprd03.prod.outlook.com (2603:10a6:800:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 19:25:56 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:25:56 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     James Prestwood <prestwoj@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: SAE offload on brcmfmac (BCM4345)
Thread-Topic: SAE offload on brcmfmac (BCM4345)
Thread-Index: AQHXESz7mO5UTjNzq0SaRS8mdQULsqqFZAcAgAAbqIA=
Date:   Mon, 15 Mar 2021 19:25:56 +0000
Message-ID: <3e5bd089-d61c-f20e-e914-c9748d7d312a@bang-olufsen.dk>
References: <1262e6e9c7d2ab499c15a3d297ed87206e49711b.camel@gmail.com>
 <0378ea17e0a8bdb72d635430ff14edc428591690.camel@gmail.com>
In-Reply-To: <0378ea17e0a8bdb72d635430ff14edc428591690.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bang-olufsen.dk;
x-originating-ip: [80.71.142.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8141da47-8ba2-4dbb-04c6-08d8e7e82816
x-ms-traffictypediagnostic: VI1PR03MB6222:
x-microsoft-antispam-prvs: <VI1PR03MB6222AE2388B4A931FB6B0D65836C9@VI1PR03MB6222.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUoBgSH5BW4qyrLZcweHJi4EH1YfNHxQM01FLnZHHFbkv4NX1BlcCTbfdMMOnrIPHPLins4mDFwpAjvegwZ7a3Hw4aq6wTP08vAg5Wl5py1Wy31y9Rvpo95BLK1rVUXyYq0nqTvtNd6MjmmNblWcqNEcEHLhHiFfzZFKMs6xI3zC8BZoQMqdpcNDOlXdSL2Vdu2ZdZHKpAtd1643+8umBbNqrsLhGHWJSkpng1dknijofzA0LxUGQbp0h63ZwtyalwSltSvuyJmeYS7X4DtVXNa07J+j5765ns1zv33ZwMXmxH5dBNFLyREyN/YWZMmfOPM+GBsSyVkU7u+l0XjWZrGy3HbzfkPbd0nvPiOQ1sc/21lofTRjezG2tBz5fJDid3C2/NqCFpkJcMk5Wh1zJiou/SXkqYkixtxekoarJYhnt1a5FX3rDOvVMy0HaQ4E5kKthnjxbIRv8GmeiNZDduNgEibyFbRiOeKvZdgJZJy5/43H2ZDld1WYYA2epWhhZh1EPD1hojfzUi14G7Qjj3zMweUT1CljOEfD4g0ia7OLD/+QFGCT1m5DAJRBm1TCij6TF65THjPzW9scQUiEketqydOkEx79RXMPEE6FCDGCsuRZZGGIeAV2qqmyvA1GahNakFbVdKWUSkA4pO7+vLECseneJyPumkNOGH5IrhuOheGEnjpkNVgFaRJxCcmRggnjJII/4RgVJYCtmEmpw+N7pDcvpPT7L6Sj+4zuHU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39850400004)(110136005)(85202003)(316002)(2616005)(31686004)(36756003)(26005)(85182001)(5660300002)(6506007)(6486002)(8936002)(6512007)(8976002)(53546011)(83380400001)(64756008)(186003)(66556008)(66946007)(966005)(2906002)(45080400002)(478600001)(86362001)(8676002)(66476007)(76116006)(31696002)(66446008)(71200400001)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L2xGTkxWODVNRmcvSVJ3L1FPQSt0S0V3MkRsVW1EdlE5WjNtUUVERFVkMngw?=
 =?utf-8?B?SlliWXRYaktySUU4bkJabDRmUW9yRWw5MHM1dDNISVdwaHh0UmoyVWRJUFlQ?=
 =?utf-8?B?SWkzWTFMV3NVRy9NVW9GME9TWitBczUxRVRXNVRJVGQ0VGJWdWM1WEk0cXht?=
 =?utf-8?B?cmo1WTJ6VVluTWZLL2FBSjg5OUM5SU9PQUZQT0dGQVp0cVFRY1hnNDc5NVpW?=
 =?utf-8?B?MzdFaXE3eXlnRHN0NU1uMHdoUVdzWmJmeXRJWmV6ckVrU3dFVW1XWmpsQjA3?=
 =?utf-8?B?cTZNUCtXNlptVHNRRU1FR3ZmZG1WaTZxTUIzeGt5UjkxQXRVTWlvaDJIMlZu?=
 =?utf-8?B?VVM3NzNPaWFEMDlyOHBzeG5QaVpGRXdpQkdtVHp6Rjlqc2k3M2NCTllZUE4w?=
 =?utf-8?B?WFBrY3dPczR5YjZlTTR0OFlKUC9ETEtiQkVqRXR1Q0VaYnlxUTJJbUE2Tisy?=
 =?utf-8?B?UWl1bWlkVUZKYzB6WkJEODZXeWxJTlBZQnRvNzd4bkVNaE5jaFdwVTI3dDZX?=
 =?utf-8?B?N0NUOFZjblplZnJuYlNtV0tqcHFEZUZHREhrTFVTWk9WcTFWUzdBdmRFRjNQ?=
 =?utf-8?B?ci9FMklzNEo0OEJOTWVMcWdyamh4UElFV20yRWJQRHBvU2pPVHdJNlNNcWZu?=
 =?utf-8?B?c0JRaW9FM212UkJlZXdEeFd5WEJyMTdLUE1jYTRsenlzblBKbit0UXVwbGVt?=
 =?utf-8?B?ZGttQnFNWVNJNmlQYXV2Um9rRGUrSnVjaEJ1ejBsNlZGMUJXZ1FvQ2Rtank1?=
 =?utf-8?B?elFFWGVQSEFzeUJWMjhqRUMwcFhVUGlCVDJwS3dvZHhVang5ZWw5RlE1MEdn?=
 =?utf-8?B?RkFad2xDQjFydmlKZlh4R0tjWCt6ZEd3WEtWd2xBVmEzZUNlZEViemN6bmxD?=
 =?utf-8?B?L1R6eFE1MHhvandzdU1hWFV0RmFzOTJJV0k1dHlWUEg0SldoWE9BdVk0L3Br?=
 =?utf-8?B?MzN4MGRWMWZyMldqQjlraTlFTXgzS3prWHNqQzdaTnhOQ2pDVHVTQnRvdjI0?=
 =?utf-8?B?aFh0cWcwVUV2dEh1TnFnZkdqR2ZXYkFtWXc4d3FzSGMvNHgwUGZsbTV4TzZZ?=
 =?utf-8?B?ZXVoWjdPeENQVGxKY1Z2alkzTnRYRTQvZFUraTh5eXR3K2lUaHFvSWZTZk9L?=
 =?utf-8?B?Q1lKeldUMHFOMHdac3pCdUZybDQ3QWVDWExWNE9LZ3ZxNVo3NEVKSlJOMFJv?=
 =?utf-8?B?aWExSHc4aHN4SzVUZkwwb2pRVHZiaFk1azNLTnh3ampkelBWd2VsM2FtY0hT?=
 =?utf-8?B?OGR4THBkWk9HQWJodzVZQTh3Q0R4dkxpSWhabExtVVUySWNta3l1d3ZqVVE4?=
 =?utf-8?B?VE1PY2MzS21zbnpqMTBmRUxEQUNuSmkreHUwQ0IycFFSRW5HSG8zT3ZnY1hR?=
 =?utf-8?B?aklnVHZ3YWY4bjZXcXNTUmdCZnRGbmpuazZyYlpKRFhxdjRwQlg5ZCt2SHlp?=
 =?utf-8?B?Zm1yaUJjRHpzY0p1WTcyU3NzMzRpWTlIVS9LcmNkaUwrR3BuS2phb3ZVR3Mv?=
 =?utf-8?B?K2FJVzdxZGdNczZpaW1PYkdRZWdWcWdseG9GSlAwSWZVc3ZtUThFSU53Mkl0?=
 =?utf-8?B?N3dvc0dKZWcrYlovOE5DeHhuUFJBVmZnbnM2MDVDcWxGRkxZcmtSL3c3TWtr?=
 =?utf-8?B?dHowelMrVThKY1RSTG9uaWNqYXpXRFNuTlpxUEVnSTZPcHA5aGRRUDhYRDUx?=
 =?utf-8?B?bm0ybkpEU3kvdk1kYWs5UWtlbzVKeXBHNkxPSTl5VmxOdVBNSUR5WlllMXBi?=
 =?utf-8?Q?iTLyPSe5nkAiqQRLF61xMKhyOGBdX4QmTkCfIWi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <59F1674E75910245BD7CF6961428E587@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8141da47-8ba2-4dbb-04c6-08d8e7e82816
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 19:25:56.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qr8CfB28zHEqKblw0d/uAiWZirwaGYfJKTx8Vuk72nKN1Cw8Ewd1Z2s01CTSFubjgO5M2B8a5l/RSx0ous9jRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6222
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSmFtZXMsDQoNCk9uIDMvMTUvMjEgNjo0NiBQTSwgSmFtZXMgUHJlc3R3b29kIHdyb3RlOg0K
PiBNYXliZSBhIHNpbXBsZXIgcXVlc3Rpb246IFdoYXQgYnJjbWZtYWMgY2FyZHMgKmRvKiBzdXBw
b3J0IFNBRSBvZmZsb2FkPw0KDQpGaXJzdCBvZiBhbGwsIFNBRSBvZmZsb2FkIHN1cHBvcnQgaXMg
dGVjaG5pY2FsbHkgYSBmdW5jdGlvbiBvZiBib3RoIA0KZmlybXdhcmUgQU5EIGNoaXAsIGJ1dCB0
aGUgY2hpcCBvbmx5IG1hdHRlcnMgaW4gdGhpcyBlcXVhdGlvbiBiZWNhdXNlIA0Kc29tZSBjaGlw
cyBkb24ndCBoYXZlIGVub3VnaCBtZW1vcnkgdG8gc3VwcG9ydCB0aGUgU0FFIG9mZmxvYWQgDQpm
dW5jdGlvbmFsaXR5IG9mIHRoZSBmaXJtd2FyZS4gSWYgYSBmaXJtd2FyZSBidWlsZCBzdHJpbmcg
KHN0cmluZ3MgDQpmd25hbWUuYmluIHwgZ3JlcCBWZXJzaW9uKSBjb250YWlucyBzYWUsIGlkc3Vw
LCBhbmQgaWRhdXRoLCB0aGVuIGl0IA0KcmVhbGx5IHNob3VsZCBhZHZlcnRpc2UgdGhhdCBjYXBh
YmlsaXR5IGJhY2sgdG8gdGhlIGRyaXZlci4gVGhlIHZlbmRvciANCndpbGwgbm90IGJ1aWxkIGEg
ZmlybXdhcmUgd2l0aCB0aGUgc2FlIGNhcGFiaWxpdHkgaWYgdGhlIHRhcmdldCBjaGlwc2V0IA0K
ZG9lc24ndCBoYXZlIGVub3VnaCBtZW1vcnkgdG8gc3VwcG9ydCBpdC4NCg0KPiBTbyBmYXIgSSBo
YXZlIHRyaWVkOg0KPiANCj4gQkNNNDM0NSAocmFzcGJlcnJ5IHBpIDMgQispDQoNClF1aWNrIG5v
dGU6IGFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0WzEsIHAuMThdLCB0aGUgUlBpIDNCKyBoYXMg
YSANCkNZVzQzNDU1IChub3RlIHRoZSBleHRyYSA1KS4gRWFzaWx5IGNvbmZ1c2VkIHdpdGggdGhl
IEJDTTQzNDUsIGJ1dCANCmFjdHVhbGx5IGEgY29tcGxldGVseSBkaWZmZXJlbnQgY2hpcC4NCg0K
UGxlYXNlIGRvdWJsZSBjaGVjayB0aGF0IHlvdSBhcmUgdXNpbmcgdGhlIGNvcnJlY3QgZmlybXdh
cmUsIGJlY2F1c2UgSSANCmNhbiBzZWUgdGhhdCB0aGUgdmVyc2lvbiBzdHJpbmcgeW91IHF1b3Rl
ZCBpbiB5b3VyIG9yaWdpbmFsIGVtYWlsOg0KDQo+PiBbICAgIDcuNjE2MTg2XSBicmNtZm1hYzog
YnJjbWZfY19wcmVpbml0X2RjbWRzOiBGaXJtd2FyZTogQkNNNDM0NS82IHdsMDogTWFyIDIzIDIw
MjAgMDI6MTk6NTQgdmVyc2lvbiA3LjQ1LjIwNiAocjcyNTAwMCBDWSkgRldJRCAwMS04OGVlNDRl
YQ0KDQpzZWVtcyBub3QgdG8gYWdyZWUgd2l0aCB0aGUgdmVyc2lvbiBzdHJpbmcgaW4gdGhlIGxh
dGVzdCBDeXByZXNzIEZNQUMgDQpyZWxlYXNlIHlvdSBsaW5rZWQgaW4gdGhlIHNhbWUgZW1haWw6
DQoNCi4uLi81LjQuMTgtMjAyMF8wOTI1L2Zpcm13YXJlICQgc3RyaW5ncyBjeWZtYWM0MzQ1NS1z
ZGlvLmJpbiB8IGdyZXAgVmVyc2lvbg0KNDM0NTVjMC1yb21sLzQzNDU1X3NkaW8tcG5vLWFvZS1w
a3RmaWx0ZXItcGt0Y3R4LXdmZHMtbWZwLWRmc3JhZGFyLXdvd2xwZi1pZHN1cC1pZGF1dGgtbm9j
bG1pbmMtY2xtX21pbi1vYnNzLW9ic3NkdW1wLXN3ZGl2LWd0a29lLXJvYW1wcm9mLXR4YmYtdmUt
c2FlLWRwcC1zci1va2MtYnBkIA0KVmVyc2lvbjogNy40NS4yMjEgKDNhNmQzYTAgQ1kpIENSQzog
OGY5Nzc3MDQgRGF0ZTogRnJpIDIwMjAtMDktMTggDQowMjozMDo0OCBQRFQgVWNvZGUgVmVyOiAx
MDQzLjIxNTYgRldJRCAwMS1iYmQ5MjgyYg0KDQpBbHNvIG1ha2Ugc3VyZSB0aGF0IHRoZSB0YXJn
ZXQgZmlybXdhcmUgaXMgYXBwcm9wcmlhdGVseSBuYW1lZDoNCg0KLSB0aGUgbWFpbmxpbmUgZHJp
dmVyIGV4cGVjdHMgdGhlIGZpcm13YXJlIHRvIGJlIGF0IA0KL2xpYi9maXJtd2FyZS9icmNtL2Jy
Y21mbWFjNDM0NTUtc2Rpby5iaW4NCi0gdGhlIEN5cHJlc3MgYmFja3BvcnRzIGRyaXZlciBleHBl
Y3RzIHRoZSBmaXJtd2FyZSB0byBiZSBhdCANCi9saWIvZmlybXdhcmUvY3lwcmVzcy9jeWZtYWM0
MzQ1NS1zZGlvLmJpbg0KDQpJZiB5b3UgdXNlIHRoZSBsYXRlc3QgZmlybXdhcmUgcmVsZWFzZSB0
aGVuIGl0IHNob3VsZCBhZHZlcnRpc2UgU0FFIA0Kc3VwcG9ydC4gQnV0IEkgZG9uJ3QgaGF2ZSB0
aGUgYXBwcm9wcmlhdGUgaGFyZHdhcmUgdG8gY2hlY2sgZm9yIG15c2VsZiwgDQpzbyB0aGUgZW1w
aGFzaXMgaXMgb24gJ3Nob3VsZCcuDQoNClsxXSANCmh0dHBzOi8vd3d3LnJhc3BiZXJyeXBpLm9y
Zy9kb2N1bWVudGF0aW9uL2hhcmR3YXJlL2NvbXB1dGVtb2R1bGUvZGF0YXNoZWV0cy9ycGlfREFU
QV9DTTNwbHVzXzFwMC5wZGYNCg0KPiBCQ000MzYwMg0KPiBCQ000MzI0Mg0KPiANCj4gVGhlIGxh
c3QgdHdvIGFyZSBxdWl0ZSBvbGQgKGZ3IGRhdGVkIDIwMTMvMjAxNSkgc28gSSB3b3VsZG4ndCBl
eHBlY3QNCj4gdGhvc2UgdG8gd29yay4gQWNjb3JkaW5nIHRvIHRoZSBkb2N1bWVudGF0aW9uIHRo
ZSBCQ000MzQ1IHNob3VsZA0KPiBzdXBwb3J0IFNBRSBvZmZsb2FkLCBidXQgbWUgYW5kIHNldmVy
YWwgb3RoZXJzIGhhdmUgdHJpZWQgY2hlY2tpbmcgdGhlDQo+IGV4dGVuZGVkIGZlYXR1cmVzIGFu
ZCBpdCBpcyBub3QgZW5hYmxlZC4NCg0KUmlnaHQsIHRob3NlIGNoaXBzIGFyZSBmYXIgdG9vIG9s
ZCB0byBzdXBwb3J0IFNBRSBvZmZsb2FkIGR1ZSB0byBtZW1vcnkgDQpsaW1pdGF0aW9ucy4NCg0K
T3RoZXIgQ3lwcmVzcyBjaGlwc2V0cyB3aGljaCBzaG91bGQgc3VwcG9ydCBTQUUgb2ZmbG9hZDoN
Cg0KQ1lXNDM0NTUgKG1lbnRpb25lZCBhYm92ZSkNCkNZVzQzNzMNCkNZVzQzMDEyDQpDWVc1NDU5
MQ0KQ1lXNDM0M1cNCkNZVzQzNTQgKHBhcmVudCBvZiBDWVc0MzQ1NSkNCkNZVzQzNTYNCg0KRmly
bXdhcmVzIGZyb20gdGhlIGFmb3JlbWVudGlvbmVkIEN5cHJlc3MgRk1BQyByZWxlYXNlIHdoaWNo
IHNob3VsZCANCnN1cHBvcnQgU0FFIG9mZmxvYWQ6DQoNCmN5Zm1hYzQzMDEyLXNkaW8uYmluDQpj
eWZtYWM0MzQzMC1zZGlvLmJpbg0KY3lmbWFjNDM0NTUtc2Rpby5iaW4NCmN5Zm1hYzQzNzMtc2Rp
by5iaW4NCmN5Zm1hYzQzNzMtdXNiLmJpbg0KY3lmbWFjNTQ1OTEtcGNpZS5iaW4NCg0KS2luZCBy
ZWdhcmRzLA0KQWx2aW4=
