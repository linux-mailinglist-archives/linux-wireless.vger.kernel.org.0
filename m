Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABEA71A391
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjFAQBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjFAQBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 12:01:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C9913D;
        Thu,  1 Jun 2023 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685635264; x=1717171264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QL1vLYhQbsUL2iEpwkb4bGxWyKiAWelJnN+WqX9u/M4=;
  b=Zu/4hOLB/ko/2+aHB20Euq8SRJ8RM0FdQILaALPKaXQzZsWioWMMQ2Vf
   lbuY67F3p+9OHun6++j8ZpX7encoiw/w3cWmZQd4dz2IJhqpocoAuC8/H
   VjLkwtcxyNBtDsJgdmEwOUjk5nhYAUey7Y3mh8XuGjUjpZvmR6S2t0mSV
   ab9pfh1byk6k7bURwhS9dnad7+4fSxHEWgHT8C90Wc+eLEe5bD4MnlJNB
   X7qQFhbQM2jg6uKyq4qYv1sH61NdsZn964XsnBoXqHKIejv+6OYmRcwot
   agpggcC5yB8hxgBsc5Jia/L9Zhr6jLkdK5BJ0TojbAmbLbU2tIAYCzI6E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340219323"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="340219323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="797200543"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="797200543"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2023 09:00:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 09:00:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 09:00:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 09:00:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 09:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRcLpNNIwneOOC9R7ZZBHIY0y0gKH3JMfHNLoW/dwsEI7Zxo5fIMr8UqgFYhnd1OZeftUgJiMu0n05OBzgdOPfvqXD24kFWrrSO88Hy2jfKD+7rjKVRqgQPtOM72S2KD6gk8LA4z3Pq5ACusGlMarKdfjOA/OtXHaily5sNrhPZQjFDYpBOOr9rloLFRI1QqlPk8ceZr9uy+e5yHeiH6EJymS3n6eWWZ511vhaWr9kcsxrh0R2cglP9fPvFufA9SCISgGnvkeel0VtGIVzjOQ3lncF3r/xV+W0Clu46s+zIldguIxBIk4uIcAUS9SiBKIuS0ajuFprxgAbwzfTpaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL1vLYhQbsUL2iEpwkb4bGxWyKiAWelJnN+WqX9u/M4=;
 b=S18SsxfkSli2kcwX0wvdTd6zrcSylDphqfu++FqtE7H16+V8hRnw3xLDBUky9cTey9N6ccu3+3iNAvoy+1EFP17qVFRvPku0FuJgMd7/DvugnLkjk2QBle06L86eKRzmFExfkPkRkgAekSSdGbdWRI5rtu8AvP2O68AGNgPanw/vsWRkiTDKgSPjJgk5SVmGrPL9GFNdRBj0Lgakh3sQbuDaO42lnln7lmmWQFLfx8vTn+4GPnYZDIVd0vz7vp0tXNIKhq7tNCLBMoAtNVa5or2UFNrdfNpuoZUXJM3DxZAVeY06hR/NixAykODo4cyub+lK6PYoo+B26iTgEofYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 16:00:34 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::a549:be63:2844:ca7e]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::a549:be63:2844:ca7e%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 16:00:34 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "inux-kernel@vger.kernel.org" <inux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: bump FW API to 78 for AX devices
Thread-Topic: [PATCH] wifi: iwlwifi: bump FW API to 78 for AX devices
Thread-Index: AQHZlJYGjAuFrX9qtE24y1vglk8tpq92GzYA
Date:   Thu, 1 Jun 2023 16:00:34 +0000
Message-ID: <1ee34c4b93dc0acb5bd51556ce5f60062b78f970.camel@intel.com>
References: <f7e417e0-5277-4085-bb50-fb43bdc52f7a@roeck-us.net>
In-Reply-To: <f7e417e0-5277-4085-bb50-fb43bdc52f7a@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA0PR11MB4701:EE_
x-ms-office365-filtering-correlation-id: 906e1d7c-8b73-4211-8ef8-08db62b9558d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 031qkKcAXBAmrkvSak2kdEQECxU5eMDAW0waFWxy6qPXeGVLpa0ID+as1JI+BnrLhrKeLz+ObAJieWl100M7KComMd8clDCTb/+1J1zQt6Tq+UX8r9FZ+KIELYV4uKJBsvV3fEXBIYubX7sQp1dN0K7YvTJ7r/k4l2y4pGlwgchAyoldD2X2iIT5I38yqldiia6e4ve1xNUfvX9/wm8b3y/c3xAyaAxZvpukEu+PC/OHjmhJ9FyXkisJV16X7hpAgDW/HNM7Vhqcnk3HkI+SzmqcfiFutj0V3GPR8ShDLGi1+0zHbLHsxVbz288Ovcv+lY40A7OGbL4r0zADt1I1+r2hEDquYwD0bm1wojEWtVZ4+vf6pwI30I0l0k7zlEq89RTpz1iKvKEH6Uuh1uC8cc2gYv9rBwkjPtA6eXCvwfQPFyDXFpm0BPF1mnsZL8vABxF/AoVWWrzX7POuDX3IE5M2a1b2mjuljiK/bTdpDy4I5r9HOMHYunJhtJgV4zM8TjH/mgstU65nHLUZrmxXvAGDsE0DARhArZhfkFHRH2EHeZqMZoeVKNcEqD4Z4w9ZJRxPGjfkh/xXUbK06fdEZbIuEk9oWfR+gLMD0AasHr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(54906003)(82960400001)(122000001)(38100700002)(76116006)(64756008)(66476007)(66556008)(66446008)(91956017)(6486002)(478600001)(41300700001)(966005)(8676002)(8936002)(5660300002)(86362001)(71200400001)(26005)(66946007)(2906002)(6506007)(6512007)(186003)(6916009)(316002)(4326008)(83380400001)(38070700005)(2616005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUlqVG0yK3lFbTExKytma3VsM1dPZzNXb25nR2RYeWFZNE5uczhnRVhHczd3?=
 =?utf-8?B?WWdoYzZXRjdrQWlwNVRHYUpEeWxUNnByWGVQWXo3UU80REZCR0JYeGh6dEVD?=
 =?utf-8?B?c20xc1RsME5JcTg0dVNVRzFuem1jZ21yellXQWk1Z0ZCMW0wYVhMeTlGaDVv?=
 =?utf-8?B?QS9oTGlmL2JKdzhyMW9aYno5RVU5ZXM1MHRWMXlKK0EzSnV3S0Rlc3dzTVpH?=
 =?utf-8?B?YjlETFQ0T1pXR0R1M3Z5THl1VGFDTHdqQml6S1FIc0JpRnIxb0RFZWp0UTNy?=
 =?utf-8?B?NktKNURCYjVYUGh0ZFo3d0F4MHFYRHRvMlN4bEQyOXAzbWdOUmxZSzVUTzI1?=
 =?utf-8?B?bWhYMEpTc2F4NzdUNmpYOUFmc1NONmpRRHBqQzNyRTJpYlVXbTVuWkxGNXh0?=
 =?utf-8?B?WEJxbDVaWVBzVm9kRGtsYmZKeGVmZURQNmJoakhoOFFZbzE2N1Z5SENrTzF2?=
 =?utf-8?B?WTEyalN4UU9yOEY2TFBpV0ZRSHlMQ21JcDdZT2VIOFZxSXl0cSt5Sk1QZjVE?=
 =?utf-8?B?RXF0Q2RtT1AzQUU5RE1KditTcE9XNEd6RVA2T0dDOTd2WGF3OWRXcWcyYWF1?=
 =?utf-8?B?NU4yNWpKWjJ1LzRGYjkycDljeGpDUlY3bEVlYldrT3JKcEZhczc4ZUM2TTVB?=
 =?utf-8?B?Y2Q4RHozSTVESXFXRWRhQ1M2aG1xM3ZvTGoyVklPREZUTXNHTGRNMnFuQlBC?=
 =?utf-8?B?Q3o4ME1Banc1bm42QytnQXllQjczb2gwWXBpMGtYd1k3cndqV0JiMHlIalVD?=
 =?utf-8?B?M3EzazN2amtBMXh2TXg5T1ZpbzRFT3NLNXByMkx6Z3Zmb0pkUzN0QTM0MXZU?=
 =?utf-8?B?VS85SWpPNUdQYWhTdVYyVnRETTNTdDZ5TXZYVlcva2FNSkFDaWxudS9INHZi?=
 =?utf-8?B?WFpSMUtVTkorMy8vRjk5Q3dxNXRId0g1Y0xCUjQ5ME1IcmN5TUNrSmJkUWV3?=
 =?utf-8?B?akV3OStlbWNzRUIzTWNKbDVScXJ3MTB4MWxVbUUxencyUk5PSFc1blNmV0Vo?=
 =?utf-8?B?MmVFc1d0YWlFbThQM21tbTBRcHdHYmlLR1BNakVJZi83SmdkbHRHaUJiS3VB?=
 =?utf-8?B?MVdPMnhwTUxxcnFuUSt3RTdSMVRib0dyYzkyZ2tPd1ZBWFpiVmZES0x6WDNU?=
 =?utf-8?B?REVzYlBsTlNBd1BVYUFiTXlYZ045L1ZzSlJLcnFoQXcwcG1wUi8zTXBiNzBP?=
 =?utf-8?B?TlRVb05PQUNTRzArM2VOTklTSkVINVFNb3RlSGhGU2o1VVJPUjdLK0s4eC9S?=
 =?utf-8?B?Z2Nrb25EMVlrNEJoMmtxd2RVeEpUZS8rbVQ4Rm1DcWlUM2pWQjdNU3RJdGlt?=
 =?utf-8?B?a0UwV3J4ajRkbEJmNHErYXlSV2haN2pUM3JoUndSaFJyM0EybUxUbERrcHVV?=
 =?utf-8?B?blVsN1RsUEtKelNnNEp5RHhuQ2d0alRaL3dIUWQ3LzJpV2JKaHVOM0NpZElh?=
 =?utf-8?B?RDg3YTdYcGtUcWdVNEw3b0MrbStNeVJpNmowNHdXQ2VVV2ZkV1c4cTEzbkRE?=
 =?utf-8?B?dW5vRk0wSm12TTArVEhmczNGNk5RUWdqdW9NaGkxbituRVNaQXJIV2F6d0F2?=
 =?utf-8?B?RTBqaEMxVkpqZnU3RVlXRnJ0WnpheEpzNzFSQWFTZUxGbnpWZnlScmFoS3Fv?=
 =?utf-8?B?b3R3V0xyV2ZpYU9nemZydGEzSmtzTHpoRWdtQ25vdTFOR0pEWUZacGRPMFRD?=
 =?utf-8?B?Rk1oTzZBTW1xQnVJZEtIUC9ZK1E0QXRKZWZKN0IxdWxmdVp0QmU4c0VRcnlt?=
 =?utf-8?B?cGNNcFM4RFIzY2ErYmJ5cEpPRThKbGxSVmw3Yzl0QitpYWM2akh1THRhbThS?=
 =?utf-8?B?K3RJdFNOSytodzN1YTVUK1E3V0t1YUNmWDNYTHBSc3Jra1BncHNSRytBZnBO?=
 =?utf-8?B?WG5tYjlwN0htbWEwSFR3bjAvTEdLV3ZVTDlTZWZ5NUhLODVVRStOTGZVRHd2?=
 =?utf-8?B?bkNDUHlTSzlnK2Q5amg0d1ltRnFRRlV5ZkVGUjZRZnVENHRqQ3l4bU83Q1c2?=
 =?utf-8?B?dXpMUkJBR2tUVjZuNC9BeFBZU29oTmwzVFplSHlGa2l6alRKT3Y2YXhPb3dO?=
 =?utf-8?B?WnJtdk5Xc1BvZTVaTnNrTGJKUEVjL1cyUCtValFZWmJ1akthNWY5aG9CUWxm?=
 =?utf-8?B?amFPcy9zTGRvVlREaWhiSzRIVU1rZDBEaFNNREtCOEFoSEN1NDFqMVF2ZXF1?=
 =?utf-8?Q?b5vJ0Wqu6j1TJLTELXl7wpU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18E1A8C95FF14147BBC38B8A49FEAF74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906e1d7c-8b73-4211-8ef8-08db62b9558d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 16:00:34.6695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAUwoIgKKPGgbEtjcAh1eOD4biOp96mu8+zTdKwpNAWZYx+rA/sf/xxt9WCz75XZ9j67WGqkphqLpkmgVs+oBoF3Ho5mawnHcY/wO8seRHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk9uIFRodSwgMjAyMy0wNi0wMSBhdCAwNzozMyAtMDcwMCwgR3VlbnRlciBSb2VjayB3
cm90ZToNCj4gSGksDQo+IA0KPiBPbiBNb24sIEFwciAxNywgMjAyMyBhdCAxMTo0MTozNEFNICsw
MzAwLCBHcmVnb3J5IEdyZWVubWFuIHdyb3RlOg0KPiA+IFN0YXJ0IHN1cHBvcnRpbmcgQVBJIHZl
cnNpb24gNzggZm9yIEFYIGRldmljZXMuDQo+ID4gDQo+IA0KPiBUaGlzIHBhdGNoIHNldHMgdGhl
IHVjb2RlIHZlcnNpb24gZm9yIGEgbGFyZ2UgbnVtYmVyIG9mIGRldmljZXMNCj4gdG8gNzgsIGJ1
dCB1Y29kZSB2ZXJzaW9uIDc4IGlzIG5vdCBhdmFpbGFibGUgZm9yIG1hbnkgb2YgdGhvc2UNCj4g
aW4gbGludXgtZmlybXdhcmUuIEl0IHNlZW1zIHRoYXQgLjc4IHdhcyBza2lwcGVkIGZvciBzb21l
IGRldmljZXMNCj4gaW4gbGludXgtZmlybXdhcmUsIGFuZCB0aGUgbGFzdCB2ZXJzaW9uIGZvciBz
ZXZlcmFsIG90aGVycyBpcyAuNzcuDQo+IA0KPiBUaGlzIGNhdXNlcyBwcm9ibGVtcyB3aGVuIHRy
eWluZyB0byB2YWxpZGF0ZSBpZiB0aGUgZmlybXdhcmUNCj4gbGlzdGVkIGluIE1PRFVMRV9GSVJN
V0FSRSBhY3R1YWxseSBleGlzdHMuDQo+IA0KPiBJcyB0aGUgbWlzc2luZyBmaXJtd2FyZSBnb2lu
ZyB0byBiZSBhdmFpbGFibGUgYXQgc29tZSBwb2ludCwNCj4gaXMgdGhlcmUgYSBwbGFuIHRvIGZp
eCB0aGUgY29kZSB0byBvbmx5IGxpc3QgYWN0dWFsbHkgYXZhaWxhYmxlDQo+IGZpcm13YXJlLCBv
ciBpcyBpdCBhIHdyb25nIGFzc3VtcHRpb24gdG8gZXhwZWN0IHRoYXQgdGhlDQo+IGZpcm13YXJl
IGxpc3RlZCBpbiB0aGUga2VybmVsIGFjdHVhbGx5IGV4aXN0cyA/DQo+IA0KPiBUaGFua3MsDQo+
IEd1ZW50ZXINCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29y
eS5ncmVlbm1hbkBpbnRlbC5jb20+DQo+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDIzMDQxNzExMzY0OC41YTRkY2JmNWEyYzEuSTEyNTgwODU2NmZlODkyZWUwODY1ZTM5MmJm
MWIxODcyZGFhZmU4YWRAY2hhbmdlaWQNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBCZXJn
IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnLzIyMDAwLmMgfCAyICstDQo+ID4gwqAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvMjIwMDAuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnLzIyMDAwLmMNCj4gPiBpbmRleCBiOThm
MGZmMDIzNjIuLjUzMmQxNGY2MTI1MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2NmZy8yMjAwMC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvMjIwMDAuYw0KPiA+IEBAIC0xMCw3ICsxMCw3IEBADQo+
ID4gwqAjaW5jbHVkZSAiZncvYXBpL3R4cS5oIg0KPiA+IMKgDQo+ID4gwqAvKiBIaWdoZXN0IGZp
cm13YXJlIEFQSSB2ZXJzaW9uIHN1cHBvcnRlZCAqLw0KPiA+IC0jZGVmaW5lIElXTF8yMjAwMF9V
Q09ERV9BUElfTUFYwqDCoMKgwqDCoMKgwqDCoDc3DQo+ID4gKyNkZWZpbmUgSVdMXzIyMDAwX1VD
T0RFX0FQSV9NQVjCoMKgwqDCoMKgwqDCoMKgNzgNCj4gPiDCoA0KPiA+IMKgLyogTG93ZXN0IGZp
cm13YXJlIEFQSSB2ZXJzaW9uIHN1cHBvcnRlZCAqLw0KPiA+IMKgI2RlZmluZSBJV0xfMjIwMDBf
VUNPREVfQVBJX01JTsKgwqDCoMKgwqDCoMKgwqAzOQ0KPiA+IC0tIA0KPiA+IDIuMzkuMg0KDQpZ
ZXMsIEknbGwgc2VuZCBpdCBqdXN0IGluIGNvdXBsZSBvZiBkYXlzLg0KDQo=
