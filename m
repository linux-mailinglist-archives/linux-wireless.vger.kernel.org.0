Return-Path: <linux-wireless+bounces-23846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E9AD1B71
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AA43A94A5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF162517A4;
	Mon,  9 Jun 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeSM+alC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4B2528EF
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749464552; cv=fail; b=G7iBaByF4q+cjoqz7tvnTkb4gkJQxVnAxFdks+pDfB2FydNbQrnee++yWusek1kkP0NETmp7JjU+UY9ZLn2AGH8619Tx+bUk9yqgmwZUpQsonOc3HsnJWS0JVt13tXnLJ5VX6+WG3mdhLb54caTdiLdzT43HiACQ+1v9oFY5i5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749464552; c=relaxed/simple;
	bh=KxgH2Sl9bhwcmUjPcb/p//b22MRj3vAp/73J6Td3sd0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a/qn9avdUJw3guwx7agLy2iROJxF/BVF3X5CKbkJkMqgSGySZ2wQkv90E8X6Dwga1vgKGNhKKigkNDrEf+XtoAkEwqMk0ylcIugaSrocQpY17RF8PQXPevUaLDj1jn9dJ97I2PHmYQLppCMHYdbEds3xyqTeU9wpI0+qKXdbn6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeSM+alC; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749464551; x=1781000551;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=KxgH2Sl9bhwcmUjPcb/p//b22MRj3vAp/73J6Td3sd0=;
  b=NeSM+alCHqGEaINx4zaqFNfGBlJrq4pWC3c+NtcpAchSIyOgihYrJAJz
   XYCMNHeEmaqtlxd7SokGv/VZ82rj1n8LQttCBr989pzED+mAvzrNm52nP
   Tflh7QExFGRFxHkJbeYZ4KXPg/kp/GTeCFydVXqYgoMdi9z9+PYgi5EY/
   Yp4+1fLKyDY1O9o4UG9qJwRPEHYE7Q5GsM7On0eLXt6Y2CQf9uGKgM39K
   vFESEGWqQz+eOqVaioAiy52PT/PXPOMZyHViWcizNF/+zzeCbmU7iHh0I
   2hZBtm5iS3Jx6lfvN/wLWMLOCMItJu2QPvn0ccvqcNgZIANmFr/3hvLfW
   w==;
X-CSE-ConnectionGUID: oV/Ve5GbQeKpkwuRo1amow==
X-CSE-MsgGUID: 2ZGRgDH2TuiKeth73qo4Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="50647582"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="50647582"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 03:22:30 -0700
X-CSE-ConnectionGUID: IDV7RhVtQG2ANlH+06jk/g==
X-CSE-MsgGUID: /PK3mIwPSiOSqj6Ou1joQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="147053517"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 03:22:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:22:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:22:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iihYUNVMDGRkxDg8JHP142ILeXP1zK2AAp+MFv/Wve9ZBKAPaY4PoRJBEJ8172f2hrllnFDS+PFsXA4S52NRRkh6P7MGuxdekCenkTY2wYBnJsY1LJY3UJc8M4cAfw6yetpUZ6+26+SSsZSH1kAp31pZVKYmTY+p8CNqwhqDyx+LJX1Uu+UpE95UWcyieWmYqGQpY5FgUbdC34fn6M+rGOmIxaqkTqog72joSuvdgeenB9Y/SFssFNSnxPGDMxPQFE5fTY39nbn9uhwes+FWZni6uwoJm1q6D/NNuKD6PumsdZjXtdED+kQCatO875NWnQRHb5xcCqiIFJnOopyaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxgH2Sl9bhwcmUjPcb/p//b22MRj3vAp/73J6Td3sd0=;
 b=qdY7nPPm/95VYA2flBNiAbfgcpA8TAo4grADUZ3BJQsLmP5tNfv5Ro1cbApaOV2XDnKWnIzh83Jj1j4XwuDdrO8/SmFWFOJl6Q1ZYBLwnUaZ4Uo7eS7vl+zcgmY00Wqn9FgiyeWZqhJPqnZosVejnF3ef2RNdcLrsh6M4i5gK/tP56nmVbiizRovNKif6Suek3HqRQP81CYwfewig3jx6N96mMF17k6GH7DZwDcaMc0U2L3QnYRD0cYu/IvgYqPoQFX1RVoUu+KrXCHIDZNOIzgNlTJYCVqTTZcAHO32DEeNwRspYQYpjMr2QzTW7/7jT0dSzjiuyaN4vuyXPYcMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA1PR11MB5922.namprd11.prod.outlook.com
 (2603:10b6:806:239::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 9 Jun
 2025 10:22:26 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 10:22:26 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: Josh Boyer <jwboyer@kernel.org>, Linux Wireless
	<linux-wireless@vger.kernel.org>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>,
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben"
	<ben@decadent.org.uk>, "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2025-06-09
Thread-Topic: pull request: iwlwifi firmware updates 2025-06-09
Thread-Index: AdvZD2JgJjvSehmUQhCifbv2opnHYQ==
Date: Mon, 9 Jun 2025 10:22:26 +0000
Message-ID: <DM3PPF63A6024A9415C3A590026C051A7A2A36BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA1PR11MB5922:EE_
x-ms-office365-filtering-correlation-id: 9c41ec31-a001-4a99-9009-08dda73f8831
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aS9qa0hQcnY0TU9qZGFBSTFVR2duRi9lbGdCK0laUEo2ejZURHJNMHBuRGNs?=
 =?utf-8?B?ZHJDcTJIRHVsTURuUVlZcWR5K3laeUNPbjFNMi9JTnN6WG5oRWh0RVVDeHlQ?=
 =?utf-8?B?NFQrNGJURFY3UThIZkM2MHVGNFR3cVdLNWlVRlp4Vk05R1ZWcEJBUjk1WmpD?=
 =?utf-8?B?ZnNJeFRSMTc1bVZGR3Z2QWtod1dPQ3hUbG9sZGFEVzZab1ZJOUVoME1GcmJx?=
 =?utf-8?B?Y0xjc1JGVWhMWFExQlFPcUJZM0w4OW5RSHNyUXU2ZU9jNlVqRTRxZzFqYTZF?=
 =?utf-8?B?bmNITXYyMXV5Z1RpSEpEN3NBT0NMNWkyRGMyR09yYlNUZ01BTnZUZHllWWpL?=
 =?utf-8?B?K2sxNlJVWjkwVFhnZmRvMXYzOVpZWUZYSXJ6Unl4VlllbElibGJ2U2p5dnNw?=
 =?utf-8?B?TG5WSm8rWi9ZdGt3cTJTck56SzBvY1V1SUxqK2FsZEFvOEcwbnNDOUxiaVlw?=
 =?utf-8?B?dDVkR1ZkM2pkdXpaa3BhYXczM0FJUC9hNmhGeVJ1MzZBOWN0ak12ODNEOFlC?=
 =?utf-8?B?bW85QkNPdVBkTS9lZWo3NVNDMGlGaDRXcjN1L2JrbUZEdTFnRFJvV2lBY2xt?=
 =?utf-8?B?TXgzQ2dIOE44bVpQaC9JdDRiakZ4YTdYaXpTeUw5MmlPVTJ3cTRpdFZSdVN5?=
 =?utf-8?B?VnFGbCtrZE5sNDFweHBVMHZuZVpxQTh1MFIvWE0xOW9QMTlQRnp2aGo2Wnkw?=
 =?utf-8?B?a2hza0szc2ZlcmZNa2JyZ2pmdy9kRy82WVVKQ0pMTXNnL0pXdlFyNmR4cmlB?=
 =?utf-8?B?eEtlWWI5Qm9mUVJLbHdoZjFQQzBoOVRST1N2ZVZpT2lYaXNtRFQ3dzR4eVNQ?=
 =?utf-8?B?M20xUXVtRzB0K3VqWWRGelNlbUlQU2ZSdDA3WU0yT04ybjY1eHg3TVNjTXIz?=
 =?utf-8?B?OHpKQ0s4UXpwWGF5VUV1ZVIvS21sTnBFL1dsTDdreS9YOEtTSmpnM2VnSnRH?=
 =?utf-8?B?Y0haTDExWGZDVGFod214dzBmSVk2UkVxSkFFWC82bEhIU2Y1b3NXc0VjMTAw?=
 =?utf-8?B?NG4xV0JMb2tTUk1iYWxxelNpeDdNZW1jL2c1TUZuSmsvQVBxQzU2c3pkWjlx?=
 =?utf-8?B?bTRucFJRL0x1c05Nbm5xaDIvbmlObjhzMW8wK0c1TTMzVy9EYmNnRldqdW5j?=
 =?utf-8?B?OXRuNzY1SEhFM0xtVmcxa012Z1FVcFdiUmt6N0tpRHVjQmIvOStIS29tZ1hO?=
 =?utf-8?B?YU5tNmRvNHpmSXVUc1BpTTVtK0llaHh4Tmxac2lZT2FDRTJiTXFCaHBYWnJB?=
 =?utf-8?B?Rm05WkNKUVZlb2xRWEk5c2dlUkZyYTRORVNHeVdibVFnZWIxSUNKclU5WGNz?=
 =?utf-8?B?SkpKQXJ1aDBXc0oxbE04MUNLN3BFdzdPZmdZWlBYYkhWZi9Cb0lQTEdScEJE?=
 =?utf-8?B?RjJnVE9FZW1hSFlKYW9mYWV1Ymc1ZUdZQWlYRnlRLy9xeW4rQnhSeE9yZHVn?=
 =?utf-8?B?RDUrSGhIeGJMSitRNVNJUWZyQzZNMzB1Z1ltWC9NTHphSmpPQm5ySDNjMWVa?=
 =?utf-8?B?RjVVU2hRZHE4cXFOa2tjeTdjZ2FSZGR5NnNxVk9QRzlMK0FwZ1BWd2E2M0Fo?=
 =?utf-8?B?bU5SVDRSQ2NOcytLZDJFTS90Q1FHckhpMjBjUlpRandpaXZ2S2pYVjJheDBW?=
 =?utf-8?B?aE9pbWhrVVZPSG5lYlJHUWRUNjVIVjM5dkZoRlRPN05UUEhmcXZyOXRxVnVI?=
 =?utf-8?B?QmNyaWpaQkZWRkQycCtFR2tLZ3NZWmozK1ZUcUdmTUhkOGJHM2lPd2dZTER4?=
 =?utf-8?B?VXRpdU51blV0ZjUxMW43UDNYaWF3WkFjVG5zMEw1djM4VVY2aXVOOXkrcUsx?=
 =?utf-8?B?VzBBL0lGVW9MYlJmNkhxTlVlbjJ4S21McHUrQnBNWnhTMmhDeFRlU28xdTNT?=
 =?utf-8?B?RXhHdmhsT1VCMnkyY3dBaFFWS2tiRUd5TEk5QStRVGozd3M0dnZOS0hPMG5X?=
 =?utf-8?B?QkxObUM1ZWY4TjA1ZENKWjluQ0NYTFJJUlFJYUo0dDhlbGRSUUQ0S0lCZk1x?=
 =?utf-8?B?eG5vSVVjWnZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2xpMUNuVEo2UW9ReFBzQkxDcVFxUHFQcWRTZlR3enFnTTJpdkNZQlN4dDBo?=
 =?utf-8?B?cENpcEVOUFdIQ3NvMjlYeWdZTk9FaXhuM2VISTYrVjBiT1NsaWZiNHc4WlN2?=
 =?utf-8?B?NlNYdUozSFp3d2dVWVkyMWdVVUM1c2FsdmoxTTZtZmhtVGs5RmhCcmY3a0hC?=
 =?utf-8?B?R1BmVVdBU2hNcUd4dFdqRUQrb00xcDRTZG93S1RVcDdhRm1KaXdhaFFPakFn?=
 =?utf-8?B?VXJ4YzhaS2ZYU3p5VU4rTWZSYkdLNWIvc085NlVLYUtFNkU0R3lIVHVFN1kx?=
 =?utf-8?B?SDg5MGtXVFY2a3EwRVZBZStKVWtWWTR0VGt6eCt1ZFFZbFlLRFFwellvOTZF?=
 =?utf-8?B?eDBFbDlEWTIyTzV3OHd3Y2k5UUcwTGs3RkcvSm1ZakdBbEtkNEdGUnZ3QUlC?=
 =?utf-8?B?L0dGZjIyYksxSHpmWVk4NW5LSkVNRTF6ZTdLT29oTnJ3SWNBZ3Y2Ti9KR0o3?=
 =?utf-8?B?Szk2N0J4MmpuUlh5cGxKKzkxQldITmFrb2Yyb3dDeHh2TUNmVTI2WGdjQ3J3?=
 =?utf-8?B?S1VrWlBBQXkyd2tLa2t6QzhpUXJQSjlkRVdrT2IvR1lqeERMSVI1bEh4STRH?=
 =?utf-8?B?Z2U0b2Q2UnB1Rm4zUHZnZGNwZ2I4K0NQamtTWE9nOTdsWWxyMkgvWFl0dnl2?=
 =?utf-8?B?Q2VVS1FmeWJoLzlEYVBJdTF4eEhwcU9DcGRoK05zL2tOZzNpdlQrVDZiUWtp?=
 =?utf-8?B?bnd6alJTaDEzdEhVOUVmRFNrNDhLUEtPTXFTT3lqZDVKd1JXai9rcGFrN0Vw?=
 =?utf-8?B?S1ZhbjdIMU15WllaUkJHdU95U0liUnBiWXpOY2FwY1ZLSFZhKzFpRXY5QkQr?=
 =?utf-8?B?THlxQ21oalcwak4xT2tHZTBORWprcXdzTlRUNXZ5N0FuOC9FVzRXNGhhNGNZ?=
 =?utf-8?B?czh4bEtHNU5YMit4Smoxd1VSeGEvZjV0ZlZNOHovNEc2NHlxWmhnRVlMWWNq?=
 =?utf-8?B?d1ZLaXdDU0JYRXMzUVhIaWlMNXluNFNQbEcvOGlIelNqc0k0TXpVeFJKTXZM?=
 =?utf-8?B?T25iS3c4NEhpR1NMWkp6T3NKWGJZNjZwQlZ0c3RyVlJaRFdaWlkrOWpoczVX?=
 =?utf-8?B?WTlGYXVxVmZobE5PSllYVjNoK01lcUYvcFh6MmRDTU9VaDdUcmV2YXcwV2JZ?=
 =?utf-8?B?TW4vK2JTYm1remJOaEUzNGpyM281c1M2UUc5aElKMWdHVmd1MmZOQzZUUk1X?=
 =?utf-8?B?U1BxS0VuSzF3QmdkYWdGdy9Jc3VyVkZPQml5WkZ3a281V3lSaUZJVmZpalI1?=
 =?utf-8?B?THlDWVNqUlhMMGlsai83Q2NtWDNJT0xYWDhWTUJidmNPN0hXTStpcEN6amVC?=
 =?utf-8?B?dGlVRmVrT2NhdS9HL1NXajN2Tmd4OTdtMU44SE9IQjlzdTFYOEhNZGJ2cWdV?=
 =?utf-8?B?WC9XUTZlNUh0S2FLR1lIenpSSlg1Smw0MVkxdHF2WVRBNXl2eUpqZnN3c3hE?=
 =?utf-8?B?eWpMakVjeC9QUllRenV4VGY5ajNOazEyeithMzNBeU42TE1LRGVOL3VJOEEy?=
 =?utf-8?B?U280MXlkZXppTjBzTklGeWdYWUVaOVE3MGlkYmtiRVBVcllHOFBLdWlLYzY5?=
 =?utf-8?B?OE1sci9URmlLbTlJaWxoRGhzY05JYm1WakNtTGpKZytoUW5ablZQVktGMUlG?=
 =?utf-8?B?dGlUUnhsMGFMdDd6RkhpVnJQa3ZGRVhVbnNZbHJubHR4WmhnUFdQV0l1T3BG?=
 =?utf-8?B?OG0vU0R3ZEdydEFWQnFYaW12RStCQTJmK2I1dE10Ykw0ZE5vQjJwRDlqV0VU?=
 =?utf-8?B?NE4weTdnNHdmOW5PYlB3enVRa2FKM0ZZck9FWS9oTVk5UUFDREpVZ29jRjhl?=
 =?utf-8?B?MGJtenpLQUovNWlLSTVYRmlocTdhUzZsVUpTL254eDRCTlNHNlk0WXNZQlE4?=
 =?utf-8?B?K21GdXJ3bEU2bjVuN3J4YlJwNnpmQUtwWHBUMElSanB2LzFlOURVMkthWk9l?=
 =?utf-8?B?T1BlOG5UdlF1VFVRK2RvaDdQamxiQ2pyNXhrdGJNQ09sZk9LVUdKMUVrL0k0?=
 =?utf-8?B?ZUxLNkp2RkVrWTlzdXlSY2FyRXg4L1ROTnBoRm4vcDc2TXdIU0I0UitKbGMz?=
 =?utf-8?B?dDlnY0JpOTJCK2dudnBwZ0Y4Vm91WXZkNDNDb2RBekhZTGZGV0QxT0VKOGlU?=
 =?utf-8?B?YmZEdlovK1ZlUFVVaTFhaDVKTWkxN0hYSlJSNW5YdUl6UGZHYjBmS3Y5NWZj?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c41ec31-a001-4a99-9009-08dda73f8831
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 10:22:26.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4tPpeGPt57B/xEsrJTmtfNrtpjldlzKvTr7RCtfkEYhPqM881mKY0ng7ZHaihGTwe17unL+ywDEt6jXoTQcei9zgQV/DtFvPcH7j8TpYeZiC0icoPzE4i4fR842uEDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
X-OriginatorOrg: intel.com

SGksDQoNCkR1ZSB0byBhbiB1bmV4cGVjdGVkIGluY29tcGF0aWJpbGl0eSBiZXR3ZWVuIHRoZSBG
VyBhbmQgUE5WTSwNClJldmVydCB0aGUgRlcgYW5kIFBOVk0gdXBkYXRlcyBmb3IgdGhlIGFmZmVj
dGVkIGRldmljZXMuDQoNClBsZWFzZSBwdWxsIG9yIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBh
bnkgaXNzdWVzLg0KDQpUaGFua3MsDQpNaXJpDQotLS0NCg0KVGhlIGZvbGxvd2luZyBjaGFuZ2Vz
IHNpbmNlIGNvbW1pdCA1YWM2MzAzMDYyZTRmMDUyMTAwNDM5NzgzY2YwNmYyNmM1NTI5YjRjOg0K
DQogIGFtZGdwdTogRE1DVUIgdXBkYXRlcyBmb3IgdmFyaW91cyBBU0lDcyAoMjAyNS0wNi0wNiAy
MDo1ODozMCArMDAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6
DQoNCiAgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3
aWZpL2xpbnV4LWZpcm13YXJlLmdpdCB0YWdzL2l3bHdpZmktZnctMjAyNS0wNi0wOQ0KDQpmb3Ig
eW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNzczODAzMWM0NGEzMjViNjMyNDdmOTg0ZDE5ZDNh
NTc4NDIzZjVmMzoNCg0KICBSZXZlcnQgIml3bHdpZmk6IGFkZCBCei9nbCBGVyBmb3IgY29yZTk2
LTc2IHJlbGVhc2UiICgyMDI1LTA2LTA5IDEwOjE4OjE4ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpyZXZl
cnQgY29yZTk2IGZvciBCei9HbCwgZHVlIHRvIEZXIGFuZCBQTlZNIGNvbXBhdGliaWxpdHkgaXNz
dWUNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KTWlyaSBLb3JlbmJsaXQgKDEpOg0KICAgICAgUmV2ZXJ0ICJpd2x3aWZp
OiBhZGQgQnovZ2wgRlcgZm9yIGNvcmU5Ni03NiByZWxlYXNlIg0KDQogV0hFTkNFICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxMiAtLS0tLS0tLS0tLS0NCiBpd2x3aWZpLWJ6LWIwLWZtLWMwLTk5
LnVjb2RlIHwgQmluIDE5MjcxOTYgLT4gMCBieXRlcw0KIGl3bHdpZmktYnotYjAtZm0tYzAucG52
bSAgICAgfCBCaW4gMjk2MDYwIC0+IDI5NTM1NiBieXRlcw0KIGl3bHdpZmktYnotYjAtZ2YtYTAt
OTkudWNvZGUgfCBCaW4gMTc3NzQ2NCAtPiAwIGJ5dGVzDQogaXdsd2lmaS1iei1iMC1nZi1hMC5w
bnZtICAgICB8IEJpbiA1NTIwOCAtPiA1NTIwOCBieXRlcw0KIGl3bHdpZmktYnotYjAtaHItYjAt
OTkudWNvZGUgfCBCaW4gMTU3ODg0MCAtPiAwIGJ5dGVzDQogaXdsd2lmaS1iei1iMC1oci1iMC5w
bnZtICAgICB8IEJpbiAxNzg4IC0+IDE3ODggYnl0ZXMNCiBpd2x3aWZpLWdsLWMwLWZtLWMwLTk5
LnVjb2RlIHwgQmluIDE5MTI1MzYgLT4gMCBieXRlcw0KIGl3bHdpZmktZ2wtYzAtZm0tYzAucG52
bSAgICAgfCBCaW4gMjk1NzQwIC0+IDI5NTAzNiBieXRlcw0KIDkgZmlsZXMgY2hhbmdlZCwgMTIg
ZGVsZXRpb25zKC0pDQogZGVsZXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktYnotYjAtZm0tYzAtOTku
dWNvZGUNCiBkZWxldGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1iei1iMC1nZi1hMC05OS51Y29kZQ0K
IGRlbGV0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLWJ6LWIwLWhyLWIwLTk5LnVjb2RlDQogZGVsZXRl
IG1vZGUgMTAwNjQ0IGl3bHdpZmktZ2wtYzAtZm0tYzAtOTkudWNvZGUNCg==

