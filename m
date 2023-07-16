Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838E754D26
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jul 2023 04:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGPCjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jul 2023 22:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPCjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jul 2023 22:39:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B32701
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jul 2023 19:39:15 -0700 (PDT)
X-UUID: f2068498238111ee9cb5633481061a41-20230716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fabVMVGCAOX8xQQ+IB04GzpfT1QZB9u9HVaNYc5QIv0=;
        b=awdPMeEg0J3BnD3zqXygouaNPWQGDZTPbb85aAftp53kBQ2KDtvtnBjSo/v0WNleGi41KoYnYptpdKAhHb9o4W7YXv7CQ3On3GCV2edC6LR0yUFzROEC1T2avBz2pF4heYXEvu54UDRFXDXmZSiN7bL79/OcvnJZaCwIFn5dKVQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:b652ce23-3aee-4b7c-b94d-ece68878d5ce,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:b652ce23-3aee-4b7c-b94d-ece68878d5ce,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:2a9ca3dc-dc79-4898-9235-1134b97257a8,B
        ulkID:2307150000328B0QKP81,BulkQuantity:7,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: f2068498238111ee9cb5633481061a41-20230716
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 263430788; Sun, 16 Jul 2023 10:39:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 16 Jul 2023 10:39:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 16 Jul 2023 10:39:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmdmvnBNz3p31e1Gw1j54bty78zoGnjYOjh1nwnVOJj8F+hmjRkHEW/tkQk1F3KneW6Vdd+IH2CrYvQvorAuFV2D3JqfCT7rOevgj9NZ7IiUplkGnU0iW77Km5AGpGw0hi5wV6ai4S/vGNf6hQaqGz7UmiKfhoTonEnq2EjMwhxkdKDQtuvPU25vgreXG4QLJ2au5oAvhJv4jV5De9dwHtkJlJS0vJ/RS3OPfO0hK27yb09HxfjUeSQ13Nf+iOBFTbRDF7d2Eny867qg6UuSpXVTUCnlKPyQbZyKfIf/imxUvqXf/lu7AWBHwsjEx6OIPQu9+hOhkwme436jcJPFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fabVMVGCAOX8xQQ+IB04GzpfT1QZB9u9HVaNYc5QIv0=;
 b=OuVF7x3tznHRibS40zENggPQDFXfbG4cq15s3WwtRt4mBHXUsHV3PECak1xk2IEvx3JxnoY7r8uZkCJI8IKqcy4U18GNeXbG3FAnb1u5a4ajJDveZ95vkqogFzsDRFTLiZ9+ueC1Eeb9o0DdD0fFAp3t9X7ZouKe6rvyNPX1ZMgOdxy7xbqgSifb6lCV+l6H6uznq2OAgUItC3vO1wMEdyPsaClfPjSyXv8aCO4aLISmWh5QC4tBUXAHRtP0hDln3nIFYd8C0nUXzqshs7WJdnGw0XCU27Fx5lNca/9mtjHkST5BJsZJuxfoU6CMyvoDMr/nl0xEpIyUhXvfQW/FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fabVMVGCAOX8xQQ+IB04GzpfT1QZB9u9HVaNYc5QIv0=;
 b=dF1vZoJPTQZDsiAQY1LWuGICJ2NtPAUV9IlRdnZkrp2Kk+1+AtkQR9tqd1z1LvyS7DGoAaQ3/SvBibLkVkXwG2+BybMOQYGOLRsZCBzmApoPixpRm/kEXnbeOEbIMHVtJiSY4Ak8ZwETcFl9U3ZoYIB1zof2J+0QqliscwN15vI=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR0302MB5267.apcprd03.prod.outlook.com (2603:1096:820:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 02:39:08 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::b847:91cc:cd1e:dee2]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::b847:91cc:cd1e:dee2%5]) with mapi id 15.20.6588.028; Sun, 16 Jul 2023
 02:39:07 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "greearb@candelatech.com" <greearb@candelatech.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: move mib_stats structure in
 mt76.h
Thread-Topic: [PATCH 1/3] wifi: mt76: mt7915: move mib_stats structure in
 mt76.h
Thread-Index: AQHZtmxogHjJMIdTt0aNhiBHPJay7a+6uWAAgADK1gCAACxSAA==
Date:   Sun, 16 Jul 2023 02:39:07 +0000
Message-ID: <d41cda4a6695b20e028fd0dd49692ed6a6351045.camel@mediatek.com>
References: <cover.1683930235.git.lorenzo@kernel.org>
         <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
         <486cb426-737e-fa57-20da-344fc44bb4de@candelatech.com>
         <ZLKI9tiNytMl8Vlo@lore-desk>
         <a168df1e-573a-43ba-b466-b7e5784dc2ff@candelatech.com>
In-Reply-To: <a168df1e-573a-43ba-b466-b7e5784dc2ff@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR0302MB5267:EE_
x-ms-office365-filtering-correlation-id: 7934b8b2-5ce4-480f-d82f-08db85a5d41a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rG+Oodz8C21l47h53FryIsvXDFKsuq0q3DQkAmgpxOkr2sY66PQrOA3gDXeKKusyCLO8AmLxsDCzfXYwsrNsZTyap0qMa2gfk1S91odQ9pQuhGMw6K0JNkRzyWrcj8te06h6LLV4AXM2+jxlLQteI0kK0eL7HXN8CCEfu9YFiQ/XzJgdutBgcUDLMeJY62MO0VUa9e67ldxxJu7OmkqzA2iCfbsDTLsYv7ODieQSW6mY9HkFXZWoEFhjaqEBuE4TKuzgJSb9hoPsPh6o7wCzHKOVQR7SzrELlyId+qaxqKcFXdRcqxIoW0DBvB0AD//TL65wweyLdydnu96QfuJJ+uquWq6EbwsBDAQ3qefOu77Vo0prplePsojQI1nDavcLRXZa4uoleooHNvIo096XSQmLEXSHBLpGNaE7nrBZ8XiefXsXOIoxKTBA6c2n/k79pVQ0Lqwg8qWxs3Kaz91upjD+6ZNlPpJhifMdzwSKYaj475L1yjTA3K+0LU++j3ueXKAZ7Kgh8lXDkF2ETOD0tM2kDAg/BWTxUG1/mkagTxam/h7S2ZA0RkN/tHv4l2dETx7l4RpCHRz94ohtc2p3dg9UhyP5oCkdsO3hcyivQeGcpS0/HfVp1Epy26jR5sjo3MjSm1T6S4MyScLK74tSxMQCnEdiIc6n+9218vswcUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(136003)(346002)(376002)(396003)(451199021)(54906003)(110136005)(478600001)(26005)(186003)(71200400001)(53546011)(6506007)(6512007)(6486002)(83380400001)(2616005)(86362001)(5660300002)(38100700002)(8676002)(8936002)(41300700001)(316002)(4326008)(2906002)(36756003)(38070700005)(122000001)(76116006)(66556008)(66946007)(64756008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wi82WERUaE0wMXBBbEQ5ZjA0L0g1dWZFNkYyTHl4ZmJUMGxUYm90Q2JkWGlS?=
 =?utf-8?B?d3IrVWpaMkN5VnQvbml2UU5RVVNQMENES1NOakx0bEZuQlVRWDk2eXRMS1oz?=
 =?utf-8?B?QXdYMlhXUGZJTkx5Q0lGeTNxdFdQSFRVU3FCd0c2Qm9VNkV4QmJiYWw5Vm5H?=
 =?utf-8?B?dGUrZE9BNUtoclpkMzVuTWIxeTBzSmhMM1YxeVJnemtER3lodmFxcWxwNmRp?=
 =?utf-8?B?bkJyOXZOSlhQRmxJei9takh6OC9xL3lpWWpNUE8yVTZueUpFSnZ6bkJxdmlw?=
 =?utf-8?B?TjNsM0FCaUJVeUlST3BGVEhWVWlqbjc5RFUxaDhWYTN2eTBWODE1N20wZU92?=
 =?utf-8?B?ZUNqV1VCandJNEFWMXg4V0NTbnRZVzJwZkFaTkl6RnZSTlBQRVpQRGphdG9Q?=
 =?utf-8?B?SlpnVW8rVGc2b0YxcnBvVjZvWlBicnluMllNMXlGbUlvZDdVVTZrU2c3YVI4?=
 =?utf-8?B?c0c3QTBaYXNDcUhIZ29RcE5INXQ1eUhFbG85MVA2VWNtZ3VRRXE5SGN4Qi9N?=
 =?utf-8?B?eThFYnFGdlVnYW1oRkZuUFpEL3liNTRjS09nYzFwbmp0M3hTQTNKejcyZjJq?=
 =?utf-8?B?azllMVUyeEpWOTZTcy81Q25DbFhLYlVSRGQwcUorU3Q1eE5OWGVFS0FTcEpF?=
 =?utf-8?B?NHpxcnM1NFhPUFpxM1dBOGw0Q01hVWs0VjdZRWdhOGhFbVRBRUV4dEt5dlUv?=
 =?utf-8?B?eGFxWFRCcEpyRFpQWE1IdHhDQWVWSS9VbXc1V1dWSC9ZTGFrZ1RyZjdLcUor?=
 =?utf-8?B?VmZNMzlIaHIvUE1qN0RWOFZWRkpzYUsxZ2FsZlYybjVCTWR1c2ZhbSs1WDl6?=
 =?utf-8?B?VnQ0d0szR0dBMWlXeHJ3WWJ3bHR3b3l6azJhaGZGelpFNFpDeGNQL1dCWnNV?=
 =?utf-8?B?aDJ1NDJaVHY1Y2NhU3BWU3U2WDNDN0gyN2h4c0VRMkRySWdCbzVLc3RCRjNH?=
 =?utf-8?B?MEhWRGk4VWhMcUZNTG5rUTVybkFtTE84dlNnTjd4MmdzZ3BzVUJMWFVVOWJj?=
 =?utf-8?B?U3Qvb2lGcWE0RjRwYyttYi92R1hMTkxNVnNoaldmQVRKb3RMY2REb1BLOEgw?=
 =?utf-8?B?TlFFYnh3VlN6anhMS3pWcFZSbUJxd2lkYzNtcU1tNExONkRyWUZCQmZWV3RI?=
 =?utf-8?B?cktZcUVsYktKTVRqdjJaV2JhSVZ4bVBJTEhNNnFZODFOUzBIcHdDNmx1dWZw?=
 =?utf-8?B?QVh2SW5tRkNEWnR3QnJjKzBmWS8rWGFBcDdnUytQYUhVby8zTk02TExPOU5T?=
 =?utf-8?B?V1lVS0orTlR1SWIvdmRpN1RpQUxNcTRESW1WQjhLWFNITjZua28zOENSTEFa?=
 =?utf-8?B?d1g0ZGxOdS9Qb2FsdWdPUGhMbVBxdGNkWFFuWE5Rc1BFdithekxPN1EyTlFp?=
 =?utf-8?B?b2tsYkNzb0pQQk53ZnRhM3BuTjFCY241cDhiZ1d2YnNDMCsvbGxnYnNnWkp4?=
 =?utf-8?B?U0ZzOWZoQ1hUT2pmdDdBTlpCMWN6UFNad0lkVVhHbFVQRjVTVEJESHBFd2Rk?=
 =?utf-8?B?RVFtVXNVaXlBWGpuRkduQ1ZER0JaRVlGeEtOOFFiTWlxaDZRelM3OGNTOWtF?=
 =?utf-8?B?bGdkM3AvWFI1d0g5K0d1cmJjcmFVUXN2MFFlSUV3SWRlbGM4RWp4RzVib3dn?=
 =?utf-8?B?MEVIc1lVc2w2ejFQSXh5YmhLeHlPN2FRSHdxaThscVIyZkZNa2hIY1RHcXo1?=
 =?utf-8?B?TFp5eWFISk44V3pQd09BTGZ1NzlPdDQ0YVJ5c2NrR1Y4eHJTZEdZaFBGTUNr?=
 =?utf-8?B?UlpnZDV2S3FzU2g1c1NFa1NpenBnS1UzZmdoa0doSDVUc05RZ013MnFoZ1hi?=
 =?utf-8?B?aGx5S0NwYSt1NGdrK2tlTGlOa010WTFIcUJuaEcvaDZreEdZUEF0VW1SaDZl?=
 =?utf-8?B?U1hoMjVTZ2x4SmpJd1Fsa1YwQmtnQlNlcUpjU0lESDhvbFE3SVJiSVRRVjc1?=
 =?utf-8?B?WGpteWFkRXBwRnRYdVkvRUd5TFprUTUybUFmRFNxMmhGdEptS2cxZVNvWEN1?=
 =?utf-8?B?SUxyWkswUWI0a1dFcUJsRng2d3J1M2dWOUJWSXpoL1JhbFJuaURjUjcvaStw?=
 =?utf-8?B?RVJMWUFydVgwQjRrVm5CRXA0QWNPenNUcTVwQlVMS2dWVVNhSDlPME5YNWMv?=
 =?utf-8?B?VVpQM3ZNeXU5L3dCZWZCL3VCT2hyZThjbVNGSWxMTVk3SWd2aWQwclR4Z1d2?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6EAE229F579B34FA02C77CF3E46C80E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7934b8b2-5ce4-480f-d82f-08db85a5d41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 02:39:07.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdrWIlcg4kQZ9N1DlGMTvPtKZA/bivnIuz6W4zgHQSnMcyJ5N+iUkObS5kLvfubPm3zsFqVp31OaxbzeWrXdyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIzLTA3LTE1IGF0IDE3OjAwIC0wNzAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIE9uIDcvMTUvMjMgNDo1NCBBTSwgTG9yZW56byBCaWFuY29uaSB3cm90ZToN
Cj4gPj4gT24gNS8xMi8yMyAxNToyOSwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4gPj4+IG1p
Yl9zdGF0cyBzdHJ1Y3R1cmUgaXMgc2hhcmVkIGJ5IG1vc3RseSBhbGwgY2hpcHNldHMuIE1vdmUg
aXQgdG8NCj4gc2hhcmVkDQo+ID4+PiBjb2RlLg0KPiA+Pg0KPiA+PiBJbiBjYXNlIHRoaXMgdGhp
bmcgaGFzbid0IGJlZW4gcHVzaGVkIHVwc3RyZWFtIHlldCwgdGhlbiBhDQo+IHN1Z2dlc3Rpb246
DQo+ID4+DQo+ID4+IENyZWF0ZSBhIHN0cnVjdCBtdDc2X21pYl9zdGF0c19jb21tb24gY2xhc3Mg
dGhhdCBoYXMgdGhlIGNvbW1vbg0KPiBjb3VudGVycywNCj4gPj4gYW5kIHRoZW4gcGVyLWRyaXZl
ciBjYW4gaGF2ZSB0aGF0IHN0cnVjdCBhcyBmaXJzdCBtZW1iZXIgb2YgaXRzDQo+IG1pYiBzdGF0
cy4NCj4gPj4NCj4gPj4gSSBoYXZlIGFkZGVkIGEgbG90IG9mIHBlci1kcml2ZXIgc3RhdHMgdGhh
dCBuZXZlciBtYWRlIGl0IHVwc3RyZWFtDQo+ID4+IGFuZCBhcmUgbm90IGZ1bGx5IHNoYXJlZCBh
Y3Jvc3MgZGlmZmVyZW50IGRyaXZlcnMuDQo+ID4gDQo+ID4gSSB3b3VsZCBzYXkgbXQ3Nl9taWJf
c3RhdHMgaXMgcXVpdGUgYSBnZW5lcmFsIG5hbWUuIEkgdGhpbmsgd2UgY2FuDQo+IGRvIHNvbW90
aGluZw0KPiA+IGxpa2UgKGlmIGl0IGlzIHJlYWxseSBuZWNlc3NhcnkpOg0KPiA+IA0KPiA+IHN0
cnVjdCBtdDc5MTVfbWliX3N0YXRzIHsNCj4gPiBzdHJ1Y3QgbXQ3Nl9taWJfc3RhdHMgbXQ3NjsN
Cj4gPiAuLi4NCj4gPiB9Ow0KPiANCj4gTWF5YmU6DQo+IA0KPiBzdHJ1Y3QgbXQ3OTE1X21pYl9z
dGF0cyB7DQo+IHN0cnVjdCBtdDc2X21pYl9zdGF0cyBjb21tb247DQo+IC4uLg0KPiB9Ow0KPiAN
Cj4gSSBhbHNvIG5vdGljZWQgdGhhdCBSeWRlciBhZGRlZCBhIGZldyBvZiBteSBwYXRjaGVzIHRo
YXQgZXh0ZW5kZWQgdGhlDQo+IHN0YXRzLCBzbyBJIHRoaW5rIHRoZXJlIGFyZSBwcm9iYWJseSBh
IGxvdCBvZiBzdGF0cyBpbiB0aGF0IHN0cnVjdA0KPiB0aGF0IGFyZSBub3Qgc2V0IG9uIHRoZSA3
OTIxIGRyaXZlciBhbmQgcHJvYmFibHkgb2xkZXIgZHJpdmVycyB0b28uDQo+IA0KPiBUbyBtZSwg
dW5zZXQgc3RhdHMgYXJlIGNvbmZ1c2luZywgc28gSSdkIHByZWZlciB0byBwdXQgc3RhdHMgdGhh
dCBhcmUNCj4gbW9zdGx5DQo+IGNvbW1vbiBpbiBhIGNvbW1vbiBzdHJ1Y3QsIGFuZCBoYXZlIHBl
ci1kcml2ZXIgc3RhdHMganVzdCBmb3VuZCBpbg0KPiB0aGUgZHJpdmVyDQo+IGl0c2VsZi4NCj4g
DQoNCk15YWJlIHlvdSBjYW4gYWRkIGEgcGF0Y2ggZm9yIHBlci1kcml2ZXIgc3R1ZmYuIEkganVz
dCBleHRlbmRlZCB0aGUNCnN0YXQgZm9yIG10NzkxNSBhbmQgbG9yZSBhbHNvIHNlbnQgdGhpcyBw
YXRjaCBmb3IgY29tbW9uIHN0cnVjdCwgYnV0DQplbmRlZCB1cCBtZXJnaW5nIHRvZ2V0aGVyLg0K
DQpSeWRlcg0K
