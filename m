Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D28637658
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 11:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiKXK1Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 05:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKXK1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 05:27:24 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472611807
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 02:27:18 -0800 (PST)
X-UUID: 87349828168349ab8fb591dd8a19a0ab-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oaxkeLTpz9ztdbPGJ/UHo9qNV/JQX8kI05gpjOMTK7s=;
        b=LwwshkN4UHQ1IwEfKw+XYrzierEDbW2HNgKdfxRBlpImTa1Vh5Xyx5UlwNnZat/LbOAyt0t/WulMCbDg74fUiDK3396V91itIXo6v7sjGVj34vpoxDrhumUxEtyhi7OxePpZucExkiM6AGQNA00SKen0r8BmKVYrd01DJ6xtXhw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:92139cec-5148-4005-807c-65f393264e66,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:92139cec-5148-4005-807c-65f393264e66,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:0591b82f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221124182714CDYLGQYL,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 87349828168349ab8fb591dd8a19a0ab-20221124
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1636040823; Thu, 24 Nov 2022 18:27:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 24 Nov 2022 18:27:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 24 Nov 2022 18:27:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDTylH1Af6fgQcMyu9j5Yz8Po8Nu4L0Xn9qGdWAtY246IsNd+uGeffJdZ0ZJquvpbGX3CaB61L9hjsLYb/RyPk/DnPhheguG1ybug5PcJOUBfO7/2dHyFdzUaHzexbsB8u+6i4AhDcPfpyKK4C1s3oSj7PVSb2Gvuc9/5ARck45fcbJzG+0G3/BJtpMWT0Kca3x9ju2Zox6fsRS36aoji+iyXXwK8xrA8gtfm3FPS4OumAnwBiqmqXWneaeWfCo0M7zKOvW9o3TiCNMKhzwBiDU5GIE9KBExGnY0y4QsHjQ9DTFJ7WucIdpljjtDsLWPRly4s6wFT/ePj+d330ssCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaxkeLTpz9ztdbPGJ/UHo9qNV/JQX8kI05gpjOMTK7s=;
 b=Vy92mp11MpIHJzZPy5Jx+VCgmC1NKSNfDMt+resZ4ekO+fFsXCsYXayM3LRe8ynOKBgOwrigPkpumc46xd5cQ8LilTpAbHsxT789leKeb3x2G11+bV/AgFaeRbZU64ar56hQY0O3lD33LTNwzD5vRCW/8I+XZseWk4VIF+Eo4B+qthKjnsg2g5DQOdGQz+hrY5NKYTJmRSIIhXX0SO0eJ8rFYeTw0PvBZiv4h86nMh37kN3XDDwF9RmcainkRzjgkmfzFughIXwf/zJQHzb5TX+S8RbPAMgsxrN4zrqx3B7PC81YVRlgZangN4deg9KJexSnPA/dDhSBsQPKrg7TIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaxkeLTpz9ztdbPGJ/UHo9qNV/JQX8kI05gpjOMTK7s=;
 b=SXGkIbX0tN4u+gmMUsBb0CWtBy5cYUjfVR9QQdeTSQBqkZs+a0lIgFXPmQlEFbgnnVCwPs6dzoaRnOOU9M9BGmPQChy0l0ic/F8SZ0LLHzm9GSbtVaZW5jbftDVl4l/lUlAME+cCVFk5zoEWy5Nc7dB9NYn2y8rtQCyX2LDbUJ4=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by PSAPR03MB5669.apcprd03.prod.outlook.com (2603:1096:301:85::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 10:27:09 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::658c:288d:5ce9:29f5]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::658c:288d:5ce9:29f5%7]) with mapi id 15.20.5834.011; Thu, 24 Nov 2022
 10:27:09 +0000
From:   shayne.chen@mediatek.com
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SG93YXJkLVlIIEhzdSAo6Kix6IKy6LGqKQ==?= 
        <Howard-YH.Hsu@mediatek.com>,
        =?utf-8?B?TWVpQ2hpYSBDaGl1ICjpgrHnvo7lmIkp?= 
        <MeiChia.Chiu@mediatek.com>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?U3RhbmxleVlQIFdhbmcgKOeOi+S+kemCpik=?= 
        <StanleyYP.Wang@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH 0/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7
 (802.11be) devices
Thread-Topic: [PATCH 0/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7
 (802.11be) devices
Thread-Index: AQHY/k+upeeMyw0a0kmFsI1M50/Sla5NuynWgAAm0QA=
Date:   Thu, 24 Nov 2022 10:27:09 +0000
Message-ID: <2a1c7fb6d6c64e6f53b275517cabfcd85f96dfee.camel@mediatek.com>
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
         <87k03kojxy.fsf@kernel.org>
In-Reply-To: <87k03kojxy.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|PSAPR03MB5669:EE_
x-ms-office365-filtering-correlation-id: 182ddfd1-b0bc-45dd-26f6-08dace067159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLk2W0uGMS4lxhWTRi8GplftxjvoO/tFiTrYDudHf4WPHlQLkHLUeG5YsjD0chDFZOYAu2WbZRIIkFLIjzalqBpRfi4RD0qfA7c0GeP72vYMz0S2F2FXaEpMEw8iBNmqUrnjio1IswgHkheVd8o8Jgm1xYg/Fa2uUndean74O2tRHhIHn1Vxgq6pSTGmUeIlNc9ZuqIMnr6vj5/nytAf3n9R7JoctqWwxcAUA8FiKSU4oG2g8XkezbOpJwH3MsLzrjUKaMRZMG2RcTOXVffpPUnhqGAs2DE6yJdXZyplWWfzoVyc4UYW6Uzm2CM9+uuEup7DrEHgaM9UuArYYsEC3412382ExBWz6uOM2BhXfwsFeYHpCUrDI4KkJ+tXWU4q9vRlHNR20+C+6SUPBstkNUYAKKzO1K7hCZQmmfJucu7MnXOK3JZpVp1IeIbvo+STjWOnCLgFrOVJVTiXcy42/H1EYjRTR1hyYD0rq4/cOOMe7z7kDbiRK2XorqjAzBPI6g/uqmkQlSMBibF9fQITz6YzWjetskdlIdFwWuOdvawtTNch51OnAeRDVLFNB3mOViymnPb/kvfraK3Im5bo6p24ewaA9Rr5sf/aVA6ZdiWxPZb6nYw9+KgReHNrOSN7whiepk0QAgJZj0JZNo65cs58LQd4uSOkxjF18kx4WN8TXNsDchxYFrmsckkEI1G/IYlNi+Rz3Es3dJHw2jjG7aHHtnvlvXuMgyLW2XzqHYV/yl5tfzXuU1/MWFupmn14
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(966005)(36756003)(6486002)(71200400001)(85182001)(107886003)(41300700001)(186003)(8936002)(2616005)(83380400001)(5660300002)(4001150100001)(2906002)(122000001)(66446008)(38070700005)(316002)(6512007)(26005)(8676002)(86362001)(6506007)(91956017)(66476007)(66946007)(4326008)(66556008)(64756008)(6916009)(54906003)(38100700002)(76116006)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnN1OU5qVVhIclJjUm10UFY3NVJXVk9BejdyOW42VTNjaWoyL1NWTVR0cUVi?=
 =?utf-8?B?YlFGK2h6ZVNhYXlMN0plRnhTWXdabm9CVFVsVm43d0JuaERXd1NtUk4wZzVt?=
 =?utf-8?B?RG90T091aG1KT3BjdkUyTjh4cHJnNkZrb0JsS283SEV1NksxUVlqb1dqeHpx?=
 =?utf-8?B?YllkL3lwNkZ6MG16UHp3QzBXZkVIWGE4c1hTVDBKeCtoRGNHWjhLQ0xXY2Rr?=
 =?utf-8?B?R2RVQUpzTDhJQUE0QTFIZ1I2eU54M2lQWXh5Y3QwU0ZTSVUzMmtiSFNKOUxJ?=
 =?utf-8?B?S3RhbVFFSlRZMUJYVWV5ZmtmSHRiUmdyWm9tcmRQbEpXanJFZ2pHVXZ6RVRr?=
 =?utf-8?B?YlNCZmJIK2JiZjFRaVFOZ0tzY3BDOEZNbDY5a1pnRjNPR3JPRVBtTW90Uzd2?=
 =?utf-8?B?dnhTR1hOY0JGaVdWWEhIY0hpdmEyQUZUb0lTWmVOb2ZvZWY0UzNNZEM4cE5l?=
 =?utf-8?B?UjhRaE1rTHM3Sml3OHBDSW40RG5aWHRGV2pzbzNUQjhwTURWS2c1azlqTmhp?=
 =?utf-8?B?YTVoeFdqSFdDRlNGdkdkSjZuQzRYOXoyZmVyL3hieU9oQ2w2WmsxTlJhaEMw?=
 =?utf-8?B?Syt3Qmp2ZVp1V2VLNjdkS0tFZ2ZEK0UyL3FWYXJMMW8xMFgwL1FmL3JuOHB5?=
 =?utf-8?B?aXdUdVdlUjJFVUtOS3JnekkxeHh2QzdNN1JSN2NrblNFM3A4TGswUHpGNHNQ?=
 =?utf-8?B?Rkx5bUZXVUVCSjdDRXE5dmgweEM2M3hpOVlaQnN2V1ptQnBWY0ZuekJDbWZI?=
 =?utf-8?B?WXlrQVhRclBwUEtKTDNFeW1YdWZLaE5uUTg5ME5PUkZMYTF5WW9SZVpOU1B5?=
 =?utf-8?B?K2JQaTJ6c29ZbWtlSFE0QytkWlk2QzAwVFhQZHVYUGlQOVdqZktJZkFNdGRK?=
 =?utf-8?B?bW1uWWU2V2E3TGZkdnNFUW9QR2VuTmJCb0U0cXM1aVZrd2t6SmFkNXZxUFl6?=
 =?utf-8?B?TUxCYlNXWnBVY3ByaDUyYVlOYjlWSjNjVWtRaUVNWjlqZzZqN2sySUFzcEw2?=
 =?utf-8?B?UE5TOGNwUnpTN21mUjVTQytQUU5KV0lVMlppNnp0dEpxRzlIWE80S3pCSktE?=
 =?utf-8?B?NXJjZ0FrSnBXaFh1VWhVT1p1ekZCZHZUSFFFZUtDZTNQc2h0Yk5DeVRmWWU2?=
 =?utf-8?B?RmVQWWx3T2tOZzlGem01NkRZSGdSNFZGTDVnTTBjVVJuYmN1UDAzVTM3blVQ?=
 =?utf-8?B?QmRIUkxZcEhveW4vMEUrZ2E2bjZwZjgyUnM4a1hHUHFzYi9JQ05DMXlhQzVw?=
 =?utf-8?B?TmZzdUlrVEtOZDIzNFFCMGJjYnRyQXppSDZaN1lsQWdSeGh3QXJIWlBRZUZD?=
 =?utf-8?B?R3BqZW04Q0RPLzZQYkx2MHFRbVVURTlzNmQzYllHNHpUdktPbkVIZ3duWC8r?=
 =?utf-8?B?SmErQjR4MU41NFdXbURGdEpxb0FxSXFYUnVjZXBmM2pNUnhUOFFMS1VyaWdZ?=
 =?utf-8?B?VUloSzVpS1hzUFNNSEZucW5vZmNEVEIwUXYxS0U1OXJlRTg0N2tBRGE3SitR?=
 =?utf-8?B?UDl6cTU0Yjc1N1EyMElLMmpUVE4rd3ZCT08zd3NPVnpPMjNHb2J6cVgxZHJL?=
 =?utf-8?B?S2dkcWlvdmxOOU9VblVkV3dYYUF1Z1M2Mis2UVJGbUJ4UWcrRmYxbWFmY1lm?=
 =?utf-8?B?U3RsNlpNR1pGZm5PVUxERzF3Um5iUkFKUEcvVXJGRVRLWFFlY0tRV3JreWRS?=
 =?utf-8?B?THN4SzVFTWZ1REdCSFFSaGo5ejc5TmhpYm1Da2NTMWVVQnNRUXhoTzhVNWZO?=
 =?utf-8?B?alRJdWthZ0RXUS9sUkdScEpQV2t6RTFXTHBoM2NZeHVTaG1nV2FTYnhxbk5K?=
 =?utf-8?B?L0EvMlB1MzlhSFpyRTc4RGdDODNGSFVOR2xCeXpuTGFSLzk3OVdoN2p3NjFq?=
 =?utf-8?B?L0ptVms1NUtvOWQ1V1R6VnloeSs3WlBKZVhHRmlodTZlRmhQcFZQVDRTOHNm?=
 =?utf-8?B?ZWU4ZlowWERqQmcwNFcyUm9WTTVEY0sxU2JjdTJhRUVzakRpTTJFSlpBdXky?=
 =?utf-8?B?Z2FSTHVwMENINTV0MUY3STUwZVZFSlhXbWdJSEQwVlNNclVrY3pObjBTNWRv?=
 =?utf-8?B?eTJMTlpwZEdGRklpZFIzTTRLTW5majRwMENrSlBqMTNaL1pmRzd0ZnFRU3l1?=
 =?utf-8?B?aHlxOStkbm1VM1o1dUlKTkM3Mm9Cd0NJM29rNUN0NUpLNnpiZkVhODVBZEwz?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <927870821038E14CB6E8C0D1A6D1F993@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182ddfd1-b0bc-45dd-26f6-08dace067159
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 10:27:09.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsqAKuVe5jGXYhj5P4go+ijP6SAwWPczNjYYS3MLe+Ct4PoKyoubeWQQM686pkXJn9nJFlFuwHqM1lbf6z9GBIGmqObzDlyl9JUwY56QU5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5669
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

T24gVGh1LCAyMDIyLTExLTI0IGF0IDEwOjA2ICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBT
aGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPiB3cml0ZXM6DQo+IA0KPiA+IEFk
ZCBNZWRpYVRlayBuZXcgbWFjODAyMTEgZHJpdmVyIG10Nzk5NiBmb3IgV2ktRmkgNyAoODAyLjEx
YmUpDQo+ID4gZGV2aWNlcy4NCj4gPiBUaGUgZHJpdmVyIGZpcnN0IHN1cHBvcnRzIEZpbG9naWMg
NjgwIFBDSSBkZXZpY2UsIHdoaWNoIGlzIGEgV2ktRmkNCj4gPiA3DQo+ID4gY2hpcHNldCBzdXBw
b3J0aW5nIGNvbmN1cnJlbnQgdHJpLWJhbmQgb3BlcmF0aW9uIGF0IDYgR0h6LCA1IEdIeiwNCj4g
PiBhbmQNCj4gPiAyLjQgR0h6IHdpdGggNHg0IGFudGVubmFzIG9uIGVhY2ggYmFuZC4NCj4gPiAN
Cj4gPiBDdXJyZW50bHksIG10Nzk5NiBvbmx5IHN1cHBvcnRzIHRyaS1iYW5kIEhFIG9yIG9sZGVy
IG1vZGUuDQo+ID4gRUhUIG1vZGUgYW5kIG1vcmUgdmFyaWFudHMgb2YgRmlsb2dpYyA2ODAgc3Vw
cG9ydCB3aWxsIGJlDQo+ID4gaW50cm9kdWNlZA0KPiA+IGluIGZ1cnRoZXIgcGF0Y2hlcy4NCj4g
PiANCj4gPiBSZXZpZXdlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0K
PiA+IENvLWRldmVsb3BlZC1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRlay5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRl
ay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBCbyBKaWFvIDxCby5KaWFvQG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCbyBKaWFvIDxCby5KaWFvQG1lZGlhdGVrLmNvbT4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IEhvd2FyZCBIc3UgPGhvd2FyZC15aC5oc3VAbWVkaWF0ZWsuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvd2FyZCBIc3UgPGhvd2FyZC15aC5oc3VAbWVkaWF0ZWsu
Y29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogTWVpQ2hpYSBDaGl1IDxtZWljaGlhLmNoaXVAbWVk
aWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1laUNoaWEgQ2hpdSA8bWVpY2hpYS5jaGl1
QG1lZGlhdGVrLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IFN0YW5sZXlZUCBXYW5nIDxTdGFu
bGV5WVAuV2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleVlQIFdh
bmcgPFN0YW5sZXlZUC5XYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IE1v
bmV5IFdhbmcgPE1vbmV5LldhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1v
bmV5IFdhbmcgPE1vbmV5LldhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTog
RXZlbHluIFRzYWkgPGV2ZWx5bi50c2FpQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gLS0t
LS0tLS0tLS0tLS0tLVtjb21taXQgbWVzc2FnZSBjdXQgaGVyZV0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gDQo+ID4gVGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdGhlIGZvbGxvd2luZyBzZXJpZXMgd2l0
aCBmaXhlcyBmb2xkZWQ6DQo+ID4gLSANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL2NvdmVy
LzIwMjIxMTEwMDkzNTI1LjI5NjQ5LTEtc2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tL19fOyEhQ1RS
TktBOXdNZzBBUmJ3ITNkYWI3NE15RXNiY25sMVg1a3YyTjFSUWxaaURmZzlQLVlMXzNkX29wVGNt
T3M1YkdkV29jOTF6MVFHSmdyOHdnNmckDQo+ID4gIA0KPiA+IA0KPiA+IEZvciBlYXNpZXIgcmV2
aWV3LCB0aGUgYmlnIHBhdGNoIGhhcyBiZWVuIHNwbGl0dGVkIGludG8gbXVsdGlwbGUNCj4gPiBw
YXRjaGVzDQo+ID4gcGVyIGZ1bmN0aW9uYWxpdHkuIFRoZXNlIHBhdGNoZXMgd2lsbCBiZSBmb2xk
ZWQgaW50byBhIHNpbmdsZSBwYXRjaA0KPiA+IGluDQo+ID4gdGhlIGZpbmFsIHZlcnNpb24uDQo+
IA0KPiBJIHdpc2ggeW91IGhhZCBzcGxpdCB0aGUgcGF0Y2hlcyBwZXIgZmlsZSBsaWtlIEkgYXNr
ZWQsIGl0IG1ha2VzDQo+IHJldmlld2luZyBhIG5ldyBkcml2ZXIgc28gbXVjaCBlYXNpZXIuIFJl
dmlld2luZyBpcyBoYXJkLCBwbGVhc2UNCj4gYWx3YXlzDQo+IHRha2UgdXMgcmV2aWV3ZXJzIGlu
dG8gY29uc2lkZXJhdGlvbiB3aGVuIHN1Ym1pdHRpbmcgcGF0Y2hlcy4NCj4gDQo+IE5vIG5lZWQg
dG8gcmVzZW5kIGJlY2F1c2Ugb2YgdGhpcywgYnV0IEkgYW0gZ3J1bXB5Lg0KPiANCkhpIEthbGxl
LA0KDQpJIGFtIHNvcnJ5IGZvciBhbnkgaW5jb252ZW5pZW5jZSBjYXVzZWQuDQpXaWxsIGtlZXAg
dGhpcyBpbiBtaW5kIHdoZW4gdXBzdHJlYW1pbmcgYSBuZXcgZHJpdmVyIG5leHQgdGltZS4NCg0K
VGhhbmtzLA0KU2hheW5lDQo=

