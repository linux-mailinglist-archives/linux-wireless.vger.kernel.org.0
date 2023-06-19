Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394AD735261
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjFSKeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjFSKeP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 06:34:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC90E9
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687170853; x=1718706853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eqpBPHXHk/a1fODV4/K0ErDJBDFPAoIuRCJPCO2uUig=;
  b=Ex4vgG95+8uJPSZ6laX826sZAslW0Nt+4zLCk1NjKxRo2zD5srZ4pVhm
   uOYR4H/Xm2ayFGffMPl2pYTNftf46rA6jMdilEVsGwrNn6HT1QuHQcwDg
   DnAmmD4PqgG8q+w1i130W8pCIO2DIje1GMuNU2CYX2SQ6Y+cI2SCHclUs
   IsUCpC3Od8MWTKPOFGVz06UlywoFm5XQFi1wrAbMzkaC/IIjhryvzjyvk
   Sb+Dqem+2n/09deIgBAcNouozwyERlSCfe+U/yU2lxeoguNdGMsKhIQZQ
   D4Wyf4YmJkqhiPMZtaBptqz8Ok+E485sC3R5pGmcKEn8lQIgrZCMWjg2u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="349319525"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="349319525"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="691055672"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="691055672"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2023 03:34:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 03:34:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 03:34:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 03:34:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 03:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HStSVznTGsryNaVe0k/VK8Ntqk+9YY5rxSZ3IJCWFQ7Jj1BhBmooqIfb4uEWQgkHtmYRMAq+n1HVd1JHZfUyQTNOgx9p/zKxpKkZvN/y0TKjyCfVF3yJ4ZD+4W9ME44HeLNl/IbLP46RtOvFsBmJam8BfMVi06GFj+PzDmEb6ZhYH3Kb6yhgQz39wnRaw3JOxRuCJJ5nhHeUBgwlAOwjTRFXlFOJkxUFDcdc3XL6nwIiPK6GbYl85Oquby1nuvEK7S3tXz+ZOy5m1iHiRo8dxHC8VSPxGqIf/mO4tipBAAQ0JubWLPasx9zK7ict5SDNIvlqbf/Eir0JPNlNMarcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqpBPHXHk/a1fODV4/K0ErDJBDFPAoIuRCJPCO2uUig=;
 b=QeAYT1pRhdmrqm7E19Th/ze9ttaOLX9+aFW3v1hp87rCCyEyNuWRvdJ5MtTEitLQD6zyl6uDVTCiQN5aiSiKcGEdz4R9KwXBh5qVbfiynpj3yL6sXa1rGRyWSFtjwf0TMAYvdEIJZMapO7O/jB963wHIRih70WC+5zjNVNWTlK0j5Cy4LeV/Lv0uPY+fchSMJ/dl3Gl1QayJ1VlgaCSI/BCCuktdd5f5rv0/xIuKlmsKDQrGhPGZOWCUowfZNIXrG5o6Yb9viB/tUr4bsK+6nQiNGuYxKcI3s3TpYQS7pxbbJTftUkTPUAQuHhSlxn6MoLdiA7xjhS+XrJCWuKPU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 10:34:10 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::557:ad6a:40f:3ef%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 10:34:10 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "Berg, Johannes" <johannes.berg@intel.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlfifi: fix -Wunused-const-variable gcc warning
Thread-Topic: [PATCH] wifi: iwlfifi: fix -Wunused-const-variable gcc warning
Thread-Index: AQHZopUj+pZgpXoNy0SdK6GTC3Mf0a+R7ZOAgAAAa4A=
Date:   Mon, 19 Jun 2023 10:34:10 +0000
Message-ID: <247acb4669c57523e3f777fb1bef5e016f2d8c84.camel@intel.com>
References: <20230619100030.284920-1-dmantipov@yandex.ru>
         <fbea3467e08bf11a8810b71de2fa17a9e0c091d8.camel@intel.com>
In-Reply-To: <fbea3467e08bf11a8810b71de2fa17a9e0c091d8.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH0PR11MB5299:EE_
x-ms-office365-filtering-correlation-id: 6b3b0f53-5d91-4468-9757-08db70b0b7ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWZxSL5fITvZpM7EPCEzCUii7vcmempqkUUDbSxEa1KGJS8zvgTJBHgdAS51dI3j48iLsSVkxpHxSkaSYnb1AEDrK5W8VwEBVhOzAHytD1BzW7gtb8THuMSfLcEpFroUV5P9BKJlgTyqHLINa16IoGlJpUJlNVPRiR9JARGyFiM+wKVrR3ZwIp7E/yeZn9csW7cxdTprm5Tj62i4oXChWB9yZNxy65Dp9ZT+HH4YR2tgZEaFCIu0MukpoUO8ycepOeOa9q5QKkZyW+sw+yNGryN1ZAGv8x/GMYKlyFbiTnkbHSzBKRD5poRmh4pbTlpZjFliyFMAHG98Wz04+wJDCX6tINzQ8lHNqbTl2BmRyK7+zhga3IVimZlmLo8me8rMWCNpsKbK1QS87JqGV1jgwM8QwfdrbbQOcIzDFtDRs35l8X5xbKbXNBX8k0nVTG0SAZb7+BAjD8ooZao65FkpyeN+hzMiNMiZ/fxTvbCFDE07OhJazvR4dxbucDAv3L5AVn9kLXCMeY+M+Rqf+/3/4VPkljmNDVa+LnrWGl1JYOTonRLWLhQrWRKGTN73TYndT4bvYEGOjQ1/PAWG8wcegKFlUs+LImhzTi8aXCc2rTQ6BVQA3brvbCP1nr0xsu87
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(2906002)(38070700005)(40140700001)(36756003)(86362001)(26005)(6506007)(6512007)(54906003)(110136005)(186003)(478600001)(71200400001)(6486002)(122000001)(76116006)(66946007)(66556008)(66446008)(64756008)(6636002)(66476007)(91956017)(4326008)(38100700002)(316002)(82960400001)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEhEVHJrdnVEa0ZLaG5QL1dabXozRHpzaGl3Tm5sR0lISHBMK0hFdmpZY204?=
 =?utf-8?B?YUNGNUh0MHdxVS8rdXhtZCs5SmxORTdSTGRlcks5eG4wNXd3RkM0Witpb0J2?=
 =?utf-8?B?UWV4Q1VBVm42ZWdaUDV1Y2pIVUhNbkV0QjExSEF2SzlheGVCaDhvKzlxWC9i?=
 =?utf-8?B?K0JZZnRrK0dCOGRBNXBzZXM1RkIxQ1lkbDZPckx1OXJnS1RlQ3NRQTRYdEtx?=
 =?utf-8?B?dGl6SCt1TjhxSS9INkptZld2R0Y1bXBCU01lVTltT01ubHZHZW5ISldiYzg4?=
 =?utf-8?B?TnZ6TldNYmkwZFArVytkWGVnQ3BiR05lNlgxSDA2L1YvYkhUZUVmYkRxaWxW?=
 =?utf-8?B?c3RCNWNhQWhhWVVmNEZWYnNTbS9lcTNBQzRsRkdxZlF3QVpwNEhIN0RGenBG?=
 =?utf-8?B?Q2RGNXB6SEVkRkVNdHJXL1dsY1F1MXdiMldvd2FVUng1SUMzaHZMU2cwdTlC?=
 =?utf-8?B?NWorRzVxbzk1eEp5TkhNZnozTUxHait3OGhzc2tYN3g0SEZOSEFET3lhOXVU?=
 =?utf-8?B?a0ZMNkJheUQyb0RjazJUakVlNnJHM1ZJWWhBVmhIRzJzK3NPdkZCL3k4R21T?=
 =?utf-8?B?bzZneGZmRnJ2SVF2aGtORG84SHFyUUkybko0TmR5NWROb0ZOKzVLYlJyWnI0?=
 =?utf-8?B?NVhRL3R2K01YeUdta3VPdnRRNGVtck05dWNkb0MrM28zTXdoZ1lRK3kvMHBR?=
 =?utf-8?B?YSsyUEd4cFU5QTd5YzlJZk1KV1pmYWRzY0o3aDlEeHA1MnU2dEJOTURIU2cy?=
 =?utf-8?B?TzhyeFZ5dnJJN2p3L0ppTGRycUhOSzZHcUpPMWhEVERRdGFVTVdIQW0wZ3Z6?=
 =?utf-8?B?UTZSTlVWK2V4NC9oeDRCZjFZeUI5eWxmRUNoanFxMldTUkJTV3JoMFRrOTYx?=
 =?utf-8?B?WVpBb1cxNmxFR2tLNXQrUjRkdXhRMDk2eXVsUlJiTlZ4bjd5VjJVSXRJMDc4?=
 =?utf-8?B?eGc4cFZjMFg5amh5SS85T3d2UUZ0SWFFNzVrOFYxNnNpQjdRbVB1R3FOQkxq?=
 =?utf-8?B?NTVzaE56WUFmalZrbFlrakkweldKZ201andiZFZKVTFDQ2tIN1VPYlFEa2Fm?=
 =?utf-8?B?aHlQN3F1dVBCZld5aVFvb2pUNTNVN0RxcDFHeDNCYWRONUlMSEZwRXZDZ3V5?=
 =?utf-8?B?RmpFQ2FyWityU3IrMmtnMDBCRXEyc0Iyb1g4VHZUZXV3eTlYS0hwenlrRFVZ?=
 =?utf-8?B?ZTZ6bFU5aDJtNmo3ay84MXhTNVVKWlIra2xtZG9qVFdDcEpybGF5U2tIdzhp?=
 =?utf-8?B?Mkt5RlZVWHdGZ2wvSFpiOHl5M2VNbzduQk1VQ2lSVzk4Tnl1Z251UERjZERr?=
 =?utf-8?B?VUJuNDFJb0M3alhIMEs2cXFGUHI2akpzZEE3SDA4TWlkQkxuNTlUOFoyUW12?=
 =?utf-8?B?Q1V3YnQ1SFQxNEtScGdVQWJONHUxZG84SjVOZUFmTWo2eTdmV0NHZmJmOEE2?=
 =?utf-8?B?UHFXbVBuZ3V0MEF4Q2l4QXlFMGtTRFhlUEZ0eFU2NzdCcHBtblJvbEh2czQw?=
 =?utf-8?B?NWhnOGpybUNLeVlUWmJwV2c0SFBtenZMV2dsaUd4VFphTXRLMzhnclVGcGtZ?=
 =?utf-8?B?Y1UzWkZsb2NtYUgzOWdBbWFiTmZvLzRkQktRbU40aDN3UFQrNWR2NmFuZ05a?=
 =?utf-8?B?Z1RKUmYzZXU2bjNadFl1bHlRSzJTdHdob1NPaE8vSHFlUHJ3bWI5WkY0T1c1?=
 =?utf-8?B?RnpPcTdjWHlWL3hwSG9qYTB5NXJDR2VMaUpuVXRHTHBudjh2UTgrOHVnM3Vl?=
 =?utf-8?B?UmpOY2dpRmVNTFFjLzhLZnl3bzZRZE1ENmhCcXJpdzlrZFlWTGxlYkUyWC9G?=
 =?utf-8?B?OWlnOEV4V0MrTlMzZmhIemc5ZlB6M3F0NXNWVjNXUSsvMlJzQ01EZ3U5OU5i?=
 =?utf-8?B?bGRaT29CWU5UOGRBbzlUUzgrWUVocE8vWjF3N3BkRUo0MlRxS0FxdFlsY1Qy?=
 =?utf-8?B?Rk44N0hray9NbTYrRm5VQWFzdjFySlVwdDAxT3pMMGx2YWJTdmkyUUd4aHN5?=
 =?utf-8?B?cDdGZFI5VmhFZDRPa3lXSWtvS0QvcUUyckhhWEtXMVNnUFJjbXIyNmRtbWx0?=
 =?utf-8?B?bmd4b0pHNzI1U2VHcTVkMGE1WFZ0d0U4TlhLemlrb1I4ZG1sVmxjTkVWdWUy?=
 =?utf-8?B?Zjhxei8rWVR5aitaVGxrNnpYM0Z6cmdCYW94N0Jsa0FTUXVMeWtVUjVSZ1Vj?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F838833A4F9DE45B39E462079FFDCD8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3b0f53-5d91-4468-9757-08db70b0b7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 10:34:10.6515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CHenljx8i9rONCqVlKZoQy4YX3GSmptB7C7UmcPkWy9oa44JqqieSqPUvg4qp80rtja+EjOt2b5BRqTaPkY4XufJkmGi+0BIybxJ1YX1Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTE5IGF0IDEwOjMyICswMDAwLCBHcmVlbm1hbiwgR3JlZ29yeSB3cm90
ZToNCj4gT24gTW9uLCAyMDIzLTA2LTE5IGF0IDEzOjAwICswMzAwLCBEbWl0cnkgQW50aXBvdiB3
cm90ZToNCj4gPiBGaXggdGhlIGZvbGxvd2luZyBnY2MgMTMuMSB3YXJuaW5nIG9ic2VydmVkIHdp
dGggVz0xOg0KPiA+IA0KPiA+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZt
L3JzLmM6MjA3OjM5OiB3YXJuaW5nOg0KPiA+IOKAmGl3bF9yYXRlX21jc+KAmSBkZWZpbmVkIGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0KPiA+IA0KPiA+IFRoaXMgdGFi
bGUgaXMgYWN0dWFsbHkgdXNlZCBpbiAncnNfc3RhX2RiZ2ZzX3NjYWxlX3RhYmxlX3JlYWQoKScN
Cj4gPiBvbmx5IGlmIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTIGlzIGVuYWJsZWQuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgucnU+DQo+
ID4gLS0tDQo+ID4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2R2bS9ycy5j
IHwgNCArKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3Jz
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2R2bS9ycy5jDQo+ID4gaW5k
ZXggNjg3YzkwNmE5ZDcyLi5lY2FkNzQwM2VjOTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vcnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3JzLmMNCj4gPiBAQCAtMjAzLDYgKzIwMyw4IEBA
IHN0YXRpYyBjb25zdCB1MTYgZXhwZWN0ZWRfdHB0X21pbW8zXzQwTUh6WzRdW0lXTF9SQVRFX0NP
VU5UXSA9IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgezAsIDAsIDAsIDAsIDI3NywgMCwgNDc4LCA2
MjQsIDczNywgOTExLCAxMDI2LCAxMDcwLCAxMTA5fSwgLyogQUdHK1NHSSAqLw0KPiA+IMKgfTsN
Cj4gPiDCoA0KPiA+ICsjaWZkZWYgQ09ORklHX01BQzgwMjExX0RFQlVHRlMNCj4gPiArDQo+ID4g
wqAvKiBtYnBzLCBtY3MgKi8NCj4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgaXdsX3JhdGVfbWNz
X2luZm8gaXdsX3JhdGVfbWNzW0lXTF9SQVRFX0NPVU5UXSA9IHsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKge8KgICIxIiwgIkJQU0sgRFNTUyJ9LA0KPiA+IEBAIC0yMjAsNiArMjIyLDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpd2xfcmF0ZV9tY3NfaW5mbyBpd2xfcmF0ZV9tY3NbSVdMX1JBVEVfQ09V
TlRdID0gew0KPiA+IMKgwqDCoMKgwqDCoMKgwqB7ICI2MCIsICI2NFFBTSA1LzYifSwNCj4gPiDC
oH07DQo+ID4gwqANCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+IMKgI2RlZmluZSBNQ1NfSU5ERVhf
UEVSX1NUUkVBTcKgwqDCoCg4KQ0KPiA+IMKgDQo+ID4gwqBzdGF0aWMgdm9pZCByc19yYXRlX3Nj
YWxlX2NsZWFyX3dpbmRvdyhzdHJ1Y3QgaXdsX3JhdGVfc2NhbGVfZGF0YSAqd2luZG93KQ0KPiAN
Cj4gSm9oYW5uZXMsIGNvdWxkIHlvdSBwbGVhc2UgdGFrZSBpdCBkaXJlY3RseSB0byB3aXJlbGVz
cy1uZXh0PyBPciB5b3UgcHJlZmVyIG1lDQo+IHRvIHNlbmQgaXQgd2l0aCB0aGUgbmV4dCBzZXQg
b2YgaXdsd2lmaSBwYXRjaGVzPw0KPiANCj4gQWNrZWQtYnk6IEdyZWdvcnkgR3JlZW5tYW4gPGdy
ZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tPg0KDQpKdXN0IG5vdGljZWQgeW91ciBjb21tZW50cywg
c28gaWdub3JlIGl0Li4uDQo=
