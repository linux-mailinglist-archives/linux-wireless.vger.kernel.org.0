Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2939763D9BC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiK3PpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 10:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiK3PpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 10:45:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7AC81D9F
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 07:45:00 -0800 (PST)
X-UUID: 30708286b6534f3e999e09cfc34d01da-20221130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=L8RHFi4AkG5Wqzi2VIYHybDJEHMf4iXNT3B9gnefXHg=;
        b=nk8k/mc1akmngn8bIYhpyXjsgSPFeL6olmlIIkbpbqTWhH10XZ+4/ELs6cLiKWZhn4UuggKtcGMFYs7wisuQMZCbuIaXIN6Ab1f0YA9nCJy4b2mHISJDcLKQlAh/rzT2TN4UU02yFsOSeIEbYEvor6/aBQ5Nt1HP9T1ak6fHPdc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:22521f8b-b462-43de-b2f7-00f02de5a331,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:22521f8b-b462-43de-b2f7-00f02de5a331,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:c5a5c21e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:221130224648H7AAX1GR,BulkQuantity:3,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 30708286b6534f3e999e09cfc34d01da-20221130
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1107752405; Wed, 30 Nov 2022 23:44:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 30 Nov 2022 23:44:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 30 Nov 2022 23:44:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3eUbueW0MnG6GUHThFjibWkIz8BqDTMqQ+IN12wm+hdLXXw8WHoHZwXCO9ZbBMn5DHa0FAieVqeEFUzJHWB9p8hPeMQGpS4GH6R4Q9W73LI1eU5+kgFj4SM+embzjn+3Mh8yo4u2Ozg8wLc7qdNRff3yuO5H2/UUuanuosd7YwzjszO89RqRJvDlQkOhFbrdHvSG3LXScQ1Rd052d9NofufnAc7jIwizBDWfDYl8pgWIUlLsYrneIQqt+sZNtw8nn4VGrvw8CHX+qaBW77kQHqI99G5VO/O4OOd1Wi3ylpVvxIVAHVYulvpPyASE2jSe34R/TAnq38/xix8On37Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8RHFi4AkG5Wqzi2VIYHybDJEHMf4iXNT3B9gnefXHg=;
 b=GGtNK4LrIdy+YVEEvFkZ1FjYTNAp0IlCFMdumhnYPItPUzZJcQxzljY3ELiAe96UfAFCZRE6EkB7fKHMHBeNvTl+YOmQeynYcoOeo29DWWXcRPUh7eitJFBxLNxByNwfgy6MCotHTCF3Awb6iBzGOvTMna5FdICikwfDxOPOlA/q+n5CnHG7ofx7hPyUAzfB3Bz7mrrICucZLK4kEauyiupla/1ZtB0xNn/v8Uhn5tXzgrUrs9N1rM5CqZKg5WocjzyVcWAsQL8YjSv4sYfyqz4irj5W688k01UJYHtA+CPThKayN0D68EQ6WLbGocmH4OHCKh3dkk9/RqI0zLfJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8RHFi4AkG5Wqzi2VIYHybDJEHMf4iXNT3B9gnefXHg=;
 b=Xy9kL3KcGOQzffYMeX2ctXfXPgFkPrqL8zd2cCbCkxgpsAxyd+A8UNjSEjgX1p4uGcQQTfQ5hwBf/SSAxj8AzWP6JaomdfbHg+ZkNRWqFDcqxsPK6rTL87R7i2J5DIe/0Z8tB6mvPPXprg4ah7xOb9YO0Zw3mXdBOfjf+gZTs/E=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 TYZPR03MB5373.apcprd03.prod.outlook.com (2603:1096:400:3f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 15:44:48 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 15:44:48 +0000
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
Thread-Index: AQHZBMBjcDJXFCmH9Eyn5erWHic5rK5Xi5kAgAAQOwA=
Date:   Wed, 30 Nov 2022 15:44:48 +0000
Message-ID: <5b41c02ace6538122ebd656db5bec748fcd6e14e.camel@mediatek.com>
References: <631e6a06fb640ec4f81c92b57d31eb0f7b23c351.1669814212.git.deren.wu@mediatek.com>
         <Y4dsznJ+GBalfzvx@lore-desk>
In-Reply-To: <Y4dsznJ+GBalfzvx@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|TYZPR03MB5373:EE_
x-ms-office365-filtering-correlation-id: 389e72ad-53c3-43fb-9a79-08dad2e9cffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5ZLFMZSrhAQNkDQr94w79c0CvYfwwggimq9a7yj3Ou42gNnaia04DoG3fx0db1JwulTZDg/xdhrww/UXkWrOsMwn0TqW/iXv9UuvlE8dgz6PKQakJ7/Mp/YxCnlaoTJgJHaF32hMTq6j3UjJq7HMh4AB1xtrP22Qw+DHxeyshi4fhRWZHw9x5tpj2Sb3PZRjt6SmBFVRDMLJkbIkJDb9PK0oTeMb4hST86BtJV7WBKuhV78LVkaapJJY21MEDKpDUi3/fnmcrIaZx1xOkFC2l6mJUq23TNDQePgfSWqi5FgJC6UHaWAQndbB3wvSeEAf540gNix05rxMe+grpE1mc+67+uY0V/X4G29lrTgeF1/diAfEnShSnWa2TmaJHlQBswewCFFSrSI1ZWKUNpVOrxQAShl934rZCltZTSdMau85W/+sNgj47znMPbnFgwWQCPETz2uzBqunXEPIwRzMwcZATUVjpEYqhHuIcEL1KEQXxAraAhzsz1G/+hC4zqE5/hRrI32BIzlodCSoWsIKrR3hPeV7jXqJDYNoL/fj7mkJaGSrsgfn4LAn3jhTeuH8SoTiKyP2YPqlZdwNht8hib6TBV8NbFXk7l2d9rW5lXIkhsbDfN9QPxXeHl3hrP1HaDNwojvbtBg9nCB6rGP4ACt5wljU9exP/d0jB+OOWvrJqAYEmOI5xoPJ444QOj5Oy4GMseRY5e5yz6uhDv5ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(6486002)(38100700002)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(41300700001)(4326008)(478600001)(8676002)(316002)(36756003)(2906002)(54906003)(6916009)(122000001)(4001150100001)(8936002)(38070700005)(5660300002)(86362001)(85182001)(2616005)(186003)(83380400001)(71200400001)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEVtQ1FRVzBEMDh5V2VHbU9OZzhDM2tqY2pFaExOOXpHRitWeFZRby8yK3pC?=
 =?utf-8?B?dXBvcVJKNG5GenhFTEVCbDczakRUN0ZJMit5L3R2blc0b2phM3dJenZoNFI0?=
 =?utf-8?B?WmRmN2QxSi93aG8yL1R5dWc0NEUwRTBtYkNmUllzOTFicmpQRTVmaFRIOEtY?=
 =?utf-8?B?QkhtZ0FkM29DMGdvM0ZnOGFjVGxLNlRmdndDK2ZxTW5TSnNKaEpNcmVqWWJa?=
 =?utf-8?B?ZmJVWFc3UzFqSDN4VXVKVG5GT2d1dWo3OEpZR0lsNmlLNGF0aGdOaXRCMkRF?=
 =?utf-8?B?OEhDZEh6SXl2TUZRaFlvbm96cjlWOUgvMVNmcVYrdkZIRmpjR1o1UzZGQVUw?=
 =?utf-8?B?eUFnZk1MYXVuTEJIWUtSb3V3STU5eEE1WjB1OHRwdXhDMTVYdkJVaW5yWVYy?=
 =?utf-8?B?UkhHc0dZb2JGVjZnM2hOMUJSNTdXUTV6Z0c3d0RGZndVaTlzb3AyOUdvcTVR?=
 =?utf-8?B?bFZKNXNySjRXaVpVYVJOMnYxeE92ajNTY3g1ZU1saXgwZ2JzT3J0TnlZVmsv?=
 =?utf-8?B?RFdZWXlyQWN4QkU3WndIU0JqeDROODM3UlZzaGdNN3NvQjdxS1E2MjRnd0Nm?=
 =?utf-8?B?TGROeU9zdDRyTFBBYkRZTWVxcXJFdnhqMnYrU1phbWlPcUtVZ2ZNOW5OVzdW?=
 =?utf-8?B?N1ZnUlRHNFJ5RklOZ1Y2Z3dHajBQT3R4dmgzK091Y2t4SXdyQlQxUWtRVnc2?=
 =?utf-8?B?S2lEL1FRTjAzVkZaVnNaakVjdU5QZnlCa1NvSXNjbGdyQmIydlpybFd6cTRj?=
 =?utf-8?B?dXI1RVl6ZTlaWTRjRHBBQkMvRm1zY1VXK2hRUktvTlpxYWJ6clhMVnFtZ1Bi?=
 =?utf-8?B?VjUxeGtORUlwcWRUNEJjcWRUaHhqemtZeG5NbS9rbWRBV083K0UwaW02Nlp1?=
 =?utf-8?B?ajhPUjgzZzhQZ1hxMzBWY2JleW5Pbmo3M3ZNbXBVUTV6Kzd5VmFMQU5QaC9Q?=
 =?utf-8?B?aElGNjFCTUNQaHpHZk1uU2Zub0xqTzFyYm9MR3k5czYyc25FeVA5cnd4RGwz?=
 =?utf-8?B?ejVXYnFCajBTeGhyckEwbU9kdkg2TkFRQXlsYUdzekVIM0J6UFMrR3BWUEJG?=
 =?utf-8?B?ZmxONXNkR0tCS1hvVzJHOGtGYnQ1Qm96RWxlVzlrclYrbzFucUc2OXk0VC9Y?=
 =?utf-8?B?aTdvNnYwQ2dTM1RKTWIwWDdsYUE1MEFFUzdkMTBFaTZzMzhQMG15MVI5dGl4?=
 =?utf-8?B?ajVYQS9SSHFkVnh0ZC9oRDNCYVZIbHNZQ1N2dlZqQUlLT1R1MlFnOXZIYkNk?=
 =?utf-8?B?YWV3NlIvOU5yMVUvZmM2SjZUQ0p5dWJPcktuZFBVYjZqMUxoWEpSdUNBbVky?=
 =?utf-8?B?SEZyZ0hKc0lFRXliZytycHJ3TFNkdUlFTlhzK0hVeStRcDYyeUc0b2g1b2VP?=
 =?utf-8?B?bFZub0RxcU1GWVVQTWpFY0w0bkVCc01UbzQzMkswb0NwalNSS0dxUkpZbjBM?=
 =?utf-8?B?cS8zRWlXa2ZEcVhWTVFRejJob1MwSFhiK2Q1WWdyTE1TSnpIWkY0R2krZ1FX?=
 =?utf-8?B?L3E4TjNWL3FWWnlKbFRrM3pLMnhMMFF6emw4K1BwcC9zdWsxcDhZaXRCY254?=
 =?utf-8?B?RW9sV0l6QmF0ekhRTzR0TWc3MEZHenA5SU5COEpoMC8ybGMrY1hEYkV3dVJl?=
 =?utf-8?B?L0NsRW96dzdJSUorbWphclJaVk5aaldtTzEwdVhqOWFzVUdKQk5nMUVLREF2?=
 =?utf-8?B?NHRhQzFpamsxSWF1VWNDWE5pdEFCSFJxY2NnNXFyc3ZOU2loWHZqak1rZ1FT?=
 =?utf-8?B?SUN6amZ6RHhYK0QrdmdrcDdDRVhjcHYxQjFWSlcyeGdSRm0xREwwSDdCcldW?=
 =?utf-8?B?NTFFMS93U2pRYkU3RTNVY0VsQVc5eWF6STVwcFBSRExNRzVGc0t5TTVTYXB3?=
 =?utf-8?B?MngzNTc0bjcwN3ZQWm1RNkdGU0o2a1o4VDZuZFgvY0o1VzNaYWRWbndvQTVP?=
 =?utf-8?B?OSsrYkZwVW5rMnlxMWtWaXRKRUFYYzE3TE1tTHRFOXROTVRHeG5JNHA3cGNN?=
 =?utf-8?B?MjFnM0pDL1VIVFo1T3lDRHoyLzMxSk1JR0Jwdk52VWh5cmNCNVg0WnAxcXNG?=
 =?utf-8?B?MEFBbmRXZU4rNjdrUFZSOXdsSUJHSFVFSERhRHhvbHd2TGNtM3BuTUFoaFBU?=
 =?utf-8?B?SWNqZkxrYk9nOU1vRGJMa3hJV3Vldlo5V2V5SmdBWXFtRmMxdUdOZ2pGd1lH?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <532F495822F1B94B9E6DA0E3BB68F77B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389e72ad-53c3-43fb-9a79-08dad2e9cffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 15:44:48.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/MrH56DsHW5rZcUEYNgXmJTXRbO4Xn+2QkRonlYTW5c1uRhLY5DjWwKtesboNh+kFw+FbYZMqLncPevpPTOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5373
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTG9yZSwNCg0KT24gV2VkLCAyMDIyLTExLTMwIGF0IDE1OjQ2ICswMTAwLCBMb3JlbnpvIEJp
YW5jb25pIHdyb3RlOg0KPiA+IFNESU8gbWF5IG5lZWQgYWRkdGlvbmFsIDUxMiBieXRlcyB0byBh
bGlnbiBidXMgb3BlcmF0aW9uLiBJZiB0aGUNCj4gPiB0YWlscm9vbQ0KPiA+IG9mIHRoaXMgc2ti
IGlzIG5vdCBiaWcgZW5vdWdoLCB3ZSB3b3VsZCBhY2Nlc3MgaW52YWxpZCBtZW1vcnkNCj4gPiBy
ZWdpb24uDQo+ID4gRm9yIGxvdyBsZXZlbCBvcGVyYXRpb24sIHRha2UgeG1pdF9idWYgaW5zdGVh
ZCBvZiBza2IgdG8ga2VlcCB2YWxpZA0KPiA+IG1lbW9yeQ0KPiA+IGFjY2VzcyBpbiBTRElPLg0K
PiA+IE5vdGU6IHhtaXRfYnVmIGlzIGJpZyBlbm91Z2ggZm9yIHNpbmdsZSBza2Igc2l6ZQ0KPiA+
IA0KPiA+IEZpeGVzOiA3NjRkZWU0N2UyYzEgKCJtdDc2OiBzZGlvOiBtb3ZlIGNvbW1vbiBjb2Rl
IGluIG10NzZfc2Rpbw0KPiA+IG1vZHVsZSIpDQo+ID4gVGVzdGVkLWJ5OiBZTiBDaGVuIDxZTi5D
aGVuQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZXJlbiBXdSA8ZGVyZW4ud3VA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L3NkaW9fdHhyeC5jIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3NkaW9fdHhyeC5jDQo+ID4gYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L3NkaW9fdHhyeC5jDQo+ID4gaW5kZXggYmZjNGRlNTBhNGQy
Li5lYmVhNWM0ZThkYTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9zZGlvX3R4cnguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvc2Rpb190eHJ4LmMNCj4gPiBAQCAtMjU0LDcgKzI1NCw4IEBAIHN0YXRpYyBp
bnQgbXQ3NnNfdHhfcnVuX3F1ZXVlKHN0cnVjdCBtdDc2X2Rldg0KPiA+ICpkZXYsIHN0cnVjdCBt
dDc2X3F1ZXVlICpxKQ0KPiA+ICANCj4gPiAgCQlpZiAoIXRlc3RfYml0KE1UNzZfU1RBVEVfTUNV
X1JVTk5JTkcsICZkZXYtPnBoeS5zdGF0ZSkpIA0KPiA+IHsNCj4gPiAgCQkJX19za2JfcHV0X3pl
cm8oZS0+c2tiLCA0KTsNCj4gPiAtCQkJZXJyID0gX19tdDc2c194bWl0X3F1ZXVlKGRldiwgZS0+
c2tiLT5kYXRhLA0KPiA+ICsJCQltZW1jcHkoc2Rpby0+eG1pdF9idWYsIGUtPnNrYi0+ZGF0YSwg
ZS0+c2tiLQ0KPiA+ID5sZW4pOw0KPiANCj4gKGV2ZW4gaWYgaXQgaXMgbm90IGNyaXRpY2FsIGZv
ciBwZXJmb3JtYW5jZSkgaWlyYyB0aGUgc2tiIGZyb20gdGhlDQo+IG1jdSBpcw0KPiBhbHdheXMg
bGluZWFyLCBJIGd1ZXNzIHdlIGNhbiB1c2UgX19za2JfZ3JvdygpIGluc3RlYWQuIFdoYXQgZG8g
eW91DQo+IHRoaW5rPw0KPiANCj4gUmVnYXJkcywNCj4gTG9yZW56bw0KPiANCg0KX3NrYl9ncm93
KCkgbG9va3MgZ29vZCBmb3IgbWUuIEl0J3MgYSBiYWxhbmNlIHNvbHV0aW9uIGZvciB0aGlzIGNh
c2UuDQpJZiB5b3UgaGF2ZSBubyBjb25jZXJuIGFib3V0IHRoZSBwYXRjaCBiZWxvdywgSSB3aWxs
IHBvc3QgdjIgYWZ0ZXIgVVQuDQo6KQ0KDQogICAgICAgIGlmICghdGVzdF9iaXQoTVQ3Nl9TVEFU
RV9NQ1VfUlVOTklORywgJmRldi0+cGh5LnN0YXRlKSkgew0KICAgICAgICAgICAgICAgIF9fc2ti
X3B1dF96ZXJvKGUtPnNrYiwgNCk7DQorICAgICAgICAgICAgICAgZXJyID0gX19za2JfZ3Jvdyhl
LT5za2IsIHJvdW5kdXAoZS0+c2tiLT5sZW4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2Rpby0+ZnVuYy0NCj5jdXJfYmxrc2l6ZSkpOw0KKyAgICAg
ICAgICAgICAgIGlmIChlcnIpDQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0K
ICAgICAgICAgICAgICAgIGVyciA9IF9fbXQ3NnNfeG1pdF9xdWV1ZShkZXYsIGUtPnNrYi0+ZGF0
YSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlLT5z
a2ItPmxlbik7DQoNCg0KUmVnYXJkcywNCkRlcmVuDQoNCj4gPiArCQkJZXJyID0gX19tdDc2c194
bWl0X3F1ZXVlKGRldiwgc2Rpby0+eG1pdF9idWYsDQo+ID4gIAkJCQkJCSBlLT5za2ItPmxlbik7
DQo+ID4gIAkJCWlmIChlcnIpDQo+ID4gIAkJCQlyZXR1cm4gZXJyOw0KPiA+IC0tIA0KPiA+IDIu
MTguMA0KPiA+IA0K
