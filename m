Return-Path: <linux-wireless+bounces-22173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0CDAA0163
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FEF1A88078
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9735972;
	Tue, 29 Apr 2025 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZAiqfB9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3F4409;
	Tue, 29 Apr 2025 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901391; cv=fail; b=bzc+hy7sB6NxfFEmvQj9rHspDUaTn6Zotm0TJloFSZ2Z6PWq7jxkkwz6dBY556m5P0V5ItaAaTnJ4t+pfIH3PaNuACj/ULxgVtHap6qXUh7jq1bP9/fr7KRx1cYIb1TdETZTCk9h49Eet2yjKMw9pXLMYpZCrO8Pjj+8JsAmOpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901391; c=relaxed/simple;
	bh=CiEvsHMAAFWQ//VzV/S4gJP/sqWW7BhRfBV8LUJJkTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d4bsLsjS5Gz4aENkE4W3f6QjLb+ZAX2MmmtUpX/gpaT1neFH3zdwUQtfg7R6VyUPAbnKllvhTZOvXGn6ahrsIfdCWi6XWnDNmyjPSvf1bJetl3jBNHGm80gLPci8AiJ85MELZaRQRNaE6bbu4LEwi9npvVEoUVjJiGLteL3ZPp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZAiqfB9; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745901389; x=1777437389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CiEvsHMAAFWQ//VzV/S4gJP/sqWW7BhRfBV8LUJJkTI=;
  b=ZZAiqfB9/QTjfwuT0PvxJQvRacjM89IjGG4hqNoX8l41Rrf8HcITK6BT
   pAW7uu0h46qX6Ih4uV8VUDM/tEVjIixQd0EXLpJmYYpn7VWi/a/vhLJy1
   yF8ej7hnJZr6VoqK+FdFp2AZfcxTMxzfiys1LfUqJ+iRrJnn7gFCP9nAz
   DoZaKwz/zJ4z6mYd9GF/Xmjfa9W3wbCh4R0A3l7Ru42ZrrZu0OFEDNy/Q
   hvq07ZN2G8wypfb/CSUmYtYb1C5gUgr0Xi/ls4SY96BUM6J1b/aBut27t
   YdZZTyaKJ3n0fkIEK4Ni8Iz3Hmdi6oHykWY2hEkV8JtjkHZr2HwdZddRP
   A==;
X-CSE-ConnectionGUID: dpk6MQ0lTWKOUPCJBzT96Q==
X-CSE-MsgGUID: pRIkw+wESxigNH2w0DXI3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47522354"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="47522354"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 21:36:29 -0700
X-CSE-ConnectionGUID: nSw7d3xFR32O8/Ou5b6b2g==
X-CSE-MsgGUID: n1a6B0iISr2y0x/ITefiDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="133613780"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 21:36:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 21:36:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 21:36:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 21:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksV4NfleIYDdP2iGW1yAEK+Le3Rqpu23TmucO9JwhA31KDlZGy3aEQv5fSdB72pazHI3F4QJaWTApxtjkBsYucYAWulPHoV3r8PbYFJCaSQ8XOIwa8QI+IWU9Kmj1Muw5khCqYndN9GWzkBokSaei1dXb09SNNNg5LdenH/dN3bJ5AYcL2y8qOmJvxKIJS4/FGZ7XY/pWnpDvCVL5jDn0uMu2kYLskqfS3BI+D0q9gAhf+VYg+jLwjiHr8ZcZYa0fjL6lpk4gsvTj+rMUcRlep1KX5hsXMbSgBDfQa/xi4F4BJzrXJzLavIKaqVM/qOLepkcUtVdDsoI1Wbcy6mzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiEvsHMAAFWQ//VzV/S4gJP/sqWW7BhRfBV8LUJJkTI=;
 b=q9Sgi34YvGozYYyRbdi8+G86yIQPYuGj/LthDa4od/Wkh7NR53Ka7/HCccj24n1Qmjue0JCkUMRxajBKFHpt7ghq+MkuA2f+9vex/HpqjBrMDWWERF+7SIKtMgj61lUG68gHlBwVsLz28jvvEZqhW8a9ydNInpP9d4ZFWJUuYSzRcLB7UrEXGiixLOIWqfnP9KEh+fm6bzPcR0paquKonRUgl4yeOrN+sJaoPfz07nov/5m/DQTltAn0LX7c5Qcwsui7pahm5UUCxgtEKJ6k5I/JRAC4inDtwMgTMlVuy/zEaGSbFyslyd3djocfV3xmBxksBwePFabMzbDsvaxeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 04:36:25 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 04:36:25 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: Add short description to enum
 iwl_power_scheme
Thread-Topic: [PATCH] wifi: iwlwifi: Add short description to enum
 iwl_power_scheme
Thread-Index: AQHbmN1OL30NiSPRDUi2QYi7oX7g6rO6TrHw
Date: Tue, 29 Apr 2025 04:36:25 +0000
Message-ID: <MW5PR11MB581072B873108C92E29699E4A3802@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250319-iwl_power_scheme-kdoc-v1-1-2033ae38b178@oss.qualcomm.com>
In-Reply-To: <20250319-iwl_power_scheme-kdoc-v1-1-2033ae38b178@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SJ0PR11MB5896:EE_
x-ms-office365-filtering-correlation-id: 7e69eb37-a932-4a5b-60ef-08dd86d7668e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVJ3c1lRcWEyUFdNWXU2NTJDTTB0akZIMFU1NHdpMVlSdzFSMURUTUl6alpU?=
 =?utf-8?B?M0Y3aXlSdVBhRW5uM0xqYU5vSDJTRlFCTW1ldmVTbWNnc0ZnNUtESlJlcGVS?=
 =?utf-8?B?OS9jbEZPSzBFa2tTUVBZZFBRMVE1c3ZqSjZGOVRNN3g2bjNEV2tsN09ZV1NC?=
 =?utf-8?B?MDA2Vm13M2ZOWmJxUDN5cTVKa1RZNzcrZHN6WCt5aGkyQW5BKzl4a3N5UDVM?=
 =?utf-8?B?bWcxSkNobVZNUHExaW1UTG92N0xXTHR2ZUN3cU1BWU9tMnd5RU9jUHRoWnRT?=
 =?utf-8?B?UTZXbzFubGVWWjVZTzZUSWQ1MWFMTi9UeXlJQ2x1SVVLVkdlbU1TVkdZWDRq?=
 =?utf-8?B?elArbUdGa1l0TjFIaGZ0bHd4Q0ZLTnVtelVHZzcwNkt1bWM4M1YzWWxUaWFO?=
 =?utf-8?B?eHVGanpRNmU3L1l3eTVlUjQ1U0ZMWS9OWUZnaHhZazBFZmRYVmY5ekh4ZmRI?=
 =?utf-8?B?Nk5tZjlCNVRvZTFuaC9IVXY5dWVDTVA0VTJPMm5GYXR1dkV4d1ZPODBGMjhY?=
 =?utf-8?B?dXJ5aG1sNFArR3gzanFsRWV3MktJMmhweHUyaklreDFIQ1NOREU0bnlLUDlO?=
 =?utf-8?B?QUNmSFYwQTVleitPTkp2Q1BNcFJHRUhVeEpPQTlSUnRiN0RSWnJPcWdWNUUy?=
 =?utf-8?B?c084bzBESDY5OVdUR2o4aXhMQ3FySXUrV3JMMDJKL2V2c1NXYTZYY25YMlp1?=
 =?utf-8?B?TUtsL0dHSTkwRXVNNGFTaW9PUGNmMXdHWWhVNVFGaDYzVzFPaVdZWTNXcWw1?=
 =?utf-8?B?QUdJSzNaaDhUVjVWMnpVR0V3MUZzNXRsMkxaSVVjOFhkK050TVZzY1c3MlNV?=
 =?utf-8?B?Y095Si9JM1Mvd0lkRkdaOSsvd285a3NLbTB5UHNSM1Bjb0ZkQ2VOb3Q1REh3?=
 =?utf-8?B?Z1NsWngxc3NCTGk3QUFwY0lCVjI2RHNmaGVmN1hnRjdnWmRqbnJ5T2hIZnor?=
 =?utf-8?B?Z2N0TDBmVitFeTJPOThwMHlXWXhVTlBmQ3R5dFMwWU1sZ2ZFWDdkeXI0UVFz?=
 =?utf-8?B?TjgxNGc3WU84ajFNQTcwZTFINHEwbFBzRGNURkdad0twcFgzVlk4enoxb3Vh?=
 =?utf-8?B?Y0VVejJGcVZndG9reFVmNklOelIrQmZsMzRGSi8wTk16dUJNaVB1anVFSXpS?=
 =?utf-8?B?MTFnUTVLanZNbmp1V0dnMWFKUStLOEZDekZkcFQxMldsY3pITWZvWGhkU0FF?=
 =?utf-8?B?MU1zbVRaRTNVMlNlWkMyRHNmWHp3TzhLS0l4Wm56TitoOFdzeEFsaWV2NjYv?=
 =?utf-8?B?ejZmeUxQVFYrRnB0Smk5d1dsNzJkZkFqWUxEZExNNXhWczhCY2JucjZ4NTJR?=
 =?utf-8?B?NHBoWEtHazMxb0xXdlhSV0lueGY0WkhYZmRUWDhPL0hOWlY1dVB6bDVTS29z?=
 =?utf-8?B?b1EvbWVraFV5cXV2Z1NnRW5wejdZOVl6RURsSUZuOUVQM1d6aVRNWFArNjlM?=
 =?utf-8?B?K2E4TUpweWpJUU45bFozVndTS3ZzL04vdytWRkJwMjRpNVAwRUpIQ2Fla1BP?=
 =?utf-8?B?Tkg4Z3pqRFkycmpNTWZmRzVlcTJKNW5ScXBFdHRUM3hpTTg3bU9VMmN2UjF5?=
 =?utf-8?B?cHhBVjVzRC9kRTRha2JvN2tHZko4QzlVQmF1dm0rT3NDWnE1S242ZVpZL2Rs?=
 =?utf-8?B?NkFLWVd1Zk5HYUFNbmhOdzlnWkxjOEpraXpKSGtSY0JLRmgxMDRBclNNZzZi?=
 =?utf-8?B?elZMb3A5ck1tWmtsaURyM2MrOFNSVXBRelc5cDNLRDF1Y2s4V2NRZU5taUlB?=
 =?utf-8?B?dVJIRDJMZFhudG93aG96REpMZFNMRmtUbW5wTk5scm1PeVdkalVmWkFmWkcy?=
 =?utf-8?B?eHF0Tml4V0I4ZlZocVJPam16WTFGOHRsbkFpQldLOCtoa3E4WERrOWVkeCtC?=
 =?utf-8?B?VUhNMnhHS1lWSEJsQkZFTXFRTUFMZnFkNmNhaXd1NnluKzMvY3BhWVB6NUJt?=
 =?utf-8?B?dXRmLzlkWldQbzFhaWZUU1BNQm8wRVl5NWppRjhoemlkeFErTkhDUWlyU1FY?=
 =?utf-8?B?cVlheEZNNEt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVdHRUxJRUhlRk1IT1NSVkwvQ0ZVZXpFdUliZmxIWkNSRTJ4QW5YU1R4b2x0?=
 =?utf-8?B?NFJCY3FqTEtaQXJEQVNXMmtvb0R1c1NWNWFZK01Gb1FSVTBwVnVYVnJ6MDRI?=
 =?utf-8?B?amxxaHFFV0x0V1E3MlhTVUtaaE9Jcm1NTG9TM0V0SGFPU09zUjA3MitRZHIy?=
 =?utf-8?B?R0VvRGxhbzYwZ1lLdzdKMlkvVUlZQ0FkcXpOUFpwTURNb1V0cjVLVW9XZk9n?=
 =?utf-8?B?NWtWTVp2L0RHelpPNUZjeHBnaUwzVzdwY2RMMWRjSGIvalhZcG9mNTJrRjlC?=
 =?utf-8?B?bWtublBOK2NteURtZlU1MEtPNmJCRUwrK0l0OFFjdzhIbUFVNVd1TkE2aXRF?=
 =?utf-8?B?M0NSemtIbHplU0VZK2pQd2ZaMWZMdlk5NXpSSnZRbmJsUXFVZjQwKy9IUjNL?=
 =?utf-8?B?a1lNOHRaL1B0bXB6NFE4N2h1RVdoQm0zdkRmeWRKVlgrSTUvZUJIOVhpTDBM?=
 =?utf-8?B?VklSV1VGd1R5aTh0TElxaUZGY2dXOE5aSnEzS3M0NXhzU0xiZkNwTmdxQnI2?=
 =?utf-8?B?bDV5VkQ1clRBYmdQUDdld2xoMkZZZDB1NmtYbzFNOTFweEdhTzJ1ajNsRmdQ?=
 =?utf-8?B?NnBiclpLSmloN0QzM2NudGlWSkpPMGlQbkpydjNmL3lrMm9uWVJvczY4c0pJ?=
 =?utf-8?B?Y3ZrUmJCT3laYkcvakdnQzhrcXp2YlRUZmlLT3R4ZnVZbGNYcTRBMzdENy9Z?=
 =?utf-8?B?WTJISHBTSnRIRlBINEJ2dkdDVUNnODlsemxwOHAvK09ieWNCbTZyY3hzMDk2?=
 =?utf-8?B?WE5PQmVuMWRGaS90YzBsTTZPK1hTb1ppVkZQMXY2eFBDNmkyNU1DQWFKeE1r?=
 =?utf-8?B?THNuWk5ZRFhhVkVmUFVoMmlvZWlnUzJIZ253Wm91aDBFeUZwck5Lc2Ntdklp?=
 =?utf-8?B?djJOa3czSzM2eFg5Y01QMEFpdE1xSUxoUVZySFFsekNxMmRGUCt0TXlZdzhE?=
 =?utf-8?B?TjRyY3VoUyt5NkZ5MUhVYW0vSHE4QWNENHJmU1lPRUs0VDR4dDlycDNJZkZM?=
 =?utf-8?B?MnhCTVNjdnEzRmRhcGRhVGgrZmJwS0tGbzJlTHNsWWFMaGVEVXFjYU9LZkNv?=
 =?utf-8?B?cW5oT2c3bnZoaXVHRE9vRmxvOVpTSDlGZmltSTc3U1luYmVsQTF2WnJlME5Z?=
 =?utf-8?B?QW9JaE1BQlUwdzZDTE8rdmJpTjZFMVdkWlh5ckcxQ3BhSGk1aHJaQ1h2bjVi?=
 =?utf-8?B?ZTk5Z3lEOWJWR0tvemcrcWZuc1pNNTJtcE9KdnZLS2pnYXh4YVZnNzVMNUh1?=
 =?utf-8?B?NXEranZjOFNnVnh3N2FoM0RWREplT0w4SmVLVFJXZEtoZkpsemZRT3BpcnVZ?=
 =?utf-8?B?YXVCWENrT3hVMUdZNWxnU0s5QklPRVFlNXFqUVlqR29IMmhNTWhST3BvRW9s?=
 =?utf-8?B?UlVnSm5scWJnVUh4aVB5ZEkvTnQ0N2U3RDJ3YVZjRHRpa1BuUGZhQlhUMGZN?=
 =?utf-8?B?WmZDc09zQjA1aFhoOEFROG9wMUFUb2tzWjRibks0Qy9hU3BOT1Z1RXZjY0Y1?=
 =?utf-8?B?RmZTcWJzMHJ3ZnM5enpLMHBRUStuc2l6aVcvMFVPTWdFeWt2QVVmMnM1Rzhh?=
 =?utf-8?B?ZGpoZzJYR1pGcEltaUQza0lLeHJseU9DODVKR0NScDd6YkRlVXU5VndIS0FZ?=
 =?utf-8?B?bHpBdFZYTjRwZERMU0ppWi9qa2M1dkkzc2xxSVpPTURBSU55R2tGRDZjYUE2?=
 =?utf-8?B?RGdjTVQxZitXV2pVZkxNWlMwNCtJSDlPRTNPVmNzOVpHcExjMFh0Q1ozZmdy?=
 =?utf-8?B?eHJ3WHFod0Vtd0FXdVZ3WlJCeWNhcXdmMHpEY29LQXBGUGRDYTlMZ0d0Wm4z?=
 =?utf-8?B?TW91TmFURmdTc2o5NE9Ga2VFUUNqbEFHcFJnVjBPZGFkL2s1Nyt6L1FuVFVm?=
 =?utf-8?B?M3VldEsxbXRaQjRCR0RDK1pMQkg3dWpKd0NTSkJISDU5L01HenQ0M1RBWWdC?=
 =?utf-8?B?cXlVSXcyc3EvaFljNzdZNytETitQdC9uQW1tUXdOZXZkNW9XbEVUVllwRkNv?=
 =?utf-8?B?OWxKNEl1UUNWK3c1Q3kzTjdOUUlWd1RLdmxhSmg0UkxmTkptNVFiZWdlVWtx?=
 =?utf-8?B?NmpmN28xaVVsQi9RcDNVaUM5NC84OEM0L1ZsbllnUHg4M1FmdDJWd2VOY1BS?=
 =?utf-8?B?cWFLQVpTOVI4WFp5TnNFcUxBbll6TlJiVFZmdE9uT3RKMW03VmREL0ZMR2lY?=
 =?utf-8?B?YkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69eb37-a932-4a5b-60ef-08dd86d7668e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 04:36:25.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0JXpm1oC2uItA7B3jA2TZDQNd7DiJB1nnn9fmSAWpVBGq41QtzCnyhjBmNIwyAgZbKApTp/cbVMJ8z9JyE3CuIGeJTD+eNqTJNHC9LPRffjbTnulA2OTjW76Pdlz2G0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5896
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBKb2huc29uIDxq
ZWZmLmpvaG5zb25Ab3NzLnF1YWxjb21tLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxOSBNYXJj
aCAyMDI1IDE2OjM4DQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNo
ZWwua29yZW5ibGl0QGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmVmZiBKb2huc29uDQo+IDxqZWZm
LmpvaG5zb25Ab3NzLnF1YWxjb21tLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSB3aWZpOiBpd2x3
aWZpOiBBZGQgc2hvcnQgZGVzY3JpcHRpb24gdG8gZW51bSBpd2xfcG93ZXJfc2NoZW1lDQo+IA0K
PiBUaGUga2VybmVsLWRvYyBzY3JpcHQgZmxhZ2dlZCB0aGUgZm9sbG93aW5nOg0KPiANCj4gZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmg6MTMwOiB3YXJuaW5nOiBt
aXNzaW5nIGluaXRpYWwgc2hvcnQNCj4gZGVzY3JpcHRpb24gb24gbGluZToNCj4gICogZW51bSBp
d2xfcG93ZXJfc2NoZW1lDQo+IDEgd2FybmluZ3MgYXMgRXJyb3JzDQo+IA0KPiBBZGQgYSBzaG9y
dCBkZXNjcmlwdGlvbiB0byBhZGRyZXNzIHRoaXMgd2FybmluZy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEplZmYgSm9obnNvbiA8amVmZi5qb2huc29uQG9zcy5xdWFsY29tbS5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmggfCAyICstDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaA0K
PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oDQo+IGluZGV4
IGY2MzkxYzdhM2UyOS4uNTk0ODNmYmFhYWIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaA0KPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaA0KPiBAQCAtMTI2LDcgKzEyNiw3IEBAIHN0cnVj
dCBpd2xfbXZtX3RpbWVfZXZlbnRfZGF0YSB7DQo+ICAgLyogUG93ZXIgbWFuYWdlbWVudCAqLw0K
PiANCj4gIC8qKg0KPiAtICogZW51bSBpd2xfcG93ZXJfc2NoZW1lDQo+ICsgKiBlbnVtIGl3bF9w
b3dlcl9zY2hlbWUgLSBpd2wgcG93ZXIgc2NoZW1lcw0KPiAgICogQElXTF9QT1dFUl9TQ0hFTUVf
Q0FNOiBDb250aW51b3VzbHkgQWN0aXZlIE1vZGUNCj4gICAqIEBJV0xfUE9XRVJfU0NIRU1FX0JQ
UzogQmFsYW5jZWQgUG93ZXIgU2F2ZSAoZGVmYXVsdCkNCj4gICAqIEBJV0xfUE9XRVJfU0NIRU1F
X0xQOiBMb3cgUG93ZXINCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogM2ZkNTUyYjI2NThlYjZi
ZjJhM2I1MzE1NTNmZTU2MzM0MGQzN2ZkZg0KPiBjaGFuZ2UtaWQ6IDIwMjUwMzE5LWl3bF9wb3dl
cl9zY2hlbWUta2RvYy04OWNmODNiZDEyMWENCkFja2VkLWJ5OiBNaXJpIEtvcmVuYmxpdCA8bWly
aWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0K

