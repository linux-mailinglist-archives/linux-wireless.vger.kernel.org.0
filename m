Return-Path: <linux-wireless+bounces-24461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B7AE790C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B723BB473
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963401F4611;
	Wed, 25 Jun 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJtqIB8V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B981E47CC
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837903; cv=fail; b=Vm40Hrly9pUyiZg5y5Cqj3W9lPsGrAbT/gNsmpBw4DOEcYi6KMV+msHCd0hxBqv+TzLN8tAX/uzGNl88VVXSbNS1THeoBARQtov/5xWbzV6P74TJFWy6Wx0SRYlufLy9pstNnKhv3zuCX4bIPlw/ajK56tDthDLUJM/3n1EfFw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837903; c=relaxed/simple;
	bh=79szX/YcWxcUxgL00yq9XN1lRAwiMFPFvxi843fx5ws=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mJhnWA+V3luFDonRAeMaE41kbPIN7b7EAB1mgWAht5cFZXyQeNETsiX+i26cBhHymBz4BprRloFcV8IlbL4kbeJK6DkbXb+vdd3r4SN5WPKLIX86SWbqpZ9fP/bXvh0wUlWr/e8IqwAah9CvekZGj/kxPbTvFCCK8GUFHl7v+kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJtqIB8V; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750837901; x=1782373901;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=79szX/YcWxcUxgL00yq9XN1lRAwiMFPFvxi843fx5ws=;
  b=RJtqIB8VKzvadoB+vWWSPywRuE6HeqlovYHlLdsDFc7tIdyWbhvrhvvS
   /qphzUVzIJR+OO3TUcZy4AD/SNk1Rh+80iHUIH1wMI0+b24RWo51uJpHB
   DUI9yLKaPRKoHqxEB26GiXEl2dZK2innE3LsNFedjrIGMUGPkw0vIQTd8
   Fx5HqME7yySLqnFfzC7WCqgKxuGEde/myIET/Ja8Pcbc5qBMyqbTrxVKx
   oklEWLEQDUVWE1/NcvVbclbh+ZIKn0xUAUrgNhXRRGRThG8+thaQGO7jn
   FxsEkvV2vGs4ySXEyKtSgEAyt6exx75NBYjg4h4vxO70WP2/xjhrZm+Wc
   Q==;
X-CSE-ConnectionGUID: 4JA3LuDeTRay3aJgLe5vuA==
X-CSE-MsgGUID: 6QbUNWf5Tzih4QSc9HioQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56772653"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="56772653"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 00:51:35 -0700
X-CSE-ConnectionGUID: 8PHDSRqTQRy88h1tnLg/Fw==
X-CSE-MsgGUID: 7IkN5gXGQ0+eq4F4jg23Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156707401"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 00:51:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 00:51:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 00:51:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 00:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3tCM+nR9sc+dx1dSQJwLioZgrOdEJX69mIwywKL8Z2lfjQuQLYYdMhNM4hOWutbNVOAPgzfX3Lbl4u0Qw4H2bM2bKBUcPKHezgFfTBWkIeTuRkzJnDxx2PkAA131z3UhdeABKnApZAfhI0AysX6yqSYussK/Rcs2fBcquWiDZuMtHJ640U26OA4p10sOYEeoas4Y4XZuCwYquL34tyyyfVqaaPzFSVscjuDF2VdMMlzgnbZ1A8+KLvihed62qM3OMv57F1LFpeKmQZ8SseYd12lFgm120dTCrpa+vX6i7SMmeP8POHAPOJGfxpUIaZz3k98khH3VaxFCtO2fKUvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79szX/YcWxcUxgL00yq9XN1lRAwiMFPFvxi843fx5ws=;
 b=oUbPJeXTf6vQClMcnRAg7ymItNZXCMTWIryklBgia6OgtKJA6WkT6xImK0aPYEnabtXNlRB80guY7jfNajkOvegxhhE5NuKjbBcSLTE7/Mi4ovbsxfnxy9ojrPnmxsUCumyVfGdB0rU/YJTIdmaAGQeKK0bhMfo61HTV5styCguVb99ZfRWNP/bNiYjJQMtzHL1Na3vLjlH6IEnq18/6TIDW/Ht/Uso6X3V3pBTnpYS9Uv+k9YYn3BNXMqI+P0ds3TwEkkd4vAjjPvhf6p/gYxIOLrwVk4Y/XhLsMkKeeKs3NFHuNutW3YYDmmM547YU94/vyTA1G0jaoBcgGhjHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH7PR11MB5981.namprd11.prod.outlook.com
 (2603:10b6:510:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 07:51:31 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 07:51:30 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>
Subject: pull-request: iwlwifi-fixes-2025-06-25
Thread-Topic: pull-request: iwlwifi-fixes-2025-06-25
Thread-Index: AdvlpVQcRohRoID/QAS1BTmilSxNRw==
Date: Wed, 25 Jun 2025 07:51:30 +0000
Message-ID: <DM3PPF63A6024A98B2068E8C193F4DEB719A37BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: 9148596e-939a-48e9-7038-08ddb3bd1934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UkMrUkEyQnFVS29xVjcycFpDUC9xK1FCN2VkL3EybUloVnIzdy9nQ1ZWb1Mr?=
 =?utf-8?B?c2hXNm94bFkyZWQrOW9adEwxRnNTeHAxczllMzJrWTRBZkFZdXllUWdyTEpa?=
 =?utf-8?B?NU5SWit5YkIwbXpDbmd2MjdtU3VmZXUrK0dUcHVQRUlZY0l1R0VmVGRqbkVH?=
 =?utf-8?B?LytabXFzTWxjY21uMU51R3p5dm9uTnROMUV2MzVpY2lEbG5MSmNCdE9QQlgz?=
 =?utf-8?B?VWN0YnIrUVYrTWN3SXlGSFFLekU4akh5VlhQTFdmUGNpMVNJVzFGTWFtaUhM?=
 =?utf-8?B?WTN5VGJaRTRDdU1UeGNDZ2pTSjdqTU8vUmJrVEFHeFVrM011RUFNdU1PYWZ5?=
 =?utf-8?B?NGtGTS9oeTBRZlNaWnozYU5tNXZVODBieERJTGVwZEQ2Y25hdFZyTUFzS3c2?=
 =?utf-8?B?OEprMFFKc1FjaUthNFZDbGd3YThmN0dUa3gvWVR5WlYrdGhsQyt0RitTVkJJ?=
 =?utf-8?B?TkFTTC95R2FqYUQ3dGg3c2lFOHBkWUJZT0xxbXdhSG51NWFOU3dvR0NVTkh6?=
 =?utf-8?B?STAydVVvT1l0TEkwbS8rS0huWjJjNzR2amNZRy96VWtkVDBiaWoyU3ZJelg4?=
 =?utf-8?B?eWkxbDZ2WjIwdWpWaHJKdWdyRjZUNGVMOWt0QXhrUGN3bXYvcTF5WUxMb3Nl?=
 =?utf-8?B?eFE3aXlJMVZDVVJSN201QzRLSnMwNFNydlprK1kzTS94VE1yTDhjV3hGUXVl?=
 =?utf-8?B?UHZySmIxWkNxTG9uWkwzQm5zZlJMTk5ZaDR6eGRNcG02N1BNWTFmeW1ZUU44?=
 =?utf-8?B?VWRJNlhma291d3IwZWdlRWdoSGc3ZUs1NWxXUndtT3VmdFpHVTBSWVdVLy9l?=
 =?utf-8?B?S1g4eFpoV3l2Y3N4YU5kU2FDVVpHME51Mk91a2JaREpyT3ZlUHF5dkxFcVpR?=
 =?utf-8?B?S0UvTnpnbFZRNGFFVVdHOU9pb2NJY2ttZ2lwcHZCQjVVMkFUcUhiWHN0ZmhN?=
 =?utf-8?B?d0RtSXFHRW5qeFJTdGdmTXlNUVJkU003VGlERDRVcFkwYmdRT2RDQzhmUkww?=
 =?utf-8?B?dlYrM2hrMWI5RnRkSlZ2N0RWQUp5WTI1azgwbExxVjhieWVPbUlxRllOcXlV?=
 =?utf-8?B?QlNHck95L3VXRmF6dzk0L1A1bVNFL3MzenU2YjA3dXJQT0NsU2pVM3FHRFA3?=
 =?utf-8?B?U1lDY0FEYmx6TXVZOUdrSFRTZTJSUDFXWEVQZUgzd1V1VFJwa3NoK2tXYTd3?=
 =?utf-8?B?SVVrVUVJL3pVbXRQWG9waXVtb1lhcUNseVZWUkhoTnp3NW45ZE9BRFk1WHB0?=
 =?utf-8?B?eUdxOUlnaDJsdGp2VW1wNjhBSDBzVU9MYlk4VkhrU2Jrejd1WS9Qak5MUHVr?=
 =?utf-8?B?QS9oYXdaSjdGelBCZVFnMnMzbHFFQ0dYdFozY2gyR3pXOHlGUk9tbW1ZeEY1?=
 =?utf-8?B?U0M1SEdCYnBSRXFyR1h3RHVaOGxpMEZqTkhadm8xbENoV01JYzltbGJXMWpR?=
 =?utf-8?B?Ym9FV2VZVmFuUzJVUjVneFhVVTM0bER4WERyemFQQWZiNXBIWVN3WE1SV2NG?=
 =?utf-8?B?b3pYdHlYeTRYQ1pPbk1lMzRzSnJGdkprbkVMbDB4Njh0N3NKczE3U0M4Z0Yy?=
 =?utf-8?B?NGhXVVQxKysxQURoM2lWN2NtandTWDBMYjRER3AxeDVZaGdRV0U1eTU2N3dV?=
 =?utf-8?B?SUdpeDhCTEF4QjFXUW9UZ215OUF3Vk1FNlBjamE2SmNjRk1xdHJEMFVXcndo?=
 =?utf-8?B?ODZVaTZmWVJQN0VmOVdyTEdMNGpYMDd2bTVyZEU0S3h5WXJpcmkzZUxuK3dB?=
 =?utf-8?B?bzlKMlZuTTZyLytFSkpKRFBOd0xtWFFESWo1b0wzUGVlVFpncUMrZkVTSFlp?=
 =?utf-8?B?WHFDVHFjbTJyUUJ6cTJQZGlMWVU1MW5RMi9hcUNkWCtEd2UrbmpaS1VlanVp?=
 =?utf-8?B?QzZ6Si92WGIvNmoya1VBRW5LNVpGNnpqeVR1RFU1UWpwLzlYRDBBMlFWNERv?=
 =?utf-8?B?WlVXWXFic2NTa0pndXVZSjhXb0pySVYxTFZSRVN0Q1pyeS91dXp6WGZEWlYx?=
 =?utf-8?Q?7fxkervGHmINmVQ2Sb7l4BK8cvFN7g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZMYXhBS0JMcTVDaUs0YmtTcHBrMzdNQXpDZU85QkY0ZUV4a0k2L0JCWTYx?=
 =?utf-8?B?VWVpRS9PREJ4anlnYTAxQjN1Z1puY0ZUaVlYOGN1TGhwVnV1UzRrek1YMjJD?=
 =?utf-8?B?TmJreDhQc0lKSmdLWTViaDNNcWlVL3FLNW9Odm5WSzlmWkVEUWZGOUNPRW5Y?=
 =?utf-8?B?RUE3eVcvbmIwWWpzeHFyeE9DWXVzTWlZczFiT2lPMFppdnhwc2N1TUQ5WDBO?=
 =?utf-8?B?VEZEeURkRUdLK1ErTnMyVEphclhQeGJ5cnl0azFLQ2dTdDZRaTJJSzBlR2p2?=
 =?utf-8?B?R05hYjdGbzFRZ1kwNWZWOFR1aTdDNW9EdnN1clg1ZEJJYndTcllJYkdaK0J0?=
 =?utf-8?B?bVBFWTNwd2UrRnNwRG5WLy9lV3p3K2dHZUU3M3UvZHhhZXAzNG41QkpSdXFi?=
 =?utf-8?B?VkhaSlZRNnhBSmNPeVVPRWFFaWVuNmNtZnJZaExFdzE4bGJCQjUycTZrL3J3?=
 =?utf-8?B?ZUxTcy9mLzFid3R2a0VCalh3a3duK0xRYVM1QjJ1U3ZqTFFkVDFvb1FJdEpU?=
 =?utf-8?B?akZxT0dnZC93VlRUUW5oc29IT0VjTzVjRUk2ZGYwd3F1N2NXRnBkYlRRTU1x?=
 =?utf-8?B?dkZHZUhabU1GUXJVZm9JYkhIWkMxbmZnZzA5R0VIY2swQkpWMys0WCtLbDJu?=
 =?utf-8?B?OGVHTVVaVjY3RTBqSEFNMmt3Q0lrc0JJKzAzOUl0VlNzelFhbDhuQktpVEth?=
 =?utf-8?B?LzlFZmRkOVBMR1p2VEdaL1FsV1JocjA5MWV4K29jMWpPWDZEeUhRbXBXTU5y?=
 =?utf-8?B?OXlLOC9peHg4aG5rS1RoQm5VcGY4N0RWME9Ua2dnakhndHhobWMvMm4zc0xS?=
 =?utf-8?B?OEVUMHRxbEI1Zno2bnFSRGszei9OTDNwUFdSY2FSVTFIdWhJOEs5TEgwejAw?=
 =?utf-8?B?SGJ0L3ArYWNKNHJSZDU2anlhYW9ORzlZTGtyVHNWN0c1YzdqQWppSFBuRDlG?=
 =?utf-8?B?NVF1MkY2WFNtbUZqa0RUMC9tVVFqWjdTYWtWdmcvc2xKcUZSYXhONmRvcjlB?=
 =?utf-8?B?akJIRXRaSzFVVnZuempXelNhWUMvalVzT3I3akRFR25kNGV1TEMwblZGMkFY?=
 =?utf-8?B?VEljR3pTTU1kSHQ4dDcrVjFkRVNZQmNMeEVsam9iUXVtVURhbkxzNUY1Sll1?=
 =?utf-8?B?aWVXRmdWeDV0ZGFHVit3N1NVc2dxcmkzWFNtR0djWUVOeEwyeG1NbGJHdmNL?=
 =?utf-8?B?NG5BNmVHalZLWllrOUdpOUp6ajIyRjdCd3BnbWwwUkZMYkhJL01DemY4RENO?=
 =?utf-8?B?WU1SWkhtK25hNnNXaVVrOGNJbTlLU05pc01rSzlGalpraUQvajJFTWlXNzFZ?=
 =?utf-8?B?d2hYTXEwUFliV21zQWt0S2ZhNDltTkxId0RVNTRWZEJPTXVKcFlrU1hRTXlR?=
 =?utf-8?B?LzRIZjZuVnRMLzBXSWVEYzVqZnRLWFJsZksrcGJwbndiTDZJNWpWYktIZUJv?=
 =?utf-8?B?MzVDK0ZmNW5DVy9BbXVqNHBSTFVMV25IYmIxODlHTUQ1ajJJSHFXaHgwaGNl?=
 =?utf-8?B?dHR2V1kxQk1MTVdCeG9QZlNmbGplVGpnY2wrV1c0N044b3VxM3BUSjVTMEZK?=
 =?utf-8?B?UG40dHlvZE5zdEpGME5LaDdRbE1RNEFBdTdjQU1YbnhLWUMwRlBYaXZDMzE4?=
 =?utf-8?B?REFXYitvUHJiY29JUVhiQkMxOGlxTjdVdjZEN2hWcWJPRzlkM0pCYjJ0K2FO?=
 =?utf-8?B?TXF0RVdZc0M0NExNV2t1Wm1HRVRiZFphQWlBYjc4UUNZcGxHYVhrTi8yaENP?=
 =?utf-8?B?MHpGaDUrV1p5OGRCTWZiM1lQVW80aSt0ekdTS3JPRHJLTmg3L3YxT0JFVjBY?=
 =?utf-8?B?UmIzTGt4ZzdRV1J1bUxtVHhBTVIvR2NWTWlHNm1xMUowTG5UUjZtcnpHTzRp?=
 =?utf-8?B?Y2NrZ2NPTWU2QzI3Q3FuWGF1WURKQmYwTDdrTzhYUTNkSmZjdFdPSXo0NGFW?=
 =?utf-8?B?SUpTazZJV3pBckdTZkVaZjVENzdGVStTUHBrRzJraW8wM0JlZE15NHpRamE5?=
 =?utf-8?B?TlRZdlBaaURYRi9MaE9jV1IvUklodFhiQWZQOTdHbHdBZENGaXlqek84UHFV?=
 =?utf-8?B?Vy9LdUF1QmI3bFZhSENrRm1XSndnaUhWM1RQK3I3bEtMS2dTWTV3Smkvd1dY?=
 =?utf-8?B?MWRXTzhRdHIzRG9pdVBEbHB0MG9Kd0FIOWM2dkkreHhPU0JFa3luckM5SVZR?=
 =?utf-8?B?d1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9148596e-939a-48e9-7038-08ddb3bd1934
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 07:51:30.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5aDclEfqoBz9XMekGX/7zweZSuzKGvMuh5u/farMvv/IeXXkhaggJs3ZMqdVg+epqJgVjCxNYIigssg+bpDj7ERCpNU1Ven6uDi9tqbaqigLplRCwiXRdce27FtzdyV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1YzgwMTNhZTJlODZlYzM2YjA3NTAw
YmE0Y2FjYjE0YWI0ZDZmNzI4Og0KDQogIE1lcmdlIHRhZyAnbmV0LTYuMTYtcmMzJyBvZiBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldCAoMjAy
NS0wNi0xOSAxMDoyMTozMiAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMtMjAyNS0w
Ni0yNQ0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gOTM1OTgxNjdkY2I2MzUxYmE0
MDQ0OWQ5OTQyNDQ2OTYxNjhmMTA5NDoNCg0KICB3aWZpOiBpd2x3aWZpOiBtdm06IGFzc3VtZSAn
MScgYXMgdGhlIGRlZmF1bHQgbWFjX2NvbmZpZ19jbWQgdmVyc2lvbiAoMjAyNS0wNi0yNCAxMToz
NDoyNiArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaS1maXhlczogZml4IGZhaWx1cmUgaW4gaW50
ZXJmYWNlIHVwDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCk1pcmkgS29yZW5ibGl0ICgxKToNCiAgICAgIHdpZmk6IGl3
bHdpZmk6IG12bTogYXNzdW1lICcxJyBhcyB0aGUgZGVmYXVsdCBtYWNfY29uZmlnX2NtZCB2ZXJz
aW9uDQoNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtbWFjLmMg
fCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0K

