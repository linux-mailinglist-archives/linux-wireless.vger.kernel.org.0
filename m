Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75444735242
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjFSKdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 06:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjFSKcw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 06:32:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C022E73
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687170770; x=1718706770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CgPflZsSAxqgHKYjvEgit7UZg+QbThaLO8/7oBgYUOA=;
  b=bWVBhePMo2D++3oUAkvaRAExKT98NnvQbv+/yDt0ZfUYUueXUZDF29Bn
   O9fwW9eR1djff5V/JuaPa0WeUaLfzoPgqBReuvjSGhFtR9CPxaX1XSw2u
   sDCSN+SWZ3VEyyyHry2X60Wq1RnqDJkTecx2qGZOfs2q0EnfS+rRu0P0s
   mjBlOnNoU9t8lWeTNl+FpUT74B4u9u01jguWZphRL0DAn7Stn+6a7S/Mk
   FqRm9huJlbyqATN9VkHTWjuivqv7/H/2BeuBeLKYWE7yRVMlRzJjD9Fo+
   pUTHKxjfZw6qW25n//AGElq+bCK8XOkcxPGNoOSwWxh3EcpEzgxL76q2M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="363022150"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="363022150"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="783663268"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="783663268"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2023 03:32:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 03:32:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 03:32:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 03:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7KSbyUpzQNFnQv9FqN2sWqK/tKkR6yHXyPtRFU/mfO5Tv6NNkG9w6fcfsP5iuNO2vcD5ZCrzIfQo8ZW3SqnLNUkv1UPj1zpZ25GKwIpAMocxOtFB3tDTo92+P3uTl/4KhEeTDxlRK4UsR60kvosMrEbkSvsVnp73EwHGxyhPCY7jkW/sOuf1HzdqXgmlZVOrNpBvChG4UsAvZM3lkV2nEBvDuVRlEHh5N+cO7mMPEZD7mqdjTcEX0+fTNXbJc7T/iwe+k+jOHV1nXSjt5b9BSnDip0H432ag92UolpqCODitJOp4aRbfc3M+ie/E0GhuHGFbDWjJw9DaTA4r13+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgPflZsSAxqgHKYjvEgit7UZg+QbThaLO8/7oBgYUOA=;
 b=GFmRxouTS8yISGs+t7ntyL28a6vTfjaiVmLREJrmLbhiTLlqOByyIH3cOyqdZZnTWRmyDybq3WqCutW/qd0LjN3GVLgvM229hTi8o/d/Fr+haBMViyzQWMnHU/ey9VkIw51yrSIsJtKTN98wQDsKg0loynZ/oGfyBNfPQaVkwj57Ewg8O4kdHYDNqw550p3f0MhT0Ofn/Z5KX+y0AxnwG7IJAZGMVt05yaCU5zjPGV1NWQAL9kNaq/Or0u1xK+Bwf0X6ivKhtl7yGIK5c0CyiGpctPcaoH5s7Ij+VIIxLYpCp4ee/oVoOu89qW4E1J2vzmMlelVDhApqmi0pQTpKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 10:32:41 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 10:32:41 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "Berg, Johannes" <johannes.berg@intel.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlfifi: fix -Wunused-const-variable gcc warning
Thread-Topic: [PATCH] wifi: iwlfifi: fix -Wunused-const-variable gcc warning
Thread-Index: AQHZopUj+pZgpXoNy0SdK6GTC3Mf0a+R7ZOA
Date:   Mon, 19 Jun 2023 10:32:41 +0000
Message-ID: <fbea3467e08bf11a8810b71de2fa17a9e0c091d8.camel@intel.com>
References: <20230619100030.284920-1-dmantipov@yandex.ru>
In-Reply-To: <20230619100030.284920-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH0PR11MB5299:EE_
x-ms-office365-filtering-correlation-id: e88a93de-8e20-407c-5e7d-08db70b082a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fX4Bk4DWYO/XH6HZzMIe04AxxMRVJg8ica2fAGXpDG717wKIXYMuimKGX4dMn36TUPR8+d07mq+xqg0fHueqyCZMMHdfIxrfhXP/axtdsOTXFIcfvGDzpkKW+fpOD7f1rOfFQHf4AIJJWVsv9tfpdpUQhgPQFjkmOejTZ5LhKpaDpxE3aXA8UbvPG4AO+fy3V+RSILxgQZjIwVkzYc8pcdEFfW3WDMSJAZPaCM7uWa7mIU8aVlLdp0Dj4ox6opDmmb+s76DG4GGaQim2OUMzPKUEm+pNEC1EPCsZRVWpAQqvj0Xt6jZW8XjmmMcTHF2JJuzec3yNRC0HY9QwTyWxR75an+tTwR6HczL/O82fN3YHP0uGlmF1/suHmLLwF93ntnkmVy4sPgjiVe3dFld45wgwrBw4wEeoohY9Rl2e+sukmTT79IrYjI69xcU9tvyEGZLUpqvszeYuyRTjnwkdZoNPL9V1Ws7QWiWucWxE2Ja9o9gBO5z31bdRelmKcDc9zuXPJ+zHDUlEmtv9nmShFREzFYFOtqLvo7TW+LiWFTFLv99BLxuh/PoY3l4KzSN5o8ILT9ppIwQsfO/hAPHdUYkc3JRTXJKa7y55fVNld0z/ywFczRuyWCuKDXIdlIqH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(2906002)(38070700005)(40140700001)(36756003)(86362001)(26005)(6506007)(6512007)(54906003)(110136005)(186003)(478600001)(71200400001)(6486002)(122000001)(76116006)(66946007)(66556008)(66446008)(64756008)(6636002)(66476007)(91956017)(4326008)(38100700002)(316002)(82960400001)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWh3OVlmeGl5MlVnK3hkSHp5bTROLzFiVWRnelI1MVBNYTBXT3FKQjgvcTZt?=
 =?utf-8?B?SUhsTHk4MGNoM1YxL0VRUEpHVjh4NzJXRmljMVRnQlViNUhXRjRxeEczZ3lm?=
 =?utf-8?B?NXMxQXhXUWxLcklLUStrS3dyM203NWJhUkZJclYwemFmaDJPMGg5a0FsRUJ3?=
 =?utf-8?B?Mm9pMUUwYjBrSXAzRXRsYUJKazlDRStTbGFucjVGRURmbzhWc3VVRFRxUFZ3?=
 =?utf-8?B?cW00ZFhnREFtNFg3RVRXMStvRzVvUk9adGZCdGlFMnUxOFhQUDRkUTN3cWRG?=
 =?utf-8?B?bFJMdk1ib0gyTnJlVHU0MFB1Ym1nMkNRZmxnR3dWVXBvbFdvQWIyb2srazFI?=
 =?utf-8?B?VWZZb2tjM20yVW9nck1Cc3VVVVJmL2ppcTJ6aVlCRFBWWFdCekwzQW1WZk1H?=
 =?utf-8?B?UlVnTkF5NmpsdVozV3JwWG9COUtTYjNFazhhanVGSkRIVytXNmxMYWYzMXdj?=
 =?utf-8?B?b2NnT0IwTXRLVUZQUjB0emF0WWx2cU84NGVtRnBtQ3R2dDRzcTAyUFFwQVU5?=
 =?utf-8?B?M0QySmpUc1hGbW5EY083ZEhVNFhYVE44WjNFOVFJaTYyaDBxdEFWdXhIZXhq?=
 =?utf-8?B?bmpRSElZNFFhWFVOZUQvV0VMcDlyM3g5bGdpaVVzU2dER3U1WGZNUnVFZmtG?=
 =?utf-8?B?U21jNVdFY214NUN6WFBJZHFwbE9WMUtqUFFJc1Y2ZjNkVTJPSEpXdHQ5VUk0?=
 =?utf-8?B?OXVWRXUvU0dXYWl1cTc0Z1ZTR1dkaXRkNG42V0hDN1lBVlNiTmtiVFlJaHdW?=
 =?utf-8?B?NmkzQTU5NGVLZkt4bzZGUkFzclE1Z1NMSnhvY0lnYmE1akhQNXgxTzRtRElN?=
 =?utf-8?B?ZWlENjMvVm56dFh4SmJnT004OVd4am15NHBQS1ErZnRMTndNVFhGaEMreUU1?=
 =?utf-8?B?b1VRaWUzeU92YzJyeFF1WTlTaUhuUUNJWVZickllQkR4U1RMcXVSYlF3LzI0?=
 =?utf-8?B?YUtZeGpRVmZrNEhlT2I3MlYzekZuRHV6Y0paQ0pvL24yMk8zdkxXdW1hTUNw?=
 =?utf-8?B?aXFkUUhVYWVpU2JTYnBGRHFOUFg4MlljTGl3QWsyd2FnQ296QnYvRUtMMDQ5?=
 =?utf-8?B?Y0hSN2FKUkVKSzdtbXNlbDVqTHlzOXZkRFdIVHZ0SCtIRmVWazZUUVhXUkp0?=
 =?utf-8?B?eEhpVW4wMXZkeDluRkpIRGVLM2NaaHdkRkNHL09UNVFzWnZNRis2NGtmYnJD?=
 =?utf-8?B?dUxYbGxiYXVFdHhEM04yTCt2Nld6NXB1NWFoUzlJQ3N3czNNQWdNOU9yOVM5?=
 =?utf-8?B?YVZXaEhkSzNqRVhOdUZpTkwrQ3RFa1Q1S05lZHYwSVBTQlU3ck05OWFaRFd0?=
 =?utf-8?B?T2lqSVNSbW1JNjF4WEVEWDlGeHJWMG9lVFF3ejRuQVdmbTFqaDNZKytLTzdt?=
 =?utf-8?B?SE83VjJ5c1c5SXBjR3M1ZGI5b3ZqWnhYZlIzbTRkazVGOUg3L091RzZ5Y3ht?=
 =?utf-8?B?b0hySTZoQktIZTVzSU1SaU1ZeTBVL3RVUWlWNFJzT0g4b3ZWQ3MyOFNpWWd5?=
 =?utf-8?B?SU1VZVpQN1I1bUFHaGJpaXpxb1hxdFdlc1dZK1EydGl5UDFtd3Riei9BWjJj?=
 =?utf-8?B?VlRVaWNyanBiTERNaHB5OHoxQ0N6TmlHVGl5Z3duNWxnNkN5S3daU2UrZkR3?=
 =?utf-8?B?a3lIT1gvMTZFOEE0Q3oxTXhQU0dlUnlkNkNNMGp4UnBFSnZvc2dYRFhxQmw2?=
 =?utf-8?B?VnFKaWtVZHVna2Q1bkFnWmo3VU8zWkdBdXNHR25saFYrellSUHhyWk1KWEk3?=
 =?utf-8?B?N09RQVB4R3NOQm0wMk9iU1RuVTFCclkvcFc2VFBSZUZNNm9BcUZEWWVrTnUr?=
 =?utf-8?B?cUI0ZGpmWU0rZGhzUzFXYk9nOVIvVnBMaGk2TXUxTFk3dFB1TExzSHJidWdQ?=
 =?utf-8?B?NlF2UXczdUVKMUcrREhRdUd2cFk3a2VBQkNNMVZjaVNsbENZQlNIRnhBSXJ4?=
 =?utf-8?B?amN5V3hST005Q3ZvRXpwQVFlWERML3ZkTGlwcTRRVmRtRUFZaUI3NFZjRm4r?=
 =?utf-8?B?bGJLeUhyRjU1MDIycWNDWG5teWRwNnA1eXpOU2kzaHdXNVJ2YldRc2hCblR6?=
 =?utf-8?B?ck5BbFBrcnFIWFRrMDV1aHdxL1l3V0gxR2J5Snl1c3VmOWVkaDdiVlVmdjFS?=
 =?utf-8?B?SFhBVVZubFhkZm4vbHhMRlB4WlIyN3lMT01QQ0VZZEtwVko4VkNmRnR1VjFl?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04A62EFD306AA1419AA46A1EB9D1D35B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88a93de-8e20-407c-5e7d-08db70b082a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 10:32:41.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCDkr1yhUOlG87vmxhnEA+CleKd6vJOXTx/6x9rKiJVyNuoDo4W5Cm4aG5wJB3SOjpA6DTfXwUffkPugaEbkcqZ2lR1rUgVDBQDliHMCFfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTE5IGF0IDEzOjAwICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToN
Cj4gRml4IHRoZSBmb2xsb3dpbmcgZ2NjIDEzLjEgd2FybmluZyBvYnNlcnZlZCB3aXRoIFc9MToN
Cj4gDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3JzLmM6MjA3OjM5
OiB3YXJuaW5nOg0KPiDigJhpd2xfcmF0ZV9tY3PigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0NCj4gDQo+IFRoaXMgdGFibGUgaXMgYWN0dWFsbHkgdXNl
ZCBpbiAncnNfc3RhX2RiZ2ZzX3NjYWxlX3RhYmxlX3JlYWQoKScNCj4gb25seSBpZiBDT05GSUdf
TUFDODAyMTFfREVCVUdGUyBpcyBlbmFibGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5
IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgucnU+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3JzLmMgfCA0ICsrKysNCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9kdm0vcnMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvZHZtL3JzLmMNCj4gaW5kZXggNjg3YzkwNmE5ZDcyLi5lY2FkNzQwM2VjOTYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3JzLmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vcnMuYw0KPiBAQCAt
MjAzLDYgKzIwMyw4IEBAIHN0YXRpYyBjb25zdCB1MTYgZXhwZWN0ZWRfdHB0X21pbW8zXzQwTUh6
WzRdW0lXTF9SQVRFX0NPVU5UXSA9IHsNCj4gwqDCoMKgwqDCoMKgwqDCoHswLCAwLCAwLCAwLCAy
NzcsIDAsIDQ3OCwgNjI0LCA3MzcsIDkxMSwgMTAyNiwgMTA3MCwgMTEwOX0sIC8qIEFHRytTR0kg
Ki8NCj4gwqB9Ow0KPiDCoA0KPiArI2lmZGVmIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTDQo+ICsN
Cj4gwqAvKiBtYnBzLCBtY3MgKi8NCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IGl3bF9yYXRlX21j
c19pbmZvIGl3bF9yYXRlX21jc1tJV0xfUkFURV9DT1VOVF0gPSB7DQo+IMKgwqDCoMKgwqDCoMKg
wqB7wqAgIjEiLCAiQlBTSyBEU1NTIn0sDQo+IEBAIC0yMjAsNiArMjIyLDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBpd2xfcmF0ZV9tY3NfaW5mbyBpd2xfcmF0ZV9tY3NbSVdMX1JBVEVfQ09VTlRd
ID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgeyAiNjAiLCAiNjRRQU0gNS82In0sDQo+IMKgfTsNCj4g
wqANCj4gKyNlbmRpZg0KPiArDQo+IMKgI2RlZmluZSBNQ1NfSU5ERVhfUEVSX1NUUkVBTcKgwqDC
oCg4KQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIHJzX3JhdGVfc2NhbGVfY2xlYXJfd2luZG93KHN0
cnVjdCBpd2xfcmF0ZV9zY2FsZV9kYXRhICp3aW5kb3cpDQoNCkpvaGFubmVzLCBjb3VsZCB5b3Ug
cGxlYXNlIHRha2UgaXQgZGlyZWN0bHkgdG8gd2lyZWxlc3MtbmV4dD8gT3IgeW91IHByZWZlciBt
ZQ0KdG8gc2VuZCBpdCB3aXRoIHRoZSBuZXh0IHNldCBvZiBpd2x3aWZpIHBhdGNoZXM/DQoNCkFj
a2VkLWJ5OiBHcmVnb3J5IEdyZWVubWFuIDxncmVnb3J5LmdyZWVubWFuQGludGVsLmNvbT4NCg==
