Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5C558D500
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 09:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiHIH4S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiHIH4R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 03:56:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A7A18B30
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660031774; x=1691567774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5oMOXHl1UdGLeTXYJjcKnddwku1V0KMuM0u1+lygPG8=;
  b=1JzWE7PK/trt09Np1cxTd6tNKy4Dh3dzylkIRDxM2EnB7z0CTZs8Ouuq
   Jm26QbsgEuYQXyIaYHwVh3tmUWaAcPbEbawzaQiUBo2tK0Tf4tkxW5bOK
   zRe4n6cyxDDvKf5D9ykPfcXtB8hnE4/5qAaAMNCXxV7RdRFfGtRQkfWba
   DdYfEJZxysQt9/B87BBuEBgsNR8w0I37ksEMHM8jXIfYTc+6S/yay1MD1
   O0Lq8GliagaKEpd4wh9nvCfVEVl0LRmGw3OfaGCFosGI7BsGNSmJtf1Fz
   xo1Xqof5EZtXkNXxu+1o7jkTwPOVH4izTh10Ypn3a2AdPssBlyt7m6WIv
   w==;
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="185694214"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 00:56:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 00:56:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 00:56:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs7J5U1EmtzZIEVyEZxIRP4k/hzJNevLd32Cju+tsQA9+HfCVJrlewnnz8FsI7ANjUn/1Sf7YF1ETurysuBuC67FKm8nyZqPdmU02eNTn7IDOSAXyMK8poy8ai59HsF7GAbE8jQoJxK8E5BW/Sge9fcYataB/+2B7TcixsICjbsuMjq0+ZOD7f7e2UlyH5qzvJVufVZjPWQ+mWsyZKwRfn80knHHPKzt7M+/CAeC1rIfEkbjbHOk33i52PqvcNOrGD3uzWL0yUDfNACOW8N+chhcB0OequSXMCfihtR+voj0Zt6OC4YwDlNHNDwdXOLjkitJTeqjxdgytPNw6VfOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oMOXHl1UdGLeTXYJjcKnddwku1V0KMuM0u1+lygPG8=;
 b=GJ6h+ItKzgjli5OMBpuVOiOx/AjPWL7xAfM6oCNbd7lQenXZROqCj8c65/Y9aHjEzXBzl7ZNa0B+kyrWmUhuCreRVpZmMFgMy2XJnI9MBFKLVyWjBuZVVit6as+L8UCTlBVDwepHke8fiTF5jMdVUnOFZ+kGeC1IBN6dHvE5JwRqMpWWGLbJToJMmlHwqWtitiYmcT43RHcudJdSXp4wszwsXaaafbPUVed+5Ld341Mti0OA3CeeXO6R1C56g76rMSmHgpdg20mnxOUQJM6cr6S21cq6TRL0stMQpCVN43QwHn9M9O1ztMfOOpKQwQ9Tc+3W/6PuGG7GubYj1DtRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oMOXHl1UdGLeTXYJjcKnddwku1V0KMuM0u1+lygPG8=;
 b=uN2hyh+jqbeTRLb2uarLCoHG13WuzeBZdwxFC2ucvZZOi/mnblsgLQAKvrAylqxfphLUywc4orjcf+TU3L9s/igwsrcwuocGfA3zB8unaiTdghSkeZUxNc66Woxh3fSQimSxwDTx8hfwy9D7jkPSCL033zrCchl/0Abi+fU0mZw=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 07:56:09 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 07:56:09 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <mwalle@kernel.org>
Subject: Re: [PATCH v2] wifi: wilc1000: fix DMA on stack objects
Thread-Topic: [PATCH v2] wifi: wilc1000: fix DMA on stack objects
Thread-Index: AQHYqC3tsnzfAAD+gEWLNR85ROYhf62f9E8AgAZGTAA=
Date:   Tue, 9 Aug 2022 07:56:09 +0000
Message-ID: <02694b88-5404-6bcb-3ac1-3db7fc12b257@microchip.com>
References: <20220804181340.365429-1-ajay.kathat@microchip.com>
 <a80d8d050ba3bf873deceb73af5a377d@walle.cc>
In-Reply-To: <a80d8d050ba3bf873deceb73af5a377d@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2025ec9-b915-43c5-278f-08da79dc9f10
x-ms-traffictypediagnostic: PH0PR11MB4824:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YwgIhMjU9kTcjiAb80BaSV26SWJsHZCoqH8+n2ewVJoW3d8SeleiKR4PbQeq7fXH31bG4UVWIT51O3lDjF80340TgssW4iSUUy1KJ9Si3TDqtVwLQuNxUNuN2Axp5EygPpljWhABe3Ud2EBUopxxSxJpV1h5nWH/hGjVngm+HIdM1LcmbTyDqjSTWX6Yp1ZylmVqZHmELMx/FpE5DV+vp5C8n9R4VmCACLhO9EUOyM94tLiJsV3loyAxDhJfTwXVlijTYIh3J5Y+BsFrrW6LFy5WpHUOj5AqKn059qHsMv/ScUCAWE1pN4hM1OKWeim4CDxjTZUBTojh2fmPULKY3xkaIak2eROr2Wo2eitIAMAqIoIo1A7rHj2C4rMyA9ENDq6xUP4qN5pTg/5BqkhEf6QhhKBlyTYMpxdD8ydWeYuV06PYejU7oxiyjzcuOJs+qAEQZWoxCfiGdUkOWNaXxeQ4Ug+utBwkodEc15p8YI6JxVj1PgtTHGHePOMg020iyxabjd31AhcfgzDmvI/GtyEeZB1YkXZ/9Fao5nkFMPjlcO5oe6GOmb4JNmiskCH3bdo+XCXQ9YT5bEvjEl6Wd+kXtyCJxmaP4gohvURegOPHiUfmnaZL/o3K2cJS6LWMEFpsaFlTAE1HvPecsWDHjzJ9XH/fdDPzvv4vuFEvsizuSFI2Qhi+yAFnw5AR9AnedLJGbtErHhjkA7yz15+1wX0oXgJ5T95wdCg1zWHwXKDkQPJhfeo2lVTxUgRlN/5wvBau8h1ns+sTZCw/AArcC7JAFrkoC9lD09KCmjrD1Wf7jC1k7pQQXxjaV8OJwFRuk9s4gXS1ZWP2hn7o5TvQKhmh9lADFaB6CwMDdUNDzpzSP1neLkWVClLeOBr5PAkjP9/ySMds8Hj2BSUTTlNX9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(366004)(376002)(39860400002)(6512007)(966005)(6486002)(478600001)(54906003)(6916009)(55236004)(53546011)(6506007)(26005)(41300700001)(2906002)(36756003)(31686004)(31696002)(86362001)(71200400001)(316002)(186003)(38070700005)(38100700002)(4326008)(8676002)(66476007)(76116006)(91956017)(66446008)(64756008)(5660300002)(66556008)(66946007)(83380400001)(122000001)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFljUkNCZjY4ZEM3d2dkZzZrS0hMdnV3Njdad1hDTlI0OWIrZmJFUjFCSFFW?=
 =?utf-8?B?WWlLQ0VpNmcxSUhoNEZtMDVzUVIwVlpuUXU1akdJY1lYWitLM01YelNNbnNj?=
 =?utf-8?B?NTRqRnNPTlNPTWJLZStVVmFWSVhSS2RUUDBaUjg1SGVvUHpJeEIzbzI3T2pL?=
 =?utf-8?B?aC9lRTBRVTBtLzNwT0dnaGpybGQ5bmlQdW45MEhGZFFyUGtETE9sUDg4eXNU?=
 =?utf-8?B?NEptOVYrWFpzNm1Kc1FKRWkwZDJzZklkMnZITVNUdHVhWU0yWUJTV3dMVHZq?=
 =?utf-8?B?SjA1cW55U29iTm5ZTjUyemVYc0pRbTl0Q0lnMW5aV2ZHbUhkWHBOdG5HSElH?=
 =?utf-8?B?M0Q4by9yV1hUNCt2Zk9aRmE2VkpnWU9xbHVsR3FraG9semxXZUpPOVlhSjd6?=
 =?utf-8?B?ck1ObWRWNlB1RHh5Zjg2QjlEMTA3bEtmVTRZdFpSbk9DWG9UeVRCcTBUanpB?=
 =?utf-8?B?amx1UlU1clExMWpCVXJXNmtId2kxLzlaT2tHQ3hMZFdIb01RYjRvTUg0N0dY?=
 =?utf-8?B?aGlqMG5xSGxDenRqVjJYSTNHSVpvUTdaaW5ubGNZc1MrREM0MFBUSWxlbjE4?=
 =?utf-8?B?NVF5WFh5WFQ5WDBSSXlhQmdoNTZGNzcxbTZsbkt3TERxSGZWUFdWMkx3SXU5?=
 =?utf-8?B?RnhlQjRFVkI5YWxHUWoydE5uVHdrL2VmS29OdlNNYS9MVlNhQ0xTZ0p0V2xZ?=
 =?utf-8?B?WGhFQi96YVlzTURxR3VEMVlBNmg1SFYvRnRyNnpzSy9XSnM0MnhsNkhEemtR?=
 =?utf-8?B?cGg3OWxMcDBLUHJBeUhGbDRNenBtdkRqQndYY044b1U0cFRkaUlaTzRJQmhS?=
 =?utf-8?B?bDl0bFVZdjhMMmsySU5oSXlvSnl4TFozOHhkOTAvQlNSbEdKZTQzNU5hUzhB?=
 =?utf-8?B?bmtLeVZ3b0NhdktERE9GQW1MUWJyMk0yL1c4cThvVHN3VWdEZGp2aVBraWhl?=
 =?utf-8?B?eDRhbmcvVE1mcXdhZUtyaEd0NnNxaUVFSFB4c0xuYTJ0SG8vTmRMdDRBS1R1?=
 =?utf-8?B?NmhpOHAyWEpDUEZMcnZjWFRoMGlLQ2svYWk1bVFIOUR1MUJvV255V3YzVzZ6?=
 =?utf-8?B?enBnWFUyWFloUDJrZmJBTUM5T3RHT1hyaUwydm5FUFN4UWdOZmRpaGJITm5t?=
 =?utf-8?B?Sm5kQldzcGpBV09KczhIS20xcndNcmxjOG9Cd1RTLzN0VUUzMHlORlFtNWwv?=
 =?utf-8?B?NGg0NFIrQ2l4N2RpMFZqZHphUHJORlRJdnd1MkdyaEZ1VmZ1VWVYeVE2SnF0?=
 =?utf-8?B?cVNtSUo1NEVUbzlMQVBmM3BHdC92ektSblZhNVErQWJVSWViWXdPNjNkbzhI?=
 =?utf-8?B?WU5sM3J1b2czdHhjaU00RDRmRHhDWm5HaUhYS1lFaTdpY2RHTVdVVTZtU3Qv?=
 =?utf-8?B?VVZZSDRHanZqdXFBbkFIcU9jakk5a0VLUUxhMnFZdEp2S0VpZUppT2NGa1BN?=
 =?utf-8?B?N2NILzkwS2NiQmRhWGt4SnJxaUhRVjhzZ0E2Q2s4SHJQQjR1di9SY0pic2R1?=
 =?utf-8?B?VllFV1NLUHRLQjlGNDJaZXAwNlFYTWNpdE1KeHFhRzUxeEh6QW9Xa2ZFY096?=
 =?utf-8?B?aFk2K3QwV2pDbitHVW8wdTJybCtIL2hmbUxhUXRZVEdPZnMzbkJSV1NFNDE1?=
 =?utf-8?B?RWxMUm5BaEVTazBFM3RMZ0J5VTVpei9sb2NPMjlrYW1LbDREak1mMGdMa2Yy?=
 =?utf-8?B?RFRDdnJCUXRLSXRzVFZXWWZUdnRzWTQ2UzQ2V1g2RzhybkJzR1V6b25rc1JB?=
 =?utf-8?B?UmV1d3FzQUFIUHd4Q1VhckFlSjh1OGxSYW9NNlB5bVdrMU1xN09ZVnorRHk3?=
 =?utf-8?B?RjVybTdXMUFYUzA5L1U0MmxuQjJhaklWOXpJRkRDL3FWWTF5eTNuVkZPOHRi?=
 =?utf-8?B?aVpGYmRWdm5HL0ZWQnRoeTBySnBhTmh1SGtqMTYyNEdsN2kvVnVRNHRKYXFa?=
 =?utf-8?B?M2NzdTdhaW9tOXpxanRXOEhrTFU1US9aWlAzMGx6VGR3Rlp6K0VkWi8vWlJQ?=
 =?utf-8?B?Z0ZVVXpyODhZN2xGOVcrR1paRUFOY0VENFhRR2tXS2doM0llUXBGN2lDTnhQ?=
 =?utf-8?B?MjVNWGRjQktsaFJma0JqZzEzanM0NWFVVWVPcndoeXc5Wjl2OFgzc0pnZHFQ?=
 =?utf-8?Q?lb6FPkfJFjAZ9u8AAcveKSq9K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF6821EA0C4A394680E578F925A3A17F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2025ec9-b915-43c5-278f-08da79dc9f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 07:56:09.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05l4GnnL0p/l9vl/ja8dkFFmy88nZgrSSOQcZBRdAQ/3CNTGDAK+ebc5oR/wOE48ontPbWTjoRQZQCDBzp0Q8C0sKmJhSRAhEgbafoMWYgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTWljaGFlbCwNCg0KT24gMDUvMDgvMjIgMTM6MzYsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgDQo+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gSGksDQo+DQo+IEFt
IDIwMjItMDgtMDQgMjA6MTMsIHNjaHJpZWIgQWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbToNCj4+
IEZyb206IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gU29t
ZXRpbWVzICd3aWxjX3NkaW9fY21kNTMnIGlzIGNhbGxlZCB3aXRoIGFkZHJlc3NlcyBwb2ludGlu
ZyB0byBhbg0KPj4gb2JqZWN0IG9uIHRoZSBzdGFjay4gVXNlIGR5bmFtaWNhbGx5IGFsbG9jYXRl
ZCBtZW1vcnkgZm9yIGNtZDUzIGluc3RlYWQNCj4+IG9mIHN0YWNrIGFkZHJlc3Mgd2hpY2ggaXMg
bm90IERNQSdhYmxlLg0KPj4NCj4+IEZpeGVzOiA1NjI1Zjk2NWQ3NjQgKCJ3aWxjMTAwMDogbW92
ZSB3aWxjIGRyaXZlciBvdXQgb2Ygc3RhZ2luZyIpDQo+PiBSZXBvcnRlZC1ieTogTWljaGFlbCBX
YWxsZSA8bXdhbGxlQGtlcm5lbC5vcmc+DQo+PiBTdWdnZXN0ZWQtYnk6IE1pY2hhZWwgV2FsbGUg
PG13YWxsZUBrZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8YWpheS5r
YXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gVGhpcyBwYXRjaCBpcyBjcmVhdGVkIGJh
c2VkIG9uIFsxXSBhbmQgY2hhbmdlcyBhcmUgZG9uZSBhcyBkaXNjdXNzZWQgaW4NCj4+IHRoZSBz
YW1lIHRocmVhZC4NCj4+DQo+PiBbMV0uDQo+PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyMjA3MjgxNTIwMzcuMzg2NTQzLTEtbWlj
aGFlbEB3YWxsZS5jYy8gDQo+Pg0KPj4NCj4+IGNoYW5nZXMgc2luY2UgdjE6DQo+PiDCoMKgwqDC
oMKgwqDCoCAtIGFkZCAndXNlX2dsb2JhbF9idWYnIHZhcmlhYmxlIHRvIGtub3cgd2hlbiB0byB1
c2UgYm91bmNlDQo+PiBidWZmZXINCj4+IMKgwqDCoMKgwqDCoMKgIC0gcmVtb3ZlIHVubmVjZXNz
YXJ5IGdvdG8gbGFiZWwNCj4+IMKgwqDCoMKgwqAgLSBkeW5hbWljYWxseSBhbGxvY2F0ZSAndm1t
X3RhYmxlJw0KPj4NCj4+IMKgLi4uL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0
ZGV2LmjCoCB8wqAgMSArDQo+PiDCoC4uLi9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L3NkaW8uY8KgwqDCoCB8IDM1ICsrKysrKysrKysrKysrKy0tLS0NCj4+IMKgLi4uL25ldC93aXJl
bGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5jwqDCoMKgIHwgMTUgKysrKysrLS0NCj4+IMKg
MyBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0
ZGV2LmgNCj4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRl
di5oDQo+PiBpbmRleCA0M2MwODVjNzRiN2EuLmJiMWEzMTVhN2I3ZSAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuaA0KPj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oDQo+PiBA
QCAtMjQ1LDYgKzI0NSw3IEBAIHN0cnVjdCB3aWxjIHsNCj4+IMKgwqDCoMKgwqAgdTggKnJ4X2J1
ZmZlcjsNCj4+IMKgwqDCoMKgwqAgdTMyIHJ4X2J1ZmZlcl9vZmZzZXQ7DQo+PiDCoMKgwqDCoMKg
IHU4ICp0eF9idWZmZXI7DQo+PiArwqDCoMKgwqAgdTMyICp2bW1fdGFibGU7DQo+Pg0KPj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgdHhxX2hhbmRsZSB0eHFbTlFVRVVFU107DQo+PiDCoMKgwqDCoMKgIGlu
dCB0eHFfZW50cmllczsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNy
b2NoaXAvd2lsYzEwMDAvc2Rpby5jDQo+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cC93aWxjMTAwMC9zZGlvLmMNCj4+IGluZGV4IDYwMGNjNTdlOWRhMi4uYjEyZjQxMWFlYzA2IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3Nk
aW8uYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3Nk
aW8uYw0KPj4gQEAgLTI4LDYgKzI4LDcgQEAgc3RydWN0IHdpbGNfc2RpbyB7DQo+PiDCoMKgwqDC
oMKgIHUzMiBibG9ja19zaXplOw0KPj4gwqDCoMKgwqDCoCBib29sIGlzaW5pdDsNCj4+IMKgwqDC
oMKgwqAgaW50IGhhc190aHJwdF9lbmgzOw0KPj4gK8KgwqDCoMKgIHU4ICpjbWQ1M19idWY7DQo+
PiDCoH07DQo+Pg0KPj4gwqBzdHJ1Y3Qgc2Rpb19jbWQ1MiB7DQo+PiBAQCAtNDcsNiArNDgsNyBA
QCBzdHJ1Y3Qgc2Rpb19jbWQ1MyB7DQo+PiDCoMKgwqDCoMKgIHUzMiBjb3VudDrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCA5Ow0KPj4gwqDCoMKgwqDCoCB1OCAqYnVmZmVyOw0KPj4gwqDCoMKg
wqDCoCB1MzIgYmxvY2tfc2l6ZTsNCj4+ICvCoMKgwqDCoCB1OCB1c2VfZ2xvYmFsX2J1ZjsNCj4N
Cj4gYm9vbA0KPg0KT2suDQo+PiDCoH07DQo+Pg0KPj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHdp
bGNfaGlmX2Z1bmMgd2lsY19oaWZfc2RpbzsNCj4+IEBAIC05MSw2ICs5Myw4IEBAIHN0YXRpYyBp
bnQgd2lsY19zZGlvX2NtZDUzKHN0cnVjdCB3aWxjICp3aWxjLCBzdHJ1Y3QNCj4+IHNkaW9fY21k
NTMgKmNtZCkNCj4+IMKgew0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qgc2Rpb19mdW5jICpmdW5jID0g
Y29udGFpbmVyX29mKHdpbGMtPmRldiwgc3RydWN0IHNkaW9fZnVuYywNCj4+IGRldik7DQo+PiDC
oMKgwqDCoMKgIGludCBzaXplLCByZXQ7DQo+PiArwqDCoMKgwqAgc3RydWN0IHdpbGNfc2RpbyAq
c2Rpb19wcml2ID0gd2lsYy0+YnVzX2RhdGE7DQo+PiArwqDCoMKgwqAgdTggKmJ1ZiA9IGNtZC0+
YnVmZmVyOw0KPj4NCj4+IMKgwqDCoMKgwqAgc2Rpb19jbGFpbV9ob3N0KGZ1bmMpOw0KPj4NCj4+
IEBAIC0xMDEsMTIgKzEwNSwxOSBAQCBzdGF0aWMgaW50IHdpbGNfc2Rpb19jbWQ1MyhzdHJ1Y3Qg
d2lsYyAqd2lsYywNCj4+IHN0cnVjdCBzZGlvX2NtZDUzICpjbWQpDQo+PiDCoMKgwqDCoMKgIGVs
c2UNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemUgPSBjbWQtPmNvdW50Ow0KPj4N
Cj4+ICvCoMKgwqDCoCBpZiAoY21kLT51c2VfZ2xvYmFsX2J1ZikNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnVmID0gc2Rpb19wcml2LT5jbWQ1M19idWY7DQo+DQo+IFRoZXJlIGlzIG5v
IGNoZWNrIGlmIHRoZSBzaXplIGZpdHMgaW50byB0aGUgYnVmZmVyLiBTbyBtYXliZToNCj4NCj4g
aWYgKHNpemUgPiBzaXplb2YodTMyKSkNCj4gwqAgcmV0dXJuIC1FSU5WQUw7DQo+DQpTdXJlLMKg
IEkgd2lsbCBtYWtlIHRoZSBjaGFuZ2VzIGFuZCBzZW5kIHRoZSB1cGRhdGVkIHBhdGNoLg0KDQpS
ZWdhcmRzLA0KQWpheQ0KDQo=
