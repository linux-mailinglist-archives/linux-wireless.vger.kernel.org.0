Return-Path: <linux-wireless+bounces-24760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D74AF0D61
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 10:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6D5445BA7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BAC22A1E6;
	Wed,  2 Jul 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPfGkC6f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB615E96;
	Wed,  2 Jul 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443221; cv=fail; b=Ehf6h8tqylRgcDzEv4dF1OBTSIySVVyNMgIHqDAF665G1llFHWoNppgCBESGV6v8mtfeKDAwpq+G8pMhecPmKVOddz1gtfuf0KKHs8GEuq+NEi7zzPg1wiqTbFusnrbfqqXKcL0GGRatXq0FZVeMWcmj2tQ5odqqq12aKNHfa2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443221; c=relaxed/simple;
	bh=vaaGfNCMlhgPeT7PvN++YlKRKxOyEmkIJoxUu3tPBYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHXe5XhAOKQXEfuGbvBdHCrDCzX7zjzZHX/Eo2k9S3C99u7DcI9Mtat3Ss3FmN4y9Cd5ROL+yL9n6kfU10brr+3vFntPHa4voWRc/WabKeaWbsQvl4FXQAkjRthPJb7QH1CErNVHaIYvHiUjST4cm2hGVxW8D6WGX5tPpapW1R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPfGkC6f; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751443220; x=1782979220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vaaGfNCMlhgPeT7PvN++YlKRKxOyEmkIJoxUu3tPBYs=;
  b=BPfGkC6fjGKMiQ7yUQLeJgvKbi7lMwOcM1ZIlXUnwMN3AJI6PV0m2Vlg
   yOr7Gzbc1FTQiNkxBHyk5o/5kKVmMKu3yyOd4FGa6patIkL9MTuX4PxsJ
   rlvLL9PMTbyBtX7TPhZjto6G4980p36DMI9aiDKoEoFhV4TkdKzHBUGJa
   vDxNLudFGDOcgx6GdqfChpp9kOryog39If//4Y6jAl0IoC9osfD66h7ul
   OR7IS2eDMCkvLeiNX0kfEDUToR+7bR1AdrGc3S/XU3JB9dizcN1Qo9E2a
   bQBqV/wq85oEeQcBujmuyflngB/jyN7QZKsWCMeHkL1fDP/UteWmTW/3g
   g==;
X-CSE-ConnectionGUID: CIAlET/MRoCWwC4DMC5Wfg==
X-CSE-MsgGUID: ByHosDYmR52DwBKYD9watQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52959056"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="52959056"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:00:18 -0700
X-CSE-ConnectionGUID: CgfR2RqCRWakrqJSQyWFRQ==
X-CSE-MsgGUID: nCjNm4WISaOLbVEh+5xTPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154735549"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:00:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 01:00:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 01:00:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 01:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anOc/6Jorxbj7s8pbI/UACuuXwP4JGaL9v2vYQvrEKGv2gGiDr7L61XRewQV9ly833DdGNNBJK4uf5OvXAov3RUEBVZyiS9lkyQMdfOGCAo662N13kOBbHn7Cm4ngwhO5rZQMBdYBR5J+dvyK7WJSqzJPMSIeB/5ZU352Ow85hDGog4FfH7z6Po48PbGyf74h7AY0NSBpm2e/vGzHwdWuf431C89bTKNQRLqDEr+QIM7YKWGyeU1MFg7e943mD5HCpnhtXKtgTxliGfVzGbliggwqB+ouQ5JVhS3LqNVdi2KqH/60YCvyN2NVRDavfPdwoBayMnqH9qHTiPT5UjQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaaGfNCMlhgPeT7PvN++YlKRKxOyEmkIJoxUu3tPBYs=;
 b=XG5Xqkh39u3YydrEauoU4jYUjSCTFZgy1URp+Ko1Z90vojnmGBgoGtBb0QfL01FV3WS53LTZowep0N0wd7M01uoenDSLBoXPvBzOy/SP5c3evMFzUmesGQzFRJW3gHawE3OhLdPI7pEFBwPkB11OKs5BzevO2waAmOofVGsJqHIMeFH0V83nwB8w7s6Y4uw4v0c2WrKhA+HqrjYi8uKlslz4sMWZJPlIyMXOQEXLEVUtSqatloyBG/rP9qjZbKF3qc2Xi0tl+LpFJpUWUbinLjQUiScYNda1nm+x1YYJ1T+kE1hF7uLaLc8zwP3UY3rgL5hGQoZ6vd0mFzGGzU7JEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SJ0PR11MB5005.namprd11.prod.outlook.com
 (2603:10b6:a03:2d3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 08:00:14 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8835.027; Wed, 2 Jul 2025
 08:00:14 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Jiasheng Jiang
	<jiasheng@iscas.ac.cn>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: iwlwifi: Fix error code in
 iwl_op_mode_dvm_start()
Thread-Topic: [PATCH next] wifi: iwlwifi: Fix error code in
 iwl_op_mode_dvm_start()
Thread-Index: AQHb6rM26izVO7Og7EmMrQgvAVfHorQeeKLA
Date: Wed, 2 Jul 2025 08:00:14 +0000
Message-ID: <DM3PPF63A6024A9A35841B9414F6099074AA340A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <a7a1cd2c-ce01-461a-9afd-dbe535f8df01@sabinyo.mountain>
In-Reply-To: <a7a1cd2c-ce01-461a-9afd-dbe535f8df01@sabinyo.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SJ0PR11MB5005:EE_
x-ms-office365-filtering-correlation-id: 5bdda0ad-1550-47ee-56b6-08ddb93e7a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TUdDTE82SDlaU0FiOExKTFFqSlEyczdQVmNsZkFhYkZ6ejQ1WVZUNGNkbHlQ?=
 =?utf-8?B?Wi9qZlhaY09MeE96Y0wwUmdqV0w2R1pjT2dmTVNjd1BqVXFNbVFuMFVXdzBn?=
 =?utf-8?B?bXpmQjdpVmJZME14T1RBK0RsNmxBN295TDZhckRDSVpFOHdmNjF6K2o5UTN4?=
 =?utf-8?B?VXdwd0lraTZicmx4SWZaSWFGUmpsVTBoUzQ0YUpXTnIzRnFuYnU4OFlpeDI2?=
 =?utf-8?B?eWpueU5DOHlaemdIWjYvSkRaQXIxL3pJdHB3YmN0NW5pTWkyN3pKenJ0MWVs?=
 =?utf-8?B?NithU2JMRm5LdzZMOFlBRHpuSjE0MitrMW1zcHFvYjhqTDVmVlZCV2tYb25a?=
 =?utf-8?B?dXBCSlFaTHEraGg2aFlhOTA0VGFGa0UrQWxSOXpLSHhTaGxicVFBQjNETlJ2?=
 =?utf-8?B?V2NjYkpGaDRKRWhsbVg2UlR4MW1WTGw4K3RIZnRQa2xDWWJEN0dqY1RzYSsv?=
 =?utf-8?B?TEthcG1yV1RhNStnaklyU3QzeEFWdThnMS9DSFlYMW1rVDhuL0hSM1E3TkNz?=
 =?utf-8?B?Wkw1M2ljandqQTA2Z3pCL1oyMDVDQlphZE1EZXFxaVlGbnhVR3FmeEErVFlN?=
 =?utf-8?B?cHlVZHZHb2x5TkVGa2hmNDgwb3FFV2ZMNCtBM2tWOFJ5ZnBmRVNSMEpndjk0?=
 =?utf-8?B?NTBzRDE3T3Y0UEo0dXpRaUpzV1BoUGtGOVVuU3hRajNWOVgzYk9tZ29hajFt?=
 =?utf-8?B?K1NId0pHRGVlYlVQdldGTktiUUVrc2Fia2UxRUJHUVpPN1E4VzZ5Vkg0Z25O?=
 =?utf-8?B?Q0h2WERWaWJueXpMYStCUE9EM1lodWozYXlJZWNpVWttYktWNy9GUTBMTDRz?=
 =?utf-8?B?WWw4WTVsV1RmSWFqZjU1TWhuY2FLamVZeE5adTZXSUY3TlJBakI5cnE0bk42?=
 =?utf-8?B?emVXN3FDTEd0d3E3Y0JGTkpsVFlLTHZLQU01UXlmM2pKTVVRbm9hd1BTQTVE?=
 =?utf-8?B?dzl4NkxxWjRnY3pueEExZDZLSjhNeHdCQVE3Vm9ZUHE2Ymg4TkZOVGd5ZmlE?=
 =?utf-8?B?MEpCa0lhZXl4dEJacEZteTFtRDA2WkJORUV3QUFtMFU5eTY2Q1orblFlK3Bz?=
 =?utf-8?B?ZTNrUXlrQ0d2NUVmaWhMSVdNWXY4RG04Y0VvSjA5SmJXZDgrOXNyYkUzK1hP?=
 =?utf-8?B?cXhJdE5TTkV0Q0V3VDlrUjRPbTd1SHhISmNzYUNvR1dyakJCK3M0UXdUdW1B?=
 =?utf-8?B?NDYraUREUWdqWkxiY3B5S2p4dG5FQWhMNklnMW9HK0pUem1oRlArdHdDZUV4?=
 =?utf-8?B?Nk1pb1EyUXFwYlRJTnQvNVNQL0Q5WnRPcTFad2gzMEdubmxiVS9sTjdlZU9E?=
 =?utf-8?B?NGZUM2tFMThja3QwemR0b1JSYklhaVp5eGVjdGI4bzRNTEs2dXlJSkV1RVJX?=
 =?utf-8?B?R3R1TzZJTzNkRmNPMVhBdDVIOWphU1REcCtVdFVTVWJKUURrRWtuMGp6QzZi?=
 =?utf-8?B?ZG1KNFhweWFPTGtEWWttUGpFcTFuVjRjVmMwQjY4WnFEOFdqUWF0dGhMQzNG?=
 =?utf-8?B?UE1uYnNlNFQwR2dpZVowUjNPYWhyNjhRMEhjVnZUazQvamJ1QTIxZ2RoQ0V6?=
 =?utf-8?B?QURURUZ0TVU2RVlRbkN3WWJGaUJacWZiMjVrQmFreWVBeng1aFdxb2J2bENq?=
 =?utf-8?B?bC9mS0NQUzRPVkJwK3VzOFV0bmlNM1NwTkV1WnEzbDkxVEFtOE9jb1JQNWVG?=
 =?utf-8?B?SHRYaUd3Ui9NaWdOaWpNbStpSFZxbGVxbTZVZjFJZ0pISFM2SFpVZGk4UlZQ?=
 =?utf-8?B?SEE3THJiVnMveEFYYlVGWklzdXlvdG45Z1lqLzh5L0ZKeDBCRnhaQ0dHTGpv?=
 =?utf-8?B?ckwwZCt3VzFyM1E0NENRQjRMdFkvZVYyY1dpbFQ4UWZGbHQxL1hVQWdOSUdz?=
 =?utf-8?B?STBqVVJYUXpUT0N4Um5obFRxY1lhbWUzMTlsOTVGckMyc2d5MlM3TG5RZEkx?=
 =?utf-8?B?bGljZWZpYnRDYWZPTWgxc1pobklremVFMGZGelpqb2lSMEtVejEyaDRSL25v?=
 =?utf-8?Q?Ko63ko6ycXiduWptaGB2Z1HVL6mjeo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXBKVk9HUUFDSWZXN0U0ZDNwUExFSWNuVDVZRTVyVFY5MWVVS3lXcnY4dkRW?=
 =?utf-8?B?eW0wbjdWTmczbEM3NUpzK0lldy9XRlI0TnNzZEpySFN1WXJSTW9IZmdDYkd3?=
 =?utf-8?B?TDNKUGJkdG1CN1hqRGVCcGdxRTdaMzIzWUtJNm1WRlIrdHBPQ1M1bmJaUGF3?=
 =?utf-8?B?L2ZEb3lrRDBraTJENXR2dzJCaVNMMmp6OFpOMmpQbEVLMDVKNUEzeHhlUXV6?=
 =?utf-8?B?czBnVWJNTkFhTDRQc0VWZ3pXa1pJTDkwNm5FZG5INmFsRlFQT1BXL2g0Rzg0?=
 =?utf-8?B?YXJiUUZ0UVNadEd0OEtucHkycmlFbUsrQ3RGa0cwNFVvcnJ6V2JJdnZydUU5?=
 =?utf-8?B?a3FnMWkwQ2JFdUd0aGIwQjR0bGxydGdlQlBjRE44SElYdjVGdEppaGxJTUtN?=
 =?utf-8?B?ejgrYzk2MVY0dC9XV2dJTVVYNmxOMFBoQnQyMTEyVi9oRlQ3SDJRWDErTW5D?=
 =?utf-8?B?T1Y4dWx4Qk4xSEJqbWtibDU2ZTZaN0dtYWJENVY4ZGk5MzJZN1ZPa0EvMTFP?=
 =?utf-8?B?aGplZW1RNE1RR1VDSUxlNDdBNi9JY3B5eGs3dXk5Z09LN2NTZGlmbVpFSlIy?=
 =?utf-8?B?clZBQXYwREZ6WnV3dysyczV6Q3lXRkJBb214cUxXR0hZelFabmNmaTlDbytM?=
 =?utf-8?B?WGQvWGdqVG9tTUtQbW1zOVR2c3k5T3NkZ0hjYUhoOXVQR2ZDa3lnUWMzRytP?=
 =?utf-8?B?eE9UNkhLbUtjZmVUeWlXUnpMSHRDN2xwRWtKN1QvZjQvZmhuMUdOc2gyVm5D?=
 =?utf-8?B?Y0dIcEdSNVhnQnZlb0tkelVxZXE0dFJGWFY2ZndmU0ZjOWgrNjNJRDQvVnB3?=
 =?utf-8?B?WmxFZWcyeFVWWHhkMnZ1OU4rZHhJWmJOeURya3BlUUFEbml2Q1hOd1FzT3I3?=
 =?utf-8?B?ZHo4aStYck5vNVlvbzFibTFGTTljZThPQVlieXJMc3R5c3BveExUdWpDOVg4?=
 =?utf-8?B?U0xVczNleDVjanRzME1zNENaVFR3MFlJMk5ybmdyOUZVN3l5THJ0K0QrT2hq?=
 =?utf-8?B?RFlrK0JFbU9PMG0wYTJjLzFublVVNTQrZ1pLL2ZOc1plV2dkTS9VQ0JtLzBu?=
 =?utf-8?B?WVN5eDNHMmpId2dJaS9Sem9TaVVwK2hDOVdiUlJnYUMxemZNaGN1SEZtOHRu?=
 =?utf-8?B?aG5YWHFHaCtzQXMyd1FGTXdwZ2I1QytXaUQvMTVrZlJLRy9nS3QzRi9qOXMv?=
 =?utf-8?B?cG1iNllRZFFuNStiU2xwQW5TOHlHbGVSL1I1WXFTZSsva25BM0srOTA5VVh6?=
 =?utf-8?B?V1NyZ00wRm91eFpkWVRpQ1U0Zk4rbWRVN3RZN09IbFBnVVRXemZKSWRINGNl?=
 =?utf-8?B?eFM4YmhDRWVSZXFzUGI0eS9sT2RTVm1RR2RLbUU1SmpzVENTb1ZzUG8wMmRk?=
 =?utf-8?B?ZFMvNmZ2UmViZHpSQ05LQVhkdE9JdHdQb3lHUTY0eis1NDNTOEpVNXN0Y3R1?=
 =?utf-8?B?SGRBOVRCNk1tZnJWSzA3eThuRTBPR3gzS2RoWWlDWEdzMVV2eFdVVXBiUGdQ?=
 =?utf-8?B?MzdoVW1UOEdPYVA2VmI1QTF4RWM1N1R1VTdYZk5xQVlDSkFyNW0rcUxhVVFV?=
 =?utf-8?B?NU5WamVMR09VL2wwNHRLZTZlQ0pScjFNRTZzN2Rya0pKVnMvaG9yZ0Fzbk0v?=
 =?utf-8?B?ai9NaVlvSGtqd25CWWQ5dGV4bSswRmJ2dGZTUmtweEFYaE5MUUI3YnpsYUZx?=
 =?utf-8?B?a05iMUs1OHQ1RjZIZzJQQ2tZT094VGtEREN2L2ZRSTRLcnNTZWJlMWZQeGVk?=
 =?utf-8?B?L21CSnUxZ0JFWS9PZzhRbytZYmFuZ0lSOVdzU3pKM05MdThRODJJRHRhd05O?=
 =?utf-8?B?K3U3OHVab0hoNEJnaUxBUkM2T3MwdVJReEJjcnVZeUh5eFhIQzRzNndkYWpY?=
 =?utf-8?B?aXZ5cGI1blhheHk5UlpKenJteUJwVzNmSDB3cCtaQSsrR2Zrc1kzeWVxaXFQ?=
 =?utf-8?B?dEtkanMwcmNMVXI4VUd3UjJ1eEx6czZsK3ZyaVFWTzR4NTZzcG83cWp5VnJ3?=
 =?utf-8?B?dUNhWmw4bjVkU1VIdG5PbGxQeVp5WkhvYWR3OExRM0JKd01YazJoZVR5ck5O?=
 =?utf-8?B?VE1GU3ptaU9EOEQ2VUNPTmFOdGdHaGVLa1hwLy9xNGtRQU4vaWxGWm8raThh?=
 =?utf-8?B?YWFGZWJPV2plQjBITGh6djhXR1kyR2xLT3k0T1Z4QnB6dDFrMWpVSmhMbU9s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdda0ad-1550-47ee-56b6-08ddb93e7a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 08:00:14.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wz32fThB5pZDWR1Hfwr35Eo1gZxW8MPJk6ifLTRlkfAtMhpsBlqsfNrV6nfssorlZufMejiZdPbq2d6BK7U8L46IPxs28oUKjKcosC1V2omi6KXJHxj9Uya+oiy8WnwP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com

PiBGaXhlczogOTBhMGQ5ZjMzOTk2ICgiaXdsd2lmaTogQWRkIG1pc3NpbmcgY2hlY2sgZm9yIGFs
bG9jX29yZGVyZWRfd29ya3F1ZXVlIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiAtLS0NCg0KRllJLA0KSSdsbCBzcXVhc2ggaXQg
aW50byB0aGUgb3JpZ2luYWwgY29tbWl0ICgiaXdsd2lmaTogQWRkIG1pc3NpbmcgY2hlY2sgZm9y
IGFsbG9jX29yZGVyZWRfd29ya3F1ZXVlIikNCg0KTWlyaQ0K

