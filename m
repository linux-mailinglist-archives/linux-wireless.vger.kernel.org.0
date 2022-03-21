Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111884E1F03
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 03:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbiCUC0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 22:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbiCUC0Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 22:26:16 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C732B24F1C
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647829491; x=1648434291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KhssA82tt+NTBAuVeiSwzKbnKJmvBSbNovxK36DJO9c=;
  b=hb6xPewXLb3g49S2sZ+8+rju9YFDOSHN9TMJ3CQBhG1HtABVtwwg1DXf
   +6uXYDPlcLXSUOiZBYuoZv8VfNgd3feOIz8kBaR+4+Cmo5BmFkF4vhSru
   u/1GhT4+zkjW9D4wkzQz+vZv5WstthxstG3dXTztp0isXKieXSW5iWkmY
   s=;
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WON3t/lkgheOLvu21ooVIr1jPcjxPxGlqfq6mhmh+Zwvpj70gXGTFkMu3+FVG7yYeQIHaf+pFzRiwrX+MHARODAIEvrVL6SknYit2XHRZXlxpiWLmKQrhS6ATWyZMWKWN730bLdwTcCtb48/7dvyPrXeXIukAHbMfLNTJ6Ya5UnHtilt0qkcDv+JhGGPKwuWYYii3YTduPFK86UzuhLkTmcf/c4NG/aDVMwuh2/+ZT/UsAHaAak19FBaNs4rniLuUVIweHfBZeKVTzVmtUEQdWuSAba0e/Fv9dWw9hz/UG+229hj0I2+lNdVrbb7siMuv42GnFGtUWRYid3tBmwD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhssA82tt+NTBAuVeiSwzKbnKJmvBSbNovxK36DJO9c=;
 b=bDYRFuDrBOVAJy/FDGXwjbtnnI0cbx/+Ptb2PZc2RZtm4ykcaTmSok9DGsHy9a3OJZDna11SpXg1HoW8Oyat0NxODS3fSEMCPYrFYb5J1urBlMgO11Zrvc1PUKCHG9AmnOv3L+7jLLxZmGnHlAN2eeeyQY7I3FhBOgv9ANMrQHUfnPZN6kBrK5wPlJ08Sd0FezLlJQ6p6Cpai4QRDwoZW7v49+Sml25KNWQ/fFy1Hle1YsBGUQ8VjDSdpIlIEmYpfc0Re+6mqYNLC+srho+U27tCLcp8fuDc2cLi8JecwrVeTr2bejXlZVmeQKHgAs+sAKcHofEtmW/J2dFYfJOfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BYAPR02MB5430.namprd02.prod.outlook.com (2603:10b6:a03:a4::25)
 by SJ0PR02MB7581.namprd02.prod.outlook.com (2603:10b6:a03:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 02:24:47 +0000
Received: from BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::1d1d:ddaa:4a23:3055]) by BYAPR02MB5430.namprd02.prod.outlook.com
 ([fe80::1d1d:ddaa:4a23:3055%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 02:24:47 +0000
From:   "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] ath11k: Add support for SAR
Thread-Topic: [PATCH] ath11k: Add support for SAR
Thread-Index: AQHYOt/13uQjUd0QyUesekUNDXsOnqzJH+hQ
Date:   Mon, 21 Mar 2022 02:24:47 +0000
Message-ID: <BYAPR02MB543076C526E59CB0E98B3DBCE0169@BYAPR02MB5430.namprd02.prod.outlook.com>
References: <20220317012728.18932-1-quic_bqiang@quicinc.com>
 <164761864196.8951.13534371903381562941.kvalo@kernel.org>
In-Reply-To: <164761864196.8951.13534371903381562941.kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f0f37ac-a654-4943-1bff-08da0ae1f85e
x-ms-traffictypediagnostic: SJ0PR02MB7581:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB7581783D71BFA1E1CFDBDC309C169@SJ0PR02MB7581.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8Far2ciBo9ElJWXF1ei+4xFIq9rP0IUefGn+axGJAVk87C1gRaIWMMljM7ed1Qa7Cq10IkSWLtgdiXDZd2tb8+woa3VZjMpbet7wT/Vlxs6mxTpwOLMFiON2eeFPkbpdZB+mO56fdG5dgFzb4m6WNw/SukuaUou0DJSri2Z0m0QwVEshfcH0UhAk7gxbQwOgmZrcdUwkl0ylpxzc/u1FujOgl9oDTt4PQPmsoivZgLgNhww7EXw2RQTP/orXCGbTUeZmiuv2bkTP8RoK2SCQn0WxAlf/r+zTqJO9/ztAsV4SYqi30urMM02ZR88ksxICFRL+XIodg78v1KupoBL7KKBeVDcp5aIYs1p+eqr6q4M0li3OLjrkMTTFnFf2EJnFmALOsr4arxp3ClS45XbLB9XqXmu/Ll1t51kC2H6OnKNLDimS8FKVIEua4QeqdycTxqSefTOISjGautEVseaLU/zrlHl9htGWbCMQoUfyvUWC/C+pg3GwHn+1fratTPFhPGJeAEgZcv69Di3ciT5Utvtg/i3ViWFMsJqxo04OGpOfl0FNvxpvAcjXr6MB4RR6uqpYKej2QN5hBhhNtObpcnR8gXoYEO+q1JEH1WYu3jsdjNOSH4/11+q9TWFsaSIC48a/x0ioAnz0dbUasEpfEWmPYIpbvkfCl+nBg6aKig9s98FisFAl/lgyT1EcBzP5xqmeP6/3YpReWHmoUJU0F1/ibWhli/T5kDjSFcL522sjaVEmwMZzrtXFwz4Pl4DEeZ95nMTk4UE/G6DW7/AKoWDK8zroeJVfPoZfhACR+6mD5dQyCuPI1u9b+oDV6yq3+LxqAnvqSDGNp4N2xhrjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5430.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(5660300002)(38070700005)(55016003)(122000001)(86362001)(7696005)(6506007)(83380400001)(508600001)(53546011)(186003)(966005)(33656002)(26005)(9686003)(64756008)(66476007)(8676002)(4326008)(66446008)(66556008)(66946007)(76116006)(8936002)(110136005)(71200400001)(54906003)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bC9TdE1XZGl2ak5TSWJNajRaNnFIOGlwNTF0bFNIekM4U0drRnF0NkRHNVBl?=
 =?utf-8?B?NGhQbGJMNTBRRlpKSjZsNlBBWXV1bllLVUxKTTN5MW9WNEROeXhCaXBZWWdE?=
 =?utf-8?B?Q3JZZDQrOFA3TE1uRUdKTUppSnJ4T3hBTG1QSkRlZ3Z6cDA2TmlIMlUwRkt2?=
 =?utf-8?B?K3FPUHBFZFdCWVJiVHRFUy9SYTlzNkNWWWFaS2JLbXltb2g3NDFrSDdxNlBn?=
 =?utf-8?B?cnBmS0pteXlJdUZZSVVKa09IdkRjNm5nRXVpYjhZeHo1SDVqVldiczUvc1dk?=
 =?utf-8?B?MmVRaWlXK0E3NVptdlBzQUovREVHcFdVWHpod0hlZGloMW5vSTRuSWEwSFBD?=
 =?utf-8?B?ZjUwR1QrdjNLOTFWaVdyZVZrV2JxbHhRODBkdGloUTBQbWg1dVljcEVWZlhP?=
 =?utf-8?B?Rm56RHdIYmg0WHUzUVZXVVZtblNKMURzcEZ1Vi8vSGNybUdoaUxGYXlSazlt?=
 =?utf-8?B?V2twd0pKYXk3V0lRQXdTUEg1OW5YbkQ5ck81bEhQQ0RsdngrUUNxdTZ2TnV6?=
 =?utf-8?B?ekg1WSt3N0hlWUFLN1BjdlpaUjJ6OFE0Vmx6V0tidWtZdmNlUGNaOHZSbGFm?=
 =?utf-8?B?c0NGN0tzZlBQVmhtdXY5Y29XMXpjTWxRTzVJWkkxUDFQaDladUdCZkhseEtq?=
 =?utf-8?B?NXo0YW5VZ01tZFpnUHYzZHNibTVxREVZMk4xZW1HemdpZ1hCaTlBRmw1Y3Bs?=
 =?utf-8?B?dkhaUFlwRExjVXdubllwems0QysxbWU2c2k3SkViRW5FQVcvK2p4K1NkMGNR?=
 =?utf-8?B?Uy9uYUZSaXF3MGoybnY0OUh3NEdCSWdmV2R2aVFBQUtBaE5OTEdaaWhLb1Bh?=
 =?utf-8?B?NDk3K09MdXNCTWMwMHNNWmpiT0JPM0pKc2xFdE0vZEpPc1B3NHhDSXNjR2xt?=
 =?utf-8?B?eTYyWHQ2WGhXSjhFZTcxejRWSzk4YVZvUU1GR3IzVmVHRS9WYmxJUlpja0pI?=
 =?utf-8?B?WkRNMElQSnhRWkRlMGd2eEZoSllNUC9PRWlyek1JaGVnRlpnUmZQTFFOWW1M?=
 =?utf-8?B?a3NuWVZ4aTBBWllsMWdKQ2lPbUdvbm50WHRPMFlRbHR3NXJlZFh1YWZaWFY0?=
 =?utf-8?B?TmpQUGI3amJGZ29ESTdVaXROTXgrYm81Tjl4RDRFSmJCQ29GRGQyTTRlaU5Z?=
 =?utf-8?B?N0szdmVMMktCVXZLa0dsZ01BcDlzNWNtWUVzMFJ5UmN6cG5rK0g2L1Q4c2lm?=
 =?utf-8?B?c1p1YjNOMDRCTVpIcnVvY3hqcmF4VHFUVFBUZ2VuS2ZDQmR0S2xtbWpIeldY?=
 =?utf-8?B?ZG1SR2pIVTljM3dBTWdNM3hSWGRXL3JiaHFjTHlOcXJ0TFN4aG4zU0FpdXoz?=
 =?utf-8?B?dzdiaFFsRG9sR2IzbENPcWxoUk1XdGdBaVpDeFlDTVh0K1BsQW12cnJoc0h2?=
 =?utf-8?B?a2RqS3FaZ005d1p3Vk1jTyt2cEcyb1V1UEFDTjREOW5NQUZYSjE0L0VvSnVQ?=
 =?utf-8?B?U0RJYTBJc0Zrd01GanpMR2pyaUVRb0xURnYvMWlhcjhabEt1dW1ZYjJjQnp0?=
 =?utf-8?B?bXBIdHpjWDRRS3VqaG16MUt3a2dFaFJBMDBZenNqNEZMbW5QKzNjdXNMUTFI?=
 =?utf-8?B?Z2ZLVHNFbVRnYUp3ZUd2a2Q1SER0cUZobGJDbkd4ZTlOVDRzVFM5emZYUlh6?=
 =?utf-8?B?bkFEUm1lM3M5bEUwcjNJU0dsNWJYZk9VYy9xR3FnOXVuTmtaUXZNd0UyQ01R?=
 =?utf-8?B?bWU4K0VDRm1pdjR5cXBydkhuWXp4dVNLc1NXTjdjQTVUOCtBWlh6MjJtTzZN?=
 =?utf-8?B?VkRpeUhyTDBISHZuS1ZOWVNONXhiRjBGY1A4Vm5zeFFJb2ZmQnpCZDd2WS9h?=
 =?utf-8?B?a1pIbi9objZ2UjZBWDJUTkNJSUNTS1drTHZqbzJXN2pPdkhFWmF1YTRmMzUw?=
 =?utf-8?B?QWZNeXhBMURkcnFXOVFQR2RMZFBFYUFxZE41YmdNM2Fid0ZSOUxxMFc0U2FS?=
 =?utf-8?Q?95CTghk6m3MHLdNAf/EbNSKSDCNSeZLn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5430.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0f37ac-a654-4943-1bff-08da0ae1f85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 02:24:47.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Emd9G38aP3ywHMXCuhEVU0oFyvHz8knanTUw+pzb78tf1nsGS/9Z2Pf1EyhJ4puSiWNQ1wYi0akiTcB1FOdIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7581
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbGxlIFZhbG8gPGt2YWxv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTgsIDIwMjIgMTE6NTEgUE0NCj4g
VG86IEJhb2NoZW4gUWlhbmcgKFFVSUMpIDxxdWljX2JxaWFuZ0BxdWljaW5jLmNvbT4NCj4gQ2M6
IGF0aDExa0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXRoMTFrOiBBZGQgc3VwcG9ydCBmb3IgU0FSDQo+
IA0KPiBCYW9jaGVuIFFpYW5nIDxxdWljX2JxaWFuZ0BxdWljaW5jLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IGF0aDExayBhc3NpZ25zIGF0aDExa19tYWNfb3Bfc2V0X2Jpb3Nfc2FyX3NwZWNzIHRvIGF0
aDExa19vcHMsIGFuZA0KPiA+IHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIHdoZW4gdXNlciBzcGFj
ZSBhcHBsaWNhdGlvbiBjYWxscw0KPiA+IE5MODAyMTFfQ01EX1NFVF9TQVJfU1BFQ1MuIGF0aDEx
ayBhbHNvIHJlZ2lzdGVycyBTQVIgdHlwZSBhbmQNCj4gPiBmcmVxdWVuY3kgcmFuZ2VzIHRvIHdp
cGh5IHNvIHVzZXIgc3BhY2UgY2FuIHF1ZXJ5IFNBUiBjYXBhYmlsaXRpZXMuDQo+ID4NCj4gPiBU
aGlzIGZlYXR1cmUgaXMgY3VycmVudGx5IGVuYWJsZWQgZm9yIFdDTjY4NTUuDQo+ID4NCj4gPiBU
ZXN0ZWQtb246IFdDTjY4NTUgaHcyLjAgUENJDQo+ID4gV0xBTi5IU1AuMS4xLTAyNDMxLVFDQUhT
UFNXUExfVjFfVjJfU0lMSUNPTlpfTElURS0xDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYW9j
aGVuIFFpYW5nIDxxdWljX2JxaWFuZ0BxdWljaW5jLmNvbT4NCj4gDQo+IFdoYXQgZGlkIHlvdSB1
c2UgYXMgdGhlIGJhc2VsaW5lPyBJIGNvdWxkIG5vdCBhYmxlIHRvIGZpbmQgYW4gYXRoLSB0YWcg
dG8gd2hpY2gNCj4gdGhpcyBwYXRjaCB3b3VsZCBhcHBseS4gSSBzdHJvbmdseSByZWNvbW1lbmQg
dXNpbmcgLS1iYXNlLCB0aGF0IHdheSBJIGRvbid0DQo+IG5lZWQgdG8gd2FzdGUgdGltZSB0cnlp
bmcgdG8gZ3Vlc3Mgd2hhdCB3YXMgdGhlIGJhc2VsaW5lLg0KPiANCj4gUGF0Y2ggc2V0IHRvIENo
YW5nZXMgUmVxdWVzdGVkLg0KPiANCg0KSGkgS2FsbGUsIEkgaGF2ZSBhZGRlZCB0aGUgYmFzZSBm
bGFnIGluIHYyLg0KQW5kIHBsZWFzZSBub3RlIHRoaXMgcGF0Y2ggZGVwZW5kcyBvbiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyMTEy
MjQwODUyMzYuOTA2NC0yLXF1aWNfd2dvbmdAcXVpY2luYy5jb20vIHdoaWNoIGlzIG5vdyBpbiBw
dWJsaWMgcmV2aWV3Lg0KDQo+IC0tDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC0NCj4gd2lyZWxlc3MvcGF0Y2gvMjAyMjAzMTcwMTI3MjguMTg5MzItMS1xdWlj
X2JxaWFuZ0BxdWljaW5jLmNvbS8NCj4gDQo+IGh0dHBzOi8vd2lyZWxlc3Mud2lraS5rZXJuZWwu
b3JnL2VuL2RldmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJtaXR0aW5ncGF0Y2gNCj4gZXMNCg0K
