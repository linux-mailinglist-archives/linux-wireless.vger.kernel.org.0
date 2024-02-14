Return-Path: <linux-wireless+bounces-3567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FE8542A1
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 07:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F08B272B6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4D10958;
	Wed, 14 Feb 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCmMtVCm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A158101DE
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890920; cv=fail; b=WHFWWKVoeCTWoLc07e9kXWr9FHQKdQl7qBT49nACHy8cgxWD8CBw5wTE9ZinE4sDILKGPZmkm8PLpKTjpY44G8qslYMmr7u9xDlHC9p+4RcAoVKXPRYDHbW0dR7+GvgGx1Ig2Kexwunm7VukK9fE+ZqhLiJayLUzO3KwvYxAung=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890920; c=relaxed/simple;
	bh=sWR/7/g3RRgAq5PseDz47Lv2LV9bG8kfFLv1ZK1PrsM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LutvCbvFsI9wj4WMdgvtCaQZgFQYQAUfrNwSiW9WUZ843mChBUpA5bEa7utfjHSCPwfGec2rKtCa+tlc3+Y2RAleaZcdcoeo4BgxmUzIvD64goT9xBrgC9jASaIEHcbesGpYxdi4sFz+BERGSDMuNxQDPhpz4AX+GMybYkziDAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCmMtVCm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707890919; x=1739426919;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sWR/7/g3RRgAq5PseDz47Lv2LV9bG8kfFLv1ZK1PrsM=;
  b=JCmMtVCmzHrCg0CuurkyMp4RVG3rRyMdvnhmC7pGdW643Q/Yu6YQVvBM
   2xKVca/U7UTP9+JzHm8B1IFAn9FlxqnmUT1hp6KMsgIDtgFZVAaLlM9vY
   48uKVW54Z56FXkvdKuDgCj4ScRhL/40sRC6rEVhseBYpKEwMrD0A0BpgG
   yKoQPN3tDmA6lMaMXrGT//Qo95I+oOtZWj5onanHMKfhJ9/9UNUXILNyI
   xD+EEfWc6bCvBT8pnZKIP1BLW/FaZNU10i4ueJK7o0G+ZDqZrH7hTkCcp
   jliwdYWmGlQCV13Ht4XsTNGubavHQFZyVSJJRechX7Fb1dchuniQgvJtX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13018190"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="13018190"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 22:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="826319632"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="826319632"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 22:08:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 22:08:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 22:08:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 22:08:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeK6rzbyOD0nRCzvD4L9OzJpPy+6gtD+oaQLP05MQX6jyQBqL2AMnSODWriIB9XZzlju/48F7dgm7UM/MAOR3Z5F/XGHXfNdz7V8YkYe/R6lg1hrWvp71yfYvQfosvW76YTd+N6SL4NtcDN6ETyX47j7G2hcgjotZDTYD+Hr5ZmpLiResc85YqSpAo8KVCpCbdxJJQQgk+Qhwe5A7PPAXjoOnmnLyENtq92hRGcgaEx5Zon8vDb1g2a2Oe2cLBZFyWLLAtoO870NQ4KGfdsMIQs07n0ZZjTJxvqT5ayXTwBtwfFIuk1Hm2Q9sS4AQjpJ1/L/UMwewyeaWZb/kmBb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWR/7/g3RRgAq5PseDz47Lv2LV9bG8kfFLv1ZK1PrsM=;
 b=Wgbg4/BpZPbcuXalk0DuNfcMC0E3c9wtFY68NrU+vEivNQTCV231PjUFxo+wIO37Xc4WECr8CyzmP7YpV20IvbrXZa+He0Uu2hmb8P6eEbwa2JcZ5Z4UJlw/8Vo+WU3ISfKoNoO36tHruJ6+Q9V0pUS+XB2F6NgkTIBDzuJ7YaFU5jN978qjcuc1JMXUtBYNllUKqBsCbTAiaVaOHgdBzAUwCqNkq03g6l588ZWj8osUSeAgb5Pk+8VylnjcDCZU5e9gZ+LHmtqNpSgQcEZXdKcb125EP7wn6mHAKD0SWN/+4PWUX/lcwDMvT1oH8OFQ2D/IO8yryUF1M6s6AyqJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Wed, 14 Feb
 2024 06:08:35 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 06:08:35 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	<linux-wireless@vger.kernel.org>
Subject: RE: iwlwifi RFC related to iwl_mvm_tx_reclaim
Thread-Topic: iwlwifi RFC related to iwl_mvm_tx_reclaim
Thread-Index: AQHaXgqBDYpxIDMMckG/dmy/C2XzqLEJWSKA
Date: Wed, 14 Feb 2024 06:08:35 +0000
Message-ID: <MW5PR11MB581035988083537C57286DADA34E2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
In-Reply-To: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH8PR11MB7992:EE_
x-ms-office365-filtering-correlation-id: ff8ec77e-2603-4158-0650-08dc2d2360fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mhr8ADyOsXHRliYM++TjcwHL9QN1Go5rbLJp5hQ0YZTD+gtxa7v+8MTGvWYBydKPGtYxqzYCXh4FDG58kd/3q+JFxjL2SiSOr4PPrbxrwkTNLR+jUsRg4wMTZSfFbi++U4Ryv9RPtVX1DdFptv+m6BKFTSTRGZ8+yTkxGbsju9JfO3GEBVQ+zvOkzbFWxVJzpRrlTHbfLHlBPi36xfdF9RTFdmJRHEMPDQPZ5KGhyFE7/7W9FTwkYeAqK2Ql0womlbRqRauV8aHpK5fYdiFMEavp/7+v+sLGVJ+2QG/4hoIp2yFwQ2pxZa2nNN9UsmMVmTpcPZ8UA2Dwd3PMVC0rZVofURxEqERNStk6a3TsLY9QPAfNiYg2GckAbYfbVrjdRpBkdEmx2xtlZEmAyitpZszgNWyvnjm0cECuJg1NVZ9LSaxmtgdR/zqidPFBUfkNa3wqZDKi9+AiXxbcwIziQJWMQ5IEHhbJAs70cJMiqEjqEbga+f0zrdFJTTqArt7fRvbmTQetbzuFWusdufM9Y4ZKb/MFR9+xXIXbWiJ0XovOrRtlz8lUbmjFzIqXV+Flki5ZJddX64wjzzqbGKVqrgWXHbzf3vNsa2LL0ttT41s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(33656002)(38070700009)(41300700001)(26005)(478600001)(64756008)(8676002)(76116006)(52536014)(66476007)(83380400001)(66556008)(66446008)(66946007)(8936002)(71200400001)(9686003)(5660300002)(110136005)(7696005)(38100700002)(6506007)(316002)(86362001)(966005)(82960400001)(122000001)(2906002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akFtSkg0K29NRHBVN0NMUTg1V1hhWHR5QWN4dEVsb1MrSHZvc2ZiQk1WeFRK?=
 =?utf-8?B?TUJLdTBVYi9YOXlXTzRGY0ZtMERiM2xDWGFsMUliTEJtb3lpenlLWk44V2d5?=
 =?utf-8?B?S3ZLZjlVcXdnd3JOb3o1cDBRaVh5WW10NC9RaXY5akdxOFFaL1hnc1pWRmk2?=
 =?utf-8?B?cy9ocXRweHg0VVJ2TlF6akVMa3RvNjA1YVRTNW5qMHNPSE5xbExNYjZMVzRn?=
 =?utf-8?B?dHk5TEJGQkt4QytsUmErQWMyRGZBeGZDM0lqY3lyRmpjdDRyUVBRSFU4Q1kx?=
 =?utf-8?B?SW56UW5YellXWlY0UXZnaGl6ZVdhUXcvZVBzVE1FaE44QjZWOFhRNWNBNVlL?=
 =?utf-8?B?NEYzZWpCb0dsNnRDQjhFVmVqVTNJVDRQM01LazFwR2Z0ZUR5d0ZIendtckFa?=
 =?utf-8?B?cXhoeExwOUVrVlNrRXRvc3lJVHZLUFRXaUUvT2pzMmRnSHRKV293dWp0VnhC?=
 =?utf-8?B?Z05JclhQZWdHRGtmWVNUeUx6L2tCRVVzVlM0VFZWZkUyb3dLTE5FSmtNbWdo?=
 =?utf-8?B?dk02SVJFTVJiTGJoaEtzZkV4aXVZeUVXMEs1RFlHVVpNR1V2NTFpbTlobk55?=
 =?utf-8?B?VTJ6ZDY2SGNhUXJaTHVWMXpQSEljdDRTenVCcGJaNWFUT2kwdm81VkdNNlRm?=
 =?utf-8?B?dlhMWmJxMnBIek42ZUJaUkxXa1FicDlTd0lielZUL2dvM1FlMTE0cHgvRTJO?=
 =?utf-8?B?VEl5YWF1ajQ0M3FNcE9Fc1daUDhxSDcwNkFuYTBzUnhHZXFuc1NmTE5OTVdM?=
 =?utf-8?B?bXVXYnBiRi82eGhGbC9yWU5FQW5nVkwyZnFPNldZVURSVzU0ZE42WFJWVE5Y?=
 =?utf-8?B?OUxHTUJISURIcjg4MFFaMXRCVEFaTmpYQW9RU1ZhSWF1cGlTSmFtZ1NMUHNU?=
 =?utf-8?B?YmhkVkN4Sk0ySk5TeWlEZkQzdjBqSjVROUxsRUFNSitRNml4NTVDRmI5MVl3?=
 =?utf-8?B?d0RSZldlR0gvbk0ybXhobURKVlJSUi9UNllSKzJkRkFnY3lPQlE5RC9WbXNE?=
 =?utf-8?B?dG93MHgzVlBkTzUzWVJ1d2J5WmpWU0FqbVZLUy96VC9DNUNESDMwOVR5OTRk?=
 =?utf-8?B?QW9FbWEwZUlGY1JPTUtJdjBGckZYeTdPVEhPdEpmUFRicTdQSk5Ya1l5QXhB?=
 =?utf-8?B?UFFsdjVscWUvN2EvdUxxeHJqTGxyV1pMTU5yQURtTFVtaUI5SkY2dk9sRC93?=
 =?utf-8?B?VUJqVkRwOS9iU2gyUVFoK0IreVFVU2VJYlp4YjJCWUJ6ZVA4K2JBYmsyY05u?=
 =?utf-8?B?UUoyejRERHNYVW9Kdk01M25qY0FzQkI5Vnc5Vkd1WnRtc2FIQ0Z4V0c5M2dG?=
 =?utf-8?B?NURsODI1SzFCUGU3ZjhDdkRpTEVYQjF1bnZXWVU5eWlnYjkrS09BVGRXUmpR?=
 =?utf-8?B?Nis2R296TVBZd1V3RnpzOStEVXhIbHlnL2V3Y1daeGtJKzQ1aWhkdE84eHFt?=
 =?utf-8?B?T3BzMDdXa2ExSTMyVy9hSEF5a2dRU1c4cEhpd3RObHV3RERJdWttb21aYmVB?=
 =?utf-8?B?Zkd2QkhEVHlMWUtSWmRrWW41VWNiL1pHdFpMQ1hxYnB1T1Y4NlNYTU8wZHR2?=
 =?utf-8?B?LzhpL1FNZkRIVTdTWnVxVTZNRnFTT1lNUjRwNkZtSWxETlBWRjgvY1RwMzhV?=
 =?utf-8?B?NVhZNC83U0xvazQ4a1MrNWphYWJrekJIS2xsRC9URHA1Vm94d0xXdHloZngx?=
 =?utf-8?B?NXlLcVpjajQrZUJoOXVXK2Z3dmdPSnRycUZMWlF2NE5KYlI4YWRqdVArOC8z?=
 =?utf-8?B?UlFqMXdDNlZQaUVEN1hyeVRTalMzRnZzNnN0N3VkME9ZUE1MZDNWKy9wcVpV?=
 =?utf-8?B?ZExoTTRqWjViUldvWTZnS05qc1pSK01rbm1WQjdRb3JwbnN1VVdVTkk4VjhF?=
 =?utf-8?B?c1BGS1V5RzlSLzVsM0JOcDdhLzdOSmVieng1cFJ5Zm1XcGtQcVYwUllJZkgr?=
 =?utf-8?B?ZndtdUhMM29VeGRteFhhQUhXeXdhRUhlZjNMcGNldk1YZXBzeEh6M2JYSWVt?=
 =?utf-8?B?NkFPVmZtVksybEdOU054ZmRlRWo1VWgzRGJEYzZrZjNHRTBSWTk3aWhmUmd6?=
 =?utf-8?B?QUdTTS9yaGc1NFN0RzdJN0lMN1R0UWJvTVdmT21QdFlzRnprZ2YzdFhUTy8z?=
 =?utf-8?B?b3luS3Z3VVB5cnVkRWUzWGJMcTBnbmZqK1BpZ2d0SnVzcGRqMlprRDJJUzh5?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8ec77e-2603-4158-0650-08dc2d2360fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 06:08:35.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mfZYf8Leg6J9nox0KlfW/b2b/N34NzwASW4CNsuQ0RIl+Ex2r+2dHpjFtwdh7+4aEFs6jRzlO0ipRkgnshHa0pY9Aa/W4Jn82Bi86twwPfDwvX5ghyyOoQp+tTFy7LC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com

OiBpd2x3aWZpIFJGQyByZWxhdGVkIHRvIGl3bF9tdm1fdHhfcmVjbGFpbQ0KPiANCj4gSGVsbG8s
DQo+IA0KPiBJJ20gc2VlaW5nIGEgY3Jhc2ggZHVlIHRvIGFjY2Vzc2luZyBhbiAnc3RhJyBvYmpl
Y3QgaW4gdGhpcyBtZXRob2QgdGhhdCBpcyAnLTInIGFzDQo+IGludGVnZXIuDQo+IA0KPiBJdCBm
YWlscyB0aGUgaW5pdGlhbCBjaGVjayBmb3IgbnVsbCBTVEEsIGJ1dCBJJ20gdGhpbmtpbmcgaXQg
bWlnaHQgc2hvdWxkIGNoZWNrIGZvcg0KPiBJU19FUlIoc3RhKSBhcyB3ZWxsLg0KPiANCj4gKEkg
aGF2ZSBteSBvd24gcGF0Y2ggdGhhdCByZWZlcmVuY2VzIHN0YSBiZWZvcmUgdGhlIElTX0VSUiBj
aGVjayBsYXRlciBpbiB0aGUNCj4gY29kZSwgYW5kIHRoaXMgY2F1c2VzIHRoZSBjcmFzaCBJJ20g
c2VlaW5nLiAgSSBndWVzcyB1cHN0cmVhbSB3aWxsIG5vdCBjcmFzaCBpbiB0aGlzDQo+IHNpdHVh
dGlvbi4pLg0KPiANCj4gTXkgcXVlc3Rpb246ICBJcyB0aGUgcGF0Y2ggYmVsb3cgYSBwcmVmZXJy
ZWQgYXBwcm9hY2gsIG9yIHNob3VsZCBJIGFkZCBzcGVjaWFsDQo+IGNoZWNrcyB0byB3aGVyZSBJ
IGFjY2VzcyBzdGEgYW5kIG9ubHkgZXhpdCB0aGUgbWV0aG9kIGxvd2VyIHdoZXJlIGl0IGFscmVh
ZHkgaGFzDQo+IHRoZSBJU19FUlIoc3RhKSBjaGVjaz8NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90eC5jDQo+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHguYw0KPiBpbmRleCAwNTY3ZjRlZWZlYmMuLmJk
M2QyZmU0MjRjZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vdHguYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS90eC5jDQo+IEBAIC0yMzM3LDcgKzIzMzcsNyBAQCBzdGF0aWMgdm9pZCBpd2xfbXZtX3R4
X3JlY2xhaW0oc3RydWN0IGl3bF9tdm0NCj4gKm12bSwgaW50IHN0YV9pZCwgaW50IHRpZCwNCj4g
ICAgICAgICAgc3RhID0gcmN1X2RlcmVmZXJlbmNlKG12bS0+ZndfaWRfdG9fbWFjX2lkW3N0YV9p
ZF0pOw0KPiANCj4gICAgICAgICAgLyogUmVjbGFpbWluZyBmcmFtZXMgZm9yIGEgc3RhdGlvbiB0
aGF0IGhhcyBiZWVuIGRlbGV0ZWQgPyAqLw0KPiAtICAgICAgIGlmIChXQVJOX09OX09OQ0UoIXN0
YSkpIHsNCj4gKyAgICAgICBpZiAoSVNfRVJSKHN0YSkgfHwgIXN0YSkgew0KPiAgICAgICAgICAg
ICAgICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPiAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4g
ICAgICAgICAgfQ0KPiANCg0KSGksIA0KDQpEaWQgeW91IHNlZSB0aGlzOiAyYjNlYjEyMjM0MmM/
DQoNClRoaXMgY2FuIGV4cGxhaW4gd2h5IHRoZSBjb2RlIGlzIGhvdyBpdCBpcy4NCkFuZCBubywg
eW91IHNob3VsZCBub3QgYWNjZXNzIHRoZSBzdGEgcG9pbnRlciBiZWZvcmUgY2hlY2tpbmcgaWYg
SVNfRVJSLg0KDQo+IFRoYW5rcywNCj4gQmVuDQo+IA0KPiAtLQ0KPiBCZW4gR3JlZWFyIDxncmVl
YXJiQGNhbmRlbGF0ZWNoLmNvbT4NCj4gQ2FuZGVsYSBUZWNobm9sb2dpZXMgSW5jICBodHRwOi8v
d3d3LmNhbmRlbGF0ZWNoLmNvbQ0KPiANCg0K

