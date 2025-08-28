Return-Path: <linux-wireless+bounces-26749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC61B39B0D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 13:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7A21C26CF1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB72E371F;
	Thu, 28 Aug 2025 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPRo6y5r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE83081CE
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379313; cv=fail; b=dxdpKBrYxU8vIoKKvNYAxK+2pVFw10qOzcrhmfUcAAKQa7mDakJeq4eRwfQWJC/PSWwpdgdjvUpS/CgGX+JEMWcAQ1/kHk8iZ+7+7DT0kdwJKVuMawmVKIcQ5Fm0M7MCdRLo5VjCt8nX95O2pOgAtsXzwMQ73MptrMZi9lsWoq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379313; c=relaxed/simple;
	bh=vecxKlgfNB7UL4UzP21fy8M32UA1XYrb9CdHywWDx5E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UFmqErpB0sD0wBIceFmKIjgHiKmIbYrDnm5JOkv4DV724jXGABzcuJIc2LhyWikteLRiuBjYqSiKWqhLpxhwIaA4ADgrNagh48uKiiLn9l1MmNFiNKAzzpUjBxKPV5mY2zrtQ6iZypCZLWOYiK4NlCv+tRVSxmtEasRUcLI0h2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPRo6y5r; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756379311; x=1787915311;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vecxKlgfNB7UL4UzP21fy8M32UA1XYrb9CdHywWDx5E=;
  b=bPRo6y5ry6Rv2w+I3YyenheD3UcAMe/E53mlXjLveDKLxxj8vi12RqR/
   K873oZDNAOukh0sgF/guglhZj4hi/BSvu7IutMQfxRvXQuquJwLF51oWi
   JZVZRM27fDsnfn37vuMYJr28+DAA3jI8A0ICwesCaXdOyPi2/bmu4cC7c
   k7AVH7FVZwGx/TzHebRyBc+m4va5p0gNtjBBT1ByAPNHFCrVzgWBxSHrO
   +0GhVfbse6osAZgaMH+7l7h42NGZVIj8N7Tw9nrO4cQrhLDwE6esvJx2W
   H6Xf0HcJyWJ2aGnD+Tnpsum+BMoQjm64+oU7zzFLwPuZuCh9717AC3Br7
   Q==;
X-CSE-ConnectionGUID: bBLgAgJLSWmaZtOnPVycJg==
X-CSE-MsgGUID: sh0B6ya/R7KYhwKY39SegA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="68917770"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="68917770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:08:27 -0700
X-CSE-ConnectionGUID: Ztxoq9YXSRO7dsmqHf061Q==
X-CSE-MsgGUID: NTy9+tYnSwm5oWVmwnU31Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170000554"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 04:08:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:08:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 04:08:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.74)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:08:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWUPiBmZftBiVpB1Bf0nlEssOrZTXu6KmUeTE3CEW5tuRJe4w2XxBX66p01MiJcHQdDR2nja2vBXnbekVRDzyai98igT1sC0r7k/3v2LESoCcbuLgB+qJaC5Xi7zg0+8Ao+Eh//t/a2/B1pJdfDtyTXFHoluTPs7KS914jDy67BE7LvjaKAlpmENDN/wLxqAo1rTCtXXbNfMYvddpNNmbHtIldy9IXdf9itu4JRb0emjS1iqXAYcc/OdGbGhHmYfm1OC7cGqSuwAgjdg7AkhqZgl5nqb+RtFaLhfZRrr97CxvnwJVFEgGcnv9ZdKyl9mUS0doXKhU9MpHqFzLO2cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vecxKlgfNB7UL4UzP21fy8M32UA1XYrb9CdHywWDx5E=;
 b=fNWhJ7O9gXx++IBjNSSIuabWDAn9pHzKrzhgCLmkcZ7bZmH4K2pQ9OhHIuE+WQseKPqw6XzL4oZYpkSnlsrCf8/H/FajHqS9FpEdrsFH4ulKBYe0kzBcte6R3LBoSBnvJDsZ1N5hU5BUqAHDRiHHaCDigv7IqLZp0wKVtlL+ihGk4cF+l/dZ0/3oduSAH9cXuGfo7iGApkHoZbl9RhZwtDWgUzobF8u82ooDV2fRafXbfIVmI565KczrRpJzYA8G0z+YKWPlsV2cv7UwmnWMlF6ad2far/TdiyfpUJEOVtjVooRSqr/phmb3VM1AZAs8LMFLzEmXRLdRPA9RolZpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA0PR11MB7354.namprd11.prod.outlook.com
 (2603:10b6:208:434::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 11:08:19 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:08:19 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Berg, Johannes" <johannes.berg@intel.com>, "open list:INTEL WIRELESS WIFI
 LINK (iwlwifi)" <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2025-08-28
Thread-Topic: pull-request: iwlwifi-fixes-2025-08-28
Thread-Index: AdwYC+TP8xWSwtafSbKSiZw544r8Vw==
Date: Thu, 28 Aug 2025 11:08:19 +0000
Message-ID: <DM3PPF63A6024A98EA6A7483A8ABEF6F498A33BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA0PR11MB7354:EE_
x-ms-office365-filtering-correlation-id: 19beafa0-2200-467a-a9e6-08dde623321f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZDA2dzdaSnBOZHYzM2NvZ1hWRWJFT1JlL3hKRnBXMU5oRnNxWVUxdGFjRi9Q?=
 =?utf-8?B?MUloalVMUzM1d2p3K2tyTFBJb3ZLQ01mY3FoQWtOQmtLR3BSY1h4YWhEdzNY?=
 =?utf-8?B?SXlmT0w0Qnh3eGU3WGRvZUs3LzdMVFpVbGowUFdLckFocjRkUzFrdkNhck9z?=
 =?utf-8?B?MFlIMjJHMXd5cU05U0RMM1VuUDE5SlYvS0RCM0p1aFJabCtveGFraFhwVGdh?=
 =?utf-8?B?cGk1MTNZZkhKTmdobVU0VG1jc0JtdFZNcUR0RUlneGIwQ0lEUzM0ZEt3a0lq?=
 =?utf-8?B?dWdEWGtRZEhxOC9GR3pFN2c4bDY5TUhOaHJ3Vm5xY0VMcEMweSszSXlaQ3FE?=
 =?utf-8?B?Ykg3cXE0NUJwTktUangyNHlSQkkwanJhRDRuby9rQ3Vyc3A3aGVaQ0VPMTg3?=
 =?utf-8?B?ZVZ2MmRZOE9DVU50NFVTcHNUVUovNFhrUFllWEtEYUxiQmpleTh2QjhpTXM3?=
 =?utf-8?B?RjJhRGk3aERPOS9ZU041eVVpUDFMZzJ5NDRFa1h2TUwvanI4OG9lc2xsd2Va?=
 =?utf-8?B?STRjdXZLcHFyQklLQU1NUGgyRlRDdjdQUmVHM0NaL0RlQzRmYXVXVlVNNUt1?=
 =?utf-8?B?VGNsM0FBb1RvVm9IMzJhUHUrb2tFbFZ1TDhzRU00Sk9qVnlQRHZrNEFRTHlI?=
 =?utf-8?B?NWl5ZzErUFFxaXB2ZjYxQVEzYVUvcURnUEdzWTBkcUpZOVZEdEZ1ZlZJbE5x?=
 =?utf-8?B?N0pGWXBQNGpWLzhnNW1tSlhHUVBTMUthU2IxM0NkMnlmcHVPM0FQa0R1YXFP?=
 =?utf-8?B?dXJKdnlDRTlHbXF2OHhFdEpWc2hVZjVZenlNNmgyYUszd0NFUDQ4SDJ6dEZP?=
 =?utf-8?B?ZjFsRG4rMkk1WjB3SEg1YmMxendvRERaazR3NHJtMWVOSkdBV1p5eE9ad1g2?=
 =?utf-8?B?RzJIeEtvem16OWZkT1RPVElXZ2UwekVTSXlCSUswWUlkNFpVUXZtcExteTFn?=
 =?utf-8?B?R2crMlNycFR3empsRUw4bEsyVGdiY1dmZFVEMlErTEdhUmVxMThZdVp1OVRH?=
 =?utf-8?B?TElBZnJFVWdzU09ZRjc4SDhveEJuOEJiNS8rT2lVeWVsdnliTG9PeHdmV2gv?=
 =?utf-8?B?QXVQYVdpNkcxSTRqZWxmbms1cU1WeVJ5V3Eyd2R2cFlKUnlnYzZLMThrMms3?=
 =?utf-8?B?aGFaV3pwaEozdlZSNjRVTzNoNUNVeWhoSFlWWThZMUJ0VjUwUTI2WUdPNjBo?=
 =?utf-8?B?Mk1MZDlkMkxxK25OQ1NXVkFJNEMzZFlKQ3o2RUNQVlJVUWxvMFVpUUpJeThW?=
 =?utf-8?B?ZlFZU3drM3RmY09ublAxM0ErVlZCTGdCNU00TDBrUWdwZ0k0b2tXc3lGUE5i?=
 =?utf-8?B?NjhpVUljMEMxc01iNXBjYjdKZmUxSGpmVHo0dEZ1cnBLSUZBUk05a3FWYlNH?=
 =?utf-8?B?M285djExMWdhUkZLemF5QVVvMUNsekJUWFFiSXRwK2JIM1BJUnZTYXZ0TnV5?=
 =?utf-8?B?SEhpNWNhL2orQVA5UmNSUVhZTEhsZ1J1djZ0bVdBSE5adVA3THNkMnJKaEtv?=
 =?utf-8?B?MEk2S043QzFsWUVkNENvMjFoOE9jZ2gxZExwbjd5ZFhkOW1WZXRiVXExYTVE?=
 =?utf-8?B?Zzl2RWFZeGZBeXBFem11cVZpKzZJbmtQZ01zQ2JCbHZTN0N0b0NSOThQSDFG?=
 =?utf-8?B?ek5oZzB6SEZwa1RXRFRPbFgvYWFUanJycW82eVdXNFRWSmJuVWZIUk4yTlo4?=
 =?utf-8?B?UkdFL0kyVk9MSmI4QkNSenJvQ09abnhybDBzeWdnazE4MHQ5cUgyV3pHYmhi?=
 =?utf-8?B?MW5Rb3ZPWGJUK01id25CV2R4RngwcGgzemdNWFMxdy9NajdXbmNacy9ibXVF?=
 =?utf-8?B?SUJjNDFIZ05jOE0reTZ6UEEwV21wTllkOXp2UTdCTnhFR2UwVTV0VE81OXph?=
 =?utf-8?B?N1FlYUJ1MjJZZVZrS1ZpUXgrTlJYdXUwSDlxSmtKYTU0TlBqNngxNE1FSTdr?=
 =?utf-8?B?LzB1ZGhGWnpPQ0JvZWsxL3NhK3JjN2pESHVnQUp3c3hSc1VyMmE2VWdqTHRM?=
 =?utf-8?Q?zUz/MoHthUM+shyoGTLCnkCZEfOTaA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hFQUEyaFNiVTlmZ3l3MjFCNkhVb1F2Q3I4cm1Lb0ZQSTB2M3JrUndPeEZJ?=
 =?utf-8?B?aFMvRFpyRFI2TkFOeUFhemRHSkRjbUxOLzQxdGVheHY4dGlXWE11Nms1Y2hF?=
 =?utf-8?B?QnkzUnVhVUV2ZWp2N29EbE44ZEZxM2pSWHZvcThCc1N4YjRCUHNKWjZLb05B?=
 =?utf-8?B?S0pkNmY5ZzM0NXdGQmpIMFM1aXlnMHp5bWorbG9vNmNuOWRtM0ZzNTlTcGtx?=
 =?utf-8?B?TjJjWC9EU3ZOeXlsdU9LTjljdzlPVWVrNXZGREJ3RkJ3MjJ0a2p0N3g3MWNp?=
 =?utf-8?B?U3U3N3BuTDRHS3h3T1o2YlJ6SkdNb01nOU56WDBXYlZjQ2R4QjF2Z1hNUGgz?=
 =?utf-8?B?RmVqWlg2MGJBdUhEaEk4S3ZrZkVIaHZtUWNhWUFzYXVUa0M0N0VESTcyWXhY?=
 =?utf-8?B?MGtWcVMxZGp4VkJMbzNjck9SOHdIZWh3N2h6Z1NTeG5OOEYrZ0pmVWF4SjB3?=
 =?utf-8?B?K3UxcGlaRzlub09teWZYWHBjVkdzTDNoc2JRTlB4b0pCV1VISmdUZkVjUTRW?=
 =?utf-8?B?QWRjUUZuaXludEhGb1lEYUZsOHM5THB0aFdsR1piV3U1djdJM2RtL0M1QnNi?=
 =?utf-8?B?czlUN0V1VC9kWitWVWZQNGllTGFvdzVQRzgvZThzZ0xZRitNeXpoVGFzWXBM?=
 =?utf-8?B?KzdsQVU4ZHJLRWRVMktmTDVTZ0ZJRlVrcEJKTzhFSTh2cEUxTHNnaDFuNlh6?=
 =?utf-8?B?L2NiQVhaR1RaaHcrN0dCS3BOcTB1VVZFUytGTWxuaUZkSndqQkwwZUxlT3Fo?=
 =?utf-8?B?SFcraGxrYjk5dkZGdVA0SEZwbjMxWndnZ3oycXJnWEdCSUZhUGdsQVJVVUxP?=
 =?utf-8?B?aURpL1RLVlNsWFY0YjdEaUJJMkF4NVVYK2dZYmF0Q0dwRFNoM2lmTlhNTnFQ?=
 =?utf-8?B?WGpqc3NMaERpWUdVNi9pZXhIMlZKanNHQ2tORUVqcXRsNlJWM2VkM21XYU1V?=
 =?utf-8?B?empjdXc3L0tTWG5iYmVkcnlaTzBpSHkyWDJXb1dqcHFsTmNpbFRWeDNWZFFp?=
 =?utf-8?B?V1lXVnpQSnNxNjg4ZnlVSDN1Tk9rZ1FRaFhyTnM4QWZjMTdySFFzdW41bDVw?=
 =?utf-8?B?emx0dTNEVUlIcjhJVDZJVTlZcjBVaytJUURsYlZrSjRkVlZhNEpDcDhjeUFH?=
 =?utf-8?B?M25hVWxpQ1NKWFpmbUVoWGhnbzlnZ1hpaExPQTVDR1MvclByME9WZDQvV0tD?=
 =?utf-8?B?OWNqbkpXUFczS1M0VUNMaVZJM2UyVlVpM3NCSWtsME5NQ0VEeVM4Z2p1eWhn?=
 =?utf-8?B?TFRpYTVrOHg3b3h3Q1loT1Vqd2JXeHNQNzJnY1NEOFgxUEN5T2p5a3RyQ252?=
 =?utf-8?B?SFJvT3BlVStZbHdtYm5mcy9xcmtCbXd0eUhtU2VtNWVCYTZodlhTcXB1OWFO?=
 =?utf-8?B?R0NTUnlsa1gxYXVhNzh0NUJFYkc0bmJ0c0o5WVhlS3ljeHFseXBxTUE5M0Jm?=
 =?utf-8?B?R291czYyODNCdURhbzFTSEJxK3pGN3Ywd1VkRnhNTVFMVFJ3Vk1Cc1NIaWZN?=
 =?utf-8?B?V05IaEFLdWMwRmUxd0lyemdja3hraTJsUURXY1NNZkpsQTlORjFUMitvS3la?=
 =?utf-8?B?Wmc3UVVLVzBlWUhsbFdsQVpvNVVwcVNiamtRZU5sRGtraTMrazlWNVpHamtI?=
 =?utf-8?B?TUxVQk1ZUmhjVHpEeHpNanovd2U1UEY3TnRuRDRPMkpGUG5hb0QxeWdUSEp2?=
 =?utf-8?B?YXN0TE5reTBtYWpkSXBNWlBPWlZibDNOUlM4UWc5R0d1cElUT2JKNEJKVThl?=
 =?utf-8?B?TUlqQ3ZTZDQ0cWxNK3pQTVhYUkJCRk9OeklkRHUydEtPa3YzTmNSR1gxOGlH?=
 =?utf-8?B?OU56Y2ZEb3ovL1FITHNacmg2bThMRm9oU1JiV1I0YzZCUTFhUnBsM1IzR2RX?=
 =?utf-8?B?bm1jWlpQZWM4TjkvRjVubnpVMTl3eEtCbzhSNGxXWGFDV2lzbDlxRjdYTytk?=
 =?utf-8?B?blpINU1mZUtLcnE4T1Z6OTdIWE5xUlVHSXdlNE9YRjZ2bHoyTXNMWHhMK3JJ?=
 =?utf-8?B?UE5Wdms0RVc1TDJFSEUvMXV2cDBST0tweUFNY2NuNC9NazdLdUQrRVIrUXlI?=
 =?utf-8?B?WnFlSGUvbFdWdERIV2RTcXlEb0VPc3JyT0hibkRKMDQvR0JEQUliSnF2cUYx?=
 =?utf-8?B?Z2l2eTVvQlJZd3M4TlplU3l3K2ZBT2FsUk5PcUg1aXowM1JVcHBlL1lSRFFQ?=
 =?utf-8?B?NWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19beafa0-2200-467a-a9e6-08dde623321f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 11:08:19.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6ZEIi82JS9q1f0isIKFfjJQH9y/SAv0fnO34TTGtflbQZgeKDpW6/1h4swE55bhu3JhgFjv09Di7yUYela2rNY28n8rxtgXnVD59cIPT4rli7+H+0O/ClNXK3EIIJ0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkOTEwNGNlYzNlOGZlNGI0NThiNzQ3
MDk4NTMyMzEzODU3NzkwMDFmOg0KDQogIE1lcmdlIHRhZyAnYnBmLW5leHQtNi4xNycgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JwZi9icGYtbmV4dCAo
MjAyNS0wNy0zMCAwOTo1ODo1MCAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJl
cG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMtMjAy
NS0wOC0yOA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZmRkMzc3M2EyNGMzZDcz
MGJmMDFmYThkN2FmMWEzNDQ0N2FhZDk4MToNCg0KICB3aWZpOiBpd2x3aWZpOiBjZmc6IGFkZCBi
YWNrIG1vcmUgbG9zdCBQQ0kgSURzICgyMDI1LTA4LTI4IDE0OjAwOjQ1ICswMzAwKQ0KDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQphIGZldyBmaXhlcywgbWFpbmx5IG9mIHRoZSBjZmcgcmV3b3JrLg0KDQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpF
bW1hbnVlbCBHcnVtYmFjaCAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBpZiBzY3JhdGNoIGlz
IH4wVSwgY29uc2lkZXIgaXQgYSBmYWlsdXJlDQoNCkpvaGFubmVzIEJlcmcgKDUpOg0KICAgICAg
d2lmaTogaXdsd2lmaTogYWNwaTogY2hlY2sgRFNNIGZ1bmMgdmFsaWRpdHkNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IHVlZmk6IGNoZWNrIERTTSBpdGVtIHZhbGlkaXR5DQogICAgICB3aWZpOiBpd2x3
aWZpOiBjZmc6IHJlc3RvcmUgc29tZSAxMDAwIHNlcmllcyBjb25maWdzDQogICAgICB3aWZpOiBp
d2x3aWZpOiBmaXggYnl0ZSBjb3VudCB0YWJsZSBmb3Igb2xkIGRldmljZXMNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IGNmZzogYWRkIGJhY2sgbW9yZSBsb3N0IFBDSSBJRHMNCg0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYWNwaS5jICAgICAgIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvcnVudGlt
ZS5oICAgIHwgIDggKysrKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZncvdWVmaS5jICAgICAgIHwgIDYgKysrKysrDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9wY2llL2Rydi5jICAgICAgfCAyMiArKysrKysrKysrKysrKy0tLS0tDQogLi4uL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZ2VuMV8yL3R4LmMgICAgfCAgMyArKy0NCiA1
IGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo=

