Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3418145A45B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 15:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhKWOHC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 09:07:02 -0500
Received: from mail-eopbgr150093.outbound.protection.outlook.com ([40.107.15.93]:6273
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229895AbhKWOG5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 09:06:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7e+D2k8ybex2124f7typvd63siojcfXOilm+U7ijLWMftUYikcsgV9w/v7bWWY/sx9U2bAhhU5PfEpAF3v/1SSPAzxGrMdO7e4e4QdxyMk3m8hRs5YJCxGq3PDfXrxOXTQ2wYyVoa3/02ylNcHeT6Tb2Nfqo382I9Y639Ems6E+Xm6OYRsoBquIbq/JQP6me3xPZ95KJtfkgmGtxZXcliTbhpRWGQYMxDjVwqhqwqzDgO1qcRErkguyAMNlYSwduT5/PVuO3FwR8qqxwbxblyKkarmIC5jshVMsA34cjSvYQnVP+6V8z+wJy/vDdG8p5EFgZU+aTwh2Nq3986EAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeBIk5unjxxzcpJusBbQLrFQ1lxXUXKGgRWLQrjfzMU=;
 b=VxoyCOSWyo4/J6SFBibBawV9K9jl2oGNleeSEczwIIvhyYzwZiokX4IGghOVNmAwKmWZtMBCmkp7NizG/4WxijyIi1eEGtt1nppdreYFer54yoIgnwkBS1ui+MjiWO+TnzniG3/5F97OqqFpDYbelv7u8DGuSlo9SgDmL7r8L8CS6DBg5i4RE/LV+0GXk6AaYVh6HZpZbDI95afhlAf0wX1kfERC/vMv0WvrlQHxRPx5B6B2jTdVJ2QwhzOjATZehKr8TifyPCFyvD9ybFSZnB+EFCHm5qVl4soPR9EAshD6rRFNET/Cllij7IhE0pil5iQ9QzdnG66Q4bVNBq5ufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeBIk5unjxxzcpJusBbQLrFQ1lxXUXKGgRWLQrjfzMU=;
 b=YfslodgaNGOgJpMaNCEvPl7G5BDK9TWv3FGmWtTvpyl5epVDdzF/mmB9vb7/G0EKavpnDJSyh70yYtClnJgmymT2tTgDgtZnfuSCL/5drWRRI7AmhzCvOkdDcyL8V7/SOVb4o04CIn2/AL83dN8jFY3AUzOWq/J9wBBSZ0L6/0Q=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM6PR03MB5078.eurprd03.prod.outlook.com (2603:10a6:20b:8d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 14:03:47 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5970:5e76:6869:ecc]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::5970:5e76:6869:ecc%6]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 14:03:47 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Loic Poulain <loic.poulain@linaro.org>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "chi-hsien.lin@infineon.com" <chi-hsien.lin@infineon.com>,
        "wright.feng@infineon.com" <wright.feng@infineon.com>,
        "chung-hsien.hsu@infineon.com" <chung-hsien.hsu@infineon.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH v2] brcmfmac: Configure keep-alive packet on suspend
Thread-Topic: [PATCH v2] brcmfmac: Configure keep-alive packet on suspend
Thread-Index: AQHX37a0j2uOM/VXG0m6evKk4XorAawRJm8A
Date:   Tue, 23 Nov 2021 14:03:47 +0000
Message-ID: <0c69083b-96d0-c4bd-72cd-8f234920f56b@bang-olufsen.dk>
References: <1637596046-21651-1-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1637596046-21651-1-git-send-email-loic.poulain@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec53548-d98c-48ec-98a9-08d9ae8a11c5
x-ms-traffictypediagnostic: AM6PR03MB5078:
x-microsoft-antispam-prvs: <AM6PR03MB5078F54786F93AF9CD96A6E683609@AM6PR03MB5078.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0UpB8xkNRba8rbJGxGZCAaThllkjCgVwV6G9aYi3Cx2eEc+jiWPwMp5rqE3GCcZmoapR9UfciT3/9ZpCVGmboeUkBhM6n1YQGrv8t7U8CPYrMCnzszQNEnfoc0Zl+kXuWxkGj197z+Y4T1n8EGsqoqdBW2GIXL2a4WR2vhIM6cTbvLprPquQHnAF56ZtL3lbX1yIz+aJT9sdbb1b+HSAbYvp7YJX7WSOeOM+HGfY+oJaXXORh1ChXAPGEzcOF+UD34q/PRYejRQ9nW6ymw1MbbP1n83jC1qMNYsQVgyvtRdnmarfU/K6b46swEIv0jkwXdmTKqqepTt+QgWY4qkRnJ11bRRJelPGgqFcFae26uLO3vcaSyqta6NXvHob4XJJmXyjD0DwSnutB4LGICDcWebePFIeG6k1Fq4NoJxiNcf9R6gaIy07S6pSJH1Pst8fUO1hQnQRx81vGj3iibE0GpHu3i/1gKmnwdsesuVX6iNt5su3ofj1yVaAzhxMn4x2rJj5ANrmN3DlucZs397BNG2C2e+zER0SzG8hXo5/nkgLsavxaoSyBe+6kqRoI7TlO9XXWmXPu++Nae6UFNOgowQppaJiK5Tes2fq8bMgvYCozPA1RuA7OXJdBx7HYdiqgfnyNnjH6rqO0bJoYNiWk7SvBD+V3PbUusPMaws3SH5zzX5Qjkmrm007bpbWexGdKAlTlP/8LxpdZLXM0bO9x19I5mkY4FW+V58Ly4H0OaoA5f2gPiR4Dg8xnVsyLcS1bK3reBfI/z1r+igrBNh2FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(6512007)(85182001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017)(186003)(26005)(5660300002)(508600001)(6486002)(71200400001)(7416002)(2616005)(31696002)(36756003)(54906003)(110136005)(31686004)(6506007)(8676002)(53546011)(8936002)(4326008)(38070700005)(86362001)(8976002)(83380400001)(316002)(85202003)(2906002)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWp3SUlkdXBDaVkreWlyMFlSY2ZGSmc4cXVOQlYveklnQnRhK0Zhb2F3YUlh?=
 =?utf-8?B?V2E4SFhrQkdCYmV1SG1ya3VhbFRTaDh4d3BENW5zb0VoczgwTlYzekRvR3FZ?=
 =?utf-8?B?NERUVkg0aEhRZHdtYkJHaGY0R3hTY29VQVdxWU1RVE9PMjFhM2xob2xTdnZv?=
 =?utf-8?B?NHBXYWRES1BXOGJFWFVUQ3N4VnVDdnFRQmt3dUFVM3h6YWFvQ1BFVWVHTk8w?=
 =?utf-8?B?RnpyUGFZVk9yZ0NRdE9QaE5WQzdPUFhGazd5ZXhGZDlxMHo5T3ZTM2xwU3RS?=
 =?utf-8?B?ZUpicWZ6TFZJdjQ2MWM4NFQxdWtLSWlwKzkrcE9PcU9JZi9lMU0zTVF6dU1N?=
 =?utf-8?B?amF1VTlNcWlNSzBUUE1GcDVQSG5wTDVnN3kycjVmZEI1MHZqQlBVYUM1Umo5?=
 =?utf-8?B?emxyQkRuN2NBR1RubGlFbFdqWDhuWGtsUWlJMTJXbUpEcDV0eFFMK0hWSGx4?=
 =?utf-8?B?eHhvOUVGUEJjRmRnbU9xbStjYjFVdXg3ZTdIbVhkWmdmclRwUDZyZlpxRUN5?=
 =?utf-8?B?Q2x4Tm1mMlpWQjEzU01VRTF5a2FMVURiVHA4b01BVWlraUo1SE5sblBRMDFM?=
 =?utf-8?B?WENUdTlSZEdkNy9qdjJGUlNKeitEWWhCT2pWcHBUK1loNVd0eGtEVFJsWjBt?=
 =?utf-8?B?SG5LUDBlekRDZnhQMko2ZzRBVmdNbHB6NVBOM25QWjh0RGdSVVNuQ1ZRK1By?=
 =?utf-8?B?SXQzaVY0OCtqWTQrSHp6QW1lZnY4WXI4ZVd5MnppOVZuc2tMMXlNSjJNZGh2?=
 =?utf-8?B?eW5IZ2ZDM1JvajRwQTNna3dwSHExL1dXa212THhzaE9Pci9VbG9xZTJSTm8z?=
 =?utf-8?B?UU9SbWg3bCtjcHYyZitLRm9rc2FSZm1pK2tlM3dIS1ByUmRZaDQwZi9za05Q?=
 =?utf-8?B?czh2TTNKZXRkVXdqZUYvc0gzNWhmeWJBNEF1N25pQUR1RlZVd2wvMFUvaXFN?=
 =?utf-8?B?RVl2UGIxZTFPczdFazYrb0k3cVA1WnUvWENlMmpoOUtDU0IybVdqMlRHdkNl?=
 =?utf-8?B?a3BCSkFBLy93V3FoQnBURkZpZ043cUJiODlzOWxxZjdKYXl4UUlLOTFZejZP?=
 =?utf-8?B?Skl3TE5EUTRtQm50N2RFSDU3dTVhSlVZblBVQm5waDZydUJrcC90aHZBNXZm?=
 =?utf-8?B?RDI1Y0tjOFRCallwYytoa1MwRlhGWEhwZFFXME00T3BPVE9OVjJBMkg5bUh3?=
 =?utf-8?B?eFQzZnB1ZTNzZCsyZ2JuNllwM0tib0NPRlBpQ3NHSnAwaHdlZE12amxvcnM4?=
 =?utf-8?B?VlZOQTBYZHY3U01jNGZseUlwenpHMTQwWDBwaW15YTZKL1BsLys1ZWZPRlNj?=
 =?utf-8?B?TmQ1TnYvSlVIdUxCNEdUc0crakNIQURMbG5tUjVJWHVvVkZsUEhNRTM1d1dU?=
 =?utf-8?B?TzFvZXNOdGdvSnFBZktzSXhLaFVPd0s2YVhQMDB6N0FpeDlSKzFURWV0UmdC?=
 =?utf-8?B?STRjWERGS0tmNHBPZkhNWnR1WTJLWGlIOWRLU2QrazE1YnQwMXJSdkFOMWR6?=
 =?utf-8?B?TGRKS0dldWxkdm5EZDFYWWFhaGRNdzNEcHNvb1lmM2d5LzlpRUVRLzFXc3ds?=
 =?utf-8?B?cWxmVlpPQVdyOG9Nc3ZtYzNESnhyYzZrT2tTRWo5clVxK2FVa1ZOQjVwZWFK?=
 =?utf-8?B?ZEw3dzM4T0l0QnM0S2ZCSFIzbSs1L3NCUlFVZnN3c3ozMjRtc0JHeUlJWEpo?=
 =?utf-8?B?L1FRMHVmdlIzeS9UekNGV09jZWxmTHR1UFlDb2ZGeDV3bHlQM1FqcjRGcncx?=
 =?utf-8?B?UlFMOTM3QnAvZTJmZTZPOGRqOGJHdmZyNHJNTXFrWVZ0ZmE0MWwva2FXaXdO?=
 =?utf-8?B?TDNwTGVrY3NUai91bTJRQUV6K0ZpSGN0UFZFWUd6czZxWXZCMXdzdzV3L09Y?=
 =?utf-8?B?UjhHWnNZZVczL2huV3F3bkFrMDF5K01mTmJQOFl4NEJaTzQreVRqdWtBSG4z?=
 =?utf-8?B?VmNaWlNYTmdwWExPL2g4QkJ4VE8rT3FGemk3R1c2SGRCSHdEQ0ozYXNZRlZ5?=
 =?utf-8?B?KzcrZmkwZnU2NytMR0lTZlFCZnk1TVEyY1B6dXo3ajJua09KaWhseXZVWFJE?=
 =?utf-8?B?d0ZjSkN3eTVwcUx5RWREL051QjlyZGx0YW4zbVZMazRxMmZSMXhyRW0wOWs4?=
 =?utf-8?B?RHVEUHBmZGlXVGFYOUdnY3NsL040eCs5Q3BuWjJwTklGVFFPRDF4aFVlQkR0?=
 =?utf-8?Q?7PFduH7je0WuTtU2j4Yb3iU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <472EBBEA69978249A87BEDBC5C068647@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec53548-d98c-48ec-98a9-08d9ae8a11c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 14:03:47.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4vHRu4Q2YhSBhi3vWoSLq/6I86MElzIXG7t4Kd4O2PQAG5IOCU061i94zjgTzVPDs4uIJkpygL1RwDTXofBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5078
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTG9pYywNCg0KVGhpcyBzZWVtcyBsaWtlIGEgZ29vZCBjaGFuZ2UuIEkgbGVmdCBzb21lIGNv
bW1lbnRzIGJlbG93Lg0KDQpPbiAxMS8yMi8yMSAxNjo0NywgTG9pYyBQb3VsYWluIHdyb3RlOg0K
PiBXaGVuIGVudGVyaW5nIHN1c3BlbmQgYXMgYSBjbGllbnQgc3RhdGlvbiB3aXRoIHdvd2xhbiBl
bmFibGVkLA0KPiB0aGUgV2ktRmkgbGluayBpcyBzdXBwb3NlZCB0byBiZSBtYWludGFpbmVkLiBJ
biB0aGF0IHN0YXRlLCBubw0KPiBtb3JlIGRhdGEgaXMgZ2VuZXJhdGVkIGZyb20gY2xpZW50IHNp
ZGUsIGFuZCB0aGUgbGluayBzdGF5cyBpZGxlDQo+IGFzIGxvbmcgdGhlIHN0YXRpb24gaXMgc3Vz
cGVuZGVkIGFuZCBhcyBsb25nIHRoZSBBUCBhcyBubyBkYXRhIHRvDQo+IHRyYW5zbWl0Lg0KPiAN
Cj4gSG93ZXZlciwgbW9zdCBvZiB0aGUgQVBzIGtpY2stb2ZmIHN1Y2ggJ2luYWN0aXZlJyBzdGF0
aW9ucyBhZnRlcg0KPiBmZXcgbWludXRlcywgY2F1c2luZyB1bmV4cGVjdGVkIGRpc2Nvbm5lY3Qg
KHJlY29ubmVjdCwgZXRjLi4uKS4NCj4gDQo+IFRoZSB1c3VhbCB3YXkgdG8gcHJldmVudCB0aGlz
IGlzIHRvIHN1Ym1pdCBhIE51bGwgZnVuY3Rpb24gZnJhbWUNCj4gcGVyaW9kaWNhbGx5IGFzIGEg
a2VlcC1hbGl2ZS4gVGhpcyBpcyBzb21ldGhpbmcgdGhhdCBjYW4gYmUgaG9zdA0KPiAvc29mdHdh
cmUgZ2VuZXJhdGVkIChlLmcuIHdwYV9zdXBwbGljYW50KSwgYnV0IHRoYXQgbmVlZHMgdG8gYmUN
Cj4gb2ZmbG9hZGVkIHRvIHRoZSBXaS1GaSBjb250cm9sbGVyIGluIGNhc2Ugb2Ygc3VzcGVuZGVk
IGhvc3QuDQo+IA0KPiBUaGlzIGNoYW5nZSBlbmFibGVzIGZpcm13YXJlIGdlbmVyYXRlZCBrZWVw
LWFsaXZlIGZyYW1lcyB3aGVuDQo+IGVudGVyaW5nIHdvd2xhbiBzdXNwZW5kLCB1c2luZyB0aGUg
J21rZWVwX2FsaXZlJyBJT1ZBUi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvaWMgUG91bGFpbiA8
bG9pYy5wb3VsYWluQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHYyOiAtIGNvbW1pdCByZXdvcmQg
bWV0aW9uaW5nIHdvd2xhbg0KPiAgICAgICAtIGJyY21mX2tlZXBhbGl2ZV9zdGFydCBhcyBzdGF0
aWMgZnVuY3Rpb24NCj4gDQo+ICAgLi4uL3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNt
Zm1hYy9jZmc4MDIxMS5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQo+ICAgLi4uL2Jyb2Fk
Y29tL2JyY204MDIxMS9icmNtZm1hYy9md2lsX3R5cGVzLmggICAgICAgIHwgMTkgKysrKysrKysr
KysrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNt
Zm1hYy9jZmc4MDIxMS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjEx
L2JyY21mbWFjL2NmZzgwMjExLmMNCj4gaW5kZXggZmI3Mjc3Ny4uMTY3OTM2MSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2Nm
ZzgwMjExLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjEx
L2JyY21mbWFjL2NmZzgwMjExLmMNCj4gQEAgLTM5MDEsNiArMzkwMSwyNCBAQCBzdGF0aWMgdm9p
ZCBicmNtZl9jb25maWd1cmVfd293bChzdHJ1Y3QgYnJjbWZfY2ZnODAyMTFfaW5mbyAqY2ZnLA0K
PiAgIAljZmctPndvd2wuYWN0aXZlID0gdHJ1ZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW50
IGJyY21mX2tlZXBhbGl2ZV9zdGFydChzdHJ1Y3QgYnJjbWZfaWYgKmlmcCwgdW5zaWduZWQgaW50
IGludGVydmFsKQ0KPiArew0KPiArCXN0cnVjdCBicmNtZl9ta2VlcF9hbGl2ZV9wa3RfbGUga2Fs
aXZlID0gezB9Ow0KPiArCWludCByZXQgPSAwOw0KPiArDQo+ICsJLyogQ29uZmlndXJlIE51bGwg
ZnVuY3Rpb24vZGF0YSBrZWVwYWxpdmUgKi8NCj4gKwlrYWxpdmUudmVyc2lvbiA9IGNwdV90b19s
ZTE2KDEpOw0KPiArCWthbGl2ZS5wZXJpb2RfbXNlYyA9IGNwdV90b19sZTE2KGludGVydmFsICog
TVNFQ19QRVJfU0VDKTsNCj4gKwlrYWxpdmUubGVuX2J5dGVzID0gY3B1X3RvX2xlMTYoMCk7DQo+
ICsJa2FsaXZlLmtlZXBfYWxpdmVfaWQgPSBjcHVfdG9fbGUxNigwKTsNCj4gKw0KPiArCXJldCA9
IGJyY21mX2ZpbF9pb3Zhcl9kYXRhX3NldChpZnAsICJta2VlcF9hbGl2ZSIsICZrYWxpdmUsIHNp
emVvZihrYWxpdmUpKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlicmNtZl9lcnIoImtlZXAtYWxpdmUg
cGFja2V0IGNvbmZpZyBmYWlsZWQsIHJldD0lZFxuIiwgcmV0KTsNCj4gKw0KPiArCXJldHVybiBy
ZXQ7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgczMyIGJyY21mX2NmZzgwMjExX3N1c3BlbmQoc3Ry
dWN0IHdpcGh5ICp3aXBoeSwNCj4gICAJCQkJICBzdHJ1Y3QgY2ZnODAyMTFfd293bGFuICp3b3ds
KQ0KPiAgIHsNCj4gQEAgLTM5NDcsNiArMzk2NSw5IEBAIHN0YXRpYyBzMzIgYnJjbWZfY2ZnODAy
MTFfc3VzcGVuZChzdHJ1Y3Qgd2lwaHkgKndpcGh5LA0KPiAgIAl9IGVsc2Ugew0KPiAgIAkJLyog
Q29uZmlndXJlIFdPV0wgcGFyYW1hdGVycyAqLw0KPiAgIAkJYnJjbWZfY29uZmlndXJlX3dvd2wo
Y2ZnLCBpZnAsIHdvd2wpOw0KPiArDQo+ICsJCS8qIFByZXZlbnQgZGlzYXNzb2NpYXRpb24gZHVl
IHRvIGluYWN0aXZpdHkgd2l0aCBrZWVwLWFsaXZlICovDQo+ICsJCWJyY21mX2tlZXBhbGl2ZV9z
dGFydChpZnAsIDMwKTsNCg0KRG8geW91IGFsc28gd2FudCB0byBkaXNhYmxlIGl0IG9uIHJlc3Vt
ZT8NCg0KVGhlcmUgaXMgYWxzbyB0aGUgd293bF9rZWVwYWxpdmUgSU9WQVIgd2hpY2ggbWlnaHQg
YmUgbW9yZSBzdWl0YWJsZToNCg0Kd293bF9rZWVwYWxpdmUNCiAgICAgICAgIFNlbmQgc3BlY2lm
aWVkIGtlZXAgYWxpdmUgcGFja2V0IHBlcmlvZGljYWxseSBpbiB3IG1vZGUuDQogICAgICAgICBV
c2FnZTogd2wgd293bF9rZWVwYWxpdmUgPGluZGV4MC0xPiA8cGVyaW9kPiA8cGFja2V0Pg0KICAg
ICAgICAgICAgICAgICBpbmRleDogMCAtIDEuDQogICAgICAgICAgICAgICAgIHBlcmlvZDogUmUt
dHJhbnNtaXNzaW9uIHBlcmlvZCBpbiBtaWxsaS1zZWNvbmRzLiAwIHRvIA0KZGlzYWJsZSBwYWNr
ZXQgdHJhbnNtaXRzLg0KICAgICAgICAgICAgICAgICBwYWNrZXQ6IEhleCBwYWNrZXQgY29udGVu
dHMgdG8gdHJhbnNtaXQuIFRoZSBwYWNrZXQgDQpjb250ZW50cyBzaG91bGQgaW5jbHVkZSB0aGUg
ZW50aXJlIGV0aGVybmV0IHBhY2tldCAoZXRoZXJuZXQgaGVhZGVyLCBJUCANCmhlYWRlciwgVURQ
IGhlYWRlciwgYW5kIFVEUCBwYXlsb2FkKSBzcGVjaWZpZWQgaW4gbmV0d29yayBieXRlIG9yZGVy
Lg0KDQogICAgICAgICBlLmcuIFNlbmQga2VlcCBhbGl2ZSBwYWNrZXQgZXZlcnkgMzAgc2Vjb25k
cyB1c2luZyBpZC0xOg0KICAgICAgICAgd2wgd293bF9rZWVwYWxpdmUgMSAzMDAwMCANCjB4MDAx
NGE1NGIxNjRmMDAwZjY2ZjQ1YjdlMDgwMDQ1MDAwMDFlMDAwMDQwMDA0MDExYzUyYTBhODgzMDcw
MGE4ODMwMjUxM2M0MTNjNDAwMGEwMDAwMGEwZA0KDQpJbiB0aGF0IGNhc2UgeW91IHByb2JhYmx5
IGRvbid0IGhhdmUgdG8gdW5zZXQgaXQgZWl0aGVyLCBvciB3b3JyeSBhYm91dCANCm90aGVyIHVz
ZXJzIG9mIG1rZWVwX2FsaXZlLg0KDQpLaW5kIHJlZ2FyZHMsDQoNCglBbHZpbg0KDQo=
