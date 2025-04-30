Return-Path: <linux-wireless+bounces-22237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940AAA45FC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25CA1BA33FD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50020F063;
	Wed, 30 Apr 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BL0ZryBy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8451EEA46
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003172; cv=fail; b=fL3n0RDpp2B9NdHipjz493wG2+Pqmr1/28Vxz92RN6ho/KIenpqV1jQx/vl7qpao2Egs04l+/rnv6VoNY452RL4kn6A15oq0cBHaJFe4oM5/OjAwS++EVBkU67Z6sqiQa7Hc0R7IbkQqgk4XwggwOULzeN4ywVG2PBoK5BLEDZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003172; c=relaxed/simple;
	bh=FmqwZRIfx1DuIvxxZHrv7p8XTeXf9gueqdHv8+phZUU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sHdXMMtVbDt+KyQd6iRA9Y027zy05a0fQEcxZ2Isvi2cs/JFD1yZpm33jFvYkrsWwPcfMvCBi7W6wbrrZPU5YXwl3hNMPZgzObLCHi5e6qnVpewPcYkOAZu8m62/P6MnM6eSF3llTz9rwbG4vhbJVLsZYiYlMgNhL3by3R/La8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BL0ZryBy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746003170; x=1777539170;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FmqwZRIfx1DuIvxxZHrv7p8XTeXf9gueqdHv8+phZUU=;
  b=BL0ZryByAdXnDA1HQR7Fl3Bnkdinf/svjj0OQeEL7CdzXLS3MXVWldyV
   OAYZdY4A7FOuPy/G/C5KyWJLwr8xxLctSa/if345zX2sRMW569E66woXb
   k1pvEG4nNJOObzEmb2lOV2CkUS1qAvMVVSILeGeXLY+NMYQQqtLyfbgKj
   JEbd2k5ziUv84VXpQ6BOcmcznl7moSWWEYH3tsqrYoY3TKSyM/bpwrSJ4
   8B6ecd5KXH8P/IqhBy3JAHdpF6YcHGN+y1ql2S5N1M4Aq7CZrAHnBRrnS
   rFxKg6mFc5ZUyVXMmhBAh9fHW3dmKg8kA/LvB1mc8jnZf7x/1zmG4cZpk
   w==;
X-CSE-ConnectionGUID: KrEtDW7ERb+TiVs8mUFt7w==
X-CSE-MsgGUID: QUloy+hzTBa6Os45Ij5PCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47536081"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47536081"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:52:50 -0700
X-CSE-ConnectionGUID: PrOlDu9ySLS8qATZ3omMmA==
X-CSE-MsgGUID: hC32AccjQpGkxVAgSXt4Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138877034"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:52:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 01:52:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 01:52:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 01:52:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYJXSHTmpmhWpnLAdLtmSsUetlF3ywiDhy3RCHMVaTscu92/CLedjhGB3g6les6yr31uzjXUKpAptkwUcHqWIB+gg4u4QaN8256xmjdckn6Ntgsp5i4/RCIqvs8xOhcNrgNERSUpibcacGxgVUoMaWJpPKNq7rk/8E20W3rPCwXa83eCX8hYEb2E6yQXhc177qMbMAh2GmXE65+fOZDYk418Hry0DREUT+jJKZ/bx+eTnH9iwCeVzdFAi6dfYUDlWNvQcxopAiUPZdg+lqQXGYHV20KhPYsqLF4S40pLFLDm1xQEbDclNevaFppC9wChGEROhNH5rwmrOSG0iNd+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmqwZRIfx1DuIvxxZHrv7p8XTeXf9gueqdHv8+phZUU=;
 b=dClh3IZjZrZ+RwanNeyWdpvoIcAdVXMOFvxhIcGMy6ktcLB2J1ZdUtO6M70QI2ARtx3UUuBC+gJfPQa5ajNO7nEdaoU0jBLiAkMUoBoluvOHdwqDNQfZ+hLIlY/LS55OVYjH2rq5DSBqan5FsRIFDzHFWIuAqAsea1jwe3WahRrnYvvMF46tRo4L6Zu5SML8gVS5dCaBeu313eOzB9Yv8bjE8iXZdCllxKC5aatupp2ghaU6TycdVKskFaRJAU6kFkKwrUzVB4yPMhO/FEqwbkXDX+SLBgGZPUNinak/YTMVrCLsguW2TYu5snMw2fXoEiKg/Vr3rvA4W+F7O7EiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SN7PR11MB7492.namprd11.prod.outlook.com (2603:10b6:806:347::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 08:52:19 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 08:52:18 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>
Subject: Introducing iwlwifi-next Tree
Thread-Topic: Introducing iwlwifi-next Tree
Thread-Index: Adu5rQw3HRj/VWFgQRWMhOjs14aZHA==
Date: Wed, 30 Apr 2025 08:52:18 +0000
Message-ID: <MW5PR11MB5810F9A009F45F1A58AC0E63A3832@MW5PR11MB5810.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SN7PR11MB7492:EE_
x-ms-office365-filtering-correlation-id: a8c43b0c-315e-4b80-10c2-08dd87c4506f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFQ0c0kvNGNnNVZtcWI3MGo3OXFJd3hCZUd3ZjN4UCsxa1ozQUQxRC9WdkRh?=
 =?utf-8?B?enNBcDQ3dEgzdFJRNmYzbjhBdGFmdjd2blROanN5QTdmOXVibUQrdHRoRWxt?=
 =?utf-8?B?NmFrOGtZMXZiWGNZeEFnZGt5cnVsUm9hS1lOTHVQNGZYS1dDcGRZSWl6M2Ny?=
 =?utf-8?B?WXBaMEdpWWhCVVhSZ0pveGJsZXlJQWhyZ3lYUDh6Ujg1cnMxZlRxUjUrN24r?=
 =?utf-8?B?YjRWV1lXdFV1Y2hvTXgxSlFVN3F2dm1Ya0ZVbWJ4bHN4K3lqalF5MmEwbkpP?=
 =?utf-8?B?ZWVwT1lEMlZqeGhBNWg0c0h5MFphYVlIWk1hTXIrSlQra2x3b1RRdm44Mm1G?=
 =?utf-8?B?M292c1ZvNVFuSE5PdVVkY2RkejBvYzBaY1BGd2JKZ3hLSi9abjBuNC9MeENC?=
 =?utf-8?B?RHRaUE5qb2ZGbzVYWFpRbC9FaWk2YnBGaStBM2Rqcm9lck9hblB3VmlhbGRy?=
 =?utf-8?B?ckRqOGdBY0ZnUHRzR3M1YzAvYVlNU3JnejBpNThqQWJGLzZMNC9yVm1iUzdZ?=
 =?utf-8?B?dS9wOEFReUxZUEw5YjFjOGdmamtmRTZIYU1sbkhDeFZ2YzF0dW5qRlRBTk5Q?=
 =?utf-8?B?LzZLMWpHQzAxWjNzd1plMmVjOFpVNFV5NzE2cEt3emlvSzI1cnR6dUF0RFdJ?=
 =?utf-8?B?b0I0N25SMWxORmNBZ3JZSUw3RDlVK1IrWkhMR3pYdTR2R2hLQmNoWSthUkxI?=
 =?utf-8?B?QUhZYVZhRUJrYWJiYVl5VXVPRHc2WktoendvVDEyRnVjM2YzMk56VEM5bmFv?=
 =?utf-8?B?dkdicmhyMFNCQWFkOGo4N2d0anNTZFRxMGk2U2gzVFJXbHA0Rkw4Mit3TVJ3?=
 =?utf-8?B?SU90TGtUOGNnemF4ZFdyZHJ4WXQ2Wk92cm5kcGR3K3lrY0E4VmpQWGU3cDgx?=
 =?utf-8?B?MlV3Zi9BSkF2QUJCeXpCbE44Y1k5Q3JURm1VdHdvRUErODdFclkrYzErbFNE?=
 =?utf-8?B?OVpGWCtTM05PUENSWEd6aWRUUGxjRWhmc1A2dS9tZlZvelJyVkRQNnVscjQ1?=
 =?utf-8?B?eEZnemdHZjJ2OG9sNkJVZXRVaGdtVXFmSkppU3ozZmxpQkUwVDNIYlFyZVJr?=
 =?utf-8?B?QzJWL2ZybU9iaEM5MFRkcmFUOGZzZVZMaHU0SDJybVJQWjh5YXkxY29GVHNu?=
 =?utf-8?B?V2d4dDUza1FpV2hrbUR0dEZsK1lnZWV3UVpkTEdkTVNheXNSWjA1VWVjUUcv?=
 =?utf-8?B?Sm5Kb0RWbWFIYzFacXNGNzhiK3NXNFhDZkhmakl4Z1FkRk1rbzluZTBpb2pi?=
 =?utf-8?B?UGEzK1VZOFIrWnplaWMvMlhMbXJaUlRlTndDRXo2aktreGVFQTdscG9uWEZv?=
 =?utf-8?B?UTJxMGdhOTNjQWpWNmhVYzUrTXNUMVhWMGZQbEVkaWVXQVJMTU5PZjNUdmlv?=
 =?utf-8?B?WHp6RU1lblBUNGdoc0l5KzdiNVp0dm5ITUc1d3pWM2hBVXJ5ZHp6eThtMzh3?=
 =?utf-8?B?bCtqT0pSaXlOSUVRT0FCRzVoN29PeUZQTkc4Um1FSVdaL0VZTDNyNFdxSU00?=
 =?utf-8?B?RzVpR1NOTU03K0NNRXZZSVEwREwwbTlhT2N5a2dBUHdaeURuTDdaM3k2VW5s?=
 =?utf-8?B?aldvRCtjSkQxSkF6UmUwRE5UN0N6VFh3b0JpdVRJNlRLYnZoc1VINmFiNVF5?=
 =?utf-8?B?L2luSlJDOHhqMml1ckFlSlY1ay9HYWJ0RmY5RVR6Y0VlK2FMSlEwVGJVSWc2?=
 =?utf-8?B?QVdrbXpEZFdKVkxrVCtRdlNCNUlENCt0Z0wraGxhVmVsZ2JOdGZtb3NuWllG?=
 =?utf-8?B?NmZ2V1A1aEhSazVqdnRSUUtqNTZDODFQckkwU0Y0WTAvZHg0cEdkSncrKzVo?=
 =?utf-8?B?MTZHUkdnSm00Q1lRYkxNclNmYVI2MFNNU2NqRXlwTFVWajBvcDRDaCt1d2Fj?=
 =?utf-8?B?b3NPa2RkWDFWRUsxYzdTWGpNT3ozWTNPbFZuSjl0OENsUUw2T1F4aEpIY09N?=
 =?utf-8?B?eWJIYjVUS0lhaGVsd2lkZnlId013dHV2YmtHTDdGdVJQcmEzUml5UDYzVmtZ?=
 =?utf-8?B?SnVvUFVteDJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZpVlZ0U0ltQ3ZiYlU1SmViNVp0Nm1wdXNUdkNvd1Zmc2U3YnltMWRqd2dr?=
 =?utf-8?B?SW9tT0d4SU5aVEtKMEcrcm9LU0swcTJPeE9wTDRvSWVxWktXWTVJdzZmdFky?=
 =?utf-8?B?MUV2UVBXMWxQd2hValdpZ0xZSzY1MHRyQnpsVC83MlFhTUZtWUdhRlhnclkr?=
 =?utf-8?B?ZUo1byt3MlpTRUdKeGRjRFBDbXQzeWoycVlnWTA0ajloZXo1R2VHZGR0SmZP?=
 =?utf-8?B?UW5sK3MzeUx5S3BvTlpBSFcwM1gvMDJhblJERHgwYmg5NXNINnU3b3RVZjEy?=
 =?utf-8?B?YUkra0UzR0tpdHp5QmF0VWx6blY1NzdTQUpoVGUvc2RlWGpTYlptYU1UU0N6?=
 =?utf-8?B?T3l5MFB3cEp0a1JTK0hQbTFPeTk4U2s3cGI3cExld3V1d1ltc0E1QkVReWdY?=
 =?utf-8?B?SFhWV0Z4Wkh5TUR0NU9rZWRockJ0NWI5ejRkZHFJckJETmVFcXlBUVk1YVJk?=
 =?utf-8?B?bFJCVWl2S2lpYlJUbDlVb1pFcHBqdXo1dDl6ZEROcFhGT2JRSGhMbXVIWFNS?=
 =?utf-8?B?Z0YxN3R6TkdISlFOc244N0NMcElXajFkTmJVWjZVckloMUl3OGsrRVdIMHRC?=
 =?utf-8?B?VXMrdnhkTXFQYmxYdmNCREp3eW45WXk2cU10a2pOQ3ZOS0Y1bnI4bzFYSjV5?=
 =?utf-8?B?aUhlUmZkZ0xHZyttQ1JRZGVNbStTM0NoM2JIYytNNDlxWndNbzhMcnNHOEdw?=
 =?utf-8?B?SHk1NlNKYVNMV2hIZGMrTFJ1TENIanRqdTY3QmswZXRSZzNlekszY1lhQ09R?=
 =?utf-8?B?UlNhdU1nZ0JvUmZncW1wVlU0WnRrUVhXVjRZcU0yUlQwZDBidEllTzIrb0p0?=
 =?utf-8?B?RmtFSnVNQy9sVHd4MVgxRVppc0RPSHZuTjJnVW5NREJySURLZithUDJxMTJZ?=
 =?utf-8?B?YTltMmVyVnMzdStXWlJhdHM1b0srQ09kbXk1aFB0UC9XYkxZME0xandDTkNq?=
 =?utf-8?B?dGwxa3BubWFiQXhVR05KTXpXa1JPeUJCZlJuKzYyMENaTXJwQWw1bUp5ZVht?=
 =?utf-8?B?WFlza09rclBWQmo4dzE4RHFjdzU1THFLOGdJdzkwVU8yUTVGdHlqRjczdkdP?=
 =?utf-8?B?MVgyRlRsQnJwMUMxSTJLSkVRa1BocFVIQkpVb0dUbVZ1VGhvT29MNDJidnlL?=
 =?utf-8?B?cy9wUkZ1TVV4THlYRzc1RjZDM05JcFIrSW15bGFoNlVQb1NRemZzMlhtaUI0?=
 =?utf-8?B?YW9nQ3VUZ3RtTEQ2eUkyaVE3ZVlHUnJYRGNWaXVSaFJaUHE3aEIxZkYzeVov?=
 =?utf-8?B?SXVjYkRyelp0aW5nRVRDRlAyWk1oQWlpdTl5MjYzYUtNeDgwOVE4bzRmcmxn?=
 =?utf-8?B?QUlwS2MxS00zcnBnaVpkalpFcnBTR2ErUXdrSUQ5K1IycEI0ZTF3b1ZVRE9R?=
 =?utf-8?B?T1VmNnN5WHlLRGRSWW9lMGF4djdzanJsd2pIdlVqeGQ3aGZ5V2ROK3FPcmtp?=
 =?utf-8?B?M0Z2THJGalBKWWZzZVJxc0RFbHR4SC85U1hTNXFNd0NNa21mRmVKUERCT2Za?=
 =?utf-8?B?WVZYSWQ5MlAyNXZ2WDBiNUNoWXJhU05CTnpYaUx1NThJU0lWWSs3N1FzZGZR?=
 =?utf-8?B?VElBZFpFWCsrdXRrbW5EbXF2QlhIWTlqZEpYR1dLQ3RIWXo3Z2FXK1R1VUxn?=
 =?utf-8?B?cnVwc3hQQURZMUx4cjFsbjVEZjdVVGRhRW5wNXpaN0tjUEp3Z3hYcjFzRVdr?=
 =?utf-8?B?ZzNCaVdtVWFyYW5NeGNJQVovNUFIcFZKaFZFemVUdHk0UUJlQ2V5QlJnb1gr?=
 =?utf-8?B?cFhiYXZyVnBveWZwQ0cwNnNhdWVsVVF0WXdWcDA4VlJMOXlnSHd4L2QzbUFo?=
 =?utf-8?B?emJFRFJTdEN0d1p6cE1GcEVwQW9sRkhlcmk5VHNGNkR1MDNZSnVIRjR6ak5X?=
 =?utf-8?B?TjVibzZ5enN4SldTT3hFcFZ4VXl0a1BRS3VheVVVQkN5VHZyVERrRFR1Rzl4?=
 =?utf-8?B?Q0NyWktrMWx0bktaZXMrRWJpamdKUFI0UEI1Tm5jeStZZFRMSkNkMTBqb0g4?=
 =?utf-8?B?aXFMMGhHeExxYkt1bFJuZlVsL1IyY0V3V3o4WkUwV2diTUx0VzMzbGcrRDdE?=
 =?utf-8?B?Mjhwd1Ara0V0Z2pCaTkxdFV5bjZVY3BPQ2RWZVFydXQ0ZDJrNC9KK2Y3aHcx?=
 =?utf-8?B?VCthSG5HYW5UaEk5Mk1VU3FxdUN2NEhrNjBvak1uN1hkZDg2NDNteXlvYmN5?=
 =?utf-8?B?Z0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c43b0c-315e-4b80-10c2-08dd87c4506f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 08:52:18.4688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6MErcE9YjPNH2I1DWgnjBn+XJQMhdGuKJUvU8RicWrcZoDBja7fb7gNBJiI2gBCwbCv06gTAtWQsJrLRPPWOpOCL8DetmC12h08wG4y2hFZSut4W8iQFVOMJe2cjR/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7492
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgaXMgdG8gaW5mb3JtIHlvdSB0aGF0IGEgZGVkaWNhdGVkIHRyZWUsIGl3bHdp
ZmktbmV4dCwgd2lsbCBiZSB1c2VkIGdvaW5nIGZvcndhcmQgZm9yIGRldmVsb3BtZW50Lg0KKGlu
c3RlYWQgb2Ygd2lyZWxlc3Mvd2lyZWxlc3MtbmV4dCkNCg0KVGhlIHRyZWUgd2lsbCBoYXZlIDIg
YnJhbmNoZXM6DQoxLiBmaXhlcyDigJMgb25seSB1cmdlbnQgZml4IHRoYXQgbmVlZHMgdG8gZ28g
dG8gd2lyZWxlc3MuDQogICAgIFBhdGNoZXMgZm9yIHRoaXMgYnJhbmNoIHNob3VsZCBiZSBzZW50
IHdpdGggW1BBVENIIGl3bHdpZmktZml4ZXNdIGluIHRoZSBzdWJqZWN0DQoyLiBuZXh0IOKAkyBh
bGwgdGhlIG90aGVyIHBhdGNoZXMuDQogICAgUGF0Y2hlcyBmb3IgdGhpcyBicmFuY2ggc2hvdWxk
IGJlIHNlbnQgd2l0aCBbUEFUQ0ggaXdsd2lmaS1uZXh0XSBpbiB0aGUgc3ViamVjdA0KDQpUaGFu
a3MsDQpNaXJpDQo=

