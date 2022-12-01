Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424CA63E76E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 03:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLACCx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 21:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiLACCw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 21:02:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360025C5B
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 18:02:43 -0800 (PST)
X-UUID: 64da809d8a734dd9b820001bc1f1bc29-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HWTrXYwOjYNibe5wlYn7raRKm1zQI4fsrJia3OAxyWk=;
        b=nqA4gjho1u6+uLV2PG56lgnTE7/CZWnl+vD3xsuBiH82yr6jEKJZNj1mJaIdHMbb2UHuQom4x//anJ9GG8aDp5WV6Q85s3G/d5cG6kcWAfTqRUCO5vWnsrtu7JVej4TPhzG4FuPBQGCkpEl+P4NyLQpSGzxg+uGkw5sUC3Nt3cI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b485752a-670d-4557-8773-106f88edaa57,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:ea20cc1e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 64da809d8a734dd9b820001bc1f1bc29-20221201
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2112133030; Thu, 01 Dec 2022 10:02:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Dec 2022 10:02:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 1 Dec 2022 10:02:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feDUDBE44qiZUX1TCjdHIcAiL3lUZAmOuFnU9+7NwwL8sVgLVXyooyinU0kjBPBwVwNFP+OVtHXIgLYv4XZJIl/m+7jOfO1iQFyUPGVrArrOx6UbQv6sF4zg4JbF1oBh8tDmO56skR5RqoUV4YHpS5ZeG55mzYjvRtTogIwT/4ebZsbGcPflS/94LA7ArMJU5hC9jfDyioPPmj3zoYsHQXkibZ2pRrNA0Qj7r2UAEFsBa+dzr2tU6lbPsXdclq4YIsuDS15vCzlfGZEAPysp/0NRLKqpxznVwf6m2FE1ZjaV4CeNwu1OAon47anb8oEDr8Dl6og1TYDFS5Q5p21pUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWTrXYwOjYNibe5wlYn7raRKm1zQI4fsrJia3OAxyWk=;
 b=giaPwrfPKXxohaH/tscUjEv7OpQ4ldCxSWcyXr4pN7COrlPGybFrGqXw6ucuWjQ/CYN64EK2PL+qCQ01Wu9cTaC5mM67CehKvrMGHGiKgeNcGD+F2LIt31ZjYU0vpYu3Af+osgMeoNTkhsHECLCjUnxaHxdnh3gonxNxZiv4pJp/HwCPe0sAZNePDh1pjR6MdoBfN9OHY0YdgARNEJxBPSCai0TGUMKZaikbDu/tvU8PA8QJXm8QvH8TmxRunNidGtpqoo9zqZZ/ijgd1QUcOBTbfW1E4LLEY1LP6Vw6oj67lIwtL4wu5oKyZbLQegk+522dmdvJ+NxkTeLicfoNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWTrXYwOjYNibe5wlYn7raRKm1zQI4fsrJia3OAxyWk=;
 b=cznZAuFO/iBsixn0I/8THYSldnyVFnwpyiZun16ZLyesx4mzneCoPVy9IhXZHITwdMb5mkJ2YTBVtPreYTSrUwe5mnv9dWUQuKibSYocd9SX00Hqacx+nsKyQmPPP/IoJI2FpNz8YRRIqnaIDBzkGzUuoYMweppeMMsf36b0+fg=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 TYZPR03MB5939.apcprd03.prod.outlook.com (2603:1096:400:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 02:02:36 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9%5]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 02:02:36 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?WU4gQ2hlbiAo6Zmz5b2l5a+nKQ==?= <YN.Chen@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921s: fix slab-out-of-bounds access in
 sdio host
Thread-Topic: [PATCH] wifi: mt76: mt7921s: fix slab-out-of-bounds access in
 sdio host
Thread-Index: AQHZBMBjcDJXFCmH9Eyn5erWHic5rK5Xi5kAgAAQOwCAABeugIAAlO8A
Date:   Thu, 1 Dec 2022 02:02:36 +0000
Message-ID: <1141267dffdb7556ca03ae6a150de06dc47a6db0.camel@mediatek.com>
References: <631e6a06fb640ec4f81c92b57d31eb0f7b23c351.1669814212.git.deren.wu@mediatek.com>
         <Y4dsznJ+GBalfzvx@lore-desk>
         <5b41c02ace6538122ebd656db5bec748fcd6e14e.camel@mediatek.com>
         <Y4eOSUzLAW8x802i@lore-desk>
In-Reply-To: <Y4eOSUzLAW8x802i@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|TYZPR03MB5939:EE_
x-ms-office365-filtering-correlation-id: 2e7e8a56-bdeb-40d4-992e-08dad3401e33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXeoiJ1iWpJeJhEcHY1oD9xksLnSv6yLAv34vlGBhBhZoBjzms997nVPTOjXRUqauqInCAbo3XTbsfS+mUagTATWWKeJYKAe9HZ9gtgVyFoPiaQxNOkLVDXNBIY1ejd6AtCzewpv7LLXZZXf/OR3zmPbi5u+DAb9oLd6g2BQSm2Dbk6Qc2O6sN4Dr+mjRRITnY/KIq/xsXSzK8bysTl9dm3vQPpWniPM8vgOWVMmy72opHCvGebh9bUCwGlifyF7cWfDyAGbn1vfav9AmknHM33KjhVs64vF+/UU1yhIQZ60bfcCbgsfOtidZ5xifzm3bNI35YuqfWDZ/lkvu4JLrVUCuhMoS741AQ6ZWD+ksUwA8gD7g6LAQ5zt1IPAQ1oxJq0hNmptlXJBPwxwAXF2VlG22q9dRRY1mtE3nELvdEd11ShTxXJMyWvz5fyOc5VkGoO3G7NeuuaTq86LAePKBZmINtGqY5HIPzANCCeAAGNYKlQylh+s1MrU8Fo515GmjbX4YvBzZYKMTNbdjcXdj+o3kaAVjKtemrYkk3K3lUQqUykKeGRjpeR3jYvwYl+SR3Qi5fOHnt/K937g0aliyVqbogievgzcDc9NRB9IFmMO2lhuCJFH8ZSxTGWmRg0e71/uS2aBzIl3cxJ143fN0g+YheTcbNsg6XYdAwQsVluW+p9ERbiHNjhotVOO8y3Q4fk6kb2FkMbwwKg8BWpJAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(66946007)(86362001)(38070700005)(66556008)(85182001)(186003)(122000001)(66476007)(66446008)(41300700001)(36756003)(8676002)(6512007)(4326008)(64756008)(5660300002)(8936002)(71200400001)(6506007)(6486002)(478600001)(316002)(6916009)(54906003)(2616005)(76116006)(38100700002)(26005)(4001150100001)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEVXc0twNzVQc1BpZ0FlK2pLUjhEQzI4dkFSN3dnTjFqYlZhY3lVTnlOUG55?=
 =?utf-8?B?dlRuTXRtakVIZkFSbHB6WWJtM2liNFc2b1gyWmVkVXZ2YyszS2lidHdPbFJu?=
 =?utf-8?B?MjRWZ0puMFBXRjZySzhJV1FMdmhFcUViNnpVUjJORllKeUhBNlVOcGYxNnNP?=
 =?utf-8?B?cW5HN1R4UzBERlMrZWc2RC91ZzBxNHFVK3A0SjFQdUNycUI2YS9PNmVoeEdN?=
 =?utf-8?B?M3RERWd0M3dwNXFUUlZZZGV1TEpQc0FTSlRDbmVUYVhBUjJxVWt5MGdqMVlm?=
 =?utf-8?B?cUtxVjdOSW5sSTVZQjRHRCtMaUpyZndscTRuTUxHYWNQSkttS0hlM0owZUhS?=
 =?utf-8?B?b0h6bjgrYkZ6c2xJWXJEYlNBSlRIM1R4U2xZUnc2M1ZGTGZYelVEaXV6cHBH?=
 =?utf-8?B?NWtVSVJMTThwcDhYQ2JHOGdPU3k2cDhRTDN0UG9RS0lSUVF5dStmYnluamp3?=
 =?utf-8?B?MnNTaDZKR3pweDNBQXp6cC9WOUU3WFNxckFsZzRSbEd2NCtXcS9DRlVxZ3Iy?=
 =?utf-8?B?b2hYbTZZbUlQMldZeFNaaEtQcTIxNzVkVUJ1S3EzVzdjNlp4YzJtRFJQQUsw?=
 =?utf-8?B?Y0VRK091NC9RZ0dyTkRFZURDeDBPNjI3a2ZOaUs1cE9TSlYzS1JrYXZNaDVj?=
 =?utf-8?B?dHhUVDhjQzloV3RmTEwrMjhPamNJQUlkV0ZJZUxYbTNYQ29Vc1c0OTI1cHV3?=
 =?utf-8?B?d0dTMWh3TFpSS2FaL1gzczJjZ0ZwejhHRXBQMHVDRVlQbUNnOWNLWkpxNUFZ?=
 =?utf-8?B?d2lqOGhiVHJmUFpHUjk2Z1YwaWZKN2o2L1I3NGR4VXVSOTdZYzgwdFpLaE5F?=
 =?utf-8?B?Sms2UStkaFF3QXgrb0FEamoyWmhBbnB3OEtxTEI0TVFjZ0tBNjBBQWZuUDJV?=
 =?utf-8?B?T1praHNnVkljZWQvM2JKS1l2bkhkYVg4bjRxSkpjYlQ0TWhqeWlSYnh0TXJs?=
 =?utf-8?B?SlpVVWpqRW1UZFhJYTBBQWZXY1hrNnJlem1veFliUW41TzV0L3lWT0VjYUxY?=
 =?utf-8?B?ZTNkZVdFN21RSkJESExveXRrYWVrdG4wV2V1VnkyYkdZdGVPR2ppeDNUZDRE?=
 =?utf-8?B?TSs2d200MnMwbElPSjFlQ3d0UUpEMmlZM1dNcjlrQjBOb1ljNG0vT1pmelJW?=
 =?utf-8?B?bkJnRUJ0RUVQby9QTWNKbGtuVmFYQlR5djNNV3dtQk5SelErcXRGY2RuQy9k?=
 =?utf-8?B?NGVEQUswTytDTDZyUHdUaVcydVpSMmNWOTFncjMwN0tvcXh4OUY4b1ZLZitY?=
 =?utf-8?B?UzhWQWd5UUF2dURTRUZxOHhDRXRDVVB2TklQZklPS1pET3pjWENVNVRDMmFs?=
 =?utf-8?B?aWErR0diQnB6VEEyNFpSOU1JVVpmeXlqQ2JUYkZLSk84RUE3dEwxYmR2NTQy?=
 =?utf-8?B?bnd2WkhMeEFaT2plakJjSjE4RlF0Z0dXeHIzeHBWU3o0U0gxUGF6SGJodU1W?=
 =?utf-8?B?b28xeWM1a08yVE5qOVhZTkJXV3lhTG5QM2JUa0phK3YwTWFack1wYlFFVG5G?=
 =?utf-8?B?YkFEb1RYc1BMZHBGWDV3d1RrckZJemVxTTFuaHpiV1QzSzFtUUlKK0hEeDY3?=
 =?utf-8?B?TXBuNThYRzFFYjRtWEdETFdPWG02eERjSHJ0TzNBVW5wTFVnZythZ2UwaTRj?=
 =?utf-8?B?SWt1a2Y1VVRnNWtiRGJ4S3Nna0J5WmVqTWtmMURCc1d5dTUzZGFkTDdIcnNC?=
 =?utf-8?B?MENMOFQ4OEVkQUhmbEVVMUtybkYrUFFQSnJZNXhjM2JvdHNlcmpmb21XdWxV?=
 =?utf-8?B?c0U5cjhmZjZNblo0VHVZQXZ5d2ZVWkNUeWRBMk5QTDhFRGkxMDZoVHFCcVhk?=
 =?utf-8?B?cGNyMkJCWFo5UWVoUE81Z1JFSDB1VU56REZqNU1XVUpwZ0VJYWtSRkhPMVdr?=
 =?utf-8?B?cWxMWmtWTTBYekJ2WHhVK1BjNEdVeVFIbFR3b1ZIbjBjOXltS2ZQS2d5M0Zy?=
 =?utf-8?B?a05MTUZpL2l2emd4MS82MjZBNURLa01jZ1pnT2lCQlFmSkdBTDJjcVk3ejhP?=
 =?utf-8?B?aFJXalpuRXYxb2RzUjBhdUtWeGU5THU1aVFYU1BYN1VHQ3oxZmt5NEtlQ09k?=
 =?utf-8?B?VEp3QTFzeW43OVMveExqcEhKMFl0SEJ1Y3hQWUtNZGFPNFRBZDA2TmFEcU5G?=
 =?utf-8?B?dUpLRjU2K2VxQS9ZSENWMnU1Z0UzR3BsR1FJS05QNS9CQ3Ryc2dSWkNnSk45?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03A16839445C6B4A9E6DA2AAD3A76F4B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7e8a56-bdeb-40d4-992e-08dad3401e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 02:02:36.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01ps9qz3ry8zjNnQqeFMHNdzJ6dFJwHQwaFktnviZnK0QuExXAh9tYeiVOVdpgY69/Ks5SEwBSF6XPJSV+o28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTMwIGF0IDE4OjA5ICswMTAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+ID4gSGkgTG9yZSwNCj4gPiANCj4gPiBPbiBXZWQsIDIwMjItMTEtMzAgYXQgMTU6NDYg
KzAxMDAsIExvcmVuem8gQmlhbmNvbmkgd3JvdGU6DQo+ID4gPiA+IFNESU8gbWF5IG5lZWQgYWRk
dGlvbmFsIDUxMiBieXRlcyB0byBhbGlnbiBidXMgb3BlcmF0aW9uLiBJZg0KPiA+ID4gPiB0aGUN
Cj4gPiA+ID4gdGFpbHJvb20NCj4gPiA+ID4gb2YgdGhpcyBza2IgaXMgbm90IGJpZyBlbm91Z2gs
IHdlIHdvdWxkIGFjY2VzcyBpbnZhbGlkIG1lbW9yeQ0KPiA+ID4gPiByZWdpb24uDQo+ID4gPiA+
IEZvciBsb3cgbGV2ZWwgb3BlcmF0aW9uLCB0YWtlIHhtaXRfYnVmIGluc3RlYWQgb2Ygc2tiIHRv
IGtlZXANCj4gPiA+ID4gdmFsaWQNCj4gPiA+ID4gbWVtb3J5DQo+ID4gPiA+IGFjY2VzcyBpbiBT
RElPLg0KPiA+ID4gPiBOb3RlOiB4bWl0X2J1ZiBpcyBiaWcgZW5vdWdoIGZvciBzaW5nbGUgc2ti
IHNpemUNCj4gPiA+ID4gDQo+ID4gPiA+IEZpeGVzOiA3NjRkZWU0N2UyYzEgKCJtdDc2OiBzZGlv
OiBtb3ZlIGNvbW1vbiBjb2RlIGluIG10NzZfc2Rpbw0KPiA+ID4gPiBtb2R1bGUiKQ0KPiA+ID4g
PiBUZXN0ZWQtYnk6IFlOIENoZW4gPFlOLkNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEZXJlbiBXdSA8ZGVyZW4ud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvc2Rpb190eHJ4LmMg
fCAzICsrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvc2Rpb190eHJ4LmMNCj4gPiA+ID4gYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L3NkaW9fdHhyeC5jDQo+ID4gPiA+IGluZGV4IGJmYzRkZTUwYTRk
Mi4uZWJlYTVjNGU4ZGE1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L3NkaW9fdHhyeC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvc2Rpb190eHJ4LmMNCj4gPiA+ID4gQEAgLTI1NCw3ICsyNTQs
OCBAQCBzdGF0aWMgaW50IG10NzZzX3R4X3J1bl9xdWV1ZShzdHJ1Y3QNCj4gPiA+ID4gbXQ3Nl9k
ZXYNCj4gPiA+ID4gKmRldiwgc3RydWN0IG10NzZfcXVldWUgKnEpDQo+ID4gPiA+ICANCj4gPiA+
ID4gIAkJaWYgKCF0ZXN0X2JpdChNVDc2X1NUQVRFX01DVV9SVU5OSU5HLCAmZGV2LQ0KPiA+ID4g
PiA+cGh5LnN0YXRlKSkgDQo+ID4gPiA+IHsNCj4gPiA+ID4gIAkJCV9fc2tiX3B1dF96ZXJvKGUt
PnNrYiwgNCk7DQo+ID4gPiA+IC0JCQllcnIgPSBfX210NzZzX3htaXRfcXVldWUoZGV2LCBlLT5z
a2ItDQo+ID4gPiA+ID5kYXRhLA0KPiA+ID4gPiArCQkJbWVtY3B5KHNkaW8tPnhtaXRfYnVmLCBl
LT5za2ItPmRhdGEsIGUtDQo+ID4gPiA+ID5za2ItDQo+ID4gPiA+ID4gbGVuKTsNCj4gPiA+IA0K
PiA+ID4gKGV2ZW4gaWYgaXQgaXMgbm90IGNyaXRpY2FsIGZvciBwZXJmb3JtYW5jZSkgaWlyYyB0
aGUgc2tiIGZyb20NCj4gPiA+IHRoZQ0KPiA+ID4gbWN1IGlzDQo+ID4gPiBhbHdheXMgbGluZWFy
LCBJIGd1ZXNzIHdlIGNhbiB1c2UgX19za2JfZ3JvdygpIGluc3RlYWQuIFdoYXQgZG8NCj4gPiA+
IHlvdQ0KPiA+ID4gdGhpbms/DQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBMb3Jlbnpv
DQo+ID4gPiANCj4gPiANCj4gPiBfc2tiX2dyb3coKSBsb29rcyBnb29kIGZvciBtZS4gSXQncyBh
IGJhbGFuY2Ugc29sdXRpb24gZm9yIHRoaXMNCj4gPiBjYXNlLg0KPiA+IElmIHlvdSBoYXZlIG5v
IGNvbmNlcm4gYWJvdXQgdGhlIHBhdGNoIGJlbG93LCBJIHdpbGwgcG9zdCB2MiBhZnRlcg0KPiA+
IFVULg0KPiA+IDopDQo+ID4gDQo+ID4gICAgICAgICBpZiAoIXRlc3RfYml0KE1UNzZfU1RBVEVf
TUNVX1JVTk5JTkcsICZkZXYtPnBoeS5zdGF0ZSkpIHsNCj4gPiAgICAgICAgICAgICAgICAgX19z
a2JfcHV0X3plcm8oZS0+c2tiLCA0KTsNCj4gPiArICAgICAgICAgICAgICAgZXJyID0gX19za2Jf
Z3JvdyhlLT5za2IsIHJvdW5kdXAoZS0+c2tiLT5sZW4sDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNkaW8tPmZ1bmMtDQo+ID4gPiBjdXJfYmxr
c2l6ZSkpOw0KPiANCj4gY2FuIHdlIG1lcmdlIF9fc2tiX3B1dF96ZXJvKCkgYW5kIF9fc2tiX2dy
b3coKT8gRG9lcyBzZGlvIGNoaXANCj4gcmVxdWlyZSB0aGUgNA0KPiBsYXN0IGJ5dGVzIHRvIGJl
IDA/DQo+IA0KPiBSZWdhcmRzLA0KPiBMb3JlbnpvDQoNClRoZSBjaGlwIG5lZWQgcGFkZGluZyA0
IHplcm8gdG8gYWxpZ24gYnVzIG9wZXJhdGlvbiBhbmQgd2UgY2Fubm5vdA0KaWdub3JlIHRoZSBw
cm9jZXNzIGhlcmUuIEkgdGhpbmsgd2Ugc3RpbGwgbmVlZCBib3RoIG9mIHRoZW0uDQoNClJlZ2Fy
ZHMsDQpEZXJlbg0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gICAgICAgICAgICAgICAgIGVyciA9
IF9fbXQ3NnNfeG1pdF9xdWV1ZShkZXYsIGUtPnNrYi0+ZGF0YSwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZS0+c2tiLT5sZW4pOw0KPiA+IA0K
PiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gRGVyZW4NCj4gPiANCj4gPiA+ID4gKwkJCWVyciA9IF9f
bXQ3NnNfeG1pdF9xdWV1ZShkZXYsIHNkaW8tDQo+ID4gPiA+ID54bWl0X2J1ZiwNCj4gPiA+ID4g
IAkJCQkJCSBlLT5za2ItPmxlbik7DQo+ID4gPiA+ICAJCQlpZiAoZXJyKQ0KPiA+ID4gPiAgCQkJ
CXJldHVybiBlcnI7DQo+ID4gPiA+IC0tIA0KPiA+ID4gPiAyLjE4LjANCj4gPiA+ID4gDQo=
