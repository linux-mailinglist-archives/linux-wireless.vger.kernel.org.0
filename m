Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D679064AD5F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 02:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiLMB5Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 20:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiLMB5X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 20:57:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244B1D32A
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 17:57:14 -0800 (PST)
X-UUID: 156d2c499113493d8db2adafc10c3854-20221213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=p4eDxJ3gaNQxFinenIcnCJX68e9JBd8EAQTFWYEH4F8=;
        b=cJvBWUlYv9xtaEeVM74LliA4WcmzxkSMoRbUEHpoMHsFTOBSE9yHWdWqt7F5HHohAwCYgXVVZO5KL0KUNlboPFsWzLeSy3YhDQ/fHFODVuU3tVEEvfO1G9fjXuM5m2LOU2moq/u9xWv/SU3TrQ89kg52lmcGOYTBj2R8z2DQffU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:47d6fe29-664b-49f2-adf9-8c9f3e6c557f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:47d6fe29-664b-49f2-adf9-8c9f3e6c557f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:f5a25017-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:221213095708EMEUPABO,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 156d2c499113493d8db2adafc10c3854-20221213
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 153377850; Tue, 13 Dec 2022 09:57:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 13 Dec 2022 09:57:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 13 Dec 2022 09:57:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8SBqoV62MDAbdckW1Ms60cGPHi7ocGSdNB+OYGaOiQw0RtsAD9jkNm9tq9Q7JTwxLPAJVfQca5U+vzdHX1n73KXNWu/wwSVx9RK2PXKjN7TAY4W8IaFcAHlUXkudDVTSzHI8nQBw/6AetBphkxa1zFHRG0nWxvLfHUqytOnnwCpdor5DSZrTfeumiAiEJK+kjQRAculdUs/weM7S/bC5u6PJREezqYYv4//kENNCZSpaKT/YhHsZNmDnYvfOFppjatQqqPk9XbntEwrZM4bnFhBD+YzmRb7Z4JyYoIeVesADC0DCNb7TGJ7uWhT44yCDy41S8wlQWmgzoaXCtsCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4eDxJ3gaNQxFinenIcnCJX68e9JBd8EAQTFWYEH4F8=;
 b=YqVow4VQs+z4ZsfX7t6BDZ98dzxddoPgL0Xv+xA7WCYq/jl7HZJx1BPSvuq2wrdx6qqOiVc7BKtCkMIt2v9eXLfyERPH5pyXLG2wuXRKOzfAfbD+gHS//sW+EjRDZZaJas+ORIn0CpOe6zOy9Xc7KvEhhfxMgLByMRTO/IjsuI5Pu6Ls7iaeeoALWbwh5iQMBPTBLMzpj7TsPIjQ4OirhbPCXuWBW50KKZjKxiz5BEMsRjK3Mt5eescNjmwcHMQ6bV9C9ruiI+A3MqP60WXJxOHmiLF9m4M+W2/Vp0ouP2uNQYN2Onlwm19rnDZffutttyEsisp7uP+Kwje67nofjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4eDxJ3gaNQxFinenIcnCJX68e9JBd8EAQTFWYEH4F8=;
 b=E6Xg9UmQ9rVsHmbIsZxecUE27UTiKNFcezFZIzj2Z1qQkvgGr7oLci4ZmP1DBURLbTTyM1AvpOJED5PT65Y2RYNU2bgcc2uqnPRluTSdDO8IvDz3ZZHIWJN8uamDy6OZ/ce35JiwcGhiVeVySwSOiFyGSfrfAt5JmpFJN/NAMAM=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by TY0PR03MB6306.apcprd03.prod.outlook.com (2603:1096:400:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 01:57:04 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 01:57:04 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?SGFpdGFvIFNoYW5nICjlsJrmtbfmtpsp?= 
        <haitao.shang@mediatek.com>
Subject: Re: [PATCH,v2] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Topic: [PATCH,v2] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Index: AQHZBJsSgs4JUAwTZkiAm8/HCvdXcK5li14AgAWXz4A=
Date:   Tue, 13 Dec 2022 01:57:04 +0000
Message-ID: <9a0fc8be12ac6c826cfceca63c76f8c86ea25a47.camel@mediatek.com>
References: <e603722d58079af98c57a3dc117274d824d1d832.1669798063.git.sujuan.chen@mediatek.com>
         <c4f01e3e-4ae6-3d60-4fd0-b8d8bc5f4573@nbd.name>
In-Reply-To: <c4f01e3e-4ae6-3d60-4fd0-b8d8bc5f4573@nbd.name>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|TY0PR03MB6306:EE_
x-ms-office365-filtering-correlation-id: 109a24fb-f7a1-4030-99c5-08dadcad555b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nV+6ASJeum5fRFsauyRp8cjC6hDNU4oEFyjwFpTeoAinFxoqBzHTJGMUQ4+0yFKg8FHNvyLMROphSJ2dWEvkOaE1cmuVHCFIjuAIfnEgjFcMxc6+jJlXYfIuVOoPqKarvchjWdkx0ImBtzmjNIyxAUoPjMAxBP2nIN+a+IaQ0SOI9s0FXxHNBtutxiPreViAe8jqjtdGp4PfDPiQFcXKN8DxG73gbUXJjUGYfm3yJcVSLU0pGaHVznfyqGHjnP+tabvRT7+55fuUhKPI7nH7dNaIqq88wDV8qfle/TQebPq5VgTJLMFGq8lk92juyg5kZXXA6BETJOqO5xzHXd+bx7WmqTN0k4b61ayxHy5SQH1qYHmQ36/0aoYTvgkvQ52Q8/CuZJFBRdaVaRPEu0GP1jVqNJSaDNlU0z+v9jr+1hWQxeGm72yFfpgRl52VlSpYcLLO4oNWS/6gZwO9ggU4nYEyFP5DrGC3cqqVIUus+Pcddpv0EFJF13kRUQ/+Jr0F5cbncRzboR7OhksuBbi7KwvteofcH4BJL6/NTz4c7hbQHqFtXPChaCmY8CkhU+8X2+rzVNaMw51670NsgAgU3ZzWg2bUOOiLe7F6Wk6e0YmYTD3q+AjBTKgsLghIfK/8sWOievA7Z96T9Ob5vMr0c2G+IYWV3UU/ziJxEifpR9L8YqNSYJ/P5DO4hb2b/tW/FzCEj/Fw0OVdwOe3vP1dNuZ036zaZVdEokJGGscKzXaUMZB2b1amvCVB3V4ceWYL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(36756003)(85182001)(83380400001)(54906003)(6506007)(186003)(316002)(6916009)(53546011)(107886003)(6486002)(6512007)(26005)(86362001)(76116006)(478600001)(66556008)(66946007)(8676002)(66476007)(4326008)(64756008)(66446008)(38100700002)(122000001)(41300700001)(2906002)(2616005)(38070700005)(71200400001)(91956017)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG1BS0FjWERKQ2ovMDVKUTZoQWIwd3lQaytPbVV3MVdBbmtaU1FVazAzMjJ1?=
 =?utf-8?B?YUpLZHlKQkJZdTZoMzVzaXhSNlBtUFZPYWxSTUh3enBuc3RvOXBwZUY2MHpP?=
 =?utf-8?B?QzhuQk9yN0Z3QXpNekVuZ2dkZVEydlM3TlpkZHFRRUxmd2o2R2VoZEJpV2Zw?=
 =?utf-8?B?S1F5WSt4TkxacExRckhvT1daSWxWWUVGdnRhY2k5QzY5YUMzMGdWWjlzUWxz?=
 =?utf-8?B?T1VMSG9pd2NKR3VFQTBjSlM3Q1hKK1RhRE1xQndPd09rdy93d09laEhvWmZD?=
 =?utf-8?B?enlmdXhPTzBKTW5STFc3OGJXMk1VTWdkVXovVFl3dStIU1BuZlZQblpkN0Mr?=
 =?utf-8?B?Q2p0dElDM1BBQ2hBRlZjUER0aGxVT0xmcUVhWW0wa0hZeXptTDZ0M1NsaTRj?=
 =?utf-8?B?MVFSL0x4OFJPbHl2MG5FL1VWc3Nrb1F2R01rQ3JQNENPb3ErT0hiTkhLanJJ?=
 =?utf-8?B?WTd6Y2ZlRHpydEYvb3gvN2o0L2JaS1l4NjhiVUxuem9FWDQ3UVdFSm9OL2l0?=
 =?utf-8?B?MlRPdy9VZ0dveTFxS0ptRXRtaFJhWTZWR3IxZUhnb2J2bXcybVNsT3l5Z2Vn?=
 =?utf-8?B?d05nOS9RYmdlcG9PWmZ6RnpSUERrWTJ6QWVRVmpEeG5IQ254RmRaTUpRSnNN?=
 =?utf-8?B?NTBHaWZodFBwNzBPSjZleTY3djZxeUlmVGFRRGc2STd3TkFvaEdISkZEZFRR?=
 =?utf-8?B?MXI3V1UvYkdnUDJPeStyRXlzRzJEL1dBMHhjWUtlSnc2VHlGbEdlV21rczNp?=
 =?utf-8?B?U3NXdnZ1N1BpajFUMXpkQ3pXajBNMGxPaEp5ZG5KWk43TGtNc2RnUmZ5VnIz?=
 =?utf-8?B?ZEptY0JsLzVHVW9qTjl4NENYYWludFlqMkU1bTZiUmcwSGNWR3NCWDlOdDU1?=
 =?utf-8?B?bExYZFhLU1R6WWJCTUxDb0dNR2Rtd2lWZlZVSGQvUVp4TG1JZ0R5WmRsYzFY?=
 =?utf-8?B?RTZDbkZTbnI2NWlMWE80MHZRM3hKVFJJWGQvZ3ZqRExmREVXTjhkeEc3UFJn?=
 =?utf-8?B?QldwTktRekhOYWFycDBCZUI0YS80ZzZYdjhLZ1VVZXBsZlNhNG93dG8zVEhk?=
 =?utf-8?B?SUw1TG92d28vRnVLOG12TGF0cDRNNkpvY0loR2d6MTJWTUJ1QkR0eU1KOUpB?=
 =?utf-8?B?K0hvWDVGZU9lUlZxWVp4RGJmak1IMFVUKzQ2ZWxzSUJYbnVWMGtubXRMNVV1?=
 =?utf-8?B?elV6anhWSkJ4dnVJdTh5UUY5TDhGVkVlWXVZVkc3dDhHNG9Ec0NuODBVUDhw?=
 =?utf-8?B?aDQzRk9sSXNLOVQ1RkYydE0vbU5mazVWV1JCRVp3a1JCNlg5cURjV21XcXRm?=
 =?utf-8?B?UldSbXBYSGlTaG9Ua1V4QlM0NzIyMjBWalN4bWNvZ0lQMEFMaTV1TmlUbUhN?=
 =?utf-8?B?UmIzcWs3U25PemwwTWpydkNRbGpTY3BIaWhQekZnUlBLdElFRUVxdU14OU00?=
 =?utf-8?B?c0JUdytQdm1DVDVKRTRJMWl4bnN6K013Z2pSNEFlTTlXOUtCWnFlTUZSRVlj?=
 =?utf-8?B?NnFsUldhUll6K2p3T0VJbzFPV0tWUnMvY3pnQjNRUVE2UDgxODZCMnNIVXk5?=
 =?utf-8?B?Z3NwUUdaNW1TOFNEOEs1YytBbTVBSVliMTJTTWkwYmFiZExqY2czQ1AwcFRV?=
 =?utf-8?B?ZDI1azNTaHNsbXdyZEs2M2ZMTVdtdjQyWGdVOFBkY0VMUXVURjQ4a0ZudVhy?=
 =?utf-8?B?M0VRSVlBZVZmMXh1NmlNVm8yTWttNXlqMVgva3BUamF3WGN2VnNYdE1JVzdz?=
 =?utf-8?B?alVRTml4alg4ZmpGSVhxWllvbHJxSC9LV0tHVE9BaUpWbUp1ZldPUFhmaW5m?=
 =?utf-8?B?aVM0NmVCUEFpVVNEbG1lWDlNZEVrUmIzNzJYYmVpRXJ3T0ppSXZaeVJWUVZE?=
 =?utf-8?B?bmVJUGNRdDl1RjJEQjF0UTVETmFqMVNWQUkzMUpCMUFvTmpCYmh5SFhqNTlO?=
 =?utf-8?B?dmJKWS9RMTlKN0VLMVVLMGNhYXRPTEM3Y3phb0Q1eVA3OHRMNWwydVhRSUFr?=
 =?utf-8?B?aExFdys2dStGcjlUQWdnY0NuUSs5bkYyaFF4L1c4Y3BpMjNrelpWRHlGSjVh?=
 =?utf-8?B?eHBCWVZqZkY0c1RWUDZzR1YweUxobTJrVFFGcmxqekI0U3doc1d4NEUvSWVs?=
 =?utf-8?B?RDlERjBwTHR5RnVMMWJRZi93NW84REdSRFZBSnNrWERGeGZINDVEbi8zeEpy?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36A222427597D446B861E81727AEFFB9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109a24fb-f7a1-4030-99c5-08dadcad555b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 01:57:04.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rRu1ie2tM/bNdWWm5taibA0mPCav03VcPDbfBLU2DjQvkttsBO+xAjYub5sRWktSLJZ7KQp9KkeEzq4mV6LDh0N8AFHOgZtLMK4ZtTRpCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6306
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDEzOjMyICswMTAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAzMC4xMS4yMiAxMDoxOCwgU3VqdWFuIENoZW4gd3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQg
V0VEIG9ubHkgc3VwcG9ydHMgMjU2IHdjaWQsIHdoZXJlYXMgbXQ3OTg2IGNhbiBzdXBwb3J0DQo+
ID4gdXAgdG8gNTEyIGVudHJpZXMsDQo+ID4gc28gZmlybXdhcmUgcHJvdmlkZXMgYSBydWxlIHRv
IGdldCBzdGFfaW5mbyBieSBEQSB3aGVuIHdjaWQgaXMgc2V0DQo+ID4gdG8gMHgzZmYgYnkgdHhk
Lg0KPiA+IEFsc28sIFdFRCBwcm92aWRlcyBhIHJlZ2lzdGVyIHRvIG92ZXJ3cml0ZSB0eGQgd2Np
ZCwgdGhhdCBpcywNCj4gPiB3Y2lkWzk6OF0gY2FuDQo+ID4gYmUgb3ZlcndyaXR0ZW4gYnkgMHgz
IGFuZCB3Y2lkWzc6MF0gaXMgc2V0IHRvIDB4ZmYgYnkgaG9zdCBkcml2ZXIuDQo+ID4gDQo+ID4g
SG93ZXZlciwgZmlybXdhcmUgaXMgdW5hYmxlIHRvIGdldCBzdGFfaW5mbyBmcm9tIERBIGFzIERB
ICE9IFJBIGZvcg0KPiA+IDRhZGRyIGNhc2VzLA0KPiA+IHNvIGZpcm13YXJlIGFuZCB3aWZpIGhv
c3QgZHJpdmVyIGJvdGggdXNlIHdjaWQgKDI1NiAtIDI3MSkgYW5kICg3NjgNCj4gPiB+IDc4MykN
Cj4gPiBmb3Igc3luYyB1cCB0byBnZXQgY29ycmVjdCBzdGFfaW5mbw0KPiA+IA0KPiA+IFRlc3Rl
ZC1ieTogU3VqdWFuIENoZW4gPHN1anVhbi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiBDby1kZXZl
bG9wZWQtYnk6IEJvIEppYW8gPGJvLmppYW9AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEJvIEppYW8gPGJvLmppYW9AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1
anVhbiBDaGVuIDxzdWp1YW4uY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjI6DQo+
ID4gICAtIGRyb3AgZHVwbGljYXRlIHNldHRpbmdzDQo+ID4gICAtIHJlZHVjZSB0aGUgcGF0Y2gg
c2l6ZSBieSByZWRlZmluaW5nIG10NzZfd2NpZF9hbGxvYw0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmggICAgIHwgIDYgKysrDQo+ID4gICAu
Li4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYyAgfCAyNCArKysrKysr
KystLQ0KPiA+ICAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYyAg
IHwgMTMgKysrKystDQo+ID4gICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21jdS5oICAgfCAgMSArDQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L3V0aWwuYyAgICAgfCA0MA0KPiA+ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvdXRpbC5oICAgICB8ICA3ICsrKy0NCj4gPiAgIDYg
ZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
YWluLmMNCj4gPiBpbmRleCBjNDBiNjA5OGYxOWEuLjQ2YTllNGYwMzk2ZSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMN
Cj4gPiBAQCAtMTExNSw2ICsxMTIyLDEzIEBAIHN0YXRpYyB2b2lkIG10NzkxNV9zdGFfc2V0XzRh
ZGRyKHN0cnVjdA0KPiA+IGllZWU4MDIxMV9odyAqaHcsDQo+ID4gICAJZWxzZQ0KPiA+ICAgCQlj
bGVhcl9iaXQoTVRfV0NJRF9GTEFHXzRBRERSLCAmbXN0YS0+d2NpZC5mbGFncyk7DQo+ID4gICAN
Cj4gPiArCWlmIChtdGtfd2VkX2RldmljZV9hY3RpdmUoJmRldi0+bXQ3Ni5tbWlvLndlZCkgJiYN
Cj4gPiArCSAgICAhaXNfbXQ3OTE1KCZkZXYtPm10NzYpKSB7DQo+ID4gKwkJbXQ3OTE1X3N0YV9y
ZW1vdmUoaHcsIHZpZiwgc3RhKTsNCj4gPiArCQltdDc2X3N0YV9wcmVfcmN1X3JlbW92ZShodywg
dmlmLCBzdGEpOw0KPiA+ICsJCW10NzkxNV9zdGFfYWRkKGh3LCB2aWYsIHN0YSk7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICAgCW10NzZfY29ubmFjX21jdV93dGJsX3VwZGF0ZV9oZHJfdHJhbnMoJmRl
di0+bXQ3NiwgdmlmLCBzdGEpOw0KPiA+ICAgfQ0KPiA+ICAgDQo+IA0KPiBJIHN1c3BlY3QgdGhh
dCB0aGlzIG1heSBhIGJpdCByYWN5IGlmIHRoZXJlIGlzIGNvbmN1cnJlbnQgdHgNCj4gYWN0aXZp
dHkgDQo+IChlLmcuIGZvciBFQVAgYXV0aCkuIE5vdCBzdXJlIGlmIHRoaXMgY291bGQgY2F1c2Ug
cHJvYmxlbXMgZm9yIHRoZSANCj4gZmlybXdhcmUgb3Igb3RoZXIga2luZHMgb2YgYnVncy4NCj4g
DQo+IFdoaWxlIG15IGlkZWEgbWF5IG5lZWQgc29tZSByZXdvcmsgb2YgdGhlIGV4aXN0aW5nIGZ1
bmN0aW9ucywgSSB0aGluaw0KPiBhIA0KPiBiZXR0ZXIgZmxvdyB3b3VsZCBiZToNCj4gDQo+IDEu
IG10NzZfc3RhX3ByZV9yY3VfcmVtb3ZlDQo+IDIuIHNhdmUgb2xkIHdjaWQNCj4gMy4gbXQ3OTE1
X3N0YV9hZGQNCj4gNC4gc3luY2hyb25pemVfcmN1KCkNCj4gNS4gcmVtb3ZlIGZpcm13YXJlIHN0
YXRlIGZvciBvbGQgd2NpZCBlbnRyeQ0KPiANCj4gLSBGZWxpeA0KDQpIaSBGZWxpeCwNCg0KQ2Fu
IHdlIG1vZGlmeSBpdCBsaWtlIHRoaXM6DQoNCjEuIHByZV9zdGEgPSBremFsbG9jKHNpemVvZigq
c3RhKSArIHNpemVvZigqbXN0YSksIEdGUF9LRVJORUwpOw0KMi4gbXQ3Nl9zdGFfcHJlX3JjdV9y
ZW1vdmUNCjMuIG1lbW1vdmUob2xkX3N0YSwgc3RhLCBzaXplb2YoKnN0YSkgKyBzaXplb2YoKm1z
dGEpKQ0KNC4gbXQ3OTE1X3N0YV9hZGQNCjUuIHN5bmNocm9uaXplX3JjdSgpDQo2LiBtdDc5MTVf
c3RhX3JlbW92ZShodywgdmlmLCBwcmVfc3RhKQ0KNy4ga2ZyZWUocHJlX3N0YSkNCg0Kd2UgY2Fu
IHJldXNlIG10NzkxNV9zdGFfcmVtb3ZlIGFuZCBrZWVwIHRoZSBzdGEgaW5mbyBmb3IgDQptdDc5
MTVfbWN1X2FkZF9zdGEuDQoNCmlmIHNhdmUgb2xkIHdjaWQgb25seSwgd2UgbmVlZCB0byByZXdv
cmsgX19tdDc2X3N0YV9yZW1vdmUgYW5kDQptdDc5MTVfbWN1X2FkZF9zdGEgZnVuY3Rpb25zIGJ5
IGFkZCB3Y2lkIGFzIHBhcmFtZXRlci4NCl9fbXQ3Nl9zdGFfcmVtb3ZlIGlzIHJlcXVpcmVkIHRv
IGRlbGV0ZSBhIHdjaWQsIHJpZ2h0Pw0KDQotc3VqdWFuDQoNCg==
