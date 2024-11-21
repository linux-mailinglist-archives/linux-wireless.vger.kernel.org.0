Return-Path: <linux-wireless+bounces-15578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A959D5503
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5181F22C3F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCA1B86CF;
	Thu, 21 Nov 2024 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1UpoDV7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8783CDA
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225785; cv=fail; b=Ghmr+D6YoIvVbCKskSIo7zXtMVCDry9mRxIFkYuXvF/77xkTuM/Fxq305QVX0UCdMqMJs1mtiqz6yGmJANWSWi+WwoQd1ZWD9Y+VIOAoOScizCxjIJo4nOkH0dglhx7ty7LPY5rxeL2lPaRpPrZSmz/pZVhHwqtynCPWqJEni3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225785; c=relaxed/simple;
	bh=1JCgfusDORcquH96JKjRb/tm2wXqybH6mhxcPuLT4/I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUrsmPqDcFvBHix5RiaxEFvESm5U+JejqOoAgNXVyQ4bBMyS7fUlUiZBaqN4UfH1ZoDBZJTGVuyKcjP6X0/w+waq8NTe4dfQwym2kp5sHqD/GiVlFZQyiDzaDh/B/Br44+d/iOQQ3gQTLp6m9GeCKQQtLNvWCXFumItu2I2wMOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1UpoDV7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732225784; x=1763761784;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1JCgfusDORcquH96JKjRb/tm2wXqybH6mhxcPuLT4/I=;
  b=G1UpoDV7ytBrI0UOfZs2Zw9F6Z89+N97E4+OH8NGH/DqRSTyPEa6Gwe/
   ShynjyVCRIyjHeXuI7lcbruHAVdgU/FeJrCftR3KwLH64ToK7vfowZuES
   071/Ic4gdA1i+lt97614f93cFInXpaCQbxh0VVaNPzBc/K54N567vSQk6
   Euz/RL9McwcfVFBy+4mIst2HLBc3kteP704nHrZLt/ySNL+x9Ag+AuRtq
   JmfyyEyTWyzgpWkZPeDQkxGw/qs62yTXkUDeNXp0NgEaabW9U/9TVwFa+
   0WjVcA0kdKZZ3uHCqjiO8JhZmTDQJ0mkvWgrbgwz3HRlEK39DHPulMnHk
   w==;
X-CSE-ConnectionGUID: FMqh/+9WSrOxhY2U2atIVA==
X-CSE-MsgGUID: Hn5WvDiUTTuD25URAgkInA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32509224"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32509224"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:49:43 -0800
X-CSE-ConnectionGUID: VszZP+NdQWCLdC/n1kKRuw==
X-CSE-MsgGUID: bjsI+q37Qj2pq4n0lAfOJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90754313"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 13:49:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 13:49:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 13:49:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 13:49:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjivJDt1XIr8l9yXBmMEkTbQmRio3ibA7yTrOx6Pg9CsaaS3sZinXFRG1Z4Eif7bEopQaZL0FyznniG7sPQ2gVbxV6TpAsqRSA3JO+n2w1YCa3BD6Vs38X1T3tRBYWRIdgkq5W92y3ilZwS3GcpdTE9JWW4G4PDcSolfRnGnZB1vMbz2wV4YWPbrD7MTR9B6pNbDQNl9/TP98wCL9UD4XWhj+qOQGkQWZLRF1l/C37mZJbv50w14+Hu9cMtbvbSaHyk3l02g9nG/ZWPaYaDnSOtdQ5qg+ePlYJYVE3nu+xTuv2adwRuCa+4coSxVmiPS0l+ZRgsP/eo7fYdm/wuqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JCgfusDORcquH96JKjRb/tm2wXqybH6mhxcPuLT4/I=;
 b=Wis2iyutr7QgSJtfekDhnicBTDbttzsfjoaUrgEst2o3QxN6OK2RECPIGxxzmovigwI1/zc3lqkR3tUB9TvAfHcC8S7U5+u3MWiNQvZXZ2Z/NiZvwzUrrlP/m3PEiVH+jPymIeMOuG+yCyj+T41rB9ysmg6PX5jdksZlD83uaPgQd7tCY99VYseAq4f61Oenye2krYOiloFjb2i870zm4QO3oUtucdU0l0EniPZOPf/U0ZQx3NeSEee0NXHqQgf9rVTobwfP/Qop2YRpczTjwYbACQ/dCpqDYhMCuKWFDQTt2NKyke0F5N3c+c/+YUZhlPzmjK28FydmTLUmVn8XMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 21:49:35 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 21:49:35 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Bjoern A. Zeeb" <bz@FreeBSD.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/3] wifi: iwlwifi: remove function declaration without
 function
Thread-Topic: [PATCH 2/3] wifi: iwlwifi: remove function declaration without
 function
Thread-Index: AQHagiouwn4fBPDBqkicUhXr4pEba7LDugtw
Date: Thu, 21 Nov 2024 21:49:35 +0000
Message-ID: <MW5PR11MB58108A93B2D1065A48963F4DA3222@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <r4q0o9rs-0q52-5125-nro9-p37n72qnn86s@SerrOFQ.bet>
In-Reply-To: <r4q0o9rs-0q52-5125-nro9-p37n72qnn86s@SerrOFQ.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|MN0PR11MB6304:EE_
x-ms-office365-filtering-correlation-id: 37ef4cf3-037e-4899-9399-08dd0a7663d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGJDVDFYc2JTY3VBY05FY3c0L2hLNHp1MnB2U01SSmYxbUFyVCtNclVoeFE5?=
 =?utf-8?B?czEzTlhOZzczRlV4REd5dFB0YS8vUVd3bnluQnZIeDJpYzh2SDZSSks5aTVz?=
 =?utf-8?B?SGloa2ZLOG93SUQxYU8xN1pWOWVHV1ZLbDh3R3BGbWR2bUxQOWVzeWF5cko3?=
 =?utf-8?B?c0JEVEZOZk1HM2JRcldWMkEyUjlpeXFMQm5xM3dnU1Q0RHU5ekpSZGJUME0w?=
 =?utf-8?B?RFgzd3VSZ0JGSUIwcnR2dFlTV3pLNzVzZWplN3NDaGNDbERENUpDRUVsYTBm?=
 =?utf-8?B?UDFDYzVGTDR0OGd6QzJiaDdRa1dKdzRVU1VwaHlvMGJUYnBrTmtpdlpZenhH?=
 =?utf-8?B?em5wallSVW5qN0Fpb1c4ejBhQzlWN1R6bFRxb0luMFlsQkNONk84R0ZxbFJs?=
 =?utf-8?B?MFF1MVNHV1FNUDZUODdIbDdMd3BESFl4UW5XdENsSThMMUlaTEFmcTJDcjBP?=
 =?utf-8?B?SGU1dDlVVkJKc01hakRuMnQ0QmNLNXZ2MTV4dmZRdWRoc3RKeDYxL1ZxbC85?=
 =?utf-8?B?aUNPREJGVEJLckVmenAxQ2xMVVh2Rnk1WmdPZjNWdlpBQkRjRlpXVjRlNXRm?=
 =?utf-8?B?ZThkRmliVnNCYlpxbmZuYlkzaXVrTEJETWo2eFduVGxCK2tqelhpM1BJT1pP?=
 =?utf-8?B?V0FMUlhFZUhucmErMGpiWG1YYit1RlpGZkUxN09GR0JPa2hkSnY4NXByOGls?=
 =?utf-8?B?TUxQQ3YzU0dFclJNQkFEZ2VLWlAzV3VlL0JMNHFPb3hBTTQrRjRqUGlqTHRz?=
 =?utf-8?B?VFhxd3p1aG9Ud01kNWhsa2Q0bTJkeWlWcFpVTmY5MUZyRkNEOG53cFQ1MWpP?=
 =?utf-8?B?NUpMV3Z4Z293K013UmhMZDA4dGVEWE5Zek83aUo3VzVQM3o2TFNKNGk3S1JE?=
 =?utf-8?B?L3J6UGJSVkJqdkR2ZW5qN0pEMEpHdkNJQzNqTmtrcUFWUGt4YXkxVGtSNFc5?=
 =?utf-8?B?NGUxZmVZWjZDZ01kVUk0ZVJHNk5UTEQ3MGRISExDNjd3VTA4elhIek8rUmdx?=
 =?utf-8?B?QWtaajJ6d294UGNDcGNWS2FDWG4zVFJMblU5N1gxVnd5MTV3UXB5dWVVaHBE?=
 =?utf-8?B?Ly9odGJxWHlaVU52cGc3MHZ2cVYxUUpoeEtIR25Oci82aHB3Wmc4cUVCdXVB?=
 =?utf-8?B?dXpvTzg1dWdTeFE1ZDF1eDJNM3E1Yk9rVmFzWjdaSnBrRER3anZobmYvTXdH?=
 =?utf-8?B?ZS92QzY3ekdnOHhBb2F6OFRjY2FCanpYYWkzMGR0L1ErRmRlWGpYVDFsUTlF?=
 =?utf-8?B?MkZhdFQyVDBybVBFYVVBRC9pS2xyVVN1NXdwOGc5UmhqbjNTMGRhYU8yZlRi?=
 =?utf-8?B?c1JHK0QzaDVVWDJYcytFQys2Z0F4QkdmREtHSlVPS3dlZ2paeDNSckUwbjV0?=
 =?utf-8?B?K1gvU2Q4SXJKMG11MmNXTVZDWURSRTdHS3p2bG0vWXA2eWV6VGNRMXNXZTNw?=
 =?utf-8?B?LytQRVRwZ2RaOU1VdUxZRUpmcnIwRGxiZWxocjYvTFUwZlFVN3lTRWFGRmQ1?=
 =?utf-8?B?MzlSNW16cFBHS0tqcGlxak11QU52bU9lS1NCWHBaNjQzRWNTTi9YK2tsMmRF?=
 =?utf-8?B?RzloZGxUbHZSeDIrZzZkazdWSHhnUGZaL0lOT0dzRm1GSDAyczI5RlREQ1Fa?=
 =?utf-8?B?NDJEdU12endPbmhhSGo1dkVrR2hERTJyQzgvOTVFNHZyZiszN01hWWNXbHdF?=
 =?utf-8?B?bUc3T2pJMWczRXR1Q2cwcnoxWUtGSTJ5L3pvUFhvSFdpM1NianMzNkNNdE5l?=
 =?utf-8?B?eVdVK0dYNmIxR2l0cW9SbXJmajU3TlNOeEcrY3FOK3hFREwwTHpxWnVscmxy?=
 =?utf-8?Q?PJbtQJnUYBPe7qEfQKF3XjpajN8kDSNVwjtWA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFFzcU1ETXlSY3dZbjBhd0h4Mk9yem8vNE1lWFM3U2NtRC9zQU5HR0UxOVkw?=
 =?utf-8?B?Z2wxeTkvcVh4R0p1MG4wenBjQUE0akVXN09UeDU3bUdCbXNnMDgxTTZJUWJs?=
 =?utf-8?B?bmVNODBzSnNIN0FzY25IS29wZjNtQWRtaTltQ05MOUUyM2ZOMGF1UTlUVmc4?=
 =?utf-8?B?eXlBNE1XbWhrNDR2bFlyYXl5cWQ2RFp6S2s0RytrQWxpNkVGbGJveGRTYXhj?=
 =?utf-8?B?YnVjYk1rRGlRR0o1NUY0dFlNVWRVMTlJSjE1R1Yzck5JSkg4UVhydkZCUTRB?=
 =?utf-8?B?UUVtb0F5dDJtQkRKSE1LUlRWYWxYbklkU3N4YmpkTnhoM2pDWFZnUjltaTNh?=
 =?utf-8?B?K095U3JOdm42bktialBsa1JnTHNLT2o1OHViOHVtNmw1c3FlUlJPVTVjc1Bs?=
 =?utf-8?B?OC9icWMyK3BKcERXZjRJOCtualN5MEhXOFFJVU81TTBpS3ovZ1c5VnorSTN1?=
 =?utf-8?B?NzlrazhYS0VjMDhGQkk5R1p6L0xwM0EzbUQxNkg0c3UxRGFCdkZyQmNlNmFh?=
 =?utf-8?B?a3pPc1lDWU52a2llQWM5ZkJvS0VnTUxUZ3F1dmZBdVlQalZ6cnl6aUNvdTJT?=
 =?utf-8?B?SVY4VUo3M0cyNURROXA4dnJ0cVRBTm9wZkZQN0JTYmkyMTJVRU9ORHJKODBI?=
 =?utf-8?B?a1JOZXZBYys2RmpZRFR2VGRtRHBkWlFDVWUrQlpsRXpMZVk1N0E4MUJvRk1s?=
 =?utf-8?B?YlhWVGNoUlppWWxoZ2JGb1Zwb3cvWHNJbWI2UWhPaDJvVlBlVFF6RVFwUVhY?=
 =?utf-8?B?WmZwZEdkRUNmTi96VEE0NW9JZjNhOXNZMjN0NFJqVGFnR3Jtd2xuWjZNNmRQ?=
 =?utf-8?B?L2RQeUg3RXJDbUgrQVRVbzNvRG54ZXk0SlNBczQyY0F4eXQ3WWZ4dkdSMlEw?=
 =?utf-8?B?Q2lTakxmNmtsN1JQZytXVlNJK0M5dVZDV0I2SHlySHhjTjF5MGQzQWhGaGw0?=
 =?utf-8?B?WVhpYXlKVCt5ekhrYkhHNzNxUTVIWGRja0xNZjdnUjRXcXRWTStkdUlGZUlY?=
 =?utf-8?B?Qmk2blZaMnNTcWY5YUFWemZVMU5sZ2RtNVQzZlZJc2F5MXBQdUtjalBoaXZ5?=
 =?utf-8?B?RXVMbk80bWNmVWVYOEZqcGJzcWRLQlptZ1FzK0UwK1kwUFd5d0o5THVZRFp1?=
 =?utf-8?B?aFNYTHcwallKOHRvcU44ZE13eE1GbWY1alYxRmM3TCszSHBoNWhQb3Z3Tk1o?=
 =?utf-8?B?dUorY3NaQWNEemJER3Q4cW5MSXFxL2VkVHpyRGJuTi9obklzb3BMakwyZFBz?=
 =?utf-8?B?RGV0dVhSNmpHSlUxTXhkUGtnUHNpYXljeEJhRWMyL3AyZlpDU2ZTM0d0dHRQ?=
 =?utf-8?B?aU92ZElTbUhMazdDajY3ZWpDa1hSdFVRZ2tDQW9aZmlnblZraXFsdDY2ZXVz?=
 =?utf-8?B?cnJyT3d1eXR6RnVha0ZseHhwcnpvazQrQUhrcW9EempWMkEvTElmbzBSTXYw?=
 =?utf-8?B?WmNudDVJcTFyMm5vU256L014b2kzTXFxbTNpMDRlVW9WdEFmSmFTdGk2S2Nj?=
 =?utf-8?B?L0FGeXVkUWZrajVCZmJSRVM3U2F5WGZKR0NGY21HNHZDNHZnTG0rcEtJM3RD?=
 =?utf-8?B?Z2h4OUFJZ1ZjWWZuMjhlc1NnbFN2V3RLMEp3REZlYnZuVk9SYXRSQTdlU2tV?=
 =?utf-8?B?cG1CN01rdkJ3LytISUtpTTNTeUovQUVrNDA3ZG5YaEF5MUlRNlVXTFNSNjFS?=
 =?utf-8?B?anYveUlNOVBNdFBCd29TTVFOUVc3WFBCRzRFN2JOMk9vd3pyUDRROCs1Q0ZI?=
 =?utf-8?B?RS9Vc1BSeXpxQUNScGdBbkU0YVNTRWd1VmxwSUJSUndhZlJlS3hNR0FhTDFo?=
 =?utf-8?B?RXova09MaVRRdVd5WFJzUHRCbDVPak4vdWZZT3JiTEd4Y2VwT3hRUWpSWE13?=
 =?utf-8?B?ZWRHTSs1SkpTa0FUc0RYSE56QkR0MmcwZWlDNEVZNHpxZDZlRHVZZHlycUo0?=
 =?utf-8?B?YUhjdHNzcHZyeDNjQkFPNFhaN1dpYmtQVnFsbVNwM1orQnVyMnhuaDhsMk9V?=
 =?utf-8?B?QWpreUZDemlJZVkrelg0NC9rQ0t1UEllU0JMblR3aXVNV1FvMERHR3VJYkRR?=
 =?utf-8?B?SmVITDZZTERYaTRvT3d4UnEzWFhBYzJyd3pMRE1KbVd4cmJJQURmL0RJUDA0?=
 =?utf-8?B?dzFia01ka2NQVWVxd0RFb080ckQ1STJhTzZtRTFZQWpnb0xHWlNNVmlKM1B4?=
 =?utf-8?B?QVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ef4cf3-037e-4899-9399-08dd0a7663d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 21:49:35.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqRwHX2uutRqvTkkeEOT2r58fG7I2QM5F5T/dYaOTA8xQvQqjiNGC2Cm+2VyzYzwG0NMMdPU/suW4Oziw2HVu5KqDH19BRkBiDawcsiPwSf//VaZg4zjcDeizuWpfZPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvZXJuIEEuIFplZWIg
PGJ6QEZyZWVCU0Qub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgMzAgTWFyY2ggMjAyNCAxOjQxDQo+
IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEtvcmVuYmxpdCwgTWly
aWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggMi8zXSB3aWZpOiBpd2x3aWZpOiByZW1vdmUgZnVuY3Rpb24gZGVjbGFyYXRpb24g
d2l0aG91dA0KPiBmdW5jdGlvbg0KPiANCj4gaXdsX3RyYW5zX3BjaWVfc2VuZF9oY21kKCkgaXMg
bGVmdCB3aXRob3V0IGFuIGltcGxlbWVudGF0aW9uLg0KPiBHYXJiYWdlIGNvbGxlY3QuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OglCam9lcm4gQS4gWmVlYiA8YnpARnJlZUJTRC5vcmc+DQo+IFNwb25z
b3JlZCBieToJVGhlIEZyZWVCU0QgRm91bmRhdGlvbg0KPiAtLS0NCj4gICBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvaW50ZXJuYWwuaCB8IDEgLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9pbnRlcm5hbC5oDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvcGNpZS9pbnRlcm5hbC5oDQo+IGluZGV4IDc4MDVhNDI5NDhhZi4uMjI3
NDlhMGRlNzhhIDEwMDY0NA0KPiAtLS0gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9wY2llL2ludGVybmFsLmgNCj4gKysrIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvcGNpZS9pbnRlcm5hbC5oDQo+IEBAIC01NTIsNyArNTUyLDYgQEAgdm9pZCBpd2xfdHJhbnNf
cGNpZV90eHFfc2V0X3NoYXJlZF9tb2RlKHN0cnVjdA0KPiBpd2xfdHJhbnMgKnRyYW5zLCB1MzIg
dHhxX2lkLA0KPiAgIGludCBpd2xfdHJhbnNfcGNpZV90eChzdHJ1Y3QgaXdsX3RyYW5zICp0cmFu
cywgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gICAJCSAgICAgIHN0cnVjdCBpd2xfZGV2aWNlX3R4
X2NtZCAqZGV2X2NtZCwgaW50IHR4cV9pZCk7DQo+ICAgdm9pZCBpd2xfcGNpZV90eHFfY2hlY2tf
d3JwdHJzKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zKTsgLWludA0KPiBpd2xfdHJhbnNfcGNpZV9z
ZW5kX2hjbWQoc3RydWN0IGl3bF90cmFucyAqdHJhbnMsIHN0cnVjdCBpd2xfaG9zdF9jbWQNCj4g
KmNtZCk7DQo+ICAgdm9pZCBpd2xfcGNpZV9oY21kX2NvbXBsZXRlKHN0cnVjdCBpd2xfdHJhbnMg
KnRyYW5zLA0KPiAgIAkJCSAgICBzdHJ1Y3QgaXdsX3J4X2NtZF9idWZmZXIgKnJ4Yik7DQo+ICAg
dm9pZCBpd2xfdHJhbnNfcGNpZV90eF9yZXNldChzdHJ1Y3QgaXdsX3RyYW5zICp0cmFucyk7DQo+
IC0tDQo+IDIuNDAuMA0KDQpUaGlzIG9uZSB3YXMgZml4ZWQgYWxyZWFkeS4NClRoYW5rcywNCk1p
cmkNCg==

