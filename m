Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C106B70E3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 09:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCMIL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMILz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 04:11:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB41B758
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678695111; x=1710231111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CFMg8gnKDBvGwcqtWS9Freauz5p0DL68BnipZY/5EBw=;
  b=BpjOko7h2/uK8uSy0ZezSx4cHpeTB036ulxeT7QufcGDqrFGJbQLmarp
   FhaISLagNsyE/3ysa7Lb9jF9WUHpqonXLKGMu0pGkkmibaTo7M2wFL8nw
   QlLobn+v9JS0cn026gB5Ohakw0p//ADwdEllL/zdSUXkBX3PefNHOXPJU
   nctnVVzTGWIATDOYFJJpin31DLZHweLSypGP6fPcmeIDjEtu1Y3znsWFK
   xXBlpSp0fQ2ceGI4ZeaDcRSj2GyK+pvjMCP270XH5ZUofKFXHi6pkrrVp
   4gtTT1aQgc9V0LGuYi+E4Rl1Zu2yw5z5cgWTdQBTRPpNCvfrw2BIp0kop
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="325445300"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="325445300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 01:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="711037003"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="711037003"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2023 01:11:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 01:11:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 01:11:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 01:11:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 01:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlwE3iAVxKNflA2eqc0ZzjcpzuRcszMT8vY5rt8siz92qIJRylqDf4CeECfn4oYn4U9kEMp8F7aJiZ+ob2F+rUQ1SiTJhwwAZSXMRuQbuNPF+uOih+3VoAEqFZVu55WXCi8yYVOjCHyJ5XZdct/cj5H43vd0sn3G2YjJsVWddJkpWMCsH//5LANQPO9BVqMTU/DyxrT8KGtYvhooGJUPtZwSvS7k7IPLGW9QI2VvsIet7pSiGkFF3Do04WbAr3YMwJfui0Gk2anAKsl8cK2rc0uL4a4dRikxF3tRRYRY8/uYq4s2xPizHfOVK5LxAdkZZ1agKKt++5xbopubB/cqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFMg8gnKDBvGwcqtWS9Freauz5p0DL68BnipZY/5EBw=;
 b=kzZoMHGQozwMCST2E1fCpE9PPvfMlKyG+TW4vAieiSvKwOMlLLiWADtj4vYSe+frUsCGdlOWlluK5/xEBRJyGKncfFqfI4npKJc0fS3NHeVa48V2BTqCdUemCC6cnAGigNzRJZiYNC9qslGV8Qf1bPQh4x4WxYdLB4019yaBpMv/8z+yRqjKSiTKQNWdRQ+oslmJtyh6U+Ph0HjooD6rFGP3BNj4VCemzSMFQlpaFj6U8Emf6RcxrNoGseC/o8NCVjTVcEjIM/fg/U30rRQ4OOdSrRfLKWq7wteICj5La95wFw9Uh7tg8hJz2DVA8kX2YkAEtBKLejWBRU6r0OKUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 13 Mar
 2023 08:11:47 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:11:47 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: Re: pull request: iwlwifi firmware updates 2023-03-12
Thread-Topic: pull request: iwlwifi firmware updates 2023-03-12
Thread-Index: AQHZVSl767DbHG4i20e4eGzZCTpH9a74XJOA
Date:   Mon, 13 Mar 2023 08:11:47 +0000
Message-ID: <063f56ea520909cc5eee6d921c18edd63edfbf10.camel@intel.com>
References: <7bbfe98e9651fc962d3133ff70aa8bf92706f196.camel@intel.com>
In-Reply-To: <7bbfe98e9651fc962d3133ff70aa8bf92706f196.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH7PR11MB6428:EE_
x-ms-office365-filtering-correlation-id: 2c61f323-cb7b-43e2-55b4-08db239a9751
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLI7Tj7k92ia4JLro7Cj1EbUnKWKIDcBQnXuiasu6oLRD0e47+9i54dnDgGL+qqG9WY+lJ+Muh53neXe6Kt6yKmlDCxXmlHxmVlpXnmoQDrzDeBelf/skmr3f77ORk7KYiHuxsX9yIdjin1eVYYh01TNRZNf3gDVwKqNZR/p9O90sZPW5GphJ3970i0qC1qpkACqgZZ60TG0njCVRPvMWjy4BWyLhVjmzg59fjRBZJh3ELq3biQvDb7CKEPNboKdfIAZbjSsLHG96DxpCRmm4DagkILhq4rrfaiiI9W0e/sd+/8Vumi4k+C6w/v40SDD4k4MpN2BFBZA3swcveCSxa7LynuSfundOLALQYykORcJZ6hTMP2H7wgmkqjuUR/SGIywKvKPtkYLJFRtufXWr9QZ8sk4WESIIx0WFGtOmWHAdb7cNMfjTfcRWjJwDBpSwZlzS51RjTbwNtPDo9+xrMX58lMnUun/1XqpUpp+TZuoAxCsj3rkumlGIi74ACroYS0Y8nd2KumGRFgEXkZidmgd2031F9dRcyTRJ6xebmvtb+ws2tL2NgrBw+aw2g5YR1qKKHJVt1NCCMoUJpjxpFZQDvCDXAbdV3s2lWXhEew6CL+PCDSFoMq34m+wgo/hAZ4nLXfVBrl7srDTBM3M+dxDmsVHoFMcz83eWF5PfCWqw7CdQ3lAxj9pUPXaX0Mg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199018)(86362001)(36756003)(54906003)(966005)(6506007)(8676002)(38070700005)(26005)(2616005)(41300700001)(91956017)(4326008)(64756008)(15650500001)(316002)(66556008)(186003)(66446008)(6916009)(66946007)(8936002)(478600001)(5660300002)(6486002)(2906002)(66476007)(71200400001)(82960400001)(76116006)(122000001)(6512007)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUJTWFFpQjVEcDc0OWtRY01wa3BYOWc5VTBXeVlsY1JKWVo5K2VRa1UzRVMy?=
 =?utf-8?B?MCtYSG9xMFFnMFlmamVWUTdFTU9VTnFibWxyMXhlVE4yazFCUS9qTnNyV1Jw?=
 =?utf-8?B?azduY0dBekVOd0JEa2Y3eUtyb0pLM2JxOVBxTzAveUdEQnAzM2YxMFI0MnhL?=
 =?utf-8?B?M2psTTU0REMzTVJFS01xaU5waTREQ1cwZ3pKTE1mU0p0UUNzdytWcnpoT2ph?=
 =?utf-8?B?NGJZQkVQa3F3cHFWSzB5Q2IwQmFVWnJPU3FOSDArRWJiVmJKdHpwNGFGUGFs?=
 =?utf-8?B?K1FlY01XREE1SCtzeGNtYVozM2hrNTNUejM1VGN6Q2Zkem1sYVNQMjZvclhN?=
 =?utf-8?B?N0lVQVB3NlNqOHF6OHk0YjZVUWh1OUJjZ0VCV3lSWXNUQk5uZlA2d0ZUbVVz?=
 =?utf-8?B?V3p0ZWg3M2llT3NDRnpCZmVzQnEvckhHQ1NiTGtIdUEvTnhWSEtlemRabVBV?=
 =?utf-8?B?S2tNejh0NE1TZTJNejFjRUNGTVVqWGc2bXBOYlpGNE90djQxMUJyR3Z5cktH?=
 =?utf-8?B?alZXQWZXVGNJb3dONzhKRmplbWlwTkdILzFBRXpYb08vaTNxSWFNeitBTXNQ?=
 =?utf-8?B?blE0T2pDVG5qeGZ0OFlvMU1pM2JJOG1mYXRReFlVRTdadVFjckEwQUJPMTZF?=
 =?utf-8?B?aXVmMUF5RStWTjRtZEVkbnZkK2pIaTJyZXBidFRVYnpMamM2VjlSeGlWZ2tU?=
 =?utf-8?B?RW5qd0JuMjJiS1VYTjdxcFM0a1JoWWdrTlQwSFhtT3lLOW94WTUvdXJWbGdo?=
 =?utf-8?B?SUR2M29DQTlMTmlIN0RwUzhvbUthNFV1UGFLVURPUGhVcDZib0JiUTViTDQ2?=
 =?utf-8?B?KzBEUGJ6b1pudFU5UC9QMHZ0ZmdUcm1vdjNuS1dsMHJ5NWlUWG82ZmYreXFn?=
 =?utf-8?B?djNSUWJHNHJsekpkbFhGamdnQlhoOHkzSUx2Z2pSTmkyRURlY0JqSVAraDVB?=
 =?utf-8?B?anBjRWlaaWxLd0xBVlJoTDV2S20vQ1g3SWlGVG1uR0tPemdkNTFsMFZWQmJU?=
 =?utf-8?B?RjhLYUVtSEx4ZXhtcUp0SCtMTjZLY1luTTJ6S3ExNHJwVE95RWZMUk1VYm54?=
 =?utf-8?B?K1ZNT05iREwyVFJCWWRhbDdQRSsyS1VCUDdUbFZDVHdldHhLL096N2g4SC84?=
 =?utf-8?B?QXR2ampTU2dsNHZCYjRzRTN4bk1sNlFlZUNRZVZvZGRDSHhMVEZLMEp1dUls?=
 =?utf-8?B?TU9paVl5citEZTZmcmkzd3NhOFdVNmt4YW9oTGxLdFJMdzNnSjhjY3hPVVVm?=
 =?utf-8?B?MTB5OUpNRHJCRjBkMFJpL0pvME94TTBWbnNIQnNlVlkxSExhbFpDdHhJQnZK?=
 =?utf-8?B?RUxMcE9tRzgzcUxoTklaV1NPV0dvOWtucU9MR3BkbTNKQzdabGhSZ0dvb3Y3?=
 =?utf-8?B?M3lZMlVmeWE2aHY3VWlzbmFmRDZ3blp2Z3pFcFllNjY1eUdIRGlhTlBleTJt?=
 =?utf-8?B?M3VwVmZ2SDlhN3dWdTB4SGZjYVNkY1Qxd3JyVC81UTNHNW1zK0VKcERSSDBW?=
 =?utf-8?B?K2tDUXJ5dVJqclhvUTdMcXhPRVYwTXBJRi83ZlNGTWpPTDZvS0Rva3daVGNF?=
 =?utf-8?B?ZzAxZ0dDdnBoZktKU3RZVEl2dFdyc1dxZUhpRXJFUjhHL3VqNGVoVW9vRmpL?=
 =?utf-8?B?NkowVGF6Q3VuaFR5a1BiOUxRUlIyN1VxcnVPN1JSSjlzRFJHMkNrbmFaRnRu?=
 =?utf-8?B?aUVFS2gxNUU2TUI0ckRxSFlZZ1k1YTNvbllVL01VbWtVSFdxbHk0Zyt2S1VR?=
 =?utf-8?B?UDdTQ0JodGUyQVZ4RkFVN08rTUYvQkZyd3FOYmpCTTBERGFvZHBTbGduWmtI?=
 =?utf-8?B?Z1dZNzJuS0RUeCtZc29abGJMTXEzbjFqdmZqdnpZdlpzYW1KSm1Wc3RjeFhw?=
 =?utf-8?B?ek8yMUtxOTZBNUQwaDV5bFVzWTdRa3ZIZWh6ckF2b2FuRUY3Zi9UMUZsdm81?=
 =?utf-8?B?M2VodGNjcndGVVhWY3NOOVY4cWJvVjB4WEJKQzdOQ2dENUVuNmU4UmhOWCtO?=
 =?utf-8?B?ZnRQemRKWDl0L25nZWcxZGN5dG9TaFZ5U0FoMC90VWVKQ2pQUC9TNXYxRDdM?=
 =?utf-8?B?emVpbkZycXhXNkdtWElnemtydVZ3a0duMTZzRUsvT2pvbDBiTElxd1JzTmpp?=
 =?utf-8?B?V2pvYnhIT1pGbHlORkd3bk81TkdjYTBEdFpxNzNuN083NWxSajU2aEw5UmQw?=
 =?utf-8?Q?ZB/yKZoPB7C1+NUPH8cAVWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDF9E7861F92BB4F9BA5A7A49CED413F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c61f323-cb7b-43e2-55b4-08db239a9751
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 08:11:47.3370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpfxZ17IoMc0bb0XHYkmLNVYJwzeVACfGD202HWrmiLzdunLgAUPOfM7vjvccqawgYHQ3ohbGoeFd+XTH3rx/jlVXVt/nRf0zEC4Ek3uRUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
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

T24gU3VuLCAyMDIzLTAzLTEyIGF0IDIxOjI3ICswMDAwLCBHcmVlbm1hbiwgR3JlZ29yeSB3cm90
ZToNCj4gSGksDQo+IA0KPiBUaGlzIGNvbnRhaW5zIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBTbyBk
ZXZpY2UgZm9yIG91ciBjdXJyZW50bHkgbWFpbnRhaW5lZCBGVyBiaW5hcmllcy4NCj4gDQo+IFBs
ZWFzZSBwdWxsIG9yIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgaXNzdWVzLg0KPiANCj4g
VGhhbmtzLA0KPiBHcmVnb3J5DQo+IA0KPiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29t
bWl0IDU4OGRkMDcxMzRkYWY0YjBmNmY3NDY5OGYyNGVlYjc0ZWJlOTAwMTI6DQo+IA0KPiDCoCBx
YXQ6IHVwZGF0ZSBsaWNlbmNlIHRleHQgKDIwMjMtMDMtMTAgMDc6NDA6MjUgLTA1MDApDQo+IA0K
PiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCj4gDQo+IMKgIGh0dHA6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9saW51eC1m
aXJtd2FyZS5naXTCoHRhZ3MvaXdsd2lmaS1mdy0yMDIzLTAzLTEyDQo+IA0KPiBmb3IgeW91IHRv
IGZldGNoIGNoYW5nZXMgdXAgdG8gYjQ1OGJlYWFiMjVhZTZjYzdhNjBkZjY2OTI2NzY4YmMyMDkw
MjNhMzoNCj4gDQo+IMKgIGl3bHdpZmk6IHVwZGF0ZSBjb3JlNjkgYW5kIGNvcmU3MiBmaXJtd2Fy
ZXMgZm9yIFNvIGRldmljZSAoMjAyMy0wMy0xMiAyMzoxNjo1MyArMDIwMCkNCj4gDQo+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gRmlybXdhcmUgZml4ZXMgZm9yIGNvcmU2OSBhbmQgY29yZTcyDQo+IA0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+IEdyZWdvcnkgR3JlZW5tYW4gKDEpOg0KPiDCoMKgwqDCoMKgIGl3bHdpZmk6IHVwZGF0ZSBj
b3JlNjkgYW5kIGNvcmU3MiBmaXJtd2FyZXMgZm9yIFNvIGRldmljZQ0KPiANCj4gwqBXSEVOQ0XC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKysr
LS0tDQo+IMKgaXdsd2lmaS1zby1hMC1nZi1hMC03Mi51Y29kZcKgIHwgQmluIDE1NjA1MzIgLT4g
MTU2MDUzMiBieXRlcw0KPiDCoGl3bHdpZmktc28tYTAtZ2Y0LWEwLTcyLnVjb2RlIHwgQmluIDE1
ODA5MDAgLT4gMTU4MDkwMCBieXRlcw0KPiDCoGl3bHdpZmktc28tYTAtZ2Y0LWEwLTc0LnVjb2Rl
IHwgQmluIDE2MDIwNjggLT4gMTYwMjA2OCBieXRlcw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCg0KUGxlYXNlIGlnbm9yZSB0aGlzIHB1
bGwgcmVxdWVzdCwgb25lIGZpbGUgd2FzIG1pc3NlZC4NClNlbmRpbmcgYSBuZXcgb25lLg0KU29y
cnkgZm9yIHRoZSBjb25mdXNpb24uDQo=
