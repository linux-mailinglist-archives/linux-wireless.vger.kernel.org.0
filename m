Return-Path: <linux-wireless+bounces-21908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12738A989C7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E91A7A57DA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60B202979;
	Wed, 23 Apr 2025 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZExv7nbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01167C8DC
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411267; cv=fail; b=F36geFZJGVI5V/re69h+NWt7Mjys1/zMyVZwPuarUMAVyKDXGFFW2jAFr20yWm7gpAc3K7W6ooCjGLV6W3i8veECXGzmawHbms5YqikP/xHCgV5LOigWBvsTaiwGDhNJ25yUhzc/Ui5kSaBLfYebXKg2XjP1b5o7VqVl+ya4i0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411267; c=relaxed/simple;
	bh=IxWBPnDUtMX59Ri1YSwmRQY5jcScOrTcwxMS+cZkS4Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GMZJuEN4hB+tOF9cldw9ju+RR0ZE5nvejD0h7Bfy6Ssr+rt7U5oyiP5cS1mlg8G24YyTux076pE3E6e2aOOpo/PeWS1SnLTBHB4hwr0/fhh69y/xrBQM2c5MuOPqRLfMLJ1XwHbXevCUdCVIRtKRq/glKk52SFIgFRSdFTUeyHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZExv7nbV; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745411266; x=1776947266;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IxWBPnDUtMX59Ri1YSwmRQY5jcScOrTcwxMS+cZkS4Q=;
  b=ZExv7nbVXzpZ4dUyWpO1XVI7IVma3rsF4abUJtLDEgLdmqF9WzJ8MWtS
   S9RxgyipE9IJPsN9I3AGsbLWjXxuQfSEAOzHu92/HtOsnRuDSWt+eIMSn
   xAbKtCSqwhRM4FAV7TE3KXFFURqXPTnDXtVWGXAb6+5YNEWrbGgUtcEQX
   CX82/nztS27VlNDzKlhizWlNuKS4xsGQprln+WN6nWzLiKal6O2E+QagZ
   vle3HQ23Icc82EfDq3QmfQlKO0NAqaO1nm8TvEJHheZj18IvnzgR78Rte
   nPBFQS8QND19VC2LzhorwTm+r1oX/9x7/SPz/oDd0iV5LRaH4U6pJIdMN
   w==;
X-CSE-ConnectionGUID: MkgqlC4fRF+n+om+A+XuZQ==
X-CSE-MsgGUID: 9ytdCwQyRmeHF+Ng9ohV5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="69492168"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="69492168"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 05:27:45 -0700
X-CSE-ConnectionGUID: 01WIHIl+QhSAY4fII1pWmA==
X-CSE-MsgGUID: EYbfF5RzTpaKzee9rKiX4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163353038"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 05:27:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 05:27:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 05:27:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 05:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0AN9bb4EMePHTP+dR8PPbTZ9wD8/IKUsPLgXa/V8/fbPqHixUFxubqwNcurFNHPEMKadbDwTQ5bn7TbG5T3jryD0qbiZaIeeTOirLJnEwrjw7fYy9jslivJUMj8St2IVTWg/R4aBby8xnhGdNbz3BiCmQILX+EKmS1k+eEXRNA1nJHNfwVEOI0fKKkPZ/D+BKyB1ITUa2odO9rmTLx3BZYrnqRnZEshjCHL2zoyh0Q+8e2mfSAHleNi9ymLq4xoa55f3j52LAfgjaP6asoGOednwpfIcMGAIFD+bjCEuWjgJfiBbWea5/zZyVdA5T+NWeJv9cb7kLSgWpD2NioqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxWBPnDUtMX59Ri1YSwmRQY5jcScOrTcwxMS+cZkS4Q=;
 b=EgairvsWbG+rg1oP21Wd/bwmo8cdoQsOtkTa5J8RAXtOtY0a2U1Fl2M8twH5r9W9eZyGFZcGPQoirXW43FTXPjzNJ9DAO7UF1GkeUjLBLTJxImMiRfLqsc7e72PbZlJxe32SZrPWoQ8N6L0tSOlBQCDVRyw/jKUiNK0l9yWJ8Pi3ruIdvNIbzZcjYt3+Cp3kxfWc50NyiLiywVDNqQfOF6YWtVa7mW77mL1uxd5UEWuyrjEsc+FASGmvSHxL36CUBVbfOSOdk1HpbMcoDI4Ri3WZEKVcOtctFNbBUIvxr0DcqZR93TztZ29LIGUbpO9/IWpBoWWQAnhf57YuVKaRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Wed, 23 Apr
 2025 12:27:41 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 12:27:41 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Shalev, Itamar" <itamar.shalev@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH wireless v2] wifi: iwlwifi: restore missing initialization
 of async_handlers_list
Thread-Topic: [PATCH wireless v2] wifi: iwlwifi: restore missing
 initialization of async_handlers_list
Thread-Index: AQHbtDGjmn6NzfU1VkOXes6faV5Qv7OxLZpQ
Date: Wed, 23 Apr 2025 12:27:41 +0000
Message-ID: <MW5PR11MB581030A6E2FD0EEED559E927A3BA2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250423092503.35206-1-itamar.shalev@intel.com>
In-Reply-To: <20250423092503.35206-1-itamar.shalev@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|LV2PR11MB6070:EE_
x-ms-office365-filtering-correlation-id: 4ec3b287-47ed-46c5-2c5c-08dd82623dd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?ZHhpQkluQlNxSThNSnZMNE1CWWxJbXdHQWZLUDFxQTRGeTB1MGdIajZBV1NJ?=
 =?utf-8?B?c0NrMjdFRjNpanExQkMxdVZDSjJtRTJJcTdZaFRWblcva0djRXMyNUhuZ0FR?=
 =?utf-8?B?NnA5WWYyZ1FHRlFOTVZhZkh3NjhIS2NEYUFyWnI1UXZraTFZUHhJaDcxZTFX?=
 =?utf-8?B?RzU1eEY2OXZQUjNmaDhmVDNQb2lMdG1UemhnM0gyMlpWMG5pUzFJK1BZR1Za?=
 =?utf-8?B?Uk5jVHNPSmkwdmI0ZlVCT25PSlBkYmNXL0pIUGxwd0U5dDRSeFFCZ2RES2tp?=
 =?utf-8?B?TGhRUWlIQjlMTWExU2hlZHp5VXB0ZUpuS1FzT3drUHEveDZWdnQxN3pveFVz?=
 =?utf-8?B?cHo4SVBMekxQTkhWRjFpbXdoNUlrT0s3dW1OUkoyNmtFbllhSGhTOWpOWmE3?=
 =?utf-8?B?SHAzYXUwdEhlZERsV1g4ajA5T0hSbzZtdmtKSHAvYlg3UThtVEhCZ0xSNFl0?=
 =?utf-8?B?K0x5bU1sQTdUWDZ5QjdzR0tocFh5SzBlM21mdjV2Q2xMR1JBTVNSUVc0MGlS?=
 =?utf-8?B?S3pPTTJyRUh0NmM2Mm5rWUJMR252YmMxTXRzVVVUbVpBWVZSUEVZMlNNaWdP?=
 =?utf-8?B?aUtzcDdZM1R2L1J1SnM1WWtNYThFZE5USFR5WXJTMHhwVjlmZU4xc1M3YVdI?=
 =?utf-8?B?dWlTeVhxVXBMUXBGazB4VU5icWI4SEdUTGZYVHk2aDF2anNSdWFGbjFBU1ZW?=
 =?utf-8?B?ZnRNUVNnaGg0UGVmME1uQWhrdHMrcDRFVFRIWnJybHdSZ3RhUmJqZmU4K0Ja?=
 =?utf-8?B?K3ZtdXBGVnVZS2pVckEwMzVPSlJMZnlwcXdIMFRoOU9pTTM2SWVmQjI2U0I1?=
 =?utf-8?B?b1cxS3FkODJjQ0RJNHFjci9OVTlHODJQNlRFYmZyUng2RXZVTTgycC9RaHow?=
 =?utf-8?B?MGw5a0w4TU5WbEQ3NytZWDBLMEdMN29qSzRlN0R6UjJzbXhVZ09NZVlFQnNW?=
 =?utf-8?B?VW1KU3FjbUh3UTlmcEp0RWdnRkRYclZaS3U2VXcyaTVtcHB2bkJDSjN5Mmlt?=
 =?utf-8?B?bEtvY3hPR0lyOG9qWmpXOXp4QWtTUU1NSE0zT0RnSENYZ05TNmZQZlMydTI0?=
 =?utf-8?B?N1lJbXBiODhid0R2NGljdmxFL0dsVDBka0ZSQnFIeHUvWFkxRHpHL0ZWRE9y?=
 =?utf-8?B?TVkyS3RRTU13WEYxYmlxVDJydktKeXFrbWJTY2kzNDdHdVJ6RlM0Vm5IOW9s?=
 =?utf-8?B?c3o0US9SdG1iL1RIMjdGcXF1c0JSV2VEYThiVk1KbkhmYjgvZWMvWGdXRkkw?=
 =?utf-8?B?dk9WeE1VTHYwRklPbnZ6NlZjbEE0N3NpVjFtUFNkOHpQK0J4KzRmNFVLd2pD?=
 =?utf-8?B?STZ5bVBxK0dnMnZjSEMzMSttMTlIcHFFVU5TVEVBaHJieVBZam9oM3NXYy93?=
 =?utf-8?B?TnRLTWoxd0Z1NDRnMFZmVVlJT21HSmg5Q3VqMmpLamxrVHlWMS81cWdCcTI5?=
 =?utf-8?B?a0pnODR3ck9QUDAyTzdxS2t5S1E0Y1UrMzFJNU9xTUlXK2RGZ0NaRHdmWUIy?=
 =?utf-8?B?eDRHU1JaN2Y4UFhETmJFa1dWaGlUT3JvOThIdFVpdWpxZHJNYklQbWNhZFFj?=
 =?utf-8?B?NjZYZ1Qxd2tZdEJYNUJNdEw2d3hHYmNpUkNrUGFPZzluUWViWXZtcEdlQXhR?=
 =?utf-8?B?NXVrT2VnMzdsT0FsYnJBdHRkbE9MdmMvaUN5UDA4ckFyMFNGc2hKN0pTTGkw?=
 =?utf-8?B?S2tFZkdVRmVPMWdHcFVKNDhET3RjQytXK1FWVUxMY3VDQXNwL1lLcG16YVpt?=
 =?utf-8?B?dGdnNmV6RDEzaEVocEJMYzZKUmQ5UmNudEwxZUZzNUw4eHRBZ083SEpIRk1N?=
 =?utf-8?B?WjVVWERWOFRvSWtVUUswM2Nza0RRNjk3blh6Q0xiVjhWUWZOb3hMYjNVWEdu?=
 =?utf-8?B?WVVXY0prZkxaRWFPTGNvSDJRUmN0OGE1WmNkN3B1VkVGSjltd0wxK3diYkI4?=
 =?utf-8?B?Q3V4WkNrQzFGWmNaakZUTzllUlNOcnBQL1VJQlFHaVBkTno1UzhOcG9vZ3BB?=
 =?utf-8?B?RmRPOW53Q1J3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlJTZGtiTy9NTHBwQ3RxRDRmN3pnNFJId3JwaUgyVVZTUjBIZVM3TjNad1My?=
 =?utf-8?B?WFc3WS9BMVdjUlJIRGtQMVk4ME1jMlQ0d2ErM25PRUl1a0dsUk9BOUY4Tysy?=
 =?utf-8?B?T3ZYckNHcGlTaHpQQXhIVXJJMnhDZFRtVEF2Z1k4NmR0b2tWaUltbkRNYWNQ?=
 =?utf-8?B?KzV3M252U3htUlZZQVU3UDFQMlpoaHRZTHpkTEg5aUllUjcydC9IUDkxR2d1?=
 =?utf-8?B?RWVMZUU1eW10WWcvS01ueGEvaWNDY3d5WmtWM0pvWmJGVlNpVzcya1NtZjd5?=
 =?utf-8?B?b01tT1hzU3QxVW5ldDFSRE16MHZCdXF6NTZZTTNYdnBIUHJsMnFRZmFaSnJJ?=
 =?utf-8?B?enFSYzdzUWlDNkhoL3V3dktnSE9taGFKUnl2Y3ovYjhJeVU5UEtsMmZMU3hB?=
 =?utf-8?B?QllJSUJxNjdLTG9ySW1mUUIwM2VLaE9nUXM4Z2tlRzhYcnBUbnNUeE1HMFJI?=
 =?utf-8?B?TDV0clZ3Y09xbmVZcFM4c0JYSlVXZW5sNUtpakx3L0RtUFBQekh1a3hDNU44?=
 =?utf-8?B?ZHZicjBWVXFQZ1g5MmpmaWdRejNMV2taUGI3a1BDWS9VbTR6RUxxcm5oNGxZ?=
 =?utf-8?B?cVJiSm5VaERBSmJPZ0FNaXRDZkhhbldWTGdZWWRaYzE0QWgyRjJIbGVPbGNR?=
 =?utf-8?B?VjhwNWY5bkxiazhWaEFpZlB4c1RsSEowV3QrTENsMER1WXJJckszMXVRT1lF?=
 =?utf-8?B?K2QyZW9EajdTZ1J6T21zaXkzRDdEMjdPbnF5ekRvRzh1QjYwT001bG1CU0Jq?=
 =?utf-8?B?ZW9TQlJqcEJvUmpFVldWUlRrdFBVblBoaXlVR3BtRWh0WXE1N3NhOFNDVkFm?=
 =?utf-8?B?am5MeGVJQWpMSlZzWjFydE00dEVMUmNiaDV4RUQ0b3dYdFZhYWM0Z2taMEYz?=
 =?utf-8?B?ZjlxeG1pUE4yTG1XbVVPK0V4Vi81WWVOYWNOdEZ5bFRjVHRZQ2lZc25RZis2?=
 =?utf-8?B?ZXk1d3ozZDhKMkFSUE5UVmdhbTI2Z3JaaHZORHBmMGQzUjNIcTZZbG41TEhR?=
 =?utf-8?B?RTRCSEUyRUh3dFJTSWJCc0RoSmtwaFZ6U0IvalhkZFg5ZzNmd3hiYUxCWDIy?=
 =?utf-8?B?WkJpKzEvditPRjE5NmtnWnZrMmpqUGxSNjRENWRaTi8rcnAvTzNZWmdja3VB?=
 =?utf-8?B?Mzg0Rk5KRTNia2FNZGJLcGMyblgvTG4rVVhSRStEaEtINitOV0NwendEMllO?=
 =?utf-8?B?STg2djhiU1JSQ1NLSWVzdnRpWUoyZjZ0UkdvaHNYM2NENmFXOTFGbUNNYjNF?=
 =?utf-8?B?ZEh5MFVJRHRXWTZvY3NNNnpZWUgvK2daSTc4OHdNbGZMa0Q2WUxLYzAvT2ti?=
 =?utf-8?B?T2xJbjIxUmZaN1docSt2SHQ1RFRoSW5LUWFTcDhPSGtJcjNEdnE5cXF6RUl6?=
 =?utf-8?B?ajBFc1FlTVlaTE9YenlWb3ZXcWNjVWRKRUNlYnFia1lyN0NRU0RNaFREWm1B?=
 =?utf-8?B?RkNjZHlieGU1TnlEZTdoSlJHbWplMFBjN2Vkbng2TmVQUjN6N1g4aGR0NlE0?=
 =?utf-8?B?b2pkVlhxb0kxNzVjL1R3eW9HTjBwM1NLbHJ5RmRoS01HTURrVFB5QzVkK0Fs?=
 =?utf-8?B?YU4vckN0TEJvbzF2U1ZEVXBpRmU0QlZ1OVl5c0dPVDRxWWExQzRUTTVWNWJo?=
 =?utf-8?B?Z0kwWFhyOTFxR0cxamQ1SjlTL0plRGtLa1lUNERkQW13eG1pNC9jaGgzMzVy?=
 =?utf-8?B?TVZWY2grcTM4Y2FkUEtBY01ZVGpvZDJIeGpWUlFtU3JxaUdmMDRHbG13cUNZ?=
 =?utf-8?B?M0c4WTZKNGVOU1hwdEg1OThZZkQ1cCtKdTUzVnlLNVN4WmN5MEl2bGVnTEN3?=
 =?utf-8?B?WWRuRlBQcUtFYjI4RVB5YnJXOTYrRkZvcnpsaGNDRUNkT001Rmpmakp0VGRM?=
 =?utf-8?B?M3ArSE9UMHY0S3poSmtVOXEvdE10RGNpS1U4NW9LaGhrd2JMNXBUaTM1TXBa?=
 =?utf-8?B?STNETU1EUSswNHN2cUJVV0xaSjdnaVNqVnhzcklnclNhTXJOMzc1UDB0VFpl?=
 =?utf-8?B?aVdHU2NROE1aQWl5UDNsLzBITGhLYUJjOHZCZEYxWGpoMU9rN0x4TUliTjZI?=
 =?utf-8?B?cXFRVTQxUWhPZWE3UnQ5SVNjWXVuK0V1K1ByYXNPQjBvRG1JY1lXNG5yakpW?=
 =?utf-8?B?d2FITzJ2TEN2eVp6bWxQUzJTTnhBaVBlbUw0cTZIM2E5M2g5a0s1RVFVSktp?=
 =?utf-8?B?a2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec3b287-47ed-46c5-2c5c-08dd82623dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 12:27:41.1761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzzydoRahtufVryWlpxzi2EIfgpd5uyDiHbhxQpv57QGMdotykmmaLiZVm2RK0kirG5Gx8d/pzxrNjQ+iTSmjDbez4dR1tnoTzrdQmiO+mtmiraBOw0m4CSlDEwwXEty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbGV2LCBJdGFtYXIg
PGl0YW1hci5zaGFsZXZAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDIzIEFwcmlsIDIw
MjUgMTI6MjUNCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogS29y
ZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+
OyBTaGFsZXYsDQo+IEl0YW1hciA8aXRhbWFyLnNoYWxldkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFtQQVRDSCB3aXJlbGVzcyB2Ml0gd2lmaTogaXdsd2lmaTogcmVzdG9yZSBtaXNzaW5nIGluaXRp
YWxpemF0aW9uIG9mDQo+IGFzeW5jX2hhbmRsZXJzX2xpc3QNCj4gDQo+IFRoZSBpbml0aWFsaXph
dGlvbiBvZiBhc3luY19oYW5kbGVyc19saXN0IHdhcyBhY2NpZGVudGFsbHkgcmVtb3ZlZCBpbiBh
IHByZXZpb3VzDQo+IGNoYW5nZS4NCj4gVGhpcyBwYXRjaCByZXN0b3JlcyB0aGUgbWlzc2luZyBp
bml0aWFsaXphdGlvbiB0byBlbnN1cmUgcHJvcGVyIGhhbmRsZXIgcmVnaXN0cmF0aW9uLg0KPiAN
Cj4gRml4ZXM6IDY4OTVkNzRjMTFkOCAoIndpZmk6IGl3bHdpZmk6IG1sZDogaW5pdGlhbGl6ZSBy
ZWd1bGF0b3J5IGVhcmx5IikNCj4gU2lnbmVkLW9mZi1ieTogSXRhbWFyIFNoYWxldiA8aXRhbWFy
LnNoYWxldkBpbnRlbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEZpeCB0aGUg
Zml4ZXMgZm9ybWF0Lg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbWxkL21sZC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9t
bGQuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21sZC5jDQo+
IGluZGV4IGQ0YTk5YWU2NDA3NC4uNGJmZjAzNmFhM2E0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbGQuYw0KPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbGQuYw0KPiBAQCAtNzUsNiArNzUsNyBAQCB2
b2lkIGl3bF9jb25zdHJ1Y3RfbWxkKHN0cnVjdCBpd2xfbWxkICptbGQsIHN0cnVjdA0KPiBpd2xf
dHJhbnMgKnRyYW5zLA0KPiANCj4gIAkvKiBTZXR1cCBhc3luYyBSWCBoYW5kbGluZyAqLw0KPiAg
CXNwaW5fbG9ja19pbml0KCZtbGQtPmFzeW5jX2hhbmRsZXJzX2xvY2spOw0KPiArCUlOSVRfTElT
VF9IRUFEKCZtbGQtPmFzeW5jX2hhbmRsZXJzX2xpc3QpOw0KPiAgCXdpcGh5X3dvcmtfaW5pdCgm
bWxkLT5hc3luY19oYW5kbGVyc193aywNCj4gIAkJCWl3bF9tbGRfYXN5bmNfaGFuZGxlcnNfd2sp
Ow0KPiANCj4gLS0NCj4gMi4zNC4xDQpBY2tlZC1ieTogTWlyaSBLb3JlbmJsaXQgPG1pcmlhbS5y
YWNoZWwua29yZW5ibGl0QGludGVsLmNvbT4NCg0K

