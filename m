Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158DA654245
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiLVOBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 09:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiLVOBb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 09:01:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3083E03E
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 06:01:22 -0800 (PST)
X-UUID: 9ea79355fa8643408446417189b2f832-20221222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1pjyfd1vwwH/BvaLz54fGNjy99rVmjNMMJQGvpzq+1g=;
        b=hpYQt7PtoV3lfAPDQImAVwGfFfIBm0ik4WK1seMgdVNUP8lLgVOvYglmYsqBXJ64WSQd4j1nTQ93++9f5xg+g+lx/gpbkA8HNITLjHpncpmX8tbmj8cBgcFS0d0Eyj+lQkKwzeV1vVefyaZXnkvzI5HRxJeHKKqBMBvNnJreSd8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:79423a00-f047-450c-a58d-6a28353ee10a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:79423a00-f047-450c-a58d-6a28353ee10a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:a049aef3-ff42-4fb0-b929-626456a83c14,B
        ulkID:221221182631NLN0JUXB,BulkQuantity:31,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 9ea79355fa8643408446417189b2f832-20221222
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 659666465; Thu, 22 Dec 2022 22:01:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Dec 2022 22:01:14 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 22 Dec 2022 22:01:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oce5fdQw5GvXzIfxgSbdcy0PdfS04mVTh5LbCG0PpMXDhvPbeR4JVZfYf/WJNMi0VPKhxL6WMFAPpgtAL7gLxEXXprT/7y6fsuoFvqEtG3Aw39HYv50Fj1vHrJp/8hXUdWwLfnn5Ack/Uk5ajZPVS1Z4R9B6z6cdlrlYj+wwBGN9Vi7gOKtp8M0+EKO/0C4LM5JmAIOpHn0xU/OnfGnWvvFtrVr0QOePJf02BAcQYPhiSrPOWeH7l/JSYClXN/3bdrkE4KSvoRgcZFffsTMx+1auE5pPFc7aQ2ADqblrhxzKaGndDFl+Nfk0kHjinb/qieCJc6oLE3wHcD7w9DgJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pjyfd1vwwH/BvaLz54fGNjy99rVmjNMMJQGvpzq+1g=;
 b=nex9kb9Flt9bJVSBC3KfzgmM/YbRgA0vXu/XtoE2A31PnBkfmV5iLePGCZHMQK27maCjf/RDh/bKqmFSuKpopZBX78oIIjb6Qx+C7QtZzaID7LQHAXomDZexQfloOhxt3lNplav2V3pbNEB1YpoWDxK8qYoax31jya7cxRf5ULZDUmg7PCWFqitjPSaJ91zMISe5x5hDFVn7FnR1fAUalJ4W5RqNubMf35eS1fS2/N0y4QK4BLRIxjzyTl+OgO/cvTmkGs3AiCHNjc76t7QOlS+EuRFszmrBvoE0/EGtgFBoWZS3gS4V64N4XimTw9xcYhzZQCXwKS8sDe6sPrQqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pjyfd1vwwH/BvaLz54fGNjy99rVmjNMMJQGvpzq+1g=;
 b=VjWtclLMuQT7M6gmBuOaIIKX2G8dmeGVn8e8aMkBHUJ0h2su9lx8EfbXDaWWdTebTkpIXI/Av4mRUXXWzq9quB41Sz+8swukWAm7jxgfxJr4LoGUjhR00B6h8M8bR/yZeoeBztIlEayeUDdB0xqr9/7Z6codiqotGl13cpliwiE=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by SI2PR03MB5627.apcprd03.prod.outlook.com (2603:1096:4:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 14:01:09 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec%7]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 14:01:09 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Topic: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Index: AQHZE2UYm26GeWDuU0a5b6k/XQDcva50+UQAgAE64oCAAfJmgIAASTAAgAAGzwCAAC9VgIAA+GYAgAAPBgCAAEeXAA==
Date:   Thu, 22 Dec 2022 14:01:09 +0000
Message-ID: <5162a6ab00c3d90e4401e8753f4a79d9232640eb.camel@mediatek.com>
References: <3940cc5ccb4b17d51b5176e722daef0d1af66d6a.camel@mediatek.com>
         <B2689D6F-E04E-4E9B-9244-4E5069DC464D@nbd.name>
         <Y6NKHY7euhifm0kI@lore-desk>
         <6de89564e1deb0b641b2a5039b23909f4647425e.camel@mediatek.com>
         <Y6QnFkJCWPsRgSQD@lore-desk>
In-Reply-To: <Y6QnFkJCWPsRgSQD@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|SI2PR03MB5627:EE_
x-ms-office365-filtering-correlation-id: a780d3f7-068d-4b85-e3e1-08dae424fa45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q407DyuVQNAT+2xaFxwNwYZVFLQr143qT0YckvNrRSmMxhKCqbY1H99lmBnsbLRo3rG1YZ6BIVgjqshJBmpr+mG8Cvy5PRsekJJ33Ulj2+OBEHAXYMqMrdA7UbErsErbIF8W96ptnz4NmCgRbOOpbvUisv71EPQX4TgDiqA31JYGCZseQV5/P1lLZk5lYzf1GgGWGWl7tY8SdrcAt28vEzZM9ZFn9H1dpW5BFMkZJeUICYi7NBg2MHw50KneS8IegjJNXF8fTmmdYgsdvrPW5w4GW666Bk129v/EaP9RRryJuTx3Xe3NlS3sL3TFBOGkLICHtKQS5ne+1sWU7C2WPU1ny0O0AOmniiyty0ugZpq/+XvAdeqdiDS/TaenxMUkgyd0QXtF6/FKPf0MNovJMIG+QMpciinfC2X0NJ41uwxlqepYj+pgnvfKvTuRLyZ9nsK2u/gyVWG8t9csLlLwEgrLMF+x65DjwK8tMQS5WGqaz1tBLEiSglP69yVJH8kJtqWbyBs0PKYJzLmwirUTQv8PSyQ0z5CWHlKz63dxR2wbulSHql3jGMlXfqNbACKTVCwMxKlHnZndPMr9nzFry49CdcS2s/Z31wqtenyZ7Eop/CIE9Sut3ojiX9xHqcvUExtBPfZDCZiBUfDmPHTiJQKXjt/RFHOV+LLYhRW8/HASFQoHsnhSfzV6kkY2QrLPCl2d3spfqR69FFGXSeVTIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(4326008)(41300700001)(122000001)(8676002)(85182001)(36756003)(38100700002)(38070700005)(5660300002)(83380400001)(8936002)(6506007)(4001150100001)(6486002)(2906002)(6512007)(478600001)(316002)(6916009)(54906003)(86362001)(91956017)(66446008)(76116006)(66946007)(66476007)(64756008)(66556008)(186003)(2616005)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzkyNHhJRjV0eGtOK2ZsaU9acWZrcVZJTDFpd3EyQ1NIajJOWm9lR2tvK1pk?=
 =?utf-8?B?WWxmTWRPekZ0V05OYW9zenlSSEplNmo4cWFQa3Y1ZWVMWHFKTEZIUyt3TTVt?=
 =?utf-8?B?WGZsZFVOTlkxNm51aTQ2bUNiN0EvNlh4a0N2djNyRkM1Tk10TnBqUWluQjBR?=
 =?utf-8?B?bkVXY1gvUDhNencwWFNoai9rVW1zbjcxVHFjOFVLMncxVEdIbDJvNkhuc2lM?=
 =?utf-8?B?NUV2T0VraUZSTmRtZUU4b09RSHR5TEkvckhabVdOWFhTM2tkVlh6eFh1Y09v?=
 =?utf-8?B?SUVzTE44bmJjcnlPN2d4L0svOW13czVCM3JvL2FkUlNUMSswYklmcUVxQStV?=
 =?utf-8?B?S2lISjdud0p6NnNLUEJ0ekNhZEVWdWh4TW9heTFHQ2NGeGQzenN1VHVhRC9v?=
 =?utf-8?B?MFk1REk2RHFWa0tFS3pORVcvNWlWOEIwWGFOblFTZmVvNGlBZ1hnKytWekpm?=
 =?utf-8?B?YktYNm5TY0d1a0xSNGUzNndueEljQ0c2bzhlcTdPU3M5amhBQTNRd3RzLzV0?=
 =?utf-8?B?OGJaRHYzQUVnSjBualhFalNvaExDSDh2RjlWWWpRVHZRNUdJZFZyaGF0UUQ4?=
 =?utf-8?B?ZSt3Y2htcjdTU3lobUE3eUZHbmFrUGdqVWdzUFg1Z0UxYzlYVElYMjYyOFdN?=
 =?utf-8?B?VkRwZmR3YnZKaGxGdEpjenlxbVNnTGJETUhqUjY0Z3hDK2ExVkYxbkcxTTJp?=
 =?utf-8?B?VnZjaFpzQjhsMlhvUy95WW8vSlhtdEd1OVlOVW1HS1J5ZG9sT0M1cWNZM01Y?=
 =?utf-8?B?VnBpYWFwSkZUZHgxVXoyRllTTlJING94Q2toai9nUlpjVXNOaWpQbFpwb0Jp?=
 =?utf-8?B?Wmc0SWdoRENyc3AyaVFZMlVaUllpeVJRQURDMXBDa3QxRHNvSGUrcVc3NlRG?=
 =?utf-8?B?S0dLRXpkRzNha2pPWGIyQ256aENtNFBpSHZnamNZMHc3QlNObTBiS0N3bFUw?=
 =?utf-8?B?WjA4KzRxWXBJTitySGN1WjJzMnRjdExDUktyb0VBTkltN0tDWmZJdXlWc2F4?=
 =?utf-8?B?NE9TR1FKL1V0MWE4RTl5TWhDcmxrZm5GUko3cWFvZ0cweHIwTDN5R3lVbVNK?=
 =?utf-8?B?VkZKbmFTK28xdDVRRWU4eEN4OVB6ZFYwNXZTWHJDbzlIbzY3alNBUjUyeDd6?=
 =?utf-8?B?N3lFRjdDaGk3L0tha3hPdXh1RlplVmltMWtSTGozYlVEejhWUGM0ZGt0aE1p?=
 =?utf-8?B?NXZQU1FhUXp6MEx3RzRKQ2srNVlLa05XQkZKdTZ1a21iL3YwMFlFUEZacWRL?=
 =?utf-8?B?MkVuVGxjd0FzWk1BSEFvYnlrQW1LeWdoN3BLTWNpUU1YSGFhRTc0NUxjWlNi?=
 =?utf-8?B?ZmFzTytRUk9mQ3JUTytlT0sxTkZkakFwTEZwcm56SW5kWlZGVnNPUHRUYjg5?=
 =?utf-8?B?UXc1dFZDUG5tVTlLN0w1dWZscUMrUFRsRml5bWJHeWEzUk03bjErcDZ6eHJr?=
 =?utf-8?B?WTN2bzJhYlJhOUJkSm9QYm9GTkZsVlVaK3VkbjdSU0hTUWxTNVVKTld6dkNn?=
 =?utf-8?B?UEpKRWRqOFJ3VmU2K204ZDRYM3pLZmE2Y3pjNk1NeUZ0M3g1SG9icm1Kbk9v?=
 =?utf-8?B?aXlsbnV5aUZrWVRWUVhVUTlsNm5BMkVZUnA1UGZRdTc0a2hlZllvY2JIYlUy?=
 =?utf-8?B?ajRVcTdHcjVoUWF3Z1IxVHRGditmLy9XNkJtMXJKY3lVT3hPQlMrd3BsbDlV?=
 =?utf-8?B?VDlUQ3gwT1ZnRkJSZmhOK0YrR25rN0loek1DSkU2TG14SkpZNjhoMUNWcGNs?=
 =?utf-8?B?TDdtelE0NEJFS2I4K0wvNUJxNFNBR0owbjg2L3N6ZnZwY2xJMDlmSFpUR2t1?=
 =?utf-8?B?QmRvMXp0dEhqendxMmpyZGM2RVA3N21hSWVQME1wMDl6aUJCTjRDcGFLSVl0?=
 =?utf-8?B?K3NyMkpDWHpYQWw2WXVwRy9FSWhISmkrd0d3ZDRLK0laU1hEMElrck9MM2tD?=
 =?utf-8?B?VUhzUHovMGxxZkhnWWpHVHlUb1VRcStZMW5TMU5qZURzRDdTSGYvbWRPMnBo?=
 =?utf-8?B?NnhpZlMvTVozdXl2TUhjRFQyUGtNeVZPdWw4ZUlGNE11ZGh6M3hoSVVjcUs3?=
 =?utf-8?B?NTRwcHRyR3ZYUXhRZmwyOWtiNnhySWRUdHc4U291d1dZQ0dDNDQ3SE14SU9N?=
 =?utf-8?B?Y3BBc2pVUU1sUTVzMXcxWFBwbzhUdUF6RC9QdFhLYmpTK0dlWnR5dU56VFFJ?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D67533B75C2ED4EAB96AB37073A2153@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a780d3f7-068d-4b85-e3e1-08dae424fa45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 14:01:09.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qm/qGG2d5lGxvSVzgB05ZKYL+PnXEM26AxEs2QB/krcgejueU7MTDbLNIV7sW9Oj+MPi3TtIrQUKEVbn9tQVFBy/ETF2btcU13bJ0IstQeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5627
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTIyIGF0IDEwOjQ0ICswMTAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+ID4gT24gV2VkLCAyMDIyLTEyLTIxIGF0IDE5OjAyICswMTAwLCBMb3JlbnpvIEJpYW5j
b25pIHdyb3RlOg0KPiA+ID4gT24gRGVjIDIxLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0KPiA+ID4g
PiBIaSBTdWp1YW4sDQo+ID4gPiA+IA0KPiA+ID4gPiA+IFllcywgaXQgaXMgc28gZXhwZW5zaXZl
LCBidXQgaWYgbm8gbWVtY29weSwgaXQgd2lsbCBjYXN1ZQ0KPiA+ID4gPiA+IG1lbW9yeQ0KPiA+
ID4gPiA+IGZyYWdtZW50YXRpb24gKHdlIGhpdCB0aGlzIGlzc3VlIGluIGludGVybmFsIFNRQyku
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gYXMgd2Uga25vdywgd2VkIG5lZWRzIHRvIGV4Y2hhbmdl
IHJ4IHBrdChiZWxvbmdzIHRvIHdlZCByeA0KPiA+ID4gPiA+IGJ1ZmZlcg0KPiA+ID4gPiA+IG1h
bmFnZXIpIHdpdGggd2lmaSBkcml2ZXIoZG1hIHJ4IGRhdGEgcXVldWUpIGJ5IGV4Y2hhbmdpbmcN
Cj4gPiA+ID4gPiB3ZmRtYQ0KPiA+ID4gPiA+IGRtYWQNCj4gPiA+ID4gPiB0byBlbnN1cmUgdGhl
IGZyZWUgd2VkIHJ4IGJ1ZmZlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBpdCBpcyBwb3NzaWFi
bGUgdGhhdCBhIGxhcmdlIG51bWJlciBvZiBidWZmZXIgaGFzIGJlZW4NCj4gPiA+ID4gPiBleGNo
YW5nZWQNCj4gPiA+ID4gPiB0byB3ZWQNCj4gPiA+ID4gPiBhbmQgY2FuIG5vdCBjb21lIGJhY2sg
dG8gd2xhbiBkcml2ZXIuIFNvLCB0aGUgbWVtb3J5IGZyb20gdGhlDQo+ID4gPiA+ID4gc2FtZSAz
MksNCj4gPiA+ID4gPiBwYWdlIGNhY2hlIGlzIHVuYWJsZSB0byBiZSByZWxlYXNlZCwgYW5kIGl0
IHdpbGwgYmUgZmFpbGVkIGF0DQo+ID4gPiA+ID4gcGFnZV9mcmFnX2FsbG9jIGluIG10NzZfZG1h
X3J4X2ZpbGwuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQW55IGlkZWFzIGJ1dCBtZW1jb3B5Pw0K
PiA+ID4gPiANCj4gPiA+ID4gQSBzaW1wbGUgc29sdXRpb24gd291bGQgYmUgdG8gc2ltcGx5IGFs
bG9jYXRlIHNpbmdsZSBwYWdlcywgb3INCj4gPiA+ID4gaGFsZi1wYWdlIGZyYWdtZW50cy4NCj4g
PiA+ID4gDQo+ID4gPiA+IC0gRmVsaXgNCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEEgc2ltcGxl
IGFwcHJvYWNoIHdvdWxkIGJlIGFsbG9jYXRpbmcgYSBzaW5nbGUgcGFnZSBmb3IgZWFjaCByeA0K
PiA+ID4gYnVmZmVyLg0KPiA+ID4gDQo+ID4gPiBAU3VqdWFuOiBjYW4geW91IHBsZWFzZSBkb3Vi
bGUgY2hlY2sgaWYgaXQgaXMgb2sgZnJvbSBwZXJmb3JtYW5jZQ0KPiA+ID4gYW5kDQo+ID4gPiBt
ZW1vcnkNCj4gPiA+IAkgZnJhZ21lbnRhdGlvbiBwb2ludCBvZiB2aWV3PyBJZiBub3QgSSBndWVz
cyB3ZSBjYW4gdHJ5IHRvDQo+ID4gPiBvcHRpbWl6ZSBpdA0KPiA+ID4gCSBhbmQgYWxsb2NhdGUg
bXVsdGlwbGUgYnVmZmVycyBpbiB0aGUgc2FtZSBwYWdlIHR3ZWVraW5nIHBhZ2UNCj4gPiA+IHJl
ZmNvdW50Lg0KPiA+ID4gDQo+ID4gPiAodGhpcyBwYXRjaCBtdXN0IGJlIGFwcGxpZWQgb24gdG9w
IG9mIEZlbGl4J3MgZG1hIGZpeCkuDQo+ID4gPiANCj4gPiANCj4gPiBBbGxvY2F0aW5nIHNpbmds
ZSBwYWdlIGZvciBlYWNoIHJ4IGJ1ZmZlciBhdm9pZHMgbWVtb3J5DQo+ID4gZnJhZ21lbnRhdGlv
biwNCj4gPiBidXQgaXQgYWx3YXlzIHVzZXMgNEsgZm9yIG9uZSByeCBwa3Qgd2hpY2ggb25seSBu
ZWVkcyAySywgcmlnaHQ/DQo+IA0KPiBjb3JyZWN0LCB3ZSBjYW4gb3B0aW1pemUgaXQgYWxsb2Nh
dGluZyBtdWx0aXBsZSBidWZmZXJzIChpbiB0aGlzIGNhc2UNCj4gMiwNCj4gYXNzdW1pbmcgNEsg
cGFnZXMpIGluIGEgc2luZ2xlIHBhZ2UgYW5kIHJlY3ljbGluZyB0aGUgcGFnZS4NCj4gDQo+ID4g
DQo+ID4gSSBndWVzcyBwZXJmb3JtYW5jZSB3b3VsZCBiZSB3b3JzZSB3aXRob3V0IHBhZ2UgY2Fj
aGUuDQo+IA0KPiBJIHRoaW5rIGl0IGlzIGEgdHJhZGUtb2ZmDQo+IA0KPiA+IFdlIGhhdmUgdGVz
dGVkIG9uIHRoZSBtdGsgcHJpdmF0ZSBkcml2ZXIsIDclIGRyb3AgaW4gdGhyb3VnaHB1dA0KPiA+
IHdoZW4NCj4gPiBzZXR0aW5nIHRoZSA0SyBwYWdlIGNhY2hlIGNvbXBhcmVkIHRvIHRoZSAzMksg
cGFnZSBjYWNoZS4NCj4gPiBhbmQgMTAlIGRyb3Agd2hlbiB1c2Ugc2xhYiB0byBhbGxvY2F0ZSBi
dWZmZXIuDQo+IA0KPiBJSVVDIHlvdSB0ZXN0ZWQgd2l0aCBQQUdFX0ZSQUdfQ0FDSEVfTUFYX1NJ
WkUgc2V0IHRvIDRLIChvciB3aXRoIGENCj4gcHJpdmF0ZQ0KPiBwYWdlX2ZyYWdfYWxsb2MoKSBp
bXBsZW1lbnRhdGlvbikgYW5kIHlvdSBhdm9pZGVkIG1lbW9yeSBhbGxvY2F0aW9uDQo+IGZhaWx1
cmVzIGR1ZSB0byBmcmFnbWVudGF0aW9uIGJ1dCB5b3UgZ290IH4gNyUgZHJvcCBpbiB0aHJvdWdo
cHV0LA0KPiBjb3JyZWN0Pw0KPiBJIHRoaW5rIHRoaXMgaXMgcXVpdGUgZXhwZWN0ZWQgc2luY2Ug
d2UgbmVlZCB0byByZWZpbGwgfiA4IHRpbWVzIG1vcmUNCj4gdGhlDQo+IHBhZ2UgY2FjaGUuDQo+
IA0KPiBOb3QgY29uc2lkZXJpbmcgbWVtb3J5IGZyYWdtZW50YXRpb24sIGhhdmUgeW91IG1lYXN1
cmVkIHRoZSBpbXBhY3Qgb2YNCj4gdGhlDQo+IG1lbWNweSBvZiBhIGZ1bGwgYnVmZmVyPw0KPiAN
Cg0Kd2VsbCwgZm9yIHB1cmUgc3cgcGF0aCwgaXQgbWF5YmUgfjMwME0gZHJvcCAobm90IHN1cmUp
IHdoZW4gdXNpbmcNCm1lbWNweSg1Ry9IRTgwLzQqNCkuDQpidXQgd2UgZG8gbWVtY3B5IG9ubHkg
d2hlbiB3ZWQgb24sIGF0ZmVyIGEgZmV3IHVuYmluZGluZyBwa3RzLCB0aGVuIGFsbA0KZmxvd3Mg
YXJlIG9mZmxvYWRlZCBieSBody4gaXQgaXMgYWxzbyBhIHRyYWRlLW9mZn4NCg0KUmVnYXJkcywN
ClN1anVhbg0KDQo+ID4gDQo+ID4gQSBzaW5nbGUgcGFnZSBwZXIgcnggYnVmZmVyIG1heSBjYXVz
ZSBhIHRocm91Z2hwdXQgZHJvcCBvZiBvdmVyIDclDQo+ID4gYW5kDQo+ID4gd2FzdGUgbWVtb3J5
LCB3aGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+IEltcGxlbWVudGluZyB0aGUgcGFnZSByZWN5Y2xl
cyBhcyBpdCBpcyBkb25lIGluIHBhZ2VfZnJhZ19hbGxvYygpIHdlDQo+IHNob3VsZCBnZXQNCj4g
dGhlIHNhbWUgcmVzdWx0cyB5b3UgZ290IHdpdGggUEFHRV9GUkFHX0NBQ0hFX01BWF9TSVpFIHNl
dCB0byA0Sy4NCj4gDQo+IFJlZ2FyZHMsDQo+IExvcmVuem8NCj4gDQo+ID4gDQo+ID4gUmVnYXJk
cywNCj4gPiBTdWp1YW4NCj4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBMb3JlbnpvDQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L2RtYS5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMN
Cj4gPiA+IGluZGV4IDI4YTdmZTA2NDMxMy4uMWQ5ZTU4MDk3N2ZjIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiA+ID4gQEAgLTU4MCw2
ICs1ODAsMjAgQEAgbXQ3Nl9kbWFfdHhfcXVldWVfc2tiKHN0cnVjdCBtdDc2X2RldiAqZGV2LA0K
PiA+ID4gc3RydWN0IG10NzZfcXVldWUgKnEsDQo+ID4gPiAgCXJldHVybiByZXQ7DQo+ID4gPiAg
fQ0KPiA+ID4gIA0KPiA+ID4gK3N0YXRpYyB2b2lkICoNCj4gPiA+ICttdDc2X2RtYV9nZXRfcnhf
YnVmKHN0cnVjdCBtdDc2X3F1ZXVlICpxKQ0KPiA+ID4gK3sNCj4gPiA+ICsJaWYgKChxLT5mbGFn
cyAmIE1UX1FGTEFHX1dFRCkgJiYNCj4gPiA+ICsJICAgIEZJRUxEX0dFVChNVF9RRkxBR19XRURf
VFlQRSwgcS0+ZmxhZ3MpID09IE1UNzZfV0VEX1FfUlgpIHsNCj4gPiA+ICsJCS8qIFdFRCBSWCBx
dWV1ZSAqLw0KPiA+ID4gKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBkZXZfYWxsb2NfcGFnZSgpOw0K
PiA+ID4gKw0KPiA+ID4gKwkJcmV0dXJuIHBhZ2UgPyBwYWdlX2FkZHJlc3MocGFnZSkgOiBOVUxM
Ow0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBwYWdlX2ZyYWdfYWxsb2MoJnEt
PnJ4X3BhZ2UsIHEtPmJ1Zl9zaXplLCBHRlBfQVRPTUlDKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+
ID4gPiAgc3RhdGljIGludA0KPiA+ID4gIG10NzZfZG1hX3J4X2ZpbGwoc3RydWN0IG10NzZfZGV2
ICpkZXYsIHN0cnVjdCBtdDc2X3F1ZXVlICpxKQ0KPiA+ID4gIHsNCj4gPiA+IEBAIC01OTYsNyAr
NjEwLDcgQEAgbXQ3Nl9kbWFfcnhfZmlsbChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0DQo+
ID4gPiBtdDc2X3F1ZXVlICpxKQ0KPiA+ID4gIAkJc3RydWN0IG10NzZfcXVldWVfYnVmIHFidWY7
DQo+ID4gPiAgCQl2b2lkICpidWYgPSBOVUxMOw0KPiA+ID4gIA0KPiA+ID4gLQkJYnVmID0gcGFn
ZV9mcmFnX2FsbG9jKCZxLT5yeF9wYWdlLCBxLT5idWZfc2l6ZSwNCj4gPiA+IEdGUF9BVE9NSUMp
Ow0KPiA+ID4gKwkJYnVmID0gbXQ3Nl9kbWFfZ2V0X3J4X2J1ZihxKTsNCj4gPiA+ICAJCWlmICgh
YnVmKQ0KPiA+ID4gIAkJCWJyZWFrOw0KPiA+ID4gIA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21taW8uYw0KPiA+ID4gYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMNCj4gPiA+IGluZGV4
IDFhMmU0ZGY4ZDFiNS4uMjkyNGU3MWU0ZmJlIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbW1pby5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMNCj4gPiA+IEBAIC01
OTQsMTMgKzU5NCw5IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiBtdDc5MTVfbW1pb193ZWRfb2ZmbG9h
ZF9kaXNhYmxlKHN0cnVjdCBtdGtfd2VkX2RldmljZSAqd2VkKQ0KPiA+ID4gIHN0YXRpYyB2b2lk
IG10NzkxNV9tbWlvX3dlZF9yZWxlYXNlX3J4X2J1ZihzdHJ1Y3QgbXRrX3dlZF9kZXZpY2UNCj4g
PiA+ICp3ZWQpDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2Ow0KPiA+
ID4gLQl1MzIgbGVuZ3RoOw0KPiA+ID4gIAlpbnQgaTsNCj4gPiA+ICANCj4gPiA+ICAJZGV2ID0g
Y29udGFpbmVyX29mKHdlZCwgc3RydWN0IG10NzkxNV9kZXYsIG10NzYubW1pby53ZWQpOw0KPiA+
ID4gLQlsZW5ndGggPSBTS0JfREFUQV9BTElHTihORVRfU0tCX1BBRCArIHdlZC0+d2xhbi5yeF9z
aXplICsNCj4gPiA+IC0JCQkJc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsNCj4gPiA+
IC0NCj4gPiA+ICAJZm9yIChpID0gMDsgaSA8IGRldi0+bXQ3Ni5yeF90b2tlbl9zaXplOyBpKysp
IHsNCj4gPiA+ICAJCXN0cnVjdCBtdDc2X3R4d2lfY2FjaGUgKnQ7DQo+ID4gPiAgDQo+ID4gPiBA
QCAtNjEwLDcgKzYwNiw3IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiBtdDc5MTVfbW1pb193ZWRfcmVs
ZWFzZV9yeF9idWYoc3RydWN0DQo+ID4gPiBtdGtfd2VkX2RldmljZSAqd2VkKQ0KPiA+ID4gIA0K
PiA+ID4gIAkJZG1hX3VubWFwX3NpbmdsZShkZXYtPm10NzYuZG1hX2RldiwgdC0+ZG1hX2FkZHIs
DQo+ID4gPiAgCQkJCSB3ZWQtPndsYW4ucnhfc2l6ZSwgRE1BX0ZST01fREVWSUNFKTsNCj4gPiA+
IC0JCV9fZnJlZV9wYWdlcyh2aXJ0X3RvX3BhZ2UodC0+cHRyKSwgZ2V0X29yZGVyKGxlbmd0aCkp
Ow0KPiA+ID4gKwkJZnJlZV9wYWdlKHZpcnRfdG9fcGFnZSh0LT5wdHIpKTsNCj4gPiA+ICAJCXQt
PnB0ciA9IE5VTEw7DQo+ID4gPiAgDQo+ID4gPiAgCQltdDc2X3B1dF9yeHdpKCZkZXYtPm10NzYs
IHQpOw0KPiA+ID4gQEAgLTYyMSwxMyArNjE3LDkgQEAgc3RhdGljIHUzMg0KPiA+ID4gbXQ3OTE1
X21taW9fd2VkX2luaXRfcnhfYnVmKHN0cnVjdA0KPiA+ID4gbXRrX3dlZF9kZXZpY2UgKndlZCwg
aW50IHNpemUpDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3QgbXRrX3J4Ym1fZGVzYyAqZGVzYyA9
IHdlZC0+cnhfYnVmX3JpbmcuZGVzYzsNCj4gPiA+ICAJc3RydWN0IG10NzkxNV9kZXYgKmRldjsN
Cj4gPiA+IC0JdTMyIGxlbmd0aDsNCj4gPiA+ICAJaW50IGk7DQo+ID4gPiAgDQo+ID4gPiAgCWRl
diA9IGNvbnRhaW5lcl9vZih3ZWQsIHN0cnVjdCBtdDc5MTVfZGV2LCBtdDc2Lm1taW8ud2VkKTsN
Cj4gPiA+IC0JbGVuZ3RoID0gU0tCX0RBVEFfQUxJR04oTkVUX1NLQl9QQUQgKyB3ZWQtPndsYW4u
cnhfc2l6ZSArDQo+ID4gPiAtCQkJCXNpemVvZihzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvKSk7DQo+
ID4gPiAtDQo+ID4gPiAgCWZvciAoaSA9IDA7IGkgPCBzaXplOyBpKyspIHsNCj4gPiA+ICAJCXN0
cnVjdCBtdDc2X3R4d2lfY2FjaGUgKnQgPSBtdDc2X2dldF9yeHdpKCZkZXYtPm10NzYpOw0KPiA+
ID4gIAkJZG1hX2FkZHJfdCBwaHlfYWRkcjsNCj4gPiA+IEBAIC02MzUsNyArNjI3LDcgQEAgc3Rh
dGljIHUzMiBtdDc5MTVfbW1pb193ZWRfaW5pdF9yeF9idWYoc3RydWN0DQo+ID4gPiBtdGtfd2Vk
X2RldmljZSAqd2VkLCBpbnQgc2l6ZSkNCj4gPiA+ICAJCWludCB0b2tlbjsNCj4gPiA+ICAJCXZv
aWQgKnB0cjsNCj4gPiA+ICANCj4gPiA+IC0JCXBhZ2UgPSBfX2Rldl9hbGxvY19wYWdlcyhHRlBf
S0VSTkVMLA0KPiA+ID4gZ2V0X29yZGVyKGxlbmd0aCkpOw0KPiA+ID4gKwkJcGFnZSA9IF9fZGV2
X2FsbG9jX3BhZ2UoR0ZQX0tFUk5FTCk7DQo+ID4gPiAgCQlpZiAoIXBhZ2UpDQo+ID4gPiAgCQkJ
Z290byB1bm1hcDsNCj4gPiA+ICANCj4gPiA+IEBAIC02NDQsNyArNjM2LDcgQEAgc3RhdGljIHUz
MiBtdDc5MTVfbW1pb193ZWRfaW5pdF9yeF9idWYoc3RydWN0DQo+ID4gPiBtdGtfd2VkX2Rldmlj
ZSAqd2VkLCBpbnQgc2l6ZSkNCj4gPiA+ICAJCQkJCSAgd2VkLT53bGFuLnJ4X3NpemUsDQo+ID4g
PiAgCQkJCQkgIERNQV9UT19ERVZJQ0UpOw0KPiA+ID4gIAkJaWYgKHVubGlrZWx5KGRtYV9tYXBw
aW5nX2Vycm9yKGRldi0+bXQ3Ni5kZXYsDQo+ID4gPiBwaHlfYWRkcikpKSB7DQo+ID4gPiAtCQkJ
X19mcmVlX3BhZ2VzKHBhZ2UsIGdldF9vcmRlcihsZW5ndGgpKTsNCj4gPiA+ICsJCQlmcmVlX3Bh
Z2UocGFnZSk7DQo+ID4gPiAgCQkJZ290byB1bm1hcDsNCj4gPiA+ICAJCX0NCj4gPiA+ICANCj4g
PiA+IEBAIC02NTMsNyArNjQ1LDcgQEAgc3RhdGljIHUzMiBtdDc5MTVfbW1pb193ZWRfaW5pdF9y
eF9idWYoc3RydWN0DQo+ID4gPiBtdGtfd2VkX2RldmljZSAqd2VkLCBpbnQgc2l6ZSkNCj4gPiA+
ICAJCWlmICh0b2tlbiA8IDApIHsNCj4gPiA+ICAJCQlkbWFfdW5tYXBfc2luZ2xlKGRldi0+bXQ3
Ni5kbWFfZGV2LCBwaHlfYWRkciwNCj4gPiA+ICAJCQkJCSB3ZWQtPndsYW4ucnhfc2l6ZSwNCj4g
PiA+IERNQV9UT19ERVZJQ0UpOw0KPiA+ID4gLQkJCV9fZnJlZV9wYWdlcyhwYWdlLCBnZXRfb3Jk
ZXIobGVuZ3RoKSk7DQo+ID4gPiArCQkJZnJlZV9wYWdlKHBhZ2UpOw0KPiA+ID4gIAkJCWdvdG8g
dW5tYXA7DQo+ID4gPiAgCQl9DQo+ID4gPiAgDQo=
