Return-Path: <linux-wireless+bounces-20225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF5A5D9A9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346D0178A9E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DC923644F;
	Wed, 12 Mar 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAbObnvo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1423A9BF;
	Wed, 12 Mar 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772244; cv=fail; b=e0vyiChZQeEPtvbGXjf3zS1j7t/k+LnCJLT0A4q2m3dgWWe9Jb06SVvBC/yyVs5u2offhOGA8S3ZMCeCC1gUbzawhm/u6PP4kFv1+jcGSpZCb/oN09PXWobF5uO82am5mkF9BzNajofIC7sdlOg/XwSs53M4pvO0yLWDTAx4/ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772244; c=relaxed/simple;
	bh=ua36L+woKy4DO3hqX3CDXCdCXO/1BaiXU9lMV5wIaL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjWZnCEREC3KqEiPgjMjNBK+6tsUYAMda619atYy34+FyFXPTcWXMO25MNxvbR/yV58bgOBBB+ZnkZfieqglB5i7dR1s1/T8Bu4MBiIKFJKM9l3R97p7zD6259tvMZMN9DBidlPXoNTihUTYgYNFWpITlW1oTEBKneNlJJ24r9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAbObnvo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741772243; x=1773308243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ua36L+woKy4DO3hqX3CDXCdCXO/1BaiXU9lMV5wIaL0=;
  b=RAbObnvox8Tx1IqXmuldwedbZmUiRrarYRxSwwf3eMc2B88qcA6CRUsU
   tqbGr4PjxXxUpKya5ebg0XSj0DBFmTiXLsGD+SYhSneNtIjVPAxER6Ydp
   3hcUD8i2IAcdDyhWsK8tF9wRuhf021bvcKXTr4jm3zxH7bYKK/jzhhlh4
   Fd4ptfVF5lB18uuEpAuDG87HN1XtKIDn3IxSt4R/BimOxRzXjzsaw8dGq
   CBKjxosoICJVH4d2vfwRI/xIJF5XKIK0yUywha4VVAZjRzTPkpNl5o19L
   NXhlPMpcA6c5qh1GGbYfqqr95IejXES2euBvvrituQnCGHN9nBG4uZEq4
   g==;
X-CSE-ConnectionGUID: FlIIOtkmQ/64YFw7nw0KcQ==
X-CSE-MsgGUID: v+E2MuO/SHapOp7+jDTMRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53465593"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53465593"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:37:22 -0700
X-CSE-ConnectionGUID: Xd801GNkS+SQx4QouuA0nQ==
X-CSE-MsgGUID: 7paTDWIeSfuiJEcgL/HDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="157772460"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 02:37:18 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 02:37:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 02:37:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 02:37:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZqmhraTLmomitVYNvEZD7rzZNzYjmHOUl/q0fEyuB/2Fo//OAjIJbJ68MA2yUPGpJYh/+eASbR3SGEay1mjhd+DNcOlHHp8PBHwk8/PRGPEGwYWnY3Ttts1hLnmIjaqFs0bMdrOSD8HxdPCSTRKJrWmGc0UxLlc5ciHTgfFQfX9QhUFV1dgPpFedP84kyxmYlBlT/YnlI5/NcvlxaNnEdRcEwQs1YMHjo+SCuXLzJfFhPwTI8rLhBMJwNdy7fa3ZzdegjJPF8+ddwsUxkmRbtRG7AxdgQWUtqOYlzU4t1NOZQMII1/Kb4whDiU7aobWYLm8vmk53pJ4v/w7M/0fnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua36L+woKy4DO3hqX3CDXCdCXO/1BaiXU9lMV5wIaL0=;
 b=g6MA3Czt6S7dLf7Llg+zYc6vdzMpjaBzbMHxLEsSoWZ6dVB72XEmdzZo3OHKhxuES/L0kExI5wBFlH7Cygma5rpdF/hteIk/Dthpd7yBQLXGAK6ZNilKGBiYXNMPZtc0EwjxZE5GE1ZVMHFjlhBWtolIs/K+rjTOicnbG/s7pa+40Oy46kW6fj72/2k0Dg7dYLiCu756P6ttETOOcCIj4nJEFByKT0qyXKXBjsQsyukLOueeNjzZKj6HldXAwBh8TBYyegV6Fx3mQLaWZzHwriehnD0gxbrrhni+spcNiRcaXIQZQn5UWtzhC11dIwI7n4TlqaPNQHfN8h2DmCO1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:37:09 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:37:09 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Thread-Index: AQHbkyk2ps1nU7Wqc0CGLEC+H0GKCbNvPcGA
Date: Wed, 12 Mar 2025 09:37:09 +0000
Message-ID: <MW5PR11MB581070A3B9F613677027381CA3D02@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
In-Reply-To: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH0PR11MB5925:EE_
x-ms-office365-filtering-correlation-id: 87d180e8-d6e9-4eee-1de8-08dd614975b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eUdubTVGRS9BV09OMkJWcCtORmhNSXZzT3B2ZjRvaWg4bm9jUDhpTmRXOGNJ?=
 =?utf-8?B?NlFTa3VPRCtNSC9IR1BhSnZqNmVFM1R6UFNtWVhkWVNHSEtMMXNGVmRmVkNj?=
 =?utf-8?B?QkhyTGowVURXb1hEL1RMZ1Y2U3NaOGZVTFJsV1ZFSERPclZkcWZtOEFoMTZi?=
 =?utf-8?B?a25ocXVXV1lyeXlnNHFmdTBhSHhJQTd2dm5RUVMyTFQrNnV5dU1yTndiRjhp?=
 =?utf-8?B?NEN5Qlo5OEF0dnJLZlBaRmVicFRUOFgya3NndmFlMC91TVNWbTZiWmMzSmg5?=
 =?utf-8?B?aWd3RjVOckZKTnU0MjFmRjdWOW5TMU1FR0pzUmgxUHpxRjBLRUsvdlA3M0pn?=
 =?utf-8?B?d3dPdjgvTzJvVTc5Q04xTFdSTHFBb3Voa0t1dXNGMG1ta0JhcnhBSHRnS0Ru?=
 =?utf-8?B?Wi9IUDVWZ2tiU3ZrWSt3S25VeHpUSDRVSGkwWG9KeEpQNEIzVnM0SytkTk9q?=
 =?utf-8?B?emVhQlNoR1VmMTYrQmE4K0l0c2FhNWsyYnhPV2poTkZBRWxXaEtYeXZBaXJs?=
 =?utf-8?B?NzB6dWlrTmg3OWZMandLeEVnRHRGOWxqeVdmS0VqWFp6djZGaWNLNnNyNjN4?=
 =?utf-8?B?M1JaMExKQ0hFak9JNCthRzR2VHVmRTl3aU0xZExUd0FuSFJrUjYwcVFrU00z?=
 =?utf-8?B?RnhweXBtMlZMSkxncGxlSTcwLy92YlYyaVloQ1A4WHZQV2xvVTVjSVVheG1C?=
 =?utf-8?B?L1AxOWsvbW9DM0t0LzI4SmdhRXc4cWhDd0cza29pdENUc0hLVGFPSTJ0eE9F?=
 =?utf-8?B?OXUzZjgxQlVBZVBvaWNNcitsZmJWd3I1NzNuaXp3eElvQ3k0T1VjclJkUVNz?=
 =?utf-8?B?cGZlQzhHK2pZUkZ4dnVFTExmMDNzblllNkNEMUtXTFE3TFMra1VNUWNEb2ZU?=
 =?utf-8?B?WmNHN3hDWjIyRVlqaXVFTjRXeENlZTJESWxqQktLeVMyQWw3ODFHd1FDZEh4?=
 =?utf-8?B?Z2FPT2dBcG5YeUxVczFLcWJGSkRTVjg3MVEyNXR5eEJJOUJ4U0pDRlc4ZmQ0?=
 =?utf-8?B?OEx5RDg1QTRMbFZCYXhzK0REVWpBN0ZyNE5DeGFGanZ2bE5tUGI4ZTdvSjlR?=
 =?utf-8?B?Q3FadkdZK1JJRSs3cGlsMEhMWG52amMranhUTGtWeGZ4N0dmUEZ1L2oyL2ph?=
 =?utf-8?B?UUxnb3dKUzByVUJUeUs0Z1pXbXdRVHJoL2xqUExSYVpIZlk3ZG11dU8zNUpX?=
 =?utf-8?B?NHpDdGg5ZURkUFNWZkVwd3ByTDdmbTVJdkQrajcxL3pydkMvVmNPZTQ0YlFp?=
 =?utf-8?B?WXZxb2xhMTVsVlYzVjdIWGszQmN6ek50c3FSVzBmSm9HaEVCd21pRlBYaVBH?=
 =?utf-8?B?TjZKWjZKcWdJcEFXcEkrajk1eDFST3VmejcyRThkN0Q4TndLczdVcVlVUUE4?=
 =?utf-8?B?OVpmd1NpYjFwUnQ3MExEK2s5RVZNdTMwSG82dFY1bzl0V1IzQWVVZmlvYm5t?=
 =?utf-8?B?eVdCOXBDbkVqTFA5a1hORmwwQWI4dHo4VW9NeEVicGw0eGloS2htNTk2OEdM?=
 =?utf-8?B?SVIvS0plMy9pNEFIbDJNSnVOaHpVai9pUkFNaEM4dWN4Y2E1UXl1SnVvbmtx?=
 =?utf-8?B?YVFDV3JCeEg5RUJTSDE5KzhIZlQrTjJxUzBuUEtXMmhKMk1yR25rTDBmTU5I?=
 =?utf-8?B?bTBCZFNjMlBDelAvc1hJQThibHhvdjNjRHRCMG1uK1BtNXdRRG5WRXg2RzNT?=
 =?utf-8?B?RzdDcHN5QmJsa09CTVdTNGFJL3BkdUpxemJGRW5KRXNUZGI3TlJhaXpxVnN0?=
 =?utf-8?B?eVVSb2pmeGlGNEFWdm5CZUY2Tmg0VDg5Qm04UWFLSGF2ZnA4WStaaCtVODJC?=
 =?utf-8?B?QnNNK2diaVBXRHN0Qk92V0xTY2loVFd0a3kzeGwwUzljVTBsRFlidlUxNUY4?=
 =?utf-8?B?em9FVmVvSUU5b1dDY1Y1SVgxN01iUmR0S3B4YXpVKy9acFZRSCtqWVI1NU83?=
 =?utf-8?Q?1b6UdbYITVrO3CLc9hdjCPOf35pVCypW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1FrRzJDQm9QdjJUcE1KelpDb3ZyMm5YaUpGcUN5NzNSeEhJN2VKSFpWRHd0?=
 =?utf-8?B?TVc0RU9nQVdTbXBLSkRyaG5FY2JKQ3pKWkhBMjl6bW0rUVBUaDFWc3F0WU51?=
 =?utf-8?B?bmRnbG5XNUVLTEJGUEtMQ1R4QjBwQ3lwaXZKeU83SmhzYnhqRHVhMmZyYmla?=
 =?utf-8?B?Z1YzOVhIdmlUbzVDZmtXcTBUUkRPeGtQM1ZzS3d4eWRUOXNCRXZXd2FlTDg2?=
 =?utf-8?B?akU5NVA3eGNvcnNxMFR6NzdpOVBEczg0dmloMzIza1BieHFPcS9ieVFGN0Qw?=
 =?utf-8?B?MVdWK1ZBVGxJNWFBMElvQjZLM3hqTmRBYVg5aHU3d2tJZGhLQVpWaHBGejZu?=
 =?utf-8?B?OHhmQ0MvRGJPS0hCVWNmSWpZa3pnc2tyUmptcStNbHF4N3B1V2xYTE4vQWFL?=
 =?utf-8?B?MUZiZWx1UmdGNXRxdXU1dTZ4RDF4WHgzRzhiVWdmdlZVUjBQVWNSMHlJcmc3?=
 =?utf-8?B?dnBveG5ubnFubndUYUFjTGZkZDVOaG80MWQ5eTYwOExxckVVRDNGV1VucW5V?=
 =?utf-8?B?eHdUU2JUTWVibjdFeTFCMDBDWDB5TFJyOTdaTkdFck15QmpYZ0NIekVTUk1s?=
 =?utf-8?B?SmxjNEY1dEdpNmdDd0xXYmxGQnBhTWdKdzRLd0thSnJEODlnTmV3M2Z2eW15?=
 =?utf-8?B?NzY5aXNwRUNkYk05NzFhVWkzM0VNOHN5SmNweXVSbFk0NXB3akpIaW1xTG1T?=
 =?utf-8?B?MnVkZ3JrQXVEWERPUmZzQ1RId1dFeG9ROFBIRlFlVmtQem5HckNLSSs5NGN5?=
 =?utf-8?B?cFdIL0NZbUhlVlhnQ1BuVFFpTEM5ZHlhRlYzcmtUcHJZOEVrM1dlNVcyQ2FG?=
 =?utf-8?B?TllwYWRNd3U4dEIyVHh1SjIxajBtSFZSd2NhU2ZOWkRTc2kvaHoxN2lUeUxF?=
 =?utf-8?B?TFJwUlNPTUxQcklwZVQzZXJYcFpKa2hmeGhZRHppWDFja2RMa096N0R2MlR5?=
 =?utf-8?B?QUpxN2tFZWswU29zVWlQWjFBRjYvK1JuaGlnTjlZSG55UjBJQkVFT1FZdXVD?=
 =?utf-8?B?VHZ5TWpDQkVGeDFEMkk1SmVsekRxZGcvcllWMy93a01Pd2FqWi9YTG4zeWpN?=
 =?utf-8?B?NzFsQkNQaGwvd1ZmdkRmZitqSnllYmo2THQzUWpTemdwQkc5eEk3UUVRRXp6?=
 =?utf-8?B?dzVzYVhEM1NmSVFzYnRqbjdrcUFIQ0NMWG1DQ09SVVN3bVhjTk1jbnA1dU9K?=
 =?utf-8?B?RlRKM2ozQS9HWWFWMWtDSXd2NitjUXQzWHc2ejlFaUs4LzN5N3VEL0hFWDNI?=
 =?utf-8?B?STRFMEhqUW81bzlZY2xhOEZ5NmdyYi9FZi9ZTXRNdllseXArQVAzSUxWWjln?=
 =?utf-8?B?TTdFNEk0ZURabmtVR3lZZUsyNmY2QTd0a2lyN2JIYkxWeWxWR25DYTQ5ZHR6?=
 =?utf-8?B?V0NvRzAvTTRoRjhYUkFnMGUyWXZQRnlLU3F1UFpXNXdkSWg4RC9McUdMSCt0?=
 =?utf-8?B?WHVxMkptR3FwK015Zjgyem1MRFVqNVR1bTZmWmRIU1M4aXVEb3gvblgzR2ZD?=
 =?utf-8?B?VVFNZGxxSXBVd1krdVVmcWY3U3haaS81bktHVmc3djJBRGl4R05YZjNxSlFq?=
 =?utf-8?B?OFA0bHNxREZOdU9oUVJ5dW4vQTA5RklqdlM3d081bGo1R2xyb3hjSlg1MnRI?=
 =?utf-8?B?bTNYVSszeDltVUxmMVJzWXc2eFp3S0gzUDhiWnBucW9pWU42Rk5rM3QyMGVk?=
 =?utf-8?B?dkc0NDlNcWFEWEp6YXFRQzRFVXFQdXpnOWtLWThTeXUzdGw2MmRWSkVmbWI2?=
 =?utf-8?B?SDlKUVNtM043ZDlIRmlqYmYzdGwwUjUrYjNqemlUeW9YeW84MGtEYXl2UUJ6?=
 =?utf-8?B?WElYZWUrOWRYQkk3L0YzSDE2U01EVjU5bWNucVB0ZDhna3JVc2JMVVZzMEFp?=
 =?utf-8?B?bEY4VUdiUHRiRmdBTkRjZVpKNUJSVDI2NHNCVlhka2Z5MEIzMGhodjIzWlB2?=
 =?utf-8?B?NnlBZ0RIVDIzTjdIR01ydHJLZTNXMVF1emMzQ3dOQ2dTeW1Sbkk4OEgyUjdY?=
 =?utf-8?B?REFVRWdLOXlKYkxZcXNScTliQ3loa1VORVdmRVRHdGJkc0NUQWIrZkhwYzNH?=
 =?utf-8?B?Q0N6N09jYWFqbHNzT0lIMWNFQ2ZJRURjUkMrUmw3bGpkd1gyaS9LOGJrMmVu?=
 =?utf-8?B?dEt6dWZLc0t1Y2lXRkh5WmZEb2pvbCs1cU1KRDhHVGhPb2V3Qmo2NERHMC9E?=
 =?utf-8?B?c1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d180e8-d6e9-4eee-1de8-08dd614975b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 09:37:09.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWxaUuZlti9kG8Syt2Tq5T5EmfjUCwu3Sge8jfu2DQJly+iJMb563po72e9clVBl4FJXMBqbxjbI3Vs8ZGa2N913JkSHxEHAgqhyqQWxRxQPwGpiHnpxlSsa7JDSG9iE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDEyIE1hcmNoIDIw
MjUgMTA6MzINCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5r
b3JlbmJsaXRAaW50ZWwuY29tPg0KPiBDYzogQmVyZywgSm9oYW5uZXMgPGpvaGFubmVzLmJlcmdA
aW50ZWwuY29tPjsgQW5qYW5leXVsdSwgUGFnYWRhbGEgWWVzdQ0KPiA8cGFnYWRhbGEueWVzdS5h
bmphbmV5dWx1QGludGVsLmNvbT47IEdydW1iYWNoLCBFbW1hbnVlbA0KPiA8ZW1tYW51ZWwuZ3J1
bWJhY2hAaW50ZWwuY29tPjsgU3Rlcm4sIEF2cmFoYW0NCj4gPGF2cmFoYW0uc3Rlcm5AaW50ZWwu
Y29tPjsgQmVuIFNoaW1vbCwgWWVkaWR5YQ0KPiA8eWVkaWR5YS5iZW4uc2hpbW9sQGludGVsLmNv
bT47IEdhYmF5LCBEYW5pZWwgPGRhbmllbC5nYWJheUBpbnRlbC5jb20+Ow0KPiBsaW51eC13aXJl
bGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5l
bC0NCj4gamFuaXRvcnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBuZXh0XSB3
aWZpOiBpd2x3aWZpOiBGaXggdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3aXRoIF9fZnJlZSgpDQo+
IA0KPiBQb2ludGVycyBkZWNsYXJlZCB3aXRoIHRoZSBfX2ZyZWUoa2ZyZWUpIGF0dHJpYnV0ZSBu
ZWVkIHRvIGJlIGluaXRpYWxpemVkIGJlY2F1c2UNCj4gdGhleSB3aWxsIGJlIHBhc3NlZCB0byBr
ZnJlZSgpIG9uIGV2ZXJ5IHJldHVybiBwYXRoLiAgVGhlcmUgYXJlIHR3byByZXR1cm4NCj4gc3Rh
dGVtZW50IGJlZm9yZSB0aGUgImNtZCIgcG9pbnRlciBpcyBpbml0aWFsaXplZCBzbyB0aGlzIGxl
YWRzIHRvIGFuIHVuaW5pdGlhbGl6ZWQNCj4gdmFyaWFibGUgYnVnLg0KPiANCj4gRml4ZXM6IGQx
ZTg3OWVjNjAwZiAoIndpZmk6IGl3bHdpZmk6IGFkZCBpd2xtbGQgc3ViLWRyaXZlciIpDQo+IFNp
Z25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9kZWJ1Z2ZzLmMg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21s
ZC9kZWJ1Z2ZzLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9k
ZWJ1Z2ZzLmMNCj4gaW5kZXggYzc1OWM1YzY4ZGMwLi4xZDRiMmFkNWQzODggMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2RlYnVnZnMuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9kZWJ1Z2ZzLmMNCj4g
QEAgLTU1Niw4ICs1NTYsOCBAQCBpd2xfZGJnZnNfdmlmX3R3dF9zZXR1cF93cml0ZShzdHJ1Y3Qg
aXdsX21sZCAqbWxkLCBjaGFyDQo+ICpidWYsIHNpemVfdCBjb3VudCwNCj4gIAl9Ow0KPiAgCXN0
cnVjdCBpZWVlODAyMTFfdmlmICp2aWYgPSBkYXRhOw0KPiAgCXN0cnVjdCBpd2xfbWxkX3ZpZiAq
bWxkX3ZpZiA9IGl3bF9tbGRfdmlmX2Zyb21fbWFjODAyMTEodmlmKTsNCj4gKwlzdHJ1Y3QgaXds
X2RoY19jbWQgKmNtZCBfX2ZyZWUoa2ZyZWUpID0gTlVMTDsNCj4gIAlzdHJ1Y3QgaXdsX2RoY190
d3Rfb3BlcmF0aW9uICpkaGNfdHd0X2NtZDsNCj4gLQlzdHJ1Y3QgaXdsX2RoY19jbWQgKmNtZCBf
X2ZyZWUoa2ZyZWUpOw0KPiAgCXU2NCB0YXJnZXRfd2FrZV90aW1lOw0KPiAgCXUzMiB0d3Rfb3Bl
cmF0aW9uLCBpbnRlcnZhbF9leHAsIGludGVydmFsX21hbnRpc3NhLCBtaW5fd2FrZV9kdXJhdGlv
bjsNCj4gIAl1OCB0cmlnZ2VyLCBmbG93X3R5cGUsIGZsb3dfaWQsIHByb3RlY3Rpb24sIHRlbnRo
X3BhcmFtOw0KPiAtLQ0KPiAyLjQ3LjINCkFja2VkLWJ5OiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFt
LnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0K

