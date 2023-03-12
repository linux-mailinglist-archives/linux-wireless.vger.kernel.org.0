Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B336B643F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Mar 2023 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCLJrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Mar 2023 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLJrR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Mar 2023 05:47:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823684FF1F
        for <linux-wireless@vger.kernel.org>; Sun, 12 Mar 2023 01:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678614436; x=1710150436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g+mmSh4TAEoF7YA0yN8JqFfZYFLVrHlCsCdRNlq8nbs=;
  b=kkv0zK76HLe6TY+tewb3Gp42TGgfDG2H9yyJwlE9IMfg9skl34fCZycg
   vqwOoLt0FeVN3RMeYuCvVFk4xcdpqNtmWq82yqHXhSc8/raBIGCCZKesx
   CYXMimM3O8rb48mJJPIZxZyLuqZpUC/m2PcJC37Mu/2wAA3djCiijNSKr
   2lyfZDLcOX27cE6WAspiLwbu6OKwp7PIAZ83iFWORd+3N+bDrArBt0qjW
   vC6yJE0LAPj432zwpIf44dgAQSd96g48r7fdP+11joVsIe6FX11VMOoaS
   ofG5zVHJDlgOZdl4rQv0VeXcsOGqtNEEO5iwoN3MmZoGrJIKyaSXeeNft
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="423243149"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="423243149"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 01:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="671561029"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="671561029"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2023 01:47:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 01:47:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 01:47:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 01:47:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 01:47:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhlU18ImhFXZQyvSWZZzFlC5DoN9yTieG+dJ+h1MqR2K9hKBpCsoNWk/ijQRnvLKpEpZ/nkPlZsLns0kwGMjvlwicKpwlw6mRR6k+eHcJqJod6Tv/55Je072qSFGDWO8JbhjiPU4SqXMvVqfM1V/Z8eHBu8tBz5iEWTNSzeGJ9PBs+yzQv6TnqfY0j/bQ40r8dncnosSn25a2hJroqNnamOh8E6NX+/zZLXDHnZQymVIqzWE0dOVVnkwZ/BnL4wVw5sakMGmeDfDkJYiXcGnObWLbsWJGLI69AibLVWiajBWUfo+1FmiKaVfdzi58Al9JSiWN7TuZQ1ooISjWoY1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+mmSh4TAEoF7YA0yN8JqFfZYFLVrHlCsCdRNlq8nbs=;
 b=LU5ziBUUwAeiTuNWx4Cn7TKORbSTzT+OQLLT7ziQcMb5yl0cm7ipmBivoi6qmc2yhAN20Dnum6IXOFOPlwYcv1iwVZp7PW2QfZLZh3aEHWjXIQ79pgPI09bxy5bZydGJf/he+Vm0XzC7alAQJ7NeLkO0E0euNR+ynLdaW85mkQqqglE9rOcwLzloVWVH5TDiCsaw5qdu40/R8TnAHfn7bLWsDBU1iz8UwaPPWUuPT6PesX3Mu61lsgfjxiTs6alryTOOHuBw2WBu8vNASeMEG3BjFCdT5jhPb9rmRmbPrYl/KZb+am5nRHkXOl26WhIW2XGcapluF3aW2Jga/Xl55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sun, 12 Mar
 2023 09:47:08 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330%6]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 09:47:07 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "aiden.leong@aibsd.com" <aiden.leong@aibsd.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v3] wifi: iwlwifi: pcie: fix the order of scanning
 iwl_dev_info_table
Thread-Topic: [PATCH v3] wifi: iwlwifi: pcie: fix the order of scanning
 iwl_dev_info_table
Thread-Index: AQHZLC+CidTP1/CGsUWqrz0Jf5wOia7D31MAgAA6uwCAL6vVgIADcPQA
Date:   Sun, 12 Mar 2023 09:47:07 +0000
Message-ID: <41704272e91ede88e49a61d7943d4e1c6c88e9c4.camel@intel.com>
References: <20230119175657.9205-1-aiden.leong@aibsd.com>
         <51e9eeb2cd84f0f8ff92981b47a8e77e11047847.camel@intel.com>
         <5815091.MhkbZ0Pkbq@eq59> <4811051.31r3eYUQgx@eq59>
In-Reply-To: <4811051.31r3eYUQgx@eq59>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH0PR11MB8236:EE_
x-ms-office365-filtering-correlation-id: 81b556fa-0e69-4acc-e6d6-08db22debe70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3elozrTxXrpVY2wa9+kW89ACXxDU0E76v3kJDraRPA3cxwckMRqMHplAo0DIUu4M0BBJX53mXqSP/E1SQiDcDzG82p5WA/cFEXzkiJPpQxzkO7WpRSO+QccPmO6mRrbbuHPvQtwMeE8RTS1SMY+sDpuNiS/Llc1Dn2YJzcaCJwdpC0IZb5b93OdnUOeONDUgP8XaYXI99Ucfo6qdirB6ATKx+XTmmdX674SdUgWhk0wSVNC0Uqmc6m44jtozXxO5/V0+HNTndu0vZcBVWc86gQX/WbsQifmZzGcwjyXbxY6YCjZpZdpywqJ63SwOQqSroMGefUT+YdZeJdV2Wmhuc/aJazuQqWoHLw0vKeJnOTLINtacTvWpJnUhM9UNP3jlfj4H1ozvEvwHnNi4DscKNi1sAQ8RgQOFpzrSN3MIiVezuXvJ8VDRILMpL8UvKVf45RK/jO1WxeQ6IIgcosyjLfZfyiJoESqIXnklmY00PtQo8AHaQIbJttjvlE5hPv9BKMCSD7++KRRFGy/0qInGqOkfFuauQdJYG5NqRnwaN19HwdXc/MT5lqDuWsc+sg/2jegGOZx42MFxYY1QiGtm5jQSNgQqUM8Gh/DR2d9GWY+559qwwcUynweKWUwBulfcxUDkU0SrDpCKM+xq2ostIMPtb9lveq+QLVwG/q0JPPiRMhl3+AjBkG79PeMzSJ7KmoyD2Eb3Gt5s/szSBzjYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199018)(54906003)(110136005)(186003)(26005)(6512007)(53546011)(6506007)(38070700005)(6486002)(5660300002)(478600001)(71200400001)(36756003)(8936002)(86362001)(2906002)(4326008)(2616005)(91956017)(66446008)(64756008)(83380400001)(76116006)(66476007)(66946007)(66556008)(8676002)(316002)(82960400001)(41300700001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjBwS2VMV296UU9tMEVNTVNYUnYxaFVzVXhvRG5mcTNjZkNWanJFeWNIVllx?=
 =?utf-8?B?MXRwdUNlTGV6WjZWbUlPWlU0UURjMkR1TXRJUXRSMStDYzB3bU5iZGt2VVcw?=
 =?utf-8?B?UVJwOXBUSHBLdDlYR3B4ZXF6dHkwZDhsK1VBWEFveUp4WkZ1OGMzYWZrVjFl?=
 =?utf-8?B?MUFhSXRFSFl4LzJHekpiYmU2ZTR4dGY5aTRMRWc2Wit6VzNvYlhqNlAwdFg2?=
 =?utf-8?B?ZjhNY0NTMXhuWFVnR2NIK3ZDWlB1SmFrVFV1cmZoUVhLSXV2TldFb2FRdFZq?=
 =?utf-8?B?RDc2bUtlT2dNN1g0dVYrVkNranJvUS9tdTFEbzZTVmkzMjZsZzJ6MnZ6WDJN?=
 =?utf-8?B?Tk91dEg2c20zWlhUY0VxMjFVdWxaZ255djk0bTRVMEp4UzZleGRxNDFXM2tJ?=
 =?utf-8?B?VUdkd2lFbjZFOXFkODQvWmpnV2NQSm5JMHVPcUQ5Nk01VGdGcWFYWEp6K2FZ?=
 =?utf-8?B?VHNjekpBTzVkc0x0Qnd6OS90WUF0UmNSU2o2WmR6MVpnNGRaT1dxZElWSWpw?=
 =?utf-8?B?UzZrc2hVR3J4ckl3T2YvUUhGUktEZVR3cEVXOWg4dW1oMEFXUkpVb0lkc2wx?=
 =?utf-8?B?MlVybkNuMG91OVphL24rSnYzczNxV0owOGtkN084c2E0Q1MzL3ZQZklWRDJa?=
 =?utf-8?B?bndLVzQwNXhQTUt4UXpwd1BPZ0hTa3pCNURBSHBqUWM1REJFdkV3d3M2WUVO?=
 =?utf-8?B?cmdEZ21DdVRCKytXUmdHRVVVaGJYZm5VS1dBRlR1cTc0VjVja280ajJRMGMv?=
 =?utf-8?B?NFQ2VEI2blF2SUF2QndsdlN2THUvVXZpVWUrcEF3cHJXS2dLVlJ5V3o4TXZn?=
 =?utf-8?B?OE9PaGw5Yk1sSUthMFR1ekRMVm1lcnlOaDhBOGdnaDEvRi91TTFZSGVhUWdX?=
 =?utf-8?B?Tk1NaWk5eG1sVFFqSU1Jbm5NbE96VkhaUDlYSDhhZno4aS8yc1BXT0tlWmdX?=
 =?utf-8?B?VTI5U2NWclIzUW1TRlFaemc2ZHlyalNWc1RPdldHcmpFZXd0eW9PS2h6YS9o?=
 =?utf-8?B?cGtwVHpMNUNncGVwV295ODdDKzRsOG02eXlFRTdjMVlpeTVPUDZWV0FaOEcr?=
 =?utf-8?B?OUZObWNwS21WV1YvVmFoYzB2SFlSQVdLck5oT3k0UENLc2xiUlA1akEycGJV?=
 =?utf-8?B?VGk4aVQ0NHpUQU1rQjh3Yk1NTUt6Ulg5NitYM1lkZElSTFFxNU4wTEFjVVVE?=
 =?utf-8?B?OCtHempiUEx3YXlkN0gwWEdSVmJGbE1ZZlZueVJ1U2xDRk0zNzlXMUFtaFFt?=
 =?utf-8?B?b1F2emx2d3Q5b20wR1dzWE5vcGR3U0R6OUlVaDM1M21WMHFzcXhYQ0tycU5s?=
 =?utf-8?B?TGlrMVRvMUwwdlhTaGEwM0Q3MzVkeXRkaFl1aTFWNkZlVGdPeWJzcG9kZkox?=
 =?utf-8?B?eG43TUdrdU9pVXRJdFJMRDl1cWwzbStKaDVNOXEvZk05TmtoU0xqSWdTYlV5?=
 =?utf-8?B?MU9SMjZPUnlyUytFVHd5VFduOEV1ZU9JQnM4YTd5a3dNaXB6dFNtLysxRmNE?=
 =?utf-8?B?T3Z4cnRIYUE2aFc3MzZOaWpKN2FnK2hzcXJWQW14T3NRMklQNG1vdTNmbUxR?=
 =?utf-8?B?YVAvcFBuOGNXWWtMVTM2d2k2Wk0rNnl5K21vVWlQOFkrWnpIR1NOY2p4Y01u?=
 =?utf-8?B?RXdET0dvWjRkRmQ1ZzMzNCt1MXZnKzNWRjFtN2xrRnR0K1FYNWRaK3FVWmYy?=
 =?utf-8?B?K3N2ZzZGUnRNZHZLdG9EK2x4Y0hTdzlpMXMyTFZyUWNLejZxcmRjV2dtN2hO?=
 =?utf-8?B?dXdMQnVwMVc5ckVGaHdDRHhocnRzdk9yaXczVGpUaXB4M2xGWS8xRUsyMUZ0?=
 =?utf-8?B?dXVHOHFOWHlGbWl6VUpnTHp2bTZKMU5NN0MxU2U0TVdrWHVNc2NEOGsxRDVi?=
 =?utf-8?B?ZWRZbGZYQ2I4cVN5aU1CM2tSMXlRZVlSR3R1d2UyMDRUTW5UWGptVlNGRUVJ?=
 =?utf-8?B?V2JwQkZSbWo2dVBLQlZmRUF6enNzSVFFbEhWWEpkZ3N6cDNydjkxMVhQU3ds?=
 =?utf-8?B?UE03akVJcXQ1NmFyU1ZnN1A2Zk9MVUhIdm95U3h0K0lIK0NCN1h5dDY2d2dX?=
 =?utf-8?B?TzNQa0VTUW9zeGxhcXo4MnNIb1dVRklpQ3lkZ29od3l6d2ZBV3hJRWpTNGVI?=
 =?utf-8?B?SGNETWorL2k0dHhLZUlVakNya0FjOHFDZFhTTDl6NythM29aOFZTN3ViWnYv?=
 =?utf-8?Q?64eVYN+WmFdZj4stQAe9eVg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E03E59C346F34F45A883DD30B50774C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b556fa-0e69-4acc-e6d6-08db22debe70
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 09:47:07.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPH4jEYQm4fPWJBpNjELpezZ6rsb9PVLaNj0i6oy9pdA5X84ft87r5zmxlI7uyvABD4oayfSDnHmgu09pP70YGPvmmE7AdxHIzkh9Baiils=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDEzOjE0ICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToNCj4g
T24gV2VkbmVzZGF5LCBGZWJydWFyeSA4LCAyMDIzIDU6MTQ6NTAgQU0gQ1NUIEFpZGVuIExlb25n
IHdyb3RlOg0KPiA+IE9uIFdlZG5lc2RheSwgRmVicnVhcnkgOCwgMjAyMyAxOjQ0OjM5IEFNIENT
VCBHcmVlbm1hbiwgR3JlZ29yeSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMjAyMy0wMS0yMCBhdCAw
MTo1NiArMDgwMCwgQWlkZW4gTGVvbmcgd3JvdGU6DQo+ID4gPiA+IEZpeCBhIGJ1ZyBpbnRyb2R1
Y2VkIGJ5Og0KPiA+ID4gPiBjb21taXQgMzJlZDEwMWFhMTQwICgiaXdsd2lmaTogY29udmVydCBh
bGwgUXUgd2l0aCBKZiBkZXZpY2VzIHRvIHRoZSBuZXcNCj4gPiA+ID4gDQo+ID4gPiA+IMKgY29u
ZmlnIHRhYmxlIiksIHNvIG5vdyB3ZSBwaWNrIHRoZSBGSVJTVCBtYXRjaGluZyBjb25maWcuDQo+
ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBaWRlbiBMZW9uZyA8YWlkZW4ubGVvbmdA
YWlic2QuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gDQo+ID4gPiA+IMKgZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jIHwgMiArLQ0KPiA+ID4gPiDCoDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9k
cnYuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9k
cnYuYw0KPiA+IA0KPiA+IMKgaW5kZXgNCj4gPiANCj4gPiA+ID4gOTk3NjhkNmE2MDMyLi4wNTc2
NGVlZjE1YTcgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvcGNpZS9kcnYuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMNCj4gPiA+ID4gQEAgLTE0NTYsNyArMTQ1Niw3IEBAIGl3
bF9wY2lfZmluZF9kZXZfaW5mbyh1MTYgZGV2aWNlLCB1MTYNCj4gPiA+ID4gc3Vic3lzdGVtX2Rl
dmljZSwNCj4gPiANCj4gPiDCoGlmICghbnVtX2RldmljZXMpDQo+ID4gDQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4gPiA+ID4gDQo+ID4gPiA+
IC3CoMKgwqDCoMKgwqAgZm9yIChpID0gbnVtX2RldmljZXMgLSAxOyBpID49IDA7IGktLSkgew0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBudW1fZGV2aWNlczsgaSsrKSB7
DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qg
c3RydWN0IGl3bF9kZXZfaW5mbyAqZGV2X2luZm8gPQ0KPiA+ID4gPiANCj4gPiA+ID4gJml3bF9k
ZXZfaW5mb190YWJsZVtpXTsNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoZGV2X2luZm8tPmRldmljZSAhPSAodTE2KUlXTF9DRkdfQU5ZICYmDQo+
ID4gPiANCj4gPiA+IEl0IGZhaWxlZCBvciBpbnRlcm5hbCB0ZXN0aW5nLCBzbyBpdCdzIG1vcmUg
Y29tcGxpY2F0ZWQuIFRvIHRyYXZlcnNlIHRoaXMNCj4gPiA+IHRhYmxlDQo+ID4gDQo+ID4gwqBm
cm9tIHRoZSBiZWdpbm5pbmcgdG8gdGhlIGVuZCByZXF1aXJlcyBzb21lIGNoYW5nZXMgdG8gdGhl
IHRhYmxlDQo+ID4gDQo+ID4gPiBpdHNlbGYgYW5kIHRoZSAiZ290byIgd2Fzbid0IG9taXR0ZWQg
YnkgYSBtaXN0YWtlLCBidXQgZm9yIGEgcmVhc29uLi4uDQo+ID4gPiBGb3IgdGhlIGRldmljZSB0
aGF0IHlvdSBoYXZlIChkZXZpY2UgaWQgMHg0REYwLCBzdWItZGV2aWNlIGlkIDB4MDI0NCwNCj4g
PiA+IHJpZ2h0PykNCj4gPiANCj4gPiDCoGlzIGl0IGVub3VnaCB0byBoYXZlIHRoZSBmaXJzdCBm
aXggKGRpc2FibGUNCj4gPiANCj4gPiA+IHR4X3dpdGhfc2lzb19kaXZlcnNpdHkpPw0KPiA+IA0K
PiA+IEhpIEdyZWdvcnksDQo+ID4gVGhhdCdzIGV4YWN0bHkgd2h5IEkgcHV0IGEgd2FybmluZyBp
biBwcmV2aW91cyBlbWFpbHMuDQo+ID4gTXkgb3BpbmlvbiB3aWxsIGJlIGEgbGl0dGxlIGRpZmZl
cmVudCB0aGFuIHlvdXJzIGluIHRoaXMgc2l0dWF0aW9uLg0KPiA+IDEuIFdlIFNIT1VMRCB0cmF2
ZXJzZSB0aGlzIHRhYmxlIGZyb20gdG9wIHRvIGJvdHRvbSB0byBrZWVwIG91ciBzb3VyY2UgdHJl
ZQ0KPiA+IGFzIGNsZWFuIGFzIHBvc3NpYmxlLg0KPiA+IDIuIE9uZSBzaW1wbGUgb3B0aW9uIGlz
IHRvIHJldmVyc2UgZXZlcnkgY29uZmlnIGl0ZW1zIGluIHRoaXMgdGFibGUgc28gdGhlDQo+ID4g
bG9naWMga2VlcCB0aGUgc2FtZS4NCj4gPiAzLiBZb3VyIHRlYW0oSSBhc3N1bWUgTHVjYSBDb2Vs
aG8gaXMgeW91ciBjb2xsZWFndWUpIG1heSBuZWVkIHRvIHByb3ZpZGUNCj4gPiBmdXJ0aGVyIGV4
cGxhaW5hdGlvbiBhYm91dCB0aGUgYGdvdG9gIGxpbmUsIHNpbmNlIGVhY2ggY2hhbmdlIGluIGtl
cm5lbA0KPiA+IHNob3VsZCBoYXZlIGEgcmVhc29uLg0KPiA+IDQuIDB4NERGMCwgMHgwMjQ0IGlz
IGNvcnJlY3QuIFRoZSBxdWVzdGlvbiBpczogV2lsbCBJbnRlbCByZWxlYXNlIHByb2R1Y3RzDQo+
ID4gd2l0aCBzYW1lIHBpZCtzdWJJRCBidXQgZGlmZmVyZW5jdCBTVEVQL1JGX1RZUEUvUkZfSUQg
ZXRjPyBJZiBzbywgcGlkK3N1YklEDQo+ID4gd29uJ3QgYmUgZW5vdWdoLg0KPiA+IA0KPiA+IFRv
IHN1bSB1cCwgdGhlcmUgd2lsbCBiZSB0aHJlZSBwYXRjaGVzOg0KPiA+IDEuIFRoaXMgcGF0Y2gg
c3RpbGwgZml4ZXMgdGhlIEJVRyBpbnRyb2R1Y2VkIGJ5IHRoZSBgZ290b2AgY2hhbmdlLg0KPiA+
IDIuIFBhdGNoIDIgc2hvdWxkIGJlIFtQQVRDSCAxLzJdIGluIHByZXZpb3VzIGVtYWlsLg0KPiA+
IDMuIFBhdGNoIDMgcmV2ZXJzZXMgZXZlcnkgaXRlbXMgaW4gdGhpcyB0YWJsZS4gWW91ciB0ZWFt
IGNhbiBmaW5lLXR1bmUgdGhlDQo+ID4gb3JkZXIgb2YgZWFjaCBpdGVtcy4gSSB3b24ndCBzdWJt
aXQgdGhpcyBwYXRjaC4NCj4gPiANCj4gPiBJZiB5b3UgbGlrZSBteSBpZGVhcywgcGxlYXNlIG1l
cmdlIHBhdGNoMSYyIGFsb25nIHdpdGggYW5vdGhlciBpZGVudCBmaXgNCj4gPiBwYXRjaC4NCj4g
PiANCj4gPiBCVFcsIGl0IGhhcyBiZWVuIGEgbW9udGggc2luY2UgdGhlIGZpcnN0IGVtYWlsLiBJ
J2QgYXBwcmVjaWF0ZSBpZiB5b3UgcmVwbHkNCj4gPiBzb29uLg0KPiA+IA0KPiA+IENoZWVycywN
Cj4gPiBBaWRlbg0KPiANCj4gSGkgR3JlZ29yeSwNCj4gDQo+IFBJTkcNCj4gDQo+IFlvdSBzaG91
bGQgbGV0IHVzIGtub3cgaWYgeW91IGFyZSBub3QgYWN0aXZlbHkgbWFpbnRhaW5pbmcgdGhlIGNv
bW11bml0eSBwYXJ0IA0KPiBvZiB0aGUgZHJpdmVyLiBJZiB5b3UgYXJlIG9ubHkgd29ya2luZyBv
biB0aGUgY2xvc2Ugc291cmNlIGZpcm13YXJlLCB3ZSBzaG91bGQgDQo+IGhhdmUgc29tZW9uZSBl
bHNlIGRvIHRoZSBvcGVuIHNvdXJjZSBqb2IuDQo+IFdlIHNob3VsZCBub3Qgd2FzdGUgb3VyIGxp
ZmUgZm9yIG1vbnRocyBvbiBzdWNoIGEgc21hbGwgcGF0Y2guDQo+IA0KPiBIYXZlIGEgbmljZSBk
YXksDQo+IEFpZGVuDQoNCkhpLA0KDQpZb3XigJlyZSBjb21pbmcgYWNyb3NzIGFzIHJhdGhlciBh
Y2N1c2F0b3J5IGFuZCBkZW1hbmRpbmcuIEnigJlkIGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkwqAN
CnRvbmUgaXQgZG93biBhIGJpdC4gUmVnYXJkaW5nIHRoZSB0YWJsZSBvcmRlciwgd2XigJl2ZSBt
YWRlIGEgZGVjaXNpb24gaW4gdGhlIGNvZGUgd2F5DQpiYWNrIHRvIHdhbGsgdGhlIHRhYmxlIGZy
b20gdGhlIGJhY2sg4oCTIHRoYXTCoG1heSBub3QgbWF0Y2ggeW91ciBwZXJzb25hbCBleHBlY3Rh
dGlvbiBvZsKgDQrigJxjbGVhbuKAnSwgYnV0IHRoYXTigJlzIHJlYWxseSB5b3VyIHByb2JsZW0s
IG5vdCBvdXJzLg0KQWxzbywgd2UgY2Fubm90IGNvbW1lbnQgb24gZnV0dXJlIHByb2R1Y3QgcmVs
ZWFzZXMgaW4gZ2VuZXJhbC4NCg0KSWYgeW914oCZcmUgd2lsbGluZyB0byB3b3JrIHdpdGggdXMg
dG8gZml4IHRoZSBpc3N1ZSB5b3XigJlyZSBlbmNvdW50ZXJpbmcgd2l0aGluIHRoZQ0KZnJhbWV3
b3JrIG9mIGhvdyB0aGUgZHJpdmVyIGlzIHdyaXR0ZW4gbm93LCBJIGNhbiBnaXZlIHlvdSBhIHBh
dGNoIHdpdGggbW9yZSBsb2dzDQp0byB1bmRlcnN0YW5kIHdoeSB5b3VyIHNlY29uZCBwYXRjaCBk
b2Vzbid0IGZpeCB0aGUgaXNzdWUuDQoNClJlZ2FyZHMsDQpHcmVnb3J5DQo=
