Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67765E5AB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 07:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAEGj7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 01:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEGj6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 01:39:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A049FDB1
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 22:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672900797; x=1704436797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W3AVVQwqgUswCBqDdmIE9CK9Q2Ia+RuqW3O76CerVhU=;
  b=hgnChi+EBY+AA08+PkEUyKqPbeRKB1BzUr6i3feG6/882u2Q7NHuqdpT
   LGZrjNmY7yJqsMIkxvWzB1STqWOGubpqSF8MZ68x513Q0uJT+IV+W5zMt
   qptW3uIfD+tM1jiiu+ndxv6m6BFuT3OP36iQQt9y/44/Up3OVAZnnvnv1
   mbewLJ9MT50073faK4bNC4evRzCaYhKeLKAd5u8xVAvE+xTRquHnqqdqr
   SZD8RBPXBiCcdWE+7MPMLXeTOTzKvyzsq6lsmLTRcwxFXpCyfZW8ot4sx
   1VbX0THy37c1+lgQ1Q1FIf+euDGyZiClqPuzggaInelK3fmIsCgKJ8/Ey
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="309901265"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="309901265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 22:39:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="648821830"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="648821830"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2023 22:39:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 22:39:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 22:39:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 22:39:54 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 22:39:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVpIA8pkX7XnEIxcmOsZZpkTZ8CLei4pOSIXo6h8iJiGOxhBXBVGvy18xV5k9lNTX+heNb8exS/jPKTHTU2LZsM0nvPyNjDGowB2Bv1y3EVYIDM2d8iuK4KYmUzXZvjLIxD4o64Twc7XE3ZnZgr28EGNprR2OM0XegWWqcx6LNhTLEP6I8Qj26780jJzmsJLZpbWQ6Lliz8mS2RctU5nzRgt+ApudgHzK3F31Jad9IQRaAhRdNjMGvl8eAWNr1Yd2DLURIbAzrubvs0kSKcQHxB7Ta8+TVy3HN2husBlv9xP2sjMwWW/VYpZHejqsPyew9Ml6OLH6644X0wihPPaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3AVVQwqgUswCBqDdmIE9CK9Q2Ia+RuqW3O76CerVhU=;
 b=m1oCzB7EI0nYx6yuGaZkszH2pNLKLclJIz7uscJpbQLc/stex4bCqin9MBv0tt7BvuWvm3PbAZ/NwQQXpWckHB46LR5bG8KYwXtXWSWGy2YoihG0pFczD5fsxX1ulRE7v+Mb7QQdWJeHDdHlWndWUUUuSLaOB3T/U5FgMbaDyo1ATpkGg162OyNurgz6zUOyxu7iaXonw5nAUkOSo32NnNXxKBgqCQJUNSENV+bTYsaKhkA7scmeFBYxqkSqCsMnyx9hkh3OvBBTY+QFIrkldZfUILX/Y2Q2qYUetIqstfQWO21yXIlOJxNEqWrprxeahKI30HKQAwxhT5O7BYWKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH0PR11MB8213.namprd11.prod.outlook.com (2603:10b6:610:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:39:52 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:39:52 +0000
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
Thread-Index: AQHZHlOZDZ7U6eVjPU258u4ky3iksK6LIIwAgAAQ7ACABDLjAA==
Date:   Thu, 5 Jan 2023 06:39:52 +0000
Message-ID: <cef2bd45d48127dfb65d8cf7243ec09cfbb30921.camel@intel.com>
References: <20230102024021.2900-1-aiden.leong@aibsd.com>
         <b1e7aabf9f1543fda0919a41ca97ead23b298225.camel@intel.com>
         <b5b67842-17a2-f2b8-3c58-b6242b77e5b7@aibsd.com>
In-Reply-To: <b5b67842-17a2-f2b8-3c58-b6242b77e5b7@aibsd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH0PR11MB8213:EE_
x-ms-office365-filtering-correlation-id: 6b894fa8-b943-4521-7886-08daeee7a656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWg3KTLTWwF72nCEmddx2mFZ/tNgENmlg52BHVl43sH/5Fvu3XGNYLBe3q0NrwyFfQYs+sVCeXKz0eziia6Z780a9ib7LgT2D7/BQz+gzDdRNDgBNE4UYIEqXAqcb37CIqKFLDdZonhcSMO9tuejtAmjjdiYv/9+P6f7og0rpSYAPl78zl2JBbhsPjswuSCdXnjo+L+d/j9omS4PTrNPwi7qaLlJm96EJRSsXnm3cAc5E2a+k525f+z5v3puNh1FLY1nf5PykTilZgJxEk9IvfQUGSglbVQM1FRQ2gWI3Sb6xe0L1SUztT3ZYvmU37OAWKEyKmBrnz7lfgOsrwhlaNXyHU3zwe71ezHrVrEBAAV4bkbDsYU20uv1QhZ3wPFFQ2XoGGB8HLPzq1E7lW9LP24qf5N86NBKtdbiwe8BSWfXK6YYu7F8GwLco5wsaJqzNTiz+tvF9rcJZjPouW7AwsEZhRavtVW2LN27aB4yL3VYpd428tAAIwdTBDFlIG+1tNpFVYNZLmZqZnE3G10CiuIwNiSyxAyeFjCdZpa+Vrz3exlar32ROCikn19DmijQq0nRssRYoOi0XbDmICdwnvEFfVLJkCysEfLSadDwbuagF3ZdrmRKZgd4eYJM0Mye4WBkFH65D+wt8deA1FsNFXsX3XoQ5CaDbRTi6hHFVJmWN7lx3EOs+8CzFjxoNV1tAEoQwmOVc2vNaaO8Oza6sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(2616005)(83380400001)(186003)(26005)(6512007)(82960400001)(38070700005)(86362001)(36756003)(38100700002)(122000001)(54906003)(2906002)(5660300002)(316002)(8676002)(66446008)(4326008)(66946007)(66556008)(64756008)(8936002)(66476007)(91956017)(76116006)(41300700001)(53546011)(110136005)(6506007)(478600001)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3U1ekMvdFF5YW1hR2l1b1Vsck95ck5QZW12M1o2WkhNWXRkenBySHdCK3Ux?=
 =?utf-8?B?YzBRSC9DR2pTNkVsNUtwVWJkK1pjV0MyMSsxbXNldGtKOFJWT3FPNTM0YkY3?=
 =?utf-8?B?NG96enRxVWZLaGNmTHN4U1ptM3FldThLc3M5UlQvazdNNXMvaC9Sb25YZkRa?=
 =?utf-8?B?dy8vVHdXUVFYWHdlRTNLVkdzQmRWSDdCanBEOXFrLzcrU3FqZ3B4ZERsVC91?=
 =?utf-8?B?RHloYldZaEJqdkdTTjQyQXlnT2FhN2JIVENCczR5dmxsWDdPTCtyZUNQR3c5?=
 =?utf-8?B?NVlvakdMamNEbStaMDYrUTZiOG5CY3J6RmFtU0pIZHB5U2VyL1FoUWRpNmQv?=
 =?utf-8?B?RWNpOGUwMDVySTR2VXd4MnRwVE8zUVVLR2g2cHd1d3VqOWRhRExLMVZPaW9Q?=
 =?utf-8?B?MDVwOUxzcFVyUWlteWx6LzVXbDdmTlRrZDU3cEZSL2YwaEVMaE5pVG4veDNX?=
 =?utf-8?B?Q2pxS3doT3U1WXA2MnphalFGTVVLeUVsVGlqd3RZSWl5aDZvZGs3NmNiZzRJ?=
 =?utf-8?B?bEZManRLL1ZXQlhOT0VxTW9hNStJTTMzMTZlVGNuUTE1NUV0RnhOY3BJMzc1?=
 =?utf-8?B?MDhDbm1PR1g5akVEajNPOWZvUlJ3MUJYdGdPTW9wUmJYcjlWUHcxOEZ4VzVY?=
 =?utf-8?B?VFFOMlpCcVk1cGxFNjBXbkgxZmlCb1N0ZmkzL2d3YzJuYzZsK3dUcmN1QmJS?=
 =?utf-8?B?c2hVUUxOV0hMdHFuamFYNmhsdmlyaW4wSjhxRHhORUVtQ2xsY3BjK2RvYytp?=
 =?utf-8?B?YXUzdnd0dEtqNmJOZS9VdThBQzhaNUxBSVBlQVk0OTQ4RVV3Q3NXSjhWTmFk?=
 =?utf-8?B?ak4wUERRNnU3dmJaSXRlUmE0MWt5TlJPd3MzV2hHVzJOU0hyVUZ6OWtlK1lD?=
 =?utf-8?B?djBScXRMYnZYNTIrNnBCZlg4enk2eVJQNlpIREtLTGVrUVVzVHYrNyt6Wlo4?=
 =?utf-8?B?aGFibDdseXRhVmR3YlBMdWV5RmdnT3AwbHZlSWZqYnVjYUlseEhJU1NJOHVH?=
 =?utf-8?B?L3I5aWxWSDFLNTdLSE5HbEhSWjJZNUgrQjE3aW5adXRVUElzaWQ1QWthNGpC?=
 =?utf-8?B?a2NNZFZudzZjUytoSDZSNFRUd0t3WWJUZTJ3OGZ6eGEzSHFkd1NjRGxCOHZO?=
 =?utf-8?B?OGgrQS9sR041TkNnSjE4RWtOSks3eWRpTHJ3OFhXVWZ6U1BWaERpcWl1bVRj?=
 =?utf-8?B?aWhYZTdwaE5zNDBBYnNpQzJaOXFId05xRWovenpIK0xVQ3p2czlITi9YVzVo?=
 =?utf-8?B?cWM1cS9OeExPUktMQXFyRytiVW10c3kycDJJdllpOW1mQlMvUkdrL3ptV2hQ?=
 =?utf-8?B?RkdxcWs4aW00ajR2YUZhWndJaG1mdzF1bWRwbzlTMDRwU1Eza0wwcUxXVFEx?=
 =?utf-8?B?SnhwY1h4NVZIQVlXRFlDcytpbC81dll0TFdTSWVQNW1EVE5jbWt6c21QZW53?=
 =?utf-8?B?VmxZZW9KVlZPemw1eksxam1WQkUxb1RsalpvK0dkZWZyRkY3V0NFSkswUHRY?=
 =?utf-8?B?VUVueVc3R1l5c2ZRQzRiNGNvVUlMdW5SMUJhcno5bFBnOHUwNGFSNmJRYVZ6?=
 =?utf-8?B?THBOeTZtdHV6TlVlcVhLdHFSS1kvM1phME1iVnJjSW9Ub0RSempoK0VqQ3F1?=
 =?utf-8?B?MEJSbTRxMFIzcElSZHRScmhlRVJud2kvUkxlYXlOS3JCajBzUFk5YnVEcFE5?=
 =?utf-8?B?VEM1aGRpaHVZaytEYmJOOUQ4UXV6L1FjcFgrOWFQMWhrc1orQThMRWQyZWVG?=
 =?utf-8?B?L0FQUkFPcTNTT28zeTE3M3dBVklpSU5zMFczcTV3Z2tTdG45bEpSdlVsY1Ey?=
 =?utf-8?B?U0dYS1FzNC9aeDBKTjVUZ1Y0blJNVWF5L3BwT2xjYkVyblplL1dkejNnditv?=
 =?utf-8?B?YnBNQ3BIVzZZZXdjOUI3S2xySlNxb0JzOXI4Q2MwdmtXd1paZlVlQ1duUE9V?=
 =?utf-8?B?WmVGYXd1MW0vTkwzK28yZTBBUTFJc0FUT1FKV3dsSDdSclN6RnR4KzBQa0k5?=
 =?utf-8?B?NHB1MW81UWxUcVRyZGl5cWRaUXkwNmtTOU8xTFllNGpJU3FHWG1XV2o5a3pD?=
 =?utf-8?B?RmVaWWZOWFVhMTJvY2hZM0dMbThvMWx5MFpUeUpyaFR5UXIwQVZrN2VUbG0x?=
 =?utf-8?B?TkwxMS9jZlgvZzFIcEVUZUNmTmovakxOb2ptVU5uTEt1dXRpWjJJYTBHOXZ6?=
 =?utf-8?Q?OYe2yOlHQXs6lbM2sL9yU3o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7F6F8E373F2FF4EBA324D83A8FBE9E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b894fa8-b943-4521-7886-08daeee7a656
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:39:52.1262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7JVm6lamhUfgjq2phFTGK/MCzwcfskR/hCJLTYPawIij/vlM9D0WDZC5+akgpM3PwjTzLLrJW2S/fHz1RlspKknuKcClKoRQ099Y8op23M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDIyOjMyICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToNCj4g
MS4gSSBrbm93IG5vdGhpbmcgYWJvdXQgd2hhdCBgdHhfd2l0aF9zaXNvX2RpdmVyc2l0eWAgaXMu
IEl0J3MganVzdCBhIA0KPiBoYXJkd2FyZSBmbGFnIHRvIG1lLiBNYWluIGxpbmUuDQo+IA0KPiAy
LiBJIGhhdmUgdGhlIHJlYWwgZGV2aWNlLiBUZXN0ZWQuIFR3byBwaG90b3Mgd2FzIHNlbnQgdG8g
THVjYSBDb2VsaG8gYXMgDQo+IHdlbGwuDQo+IA0KPiAzLiAvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jI0w2MjMNCj4gDQo+IMKgPiBJV0xfREVWX0lORk8oMHg0
REYwLCAweDE2NTEsIGtpbGxlcjE2NTBzXzJheF9jZmdfcXVfYjBfaHJfYjAsIE5VTEwpLA0KPiAN
Cj4gVGhlIGRldmljZSBJIGhhdmUgaXMgMHg0REYwLCAweDAyNDQuIFRoZXkgc2hhcmUgdGhlIHNh
bWUgZGV2aWNlIElELg0KPiANCj4gNC4gSSBoYXZlIG5hcnJvd2VkIGRvd24gbXkgY29kZSB3aXRo
IF9tYWNfc3RlcCwgX3JmX3R5cGUsIF9yZl9pZCwgDQo+IF9ub18xNjAgYW5kIF9jb3Jlcywgc28g
aXQgc2hvdWxkIGJlIHNhZmUgdG8gb3RoZXIgZGV2aWNlcy4NCj4gDQo+IEhhcHB5IE5ldyBZZWFy
DQo+IA0KPiBBaWRlbg0KPiANCj4gT24gMjAyMy8xLzIgMjE6MzIsIEdyZWVubWFuLCBHcmVnb3J5
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMy0wMS0wMiBhdCAxMDo0MCArMDgwMCwgQWlkZW4gTGVv
bmcgd3JvdGU6DQo+ID4gPiBBWDEwMU5HVygweDRERjAsIDB4MDI0NCkgc2hvdWxkIGhhdmUgdHhf
d2l0aF9zaXNvX2RpdmVyc2l0eSB1bnNldC4NCj4gPiBXaHkgaXQgc2hvdWxkIGJlIHVuc2V0PyBX
aGljaCBrZXJuZWwgZG8geW91IGhhdmU/DQo+ID4gQ29tbWl0IDNmOTEwYTI1ODM5YjEzNDM2YmYw
YTIyMTg2ZjE2OThiMjNlYWZiOTEgYWRkZWQgQVgxMDEgZGV2aWNlLg0KPiA+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogQWlkZW4gTGVvbmcgPGFpZGVuLmxlb25nQGFpYnNkLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gUmVmIENvbW1pdDogOTM1MmVkMDE2NWZmNDMxM2FiMzQwYzk3OTQ0NmMzZDY0YzUz
MWY3YQ0KPiA+ID4gVGVzdGVkIG9uIG15IG93biBkZXZpY2UuDQo+ID4gPiAtLS0NCj4gPiA+IMKg
wqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMgfCA1ICsrKysr
DQo+ID4gPiDCoMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Ry
di5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+ID4g
PiBpbmRleCA5OTc2OGQ2YTYwMzIuLmE0NmRmMTMyMDM3MiAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+ID4gPiBAQCAt
OTg2LDYgKzk4NiwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGl3bF9kZXZfaW5mbyBpd2xfZGV2
X2luZm9fdGFibGVbXSA9IHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGl3bF9xdV9jMF9ocl9iMCwgaXdsX2F4MjAxX25hbWUpLA0KPiA+ID4gwqAg
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAvKiBRdVogKi8NCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oF9JV0xfREVWX0lORk8oSVdMX0NGR19BTlksIElXTF9DRkdfQU5ZLA0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVdMX0NGR19NQUNfVFlQRV9RVVosIFNJ
TElDT05fQl9TVEVQLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgSVdMX0NGR19SRl9UWVBFX0hSMSwgSVdMX0NGR19SRl9JRF9IUjEsDQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJV0xfQ0ZHX05PXzE2MCwgSVdM
X0NGR19DT1JFU19CVCwgSVdMX0NGR19OT19DREIsIElXTF9DRkdfTk9fSkFDS0VULA0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXdsX2NmZ19xdXpfYTBf
aHJfYjAsIGl3bF9heDEwMV9uYW1lKSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoF9JV0xfREVW
X0lORk8oSVdMX0NGR19BTlksIElXTF9DRkdfQU5ZLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVdMX0NGR19NQUNfVFlQRV9RVVosIElXTF9DRkdf
QU5ZLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
SVdMX0NGR19SRl9UWVBFX0hSMSwgSVdMX0NGR19BTlksDQoNClNvLCBzdGlsbCB0aGUgb25seSB0
aGluZyB0aGF0IHRoaXMgcGF0Y2ggZG9lcyBpcyB0byAqZGlzYWJsZSogdHhfd2l0aF9zaXNvX2Rp
dmVyc2l0eSBmbGFnLiANClRoZSBjb25maWd1cmF0aW9uIG9uZSBsaW5lIGJlbG93IGl0IChsb29r
aW5nIGF0IExpbnV4IDYuMi1yYzIpIGlzIGVzc2VudGlhbGx5IHRoZSBzYW1lDQooYnV0IHdpdGgg
d2lsZGNhcmRzIGluc3RlYWQpLCB0aGUgb25seSB0aGluZyBkaWZmZXJlbnQgaXMgdXNpbmcgaXds
X3F1el9hMF9ocjFfYjAgaW5zdGVhZA0Kb2YgaXdsX2NmZ19xdXpfYTBfaHJfYjAuIFRoZXNlIHR3
byBjb25maWd1cmF0aW9ucyBkaWZmZXIgb25seSBpbiBzZXR0aW5nIHR4X3dpdGhfc2lzb19kaXZl
cnNpdHkuDQpUaHVzIHRoZSBxdWVzdGlvbiwgd2hhdCBpcyB0aGUgcmVhc29uIGZvciB0aGUgY2hh
bmdlPyBEaWQgeW91IGV4cGVyaWVuY2VkIEZXIGNyYXNoZXMsDQp0aHJvdWdocHV0IGRlZ2FyZGF0
YWlvbj8NCg==
