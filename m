Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3461EB43
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 08:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiKGHA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 02:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKGHA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 02:00:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D83657D
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 23:00:19 -0800 (PST)
X-UUID: 31dc87c0c557445dba6162184bc2cfbd-20221107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hbhxqcM3aZjtWvE600joT9ReATYmUTQIbVjSaMQP4qk=;
        b=d0PCMn48+7ISTpsuu3TxcjlBaMnbRiP2343xyijtU5BECcmZOy5OxF1HVfrvRGsVL7nT4KZqwIPtc/aSmlyL/JwTC8Prg9Yo5+njw0zpzgm71GPJxze4Sj6lXG7JAHzKooJ0d6Bvgp2vNjZv0eYEkvotTrdfEK1tSTjiff1o/Ug=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:ceabbaf3-62a3-43c7-9e5f-504dbb7dc3f3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:2692a3eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 31dc87c0c557445dba6162184bc2cfbd-20221107
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2130019941; Mon, 07 Nov 2022 15:00:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 7 Nov 2022 15:00:13 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 7 Nov 2022 15:00:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqw3qjkf17ZykGGKL4oOd2IiNuf2rQhjuqwvkF0agop+M+tOLxSWJvKth15s11oUzjY1mYtxFsgzpn9VTP0kHuM0qU+jd1k3ooxXLG6d0HVH7mNiNDcihosYlXMDZ1kHUrvG26zwz3RL3/vxCbLmtcMrDgkhvTwESJuC2vy2HHiw83Y8m33obk4N+Ru0mRB3azvjqA8pCTyXh0AG8YMIQX7lf/rJfkGElN73+P34uzXNl9YFCOJVKF+WWo00hzOsqeN/jaTx8sIRCBR2S1WrwPdUbBNEqD28aLHihsscNnjXsjqLdPSVYn+/5Vd46Ip2vcV+at5mHIGZts0yyb673w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbhxqcM3aZjtWvE600joT9ReATYmUTQIbVjSaMQP4qk=;
 b=iHLzbceViosXK0pk0xOmWDc1Rufa52K9xTP0M5BxXtOVPA8gCH/MfG5RiHZvUKHKJkq7XHYw9WpgYWkwzbGqXOPOUD1kTrQXPoDF/eHcrAz30t42/QcbKW2g/vJyCJhEnsfwZEzWej+VaVuNs9OBblM3cTmBeDwZQDfXEBv/uY0AX+DM0MM/CycxAIcLmj+HriOyY59D3W/C90PjVrBjl9sqDcYue4EUDnTisiFd886F/ZYqUXLxHfPic2ZjMZkraBqKwvPw5gmNab3dQLwNPSebiW1fcvFE4JBkR50V/QSLoYzlNSDAytI5dEWjxJNGuQSoVR/+ob57RFitxuaZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbhxqcM3aZjtWvE600joT9ReATYmUTQIbVjSaMQP4qk=;
 b=SV/YV3RUKEXn9KR01QMYDPZbPPh3uLzo4r1lzpazM74f/TVIt6719K2geQckMjQ8boKxz04ciWhwL5f5YjZqTkWIEBWLyM2aOtfE8dAr/qe8vUhinrNPH3AVpFss7vYRNKp6WYVHMx1ksUkCldYmu4GgjtDq+W4wKjXM/OY0Qpo=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by KL1PR03MB5682.apcprd03.prod.outlook.com (2603:1096:820:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 07:00:07 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::1173:ea52:a697:1f9]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::1173:ea52:a697:1f9%2]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 07:00:07 +0000
From:   =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>
Subject: Re: [PATCH 01/10] wifi: mt76: extend aggr_stats for tri-band support
Thread-Topic: [PATCH 01/10] wifi: mt76: extend aggr_stats for tri-band support
Thread-Index: AQHY7Ud2O9pZkRS5rEW8ZRq7/EVGPa4sPK8AgAbV5AA=
Date:   Mon, 7 Nov 2022 07:00:07 +0000
Message-ID: <46c2119c998796be483c716bfec052c99240f90b.camel@mediatek.com>
References: <20221031164000.17063-1-shayne.chen@mediatek.com>
         <20221031164000.17063-2-shayne.chen@mediatek.com>
         <Y2LxDLqPa45Xbe9n@lore-desk>
In-Reply-To: <Y2LxDLqPa45Xbe9n@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|KL1PR03MB5682:EE_
x-ms-office365-filtering-correlation-id: 1c971cff-c4f7-4c70-dce8-08dac08db435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4SgWQfn20H+m09WDJ/y1QNt3k0fHVDbxthmPVR/XzkILeNqrz5Rxuz6lUBvh15UC89XKB6Vfliwz04kvo46ZLnGd03FXHbWRLyrbkIlCsGs2JoxJmjyfrClt9Iehd9ln1AstFe7WLX9mw9OTfR1HTtgF+MRtM8J0XIr2Elpk1mfFQVyykIFuO2UWy/bl9LVeugBKICP0gzzTPGsgCPyQLWbFMzh6COD9HFraMiP/z6J0NWYuMsMYUW1YjGSMPQYgEXgnBz7KCh19ISCYmosGc00z4YRX1KjKoOVMwCIm1nnSyzbwjM5gKoFfm1HLJSybC0myWvaAhPJlaQhR8B7/h4/cT2yh35vVg1ywFkMJRmj8JTqUAvGsmedubfrlg4e3JDZFJVVYnefXiS1wWFJg4xTLdRv9S8NhTphecLUwGHPaywQ8ilNcWEfBW8wApgDo3i5ykqmAiWSBIIILzFDEzCaUFWn6DUB+wOUIQJDJtGJ4hSlD+2WWfq0PBmoA10N6xGM3v0dehmlkbeEIhGj8CzBPRqP7QLApXtWKm1e7Q8mfofUF/DAwcywvYtjSkBXF9pSUDmuHgk2SX9ntPmw5Y263djGLNRHtGYGlfJTdHKOOZRsJTBbA/Niv3BCIdh5v+syU2bbT4E61R0Qtq5tupuwrZ3Hcf57xv28nnfjPtMcXGLoG6Ztss1iWB0W9Nn+fUYpgEygphaGmm8cKfkOx2FN1uq9gy4AkkxIMbUjXLHVIK8uzBsS/TLm04+Pleg392adTEn3dQXBJog44VnEfzJleWlEbXyYb4t5aoGkg1DM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(186003)(26005)(6512007)(107886003)(6506007)(2616005)(122000001)(83380400001)(2906002)(54906003)(6916009)(478600001)(316002)(5660300002)(71200400001)(6486002)(41300700001)(38100700002)(8936002)(91956017)(76116006)(64756008)(66556008)(66946007)(66476007)(4326008)(8676002)(66446008)(85182001)(36756003)(38070700005)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWJoMkkxVWtldlIyM0hhSjV5enNPNDZnSmV2Qm14NGlxL0lkQ0MrdWZaNTYv?=
 =?utf-8?B?WnNUdDBkUEZSU1dPVWp1Uk1FdGRXU1E3ZTZvUmszZWRidVZEanB5QWNWRFJD?=
 =?utf-8?B?Mys4dVpUamJiK0ROaWFCaXp0czk1R1FKYjRHMkMzeGlCdkhXckNNQzZwK01z?=
 =?utf-8?B?MUNsUm91OUI2Y0w1ZWtCYkhzZDVYRnFCVkNBSUNlL2ppTmZ4RTRTQU1tVFlk?=
 =?utf-8?B?VFZpdkkxL200UjBTYkhFQmJlMnZNeDVMbFNkNGt2bitrUVVHM2F2UmVwRlc2?=
 =?utf-8?B?ZVF1ejdYNEd6bFBjSFlPQXdnRFp0dGdvK3FmYzdwRjRialUrM2sySGt5eWxG?=
 =?utf-8?B?Z1JVdXFJNUh2ZmhFT2ZIaXcvS2gvKzRNK3E0SENKZktoVkRIYW84REhOeTFG?=
 =?utf-8?B?RU1aQ0tHVmowTENia2pxN0s0YXFQa0Z3Z1NTZnZrK0gzZHpmNTIwZjR6LzhV?=
 =?utf-8?B?ZDgyeU8zVzRwbWFEanZZVFptY3FzSmlNK2R4bmhMMS8zcWNPU215TEhIcU0z?=
 =?utf-8?B?Z2M2ODQ5MWx4cUJUZEt6UHJZNWlpT0VzVzdseStQcXU0YmhuSEo5K0t3STZN?=
 =?utf-8?B?d1lmL3NsdXU0Y2VMb3QwZnpYK1VQN0lJc2hpY0NGaDlhVklGaVZBNG8rampS?=
 =?utf-8?B?TU1Sa0U3VnZZaWhTR3VzV1pzdmhyQUFRanVpSmJaYnQzL0ZkTTRHbGVXZWVk?=
 =?utf-8?B?TzR1VUJDemtzdnYyVDdKSDJEbStsdkVTNkYvVkV2dGtFb0Y5RjJPb3U4dkVj?=
 =?utf-8?B?VXpsakt0TmVURTIySXo4N2RuUVpiVVBydGtpd3l0WngxTXpqQ0w5b1dUNGsr?=
 =?utf-8?B?V2Z3VjRiZmwxcU5peXRpWm9UNkd1dE1jdkQyTWhGTnI1UVZFQkgwa0NqV0s2?=
 =?utf-8?B?S1NieFRIdjVDcWNaVFB3bWxqRjVFU3hKMWt6b200alViQ0RaR0ljZy9RdUlS?=
 =?utf-8?B?TVdxaEhqUkt1ejhJVHFpWEhDdzB5N0J1SU14OXNCNm5vQmk4eWRwMFYwWG93?=
 =?utf-8?B?MjFxQ0FwWWx6V0FrYk9mVzFiVVB3bVoyU0cwVmxDQ1ozQXRQMjBGZndKMDRx?=
 =?utf-8?B?Z1RrdGx1MDdlbmppeHJ3OFg4Mk9ZclJBMFIrSDkyOGxtQVp4Rkc5dEdNYktW?=
 =?utf-8?B?a2RaNGZDMVB1VklHVnR1cFg5NUVGVG41U3k1ZXFMU0xaY29mMFhiWU8vVE8z?=
 =?utf-8?B?aU44RkVGR0FVR2diVHhtNTZRTmtXR2kyWEh2MzZhUUZrRlJqYmtVczRyV0Y3?=
 =?utf-8?B?c1A2bHV2V29kU0l4bWlwbEw0bTFzRXVWZmpKL1I4UWJaYy9DVjU5RHZOV0Z0?=
 =?utf-8?B?ZjNVcHMwN1hDM0U2ME1qdFpZRk01dUNWZExYVHBCSDg3N2J0dDVTdGZBRFp4?=
 =?utf-8?B?aGtBNzdXYmRBTDZwSWJ1NjB0TUo4Syt4ckZ5R2l5VkJzajFGem1iMzlPVS8y?=
 =?utf-8?B?OXFtLzl0cTgzTUlZTGFBMitpQ056NXdDNHVVZUl5aVF5VWhXcFlKdEIzMUJw?=
 =?utf-8?B?SWs1d24yVlMvOWlqRmdwTWlBQXQ3ak1DeFVFSC9Lc2kwZS9wNU1oU0VsN2Nq?=
 =?utf-8?B?dDZPeHA4bzgxa2tQUGFBeVZlUlpJcFQvTmp6Z3lqOE5PazZLMUxsRUJYMzBL?=
 =?utf-8?B?UDR2bC9MYk9teW5NVGZxemhadTZZZVJGcHh1VnlTNmhQWkFTeVpNd3hnRFF1?=
 =?utf-8?B?NVpFSUZ5RVkvNk5hWUxabFZnQlZOWGVRVGowUUVYYjhGTzlGOFJ5YjdQeUYy?=
 =?utf-8?B?dEFyNWVaYWp0eWh5cWFGV3JpTktIM3o0aTJNUFErYVZtdURGTWZpWDA2NkNs?=
 =?utf-8?B?Y3BBNTVrb296LzJyZTNDU2JDNG1qb0ROK0tTMUo4d0p0bFpDTDhrZC9CK0pW?=
 =?utf-8?B?c3FpdFU3MHdxc0lXdGtxTEVtaHh1ZlFGN2E2c3pmbUxGa2JSbEJTNzdLR0VG?=
 =?utf-8?B?bVlUdjFKY2JwM2ErcW01eTBHU0xTWjhKTTR6S0luZFc5bkp6WlRzVmNIVEZm?=
 =?utf-8?B?cEJNNXpKdHhwa3pQT3hXeTJYNi9KeVRwUFdqdDRuVnBDMTh3UDhTUGhWR0lk?=
 =?utf-8?B?MDlLWXJNQ0VRc3hlcW1OTHBxKy8vV09RSEQ0L1M1dXF0dU9VOW5ZYmt3N010?=
 =?utf-8?B?YWpuaWU3R2p4VGFGSDNMdkpjMDU3eTNoS1FoaFYxMzFiNUpVdHduYWRXVXdR?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8190EFB5A4C77C45ACCE10BAFB7972B1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c971cff-c4f7-4c70-dce8-08dac08db435
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 07:00:07.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GE4LombfLbhHuF3NNG+N9Frvy8Wf/laxa58U7mx8NuNW1X1veNtiV1r4x6/Ya9YMZHq0dV2jbUdpih2CMIqF+n8gCjxsUymP3vPIhO7EWEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5682
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTAyIGF0IDIzOjM3ICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBPbiBOb3YgMDEsIFNoYXluZSBDaGVuIHdyb3RlOg0KPiA+IE1ha2UgYmFuZDIgYWJsZSB0
byByZXBvcnQgYWdncmVnYXRpb24gc3RhdHMuDQo+ID4gVGhpcyBpcyBhIHByZWxpbWluYXJ5IHBh
dGNoIHRvIGFkZCBtdDc5OTYgY2hpcHNldCBzdXBwb3J0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBldGVyIENoaXUgPGNodWktaGFvLmNoaXVAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oIHwgMiArLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgN
Cj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQo+ID4gaW5k
ZXggZjliZGYxNmZjNmM0Li40Mjg0N2IzMjdjYjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KPiA+IEBAIC03ODEsNyArNzgxLDcgQEAgc3Ry
dWN0IG10NzZfZGV2IHsNCj4gPiAgDQo+ID4gIAl1MzIgcmV2Ow0KPiA+ICANCj4gPiAtCXUzMiBh
Z2dyX3N0YXRzWzMyXTsNCj4gPiArCXUzMiBhZ2dyX3N0YXRzWzE2ICogX19NVF9NQVhfQkFORF07
DQo+IA0KPiBJIHRoaW5rIHRoaXMgcGF0Y2ggd2lsbCBicmVhayBtdDc5MTUgYW5kIG10NzkyMSBk
cml2ZXJzLg0KPiANCj4gUmVnYXJkcywNCj4gTG9yZW56bw0KPiANCkhpIExvcmUsDQoNCldpbGwg
cmViYXNlIG9uIHRvcCBvZiB5b3VyIGZpeCBpbiB2Mi4NCg0KVGhhbmtzLA0KU2hheW5lDQo+ID4g
IA0KPiA+ICAJc3RydWN0IHRhc2tsZXRfc3RydWN0IHByZV90YnR0X3Rhc2tsZXQ7DQo+ID4gIAlp
bnQgYmVhY29uX2ludDsNCj4gPiAtLSANCj4gPiAyLjI1LjENCj4gPiANCg==
