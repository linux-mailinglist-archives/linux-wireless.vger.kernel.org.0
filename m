Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E565651A07
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 05:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiLTEmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 23:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTEmp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 23:42:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2A1261F
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 20:42:42 -0800 (PST)
X-UUID: a235d208ed7d4890b3b54134017bddf4-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MFUgshTh/cwND3yOKbrHBV1KklQrGHtCxnnq/mmwSEM=;
        b=Gz9/5Tv5D9wMs61Kj9ZnyqmZT914FIO3wHwL0aXab3PHu41rVND4Wox01UE45drk9wKT/opid4Ch7n7Ov01xhGNHnsDrxjaukZ0tINdomg4qbC9q7czqMuakJ7JpuAXTRnt7aivz92c+pnSiLT2oy2XCKGt29fgZOcjPVuDKhVs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:7ce6ac7c-b907-4d2c-b064-fef5627526b9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:7611d989-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a235d208ed7d4890b3b54134017bddf4-20221220
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2097342868; Tue, 20 Dec 2022 12:42:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 20 Dec 2022 12:42:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 20 Dec 2022 12:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUJOqgzGeMfBLRcdwUk6Y+YZTYgIhI2alPlKPtVBmyCouhlxFnZHazJ0AHYN44o1B4Y9m3q+JgI2exHLC4IOI744fU8s/WiL0zIw66dIAftUlZxD51ewVgP6g7t64peRVA2jRaT908hEniefjsCY7qLGVaV4hPaV0ZUVbOVI7+/IVAAVJDxesJmSDIOvRuaa2HJ1CqNZYkF1dwdQXj1oWJg5qf2PrSE9y37JlffUOp0depr3oQjzczrtQxg8Shvyj2nenW3H8amw6O8vk2mDdVTjNeG9lWYE0wiV909VQ4l+RNuHwMulMN2ZCMisTX/4OErdXKfqKCoTNV7J2YjGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFUgshTh/cwND3yOKbrHBV1KklQrGHtCxnnq/mmwSEM=;
 b=EExZ4LfI0kVEbOfC/S5imesfmbVpYzD1F+CmcL+AX60mlHgNDybUteqvV5pZlqjU8PF3CkKvY8tATijNLZ8cZfqJu6ggrn7pfSKZq2IOkA08P8JX/xwet69S/qfV1QOkbEJrUBpJGuSjDwC/EyZXl9x1NzRaISrfi+S4pLRMymx4kq+m64Lq+XYSwx7y2vDJMJeEAOZS7IoCY3VEjUYGBaNKaOstmocmpeLJFLCf0fDxK+sdq+Zt3xrgiaMBpb9ylZtLttaEG0Lnk1dqpQXNtPy9QI/9NvxoyvPZerfSrEMLYVbNrTJFovvB80Q3PPUyB75L5TzSEhbucEEbp5JGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFUgshTh/cwND3yOKbrHBV1KklQrGHtCxnnq/mmwSEM=;
 b=GOCOIYqOY2HRJ/Vcnm7kCJpGVwNDi4DJ7wkhQW73/sdnv2foDVKYLVeJcD9KHQJl0VP0drtXIqy0ns3oaJaNbO+QjUq8ayjF6QtrYB9DXU3bVypkODY/nLEggUSUK0avVdHJzrQrBIwwNE9Hq1w0vzGEvhq/vK+jgC1sihUmTY8=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by SEYPR03MB6436.apcprd03.prod.outlook.com (2603:1096:101:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 04:42:33 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 04:42:33 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Topic: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Index: AQHZE2UYm26GeWDuU0a5b6k/XQDcva50+UQAgAE64oA=
Date:   Tue, 20 Dec 2022 04:42:33 +0000
Message-ID: <9d8aa92e3650128c94af91435a222c00ff2acb1c.camel@mediatek.com>
References: <0a218783098a6b1b90ff120c7182acee93dc8feb.1671423784.git.Bo.Jiao@mediatek.com>
         <Y6A1Et1yzcWnWhpy@lore-desk>
In-Reply-To: <Y6A1Et1yzcWnWhpy@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|SEYPR03MB6436:EE_
x-ms-office365-filtering-correlation-id: 8172d021-85d2-4149-1f5c-08dae2449c17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26bFvkwjFhv8qtDhy0FnCruAlemA+S66Y9xIkemElhrFltz3wuYqB65vFDy57MbW7lhTqLx38hxEjCZxFH6Thx2IVvqQhE4ZWz2ENgHrH1fukq8LRKk8k0gwDp5BvBaY6dhm0n39bahxf8RbU4tRIrFPOKWVDky1MatI+emwmg/bdIsuIvdEkoE1JEpZHxNsqAiPQDWY7AxV8qb3gI+k9zZ/giWdxgLZDoZRjxbFAGHLYZw8N/WWpprVJePJSsfPJYHZrNLdlCdvO+LDYXwDvoJD/K3HipeRGLGC+/Y6Sp2FK9Xgump/pcSilfCCbZ4mVGAtTyNVdlPGcCAgY6urVzKHGk2tod0iEX5zdBYb7BIN013dowPsfRQblhAZA0eyOKsu+q9sINU75fKapyuCz5LxbJuilsuCnmqz9gQhIsY7pGmfH3/cZGIsSFrvWCjvnOPF29/R6Qoi9LnMRraX1C7OhS5foDBzaaezUyeazfMIjRQUusNxbJMhDpVyXyq6/4bAITaXpvP/5nAkBydsuglC8uL6FU2Uy/4U/fum81aoPwYGwjDxRwXCo3rxvJ9XwcaOGFj+LVq3K/QmEyPadmTRUk2RNUnqHqvA3UVhIkb5p5T1K9VfWwP9LMThujbSLMhY+XRgNO4imTTDshK6peWokAHDgDUNDTcW8CYXJn06nHmoRI65q/BgbyMAV4Waccuv1MuXXnRoT1J9ggGhSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(85182001)(36756003)(110136005)(2906002)(4001150100001)(54906003)(316002)(122000001)(2616005)(83380400001)(478600001)(26005)(6486002)(6512007)(86362001)(71200400001)(186003)(38070700005)(38100700002)(8676002)(5660300002)(66476007)(64756008)(41300700001)(66446008)(66556008)(4326008)(6506007)(8936002)(76116006)(91956017)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXlENmEzK3FFR3BZblQzSENhbEtEd2JaRVJmQytNcWhzQ3lXbWdqcXBHNTNk?=
 =?utf-8?B?OUdCeTVsWDlEV1B5Mmdxakk1SGhpZ0NkS2g3blY0Zm5MSXVkL05KdnduN1ZH?=
 =?utf-8?B?UTg0dExuNmFKVVg5dFRUbFp0R2dUMUF5WkdLb2lXZk9oNXBrNWkyRkR3QStS?=
 =?utf-8?B?OEJxVmdydEF1RzdMRENvN3cxYVhQSzlTY2FJTHF3WTc1ZzJJUU1YYlBhM0hH?=
 =?utf-8?B?MFNZWnVlT1NkMHlsS2h5aVVYdTZFSytFcE1CSlpIR3ZiVHhhbHA2S1AvNXpH?=
 =?utf-8?B?S0FsZnp6clNvbnEwZWUzRDR0bnZsVjV4SlhzS2YvVko4Z0VIUVJCcVJ0S0Uw?=
 =?utf-8?B?VUVTdHIrRkg4WGplOVJMT3pKMTdhdEdxZEMybXdsQTg0Rk1UL1ZBTlg4Slg4?=
 =?utf-8?B?NUFPZDBIa2VORTZxQnNFZVoveGM1dldJaUlFSDErd2VRUnlXVkNwNlBGaVQy?=
 =?utf-8?B?VEgzeXFKVTlVbW8wa0pwcWx1cHllRjNsQ0dHRzcvWVVLbHJ6VzB0OVdtZUht?=
 =?utf-8?B?bUlmQTQvRmFEdmZhR1d2OUZqUnhRRzBuNDhPTnRvSFYyVWJjbnRyeUpBNXA0?=
 =?utf-8?B?NFF3VnBlVzBDYTFwNWZLa1V4dkdaZWJ2cGI3Mm1vMDRYZXpPVjZNRUFBZmdP?=
 =?utf-8?B?WDRaQ3F4Rm5HeG5SeFRrbmRiNXNqbVUvTmpPK0habVhYblNRUkE1aUlPanRq?=
 =?utf-8?B?a1hrR1BsT0ppZFFLbTg2eHVENFZjdlhrR1AxVzRwaFNIWisxWnk2Y1RNQmln?=
 =?utf-8?B?MGtVTEZ1MlFweXkwNVUxUGFUVUFyTSs5V2RPbVdZTlBZRUIrdGhQZzFHTllu?=
 =?utf-8?B?RXRtMGgxQllqQkJOQU1UQU9QLzI3Z1kzUVdiSzJsSVZUWXZTbFhuNCtSaGlK?=
 =?utf-8?B?WEZQaSs3akV0T2g5Z2U0R0lkcU02ZmVkbnovbTBBRENVSDdiZThDUGh0YTM0?=
 =?utf-8?B?S2JnUFpmaDBXdEVyK3FVd3p1VFVNTEJxdlE5R1Mzb3lsNGdHV3I4dG02NUJj?=
 =?utf-8?B?NGx6U2NmbUlnaUIxUmE3Qm1ZRnZRQ2pDL1VtR0RqdHdURDZ5QkhYV0NXOHZH?=
 =?utf-8?B?bUYzZGJRTkpIa1djQnozWThYRlFLWEJhTGZzY1BhbFNaQ0Q0Z0EzeFJLMlJF?=
 =?utf-8?B?WERESklxMlV6UllVMGg4VTg4Vkg3eEpGUy8zNnlaVEo0U21tdWZicG0ybXlz?=
 =?utf-8?B?UVFId3ZsODQrVmYwVW4wY2g5ZC84cHljL1BCRm1aNEdJY01IVjFzemV6Tlpm?=
 =?utf-8?B?bUFrUXJreEFuNE54YSs4NDd0Z3lYa1Z5WWVEcG0rUEVtL1d2R2t4YUVEenY5?=
 =?utf-8?B?UmNtbm4rRUY2Z1JZVmRQMDNnTWdtbjVUd2lhdlFYeGE2cmc1V0ZhWlBabU9a?=
 =?utf-8?B?RHcraXBiNEJhZGo4SkJEY1I0R2Rmd0kyYitlbWc0RjAvNzhFbll4dGVGU005?=
 =?utf-8?B?UHZ5bW0xMmJ2aFRacU5aUDNYK2RMY0JrQmF4WE9GcEMxTkVGYlBJZmY5Uk1J?=
 =?utf-8?B?NXdYbndhcHNMRHQ0ZFNQbUsxZ293TDE5eitVeVFBNVN4NHgrcHRmRFBpTkU0?=
 =?utf-8?B?OWl2R3RnWGNnNU5MTExCdjBXWE9IMkJIb0toTVYyT1JjcG0za1hWS2owUk1i?=
 =?utf-8?B?cjFiaXpZZHlqRnBjWE5lQWdOL3hxYkhGT3djbXloZ3NoL2k5UVkvTEZ4Mnox?=
 =?utf-8?B?enAxSnZrcDd3d0E0KzVEQmRZOUp5U2ZTTWhreVZ6Rk1UeThsRlZlRHJVV29p?=
 =?utf-8?B?UmFsN2h0OWpBcjVsNkZXMU1rdExBaWNRTUdQSWlIR1d0Nkh0T1haakRoSjZr?=
 =?utf-8?B?ZUNEK1UvUzUvaFV5dVZJdytnVitJWGcvQnlsR3hENTVZeEVvU3ZLejYyLzZW?=
 =?utf-8?B?SVZXdTUzdVlMYXdrUkI4Y3owT0daSE1nQWczbktIQ3g2cElDUWNYeUd6L2dI?=
 =?utf-8?B?VUJNQ2h3WUhTbVN4b2pIWnlOQjk0dS9YTWpaVGNYOEJlN2NMUHlDZGhVMnAw?=
 =?utf-8?B?Vit0RndVbEpoM3NlUVlVb2RJUlFoZ0dPQkNQT1JqTGRvRlRHTzY0QkFTcWpp?=
 =?utf-8?B?NHg4SmNwSE96WTRHSGFKVGpHaWxkN1ZMRnliemxrS2Jrc0pQOHFFMm9qRlVH?=
 =?utf-8?B?b0dicEdkV2paZTdmRlVUWTZTcjFoQWI0Um1QOExmS3dFRVVScE1NTzFTZGYx?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A642F9FB2CA1646A1AE323949100991@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8172d021-85d2-4149-1f5c-08dae2449c17
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 04:42:33.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMoCTMzMYdNm6XxjGZZas1S/U3WK9kkEC4qhVq2VBGlmnlbBh7QN7rYPYkqrjiWhRgNo4d5SVCmwQByCPgnb/yAnI07hDUnmpHT2AYc1AR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTE5IGF0IDEwOjU1ICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IEJvIEppYW8gPEJvLkppYW9AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IGZp
eCBwb3RlbnRpYWwgbWVtb3J5IGxlYWthZ2UsIHJlY3ljbGUgcnh3aSB3aGVuIG10NzZfZG1hX2Fk
ZF9idWYoKQ0KPiA+IGNhbGwgZmFpbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBCbyBKaWFv
IDxCby5KaWFvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAtIHJlY3ljbGUg
cnh3aSB3aGVuIHBhZ2VfZnJhZ19hbGxvYygpIGFuZCBkbWFfbWFwX3NpbmdsZSgpIGZhaWwuDQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMgfCAy
NyArKysrKysrKysrKysrKy0tLS0NCj4gPiAtLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2RtYS5jDQo+ID4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2RtYS5jDQo+ID4gaW5kZXggZmMyNGIzNS4uNzZhZDQ3
ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2Rt
YS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0K
PiA+IEBAIC01ODAsMjQgKzU4MCwyOSBAQCBtdDc2X2RtYV9yeF9maWxsKHN0cnVjdCBtdDc2X2Rl
diAqZGV2LCBzdHJ1Y3QNCj4gPiBtdDc2X3F1ZXVlICpxKQ0KPiA+ICANCj4gPiAgCQlidWYgPSBw
YWdlX2ZyYWdfYWxsb2MoJnEtPnJ4X3BhZ2UsIHEtPmJ1Zl9zaXplLA0KPiA+IEdGUF9BVE9NSUMp
Ow0KPiA+ICAJCWlmICghYnVmKQ0KPiA+IC0JCQlicmVhazsNCj4gPiArCQkJZ290byBvdXQ7DQo+
ID4gIA0KPiA+ICAJCWFkZHIgPSBkbWFfbWFwX3NpbmdsZShkZXYtPmRtYV9kZXYsIGJ1ZiwgbGVu
LA0KPiA+IERNQV9GUk9NX0RFVklDRSk7DQo+ID4gLQkJaWYgKHVubGlrZWx5KGRtYV9tYXBwaW5n
X2Vycm9yKGRldi0+ZG1hX2RldiwgYWRkcikpKSB7DQo+ID4gLQkJCXNrYl9mcmVlX2ZyYWcoYnVm
KTsNCj4gPiAtCQkJYnJlYWs7DQo+ID4gLQkJfQ0KPiA+ICsJCWlmICh1bmxpa2VseShkbWFfbWFw
cGluZ19lcnJvcihkZXYtPmRtYV9kZXYsIGFkZHIpKSkNCj4gPiArCQkJZ290byBmcmVlOw0KPiA+
ICANCj4gPiAgCQlxYnVmLmFkZHIgPSBhZGRyICsgb2Zmc2V0Ow0KPiA+ICAJCXFidWYubGVuID0g
bGVuIC0gb2Zmc2V0Ow0KPiA+ICAJCXFidWYuc2tpcF91bm1hcCA9IGZhbHNlOw0KPiA+IC0JCWlm
IChtdDc2X2RtYV9hZGRfYnVmKGRldiwgcSwgJnFidWYsIDEsIDAsIGJ1ZiwgdCkgPCAwKQ0KPiA+
IHsNCj4gPiAtCQkJZG1hX3VubWFwX3NpbmdsZShkZXYtPmRtYV9kZXYsIGFkZHIsIGxlbiwNCj4g
PiAtCQkJCQkgRE1BX0ZST01fREVWSUNFKTsNCj4gPiAtCQkJc2tiX2ZyZWVfZnJhZyhidWYpOw0K
PiA+IC0JCQlicmVhazsNCj4gPiAtCQl9DQo+ID4gKwkJaWYgKG10NzZfZG1hX2FkZF9idWYoZGV2
LCBxLCAmcWJ1ZiwgMSwgMCwgYnVmLCB0KSA8IDApDQo+ID4gKwkJCWdvdG8gdW1hcDsNCj4gPiAr
DQo+ID4gIAkJZnJhbWVzKys7DQo+ID4gKwkJY29udGludWU7DQo+ID4gKw0KPiA+ICt1bWFwOg0K
PiA+ICsJCWRtYV91bm1hcF9zaW5nbGUoZGV2LT5kbWFfZGV2LCBhZGRyLCBsZW4sDQo+ID4gKwkJ
CQkgRE1BX0ZST01fREVWSUNFKTsNCj4gPiArZnJlZToNCj4gPiArCQlza2JfZnJlZV9mcmFnKGJ1
Zik7DQo+ID4gK291dDoNCj4gPiArCQltdDc2X3B1dF9yeHdpKGRldiwgdCk7DQo+ID4gKwkJYnJl
YWs7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJaWYgKGZyYW1lcykNCj4gDQo+IEhpIEJvLA0KPiAN
Cj4gSSBndWVzcyBpbiB0aGUgd2F5IGJlbG93LCB0aGUgY29kZSBpcyBtb3JlIHJlYWRhYmxlLCB3
aGF0IGRvIHlvdQ0KPiB0aGluaz8NCj4gDQo+IFJlZ2FyZHMsDQo+IExvcmVuem8NCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2RtYS5jDQo+IGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiBpbmRleCBmYWQ1ZmUx
OWZlMTguLjAwMTUzOGY2OThmMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L2RtYS5jDQo+IEBAIC01NzEsMTMgKzU3MSw2IEBAIG10NzZfZG1hX3J4X2ZpbGwoc3Ry
dWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdA0KPiBtdDc2X3F1ZXVlICpxKQ0KPiAgCQlzdHJ1Y3Qg
bXQ3Nl9xdWV1ZV9idWYgcWJ1ZjsNCj4gIAkJdm9pZCAqYnVmID0gTlVMTDsNCj4gIA0KPiAtCQlp
ZiAoKHEtPmZsYWdzICYgTVRfUUZMQUdfV0VEKSAmJg0KPiAtCQkgICAgRklFTERfR0VUKE1UX1FG
TEFHX1dFRF9UWVBFLCBxLT5mbGFncykgPT0NCj4gTVQ3Nl9XRURfUV9SWCkgew0KPiAtCQkJdCA9
IG10NzZfZ2V0X3J4d2koZGV2KTsNCj4gLQkJCWlmICghdCkNCj4gLQkJCQlicmVhazsNCj4gLQkJ
fQ0KPiAtDQo+ICAJCWJ1ZiA9IHBhZ2VfZnJhZ19hbGxvYygmcS0+cnhfcGFnZSwgcS0+YnVmX3Np
emUsDQo+IEdGUF9BVE9NSUMpOw0KPiAgCQlpZiAoIWJ1ZikNCj4gIAkJCWJyZWFrOw0KPiBAQCAt
NTg4LDE2ICs1ODEsMjcgQEAgbXQ3Nl9kbWFfcnhfZmlsbChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwg
c3RydWN0DQo+IG10NzZfcXVldWUgKnEpDQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiAgDQo+ICsJ
CWlmICgocS0+ZmxhZ3MgJiBNVF9RRkxBR19XRUQpICYmDQo+ICsJCSAgICBGSUVMRF9HRVQoTVRf
UUZMQUdfV0VEX1RZUEUsIHEtPmZsYWdzKSA9PQ0KPiBNVDc2X1dFRF9RX1JYKSB7DQo+ICsJCQl0
ID0gbXQ3Nl9nZXRfcnh3aShkZXYpOw0KPiArCQkJaWYgKCF0KQ0KPiArCQkJCWdvdG8gdW5tYXA7
DQo+ICsJCX0NCj4gKw0KPiAgCQlxYnVmLmFkZHIgPSBhZGRyICsgb2Zmc2V0Ow0KPiAgCQlxYnVm
LmxlbiA9IGxlbiAtIG9mZnNldDsNCj4gIAkJcWJ1Zi5za2lwX3VubWFwID0gZmFsc2U7DQo+IC0J
CWlmIChtdDc2X2RtYV9hZGRfYnVmKGRldiwgcSwgJnFidWYsIDEsIDAsIGJ1ZiwgdCkgPCAwKQ0K
PiB7DQo+IC0JCQlkbWFfdW5tYXBfc2luZ2xlKGRldi0+ZG1hX2RldiwgYWRkciwgbGVuLA0KPiAt
CQkJCQkgRE1BX0ZST01fREVWSUNFKTsNCj4gLQkJCXNrYl9mcmVlX2ZyYWcoYnVmKTsNCj4gLQkJ
CWJyZWFrOw0KPiArDQo+ICsJCWlmICghbXQ3Nl9kbWFfYWRkX2J1ZihkZXYsIHEsICZxYnVmLCAx
LCAwLCBidWYsIHQpKSB7DQo+ICsJCQlmcmFtZXMrKzsNCj4gKwkJCWNvbnRpbnVlOw0KPiAgCQl9
DQo+IC0JCWZyYW1lcysrOw0KPiArDQo+ICt1bm1hcDoNCj4gKwkJZG1hX3VubWFwX3NpbmdsZShk
ZXYtPmRtYV9kZXYsIGFkZHIsIGxlbiwNCj4gRE1BX0ZST01fREVWSUNFKTsNCj4gKwkJc2tiX2Zy
ZWVfZnJhZyhidWYpOw0KPiArCQltdDc2X3B1dF9yeHdpKGRldiwgdCk7DQo+ICsJCWJyZWFrOw0K
PiAgCX0NCj4gIA0KPiAgCWlmIChmcmFtZXMpDQo+IA0KSGkgTG9yZSwNCg0Kd2UgbG92ZSB5b3Vy
IHBhdGNoLCBidXQgd2UgaGF2ZSBhbm90aGVyIHBhdGNoIHRvIGF2b2lkIG1lbW9yeQ0KZnJhZ21l
bnRhdGlvbiBieSBkdXBsaWNhdGluZyB0aGUgcnggc2tiIGFmdGVyIG10NzZfZG1hX2RlcXVldWUo
KS4gaXQNCnJlcXVpcmVzIG10NzZfZ2V0X3J4d2koKSBiZSBwbGFjZWQgYmVmb3JlIHBhZ2VfZnJh
Z19hbGxvYygpLg0KDQp0aGUgYmVsb3cgcGF0Y2gobmVlZCByZWJhc2UpIHdpbGwgYmUgc2VudCBh
ZnRlciB0aGUgY3VycmVudCBwYXRjaCBpcw0KYWNjZXB0ZWQuDQoNCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvZG1hLmMNCkBAIC0zODYsOSArMzg2LDExIEBAIG10NzZfZG1hX2dldF9i
dWYoc3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdA0KbXQ3Nl9xdWV1ZSAqcSwgaW50IGlkeCwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNLQl9XSVRIX09WRVJIRUFEKHEtPmJ1
Zl9zaXplKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9GUk9NX0RFVklD
RSk7DQoNCi0gICAgICAgICAgICAgICBidWYgPSB0LT5wdHI7DQorICAgICAgICAgICAgICAgYnVm
ID0gcGFnZV9mcmFnX2FsbG9jKCZxLT5yeF9wYWdlLCBxLT5idWZfc2l6ZSwNCkdGUF9BVE9NSUMp
Ow0KKyAgICAgICAgICAgICAgIGlmICghYnVmKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIE5VTEw7DQorICAgICAgICAgICAgICAgbWVtY3B5KGJ1ZiwgdC0+cHRyLCBTS0JfV0lUSF9P
VkVSSEVBRChxLT5idWZfc2l6ZSkpOw0KICAgICAgICAgICAgICAgIHQtPmRtYV9hZGRyID0gMDsN
Ci0gICAgICAgICAgICAgICB0LT5wdHIgPSBOVUxMOw0KDQogICAgICAgICAgICAgICAgbXQ3Nl9w
dXRfcnh3aShkZXYsIHQpOw0KDQpAQCAtNTY5LDYgKzU3MSw3IEBAIG10NzZfZG1hX3J4X2ZpbGwo
c3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdA0KbXQ3Nl9xdWV1ZSAqcSkNCiAgICAgICAgd2hp
bGUgKHEtPnF1ZXVlZCA8IHEtPm5kZXNjIC0gMSkgew0KICAgICAgICAgICAgICAgIHN0cnVjdCBt
dDc2X3R4d2lfY2FjaGUgKnQgPSBOVUxMOw0KICAgICAgICAgICAgICAgIHN0cnVjdCBtdDc2X3F1
ZXVlX2J1ZiBxYnVmOw0KKyAgICAgICAgICAgICAgIGJvb2wgc2tpcF9hbGxvYyA9IGZhbHNlOw0K
ICAgICAgICAgICAgICAgIHZvaWQgKmJ1ZiA9IE5VTEw7DQoNCiAgICAgICAgICAgICAgICBpZiAo
KHEtPmZsYWdzICYgTVRfUUZMQUdfV0VEKSAmJg0KQEAgLTU3NiwxMSArNTc5LDE5IEBAIG10NzZf
ZG1hX3J4X2ZpbGwoc3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdA0KbXQ3Nl9xdWV1ZSAqcSkN
CiAgICAgICAgICAgICAgICAgICAgICAgIHQgPSBtdDc2X2dldF9yeHdpKGRldik7DQogICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoIXQpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KKw0KKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHQtPnB0cikgew0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBza2lwX2FsbG9jID0gdHJ1ZTsNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYnVmID0gdC0+cHRyOw0KKyAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KICAgICAgICAgICAgICAgIH0NCg0KLSAgICAgICAgICAgICAgIGJ1ZiA9IHBhZ2VfZnJh
Z19hbGxvYygmcS0+cnhfcGFnZSwgcS0+YnVmX3NpemUsDQpHRlBfQVRPTUlDKTsNCi0gICAgICAg
ICAgICAgICBpZiAoIWJ1ZikNCi0gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KKyAgICAg
ICAgICAgICAgIGlmICghc2tpcF9hbGxvYykgew0KKyAgICAgICAgICAgICAgICAgICAgICAgYnVm
ID0gcGFnZV9mcmFnX2FsbG9jKCZxLT5yeF9wYWdlLCBxLT5idWZfc2l6ZSwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfQVRPTUlDKTsNCisgICAgICAg
ICAgICAgICAgICAgICAgIGlmICghYnVmKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCisgICAgICAgICAgICAgICB9DQoNCiAgICAgICAgICAgICAgICBhZGRyID0gZG1h
X21hcF9zaW5nbGUoZGV2LT5kbWFfZGV2LCBidWYsIGxlbiwNCkRNQV9GUk9NX0RFVklDRSk7DQog
ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KGRtYV9tYXBwaW5nX2Vycm9yKGRldi0+ZG1hX2Rl
diwgYWRkcikpKSB7DQotLQ0KMi4xOC4wDQoNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCg==
