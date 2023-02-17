Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D769A803
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 10:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBQJVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 04:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBQJVa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 04:21:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B312F37
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 01:21:28 -0800 (PST)
X-UUID: 7124d08eaea411ed945fc101203acc17-20230217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=c5yqNM6RKADWIBB5zxyIUUASxHtAp3TzGq7eVRBFDQI=;
        b=GvzbVKVLeIzsL4Kzod+cQvsL6JphLIBmhhcGsVJtlufFRieiA4Tzx1EiSRc/OYNuWS9ZhgB0kXjR/1OB0vvgRQArm40M8iATFkf8XNSJOwv3RmX4OsmF8R8BBkmHoOEySFlnXKw020CoQ4FdIbbLaCGLtLaIrOIbN07s58kcpqw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:76658f60-40e3-4bd7-92e4-c74eb8fa6792,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:6982e225-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 7124d08eaea411ed945fc101203acc17-20230217
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 874859662; Fri, 17 Feb 2023 17:21:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 17 Feb 2023 17:21:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 17 Feb 2023 17:21:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nieknq4pAxHeZOqlWs7x7y0anfDrz+qvdruWs3uZcRCjZXWeKDXNHiJ5uNxKglUNgYoL/4v9Z0OYxy/VfJVOHM89PNxjr5l2Rwf9DGMJYpukvfXq2mL/AEcQypztujwU5vj4xm4d0+OXG9LwnEu3XKc8cbaIe5XDMbYIvb0eit5+v2L/UyOZ0JDP7elRQkptkFcttbp9zHFjqJ1fmc0L27a0XwPpeTDgjkCvqJr4D72CcaqHOPKgOS5U8wvHHp2O+DoJPopJZakZ0hQlsjUxz1wJCOjuXaQ4r4Szpt3LaRBErXa5IUQGzUcodV88gAj5nWQErVZ2AwbqG1TvHDcw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5yqNM6RKADWIBB5zxyIUUASxHtAp3TzGq7eVRBFDQI=;
 b=YBr5noEwYitKJxtupjWRtoz4+RuyKxFCM853vNRHH1UjZh67sKfhBKJHbLPNp4eacBsQi5hnw9j9U2W9+WkO80/fRryxP0S3N0MULiERjZm6GqKOBmHkDTKPMTyVQn9gVt1OBfk0MQOfgKrTca+MgFw1XVoxXPzgsdOShEWV3M134ufZT/YurYpJGWxMaJOQ7FHMvu3LySqrhT6FaBcREFqzF1wXhspGsx8XnMtJDCIGzT00o2vIFpFyqtuarzc74QPiVsPehwLoMwDHflAbQ0rnrDUH5xN/nH1zPHaaGa1ajf5Ig6gIrNP3Zw5+/yMqPhbEzCTnu7ntYFw3boRZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5yqNM6RKADWIBB5zxyIUUASxHtAp3TzGq7eVRBFDQI=;
 b=nvZd5hRRS/WRSkpQU3lsRrx+oA6mNUMy3VdvGiLvEOpNo84637EzcuBM+sX6F9sFg8edyQUhYF21JLRtL/a1QZB9+i45NzV5mHhZlXMrkAn4u9xdhOYprxhLbWuedkbQ4uizO2nsTUFvCvIQ7CFthImwirjNAOqC5ra4QI8WbVg=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SI2PR03MB5610.apcprd03.prod.outlook.com (2603:1096:4:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 09:21:17 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%9]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 09:21:17 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH 1/2] wifi: mac80211: add EHT MU-MIMO related flags in
 ieee80211_bss_conf
Thread-Topic: [PATCH 1/2] wifi: mac80211: add EHT MU-MIMO related flags in
 ieee80211_bss_conf
Thread-Index: AQHZQWT34hxzOaeEHkGD7LAngR0WWq7S35UA
Date:   Fri, 17 Feb 2023 09:21:17 +0000
Message-ID: <791f6a25eecef8a0b30ca75acdca9bd11740acad.camel@mediatek.com>
References: <c1a6ef2f42e26a6e0473d4fb2ce1b572f8448d87.1675893838.git.ryder.lee@mediatek.com>
         <26c62285825010dc9947c9a8c147f60da5db004a.camel@sipsolutions.net>
In-Reply-To: <26c62285825010dc9947c9a8c147f60da5db004a.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SI2PR03MB5610:EE_
x-ms-office365-filtering-correlation-id: 4f21cfcb-405a-4de9-e7c5-08db10c85311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7WonjISUCixmoZzos8qcpNZA1xezmG9qWx1IT83wsiNdAIteqMb5v/iuQcb/KH+xZXqHzWybdEt2OEHr2M+a3EvoPp6v911yPpxGZVIhAQzJb91xNVfxnL2IIRpN+l4jnhigYzKVlMsbSL9qao/77poYP0in/MNZnm+EanEBd7L5ZNt8uxfld5WpSSLkUXPBH7KC5aMp8gqMYwt/2KHlHOnGLH50d6e1EIcKseOTiEO0K9D7HSNSfFgUOm9ieKo3UJoVgC8L6AAswsq+vk7AzPYdNkRh1+utW277UW9wm7OcLnUE59Isy77tFIjO50o0awcx1bIXPwTN2s0rSWsHy4OJCig1OfGzKF+Hjcc8MylSSZqY2oqmljsVIWr9npJoqe1YGRFIx4kBzOJ2lQaDwXaNl0+O3PTS1a85Zv5JWXeEUuRP3PRtXTnjHDG3Joml93kE2J2hmEUwgVjCZZLSKF/OaDKreKRkKyuW0NhnEpPT7R9DnytozkU++mW1uQK59gq2oCrcm5c1t2dCEh5AUdtaeQ4jW6u23cjLxuFoEDcRVnNVxP+kySfbOHPXrRe41wM7WwQBby28Zea84fH2uKYfXaquk2ATC4RbIBgrUQ4MZAyj8cUQbtyewPU9apZrxhDaFwpgaOzzJ7ro4TZcItmLRRHy4s82KhTZQtfS/X0bbPqX/Q9+SPaDUhtKBW5ZAu1NROQsA6OiXXyfjTf7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199018)(71200400001)(26005)(186003)(6506007)(6512007)(38070700005)(86362001)(107886003)(2616005)(478600001)(6486002)(54906003)(8676002)(4744005)(41300700001)(110136005)(8936002)(4326008)(5660300002)(36756003)(316002)(38100700002)(122000001)(66446008)(66476007)(66556008)(2906002)(76116006)(66946007)(64756008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1JuS0dyczNqWkI4UGJlU1hBTXpMcE1oK0Jza0RlV3YvWFRIeUtxQ1RtSmtO?=
 =?utf-8?B?T1hMTG50S3JHcytyYVV3RUQxNzBPdDVHdTlUOU9wTFFqRlEyNVhBcEcrVkNO?=
 =?utf-8?B?dEd6dGJYdFdwdVIxT25za01Ja1ptS2IvcnJUZlZ2d2o1SC91V0x3REo4NXM1?=
 =?utf-8?B?YU44dnM3aGlpVWEwVktSdkJuVHlCS25weElxL0trVU15MWFKaTU4WFRISm1R?=
 =?utf-8?B?bmc3aitIMG1NbzhmZUVHMDlxS1BtK2lvV3NvUmNJbkJMN0kwTnUyek9nQjAv?=
 =?utf-8?B?U2EvUnVuZktDNDhwZjMrbjZyVmZGbFdSditLaDlYdmxJQU51K1dmV1ZvS0th?=
 =?utf-8?B?NWJubzEzUEJlNDcxQzNwUlJjRW0xTFVzU3BqWjNCS3pYRWZLMFpuNm9XUUUz?=
 =?utf-8?B?RjZVZFdGS3kzNE1FWUNNc0dnVFRLTi9OT3BCQTRoT2RkZlhUK2k1RGlMNHdY?=
 =?utf-8?B?bEZJSHFKTUpId25mYzhaZDJ5aFNlU0Z0NUNCWXdXTTFJbm5xU3FLYk5ZSUtF?=
 =?utf-8?B?amZtNG55OGtIVW9zb3lQa25WOUhqZS95TmNKckg1NkpCWVJWakNLUjJtTm1Z?=
 =?utf-8?B?TVppRWNJUlk1OVFkOExXenNUSnZCa1IxWGlQbzhud0V6bW42WXAzcTkwdk05?=
 =?utf-8?B?cVZlcnJqTEk1N3d0bEs0clZZa0tJekFrTkpzeER6OUhsRkw1K0lHK0tTZGd1?=
 =?utf-8?B?MVJrbHFnK3NYYTV3QUcxN0RiL3I5QzZqa2haN2hkWlRHcmdPaEdIOUdYWFhZ?=
 =?utf-8?B?dXJIcGx6Q0tta1ErVGFqdzNvZjhodm4vb2NlbVNRZ1NFMEJWN1hkSnFNYmE3?=
 =?utf-8?B?bmZOQThBeGh6QnRlRW5Va3VMN2lRMmtNQ1NRR1NFT01CbXFyOW9jdDVHc3Bj?=
 =?utf-8?B?Y0k4bDNMUC9DYVFFUnhSREhNQ3JIaTV0cnVSQVo4Tm5KSE9FVXVacmFXTkNv?=
 =?utf-8?B?diszWEpWSm1PSXgwRk1TL1FIK1ZkZFlnTVBuQXZiZmdXZ0FiQXA5bTFFSDNp?=
 =?utf-8?B?K3V6R1p0TEN5SkpCNi8zaWt0TjUrUHdwUmVwQU5uSGNJcE1RTUk2cDNPTzZt?=
 =?utf-8?B?czV1ZHU4NXJKNlNONVhteVdyQ2FzdjhsNlhQcTBsN2UrUFV3NjZUS0tJcndM?=
 =?utf-8?B?QjM2TWhqNk9FS3liSFF6Zk5WTDQ0dGNwNWI0ak5UcGQvTzVvWHh6YUkzU0x6?=
 =?utf-8?B?b21aQ3JWQzhvczVUbWxhZjNIQ2dsRHlieENpWEN0WGNPQXhZc0t1SFdKQ0NY?=
 =?utf-8?B?TC9LY1kwanFTV3lIT20wbWQ0RGVSK2JwOVAzbm0zZjFNcE4ydHdIQ2gwVlN3?=
 =?utf-8?B?eVU3NUJHYTRJYTJWRHh3aTROY0NVSFg3K3Y2eXV5N1lyV2MxckdsTUlXVzNF?=
 =?utf-8?B?Z2RTd0ZpejVmbGhxbXM1eVF6MW1kMGVsZG1udktTM3lsOEw5UE5jc3NWSkhV?=
 =?utf-8?B?RFNkdTlpb3hobUcvQmV3SkI3TXZKaXliMFVWRWRhakFYY29lVmNtaUlVak00?=
 =?utf-8?B?RHZIK3o2M1lMS1R1Zkp3QVVpbS9wMlYyT3B2cnJYS0QvaUlMK1U4bFVjUVpP?=
 =?utf-8?B?MzZtK1NQZTJzc0RaWldoc1I3UndlZHFIYkQ2bG9oeEFleW5pcm9kaEdROUhW?=
 =?utf-8?B?eTEydEZGQzZ6ZlI0eXRBMERKUFcyZkRzRElPck9RS0pHY0RGTVoxRnNlTXZi?=
 =?utf-8?B?MjQvWU95STJaQmxvQXNXbTNpNGRydkc3dldzb0FBWmNoMGNSU24wY1p4N3pM?=
 =?utf-8?B?RXU1RVlORzJyQjExRWpUa1d1UWtrRy9Dd1lNUFdRZEdpTVV6MnVyeGd6WTg5?=
 =?utf-8?B?bHFKRHVZRCt6NkVFOGVTaTZJWklBOXhzZHU0RkV4dnB5MUEyNDRrRWtRd2VT?=
 =?utf-8?B?V2JrREtEanN6Rk94bVpBa0VBd1dKWWJGRGcxNVJOQ0UzWUhXelZaZkV2a3VD?=
 =?utf-8?B?bVBpcTgvQlVjS29UcFMyOThwM3pCSjY1U3BXZzNmYTVmTE9nTmd5NFJranZx?=
 =?utf-8?B?SmpxS250S1dPVEw4R1BjQURTMjh1OFJxdEdMWVB0eU1LbElOVENxODlQbFNq?=
 =?utf-8?B?YmRtYjh3Ync2a1NpWGI3WVI3M0RFaEUyM2Vsa2ZiMCtiQlRpdk1oOFF5b3Yw?=
 =?utf-8?B?Rk1ES2g1M3hwVGJhRFdKb3hjclFZNkRlVHFCdFpjTndFWm5uRmVEVlNJZ0RC?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71A177D8D93BF499870DB56B7EF6EB0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f21cfcb-405a-4de9-e7c5-08db10c85311
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 09:21:17.5618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAsq7sFiFKnu993TEE4/ZSRCq14ssFYozAsNGJoOlIpAJWHPxUCBcfEyMMcwy8BAvHHbgAeCZHKznQMgEPPTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTE1IGF0IDE4OjQyICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjMtMDItMDkgYXQgMDY6MDkgKzA4MDAsIFJ5ZGVyIExlZSB3cm90ZToNCj4g
PiBTaW1saWFyIHRvIFZIVC9IRS4gVGhpcyBpcyB1dGlsaXplZCB0byBwYXNzIE1VLU1JTU8gY29u
ZmlndXJhdGlvbnMNCj4gDQo+IFR5cG8gLSBzaW1pbGFyDQo+IA0KPiA+IGZyb20gdXNlciBzcGFj
ZSAoaS5lLiBob3N0YXApIHRvIGRyaXZlci4NCj4gDQo+IF5eIGhvc3RhcGQNCj4gDQoNCndpbGwg
Zml4Lg0KDQo+ID4gKyAqIEBlaHRfc3VfYmVhbWZvcm1lcjogaW4gQVAtbW9kZSwgZG9lcyB0aGlz
IEJTUyBzdXBwb3J0IG9wZXJhdGlvbg0KPiA+IGFzIGFuIEVIVCBTVQ0KPiA+ICsgKgliZWFtZm9y
bWVyDQo+ID4gKyAqIEBlaHRfc3VfYmVhbWZvcm1lZTogaW4gQVAtbW9kZSwgZG9lcyB0aGlzIEJT
UyBzdXBwb3J0IG9wZXJhdGlvbg0KPiA+IGFzIGFuIEVIVCBTVQ0KPiA+ICsgKgliZWFtZm9ybWVl
DQo+ID4gKyAqIEBlaHRfbXVfYmVhbWZvcm1lcjogaW4gQVAtbW9kZSwgZG9lcyB0aGlzIEJTUyBz
dXBwb3J0IG9wZXJhdGlvbg0KPiA+IGFzIGFuIEVIVCBNVQ0KPiA+ICsgKgliZWFtZm9ybWVyDQo+
IA0KPiBJcyB0aGF0IHJlYWxseSBhYm91dCBfc3VwcG9ydGluZ18gaXQgcmF0aGVyIHRoYW4gX3Vz
aW5nXyBpdD8gT3INCj4gX2VuYWJsaW5nXyBpdD8NCj4gDQoNCldpbGwgZml4LiBGb3IgdGhlIHNh
a2Ugb2YgY29uc2lzdGVuY3ksIEkgY29weS1hbmQtcGFzdGVkIGZyb20gVkhUL0hFDQpNVS1NSU1P
J3Mgc3RhdGVtZW50Lg0KDQpSeWRlcg0K
