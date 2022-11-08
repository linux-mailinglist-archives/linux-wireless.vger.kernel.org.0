Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2B621ACB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiKHRfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 12:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiKHRfa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 12:35:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A4165B5
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667928929; x=1699464929;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=OLtENLziaFjD0YvMx1JlMF26W5x8nvhrrIVVGGB9uwI=;
  b=EGLxDqUWkaClPPcmE4lk+p2n97pik+BGWRfEmnA4aL/lrUOMO5vGjYH5
   gApEmGteJQTMs8emO4jRDIpeulqE6YCY5F143OFN+JytcoD3t+J3EsOZt
   1quft/aQVAbopbuGMGabeRw3kzC1vr8kxJ5fJVs4SUNXuuwThbjaCw8MY
   rfM1RQTdg9zsfL0tg2lclL67dIEfI/gCI7DMJC2Oi1jrBOixEPASnnwfM
   NYgPwg/DRTLnnGb2FH7WstYQ3Ob5DCzFUb9lSOPAwpcVhYSltNmua8RBh
   cVHrLuYub5GZ1bbwFegX2kALkCr+p4tRMHG/RvP8pjKG7YQGa6A3qcjD8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291146655"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="291146655"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:35:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="630948525"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="630948525"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2022 09:35:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:35:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 09:35:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 09:35:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4vxxVyqFHv3FabPxsWSejm1O6ACVda84IOaBcihOnP1WET0pxdeVUpAdjGdU1ieGR0XaBfOkNgciU0jF5V2Y6B34Ts5G7s33nfmP7+gkiJlXSPKyTP6iILIpNqrcrb96Bc9vasL7sceMN74WofjGaC5NvlADGQwmWEdICQWhQ3mpgH769Y9vJ2uSF85o28Yc7z/m0hwPEd1p4cs2J+GOwFQuk+96eVZ54CdzUUapZfaL8mJuPuT30/qDsDcWCdZHJWatVP5L+CBeu7hkI7FWilu8eg7PF+W7mgIrqMh9y8HCpE6CgRkGnTTDwmy2dUJY2O/JOvheZN0PXrjoudk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLtENLziaFjD0YvMx1JlMF26W5x8nvhrrIVVGGB9uwI=;
 b=TZwjfYWsb4jcwOQIj7elYj5/xLKAfLuPHD7lq0CQv5E0flD8JQ4VHyvSiZJhh0ukaC/wpAQkorel/gNLVw5dJmsQw8R3paOcWrEMabaqJRl04aGLP23WWR7f/vqmyelbn/yAOudUEwVUAtKBScGqk/CAcvftJAALbwATZZnB9xjMaLrjYYK8iVv9YCROOPxBGr0o7IeXXNvFwdT7TEx9IkyMe6RdpUb2XJIunUNz1W1kaEc4lwq732CgBNDYT7LHFA5AcBfkeBEcm7TQxAXqvguAAmtDvzvCzdXL6WSWanLuvjwOyV3RjYiksHvs/2av7kz98JNcX4XTuKqFJARnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 17:35:25 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b%9]) with mapi id 15.20.5791.022; Tue, 8 Nov 2022
 17:35:25 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2022-11-08
Thread-Topic: pull request: iwlwifi firmware updates 2022-11-08
Thread-Index: AQHY85h8XuXMRAt4OEayPpJw3giWnw==
Date:   Tue, 8 Nov 2022 17:35:25 +0000
Message-ID: <79b625f47ae9ed8fd9784471dff0deb5ecb2c2f1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|IA1PR11MB6267:EE_
x-ms-office365-filtering-correlation-id: 758ed23a-1181-4299-bf4d-08dac1af9ee9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QtlKKb0yaG8emAYzM0TpxD2nJhtia6z+uCwlP24ElMcCtkxz+jeKPznif21MXhyPGOOx6j7LiPXz+eMe2lD9J/gXLKT2Pvg6OtaT5jexkhVL44+dvYTbFZO9pc3p0sv7282ibZhZfj5Q+eDusIHX0rn7GLLjQIJ5c8jlQXR89o7Gulg7dylawdHr9pvJ2hxoRY7d4+5llmlAj59HTU3VyyAdA7QGg42lqskvzgaQVTyTB/tU0ujvjhyn1+EPNwkICy+JQOBAfolpRWCG8h2t1exJH5/MMokSXimJ8IToyfjXgkq9E0NEXAsXMtJV68UZ3rW/F98fk2ZInEdM3WVDV6csZVyjm0cHiIfapcFnodnUiC9r+fOxsMHRYruGs59dl4yLegVQRe1i8C7MlHa79nqDUi7+SgZelaC3E8W09FAH3Ezb5pHcyRcgQyFeJ3tNTjmofEIHzSHwBBAzMTqYdomFjpoel3ja4YSUeBo8/HIz3PVMnuBIJ0zHZqbBNcPshVyU10f+afVIq/fWcsizNVqRbgcCGPq2v5XKERR2t9D4EDzyNyHBAbO7EfhwO6V5AId4Eyd6LAERZbicP5cBtNl86GbzyIx6OA9VMaGkd+zY5wRjDTrnEaGMOoXJmFt98whpeoaShmQrKtf+7G4VP6Q24kl7DuqNXgV+LPJHn0xk6SXJl/IQbKP2Jm0A5HYcsB3plwNr//AZfQjwWJzQu3YfvtjRGUsC7d1+zne5Uktq9gXvCkSDIcVU99if22VymErnxNSOtayKOQTjPJqPT9hXIWYg7jMfp//gyIkWXkbpSGpktsRNSg2ei/d4kGlWTU5GIzZcGTBStryAo2yJyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(36756003)(6512007)(38100700002)(38070700005)(122000001)(8676002)(4001150100001)(2906002)(82960400001)(86362001)(316002)(64756008)(19627235002)(66446008)(66476007)(4326008)(6486002)(186003)(2616005)(26005)(66946007)(71200400001)(91956017)(66556008)(76116006)(6916009)(54906003)(966005)(41300700001)(5660300002)(8936002)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEZrY1lIZnFvdFZTeGZTbE5iYTkvUHBhU3UzdGhGeGh2eTJicTdqUXloa1du?=
 =?utf-8?B?Q2xXWWxaNTkrM2M2UVpyeGtjL0E2cGdGQzI4T3doOTJaeUNRM3ozOWNReklO?=
 =?utf-8?B?d0xpcG91NjBrYjNWb3Y3S3h4QlV4ZUwzWFFrUjBLK3kwVU4xR2RBNVVHRDFP?=
 =?utf-8?B?Rnl6a3F3RGRSQVZWUlZOdmhqQzNVWVBOaHpZN09SNnhQOWNudTI3Uk5Wdncy?=
 =?utf-8?B?aWxrREZldS9sT0lhcDJydXRrcWNRZzEwbUlUZS9raEs1V2QyVTY2Z1l6Znhk?=
 =?utf-8?B?b1IvUklVSWJSaC84YlNtQWF3ZWo3d29nUTl1QWJtVEMvWk9QRG9wSkpMcGxY?=
 =?utf-8?B?V2k5aWt6Zmx0UThoSDFjK2tMVXpUbytuTzFuOVF6OXFRNmR2cjdGZVNpMVhs?=
 =?utf-8?B?R1ErOGJhWG8xM00rcXp6WjdRc295THdTT29QZ2llUml4R3ZLbVFFQURKUHNT?=
 =?utf-8?B?N1BTSVNQczE4KzJ6NXFCa3QrQ1NCdDhBSC91eXJkVWxaaTJqYWhScXJJQ0Z0?=
 =?utf-8?B?M3ZOWlJ1UFYxekJUOEJBZ1A4aVZtYzQyZ0Q3bHhwdlkwUk5FVXd4WVhvcDly?=
 =?utf-8?B?UlNFOUhFVWtXVXFqeVBJalFnbXNOU05rcUFnVmlGRjNQSmNldEZVQTJLVFFN?=
 =?utf-8?B?Y3hXbXNiWW1iVDdBT0JHQ0VLd3NzNmJXeGZmd3phNTFwbWlmZEVvSlNBT2ty?=
 =?utf-8?B?MGpCeW9NQkYzMHBJKzZPbHVhelZ6bDE2MWl3VEc5M045aEljcGFKUjhqMEd5?=
 =?utf-8?B?aytJSk1pd0NTMFpmU0NnRzg4QmMrK1hlaHF1RFBYYkJtNkFWMzNONzNWQTdR?=
 =?utf-8?B?Tk1CT1RMT3NVdm5WMlhNdUhKdEo2Y25PWWdWQzNPWHdBYWhZTkxHMUJKbTRC?=
 =?utf-8?B?WTdTU0YvK01VcXhWNkRaUEdudEdoY0tYVDF2OHZyaStJdGcrZFc1TlJTZndJ?=
 =?utf-8?B?aEQrY1A1ZlZHZXYrYlZxVHkxOFpIVWVxWHRxRU1UM0J5UktMMmY3cFp2ZXpw?=
 =?utf-8?B?U1laaUMyQVBnZFA5Ryt3S2ZVR2RnYUtNRWw3RG1rQWlZWmFkM2o3dkRFbVJv?=
 =?utf-8?B?cVhnQ3JqanVWTGxZM3FpUlAvdkhYRjBLNllIL1NCUTBTZFBXTEkvaHVHTk5I?=
 =?utf-8?B?K2RoRXdYWU96NWd6dWVBVkZ1RnRBSnJIeXJIY1lJV0NqanlPaEswUWp5U2d0?=
 =?utf-8?B?Tk5mTkVia3E4V3pPREhVeno0M1gyQnpib2VJRDZseWY1ejB6eDM0ZE9obnNn?=
 =?utf-8?B?SnA5WXIwWGY2VlJOT1NYci9BTFdRSmRkU3ZuVXpLT21oMWJHaFhadTdwME5D?=
 =?utf-8?B?SmdlSUhldU81TkxBaktEa2tZSUZuTjFvVFpDRURDalE0TUVhc2ErTVB3WlBG?=
 =?utf-8?B?VTRidWdlcVdFMjAyMkpEWkJMcjlmMkdyQVdjV2t5NkttL3dhUVRlb0NjZEZx?=
 =?utf-8?B?bldFSmVjcWxRRDlwSmdvM1J2cHZzclJHVlhFSUNJYlR4QUFuTUNQV1E4L0t1?=
 =?utf-8?B?aUJMSlZrN1JPMi8zT1lFdlhEWGJhT25VRGExWlFmc0RaTk9GRm9veDJDMVll?=
 =?utf-8?B?V2E4a01pdE5oR0JrcDdxdHdmeEUvNzU3ZGZkSmcrbjIxclo5dWNQbnRCMjVi?=
 =?utf-8?B?RmRhRmluVDQwdWJvVHNlZDZCQXM0NFZNUVU4Y1E2b1J2ZTdiNFN5cXBHWGhT?=
 =?utf-8?B?eW5ldVdQK01YSkpzL1pVT1padzRTcHBXS1ZpcHFzbW9rZ3J0UjhvWmFqWFdt?=
 =?utf-8?B?UzZlOFE2MUV3YWI5YzJMNlBKWGlLZlZzUkt3RUlLWVVKVjlnR21wY2dqZ04z?=
 =?utf-8?B?UDl1VStuWHJYVGtueS9DY0E5eXpBUXNWaGlLVE9mcXRnb3p3RlJqVXl4Q05X?=
 =?utf-8?B?MzZWMmxyQ0RJdWdITU1tT2hOSHliUGJJNGx0TUw4dlB2cHBsNFFaeE44VFNH?=
 =?utf-8?B?eEJJMStIcDdnelBNN21YZGNUT3hISkZ4MmRjQlNYbWlrRzA3MmRTSFNDWENM?=
 =?utf-8?B?QUVINkN5MmVXcVF1d0lzd2lmaUY3K2J2ZjUvVnpCbmtXSjRoczVCWVhHS1hS?=
 =?utf-8?B?cHU2cGR2anVoMCs5VHZtWkVrcThLTXhNaVV1UFA5RVBLZm9haW50cUdhZm1m?=
 =?utf-8?B?T0FYL1lXazN3RDJtNlM3emQ0eFdzYWVRZkRsaUtlNzdMNkNLcEZXUS8yaGR5?=
 =?utf-8?Q?V4rcA49ia/bszLT56jE0qIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7483D4D56DA2B644956CA43376E7376B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758ed23a-1181-4299-bf4d-08dac1af9ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 17:35:25.5434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7C7EEEYGcZQ6PBamS56Yr9OVcpWgasDqKfwMFmS+M07kuA9KnaM/7bK/fieYUNI/dLW8TQis62bc3/ciTNUyn48wnqSqjG8rBCD4OQHMUZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgZmlybXdhcmVzIGZvciBhbGwgb3VyIGN1cnJl
bnRseSBtYWludGFpbmVkIEZXIGJpbmFyaWVzLg0KDQpQbGVhc2UgcHVsbCBvciBsZXQgbWUga25v
dyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KLS0NClRoYW5rcw0KR3JlZ29yeQ0KDQpUaGUg
Zm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDhiYjc1NjI2ZTlkZDgzMWQzMjNjNGU0NjA0
MTRiNTYyNjBmMGI3MDA6DQoNCiAgTWVyZ2UgYnJhbmNoICdmb3ItdXBzdHJlYW0nIG9mIGh0dHBz
Oi8vZ2l0aHViLmNvbS9DaXJydXNMb2dpYy9saW51eC1maXJtd2FyZSAoMjAyMi0xMC0zMSAxMTox
Mjo1NCAtMDQwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoN
CiAgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZp
L2xpbnV4LWZpcm13YXJlLmdpdCB0YWdzL2l3bHdpZmktZnctMjAyMi0xMS0wOA0KDQpmb3IgeW91
IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNGE3MzNjMjZkN2EyZWE5M2MwNmJmYjc5M2Q2Yzg3OGJj
MTlhMmMzYzoNCg0KICBpd2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU3NF9wdi02MCByZWxl
YXNlICgyMDIyLTExLTA4IDE4OjA1OjUyICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQphZGQgbmV3IEZXcyBm
cm9tIGNvcmU3NF9wdi02MCByZWxlYXNlDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkdyZWdvcnkgR3JlZW5tYW4gKDEp
Og0KICAgICAgaXdsd2lmaTogYWRkIG5ldyBGV3MgZnJvbSBjb3JlNzRfcHYtNjAgcmVsZWFzZQ0K
DQogV0hFTkNFICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQogaXdsd2lmaS1RdS1iMC1oci1iMC03Ny51Y29kZSAgfCBCaW4g
MCAtPiAxNDA3NzM2IGJ5dGVzDQogaXdsd2lmaS1RdS1iMC1qZi1iMC03Ny51Y29kZSAgfCBCaW4g
MCAtPiAxMzI1NTAwIGJ5dGVzDQogaXdsd2lmaS1RdS1jMC1oci1iMC03Ny51Y29kZSAgfCBCaW4g
MCAtPiAxNDA3NzUyIGJ5dGVzDQogaXdsd2lmaS1RdS1jMC1qZi1iMC03Ny51Y29kZSAgfCBCaW4g
MCAtPiAxMzI1NTE2IGJ5dGVzDQogaXdsd2lmaS1RdVotYTAtaHItYjAtNzcudWNvZGUgfCBCaW4g
MCAtPiAxNDA2NzU2IGJ5dGVzDQogaXdsd2lmaS1RdVotYTAtamYtYjAtNzcudWNvZGUgfCBCaW4g
MCAtPiAxMzI1NTMyIGJ5dGVzDQogaXdsd2lmaS1jYy1hMC03Ny51Y29kZSAgICAgICAgfCBCaW4g
MCAtPiAxMzY5MTkyIGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC03Ny51Y29kZSAgfCBCaW4g
MCAtPiAxNjQxMjYwIGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC5wbnZtICAgICAgfCBCaW4g
NDIwOTIgLT4gNDIwOTIgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmNC1hMC03Ny51Y29kZSB8IEJp
biAwIC0+IDE2NjkxNjQgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmNC1hMC5wbnZtICAgICB8IEJp
biAyODA2NCAtPiAyODI1MiBieXRlcw0KIGl3bHdpZmktc28tYTAtaHItYjAtNzcudWNvZGUgIHwg
QmluIDAgLT4gMTUwMDUzMiBieXRlcw0KIGl3bHdpZmktc28tYTAtamYtYjAtNzcudWNvZGUgIHwg
QmluIDAgLT4gMTQ0NjAzNiBieXRlcw0KIGl3bHdpZmktdHktYTAtZ2YtYTAtNzcudWNvZGUgIHwg
QmluIDAgLT4gMTU5NDI3NiBieXRlcw0KIGl3bHdpZmktdHktYTAtZ2YtYTAucG52bSAgICAgIHwg
QmluIDQxODc2IC0+IDQxODc2IGJ5dGVzDQogMTYgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9u
cygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLVF1LWIwLWhyLWIwLTc3LnVjb2RlDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktUXUtYjAtamYtYjAtNzcudWNvZGUNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaXdsd2lmaS1RdS1jMC1oci1iMC03Ny51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpd2x3aWZpLVF1LWMwLWpmLWIwLTc3LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3
bHdpZmktUXVaLWEwLWhyLWIwLTc3LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmkt
UXVaLWEwLWpmLWIwLTc3LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktY2MtYTAt
NzcudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1zby1hMC1nZi1hMC03Ny51Y29k
ZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmNC1hMC03Ny51Y29kZQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWhyLWIwLTc3LnVjb2RlDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtamYtYjAtNzcudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaXdsd2lmaS10eS1hMC1nZi1hMC03Ny51Y29kZQ0K
