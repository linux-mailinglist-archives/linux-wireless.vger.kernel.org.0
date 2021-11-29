Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB0746110C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 10:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbhK2J3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 04:29:45 -0500
Received: from mail-eopbgr140104.outbound.protection.outlook.com ([40.107.14.104]:8840
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244075AbhK2J1n (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 04:27:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXjea/fQwtYvP7ftI6R/+UM1WvAX8kRONQLPMzuIbjoGZPrk57hiIw8K61bpwIAOs006htomhMlvEmul0UD0GCWMr0k/q+891uDAuK/boXOMP+6f+pEKWnYwqiKI7Elya0aavCA/UpFT0zx/TxuBRFzRcbgafkgpZzBMkcrs+qPkVmXYQrWEx5sIyHIJF7tH1KEe2m+O4NVLqldfTpt5ZLVhTq16SMDDjLg+nKzEmzVlTnvkKyAfCrSqfK76sI0kaW++9CLKEYaNx0A4bXGvcNixMjLD/nKDUuphBCOyYm40qmdmj+FdhFasR4mRBzApU8pCYxO7s27R53+RoSCNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5uK/hEerriAHsjklkGJ0C+KsSrtymZjwxwwfJuC7xI=;
 b=MSiDEDergc8MO4CwFBoP/7CdwTBQa9p9vFzMWIx1dTNzJqY7HAMGDSnfcEVZwAoPT6/rEk17iZAjkcK4Vm2CPSwzoiVUvmABi+OnpdJ8LNDkhjbHS/viUyaY5UIcfNdUAyR93I3JOJD0j6kotlbWtjWQalCRvGqdm+bmMnU6ZijJMnpDr+j6tOB7AS29T26YDji9RslZEkSFbwVASJZY4usUGZK8/W18kfxmu4RN1TdX/5Cg9pn/MVyULdFunBaAJ3DJpEi0vhiipbyIKLVGtB5Zfb4UACccBnv494/qwLjuKNXjtDLx6II8f7b7nPNXySpPt7NgXpt+MDOPvwp+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5uK/hEerriAHsjklkGJ0C+KsSrtymZjwxwwfJuC7xI=;
 b=3iodmWA13wWbEy+dwSQJ9iIGNq/241eDhLjr4SfZGO7KoVGMqW9FRoHbu70HcES47VY6bFbYWM6Ji50dfgox7tifH2KA2CZ2YArdj2qc1T4Qg4kLCgYrNqqGtU57iNrUXP7YDJikGp2hrAvtrXhlewd3sQzDwFLE6nsnZC3/81w=
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21d::7) by DB7PR01MB4570.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 09:24:23 +0000
Received: from DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::1965:1b35:7a28:e26d]) by DB9PR01MB7354.eurprd01.prod.exchangelabs.com
 ([fe80::1965:1b35:7a28:e26d%3]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 09:24:23 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC v4] mac80211: fix rx blockack session race condition
Thread-Topic: [RFC v4] mac80211: fix rx blockack session race condition
Thread-Index: AdfL5NB40bniWIPCQwqcYHgT9opvcAW2P3qAAI+EiyA=
Date:   Mon, 29 Nov 2021 09:24:23 +0000
Message-ID: <DB9PR01MB73544CD20B07C4E784CBCBE0E4669@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
References: <DB9PR01MB73541FED9E91AC3005D27DAEE4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
 <a5ac66c2bee2f5de7cda68ad13d7008a05975c0b.camel@sipsolutions.net>
In-Reply-To: <a5ac66c2bee2f5de7cda68ad13d7008a05975c0b.camel@sipsolutions.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=acksys.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 052c6fff-cc64-4748-8176-08d9b31a084c
x-ms-traffictypediagnostic: DB7PR01MB4570:
x-microsoft-antispam-prvs: <DB7PR01MB4570DDF61677A93A8B436DDCE4669@DB7PR01MB4570.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BgE5yxF90GJrzKp4sHP8w0EZmvqb7NLluPhBH00bV9QRlz7skU/eixcCrq2dMx8V1num6aaEt35+hMYL3h8r6ZYoknCooyULudAIR8e3rLkcoe+RIlSQuw6ksCPr4lKvdlWmQA7zL3L9UF/ITH1qipbisaIxqME4Fj4X6rCvwlxA77DF4UXaHtcd+g4mt7QHgLmGHSKx9re52O/v189qscdTRBhDOFwE2cF4oUHkAZVi6WkNv2k4eQKQnw5xe0apnnfjH7SfIoKCh5+BS1gcwE2b23DVbsCDchf2ck3gPn6WSLxcr6PPjIvQICjyh24cJNXWIlymQVV2d9ryd88MtU2vt/lZOQ2LhWAktZHjKqnHKDnquEBZyGf2ezsXzf4dSfJSOvUihxQJgJ1IhjMyWcdX7nRhPrFBLIn3UgRONUNjHv62LS140Mi1mtT4M7LTWnjJH3h8idpBk9Ob3eJyseTruB6UNlYPxDonpBdZTxdZhoEi9ken888NdCxskdGiX2+8/W7yrkTMemTzTr6ciy5QxKDPgImsoMXuIY+eZ0UBEc5D/8g/tlJlwPyUKxK3uImS2HDuUCC6ELA7WRLSxwvyhbaMO6G0Ei6fottprSbTjvrsphpUlzMZ3587x0jUFTX6w5wXkotNb3pEy7BbDPZ3VPM8C4/zTiSI4UbiKsVOQToD4s6u/RWkZ32fzcEjOnV58lkZeuSElwXLjU6E0Qr6o3OlrH6DJJcThABzVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR01MB7354.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39830400003)(346002)(366004)(376002)(33656002)(38070700005)(55016003)(38100700002)(86362001)(9686003)(8676002)(122000001)(26005)(8936002)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(7696005)(6506007)(2906002)(186003)(316002)(5660300002)(52536014)(508600001)(71200400001)(83380400001)(110136005)(4001150100001)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0xZQkpJVlNNY1FJWERKWHh2dDNodERYQmJXNGc5eG8zaXJkSXo0emlvOE5h?=
 =?utf-8?B?Z0w4UExPRDNpTWU4MWVTUnZDQ0FaSEZIME9ZcjFJMnRReU82enh5Y2c1bS84?=
 =?utf-8?B?U2VyRWZ3aU9KV0V1cW4rN3NUU1lGZWs3LzBvTUl0MEhXR0tiUXZ0ZFhyWUs5?=
 =?utf-8?B?M3hzVVF1VkJNNWdJUmV0RVZDTC9ra3ZhVExNQ0wvN2xsSmhWWFdUSEFMY2FH?=
 =?utf-8?B?R0U2MkxuV1ZpNG1XdnRTRm9veDE2N3JySEY4WWdTWTdUL0RXd0YwLzVjMUFR?=
 =?utf-8?B?Q3g4OUNRUjJHVmhpZEQvSllMZzduclpZZklUWDFuVTFoK0E4dVRUci84K1NR?=
 =?utf-8?B?MVBWVlZxWUd5Zmt6Ukp2eXZ6dWwwT3pWbGtGdjdCRy9GK2V3VmJWdEkzWmFP?=
 =?utf-8?B?VXBTaVhXQ3BtdGFMQnRnemY1alVMOWVSK08xU1BzYWZST2s3Y0VXRytlVTk3?=
 =?utf-8?B?NXBXNFBFNTVYNll5UkpaS0JaTnRTLzFMR3lUSVQ4dkhqTmN0cDBEWXNjc3VM?=
 =?utf-8?B?MDdxWHJ4OFBrOWEwa3BveVprM3A0Z3dMMlpscHJoKzNWWHJweVI0eWxUaVoy?=
 =?utf-8?B?eGw0UERrT2UvM0lqczFhTW1rRjhiSE9UN1pRMUpUYVc3dGtRMXhhbnhTaHZN?=
 =?utf-8?B?a1FNUDUvTVd3RlBjejZhQ1NpVU5XWXE2VzFtc0tYeXBZMXRIUWdoS1d5aUc5?=
 =?utf-8?B?ZGs4bjV1a3Z1dWNXSUI0czFzOHd0NDJXQVN0WGFKMWZWVS9ZZE05RFJKUlRk?=
 =?utf-8?B?QzVxam1vazBsSU9mZWdJWjArcnBwOGE3Y1JkcUZtcGpNUmR2T3lmYkxvcENH?=
 =?utf-8?B?cG12eFVpRWNSRnJsVm9EcWRKVHhKQ0tYcFVNajNDTGIyOTVvVGRVNVVtbzZx?=
 =?utf-8?B?NEhxZi84c1A0N0NGMlpwaXJxYitNUWRjdTFEUS9mUS9oTlJXWEpoekxMOHdL?=
 =?utf-8?B?RlZ2cE9sQzRNRTB3R1FDaWxrRWV2VWZsMXpFeVVyYlVCNW1kY1d2QTQxblRQ?=
 =?utf-8?B?Rk9BaWtNL09QdnhaTkY4MlRqTnhFeU5kd2l0d3cxTUxUQk5Lc0RmN2J0OVpG?=
 =?utf-8?B?c25uYkptVG1vR1ZtcTBoWUQ4K1NMeFQ3d0k1dlJRUEh2UFV2ZUZxazZZV0d6?=
 =?utf-8?B?WXJjNzVKUVhyaXIxU09STkxOUUNHd2h3UjB5Q3hqcXJORkh6MHlHUit2OUov?=
 =?utf-8?B?SzNZYjg1L2wvazdDOWxVOUtqN1RDbEdrUUpRVzBRaGxITnk5VXV0OFFZT3hY?=
 =?utf-8?B?UkIrd2hxR2RoZzRpemhBUnNLdFhqSzE5K2dhbXV4WStUQnFzK3pSWWEwTnEr?=
 =?utf-8?B?Y3dFdU1oajZYejZhY1M5bmFrNlZkNzFwUnBEWmM1ZTZVMjRJaUJxWUZqTkQz?=
 =?utf-8?B?Tys0TUdUMmcxNTB5UnpzUWd3dFlRSTd6emVXU0NhejR3U2NteHE1QzVWMHZw?=
 =?utf-8?B?dmpWNEVyckVpc243eWVPdEhmcWRxdkx0dUJaT2Jsa09yOHRua01UUWp2azJ3?=
 =?utf-8?B?b2FqRzAySTM0R2ZiSGd0VS8xSlhweHZoQXd6Wm1xK3FwYUpXWEp4V1Vnbld0?=
 =?utf-8?B?cDQ1MFByWmFxZFBZMk43dkJ6bXFPNS9vTzZseDRRSytkbXNxNFBBS0ZmUzlx?=
 =?utf-8?B?L0FNdXpNa0IycldRU01NL1VtM1NOYTNOeXpCVkNZUDZqRE1jNlVWQ0xlRGNv?=
 =?utf-8?B?S0tZUENLWDByYzd1b3FJVjRKYUNHV3laRkxHdXM4NW9jeUpmaHZGSlpoZE8w?=
 =?utf-8?B?WVprQldmOEtYVHkrejZIa2diY2NiYkl3MkhkSE5Ield0NkJ6ckRXN1J5RkFE?=
 =?utf-8?B?SWlaZXMzc1B6ZEVQenE3NUlwWm9tMmIzZWNmNmROUStDK2NxSGZPZDBCSVJr?=
 =?utf-8?B?UG9qaXg1R244dHVJeW1vQTBtbVBzekFLbW1KVmp0K0h6T2VkSWc3b0Rrb2Fh?=
 =?utf-8?B?bWlPemhqQm44OGN0ekQ4c1ltYjZnYjE1VHFGZFpyZ0wyWmVNYnhHaHkrYm12?=
 =?utf-8?B?SGF5QW45U3dTYVdxRlBCbWo2RkRnWTM3d09OVUZUUDVHOFI3T1dJQ2pYd05F?=
 =?utf-8?B?alpYTEFoRDhXNmVLQWR4MExPbTdxdWZ4VHgwWUxWVisvNi9VYktqa3JuSUpR?=
 =?utf-8?B?OFdwTU1CWmZ5a0lUNWpTazZ4TW5QNG4zRWhkSW04UEI1aEdOQXdjSXA1Uysx?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR01MB7354.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052c6fff-cc64-4748-8176-08d9b31a084c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 09:24:23.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 921DQKALU0j8wXeGKSaLqcIxPvxA7f4CWIqCdwQHsTr+J+3rlhsR3IjvTRE7wpzU4qKFlWlDUcKoj/ZQtgpXxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4570
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU1lc3NhZ2UgZCdvcmlnaW5lLS0tLS0NCj4gRGXCoDogSm9oYW5uZXMgQmVyZyA8am9o
YW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gRW52b3nDqcKgOiB2ZW5kcmVkaSAyNiBub3ZlbWJy
ZSAyMDIxIDEzOjA1DQo+IMOAwqA6IEplYW4tUGllcnJlIFRPU09OSSA8anAudG9zb25pQGFja3N5
cy5mcj47ICdsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnJyA8bGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnPg0KPiBPYmpldMKgOiBSZTogW1JGQyB2NF0gbWFjODAyMTE6IGZp
eCByeCBibG9ja2FjayBzZXNzaW9uIHJhY2UgY29uZGl0aW9uDQo+IA0KPiBPbiBUaHUsIDIwMjEt
MTAtMjggYXQgMTA6MjUgKzAwMDAsIEplYW4tUGllcnJlIFRPU09OSSB3cm90ZToNCj4gDQo+ID4g
KwkJc3Bpbl9sb2NrX2JoKCZyeC0+c3RhLT5hbXBkdV9tbG1lLnJ4X29mZmxfbG9jayk7DQo+ID4g
IAkJaWYgKCF0ZXN0X2JpdCh0aWQsIHJ4LT5zdGEtPmFtcGR1X21sbWUuYWdnX3Nlc3Npb25fdmFs
aWQpDQo+ICYmDQo+ID4gLQkJICAgICF0ZXN0X2FuZF9zZXRfYml0KHRpZCwgcngtPnN0YS0NCj4g
PmFtcGR1X21sbWUudW5leHBlY3RlZF9hZ2cpKQ0KPiA+ICsJCSAgICAvKiBiYWNrX3JlcSBpcyBh
bGxvd2VkIGlmIHRoZSBmdyBqdXN0IHJlY2VpdmVkIGFkZGJhICovDQo+ID4NCj4gDQo+IElmIHdl
J3JlIGdvaW5nIHRvIGFkZCBhbiB1bmNvbmRpdGlvbmFsIGxvY2sgaGVyZSwgSSBzZWUgbGl0dGxl
IHJlYXNvbiB0bw0KPiBoYXZlIGFsbCB0aGUgdGVzdF9iaXQoKS90ZXN0X2FuZF9zZXRfYml0KCkg
ZXRjLg0KDQpUaGUgbG9jayBzcGVjaWZpY2FsbHkgcHJvdGVjdHMgdGhlIHN1Y2Nlc3NpdmUgdGVz
dGluZyBvZiBhZ2dfc2Vzc2lvbl92YWxpZA0KYW5kIHRpZF9yeF9tYW5hZ2Vfb2ZmbC4gU28gSSBj
b3VsZCBqdXN0IGlzb2xhdGUgdGhlIGFnZ19zZXNzaW9uX3ZhbGlkIA0KY29uZGl0aW9uIGFzIG1h
am9yIGNvbmRpdGlvbiB0aGVuIHRha2UgdGhlIHNwaW5sb2NrIHRoZW4gdGVzdCZzZXQNCmFnZ19z
ZXNzaW9uX3ZhbGlkIGFuZCB0aWRfcnhfbWFuYWdlX29mZmwgYXMgYSBtaW5vciBjb25kaXRpb24s
IHNvIHRoZQ0Kc3BpbmxvY2sgd291bGQgYmUgY29uZGl0aW9uYWwuIEJ1dCBzZWUgYmVsb3cuDQoN
Cj4gDQo+IEkgcmVhbGx5IGRvbid0IHRoaW5rIGl0J3MgX3JpZ2h0XyB0byBhZGQgYW4gdW5jb25k
aXRpb25hbCBsb2NrIGhlcmUNCj4gdGhvdWdoLCBpZiBpdCBjYW4gYXQgYWxsIGJlIGF2b2lkZWQu
DQo+IA0KPiBqb2hhbm5lcw0KDQpBZnRlciBleHRlbnNpdmUgdGVzdGluZywgYWRkaW5nIHRoaXMg
bG9jayB3YXMgZWZmZWN0aXZlIGJ1dCBvbmx5IHJlbW92ZWQNCmhhbGYgb2YgdGhlIERFTEJBIGZy
YW1lcyB3cm9uZ2x5IHNlbnQuIEkgc3VzcGVjdCB0aGVyZSBpcyBhbm90aGVyIHJhY2UNCmNvbmRp
dGlvbiBzb21ld2hlcmUgZWxzZS4NCg0KVGhpbmtpbmcgYWJvdXQgaXQsIGhlcmUgdGhlIERFTEJB
IGlzIHNlbnQgYmVjYXVzZSB0aGUgYXRoMTBrIGRyaXZlcg0KcGFzc2VzIGEgQkFSRVEgYmVmb3Jl
IHRoZSBzaWduYWxpbmcgdGhlIGVzdGFibGlzaG1lbnQgb2YgdGhlIEJBIHNlc3Npb24uDQplaXRo
ZXIgdGhlIGZpcm13YXJlIHNlbnQgdGhlIHR3byBldmVudHMgaW4gd3Jvbmcgb3JkZXIsIG9yIHRo
ZXJlIHdhcw0KYWN0dWFsbHkgYW4gaW52ZXJzaW9uIGluIHRoZSBmcmFtZXMgc2VudCBieSB0aGUg
aG9zdCAoaW4gbXkgdGVzdGluZywNCldpcmVzaGFyayBzaG93cyB0aGUgZmlyc3QgY2FzZSBvbmx5
KS4NCg0KSW4gdGhlIGZpcnN0IGNhc2UsIHdlIHNob3VsZCBub3Qgc2VuZCBhIERFTEJBIGF0IGFs
bCwgYmVjYXVzZSBhY3R1YWxseSwNCnRoZSBzZXNzaW9uIGlzIGNvcnJlY3RseSBzZXQgdXAuIFRo
ZSBzZWNvbmQgY2FzZSBzaG91bGQgYmUgZGV0ZWN0ZWQNCmFuZCBhY3RlZCB1cG9uIGJ5IGF0aDEw
ayBpdHNlbGYgc2luY2UgaXQgd2FzIHJlc3BvbnNpYmxlIGZvciBhY2tpbmcgdGhlDQpBRERCQTsg
aGVuY2UgbWFjODAyMTEgc2hvdWxkIG5vdCBzZW5kIGEgLWR1cGxpY2F0ZS0gREVMQkEgZWl0aGVy
Lg0KDQpTbywgSSBjb21wbGV0ZWx5IHJlbW92ZWQgdGhpcyBjYWxsIHRvIGllZWU4MDIxMV9zZW5k
X2RlbGJhKCkgd2hlbg0Kd29ya2luZyB3aXRoIGF0aDEwaywgYW5kIG15IFJYIEJBIHNlc3Npb25z
ICBkbyBub3QgYnJlYWsgYW55bW9yZS4NCihJIGFkZGVkIG15IG93biBoYXJkd2FyZSBmbGFnIElF
RUU4MDIxMV9IV19SWF9BTVBEVV9JTl9IVw0Kc2ltaWxhciB0byBUWCkNCg0KV2l0aCBteSBoYXJk
d2FyZSBpdCB3b3JrcywgYnV0IEkgaGF2ZSBubyBpZGVhIGhvdyB0byBpZGVudGlmeQ0KY2hpcHNl
dHMvZHJpdmVycy9maXJtd2FyZXMgdGhhdCB3aWxsIGhhbmRsZSB0aGlzIGNvcnJlY3RseS4gU28g
SQ0KY2Fubm90IHN1Ym1pdCBhIGdlbmVyaWMgcGF0Y2guDQoNClBsZWFzZSBjbG9zZSB0aGlzIHJl
cXVlc3QsIEkgd2lsbCBzdGF5IHdpdGggbXkgcHJvcHJpZXRhcnkgZml4LiBIb3BlZnVsbHkNCnNv
bWVvbmUgd2l0aCBtb3JlIGF0aDEway9maXJtd2FyZSBrbm93bGVkZ2Ugd2lsbCBmaW5kIGEgY29t
cGxldGUNCndheSB0byBmaXguDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldywNCkplYW4tUGllcnJl
DQoNCg==
