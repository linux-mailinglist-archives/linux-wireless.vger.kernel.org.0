Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D46673D75
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjASP0Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjASP0Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:26:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E84380882
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674141983; x=1705677983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/wPiSa08v6/7tNv6PyTGFwJbrb09RZf/ZzyYvZ9fMCs=;
  b=Szj+bS5jRdbf7NElf7FfRDrYqBUIeCyx1Uk1VV3Ycfi+JSlNgnF/hknY
   2rJDeb3AJlyHhPOGCjm2ClOfSAmrcVxwRdtRnMX+mIzx3jI47TdW3Ar1E
   Lf8+knvQr20eIweJ7wKD6zyTSW2YQ3gv432M1o4yZz74ev7xDstnfk0Tb
   XodnRQIx+UHJAD9jIW6Xw/akXMWdUYL40ob128lHt6dH1NVVD3XdSFjvK
   o0bJmOivtQRSNhiP8T2VNFi7maHiXhy1xLKykhs4cbRCpPcNMyrhIVg9N
   s0dd1CyETIemjl4aD4UkUEAUEPA+LCTzSMsD6+7BWPHzvFlhK4Bu1QzFr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323001453"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="323001453"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="834003498"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="834003498"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2023 07:24:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 07:24:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 07:24:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 07:24:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8S0aw8nCN3Y9FULCopO/XlAcUeZ8ufjKa8P8IywY6Np34N3naPpUfCamz89gyt9YJDjUqDV74dB7/QVpMlG1INo4h9c1D5JVyVYXEPGvZOaYPruM6bzTiHYbj3Vn2u8QBsiKTkLSweYb7ABZ70bS6VHI/pNzMZ3rzPT/i+KCwWZk7u8DIEZZCTqngJuX/ScR99kBM0C045uZUU8698Bb0ak9bh8bIqTBm0V8wMKUWu2vzUgMH7R7LCOAMZWjk1YGvW00+XHWH8Sr1UmvNWiNjl4hAMdjeP/WrDpG/adgC4QeeC17I1asnjWGrVDzFQSbPbUNV28m7WJd7maeUba9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wPiSa08v6/7tNv6PyTGFwJbrb09RZf/ZzyYvZ9fMCs=;
 b=hrW4RxshpDmgS7bDP3IP2FF4uXx4meIm2kJ3omAxTwPg/cM38EE7BFWH8GIuiS8OX/iv+RAl8OmSwXqwxAAQw+OZpPCeIkM2MLygnN3dVqnnftyEbeeUjta6AHpfi4DYgy7wD82ZjvMLwOK13eJSQpnE4i2DcsQQ4PAeyqqawPZSFvw0V8xkDao87WSArFI7maD2Mla5pT1DzuAclnCsDg2ur6DQt5b1MBz3FBJSD/1CrXIYKl/GA7wApXcf+fxeHQNOwgwqjjoF2I4qHChy5bsSe3LcmlU/0A4iWcAFaj+HWPAGeGH3j7ikwllc/w/U1cfwCxM6Q3NFI3Q0EQA5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 15:24:41 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 15:24:41 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "aiden.leong@aibsd.com" <aiden.leong@aibsd.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v2] wifi: iwlwifi: pcie: add support for AX101NGW
Thread-Topic: [PATCH v2] wifi: iwlwifi: pcie: add support for AX101NGW
Thread-Index: AQHZIYy0IWDTO8uq6kCpKwgXsl9UY66l8TGA
Date:   Thu, 19 Jan 2023 15:24:40 +0000
Message-ID: <cd1eaa92ba4e5cc8da9715368fbcd1249335977e.camel@intel.com>
References: <20230106050548.9112-1-aiden.leong@aibsd.com>
In-Reply-To: <20230106050548.9112-1-aiden.leong@aibsd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: 8b584d75-96b2-4ca0-80e1-08dafa3148e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcNgkGU757BHVQtH0AoIuE88pNW/RjTccIHZjyjC5T+L+94LCMUr0WsO35Hx5VwA0cR14O5XAVfNoL9YO3/ORPADr1+KJpsKaOS/BxDtd1vecj+EeqIaNIRJsx5F0OJx4LXoDJUD0ROTNvsbH+nEpMgRInSIVmTkO+UxjCbshK7rHR6qWUmRK7WNbBwMv3QB6+gshOHY/GRl1oUq2BcscIAskrDUTgSnONGcE1xaUTuFbvhNVxcN+eDcCM8Q4JVAXjaUCu6FkszqfjKJBe2nVwl65PUuYRusanv9YXzQTGM0tXqfbzZMtMBT+WgIzQte4/b2IBTtzFNMT2J9AMXn+41BVsCi3KjyZ1oM0HY+Thx/snBAA2+zIPlbTE95jM549KHuiOtzDMp3E/qwnZackCkdU3OYj5gEyaWQxv1eNkwWNREbsO2QabLIXiwWgEWZGGw18LY5tiYrSM791rspYduTndxzsY/hI41wEg6yaTd9hCKXdk7sRf0jjccHaERUMN8pad9lcx21l+6cl2wdAz+idUl95BM8YMSJa8MvW0Q9UFjqa9lzRhwvnfqeS1cn4gWMB3ZN7rR9bECSTRG5s4adyVlIeU2+uaSotaTTTXqVXwaDqAMO8i6oNXF4ztlsbugFFkiioalqt1QvJoaZ13SFRVmmE/Zb1UQBepsecFBRcO3D6XZrNFGwVG4YU9iRO9/Mq3jYKFZUF17Bh347nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(36756003)(122000001)(66476007)(76116006)(2906002)(66946007)(91956017)(8936002)(5660300002)(66556008)(82960400001)(38100700002)(316002)(54906003)(110136005)(71200400001)(86362001)(478600001)(38070700005)(6506007)(6486002)(64756008)(8676002)(4326008)(41300700001)(66446008)(186003)(83380400001)(26005)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um1JZ3Q1TzNqOGFQVld6Nk9pWFUrZERSYy9VT25QSVRwbXV0OG5iYnc3ZXhs?=
 =?utf-8?B?bUZCVG1BQnhZcjQrT1dmUWJ2VWJiRW43UElFWVV3RmRPcmtkdGlFemRpT2g1?=
 =?utf-8?B?UGNvTUJXZmdacFpvYVpiSGpYTiswTzBaa1JiNkZlU3ZXUFFkWU5mdHRLSStr?=
 =?utf-8?B?UkpHK3V0cGJnM1R0ZGdIaHNVb1NReHZXV0dBdVptdzlwa1gxTHhJbTR5VytH?=
 =?utf-8?B?Q0hjK0d5QURvRWlkNVVvWTl4eDJpTVNtdUQ2Z2Jqd3FuWmtjVnF6cXpBRzUr?=
 =?utf-8?B?Y292eUQ5Q05oWm9DUGlvSmFLaVpoLzJYY0hLOUgvUGRONVF1YWtFR3o1MGht?=
 =?utf-8?B?ZjJnRmNVNlZxR3lOdFhFT2kxeldUUnBmMlVyb2oraHc5NVZIV3puYnJ1RGtY?=
 =?utf-8?B?b3B2d3E2VzJMU3Q5bHVQK1dtdzF5eXllZmVrbGNjT1JWTVF3YkJ2eFc0MTNv?=
 =?utf-8?B?S1ZENDJtTE1zSjdGdEMyQnpZL0ZQRjRhUjVYNFd4SDdOU2hqb2J6ZWtCb2dO?=
 =?utf-8?B?aExFVGgralV4MjI3MlNCWmNCTFlGK0ZScHZDc3lMUmFPZTVaOXh5OUl3OXlh?=
 =?utf-8?B?UG9zOWVOQm81TkMwbkhNd25QMURQQnZteEZkU0t4cS9PUU5VNjRQTkZBUmh5?=
 =?utf-8?B?Um9WamNSTytlY0QyRVFQaittb3NDNHg2WWY5VE0zV0tJQVg5S0JWQWpMMEpE?=
 =?utf-8?B?bWU2ZkdXeFEzdHpZdHByWjNncUxra1VvMk0ybDNsclFUaW41MEMwM1pMTHk3?=
 =?utf-8?B?OHZjS2ttcVozbVU0OTB6a3FVc3VCZEFWSUhOcnNlWDlack1Wb3MrNktMUmlT?=
 =?utf-8?B?VlBjK1FLdVpSeDV3YzQrdllsbFZ4eGxScnZDc2d3Q1haUkpqd1hUMUVobERx?=
 =?utf-8?B?VVUxYU9pUUpnYXMvaHY3Z0VPc0toQ2h3dE5XdnRDZGRpaE50NGJDMUtTK3VD?=
 =?utf-8?B?dy91TGRrOFpaOWZTK3dsZm1HWVl1NFA1OFdDVlh6TS93YWxDTW14RGhqd1R5?=
 =?utf-8?B?K2pGRDQvSVB5VjdUQ2ZHZkVXaFRISDh1WjI2RGpEQWF2TzI4Q0dycHlSNXNV?=
 =?utf-8?B?elNSV0tIUjQwU3ZIYUhRWU5rVlNKQUNvS053YTIrRG1SOVAxSExOR1lQbUNp?=
 =?utf-8?B?SGQ3RmU2ekFhMHE4cUxtbWhwSXVMeGJtdGFCTUh2NEE5bHNuMU5FYTA3aGR3?=
 =?utf-8?B?OENwNG0wbnYyangzd0pBdjM1bzYrUHM1ZVJtM2FmeERHa0M5aVFlN3pDOTVu?=
 =?utf-8?B?SHpuWjFQSlpIRXR4dWlsOHB4Tm5ucVhaMjJHeGlHYUM4clBzakxQMG9RZC9r?=
 =?utf-8?B?MFNYTThkbVpFS3RRRjZTbXF0K1pxTStMNERUSWVuRkVxcGd1NzBKVFBnY1pr?=
 =?utf-8?B?SFVnS1NxNGNmaHFCeUtreHYyRVAwa3kxMXVzQ1ljL2FmSmVWTGpxUmtxL0hG?=
 =?utf-8?B?dHhlZDhjNDU4VWJyZk91WWtzRWtPUTFWVzdNZ0x2RnNQN3BmMTJhZjZxcHNW?=
 =?utf-8?B?YkJuN3BNZTdDOXZBVDVtVUlwd1dnTnl5NGcrTXFpYkpPZHAwUlZsbFV3UU1N?=
 =?utf-8?B?R0dDMjl4QXkxeTZJWDhKcWNrQVhoV2kwQ2lMMXN5ams3dTJVaGZtclJnc3Aw?=
 =?utf-8?B?SFpFOElxRHF0dUVtelh2TGVveUpESzFvYzFJTkZGQktZdWlJK2Q3WnhFSlVp?=
 =?utf-8?B?Mkl0VlgyT2NyM21kZmYvU1Ixa3FyVXA2elZIc1hicXNnTEE4NFJZNWNnT3kx?=
 =?utf-8?B?VEFEeVIvdlNQWllaSU8rdFlSUE5JQWJ6cVVwOUtBMnU1MGlCYldFMmFBWU03?=
 =?utf-8?B?VFBmUitwcTZoakU2end2OEl0V2tOL0phRUp5SnZXVVZqSmVsdzJqU2cydmR3?=
 =?utf-8?B?c1A3S1IyMm5ZMkp1dktPK0NBdWNNQThqSFJsekQ1L0NSejNIamd2c0N3cjRG?=
 =?utf-8?B?TnBuRTZ4U1ZHMTZaOXJyUWZ0VTJ0SVNaekVJbmNSTHlxYmp6T1VWRUVxUWw5?=
 =?utf-8?B?bWpHSk1DS3dkNW94WkRHSk5INUFqZHlKYVhwbWR2d3NkVkVFbjdGaUtLR3dQ?=
 =?utf-8?B?cXpLeUNhdXVWeXN3alFrbk1jRUdEOFJYQzAzRnEvSHVBQXFsSm5la1R0aGVo?=
 =?utf-8?B?NGp2ODhxVjVTdmhpVVNWblJiMVJwbWVpTW8ycURyTisvVHNXeDA0MFg5SGpB?=
 =?utf-8?Q?xe7Bc4B6qgYDmeHmvejeoeU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B78CFCE952FD434D907E9DF03FF858E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b584d75-96b2-4ca0-80e1-08dafa3148e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 15:24:40.9794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBby5c2x/eIWU1F9YxySIETxMqKnZIpIQ6HKTTj/iWoN6FuI1khUS/E09hCaIrAlTacdtna6wKo/bi3GXVmigeskTXfcXwR5eP5WGMj7R5s=
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

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDEzOjA1ICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToNCj4g
Rml4IGEgYnVnIGludHJvZHVjZWQgYnk6IA0KPiBjb21taXQgMzJlZDEwMWFhMTQwICgiaXdsd2lm
aTogY29udmVydCBhbGwgUXUgd2l0aCBKZiBkZXZpY2VzIHRvIHRoZSBuZXcNCj4gwqBjb25maWcg
dGFibGUiKSwgc28gbm93IHdlIHBpY2sgdGhlIEZJUlNUIG1hdGNoaW5nIGNvbmZpZy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFpZGVuIExlb25nIDxhaWRlbi5sZW9uZ0BhaWJzZC5jb20+DQo+IC0t
LQ0KPiANCj4gSSBzcGxpdCBwYXRjaHNldCB2MSB0byB0d28gc3RhbmRhbG9uZSBwYXRjaGVzLCBz
aW5jZSB0aGVyZSBhcmUgbm90IHRoYXQNCj4gc3Ryb25nbHkgcmVsYXRlZCB0byBlYWNoIG90aGVy
Lg0KPiANCj4gLS0tDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2ll
L2Rydi5jIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvcGNpZS9kcnYuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNp
ZS9kcnYuYw0KPiBpbmRleCBhNDZkZjEzMjAzNzIuLjVkNzRhZGJkNDljZiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYw0KPiBAQCAtMTQ2
MSw3ICsxNDYxLDcgQEAgaXdsX3BjaV9maW5kX2Rldl9pbmZvKHUxNiBkZXZpY2UsIHUxNiBzdWJz
eXN0ZW1fZGV2aWNlLA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFudW1fZGV2aWNlcykNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsNCj4gwqANCj4gLcKgwqDC
oMKgwqDCoMKgZm9yIChpID0gbnVtX2RldmljZXMgLSAxOyBpID49IDA7IGktLSkgew0KPiArwqDC
oMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgbnVtX2RldmljZXM7IGkrKykgew0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBpd2xfZGV2X2luZm8gKmRldl9p
bmZvID0gJml3bF9kZXZfaW5mb190YWJsZVtpXTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoZGV2X2luZm8tPmRldmljZSAhPSAodTE2KUlXTF9DRkdfQU5ZICYm
DQoNClRoZSBmaXggaXMgb2ssIGJ1dCBwbGVhc2UgdXBkYXRlIHRoZSBzdWJqZWN0Li4uIEl0J3Mg
bm90IG9ubHkgZm9yIHRoaXMgc3BlY2lmaWMNCmRldmljZSwgYnV0IGp1c3QgZml4aW5nIHRoZSBv
cmRlciBvZiBzY2FubmluZyBpd2xfZGV2X2luZm9fdGFibGUuDQoNCg==
