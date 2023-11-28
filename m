Return-Path: <linux-wireless+bounces-145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5857FB40A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 09:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD33282104
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98091179B4;
	Tue, 28 Nov 2023 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMtW0om0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3C1CE
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 00:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701160001; x=1732696001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k23qo9cA4mY1XC3l0SIY0AmUpjDflytEVx1oIKisZL8=;
  b=FMtW0om0LV1KMwgqGeA5rAw2NY4fDM5zzZRWaDBkhVorrW84+jcK8MwH
   IbsPlW6YdX1FssQhKsu5hHx87loPi9dw5UvAhsThDtjie7O1K0Qc/PSJD
   tAJpUwq/MbPPnsri0U5yEfIvOBx32Mje/cBi8d1r98016luTtlhLtMMcc
   KDrcyE8Gi2JJbipZ+QsXeZXYWS5ZO8SM7+Qai5sxiqYtptIsHOfYLytvH
   C/bvKRrFdHt64UORGS0vOqNK8apoYBqWyzDVF/wkrRAzO+QgtIzh1mNyu
   diqzD/YSxgQ3ooaLAFRVBXEo27eN8+ZzkIxSe+ZqS3kR4C7tnninJ8bAU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6136465"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="6136465"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 00:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1015843347"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="1015843347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 00:26:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 00:26:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 00:26:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 00:26:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 00:26:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSVkn0RkK+Ysz4OTARrhogIJhClhTcyKA0g6D1okiX11slhJusPymenmNrnrUYLn2XXI9dn65PQ7cyG82zjJpTn77EcX9LJcPIGJpAwepz4IHerAefxpFYbptiOi/c75FfJkEby4Dt3nZlhrRPc2bw+baxI4GtZUGzvObnUs+7s4N2dTYuf5TZ1/OHeo06qoWMepc6m+VeidlCnIsxUO8Ml+qDf5qqSDuGidGRFTjUq1g3IRz+10ezGpS/WqUD5zG3wqadskfv4crYo6gdlR5dljs0Kp5H+2xEeiRTgV6LqT4jF4tL1Wzt7lIkBR6VRlqHuxP0L7I24Uke2ZpRTQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k23qo9cA4mY1XC3l0SIY0AmUpjDflytEVx1oIKisZL8=;
 b=LpEEOMO4Y9AQ7NHKDYOTkvZTC0Wrg0DmBmczA4Ux+WA94lLYTWYbc7LbontR8ZmfKlH5DFXDuhWbnhp4tu/N8SfjJcvnNDcA9719NrAmJBUBbGY5Tpv1qcX+qFuu+pXK3C8LYSEo4nfbTLtW9DiNkT6BYeeMjwnk+ybXJ1mZr0rZaqqD0rIj+QW3Su4G2EWc7kIij/BRhP5CL3Ia9fGvUTnhcvc60cIQdpPYKkZpLek6Mh2Plm2qMIuZnZY2vFKhsFpy4HNx652MzHaPr9TydsNJRVlJHzfZnjKggwz/MIZrz+RgK5N8d9Ec/NB0khh42hezkWrLSLjqH2f3UC0+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3901.namprd11.prod.outlook.com (2603:10b6:208:138::12)
 by IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 08:26:35 +0000
Received: from MN2PR11MB3901.namprd11.prod.outlook.com
 ([fe80::8811:350b:6fcb:8c09]) by MN2PR11MB3901.namprd11.prod.outlook.com
 ([fe80::8811:350b:6fcb:8c09%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 08:26:35 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Greenman, Gregory"
	<gregory.greenman@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/6] wifi: cfg80211: Schedule regulatory check on BSS STA
 channel change
Thread-Topic: [PATCH 4/6] wifi: cfg80211: Schedule regulatory check on BSS STA
 channel change
Thread-Index: AQHaFhTT7gV152az5UmUhnfVvdT70bCJ6FMAgAJ33ICAAEocAIAC0dlg
Date: Tue, 28 Nov 2023 08:26:34 +0000
Message-ID: <MN2PR11MB39011A9D32A76FEC30588385F5BCA@MN2PR11MB3901.namprd11.prod.outlook.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
	 <20231113112844.15d7a0ee3fda.I1879d259d8d756159c8060f61f4bce172e6d323e@changeid>
	 <782a4f7ac91dcb0e1c564e285051c63e2a95d71f.camel@sipsolutions.net>
	 <DM6PR11MB3897EAD2252F23EBAED8EC4EF5BEA@DM6PR11MB3897.namprd11.prod.outlook.com>
 <dffcbd379ede949e328076c5cffb42d442f0ba9a.camel@sipsolutions.net>
In-Reply-To: <dffcbd379ede949e328076c5cffb42d442f0ba9a.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3901:EE_|IA1PR11MB6465:EE_
x-ms-office365-filtering-correlation-id: fc639298-3164-406f-ee81-08dbefebbbaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+xh8RYtEGZHqa40T/Yz1FecFyUMYpZHbm/957mpJh98WANMEkZmj+VsUHgtKMMjrNa4ZMOaGSwT1qCGZhhiyQzV1WSZFWn29/FGsCytttwqdzn1oNsoEGG1DHEkarIgDvy3wuZz0InlMMaGwRImMyJptjJ8vO3pmcXlDlWEsE7V4PJ/w/si+W+7XNVPVpfxesgBYB1q2t66L8pxjFhRdGYJvyyndjwU9NDCWZ7GnmkfstNR/unqO5lkmcSCPP9ouzIUTACDu/DbhY+nSpj4YBIDaybNYECPqSqO6k4Q5wmLbOg/ol5Ru4irTshfdNgQHmfGzwCIyAJgNaMZKt4BAJmQAj/xZ0I98/jACNEwJvYLkhrJSscsNbsALyh3qSaPMFRTdDV+OUlIP2u7+P4DyB3GKXQHhcFSDUCwijkGP+P0lw3gEkb4WdmoeDOianYmD9c2Z04apk+Yua+HHUhcrGiUJKMpgRAcW+gREfepAE7KLiX23wzfUCoRmX9S/9radWMy4lsuh/N9OLqOqhE61/GzdVtPh5EuvHrYovg+FLneEq1OwI4RDH9EHyDfGdvM6FkTnOFFy+H3hDt3rtm43R3J3mEoP+2BM8cBzn4MgmgMXJbCLXUcrMvXZzm784ef
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3901.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(52536014)(8936002)(8676002)(4326008)(9686003)(7696005)(6506007)(110136005)(64756008)(76116006)(66556008)(66476007)(66946007)(316002)(6636002)(71200400001)(478600001)(66446008)(122000001)(15650500001)(4744005)(55016003)(41300700001)(38100700002)(38070700009)(33656002)(86362001)(26005)(2906002)(83380400001)(5660300002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnZCdTFHRlY4Z0dPR0RKcXpleHV0bGxKUHVLVW51a3RFSVgwRGVubVBqL1R0?=
 =?utf-8?B?RUhtakRqUXhON2hjUFpnVzBCaG12RWdENEQrT2pIY1lTUmNuall4VHBaVDh2?=
 =?utf-8?B?aXU2dlJ0Q0hNTkdUZys1RlRiZ09LNGxUbWlra3V6d1JqckRsUjdrN0pjL1Fw?=
 =?utf-8?B?K1hrSnkvUGo5ckdJdnJwb0t1WEZsaWZqanBGdGFIcDVFUkl6Umx5UFVQdUNB?=
 =?utf-8?B?NXZJMDdXK1RaQjdIOER4Rm5SR1dqY0RvcnVmTnc4MzJWb245MFFhS0g5Y3JU?=
 =?utf-8?B?OVJXc0ttK0pyaG9hakNxSHdOd1FDWDljcWZBSnhoY3IvMFpPejU1WkZiRUNx?=
 =?utf-8?B?Qm5vOFF3d3lKelkvZ2ZiMjI1TW9rUE5iVVJhVUVJV2RzUS9UancrL0ZkM0ZZ?=
 =?utf-8?B?alQvSk4vN0k2WEFYM1FMMW5EWGVzVVRuVVBkMjJtR3poY3hRYTdic1NzSURW?=
 =?utf-8?B?UERPOG9DODlJT1BsQTNKNVZHTlBzZFV2QUlySEVMZTZuTHVac29GMEZ1TVVL?=
 =?utf-8?B?VHRkRTdhd1BQT1dzSHpXZnZZN1lIaC9EQjJnbktUOW5SSHN0MUFUdjFEMzlB?=
 =?utf-8?B?bVhxRk9rRk1CN0p6SHkrNU51ellrWGF1ZzNwUzRJOFRNeUNKQ0IrMlhvR2xM?=
 =?utf-8?B?cGRSTWw3R3hpQ2JrZmROeHdkN0VGRkxrcUlqbDM5UUoyT3oxb2MzRmdkV1pn?=
 =?utf-8?B?L3hLci9xeW1sTm5qb0M3MGVLc29HZlRpTy94a0c1ZWhZWE5CNTVPcEZIcWha?=
 =?utf-8?B?a3VFbEZjYjIrQjdQWVBqMVZsbzlsOGlyTCt2TWVhclhHYmhxRWhFOThtMW1i?=
 =?utf-8?B?ZzNPZkFuUUExMjY3VnF6cjFxeG1aN1ZtSlcrOFpudXluZEhlVDBUSElvOEFU?=
 =?utf-8?B?eVNUcCtmb21PdGtnVEFiTGVZUzBhWld5bEdHOU94SHR3cEYrUmtUNEdlSVM0?=
 =?utf-8?B?QTVSU0libzRuQzVvRmRkR05rb2lWRFBaaUZ4Nkp0Ym01NXpoeTRzR2hRZ1Ra?=
 =?utf-8?B?ZW5LRVJsY2s2cGpzNHFURWtVd3Jyd2dnM0hJN0I4Y1Y2aEJqMlRrZmlaYnk4?=
 =?utf-8?B?M3htVUIvVWhMZW5sWUJmUzluZXRadjF0WDI2T01xbWlQck8zNWNoYjcvcTln?=
 =?utf-8?B?T2l6MUh4WXhzUEdMMW5ueCtjNWxvNlJjc1JtdDM4NGFNK0dNdEp4bEF6aFZM?=
 =?utf-8?B?OUpveFVzSk5WbkthWlE2bm1lTmcveTFxcjNaU0RtVkExZVM1d0FEZjdCYlIr?=
 =?utf-8?B?SWNzd2FMcDYxdEtvenFycklWNEVpMGJTT090ckltWXhCUHppaElYaDNzYlpW?=
 =?utf-8?B?VHJQdE5IZ1ErN1NPNXpONEVYRzFrS3BxWE54SytaZnJjWGVzRWFqNTMxbkVV?=
 =?utf-8?B?U3FNcDd2aFhJTGZ5LzNHRDhGVDREUjRrVlQ2ajltcDZLbHlJZnJ1TGlhbWlt?=
 =?utf-8?B?cEIxOHpnOUw0MHJkVXdWYXc3R0Z6QlZkaVVTRCtHakgwaWl4c2hGNHNZU0Mz?=
 =?utf-8?B?cDRKN2gwUzBxWldHSWs5TjJhZEtIVnBocTVMRE5Pb1J4aU5jOUhKZmMwb3gv?=
 =?utf-8?B?NCsxZWxqUmxxL0hEeXA2eHVjOHBnQW9sUFhMUnl4bVJZWFFoYkRBMCt0LzN6?=
 =?utf-8?B?SG5oTHczc1F5TDZzSzVEdzZtTDZOQTJ3eDhZb0lDS0tueDgwOExVSEVIY2VE?=
 =?utf-8?B?Y1ZyY3paclp1WGtDMXdoRC9XWDFPekp4UUtNZ2tCT004bmtLWWt5ZW9LSDRj?=
 =?utf-8?B?U1Y2dHlabFBmRFVVcVBLSzF0eWhoMDhpbGp6R3c5TjI0anJXTjZhbVh2Vkta?=
 =?utf-8?B?dU1YeVlSd0tpWUVZK3pIVEVHWVFDcXc0c3MrT0w2VmpSd0c0eGtVRm1kbk96?=
 =?utf-8?B?S0FYc0QwQjNKNmRHNW9Zd0ZYSHB5bUM5bWlNRVg0bzMzclMwU3BzdlRzbVdw?=
 =?utf-8?B?WFl5K1JBUTlxckphYThWbFI3QW5VQk4wakVmOHZOUTF2d1N4aDgvdzcvVGFS?=
 =?utf-8?B?RlFESGtraEpyNmtTbW1HOGFsV2V3TUNTMDRwQTBmSWw4UnpicDZDT003Y2Ri?=
 =?utf-8?B?WGQ3NkVMUGNBR3ZLcjJPVzRva3gycVNtdWZBdnY4VDc2WTBiYklENXA3WXNu?=
 =?utf-8?B?NU5kR1BHTmZzcEJtOEdBVC96V2lyL0UzSStmQzVJd2hFelVtK0NMNFJkeHJR?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3901.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc639298-3164-406f-ee81-08dbefebbbaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 08:26:34.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PnTyblawv4xsY+e78M8gpDZF09SoonkCvE70rfBFNNZeJ7FGUiihVvOEx7jqq2QDISKEwTQ1jjHd9KoXBuU0e16ZsC7rthTg60lMAXSN1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
X-OriginatorOrg: intel.com

PiA+ID4gPiArdm9pZCBjZmc4MDIxMV9zY2hlZHVsZV9jaGFubmVsc19jaGVjayhzdHJ1Y3QgbmV0
X2RldmljZSAqbmV0ZGV2KQ0KPiB7DQo+ID4gPiA+ICsJc3RydWN0IHdpcmVsZXNzX2RldiAqd2Rl
diA9IG5ldGRldi0+aWVlZTgwMjExX3B0cjsNCj4gPiA+ID4gKwlzdHJ1Y3Qgd2lwaHkgKndpcGh5
ID0gd2Rldi0+d2lwaHk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkvKiBTY2hlZHVsZSBjaGFubmVs
cyBjaGVjayBpZiBOT19JUiBvciBERlMgcmVsYXhhdGlvbnMgYXJlDQo+ID4gPiBzdXBwb3J0ZWQg
Ki8NCj4gPiA+ID4gKwlpZiAod2Rldi0+aWZ0eXBlID09IE5MODAyMTFfSUZUWVBFX1NUQVRJT04g
JiYNCj4gPiA+ID4gKwkgICAgKHdpcGh5X2V4dF9mZWF0dXJlX2lzc2V0KHdpcGh5LA0KPiA+DQo+
ID4gV2UgZG8gbmVlZCB3ZGV2IGhlcmUsDQo+ID4NCj4gDQo+IE9oIHJpZ2h0LCBJIG1pc3NlZCB0
aGF0LCBzb3JyeS4NCj4gDQo+ID4gSSB3aWxsIGNoYW5nZSBpdCB0byBiZSB3aXJlbGVzcyBkZXZp
Y2UgaW5zdGVhZA0KPiA+DQo+IA0KPiBObyBuZWVkIEkgZ3Vlc3MsIGlmIHdlJ3JlIG9ubHkgZ29p
bmcgdG8gY2hlY2sgZm9yIGl0IGJlaW5nIGEgc3RhdGlvbj8NCj4gV291bGQgd2UgZXZlciBoYXZl
IGEgcmVhc29uIHRvIGNhbGwgdGhpcyBmb3IgYSBwMnAvbmFuIGRldmljZT8gSSBndWVzcw0KPiBu
b3QsIHNpbmNlIHRoYXQgZG9lc24ndCBhZmZlY3QgcmVndWxhdG9yeSBpbiB0aGUgc2FtZSB3YXk/
DQoNCk5vLCBJIGRvbid0IHRoaW5rIFAyUC9OQU4gZGV2aWNlcyBjYW4gYW55aG93IGFmZmVjdCBy
ZWd1bGF0b3J5LCBmb3Igc3VyZSBub3QgZm9yIGNvbmN1cnJlbnQgREZTIGNhc2UuDQoNCj4gDQo+
IGpvaGFubmVzDQo=

