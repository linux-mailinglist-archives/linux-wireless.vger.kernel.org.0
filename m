Return-Path: <linux-wireless+bounces-29109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D1C6B8B1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 21:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3176D3526B1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C275285CB2;
	Tue, 18 Nov 2025 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwjshZPO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FF2DFA40
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496937; cv=fail; b=qwxjU33w4sDpWlMl7DLIalUNAwNQRNBApVH0v8W/zOJM2tW4yqpYDvSoBXFWMc3c+44M5yFP9v0NbeNY9Ck4JWgfLkY0Nzb9otUyQrwOzdWzFq3e6/gdFQfJhnwtlqypsp1LPekrb+WAdslq8hfkuqLEaLEsJbsvLtidMlg5wd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496937; c=relaxed/simple;
	bh=y0BhEQ53P5cGrP8J+AB6sOyEMFJoc7Vw63/vI+8XayY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gBqV0WIqve1te9z1jt/StXc7k+qck/Zfmqr3kw3yMgMt33MnPXKLJovnRgINgVkbvuJjcNQ29KB19kAn3WHFdWx+Acpj0DKVA4aLBOQANi40woYQBlAcNDuQyMmgDsbBH0dXbuaK8iBa/lsByatrKn+t4Zd+/Eua/ALybc4tsoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwjshZPO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763496935; x=1795032935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y0BhEQ53P5cGrP8J+AB6sOyEMFJoc7Vw63/vI+8XayY=;
  b=gwjshZPOHDLR2H6NXxhdZI8JKJMQKAudPRbZzCeWblMnvSZkRXP04Tp3
   ZiRPgmahAFuSVSHQFweYw9v+vTpsbqj1++KSyZxsc30C19HOpPGf0i/5V
   PbeQd2kYQoCkx/Ug0GuJuJyAoNV40CX7zzZOU4qG1s6dTT4+akV8x+iMo
   xMvHw/QO2VfF1BoxAxUvmNMFNwHhpmzIv4KsBZNtJWvIzH5jd32hPIyTL
   l4iRwUoi17fvtMMHA5jiRPTFsyouBg/vEDxbCLW/TyKgKIHH6XyyVuJlk
   YQnYludshde5bGR4fIHJ3u0eGVDL2KBvHYes+mt5JxffzkuLT2c1W9jTJ
   g==;
X-CSE-ConnectionGUID: 4xQ/4c8BRyivEVCfCFzw+g==
X-CSE-MsgGUID: R0e5esnPRmGCltUr+CpRZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76141674"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76141674"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:15:34 -0800
X-CSE-ConnectionGUID: 1EtKlID9Qj6BEMp/5F5v+w==
X-CSE-MsgGUID: E6Kw4PSgRNW7EDr0DyXQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190887448"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:15:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 12:15:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 12:15:33 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 12:15:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgC0K1FxmqYrse2dLbWEigL4JBDP7eat0fSLRopcbW+Lxs8948UYWUSYmDN2E/4xVVKTAYBnKmrVU9MvRfG8i2qh1fmahrYziQTQLsQUNyuvyhD7HhK2gw69izdHNR7scHSSoeAmHeRDQO7dmVw5S3LFDNTT4gEnnxOyGHszLkxHXxnTgnyDBq+abiA4rjbR7EmQyx/lE+CiwfcezTjP+HMMRfEHUFFJfMgA7bRFIe3yWvciWvWF7meFd0743xb+F/yNYjvqDhrH2NtJPP297IHPU2FWoeM0as5q2vQRQcH6+v1x4URElRgIJGDggzgrOMxByodUZJIyCUuoVBVluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0BhEQ53P5cGrP8J+AB6sOyEMFJoc7Vw63/vI+8XayY=;
 b=PjZPNBwsz0dcS/qcbK7GoBa43/MS7uZCzsSDKdgolL683k15AAbyGXQlqPPFphpPv/Al7rw9BeLJc0vtWpWX4GAZTDTrRaabjlQgZERX3+tsz6Nad0lKwFktyM2U8Jp6wpRNhrCAACm6NIGuNxdMRqnBSy+42ANOPmpapmDIPlRP7sI1JkXJYwOK6JAFDgT6MypaOzyrVmQExErLy+8VjCABQVT3NO00GLHrjnpwv8fLudoOsoVJiv6ExXzZidlEtY219B2AFzGJVlJPcclRD8jl2hBDkoMBNqs4KkCcAcVSnzoQqhdVo4cd51tHLtZiaFxvkxGXaEzupaS3DhaLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM3PPF195D11F0C.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f0c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 20:15:31 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%8]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 20:15:31 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ally Heev <allyheev@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Dan
 Carpenter" <dan.carpenter@linaro.org>
Subject: RE: [PATCH iwlwifi-next v3] wifi: iwlwifi: fix uninitialized pointers
 with free attribute
Thread-Topic: [PATCH iwlwifi-next v3] wifi: iwlwifi: fix uninitialized
 pointers with free attribute
Thread-Index: AQHcUuJk+q5VR/BuhUedH4g9Twd1JLT46dvA
Date: Tue, 18 Nov 2025 20:15:31 +0000
Message-ID: <DM3PPF63A6024A9184DD38E41273FC35C7DA3D6A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251111-aheev-uninitialized-free-attr-wireless-v3-1-26e889d0e7ee@gmail.com>
In-Reply-To: <20251111-aheev-uninitialized-free-attr-wireless-v3-1-26e889d0e7ee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM3PPF195D11F0C:EE_
x-ms-office365-filtering-correlation-id: 9fcfe9c7-793f-4af7-e8b1-08de26df3931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MXpjOGVxVkd5ck5Tc3U0a3lXVVpVd3FYaDZKSURCKzhkMDJDZVZnVzJHL1Na?=
 =?utf-8?B?aUdUQWVTcjlBU3A1NWoxNmgxSlRsRzJWVlg5S2ZBaEIzUnNIcWJXajMyamhH?=
 =?utf-8?B?M3dGMUpBNWlSVkpaK08zMHFGVHJQNVFBc0grNzRlM3BDZ3BKR1NUU09vdnBK?=
 =?utf-8?B?UklYczlMWFhQMXVOMU13bU5Hb3owQTAvUWN2RkVBUE5YVGlyQkNhcHNGM2Fm?=
 =?utf-8?B?ZlpQUFdKdXUxbTN6eVFuSU1aZXdKc0JrVk1yZUpIZFVOVFVtREtoeWZPWjRO?=
 =?utf-8?B?ZHFLdGRvMG81dXkwNVdVbENsZytLUzNLRXMzRWxCUTRzOFpZR0gwSVVROEVE?=
 =?utf-8?B?dXgrY3QvWDgreVVrYXlQd25JS25qQ0J0cG5rV3VoOS8wemZaZzZVbjhTa3RL?=
 =?utf-8?B?VXJqTVJWR2tNQ0dvVTliQUcyYWgyc2t5ak1jTHlwbWoxTUNKUlFaOUhPQTI4?=
 =?utf-8?B?cmdSUkVMS0trWmdFUzJzMk9FZjNpblVIRlZzR2xvSVpxMUxsaVBVSjlRVVln?=
 =?utf-8?B?dmRXcURhQi9MV3NvYjVIZjdGWGZQb2NFVklSaEJIMkRWaW1udElHQUNGSDgr?=
 =?utf-8?B?cGV2RENIc1ppUmt4T3dqMkdjY1RXby8yR3lncVNROWFlNUJvV0k3eVpkeWNS?=
 =?utf-8?B?WUZReG1sYm1LYitDQWEwZEVaSm0xb1ZlRmgwalJuQWdmS2FWM3dmbEt4Wll1?=
 =?utf-8?B?QXB5QUJuTEJaNEFRSFp1VkRoZ3psQUdVanIrNnRQenExUE53SHBkMC9KblpG?=
 =?utf-8?B?ang2VnJoMys4SEZ3RHp1SFh6R0ZmcTlTc1BYZ2RJTDZYWFlsdnI1bjBrYnFj?=
 =?utf-8?B?VXFvZmxlZzdXNXNFRGhuRndzRjZ4YnF4Ymh4QjRKdmxMMXR1cVd0eWpuNUdE?=
 =?utf-8?B?QlkyQ20xSkpTYjM5RFZxYWxxRWVKcFU5MmFnRVhYenhKUlMraFNPVWxBOFR4?=
 =?utf-8?B?K2dHN0NZMGlqdWNwU2I2RWxLUHBFYURRMnU3UVFPTzl5UFliQVN2SVZKV2Nm?=
 =?utf-8?B?ZkJCMnNDanNEd2R5OUsvZE1kUEdWU1NjQldOSjFyZko0Y3BISFdieDk0aDJU?=
 =?utf-8?B?WHRRajl3b1Nod1hLbGViS29qcE1sU2o5MjRnYUU2UUZ0RkNmL1haR2lXWUFW?=
 =?utf-8?B?VTIzViszMWsvWXpDazVkR1llemJScEJlb2pXSzc2ZFpEUWlJU0pxeEYrVjB3?=
 =?utf-8?B?eGwzTHZjeTdQTUh2TTJHMG9oaFNYRmY4bngwUE1FSitubU1xbi9YVmEyTlha?=
 =?utf-8?B?RXRRQnovaWtzaW5ZTHdKZzdOU09RdXp3Vk02dVJBa05sV1RKUlhQMk0wMXl6?=
 =?utf-8?B?K1kwVm9lR0ZEdFF2TkRNV25xVjlFU0tMS2UxaGtFMytvSnhrTUwwZm95eHJK?=
 =?utf-8?B?cEhVTW55Sld3aE1TQ2YrNE5rL09Da1lzQ2VXcmVWd0lzYVBxOUdpSytoM3pT?=
 =?utf-8?B?MDNWbVFYc3Qrd2tQeGVBb29QN0N0N2NBQmdmdUdPM28zU0t0bVlpZlVXR0Fq?=
 =?utf-8?B?Vkd1RFhOVVFtaUwvMjlkWWpTWTkxRGxJMTdoSmMyL3UyVnlLblM4SkRKZHJj?=
 =?utf-8?B?TXVsM3NGUHhiMjNCZUlCVEYzSFl4enpCdmgxOHZlM3hNdDRjbUVVR0ZsSDV1?=
 =?utf-8?B?cmtoK2pveFNva1MwR0crTHFSV281WXVwT2p6TmpIaHZvYnN3bVFqRkJoQ203?=
 =?utf-8?B?bGhnMm5zai8xbHZPT0V3SU1JRytKUG8ydVFaekluNTZncU5Sd0pnVCtORkxD?=
 =?utf-8?B?cHJuY2lsNXNZMXVDUFQrak5ZNGIyVEtFU24vWVVTU3pydnVzZnNNNlpLN1ZE?=
 =?utf-8?B?dmlPbk41V1gyeGtrTHZyTW04WUZMOHpRUUN3UWxWeGJIcUZSeUtvSFhlOS9T?=
 =?utf-8?B?dWtjcU1IU0VReG1RZVpIVksxMEFsRHViSkNtbThKUlZtcU82SWJKaW1sbmxq?=
 =?utf-8?B?U3NwS0x1K3VzY2FVNXlwUTFYTmpTaUl0Qm5uZnVCWlFpanVyL3FQZ0V3dkxy?=
 =?utf-8?B?RVdyUTFuRDJKVm92bGF5SGdzNWNGekM2Z2xvNHNkcnN0Vkx2ZVNIWHhsZk45?=
 =?utf-8?Q?hfsAno?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDMzQ1JubUNFYytLdnJhM2dMLzIvaXEwM2loNVk2eTJyZDFiaWQxcGczS3hJ?=
 =?utf-8?B?VHBwUTYrdHQ5Zm01ekVPL2paMm5TbWJhVTFoSUdrUkRuYkpZU2VYazdGVFlM?=
 =?utf-8?B?SFRGNUhwbHZMWUhaeHptZ0JzUHdLYTJneDZtWENQMVlNSkJCOWhJVTNXZmlW?=
 =?utf-8?B?cHVZTGI0cm1Vd3JTemN0ekJRWVkrTitBem91S2NWYW1uTW5EdnVHb3Q0S0Jr?=
 =?utf-8?B?NEpuY09tdnQzdlR6d05FZ0hINW5DNld4SjlCSFRhVnJSL0NSbnFVT1JzdDlT?=
 =?utf-8?B?Sm5XeUdwNHdKRTh3Q3V1UHIzTGtsaHdzWUEzbjhReDQ0QmdBK1QzNGl6M0l2?=
 =?utf-8?B?UDNHcG5DcHM0Y1lqYUdFcG5qNVJrQld4dmQxQ09md2NEU3VOc0dEL045dGJT?=
 =?utf-8?B?cEZiTHJOazY4WHMzK2s1Ukt1UGJpWkF0SVRodWNTSDc3VlA2RDQzZzhhRnhn?=
 =?utf-8?B?T2dCeXpicFVpL1B5Zkc3U1NXOTJ3MXJuVlJsSGxBWTM5azRHK2d3MW1MY01u?=
 =?utf-8?B?RHhYc0lweDVqYlZHcGZjSmZHejVyVFJPMGkzNG1nZFpjcE9zTWhWMzBnbno4?=
 =?utf-8?B?dE5xYkpaa211UkF5cm1Takk5aFVuM1ZsK1dQZDhXWElXRExiaW51VC9nNkM4?=
 =?utf-8?B?M3lhaDhvNmQzYjJ6TkwzYzJ2YktsZ1BpNkJncE4xb3pyNENPZFhmY3k1aXR5?=
 =?utf-8?B?UmtOQlBjUlI2UklRa2NZeDEwRC9NMzAxS1pPK3Z3NXNzRzdDYmVDZm9vSkJN?=
 =?utf-8?B?ZXVXVUREY0tLQUZDeEplV01TVWx1YjRuSTVNRDJaMC82bUJWTjdqSWlIY0pR?=
 =?utf-8?B?R0xjMmRsTW9nUUdGS2p0UDEraitTL3cyc3FTUEg3Z1I2VzJ2bjBiUG5hNDA0?=
 =?utf-8?B?WUx6TVhMdzIzTHlwOU52aFVNOXlzQll2bTYrWUlxdGZtK1E1c1NxMjdTNmY5?=
 =?utf-8?B?bEhybnd4MW13Z1ZCUHJTN1dpTnRQNCtFZnUxQ2VOT1d6ZVk0VnZyN1RVZ3Y1?=
 =?utf-8?B?N2xlYjYrU3J5dWFQVlJqTWpwdzdwdTZMOFpGZ2srNkdzaWN6K25XZWZ2aTNR?=
 =?utf-8?B?VTVPRmladGwwekZ2QWx3VEVzTDd4VUhXQk5FWTBFSTNEcnk4eXdFZDVjd005?=
 =?utf-8?B?cGt0YlR4TS8xMk44bkhrbnROaGRKSVk1cm5JcjZ4VVZKY0FqZ2RQYVRQUDcz?=
 =?utf-8?B?dzZiRkxHaGpZYkI2QVZSbnNIR1VoY1JXTTl0ZkVBR0R4TnBjKzZRMHdXZWc5?=
 =?utf-8?B?aGR2akRjOEtYaE96Zm4xWFl4UTJORHVnemhaUlBkcG5wNFBPV1duN2dRak0r?=
 =?utf-8?B?eDFBWWpWeG1ZTG40Y3FWcmlZa0FOK0pPL2wvemVLZ2pWZ2JZaVVCM0RUTDlq?=
 =?utf-8?B?K0QzNWZDY0xKZTZLcHFyRWI3MzVqN2JGSldGcDhBQW9oVW0xSThNcnNFZkF4?=
 =?utf-8?B?aU43ZUs3QXlZRmVLdGdQait1OUtQRmIwZlRRYklRMHVJdm5TcVQ1Z1hhSVFi?=
 =?utf-8?B?NlhabzY4MlpIMjZOYlEzM1VHenExdGM4Qk9LeU1JMXQ2M1dWVjlXTis1a1hy?=
 =?utf-8?B?d2pPYkVDd0w0N01nUDhxTmQxRnJZN0x0a0tubXVVNFFmUlVMUFI5Q09yc1Jo?=
 =?utf-8?B?VXNiMjJuTlZOSEcvdU02NytVNWdVaHJXQlRSbXdPajJYNVR3YytDckpKZzBq?=
 =?utf-8?B?NkcwSlMzWk1YRVNqd3RDbW9PVXlHMUltLzdhRVZlY1RPZjdMckF6TzdsaU1m?=
 =?utf-8?B?QlllRHFMeUttWTNFcmhxclIxZVNnWXo2RHFvVHloQU51c3h4ZGI4QjdzYW9v?=
 =?utf-8?B?dUE5Q2RaOXZtR3d2Z2FYa2VMTkt4UUlPMUVrOTFXOE5LTUJDZnVhYnFYeDBl?=
 =?utf-8?B?bjFXU1pJaEMyWXFPelFFdlpRUU9qV3RlY3RzM3EwRTk1dC9CZ05zSklSbDA1?=
 =?utf-8?B?RXY0cDMrYUhxNy9RMXI2QUdLeTNFdE5CSU4zUFo4dXNqZGRIL0R3YUZFMTRV?=
 =?utf-8?B?QXJsZUdWUW9TVDhkbmN6K21sT3R2RUNZK2xsa1l5L21Mc041WXdERzRHMUpN?=
 =?utf-8?B?SVp3bittNFdGTzNNbXFIU2F0d0FRM2c3ME9oZGxFZTZBbWhoSWF1cTR6eEFv?=
 =?utf-8?B?d0p4d3hOUXg0SFZaYUR5L0VyVkkwNnd2M2IvWHpwMU5ieHNhNE1pNy9zbE5j?=
 =?utf-8?B?aGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcfe9c7-793f-4af7-e8b1-08de26df3931
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 20:15:31.2113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIEt0XgWNBaGBEAUvAGHRVHnHWgww+UPUwQmbU3dNbIamCtmw4V4bwNSg7rY82H4ypi/DfJZPNi1PMK+ydKJmpxKadzoDPCzL8WwnlKo8mdnwoqkSltC2G0Hex2Dmdyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF195D11F0C
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxseSBIZWV2IDxhbGx5
aGVldkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDExLCAyMDI1IDEwOjA4
IEFNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5i
bGl0QGludGVsLmNvbT4NCj4gQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9u
cy5uZXQ+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz47
IEFsbHkNCj4gSGVldiA8YWxseWhlZXZAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXds
d2lmaS1uZXh0IHYzXSB3aWZpOiBpd2x3aWZpOiBmaXggdW5pbml0aWFsaXplZCBwb2ludGVycyB3
aXRoIGZyZWUNCj4gYXR0cmlidXRlDQo+IA0KPiBVbmluaXRpYWxpemVkIHBvaW50ZXJzIHdpdGgg
YF9fZnJlZWAgYXR0cmlidXRlIGNhbiBjYXVzZSB1bmRlZmluZWQgYmVoYXZpb3IgYXMgdGhlDQo+
IG1lbW9yeSBhc3NpZ25lZCByYW5kb21seSB0byB0aGUgcG9pbnRlciBpcyBmcmVlZCBhdXRvbWF0
aWNhbGx5IHdoZW4gdGhlIHBvaW50ZXINCj4gZ29lcyBvdXQgb2Ygc2NvcGUuDQo+IA0KPiBJdCBp
cyBiZXR0ZXIgdG8gaW5pdGlhbGl6ZSBhbmQgYXNzaWduIHBvaW50ZXJzIHdpdGggYF9fZnJlZWAg
YXR0cmlidXRlIGluIG9uZSBzdGF0ZW1lbnQNCj4gdG8gZW5zdXJlIHByb3BlciBzY29wZS1iYXNl
ZCBjbGVhbnVwDQoNCkFzIHRoaXMgaXMgbm93IGluIGRpc2N1c3Npb24gKGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvNThmZDQ3OGY0MDhhMzRiNTc4ZWU4ZDk0OWM1YzRiNGRhNGQ0ZjQxZC5j
YW1lbEBIYW5zZW5QYXJ0bmVyc2hpcC5jb20vKQ0KSSB3aWxsIG5vdCBhcHBseSBpdCBmb3IgdGhl
IHRpbWUgYmVpbmcuDQoNCk1pcmkNCg0K

