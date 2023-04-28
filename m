Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912F6F20A0
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 00:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbjD1WAO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 18:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbjD1WAK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 18:00:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D464232
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 15:00:07 -0700 (PDT)
X-UUID: 06d0b11ee61011ed9cb5633481061a41-20230429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=/7Xq4oiI1nBtmuJfWh0ldLPrOL+DFw+EPra/TiSdKZE=;
        b=tysBlD90m6gPl2OI+g9U98egaW6LU3oTD+jOn0nIyowu/fEyEthZrcjTK+GeyPGMHNk4l/8KWrcVODB9MkdF+9sPQ7MnKlBmevE577ZJPjqR4QqKXF4RQzZwYss50aOi5e0myP5AZfzqFi9YzzEpiUS2cpWwdrUD+fuAf58g2kg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:1a7b71dc-2cc7-4609-97c2-739b975fbcfc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:410d49bf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 06d0b11ee61011ed9cb5633481061a41-20230429
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 564513145; Sat, 29 Apr 2023 06:00:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Apr 2023 06:00:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sat, 29 Apr 2023 06:00:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMArgmFU2EA25T0vLE4TDIcK/gJReLoYFGorM6x6xWxz1nhcfliUxUz0I7mJHwnTCGYIoGlUm6qEKiJUB9mhan6gQgM0ikV67HfpSugKsYx/+fIBYk9nfAzKV1dQVbv2f0SrsnekyeIRa46aKqOA1ihSRpHa9pqoYxLJipIY6qSIi199AQp8JCeXP7ZnZ0+YNpw0Njy6OEH2usqEOKZCFRwFueTDCPMQr9lAhgg+CtJZk2zOAvt+CUlKqap1cXEfpwfPFcY7y6yQSobNGygAEY/hwUjaOpMWdUoX/mIn0ZyTplZ2xR7f9S6cHVSuKTHnbkQvE6JSnp69HSUeiB/wGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7Xq4oiI1nBtmuJfWh0ldLPrOL+DFw+EPra/TiSdKZE=;
 b=dGOgEMWe1T0ksLQEUhzttdhYtKq9keLtqn3f3iGM+Udau96cuAzbVBXqOTKCzbieBrYmlI4sjWp2pu6bfWng7n/Xbikj7pJI1Z5sevXOFnusdNeqnrvyYXmjpIVusFv+CT/QULJRctt2RyiJMxPrjs/29wCAC9f1D0r76Nbu0FD+KibQVIpiy1l2BU8sKSHl7GPM5SXjAj8wj03OfY0BK5PIfmUl11up5SR1g37/f1gEAG8Rvzu7PwhfjyUV9Ft/AvTNTcRmEJZiHmihNb8jzDI6HQX6SSOIMPehE9Iuwjs5GESuOMR11YQFuLllg0woLG03YqfnyFW/Lw20FC3Xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7Xq4oiI1nBtmuJfWh0ldLPrOL+DFw+EPra/TiSdKZE=;
 b=UOoCMO/JJ+mWZRNUnNeFr4CZofcTnIcRAqaOmAkQ6ph+/mWJVZgL/d7jP1StTHXghsjYzgvA7cQq+mqjNEUuFTbB3Wlu/CIb+5TtcLOly1+A7ixtmcJpBXjDDpbpuJ/F2mk9Q90rHHjpIa8ws5EIjzIjYtXujbSZyZngPx9cFBY=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYZPR03MB6050.apcprd03.prod.outlook.com (2603:1096:400:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 21:59:59 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086%3]) with mapi id 15.20.6340.025; Fri, 28 Apr 2023
 21:59:59 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "greearb@candelatech.com" <greearb@candelatech.com>
Subject: Re: [PATCH 3/6] wifi: mt76: mt7915: Support setting aid when in
 monitor mode.
Thread-Topic: [PATCH 3/6] wifi: mt76: mt7915: Support setting aid when in
 monitor mode.
Thread-Index: AQHZehMXSGGLqtqNnkq+oxW9mP6e3K9BRWUA
Date:   Fri, 28 Apr 2023 21:59:59 +0000
Message-ID: <c664250319a1273c72bef60ca96c93ef67077f24.camel@mediatek.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
         <20230428205000.2647945-3-greearb@candelatech.com>
In-Reply-To: <20230428205000.2647945-3-greearb@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYZPR03MB6050:EE_
x-ms-office365-filtering-correlation-id: e42bcb82-ef70-407f-211d-08db4833e907
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJvjvDTWKs4B7UgSYSlzdoxdeDDLZ54yH4AxyVfQyuVjW6sGCSk9VKuuYnYqameChgMEL+3QXzmPWcNtIO38hXfBggib94cq/HN0bFwvkFSRH0aMp+S/40O1WEElAU5l4TmJhDJV5xNV8ZiPWNY8BOXXTIkWEbGiqsus0jIUvJcQoWZOb42f/riie90MZ7/r+H1tUiyTVpoOeRxhFX12gTDtGE0resFnRiAA4mrcRJ9BmXvaOVkQVqWelWS2kR11KBPLspHpcaLVaMyGcSh78kzgFQoR8X5BStuCV3mMklHXMsizXf+SYu954S+z7Y03AlabhWtp3O/K8oRQeAz8rUS9tqZRO6zFoxupD1Cidg0WNwyYwHGxSp702kvNYu61kMwqe2Ub1TrZzrIbARx4N58WqWczUXTKmUmIdSb0RFN+Ap/7r4QFaTKmaPXivQjBwOMHUhqs5HaGlQ264IPerXD/oDBa6EIhOYyOpj2Ltf0soLL6vuzyqBVYSwoN/QK4ZAMHkFP2OYyod0otrLbnyD2+pFgme0LPMarX5Y4+kR38tvgrHlxAygpMJt9NVA0myj6PL3CjDaSbe+5Fz6AypHHOYa4b5yBVzMqy1j03yyFHETrs06y7VDcQ8YusA0Jq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(110136005)(478600001)(38070700005)(71200400001)(36756003)(6506007)(83380400001)(186003)(6512007)(2616005)(6486002)(26005)(66556008)(8676002)(8936002)(66446008)(66476007)(41300700001)(122000001)(64756008)(76116006)(66946007)(316002)(2906002)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0RZNjMxclZzUkhVYTVlRmE1clRhaEJYUmpRamk1MkNndnh4UVV5NHA3NkpC?=
 =?utf-8?B?UFhzMWtNcjdqeVlZTzFrNDI1Z3E4MVNzbEhhNHpwZVVUK0pZUm80WVIvQk5l?=
 =?utf-8?B?a2hPS2NkaVErUUNyM29QUm9ON1lKQjNyelhHdVhQMUxTR3RYaGlqN1JkU0tD?=
 =?utf-8?B?TjNEc1NWSzZheGR1MmZzWjNFa3hiYmkrNjlLVW1yTktBNWNKU0lPbXZXeDcy?=
 =?utf-8?B?TE0xNjVHR0JhekV4VmIxVUF0alVuY2FSMGIzMnZjaGlsRzI3b2NYeVU2TlFT?=
 =?utf-8?B?a0Y5YmpvQUxBdVFmMS9wRnpoYlB6elJRYjFzVHZtWm80ZkFDbjJDb0lmWVlx?=
 =?utf-8?B?cjRFT3B4THpZa1ROaHIvQ0dvd2JGbFBNODF3WU1qL1lxMEdyb2k4S3FVbGZm?=
 =?utf-8?B?Y0Vmd1VjYzdZZzFpTTZNUmY5R0NoWnNuOTZKeDRzQktNdDRCVkJnTHVoWGRM?=
 =?utf-8?B?Vkg3aitqaGRpallPT2tiUWdxMHROZnBXbFFMb2tyRm1TUlRRT0Yrang2RTNj?=
 =?utf-8?B?bTRjRkoyNXRyN1VSSStaVTJHeDFxN0I1bHMvdEZzdE8rTFhac1BtbHdPS1o5?=
 =?utf-8?B?U05iSXkzYmQ0WGsvbkNIZWViVnRTdm90MXZEWFlNN2pEbU1QdGFNV3RBcGFY?=
 =?utf-8?B?SlQ3WnBhT2JsRlhTaGhhVGE5OVk5cC9aVGlvbnU2MHhKTmhYVjlMd0V1bVhN?=
 =?utf-8?B?a0E4eElSWVNwdVdPeDdhWTduclJxSkdhT2lvTVgrd2xwUjZGK2FCRldRT21l?=
 =?utf-8?B?aEMreEs4akNhYlNUemhjbHkvWkp6NW5PVkw4eGMxVUpqbnJlZzdNUG45R2JS?=
 =?utf-8?B?N1l3c0xjek9zTG1QY0VmKzVBVjdWVVduS284a1pHSm1iUDc2SUJ4VEM4alEr?=
 =?utf-8?B?UFptWTB1ZW1XTkw1UFpWbFFTM2FEdUUwQVo3Y2ExVkh5N1grUFJNRUg1S2g4?=
 =?utf-8?B?cGQ2VnpaTGNQcFZKelcyV2hPZW1MTW1XS2hkRlhoR0VmLzdkakh3MGEzUHVJ?=
 =?utf-8?B?ZFdxQ3hPNjZNdHRDclBULzBNSGdLbG1mcHpQL21hRENxODlmdWdVSXBPSXNm?=
 =?utf-8?B?M1VJbjVnYXhCeW45Vk1jRHlqbHFkbjFMZFQzUXh2VGg5clJDblZiV2tYWDB6?=
 =?utf-8?B?VDE4WGtsOWg3eVZFNjVuQllTazgwNnZ5bWdickJ3Mi91VjN5Z1FVVXdtMkRK?=
 =?utf-8?B?YTNyMklFbEdPVjJMNGdVblNwZk4wWm02SzZjcnVNNlNRWVZPbHBvQjI3QmpS?=
 =?utf-8?B?eDhkVUdBc2kzRFdQcVRHOXRuMjcrU01nbTJpcmt3TDRYK2ZtRGNOanVUTVNp?=
 =?utf-8?B?RldIVUsyK1dwNjU2N0tGZ2tMSGJxUHlvQmgrTTlwcTdPcmVEY0s5Y1pSMlJ2?=
 =?utf-8?B?Nm9Dbk42YnBsTDM5WjF0TXVVK2czWEJBZEZkck5CbExjWUJHdDhIUXlJVWtU?=
 =?utf-8?B?eXlRbEx6TlIrQkFwWmVQdlJQc0RHYXNRTnJKRW5oTVgxYk1ac1lqOVdRRnJq?=
 =?utf-8?B?MEMvWnk1L2haYWxQVmZBWFJqYm9zaXh0L2VVb04yaXRyNlNndUtpb0o4VUlW?=
 =?utf-8?B?MDBNVHNzTklUbWNHUVRndUdGM04ySEEvUEl1Q3BnU2xIK2V0MDZ5Z1J2YXB1?=
 =?utf-8?B?Q3Y4bWNEd0VoV1dhQitkNk9nYTFhUkJzNGt2TmRyZVhKUWkwUVdOeFM0enlX?=
 =?utf-8?B?YllPQ09QcHh0NTM0Z0tUMjY2SVRRcUhEcTl5TU5HWnVGQjRLSUhRZDRMSXpk?=
 =?utf-8?B?ck5HanA0NVpuYzdOSHA5ajJTVUxRdnZZbnJjWWxYOE1hckNqQ25UbU5rUDlO?=
 =?utf-8?B?Q1YrWkRucmFnTEJiTStjZjh5b2ZvWW1NVGlDTldYMmlMSitYNHRIb3VyMTZt?=
 =?utf-8?B?OWFRR3cweXlHNFdZVTNlTzJLaS9pRHNLcGtqU3dHL1pnRXF6WU40ZnB3eGRR?=
 =?utf-8?B?bkZ4dWdOK2h5RnlWY3NXTUtqVXY1cXNDTTlUcjdza21aOUM2aGtpQnVUa0Vw?=
 =?utf-8?B?SjU2elRUR01xSnpyOEdFTFBXcUtFTGllOWJoTTlUd05JUW1qVTUrL1lzS24v?=
 =?utf-8?B?aDEwQUQwUXNFdUkrMENWY1NSM3VUenEwdVBmZWxQdjc5enNTa3M0Rkk0VVZJ?=
 =?utf-8?B?UElxY0FnVGlpZHQxS2FZS0lGNlFqOTlQTXJsWlY2RmJ1bEhSTmtHSlZiWGhj?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04B9A2A505E4B941873C063F13C12E0E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42bcb82-ef70-407f-211d-08db4833e907
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 21:59:59.2556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzHGUFDjyQd19QT7p2d3VWpZemJIrKVrKVIaRwZMl6BLI7pZcB//B+ikZ+cQhFc13qwM8cuOcgRf6abjSNEslA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDEzOjQ5IC0wNzAwLCBncmVlYXJiQGNhbmRlbGF0ZWNoLmNv
bSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBGcm9tOiBCZW4gR3JlZWFyIDxncmVlYXJiQGNhbmRl
bGF0ZWNoLmNvbT4NCj4gDQo+IFRoZSBwYXJzZXIgZXhwZWN0cyB2YWx1ZXMgaW4gaGV4Lg0KPiBT
eW50YXg6IGFpZCBjb2xvciB1bGRsIGVuYWJsZXMNCj4gDQo+IFRoZSBlbmFibGVzIHZhbHVlIGlz
IGEgc2V0IG9mIGZsYWdzIHRvIGVuYWJsZSBhbnkvYWxsIG9mIHRoZQ0KPiBhaWQsIGNvbG9yLCBh
bmQvb3IgdWxkbCAoaW4gdGhhdCBvcmRlcikuDQo+IG9wdGlvbnMuICBGb3IgdWxkbCwgMHgxIG1l
YW5zIHVwbG9hZC4NCj4gRXhhbXBsZSwgY2FwdHVyZSBhaWQgMTE6DQo+IGVjaG8gImIgMCAwIDEi
ID4gL2RlYnVnL2llZWU4MDIxMS9waHkwL210NzYvaGVfc25pZmZlcl9wYXJhbXMNCj4gDQo+IE5v
dGUgdGhhdCB5b3UgbXVzdCBhbHNvIGVuYWJsZSB0aGUgZ3JvdXAtNSBmaWVsZHMgaW4gdGhlIHJ4
LXN0YXR1cw0KPiBoZWFkZXIgZm9yIGhlLXRyaWcgKGFuZCBoZS1tdSkgdG8gc2hvdyB1cCBwcm9w
ZXJseSBpbiBhIHBhY2tldA0KPiBjYXB0dXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVuIEdy
ZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IC0tLQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oDQo+IGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCj4gaW5k
ZXggMDZmOThlNWNkOTVlLi4wODQwMDE2NDdhYWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oDQo+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oDQo+IEBAIC0yNDIsNiAr
MjQyLDEzIEBAIHN0cnVjdCBtdDc5MTVfcGh5IHsNCj4gICAgICAgICBzdHJ1Y3QgaWVlZTgwMjEx
X3NiYW5kX2lmdHlwZV9kYXRhDQo+IGlmdHlwZVtOVU1fTkw4MDIxMV9CQU5EU11bTlVNX05MODAy
MTFfSUZUWVBFU107DQo+IA0KPiAgICAgICAgIHN0cnVjdCBpZWVlODAyMTFfdmlmICptb25pdG9y
X3ZpZjsNCj4gKyAgICAgICB1MTYgbW9uaXRvcl9jdXJfYWlkOyAvKiBhaWQgdG8gYmUgdXNlZCBp
biBtb25pdG9yIG1vZGUgdG8NCj4gY2FwdHVyZSBIRSB0cmlnZ2VyIGZyYW1lcyAqLw0KPiArICAg
ICAgIC8qIGJzcy1jb2xvciB0byBiZSB1c2VkIGluIG1vbml0b3IgbW9kZSB0byBjYXB0dXJlIEhF
IHRyaWdnZXINCj4gZnJhbWVzICovDQo+ICsgICAgICAgdTggbW9uaXRvcl9jdXJfY29sb3I7DQo+
ICsgICAgICAgLyogdXBsb2FkL2Rvd25sb2FkIHRvIGJlIHVzZWQgaW4gbW9uaXRvciBtb2RlIHRv
IGNhcHR1cmUgSEUNCj4gdHJpZ2dlciBmcmFtZXMgKi8NCj4gKyAgICAgICB1OCBtb25pdG9yX2N1
cl91bGRsOw0KPiArICAgICAgIC8qIFNwZWNpZmllcyB3aGljaCBvZiB0aGUgYWJvdmUgYXJlIHVz
ZWQ6ICAweDEgaXMgQUlELCAweDIgaXMNCj4gY29sb3IsIDB4MyBpcyB1bGRsICovDQo+ICsgICAg
ICAgdTggbW9uaXRvcl9jdXJfZW5hYmxlczsNCj4gDQo+IA0KDQpKdXN0IG15IHBlcnNvbmFsIHRh
c3RlIHRvIGdhdGhlciBzaW1pbGFyIHN0dWZmIGludG8gYSBzdHJ1Y3QuIA0KDQogc3RydWN0IHsN
Cgl1MTYgY3VyX2FpZDsNCgl1OCBjdXJfdWxkbDsNCgl1OCBjdXJfY29sb3INCgl1OCBjdXJfZW5h
YmxlZDsNCiAgIH0gbW9uaXRvcjsNCg0KQ291bGQgeW91IHBsZWFzZSBtYWtlIGEgY2hhbmdlIGlm
IHlvdSBwbGFuIHRvIHBvc3QgYSB2Mj8gDQoNClJ5ZGVyDQo=
