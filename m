Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2D6936D0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Feb 2023 11:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBLKF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Feb 2023 05:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBLKF2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Feb 2023 05:05:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB6213D55
        for <linux-wireless@vger.kernel.org>; Sun, 12 Feb 2023 02:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676196327; x=1707732327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IO4YgifxrLuHfaGMC8SW1THBsxO5m5MFENvkj1iItg0=;
  b=SdbX0J0NqNXMpSkttn8a8ciFO5OsbCkpjjTkBNDg2abLrSTFDQHIwg7Y
   63pXYFGt5mODJLyabQr3QYNkV5dTCAhozDYo1U7RZ+Sdcs9iXTonueNVp
   N0pR3X6K6M5Oa/cdsjSopBEajBOsSGdW9l0zpMUvC8fvmb13JQrZ5a4iZ
   C5Iouv74fwWiipe7IAv7OepIJWKxHlhDwuKI3h6s75BW8vQskjGYJWil5
   X6A/9NPPDVMqcTxWgqAyHGUMEJjt+bJTM2zqmHfj37SEIn2IMZT897AZ5
   mKcSeT8lWCdZ8Qah8Kq0PQ/efVmNS8NBRkg1CsNj1/XBVf1s48OokJLqn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="311064727"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="311064727"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 02:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="913987488"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="913987488"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 12 Feb 2023 02:05:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 02:05:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 02:05:26 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 02:05:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWTYW/YUEbwCOr5GdPHwp+wBtMuFlEprKKGvWhKXAmR5jmmmi52m9dEHzN1HMhYUXST/TD/pGqQSr7qB1GbWSGpVFkXBeBRzxMn87w4OAyKmQDec+GrD+/WagLLIbvLNRVDefl66wwUmCoGD/ACteAalw39FTs9XmGVXwGApX1Ri8aO3L0gdM3US7PVC2gqXIg5zta6NcLLLlxSqOxMtdwgpuRP/J9mufU8mm5EdvYV2bP3Op6euh4Rh5toS521FIKDylgqQV1y1zI0i+qb2RGR2GhruCQUdL6JcRktpJPKFZiLttuvrbUFnup+apv1sgXFGfw9AzNO+LG8FkyqYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO4YgifxrLuHfaGMC8SW1THBsxO5m5MFENvkj1iItg0=;
 b=g0Z/DKXNSSlS/l+LKkxV+6dAfFKyccxEefGh4s7rPI2sw3BwPNvM19jKXo7Yaj2tTti7rJP6PuVYQ1TEIicADOPjn/+A2sYpBhxc7n6/cytSxvH1HqUi5vUlH+oO56PJdErO09kw/aKK9d4XP6xjz9cqiGezWym4L5C5ZvWMaXu47BpHVwr8jJ+VrVuB3ddIsXxI3qsqIQm2Y/9K6FXZQtDyrpvaunp5mB+UyDeMWKTOemrKmxyyMJYpJ3NhOiXcUv4QCknl9EeqNvBUx0T9v7OEcj68+ikP0DFqaXksl2bkYH88/aO1Q+IU39o6Wr29tNbRgd1uJMFXqESq9ZefAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 10:05:18 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c%9]) with mapi id 15.20.6086.023; Sun, 12 Feb 2023
 10:05:18 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "chaitanya.mgit@gmail.com" <chaitanya.mgit@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "egrumbach@gmail.com" <egrumbach@gmail.com>
Subject: Re: iwlwifi: Monitor mode broken with 6.1.0
Thread-Topic: iwlwifi: Monitor mode broken with 6.1.0
Thread-Index: AQHZLwXzIckaW/dU5EOJQ/UY52NzZa6r9wMAgAA1n4CAGqE1gIAEZx8A
Date:   Sun, 12 Feb 2023 10:05:18 +0000
Message-ID: <8648ceb22dace0ac7098fd4c8d11927c4df9f284.camel@intel.com>
References: <CABPxzY+_Mjercvvh5XHmtHdNCKXDupVbL4PKXgzZPiUesRsRMA@mail.gmail.com>
         <714df952bf0b0f53a2f7a6714083e93e39632f49.camel@intel.com>
         <CABPxzYKc58mqCjyy+rzbrhZm5wCRKUm1Vs=HiP9OVsVSO3DiKA@mail.gmail.com>
         <CABPxzYLhzNgM3pRZT1LuPMA_SWwOss12KZzF5+QEkKuOnazQ3A@mail.gmail.com>
In-Reply-To: <CABPxzYLhzNgM3pRZT1LuPMA_SWwOss12KZzF5+QEkKuOnazQ3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH0PR11MB7613:EE_
x-ms-office365-filtering-correlation-id: aa6747da-1be2-4a5e-29ea-08db0ce0a4dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0mhGSCoDh/Tj8pR3L4u8Iq9jMMk7uketx+nmXajgY0nLJFo5VMpmerj8k+G9d7kvHtdz2yIKSBls9OD0tzdoNAoc0dCp8jIr/Hx/ny1gRNBUI1cAhAm1mTPTT3Ti8qVoSPb1+l8FvIRaHr4TapiKqjgbgm0WRq7qMbfR/DMzlvfJXjTiFgusXbkS9hfVIo4mB9kXeKaK2ZROM1oEdGlbV7F4PC2qQUTp7XhtrTj3bjjydBcxA6KVoHulpkO1q0sdmEAt0cKgFnfU6c1t6fTLXAbFe8MuhmcicqrGbZbD+U9Nl47or4Nh6XU/GGP9ocwCwMHDJrYjzGo+9JAmcjUn2hHhmFp8qf42RFF1ckEMSV2dsV2eY1GJdBJV69I4X+YQpIRWomEmu7uZKD9e5d3rrOBRljTDgFy9KEzljAkj3LMn/mWCTLIk9ik9oQnCivUZRTgkbNWnQg6gQ4Ofgjn0584TeZCI3g6ykFRvK3CVHGWj84BIP/MRy/oFWMOLWTYbV8gYTPoovVaWOALgw/n12loeMnddUz95P/tdCkj7frQNwX4uLDKEUZkdjv0Iwzxy5KIXYg79bNbWqnYrQluAZhjfjCcnBtwNFsMCY6UTW677CG8Coy9rHy57OMIuz7j8OFdaWdeoh6+JUNgzeAH0pmGLUYcirQC0Y3DOBWCVgvTSL8PbpXhukg3Qc23+B7H+5DaYvG+WPRz7Jt0hcyJVHpeKNfiRqMz1U2bDMrLGDE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199018)(82960400001)(2616005)(6512007)(38100700002)(122000001)(54906003)(316002)(6486002)(71200400001)(478600001)(966005)(5660300002)(86362001)(186003)(26005)(53546011)(6506007)(83380400001)(8936002)(4326008)(36756003)(2906002)(8676002)(66476007)(6916009)(64756008)(38070700005)(66446008)(66946007)(66556008)(76116006)(91956017)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TElxZzhqWUd6RUpFTHh4YS94YlN2ZkYydERlQVVVdGxBQXlqTTdoWXZ3S1Zo?=
 =?utf-8?B?K1l0MlpobnlMaFkrZktXemhvNUJVK251eklUbFJtTEpXL1JvVjFJZGlQV24w?=
 =?utf-8?B?WkN6aS9rM1VqVHRYQVQ4NGgzZVptVmg3YmdUckNySVdSS0lHSmNrRzgwWEVJ?=
 =?utf-8?B?V3NWMzIvVVp4VnhqSDhoR0lLZkRpSkhDU0xxWkZMNEx1TUFneFl6YVg2eGN6?=
 =?utf-8?B?WU4zaVFJL2NBU0l4OVArU1hDamtqUkh2dCtsM0toZTdWUUVxUmpoZ2c0bkJz?=
 =?utf-8?B?R0c0TS9IMGdyYzJBWGN1MGRhOXl5amx1eTZKMFRZbGJPeEtjLzZiSjBZbnFn?=
 =?utf-8?B?VVJQZ3hMMGpDL3NXSUtqUUtGT3BHUnRUWUxmS1pCZWdFVjJrSWxZaVhLb1JH?=
 =?utf-8?B?dlpCMi9KS3hKRTRNYTlDWU9UVGhqMEo3RmlyZmdHNmVjYkQ1TXdSNGNLOFpy?=
 =?utf-8?B?NGVla0h2clUxcVVkZk5Fc3RSeTJRTDh3enYraXJpOVorbnJOWHVKaTFvN1l4?=
 =?utf-8?B?YlNPZ0hQNkF4K3ZFZFpkYjJGZ0JzbHpYMXJBbDUvZk8vVENFVzBxLzB3R1Zw?=
 =?utf-8?B?RE0rRlE1ZzF3aGFLUnhYWFVSMDNZd0M5NGtHNnY4aEdHMmx6Y1h4b2toYjd2?=
 =?utf-8?B?cUhzYjZzaVRXeXZJNThoNnU1d3FEQVdFOUw3cExsczdhQW9CUEtxU0FXUTFH?=
 =?utf-8?B?UFVkWDFUWFJKdzluMm1VUVRDdkRHT1d1UWIzTnlEd2JTV1hySmc0Wm1pZGFU?=
 =?utf-8?B?b3VNbDkzbm03R2J2ZUs2WUdreWJCQlEzcmx6MS9jQ1pTdmhKTVpQRnlxU1Nt?=
 =?utf-8?B?dytVVXU0NFRPWEZwV2tvNG8wTzRJSHlScW1SWlV2K3d1ekxCKzJXODJqZG1P?=
 =?utf-8?B?ZDhYSDI3bnQ5UEhReTBQUkVadVFuYk9uOHNrMFFjYkV3Z0JJMm4zazlRL1RH?=
 =?utf-8?B?QSs3Szk1aDBSV1BkR3NvTldpNVh3WmNmSS9iOC9JUlVMSjE1eXR0ZitKVEd5?=
 =?utf-8?B?QVAwVTloUWdvaFJSUnJqMTBlQ01ybjB4RG5Gb3VMdzNvV0dWcXdzRWU5STdE?=
 =?utf-8?B?cjRDY3h4dFBKNWxXT3VLWmFtektEKzZYV0w5VXJtY3NPNFBtRWYwTjV3dmVs?=
 =?utf-8?B?dWtSem1xN2VpdDZwWVJtdXl3VExDZFJOblNka3hWTzBhVTNHT2JXR2NVdDhq?=
 =?utf-8?B?M1JWTXpCc1dSZUlBSm5hN0NGN2RzaWdNeE5UT0Ftd0xCems2dEhlY3loajFi?=
 =?utf-8?B?Q0lrbG9qdGt5RzBQOEY2YzlhdEJ3cWw4NnpJL2F4VDNxL3VwMVN4U2c3NWl6?=
 =?utf-8?B?RUpQSnQwUVEra3o5WVh2eFhHZmZ2MW4zbTdlWUZXZmhwYktRRE9ZU0dJVFVH?=
 =?utf-8?B?ejBkNlZTR3lUejRIU28vMEg4ZXBjSFlhWTZteEdadmxTN1FnMzhYTDVYbUFY?=
 =?utf-8?B?ZTVXL3Q4RUpFZ3pHTnBobWV5aGNxTFFFU1daTU1xdC95ZmpTVlJKWnJ3ZW9O?=
 =?utf-8?B?aS9lWE00Ylk3SlZBMDdYVUJ2dlZTTGl5bmo2Skd3L3NYTE1TanlIUlBiYjlG?=
 =?utf-8?B?NDZWSkNZUlhDNGlEempDTUVlS2VWMnM5bFU1TWdVWUFFRDZnd1FjTXlZcG5P?=
 =?utf-8?B?ZnpmdkorTkQ3VW9oUzlKNkJHTE1lNWFJS3pXSXNpcXZMQVJOcGNTZGRPcDlZ?=
 =?utf-8?B?U28rY1N6NWgrczhxWUx3a1pCNUZPcHBzUEZnRDRjNU5nZEN3aDlya0VhenZq?=
 =?utf-8?B?OHNTc3ljRGVLZHRIdnQ2aE8xUjAwcUdTUDlhVnR0Y3QxNzJkVDc0VGp6MENJ?=
 =?utf-8?B?S2daaFA1T2Y2TXQzUVlVeVQ3ZVozNjlYb1d3bEhPcTdEN2p3NGM5dndPem9l?=
 =?utf-8?B?eUtra0V2Q3JjR2tSNU1XTlBMRGNIQU4rd2Q1VitVMzIzRDVMUnhXZG9GTER6?=
 =?utf-8?B?a1VjdUhCZkdhOURPMVo5QXJhNnUyM0tYaWoxcFhudEpyeFpZdUY4S2c4RktX?=
 =?utf-8?B?VTMycnNyMmJ5N2lJbDlQOGdweDB0YkJSUFlpenkwZ1VpQlA1bmVoQnMrNzhw?=
 =?utf-8?B?amNVOHBjWnNpN3BGZ0JuV2dkUjR3MzhtbXhCY1NPaktGR3VFZVp5ZmwvQVpq?=
 =?utf-8?B?ZDAxTytuZnA1UVp5QjRZN0Rkci82SGhSRXZBck9Ib2xWNUFabHVlaTZzcWxs?=
 =?utf-8?Q?JuF6dwRw6x7aLM4MTXGHoEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B6E5DDA432FE3469F80B1D62E82F359@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6747da-1be2-4a5e-29ea-08db0ce0a4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 10:05:18.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBmhrdyAODt8LyHp3AZ3bGmYbjT7hka8CkzHx/vNqeMBHf7zECvGcO5wEXDVj193/pvxjhD56vk7nfpT/Hhpf91+UDiHBiWOZ03dlSJaTFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTA5IGF0IDIwOjIxICswNTMwLCBLcmlzaG5hIENoYWl0YW55YSB3cm90
ZToNCj4gT24gTW9uLCBKYW4gMjMsIDIwMjMgYXQgOTo0MSBQTSBLcmlzaG5hIENoYWl0YW55YQ0K
PiA8Y2hhaXRhbnlhLm1naXRAZ21haWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIEph
biAyMywgMjAyMyBhdCA2OjI5IFBNIEdyZWVubWFuLCBHcmVnb3J5DQo+ID4gPGdyZWdvcnkuZ3Jl
ZW5tYW5AaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gSGkhDQo+ID4gPiANCj4gPiA+
IE9uIE1vbiwgMjAyMy0wMS0yMyBhdCAxNDowNyArMDUzMCwgS3Jpc2huYSBDaGFpdGFueWEgd3Jv
dGU6DQo+ID4gPiA+IEhpLA0KPiA+ID4gPiANCj4gPiA+ID4gSSBhbSB1c2luZyB0aGUgYXRoLmdp
dCAoZWE3MjZhOGQzMDVhIDogd2FzIHRlc3RpbmcgZXh0ZXJuYWwgQXRoZXJvcw0KPiA+ID4gPiBj
YXJkcykgKyBsaW51eC1maXJtd2FyZSAoYmIyZDQyZCkgYW5kIHRoZSBtb25pdG9yIG1vZGUgc3Rv
cHBlZCB3b3JraW5nDQo+ID4gPiA+IHdpdGggaXdsd2lmaS4gVGhlcmUgaXMgYSB3YXJuaW5nIGZy
b20gVUJTQU46ICJVQlNBTjoNCj4gPiA+ID4gc2hpZnQtb3V0LW9mLWJvdW5kcyBpbg0KPiA+ID4g
PiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jOjY1Nzoy
MiIuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgcm9vdCBjYXVzZSB3YXMgdGhpcyBjNmNlMWM3NGVm
MjkyIHdoaWNoIGRlZmF1bHRzIHRoZSBhc3NpZ25tZW50IHRvDQo+ID4gPiA+IDB4RkZGRiBhbmQg
dGhlbiB0aGF0IHdhcyBiZWluZyB1c2VkIGZvciB0aGUgc2hpZnQuDQo+ID4gPiA+IA0KPiA+ID4g
PiBJIGhhdmUgdHJpZWQgdG8gZml4IHRoZSB3YXJuaW5nIHdpdGggdGhlIGJlbG93IHBhdGNoIChq
dXN0IGZvciBhbg0KPiA+ID4gPiBleHBlcmltZW50LCBub3QgYSBwcm9wZXIgb25lKSwgdGhlIHdh
cm5pbmcgaXMgZ29uZSwgYnV0IG5vIGZyYW1lcyBhcmUNCj4gPiA+ID4gc2VlbiBpbiBXaXJlc2hh
cmsuDQo+ID4gPiA+IA0KPiA+ID4gPiBCZWxvdyBpcyB0aGUgdmVyc2lvbiBpbmZvcm1hdGlvbiwg
YW55IGhlbHAgaXMgYXBwcmVjaWF0ZWQsIG1vbml0b3INCj4gPiA+ID4gbW9kZSBpcyBpbXBvcnRh
bnQgZm9yIG1lLg0KPiA+ID4gPiANCj4gPiA+ID4gbHNwY2k6IE5ldHdvcmsgY29udHJvbGxlcjog
SW50ZWwgQ29ycG9yYXRpb24gV2ktRmkgNiBBWDIwMSAocmV2IDIwKQ0KPiA+ID4gPiANCj4gPiA+
ID4gW8KgICswLjAwMzc5MF0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IGFwaSBmbGFncyBpbmRleCAy
IGxhcmdlciB0aGFuDQo+ID4gPiA+IHN1cHBvcnRlZCBieSBkcml2ZXINCj4gPiA+ID4gW8KgICsw
LjAwMDA0Nl0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IFRMVl9GV19GU0VRX1ZFUlNJT046IEZTRVEg
VmVyc2lvbjoNCj4gPiA+ID4gODkuMy4zNS4zNw0KPiA+ID4gPiBbwqAgKzAuMDAxNTE5XSBpd2x3
aWZpIDAwMDA6MDA6MTQuMzogbG9hZGVkIGZpcm13YXJlIHZlcnNpb24NCj4gPiA+ID4gNzIuZGFh
MDUxMjUuMCBRdVotYTAtaHItYjAtNzIudWNvZGUgb3BfbW9kZSBpd2xtdm0NCj4gPiA+ID4gW8Kg
ICswLjAzNDg4N10gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IERldGVjdGVkIEludGVsKFIpIFdpLUZp
IDYgQVgyMDENCj4gPiA+ID4gMTYwTUh6LCBSRVY9MHgzNTENCj4gPiA+ID4gW8KgICswLjAwMDA4
M10gdGhlcm1hbCB0aGVybWFsX3pvbmU3OiBmYWlsZWQgdG8gcmVhZCBvdXQgdGhlcm1hbCB6b25l
ICgtNjEpDQo+ID4gPiA+IFvCoCArMC4xMjIxNDRdIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBEZXRl
Y3RlZCBSRiBIUiBCMywgcmZpZD0weDEwYTEwMA0KPiA+ID4gPiBbwqAgKzAuMDY1NzAxXSBpd2x3
aWZpIDAwMDA6MDA6MTQuMzogYmFzZSBIVyBhZGRyZXNzOiA0Yzo3OTo2ZTo5MDo5NDo3MQ0KPiA+
ID4gPiBbwqAgKzAuMDE5ODI2XSBpd2x3aWZpIDAwMDA6MDA6MTQuMyB3bHAwczIwZjM6IHJlbmFt
ZWQgZnJvbSB3bGFuMA0KPiA+ID4gPiBbICsxNC4yMTA5ODddIGRldmljZSBtb24wIGVudGVyZWQg
cHJvbWlzY3VvdXMgbW9kZQ0KPiA+ID4gPiBbSmFuMjQgMTg6MjBdIGRldmljZSBtb24wIGxlZnQg
cHJvbWlzY3VvdXMgbW9kZQ0KPiA+ID4gPiANCj4gPiA+ID4gLS0tDQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jDQo+
ID4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQu
Yw0KPiA+ID4gPiBpbmRleCA4M2FiZmU5OTYxMzguLjU5MWY5ZmRkMGVjNCAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQu
Yw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9t
YWMtY3R4dC5jDQo+ID4gPiA+IEBAIC02NTQsOSArNjU0LDEzIEBAIHN0YXRpYyBpbnQgaXdsX212
bV9tYWNfY3R4dF9jbWRfbGlzdGVuZXIoc3RydWN0DQo+ID4gPiA+IGl3bF9tdm0gKm12bSwNCj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIGFjdGlvbikNCj4gPiA+ID4gwqB7DQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpd2xfbWFjX2N0eF9jbWQgY21kID0ge307DQo+
ID4gPiA+IC3CoMKgwqDCoMKgwqAgdTMyIHRmZF9xdWV1ZV9tc2sgPSBCSVQobXZtLT5zbmlmX3F1
ZXVlKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCB1MzIgdGZkX3F1ZXVlX21zayA9IDA7DQo+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+ID4gPiA+IA0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgIGlmIChtdm0tPnNuaWZfcXVldWUgIT0gSVdMX01WTV9JTlZBTElEX1FVRVVFKSB7DQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRmZF9xdWV1ZV9tc2sgPSBCSVQobXZt
LT5zbmlmX3F1ZXVlKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCB9DQo+ID4gPiA+ICsNCj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqAgV0FSTl9PTih2aWYtPnR5cGUgIT0gTkw4MDIxMV9JRlRZUEVfTU9O
SVRPUik7DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpd2xfbXZtX21hY19jdHh0
X2NtZF9jb21tb24obXZtLCB2aWYsICZjbWQsIE5VTEwsIGFjdGlvbik7DQo+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9zdGEuYw0KPiA+
ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3N0YS5jDQo+ID4g
PiA+IGluZGV4IDUxNWRkM2UwNzMwZC4uNzg0YTdmNzJiODE5IDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9zdGEuYw0KPiA+ID4gPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9zdGEuYw0KPiA+ID4g
PiBAQCAtMjA4NCw2ICsyMDg0LDcgQEAgc3RhdGljIGludCBpd2xfbXZtX2FkZF9pbnRfc3RhX3dp
dGhfcXVldWUoc3RydWN0DQo+ID4gPiA+IGl3bF9tdm0gKm12bSwgaW50IG1hY2lkeCwNCj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiA+ID4gDQo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqcXVldWUgPSB0eHE7DQo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YS0+dGZkX3F1ZXVlX21zayA9IEJJVCgqcXVldWUp
Ow0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsNCj4gPiA+ID4gQEAgLTIwOTIsMTEgKzIwOTMsMTUgQEAgc3RhdGljIGlu
dA0KPiA+ID4gPiBpd2xfbXZtX2FkZF9pbnRfc3RhX3dpdGhfcXVldWUoc3RydWN0IGl3bF9tdm0g
Km12bSwgaW50IG1hY2lkeCwNCj4gPiA+ID4gwqBpbnQgaXdsX212bV9hZGRfYXV4X3N0YShzdHJ1
Y3QgaXdsX212bSAqbXZtLCB1MzIgbG1hY19pZCkNCj4gPiA+ID4gwqB7DQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgIGludCByZXQ7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgdTMyIHRmZF9xdWV1ZV9t
c2sgPSAwOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgbG9ja2RlcF9hc3NlcnRf
aGVsZCgmbXZtLT5tdXRleCk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKG12bS0+YXV4X3F1
ZXVlICE9IElXTF9NVk1fSU5WQUxJRF9RVUVVRSkgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0ZmRfcXVldWVfbXNrID0gQklUKG12bS0+YXV4X3F1ZXVlKTsNCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoCB9DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCAvKiBB
bGxvY2F0ZSBhdXggc3RhdGlvbiBhbmQgYXNzaWduIHRvIGl0IHRoZSBhdXggcXVldWUgKi8NCj4g
PiA+ID4gLcKgwqDCoMKgwqDCoCByZXQgPSBpd2xfbXZtX2FsbG9jYXRlX2ludF9zdGEobXZtLCAm
bXZtLT5hdXhfc3RhLCBCSVQobXZtLT5hdXhfcXVldWUpLA0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
IHJldCA9IGl3bF9tdm1fYWxsb2NhdGVfaW50X3N0YShtdm0sICZtdm0tPmF1eF9zdGEsIHRmZF9x
dWV1ZV9tc2ssDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTkw4MDIxMV9JRlRZUEVfVU5T
UEVDSUZJRUQsDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVdMX1NUQV9BVVhfQUNUSVZJ
VFkpOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gDQo+ID4gPiBUaGlz
IGJ1ZyB3YXMgYWxyZWFkeSBmaXhlZCBpbiBvdXIgaW50ZXJuYWwgcmVwb3NpdG9yeS4gWW91IGNh
biB1c2UgdGhlIGRyaXZlciBmcm9tIFsxXQ0KPiA+ID4gdW50aWwgdGhpcyBmaXggd2lsbCBtYWtl
IGl0J3Mgd2F5IHRvIHRoZSB1cHN0cmVhbSAocGxlYXNlIHVzZSBtYXN0ZXIgYnJhbmNoKS4NCj4g
PiA+IA0KPiA+ID4gWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2l3bHdpZmkvYmFja3BvcnQtaXdsd2lmaS5naXQNCj4gPiBFeGNlbGxlbnQsIHRoYW5r
cyBmb3IgdGhlIHJlcGx5Lg0KPiA+IA0KPiA+IFRoZSBkcml2ZXIgaW4gWzFdIHdhcyBub3QgYnVp
bGRpbmcgZHVlIHRvIDIwYjBiNTNhY2E0MzYgYnV0IGl0IHdhcyBzaW1wbGUNCj4gPiB0byBmaXgs
IGFmdGVyIGluc3RhbGxhdGlvbiAoYW5kIHJlYm9vdCkgdGhlIHdhcm5pbmcgaXMgZ29uZSwgYnV0
IHN0aWxsDQo+ID4gdW5hYmxlIHRvIHNuaWZmLg0KPiA+IA0KPiA+IEZXIGlzIG5vdyB1cGRhdGVk
IHRvOg0KPiA+IGxvYWRlZCBmaXJtd2FyZSB2ZXJzaW9uIDc3LjJkZGE4ODBkLjAgUXVaLWEwLWhy
LWIwLTc3LnVjb2RlIG9wX21vZGUgaXdsbXZtDQo+IEFueSBpZGVhcyB3aHkgaXQgc3RpbGwgZG9l
c24ndCB3b3JrPyBTaG91bGQgSSB0cnkgc29tZXRoaW5nIGVsc2UsDQo+IHBsZWFzZSBzdWdnZXN0
Lg0KDQpXZSdsbCB0cnkgdG8gcmVwcm9kdWNlIGl0IGludGVybmFsbHksIGlmIGl0J2xsIHdvcmsg
Zm9yIHVzLCBJJ2xsIGFzayBmb3Igc29tZSBkZWJ1ZyBkYXRhLg0KQ2FuIHlvdSBwbGVhc2Ugb3Bl
biBhIG5ldyB0aWNrZXQgaW4gYnVnemlsbGEsIHNvIGl0J2xsIGJlIGVhc2llciBmb3IgdXMgdG8g
dHJhY2s/DQpIZXJlIGlzIHRoZSB3aWtpIHBhZ2UgcmVnYXJkaW5nIGJ1Z3ppbGxhIGZvciBpd2x3
aWZpOg0KaHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vdXNlcnMvZHJpdmVycy9p
d2x3aWZpL2RlYnVnZ2luZw0KIA0K
