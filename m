Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A0624331
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKJN23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 08:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKJN2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 08:28:21 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B571F13
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 05:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668086897; x=1699622897;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=8EdvyfKLFdko6GXPkbVBsZ9+X+jYtE4lumiNLG98hlU=;
  b=iJSTaPj3wrVz0b6UdFexwE5cHBkXigzgFIx1t5oYtRHQ4RdAL65bHVoa
   yM/3/UtAw2KG2Xsd15WXw6ruJqGfgeBmYO4w3VoCnq/mHFOf3ukrR7zqC
   5KDXKeEUVjs0+FOJ+nt3Tem6DwSmQsjlfY03sp8hFKsDvhv/HwYqmNLmj
   doNC/tPYGyvw+X6nymiHrZQEV+ub7y1oUlBcCc1jBZqmlVemCme6L0v7I
   mn8pjJgtOf2gAUclPsYY2bJlZkICjigchRPHf7OHY2DQuOCZQmkON5hJA
   uQQ/TuHBJf3+9WsWPTC/QHa5IRb+pEN3zC6bAEv1JjNKzDIyvmNfYmYz9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311306212"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="311306212"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 05:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="762280851"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="762280851"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2022 05:28:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 05:28:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 05:28:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 05:28:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 05:28:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB5E3nSHMxHFK7L8u/ztwWXT9pfFzEd6NoR6WJlUNOXMoQsgFFKtntb5IpgRXe8RYj7iHXmOidjxhJnqpiiL+KEAg/wCq2xzDdrECl/Z/CAFfsPGh+L+9O1jP3TxI7SEsAMnZth6qrIssOqzhtniOlyJtRZtPhNv39ZU7Jvf8K0WhUpRijFlBKk7FIfOnKcd28PV1AW5PYLQToepbaL8acb3TW3heqKYEGhh+EKC4aHaLYEX1g8EK2YaL5/f15qAPnDWo4foegBtS+axzT+RmW1neDwqXOVLwK3M81K145PuDdHpWzY2/NWPZkqEK9s0bKML8c58AraSTSEuL+lItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EdvyfKLFdko6GXPkbVBsZ9+X+jYtE4lumiNLG98hlU=;
 b=f8Sc1ytEM+l+6kO/Da79rMFgyBYBesw1/ClozqUGSEm0zRHOm4csTZ7lpXHuZNVt5ayMGujgkIxOpXl+d72epyfvtOLdx0o6th9sWJeN1Agfc1ed2Dh0SSNCRSx8NzMnFfYUV09KcwAFwSdPsbMIsVN1Qzsdqu6nKXZ2pOHvdCBHCzyIuuBOrGo7u+yViZcusad9nbnveiK3dzM4/yetzukJjF1P3zmreN4K5KLJBPQdWla2RgxqFcA0OwBYYyRQO1BOa7R1hlZ7KO0ZmJtDYSPQOmggRQzfMZTZvyeLrCDnnUkJ2Q3jTQ8rn8UIFvx/wYLKFThbDeR2vxXp86sWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 13:27:59 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b%9]) with mapi id 15.20.5791.022; Thu, 10 Nov 2022
 13:27:58 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-for-kalle-2022-11-06-v2
Thread-Topic: pull-request: iwlwifi-next-for-kalle-2022-11-06-v2
Thread-Index: AQHY9Qg/fd5vBZALYEil4vl5XR5orA==
Date:   Thu, 10 Nov 2022 13:27:58 +0000
Message-ID: <7af6d446bc64fc442e0d5f2c9d288e2c813b1504.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CO1PR11MB4769:EE_
x-ms-office365-filtering-correlation-id: 9950d14b-77d6-4a76-d8ac-08dac31f6256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5aO9+UNpEf7TNBjLImkooaGTbw1oCQ4QdhVxQA1Rm0RfyBv+gPDQc4p7WuRaykwdQTCG/1/8keFztcN+A5YLFU4wdWLVP4EXwvp1b9ZzFhX1GDL1/4XpDjwIiodoaf0bfIKn7WKSePmJ8Bv7g11SvvNh+UEkNuDF5/4SILLhXdoou0nPxggDlaiypwf+F4qCf8p+RdkWRftBxRxETldGEzqiE4QTXaOod2d+EiAsUgTXLK92tkJ2LEV7oWeASqMxkFgYPFizmS9u5y/WphsewUPzWriwTXqg9pquigYap72/QqTD7L4ffw/4ld8V07Uodn24IBTPTdQsSqPWuS6zgdCzn1ItPM3GhtDUM5ht0PJhv6xsMCuEAK7Exa33hOkz/xP4vPU8V/1166u4wvQK9aPhVHweHpI1IEIvY7RQTjmqHGOpvbwt7OgnsM38lV4cCf8LEwJ1En9xUFECe1CVv7yg4YijYOmwOmlPcMsU6tLv4WNmmCI3C50C9KsW17P7lBg3auLM5gFIKEFU4lM++FJCH7QsuFnEbhBk8iFU+z1ADjmoQUYCpt6rhNdo+0ClhFUQAQDJrgvTXAmIrVgIqOFKEYrzn9wXqJBO3QEoNM3AByq1axrarV/AhVnTKBf02k534/QPRgakUq2L0MSM3sU3zzPU3huXzj+qGwHbFmY7L0QlPOAxVmAunOjvuJEgNzmUhX6+Xv3LH3IaqFV2kRkEh855UgG1QlRREi/MKu5GjxzfpY+GfCSc4Hk/MDI5VKQba7Ba3lkTNj9mvjW7M0zwQNEz+bCZbRY8tmEohs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(38070700005)(36756003)(86362001)(82960400001)(6512007)(2906002)(6506007)(186003)(26005)(2616005)(4001150100001)(122000001)(83380400001)(64756008)(8676002)(71200400001)(6916009)(66556008)(66946007)(66446008)(316002)(38100700002)(966005)(8936002)(91956017)(76116006)(478600001)(4326008)(6486002)(41300700001)(66476007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFl2WHYzQUsvaTdidlZPNGxPd1hxT3gydm11bWQvOXN5eGtDMWo0NFFBMnN2?=
 =?utf-8?B?cXp5K2FpeVNpRXNEbVN4WFc5ZWpRQ2JMQ1hWeEJnZWVKcDRKeXVzUnE4cnBE?=
 =?utf-8?B?Z3gzTDg5MHBadVc4VHpxeWhHeWhSUGNRTGVRYlFFcWc2M3pGcFYybFBPNnZv?=
 =?utf-8?B?Y2RtYmdyN3dqa2pxMkpheUZrZEt4SmlodW4zeVhsREtsOFJYanBOeVhjbjMz?=
 =?utf-8?B?SmFESWthUnNRRXcwQnY2V1M3OE9hUlVpUE5pSU9ydjBrZEloYm1QV3c0NjVR?=
 =?utf-8?B?NysraHUrZEs1RXMyL0t1TEpwL1p5VW4xeFlQSEdVaDM1UGJ0YW85Vkxta3dY?=
 =?utf-8?B?NjBxQ3NGYTBSU3p1T1AvVmxPSDNaK0Z4YnlZa1Zsd1p6c0dvRU0xV2R6YUF3?=
 =?utf-8?B?WFUxSjkzQ0dmVllFQ2lNeUluOE8zNElqMDF0eUFBd2hxMmZUVitiQTlrNWY3?=
 =?utf-8?B?Q3QvSnZoUThTSnpZR3JiSFgwQldSdUVxTjRnVm1Va0JWV01JVWw5emo3Qmh5?=
 =?utf-8?B?KzhpVThxZWVKOGl6UjFjUVI4VzljejRxdDFjNlVuSmo4bVAwNi9NcnQrRW5R?=
 =?utf-8?B?TEZkZ2VXWCthb05UL0R0QVhWQ2tXM0cwSnpKejFrMHY3MjM2TWU0VWRoTUZK?=
 =?utf-8?B?SU5nKzQ1SlVQZ1hDWDlja0ZWMFJjZEQxVVM1Rkh1SXpNeXREUUM3WDZkcXBI?=
 =?utf-8?B?TEhCK1h2eFZWZE81cXlFY3g1QllnWS9iYVZuT2JxTkRXQzYzS1RDVXQwOGlm?=
 =?utf-8?B?MlBJVXZyRXBqbzdHcDJPMmliZjJZZHNrVXExc0crdFAyaTJwN1hGa1U5MjFu?=
 =?utf-8?B?K2h1MXJNUzhlYzUzU1N2OGJ4ZmJWekd3eS9pNUhjR1dlMG1vQjBZNkVXZ2VX?=
 =?utf-8?B?aGF4SE5Hbm9aMkhyYXdnUFdlYUJUTmhBczY0K0doRDIrT3RoZmtBZU5NVXVO?=
 =?utf-8?B?dEw5cFJMQmZQeUlZaE9lOEdERkxka2NxUHpYc0VzQzIwZG5Cb1FYNmRIcmhL?=
 =?utf-8?B?RHF4S09BbVhzeTJOR0NibERzckd2ckNBR0w0M2NjTkxJSXk1ZlZjRXQ2NHhn?=
 =?utf-8?B?NjcvaStaUVY2SkNDUDJJUk9hUW1QYlFKQ2RNVjlwS0REYzl0N1owUm4xV29V?=
 =?utf-8?B?S1BTbk9mb3c2Wm1remw4Q1pGSFpvRUMwRmJDTVU0REIzL3U2RkN2dWpPU3Zv?=
 =?utf-8?B?cjNmZ3NwYndlcnkrZFFHZWg1WnBUd2dxUWhBUlA2WlpiSGw0OWdvM0k3WUNO?=
 =?utf-8?B?NHlwZ0hLRzJUeUpmS2dIMDB1ekFsc3hIT2dtd2VvWWhOc0ZrdkdYRHMxQWht?=
 =?utf-8?B?VDhOZ1IrWHNRZGV3anRwMjNmZmpJcHl4cWMvMldZcDR1cGh6U1puMDZFMFA5?=
 =?utf-8?B?cTVxNUJHL2Zlb2dNUTlqbjBPOFJjczJqTGRhVTB1clI0UFR5UEtMYldkNWlh?=
 =?utf-8?B?cmRIbkl4NGwyeG5xY3BULzdlczRnWkczdjdjR0t5cTlxRUErT1dSYnBGZGVW?=
 =?utf-8?B?VDZNMGNXblRMSG5mQm1hZ1Z1V1FhcDlCUm8xbVdYMHlwMnFaT1FFbEtkRE1l?=
 =?utf-8?B?WVhMd0VHMG0xSDF4V1o2NWZ6SFNURk5pT0VzcXFXUEErc21IZFJza0xJN2JR?=
 =?utf-8?B?cFZ3clA5WDRkanFTSlNHa0U1UXlnRitxWjFPMnJiWE40RmJQRVp3SzF4eURE?=
 =?utf-8?B?bmZLYXFSeWV1bnM4cVY3bDlESnBkZ1ZWZkFFQnpsdnFhc3duVHVLbEtYNWRa?=
 =?utf-8?B?RDlNZFRrVWZndTY1S0NrVklGSVVjbGl5Z2Zmc2FOTDVpZTZRS3NHaVlSV0VC?=
 =?utf-8?B?WVI0Z0pudmhDWUJna3ZLcDArL2JEcGNPd3J1Z1R5d2J4Z2I4cFJ5U1kxTFJw?=
 =?utf-8?B?MGpibUhxRFZqUU5rTnR1ZldEKzJtc0xaU01NZWhqRVR4K3dMN1JXMytqY256?=
 =?utf-8?B?ekxnVzNpM3FTVkFRYzJjRU5rMG5qOTlOWUNrZ1dTNjVsSUE0cEs3cUxUWUpT?=
 =?utf-8?B?NThsZnd6UGl0ZWR5cDBwa0tGTkdLdnl1UlArbWRpUmphYWg0SHd5SlM4bjVC?=
 =?utf-8?B?VUVDWFFCK1VjK24vb0kybUg1OHFmRzk0VGRjZm41cUpOL3dFdnJQWXRFMWlt?=
 =?utf-8?B?MC85VXVWQ2p2aGE0TlM3VHEzcVpVdVcvUmI0a3ZIQTRNY3FyVWkzcTVzZC9S?=
 =?utf-8?Q?QlZi0xSdC0R5d8J8WUG3/YA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1206AC1D3008C84AA5AD259ECB39A129@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9950d14b-77d6-4a76-d8ac-08dac31f6256
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 13:27:58.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdiCmpFWLuqVnm/EPc+uCTXs9gI79om9OKt+cWNt4fNzZL+24lYdfyrJq99kFV5b9yZn15PS7nE1ilISBzAbS434gKuuYvUdPVzj4m11xdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCkhlcmUncyB0aGUgZml4ZWQgcHVsbCByZXF1ZXN0IGZvciB2Ni4yIHdpdGgg
dGhlIGxhc3QgdHdvIHBhdGNoc2V0cyBJIHNlbnQuDQoNCkl0IGNvbnRhaW5zIGJ1Z2ZpeGVzICht
b3N0bHkgbWVpKSBhbmQgY2xlYW51cHMuDQpJIHB1dCBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIGNv
bnRlbnRzIGluIHRoZSB0YWcgZGVzY3JpcHRpb24uDQpUaGUgc2Vjb25kIHBhdGNoc2V0IGRlcGVu
ZHMgb24gdGhlIGZpcnN0IG9uZS4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBh
bnkgaXNzdWVzLg0KDQpUaGFua3MsDQpHcmVnb3J5DQoNCndhcm5pbmc6IHJlZGlyZWN0aW5nIHRv
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkv
aXdsd2lmaS1uZXh0LmdpdC8NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYmQ5
NTRhN2U0YWEwNzM5NjMwODg0ZmM1NzJkMmQwZTRkY2QxNmUyNToNCg0KICB3aWZpOiBydGw4eHh4
dTogVXNlIGRldl8qIGluc3RlYWQgb2YgcHJfaW5mbyAoMjAyMi0xMS0wNCAxMzowMTozNSArMDIw
MCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3bHdpZmkt
bmV4dC5naXQgdGFncy9pd2x3aWZpLW5leHQtZm9yLWthbGxlLTIwMjItMTEtMDYtdjINCg0KZm9y
IHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGIwYjliODA1OTlhMzBlZTg4NjJjMDI5NGI4YTNi
NjljOWM2ZGY0Zjk6DQoNCiAgd2lmaTogaXdsd2lmaTogbWVpOiB3YWl0IGZvciB0aGUgbWFjIHRv
IHN0b3Agb24gc3VzcGVuZCAoMjAyMi0xMS0xMCAxMzoyNzoxMSArMDIwMCkNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
aXdsd2lmaSBwYXRjaGVzIGludGVuZGVkIGZvciB2Ni4yDQoNCiogaXdsbWVpIGZpeGVzDQoqIERl
YnVnIG1lY2hhbmlzbSB1cGRhdGUgZm9yIG5ldyBkZXZpY2VzIChCWikNCiogQ2hlY2tzdW0gb2Zm
bG9hZCBmaXggZm9yIHRoZSBuZXcgZGV2aWNlcyAoQlopDQoqIEEgZmV3IHJhdGUgc2NhbGUgZml4
ZXMgYW5kIGNsZWFudXBzDQoqIEEgZml4IGZvciBpd2x3aWZpIGRlYnVnIG1lY2hhbmlzbQ0KKiBT
dGFydCBvZiBNTE8gcHJlcGFyYXRpb25zIC0gc3VwcG9ydGluZyBuZXcga2V5IEFQSQ0KDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpBdnJhaGFtIFN0ZXJuICg3KToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogc2VuZCBU
S0lQIGNvbm5lY3Rpb24gc3RhdHVzIHRvIGNzbWUNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1laTog
bWFrZSBzdXJlIG93bmVyc2hpcCBjb25maXJtZWQgbWVzc2FnZSBpcyBzZW50DQogICAgICB3aWZp
OiBpd2x3aWZpOiBtZWk6IGF2b2lkIGJsb2NraW5nIHNhcCBtZXNzYWdlcyBoYW5kbGluZyBkdWUg
dG8gcnRubCBsb2NrDQogICAgICB3aWZpOiBpd2x3aWZpOiBtZWk6IGltcGxlbWVudCBQTERSIGZs
b3cNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1laTogdXNlIHdhaXRfZXZlbnRfdGltZW91dCgpIHJl
dHVybiB2YWx1ZQ0KICAgICAgd2lmaTogaXdsd2lmaTogaXdsbWVpOiByZXBvcnQgZGlzY29ubmVj
dGlvbiBhcyB0ZW1wb3JhcnkNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1laTogd2FpdCBmb3IgdGhl
IG1hYyB0byBzdG9wIG9uIHN1c3BlbmQNCg0KRW1tYW51ZWwgR3J1bWJhY2ggKDIpOg0KICAgICAg
d2lmaTogaXdsd2lmaTogbWVpOiBkb24ndCBzZW5kIFNBUCBjb21tYW5kcyBpZiBBTVQgaXMgZGlz
YWJsZWQNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1laTogZml4IHR4IERIQ1AgcGFja2V0IGZvciBk
ZXZpY2VzIHdpdGggbmV3IFR4IEFQSQ0KDQpJbGFuIFBlZXIgKDEpOg0KICAgICAgd2lmaTogaXds
d2lmaTogbXZtOiBGaXggZ2V0dGluZyB0aGUgbG93ZXN0IHJhdGUNCg0KSm9oYW5uZXMgQmVyZyAo
Myk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtZWk6IGZpeCBwb3RlbnRpYWwgTlVMTC1wdHIgZGVy
ZWYgYWZ0ZXIgY2xvbmUNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogdXNlIG9sZCBjaGVja3N1
bSBmb3IgQnogQS1zdGVwDQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IHN1cHBvcnQgbmV3IGtl
eSBBUEkNCg0KTHVjYSBDb2VsaG8gKDIpOg0KICAgICAgd2lmaTogaXdsd2lmaTogY2ZnOiBkaXNh
YmxlIFNUQkMgZm9yIEJMIHN0ZXAgQSBkZXZpY2VzDQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06
IHByaW50IGFuIGVycm9yIGluc3RlYWQgb2YgYSB3YXJuaW5nIG9uIGludmFsaWQgcmF0ZQ0KDQpS
b3RlbSBTYWFkbyAoMik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBkYmc6IGFkZCBzdXBwb3J0IGZv
ciBEQkdDNCBvbiBCWiBmYW1pbHkgYW5kIGFib3ZlDQogICAgICB3aWZpOiBpd2x3aWZpOiBkYmc6
IHVzZSBiaXQgb2YgRFJBTSBhbGxvYyBJRCB0byBzdG9yZSBmYWlsZWQgYWxsb2NzDQoNCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy8yMjAwMC5jICAgICAgIHwgIDM2ICsr
KysrKysrKysrKysrKysrKy0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZncvYXBpL2RhdGFwYXRoLmggfCAgNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1k
YmctdGx2LmMgICAgIHwgICA3ICsrKy0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9pd2wtcHJwaC5oICAgICAgICB8ICAgNCArKysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL21laS9pd2wtbWVpLmggICAgIHwgIDMwICsrKysrKysrKysrKysrKystLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL21haW4uYyAgICAgICAgfCAz
MDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9uZXQu
YyAgICAgICAgIHwgIDEwICsrKystLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbWVpL3NhcC5oICAgICAgICAgfCAgNTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vTWFrZWZpbGUgICAg
ICB8ICAgMSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZGVidWdm
cy5jICAgICB8ICAgNCArLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS9mdy5jICAgICAgICAgIHwgICA5ICsrKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvbXZtL21hYy1jdHh0LmMgICAgfCAgNjAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4
MDIxMS5jICAgIHwgIDIzICsrKysrKysrKysrKy0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vbWxkLWtleS5jICAgICB8IDIyNiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaCAgICAgICAgIHwgIDE5
ICsrKysrKysrKystLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL29w
cy5jICAgICAgICAgfCAgIDMgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS9yeG1xLmMgICAgICAgIHwgICA4ICsrKy0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vc3RhLmMgICAgICAgICB8ICAgMyArKw0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R4LmMgICAgICAgICAgfCAgMTUgKysrKysrKy0tDQogMTkg
ZmlsZXMgY2hhbmdlZCwgNzczIGluc2VydGlvbnMoKyksIDEyMSBkZWxldGlvbnMoLSkNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWxk
LWtleS5jDQo=
