Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E569F50C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjBVNDT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 08:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVNDR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 08:03:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5336690
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 05:03:14 -0800 (PST)
X-UUID: 4298e12cb2b111eda06fc9ecc4dadd91-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=P35yEMXXa0PFdLkUkoN4EG6S4Q5vMBM3U3H6QmRdriU=;
        b=N7X39HEljw+tILMuT/XfnkHBMAOZumJDdxDd/sn8Gh63aV/7CNvFY+EGiVNY8HhI1jGLjHpD7Oy/5FW9CkH7vIby3OKLbVPugiKFSsepeIh0+1YAftuKfWavEH4SpzntFsymwV7X2eEZYdgHE3TBE+SjjSpRYP9dO+FIrN+3hP4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:dbc7376c-d4e1-4da4-b3c6-64a6a1c4fcee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:d38840b1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 4298e12cb2b111eda06fc9ecc4dadd91-20230222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1937346036; Wed, 22 Feb 2023 21:03:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Feb 2023 21:03:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 22 Feb 2023 21:03:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS95Nr46DHECOFTcKRWJT/TYAFMqZJ+b+Fifny4MbzfO/DMJgdDKuivKQfyy0NA1DyBwr7z3ntR208aFMIi4xjvMEe4RH28uGYW0GTsbEp7DMbVsipp3QG/O1hg/PRqOe7tvLcIDXEU3CwvqutgTiFygQrwBdWrvolZLfk1ChicrF2okVevp2/ofMsiZZJOxy5AdPFRBofEgbukZIxh7NJnIRhjmI/oqblCNvaZUUxNguUAC5ui4nAsh9c3JvxERs7FmuTIK3uHzAS2UJN+f98xlyyF4A3Q2TJZ1VeJzXhAmYgNPEcseRLz+N6RfkB/+/WrGI24NaWJrv9v0FvXrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P35yEMXXa0PFdLkUkoN4EG6S4Q5vMBM3U3H6QmRdriU=;
 b=St0dxyUPZ6Ou6RrSUNUjbNgpWOO3xSArPRrnqgNNOVHDyM9eF9eaDDW3wX8LO4hNR+K90/s7ijXeAeTaobJjSojU17T3BFMIz175FvUb419TrqQaJ4adsGGjjiBOqhio7gI7tY50ZaWJsaLcIeP+1E0umgBow9L1FXCV2cVBBemZHozVsGHyrt2MwIh1AWMm7Q6kwb/ZrCEGDVkoz5BGYk56UbqOtoVMdhZnsniLjJ8bjjyH4SwNUG4i/7xNM6yeTPp8n822NRU4G3ZnmZTEYVcqqyFZ2Uapth8JK8SN+v0JL9Q4WZiLx2mtsuGcT4ma6kHPEWOL2GvWBH5+kA1GEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P35yEMXXa0PFdLkUkoN4EG6S4Q5vMBM3U3H6QmRdriU=;
 b=gGQE73jYsuixuGoJ7pZALnwMPb6BJ3QAp1hQfLqmpbCQG+rl3UMZdpynXNKbBktbOISn3tKTlf0esNlrQduae2d3gHLBP03E16nc3aLek7Lq5PqH08R2mduZ2JjogD4S8LnHniUiCwW05w1qVpDa54go0fUk5VeePcbm8LmptlI=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by PSAPR03MB5687.apcprd03.prod.outlook.com (2603:1096:301:8c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 13:03:08 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::675:89b6:b9f7:f407]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::675:89b6:b9f7:f407%5]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 13:03:08 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7915: add dev->hif2 support for mt7916
 WED device
Thread-Topic: [PATCH v2] wifi: mt76: mt7915: add dev->hif2 support for mt7916
 WED device
Thread-Index: AQHZRpzpAa7xwRuojkqS0xzpJ0TMF67awk0AgAAsewA=
Date:   Wed, 22 Feb 2023 13:03:08 +0000
Message-ID: <4742bf20e11542b4af8446b7417eb782362c86b3.camel@mediatek.com>
References: <73e1988a12a60fa0c661edc8328a302b92392b94.1677056399.git.sujuan.chen@mediatek.com>
         <Y/XtOhW5fUshrUPY@lore-desk>
In-Reply-To: <Y/XtOhW5fUshrUPY@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|PSAPR03MB5687:EE_
x-ms-office365-filtering-correlation-id: 6c63fc0c-f08a-4584-403e-08db14d5250f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/sOFmwBCsRFzicP778Z4JzCHfe5QZtjveNJgRlTaKuKVHdyD4EY11le6IiMjvK9fz9koYo0vKEiEg+DGzV9YmUJtdyVSbqFcTgWLlm45lF13g6OwLE6ScSpK4uVsb0VGeLtkm8nvdHdlsdWwNd9CDQLA7D5TAGB4vg4XLzriCr1AY/XyY2KKPIgJyt8aw1AGhsoPf7P1typtMu74Sf1CiVt0BCOhS9jAafmfXnkV36R6zd8tpVTF7PkmiySP8TeJfaaY5ecGNjO6pUcVRQehmfHPe25hLfKyxEHrvcM0E8Tks8KNTNRgvG6Hfp8eUSxnAfRMn5CLOlCAdpAILHCZBYDa4iRFiyEkuGhm3tH42QX9MetqcMYwI/rKXnJS2/yyEr/pNaA4meOZT1IEv1Ifou580Y2RRB1hhUPqcy8svyG97qlB7M9ZokkzwmMUqperRgl+Q2sNbsjc7NWlaEbB5IUO0tXV/BOuMxHG4NmGOdhhx2OPi1ywTvS0SE0RkywBxhgL12XcF1TkvvBRZMKcVjcRG7P4MWMbgq7TWkwXxtJnD9tqsZvD1RFPcGlf4TLMwrliv4aUNF02UaezQmDgYnYKV3rQwObUPuO5Kfvde7Mo7VeamZF7c+33F1O/W2yqpcqtr64l6KpSPdd2xYBJVOekPyNmXzYjywakVhMpBpt8hYtHkDZUYqfIiBhAaw9gaVY6QfEAl1qxUL8YgBghocTNcynOLw/Gc0mByxfNMT2eUhHWrqMWLRAD2/ExNjX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199018)(83380400001)(122000001)(6512007)(4326008)(66446008)(26005)(8676002)(64756008)(478600001)(316002)(6506007)(71200400001)(66946007)(76116006)(66556008)(66476007)(186003)(6916009)(38070700005)(36756003)(85182001)(38100700002)(86362001)(91956017)(107886003)(2906002)(41300700001)(8936002)(5660300002)(54906003)(6486002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WithNnFSSTc1QjlTQS9aSzVkSVlKZXl6UXFNb1p1MUNnWGl1b3p3UFNFalln?=
 =?utf-8?B?aDhyTjhlaXAyNTBGTlRzSXZicXpNVG1CZktOZkVUVzB4VkVTbDZ3K1hqYUpq?=
 =?utf-8?B?M1ZEellUMmx6QWtidENVRndvS3dmajFpSnIzbzFLWmlJbnovMGJndnBDZTZE?=
 =?utf-8?B?eDB1d0wxa3R2RzA1ZFdBL25uREh3MU1wQU5hT3NRb1E0alEwckRlVDEwUU1n?=
 =?utf-8?B?SmYzWkl6NWdVVy9acmxtWGFZS3hkRjBNVHVNZzlVTE5ZZ2pSNGduL3ZucHB0?=
 =?utf-8?B?VVBreUNBaWZSZVFwdCtPazZRc25qNHVPY0ZWRVYyTGFseml4aHZlbU9ieEZo?=
 =?utf-8?B?UHoyN3FaOHBEbWdlWitITWxIZ2I2eE1naDI4TmJjeTc2VUJyZmFVUkIvTlJP?=
 =?utf-8?B?a2VPRURYYUkrazJBalVWR0F3aGVYeGtzcTBRcGI3ektpSWhOb1lDN3JYSTFv?=
 =?utf-8?B?bHhiUkVWbVdUZnhpc1BaZ25pZXF0VmRZNXNsL05ESVNtQm5ESFlTWEtoVXR2?=
 =?utf-8?B?ZGpVT0xiVm1lMkVaaDZmYmZVd1RzMThoZmVBaXFid1VNN2dXZXl2NkxReXNM?=
 =?utf-8?B?cmpKWmtlSERuNmc5TlBIR3lXK1o4Ti9WeGlZdzhZVDR3RU1ETlJ0MzhmakR0?=
 =?utf-8?B?bXNCY3J5Y0RUcmRGNmd4VXJOTERsUnluc2xPK2JPdVljTWl1RjdDeXZjZ0Nm?=
 =?utf-8?B?ejBZTVgrVVV4OFdtWXlhL1RDN2hXNUs1YzVDYStqMUZCRXo1cmtEbEhHVkta?=
 =?utf-8?B?dm90aHZYa2R4T0lKcmt4L3lmYzRsUEljZkVTSXBFNlhRdERVeUdzY3djQ0hK?=
 =?utf-8?B?UlBBWTlneW5CdUJzYXJBeDR4NDdDdWIzQ3AxMFBjbUlZazFEbnlqOVI5Smw0?=
 =?utf-8?B?N3p6bVozZzc3WG9DSjRvdWlEcVQ3YnhpTmlLVlJ6QysyUTUwb2J1KzJKQ0I5?=
 =?utf-8?B?VkZneCtpV3UxSWo5VEZJemxDRzdWU3FmMW5pSUtsUzl1TXlMaE1vdHdNSmxK?=
 =?utf-8?B?NFNPMDNHdkFzWXIzNkpIbGZRTlZ2eXFLSWc3RC9DTWpVRDZtRXFkZ2N1a2VP?=
 =?utf-8?B?cEExeHhrRWZmRk10RzNvYXdodlg4TkVGRE5zUGdQbTkyUnVxd0h6bzVnWXJM?=
 =?utf-8?B?N0Y3a0ZLTGRKUFg5TFpIN1djOEVlSmIvNUVIYmhhUjZySFNlRzR1Und6bFFJ?=
 =?utf-8?B?K3ZKOFJHbENadU1ORm5Jd3N2dlRrSVU3Ymgrc01CZVI4cVBKcXdnVCtWemVY?=
 =?utf-8?B?MW5LeXhXNGpFakNYVTdRNXFqajFzMERsV0dtVHlQVzJwejRSVXpsK2tEL2pp?=
 =?utf-8?B?NkZ6bWRXd2s2akQ4c0JFWENmUXdQME9uSGpJS1BwbzBIcm9HM3FNbGsyVTdS?=
 =?utf-8?B?QjZpNnRlcnl0aUFYTkhFY29NRCtPVHNORFN5U2xnb1VyLzc5a0I4YzlsbkdM?=
 =?utf-8?B?d09BenJNZFlUM3M0dzlPUGVrb0Fuak1OOXltYTRGODNCbndOVXdMdVdDRWhr?=
 =?utf-8?B?MExHY1I1RjFoMlZIcnpPYkxoOUVkMWQwdU1jbTNVOEZyakduYm5SWThtZEFK?=
 =?utf-8?B?ZFp5RDg4TlhNY3ozVjVJeGY4Umw1NG9zTC9HZTFacTV5b0JidWVpYzMveER0?=
 =?utf-8?B?QWZuYVBwdkduNGxBQ0NFbmZZUkpGa3JCRXFpMk5ldmNLKzd6ZmVkSHpMVk9S?=
 =?utf-8?B?QWVZRThKYmRsL2hSaHNqczVPcXdBUkZRSTkrVURsbWE1NnN3dHpZM28rd3Mv?=
 =?utf-8?B?RVJpN1dqYlVUNlZzWkswb2FxR0Zvb0JlMVZiRmxxZ1NlRlk4NlhQSGlyVnJk?=
 =?utf-8?B?eTRQUHBqZGJKcGE5R3VCMmpEU0J6NjdELzU3K1RMTzVtNTFON1YyWVNxOWhl?=
 =?utf-8?B?OXNPd2dIWWR6ajEwYUx5ZVFiQ0pQOUdnUTRrM1l5TGRkQXFSTUZ5LzRBV2F0?=
 =?utf-8?B?djYxMGtQUGdhNGhkNS9zVlNzYjZsdkNUUnU3ZFdKczZDSmJ2K0JNcG5rclNz?=
 =?utf-8?B?OEV3bjdFTk81NFhPZnNtMWlpa2V5UFRnRXM5M1BmbFJWdC9VUDJtNWc5dmJC?=
 =?utf-8?B?Q3A1YVVzSVhLZ0hVVGZqdThrMDVUb0NUdGVsQUlpalBhbHFVVnVRVjMvWVJX?=
 =?utf-8?B?KzZ3V25QWnJ3VHk3ZUk1YlhsaEk5Y3JrT2oyRzUvbXZ0UTJVaXRhdmRZb3Q1?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B752DD143B8BF64EAE903589522EBC8A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c63fc0c-f08a-4584-403e-08db14d5250f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 13:03:08.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTUIl88/nmjvPqacvXd4eirnPdxgQTMt7OjmU8qAVPXzZRaqQvIx+GBVtenWMV06nJGU8WwAPTj+4Dn6+anK/hrzdH0i8eOmoigAv0aOY1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTIyIGF0IDExOjIzICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEVuYWJsZSB0d28gUENJZSBpbnRlcmZhY2VzIChkZXYtPmhpZjIpIHN1cHBvcnQgZm9y
IG10NzkxNiB3aGVuIFdFRA0KPiA+IGlzIGVuYWJsZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogU3VqdWFuIENoZW4gPHN1anVhbi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZG1hLmMgIHwgMTAgKysr
KysrKystLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYyAgfCAgNCArKystDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21taW8uYyB8IDEwICsrKysrLS0tLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kbWEuYw0KPiA+IGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZG1hLmMNCj4gPiBpbmRleCBhYmUx
N2RhYzk5OTYuLjQzYTU0NTZkNGI5NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2RtYS5jDQo+ID4gQEAgLTg3LDggKzg3LDE0IEBA
IHN0YXRpYyB2b2lkIG10NzkxNV9kbWFfY29uZmlnKHN0cnVjdCBtdDc5MTVfZGV2DQo+ID4gKmRl
dikNCj4gPiAgCQkJCSAgIE1UNzkxNl9SWFFfQkFORDApOw0KPiA+ICAJCQlSWFFfQ09ORklHKE1U
X1JYUV9NQ1VfV0EsIFdGRE1BMCwNCj4gPiBNVF9JTlRfV0VEX1JYX0RPTkVfV0FfTVQ3OTE2LA0K
PiA+ICAJCQkJICAgTVQ3OTE2X1JYUV9NQ1VfV0EpOw0KPiA+IC0JCQlSWFFfQ09ORklHKE1UX1JY
UV9CQU5EMSwgV0ZETUEwLA0KPiA+IE1UX0lOVF9XRURfUlhfRE9ORV9CQU5EMV9NVDc5MTYsDQo+
ID4gLQkJCQkgICBNVDc5MTZfUlhRX0JBTkQxKTsNCj4gPiArCQkJaWYgKGRldi0+aGlmMikNCj4g
PiArCQkJCVJYUV9DT05GSUcoTVRfUlhRX0JBTkQxLCBXRkRNQTAsDQo+ID4gKwkJCQkJICAgTVRf
SU5UX1JYX0RPTkVfQkFORDFfTVQ3OTE2LA0KPiA+ICsJCQkJCSAgIE1UNzkxNl9SWFFfQkFORDEp
Ow0KPiA+ICsJCQllbHNlDQo+ID4gKwkJCQlSWFFfQ09ORklHKE1UX1JYUV9CQU5EMSwgV0ZETUEw
LA0KPiA+ICsJCQkJCSAgIE1UX0lOVF9XRURfUlhfRE9ORV9CQU5EMV9NVDcNCj4gPiA5MTYsDQo+
ID4gKwkJCQkJICAgTVQ3OTE2X1JYUV9CQU5EMSk7DQo+ID4gIAkJCVJYUV9DT05GSUcoTVRfUlhR
X01BSU5fV0EsIFdGRE1BMCwNCj4gPiBNVF9JTlRfV0VEX1JYX0RPTkVfV0FfTUFJTl9NVDc5MTYs
DQo+ID4gIAkJCQkgICBNVDc5MTZfUlhRX01DVV9XQV9NQUlOKTsNCj4gPiAgCQkJVFhRX0NPTkZJ
RygwLCBXRkRNQTAsIE1UX0lOVF9XRURfVFhfRE9ORV9CQU5EMCwNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCj4gPiBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQo+ID4gaW5kZXgg
NTU0NWE4YmRmMWQwLi4xZGZiY2M5YmY3NTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KPiA+IEBAIC0yMzcwLDcgKzIz
NzAsOSBAQCBpbnQgbXQ3OTE1X21jdV9pbml0X2Zpcm13YXJlKHN0cnVjdA0KPiA+IG10NzkxNV9k
ZXYgKmRldikNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4g
LQlpZiAobXRrX3dlZF9kZXZpY2VfYWN0aXZlKCZkZXYtPm10NzYubW1pby53ZWQpICYmDQo+ID4g
aXNfbXQ3OTE1KCZkZXYtPm10NzYpKQ0KPiA+ICsJaWYgKChtdGtfd2VkX2RldmljZV9hY3RpdmUo
JmRldi0+bXQ3Ni5tbWlvLndlZCkgJiYNCj4gPiArCSAgICAgaXNfbXQ3OTE1KCZkZXYtPm10NzYp
KSB8fA0KPiA+ICsJICAgICghbXRrX3dlZF9nZXRfcnhfY2FwYSgmZGV2LT5tdDc2Lm1taW8ud2Vk
KSkpDQo+IA0KPiB5b3UgZG8gbm90IG5lZWQgYnJhY2tldHMgYXJvdW5kIG10a193ZWRfZ2V0X3J4
X2NhcGEoKS4NCj4gDQoNCmFjaywgd2lsbCBmaXggaXQgaW4gdjMNCg0KUmVnYXJkcywNClN1anVh
bg0KDQo+IFJlZ2FyZHMsDQo+IExvcmVuem8NCj4gDQo+ID4gIAkJbXQ3OTE1X21jdV93YV9jbWQo
ZGV2LCBNQ1VfV0FfUEFSQU1fQ01EKENBUEFCSUxJVFkpLCAwLA0KPiA+IDAsIDApOw0KPiA+ICAN
Cj4gPiAgCXJldCA9IG10NzkxNV9tY3Vfc2V0X213ZHMoZGV2LCAxKTsNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbW1pby5jDQo+ID4g
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMNCj4gPiBp
bmRleCAyMjVhMTk2MDRkM2UuLjZmMGMwZTJhZTA0NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMNCj4gPiArKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMNCj4gPiBAQCAtOTg5
LDEzICs5ODksMTMgQEAgaXJxcmV0dXJuX3QgbXQ3OTE1X2lycV9oYW5kbGVyKGludCBpcnEsIHZv
aWQNCj4gPiAqZGV2X2luc3RhbmNlKQ0KPiA+ICAJc3RydWN0IG10NzkxNV9kZXYgKmRldiA9IGRl
dl9pbnN0YW5jZTsNCj4gPiAgCXN0cnVjdCBtdGtfd2VkX2RldmljZSAqd2VkID0gJmRldi0+bXQ3
Ni5tbWlvLndlZDsNCj4gPiAgDQo+ID4gLQlpZiAobXRrX3dlZF9kZXZpY2VfYWN0aXZlKHdlZCkp
IHsNCj4gPiArCWlmIChtdGtfd2VkX2RldmljZV9hY3RpdmUod2VkKSkNCj4gPiAgCQltdGtfd2Vk
X2RldmljZV9pcnFfc2V0X21hc2sod2VkLCAwKTsNCj4gPiAtCX0gZWxzZSB7DQo+ID4gKwllbHNl
DQo+ID4gIAkJbXQ3Nl93cihkZXYsIE1UX0lOVF9NQVNLX0NTUiwgMCk7DQo+ID4gLQkJaWYgKGRl
di0+aGlmMikNCj4gPiAtCQkJbXQ3Nl93cihkZXYsIE1UX0lOVDFfTUFTS19DU1IsIDApOw0KPiA+
IC0JfQ0KPiA+ICsNCj4gPiArCWlmIChkZXYtPmhpZjIpDQo+ID4gKwkJbXQ3Nl93cihkZXYsIE1U
X0lOVDFfTUFTS19DU1IsIDApOw0KPiA+ICANCj4gPiAgCWlmICghdGVzdF9iaXQoTVQ3Nl9TVEFU
RV9JTklUSUFMSVpFRCwgJmRldi0+bXBoeS5zdGF0ZSkpDQo+ID4gIAkJcmV0dXJuIElSUV9OT05F
Ow0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0K
