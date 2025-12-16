Return-Path: <linux-wireless+bounces-29796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0692DCC1DA0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D641F3010284
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4583032D440;
	Tue, 16 Dec 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yb1Whf/i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF333A008
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878232; cv=fail; b=c1lE5DwDCYTZSSY+GTkl2X5dNS2JTL0czxnr4KJjB0+3GGWBNiM5mh3laqoQCDMLsKBuOzhC48uhif4QsD1PWDkC9iVKyERJSiTl4UgHr5kUbVN9b9dERoKcZzYsZQr3w4jwzqmDohKrDGm2WkBCEErnUz1GX0JeB3mnsg0r9I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878232; c=relaxed/simple;
	bh=mzHqIj4abtz63itdimehLr1g4/R16MOxFjeKMqgHCEY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j+ctPEY5UyYub0JGlimuHgtUHEMAOyr84EmY9/61VAUJXmC/kYhREE2vJhdvUpbTRJRuxnPLG0fp/nFxYMIsaHe2u6FU30R7fj3JoPTDwjkGB/0EtWp6ftxos+c64eQDmJY9qdJAyU8O9g7DXNN5rSfp2MoP3ad02YLgBIeJZww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yb1Whf/i; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765878230; x=1797414230;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=mzHqIj4abtz63itdimehLr1g4/R16MOxFjeKMqgHCEY=;
  b=Yb1Whf/imllzDIJ/RbvhStWrkLMPN0CaeyFlWsPNIhvQ9siAJcXyWUhV
   g0AfHnAwk9CDMaoz1hBdSWSo26jpn4kzb1rG5yrI3WuiZvJtmYlz4oiCO
   gIYjTuqk3eBeFaGhg8YGIghsLcXN1rPtbqBfOS+UED8BxQE4M3NbNgpnB
   8YxkY8epIeOoARGjUjurG5ZhJDl+1jY8+N/I8QbXVEYUFh57OYyx7NQm0
   2OivlrVwnB2sbIZ7IRGNxAWnZRPF5VXpkYfKaqel8yjLJl5CcelUiDWeO
   vQZd9dGq+/cxJmMzMKKEgVLO9+ztAiG56wjmhnn252gv3bnjJfVxZ9kSE
   g==;
X-CSE-ConnectionGUID: qBEcRSQ5SQm/MxwpdZ+mHQ==
X-CSE-MsgGUID: fagILPH5SLGaVOS7L1Dvjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71421340"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="71421340"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 01:43:50 -0800
X-CSE-ConnectionGUID: yOA+HxqzQkuHmxJFN5xiKQ==
X-CSE-MsgGUID: pVp35yWzTO2j7nmiWUTgiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198232274"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 01:43:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 01:43:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 01:43:48 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 01:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNqkZIfzplN4Pq3/R965wMAjFLn8Y/73RMJp9xOd9eXSEZixIppi1wyNQxLhz3zrJdykJvq7dSwjWCSN6i0/1MlKUJWM16KF+6CWfL2qLPw5LmaHqIOxFXXaxQgTZJVaBzMnMgxWU169rnEV/AUSQi0wj6fTnhNtzJiwZ46awHp7zuoGojV3QItIbVSFWaR5zSOHweDxegBegMXvitPjzzwgpE23ikKSBtnemuUTeKzi0sefm4uKzE8OXVKnFrGIu/eoJJ73xAlf2rCYlGN70WfBCOMsj7duPa4q+BToTq7ej7uSFJJhv2fWxOdfkA9+D3SdT3WZykJWLuq4f1y0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzHqIj4abtz63itdimehLr1g4/R16MOxFjeKMqgHCEY=;
 b=DgNOYwAfBr3X9QPfaDcOZaasyAlbRCed/2kJtxWfzoRLl+Q+/J5U9IPwLWKLtHwmQoyV2++LZxGak3spcWQNwucfCcrDV+BnghluK+C3ZnYR5K5A1SXAGYdLjLidipHywEmClRf3kExUfj+3futMEI8DOwh162HlQVuKjDVaw4yrDSs27aRAiyAjOk3ThTI6+Y8SKy3lq95DvA9LmwkaLVMud3bzz8/Jt2aKiYuQhbr+hhUQbhwhGAmBnFXKxhXMMYtxE1BWtoJ7sY7lKRwa5c7pv5dazOTiurgwJYr2FyKTxb482DDiIP2/1ojoFDeIQWi23+JKlKN0v0t0SX7DAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS0PR11MB8072.namprd11.prod.outlook.com
 (2603:10b6:8:12f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:43:40 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%2]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 09:43:40 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "kyle@infradead.org" <kyle@infradead.org>, Josh Boyer
	<jwboyer@kernel.org>, "Hutchings, Ben" <ben@decadent.org.uk>, "Dreyfuss,
 Haim" <haim.dreyfuss@intel.com>, "Yang, You-Sheng"
	<vicamo.yang@canonical.com>, Linux Wireless <linux-wireless@vger.kernel.org>
Subject: pull request: iwlwifi firmware update 2025-12-16
Thread-Topic: pull request: iwlwifi firmware update 2025-12-16
Thread-Index: AdxucCfdvTfcJAqpSfSgenk5YLIOdg==
Date: Tue, 16 Dec 2025 09:43:40 +0000
Message-ID: <DM3PPF63A6024A9654428CE36E88D571C8AA3AAA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DS0PR11MB8072:EE_
x-ms-office365-filtering-correlation-id: 85179652-3404-41d6-cd24-08de3c87983b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YmFPVXYyaE0xdmJDZDdnU3IwNFRGS2ZnNC9IQng3cnprYTZyTDQwUDBhY1h6?=
 =?utf-8?B?QWpYT2ZLNnV3SEY5V1BrcEEyeHhKVzBLb0V6RFRWNkZReng3amRQaVNrYU44?=
 =?utf-8?B?ZnZjbHJsR0xtd1BReXgwdGFPb0V3TGFXSkNFdHlHY2F4RTErTUxOanFRYnM3?=
 =?utf-8?B?Skx6cERlTnZHdTA4SzlSd0o3UUVubnk0d1lMeW1IV2ZGUkpSQ2hkd1gyUmpF?=
 =?utf-8?B?aXUzc09jUi9QcDFDWU1NOUNiUmR4a0c5MThmR3huczNiNFB0TTg0NXh5MjVH?=
 =?utf-8?B?T204VVV0Y2w5VzdHZ2M2QVFDSjhWWG84d0REK2dWNExSME5obGkxMDl0WFFj?=
 =?utf-8?B?ZitqdGVWLy9yZDFxS3ZETHdrYWQ1THpiNGVMQjJnT0l0enQ4ZGZ6NFIxQzNW?=
 =?utf-8?B?L01ZTmtwRjZDOU9sUjVHQmZ0YVdXNFU3VHBpZkpGd3RkdGJ4c0JlOTM4THZV?=
 =?utf-8?B?anJvVzhSQ3EwUzF4TndjK29BZXZEa1czUTRVOC9oaWtQcXkxYmRhYVFKQzhX?=
 =?utf-8?B?eTg1U29YWkY2TG5SNVg5YVNJZ0YyeDlLVkxnOE5NVWZWZDhGdXl1TVNHSkE4?=
 =?utf-8?B?eEUzRkF3SXpJdWNlSUl6cGRkSnkvOFVyb0NENWpSYUlYVnM0bWFTWGMyclM2?=
 =?utf-8?B?dVZ4TUtPeGo2Qk1xa0cyNHVjWkhGU0hxY2RZM0Y3b2FxN3VGMzZGSG1OOHNk?=
 =?utf-8?B?ZURjZGJaSTNPYzFPSzlwcUQ3dVhSc29Tc1ZIcGp0eTd5S0I5U2Q4V1RURFZ6?=
 =?utf-8?B?eUwxTVA4S28vbS81MzN2elZnTHNMemRYa21JRDlCcFFsV3BQdHBLL3RXQ2Na?=
 =?utf-8?B?MHZ3REx0L29wek1GcWhlOUh4RFJWT25Md1dHNlg4RGZQaStOSlZ2eEpOVUE5?=
 =?utf-8?B?bHc4d2dmR29CZ0gwNktpRy9PbkRmdzgza3ZycTIrYUJBVjhYSG40M0pwQVpm?=
 =?utf-8?B?L1NidWJURUpvTFowUlpBZnp1MEQ3UkpWS0thc0lsUDM0OVlEUW9VaGpubWQz?=
 =?utf-8?B?dk13WHUxUG9YV2JpNHd1dG5ieEd0aUxMNTZYQzdOeDltV1NXbE91dXVkKzBP?=
 =?utf-8?B?eFgydjI0VTNNOGVCbGd4TDNLbUtscGhxWDB0ZzdjNENKb25BSE94T3dwc3lx?=
 =?utf-8?B?SGRRajhpQlBIY2JiajZLUjFrTnZLeUxuN1A4czRNMlIvNXd4ZUF4NS9YajNE?=
 =?utf-8?B?bDJLb204R1ZyOWVVcTBsd3pKbzJPb1I0OHd3aytoSUtvWkpFeE5wWGdPc1VK?=
 =?utf-8?B?a0x0V240RWJ4R3g1bGw5VGhkR3J1bG1neFFEZUZTcThOcXJ1MnRjQ2tjNHdV?=
 =?utf-8?B?c3hqaXhjZVVTWkgzYi91K2d4T0NHYk43cnY1Zm9IQVZUQzRORlYzSVFNZjc2?=
 =?utf-8?B?L1d4TVV1YzlLY3UvOW9Ga3EyNmtiSHpxZkhoUVVReWRZQ2F1cTEvUUdTOFBY?=
 =?utf-8?B?TEpwb3NwcUdObVY0V013Q2N6N29welk0clZWQzNIT01hdmw4bFJIdUJ0VGhK?=
 =?utf-8?B?Y2pYQURJS2lTK21pU2VWMVg0U045TWphdmZyUDZOSlhRcS9paG53LzVGaUhQ?=
 =?utf-8?B?VVd6cUp2SkZYb1k2Nkx0UXdtTEZRMzBldUYzN0NmQ0NUVzBYa2Z5OG9FVUEz?=
 =?utf-8?B?NUJUOTFHcG4ydmFEOGhWNTZBM01GcFZ1Ti9QeGEwUkIvc09RdklGTStwUGZJ?=
 =?utf-8?B?ZW9GOXpBUGhQb3BSWkJTTmxZOUFzWUtQNkh3OE9EVytGU2RqeERTWmZMMmEw?=
 =?utf-8?B?S3RHejFteE9PamxSYld2bVY3ajVOYjgwVU9pZjh2cFR4b3UvemJMT0o5NEdJ?=
 =?utf-8?B?VHVCZFFuT2lQTDBRcnRDeFdYV3NsRUp2amVtQmsyNy8wTGYvTnVGdklUZVAy?=
 =?utf-8?B?NmJ4SlYzSWNDZWpVZGYybjBnbmRtSWQvK3lvRnB4RFFRN0JhWWJrZC9LM2RD?=
 =?utf-8?B?RS9jTlB0cTlHS1ZwWTdaTFRTVlFsaS9GZkQ5Uk9oMGNaQUNqbmV5dUM0TE9C?=
 =?utf-8?B?ZnFldEdYZ3JCTG14cGJQcmlYNitnbndHUFBCWTd5YURXUDJIMjE4cXFFY1R1?=
 =?utf-8?Q?1crIg8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SllvN2JIOFRIc05KRFpHWklHMW51WmMycUhoQ2xVd21VTU03MXhaY05TU2RG?=
 =?utf-8?B?QTBRMUFiSVVqUHd5dnk2M1ZnRktiVy9LUHExNUx3WDZNS1Izd3hSMzdmVVhF?=
 =?utf-8?B?WW0zTEUyelNQV3dQMUxSK0gyOURxK29ZalpPaTJ2TitKR1Z5VUxmQTBubzF2?=
 =?utf-8?B?VURvNUVyak5WL1Ezb1lhSmZXRFFJU1pOM2RPYTQ5SWxBU2I5NkpSTmNyVTRE?=
 =?utf-8?B?YjZjS0NkU1Y0YktxRlg1QnBuSHE1eDJ1aFVnenhvdnFSNHI4cmhZSENwSDU3?=
 =?utf-8?B?WTh5NzJjdWN3andlMlpGeU93T1U3bHFoTGhTeGloVDZVN3JJbUkvcnBmUEZY?=
 =?utf-8?B?MmNCYitDVnFTa2ZST0Q5VWtOVUh2dGxWZ2JaWGhkck10RE5lcXpreXE4bFkz?=
 =?utf-8?B?MGNVWlJndjQ0TGJtbHMweGdIZkY4N2dFY0YyMHduN1Q2a3R5cDBzMnVLNjJI?=
 =?utf-8?B?N29mTlRGMDlyTEErY1BXWmYvc05SUTdtY3JpME5NNE91cEIzemU3cEZUaG5S?=
 =?utf-8?B?Ynh4V29GUkNGRTBucjl5VHRZWFFZZ2lEZzZqVFM1a2lxL2IzbnVTTWtuTDV2?=
 =?utf-8?B?aUJXSHJFbWlUVzhPbHFRaUtOdWQ0WFEvSGZWN0MrWjE0eVI0YXhjaEYrS1VR?=
 =?utf-8?B?V0lXejArWEZMUHJEdmpZbzVtRisrSGJmRjV6TWY1YkF3NDVWSk5obmdvYTMz?=
 =?utf-8?B?K0JSazhRRC9mOGRmdVYvZjJhOFp6WExqbHNRbVlzaHRHQUVNc3NYV1Ava3Jp?=
 =?utf-8?B?WCtMRFRCQVdMVDl4a21ZY3ZjSXdGQXJBVkhmdGxoUHU2dGFQK3hReEk3WG12?=
 =?utf-8?B?cmxzZTZrZ2VJTzVFUS9iYnlrakg1K215OE9kSW9Nb1FWV05maUZYaUR4eDd5?=
 =?utf-8?B?WGE1aGVUcmtrSHBEQy9HaGpJL05oNnVUaW0rTDhOT0hUV2txWnRlSWU4MzNt?=
 =?utf-8?B?cG1wZHd4MDdIdHV1NWpGazdvWG9KSFFuTk9BZUV5SUNBN1pnNTVIU05UZWJ1?=
 =?utf-8?B?KzFONzZzaHFPOFVvM29sMlhYOTJsVTNGNzJuU3kzM0o0M0FTNUpnbUdBckYz?=
 =?utf-8?B?SmVScGFqZnBycHY1YzM2OXRhUWpBcU1YVjNPeEJPeUN1b1R3Yk9iZEdmY1Vr?=
 =?utf-8?B?eW1VVTh3OTlQM2E0ZzgrejdqbTcyMVVRc3N2V1Z3alI5UC9QQzdNdytVa0Fi?=
 =?utf-8?B?YWFVeUlqaFJVb0xZaVpvTG01blFXVHcwT2ZPclhyMVVuOFpDNlB0TDBqcldO?=
 =?utf-8?B?Yk95aVFuWUdvRmNBZ1d5UHRiMWV2bnlRd1phbmZsUTl4YnNISUxXTVUzVEZF?=
 =?utf-8?B?bnZSNThhSmdmM1kwZFNFOHZKWlphbXdFYitCekFWYmQrYmdyMkI3Zk93clhS?=
 =?utf-8?B?YlEyREpHTEEvS0tkRzhYcW9EMU11UmhyeFRBaFdXMlFJSnB4SkpnT1p0Nnpw?=
 =?utf-8?B?UzR5WnhTLzltMm9tOGc3WGk2V2xUN3BUNXM2THVZWnlobVd1L1llSlFFQlRv?=
 =?utf-8?B?N0dkVWdtYkpiZERZdEQrZlpreTJzV3IraEtmdzVmSUNMZmtrNUp1YjF2MjRN?=
 =?utf-8?B?Zk9Dc09aYnQrellnNUd2M0ZwL0V5a01Xd1FjSGswYnIyVXR1dGRDMUpZOFB4?=
 =?utf-8?B?SjIybjU2TkxOaEs2Ymc2K05WMjJqQ01FUUpSSEVWbWdQb0N1NWF5UzE2Wkor?=
 =?utf-8?B?c1l4NmJOR2t4dnZYNUZuTkxwWnBkQ0pRKzBHcUtKNCtpdktBK09WVjk5T2NG?=
 =?utf-8?B?dHNYOWp4VWpQR0tQNkdLcTZMTlUyZVVRTWc2R0hmSFBBSm9pZ0JteU5WNWZO?=
 =?utf-8?B?N2VuNXdJQ1krRHh6dXFjUjZxcjFkdnZGbmFQUitXTDY0S05lZnV2dW9BU3dR?=
 =?utf-8?B?c0RWb3ZhODVseTlIT2svalRtZExjdGF5N2d5OHQrVldaa1ZQbzRMUlJVUUdO?=
 =?utf-8?B?WldaY3hOZnI5OTh0WWcwcU4zT2pwMTFYSDc4cXZTS3pqcUhiVU54aHdmMk1R?=
 =?utf-8?B?UmpwK2dFV2lxNllOYVJETVVMTWxua3puSFdsSzZYZFcwUXBubk10SEw2UXNP?=
 =?utf-8?B?UzVrNmJwc0JuWXZaWnJ4TEZHY3AwUDJyZHZBdU5aT2FVSFliZG1YWU9tYVFO?=
 =?utf-8?B?VXZCVmxST0JuZjNESW00aHlPL2xySkJsMWVhdjlVZ3dQTjhKU1paTEE2bTdn?=
 =?utf-8?B?eUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85179652-3404-41d6-cd24-08de3c87983b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 09:43:40.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUWjr65AyM+a07TT51yxU87rGHVNlUGCwbxPWMIB0Ertw/vuiHFSyLM3k1JRss//7WRyvLcCkGit7VA20SWe91p1ZTY+9lxAiulSR/PATnW1VANwdW5XioEjKMljTlQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgY29udGFpbnMgdGhlIGZpcm13YXJlIG9mIGNvcmUxMDEgZm9yIGFsbCBvdXIg
c3VwcG9ydGVkIGRldmljZXMNCg0KUGxlYXNlIHB1bGwgb3IgbGV0IG1lIGtub3cgaWYgdGhlcmUg
YXJlIGFueSBpc3N1ZXMuDQoNClRoYW5rcywNCk1pcmkNCi0tLQ0KDQpUaGUgZm9sbG93aW5nIGNo
YW5nZXMgc2luY2UgY29tbWl0IDZjNjBkMTEyODU2NmY4Y2M5YzNkZGQ3YWQxZGI3YWRlYzgyNGY3
MWI6DQoNCiAgTWVyZ2UgYnJhbmNoICdhbWQtc3RhZ2luZycgaW50byAnbWFpbicgKDIwMjUtMTIt
MTIgMTQ6NDE6MjkgKzAwMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KDQogIGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
aXdsd2lmaS9saW51eC1maXJtd2FyZS5naXQgdGFncy9pd2x3aWZpLWZ3LTIwMjUtMTItMTYNCg0K
Zm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDBhMDQxNjMyYzE1NjRhNmFjZjZkMmI5YWI3
Y2JjNjQ0NzRhMmMzMjM6DQoNCiAgaXdsd2lmaTogYWRkIEJ6L1NjIEZXIGZvciBjb3JlMTAxLTgy
IHJlbGVhc2UgKDIwMjUtMTItMTYgMTE6MDM6MDggKzAyMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClJlbGFzZSBj
b3JlIDEwMQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpNaXJpIEtvcmVuYmxpdCAoNCk6DQogICAgICBpd2x3aWZpOiB1
cGRhdGUgY2MvUXUvUXVaIGZpcm13YXJlcyBmb3IgY29yZTEwMS04MiByZWxlYXNlDQogICAgICBp
d2x3aWZpOiB1cGRhdGUgdHkvU28vTWEgZmlybXdhcmVzIGZvciBjb3JlMTAxLTgyIHJlbGVhc2UN
CiAgICAgIGl3bHdpZmk6IEFkZCBTYy9HZiBmaXJtd2FyZSBmb3IgY29yZTEwMS04MiByZWxlYXNl
DQogICAgICBpd2x3aWZpOiBhZGQgQnovU2MgRlcgZm9yIGNvcmUxMDEtODIgcmVsZWFzZQ0KDQog
V0hFTkNFICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDggKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1LWIwLWhyLWIw
LTc3LnVjb2RlICAgfCBCaW4gMTQwNjU3MiAtPiAxNDA2NTcyIGJ5dGVzDQogaW50ZWwvaXdsd2lm
aS9pd2x3aWZpLVF1LWIwLWpmLWIwLTc3LnVjb2RlICAgfCBCaW4gMTMyMzI5MiAtPiAxMzIzMjky
IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1LWMwLWhyLWIwLTc3LnVjb2RlICAgfCBC
aW4gMTQwNjU4OCAtPiAxNDA2NTg4IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1LWMw
LWpmLWIwLTc3LnVjb2RlICAgfCBCaW4gMTMyMzMwOCAtPiAxMzIzMzA4IGJ5dGVzDQogaW50ZWwv
aXdsd2lmaS9pd2x3aWZpLVF1Wi1hMC1oci1iMC03Ny51Y29kZSAgfCBCaW4gMTQwNjcxNiAtPiAx
NDA2NzE2IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1Wi1hMC1qZi1iMC03Ny51Y29k
ZSAgfCBCaW4gMTMyMzM3NiAtPiAxMzIzMzc2IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZp
LWJ6LWIwLWZtLWMwLWMxMDEudWNvZGUgfCBCaW4gMCAtPiAyMjM5NDQ0IGJ5dGVzDQogaW50ZWwv
aXdsd2lmaS9pd2x3aWZpLWNjLWEwLTc3LnVjb2RlICAgICAgICAgfCBCaW4gMTM2ODA5NiAtPiAx
MzY4MDk2IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLWdsLWMwLWZtLWMwLWMxMDEudWNv
ZGUgfCBCaW4gMCAtPiAyMjIyMjQ4IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLW1hLWIw
LWdmLWEwLTg5LnVjb2RlICAgfCBCaW4gMTc1MjA3MiAtPiAxNzUyNTgwIGJ5dGVzDQogaW50ZWwv
aXdsd2lmaS9pd2x3aWZpLW1hLWIwLWdmLWEwLnBudm0gICAgICAgfCBCaW4gNTUxMjggLT4gNTUw
OTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktbWEtYjAtZ2Y0LWEwLTg5LnVjb2RlICB8
IEJpbiAxNjA0MTIwIC0+IDE2MDQ2MjAgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktbWEt
YjAtZ2Y0LWEwLnBudm0gICAgICB8IEJpbiAyNzgzNiAtPiAyNzgyMCBieXRlcw0KIGludGVsL2l3
bHdpZmkvaXdsd2lmaS1tYS1iMC1oci1iMC04OS51Y29kZSAgIHwgQmluIDE1Mzk3ODggLT4gMTUz
OTc4OCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zYy1hMC1mbS1jMC1jMTAxLnVjb2Rl
IHwgQmluIDAgLT4gMjMwNTYzNiBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zYy1hMC1n
Zi1hMC0xMDAudWNvZGUgIHwgQmluIDAgLT4gMTgxMDU0OCBieXRlcw0KIGludGVsL2l3bHdpZmkv
aXdsd2lmaS1zYy1hMC13aC1iMC1jMTAxLnVjb2RlIHwgQmluIDAgLT4gMjIwOTA3NiBieXRlcw0K
IGludGVsL2l3bHdpZmkvaXdsd2lmaS1zby1hMC1nZi1hMC04OS51Y29kZSAgIHwgQmluIDE3MzYx
MDggLT4gMTczNjYxNiBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zby1hMC1nZi1hMC5w
bnZtICAgICAgIHwgQmluIDU1MjA4IC0+IDU1MTc2IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3
aWZpLXNvLWEwLWdmNC1hMC04OS51Y29kZSAgfCBCaW4gMTU5MDY4OCAtPiAxNTkxNTg4IGJ5dGVz
DQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLXNvLWEwLWdmNC1hMC5wbnZtICAgICAgfCBCaW4gMjc4
NzYgLT4gMjc4NjAgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc28tYTAtaHItYjAtODku
dWNvZGUgICB8IEJpbiAxNTI2OTU2IC0+IDE1MjY5NTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3
bHdpZmktdHktYTAtZ2YtYTAtODkudWNvZGUgICB8IEJpbiAxNjc4MTc2IC0+IDE2Nzg2ODQgYnl0
ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktdHktYTAtZ2YtYTAucG52bSAgICAgICB8IEJpbiA1
NTA1MiAtPiA1NTAyMCBieXRlcw0KIDI1IGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyks
IDE0IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdp
ZmktYnotYjAtZm0tYzAtYzEwMS51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3
aWZpL2l3bHdpZmktZ2wtYzAtZm0tYzAtYzEwMS51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bnRlbC9pd2x3aWZpL2l3bHdpZmktc2MtYTAtZm0tYzAtYzEwMS51Y29kZQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc2MtYTAtZ2YtYTAtMTAwLnVjb2RlDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGludGVsL2l3bHdpZmkvaXdsd2lmaS1zYy1hMC13aC1iMC1jMTAxLnVj
b2RlDQo=

