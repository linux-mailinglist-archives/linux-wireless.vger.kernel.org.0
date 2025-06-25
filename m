Return-Path: <linux-wireless+bounces-24498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D7AE8BB0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1197A7EC2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B71D95A3;
	Wed, 25 Jun 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jY6VOfyd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84391B0F1E;
	Wed, 25 Jun 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873517; cv=fail; b=trFk4jKsyMcJHvuFeWSXf8dkpwVwXJ9R4hkHI+9cf1vo+tyhbSSOE1R/pK9gPeULRs6p+M6jG2Nl9VVKszWLE+5LCe/iohD/WQB2RWl6dsY63F14cxz7hp0nPLU+haCa0d7GegTzQ33eyYBWEhNG/kXSp5ojUlxO1OBYljql97Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873517; c=relaxed/simple;
	bh=RyE/NlM95URTkM3S5fuBMzYwQp/KnI0JlKvfuLFyIwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RwsJXwc3xAmOdr2CrMvcQGappy/xYM15aQrTrm4j4N/MPs3LNsk+FMlF5B9szrwo2Z+xqsm+Jt4owrOcbjboS3I5Usc/vF7/HUF4e+75aqf9oiETN444qco964WG3B6Vi91mWLfNtViyhAI3VoBdje1Bfnj45lciDi7t1jfx0jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jY6VOfyd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750873516; x=1782409516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RyE/NlM95URTkM3S5fuBMzYwQp/KnI0JlKvfuLFyIwA=;
  b=jY6VOfydEHDjtUmFddKOV5Q53cJzQy7MxhxxPseFsJUB8v2V2SHcRAky
   p+ilyf+LNDNICb6iXTiDQ+bR+gJKW+LkzAnbgOrIT/DDjx83DEbV9D+Z4
   iB+l4UpiOhynLFY/oa/XC3mW7YMd7dAVlo4I+QOWvA87HjtOdXqe/rGSb
   RFewvkDDHrJrJYTqlgi3BstdCndc8hMsHIcgzUG3O7ZZ9SRwaZyEI78KQ
   X1qpbMmFD/rJKm/eY1bOXRWYoh4LsCm79a3w7Fu25D84ui3pwh57rNeyt
   o8A9rg6meLAPR21AkMlwB257Lubbn4GqPgufkB73lFeDGdtXQATkixvQw
   A==;
X-CSE-ConnectionGUID: NwKuL7DeQbK97RGe0SbL/Q==
X-CSE-MsgGUID: NkjX6HwrScmu2BF22qm+TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70588249"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70588249"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:45:16 -0700
X-CSE-ConnectionGUID: +ouCM3GWQ+uCFt1mrUHP9g==
X-CSE-MsgGUID: e6Ghw60/RgSF9XmCPSjpyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="158042083"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:45:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 10:45:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 10:45:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 10:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMG5TJW/WS7nnJ4M12tMnMm77c8TQAaFV2KHlAQU7kNj3TQl7qMOyMfhNLTww9AZ4xn3SFbzZ01MWdjYBnUWrTcNhpJ6I42k6NMDEdt9L7QrGy0GDAxmVxhxu1ioLiuByhxs0O+cXonAgwe0o5FXxttUchhw0OOh2j18F40aVM8ej6FXFx0hnhJJ13WMawGA7BzgOgaLN5StDXvXbPTjX7ZBC4gcVt+oNQD1jh2QCxjstcHqncpMVONlIUWEKoXvCTBkVb0hEDZvzsqCHBL2lLF9hHfjxCfaMEtgkPoX6f8WTUYMB62D7sxRmdYFS+NgS8bdezhCvRWiYwUr7EXBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyE/NlM95URTkM3S5fuBMzYwQp/KnI0JlKvfuLFyIwA=;
 b=n54wrRY+undMJTooUf2DaX/TLuE2ZmvMmsB8o3pA2G568GB36RPZB6vlS+onBCcGD8nOxz+A84gEkp9b65sq7zSc1wGcnFReMlecqesaohljuFfk7NwqJ9JzWtHtcJCOENCuXQYPSLO+qk+PXB9TeGOKpqOtl4j5S2dbbHo51m52VqjPiZooKDrqP/VPon3KZr+L91SkeEaf5nypLq7qkYqxX3QU2gcUfrO0tXzHpr3mdX1481rubQIWJD3BDFgPkfUtjgZPyzn/LIVcbH+6GSEDNJVD9xS778sUF4YpyXNki49MUCd7hFwLmtwPpjOoVkM+Hz7R25ajdUjGxy+AHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS0PR11MB7684.namprd11.prod.outlook.com
 (2603:10b6:8:dd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 17:44:56 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 17:44:56 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: pcie: unlock on error in
 iwl_trans_pcie_gen2_start_fw()
Thread-Topic: [PATCH] wifi: iwlwifi: pcie: unlock on error in
 iwl_trans_pcie_gen2_start_fw()
Thread-Index: AQHb5eT0AYJTDB4n6USBU3KIqsL1NrQUI9nw
Date: Wed, 25 Jun 2025 17:44:56 +0000
Message-ID: <DM3PPF63A6024A9A97D5A9836F92CFD9B98A37BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <685c1420.050a0220.ae80e.9bfa@mx.google.com>
In-Reply-To: <685c1420.050a0220.ae80e.9bfa@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DS0PR11MB7684:EE_
x-ms-office365-filtering-correlation-id: a62893a8-baf4-4c7b-e36e-08ddb40fffc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?blZ3WUFPVFNuTzJTRUE2U01Wak5UZ3FuQmRlMUJTWkNUSEtITzNKSHNSZ1Uz?=
 =?utf-8?B?amJPamVac0pUN3RVQldDQ0xmTWY1bUdiNlFXS3ZsaGN0eHovcng0eHlibWND?=
 =?utf-8?B?a056ZFNQajREK3kwaWxZQ2pmNjgxeC9Gdjg4b2ZEbGE2c05odnBKQmthZVBT?=
 =?utf-8?B?UW9abC9oa3c0czYvaU1JTEJRUjdYS3pINHlaYlFKRmEwRUxFL3VPcEF6aWFa?=
 =?utf-8?B?RWF0Y05NaW1CRTVSMmh2d1U0Qy85cUZiMVhoVHgvN2xSeVVDL0I5NGljaUtn?=
 =?utf-8?B?QjNTNkpvWHczdGUwT01wWGlKV1pVb05HMEIvaDdnNXl1Sm96RlFTL2ZRYmsw?=
 =?utf-8?B?ZE55Q2lXQVN4YWxMZWpXajMzM2N0ZXdpd3ZWRGdiOEZKejFXeG16M2lkY0Rj?=
 =?utf-8?B?NXBlODNJUEhxUXQ2dWdsVWFLTWpaeW5USG12dUFuVXRzSS85THY4RGRFTVhH?=
 =?utf-8?B?MlB2WVY2QWpRVldiN3R1cUVRUVY1VFFFYndoMUdGNHR3OE1Mc1Z4b2RNQlEw?=
 =?utf-8?B?dmVMZnlySHpxYldYM3dNS0RvNkpVY2VPZ3I1M3kyUW53bTg5SjNhY3hXVGxM?=
 =?utf-8?B?Vk9YTDhwcjZObG9IMkYrSGRTWW9GUjdHUENrMkl1NmNQYWsvYUhVWE5mTEJu?=
 =?utf-8?B?UEoyMkxxZzlseHZyUGlqY0lEQ1JaNW9MNUVkK1hJUVFMeHFJUThvbjJLNUh3?=
 =?utf-8?B?MlNRMks5cjZIUWpNSktyWi8rZFd3WnZsSWRMQjJBL0RPMzhDcUNvdmg5L2xu?=
 =?utf-8?B?a1R3UytBQzBmS1RvaEpTNWV3NCs1a3QzM0pSb2xLcjZtdGg5amgrR1kvNi9B?=
 =?utf-8?B?K3V1V2NxS3dYZkJOdGVzTnFzbm92TGFOTG9Vc0RzVU0vVm5pM3hiOEFlK1hs?=
 =?utf-8?B?dWxnYy9DRjdVWm5YcEJUVUJBRk9aOVZLcXFITGcrbnpueUtlM3lTTTgvVDVm?=
 =?utf-8?B?S1VjUFpHaGhGalVlbXdKbVAzc3hzWG5xaTVta240Y0xlM3dDblNYL25IbnA2?=
 =?utf-8?B?MlBScWZyRWtqRlAzNUxXbzdRb2d5dVRreGl0eko4ajV4L0h1ZkZhYWVYRldN?=
 =?utf-8?B?T2pzclZ5WGZKb1d6cHNQOTllNGdtNzhOU2pLYU84NnNDRCtkMlNOZ1pMeGdn?=
 =?utf-8?B?R05tcTlSNDlGblRxOTZSazh5THJQWllVSlVJRmZpRUNjZnBHL0FabzZwWWtP?=
 =?utf-8?B?WXNjeGtZeU8vQXZBYm84SWVNZzRCalA5WWlFbDB4WWVPZDZUZ3J6ZE5NeVVE?=
 =?utf-8?B?NHU1dGFaOUR1Wm4zTWhNeGlCQWk3R3ZUSmZzZjVVVk5oSVJXallwdVRWY3ov?=
 =?utf-8?B?NjRWZ01SRzA1VjJkMHFJNmR1L3V0cnhlN0tBWVRadjU3cEJQYUFEUFBKVzhq?=
 =?utf-8?B?MGZSM0M5ejRFMnZTM3dVZVczQzRDNDNnT3NkU1ZELyt6c3NxbWVhREZuS2ZG?=
 =?utf-8?B?VkQ0aWJiWGczTlhERnBPNlRXRHJGTVlXU1RIbExnODE4clBXeW1TMm92K211?=
 =?utf-8?B?T3lYU05HOUdQQmZ5TGNhZmN3Q2E5d1cvV1ptdEJjVGYyMFFjazhGUC9pU0pW?=
 =?utf-8?B?a2UrV3NwRnFGTTZpN0xVNmt6N1J4dnVhWnE5RGJBQzJDL2gza2REcGVjaWhu?=
 =?utf-8?B?ZmZxOE9yeEd1SGg2MEpJL0F2cFNpTURqa2k4dXYwMFIyV3FGMlMydkNvRVRz?=
 =?utf-8?B?NS9YVEl0OFhBU1QwaGZBNktTVHlKN2RMejZkc3JOR0M3T1lnTVVBNlJKK0dL?=
 =?utf-8?B?ZmlJM3g5WkU1QVdxaFVPdlNGN3lLOVNlb2piOFJzTE1VaGpIeUhpRDA1OHdu?=
 =?utf-8?B?UkxYMmwxR01iZjNTZlVoTDNPN08xdmhLQnhaZEZycDczb3ZpV3JFbDZuNW9h?=
 =?utf-8?B?czJBc3o3bW9hV1QvNkpJWVQwWndZYWFOcmxHSENpZUgwUHRLUnJ0T0lycUtZ?=
 =?utf-8?B?VmdnejdpOWFnWWpvYnRmMzFSSy9sRDNpQ1RyMGo5LzlZamVGbU1HRVRGdjBp?=
 =?utf-8?B?YmJGLzd5Z3JnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1I0V3J0T1d2OGFCakg4VUxlSGdONU5xSFFUSlEwbGM1WWZVVVNWUGdMMXQ4?=
 =?utf-8?B?SURwd3NjS2Y5bGJUeWZFT1JMUmRZd1VpVWJoT0FzTTd5dG4xc1A0REc5MVQx?=
 =?utf-8?B?OXJRQXNEMDhWWWZvc3E4a0M1VXlBMnllTUlVZmhSUzBDN1lRN3V1NjcvLytG?=
 =?utf-8?B?S1ljMVlkKzJUZ1laS2R1YmJ1dzk4aGRGZUNMR3lMa0QybmJYUjNDNnhJQ3Fy?=
 =?utf-8?B?V1NWU1dUY1U2Mm9EMDY5NXdHREhpZzVnaVdYZmtPVVI4SHlBczlGYVNQeUQw?=
 =?utf-8?B?ZDdaWFNabmNVeTUrZHlzUXhucDlHSS9yNXlCTGNYREtuMC9yczZ5YTYwelox?=
 =?utf-8?B?RmNmeFIxenlFVkdrVWZrdjZ1TWJYU2lGWUJFbEVXQW13YVc2bkJ5SWF1Z1ZU?=
 =?utf-8?B?N1IyeEFER0Jab1hzbitJS2NLT1FaTkpEckJoMVp2RHNyZ3BWRXAvYXZHSVpI?=
 =?utf-8?B?c05sZE1BbDcvYi8vRGtmV3E0MnZQcE1za3pId0ozTEhRUkd6b0drQjA1V1Z4?=
 =?utf-8?B?QmpBdUcrRzVOcU9kWWtjbjZRQ0ROR1ZhZWNhanp0WW43S3VCV0JNMlEyelQ5?=
 =?utf-8?B?YnpHclNhLzVDQzlnancyV0NQdHVEZC9RR3E5c1c5cXA5RUMwVW1LZWFWOTRU?=
 =?utf-8?B?a2ZpQ0JmMUhqc1VuMEl1aUZFdEVsWHlRd3NWenNYSGE2Z2JlWWxZN1BxazJE?=
 =?utf-8?B?K1VtSG9IM013TXFWaDIzcTdIc1hUZ2J5YjNXcEl1aWVjYjc0YmNmVEt0VXpp?=
 =?utf-8?B?RTYzakYrL252bWV0UG56ZmlOZzNYQitDeDRxVFM3ZEdrcnBxdnZ0T0N6a2Rv?=
 =?utf-8?B?VE5keUROLytCa2JzdXJUcVhoVE4xUS9LUEo0ZTBia3AzN3NmQjk1clB2Zmdh?=
 =?utf-8?B?VE9ld1NyR1BKMXVxUEhPKzBQZ2ovYTluV2VDZnBxUUgwY1U4aWU4eFkzQ3VH?=
 =?utf-8?B?OHNBSjRCZFB1bEUvS0lOdElUQ2hYTkhhdjcxUkdacHlNKzd4c005TjRTdVBH?=
 =?utf-8?B?dXQ1ci9pY3Q3V0ZjNHZkNEhwNjBUS3VXZmVTT3g4ZWt2TlQyYnNIM1ZNN0Fo?=
 =?utf-8?B?RTJ4b0tzUW9rWUwrUFVjY1p1QXpxcXlTa2VPcTVPSVg0VnR5Y0dIWG1hUUxw?=
 =?utf-8?B?ZDJ3NFRySHdiRnRVbXFRaGwxcm5VZkJhZEhvS2hCRWdGSFNYUERtWVNNVjFv?=
 =?utf-8?B?VDl5ZHRwa2RzbVVvWnFrcTcyVExuaDZ1Qm1kbjhoNThkNjFLeHQvK3ROdXMz?=
 =?utf-8?B?YlhQWXAydjVKY2dMQzRmNmsrN2Y5emhuQ0hqenhtM1FZZ2Z2eDZLOUNSVkxC?=
 =?utf-8?B?RWovbjZzaDNWMExMRVh3eGlDYWVvbGczYk54eUUzaU5Dcm1XeVRCMW9uRW9F?=
 =?utf-8?B?YzE1aVdOb3UwRHVMcEJqdDE4TGFaUGJJb3pmUUNtL2twUHJjd0kzUzF4c0tW?=
 =?utf-8?B?WVRNcHRmd2ZsVUxNbzBqK1ZyQ2t2NlZoRWFzVThKVm5XZkZwL1RDNXh1eU9v?=
 =?utf-8?B?T2lOWStrNWlrbHdLU2lDMlA1bXRSc2JMV1VkaHA1ZjkrcFcydU5RVnUvTWxw?=
 =?utf-8?B?bVg1TmhXdU4wQ1hETEFRVVIvcTFoaWRKcC9wQ01tUE83VTJFdVdtd29wbWQx?=
 =?utf-8?B?cDF0WkxVc0tUOFN0cjZjb01NYXM0YnNvcnFkemVRNFE5TTQ1L3ZyaU5uUnN5?=
 =?utf-8?B?dWs2ckFSbFNobUowN1NTSVNVTGxNNklUWG9ER3FmMTUrN3ErUkgrbUhtTzhS?=
 =?utf-8?B?NFhNOEpadU83WXRRV1dFMVRuR3EwUGlhVUtrZm05ZXpxTlNqYWJhQmlsOSta?=
 =?utf-8?B?U3ByNEdkK0UzUU9mWTEvaXJSSEUyemZ4NXJLTkJKRUN5UGd6SlBYZnI2bVZ3?=
 =?utf-8?B?OFZQRXdDMlBzajh6bGxBMTFxRUNvYUFhVTJXV2lFMTFNV3o5bjFWOUVqU0pL?=
 =?utf-8?B?RjU1WG1CLzlLNzI5bCt2NlhETmR0ZGJuM29hc05VbWQzNXc0MlJrdVlwRnRx?=
 =?utf-8?B?eTZCQkZSM0ZEWU0rZmhVeVVZSms0OFFDeGJHQWJVYWVQSlNXTkxwVTdkRnRO?=
 =?utf-8?B?OFdTclYvUk5UV0dnWVlJSDRHc2VtbDM3aU9UM3FlczUxblVGck5RejgvczMw?=
 =?utf-8?B?KzBRakZBVTVWc0ZnNXFtTmtrR0dHZDJsRlUyb250eFU4aWxBUU84cWFHYS9W?=
 =?utf-8?B?Z1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a62893a8-baf4-4c7b-e36e-08ddb40fffc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 17:44:56.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jijrTZs2MinXdTG8XF0ccaxSIKmLH9V5ZiwJUfXG9dRTq/zejpFzBGnC5OZPEy9uus7KQ1hTORXaMKLvrQawujaScbamqtquDzIirrAxZyvVCNo4ApD5lriyF0q6LDO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IGl3bHdpZmk6IHBjaWU6IHVubG9jayBvbiBlcnJvciBp
bg0KPiBpd2xfdHJhbnNfcGNpZV9nZW4yX3N0YXJ0X2Z3KCkNCj4gDQo+IFdlIG5lZWQgdG8gY2Fs
bCBtdXRleF91bmxvY2soJnRyYW5zX3BjaWUtPm11dGV4KSBiZWZvcmUgcmV0dXJuaW5nIG9uIHRo
aXMNCj4gZXJyb3IgcGF0aC4NCj4gDQo+IEZpeGVzOiBhZWVlNzNlMjdmMmQgKCJ3aWZpOiBpd2x3
aWZpOiBwY2llOiBtb3ZlIGdlbmVyYXRpb24gc3BlY2lmaWMgZmlsZXMgdG8gYQ0KPiBmb2xkZXIi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5v
cmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2dl
bjFfMi90cmFucy1nZW4yLmMgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZ2VuMV8yL3RyYW5zLWdlbjIuYw0KPiBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9nZW4xXzIvdHJhbnMtZ2VuMi5jDQo+
IGluZGV4IDBkZjg1MjJjYTQxMC4uOGZmMjNmMzkzMWM2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZ2VuMV8yL3RyYW5zLWdlbjIuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZ2VuMV8yL3RyYW5z
LWdlbjIuYw0KPiBAQCAtNTQ2LDggKzU0NiwxMCBAQCBpbnQgaXdsX3RyYW5zX3BjaWVfZ2VuMl9z
dGFydF9mdyhzdHJ1Y3QgaXdsX3RyYW5zDQo+ICp0cmFucywNCj4gIAl9DQo+IA0KPiAgCWlmIChX
QVJOX09OKHRyYW5zLT5kb190b3BfcmVzZXQgJiYNCj4gLQkJICAgIHRyYW5zLT5tYWNfY2ZnLT5k
ZXZpY2VfZmFtaWx5IDwgSVdMX0RFVklDRV9GQU1JTFlfU0MpKQ0KPiAtCQlyZXR1cm4gLUVJTlZB
TDsNCj4gKwkJICAgIHRyYW5zLT5tYWNfY2ZnLT5kZXZpY2VfZmFtaWx5IDwgSVdMX0RFVklDRV9G
QU1JTFlfU0MpKQ0KPiB7DQo+ICsJCXJldCA9IC1FSU5WQUw7DQo+ICsJCWdvdG8gb3V0Ow0KPiAr
CX0NCj4gDQo+ICAJLyogd2UgbmVlZCB0byB3YWl0IGxhdGVyIC0gc2V0IHN0YXRlICovDQo+ICAJ
aWYgKHRyYW5zLT5kb190b3BfcmVzZXQpDQo+IC0tDQo+IDIuNDcuMg0KDQpIaSBEYW4sDQoNClRo
YW5rcyBmb3IgeW91ciBwYXRjaCwgYnV0IHdlIGFscmVhZHkgaGF2ZSBzdWNoIGEgcGF0Y2ggaW50
ZXJuYWxseSwNCndoaWNoIHdpbGwgYmUgc2VudCBzb29uLg0KDQpNaXJpDQo=

