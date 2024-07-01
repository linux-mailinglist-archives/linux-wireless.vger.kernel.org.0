Return-Path: <linux-wireless+bounces-9758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B4691DBA6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818B51C2103D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9F384D12;
	Mon,  1 Jul 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQ/Gs9Jm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B01524C9
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826868; cv=fail; b=Uci0agZGoMqJsfHJ66EDOzRfIKJHgSuD2ttRjggFs6Apr3d6Gk4SRANMMbY2Ufnl2uBUIY8rW+UvNFYVjs+ulqVWR97XpY6nT+4+kL29I1IlOtNGl9V6PtW51b2x5REd9jbYzfUS2ONXppwRqg+Ur1lq/9yXGPOSTER+ow86MeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826868; c=relaxed/simple;
	bh=O1S2zj53YHWv2HXpNe4DoIgErnH6naK27Qc/IqwubUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/Fn/lPGquCQ5oVlJk6Nd4BL9oAc1u9a5QnOyEK6LkLQd11gdmpzo42k212UawUUsDeTIGGO1g6rq3QJyrBipBELbPy7/pPhKIK6ga5i0TiRrmCw3ritvXtFJJ1DwJfSAivHqgFXwGbx76r3beN6jSphQfoxppmlbOo0U5FB01A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQ/Gs9Jm; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719826865; x=1751362865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O1S2zj53YHWv2HXpNe4DoIgErnH6naK27Qc/IqwubUo=;
  b=IQ/Gs9JmB/+078nwGInmCdO0Co9q955mgkYu8HWGsBUfDpaB6awrFN6f
   Av2JgAogxY0/UKd8QHjieDFAbNlbzJq8jBcSez+HjQGArg41lNt4WcggJ
   5HtmLSEWGGjSJ7Q+IjSF8WeKoaOHyVvTtlaTBFpLiSQNTn/8WQEekdtHA
   ylKsXNU/8qkkw6/tqsUzdFqkq3ddzjpMFZ4fYocf8YxRJ5bwYyhO9/ijy
   f1h8eoHU68+SfVPRmAj8M/Y3J6yWr0JCQpNonIX7a6HFBvLBGyhDXMNBo
   3YsQiRwZdR5QSOztyiXgZitauCnXdEeJ0XnWTKeEa7fK0Sep972eeVb3N
   w==;
X-CSE-ConnectionGUID: ospksaihR/24LWspDKKCFg==
X-CSE-MsgGUID: QDxvhR5RSGm6BxZyZ7QpmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="20812796"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="20812796"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:41:05 -0700
X-CSE-ConnectionGUID: Dgk4kTe0Sg2c6A7H6OP7VQ==
X-CSE-MsgGUID: NqKpd2hcT1q/Z0NCmSBx2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45547014"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 02:41:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 02:41:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 02:41:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 02:41:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 02:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ8Jaq0R6SA8wRF0404crpaOkeW+JO8uC47E3i9U0FWj6eZq86ronEf8StQB5QlTjIjdF935OhCY8INkZkIGUa2Tx9L+3NvKMWbUlioEzP8T3orWWuXeEnfLFrHSvNAQs39Wsnkbo34eTrMXLrKj9pA1mhf+Wh55k8eBL4wBacPTVmK1c5rrhkzuWucfeLEf2K+wggSbJ6CnAzkMlqCTNrKH7l46nSycihSMnlN4xVHFLhoFkOdIazR7oN5FOKEp/qaJz2g4O80GrusHcjB3oCkKpu27isFFtVL5S+EIVzh4zHrFQmRA7KhirmeIjyqGR0Vs/H+9cmagG1NXfYs7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1S2zj53YHWv2HXpNe4DoIgErnH6naK27Qc/IqwubUo=;
 b=hO3OaXRxf3MwAV8sRTJDi3F9rwIwGm7jXtcN9+JQvaUR6gCenPv4f39S+kMDqbZH/UyBbBPOc7Hy/+jTx0oekg4Bohwi+TdcgpY6hd3JP6pHEwtIQE/mToO9d6KkaEoGasAX1MRuUhgqXYzL1VSEZFI1o/tFGjYGhgVsVIyVfx7CyGXSSGg7n5urlmaK6DhWOtb5T+WVX61/wwHF/62J5o2W+ujYXM4v1b5PrSIra2E8UXg3JV/HfpiHzT+7hoXHsLyeuZlPgTbdR+JkW+jiz5Vmd1I3q7MGgkzT3fIZH1lQbQ3G+mdMZZ6m0OXQVpHXTqjQ7/Z/+YujYdYiWTV60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 09:40:59 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1%7]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 09:40:59 +0000
From: "Peer, Ilan" <ilan.peer@intel.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Berg,
 Johannes" <johannes.berg@intel.com>
Subject: RE: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
Thread-Topic: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
Thread-Index: AQHatzc0yb7T+43A3kaSl/T1R0ONJLG6eZjcgASS/ACABU2ww4AGL7cQgAxxr8eACsmpMA==
Date: Mon, 1 Jul 2024 09:40:59 +0000
Message-ID: <DM4PR11MB60435DCC960FE028D572C3D4E9D32@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
	<20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
	<875xummndx.fsf@kernel.org>
	<DM4PR11MB60436A9107BCBC27294DBF22E9C52@DM4PR11MB6043.namprd11.prod.outlook.com>
	<87ed92nngq.fsf@kernel.org>
	<DM4PR11MB60435B5F50827F6ED8E8115EE9CC2@DM4PR11MB6043.namprd11.prod.outlook.com>
 <87sex2ijz2.fsf@kernel.org>
In-Reply-To: <87sex2ijz2.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|SA1PR11MB6687:EE_
x-ms-office365-filtering-correlation-id: af160f36-2c4a-4509-053d-08dc99b1ea05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MHdnSjdPWU1qOUF1US92OC85bG44VmFycFJiYXFhdjRsdUZHYUpYdUtKVCtj?=
 =?utf-8?B?dnozamVoSk9ZYkxQL1lKdWJVbTA0Z0dnTFdQaitZZlFsWU0ySXZTblJMM0FS?=
 =?utf-8?B?d0ZERlUydVBkYm90bEYxak1adXhnZDVuUG0xWGkvM3U0NU1ENXJuZFpDNnEy?=
 =?utf-8?B?UXNxTCttVDNzaUNSWTVNN25hS0tMRU5tUnIrVkpucWZLSHJwdm9vY2dNSjNO?=
 =?utf-8?B?d2lnL1doaGdoeHVjQTE0K0cvbHFkNk9HTE9vY2tmNEwyRzF6UWlhenUzMnBP?=
 =?utf-8?B?djgzckdKSVZRenA3KzluOTRlcmVYYVEyRDlzTWc5QmFKVUt6M0d4eVJPVFQz?=
 =?utf-8?B?WU8zN1l3NE5ZZlErY2I0MlM2REpTNXVFeHNiZUUrbXVra2JWeW5oZExyZXFW?=
 =?utf-8?B?MUVOMVFtOU1zSGpjR1VGR2t0MHpmeE9JVEdadVBxYmdFSWtzYStVL3U2bUlU?=
 =?utf-8?B?UmtZU1EwS0RvckFWRkx0OVJKSmk3bys3c1NQYnFnZE9EeUhMWFhjT241WFJn?=
 =?utf-8?B?eHZtTHF1Q3J2RHM1bUw0Z294QjZxL0JTTi9xdUtDTHBvZktFekpCMDVXaklF?=
 =?utf-8?B?WTlrWGp3TFBKa1hvYmUyUXV4YjVCNDZrazVDSEFlQ2w5dWV0QTBmSTVMYnRL?=
 =?utf-8?B?UmpGMThWdXFuc1FqcllER0h4MDBlcTIvT3BGNDdDdXVXalh3MkV5aEEybUlw?=
 =?utf-8?B?TFJlWkN1dnhOWTlUbEFmRlFZanEyRU5MUWs5MlB0bGJLNnV5d3dFd0I0NWV6?=
 =?utf-8?B?S2JRL2ovTWpKaGpCZ1NRb1h2aU51aGNXQkI4V1UrSnZoWjZvbFRJOURCR0JK?=
 =?utf-8?B?SzNOK09uMUVRak1WZVp3OFk3SzNUeXoxZVF0M3NBV3JsTTF5cVhPNU8zbXpl?=
 =?utf-8?B?dDFJZVRWWWZxbEg4MUFiaHJUZnJTSnJnSkFvVlZ5WjNMYVhZS3pEUlhyWlJ3?=
 =?utf-8?B?MmNLdUQzQXBqUUpUck00WlNrWEJ6anFHcXdCUFhXSWNzdDRrUnJXWWczNzJx?=
 =?utf-8?B?SmFJQk5tSnR3UVRYaGhXb0dJWU1zRU5lK3lkV3pMV0M0OUJSY3NzdzFvYnRr?=
 =?utf-8?B?TVE0VWNzdXNvWG5RTmVFdFdid0lrbUk5VEV4dWozWC9Db3pMZ05zSVBKWDNj?=
 =?utf-8?B?OElqSUtjanlBWDJaMzlDYU9uUkVJRmwxQzN5THhEVmZqN2Rsc0h6YVplY3Uz?=
 =?utf-8?B?Z0F5Z01FM0RJeXl6bkdoem02NUs5OTh3VCtrZjV2STc4NVlFSnowTnk5MHlv?=
 =?utf-8?B?QmlYTlpPSG02cmYzNWJVQlorY1F6dmRvOU80RWZ5S0RrL2E5eUFneGQ1VjFj?=
 =?utf-8?B?NHVrRmIvOXJmeEF0elZWM2Fnb0NCRWl0R2RYQ1RHYXBiWk53SnpXaVBKblc4?=
 =?utf-8?B?T0lrTGhTS1d4ZzdaMTRmdUtrZ1ozZFNQREV1WUl1YksrRnl0d3UzZUdWQmcy?=
 =?utf-8?B?bDlMSGN2MGcxYmUyckR1MGFySGphSEU2a2JJZW50bXdKbzkyaWN3U2l0Uno5?=
 =?utf-8?B?dFh1cXZlTkljL2RwTVV4SnN0VEd5Y3NuN2pVUE5GRURvMTdzOHN0NzhKSVNR?=
 =?utf-8?B?T1drTUhWMHBnQVZ4OEpQdVNPRWdpS3ZGck5aaVRudEUxa0RadlJLczRvOXhu?=
 =?utf-8?B?QjUyYlQ3YXd2SGlVYjcxak8rZW9UelM0QVVMM09Xc2Z0VkZIbkJNMEIvSkUx?=
 =?utf-8?B?QnZ4aExlblRPcDRoY3VGOWsxZVdvVGVjZFhEajFtbzdTSVNUbG1XQUs2ZnBE?=
 =?utf-8?B?L2J0N2phUFI4TkI2ZlF3QklwVVVtUSsxbExTdEV6by9wUmVIWVp1QjdvNHh5?=
 =?utf-8?B?MHBSWXdGVG8rMXRMcjR3d1QwTHphWFpxZURvY0JjbkE3Y2VCRjJYR0F5TVd2?=
 =?utf-8?B?M2pwT01wVDZ5UExMR0pnV3B4cFE4MWpiK3VWSTJYOHcrVmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1NtMkc1NWRhdElaY1ZqYzlHUkNGZnh3TDBxRHdGTFJZbWROb3ZGblBvWStR?=
 =?utf-8?B?cy9sSlFONWlaOXBQZUhJbTJqQUk3eFB6SlBVaml2SCs5dUJFc0IyUE9DcGxz?=
 =?utf-8?B?S0g4dkxjR3N4cEQ1MTJ1dnd3QWZGUm9XK09YeXZYSU9XOVNsVjJKMDM3WHZZ?=
 =?utf-8?B?ZCtJNXgrdmxONE9ITXVpWmtkY1dZMHVmbVFBMkdWZVFGeGdBdDFoRTRFZ1hr?=
 =?utf-8?B?YjFPNm05bTBrWXRvdVN0Z2tNQXJmcjVHUzJQOHg3M3E3MmhoNGtPdnJZcThx?=
 =?utf-8?B?QW5ES0c4Nml2K0dLSFFqeGNoZlZJRktGVHd3a2hkQXNsaVc5YUFnOEJDOGlD?=
 =?utf-8?B?bFo5MzhwcXlUU1loUHFOQW5PYXM1elFJcVhSOGUydDJNak9oajJDZ2FPVDFH?=
 =?utf-8?B?QjRsR1ZWUE5XS2lhZUZjRXEvcVRsbTZHYUk2NW1OaUJDZ29LN3Y2aDJwRjIv?=
 =?utf-8?B?d1FDREFvSXN0YktEVlV5cXZ6eDNkSG9GaG52bWZ0d1pmTHdtOUsrR2xMQ0s3?=
 =?utf-8?B?ZkJVOGYwKzRuSVR2c0VsMkVicklPWnhsYXkyb3NDRGFXWHdTTXMwc2FxdmtR?=
 =?utf-8?B?S1VSUlB3V1UyMkcyd3VFcjZ3em1jM2VMYzgzeFp3eGZIY2FRVms0UjhVaGRX?=
 =?utf-8?B?cHNWUFlhYUxXck9jNnI0R01kS2p0ZFBMWEh6UDlsNVJRSWVUYkdUSXRNZ1g0?=
 =?utf-8?B?dWpIVzdTQkZ2UjU2ZDJYQ29IRFBHYTZPYXFTYmdSa0JYblFkMFp0cXhnbklP?=
 =?utf-8?B?YjJmVWpYUW5NOEhEejJRV0tnVFdLdEVnekxiV2YzUkJMbUtwQVIxVE5DeTJG?=
 =?utf-8?B?YngyWFhNTThtV0xjcWk0UllxRlBrTEE2cDNLZzNqTmZsdUh3VWtnbU5GUzlo?=
 =?utf-8?B?UTJ2UEp3eVBNczlQcEhCVkNsWnBzaUpSclluTU9XMUgydXhIMW95bWt2Z3o4?=
 =?utf-8?B?T3FaQlRQaStvTjdxb1J4UUdSLy9obi9XZzhLWFdMTWtTQWJSR3hIclhBdVFy?=
 =?utf-8?B?bURMQnQ1Q3doUFREMVJNRUxBNlRwYUUwOTRyZUJQWTBrTDlMZVBYMXh5ZXlu?=
 =?utf-8?B?OXZwRjBKWmZITXNnTS9WMC83SnBjaElDQzRVYXhzU3REK3Y0NmdUZmowQXMv?=
 =?utf-8?B?OEhGTFVJSWM3dzJRaTR6K3JZajBMU0Fjay84OWJ5c2l5eDJydXV5UnJCYnpq?=
 =?utf-8?B?cEwvN2FZRzNuaHRqRVVaTHRTYkkrM0kydnh6dkNzUWZsd2J6L3FGQmJITmlK?=
 =?utf-8?B?cGdJY2xwVmRWWi9pclViSFBncHluK3psU1l5SllYdUxvS0ZYWEt4dGprMlpx?=
 =?utf-8?B?V0ZhNXZkd0gxcVpMcE9DMXRCb0lvS3RzM01XNHkxcjRVOU4rS0J0NS9IMUc4?=
 =?utf-8?B?djQ1SDhYWUljUU9NaEpLQWc5ZDFDc1dNd1Jnc0xFcnAxRkx4S3gvei9FYXh3?=
 =?utf-8?B?WktiTnRXZE52V0cyVUp3cTQwQzZBM3F1ejZITkZ5N1Z5bDNJTVhid0o0Tncr?=
 =?utf-8?B?R1RMcXd4MHBsa1J1ZWNmK0Rsd2dIcmp6K3NLYUhFd0NZbXRiN3pkUlRydGFT?=
 =?utf-8?B?SHlsQTEvakVjcFBuOTJhMXlJajFObXErcTdOcmVkd2VTNlRMOXRNSzVldmto?=
 =?utf-8?B?YVh6aFAzOWJ4K0FQVEM5VWIxcnV2MERWclJQamYzYWJKSVhuZzdYOXhWa1lN?=
 =?utf-8?B?UHI0UjFVaVdxMkRJSUswc3A0a3RaaWV5SlVoQWt3bE1jVzZvR3EzemNPeE9P?=
 =?utf-8?B?Syt3T3NBUE1Ka2FCNTBQZ1l2WXU1aStabTEyS0JpTEFnSERCTlFFNVFTVTl5?=
 =?utf-8?B?QUJoTExzVW1TbHc2Z0tZa0F0SDA5MDJxNTRRMkFJTHdnYjNjSkNVdUtLM0dU?=
 =?utf-8?B?MnVhZzJ5eTlwM044UDNnaTlkbzZ5SUFBU2Z3SHJyeXR2dG1uKzl2SlhvMXpB?=
 =?utf-8?B?Z0FiUm5LTWFUdkZUVVo5bEw5elFaVGd4c3RFVkR3dkRIRnBaOXlkN0xsUzlB?=
 =?utf-8?B?RHJucW1USDV1TG9lanp4alR3S0hUMlUvZDdpay9DVnRIOWVYWHV6K1ZnaUpM?=
 =?utf-8?B?UThPcHoxMVJLeFNQSXFOYXV0TUoyZHgrUGtFbllpS3pSN1dzcWpnRU1LVHAz?=
 =?utf-8?Q?kUA8ehOFmSSA5VLbmrMvTSUh0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af160f36-2c4a-4509-053d-08dc99b1ea05
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 09:40:59.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQbqpjr0PRq0rAJYc9Z4Qt5Xu1Kl3RbnLG2BdX+5mI7UmULjCwtzP6WUB1r7ejVmSvoW5xcHikLGxRxz4xOA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com

SEksDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbGxlIFZh
bG8gPGt2YWxvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgMjQgSnVuZSAyMDI0IDE1OjUw
DQo+IFRvOiBQZWVyLCBJbGFuIDxpbGFuLnBlZXJAaW50ZWwuY29tPg0KPiBDYzogS29yZW5ibGl0
LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+Ow0KPiBq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7
IEJlcmcsIEpvaGFubmVzDQo+IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCA2LzddIHdpZmk6IGNmZzgwMjExOiBBZGQgc3VwcG9ydCBmb3IgaW50ZXJmYWNl
IHVzYWdlDQo+IG5vdGlmaWNhdGlvbg0KPiANCj4gIlBlZXIsIElsYW4iIDxpbGFuLnBlZXJAaW50
ZWwuY29tPiB3cml0ZXM6DQo+IA0KPiA+IEhpLA0KPiA+DQo+ID4+ID4NCj4gPj4gPiBBcyBkZXBp
Y3RlZCBhYm92ZSwgdGhlIG5lZWQgdG8gaW5mb3JtIHRoZSBkcml2ZXIgYWJvdXQgdGhlIGludGVu
ZGVkDQo+ID4+ID4gdXNhZ2Ugb2YgdGhlIGludGVyZmFjZSBpcyByZWFsLg0KPiA+Pg0KPiA+PiBT
dXJlLCBJIGNhbiB1bmRlcnN0YW5kIHRoZSBuZWVkIGlzIHJlYWwuIFRoaXMganVzdCBmZWVscyBs
aWtlIGFuIHVnbHkNCj4gPj4gd29ya2Fyb3VuZCwgbm90IGEgcHJvcGVyIHNvbHV0aW9uLg0KPiA+
Pg0KPiA+DQo+ID4gSWYgeW91IGhhdmUgYSBkaWZmZXJlbnQgc29sdXRpb24gaW4gbWluZCwgcGxl
YXNlIHNoYXJlLg0KPiANCj4gWWVhaCwgZml4IHRoZSByb290IGNhdXNlIDopDQo+IA0KPiA+PiBB
bmQgdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoaXMgaXMgcXVpdGUgdmFndWUsIEknbSB3b3JyaWVk
IGhvdyBkbyB3ZQ0KPiA+PiBnZXQgc2ltaWxhcmx5IHdvcmtpbmcgZHJpdmVycz8gTGV0J3Mgc2F5
IGlmIEkgd2VyZSB0byBpbXBsZW1lbnQgYQ0KPiA+PiB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIGZv
ciB0aGlzLCBvciBhIGRyaXZlciBpbXBsZW1lbnRhdGlvbiBmb3IgdGhhdA0KPiA+PiBtYXR0ZXIs
IGl0IHdvdWxkIGJlIGEgZ3Vlc3NpbmcgZ2FtZSBmb3IgbWUuIEZvciBleGFtcGxlLCB3aGF0J3MN
Cj4gPj4gInNvb24iIGluIHRoaXMgY29udGV4dD8gNSBtaW5zLCA1MCBzZWNzIG9yIDUgc2Vjcz8g
Q2FuIHRoZSBtYWM4MDIxMSBvcGVyYXRpb24NCj4gc2xlZXA/DQo+ID4+DQo+ID4NCj4gPiBJIHVu
ZGVyc3RhbmQgdGhpcyBpcyBub3QgY2xlYXIuIFRoZSBpbnRlbnRpb24gd2FzIHRvIHNheSB0aGF0
IGJ5IHRoZQ0KPiA+IHRpbWUgdGhlIGludGVyZmFjZSBpcyBlbmFibGVkLCB0aGUgaW50ZXJmYWNl
IHR5cGUgbWlnaHQgY2hhbmdlLCBhbmQNCj4gPiB0aGF0IHRoZSBkcml2ZXIgc2hvdWxkIGJlIGF3
YXJlIG9mIHRoYXQuIEkgY2FuIHRyeSB0byBiZXR0ZXIgZXhwcmVzcw0KPiA+IHRoaXMgaW4gdGhl
IGNvbW1hbmQgYW5kIGRvY3VtZW50YXRpb24uDQo+ID4NCj4gPj4gU28gdXNlciBzcGFjZSBpcyBu
b3cgYWx3YXlzIHN1cHBvc2VkIHRvIGFsd2F5cyBjYWxsIHRoaXMgbmw4MDIxMQ0KPiA+PiBjb21t
YW5kIGFuZCBhdCB3aGF0IHN0YWdlIGV4YWN0bHk/IE9yIGlzIGl0IG9wdGlvbmFsPyBCdXQgaWYg
aXQncw0KPiA+PiBvcHRpb25hbCB3aGF0J3MgdGhlIHBvaW50IG9mIGFkZGluZyBpdD8NCj4gPj4N
Cj4gPg0KPiA+IEl0IGlzIG9wdGlvbmFsLiBVc2VyIHNwYWNlIHNob3VsZCB1c2UgaXQgd2hlbiBp
dCBleHBlY3RzIHRoZSBpbnRlcmZhY2UNCj4gPiB0eXBlIHRvIGNoYW5nZSBiZWZvcmUgdGhlIGlu
dGVyZmFjZSBpcyBhY3RpdmF0ZWQuDQo+IA0KPiBJZiB0aGlzIGlzIG9wdGlvbmFsIGZvciB1c2Vy
IHNwYWNlICh3cGFzdXBwbGljYW50LCBpd2QgZXRjLikgdGhlbiB0aGUgZHJpdmVyIGNhbm5vdA0K
PiByZWx5IG9uIGl0IGJlaW5nIGNhbGxlZCwgbm8/IFNvIHRoaXMgY29tbWFuZCBjYW5ub3QgYmUg
dXNlZCBmb3IgYW55dGhpbmcNCj4gaW1wb3J0YW50IGJlY2F1c2UgaXQncyBvcHRpb25hbC4gQWxz
byBJJ20gd29ycmllZCBob3cgdGhpcyB3aWxsIGdpdmUgYSBkaWZmZXJlbnQNCj4gdXNlciBleHBl
cmllbmNlIGJhc2VkIG9uIGlmIHRoZSB1c2VyIHNwYWNlIGNhbGxzIHRoaXMgb3B0aW9uYWwgY29t
bWFuZCBvciBub3QuDQo+IA0KPiBUaGUgd2F5IEkgc2VlIHRoYXQgdGhpcyBpcyBkZXNpZ25lZCBq
dXN0IHRvIHdvcmthcm91bmQgb25lIGl3bHdpZmkgYnVnLCBub3QgcmVhbGx5DQo+IGFzIGEgZ2Vu
ZXJpYyBubDgwMjExIGNvbW1hbmQgd2hpY2ggY291bGQgYmUgdXNlZnVsIGZvciBhbGwgZHJpdmVy
cy4gQnV0IEknbSBtb3JlDQo+IHRoYW4gaGFwcHkgdG8gYmUgcHJvdmVuIHdyb25nIQ0KPg0KDQpJ
dCB3YXMgbW9yZSBhbiBhdHRlbXB0IHRvIHRlbGwgdGhlIGRyaXZlciB3aGF0IHRvIGV4cGVjdCwg
c28gaXQgY291bGQgcHJlcGFyZSBpdHNlbGYNCmZvciB0aGUgdXBjb21pbmcgZmxvd3MuIFNpbmNl
IGFzIHlvdSBtZW50aW9uZWQgdGhlIEFQSSBpcyBjbGVhciBpbiBhIHdheSB0aGF0IGNhbiBiZSB1
c2VkDQpieSB0aGUgZHJpdmVycywgd2UgY2FuIGRyb3AgdGhpcyBwYXRjaC4gSSdsbCB0cnkgdG8g
d29yayBvbiBhbiBzb2x1dGlvbiB0aGF0IGRvZXNuJ3QgaW52b2x2ZQ0KdXNlciBzcGFjZS4NCg0K
VGhhbmtzIGZvciB5b3VyIGlucHV0cyBhbmQgZmVlZGJhY2suDQoNClJlZ2FyZHMsDQoNCklsYW4u
DQo=

