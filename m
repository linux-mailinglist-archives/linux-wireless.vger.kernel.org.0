Return-Path: <linux-wireless+bounces-31654-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJJDB8mTiWlj/AQAu9opvQ
	(envelope-from <linux-wireless+bounces-31654-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:59:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7215C10CADC
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 08:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D940B3005D2A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7B33987D;
	Mon,  9 Feb 2026 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUWP4enZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B934339843;
	Mon,  9 Feb 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623942; cv=fail; b=auhXFb3wwSyOQyjdtJjJGy2MnqfxIgsAKeGhReJtUSk0fhSn37kknBRmknurMVKCeEiyX/Ni14B4eKJTtmR3O+XgTX5ujMeW+67jTWADk79ygGW00odNbKVPOA1IeJPzFDAP5gbqcwR+oSbcy8b7Ttrix+z4zoAdgVvFLwNcIYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623942; c=relaxed/simple;
	bh=aGBqpkaBSryXKQgDbOvIy29DDZuZh0Uy3QVJkEo8PXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d3kC7vMPUfrkzvcUWE9uLygNpmg7FJtFDp6yu/i0RevVpRb/44dy9OwZP1mT2PVP4TNeVxsQU7HV2ed3y/ASwigjRi/TWmMYj+zjNupXB5N3WlrxyxZiFKGAsRT1IIUwqoHnjqYF5Ia9uza8pD9fN43sUxZUriPYpce3hDOaaJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUWP4enZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770623941; x=1802159941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aGBqpkaBSryXKQgDbOvIy29DDZuZh0Uy3QVJkEo8PXs=;
  b=UUWP4enZQgqsbD9tAiQNwXOIh6tqe84J1ONfVhDSVPiSE8BhP8LLXwQQ
   L41NyVB5to9hJGkosFhx/GnujiUpt+TLmWLkS03I4BOnUdTcssudkbcvs
   MCedWhpdextNAuE+xhWVmc8zPqFfup5oc6Pcrn8e+sKyfO3Eu43DEd1da
   154Wfnh1CoJXswyx5XMfB2mkVcqa3z1becdD1iZuOUJMoZAR6KOSEDx7a
   DtbIHCsVauFEWw3Z9XygIS8F+NHtfMSOrVyeiuXrQlZPlOWh5QY1oVaIe
   YMd++2lORGIcV4rbOzKW9fyPO2QWhP08W+mbPpd8FJoiXcx6myNmg3P5C
   Q==;
X-CSE-ConnectionGUID: 1i9budXITjyNKcSAG0rm+Q==
X-CSE-MsgGUID: HhmYYLWEQyGEkf6VRBOPjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="82056559"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="82056559"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:59:01 -0800
X-CSE-ConnectionGUID: hlrn11r7SdKTVyWOms2O/A==
X-CSE-MsgGUID: qFiT3hV0SSKGsLFcXUxIdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211325707"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:59:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:59:00 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 23:59:00 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:59:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJOzWbaln4DgYwzeLwCNTIOdXruB5hrGxzlcc5mz+nEecJ8+sCChy1PTQnOZCMwm6W015srZiCpGlPO8DBT3mShtJ29zuJw0VaeF+Tpan22EDIq7f9/2fuPT/f5SK2NyvDjUhwnI9ZERpvjzBON0wjy/QImw+Iyw4OxqXYHRjqumIHal3qApKTwPIDP71h4F10G0rT89Q3IUCU7r5Z/w8L9q13Qo6jlE2f5yQlO7EPh+6KRls9BfvPqdgWaTatDmOJf05lqagRpdeJ/fG8RG8WOrjiIB2qJSCbPtXfSfo6sVxEZ1BPzK5/RUsCRQnJvjK+7jnTFtdC/dQW1n5m8y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGBqpkaBSryXKQgDbOvIy29DDZuZh0Uy3QVJkEo8PXs=;
 b=HNMiS46OQlQ9YXJSMzDy7RG/f6h0JkafHlmPxb6hDnXpIZSxNdXmhNM+StBXjgWsUQj1x6RuIxLMf5E8YkSf1J7CJbKT/RZJCHHALzBtBESJ13Bgj695K9yVLu/3JCtoRhNt9M1jmlzxYHokw9sybqKjlG+0X9KXdV20yDruRyTlBx+ycrqrWUUCtVvIZXOtMv/jeNF9t61xwacC8z6EVDOuldHfZTh1WnmjjmcTGoR+RzZfOsG03bLVQ912lAnwlllqepmrLshanzNqetUc7PuJlkt0nGIoRTL4DLA+VtkZRPqYlkQZEtF2fnAhGWVIeKgYJ2BJB3O7ExgdEia7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CY8PR11MB6820.namprd11.prod.outlook.com
 (2603:10b6:930:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 07:58:58 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 07:58:57 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: RE: [PATCH v2 3/3] wifi: iwlwifi: nvm: replace use of system_wq with
 system_percpu_wq
Thread-Topic: [PATCH v2 3/3] wifi: iwlwifi: nvm: replace use of system_wq with
 system_percpu_wq
Thread-Index: AQHcWgW7F5VLRnEtP0CahgnrT9QNNrV6f5hA
Date: Mon, 9 Feb 2026 07:58:57 +0000
Message-ID: <DM3PPF63A6024A95377F0E6D202095C3349A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251120100850.66192-1-marco.crivellari@suse.com>
 <20251120100850.66192-4-marco.crivellari@suse.com>
In-Reply-To: <20251120100850.66192-4-marco.crivellari@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|CY8PR11MB6820:EE_
x-ms-office365-filtering-correlation-id: 7813997c-aadf-45d7-dc93-08de67b1142c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ekZ3NlhtWi9acU9lUEdTSkxmeGdLRHc3YkRwSEdHb2g0RjU0L2YraE9oTHZS?=
 =?utf-8?B?NlNHdmw2SHFNRk5YWmJ3RTl6TTlkQnN1VVkra1JrVEF5STZDR21pOUozeG9B?=
 =?utf-8?B?Vi83blR6MCsxb0xaSXFGMGVZRG5UTjVXenkyaDQyUkl4enFMVEZiVW45dFRi?=
 =?utf-8?B?NGNYNEVCYWVBWkRENi9RRjgrbkVycVZvaUZUY0ovYkZ0QnlFN2JCakk4Nlg2?=
 =?utf-8?B?SGJoNzh3bFhQTkNvSHRlRW5WTmdkRXJYNGVURHBQL2pGTGVDY1ovandFVVRF?=
 =?utf-8?B?MDRCdVVZVG1QcDROemhkZFJndlJSN09XVWY0Y0pPVytVbzZUVTdnTlRlS3oy?=
 =?utf-8?B?VHdLMy83bHdsUGM3ZEtmWHNvVTN5VkU4YWdpT09ES2FublMyazJTbXYrWURw?=
 =?utf-8?B?NmJNaW00T3MrQzV0WlVmdlpHYVhUTks0VGx0dmRXNkVlSDU4YXNld2JyS0E3?=
 =?utf-8?B?ZVNOUWhTQTBJamxMTGJSQldiZVN1NktWd3RYM3ZHWm16dWFPNWZGVUZQUzAv?=
 =?utf-8?B?dGhXcWtKOU82TkJONWYyOFRQbTBsWlpCR2lXd2o3d01kbjNyNVhxbUZhUTI0?=
 =?utf-8?B?Q3Q1OGJTRXJqMTdJdWNOUnVqU1VtWmw2cVhpYS9Pdjl5OGFtaS9lRm5XZ2RR?=
 =?utf-8?B?Y2hob3BNaXJLald4QzRMeVJrTFYyc2JmNHcyR29OOWhoN0p3MXUyem9ibkky?=
 =?utf-8?B?SS9SSHZpVUltZm1JUkRDcThJZFlPMEgwUXcvV3J0YmtkOUVNUVJJKzQ5Rkhx?=
 =?utf-8?B?eXpSeTNSU0RhMUpZTHNpUFhINmpwaXNqQzV5Ny8rVWFwQUw1SjM3dkd2dHVM?=
 =?utf-8?B?ZXN6T0NWWEpzcXJMZ3UrNWh3Sm85Z1RIaFpaOE1VS3ZCN29rZE9sc2pCMFUr?=
 =?utf-8?B?SUV6dlV6Tm9WbGgxVmFSaHFFckNTQndVbmp6MnhzNnhQajZ5NURLcndJdlU1?=
 =?utf-8?B?Tzl2bDdNY1VaRWEreTVRRXg4U3hhRG1tV3JoeFJORHJMRGErUHE4dWhRWFZJ?=
 =?utf-8?B?akQxQ3RaSWc4UkFYRzJuNEdWaXFtbkRRVnZQWFUxQ1pPM3NjNmVJYUY2ckIr?=
 =?utf-8?B?Z2RRMHAyamVEellndmNqTCs3Y1BLRm5ZMXdwNzAzU01ZanBlOGR4aG9BM3pL?=
 =?utf-8?B?RUNTRUdRTUZlc3Z3Ync4MWQ2WWJWcjV1MGsyeXhxYUQ1QzJqNU1sT0RsWXVa?=
 =?utf-8?B?UzJLRVY4YWoyWFJOaVNPMWlKUjFzdVlIdktQQXhTNTNVRU9ScHhHQTc5a0lM?=
 =?utf-8?B?dVAvTUc5QjBUb1p2SFhDQzUxekI3YzFHQy9uWW9hc3FEMTFmYU9IRXU3bUdE?=
 =?utf-8?B?eFlQRU5JZHVhRm4wUktNU0tsRkl6SENvUXVFVEtHNTNaNktLSmQvb29YZUhv?=
 =?utf-8?B?Y1dOQkUwZUV2WWpnU3hVTWpJcWc3RjNFSHhIeUxZMG1BNzY0em1oVG1UTmJN?=
 =?utf-8?B?dzkxQVZDYWg2TDQ1M1haOGQyM3NOMjNVQ1hjdGpiS2htQnR3NFdmZFNEMU5Q?=
 =?utf-8?B?WGV4WlJsUkNacklMZXRSOFpwZ1E4M1NnQThVYnhPQTRBWTBldUY3K29ETjB5?=
 =?utf-8?B?ZlNaMXlQQnlBc1NhYVlXWmFDWlVQQ0NXY3ZxRXl4OWJxTEk2ZkkrcWdiZk5o?=
 =?utf-8?B?Q3dLNVVJeVFoTmczU25XT0JyTTJ0bGZqTGpCeWRoWStCUEVPTVNVZE5LdFRz?=
 =?utf-8?B?OThBQVNTNDZ5MEhtYm5rVnl0UUZDWkNDeGNQdG96c25SVGswQkdXdzE5TjZM?=
 =?utf-8?B?MGJJNmRFWkVoVkNVNlhHcTVGWVNiZlBFa2ZiM0pyRGllRENxeVFQTEd3WEJo?=
 =?utf-8?B?Y0dDQXdCMFhEYXJLWU1KdVlKcWo0TUJXSFB6dlhKbHF0K0Evb3JaNm00eVVt?=
 =?utf-8?B?eStFdlhkcXRsZW5ud3hVWE1tSCs0c09leVBzV3oxblNMMFAzQmZkSm00bFpz?=
 =?utf-8?B?aHhSU3BXK1NLblpGSHZ6TWdBYzIwMGNGbkFGNmdnYTlxVnNmbGtYMGxHd2R5?=
 =?utf-8?B?MUs4UjhxazZhR0ZJT1VtbFBaa3ZRdmlLSERHODZXc3h1cXRoc2RQeDFlSVlh?=
 =?utf-8?B?MU1GSFY0OXZqVWVMeG13VWM4YjBlb2ZjaUNNcStWYk0zZDB4UEdNSTRMRHg0?=
 =?utf-8?B?SDdSYVBDZEx3NkNQVVdQUWdGNkhNNnRSZWx3MStqdXE0WTV1QUIremtMNkRK?=
 =?utf-8?Q?tma+s/WaWNLQGVUGQF7t3Ic=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eitSOVRJUDBjbEEwbzZiTjBkeEJVQ1dtazhVb2tHbDBEeDU0WHdOV294M2Fq?=
 =?utf-8?B?VkN3eDNyY0p4RVdlZWkrOG1aNVU2Q1owRGg4ZVZQN2szZWR6Z2NNeTZxMHIv?=
 =?utf-8?B?N0ZBbXRuM09CeEtvTlBVNkNMOHhqTXJ5U3p5TXNqTzYwWXZYYnlUR1Fjc0tj?=
 =?utf-8?B?VVdoNUM1T1ppdG1uQ0dVVEhXZ25MNDNZRzlvTDlVOVRERUJHaCthM2R3aklv?=
 =?utf-8?B?bmVSMDJaSktKbEg2SEhTaFhzemNwU2MycElDQUQ2dytHOEtnTjNEUng2U01t?=
 =?utf-8?B?OUhzTWF0K3dwd1RoTFkvVkZSYi9oVEx2ZmZIdzlHbjU0aWprUEtsS0tKRGZO?=
 =?utf-8?B?Z2xWQm1lRytqZzE0WVVxV0VQRnV2WWE5QlY2aDBLam1JSkx6aFZxTzVkamEy?=
 =?utf-8?B?bTV4QmxpSm4yaGVCRFZ4U2pScWJZMkdIK3l6cFYvNlhGMWcvY2paQW1JdFNJ?=
 =?utf-8?B?b0orTmNkQ2IwdTJ6R0RCOEJCcytjUWw1T05wRHUrbU4wQzU0ZjhSTElrQWkz?=
 =?utf-8?B?QVNBQjN2YWFZVHQ3L3ZqUEI3bXRxaElMKzVvNVJvZ1pDTXl5Z2RoblZmdkNn?=
 =?utf-8?B?MkI1aGc0WWRqMWZxR0pMVW1xU1RhSzJESHVZaHhNdkF5bitKWGloMmJWV0NJ?=
 =?utf-8?B?LzA3QSt5R3k5S2ppSkozTytjUFoxakQwbTBNcys3bTRHMDlxc3hEQUdYeUJW?=
 =?utf-8?B?dEU1TDdxUm9lSURKNm52czZNMXowbDJZWTJHUjJWeEVicXlUNFJVbm5tdHg3?=
 =?utf-8?B?eVlyNWZpandsNFM0QlhOM3h4N28zTnZ2TWIxMEJmbEdMR2JvWVRjVk4rU0RF?=
 =?utf-8?B?WGVCbzdUNVNvUVIzbENNWGY3NklzdTlJWUx2SVByOFBRTk9FRTUwVC9NY2hr?=
 =?utf-8?B?Sk5CR1VPYzloV29xdG0xbFBCdHZQYVd4RHlZb3g3b3RLMlZEZGhNUThwdlZO?=
 =?utf-8?B?S2ZJWE5nWGpiS1kxa245bHI0TEV6c0VLQ25ERVlVN3BvT2F6d20va2I5VzBK?=
 =?utf-8?B?bDBiaUtUaGJjQTMyV0hiL2t1NGpTeTQ2bWlLeXNSaXY1Y2lTdFNmUk1MT0Vy?=
 =?utf-8?B?eWJ5QUg0cWpYWEQxMlBNOGZQRVJlRXMwbmVJenJIWmlCa1JkUDZSd3NZOUJE?=
 =?utf-8?B?ZE1HZ3I5WkxFdDdoNEJuWVI2SmxsWndiUTY5UHB1K3hWdW1qclNnSWFKbEFV?=
 =?utf-8?B?R25UMXRLNU40TVVINzNmNFVyaEZ5R3ZwR29ZeFdDV0Y4Y2Jsc3gwYzBCTTZ5?=
 =?utf-8?B?Zm9malpmSkwzVUJVRlZsS2IrL1hva2F4dVBqTkxDNEZLS2NXaVFsZEt5bmQr?=
 =?utf-8?B?aytrRHg5OVlOK0F5YWVXYkRCamt2aFY0MS9WVksxUlI5ZGRnbURwVkl6aW1n?=
 =?utf-8?B?Q2JWQURRYk9UaDNHTThIaXNBTVkrS2tYVE05SkdjK1JOZzFlaFFWUmZLNzdG?=
 =?utf-8?B?d1gxNnVjaXppYUF5MEFvKzRSS2hBaTA0cjQxSGJMQWluaml5UDNIbk4yOG8z?=
 =?utf-8?B?aTc1RjVDcFRJTUh1MkltbGRTcmZTeXRRUG9VNzhHUGZBZmdXdnVVVlYxSDJj?=
 =?utf-8?B?VDhNUzA1K29RQXZuSXgxVDAvTU1aZVh0NFVydmJNS0ROeVNzVzhsc3NXSlRO?=
 =?utf-8?B?YmtuaUt2YWRwK09JdktUcmdiMmJhYTBrTUlxNitjeXhxMHlCWklRM092MG5O?=
 =?utf-8?B?OEFMRXdFTVVvYnpKUnQrdElqbEg0UXRObm10Y0xyVFB3YnhXZ2xwS1g3bUZK?=
 =?utf-8?B?RkYvYlpvTXkzbDBBS2JjZllVV2J0UkhCbUxWdk9SYVNjSE9URmtXSmNFU09u?=
 =?utf-8?B?c0JsL2c5Szdjak9wSUFsbkcvWGpuYi9LTjdFV25FVU9BSmU1aHlWRE9NN0NT?=
 =?utf-8?B?cWxlTTNmWlVJU1FQSFRsazRFcUFFWVZyUmQvdkwzdDJQd3B1WXJ4ZE81dG9t?=
 =?utf-8?B?SHFqS1ZkbFhYTkprVFBzNnlyMlNHRGVSaGxleDRrQTFnd1NET2p4KzB4N2Vu?=
 =?utf-8?B?RW9kZ3BhNUgwMlF4VVAxMk1obEREcjl1OGFCc3BFaHRNMkhGS2RzSTRXRnJl?=
 =?utf-8?B?TmxINnEyRTUrSGw3dmJYbWIzcFRTbGJyT2M1TEFNdS95dEdVYVFDZFMyK25K?=
 =?utf-8?B?cFRYRmdIVWIwUkc4ek5aQXZXWTRLVDJVTysyaXl5ZXBUMlZ4VE5qUTJKcTVD?=
 =?utf-8?B?WlpkOTZxdjVuSlRhSE1MbTNCNFhrcWt1dHp5TUdVaE9OVnRQZjR0ZjJkbDRT?=
 =?utf-8?B?VDdHQ0V1RzZBK2FIeEFmSmFHcnhkNW96NjJ4MTVzL3BVTkJSNTZTMUNwVjk2?=
 =?utf-8?B?OWVONGo4VDBpYlV5K3F6bXpudkdPZjNaanU2N3JsaGM4S2xHd3IvVzcxUmN0?=
 =?utf-8?Q?VGqfAh6HqsPVCc5I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7813997c-aadf-45d7-dc93-08de67b1142c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 07:58:57.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJ0kRptZRSJ7SENgwMErhGyBMyeFwsMXGDwo47eh304K0f+x+V9/fXShWKQuIA6QusYr3NyGuW8Prz/fewavAUBBLZY7Vv3JbhuQfcRh/rnWJomzff+MZq76c9QcSo5U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31654-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,suse.com:email,sipsolutions.net:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7215C10CADC
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY28gQ3JpdmVsbGFy
aSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVy
IDIwLCAyMDI1IDEyOjA5IFBNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVs
Lm9yZz47IExhaSBKaWFuZ3NoYW4gPGppYW5nc2hhbmxhaUBnbWFpbC5jb20+OyBGcmVkZXJpYw0K
PiBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvcg0KPiA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgTWFyY28gQ3JpdmVsbGFyaSA8bWFyY28u
Y3JpdmVsbGFyaUBzdXNlLmNvbT47IE1pY2hhbA0KPiBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPjsg
S29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsDQo+IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRl
bC5jb20+OyBKb2hhbm5lcyBCZXJnDQo+IDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjIgMy8zXSB3aWZpOiBpd2x3aWZpOiBudm06IHJlcGxhY2UgdXNlIG9m
IHN5c3RlbV93cSB3aXRoDQoNClBsZWFzZSBjaGFuZ2UgbnZtLT5tdm0uDQpPdGhlcndpc2UgbG9v
a3MgZ29vZCB0byBtZQ0KPiBzeXN0ZW1fcGVyY3B1X3dxDQo+IA0KPiBUaGlzIHBhdGNoIGNvbnRp
bnVlcyB0aGUgZWZmb3J0IHRvIHJlZmFjdG9yIHdvcmtxdWV1ZSBBUElzLCB3aGljaCBoYXMgYmVn
dW4gd2l0aA0KPiB0aGUgY2hhbmdlcyBpbnRyb2R1Y2luZyBuZXcgd29ya3F1ZXVlcyBhbmQgYSBu
ZXcgYWxsb2Nfd29ya3F1ZXVlIGZsYWc6DQo+IA0KPiAgICBjb21taXQgMTI4ZWE5ZjZjY2ZiICgi
d29ya3F1ZXVlOiBBZGQgc3lzdGVtX3BlcmNwdV93cSBhbmQNCj4gc3lzdGVtX2RmbF93cSIpDQo+
ICAgIGNvbW1pdCA5MzBjMmVhNTY2YWYgKCJ3b3JrcXVldWU6IEFkZCBuZXcgV1FfUEVSQ1BVIGZs
YWciKQ0KPiANCj4gVGhlIHBvaW50IG9mIHRoZSByZWZhY3RvcmluZyBpcyB0byBldmVudHVhbGx5
IGFsdGVyIHRoZSBkZWZhdWx0IGJlaGF2aW9yIG9mDQo+IHdvcmtxdWV1ZXMgdG8gYmVjb21lIHVu
Ym91bmQgYnkgZGVmYXVsdCBzbyB0aGF0IHRoZWlyIHdvcmtsb2FkIHBsYWNlbWVudCBpcw0KPiBv
cHRpbWl6ZWQgYnkgdGhlIHNjaGVkdWxlci4NCj4gDQo+IEJlZm9yZSB0aGF0IHRvIGhhcHBlbiBh
ZnRlciBhIGNhcmVmdWwgcmV2aWV3IGFuZCBjb252ZXJzaW9uIG9mIGVhY2ggaW5kaXZpZHVhbA0K
PiBjYXNlLCB3b3JrcXVldWUgdXNlcnMgbXVzdCBiZSBjb252ZXJ0ZWQgdG8gdGhlIGJldHRlciBu
YW1lZCBuZXcgd29ya3F1ZXVlcw0KPiB3aXRoIG5vIGludGVuZGVkIGJlaGF2aW91ciBjaGFuZ2Vz
Og0KPiANCj4gICAgc3lzdGVtX3dxIC0+IHN5c3RlbV9wZXJjcHVfd3ENCj4gICAgc3lzdGVtX3Vu
Ym91bmRfd3EgLT4gc3lzdGVtX2RmbF93cQ0KPiANCj4gVGhpcyB3YXkgdGhlIG9sZCBvYnNvbGV0
ZSB3b3JrcXVldWVzIChzeXN0ZW1fd3EsIHN5c3RlbV91bmJvdW5kX3dxKSBjYW4gYmUNCj4gcmVt
b3ZlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8gPHRqQGtl
cm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNyaXZl
bGxhcmlAc3VzZS5jb20+DQo+IC0tLQ0KPiAyLjUxLjENCg0K

