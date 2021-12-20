Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291DE47A539
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 07:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhLTG7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 01:59:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:65257 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhLTG7T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 01:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639983558; x=1671519558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2IKEmXuRRT8GlWqsSNW8oibEMvGYus+jcdbL2RxX4Ng=;
  b=Ea6/OTGEp49g1hyVg/XBMTcc10/lSD+UD2quLaM+ac+iDBz8Ow03a3oI
   QnwFs5Kjh3LWVuSLm3fz8gPmH77pxI5gSbvd/mNfX3xaWC9pwsxYBMLwB
   g1e21cmWpSUGxG2D7jTtv0e/dBzaQENpMbZeNi+UJ1KgfJJxVMX7hy2v1
   N/FRQ1QXprvGU9FSS4DJFTBh5oxx5Ns1Mgojpw3cUu/+263eqZoQ4idaN
   KSJNeRn1L1MHro7D0rzpz1Wj8WhuG/ZD8kCiSOdrSYsC5KJ2dRdNOCd1j
   1/9LQm6w82HJAsDFOgYYSm/7l5IOP9a9xwo9XjjZp30TG4FKBTVqjwfw+
   Q==;
IronPort-SDR: OAaZ+3jdmo6S5a0W6dBZGmNKe4jVpbuEnB5O2CympNS1mpb3ek1S1aGey1aKZyZMyHqCCNzUns
 TjCAGLzBOeZNlRaCpLHVHS+bUdGL6puG5xxlp+SRlJyHBplxL+QxHxaJ6W2Bnd8zbwv7YRfv97
 I2w5ctkfra3ClWcRO93pELar+L7ktHXfI6ka59BZcSOZkSYNS6z83i0iiwYSYMoacaX4Tqo5zI
 D72XUeiDCe5loBmnUOxVhxaNq4+zzeH4wctvBNbf0X2GU0hsiNN6EnLAt5asj4eWqdwIQXm3D8
 SeZr+RVFK5QC8ed+aHeNSp4e
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="140310741"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Dec 2021 23:59:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 19 Dec 2021 23:59:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 19 Dec 2021 23:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfbmOjql47MLLoCLtMQAAbwAVfBjiRRCZn+oiHEDK0OXA6qRg6BreL2O+urNWpGXsWSP1Gm3MmmNHN1PefbnelGkNQn4WBgyUpd5toVwO/t71FzNHo3xIb1OwbUdoyjXmJBV3kYe25Ryz9ku9NrXHJibYQFMQfZdfQjvGsO0abySIFc771XEpjkYHUwqpCayqTL7bJKrzMuLH3cyf726/J1onpEK/xuufcr5xgpITvQ39dorsxASJGrwVTkixA3pfeyKcx5wW1PQ5srryIZyOgJtsN79H7K7z2fgJGOCqbIB7os3aw/KCNFgjJ8vxBlvYnOjEMDjmd91kJcpo+th0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IKEmXuRRT8GlWqsSNW8oibEMvGYus+jcdbL2RxX4Ng=;
 b=R2BH/EbgAK/rRLfE7I/bxh9oeXIgwnrtccmV/hkT2rLZ8U3S+hi6RHTt8pkJCH40UcErjUXzoZvSO0cTpTGw6IoFnH3NtZJ4/PIF/dJv6xB6hWyJ7J7hxtOWCe2JMtadB+mWndVXRIIdUM5PQ9GjnDc1Z62B/whUgbZo/k7tTqcBYP9SLoIYJXQpM9B6d02o5EiqTq0x0arHV8dY0w+QY7lnxdJIy6qgD2fH6egLtjDRybrmqw8Fq+tTjue6MVmix8CKyjjk0aOqhckDfC+qQX2AtunYtvnwTTVfpbR4ChOkdYNMd44D6iP4+P902+HB0zJpOXA6CSqj+SCEbo7PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IKEmXuRRT8GlWqsSNW8oibEMvGYus+jcdbL2RxX4Ng=;
 b=rBNVdIzwqUZ4cB6sr1XKBUlMX5SwOoK/vcLkuBOk2xlW/e8a7ADaHt00kOgeXsKaIrS6SdnbWkUjrbUdkIUP+aQZt3SfI8Wz1IVbHJ53bdvu6s9MdQdfu78rH6uEFMhhb35QyxOUg/ce+VXnMiaJZ/lSj5kv87ddRpGwTWediL4=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Mon, 20 Dec
 2021 06:59:11 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::1f6:467f:69d9:e0b3]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::1f6:467f:69d9:e0b3%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 06:59:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <dan.carpenter@oracle.com>, <Ajay.Kathat@microchip.com>
CC:     <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] wilc1000: fix double free error in probe()
Thread-Topic: [PATCH] wilc1000: fix double free error in probe()
Thread-Index: AQHX9W8XBnhcZBa400uofphoGXgXqw==
Date:   Mon, 20 Dec 2021 06:59:10 +0000
Message-ID: <de9ca659-e793-b67e-767f-44d4a49500a6@microchip.com>
References: <20211217150311.GC16611@kili>
In-Reply-To: <20211217150311.GC16611@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 835f4f45-a8c4-47ce-0fb2-08d9c38639b1
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_
x-microsoft-antispam-prvs: <CO1PR11MB4771EF3612E50E2D5FFD1BC2877B9@CO1PR11MB4771.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VIXWtR5bjsOmvc4A++aLkdsEyM95rNFW1bTQ9FSRf4EZiO39Y53hdZWUKvBQKb8iDXRetdKcjVfE7yc0aT5M5YWYSmM6tIlTVKhYnK2LsidDeiILrctQdi9CwtEWKjacNao3XsMrDB19PDV+bI9PGxK6uGhicV+84vlQ3/6uA30c+Jv9sgNcLKQbwBLHtuRgGoOp8vtW2ffDa8HsuamXGpCDOV6h7pdbZCZnn7Cfa7YZyDHo8pJ4+XfQt3LJwsOjuq0rOePamL0HWVMXAOXc6YzLQVFJdcizqMPBKIKSagYYW90NTS7PfkeodmVQ0SS1q4cp2beYKoXwfkq4BLJZ1wKy3OmhUs0iSFy6tLkwBR+7oR9rBFVNlVjYzq/RJ/TPM0b641LTqg7pGsPP7PxZW/uFjaG1QZfNTucG8LzuveKYWyXjeUw/6I3/6ru2DoAr873R7PmxgWjmePWBKmDtGnlHqbwhcLzJNFMaFTdVgDQpHldjimcLMsL1nk7hbVQNbmlMQn1msbGRAUAidrrFQ9j5nF9Xh+t++eoEy6DV63+PbzSVIMA0WGF30a0Z9L3s6VChpo0WzrK2ooc9ECRQGFfwTHmPAIBG2yxjkfgZs4BuQBelaMVM+djEh4IWqPt20zk9744U8dxF7R2Ue6oDGb3DgeZhaKFWrN5E8rbwxiPyzQvyvc+NyLOr26Uc2eZhFsaSJWHg5dQJveGbBxT/ziXT22WRMeer7UsIeRPghf1Ea+DV9tUeGB7IsnwPu/aB2c/aOwTlXxUvi8LKWz2Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(64756008)(66476007)(2616005)(31696002)(66446008)(6636002)(66946007)(76116006)(6512007)(71200400001)(5660300002)(2906002)(508600001)(6486002)(4326008)(86362001)(316002)(110136005)(91956017)(54906003)(53546011)(26005)(6506007)(38100700002)(122000001)(8936002)(38070700005)(186003)(36756003)(8676002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhFckIxeTZBTXVxTWg5WnVhRlhqQTRLZTVORldYbXZlQ2pVRU9xL2t6OSt4?=
 =?utf-8?B?Vjk3ZzQ1R3pVWmJLTkw0S1JFNVRmck1xa1JwMUZhUU5ldmhTWnMxRWIyTHFq?=
 =?utf-8?B?eC9IZmZSWWh3Zk9JSDhJNi9Yd1B5TXRMeFdVOHo4b3pGMG9tNThWWXEwQnV3?=
 =?utf-8?B?VStiSW12TUVVbE9qanlSdUtlNElTcTFJNnNLblVSclVMQ3RQVm5OY0xLbVE5?=
 =?utf-8?B?MW1RdDlMVSswVTNKSy9RK2FIcnhUNkZiWmxad1ZDMnJJYm9VbVZSeDRWUE9T?=
 =?utf-8?B?NVVZNURNNFdKR2dBZ04wQVRBVHFxcG4zcW1YQjE0b0V1UDhiOE1XRWRFdDdN?=
 =?utf-8?B?Vk1RUmg1M3RrT3p3K2M4OFMvNDJoYVR2dGsxbUxsUnpJS2tqSUMrblArcmlW?=
 =?utf-8?B?NE94TENFSCtMR0VaRUxoWnk4aWNSZGljWjhVTDdOOE5lcGw4ajlSc1l4bDhF?=
 =?utf-8?B?SEN0TkhzTzl4TEtDNlNYdkZ5ZDRMcnlmeDNxM0J6S3NObkI3TjgrTVdqb0FP?=
 =?utf-8?B?NXVwK085MTIzS3p0V2tuckpPNUdiS2R0ajJmUVM2elB5ZU1KS2pZMGtHTERh?=
 =?utf-8?B?QVBuNUtsemlPVG5kSm45VUdEOXFIOUdXVnd3L2pLQ0oweTNaNmw2SkJObzl4?=
 =?utf-8?B?TDNsSWd0UVV6R3hHWS82b2ltMkkwUFVYdW9MZk1HeTd2aDliOXdwQjFsSjkz?=
 =?utf-8?B?TWpId2Y1MkQ0MStPc1p3TDhTQjd5UmJFQnVlZjhGNlJGSFR1NFdKQ0lMVkJW?=
 =?utf-8?B?aTJtNDRSTjlOQjRKaHBqRGY4WUFUYXExd0d1MkdjQnQzMkdqUktkSHhBdVFX?=
 =?utf-8?B?Z1pkcTJTbHFGdzFrSFJOQlRZL2E0WnVXeXc5N25BNmhzcVJRM0swQ0pOcUVC?=
 =?utf-8?B?YmdFN1RPOGRzS3dlVnl1KzBVUmxIc0lWWE9VRkF5WGVWam1vcjRuSUJRMGlB?=
 =?utf-8?B?Q1hTdURVbWRkLzdXT1htRjFUM2ZxT1VHdm93ZVRCaGpkRDE0NGdnalZ3ZjQx?=
 =?utf-8?B?OHdZUVpmWWMwcFNsd2d0SXZzMDRwcXRlU1VKQnY4UUIzMVFLR3JZVWtiRXo3?=
 =?utf-8?B?bnFmbWlBdUJvU3NlaCtoNDBOVGpHV0tQaFd3Y05pdkJ3Ukc3bkpzM0d3QjFD?=
 =?utf-8?B?TUV6dXRHWldlWmRxc0FZa01MWEtNR0xsNmdUblp0ekNGUU5ET3k0emdMaFdH?=
 =?utf-8?B?aFhMSUhubUlibGx6OHM0VHgwK3dGQ0F2TTBiMkhMUUV6Mi9HNTRTTWpVMUpJ?=
 =?utf-8?B?MisxK2t3ZHpxbVlOUXJOTlBvVnZKZ1VIYjRtQ0gzeUZ6YURQRW0vQnNWUlZD?=
 =?utf-8?B?MjIzTk1haG1TYkQ2ZTVhVXI2cVJvclY1UytZSDhlWHpZbnpldkYySTRrS2Nr?=
 =?utf-8?B?SE11cmV2dW9NOW9HZWtQUXJXTFZ3NDUyZnhhVFVvdUhwU1VPTVR2TEdibGdm?=
 =?utf-8?B?MTFLaEFaSHl4VjdrcVZSbHFRNEM1Z251RmN2eERPWDFReGJWcEg0UlRFK1Rq?=
 =?utf-8?B?ODJucC84c3BQa3R1b3kySUFuQW10azBZWktsODF6L2FCY1ptdG5UOThqVkF4?=
 =?utf-8?B?UXRCSmV0TDBBQ3AwVzRMQ28vUCt5R0RWem52aXdJcWg1YnZnOEM5bE9qeml4?=
 =?utf-8?B?emQ0bzNmY003WXNVN2UyQW5WdkJuU2l5K0taa01HdVRZR0E1ODA2eEczSUdN?=
 =?utf-8?B?bFhIT0FHZTV1dUx0azRVYTF5SUZERlExUlZTMVdUYTFnZGplMzJtZWVadkpD?=
 =?utf-8?B?bUJOa3RUbm5aSjYxWmc2a3RnaTFOWjNqM3U1U3RreU5oSWsxTVo4RUFVRkFT?=
 =?utf-8?B?SHkyNitYcnFaWGVOWXFKTHI5Z0hTalRmbHBKZVBoZVRWRCtWczFGK3ZsSWFa?=
 =?utf-8?B?VS9MQ2ZsUVJZL2RSNTh5WTR3UUh1OG1oalUrYlNSK2ZPT1hpNXJOVUZ6UjYw?=
 =?utf-8?B?NTFOK25wQkdDelp0UmpiMGNjVzFORTVWc0pUSVpGWmR2R2l0M0c5bHdmZy81?=
 =?utf-8?B?SUsrcGhVYXZEUHJhWDFUOGQ3TlVUeTNlZWEzZm1idURuYUFJRjJFUXFiUkFD?=
 =?utf-8?B?M2ZXTTdiR2dpNTRQZ3NFUHdJNWw3dnFZY1p0M3VKTC9TaEUvWDhSZmVybXdB?=
 =?utf-8?B?NWZrbHdCeXJLWkY5cFU1MmUvMzBrWlVKb2cyd3AxenZySUZIZms0YWpJQUxG?=
 =?utf-8?B?MStxWlcvRXRleGlkV0IwSGJNNWdjd3VPU01FSHFzd1Nmc1pjNGtxNmpLdkZI?=
 =?utf-8?B?cWdQWjlHRGtNS2JUbjJzNWN1UHV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7AF5736B0B0C7499B8C95429F79890C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835f4f45-a8c4-47ce-0fb2-08d9c38639b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 06:59:10.9325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAA1fCJad9MYWkh2r8MuSUtz40Q4sBTHMW3UH76M6svBsJ7HLlstio+qXwzEFUxnEZeQ7+mi4JGB1r9Sno5EvmflyEkr5u5RtSJeZqR+XQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTcuMTIuMjAyMSAxNzowMywgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTbWF0Y2ggY29tcGxhaW5zIHRoYXQgdGhlcmUg
aXMgYSBkb3VibGUgZnJlZSBpbiBwcm9iZToNCj4gDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21p
Y3JvY2hpcC93aWxjMTAwMC9zcGkuYzoxODYgd2lsY19idXNfcHJvYmUoKSBlcnJvcjogZG91Ymxl
IGZyZWUgb2YgJ3NwaV9wcml2Jw0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2ls
YzEwMDAvc2Rpby5jOjE2MyB3aWxjX3NkaW9fcHJvYmUoKSBlcnJvcjogZG91YmxlIGZyZWUgb2Yg
J3NkaW9fcHJpdicNCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2lsY19uZXRkZXZfY2xlYW51
cCgpIGZ1bmN0aW9uIGZyZWVzICJ3aWxjLT5idXNfZGF0YSIuDQo+IFRoYXQncyBjb25mdXNpbmcg
YW5kIGEgbGF5ZXJpbmcgdmlvbGF0aW9uLiAgTGVhdmUgdGhlIGZyZWVzIGluIHByb2JlKCksDQo+
IGRlbGV0ZSB0aGUgZnJlZSBpbiB3aWxjX25ldGRldl9jbGVhbnVwKCksIGFuZCBhZGQgc29tZSBu
ZXcgZnJlZXMgdG8gdGhlDQo+IHJlbW92ZSgpIGZ1bmN0aW9ucy4NCj4gDQo+IEZpeGVzOiBkYzhi
MzM4ZjNiY2QgKCJ3aWxjMTAwMDogdXNlIGdvdG8gbGFiZWxzIG9uIGVycm9yIHBhdGgiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQoN
ClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9u
ZXRkZXYuYyB8IDEgLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L3NkaW8uYyAgIHwgMiArKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMx
MDAwL3NwaS5jICAgIHwgMiArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
aWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2No
aXAvd2lsYzEwMDAvbmV0ZGV2LmMNCj4gaW5kZXggMDNlMzQ4NWQ3ZTdmLi42NDNiZGRhYWUzMmEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9u
ZXRkZXYuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAv
bmV0ZGV2LmMNCj4gQEAgLTkwNSw3ICs5MDUsNiBAQCB2b2lkIHdpbGNfbmV0ZGV2X2NsZWFudXAo
c3RydWN0IHdpbGMgKndpbGMpDQo+IA0KPiAgICAgICAgIHdpbGNfd2xhbl9jZmdfZGVpbml0KHdp
bGMpOw0KPiAgICAgICAgIHdsYW5fZGVpbml0X2xvY2tzKHdpbGMpOw0KPiAtICAgICAgIGtmcmVl
KHdpbGMtPmJ1c19kYXRhKTsNCj4gICAgICAgICB3aXBoeV91bnJlZ2lzdGVyKHdpbGMtPndpcGh5
KTsNCj4gICAgICAgICB3aXBoeV9mcmVlKHdpbGMtPndpcGh5KTsNCj4gIH0NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9zZGlvLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc2Rpby5jDQo+IGluZGV4IDI2ZWJm
NjY2NDM0Mi4uZWM1OTVkYmQ4OTU5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvc2Rpby5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMC9zZGlvLmMNCj4gQEAgLTE2Nyw5ICsxNjcsMTEgQEAgc3RhdGlj
IGludCB3aWxjX3NkaW9fcHJvYmUoc3RydWN0IHNkaW9fZnVuYyAqZnVuYywNCj4gIHN0YXRpYyB2
b2lkIHdpbGNfc2Rpb19yZW1vdmUoc3RydWN0IHNkaW9fZnVuYyAqZnVuYykNCj4gIHsNCj4gICAg
ICAgICBzdHJ1Y3Qgd2lsYyAqd2lsYyA9IHNkaW9fZ2V0X2RydmRhdGEoZnVuYyk7DQo+ICsgICAg
ICAgc3RydWN0IHdpbGNfc2RpbyAqc2Rpb19wcml2ID0gd2lsYy0+YnVzX2RhdGE7DQo+IA0KPiAg
ICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZSh3aWxjLT5ydGNfY2xrKTsNCj4gICAgICAgICB3
aWxjX25ldGRldl9jbGVhbnVwKHdpbGMpOw0KPiArICAgICAgIGtmcmVlKHNkaW9fcHJpdik7DQo+
ICB9DQo+IA0KPiAgc3RhdGljIGludCB3aWxjX3NkaW9fcmVzZXQoc3RydWN0IHdpbGMgKndpbGMp
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAv
c3BpLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc3BpLmMNCj4g
aW5kZXggZTA4NzFiODk5MTdkLi41YWNlOWUzYTU2ZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9zcGkuYw0KPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc3BpLmMNCj4gQEAgLTE5MCw5ICsxOTAsMTEg
QEAgc3RhdGljIGludCB3aWxjX2J1c19wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAg
c3RhdGljIGludCB3aWxjX2J1c19yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gIHsN
Cj4gICAgICAgICBzdHJ1Y3Qgd2lsYyAqd2lsYyA9IHNwaV9nZXRfZHJ2ZGF0YShzcGkpOw0KPiAr
ICAgICAgIHN0cnVjdCB3aWxjX3NwaSAqc3BpX3ByaXYgPSB3aWxjLT5idXNfZGF0YTsNCj4gDQo+
ICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHdpbGMtPnJ0Y19jbGspOw0KPiAgICAgICAg
IHdpbGNfbmV0ZGV2X2NsZWFudXAod2lsYyk7DQo+ICsgICAgICAga2ZyZWUoc3BpX3ByaXYpOw0K
PiANCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gLS0NCj4gMi4yMC4xDQo+IA0KDQo=
