Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBBC677C0A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 13:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjAWM7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 07:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjAWM7f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 07:59:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7C14E9F
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674478774; x=1706014774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jawhMpjm1dvl0IEMv7L1BQiX5CsLi7gxrxnVOkwuEdg=;
  b=VRuKJ4iVOVUyMK8n2NWqvI6UR090HxwksPvaihMms0qd60MdJb41V97W
   vp/3n399IFN0ZrAIwiNI8Izj0279PEdiC2Gv7l+LglpYDL819dS3NlDqf
   Wxjxew+OOACtRFRaU+M2gfNSMIKO+eDm3FxRvadJQ0E/TOwyrSPhUS/aJ
   9j0k6jGfB6WdHJvDlSSOQyuB+pStdcKDPDTMlQP9Ct0NnJipm8jPhrG4Z
   k2VNan3HhPnlwuOpOSDSCLxxxhiYJCVutEr7HM7IDcNVXfnCYyDqQET9D
   3ItfqigEa1oNXZKvnZtqImgpPgP7VeDoc9CAfUIjv1YQ3gfT3xvCfJyNU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="323724006"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="323724006"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 04:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="750309570"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="750309570"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2023 04:59:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 04:59:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 04:59:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 04:59:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+A8JvhEupQy6eTR65wrBxWye7G3AiU2x5d4uuRY24nRllnU4f/43gbhsaJ2qGRoxc2MGQZRTyZlyXOMqMXotV8hoRVMS/LHB3CbxQ3IjOu4SaLTca+Ih6KGYbxg723jzb6Uegm0TZ+8Fod99biJ73EeGhlRyAPBuhQw++DThcsuvdeliiPST0JKP5PqHhKbFsAcT/V3OAbcwGJ4PuPmIfnE4JRIGn2L7aC8RdtLRakW5/65INOCY2udaaTHxtyHfVhbE6b920W2cisD1UyeMZlU3rAdK7UDnlARCxR2jymA9Ek1zT93hlqN/m/7/VYr3nl9P0/ZiCNZoX8qDdDeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jawhMpjm1dvl0IEMv7L1BQiX5CsLi7gxrxnVOkwuEdg=;
 b=G7wQOCimH9bxrHfp8w1xy0ci7bhW7Zo48fhVtT7kEszmF5LXs2pocjDF4Jpf+w+0rpnkfOjAClwK0qLvNp040iCRi3/ivDmDLeBZOjmnnJ05+oJAtFuAwvxXrm6V4k/QUaPi5+nAXJlEUUV2rub8cQtWz1qWvow/XD4CDlD9Jh9cjW42FFa0Tl9lbK432CEfhMuOrBL9VUryBNg+fnTwxrF+wn95cCoIXG28adB1d7B26cZUcrWpN6qx2l5sw6pDUGr4R8boWdzXj0E2zKtIHNY+Gh6E+L99GzmXQp2hDDTh/uieJH3Ej9SBrjTE4emRIy+bezZ6u4Ik7WL1HmL8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH0PR11MB8216.namprd11.prod.outlook.com (2603:10b6:610:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 12:59:31 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 12:59:31 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "chaitanya.mgit@gmail.com" <chaitanya.mgit@gmail.com>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "egrumbach@gmail.com" <egrumbach@gmail.com>
Subject: Re: iwlwifi: Monitor mode broken with 6.1.0
Thread-Topic: iwlwifi: Monitor mode broken with 6.1.0
Thread-Index: AQHZLwXzIckaW/dU5EOJQ/UY52NzZa6r9wMA
Date:   Mon, 23 Jan 2023 12:59:31 +0000
Message-ID: <714df952bf0b0f53a2f7a6714083e93e39632f49.camel@intel.com>
References: <CABPxzY+_Mjercvvh5XHmtHdNCKXDupVbL4PKXgzZPiUesRsRMA@mail.gmail.com>
In-Reply-To: <CABPxzY+_Mjercvvh5XHmtHdNCKXDupVbL4PKXgzZPiUesRsRMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH0PR11MB8216:EE_
x-ms-office365-filtering-correlation-id: 85f4eb64-d19a-4c7e-7cdd-08dafd41ab72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbaV9FoP7xy5me8VRqNUf6go97vTRitsBOt+AAHV9nc5FpN+S4+EzQsuNEZtCufqeuUQrSS22um1fQNLq88SmqUSbg4U18ExrCRpcv4Vg5vxuTPcb9t15ME3e8PpM2dvqESelgB4XCa72EDLn3uPwStynwm5iHTQn5kywLcBqFuglJzL8ccb4W6R3anx1CzV2N749kMnyjX+Yk3AEasoHsIT3pymRP1cAfq1uc2r+u34nNrnvdjBixeCBT+C2nHNtgPSeuE4eh6izfvItzDlEFOC18MTdP77Q75Wr1BwQJF4ob4TfsYdsTgxkP/LzO0uoamAcjY/aeHErm+ERBhg1Dfe7B2kdd4WPP3FwHc4qh87/pBGfaAtH8TBC1Magiar8frRwcBe4eNC74KxJERXdR2d8z1pwH+1L9wMy4B1lAlZxU5BQRx2xRSOK+ABUrmKSn46H28D0eK+11Jg7KECHWWvVnmW7xwpiYk5zXtw43WrbU+W/e8UB7qfzygiTnbBMPK0yPQ88b4WgwsEWYb35+TEnCM3nIWPnj3pZl6dw5TXmnvVsC8RD/VwS7DFu22YvMs/Qw8FtQrkp9DI//HY2mDhf6en8y15G/C7pAcN1y1ntJetVbRGZeb6NAvdGJjevUsrVF8Ww7Efi40bc8BKYIJM0xKYDcWE+o7XVEeeLNen16Xdc7Gi6NnBxNVCMgh/7OM5X+t6HSHChL4l/zxBA6fUiMZvJQ9p679akAk20yw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(2906002)(41300700001)(8936002)(66946007)(91956017)(66476007)(66556008)(5660300002)(76116006)(54906003)(71200400001)(316002)(110136005)(6506007)(966005)(6486002)(6512007)(478600001)(26005)(186003)(2616005)(83380400001)(36756003)(122000001)(82960400001)(38070700005)(38100700002)(8676002)(4326008)(64756008)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTdHU25ENVgrVmFXY1UvRmhoK3kxK1o0TFNMOWU3V0UrMXcyQXU3eDc5Z1lQ?=
 =?utf-8?B?MUh5UlZ0WVpTMW1Rcnd4Q3BlL3NCSHJ6M2F0SGhzUkp6Q3NWbjNobzZ3UFpX?=
 =?utf-8?B?THJYYlU1Yis1SDU1TDd5WmZFN2MrOFFUR01yM3hRa2ZsZ2l1QTd1R2VwSmFp?=
 =?utf-8?B?aWRZckFpMEs3MlJOTGdXYmZoV1dOOUh0czRoczNYNWQyTTRxSlE5RWlERnJH?=
 =?utf-8?B?eGtPOE90SmFreFNEMzIvYytIRUFMSFBZMGdmeXJLMC9SUlZkam1adEJ1Rmpm?=
 =?utf-8?B?bGVtK05HaXNocXlMQUpRZkZRMGFBUndxS2NneW5pTEZNRmN2dGRuZzA1ek5G?=
 =?utf-8?B?ZzFaV0pGWFFLOVBCV25CMGFoZGljbFJIaTE3MzNqL0s5aGQwYVl2UW90VExF?=
 =?utf-8?B?MjlOUGJWbnB3bjFVL1BUZTlIYVArajBiRy9Dcmc3dHI2YVhkblZFZ3FXMTcx?=
 =?utf-8?B?OXArOGRQSnNrdmExcXlqUE5nMTdleVhVanFVeTd6R2lYcUdhM09CRnVVWFhj?=
 =?utf-8?B?bjJQU09uVmJZd241b1lrRXVUcTBKQkt5eXVYenUzT3VMK1orajE2eGVtaWVI?=
 =?utf-8?B?UWs4akp2V3lVTGdaNmF5SVZSQzZ1ZmNvbWZBbXRRSG1Xck9KaEF4YUMyWXlV?=
 =?utf-8?B?ZUUzdkttZ0diQ01CcXpWWlRVZUszZ09waGJsZDFFVElhR1VIOUd5RzVFemVw?=
 =?utf-8?B?NUMyVEFQNXI2TG56NFdRM1ZPdE45THZmU1g0cUNiVGVLVlhSYk1pYUtCUElU?=
 =?utf-8?B?TTljRysvaW9RZms0eGFPV2RCL3lURDlaTk8rd1o3QUJuMjFvSFBKOCtVVVdV?=
 =?utf-8?B?N0dMMXJMcUJCODBGUC9hOGhRVlBmS2VsenpHQXZHeFVGY0VsZHIwUERsOW9s?=
 =?utf-8?B?SHpTL1c4VmNoT2dmVisrNmwvWHdpUnpyZkgyNVBaMzZyWlZoZGljUHRjTW5V?=
 =?utf-8?B?ZmJEczUwNzBwUC9kSWVsZHVXcVB3UGQ1Z3dJUGdLcWt4eVVtMm83dkFSU3ow?=
 =?utf-8?B?ZFhmaE55NGIwK1JmMjBlYkljZU5kcXhYTEFQVFFNRGxvdHJJUlMwQllhUFVT?=
 =?utf-8?B?VkNiVlp0N0Q1Tm84S2hiZGJOMWlaWTN1OXNMVE5aK3BIamMyR254WjQwLzNF?=
 =?utf-8?B?K0I1OExrMFNFOUgyQUFoTUE1ZXcyRGhYY2YrOGhZZzJwRndrRVMvbGVXeXNR?=
 =?utf-8?B?Skk0T3RDbVlRdXhTSGhXQlFJTlhzWXViVnFiNjM1M1B1OUtNbWVyK29BQWps?=
 =?utf-8?B?MjJCZ045UWczcG9lZTE5aHlaQ04yUmd3V0JTZkdrMmJySWxaNGZzcW1aakpN?=
 =?utf-8?B?S3F6bkVVR2cwTzJwSGpNNm8xemNUakRad3BnTFBOOXZMMmhDTnVBVlBRajRR?=
 =?utf-8?B?emd5S3JtQW9LYUZxTEVQS2VNSXdqakhnd05ibGFJL2JhUEVlVmhadHA5dStY?=
 =?utf-8?B?UnpLaWIxMmdsbHN1RjJCT3hSeXVKbE1yQ2xiT1R3bGE5bXV2VVhvQjdnVHUr?=
 =?utf-8?B?bFVCTUlCbzhuNDBsT1dERm1oMXJndWovRGtxSlVzUVlwZThiOUVNRkhSNkVH?=
 =?utf-8?B?Sm9aM1lsSXFmOUw3emxXL1pNbnJ1RlhpdXZRZWpnYWlmLzVGT1RwdzdPcFFH?=
 =?utf-8?B?OW1kUlpmeFBpUEw3SzJnZHVBL3NYZjNkK25QMFY1S0t2MnhDNUErQTFDUlVk?=
 =?utf-8?B?RW1rZ0w1cFZVazJLRjZkSVI3N2tFYnJ5L2ttWUIxZ2NMSitUeXloUVhycjVo?=
 =?utf-8?B?a0VuYjdtWXZ4YkoydTNFS3NUaUxkUkdjMUsrTVZsQVFtMjcydDJUWjhyTXFC?=
 =?utf-8?B?bHdYeGVQcG1sT2ZTTzQ3WnRRNmdUZk1GYjlDR2tlMjFWYU1ZbGRkWGxOSzBl?=
 =?utf-8?B?c1FmQWFZT09EeEw5NXRtRlIvWW5tZDllL0RtRzRyZG9aRlk4cnl5RndVTHhN?=
 =?utf-8?B?VDZWOFFnZGJZOHNKRW5HdUJwOW1OZ3dTazlIdVNGaDJOS3lRNnI4eG1JK2FX?=
 =?utf-8?B?anJacUFJQjQ5M09XRWV5elZvRm1jSXFGMndYUWJNSXRGZTJJME1SWHBGaFg0?=
 =?utf-8?B?elhUUHd5YmFjc2U3dEV6eTJsblhrZGNzR21HTFkzRXRINGNyOU9KR0ZoSWdw?=
 =?utf-8?B?MlVIU3lYQitKQkUxbWh3cWdod3lINWwzeW5Db1pudVMxMTVwWU1SSFVMQURi?=
 =?utf-8?Q?tXxbBneiS2ZbuISzVwC9L9w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08D1B14AAC29954AAE0C1805D9187B4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f4eb64-d19a-4c7e-7cdd-08dafd41ab72
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 12:59:31.7142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYiT24yFmuYXIfzkYiGaW8RYT2BVYnCf+y1CnOzvUrOqjU0ZgTz8gsMZ0YSVc+GHaBgCdcnU1xvaQG1iiLf9WJk9+0NlkS27kXXgzGdnFCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkhDQoNCk9uIE1vbiwgMjAyMy0wMS0yMyBhdCAxNDowNyArMDUzMCwgS3Jpc2huYSBDaGFpdGFu
eWEgd3JvdGU6DQo+IEhpLA0KPiANCj4gSSBhbSB1c2luZyB0aGUgYXRoLmdpdCAoZWE3MjZhOGQz
MDVhIDogd2FzIHRlc3RpbmcgZXh0ZXJuYWwgQXRoZXJvcw0KPiBjYXJkcykgKyBsaW51eC1maXJt
d2FyZSAoYmIyZDQyZCkgYW5kIHRoZSBtb25pdG9yIG1vZGUgc3RvcHBlZCB3b3JraW5nDQo+IHdp
dGggaXdsd2lmaS4gVGhlcmUgaXMgYSB3YXJuaW5nIGZyb20gVUJTQU46ICJVQlNBTjoNCj4gc2hp
ZnQtb3V0LW9mLWJvdW5kcyBpbg0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS9tYWMtY3R4dC5jOjY1NzoyMiIuDQo+IA0KPiBUaGUgcm9vdCBjYXVzZSB3YXMgdGhpcyBj
NmNlMWM3NGVmMjkyIHdoaWNoIGRlZmF1bHRzIHRoZSBhc3NpZ25tZW50IHRvDQo+IDB4RkZGRiBh
bmQgdGhlbiB0aGF0IHdhcyBiZWluZyB1c2VkIGZvciB0aGUgc2hpZnQuDQo+IA0KPiBJIGhhdmUg
dHJpZWQgdG8gZml4IHRoZSB3YXJuaW5nIHdpdGggdGhlIGJlbG93IHBhdGNoIChqdXN0IGZvciBh
bg0KPiBleHBlcmltZW50LCBub3QgYSBwcm9wZXIgb25lKSwgdGhlIHdhcm5pbmcgaXMgZ29uZSwg
YnV0IG5vIGZyYW1lcyBhcmUNCj4gc2VlbiBpbiBXaXJlc2hhcmsuDQo+IA0KPiBCZWxvdyBpcyB0
aGUgdmVyc2lvbiBpbmZvcm1hdGlvbiwgYW55IGhlbHAgaXMgYXBwcmVjaWF0ZWQsIG1vbml0b3IN
Cj4gbW9kZSBpcyBpbXBvcnRhbnQgZm9yIG1lLg0KPiANCj4gbHNwY2k6IE5ldHdvcmsgY29udHJv
bGxlcjogSW50ZWwgQ29ycG9yYXRpb24gV2ktRmkgNiBBWDIwMSAocmV2IDIwKQ0KPiANCj4gW8Kg
ICswLjAwMzc5MF0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IGFwaSBmbGFncyBpbmRleCAyIGxhcmdl
ciB0aGFuDQo+IHN1cHBvcnRlZCBieSBkcml2ZXINCj4gW8KgICswLjAwMDA0Nl0gaXdsd2lmaSAw
MDAwOjAwOjE0LjM6IFRMVl9GV19GU0VRX1ZFUlNJT046IEZTRVEgVmVyc2lvbjoNCj4gODkuMy4z
NS4zNw0KPiBbwqAgKzAuMDAxNTE5XSBpd2x3aWZpIDAwMDA6MDA6MTQuMzogbG9hZGVkIGZpcm13
YXJlIHZlcnNpb24NCj4gNzIuZGFhMDUxMjUuMCBRdVotYTAtaHItYjAtNzIudWNvZGUgb3BfbW9k
ZSBpd2xtdm0NCj4gW8KgICswLjAzNDg4N10gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IERldGVjdGVk
IEludGVsKFIpIFdpLUZpIDYgQVgyMDENCj4gMTYwTUh6LCBSRVY9MHgzNTENCj4gW8KgICswLjAw
MDA4M10gdGhlcm1hbCB0aGVybWFsX3pvbmU3OiBmYWlsZWQgdG8gcmVhZCBvdXQgdGhlcm1hbCB6
b25lICgtNjEpDQo+IFvCoCArMC4xMjIxNDRdIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBEZXRlY3Rl
ZCBSRiBIUiBCMywgcmZpZD0weDEwYTEwMA0KPiBbwqAgKzAuMDY1NzAxXSBpd2x3aWZpIDAwMDA6
MDA6MTQuMzogYmFzZSBIVyBhZGRyZXNzOiA0Yzo3OTo2ZTo5MDo5NDo3MQ0KPiBbwqAgKzAuMDE5
ODI2XSBpd2x3aWZpIDAwMDA6MDA6MTQuMyB3bHAwczIwZjM6IHJlbmFtZWQgZnJvbSB3bGFuMA0K
PiBbICsxNC4yMTA5ODddIGRldmljZSBtb24wIGVudGVyZWQgcHJvbWlzY3VvdXMgbW9kZQ0KPiBb
SmFuMjQgMTg6MjBdIGRldmljZSBtb24wIGxlZnQgcHJvbWlzY3VvdXMgbW9kZQ0KPiANCj4gLS0t
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9t
YWMtY3R4dC5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFj
LWN0eHQuYw0KPiBpbmRleCA4M2FiZmU5OTYxMzguLjU5MWY5ZmRkMGVjNCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jDQo+
IEBAIC02NTQsOSArNjU0LDEzIEBAIHN0YXRpYyBpbnQgaXdsX212bV9tYWNfY3R4dF9jbWRfbGlz
dGVuZXIoc3RydWN0DQo+IGl3bF9tdm0gKm12bSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dTMyIGFjdGlvbikNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpd2xfbWFjX2N0eF9j
bWQgY21kID0ge307DQo+IC3CoMKgwqDCoMKgwqAgdTMyIHRmZF9xdWV1ZV9tc2sgPSBCSVQobXZt
LT5zbmlmX3F1ZXVlKTsNCj4gK8KgwqDCoMKgwqDCoCB1MzIgdGZkX3F1ZXVlX21zayA9IDA7DQo+
IMKgwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+IA0KPiArwqDCoMKgwqDCoMKgIGlmIChtdm0tPnNu
aWZfcXVldWUgIT0gSVdMX01WTV9JTlZBTElEX1FVRVVFKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRmZF9xdWV1ZV9tc2sgPSBCSVQobXZtLT5zbmlmX3F1ZXVlKTsNCj4gK8Kg
wqDCoMKgwqDCoCB9DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqAgV0FSTl9PTih2aWYtPnR5cGUgIT0g
Tkw4MDIxMV9JRlRZUEVfTU9OSVRPUik7DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCBpd2xfbXZtX21h
Y19jdHh0X2NtZF9jb21tb24obXZtLCB2aWYsICZjbWQsIE5VTEwsIGFjdGlvbik7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9zdGEuYw0KPiBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3N0YS5jDQo+IGluZGV4IDUx
NWRkM2UwNzMwZC4uNzg0YTdmNzJiODE5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL212bS9zdGEuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9zdGEuYw0KPiBAQCAtMjA4NCw2ICsyMDg0LDcgQEAgc3RhdGlj
IGludCBpd2xfbXZtX2FkZF9pbnRfc3RhX3dpdGhfcXVldWUoc3RydWN0DQo+IGl3bF9tdm0gKm12
bSwgaW50IG1hY2lkeCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqcXVldWUgPSB0eHE7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YS0+dGZkX3F1ZXVlX21zayA9IEJJVCgqcXVldWUpOw0K
PiDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gQEAg
LTIwOTIsMTEgKzIwOTMsMTUgQEAgc3RhdGljIGludA0KPiBpd2xfbXZtX2FkZF9pbnRfc3RhX3dp
dGhfcXVldWUoc3RydWN0IGl3bF9tdm0gKm12bSwgaW50IG1hY2lkeCwNCj4gwqBpbnQgaXdsX212
bV9hZGRfYXV4X3N0YShzdHJ1Y3QgaXdsX212bSAqbXZtLCB1MzIgbG1hY19pZCkNCj4gwqB7DQo+
IMKgwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+ICvCoMKgwqDCoMKgwqAgdTMyIHRmZF9xdWV1ZV9t
c2sgPSAwOw0KPiANCj4gwqDCoMKgwqDCoMKgwqAgbG9ja2RlcF9hc3NlcnRfaGVsZCgmbXZtLT5t
dXRleCk7DQo+ICvCoMKgwqDCoMKgwqAgaWYgKG12bS0+YXV4X3F1ZXVlICE9IElXTF9NVk1fSU5W
QUxJRF9RVUVVRSkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ZmRfcXVldWVf
bXNrID0gQklUKG12bS0+YXV4X3F1ZXVlKTsNCj4gK8KgwqDCoMKgwqDCoCB9DQo+IA0KPiDCoMKg
wqDCoMKgwqDCoCAvKiBBbGxvY2F0ZSBhdXggc3RhdGlvbiBhbmQgYXNzaWduIHRvIGl0IHRoZSBh
dXggcXVldWUgKi8NCj4gLcKgwqDCoMKgwqDCoCByZXQgPSBpd2xfbXZtX2FsbG9jYXRlX2ludF9z
dGEobXZtLCAmbXZtLT5hdXhfc3RhLCBCSVQobXZtLT5hdXhfcXVldWUpLA0KPiArwqDCoMKgwqDC
oMKgIHJldCA9IGl3bF9tdm1fYWxsb2NhdGVfaW50X3N0YShtdm0sICZtdm0tPmF1eF9zdGEsIHRm
ZF9xdWV1ZV9tc2ssDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTkw4MDIxMV9JRlRZUEVfVU5TUEVD
SUZJRUQsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVdMX1NUQV9BVVhfQUNUSVZJVFkpOw0KPiDC
oMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KDQpUaGlzIGJ1ZyB3YXMgYWxyZWFkeSBmaXhlZCBpbiBv
dXIgaW50ZXJuYWwgcmVwb3NpdG9yeS4gWW91IGNhbiB1c2UgdGhlIGRyaXZlciBmcm9tIFsxXQ0K
dW50aWwgdGhpcyBmaXggd2lsbCBtYWtlIGl0J3Mgd2F5IHRvIHRoZSB1cHN0cmVhbSAocGxlYXNl
IHVzZSBtYXN0ZXIgYnJhbmNoKS4NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvYmFja3BvcnQtaXdsd2lmaS5naXQNCg==
