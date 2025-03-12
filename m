Return-Path: <linux-wireless+bounces-20256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 021BFA5E45B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584F4160D15
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF8258CD5;
	Wed, 12 Mar 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZ5w+rJx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8623F369;
	Wed, 12 Mar 2025 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807684; cv=fail; b=o1qsCOGFmg0hWApWTBy3WcdhEN3142tW1hJF1tl7myIGjpv1+2Ubv6jbLNP3fpP1tfxAT25GkHGDonoVaY7Oaf8VpgFZCxf8GNNkDuV5lSox7mbNBWv9BUtqsdScNdbEwmFSMMJHSK7UMgbzXo1OiCNIAI+RfDvc5UNuPFePMEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807684; c=relaxed/simple;
	bh=iSHMamP9q1ab21sfk3zY4ZR+p+78B03auSU8w+ZrEIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ax0iNH8rVFSRaxwmwSP/bJMLXjj6z6HH/zNxwVsx4/9D6YgogcDBKvScxkOhHcgJH1fmgBW+8lnEC+Zl284w7lw6qywebUFE6bG7pbJyoKYT6BvhC92GfkYUMY5P/XW/+/Bl3w2HUeivuPiaYk4LLIOOcnT4DqmFvF2H49jAipU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZ5w+rJx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741807682; x=1773343682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iSHMamP9q1ab21sfk3zY4ZR+p+78B03auSU8w+ZrEIE=;
  b=WZ5w+rJxNmQebEFpsr6AwFdsQoMHiM6Zg3yeFioLtm596vcYl7swZ2P8
   DMzrrvPU8k6kuJ4CNkOGiBuqG9+6iDGoR5zDkZtRMG1cS4fw2l0uz2Om9
   cJ3D5FdSxgT/nOdMHMmladRcgVDYPwjKkUa2K2xOueenz5GYjbnDCmlDB
   PnL78rydSW+15Cyqb9SP+Il4SqH5WRghK53aU+3eqtoV9rB7AhlpbGXtl
   g3SWqtVjjXVOCXoF96AGejaCuipVtwk6Oe9PCEd+PlcB9kMnAkqWNgOAd
   /VJ2uK6EX4X70XJaBDtR+cEs2nhGEsjIL4lnUKFzzG9FtuJhhyc8O9zV5
   g==;
X-CSE-ConnectionGUID: Jd7x7+M7Q025SOWMFPuUVg==
X-CSE-MsgGUID: 4Gq4VbjXTT+iHBtC73Hk4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54275497"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="54275497"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:28:01 -0700
X-CSE-ConnectionGUID: 5luCw/nYSHWi+eTm3AuZMA==
X-CSE-MsgGUID: 3khvgNreT8KYsdw1U8AcgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121648823"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 12:28:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 12:28:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 12:28:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 12:27:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgbThg65wL0QaIaAYyFz7gJLxHDCTLVBqPEiKMT54htLxVT07KfLV1u/WXpIduiEcvU8WexzICo7AZzU9c/hjNrWN+zWhzWzLkEab/MJw9CQzPfZscbVecy26ikaaFtK5VUihq+6Ynbd4Cli9h8pt15/xzKhs/s8YfmIp+gLvHIZMCVbD6NeNDN+Bml5KcWGBMmIx/x6a2FYVKnBFMzxMiDy6AQ3ICvF8pxDslcrYEFITogkKrBklmIKzMFj8j+u5h0xjVK490bqofbvfAhgI5vOiG/mwedA0Fsx2RUpWwabGn2FDy/o/Hte9kw7n7hKhmp3a44HyQUBN6nX5EVv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSHMamP9q1ab21sfk3zY4ZR+p+78B03auSU8w+ZrEIE=;
 b=GMU7nW2pSR8z1/OTxmmKZJ1i5V2SfEm47kvZtF1K+0jcuY21PFdPlaYF5VcgG3b3wqZ//LstSXCjnXZhcdkF0qcaWYymSeY+wXSkkX/gfyUuCxwe+6b2UkrZO0H70UzBQ7nWpBq5WQcMTuzlyxnv2yLSs/7mfKLSwDEtFX/XjwfkTYUFIBzeU4U0C55el1MKZPftNpd84bwrWoaBQU4Vl5d45pa9Xj3FRbiJKqbo2y0NdblEXkhGtDwoFJB1jojQMdCMHKdRg0RBUt8hAWhmv0QLGj6EL4dkMyFAxrmrA/Kc0dy0/xyHLHeRU6pZ6vq3yVQIGS4IFGiVYwA3iFQgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB7003.namprd11.prod.outlook.com (2603:10b6:510:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 19:27:43 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 19:27:43 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "Stern, Avraham" <avraham.stern@intel.com>,
	"Ben Shimol, Yedidya" <yedidya.ben.shimol@intel.com>, "Gabay, Daniel"
	<daniel.gabay@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: iwlwifi: Fix uninitialized variable with
 __free()
Thread-Topic: [PATCH next] wifi: iwlwifi: Fix uninitialized variable with
 __free()
Thread-Index: AQHbkyk2ps1nU7Wqc0CGLEC+H0GKCbNvnM4AgABFKbA=
Date: Wed, 12 Mar 2025 19:27:43 +0000
Message-ID: <MW5PR11MB5810FA23CCCA73A987CB8D44A3D02@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
 <a21610ae-e155-44bc-bcc5-b9b8b1c8cbd1@oss.qualcomm.com>
In-Reply-To: <a21610ae-e155-44bc-bcc5-b9b8b1c8cbd1@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH7PR11MB7003:EE_
x-ms-office365-filtering-correlation-id: d963b8af-85b1-4d5c-d472-08dd619bf5fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFlqMHNxcUNkTU1yZmE5Z01yTm1lRHFFdVdLR0dHMU80M2hlTVZTcmVMQW9Y?=
 =?utf-8?B?VWc1MThRVW16SDJST1FkRGxHSzRiYXZrRGZ2cUlnRjU5dnRYYVF4ZjdrdWMw?=
 =?utf-8?B?czZCREZheUNDZVRoTUJNSVM0ZXVzcndWMGN0UGk2N1E1bm83SU53UVQwSzY2?=
 =?utf-8?B?ZjIvZDhmYnlpS0s2TnVHRWp5ZlJ3SzlQSHkxbmJ1K21MQnJXc1llQ3VqQUNC?=
 =?utf-8?B?anExR0VVWWhVVUU0S3h6N2R6cWhzMmM1SWZPR1JTSFdWMXJvbk9aUUVwY0Ri?=
 =?utf-8?B?Smh3SVhEQW8rN1FuQ3RNRXJKNVJGOUxOdTdEb0dQNjVaZytibHE0VlNJVzd2?=
 =?utf-8?B?YTJpWFBPYzdVT3l3amFSWUJXbVVXMUJRVWkzdFZlcjdTdW5ZcUlUOHdlVnFI?=
 =?utf-8?B?SUFnWVZDUnVrRldvYlkvOVZ3V1I3L0grNnZNSWlqUm5Kbmk0d3MzcFpLNlpP?=
 =?utf-8?B?ZnFZdmFtekREQ2lmcUhXOG1wRHlrTVRjUnJNNG55aE5RS3dwTTNDY2NjNEFz?=
 =?utf-8?B?N3JvS3VoNUNpSm04WWFFRkttUXdhRmZQWXBiZk1lMWNJV0xWOUhZQW9RUUFP?=
 =?utf-8?B?UzlVTHBjUzR3djRTUG1kMEl2WXdnYXM4bXluVkFCb0FEVXdMM0lmQndlVFp2?=
 =?utf-8?B?L2MwWHNnVlFCT2lVbmtjMHRzd0dGR0grQXpONEZvNE1SWEtTdTVKQ3BoUEZw?=
 =?utf-8?B?aENWTHlEM2Y4ZzArdFB0OE1xdXpmb0RrZDJidjNYeGFxUkM3U2VTVTdEMUNi?=
 =?utf-8?B?NDdqeXovVU5XVXRHcWUwY3duQS9PV0tJUE1RMTRRekcyc29Ea2pRMnNaMlRW?=
 =?utf-8?B?aUw5MTRpblBpaEdBczBjTUdhM1dBVzVldU40ZWJjaVJTekVuUUgzditsaVpY?=
 =?utf-8?B?VlpPWVgyYTlTV3hLOStiVDJySXE1dDNqeUVaZ0JTVS90V05JcU9nNUc5UVJZ?=
 =?utf-8?B?NUpaUGhGbHJoUjlYNVplWUovYlhwampIeWFDMnlDSXppT3hLWGJLNlpJTGNG?=
 =?utf-8?B?VWpWUnBLOFY3WjMwS01CblFZN2tYVE5EOFRRYWxWZ0VRKzVnbmxIWmlwYTVp?=
 =?utf-8?B?MmFlcUJ5bDdyV2lYQVV1VEdyZ0xOL2YzL2h0YVdHaWd5bzdNZWMweGFLSjlL?=
 =?utf-8?B?ZkVtZUxTV2FiMERnbG1YNkx6OGtUYnp0dHN3amN4eWhyamx3V1p4azRTeVlD?=
 =?utf-8?B?dmJ3NmtaRy82U0I3ai9aWGVpNzBrY2d2MWNQSldxRjdTS0hwNno2S25iekE3?=
 =?utf-8?B?ejV6bFdoSmhMZDJrd00zSnIxSmI1M29BWjdWZHl1YUptWXlOQlp6azlOb2lC?=
 =?utf-8?B?NW1kSXJxRmk3SzlaYVhCVG45SHdjYXZBeGNCdGRDMmR2SUhXd04vSllvRnFY?=
 =?utf-8?B?NXRETlhEcWdZaDlNaTBpbjI3MS92ZzZRbndHeXlpVzJWKzJjVThZZURjREZF?=
 =?utf-8?B?M3FSVTZsNVlvdTBvZFY2dEE5TVVNVE1uNTgxRDMrcE1aNk93bmZYMVMrVnVU?=
 =?utf-8?B?UkJQUC9JQU05ZkNjbDQ0WkorZ01JaUFSTStDNVBibUJVSW9vQU93R1ZiVlJF?=
 =?utf-8?B?MnVBMk1LSUx4QndSOHFiUEg1R1NJQTFETEhyTUdxa2xEOFJUWVNQYWp1Q3dp?=
 =?utf-8?B?SW1vQTJ6OXplTG5PL1o1Y0grWS9lMGYrdGRoeHQ2THMvSnMza1prK0pPN1Bs?=
 =?utf-8?B?WStXMmZnVm02OVdjeDBicFI4WWM5SXRqbGd1bzBGR1puTVZ5d3EreWlsaHpT?=
 =?utf-8?B?NS9TRkNYZThxaUoyeFhucFFUMkZtWXNkNnlING5OZ2lBRnNHWHhlYUsybTEx?=
 =?utf-8?B?Vm9aY3JONGxHdzBOTitWdEVLcnZwRUZObzZLODJpMGdNcXNsWkJKYmNJek1Y?=
 =?utf-8?B?MEpyVlovcEUxd2xmdlhLbTA4dlc5clFGL3c4dFROQ1lmZjU0UXdCRWVrakM4?=
 =?utf-8?Q?H0XIn8c2sJMaAaAR675w8INNS+WqYT47?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGNLckJuNFhmYTJBMjUwWnc1cmkyWlRrVUhCQ3R6K2RHTlg0NXVSL3EvVkQ1?=
 =?utf-8?B?S0p1aDM2YU44czRvbjNLeXBHS05jR2NBWjUrRzJ2MEpJamU4aWVNWC8wN0lK?=
 =?utf-8?B?dWV1azlzWlp6MzhDOWhzMUxoVkV2aU1iOGRhOVk2WVZiUzVUUWN3WWJkVHJa?=
 =?utf-8?B?MW1sMWhsc1llU3EvaUVkMDJIQ3ZKN0p4S3YrdUN3Yy9HS1Rka2JkU1NmQXlk?=
 =?utf-8?B?SVc5K0hzRjBLZWZWT0xYQjZmQVhEK1V5Q2FmSzBYSzl3VjJveTFqRWJHalVD?=
 =?utf-8?B?R3ppOEd3RGtNKytlR1pHR0ZuUHBYdDdrekFLTkhxVk1TNXZqbDk3Z3lGZzlH?=
 =?utf-8?B?bUp4eUU5Nkh1VHo3dzlGMW8rVGt3LzNkWGtCRVo4TnQxT1BycnJ3REtOTlpY?=
 =?utf-8?B?SnJiQVp5RURwYmovTTZuaitzaENUeWNhOS85SjZyTmdvTjhzM3NmMStRZzFK?=
 =?utf-8?B?RExVWUpnYXc2bFZGcFZ6L2tKSThveXJ0aVBkbWZxVkVUTjJDemdIcXc1eGVZ?=
 =?utf-8?B?UGY0TzFmZ2hRUDNyQUkvS2IrZE9qT29nbkVLWkhpbCsvSnJUNk5aa0poWlhF?=
 =?utf-8?B?MFR0eHp6TERwMWUrZHR4V0RxNkh3OTA1cE45Skk2bGZvQzV5SkJVTVlQY2dU?=
 =?utf-8?B?Z1o4enVCYXBPUkttQk5nRHI4aFZUYUIyTFoxRWtTUHlJZTdraDNrTE0vMzZX?=
 =?utf-8?B?dURGOUVxQ3VnelZGTWorQno4Sko5QUdCZ1RYNWlXNkRqM0xJVy9La3RXclE5?=
 =?utf-8?B?Mkhoemo1K2ZUTVRHVHlEZjBoamo5T3dWZUd5dFVlRERCbHVsNVZZOW52UnZx?=
 =?utf-8?B?bWpQWDlEdTJ1YUxxaTYweXYzOFpHOVJIT1FFTzhSaTBWMGVoRWpQUVNMVk1k?=
 =?utf-8?B?aU4ydGVoMzdYcGovbFdHcWpla0RkcnRLSEFmNGl6MFpINm4rcWhyS0pLSmZ2?=
 =?utf-8?B?cGc5d1h3SmZVdGtnRHdtRWp3a0NDazUrT2ZiL0VTZ1YraFVZVG1OdCtjbXJ3?=
 =?utf-8?B?QWFabkNrWVF4N2tWL2F0Y1kyS255NjBjbCtSOStZZ0czYkZ5c0RhVVQyanpS?=
 =?utf-8?B?WW5ERlpIZTBQUW8wdnQ5YXZoVmNqM0ZZZ05lT0lpTCtSSHRiMEFCNmJIeXc3?=
 =?utf-8?B?bHBkaTBjYm5MRm1ENXdjckpJVnRTVHNhSUI5YVptcFlQaVROYVFKVlFFUUg4?=
 =?utf-8?B?WFBheVVHZkg1VC9GSWxBSzNlQ2JMTzMvZjhBVzgydXVxSkIrOUU1UG1GVHJJ?=
 =?utf-8?B?RXYxdmpKMXNNR1RlQ2UzU0lhYU5pZmJYTHN6VC9JZlYwMEpUU3lET1lrQTE2?=
 =?utf-8?B?U3BwWTYzOG1HM3RHejE3QXRFRFFrL3BvcmtScUR5RnJJcFlGK3hORGk1OEJi?=
 =?utf-8?B?dysrUFhBTkRvVFpsbyt2anBDM3NsVU5pQit3cVdIVURnSkQwYmRWL2RXQnBP?=
 =?utf-8?B?d0pCbS9lZlRqU01SSE9scW1QamJhT00zaURVNU5tZ291WndSQ0FmRktxNGMv?=
 =?utf-8?B?RmZndVpPenBiTGR6aFJrTU1hVmxlQlByWVo2SU51ekkrUmVVSjNhSFRuTlp2?=
 =?utf-8?B?b1VBN2dqNWxhWjZpTDdYMkJpV0V2VzROTXVlVzhZak9BSlArU0Zic1BNQVJN?=
 =?utf-8?B?djVESjJLQXhoVnpBMkNHMWlsRHdLSW03b1l6eGs2UTE3cVAxSjZ0Q0dzVkFv?=
 =?utf-8?B?bHZocWRwaXRIakh6bGZtaFZXZ0I5WHI3VTJCMTUvaTEwSUZHL2tmdExkMUk1?=
 =?utf-8?B?RUg1OTdiVkdGTDRZVlVyQnBId0JRVXhIYWdsR0o3c054d2NtWTB6V2RSSWN1?=
 =?utf-8?B?TUx1M28zUmdOWHJPUnhyZnVYUnhXR0IxeGhFTEhsSTNnb0Z4Z1hXUCtpRmFx?=
 =?utf-8?B?UXhWVi9jd0VYTDg0WGlXcVpMT0svR3JaVUVocG1UazdJK0xHZFdIbnhjYkky?=
 =?utf-8?B?a2l1WXZxQUVNWFdlTFFtVFNOVlBHKzN2TFg3TjBzcFdjNmp3VXp1MmdjR1Ba?=
 =?utf-8?B?ZW1nbXhpYUs3MUI5RUZ0ZExObEFMNEtxRW56dE4rMUN5UDZKVWxxR2pmWmk2?=
 =?utf-8?B?ZG1WVXhKOTVqdWN5bllKYTh0ZjdaMkxJYUI0OU5FTTlpUGdzeU9ORW1LOHlx?=
 =?utf-8?B?cjVtSDVDeUJBZSsvQ2ErMXFtZkdqaEx5dXNRNE9DSFNqUmg5ekVoWk9jUlhX?=
 =?utf-8?Q?eYsaCUlmauxBr3RgIFEdCqA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d963b8af-85b1-4d5c-d472-08dd619bf5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 19:27:43.1145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWQQdkO3eZgaXCyIkvP8I2sl/I35PghvGnJtxSLO3TPoZxZ/YSViuGrH1i9MxWuseORjWWwg6H4zVFsP3BxuCNGWbxiOaV1qWp0Ezpft9CQejZGxf1q3pg/E+AfKIu5n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7003
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBKb2huc29uIDxq
ZWZmLmpvaG5zb25Ab3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxMiBNYXJj
aCAyMDI1IDE3OjE1DQo+IFRvOiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5v
cmc+OyBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwNCj4gPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0
QGludGVsLmNvbT4NCj4gQ2M6IEJlcmcsIEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNv
bT47IEFuamFuZXl1bHUsIFBhZ2FkYWxhIFllc3UNCj4gPHBhZ2FkYWxhLnllc3UuYW5qYW5leXVs
dUBpbnRlbC5jb20+OyBHcnVtYmFjaCwgRW1tYW51ZWwNCj4gPGVtbWFudWVsLmdydW1iYWNoQGlu
dGVsLmNvbT47IFN0ZXJuLCBBdnJhaGFtDQo+IDxhdnJhaGFtLnN0ZXJuQGludGVsLmNvbT47IEJl
biBTaGltb2wsIFllZGlkeWENCj4gPHllZGlkeWEuYmVuLnNoaW1vbEBpbnRlbC5jb20+OyBHYWJh
eSwgRGFuaWVsIDxkYW5pZWwuZ2FiYXlAaW50ZWwuY29tPjsNCj4gbGludXgtd2lyZWxlc3NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWwtDQo+IGph
bml0b3JzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5leHRdIHdpZmk6
IGl3bHdpZmk6IEZpeCB1bmluaXRpYWxpemVkIHZhcmlhYmxlIHdpdGggX19mcmVlKCkNCj4gDQo+
IE9uIDMvMTIvMjAyNSAxOjMxIEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiA+IFBvaW50ZXJz
IGRlY2xhcmVkIHdpdGggdGhlIF9fZnJlZShrZnJlZSkgYXR0cmlidXRlIG5lZWQgdG8gYmUNCj4g
PiBpbml0aWFsaXplZCBiZWNhdXNlIHRoZXkgd2lsbCBiZSBwYXNzZWQgdG8ga2ZyZWUoKSBvbiBl
dmVyeSByZXR1cm4NCj4gPiBwYXRoLiAgVGhlcmUgYXJlIHR3byByZXR1cm4gc3RhdGVtZW50IGJl
Zm9yZSB0aGUgImNtZCIgcG9pbnRlciBpcw0KPiA+IGluaXRpYWxpemVkIHNvIHRoaXMgbGVhZHMg
dG8gYW4gdW5pbml0aWFsaXplZCB2YXJpYWJsZSBidWcuDQo+ID4NCj4gPiBGaXhlczogZDFlODc5
ZWM2MDBmICgid2lmaTogaXdsd2lmaTogYWRkIGl3bG1sZCBzdWItZHJpdmVyIikNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2RlYnVnZnMu
YyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvZGVidWdmcy5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL21sZC9kZWJ1Z2ZzLmMNCj4gPiBpbmRleCBjNzU5YzVjNjhkYzAuLjFkNGIyYWQ1ZDM4OCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9k
ZWJ1Z2ZzLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21s
ZC9kZWJ1Z2ZzLmMNCj4gPiBAQCAtNTU2LDggKzU1Niw4IEBAIGl3bF9kYmdmc192aWZfdHd0X3Nl
dHVwX3dyaXRlKHN0cnVjdCBpd2xfbWxkICptbGQsDQo+IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50
LA0KPiA+ICAJfTsNCj4gPiAgCXN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYgPSBkYXRhOw0KPiA+
ICAJc3RydWN0IGl3bF9tbGRfdmlmICptbGRfdmlmID0gaXdsX21sZF92aWZfZnJvbV9tYWM4MDIx
MSh2aWYpOw0KPiA+ICsJc3RydWN0IGl3bF9kaGNfY21kICpjbWQgX19mcmVlKGtmcmVlKSA9IE5V
TEw7DQo+IA0KPiBobW0sIEkgdGhvdWdodCB0aGUgcmVjb21tZW5kZWQgY29udmVudGlvbiB3YXMg
dG8gZGVmaW5lIF9fZnJlZSgpIHBvaW50ZXJzIGF0DQo+IHRoZSBwb2ludCBvZiBhbGxvY2F0aW9u
LiBjbGVhbnVwLmggZXhwbGljaXRseSBzYXlzOg0KPiANCj4gICogR2l2ZW4gdGhhdCB0aGUgIl9f
ZnJlZSguLi4pID0gTlVMTCIgcGF0dGVybiBmb3IgdmFyaWFibGVzIGRlZmluZWQgYXQNCj4gICog
dGhlIHRvcCBvZiB0aGUgZnVuY3Rpb24gcG9zZXMgdGhpcyBwb3RlbnRpYWwgaW50ZXJkZXBlbmRl
bmN5IHByb2JsZW0NCj4gICogdGhlIHJlY29tbWVuZGF0aW9uIGlzIHRvIGFsd2F5cyBkZWZpbmUg
YW5kIGFzc2lnbiB2YXJpYWJsZXMgaW4gb25lDQo+ICAqIHN0YXRlbWVudCBhbmQgbm90IGdyb3Vw
IHZhcmlhYmxlIGRlZmluaXRpb25zIGF0IHRoZSB0b3Agb2YgdGhlDQo+ICAqIGZ1bmN0aW9uIHdo
ZW4gX19mcmVlKCkgaXMgdXNlZC4NCg0KVGhpcyBpcyB1c2VkIGlmIHlvdSBoYXZlIG11bHRpcGxl
IGtmcmVlIHZhcmlhYmxlcyAoYW5kIHRoZSBvcmRlciBvZiBmcmVlaW5nIG1hdHRlcnMpDQpvciBh
IGd1YXJkKCkgaW4gdGhhdCBzYW1lIGZ1bmN0aW9uLg0KVGhpcyBpcyBub3QgdGhlIGNhc2UgaGVy
ZSAoYW5kIG5vIHJlYXNvbiB0aGF0IGl0IHdpbGwgYmUgaW4gdGhlIGZ1dHVyZSBzaW5jZSB0aGlz
IGVudGlyZSBmdW5jdGlvbiBpcyBydW5uaW5nIHVuZGVyIHRoZSB3aXBoeSBsb2NrKSwNCmFuZCBp
dCBpcyBqdXN0IGEgcmVjb21tZW5kYXRpb24/DQo+IA0KPiA+ICAJc3RydWN0IGl3bF9kaGNfdHd0
X29wZXJhdGlvbiAqZGhjX3R3dF9jbWQ7DQo+ID4gLQlzdHJ1Y3QgaXdsX2RoY19jbWQgKmNtZCBf
X2ZyZWUoa2ZyZWUpOw0KPiA+ICAJdTY0IHRhcmdldF93YWtlX3RpbWU7DQo+ID4gIAl1MzIgdHd0
X29wZXJhdGlvbiwgaW50ZXJ2YWxfZXhwLCBpbnRlcnZhbF9tYW50aXNzYSwgbWluX3dha2VfZHVy
YXRpb247DQo+ID4gIAl1OCB0cmlnZ2VyLCBmbG93X3R5cGUsIGZsb3dfaWQsIHByb3RlY3Rpb24s
IHRlbnRoX3BhcmFtOw0KDQo=

