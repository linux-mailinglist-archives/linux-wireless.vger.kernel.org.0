Return-Path: <linux-wireless+bounces-27819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C94BB97AC
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Oct 2025 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25453A6F99
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Oct 2025 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89A2877E8;
	Sun,  5 Oct 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6F+xdkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538A28727C;
	Sun,  5 Oct 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759671413; cv=fail; b=Yi7g62ms8naDnQKfuizgRfJrAPeCSXwqRfNr9SB8NLjvY0hQryGsFa2eTrKV2E/C1nVKEsoF0gqh7sAD1G1vtgOeyky5oxWc7kEafvrhim7IxgWrO/9ZoAN1yaw6KuDt/ynXXikoGfkXUcEv84NV6GAscNYXcBm7gtkKF8gIw/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759671413; c=relaxed/simple;
	bh=DnGei9H8eJmnBgeD1kLZFi235NyeSVXgzvNCSuUxk18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNYeqgUteUMNIlGFcpNFEX5wVgIXnNf7WZDYw+VB+o0+RW5Al3+EJ1GMQM+MbrEbHaNr+Flnu/T4cDib9oTzI3/rz1Php6bbmj6BjFptqWYLXY/fgvFFOvjzrOEfK4zkQgrFhyJIzGumjpaQD1gjraXZCShrHumtannZrtjtlP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6F+xdkE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759671411; x=1791207411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DnGei9H8eJmnBgeD1kLZFi235NyeSVXgzvNCSuUxk18=;
  b=c6F+xdkEl1l5Sd+wD3F+6BFNJw0MBWJn9zPhLjDY+RSVJ8OgxRpC9lib
   /1nHQEIvi7dl63/gWziTqRKg1LA/Qio2IfjG8zUl5quTfqTSqn/JElxaC
   FgzhxBs05ycni6M+idq+r7B7GGHCRGiJlgrUAzVinRxGcPve/Cowt/Tyn
   4GLZyo0y0/tNXNBi7/O9V5dPxIc4c15uQeA7UJ647ExT5JIh2q1oaKOdb
   I+Kf6YB3n46qgJqVNJMbQzfcFT7/4Tcl4RkOQ0kUz6dLP5LO8K6vJ42+w
   YpaZUnn2umRufbQh/ZO0xVA0tbi5QYQ6iZRgz5P8hPBg6ax0HNcZq2MIL
   A==;
X-CSE-ConnectionGUID: XTKtGvQbTaWfxgtJ8W22Dw==
X-CSE-MsgGUID: qQOtzvB3SK2EKcMz+H0/wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="64492505"
X-IronPort-AV: E=Sophos;i="6.18,318,1751266800"; 
   d="scan'208";a="64492505"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 06:36:51 -0700
X-CSE-ConnectionGUID: XrIvV5VzRSaJnKFqUaDRNA==
X-CSE-MsgGUID: Nm9wfSy9SDyBG1Xe5zZnKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,318,1751266800"; 
   d="scan'208";a="183962680"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 06:36:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 5 Oct 2025 06:36:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 5 Oct 2025 06:36:48 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 5 Oct 2025 06:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4vhEQU9UHrP9zdgXeDDRFncZEJHO0XjrT9ZQXGM/KnOFkAMB23+IPb3+3KAe3CgtjwTItACEU1/a2BGKom6n74pu3W4xEk0b9yYDvUYmAkDyUE+42bWPwUMbik/l0NyY8T5hMVMI+N6MyPeprG0iss7BzZuZQuv4lfY/uljE2f9UBYqqJlXBYA40ys3byPiPObyVNkDIWsPpcwQ73NDLRBN0CbwSUpRq8+uYiiuK0DvqNhhIFjOrd5tZXcRqlfVsKn6wsfCf9H7Ie4DBmKeazlt/Ft6C8imfzUov5t4tSE87Y3AE+iOvZQ+110hBuPq+Ov3creA8ufPVNYO+sj4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnGei9H8eJmnBgeD1kLZFi235NyeSVXgzvNCSuUxk18=;
 b=c1rttJXF2pGF2E1rPk1u/pk4Uic1kck7w/w2D9CVcaiGaYRS5CiZKa0odPp3UDz2sYByWbmYZGxvfURi0ltoD4u3FQ6G5VfQeRTiATWMaL+BVA5hQr7mK6eGrYMnXQs3tXW7M87wmqS5gxB+kZxkEtrAH1Y2wd9G18asTR6LL1XuFxqMTgReKFq63UD5EXy4yE20oNgf83qKFmoHU/sVqt3JCsnMqKYO4BwGrNoOdqbR5NPrXiVngEihWzRx7qqe2sSN+Py3L2U1ARhvrNZ3GcDXP1QrwNvO7PZxtW+ND7rPt3p8eMSFl8kUs4cjpYwhYK7KvaHvelunBPXG2YFjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by BN9PR11MB5289.namprd11.prod.outlook.com
 (2603:10b6:408:136::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Sun, 5 Oct
 2025 13:36:42 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9137.018; Sun, 5 Oct 2025
 13:36:42 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan"
	<ilan.peer@intel.com>, "Gabay, Daniel" <daniel.gabay@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
Thread-Index: AQHcNTlm+VnB67gfYEuELYoxWi9tT7SyCSiAgABvtjCAAMNrgIAAFz8QgAARxgCAAAEkgA==
Date: Sun, 5 Oct 2025 13:36:41 +0000
Message-ID: <DM3PPF63A6024A92B862A68F1EA07192752A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251004141539.6512-1-brgl@bgdev.pl>
 <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com>
 <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=McJ649k44-Y9ugjq1-xKX9QL4c4MX_LeYs12N1SD4D7_g@mail.gmail.com>
In-Reply-To: <CAMRc=McJ649k44-Y9ugjq1-xKX9QL4c4MX_LeYs12N1SD4D7_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|BN9PR11MB5289:EE_
x-ms-office365-filtering-correlation-id: e35a4f72-14bf-44c4-99af-08de0414380e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SWFKUUo0b1ltcGNPa1IyTGhSV2ZsRGhWSU9CV0p4R0piUGpyZ0ZTYnJlTGtC?=
 =?utf-8?B?YW90ajJkb294Sm5wQlovMGFDZDBFVHJycy9ybmZOamtoZWcraEY5WDdvTmx5?=
 =?utf-8?B?Z2hBVXc5TDdDRm1EVFFrTzRwYzNPYnBqcSs5N2l5M2ZLMW9Za2pReGpJMnZz?=
 =?utf-8?B?eGJScnZkU2ZkUVd3TkorZU1KdE16dmNSRXYvTVRuQTdyT1A1NEJGSjQrRUhj?=
 =?utf-8?B?aHJZOTZ1ZXFFU21mRTd6OGJPbXhGSGxEUU8vUU1qazI0NmpxYm1uMHI0QnpE?=
 =?utf-8?B?T0ZMaUNvVklPZVFBeW53UzZ6THBBQkxsZmI4SVJ4NVhjV1VCSURWTTFLUEQx?=
 =?utf-8?B?R1pKZXZnVXBQYzVZbzRCUlVTMzN0Um9INnZzanVjUzRkVVhmZVUxYndxR2pN?=
 =?utf-8?B?WmJpSnNyWVRtRnpsT2ZyS3FVRTZDR0tqaU5aa1FQQXRxNVlNK3NtbjE5c1Y0?=
 =?utf-8?B?aWIrQ1l3TXE1d0hCMW5IS3hoa3VmdFovQ2FaYkxwaG5tdVBpVVAybWQwZG5S?=
 =?utf-8?B?ZitPY0VaeGxnMFBHaTZ1dmtRYmNJK1BMdS9CZVkyL1pIeFd0RTBFc3Z6V0dE?=
 =?utf-8?B?Z0VVZXlQZkk5T0ZUY3Y2dkJHQU1wWEh2dnFIaXBzM0ExdW1zWTAwVitFL09w?=
 =?utf-8?B?U1ptZERIMCtqbmRXQ0N4K1JualJVNENkMzA1U0doWFowZjFWWkZBdDJHcDZn?=
 =?utf-8?B?Rmp0a2xoQ0lBczdDcWd0Ny9jTzBSaEkrVGVibk9td2hVb0lPK1locG54RXQ3?=
 =?utf-8?B?T293UmdHdnZld3J4Qm5IYlM0QlNra2I1KzRYdCtIbVZER1VqT0tzY21xT2du?=
 =?utf-8?B?eCt6bnBaY0JJelFUVXpITzQ5aTk0cmhxUUVDZ0c0Nm9Ca1JMWlZyTVRIUWZu?=
 =?utf-8?B?OEhiUllPd3U4TEl6UnVlaVVTYmJFK3dsVzF5QWt0MUtXdlI0SmJvOHpxNm44?=
 =?utf-8?B?cjQwRFFSa0RBSThDVGgwY3gzZTNIZkNRUWRYbk9mOWFvVU1TV28xS0pzNkZs?=
 =?utf-8?B?M1ZHZWhuUlNxS2diZ1BYM1poYndNOGNZbVlvYjB4S21rR05wMkJVdmhjanNN?=
 =?utf-8?B?S21LemVOaDdRbUhpbDBYazNqUkxSK0Z3eXRNeGxLZjRqT2Zmck5jcDA5RUl2?=
 =?utf-8?B?MWovN3hNVFd2SUI5NkV2L1gyeTZvOERKYXdueXBIMlgzOS8xa0RndVp0OHg1?=
 =?utf-8?B?ajB6T3E3K2N1NW51bDEvZXpBRTBhRHo5UTNVM1BMVFpEcHhUdkRZN1dlbWhF?=
 =?utf-8?B?S3phVnZzNHZqbmxqRThLcnc4VGprQ2dDVGx5N3NaNXlRZGdTQ3lSV0Z4YmNL?=
 =?utf-8?B?V21DZEJ3bmVuTkkzNU9TbFNlWC9KQVl5eGk4blU3ejVIVkQ2MThkUzErZlhn?=
 =?utf-8?B?aldKK3JsQ3NaSTBEMUc2WWRLTlEyYmIzL0c3YVdDMzZQZmxhZ0xQRUk1MVh4?=
 =?utf-8?B?cWllNGU5VUtEZmplYTBGN1QyWnNLVTN3TEkzamE5dmlpVFcyeDh5MUxsSDBi?=
 =?utf-8?B?UTB6T0NqSWtiZUxNSVRPbWx5cXNPdi9JMFFJT21aTngweEVveDlOSjN3OWta?=
 =?utf-8?B?RjJieHVpSjZLYm1TcTN5OHorUzgrUDB5ckRqK2NpTytzMVB4a3REalN3bngz?=
 =?utf-8?B?U1lvYURFNUhBSWN6VXFJYlBSNXdWZ2YvTlRGNUFjTUphdHgxVjNRcS81NHl6?=
 =?utf-8?B?cGxoUnQ5VEhZQ1pFdXFGdSt4ZkpmV0R0ZkwvQ2pnNFNYSHdDTjZpYzA4YnVW?=
 =?utf-8?B?d2F3d3RyRWQ5VmgrdjUyd0xQK09MdUVMVjl3VmJyR043TXRpT2RwMDhzU1B0?=
 =?utf-8?B?QTRnNi9MYW1zeC84Y3NXYmt5Wllib1dXSDZWR2FHNG5CZ3JHZ1BRT3NoSUV1?=
 =?utf-8?B?c1VoOGZqTmxxNkFGamxUV2VDbTdWWGJ5Tlc5dEFQa0E4OVFWTDQ3R2pTOWlG?=
 =?utf-8?B?cnhzTDFyMUJKSjdZK2pobml2V0hKOFdSZTFScGR1Y0p5NGk5dHJOWWVLVHJX?=
 =?utf-8?B?WGpsNDlncXFETzA3MGxObStzK1g1clVLMEFPRS9xUm1XVXU5R3JqUSs0K1Rw?=
 =?utf-8?Q?VqX71i?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1FWbEhMZTYwTm1JZEFLVjZmMHZzOXQyNWZ5YktmOERZaldSZWpLR20zUlM4?=
 =?utf-8?B?ZGs1Q1Zabm5DcEIyRmtFY0w1ZmppY3lRUThvVG1UVzhIMGRGTjEwUlhiOXls?=
 =?utf-8?B?cVZOMFRYNGp3NisxblBxMitFMFJtMXFSNWQydi9nbHNIMWlNOXhzUzVwd1FD?=
 =?utf-8?B?dFRidmV5VEp0NUVrYnk3SHdCbzJJalVUS3hNd1R3UHVRY2QvdWE0VXgzbStR?=
 =?utf-8?B?RzQ4R2FXMVk0N0dFVi9sYkgxWVVoK0ZOVVhPS2xVU3JwSlZFeTJ0Y1pRV2xG?=
 =?utf-8?B?b1pUaDVPNlJUS2d5a1pseHE5Z3o0SkJTQ01raGdFYzdtRSt5b1hVOFZNVnRh?=
 =?utf-8?B?Njh5MTlZRGw0K0tjSkRjaTVyQktOWnh4dzc3RTBiaGRuMGFKTXpoRC9HeEdj?=
 =?utf-8?B?WHMyRXJQQVZsZEg1WEFFNWIwK3F4ekRtUnJpZE1xSXB2VWZmZnRzYUFyc0Vs?=
 =?utf-8?B?bmdSeW1rSmI1S3ZKUElSQkwxM1NObkdISmVteHNrdEVJNHBRZWZjTm9GaDRH?=
 =?utf-8?B?d0FiWmhFMnZJYmZ4a3hucm5zNEliSWRZczJxaWRiSlJNbUtFS2hveDcwWXVn?=
 =?utf-8?B?NEFSRytsRDRGRFI5ZFRJQWhUc3BJejFZZDRKcVdDYnNOczROZ2VOWVdjTEpR?=
 =?utf-8?B?OVUxNWNsQk0yQ1JMaFBWSWVRZ05XNzAvYjVtSG0ramxqeUdPV1FLNkNoMzB5?=
 =?utf-8?B?WHdOMGo0UWhEeFhwR1V1SEQxM0YvSFEzUGI4VFY4dnB3Z2dWZTRvd0JFM3Nx?=
 =?utf-8?B?MnRydytMNGdNQTNpOThJdDVBUFZ1bXZrK1ZwUWlLWTJkNVVTSExEQ3YxZEtJ?=
 =?utf-8?B?enFQLzZWQk1HdnA0blg5WlQ1MmY4OU10L1JNQTFRcUlzYStjZTRST0VLaysz?=
 =?utf-8?B?MXNtUmJkRzRwSjZhN2lCanZQQTNMQnM5K0hsT3dOOURoVFY5OFBMY3FrZk5m?=
 =?utf-8?B?UW9TQklXMHhqVWd1cHU1VFJwL2FkRVRkWHMrUzhxSS9CVXQzNjNMY2NwbFdL?=
 =?utf-8?B?cU5xZEUzVmo2S2NNNjNncGIzT1FZK0puV1lEY0Z6aEtOdEJ1S3QwMGlGVFor?=
 =?utf-8?B?QlJlcEQ4S0JqS0RwYmxKaTBOOEU4b2liRElpZGtlTFFzOVIwY1NXSXlRZU54?=
 =?utf-8?B?RGEwTHhIZDdaNktrOFNOYk42MjBoejg4c29XZW9Gb1JraUY1UUtENnNOZCt4?=
 =?utf-8?B?QWQvMjFYcVF0MnVxZytRWEhEWE5odFo1NDFpNlh5dEh0NEJ1YW01UFNZbFVv?=
 =?utf-8?B?RXlleWpDQUtpY29HVytrRkhjRXNkNEtWTUdFL0xyVms3SHRObisrVUFheDBk?=
 =?utf-8?B?WmV1M1FPUHJrYml5UFJUSXZFMVVSazZVSzZEYmo4bERLUmlLeHFXZFlQcEwz?=
 =?utf-8?B?ZkhjODJGRW5rOGl4ektlaVFNdzlRYjBDK1NaRWNWeG5TNnBQMCsveFp4SUVp?=
 =?utf-8?B?ZldzbURwSzVobFhCQU1VcTVVb0p2ZXhuYXVRTXREdUMyQjl4WFQxNm1YRTZP?=
 =?utf-8?B?bTE2a1hXTnRERi8yY2FvSzhqWHViVzYxWE80WWttaGowdmRlb0ZCbGwwYXpy?=
 =?utf-8?B?Z2hTVWNoanNUL1RuOUxKSWIySEoyZytXQUVZdEMvTTNDdENFbW4vNElxSkdt?=
 =?utf-8?B?T2lrTnVWQWJnZEhRZkZPby9tMGZmWWtFK3QwNXpiWHd0RXM0Z3NqNmUwSFNS?=
 =?utf-8?B?N1oyR2loTHN6cy9uc3lnMjd4S3pYRnBhWG9PcSs2SWZoZzI0dVlhUnJ1RkdJ?=
 =?utf-8?B?K28vaHY2N2ZSK2U2RkM0NlYwRlVWWXlnMXAzOEJuZmgxMG9PVGNqR0lVM1B1?=
 =?utf-8?B?dDJBRkdDQmJuWmNHVjZldWt1L2hxVzlGUWhzdVcyVktHd1U3elBiUWRVUWV4?=
 =?utf-8?B?RnlMSmVCaTBsM2NFdlZhV2NIT3ZjdlI5VmRONmpmaGhFb2U3ZnN1MnNVRWJB?=
 =?utf-8?B?VDAzblFVdHIxUWtBa2xUekRBNEZ3NFBGZXBlRS9jZ1Z4MlE0S0NVNzVmUTdl?=
 =?utf-8?B?dFJCRVF3RjlSaFRpSXRYVWM2SVdvYThCbytYMFNvWFgrTjN0VzZnd2wvbGlV?=
 =?utf-8?B?a3llanNicXllRUs1clA5NEt2VUZxb2JLQlJNKytJWVVBenR6bHF3eEt6Nm80?=
 =?utf-8?B?NHI4RVJqRUwwOTNoNTJ0V3lFajJsdUdaeDFLeUljT3RwYVpUSTZUUVE4Y09X?=
 =?utf-8?B?RHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e35a4f72-14bf-44c4-99af-08de0414380e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2025 13:36:41.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Elnn05m6sisDAQyvVEPSYy5a1m93g7k52XLowq/+dIDcUvKZ455dXS8eRKbOlW1EqFRsABV3eQJEZevH6H9y3vmXupXqHN+fUUHGGPZi/KCIxUtprd2eoOfJKaLVpQY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com

PiBTbyB0aGUgODkgYXQgdGhlIGVuZCBvZiB0aGUgZmlsZW5hbWUgaXMgbm90IHRoZSB2ZXJzaW9u
IG9mIHRoZSBmaXJtd2FyZT8NCkl0IGlzLiBCdXQgbm90IGZvciAiZnJvemVuIGRldmljZXMiIC0g
bGlrZSB5b3Vycy4NCkluIHN1Y2ggZGV2aWNlcywgdGhlIEFQSSBudW1iZXIgKDg5IGluIHlvdXIg
Y2FzZSkgZG9lc24ndCBpbmNyZWFzZSBhbnltb3JlLA0KYnV0IHdlIHN0aWxsIHVwZGF0ZSB0aGUg
RlcgZnJvbSB0aW1lIHRvIHRpbWUuDQoNCj4gTm8gdGhlIGZ1bGwgdmVyc2lvbiBhbnl3YXk/IEkg
d2Fzbid0IGF3YXJlIG9mIHRoaXMuIFdoZXJlIGlzIHRoZSB2ZXJzaW9uDQo+IGluZm9ybWF0aW9u
IGVuY29kZWQgb3RoZXIgdGhhbiB0aGUgbGludXgtZmlybXdhcmUgZ2l0IGxvZz8NCg0KWW91IGNh
biBzZWUgdGhlIFNIQS0xIG9mIHRoZSBGVyBpbiB0aGUgZG1lc2cuIEZvciBleGFtcGxlLCBpbiB0
aGUgbG9nIHlvdSBzZW50Og0KTG9hZGVkIGZpcm13YXJlIHZlcnNpb246IDg5LmU5Y2VjNzhlLjAg
dHktYTAtZ2YtYTAtODkudWNvZGUNClRoZSBTSEEtMSBpcyBlOWNlYzc4ZS4NCg0KTWlyaQ0KDQo=

