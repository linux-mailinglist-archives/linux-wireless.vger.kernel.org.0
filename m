Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A435B2FF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhDKKOa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 06:14:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:36258 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhDKKO3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 06:14:29 -0400
IronPort-SDR: JoGtqenVcvZPb1RbDARbJ1JrevDftfrMxUHex1xpHJ5BlqnGpsMic4fuMq95Z6D2UQrBqD+/Oo
 QteSR4ki0jbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="181141776"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="181141776"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 03:14:13 -0700
IronPort-SDR: FhUDt7/PvF+3itqvUinxspk9PxhfCmasspn5J5grPDTl/dz7n3qr+ZV6AvN5+CBJiImOWSNC+k
 hcWQodjssVJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="531536347"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2021 03:14:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 11 Apr 2021 03:14:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 11 Apr 2021 03:14:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 11 Apr 2021 03:14:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 11 Apr 2021 03:14:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkUQ8ysCzegk1kC5aBOsNna7Fhdh36NM8cIr/5z2t8Eg9/NbQzr3LfL0z2InAr7dZJaKOvrvss31GAtuJQAFTMgQ3c+EbzhMSoADKbpT/KItBE1gFEf1Pafq8sGIZz0YQ0ABEZTuZjMjCmy7yrY2FptGsBDxc8JcXHJpF0HmxD22o8YUNWBam72oka6W1hSxs0o8/Hf3AkqQp2iidORVl064VxkkWo/xlsjRi04TLLR6cbUzq/gEpk/1pzYgRoszsH9IH6O+COwabZjguKtg4YL1DHHTa9BbxG3siV9YE1L2BDcT3+4Xdgr3cnQrfgTi/ifX3kNMG7/d7TQENcHfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JcNP8+9aeVrRBDF3XkxUL6MdOIbsBdUxZSttLZur/U=;
 b=fcFWiNkIq1E8hYr63Dfsa/c1fsbqRo0TroKfDimACbXdu4wyH736djlaibfu8+mB80oYBIsnqjFGcB4xAq43dVgfsV3CHq2Vrst9iVY0kXKxeH9aK62G5D1xLV1ebUhCu6NacwlAKAf7gJlzfM6SBxKfENP2jJo7K7eYi/ePqLQ8S9RsGl/mxThhClBQ0o+tOR9YIZqunHDLAC/x1lfnqlXupcjiJXuWFH94QRkoGE7kXT1nJ1B0hAy+4WQt90ZKmE8eoZgLRKKAa7sR+338tWhLanE7Tu3Co4rawbLEP0SB/UTg7zym4gUy4wtA5/CUh6CGtbgdc5kAoeK9yYh6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JcNP8+9aeVrRBDF3XkxUL6MdOIbsBdUxZSttLZur/U=;
 b=ECwY9nTjE0NfbfzUHxlMQrItZNqegOA+ldsr1Xhhm6bgOCSMBL/pfFBFCmPBTFxfkWs7bl45UL5Sub5Z+lo/e0tpvvSpttggamBOMtVt6Q4C/nBIcg3yHrgXgtef7etuz3AADDESkZbOZDrlqT85TDu7xShgtHFnS9FpZfpa2ZI=
Received: from BN7PR11MB2610.namprd11.prod.outlook.com (2603:10b6:406:ab::31)
 by BN6PR11MB1572.namprd11.prod.outlook.com (2603:10b6:405:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 10:14:11 +0000
Received: from BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::5480:4536:4082:eae0]) by BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::5480:4536:4082:eae0%6]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 10:14:11 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Ben Greear <greearb@candelatech.com>, Luca Coelho <luca@coelho.fi>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
Thread-Topic: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
Thread-Index: AQHXJg5w+sLc3CukO06kSfTxTOYklaqd/7oAgBEn/cA=
Date:   Sun, 11 Apr 2021 10:14:11 +0000
Message-ID: <BN7PR11MB2610D9C80C698F837C3A2A55E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
References: <20210331091452.543321-1-luca@coelho.fi>
 <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
 <aa0dae40-1565-2bb0-b33f-0da82a8de137@candelatech.com>
In-Reply-To: <aa0dae40-1565-2bb0-b33f-0da82a8de137@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: candelatech.com; dkim=none (message not signed)
 header.d=none;candelatech.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [147.236.145.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef9bcdaf-231e-4632-78bb-08d8fcd28d35
x-ms-traffictypediagnostic: BN6PR11MB1572:
x-microsoft-antispam-prvs: <BN6PR11MB157274409D9C5EFCB0CFBBF0E9719@BN6PR11MB1572.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0o+3bbwdiq0LFuFlseMEHIa+5kojTYCU64yj6G/Xjja61HGOILf9J7iAYtTro3hhQp0YW3n3CpZCAESgoDq9IdMGRCZaya/c/TkMPMlyQp5XGBhebPo58yRsAULgFH9oaxNvQBLf0i+SfWWV4ifMKrIdco6FMLaellksV+RddVTrktnSnP6eI7W+m9NhjpA5YLRwRSHY4nb67ldBPMilCffJAUNvAhEsfL+ZSJqPiYb42MTAE9o0Yn0CzjCsPKcLKKkXDGUnp8zw3s8KaRric/Nv2Th9UmvdRWROpo6wbsxOaUnSFkdVGdOZW9v8A7pKxS4uZYP4t3vtl1MmBx5y8nRn0SwzXf7Dcrmdy1n4kgEP37dfqkUa+XTjgoPD2FmcMt+s4OETKifyQbsySdrRU/xRy9kcUxdI4gI+GHKgvI4iZjEPEIwOfa0/CHGULy3853B4Nso9PCPtrUKeYsbpP6bffkE4XyKHFk/xZ239xjOjox4DPFsuNqemWbTUnYZsttaOhiq/4ESbxTy8V+lk8UlpZAR0qvQNSd6WgRY7FIbRWkmGqaJbiZUrCAyGyRX1EChmyqP+ZVUaA+TSQFkjEKDMBB9ECQAynDbSoeUXLZA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(8936002)(478600001)(66946007)(33656002)(110136005)(64756008)(9686003)(52536014)(8676002)(316002)(86362001)(66446008)(66556008)(38100700002)(4326008)(83380400001)(5660300002)(76116006)(55016002)(186003)(53546011)(7696005)(26005)(2906002)(6506007)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NlNTQ1RnMFJ1VjJNSHJVK2lIQjloaU9Zc1NFcFBQU3NKTEJEY2lXT2VFQmNs?=
 =?utf-8?B?bnZ4YW9TdGpRN1YxbXkyRXZIL1dKNGtFWWhVK0plQXoyNll4U2l0OCtoSGpH?=
 =?utf-8?B?N21kaDlTQ2paY08vTUdCT0dOcjlQczYxVUpkaFptbHBQenpuMzNlVFZWd0V6?=
 =?utf-8?B?c3l0MlRkUm9YaFJ5d0pNUWdLNnhyWCtFMnFGcUU4OFZHK2F6VEc3TUZrQ2tw?=
 =?utf-8?B?SDhjSnk2K013WHBiTERqL2c0N1hXTk5BbW85bVIwWkZ0Yyt2S05FdUZpL1U2?=
 =?utf-8?B?dkFVM2tHWWNvN2hFRXcxSDJ1MGt6VUJQbTJ2Slc1ZkV0bmxZclJNNWZVTk9k?=
 =?utf-8?B?VlZuK3c5YlJSREQwVk5BVzVBZzZxTmhFS2NxVGxFbEpWZnlSdm54cXo2WWZo?=
 =?utf-8?B?TjV0UkQ1RWxOK2NnWCtUVEtjeTJQRkJ3TGs4aU1mV01wUjVxODdkZTkzS1J1?=
 =?utf-8?B?WStranBsTnRSTDZ1d1ZseG56MUVzdExyVmZZYVRQd2w3OXhOSkdDczcwclBv?=
 =?utf-8?B?OHRQQjhSdDFiT1g1K3czakRTLzgva2lqajljNXZFTFIxcGRVaFcxMiswbDBJ?=
 =?utf-8?B?OC9oVDZDc3MxMHMzellCOVZENWVqUmZXc1FKbHp4SEJmZzJYWHJCUXpnTkY0?=
 =?utf-8?B?ellrdExMakNGMHVmemFad0w0REdQd1ZFRzAvY09zTnI4cmtxM0RaY1hDTnF6?=
 =?utf-8?B?SmNIb2dPckIwL2ZSM2RUV1BjSW5FRmFBN0VOR1Q4RDE2YVpVdjU0WjgyMy92?=
 =?utf-8?B?dHRTenNYSVJyMUUwdTdDMEFLeTM2anlETmpZQWNRZUd4c29hMXBNcURqV3ZG?=
 =?utf-8?B?aXhKS2xkTjVJWjd2ck84UGZCTytQYlY2TmZvWEp1MnBzOFQycTVROVdwZnA0?=
 =?utf-8?B?YnBQRmE1VXpTUGtYQjdJSHRrUWRMYk5JSlZ3UHh6WTJLcXphRlJkM01DZk1w?=
 =?utf-8?B?R05VM2ZPaEdrQzlRMDMybGxLa1RMMm11NUFoYlVkK1ZMZDhCMHdBcXFnT1U3?=
 =?utf-8?B?dnR1N2w5TUpOVHRpRFFoSUw3SUpXajlEZHN0TUd6UXpvK3FtNUNiSGo4UjJT?=
 =?utf-8?B?cVMwMERvZFl5T2dGQlhCNkFYY0pxRzd0eER3VGFMUHF3akRqK1FHczZzTi8r?=
 =?utf-8?B?UENUWjFGOHY0Z2RDa2VEVlFtZlkzYzB6dDVRalBEdUlPb2pIcGw4SUdySTZv?=
 =?utf-8?B?NXVDSmxqUmpnclVJblo2bGQ0VlpYRFdrWGVEUldqVDR5N3o2bUozUjRVeEE4?=
 =?utf-8?B?QW83WWFFdGUxSkZlSThUR1Byek9pUFdrdTNKSmpNOVhHSG9MNk9zOWpBS3J3?=
 =?utf-8?B?MHVWZ0R6ZVF4ZW94a2M4d29FL2VGZ3NnVEZmNmk0bHJSb1FEcEgxekducERD?=
 =?utf-8?B?M0ZQNmtOOS9GTmlBaXRNMW41dWpzb0tWc05YTFRwYnlWOTVDT0hFRjd1Ylla?=
 =?utf-8?B?clFMTVJqSmU3WjBYSWUySktSdHJtVy9aYXNzR0xaMkF5Mk82UFV5dGljVWMw?=
 =?utf-8?B?a2R2ZlJJd2V4QXA1K1kzN042VTNXUGlhMURFbkhXSW5pVnRVN09oOFkweTAx?=
 =?utf-8?B?WmhQQnpTYUttd250R2tIbkQydk1lb2xXcGYwRGVLdFJPb2NIRUNCbkxMNkU1?=
 =?utf-8?B?a3JDN1lueG1qSWdXQW01MmkvNXpZVXpLTjVTNERNMk5wRTkzMjhBTmdjemxw?=
 =?utf-8?B?N2x2VzNJNmcxdzdWOUtFUVpiRmtkTElvTFFLNW0wQWd4RitWV2VGZ2ZwQTFS?=
 =?utf-8?Q?dyBqiGokoMr4y61oMoopQPsyInnXAZ+Xoy2rh7U?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9bcdaf-231e-4632-78bb-08d8fcd28d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 10:14:11.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnSZL8F59Mdk1D2JIV4cH2emTdu9BV3lQ03QARTR9PQRhCxy8aeTsTfl0j/nQjsuCQFzTpQTYgIAEdjkW6JqYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1572
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQmVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlbiBHcmVl
YXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDMx
LCAyMDIxIDE1OjA0DQo+IFRvOiBMdWNhIENvZWxobyA8bHVjYUBjb2VsaG8uZmk+OyBrdmFsb0Bj
b2RlYXVyb3JhLm9yZw0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMDYvMTJdIGl3bHdpZmk6IG12bTogQWRkIHN1cHBvcnQgZm9yIDZH
SHogcGFzc2l2ZSBzY2FuDQo+IA0KPiBPbiAzLzMxLzIxIDI6MTQgQU0sIEx1Y2EgQ29lbGhvIHdy
b3RlOg0KPiA+IEZyb206IElsYW4gUGVlciA8aWxhbi5wZWVyQGludGVsLmNvbT4NCj4gPg0KPiA+
IFdoZW4gZG9pbmcgc2NhbiB3aGlsZSA2R0h6IGNoYW5uZWxzIGFyZSBub3QgZW5hYmxlZCwgdGhl
IDZHSHogYmFuZCBpcw0KPiA+IG5vdCBzY2FubmVkLiBUaHVzLCBpZiB0aGVyZSBhcmUgbm8gQVBz
IG9uIHRoZSAyR0h6IGFuZCA1R0h6IGJhbmRzDQo+ID4gKHRoYXQgd2lsbCBhbGxvdyBkaXNjb3Zl
cnkgb2YgZ2VvZ3JhcGhpYyBsb2NhdGlvbiBldGMuIHRoYXQgd291bGQNCj4gPiBhbGxvdyBlbmFi
bGluZyB0aGUgNkdIeiBjaGFubmVscykgYnV0IHRoZXJlIGFyZSBub24gY29sbG9jYXRlZCBBUHMg
b24NCj4gPiA2R0h6IFBTQyBjaGFubmVscyB0aGVzZSB3b3VsZCBuZXZlciBiZSBkaXNjb3ZlcmVk
Lg0KPiA+DQo+ID4gVG8gb3ZlcmNvbWUgdGhpcywgRlcgYWRkZWQgc3VwcG9ydCBmb3IgcGVyZm9y
bWluZyBwYXNzaXZlIFVIQiBzY2FuIGluDQo+ID4gY2FzZSBubyBBUHMgd2VyZSBkaXNjb3ZlcmVk
IGR1cmluZyBzY2FuIG9uIHRoZSAyR0h6IGFuZCA1R0h6IGNoYW5uZWxzLg0KPiA+DQo+ID4gQWRk
IHN1cHBvcnQgZm9yIGVuYWJsaW5nIHN1Y2ggc2NhbiB3aGVuIHRoZSBmb2xsb3dpbmcgY29uZGl0
aW9ucyBhcmUNCj4gPiBtZXQ6DQo+ID4NCj4gPiAtIDZHSHogY2hhbm5lbHMgYXJlIHN1cHBvcnRl
ZCBidXQgbm90IGVuYWJsZWQgYnkgcmVndWxhdG9yeS4NCj4gPiAtIFN0YXRpb24gaW50ZXJmYWNl
IGlzIG5vdCBhc3NvY2lhdGVkIG9yIGxlc3MgdGhhbiBhIGRlZmluZWQgdGltZQ0KPiA+ICAgIGlu
dGVydmFsIHBhc3NlZCBmcm9tIHRoZSBsYXN0IHJlc3VtZSBvciBIVyByZXNldCBmbG93cy4NCj4g
PiAtIEF0IGxlYXN0IDQgY2hhbm5lbHMgYXJlIGluY2x1ZGVkIGluIHRoZSBzY2FuIHJlcXVlc3QN
Cj4gPiAtIFRoZSBzY2FuIHJlcXVlc3QgaW5jbHVkZXMgdGhlIHdpZGxjYXJkIFNTSUQuDQo+ID4g
LSBBdCBsZWFzdCA1MCBtaW51dGVzIHBhc3NlZCBmcm9tIHRoZSBsYXN0IDZHSHogcGFzc2l2ZSBz
Y2FuLg0KPiANCj4gV2h5IGFyZSB5b3UgdHJ5aW5nIHNvIGhhcmQgdG8gbm90IGRvIHBhc3NpdmUg
c2NhbnM/ICBUaGlzIHNlZW1zIGxpa2UgaXQgaXMgc2V0DQo+IHVwIGZvciBhbGwgc29ydHMgb2Yg
ZnJ1c3RyYXRpb24uDQo+IA0KDQpUaGlzIGxvZ2ljIGVuYWJsZXMgYSBzcGVjaWFsICdwYXNzaXZl
JyBzY2FuIHdoaWNoIGlzIG5vdCBkaXJlY3RseSBpbnRlbmRlZCBmb3IgZGlzY292ZXJ5IG9mIEFQ
cyBmb3IgY29ubmVjdGlvbiBldGMuIGJ1dA0KZm9yIGRpc2NvdmVyeSBvZiBBUHMgd2l0aCBjb3Vu
dHJ5IGluZm9ybWF0aW9uIGluIHRoZSBiZWFjb25zL3Byb2JlIHJlc3BvbnNlcywgc28gdGhlIGZ3
IGNvdWxkIHVzZSB0aGlzIGluZm9ybWF0aW9uIA0KYXMgYW4gaW5wdXQgdGhhdCBtaWdodCBhbGxv
dyBpdCB0byBlbmFibGUgNkdIeiBjaGFubmVscyAod2hpY2ggYXJlIHN1cHBvcnRlZCBidXQgYXJl
IGRpc2FibGVkKS4gVGhpcyBzcGVjaWFsIHNjYW4NCmlzIGludGVuZGVkIGZvciBjYXNlcyB0aGF0
IHRoZSBkZXZpY2UgZG9lcyBub3QgaGF2ZSBhbnkgb3RoZXIgcmVndWxhdG9yeSBpbmZvcm1hdGlv
biB0aGF0IGFsbG93cyBpdCB0byBlbmFibGUgdGhlIDZHSHogY2hhbm5lbHMuDQpPbmNlIHRoZXNl
IGNoYW5uZWxzIGFyZSBlbmFibGVkLCB3ZSB1c2UgcGFzc2l2ZSBzY2FuIGFzIG5lZWRlZC4NCg0K
V2UgZ2VuZXJhbGx5IHRyeSB0byBhdm9pZCBwYXNzaXZlIHNjYW4gb24gYWxsIHRoZSA2R0h6IGNo
YW5uZWxzIGFzIHRoaXMgaXMgYSBsb25nIGZsb3cgdGhhdCB0YWtlcyBhdCBsZWFzdCA2IHNlY29u
ZHMgKGFzIHRoZXJlIGFyZQ0Kc3VjaCA2NCBjaGFubmVscykgYW5kIHdpdGggdGhlIGRpc2NvdmVy
eSBtZWNoYW5pc21zIGRlZmluZWQgZm9yIHRoZSA2R0h6IGlzIG5vdCByZWFsbHkgbmVlZGVkLg0K
DQpIb3BlIHRoaXMgY2xhcmlmaWVzIHRoaW5ncy4NCg0KUmVnYXJkcywNCg0KSWxhbi4NCg==
