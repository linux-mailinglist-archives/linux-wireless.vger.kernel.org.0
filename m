Return-Path: <linux-wireless+bounces-31651-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id szNHLH6KiWm7+gQAu9opvQ
	(envelope-from <linux-wireless+bounces-31651-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:19:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB010C61E
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7986A3006B16
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914F2DCC04;
	Mon,  9 Feb 2026 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqhE2d7b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BE450F2
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621563; cv=fail; b=EK6GqBEoiF59XWNg7whSWB0pEQkYQDQDqBkTFwD8Tuag6tMGsCUfcjRANCJgM8MdgDpiNyETYal4nTdihVZv3YXEjLiO53mBczPlDk8NIDmlRgpPRXduwlueuvkA1eovSQfDyofdpQwhHrx1c3SRxPoZQ7kjsb2X/UXy8R+CFpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621563; c=relaxed/simple;
	bh=d65nWI9x39BH1JPOoZlas1IgLP1Pazoru9cFial7pQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kGRupYk49Mi/TGEEIAxxVmjpehIr5FwqVIWXKwlqfDXu5h1JkCJnnuZg9yxDVLoy2M74+/PS+mG8KC1fRcfq+tgMkKTaqmWitGJZytHk8v/mwwgL3CmjKEWl5dceVKetKBH/QatuObgLbMHg3fzhKwDkaL+FIc52cBec9WVv39M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqhE2d7b; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621563; x=1802157563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d65nWI9x39BH1JPOoZlas1IgLP1Pazoru9cFial7pQU=;
  b=JqhE2d7bi3iuKlOAKmWb0ave9p4/aeyPiGicQxFJLMcNEVQe+WGvBhRg
   1yZolfJOhzUI1qxtPFWDTGvybUPqqFuiAnmwBkn7SSxV22g6sAIbYGGBC
   uazzEEz04leu4QRm0udMrjDiSxRytqcQ8BIIdcsTZrMu1SXbhI9KN3Jc8
   9ZRZVMdPT9SMZY0uP7E3vTYCTJnLUHEG8T97aT6lX3K55nVoxln0Lk7b+
   xCHCXYR3uCE2mLK9AFrptx9fsvulHBjTTxqFJyblLHOtsA0Ex3vbunK5t
   W1lnqfa7vNIndOLFtuxzsq7QEb8SqV2orc8jEjgkw0Wdpt8CmrV3ktab4
   A==;
X-CSE-ConnectionGUID: Z0attf2nTv2VtXn2sTo4Pg==
X-CSE-MsgGUID: 7eIRuNidSembHxoQlRe5LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75347867"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75347867"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:19:23 -0800
X-CSE-ConnectionGUID: eglV8izhS3aTk9Jv45pngw==
X-CSE-MsgGUID: T8WaegsATPCF7vMg2N9NeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="216002593"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:19:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:19:22 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 23:19:22 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:19:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytl0wb4M2JthCgX/8AYGnyuhpSdBR7kDatuCdV6zwbdoIsPFXq0oHUXGuCSDCMja5AXBObhbyvcP7hU8UqYF1+JO4JDXDrBgpi6UmpzF73z5l7fZJ0pbFUiSxeqm/yCzNnH0s4IGD+Mg56p+yJqzeAlgXvaeDS5EUCAFSXaAGU5ZY2AvnBuXR0mVAzv2LDnr/TD6mLKj4b4RcSfI1e4MDisrHEZKL0tX/XdGHj5NVLMrzVNfp0NfbV0aXPqhD+nDE/49JYFcVzdcNoqW3UJnfJWo6OjqPESeoyvc1b3zs3d/0/GewaYOflX07MXpODuKjmDbx8MHrsHg7uPh4S/+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d65nWI9x39BH1JPOoZlas1IgLP1Pazoru9cFial7pQU=;
 b=qZmvrW4yusEx0NFYw4ir7C+zxG+sZvkRGaFbTcbOK1pt9Q9f45Y2h9YwWvEwk1QHSV8oaWmbgp1izGhJpi5vcVowaqdMtpkTWgb8yyxtGz1UO0w2IhYPor9WN6k1AGOglmrd6BmUikUfWON502LgNUJuCRo7PZxKNQml56fe8MHwmMmAujqtcP8in6ridGuNRw0xdLvFQgbUk3v0VDiff1o+rK2BPw0T4Ta7w1fWC0RLm8w8esbli23oe3/6TN/CKIPhkhRgnR6Vs9zz0ggK9y03eCCWmzmwWag6ayM79Z2gGEFh9M92a0jzwDOaNnaQ22EZ834k3mYqNV+3UTdKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA2PR11MB4826.namprd11.prod.outlook.com
 (2603:10b6:806:11c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:19:02 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 07:19:02 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 iwlwifi-next] wifi: iwlwifi: Add missing firmware info
 for bz-b0-* models
Thread-Topic: [PATCH v2 iwlwifi-next] wifi: iwlwifi: Add missing firmware info
 for bz-b0-* models
Thread-Index: AQHcWIS1yWHU+78xDEK2Q77rOwxY27V6duqw
Date: Mon, 9 Feb 2026 07:19:02 +0000
Message-ID: <DM3PPF63A6024A9247F1115A57EA2B55DC0A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251118121251.149922-1-tiwai@suse.de>
In-Reply-To: <20251118121251.149922-1-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA2PR11MB4826:EE_
x-ms-office365-filtering-correlation-id: ec21fe66-4722-4e57-daeb-08de67ab804c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OXdKS0tlSmpMcWxYcDVWSnYxaHFHczB3YnNjcW4wQy9zb1hLbXZpcUhURkpy?=
 =?utf-8?B?VzZvSnFZZk9EN2E5dkJVNm5weFlxUjlzckdXaFFub3FwaS9CM2o1d29XbjVt?=
 =?utf-8?B?ajl0RnB3TmVGM3g2SlNTbWxTdk1URjVHc0ptOG5DbjVORWgyYjJLUDBCWW9O?=
 =?utf-8?B?Z2hxZFozbmxwZlphRGVmZ0lOYkhSMXppdnVoR2NGMUlmMytwQXRGWk0xUmZI?=
 =?utf-8?B?c3lLd0R6WjBHZ01kZUpYZWtnTjltYktPUm8xU2JFVS90a1ZOd2dqK2VWWmtX?=
 =?utf-8?B?WFhkRTJxdGtGUTJPZlI5NytibnNCOGRDbjJvUmN5OXp2cFVtL1lOSnVJNU1l?=
 =?utf-8?B?dG15R1h0RGkwTUhjY0JHYjJjcE9xVUdqRCtqSGdOZmVYZkh0dXBvNzFUaHpt?=
 =?utf-8?B?U3ovajNIVGpzOVI2UHJ4cU1HTXB5aEk3UXdaeVE5Vk9NL2FBNkxQbGlKSUZ6?=
 =?utf-8?B?d1QrVDFCWjBkSzh4dXdqcllNd2JzV0ZaMzVEZTFuZUNtNWR5STNQNzhxYmpZ?=
 =?utf-8?B?UzVOeTVNdjJMK015YVc4M1E2dlBzVHp6UUhsT0wxSVA0MjNMQW9CaFB0aTRG?=
 =?utf-8?B?N2tGT2t2UVh1MktZVWlGVExHL1o2L2pQUXR6cURITXc2d3NIcDRjU2Q5aXlz?=
 =?utf-8?B?blJMNi96YWpZS25hMnpXUzRxY3FTKy9tWXBjTHV5NWFKVlhzbGVUVnZFUUxW?=
 =?utf-8?B?ZjFPb0E4SmVFbnJDVlN5V3NCRDFYS090VitUYnVzNXlGZXF0ZW5GbzY4dnRm?=
 =?utf-8?B?cnZkZ3pzWmNTUklMT2w3eHhQMmxHOXpUVmpTVkNwZGl4WTlucm9MdzVoRk9P?=
 =?utf-8?B?OVJFRk4vd2kyTVlqckFQY1VDaEFUYzYwRlpaVjU5Rnp5WmV1QTgvcmo5dzhi?=
 =?utf-8?B?bC84MER5MElVUERLTTRldDFaK1h2VGM0Sm5xLzJMdTFQZVA4V2xlMnZLbzRI?=
 =?utf-8?B?bzZPY1l2azh2ZXNnejlGRjRacSswQ3dRQXNCUDVwT252YVVDQTMxTjlnQW1p?=
 =?utf-8?B?OHhmZFcySytSV0lVZXpvTmQ5VFFob01IVmVZRStnQmFZQ2YvQ1dCZkwxLzBY?=
 =?utf-8?B?U2hISXN0M0ZyNGMxTEdLQXZST1VoVXhhY2hVelhqZ2JFVmpBalMvTjdFcFNK?=
 =?utf-8?B?OUxnMDd5ZGJwcTNCU0lwaWhFY3BlcGMvbXphOFlwZlY1R2cxMml6QmJ6RTNh?=
 =?utf-8?B?cVFnS2VrQ0xISnU5cXVoaFEyUHd1YUpNaFV6dU9vU2d4NkI0UHVuSUpYM1RO?=
 =?utf-8?B?RFdzUnNCc25nTE5MTXhmQURGN0tXMEMvRVoxQXF0b3ZQTmR5S3hZKyt3bXNQ?=
 =?utf-8?B?cU53MFlRUXQ1N2tYTmN4UndndGVTcW5Bek52aEhKY2pwV0tZdStmU2ZpMlQ2?=
 =?utf-8?B?WG5xZHFYSTVIUWdWZjRUYTI3RThTSWdSL2VReTJUV3NDWVRQeFpUNTFSTlkx?=
 =?utf-8?B?Zy81blorUURBcjZwdEJhN3FXOHk4MFpNWW1WNEJFaUF2NUh6bHJnbkQxU000?=
 =?utf-8?B?QnM4S0NvcG13b0hKOXRUR3dXOCtXMitSSFNOa0Rxa2pRbHZmcnh0ZHRka3Y4?=
 =?utf-8?B?aXF6RTVYNlNCUGhvaEUxeVNoVk5iWTJld2RkdkwyMnRjQjRDeVhNWmlMUU83?=
 =?utf-8?B?bDhsa2F2NktvMFJlUUUxaHhPNjIwWG1UYVlyMzZscEFLZjNQVDRzTHhKTzhk?=
 =?utf-8?B?WGpIV2FCWnJOSlBoN0RiQk5IZXA5UElmc05WdDlsaWdvczdQYmxYRzFTUDVN?=
 =?utf-8?B?Vk9oRkNGbWt3ZjZHdUM1aGVQUTJiMXlYR0lwUWQwWjEwREV0WFVIZjJ3cnV2?=
 =?utf-8?B?Y0podURNS3JEcUFXZzlXaWl2NjRmOFErQjczQ1FCQWdGbEdKRE1aRDc5ajhy?=
 =?utf-8?B?MlVYYjBjUmN1bFBxS2dRenFvWVhacXlyVDNXRS9RVVkyOXpqVDVFSlczMVla?=
 =?utf-8?B?Z0ovZ1NUdWRaY0JpTHl6TkczUmdiRTZLMElCMzB5OWVXVmEwNVBsZGQzSGF1?=
 =?utf-8?B?MDhrakgzeGNpamZzcS9UY2JJQjNVOG9NdmdkR0RRZk9BeXhFeDArKzFhTlpw?=
 =?utf-8?B?Vi9OeHBKV2FNQXVZaU1jQzVMOUFlK3R5TWJkaVNWb0RDMm9Cb3RmeGtROEdt?=
 =?utf-8?B?Yi9XVjFBRlBjV0RWSVZXcUp3UW5wazZ3UHFxSkhtT1pnazVmWXdsMm96YjJY?=
 =?utf-8?Q?JXlOWKZQkypBC7tGVC3NuH0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sno1TlQ2SllmektBdVpaYXJsUGRMclV4emEyeE8zRC9HZ2FGQ1NtbVZUUUNF?=
 =?utf-8?B?SUdpOXBUcHB0MWoyQkI3QmcwV05sMnNQcWNWaUNpKzZuVWZqVzRydTlYRmcr?=
 =?utf-8?B?M1czSnJwd05ZRm9FMXJkTWk2dWZaWXpqV0V2Z044b3lIYVByQm1ScTBhaHht?=
 =?utf-8?B?dVFwL01FTXRLdFo0NHZkZUhaOHV4MWcvQ0FTM0c1dm9QOEJUNlFuTFkwczMx?=
 =?utf-8?B?YkREbDNMU1pJTWRqcDRlZmpDMk5LbUlkWk85Vkg4UmZNWmtnakhVRm1qR05n?=
 =?utf-8?B?SjB3TDhlYy9UMjBqOVdxbXpwY3lGL2xqZXVibFdGNHc1SEc4cTN0TjA3WVd5?=
 =?utf-8?B?d1NBV3VDN0phTTlDM3lwajJCUmJrZjhuNzFhWVYyZDdKZGE2RUwyME9zUGQ4?=
 =?utf-8?B?U1cvZ2c0eXRVaGlQUDJFSTMxMXZydHcvL3l3M1lnR2VXQUxEYmw0bjNTRmFP?=
 =?utf-8?B?QVdzcVhmVkI5VlNrczFuSlFWdW5xRWR4UWJ0d0VTdUdRVzVXbmV4bnVMeXhs?=
 =?utf-8?B?bFNnd3p0L25HQUFWT3djU3BRSitTT0ZETENHK3F5UWhHcE05ZU0wb2pnUCtm?=
 =?utf-8?B?anVPbUxKTERjckczV2Y0bkdwd2VTd1dVVkc3YnVZTytHa09naDRVWHo1bWNH?=
 =?utf-8?B?NmxMdzI3eEFOVUQrbGY3YmVCMGdrS2hnMkVRY1JqYkNlcDVNby92MFAvdUhm?=
 =?utf-8?B?cUtRZzBXMmo5SEE1UTJ6U0VtcEdvdXBHZk90Y3Arczg3MDVsNkZIV1FxK3Jt?=
 =?utf-8?B?cmx4cUtrUkNoRkJFK2FYOE8ycWRPKzM3SnhRbC8yNEVrNFUvUTNjcEJseHd0?=
 =?utf-8?B?ZzBGZWJpWS83L1pkU29RR2NLUFVBRTN1UlIxbVpMTjROS3Qvc0ZtTnlrSSsr?=
 =?utf-8?B?elIwVzVxdllhSTc1QTJFRFliRVl5ZWYzT3pUbENzRTJjYk9BT2hQcWR6bmZC?=
 =?utf-8?B?VnZ6aURZbGxYSCtwWnpOcDB2Mi9OcHRHWmtuR1dwbHFHUDFtTGJ2WDliRWlo?=
 =?utf-8?B?TWpaRWNoZXgwTmFSbnE4eXJERmlsc2pIdWpaRVhmTVMxa2hwUk5YN2pvb0N6?=
 =?utf-8?B?SUQyaHZYd1h5dElCSEpNeDVvRys5dlZadTUyYVlXam1wbWh3dUtGdTVveVhG?=
 =?utf-8?B?aGpXbXh3S05XYmpZY0lSTEpjTHJZWlJIMG5lS1FaWHFKeEt4SmxVejV5YTN6?=
 =?utf-8?B?d3VXdEIzblZ0Ym0rWUZlUlNuWnJpdHR0eU56TWxQR2QwUnpwZTQyRGNYSzBS?=
 =?utf-8?B?b2dNZGlQeTRtS2Q0TXpqZEl1YUVaYUJ1MmQxSmYxeDBSVnowN2ZUN04ydnZQ?=
 =?utf-8?B?UjRZSFpXb2J3dmtHc09KZEMvVmQzWmRGRXo1V2E0Z0NSZEpHRHlITGVqRmtr?=
 =?utf-8?B?dHpxWmpKcURUNmVacDN5N3VDSk11clMvUDNnUEFVcG9NSHBKUzZrUWRqVmMr?=
 =?utf-8?B?ZWFBbzhqdkdaZ3dwMHZ5SVhHc05IVkNUNENrSDZSL3dNYmhnNXV2d3Q4Ulh1?=
 =?utf-8?B?STFpdWoyOGxTdjk2WUkrMnpEZHhDVHB5SExTUTA2a2V3ZHdVK1llVXhuSTJS?=
 =?utf-8?B?WHUrZ3RYaW4yMXkyUm9kSTZieWlBeXEydDh4bEhlVElpd2hPeGlRNUVGRmdn?=
 =?utf-8?B?SjBzQmt1cFZ6NEx5aHhCMkdENFFTdXYwbEgzOHcrUUErQzIrRk9VenM4SnJK?=
 =?utf-8?B?Mm53WVptUDRaN1dxK3dYcUdEOFV1QklSQUhnQTlkeTRYWXNBeERMUU1JNjVk?=
 =?utf-8?B?V210V0VMM21HdGxMY1Foc1RvTkswZGNjNlFTU1VGZHBldXU1a013OC9uNGpK?=
 =?utf-8?B?MjNpMjMxblZvTHBjTE1meTdFY3E4MjhmcWxmOE91V3VydjhHMU9YWjgrbSs0?=
 =?utf-8?B?YW5RZWJLamVPZVM1MjIyR3FYQWNhZzNJM0E3MUFXcFVxVFNyWFpiRlhVR2J1?=
 =?utf-8?B?dVlGak5pd0k4RlRqeDFPYmZrUldRdytwSmgyZ2VqY2Zubk5hekYyZk90YXhH?=
 =?utf-8?B?eWJiL1JrWlBkWnBYRVYySEw4a1kxTFlGVVZsWFR5dHd1YnVOSk84c0xNazd2?=
 =?utf-8?B?V2h0L0pPQk9PM0ZCWlU2WjFCMHdxZjJLYlFoeERVK1ZVZWY5VFlieGdFTVdR?=
 =?utf-8?B?VmdPUzI1eExiWEdtT2IvT0JEaTJPREJtMGp1K09leG5lS09xREs0cWIrOGw5?=
 =?utf-8?B?QkkxbXQzczV2UFJWZGpibDYzc1A1aXVsMGVJNWI5VWJLMWhINDJmcmlSVjJG?=
 =?utf-8?B?WitUOUZSeEkvV2xpSUNIeVJraUo5ZWVMSkFOcEZIcU5USVRBbXdzTTNKMGor?=
 =?utf-8?B?Q3BVd3lvUFBVZ3kwVnlJWnFSbDgyTTRRWlJHZ01PVXg2SGxVWG1SdHFXSHpn?=
 =?utf-8?Q?albv/jQUunxsvzI0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec21fe66-4722-4e57-daeb-08de67ab804c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 07:19:02.2701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jv2ssuB3rsxqdMAHDrnyt1ySbXC/cEAimDRoO+id4Jau5vABN5nZc0M3gKfFBhfYo3A7NEgoP4JLYRymMknEyoel2kT4/t34G/o6lSzoSs5i8tMWzK3pUa1Az33iCNkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31651-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,suse.de:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 01DB010C61E
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGFrYXNoaSBJd2FpIDx0
aXdhaUBzdXNlLmRlPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxOCwgMjAyNSAyOjEzIFBN
DQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0
QGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBbUEFUQ0ggdjIgaXdsd2lmaS1uZXh0XSB3aWZpOiBpd2x3aWZpOiBBZGQgbWlzc2luZyBm
aXJtd2FyZSBpbmZvIGZvciBiei0NCj4gYjAtKiBtb2RlbHMNCj4gDQo+IFRoZSBtb2R1bGUgZmly
bXdhcmUgaW5mbyBpcyBtaXNzaW5nIGZvciBpd2x3aWZpLWJ6LWIwLSogbW9kZWxzLCB3aGljaCBy
ZXN1bHRzIGluDQo+IHRoZSBub24td29ya2luZyBXaUZpIG9uIHNvbWUgaW5zdGFsbGVycyBvciBp
bWFnZXMuDQo+IA0KPiBBZGQgdGhlIGVudHJpZXMgZm9yIGl3bHdpZmktYnotYjAtZm0tYzAsIGl3
bHdpZmktYnotYjAtZ2YtYTAgYW5kIGl3bHdpZmktYnotYjAtaHItDQo+IGIwLg0KPiANCj4gTGlu
azogaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTI1MjA4NA0KPiBT
aWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+DQo+IC0tLQ0KPiB2MTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvMjAyNTEwMTUxNDEzMDcuMjUzMDUtMS10aXdhaUBzdXNl
LmRlDQo+IHYxLT52MjogcmViYXNlZCwgYXBwbHkgdGhlIGNoYW5nZSB0byByZi1mbS5jDQo+IA0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvcmYtZm0uYyB8IDYgKysr
KysrDQoNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9yZi1mbS5jDQo+IGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvcmYtZm0uYw0KPiBpbmRleCBh
ZDI1MzZmNTMwODQuLmIwZThiNGFmNjg5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvcmYtZm0uYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9yZi1mbS5jDQo+IEBAIC04LDYgKzgsOSBAQA0KPiAgI2Rl
ZmluZSBJV0xfQlpfQV9GTV9CX0ZXX1BSRQkJIml3bHdpZmktYnotYTAtZm0tYjAiDQo+ICAjZGVm
aW5lIElXTF9CWl9BX0ZNX0NfRldfUFJFCQkiaXdsd2lmaS1iei1hMC1mbS1jMCINCj4gICNkZWZp
bmUgSVdMX0JaX0FfRk00X0JfRldfUFJFCQkiaXdsd2lmaS1iei1hMC1mbTQtYjAiDQoNCllvdSBj
YW4gYWN0dWFsbHkgcmVwbGFjZSB0aGUgYnotYjAgd2l0aCB0aGUgYnotYTAsIGFzIHRoZXkgYXJl
IG5vdCByZWxlYXNlZA0KDQo+ICsjZGVmaW5lIElXTF9CWl9CX0ZNX0NfRldfUFJFCQkiaXdsd2lm
aS1iei1iMC1mbS1jMCINCj4gKyNkZWZpbmUgSVdMX0JaX0JfR0ZfQV9GV19QUkUJCSJpd2x3aWZp
LWJ6LWIwLWdmLWEwIg0KDQpUaGlzIGJlbG9uZ3MgdG8gcmYtZ2YuYw0KDQo+ICsjZGVmaW5lIElX
TF9CWl9CX0hSX0JfRldfUFJFCQkiaXdsd2lmaS1iei1iMC1oci1iMCINCg0KVGhpcyBiZWxvbmdz
IHRvIHJmLWhyLmMNCg0KPiAgI2RlZmluZSBJV0xfR0xfQl9GTV9CX0ZXX1BSRQkJIml3bHdpZmkt
Z2wtYjAtZm0tYjAiDQo+ICAjZGVmaW5lIElXTF9HTF9DX0ZNX0NfRldfUFJFCQkiaXdsd2lmaS1n
bC1jMC1mbS1jMCINCj4gDQo+IEBAIC02MCw1ICs2Myw4IEBAIGNvbnN0IGNoYXIgaXdsX2JlNDAx
X25hbWVbXSA9ICJJbnRlbChSKSBXaS1GaSA3IEJFNDAxDQo+IDMyME1IeiI7ICBJV0xfQ09SRV9G
VyhJV0xfQlpfQV9GTV9CX0ZXX1BSRSwNCj4gSVdMX0JaX1VDT0RFX0NPUkVfTUFYKTsgIElXTF9D
T1JFX0ZXKElXTF9CWl9BX0ZNX0NfRldfUFJFLA0KPiBJV0xfQlpfVUNPREVfQ09SRV9NQVgpOyAg
SVdMX0NPUkVfRlcoSVdMX0JaX0FfRk00X0JfRldfUFJFLA0KPiBJV0xfQlpfVUNPREVfQ09SRV9N
QVgpOw0KPiArSVdMX0NPUkVfRlcoSVdMX0JaX0JfRk1fQ19GV19QUkUsIElXTF9CWl9VQ09ERV9D
T1JFX01BWCk7DQo+ICtJV0xfQ09SRV9GVyhJV0xfQlpfQl9HRl9BX0ZXX1BSRSwgSVdMX0JaX1VD
T0RFX0NPUkVfTUFYKTsNCj4gK0lXTF9DT1JFX0ZXKElXTF9CWl9CX0hSX0JfRldfUFJFLCBJV0xf
QlpfVUNPREVfQ09SRV9NQVgpOw0KPiAgSVdMX0NPUkVfRlcoSVdMX0dMX0JfRk1fQl9GV19QUkUs
IElXTF9CWl9VQ09ERV9DT1JFX01BWCk7DQo+IElXTF9DT1JFX0ZXKElXTF9HTF9DX0ZNX0NfRldf
UFJFLCBJV0xfQlpfVUNPREVfQ09SRV9NQVgpOw0KPiAtLQ0KPiAyLjUxLjENCg0K

