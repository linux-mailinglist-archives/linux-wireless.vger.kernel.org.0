Return-Path: <linux-wireless+bounces-97-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ECF7F9D4D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 11:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1FAB20C91
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE5182A9;
	Mon, 27 Nov 2023 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QWeQ3sfM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2017.outbound.protection.outlook.com [40.92.98.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB286192
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 02:17:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiRJYbNB8LFJjw0Xzuk1e+Lv5gqkea7o0uBQltWwWVGWqZWGicFrWZCzvHGYBYpFYl4XrGW9OkCPUCaLgN+z2BSFe0XvqCEiQnK7Svlsmf9l3AlotpmBLGQjk2cCnLcu+yEXjDSaFKR4n492UN0WG8uh9CYtO2BWOVAeBYWTSU9PiycYQF6kgGfIPS9T4FTSXq7QZBrhA7qAxlL6WOkiQCrMa72Kp/+SQfudt82SlUz1mLKEOYb+Asv9WO0CmANOsIGC6ZKrWUZu+MsC1CVacogU4ZJLW1d89L/RAc0WOBG1LbYcDcmMju9Ylic+K1hGZSkXtAvs+XtvH23Fv6Jt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGm8F6TDvCwK9u91YEvs7syMHuenmjqE+qfaYqkd7JA=;
 b=Up/IYfGjccnF7xRUut7yzXS+GEuLfjWfi/qabaJxbA9415Gva4m8yvbccmtPZN5kIL5FGRnMtUCboz5ZYhs1QyUAX/Jwy1Xab/1fKgJcMy48CV4gYAffC9iFNXxZgTFsrDfX+j1fF2qnxmI/v3kkOPh7QTb+CZ2BnvkKyUQWXqYPztawScBBK1bz5+I7op255ENiSRrkl2YBjYcqG9dORyGA2AnYDE4acWxCj4z+WyCtyr9l+t03FISRwTFrkqYnIIEmpkFX6owBFoyCUqWm1I1a+UP9tPijEZS/eZL261nknBGqTNyTeGl+irCCsFiwqMv6wR1Oed6GLvvMvXPEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGm8F6TDvCwK9u91YEvs7syMHuenmjqE+qfaYqkd7JA=;
 b=QWeQ3sfM3PT8VDQBfv3AwX0moF54W6QkuY2nWjlZV9B9j73giwBuC2LMmsgg8YDzYXiLrGFIKxer7uTMzTC9Jd4WShg61EXZSrCwD79xx1bfdOmOUiCNvwkjoIm46efC6iN1g89Pl+wEl4fCde3ES7btzrB3e1gfyulsMUoamEIOluO3ZpBR4lpe5jxjJ71zckZHOVqzFFU7WeFyfG2NrG7hMSWWIHT0ndE4vPZm5fOXwFD3tVAhC5ZUGxl6YIAA+Zt2F0awlnaA3tFVwrnUqzLBFoVPH5QT3gfkJf66ELkd1GzKclfqMlwxFm1t7XC0NX1NabCJUL09JPG8qHlziQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYVP286MB3715.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:369::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 10:17:06 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b840:5197:9b15:ea2d]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b840:5197:9b15:ea2d%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 10:17:06 +0000
From: Yang Shiji <yangshiji66@outlook.com>
To: "stf_xl@wp.pl" <stf_xl@wp.pl>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIXSB3aWZpOiBydDJ4MDA6IG1ha2Ugd2F0Y2hkb2cgcGFy?=
 =?gb2312?Q?am_per_device?=
Thread-Topic: [PATCH] wifi: rt2x00: make watchdog param per device
Thread-Index: AQHaIKJPrOJPY4bqYUii0RFNs/3KyrCN9Bk+
Date: Mon, 27 Nov 2023 10:17:06 +0000
Message-ID:
 <TYAP286MB031570B7ECB23FF003B43211BCBDA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <20231126195358.500259-1-stf_xl@wp.pl>
In-Reply-To: <20231126195358.500259-1-stf_xl@wp.pl>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [nlcCr+/yxiqWL/jPiCn6vqNEaTV1X1a/]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAP286MB0315:EE_|TYVP286MB3715:EE_
x-ms-office365-filtering-correlation-id: 3e8e4d29-fcb4-4b91-d062-08dbef3201f2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yHWFyY2AWJlStqyrwMsWEY6deBBU9cIWZ0KHDPbbF2cFICeQcYP+14txAeBJAMTr62l8wynORUlX8nzvFyP4ymk8NW2+MsqD/gGGeFv13zojIIpjnCdm94gHIZdtsdmtPhdcNw23vmtGkaLmysf7It0Q7YjsriiQ2t4hr1G22/BmGk8G8oHukVsdPkX2XhB2djRZ+8vPrPjJJ4TmuL4jNeuo4mOavqOx9Ar6d1tn9J0M2fV3zZQraYYu771F4EdQ7gdFcGCPH1zrR/hsSW4LNTzkSfAe0KiKH7yDCBpXT23xltdKflsIe9bi/g8n3sIUX+G+X4jz8rjhE28tpKp+0aFaPS/lOCzVCp11JxzQc2h4JliQj05sZksbRIjqJpKB3y+sk5uTrAu8ALBvsvux8NhQab0iW+uz5H6po1QF2XYtoiYQwTtA7mPpNRNQgEeS3JPjbzltFKjk8HkuU/9vfxpOMu1nlpv9D5OA3EgqVjYElV4P+jc7AhZ3vPqDqQ+ucsvlRvcCGgYely2iTpEEPjRJPaShbaP0vX/xvbWDCENDO+RdvqLbC1Pq3giY1UU4
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SlBDT2kyQ0tOcjgzMXRJalA2aktUaHFYNmcydXNJdEdxTnREQmxtTFJzY1lV?=
 =?gb2312?B?aXNPOUYzM2YzSU12VkJFS2Y3VC9qSDAwTWNrall0c1pFeTlSTFhwUHB6cUs0?=
 =?gb2312?B?VkVMZ1Foc2NUN25nREJkblBRM296M0s0MGZDSUFOd3NpYWJUZEpBSmJRdk9p?=
 =?gb2312?B?WTEwZFZJeHRmSU9Wb2hDUmxhVklubGF0Y0ZaWXpvWkVFSDZCZlRFQ0hMTkVq?=
 =?gb2312?B?N3BtbnhWVmFkaGQyTWdUdklsZ3ZtMDFuaFdRelJyQmx1eGYraldhR0tCa3NP?=
 =?gb2312?B?VXFNVlFYRUsxbjJmYWZuVUMyZTQ2bEh5OHdLZWVhd00zQzc3WElBY2VCMCtt?=
 =?gb2312?B?ZlQzUDBFdjZSTW1Wb0N6RUNBN3ZrNnJYbWtxWUo3T2MvaFNGS2JRRk5KRHZZ?=
 =?gb2312?B?RHhBbEphQm1nMWp4a2dnWStFN2VyNXhZTlNHN3VkK0J3VWlyZnprZGc2VkhF?=
 =?gb2312?B?T0NxTVhvc1RsWkRwbVptSVRTUHE5RHhMTk4xazQwZEpRY2JOOFptRVFZZzd5?=
 =?gb2312?B?YUN0Zk44QUdHN0pKZXhVYzloYWU3azlWeUFSdG9BUXlZUTdKSzJCMWdaUndS?=
 =?gb2312?B?N0lINlc1Z1pqS1Nudkd6VlZwTTJ5Z2NqTjZHeG01d1Raak41Rk0vYzlKS05j?=
 =?gb2312?B?K2NJcVlRRHdid1l3ME03ZzZkVmxSbWQ4a2xHWXplbVVmN0QvTGozb1FvVUZq?=
 =?gb2312?B?bzZnR0pIOElHdU1PbVM3NGY3WEJFMzZ2R1B3MzlYYk5rc05BWGZTUmZId0NS?=
 =?gb2312?B?WC9rcDYwQ1Z0dytzOWFXTms5ZUV1N0tQNGh3YjI1cU4rZ2lmZW9SYzhuNlUx?=
 =?gb2312?B?ck5ha2x2UUJYQVlxTFlKWEY2Qzl3TktTK252VUdTZXl6NVM0K1h0QkxibGYy?=
 =?gb2312?B?K3JxS2tGK3F6NkhVU1Qxd0pXSjNuUm1QckpORUJPNm1UK0liYUtZSHVkTjlz?=
 =?gb2312?B?Tkcxc0VBd0FHK2pFUkI2K3VPSlVUenR4QW9hM2V0dTVCeUhoZUtzRnU2aVV6?=
 =?gb2312?B?ZVdDN2xxc0RSK3Y3eHlVSm81ekZPeDBNMjc0S1Bhc0poeExpVktaOE9YS3A5?=
 =?gb2312?B?TFBqVWk1QWhDS2RDRE1HaFFkalM3SEVRdlA0aDFoV0E5SEI0REZzREZMdklu?=
 =?gb2312?B?ZVlEdzU5VVNOck95VTF6T0xTazNpMVc4a0N2ZFhYd0xhaHVnMmg5RlBPZ0hD?=
 =?gb2312?B?RlVrYjVzZW5FNUJ2MVlkd25Ma21tblBXT1lOZkVtYXlUbEI4VW9pc1VPQy9M?=
 =?gb2312?B?WFFaWVpkd0QvY0FLSE9FUDZRMGpEUVpVc1RyeWxkYVloUFBPb3VmUWdhNm11?=
 =?gb2312?B?Y2VpV28zL0libnZIY09Ua0hwU212UG1YZ1BiR01xUktLeEFuTEhwcUhtVFF3?=
 =?gb2312?B?WUF6K0xRKzN0V3pLS1BVSkhDOEo3L0lMdFRFOFB2UWhIWkx4Nk1TMUFQdC8v?=
 =?gb2312?B?SUtIbkVTS0tUV0hRL3dIUnRLUnROWW5DVWpBeWszcmI4czIrNXQzcnpnTjIw?=
 =?gb2312?B?K25kNWhDb2tIYkJXUk0yVkVBTlZhSkN6bmhCTmJvTVhKZ3RPZ01zWEtYZHB0?=
 =?gb2312?B?S1NnS2grKzd4M0ovQXQ4SjljbUFROFBZcGR4NHd5bGhwTlJlVEx5Mnkzb1JP?=
 =?gb2312?B?c3Q1V29rWi9jTUpSdnpmQzlCN1dZdVE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8e4d29-fcb4-4b91-d062-08dbef3201f2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 10:17:06.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3715

T24gU3VuLCAyNiBOb3YgMjAyMyAyMDo1Mzo1OCArMDEwMCwgU3RhbmlzbGF3IEdydXN6a2Egd3Jv
dGU6Cgo+V2UgY2FuIHJ1biBQQ0kvTU1JTyBkZXZpY2VzIHRvZ2V0aGVyIHdpdGggVVNCIGRldmlj
ZXMgaW4gdGhlIHN5c3RlbS4KPk1ha2Ugd2F0Y2hkb2cgcGFyYW1ldGVyIHBlciBkZXZpY2UgdG8g
YXZvaWQgc2l0dWF0aW9uIHdoZW4gcGx1Z2luCj5VU0IgZGV2aWNlIGNoYW5nZSBtb2RwYXJhbV93
YXRjaGRvZyBmb3IgUENJL01NSU8gZGV2aWNlLgo+Cj5TaWduZWQtb2ZmLWJ5OiBTdGFuaXNsYXcg
R3J1c3prYSA8c3RmX3hsQHdwLnBsPgo+LS0tCj5TaGlqaSwgY291bGQgeW91IHBsZWFzZSB0ZXN0
IGl0IG9uIHlvdXIgc2V0dXAgYW5kIGdpdmUgVGVzdGVkLWJ5OiB0YWcgPwo+CgpIaSEKClRoYW5r
cyBmb3IgZml4aW5nIGl0LiBJJ3ZlIHRlc3RlZCBpdCBiYXNlZCBvbiBPcGVuV3J0IG1haW4gYnJh
bmNoCmFuZCBpdCB3b3JrZWQgd2VsbCBvbiBNVDc2MjAuIFRoZSB3YXRjaGRvZyBpcyBzdGlsbCB3
b3JraW5nLgoKVGVzdGVkLWJ5OiBTaGlqaSBZYW5nIDx5YW5nc2hpamk2NkBvdXRsb29rLmNvbT4K
ClJlZ2FyZHMK

