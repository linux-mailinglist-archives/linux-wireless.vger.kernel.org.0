Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB33E66292D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 15:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjAIO67 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 09:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjAIO6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 09:58:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734E15839
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 06:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673276330; x=1704812330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qyeu4L0mtrVH1HqZUSOiADqEhGdq3rMG1AWMs2/94Hg=;
  b=ibJ0YOo0OLERoW/o+OpmmhuS2QhptzF/C5ENckeMrl6YR5xXgI/Mi9pq
   MxE/QYNyiFAIPjRti3fs8xvpmWLSJEsJbRhgVUu86M5gNPuARBMElKJlh
   S5Yboe9Rk99jEYTgcVMDnAao+dnN4ALB9gr4uLttCkPThpKQUY5xXTCkG
   GBj3Iqv3O/Xla9yAkC+X5uGElu4DeW8Auptxs4mu4eEn8pOD9MBoclhdw
   8VDoNb3l7Sck+8ukLboxsSK1WERreknADYUw9W5qUdSikLLQmbzRJnEs/
   pLNxoT9HU+pJ69PkQKkJUEEWhGo5RWRy8lUFw0r3wfmh7BBMY9WcvQgGb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324895788"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="324895788"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 06:58:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="985418988"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="985418988"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2023 06:58:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 06:58:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 06:58:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 06:58:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaixG6yO3g1+22Kzt/4kpZpP7SSKR0uVNeFUt9kP9LzF6s5V8IPdhG8bLKU1kHzqu9sjAeFy0//PzJhpPzoDi2mLatuTCRqIWmZN6J9L/iC/+fxG9KTfDik+HX+yHAU22xVwTU7OPPSTS41he5Rl5x0TkW7fxK4jnXTXD9LndJka8wL1m0gZoeQ6nZrITbD6vaZ/fZvPZ71/hlEfeQfTgDUnvBW/SvkiTy4Y/PYtW7Jz94mIEcTSeWOo9N0SrAbtWjIp6iBhzL/Z6d3i/z2GUoUpdgrINQ4y3GVvSvdTDtw8CL0M4+ksN/X541OJ0cEXR0bmdRY2veD/7HpqHX4ydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyeu4L0mtrVH1HqZUSOiADqEhGdq3rMG1AWMs2/94Hg=;
 b=kgC6IjniYIu8SnhxhW4PCgBUQLTUufs9rM5QEoFP6OpQqq7hfUDSJqMVpmJlslVSpelGr1q3icTzI3Hylsusjiz6XGyF3E6B4PFtRru0E6xXX+zZPG4DkGo3qULsrwJ6ckvvN7ZgMDp1cRd9UjYJRmGzB8hOsAQv1jcm8/OxZza89LFrpaSROVk7+8WYArLDqBYVDVNfJ0NmvlC5Ivl6tDM9WQ3g0s30Swi2QShe56tYagIC/LsKj2iSgJbTWS2/8eYCHicdy0s6bMGiMrH5Frq1GQx+EdpWrJpB+jPx9IKLW+DcykpEfksI/OSnCc9a+0nYFoQbTFzHSGaJCfBD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:58:45 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:58:45 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "jwboyer@kernel.org" <jwboyer@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: Re: pull request: iwlwifi firmware updates 2023-01-04
Thread-Topic: pull request: iwlwifi firmware updates 2023-01-04
Thread-Index: AQHZIIDbu6PwsFMpYUK8SAT96mbX0K6WJ9GAgAAM5wA=
Date:   Mon, 9 Jan 2023 14:58:44 +0000
Message-ID: <a7ddb6d9daaa6ee5476b2a5c9403d5f67d716a36.camel@intel.com>
References: <0f2d6fb13fe09bc7cd0a74d7c57cdbc03f979071.camel@intel.com>
         <CA+5PVA63L6h+j+0J2bLn3fB7qWdOk34tapuF2N0kUftzUyZHVA@mail.gmail.com>
In-Reply-To: <CA+5PVA63L6h+j+0J2bLn3fB7qWdOk34tapuF2N0kUftzUyZHVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA0PR11MB4573:EE_
x-ms-office365-filtering-correlation-id: ad16ee3e-e870-4107-71a6-08daf2520137
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wcfmfkSo3KuVtwtxGdKWcHSM5LQ6vkhq+H8F57tV762K+5Sf+sc9C4ljftgCB0s9umRtvNsbwVOjEKMhuJnylLDdm59RNf2F9MRAnyfr6Y0oEQealhvtygH+k0ZA+ioGrtjU6AiszSaTPxIppEaQXbQeq++D1J8KDUXrutIuahU/mZV/+sRRtQcBCuAgGr/qgbVfkwymLJEALrwD6wnP0rppOz0rP+rRqw5AaL20M9+ijFqxzGY4EmORJedb2j6JRSRpKJmg0OGR/3qSKart31/fiByCGr4AQdOB6mtnSk3u82SmAwJtyVADyn8tsOnarFo3a0Jg8fJXx7Uy/Hgojm58dHrNeJVIWhT3CaRiX7bAvBZ+KpTV8VJMbPe4TdKk9/mwE4V09Ft2mreQmzIeMHJ/QMDg9yCC/MR1QG2oOwLHiGdvZfYssyqnVr5H5cW3ZYjVAk654BPire7K1LljDDeNqiVbSTjf4GhpG//4aHBqAO3EpWFg13sP5cQGHQ58LSSwN46VK+Bnm9vcbO7zR4aCxxOrt6MfIEmkHTXFKFz/V0nPfsKbUUPChjFyCq/5jM22U6EIPAB3pcyFV5nO1zPWguhPGSJVpm0fis8ysDSyuxrZJ1nDFEwCDBzabtBjDv+0OoGA2ReMpmQNU3zfHSTUMu+0GTKdekQ+fQdDyJAiRtfuHT1BNKeK28op5oaa2KWjbfbRdueTZdCU+zNwE6cjNtbC9XGr0wguoHyIW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(2906002)(83380400001)(15650500001)(54906003)(2616005)(66476007)(66446008)(66556008)(64756008)(5660300002)(66946007)(26005)(53546011)(186003)(36756003)(122000001)(8936002)(6506007)(6512007)(82960400001)(478600001)(76116006)(38100700002)(8676002)(41300700001)(6486002)(86362001)(38070700005)(966005)(19627235002)(6916009)(4326008)(91956017)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGVCQnF4NHpJL0tRSGlmUmd4MnJqYkY3cWdQNmF6bHJtZFp5QzVOSGJheDY3?=
 =?utf-8?B?M2creDRzN0lVL3l1cERHc2V4K043dERiVWxjUFMyU2ZzSytkZjNNMVlnclNh?=
 =?utf-8?B?ejdZT2FiOG8yOWMxVVlsNnpLckJIeVJHeS9HR2xQQXN4NVMzSHJ5bkN2c1hr?=
 =?utf-8?B?Rk41SzhRMDZ5b01Wa0RpMnJlbEZYRVEvMVNlSENMQnhSQzJBTlRKa0xiQnRo?=
 =?utf-8?B?cUdWNUIvdTdCUWtWUVR2Qm80VHRXOFd4NG9nYWVCSzR2empJUjA4YVIrbVl1?=
 =?utf-8?B?aExSMGxkd29LdHJtaGJKc3JWZWRGaXV5ZmtRSjVlcjdCUmg5c1lTcm96MWRx?=
 =?utf-8?B?dmcrVGtSb1pHMmRBYXlqcW54VmxrOUE3ODNSTmt1MmtsVmQ5Rk5UbXpQVkZo?=
 =?utf-8?B?UklVQ1JmTlRCUzNYUFdIaDlpaWlSQXpjNXk5YjJTbXlVQmIreEdrK3ZEb1l2?=
 =?utf-8?B?MmV4czQwSEFscjYxZEJ5YkhDWlJjZmszOUx6K2ZlbWpqbXlKcFljYzVzNE54?=
 =?utf-8?B?blc5bHVDT2ErT05YUFQwOVZaTlphRDB5S2pXZlBJbEFpME14VjlkRy9pVVor?=
 =?utf-8?B?MkF3am9Fak1ra01jNlBYZFVyT0g5N041UzRUQWxpYjlrOEtWNjZxZk1sUk9D?=
 =?utf-8?B?akpDamo3TnBSaDZZa1lzU0F4WFhGVktNNEFqdmZ6a3dRZ2pKWXFLb0QxNFhI?=
 =?utf-8?B?T1VuVDJ6TXdVUExDdmFENmhRQUtaeGh1MnNVbmFvUWlraVJKOXFRa1FLRzVi?=
 =?utf-8?B?eEthZmV0TllKcndqTlVlL3VDbWFlTjFSdjVwVkVoL21CTVJBMUVOTkN6ZFpr?=
 =?utf-8?B?WmxWUEFKSWQ5T3g0a0VLMnkvbi9YUUw3MTRhajBiZzFWWXlsQVNuazZSUElh?=
 =?utf-8?B?Rmo1MGc5S01xbkdPeVUxMW9Iak1iUWdXRDM1RS9UMzNFbVY0WTJua1lmZE56?=
 =?utf-8?B?UFU3T2dGdmpQTU9NM0JKWVB6d3Q0Uit1RnZ5R0ZGWTVzUGtITDJiM1NuMG1a?=
 =?utf-8?B?MGZUQUx3YkJJKzFPN3V3YU5mb2djQUxFVkk4MXBHcHdJeGZCaXZ6dGFMQmNh?=
 =?utf-8?B?MnlQc2plYmR5NW5kWTcvTW5GZ3pzQ0JMR0k1Q3JtVXpkdVJWbE5kRHlDYW9j?=
 =?utf-8?B?SFQ3VWQ1bkFFeEtmRXFmTy9QY25zREErQUhrOFp4ajFFMDhoZ290UXJQdW9L?=
 =?utf-8?B?T0Y5RU52aUdvSFpiVThlRS9FSlIrNmhHMGdQR05NL2plMlBTWFlOVWNRektP?=
 =?utf-8?B?R09GRlZ4SlU5aVJPNGlTYzhrQ041NzlmVHZwZXhLQzJwMDVaQXlsQTU3bmZ6?=
 =?utf-8?B?bkVxZFdGbzYzN25OTEtoQXh3TEJtSE5pRzRua2RuWEdPd1lXMWpUcFM4Q2xQ?=
 =?utf-8?B?Q1NWYlJqVFVKYVFKOHBJZitpWjhseDM2Y3J5YTQ0Q1o2eXRVRGlRVzltS3l5?=
 =?utf-8?B?NGVKYkZueGc4VDRvczVKZHdqRzJHeDYxMzFSRjdlSE45aHNtcmc4WUhObGxn?=
 =?utf-8?B?b2FadXJNbWFtOU5GUFlDYUNUSGpjK0Y1V1hvbkQ3ZWFnTFVQVHp4NS9sUm1l?=
 =?utf-8?B?MlZuQ1lhSEZYOWFJUnlqSXM0blpMOVk2dzZYWWhvUUcreU1DMDJGc2tkNWxW?=
 =?utf-8?B?NTlJNHZvS0JZWEc4MjF0V0dibk9KVUc2KzltSGdCQ1NGeHBqU0tSU0ZjU2Uv?=
 =?utf-8?B?a1ZSVTRFM1hVbWVNVlVoNWUrVlcrdDJuYnUvZmd4MndDRWNwVjFvRlJHb0Na?=
 =?utf-8?B?WG9POU9lMm5uTVZ4VVFSSDhZNjhuOWIrNUlPMEtQejM0T0tYMFQ2bWUxQ3My?=
 =?utf-8?B?YUFMU0pqeHlwQ2ZjZGdJTjZUdG9xOENJaUFJcFhCRGlzM28wR0NwN1hwVitJ?=
 =?utf-8?B?d1E1VzIzN01sV09CM2JvUThkcGttNjI2ZUVGOWNHVEVoRHdHTFpBc2IwTVVt?=
 =?utf-8?B?L2NjeHJ6TXJLSnVaM2pNZmVZempEUFVBOUJSeVhMYU9kK0RZd2dKTFRXVkta?=
 =?utf-8?B?Uk1VRFZQM2dEWlI4aTlEQW82N1hKZ3lUUk53NlZzZk52bnNlaWNocXdqMk81?=
 =?utf-8?B?bWxOOVZYb25qamdKMlY4YmtCaForYUZuU1JhTE5Qdmo4d2JSem5TdTdzVUdL?=
 =?utf-8?B?Ynh1eWpER3hiUHVld1RuNisrb0lZMVFtQ0NKODZnQTg2ZzZURnVaM1BxSFBw?=
 =?utf-8?Q?TwV/ILKroVtFHjQKqdiXq24=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C3FC1F815C3EB4C866AC0AD2CA7572B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad16ee3e-e870-4107-71a6-08daf2520137
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 14:58:44.7528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsHK2VTInDNuSZxr1L/8QLIQBMRyAEAxyHh1sIG7fQ3GzhGCqDkVp5VbOf9zYOq5Wer4a1lKpZjtxN14j0k8d72L4eUG1J43k1GqvmxB3ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTA5IGF0IDA5OjEyIC0wNTAwLCBKb3NoIEJveWVyIHdyb3RlOg0KPiBP
biBXZWQsIEphbiA0LCAyMDIzIGF0IDQ6MDkgUE0gR3JlZW5tYW4sIEdyZWdvcnkNCj4gPGdyZWdv
cnkuZ3JlZW5tYW5AaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBU
aGlzIGNvbnRhaW5zIHNvbWUgbmV3IGZpcm13YXJlcyBmb3IgYWxsIG91ciBjdXJyZW50bHkgbWFp
bnRhaW5lZCBGVyBiaW5hcmllcy4NCj4gPiANCj4gPiBQbGVhc2UgcHVsbCBvciBsZXQgbWUga25v
dyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCj4gPiANCj4gPiAtLQ0KPiA+IFRoYW5rcw0KPiA+
IEdyZWdvcnkNCj4gPiANCj4gPiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDRl
ZTIwMTQ3OGQzZjA2M2ZkODI5NmQ3NzNhZWVhZjBkNzJiZmI4MGY6DQo+ID4gDQo+ID4gwqAgTWVy
Z2UgYnJhbmNoICdmb3ItdXBzdHJlYW0nIG9mIGh0dHA6Ly9naXQuY2hlbHNpby5uZXQvcHViL2dp
dC9saW51eC1maXJtd2FyZcKgKDIwMjMtMDEtMDQgMDg6MjI6MTUgLTA1MDApDQo+ID4gDQo+ID4g
YXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQo+ID4gDQo+ID4gwqAgaHR0
cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4
LWZpcm13YXJlLmdpdMKgdGFncy9pd2x3aWZpLWZ3LTIwMjMtMDEtMDQNCj4gPiANCj4gPiBmb3Ig
eW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZGVmMWUxNjlhN2ZlNTcxZWIxYTBmZDMwNmM4ZmM4
ODUxOTA2YjdkZjoNCj4gPiANCj4gPiDCoCBpd2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU3
Ni0zNSByZWxlYXNlICgyMDIzLTAxLTA0IDIyOjUwOjA4ICswMjAwKQ0KPiA+IA0KPiA+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiBGaXJtd2FyZSB1cGRhdGVzIGZvciBpd2x3aWZpOg0KPiA+ICogdXBkYXRlcyBmb3Ig
OTAwMC1mYW1pbHkNCj4gPiAqIGFkZCBuZXcgZmlybXdhcmVzICh0eS9zbykgZnJvbSByZWxlYXNl
IGNvcmU3NS00Nw0KPiA+ICogdXBkYXRlIGNjL1F1L1F1WiBmaXJtd2FyZXMgZnJvbSBjb3JlNzYt
MzUNCj4gPiAqIGFkZCBuZXcgRldzICh0eS9zbykgZnJvbSBjb3JlNzYtMzUNCj4gPiANCj4gPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gR3JlZ29yeSBHcmVlbm1hbiAoNCk6DQo+ID4gwqDCoMKgwqDCoCBpd2x3aWZp
OiB1cGRhdGUgOTAwMC1mYW1pbHkgZmlybXdhcmVzIHRvIGNvcmU3NS00Nw0KPiA+IMKgwqDCoMKg
wqAgaXdsd2lmaTogYWRkIG5ldyBGV3MgZnJvbSBjb3JlNzUtNDcgcmVsZWFzZQ0KPiA+IMKgwqDC
oMKgwqAgaXdsd2lmaTogdXBkYXRlIGNjL1F1L1F1WiBmaXJtd2FyZXMgZm9yIGNvcmU3Ni0zNSBy
ZWxlYXNlDQo+ID4gwqDCoMKgwqDCoCBpd2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU3Ni0z
NSByZWxlYXNlDQo+ID4gDQo+ID4gwqBXSEVOQ0XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDM3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0NCj4gDQo+IFRoaXMgc2VlbXMgdG8gbWlzcyBhZGRpbmcgYSBmaXJtd2Fy
ZSBmaWxlPw0KU29ycnksIG15IGJhZC4gV2lsbCBmaXggaXQgcmlnaHQgYXdheS4NCg0KPiANCj4g
W2p3Ym95ZXJAdmFkZXIgbGludXgtZmlybXdhcmVdJCAuL2NoZWNrX3doZW5jZS5weQ0KPiBFOiBp
d2x3aWZpLXNvLWEwLWdmLWEwLTc5LnVjb2RlIGxpc3RlZCBpbiBXSEVOQ0UgZG9lcyBub3QgZXhp
c3QNCj4gW2p3Ym95ZXJAdmFkZXIgbGludXgtZmlybXdhcmVdJA0KPiANCj4gPiDCoGl3bHdpZmkt
OTAwMC1wdS1iMC1qZi1iMC00Ni51Y29kZSB8IEJpbiAxNTE4Nzg4IC0+IDE1MTg3ODggYnl0ZXMN
Cj4gPiDCoGl3bHdpZmktOTI2MC10aC1iMC1qZi1iMC00Ni51Y29kZSB8IEJpbiAxNDg5NjY4IC0+
IDE0ODk2NjggYnl0ZXMNCj4gPiDCoGl3bHdpZmktUXUtYjAtaHItYjAtNzcudWNvZGXCoMKgwqDC
oMKgIHwgQmluIDE0MDc3MzYgLT4gMTQwNDA0OCBieXRlcw0KPiA+IMKgaXdsd2lmaS1RdS1iMC1q
Zi1iMC03Ny51Y29kZcKgwqDCoMKgwqAgfCBCaW4gMTMyNTUwMCAtPiAxMzIxNzIwIGJ5dGVzDQo+
ID4gwqBpd2x3aWZpLVF1LWMwLWhyLWIwLTc3LnVjb2RlwqDCoMKgwqDCoCB8IEJpbiAxNDA3NzUy
IC0+IDE0MDQwNjQgYnl0ZXMNCj4gPiDCoGl3bHdpZmktUXUtYzAtamYtYjAtNzcudWNvZGXCoMKg
wqDCoMKgIHwgQmluIDEzMjU1MTYgLT4gMTMyMTczNiBieXRlcw0KPiA+IMKgaXdsd2lmaS1RdVot
YTAtaHItYjAtNzcudWNvZGXCoMKgwqDCoCB8IEJpbiAxNDA2NzU2IC0+IDE0MDQxODQgYnl0ZXMN
Cj4gPiDCoGl3bHdpZmktY2MtYTAtNzcudWNvZGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgQmlu
IDEzNjkxOTIgLT4gMTM2NTQ4NCBieXRlcw0KPiA+IMKgaXdsd2lmaS1zby1hMC1nZi1hMC03OC51
Y29kZcKgwqDCoMKgwqAgfCBCaW4gMCAtPiAxNjY3MjM2IGJ5dGVzDQo+ID4gwqBpd2x3aWZpLXNv
LWEwLWdmLWEwLnBudm3CoMKgwqDCoMKgwqDCoMKgwqAgfCBCaW4gNDIwOTIgLT4gNTYwNDggYnl0
ZXMNCj4gPiDCoGl3bHdpZmktc28tYTAtZ2Y0LWEwLTc4LnVjb2RlwqDCoMKgwqAgfCBCaW4gMCAt
PiAxNzExMTAwIGJ5dGVzDQo+ID4gwqBpd2x3aWZpLXNvLWEwLWdmNC1hMC03OS51Y29kZcKgwqDC
oMKgIHwgQmluIDAgLT4gMTcxMjc3NiBieXRlcw0KPiA+IMKgaXdsd2lmaS1zby1hMC1nZjQtYTAu
cG52bcKgwqDCoMKgwqDCoMKgwqAgfCBCaW4gMjgyNTIgLT4gMjgyNTIgYnl0ZXMNCj4gPiDCoGl3
bHdpZmktc28tYTAtaHItYjAtNzkudWNvZGXCoMKgwqDCoMKgIHwgQmluIDAgLT4gMTUxNzE0OCBi
eXRlcw0KPiA+IMKgaXdsd2lmaS10eS1hMC1nZi1hMC03OC51Y29kZcKgwqDCoMKgwqAgfCBCaW4g
MCAtPiAxNjIwMDA0IGJ5dGVzDQo+ID4gwqBpd2x3aWZpLXR5LWEwLWdmLWEwLTc5LnVjb2RlwqDC
oMKgwqDCoCB8IEJpbiAwIC0+IDE2MjA3MDQgYnl0ZXMNCj4gPiDCoGl3bHdpZmktdHktYTAtZ2Yt
YTAucG52bcKgwqDCoMKgwqDCoMKgwqDCoCB8IEJpbiA0MTg3NiAtPiA0MTg3NiBieXRlcw0KPiA+
IMKgMTggZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4g
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmLWEwLTc4LnVjb2RlDQo+ID4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1zby1hMC1nZjQtYTAtNzgudWNvZGUNCj4gPiDC
oGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmNC1hMC03OS51Y29kZQ0KPiA+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtaHItYjAtNzkudWNvZGUNCj4gPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXR5LWEwLWdmLWEwLTc4LnVjb2RlDQo+ID4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQgaXdsd2lmaS10eS1hMC1nZi1hMC03OS51Y29kZQ0KDQo=
