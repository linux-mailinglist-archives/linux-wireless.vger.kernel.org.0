Return-Path: <linux-wireless+bounces-20263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FEBA5E577
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8613B319F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704F41EDA37;
	Wed, 12 Mar 2025 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2WoKmEB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6B1EB9E1;
	Wed, 12 Mar 2025 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811620; cv=fail; b=iJdBAAq+lr2Arn+vjag4UXALp9NQw69gvwWG2dLKR1Bqc4X3uZzUfSA+eV7kik9BW69pmRRlnbXEJ7jXnx7eX5LPed5B04qiOCFA+7wmJ1BFb99nMjTb/gFZMbmrh3DrHZbJVHYEqqjseF+JFYcGUfU0XQI6IyfT0CDZQAF7Uxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811620; c=relaxed/simple;
	bh=H9Y3xd0c8E5IGZXpDhRRtD49I/GrTpIsfeq+4XuRl24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qo5bEHYKqlK0jfKyzZO2/t25NNpZPGNpwisfAAlHZ9cDhH9VSauqgyfqGqPEJWAJm12iacI2tbPS7TSoKDwiGyZxWhJ5m2cFa37OxNSFUUSUPdRmmA5LAPOf7p7j5NFEB5PK1cwvRjwAef9ZVbpCDk/eBHtZGCZ44VBdCznD00A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2WoKmEB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741811619; x=1773347619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H9Y3xd0c8E5IGZXpDhRRtD49I/GrTpIsfeq+4XuRl24=;
  b=Y2WoKmEBvbQzJb8fDBbVCiGqsv0ksFkz2YlBHGqH4SnEyT5/pcS9Z9E8
   uqPW9yLyvf5d2B2VPWpZpVjQKno+BSbnQ5ygj83EvzBUodSgf8BIkewom
   r5bFNtdu2BKyoCCQcapMWz4/U78GYnN/e7gZlwTuirLsDg66V02XEIbMc
   gpX+WVE0p/Jvv28tIscn7yrMmoXHUsCem4Iu/OBcgpG8s13W0O98e0NYd
   fNuYcx6dcK25/CU+penJ52bhDrLDgP+wsmGDoOjSa3+xpKMl8EUUO5/JL
   mdBJ1Q0q538LFsHK+h1yJMaJ5Npi3SrpZjp90XERk1Rd6awhfql8WVL7a
   A==;
X-CSE-ConnectionGUID: e2e6ZT+hTW6lnzxLZBNs9A==
X-CSE-MsgGUID: +D5lC2HXQcSo2eNu8kNByw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53118790"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53118790"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:33:38 -0700
X-CSE-ConnectionGUID: gSZdfrGzSv+J52KrVX8AnA==
X-CSE-MsgGUID: cLbW3ZOQRSquWUeqUqGYMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120703167"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:33:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Mar 2025 13:33:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 13:33:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 13:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jql97tG7zqUlNZTUkOD7jlJH8mTOtThGP0qoubP/+iB1Jnl/UiidV4dSZAzM5O3H//EWOcUXRG4DKGDLb54m5fT1WPvm5bcFntj7RvjUA6RC6R8Szz3JF9vd7WSasUPrpiNXrgokxcgg0ykYfAL2gCZRdKhMI0PLISqkJw0Uat9KceqaS9vGYFbiF7Mep6yOYsdPecMmxr8J3kpxV1FQnHFcWXjz/GsTQdjnrzbTuPxAO2QiZmpI1tWI+uTS1yzFlfTwn8SX7FOBhuyK14ZTphG+wO1UX8zZBGVVCGWKVnmHBimDS08xRV+tboTYtK0RGRu+JxVWoSM0s4vwOyQ0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9Y3xd0c8E5IGZXpDhRRtD49I/GrTpIsfeq+4XuRl24=;
 b=zAN4sA2oIjSnyoATqRhMf6+ykivslTOz12koOra9S5Rdghn5T9r1XmAME0adGa4rWsEqY0MxYarwsci8iE5OpJ0Z6LHzJ1Nj/EecwtxC4w5MR86QdP5JPM5+ZUwRUkOrnuJEAc+5KLBML7/e5Js7zuyVsM1Nx2UoL/4RFjxMXm2ddQ6y+3tq4Vyu3zJzZHchuVPswgT4TRcC3TJ5erYF6pS6EOV0w43cz+RcoXOAfXJ81fGl4fARxbSMtZGyasjuxtIVKhz2bZ4m640imkvdYU9aMMe1cDv+oBjOEvPwNdO8poXBn8NpVG/cuufyvjIa+PKZo2gSrmXkt5BSM02y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 20:32:51 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 20:32:51 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, Dan Carpenter
	<dan.carpenter@linaro.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Stern, Avraham"
	<avraham.stern@intel.com>, "Gabay, Daniel" <daniel.gabay@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Berg, Johannes" <johannes.berg@intel.com>,
	"Ben Shimol, Yedidya" <yedidya.ben.shimol@intel.com>
Subject: RE: wifi: iwlwifi: Fix uninitialized variable with __free()
Thread-Topic: wifi: iwlwifi: Fix uninitialized variable with __free()
Thread-Index: AQHbk4u+7Ys+GoLojEuM1xAItCzrlLNv8nUA
Date: Wed, 12 Mar 2025 20:32:51 +0000
Message-ID: <MW5PR11MB5810D96B62BB3F8DD82FB656A3D02@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
 <1b32cd5b-aa46-4a23-bd21-908196c4bab3@web.de>
 <MW5PR11MB5810329D2D44A188239D3093A3D02@MW5PR11MB5810.namprd11.prod.outlook.com>
 <7ea83bd5-b19b-4bd8-ac2a-8fb2ad616f8b@web.de>
In-Reply-To: <7ea83bd5-b19b-4bd8-ac2a-8fb2ad616f8b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|DS0PR11MB7558:EE_
x-ms-office365-filtering-correlation-id: b21fc1fa-2bba-40ce-83d9-08dd61a50f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFNNRlVINnMveDZiVkF1Z3d2WDlXYkhwdjNhbUZkMzdFRTc0YlIvQmgvZSsr?=
 =?utf-8?B?ZFpid1ExRGdmam9WcnpSRWdMQU1qOGZIL282QmJiS3Z1bnUrbnRQT01DUEd6?=
 =?utf-8?B?NTBkeDBld1o2MXlOM1NlTEtkdFZxeVhwdnJiOTdTMXZXM0hmd3h1K2lZRWRY?=
 =?utf-8?B?cTdiaXNzSnl1VXdkdGdtK1l3RmRaRnFPald1MTAvZkdMeGFiMklMNERuSXR3?=
 =?utf-8?B?WDdpaXJHWkFBZlVaeHR6RGtJUFJjVzJPOTBIc2MxSVVpek0vNGNUcnBlbHBu?=
 =?utf-8?B?VkQvazRDdmZvMGFFcDN6bW5EQ3JPY0dPTlE4L01yOC9iVEN6c2t4WjdTYWh5?=
 =?utf-8?B?TzlWTmx3YzFaa3VtMmcvUHZBR3l0MUd4RkJETFY3RDRvZ1R5ZzVCeVNGclF0?=
 =?utf-8?B?RFlHVmpwTE9mTWZoNmdUNEswRmZqVzFrcTRXcUg5S0RXd3RMUnFmVHBXVjA5?=
 =?utf-8?B?dnp5ZXpUNTRneUEzWXluOHNoOGVuZzd4T3Q4eTlQMGFQRFRzT056VytrblV6?=
 =?utf-8?B?Y0tUcDd1STdrbUxleDlmTHZ0Q2F3bTh3NE91QUZ2Zkw0S2Q0Ymg3OHRoZ0Zx?=
 =?utf-8?B?YW0vVStleUNUVU0wQTRXNm1QNVFBVE9TWVRuODlpY21iTXhGb2JLVGdKaytK?=
 =?utf-8?B?aStEVm9pYmxrSldNWVVrVkxmc1hKcVlzWUFydjUzdW5mUkpOaDhqWWhqZmlk?=
 =?utf-8?B?Q0Q1R1hWbXRQNFFGQVpkcDNoclZMZWkyT1R1cEorWXhod0wrc3RnNnVxTnBa?=
 =?utf-8?B?cFY4NVp3TC9iQUIzVmdBbjQralVlYkJTUkd6S2daTVJyNUdrYUFEb1IzUkNF?=
 =?utf-8?B?QWJEZDhBT0FWNFhkZ05CZ1psZk1pMEJiSUFNeWFiQ252Yk8wTmQ2RENPOFVF?=
 =?utf-8?B?a0lOS1NiTzZvNUdYMjBiNkxNeTVhSmo5ZVIyWW1Oc28zQUo2eUdqTnZmd0Q2?=
 =?utf-8?B?NzlMNklNaHhWNjJseGJzaTZWc0xJUXRsN2FjU1gxNTFOWDVDU3RaTVNhM1Nz?=
 =?utf-8?B?Snoxb2c4amRxQWRnVndsZHhCZncxa29FUWVGVHhIdTVJRzMwZ0p3S3VNMXlX?=
 =?utf-8?B?QTJ2MGhkMHdnVEtjT2ljdmUyTDh0Q3RMUUFhQVA0ZXRZUEtVNTN2SEphSU9B?=
 =?utf-8?B?T3BFUmRyUno4bDNBa01Zc0ZuRThrd0Q2S2RXNllpd0pYSXc0V2p2NXluMEQ4?=
 =?utf-8?B?RFBTL0VHWFRyY3dSb1BRTndDMzFLV1JVazVRU3F3YzBLYWpUQTNVcmJCR3p5?=
 =?utf-8?B?YnZMbGFqazIreko3SWtOaWgxRlFjUnZVbE85VTgwRmpPNTNzc3oyZWxTMHVt?=
 =?utf-8?B?YTVReFcxVmpCU09sbFdaSUtGdEVUSFZ0dnRZN0xIdktlVC83SHRrTCtjOVlR?=
 =?utf-8?B?QjNMYTE5WUs1NTg5a3B2V1FhRnRkUEZiRGxYc1hSSElKckwrNGw5bnJtZkdz?=
 =?utf-8?B?aStSL0lGYVBqeDJOakdTTVdUcFRiTUpIcGJ2dkZNUlZjQzY1QTZzdlpvMkdZ?=
 =?utf-8?B?cWh6SlF4R2QvZWRKVDVNQ3g4L1JsSzY0YU1xTWZaNEZLS01WOEZnbjlZRklW?=
 =?utf-8?B?alpqR1RRNDk1d2RhUTNKRUh6OG0yYk5rc2dnOGRFZnk4ZHVPZVZ3TEwzZ3Ix?=
 =?utf-8?B?V1N5aWM0Sm5Jc0R0NkU5S2pNMkl6VkJxQjZ1QlNMWE1kZGN3K1FPM0VJR0Ri?=
 =?utf-8?B?WGQ4TzN0ZDc3QzJpOCtkL1ozZUJTc2t0Q2xmY0NucFpaUDVTeUZ6OW0zQmRs?=
 =?utf-8?B?ek5TVkpyejYzZHhZaEtVc0lrSnd1NjN2cTZ1Nkd4RGZiM0FEaE5qaEw3ekd0?=
 =?utf-8?B?UjdUVkk0b0k0MmE5eGF6Qy9wQi9rM2o3czNiRnFYQkYvdFBZNkdjdkFqRjJW?=
 =?utf-8?B?Wm1Oc0wwWTNqSmx4dXIySWZzODQzMHJnMlFSVVhWYWYyVkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTFFNU1FVGdQS3daL1l0Z2hVVHJlVGsveDhQdXMrVm5WVm1rRzYvL1dnMzB4?=
 =?utf-8?B?SmUxK1VHMlUzTXE4RCtIZlBsTmtyWXZQNWRNL3VrK3pndTRkc2VIN1JmaGRG?=
 =?utf-8?B?OXJrV1NXNnVlb1ZQUnd5bHFacTNyUVU2TE8vTlBPbGhtZ2JHTGNleWtNbk9Y?=
 =?utf-8?B?d1UwMkNLaS9IemZGNTRpak1aOGV6VTgvWGdrV2xoVFBJdHBIN3RtVWQzWkFZ?=
 =?utf-8?B?cHZLT3VNRjZKOHQ2TjZOcGhVNm93OE1WL0tzOG5OT1huQ2o4cHUzYUU2Vmg4?=
 =?utf-8?B?Y2Y4T2hGeXlXN2YwR0tNc0Rocmp3a1l0NkNrd1dhUmdLZmJJRDMrUkNBODJB?=
 =?utf-8?B?WkZEUlFzTFJmL2hETUV6NzV3ZDl2R1ZWTTMvUXJsSy84NmxTN0o4QkNOOVNq?=
 =?utf-8?B?TEpqV2RJRVNwUW85OFpGNG41NXNwZEx5VDZiVnBZZ2RadmU0dndjU0paNlNa?=
 =?utf-8?B?aDRtK3J6Z3dxVlA2cHNlbHpvbjNnWTRBU3lSbDRiMUkyWS9zakZsQnRGa0lF?=
 =?utf-8?B?SmJLbExFUlczeEJ6UDFMQUlTK01Tazl2OWNXaVY1VmVPWUtwRFgrTG5IRVN1?=
 =?utf-8?B?UXcrOGpSMjY5M0w0WCtoOEtpa2l1ajY1cnFhZGprZmRiOVQ2RUp0cVZrTlNX?=
 =?utf-8?B?OFpOWkJGSUU3UEhta242aXgwdEFVT0FzbkVudTYveEEyWFhXZGNEYWJ3K3Bl?=
 =?utf-8?B?Nk94MzVSMDhxSjBrYnZlQU9UcWh2dDA0KzE1Y3ZnNUwrc0dBODN3Sm9uWmhu?=
 =?utf-8?B?V3ZWaFpjUXJnWFlNNm1JOUh5OGphTmlJSk9kc2M2anRRRTA5T1NCeml3S2pT?=
 =?utf-8?B?cE51VXo5QnRJSENhQXlyWUVlOFMwLzJYaER5YXhaREExbis2UGJGSUV3c2s3?=
 =?utf-8?B?bDlsREVmN0tsUUYzTzRZZE8yWkwzMFU0T2R5amUxQk9HZ1cxZjZrZGNKNi9G?=
 =?utf-8?B?Z1dpUjd3OSs0UFJxeFFZeHhLZXdHR0JMT2NyOVM4U2JyMDhxWHZvcUV5WUtY?=
 =?utf-8?B?ZFhXTmEzbTFsRElybmVMcE8vYTFTQjVmTUVGODMvMVlCelJuWWdtLzlYbGZw?=
 =?utf-8?B?L3c2RGpaZm53Wm01anNSTEtWSVdSMXJhTlcyTDdpMkdQMzdyQmp6V3d0SGRT?=
 =?utf-8?B?cFFLeTRQSC9zMzRqek5zZCtGUjZ6V1J5eXhoekVWbmlBRWFGTmRCYkpiNWNm?=
 =?utf-8?B?bDh3SjlOTHFBM3dHeE52cWFvSmdsenNJek5CVUJSV0kzbUtuWFNaamZ3UU9j?=
 =?utf-8?B?YW9Mai9UT3BYR1kwUjZuMGpOMEIybUNxdEpuUU1OVEVSelFycjEzQkYyTFBm?=
 =?utf-8?B?RXNrNEpIWG1xOXJyNUJMNnhWMHEyQjlMaTdvUzMySk9yRE52eDBseDloRG95?=
 =?utf-8?B?L3lNV1Mrb00zcTNXNStOZmtCRG05RGhJWDUwd2lUQ3duNTEyS0YxT0kxTS9i?=
 =?utf-8?B?ckVRR3ZFTjZ6cjkzRW83UC9iQytOM0orUWpRb3cvcXJmK0VOZWswMTI0L21J?=
 =?utf-8?B?ZmVQYmJORTl1a2VabnQwMDZBRUFBL1ZHQzROdXFqVmxEejZXODArNG4zbUVj?=
 =?utf-8?B?WkZSZHU3QmV0b294V1JyZkd3dVdlT09IMG5OK2pkVWsxMzFTb3hsQXYwVUNn?=
 =?utf-8?B?b1dreno2anNVOHY4MGR3M1ViWkdCZHVKaHNkZFlQVlE3VnJJWFJ3eHdnZUxo?=
 =?utf-8?B?T0k2VTdiQ0FaUGc1WkNBcS9WLzd1M2hLQ3NmOEZ0NkJOKzRWNkdEakR6dmxx?=
 =?utf-8?B?YnFkc3VzQThieWVKUHB0THVQVjJFZVZsNWNhVDJTM1FmekowazRQOGFXdW1H?=
 =?utf-8?B?djVjbFBTaTE2a1I1R2JJVXE1UUlyR2Q1UFd1ek1MbnhHQUxCekJaNU0wM1ND?=
 =?utf-8?B?alMweFUwKzhtc085ZENRRExrdXh5Q1FkRndKellHOTFBbUFwV3VVTGhiODky?=
 =?utf-8?B?RC9jbFBFalNDSCtjL3lSN2tZaHdqeWkyTXIwaTNrbFc5VkJJOTlPMzE4VTV3?=
 =?utf-8?B?NTk1d0hiQ1d2VzNBOE1Dd3ExS0tZKythV1RpL1MwdU1XQ3RWMjFiRmpVTkpQ?=
 =?utf-8?B?RHlEN0p2aGRSdVdBZzdKVG1oQUlJeTkvY0l5a0w5K1k4VW14NkpiSGpmN05n?=
 =?utf-8?B?Tll5M2o3RDZ0dWJtUThjK3cwaTNxTHJKYjR3MDk0VjdWKzJ4YW9XYS9tb09I?=
 =?utf-8?Q?mIHEVhKrrt46miItHJ2DodM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b21fc1fa-2bba-40ce-83d9-08dd61a50f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 20:32:51.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOZCjl7ur0ECo1CcxEBioS+wndSbBGC/8DtFprtdRp8n1aPSKYqQ+Wi+s8hz7A+VtfcSD+FjIlzagNM/dorcDVT3G3gQu/AgORQRXpmokWX8mU5E78ztd8vpIRiovIzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFya3VzIEVsZnJpbmcg
PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCAxMiBNYXJjaCAyMDI1
IDIyOjE3DQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29y
ZW5ibGl0QGludGVsLmNvbT47IERhbg0KPiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJv
Lm9yZz47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzoga2VybmVsLWphbml0
b3JzQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
DQo+IEFuamFuZXl1bHUsIFBhZ2FkYWxhIFllc3UgPHBhZ2FkYWxhLnllc3UuYW5qYW5leXVsdUBp
bnRlbC5jb20+OyBTdGVybiwNCj4gQXZyYWhhbSA8YXZyYWhhbS5zdGVybkBpbnRlbC5jb20+OyBH
YWJheSwgRGFuaWVsIDxkYW5pZWwuZ2FiYXlAaW50ZWwuY29tPjsNCj4gR3J1bWJhY2gsIEVtbWFu
dWVsIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+OyBKZWZmIEpvaG5zb24NCj4gPGplZmYu
am9obnNvbkBvc3MucXVhbGNvbW0uY29tPjsgQmVyZywgSm9oYW5uZXMgPGpvaGFubmVzLmJlcmdA
aW50ZWwuY29tPjsNCj4gQmVuIFNoaW1vbCwgWWVkaWR5YSA8eWVkaWR5YS5iZW4uc2hpbW9sQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IHdpZmk6IGl3bHdpZmk6IEZpeCB1bmluaXRpYWxpemVk
IHZhcmlhYmxlIHdpdGggX19mcmVlKCkNCj4gDQo+ID4+IENhbiBpdCBiZSByZWNvbW1lbmRlZCB0
byByZWR1Y2UgdGhlIHNjb3BlIGZvciB0aGUgYWZmZWN0ZWQgbG9jYWwgdmFyaWFibGUNCj4gaW5z
dGVhZD8NCj4gPj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTQtcmM2L3Nv
dXJjZS9pbmNsdWRlL2xpbnV4L2NsZWFuDQo+ID4+IHVwLmgjTDEyOS1MMTMzDQo+ID4NCj4gPiBB
cyBzYWlkIGluIHJlcGx5IHRvIEplZmYncyByZXZpZXcgLQ0KPiA+IFRoaXMgaXMgcmVjb21tZW5k
ZWQgaWYgeW91IGhhdmUgbXVsdGlwbGUgX19rZnJlZSB2YXJpYWJsZXMgKGFuZCB0aGUNCj4gPiBv
cmRlciBvZiBmcmVlaW5nIG1hdHRlcnMpIE9yIGlmIHRoZXJlIGlzIGEgZ3VhcmQoKSBsYXRlciBp
biB0aGUgZnVuY3Rpb24uDQo+IEhvdyBkb2VzIHN1Y2ggYSB2aWV3IGZpdCB0byB0aGUgZG9jdW1l
bnRhdGlvbiBvZiB0aGlzIHByb2dyYW1taW5nIGludGVyZmFjZT8NCg0KRGlkIHlvdSByZWFkIGFi
b3V0IHRoZSBwb3NzaWJsZSBidWcgdGhhdCBsZWFkcyB0byB0aGlzIHJlY29tbWVuZGF0aW9uPw0K
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTQtcmM2L3NvdXJjZS9pbmNsdWRl
L2xpbnV4L2NsZWFudXAuaCNMNjQtTDEyNw0KDQo=

