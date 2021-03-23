Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C85345A51
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 10:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCWJE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 05:04:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:56820 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCWJEv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 05:04:51 -0400
IronPort-SDR: l3uMho8A8w02/DbAigU6wmfGgDvobVA0XC+Zpta+g+2bdy0hxTkRMwCQFWV9c6yH3IGbWSNQC9
 J0mkOFfsQW0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190533017"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="190533017"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:04:50 -0700
IronPort-SDR: GcWSb5ZuZ9x1QY6wSSS6rtukbhrerf+m/bljgr/B2aeafoql1Lt6eONvwRrW75MimJfKUGdSNd
 mabu/MuoNhJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="524759986"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2021 02:04:50 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 02:04:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 02:04:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 02:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU7tzh7F/+bu8N388HcQkvL7g5WxiTNIZNpOJvHnlmc7kR0HPEcdBkDD2hzHmfRyBfoorkGVvyGrhYnc8pzKc2yMUfVQygGBsVVSpPJh2mnPLkU8JUN2Seiw5qSm8ucdo6Qwg9lF+OHk2hQw61g8j1kE16tp4ns+jFHKQ/frRUytBMY9wd1b6yIoKO8RmsQLnrQ3xtJxTWu6fLYIvaMGtiG28YOfVLXIEujJRi/cnfFIXbTCVeVUz5gxlpEQXu0QJha3w6qE1lxfvE9MJJgDvH/gdVZBwZCnGAdC44+CUlN3h92IKiB5uHgRPRoFiP+d8VNfcWP012XG9eorEn1j3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK3s2kacenPMfZu9UNbQWmfMjkTguT/C3sobywOkX2w=;
 b=DdR4Qd3EjeevGY8Ez/OG7QqP4yUTCLkaf/eiD73pChR6sBmfpDeV6ZYuvz8lSczMPcWdYpe2Pm/57RqovVVRV2N7nGB4l60DKG997l4Prj6CM8yRhF0D3N6zqqirun2c5e0gOwoirvapOkToB1DTHoukUhvwI+XcvBF8AGhcIEvvTYdYT/IJDaq3kXjV8e3xZ71E078rmqGhJlXCLWSim0xydth2sfqTYObjxiEzrqczt/me5ox16hBe2cCMlGrXph75kRIl8n3+Y82GzVgH6PwcvnWko5uR3dmsEWIXN8XeEu0eARooHbv3yMVR6yAMyUq7Aw7GD/a2XrOc+9Lu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK3s2kacenPMfZu9UNbQWmfMjkTguT/C3sobywOkX2w=;
 b=vyaGjjmgrBMiD9/9NY+MXGVfsTB+XS8l2Ne9TsYbIRGmPrZE9BDBWzzHR/xwV2XYXmkWTLvLq789UNff8+rIa5SCO76Fd3rQfHpeXGjTENRCPSuA4ezfHR7pUYhfiCc4o6HOZE77wnYt1eU/LAFh8ZZPGAjVWav1JwWLt2xmYSQ=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 09:04:48 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e084:727e:9608:11c7]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e084:727e:9608:11c7%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 09:04:48 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "zhangqilong3@huawei.com" <zhangqilong3@huawei.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     linuxwifi <linuxwifi@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH] iwlwifi: mvm: fix a memory leak in
 iwl_mvm_mac_ctxt_beacon_changed
Thread-Topic: [PATCH] iwlwifi: mvm: fix a memory leak in
 iwl_mvm_mac_ctxt_beacon_changed
Thread-Index: AQHWvnGRLnrkOClSJ0KBJeRW9ZXHlKqSCkAA
Date:   Tue, 23 Mar 2021 09:04:48 +0000
Message-ID: <ab261e501db7af2bf80087b8c0211bd58697e080.camel@intel.com>
References: <20201119124628.2926763-1-zhangqilong3@huawei.com>
In-Reply-To: <20201119124628.2926763-1-zhangqilong3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4ff8b62-a2db-4bf6-61a9-08d8eddab5da
x-ms-traffictypediagnostic: BY5PR11MB3958:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB39585D44F1A25880610DCE6690649@BY5PR11MB3958.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hd56Rqiz4awXgA+kAfKyV7FlibU/bZde9y677ep3cm44xX+PsdC3ej9RTbKR2xiQKVcAlcNeMln4TcqDRI1WuVh6KI8DpvMUSsZERb9RTLh/9BZr06hUTmmJSwTuNxGPn3x2O8T8YDpb/G0lhccpCdyqg0SJls5abrnTxnDlVBGPqf/CR3/tgwSx+GV4jL8nXeF4o6v08eZYmDSrgsWRSDOpKdToyNJnr4rIwP9Wsti7MrhZ0GHTsJmK/c1WGLHCm21WBUIizymZOcqnog4mXMNMcljQfveOmJ94y/A5FKCJgoNyqzejAGeT+kuryiqhpbF8knFyA/wG78YuGVt4B8ZzqMNao7LzF/fuWUeEn7Au7ExmfEXUeu96+KjIM7jc6nXHo4UJu7T/1N7U8y4z61v91lawEV4hbBnZ02nOUNGgDACrzn98TdftUdeGz9SbXYGPFzBQTfEUYG2jLObznH6j44T24PAilVLIcQ1GnijBMa9eL6t3j0kGJ8mVaGrlm7Z3EtFO32wTYjAJwmbiXnUMrj7909j1zGqgyIlq2pf55MZuIithtBYomq6cFw958Rh5aabS9eD3wVbUvnsB8kcGrs921xhEVfdfuHS5RS2NIszvwM3EBQe0Q3U8+6Jbb6mi4L6FHjU24b9BxbPYF0ZQShmM0+e5OjsUE0rQ9cM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(4326008)(110136005)(6506007)(4001150100001)(26005)(478600001)(83380400001)(54906003)(38100700001)(316002)(36756003)(6512007)(86362001)(71200400001)(2616005)(186003)(91956017)(66946007)(76116006)(66446008)(2906002)(64756008)(8936002)(66476007)(5660300002)(8676002)(66556008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OTRYZ2dJOG9YTktsK2ZQVERvNnR6YlJaZjJxRTVEa1NsQU1WaENTdmZYNnBh?=
 =?utf-8?B?V2VMallZTXYwekZxVGwrKzhyWUE2M2NMdGZLcHVaVTB1cHZ1RHJvbTJ5enBw?=
 =?utf-8?B?Z2xOdVVNOFhpNXR4N3lYdUlrdGZyN3E4Q2NNZVJmbEFNaTNScWJ0ZlRuNTNZ?=
 =?utf-8?B?S1BhSjVDSnZvblNUSWs0dlVQMjI2YjUxdFhUQVRjL1liZmxiWnc0OGxsUE9p?=
 =?utf-8?B?V3JXNlZIeFc5YjNmVlRNK2VJN3pXaythOTVOUDdSSWJ5VmpnVVIrQXhyOVFM?=
 =?utf-8?B?Nk5CNkROL0VUTTUvb25iTFNEMyt5YldTUzVxWjRCNFNDNnBLaFI0QzdsU0JE?=
 =?utf-8?B?clM5dDRML211ZS9xL0J2Mlh5ZytERXhaTjQrVkNaTi9xd3dKRFcwQnJ6SkRE?=
 =?utf-8?B?R0ZQeWlWMmM2UjY4SWRzZE5ETG5FR24vT0FkeXUxck0zUmFiaWh4bng4VkZM?=
 =?utf-8?B?cEpUdU5wai9wZUxrWkdIZ1l5b3V3WDh1ZlJYVGwwZFphcXZuRmw4blZjOW1j?=
 =?utf-8?B?Z3AyK1JIRjJRNmVTUk1WZ3dVK2FJMzZoclhLbG1YdzFXWnV4eTFrNmlTK2Z6?=
 =?utf-8?B?T2J3M2VZcTZXVTZ4K0JtYzJhTm5XWVFORWRaL3l4eDB5VlFLcEVBTnpiZ2lt?=
 =?utf-8?B?RlI0ZlpjRG9BN3o2VkhMUnR3TWJZU093SXRITlJKQ0NZZ01OeDY1WnJnWU5J?=
 =?utf-8?B?MHd1bERoT0RLZ3AwbDFjb2hrQVJwWDVEekw4SWVqM3AyTmtUWkd5bDVzWDNW?=
 =?utf-8?B?R0dJb0Zmd2Z4bktQZFB2Q3lWZXJoUGZ4M3RrQ1l6cDR4SmVnTzVPbGt4WFdn?=
 =?utf-8?B?bUdRUWhGWDRrdytISXVPeEZLbjZLV3hQRmlFNlJyRzRHK2tXQ1JZY0hvNXZZ?=
 =?utf-8?B?NFBRQkZHdTU4L3hWdWRON2x6N3lnVktQT1BycHc5N1c2amRkSkVMUzdTSGdr?=
 =?utf-8?B?Z0ZWL01zTXJack85a0Y2eFAyejZjUWxMODVBYW11L3UyenN3eXRFRnovM2x4?=
 =?utf-8?B?TWlFOGloS3dtdVdCSm9uK1lPN1NOYzNmakpUcGpuUmQrNUo1TGd6di8xZjNE?=
 =?utf-8?B?dWM4SnBpMEFZL05TTVYwZWNNcVdhMDBWVjNjejB6Mk53SHBLTjUvYXN3U3VT?=
 =?utf-8?B?K3NkVTlkSFdPYklBRnlOclMxeVRhdjRHYys4Y3ViaVVkUkVteGxZYXAwOWFU?=
 =?utf-8?B?UlFHN244VVRpZkI1azErUUFWOVkxTloyWTN5T01jSHdtd1IvNDZ5MjMzKy9q?=
 =?utf-8?B?OUZLejRqd0R1dDB6QmtOcnlKU29DT0NyWlRlUlhPMTZkclBCQm5nb1A3c01Z?=
 =?utf-8?B?NFVvTnQ1S2lRaks4V1NkcWxlTGZWNzA0a25ibFdiUFd5QVZwQlB3YVNGUDRl?=
 =?utf-8?B?U2lIVitOSUxBYmVkTHNsZ3ZuV3JnbklXVUFPbkJVQkx2dnFCeFJLNUYzekt3?=
 =?utf-8?B?VEdpMzZjMFhCNitHVzVrdjF3cXYvZmZyVHZkRzhnMmllY2RoK2VVZm5wcVJx?=
 =?utf-8?B?MjJaU3FUYkZhMnNKUmhra1BpNFp1a1BvVzc1ZFU1cVhhTml6WEFkaXRNMEV1?=
 =?utf-8?B?cE5zNkVSUTR6djZ2ZzBIVUFtTGNVYjBRVVJwRDI4enI0M2M1bGxLMFkvZ2FT?=
 =?utf-8?B?TUx6d04vT0d0ZUZMWnQ5K0hua0RIb2pzVU8yYVUwT2lqWEczd1RKbVJkUkFL?=
 =?utf-8?B?Zy9JWkN0akw4aGtUczRxd1ViTWFjVlAvNlZnN0tnNUNwbWJOZnZDa2tCbzc5?=
 =?utf-8?B?VnQ4Q2k0SU5zYXlXOHVNWnNpcmpWNDRPdlErL0hUd1hIREswTFBzQUg4OTlK?=
 =?utf-8?B?eWF0NUQzMG9tMmVxQXZCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D4302EFEC0E614197E416513D34CDD2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ff8b62-a2db-4bf6-61a9-08d8eddab5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 09:04:48.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TvvUdts7YUetweeA0S6r/TcsxSaINVZ+IY9ReFTjQ7LkMnuSlOBlXEwjX88jUGBZZqYLwHJyHKSZvc1SnzgSllsiVpBpAY7GXMaH7iSrwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3958
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTE5IGF0IDIwOjQ2ICswODAwLCBaaGFuZyBRaWxvbmcgd3JvdGU6DQo+
IEluIHRoZSBlcnJvciBwYXRoIG9mIGl3bF9tdm1fbWFjX2N0eHRfYmVhY29uX2NoYW5nZWQsDQo+
IHRoZSBiZWFjb24gaXQgbm90IGJlIGZyZWVkLCBhbmQgdXNlIGRldl9rZnJlZV9za2IgdG8NCj4g
ZnJlZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFFpbG9uZyA8emhhbmdxaWxvbmcz
QGh1YXdlaS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL21hYy1jdHh0LmMgfCA0ICsrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbXZtL21hYy1jdHh0LmMNCj4gaW5kZXggODY5OGNhNGQzMGRlLi5lOWE4
MDRmZmQ5ODQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL21hYy1jdHh0LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vbWFjLWN0eHQuYw0KPiBAQCAtMTA0NCw4ICsxMDQ0LDEwIEBAIGludCBpd2xfbXZt
X21hY19jdHh0X2JlYWNvbl9jaGFuZ2VkKHN0cnVjdCBpd2xfbXZtICptdm0sDQo+IMKgCQlyZXR1
cm4gLUVOT01FTTsNCj4gwqANCj4gDQo+IMKgI2lmZGVmIENPTkZJR19JV0xXSUZJX0RFQlVHRlMN
Cj4gLQlpZiAobXZtLT5iZWFjb25faW5qZWN0X2FjdGl2ZSkNCj4gKwlpZiAobXZtLT5iZWFjb25f
aW5qZWN0X2FjdGl2ZSkgew0KPiArCQlkZXZfa2ZyZWVfc2tiKGJlYWNvbik7DQo+IMKgCQlyZXR1
cm4gLUVCVVNZOw0KPiArCX0NCj4gwqAjZW5kaWYNCj4gwqANCj4gDQo+IMKgCXJldCA9IGl3bF9t
dm1fbWFjX2N0eHRfc2VuZF9iZWFjb24obXZtLCB2aWYsIGJlYWNvbik7DQoNClRoYW5rcyEgSSBh
cHBsaWVkIHRoaXMgbm93IHRvIG91ciBpbnRlcm5hbCB0cmVlIGFuZCBpdCB3aWxsIHJlYWNoIHRo
ZQ0KbWFpbmxpbmUgZm9sbG93aW5nIG91ciBub3JtYWwgcHJvY2Vzcy4NCg0KLS0NCkNoZWVycy4N
Ckx1Y2EuDQo=
