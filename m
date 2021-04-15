Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961AC3609A8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 14:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhDOMnj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 08:43:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:20893 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232786AbhDOMni (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 08:43:38 -0400
IronPort-SDR: 50cIF3FpR6MEQJxe+jvXii3a+pb+wPazEDiazdV4/zwxt+3ROFVt+UxufDwAm3YAhgrA6nGaYp
 WFFGr/iKHTXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="191653923"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="191653923"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 05:43:15 -0700
IronPort-SDR: yfvfRkv7mLEI3RxqrtBZ6hqvj+u5hI1QFO+q9EX+6pRSUv5fDp5DXt+MOeWFRuAm5IbosetVC9
 m77uSxmTOBaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="452897415"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2021 05:43:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 05:43:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 05:43:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 15 Apr 2021 05:43:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 15 Apr 2021 05:43:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBsiYyU10l3VXfSohoa8xYqkjCS4SHcaXX7v3/n804j11W6SK56+CuunlZOGiStrwbaxCnyJGC4lCeidBRsp+mraajc7+AKiBjMvjcLqMao/fJMHbG7HdHePX1iyGZNK6pgs7UfLFJ3858ID6fMhO3wJJG1GF6D6lj5qB5qBH1PxRmesEhmKbnMN87A2lnwds/vX0FF4s3iM5EdR//fAJccpCu9N7sipE04x8pTAlqck5z9DIn8KT11lqUHbs+8OjOH77a9F9/wj8euRYpZtFi36OdQd71+jeE1qOWRE3GRDEsvD0US1p7hrLa7UdFvVOGr7bkmfMuXaS7upWSjlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkqdO3IHlcieFaOLIhWhyUqDFifNHu7udQBpw2t3WWs=;
 b=mRidvSeCEo/Ax8DNYMXSJp21eYjgbZpLBxTKEh7V/ptze8iEANm2nf59O+qPZcOP+abDo0BhpED3l6J5yE4qAU3eP15ltjUUHmQUsSYXiYfsDVIYNA3RKVOBWwqlsn7EV/0zVlSmeXMqyan36ILQa964boUygobhTCLtzM/020nRzlYn3DJn/Y8HLSCELqygqrfXyktacQVIiV8SijqTj8zdL74glXIng2zOSdi7xryePQgUzW5cVQafRhp35ktIoslZwwQ+0L62kAW7XgNFA1t4GUEm/YjI8LfBSHcVo8l3cmvJv34C6VIYW5Pmy9lLAU6f9UwxIUDur7SNFxbiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkqdO3IHlcieFaOLIhWhyUqDFifNHu7udQBpw2t3WWs=;
 b=XTl8u7r7dz2Wnujambw8/aw3M07BWSDGkZ0WAZ0MZWPptzpwzfYWhAEBpMLrrkTT90h1SNNOaOZ3/EA7L46Yjh3sJhYxS+wMnVH/uQ5jSpsBXn+JTU6cG6sVCqG0kIQDSB2Q7lrvOldS0Gh5QOR+gJXokeBRFVv39BsVZo/7b9Y=
Received: from BL0PR11MB3201.namprd11.prod.outlook.com (2603:10b6:208:6b::21)
 by MN2PR11MB4445.namprd11.prod.outlook.com (2603:10b6:208:18a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 12:43:12 +0000
Received: from BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d]) by BL0PR11MB3201.namprd11.prod.outlook.com
 ([fe80::5848:fb22:4ea8:9a8d%3]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 12:43:12 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lists@colorremedies.com" <lists@colorremedies.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Topic: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
Thread-Index: AQHXMe+RUGJ6U8HHjEyOqMg0KcytCqq1f/jpgAAEO4CAAABBgIAAAXaA
Date:   Thu, 15 Apr 2021 12:43:12 +0000
Message-ID: <47f46e1f5ef6f32bc99d0da4c8d9b9438f6facaa.camel@intel.com>
References: <20210415120447.4424-1-hdegoede@redhat.com>
         (sfid-20210415_140503_625209_839D9098)
 <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
         <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
         <3a0ee5f64003b6d76f2eeae3c62cf73ee9cc03d1.camel@sipsolutions.net>
In-Reply-To: <3a0ee5f64003b6d76f2eeae3c62cf73ee9cc03d1.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20e1319f-ad23-4aac-b096-08d9000c080f
x-ms-traffictypediagnostic: MN2PR11MB4445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4445A0706CF1C6803CF66AED904D9@MN2PR11MB4445.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nENI/Z73r9fALKlXAsGC8joJlwVvH5MN9OFx7IvleJxIWo7XLnqZG7hz6LFK1RssvNjJFTRf0mxicjUhzg5t/0XijSTFBXmjyQSh52YbXrq4FHzIa76K08CJ49rNI474Kz6W546EmQ5Ii32u5FQpFWO7mdqA9ikhrh0fSLCbiRYPkPW+DFtvkrGCw/TyOiL2ophhe3NQMKUws25ZgWcqvnFibO/iYbxA0usIPIZP10FI9rCgX5BxsBDqWgQBf0AtgmOrWY0ecx9sTsnITCmNm7BESQQl8trFrMTCR8d0MkdeLerxERq2QxV/+CLp2NbRQ3ENQ3Wk5FZznDTNIKrrBmMv61rBi0WpLTEy7MuPYPNaeWVRSX9ejXAgEM0Vp8RTAU6ghD1vvf+zq4hNu8PEmSa1gQ4ngwsKwPq9r6xtYAnV6O+RF7PkNXvSRattQ/VJHEm+mW3rBSQ30hbNwFx++YG4Pry8UI9oAOKs8EiZahs+eSZTEdGWaIqoEaOkvjrKucSY6KYjEKe98NbtoWc9BW6Xa26yVWMvlZHW8fkIC6Za0isIJJLlg8KPWZCGnoUpH10/kQhJIku8XLKqVbuNs6piAi7BIbIkrpVqE35LTl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(366004)(376002)(8936002)(64756008)(8676002)(66476007)(4744005)(478600001)(66946007)(66556008)(86362001)(2616005)(76116006)(38100700002)(186003)(110136005)(6512007)(54906003)(91956017)(26005)(2906002)(6506007)(6636002)(6486002)(36756003)(66446008)(71200400001)(122000001)(5660300002)(4326008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?KzdGNlAwRE5oSTAwR09EL3FFOEcrQ0VibkpYUWVycGJsVVMzckN3ZFV3YkR5?=
 =?utf-8?B?cU1HVzFSSG9nWjEyN0JIVWRjbUszMVZBWVQvN0dkb3hXM0kwSDNlVW5SdUR5?=
 =?utf-8?B?OHhjaStIMW56RE9PdXJINzhDMVBuUXlKUXBuTHJaemQrZGRDQitINlkxUzBu?=
 =?utf-8?B?WGhxemhPc3JsckVRV2NDNWlMMlB4QThEQSt4RXJUVTVMankwK3p6V3NrQnhQ?=
 =?utf-8?B?Ym5hbFppZTFreUxOall0elZUN09sanZDTDhDZVRyLzNSTENoUHNpUytjM2ZO?=
 =?utf-8?B?ZE4xbmJpc080WVpUOHEyU2IzaklSZks1NnAvNHpDbUU1ZWV4WVVUdldaMk50?=
 =?utf-8?B?dkJOeUlsSFVwMUQyOFVpN3pEblFuSU4wYU5OeFEyMmtDTm56emdDUUpSRVpr?=
 =?utf-8?B?aG8zdFJlcm1nWDcyRzFFV0FZTjJBRHltWnBndmRwZTZ2MGdVMkU3ajhPZStn?=
 =?utf-8?B?UGhiUWNQU3BPY1N0NUxOZDY0R1JOYjVLYUFxeWk3U05DekFRQkhLend1WHNm?=
 =?utf-8?B?Vm40bkR5TFdZT200ZHdycU1RSlVRM2p4MDJuTlQyVkdqYkpIQVNIakliSnQz?=
 =?utf-8?B?bHVCWGJHd1R1Y3V0SDJmamd3ZXdqY2wwOC9oa0I4U2hWZkpZY0ZyL1lSaW5N?=
 =?utf-8?B?SUl5NWw4MkxpR0xWcERNcVhUYVozUEVHZTZ1MFQ1NXNpMFptYkErdC9UY3Ny?=
 =?utf-8?B?MHhKU0ozNXFHcHFqTk5sMTRWRVUzSzU2QllTdVJzRFZVTlZDTjdISXNMencv?=
 =?utf-8?B?MTRFcnhIVVg1MUh3cjZhKzJQVXpzWGJYZGZQbzRWZjBrdjZXQWdvT0ZOS2xM?=
 =?utf-8?B?TUhRZkkvMnRZbVg0LzNsWmc4UzFSL09rMHM5anN5UkREVWlFbmxpYk1PS1Rn?=
 =?utf-8?B?MUNHRWpZem10TFhkcVJnWTVZanBWV2U2aC9EYmFTT0ljaHBJTWEvVkVXbGZp?=
 =?utf-8?B?ZllHZ3kvK3hGM21yM1IxSzZYOVFXT3ZLejl6V2VnRGlPQnBjRHJlYUYrb0to?=
 =?utf-8?B?a1FRWkJiYnNoTnBZU1RGMTFieUI0WVVCdHVJL3BKRE53WnV4NVlKUTE0aUl4?=
 =?utf-8?B?UHgxRi81TGZsREJhWkY0YS9EdlF5VzZrbEw4WmVSSlZvaVdkTDlIcG1JUTBF?=
 =?utf-8?B?czdiL0ljTTFEVmpsN1FreEVCMWhES01qSitJTXM5S3QrNEV1K0N0bE1YaVFU?=
 =?utf-8?B?L2hRWDJraG1ISE1lRHBuakJhVmZyOFdrdC9kL0JHT0FlUUFMbDRwS1dSUXdq?=
 =?utf-8?B?OVZxUFB3a2NXdWtSVHlady9HbUpIVTdEdXpqaCtiRXJkbnM5bmxROUJ6bjJ2?=
 =?utf-8?B?cHpQb3U3c3U2bjNFK1grbHF0SzZFKzJUVnI5S2lwV1FVMTJPSTVCeDNpZVVi?=
 =?utf-8?B?R2ZBUzFQbmVuVk9xWXZFY3pmY2QzNWhCNWFjckVzWElmWmpLSExJRUNsYVla?=
 =?utf-8?B?UlpBMVB1UFZXclp3b1VKNVpUUkt1ZDRZYUFjTU9MY1Izb0YwUFdwMFQxT2hO?=
 =?utf-8?B?STVXNDdUSmFYYVBhR0tTOWFhei8wUU9hb1k3SkE5UTY5U3JmZFFldzlXUjlE?=
 =?utf-8?B?OGFDRVMraU5KUGRrSXRrTzl5dStialVHMXJRdlN4YVpmMVJ6bHhtTTMwTFEz?=
 =?utf-8?B?eE5EMU9YR0x4RDNVbWtRN0pyTmcxM25oUG9hckY3TGczSUtBVXB5L0p3dkRz?=
 =?utf-8?B?clBISDdPVDV4T0YyVnVoK2JaZTlrK2ZBbnNQMUhQa1VnOENpeEI5Y3ZsUWVC?=
 =?utf-8?B?NzJKL3llbmdZQnV0U1Y0cE9FZTgwTXJxVGpsWFZNZkJ6T1VXS2kzS0tCZmdR?=
 =?utf-8?B?QWJxdlgyMzRteU0ySDQvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD8F2863EEAA864AB34542D846380441@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e1319f-ad23-4aac-b096-08d9000c080f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 12:43:12.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4I2bARj7vqYNpmpkZnHrHfqK5xz3D9ozMSCAAmytHiIFiXzNMB+c9IAeBdArefoS21OODWDKTaC94ZugPJsCC6P7BaNvsjXM6nmAC9Zcg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4445
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDE0OjM3ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjEtMDQtMTUgYXQgMTI6MzcgKzAwMDAsIENvZWxobywgTHVjaWFubyB3cm90
ZToNCj4gPiANCj4gPiA+IEkgYWxzbyBoYWQgYW5vdGhlciBmaXggaW4gdGhpcyBhcmVhIHRvby4N
Cj4gPiANCj4gPiBZb3VyIHBhdGNoIHdhcyBub3Qgc2VudCBvdXQgeWV0LiAgSXMgdGhpcyBzZXJp
b3VzIGVub3VnaCB0byBqdXN0aWZ5DQo+ID4gdHJ5aW5nIHRvIGdldCBpdCBpbnRvIDUuMTIgc28g
bGF0ZSBpbiB0aGUgc2VyaWVzPyBNYXliZSBpdCBtYWtlcyBtb3JlDQo+ID4gc2Vuc2UgdG8gd2Fp
dCBmb3Igc3RhYmxlLi4uDQo+IA0KPiBJdCAqaXMqIHByZXR0eSBzZXJpb3VzLCBhbmQgZ2l2ZW4g
dGhhdCBMaW51cyBpcyBjb250ZW1wbGF0aW5nIHJjOCBJJ2QNCj4gcHJvYmFibHkgc2F5IHdlIGNv
dWxkIHRyeT8NCg0KT2theSwgSSdsbCBzZW5kIGl0IG91dCBub3cgYW5kIHdlIGNhbiB0cnkgdG8g
dGFrZSBpdCBmb3J3YXJkLiAgS2FsbGUsDQppcyB0aGF0IG9rYXkgd2l0aCB5b3U/IEFzIHVzdWFs
LCB0aGlzIGlzIGZvciBmaXhlcyBhbmQgc2hvdWxkIGdvDQpkaXJlY3RseSB0byB5b3VyIHRyZWUu
DQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
