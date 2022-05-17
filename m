Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984A8529E2A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiEQJiY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241479AbiEQJiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:38:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1FA44755
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652780293; x=1684316293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7es05uwj81B5uKKttLItlPmvCkFKZv/hMIgT1nnsNEM=;
  b=FJrD/iRnp4f/CX9h8QR5xriYCWV3zVjkKSd//gHfqcYpSLfkgWgbOftr
   WlJ+jlsvbeLK5iRXqRIgsPV0BFgvX0k7QGc8nTfIsabwmV6g0+OwYLMot
   nx12ag69v6oSGsEhlgq3YiiqKWpErO3sA8e9y1L9xj6zII7dyUtBjzuDG
   Mi4uNCW5JX45TpQ8jc6y7lsebuxS2mrHtxb52xB+pdFnO9aAgo/mbdvIl
   MS8Db5TqQ2bCzYvUJyPcRPhqIwoVToek5tXgSXKf5yp/5/Tzia6fX9WM8
   iji3OJ8e5LnmmHdG6oabW6v9T8kW0k3q1ffpgPGCXtmQSg6puneowxKQ/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="331743717"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="331743717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="816819567"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2022 02:38:10 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 02:38:10 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 02:38:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 02:38:09 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 02:38:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3oTpFRG2QFMpZZzi4bTAQ9vmyPGnLz//KRsJNZd21wuaB2jBI+KpZsTsYnBIFVbzl/kyBbkR1dd1DgSJNUP88GGVXDiDUIrD1+9n30epRICUfO8ySB65Z4ChdiYA1oUaqb+AzrWUeMhG5jkTXNNW9EoH8BRkwtMUI/EFcgPwuUg+zZhZd0ZEc0wzNbkUcJNF83wGdGKW0/eXexi5lsBrJBZHrusGrG74wJAg99Xvu8rn4UNgGpCGe1v0FretL5d3IhJw6SwMehbrq63M+64Yu/rNv2Mi0sLRKU7Z2S3y5UIUgQ4PmKpFAzUNtSBkwmYpdIrSGFX2r9XSpfpqF4kRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7es05uwj81B5uKKttLItlPmvCkFKZv/hMIgT1nnsNEM=;
 b=g4Q/0RZKXU+qKAU+iPtnDyb7LYpY3ew1TBc+CR3CIgg/XvKEIzj3pKeIg9go6shLgDZGintADbVFRsEw2jn0r5pIHWDlVvHbQQYUn8Mmk6nFFQ4qxmgbNHB7nm/LsXD9UyDl57DVrQLOWpQkLXBu/ExbszjAwzL8jSnYeQkCxJSRd8Rq2lfNCwNujYe1R7pwlgCFzoXC1TtXB0mO960LuXgSjzpLC9npDnA3mUjqHFtgksmjqhUSSW/LMH//r05mM37iY2LPUXEM1Ma1JBeR+Hg626Awm2NuqfVoT3d9gMx73qZ49diiO2wy14Vx0nL8FbuSBrAVBU0COtIGT/0HNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CY4PR11MB1703.namprd11.prod.outlook.com (2603:10b6:903:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 09:38:07 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::d9a2:bed7:a188:a582]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::d9a2:bed7:a188:a582%9]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 09:38:07 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [PATCH 00/10] iwlwifi: updates intended for v5.18 2022-05-17
Thread-Topic: [PATCH 00/10] iwlwifi: updates intended for v5.18 2022-05-17
Thread-Index: AQHYac1XoLU3398g0kOqIPEhlt/B8q0iz/6A
Date:   Tue, 17 May 2022 09:38:07 +0000
Message-ID: <ac00ab264de1d3d615c956ec256caf9ff30d1206.camel@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a1e8a74-f983-4612-9b10-08da37e8f31f
x-ms-traffictypediagnostic: CY4PR11MB1703:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1703C3F4E4CE1AC1A4449C5D8BCE9@CY4PR11MB1703.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8tDBOl+7RYjrtjUCl7iCjl89pW7lNNNeE6TSSZIeoQeNfwhSnPkcXZic0fcmLMIzqmh0E/f5mKhC/dyDLK0MKhDM8eVQz83EfpWMZov+o6sP7AWyTBNmO66HrQz2OaGfXd5aqg8ftnPp093OfXts4WSNIXggIBZbSXoyUze0g+Ii6TWEqrRErdXKcqVCedcFQCaH+WqXZkAJG9KJdGHQo5xd8FI8CHzb2q+NHDLDZJFDz2QIvDqOii7ubPh9NRF6pV9p5qLQHc1/dZk9NL/EWAPPPRsyn+4zuQ6RTZCT1nW5mNewRSgjlkhVhKwOY0LbWRlc9YdKebmuPynyLbhqnYU+4K08pQDpxq0C/IcMHkafFSWN1mnzBN4ig3Ud9qbHtqjx7XcHDt3Yt8ntAs7rdZ9B16qLL2HH9o5yKfwbdsAAlA6kV5Q5HOB3G6XHpzYc/Bu+y13EFYz8vadJ87rlU92xCxa+mHO/YCV/2/EVVkeIy+PAowcVf9Je6e39N15Pyvhf2+k2HfCP6UAjEDWIU9zjEvSq2ba/ARlOzEy0sN7sluUhTmNuTDs1Afl2Lf/0KMn/MzY2ZBaP20Wa0ZPnMRqwglfrxTVfE7lkVW0VMr45jufjinBNcKhX16TcWuLuz19zTsAXMVQj5VbDJGQNdhDldkpnRCQQeIn007Hg7MguxPwnvuxOSTbuP/Debzga8tKuQ4cq4/BdccMx812MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(316002)(26005)(6512007)(6916009)(36756003)(508600001)(66556008)(66476007)(66446008)(82960400001)(54906003)(122000001)(5660300002)(4326008)(2616005)(86362001)(91956017)(8936002)(6506007)(186003)(71200400001)(6486002)(8676002)(66946007)(38070700005)(64756008)(38100700002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODlYNTRTSVRRdkQzTld2ZE5zWXJ0amxaTFVpalY5YlJqYXBqSE80bysyRWM3?=
 =?utf-8?B?cUJoZjRIb0g4Ukg3WWNjekZHQXNvN3ZrSEUvN015cVlSN0F5OEZNbzhDSjlO?=
 =?utf-8?B?NmFramZlSnBwVkNSZGZEbHlnSUExa0xUeExZYjdCK3JlMVhGVHNhVng1eTdM?=
 =?utf-8?B?QlVmbjRtNzAzbE1tSlp2VUFDZjJYWFpCRUpuNWdCcWJHNlVjM21ZTEVaVVNx?=
 =?utf-8?B?SVh3aURSYVVldWVmNUQ0VzhXNkdaTUV5WVVjMVE4bHIzd2dIa2U1NTQzM000?=
 =?utf-8?B?RkRqSExsVU0xdmJtemovNjd1SjNrQTVmbnZTQ0lXUXd0V1YwMXRTRzlnYUlP?=
 =?utf-8?B?aWt4WWJQRHRqczRaTVhlb01jU01wOU9FdTdEeDkyU2FEd0I1c1NqSGdiN2dR?=
 =?utf-8?B?dnp4RDQ4Nm1XZ21QclQ0N01Na3lSNVcvM2U5eXhQQ3F5MnJ0akxZV3llUE9R?=
 =?utf-8?B?THhwMFNWMkdIVjc5eVFsdUVGUFNxMno2ZlN0ckRDSU9jdHRIeFc5S1pGZU5v?=
 =?utf-8?B?Q253Z2hFSnhRWnk5VkR6WUd1ZGlIV3JVR2ZuSlZIcVA3U0dmTFkrelRSWkFR?=
 =?utf-8?B?UzYzK2hGWDBPajFFSm9YWlBub1JTaEhRUzk0Vk1UdlA1cnpCTDhPVk4yNVFD?=
 =?utf-8?B?VURqeDN2aGgramU3Q1VYSkxiR29Ha1VBZDVsK09FQ2E5UlVsVG5ZVkprZ2pJ?=
 =?utf-8?B?QUZGUzRlTU4yR2tnYldlb0k0dCt6TnpNd0dqbk4zOU1Xanc3SjlKNmdSVERq?=
 =?utf-8?B?WE5lWUx2YTNtRmdSQmZJRTV3Y20wWTR4dUQ0UjhoWmhvcmt0WkROZmJ0UGVn?=
 =?utf-8?B?VHdOVzJuSVVlZ0YrTG9oSjdmNjRZb2cwR2M3LzUyMFB2Y1lrUklZUXFiL2Zm?=
 =?utf-8?B?clFKZUdKVjd4VWpvaFNDRVhTTlpsUFYxaGNCWkFyQ3RYb2JTVFM1TVpmTU9Q?=
 =?utf-8?B?MzBRMXg5Q2E3bmFaTzEvdGlDRnNhN2pZWGtuWitwTFhjQTJxTDkrYldqazdj?=
 =?utf-8?B?bEY1ZWMrU2NhRDlWQmR5Ymg0eXlCcHJNUTZtanVjanNjTEcvb0xVUVNlWkEy?=
 =?utf-8?B?TlhiL2pDRE5HK1k5bEVKaDg2emYzUzBMRXFISnI1bFFXTkNhZ1NzRG94WVB2?=
 =?utf-8?B?Mmd0SCsxeWpqMFVsNlFVWlY4VFdmanV4Q0RXV215K1l1bERKY1d6M3hFRTRG?=
 =?utf-8?B?Mk44bGxmczUxbndaUWVxdTBmVXRQNFZWT0xuOUhOS3hFK1BXU1VQVWdQZkVU?=
 =?utf-8?B?aXJSVmZGZmJuSi9OMElYbWxtY3VGS1ozODByZDFKWXNlSFB3NlhxV3cyVDhp?=
 =?utf-8?B?R25sczVXa3pRWnowWGFCZE1TYW9zOEdnYVJMTkErcGZ2bHlhcEdhV0s2WnBD?=
 =?utf-8?B?YjhJbUVrUVRVQ2pmMlpXMkp6bmxoZHRPQnExdnpQaHZZSnJwL1Y5QndvSlNM?=
 =?utf-8?B?K3RIa2p5TkxyUmtNbHR3bStlZjVsbG00SEhabG1jYks5azJPQktwY1h0RFZS?=
 =?utf-8?B?bDBKL09vZEkvanhiTVg2WTdvTEhVZ2E1V2RmRmw5VnFSd0xTRkdUM2JFYUtJ?=
 =?utf-8?B?dnpLNDB2dldTNVNPWUVCeEx2czlKSnE5d2ZRWWQvTTlQcURhOEpVOUZsQ2pC?=
 =?utf-8?B?ZUhlc0FYbGZiRnJiU3JpRUJDVnl1cWtKV3FrMk44YzhlOFZuT0VyQkRPcUg1?=
 =?utf-8?B?OTFWR2c5VmsxNzNTTnFYOHdYUStlRGM0TFZkRFhScUFSaXJ1dTNRZWVuRk5h?=
 =?utf-8?B?OURBa0svMitoNXpERmhVaGhEOXpIQUZtL2dZV1ovWlFRaTlEaEsxT09hQW16?=
 =?utf-8?B?Ny9yakFDdEZvSU5WeTlZeCs0RWNHS1V3MlpCMjFLWXdqSFdhQVVpTEFQUEhr?=
 =?utf-8?B?eTUrajF5bGhpSU5Vbkp2VnBmM0VuOUtLZmJ2VjFwazZVNmZXSGdlMmZYV3ZW?=
 =?utf-8?B?T3YyK2lSZnhiZm53Ykt4djhFZ2VuL1duaUpnNCt5SHB2Mk5tK3NVTTg1TzVZ?=
 =?utf-8?B?Njk0bllqMFpaNnFSNjFidlJ5cUhYWHJ5RndMaW5zVUFaTHk3MzJIM0xzdml6?=
 =?utf-8?B?andpVEdTendreTJ3NU4vSnJWV3N4UzNza1lPck10aEtNMUVsR29NOFpsQXR1?=
 =?utf-8?B?RmZHVldKY0ExaTVMUEc0TkhjemVPc2M1aS9QVWR5ODdBWjJiMzBXL1IwNEpw?=
 =?utf-8?B?R2lFd1VZdXdLdGUraXV4RlFIeE0wV0c1ZHIzbnFOci83b2NLd2xPY1ZIRU5m?=
 =?utf-8?B?RVVPenA5N0ZhT0RBRU81NkhLa1FUeS93cm0rcFJ3em5uSm9aT1dKYzhyUE5h?=
 =?utf-8?B?eXg2cUlzTkdXMzZ4ckhOdE1WYUpZbWtsTmhySlNRUEZoTHVLbmk0WXJETHpL?=
 =?utf-8?Q?uMtVELaJ06NRPiZ2ez0LML075oUUvCDBx1NZz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <021F5766E39F5F49886BE2635ADFCB94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1e8a74-f983-4612-9b10-08da37e8f31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 09:38:07.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4sUnF1aqyqXALzutjScDcqOD5HZh5deKzYa3use2GS0E0yzPXV7De/zK9ss+zwF06KePgaqflnq1yJA76mDwF+duaGUsBh5OLA1FT0xKsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDEyOjA1ICswMzAwLCBncmVnb3J5LmdyZWVubWFuQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBp
bnRlbC5jb20+DQo+IA0KPiBIZWxsbywNCj4gDQo+IEhlcmUncyBhIHNldCBvZiBwYXRjaGVzIGlu
dGVuZGVkIGZvciB2NS4xOCBpZiB0aW1lIHBlcm1pdHMuIEl0J3MgdGhlDQo+IHVzdWFsIGRldmVs
b3BlbWVudCwgYnVnZml4ZXMgYW5kIHNtYWxsIGNsZWFudXBzLiBOb3RoaW5nIG1ham9yIGluDQo+
IHRoaXMNCj4gc2VyaWVzLg0KPiANCj4gVGhhbmtzLA0KPiBHcmVnb3J5DQo+IA0KPiBBdnJhaGFt
IFN0ZXJuICgxKToNCj4gwqAgaXdsd2lmaTogbWVpOiBjbGVhciB0aGUgc2FwIGRhdGEgaGVhZGVy
IGJlZm9yZSBzZW5kaW5nDQo+IA0KPiBFbW1hbnVlbCBHcnVtYmFjaCAoMik6DQo+IMKgIGl3bHdp
Zmk6IG12bTogZml4IGFzc2VydCAxRjA0IHVwb24gcmVjb25maWcNCj4gwqAgaXdsd2lmaTogbXZt
OiBhbHdheXMgdGVsbCB0aGUgZmlybXdhcmUgdG8gYWNjZXB0IE1DQVNUIGZyYW1lcyBpbg0KPiBC
U1MNCj4gDQo+IEhhaW0gRHJleWZ1c3MgKDEpOg0KPiDCoCBpd2x3aWZpOiBtdm06IHVzZSBOVUxM
IGluc3RlYWQgb2YgRVJSX1BUUiB3aGVuIHBhcnNpbmcgd293bGFuDQo+IHN0YXR1cw0KPiANCj4g
Sm9oYW5uZXMgQmVyZyAoNCk6DQo+IMKgIGl3bHdpZmk6IHBjaWU6IHNpbXBsaWZ5IE1TSS1YIGNh
dXNlIG1hcHBpbmcNCj4gwqAgaXdsd2lmaTogbXZtOiBjbGVhbiB1cCBhdXRob3JpemVkIGNvbmRp
dGlvbg0KPiDCoCBpd2x3aWZpOiBmdzogaW5pdCBTQVIgR0VPIHRhYmxlIG9ubHkgaWYgZGF0YSBp
cyBwcmVzZW50DQo+IMKgIGl3bHdpZmk6IG1laTogZml4IHBvdGVudGlhbCBOVUxMLXB0ciBkZXJl
Zg0KPiANCj4gTWlyaSBLb3JlbmJsaXQgKDEpOg0KPiDCoCBpd2x3aWZpOiBtdm06IHJlbW92ZSB2
aWZfY291bnQNCj4gDQo+IE1vcmRlY2hheSBHb29kc3RlaW4gKDEpOg0KPiDCoCBpd2x3aWZpOiBt
dm06IGFkZCBPVFAgaW5mbyBpbiBjYXNlIG9mIGluaXQgZmFpbHVyZQ0KPiANCj4gwqBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FjcGkuY8KgIHzCoCAzICsrDQo+IMKgZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtcHJwaC5oIHzCoCAyICsNCj4gwqBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9tYWluLmMgfMKgIDMgKysNCj4g
wqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5jwqDCoCB8IDIyICsr
KystLS0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmPC
oMKgIHwgMTUgKysrLS0tDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9t
YWMtY3R4dC5jIHwgMzIgKysrLS0tLS0tLS0tLQ0KPiDCoC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vbWFjODAyMTEuYyB8IDE3ICsrLS0tLS0NCj4gwqBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaMKgIHzCoCAxIC0NCj4gwqAuLi4vbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL3Bvd2VyLmPCoMKgwqAgfMKgIDMgKysNCj4gwqBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeC5jwqDCoCB8IDQ0ICsrKysrKysrKysr
Ky0tLS0tDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvdHJhbnMuY8Kg
wqAgfCA0OCArKysrKysrKysrKy0tLS0tLQ0KPiAtLQ0KPiDCoDExIGZpbGVzIGNoYW5nZWQsIDEw
MiBpbnNlcnRpb25zKCspLCA4OCBkZWxldGlvbnMoLSkNCj4gDQpDb25zaWRlcmluZyB0aGUgdGlt
ZWxpbmUsIHY1LjE5IHNlZW1zIGxpa2UgYSBtb3JlIGZlYXNpYmxlIG9wdGlvbi4NClNvLCBsZXQn
cyB1c2UgaXQgZm9yIHY1LjE5Lg0KVGhhbmtzIQ0KR3JlZ29yeQ0K
