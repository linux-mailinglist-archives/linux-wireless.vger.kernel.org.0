Return-Path: <linux-wireless+bounces-28099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79334BF0E64
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338B33A64F6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658A2F6576;
	Mon, 20 Oct 2025 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VyNg+Kv1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB82F5A0B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960669; cv=fail; b=ABQ8ULZqFQ0xNtbwqIJQ151gNoSTZ1gnFrcWZQZaLU7OqpPe28KQVWPs355CtB6i+q0nHBtJs/m+GHA0hc2GTiKcA1MXMkHUaZCI4HIV04McpbQWm5NciuEgNhN6sp9hB+9LFKCk5gnWNtyQtQ1mvRL53kD+xTUnxohndrQlAcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960669; c=relaxed/simple;
	bh=GPGpWllDiTr2kID5BJOdOCy3+wHuLsYCyiqppVrovgU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OMokRqRDYjDuSrhjd+IlO5X/sbksy3+J2ho8ecExTZZWFX7o5YAE0YuC0Cig4KCgCGl9gUGMr+o9GcvCbYvwt49dPuVHJ2zcm6wPJKVbsAu7rR4n9u7mWA9M/LnkzEV9Rka6o7iZpQz2sDbkRmHlxszZRCt8dK7Fp5QiW56M490=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VyNg+Kv1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760960667; x=1792496667;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GPGpWllDiTr2kID5BJOdOCy3+wHuLsYCyiqppVrovgU=;
  b=VyNg+Kv1ekF0GSYXMyBfc5Us2irHky3lrK19m5KawxQTqNtmMlwa/RMQ
   fVySgJrQo4KbzOwOVfUGe20FHriTfN/6fyLj5RblrHJ7sCqD/GO6Bf5N/
   Fu3YC/SS8KNQbXr6xHd6QlqZWl/PlBtgOOSU+lqXDWqPaNtLZBM683qWd
   NYlsGVLy2LPIwsKz/aFhKhX4TEFIfxbo+Swyst+Fgam/hM/lEb0AiXedg
   z7lHM7bUTJpKWoXCSY20aSmlnT5YEFc/OAh8+hupkU/9Y6CTds9vlF8Ed
   iQZtQ0DyZCQkGcuDAY8deQ/ZIAa2mBh4bBviCL49ek06yy20DKkufsFsh
   g==;
X-CSE-ConnectionGUID: w21iCuz6SI6dsYoEbzOh9g==
X-CSE-MsgGUID: +zF+lPK4RLmWJRWMNRAEDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62992191"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62992191"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 04:44:27 -0700
X-CSE-ConnectionGUID: ofghT0j9Soe5dRcQgASyzQ==
X-CSE-MsgGUID: rhZLbn0/S5644nrY6P0y+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183152123"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 04:44:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 04:44:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 04:44:26 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 04:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kmfp85wtIpsoVmK4X/fg/oU94bNSWvCNlRwFrMJ9YhhcvjqIDuTDGnE1uDQ4zkYwE4/fXEqbkzemluMwfjh7Lr+6y3TZ6vii/4z6PJCbdjRKc+3ejkWzL3FzCF5NPESGImQcDaRGkoWxVOAMH8/8NU9Yz8XWpuKk7OSC5RzKj5oCO1ed1iOOTkPGI4VEFmG2VqS7/jrokSu8pbaDy9mEKKAId/CVHC9gsYye8pKA7WLEgu0chj/jbozWHfh0/dZAqWky5/g6o5dNou/SDVK6D7qoeBJhBQakT8ZI7HW5GvHYuaZdbTIc9TcWlMEeUCBUTHzs2X/nCAd4TAsFrMX1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPGpWllDiTr2kID5BJOdOCy3+wHuLsYCyiqppVrovgU=;
 b=tDO2c3H9gju0pIVAr7pTb6GMYc3ViK/3lIzTG6IkQU+zpuMakPQV3ioC4FS+Rn72gPMsUxp27m27grfE8+spc94+/rH6b71sQWVNPwtehr5kemubswY+Slp+4SDIU0RiZIU9ZN7lV1YNwOLgEKJ6oIp24EVzKrKx0miSrpUIDWB+HXetCp39IuGx+1ernOTDpPrlxXQ2y82eD6EZlF+PsmbIkxZwPSfZwC9aNx2kZPF1thDOkt3dRVZWwDYfyJpMcBlCdGUBW+GR78ejGvaRvaS4d94EoH6L2Iavh3Z6pgFNMmg5PdhZU8kx1xv1J4O81m5CYGEjdHISej3fIFKITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA3PR11MB7655.namprd11.prod.outlook.com
 (2603:10b6:806:307::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 11:44:22 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 11:44:22 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: Linux Wireless <linux-wireless@vger.kernel.org>, "Dreyfuss, Haim"
	<haim.dreyfuss@intel.com>, "kyle@infradead.org" <kyle@infradead.org>,
	"Hutchings, Ben" <ben@decadent.org.uk>, "Yang, You-Sheng"
	<vicamo.yang@canonical.com>, Josh Boyer <jwboyer@kernel.org>
Subject: pull request: iwlwifi firmware updates 2025-10-20
Thread-Topic: pull request: iwlwifi firmware updates 2025-10-20
Thread-Index: AdxBtqJnvPLcUXzMQN2aP2f74ScfRQ==
Date: Mon, 20 Oct 2025 11:44:22 +0000
Message-ID: <DM3PPF63A6024A9F84E169D8EC641101840A3F5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA3PR11MB7655:EE_
x-ms-office365-filtering-correlation-id: 65c3d880-2316-4b7f-9854-08de0fce036a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bjBZTkZUMmxrQ1JxNEhVWlVhQngyejVzNjJqTk56UlYrK1VIMlU1ZG1IcHVD?=
 =?utf-8?B?OGd2d2dTWmxQd29FblZGVzNCMVE4UWtsNDh6NVI1a1MxUndRL3EyMjRLNGlI?=
 =?utf-8?B?QnBpNURzM2MrRFZDempIMi9BVGRybTNaQnRtSEF5MnZPVVFQWmFtd0ZxaFNa?=
 =?utf-8?B?NnYyK21mSE1xVUU1cUdkZDN1K0xaVDBZMmhrMktqMVhKR0toelBTcGg3dnhv?=
 =?utf-8?B?aFlPeFphNnZXUVNQT2d5SW1KblkwSHd0WXJGWUR1TzZJNFFvUTFrT3ZIZ2Y0?=
 =?utf-8?B?cjhDOWdLUERrWEhGb09yR1RRNktvZk9rVG5jTzc5Q3M5UDEycGF1VFJqdE9u?=
 =?utf-8?B?ZkFndCsyd2MzTmtiMEtPaEdaWTJQRGlsME11QkpvU2JETjlPODV2M2grcWxO?=
 =?utf-8?B?V2Q5ejZSNkc5RXRtSnphOUNRRi92OWtlWEhPTDBmVHh6OExpdTVWZVhodzlS?=
 =?utf-8?B?S2hlajVDcEpIdUg3RUhzcmNzVW16NnpPeUdTL0VQZzZ1UEk4eVpCMWFoaWsx?=
 =?utf-8?B?VkhQREg0ak5rUnRwL1BUd0k1VUxBUlNBRVd0dmN4eXdlSmxRVm9NSCsvb3Uy?=
 =?utf-8?B?RkZBZ1ZEQjhrRG9XTG9hNnNrRXJyVHRML0w3am9CMHhRWmF3MllJMEZXYkVz?=
 =?utf-8?B?YkY3WFZaMFErTEtBbTdkNHZXU2R1b2swUWxXSlZtZTkrM1pER3oybUZuVk84?=
 =?utf-8?B?eEU0NzFTTndHdDNBNEdBNG0xRml6WHlxVjgvMklkNW5VYjFnRkx6YUhkWUlk?=
 =?utf-8?B?Z05hc0xhOVc4V1J1VmhLelNKakNqR3RYOXJ0TjUwSXlIaTE4ejFCM1BmNWRS?=
 =?utf-8?B?bE9DTmVrSjJZaThRZTNIYmRobk1DVVlSNEFIalJYeFRVZTI2alZDbWptUm9N?=
 =?utf-8?B?ZEJ0NHl5YUM4ZWlJNkgzWlJOZWxlZGFtR0tKN3NHS29OVGJSQWpwWWxXVm5v?=
 =?utf-8?B?bkZYTEtRVnZUSXVDMWlmWU1JamY3RWFDMDFWdUtncnBlUHpJMG1MSS80VjFO?=
 =?utf-8?B?NFplR1pmd3J4S3lodWJ2RW9XcWgzRDlFNEZ1N2RsbnhGdVJycUliM0dsdXhl?=
 =?utf-8?B?Y0NmZE1uYmhMak8wV1BFS2laSVowVVlocVdvQTV2QkhZcG1MTjVTZzZ2Vm91?=
 =?utf-8?B?Q3o5dTV4VE5jL1BhWHdkZFNZTTUwdlFWaFpEYkZnUVZUUTdMYWIwMDlxZHd3?=
 =?utf-8?B?ckZJRWFpRGRnMjR2NGJkN0lka2czWGtXUEtHQzJaU3lnaXI3cU9qMm9IMFJJ?=
 =?utf-8?B?TVA1NkUxbGNWUkdnYXcyNDNPYUdzVXdaMnVQOXlnbVpsbEYvNmw4OFVnMjN4?=
 =?utf-8?B?bWE1UE40djcxa2VrV1ZCWUpMMUZVTXo0SGFFY2lpWTd3cjFtYWlZK0liRUZF?=
 =?utf-8?B?SlFPak4vNzlmWllzL1FOLzhpbi9adGd2dzJhSUx1d3dzK0FHZ3JiWGFZTWZs?=
 =?utf-8?B?bFJlM1N2WUQ2OWtONGVRMXJhTkVIZGVIdTkyTHNNd1BJN01mMG5hZFpsSjBu?=
 =?utf-8?B?ZFE2YjNSTHg3TkdkSnljclJyVytvZVpKeGV4QmR0VmIzOXNnTWNjOCtTbXI0?=
 =?utf-8?B?VFRuZURNMmhRNWUxZTBZeUNmUm5PNm42aGJWbFVEY0lEVFpkODFYaXRjdXdK?=
 =?utf-8?B?UjJDMFFWdTJVMnlVZWdGZ09xREpEQ3pCcWZGNEtCc2pkOHJzUjJETnpDZllw?=
 =?utf-8?B?c3NEdTEvL24rdEduRGNydzI0cm1LTHQvb1BNTU83cjgzUXQwaG4yMDBnQy91?=
 =?utf-8?B?SThoZzdWRmxrTTNQUE9NZnFFdHFUUnVGU3M2OHk0UmdoWWhsMGtOYkp3bXJZ?=
 =?utf-8?B?dFhDNkdNS3EyVS9UVytYRUk4VVRycHpLYnh3bTFrWXVrZWFWVlJzZjFRK2ZZ?=
 =?utf-8?B?VVNEMDZaRi9SUTkvQmwxUG94NU5TK3N3bVM1Q3RCOWFsckZzdVVvYTFhOHlr?=
 =?utf-8?B?c1A1dHJOMC9NUkczVXVqbmRyZ1dUSUpTNzZvdUNpelVOYVZVNjNFTEIrRGFm?=
 =?utf-8?B?N2R1ODMyL0gyYUplQXBUeisvMVhFR21FdUcwMDFhcTZHRSsySWdhOGZnRVlF?=
 =?utf-8?Q?jubnFz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGN5OHR4YkxZR2h0c2tVSGhUYUtSMjl1QTlwSGhwZzhrZVdYaFJMVmFTcm9h?=
 =?utf-8?B?eHF2T0FJUGI5bjhqQnlGSVlVR2ZOeGkwMHV6ekt4ZWV6Y25XTnlaUkNISWdj?=
 =?utf-8?B?SFVzOGVRd2NZTlVFa3FHcnduWGY3V1pUdU5zMTB6ZGpXdlZMT0kwNm5aekFx?=
 =?utf-8?B?aFVxaldUV21uSzBJTXlpcE1pQThWNkJGTGVVNFlhNE1Cb2RNZ0I1MTQyNUNL?=
 =?utf-8?B?d3VJcS9OOWFjSlNBZngrNk5EYlZ5Ukh2bGVKMU8yZmFVR0dKZlJhVkVnT0Ri?=
 =?utf-8?B?TDkrMkFkL3M1dTNsdkM3RTJhUXNjcTdlbGhxMjRPTTJzSzUwdjJEdlg2eXA4?=
 =?utf-8?B?MmhuSG1hdVZoM1o0T1gvMXV6TUJROVgyZ0JkMERXMSthdUVEMVovSU15dGtr?=
 =?utf-8?B?R3N1QkltQTh1eVlTS09wWFZ3M3VKdEhtQnF3MHhPV0RSVzZCeDZmZFRvUnlU?=
 =?utf-8?B?WTRIOVJacmd1QTlGdVVlLzV3anBSWEdkM1pFU3FlZmE3aks1d0g0dXlhSjg5?=
 =?utf-8?B?QzBsRzhlYXFnaFdFOTRLTXV3NklXZnN3bmFlTDdOQk9BT3ZEV0lteWZLV3hK?=
 =?utf-8?B?cGZXYndNTDlhamh4UEpIS3dhV3JEYiszUCtWSTlTQ3RIWHZYS1EvZ3dLcSt6?=
 =?utf-8?B?Nk40UEZhRUd3Q0x5UkZUVlV2Q1o4NU1xaXZUM05VK05yTVJ2V1RGNDdnSXlv?=
 =?utf-8?B?VERWNTRJTlRwQzBIU1d0cG9XS2FaYmRRUGkrMTBWQ01DY296bHk0ekhXbzNM?=
 =?utf-8?B?V2JzUUVrMDJPeEV2T1NTTG1uTWpqOVFhbXBBNGp6amxwa25UOGVJRXI2bW5q?=
 =?utf-8?B?bmhTZEZGNjBQVXJoWmNCYTlZcnFYL3JRdmRmRW9DamJvRkMxWDgzZXhJdHNF?=
 =?utf-8?B?dWZHUWh6QVNOL1hzekp4YjZqTEZYZGowd1VlalB1M0dIS2dQamZLVU13SlUw?=
 =?utf-8?B?UmxCMFRNNkp5OVFxVmx5RjZZVUs0akNwTmtWYk5zTk9aVnF3QU5jcVU1VjJO?=
 =?utf-8?B?dUFsdHNFbVN3ZmE0MHpRNzJrQ0U0WHZpRElmYjZWUlMxdGF1Wk0rTllIdEN0?=
 =?utf-8?B?alJ2YTEvZUxxMm4yV3FTMHlVdVN3YnRGQmdzcWxiL1J4QkZXb3B6N3JnL2Vr?=
 =?utf-8?B?MGh0WjVYS3p2OHJBS2RrUFArZ0w0eFZ5L2N0ZnMrSFJ4N1A4b0ROR2tNOTRl?=
 =?utf-8?B?ekUwbCtpam9kb0ZiQStOcDdxbDgzdFA0dWoyM2xxcGp0Z3FjYktxZGhGcThr?=
 =?utf-8?B?dG1maFBka0dsYXF0NCtQcXZzcWtYam1FS1hwVlp3R3hOQTFGZmVSOUxvRVNC?=
 =?utf-8?B?RnNtQ2gyY1dlRFViY0tyVE1qN0RqdFJrQ3UwUjFMWEgybTVzZExtakRLQ1RS?=
 =?utf-8?B?UHVLdVBIR21lMUp0QlR6Z1JaWDRGVUQ2MitFMG1KYmg5UDVtYVlVTlRYK3dG?=
 =?utf-8?B?VFY1Z1hidEc0YVB6VzNXMmdxalRxc3FQcnpWMnVqaEJSZzhGSi9QYWpacmt3?=
 =?utf-8?B?SG91ZHMyVnZKMmRQNUNMSGZkZ25mSEJtN3JUVFVFcDZzeXp2OW5qd0c2OVZK?=
 =?utf-8?B?WHRJTE1GSnNZbmQvaGtkczU3cFUxWXExN0lubjBaWlZtdUpHWlZYbjk0TDRH?=
 =?utf-8?B?am1JNERqZXBZVkl0VTdpZWhTd1lBbEp6cFdxOWdFZkhQcHhrcXU2RHRhRkdS?=
 =?utf-8?B?cFdBMlUvS1czd2N6Wm5xN21lbk5BcXJNTE5RR2x1VnB0Unp1YkZaelBvdlZF?=
 =?utf-8?B?M0h4UTRpdm9vdk00NXNNZFBDYUsyaURJVEhLeU1hU0JWUlA5K25BdVgrQ3NS?=
 =?utf-8?B?WXFBelZoVUQzT1J6ME95c0sySEo5eFFPLzFYOFlaSVMwWHl2SkJsMXR6TWNI?=
 =?utf-8?B?b1JCWUpFeFNoQnprRDAzU0VDR01qWTE3aHR5WWdvWWNUWlhOZmpZTGhHckth?=
 =?utf-8?B?RGRoZU9EdTVqVjBaeC85U3NXeUZjUXNhb2hldU54cGVVR1lwUFpWVWpYOHoz?=
 =?utf-8?B?a1RKYTFoYnJOblNXZmUxQWlCcFFaSTg5aE4vUWpMRXR4blhTWTA5UC9ZUXZo?=
 =?utf-8?B?N3l1RDRhczRSbi8rcGRYMEd3K1cyc3lxVlZPdWRrODJjdVFUL1lzZVczSWR0?=
 =?utf-8?B?MWVvbXlvd3dGa3E1aDh5cEh6NWdWRnQzQUZIdDNqeEJWTHo4K0MvTmlnMjl2?=
 =?utf-8?B?b3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c3d880-2316-4b7f-9854-08de0fce036a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 11:44:22.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjroD7Hk45pgeyTEMMV51TxLzq5lNo6GSY6TOkVDsPbAe3ATmLXsJ2ibxitozR1D97+HoP5JzZrOzmE3UrU357kszJbHnJX+ZodZF0D1+wGPAqKIKTLwvfUz3BMmtaCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7655
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgY29udGFpbnMgdGhlIGZpcm13YXJlcyBvZiBjb3JlOTggZm9yIGFsbCBzdXBw
b3J0ZWQgZGV2aWNlcy4NCg0KUGxlYXNlIHB1bGwgb3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJl
IGFueSBpc3N1ZXMuDQoNClRoYW5rcywNCk1pcmkNCi0tLQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5n
ZXMgc2luY2UgY29tbWl0IDhiNGRlNDJlMzQzMmQxY2RlYTRkZjgyYjI5NzE0ODZlMTQzMjU4Zjk6
DQoNCiAgTWVyZ2UgYnJhbmNoICdhbWQtc3RhZ2luZycgaW50byAnbWFpbicgKDIwMjUtMTAtMTgg
MTk6NTA6NTggKzAwMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0
Og0KDQogIGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXds
d2lmaS9saW51eC1maXJtd2FyZS5naXQgdGFncy9pd2x3aWZpLWZ3LTIwMjUtMTAtMjANCg0KZm9y
IHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGQ3ZWZhYzIxOGRkNWRjZTRkNzRiMmY3MmM3ODYx
ODQ2MWVkNzY4M2Y6DQoNCiAgaXdsd2lmaTogYWRkIEJ6L0ZtIGFuZCBnbCBGVyBmb3IgY29yZTk4
LTE2MSByZWxlYXNlICgyMDI1LTEwLTIwIDE0OjM2OjE3ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpSZWxl
YXNlIGNvcmU5OA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpNaXJpIEtvcmVuYmxpdCAoNCk6DQogICAgICBpd2x3aWZp
OiB1cGRhdGUgY2MvUXUvUXVaIGZpcm13YXJlcyBmb3IgY29yZTk4LTE2MSByZWxlYXNlDQogICAg
ICBpd2x3aWZpOiB1cGRhdGUgdHkvU28vTWEgZmlybXdhcmVzIGZvciBjb3JlOTgtMTYxIHJlbGVh
c2UNCiAgICAgIGl3bHdpZmk6IHVwZGF0ZSBCei9IciBhbmQgQnovR2YgZmlybXdhcmVzIGZvciBj
b3JlOTgtMTYxIHJlbGVhc2UNCiAgICAgIGl3bHdpZmk6IGFkZCBCei9GbSBhbmQgZ2wgRlcgZm9y
IGNvcmU5OC0xNjEgcmVsZWFzZQ0KDQogV0hFTkNFICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA0MCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogaW50ZWwvaXds
d2lmaS9pd2x3aWZpLVF1LWIwLWhyLWIwLTc3LnVjb2RlICB8IEJpbiAxNDA2NTcyIC0+IDE0MDY1
NzIgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktUXUtYjAtamYtYjAtNzcudWNvZGUgIHwg
QmluIDEzMjMyOTIgLT4gMTMyMzI5MiBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1RdS1j
MC1oci1iMC03Ny51Y29kZSAgfCBCaW4gMTQwNjU4OCAtPiAxNDA2NTg4IGJ5dGVzDQogaW50ZWwv
aXdsd2lmaS9pd2x3aWZpLVF1LWMwLWpmLWIwLTc3LnVjb2RlICB8IEJpbiAxMzIzMzA4IC0+IDEz
MjMzMDggYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktUXVaLWEwLWhyLWIwLTc3LnVjb2Rl
IHwgQmluIDE0MDY3MTYgLT4gMTQwNjcxNiBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1R
dVotYTAtamYtYjAtNzcudWNvZGUgfCBCaW4gMTMyMzM3NiAtPiAxMzIzMzc2IGJ5dGVzDQogaW50
ZWwvaXdsd2lmaS9pd2x3aWZpLWJ6LWIwLWZtLWMwLTEwMS51Y29kZSB8IEJpbiAwIC0+IDIyMjU2
MTIgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktYnotYjAtZ2YtYTAtMTAwLnVjb2RlIHwg
QmluIDE4MzcwMjQgLT4gMTgzNjcxMiBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1iei1i
MC1oci1iMC0xMDAudWNvZGUgfCBCaW4gMTU4NDY4NCAtPiAxNTg0NjIwIGJ5dGVzDQogaW50ZWwv
aXdsd2lmaS9pd2x3aWZpLWNjLWEwLTc3LnVjb2RlICAgICAgICB8IEJpbiAxMzY4MDk2IC0+IDEz
NjgwOTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktZ2wtYzAtZm0tYzAtMTAxLnVjb2Rl
IHwgQmluIDAgLT4gMjIwOTkyNCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1tYS1iMC1n
Zi1hMC04OS51Y29kZSAgfCBCaW4gMTc1MjA3MiAtPiAxNzUyMDcyIGJ5dGVzDQogaW50ZWwvaXds
d2lmaS9pd2x3aWZpLW1hLWIwLWdmLWEwLnBudm0gICAgICB8IEJpbiA1NTEyOCAtPiA1NTEyOCBi
eXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1tYS1iMC1nZjQtYTAtODkudWNvZGUgfCBCaW4g
MTYwMDAyNCAtPiAxNjA0MTIwIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLW1hLWIwLWdm
NC1hMC5wbnZtICAgICB8IEJpbiAyNzgzNiAtPiAyNzgzNiBieXRlcw0KIGludGVsL2l3bHdpZmkv
aXdsd2lmaS1tYS1iMC1oci1iMC04OS51Y29kZSAgfCBCaW4gMTUzOTc4OCAtPiAxNTM5Nzg4IGJ5
dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLXNvLWEwLWdmLWEwLTg5LnVjb2RlICB8IEJpbiAx
NzM2MTA4IC0+IDE3MzYxMDggYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc28tYTAtZ2Yt
YTAucG52bSAgICAgIHwgQmluIDU1MjA4IC0+IDU1MjA4IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9p
d2x3aWZpLXNvLWEwLWdmNC1hMC04OS51Y29kZSB8IEJpbiAxNTkwNjg4IC0+IDE1OTA2ODggYnl0
ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc28tYTAtZ2Y0LWEwLnBudm0gICAgIHwgQmluIDI3
ODc2IC0+IDI3ODc2IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLXNvLWEwLWhyLWIwLTg5
LnVjb2RlICB8IEJpbiAxNTIyODYwIC0+IDE1MjY5NTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3
bHdpZmktdHktYTAtZ2YtYTAtODkudWNvZGUgIHwgQmluIDE2Nzc5NzYgLT4gMTY3ODE3NiBieXRl
cw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS10eS1hMC1nZi1hMC5wbnZtICAgICAgfCBCaW4gNTUw
NTIgLT4gNTUwNTIgYnl0ZXMNCiAyNCBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAx
NiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW50ZWwvaXdsd2lmaS9pd2x3aWZp
LWJ6LWIwLWZtLWMwLTEwMS51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZp
L2l3bHdpZmktZ2wtYzAtZm0tYzAtMTAxLnVjb2RlDQo=

