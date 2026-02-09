Return-Path: <linux-wireless+bounces-31660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFTgJ5CbiWkv/gQAu9opvQ
	(envelope-from <linux-wireless+bounces-31660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:32:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826B10D035
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 09:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6C2C30013A7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B3309EFB;
	Mon,  9 Feb 2026 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H14wfBxE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB9280A5B;
	Mon,  9 Feb 2026 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625930; cv=fail; b=HKIN/dqjWbYmZCG/79DJ2I92karq5/ZRFBOX1TC+7ihxA7IBlV3DsyuxShqwoe8ckS/cdIoIEhc3BwakBHRoPs23bsyF2DOHoWfLT3QmI6ZtCTfwdkl/h8PnLndjGqXSpWkqUXdcthZ2ofeMxvLTh1wkk38b2VMz7dcq6Ag+NiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625930; c=relaxed/simple;
	bh=va3kvt0fk3xOV6289wicCic4NB1pU3QoVMlTPovghag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hv2ixSL+FsRrjISOFVAHbjEwfmrfYsB4z/E0a3mIJC25MurLCIwlUc81QLTfGldxK0RLz4rYmQTVZ3+EOyp4C5UFGlWfRHEKcA0Rmx6EgiPUSbg5zwLFtU/m7b4ljJZUL14WozmqUiLqSFnUE/lvV2IpiLuJ2drcAg1hdRVf3l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H14wfBxE; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770625930; x=1802161930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=va3kvt0fk3xOV6289wicCic4NB1pU3QoVMlTPovghag=;
  b=H14wfBxED1Tqh4VMX5+TequESiHYZQxxmBNW68BwjOltv2wf9boInxL6
   4bJ4OmIaN6b5pCv7f8E/4HC2DlyWaIbK9S6roo+JiuAd/2ePlxrQDb56L
   W2mbS6nRC33dX3iSe8HtZFjKT/29SvX1Wh3VmAzBiYwaLhxT9XfEvruou
   dn69d/EfOsrTlILZIIbwB8GPpm6YMWM/bfC8QiFMsntOBmIWSMrQ8412m
   ILpGn4/LYHHhWte9fJVPZc88zF3yLfrvEKg8wpdLfPLcS/VQju69Gi8kj
   frSXZkixbAXN4bmK72AsXYc1jGAYRC6T9s0//H+o3PmwIjf98HXLRiNJj
   g==;
X-CSE-ConnectionGUID: K/PQD4vxT7aQtOqOZM7Qkw==
X-CSE-MsgGUID: DIn+zv3PTzGoWb/Fq/tY2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75582370"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75582370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:32:09 -0800
X-CSE-ConnectionGUID: 1itfhP2cS0uK6ed8tsFWbQ==
X-CSE-MsgGUID: QtE3P/wuR+G2noDHvobZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="234456883"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:32:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 00:32:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 00:32:08 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 00:32:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foa2NWzHnAFF6kYBNmjdognc7GZGq/tn5PNqzDdMPUUj/Ay85c4vg3ch9YY3Hz9em7Ys/yNGHl2cWYNV8zfp2RLSgDs0GoJa9doc4J8zAE70QmaU3yWuGmQnVmmqxTG2g9Ypc+FYImfQoYc9mENmln6+9U+cVHlwprWp37ozTd6hzkUHr+J/lMs7BTVpt/dcaTzyFEViJ2RHFJkR6D/hpVq/uzWvsgBMvjkbFw3cc+nUTcjtCxQy1cqny/FIxJgqalZnnHzjhGcKpkg36NY8QRw+6l53TrFX25HKVMmEo7xuQpPmaAnxwXSgGn3D2/+84LVtkveG/VHJVLX5lzkcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va3kvt0fk3xOV6289wicCic4NB1pU3QoVMlTPovghag=;
 b=DZsXaDW1ttd43sOK/fy26RN3ne8QbvztnnAHKMYidEoXscPswc3aLNdhZLTtI/RV6q+R7vY5wVUxUcVcT7svcfvTccgKv0dncLjJFUeFZWDbHdyN0RxvMlz1Th3J7n77+eMr0Wn/Rw3zUiJRlYXv6JWWGUpmMKskyrx0pwCt9ZdQToiarPxcn47UfNLsDkkzz+Sf1cPi/rmI0UpI5NRu5dzTVOClOIb+h8OY3ewB6n0Zu73rai5RWdoVNuaPv8u8n3toOp2czf+l/oy4gtDxt6lws2L1tFpytYuR5VaYhBh2L0R/0RxV3LaLGEn0MgM/U4LzSejDty6J/CaYDLt87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:32:04 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:32:03 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Cao, Junjie" <junjie.cao@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ben Shimol, Yedidya"
	<yedidya.ben.shimol@intel.com>, "Stern, Avraham" <avraham.stern@intel.com>,
	"Gabay, Daniel" <daniel.gabay@intel.com>, "Prabhu, Krishnanand"
	<krishnanand.prabhu@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: ptp: Fix potential race condition in PTP
 removal
Thread-Topic: [PATCH] wifi: iwlwifi: ptp: Fix potential race condition in PTP
 removal
Thread-Index: AQHchjo8VSWQf0J3kUWZz/ysb4h8arV6MGKA
Date: Mon, 9 Feb 2026 08:32:03 +0000
Message-ID: <DM3PPF63A6024A9E1EF4081E342AF4BED81A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260115161529.85720-1-junjie.cao@intel.com>
In-Reply-To: <20260115161529.85720-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SN7PR11MB8066:EE_
x-ms-office365-filtering-correlation-id: 7bce35e8-d33a-4998-d22f-08de67b5b3e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?YmlNOUFMSWU2WFhpV2I4Qm9TcVNWTXFjaHZDcGVCWndoUjVvUU5iY0lOQWlZ?=
 =?utf-8?B?QmZsSlVvY2NieVExWmw0NEYrdWRHVkZkdW5JcjEyQmo0RnJ5b3dvZjRPK3Ny?=
 =?utf-8?B?LzRuSW5ZRVNGUDNBYVM5VHQwUFVSVEI5bGJsaFlhNklDMVgrRDM1bWdrcGQ4?=
 =?utf-8?B?YnZGdTdYWmNQaVJ4UXZCZm9OTjR6NDR6VmZEUFN3ZXBrVXRDYitWeVlZckxu?=
 =?utf-8?B?U0lyTDgxT1JuMUtleVhlNHYxSTQ1NjlvRFovaHV4eTByTS9UaERpQWUwb3R6?=
 =?utf-8?B?ekNmcTdnUnZhZXBNbTE0dnVNSVIycWFINXlhZWRYeGFCS1RRV2hnMEZTNVlr?=
 =?utf-8?B?UmVsa3RUejB6Ui9rQTB6dGJxaWI3K1J4L2hzUkxGYllnaHYyWDBQc1FIWkxz?=
 =?utf-8?B?blluelFWTm13OGIzN3NpRDBGSWFrdnRSZmdzN29GWXg3TklKdnV1YkJ1TU5t?=
 =?utf-8?B?TnJpQzE4dnhqK0NmejlEeDN1Q1JkdmlWK216cjBFU05ST1lNczFybElPLy9p?=
 =?utf-8?B?RVQ5c2NTVkhWQWMzNlZQb3c3ZFdtWWo5bFZ1aUptamdrUUZNTEUzMm14bEZ6?=
 =?utf-8?B?VGVaWFFCVGhUS1VLS0RiT01vREkxSmVrNDBXRzhUQWViWGRkOU9nSUhLZmdG?=
 =?utf-8?B?ZVF3VUlDL0JERkdrVHROcU9HeUhFMjBtYjNqK3g4WGNRMzNtdlg4QnFHYVlQ?=
 =?utf-8?B?V1hWUjNWb1FMdFpIbWoxTTBSbFEydm1aakM2UEc3L0dQZGJvRTJVYkxGSm1D?=
 =?utf-8?B?QSt1RnB6SFBzWUU3RURPSnBEdjBnV0p5MW4wakpBa2ppU29Pd0ZEWkpJYlFD?=
 =?utf-8?B?Rjh2dkZGWkxDbjhrcEk1VHY2eGg2eWh1VDByYzJ4REV1eElZbTNFQ1JaZkVt?=
 =?utf-8?B?WkZ2NzlQTDJFNDZzZEpCYjhlZWpDdDlHZTlHdWhKV2pCN2hxeTRWRFhrbHBj?=
 =?utf-8?B?MDgzTVlsaWYrZXNOdElXRExudG9qOE11M29JUXozSGtsUXhvZENmY0pJMmVx?=
 =?utf-8?B?anc3RWVPTEt5dyttQk5NQitHUC94MUhyZWIxYnE5L0Y1NWxMU1dSRmRSd0hD?=
 =?utf-8?B?Z3VYVUxGWHJqRUN6bWJXQlQ0U0JZbGc1ZTVyT1VIVFpjNHFZNkU0TWgrT0N4?=
 =?utf-8?B?MFN0a2FIZlFIVTF5azQxTGZma2hzV05kT1J1VzNuanJGeWZydndvejZqQWls?=
 =?utf-8?B?NHd4ZDRudHhISlJFSjYzZkhiZDVDd0o1YTBxZDh5a0lRVTRoWU8ybkJaSWdE?=
 =?utf-8?B?cHJtd1pQZ2hBbmxEeVQwMEU3SW1RMkl5bkhqN2k1SC9MRXRVR2ptMm9nUFN3?=
 =?utf-8?B?dVZUUTVhU0N0amEzajlqdVY1dkE5M1NmakM3UHlQd2ViV0ZudXU0aFg4TGRT?=
 =?utf-8?B?aWJDMDc2YjUwTnZjbWkzUzMxTDF0L1hXZ0IvckpNeWRYZ3JXZVNUTEd1SHVD?=
 =?utf-8?B?ZXllcWU1cUVkT1lYaTZTVTBLN0duNWlad1lNUWJQVVF6TVBDWkZjN1BwaHpQ?=
 =?utf-8?B?TSs1K2pEV0JCM0lGS1JnMm42UGNIcVN4TkRhNTMzYWs4SERZcWs2Vkx6VDFj?=
 =?utf-8?B?aDVPVHFKc3RCUW9TQVk1RFgzSlRpMU4rNnFBakJKTmlGNHB3KzZTc0xyaU1x?=
 =?utf-8?B?WUtKNVRpd1lsUkNDT01UNFFvcVlYbndKV3QrZEVLOTRmOG93NFQ0MnM2endw?=
 =?utf-8?B?bzRmUkpqcG51dTZuMG1FY3pWZWVXQmJlak5wWFUvMTRRMG1CQkJwUUE1OUVp?=
 =?utf-8?B?RWxHY1JrSWJzNDBwMkdIVGJUKzl5ckRoSmlkNXZYS3RkLzhFNXE5eDRmeWFp?=
 =?utf-8?B?MG9zN25mWUFHOGpnZVd3SjYzUGFpUmcwbCtMcU44akNVR2FWL2d6S3dsdVhZ?=
 =?utf-8?B?WkZzVWZaMFFTSkFRWFJIZFBwMndsaFlJSVVVa3E1MDkxcmlBbVlBZ1RldEY4?=
 =?utf-8?B?b3pjZFFOeGZiZUdGVjBzeGw4UmpDR1Y4eDY3SUdETEIvcEJEaDdpUEpJRjZP?=
 =?utf-8?B?ZjU3TFhnMWtEUUZMajBMWmpYT0ZGTVdoNk01T2dkU0MxZTJCdmdrS1hNNnlq?=
 =?utf-8?B?eklDenBIRlh6bTdKc2d5ZHYwWjBFRTVueEk1Q3FEemwraFVDZERyam1nMk9P?=
 =?utf-8?B?dVo1VlZONGg2MC9JbGVPQUg1cmFSZVY2Z3VIWnVlUjYzOXJTb0FWcVFGOG5G?=
 =?utf-8?Q?jj9SBACsHH7hKr58U6NahsM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXowZE81M0lDZnJzbStPNUN4cm5VLzZpUGY2azg0dXZsbElYckRZeC9Id1pF?=
 =?utf-8?B?N0hKTmpWb3hLVkVMVDduSU9USk1TeDAzdXV5QTBHVFBUVmg0ZmJ1SVpqWC9n?=
 =?utf-8?B?UU9XY2UxanFNM2FILzF3YlVYdHFSVEp1bDRldVlBWFdVTlJSM2VpRHVqaUtK?=
 =?utf-8?B?VWpoN2pQVmNlOTY3R29TdWxZWXZ3Z2xqTzA4NWtXRjdmSWJKVXltVFRyckx5?=
 =?utf-8?B?eld2bE9IbzNBa3ZmRERpd2NsTS95VlV6cStyUTJ2cjZHTGtLUTJJb3lOZk5K?=
 =?utf-8?B?VmgyS0lZY3doWisyWmFCTmdPSlRsZzJ3ZHU1QTNBL0lDM3NneVhsdkI2d2dL?=
 =?utf-8?B?aVZ4bFhoa2l2cHVzNk1LWjRzSC9paS96eWhkODFqNDR2bWVjYXg2NW1ka3pC?=
 =?utf-8?B?SUVQQVdLQXFzUVJnTE1nMk1mSEFPS0h5OHVrSlM5cEFuM0o3WHhUU1M2MXNR?=
 =?utf-8?B?aW82SGM3Y2Z1SkdpekhQQVM0UE44UmV0eGw1VVpKZUMwT3pEMGc2emlMaGFh?=
 =?utf-8?B?NlRydFh2Unc0bHFmQ3V2c1BiZXVWdkJsYjlhV3MwdVN2WVNPblJyTmkwWHRY?=
 =?utf-8?B?dlVqTVMxS2p6QkpXY1ZZNVE2dVhoUG9jSkUvRVM0Mnc3eG80bEZWK3FTeVVj?=
 =?utf-8?B?czRDNGNvQXBwSHNlbkxwQlZtMzBJZGkxcEpIdG44L29qN2xxTko4MmhNdUxj?=
 =?utf-8?B?aldNVzNkajMzdkxoWExnT2NLbnVwQzBuSGROTHh5NEZPNXZPYnFSbFhRcXdW?=
 =?utf-8?B?endCdXoxVUxGMDVYNjVQcFlmanVVN3ZXVDl6WXhlc0tBSmRIL3hGMEM3eVZB?=
 =?utf-8?B?MU45bWxvNkZkS0h5WCtVTWx4cEIxZ2lkMXd3SjhycUxHeUIwQTc0WExmN3hL?=
 =?utf-8?B?SFgvSzEwYk1UUXFySFZhMHNQVmp0T1FyR1V4V0NXakFSaE43ZGFiUDZTZ2Rq?=
 =?utf-8?B?UWNWb0hDSFYrekNRTytBcXRxYWR3VXVzVVVGSmN6a3RjWEFFL2dnSWlkMWVZ?=
 =?utf-8?B?QXpNajBrdkFVMFQ0TWlUNS9BQUV3djIwVTgzWUhSUGVYMkg4cTlXcDBzbXp3?=
 =?utf-8?B?alNqM0RSSlhFMDdLeGFpSGNOdHFURiszdUYzTE1ObnlFZ2hvVytSUCtUVnN1?=
 =?utf-8?B?M0pxeWNaajFNZkpmMXRwYVNDM0ozYkpPMk8xZmxHb3NKMTRCMW9SQzhldmx5?=
 =?utf-8?B?MVZQdExzOWZUKzBJMi85cEhiZkVLZWNCSFhxNHc1L2JvcWJObGFjb1Q2QjNo?=
 =?utf-8?B?dFg2M1R0UDhLU0o3R1FFdXFUTWV6ek1ocnhEYVRPVGdlc1pNdmY3ZHFCcUcw?=
 =?utf-8?B?SnIvejFQZWdERTFubnM0N29CK0poUGtCVzlGUXVraHdDV2p0UjdqZzZBUXl3?=
 =?utf-8?B?aGNRWVNKN04wb3d6bjdpM1J3L3RTZlhORXBLMWFxb3BWeS9acU9ReVVrS1pI?=
 =?utf-8?B?QnEwTVgzQ0JPZ0VBb25WL3pKbWN6a3RwVzlwb21oVGIxVHorV0QrcFBUNGpR?=
 =?utf-8?B?WkUvL0RGeDlnZW85V2VES00zM0JPcTJZZm9XMHdkWXNzbXZuU3VqcG9ZTWZp?=
 =?utf-8?B?d01KRFFhcmtFd2lRNU1mTFNqV1B6dEFTbFZzZ3BRa2wxanNYWDdUUWxuR3hq?=
 =?utf-8?B?K1Z6aFY1ZCsrSmV5aDNZcUlSUFhIUUYzZ1g2UWNDaDBRZWJTSzhyQXBjelZQ?=
 =?utf-8?B?cVhyS2QxUXpmc1ZHTnhUS3lYeStnR2J2WFZPbjhGNmtNUnBnZVFnd01SMEEy?=
 =?utf-8?B?a0JURmw5VVB4Zms3Q050Ry9WZklQdUZwVnNLV3Vwc3dVTEZWdU92Qk5NUElQ?=
 =?utf-8?B?TjVLcE1vZEFHSEVhRWVmcDlqejlodWZkRzk1UVM1RWdsemRucWRwQmJGOXpH?=
 =?utf-8?B?eGY1ZjhqdUZwOWJwdG91d2N3T0hvaFpxM2FucHRoNG1vY2s5bDNIdVpxM3Z4?=
 =?utf-8?B?ZXdiQzlUOXJQMU82cWllb0Y1bWZQT1R3R0NZMmJIWXVQSjYrSm5ubmV4b3Az?=
 =?utf-8?B?MFBDWnh4SDlDUjE1VjFITHl2T3pFNEpHaGJENjdzTXM3YnJqc0ZCWko1STJ2?=
 =?utf-8?B?djUwRVFqb0tVWXlvRk0rakhEZURhOWtoRWVWb2ZhdjlManRFYUNQNW5scDEy?=
 =?utf-8?B?bkVUNld4Z2p1RTkxSDIzUU8ydnlEenJtbHduSFVPalIzeDgvcWFwM2VMRzgw?=
 =?utf-8?B?Z3NDNTI2WTFXTGlzY0xLbFp4dzVKNktNMVpCZCs2VHZwVlZxMjFNQ1QyM2Vj?=
 =?utf-8?B?MDFXUm9zR0ZhVm9zWmZma0l6NFpRQmJFbXYyNFBGRzFkQXhmVm94NHYwTGpi?=
 =?utf-8?B?cG5Kc3FOTi8ycmlUakJmZmxqWEwrNW9jVGNRWHg1OTFPbHBseXQwdHVXcE15?=
 =?utf-8?Q?stnCPZVna8TUXJs4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bce35e8-d33a-4998-d22f-08de67b5b3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 08:32:03.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hPXWFvPoF9DEYvuqquvmbH3H3ubUOCgB1x8MRCbE8eA1aBMYTEjo3HeIbSifdnJQ8YrVlerWuhkazpNhsouOlwab7j5OeWQip6GblkpC4fLxQnaw2pwEnn6obQN7BEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8066
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31660-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,vger.kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7826B10D035
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2FvLCBKdW5qaWUgPGp1
bmppZS5jYW9AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxNSwgMjAyNiA2
OjE1IFBNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29y
ZW5ibGl0QGludGVsLmNvbT47IEJlcmcsDQo+IEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVs
LmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgUmljaGFyZA0KPiBDb2NocmFu
IDxyaWNoYXJkY29jaHJhbkBnbWFpbC5jb20+DQo+IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtl
cm5lbC5vcmc+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgQmVuIFNoaW1vbCwgWWVkaWR5YSA8eWVkaWR5YS5iZW4uc2hpbW9sQGludGVs
LmNvbT47DQo+IFN0ZXJuLCBBdnJhaGFtIDxhdnJhaGFtLnN0ZXJuQGludGVsLmNvbT47IEdhYmF5
LCBEYW5pZWwNCj4gPGRhbmllbC5nYWJheUBpbnRlbC5jb20+OyBQcmFiaHUsIEtyaXNobmFuYW5k
DQo+IDxrcmlzaG5hbmFuZC5wcmFiaHVAaW50ZWwuY29tPjsgQ29lbGhvLCBMdWNpYW5vIDxsdWNp
YW5vLmNvZWxob0BpbnRlbC5jb20+Ow0KPiBHcmVnb3J5IEdyZWVubWFuIDxncmVnb3J5LmdyZWVu
bWFuQGludGVsLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENI
XSB3aWZpOiBpd2x3aWZpOiBwdHA6IEZpeCBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24gaW4gUFRQ
IHJlbW92YWwNCj4gDQo+IGl3bF9tdm1fcHRwX3JlbW92ZSgpIGFuZCBpd2xfbWxkX3B0cF9yZW1v
dmUoKSBjYWxsDQo+IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIG9ubHkgYWZ0ZXIgcHRwX2Ns
b2NrX3VucmVnaXN0ZXIoKSBhbmQgYWZ0ZXIgcGFydGlhbGx5DQo+IGNsZWFyaW5nIHB0cF9kYXRh
IHN0YXRlLg0KPiANCj4gVGhpcyBjcmVhdGVzIGEgcmFjZSB3aGVyZSB0aGUgZGVsYXllZCB3b3Jr
IChpd2xfbXZtX3B0cF93b3JrIC8NCj4gaXdsX21sZF9wdHBfd29yaykgY2FuIHJ1biB3aGlsZSB0
ZWFyZG93biBpcyBpbiBwcm9ncmVzcyBhbmQgb2JzZXJ2ZSBhIHBhcnRpYWxseQ0KPiBtb2RpZmll
ZCBQVFAgc3RhdGUuIEluIGFkZGl0aW9uLCB0aGUgd29yayBtYXkgcmUtYXJtIGl0c2VsZiwgZXh0
ZW5kaW5nIHRoZQ0KPiB0ZWFyZG93biB3aW5kb3cgYW5kIHJpc2tpbmcgZXhlY3V0aW9uIGFmdGVy
IGRyaXZlciByZXNvdXJjZXMgaGF2ZSBiZWVuDQo+IHJlbGVhc2VkLg0KDQpOb3Qgc3VyZSBJIHVu
ZGVyc3RhbmQgaG93IGlzIHRoZSBmYWN0IHRoYXQgd29yayByZS1hcm0gaXRzZWxmIGlzIHJlbGF0
ZWQvbWFrZXMgdGhlIGJ1ZyB3b3JzZT8NCg0KPiANCj4gTW92ZSBjYW5jZWxfZGVsYXllZF93b3Jr
X3N5bmMoKSBiZWZvcmUgcHRwX2Nsb2NrX3VucmVnaXN0ZXIoKSB0byBlbnN1cmUgdGhlDQo+IGRl
bGF5ZWQgd29yayBpcyBmdWxseSBzdG9wcGVkIGJlZm9yZSBhbnkgUFRQIGNsZWFudXAgYmVnaW5z
LiBUaGlzIGZvbGxvd3MgdGhlDQo+IHN0YW5kYXJkIHBhdHRlcm4gdXNlZCBieSBvdGhlciBJbnRl
bCBQVFAgZHJpdmVycyBzdWNoIGFzIGUxMDAwZSwgaWdiLCBpeGdiZSwgYW5kDQo+IGljZS4NCj4g
DQo+IEZpeGVzOiBkMWU4NzllYzYwMGYgKCJ3aWZpOiBpd2x3aWZpOiBhZGQgaXdsbWxkIHN1Yi1k
cml2ZXIiKQ0KPiBGaXhlczogMTU5NWVjY2UxY2YzICgid2lmaTogaXdsd2lmaTogbXZtOiBhZGQg
c3VwcG9ydCBmb3IgUFRQIEhXIGNsb2NrIChQSEMpIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSnVuamllIENhbyA8anVuamllLmNhb0BpbnRlbC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvcHRwLmMg
fCAyICstDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3B0cC5jIHwg
MiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
bGQvcHRwLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9wdHAu
Yw0KPiBpbmRleCAyMzE5MjA0MjVjMDYuLmI0MDE4MjMyMDgwMSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvcHRwLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvcHRwLmMNCj4gQEAgLTMxOSwxMCArMzE5
LDEwIEBAIHZvaWQgaXdsX21sZF9wdHBfcmVtb3ZlKHN0cnVjdCBpd2xfbWxkICptbGQpDQo+ICAJ
CQkgICAgICAgbWxkLT5wdHBfZGF0YS5wdHBfY2xvY2tfaW5mby5uYW1lLA0KPiAgCQkJICAgICAg
IHB0cF9jbG9ja19pbmRleChtbGQtPnB0cF9kYXRhLnB0cF9jbG9jaykpOw0KPiANCj4gKwkJY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jKCZtbGQtPnB0cF9kYXRhLmR3b3JrKTsNCj4gIAkJcHRwX2Ns
b2NrX3VucmVnaXN0ZXIobWxkLT5wdHBfZGF0YS5wdHBfY2xvY2spOw0KPiAgCQltbGQtPnB0cF9k
YXRhLnB0cF9jbG9jayA9IE5VTEw7DQo+ICAJCW1sZC0+cHRwX2RhdGEubGFzdF9ncDIgPSAwOw0K
PiAgCQltbGQtPnB0cF9kYXRhLndyYXBfY291bnRlciA9IDA7DQo+IC0JCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmbWxkLT5wdHBfZGF0YS5kd29yayk7DQo+ICAJfQ0KPiAgfQ0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcHRwLmMNCj4gYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYw0KPiBpbmRleCAxZGE2
MjYwZTIzOGMuLjJiMDFjYTM2YTFiNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vcHRwLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vcHRwLmMNCj4gQEAgLTMyNSwxMSArMzI1LDExIEBAIHZvaWQgaXds
X212bV9wdHBfcmVtb3ZlKHN0cnVjdCBpd2xfbXZtICptdm0pDQo+ICAJCQkgICAgICAgbXZtLT5w
dHBfZGF0YS5wdHBfY2xvY2tfaW5mby5uYW1lLA0KPiAgCQkJICAgICAgIHB0cF9jbG9ja19pbmRl
eChtdm0tPnB0cF9kYXRhLnB0cF9jbG9jaykpOw0KPiANCj4gKwkJY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jKCZtdm0tPnB0cF9kYXRhLmR3b3JrKTsNCj4gIAkJcHRwX2Nsb2NrX3VucmVnaXN0ZXIo
bXZtLT5wdHBfZGF0YS5wdHBfY2xvY2spOw0KPiAgCQltdm0tPnB0cF9kYXRhLnB0cF9jbG9jayA9
IE5VTEw7DQo+ICAJCW1lbXNldCgmbXZtLT5wdHBfZGF0YS5wdHBfY2xvY2tfaW5mbywgMCwNCj4g
IAkJICAgICAgIHNpemVvZihtdm0tPnB0cF9kYXRhLnB0cF9jbG9ja19pbmZvKSk7DQo+ICAJCW12
bS0+cHRwX2RhdGEubGFzdF9ncDIgPSAwOw0KPiAtCQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
Jm12bS0+cHRwX2RhdGEuZHdvcmspOw0KPiAgCX0NCj4gIH0NCj4gLS0NCj4gMi40My4wDQoNCg==

