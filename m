Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A648C10D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 10:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352077AbiALJeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 04:34:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:57455 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238079AbiALJeC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 04:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641980042; x=1673516042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=goUtyr4hVPvYSr4jOvUQ3z9dc26EJbOcJI+6yVRYMCA=;
  b=WgGu7JuLB/D6I/x2wrGssmoA28OkhiQxaT+kgrBFP4aLKncL6W/ZISgz
   Aq/jyJWmVRS85d4XY6hrOFIezONQ9upSXzqGeLRbxPXRTZawW/k+AES7C
   65KIDXAlFO8LCWbaEaK5XGhwszEas9CdemDsbugkG01m8c7pA1rqw2f8i
   PFvs71cWpJ4T+aOMgd5jpOw5s/0VueQu6AYpZNkjvTBmmV8bYVgDETH3Q
   RgcDCmOPzFFWeifgly0VltAIuE5Kf+ckz5GodD6wGwWrqEdIX3EEBXAuS
   Hr6Uc7xO5MINTwKLCDioRSS/Rw9hXVIk729FGMJmV5LHz8mwY3pQ/+JkQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="307049007"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="307049007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:34:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="529101250"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 01:34:01 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 01:34:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 12 Jan 2022 01:34:01 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 12 Jan 2022 01:34:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdVVjHweO8YggGU0wQIlfnlU+2G3hsOfZLkW+JgdYf+CxU0PwG3U2LIHWtxwNCFleIXX19+5ae8OgRuKMdWaEWxN7Wknqb9r7jbUcSfMFxK3L0Nxsfmgme4I7d0JPvTzmi3ETJtS6ZBt8M2lYfUFz37E8rLoqG26YXfRgmw3cgtCpLmKZR165FxgyEMiOfoTpEX7/Ci8wxJ4/kjILwgLYO0O86Fr7Z6W6h6VEPh21BQlv2PmD29mGukUYXqu1acY6bdM8f/uc+949JwWLWoMYRbf6FcoD2eSkUOffaQj6gdtSVN1KbYoxDWa27XSB26ZsBzn0YHyfXAzJCXax3Y0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goUtyr4hVPvYSr4jOvUQ3z9dc26EJbOcJI+6yVRYMCA=;
 b=k62N7K2XV+ZrSoyuohXGIbRj9UO9NoZ8u2JLl7SlqiIpWRBUagHK/R9DysKiLLF67fKhPrz4UeIrpXPu0bXVYWDc3Dae0nzTu0qo1VGxKRZQNg1byaWgtvlFqJs6yaSzMnQQr/1Gw/eQ47Im1YU1Fyi+ZrVVNm64tKscBeevdTHBA3cp3RCYYLIVQm9nicS35iAgBJDpxHm6GBKVmzhSruPBIBmPHU8RWgSABdCV/r7mWV7Rw/P/1NLkvnIVnwFZDm/Yld73wcxfCLJROHiPDab0UOWojaPla7n2oV9YOjV0oEUV6I13wzbSHmpZYGt5avH9hny87JxZdwxXtTHJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2981.namprd11.prod.outlook.com (2603:10b6:a03:83::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 09:34:00 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:33:59 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Topic: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Index: AQHYB1Z1kfzr/0Efz0WQ7sMSiyR//KxfD8iAgAAIsQCAAAYOAIAAAdeA
Date:   Wed, 12 Jan 2022 09:33:59 +0000
Message-ID: <9644c62f580e30a2b7fc3d62b67db0b1e64872c7.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
         <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
         <ab9e48ae8dad3187d206d46fc1d997245ecbc3ef.camel@sipsolutions.net>
In-Reply-To: <ab9e48ae8dad3187d206d46fc1d997245ecbc3ef.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36066840-3322-4352-dc5b-08d9d5aea9d1
x-ms-traffictypediagnostic: BYAPR11MB2981:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2981B460DDE5AA3E4FDD5E2590529@BYAPR11MB2981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNRT8hhcBYaK2QtPM+c78i6h6O7S9qABByVFKlhQM2or1JcYPmUY7KV8TGn7Op3whBG9EqVx8qUpV8fVB196gTF5rQRUmeCPA/XknT/VoIM8PTJdbu98/C5AuFn5b9f4YtPMveFjNAbK7+Wws0HMw6xj96DRDY4CSIH5GkyYlVJTKVy1HOBa/JIxxRrXTjGdO86mL1mjUNhs7pUi1fjfDk+0zRRRzavirEIAFjL4DKp8fLMjxgTPuI+JBjHD7axOd1kPydZs0e7wXrZI/bP19/iMwh4tTCg3atiLgitnLVHiUwDIK5C+pn5JdPcUUbFO79XWQzhS18FRyndoI4CDuJDXNvWoRaNHxcPyxLLbY11QH8WNsjiXicdRRpATS1oyKIdclI5TH8r7Cw2im/7ZYra3ZxWXIQd2Cs/fLqrRAWZSRomEAGbmedAHztPOrr2qokfrdiS0tm21tkBl8v/EZl9zSY0ojrZrCcLK9H4Je5nd14cqtW42T++FoOgzsoBoyxp+PVH8Q2A8TVeGItw+cgyirNzgP+/tH9XWvSn+EEhLIx1llidsePtrG7R4R0gf/5TM2Nytf/7AW8GgqAFekbKRZm39jrsqABPSSjTO/nUMlOtF7Ub+2zGsPCw4q8pzK0H8yg5V1qSK3KMhH+mOs4gfeoMi3gy+fmgmRPnwC79eB6S+4cn0U4R80FpBYPHZtgJtnfxIBQ5n9C4UeJeGXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(508600001)(36756003)(71200400001)(38100700002)(110136005)(83380400001)(5660300002)(122000001)(316002)(6512007)(6486002)(76116006)(91956017)(186003)(26005)(86362001)(4326008)(2616005)(66446008)(8676002)(8936002)(2906002)(66946007)(66556008)(66476007)(64756008)(6506007)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlU4OC9SV1VCbEpUVlBSNUtMTGxYVW1xYnhsTEx1RklaR0pBUTYwSllRLzBt?=
 =?utf-8?B?UTZBditPMVVReXphdlJ1OWEyZjJobENOeDBMRWM4VlZEVXh2VFQ4Sm1LWkF6?=
 =?utf-8?B?NXBPN3RGZzQzYWIrdmt4S28vcHhsMGRTaXpJME4xMzZOOVdkak1NWEpqdi9U?=
 =?utf-8?B?NGJQVWtyeVRUV29aTStJZlVZUUdWeGc3SVNaR1NnekxQSG5meE9wZDc4b1ZG?=
 =?utf-8?B?MlUycmVERjFSZ3hYOUcwWjhLU1ZsSzA3Qk5HWDRpMG1OWldjZi9icTBVYWhX?=
 =?utf-8?B?c3VrMEtYL3lOa0FlUGlsUEJieXpDTlYzRk5xS1g1SDRycDRGb1N2S2J2WVV3?=
 =?utf-8?B?ZGphZEt3UHdYUGIrNDVONkJvY1BoaU9lakxJWGJFWFZiV0Jsc2JRV2l4bkxJ?=
 =?utf-8?B?a1k4K3Q2dW1UR0F5OFNnQ1pSUDd2aG0zd0lvZnN0MUJKbEh3S2NLTXBEUmJL?=
 =?utf-8?B?ejVRdldjSGZrbGRaaWcrZEttcGc5a0p5Q3ZNVUxoT2ZOZ3ZEOVVnZmEySWRP?=
 =?utf-8?B?Kzg1VmlDYUJ5dnlYVUhGRDR4YWRuRnVmTW9XeHM2TDA0b0U2WGhNNEFCTHNr?=
 =?utf-8?B?UGcxUGM4OEdxWS8xTHNYTWZyUzRHVlZOOE5VWENEaFMzNlVqT2FYSCszaDRw?=
 =?utf-8?B?UGZ0TmZlRDEwVXowMFZVR0hWVFE2d1dmVU04WWYvdktKWEZxbDNZMWVZMGZP?=
 =?utf-8?B?NFlSL1FiTEYyMGxIdHR2Q0t0b09qeTluSVRrY2tLZy9XU3ZEN1N4Q3pTV3ZY?=
 =?utf-8?B?MGpNVnZHYzZyaHF6c0wyajFKa1NmLzBtVXdPM1kyd3RRanlHSFlwMC8xZnBk?=
 =?utf-8?B?czZTUUREVzNveEFiL0ZlenN5RnAxVWk5ZkJWajdpUWdUOUtoMkoxeGlZWmRa?=
 =?utf-8?B?Ukg2dXV1ZE50U2NnUE03blBGTWZTQS9HS3dtd3lNc0U0TXJUc2Eyb1JEYXMz?=
 =?utf-8?B?a0JncUYzS3NkSC8xUWxtVlNBdUlDU1FldnlEWHFrS2dKcGtma3NMdkgvZ05z?=
 =?utf-8?B?TGpVa1YvbTI2S3U0VE1mbjVlN0NuVDJGY1ZiVVByQWZlTDMwNFFJUHhxWGVx?=
 =?utf-8?B?Y2YrUlQwcjhydDFOVmU5dTV0dnNCdEFybWZlcG9CZWdZTjNiM0o2c1RnTkZW?=
 =?utf-8?B?TmpWYWtiRVBaUDBJYW0yMEtBbU90RkgxRjd4aStEMkxlU3l3c2o4MVp5RU9x?=
 =?utf-8?B?SkRrT21qL3ZmNWErd1dOVyswdUYzeFdZRmdNWGwrT0E0bkFiV1RHM3R0REsz?=
 =?utf-8?B?UHAyMDMrN0FDZnB5RWE4ZUs1NDdtU1dzM0gzMUxleXdYZWtMMGJjTkZmUHl0?=
 =?utf-8?B?NHp1akxyWDB0cDhURjFnOG5FcTZ3NGRNOTRnWVpXNjRBeThZZTJJRGp5TG5t?=
 =?utf-8?B?K1pWSFVueEZQOGUvRVhFKzZtQmJ3RldoNU92M1Vza1hvbGNlUm1LcXdkbm9n?=
 =?utf-8?B?ako2VlJCRjgzcm1PY3lxOUdrZFFJT3Fjd0VkREJwSXIrcStTTFU2Y25CbzdQ?=
 =?utf-8?B?eGkvY09hMEpqWHpRemVZSCtBVzFiNE9JcW9SYTQ5cFN5Ulpab01OWldlVWVS?=
 =?utf-8?B?YURKZVVnaFdlWkcwRnp0cGZ4Z1Irckk1YzNxR3NCbTgzNTlrY0RrSkwwVjFu?=
 =?utf-8?B?QkJjSFFRc3NrSWdSK25IZS9CQXpNaGJwYUdxUXgzbDRQUmhnZWV2Ryt6QWRG?=
 =?utf-8?B?cE1FZlcyWU9UdWZwaE5zMXZLejZrYlc2ZHBOQ1B4VzZvK3UvcG9MLzVjaGFO?=
 =?utf-8?B?YWh5T25OSjVwZ3JtTTE3aDJxd1dGOElpWUJySTZPK3haVE9Ja2ZCZHBvUjNN?=
 =?utf-8?B?b2pjSGlvL3R0b0ZFdzB2Y0NmcmJXMnhsTU1uZC9wNlQwTm81Q0VqOEswbjV6?=
 =?utf-8?B?cm5rOCtOTW5hc1k4NytSVmxSL09UNHIvblU0Ky9YbGxJOWNhOGRKK3VpMWQy?=
 =?utf-8?B?czFCVDZBSlRPajJFRXRSOTkxcEdLOUZvWjZ4VGZjTEdNQkc1S24wVGlyWDgz?=
 =?utf-8?B?a1dEclk3ckxCSFpSMG1YMTBZU0VMTFV1T1MzNWpsMy8vVkJtazErdVhDdjA5?=
 =?utf-8?B?RmFHWWp0dE04ZnVyWkJmVEJNMkpqWXc3dGt4d3B3OXRLNTNCMThOQnlrU1Fj?=
 =?utf-8?B?WUFXd2RiaW12emhZODlWWGMwNnV0SHdJU2JiNVVWYTcwdjFhR0Jzd0syRkUv?=
 =?utf-8?B?QmM2dGVFN2YvZlU5RXlmM1lWTEVERTB6ZzZkNGZEOTg1QThXaDNZbWxUUkpV?=
 =?utf-8?Q?HfDqp+dqbVqBEpBDyuBTIrqC6zoicoZex1zjMtKgK4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3700740373516F4CAAE39350CE71A139@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36066840-3322-4352-dc5b-08d9d5aea9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:33:59.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNJyXw9v2YYbmdmOCOFs+Nm94GwjduUcvzKTsNWpyP9tjoVc7fsfyiNtpGL4jwk1+u0iGfiKFaGq1H2repPyLN0DIpfw/n54ddd9sDyOEqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTEyIGF0IDEwOjI3ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS9mdy5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9m
dy5jDQo+ID4gaW5kZXggODYzZmVjMTUwZTUzLi5mMTM4MjUxODUwOTQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZncuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmMNCj4gPiBAQCAtODM0
LDYgKzgzNCw5IEBAIHN0YXRpYyBpbnQgaXdsX212bV9zYXJfZ2VvX2luaXQoc3RydWN0IGl3bF9t
dm0NCj4gPiAqbXZtKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG9mZnNldG9mKHN0cnVjdA0KPiA+IGl3bF9nZW9fdHhfcG93ZXJfcHJvZmlsZXNfY21kX3Y0
LCBvcHMpICE9DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
b2Zmc2V0b2Yoc3RydWN0DQo+ID4gaXdsX2dlb190eF9wb3dlcl9wcm9maWxlc19jbWRfdjUsIG9w
cykpOw0KPiA+IMKgDQo+ID4gKyAgICAgICBpZiAoIWl3bF9zYXJfZ2VvX3N1cHBvcnQoJm12bS0+
ZndydCkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiArDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoC8qIHRoZSBvcHMgZmllbGQgaXMgYXQgdGhlIHNhbWUgc3BvdCBm
b3IgYWxsIHZlcnNpb25zLCBzbw0KPiA+IHNldCBpbiB2MSAqLw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqBjbWQudjEub3BzID0gY3B1X3RvX2xlMzIoSVdMX1BFUl9DSEFJTl9PRkZTRVRfU0VUX1RBQkxF
Uyk7DQo+IA0KPiBJIHdhcyBnb2luZyB0byBzYXkgaXQgc2hvdWxkIHByb2JhYmx5IHJldHVybiAw
LCBidXQgdGhlIGNhbGxlciBsb29rcw0KPiBhDQo+IGJpdCBmaXNoeSB0b28/DQo+IA0KPiDCoMKg
wqDCoMKgwqDCoMKgcmV0ID0gaXdsX212bV9zYXJfaW5pdChtdm0pOw0KPiDCoMKgwqDCoMKgwqDC
oMKgaWYgKHJldCA9PSAwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9
IGl3bF9tdm1fc2FyX2dlb19pbml0KG12bSk7DQo+IMKgwqDCoMKgwqDCoMKgwqBlbHNlIGlmIChy
ZXQgPCAwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyb3I7DQo+
IA0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gaXdsX212bV9zZ29tX2luaXQobXZtKTsNCj4gDQo+
IHNob3VsZCB0aGF0ICJlbHNlIiBiZSByZW1vdmVkPw0KDQpZZWFoLCBJIG5vdGljZWQgdGhlIHNh
bWUgdGhpbmcgd2hlbiBJIGNoZWNrZWQgdGhlIHJldHVybiB2YWx1ZS4uLiBJDQpkb24ndCB0aGlu
ayB3ZSB3YW50IHRvIGFib3J0IGV2ZXJ5dGhpbmcgaWYgU0FSIEdFTyBpbml0IGZhaWxlZCwgc28N
Cm1heWJlIHdlIHNob3VsZCBqdXN0IHJlbW92ZSB0aGUgcmV0dXJuIHZhbHVlIGZyb20gdGhlIGZ1
bmN0aW9uPw0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
