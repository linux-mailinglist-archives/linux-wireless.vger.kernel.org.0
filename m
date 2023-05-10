Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C96FD40F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 05:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEJDMe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 23:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjEJDME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 23:12:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC905FC9
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 20:11:20 -0700 (PDT)
X-UUID: 531c679ceee011ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UQyKenTZBxOPt8Qt3DT3ld85khN1ZtM7y2iQNip7wAs=;
        b=V8tUFfN5duRwPavL5v8zxHwooe3jSqZXp6AKptvcSWU1cZ49CSzg/S8NtPakMMaKC/LRPO7wYd2j0wB7Fec9HBifDTmJhqgtIqaUB0FOlU34POmD8vHI0BFT2pKRzbT4mJ2ymtTsa94tRftDnOTsQ5nWXv2w5s5KAZsjH3jlNGI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:e6e27bbc-c3aa-4085-88b0-e2612de5d242,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:f86baa3a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 531c679ceee011ed9cb5633481061a41-20230510
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1042430763; Wed, 10 May 2023 11:11:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 11:11:14 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 11:11:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nugIiHBzT82Hwv4HEPQ5KpnCMNdAIMv6pWza431aYv0CSu45tbuODsNNEcQUHmwZFMYFy5LjmiiUnRcIGagL7ncUAdGe1ZyatQRsEbuLN5Onq/O8RW7cSnh7+ag4C3gBAP8qBt0E018GJUbfACtTc0STJbu7k50cirOcmiWINPH1VcrCylxpYmclJwN6okZcFbxNC7rwdkurXGn8OP8/yL4RC5ipUXYmjB3V8j28V3ShF0WTEERRw/5CVAkFEwRHCIjR8Yq0AHqZ5E0jXRqwl/HtS8GYqJYPg4Ipea52igYgn57BWeAVJWnlpkWamJL1kxmLOzSc4wmlBp2gmAqJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQyKenTZBxOPt8Qt3DT3ld85khN1ZtM7y2iQNip7wAs=;
 b=gvbzyQwp6Pr9OI92i8pbml1LaG8ty1JqAUdU1+WochExmnjmJ87n11TEVaL/7InTMAbxX3Weosnjsqx+47XlQobi3PSsAK5ICQhqqO6/3R914OXF1vy3QQevS6hpLmi8yxNBIz9uPy1CJSLOMNVy4DuYR01J9fOIzv3oFITPFGWdGngf1FYZWhRl3HGCWB8NWAK95GuFthLWkrPYa0bxHRR5XZt0CAMRmKB8NgS8SBevW30VYTmV7vame/FLGSrb25CjGd6ihHYE9H/a31J66Uf6nbAHoZu7csoUbotqjnw9abzR8Gqc565Ps3Cwq4L+jfoNxXbuC2bMZSeWBWwpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQyKenTZBxOPt8Qt3DT3ld85khN1ZtM7y2iQNip7wAs=;
 b=mohseIYjpSsI33w/tslVcZ3XtQ4pFuyaajxTPOUaIUmN5mLr83CFXV4cqZw6IgFymHq0COMFD90eIY3MRvVaUoTl/lncZgdYsn20IJDrelvdZE9L+NPnxG9hEiIAwSpAewhwmUmc9FVUdAMS6Sp22FrxP96IS06hVQM4t3u8JxY=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 TYZPR03MB7868.apcprd03.prod.outlook.com (2603:1096:400:45f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Wed, 10 May 2023 03:11:12 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::95ea:f4f2:fa37:c9a7]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::95ea:f4f2:fa37:c9a7%6]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 03:11:12 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>, Ryder Lee <Ryder.Lee@mediatek.com>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>
Subject: Re: [PATCH v5] wifi: mt76: mt7915: report tx retries/failed counts
 for non-WED path
Thread-Topic: [PATCH v5] wifi: mt76: mt7915: report tx retries/failed counts
 for non-WED path
Thread-Index: AQHZgie07Nwp/2kVK0icrBheyTz0V69SPtAAgACXAwA=
Date:   Wed, 10 May 2023 03:11:12 +0000
Message-ID: <d3a40ed166b169f9113da557236d3492174bce99.camel@mediatek.com>
References: <13d9169b5709efad969d7d167a1ff19828395fed.1683602740.git.ryder.lee@mediatek.com>
         <46117c51d736be7ab8e5cf280d779f45751b73ae.camel@mediatek.com>
In-Reply-To: <46117c51d736be7ab8e5cf280d779f45751b73ae.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|TYZPR03MB7868:EE_
x-ms-office365-filtering-correlation-id: 670ea39e-1864-4d8b-e080-08db51043566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVFEq+f6W1gWigHNa3mHBVzM0vp0TIH7+Okcxq5s/Oyxdj/DMIgfJVTPJb0IUIUIPzXSMQBZ1BuoKBcfL+Ia+6BVoZVCqmeS18jrnINv22mUX+HqsBE0S+kOqRRVqlOgjVhNiFTxQhg88Bl1o+pGxZ/WsC2exDX9x5PnQTtcK9gci4Qh6NHBWtnZZysTKHUMRvoosXILZ+pJRoNbe5VYJkksyONaBQpMUzcFerGsbplLv8IlmfMlUiFY3xIAWXnwVE11kbK7eV1t2K4+a/n3iqyYTacb0MPmuDUZGDAI0sL8WfKDnaPDZR9HaQay8aFp8adiTS5IQL/hwIjKt72mXs3gWCqfyD5yy6bT0bXz9Cc7SjDkXe0DWKoJ6Z5nVT2p7XxffA/9FkSR4iXp888FgrwDAlE75gvhR0oJdKu6OKvqB/i9lexhtj/RyNh4Toja2XpdjHDLdTro13gwxgRGRpNlHC5wHv2vUH6HEeaDWmXoo+df1uUj2gpWGNbwM5/xugZ0lQmiKEWd3QYFx8Lt9XlmKfptqyt6hx9CmbezoQgGKF2v1vkJ26EhoaPOvNYe2rMlrHJ4Kd3i0pjoNV+5OlLmhCWWt+Q3MYYLucjJb3WawenX557OslxgqtRQVecPUsXLn//IKBvAqB5CBWDPOb0onTbcbA47s+YVpzi6qmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(84040400005)(451199021)(6512007)(6506007)(26005)(186003)(478600001)(54906003)(66446008)(110136005)(6486002)(85182001)(5660300002)(8676002)(71200400001)(8936002)(36756003)(6636002)(2906002)(38070700005)(4326008)(91956017)(76116006)(64756008)(66556008)(86362001)(38100700002)(316002)(122000001)(41300700001)(66946007)(66476007)(107886003)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjVTRmpjVy9FZ1BtZi95b3hZdXpVYzRuVGszMnpzSFIrY3lweUpSdU5heUo2?=
 =?utf-8?B?TWFFVGpGSWJRL1VpSktiTkdhNjBxSU5YSGxlVkhuc2JEblpzSSt4UytUOU1p?=
 =?utf-8?B?MDhrWnFDRFFkUkpkQ2V5d2xURnBVbE1OWG1xcUVIRldIeWNybklmbEdOejll?=
 =?utf-8?B?VW45NGI4OUdLVXY4Z1hHUlJQSDFYV0xERVNJdGlMWWlWQm95Z01PUjZlekFv?=
 =?utf-8?B?cytFVW9SeG1lQVhnayszRUZVRkMvenNjZkZPWEoydzQ2VVBpdmpYT3VkTTM0?=
 =?utf-8?B?RmlveDdwcVE0bWVpUEtCU3htNG9HRXpCcjRZUURuZFMveFRPd2hNNXZDaGFn?=
 =?utf-8?B?SmhJYlZ4QlFSb2lEOFkvMkZVMkFiNHVPakpleXJaNlV0WHpwYUF1aVhYKzc0?=
 =?utf-8?B?dG1QWUxRbmYrZENsS3BVSXh0MTRhOUpneE1nTFYzem5uYnBrV2lsellHQWhq?=
 =?utf-8?B?MVdiQWtYVW1UdWVtU3kzd1ZDNVh6MFZDcFY1Tm02ZVJ6WUJTSXRBcVNoNHZk?=
 =?utf-8?B?a05DOGhzbk4yTGpSYUk5ZGtaVTZQQmF5YWxaT3ByYVpiQy9wNWhKKytQM2dt?=
 =?utf-8?B?MzRnQjB1bHBBUXRsWWZPa0hMZExWbDlSWDlsRGpoaGtaUTYrWjJBZUZtM1dU?=
 =?utf-8?B?TkVqYmgrbkgyOVF4Uk9rOUN1c1NrbzcwSUx2cUhsdFRCcmdDQ3ZhQkM3QzM2?=
 =?utf-8?B?WER1azd2NGxQYlg1OGxEMTI5Tm85NzRZSHYzQXpSZUpMbzFhM1kzeGdYa3c4?=
 =?utf-8?B?VDNaNGc4N3VkTVJEVWdqQWJRZmlCbUFKendEWldjeUxLOHlYWWFRVXRMOFNW?=
 =?utf-8?B?azBLRDBqY1FvV2Fsbmp4bW41ZytKV01tS0ZHSWVxc3RBTWZ4eFAxaFJJWDBo?=
 =?utf-8?B?a0t0cm9VL2x0UVFaTXoyUXRtVG1JY2ZCT1NzSi9KVGJ0akRwc3p4MUVVNWM1?=
 =?utf-8?B?SDBDa3V3T1RDdUpIUWsxRGpVVkNzVzVDL2g1NUZSS1ZBS2VjZ2twTStEK1ll?=
 =?utf-8?B?bXBlQUo4b1pLZTBUMjVPMG9kWlFyYStpeFk2QmkvUEVnclhFR2FuQS8xM0ow?=
 =?utf-8?B?bVhoYWFYdFhFalM4Q1dBOWovOEZaZUVuRGd4SmJoY2w4VVg0eXJ5RWhnSXFS?=
 =?utf-8?B?a3FERTlrSVROTlR0a3NRbVZkcjB2RjR3OHNsSUloYXZSNDAwR3lINitYRjJM?=
 =?utf-8?B?Z1VFMTRjN1VEUk1TTHExNHprbmVSVW52VzAvcGppOE9ib2h1N1FUMUFCaFF2?=
 =?utf-8?B?OUxNMnNBT3l5QWhBcU5zdUNEZjQ0UUpWc3hDRHNjVkZyWEFyNXNNUk83blVC?=
 =?utf-8?B?SzZsVE1Pem13dDd2SG5tOEFtSW1TWFRwcFFjeGdJV0ZXOEkyNk1yQTRJTTY1?=
 =?utf-8?B?cVJ6TXg0MXhvVktMbmY5cmdCNTNKMWdsc1oxUGRxOVZJTUt1KzhWTUhhNVVu?=
 =?utf-8?B?ZWdCUlpPb1hVZEhMbTl5MFBiVHJYWUp1MCtveG83RmFtaFF3Q25SY3VnbWxM?=
 =?utf-8?B?NW43SlFhck1XQ3lrZU9rYmRxN0JoM1hHdkNtSkFNOUtzZmxoeTl1QmlXQjVr?=
 =?utf-8?B?dVZqMlJHY2Z1NDk5SnJYSFVWSVBBd3E5QmF5TGdUTjk1TkFTM0hsbUpwWHRk?=
 =?utf-8?B?TEg0MTRIQ1JrQVVRQkxMU2NMRkNIUUIwZ1MxV08wTWR4SnJjWUxYNXBEUVJF?=
 =?utf-8?B?M2puUDVTUEttdVBTU1JtT3ljNmxKTk9iS0pNSjJhUmt2QmVhK2lPRHljT0hL?=
 =?utf-8?B?bHdnYmZOWmNTYzl0TGFncmFVMDFDVFcrYnNCS2RqT1JiOGRrRDI5LzVGcjVr?=
 =?utf-8?B?MUw5b3dTYW9sVElXZU5mNHVpVnZvQTJKd0U0UVNwNytIQVp2NHNoM0tDeG9m?=
 =?utf-8?B?ZFZBVlFNWG1UL0JPZjI4NmxJRVd4d2RSK2Q2MlNKWkRXTmVzSmg0SVJDOVll?=
 =?utf-8?B?TDN3M0Qvcm1YSUt1YjgzajdoanNwZzE2eWJ4S3RxaHdxTXozMk1IWGkwZHJ5?=
 =?utf-8?B?MHVYa2ZPN2VIangvZDdoZ1hsWjREazJJVFhSV3FLT3QrQTc2cFFlNGp3TDM1?=
 =?utf-8?B?a2hLc3JGdkdmbjdCNGphS0Vqc29tcjNQYndRaEMxazBhZFdTd0UrTXgvVkZC?=
 =?utf-8?B?ajNlOTZ2UWF1amNWSHBITEV6MU1VQVQvZENVOEJJSVMwSW9tQVJtU0lHOWFJ?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A2B914F35D604EB9661E9462D43FDF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670ea39e-1864-4d8b-e080-08db51043566
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 03:11:12.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvg3zja6HXZHKsiBZnvcMT1WPYd3XU9yLU4szZlUpPQwGr3ncza+elaXfKRQDeTSNGJHepBoJiYtDvdieQh92g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7868
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTA5IGF0IDE4OjEwICswMDAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IE9u
IFR1ZSwgMjAyMy0wNS0wOSBhdCAxMToyNiArMDgwMCwgUnlkZXIgTGVlIHdyb3RlOg0KPiA+IEdl
dCBtaXNzaW5nIHR4IHJldHJpZXMvZmFpbGVkIGNvdW50cyBmcm9tIHR4ZnJlZSBkb25lIGV2ZW50
cyBhbmQNCj4gPiByZXBvcnQNCj4gPiB0aGVtIHZpYSBtdDc5MTVfc3RhX3N0YXRpc3RpY3MoKS4N
Cj4gPiANCj4gPiBDby1kZXZlbG9wZWQtYnk6IFBldGVyIENoaXUgPGNodWktaGFvLmNoaXVAbWVk
aWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIENoaXUgPGNodWktaGFvLmNoaXVA
bWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1l
ZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2NSAtIGZpeCBub2Fja2VkDQo+ID4gdjQgLSBzd2l0
Y2ggZnJvbSBUeCBsYXRlbmN5IHJlcG9ydCB0byBlbmFibGUgVHggY291bnQgaW4gdHhmcmVlDQo+
ID4gcGF0aA0KPiA+IGZvciBub24tdjMgZm9ybWF0DQo+ID4gdjMgLSBhZGQgYSBtaXNzaW5nIGNo
ZWNrIGZvciBtdDc5MjENCj4gPiB2MiAtIGFkZCBhIG1pc3NpbmcgY2hlY2sgZm9yIG5vbi12MyBm
b3JtYXQNCj4gPiAtLS0NCj4gPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25u
YWNfbWFjLmMgIHwgIDcgKysrKy0tDQo+ID4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvaW5pdC5jICB8ICAyICsrDQo+ID4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWFjLmMgICB8IDIyDQo+ID4gKysrKysrKysrKysrKysrKystLQ0KPiA+ICAu
Li4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5oICAgfCAgNyArKysrKy0N
Cj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgIHwgMTIg
KysrKystLS0tLQ0KPiA+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Jl
Z3MuaCAgfCAgMyArKysNCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tYWMuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tYWMuYw0KPiA+IGluZGV4IGVlMGZiZmNk
MDdkNi4uNmI1MTVmMzMwOTc2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWFjLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21hYy5jDQo+ID4gQEAgLTcyOCwxNiAr
NzI4LDE5IEBAIGJvb2wgbXQ3Nl9jb25uYWMyX21hY19hZGRfdHhzX3NrYihzdHJ1Y3QNCj4gPiBt
dDc2X2RldiAqZGV2LCBzdHJ1Y3QgbXQ3Nl93Y2lkICp3Y2lkLA0KPiA+ICAJc2tiID0gbXQ3Nl90
eF9zdGF0dXNfc2tiX2dldChkZXYsIHdjaWQsIHBpZCwgJmxpc3QpOw0KPiA+ICAJaWYgKHNrYikg
ew0KPiA+ICAJCXN0cnVjdCBpZWVlODAyMTFfdHhfaW5mbyAqaW5mbyA9IElFRUU4MDIxMV9TS0Jf
Q0Ioc2tiKTsNCj4gPiAtCQlib29sIG5vYWNrZWQgPSAhKGluZm8tPmZsYWdzICYgSUVFRTgwMjEx
X1RYX1NUQVRfQUNLKTsNCj4gPiArCQlib29sIG5vYWNrZWQ7DQo+ID4gIA0KPiA+ICAJCWlmICgh
KGxlMzJfdG9fY3B1KHR4c19kYXRhWzBdKSAmDQo+ID4gTVRfVFhTMF9BQ0tfRVJST1JfTUFTSykp
DQo+ID4gIAkJCWluZm8tPmZsYWdzIHw9IElFRUU4MDIxMV9UWF9TVEFUX0FDSzsNCj4gPiAgDQo+
ID4gKwkJbm9hY2tlZCA9ICEoaW5mby0+ZmxhZ3MgJiBJRUVFODAyMTFfVFhfU1RBVF9BQ0spOw0K
PiA+ICAJCWluZm8tPnN0YXR1cy5hbXBkdV9sZW4gPSAxOw0KPiA+ICAJCWluZm8tPnN0YXR1cy5h
bXBkdV9hY2tfbGVuID0gIW5vYWNrZWQ7DQo+ID4gIAkJaW5mby0+c3RhdHVzLnJhdGVzWzBdLmlk
eCA9IC0xOw0KPiA+ICANCj4gPiAtCQl3Y2lkLT5zdGF0cy50eF9mYWlsZWQgKz0gbm9hY2tlZDsN
Cj4gPiArCQkvKiBhdm9pZCBkb3VibGUgY291bnRpbmcgaWYgZGV2IHN1cHBvcnRzIHR4ZnJlZSBl
dmVudA0KPiA+ICovDQo+ID4gKwkJaWYgKGlzX210NzkyMShkZXYpKQ0KPiA+ICsJCQl3Y2lkLT5z
dGF0cy50eF9mYWlsZWQgKz0gbm9hY2tlZDsNCj4gDQo+IEBEZXJlbiwgY2FuIHlvdSBoZWxwIHRv
IGNoZWNrIGlmIG10NzkyMSBjYW4gZHJvcCB0aGlzICBhbmQgY2FsY3VsYXRlDQo+IHR4X2ZhaWxl
ZCBmcm9tIHR4ZnJlZSBkaXJlY3RseT8NCj4gDQo+IFJ5ZGVyDQoNCkhpIFJ5ZGVyLA0KDQptdDc5
MjEgc2hvdWxkIGZvbGxvdyB0eGZyZWUgZXZlbnQgYXMgd2VsbC4gUGxlYXNlIGRyb3AgaXQgaW4g
dGhpcyBwYXRjaA0KYW5kIEkgd2lsbCBwb3N0IGFuIG5ldyBwYXRjaCBmb3IgbXQ3OTIxIHZlcnNp
b24uDQoNClRoYW5rcywNCkRlcmVuDQoNCg==
