Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D49735AA3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjFSPFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFSPEi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 11:04:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D341BFA
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687187018; x=1718723018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zf+9WF/3g2mq/In2YqU7a72sg+3g2+b5ialAagAVw7s=;
  b=cWRJkiaqxc/5PfW7vHP3BFDqyX/YCsEDZnfswBdp/wWDjeGNLf1FY2RU
   1jGFd+aZxhpShKhUx/oSJX32srJ14KEA4yFBSjShjvSh8IVLIlgTEr14X
   unNUNetdPSp7Vap//NOlD5G2n9bJr6ja5wR1Y1OYl/MH/iE5JO1dga0Ot
   +waurXyvRTeE4vMXorNxpDhpLJPg6W0xJ38OsPaB24A17tiYpQ59l77Km
   p3rUFxJyVNUsZnybNzzZHmcG9NynlOOqLKlfAl+zW/Qq9T/Fz3ncGCSNN
   ps2LM5ie0Bga+jZSqclTF4K9A+FpkYraJUgbVYvBdJOEhKe/j4znjc3Vp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="425602278"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="425602278"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 08:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="691122728"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="691122728"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2023 08:02:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 08:02:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 08:02:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 08:02:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 08:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO2hrtnpfkeWHXdXWM8ZrubuD3ngrzllTbVu2rbscphxMmiyxhjK+cKctuZE4ZgvcUqAUOvGhPf1j6CxV58+bkAagtS3W+Mq7pP8N+vXFrrlMLysknw0lB7feTtbvkAXYNmhSY4I4UEAcxllCJQhatFyxEc0kSDTE1fa4M08r3Kkg6C8No0fVtod1O8W8dUA11CypVgJ55VbSQ8/TUEe4l5toKJZa9/pa4IhO6v+ku2jiEggkqfZIn+/sCzLfCFEXZ/oL4u9DQwNfmsBA5euXidyFOB/qZGN8QQ8qlTO7gkH+0yceg35h7f0EX7GUT8Bw2Ojiv567lHc7ViXGSO4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf+9WF/3g2mq/In2YqU7a72sg+3g2+b5ialAagAVw7s=;
 b=JssfHhsI6Ulz9xZYI8NsFElzjhV+6BQP4a107LvsyL3y5eWNDHh5lXgbbkyLWS6KrhgkTMXCLSGZS43jee9mrQey7emQARPMUK7LnLuOw9zIN8eQiiV2odUWVIzEFbUTaaVlN3XopC4vMlBFZKLxR5ZE2k9F1IQbpUWccmHbAkxZhq6xEh+mXqK7k2Oaeh2ud9LnjL0IvKaM5h0XtogOWDOtS2EQ6tUtaFTIScaqB5A59eLVPWhJogMZV0JQ+0+msch9B9Zz2MAQodpCtDfOBB0NIealDzxJpS59jffTDaUGjCdUh38VbvC4iy1itkXgsX1DyELepZz7ERflP+6zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH7PR11MB7076.namprd11.prod.outlook.com (2603:10b6:510:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Mon, 19 Jun
 2023 15:02:10 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 15:02:10 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "yi@yikuo.dev" <yi@yikuo.dev>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: iwlwifi: pcie: add device id 51F1 for killer
 1675
Thread-Topic: [PATCH v2] wifi: iwlwifi: pcie: add device id 51F1 for killer
 1675
Thread-Index: AQHZmeMV9Dx0Ed7tsECXCwICjyB1yK+SSkIA
Date:   Mon, 19 Jun 2023 15:02:10 +0000
Message-ID: <d3048e5180a1fdf9ef679eeedf63e34b4487fcae.camel@intel.com>
References: <20230608082725.353150-1-yi@yikuo.dev>
In-Reply-To: <20230608082725.353150-1-yi@yikuo.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH7PR11MB7076:EE_
x-ms-office365-filtering-correlation-id: 3302a095-0df2-4805-7c9f-08db70d62856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aAz3AOe/LcGxzr4qnZMoma4Wk8x11lAJPQQ7mq+KNavqln35xQkbAq4lgnMb2NdQ382WhuP9MCxSLXFTe/esx8OBtPKbGKk5oDPGhMT2dYoqKv5ayiVDY4Cskb1L67bBRr3AfpsCxP+CkZ+n10CGWeh06goWQwueV5knRuu8b/cUy1TKD/qjHYXBpP+s6Uh77tbIoVvubmYoP4C86vSO0yg5cmpQSt3FEQ0eVezZhOMVVpaSKias+CTFsKBP0B30qh/G5DP1ep80CTDhucZlnXIm0M5bq7N0wHaMJHIchObjCiohNJs+RRJCCdfsYXuTFHdfn8uxIRWipCY2js1BjtaEsrm9f6KrPeA3jFl3sRJZNVj7kk3ZF9ClfH+fceaYapqzAjfLexslzZu/2Rr2Gt6lh0j6ylRmjsMmjI6z3naAb7tLjidVtwuYLQwhh3gek78Mccdw+6ivM8x/Q3tVXPOXSQ/HH2CI3ehuIwHQDECheOxSA1CFPjk9XlD2Kg1whzLV6ZDzXhbAaGEh9rREbMaIpQMfEfSgxk/ymcnU5qYncCwmhUNpGZyoOAGUWzUBVtLauP0Z4Ot0xN5dCZ/wmsRQsNPwd7t3eKVsnTajVpG/pog7FF4KI5QXRI2Xm0HP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(91956017)(64756008)(2906002)(41300700001)(5660300002)(8936002)(8676002)(4326008)(76116006)(316002)(66946007)(66476007)(66446008)(66556008)(36756003)(2616005)(71200400001)(186003)(26005)(6506007)(6512007)(83380400001)(82960400001)(38100700002)(38070700005)(86362001)(122000001)(478600001)(110136005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkp0dzRjYUpYNjdQdUx5NnRNYStMTmxKaGdvblcyQnhMSnpjVkFsazE4a09G?=
 =?utf-8?B?L202VXpuOFNFOWtaZVFJMjFkdnlpdnVuOUZjTUpGK2phYmgrK3l3bHBycVM4?=
 =?utf-8?B?NzBxU1ZxMzE1OXhFc3ZBNll4bFNQRk5JYk9YTm9xazZ1QmFuNDg1NjZ6MTAv?=
 =?utf-8?B?VjlXelFFd1JhbHZxVzVZQ2FpWkNzd013WHd6RnoxUDBVRTkrZ0IrRTNxU1lL?=
 =?utf-8?B?eFJ5MU94czRwZGRQTXlqYk1KQ3Z1akl3YXRXVXhjMW5BT3NWZ2MvazZCZXRk?=
 =?utf-8?B?MW9KaUtsMHlmOTFBb012d284TitFVk4yUlNQZm83ZU43ZnVHR1pTMjNwLytD?=
 =?utf-8?B?cFZidG82ZWxXN0tFeFBOcHAxTTd5QjI1Qm82eVdQd1JYQlBKbGNPYlUxTXA5?=
 =?utf-8?B?NDM1TC9jaDFZU3AwK3h0bnJhMDdvQU55VjczenczejQ4a0Fhek5mdEpFSzFK?=
 =?utf-8?B?a2FCMjI3QVpGd1gxMGh3eEtldzYycmgzV0tMQXMxQWdqMVIrN1dDNHkyN3Zv?=
 =?utf-8?B?a08wT3VWbzdqSThrZzhKdUduK281cWxNL3ArNVN3WTlIbnkzdGVHRDVGWU1M?=
 =?utf-8?B?blpMSDErOGtsYmxjRXJXY3dEWTdOTFQ2dHBZTXcxcHNZK1ZVRVdGeVYvSm55?=
 =?utf-8?B?M0NDaTNYZ2t5MHJBQTZjaVhmOTdqYUhhaGR2c3A5UElKUlBWa1VMc3B3WlFi?=
 =?utf-8?B?ZFRIL2xXYzVPdjdGRjlyUzBXT2w3MkdhWXNZUGRRb0RJbzNJMXV4am5oTXFT?=
 =?utf-8?B?RG9TRWQzTTlXaWRjVFVOd1Zsc0QwQksrMFMzc0dWYUxSMzQybWg5Sk9lcTFh?=
 =?utf-8?B?dUtXdGYzWkJnRHhpSE14L3pITmVxcGJmS2J2OE9iNlZDVGY3ekFVb1hLaUhl?=
 =?utf-8?B?OFp5VGlJYkxkN01nR255SHptTmNvMHArc2pMbWg5dVFwZUdXZUlEN29CY1Ni?=
 =?utf-8?B?MUUzNTRoOUpOcXEzYUpoRXhoamtCVDEzMDJueU1jQmZqazZIejAxTXJpK1Np?=
 =?utf-8?B?S3JQcG52TmRlZkFqejR0UkVtRjlKMUtIT0QxSXFCL2ZIaFhZWDdkd3V4bTg2?=
 =?utf-8?B?TmZUUkljcXdKY0VtbmZMM2lhWnFQa0Q0MStnanRQOFdLRmYvZzZlNTNmV3Vm?=
 =?utf-8?B?eDVIVmJmeUhlRjkrVW5VSDNBc0FJdURNcHk0MlJpSjNTb0lWSkhVUFlIcUJU?=
 =?utf-8?B?dTJWaFF5TkhUQXhFMmd3TWJPbFR2SnJsT1B0Z2JEU29BVmJ3bk9LaFBWYnUz?=
 =?utf-8?B?d3N0elBEL0VYb0FpNEIxSUwyd0xvZFhMZ09ESGJRb2xEeVN1c3ZnSFhRVmg5?=
 =?utf-8?B?aUhHVG1GSC9sSHFuaEYzRytMMkJiUlg2SzFiUTlBWE13SE9pUnRoTXBlSmNG?=
 =?utf-8?B?UHBrKzhWT3RjSjBtYVRvUVcydGNqbWN1eTBzTVlBczd4SnpNQlFsanlaaisv?=
 =?utf-8?B?Vm1XeU11bCtHckx5NU5KSGpXYnVtME9QdGVjZS9OT21kbkFIWDM3ZHhIaGU2?=
 =?utf-8?B?VWpUUGxEYXhKYWxLRGZtbjVaMHlwMDM4T0FvUWRoZzQ4WTZ1MGlQTzFIM2J2?=
 =?utf-8?B?QU0wNnQvMzJQN21NaitjSXlYSFRDN2drbktWMjBnS1J3V0dIOE9peGJIUU05?=
 =?utf-8?B?cmtuQi9HY09OK0N4YVl6SkY5eHptVnZrZWpaalJMVVJTaTl6YlNBSk82UnRL?=
 =?utf-8?B?eURyamUxWkdxWjJtUFNPWnlVQUVKdm5KYUhSSENLbVpoVlZaL1Azb1JZQ2FB?=
 =?utf-8?B?UXR3L0p3MFVBZXBwRi8wT3BQb0JJVzdESmJSVUZoY1MzZ1ovYnM0bHNXK1dt?=
 =?utf-8?B?OWw0U0Vkc0V2MldJdXVNbHcyYzF6a2dGTG1QVVV6bFNkSEh4TTd6MXdFSU1W?=
 =?utf-8?B?S0dhUzNDcTJXYmFCQ1loRlM1OGpOZTNZVjQvRXBsc2prbkpVZ1ZwMk5IcGxs?=
 =?utf-8?B?S2NQN3B5OHEvWVFEL1dXZVBPNFlKNENpTU45bU1hRnllbTVPaUNncWFPc0JL?=
 =?utf-8?B?Z00weW5Za0duV2JwR1l2NCt5anJqcHNjT1ArS1FtM3RJOG5Yb2pZa2V5WDIx?=
 =?utf-8?B?UnRaT0FxcGlQSXJYTGptV2F6K2lmbWN6azhyTGtpNmw3ZTlJUkY0MmViQWZk?=
 =?utf-8?B?TFkxV21FajNVK3RTS2ZqVjJlVHYybE41K3hqVUdqOXpaS2Z1ZmtuTTBFejFH?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6522F10CA3D9BE4ABC2269E2D6D1602E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3302a095-0df2-4805-7c9f-08db70d62856
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 15:02:10.4676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zm3NKVl0GO+ewi4VQ3XMbrTHIbm/KxF9YDVSHyZONCudECJTapLFY49wEhmLf9rvQRs6NgizILhjTApklp90QjDAgZUfYiR+V1JqZ2v0ekc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7076
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

T24gVGh1LCAyMDIzLTA2LTA4IGF0IDE2OjI3ICswODAwLCBZaSBLdW8gd3JvdGU6DQo+IEludGVs
IEtpbGxlciBBWDE2NzVpL3Mgd2l0aCBkZXZpY2UgaWQgNTFmMSB3b3VsZCBzaG93ICJObyBjb25m
aWcgZm91bmQgZm9yIFBDSSBkZXYgNTFmMS8xNjcyIiBpbiBkbWVzZyBhbmQgcmVmdXNlIHRvIHdv
cmsuDQo+IEFkZGluZyB0aGUgbmV3IGRldmljZSBpZCA1MUYxIGZvciAxNjc1aS9zIGZpeGVzIHRo
ZSBpc3N1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlpIEt1byA8eWlAeWlrdW8uZGV2Pg0KPiAt
LS0NCj4gDQo+IMKgdjI6IGFkZCB0aGUgJ3dpZmk6JyBwcmVmaXggdG8gdGhlIHRpdGxlDQo+IA0K
PiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyB8IDIgKysN
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+IGluZGV4IDk5NzY4ZDZhNi4u
MzQ1OTJkOGNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL3BjaWUvZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9wY2llL2Rydi5jDQo+IEBAIC02NzksNiArNjc5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
d2xfZGV2X2luZm8gaXdsX2Rldl9pbmZvX3RhYmxlW10gPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqBJ
V0xfREVWX0lORk8oMHgyNzI2LCAweDE2NzIsIGl3bGF4MjExXzJheF9jZmdfc29fZ2ZfYTAsIGl3
bF9heDIxMV9raWxsZXJfMTY3NWlfbmFtZSksDQo+IMKgwqDCoMKgwqDCoMKgwqBJV0xfREVWX0lO
Rk8oMHg1MUYwLCAweDE2NzEsIGl3bGF4MjExXzJheF9jZmdfc29fZ2ZfYTAsIGl3bF9heDIxMV9r
aWxsZXJfMTY3NXNfbmFtZSksDQo+IMKgwqDCoMKgwqDCoMKgwqBJV0xfREVWX0lORk8oMHg1MUYw
LCAweDE2NzIsIGl3bGF4MjExXzJheF9jZmdfc29fZ2ZfYTAsIGl3bF9heDIxMV9raWxsZXJfMTY3
NWlfbmFtZSksDQo+ICvCoMKgwqDCoMKgwqDCoElXTF9ERVZfSU5GTygweDUxRjEsIDB4MTY3MSwg
aXdsYXgyMTFfMmF4X2NmZ19zb19nZl9hMCwgaXdsX2F4MjExX2tpbGxlcl8xNjc1c19uYW1lKSwN
Cj4gK8KgwqDCoMKgwqDCoMKgSVdMX0RFVl9JTkZPKDB4NTFGMSwgMHgxNjcyLCBpd2xheDIxMV8y
YXhfY2ZnX3NvX2dmX2EwLCBpd2xfYXgyMTFfa2lsbGVyXzE2NzVpX25hbWUpLA0KPiDCoMKgwqDC
oMKgwqDCoMKgSVdMX0RFVl9JTkZPKDB4NTRGMCwgMHgxNjcxLCBpd2xheDIxMV8yYXhfY2ZnX3Nv
X2dmX2EwLCBpd2xfYXgyMTFfa2lsbGVyXzE2NzVzX25hbWUpLA0KPiDCoMKgwqDCoMKgwqDCoMKg
SVdMX0RFVl9JTkZPKDB4NTRGMCwgMHgxNjcyLCBpd2xheDIxMV8yYXhfY2ZnX3NvX2dmX2EwLCBp
d2xfYXgyMTFfa2lsbGVyXzE2NzVpX25hbWUpLA0KPiDCoMKgwqDCoMKgwqDCoMKgSVdMX0RFVl9J
TkZPKDB4N0E3MCwgMHgxNjcxLCBpd2xheDIxMV8yYXhfY2ZnX3NvX2dmX2EwLCBpd2xfYXgyMTFf
a2lsbGVyXzE2NzVzX25hbWUpLA0KDQpNYXliZSB3b3J0aCB0byBicmVhayB0aGUgbG9uZyBsaW5l
IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCk90aGVyIHRoYW4gdGhhdCBsb29rcyBvay4NCkpvaGFu
bmVzLCBkbyB5b3Ugd2FudCB0byB0YWtlIGl0IGRpcmVjdGx5IHRvIHdpcmVsZXNzLW5leHQ/DQpP
ciBJIGNhbiByZXNlbmQuLi4NCg==
