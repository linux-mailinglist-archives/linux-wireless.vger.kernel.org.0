Return-Path: <linux-wireless+bounces-20028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9496A57E28
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DA11891876
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77F41EB5F3;
	Sat,  8 Mar 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQHGXMKR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC013B2BB
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741466041; cv=fail; b=pG8ue3Nl9BW7JY1QaEJItMlgRMO+Okhcz9iOw3fwvxQGxknqnMAe+u7Ela+I0+gcf3C1dExt882GeEruBqMVMSWOtI8PElzrTyrUOuXZz1X1SOdanRVfzxurUc0m9Oa4+JLHV3D8dEyyYd/nbf6N0fBNb0hEzLGyojzOPrDGiZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741466041; c=relaxed/simple;
	bh=WkAjmFIUrvOvFlox6TFDqmxgNhNuomWtNpxJ6l7ouPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AVD3lJvNqOKjSvxx0e5SF3ElPAZO+Lpc0zU84xdYTdbjqRIvhjEwmEys+XiPn4brMzDkaFArhaZ2Aer+3eZQv4r/QDg9//kJcVOT8oqmjOJzTGHz6xD0Z6ZvskIvaQXlHQHkrCfPfhCX0D3zjzB0SReGUFBGuaHyFbmT2Th23TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQHGXMKR; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741466039; x=1773002039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WkAjmFIUrvOvFlox6TFDqmxgNhNuomWtNpxJ6l7ouPQ=;
  b=OQHGXMKRgbKujxVJYgPSDLGjSh08W6gbjxQlL9dRGPWHQYthlLmav3wT
   P6bAXntqNxxmKWWHDtGgX1CxqXmA/SBfM40e/NBoHjU3l+7c7CGlMiSS+
   CANRZDuP4R3gXLD+yHgqMMrJ0QtA9Ik7l/RASM0u3oyyJzRhavtKng24s
   PFHXnyNyf+UKcSQ3MWMWSAHgzkDOepnQfh0EVC53ylmdsTH/DNE4/XAL/
   zA6qx9RSUPRjyRWsgJPdwTC5MEjxOFSq4md3abEyfnf7QaiB4czmoL6nv
   zQCp2RjWlxhjn6iPy1SSJGaaxIlDvD8mkU49LIDU2e909YxCUzwb1DMUQ
   Q==;
X-CSE-ConnectionGUID: p/RrmjsZSdyiFHqzGuLNHA==
X-CSE-MsgGUID: ommDq9qoTGe25GCzUEfQQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="30080384"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="30080384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 12:33:59 -0800
X-CSE-ConnectionGUID: SjSOobaVRb+VrnX7+15FJg==
X-CSE-MsgGUID: sYwh+/NgQgiVtdg+uBEBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120340802"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 12:34:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 8 Mar 2025 12:33:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 8 Mar 2025 12:33:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 8 Mar 2025 12:33:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1mbfu80wZBUDt/oJGtI0miXCcIkd3mAkhMQFxsjLY5A+sKFFLkLE1vFc+vz81DnUX6gZR8wuxXsd7ruoUktbHhzWLz3sli/IicDnm8GCFh8rN4GblraSHgWt0r0TbVXOFyUciCRor3UBT2oiAMfXxh+AS7uzFgh8m9+vZaPkeu3k2z7LPZYcTqySRsNzh94nux5Uf5GITjfZw9r62NLpo55K51GT1xHFYZlDBv+gj92K8J6Yg56xSfKmQmLB5PJ/N+RHJ/OF/SxvdXabPOAKQzA0L5isDvKaVREj6PpvLNTn4I0zWGQWicTjUI/6q4wy13rXT8Q/IfUJOJEyQn94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkAjmFIUrvOvFlox6TFDqmxgNhNuomWtNpxJ6l7ouPQ=;
 b=TWZijvIFJbtnvZlNosPLY1pAt3ib2yu48MXx8sYxyvCertK3yjWS4DrtnI58bgBIiH0ZTcVY+Z17JDQ6ab3t4foqtZ32o6XXDirejvhTDhFZldlcC9tkrpfGFNRzYD6tHon+S57Uq/i7vsKy5GYhaMb1cW2OKNQfv27NoOZMBGOMMwJfYjIXL/s5zBVAL7O8nKt2y59aP2mYIa6NdZC0x9h3/1iSukwK047xotwQeu9S30mGEBwsqphJ2JXQEkF9QOhW/ynO2DxAyB+EUx6m4pKAtFRQUhRsVhQYMpDEJ5DmPnpU3MNn5WvSlkbip3WfL1+S755qRDPDKLLMxrup1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Sat, 8 Mar
 2025 20:33:42 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8511.023; Sat, 8 Mar 2025
 20:33:41 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Peer,
 Ilan" <ilan.peer@intel.com>
Subject: RE: [PATCH wireless-next 11/15] wifi: cfg80211: Update the link
 address when a link is added
Thread-Topic: [PATCH wireless-next 11/15] wifi: cfg80211: Update the link
 address when a link is added
Thread-Index: AQHbjoTU0C5J+YmXaE+PhyTZ6X2CILNm7jsAgALFFCA=
Date: Sat, 8 Mar 2025 20:33:41 +0000
Message-ID: <MW5PR11MB58103C490B7D5C6BF81026A2A3D42@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
 <20250306124057.6ae37b21922b.I79b010ea9aab47893e4f22c266362fde30b7f9ac@changeid>
 <756726fac4484a1e862f0f4186691795@realtek.com>
In-Reply-To: <756726fac4484a1e862f0f4186691795@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SJ2PR11MB7545:EE_
x-ms-office365-filtering-correlation-id: d7ca6bf6-1ca2-4c3f-3a4f-08dd5e8083fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZWJyZk5jOEZ6dFNkUEVZNDMrZ0taSTFWVklNUU1xaUw2NlFzU3J4b1JWbVBH?=
 =?utf-8?B?SEZWZXMxWk44ZW94RElNLy9oMG1pZUFSRHpDSjZaUlhDTVdhM2x6Y0E3Nkw1?=
 =?utf-8?B?UEoweTlLK3EzNklYRkVUTnF6cERoR3ExeXhEaDh2YmhIUmp5eEpONmRMaXEv?=
 =?utf-8?B?TDQxcFptTGp4NXM2TVR4MFN2M0hDY2RZZmduZzllZWxXRFdzSEJ5WHlyaStM?=
 =?utf-8?B?Y3lablhKalNvaVljTFpiN3pOMlB1by9OcERvRUJ1TFR3TWV2RkRHS0VkV0Y5?=
 =?utf-8?B?SVhidEtWVDN5UFF5eXZDYVQxcENyaVVEbEdzTzNpSTJEcTBpNkdjaGxQb29s?=
 =?utf-8?B?WFA2SjRHekg1QW1HaHkzTlU5SmFMYm9QczJWZVZTZXBhTFpYTVJBbEROVitD?=
 =?utf-8?B?L0xreWRBUXdJN25XSXlySVl0a3hjL3Azc2kyMXJ4LzNSL3RpODBXK0t6MmE1?=
 =?utf-8?B?VldOTDM2NE1qbm9UbjZwVWJKTjlvZU1VaDlyV0IvWTN2TnVYNUxuZ1pENXNr?=
 =?utf-8?B?Unllc2o0ZUdqazVGeW41KzNYUmR1S3VCWUxVditzUmJGNU1keFFGMnFzcVZj?=
 =?utf-8?B?d3R1ekpMSVpFZmZyQnNsbnJaNzZUY1FzYW8rZHpKdXc1bTQ0ZUdYWnFKZ0VC?=
 =?utf-8?B?S2ZSYjhkZklVSDVudE4yVXJtK3NsNUVSUnlSdTZ3SzV6cUNMb2lLemJmdzBM?=
 =?utf-8?B?cmRFQkhWWWNKeXE0UnRRZkhUeWx1TG9mQmJJdSt1My82SUh2VnNkbXdMWTdK?=
 =?utf-8?B?cWRwVHJPSjhBMTFWYjVERU4xMWNWcDNwZTFVdHZWTjFCa1h3WmxVTVBETExz?=
 =?utf-8?B?M2ZrNTVQYlFjYTdHYlVkYkFDbzlrMCtFeXQ1dWtMbDBMN01HMVJvcGxINmE4?=
 =?utf-8?B?bjVPSll4UXlQVWVOY3ZFdlphMW9CR1FFUFJVQXk4S3dUQ1l3a25NNlJhWTJz?=
 =?utf-8?B?cGJZNmZnYS92Kzl3KzRFSTFpcU4vNFRLZXdhSGxLU1J3eGRDVW4zQ1NDUHlV?=
 =?utf-8?B?ZkZjOE1tM1JmWVdxeDRDRFdEblE4akxSeExvbzRPWFd5MFk0YXpIcFpoRzZ1?=
 =?utf-8?B?QU1ITzdwU3pFTFlkRUYwMlE3aFJ1WnhTR0ZUSU90VE1PZmQxZEYrd3RUL3Fz?=
 =?utf-8?B?ckRqOEluUHUxV05FaURDR05Ua245WFJkbVk5cEVPcDZFMlRIeDBaUzlDdFpm?=
 =?utf-8?B?R0Zldnpha00yanpmYi9zcFllQWw4eGl6YUEyMzJBTDROTW0rbG50ZlJUR0pX?=
 =?utf-8?B?dzd6K3ZtVml3WHZPdGlhRHhzRVUxaDVLeUJ0Z1lXS0M0STFuU3p2d0k2eitz?=
 =?utf-8?B?ZStIS0w5RmNFcmQrWHZhTzU5c0VxdDc0d1RUMXB1ZkZ6TUJCUFZ5Z25xeW5U?=
 =?utf-8?B?SWZ2cmE4MTJhZDhLYmFhV0RKd1p5T3BVRmthaXUyUWI4TGZpdUFZS3d3d0VO?=
 =?utf-8?B?b0YrSUVwMkhoUnlObzBqeHljeGRFdFdmUlA5UmwvQy9Ed3QybkxGYWV5ekpD?=
 =?utf-8?B?eEdpc0RtQ2JyZ2VQeXlydTdlWm9xTHFlRDQ4MDBQaFRvNWlIQ29RNTY2TDhB?=
 =?utf-8?B?NEVaYSszbkU0V2hlV1g3WTE1dC9mRzRTWFZQVHlUY1BXMmZpZm9yN2xObXJN?=
 =?utf-8?B?c2JzTXAvMWd3RlZYTDNja1pHTktnemtvRnFVNUR1V0l0Ry9ZVStLV3Q2R2Nk?=
 =?utf-8?B?MHpnd0NYMjlWR1pJSllDMDAwU3RyUENoRnc2dUxrUGRwSEhuS3ZyWllSTzhh?=
 =?utf-8?B?U09qSlNua0IyQ29TNTdvQ3llOXA0anV6d0c1N2xkRlhYVHRENXpabWc2ZzNh?=
 =?utf-8?B?dEdGRjcwM3lRR1NJYzRpcDM5bkZjS3FTQnJESTJjcU12WjFHclFBK0s5WkZV?=
 =?utf-8?B?bndhRHZQRjVxSTNKc053cURNS09LbDB4aW5udXA3WmpqWm84ZXNqM0p2cThi?=
 =?utf-8?Q?FCpJfg5l3Q49Isi4VDEAXV+ttzZa3Xow?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFpOenNac2RnOWVDNW5BNlphSHQ3L1MvVnlLVlNzakE1QlpvbnJ4SzdEZWdG?=
 =?utf-8?B?dmdEa0NCK3dDOEg1TGVaMm0xWFpLeUNWTGJURHFmSlQrWEFrWHBYN1ErdW0r?=
 =?utf-8?B?MmZXQkl6UXNxbU1pNXM1WTJWZFpDOE5VSFl0VU80dC9ObjY3a21PbTA1TmRy?=
 =?utf-8?B?U3didzZVakVySmViS1d1eDUrY1YzeGxTNXl0V1JXOHVkS1duUDlpaGxCRWp1?=
 =?utf-8?B?TnZuZEF0cWwzNmFodkZhbkd3QkpLWmNSMytLbXViUGFxQldQc1UzSmhRTnpT?=
 =?utf-8?B?THE1OFRHNER6czFoODZqS3NGUzAzOXZlWU5aQjlTV0J5TWNYYmxXT0NRK1FP?=
 =?utf-8?B?ZER3ZHFGWnBkTDIwUWNKdEVYVE9PTUV2clBFQ0FWTDFmRmtKR1gwNWx1QVVi?=
 =?utf-8?B?WmdqbEJnQ1plaVBmelNBSnZjcUdEcFVGajhNb25EYUpTV1E4MTh1M0N5NS9K?=
 =?utf-8?B?TDVsTkFiYkE4UzlkWkdiZXFPN3JzTi9EcVZxUU9rQkErWDNySHo4ZDVPb2du?=
 =?utf-8?B?OGozNTVpZ3hYNVVmeVdyNU1NQnZGbmE2NVo4TFFGSm1LTTJVakt4ak5XRTdU?=
 =?utf-8?B?Z05pbUR3TVdaT1NYR3dxRS8vWmdLZ0hZdExxVHZROUZ2L2hSWDRVdzgrb05h?=
 =?utf-8?B?ZzhXcXI4REczWlM0N2hHKzJMTjdXUnBPV1VnYnZoZUw1UU9DNDF4N1FxRnFI?=
 =?utf-8?B?cndxZC9EYWVyakpTVEM2Uk5vWDlqUEd4VzFQUVBXVGltRXJaSDU4eXhsWWlI?=
 =?utf-8?B?eEdCZ29CQmZxTEZQUlNaeXNQc1puUTlZM2dyR3VZYW9meWFmK3JIamFJejJC?=
 =?utf-8?B?elp4M05yRVBvd3Q5VlIrSWp5NWUzT3g0NGhEWUVCd2FaaEN6dFBabkcrNTVN?=
 =?utf-8?B?NkdyS3B5ZEd0VDhMdFA5T3RzdXBROW45WmtEY2VHVEl2V2k2OXpvMldwVUJW?=
 =?utf-8?B?L1dMYWVvYW0wRVJLa3IzSEl6RmppUkFCNjNTUnIwV3oyR2RhMk5GSnNHSGRr?=
 =?utf-8?B?dDE2aEF3eFR6UnJiNkxPcTVOTzFqZSthQVdJMEVNc0pXT0pmWllDVjhrSWVp?=
 =?utf-8?B?TnU4NHdnTDhrSzMzZS9JZThxWFlpVHVqMktZa29vL21zcEN0OVFpWDhVb2hE?=
 =?utf-8?B?YldzcE9PVTFqZ0I5SHJQMkhDbHZCMEtBbU80QnVYd2hBY04yMHV3NGliQmJw?=
 =?utf-8?B?TG1UTUZIdmc0THdEVXNWUDI0RFFCUkl1blp3UTVZaStpV3FPWmZFVkhBanN4?=
 =?utf-8?B?c3JBWE0vL3dBQ0x1VXpBNHg4azZRVnV0ZlJQZGZXRVpnRm9BZ09QOHBJQU9h?=
 =?utf-8?B?YXgveUtFSHRZQVo4SVhVazE2MDFHc0hYMURpZmdIVjg3VWtWM1ZsMEtKZ3lW?=
 =?utf-8?B?ekt2SzlTMzFEWVVmWjZMZkNZcVdLM3UrdE9ZWG41SS96VWUrbjdic0RaMU1M?=
 =?utf-8?B?dVA2cFl6ODZmMjVYZW5QWTNXc3BSYjcvc0dTS1daclhqajJwS0J0QVJmZnVU?=
 =?utf-8?B?Q05ONmRNRmhlem1tMm9MNVIrcjdITnVoRkk3NVZZak05WlFtY2dxdFN0STBL?=
 =?utf-8?B?TDJYVGhubEZtUXVQa0liZ1V1MzlrOWUwOGtCRVh4TXZybVM2ZWhvYkdNaVlh?=
 =?utf-8?B?YkovWk05UEsyOG94RWI3RFpSSDRGTEJKUGgvU0NHMnFoQUNVY2ZQcUF5SWJG?=
 =?utf-8?B?Z1VOSVhmZmtUVFpDM25sR2ozUUdGZGEwc2U4eVhSMUMwdmZpSW9YNmNIY3pH?=
 =?utf-8?B?Y3FSdCs2NzEwR0RwUkJjdUF6c3hmS1hudDR6ckNsU1U3UVpmVVh0TVVNTnNT?=
 =?utf-8?B?TkNBaXcyems1Z3NsVjlpemZsQmFvbC9nL2xrN3VYTkJpandUNG5mMjN6dHRo?=
 =?utf-8?B?Zi9pN2YrWmduQnY2OUs4ZkE5ZjhxY2grOEZzdjRVOERja1V2L1I0ZVFPMlRU?=
 =?utf-8?B?MDQ4dXgvalh0eWM1STVZRVlia00zYXdIVy9pOHZSQ21uSWJvbThWVStSMU9X?=
 =?utf-8?B?NUpMcXZlTzE2TXB6d2o1TzJVSkkzb1pTakpKd0V3a2lJRWUzUk1PVElubWx3?=
 =?utf-8?B?UGk5aStzM0ZjUExOU3k2NTl2L0FmdCtTNjVzdTAvTDlNVE82ejdLMERzNHYy?=
 =?utf-8?B?cFBYL3NEYnRTcVA4RWVlQTcrOGF4b3owUHo3QU4rbktuVzhBSmRUa0tpbnZP?=
 =?utf-8?B?VFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ca6bf6-1ca2-4c3f-3a4f-08dd5e8083fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 20:33:41.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: En0c2/xRnGw4V1ivlXy2GS9sNXhm3joRdqV0sNF+55+jhBaH4XA+kJ8eCH7D7Q10Uo8mpAElLkT3qabKmkLCkr9PqSMYF9EfHrocAhLAhNbEiDikfTdS41qUtpPDy/pI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com

PiANCj4gTWlyaSBLb3JlbmJsaXQgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT4g
d3JvdGU6DQo+ID4gRnJvbTogSWxhbiBQZWVyIDxpbGFuLnBlZXJAaW50ZWwuY29tPg0KPiA+DQo+
ID4gV2hlbiBsaW5rcyBhcmUgYWRkZWQsIHVwZGF0ZSB0aGUgd2lyZWxlc3MgZGV2aWNlIGxpbmsg
YWRkcmVzc2VzIGJhc2VkDQo+ID4gb24gdGhlIGluZm9ybWF0aW9uIHByb3ZpZGVkIGJ5IHRoZSBk
cml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBJbGFuIFBlZXIgPGlsYW4ucGVlckBpbnRl
bC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlyaSBLb3JlbmJsaXQgPG1pcmlhbS5yYWNoZWwu
a29yZW5ibGl0QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9uZXQvY2ZnODAyMTEu
aCB8IDEgKw0KPiA+ICBuZXQvd2lyZWxlc3MvbWxtZS5jICAgIHwgNCArKysrDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9uZXQvY2ZnODAyMTEuaCBiL2luY2x1ZGUvbmV0L2NmZzgwMjExLmggaW5kZXgNCj4gPiA2Zjc2
MDU5YzBhYTUuLjU1OGRjODhiOWYwNyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL25ldC9jZmc4
MDIxMS5oDQo+ID4gKysrIGIvaW5jbHVkZS9uZXQvY2ZnODAyMTEuaA0KPiA+IEBAIC05NzcxLDYg
Kzk3NzEsNyBAQCBzdHJ1Y3QgY2ZnODAyMTFfbWxvX3JlY29uZl9kb25lX2RhdGEgew0KPiA+ICAg
ICAgICAgdTE2IGFkZGVkX2xpbmtzOw0KPiA+ICAgICAgICAgc3RydWN0IHsNCj4gPiAgICAgICAg
ICAgICAgICAgc3RydWN0IGNmZzgwMjExX2JzcyAqYnNzOw0KPiA+ICsgICAgICAgICAgICAgICB1
OCAqYWRkcjsNCj4gDQo+IFNob3VsZCBzd2FwIG9yZGVyIG9mIHBhdGNoIDEyLzE1LCB3aGljaCBk
b2VzIGFzc2lnbiBhZGRyPw0KDQpJIGNhbid0IHN3YXAgdGhlIG9yZGVyLCBiZWNhdXNlIGl0IHdv
bid0IGJ1aWxkPw0KKHRoZSBjYWxsZXIgd2lsbCBzZXQgYSBkYXRhIG1lbWJlciB0aGF0IGRvZXMg
bm90IGV4aXN0KQ0KDQpJIGNvdWxkIGhhdmUgYSBjaGVjayB0aGF0IGFkZHIgaXMgbm90IE5VTEwg
YmVmb3JlIG1lbWNweSdpbmcgaXQNCkJ1dCB0aGlzIGZlYXR1cmUgaXMgZGlzYWJsZWQgYW55d2F5
Li4uDQoNCj4gDQo+IEF0IGZpcnN0IGdsYW5jZSwgdGhpcyBwYXRjaCBkb2Vzbid0IHNldCBhZGRy
IGFuZCBjYWxsZWUgZG9lcyBtZW1jcHkoKSwgd2hpY2gNCj4ga2VybmVsIHdpbGwgcmFpc2UgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGV4Y2VwdGlvbi4NCj4gDQo+IEFuZCB0aGVyZSBhcmUgdHdv
IGNhbGxlcnMsIGJ1dCBwYXRjaCAxMi8xNSBvbmx5IHNldCBvbmUgb2YgdGhlbS4NCg0KTm90ZSB0
aGF0IHRoZSBhZGRyIGZpZWxkIGlzIG9ubHkgdXNlZCBpZiB0aGVyZSBpcyBzb21ldGhpbmcgc2V0
IGluIGRvbmVfZGF0YS0+YWRkZWRfbGlua3MuDQpCdXQgdGhpcyBpcyBub3QgdGhlIGNhc2UgZm9y
IHRoZSBmaXJzdCBjYWxsZXIsIHNvIGl0IGlzIG9rLg0KDQo+IA0KPiBtYWM4MDIxMS9tbG1lLmM6
Mzg5NjogICAgICAgICAgIGNmZzgwMjExX21sb19yZWNvbmZfYWRkX2RvbmUoc2RhdGEtPmRldiwN
Cj4gJmRvbmVfZGF0YSk7DQo+IG1hYzgwMjExL21sbWUuYzoxMDEyNTogIGNmZzgwMjExX21sb19y
ZWNvbmZfYWRkX2RvbmUoc2RhdGEtPmRldiwNCj4gJmRvbmVfZGF0YSk7DQo+IA0KPiA+ICAgICAg
ICAgfSBsaW5rc1tJRUVFODAyMTFfTUxEX01BWF9OVU1fTElOS1NdOw0KPiA+ICB9Ow0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL25ldC93aXJlbGVzcy9tbG1lLmMgYi9uZXQvd2lyZWxlc3MvbWxtZS5j
IGluZGV4DQo+ID4gOTU2ZDMzYjIxOWRmLi4wNWQ0NGE0NDM1MTggMTAwNjQ0DQo+ID4gLS0tIGEv
bmV0L3dpcmVsZXNzL21sbWUuYw0KPiA+ICsrKyBiL25ldC93aXJlbGVzcy9tbG1lLmMNCj4gPiBA
QCAtMTM2MCw2ICsxMzYwLDEwIEBAIHZvaWQgY2ZnODAyMTFfbWxvX3JlY29uZl9hZGRfZG9uZShz
dHJ1Y3QNCj4gbmV0X2RldmljZSAqZGV2LA0KPiA+ICAgICAgICAgICAgICAgICBpZiAoZGF0YS0+
YWRkZWRfbGlua3MgJiBCSVQobGlua19pZCkpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICB3ZGV2LT5saW5rc1tsaW5rX2lkXS5jbGllbnQuY3VycmVudF9ic3MgPQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYnNzX2Zyb21fcHViKGJzcyk7DQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIG1lbWNweSh3ZGV2LT5saW5rc1tsaW5rX2lkXS5hZGRyLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5saW5rc1tsaW5rX2lkXS5h
ZGRyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFVEhfQUxFTik7DQo+ID4g
ICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY2Zn
ODAyMTFfdW5ob2xkX2Jzcyhic3NfZnJvbV9wdWIoYnNzKSk7DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgY2ZnODAyMTFfcHV0X2Jzcyh3aXBoeSwgYnNzKTsNCj4gPiAtLQ0KPiA+IDIuMzQu
MQ0KPiA+DQoNCg==

