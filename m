Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64C6673D6B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjASPY7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjASPY5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:24:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00C48A0E
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674141896; x=1705677896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bBzpOdG7cVQsaGOQikCHavJUCqir2eUYTWoQkCN2xRE=;
  b=Uu8b99g1E+OZXD2gPgtNMBc67RCOY5GTyY86n8zWFLUvN5AV8rTVuhj8
   tyCqmsVdzFgaUfO12SN59n8zpaRMbHmPUSx8W7I88Ub2e66A/MzbflQL7
   xSPmUFQgQTiy6O1lh5DeTgjl3+8woEa1Y+ysLeFcb8G/YckWuhNKwOrEC
   D9bo5aJGMpbraoi7FaYuNkOWy/DXDdxl/nHx++SDaLocOFREiXxjzuQNb
   /ODIA5q+KF27DkUCk6w268SBQp/FO+wYzzBn0kWaQExlfRnujz4xLWo6E
   D4jgRoqeJE9grMTWIZMV+3GP4nLWB1c59gmTPYUh/4AymipeHLYQ+OqvA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323000603"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="323000603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:22:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="653413591"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="653413591"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2023 07:22:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 07:22:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 07:22:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 07:22:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 07:22:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/ROBlUJCUyrDLG1mB/NdCCBjqGR2ysAXpWKp6xxK8kS6r0ms4CY73wcUMCuZo4tp1q/0iIP4wgI3rGkT3bn823TF89hJQD5EoOaVoNoo0BDpiXmSXoc5tPtZgDv9/f8n18gIJyCSRpU8PiL79iTspg6ABgpF8dfzuk9wGf2CnRuyOEavYMs+Ro16V4mS5Amr5Zw3rFPxRI5soUDNYaBNXh+JixIh1NjlF34K7brBxAuLx8HlqY7BZAE2ruDAeayvnlT0ecA7A9PGkgOT7lxIHpJb/zuOaBBhdLma9vsxhfiMbcR+QbzeA5/qDJqlXNMtHR5EGlhWBOqFdkkRtRd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBzpOdG7cVQsaGOQikCHavJUCqir2eUYTWoQkCN2xRE=;
 b=TsU+m5vRl3jwEh3/F9RJEUiAezpeP1gnOq93tMevphLxJ7jmcE6Uw8063IPQzBVMAGGARhGgTAvA4KZUgDL9vq/wwxRCv266eHNA9de51kcz5/KKZ11+kXCu9habASN1rIMSahcovyfAt7e0yuVSW7dTAaQTl5wzN5uvO3lrSMHQjIqioaWvopCvE5PlC8XN7B2hLH9iDAID0y+qG+N7EE6yI5h48HePXqr55XkZKc27F/GabX8MNJQJ6BYqg0+FTj0RuGQffJ/MOI6waRgfi1gDm2w9lR3Yk6TguscG0x4ZkXVMT6R39BR+Mem2uv+p1JS8srT5dGt3nDJKN+FOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 15:22:29 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 15:22:29 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "aiden.leong@aibsd.com" <aiden.leong@aibsd.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Thread-Topic: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Thread-Index: AQHZHlOZDZ7U6eVjPU258u4ky3iksK6LIIwAgAAQ7ACABDLjAIAAIh+AgBZwi4A=
Date:   Thu, 19 Jan 2023 15:22:29 +0000
Message-ID: <fdeee5bb7659483a0609fde606f216851b9422f4.camel@intel.com>
References: <20230102024021.2900-1-aiden.leong@aibsd.com>
         <b5b67842-17a2-f2b8-3c58-b6242b77e5b7@aibsd.com>
         <cef2bd45d48127dfb65d8cf7243ec09cfbb30921.camel@intel.com>
         <2669054.mvXUDI8C0e@eq59>
In-Reply-To: <2669054.mvXUDI8C0e@eq59>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: dc5fa7dc-e114-420e-863d-08dafa30fa67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7d7C8k4jpp9fygh5O61WVC9cbkZOSGYl49Esx0Z4iKi8jOG3gYVC+Sk3/usOoViT/QUCbt/zunG1KR1LXl/DJC7RkuHK9ITmGsX3FJrTfaTiXDsEa6MtzpnUKkjVdDuJ5Snlr9bFJazFwaO+zSlQfPy39kR+92/xFWCoMc1GQLuJ/nBrxEUzjm+COGgdAfVB6JRVtRZphqRVvaxkca91WbwwI8drtfJFEDQLaSHihkUUHyYvFnwlokMFOW5foNojGUljJwzRMhDbEeDbYSRQXInLyr/44q6Gzh496DK6D0sFsSwe4R91OlibVFyGbvXUsdKWs2ldAGpONHG8o3siNK58WrOJzYo1wyW81Dujc99r3QSKpR8N38dG693EfA8t4t5pYgLOQyBS0KTtTv/0XA/jurieyZKb362IGhNhzE1sgWkQKIKIL4rY+NTkkkZp49UTvK12BIfzBbhNVmbNHo3d3z2JiPQFZs+qM0/3ra1TUup1gmye10biIzqQ4tM+4NH6i9lXiB7o6cLiaP9aFkkHlMhn8jA7LFFSaG+Q8mvoayXU7CY6pTBv/A6N7p5s1N4M9FYiIhaXqObDcoFaqtGNTv3L12BvraoC/MJiEa8/CfcUJ3u2hbpqrxpfrJMbcLeh8/0tGbtn0xmIVdhS+4YA9R1MWxBi0LIz3uFxU6T05sFBAfOtday+oRG9SpkNfrQ8V3CMHolw2cRJONv2rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(36756003)(122000001)(66476007)(76116006)(2906002)(66946007)(91956017)(8936002)(5660300002)(66556008)(82960400001)(38100700002)(316002)(54906003)(110136005)(53546011)(71200400001)(86362001)(478600001)(38070700005)(6506007)(6486002)(64756008)(8676002)(4326008)(41300700001)(66446008)(186003)(83380400001)(26005)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUM2Yk9KREswSVRlSnl4WjNMS2R0bUNFVEFUbDRLZUxZZ3JuL0xaa0dwV1l5?=
 =?utf-8?B?OUFPaEJUMVpuVlFNNTBIL215NkMvd2VGbEs0RVhlZDM3cUxaQ2J0cFQyOVRh?=
 =?utf-8?B?SlptWklHODdsV3htcC9YSEp1UmdyazExRVY2ZS85a0h4VEhtRk50cVB3S2lQ?=
 =?utf-8?B?bSt0c0RyQ1liRHNjMTBXL2NIU3IzZFozSG5hZU01cjVsUXg3eGFELzRLcmhO?=
 =?utf-8?B?dE5CMXdoQUxxNnFaVUo5WjRxSStXNnZxWkw4a1dYNUhqZEV3V0VGNkFzYisv?=
 =?utf-8?B?Y2dtbkU4MlRuS2V5c1JITk5XWTdCUllQRTdXeXV2RXRzUGR2TEdQaW5yQjFn?=
 =?utf-8?B?TVJ4dkFSOFRzUUc2Mm1Ic1BuWjhVRWNyUkczd3hHcGZkd1VWdzM2ZTBIQy9z?=
 =?utf-8?B?K1dJSDN2Nzc3V2s4RklLOFhJcm9EQ0FuSmkxTng5N0Z0anlqdDB4MmNxcmc4?=
 =?utf-8?B?eTRpRjhidVhHcThBeWw2MVJHc3dza2FraGhRbVBzYWpJcXRjT1ZEaUk3RTZN?=
 =?utf-8?B?ei9lOWFyUHRzMDVBUjJWSnR4VSsrbm1PVGszN3lka1JZTEtJenJqdkdpaEdv?=
 =?utf-8?B?OGJFaEhKK0YzMUVIL3hJYWN6UVZNcVAxS2lWbC9scnh3YTNtNnNRWGlRakdl?=
 =?utf-8?B?a3FablA0R3l2bE5iMDA2cndtYWhHY1Y1aXQrcVN0TUNNR3pBaXcyQTVwbk5C?=
 =?utf-8?B?M1c0ZW44cnh2L2JmeWZiSkJPY3FaU1BCV0tIdm9Va0ZkWUlOblBWaE13T2ww?=
 =?utf-8?B?RkRPWTBBeHF0VjU3Mlc0K1VVY0lKMGZCY0l3YWlMdThyb2QrUEwyaXUzUnZB?=
 =?utf-8?B?TUs2b24vVzhSMSt6ZkdLL3o3YzVkNkEyMXV0dHJuekUzamFtR0ZyKzZORFVT?=
 =?utf-8?B?V0NiZUE1RDZRYjg0RXNXOWxqR01IbFdlR09xdTk1aFBCYUxZc2lnRUtmVzFk?=
 =?utf-8?B?bDJ5TGtHajBxR2paQXRUV3VqYnF4L1F5VDlobWdRRlZWUDlhQlJ6MXdOWjBO?=
 =?utf-8?B?dlVLaXk0ZWRpNk9sOGx3R29TWW1GMGdhMldYNm93czNoWHcxT2VFTHhKaTQw?=
 =?utf-8?B?UmNvYmZFSjJhc2Zza21GeE9vVGVHYVZqOFpOZUY2VjBRT0xmUGp5QzlBNGY3?=
 =?utf-8?B?eUVIZnphaHVrNnVJTVl5M2xtdm9la2hUd3VsRTVPbDhsbFhvTlFXMWNvQm5Z?=
 =?utf-8?B?cHpNRGczdWk0UEViWURScTFkSDc4ak1VOXNqYytTUEpRN3dNOVRDN2QyanBR?=
 =?utf-8?B?SlBFNGlLSG5GbTdJbkQ1UUdHNUtuTDRYbXgxMXpSVGhERU85Unl0Q25VbndL?=
 =?utf-8?B?Vkc2RDR5VE1rT2tnZ2U0WGF5bWNUU1NjRFRFbHRZWXQ3MVc3eGtNTCs5bkJK?=
 =?utf-8?B?ckl0QmxiZkR3WWxsbVRWdkZQbXFaSUxmY0VaY3pVa0Q5cHUwcEtmcmVDQ2xu?=
 =?utf-8?B?VmI4RzJpR0VIMVQxajdOOVdGa2xmNUUxdFFROFJnZ1dNSFdtaU1nNHVGdnR6?=
 =?utf-8?B?UGQ3L1lmcDlWUE5MVEMzT2RUNkFpdU9FQlIybWNRdDVJSEN3c0VtMlZKWW1B?=
 =?utf-8?B?WkhXUWp6Q1c4NWNLR0hTS3ZOcUErZWlaQ0NGS01YWUpyTTU5L0hJbnVTVWpn?=
 =?utf-8?B?L1ZFeUQrTk91SnQ1ZWRlMXY4S1hYTXkrSExtNDFKeE16MjFPWnpLZWdYejVq?=
 =?utf-8?B?TVhSaVpCTWlTbkRkeVNoa2tJcDlTN1hiZHFaMk04Q21VeisrUkY2OUxVZytK?=
 =?utf-8?B?cTA0elllT0hiWml6NlI3Q1MrSGtpSVQ3YTRNT3BPMUx5WVdWUVVoaFlUM28x?=
 =?utf-8?B?bWI5VHB5cUhLWE1WMFJtZFJCeTZCT1kwVVJ3S3BMazNzOHh1R3BqbnhiL1NB?=
 =?utf-8?B?NmV3RGFIeWpBK01YRHozMXhXQllUcGFiVUVhYm16TThxdzN3QzNFY29IN0JL?=
 =?utf-8?B?dTBwTnpmblFabFFMTDdKWVVKSFFLWXZhdVJZTDlPOWgyb3o1dEs2c1RIQ3Y0?=
 =?utf-8?B?R1lqWTk3M1JaVUQ0dHdnUVNMbTU0NUhZT3A1Vzc0ZU9CcUtHa3doeG5iKzBV?=
 =?utf-8?B?VTV5Sng0SzJ2TmZ3MEswdjJoWk9BMGRia1F5Q2FaamV5TktkNUVGNmVHU2lC?=
 =?utf-8?B?cW9IRnY2WEZ3UDNIYXY1anpJK2FHeHJPT0FNbU9jMnpNL2RLSlgySkVDWUZQ?=
 =?utf-8?Q?uOcuIwZFCs2Br1y1xQfvKJI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA58B84E3FEC840AA327CD202A98376@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5fa7dc-e114-420e-863d-08dafa30fa67
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 15:22:29.2496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVh1NvftJ4aK3Rnl1S+WMcOzCelmPsDJc+Uujk+mAZ4CrdLRFXlb2VLNL3edJ2Q4BIN+g6L1im5y07GqmqvzdjuK/hWzvfgZSeh/+liSaD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTA1IGF0IDE2OjQxICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToNCj4g
T24gMjAyM+W5tDHmnIg15pel5pif5pyf5ZubIENTVCDkuIvljYgyOjM5OjUyIEdyZWVubWFuLCBH
cmVnb3J5IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMy0wMS0wMiBhdCAyMjozMiArMDgwMCwgQWlk
ZW4gTGVvbmcgd3JvdGU6DQo+ID4gDQo+ID4gPiAxLiBJIGtub3cgbm90aGluZyBhYm91dCB3aGF0
IGB0eF93aXRoX3Npc29fZGl2ZXJzaXR5YCBpcy4gSXQncyBqdXN0IGEgDQo+ID4gPiBoYXJkd2Fy
ZSBmbGFnIHRvIG1lLiBNYWluIGxpbmUuDQo+ID4gPiANCj4gPiA+IDIuIEkgaGF2ZSB0aGUgcmVh
bCBkZXZpY2UuIFRlc3RlZC4gVHdvIHBob3RvcyB3YXMgc2VudCB0byBMdWNhIENvZWxobyBhcyAN
Cj4gPiA+IHdlbGwuDQo+ID4gPiANCj4gPiA+IDMuIC9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL3BjaWUvZHJ2LmMjTDYyMw0KPiA+ID4gDQo+ID4gPiDCoD4gSVdMX0RFVl9JTkZP
KDB4NERGMCwgMHgxNjUxLCBraWxsZXIxNjUwc18yYXhfY2ZnX3F1X2IwX2hyX2IwLCBOVUxMKSwN
Cj4gPiA+IA0KPiA+ID4gVGhlIGRldmljZSBJIGhhdmUgaXMgMHg0REYwLCAweDAyNDQuIFRoZXkg
c2hhcmUgdGhlIHNhbWUgZGV2aWNlIElELg0KPiA+ID4gDQo+ID4gPiA0LiBJIGhhdmUgbmFycm93
ZWQgZG93biBteSBjb2RlIHdpdGggX21hY19zdGVwLCBfcmZfdHlwZSwgX3JmX2lkLCANCj4gPiA+
IF9ub18xNjAgYW5kIF9jb3Jlcywgc28gaXQgc2hvdWxkIGJlIHNhZmUgdG8gb3RoZXIgZGV2aWNl
cy4NCj4gPiA+IA0KPiA+ID4gSGFwcHkgTmV3IFllYXINCj4gPiA+IA0KPiA+ID4gQWlkZW4NCj4g
PiA+IA0KPiA+ID4gT24gMjAyMy8xLzIgMjE6MzIsIEdyZWVubWFuLCBHcmVnb3J5IHdyb3RlOg0K
PiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwgMjAyMy0wMS0wMiBhdCAxMDo0MCArMDgwMCwgQWlkZW4g
TGVvbmcgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IEFYMTAxTkdXKDB4NERGMCwgMHgwMjQ0
KSBzaG91bGQgaGF2ZSB0eF93aXRoX3Npc29fZGl2ZXJzaXR5IHVuc2V0Lg0KPiA+ID4gPiANCj4g
PiA+ID4gV2h5IGl0IHNob3VsZCBiZSB1bnNldD8gV2hpY2gga2VybmVsIGRvIHlvdSBoYXZlPw0K
PiA+ID4gPiBDb21taXQgM2Y5MTBhMjU4MzliMTM0MzZiZjBhMjIxODZmMTY5OGIyM2VhZmI5MSBh
ZGRlZCBBWDEwMSBkZXZpY2UuDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBaWRlbiBMZW9uZyA8YWlkZW4ubGVvbmdAYWlic2QuY29tPg0KPiA+ID4gPiA+IC0t
LQ0KPiA+ID4gPiA+IFJlZiBDb21taXQ6IDkzNTJlZDAxNjVmZjQzMTNhYjM0MGM5Nzk0NDZjM2Q2
NGM1MzFmN2ENCj4gPiA+ID4gPiBUZXN0ZWQgb24gbXkgb3duIGRldmljZS4NCj4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiDCoCBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUv
ZHJ2LmMgfCA1ICsrKysrDQo+ID4gPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYw0KPiDCoGluZGV4DQo+ID4gPiA+ID4gOTk3
NjhkNmE2MDMyLi5hNDZkZjEzMjAzNzIgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+ID4gPiA+ID4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+ID4gPiA+ID4gQEAg
LTk4Niw2ICs5ODYsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpd2xfZGV2X2luZm8NCj4gPiA+
ID4gPiBpd2xfZGV2X2luZm9fdGFibGVbXSA9IHsNCj4gwqBpd2xfcXVfYzBfaHJfYjAsIGl3bF9h
eDIwMV9uYW1lKSwNCj4gPiA+ID4gPiDCoCANCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIC8q
IFF1WiAqLw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgX0lXTF9ERVZfSU5GTyhJV0xfQ0ZHX0FO
WSwgSVdMX0NGR19BTlksDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSVdMX0NGR19NQUNfVFlQRV9RVVosIFNJTElDT05fQl9TVEVQLA0KPiA+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElXTF9DRkdfUkZf
VFlQRV9IUjEsIElXTF9DRkdfUkZfSURfSFIxLA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElXTF9DRkdfTk9fMTYwLCBJV0xfQ0ZHX0NPUkVTX0JU
LA0KPiA+ID4gPiA+IElXTF9DRkdfTk9fQ0RCLCBJV0xfQ0ZHX05PX0pBQ0tFVCwNCj4gwqArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgDQo+ID4gPiA+ID4gaXdsX2NmZ19x
dXpfYTBfaHJfYjAsIGl3bF9heDEwMV9uYW1lKSwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
IF9JV0xfREVWX0lORk8oSVdMX0NGR19BTlksIElXTF9DRkdfQU5ZLA0KPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElXTF9DRkdfTUFDX1RZUEVf
UVVaLCBJV0xfQ0ZHX0FOWSwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBJV0xfQ0ZHX1JGX1RZUEVfSFIxLCBJV0xfQ0ZHX0FOWSwNCj4gPiAN
Cj4gPiANCj4gPiBTbywgc3RpbGwgdGhlIG9ubHkgdGhpbmcgdGhhdCB0aGlzIHBhdGNoIGRvZXMg
aXMgdG8gKmRpc2FibGUqDQo+ID4gdHhfd2l0aF9zaXNvX2RpdmVyc2l0eSBmbGFnLiANCj4gwqBU
aGUgY29uZmlndXJhdGlvbiBvbmUgbGluZSBiZWxvdyBpdCAobG9va2luZw0KPiA+IGF0IExpbnV4
IDYuMi1yYzIpIGlzIGVzc2VudGlhbGx5IHRoZSBzYW1lIChidXQgd2l0aCB3aWxkY2FyZHMgaW5z
dGVhZCksIHRoZQ0KPiA+IG9ubHkgdGhpbmcgZGlmZmVyZW50IGlzIHVzaW5nIGl3bF9xdXpfYTBf
aHIxX2IwIGluc3RlYWQgb2YNCj4gPiBpd2xfY2ZnX3F1el9hMF9ocl9iMC4gVGhlc2UgdHdvIGNv
bmZpZ3VyYXRpb25zIGRpZmZlciBvbmx5IGluIHNldHRpbmcNCj4gPiB0eF93aXRoX3Npc29fZGl2
ZXJzaXR5LiBUaHVzIHRoZSBxdWVzdGlvbiwgd2hhdCBpcyB0aGUgcmVhc29uIGZvciB0aGUNCj4g
PiBjaGFuZ2U/IERpZCB5b3UgZXhwZXJpZW5jZWQgRlcgY3Jhc2hlcywgdGhyb3VnaHB1dCBkZWdh
cmRhdGFpb24/DQo+IA0KPiBDb3JyZWN0Lg0KPiANCj4gMS4gVGhlIEZXIGNyYXNoZXMgd2l0aCAi
Tk1JX0lOVEVSUlVQVF9VTktOT1ciLiBOb3QgaW50ZXJmYWNlIHNob3dzIHVwIA0KPiB2aWEgYGlw
IGFgLg0KPiANCj4gMi4gV2l0aCBpd2xfY2ZnX3F1el9hMF9ocl9iMCwgaXQgd29ya3MuIEhvd2V2
ZXIsIEkgZ2V0IA0KPiAiTk1JX0lOVEVSUlVQVF9VTUFDX0ZBVEFMICIgaW4gZG1lc2cuIFRocm91
Z2hwdXQgZGVnYXJkYXRhaW9uIG5vdCB0ZXN0ZWQuDQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cg
aWYgSSBzaG91bGQgc2VuZCB5b3UgbW9yZSBpbmZvIGZvciBmdXJ0aGVyIGRlYnVnZ2luZy4NCj4g
DQo+IENoZWVycywNCj4gQWlkZW4gTGVvbmcNCg0KU29ycnkgZm9yIHRoZSBsb25nIGRlbGF5LCBp
dCdzIGFjdHVhbGx5IGEgYnVnIGluIHRoZSBkZWZpbml0aW9uIHRoYXQgd2UgaGF2ZS4NClRoaXMg
ZGV2aWNlIGhhcyBvbmx5IG9uZSBhbnRlbm5hLCBzbyBubyBkaXZlcnNpdHkgaXMgcG9zc2libGUu
IEl0IG1lYW5zLA0KdGhhdCBubyBuZWVkIHRvIGFkZCBhIG5ldyBlbnRyeSwgd2UgbmVlZCB0byBm
aXggdGhlIGV4aXN0aW5nIG9uZSAodGhlIG9uZQ0KYmVsb3cgdGhhdCB5b3UgYWRkZWQpIHRvIGhh
dmUgdGhlcmUgaXdsX2NmZ19xdXpfYTBfaHJfYjAuIFBsZWFzZSB0ZWxsIG1lDQppZiB5b3Ugd2lz
aCB0byBkbyBpdCwgb3IgSSBjYW4gZml4IGl0Lg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIG91dC4N
Cg0KDQoNCg==
