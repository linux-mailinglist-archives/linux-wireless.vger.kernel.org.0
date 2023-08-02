Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217B176C3B1
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 05:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjHBDth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 23:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjHBDtf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 23:49:35 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9161BF
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 20:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALoAhkh2ljiWxfl1rQNeDbJDv5Bg2KBQkdELOI1L/Qc7dqNGXVhZ1O4XO7LQ5O/sej2msrOcmDhlygrgX6g8OVXS33idAZGxFM/J9b9eDR885Vhujqtsr0/oQpztNCEdYWHzUX++ugFusa4G0bQ9Pf8pl22tud8phExjnkJFidGM7YzvSkkSnrISL+Rtam8sJqDTdgL7CqpKPllx9VL6G4G75MsFkq+c/F1+iH230gb5YNVsLXMIMEd06Mcs7oIWHIXOGp1mIw3j2QfwxHZ/4eD9/ZcJYnTyds1f74hx1VBhzGmrq4BUvLtHxHg27npjTNsLpJQqjCpc8BbiEgDhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxotKvOpbnmBp4FjfZFUg4nBIIWCkUo1iJFMcAQgVtU=;
 b=XDC82EkDXZB83XW528VtRhwsjj0pDdw3siNn7gNpj1MUB6xrPpGBKx10vPp7dn7WCANQkEXN/+/90rWZzLsZjlAfKsNZweGi5XzKOIVXq9COABQ14uxIv7wAUWaZT+ztbcHKnSlrWiUAdoVCVZ5k9pbPJmNRfrON+uAdM3Hhf8KdTdde4aztD0hExDygzatAMOsApHrqHWrAIy05TzcArFCsOT8DcmTMBNYBNhYvg/kGc5to8Lyr367QGHtHnaXFVLxCUTVxRrF9FuPt9R32UnY987BhZeQh/B9BRE4phElpf0rnc+xOy8t3TvoKGq3fiP8mTAViimfFkwbOmPfrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxotKvOpbnmBp4FjfZFUg4nBIIWCkUo1iJFMcAQgVtU=;
 b=C0qLbWIA2k/ZB9Q5XJ9gxlMDNEGSd5YDBAz2IwEmwTo6lr1nm/i7Aa45Sp0ApQxdrUXxfNGcpg72Iq2nnrOWIF+uKQDzDUybZXNdfUbmEAqglUhOlOCgGw72241Teqrz7qzw6cKxF7Xdvgq0oNhJuR2mOXtQxIpHywuatiZ92wY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBAPR04MB7317.eurprd04.prod.outlook.com (2603:10a6:10:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 03:49:31 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 03:49:31 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host mlme.
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: added code to support host
 mlme.
Thread-Index: AdnBG0VbUku3Gob0RoOlmlRWbISqeAAVIG+AALL1uhAAGOT5AAAVNv8g
Date:   Wed, 2 Aug 2023 03:49:31 +0000
Message-ID: <PA4PR04MB96389A15C756B26CE1E31588D10BA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638100B3F21D083F386C6D9D106A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMx46aLztpKHqtS_Ab_yV_0GvRdWinf4C9o=9zqtTGehQ@mail.gmail.com>
 <PA4PR04MB9638F315ECAE762875B5FEE3D10AA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZMlDcG5wJPMNZ8Fo@google.com>
In-Reply-To: <ZMlDcG5wJPMNZ8Fo@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBAPR04MB7317:EE_
x-ms-office365-filtering-correlation-id: 599bbf3e-512a-4755-6090-08db930b7abf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMU06ADNls6F66MsIsddGFABse/Zzer7mYo+kSAaIi0mwlUMgMNcQDD/qfc09jvIoiQsLiiWHnn8Ad4XfgB8VDcMNVSY9X0T2+k7UxVuGT36N1Iz0AxOEk5MVwz4+JOCLCERRMZCF+KENDKM0Znqa47OxrgrQn8GJIxm13PzB1Y7g9pbpZM8bQCokM6FN6TiOZTNDz4p0jJB0BdV/uwR0y3RdS2t2XQxME6aKQ8YdB5vLgqorcnVEJmvGnpPI39ZXwk82rC4PW8kStVETOCobOnYx9zDAQmgD+wkZqX7Ydxmvffh/s3sQXuoOxGPA+us1bEZ8Hx54qO262djRFPteNYth5e3SlVIxV3Vwy2jeFN+f5Om3oEStY3oxEfsnSOLEBnYqbSgQ77T0fZDGCJDSdd+wamPfQzv5T3DD59gaSD4YgX8fAKqGGlJ5fKSamN3+5bsP8G5RW5uN1X/58sIn1LAJgfAPw/v/v5zrC2An118wd3z+e+DuaposXkK/FbJ1ZncJWCXNhOOJmWtQb3tngCkgD7PSfB8+MguCaj0xkcju7sJ9Bd+N/gx/FQ833IWlvP8hTVXICk0Ff8+4liwFxAIY8tIsCrq5GhQ41DBHJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(5660300002)(52536014)(55016003)(38070700005)(33656002)(38100700002)(122000001)(2906002)(26005)(45080400002)(83380400001)(478600001)(8676002)(186003)(6506007)(8936002)(53546011)(71200400001)(966005)(9686003)(7696005)(41300700001)(86362001)(54906003)(4326008)(6916009)(66946007)(66556008)(66476007)(76116006)(66446008)(316002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFFjeFpDZmZqejNYNC9IbWRxR2hGR3djWlRvWWtZQ1gwQWtoQlFPbi9DMjUv?=
 =?utf-8?B?SnkrRGFBTVpwS1pBVFpmVDV2OTFDaW9MNWtGVy9CSTdMM3Z4Vm56MlE1QWQ1?=
 =?utf-8?B?OEYzVzhpNTFnTEZQRy9jcVVjSzNYNWxBd2lpWlpkNkJqM0ZxdVVCQTJWMXJQ?=
 =?utf-8?B?RUh2RC8xS1M1SUI5SVpCOGhlMVRtZUFEcjFKTzRJQ0ZNZUo3NFF6cHQzRk5z?=
 =?utf-8?B?YW9UZ2FFZkY0OXU4VVFiamdITnBCekZ3WDZqTDFPMHRKeUMySzB5b0FCNlBj?=
 =?utf-8?B?Zngwc2xvenhVVmQyYlRnZlJCdW90aE1YUkN3VDhqT2pjVEVvZFlzaENRZmlO?=
 =?utf-8?B?Z0pDRWlIZ2NBeU1EemxoRnc1WjhtYlhLNW01NFIwV1BYalF3aERuM1RvN1RH?=
 =?utf-8?B?V1ZvVUdjY081d3VUME9BaGRxQWIwdkFKUTdHVjJIMXZYSUhIUmRtWG5DZEFS?=
 =?utf-8?B?UjFMOHdJdkh2WUZyQTdERkIxT1BlTERUVEJpMUxRVVcxVDBLM05reVl2b3Fn?=
 =?utf-8?B?Zy9ETS9DNHVXU1BJY3doaVcyYm8vSittR0FXcU5zeXRqTFFScmRKRnIrU21B?=
 =?utf-8?B?ZUdWVSs3OTFYeTlva1ZXVkw3cW5yUFJDZTd6ZDFjbzVRdTJCYWZDa2ZnYjZ6?=
 =?utf-8?B?R0JISXR5QndIUG9uOFpSQjgyY2FDakxsODNmNFhOLytEZkdqRXJwYVRSbTVz?=
 =?utf-8?B?M2xtaDk4RUs2UnpNcHJtYUMzdUp3ZkJRRmozQVJNTVpoZkpsRThHRVVSQ2dl?=
 =?utf-8?B?VkpSbisrV0RMbWFvUlVDZmV0ODEvWlZLNEpQb1k3TmtpejNJampmdTByL2du?=
 =?utf-8?B?dTJ0cjdpRlluSm5BN241TzZVMGhhQWt4MjQ2My9TL3BYQjlqWGpBZXU3N2VU?=
 =?utf-8?B?ZDlScERXZGF1aUpkVU1sdGRlN3J6SmlwK24yYi9wM1BlOTNXTUNnam45NFpF?=
 =?utf-8?B?SkFBVENzcHJHc2hmYXhyNlpVNmswS3orenlUcTV1RmlvbkRtSVJsdTg5WWR1?=
 =?utf-8?B?T2UrVGFRV1JzaW5GU2gwZDZJbGJvWGI4WkxQK1hjck5nTFZCTWVZREVBWUdK?=
 =?utf-8?B?SVZ1MnlEaS9uRnprYWRFeXdJSmVkVVYwd25LVjlOcDhpVXNHUkdPM1pGbi81?=
 =?utf-8?B?eEhrelVsRHYxZ0pzVUQ4bDIrZWlBWC9KR1p1WUNBVUlxM0FGcGVZZWRTSFZ5?=
 =?utf-8?B?SGVXS2ZEM0FNdEh6SCtQNnlsa1dnSlIzcGtoSnN4KzlKMkprL3REbXljWks0?=
 =?utf-8?B?Lzh3bHJwNEowTFp1THkySktuMlVoMWxxRGRPSU9YbkRsKzUwU3NJMnN4MENo?=
 =?utf-8?B?dGFjNG84S1dGME40a1RBN1RjRm0zTjBkRGVqUzBSNDZ6TGQvbkVaYjRjZEdI?=
 =?utf-8?B?NnVRaTZwRGNLZCtVRmRHN2R1ZS90RUNiUnFIU3V3L0FTckhrSjVRUWgycmNj?=
 =?utf-8?B?Umk5cWYzdHpvNkQrdVRRSXNLa0t6YkY2cUR0bzg0anhaNGV3eFZSbllSb09L?=
 =?utf-8?B?QUFobzlVU1BDK0luZmxQNUh6Q2xTZlZ3TkhjMmJveC9rSXN2ZHc0RXBqVVBx?=
 =?utf-8?B?OUc5Y01XSXpRYmFkMTFsMzd2cnRLUzB2OW1POVJPaFlEM3QreS9XZ0JaRUxO?=
 =?utf-8?B?eHFjeElDS3pLQ1NIUWJMSUFlUm5Fb3lZdEQvcjdkNFlEK1czdXhHcitORWcx?=
 =?utf-8?B?L01SRzA1U0RxclR2allkeStqeWdhQW5wZ1pBWk4wdGdVYnVGZkIzUkRrTWk5?=
 =?utf-8?B?UGdNR1dPbnFIK2x6bHJKN25JSlB3bzBMMklaMzRHMUxLR01Ud1pHYWpaQ2xQ?=
 =?utf-8?B?aVZZZ2RwMVFGT1RjdGMvZHBobEpTSkc1dWQ2SEFhODlhZHk0UnZ3b2JIcHlY?=
 =?utf-8?B?YzJKVTJFU1R6LzY4VUNUc0hNaHUyeThFeHJkZFNjWmhLMVR0dTRmNG1GN2tu?=
 =?utf-8?B?NG9OdDhCMS95bUdyVW1aTmh5RHFycmlyM2pGNnJ2R3MrR3JlaFpiSEEwMlZQ?=
 =?utf-8?B?VFZQNm5TekhoMGNzUU5FNWlCOHRKUndnMzlWRVczcEpIeVNvMUQ4VUFEaUx2?=
 =?utf-8?B?NG9RYWVKdUFJcDJXaURzQ2lvMUNLVmtBd0RBQlVSZUVqYzFpTU8xa0N5QnVW?=
 =?utf-8?Q?xKvMZ0WHKvBRksRzhzf4wOevm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599bbf3e-512a-4755-6090-08db930b7abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 03:49:31.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 023FwIbuJJkhMRv9eXuwhRJTd86J7VXSH3NcYy0A9ol+poVTJGqNS10bIEa9wgnsHA9RS238/+TYLS4dTP+mdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IEZyb206IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnPg0KPiBTZW50
OiBXZWRuZXNkYXksIEF1Z3VzdCAyLCAyMDIzIDE6NDAgQU0NCj4gVG86IERhdmlkIExpbiA8eXUt
aGFvLmxpbkBueHAuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBT
aGFydmFyaSBIYXJpc2FuZ2FtDQo+IDxzaGFydmFyaS5oYXJpc2FuZ2FtQG54cC5jb20+OyBQZXRl
IEhzaWVoIDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VYVF0g
UmU6IFtQQVRDSF0gd2lmaTogbXdpZmlleDogYWRkZWQgY29kZSB0byBzdXBwb3J0IGhvc3QgbWxt
ZS4NCj4NCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2Ug
Y2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVt
YWlsJyBidXR0b24NCj4NCj4NCj4gT24gVHVlLCBBdWcgMDEsIDIwMjMgYXQgMDU6NTA6MDNBTSAr
MDAwMCwgRGF2aWQgTGluIHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJy
aWFubm9ycmlzQGNocm9taXVtLm9yZz4gV2FpdCwgeW91ciBjb21wYW55DQo+ID4gPiBjYW4ndCBh
ZmZvcmQgdG8gaGF2ZSBhbnlvbmUgcmVzcG9uZCB0byBtYWludGFpbmVyIG1haWwgZm9yIHllYXJz
DQo+ID4gPiBbMV0sIGJ1dCB5b3UgY2FuIGFmZm9yZCB0byBhZGQgbmV3IGZlYXR1cmVzPyBDcmF6
eS4NCj4gPiA+DQo+ID4NCj4gPiBUaGlzIGZlYXR1cmUgaXMgbmVlZGVkIGZvciBXUEEzLg0KPg0K
PiBZZWFoLCBJIHJlYWQgdGhlIGRlc2NyaXB0aW9uLg0KPg0KPiA+ID4gT24gVGh1LCBKdWwgMjcs
IDIwMjMgYXQgMTE6MTnigK9QTSBEYXZpZCBMaW4gPHl1LWhhby5saW5AbnhwLmNvbT4gd3JvdGU6
DQo+ID4gPiA+DQo+ID4gPiA+IDEuIEZvciBzdGF0aW9uIG1vZGUgZmlyc3QuDQo+ID4gPiA+IDIu
IFRoaXMgZmVhdHVyZSBpcyBhIG11c3QgZm9yIFdQQTMuDQo+ID4gPiA+IDMuIFRoZSBjb2RlIGlz
IHRlc3RlZCB3aXRoIElXNDE2LiBUaGVyZSBpcyBubyBndWFyYW50ZWUgZm9yIG90aGVyIGNoaXBz
Lg0KPiA+ID4NCj4gPiA+IF5eIFRoYXQncyBub3QgYSBnb29kIHNpZ24uDQo+ID4gPg0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMaW4gPHl1LWhhby5saW5AbnhwLmNvbT4NCj4gPiA+DQo+
ID4gPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvdXRpbC5jICAgfCAg
NzQgKysrKw0KPiA+ID4gPiAgMTQgZmlsZXMgY2hhbmdlZCwgNTU4IGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWFydmVsbC9td2lmaWV4L21haW4uYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tYXJ2ZWxsL213aWZpZXgvbWFpbi5jDQo+ID4gPiA+IEBAIC0yOCw2ICsyOCwxMCBAQCBtb2R1
bGVfcGFyYW0oZHJpdmVyX21vZGUsIHVzaG9ydCwgMCk7DQo+ID4gPiA+IE1PRFVMRV9QQVJNX0RF
U0MoZHJpdmVyX21vZGUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgInN0YXRpb249MHgxKGRl
ZmF1bHQpLCBhcC1zdGE9MHgzLA0KPiA+ID4gPiBzdGF0aW9uLXAycD0weDUsIGFwLXN0YS1wMnA9
MHg3Iik7DQo+ID4gPiA+DQo+ID4gPiA+ICtib29sIGhvc3RfbWxtZTsNCj4gPiA+ID4gK21vZHVs
ZV9wYXJhbShob3N0X21sbWUsIGJvb2wsIDApOw0KPiBNT0RVTEVfUEFSTV9ERVNDKGhvc3RfbWxt
ZSwNCj4gPiA+ID4gKyJIb3N0IE1MTUUgc3VwcG9ydCBlbmFibGU6MSwNCj4gPiA+IGRpc2FibGU6
MCIpOw0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gSSBoZWFyIEthbGxlIGRvZXNuJ3QgbGlrZSBt
b2R1bGUgcGFyYW1ldGVycyBsaWtlIHRoaXMuIFRoZXkncmUgYSBjb3ANCj4gPiA+IG91dCBvbiBw
cm9wZXJseSBzdXBwb3J0aW5nIGZlYXR1cmVzIChhbHNvLCBzZWUgeW91ciBvd24gY29tbWl0DQo+
ID4gPiBtZXNzYWdlKS4gSSdkIGhhdmUgdG8gZGlnIHRocm91Z2ggdGhlIGFyY2hpdmVzIHRvIGZp
bmQgdGhlIGxhdGVzdCBhZHZpY2UgYW5kDQo+IHJ1bGVzIG9uIHRoaXMuDQo+ID4gPg0KPiA+ID4g
T3ZlcmFsbCwgSSdtIG5vdCBlbnRodXNpYXN0aWMgYWJvdXQgdGhpcyBjaGFuZ2UuDQo+ID4NCj4g
PiBUaGUgcGFyYW1ldGVyICdob3N0X21sbWUnIGlzIGFkZGVkIHRvIHByb3RlY3Qgb3JpZ2luYWwg
Y29kZS4gSXQgd2lsbCBiZQ0KPiBkaXNhYmxlZCBhcyBkZWZhdWx0Lg0KPg0KPiBSaWdodCwgSSBy
ZWFkIHRoZSBjb2RlIHRvby4NCj4NCj4gVGhlIHBvaW50IGlzLCBtb2R1bGUgcGFyYW1ldGVycyAo
b3IgZGVidWdmcyBmaWxlcykgZm9yIGNvbnRyb2xsaW5nIGNvcmUgcHJvdG9jb2wNCj4gZnVuY3Rp
b25hbGl0eSBhcmUgaGlnaGx5IGRpc2NvdXJhZ2VkIGhlcmUuIFNlZSB0aGUgZm9sbG93aW5nLCBm
b3Igc29tZQ0KPiBhZGRpdGlvbmFsIG5vdGVzIGFib3V0IHRoaXM6DQo+DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuLw0KPiBlbC5vcmclMkZsaW51eC13aXJlbGVzcyUyRjg3ZDA5dTd0eXIuZnNmJTQwY29k
ZWF1cm9yYS5vcmclMkYmZGF0YT0wNSU3Qw0KPiAwMSU3Q3l1LWhhby5saW4lNDBueHAuY29tJTdD
ZDc3ZjM4MWI3MDQ1NGQ3YjY5MDIwOGRiOTJiNjU2ZWElN0M2DQo+IDg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODI2NTA4NDA3MDE2MzE1NiU3Qw0KPiBVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRp
SQ0KPiA2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2RhdGE9MHlGYmE1
R2c5dGlnNkhxDQo+IHc2b2NQc293SVRpdk9hUGhTTE5wVnRqV1ZLcDAlM0QmcmVzZXJ2ZWQ9MA0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBydHc4ODogZGlzYWJsZSBUWC1BTVNEVSBvbiAyLjRHIGJh
bmQNCj4NCj4gSSByZWFsbHkgbmVlZCB0byB3b3JrIG9uIHdyaXRpbmcgdGhpcyB1cCBmb3IgdGhl
IHdpa2kuLi4NCj4NCj4gT24gYSBjb25zdHJ1Y3RpdmUgbm90ZTogd2h5IGRvIHlvdSB3YW50IHRo
ZSBtb2R1bGUgcGFyYW1ldGVyIGF0IGFsbD8NCj4gQmVjYXVzZSB5b3UgZG9uJ3QgdHJ1c3QgdGhl
IGNvZGUgYXQgYWxsPyBCZWNhdXNlIHlvdSBkb24ndCB0cnVzdCBpdCBmb3IgdGhlIGNoaXBzDQo+
IHlvdSBoYXZlbid0IHRlc3RlZD8gQmVjYXVzZSB5b3UgeW91IGRvbid0IHRydXN0IGl0IGZvciB0
aGUgZmlybXdhcmUgdmVyc2lvbihzKQ0KPiB5b3UgaGF2ZW4ndCB0ZXN0ZWQ/DQo+DQo+IElmIHlv
dSBkb24ndCB0cnVzdCB0aGUgY29kZSBhdCBhbGwsIGRvbid0IGV4Y2VwdCB1cyB0byBtZXJnZSB5
b3VyIHBhdGNoLg0KPg0KPiBJZiB5b3UgZG9uJ3QgdHJ1c3QgaXQgZm9yIGNlcnRhaW4gY2hpcHMg
b3IgZmlybXdhcmUgdmVyc2lvbnMsIHRoZW4gZGV0ZWN0IHRob3NlIGF0DQo+IHJ1bnRpbWUgdG8g
cHJvcGVybHkgZGlzYWJsZSB0aGUgZmVhdHVyZS4gKEFuZCwgSSBoaWdobHkgc3VzcGVjdCB0aGF0
IG5vdCBhbGwNCj4gZmlybXdhcmUgdmVyc2lvbnMgd2lsbCBzdXBwb3J0IHRoaXMuIERvbid0IG1h
a2UgdGhlIHVzZXIgZ3Vlc3MuKQ0KPg0KPiBCYXNpY2FsbHksIGZvciB0aGUgY2FzZXMgeW91IGNh
cmUgYWJvdXQgZW5hYmxpbmcgYSBuZXcgZmVhdHVyZSBvbiBmb3INCj4gcHJvZHVjdGlvbiB1c2Us
IGl0IHNob3VsZG4ndCByZXF1aXJlIHBsYXlpbmcgd2l0aCBtb2R1bGUgcGFyYW1ldGVycy4NCj4N
Cj4gU2lkZSBub3RlOiBJIHRoaW5rIHlvdSBwcm9iYWJseSBzaG91bGRuJ3QgYmUgYWR2ZXJ0aXNp
bmcgdGhpbmdzIGxpa2UNCj4gTkw4MDIxMV9GRUFUVVJFX1NBRSB3aXRoIHRoaXMgZmVhdHVyZSBk
aXNhYmxlZDsgdGhhdCdsbCBsaWtlbHkgY29uZnVzZSB1c2VyDQo+IHNwYWNlIGludG8gdGhpbmtp
bmcgaXQgY2FuIHRyeSBXUEEzLCB3aGVuIGl0J2xsIGp1c3QgZmFpbCBhcyBzb29uIGFzIHRoZXkg
dHJ5IGl0Lg0KDQpJIHdpbGwgcmVtb3ZlIG1vZHVsZSBwYXJhbWV0ZXIgImhvc3RfbWxtZSIgaW4g
UEFUQ0ggVjIuIEkgd2lsbCBhbHNvIGZpeCBOTDgwMjExX0ZFQVRVUkVfU0FFIGFkdmVydGlzZW1l
bnQgaXNzdWUuIFRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9ucy4NCj4NCj4gQnJpYW4NCg==
