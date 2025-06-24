Return-Path: <linux-wireless+bounces-24400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372D7AE5C63
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C9D7A57B2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ADB241674;
	Tue, 24 Jun 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eistVd/X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3ED158218;
	Tue, 24 Jun 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745039; cv=fail; b=QGGKia8BK/aYVNwcSlwSEkOopqeQK//yjfrjWqYHkaIuLfPb3hkHWCfIGI2AozxDM7e4IQx/1nos+EA6iS5/8386TeBXiuaVYVe22LfH/GV4ktVqUlCC1HNP/1kM3h52MBHMga097e6Cechl4KhT+P536SxgTvnJVg9BcSCfhNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745039; c=relaxed/simple;
	bh=aY+0Rek/4ASKUgSGdVJUyIKXuSKoEQxX0qFPRPGhze8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rDmo15CfHj9MmqzbIZGz43a59WEqJAX6tWgyGV6XFpaJLsz079gZlerdBSA/nkoLvKu6s8kjQSlppDTrvsK0hxdGZ+LKLGjMjCazSurB/7a3s+zZ/sMqyWkfsbR8uTpSd40qXDvNO3lfs2RkPcZ1NmrkJrrAMneV9XxDAo0fEys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eistVd/X; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750745037; x=1782281037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aY+0Rek/4ASKUgSGdVJUyIKXuSKoEQxX0qFPRPGhze8=;
  b=eistVd/XZLhOJj1FR0hcV84teyMSHOf405OIA+oe/jwm1tN7myah/RC6
   MOzCDhpAWUuTSVgljiJPrDvEgR/Ph9MpfAxV0iiJGFACbIFfzawnRQoWb
   ZU9MOo4JYhXAcsDvXv9YLJ1I+/oQQyUjKijqWNo9aobV0UIguCt5E1O4p
   ew8h7kF1Jn0DltSJD07ygWPwFGCn3Kvb/HrwcthCz6Ckn6wpMO+XEiC1l
   89I4IfHwMb8vtfWrchWleyxU7oGIsns8wH+bKOATL1qitYJ41NRzNFoqB
   8hzU+M5CpY4CyEdyp0OU7/9mZQvPcb/G+laqxcIpzmosgC++KUZL5pFso
   A==;
X-CSE-ConnectionGUID: SEOmFhSPTP62WtavfFhhLw==
X-CSE-MsgGUID: wGdYcuWySIK1yY8XCdj3aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70393750"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="70393750"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 23:03:57 -0700
X-CSE-ConnectionGUID: eeKlQYtyT0SXPe+VHz8smA==
X-CSE-MsgGUID: bNxqnEuBSdGxfMv7iIpibQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152119392"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 23:03:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 23:03:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 23:03:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 23:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEsq8VN+JrHGAEjdhDh3KUZq1ELEAlOqjBk1Wa0jwlp1ZEGTdffl6pdTs3iIiCgv3cKixj5mlzc6M9tWaPkEz5Nxul1jOT5x67wWVdFTOgK70JaZd3KwwYY31eFUxyobruGIxL1IGZVK+prypBEkHnOsTIvyrGnTvGPgH3hDjFt7LqudfgUYmBSzq/XMoG7k6AdioA6RhKSyyGduviQ8HbE8QUO0bwDTTCdHIRln/HQ221fiLUIsjpTUV3WifbKGUKheiEXTPjnAJ3HSF24GXLT4c0ya+oKwhpBFJjeyYzT15PRPElEpmSI/03pTqhNuQC3IsQRAuHsscxlfVeHa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY+0Rek/4ASKUgSGdVJUyIKXuSKoEQxX0qFPRPGhze8=;
 b=VZ1zhpSLyXpXWNSmeIkqNzmqYGJR3HbuC8VXOTX1EcWTrcuVR4CIb5CvY/u4PW+NrbuG+vM7gtPdEU31ORWg5Cs6Y7xqVLGefQYQGKkNqZsaY1kJiXLfl6t7hAo9MXmZ9wrhixSzUj73hOXDVMDXss7NACXMUxNLl7M20/lU6M0ySV/Z0Qc5PRK1D9r7/jp6bphns/ybA0Jiwcd5YBSVcaw5BPzdkIBM+GEidLnV9vUztTcyeTHeOEwyYTkybiP7Y1vBA+jbAg9X/WdIu+38J9x9UwW4UQN6rQkJ52g4nHB/1cIPxgr5kjR4JvY5yyaRuo1geLnU75dNko9OC0IXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 24 Jun
 2025 06:03:35 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 06:03:35 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "hansg@kernel.org" <hansg@kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: 6.16-rc2+ lockdep circular locking between iwlwifi and
 thermal_zone code
Thread-Topic: 6.16-rc2+ lockdep circular locking between iwlwifi and
 thermal_zone code
Thread-Index: AQHb4fv5Pcxq4PTZM0uIWpwE/1MmULQQheCAgAFRlQA=
Date: Tue, 24 Jun 2025 06:03:34 +0000
Message-ID: <f134ddec8ed45ace06993ca26fdcca58c35250b9.camel@intel.com>
References: <e9d7ef79-6a24-4515-aa35-d1f2357da798@kernel.org>
	 <3a9f8d73ecd8fc1f6994b58d69014aa064d6cd60.camel@sipsolutions.net>
In-Reply-To: <3a9f8d73ecd8fc1f6994b58d69014aa064d6cd60.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: 231491bc-0620-4034-ed10-08ddb2e4dad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N0ZhUGdDWHBrdVR4RVpubEo1U0svUEF1WENUSXZZOU9PQTVHSWdHWVdjOWxY?=
 =?utf-8?B?WURObkt4UWQ3SUlwTmR2aGhhRDh3cFpJTWxuMW9oSjhZTWRUSTZnVHQraHN1?=
 =?utf-8?B?cnJWb0RZemhIYVhJRDNUVlVISnNyWkJvVzBXeEQ5ZEF4czhpTko2TmZsb0xB?=
 =?utf-8?B?a3RSR3ZXZW9TMUhqUW5CSDVvbFlXeVVGWk1sMCthcS9zR0hFcitLSWxMTElR?=
 =?utf-8?B?L0psdVp0VjdVNW0wNHo1NEZRSEpNejNrZDZvWURoWStIMWVGNVRPZlJpMlkz?=
 =?utf-8?B?bjhJdTZrSWd4Z2dnek93RVBIZnpEcm9KR3dwN3Zmbjk4aERGNE5ieFhjeHZk?=
 =?utf-8?B?Y0MzdlpFYm85bGt5b1VYVnVTa2tKMWF1ZjNhRUpvNzVsWmprbVRLTDJNdS9R?=
 =?utf-8?B?R1E0S2RVMVBHNy9WV2hOZHB5Lzk1MENYckxWOE5lN1dMMzY3M20yQ01ZVDF1?=
 =?utf-8?B?OG82ZUpBZTVQWk1CY3RqNGhaMEV5NEFuelZGa2JPY3c1MkJEZEZTRTdmNTdn?=
 =?utf-8?B?bEh3MVN6NFJGWTJ4T2FQd2hhYU83U012ZXM5Ly93RjdzcVlGUVhuaUhtd1JW?=
 =?utf-8?B?bE1veUF4b2cyWG15RWZIWTc5M3BxWXIybDBoUEZHVUVIcXFVanNHTGJwNW1U?=
 =?utf-8?B?UlZzTjdOdVptcnhSemFSL3B2S1owcS9WN2t3ZE9veEljSkdublhQWjNYZjUw?=
 =?utf-8?B?LzN1ZEgzMXBDY2F6aWt3UXY5OUlNbXFSR3VQMFBrb0FMVlVXUGhlU011dHVh?=
 =?utf-8?B?NXJ3K3dTS0kzOHZwTWQyRzZKY0tOZ013S2F6S05nTnNiOE0vcW5HNFFCMjY5?=
 =?utf-8?B?TlVjVW9oenhPT2ordmVrUFdOV29EbCt6L0gycmRBUGRtU0hWaHR4K0pmWjRG?=
 =?utf-8?B?R3RZVnROcGNpcXZ6MDRUemxTK2I0cktRdVpjYmg5Z1U0YkMvZkNNQVpqNXdW?=
 =?utf-8?B?eVJTZmdTalI4SjhqRy9tWmMwRGdtM3A0U1FYd3pTSGRDam1QanZCL3E2VlJD?=
 =?utf-8?B?Ulc3V1M4Vk5XQTBEQ1l1cE54VkM2WFJhQ2s3a1BYcXNSd1dHclZFQUJCUkJS?=
 =?utf-8?B?QnVaUGJHdDFaSTl3aWZ2cG1sNUpwbWlOYUY4MXRHRmxuYTdCUFZMT1JZKzdW?=
 =?utf-8?B?VUkwRFpmc1dtZWZiWHBZZGRSM09yV0UvaFVicjNzVnhqMzg1bVpaTkdpUlBt?=
 =?utf-8?B?L0E0NWFZYmdSQXZBS25uQmNwczlMVDJxMlliQ0V5ZW9ZNVBLNWYzLytQcGw2?=
 =?utf-8?B?eUVncGtmNTB0Ly9qaDhWZzA3ZUxsYkxycjRiUEpRek1aeVBuc1RxN2EydE1a?=
 =?utf-8?B?djd2NElSWDk0eXcxWGRkZk96dkpZSmVaOVErNXRJTHVDU0tBR010d2kwZU5K?=
 =?utf-8?B?NWpQUjlkT0dMZG96L1hPZFhYZTNrQlJWRVhORW4rZExsTWNHRUVhV3BnZnZW?=
 =?utf-8?B?b25MT1lSUUM4aHV1U2dOTjRjODNYeXF0Zm9uTDNpdzhTcjBlUStXQ2YwTnhJ?=
 =?utf-8?B?VFhMd0pLbGV4eGY0bmFQZUpOZnZZOTF4eEVIWmIvdjFiWVJPWkMySW9lYVo4?=
 =?utf-8?B?a1AvYTRLL3R5TjIrNDZNaUJVMEJpdHhPaS90YkxNcWlpTFgvaW11MEV5cWRI?=
 =?utf-8?B?K3dlTmU2aVBlVDhKOVZYZ3p5V3JzS25ac0FMeEFLbFpFNElWSlBxK3RZUmNa?=
 =?utf-8?B?RzJKUUF4VDFReDNNWDFwZEZBdzhtMXpILzFtVTZmeGpBTVpIZ1YraWpWazZI?=
 =?utf-8?B?SEtQaGJvaGptcFd0RkFxaTI1VTkxUHdJQ0dYWFhhN2orYkRxckRDcWhFaXhj?=
 =?utf-8?B?WWVnaHVqRzZRYXFKbzkxdTIxa1VqZGtIK0ZuMWt5SWJtVnZrZHNsSStlbWlv?=
 =?utf-8?B?ZVFsd29raFBWOXNocEtsR3E4KzBaK212TWJuK25OeVFqY3pDNUVBS3hMcVlE?=
 =?utf-8?B?ajVuQUJJbkRMYk51Si8yZUcwdkQ3WjVYVVJGMGlWdFBKVHJ6V3ErTDJvTnZn?=
 =?utf-8?B?cFA3dmhnNDN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0x3OW1HRjFpK25vcHYvdHRhdzZBOVdBaUFMd3p6TlpsQlZPaFM5Y0xSZHRk?=
 =?utf-8?B?a29nakk4Vi9sMWlxME1KSkdVQ3lGRHBNS0pibWJHVnBSOHd3WVdaNWsrMi9C?=
 =?utf-8?B?bm5qU283MThPd253NHNXMjUrTEp0OXRoNG5OZUMzd2JndVhJOWdqN041TFd0?=
 =?utf-8?B?dGlOUlptcThIYTdIOTd2VHVaQjcyNXFPYWp6RnQ1QnpnTGg3RUVTMUtkbjg4?=
 =?utf-8?B?eTNsWlJPNjFyakh2ZTdya3BCR3V6Y1oyVEpJZFZrWWpWWWgyek4vZXBKck9M?=
 =?utf-8?B?UUs5enJ2VzBLUDZWYVJjYk5FUE8yZTM3R1pMYUFjTFhVWUFwL2hHbGt5cS9o?=
 =?utf-8?B?RlJHdmxUdlpiZ1E1T0lwMDUxZHZXZVE3U3YvTFBPWnJmeUpYbWNMNDhwSGw3?=
 =?utf-8?B?WWRLb1kzNEhNUjFSeTRESmh2NThzR0xldDdreGozK2lJUTdocnpLUXJWeXg0?=
 =?utf-8?B?aVljOTF0eGZhdVFkWWt0azBraDVPUm5DNTBKZWlPQmtSQnR4d0M4bkVEZEhq?=
 =?utf-8?B?S21iSGVmckswOENKZ1VIRFkwMUs4eTJCcm01YmphRXppRlV6dEJqSFl3UWVW?=
 =?utf-8?B?NkJPOThMQ1dDZUxEY3Y1cDRZazJjVEptK1lnUjh2cXloM2NIYXpOT1BkMlNC?=
 =?utf-8?B?THdWdGxkeEhBZkRoVFE0a24vS1UwTlhjRXRvMUNYd1NVMEtRM0RZZ0p2ZWEz?=
 =?utf-8?B?cG45czVUSXNlM2E2Y3hKd0VqVDRkbzZHSjVmK0VwZU1JNE4yazRPOTYvV2x0?=
 =?utf-8?B?ai9WMXFRS1lkYlpOU1haanEvMWxuTVNDZHU3NGN0WXl0VFhZY2NRWFRFci9O?=
 =?utf-8?B?N3RjY1FYY0hsVWM4M2ZyZXBucWp4YmRkNFRqMFhmUlExNWZZWjBZUC9nT3V0?=
 =?utf-8?B?U2hmclgvdk1SWmFLSVBPbmhOb0FzcVZhRTZvNHZkQlFSWW55L0M0czIzNjB4?=
 =?utf-8?B?eXR6VDN1OSt2V0ZTQWJ3OHhvKzFrcy9VRGgwUk1YVUdxY2FHVnZDQWhTRDVK?=
 =?utf-8?B?R1lmTjl4ZkdlTitucE1zNThQMkRtZ0tKRk5OcWM2U21Id1JIck43RnJSYi9E?=
 =?utf-8?B?UUtEVDEvM3dLYjNFMWNZYXBwZ2hzNzVBY0JOYSs1RG9tMlJhSUZMSGI4cGxj?=
 =?utf-8?B?ZXNTa1NDWHZuZVVTV216SFdWa3d0ZHRZNFFJYWpJaGxQR3NlVDhLdGxmNnRI?=
 =?utf-8?B?UUdkVm5jWGUxY2g5dGJqMW1LRnBybzl5Vi9YWnhQbitCUjVUaXhNTGpMbVhv?=
 =?utf-8?B?b1ZaeW5SbFh6djlpVVdhWWZoT3ZPQnI2b2tkT3hkaHp6UnhRYm8wRitZRE9x?=
 =?utf-8?B?U0Z3cGw5d3FVVFExT3BYVzFPaDlRc1dkc2l2ZVEwQmN4SzVoZDdZT2txQ0pW?=
 =?utf-8?B?LzdHNXBpZnVEc3BPdVJPQUx3UnVkNE0zd2l1WUcwVHY0dHRkSzhGakZ2WUJY?=
 =?utf-8?B?cGp6bXcxYVNkdW9VWlJGU1lGSGh0c3NhaU5KdFdQdDVISWgwbFdJWFBrYmZY?=
 =?utf-8?B?ci8xR3dMNFNkRjNWeTBTTkwydmZsRWE0MXpSK3VFMUUvK24renFuRHprdkxv?=
 =?utf-8?B?UHNNbDRPam9nOW00SGM2MlUzVXowQzNST0tmOWV5bjNldGRKb1RWS05Nd0Qr?=
 =?utf-8?B?ZStmYmdhSyt4dlVMbzU2Q3I4YmQrSlRObUhmTlJ2V1FacXFRTWpwMnhaK1Jn?=
 =?utf-8?B?T0FmZERhcWY4R3VXREZTYXRRTC84SitUajZLUjBEWHliR2E4SHNidEszQTgr?=
 =?utf-8?B?TmpRUnFxV1ZyWG56MUFYTjZVM3h2ZWJIMjBYZWtnK3l4V2RHdUtYSmFBT3lD?=
 =?utf-8?B?N2Q3OThnZHpLWlFLZzZORjNCYjh5UWc5TTY1S2FkL2VyWEZpZW9XeThLYjZy?=
 =?utf-8?B?ZzIvRDByRGJDMFhPZDZ1Rk1JeVROdWFHQkFXZVJIQnVVbFBSNHR4N05CSjBi?=
 =?utf-8?B?djBSbVVLYjc4ZHRmSzFZcUxMbE5naXRYckEyZjQ5ajkzeHM0cWRoaGZpbTRM?=
 =?utf-8?B?WktObldOME5oZndmNnpEb1VVamZiME1waGxnUFE0WDNicFRkZFdxWnlMbDl4?=
 =?utf-8?B?ajdxc005R3lxb2JkSWFHVTBVUlRsSnpLSWJIbHNDTi9TaW1mZXFFT29PZTFI?=
 =?utf-8?B?aTRkbHRqS001bk9GbXVDQWVBTkRBMGhBZDhSMWxUbDA1ZDNrRTBBOWM0QkxY?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B74B6304EA6AA4086D40D7AC525FD46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231491bc-0620-4034-ed10-08ddb2e4dad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 06:03:34.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zs2NSf+nG/qqm5b6FZIJFQH4hGAQEGo6kwLYM3E/e89V0U98KaGzke+IkZFQ5nVYrQCVbC262mpju/rKQSs1uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA2LTIzIGF0IDExOjU1ICswMjAwLCBCZW5qYW1pbiBCZXJnIHdyb3RlOg0K
PiBIaSBIYW5zLA0KPiANCj4gDQo+IE9uIEZyaSwgMjAyNS0wNi0yMCBhdCAxNzo1NiArMDIwMCwg
SGFucyBkZSBHb2VkZSB3cm90ZToNCj4gPiBXaGlsZSB0ZXN0aW5nIDYuMTYtcmMyKyBvbiBhIERl
bGwgWFBTIDk2NDAgSSBnb3QgdGhlIGZvbGxvd2luZw0KPiA+IGxvY2tkZXAgcmVwb3J0Og0KPiA+
IA0KPiA+IChOb3RlIHRoaXMgd2FzIGEgYnVpbGQgd2l0aG91dCBkZWJ1Z2luZm8sIHNvIEkgZGlk
IG5vdCBydW4NCj4gPiBkZWNvZGVfc3RhY2t0cmFjZS5zaCkNCj4gPiANCj4gPiBbwqDCoCAxOS42
OTAyMTBdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KPiA+IFvCoMKgIDE5LjY5MDIxMl0gV0FSTklORzogcG9zc2libGUgY2lyY3VsYXIgbG9j
a2luZyBkZXBlbmRlbmN5IGRldGVjdGVkDQo+ID4gW8KgwqAgMTkuNjkwMjE0XSA2LjE2LjAtcmMy
KyAjMyBUYWludGVkOiBHwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFwqDCoMKgwqDCoCANCj4gPiBb
wqDCoCAxOS42OTAyMTddIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+IFvCoMKgIDE5LjY5MDIxOF0gbW9kcHJvYmUvOTA2IGlzIHRyeWlu
ZyB0byBhY3F1aXJlIGxvY2s6DQo+ID4gW8KgwqAgMTkuNjkwMjIwXSBmZmZmODlkYThlOTQ4NzY4
ICgmcmRldi0+d2lwaHkubXR4KXsrLisufS17NDo0fSwgYXQ6DQo+ID4gaXdsX21sZF90em9uZV9n
ZXRfdGVtcCsweDJmLzB4MWQwIFtpd2xtbGRdDQo+ID4gW8KgwqAgMTkuNjkwMjY5XSANCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBs
b2NrOg0KPiA+IFvCoMKgIDE5LjY5MDI3MF0gZmZmZjg5ZGE0MWFjMjcwOCAoJnR6LT5sb2NrKXsr
LisufS17NDo0fSwgYXQ6DQo+ID4gdGhlcm1hbF96b25lX2RldmljZV9zZXRfbW9kZSsweDIwLzB4
YTANCj4gPiBbwqDCoCAxOS42OTAyODRdIA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgd2hpY2ggbG9jayBhbHJlYWR5IGRlcGVuZHMgb24gdGhlIG5ldyBsb2NrLg0KPiA+IFtTTklQ
XQ0KPiANCj4gSSBhbSB0aGlua2luZyB0aGF0IHRoaXMgaXMgYSBmYWxzZS1wb3NpdGl2ZSBhbmQg
dGhlDQo+IA0KPiDCoMKgwqAgbG9jayhjcHVocF9zdGF0ZS11cCk7DQo+IMKgwqDCoCBsb2NrKCZ0
ei0+bG9jayk7DQo+IA0KPiBjaGFpbiBpcyBoYXBwZW5pbmcgb24gYSBkaWZmZXJlbnQgdHlwZSBv
ZiB0aGVybWFsIGRldmljZS4NCg0KQWdyZWVkLg0KIzMgYW5kICM0IGluIHRoZSBsb2cgYXJlIGZy
b20geDg2X3BrZ190ZW1wX3RoZXJtYWwgZHJpdmVyLiBTbyB0aGV5IGFyZQ0KcG9raW5nIGF0IHRo
ZSAidHotPmxvY2siIG9mIGRpZmZlcmVudCB0aGVybWFsX3pvbmVfZGV2aWNlIHN0cnVjdHVyZXMu
DQoNCnRoYW5rcywNCnJ1aQ0KDQo+ICBBIHNvbHV0aW9uDQo+IG1pZ2h0IGJlIHRvIGNyZWF0ZSBh
IHNlcGFyYXRlIGxvY2sgY2xhc3MgZm9yIGV2ZXJ5IHRoZXJtYWxfem9uZV9kZXZpY2UuDQo+IFNv
bWV0aGluZyBsaWtlIHRoZSBiZWxvdywgSSBzdXNwZWN0Lg0KPiANCj4gQmVuamFtaW4NCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gYi9kcml2ZXJz
L3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gaW5kZXggMTdjYTVjMDgyNjQzLi5mY2IwNjA4OTg3
MzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiArKysg
Yi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gQEAgLTE1NTYsNiArMTU1Niw3IEBA
IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlwcyhjb25zdA0KPiBjaGFyICp0
eXBlLA0KPiDCoAlJTklUX0xJU1RfSEVBRCgmdHotPnRyaXBzX2ludmFsaWQpOw0KPiDCoAlpZGFf
aW5pdCgmdHotPmlkYSk7DQo+IMKgCW11dGV4X2luaXQoJnR6LT5sb2NrKTsNCj4gKwlsb2NrZGVw
X3NldF9jbGFzcygmdHotPmxvY2ssICZ0ei0+bG9ja19jbGFzcyk7DQo+IMKgCWluaXRfY29tcGxl
dGlvbigmdHotPnJlbW92YWwpOw0KPiDCoAlpbml0X2NvbXBsZXRpb24oJnR6LT5yZXN1bWUpOw0K
PiDCoAlpZCA9IGlkYV9hbGxvYygmdGhlcm1hbF90el9pZGEsIEdGUF9LRVJORUwpOw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5oDQo+IGIvZHJpdmVycy90aGVy
bWFsL3RoZXJtYWxfY29yZS5oDQo+IGluZGV4IGJkYWRkMTQxYWEyNC4uOWFkNWMzNzYyMGYzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmgNCj4gKysrIGIvZHJp
dmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5oDQo+IEBAIC0xNDEsNiArMTQxLDcgQEAgc3RydWN0
IHRoZXJtYWxfem9uZV9kZXZpY2Ugew0KPiDCoAl2b2lkICpnb3Zlcm5vcl9kYXRhOw0KPiDCoAlz
dHJ1Y3QgaWRhIGlkYTsNCj4gwqAJc3RydWN0IG11dGV4IGxvY2s7DQo+ICsJc3RydWN0IGxvY2tf
Y2xhc3Nfa2V5IGxvY2tfY2xhc3M7DQo+IMKgCXN0cnVjdCBsaXN0X2hlYWQgbm9kZTsNCj4gwqAJ
c3RydWN0IGRlbGF5ZWRfd29yayBwb2xsX3F1ZXVlOw0KPiDCoAllbnVtIHRoZXJtYWxfbm90aWZ5
X2V2ZW50IG5vdGlmeV9ldmVudDsNCj4gDQoNCg==

