Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B39360A0E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhDONGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 09:06:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:40341 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhDONGB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 09:06:01 -0400
IronPort-SDR: 19gHW9jeMd2VXaZDhfhGW1JzQAjeWrJjYjQ0SSM8s6BkKoS3/mQjlq5lx3ACrnhbJQ/FK2Wf+Z
 l0Bx1oduLq4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194408809"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194408809"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:04:10 -0700
IronPort-SDR: K1sk5GvDkwxZB5zJwhyQUbNhs3f/wtW+HANJeaazZfLUbDmJa3DMT/ttCpo2DBs7Rs4NGyeYS7
 ntl8kZgh8eOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="451121172"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2021 06:04:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 06:04:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 06:04:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 15 Apr 2021 06:04:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 15 Apr 2021 06:04:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RibmH1KOGIhNghjb7OM29fpsWhe5WJgjmwlNzkxKtS2ICvgnaNdPbNpoIYZ1OduTJGkPc/zTEDU7/HAprdgTILdjSAByTUW9v9oLhD5UHpQV2t3gKIeQYxVju3WjVzcLCAR+yVthU9L+MU3tlxH3elUEXQXIFcC7ABO42vpFSLx48h308/cdoeHP9nKGaugG/SKWUvovQwFqPy0IBPcjgbQTUJd+NcojaDiVWQLqSh2myqchk88aCvodx3KI/UJJt1ef9KJ50L0yP1S7388+MzjK9jpGO3iQrHcxYO9j7tM+PVPUIpresbtDgrmm/o4ah8AQNOBdy+2i8CNWJxrwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q36lAEA9+OxrLtqJIvM0pok8wJwKm9GhWQN7iEs6dLI=;
 b=htmvFOGh/DIxrVDxrsICR4grsOK3Zj56RzJvI0G+2+zc6RFrwmnOil0ic2VPRphwNCWDb8dDal8p5wuXM+PttJ0b5UOtMPImeLRlLm1ydVHengMcbkTUpw93sgTGlHC8L4d8s+nmIt4nEYcl2Z138jWIHmvnJHgwAYSN2Y+pcCu3OLK/TXAg9gqV+zMK66ot4qx6mwSY4jxEnyVyYBhLv1vfrhp4i15FkTYhJ+5Rdn12tuF9SOn+Bh+swQPS5UqN7sABn42cz2lraLsiPJlvOFsyk/EXEMBsLE/oY+xmGgHEEcD+u8XCJdc61E/s8zlGZjK0cbSQzJ+k7zTxNW+7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q36lAEA9+OxrLtqJIvM0pok8wJwKm9GhWQN7iEs6dLI=;
 b=KqZE+B/B6Z05cbAou+zOmToQtypZ/5/6YiEGlvL3pEuJlbqcklfM/qLO8qi/BoH2i8luRJRq24bhGjRZzQAYKB/OeJ/gIu51bEGwN8PcLcD3y3OeLHrVd5DFONYhSaSA02XO9D+5iKW8/07KMlAo0t9XepiTjUm+ERhNwPfo/T8=
Received: from BL0PR11MB3201.namprd11.prod.outlook.com (2603:10b6:208:6b::21)
 by BL0PR11MB3250.namprd11.prod.outlook.com (2603:10b6:208:63::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Thu, 15 Apr
 2021 13:04:03 +0000
Received: from BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d]) by BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d%3]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 13:04:03 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lists@colorremedies.com" <lists@colorremedies.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Topic: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Index: AQHXMe+RUGJ6U8HHjEyOqMg0KcytCqq1f/jpgAAEO4CAAAI1gIAABVUA
Date:   Thu, 15 Apr 2021 13:04:03 +0000
Message-ID: <2967a7b509e72b604e144df1dbd504d203b9ba46.camel@intel.com>
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
x-ms-office365-filtering-correlation-id: 24b8fecf-14e3-4be5-4ad3-08d9000ef1b3
x-ms-traffictypediagnostic: BL0PR11MB3250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB325061B78A8E3C11E0B6704F904D9@BL0PR11MB3250.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HB9ZtbLT722wx7t0K5qXEmX6irKHkyHZt8RQs7T9SvcWs2bJgKh624FSnzGPzHR23xtJRrlHU/SK/or2izTVuktKE3QZsQmiM9mAJUgNGnvk0P4v5TBJuWYQ/i5Wp8ohd6nXsITCIwCul3bVbuezBfmJupGm6spcb8F8lHVRxB0S29hoem4i7i8kwaFKMuADiqTkq64Xu+78paFcMs8qbMI/voQ176F6gVJfArvlDtRl/cWY9z9uBa/kJF0Yk4Dy0tXvaPjN0Pko3JOP7uAGkU1M73aEZ2GDbuHd3H809KduiWKNwuj0d3OYIixY6yvYXX0IvDBxNPsEzi+Y+LhGbIactTHif0OVrYb3nFnEXyzWWaAH3sL629BMaZll7C2FFmZcd1pEdVlMfTHxYbZpyhjY447N/ZveRoWgQ8xaCwCUSt+gN6bmPp3JOFSG+PbdCMkiCImnRmt01d7rW39aNC3NCBws8bzFcNM8N7zC63g92+1a5cnsjmQkgN6LEY5gB82qFsnK2sWCqcwtVGMXvB9EqiXq8HYJqOz1BknSP9zHJknxUj4oJ7R0re93gqpDClYSThT2jgzpaicWML6SoUIW0eTOraVHqBNb11Caz8usQgSRV86PLtTGfRQtXpIz3DzaSRGS9OrGiLJ8Jz9/YBphEeQh4V1JekzAlPmSLyF792a7Uc4Y9/3/RBeFH21T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(396003)(136003)(71200400001)(2906002)(5660300002)(26005)(4744005)(478600001)(64756008)(54906003)(186003)(966005)(316002)(6916009)(66446008)(86362001)(8676002)(4326008)(2616005)(38100700002)(76116006)(66946007)(6506007)(66556008)(6486002)(66476007)(91956017)(122000001)(6512007)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?elo5a0hSL0oyM1dLb0lqY3lVYzVZdXpBSkl2TW5TeDM1R08wTWpra2JVbzBE?=
 =?utf-8?B?cHZnS1h2Nmo1Zmd3NDZ1VGlmRlRZVC9wOGI5WW1DQXpKR2E1WlFCRFJjYVJu?=
 =?utf-8?B?a3ZUK0xtaFFZeFRBQTAwaFJ2bnpZbXBKa3MyWWNQV2JFdlhPUjV3M3Q5c2hv?=
 =?utf-8?B?aFBnTHpwbnNRZE0yRVMyNTdIV1hsVDc3aXdlUkNnQmVpMEppTmtvMndkU0Vs?=
 =?utf-8?B?S2J2SUtBcmFQUUhyekg3aUY2dThtQ0dYVkg4SEp0Y0ZvNTdIOWN4d0J6RUdt?=
 =?utf-8?B?NmdIVzBFS0h5SUtsUkZCSDVPWXprcUE0ZUxEUDU4Q1U1YUxuazVMSEJMdjBz?=
 =?utf-8?B?R3NvUS9DV1ROTEdGTkp3bCtEOHpJZWtoZHhIV2J1S1B1dUNjMHRxVzBNeVZZ?=
 =?utf-8?B?Wm0zRS9QVmdDOFVia0M4RHEvK1F1OWNid3lrcU1SY3U5YnkySXpwbjh1NTFG?=
 =?utf-8?B?Vkx5TlN0OUdPbVp5WndmcVcxUnpyLytGaHFkcytuU2FSOVczTklvMzRIajRY?=
 =?utf-8?B?L0Y4aVU3Q3UrSGpINU0vVnNrVWxEWnQ3ZFBLZk1ueTFVMWo2NDNHSlNkQ1dE?=
 =?utf-8?B?M1JaYUdZTC9Kbm9zQytEd3BJYjJIeTJYRW9Pd3haaU1RNS9qek1qQ0VabC9i?=
 =?utf-8?B?ellTVzM4UHEweTVBaDc4Yll6TFBDeTg2N2s0YTh1dXVjQWxJM0EwSkE0OFdj?=
 =?utf-8?B?bGFMa1VhNU1oVVRmcjZnTG5WWTBHS0VGWmpUN0p6TFRmZFEwSDRwRXNuUVlJ?=
 =?utf-8?B?bnhlOUVHWWNwN2V0SUx2Z2UvZ1FDM2xkbFMzaXhkZkFJamFVYjlBSXN1UDgx?=
 =?utf-8?B?bm92a1pMOXNDU1kzYTl4V1lJTk42NTlHREVTMTN5K2NyQWtGMWpGenBWREd5?=
 =?utf-8?B?RDBHcGpmMGx1NU1ET1hoeE9mbWRTU3JFaThZN2pNQkoySGkvRE84OXhUajEz?=
 =?utf-8?B?eXB6Y2hLVWFUdjRkRk45Ynp3TFAwVlZBUVlPU09ZWjJsQWg5ak13dWMyK3lN?=
 =?utf-8?B?NFVoUjBnOTBFbVV3V1lsSU14MTNCZXZoQ1B1QzhQMmhIMkc5ZzBhMWprSExW?=
 =?utf-8?B?bi9OMDJZZzg3UFh4TkFST0s2aTAzNXpkdEFrcmRmcStuc3BzVVZMdzAwUjN5?=
 =?utf-8?B?R1NpOUZNSVFwSUFadW5ieEFCcHVVdnBJUlNJOXpNbzhyeXhFT3R2UFpUeXlB?=
 =?utf-8?B?b2h1eHlvcVRJVnJ4WVhaRitUbFROTkhoSy9nMW5DQUZsVFdtWStwbkQ4MlRw?=
 =?utf-8?B?ZjRCVzc2SW44WXhGeTlhWEJkRzJLNUtCWjN1RlNHVmVoa2hCcWlaWllIc3dC?=
 =?utf-8?B?M09lbGtwUTlqbC84enNXVEx5R3RkU2VkWXNBVVhyeGJibm5sdCtRVm5sRDcr?=
 =?utf-8?B?dmZxWGxJUm9yeXhaZytkYnAxUEY3ZWMxeXFwOURWQnQ5T05FWDBlMkpxYkYz?=
 =?utf-8?B?cFhTMko1NllvT0lsN0JqQnF5dG4wUFNxKzdNK3ZHWmxMM2FOUEFkMmltOC9O?=
 =?utf-8?B?SXFrd2Ezb050cEVrVzg2eEZzMkNTQWRFeXR2QVdMVlZNdk9RNjlNKzdTNmZo?=
 =?utf-8?B?QWdnTGlXVUVVM2RWbWx6a0VoUG50dlM2bTJXeE4vL1dSQS84R1dBMzRNSlpx?=
 =?utf-8?B?bnRTR2ZXb0ZHR2hseFdmaHV4cW1sdWliRDI3ZTltZjBSRUQxU0VLdk1UWHFm?=
 =?utf-8?B?azZySElIWW9ieUZiRnhyTVpyWW5mL0ozcEFycWNZd214UHRmUXUwdDRwK05k?=
 =?utf-8?B?Nkowa3RaNmRPeWJjTVlLREhXTzF2ZFZRbWNyR2xHWWxMcUk3YXArK3dsZXlK?=
 =?utf-8?B?aUxEQW85YjdscTJuUTdsUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87811B3CF2EAA843B3994B114A0DE254@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b8fecf-14e3-4be5-4ad3-08d9000ef1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 13:04:03.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFme1fHhrpedfdFI9fFpd11AyLCCSEJYStZ6SFsH8tQF7KVPQjblKNKQpuObyVkt7bC+ciVoN6ILWL8UktCDybeQtbUxcqfYFYURP0U200k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3250
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
ZXVlX2hjbWQoKSkgaXMgbm93aGVyZSBhcyBmYXIgYXMgSSBjYW4gdGVsbC4NCg0KUmlnaHQsIHNv
cnJ5LCBJIGNvbmZ1c2VkIHRoZSB0d28uDQoNCkluIHRoYXQgc2FtZSB0aHJlYWQgSm9oYW5uZXMg
c2VudCBhIHRoaXJkIHBhdGNoICh3aGljaCB3ZSBoYXZlIGluIG91cg0KaW50ZXJuYWwgdHJlZSku
ICBKb2hhbm5lcywgd2l0aCB5b3VyIHBhdGNoLCB0aGUgZ2VuMiB2ZXJzaW9uIGlzIGFsc28NCm5l
ZWRlZCByaWdodD8NCg0KS2FsbGUsIGNhbiB5b3UgdGFrZSB0aGF0IHBhdGNoIGRpcmVjdGx5IHRv
IHlvdXIgdHJlZT8gSSdsbCBhc3NpZ24gaXQgdG8NCnlvdSBpbiBwYXRjaHdvcmsuDQoNCkFuZCBJ
J2xsIHNlbmQgSm9oYW5uZXMnIHBhdGNoIG91dCBub3cgdG9vLg0KDQotLQ0KQ2hlZXJzLA0KTHVj
YS4NCg0K
