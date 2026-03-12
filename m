Return-Path: <linux-wireless+bounces-33164-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEXjI0cts2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33164-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:16:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D45279DCD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88EB3145A02
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66CC37F005;
	Thu, 12 Mar 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkbIGPf0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17451394474
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350078; cv=fail; b=Y6YJWWgt8Of8z1a+aKGMRIpHOQKtkAOU7BYIZ+RRCT3zfaj6fIoXuti/2XNwLsmoq+aY1Xc6354cWDBac8tBBU55bVp6qYw7W0lHQ9Y/pGw1FY6etAXDi4ChvmB4AkIdTpNdfguTyaXeFHx0EZ/lodOOC9APsBPnvPNAs8vN3mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350078; c=relaxed/simple;
	bh=jvd+MaHXhWRdkfndEMO2qw0YcFbjdZnH3hQ+FQmLLAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5548REAPhJGKmkJ1lcJ2uFHbr5oYE7DOb//2kOEx6GSLrOmAz0lCbHAlBuHiFha7pTY5F514F0CsZ1TYoskIFJ7hdgFNmayaBo5rCSFnPbeLnv54+TZ5dXDi7EhjtcqAla8e5ZyPQ+burSLD3xpC1GqJtDH7abJW67kEk8Sg2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkbIGPf0; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773350075; x=1804886075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=jvd+MaHXhWRdkfndEMO2qw0YcFbjdZnH3hQ+FQmLLAA=;
  b=PkbIGPf0ID33T6RjgSLPsz/daoZ7gLle976b3gQAvNctXHBCtrKd7nT5
   5mHvFuLpNOa/L7e8lHQSfaD7tJlvsToD/v3bsYq3hYYBQx3myYUXP3/2I
   CJiEEROhQwkql55QBfXlPgEIBQ1RC0MWZuUaOnpRN26u7B1PD6JZmpdul
   01gaEQZ5NYI9l1wuGmhRlZCV2osDQ4EBKfpRrCYoqnq0i5xnzDWwjvrwQ
   I8/FZFXFJ3uXGFndfdzOpnLPNHPtGaQmkEMKS7oHQsFeX59NBpqi+g53G
   qhzuop/UKaZHMtvtwT6it/rL5FBZiMO/8qgJAfokCOWb68Eth3/6NVi9M
   Q==;
X-CSE-ConnectionGUID: HP766I27Sk2a0VYQgd3H8w==
X-CSE-MsgGUID: 3npx83XYRnGeYW6UINM4Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74350202"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74350202"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:14:35 -0700
X-CSE-ConnectionGUID: OyLYfnOSQ3iHJ3H8hgOWfg==
X-CSE-MsgGUID: 0wz9SE4VRROJo97KJcE5Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="217022557"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:14:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:14:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:14:33 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdXACRNkkAiiCfqQLmhfvWB+uZz9/R5gEa7aEmIbmc5fkMDQgbG2gPwGFpbu1AQK3QKq3pijFSzr/j80SllrBpKxa7+9DZZoBbxYmtC/DDQGO4CUR35TuS4vH/2Iu8eW67L0F/VA8sQI3x2ALJiBL0KCK5g77aBBACTDVV+1vKO0luCFIRf9KGGpcOuDCg6egEJHkamwWoR7gHDiOkYlyg6N2nV0JOu8GycSvf7cG2pZUii/HyBPnPHjKfG3LRL0geA7dOsqgk5dyO7QuuJKgOzQKuHe9smXsecop3TjQ67lma//fDrIh7W4trYofPasRR5uAEcHUooGtTigJC5thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjG+dUxJdWG7HpNVJX8+Xugfe0KpnPfj5zRqEG7VL3o=;
 b=LeoUfWCSwKxaaiWssQ1KC3cQd04eBPSgFGVQbGZZIE8u0bADEnpgk/MLntmvIqKMJd1MZ+zVLnDBKgLFv6AmojM74cTYk8yxMXIzQQni5PGRKCzwsAbPpmgpJGEU6tTDVsTKEvO6cdYT/kOswh07uHQ5xwhiwGZj5XBx1qVuDb+RWnZ0dmddOSZzjLQlYMfXgd6MvVwuuNy9YJ2qeQmRnjmv3gMjdtm7/8A2TDow0aGKXfCfK9WSkddu9w3WHt2uNGHD5uI7IpuZqFDH1GpVnyDgvD9q/NurH0NgDF/Chb7m56v6WGxDtpWLmViTBullJIR2AMad5jQj9eXAsMC8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by IA3PR11MB9325.namprd11.prod.outlook.com (2603:10b6:208:571::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Thu, 12 Mar
 2026 21:14:25 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:14:25 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 10/15] wifi: cfg80211: add ingress/egress
 distance thresholds for FTM
Thread-Topic: [PATCH wireless-next v3 10/15] wifi: cfg80211: add
 ingress/egress distance thresholds for FTM
Thread-Index: AQHcr8tfLdV4uQpGMEyEyzd1LP/5dLWrao8w
Date: Thu, 12 Mar 2026 21:14:25 +0000
Message-ID: <CH3PR11MB8383572815565E924067C267FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-11-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-11-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|IA3PR11MB9325:EE_
x-ms-office365-filtering-correlation-id: 7cec402f-6cc6-431e-3e32-08de807c56ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 45tODpDQzMPkM4t5NsiXQuOw5WqAM5t7e6wFHQ9uSUztTfujMvtvZWCo49saTZqzHZPx9tzV4PwXjO5K+eX6nNy8WAFhBy7QSZMHKX7ntYu+7U6Z4MfyxFOSMdMuKPod0DAS8lfv/krhw/84MfIT8muJJpEXgNLlALoGNePN0Ycx0zehguDVBdct3oYkXnzRxVekQU7k6PYc2WXL+M9/OxRKJOJ2xF4ivtyHB0gN1tgn+1XLZAJ70x4gTQmBVsw8HcBOTWS298sLZHgzXXDyrf3TFtD/HfcyBAUvWjwZUcFuBKPatO7tH51Pxy6n07WNmcDVuoNniQBOycYFbrtK8kFVtnTlPQiPJuYPvpYKwMkljFsCdDHDRSj44tVxeWMmOaai/tL3aN94dUTIHwD3Dlp60LPPUr8zSk6ruF7ESCk6LtSHWqbXKPD4dgxUK8lqEEoWAWXw8PmIjuJsOQZVngYFho+GDkOBuatmy7E+Z7RKpV4Nv28Ha++/hodqIbFPOAfOe2x8qcQ28LM8h1bYFWqeEb6iV8AbtZJad9+OtZ2sh3EhjCeeQ9aVfKs8njtKr8mNU8Kce+zVZ/um7xb55zcCfNrO535FK3vjc7lKgNJ9hMcDuZfxhnzcome15hx1+KIuit1L8x78r+AxjuqGpNW3+8GK17fqMhawLIOwwnkYB1w27IUHRi9W9ua42zXo5NogyHmOfenMlQf4WefoI780+idQbf9gYcYyRY2SLh6+MSuSJhDrl2pFB5s72vzxeXw9H4HbHbX6lSQWJDvI1+g+fjp7NyGqQcymXnfcI8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QowwE4GRD/QCoCM5v3fYEnFjz14YIzNyRsyLvG5vrOiWtpjP9p+s3yju7Os4?=
 =?us-ascii?Q?gRK74FMdWyFuLq76Z/2KylE2pcUarCdYHZkxUcW5Lf7KjcZ/YVZIRsPl7/xD?=
 =?us-ascii?Q?eUTkXGbQoZvJVprEMB99GXnPoDgOyH3B1Wbfvw2D+EpdMR+THpvRQ5ZV8c0a?=
 =?us-ascii?Q?Tpr1M8JlalZ5twsMr22YZQ8egXlujkI85T2cozJCDF5I4I9VIJo83P8Z6WYG?=
 =?us-ascii?Q?AiMZ8DS2GTBYsCOyiBCF5hGiuIuTOxn2JaEtk9jCQdBbWANPIfSCuRyemaxf?=
 =?us-ascii?Q?QuX6yCw+zPzCOhAcvy8Kmv84QVK4CZTd4q7bLXRWskdSCABQQCfPHlbBJyTB?=
 =?us-ascii?Q?UaP7dtpSmmIqPi8JrfDtPXRcNNqy7I8gFfGdyPpwwTHiWwJBUZuy7FlArORK?=
 =?us-ascii?Q?3WyovFXP+j+qxXgNTySWDMeq3Cl5M0Ji7YSIKgeVvJSg4cgR7tssD4gbeTJo?=
 =?us-ascii?Q?p61HCPfIYaw9U9uXcu5EeE7ofyGtThhK4DqhNXHxO3p+2oGZJNlGSUuyCe1j?=
 =?us-ascii?Q?heYIrNUdrmadAF8Obj66rMbgr9uof2HtwLDI4QYGnNuGk6eNV0fMqEj6Qswe?=
 =?us-ascii?Q?+HFQhUytrhPI7j5PkXYfu6UamON6/YazhzUgqfEJMASXzbdfnGSSsg2xa4dm?=
 =?us-ascii?Q?pUD1ypI1396ojst7XCDslizlJbE0jsfnPVv1WMaS93nAQnRmr+yN0GBfOCwn?=
 =?us-ascii?Q?hikXgUy/FTKbi7POXhxK/4yXBRqc4xScU+xlYU1UwrFZgEyOKose8HrAdd3b?=
 =?us-ascii?Q?ExSgZBXDGcn4Dlx2BDP0Tx+5XUUcz9YtbuhuH6oRYJ52tDE7/NgMIQ7oE2Kk?=
 =?us-ascii?Q?375nB34JVwWKIbcGwO/crqcnPR3HtdHpjvfukBEiFRIhkfivMY0JO6HUJTlD?=
 =?us-ascii?Q?MBv6lJSaYF6opYqs+bnK8rIvdoNWpOT0ORLr2hqwwNctO286FbYDZvMSmlAL?=
 =?us-ascii?Q?yWlv70/4Th7hp5MlkfHmgLJg6BE0Rr1bvWRqxOtwHFz5dj+PJf+LCXx8TGGg?=
 =?us-ascii?Q?CubbkUsjKV4p8td7MU2cE+1GZOYPPRT/69fNG1hcjJ3DpVhac8DmioMTdCqX?=
 =?us-ascii?Q?A0bHBo1RK+ORi2MNrjWcgFnTqdoJyAxZge/qb9nbPvfL3wLBOsqoQNgHYa5J?=
 =?us-ascii?Q?mY7+fDgj1IV552vchBsa0gSN1+xhKP/oBHId6dihYRpIkjxQbcjRjF7QAV3c?=
 =?us-ascii?Q?wOz8teGq1jYrrNPk0/eOK5zkkuTeoN50DNwuehEUU3IY7uaN32lFNoAQRpNc?=
 =?us-ascii?Q?jozIjt9LCZ6VF12LJ4mKKfW5HfWsVGgP98cPLhH1HjZkCaqJxiIMJ0HJ6QJn?=
 =?us-ascii?Q?nZp9RHjRGQeZQwbABPaFIQbmL5oM84wJti4sANQsZatQvKLwriPruWTIMKfe?=
 =?us-ascii?Q?Bb7rhXpZkWaaqY0SJQdg6D/+04DO0AeicXDfIS9/T5pEAoOFBdi6pZRIvuka?=
 =?us-ascii?Q?xqTctt+FLWKlUO590AsjAaAXI8K3KaC+3CW3Nn4CYG3Fpu+/Nykrq/i32aJG?=
 =?us-ascii?Q?xBu2H5cR1NMUobhEL3aCXmDJ0bsb1Vv3GC9QwhRUk1THogY8+z2ICXk9T0A9?=
 =?us-ascii?Q?C6DM6Kef6wLjXBaBMpskN39rQARpmwuTF+BPE7yg6uDYWEkEEZIle0aifkxR?=
 =?us-ascii?Q?4v/FhHLj4Y6jUQBqAC11uI4Vxmfp3ZSg5J8GSMlTtCElAku0xU0F9ZHzeLfr?=
 =?us-ascii?Q?vKx/WR+VTCawNmvU+pt7gYQTwQMwKjeQTIIc3js4jwzDMWWCnHqX0xBVgwxx?=
 =?us-ascii?Q?lvMwW81h8x8djccCKGMlPS9rNfHTxdmP9BqTB6LlmdyCvc/n1vqYIdrgvtum?=
x-ms-exchange-antispam-messagedata-1: 4xbnIbCKJ96IrQ==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qZ0xXYTOfW+Y+y4Y1jCARtKkuZgyTBWctuN8S7h4kqTl29EhJyQVVbDG68DsJcAFg0/C1evLgCO8I30waYhm6DgCKbQAmWs83kaVcg42X623cwHFy9G29pqYc/UXjt2I1z8bd7+KKRYbKHe2nliIhk88OJdqeew1N0/mHn/FKFTc/9o5UseAc3LGB948YD+EiHXmSF+GVtsaK1KhGjaaauBuDx65Q74v06PhTj2ddwDiOVtG1xFcTUw9RuIzhyYiArVRpZ2is9Lt98u2gFnUM14y6InCoXyJWAXx1A2Kg9WfjdAcYQPKoK0kQyVNnEPWioa/erV1UjbV7tRHHC8WWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cec402f-6cc6-431e-3e32-08de807c56ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:14:25.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nc0pwNWlQSlcCqKjU3kSAQhOKyoBD48qTpS+I8GpPvMc1v51jc2AlvJWyI6Q2gj/Ejg2skptSfwti0QYOR71sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9325
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33164-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F0D45279DCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> =

> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 10/15] wifi: cfg80211: add ingress/egres=
s distance thresholds for FTM

> + * @egress_distancemm: the measurement result of the peer needs
> + *	to be indicated in case the device moves out of this range.
> + *	(units mm, u64). measurement results need to be sent on a burst index
> + *	basis in this case.

Not sure it makes sense to keep reporting results if the device keeps movin=
g away.

> + * @NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the pee=
r needs
> + *	to be indicated in case the device moves into this range.(units mm, u=
64)

Need to add "measurement results need to be sent on a burst index basis in =
this case"
---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


