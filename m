Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5001764838A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiLIOQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 09:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLIOPf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 09:15:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D478B8C
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 06:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670595270; x=1702131270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=exKfitjZNrSIiuRYkOhMWCbBvomqXmhWwaK7QMg97H0=;
  b=B+pPiFqN8dPTpeMq+lxZKd/FIi+kxTBhHpz9AMMH3Ti/kt/TcZRU0jpr
   OPzEkeT9NWp6x+hjjahRfjD1x6j67jrS+V7EqufDuvYEPJxPFqnzD06mz
   UDFeQwsj5xlw+WnSuMP/kbFlR5/uBqGhTlKl8L6Jo95diN1ZFmrf9s9I4
   bWwMhUhhii2vd8h/fKUhz3UAgZqfsgKlAAdu5MKGIEKLshtPtn/VX8VGh
   ckaG/ZrOT6b0PrB/iA7jryfxYxNwnkf0ZqnFBVWILa14Qqi3XGgOVOjSi
   v/IGBcajrrdvtU12/YUjcyKWgJu8c0Lj3qoGIVUXGHTB/84OvKUpVfJz5
   w==;
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="192394233"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2022 07:14:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Dec 2022 07:14:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 9 Dec 2022 07:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kecjVEbIqgvDNUgzRonGzrCfT9frC48i7Y5j3SZ6To2/qXa0t2P4HnF1zJWGIxgp4ukkuo51qBkkMci3/rOD6BFWoSa9miBk7PnAFEKuTTnloEj0tFMl7kW8poavE8TpEXL0948sr92ZFis4bfuQEcznE0i0SYLiMrpmKcXQ6vqAnmPmKnNnxg18+dDwN88qtGFyLDyKN8f+0JdIhsO7QIE2fD5lGdPgmeBOBZVmFQeUbqKlSoZwR3WzQz+KzvTOV9Aw6yuT1c05ZYQZjVXSERkQGh7qotLGFItlrwjWgtfPuQJZieHSEk57rdAzBKoFjYZDZXDV9A0BxgRD5HkGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exKfitjZNrSIiuRYkOhMWCbBvomqXmhWwaK7QMg97H0=;
 b=i06Mn6Fi6BiBkq+LUOm7ehcOCsL4RkYGeyD+Vo482Yd3hTkvg+wiDmQeyBDmdOPGXwLg+feMsQXwB355OFax0NsCywzdwfb0Zzt4Bx/Y7Ui2Gvy/45MQCnty9StD09em7KxEtATNnLMtsCFtfE3Sm5F9ZgTOMDLMjvIGMRjMCJO0E4jAAwJKnZUE7/LzcXx4uedXJxgLxp7AjMPo+fC2KXB9iGnF6tLLWhzZ3n6HV0lDHr8YBphWjZRRbTpnRbnvOUK6BbvGjz1Yq/47N/ZFuw9OYXEwnWTh7R4Sjn3NWfWOs6toHUpRRDyaLwHqU9YNveTYaSU/BaiBJIaPu+5XBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exKfitjZNrSIiuRYkOhMWCbBvomqXmhWwaK7QMg97H0=;
 b=ILQUxOAp8/QwKSkd4gnH2j+8KFkkRGaLVHxXzPn4pragY6PJcnwVjZ0lTeFBK4naFBco8eHjwcb9NhfdQWit5oLH3OMRes0r64GlWZ8aDx+1LqKQiSge6yMtDQNciJBOxX2lb/KI14jNUnkAJtQ0Za8LkVIu2mnIcn0b7uHVDsg=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH7PR11MB7479.namprd11.prod.outlook.com (2603:10b6:510:27f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 9 Dec
 2022 14:14:27 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4615:bb9a:f2f9:6a1a]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4615:bb9a:f2f9:6a1a%5]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 14:14:26 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <mwalle@kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <linux-wireless@vger.kernel.org>,
        <kvalo@kernel.org>
Subject: Re: wilc1000 kernel crash
Thread-Topic: wilc1000 kernel crash
Thread-Index: AQHY57AoYhoLUWmb1kmazG1Rwau7ba4fkKkAgADRA4CARVuEgIAAJISA
Date:   Fri, 9 Dec 2022 14:14:26 +0000
Message-ID: <4f279aa2-b5df-0b76-2cdf-ddb339a19cf7@microchip.com>
References: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
 <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
 <20221026085415.6jgwrhq4sunqaypm@0002.3ffe.de>
 <20221209120343.wvagbfprsgdj74af@0002.3ffe.de>
In-Reply-To: <20221209120343.wvagbfprsgdj74af@0002.3ffe.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH7PR11MB7479:EE_
x-ms-office365-filtering-correlation-id: 971507e6-8095-4472-8e75-08dad9efadc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 05TQ/BNXs5XlrIjqpOewGKFGDq2ESvhmBU2TuXzHYeNNdrfrgbcKsE1dVjztFbpXTTCAJHuUIcyGWu4TP3vW/AvT+lim5BsjAbzKciDpgDYyf+FkapnBseykg5rFo0hdevP0+V9nAPWgjFaHh2nwRsUQsZYNlYU1yQHuMPTPJyzIN+D2ylhvsGF6EQMHv+n1KiUhy1VPJwFTUqyURr2rbnQ4Pch3b+bpHzOgp3nncMhROinOx4a5nfe3XNW1RQZRl6fdPrrMWx9kIeAc+hsBF8+No29bt/9rXu8sjWhY3SpI+agvQHBLiKt7bF6tTPK0T/QpFfFwoRbje+Sm/S1+QmMjYvUQkSbK6EEcTEd7FNfh7DXjfvxpA3O5l+1LFANZAcFce/jsIVuMBb3ElWUJPDQi/jH+9y4ypdNyU6WCo7tHTe6fThQ9Zv+O1qvLNOUiGOzLm+zs1dho8GrNcNcDH/HC2VGnCojBk37HmYq3nnEDmS6aoepmPDZ2YHGgrJKSNC4EJwEUHGnnPBdm3s8F65Xn3gdIIRS+28hzQdE3L1Fj/QTf2tddjRHcHaYCFIzGo+pjnrA26TvoFPwh7MiGy2mTJJx47+Truix4IMQ+NAR22InCTadmS70Wqtrcy23PDsuOug3GWWm+e8SWzDJKLUIL27tucEUIrOCAi/rcch8v7M/iOKRyJa3Z8Wcq7X0wE/dhxVk6IMzATVWp6DjLC6PrLrdVTno5DC/Q1p2TnmRbn3htF7en3hO3iuLQ2r/TKuk6LhHVDQn/5CuhW0ILQf4HkSeDf1G0MNxbZBg5b2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(83380400001)(6512007)(53546011)(6486002)(6506007)(26005)(66556008)(54906003)(31686004)(71200400001)(6916009)(55236004)(66446008)(66476007)(4326008)(64756008)(76116006)(478600001)(66946007)(7116003)(8676002)(91956017)(316002)(5660300002)(8936002)(186003)(38070700005)(41300700001)(36756003)(2906002)(2616005)(38100700002)(122000001)(86362001)(31696002)(334744004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0owd2srMm14UVdvMzlEQUxTR1NwdXkvU09OWUFCWldYbGFpRXdPcklKZ0Jv?=
 =?utf-8?B?UHJKVFkzWkFaWHIrN3JTbForVnJKeFFmckduU1V0d29DMHBYRXM2M1RQSkJ4?=
 =?utf-8?B?VXU1T0t4d2tUUlpLdHpndEdtdjdmd09Tb0VPVjU1MTFmNlZJc3M2bFNLSkxm?=
 =?utf-8?B?MVpHREVKZHVUeHFxZTFJbXVIUEdGRmdyZk9Sb1BScWp3M0R5MFFGMHJXVzBr?=
 =?utf-8?B?bUpwZHFPZm8rajIzUTdNdVBxb2tsM0JlQVV0UGVXeGtDMmZ4aFVhTjIwc3Y3?=
 =?utf-8?B?OS9ZcnVNbWhmdjhhZVNSMVVrYTZhU0dvUlFhWlN6ZGZVY3RhckNhdjBBUG9P?=
 =?utf-8?B?R3FNTGVFSTREUUFwbm1JdmljYUxtVFM1ZmtzaWsxM29Bb3dxbFZ1Z2pMRExz?=
 =?utf-8?B?a2NaWDFUaWhQZEVnc3RtRzhtam4rTStPSDU4SUZpM3djMXVGdzZucklta04w?=
 =?utf-8?B?TnhaZk9JUTk5aTdsbmdlMzhwcTZjZnNvbU82cGxoSWlldjVYVUtRSjQyTHRl?=
 =?utf-8?B?dkpMVSszOCszTEdScis4RDlDZXFOS3oyekcvY2dPUXptWGNxTUNLZGNJdjZj?=
 =?utf-8?B?L0Z3SE41ZHVaSHhPU2tiY2MvSEZ0Z3IxYk4rK21MSUtBYmxJNFVMZDdESXlK?=
 =?utf-8?B?ekp5dHNOY2puN2tGTEVoMUFTL1Z3UERvd0R3UUVqdVg2Rk13V2VLK0hlMEZV?=
 =?utf-8?B?WUFMaFNBVmI1cndET1pyWUhja08ybit5aVBHMXlZM05KS2h3M3pOS0p4Vm9v?=
 =?utf-8?B?cUEvS1VvaUNJdGJZdXNDVUJMN3B5anJTaTdGYkJmTENHTWNrSTdwNkhTNFNy?=
 =?utf-8?B?SjNsVllTUXRhN3N1YjR2OEtSYnlGZlhzZzFPb28vcGk1Rld5WGg2amJtMjQr?=
 =?utf-8?B?NUpWbmZvUktObjlFN1IzWU5mOStRNjFlNUZIN3JxZ05FZkRmalhBM0Y2aFB6?=
 =?utf-8?B?aXBhQVpRU2pIdmg4Mjc2MWhuNDRzMkM3WUIxNWRUdHJXdm9COWpqVWY2ZlQz?=
 =?utf-8?B?TVliazdXN1lZNjNQL1o3cnNKRlNKOFVuMUpHbENaSXpmV2NiVCtXdTFwS1pB?=
 =?utf-8?B?d0xEWnBweUlMMnRodE9jVzBoWVN3V0JYTDYvNFFwZWkzdFlNdVBNQ0NuSk9Q?=
 =?utf-8?B?UXcwY2FqK0trYlpZeG5ZTm5wK245N0xhRVYvMzlwTWVTd2lIcEljbmhVTEJw?=
 =?utf-8?B?ZkNsdTI5cW53Mll0STVxZ3ByZThnN2d1TkZmdVNnT2xYdU1NdW5kNk1TLzhu?=
 =?utf-8?B?TFkxNVFGUXByTjU1U0hhLzNLMWo4ZGFjZ3k2SCtHd3hYOVF5YVMxWmpxcGU4?=
 =?utf-8?B?azBVM09md2NXVzZiRXp4RmRpR1JrQWkwM0hVYnZiR1ZqWU9zelRLWkNzN1NZ?=
 =?utf-8?B?YTlnZExYSmh3MkpMZmh2Y3FzN1JwODBlbm1xUk9UTVhFNytUcWZKaGFWUjY5?=
 =?utf-8?B?azlNMzNJcHVVQTZTclF2VzF3TWNIdVJOS2VvdUlrTzEzb0sySk1NbUowUUw0?=
 =?utf-8?B?OXVLRWdJTVJQaVFuMUlTVkJtU3lGTzZTVUhyaVdDL2xsYnMzaEo5QVBRcTg1?=
 =?utf-8?B?NHlleENtS2VlRjB2TUdZY1poL3ljRkFubFliVDEvN1hpdUV4MnhTdXkwZFpy?=
 =?utf-8?B?M1V1QS9RZEZxTTZ0QXJ6V01tTkZxZVZjMzRNbzJJb29UNFExK0FRcVdrU1k1?=
 =?utf-8?B?Qi84cTRrVWsyWVdDVGVtVmQxYlRLcHc1YjNiTmt4RERaYklWWVc4M0d4WXZ4?=
 =?utf-8?B?cWkzcnNjd1MzU01nY0g3Wm5xN3gyRVNYeE5hWDhydWkrOFRPM1hPVGJqaytt?=
 =?utf-8?B?T0RoZ3lDMnVieVVkTzE3OVd6YU9DeHdnMk5wUGtIaXNvbkR4dVI2d08xQWk3?=
 =?utf-8?B?WnVXalN6UDh0aEViR0Q4S0hLWVd1QTFMaUthbjQ1L29MYm9acW1BaFJiblJp?=
 =?utf-8?B?NHZ0amtZdFRsSFRwU3EyaGhDV2JGVmxlVTJYSVBMc1lYYktWa1FCd2VqUktY?=
 =?utf-8?B?WEp5a1o1TE9icThSV3pISEpmWWVTcEI1NTVNMndobjJ0NlhCcGNpa3JCUmFs?=
 =?utf-8?B?ZTdzbk9la1NiZW1udHU3ZjJjTUxvMTNobmswUDhxYUVNTURjUzBtdGoxTWxv?=
 =?utf-8?Q?npJPTZZa798RM2K6WEiYr7fa0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ECEB102D6452046AD40E8B573F4B2C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971507e6-8095-4472-8e75-08dad9efadc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 14:14:26.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EK7B+8Z3G0DSJKL2PYZiyrachU5Jq5HQy97LSs51ypaVkPs/2cRv6J940GYRYcO05IacLR5YtPoLT37vmL9yavVKQHKre4+ftXQccjtt+t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7479
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMDkvMTIvMjIgMTc6MzMsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiAyMi8xMC8yNiAxMDo1NCwgTWljaGFlbCBXYWxs
ZSB3cm90ZToNCj4+IEhpIEFqYXksDQo+Pg0KPj4gT24gMjIvMTAvMjUgMDg6MjYsIEFqYXkuS2F0
aGF0QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IEluIGhhbmRsZV9yY3ZkX250d3JrX2luZm8o
KSBzY2FuX3JlcS0+c2Nhbl9yZXN1bHQgaXNuJ3QgdmFsaWQgYW55bW9yZSwNCj4+Pj4gYWx0aG91
Z2ggaXQgZG9lc24ndCBjb250YWluIE5VTEwuIFRodXMgdGhlIGRyaXZlciBpcyBjYWxsaW5nIGlu
dG8gYQ0KPj4+PiBib2d1cyBmdW5jdGlvbiBwb2ludGVyLiBUaGVyZSBzZWVtcyB0byBiZSBubyBs
b2NraW5nIGJldHdlZW4gdGhlDQo+Pj4+IGFzeW5jaHJvbm91cyBjYWxscyB3aXRoaW4gdGhlIHdv
cmtxdWV1ZSAod2lsY19lbnF1ZXVlX3dvcmsoKSkgYW5kIHdoZW4NCj4+Pj4gdGhlIGludGVyZmFj
ZSBpcyBkaXNhYmxlZCAod2lsY19kZWluaXQoKSkuIHdpbGNfZGVpbml0KCkgd2lsbCBmcmVlIHRo
ZQ0KPj4+PiBob3N0X2lmX2RydiBvYmplY3Qgd2hpY2ggbWlnaHQgc3RpbGwgYmUgdXNlZCB3aXRo
aW4gdGhlIHdvcmtxdWV1ZQ0KPj4+PiBjb250ZXh0Lg0KPj4+DQo+Pj4gUGxlYXNlIHRyeSB0aGUg
YmVsb3cgY29kZSBjaGFuZ2VzIHdpdGggeW91ciB0ZXN0IHNldHVwIGVudmlyb25tZW50Lg0KPj4g
VGhlIHdvcmtxdWV1ZSBoYW5kbGluZyBhbmQgd2lsY19kZWluaXQoKSBydW4gaW4gcGFyYWxsZWws
IGNvcnJlY3Q/IC4uDQo+Pg0KPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cC93aWxjMTAwMC9oaWYuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cC93aWxjMTAwMC9oaWYuYw0KPj4+IEBAIC00OTUsMTIgKzQ5NSwxOCBAQCBzdGF0aWMgdm9pZCBo
YW5kbGVfcmN2ZF9udHdya19pbmZvKHN0cnVjdA0KPj4+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPj4+
ICAgIHsNCj4+PiAgICAgICAgICAgc3RydWN0IGhvc3RfaWZfbXNnICptc2cgPSBjb250YWluZXJf
b2Yod29yaywgc3RydWN0DQo+Pj4gaG9zdF9pZl9tc2csIHdvcmspOw0KPj4+ICAgICAgICAgICBz
dHJ1Y3Qgd2lsY19yY3ZkX25ldF9pbmZvICpyY3ZkX2luZm8gPSAmbXNnLT5ib2R5Lm5ldF9pbmZv
Ow0KPj4+IC0gICAgICAgc3RydWN0IHdpbGNfdXNlcl9zY2FuX3JlcSAqc2Nhbl9yZXEgPQ0KPj4+
ICZtc2ctPnZpZi0+aGlmX2Rydi0+dXNyX3NjYW5fcmVxOw0KPj4+ICsgICAgICAgc3RydWN0IGhv
c3RfaWZfZHJ2ICpoaWZfZHJ2ID0gbXNnLT52aWYtPmhpZl9kcnY7DQo+Pj4gKyAgICAgICBzdHJ1
Y3Qgd2lsY191c2VyX3NjYW5fcmVxICpzY2FuX3JlcTsNCj4+PiAgICAgICAgICAgY29uc3QgdTgg
KmNoX2VsbTsNCj4+PiAgICAgICAgICAgdTggKmllczsNCj4+PiAgICAgICAgICAgaW50IGllc19s
ZW47DQo+Pj4gICAgICAgICAgIHNpemVfdCBvZmZzZXQ7DQo+Pj4NCj4+PiArICAgICAgIGlmICgh
aGlmX2RydiB8fCAhaGlmX2Rydi0+dXNyX3NjYW5fcmVxLnNjYW5fcmVzdWx0KQ0KPj4+ICsgICAg
ICAgICAgICAgICBnb3RvIGRvbmU7DQo+PiAuLiBTbyB3aGF0IGlmIGhpZl9kcnYgd2lsbCBiZSBz
ZXQgdG8gTlVMTCByaWdodCBhZnRlciB0aGlzIGNoZWNrPw0KPj4NCj4+IEkgZG9uJ3QgdGhpbmsg
eW91J2xsIGdldCBhcm91bmQgdXNpbmcgcHJvcGVyIGxvY2tpbmcgaGVyZS4NCj4+DQo+Pj4gKw0K
Pj4+ICsgICAgICAgc2Nhbl9yZXEgPSAmaGlmX2Rydi0+dXNyX3NjYW5fcmVxOw0KPj4+ICsNCj4+
PiAgICAgICAgICAgaWYgKGllZWU4MDIxMV9pc19wcm9iZV9yZXNwKHJjdmRfaW5mby0+bWdtdC0+
ZnJhbWVfY29udHJvbCkpDQo+Pj4gICAgICAgICAgICAgICAgICAgb2Zmc2V0ID0gb2Zmc2V0b2Yo
c3RydWN0IGllZWU4MDIxMV9tZ210LA0KPj4+IHUucHJvYmVfcmVzcC52YXJpYWJsZSk7DQo+Pj4g
ICAgICAgICAgIGVsc2UgaWYgKGllZWU4MDIxMV9pc19iZWFjb24ocmN2ZF9pbmZvLT5tZ210LT5m
cmFtZV9jb250cm9sKSkNCj4+PiBAQCAtMTU3NCw2ICsxNTgwLDkgQEAgdm9pZCB3aWxjX25ldHdv
cmtfaW5mb19yZWNlaXZlZChzdHJ1Y3Qgd2lsYyAqd2lsYywNCj4+PiB1OCAqYnVmZmVyLCB1MzIg
bGVuZ3RoKQ0KPj4+ICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4+PiAgICAgICAgICAgfQ0K
Pj4+DQo+Pj4gKyAgICAgICBpZiAoIWhpZl9kcnYtPnVzcl9zY2FuX3JlcS5zY2FuX3Jlc3VsdCkN
Cj4+PiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4+ICsNCj4+IFRoaXMgaXMgYWxzbyByYWN5
LiBXaGF0IGlmIHNjYW5fcmVzdWx0IGlzIGNsZWFyZWQgcmlnaHQgYWZ0ZXIgdGhpcw0KPj4gY2hl
Y2s/IFRoZW4gdGhlIHdvcmsgaXRlbSB3aWxsIHN0aWxsIGdldCBhZGRlZCB0byB0aGUgd29yayBx
dWV1ZS4NCj4+DQo+PiBIZXJlIGlzIHRoZSBjYWxsIHRyZWU6DQo+Pg0KPj4gaXNyX2JoX3JvdXRp
bmUoKSBbaW50ZXJydXB0IHRocmVhZCBjdHhdDQo+PiAgICB3aWxjX2hhbmRsZV9pc3IoKQ0KPj4g
ICAgICBtdXRleF9sb2NrKGhpZl9jcykNCj4+ICAgICAgd2lsY193bGFuX2hhbmRsZV9pc3JfZXh0
KCkNCj4+ICAgICAgICAgIHdpbGNfd2xhbl9oYW5kbGVfcnhxKCkNCj4+ICAgICAgICAgICAgd2ls
Y193bGFuX2hhbmRsZV9yeF9idWZmKCkNCj4+ICAgICAgICAgICAgd2lsY193bGFuX2NmZ19pbmRp
Y2F0ZV9yeCgpDQo+PiAgICAgICAgICAgICAgd2lsY19uZXR3b3JrX2luZm9fcmVjZWl2ZWQoKQ0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIHdpbGNfZW5xdWV1ZV93b3JrKGhhbmRsZV9yY3Zk
X250d3JrX2luZm8pDQo+PiAgICAgIG11dGV4X3VubG9jayhoaWZfY3MpDQo+Pg0KPj4gaGFuZGxl
X3JjdmRfbnR3cmtfaW5mbyBbaGlmX3dvcmtxdWV1ZSBjdHhdDQo+PiAgICBpZiAoc2Nhbl9yZXN1
bHQpDQo+PiAgICAgIHNjYW5fcmVzdWx0KCkNCj4+DQo+PiB3aWxjX21hY19jbG9zZSgpIFtpb2N0
bCBjdHg/XQ0KPj4gICAgd2lsY19kZWluaXRfaG9zdF9pbnQoKQ0KPj4gICAgICB3aWxjX2RlaW5p
dCgpDQo+PiAgICAgICAgbXV0ZXhfbG9jayhkZWluaXRfbG9jaykNCj4+ICAgICAgICBpZiAoc2Nh
bl9yZXN1bHQpDQo+PiAgICAgICAgICBzY2FuX3Jlc3VsdCgpDQo+PiAgICAgICAgICBzY2FuX3Jl
c3VsdCA9IE5VTEwNCj4+ICAgICAgICBrZnJlZShoaWZfZHJ2KQ0KPj4gICAgICAgIGhpZl9kcnYg
PSBOVUxMDQo+PiAgICAgICAgbXV0ZXhfdW5sb2NrKGRlaW5pdF9sb2NrKQ0KPj4NCj4+IEkgZG9u
J3Qgc2VlIGFueSBzeW5jaHJvbml6YXRpb24gbWVjaGFuaXNtcywgYmV0d2VlbiB0aGVzZSB0aHJl
YWRzLg0KPj4NCj4+PiAgICAgICAgICAgbXNnID0gd2lsY19hbGxvY193b3JrKHZpZiwgaGFuZGxl
X3JjdmRfbnR3cmtfaW5mbywgZmFsc2UpOw0KPj4+ICAgICAgICAgICBpZiAoSVNfRVJSKG1zZykp
DQo+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4+DQo+Pj4gVGhlIGFib3ZlIGNoYW5n
ZXMgc2hvdWxkIGF2b2lkIHRoZSBrZXJuZWwgY3Jhc2ggZXhjZXB0aW9uLg0KPj4gQXMgbWVudGlv
bmVkIGFib3ZlLCBJIHRoaW5rIHRoaXMgd2lsbCBqdXN0IGRlY3JlYXNlIHRoZSBjaGFuY2UgdGhh
dA0KPj4gaXQgaXMgaGFwcGVuaW5nLiBOb25ldGhlbGVzcywgSSd2ZSB0cmllZCB5b3VyIGNoYW5n
ZXMgYnV0IGl0IGRvZXNuJ3QNCj4+IGZpeCB0aGUgY3Jhc2guDQo+IEFueSBuZXdzIGhlcmU/DQoN
Cg0KSGkgTWljaGFlbCwNCg0KDQpObyBwcm9ncmVzcyB5ZXQuIEkgdHJpZWQgdG8gc2ltdWxhdGUg
dGhlIGNvbmRpdGlvbiBhIGZldyB0aW1lcyBidXQgd2FzIA0KdW5hYmxlIHRvIHNlZSB0aGUgZXhh
Y3QgZmFpbHVyZSBpbiBteSBzZXR1cCBzbyBJIG5lZWQgdG8gdHJ5IG1vcmUuIEZvciANCnRoZSBv
dGhlciAiRlcgbm90IHJlc3BvbmRpbmciIGNvbnRpbnVvdXMgbG9ncywgSSBnb3Qgc29tZSBjbHVl
LiANClByb2JhYmx5LCB3aWxsIHRyeSB0byBzZW5kIHRoYXQgcGF0Y2ggZmlyc3QuDQoNClJlZ2Fy
ZHMsDQpBamF5DQo=
