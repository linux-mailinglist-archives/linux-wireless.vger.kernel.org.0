Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED7C722254
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 11:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjFEJgf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjFEJgc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 05:36:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62422F3
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 02:36:27 -0700 (PDT)
X-UUID: 6f430fd0038411ee9cb5633481061a41-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ehmhUy2TbvxkI55NJkomy+Cbs+ta5szZEbT4hU4An6w=;
        b=RZHkyb9i9T73ddUV7o76iASgCi178MgY4moldVxHUhFXFRNWBWEQDxKkUfYKZLhnkXg3sN4+E2G0VU3LpJymNfKWGn4uhpW5P8R1Gu+nPxRXPB/CkAOgO3vRrOF5CNhQcIi9D515MCJCzocJa3FuZMdECsoFYBBRVkFtl4VrDeM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:037bde72-2ad1-4fdb-b724-6c82e8b0d4dc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.25,REQID:037bde72-2ad1-4fdb-b724-6c82e8b0d4dc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:d5b0ae3,CLOUDID:be159b3d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230605163833Y0UMRTGU,BulkQuantity:14,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 6f430fd0038411ee9cb5633481061a41-20230605
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 404920243; Mon, 05 Jun 2023 17:36:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 17:36:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 17:36:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6GZErzrInb/58S1QRjfuN4OqXZNsw2VEK3LipIL2L//6JWB5w4ItABWj14ORHCHPoW3hstxKNoJNTsB53AbQecUjmVC5zBaYHjA4Tvv+Ksxhdgkf8yQp59W6lg950T2zErPaLi7z7HRCI68lNatE/X2rxeU58fbNRCIHjOxYpWKdoAtv4SiyN9hFVc45lqMbvoVt833qHS3GmZFbtj0S1V59H4+ZlcU404xCEasThpGHgbOalc1hw0F3qagieoytbNgS9O6pv5S2i89tJyGgImmGcMO14nLLFteRpBHSA8aOEyp0+uisTEN5BTmdf8Zgi7Ft5fKMTx6NQmUvSQ2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehmhUy2TbvxkI55NJkomy+Cbs+ta5szZEbT4hU4An6w=;
 b=Hs+WjdW9Cw9JILx64cWZVbf/JuQRAASYsz+d484SvCIkXufTo0f9X3+s9UXXpaj5zHzshcHWTwp5lErlIBhv5yPYDKCqj6DrL5Vbtu/PKzCm0zLdtCfz9/uPvx2ybMsrH/x3cX/tQrspzpreIZ+vA1EfTxzhbToGyvrAJ4uyGLeYkDqMDuAtX99sAovDC6ygqU4hVLqtuaGlfGmknyG0TKgKpBtr3SqdCVcUSu4CzZAH48wMATXgc9pn5Pck25VF4CRHpYHR2tT8zzf324UgdANPUNT2BL2acq2BzOkwOSJ9SrIqAnQxRRUD01Dahfh+xep4msezA3GJPYHRZ70Gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehmhUy2TbvxkI55NJkomy+Cbs+ta5szZEbT4hU4An6w=;
 b=AQtvKCLP6K+9oVe2OhvqqSWcDdYg9yiwUWxigAklNwLnoks1T+7KhCjRJMSSw0Z68sNGlCg4MruHK5HZ6zGIuZOs6Mv6JK6t/UgoUqSwVnTCTLmiGPacrI7WYCaLTIWix6BhMYZvV97+2kT1oJpCz10CmMT63bUB5joKly6F1yU=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by TYZPR03MB7227.apcprd03.prod.outlook.com (2603:1096:400:33e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 09:36:15 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::662b:189f:a0dd:6734]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::662b:189f:a0dd:6734%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:36:15 +0000
From:   shayne.chen@mediatek.com
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
Subject: Re: [PATCH v2 02/10] wifi: mt76: connac: add support for dsp firmware
 download
Thread-Topic: [PATCH v2 02/10] wifi: mt76: connac: add support for dsp
 firmware download
Thread-Index: AQHZl4ahLyQodEW8EUuxBFeOh5ILZq974yKAgAAPRQCAAADiAA==
Date:   Mon, 5 Jun 2023 09:36:15 +0000
Message-ID: <c38130b9051a6b39cac6c844f62821b7e681f689.camel@mediatek.com>
References: <20230605081947.12804-1-shayne.chen@mediatek.com>
         <20230605081947.12804-2-shayne.chen@mediatek.com>
         <ZH2fAWYfp2rdurwT@lore-desk>
         <8bf15819e81358e4dbc747206e3048c96ef73cbc.camel@mediatek.com>
In-Reply-To: <8bf15819e81358e4dbc747206e3048c96ef73cbc.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|TYZPR03MB7227:EE_
x-ms-office365-filtering-correlation-id: 4f069e0b-a538-4140-ed85-08db65a84ef8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8NC83HT+297H5om4NSVmxi07qrLKAdybnlZ/bwfZ25k8i1/iwuD3AeF6S6ZNszJ4EB7JHgE9HenKYtjwV2AsC7Duv86pD73bCV3fTmkuiVN4+HGtuRQ3Hmx8QU9G1Uk4aq9+MjKwAzv7qtiIDoaF3I1ehsjzfuwmxLqCBH5wFVcG/bXhFtITIFk6Hjg9ysqzsYWrCIMgTV1b9VvbpW09G3h4r25crR2rfATxjcS5TRKuukt0PEJiVphbkChabr4FK+9ycLhKz+/gEYhTqLS3gOdHFg82E5vgr9CLeiiP+WJ9toG1gnaxs8QK1uTj2j0siNAN4LDaV5chfo+By2e4VOE8eTHxSvtlu7kfAH5/y8UNQKZIdHuUoyahD0KJ//mImQLcOCX2/WOxeM+bCFGDx6EBKxjLvmADBWWNmeYjYj8rp4CFyFH056mauxQPMOxSkGvl+i2Tc+OjCN2Nw6fuRWX2I0ogxZJjDpAIINz+LzIDReZKu2ceXnTE09FB17MHS0uL1FU0LM6Flg/RGO6xvLJdiWUwZwD7uqkZ89+SUwahjMm/6ufSY4tQ2SDySLzDTRA9VvKvKw4djtBkFZVQX1guGojwIR52H8KJ8IbsFgI0MAi5cCzPsqKDqb0uL2NbH8aS2Ywohgts7Vw7mBF0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(107886003)(6512007)(6506007)(26005)(85182001)(36756003)(83380400001)(86362001)(38070700005)(122000001)(38100700002)(186003)(2616005)(41300700001)(54906003)(2906002)(478600001)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(6916009)(4326008)(8936002)(8676002)(316002)(66556008)(5660300002)(6486002)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk1QR3IwaE1rRkVTSFV3ZmgybnRwS0dVR3dET0hvaFdvT21oc2Npb25xMTRJ?=
 =?utf-8?B?cHN3S0I4TmJKZHpNWmtNS2wrWXFKcVRSNWRROEFrUExvQXVYNTVOd2NHWmVM?=
 =?utf-8?B?SWljU0lkaHA3RCs0eGRCc0ExV3lrMkd4RWR1UVdkbkhVWmZmdzBNU0U5UDZX?=
 =?utf-8?B?Rnhna3NUK3daME5SVEhlQWkwQUEvdXkzcjE0N0IrNTZTTk5Hc2RHZ1FCaXFn?=
 =?utf-8?B?a0lqUWMwTWt0ZDZnb0huOXFEMUVWUFRZWVdNRmRGZFp5OFZsM2xkazVSZGNh?=
 =?utf-8?B?MHRMVkRXWTloaDJzd2NKL25LdTFQaDEzMXVPSHNsUm5CVkN0c0hOUVAxVjlw?=
 =?utf-8?B?UmIxUzkxaTZRMlp3MFg0dklRKys2bzdvNUltZDkyalhreVZucFd2eTh5QnVJ?=
 =?utf-8?B?eU9ndUVqSWVvU05CTW94dlpPRFVvSVVBMi9WSnZicWMzRit5ZVJjN2preEdp?=
 =?utf-8?B?YnY0RW8xS3lMcEFneE01MXlFdmhRZEpkK1hzMU1IWVMyanZ3RFZ1QVc2VUJn?=
 =?utf-8?B?WEp6VDduQkE1blI2MWtzSkx1QWVEdWZtQTI2WUtacUlCandYRk9LcjYyOWwy?=
 =?utf-8?B?T0s4S1JsOHAzK3JoOUdEUllBaWwraTMwMFdBN1R1M21iUnFiOEtqeFZTeDFV?=
 =?utf-8?B?VDBnenlrTWp0cVhIbEVUZkd0NG00d2lpL2tuMnFVR2V1b2E1MEZRNFRPZldB?=
 =?utf-8?B?ZkptRjg2a1c2eW84TmZibmdmK1NwR3RXb0JIOHlmUkN2QTBQeVdwSVRCMEJS?=
 =?utf-8?B?dHdlYmJyWlZlL00zWTdKNmZ0SXVSQnROZW8zSGhqbGVTd2JvU08rbUlVZzVw?=
 =?utf-8?B?UHNDTkQ0YzEybFBLa3BjTVJHUGZZbXZpSytYUnEvdnVPNE5kb2N0OE1OSFh1?=
 =?utf-8?B?MThDWUFsbzR1NUN2dGFyZWVra3ZidkhWenp0aWhYV0pmVWpWQ1dBNStlczBQ?=
 =?utf-8?B?NkJrY1YrODdkL3NpbzJYNFptTFN5TllqUkNEajRST2c2bXpZV1BkWS91ZzRX?=
 =?utf-8?B?aSszSnhyT3Jtenp1eUxNT1RZOUVqUTZQQVBiK2pZd0JIRzhUalRud3NUWTR1?=
 =?utf-8?B?Zi9lOEJiUVFvMDdmeEF4akptOXR1TStuZ2pRdUZlMkhlQnlkajQxNnhSZDVY?=
 =?utf-8?B?ZTNxK3JKcWo5ZHhTVzF2dVoyelpsQVA1Wi9hdFV4aWZza1l5MjdVd0ltZEFX?=
 =?utf-8?B?NFBJSlJRZjBPOEYxRi9TdjAxMEVHc3pYcWJENUM1bHoraXFLUVdPczJvOFd5?=
 =?utf-8?B?T25SaFloM3NGd0lJUHovMXNnZTBaeCthNk1ZNU41QXF3TzR0TGtwQStHVE5t?=
 =?utf-8?B?Tlk1UTJsOFJIdjdFMzJ5OENWV2pGZ0ZSMkdJeEJBUEFkTUNra2VyZTdlcy9H?=
 =?utf-8?B?TG4wWmk1ZExvMjV0OC9ZNis2NUhtZG8vTEhmU0tMbm02aWVKUnFqQjF3cVNJ?=
 =?utf-8?B?K3JOVzFpbjJOVmp2SitqY0ZWRTFMbGpQZUVrRXU0NENYY3ljQW9YN3NUZEp2?=
 =?utf-8?B?U2J6VTVINmhhNnV5WmdYQUQvZWM2UExCTVgweUxPSWk1ZWJTZ1FCVm9CN0k0?=
 =?utf-8?B?K2FGRnF4YXo2Q2FHSEtKYlJHQ3pxZDlUbTlOTm9Wa1cxb1pueFVUcXZGRmhC?=
 =?utf-8?B?UlZuYm5YYllXeU5zNzJOMjlmaEJjN2JubTlENWdQVWhrbTRWajZMUW1uSU5x?=
 =?utf-8?B?YWxVSmRtK3JSekFadlQ3NGJGYk1HWUlDdDlzdXVLNzdIZzJCbVkvSDVZNGNj?=
 =?utf-8?B?SmhwMWFURklFVysrNTh3WGcyUWlBMlVuYzFUdUxNdTBPRFRuMmdoWHQ2dDEr?=
 =?utf-8?B?ZlE1S1F6RUozQ1dPdG9pSC85cEZsVzQwbFZqazZSWkpYSmoyRnZiOVBNZ0No?=
 =?utf-8?B?Qk5pRUYwZjdXRmIxYk9WNmdGZ29aRGNlSURTNkc0a1J5THlqbkxxTDg0ejlX?=
 =?utf-8?B?ODNOSDB1Ym4vbWZYL3NXb29nK2hKdFV3TzNiTXFCWCtkNzYrdDA4TGh3V0NP?=
 =?utf-8?B?L1psZU5rK3JNYTR2ZE0rbXJQV1lIS1Z4dVEyYlZDU1BSem1kbTBSc1Q4MnBC?=
 =?utf-8?B?U3RvZitDOVRkd2tPcjhBMFNSZVM3Wm5HdDZYTktBRW9TUnVZd3laL1lvNEt6?=
 =?utf-8?B?Yk1QYnYva29HMHdrcS8vUkJaMVB2UTd1OTVlR3pCWjFmOXUzam5HaGJPT1Bq?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <334E81EAF0ACA443849B7B0259AF6268@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f069e0b-a538-4140-ed85-08db65a84ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:36:15.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4B1f++KRIlm4veREN6n0NzPKNEiSU4dwrlkBC8XVgFdaBzY8Hj2uKtg+icn7AlBkCl5kK71bM5MaMTOHFMSlP87ijL3FKhGJgFJ0t64Ttb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7227
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDE3OjMzICswODAwLCBTaGF5bmUgQ2hlbiB3cm90ZToNCj4g
T24gTW9uLCAyMDIzLTA2LTA1IGF0IDEwOjM4ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+ID4gRnJvbTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRlay5jb20+DQo+
ID4gPiANCj4gPiA+IEFkZCBGV19TVEFSVF9XT1JLSU5HX1BEQV9EU1AgZm9yIHRoZSBpbmRpY2F0
aW9uIG9mIHN0YXJ0aW5nIERTUA0KPiA+ID4gZmlybXdhcmUgZG93bmxvYWQsIHdoaWNoIGlzIGZv
ciBwaHktcmVsYXRlZCBjb250cm9sLg0KPiA+ID4gVGhlIGZpcm13YXJlIGlzIHRyYW5zcGFyZW50
IHRvIHRoZSBkcml2ZXIsIGJ1dCBpdCdzIG5lY2Vzc2FyeSBmb3INCj4gPiA+IHRoZQ0KPiA+ID4g
ZmlybXdhcmUgZG93bmxvYWQgcHJvY2Vzcy4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IFNo
YXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBQZXRlciBDaGl1IDxjaHVpLWhhby5jaGl1QG1lZGlhdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+IHYyOg0KPiA+ID4gICAtIG1lcmdlIHR3byBjb21taXRzOg0KPiA+ID4gICAgIC0gd2lm
aTogbXQ3NjogY29ubmFjOiBhZGQgYSBzZXR0aW5nIGJpdCBmb3IgZHNwIGZpcm13YXJlDQo+ID4g
PiAgICAgLSB3aWZpOiBtdDc2OiBtdDc5OTY6IGFkZCBkc3AgZmlybXdhcmUgZG93bmxvYWQNCj4g
PiA+ICAgLSBtb3ZlIG1haW4gY29kZSBmb3IgbG9hZGluZyByYW0gdG8gYSByZWd1bGFyIGZ1bmN0
aW9uDQo+ID4gPiAtLS0NCj4gPiA+ICAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nv
bm5hY19tY3UuaCAgfCAgMSArDQo+ID4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210Nzk5Ni9tY3UuYyAgIHwgNzAgKysrKysrKysrLS0tLQ0KPiA+ID4gLS0tLS0tDQo+ID4gPiAg
Li4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L210Nzk5Ni5oICAgIHwgIDcgKysNCj4g
PiA+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L3BjaS5jICAgfCAgMSAr
DQo+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMo
LSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmgNCj4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuaA0KPiA+ID4gaW5kZXggY2ExY2U5N2E2ZDJm
Li40YTIxYzIzN2VhNmUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5oDQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5oDQo+ID4gPiBAQCAtMjIsNiAr
MjIsNyBAQA0KPiA+ID4gIA0KPiA+ID4gICNkZWZpbmUgRldfU1RBUlRfT1ZFUlJJREUJCUJJVCgw
KQ0KPiA+ID4gICNkZWZpbmUgRldfU1RBUlRfV09SS0lOR19QREFfQ1I0CUJJVCgyKQ0KPiA+ID4g
KyNkZWZpbmUgRldfU1RBUlRfV09SS0lOR19QREFfRFNQCUJJVCgzKQ0KPiA+ID4gIA0KPiA+ID4g
ICNkZWZpbmUgUEFUQ0hfU0VDX05PVF9TVVBQT1JUCQlHRU5NQVNLKDMxLCAwKQ0KPiA+ID4gICNk
ZWZpbmUgUEFUQ0hfU0VDX1RZUEVfTUFTSwkJR0VOTUFTSygxNSwgMCkNCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+
ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+
ID4gaW5kZXggODhlMmY5ZDBlNTEzLi4yODkzMDY5M2E3NWEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gPiA+
IEBAIC0yMTU1LDcgKzIxNTUsNyBAQCBzdGF0aWMgaW50IG10Nzk5Nl9sb2FkX3BhdGNoKHN0cnVj
dA0KPiA+ID4gbXQ3OTk2X2RldiAqZGV2KQ0KPiA+ID4gIHN0YXRpYyBpbnQNCj4gPiA+ICBtdDc5
OTZfbWN1X3NlbmRfcmFtX2Zpcm13YXJlKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsDQo+ID4gPiAg
CQkJICAgICBjb25zdCBzdHJ1Y3QgbXQ3OTk2X2Z3X3RyYWlsZXIgKmhkciwNCj4gPiA+IC0JCQkg
ICAgIGNvbnN0IHU4ICpkYXRhLCBib29sIGlzX3dhKQ0KPiA+ID4gKwkJCSAgICAgY29uc3QgdTgg
KmRhdGEsIGVudW0gbXQ3OTk2X3JhbV90eXBlIHR5cGUpDQo+ID4gPiAgew0KPiA+ID4gIAlpbnQg
aSwgb2Zmc2V0ID0gMDsNCj4gPiA+ICAJdTMyIG92ZXJyaWRlID0gMCwgb3B0aW9uID0gMDsNCj4g
PiA+IEBAIC0yMTY3LDggKzIxNjcsMTAgQEAgbXQ3OTk2X21jdV9zZW5kX3JhbV9maXJtd2FyZShz
dHJ1Y3QNCj4gPiA+IG10Nzk5Nl9kZXYgKmRldiwNCj4gPiA+ICANCj4gPiA+ICAJCXJlZ2lvbiA9
IChjb25zdCBzdHJ1Y3QgbXQ3OTk2X2Z3X3JlZ2lvbiAqKSgoY29uc3QgdTgNCj4gPiA+ICopaGRy
IC0NCj4gPiA+ICAJCQkgKGhkci0+bl9yZWdpb24gLSBpKSAqIHNpemVvZigqcmVnaW9uKSk7DQo+
ID4gPiArCQkvKiBEU1AgYW5kIFdBIHVzZSBzYW1lIG1vZGUgKi8NCj4gPiA+ICAJCW1vZGUgPSBt
dDc2X2Nvbm5hY19tY3VfZ2VuX2RsX21vZGUoJmRldi0+bXQ3NiwNCj4gPiA+IC0JCQkJCQkgICBy
ZWdpb24tDQo+ID4gPiA+ZmVhdHVyZV9zZXQsIA0KPiA+ID4gaXNfd2EpOw0KPiA+ID4gKwkJCQkJ
CSAgIHJlZ2lvbi0+ZmVhdHVyZV9zZXQsDQo+ID4gPiArCQkJCQkJICAgdHlwZSAhPQ0KPiA+ID4g
TVQ3OTk2X1JBTV9UWVBFX1dNKTsNCj4gPiA+ICAJCWxlbiA9IGxlMzJfdG9fY3B1KHJlZ2lvbi0+
bGVuKTsNCj4gPiA+ICAJCWFkZHIgPSBsZTMyX3RvX2NwdShyZWdpb24tPmFkZHIpOw0KPiA+ID4g
IA0KPiA+ID4gQEAgLTIxOTUsMTkgKzIxOTcsMjIgQEAgbXQ3OTk2X21jdV9zZW5kX3JhbV9maXJt
d2FyZShzdHJ1Y3QNCj4gPiA+IG10Nzk5Nl9kZXYgKmRldiwNCj4gPiA+ICAJaWYgKG92ZXJyaWRl
KQ0KPiA+ID4gIAkJb3B0aW9uIHw9IEZXX1NUQVJUX09WRVJSSURFOw0KPiA+ID4gIA0KPiA+ID4g
LQlpZiAoaXNfd2EpDQo+ID4gPiArCWlmICh0eXBlID09IE1UNzk5Nl9SQU1fVFlQRV9XQSkNCj4g
PiA+ICAJCW9wdGlvbiB8PSBGV19TVEFSVF9XT1JLSU5HX1BEQV9DUjQ7DQo+ID4gPiArCWVsc2Ug
aWYgKHR5cGUgPT0gTVQ3OTk2X1JBTV9UWVBFX0RTUCkNCj4gPiA+ICsJCW9wdGlvbiB8PSBGV19T
VEFSVF9XT1JLSU5HX1BEQV9EU1A7DQo+ID4gPiAgDQo+ID4gPiAgCXJldHVybiBtdDc2X2Nvbm5h
Y19tY3Vfc3RhcnRfZmlybXdhcmUoJmRldi0+bXQ3Niwgb3ZlcnJpZGUsDQo+ID4gPiBvcHRpb24p
Ow0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+IC1zdGF0aWMgaW50IG10Nzk5Nl9sb2FkX3JhbShz
dHJ1Y3QgbXQ3OTk2X2RldiAqZGV2KQ0KPiA+ID4gK3N0YXRpYyBpbnQgX19tdDc5OTZfbG9hZF9y
YW0oc3RydWN0IG10Nzk5Nl9kZXYgKmRldiwgY29uc3QgY2hhcg0KPiA+ID4gKmZ3X3R5cGUsDQo+
ID4gPiArCQkJICAgICBjb25zdCBjaGFyICpmd19maWxlLCBlbnVtIG10Nzk5Nl9yYW1fdHlwZQ0K
PiA+ID4gcmFtX3R5cGUpDQo+ID4gPiAgew0KPiA+ID4gIAljb25zdCBzdHJ1Y3QgbXQ3OTk2X2Z3
X3RyYWlsZXIgKmhkcjsNCj4gPiA+ICAJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdzsNCj4gPiA+
ICAJaW50IHJldDsNCj4gPiA+ICANCj4gPiA+IC0JcmV0ID0gcmVxdWVzdF9maXJtd2FyZSgmZncs
IE1UNzk5Nl9GSVJNV0FSRV9XTSwgZGV2LT5tdDc2LmRldik7DQo+ID4gPiArCXJldCA9IHJlcXVl
c3RfZmlybXdhcmUoJmZ3LCBmd19maWxlLCBkZXYtPm10NzYuZGV2KTsNCj4gPiA+ICAJaWYgKHJl
dCkNCj4gPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gPiAgDQo+ID4gPiBAQCAtMjIxNyw0OCArMjIy
Miw0MSBAQCBzdGF0aWMgaW50IG10Nzk5Nl9sb2FkX3JhbShzdHJ1Y3QNCj4gPiA+IG10Nzk5Nl9k
ZXYgKmRldikNCj4gPiA+ICAJCWdvdG8gb3V0Ow0KPiA+ID4gIAl9DQo+ID4gPiAgDQo+ID4gPiAt
CWhkciA9IChjb25zdCBzdHJ1Y3QgbXQ3OTk2X2Z3X3RyYWlsZXIgKikoZnctPmRhdGEgKyBmdy0+
c2l6ZSAtDQo+ID4gPiBzaXplb2YoKmhkcikpOw0KPiA+ID4gLQ0KPiA+ID4gLQlkZXZfaW5mbyhk
ZXYtPm10NzYuZGV2LCAiV00gRmlybXdhcmUgVmVyc2lvbjogJS4xMHMsIEJ1aWxkDQo+ID4gPiBU
aW1lOiAlLjE1c1xuIiwNCj4gPiA+IC0JCSBoZHItPmZ3X3ZlciwgaGRyLT5idWlsZF9kYXRlKTsN
Cj4gPiA+ICsJaGRyID0gKGNvbnN0IHZvaWQgKikoZnctPmRhdGEgKyBmdy0+c2l6ZSAtIHNpemVv
ZigqaGRyKSk7DQo+ID4gPiArCWRldl9pbmZvKGRldi0+bXQ3Ni5kZXYsICIlcyBGaXJtd2FyZSBW
ZXJzaW9uOiAlLjEwcywgQnVpbGQNCj4gPiA+IFRpbWU6ICUuMTVzXG4iLA0KPiA+ID4gKwkJIGZ3
X3R5cGUsIGhkci0+ZndfdmVyLCBoZHItPmJ1aWxkX2RhdGUpOw0KPiA+ID4gIA0KPiA+ID4gLQly
ZXQgPSBtdDc5OTZfbWN1X3NlbmRfcmFtX2Zpcm13YXJlKGRldiwgaGRyLCBmdy0+ZGF0YSwgZmFs
c2UpOw0KPiA+ID4gKwlyZXQgPSBtdDc5OTZfbWN1X3NlbmRfcmFtX2Zpcm13YXJlKGRldiwgaGRy
LCBmdy0+ZGF0YSwNCj4gPiA+IHJhbV90eXBlKTsNCj4gPiA+ICAJaWYgKHJldCkgew0KPiA+ID4g
LQkJZGV2X2VycihkZXYtPm10NzYuZGV2LCAiRmFpbGVkIHRvIHN0YXJ0IFdNDQo+ID4gPiBmaXJt
d2FyZVxuIik7DQo+ID4gPiArCQlkZXZfZXJyKGRldi0+bXQ3Ni5kZXYsICJGYWlsZWQgdG8gc3Rh
cnQgJXMgZmlybXdhcmVcbiIsDQo+ID4gPiBmd190eXBlKTsNCj4gPiA+ICAJCWdvdG8gb3V0Ow0K
PiA+ID4gIAl9DQo+ID4gPiAgDQo+ID4gPiArb3V0Og0KPiA+ID4gIAlyZWxlYXNlX2Zpcm13YXJl
KGZ3KTsNCj4gPiA+ICANCj4gPiA+IC0JcmV0ID0gcmVxdWVzdF9maXJtd2FyZSgmZncsIE1UNzk5
Nl9GSVJNV0FSRV9XQSwgZGV2LT5tdDc2LmRldik7DQo+ID4gPiAtCWlmIChyZXQpDQo+ID4gPiAt
CQlyZXR1cm4gcmV0Ow0KPiA+ID4gLQ0KPiA+ID4gLQlpZiAoIWZ3IHx8ICFmdy0+ZGF0YSB8fCBm
dy0+c2l6ZSA8IHNpemVvZigqaGRyKSkgew0KPiA+ID4gLQkJZGV2X2VycihkZXYtPm10NzYuZGV2
LCAiSW52YWxpZCBmaXJtd2FyZVxuIik7DQo+ID4gPiAtCQlyZXQgPSAtRUlOVkFMOw0KPiA+ID4g
LQkJZ290byBvdXQ7DQo+ID4gPiAtCX0NCj4gPiA+IC0NCj4gPiA+IC0JaGRyID0gKGNvbnN0IHN0
cnVjdCBtdDc5OTZfZndfdHJhaWxlciAqKShmdy0+ZGF0YSArIGZ3LT5zaXplIC0NCj4gPiA+IHNp
emVvZigqaGRyKSk7DQo+ID4gPiAtDQo+ID4gPiAtCWRldl9pbmZvKGRldi0+bXQ3Ni5kZXYsICJX
QSBGaXJtd2FyZSBWZXJzaW9uOiAlLjEwcywgQnVpbGQNCj4gPiA+IFRpbWU6ICUuMTVzXG4iLA0K
PiA+ID4gLQkJIGhkci0+ZndfdmVyLCBoZHItPmJ1aWxkX2RhdGUpOw0KPiA+ID4gKwlyZXR1cm4g
cmV0Ow0KPiA+ID4gK30NCj4gPiA+ICANCj4gPiA+IC0JcmV0ID0gbXQ3OTk2X21jdV9zZW5kX3Jh
bV9maXJtd2FyZShkZXYsIGhkciwgZnctPmRhdGEsIHRydWUpOw0KPiA+ID4gLQlpZiAocmV0KSB7
DQo+ID4gPiAtCQlkZXZfZXJyKGRldi0+bXQ3Ni5kZXYsICJGYWlsZWQgdG8gc3RhcnQgV0ENCj4g
PiA+IGZpcm13YXJlXG4iKTsNCj4gPiA+IC0JCWdvdG8gb3V0Ow0KPiA+ID4gLQl9DQo+ID4gPiAr
c3RhdGljIGludCBtdDc5OTZfbG9hZF9yYW0oc3RydWN0IG10Nzk5Nl9kZXYgKmRldikNCj4gPiA+
ICt7DQo+ID4gPiArCWludCByZXQ7DQo+ID4gPiAgDQo+ID4gPiAtCXNucHJpbnRmKGRldi0+bXQ3
Ni5ody0+d2lwaHktPmZ3X3ZlcnNpb24sDQo+ID4gPiAtCQkgc2l6ZW9mKGRldi0+bXQ3Ni5ody0+
d2lwaHktPmZ3X3ZlcnNpb24pLA0KPiA+ID4gLQkJICIlLjEwcy0lLjE1cyIsIGhkci0+ZndfdmVy
LCBoZHItPmJ1aWxkX2RhdGUpOw0KPiA+IA0KPiA+IGRvaW5nIHNvIHdlIGRvIG5vdCBhZHZlcnRp
c2UgZncgdmVyc2lvbiB0aHJvdWdoIGV0aHRvb2wgYXMgYmVmb3JlLg0KPiA+IA0KPiA+ID4gKyNk
ZWZpbmUgTE9BRF9SQU0oX3R5cGUpIFwNCj4gPiA+ICsJZG8gewkJCQkJCQkJDQo+ID4gPiBcDQo+
ID4gPiArCQlyZXQgPSBfX210Nzk5Nl9sb2FkX3JhbShkZXYsICNfdHlwZSwJCQkNCj4gPiA+IFwN
Cj4gPiA+ICsJCQkJCU1UNzk5Nl9GSVJNV0FSRV8jI190eXBlLAlcDQo+ID4gPiArCQkJCQlNVDc5
OTZfUkFNX1RZUEVfIyNfdHlwZSk7CVwNCj4gPiA+ICsJCWlmIChyZXQpCQkJCQkJXA0KPiA+ID4g
KwkJCXJldHVybiByZXQ7CQkJCQlcDQo+ID4gPiArCX0gd2hpbGUgKDApDQo+ID4gPiAgDQo+ID4g
PiAtb3V0Og0KPiA+ID4gLQlyZWxlYXNlX2Zpcm13YXJlKGZ3KTsNCj4gPiA+ICsJTE9BRF9SQU0o
V00pOw0KPiA+ID4gKwlMT0FEX1JBTShEU1ApOw0KPiA+ID4gKwlMT0FEX1JBTShXQSk7DQo+ID4g
DQo+ID4gY2FuIHlvdSBwbGVhc2UgcnVuIHRoZSBmdW5jdGlvbiBkaXJlY3RseSBpbnN0ZWFkIG9m
IHVzaW5nIG1hY3Jvcz8NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IExvcmVuem8NCj4gDQo+IEhp
IExvcmVuem8sDQo+IA0KPiBXaWxsIGFkZA0KDQooU29ycnkgZm9yIGFjY2lkZW50YWxseSBwcmVz
c2luZyBzZW5kKQ0KDQpIaSBMb3JlbnpvLA0KDQpXaWxsIGFkZCBiYWNrIG1pc3NpbmcgY29kZSBm
b3IgcmVjb3JkaW5nIGZ3X3ZlcnNpb24sIGFuZCBleHBhbmQgbWFjcm9zDQp0byBkaXJlY3RseSBj
YWxsIGxvYWQgcmFtIGZ1bmN0aW9uLg0KDQpUaGFua3MsDQpTaGF5bmUNCj4gPiANCj4gPiA+ICsj
dW5kZWYgTE9BRF9SQU0NCj4gPiA+ICANCj4gPiA+IC0JcmV0dXJuIHJldDsNCj4gPiA+ICsJcmV0
dXJuIDA7DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+ID4gIHN0YXRpYyBpbnQNCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYu
aA0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5
OTYuaA0KPiA+ID4gaW5kZXggNGQ3ZGNiOTVhNjIwLi43ZGZkYzczODQwNTYgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYu
aA0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bXQ3OTk2LmgNCj4gPiA+IEBAIC0yOSw2ICsyOSw3IEBADQo+ID4gPiAgDQo+ID4gPiAgI2RlZmlu
ZSBNVDc5OTZfRklSTVdBUkVfV0EJCSJtZWRpYXRlay9tdDc5OTYvbXQ3OTk2DQo+ID4gPiBfd2Eu
YmluIg0KPiA+ID4gICNkZWZpbmUgTVQ3OTk2X0ZJUk1XQVJFX1dNCQkibWVkaWF0ZWsvbXQ3OTk2
L210Nzk5Ng0KPiA+ID4gX3dtLmJpbiINCj4gPiA+ICsjZGVmaW5lIE1UNzk5Nl9GSVJNV0FSRV9E
U1AJCSJtZWRpYXRlay9tdDc5OTYvbXQ3OTk2DQo+ID4gPiBfZHNwLmJpbiINCj4gPiA+ICAjZGVm
aW5lIE1UNzk5Nl9ST01fUEFUQ0gJCSJtZWRpYXRlay9tdDc5OTYvbXQ3OTk2X3JvbV9wYXQNCj4g
PiA+IGNoLmJpbiINCj4gPiA+ICANCj4gPiA+ICAjZGVmaW5lIE1UNzk5Nl9FRVBST01fREVGQVVM
VAkJIm1lZGlhdGVrL210Nzk5Ni9tdDc5OTYNCj4gPiA+IF9lZXByb20uYmluIg0KPiA+ID4gQEAg
LTUyLDYgKzUzLDEyIEBAIHN0cnVjdCBtdDc5OTZfc3RhOw0KPiA+ID4gIHN0cnVjdCBtdDc5OTZf
ZGZzX3B1bHNlOw0KPiA+ID4gIHN0cnVjdCBtdDc5OTZfZGZzX3BhdHRlcm47DQo+ID4gPiAgDQo+
ID4gPiArZW51bSBtdDc5OTZfcmFtX3R5cGUgew0KPiA+ID4gKwlNVDc5OTZfUkFNX1RZUEVfV00s
DQo+ID4gPiArCU1UNzk5Nl9SQU1fVFlQRV9XQSwNCj4gPiA+ICsJTVQ3OTk2X1JBTV9UWVBFX0RT
UCwNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gIGVudW0gbXQ3OTk2X3R4cV9pZCB7DQo+ID4g
PiAgCU1UNzk5Nl9UWFFfRldETCA9IDE2LA0KPiA+ID4gIAlNVDc5OTZfVFhRX01DVV9XTSwNCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5
Ni9wY2kuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5
Ni9wY2kuYw0KPiA+ID4gaW5kZXggNjRhZWUzZmI1NDQ1Li5jNTMwMTA1MGZmOGIgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9wY2ku
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
cGNpLmMNCj4gPiA+IEBAIC0yMTksNCArMjE5LDUgQEAgTU9EVUxFX0RFVklDRV9UQUJMRShwY2ks
DQo+ID4gPiBtdDc5OTZfcGNpX2RldmljZV90YWJsZSk7DQo+ID4gPiAgTU9EVUxFX0RFVklDRV9U
QUJMRShwY2ksIG10Nzk5Nl9oaWZfZGV2aWNlX3RhYmxlKTsNCj4gPiA+ICBNT0RVTEVfRklSTVdB
UkUoTVQ3OTk2X0ZJUk1XQVJFX1dBKTsNCj4gPiA+ICBNT0RVTEVfRklSTVdBUkUoTVQ3OTk2X0ZJ
Uk1XQVJFX1dNKTsNCj4gPiA+ICtNT0RVTEVfRklSTVdBUkUoTVQ3OTk2X0ZJUk1XQVJFX0RTUCk7
DQo+ID4gPiAgTU9EVUxFX0ZJUk1XQVJFKE1UNzk5Nl9ST01fUEFUQ0gpOw0KPiA+ID4gLS0gDQo+
ID4gPiAyLjM5LjINCj4gPiA+IA0K

