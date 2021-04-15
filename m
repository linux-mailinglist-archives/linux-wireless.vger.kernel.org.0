Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB550360B1F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDON4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 09:56:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:17163 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDON4F (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 09:56:05 -0400
IronPort-SDR: EXI85KitP5Ep/OpBv7SQFuJMvylSf5NdFQ//wdd8NbQtizKDkJiMxgugrJSid2NdIIJbFM4H+c
 FHjKWfuhdAHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="174350215"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="174350215"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:55:39 -0700
IronPort-SDR: lkR8SukBYqAVvkzV0rt9Wv39gt0ZfmKmyn9/xjDjFa4eUZNXvr1rDEAlaEWFDt6bRNIdaPC9R7
 HW5r59ydAFzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="421698723"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 15 Apr 2021 06:55:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 06:55:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 15 Apr 2021 06:55:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 15 Apr 2021 06:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQbeaVr+Q01opGn3igmPJ+caVLK8ldQ2Ibdk0T2NS+yCd4zPZyLihNXqWDIXo3Axdxdr0D3+d4bb6gv/O4J8C/SpGgtYQfYtlZS66hg5Q+VTUxoyVmdVD6Fa+boP90bIXzVJc5R4nmF25vW/nIpDxukGbyh918HEKbyH1QSEiQU/eeOnYH9hBdvO9NoOBsBN8tX6DwEyXNpurUN2D/EKSZZhREMSKtsINiOhrMa2F6jxb1ubXhCdavEx5JvoKJIljdE9tufWDINRY+1KC/rIiG5HrroX/xYtS54JQKplGKX4VGeZwz6iX8I/f2Ljqu6/ef/e4fCx/MK2tcu+8YktXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdGkvaxQJU3HqssODkXa4vqEkdw5naRkDpxowr7f+gA=;
 b=ZTsrYmqfrplxSYax/7Np8JB+XcTYf4CmxAXpGAXn9xS5e/vi7InTieWqNpOmTHJ2n/OhO7GHn2Kw/OblzxAxkKnl323mS9kCu8nIn5SzC+ya4oQaMNJqxA3Oti2TBMuzcZ7CWYA45RGWsSuMNCrtUUNPt0iZbLAQCMrJM8IIc/uUsvrU/43zy6vEnwIUVmrR1wo8XtC5YOgt/B+skGndOHrWflYMF4ISUU9EJKDSs06f+BaogfUUYmRW+JywJwV1VQDKPgIOw1iV2bglcYYPVYmB0HRX1Pupuf48EzpMbTX+XBzcO5dZbL1ghhAvUGALQ38yoHG+0WvBO7ohtbv1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdGkvaxQJU3HqssODkXa4vqEkdw5naRkDpxowr7f+gA=;
 b=h8IyK7wuLvlb9VxsoT6ZYmut10vkkDc1XwP4MV1CicFZQLXbUECljEoE64ii8oHmniZzIEsjFM6B9V9LPBT2tGFb/oA2Z2cWRPJhe7nu7rQxIec7wRjRh6WvLncTBNhZcWIXFgMG+DDJpzkPzWnfk9JMW0RWjCSaRBs49qUkpvE=
Received: from BL0PR11MB3201.namprd11.prod.outlook.com (2603:10b6:208:6b::21)
 by BL0PR11MB3170.namprd11.prod.outlook.com (2603:10b6:208:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 13:54:56 +0000
Received: from BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d]) by BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d%3]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 13:54:56 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lists@colorremedies.com" <lists@colorremedies.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Topic: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Index: AQHXMe+RUGJ6U8HHjEyOqMg0KcytCqq1f/jpgAAEO4CAAAI1gIAAE4sA
Date:   Thu, 15 Apr 2021 13:54:56 +0000
Message-ID: <48b92f7dbfe24bdc84a00ec20adf76010d3e70d3.camel@intel.com>
References: <20210415120447.4424-1-hdegoede@redhat.com>
         (sfid-20210415_140503_625209_839D9098)
 <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
         <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
         <nycvar.YFH.7.76.2104151444150.18270@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2104151444150.18270@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 280201b9-f881-42d9-eaa4-08d900160d78
x-ms-traffictypediagnostic: BL0PR11MB3170:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3170603422642AFD1DE395E0904D9@BL0PR11MB3170.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BesrRYYBCZx4DM93oFy9frm6EWzcawTPBSWazonxCsSqoFeROmtlanFVoe3a79ydqdVzZluBF1lX6e5oyUeeIkuWEayltI8GgRhLcfSChvz9s0/UUFuCtjCq/ZSpbA3FzuHBsTPa4SMSwe0xPp15yy3N9Bo+xn6fKFAdSb3uqlFisSrGs+66qjq5Unots1johsnfRfWyKaz6+lJpDUkkFUhwTKrEynQJQ/lJMWXkBqravdeG2BuZn/YSvXejCf5YBpHnkbe3H8A8KYkPW1X1RYdWOrwho8FZM4xlgr4S8jH9yPTiqkrh/RiILiifuCuclzK9IrrPDrM+jmVYxkr6c7tMDoM8C1ecHPJIdw8n77YIourJjqBLQysaPqArJGo4rsiwsh0qo8qtbV/y4ev4zd5H5fUvCzGOdRx4AEUEgsHkzhU2g232hKwfrMshnfgZJygz/Q9fJ99XYPQq4r7ePNqVKd41kdqcax++MkqJZsxdH/TZQCugF6HK0g8Sa8lLYmXHVWxCAnIPprT4vw/TPApJHAuT0XX59eKX8t5oI7vK9tTwNMQ8ctHVuR4/YS87PaSz3xx2NDm2E3LAAvrJFXsYxs/gx75WQr061LKLscXaFkN5ZJwD7DxG+wbxl0s+t/gS7icnjCp7pApsgSNEu/jDic4KuLpDl1+ZWXatOlORf/A2SnCfDVDOXm4rDIbG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(6486002)(86362001)(2906002)(5660300002)(71200400001)(316002)(38100700002)(6506007)(91956017)(8936002)(107886003)(4744005)(66446008)(186003)(26005)(966005)(110136005)(122000001)(4326008)(478600001)(54906003)(76116006)(36756003)(6512007)(64756008)(66476007)(66946007)(8676002)(2616005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RzZDQmg0c1d3MUs1TVpjNmJzZFQyZmljWkZhQUtKUEVFWnphbGxUNnE4ZnhS?=
 =?utf-8?B?V1J3OTBycGVGazNYbWc4WVVIQTRBRWJiQXN6N1o4SHNIdFZoYWNOV2NLKzVB?=
 =?utf-8?B?QnhGOEMyTmI3cDQwalF6VlZtNXJ6dkRBeGwraFQ0anVxbklPTjFIQTdoZXBE?=
 =?utf-8?B?WGNLNmU0bTdISHVBcWduQ3VxMUdYdFZEdGNQdlNjR05LTC93TjNmbStubFV5?=
 =?utf-8?B?dm5pWGZkamJVRnpsQUdIa0NwMzBjYXlQd0RUejk5cjZTK3JqcDE1NHh3Vnlm?=
 =?utf-8?B?cHlwVXYzMTZNaDRqcUZpU1NLQkV6UTIvaTVvbmJSU3p4QWZoTHVYRGhZVWl4?=
 =?utf-8?B?OFFQOUFrcUw2S25taWVqUmlSaXdBeHJBWEkweTBINHpnakdPdzJkVVFVYkZm?=
 =?utf-8?B?NWpuV1hTWkRlYkVwNElDNHJRbEhyMVBWU05nUmszMzk1WWNheWJPQjl3RHg3?=
 =?utf-8?B?UXNrNFdCOExlR1UrL3ZUc1FIQnBENFRtTW8wNEhTRWxvbDh2Mzl2TENyWWhR?=
 =?utf-8?B?WUdvbEVZY09odnQzdlRpcXJiL0MxMmkySk1XMyt4d2c0b0J4dlhBSldvOU1E?=
 =?utf-8?B?UWdvc2dSWlQyYjErTnRCcmF3ZXRyNXZ3T2dYeGt1b3dSMEU0azEwZU5RSEFp?=
 =?utf-8?B?Rk9RTDJJMWZYZ2tJMEVPNUpFYi9VbGFPeGlVcXo2SXZmSktBS3hHZHRNUkVq?=
 =?utf-8?B?aDhlSnkyakMzVWRHMzNQeXpGb21oRytUYkRRSDBKdE0vcFJyZWRwekZGRHZa?=
 =?utf-8?B?OVhYYWJCeld1YXQ5TDRVdlZDMENSWG1yZ3g0cDVPakE3MEc0cFVVQnJydXVk?=
 =?utf-8?B?bC8zZmVjM2FxWmdUc3hHOXNBSDZxODR2UDRTU0tla1RQNHVic0NlYURTNXQw?=
 =?utf-8?B?cUhyVC9GL0ZYRUw3TE5iZk01aElxbmNDYzNoKy9oM2RXSWlacFdSQjEyUVox?=
 =?utf-8?B?VERSS1JFSVBSWlV0Y2RhNlZKczZCWmhQemVIVWc4dy9QUGQ1MVoxaEllMEM2?=
 =?utf-8?B?ZlFDRjZ5TTBIS2NCeDdXYjFFcmNtOXhNV2dMNVNpUG9rZmFYTjhGWVI4d0VH?=
 =?utf-8?B?ZXV5UjBNYWZZUktaKzY0V3o3WkdrZENEZUpka1EyMzAyKzQzMVFNVTlwZm1r?=
 =?utf-8?B?Qk9lWFhvZ0tQckhzT2VsSlk0WnJpYzF2dVZFSzc0QUszblBZNlpaTWZKZ0dr?=
 =?utf-8?B?dXpzM2pranVuaHNERXd4NVFmV1hYN3VoemJHTzRPNDhLRFRib1BLdXJ4VlhP?=
 =?utf-8?B?cy9CM2JNc2Q4WW1QekJBNmpOalIrMVNyeG44QWJUanQ4aE1LY3RhOWlqaXlv?=
 =?utf-8?B?c1VWdlRhM3FSOWUrTzMybXBqSnRXNnVPNXA0UDBrWk9lNEpwd2lsN3huTTE5?=
 =?utf-8?B?QUdhcnRMcy9xVGVVVVVMNnhGT09lUnRvSmZTUnU4T2NhU1ZxbnJvbGRGMmE2?=
 =?utf-8?B?NFRJODdNUDdQQ3l5TW9EZUNyQ3FkZUNNUmY0b050MEkrdEkvSmQ3Wnp0ZnNi?=
 =?utf-8?B?QnFvUVd5bVlONkJva0JNajB4UFEzTTVZTFRYeGZDMUJRc0ZlRW1vVVFzTGk4?=
 =?utf-8?B?MTVJZ2h2MkdGOVhWZUVMQ1hHQmFna3hlZU5xSkFGK010dFFzV3lma0hSOXBQ?=
 =?utf-8?B?clc1eWVDSXpMTTZ0WFVnU3BVUXVRYTVJaWNmM2JNby9tbERUaSsyNTlMWGRk?=
 =?utf-8?B?ekdZbEhlZU9CVGg0U2w1Y2NQSExHdWtUOVc2OWZETEkvdmthWVM5YlVqUUg4?=
 =?utf-8?B?MEVWOUxSR0RrS1laUjJSSk95Ym8rd290cUE2NDBJY3lLNktXNTU2WDlMdWd2?=
 =?utf-8?B?RVBNQm5JM3VLYjZGNEZZZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EF233CB7E40DB47AB4C141A255F55AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280201b9-f881-42d9-eaa4-08d900160d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 13:54:56.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJeeDyAOT41Y8RaBFJ+EZjeyPPSSyT4adhRdaLO6XhPHVkdnMsEBc9xGFFlhlRRuoTjFnZzgd/kOv3W3kf23lr/wU4DJccZfcse2eRQZGBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3170
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDE0OjQ0ICswMjAwLCBKaXJpIEtvc2luYSB3cm90ZToNCj4g
T24gVGh1LCAxNSBBcHIgMjAyMSwgQ29lbGhvLCBMdWNpYW5vIHdyb3RlOg0KPiANCj4gPiA+IEkg
YmVsaWV2ZSBKaXJpIHBvc3RlZCB0aGUgc2FtZSBwYXRjaDoNCj4gPiA+IA0KPiA+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvbnljdmFyLllGSC43Ljc2LjIxMDQwNzA5
MTgwOTAuMTI0MDVAY2JvYmsuZmhmci5wbS8NCj4gPiA+IA0KPiA+ID4gTm90IHN1cmUgd2hlcmUg
aXQgaXMgbm93IHRob3VnaCwgSSBndWVzcyBMdWNhIGNhbiBjb21tZW50Lg0KPiA+IA0KPiA+IEpp
cmkncyBwYXRjaCBpcyBpbiA1LjEyLXJjNy4NCj4gDQo+IFRoZSBpd2xfcGNpZV9lbnF1ZXVlX2hj
bWQoKSBpcy4gVGhlIG9uZSByZWZlcmVuY2VkIGFib3ZlIA0KPiAoaXdsX3BjaWVfZ2VuMl9lbnF1
ZXVlX2hjbWQoKSkgaXMgbm93aGVyZSBhcyBmYXIgYXMgSSBjYW4gdGVsbC4NCg0KU29ycnksIEkg
bWlzc2VkIHRoYXQgb25lIHNvbWVob3cuICBLYWxsZSwgSSBoYXZlIGFzc2lnbmVkIGl0IHRvIHlv
dS4gDQpDYW4geW91IHBsZWFzZSB0YWtlIGl0IGZvciAtZml4ZXMgKGkuZS4gc3RpbGwgZm9yIHY1
LjEyKT8gSXQncyBhDQpzZXJpb3VzIGZpeC4NCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
