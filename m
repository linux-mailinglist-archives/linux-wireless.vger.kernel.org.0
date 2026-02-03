Return-Path: <linux-wireless+bounces-31499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHtIDYT0gWljNAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 14:13:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F918D9C24
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 285DC30268B3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D234D4E0;
	Tue,  3 Feb 2026 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoAYrvZ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6134F257
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124237; cv=fail; b=Zd8yE5sX68I+T7P2OobFqai3y4KGFu4l5cHg2SSEFj8HK5fs+8XHlRI1LbHK+mUSb69LxPVWFHNIuwFdlEThXcFRK4DeqosVAJIi5imTX9c5lErU/xzYeH7RFn07Z9XeHnxfjwj7Nl3AUog0dF2gV7ZUgjI9OClRtSLYmpqU0Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124237; c=relaxed/simple;
	bh=/l1q+X+mkTcaF8c+Hl6GgOMOG5m+nCXvwTLMvjF878s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QCq4ibVmJG4XSChk5AAFuRdy4EYs/sEALMrZfcWIjDiplGLeLM7UeZ8InECJukfkPRglwu4csJ4/6crvmUjFZ/Oo/ikmb8Iwa4IYwXeGu5yK/zjS576fh4se5pGZC5qtc2F1uom3RBe60ym2dJh1WzsdlbGdhJdLzQZep/X+yEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoAYrvZ4; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770124236; x=1801660236;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=/l1q+X+mkTcaF8c+Hl6GgOMOG5m+nCXvwTLMvjF878s=;
  b=RoAYrvZ4nijf3SKHwp0n2/96pWbU320YTCOHK6hu2/q2gzsCYP5ayrgp
   6yWQ8HoJesD7a/TqMYiI1a7VNgn152Wi4yQ4RB5pTF81O2mZCvj5M6uNs
   ews4sBKHDxvj2pHFgLX9B7m7BEyx43qvrawTIZSZAyAMdQ3CS4dCgvjmD
   lsxUQ5qXDHJocvXBRYjQly8M8QFSEDB5GqbpHnSksE01+CqtNFFVLv6Em
   3C3HStTkstRRkdqngFjgBM/saTJOTeh1mSy8kHbCLz4GRXSsksYbxIvFA
   Cg2PO9R3ZNK+JPXf8f2i1WLNuvsJ/dHRXz6K+2MA47kGvC9hTdBw1n6Yo
   Q==;
X-CSE-ConnectionGUID: yEzzAXfHQlaYPul7A5rtSw==
X-CSE-MsgGUID: BLuhtGw8QpWbr/jLIA0ptg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82718186"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="82718186"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 05:10:34 -0800
X-CSE-ConnectionGUID: AjlmJtImRNK1ZBugHcTSbg==
X-CSE-MsgGUID: 15KMwerbSEur19ndnntXQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214372411"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 05:10:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 05:10:32 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 05:10:32 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 05:10:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBtS0Ode/UjE3gS9KcrFBJoMFvu3w6iMTqVFPhf5DUyGgbrUeo9DvgVj7nRpK6Q3oymo0ykhpleckgFUQHcJkgTc0gnkRHkf3JjKKWlWyovHrqEJIrGUeeG8H0Jq6DtRLehUijHU8f9UZkCDPQu2L9yzH1S24s3Csz10cagZ2TmWI4GsvZhU/telteIyElb6QWS6r6hfXMpd79jUO4eYQJU4B44DjyzY8LFwDZTyUKEWD3UMaD2ZuhUBNg3AGHIp+SxehcgB4ZTD4e1J1+S0QLM7HdrQ9U02R2KrvJLHKUKJSOT8+Lj9t+9L9Hlj1LFLT65TPFrqOHcXAlsYCtZuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l1q+X+mkTcaF8c+Hl6GgOMOG5m+nCXvwTLMvjF878s=;
 b=lSDdSMEAz6i+bk7KscrqFh+lOef9cbFV0ciRNoHJpS39FZYHV51G4TLtOlaV1uVErLakbdsqp6qQmbIaJPbH1Rf+tuS/hWj7g/FhSSpiWyMEvjYnxM0x5lsYKPjB3da56Ba+Nmn2aDjUcy9orANNHwR3lUmRHh2rmf9uzMzIu4Ji73fVVt8GTsWyoH3bA8Vp+CA/iX/I9DyFxUP+2PIjgs1VRIf2bR8y+gNKEj/iSX7oYKPxcnXUzvHnE24DVZTxYXOeHZTBB1xa6Iyi11r4oeBlz/xdBltzJn1HTuA0PzEceynfMKH4ivEzOtN9PT27OccbJSZ/bWCutdEWtTRghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS4PPF30373102B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::1b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:10:25 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:10:24 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2026-02-03
Thread-Topic: pull-request: iwlwifi-fixes-2026-02-03
Thread-Index: AdyVDlA/1Pj69JRZTba8b+hqsKO/Rw==
Date: Tue, 3 Feb 2026 13:10:24 +0000
Message-ID: <DM3PPF63A6024A96ED9308FB7C091E4D350A39BA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DS4PPF30373102B:EE_
x-ms-office365-filtering-correlation-id: 5b87c958-0f81-4d59-b9d8-08de6325980f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SmNQVDJEMCtNMGRqdms5QThMWEdHMnNzZUZHQzEwaEREMmc2c2t5b1dnQXA5?=
 =?utf-8?B?UXRHSVc0cXNUUzZkNFpNWC9rMU1zVUtsRkxJUUZVSHc2bCtWSlBGelZZTlZa?=
 =?utf-8?B?bWxESmRxVHRsVldRcm8yekdISkRlWlAwYVNJMjFNcHJSQXgzR005ajZ6dENy?=
 =?utf-8?B?UFZMUFcwUGVJeHhxSUt3TG8xR0djNUpXc3JDaXA2YlY5UFRpd3E0OHJKU3ho?=
 =?utf-8?B?RnM5U3lJRU43dUY2d3RNdHRrRU9Yb3ZuS0NIU2Nra3VKMGdWK0dCM05pOTly?=
 =?utf-8?B?cFJobjlma0Rqd1VBSldmUnpMNllMRjRKYmxkOVZYQmNIN0cvZXRONi9NcmVj?=
 =?utf-8?B?cTNpL0RnSUk0bkYxUXlXVUJRQy9ZMVE0ZG5BQTZtaFdmN0RmeVN5MU0yUHN4?=
 =?utf-8?B?OC9zN2RnTDk2bmZSaUQ1Z0xIMEl0enFiWExzOCtxU1dieDlTd0JXeXpyUzdK?=
 =?utf-8?B?Zm1Qcm5mNmZrc2xOSjBOYzRtM0REUXpveVAyUnRoZWpKeFZOV2t6cHl4UzlO?=
 =?utf-8?B?cXM2S0NsNzQyNlJPRytzWmxFMzhMTFVZSk9KVmR6dmJvZlpseXhsRHFjd1By?=
 =?utf-8?B?Q3c5cEFnck5lRmczbFAvdTdPZmZ3MmVvMktyQnkyUlk0TW8yaXVWQm5HbTU0?=
 =?utf-8?B?cWhMcWtrRWJJaDY1OVJNU1lLTmZabktsVEZJM0NmMjJyVUhFakRhV0pDWWNC?=
 =?utf-8?B?YWtOdzQxL3Jpdjg0VDlzWXZtMmZhYkFKTzJNZFlMYVZSZGVBNkdLd3V2b01X?=
 =?utf-8?B?TFdOcUl2Sjl6dE8xbWpOQ0wzZmlkeEZ3S2lPUjBBaWFiWGFvbG5zMmM4ZHZt?=
 =?utf-8?B?ZGlaNHpTRmFtY2t2dkhLV2dsdjZqKzd6OEhlYnd4RWtDdEFrNzIyTGhOcnRo?=
 =?utf-8?B?R3M0UVo4aDU4M2NJYjMxWmJoMWRXZE1BcHB1bmUzL04wQkM0ajJ2RVp2VkFY?=
 =?utf-8?B?anhJUENsa3d2dXFybG14bk1sZEJ4K1NKbWRPRTQvYmlZVlo5NEhCYXArZVN2?=
 =?utf-8?B?ZnBlemxac1E0OStvbzg1a3EyQU9abGY1bTVEejIvbGxaZFluNDR5ODZoWE1Q?=
 =?utf-8?B?c2RMZU5KRmFySXZ5OXBkUVIrSytGcWpTNUt2aFFicUFxMW02dVBNTlNTSmJC?=
 =?utf-8?B?VGxsS2FyN0tKaFBiaUtIRlJFRisvT3pYTjl5c0ZnYXNpTVVCdXNxTU1QRmxF?=
 =?utf-8?B?L05UR1B4ZkppUGt4VityUGd5Y0Q3M0wzREtRMzhNeVpza0l2aTZYczdnMFYy?=
 =?utf-8?B?RisxTFBZUUZwNVhaRTFjWWx0QW9LV1BLOG1zU2IydVErb0xlOUxKQjJBdG5l?=
 =?utf-8?B?a2JPeWwrc3d6Sjk5ZmJOVTRxaEo1SlppMjdVM1BBTStJaUFuakdzVzlyUloz?=
 =?utf-8?B?bGtuM2xtSVJFMktCSmhZRXdxdEpzUmczTHczNy96blVFU21kbTk5d3M1YjBj?=
 =?utf-8?B?Qkg2ajBYQmFqa1pyRzZ0TXJJSDByVXVMRDhuVFJiWkpmN25xSGZ1ZTBuMm1Y?=
 =?utf-8?B?aVhuaTRYTDNCdk5KWHNhK2FmUXpWMnB6eENtOUM0Z1JOVU5pRFNJd3JkWTcr?=
 =?utf-8?B?QlRqeThZajg3ZU9rL201ZTE1VkQzaUJiVGhZZFdObmJ6dkRtTDM3dGpLZnk2?=
 =?utf-8?B?YlFhb3Iwdm5LNDFjOEZEdWQ1U3RBWmpNTmNJbk9YV3Q5Z21LZnRpVWFLdUo3?=
 =?utf-8?B?VmtWNTJmc2J3NW5PQmdaeWFVVUdoUndlV1FzSGJvZGgrWmtqVE1mTGRneWtk?=
 =?utf-8?B?Y2dBTjRSYjJnU3FaV2hHM21rWTVKQ0JmTDMzMlJ4bVhyei9ZLzFBaGw2eEp1?=
 =?utf-8?B?TTU1c1Rlb1NQQ3VwWWNqR3RPNDZYSFVjeE9KcW45ZEQxZDcwWlVGcng2Vkgy?=
 =?utf-8?B?cDFPQVIyYWZzNDV2OHJnTDBLT2F0Wmt2VmZVcDZtWWhqeXQxc2JwQ25pS2xi?=
 =?utf-8?B?cHpYeFB0ZjI2V1RVTitqQlRodVdCWHl3NVhUNXBMV09nL21CeHcrQ0hPSVht?=
 =?utf-8?B?Sk8zSWNVam5tK1l1S0xRZXZ3cnhjK29ZWlVhNUNOY21pdTBoZzlvZFJpSm5B?=
 =?utf-8?B?RkFGR2ZGRk5Eajd0dGc2dlczaXRQSGVtV24rUGlMQmVwcFlSN2UzM2pMQ1FL?=
 =?utf-8?B?SXlmelFobUNDQjFrTlhpcnJpRlVtRFpHV1Z5TVVlc25mS1dPaWs2MkREMVA3?=
 =?utf-8?Q?qTGRY4DUI/bHwRDVpnsBCAg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmtwd1ltQXZuQzgrL1F1WkRFbW93dG5YOXhLRVAzdU8zbUxpZGhFS3FFZ1Yz?=
 =?utf-8?B?WS9qOWlNSjh6RG1JQnJtcmtEQXBPYWNTT2dvY3Q0ZkxEMmpYeGNxODNmT0c1?=
 =?utf-8?B?UE5vYk4zazJqVGtjTk9OOTNVYzJiZllsWVg0UWp6ejBac2svYzM1M2xWN3p4?=
 =?utf-8?B?V0lzRlFqaVFINDFNMngydkhNazVYWjJQNWZiSTFvbGxIckhwWWlFaEpnR3hD?=
 =?utf-8?B?VzFQRDc3UDBCYXVNYnVOTUY2OWVQaVExcjN4QWJndndaWUFDSGZBclErV1FR?=
 =?utf-8?B?cTdldkVqbFUzN1JjeFFGYzM3bEZIUHBKaE82SFQxNE04S05ET3g3RGVOdmFH?=
 =?utf-8?B?U2QxNzh2bi9yUVY0b0l1V3YyQURpSzhadC8wak53QmtkUnA2YWlJR0l4YUNm?=
 =?utf-8?B?NFZIeHcyMDBKNGlRdjJHK1JSRHZoSy9zYVVmc25tYjBkc2tST3RxMHBpQ3hV?=
 =?utf-8?B?OTd0ZHo3OCs0cVMvK3dRTk9PRjluYk5JeEdUV2x0VHdiM0lWanEzQ1FPLzhi?=
 =?utf-8?B?eEpLcCtLemZVYk1wdVFWNGNZVzcvRlBTK1pCVlhTMU9idlp3TkpYNnVQOWw5?=
 =?utf-8?B?OFFrSHRQYW1MZTU2Skl1c04ySWp5d25YemxJUDJJejViR0VHZUVma3ZCUGF2?=
 =?utf-8?B?a0pyTHFkc2FkMHRacCtvNnJlUGxhYWovYWVIV2srNnpqUjhaemJQaHo4WlQv?=
 =?utf-8?B?UHRyMmVFaEZ5SU85aEtLVTR4Mnd4ekFRZXRJTVlBTkpaL05ZbHl5V2hmNS9x?=
 =?utf-8?B?NjZ3VnBFZXNyRDZCdTkxWHVTV3I1Z2NKZWowWjBxdnJJVkVTTGc5QXdvYWJ1?=
 =?utf-8?B?K3c2T2poZXMxODV1U1BySjVkYW5uaTZLeUh5K1RkVlZhRTBQbjk4YUdCeCsz?=
 =?utf-8?B?eDFqRVdKaEIrWUw1a0RPeE9WZDBLbERNbWZ3bXFNVEN0ZEJDL3lnQ1hjSzdF?=
 =?utf-8?B?SjVJN1VUOWVZdXdrS212RHNBMmpqQ0ZaMFBWVDlYSklVUVBpYWkvWXpkYlpE?=
 =?utf-8?B?dVlmWit5MzQvMEo1T2o3MlVvV0t3ck0vMnlIU0FoSTNvbW16a3VHTGZCVmdT?=
 =?utf-8?B?T1VPWkNwVlJ5ZGcxSkdSWDJ0c3daTWtrQ3hyVmwvUEMxOURjK0dFZSt0bkdT?=
 =?utf-8?B?QnBhTFZ1aDFETzVSbFljcjdmS2J1VVU0NVE2eEZ1OFdXTjAyejhwai9NSXVk?=
 =?utf-8?B?M1FsYVNGMG5Ha0wwUlFxUTI2cmd0eFEzRXE4V2tSWEY5Q3lUQURRemxvRzl5?=
 =?utf-8?B?NitKeWJyUTY5MU1QMmxPQzN1RXp6dEpLbWpZd3UyclhGdkpURUk1WkVUV0dj?=
 =?utf-8?B?SnYxaWFDRm9LUGx3eUVEZUVuV1dJMmpWVVpQSWZJVld3WnhOaUxQWVM5QWc0?=
 =?utf-8?B?STlQYXlaRW5vYXhJZ2JkNmp0cFpMK0xpSmJnQkpBUlBFNXpjRjRFR1RjN1Vr?=
 =?utf-8?B?UVJrdHowUkE1aGhaR0J1YmlLdGhXTDlBODU4MGI3TnVFRy96WEkyazByUFVI?=
 =?utf-8?B?dkdIZVdZamFrNE9XUkNYUW13WEo5M1BkSVBUM2w0NU1jRTdGSWFiRmJ3djQ3?=
 =?utf-8?B?dDdMSy90LzZXWWlmc1BPUXdPdUFnTHFuNThxOUZSK2YwN2hyQ1FPN3V2Um9u?=
 =?utf-8?B?d0ovc3dJVWlOOTdoV1UxQjd6UEJ3N2pBY0FRay8xNTFDd25KK21Xc1ZkbW9o?=
 =?utf-8?B?RGJKQ1F1UUwraG5sUUs4YysrSzhYUkRyWUJYYURpOFFtS1ZUSTJnZ1N2SExp?=
 =?utf-8?B?NUFubVVmNzNHY2pyK3hWeUpheXdYQVZHMWxVMXhqcWY5Sk9PQW9icXVxdnRl?=
 =?utf-8?B?Umd0bGNwVDcyRDlUZ1A5a1UzZ25FSFJXQTJudHRWRTRVbGMwMElOQXVzNUV6?=
 =?utf-8?B?Z0Ntd2VBM291ZUtEYkxDcjVERUF1VTVHUXpIT1lVZ0syUml2MWRPY1BtbHlr?=
 =?utf-8?B?T1BHemNCK1lYOEU5dERpelZYLytaS0dkODMvMkNWK3BzR1BVbzJTckNkZUxY?=
 =?utf-8?B?amJncGxkN0I1N21nUEZOR3VsS3BVNUhZMmx0Unl3dVFkeU9JR0MxS1IxVU9x?=
 =?utf-8?B?UUVZQlNYd2RaN3pBaTdVVG51ZmFtU0pFNS9JSHFFZzlVRXNBMHNNVmFZMGQr?=
 =?utf-8?B?a3FGVDJZcHRNYTVtcVh4ZlFYc0ZCd0xkNmFHQ0VhTlFxUERKenZjVGJPT3dx?=
 =?utf-8?B?QmsrT2xpTW1GeFdTY292ZGJxNEgrNTQydS9SRjFBaWVnWVphb0w2Vnh6WWVh?=
 =?utf-8?B?V0NoWVdUbndscHQ0NkR5T25sZkVwRVF3Z0hFeUFoYWZLeDU4SDFzQ014V1FW?=
 =?utf-8?B?SnY1T0doODJ2MGs2RTJqRXhSc1NlZVBmVk13SlNwd05Sb0JBZ1V0TkRvRlJD?=
 =?utf-8?Q?GlT3+IHVI6pGEZpA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b87c958-0f81-4d59-b9d8-08de6325980f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 13:10:24.8668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57cVDd9VbbT+0r8S1w209NiUBI7m6yxx6GEKPOH2ttZkmfElInIvULUpVUiFv1SGQTxaUGGh8eJU54ha4YH1AVzn8mm77kXiex8/FI6wAJD0IaS0y6ztTuqGMgOQcT/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF30373102B
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-31499-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9F918D9C24
X-Rspamd-Action: no action

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAxY2FjMzg5MTBlY2I4ODFiMDlmNjFm
NTc1NDVhNzcxYmJlNTdiYTY4Og0KDQogIE1lcmdlIHRhZyAnbmV0LTYuMTktcmM4JyBvZiBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldCAoMjAy
Ni0wMS0yOSAxMDoyMTo1MiAtMDgwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMtMjAyNi0w
Mi0wMw0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZmI3ZjU0YWEyYTk5YjA3OTQ1
OTExMTUyYzVkM2Q0YTZlYjM5Zjc5NzoNCg0KICB3aWZpOiBpd2x3aWZpOiBtdm06IHBhdXNlIFRD
TSBvbiBmYXN0IHJlc3VtZSAoMjAyNi0wMi0wMyAxNTowMjowNSArMDIwMCkNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
aXdsd2lmaSBmaXhlcw0KDQotIENhbmNlbCBtbG9fc2Nhbl93b3JrIG9uIGRpc2Fzc29jDQotIFBh
dXNlIFRDTSB3b3JrIG9uIHN1c3BlbmQNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTWlyaSBLb3JlbmJsaXQgKDIpOg0K
ICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBjYW5jZWwgbWxvX3NjYW5fc3RhcnRfd2sNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG12bTogcGF1c2UgVENNIG9uIGZhc3QgcmVzdW1lDQoNCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9pZmFjZS5jICAgIHwgMiAtLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21hYzgwMjExLmMgfCAyICsrDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYyAgICAgICB8IDYgKysrKyst
DQogMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo=

