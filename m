Return-Path: <linux-wireless+bounces-20959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954EA7588D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 06:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1841116B5F2
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403FD6A33F;
	Sun, 30 Mar 2025 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeXtWC2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051D4C81;
	Sun, 30 Mar 2025 04:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743309145; cv=fail; b=Pyu+APp9rFod04xxj+hidgtK+OXCfdt3mZ/6mhLhu5yiMvLKDuziIvcsImLVqLH+4j7/iOppNdg9A3WfRI/jPxSFhQ6XTuvc9YRarykxHyjkF6W2bWNxFrvAoCwU+udpuf8Zflexx/kqDykL8Uuaqbo1/W1Wfskf91AVHleTGXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743309145; c=relaxed/simple;
	bh=1uGjoV+ZQqBSAl+rVdh+aHT6ALiGUDC1s49Xp17SvTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3J7ndlLZJ/34/zC7DpCXUXvvljBSxxTGs67CUfj0PnDZW4ncmm2BeclwbOAOgpLwMdxt8UOHlZttUsu53PdOT9KSEb03hDiou4HjGn7Jtgj13pRBK+ZIaazrSyKKq1Zcou+4nNbU4DaRRxdq0xtyrhvpr4TjIOtS0ElxaXDwQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeXtWC2x; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743309143; x=1774845143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1uGjoV+ZQqBSAl+rVdh+aHT6ALiGUDC1s49Xp17SvTc=;
  b=ZeXtWC2xuoIIElUj+qeXYJeo5FmJwGVAXwcd6bmlYtvIWgvo7r7AJxlj
   mE291aKEQs6HH8Fz/0sUS+BoAf91/3fG+D3tK52JVl/EweUdDX31Cry9c
   3KHXMlefRjYsQq0I2/ZRP+dgrLTsjafUaFaYaG/nJfgWS/bjecIIXz5jS
   CeyA9LuSSefSW8jRNFGg9aZb8Ks8XbiWuWO5iR1ehQZ/hDulqarmRbhpB
   N8g8zgnznfo8a58BuwHuUxITRbshOJHMCmBv4uS+aJb9UnPldEJOzzucy
   8+6obDDQ8iehkmVS8YOKiC86ZSOcgmXv/ByBp02t0iocfdQwNdfrU1Qqn
   w==;
X-CSE-ConnectionGUID: Litx2VCnQ8a8hn6SgftlQQ==
X-CSE-MsgGUID: lsDx5ciFRZKViNSy/xVAWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="44807946"
X-IronPort-AV: E=Sophos;i="6.14,287,1736841600"; 
   d="scan'208";a="44807946"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 21:32:22 -0700
X-CSE-ConnectionGUID: iXtmXaAVTPipk9wMwE3ovw==
X-CSE-MsgGUID: TV7QL1Q4T3+BAH1Jb8kxNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,287,1736841600"; 
   d="scan'208";a="163051763"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 21:32:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Sat, 29 Mar 2025 21:32:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 29 Mar 2025 21:32:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 29 Mar 2025 21:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4MDPoH2KM35tSRhrf9TR+Etbc3NoxneZ9ym205aeKtL3u9dZknJGoPg4IfGhb7TbQbqej2ZWsLgkSZEfo53KwODvrakbh+GraDZYoNVPtLvtkePZBcC3YzAJfZcA7xgIPbXF5ZrwZ6EO8vgDz77M6of/78l/DBfZk1TKnz9/ZmuVvFu6Fr8FMiwv1qhjn8VDy3fldoTUGNysiNTDDHEC3ZdL0mv+H5EL4+Yc1y909PcRvAhcwtXEPG3bv0JlZ+CGW3cIErfeFalgb7dbBDcYgffN4opcMTkDZ6Jte02y+caSwvNf2TdOcZ+75t0rLUNiSIspFlg7Q2nj0YaUxpNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uGjoV+ZQqBSAl+rVdh+aHT6ALiGUDC1s49Xp17SvTc=;
 b=wEMOevndQmBletmPIEXoC6YOuzP6+jF8llvfvvjne7dst1MHNPX8MWM/4TChgictsLvavQ+eRFH81KoFs2KEUhXLalMHj2hvujYcwG0yu542hQWrUIw3GV2oyANl6N1oICHXaE5djo2GwnGMYAhIltfYfdkEAUwAmcDObHmQRmfAqgUbbA53jUrR/3Y9SWQz2cLrxWjXaA7CXlYMqWZ9qaHoiaEqYiNQgxCXL2jfZSG8DnwsAod/DBwEojmfEPgJ2uZmVwY9+gOrBKNklsISJLm6XYIEMlsodOryOf8KqS1AH5J9YHUX9bTZ63PUHN8bMJtBqgaNphNQx25et4GjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sun, 30 Mar
 2025 04:32:19 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 04:32:19 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: iwlwifi: mvm: Avoid
 -Wflex-array-member-not-at-end warning
Thread-Topic: [PATCH][next] wifi: iwlwifi: mvm: Avoid
 -Wflex-array-member-not-at-end warning
Thread-Index: AQHbnqvEVAo7gbZZFkqcPaNXixF8brOLG0cg
Date: Sun, 30 Mar 2025 04:32:19 +0000
Message-ID: <MW5PR11MB5810ED44CAC151708F370906A3A22@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <Z-SV8gb6MuZJmmhe@kspp>
In-Reply-To: <Z-SV8gb6MuZJmmhe@kspp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH0PR11MB4887:EE_
x-ms-office365-filtering-correlation-id: 998efc3f-120f-4dbf-f578-08dd6f43dbaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXdCZjJvK1FkcFZlMnJ5ZXVES1lnN25UWlptNk1rTFFOVUFLK20xVWpUQWRt?=
 =?utf-8?B?bm5kUGNzT1lzaUpTcnF0VFhNVnJFNGsyUm9GVHdrTGx5K1RxSlV3TzgrM2Zz?=
 =?utf-8?B?ekVmdmRVNTJOczhKS0I1ZnRsbEJkK3h3V0V4NDBHSVFCczdtTFd1SFE3aDd6?=
 =?utf-8?B?UzMvUGJ2WUhsR0hqakp0b0NXMzVvNU5FTkpFMWtXTzNsUEUyYldqNW1pU0hp?=
 =?utf-8?B?Y2ZyNEtBK0N4VE0xUGtUWC9ubjRsM05SeWxnb0NwSTRac0hHVXA5aXFCM3FL?=
 =?utf-8?B?S2VWWUd0SUd3NFFPeGR0SC83SmdpL1NUalpUVFlkMkJCb25IdndEN1ZrYVF3?=
 =?utf-8?B?Zm5KWjM5dVRtQ3gzUjVnUGl6TkEzWVZiNjBJR3dXeVlFZnVhbnRZYmRwaTYv?=
 =?utf-8?B?ZlcrN0h0dFh3WHFoMDZtWm1NR3pRQzkxeXBENlFFZ0M5RFhEUkIxNmxQTVJK?=
 =?utf-8?B?SWRGZHcvM2Jhc21lWlQ2RmVMaWVIOEF0NnU2WU9ndGNxYTdVVzN5Rit0YTFr?=
 =?utf-8?B?M1g1eTBxZGM0WDRCMWhud25WejB0MGNiOTZIVitJeXVrelFrMzI1S2RRSlFp?=
 =?utf-8?B?V0NIeE0zdytlQnBidVJEb0dMU0NPTkFMWlFnOVhYMlYyT0xGeXJCRmh1ZzU3?=
 =?utf-8?B?MXJFREUrM0JCbFYrMVJ3WGdTQXUyL212NjVWTTJaSWNYdm1Qc3FFK2FJM1JG?=
 =?utf-8?B?MWtwWnZCMWI1OW1obTliTEIxcFhscmxxcFBnZGVzKzk4OW1kYUlNQjhFUkND?=
 =?utf-8?B?RGdOMUl6YjJxcFE3WnkxdnJtaUZuQUwxWm1YRVRRNnpSSlpIYVNkenRydGY4?=
 =?utf-8?B?UjRPb05yT01sY25EeTZrdU9oZ1U5K0xvc3RtMnRSanBnR3JkSVpISE90c1Vo?=
 =?utf-8?B?Mk9WS0JaeGRma1VXaEplNHgyQnNuNk1RZ0hTM1JRelRnOWhaVEU1UnltZ1ps?=
 =?utf-8?B?K2FyUkJvSUdQMG50dUI3dVpHNjFWeUJhdVlqbi9BcEpIeWpXSGpXQmlVbFFT?=
 =?utf-8?B?cFF5MitTY01uRk5jakZ5eVl1NkU1UzJvRE1iVUI0d0s2Uk5SdVVjK1YvL3ZS?=
 =?utf-8?B?bThvVjBSVXZoeXdJaDJTTVNZWmRIdkZuU3BYK3ltTWRoTm5mOFA5SHNsRjRT?=
 =?utf-8?B?U2lvNDVlZGJ3NHFUR25TeFY4dElPTVZCaHRXR3dKbEF6bHg4Y2ZsZ2E3Tktw?=
 =?utf-8?B?dmp5UHVzd0t2WW5tSnZacVpsekRtTUVKVlZIUC9FZXg3MVZaWjdwSVdOMXpm?=
 =?utf-8?B?eUFSc3I0cEFFY1lTZWlLaFh0bUdteVRtUHJwRWtyd1FVWDE3Y1YzYm1LWDV2?=
 =?utf-8?B?Y0hVZmUySm5KeThFRWMxODk5MXc1ZUE1SCtvUmJhU0p5Mmd2V2JLa0pnTitK?=
 =?utf-8?B?SlVmQ0YrNitPWHAvRzN5WjZIL1ZnUDJ5SkpRbHRoNjRicUxZWmt6aG5vdFg4?=
 =?utf-8?B?RDJyRC9FWkppd09QeUZHUjhsTE84NFJLdDlpQjF6MzhFdkFrQlp3dGc0cS9z?=
 =?utf-8?B?ak1PeDl4aVNndFExb0V0SWhIN0xRRFJNc1hNWWsvM1ZDR0FXeC9lMUFzeVBs?=
 =?utf-8?B?OFZHaTg2WW5kbks0eTExL3ZBNmFnbTRCamRVT1dtSTAyZWJ5cUYvS3BuNXdr?=
 =?utf-8?B?TUhpeHJ3RkYzN2ZGNGd1ZWVDdFlTRTFTOVRIczljcTExTitvdUh6QTUwUnZS?=
 =?utf-8?B?blBnNU0rUVIwcE1hNlJTNXBQQ0ZHNjNwOGZWaEhkNHR3WmRUV2dqcDdzSFFi?=
 =?utf-8?B?THdjdVNxVmh1QVZsWmZjTklJd1NmeklqUzZ4eU41MnZRSTNxakR5VnFFMmpn?=
 =?utf-8?B?d0lOZUFyK1ZjOFZTOWhIb3VtUVJVWXdoUjN6TXVwZis3bDJwallvYXVIMHlk?=
 =?utf-8?B?LzBQaWxjcW1ac0NFaFNUUGJTVnhiTmhSNmZvUnRXd2lnWktCUThhSGtmVm5X?=
 =?utf-8?Q?azioP+KLYGs81UscmY/F8IefDK+qBtS7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QndCek5DUWtGanJnT2o0cVR1QnErM2diQzE1bytiQTRiNzkwUXd4bFA2RnVi?=
 =?utf-8?B?SVQ5UFI5d1Jnd05mYzQ0WjB0QVBFZ2NRdDd3V2I4MjNSVE1xYnlvc1ZidnBX?=
 =?utf-8?B?VXlhTWsyeXhUM0piRFpjOHdjQ2JFNGx4SFV3MHZTb1l3b3ZNSmlmdFJabndq?=
 =?utf-8?B?TGZkRjljV2hoNW9SMGVoUmFzWFZMdDFUc2ZyZlI5eW85UzhyTDJsSlRVa04r?=
 =?utf-8?B?VlFuWnJtbFNRdWl5NWFWTEFCSG04WjFaczBDVy9TZkFuYWRnckZPQk82V0FO?=
 =?utf-8?B?bDlYdDNLdVJrODJlTXNVWWlnZnlCMHBtYzZ5VzE0RUdOSGNKZnFIalRvQi82?=
 =?utf-8?B?VmNQLzYvdzdVbm4vZFZqNWRmZTBUUjQxaHBOakxWT0NJS0pLeTRWNEZoajVj?=
 =?utf-8?B?L3l1UDY2d2hsNWJjdFlhYWNIYStJZGtxZXJUTFgxWDdyQXBTaU1MZTlXc1lC?=
 =?utf-8?B?WnNpZS9MTkl3WnJLN2FFY25VQ2FXdXVPOWFNd0E5aGl0VkRJTFJNK05HSXgx?=
 =?utf-8?B?MThpU21SNkFsMk9kMVptTXZCNzU4ZUZLOS9Od3J5b0FNMVVSYWtJZmtJT0xy?=
 =?utf-8?B?dGxneDdreCtoYzFLWGdZZmN0MEhsckgzMjZMbTlHMlhDRXdQMTNSdDVhekxB?=
 =?utf-8?B?dUY5Wkhsb0xscjNva3BPV2tDaGZDMmtHeTZrMUI2OS9iZ1VObi9CeVloM0tN?=
 =?utf-8?B?OG9TMmR4UUZndTN4WFZZREJsR3hodkV5Snp6ZEc0eWl0clRtWFBaWDVDcFB3?=
 =?utf-8?B?VzhsdFpLWmdzVUk5RHhhWWVoRTBKaHBuaXNqeGdDVDFoWlZRSnR2dDZrQnhJ?=
 =?utf-8?B?M3MweWZPbmtiblNBMXovTDFraFppbllqU2VFeENuUWd2NjBLcU1UbFBrRnhJ?=
 =?utf-8?B?emxwZmFSczdjbHVTbTBkSXhLMDB6RGpYdVRWS2doZkF5NGljcFNDSms0RHNO?=
 =?utf-8?B?VEhpdzNEUS9EVzNsWGFaL1krY2cxeEpXbW1YOXdRejVVQVhsajFjQm1DTTdp?=
 =?utf-8?B?aHg2TFAySFcrYnRScE1rMWlxMFF4b29QQnpzZGFGTzNUUlFheGEwODByVE5O?=
 =?utf-8?B?ZFltVGtKU3FoZ1YwbUllZFNDU1VEZ3Q4blBXc0k0OUg4cUJRalJldmMrRkdZ?=
 =?utf-8?B?MUV4QlNlcEwvcElQSU4wMks3b0JZcG5kVXVRZnBITTRDYUtPbnBiRHpaQkhz?=
 =?utf-8?B?MGtLRmIza05FR0FwWWhPQUI2KytMTG05d01KSGlWYmhMVEpleEFDNWdKSEYr?=
 =?utf-8?B?Zmc2MmVHeVJ2ZEx4RlNYYjUyMzNhWG9iSExua1dpRm9TSmFadDNOTWh0Sk4y?=
 =?utf-8?B?LzJUenVlT0FPUUZGNzJya2JWTENzRXFCVmVjeks3aWhpdmpQUURXd1JFcW1T?=
 =?utf-8?B?eWRyZnlnMWtiODNqWXVkemRmNC9xL2QyWHp0U3NsUm01NHlRKzZJU2RaZ3Rx?=
 =?utf-8?B?YWRTdXNiT1cveHNXMENQaW5nZ3lxbENWenBkSlJZb0cyRm5lVnpJWUJkcGkz?=
 =?utf-8?B?Qm1qRmtMcWl1UzdEU09PSm4zTWtEUEkraXhQK3hZNzVobTVjYy8xZEhoK3RN?=
 =?utf-8?B?ZEl0d3FFajkrZUZuc0EwbWJEY1Z2R0o1eHBGY201SUVJM2xIS1NISGxhQWhW?=
 =?utf-8?B?UzF0U1RURkp2MHY1MEEvYWQyUGZRSml0blhKYjN3anl4NnFaczlXQ1k3V1Yw?=
 =?utf-8?B?WTN4SFFjWmtUaW05ZXdxRmpDMEpHZ285S2xYZlJIUVhncmtJNWNzaUZmdm9F?=
 =?utf-8?B?dUxuK2ZYdGE2SVUxaHlpU1N3cEJYOEt5UnFtdWlpdU1wcWJpNUlPU0FKemlL?=
 =?utf-8?B?Z2kyemlncHNDQ1hRZk83M0dydnFvMkFLWTNyRWpwTzVUcEF6bHNiaFh4NDVQ?=
 =?utf-8?B?VC9vTE15dklFQVd2VnNHczlVRmRNWDJ0QVpFQ1hpRS81WUQ0RzdTTEJLSU9t?=
 =?utf-8?B?bS9LTjU5ckxXU0tzREw1V1FzOTlzbWtnZTF0VWREQmFjUFRUdHNtS0VkdU9Z?=
 =?utf-8?B?S01SWGdWdW9UMFIwZUYvVWJFZERrNzBmOUpIQWJHQVJlczdJNjY3ZGZpd0V0?=
 =?utf-8?B?ZndCMkNiWVRra3FSWjVYTjkvSXAzNld2SDJJS3BWVzZ4REkzcXdKUFMyY0dq?=
 =?utf-8?B?djEvZ3AzdDA1TE4vVzZvTDN4THVPUEFVN0g2TWRMR3hTQXRMbWUwc1d1dStV?=
 =?utf-8?Q?FL9p7ucmw1gneVpGZchTw5U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 998efc3f-120f-4dbf-f578-08dd6f43dbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2025 04:32:19.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQEkb/7OvF4uvXSCMyxynRnqRqAjVHm0TRLQm12w1RpkOOb9ZGOd+CDtq2ThkfXAjkWwerge3sq0pEc6HLdrQd+JH93/gckbBWH6L5DErwpqNg1y2WC3WUqy1TnxQ+HB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4887
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VzdGF2byBBLiBSLiBT
aWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgMjcgTWFyY2gg
MjAyNSAyOjA0DQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwu
a29yZW5ibGl0QGludGVsLmNvbT47IEpvaGFubmVzDQo+IEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0
aW9ucy5uZXQ+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEd1c3Rhdm8gQS4gUi4NCj4gU2lsdmEgPGd1c3Rhdm9hcnNA
a2VybmVsLm9yZz47IGxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
W1BBVENIXVtuZXh0XSB3aWZpOiBpd2x3aWZpOiBtdm06IEF2b2lkIC1XZmxleC1hcnJheS1tZW1i
ZXItbm90LWF0LQ0KPiBlbmQgd2FybmluZw0KPiANCj4gLVdmbGV4LWFycmF5LW1lbWJlci1ub3Qt
YXQtZW5kIHdhcyBpbnRyb2R1Y2VkIGluIEdDQy0xNCwgYW5kIHdlIGFyZSBnZXR0aW5nDQo+IHJl
YWR5IHRvIGVuYWJsZSBpdCwgZ2xvYmFsbHkuDQo+IA0KPiBVc2UgdGhlIGBERUZJTkVfUkFXX0ZM
RVgoKWAgaGVscGVyIGZvciBhbiBvbi1zdGFjayBkZWZpbml0aW9uIG9mIGEgZmxleGlibGUNCj4g
c3RydWN0dXJlIHdoZXJlIHRoZSBzaXplIG9mIHRoZSBmbGV4aWJsZS1hcnJheSBtZW1iZXIgaXMg
a25vd24gYXQgY29tcGlsZS10aW1lLA0KPiBhbmQgcmVmYWN0b3IgdGhlIHJlc3Qgb2YgdGhlIGNv
ZGUsIGFjY29yZGluZ2x5Lg0KPiANCj4gU28sIHdpdGggdGhlc2UgY2hhbmdlcywgZml4IHRoZSBm
b2xsb3dpbmcgd2FybmluZzoNCj4gDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL21hYzgwMjExLmM6NjQzMDo0MTogd2FybmluZzogc3RydWN0dXJlDQo+IGNvbnRhaW5p
bmcgYSBmbGV4aWJsZSBhcnJheSBtZW1iZXIgaXMgbm90IGF0IHRoZSBlbmQgb2YgYW5vdGhlciBz
dHJ1Y3R1cmUgWy1XZmxleC0NCj4gYXJyYXktbWVtYmVyLW5vdC1hdC1lbmRdDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+
IC0tLQ0KPiAgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jIHwg
MjUgKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jDQo+IGluZGV4IDFlOTE2YTBjZTA4Mi4uNWQ4
ZjUwYTQ1NWQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS9tYWM4MDIxMS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL21hYzgwMjExLmMNCj4gQEAgLTY0MjYsMTcgKzY0MjYsMTAgQEAgdm9pZCBpd2xf
bXZtX3N5bmNfcnhfcXVldWVzX2ludGVybmFsKHN0cnVjdA0KPiBpd2xfbXZtICptdm0sDQo+ICAJ
CQkJICAgICBib29sIHN5bmMsDQo+ICAJCQkJICAgICBjb25zdCB2b2lkICpkYXRhLCB1MzIgc2l6
ZSkNCj4gIHsNCj4gLQlzdHJ1Y3Qgew0KPiAtCQlzdHJ1Y3QgaXdsX3J4cV9zeW5jX2NtZCBjbWQ7
DQo+IC0JCXN0cnVjdCBpd2xfbXZtX2ludGVybmFsX3J4cV9ub3RpZiBub3RpZjsNCj4gLQl9IF9f
cGFja2VkIGNtZCA9IHsNCj4gLQkJLmNtZC5yeHFfbWFzayA9IGNwdV90b19sZTMyKEJJVChtdm0t
PnRyYW5zLQ0KPiA+bnVtX3J4X3F1ZXVlcykgLSAxKSwNCj4gLQkJLmNtZC5jb3VudCA9DQo+IC0J
CQljcHVfdG9fbGUzMihzaXplb2Yoc3RydWN0IGl3bF9tdm1faW50ZXJuYWxfcnhxX25vdGlmKQ0K
PiArDQo+IC0JCQkJICAgIHNpemUpLA0KPiAtCQkubm90aWYudHlwZSA9IHR5cGUsDQo+IC0JCS5u
b3RpZi5zeW5jID0gc3luYywNCj4gLQl9Ow0KPiArCURFRklORV9SQVdfRkxFWChzdHJ1Y3QgaXds
X3J4cV9zeW5jX2NtZCwgY21kLCBwYXlsb2FkLA0KPiArCQkJc2l6ZW9mKHN0cnVjdCBpd2xfbXZt
X2ludGVybmFsX3J4cV9ub3RpZikpOw0KPiArCXN0cnVjdCBpd2xfbXZtX2ludGVybmFsX3J4cV9u
b3RpZiAqbm90aWYgPQ0KPiArCQkJKHN0cnVjdCBpd2xfbXZtX2ludGVybmFsX3J4cV9ub3RpZiAq
KWNtZC0+cGF5bG9hZDsNCj4gIAlzdHJ1Y3QgaXdsX2hvc3RfY21kIGhjbWQgPSB7DQo+ICAJCS5p
ZCA9IFdJREVfSUQoREFUQV9QQVRIX0dST1VQLA0KPiBUUklHR0VSX1JYX1FVRVVFU19OT1RJRl9D
TUQpLA0KPiAgCQkuZGF0YVswXSA9ICZjbWQsDQo+IEBAIC02NDQ3LDE1ICs2NDQwLDIxIEBAIHZv
aWQgaXdsX212bV9zeW5jX3J4X3F1ZXVlc19pbnRlcm5hbChzdHJ1Y3QNCj4gaXdsX212bSAqbXZt
LA0KPiAgCX07DQo+ICAJaW50IHJldDsNCj4gDQo+ICsJY21kLT5yeHFfbWFzayA9IGNwdV90b19s
ZTMyKEJJVChtdm0tPnRyYW5zLT5udW1fcnhfcXVldWVzKSAtIDEpOw0KPiArCWNtZC0+Y291bnQg
PSBjcHVfdG9fbGUzMihzaXplb2Yoc3RydWN0IGl3bF9tdm1faW50ZXJuYWxfcnhxX25vdGlmKSAr
DQo+ICsJCQkJIHNpemUpOw0KPiArCW5vdGlmLT50eXBlID0gdHlwZTsNCj4gKwlub3RpZi0+c3lu
YyA9IHN5bmM7DQo+ICsNCj4gIAkvKiBzaXplIG11c3QgYmUgYSBtdWx0aXBsZSBvZiBEV09SRCAq
Lw0KPiAtCWlmIChXQVJOX09OKGNtZC5jbWQuY291bnQgJiBjcHVfdG9fbGUzMigzKSkpDQo+ICsJ
aWYgKFdBUk5fT04oY21kLT5jb3VudCAmIGNwdV90b19sZTMyKDMpKSkNCj4gIAkJcmV0dXJuOw0K
PiANCj4gIAlpZiAoIWl3bF9tdm1faGFzX25ld19yeF9hcGkobXZtKSkNCj4gIAkJcmV0dXJuOw0K
PiANCj4gIAlpZiAoc3luYykgew0KPiAtCQljbWQubm90aWYuY29va2llID0gbXZtLT5xdWV1ZV9z
eW5jX2Nvb2tpZTsNCj4gKwkJbm90aWYtPmNvb2tpZSA9IG12bS0+cXVldWVfc3luY19jb29raWU7
DQo+ICAJCW12bS0+cXVldWVfc3luY19zdGF0ZSA9ICgxIDw8IG12bS0+dHJhbnMtPm51bV9yeF9x
dWV1ZXMpDQo+IC0gMTsNCj4gIAl9DQo+IA0KPiAtLQ0KPiAyLjQzLjANCkFja2VkLWJ5OiBNaXJp
IEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0K

