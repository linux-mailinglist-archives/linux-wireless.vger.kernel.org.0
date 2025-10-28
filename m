Return-Path: <linux-wireless+bounces-28342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0DCC152C1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 15:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2C513544B1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F946204F93;
	Tue, 28 Oct 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctrQT321"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CDA288D0
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661882; cv=fail; b=MMTBTbUz4iQRJYY62MiArMxbMc0FdRr6XXZjCAEpXaPRjyoOaaHOPBguJ8JIN0ObFDVhiCXAvVlgxVnDXXXWnKT9VU2zk0b8NragwSR+43Gh865FsYRCsUY1DBxytPzZ9v8UpTBEdZLj3eHuJnPMqlRY2PeqD+t2HSopdVco4nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661882; c=relaxed/simple;
	bh=rU0MsYpe9kpQfvUj3W+GiX3JBCZxjXY5jGYdQyZxN9g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nZgKFTjPz9k4A+u0lzVAcwLzXAsMTiw2Ha4615WB5EDDRr1ZDZiYjy4EdpnSJk11ncVGIR9OjpTb2M2hTx5LMMOlQ4fntqnpYr2nWu2cpiTgl925NwSMZ3SuhxM0+hsByfHmRpZ5Ku+NLAILZy7qYw5UToBQchIU9dwmHAODv5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctrQT321; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761661879; x=1793197879;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rU0MsYpe9kpQfvUj3W+GiX3JBCZxjXY5jGYdQyZxN9g=;
  b=ctrQT321bSCWfjBGz5CTdMGCphp5qH1dGntErXqQXxu3y6u+hcvqY80j
   lVA/d6U7u3N+QKDRDgJUno3tZYf24arOpJ/jZEoCHFMF864aYTUiihAYv
   W+T+hExu87eB50pGzJrq0VflNXhI20rvPot2Pp14cU9v/DOVnjnlXDsr8
   D7Xeykd2Tqw4eV1UJnvIJUS3Tw892PCrgAdYBwM6se2ZmPdDSlwme30H5
   vRyZGeKs4gHVFbcCWZ5sNycvOeAqxIQAptdYLai5Clnq8UH5IHL3llQ5Y
   hhh3gQecvq4VLbdG9DphEmlLDiDEHU5PLsZV7iKJHCZv2a0KGllMff2BS
   A==;
X-CSE-ConnectionGUID: kTJ8SwHASi2RWQy6xZgFGQ==
X-CSE-MsgGUID: sZs6ASXWT7OSGEVQ14f8Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63670280"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63670280"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:31:18 -0700
X-CSE-ConnectionGUID: Zwor3NGNSpGZjGmM0Teggg==
X-CSE-MsgGUID: zfLclubvQmWlBJPADfQq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="189678575"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:31:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:31:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 07:31:17 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.32)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 07:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPzWAfPSKxcFYPYRgpkm6x/ZgNGURVJ1TS2gEAy6+N6JBC2nHQDvs+nbXo9YjIN6g2mUBC+qZiE3/+YkstpoVoHPCbwK5rxDROllZnWR0yE1gVadFzEvL1DjYOlmitEeXWTCkw0JC8UV2ev1vWeY1OckyyILPKOjAPXLaCju/J4+9hNfJCh8Hn0Ob+H4DpTiH5p/rNUUzgvk1DJGBXqUfDrhRumPWQqHYi5vlk+Rks3vQjY+QRypU1P0SEJnihoM3XYcoWGLUfGQXQTLWeOj+k4gf7L5dsYKRI3E85qLlvab3BRoLCBDZz/zGd9jbhkH5fXo7+wulp1nESoXRhhqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU0MsYpe9kpQfvUj3W+GiX3JBCZxjXY5jGYdQyZxN9g=;
 b=TYWX02UhL//RfJmRZBvtNxtl5sScdB+v4g5983y2vrE2vmcYY8Seta1rZZvauSTbbq61kpcXV/yRLzHiL/43FZw69kCWQqAu7dtzpbGNYciT7SSH9C1SZNf7f4/iQLCnoJiGlCkewn6MqtZnLkPhZjPqA+l8lA3ZYwG52AFI3H1j9YgB8S6kH5GAZqk4tf5/GIE7+7HSEx0QBmLFyBLsARYCOY+JER1dKoDYveNAHVCkC1w1hlumj1s6L/Z9u7axCraoU3GoQzVT4/r/3XekPHl98v06s4P3vOtU6V9/wdR4B+PBoJ36DKziKFrH95vSHWOLuVi7SOTFxVkCNR6s4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM6PR11MB4657.namprd11.prod.outlook.com
 (2603:10b6:5:2a6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 28 Oct
 2025 14:31:14 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%8]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 14:31:13 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Berg, Johannes" <johannes.berg@intel.com>, Linux Wireless
	<linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-2025-10-28
Thread-Topic: pull-request: iwlwifi-next-2025-10-28
Thread-Index: AdxIF4E6Ah9hl1A/QR+06FobHEga6w==
Date: Tue, 28 Oct 2025 14:31:12 +0000
Message-ID: <DM3PPF63A6024A9B77EE7385B4C865E3E54A3FDA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: 107e083f-5b92-4c3e-31f5-08de162ea545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TjRtMEJ3Qk54UXhnV044TXY1UXUvUWlUUG9BbHRVZ0ExOUZCNHhVRVFGUThU?=
 =?utf-8?B?NjNwNFlHVnZkNjQwazZYQ0tKRzBSYVNrUERLem1mcFhScFJmTExneEtQOFVG?=
 =?utf-8?B?WFJNWnVWWHNWUkhDZVpLTUp0b1dMME5uN3Y3cFBWNGtRTVFtaWhuMW81cStH?=
 =?utf-8?B?czNYZzE5REZ5cEZuOW1LeStVenZwY3Y2M1BvRHhSRVNJM1RzQ1o5R1hobHBK?=
 =?utf-8?B?UHRzNHFvWWp1elNibnQyODJuR0hlRFZmeDJiejNMOGk3YnB2ZlBqOHZ2Q1RI?=
 =?utf-8?B?ZXpBT041OWIrclpWYlVNRnVXVkQ1STZRUEl2dW1OKzdtODlacUp1SXYxK1Jl?=
 =?utf-8?B?ZDYzWEhQM3VOWXBGVmFiOXZsUDdGOE9uU1djZDBsVTFKSTFWbHV4UDVoY3I5?=
 =?utf-8?B?UnBpK2UwUkMzeGVmR2hzSm5kT21YNGV2Sm90bTFlendkckpkYTlrSnZGN3lp?=
 =?utf-8?B?S05wVWgvZGxHUlNpZytvalVDUWtjZ2VDYkZpMkdqOGpzNWdRQzB1NTZCY2E4?=
 =?utf-8?B?MkFrKzkzdWZuRVRRSlIxeDVRckt6cU45SEpHeDc5cjBBY2ZqYkdwcHVkd0lZ?=
 =?utf-8?B?Ynd4bldlY2JGRFVMSHNERTBUdkgveENIL2JVNWZ5MWVJNDN6Z0ZxVFBxQmVF?=
 =?utf-8?B?UFVmdHFUeFpZalFRMFk4YXh0cEZJd0FiNDgwbkJoM3o4WkhXN3Y4OVFrUnhv?=
 =?utf-8?B?WmwrM21YQUROMUdhOGNpRDAyamYvUklNWExaTjNKYUN0T2ZGcVFmM2NqcFNt?=
 =?utf-8?B?TmQ2QklYQ0IxMm9BUUVsak5pdFR0UnZzNzNkRGloVjQ3VlpsQXFHcUdsckJp?=
 =?utf-8?B?cFpoL2tlM3U1bjNYblI3NFVxNm4rZGMzRmtaOVlWNXZSNVU0RmNlb3hVMHAv?=
 =?utf-8?B?a05lWFBvL3kzL1k2S3lpaFF6ZE9YWGlwUEtqWklJaldiZ2pVekEwYWY2dUNK?=
 =?utf-8?B?enRWSCtoektUbEdTKzlzYVZsTm90UHpGa1d3aXRMUlJ4a2FlL2Ribkg2TVVJ?=
 =?utf-8?B?aXZ0QTg2L2JKcTg3RGFPWnIxNC82Q2Rmbm41aWRZUUhNZzM5UHlNaTZXS216?=
 =?utf-8?B?UURvZ3k2TGpMNjIvZGtBRlBLTEQvZzJIQ3Q4emJuN2k4cnlqSHJ4NG1LWlY5?=
 =?utf-8?B?UkRuUjNmQzZ4MXY5MWV4N0tsTFZ2R0d3UjBJZmZSU3BlR0hKYm13SjFXRGIy?=
 =?utf-8?B?YUV6L0xUazRHelpWUEEwdTdrSi9FaU1aelJtY20rNytyZUk4VE1sRGRmS2tv?=
 =?utf-8?B?bFg0Sm4zeWhMOXVZNUxxT2E4b05MLzlkRzVUa0ZTa0toNTVJMkVabW5xNHdJ?=
 =?utf-8?B?M1lmbjFPOUU0b2F1cmhhNHlLMlhlMWpSYVFLNFIxU3dhTXlRRGFsTitveE1k?=
 =?utf-8?B?dlo5R1FkRjM1L0RtZU4waGExbStQdklNaklFUUY1Ky9sZU03YStxV2ZrUEk0?=
 =?utf-8?B?eUEwR04yYktnQmF0bTBIQU03b1EzM2o3UzFWb1FOV24wY2pTMGhub0Ixbk04?=
 =?utf-8?B?RE11dTkzdnRURkY1d3pZZUt6NG1GdVJmUnNvajlnbkdnTHNWdFVLVHNITTJn?=
 =?utf-8?B?cFdGVHVCRXlFTUVBK2o5Z3Z6V0FUK1hxZDVFUVVRdVlyNklWYUZhWDR4ZHo4?=
 =?utf-8?B?Sm4rQVhJcHN4bDNIcVMxcnJ5azBTdVMwR1Fnak5VWE1MblZPZzRpZzZZQW00?=
 =?utf-8?B?THFwc2s4bm9FdW85SVNzSVRoSDlzcVpkT0NaeHcvNGR0S3RaZ1dGa0lWMjZR?=
 =?utf-8?B?Q0RDZk1EaTZSMng0WGFaY0lhSTEwZHRUN0FxRzBPMDJ1dzJNUzJYSjBGc3hE?=
 =?utf-8?B?YXpiZzNselBkaVBublo2bm4vd1U0Ymg5ZHVrU2xxNWtrRE9sZDVBMUIyMXNk?=
 =?utf-8?B?NDJDVmhncXMrTjd2WnpMcnhsNGJ0YXFWdkZMTHlZU2FzZFExMTBqSGxIU1NR?=
 =?utf-8?B?RTNMbHB4eTZFUWdQNWVNY2ZLOWtzNitSMHR2TmU0cFgrczlLUEp4V1p3RXF3?=
 =?utf-8?B?b0NucFc4MmZBTEc2T2s4UEVKUnZhR3kzQzVLRzRUY3UxeWFMRkIwQ2VVRXR1?=
 =?utf-8?Q?khmzBF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUVDTUk5TU5TTk45YU1lZ1dRRmIvTUloV0hTYkFvT2xCTGJXUGtvSlo5YnVy?=
 =?utf-8?B?Q1FzdVNkSjIzcyttYTRZdFFGSFpoaU82YytsY3lSYnhDUXBYOGNEcE8rNjc5?=
 =?utf-8?B?aVdJNTB5VjZCdU56ZFJXL0tSSHVSRldjdWNPTVZRek15b1NRcFZ6Ry9WNmxl?=
 =?utf-8?B?VkVPMW1UMWtpSS9ucTRoRlJmcmt1OE9tNy9pMGNFMngzc1pBV09NRWhXTW9H?=
 =?utf-8?B?QzMyd0VqZndpK0NvVXBUWmQ0WnErd25oWDhGK1JvTEUvQVMyNGZvUVhBMHRn?=
 =?utf-8?B?akpaekNpMEtGYWpXOGZyT3QrUWhmMmlkU1ZvRC9QUTN6VHoxWExHSmtZaElR?=
 =?utf-8?B?aENRNUJ0eTZhZ1VpN21Ramp0b0hkeXZobnhXOEJieEFSRTJEZ3ZnTm1CZS9O?=
 =?utf-8?B?ZXN6bzYxd2d1NElEWWZ5YkJnVjlHUXVXUnNWL2RYOVN0RkY4RDZGUUUvK0t6?=
 =?utf-8?B?WnBXaVhETkN4SDYveHF2NWJVQWZqaStSY0xFVDYxaUJUZUZRZ2ROSHNrdnU0?=
 =?utf-8?B?R0FWdVEwbUxJMGgyVU9IekthWkllTERzRkZ0OFM5MG9yb3UrVGZQOHAvTW52?=
 =?utf-8?B?dzdqWXRtKy9TSVc1SFk0MENoNjZwb2RkYUloNEZIL2FUR1NwVlRFcmczYlRh?=
 =?utf-8?B?eGErTHZsWU44UUtxUnNrVDEyY2tmRW1RU25QcmQ1anMwdkFqeVUrQ2NKTnBn?=
 =?utf-8?B?NFNtaGtVRXJ6ZjJ1dVgxQTJCeHA3ZEt0WTlwSk1JVlBTcnBwcFpDZ1FUYnJo?=
 =?utf-8?B?bkM1VWRzWFZ6U3ZXTHZSNDlhWnJQMVB5d0RLVTVIWlh4c3VIZkI3WnpnUW1o?=
 =?utf-8?B?VlVjTGhTZDZueVZUT1dvcjdOMjRmSGNxSTA0UXNQc3Npc0hYK0tKTGg3eUEr?=
 =?utf-8?B?bDJqcXE2bmI0aWNTc3ZNbkx5L1hDSkQwTWQwcGc2b1BvMDBtN1ljTXE1aXpR?=
 =?utf-8?B?MGR5cXk4ZkVmY1U2T0NuQ3I2RnZQaUEraSthMTVaZVhRVzcvRVhiS0dFRW5j?=
 =?utf-8?B?MGprMWJTRmN1MkFiV3Z4ZTUvTURiWkN1NVhvb0ttay84dE0xd2lDUTNSNGs5?=
 =?utf-8?B?RXhRSmpWNVBBQTZEd0pUVm9NalpyTndoWHZKZDBwZWxDWXpPam5sNDVDM2Rp?=
 =?utf-8?B?MUlwSXNpUCtjbEliRlhwZDdaU0x0T1hlVGg1RkpHNXMydk5NMm5ZT2VBM1NN?=
 =?utf-8?B?Mnpmc3RwbHd0UGdYZXNvMUJ5WWVlMnNqSUtUN2NjNnpyR0h3N0VWMndnVzNV?=
 =?utf-8?B?b2tjaC9lT3JrR3FabFRjYVhnd1A1U01YSk8zTzVFS3pVUjhiZHdIWWhUWktn?=
 =?utf-8?B?MHJXMjllN2FYK1V1N1RjaTEwSUVKLzlRdzF2ZVFuajBRTGFFcFg0TmNjOHlP?=
 =?utf-8?B?eUhnb0hNZlYzNUxLUjhzYmw2Q3U2empTMUd3WTdONU1LTjZNc0dDSU9DL1Np?=
 =?utf-8?B?bk1uWXErZUpQTVhXV3ZqQWRnajd2VFU0M0o3KzlDaUJYK0FOWGxLK1hmbm1B?=
 =?utf-8?B?eG1jWWFSVDdDeU03cmw3SHliSlo3RXRWZmx1Rk1JeEY3c3FCbVNqMUZ6Q1k1?=
 =?utf-8?B?eVVTZFZMN2h4c3BsWkNJcE1DVGYrZTF5MUlCZncxNmNCTWNlOGorcWl6Ym5t?=
 =?utf-8?B?cVNjQ2p4dWFSQ1dUcm1Ia3hMSHgxUEIrVkJHdHRqYW5lYmFiWjNlNHdFejkr?=
 =?utf-8?B?WHkrQXA4R0d3MG5KV0NDNEdCbTZ0TFBqK0M3V0svcjczMkNxSXI5MHpoQS9O?=
 =?utf-8?B?OThwTUUwTGlJbFBxMnMxSUJ1K1V5V3NsNmQ4bkhzcEJoVzBYTUtBblU3Q05C?=
 =?utf-8?B?RkFIeERQekNOa3hCZktRMnhJaWZZM3JzTUVvajZvTFFnZlhQWkJ6a1Z6dzQr?=
 =?utf-8?B?WXFTczVzY0VKRkMwdG4xMEJoaSt0NGlRcVdOa1FtS2t2Y1REUTlZWlZiSktx?=
 =?utf-8?B?dUJ0UUpOWEtXZUQrOXJqdW9XeFFKaHgwK05GR3N6OWRjWlBnTW9GR0JEM1l6?=
 =?utf-8?B?ZjlPdnlGWTRDYWgxQWF5RFNTN2k4dU0zNnVVdCtBS25HKzBoY1BNQXlHN1h0?=
 =?utf-8?B?ajlGNmFSeEJub0IyOTdKdng4K0pUVFY0VDU3T09ubjdnVUcxTEZBZXVIVjAy?=
 =?utf-8?B?VVNjWjJiZEt2d0xPYlBDOTVtL3hVUXdIdXphNi9xNnRZVjE0dUlQZlFiTzFs?=
 =?utf-8?B?ZEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 107e083f-5b92-4c3e-31f5-08de162ea545
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 14:31:12.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHNNVVRZCLy9Icjgcr4HA9zBp2RaE5DNAHLpHQan82d4IkVwQnXWBa2GEi2NfbBIghKhluQQdCTkyiB80LgcZ1pQeQqM9bGW+626Am2AfYhOV0OYM/m0ii7allgmI38X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA4OGRlMDgzNDhhZjhjZTE1ZGM1NjNl
MGViYjU1NTNlZGRkODIxYzA2Og0KDQogIHdpZmk6IGNmZzgwMjExOiBBZGQgcGFyYW1ldGVycyB0
byByYWRpby1zcGVjaWZpYyBkZWJ1Z2ZzIGRpcmVjdG9yaWVzICgyMDI1LTEwLTI3IDA5OjE4OjQx
ICswMTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3
bHdpZmktbmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1uZXh0LTIwMjUtMTAtMjgNCg0KZm9yIHlvdSB0
byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDNkZjI4NDk2NjczYmQ4MDA5ZjFjZDNhODVhNjM2NTBjOTZl
MzY5ZjQ6DQoNCiAgd2lmaTogaXdsd2lmaTogbWxkOiBhZGQgbnVsbCBjaGVjayBmb3Iga3phbGxv
YygpIGluIGl3bF9tbGRfc2VuZF9wcm90b19vZmZsb2FkKCkgKDIwMjUtMTAtMjggMTY6MTc6Mjcg
KzAyMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCml3bHdpZmkgZmVhdHVyZXMuIE5vdGFibHk6DQoNCi0gVW5zdXBw
b3J0ZWQgQVBJcyBjbGVhbnVwDQotIE5ldyBzbmlmZmVyIEFQSQ0KLSBzbWFsbCBidWdmaXhlcyBh
bmQgZmVhdHVyZXMNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KRW1tYW51ZWwgR3J1bWJhY2ggKDUpOg0KICAgICAgd2lm
aTogaXdsd2lmaTogbWxkOiBzdXBwb3J0IGdldC9zZXRfYW50ZW5uYQ0KICAgICAgd2lmaTogaXds
d2lmaTogYmUgbW9yZSBjaGF0dHkgd2hlbiB3ZSBmYWlsIHRvIGZpbmQgYSB3aWZpNyBkZXZpY2UN
CiAgICAgIHdpZmk6IGl3bHdpZmk6IHN0b3AgY2hlY2tpbmcgdGhlIGZpcm13YXJlJ3MgZXJyb3Ig
cG9pbnRlcg0KICAgICAgd2lmaTogaXdsd2lmaTogZGlzYWJsZSBFSFQgaWYgdGhlIGRldmljZSBk
b2Vzbid0IGFsbG93IGl0DQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGNoZWNrIGZvciBOVUxM
IHBvaW50ZXIgYWZ0ZXIga21hbGxvYw0KDQpKb2hhbm5lcyBCZXJnICgxMik6DQogICAgICB3aWZp
OiBpd2x3aWZpOiBtdm06IG1vdmUgcmF0ZSBjb252ZXJzaW9ucyB0byB1dGlscy5jDQogICAgICB3
aWZpOiBpd2x3aWZpOiBjZmc6IGFkZCBuZXcgZGV2aWNlIG5hbWVzDQogICAgICB3aWZpOiBpd2x3
aWZpOiB0ZXN0czogY2hlY2sgbGlzdGVkIFBDSSBJRHMgaGF2ZSBjb25maWdzDQogICAgICB3aWZp
OiBpd2x3aWZpOiBmaXggcmVtYWluaW5nIGtlcm5lbC1kb2Mgd2FybmluZ3MNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1sZDogdXBkYXRlIHRvIG5ldyBzbmlmZmVyIEFQSQ0KICAgICAgd2lmaTogaXds
d2lmaTogbWxkOiBpbmNsdWRlIHJhdyBQSFkgbm90aWZpY2F0aW9uIGluIHJhZGlvdGFwDQogICAg
ICB3aWZpOiBpd2x3aWZpOiBmaXggYnVpbGQgd2hlbiBtdm0vbWxkIG5vdCBjb25maWd1cmVkDQog
ICAgICB3aWZpOiBpd2x3aWZpOiBidW1wIGNvcmUgdmVyc2lvbiBmb3IgQlovU0MvRFINCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG12bS9tbGQ6IHJlcG9ydCBub24tSFQgZnJhbWVzIGFzIDIwIE1Ieg0K
ICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiB1c2UgRldfQ0hFQ0sgb24gYmFkIFJPQyBub3RpZmlj
YXRpb24NCiAgICAgIHdpZmk6IGl3bHdpZmk6IGJ1bXAgY29yZSB2ZXJzaW9uIGZvciBCWi9TQy9E
Ug0KICAgICAgd2lmaTogaXdsd2lmaTogY2ZnOiBmaXggYSBmZXcgZGV2aWNlIG5hbWVzDQoNCkxp
IFFpYW5nICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogYWRkIG51bGwgY2hlY2sgZm9y
IGt6YWxsb2MoKSBpbiBpd2xfbWxkX3NlbmRfcHJvdG9fb2ZmbG9hZCgpDQoNCk1pcmkgS29yZW5i
bGl0ICg3KToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGFsaWduIHRoZSBuYW1lIG9mIGl3bF9hbGl2
ZV9udGZfdjYgdG8gdGhlIGNvbnZlbnRpb24NCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogcmVt
b3ZlIHN1cHBvcnQgZnJvbSBvZiBhbGl2ZSBub3RpZiB2ZXJzaW9uIDYNCiAgICAgIHdpZmk6IGl3
bHdpZmk6IG1sZDogcmVzY2hlZHVsZSBjaGVja190cHRfd2sgYWxzbyBub3QgaW4gRU1MU1INCiAg
ICAgIHdpZmk6IGl3bHdpZmk6IGl3bG1sZCBpcyBhbHdheXMgdXNlZCBmb3Igd2lmaTcgZGV2aWNl
cw0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiBjbGVhbnVwIHVuc3VwcG9ydGVkIHBoeSBjb21t
YW5kIHZlcnNpb25zDQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IHNldCB3aXBoeTo6aWZ0eXBl
X2V4dF9jYXBhYiBkeW5hbWljYWxseQ0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBjaGVjayB0
aGUgdmFsaWRpdHkgb2Ygbm9hX2xlbg0KDQpOaWRoaXNoIEEgTiAoMik6DQogICAgICB3aWZpOiBp
d2x3aWZpOiBmdzogcmVtb3ZlIHN1cHBvcnQgb2Ygc2V2ZXJhbCBpd2xfbGFyaV9jb25maWdfY2hh
bmdlX2NtZCB2ZXJzaW9ucw0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBNb3ZlIEVNTFNSIHBy
aW50cyB0byBJV0xfRExfRUhUDQoNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L2NmZy8yMjAwMC5jICAgICB8ICAgIDEgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvY2ZnLzgwMDAuYyAgICAgIHwgICAgMSAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9jZmcvOTAwMC5jICAgICAgfCAgICAxIC0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2NmZy9heDIxMC5jICAgICB8ICAgIDEgLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL2J6LmMgICAgICAgIHwgICAgNCArLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL2RyLmMgICAgICAgIHwgICAgMyArLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL3JmLWZtLmMgICAgIHwgICAgMSAr
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvcmYtcGUuYyAgICAgfCAg
ICAxICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9yZi13aC5jICAg
ICB8ICAgMjQgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL3NjLmMg
ICAgICAgIHwgICAgMyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
YWNwaS5oICAgICAgIHwgICAgMSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9mdy9hcGkvYWxpdmUuaCAgfCAgICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9mdy9hcGkvY21kaGRyLmggfCAgICA0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9mdy9hcGkvY29leC5oICAgfCAgICA0ICstDQogLi4uL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9jb21tYW5kcy5oICAgfCAgICAyICstDQogLi4uL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9kYXRhcGF0aC5oICAgfCAgICA1ICsNCiAuLi4v
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL2RiZy10bHYuaCAgICB8ICAgMTQgKy0N
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9kZWJ1Zy5oICB8ICAg
IDIgKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL2xvY2F0aW9uLmgg
ICB8ICAgIDggKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL252bS1y
ZWcuaCAgICB8ICAxMzQgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3
L2FwaS9wb3dlci5oICB8ICAgIDUgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL2Z3L2FwaS9yeC5oICAgICB8ICAyODYgKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvZncvYXBpL3NjYW4uaCAgIHwgICA3OCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3N0YS5oICAgIHwgICAgNiArLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3N0YXRzLmggIHwgICAzOSArLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3R4LmggICAgIHwgICAgMiArLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvZXJyb3ItZHVtcC5oIHwgICAg
NCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvZmlsZS5oICAgICAg
IHwgICA3NCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvaW1nLmgg
ICAgICAgIHwgICAxMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
cmVndWxhdG9yeS5jIHwgICAyNiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvZncvcnVudGltZS5oICAgIHwgICAyMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvaXdsLWNvbmZpZy5oICAgIHwgICAxMSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLWRiZy10bHYuaCAgIHwgICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWRydi5jICAgICAgIHwgICAyOSArLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWRydi5oICAgICAgIHwgICAgOSArLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLW1vZHBhcmFtcy5oIHwgICAgNCAr
LQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLW52bS1wYXJzZS5jIHwg
ICAgMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLW52bS1wYXJz
ZS5oIHwgICAxNyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLW9w
LW1vZGUuaCAgIHwgICAgMSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9p
d2wtdHJhbnMuaCAgICAgfCAgICA2ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvY29uc3RhbnRzLmggfCAgICAyICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9kMy5jICAgICAgICB8ICAgIDQgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbWxkL2Z3LmMgICAgICAgIHwgICAxNCArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2lmYWNlLmMgICAgIHwgICAxMyArDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbGluay5jICAgICAgfCAgIDE2ICstDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEuYyAgfCAgMTAzICst
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWxkLmMgICAgICAgfCAg
ICAxICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbGQuaCAgICAg
ICB8ICAgMjUgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbG8u
YyAgICAgICB8ICAxMDAgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21s
ZC9ub3RpZi5jICAgICB8ICAgIDQgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL21sZC9yb2MuYyAgICAgICB8ICAgIDQgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9yeC5jICAgICAgICB8IDE2OTEgKysrKysrKysrKystLS0tLS0tLS0NCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9yeC5oICAgICAgICB8ICAgIDUg
Ky0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9zdGEuYyAgICAgICB8
ICAgIDIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jICAg
ICAgICB8ICAgMTUgKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21sZC1t
YWM4MDIxMS5jICB8ICAgIDMgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bXZtL212bS5oICAgICAgIHwgICAgNSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vcGh5LWN0eHQuYyAgfCAgIDI0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vcnMuYyAgICAgICAgfCAgMTY0IC0tDQogZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vcnMuaCAgICAgICAgfCAgICAzIC0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9yeC5jICAgICAgICB8ICAgIDIgKw0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3V0aWxzLmMgICAgIHwgIDE2NCArKw0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyAgICAgIHwgICAxMCAr
LQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi90cmFucy5jIHwg
ICAgOSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS90ZXN0cy9kZXZpbmZv
LmMgfCAgIDI5ICsNCiA2NSBmaWxlcyBjaGFuZ2VkLCAxODY1IGluc2VydGlvbnMoKyksIDE0MDAg
ZGVsZXRpb25zKC0pDQo=

