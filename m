Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7464633545
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 07:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKVG1q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 01:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKVG1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 01:27:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A252ED7C
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 22:27:21 -0800 (PST)
X-UUID: 181422b951ce40c4b7188c6ef55f7b1a-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=801rFqibeByJRcJGBDVwqSJO6QY7zIh3xHsAbw4TORg=;
        b=TLJhvJkSxsDO9ZfeYUeIwrdgAD6apuV99T0VfnF9XGSYVz1CUS4v87cdZvpkm6nmYIEewlFr8WYuP6YbYkq3dti2LgHFYyn2IEO/SuNiIC/vdf9fFnKUC3UlDjAKPuUrfMxd1kQLY0vN0Xbl1PQR/Dfj7jFdQbBj4yqJdoAnpPw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:ff78c184-814d-47a3-822d-214518335b69,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:0c95f2f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 181422b951ce40c4b7188c6ef55f7b1a-20221122
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1331662092; Tue, 22 Nov 2022 14:27:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 14:27:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 14:27:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWu4tUcXpuEIwf0PtFbp2hFzLbB3rxAzgfPj9+TPC5QyhnT0EZ+WhORWzeSvFnzAnglz/voTcIOA8al7AwIgtIQm2YgTwi177vBe4hZAASQst7aBVBQxYtMnbv337Ojts9lDFPzArli7N1c8LH4jAnyTyC0bl2kRYRoZNQ/NsxNelWQg5Sv/WRayBq69OJV++Q2zxdjHUjNrjDWi26sMbt8Eh9j2sTZQl4lK1waJKPwpKVPMFCoNeQlW0zDBy5nYtPtVJi1tfz2V1X3cfcK1FKLr17NmAcYdluAPxJuLncPTTGh08AiHTWDIn6t8qzsx9E+1L+xdLS3/nwaNnb+LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=801rFqibeByJRcJGBDVwqSJO6QY7zIh3xHsAbw4TORg=;
 b=TWskYt157+PpaJ3VjpYmmwGZ+siajMDFRhEhPQNYV7aiZytVVjl+1C7nAydyzPwgRg4FuSyLFD0l2duJTdT8qX/4wryR3L1u2OsBbL2j1YgVF2ixn5n4YugwRITlPofxgyXormak2ZCI5H+w9Vei0ZpbTNcWbDrVO3AkuPNHS/x1xW9/UvPTPA5yFUKNP6hjjBDKCAzN8rN4gDEiWnE2wK3NjNtxWzva3Ugip8ONCs6WYPiwyCvtz8EX40KNTwCjuQ8OJZmmNsWT0xVgq2MVOmYyoANUxFPtF3pdBJSziB02mg9qjvnZeUfiNysjmpRhvizB1IJbj1WuHmWzOtXr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=801rFqibeByJRcJGBDVwqSJO6QY7zIh3xHsAbw4TORg=;
 b=dLImmxjK9Y/NzC8eBYuuU6G39sNJPuFOU5HPHmaMEbAvU4rdmenDqSlgIB8tq2bOAJHCEsJjgnccfYkBMyADcoEbetCRLYNk7nNGD0yMzQV2mwRHsrVwnVQDoOhzhHP08pRuhxApBbQCMAAr1surttRQMyYJdunrr8ngsU3uLmg=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by SI2PR03MB5276.apcprd03.prod.outlook.com (2603:1096:4:10f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 06:27:12 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::1a4e:1765:7e7f:4000]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::1a4e:1765:7e7f:4000%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 06:27:12 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7915: add wds support when wed is enabled
Thread-Topic: [PATCH] wifi: mt76: mt7915: add wds support when wed is enabled
Thread-Index: AQHY/Zxs+xMG1snEbUmWZdKMzwvlUK5JYuAAgAEYz4A=
Date:   Tue, 22 Nov 2022 06:27:12 +0000
Message-ID: <9347265baa18876553a9689411113a0e50ac0668.camel@mediatek.com>
References: <af04db938bf9633225c4358058a39aa3be0e218e.1669022945.git.sujuan.chen@mediatek.com>
         <Y3uAMEfCxQhC46Hm@lore-desk>
In-Reply-To: <Y3uAMEfCxQhC46Hm@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|SI2PR03MB5276:EE_
x-ms-office365-filtering-correlation-id: 01885bd3-9c2a-4cc4-2458-08dacc52975a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wPeOWYUqIPc73fko3jsxLrZdxevWWFeJdz+BnW77U+DYPfCM06MUSJTsU3yE9V/AXKSx+Xxt1+zXAkPckUbg1auUHZlIQFJXEZHiJGij2sTjWwhsrEkH0T/pteDTrFsPUJ7tMYvSpmQbczYWEm/BKDUN9FmAAUSImT6BB1LMu2vir9Al5lV546jLkY2wRx7/AY5HoK29B27mfWnfdClf/LyQBW3CxRaQC+IFMc1vJWzu7wmZsGDgWSUgv01nRXo51tYXZO/t+xmTtkKxIamdUkcbIQ5jjoAeIY/ylZANfNOy6BM0mqym+Wi0W4mIGmYeLCZ6qP26m/WJpcR5G72Mvfguy62EV1XFX2ZcHxSONWlWwpMkBbvBON0HVT6ya416s1BYte5bFjmfCzAj+qvYSuWGjaRo90VFTDT8ayrfxecafyG7+CVfPGFAPGy5L3+5u9bPk1nMJhaC+oV27d9QFdNBUFqBlUzpfgir1xUjWjAKOngfpetRDF4L9c7Hwr/AOHDfO6lGHmgy2nMs2GUlFbqy0ixNaqPAKXBis1p0Ih7Em/pVXwSN41HrRaW44h0EWq36enQHbvlZGKECct7+bQdHouLhizdbuW5aUrLtxbK/LNCdDt79HMcmbLRtdO2+14L/nWXCWwygxMXumO0pJGzbgRi/lhs1BgXmhxndrV3njuQEoEePM2/4WjJCfcHzGu/zIzOAwAPdXrWOXGOHqYKgpTRDWox611JY+1AIAz8JLTgLhULbkI2VhVfiVzPI6/vnSYMRyVrUcN3qjiYYqfJjL5grhsMfDITLbYByEts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(122000001)(38100700002)(26005)(38070700005)(86362001)(71200400001)(966005)(107886003)(5660300002)(6486002)(6506007)(478600001)(66556008)(76116006)(66946007)(4326008)(64756008)(91956017)(8676002)(66446008)(66476007)(41300700001)(316002)(83380400001)(2616005)(186003)(6512007)(4001150100001)(2906002)(54906003)(8936002)(6916009)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdhNUFJR2V6ZUpmU1F4ZlM3TXl5S0JCS2lwemVLYnBETEViTllyQ0x5aUdO?=
 =?utf-8?B?U3FaRW9scU81WE9zeWtCc2hVaGRMWENwaWxDT2pCVFpRSElIUUtjNFhVR0ZY?=
 =?utf-8?B?SElhaVgwdW4zY0ZEZ3Q3YUg2T2hobnNyOEtZckplRmV6blZUZ21NS2lGQkJQ?=
 =?utf-8?B?d3p4ZHZHRHVNWHkvalczcUZWMEV6MDk5SWtPMWxJRXd3azRWbnNuNU9nNWlq?=
 =?utf-8?B?NHVibTdxMGo2Y3BvcnQvRmQxc0dCenBOOCthUVNsOEdFcmlwK2ZYUVU3dDZj?=
 =?utf-8?B?WkNLT1NEd01aM1ovTHVHU3FxemRia096OCs5S3NZNFJ2Ryt3eHB0RWFiMHlp?=
 =?utf-8?B?bkxBeVpNQm9YU1Mzcmd4dGp3NkNicEFDZWNIdWZFUmRGT3oyRXlTYzFRbkhq?=
 =?utf-8?B?N2grZytVeEVKd0xHVzE5eDhobUsrN0tJU3l0K0NVS3U2N1FvQW9wZGxQWk4x?=
 =?utf-8?B?QmRCU3lPMG9EeWsrWS9pV1FMWi83aFVHYS9RV1VmNjJHOGRid2JNakM2VDhN?=
 =?utf-8?B?Q3lhNVlONFViWEFHTUtSZEhvanJqQTc0bEtkODl0aFMvWHJmbndYcVBVU1g4?=
 =?utf-8?B?dXVpZlhxQUM4bnphNzlYM1E1Y0V5V053eHhwdC93dnFYYjBsV1dMWnBKeVVP?=
 =?utf-8?B?UmxUWEVNSktNMDQySWVzeGtXbDEyQnFPNUhISFRsQlpPY2NyaTZGaDdvVUM5?=
 =?utf-8?B?aXJ4SHhCZndzVnNLZHhHTURsMUlFdXJmY09PWjJOZ3JaZzkwSW9WZE5qWkRF?=
 =?utf-8?B?Y1BLUEtGVVkxSXh5UjVWUFlHbExwTUhFNEphOExYVFIyaXAwL2lkckZEZlVZ?=
 =?utf-8?B?NWhnMWhlL24zeUQyOVFxNjVWVDYyTDdZQkNwSGxaQXZLbmxBeVJyeHhMaXFL?=
 =?utf-8?B?OGp2U3MrSG1MWWRFQTZyQm41UUpKRExMR3F2eVh3dkdpYzV2YmlpRXR0bWNw?=
 =?utf-8?B?MjVEVnZBOFE2UE5BTzZmYkkxNXFreHZsRUx3K0dvaU1PVzlOczkyVXA1T2lv?=
 =?utf-8?B?RUdnUVdTL2ZKM0M4bk1UZ2dMSE44d0d0b2ZPRWFrYlFSRjByZmxYc2lhTmR6?=
 =?utf-8?B?RUo0eFg1VE9KMmZnZnVkNEIzNTY0Z3J3WjhiakVuRmIxaDNDTjRYMmVlUWYy?=
 =?utf-8?B?OVNjS1lBRFh2TmpRMExnWWJad3h4TGsxdFBjUzc5MmRaMXhJZE0rK3R2bGlS?=
 =?utf-8?B?bE9uTmVtd2pLenZjVTJodThxT1BGbWx3aTRXcEk1MHFrS1lwTERDWUd0U0pm?=
 =?utf-8?B?OFJUdXVTdEM4bVZZNFV1WitrbFV0NWtWSlVJRTAwNkpiOEJPRnh1dnZJYk5S?=
 =?utf-8?B?elFOclNxMHdYalhCWjJYdXNLS082Wm11TDdUZHhMSTBLTjUvN0tlMlE4bmVW?=
 =?utf-8?B?ckh0UHh5Yy9ETXQ5Zjg2WENIZEZZbUxFZjc4Tmw5WjM3dkszbjdndW9oVkJN?=
 =?utf-8?B?WlJZQkk1L2h4QXllQUhkNzNOWlBaLzBSckpVU0VyaTZFN1NUUTNjS25pMjdX?=
 =?utf-8?B?MUdEaHZNTXdNSHIyUFV6NVZvVFFEUmhTWHZuanBRWnlOREdOM1d6SThLMlhr?=
 =?utf-8?B?dWpkRzFueUthMXdvckE0L2dnL01HZHYwcFUzWm1GS2JDQk91WHpQR2VPQnFs?=
 =?utf-8?B?eEI4akhMMk1yMjlkdzlWR2JvUEwyU0ZMRUk4RlJzWnNNNFNZR2RvMHRhVjAw?=
 =?utf-8?B?NHg3UUZGa1UwWmJvdjFLVncrYXNEZ0lTSlIxT25SSU9MNklQU2J2dHFUeWwx?=
 =?utf-8?B?YTZGVldDYlN1Z29xNC91cHB4ejlLTUgvOS9iNFdTcHROMElXTVVsUnA4M25a?=
 =?utf-8?B?VDNMd0hQK01nOVNEZkJCWVdNbm9yQlV3dzdEdFhFclJuamxrSldoMm16VmZr?=
 =?utf-8?B?cC9qWlRGK2hRNU4yL2dSSXVWTnJYQUtMelppc0VTc1VhZXRzUjdNQTlWTml6?=
 =?utf-8?B?STl4ZjdKcFA0SDlsVGU3d1FvbU9vZURmSC82VUgzL01BaGRvMXVTNmUxcmJU?=
 =?utf-8?B?LzQyZWZHQnZ1WFc1VHA0VUo4QkpCeWNuc2JMNUIyYUtUbFRHZnRzWDFoSXlI?=
 =?utf-8?B?Y0g0VHEyaWtoNWJuS09Ed0p3Y0Rudjd0ekdiME42dTVtNXhRNmxwaC82YzhC?=
 =?utf-8?B?UHFCcGVWbFdpNXU2bjJsby9YZWpMTkx6aWhWVHNaL1hkRkJlbm1xbE14WXlU?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5995ECA5702A54CB49FE59CCC124623@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01885bd3-9c2a-4cc4-2458-08dacc52975a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 06:27:12.4373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZP2U5E+VLPC03uL9cSfWUpsAojN+xS3zvqah9w4daFSpB4kAxdKTv3fsz1oVcwtOA6sunH1TWTS85oUgJAwn2gE+xCg8jXvqL+zeh9joV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTIxIGF0IDE0OjQyICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBbLi4uXQ0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgZW51bSBtY3VfbW1wc19tb2RlIHsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bW1pby5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
bWlvLmMNCj4gPiBpbmRleCAxZmNmMzRmNTdhMTYuLmQ5MDc5M2QwODJiOCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMN
Cj4gPiBAQCAtNzczLDYgKzc3Myw5IEBAIGludCBtdDc5MTVfbW1pb193ZWRfaW5pdChzdHJ1Y3Qg
bXQ3OTE1X2Rldg0KPiA+ICpkZXYsIHZvaWQgKnBkZXZfcHRyLA0KPiA+ICANCj4gPiAgCWRldi0+
bXQ3Ni5yeF90b2tlbl9zaXplID0gd2VkLT53bGFuLnJ4X25wa3Q7DQo+ID4gIA0KPiA+ICsJaWYg
KCFpc19tdDc5MTUoJmRldi0+bXQ3NikpDQo+ID4gKwkJd2VkLT53bGFuLndjaWRfNTEyID0gdHJ1
ZTsNCj4gDQo+IEkgZm9yZ290IHRvIHNheSB0aGlzIGlzIGFscmVhZHkgaW4gdGhpcyBwYXRjaDoN
Cj4gDQo+IA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVs
ZXNzL3BhdGNoL2M2YTJhNThjZGQ0MmI0N2I0YzIyMTM3YTQwZTM1N2RkNzRiYTgwMTQuMTY2ODI2
NzI0MS5naXQubG9yZW56b0BrZXJuZWwub3JnLw0KPiANCg0KYWNrLCBJIHdpbGwgZHJvcCBpdCBp
biB2Mg0KDQpSZWdhcmRzLA0KU3VqdWFuDQoNCj4gUmVnYXJkcywNCj4gTG9yZW56bw0KPiANCj4g
PiArDQo+ID4gIAlpZiAobXRrX3dlZF9kZXZpY2VfYXR0YWNoKHdlZCkpDQo+ID4gIAkJcmV0dXJu
IDA7DQo+ID4gIA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkyMS9pbml0LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTIxL2luaXQuYw0KPiA+IGluZGV4IDc5YjgwNTVjZTRjNC4uNzAyZmYzMDBmOGY3
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTIxL2luaXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTIxL2luaXQuYw0KPiA+IEBAIC0yODMsNyArMjgzLDcgQEAgc3RhdGljIGludCBtdDc5MjFf
aW5pdF93Y2lkKHN0cnVjdCBtdDc5MjFfZGV2DQo+ID4gKmRldikNCj4gPiAgCWludCBpZHg7DQo+
ID4gIA0KPiA+ICAJLyogQmVhY29uIGFuZCBtZ210IGZyYW1lcyBzaG91bGQgb2NjdXB5IHdjaWQg
MCAqLw0KPiA+IC0JaWR4ID0gbXQ3Nl93Y2lkX2FsbG9jKGRldi0+bXQ3Ni53Y2lkX21hc2ssIE1U
NzkyMV9XVEJMX1NUQSAtDQo+ID4gMSk7DQo+ID4gKwlpZHggPSBtdDc2X3djaWRfYWxsb2MoZGV2
LT5tdDc2LndjaWRfbWFzaywgTVQ3OTIxX1dUQkxfU1RBIC0gMSwNCj4gPiAwKTsNCj4gPiAgCWlm
IChpZHgpDQo+ID4gIAkJcmV0dXJuIC1FTk9TUEM7DQo+ID4gIA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9tYWluLmMNCj4gPiBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYw0KPiA+IGluZGV4
IDQxZGYxN2VmZGIzYS4uM2Q4NzcxZmNiODQ3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYw0KPiA+IEBAIC04MTQsNyAr
ODE0LDcgQEAgaW50IG10NzkyMV9tYWNfc3RhX2FkZChzdHJ1Y3QgbXQ3Nl9kZXYgKm1kZXYsDQo+
ID4gc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCj4gPiAgCXN0cnVjdCBtdDc5MjFfdmlmICpt
dmlmID0gKHN0cnVjdCBtdDc5MjFfdmlmICopdmlmLT5kcnZfcHJpdjsNCj4gPiAgCWludCByZXQs
IGlkeDsNCj4gPiAgDQo+ID4gLQlpZHggPSBtdDc2X3djaWRfYWxsb2MoZGV2LT5tdDc2LndjaWRf
bWFzaywgTVQ3OTIxX1dUQkxfU1RBIC0NCj4gPiAxKTsNCj4gPiArCWlkeCA9IG10NzZfd2NpZF9h
bGxvYyhkZXYtPm10NzYud2NpZF9tYXNrLCBNVDc5MjFfV1RCTF9TVEEgLSAxLA0KPiA+IDApOw0K
PiA+ICAJaWYgKGlkeCA8IDApDQo+ID4gIAkJcmV0dXJuIC1FTk9TUEM7DQo+ID4gIA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9pbml0
LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L2luaXQu
Yw0KPiA+IGluZGV4IGNkMTY1N2UzNTg1ZC4uNGNmMDU1MDQwNTE5IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L2luaXQuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L2luaXQuYw0KPiA+
IEBAIC00MzMsNyArNDMzLDcgQEAgc3RhdGljIGludCBtdDc5OTZfaW5pdF9oYXJkd2FyZShzdHJ1
Y3QNCj4gPiBtdDc5OTZfZGV2ICpkZXYpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4g
IAkvKiBCZWFjb24gYW5kIG1nbXQgZnJhbWVzIHNob3VsZCBvY2N1cHkgd2NpZCAwICovDQo+ID4g
LQlpZHggPSBtdDc2X3djaWRfYWxsb2MoZGV2LT5tdDc2LndjaWRfbWFzaywgTVQ3OTk2X1dUQkxf
U1RBKTsNCj4gPiArCWlkeCA9IG10NzZfd2NpZF9hbGxvYyhkZXYtPm10NzYud2NpZF9tYXNrLCBN
VDc5OTZfV1RCTF9TVEEsIDApOw0KPiA+ICAJaWYgKGlkeCkNCj4gPiAgCQlyZXR1cm4gLUVOT1NQ
QzsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTk2L21haW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5OTYvbWFpbi5jDQo+ID4gaW5kZXggMjFkZWEzZmE3ZGMxLi5mZDQwYjUxNWNjNWIg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
OTYvbWFpbi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5OTYvbWFpbi5jDQo+ID4gQEAgLTU3OSw3ICs1NzksNyBAQCBpbnQgbXQ3OTk2X21hY19zdGFf
YWRkKHN0cnVjdCBtdDc2X2RldiAqbWRldiwNCj4gPiBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlm
LA0KPiA+ICAJdTggYmFuZF9pZHggPSBtdmlmLT5waHktPm10NzYtPmJhbmRfaWR4Ow0KPiA+ICAJ
aW50IHJldCwgaWR4Ow0KPiA+ICANCj4gPiAtCWlkeCA9IG10NzZfd2NpZF9hbGxvYyhkZXYtPm10
NzYud2NpZF9tYXNrLCBNVDc5OTZfV1RCTF9TVEEpOw0KPiA+ICsJaWR4ID0gbXQ3Nl93Y2lkX2Fs
bG9jKGRldi0+bXQ3Ni53Y2lkX21hc2ssIE1UNzk5Nl9XVEJMX1NUQSwgMCk7DQo+ID4gIAlpZiAo
aWR4IDwgMCkNCj4gPiAgCQlyZXR1cm4gLUVOT1NQQzsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvdXRpbC5jDQo+ID4gYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3V0aWwuYw0KPiA+IGluZGV4IDU4MTk2NDQyNTQ2
OC4uMDg1MDE0OWY0MjAwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvdXRpbC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni91dGlsLmMNCj4gPiBAQCAtNDIsOSArNDIsMTQgQEAgYm9vbCBfX210NzZfcG9sbF9t
c2VjKHN0cnVjdCBtdDc2X2RldiAqZGV2LCB1MzINCj4gPiBvZmZzZXQsIHUzMiBtYXNrLCB1MzIg
dmFsLA0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKF9fbXQ3Nl9wb2xsX21zZWMpOw0K
PiA+ICANCj4gPiAtaW50IG10NzZfd2NpZF9hbGxvYyh1MzIgKm1hc2ssIGludCBzaXplKQ0KPiA+
ICtpbnQgbXQ3Nl93Y2lkX2FsbG9jKHUzMiAqbWFzaywgaW50IHNpemUsIHU4IGZsYWcpDQo+ID4g
IHsNCj4gPiArI2RlZmluZSBNVDc2X1dFRF9XRFNfTUlOICAgIDI1Ng0KPiA+ICsjZGVmaW5lIE1U
NzZfV0VEX1dEU19DTlQgICAgMTYNCj4gPiArDQo+ID4gIAlpbnQgaSwgaWR4ID0gMCwgY3VyOw0K
PiA+ICsJaW50IG1pbiA9IE1UNzZfV0VEX1dEU19NSU47DQo+ID4gKwlpbnQgbWF4ID0gbWluICsg
TVQ3Nl9XRURfV0RTX0NOVDsNCj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgRElWX1JPVU5E
X1VQKHNpemUsIDMyKTsgaSsrKSB7DQo+ID4gIAkJaWR4ID0gZmZzKH5tYXNrW2ldKTsNCj4gPiBA
QCAtNTMsMTMgKzU4LDQ2IEBAIGludCBtdDc2X3djaWRfYWxsb2ModTMyICptYXNrLCBpbnQgc2l6
ZSkNCj4gPiAgDQo+ID4gIAkJaWR4LS07DQo+ID4gIAkJY3VyID0gaSAqIDMyICsgaWR4Ow0KPiA+
IC0JCWlmIChjdXIgPj0gc2l6ZSkNCj4gPiArDQo+ID4gKwkJc3dpdGNoIChmbGFnKSB7DQo+ID4g
KwkJY2FzZSBNVDc2X1dFRF9ESVNBQkxFRDoNCj4gPiArCQkJaWYgKGN1ciA+PSBzaXplKQ0KPiA+
ICsJCQkJZ290byBlcnJvcjsNCj4gPiArDQo+ID4gIAkJCWJyZWFrOw0KPiA+ICsJCWNhc2UgTVQ3
Nl9XRURfQUNUSVZFOg0KPiA+ICsJCQlpZiAoY3VyID49IG1pbiAmJiBjdXIgPCBtYXgpDQo+ID4g
KwkJCQljb250aW51ZTsNCj4gPiArDQo+ID4gKwkJCWlmIChjdXIgPj0gc2l6ZSkgew0KPiA+ICsJ
CQkJdTMyIGVuZCA9IE1UNzZfV0VEX1dEU19DTlQgLSAxOw0KPiA+ICsNCj4gPiArCQkJCWkgPSBt
aW4gLyAzMjsNCj4gPiArCQkJCWlkeCA9IGZmcyh+bWFza1tpXSAmIEdFTk1BU0soZW5kLCAwKSk7
DQo+ID4gKwkJCQlpZiAoIWlkeCkNCj4gPiArCQkJCQlnb3RvIGVycm9yOw0KPiA+ICsJCQkJaWR4
LS07DQo+ID4gKwkJCQljdXIgPSBtaW4gKyBpZHg7DQo+ID4gKwkJCX0NCj4gPiArDQo+ID4gKwkJ
CWJyZWFrOw0KPiA+ICsJCWNhc2UgTVQ3Nl9XRURfV0RTX0FDVElWRToNCj4gPiArCQkJaWYgKGN1
ciA8IG1pbikNCj4gPiArCQkJCWNvbnRpbnVlOw0KPiA+ICsJCQlpZiAoY3VyID49IG1heCkNCj4g
PiArCQkJCWdvdG8gZXJyb3I7DQo+ID4gKw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQlkZWZhdWx0
Og0KPiA+ICsJCQlXQVJOX09OKDEpOw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+ID4gIA0K
PiA+ICAJCW1hc2tbaV0gfD0gQklUKGlkeCk7DQo+ID4gIAkJcmV0dXJuIGN1cjsNCj4gPiAgCX0N
Cj4gPiAgDQo+ID4gK2Vycm9yOg0KPiA+ICAJcmV0dXJuIC0xOw0KPiA+ICB9DQo+ID4gIEVYUE9S
VF9TWU1CT0xfR1BMKG10NzZfd2NpZF9hbGxvYyk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvdXRpbC5oDQo+ID4gYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L3V0aWwuaA0KPiA+IGluZGV4IDI2MDk2NWRkZTk0Yy4uYzcyNDYw
ZTc4Mzg5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvdXRpbC5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni91
dGlsLmgNCj4gPiBAQCAtMjcsNyArMjcsNyBAQCBlbnVtIHsNCj4gPiAgI2RlZmluZSBNVDc2X0lO
Q1IoX3ZhciwgX3NpemUpIFwNCj4gPiAgCShfdmFyID0gKCgoX3ZhcikgKyAxKSAlIChfc2l6ZSkp
KQ0KPiA+ICANCj4gPiAtaW50IG10NzZfd2NpZF9hbGxvYyh1MzIgKm1hc2ssIGludCBzaXplKTsN
Cj4gPiAraW50IG10NzZfd2NpZF9hbGxvYyh1MzIgKm1hc2ssIGludCBzaXplLCB1OCBmbGFnKTsN
Cj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiA+ICBtdDc2X3djaWRfbWFza19zZXQo
dTMyICptYXNrLCBpbnQgaWR4KQ0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0K
