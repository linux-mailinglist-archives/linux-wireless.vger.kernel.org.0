Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC869B27C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 19:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBQSnj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 13:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBQSni (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 13:43:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17E10F9
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 10:43:33 -0800 (PST)
X-UUID: f892d716aef211eda06fc9ecc4dadd91-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8DsM4kGo68KYFgyIyzbc00/44lhqYSdqyfGUkkZ28tI=;
        b=P8Ap9t+JKTs178RCQc38xUHZWW3R/uYmp39PfisGsLqxS7V6tIwlQkymZJLOARqhYu4T/huzJJxQ6xW+uqFlO1+WrIGsAaHHaQLq2bA2NFwnZg9fiLVuVpsdAl0icCeDuTWF4j6bo4BxFfAjDX9Z1EkT7V+3JtKPOXSIMIfR778=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:2d7f60f7-390b-47a7-9a01-e042c89254e6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:f3c6cbb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: f892d716aef211eda06fc9ecc4dadd91-20230218
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1180614071; Sat, 18 Feb 2023 02:43:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 18 Feb 2023 02:43:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 18 Feb 2023 02:43:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLEXqLJU4/k67HxdVjzQKu4vlOU/kHH9BqrS/iY85jaudilrVwlvVk9ZycoAMP2Osf4/A4uhpV1WYAL9c9fpq+66HWuG4FK+OU4VkYlVMvi5evPE3WrhiN9ImiW+hXkgf14/UIRubyN7k4fc2p0k3Kn6CszttASzoDLz4ZsifsS/sV1duT8w8yrgNxaT07F/eRjWpS/4YMux4KRiYOdJxVWykEDVWJOBeWiVK3sU/Db0l6uldLRRV+1DTW85SYciHUNYGNoX26eZWU/SkOkZsrzeVEVaREnf/LDUp/W6STbMCW6avIu7EQcnLB/fGC4xGE0+PDrrV7Qh/VJsfUjhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DsM4kGo68KYFgyIyzbc00/44lhqYSdqyfGUkkZ28tI=;
 b=DaPXcAmsjvBIRVO4mzQs8igBP0msxlMgQJ8hpeMcCOqxLNnagjMYK7p+kpRDJL64/HdS14Fv3NbmDrTWpyZBuqwa/LX/uH79BuNakczh64gP8CJR0teH6ip+wRVyWUY9kSrjQRzBpXmLBxrORw6uA8KXaclDwJwkopSmtbb7tZFP7SgNjBx82FiAIlTeodourM9x8bWGswJzxi7boisQPSFwncFq7+gHGLTysKFKBPNGNUfJn1UmL3hxxrY5jajbeo5mGUG0JMnWnR8RUpP2hz+MbUDTXiNVxvJ3slBVlHZ6kWqphENQA3jkSkgzGdVJL1tTon/4X+Q3KvcJdX2f3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DsM4kGo68KYFgyIyzbc00/44lhqYSdqyfGUkkZ28tI=;
 b=ccCTT93lWdlB/3E59w0eTE8tfDnS52LC4Bx0BG0v3Zw/SXNNNjqw9Kn/SBaNzkCDgT8lzmHixLH6ie46DFwR9s4IM/UWQz6NBM+NsZY1Y95BhudFJ8broCrtODtaA0OxwE0diGPH3lQ3DweXl6kgdogXva8f+OfNIizyquzT2W8=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR03MB5892.apcprd03.prod.outlook.com (2603:1096:820:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 18:43:25 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%9]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 18:43:25 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
Thread-Topic: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
Thread-Index: AQHZQvhNg/XMHPbh9UaJA+rO7kUbpq7TbbAAgAALzIA=
Date:   Fri, 17 Feb 2023 18:43:24 +0000
Message-ID: <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
         <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
In-Reply-To: <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR03MB5892:EE_
x-ms-office365-filtering-correlation-id: 55e8c9b7-f967-4ee0-62cb-08db1116da52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTtdEt4YsxEryGEMU+7bv2/q8iangZcyO7CPjTNxBtTyuORh1g6CqSsbobNFa6vjWdBmB5omUsvs1QMmXufVOj5/KmYrxQVcg/Por8rESAUcThWP3YKbeT7b4beLWZ+GSpKyY08XZR8r9APYCMXUfx3jOr98aLNDoinrLYpco0iY2N93kbc8gzBBTijMKAjXEFIKtbOZGu6s1mhxkuA10dhqCI4HeXQzhqAfq1V0HvcfqhdXPS0sEGH6Ku5j8+bwli66tD+iOOzNvz8jjYP6pHZRoRZNAN2C8f2SwxJVb+F4Ap/1m2XYJkG54XiqGYGgCoTPz7+L/1Tvb86BKp85/KdhmzXJJliLOQ9bxjKd9Y/U2xY0wIXn69Nv4LMkrdoZw6O55KddWOrTTO3mDRIltad9K2yBTunRtju4NpKgpbd63Jk3jwMqcBWLvk1Q2WutzEyYpr7BSwsA0rWnkeHKedLREkpuw5SPPJQBZxgc0xGNWQMCmdm+lD6UAnBDjvZ9r26a4QPjVRwQIZqbcWUvsCy2Keu+sHTsuu+s9OykTf6v9sjoELR2EcTCKxvL/Z6AU0D++dTTEvGFm/GCY6qDTPDlgs54bu7EIfGNVclAz8EiPwGWHk2Lm6L77ZXlnJrdnJgEeM1YTZBs/cuphB1zw2pfhoRAviNyqGhU9VHuMwmVkdjtOqaQXStcM3rPG2iC98SMHjnxPIQ/7i/R8Lt3BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(38070700005)(54906003)(186003)(66556008)(26005)(36756003)(6916009)(4326008)(8676002)(41300700001)(66446008)(64756008)(8936002)(66476007)(71200400001)(76116006)(66946007)(316002)(86362001)(5660300002)(2906002)(83380400001)(122000001)(38100700002)(6486002)(6512007)(478600001)(107886003)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFVNbE9rZk9KZjBCQkFFUUVJRi9qbmY5U3JzbDBSRk92VEZ6TzJhS1FraTJU?=
 =?utf-8?B?SWsxdWNiMUNjdlJxenYvQlY5RWFzczIvTGwwbi83VjltemRhWDRDeGVieTZ3?=
 =?utf-8?B?RDVVUU1teEhhUEljMUJCcnpYSkxGRnk0b2hORUNEcFBsTk1uUW1sMG53L1ky?=
 =?utf-8?B?MDdCeERJbkdoZkhnN2hXakxkSTlLWXJxckFBQUQycXB5NUcreVE1QkUzcy9Z?=
 =?utf-8?B?QlEyblVmNUwxeFF0cENhQUhmN3dRYUN2T2g4dnpkaWpPcUsxajQyanBqeE1U?=
 =?utf-8?B?aDBnU0dSRnJydURyc0p5Rmh0WVAxUVpqMTZzT3V5Vmc3eU1mRkpacFRMVUlY?=
 =?utf-8?B?MlI3cnNvUXRTMHZmQzdDaHZRZGk1YmVGL0FzNTd3K1VrVlhyU3d1ZVNzZ3lG?=
 =?utf-8?B?VkNaRnRjNkFwUjBqL3M0N1VnQ0EvVHlUQ1pUZzM2ZDFYeENDeUZ0dGhBZmNI?=
 =?utf-8?B?OWJ6aXh3T0FFa3c2clZDQkJyUWZmWE1ONUpFOXRMaGFwMGlwTzZoMkJQSE1C?=
 =?utf-8?B?cklXZS9DdldGbldLaEJFdDhzSm9kbzJqK0tyaVcxbWdoc1ZXc254YSt5Sjcx?=
 =?utf-8?B?T2p1Y2pyMmh6WldDRUFINEpDUVJwOG5kMWZtVFNod3JJUHRFc3ptQ1lOaE9M?=
 =?utf-8?B?ZzRWcWZ4MkRxM0RFTUlaVHhtUHc5WTVnVEVpVDcyemNTWVhUeXo5aGV4TWlC?=
 =?utf-8?B?Y1djTGpkRVJINkZ2UG5zbnc5ZkV0TXlsUkdKNjZvVldSd2FrVXZJWHJPMzlx?=
 =?utf-8?B?OW8zSUtXaGhXc3ZJRVBxZ3AxQ21xYWdGNWVDa1NxRDFqUDZjQndQdUNSS0tE?=
 =?utf-8?B?eFg1Zms3M1lBZFhTUDBoVXkwSG1nM0xrVmZSQitLQUQ2ekErRmVDd1VvZmpo?=
 =?utf-8?B?OHhrS0hDWFZwMVJHeUlqZWlUZlBXL3hqZm8xbktNZ0pJRmNtWFUwZ1JnMjBF?=
 =?utf-8?B?KzJEZFJlUGdZYzhUdjEwREdRQldmVlFmS2wwQnBtYnlnTC96UVFiZGxKK2Ir?=
 =?utf-8?B?d2RlZXpRRDJjVStiRWQrZ2ZWdWd3YzVSdFpJd0ViOWFvRmM5Q1FHNytOalBz?=
 =?utf-8?B?UTBWbVl3czBtamF4OHBSWCtOdDFKY0tMdFBlN1ZFZFNOTSs2OTgrM05QRnhS?=
 =?utf-8?B?MjFocEpTU1ZxQXAxN21ZTHZCd1dHanBtMlNaSzhieDdPdytZMlRmc0ZmbUJw?=
 =?utf-8?B?emk3UTdocWpucnMvczZOdU9WUUxZL2hMTVptZE16VEVGMjhsVkJkcFV1NEsr?=
 =?utf-8?B?Zm1aMmFHVktJSTJ3NGJFUzh1MmpTWVBlMGs5S0Z4T1ZyNTNWczVxczAwcFl1?=
 =?utf-8?B?U0NNbk02U1BLR2EzK21JMTd4OGdvbEllOThrQll5MjBaNHdPc3hZWER0NjFm?=
 =?utf-8?B?ZWZKRm0vSlM5SWNDLzF0U1B5N2dWcnRzYXlEbVZWY3RFWVh6TkVKL3RjSDR0?=
 =?utf-8?B?eFFvTDlKQ1ZSMmNSRHQzS0N5UGJoV2hpMTlVSHJNK0pINVI3WlVYZ25Rcisy?=
 =?utf-8?B?a0cwcDY5NUkyeWRmdmhwOFlLVlloVzZvUElmOC94aUVDeHJjQ2dvT3lJVnpu?=
 =?utf-8?B?WkRCa1JZbXcxd05FRDdDOEhjcGVha2dyOENPeDgzY2dWS3pzYk95QmhuTnpL?=
 =?utf-8?B?QWdpTzRmM09jWStwOFNFdWR5SVVwTDBIaHREaDc4eGpxYktZWGpnZ2h6NnI1?=
 =?utf-8?B?cmRaOHlXejZKWTFrRENGeUlMSmZtVnVweGdiMlBKK2dYRDdYeUNsN0JWclRj?=
 =?utf-8?B?Q0JyTlRKakJRbTFDR2NITkRQa1p5ZVRkUmxHbnczTjRxdEs4NjZibHp0azdE?=
 =?utf-8?B?UnVFMkJjc00xcTBYVVYrU2xJbzc0dmJlclJKcTdqTWVNdnlTV0xuejNyVVZY?=
 =?utf-8?B?TXJUd3cwM1JoNjJMMTRBNjlaWDVLNzNpSWxsVmFuakVvaWRmVzF4VUJHV21l?=
 =?utf-8?B?MnpMTVNETm91MDZvMk1EK3JITktMNVcvekRVdVZ4clplaFVTeS84STJ5WFlv?=
 =?utf-8?B?NHJJditEb1JPbzl6NUlkOUUydkcxZ1RSdDZSRWZocm1JdUoxOUNZdkV5cVY3?=
 =?utf-8?B?czBZL0pqM2dPd0JzczFUL2tVY3FFVkNtRERWZ2lkZ1ZhcHJYbkQ5YVB2a1By?=
 =?utf-8?B?TStuYnZPM3FxNWtjK3dHQ3Z5TnVuQWR5SUorRmJtWVZmRHhoYlVXNVV0UHhW?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A59677F853E7894E83AE3E375D1FD0E0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e8c9b7-f967-4ee0-62cb-08db1116da52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 18:43:25.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLKqiWWt+aogj96tv/Z7VQ2FB3aD6Ig/VzzQx/ezdHHKzRuapHAZ20VE1ICw6wLGN//Tdtd7Xzc+K1RjPm0kWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5892
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTE3IGF0IDE5OjAxICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBTYXQsIDIwMjMtMDItMTggYXQgMDE6NTAgKzA4MDAsIFJ5ZGVyIExlZSB3cm90ZToNCj4g
PiBUaGlzIGFsbG93cyBsb3cgbGV2ZWwgZHJpdmVycyB0byByZWZyZXNoIHRoZSB0eCBhZ2cgc2Vz
c2lvbiB0aW1lciwNCj4gPiBiYXNlZCBvbg0KPiA+IHF1ZXJ5aW5nIHN0YXRzIGZyb20gdGhlIGZp
cm13YXJlIHVzdWFsbHkuIEVzcGVjaWFsbHkgZm9yIHNvbWUgbXQ3Ng0KPiA+IGRldmljZXMNCj4g
PiBzdXBwb3J0IC5uZXRfZmlsbF9mb3J3YXJkX3BhdGggd291bGQgYnlwYXNzIG1hYzgwMjExLCB3
aGljaCBsZWFkcw0KPiA+IHRvIHR4IEJBDQo+ID4gc2Vzc2lvbiB0aW1lb3V0IGZvciBjZXJ0YWlu
IGNsaWVudHMuDQo+ID4gDQo+IA0KPiBEb2VzIGl0IGV2ZW4gbWF0dGVyPyBXZSBjb3VsZCBqdXN0
IHJlcXVlc3Qgc2Vzc2lvbnMgd2l0aG91dCBhIHRpbWVvdXQNCj4gaW4NCj4gdGhlIGZpcnN0IHBs
YWNlLg0KPiANCg0KSSB0aGluayB3ZSdyZSBhbHJlYWR5LiBPdXIgbWFpbiBpc3N1ZSBpcyBwZXJm
b3JtYW5jZSBwZXJpb2RpY2FsbHkgZHJvcHMNCmV2ZXJ5IGZldyBzZWNvbmRzIHdoZW4gLm5ldF9m
aWxsX2ZvcndhcmRfcGF0aCBpcyBlbmFibGVkLiBXaXJlbGVzcw0KY2xpZW50IGhhdmUgbm9ybWFs
IDUwMCsgTWIvcyBpcGVyZjMgZG93bmxvYWQgc3BlZWQgZm9yIHNldmVyYWwgc2Vjb25kcy4NClRo
ZW4gaXQgZHJvcHMgbGVzcyB0aGFuIDEwMCBNYi9zIGZvciBzZXZlcmFsIHNlY29uZHMuIFRoZW4g
ZXZlcnl0aGluZw0KcmVwZWF0cy4gSXNzdWUgb2NjdXJzIG9ubHkgb24gY2VydGFpbiBjbGllbnRz
LiAoaS5lLiBJbnRlbCBjYXJkcyBBWDIwMCwNCkFYMTY3NSwgQWR2YW5jZWQtTiA2MjM1IGluIFdp
bjExKQ0KDQo+IE9yIGRvIHlvdSBoYXZlIGEgc3Ryb25nIHJlYXNvbiB0byBuZWVkIHRoZSB0aW1l
b3V0LCBzdWNoIGFzIGxpbWl0ZWQNCj4gaGFyZHdhcmUgcmVzb3VyY2VzIGZvciAoVFgpIGFnZ3Jl
Z2F0aW9uIHNlc3Npb25zPw0KPiANCj4gQnV0IHRoZW4gbWF5YmUgeW91IHNob3VsZCBqdXN0IHRp
bWUgdGhlbSBvdXQgYmFzZWQgb24gRlcgc3RhdGlzdGljcw0KPiBkaXJlY3RseSwgcmF0aGVyIHRo
YW4gaGF2aW5nIHRvIHBlcmlvZGljYWxseSByZWZyZXNoIHRoZSB0aW1lciBpbg0KPiBtYWM4MDIx
MT8NCj4gDQo+IEkgZG9uJ3QgbWluZCB0aGUgcGF0Y2gsIGFuZCBJJ2xsIGhhcHBpbHkgdGFrZSBp
dCBpZiBpdCdzIG5lZWRlZCwgSSdtDQo+IGp1c3Qgd29uZGVyaW5nIGlmIHRoYXQgaXNuJ3QgYSB2
ZXJ5IHJvdW5kYWJvdXQgd2F5IG9mIGFjaGlldmluZw0KPiB0aGluZ3MuDQo+IA0KPiBqb2hhbm5l
cw0K
