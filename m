Return-Path: <linux-wireless+bounces-25083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7FAFE3E0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354EA172709
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C0425C810;
	Wed,  9 Jul 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQ6WWEDX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D627E7E3
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052689; cv=fail; b=KYF1VpLnsKNaIeKKMVaW58UwRwwMDrkJXwqzcv8l02s9joJGEHAu62OChrpBnl5Kg+GLCbQ9o5e7sJ4qcekDN+LSOmyJMcuMn5eJCkeT3nXhAqz1vWPvzBxN8dQ5BppbZ6OP70I4dYerbTxx8F7gZbKuQdQTKEfN4mgJJXRTpEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052689; c=relaxed/simple;
	bh=D3OAT4ryBkUIAW0C3eRfRn9tKWXbVF02U3NOYwlqJ7w=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pctDfLAJTDWRKqU1zcaDUqXVm+L8NXzEmpDtQuFdGqx88JsPisWt2I5EwkPnzYZXvgZbg5nDLfvqBhudsidjXD1ADDxNtS3ZFHBpOQpPuetxDxNgbK2+EUmRrjuBov91RIxNx5aa/wrBMbZd4OR/3NxOyUfMi+7OcHOnKI+ZX0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQ6WWEDX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752052688; x=1783588688;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=D3OAT4ryBkUIAW0C3eRfRn9tKWXbVF02U3NOYwlqJ7w=;
  b=MQ6WWEDXinhsjylgwzugyJXjrNa/QDE7dqY9DUNb5ykNuRXIDnPUO4b8
   bfVrPawibGrnE1jlPAMJnsl9FfyiuIDnLq7MLw0yjzJoXKn96QsxOJOND
   AT09/ppMNYArmOUYnmFMwnuSB3YpQb1Xsoo45Jdocvj67zN1Zbon9h1HS
   Za06GC5B9buuO/DJaF3CgwUyAATFlAZfdfLSV4HYrvaueahHxb73ZWIsS
   Qtnm8tfn01qj98uZ6NhAE2LpWDUQvcANt5RzhuR6lHMulBsInI8NDXIix
   xRe+BtcEw53w9iz1JKFYnAALJDHtMa7GUZPjEgxiDAA5ZP6SELTvp2leW
   A==;
X-CSE-ConnectionGUID: FHrki0UeS/6bF9LsFog8GQ==
X-CSE-MsgGUID: CmUx8nBcSyaccscA6DOrhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71891231"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71891231"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:18:07 -0700
X-CSE-ConnectionGUID: HVAo9pCrQMmh7k/lz6ysIA==
X-CSE-MsgGUID: n4hPYTHQQA6JF0wygEUA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155362729"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:18:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 02:18:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 02:18:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 02:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6/tfdVatJKhMkP2/l565Mv7MYu6ghKyF4CQMhGv8IMHLg/QUvv85GOLr31i2bS6gCT2furLEeKwm5lKpoHlvctUqrmKOSCrMLMlXKWy5iMcnEEnxm26MueynHRHb5QD15ZP28ciH9EDS58ypy8+5Kj0gFHU/jNvVAZoWPTD9JdcQREZp8ZRO7SmlTMBYTvkRoNPkvTtErWlnKU9xUThffJ1RLNVawQbcQEHTzdn170RWHPlyRBB7r8EvawtvIZJCgP4yTtwUs/krGj4wuEnftpJkOc1+O03CV2vaibktW+pz0xfPPh0zAPS1LRPLdZUVeQ9lkX7tl68aLbaAxVuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3OAT4ryBkUIAW0C3eRfRn9tKWXbVF02U3NOYwlqJ7w=;
 b=XWRGLi0nqh6eK23kpLMI8FWJyoOVcMFmJv7njwIFwgNPtClX6wHcvnblWmgipvhlgqWSoRD81AkVKmwt3NhIH05bXLPbNN20H8J5QKZWZh9OekEOdXlh73pbPbRmRTDM9aAxPyPIwfAXJCGxVZaSlKw0RgTwc+8tka8/qLr8BqfPw8UD0Hp1ac4oQk5j5dA9xB5bN/+9IyUJF4iJxXWYCxmLCkjyOVcIU0X3sgSHIy0BgV9Y2EooLZ1DZaCqetaCeIG+g5BghQcwsa6GvCBbtwEp/zArSwu7uFFwUX0Jz48XQJw+rv9waubmRGs0kLxSvdjDcjec5UU0mDia04M1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MW3PR11MB4716.namprd11.prod.outlook.com
 (2603:10b6:303:53::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 09:17:31 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 09:17:31 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>
Subject: pull-request: iwlwifi-next-2025-07-09
Thread-Topic: pull-request: iwlwifi-next-2025-07-09
Thread-Index: AdvwsGGNqFne/em+Qb+8shUBe5R3eQ==
Date: Wed, 9 Jul 2025 09:17:30 +0000
Message-ID: <DM3PPF63A6024A9A67E123BBD3E8CCBF35CA349A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MW3PR11MB4716:EE_
x-ms-office365-filtering-correlation-id: f05334b6-20a7-48bb-be03-08ddbec96ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dHpqTkVERlZQamhJZFVOS2htbVFhS0loclBQN1J6MTFHOHVGSG8wYmUyWFRC?=
 =?utf-8?B?NW5BTis3WGxncjlDRU4rTGJaODNjL3FVR3J0VnFhSEZlNWs1eFdzc1NQN3lH?=
 =?utf-8?B?VjNoWWZlbU9HL0xzVlQwYURCUHNqbDVYdUQvSGF1OHZpSGNtdnNSOWpMWkYy?=
 =?utf-8?B?bGEyNHp1VVhTYTU3OURqdmdXYjhTUGFyNU9iUm5lZGFPWHZGb3FLV001dUlR?=
 =?utf-8?B?UllFSVR0Ykg1UzFHL1BSWmNVUFBTcUZ4VHVNNHhrb3M0Y3RkMXV2YUxDU0VC?=
 =?utf-8?B?Qmg1OVJSRGFsR2tiZGwyQ05UTWw2VnB6R2l0R253MW5IcTVzMm9VM1lWTklm?=
 =?utf-8?B?RndaTllVbTFNRHpLWmM4Q2FMeVVUMklreTRPUC9YSFFRd3FUY3VielBhN1FM?=
 =?utf-8?B?M2dIQlF6ODgvM1lnck1DdE1xK2NLVjM1bGJCSHBTRlFBY1Q3Z3FQdVQ4RkFQ?=
 =?utf-8?B?em02anFveFRESFhiaXdHTmpuK1lSZ1JCYzNtNElnOWFQTzVzZTlRS2xpcUow?=
 =?utf-8?B?SjJDMkpOVmRiOWl4Y29kc0FxOHNVV3pZVDdkWWFCMDFEdHhkTFpMdm9IWllI?=
 =?utf-8?B?eWsvT2pnZ0ZBZG81Q00zWlVsbHFmRXJPZXVWOHdqNWppTkJzZnlBMGM1TE5J?=
 =?utf-8?B?UXZYL3hJMnRmWkZUVlFiM0F2YTZYbXI1QVpjTzkrY2p4d1dUY1ZGVXVXcVQ3?=
 =?utf-8?B?ODdyc3NwZlRXczRXejhVcVAvSDRmV285T2cvR2FmK05yUmpiclNZSmRVN0l2?=
 =?utf-8?B?ekUyYmRtNlMyajZXYTRxUWlkSmZOcjZHcHJ5RG5zTC95ZjN2bWJ6R21FYXk4?=
 =?utf-8?B?S2F6L1RtOWZQSXRBNythdXRIQVpldWJPbFhJZ2FxZ1lMbWVCQWpEaUN4blFu?=
 =?utf-8?B?c0pZdmJFMUl5dWFhZVBMMXdtUTNDb0Q4ZlJlQitlUUFNSzQyWUlSeFRaQWpq?=
 =?utf-8?B?RnZEU1M5V1hUcytNMnA3QUN2Y2dJMk55MkZKQ2JaVURHSTl3UFJXcUJkMGJL?=
 =?utf-8?B?a2w2UFFsT28xeEx4SjZxZnlGYUdkMU8rNG5sMG9JOVRPTGZIeWU1WkRYOWNY?=
 =?utf-8?B?WGJGcmZVc2owMEpCbjNxQm1OUzRWNzQ1ditBMU1nWjNpRmRkWlRZVFdSSFlp?=
 =?utf-8?B?d2cvdms2RENtOVpWUUVEUkJ6eENXNTdjeHNXNFUxbkRjSWM3MkxHOTdiWVQx?=
 =?utf-8?B?K3FIVlA5bWZGMnU3VzI0Mm5FSGY2Z0tON2JsbjhwMVVBZHRIMlg0eU45MUFG?=
 =?utf-8?B?aEFpVmR0RGw5bHF3WnJqbkFHZXlvQm1pcURlSkJOd28wNmxiQjNhcjJ4Z0ti?=
 =?utf-8?B?RnJQNThiSHVqdHdhbzhMY2NDNlNLOG85UjdIZTZ4YzhscUZOcVhmMGRvMldq?=
 =?utf-8?B?b3NuMVkyRmNaNWl5WEJCbkR5UVh1NTNIRjVWdkF1czY5RG9wSXZuSUZJMmhJ?=
 =?utf-8?B?d1NDbmxhazZpRDZZQVp2aVZDdGExUG1YYlZqUHlPNmU0a3ZPbmpTeGpuVXU0?=
 =?utf-8?B?TENTR3VoaEFrcFpEdmkvZU5BcW9GRU1EOGFYbTNQUUNnZmxlSDVaTHlMbmtD?=
 =?utf-8?B?bzU1TDRQQTZwa05BdHU4QldESmxia3hKS2dOSVluYll0ZThaMklIb0tjMnlO?=
 =?utf-8?B?YXNjcC9VUWxrUVpQRHV2YlZ5dGJHdUQrUTd3NXFaTFBDMy9HSG41Z1ZhK2ZZ?=
 =?utf-8?B?Z0NNM0lkcGtGRldEdDRzdEQ3SGlIZnBraUk5K2ZaS0N6eHdaSFo4c1RGOUpB?=
 =?utf-8?B?eUphNVlTV1NqV0xkbXVPMWxwQ3JoUWtrM2Y0K2Zsemh2OVA0dFlEVndUWFB0?=
 =?utf-8?B?emZuclpRbmhmdnozM1lYR0FrZ3FmVHVIeXo3RjBzZ3RxNFJCN1ZVTHFzQ2FO?=
 =?utf-8?B?ZHQ0NktpU1NqaHIrbXpiUlNvZXlyVFlySVhpSVRGaFRJZVVMeUxma3ZtZVNN?=
 =?utf-8?B?VkxXTk5heDhPOUVPVVpJTmZyQUh3TzNxbXdsRVF6cFRuRHlzclVnREVVd1Ix?=
 =?utf-8?Q?ssG8iRqlGg+Zk/HJ917lWOzKwFB82A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1IzTmk3VTlENDRmTlpNVmNMWkVqZzNEajMrTXFQVFpGRmtuRDEzVTlCTWdZ?=
 =?utf-8?B?elNFNVliNjFtV2Ewc2QxZE9ObzB0OVh0VExnbFpVemZZQ1k2ckJrYmdaNzVm?=
 =?utf-8?B?cStmdDdVdml0d0NUVjBrWkRLWkRnaUVFZDlzYlZnMi9GeDFTWk14RkU2aFdG?=
 =?utf-8?B?RlR1bXlxWkFSaWF3cWxRbHhOSWgzNDgrQkV5YVRqZitCL3UyMVovOXVWaGti?=
 =?utf-8?B?RWwyNllCQzF3amUwK2VzZGN3MkRGdjVxTDhPNnpHUklpakJPb1dZYmFpN1E0?=
 =?utf-8?B?QWZMVWtQcW1ZTXphRS9xRytmN0JXZEhLLzFtZmlUZHgyWVRob0hBejRmRlAy?=
 =?utf-8?B?aVp1aTBuRGFUOWR5cGp5Q1piSlJESUlMekkyck5EMGRHdzhXYWY5UUdmNVBT?=
 =?utf-8?B?MlJyRkhwNjcwZ3MxRnl2d04zZENDSllRZU14aGtBbDYvWVFPZFNRWExHMzZG?=
 =?utf-8?B?YVVxUlVDdVRFRk9HQ3kwK2lmaDV5NnpGRnkwZEQxRXp2OVo5YlZiMXk3bjNj?=
 =?utf-8?B?NC9OOW44cFFsTXN5KzZFUUlrUXBwYzB2bFpFbDRnOVhzcy9ENmJEYkFHY2Qx?=
 =?utf-8?B?NU1wNHhoQmlFWk03NUpReU5XaGR6SC9QblhhUDhVNjV2R0t1WTdzbXhnQWJt?=
 =?utf-8?B?Y2dpZWJQNllYSmFzNDRHd3c5U1NtbWRUaG1wcE9PM1QzakRxNFlFaDdXMU9Q?=
 =?utf-8?B?M3h2ZTRocHdZc2tnV01LN3o0Q0ZIdkxtNm9iRXZTeHdES01abzBHZUdmd1lu?=
 =?utf-8?B?dDEzbXdkUVExY0ppZUg1QVd4UWZBTnYwd3I4aktjcXlrTzBJV0svbnRvU29K?=
 =?utf-8?B?dnRhUDNvZnU3eERGbFlZenpRN0k1dm01RWFUUWd4N3dnRURrdnJ6MXY2cVNq?=
 =?utf-8?B?VE11ZDhENkEvU0xRU0NTWmNaQUZaYmNGTGNiS1hJcllpOG9nYnJ6b0pWVzhV?=
 =?utf-8?B?SXE4bUgzSlM4NXZMNW05ajNTQnhkdHEvODI5YVFrMWJiU3dWdWIxVHlIVWU3?=
 =?utf-8?B?VXdBeHFBdTJFWEZDdi9ZdjQ3SXhBNEFwS0lDT2hiMlE0WG1tMVphaHBRU2kz?=
 =?utf-8?B?dG4rMERiRjh4YlpRZnFsQm45WkZQZ09TYnQwOU1Ca3d2bE80djBoZVp1YmEv?=
 =?utf-8?B?NitjNW1MODdZL3hVMXQxVkRqbjR4dEpDTDRMSlVlNUdRaVBZZUdTWmRIdlN4?=
 =?utf-8?B?VnFaMy83bjk1b1FrRGxndk14SytFZUZxTnc1VVBnaE9RRnkzdXovSEJaVXRO?=
 =?utf-8?B?c0M0bzh4WTN0cDRTQ2FIWDl2WlVBUlJCNGVFS1RyZTZFcUtoM2xQZTJPbSs1?=
 =?utf-8?B?NGFyUGpEK2E5T2RiUjcybHd5alZKUG1taEtxWHlWbyt6SmZaR25DUnI2RmtR?=
 =?utf-8?B?SUJEQTZ1WFpRWEpCUG5QYm8rVEllbXNaUXB2MG0vaTkyN2RTaXV1M001aE1h?=
 =?utf-8?B?cUlDamdVZlUybDNqSVZlMXFUQVBablp2RkhUTnp1dWdaeHhFVTJrZ3FkaHZR?=
 =?utf-8?B?cjZLaDJmalBGeGtkRmZndmJvWkRQU1ZMVGcxVFRvdldaQ1lVYVZPd2czS3lB?=
 =?utf-8?B?TEN6Ty8ySWZSMzdsS0F2MlhEN1FQWnQwdlU1MW11cFV6TkVqaG5Ia3VBZnI4?=
 =?utf-8?B?ZTZiZ3gxdUZNdmlRcXI0Rm9rZlZ4dVpOK2R2cEVtbk1kcjU2K3hhVXlWR1hV?=
 =?utf-8?B?cVIzTW54TXc4VUp2RkxRdTQrUFZ6UHpOK2piN1V3VEtIOW1aN2w2N3p0eTA1?=
 =?utf-8?B?dmVYVXMxYmp1NUlLSDdxU1FSRmdzKzZGOHFYQUxOeTlzT3RpSDJOYVp1NjRG?=
 =?utf-8?B?L1BCbTJuQjVZUUE5Y0JzamdhZXFSb2pOdTc0M3hESzZ2cjdPWU5BUSt4cytv?=
 =?utf-8?B?bHlXcENQbjBCYzgxaDc4d3RSR0NIYU5MemFzdVMwMHRUMXRqTmVMYy9TUEJp?=
 =?utf-8?B?aENCT2RqUUlid3NLT0wvYVp2bUFsUmFoeTNZcGNzcDhkZ2ZoSW9rb2o3SSt6?=
 =?utf-8?B?Nys1Y0Q2ekR3VXUyajZ5aXlMZUhJVVFKN245bnJxNWtZRjRGWEtKdTFQYlpy?=
 =?utf-8?B?RkNVMmZqWHgzQ1ZZaHpWS3RBVkF0Yk40WU1LQnd3THp2OGJhRnkrRzFxb2VT?=
 =?utf-8?B?UVdwQ1VWU09ldTMrU0I1b3pIMDhQQVQyMFpod0k2c1VDM0FlT0wwTk9RUTA0?=
 =?utf-8?B?OVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f05334b6-20a7-48bb-be03-08ddbec96ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 09:17:31.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IulJ514WkPPpFdmOMjJUNMRPRkNYNY5fpAWjIIbAJQ4wno1vjspI6MR//n0TXkXsYNUuMfrung65ouZAQ5eXfBoyYTXJHWYoeI4DZz1OADk1i8A8Awvtnt6c2WHaTYzB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyOGFhNTJiNjE4OWYxY2M0MDlmOTY5
MTBjNjNmYTFiOTkzNzBiOTllOg0KDQogIE1lcmdlIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0ICgyMDI1LTA2LTI2IDEwOjQwOjUwIC0wNzAw
KQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3bHdpZmkt
bmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1uZXh0LTIwMjUtMDctMDkNCg0KZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIDM0ZjI1NzM2NjFlM2U2NDRlZmFmMzgzMTc4YWY2MzRhMmZkNjc4Mjg6
DQoNCiAgd2lmaTogaXdsd2lmaTogbXZtOiByZW1vdmUgc3VwcG9ydCBmb3IgaXdsX3dvd2xhbl9p
bmZvX25vdGlmX3Y0ICgyMDI1LTA3LTA5IDExOjQzOjE2ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3
aWZpIGZlYXR1cmVzLCBub3RhYmx5Og0KDQotIFBOVk0gaW50ZWdyYXRlZCBpbiB0aGUgdWNvZGUg
aW1hZ2UNCi0gbW9yZSBjbGVhbnVwcyBpbiB0aGUgdHJhbnNwb3J0IGxheWVyDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CkRhbiBDYXJwZW50ZXIgKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogRml4IGVycm9yIGNvZGUg
aW4gaXdsX29wX21vZGVfZHZtX3N0YXJ0KCkNCg0KSm9oYW5uZXMgQmVyZyAoNSk6DQogICAgICB3
aWZpOiBpd2x3aWZpOiB1c2UgUE5WTSBkYXRhIGVtYmVkZGVkIGluIC51Y29kZSBmaWxlcw0KICAg
ICAgd2lmaTogaXdsd2lmaTogbXZtL21sZDogbWFrZSBQSEMgbWVzc2FnZXMgZGVidWcgbWVzc2Fn
ZXMNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHJlbW92ZSBJbnRlbCBkcml2ZXIgbG9hZCBtZXNzYWdl
DQogICAgICB3aWZpOiBpd2x3aWZpOiBtYXRjaCBkaXNjcmV0ZS9pbnRlZ3JhdGVkIHRvIGZpeCBz
b21lIG5hbWVzDQogICAgICB3aWZpOiBpd2x3aWZpOiBwY2llOiByZW5hbWUgaXdsX3BjaV9nZW4x
XzJfcHJvYmUoKSBhcmd1bWVudA0KDQpNaXJpIEtvcmVuYmxpdCAoNyk6DQogICAgICB3aWZpOiBp
d2x3aWZpOiBidW1wIEZXIEFQSSB0byAxMDIgZm9yIEJaL1NDL0RSDQogICAgICB3aWZpOiBpd2x3
aWZpOiBwY2llIG1vdmUgY29tbW9uIHByb2JlIGxvZ2ljDQogICAgICB3aWZpOiBpd2x3aWZpOiB0
cmFuczogcmVtb3ZlIGl3bF90cmFuc19pbml0DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IHJl
bW92ZSBNTE8gR1RLIHJla2V5IGNvZGUNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogcmVtb3Zl
IHVubmVlZGVkIGFyZ3VtZW50DQogICAgICB3aWZpOiBpd2x3aWZpOiBidW1wIG1pbmltdW0gQVBJ
IHZlcnNpb24gaW4gQloNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogcmVtb3ZlIHN1cHBvcnQg
Zm9yIGl3bF93b3dsYW5faW5mb19ub3RpZl92NA0KDQpSb3RlbSBLZXJlbSAoMSk6DQogICAgICB3
aWZpOiBpd2x3aWZpOiBBZGQgYW4gaGVscGVyIGZ1bmN0aW9uIGZvciBwb2xsaW5nIGJpdHMNCg0K
WWVkaWR5YSBCZW5zaGltb2wgKDIpOg0KICAgICAgd2lmaTogaXdsd2lmaTogcGNpZSBtb3ZlIGdl
bjFfMiBwcm9iZSB0byBnZW4xXzIvdHJhbnMuYw0KICAgICAgd2lmaTogaXdsd2lmaTogcGNpZTog
TW92ZSB0eGNtZCBzaXplL2FsaWduIGNhbGN1bGF0aW9uIHRvIGNhbGxlcnMNCg0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL2J6LmMgICAgICAgIHwgICA0ICstDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvZHIuYyAgICAgICAgfCAgIDIgKy0N
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9zYy5jICAgICAgICB8ICAg
MiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL2VlcHJvbS5jICAg
IHwgIDIxICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vbWFpbi5j
ICAgICAgfCAgIDMgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2Fw
aS9kMy5oICAgICB8ICAxMyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZncvZmlsZS5oICAgICAgIHwgICAzICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL2Z3L2ltZy5oICAgICAgICB8ICAgNSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9mdy9wbnZtLmMgICAgICAgfCAgMzIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL2Z3L3Budm0uaCAgICAgICB8ICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvaXdsLWNvbmZpZy5oICAgIHwgIDExICstDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtZHJ2LmMgICAgICAgfCAgMTQgKy0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1pby5jICAgICAgICB8ICAgOCArLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWlvLmggICAgICAgIHwgICA5ICst
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuYyAgICAgfCAg
MzcgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5oICAg
ICB8ICAgNyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2Z3LmMg
ICAgICAgIHwgICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQv
cHRwLmMgICAgICAgfCAgMTIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS9kMy5jICAgICAgICB8IDIzMiArKy0tLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9mdy5jICAgICAgICB8ICAgMiArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3B0cC5jICAgICAgIHwgIDE0ICstDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jICAgICAgfCAzNTAgKystLS0tLS0t
LS0tLS0tLS0NCiAuLi4vd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi9pbnRlcm5h
bC5oICB8ICAgOCArLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFf
Mi90cmFucy5jIHwgNDEzICsrKysrKysrKysrKysrKysrKy0tLQ0KIC4uLi9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi90eC5jICAgIHwgICAyICstDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS90ZXN0cy9kZXZpbmZvLmMgfCAgNDUgKystDQogMjYgZmls
ZXMgY2hhbmdlZCwgNTYzIGluc2VydGlvbnMoKyksIDY5MiBkZWxldGlvbnMoLSkNCg==

