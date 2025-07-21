Return-Path: <linux-wireless+bounces-25755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8EBB0C8ED
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881FF1AA5231
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0428C02F;
	Mon, 21 Jul 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NThL5GU8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9F2C9D
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115911; cv=fail; b=PIrZMRqnCLfxnYzoXhIF3WtW0A13LU8Pk556rccvMt93LPE6oV+wTUuvL6QXEIO0G+QzISFINKNrkQ7VchjC2MzWqZYTD4qK5kqVwgSqimvrjM5mi/x4R8vDI7gXKOBMDToat2WACVltiP2GwYA5If22t4JmlPwpcYdhAVNr4sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115911; c=relaxed/simple;
	bh=OC3AMlYUH/bK1y5fG8b4r18hOB22439wWrYQi7KfYjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=brQP8IpcHgXx7RZwCtVeatYhBFFfgz+zCeWq49OjctEFoOoCSOAa01xA3k3XfUro/6XfgMfg0Zr6LdmZhUOXzkWFhv7MMnde5Ea7lYid84VgcLeUTK7CIp9PnUq/6CeblXvOkVuUzMyHxxUwxyFDM0QZc8iBY2Ayu1kPG4gvLP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NThL5GU8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753115910; x=1784651910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OC3AMlYUH/bK1y5fG8b4r18hOB22439wWrYQi7KfYjA=;
  b=NThL5GU820uyE2xpg/xK9wbDVR8OQspW/NyNucgCD8NpYMGSlsAJStlQ
   ZSV9AVZCigR5nLSsyhXIUI4SyvjcFuvVEs9VRUlCqXjA2b9v3cIemCuC9
   gN0xtmwvMsVlw7UGlHFe7xbx+Gfm8Swp0S77YE7XAe/c/tOaXp1VsGlZQ
   uKsLa3SQnoYz7p3AVpR7iQ1VlSSdE1wkhmPvGyed9xqopQ8kSCt20nSqs
   KZ6EGuoyWv0CGYI7gXAHnrsRhLj+Vv3Uj3zg3b59lrCU51LWQr9Tqo/z9
   rhpLFQnVJ85ZnlaLhzEoNWaznlW49y/dat6u/SR1DEr5VzJDDs3HFdNRI
   g==;
X-CSE-ConnectionGUID: /HQZ9KZtRmyIrkRJBhN3AA==
X-CSE-MsgGUID: HydcTdAMRECm1plMS5PXsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72906252"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="72906252"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 09:38:29 -0700
X-CSE-ConnectionGUID: 6lQ/Q7HRSw+yhlek3X32QA==
X-CSE-MsgGUID: PVbCmfN5QGC/ZWOq4HCVig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="163184597"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 09:38:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 09:38:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 09:38:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 09:38:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3G46K3q9IsFeaQ0+Yr1BsJi8mQklaHGhyRvrNJU2iByLXryz6xiGmKUUQymHuX5ThqvTk5jwHoay3rVTfgRQDUh9uKetCR6tHp01RDVGmSRsV31mGEQy5EbN03J/n3A6l/v+WfmS0hV3o/mnQw6bmBbwlO+WJPnARr+KHB4rVzmgBs+NCmlH2WcAKsYcifoQ7eK/Y/C8eADLHfr53lmnjajenyMdb1CYN7b6ORIHM2Wc8RPMZtIwlXQr8azNvqqzvSPIGm6jNoxsLCkjcl8iKgYkaWAiQ6XkBDnIV8Y6YLLDMM6coMQXwnV/6DY90EcLjXKV9mORIUahBB4s4nZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC3AMlYUH/bK1y5fG8b4r18hOB22439wWrYQi7KfYjA=;
 b=Mh9BBLJl1bO22hnMXMqKJWwADLamuNDudii0qDNE3SLg5iwa5DfDylfGLs5cifVw5JeNpVGyqCC0UdjdF133nmf7EROxFU9Cwoe9ZUMJoJPOH3y+em4Mc0/HI0gXXUsg73noPt9px44Jzw6zTOlvYANhp+knCshF2BEjaigotNmuCkvNSqZOFpPrguQJUXToGgGkri/Hm2uSK5SxCmlyTBRNI26vS35JAZl9lXWBFt3QeuvljJorODUdVowtLOinGWf5ji8MoW1h1VtuohsBdsz5ZUQMc0a153xkkP3oDPkVk8dV0ioObSLyO20T4dfbJRJgSH2lgG0QefY6yNiaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.42; Mon, 21 Jul
 2025 16:38:20 +0000
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95]) by SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95%6]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 16:38:20 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Vinay Gannevaram <quic_vganneva@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"maheshkkv@google.com" <maheshkkv@google.com>
Subject: RE: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
Thread-Topic: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
Thread-Index: AQHb48SerkPaO9aaN0CO9YgNtFbTgLQoO8eAgBSfa1A=
Date: Mon, 21 Jul 2025 16:38:19 +0000
Message-ID: <SJ1PR11MB6252E30E7221877491CEC817F55DA@SJ1PR11MB6252.namprd11.prod.outlook.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
 <20250622222444.356435-3-andrei.otcheretianski@intel.com>
 <61213657-4df3-4ed5-9950-04e52be92df6@quicinc.com>
In-Reply-To: <61213657-4df3-4ed5-9950-04e52be92df6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6252:EE_|SA3PR11MB7584:EE_
x-ms-office365-filtering-correlation-id: 7a98271c-5b47-4fe3-d38b-08ddc8750074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGxKaE1IUmhrQ1FjQjYva01aMDZ6NERLSkFRLzRyKy90djhhMTdxRFhCM3Ra?=
 =?utf-8?B?bWhveE45c1RoUjZXTGw2VEMrZVZEczhwcitSd2lGTi9Xak80MEd0YUF6WnJ0?=
 =?utf-8?B?aGZkRTdvNi9XbkIzajAzeWwvemMvQWFBT1hZSUNyby9UczdUT0t1cGY0VTFn?=
 =?utf-8?B?V3pDYU1wQlRIcVJ3NXU3NTRJMzNRc0RNcmVHU3lPR0M4RlRTbU1UQmtUNEFZ?=
 =?utf-8?B?RERaU3dTVFB5OEtST0NrQnVoUEJDU2tNNlgvbFk3V2ZMYXZJdG5LR3MxZ0NU?=
 =?utf-8?B?eFBxODNDdFMwTGdOWTg1RmZYWHJIbWg3MGNGdXBHQUhUOWhHYnIrYm9pVHcv?=
 =?utf-8?B?QVJIY2lVaFNIeThudk5pUmoxZTc1VmpaMGxxQ0pwY3Z1WndVb0YxTnRCYlVM?=
 =?utf-8?B?dUlrL3A1NlZYMXJ1eW5xT2cyUzJPOTA3OUpqM2QwQmdVOENKL2lLckVaNEdv?=
 =?utf-8?B?TWNRME01ak9kWVpGZ1BPK3ZzQmxCN1Y4eG83NlJ5bXhwQnBpOU16VTZNTlk2?=
 =?utf-8?B?ak1SaTRlUFpqSGVhM0s5VXhic1MwOGM4QThoRWpoejlvalRBVzFiYVkyazNN?=
 =?utf-8?B?YWVZcnZ6Q1JLQmIzZkg2SHNURklieHA1RGkrUVQrbWZJN0dMRXdiMzFvNzZy?=
 =?utf-8?B?bytMc05qYVd4MzF2NlVqQ20vdkxtb01GaDRCTlh1S3JNS3VnZ2hoeThJb3I4?=
 =?utf-8?B?Q25tcXBGZGZ0VVJqRGpYN2M4clkwRVFMWVVmbjBUWStLVksyR0NUR3BFYXFF?=
 =?utf-8?B?TFBnODBoQkZ1RTdDT2s4aTA4WHNDbC9QUTBRUHZOQ1pxbkl6TFNYTno5b0o3?=
 =?utf-8?B?RjBHUjlmRDBPc2p2dkdkL1V2M3dxak5IZmZmV3BId2tBUnZZVmVPMVlGalVQ?=
 =?utf-8?B?eDN5WHlIQThsdyt5MlYwSDIwK25hT2hLK3JTZW1rbXpTVS9MeDgzRzdoZDBS?=
 =?utf-8?B?R1c2cXh3WHB1MmpFNU9sTEJKY1ZkTTZLRk9GbXVWNVViekpuZnVLSXRkNG5V?=
 =?utf-8?B?dzkycjJua2FMcUVuZXdCM0dONUV4QnZXanJLcUh4SmMxdWw4Y1NlUzZqaDc2?=
 =?utf-8?B?MEFHY0lQSklkMzAyeFA2RkhnL2taQzhjb3VHR0pWQThUTVBnMVNCMU5tUHN5?=
 =?utf-8?B?S2NUQkpBYzMzMHBPOWZyRk1JL1RudGc1SUNUYjNDbTJaZmdYN1pyZzExZGJ4?=
 =?utf-8?B?MytIWnRDN1hIRWtKQkxGNFdWdjE1QUNQZnk1U1dKcEU3WS9oajZpTk5oVU50?=
 =?utf-8?B?VFR3alRLRHdhRm43OWtxQVhFOXZFeUt3YkYrMldmRnBlZ0dsVkwwbWVLMzFT?=
 =?utf-8?B?bkZ6UDhwd21Lb1NnMHVTakFtQ3JLMm5PQllyOFJza0EvUTRMcTYzemFGWExv?=
 =?utf-8?B?Nlp1aWMxWk40UUx4RWpqdFg2MEt1a3RxbTd1VHFBYXJyTkVGQlp1V3RLN3k4?=
 =?utf-8?B?OGVMMW1DL0NMVi9QRDBGY05IeXpjSFVDejdhMVhiTHh2MnJLVTY4cFpGbzl6?=
 =?utf-8?B?eXFLZE9nLzJVWU1BbVp3dWdHbVhYdjlNQ01vNDZCM3Q4R1o0SnhCdHM4TUQ3?=
 =?utf-8?B?d1hIbHNSc3NMR0ROTEJicFdTWGdtSGljb0pCTWFZVnVVMVpFYzJ3MVZiYTB6?=
 =?utf-8?B?aTdHMFFrS2ExbzU0NlQwR1J6YnUyZERIQS9laC9Gb0lJeDFidGhJNmJ1M2tU?=
 =?utf-8?B?M2lZVGJ2bGlMbGE0L3o1QUlJMGNpa2g5STdyVnFEWWtsK1RkTExSajlxaVR0?=
 =?utf-8?B?WUQzQ0hoeFM3SDRydDJWLzJoellYMm9tUm1neit6aGNRZlFXNFhuMUQ0U3dl?=
 =?utf-8?B?RGZvemtjcTZRWnQ1ajVZa2ZOUEtWbnV4QVdLVWtaTVRVOWlkREtZWENucmh2?=
 =?utf-8?B?OUt0ZFZSeWpWQUNhZDRtTnhudlE0MjQrYWZPbHdtdHJvWnRRUGpXdUZoUXpq?=
 =?utf-8?B?OTYvZkxoQU1ZVDVGZXdMenhYL3pzcCsyRFBVb3pEWmcyVWI0V3ZVTzJ4bDQ5?=
 =?utf-8?B?RW5YSVp6Q2F3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFl5OVVQUG91T29xUGRDOFoyengrNW5ja2NiSHV0Z3dZRUlvT2hpTUhmOVd5?=
 =?utf-8?B?bDVXM25vSUNFZS9zQUk5NitFeVpBOVI4c3Q1YmVPMkdZL2d1ejVJS2xHeDI5?=
 =?utf-8?B?eC95SUNzT1ptWmh1c0x4Ukp5V2g3WTIvaXRnRWMrMkpzYUFZSHcyemljQUZ2?=
 =?utf-8?B?Y0Z5TjBMYkhaaEo1N21seWV0N3NsOHk4Smx0OHVqWlpoY1oxK0daT25lcUc1?=
 =?utf-8?B?M0x3RDNpRW1EYlpwYnpXT29kMWNoejhUeVVFbVpVVHIwc0NkVEhvTWRRb2tr?=
 =?utf-8?B?TDhnRDZxWmNWdFhuS2cvYzljTzhuaUN5cmkwdTBwRE15RHJkbTRVRVpHSmlI?=
 =?utf-8?B?Ujl5QmM2WFpKNXAwNCtXNXI1UU43a0RvZ2h6bGJ5TC9vUXF6VDAxdWM4TGtL?=
 =?utf-8?B?NFRta3hRdzNGMys1RVFtZlBRVnU5S3YwSDNoYURuQ3V6eGdTa3A1Vnl1NjFr?=
 =?utf-8?B?Rk9uQTJVMTFTWnBYN2hBL0xYejNFSGprekVJZld5aXBxVVRBV3U3eDBZbmNW?=
 =?utf-8?B?Rlc4K1dkcFNDQmcxTFQ5Ujh1OXhJbHlhb2ZXVDNIV1VUVHpMNCtmV3pTWnJZ?=
 =?utf-8?B?L2NoeXZCRHdLM1krYmZQbi9JQUx3aEZwQVp1TExURm10Qm1ZSXdCdkY0VnNO?=
 =?utf-8?B?RXJwNGRMZEdwWUxVT05lOE9DSlNKWmlDTzVpblNtVEhkSFBNZ1pZZ0gyNE4y?=
 =?utf-8?B?Y3FBNTl6cS82ZWYvdmlCMng5aDdUdmwwak1HRUU3aUF0OVh4bEhocnpKd3Vn?=
 =?utf-8?B?U0pDbW03ZE5YSU14OWVlQ0ZaclpzeFI0K3lyWitvelJlN3U0WGJndTlScVls?=
 =?utf-8?B?WEs1WmpqdGt6Nmt5dWhHNjFZMkYxdERrRTRidmxOOGYrUWE2MUg3QjRqeE5o?=
 =?utf-8?B?VmxXY2NmL0trNWFFS3dvbW91WTUweEppSlg1cVY2di83U2JmM1NocnV2T1ZJ?=
 =?utf-8?B?Vml2TERSbmxPdE1sMFByYzlKVmVUU3JIR1RLa1dFNm1mUmhYQVpybG9VZUFO?=
 =?utf-8?B?dlA1UVJ3WVZ6VnJpQVBSNGlRcVNFeHdGQVZUSURqVmROSUVreXNMQWJZdkFq?=
 =?utf-8?B?SVMrUnJXRGlEZk43MUVsd2xrN01aQldtZlJ0YUJUWk5NNm1WN0oya1F5cFpK?=
 =?utf-8?B?a3JSZ3NZV0g1SmR3djRYbm5udm1kd0pJTUVYMm5xT1pEY1ozb3hYalAxamZx?=
 =?utf-8?B?Z1BtRUZheHdLV3VDbGV6K0FNVkZMa2dRNVZLSGpKdGQ0aTNrdjRpaHZTL3Rr?=
 =?utf-8?B?WGtxbGt2WUhQeHdQek1IUGRwRnY3bFBrWWNSK0tLa3RuOXExRGR3MGd4Vkhj?=
 =?utf-8?B?c2ZNdE9tVE5QNk1nYktlQStyYWIzYlROVTVhYjRYOVExaVZyYVNpc1ZzS0xY?=
 =?utf-8?B?ZTRzNWxrVkNlMHdCWHRrdFRVMlJZQ2RQKzBVK1BCdnFHQVNHdThLTzNCbEs4?=
 =?utf-8?B?bkoxK1NDd2ZJTWExb005SDJyb2VmekFib1ZxMjhYN1RnYmhIdHg3bzRCdnJt?=
 =?utf-8?B?Nm5Da3AxTXQ5S0RkTUFhb1hzRjB2Q09wOTJZZHhiaFNZNURaYzZjT2N6VVpa?=
 =?utf-8?B?SWNTQWpTajFyaVlOaEtSTFBXOUNMRURLMENtdWNxNWZBQ3J6QXJrcVpDdXlO?=
 =?utf-8?B?SHJFRVZWUS85SlMweEllVkdBaTV6Wkx6a3dLRnRhYkVMektDTGxxMzlwQTJQ?=
 =?utf-8?B?Z1l0V3huSi9ldEhocDFoTVhsNG9ZQ2lBRyt2bmp3Uk9JTnBpdWlGT3pkZXdM?=
 =?utf-8?B?czhJRFVwaXloWHIxamdFVEhxd3NjQTFRcE1WK2xRMTB0U3VhNXhWekxGNTdn?=
 =?utf-8?B?bHZ4L3BOWFJUWmdVdXJUWktWSDdTRUppRTZ6T2c4TUczaWJjdk5RdjI5bDlC?=
 =?utf-8?B?VjFDd0xzSnkxZE0rMXZkR1l0emVIQm5xOFlYcnpYbnB1NC8ydmRGMVJnYmFy?=
 =?utf-8?B?dnQvekN5RlpMM2RBL25JZStLZmcwaS9CUElTaXJ2bWdWVjlEa1pRck85UzQr?=
 =?utf-8?B?MTh0T1NKQ3JpWUNOSVBjaVN2cHF6dTVGbjBqTUZRMjBCU0M4N2RTdDltOU9p?=
 =?utf-8?B?Yk9VbnhWbXZmOTBkaHJZalhzdFdOOE5zNlY5WXFIaFVKSDlCSU1qMjRVN05F?=
 =?utf-8?B?ZGtCSEM1TGFPVzhxeGJrKy84dVhVdGV5TXphaWRUZjNwT2JmOS9xWFNBNkd6?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a98271c-5b47-4fe3-d38b-08ddc8750074
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 16:38:20.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7lhqpAwweiJErJYuyqqbgUR+ZIIA0/uv/rNJ3F/2lvn7PgP4oX34bS9Hu9Thk5eKDDxfDX3oFO9+/UvONBZZQp7H8D8e7kSlWPnzMKL5ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
X-OriginatorOrg: intel.com

PiANCj4gQ2FuIHdlIGFkZCBiZWxvdyBhZGRpdGlvbmFsIGNhcGFiaWxpdGllcyBhbHNvLg0KPg0K
DQpTb21lIG9mIHRoZSBiZWxvdyBjYXBhYmlsaXRpZXMgbWFrZSBzZW5zZSB0byBtZS4gSSBjYW4g
YWRkIGZldyBvZiB0aGVtIG5vdywgYnV0IGluIGdlbmVyYWwsIEkgdGhpbmsgaXQgd291bGQgYmUg
YmV0dGVyIHRvIGFkZCB0aGVtIHRvZ2V0aGVyIHdpdGggdGhlIEFQSSBkZWZpbml0aW9uIG9mIHRo
ZSBzcGVjaWZpYyBmZWF0dXJlIHRoZXkgaW50cm9kdWNlLiBUaGlzIHdheSBpdCB3aWxsIGJlIHBv
c3NpYmxlIHRvIHByb3Blcmx5IGRlc2NyaWJlIHdoYXQgZXhhY3RseSBpcyByZXF1aXJlZCBmcm9t
IHRoZSB1bmRlcmx5aW5nIGRyaXZlci9kZXZpY2UuDQogDQo+ICogQE5MODAyMTFfTkFOX0NBUEFf
SU5TVEFOVF9NT0RFX1NVUFBPUlQ6IEZsYWcgYXR0cmlidXRlIGluZGljYXRpbmcNCj4gaWYgdGhl
DQo+IA0KPiAgwqAqwqAgwqAgZGV2aWNlIHN1cHBvcnRzIGluc3RhbnQgbW9kZSBvcGVyYXRpb24g
Zm9yIGZhc3RlciBOQU4gc2Vzc2lvbiBzZXR1cC4NCg0KSSB0aGluayB0aGlzIG9uZSBzaG91bGQg
YmUgYWRkZWQgdG9nZXRoZXIgd2l0aCBzb21lIGNvbW1hbmQvY29uZmlndXJhdGlvbiB0byBlbnRl
ciBleGlzdCBpbnN0YW50IGNvbW11bmljYXRpb24gbW9kZS4NCg0KPiAgwqAqIEBOTDgwMjExX05B
Tl9DQVBBXzZHX1NVUFBPUlQ6IEZsYWcgYXR0cmlidXRlIGluZGljYXRpbmcgaWYgdGhlIGRldmlj
ZQ0KPiAgwqAqwqAgwqAgc3VwcG9ydHMgTkFOIG9wZXJhdGlvbiBpbiA2IEdIeiBiYW5kLg0KDQpJ
IHdpbGwgbWFrZSBpdCBtb3JlIGdlbmVyaWMuIFN1cHBvcnRlZCBiYW5kcyBiaXRtYXAgKHNlZSBt
eSBvdGhlciBjb21tZW50IGJlbG93KQ0KDQo+ICDCoCogQE5MODAyMTFfTkFOX0NBUEFfSEVfU1VQ
UE9SVDogRmxhZyBhdHRyaWJ1dGUgaW5kaWNhdGluZyBpZiB0aGUgZGV2aWNlDQo+ICDCoCrCoCDC
oCBzdXBwb3J0cyA4MDIuMTFheCAoSEUpIGZlYXR1cmVzIGluIE5BTi4NCg0KU2FtZSwgc2VlIG15
IChsYXN0KSBjb21tZW50IHJlZ2FyZGluZyBkZXZpY2UgY2FwYWJpbGl0aWVzIHJlcG9ydGluZy4N
Cg0KPiAgwqAqIEBOTDgwMjExX05BTl9DQVBBX1BBSVJJTkdfU1VQUE9SVDogRmxhZyBhdHRyaWJ1
dGUgaW5kaWNhdGluZyBpZiB0aGUNCj4gZGV2aWNlDQo+ICDCoCrCoCDCoCBzdXBwb3J0cyBzZWN1
cmUgcGFpcmluZyBvdmVyIE5BTi4NCg0KUEFTTiBwYWlyaW5nICsgYm9vdHN0cmFwcGluZyB3aWxs
IGJlIGRvbmUgZW50aXJlbHkgaW4gdXNlciBzcGFjZSAod3BhX3N1cHBsaWNhbnQpLg0KV2hhdCBl
eGFjdGx5IHRoaXMgZmxhZyBtZWFucyBpbiBjb250ZXh0IG9mIGRldmljZS9kcml2ZXIgY2FwYWJp
bGl0aWVzPyBJIGd1ZXNzIHRoZSBkZXZpY2Ugc2hvdWxkIGJlIGFibGUgdG8gaGFuZGxlIGFsbCB0
aGUgbmV3IGtleXMgZGVyaXZlZCBkdXJpbmcgUEFTTiAoTk0tVEsgZXRjKS4uDQpJIHRoaW5rIGl0
J3MgYmV0dGVyIHRvIGRlZmluZSB3aGF0IGV4YWN0bHkgaXMgZXhwZWN0ZWQgaGVyZSBhbmQgdGh1
cywgaXQncyBiZXR0ZXIgdG8gZGVmaW5lIHRvZ2V0aGVyIHdoZW4gdGhpcyBmZWF0dXJlIGlzIGlt
cGxlbWVudGVkLg0KDQo+ICDCoCogQE5MODAyMTFfTkFOX0NBUEFfU0VUX0NMVVNURVJfSURfU1VQ
UE9SVDogRmxhZyBhdHRyaWJ1dGUNCj4gaW5kaWNhdGluZyBpZiB0aGUNCj4gIMKgKsKgIMKgIGRl
dmljZSBzdXBwb3J0cyBzZXR0aW5nIGEgY3VzdG9tIGNsdXN0ZXIgSUQgZm9yIE5BTiBvcGVyYXRp
b24uDQoNCkRvIHdlIHJlYWxseSBuZWVkIGEgY2FwYWJpbGl0eSBmb3IgdGhhdD8gVGhlIGRldmlj
ZSBjYW4ganVzdCBpZ25vcmUgd2hhdCB1c2VyIHNwYWNlIGNvbmZpZ3VyZXM/IEFsc28sIHRoaXMg
ZG9lc24ndCBzb3VuZCBsaWtlIGEgdmVyeSBjb21wbGV4IHJlcXVpcmVtZW50LCBubz8NCkFuZCBJ
IGRvbid0IGtub3cgd2h5IGl0J3MgbmVlZGVkLi4NCg0KPiAgwqAqIEBOTDgwMjExX05BTl9DQVBB
X1BFUklPRElDX1JBTkdJTkdfU1VQUE9SVDogRmxhZyBhdHRyaWJ1dGUNCj4gaW5kaWNhdGluZyBp
ZiB0aGUNCj4gIMKgKsKgIMKgIGRldmljZSBzdXBwb3J0cyBwZXJpb2RpYyByYW5naW5nIHNlc3Np
b25zIG92ZXIgTkFOLg0KDQpUaGlzIHNob3VsZCBiZSBkZWZpbmVkIHRvZ2V0aGVyIHdpdGggcmFu
Z2luZyBjb21tYW5kcy4NCg0KPiAgwqAqIEBOTDgwMjExX05BTl9DQVBBX1JUVF9TVVBQT1JURURf
Qlc6ICh1MzIpIEJpdG1hc2sgaW5kaWNhdGluZw0KPiBzdXBwb3J0ZWQNCj4gIMKgKsKgIMKgIGJh
bmR3aWR0aHMgZm9yIFJUVCAocmFuZ2luZykgb3ZlciBOQU4uDQoNCnNhbWUNCg0KPiAgwqAqIEBO
TDgwMjExX05BTl9DQVBBX01BWF9DT05DVVJSRU5UX0NMVVNURVJTOiAodTgpIHZhbHVlIHRvDQo+
IGluZGljYXRlIG1heGltdW0NCj4gIMKgKsKgIMKgIG51bWJlciBvZiBjbHVzdGVycyB0aGUgZGV2
aWNlIGNhbiBqb2luIGNvbmN1cnJlbnRseS4NCg0KSG93IGNvbWUgdGhlIGRldmljZSBjYW4gam9p
biBtdWx0aXBsZSBjbHVzdGVycz8gVGhlIHdob2xlIGlkZWEgaW4gTkFOIGlzIHRoYXQgdGhlIGNs
dXN0ZXJzIHNoYWxsIGNvbnZlcmdlLi4NCkhvdyB3b3VsZCBpdCB3b3JrIHdpdGggdGhlIGV4aXN0
aW5nIEFQSSdzIHdpdGggY2x1c3Rlcl9qb2luIGFuZCBkd19ub3RpZmljYXRpb24/DQpBbnl3YXks
IGV2ZW4gdGhvdWdoIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgYW5kIGhvdyBpdCBjYW4gYmUgdXNl
ZCwgdGhlIHdheSB0byBkbyBzbyBpcyB0byBzdXBwb3J0IG11bHRpcGxlIE5NSSBpbnRlcmZhY2Vz
LiANClJlcG9ydGluZyBpbnRlcmZhY2UgdHlwZXMgY29tYmluYXRpb25zIGFscmVhZHkgZXhpc3Rz
IGluIGludGVyZmFjZSBjb21iaW5hdGlvbnMgQVBJJ3MgKE5MODAyMTFfQVRUUl9JTlRFUkZBQ0Vf
Q09NQklOQVRJT05TKQ0KDQo+ICDCoCogQE5MODAyMTFfTkFOX0NBUEFfTUFYX1BVQkxJU0hfU0VT
U0lPTlM6ICh1OCkgdmFsdWUgdG8gaW5kaWNhdGUNCj4gbWF4aW11bSBudW1iZXINCj4gIMKgKsKg
IMKgIG9mIGNvbmN1cnJlbnQgcHVibGlzaCBzZXNzaW9ucyBzdXBwb3J0ZWQuDQo+ICDCoCogQE5M
ODAyMTFfTkFOX0NBUEFfTUFYX1NVQlNDUklCRV9TRVNTSU9OUzogKHU4KSB2YWx1ZSB0byBpbmRp
Y2F0ZQ0KPiBtYXhpbXVtDQoNCldoYXQgZXhhY3RseSBpcyBzdWJzcmliZS9wdWJsaXNoICpzZXNz
aW9uKj8gSSBndWVzcyB0aGlzIGxpbWl0YXRpb24gb25seSBhcHBsaWVzIGZvciB0aGUgb2ZmbG9h
ZGVkIERFIHNjZW5hcmlvLg0KVGhlIGV4aXN0aW5nIEFQSXMgZm9yIG9mZmxvYWRlZCBERSB1c2Ug
dGhlIG5vdGlvbiBvZiBOQU4gZnVuY3Rpb24sIHdoaWNoIG1heSBiZSBlaXRoZXIgcHVibGlzaCwg
c3Vic3JjcmliZSBvciBmb2xsb3cgdXAuDQpIb3cgdGhpcyAqc2Vzc2lvbiogbGltaXRhdGlvbiBh
cHBsaWVzIHRvIGl0Pw0KSSB0aGluayBpdCB3b3VsZCBiZSBjbGVhcmVyIHRvIGRlZmluZSBpdCBh
cyBNQVhfREVfRlVOQ1Mgbm8/DQoNCj4gIMKgKsKgIMKgIG51bWJlciBvZiBjb25jdXJyZW50IHN1
YnNjcmliZSBzZXNzaW9ucyBzdXBwb3J0ZWQuDQo+ICDCoCogQE5MODAyMTFfTkFOX0NBUEFfTUFY
X01BVENIX0ZJTFRFUl9MRU46ICh1MTYpIE1heGltdW0gbGVuZ3RoDQo+IChpbg0KPiBieXRlcykg
b2YgYW4NCj4gIMKgKsKgIMKgIGluZGl2aWR1YWwgbWF0Y2ggZmlsdGVyLg0KPiAgwqAqIEBOTDgw
MjExX05BTl9DQVBBX01BWF9UT1RBTF9NQVRDSF9GSUxURVJfTEVOOiAodTE2KSBNYXhpbXVtDQo+
IHRvdGFsIGxlbmd0aA0KPiAgwqAqwqAgwqAgKGluIGJ5dGVzKSBvZiBhbGwgbWF0Y2ggZmlsdGVy
cyBjb21iaW5lZCBhY3Jvc3Mgc2Vzc2lvbnMuDQoNCldoaWNoIGZpbHRlcnM/IFRYIC8gUlggZmls
dGVycz8gSXMgdGhpcyBsaW1pdCBhcHBsaWVzIGZvciBib3RoPyBXaGF0IGFib3V0IFNSRiBmaWx0
ZXJzPyBCbG9vbSBmaWx0ZXIgc3VwcG9ydC4NCkkgdGhpbmsgaXQgDQoNCj4gIMKgKiBATkw4MDIx
MV9OQU5fQ0FQQV9NQVhfU1NJX0xFTjogKHUxNikgTWF4aW11bSBsZW5ndGggKGluIGJ5dGVzKSBv
Zg0KPiB0aGUgc2VydmljZQ0KPiAgwqAqwqAgwqAgc3BlY2lmaWMgaW5mbyAoU1NJKSBmaWVsZC4N
Cg0KVGhpcyBvbmUgbWFrZXMgc2Vuc2UsIGJ1dCBiZXR0ZXIgZGVmaW5lIGl0IHRvZ2V0aGVyIHdp
dGggYWxsIHRoZSBvdGhlciBERSBsaW1pdGF0aW9ucy4gSSBndWVzcyB3ZSB3aWxsIG5lZWQgYWxz
byBtYXggZm9yIHZlbmRvciBlbGVtZW50cyBhbmQgTkFOIGF0dHJpYnV0ZXMgbGVuZ3RocyBldGMu
DQoNCj4gIMKgKiBATkw4MDIxMV9OQU5fQ0FQQV9NQVhfTkRJX0lGQUNFUzogKHU4KSBNYXhpbXVt
IG51bWJlciBvZiBOQU4NCj4gRGF0YSBJbnRlcmZhY2VzDQo+ICDCoCrCoCDCoCAoTkRJKSBzdXBw
b3J0ZWQgY29uY3VycmVudGx5Lg0KDQpOREkgaXMgZXZlbnR1YWxseSBhIG5ldGRldiBpbnRlcmZh
Y2UsIHNvIGl0IHdpbGwgYmUgcmVwb3J0ZWQgdmlhIGV4aXN0aW5nIEFQSSdzIGZvciBzdXBwb3J0
ZWQgaWZ0eXBlcyBhbmQgY29tYmluYXRpb25zLg0KDQo+ICDCoCogQE5MODAyMTFfTkFOX0NBUEFf
TUFYX05EUF9TRVNTSU9OUzogKHU4KSBNYXhpbXVtIG51bWJlciBvZg0KPiBjb25jdXJyZW50IE5B
Tg0KPiAgwqAqwqAgwqAgRGF0YSBQYXRoIChORFApIHNlc3Npb25zIHN1cHBvcnRlZC4NCg0KTkRQ
IHNlc3Npb24gaXMgbm90IGEgcmVhbCBsaW1pdGF0aW9uLiBXZSBjYW4gaGF2ZSBtdWx0aXBsZSBO
RFBzIGJldHdlZW4gc2FtZSBwZWVycyBvdmVyIHNhbWUgTkRJIHJldXNpbmcgdGhlIHNhbWUgc2Vj
dXJpdHkuIFN1Y2ggTkRQcyB3aWxsIG5vdCBjb25zdW1lIGFueSByZXNvdXJjZSBhdCBhbGwuDQpU
aGUgcHJvcGVyIHdheSB0byBkZWZpbmUgaXQsIGlzIHRvIHJlcG9ydCB0aGUgbWF4aW11bSBudW1i
ZXIgb2YgcGVlciBOQU4gc3RhdGlvbnMgYW5kIE5ESSdzLg0KU2luY2UgdGhpcyBpcyBub3QgdHJp
dmlhbCwgSSBwcmVmZXIgdG8gYWRkIGl0IHRvZ2V0aGVyIHdpdGggdGhlIGRlZmluaXRpb24gb2Yg
TkFOIGRhdGFwYXRoIEFQSXMuDQoNCj4gIMKgKiBATkw4MDIxMV9OQU5fQ0FQQV9NQVhfUVVFVUVE
X1RSQU5TTUlUX0ZPTExPV1VQX01TR1M6DQo+ICh1MTYpIE1heGltdW0gbnVtYmVyIG9mDQo+ICDC
oCrCoCDCoCBmb2xsb3ctdXAgbWVzc2FnZXMgdGhhdCBjYW4gYmUgcXVldWVkIGZvciB0cmFuc21p
c3Npb24uDQoNCkZvciBvZmZsb2FkZWQgREUsIGFzIEkgbWVudGlvbmVkIGJlZm9yZSwgSSB0aGlu
ayBpdCBzaG91bGQgYmUgTUFYX0RFX0ZVTkNTIHdoaWNoIGluY2x1ZGUgYm90aCBwdWJsaXNoLCBz
dWJzY3JpYmUgYW5kIGZvbGxvdyB1cHMuIEZvciBub24tb2ZmbG9hZGVkIGNhc2UsIHRoaXMgbGlt
aXRhdGlvbiBkb2Vzbid0IGFwcGx5IGFzIGl0IGlzIGp1c3QgbWFuYWdlbWVudCBmcmFtZSB3aGlj
aCBpcyB0cmFuc21pdHRlZCB3aXRoIE5MODAyMTFfRlJBTUVfQ01ELCBzaW1pbGFyIHRvIGFueSBv
dGhlciBtYW5hZ2VtZW50IGZyYW1lLg0KDQo+ICDCoCogQE5MODAyMTFfTkFOX0NBUEFfTUFYX1NE
RUFfU1NJX0xFTjogKHUxNikgTWF4aW11bSBsZW5ndGggKGluDQo+IGJ5dGVzKSBvZiB0aGUNCj4g
IMKgKsKgIMKgIGV4dGVuZGVkIHNlcnZpY2Ugc3BlY2lmaWMgaW5mbyAoU0RFQSBTU0kpIGZpZWxk
Lg0KDQpUaGVyZSdzIG5vIG5lZWQgdG8gZGVmaW5lIGJvdGggU0RFQSBTU0kgYW5kIFNEQSBTU0kg
YXMgdGhlIG9mZmxvYWRlZCBERSBBUEkgKEFERF9GVU5DKSBoYXMgb25seSBvbmUgYXR0cmlidXRl
IGZvciBTU0kgYW5kIGl0J3MgdXAgdG8gdGhlIGRldmljZSB0byBkZWNpZGUgd2hldGhlciBpdCBz
aG91bGQgZ28gaW4gU0RFQSBvciBTREEuDQpBY3R1YWxseSB0aGUgc3BlYyBkZWZpbmVzIHRoYXQg
U1NJIHdpdGggbGVuZ3RoIG92ZXIgMjU1IGJ5dGVzIHNob3VsZCBnbyBpbnRvIFNERUEuDQoNCj4g
IMKgKiBATkw4MDIxMV9OQU5fQ0FQQV9NQVhfU1VCU0NSSUJFX0FERFJFU1NFUzogKHU4KSBNYXhp
bXVtDQo+IG51bWJlciBvZiBzdWJzY3JpYmUNCj4gIMKgKsKgIMKgIGFkZHJlc3NlcyBzdXBwb3J0
ZWQuDQoNCldoYXQgaXMgc3Vic2NyaWJlIGFkZHJlc3M/IEkgZG9uJ3QgdGhpbmsgSSB1bmRlcnN0
YW5kIHdoYXQgdGhpcyBtZWFucy4NCg0KPiAgwqAqIEBOTDgwMjExX05BTl9DQVBBX01BWF9SWF9D
SEFJTlM6ICh1OCkgTWF4aW11bSBudW1iZXIgb2YNCj4gcmVjZWl2ZSBjaGFpbnMNCj4gIMKgKsKg
IMKgIHN1cHBvcnRlZCBmb3IgTkFOIG9wZXJhdGlvbi4NCg0KSSB0aGluayBpdCBpcyBiZXR0ZXIg
dG8gcmVwb3J0IHRoZSBlbnRpcmUgZGV2aWNlIGNhcGFiaWxpdHkgKHNpbWlsYXIgdG8gdGhlIGNv
bnRlbnRzIG9mIE5BTiBkZXZpY2UgY2FwYWJpbGl0eSBhdHRyaWJ1dGUpIGFzIGl0IGluY2x1ZGVz
IGV2ZXJ5dGhpbmcuDQotIHN1cHBvcnRlZCBiYW5kcyBiaXRtYXANCi0gb3BlcmF0aW9uIG1vZGUg
KHdoaWNoIGluY2x1ZGUgVkhUL0hFLzgwKzgwIGV0YyBzdXBwb3J0IGJpdHMpDQotIGFudGVubmFz
IGJpdG1hcCAoaXQgaGFzIGJvdGggdHggYW5kIHJ4IGFudGVubmFzKQ0KLSBtYXggY2hhbm5lbCBz
d2l0Y2ggdGltZQ0KLSBjYXBhYmlsaXRpZXMgKGRmcyBtYXN0ZXIgYml0LCBleHRlbmRlZCBrZXlf
aWQsIHNpbXVsdGFuZW91cyBuZHAsIG5kcGUsIHMzIGNhcGFibGUgZXRjLi4pDQoNCkFuZHJlaQ0K

