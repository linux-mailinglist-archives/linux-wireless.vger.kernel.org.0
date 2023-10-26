Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134BD7D843D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjJZOJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZOJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 10:09:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD301128;
        Thu, 26 Oct 2023 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698329352; x=1729865352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xkUgGXTlcMwS+8EgiBPj45oEiUwVktDgp8XlP7peVVQ=;
  b=fbpE7IUW4hInGdcW0Ezr5gs6pwsxC0Oe5jVVfD/ySDtt+kIsQZb1KTK5
   ZTmaz6Fpx6Wquh3sxQ1kHJ1VhRdH10Z/mP73GSChroo7ofqSC3qcXUguD
   KvNc5D6YdYX86u9rdFQVg/nkBn0RB8VqvLYAxtKCEnT9BKdBrkrXHXdlY
   e69ifuWfyumBGj59jU+v7aokI3XsazlnDBWMdOacAc/U6RHVszYnWEfZM
   3Qew1cJMIhM4czGuor3HaNYp+pUAvJn2zHvUx47ObqzZ5bApvd4OIf0Ug
   jJ2wWscwMW2arWxAdWDjrIBI6Jf+wP/U4Wj88V2X/jbVoyDwj5g93xjBR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="384763825"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="384763825"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 07:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709085296"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="709085296"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 07:09:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 07:09:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 07:09:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 07:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af8C4N6maC77ay/7K0VvSHfNJmzgfnycdwgzKLk4K4roqWo48+AuEs2udfhIrLUKY/wH4JywJARI0dspCziUTb44Q/li0nooG/UQJtErw/C6PBsBfLLMkJvsm1Bp0IojJOM4xz6srbp6Z+Eu24/YpSjxLsXdBw0cpHVQYAPrj9mH2yxB0AeoEfcg1dzC0z2Ztq3hwYCfzfgrqB9nl2LyB+rB9RIxe7v6zvkn/VXNmr1TQ3558CWJMFGPWnWeOqPWvLoxsMTjR0ddXL+tYtQJNtwTL3CY5mRKjMOS7naCURIao6WaYNLAVyxONA7KDTCAWfyON01ozh8jrDOFuW6DJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkUgGXTlcMwS+8EgiBPj45oEiUwVktDgp8XlP7peVVQ=;
 b=MXW6hfhuvfj281qPJSgPuzA0CRvoGcMMpHHOuPT67SPdpP9v3J8T9pHSQFmjhzq2cEBkCUXpv4a58Usq4FAkBMR8zqkZSeb5brmH5htFet1eNQSE95C2GRLLA9HlmpVtKSMY+0ON5SNVRX+7kmlYDppBvsDCdbizBDbt19wpkYFJnN1CMN2OiR1jhlvd1+COOxJEjF/6SyoAhbr2q3GXmsEawX12EWh4/ruDy0FDEgESYLbDxfg7Z0bPYMgRmb3GEnTDnpm5JTbtGtw093JiuL+pvj674+6NolrDXc893jd0yqlQfN4aK/z/82UFAom6XBleu864MKpMa0HG9WNcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Thu, 26 Oct
 2023 14:09:06 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::9825:4e0:cc8:752e]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::9825:4e0:cc8:752e%6]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 14:09:06 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Triebitz, Shaul" <shaul.triebitz@intel.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_mld_add_sta()
Thread-Topic: [PATCH] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_mld_add_sta()
Thread-Index: AQHZ8UAD0Mj/Jbd72UaQItCiREC+XrBcD5kAgAA52gA=
Date:   Thu, 26 Oct 2023 14:09:06 +0000
Message-ID: <d6b9fc241887381bf3920407062168c1af993f8e.camel@intel.com>
References: <75e4ea09-db58-462f-bd4e-5ad4e5e5dcb5@moroto.mountain>
         <79f70bb6-ca33-48fc-ab33-6a6cd8ba2e1d@kadam.mountain>
In-Reply-To: <79f70bb6-ca33-48fc-ab33-6a6cd8ba2e1d@kadam.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SJ0PR11MB4912:EE_
x-ms-office365-filtering-correlation-id: 666b30af-ec00-4eb8-8a51-08dbd62d1dbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7UCewPVIl6DVWlZF9GO65V3mfhs5Bu4Sqbek5BmwGjQR6eX7FZIUqpuqZsJYfFgXar+fyE6ru1MAg3z2/WjCE7es2zMEy7e0ZJJxNExgE0VwE1TWSmELgqZrYAj8bvwtQzRUlb4ZEi7MHUOJnXAcqqVvJrHiwwGbORtV9goCa/gdRhcbentig1OhNoqBf8wka2P5ZmA/+yKwKuB2p2SBG1e84nruIWh5v2RVWgEpjbRZM9q3IhbrLE4AC4Uidq9byUrFJH0cYAi+BcM1LrTow4WMXNHhppSqibBHuEFg/HgSvtwPBcx8Ulg81WPSuAe/4KnFGcomaI0WmlxHwuaBXDCoSsEa/WZiiHTWm+BEfLjWfG2H/3eh2M8OiQAoZ5R54izy4HAbO3fuD0nDdkp7JhwjKwY0Aq15ORiopniAWjqZ8dYGjqYgrHiHtaaHASyBIHCfBQwEDUZsNzkHDi5dyvcHgOys/hDj657A7G5eG5u85AOQ6GSAWjDSx1aicTvHuuOC/CP0QtyMzSeG8l/A8kB+YrQGJtP5SSXtRIxhIVZG6aczx82tp5+FHAhRanojHxPEO//U4bgy1itXeFqju7PppQ8I4Pja7wmPB57oEVyxPl+1VwbS35GWItXGJFO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(41300700001)(36756003)(26005)(6512007)(38100700002)(8676002)(8936002)(5660300002)(4326008)(54906003)(91956017)(38070700009)(66556008)(66946007)(76116006)(6506007)(66476007)(66446008)(82960400001)(64756008)(2906002)(6916009)(316002)(6486002)(122000001)(86362001)(478600001)(4001150100001)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2xMMUs5Wm12d3VzbktrdDhsS2NyWnloeEFoRmRNMzlPcVg4b09vcU95NG81?=
 =?utf-8?B?NTNSLzFOT0tONXZ1c1Mxamh6OC9reFF4MWJrY0lsTktFbU9aS0UrKzFndXQ0?=
 =?utf-8?B?VnhIdlREZHljVlQ3MHBVN0ExZEJHT2hoK1hBelZFNnFVY1lXVDkvZ2c0SlVw?=
 =?utf-8?B?eldwck1zODEwWm1CazNBRER0NUZ1d29VZW5NY3c0aXFWQU9SeFVHL2ppelpt?=
 =?utf-8?B?bWV5bmhUeTZ6ckFsSzlJQ2I5VmdDcmp1cTBIbWQ3aER0dm9PWDVQbGZSSEJ0?=
 =?utf-8?B?aGw0WGkxMFlLeHVPQkZiTE5TRWxsdUxOWFRqNnZ4RmhLRk1nbFgyakUwaVRr?=
 =?utf-8?B?UDR3QUd2Tmx5OHZEY0s1UEIvVmgxU0QzdlR1eFNSOWdYRVNldzZyUzhtTjIx?=
 =?utf-8?B?Si9NYXZUd3hrYTZqNWhGQmUzTGhoVldqcERaME5Nc01KWURxaHRVOWRRNFBN?=
 =?utf-8?B?Wmk5dGNxaWt3ZFBkbG1yZ3UwcnhNZW1lRTZwL3VhWmdVU0RCVC82SEc2NEFn?=
 =?utf-8?B?cThyWlMzMTlvSWhDYUZuYlRXaHhQOGRPa1ZhSnNicXk3VERCb1J4Q21nYVZs?=
 =?utf-8?B?S2pSa2NOSFErWVdwdGdtNkkwTEJSQ0hEQXRWYW1ENVM4Z2JsL3RvK2xJSkRT?=
 =?utf-8?B?NGNrZ093bEQ1Mm5LQnZUVjBtb3JQWmlXd0E4WWZyd0JTRSt2bjZBd0ptTmsw?=
 =?utf-8?B?SWFwbUdaVVA2RWt2K3JnOGdvMmxJOTdFaEF5aWZOVi9ua0J1VnEyUmF3WWJE?=
 =?utf-8?B?NVlFaDBUUjVUUkNXcjQyREVreGdIUDhDalR4SUtVd0pBTi9CSmtiODFzNGcr?=
 =?utf-8?B?bHZnTjZnSTQ2UVp0R0U2K2VObnBrc0pkempXeDBZbXpILzUvaXRnb0YzWHRv?=
 =?utf-8?B?SVZLSVIrenVtRi90eXpvY2R6bkpnTGlXZXFpeU92a0xoU0U1OE53WmEwZTZu?=
 =?utf-8?B?dHRhRU94L0RSQkdhL3BPeENHQmxRLzhhUTRONCtCNjgzWmQwMzgvcnZwQlZJ?=
 =?utf-8?B?Z1cwclZmQUxxVzZLbzg5SUI2cVRNT1VWUE4zc2ZLN0paQVc2TmppWnFNRG82?=
 =?utf-8?B?NVV5dmt3U3V4aTlpYk4vc2J0NnhrU1o2S2dIbnJCSDBWZi9SRmQzTExobENv?=
 =?utf-8?B?b2YvTnVOWFU5Qm5XSVZPM2RZVlRuWUF6Q3VZbXdZWWViSW5LRUcvbno1aEsx?=
 =?utf-8?B?eU1pME9DRjlwT1QyNFJxQXZmTlRrSXpqK2t6S3FqaThKajlXd0w4dE1KT1lh?=
 =?utf-8?B?bVlwTVFzN0RvelVpY29CNVU2MVpUMmhNV3cwcGZ6RXVVVUluMWJYWW1TS2Fu?=
 =?utf-8?B?anVGZkdDeXdqdlNtOVY4N0lIMEszSmtrdU14YmZsK3o2aWI1cm1TQmJKdUJM?=
 =?utf-8?B?cnNJYWdyRW1hNzRtd29EcU1FMGtaRkltOU5RRU5sakQzNDVuL05CWldlcDlP?=
 =?utf-8?B?SUJTQndLYWxSelNYV1d4aDY2YkIxQ3pZQkcvT0hlR2xWOTFaTEJ0OU9yWXU5?=
 =?utf-8?B?OUVpdEpXY2hNeFhCNncvUFh1TTBZWG1hWkM2RjJZNTB4UTUyMjZkejJ3enRk?=
 =?utf-8?B?RmFMVklqSzBNem4xWkVPbnJ6dnl1UFIxT1o1SS9jaXgvazAvTVdZTVllTzRH?=
 =?utf-8?B?NWZYNHdLWnlZQlRDQTkxN3RjNnN6Qk5nQkkxV3E2Z1p3VVdqdjA1SnVKbG5S?=
 =?utf-8?B?SytMQVR1Q2lVWTZzZmd0T2FPeFJkMitIMjFoWjc1OFpZMWRxYmt4Q0RxN29h?=
 =?utf-8?B?aEQ5Tkd3U2ZMdkJVNFY5VDB3UGFXTnpIRS9nT2xHZlR2d3ZHWlpUQk1mSkV6?=
 =?utf-8?B?eXB4Yzh0NWFGcFZ0N0IrTG10QUh0T1NjUnpaOG9VMTVoYnc5S3llQ0J1SFVt?=
 =?utf-8?B?a0NrQzM0TWxqYzNZUnlISGxxaGY1bmUxbkw0R2FaTkhGMUkvU2VhYWNJcmth?=
 =?utf-8?B?TExlTTVUQmFyZUN0dTkwZDVOQ3h2cDF0WnNqMU8yemNGRTM2Q3RSVkwxbmg2?=
 =?utf-8?B?bFdRdmlsR1VYMzRZQ1J4d21seHFSRFErUUUrclYyejlMUk9TM2dCSWZDS1Y1?=
 =?utf-8?B?eTZFS3RsNlU3QnRyREhUNFVXZWtHT0pnRFd2MmNqeCtSblpFb3hiNENyVHBG?=
 =?utf-8?B?TU02bjBMY2Y5U0hoYWR5WlFKbGZKSk9Mdmx3dUcyNDlJZzgvV1R3Y0ZEUjJV?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB9DD4E5CAF9D74AB2A4332D1B554AC5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666b30af-ec00-4eb8-8a51-08dbd62d1dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 14:09:06.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbuAJyHuvStUsNjNg8BYla9kPMuN+faN51LtgiOp5gSsqstKpgPieiOXUsbFo/QMn6ha2eYd3N0j4+ibohdWQRjmpJSGLM7IrQnZ4ukhQpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDEzOjQyICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+
IFBpbmc/Cj4gCj4gcmVnYXJkcywKPiBkYW4gY2FycGVudGVyCj4gCj4gT24gV2VkLCBTZXAgMjcs
IDIwMjMgYXQgMDM6NDA6NDFQTSArMDMwMCwgRGFuIENhcnBlbnRlciB3cm90ZToKPiA+IFRoaXMg
ZXJyb3IgcGF0aCBzaG91bGQgcmV0dXJuIC1FSU5WQUwgaW5zdGVhZCBvZiBzdWNjZXNzLgo+ID4g
Cj4gPiBGaXhlczogNTc5NzRhNTVkOTk1ICgid2lmaTogaXdsd2lmaTogbXZtOiByZWZhY3RvciBp
d2xfbXZtX21hY19zdGFfc3RhdGVfY29tbW9uKCkiKQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuIENh
cnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPgo+ID4gLS0tCj4gPiBJIGNvcHkgYW5k
IHBhc3RlZCB0aGlzIGFwcHJvYWNoIGZyb20gc2ltaWxhciBjb2RlIGluIHRoZSBzYW1lIHBhdGNo
Lgo+ID4gCj4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21sZC1z
dGEuYyB8IDQgKysrLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS9tbGQtc3RhLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS9tbGQtc3RhLmMKPiA+IGluZGV4IDE0NjRhYWQwMzllMS4uZjJlOTUyNDgxZmY4IDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWxk
LXN0YS5jCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9t
bGQtc3RhLmMKPiA+IEBAIC03MDcsOCArNzA3LDEwIEBAIGludCBpd2xfbXZtX21sZF9hZGRfc3Rh
KHN0cnVjdCBpd2xfbXZtICptdm0sIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByY3VfZGVyZWZlcmVu
Y2VfcHJvdGVjdGVkKG12bV9zdGEtPmxpbmtbbGlua19pZF0sCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2NrZGVwX2lzX2hlbGQoJm12bS0+bXV0ZXgpKTsK
PiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKFdBUk5fT04oIWxp
bmtfY29uZiB8fCAhbXZtX2xpbmtfc3RhKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoV0FSTl9PTighbGlua19jb25mIHx8ICFtdm1fbGlua19zdGEpKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FSU5WQUw7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IGVycjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoAo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBpd2xfbXZtX21sZF9jZmdfc3RhKG12
bSwgc3RhLCB2aWYsIGxpbmtfc3RhLCBsaW5rX2NvbmYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG12bV9saW5rX3N0YSk7Cj4gPiAtLSAKPiA+IDIuMzkuMgoKVGhhbmtzIGZvciB0aGUg
Zml4LgpBY2tlZC1ieTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBpbnRlbC5j
b20+Cg==
