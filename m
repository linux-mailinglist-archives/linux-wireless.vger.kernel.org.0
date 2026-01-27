Return-Path: <linux-wireless+bounces-31201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IuWJLBHeGnRpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 06:05:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B28FF36
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 06:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD4FC300DF45
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 05:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C51328605;
	Tue, 27 Jan 2026 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDvKB4xZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51057328610;
	Tue, 27 Jan 2026 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769490338; cv=fail; b=GL3EgfJvATX79yd8cqrSJXIFp+B/BJFL1zNrnnOrw3aFHLcvUAOHj+QKnrC6/5F+JSA3EX8UwFHf9GK0KqtVwl/YPIiQZ7Wyju8MWIrydmNumkBxaCVFJrLCTrAxlRwHThQfYcA6mvFI90rHKAeuOPwJxZqVPwdsUSq/0GAmksA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769490338; c=relaxed/simple;
	bh=TmE6G1qUDhbU/AvpcTpqq/kSU4B8Q09t+J44ILtf2Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YH3meVz3z2uziMqEchTMRl8mv60MjbOn86CS+X121+IVFCMDCVC4GJBPNRPVmtRfn6NpKqH5P8NNvu6E8Gjfreg3AH+iCZOrFK3eHVViqupyI9YqxlWYYqBm4+b+7GdrfY876os7cv6tTHPon1C+Y/zuJC2Pq1rktVXn3FlHpf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDvKB4xZ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769490337; x=1801026337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=TmE6G1qUDhbU/AvpcTpqq/kSU4B8Q09t+J44ILtf2Dg=;
  b=gDvKB4xZmyk2D1V+RQvsbS1gSBEr0TWuk2Utvhw20EBSdhJmHljUDgWP
   Zrz82DSS0gKrFaVmM2Bwi5sCkYsH4pUW0GV8VxxEE46VH1NxEpB8QnDxl
   dpNKqPBXqamg/IrtXVHaz1abqbS6Ewo2T/97xYPDW3b6+OQqeufX4w+XU
   FdaalDwvRF+9IXEAJ6BUuZhI7zUDikQfyqZSU+SThEM0HJswq1iDDijdZ
   qIQu7GtUyTI1+nyuFER+JmOTvKBF3VD5uH6fJ4PrbJoUgEZyHPDbwGiJR
   /DH+rurzQ2PSBdDk4wQ3toV/WXZ795q2WffF8aRZkRefihFPK3C33y+tq
   g==;
X-CSE-ConnectionGUID: Hk5E4fSMRtm0zCL837pk2g==
X-CSE-MsgGUID: gJ+bpsUrQSK59jS9L74zaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70647791"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208,223";a="70647791"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 21:05:36 -0800
X-CSE-ConnectionGUID: BFYtpMGFT6iaiwcstCSsfg==
X-CSE-MsgGUID: RJffxuBmRD6Ma+ut3rCH3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208,223";a="208233499"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 21:05:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 21:05:35 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 21:05:35 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 21:05:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jewAhdgXZfw735kQm7qdnzF9J0jiLVzrIWCfnjLqGV+sfYKKTGTb+LBH//9VI2MXav2rIsdbrfJylribbUHAyizCLPg+pZGM7qKJPKzmi0vU7vyWyydJDKZqdNFtEPLcD9tbEt9aYvnA2GH/SAZvvl1ZRmvK4gKY5FaLTlmMHZQncntTqhNJtjoDS7Xni04aO4LZuh5NswjWBXo9fi7JQ3AsLQwdUKo6+Qgw3KbWcrHlIM2h17CDrIMZo/2e/ElulM9QzkL2Zgeeklo2V5II6tXoor1UccE50oQD2HwZrY45w4YWrECZdnaaxaBIaxhbDAfVEJcZiieQjrqOMx17hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhi77jCVCrj3RL2gAS5cMCdkXYScF4r9pDrljnDmi3g=;
 b=cpdBSryPsYNFU9Uq+hyLxcGklxLPuQ22oIzu/Rw1ZXirukNHk1Qc3HDSjKl3eSWNmwf/xFxkuCk9/SuIBwv0nfAtwfC8ZFzAakEHHt14HY1ePHd7z7lDfLHGrMROeW5wlxqjVQ3+3Tavgr4IxRbhEs6JGe0pq3rr9hnMoltCh92+CBFPnQNL7byvEP+wrGzm+0bluadxoCiavLvtHuz4UfV6YFdMfP64CJNKCFHpHc1t/ZDH4Mu0kg3MIgtFBVSD3KBigL2nd1/0lQP2D07MJ7yH/wF/Xnr7fLGvwO+le58rv6WK7WS9gQFozzKh+DkXG6KG+SNnavGGK9ePXUV92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA1PR11MB8099.namprd11.prod.outlook.com
 (2603:10b6:208:448::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 05:05:32 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 05:05:31 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Index: AQHcjlMSDsDNaO3QzkSRZaUB0ZOqB7VkClEAgAAYLQCAAFS+8IAAi5yAgAB00nA=
Date: Tue, 27 Jan 2026 05:05:31 +0000
Message-ID: <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
 <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
In-Reply-To: <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA1PR11MB8099:EE_
x-ms-office365-filtering-correlation-id: 3aa46f17-dd23-4c31-90ad-08de5d61b243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?K3d3dndpb3c1bWFPNjByV1R4dlYxbnZiOHVEZ2g2RWZpN29Zc2VlQ3k5VHpu?=
 =?utf-8?B?TWppU2o3ME5OTlQyeEtMSkt3ZlRpSnpkQW1BVWFQZ0VEOERIVG1LOWtoYXJH?=
 =?utf-8?B?TitXNkVNT3J1c3VRbC9DWG9MczcreWFNMTJNMnJaN1dMTFhDb2ExaUs4cFd1?=
 =?utf-8?B?MnArZUlXNHU4czVxekZVanpxcTB6OHJib25PekVGejhRTGNsdWR6Q2FaQXlJ?=
 =?utf-8?B?aDZNdWlGRDNlK2FHbUZJVFdjYWZ3S0Z0NkxZblNrVVFMUEU2Q3VKNytBSnZu?=
 =?utf-8?B?S2Q5Q1U4UWNDSkpPaG5SRlU3Y3d4aEx4MlZpNlk4TnVyOGVxSlJwb1lJYk4y?=
 =?utf-8?B?cTJBMjZKS0t3UmFWcWtUb2FzWndZS2lMV3BVNjJjZ3FIWUorZFpsSkh6eXRw?=
 =?utf-8?B?TEswdmtOZnIra3ZnWkxVRzYwbEJkQjR6S2d0NHNjTU1SYjV5NlFXSFBmNDJq?=
 =?utf-8?B?WGRTbGRqeGdUWUNKSGJQVWY1a1JEZzl6YXBYdktnbVExNkowNHRHNTRLZ3dO?=
 =?utf-8?B?bmprc2FCeWw4L3VCMDZEenJHczF2MXNPeWc2djhHL0JTNUdIWUl3dkNIdnRv?=
 =?utf-8?B?KzJldkptWStER2tSWVRhRWJkdEZIVVIrY2JISUJTNEJKeU42aGFmcUVFZC9z?=
 =?utf-8?B?VmZWZnA3T1BDTlNaaDFhZUtFQlhPOFhualNsaGdndWVCQXFFMG8wdUZIaEFB?=
 =?utf-8?B?TlZRRFJ0UUFmWWppajFkM2NyQWFZWkh4ZXBseDdObXlQTEo2amhQelZDMVho?=
 =?utf-8?B?R2RhTjl3TXZJdFRzVWZ1WEs1bVNOVXlXVGg4SElVV0FMVUtkV1c2aVYvYXRx?=
 =?utf-8?B?ZXh1NHpBSFNIdmVJYnFtVHB1eUlKa1lYVlBNdTd6M29Ma0g1LzRLTTJtbVh5?=
 =?utf-8?B?bWR0TkJiTUFBWFp1czJHRmp4Y0kyOC9mNGNmSFpLeVZoSkRoWjFhRVRHOVkr?=
 =?utf-8?B?TGVPaUFyRFl5YXZxc3l0V05qSjhoMDhZVmhodXUyT1MwWXd0a1Y5T2trcUNQ?=
 =?utf-8?B?ZjI1cDdtQytSM1owM014Z044aFpyTkFraE8zQnR5RkszVGlWZ2kyZ25uTHNj?=
 =?utf-8?B?V0pkaVF4MUgzVWVTaHlNck9tRFRDUTBMS2F6V3dackhzczZRMG5yaXB3YVpH?=
 =?utf-8?B?R29OTUIxQ01ZbzhseHZDeis5Q0c4RnVSWi96YURibXRNK2lwYXp1Z2Njd0Yy?=
 =?utf-8?B?TmVkdml6ZFpmK0dYTHhZS2VIZjF1VXg3b0p2UkZjWVZBZjAyMGlBSTdFZlBM?=
 =?utf-8?B?c1g0UkNYdXBtUU0vNm9rYVluYVcwSVNjWnRLRzRyNTVLVGxpemZvOTFMdU9M?=
 =?utf-8?B?clB3T1hObnlWUVdhYnMvSHJSc1FpbUlxQ0FtaGRydGgrTU5McW9tQVVMWGlW?=
 =?utf-8?B?eEpTZmZoYlBDTkVTbnlialBoazJuVzFKcWVtNFpQQjhrNENMemt1eURDb1hH?=
 =?utf-8?B?ZUZreTVpOUZqMGRkdlk1T1B2dkxRU3l6V1VuYjQ5UGwzMUFxYVBSZTcxZVJr?=
 =?utf-8?B?K0tuTVhPRWVKS3A0UWRiQ2RBTVRTTXBWTlc1UHp6dGNQdWxwLzh2ckJXQ2Vt?=
 =?utf-8?B?OHpYbXoyREVGcG5IcXR1TUM2SHQzWnczYk9IZlNRQ01GQzVTR1h6NGZFWUNF?=
 =?utf-8?B?YndnNGZrZkZGNFhkVU5hUmxkd1I0NDFzakhZQkU3R0QzL3hPQUNOQjlYMTBl?=
 =?utf-8?B?b1B2UUR4WG94MWxxeGRsNndOTlFZdkdsZ3NBSk1WcGNsVGh2NnM3NnFPNDNM?=
 =?utf-8?B?d2ZIZU1ZMDBFbStIb1B6QmhTeU5oekRGVW0yK2ZzNm1uUlhlbER5aEc5YTdF?=
 =?utf-8?B?QnVxRDFFNm53ZEx3WFJ3bmZtNitXZ2RkNmFHbklsbkxwdUcyN2xuamE0YXdw?=
 =?utf-8?B?SWlDS1hpTEhOTUdVdWl6YmMyc0hJNllwdFZZcnA4TW80MnBkalhDYThPSUdo?=
 =?utf-8?B?endTckpOaEg1MnZ3T0RnK052a1p3QlhudnplWFNvWUdobFd2aVpWMGxnaEVI?=
 =?utf-8?B?ZFEvYzgrS2V4Rmh1MGNsQjQ3Ym5FKzYwSU1ldUsrcnZJeHVYd0E1WHNWQ0tQ?=
 =?utf-8?B?TmFoa2htWDlrbUVvWWFMMC9GbExsUmZha3VnQ2ZLZ0J4aVk1Snl3a1RINHdX?=
 =?utf-8?B?NFU0T25kTFpsREhZLzc3S3R4TXA2b3d5SWhPZGNlZjdkQng4WE1nS1VkVWgw?=
 =?utf-8?Q?vJ4n94lrj3cRirxPB/PoIPQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVVSaVlCOGtsajN2UDRaSWwzdzBrZEljc2ttMlRjZllUQUtHS1R5MzBheWJx?=
 =?utf-8?B?dHBzaC9pVmJrekNqSXdUYXRmK3N5VlYzSEV0eHVYYm4xZ3QvcnA1RWN0NnBr?=
 =?utf-8?B?b0MyV0lYcWZLd1I2Z0w0VWxDeExNN3ZiNFpraEhYQU1OenVOd2RGbWRIQksz?=
 =?utf-8?B?SXhvakJ6WVVKL0ViUDJlYzRKRklFSFc0UVo4MXUxZzIwak5XZ0F1Zml2SnIw?=
 =?utf-8?B?d0g0WURnUUxiU1MvU2dsdXlLRGg5S0lHTzd2TTZwdFg0TG53RHovSVlWS0U3?=
 =?utf-8?B?My9kREdEUm5FYUJ6cVM0R0MvaW4yV0o0ai9kYzBqeUJVL1RNRzFzWTFjMXo3?=
 =?utf-8?B?bWg1NTVoTEhURGxsVitiaG55NmI0TFZsVDFmaE1pTFVxNG1Mc3JqRlBHNStC?=
 =?utf-8?B?MzhSZFRRVVh3VWdySE1GeDRORVdLNG9UT1BJS1NwRlBmTUJpM0o4VURaMXJv?=
 =?utf-8?B?RlhyeDMwSlQ5dGlQeEVNc3AzLy9ZMmJQK0Z1M3lYK1RHRVB6a1NnYnFidmQ5?=
 =?utf-8?B?Wk03OGRlK0dZZndka29XNXF3bkhnNTRTZ1hsWCtqKzdpaU9wenRmbXJlV1Ix?=
 =?utf-8?B?UW9kRjNLN3kvSkpCNTRmM21oanY0VDlrK1g4YldVTUtZditVVjUwSHJlbUND?=
 =?utf-8?B?ZEdvT1Q2d3lmV0pidFBnTWk1VDhvMjNNazZYUy9oZnZvb0RVVm9sVHRiWmJ0?=
 =?utf-8?B?U25zZ254eGwyVk5tU096a0Z4SUk4MkJtV1JDRmhpWDFDcnQ0L29oL2hFMFNh?=
 =?utf-8?B?Q29Sc0JOREdTTGZ0WnVMUTBmUGJUWXpKdWRnemJhVnpwejhVSU04dkFxMnJR?=
 =?utf-8?B?WnltcDNTNjR3THNKanZBVVRtZjhJOXF3NEU2Y1ZBaDFFREhJTzhmOUlQaWFW?=
 =?utf-8?B?eE8yUi90NFp1ZUZpbEZ1cVUyUFlkcUV6QVZreXY5NG1HUm1iZndINWRPZmdY?=
 =?utf-8?B?TSthY0ljMWhuMkRzRy9MUXgrRFo4cHNlekI2bnM1ckFVWXdTbXlxRmgrUzF0?=
 =?utf-8?B?N3JlaVZYY0dyWXAxY0RpcnJPUG5VNTdIbCtySWl4bjZWNmljK0dkOWJDQTZT?=
 =?utf-8?B?Z3NLUHJwVDQzYmVHYWNIeHd4U1FzdGRvampCY3EzQ2FPa29BRlFJT2lsVWJW?=
 =?utf-8?B?ejRHV0puUi9WWldpbjNSV3dEeHRoZXpxNEl5ckhuVjBWT0gyM3l0djgvY2I4?=
 =?utf-8?B?Tk9IMGl4NHRna2MxUmhOL0dyV2ZTR1Nja3lPVGtuY0J6SnpKVHliSHM0bkF5?=
 =?utf-8?B?MDhoMjc2VlVONThFMVFtTzZST3N3eTNhcUlxZVFUQ1hyTzRkZWpRMVRGdGxC?=
 =?utf-8?B?SkY3ZXRoOElYUy92S2JDZUFkTXhvb1k3NlJHeVNwUEpvTThwU0N6KzBtWTZi?=
 =?utf-8?B?aUpmUXRkQzhScVBxYWdGeDV0OFFKZ29jY1RPajhmdUJXZWV0TndFL3ZsTzJU?=
 =?utf-8?B?UU5SYStlYkw3MzdMV3VlbTlEZFVyR0tQTEl3RHdKcGVNZElKZUYrcmw3enYv?=
 =?utf-8?B?cDdjVmxndWVTMlM4alZIRUV1S01LWFBXUmxnbVZmLzRyUDc0b1p6cDRwUWta?=
 =?utf-8?B?UFp5dUwwbGpGMzR5WHVlMWtWcTlEaXpxL2NVMTd3Z0hjamJQdEFpSGhpUmRv?=
 =?utf-8?B?SFZiblg2UEdpckpMdmMwNVIybGYrZmdsODZhdHB6ZmNGbDVMN3R0Ym9OZUhY?=
 =?utf-8?B?eE1xWC9ZZE9tbEI3anlFdTF5T0lXMzFrZ2lHZ3lQZk03cnpyQWFsa3JpUVJD?=
 =?utf-8?B?K3RxamduTUhQYzdRNGpseEM3em1yZ013ZmNlaHdZVjNlRlgydnF1cHp5c3Zk?=
 =?utf-8?B?Y3NZdzV6czZTNC90Y0pDT2s4dEZqUzQxYVZhbjZidGNuZUlhZFFQbW1kVnBS?=
 =?utf-8?B?NG0yN250RS9RN2xwTVhGZTJZTThlZ3pRUHVMUkw4QVRRZlB3d1Rwd3JCVXc5?=
 =?utf-8?B?Mzc2SFZpRXI5MmY0cjNVWVFwMWw5dmNIZm4rcGVIODJnNEw1T0tFQ1FneVda?=
 =?utf-8?B?SWh2UnBvSDBKK0dpZkpEViswODZRemhRR09IMUlMUHpGZHM0eWNkTFFoeXN2?=
 =?utf-8?B?TERTemlLWE5RUTN2QlZvVWxwS3lMdVBNYW1SSnorNC96M0pwQ0Y1RWJ4YkNI?=
 =?utf-8?B?RlhtYkNjUlZQQnpMUzZSUnllcGRyaVhkWkd3UU1ndklMNkE0SVlTNXpwYTUz?=
 =?utf-8?B?T0JmVXExbjNxOW9UZ2VSYnN1R2RDdTE1OC9CSW1odnJ5azRHdEZiZ0NWT1E5?=
 =?utf-8?B?NVpGem9Id3RhNUhFUnQ0TkRnekZySGUyVlc4anUzS2F6RFp4RE4xU1VBOFhK?=
 =?utf-8?B?aXpNUE9WNDdNblpobW81Tm82WXA3TTdkcnd2M1Y2Mkx2RmViTFJ1Z2dPQWlU?=
 =?utf-8?Q?tGFYR/+fT6X4wUZs=3D?=
Content-Type: multipart/mixed;
	boundary="_002_DM3PPF63A6024A9FCE1CF29C0492A406E7AA390ADM3PPF63A6024A9_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa46f17-dd23-4c31-90ad-08de5d61b243
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 05:05:31.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3c+cmwLeMPnMWg6m/PcPRIzPWFxtTiojYYD/vL9X6rdXd7M7m4dPLRfiyH+TPIJRO2bTW5eQxwMob7+0Y7Na4fafQ/g0ymQOcC5kpE4Or6fJath8/N/dczSEI7hf4wE0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8099
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31201-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 984B28FF36
X-Rspamd-Action: no action

--_002_DM3PPF63A6024A9FCE1CF29C0492A406E7AA390ADM3PPF63A6024A9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQmFpbmJyaWRn
ZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkg
MjcsIDIwMjYgMTI6MDUgQU0NCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFt
LnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiBDYzoga3ZhbG9Aa2VybmVsLm9yZzsgQmVy
ZywgSm9oYW5uZXMgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPjsNCj4gYmVuamFtaW5Ac2lwc29s
dXRpb25zLm5ldDsgZ3VzdGF2b2Fyc0BrZXJuZWwub3JnOyBsaW51eC1pbnRlbC13aWZpQGludGVs
LmNvbTsNCj4gbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgIndpZmk6IGl3bHdpZmk6IHRy
YW5zOiByZW1vdmUgU1RBVFVTX1NVU1BFTkRFRCINCj4gDQo+IE9uIE1vbiwgMjYgSmFuIDIwMjYg
YXQgMTM6NDUsIEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0KPiA8bWlyaWFtLnJhY2hlbC5rb3Jl
bmJsaXRAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBDaHJpcyBCYWluYnJpZGdlIDxjaHJpcy5iYWlu
YnJpZGdlQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyNiwgMjAyNiAx
MDo0MiBBTQ0KPiA+ID4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hl
bC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IGt2YWxvQGtlcm5lbC5vcmc7IEJlcmcs
IEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47DQo+ID4gPiBiZW5qYW1pbkBzaXBz
b2x1dGlvbnMubmV0OyBndXN0YXZvYXJzQGtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1pbnRlbC13
aWZpQGludGVsLmNvbTsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZl
cnQgIndpZmk6IGl3bHdpZmk6IHRyYW5zOiByZW1vdmUNCj4gU1RBVFVTX1NVU1BFTkRFRCINCj4g
PiA+DQo+ID4gPiBPbiBNb24sIEphbiAyNiwgMjAyNiBhdCAwNzoxNTo1NEFNICswMDAwLCBLb3Jl
bmJsaXQsIE1pcmlhbSBSYWNoZWwgd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEhpIENocmlzLCBj
b3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgdGhlIGZ1bGwgbG9nPw0KPiA+ID4gPg0KPiA+ID4gPiBN
aXJpDQo+ID4gPg0KPiA+ID4gU3VyZSwgZm9yIDYuMTguMCBzZWUgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtDQo+ID4gPiB3aXJlbGVzcy9hVERvRGlENTVxbFVaMHBuQGRlYmlhbi5sb2Nh
bC8NCj4gPiA+DQo+ID4gPg0KPiA+IFRoYW5rcyENCj4gPg0KPiA+IGNvdWxkIHlvdSBwbGVhc2Ug
dGVzdCBpZiB0aGUgYXR0YWNoZWQgcGF0Y2ggZWxpbWluYXRlcyB0aGUgcGFuaWM/DQo+IA0KPiBZ
ZXMsIHRoYXQgc2VlbXMgdG8gd29yayBmaW5lLg0KPiANCj4gUmVwb3J0ZWQtYW5kLXRlc3RlZC1i
eTogQ2hyaXMgQmFpbmJyaWRnZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+DQoNCkp1c3Qg
bWFraW5nIHN1cmU6IGhhdmUgeW91IGJlZW4gYWJsZSB0byByZXByb2R1Y2UgdGhlIGFzc2VydCAo
QURWQU5DRURfU1lTQVNTRVJUIGluIHRoZSBsb2cpLCBhbmQgdGhlbiB0aGUgcGFuaWMgZGlkbid0
IGhhcHBlbj8NCg0KSWYgeWVzLCBwbGVhc2UgdGVzdCB0aGUgYXR0YWNoZWQgcGF0Y2gsIHdoaWNo
IGlzIHN1cHBvc2VkIHRvIGZpeCB0aGUgYXNzZXJ0IGl0c2VsZi4gV2l0aCB0aGlzLCB5b3UgYXJl
IG5vdCBldmVuIHN1cHBvc2VkIHRvIHNlZSBhbiBhc3NlcnQuDQoNCk1pcmkNCg==

--_002_DM3PPF63A6024A9FCE1CF29C0492A406E7AA390ADM3PPF63A6024A9_
Content-Type: application/octet-stream;
	name="0001-wifi-iwlwifi-mvm-pause-TCM-on-fast-resume.patch"
Content-Description: 0001-wifi-iwlwifi-mvm-pause-TCM-on-fast-resume.patch
Content-Disposition: attachment;
	filename="0001-wifi-iwlwifi-mvm-pause-TCM-on-fast-resume.patch"; size=1440;
	creation-date="Tue, 27 Jan 2026 05:02:33 GMT";
	modification-date="Tue, 27 Jan 2026 05:05:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NGZmMTY3MGVlOTRlNjliYzc4YThlNTUzY2ZlMjc5OTU4MTFmNjQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJs
aXRAaW50ZWwuY29tPgpEYXRlOiBUdWUsIDI3IEphbiAyMDI2IDA2OjU4OjU2ICswMjAwClN1Ympl
Y3Q6IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogbXZtOiBwYXVzZSBUQ00gb24gZmFzdCByZXN1bWUK
T3JnYW5pemF0aW9uOiBJbnRlbCBJc3JhZWwgKDc0KSBMaW1pdGVkCgpOb3QgcGF1c2luZyBpdCBt
ZWFucyB0aGF0IHdlIGNhbiBoYXZlIHdvcmsgcXVldWVkIGludG8gYSBub24tZnJlZXphYmxlCndv
cmtxdWV1ZSwgd2hpY2gsIGluIHJlc3VtZSwgYXJlIHJlLWFjdGl2YXRlZCBiZWZvcmUgdGhlIGRy
aXZlcidzCnJlc3VtZS4KVGhlIFRDTSB3b3JrIG1pZ2h0IHNlbmQgY29tbWFuZCB0byB0aGUgRlcg
YmVmb3JlIHdlIHJlc3VtZWQgdGhlIGRldmljZSwKbGVhZGluZyB0byBhbiBhc3NlcnQuCgpTaWdu
ZWQtb2ZmLWJ5OiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwu
Y29tPgpDaGFuZ2UtSWQ6IEk0NGRmOWNmOTE4M2I1MTQzZGY4MDc4MTMxZTBkODdjMGZkN2UxNzYz
Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYyB8IDQgKysr
KwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9kMy5jCmluZGV4IGY1YTQxZjI3NWQ5OS4uMTEwNjkwZGE2M2Vl
IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5j
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMKQEAgLTMy
MTQsNiArMzIxNCw4IEBAIHZvaWQgaXdsX212bV9mYXN0X3N1c3BlbmQoc3RydWN0IGl3bF9tdm0g
Km12bSkKIAogCUlXTF9ERUJVR19XT1dMQU4obXZtLCAiU3RhcnRpbmcgZmFzdCBzdXNwZW5kIGZs
b3dcbiIpOwogCisJaXdsX212bV9wYXVzZV90Y20obXZtLCB0cnVlKTsKKwogCW12bS0+ZmFzdF9y
ZXN1bWUgPSB0cnVlOwogCXNldF9iaXQoSVdMX01WTV9TVEFUVVNfSU5fRDMsICZtdm0tPnN0YXR1
cyk7CiAKQEAgLTMyNzAsNiArMzI3Miw4IEBAIGludCBpd2xfbXZtX2Zhc3RfcmVzdW1lKHN0cnVj
dCBpd2xfbXZtICptdm0pCiAJCW12bS0+dHJhbnMtPnN0YXRlID0gSVdMX1RSQU5TX05PX0ZXOwog
CX0KIAorCWl3bF9tdm1fcmVzdW1lX3RjbShtdm0pOworCiBvdXQ6CiAJY2xlYXJfYml0KElXTF9N
Vk1fU1RBVFVTX0lOX0QzLCAmbXZtLT5zdGF0dXMpOwogCW12bS0+ZmFzdF9yZXN1bWUgPSBmYWxz
ZTsKLS0gCjIuMzQuMQoK

--_002_DM3PPF63A6024A9FCE1CF29C0492A406E7AA390ADM3PPF63A6024A9_--

