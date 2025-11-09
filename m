Return-Path: <linux-wireless+bounces-28698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C2C43A17
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 09:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D5D3AF1E2
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486F2144CF;
	Sun,  9 Nov 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhx8N/gl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A1BA34
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762675815; cv=fail; b=k0mTDjvS1iBXROEviFNYHd7RA+E7+sdz0+L2n/ohWgiAdEzni1yHQWoGRWrZ3hGiOAwMWBFfGfZvfRKu5HPTo/AJftYNaJa75VpnVMldgDbEOVDOQ4kntF24RT0VnNJlrhOiaYOYvvcJjBAGd1A6zMrh6peRDqqb8vZ+x4b119c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762675815; c=relaxed/simple;
	bh=Y0vasA9pW/84agQyRTEK1dHgdnRI88S/eOv8B2NrboE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ka92rfUTazyb8vRuycEOkBuQwIpDVG3gO1iyNDC6MMLg66DPyLy+RJAs2+UAO2sTuo9ujP4/2OkcZColC6N5m4XE9hEOZW86O0XMKSon9CQc73CynagyO0Pq8BQa6I1wAgwV97Zy4Qe2fAu4xkBQwtcC5n2al2chCL+vjZJn71g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhx8N/gl; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762675813; x=1794211813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y0vasA9pW/84agQyRTEK1dHgdnRI88S/eOv8B2NrboE=;
  b=Rhx8N/gl9mYG5SP2/Tl/oxlygU3dnWMurk47wjV0YktogBp2yzh+zC4R
   uk/AdJ4dcJAwtNqF44C3wrZNrVKaAHjrg/U4C/dZfJWxPB6aF9bLrM+vU
   7yD/kZ449A8TOOYRdnUzRa682i1awo+e6SK2oAfbzXO/iVfmbY4V6F/yW
   03REoVbs4N6SQM6B62GEY1BpR8M3CF050bPwtq3BcCVdjq5ouECa6eG8s
   4tyGmpkF97nbEGeI4c6UKYasQzd3o5QHQ8lKjFtlyS8RUuPuQmg9BPDlO
   kaoP6ayu7Ylrw70UBLx1nCqq6EX6zOh5CspKAk4YSksx2RhctHAaXzcE6
   Q==;
X-CSE-ConnectionGUID: IJ0CzriZQ4SHWHPKvUZPFQ==
X-CSE-MsgGUID: NRybH51FRw+BZmWNUqaxvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="75451020"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="75451020"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 00:10:12 -0800
X-CSE-ConnectionGUID: aVjKP75JSP+aDL1dz3PQVg==
X-CSE-MsgGUID: Smx6fKEsScOJmozGcXmRag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188665825"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 00:10:12 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 00:10:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 9 Nov 2025 00:10:12 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 00:10:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPObnhhLV/gq4G9qKVR/7vfJ6rAmcuhj3oF4ly+qZjYS0BgQFnR/89s7LUYX4TiATk6RQVx5HDBboCb1Mp6zuOSNHVpY27vwjOTh793bbgr2At4s+/2eDrvxjrYdMRxCXw+2e9DXvBwfHfpCJimvXcHpSXyx4QnBjHuA84fFr9F5PQZ31Qm57WDB3rr91H73Ari3Dooz4q07tR7oLUUhrYkfwEpDfR0SaHsTgIkxh002rr48vbqwmZuMXO4GUNz7GL3pBl5Et0ZAHY5jWEY8vZrfTI9AmDeVdEj9YZjXZMro6LaHeiSJ9YWczZRIU41UYm0oZ+opP573RkGdFWyatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0vasA9pW/84agQyRTEK1dHgdnRI88S/eOv8B2NrboE=;
 b=KMkp9T4rBUvmi9GkRWcvHNlMckim3AB0gjmNL+efAvVHreN8nMFyD3I65ifEpR3BwvYnxr4qeU+4zuv2aX+i0a8jAJ9W+/lqLBhnuDbHz3B2msMvX7tebZnhpajFAX0ec2Uzxu6+R1j9U58LSZnW0ic+JTNSc1YRE6tgRtycyCKnV13XoDBOyYpMj0Ue3h2aCxZTOTa5ow4tL+whtZE6leFDTu3ItnD2DlD4WYCLnEtA0iL5yHnzntK+b+qUJ5syk2nYbbp1wUM7bLv2vjEYYtfa7uPmV5pX8/ckfA2gMZbgv2w/efnUHQDZ9cz2PLqYc8Zs4HJQVW6I4ma7XkYXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) by
 IA3PR11MB9206.namprd11.prod.outlook.com (2603:10b6:208:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 08:10:05 +0000
Received: from DM4PR11MB6432.namprd11.prod.outlook.com
 ([fe80::8b2:9c72:8f9a:8280]) by DM4PR11MB6432.namprd11.prod.outlook.com
 ([fe80::8b2:9c72:8f9a:8280%6]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 08:10:04 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "greearb@candelatech.com" <greearb@candelatech.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: support for
 COMPRESSED_BA_RES_API_S_VER_7
Thread-Topic: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: support for
 COMPRESSED_BA_RES_API_S_VER_7
Thread-Index: AQHcUDyhThrLX6rLR0acdyOq6ZwzZLTqAAeA
Date: Sun, 9 Nov 2025 08:10:04 +0000
Message-ID: <ebff7d3d89c87b2646da17bd10b8f075a4be4d98.camel@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
	 <20250430155443.c4be90e242ff.Ie8a0f0d6320613bd8c5cb6c82a063069fffa3b67@changeid>
	 <11cca5db-28c5-a57c-78c5-7084afd92509@candelatech.com>
In-Reply-To: <11cca5db-28c5-a57c-78c5-7084afd92509@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.1 (3.58.1-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6432:EE_|IA3PR11MB9206:EE_
x-ms-office365-filtering-correlation-id: fba4d061-fb23-4a40-9ba1-08de1f67637f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bjR6VmMxOHZJWXJ4VXVsbU5xcHg5c1FTMXB6c0p4c0Y4TmExeWxwaDNJWFZy?=
 =?utf-8?B?aDJrSjBlZ2FxQ09CamNkSUhWWTVKQWV1WFZtTldwOGREWlFJQUtpYm9QWTJ6?=
 =?utf-8?B?d1NTR0JaNzFpSzZwVzZnQXpQNDlMajJpaHRLNkRXNkdaYXRva2lZZGg1TEFw?=
 =?utf-8?B?M29GcklFdXRYTUY1YithQ1h0U0Nqc1dTQ1B6dzVkek9wVk5DMzNRVmV2UHRr?=
 =?utf-8?B?QnJpTit3bjVUTU1ZSkdrcVA2dDJWbzFCVElJelcwcTBUK0lTWVJvVTlncUFE?=
 =?utf-8?B?b0tVTlZoWkVnNWRUZUxwWVBkT0RnZDhuTWNTdkk4clF4dGZPVWV4eWZOV0o3?=
 =?utf-8?B?TXlydHEzdmZKKzhSRXhMSEdLUmpmM29rcCtVYUVzMkZyd29Bc1Y1VU8zSS9z?=
 =?utf-8?B?bGo2M3hEYmVQTlNDeWhPVEZBaTJaNFh0Q1c1eEdiRk5yaWloNXo3RW1pVzQ5?=
 =?utf-8?B?TUJNUzFBSEZZVTZCZDlqL0l3cmJReTBnRHZIWUVjMWlyb2Z5RER6RnRueURm?=
 =?utf-8?B?dWxTaXA0Wko0bG5mL0ZvdmVKQlh2TlBQcU5GQmhsMmJmdGRURVJVQnJ2ajJo?=
 =?utf-8?B?YUlTK0VvWXhmUzM0VWJKK3JURVQyTmswQWxRUEpJMDVpQzczT3dtcy93Q0x4?=
 =?utf-8?B?WXdydElubzlPTE41TkVwUnFTVEZkcU1NSGZPUkUvd1lMcDd3bUxrQWdwaTJm?=
 =?utf-8?B?NUhFd1J6TUdhMXNJblNXNU1xbGFJbmdDdDFNTURjSEhFc2xGdU5mTTZQZ2Fy?=
 =?utf-8?B?V2ZyeXpad0FJTlE0U2tYLzVib2h4OW5DVHBpdzM1d0tEMmdXYjlRYVRIb0xO?=
 =?utf-8?B?OWJFYnhnQmZtc1F3VFdwUDI1MjY2bng1TXM3U1RQTU5DQnZTU2tIZjRoZ2xR?=
 =?utf-8?B?b3JtZTJHYkZTaWtwRlVxWXNaWXlnbUQ5U1VaZlgyajZvYVgwUHFCYlI0QzVw?=
 =?utf-8?B?cTBwMmxtNDhsenRQbWkyMXgwTHBVT2wvRDdzKzJCaHczd2hUaWx6QXJLVlVC?=
 =?utf-8?B?R0hoSGtHL09qOGNsbjlmN1B2RnNxZjFKa1NqR2VNdVRTQ0ticnVNSVI5VnBV?=
 =?utf-8?B?eC9tTWYyNU1lQ0xsblRBNFF2M2djM1BaSW52eVVxZ2NKY1cwMVF0ZUtpNmNj?=
 =?utf-8?B?aTNCdTVoNCtaRktZclJqQmxxelNYL1NtdjJVYUVkOEhwQjExN2cwamhhQnUz?=
 =?utf-8?B?ajMwY0ZhSFIrZVZaQUxCTjFla21nUWNNYTNURndnenFHcVE2YlRwaURoK2Yw?=
 =?utf-8?B?MitVSjRUMm9qUUxybGtqT3NDMWt6NmU5eWxLWkQ4T2trVWh5OG02T21MTnBY?=
 =?utf-8?B?dlhNZkJoSmJpc1RrcjZFMnVxcm1oUkVCcy9oZno1YTRHblVLMjE0UWoxeFYr?=
 =?utf-8?B?QmxsMTByODJlR0lDcG5WVTNseHJYdlJ1bmZOYnc2clFNTEJYYXQ2SUtXaG8x?=
 =?utf-8?B?STh6YjhOc2ROeDIvdkFBOGF4TFZMVWlOcjZsZUdYOHZRTlp6akRCYURNYmUx?=
 =?utf-8?B?ZVJlU004QTVKZmJROFlYSXpwcWk0WGxTRGpIbVgxMHptbC91eUJmRndMTUNE?=
 =?utf-8?B?WEdzWk0wM2d0Qit1Y2F6dnRWWU9wdWp6cE4yRzZNa3ZocStJbFI3aXNjWmJq?=
 =?utf-8?B?RmNRbjV6TTMwTlVUcVh1UEk3QzhDcnRkTHlvdExUYm1pNVBvV21ZYkhEQ2FX?=
 =?utf-8?B?aUpkc1RWa3lPaEl1MlF4eEFwcHNoTTQ0QlVxbHJMMVEwK1BuckIrUHM1bmZh?=
 =?utf-8?B?dUpDZm5ua0RXQ2RZVkk5a3Yvd0E0UE9lNWRjVERxR2FzcktUd2R4dlNMVzdI?=
 =?utf-8?B?OFZTRDFSWGpnUENOdjJFdkJkemg5NUtEVCt3S3BIS2sxZXByYkVhV0E3OWZw?=
 =?utf-8?B?cFU2QmhkNEZQdVJIQU4wOXlFeWVoL1hSSVhsamMvOTRvYW5HL2Z2ZXcwQWJ0?=
 =?utf-8?B?TS8rZU5zeVRaZUJsdUFhcDBjbkdoVFpjWjRkR0pDS3k5ZkRtSW1ZMjdHTEtz?=
 =?utf-8?B?bWluSEE0KytnWEFMZm00NnZZTTQ1cFpZWW9lZjRBeEMrMzRVdG41MUk3bzJm?=
 =?utf-8?Q?RHNbFv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6432.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDBYd0I5TFhMdDRXK25qd09vOVpXSi92bGVEM0h5aHlzYnZzbnpaYmVvb09s?=
 =?utf-8?B?cGRoNkZUQXVoZk50QW43MzBFSmNHbllNeG5MM1dDdFdZYUFWOHR2YUdOcUlV?=
 =?utf-8?B?bUM5bFRPN01IWW82dmNCN1Z2WU1TSW5wTFZUOEhUVVVuQnFNTFJ4b2JWY0JX?=
 =?utf-8?B?OC8yeWxGeHVLa1pCNlBBdVVZaWlYODVCK0NuUHBuaFA0aVN2RVduT2RFd1Jr?=
 =?utf-8?B?Ri9XTU5FNzJlVTQ0bWF2QTRKQjZ6cUZWUWZRam9KTlVEMVNqczJRQjA0Tmts?=
 =?utf-8?B?dk9Zb2dTMlJNRW42UzI1cnpmVEptencxY2czZ1NjRmY0SnAwM1NsalA4cHFR?=
 =?utf-8?B?by81Y0dkN1c3N2JKMGdRRERleDNvbm12WGU5bFRSOXBUYTA1UC84WTI0cVgx?=
 =?utf-8?B?NTE3d21ZR1NmelhtTEVWbHkxOGliZlFPcmpIcXNTZVdxZHZWYzBoTUpHcGw0?=
 =?utf-8?B?T1V3KzZnZ05XelhSdjdsaE1PYWVmNFY1UGZ6NmxlSlFna0FDODJ3QyszUTlX?=
 =?utf-8?B?aHh2RlRpNjgzdjA4UlNsajV6bk1TTDIwOVJKcHEra0Q0clc3TlBDYWxRbDNr?=
 =?utf-8?B?b2xLaWhwMWR5emhnTktsdjJmNTNWUHdEQUs0MGYyVFdId0R4RlQ3di9adURp?=
 =?utf-8?B?dkx2TVAwaENrcDJNdTVmeVBLYldMSS9qNXNmQnBlRi91UTZGRnlUQ1Bub0RX?=
 =?utf-8?B?ZXlBbEFCY1N5RHowYnBqYzhUb3lRUTF1S3JLdkQwL3k3OFIzTWZLbUVqRkJx?=
 =?utf-8?B?ZWVCRUp4eVVxdk1NQ3BzKzNMdmREbjRIYzJqZlRMQlJhSUZjOEJhbVY1ZWkx?=
 =?utf-8?B?TjB1SmlwUWdnZlpKVXQvWWFYZEtZenZsOFBPZVZJZG4zUWllN3Q5V3M5RGhi?=
 =?utf-8?B?THNOdmJvejBTSXdOL0dML29DOE1LZnJCL3NGYU5mZ29zMkxaYjMzY0FiTjg5?=
 =?utf-8?B?MXVURjFkNUFpMytNMXhDYVF5NkJMZkFoWDRDOTZBUTltWDVBei9PVmdUaWVW?=
 =?utf-8?B?WDVQRjVITEN1NmE3RUxOaGVqSERRWVdjb1BvU2MydzRROWJGR0FVNXE0MktG?=
 =?utf-8?B?NDIwdGd2L04xdW1FRFJNSTg0MCt6Snd1WXptZGE1bW9YWGM2NGt6Z0xqK3Z6?=
 =?utf-8?B?SmRSQ1M0N2ZXR09HWjJFVWhkc3lhQURDUy85ZjQvUGNTYU81YnBvUkFOelZW?=
 =?utf-8?B?MWk4eW9lemVnNnZKZjRvVENiK0taWGJwRVhmZXZXaWhLeUhiM2tRM2NEYkJL?=
 =?utf-8?B?OEdIRkQyRlJ3NDlNOUQ5K3RrbExCN1ltUUZPNWFTWU1KTG10b1F4ajc1bkIr?=
 =?utf-8?B?MjdKNTNidG9xM0gwSnJuSFFZdUk2YlZyU3FBQ0xLeWVUcWQ0cXFwdzJ5QTJS?=
 =?utf-8?B?UGord1pHQlJoL2Y1TDlxT2RzcEswNEVZTTVRVGJkUFNnUlF3Y1M3WXljKzN5?=
 =?utf-8?B?UlVJY0NWelFUd0pZWTRPeXgyakQ0V2ZkbXFMOHFsOWpwL0FZSjE3WEJSWVlE?=
 =?utf-8?B?d2FGU1V0TUdBQjF2eU5WT2ZTRlIrdC9XZ053NlAzYXg0Y0lHOTUwVU1RNDZC?=
 =?utf-8?B?WEFDc0J5c3htZW9BdE5Fc2tYL0RwRXB6N2pEd21EelRKVUdHQWZKWHpLU29R?=
 =?utf-8?B?K3I3QU5HUiszOE85ZytCQWJxQkYvTDMzemhpU3Z6MllxekxTODllWGlTeUk3?=
 =?utf-8?B?ejR3Z2JoNlI1MEp3TXZnUCtKVFVtdTRFRkdHL3RFRi9CcHVsS0FCcW1aRk1j?=
 =?utf-8?B?WEsraDZmcVpEb2JySldXVzd5S2FhanY1VkJDYWNOS0R2THQ5TnVhcityNC9r?=
 =?utf-8?B?U2IyNjViWWc0c0hKZ1J2MVFPaDdsbUd5WVJROTZmdHFtS05tOFRzN3hqb2pm?=
 =?utf-8?B?STFoUjJibjVMQVU5eFZqbk54Q3BqeXJ3YUpINHVxM2UralRUWXRiMlE3MWFa?=
 =?utf-8?B?MUJ3TmNLK2p0Z0Zpd3FTQnZMWjNtWUdXUEgzMHgrQVoraFlOS0lHcWJSK21U?=
 =?utf-8?B?K3JUTVZBMXFTUnlGSUtoVHVSMkZsOFc4Q3JBaFlTamNybGVmSCtTQ1krZXRC?=
 =?utf-8?B?MmR6ZXNrN3B3UC9wMWZqNENEclpRYXFRd2xpY2ZMYUlsOXgxMnpIM3RwcUp0?=
 =?utf-8?B?K1V2WmQ5SUlFY21OM24yUFVWNFdrRlArZG10d0VDNFd1ZVQ0KzJXMStzUzZ0?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD709774EB12E44E8F5A42424DC57F4B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba4d061-fb23-4a40-9ba1-08de1f67637f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2025 08:10:04.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWz5xl8d9F4yq9c/QrHldrRBv3i8jF0j4pzyb3addykL3Z7pnhAnRDH6iDZBKhPDK3R+8+4CTSvLgNbNJaIyX+q9TxR4HDVKaFw5JkgD+h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9206
X-OriginatorOrg: intel.com

SGkgQmVuLA0KDQpPbiBGcmksIDIwMjUtMTEtMDcgYXQgMTU6MTYgLTA4MDAsIEJlbiBHcmVlYXIg
d3JvdGU6DQo+IE9uIDQvMzAvMjUgMDU6NTcsIE1pcmkgS29yZW5ibGl0IHdyb3RlOg0KPiA+IEZy
b206IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+DQo+ID4g
DQo+ID4gVGhlIHJhdGUgZm9ybWF0IGNoYW5nZWQgYnV0IHNpbmNlIHdlIGRvbid0IHVzZSB0aGUg
cmF0ZSwganVzdCBjbGFpbQ0KPiA+IHN1cHBvcnQgZm9yIHRoaXMgbmV3IEFQSS4NCj4gDQo+IEhl
bGxvIEVtbWFudWVsLA0KPiANCj4gSSdtIGludGVyZXN0ZWQgaW4gdXNpbmcgdGhlIHR4X3JhdGUg
dG8gcHJvdmlkZSB0eCBoaXN0b2dyYW0gc3RhdHMgZm9yDQo+IG1jcywgbnNzLCBldGMuDQo+IA0K
PiBDb3VsZCB5b3UgcGxlYXNlIHNoYXJlIHRoZSByYXRlIGZvcm1hdD/CoCBJJ20gc3BlY2lmaWNh
bGx5IGludGVyZXN0ZWQNCj4gaW4NCj4gSW50ZWwgYmUyMDAgb24ga2VybmVsIDYuMTggYW5kIGhp
Z2hlci4NCj4gDQo+IFRoYW5rcywNCj4gQmVuDQo+IA0KDQpJdCdzIC4uLiBhIGJpdCBjb21wbGV4
Lg0KVGhlIGZpcm13YXJlIGlzIGNoYW5naW5nIHRoZSBBUElzIHRvIGFkZCBzdXBwb3J0IGZvciBV
SFIuDQpZb3UgY2FuIGxvb2sgYXQgaXdsX21sZF9maWxsX3BoeV9kYXRhLCBpdCB0cmFuc2xhdGVz
IHRoZSByYXRlIHVzaW5nDQppd2xfdjNfcmF0ZV9mcm9tX3YyX3YzIHdoaWNoIGFsbG93cyB0byB1
c2Ugb25seSB2My4NCg0KdjMgc3VwcG9ydHMgVUhSIGFuZCB2MyBpcyBzdXBwb3J0ZWQgb24gZmly
bXdhcmVzIHRoYXQgc3VwcG9ydCB0aGUNClRYX0NNRCB2ZXJzaW9uIDExOg0KbWxkLT5md19yYXRl
c192ZXJfMyA9IGl3bF9md19sb29rdXBfY21kX3ZlcihtbGQtPmZ3LCBUWF9DTUQsIDApID49IDEx
Ow0KDQpUaGlzIHZlcnNpb24gb2YgdGhlIFRYX0NNRCBpcyBzdXBwb3J0ZWQgb25seSBzdGFydGlu
ZyBjMTAxIGZpcm13YXJlDQp3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5IGtlcm5lbCA2LjE4Lg0K
DQpTby4uLiBib3R0b20gbGluZS4uLiB5b3Ugc3RpbGwgaGF2ZSB0aGUgb2xkIGZvcm1hdCBvZiB0
aGUgcmF0ZXMgKHYyKS4NCkkgc3VnZ2VzdCB5b3UgY2hlY2tvdXQgZGFiYzg4Y2IzYjc4Y14gdG8g
c2VlIGhvdyB0aGluZ3Mgd2VyZSBkb25lDQpiZWZvcmUgSm9oYW5uZXMgYWRkZWQgc3VwcG9ydCBp
biB0aGUgZHJpdmVyIGZvciBVSFIgcmF0ZXMuDQoNClRoZW4geW91IGNhbiBsb29rIGF0IGl3bF9t
bGRfcnhfZmlsbF9zdGF0dXMgdG8gc2VlIGhvdyB3ZSB0cmFuc2xhdGUNCnJhdGVfbl9mbGFncyAo
djIgb2YgY291cnNlKSBpbnRvIHN0cnVjdCBpZWVlODAyMTFfcnhfc3RhdHVzLg0KDQpIVEgNCg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5ncnVt
YmFjaEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlyaSBLb3JlbmJsaXQgPG1pcmlh
bS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiDCoCBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS90eC5oIHwgOCArKysrKy0tLQ0KPiA+IMKg
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL25vdGlmLmMgfCAzICsrLQ0K
PiA+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L2Z3L2FwaS90eC5oDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3
L2FwaS90eC5oDQo+ID4gaW5kZXggMGEzOWU0YjZlYjYyLi41MGQxYzU5MDA0NGYgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvdHguaA0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3R4LmgN
Cj4gPiBAQCAtMSw2ICsxLDYgQEANCj4gPiDCoCAvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCBPUiBCU0QtMy1DbGF1c2UgKi8NCj4gPiDCoCAvKg0KPiA+IC0gKiBDb3B5cmlnaHQg
KEMpIDIwMTItMjAxNCwgMjAxOC0yMDI0IEludGVsIENvcnBvcmF0aW9uDQo+ID4gKyAqIENvcHly
aWdodCAoQykgMjAxMi0yMDE0LCAyMDE4LTIwMjUgSW50ZWwgQ29ycG9yYXRpb24NCj4gPiDCoMKg
ICogQ29weXJpZ2h0IChDKSAyMDE2LTIwMTcgSW50ZWwgRGV1dHNjaGxhbmQgR21iSA0KPiA+IMKg
wqAgKi8NCj4gPiDCoCAjaWZuZGVmIF9faXdsX2Z3X2FwaV90eF9oX18NCj4gPiBAQCAtNzAxLDcg
KzcwMSw4IEBAIGVudW0gaXdsX212bV9iYV9yZXNwX2ZsYWdzIHsNCj4gPiDCoMKgICogQHJ0c19y
ZXRyeV9jbnQ6IFJUUyByZXRyeSBjb3VudA0KPiA+IMKgwqAgKiBAcmVzZXJ2ZWQ6IHJlc2VydmVk
IChmb3IgYWxpZ25tZW50KQ0KPiA+IMKgwqAgKiBAd2lyZWxlc3NfdGltZTogV2lyZWxlc3MtbWVk
aWEgdGltZQ0KPiA+IC0gKiBAdHhfcmF0ZTogdGhlIHJhdGUgdGhlIGFnZ3JlZ2F0aW9uIHdhcyBz
ZW50IGF0DQo+ID4gKyAqIEB0eF9yYXRlOiB0aGUgcmF0ZSB0aGUgYWdncmVnYXRpb24gd2FzIHNl
bnQgYXQuIEZvcm1hdCBkZXBlbmRzDQo+ID4gb24gY29tbWFuZA0KPiA+ICsgKgl2ZXJzaW9uLg0K
PiA+IMKgwqAgKiBAdGZkX2NudDogbnVtYmVyIG9mIFRGRC1RIGVsZW1lbnRzDQo+ID4gwqDCoCAq
IEByYV90aWRfY250OiBudW1iZXIgb2YgUkFUSUQtUSBlbGVtZW50cw0KPiA+IMKgwqAgKiBAdGZk
OiBhcnJheSBvZiBURkQgcXVldWUgc3RhdHVzIHVwZGF0ZXMuIFNlZQ0KPiA+ICZpd2xfY29tcHJl
c3NlZF9iYV90ZmQNCj4gPiBAQCAtNzMwLDcgKzczMSw4IEBAIHN0cnVjdCBpd2xfY29tcHJlc3Nl
ZF9iYV9ub3RpZiB7DQo+ID4gwqDCoAkJREVDTEFSRV9GTEVYX0FSUkFZKHN0cnVjdCBpd2xfY29t
cHJlc3NlZF9iYV90ZmQsDQo+ID4gdGZkKTsNCj4gPiDCoMKgCX07DQo+ID4gwqAgfSBfX3BhY2tl
ZDsgLyogQ09NUFJFU1NFRF9CQV9SRVNfQVBJX1NfVkVSXzQsDQo+ID4gLQnCoMKgwqDCoMKgwqAg
Q09NUFJFU1NFRF9CQV9SRVNfQVBJX1NfVkVSXzUgKi8NCj4gPiArCcKgwqDCoMKgwqDCoCBDT01Q
UkVTU0VEX0JBX1JFU19BUElfU19WRVJfNiwNCj4gPiArCcKgwqDCoMKgwqDCoCBDT01QUkVTU0VE
X0JBX1JFU19BUElfU19WRVJfNyAqLw0K

