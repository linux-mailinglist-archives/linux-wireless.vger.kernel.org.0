Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084666FD32D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 01:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjEIX4t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 19:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjEIX4s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 19:56:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1945A123;
        Tue,  9 May 2023 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683676606; x=1715212606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cJnaw4HBqgV8MjQNphGQQhob43lhqhGdYIUs10A4D/U=;
  b=FBLoPjqkc/L8R3uAoPErlQyCFS/Sdl2GhsdbX7HvpQsdkcQb3K4K+ZwB
   pf8riS3T66kwJhk4bArjd+CYHoUOtSq56OtARtz6yXhFgi3pPhh5ysBLo
   pFKO6juas+cj67t73SJ39PLP/L7v9LV1cH8WgA42BhhEB14X0fOF2DLJ8
   XjoSMVgPu7UPfZgVMMDH9KHEFsHqB5w219RoLL62upUKtiNw9DRkY5qf9
   47tjW2fEKTaN/zBrwoLVhUqkjw+J2GAPciTyKv6D8ZZSc09I4EqgMQ4NT
   I/Y65bVfOxyOrqEMjDfNGavRAQKAQYZlWkd5v+ow5tl5ue1p/8TIkztxf
   w==;
X-IronPort-AV: E=Sophos;i="5.99,263,1677567600"; 
   d="scan'208";a="213191384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2023 16:56:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 9 May 2023 16:56:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 9 May 2023 16:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEbTUsyqZ8uj8pOHE3K+O9ijeLFirrtoaMwUGIuMFe6n772h6qPHHBg8vm/7o/uxzVP5xF6h89SDDP3hEAPy0/763J+ZC2Dyv75ygDE+QkU2dIq6Ee9h2rmdb1Pq42fK9CDO2AuVovQOiFNEtuOPq0Kaz4YMFko281efjrhcWFxvjtqaVhGZGgq5WQ/ec0eAxfxetvUCUpGMT/ptmGJ5XtYE7qxUeixeHedsnoZWp6edFe37/AsrzJbo+9STKop0ff/tesGXPToUyF9q6y+WBddwlf2akoxe1xBDgJ4/eJsU01QWbbb/9Hsrj66TaN6oGqfpW4k70L5xmgl9+HiBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJnaw4HBqgV8MjQNphGQQhob43lhqhGdYIUs10A4D/U=;
 b=OeI+QI9TMz3eBdqdGmxGf7tQ4JqdTtutXlnWzJBeuHWsP5qgbW7mTCraS4lGXVljHDrFwrqIN9MIgG3QcM8tnnJ6dk3g/210Ose8FTtmyGUZmHzn2LnoLDuqcrdVtgOfHWMiKy/Hw9Z+ROBJyxo1ounAZD5YmDkPjfSOn+6N9Wc8xdoSCzIXH//oBtW65NWvgoGuTnVT6jorJ3ADLTU7BNeoMbG3Qg5fF9Jc0G8kCFuuM104M7gx/KeGac7vIUHcOVS09/q7nriPVEbIREZtn2joIc+Hheaq+mSgIEN9rQ4Hfzdqz2iBzbRGgGJf5RU9bqQvjNN3icYK2HJ1UVFeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJnaw4HBqgV8MjQNphGQQhob43lhqhGdYIUs10A4D/U=;
 b=vvz0MhsPWtRhGsOPnWvSUz/ZKpnGUuMR5WLqlqzUab9IULresis3Wf2Ps7Cljnrvvm/8h36hpk8PiojIkH4rfrkORNGVnpiVeOgO3cEWvlsJkz9sp5IF6FMo4wW06Oitz2RLbh3briS78cBqEWs5rRZNqiRVyBjRtDXZkMy7h+8=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BL1PR11MB6028.namprd11.prod.outlook.com (2603:10b6:208:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 23:56:42 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::30d9:173b:e580:28c6]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::30d9:173b:e580:28c6%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 23:56:42 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <stable@vger.kernel.org>,
        <mwalle@kernel.org>
Subject: Re: [PATCH v2] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Topic: [PATCH v2] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Index: AQHZf6tOCZz1EGCoL0mIVwhtQSxjP69MvoaAgAXl7YA=
Date:   Tue, 9 May 2023 23:56:42 +0000
Message-ID: <d21e41f4-c3b2-ea06-687b-bf188e74abeb@microchip.com>
References: <20230505232902.22651-1-ajay.kathat@microchip.com>
 <2023050645-vaguely-unruffled-fd81@gregkh>
In-Reply-To: <2023050645-vaguely-unruffled-fd81@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|BL1PR11MB6028:EE_
x-ms-office365-filtering-correlation-id: e738391e-0253-475f-125c-08db50e909de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yg7vE2hscGFkocEUVgGaRS06L8r47RB/H8BGCRQRneYjRuoNqsX7GLluA0OK3f0OEBCj3KnMdlrBs4MUYmIyK/z8WXQcRvjLxrsurt1r3U8/N3aJxuCl3S7+qgB1FXnlmqTa7EMSJpUl/yFZc+GnYsLGHja9bQUsZJ9EsYe/FdgAG0sUzzG+Xganha/IE80wbx7lHxlBxU8EkI9pDVeod0bWNhxJeV7YkwpemldWvnh8UMAw23vJ6/bhlnJ42g2xTl7LNxky/js3kgk43nWQnzoIS3sZAtwFBqZDir8r4GECmOdKKs43sCb/YA2eQhrkUixMkvAHVJJzWrpf6gozDLQuwdTHU3kW35sFocBV1/SxOglxGexrAKHpso2HVBgxnn8BQLy9usxULYbfqZKbCkeW5NZd5JAUgJnlq27vmUKKhEtvz7OonV6TjzaafeWWfMYoK+HxBooMHT8g6Mc1zQuk7HIpjmL6rjtmx3Z5cgSpmVmYd0QmPFNoqS7P6HXDH7hpuoIf7qX2ClVSa75Osow7ngHBCT8XZFoh3S3F/KQs4OIddnNJjOlCsw94MADcdB16j5XOqHMijwMN/+0NHm2pTaLNuV5tpa5WWGWWW4is5a86j+FQAKWn/NW7DD/apxAFLPLCKMFPnHIsnx6frUNC/Vx+6UDOfOljn+Fsukw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(186003)(2616005)(2906002)(83380400001)(38070700005)(36756003)(38100700002)(86362001)(31696002)(122000001)(71200400001)(5660300002)(66446008)(8676002)(966005)(8936002)(66946007)(64756008)(66476007)(4326008)(6916009)(66556008)(76116006)(41300700001)(6486002)(478600001)(31686004)(316002)(54906003)(6506007)(6512007)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkRTenF5Qkp5VTFUR242N09nb2xGM3ZWbFVwL1BNRWRxazczZ3hLU0RnTlU4?=
 =?utf-8?B?a09xalp6U3Q3WVZkeGtIR2FwQTFCU2JXdkFSdGI5TjBKV1k2VmVEMU9pbERj?=
 =?utf-8?B?RUs2QmdpOU9Wb2tGYmIwU1VweTdsbC9kdVVieDN6ZS9rNEVObVkzUFlPVEVQ?=
 =?utf-8?B?TlJMd0VocEZycHl3T0RpWTdTWTdYbC9iOEFVL3RtY1hVcC9uaUlrVTZEZjlL?=
 =?utf-8?B?T292QmxvVGk3TWFsM1VuYzd3OVlPT3g1OTNwdUtsNVFVMElxUENmVW9iZmhv?=
 =?utf-8?B?SDg1eFA1ak9pVllqY2dkejRpeDd4NnE5V3FXdjN0akd2bWEyREtlb0JBSFdn?=
 =?utf-8?B?bmo3aytOVjU5akhQRjNNcEllT3NZTUtYL3F1OXN4eVY1aVNlWDN1RWtoaDli?=
 =?utf-8?B?RGdPMFBDZnMxMUE3VnpIVUdROW1VN0dqNWZ4b05wY1hXaHdLeTNvRkxVZktj?=
 =?utf-8?B?aC96SkxGWXJNU2pBYWM4QmttRFRkK1hhVkxHamROSmx0UGJvQ2FEWlJsdlFC?=
 =?utf-8?B?a2Q5eTZ6WmlaeFZ0cXB0eXlhY1F1QWdOUDJvV1FueGpYRGNabGlFdWdlK1Fz?=
 =?utf-8?B?V3llWTJKZk5nUyt0RlZJTWtsMDE3UFNabE5kMEdwc0h6RExKNllKMTM1QldB?=
 =?utf-8?B?VkFHeHFmUCtaT3lsQW1WaDdqRi93TWd4NGNmY1BiZTNieUQzYXptanErd1hM?=
 =?utf-8?B?ZUpKdnpQSnhuQzhmUXZ3T3lMYkhjRXoyaUxPUzlYbldhOStENHEyQmxzL2da?=
 =?utf-8?B?VlNHcEkzeGgyUDhXT0hOMExtdnhNZS9LMW5Lait1eS9DLzJha0xMZmM0SE1Q?=
 =?utf-8?B?VHplZ1R1NjhhK2d4UXhDeGw2cjNIVzNYcWIvRGU0d0RHbzNlc0R0UEI4UmhD?=
 =?utf-8?B?MWJaKy9aU2hDSEdzbTVGZTd3TXhjR2JxYVorc3NCcjBRQXpDOXFBS1R2NnR3?=
 =?utf-8?B?bHBvYUthc1hPelp6V2xYKzNuV1d4Q2hPK0ZPcVJDWTBVOWlvTENDS2dSa2ZC?=
 =?utf-8?B?TndERkJaRWF0ejY4R1gzR0FDRGpaWVdQS2crbER1eXVXbU40LzdxMjJ2eUww?=
 =?utf-8?B?ZmNvMDNYL1NUUkNoVFBtZkx0MnlqazQvSm1Oc3czUS9ZVnkrTDE3RkVOdDY2?=
 =?utf-8?B?c05FRVo0THIxMHJPUk1KYksvbFVzVWMzRVFTNXJhaXhDcG1FUFdWMWxNTVhz?=
 =?utf-8?B?blhxUU5ZSUJadVRwdWxiYkJaZmZZaXIvTlBVVEVBZWFqVGhhQkUrM1FnQVIy?=
 =?utf-8?B?dG1iQmllSWFMR0xjeVZTTW96dUlDUENhQkRiNjBKTUgzbEQ0T0luUVMybmF2?=
 =?utf-8?B?NitRbWpRMlJTNitrcmNVV2Y4MXllNmd5Y1dBSWNXS24vRTM5djU3RGZDajJs?=
 =?utf-8?B?VEJReFdwN2lpTHZpRFdCY2pSUzhBWXVNQ0sxTFpYVWJYNUxwZDVKTVBJdGVU?=
 =?utf-8?B?SzgreXN5dUZ1RUU4K0VNRWdFQVI5S2lMVWhSVnE1UDlCV0xrQlJYL2pCeUdm?=
 =?utf-8?B?SWlJb3RPVU5ZemwyemJGdEVJM3U5WkhvMXlBejVkNGplK0Y4VzdsZzczbHFz?=
 =?utf-8?B?TCtxM2xhNTYwd1YxVkpEaDNsNDAvV05MZzR2UWkzMjR4M1FKNUcyc01kT0Jr?=
 =?utf-8?B?THM4RFpFU0JJalY0T2t5S2ZoUWFMN0x5bXlsSTZEdzAzWUJOQXNKT3ZpNnlX?=
 =?utf-8?B?MFNRYXZ4NHFEcEsyeENqbjNmaEpxREdBWlhpMmtYYXRtZzBFVGZmTWxEdnBC?=
 =?utf-8?B?R0M1WmxWSHkvajJPTFdIWHZlWTZlNktIeGJBY1cyUk9sWE05bXFyVG80dkpH?=
 =?utf-8?B?enRFWVVsS1U1M3NicTVwNmpNaUhnNWFIS2MwaXRkRjc1V2YxcGhuOW43MVdk?=
 =?utf-8?B?YU1FMFhhRjdITWhUQlN4VGFzTjcwK2tYTGlJT3cvb1hXTlFUK1VkN1pjRWd0?=
 =?utf-8?B?Sng1MnViYy9LeEhxNjBXNnFMUzhEdDJHdExiSG5BOHdoekdLZDFwclUyRWxs?=
 =?utf-8?B?MDNkYUJYZ0lrdlZHcFRLUWZDWVdMaFhEc0MxcmZEQW92ai9NTEpZSXVCL2ZH?=
 =?utf-8?B?OURpaG1mL3REQ0hiTlp6ZStWTTNPRWNQMDdPOHhnb3pmTm1SUzlGSWVpZ1VU?=
 =?utf-8?Q?HBStRMx1KjyNV0DWfF0/2aoF5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F6ED195181E6443A26B0FE2DB553EFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e738391e-0253-475f-125c-08db50e909de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 23:56:42.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsCEDs3WY4KkNlNsjRK0e6fGpvUpFzgCpNuCSQWEPJpPJrXXaJIuLALVMuD6mKuXEnxaCJsKjTdn8kjnizP1pQAZg9AZOckvjSv/HVKv1do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6028
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgR3JlZywNCg0KT24gNS81LzIzIDIyOjUyLCBHcmVnIEtIIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwgTWF5IDA1LCAyMDIzIGF0IDEx
OjQyOjUxUE0gKzAwMDAsIEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGaXgg
Zm9yIGtlcm5lbCBjcmFzaCBvYnNlcnZlZCB3aXRoIGZvbGxvd2luZyB0ZXN0IHByb2NlZHVyZToN
Cj4+ICAgd2hpbGUgdHJ1ZTsNCj4+ICAgICBkbyBpZmNvbmZpZyB3bGFuMCB1cDsNCj4+ICAgICBp
dyBkZXYgd2xhbjAgc2NhbiAmDQo+PiAgICAgaWZjb25maWcgd2xhbjAgZG93bjsNCj4+ICAgZG9u
ZQ0KPj4NCj4+IER1cmluZyB0aGUgYWJvdmUgdGVzdCBwcm9jZWR1cmUsIHRoZSBzY2FuIHJlc3Vs
dHMgYXJlIHJlY2VpdmVkIGZyb20gZmlybXdhcmUNCj4+IGZvciAnaXcgc2NhbicgY29tbWFuZCBn
ZXRzIHF1ZXVlZCBldmVuIHdoZW4gdGhlIGludGVyZmFjZSBpcyBnb2luZyBkb3duLiBJdA0KPj4g
d2FzIGNhdXNpbmcgdGhlIGtlcm5lbCBvb3BzIHdoZW4gZGVyZWZlcmVuY2luZyB0aGUgZnJlZWQg
cG9pbnRlcnMuDQo+Pg0KPj4gRm9yIHN5bmNocm9uaXphdGlvbiwgJ21hY19jbG9zZSgpJyBjYWxs
cyBmbHVzaF93b3JrcXVldWUoKSB0byBibG9jayBpdHMNCj4+IGV4ZWN1dGlvbiB0aWxsIGFsbCBw
ZW5kaW5nIHdvcmsgaXMgY29tcGxldGVkLiBBZnRlcndhcmRzICd3aWxjLT5jbG9zZScgZmxhZw0K
Pj4gd2hpY2ggaXMgc2V0IGJlZm9yZSB0aGUgZmx1c2hfd29ya3F1ZXVlKCkgc2hvdWxkIGF2b2lk
IGFkZGluZyBuZXcgd29yay4NCj4+IEFkZGVkICd3aWxjLT5jbG9zZScgY2hlY2sgaW4gd2lsY19o
YW5kbGVfaXNyKCkgd2hpY2ggaXMgY29tbW9uIGZvcg0KPj4gU1BJL1NESU8gYnVzIHRvIGlnbm9y
ZSB0aGUgaW50ZXJydXB0cyBmcm9tIGZpcm13YXJlIHRoYXQgaW50dXJucyBhZGRzIHRoZQ0KPj4g
d29yayBzaW5jZSB0aGUgaW50ZXJmYWNlIGlzIGdldHRpbmcgY2xvc2VkLg0KPj4NCj4+IEFsc28s
IHJlbW92ZWQgaXNyX3VoX3JvdXRpbmUoKSBhcyBpdCdzIG5vdCBuZWNlc3NhcnkgYWZ0ZXIgJ3ds
LT5jbG9zZScgY2hlY2sNCj4+IGlzIGFkZGVkIGluIHdpbGNfaGFuZGxlX2lzcigpLiBTbyBub3cg
dGhlIGRlZmF1bHQgcHJpbWFyeSBoYW5kbGVyIHdvdWxkIGJlDQo+PiB1c2VkIGZvciB0aHJlYWRl
ZCBJUlEuDQo+Pg0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFJlcG9ydGVkLWJ5
OiBNaWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4NCj4+IExpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjIxMDI0MTM1NDA3Ljd1ZG8zZHdsM21xeXYy
eWpAMDAwMi4zZmZlLmRlLw0KPj4gU2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8YWpheS5rYXRo
YXRAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGNoYW5nZXMgc2luY2UgdjE6DQo+PiAgIC0g
dXBkYXRlZCBjb21taXQgZGVzY3JpcHRpb24gYW5kIGluY2x1ZGVkICdMaW5rOicgdGFnDQo+PiAg
IC0gdXNlIGF0b21pY190IHR5cGUgZm9yICdjbG9zZScgdmFyaWFibGUNCj4+ICAgLSBzZXQgY2xv
c2Ugc3RhdGUgYWZ0ZXIgY2xlYXJpbmcgb25nb2luZyBzY2FuIG9wZXJhdGlvbg0KPj4gICAtIG1h
a2UgdXNlIG9mIGRlZmF1bHQgcHJpbWFyeSBoYW5kbGVyIGZvciB0aHJlYWRlZF9pcnENCj4+ICAg
LSBhdm9pZCBmYWxzZSBmYWlsdXJlIGRlYnVnIG1lc3NhZ2UgZHVyaW5nIG1hY19jbG9zZQ0KPj4N
Cj4+ICAuLi4vd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2NmZzgwMjExLmMgICAgfCAgMiAr
LQ0KPj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuYyB8ICAy
ICstDQo+PiAgLi4uL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmMgIHwg
MzMgKysrKysrLS0tLS0tLS0tLS0tLQ0KPj4gIC4uLi9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL25ldGRldi5oICB8ICAyICstDQo+PiAgLi4uL25ldC93aXJlbGVzcy9taWNyb2NoaXAv
d2lsYzEwMDAvd2xhbi5jICAgIHwgIDMgKysNCj4+ICA1IGZpbGVzIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvY2ZnODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9jZmc4MDIxMS5jDQo+PiBpbmRleCBiNTQ1ZDkzYzZl
MzcuLmE5MGE3NTA5NDQ4NiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21p
Y3JvY2hpcC93aWxjMTAwMC9jZmc4MDIxMS5jDQo+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvY2ZnODAyMTEuYw0KPj4gQEAgLTQ2MSw3ICs0NjEsNyBAQCBz
dGF0aWMgaW50IGRpc2Nvbm5lY3Qoc3RydWN0IHdpcGh5ICp3aXBoeSwgc3RydWN0IG5ldF9kZXZp
Y2UgKmRldiwNCj4+ICAgICAgIGlmICghd2lsYykNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU87DQo+Pg0KPj4gLSAgICAgaWYgKHdpbGMtPmNsb3NlKSB7DQo+PiArICAgICBpZiAoYXRvbWlj
X3JlYWQoJndpbGMtPmNsb3NlKSkgew0KPiANCj4gV2hhdCBoYXBwZW5zIGlmIHRoaXMgY2hhbmdl
cyByaWdodCBhZnRlciB5b3UgcmVhZCBmcm9tIHRoaXM/DQo+IA0KDQpZZWFoLCB0aGVyZSBpcyBh
IHBvc3NpYmxlIHJhY2UgY29uZGl0aW9uIGJldHdlZW4NCidjZmc4MDIxMV9vcHMtPmRpc2Nvbm5l
Y3QoKScgYW5kICduZG9fc3RvcCgpJy4gVGhlIGFib3ZlIGNoZWNrIGlzIG5vdA0KZW5vdWdoIHRv
IGhhbmRsZSB0aGF0IHNjZW5hcmlvLiBGb3IgdGhhdCwgSSB0aG91Z2h0IG9mIHVzaW5nIGEgbG9j
aw0KYmV0d2VlbiAnd2lmaSBkaXNjb25uZWN0JyBhbmQgJ2ludGVyZmFjZSBjbG9zZScgdG8gc2Vy
aWFsaXplIHRoZSBhY2Nlc3MNCmFuZCBzdWJtaXQgaXQgaW4gYSBzZXBhcmF0ZSBwYXRjaChtYXli
ZSBJIGNhbiBhZGQgYSBwYXRjaCBmb3IgdGhhdCBhcw0KcGF0Y2ggc2VyaWVzKS4gSG93ZXZlciwg
dGhpcyBwYXRjaCBoZWxwcyB0byByZXNvbHZlIHRoZSBpc3N1ZSB3aGljaCB3YXMNCnJlcG9ydGVk
IGluIHRoZSB0ZXN0IHByb2NlZHVyZS4gQnkgc2V0dGluZyB0aGUgJ2Nsb3NlJyBzdGF0ZQ0KY29y
cmVjdGx5KGkuZSBiZWZvcmUgZmx1c2hpbmcgdGhlIHdvcmtxdWV1ZSkgdGhlIG5ldyB3b3JrIGRv
ZXNuJ3QgZ2V0DQphZGRlZCBmb3IgcHJvY2Vzc2luZyB3aGVuIHRoZSBpbnRlcmZhY2UgaXMgZ29p
bmcgZG93bi4NCg0KDQo+IERvbid0IHJlaW1wbGVtZW50IGxvY2tzIG9uIHlvdXIgb3duLCB1c2Ug
YSByZWFsIG9uZSBwbGVhc2UuDQoNClN1cmUsIEkgd2lsbCB3b3JrIG9uIHVwZGF0aW5nIHRoZSBw
YXRjaCB1c2luZyBhIGxvY2sgYmV0d2Vlbg0KJ2Rpc2Nvbm5lY3QoKScgJiAnbmRvX3N0b3AoKScu
DQoNCg0KUmVnYXJkcywNCkFqYXkNCg0K
