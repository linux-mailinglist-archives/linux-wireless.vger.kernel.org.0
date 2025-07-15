Return-Path: <linux-wireless+bounces-25462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A6B05644
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C253BE728
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D462D541B;
	Tue, 15 Jul 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJXJQPvZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AC22D78A
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571501; cv=fail; b=OEleFjapO4/ursGrfX/zEnXUcc5TM8UcxqFQ9QjTmWa4gGOzAkjXmShclh1ehFPFEMx9Qy2SoibERxynWl5wJFyhbn4K8eaYt0QxKiO8vAZKbS5DaAVvdUdh5vyjJixVe2j7kx7rTO4nVZ25oRKobxAUy6hg03MEMnwnJjhbrtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571501; c=relaxed/simple;
	bh=lSdfsS6UlWOWPBoGHeQPkQIGQMC5H0g/9wCI5cM68W0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gA5Fw6/qd6++l6u366bG6feswxkkwP6GoIiLapb7FgpmWpFpr1ShLr7SVYHZjWqqsUcYzzTYXdeXg4G8bWRtkQLpgRoM5wD65f3mYKi19Q+UZ4YnH9S+z/+PxuwTdocEPQbiKOdb2oqxcNg5St4Hw1cXhFP4t6c+s6ucs1rf+pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJXJQPvZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752571500; x=1784107500;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=lSdfsS6UlWOWPBoGHeQPkQIGQMC5H0g/9wCI5cM68W0=;
  b=iJXJQPvZUMGHsycbR3sNNzt8QvgulStOAwfoZ2zjnXkcLPT70QsRtiee
   B5i1JXYO0aopKezqxRiqlnm7YOdIHwA/+RhIh6+k2K5GPZ/0/dtIrM1qR
   Vk9/W4DgAPKj4wW86q80kzxLvtHZnDCvJm67RxoikPFACzBJRSTez65es
   POh8VVlDkzaLcNdowxV9t07R1euY8haGoKEoOG9ixPAwUQo+PZikfTQCX
   RtnWk9K9MuD3vL5qPVtErOG+dk2bQllE2I7CGp49wdO/janC7evAF8D4z
   9cCNZL/7xWVGn8jHD2ixpMH4+gXJ/Dh66cyVD00g8ADv2QcRw0bnC4BGv
   w==;
X-CSE-ConnectionGUID: V/eX5LiSQhON2RtIBhSGBg==
X-CSE-MsgGUID: GvE+Zzc6QA6l8rlyn0O1uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54871812"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54871812"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 02:24:59 -0700
X-CSE-ConnectionGUID: IWnfvhaFSUKSTMCYs5IgLQ==
X-CSE-MsgGUID: AbS6szqiTymrL8oiFPpjhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="180875881"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 02:24:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 02:24:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 02:24:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 02:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmIhki8hz1VEADBLazqvugBL5lgXBZjgb1lmLJBMv6Hygx57YZr0wWuP9550gwPXbQVOZ99RaCPbB/mg54C0Kqi7JfLoaHGiTvJgVpwHufJdZQaPhrJzqYop1WPfHMmMA+Yp+O7QsNL0wsRjbtvRsYm7hmsJp3KIIS2a0xdbY90ayhg4mGj9KIv9LjWCuSvkNd8taDo7Nzl8NHOl61R1+G47dcXR4AbCoo78ee764hHz19tk0oYBmSIod3N8GZlTRhyuMJo2YPDlv8la0kiBaXIUP6DIHSoOc0XlRf60Qb5YUROxKc7uQC19iSYP1ubKpkePfnhNWZVnAMNZ15Qqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSdfsS6UlWOWPBoGHeQPkQIGQMC5H0g/9wCI5cM68W0=;
 b=G1wYP38ObFIeEoH7XB+UAlpRJTKS3CIO7OJpdKF+SqK/A6iIv0EczimNKbI9Xrdj1+AbankD8T4n1rFxh+4b+ZkX8KnVgPMxQJ3+gx+ucy6+6mGwKn6HszQWfQz6m81euoBwEzg/N9/bdm/AnExmZDINkNbD5vRoUJWkviLhn2i10QHjgpE7QqofYhEuC3tBJGKm4/cOF5SiCiJj2BVom6jinioMJ19xNIoY3ZBNTfVb1grfTYxMJ6pTFlinVM1PV25SnJvIUjvzTTS99VbSE5LkYOCHMGQKNm5BnSlVCJh0ItmQrnIaDjnypNbUm12LLmucAH4YantR6OmUtACwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA4PR11MB9299.namprd11.prod.outlook.com
 (2603:10b6:208:565::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:24:39 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 09:24:39 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>
Subject: pull-request: iwlwifi-fixes-2025-07-15
Thread-Topic: pull-request: iwlwifi-fixes-2025-07-15
Thread-Index: Adv1ajZo6NC9M492RGG8a7313r5W0g==
Date: Tue, 15 Jul 2025 09:24:39 +0000
Message-ID: <DM3PPF63A6024A9AD42B4E339B16B036FD6A357A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA4PR11MB9299:EE_
x-ms-office365-filtering-correlation-id: bb3daadb-99aa-4398-a9e2-08ddc3816c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWF5Ry8xWE9KUGpwbEtZM3ZDcHRYNU5XS2N2TXdkSEtDUWdlK3RnMitxUFd6?=
 =?utf-8?B?bFpKYVFUVnpwc2NmMFEyMFRWaEp1TnRxZkVROU5mZnM3VkJIY3BDWS9uTThk?=
 =?utf-8?B?YU9ZRkpxc0ZudDJicUtRdnNiMCtPNXp0UnBjQ3NyeE5aWDNsSG1TMEMxTlRW?=
 =?utf-8?B?ZUZrTU1MN3pRbEdlSGtqN3cwUlNZQkpzcFhwb0xwRWszS3RBRVY5emI5RHlC?=
 =?utf-8?B?QkNXMkVnUnFSejJYalNHZElJSjhyd2lvNFZBWWRWTDdmbGthQzRXUXlPSk03?=
 =?utf-8?B?OFFRbnp5cFh3RjhDVFg3NHl2QzlQR0xWUlhGemEvV2YvNjhtSERqV3I5QVlP?=
 =?utf-8?B?TUw3UGd4UC9UKzVNaWNMSkYrKzEremovY0RYd3lWL0hNUjV2TFRwSWRoVTZE?=
 =?utf-8?B?Zk1hdzFMVWtNNUxuVXFlUFlBbllvZnBNcTZ2VENsY3Zqd0tVVXZ4eDFTNzl6?=
 =?utf-8?B?dU8reFNScU5JL29PeHh3RjkrSEhKNE4zVmQ3enZ2SGZ1ajlpTTNJUjV2THFT?=
 =?utf-8?B?YkFhUXpBM3dNclQwOVZ5YWlmUjVrSmMwSGZZUmViSnM5WldOYzhVWkoyeE9H?=
 =?utf-8?B?S2JHdnhzWklobTFlV010Z0NIWUovZGxDUHR0ekNyZWNYUGlOL0dwb09hL2Jx?=
 =?utf-8?B?c293Q0ZYWFF5V3RHWTFQaXQ0T1ZIcnQ4Q2xJQUhiNnR0LzRMeTBDUEFLcTFF?=
 =?utf-8?B?ejRCSXIvMFFYRmkwa0hrQ1RzcVRQaWp2QUNRVHV6U2dhaVdUVjFwMUdIRUJn?=
 =?utf-8?B?T1poWGFFODhZZFB5clh5aG9LeGNtckRjby95UDBsNFQ1ZHJnVHRyUENUd2lh?=
 =?utf-8?B?WC9UQmhSRXlhamVtb0VmTTgrZStSck5lTGpwS2pqUmNybEhPSThYeUVhMjVN?=
 =?utf-8?B?UVZUUzJBOVlXeTdkVkg5SzlJeFhZY0JmN2xGY3ZXQ0NQVmZUU0hBSkxVZHpF?=
 =?utf-8?B?bGc0Q2pLUXY0SVdQYy91V1VHSFBSelI3TDRvelZSc09kL2pXWTM2QUttK0FV?=
 =?utf-8?B?U01NTHRvRHAwTmozTnpROVZHL2hUWExXNGFNbW5xeXlDVTlTSG5lQ0FKQ3ZH?=
 =?utf-8?B?a1BUWVcrMTk5MWxQRHNoWGEyVUdlUGFOdXpYWlhXS0hQTVluUDc2Y2pGdnVV?=
 =?utf-8?B?aU14OFNBSklPVWNBaFBaUnI0RVYwYTdmb3poS25pR0s4d2FmNFNsdFM1ZUZk?=
 =?utf-8?B?dzVUQ1VaUktHV1VrTXpWWS80cXhWUWtWVmRkQ0FLdDBxK1hQMkxsZFlwcmlG?=
 =?utf-8?B?TUxlNTNTbStPcCtoeTErUjJiKzlHYWJETzZBejlHRGwwZjhWTm42U05kUnBi?=
 =?utf-8?B?RWNhdUE0MzdMcEtRTkp1VmI2R3dCa0dXRjl5bmJ2djZPQWJoSmFaWjFETFZM?=
 =?utf-8?B?WmZuZ3VyVmx4VkpxbzdyZWo3QmxoK21PWnpZUElKbzlKalNYMi91OFpJMng3?=
 =?utf-8?B?RUVzZVpGQXZ3SGo3bVdINHMzS2o1VDhBcDBUVUlMUzBmVjFKNk9udmhQakdX?=
 =?utf-8?B?NzV4TWZtZjFoYU1HVFNwM3hqUkw5cUxKYjgzZ1grVmtKLzRyWU1hV0lBOXZN?=
 =?utf-8?B?cUZMSHF4d3U5MHh2Ri9yMU9xT0ZZemphL0s4c1YzUGJ6WU5Xb2h4TFVnWGM3?=
 =?utf-8?B?b1VPMUtzK2FPaXg1REkyendBa1B3Vk5xK000NzRnTWNRVkJuQmdlcUpCSzRB?=
 =?utf-8?B?ajY1RUQ0TW1TY2lVZUtNZzEvalR0SC9PNVpRZTNPWXFQTkhJZU52Rmt5Qmkv?=
 =?utf-8?B?akZBTjhCU2JEU3BObHFUZ0JDUktYQmRUbUpJUGlFMEZSUDl0ck9OUnhHRHhj?=
 =?utf-8?B?a09mUHhYYlpML0s4Qk1GUXB4SjgyV2dieGxHdTVSUTdkNmgrNXd3VUZKRnpl?=
 =?utf-8?B?alVsNDVEckl3UUZOL3l5c1paSHo5ZHRRbE1EUWtCSG0yR21EWVIzU3FXVXU5?=
 =?utf-8?B?SDVTQlE4YTJ1RFZjT3REQ1BLZzBGSkx6Q0FhS3pKNnpFOWxRaklIWS81eXpJ?=
 =?utf-8?Q?WPYZcGfdhOjww+EtocZst5SEhdJmM4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTl0c2xrODllSjl0dGZWVHdoS3BwakZ1SG8xK1lPUHFyN0Nla3VkVU9Lakdp?=
 =?utf-8?B?ODladGJWNEFFb3l0dVZVK21zcUcyTkxtZng3UTBlTXNRN0drUzBRL0N2TXUz?=
 =?utf-8?B?cDRzMmdDeUZwdS96NS9wdEtvWEtDMlk5b0dnajRiV3U0cmxnNHd3WUg3bkVh?=
 =?utf-8?B?eUR4RkZuVlF4MjNlMHFoMG5WbXhrdDl6YTEycGFBZng5N0lsTThRZEJzT0lF?=
 =?utf-8?B?UVFNMXhHRlFUeXlGUjFtL0pTTzBuSDI3MDFhbjRmcjV0VDU4WmtuQjN2dGhx?=
 =?utf-8?B?K29KV0krWm12cDBEYlo1TVhZVXZsS3BZSFJ2aGtRNEZQdUVRZzY5bmNwbEtR?=
 =?utf-8?B?RVBnaUl2cjl5OTBzd1FlWVM0ZkhIcVZaNjA1cVVnSDNnY0c1ei9vZ0pMWWZ3?=
 =?utf-8?B?ZkdPK3RMVmx0N09UNlNvemFaVS9tbnlOS085RG14N1c0NU9wd0RpT3BXUGNo?=
 =?utf-8?B?dzA1TnV5ZCtJRHZ6QzlUMEtJdnlPTWVjcEVZb1hlemZQby9ySVAvRjU5WWpS?=
 =?utf-8?B?OHpwWjZoam4vMHd6V05tRmgxcnU0K3EzcmVzdDU4YWJ6R2VraUVTazZJV3J5?=
 =?utf-8?B?R0tmUW5MRGNkQXJDVWlTRStEckNqTm8vdVNPLytXdFo4bzV4cW5DTWREUVJT?=
 =?utf-8?B?dHZzd3F5azRuU0JDd0FXZ2VjWnhHbG9qS1NaY2RIZzJ2T1gwa2N2RGpJZGpv?=
 =?utf-8?B?SzUvT2Y0RElMd2RiVmc2V2FTUnl6MjU3QklubXcwYW1JdlF1WUhxdi9NVE9Q?=
 =?utf-8?B?a0lrTFY3b2VIOGs0aFo3akxpM0pZb2VyQ3JNcERRV1VWblc3ZHVDSW9ESXVJ?=
 =?utf-8?B?U1FTWlI5TndUT1k5L0I5NzBRK2tud1U2Yk41STVzeGFqNmdqSXhMRS9DYWVE?=
 =?utf-8?B?eHhnNmoxeGRvSng4bUVjdmFVdXVmbjhoMm1wSU0zd3MyQkI0SlUxdkYvdHkv?=
 =?utf-8?B?emZnUnZ5L0VDTHlSYjl0K2NaUjZzV0F5eDB4bldmTGx0bW1ObWZEUHJUWVlh?=
 =?utf-8?B?SGxiT0k4S3lsbGR3d0N3MU5Zbmd5RzJKU0FJejlHWUVQdFVLTFlKaGZQUzhU?=
 =?utf-8?B?ZG4yL0ZhTDlFUVF6N1ZXWGlhNkFrMEtCaS9zQjVCWXpHNmplMXlUL1orU0lG?=
 =?utf-8?B?Mk9uNTJMWnZwOGVVRXI4UWV5ZzE4SHFKRGd2SXh2MUpzUG5mVFdxVFA3MU5T?=
 =?utf-8?B?ajNRdWpuNlUrU2dDc3JXM1F6SDMrU0tTM3pPb2o5WU1jVlNrWjFqY1JCNG5J?=
 =?utf-8?B?cnEvK0xvK0N6THFSd2tGT1hESHM4V0wwZTExNDZjTmM1eHcrNWJRNHc2MzR1?=
 =?utf-8?B?MGl2aExaT0Q2OU90aCtVdTdFbWlzL3ZhTTFIVisrenBBVzBxbjBtSFFjUzBY?=
 =?utf-8?B?c2JMbDRaRkh2a1pUTmxXbCtHenpQSmRXOHU4WmlnaFEwK3poajVoU3FvQlBT?=
 =?utf-8?B?aXJzWEQ1YnJVRy9DZEhHOEhtY2ovMWtjVk5uUWltT3FmNmlTUVhlblVDa2N2?=
 =?utf-8?B?U1pkME1KalhhOXV2VVF1ZFh1N3A4TURVZWxnS21oV3gxTEdESnBTOTFuVUZn?=
 =?utf-8?B?TmQ4UHV5N0R5UHpYZnBjVDdrQkYyaTUyUXlKYW9UbFNVdFdKU0k5SFdHQ3lu?=
 =?utf-8?B?dkQwakp5S1Baa1dOU2VzbW5zd0lQUVRYbDV6ZzM3cEF0YnBsRG5WNG1XSjhJ?=
 =?utf-8?B?K1JuUlZGSWc5NCtuM3M0VHpvSUVLQ1pCVURGRUdkUjNydUhhdkpHaGptSGl6?=
 =?utf-8?B?OWFsWkdZUTE3WjVtelhsM3ZzYkhwWG1POWlvWGlHZDA0WmZmaWZRV0RhdTkr?=
 =?utf-8?B?Y1VtVFAwM3JSZWovbVdvMjBHczI0Ri8wRHl3ejUxY05YUEpjYS9McThJRDd6?=
 =?utf-8?B?ZHBzaG02N3R3THBnNmtIQkVaYndFZkVUWUNONWdxeUcvN28rOS9XZ1lPRnJT?=
 =?utf-8?B?Q0FnQ3NMMWlUOE1jYVA4Q3dESHQzLzZhZXFNVUFHQXdQSmNPSFBBR3cxbEZ0?=
 =?utf-8?B?cHZrZEVybldTKzQxeENRQ2MyRW02V044L1VEb0ZXQmx0Sm5BT0Rka3JGUGF1?=
 =?utf-8?B?RG5Bd1BqYTliNzlFM0UzNThFMmpMM0pxS2hSdTJVUGdtVVFNR3pQVkZUbjUr?=
 =?utf-8?B?UXJpZE15TUt5WVZSQ3l1RkFPZjFBWTUxalRXY2JVQjFWTy81TmRKeUxIdWhn?=
 =?utf-8?B?emc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3daadb-99aa-4398-a9e2-08ddc3816c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 09:24:39.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FsSalYcSXtlGa9PL39V8rEDve0AOlcmK4MkA+Kq6YLONuTL2UeU2o8+z1V+9QMAnom5xDeZF2OB1cWzKyVpshI0KwrR9N8CzNR3Y5eaKekvXl8BrtaZmqmvdrUnvzvp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9299
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5MzU5ODE2N2RjYjYzNTFiYTQwNDQ5
ZDk5NDI0NDY5NjE2OGYxMDk0Og0KDQogIHdpZmk6IGl3bHdpZmk6IG12bTogYXNzdW1lICcxJyBh
cyB0aGUgZGVmYXVsdCBtYWNfY29uZmlnX2NtZCB2ZXJzaW9uICgyMDI1LTA2LTI0IDExOjM0OjI2
ICswMzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3
bHdpZmktbmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1maXhlcy0yMDI1LTA3LTE1DQoNCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA0NjM0NWVkMzYyOTZkOTY1YWYxYjZlNjhlNjIwNzZkNjc1
MjFjNTVkOg0KDQogIHdpZmk6IGl3bHdpZmk6IEZpeCBib3RjaGVkIGluZGV4aW5nIGNvbnZlcnNp
b24gKDIwMjUtMDctMTUgMTI6MTM6NDAgKzAzMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCml3bHdpZmktZml4ZXMN
Cg0KLSBtaXNzaW5nIHVubG9jayBpbiBlcnJvciBwYXRoDQotIEF2b2lkIEZXIGFzc2VydCBvbiBi
YWQgY29tbWFuZCB2YWx1ZXMNCi0gZml4IGtlcm5lbCBwYW5pYyBkdWUgdG8gaW5jb3JyZWN0IGlu
ZGV4IGNhbGN1bGF0aW9uDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkpvaGFubmVzIEJlcmcgKDEpOg0KICAgICAgd2lm
aTogaXdsd2lmaTogcGNpZTogZml4IGxvY2tpbmcgb24gaW52YWxpZCBUT1AgcmVzZXQNCg0KUGFn
YWRhbGEgWWVzdSBBbmphbmV5dWx1ICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1hc2sgcmVz
ZXJ2ZWQgYml0cyBpbiBjaGFuX3N0YXRlX2FjdGl2ZV9iaXRtYXANCg0KVmlsbGUgU3lyasOkbMOk
ICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IEZpeCBib3RjaGVkIGluZGV4aW5nIGNvbnZlcnNp
b24NCg0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL252bS1yZWcu
aCAgfCA1ICsrKy0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9yZWd1
bGF0b3J5LmMgICB8IDEgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxk
L3JlZ3VsYXRvcnkuYyAgfCA0ICsrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL3BjaWUvdHJhbnMtZ2VuMi5jIHwgNiArKysrLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL3BjaWUvdHguYyAgICAgICAgIHwgOCArKysrLS0tLQ0KIDUgZmlsZXMgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg==

