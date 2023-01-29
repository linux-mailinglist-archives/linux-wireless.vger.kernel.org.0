Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F568004B
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Jan 2023 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjA2QrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Jan 2023 11:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjA2QrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Jan 2023 11:47:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48817151
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675010831; x=1706546831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WUcueK/a9BTD+RKzhhdKdR8X6fngFE/VvEBs2M5ayzY=;
  b=Qo4q5gRXh1Vu1Pro7dfSmMYem6exxUhCSE0IAoO9vRxJWvMzYaVtL4t3
   AAZEtPRwL1SaPQMxdscwQ4oJTWrPndiArG1cZRCUdhGhQEheqwUH+9VDO
   xIsK9yVZjtQVbGYZJckAvk5xGmXpZJl2u920g1by9rFJ0vdHwfmS0FPlE
   6yhw2+P8CznfhnDrg8pPrqwcbQOahIe8v93csPbzSDD8Oet0CUQ8dwpF3
   dw8Rj6MP0eQA9Iv95PqIfA8cVL8UTA2F1n97lDaDQ+cQ4ALuWAC1OQmv9
   z+FQQnOr3BQe6ljwBjsCwmKqzIuqDNYGdV0izX4KnrC7fLKJasq1YwtxB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="391966353"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="391966353"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 08:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="665821354"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="665821354"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2023 08:47:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 08:47:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 08:47:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 08:47:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 08:47:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5+t3h/SgG02jNiiS5118cM0q9H7lN5TCebOc+Qmu7C3qh5hRKUHe2QPxa0YpydOft6YV52PVM8PBC2oV1pTnXtwghR7yzfiDKXFCxomn8glLgCsz58hZrio+c83MB+WJJC8XxdWFVEA1oE0yhym4JjrELhV9kdRIxwqblc1X3RkHMB3e4HSAT/cMVW7GmMM+rPbcffq/5vQBI/qpWdZyezAK2ChcfSx54NXnGOzao915FezeZLwV3JdvVSXX7W+lanon7SbrHnhzJfTBBvBEY6vot4sFN1HDmLoqgRaP38/l2lRoh995L2I8YWGW4yKOJLhQERqt97+WB7ntkvBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUcueK/a9BTD+RKzhhdKdR8X6fngFE/VvEBs2M5ayzY=;
 b=Hp7xgT06lhnnK7EOen9lLcOAwWoFXicoq4bplUr+/GPastFyv0ohToF4YPJh9pIOWt2GZwHVqrceDVn0PXmkhv1wdcubTUQRslS1b9bkStyYCDRKAk/VmniCFg7Q0PeN7PZPnqeEboIPcoQuBK2zdcTRYhYvNtA0yP5pf2H3lNAjjCxysnxy+fQki0df3EpWXh4CUTOhWfzc2MZFvmcKJvvEbiTEWE26I3leyhp91LXR8lCZeeXxkCRIYV686BtJtd7p7vZDx8Lv0sB0b+rbjJ5RazQUfSaGkfpdMvUy914MqCDznt+MXFtUyo0i24+QncOm84LCtee5CfZcFGq8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Sun, 29 Jan
 2023 16:47:05 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c%9]) with mapi id 15.20.6043.030; Sun, 29 Jan 2023
 16:47:05 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/12] iwlwifi: updates intended for v6.3 2023-01-27
Thread-Topic: [PATCH 00/12] iwlwifi: updates intended for v6.3 2023-01-27
Thread-Index: AQHZMdWUJF2RgujkVEyoEEybKOzCUK61nvWA
Date:   Sun, 29 Jan 2023 16:47:04 +0000
Message-ID: <7f25d605cca56dd52c5056ce2f2725e0543563cf.camel@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: b6773bce-d066-40a2-3933-08db021873e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+KOrmDslUdSmbvWfIemSkxfZKMVJq5L6ZUpPIAbQJZ9rki1F0+W6aHFr3f73aJQWGyfPjhjED84d0EZohB4xSjwwRkzxABjIfnshj/9spmPMPj06ESG19vcupATtSpB/8Qs25NvRZ4BHefT9lJRru6Hm4t+ksh+yn1kUP+DUsOsxLrDgAVl1eFjNIpba9C+6b6goas0seB1zROTq30ZOQL4tep9/o2ZooTlrqytp3iBhwvNa3m5s2UKmH6NxD3dLIZkvgn0LXdzF5fbvFCfZqxD+WTGc1vuYnNiByDVEMsomLhpip5VozXrke9CKJ6a3Wwi2rHb7D16iYzqTcj04RtTw2z5R966HKAgoWj3mjngenXDt531te74c22Ff6X5ct16tG5VufsBTlbt/lvP9y7E2EREFjyolnzbOUuY0jmpznm1kPlXQ/YHsGEzqqM1ntgHKQXUxeC0ic9yBora0N0NU3+2jaOfiK6vp8825VLZfWh3LuI/qpr21TFd6qRD0WPfLfME3sRICRxOaN9c5MCmc4naNC5SgnSU+YSJTNtZUjs/k1kMpjgIWVPx7OsygfWwhMpiED21MfwrsiC0pQkIpNlTeMkt1wSrqr/czrZ+6mHq2exK6t9GLJbVs1Y2YN/T3na4VwLZA97neQ/W3HNGTsecu1rQ2bCNF1dchMFcDRfXyLY5p/zpRm0u0R0iaWy0UrH5gLzkhRoPgT++1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199018)(36756003)(110136005)(316002)(91956017)(76116006)(4326008)(8936002)(66476007)(41300700001)(66446008)(64756008)(8676002)(66556008)(66946007)(86362001)(38070700005)(122000001)(82960400001)(38100700002)(6506007)(71200400001)(26005)(186003)(6512007)(5660300002)(2906002)(15650500001)(478600001)(6486002)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkZyNHV3ajI1R3A2a25tdUxwVzY0NWxoY2E5endONXJFbXFlMGFjemJCNjBN?=
 =?utf-8?B?N2NLZ3JyOG16aGhxRTFLMmx0eFFUeUxwV0IrT3Y1dkE4d2MxVVJ0YW9aSFZX?=
 =?utf-8?B?NHpXejB4S0IwVHEvWjZrZW1QRDhneXY4NXFwQ2N4TCtOUGpvV0J3SnljQjU2?=
 =?utf-8?B?MTFxcjF5L0hVcUhnck92b1BNVkFXdCtPcDhZS1hMNHBnR1ZqRFBIYnFMdG1n?=
 =?utf-8?B?aytWWEZxYWpSbjR1SWtYdjFhOXB0NzBMYTJ0c2ZQbG9IQmlDSmZaM054eUFp?=
 =?utf-8?B?R0poeXI3b2VadjJJMk55c1JrRjY0VFlKRWx3ZURWL3hQZ1VVNDJGL2NqMVZM?=
 =?utf-8?B?SXd1bG4zN0NzZjBDS28wd1IzVzg1cFB5QklhQ1MyMyt1TlRNSTk3OVQ0Wjgv?=
 =?utf-8?B?ZENLaXI5YnpHcXNVc3hxZ1JVYWJ2MEZzVDM3dmVDOUJVcWExeHIzR01QWGZI?=
 =?utf-8?B?bEFXQlpaMEFEeUp2ZGZEMytmNktZRDBqTmZkOVdsR1p2S3dkNjhKaTRvWTNw?=
 =?utf-8?B?MUhLQmtnMFNhYXNsaUdqSjE3N1VKd1Y0UWdjS3NLTWdoam5CNkViOWNTR0Ux?=
 =?utf-8?B?RHROOWpncXA5QXVuT3RqTlNsZytRTVhPRkdJYWI2Vk9qcXNYM1ljd0hkWUFx?=
 =?utf-8?B?S0l4UUZ5V3lJMTlnUEJxQ2ozb2dsT2hJRDlIVFhJeFJqMGNJMkdsVDV3b25G?=
 =?utf-8?B?YXZqRUI3NGNmb1V4UmtZYzBGdG1ZYVpDMTZyWDQ0MEhiNldVN0YyQVljdFIx?=
 =?utf-8?B?ZTBNZWoxVS90NEthTEEweDFobytXVUsyd09zQXJLdHc2N01POXNxZjdKL014?=
 =?utf-8?B?MDVTcFR0NU5oS1o4UFRmVTk2Qk9MQXMwaUtHSmthN2IxZlVXeEhmWDlmSE9R?=
 =?utf-8?B?VXU3Q1NPbGZHUSs1ZWxjcW5rSTJJZGsyTjR0SXp1bXlsL1RzNFZhZ2c2eUo1?=
 =?utf-8?B?VERuVEtoTC9RMTl4c1Q3Z2NEQnZFamZSdWg3cmFWWUVVRFg3ZmM1N0U5NS9a?=
 =?utf-8?B?TTIvYnY0Uy9TVjg0OVRxZVdualpCa0lQRDhldFdWZ2dGb0o5ZjRGUk5PS0dO?=
 =?utf-8?B?aHVTVzNOQklSL1dqUm1ua0RwQWpOUnFlVFplRnVZRSsrUk94UHowd28vOVJ5?=
 =?utf-8?B?ZjRKaVJzZis3QysrQnMwWW4weVdYd3FPUEg3QUJycXJXbDVqbm1rL1ZTT01H?=
 =?utf-8?B?WlJtTSs4RnJqUHQ2clZzcHFmN25URVpTMVJCN1FGR2hnS1orYnRiZWJHRnFa?=
 =?utf-8?B?MXhwWlNNZXVYc3ZRdldlVURHb1N5bUVrUm1EYnhFVVplYzQzTlFHUlVhVlRP?=
 =?utf-8?B?S3lkajZvUE9HR2hwS2Y1alVkU0YvQkFjSUtBWEl1MnRKSjhZRkVISXk2RVZy?=
 =?utf-8?B?bEJjblBmNWZURko1ZWppa01GMXJxamVwbUo3TUhOZGZRb0xiclJWT0QraCtj?=
 =?utf-8?B?RXN6cGtYZWRTakxMNmVvVU54YVl4dGwzMHFkR3hqeXdoVVd0N0lOT0ovWVBN?=
 =?utf-8?B?MUM1eGFlM1ZCbDNwTGl4S1RSb2ZydEcwdERhUHgrcGsxdTlsYnh2cXVWTTUr?=
 =?utf-8?B?UGZUQThGaWpibkJJNXk0a3Q2TUpRZE9xS2tVbHpNemRBa1NETStkazUwR2NF?=
 =?utf-8?B?ZU9OODNXSmVrTVVKdUI2VytQVlg1cXFMbDlJT2d2VWN4dGY3V1BZZ0dWR0Za?=
 =?utf-8?B?UGNIZDYrRGtqREtmMVZuNmdhR1BHTkFEalNqZmlKVUxjSWQzck1LM3AxZnda?=
 =?utf-8?B?dTBwbVl2R0hCR2VLQVF3NjlyQjFRRnBnT0M1VXFaVHBUM3Rya3Y5L1pYcnNt?=
 =?utf-8?B?NnlrVHVvRU0yOEQwNHVCQVVKdmgrbVNPY3pQT2d0M2xhaXhva3VSWjMxWkJB?=
 =?utf-8?B?Zm5TZm5kU3d4dC9rZVJYVDcyaEozdEpBUVdKM2ZBUWFLa3BsQXVyYm90REN1?=
 =?utf-8?B?VE9pbXlUMUM2K0JkaDVLZXhJSlBxRmk4d2tzQzE0aFZyOWVIYlcrR1AzSG1X?=
 =?utf-8?B?c253QlUrTGhIRTFGYWc0Z1JxSmg2Y0Q3bUdrQkd0dWVNK2tEd0toeWtvNEo0?=
 =?utf-8?B?WklGckdsMXVZUUcvMnd6RHZjUlRpR0FFcllkTWs1NHdJMDhudGtoSEZrT2lv?=
 =?utf-8?B?TnFLQ0RrWDBhc2N0eEhqMHM2Y05MR1o0em12S1NxMnhMc1FhRUxnNWVzcXlF?=
 =?utf-8?Q?aeRkV3tnIy6l0euHDhp4M2E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FABC4BF38178048B2E777B284AB1464@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6773bce-d066-40a2-3933-08db021873e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 16:47:04.9043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLAuulmYqG5ADsGc56a7M+NDmNyIo1j25ccRAEXnH7RRQIXG+CG9lx3f2ZSbUsGVMRszy/Ss+VRNth5wimQN+W6dOME7WAD5ivj54nXEOWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTI3IGF0IDAwOjI4ICswMjAwLCBncmVnb3J5LmdyZWVubWFuQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBp
bnRlbC5jb20+DQo+IA0KPiBIaSwNCj4gDQo+IEhlcmUgaXMgdGhlIHNlY29uZCBzZXQgb2YgcGF0
Y2hlcyBpbnRlbmRlZCBmb3IgdjYuMy4gDQo+IEl0J3MgdGhlIHVzdWFsIGRldmVsb3BtZW50LCBu
ZXcgZmVhdHVyZXMsIGNsZWFudXBzIGFuZCBidWdmaXhlcy4NCj4gDQo+IFRoZSBjaGFuZ2VzIGFy
ZToNCj4gKiBXVFNOIGltcHJvdmVtZW50DQo+ICogU25pZmZlciBtb2RlIHVwZGF0ZXMgZm9yIEVI
VA0KPiAqIEZpeGVzIGFuZCBjbGVhbnVwcw0KPiAqIEFkdmFuY2luZyBGVyBBUEkgdmVyc2lvbg0K
PiANCj4gQXMgdXN1YWwsIEknbSBwdXNoaW5nIHRoaXMgdG8gYSBwZW5kaW5nIGJyYW5jaCwgZm9y
IGtidWlsZCBib3QsDQo+IGFuZCB3aWxsIHNlbmQgYSBwdWxsLXJlcXVlc3QgbGF0ZXIuDQo+IA0K
PiBQbGVhc2UgcmV2aWV3Lg0KPiANCj4gVGhhbmtzLA0KPiBHcmVnb3J5DQo+IA0KPiBBdnJhaGFt
IFN0ZXJuICgxKToNCj4gwqAgd2lmaTogaXdsd2lmaTogbXZtOiByZXBvcnQgaGFyZHdhcmUgdGlt
ZXN0YW1wcyBpbiBSWC9UWCBzdGF0dXMNCj4gDQo+IEF5YWxhIEJhcmF6YW5pICgxKToNCj4gwqAg
d2lmaTogaXdsd2lmaTogbXZtOiBTdXBwb3J0IFNURVAgZXF1YWxpemVyIHNldHRpbmdzIGZyb20g
QklPUy4NCj4gDQo+IEVtbWFudWVsIEdydW1iYWNoICgxKToNCj4gwqAgd2lmaTogaXdsd2lmaTog
bWVudGlvbiB0aGUgcmVzcG9uc2Ugc3RydWN0dXJlIGluIHRoZSBrZXJuZWxkb2MNCj4gDQo+IEdv
bGFuIEJlbiBBbWkgKDEpOg0KPiDCoCB3aWZpOiBpd2x3aWZpOiBidW1wIEZXIEFQSSB0byA3NCBm
b3IgQVggZGV2aWNlcw0KPiANCj4gR3JlZ29yeSBHcmVlbm1hbiAoMik6DQo+IMKgIHdpZmk6IGl3
bHdpZmk6IG12bTogYWx3YXlzIHNlbmQgbnVsbGZ1bmMgZnJhbWVzIG9uIE1HTVQgcXVldWUNCj4g
wqAgd2lmaTogaXdsd2lmaTogbWVpOiBmaXggY29tcGlsYXRpb24gZXJyb3JzIGluIHJma2lsbCgp
DQo+IA0KPiBIZWluZXIgS2FsbHdlaXQgKDEpOg0KPiDCoCB3aWZpOiBpd2x3aWZpOiBpbXByb3Zl
IHRhZyBoYW5kbGluZyBpbiBpd2xfcmVxdWVzdF9maXJtd2FyZQ0KPiANCj4gTW9yZGVjaGF5IEdv
b2RzdGVpbiAoMyk6DQo+IMKgIHdpZmk6IGl3bHdpZmk6IHJ4OiBhZGQgc25pZmZlciBzdXBwb3J0
IGZvciBFSFQgbW9kZQ0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IGFkZCBzbmlmZmVyIG1ldGEg
ZGF0YSBBUElzDQo+IMKgIHdpZmk6IGl3bHdpZmk6IG12bTogc2ltcGxpZnkgYnkgdXNpbmcgU0tC
IE1BQyBoZWFkZXIgcG9pbnRlcg0KPiANCj4gTXVrZXNoIFNpc29kaXlhICgxKToNCj4gwqAgd2lm
aTogaXdsd2lmaTogbXZtOiBSZXNldCByYXRlIGluZGV4IGlmIHJhdGUgaXMgd3JvbmcNCj4gDQo+
IFRvbSBSaXggKDEpOg0KPiDCoCB3aWZpOiBpd2x3aWZpOiBtdm06IHJlbW92ZSBoIGZyb20gcHJp
bnRrIGZvcm1hdCBzcGVjaWZpZXINCj4gDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL2NmZy8yMjAwMC5jwqDCoMKgIHzCoMKgIDIgKy0NCj4gwqAuLi4vd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9mdy9hcGkvY29tbWFuZHMuaMKgIHzCoCAxOSArKw0KPiDCoC4uLi93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL2Z3L2FwaS9kYXRhcGF0aC5owqAgfCAxMzggKysrKysrKysrKysrKy0NCj4g
wqAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3J4LmjCoMKgwqAgfCAxNDUg
KysrKysrKysrKysrKystDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9m
dy9maWxlLmjCoCB8wqDCoCAxICsNCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL2Z3L3VlZmkuY8KgIHzCoCA1OSArKysrKy0NCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL2Z3L3VlZmkuaMKgIHzCoCAxOSArLQ0KPiDCoC4uLi9pbnRlbC9pd2x3aWZp
L2l3bC1jb250ZXh0LWluZm8tZ2VuMy5owqDCoMKgwqAgfMKgIDIxICsrLQ0KPiDCoGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWRydi5jwqAgfMKgIDEyICstDQo+IMKgLi4u
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5owqDCoMKgIHzCoMKgIDQgKw0K
PiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL21haW4uYyB8wqDCoCA2
ICstDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9NYWtlZmlsZcKgwqAg
fMKgwqAgMSArDQo+IMKgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kZWJ1Z2Zz
LmPCoCB8wqDCoCA2ICstDQo+IMKgLi4uL2ludGVsL2l3bHdpZmkvbXZtL2Z0bS1pbml0aWF0b3Iu
Y8KgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvbXZtL212bS5owqAgfMKgwqAgOCArDQo+IMKgZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vb3BzLmPCoCB8wqAgMTMgKysNCj4gwqBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeG1xLmMgfMKgIDgwICsrKystLS0tDQo+IMKgZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vc3RhLmPCoCB8wqDCoCA4ICsNCj4g
wqAuLi4vd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdGltZS1zeW5jLmPCoMKgwqAgfCAxNzYg
KysrKysrKysrKysrKysrKysrDQo+IMKgLi4uL3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3Rp
bWUtc3luYy5owqDCoMKgIHzCoCAzMCArKysNCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS90eC5jwqDCoCB8wqAgMTIgKy0NCj4gwqAuLi4vaW50ZWwvaXdsd2lmaS9w
Y2llL2N0eHQtaW5mby1nZW4zLmPCoMKgwqDCoMKgwqAgfMKgwqAgNSArDQo+IMKgMjIgZmlsZXMg
Y2hhbmdlZCwgNjk3IGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQ0KPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90aW1lLXN5
bmMuYw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL212bS90aW1lLXN5bmMuaA0KPiANCg0KSSBuZWVkIHRvIGRyb3AgIndpZmk6IGl3bHdp
Zmk6IG12bTogcmVwb3J0IGhhcmR3YXJlIHRpbWVzdGFtcHMgaW4gUlgvVFggc3RhdHVzIg0KZnJv
bSB0aGlzIHBhdGNoIHNldCwgd2lsbCByZXNlbmQgaXQgaW4gdGhlIG5leHQgb25lIHdpdGggYSBm
aXguDQoNCg==
