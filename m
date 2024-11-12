Return-Path: <linux-wireless+bounces-15205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7665B9C5B68
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060F11F261E2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283731FF5F7;
	Tue, 12 Nov 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp84dvSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684771FF7DD
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423858; cv=fail; b=TDzFKECiGdj7xRkLHB6iCmUN4wBnWKUu0kYZwc26MQIfhqZxV2/cXHv5rN0mzocQJyKyIFP5H+rej11mAXCEEwYRGUBCxPjVJngS7GQKkRV9jc1g+toulk4VeBcwJlMGXXVPZv8IuVLxcre7zRhatF8w6sPvoRB+MzORVEoRO/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423858; c=relaxed/simple;
	bh=YgDAhq9J5acMCDpjhGjttb4WWtzc3JUwjuaFev0+tIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBzKfUp+uP968qkvJk6epBeaINS9zZJW3bdAeOy2T09CvAiGSQEa5jutroYlIss9Ay5e1YE+eyva0zK8pd0aF6TOFWlbhV9Nfd5lnPvx9zlxVmdos8Z43mD/IWzsFw1zqmQrSK5W2oGX3Z/Phwx8OtTxJHqsNRn854zCb5fOuvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp84dvSF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731423856; x=1762959856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YgDAhq9J5acMCDpjhGjttb4WWtzc3JUwjuaFev0+tIA=;
  b=cp84dvSF9CMYnBtBk2gIeTe2q2GFVfpIye2ZJ1KPn+U/lTW2R+l8jqA3
   X7LXnzuzdAsU52uzC1O4PYgFKaE40WVuSx44oSHVvZNga3tvkpSc6f2Ei
   mHG/ehVCdtHlFyiv3s58eo2t5DxlQ5JCeJdzfKcb4XHYRF9Ho1ymUeu4P
   x9Yv/LZB2E8EEb1IQL7EXGDxmAXy+ZbTkmgCUTKPi7ozSMpG6DKOWK2en
   HWyUVRqoBkv3/+y/OFswty0nbL0BAvhwMNb+GBUL1eYpi8FbjlwJygUDQ
   sCj+P3Bi6xOpbe0Iq9e0vo1OuYIx1TN607gXjgUngbGKbPR7HIWVHAcsN
   Q==;
X-CSE-ConnectionGUID: 5eHAJ4zgRceV3fIs9SDe7A==
X-CSE-MsgGUID: QLMh86ICRq6bLda5lttamw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35049385"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="35049385"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:04:14 -0800
X-CSE-ConnectionGUID: 3V0z3QBoShWGoBqivEcTEw==
X-CSE-MsgGUID: bAtvniVuQ+2jTkkE/KPIsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="110790958"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 07:04:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 07:03:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 07:03:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 07:03:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUBqV7WdObEjkl8YpuOU7yqrqR7VtkacX1CFslYEs3hX6VddM/VtzlzusaiLbOsDVOKSSfD9mz39L0EJ2m/eulvToN7jY2kJXXgXoJSPTlios5JCL6zEQUCnQyqkw9BEFXyw3FYoYpIbOG14rHR3d/oQzp17oFeuaCJ4BaQS+Q+cFIjM+URJ7yCmk7CVWDKYuy1aNb+5WkqVvNdWy5+UFAs32MgBhC4+sE/8b6pCVG+buBcEl1Zy0BQ5ibUt8yCCpQiKm+54BbUBGEal5dd3mmYd3uR+6wTLNyy2RfB/yuGAi19x5szlY5SSxeC6kMTdc1A8kTp7Ua6DF9uvxHuipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgDAhq9J5acMCDpjhGjttb4WWtzc3JUwjuaFev0+tIA=;
 b=cKjRjo/+rTbReYb9oZazcwF+IG+k7XcN64NWsA9dlLU5a6w2TvKX/8NBHeCb6hVZsL9yOcHBJFbVEXX/rPkFONGUweJfVzfgqkd5aBJw3Xt9sJZ8oadso53d0XtMstkT/zXTVCtEgwD/rTexVP213uT8euhZJQo/Vs4aDaV9oZSFX0/usNXW0UwqdjvIeYahxAKyimfsvDrmHFHrVrOLvvaVIPP8S1YrBE9pDEMgaRQncEJTLpS1dfqyIr/t0Xu13RX3jgbnskKats077w2VXNh7zkQrdGQo7mww1GC3Za9k0XU3CtVhZh9J/8dJKbODta8I31KVtMlA5Z/sZVm0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 15:03:02 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%3]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 15:03:02 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] wifi: iwlwifi: support fast resume
Thread-Topic: [bug report] wifi: iwlwifi: support fast resume
Thread-Index: AQHbNOd+8svcudxEdE2gtsJsxw2uaLKzvh+A
Date: Tue, 12 Nov 2024 15:03:02 +0000
Message-ID: <77a57d6ffaa90080178dddec26f6cc3f45534c03.camel@intel.com>
References: <c6a40af0-a649-4f9d-9245-dc6d6381cc10@stanley.mountain>
In-Reply-To: <c6a40af0-a649-4f9d-9245-dc6d6381cc10@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.1 (3.54.1-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|DM4PR11MB5328:EE_
x-ms-office365-filtering-correlation-id: bef60353-f25c-4dc0-a3b9-08dd032b1aa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXN0SEFjSHdJZU5ZV25iamdWYStHSmlNZ2k2QmJvbWhMNG9ZQkFpM1R2NEdr?=
 =?utf-8?B?K1NuZDJwSlZKUy9EbHlSYzhrV3BRTTgxOTg4dnhmaXlqQmxSVTJJQmpLdzQx?=
 =?utf-8?B?MG4rZVVzYWZGZHI0S1NGc3ZFTmhRck90VXlBekIvSEdTc0hHMXdXeTRJdlI0?=
 =?utf-8?B?ZVpFeVFiVjdLS0QzQWVjdWZGOFhYOVhmZXpQUW9aczBXZUxLYW54VFRIWVYx?=
 =?utf-8?B?dVM0YXpyTFhlMGRKWFRhNktQZnNxNUY4R2pFaW1SUjJVcFVKTVZEcGVIcmlB?=
 =?utf-8?B?b2ZYZkptVEV2VDdoUTVkUUM4NDE0YWcwTFBOdDd0dlVjZFdkdTFhaFNTSWtC?=
 =?utf-8?B?a3dkWVRscGhabWg5Nm9HYmhkNmFaZ3dBUVpKMVpWcStpdU53cWJ6aUdBTENL?=
 =?utf-8?B?MUl5YTRxRHIvTklvUTQrN2FmcmsvZXVIUFFCL05ia2c3MHNReDRCbTk4ZHR0?=
 =?utf-8?B?VVl1T0FDRnBlSXBoTGpUK3hNQ2xMekVHZTc4TUptR056bGJIRHlHR3BhRGpL?=
 =?utf-8?B?YmIwNE9qbFdVZUcrRFpBdUswWmdhdTBvU3NmeEZrVklwQ1dkc1JoZ1M4SzVo?=
 =?utf-8?B?TzI1VEZXWjJrUHZiQlF0RWlNa3RsTWt5Y3FIdmNHNDJQbkdwYU5NbUR3Y3dP?=
 =?utf-8?B?OStIWEhOWkU4ZU13NnhIbjZzNFRESzBwelp3aU8vRGlwdUNHL2NUWWNVdFll?=
 =?utf-8?B?SGRoRHIzNWFDeTBVcG9zekJDZnpqcFdROUdNTWJJWFY1TkFMRlNhdU9tc2VY?=
 =?utf-8?B?MThjTDBiVlVYVm5zNzJrWmg2d3BPWHlXbGNmSENkWHlaUzdGZjN0NVg3T0ZJ?=
 =?utf-8?B?a2pRSjgwNzIxWG5tRnpQSmFFNHBWc1U3RmtLaGM5QUgxcSs4TWlZN3BzMmwr?=
 =?utf-8?B?VzdiSE1aV0pHNWlZNkp6bEY3TWZsY0xGZGtBSkMxSXVDMVM1UGxBaC8rRjZQ?=
 =?utf-8?B?d3A2NGZjNFJtQjNiNDVPcExxdDBrVnF0RGVGN0tUb1lqdmc0cUMvcmlXWHh1?=
 =?utf-8?B?cVdOVitqdC9BajhGV3dRU3lkV1BQUlVWN043WDM1UlNOb1d6Zllmby8zQ21u?=
 =?utf-8?B?ekZ4cnZ0V2dMVjZQZ1dHQkMveEFXNThnbVArVU5scXVPa3hCZFBjSUZBU0sr?=
 =?utf-8?B?ZldxMGM3dTVUcVNIY0FNRkhZcHZEZWF6MWd0bWlTNXQ4eHlyNEdXMjJ1Ky9X?=
 =?utf-8?B?WlI4ZzE3ckNQUnFRN2xNUVE1RXNENTcrLy9CbkZoeXNpVEF1NGNKVFVvdVlS?=
 =?utf-8?B?dFlsaGkycHRjL1NJcDUreEZUTXJPL2RFc2c1YkhIZVZLUUFtTXBETVBqYlpW?=
 =?utf-8?B?U2RtMHpUZU5XZHRiUkgySXUyTXpUNzVOTXcxNFV0TUFsbTlUanJzY3d4SzBJ?=
 =?utf-8?B?ZGh0SFRwdzRNVS9jamRKRldCYUN4U2pFSlhJTzBZK2Y5K1ZVK1Azbm1BSnNa?=
 =?utf-8?B?TjB3aXAwTi9GUEwxSVRVVEVYTk9vRTJhcjJjeXIyZWxyR2hoSnZUYUpwOVZT?=
 =?utf-8?B?OHJoRkZ3Q3hkMlpvZzN1UDZ1RG9GVExtNlJiTG5xWE54K3JEYU9GTEdMYXUx?=
 =?utf-8?B?c2N3MWx0dE8xUnlGSTNwa202eUpNMWxRaHZHalliSlJ6T05XZW45d3pJVUVR?=
 =?utf-8?B?amFRdmVWUWoyQ2Z0M3NORFppUHZaRGJJcnVVR2xaeDRvVEExSVhYdFIrcmsz?=
 =?utf-8?B?NkxBOEM1UTVCNkZFNmJ6clhXRDlPbE5LeTV1OXAyNm1GbUFUL25EWjBObGVV?=
 =?utf-8?B?d1h4d0J6dGoxb2gyZWozeG8vTUU3aHdZeVg5a0g2K1BPNWlUeGVPVWZlZnI1?=
 =?utf-8?Q?r1COMm2D9wht7HPsWTV8YTl8FjSXY1sj42/bM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU0vaXk5S2hzNG5BZWJzYjdjL3NlcDgwbWwyR1QxUjhsMm1tcmw0bllpYjdy?=
 =?utf-8?B?Qys3cm5saTVnUHFRTFpmS3cxc1FoVy9sS1A0UENId3JSSHFPcVlzQ1lIS21L?=
 =?utf-8?B?VXp5dDVXbUF0aWVNVWtjUTRBajcrMjArdXQvVmNoZkpyR3FrMjY5Sk9aQkds?=
 =?utf-8?B?eHEyRUhDQmZaTm80MXZlQ3ZsVUFOV1I0dEFudEZzcEE5MU5OMkdYUWR0SnJL?=
 =?utf-8?B?OG1zdUZ6UmhlYjVzRWM1YkdCa2lVQml5UzMxbkJrQU1GMWswL2FKQmdLaUhT?=
 =?utf-8?B?eHpSTEhlQkRYVjhacC9tWi9heW8xcnJKQWdCQ1BpWndFZ0dkZERVK1dCaDcw?=
 =?utf-8?B?MXV3c2R0dzluamtWUnNOREdMb1dmZC9ubUJBdUlvT0M3aW02NlZmNkVoMjVx?=
 =?utf-8?B?U3B2SmxaRklNMXIyWEl0Q2lHSHcvdUUxYWhFRytLS05UUzdBVytSbkJKcDZt?=
 =?utf-8?B?U2w2SjVmZ0dQVXFEcFVQU0ZFQlNsanBzYVg0K3E5SXFxd1REYUl1S2NoMjV4?=
 =?utf-8?B?MUt1b0NjUFNtd21BN2MrTEtiejRERFV5QXZ1Rmh0ellGbnA1VVdlZ0ZzdzFW?=
 =?utf-8?B?VlRBZnlmMERNcUVaSnpJVkZ2VW1kbUdrSHRabndVUjQ1MlQ4dEVPbUx3WXQx?=
 =?utf-8?B?aHNDS1QvSEFPN1MwamtUcllqNzBEek1UMURKdlNKKzRYZGdZclpVZ2l3bkJn?=
 =?utf-8?B?SnpKUHhGTU9SR2RLSmVpY1VUbk40bWtvZjB2WVNreGRSb05GenQwVmhuejFW?=
 =?utf-8?B?K2d2VjlIazVidzZZL3BwOXN3WTA0cnZwdFFISi93V2g5WWw3ZnVwR21BWE1G?=
 =?utf-8?B?cThML3d4alRSS2JkdXN2OTNCZzhjTkV5NFBwbnFuaFVuSGN6RXlQSnBaZjVL?=
 =?utf-8?B?anE2Zm5wbHdpOVR2eFJlMjUwRFBmRFJEVytxd3FKMi9pMjFZaXcxdllVK3Nm?=
 =?utf-8?B?U2l4OXMrTElvSWJjcWprWkFxUUk3d2l0em1GZUxhdWdvRzZlSjZ0UEVuMmky?=
 =?utf-8?B?R09PeTRvNDl4bGpka1ZFN1Y2WHF3dFRwcUVyRkZqZCs1UVEyK1FLTENnS2ZL?=
 =?utf-8?B?R3lENXByMU9NMzB3WkV1b1J6OU90SW40dDF4b2I2RW5PeFRUV2lFd3RTWDlt?=
 =?utf-8?B?Q2M4UkdhSEJRZTVjNXkxNW5tWHJYVGFaak0waVhwbnZQcTBuVVpIa2srQld3?=
 =?utf-8?B?ZzhNejc4emNLSUxPVm5pWFdWMG9ERVVSZWYwZGRVMHdmSXZEN3RhZk9NN1du?=
 =?utf-8?B?K0J5Y04zN0dCUjJkU1Iyc0RjN3F0eWVtaGo3Y1Fhck01L3M3dy9MU0ZOQUt2?=
 =?utf-8?B?ZDdLRnBveXY5NmhocWFvVG5hWHdjOGZvNnlXS1VpVGJKU1cyRmdPR0J6S3FD?=
 =?utf-8?B?VHllb3BvVVpUczNzVTRSZHJLMndRNmNlYzBLeWVRUEIxdEdFUGJLNDl6Q0dn?=
 =?utf-8?B?WFhja09JWXFRMlNVR1pGc1IrN2tudVV6cldWRmNCMGJxVG5aREU0NmRPcGs5?=
 =?utf-8?B?QmM1L2J1NUZWcTNNNWpsNkxvZmk4U0JidkpCNUZHL3lNM3AyclBpSyt3OW8y?=
 =?utf-8?B?eUNYUm8rSDBCa042ZHgrdytGdS9sblpBekUvVy9JM3ROY3Jqc3FNUWVoNWpY?=
 =?utf-8?B?T2sxUDVlc1V4Z0xpdFM3YVByMk5RUE1mN2hrY2ZiWDFlUXFkVUR5Q1lvb282?=
 =?utf-8?B?TjJiM2tKYXFTWXVuWXgrbXRXNHpaQjBZQTQ3YnhDaTJ1SjZrNzlZdHEyU1l5?=
 =?utf-8?B?U0xrOURlaFNzNDVsSEg1MHJPWFZhK0JselVUYlNRK2FlQWRaNjdSbFNpbmVQ?=
 =?utf-8?B?cHVDSWFKYzl1QnI5UVdRek8vQTgvelNaVU1TMXBlRFNmOVlXeFBZSEt1aFcy?=
 =?utf-8?B?NjY1ZGtvN2VCTEQxdXZiS2lkbCtUQ2tkZWhEVWc0RGhvQnB0VmtnSk1ucWtu?=
 =?utf-8?B?QzNWOGx3c1hNNkZhczdmSmFtZ0lFRVZlVEZBTFJYMWd1VGJPTG5xMS9hWHI5?=
 =?utf-8?B?QXJSRjdXN0phVlBaYmp3R1NGQ2djV3JJQXZqQnJiZU5vQmY0S0ZXZmVUZUQw?=
 =?utf-8?B?TWNtYnJEWWlHa2kwdk5PWGZ1OXVmbzdTZHJQOWpEUCtNOWlWZUcrL3huQ3k1?=
 =?utf-8?B?cmxQTzJGWWM2ZzJoTlZENVNQdGh5TkJHaFBZcXZ3QjZvdnVsYjRnOGljanJ3?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E4414DCAFD0C04F86868D81BDD8F0A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef60353-f25c-4dc0-a3b9-08dd032b1aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 15:03:02.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXUa4A0mgvh3tRP+hsAyHBb6x9Odo3jS9N5ST7SeJA+lSbRW9+sm53vnOpUUFOZMvgP3y/k1U5K6YFcmCZxg1AiSqUCXCYzMGM82uGGf/ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com

SGVsbG8gRGFuLAoKT24gVHVlLCAyMDI0LTExLTEyIGF0IDEyOjQ0ICswMzAwLCBEYW4gQ2FycGVu
dGVyIHdyb3RlOgo+IEhlbGxvIEVtbWFudWVsIEdydW1iYWNoLAo+IAo+IENvbW1pdCBlOGJiMTlj
MWQ1OTAgKCJ3aWZpOiBpd2x3aWZpOiBzdXBwb3J0IGZhc3QgcmVzdW1lIikgZnJvbSBKdW4KPiAx
OCwgMjAyNCAobGludXgtbmV4dCksIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgU21hdGNoIHN0YXRp
YyBjaGVja2VyCj4gd2FybmluZzoKPiAKPiAJZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vZDMuYzozMTIxCj4gaXdsX212bV9jaGVja19ydF9zdGF0dXMoKQo+IAllcnJvcjog
dW5pbml0aWFsaXplZCBzeW1ib2wgJ2Vycl9pZCcuCj4gCj4gZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vZDMuYwo+IMKgwqDCoCAzMTEyIHN0YXRpYyBib29sIGl3bF9tdm1f
Y2hlY2tfcnRfc3RhdHVzKHN0cnVjdCBpd2xfbXZtICptdm0sCj4gwqDCoMKgIDMxMTPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBpZWVlODAyMTFfdmlmCj4gKnZpZikKPiDCoMKgwqAgMzExNCB7Cj4gwqDC
oMKgIDMxMTXCoMKgwqDCoMKgwqDCoMKgIHUzMiBlcnJfaWQ7Cj4gwqDCoMKgIDMxMTYgCj4gwqDC
oMKgIDMxMTfCoMKgwqDCoMKgwqDCoMKgIC8qIGNoZWNrIGZvciBsbWFjMSBlcnJvciAqLwo+IMKg
wqDCoCAzMTE4wqDCoMKgwqDCoMKgwqDCoCBpZiAoaXdsX2Z3cnRfcmVhZF9lcnJfdGFibGUobXZt
LT50cmFucywKPiDCoMKgwqAgMzExOcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdm0tPnRyYW5zLQo+ID5kYmcu
bG1hY19lcnJvcl9ldmVudF90YWJsZVswXSwKPiDCoMKgwqAgMzEyMMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAm
ZXJyX2lkKSkgewo+IAo+IGl3bF9md3J0X3JlYWRfZXJyX3RhYmxlKCkgcmV0dXJucyB0cnVlIG9u
IGZhaWx1cmUgKG1lYW5pbmcgdGhhdCB3ZQo+IHdlcmVuJ3QgYWJsZQo+IHRvIHJlYWQgdGhlIGVy
cm9yIHRhYmxlIHNvIG1heWJlIHRoYXQgdGhlIHR3byBlcnJvcnMgY2FuY2VsIGVhY2gKPiBvdGhl
ciAoZG91YmxlCj4gbmVnYXRpdmUpIHNvIHRoZXJlIHdhc24ndCBhbiBlcnJvcj8pwqAgQW55d2F5
IGlmCj4gaXdsX3RyYW5zX3JlYWRfbWVtX2J5dGVzKCkgZmFpbHMKPiB0aGVuICJlcnJfaWQiIGlz
IG5vdCBpbml0aWFsaXplZC4KClRoYW5rcyBmb3IgdGhpcyByZXBvcnQuCkknbGwgc2VuZCBhIHBh
dGNoIGludGVybmFsbHkgdG8gZml4IHRoaXMuCgo+IAo+IC0tPiAzMTIxwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVycl9pZCA9PSBSRl9LSUxMX0lORElDQVRPUl9GT1JfV09X
TEFOCj4gJiYgdmlmKSB7Cj4gwqDCoMKgIDMxMjLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGNmZzgwMjExX3dvd2xhbl93YWtldXAgd2FrZXVw
Cj4gPSB7Cj4gwqDCoMKgIDMxMjPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZmtpbGxfcmVsZWFzZSA9IHRydWUsCj4gwqDC
oMKgIDMxMjTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsKPiDCoMKgwqAgMzEyNcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZWVlODAyMTFfcmVwb3J0X3dvd2xhbl93YWtldXAodmlmLAo+ICZ3YWtldXAsCj4g
wqDCoMKgIDMxMjbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoAo+IEdGUF9LRVJORUwpOwo+IMKgwqDCoCAzMTI3wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQo+IMKgwqDCoCAzMTI4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHRydWU7Cj4gwqDCoMKgIDMxMjnCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqAg
MzEzMCAKCg==

