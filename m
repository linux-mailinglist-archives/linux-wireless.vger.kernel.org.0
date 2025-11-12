Return-Path: <linux-wireless+bounces-28860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0789BC510A0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 09:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634F41895EEB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91441D6DB5;
	Wed, 12 Nov 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnM0ar4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC12749C7
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934524; cv=fail; b=c+6hHjRYNRc8qZVsVAmVWEGtjuuhr+O2uZrTZiJ522iuoGwHAzvbd7Gj5uT7U6MojjDZjURnDeH+rNcIp9O5yspjPI12sAQFeqhlQ7eNVQS9NxHn39vsWWaB0wtf/25BrjG2q1g2DBT0blMUdmyZ/FYqRJ8mSbLElZ3Utmu3UA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934524; c=relaxed/simple;
	bh=Ittz4QSDmtFUOxgi32K+3NwIvfnBijC1ufKib6rgtQ8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HJiekD/nCzDb/qAL/w5Zcoqe84EQ0nHq4fxJYy+vJsqwSRiOPRAw3wTBnAN0kR1VJhkbPlAcWjFzeu2sEx6anW6UER4LzhcFct5Ylg6ChsITYG5tdgIvmloORn4QuOd7ShU0MfKGh02E/6bGLh/cPTcdc57KFhlEww5oB2SEfVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnM0ar4v; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762934523; x=1794470523;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Ittz4QSDmtFUOxgi32K+3NwIvfnBijC1ufKib6rgtQ8=;
  b=PnM0ar4vU84JcwlUqX6LIG/9nhfs7HZX8c1p80LCfypt4pRffjwn9wtS
   jmV+q/eeOLAchXE6+qkIUmOG5YdZp+sETSc9W9D2LshJoDFM5QHI7uuJP
   gIVh05KjSQ5z/EoERjTIccp1orImItiJqOwxN3sIsGBmiV1IroSIijuEd
   wZQ93Z5lHRxUQh8TAmM6sSUKGZur9X6vgz6klrs9jgZHi+W+Yh7+u9HjD
   agwFAfFVapGuTCv5uXXK1cw6CY0gBCQNbDTVRyv7D42U/4bkdFD38+jaM
   tp50lKExqCBJw37cmL4vRAeHjTgGH0HKdI6gyXnq3kjaHjNFOSxrAm0Ey
   g==;
X-CSE-ConnectionGUID: 4vCVPKgrS4iXyWv1TceaSQ==
X-CSE-MsgGUID: TJ2cErDLTGqp5QIKNRrJtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="63998826"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="63998826"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:02:03 -0800
X-CSE-ConnectionGUID: LmVqHSixQx2FSUJUfNJ/nA==
X-CSE-MsgGUID: O4yqfLhGT6OyHN270VUscQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="189882733"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:02:02 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 00:02:01 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 00:02:01 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 00:02:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTVVMNwVumSrPRmnBfWsPjZp6J/T6qMAwstB96mxex+MFqX9s/3cA9r3WOSthINXshxa+4ORedBB4qleCpASIPCRbvBxSCHNfa1UJ3FW26SDS7y5A4MSSvzLoLBRV2/AoPy+WkP0SmW81iLrWJp/OZwiFVeYSjgerT1qBGEW7Xd4F5nB7Cd5shOSlYBUjSP5mXPd2h28X3lIj0BFS5Epj1OS0WMkY6AfsXhVqkaevhQ546eupmz52sBFHruFXUJG34EduBko/7Slbrx/o0lKSJ/ly1eCndTwH2TNbLfXRkJ3OuLypnEaIAunZtDcvAGpsqomeYh6QGkGucpWsd/v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ittz4QSDmtFUOxgi32K+3NwIvfnBijC1ufKib6rgtQ8=;
 b=Jp4SBsXgcJJrYaQ+44MVx35qUo8VAaQwE8Q0HcXMSMKIJYrQuMvW0+phfKQsj/sMQVpopcg4PQ3zPlFoGvPsUL+Lm6fJ/SpHHMEr1zdexbTW5dOwOkqA1HHOPAc1OXj5qY4FuSY/mfteCl5jNrWYyF0xxus1KD3Uef+PkFRAeGTE7kEINFXUzoQ5AU5CslaouEINjhhQTZIJY/zxy8GNjoSUhNlAc0+P05H6SCYYwLVD3eiPYMBAm/XMNo3kT4fMca9/pP6yIWC37Uc843fyNxXmF7nig4kdNqORZVlZdaP4stwZ3d4JpNIpWUuBdW0c7jZdqWxZvyLa3XVrrsTO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA0PR11MB4558.namprd11.prod.outlook.com
 (2603:10b6:806:9e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 08:01:58 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%8]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:01:58 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes - 2025-11-12
Thread-Topic: pull-request: iwlwifi-fixes - 2025-11-12
Thread-Index: AdxTqpwVyv1WTAw3RJq+YWIJjvgTmA==
Date: Wed, 12 Nov 2025 08:01:58 +0000
Message-ID: <DM3PPF63A6024A9E52FF4A7B23F283B7FC7A3CCA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA0PR11MB4558:EE_
x-ms-office365-filtering-correlation-id: 87a446da-bfe3-4ebe-bb2b-08de21c1c0ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VWlhTTRlMmVRU1MzeUUzcllxa1B6MmNERjMyVUJhOGdPSkUzdkliN3I4M2tY?=
 =?utf-8?B?a2lURG5IMzZ3UGNDUlFLL2cyN3ZhMGtvLzlaa2NGdkxTVzJoTkRjckVabEd5?=
 =?utf-8?B?bjdIdE1EM05qOWxNbEtWazcyeDZsN3Zoa0FKRWF6Y001TjhDSVU0Y0EzYnRN?=
 =?utf-8?B?VitBMHdiL3QrSWFYMEZraFgxd2dpWlcvRyt0VW5NWWtTaVlwM202SmQxQ3FG?=
 =?utf-8?B?bEk2emZRVHdOdDhPUWlqNGQxVE11T245VDRkUmlpRkxXMTNBMys0ejh2Lysz?=
 =?utf-8?B?TE5ickd5Q29IR1NrMUFGMzVVdExZWEF5ZkVzb29zd2xVWFFEd2cwbzF5L2xH?=
 =?utf-8?B?V1RQeGN0VHlXQmtNQUxzNkpCaGUvWUxFamp3dUFxZWxtK2h4Q205K2FsRUNV?=
 =?utf-8?B?OG9BNDBqUE5rMHlsMGR4UVlXMUVhLzlJWER0dmhZajJ4ZkpVbU1XOWV0c1Yr?=
 =?utf-8?B?YWl4K1U4Y0FZS3R0S3IxVU5UL3dNR2QybnNTZktBaFo1aHNwZFgxYnFxandT?=
 =?utf-8?B?OHJKVjRzalVRVTFaa20vbFVnN29yVXBIa0R2TVgzbW5GeWVEK3p2VDEza3h2?=
 =?utf-8?B?OWR1U1l2S2Z5amtPbFhzV2hiRGtuVVVmSDVBN2d4NXgvZ21UWmNBWlZ5MGVk?=
 =?utf-8?B?RnA0MHJXVHpiTFJXaUVQZm0zNFplUU1BZTlKaWFPTXVyU05GaER1dEUrS3Fk?=
 =?utf-8?B?bkxWL2YxUmlnT1JSU1h0L1RtK044Rzd6WXc0ZEZmNGlTUWpzNmo1bXg5K3FC?=
 =?utf-8?B?aVVDVkFId2FJcGE2dnl4T2xtMEt1RWhnQThjb1F5MjZveU1lRUM5NXFqRXV4?=
 =?utf-8?B?Yk9xT3c1TmdtWTYxdHBCQytTQnpVUjhGdTdyTjRwRVRMWFBFUFo5a3ZaMVor?=
 =?utf-8?B?dDZQK3lJK0haYmcrVkI3YWFUWTc4NG9WUnJFbVEvVzVBSXlUbzllWkNJVE1y?=
 =?utf-8?B?bGZma0ZYWExoVzdlR2NqVEpKR2FqR0s4S3lXYTRSM3lieU1vMC84aWRUL0VW?=
 =?utf-8?B?c1ZyZUZVb09oQzdzdFdsMVMwTjU2c3VkL1Y5L0lXS2gyYnMvOENyT00venhP?=
 =?utf-8?B?cHhJZHQ2Z2FDY2ppYWVkRndBZG1kNXZ2VVBWbmFOQXpRK3YzSGN1SDNkaE9m?=
 =?utf-8?B?VlFIcFc3aFZXb3NkWkNsamNpQ1QwKzdMVlF6VFNkMDd1czg5S1Y1aEs0T3Fm?=
 =?utf-8?B?VFdLcUlNcGdNNE4zWXJ3NFZZSGpDOG5hZlZwUVJINGcweHpZcy92eVFCSDhD?=
 =?utf-8?B?Ym9nSHdsSGcra3dhaUJubmFHeEVTem5xSHdPYWN2ZkpGb21JS0VvU0tLOGdN?=
 =?utf-8?B?SVRLSjc2N090MjJKcDRsMElYcEZDVzZSN0pGSVl3ZDVEaHFYMzdpd3p2QnBS?=
 =?utf-8?B?cGFwVXVxWjRpNjlRak9KK3gvbGZiNnVoSGU4T2U0L2hoTHhlMjRvd0krVWU4?=
 =?utf-8?B?NVpuaHBFOGNEQ0JVSDZ4TEpkRjZaZC9FeVlWeHBoY2c5U0w4K3RSekhpbDBM?=
 =?utf-8?B?UnAzaHlJZjVuTW9MWkxzZDdyTlQ5NkFPMmpLd3IveWkwUjZtS0lUdGM5NjU4?=
 =?utf-8?B?QUFCSlJjZ2h2L1J1T3NBcVgwYXE0NWQvQlVJclBmamJVN1pLbVYrYVRXbk9v?=
 =?utf-8?B?K2VUemV2VE9UZ3d4dm5vZDV6WWZ5azNvMlFNa1pzYmlKQXVvb2p1WWJhUkQ5?=
 =?utf-8?B?U09KRnN3Mkk4N0RxL0l4NWRWd3RaOVJvZ0JKSVhQazRPdWk1UkFJS2VxbFJo?=
 =?utf-8?B?c2Z5dGsxOGhzRXNHdURyUVdQL004WXQrOXBUNW9CakNxY3J1Q2FIMFR5L1Vp?=
 =?utf-8?B?ZVV4dWVvR08vZ0Z0SkRlV2s0K3JZSlR1Vk51cFl0amxFSFBvM1JYTnU0TTFy?=
 =?utf-8?B?RWxFVFVZYkI0YkorbFBIVVRrc1RNVm5wbGg5UFYvcVl0UlNKMGFDM3VWajdj?=
 =?utf-8?B?bDB6RG1VaXJ2cVdSdGwxcWRpcXdveWx2bjNzeDRCWnJxa0FkR1JmUVpnZVU2?=
 =?utf-8?B?OWJxMGdxcnZDK1JPMUtpR2x3ck1ienhPMjMxVnpTdktsVER6c1cvVEh5UXMz?=
 =?utf-8?Q?Sv1RjM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVRCUndaUmtqaGN6d3B4SCs4QzhwVnNpS1lWUWxBWmF0bjZPTlpHd2F5RTNO?=
 =?utf-8?B?blpEdUwrelMrQWphRitvWjhmZ3B0Q20vS1VWZFNBdTQ2cWNySzAxNjRwY2Jp?=
 =?utf-8?B?bGtQaVk4YlU0Z2xSZytEblo0LzVueTBJckFQK3grbGRadXFIUGxDc3RaVkRH?=
 =?utf-8?B?Wjk1RE9CZVdoL1AyVzBvR0NiZndaQVUrRjBxYnJ5c25QQVNTSUFLMHFFZ3Jk?=
 =?utf-8?B?UzBYK1ZWTjFFc2dEYTRaTXpRenN0Wlo5WGdwY2VFR2NwRXIwNEZHVlVPaDVi?=
 =?utf-8?B?dkhqd0d3Mk1OL3J4V3dJZ1VkeUgzbTFqZEdRUXJxaFF5aU1oOXowTEtQQVRJ?=
 =?utf-8?B?R0p4TjVLTDg0eG9XNkwrVUpUeW1BdTFXUkQwcDdEa1ZoVkt0Rmk3OFZPUVJS?=
 =?utf-8?B?aVJMQzh3NkMwMkljdndSTEhLRlllcmZQMkoyTStpakoxL05YejZQSGRhNjRF?=
 =?utf-8?B?MzhmQmtJcU5NMThpb0pZSmZrRld5bDd6SzRLRk9BTUl2eVRoTXcxaDk1WWpT?=
 =?utf-8?B?QXhwQzIrWCtSQ0dXbGNCSUsxZ3crNzM2bnJIK056dXlUWEZzVXBBVDJocTJF?=
 =?utf-8?B?Tk9TanM3aUlaTm5Vd00vZ1R3SkxDNDRYcUxtOEJLV25WVmxLRTRVcUszMVRs?=
 =?utf-8?B?L3RtbGg4RFJ5WmZlQWhiYWtURzBHcTlpZmxaRXJ6UXpkTmlDc3ZVZmxGcjZz?=
 =?utf-8?B?T2lSOExrNDJxVG0vT0w4NHB0eklVTzFsNzBvcmxsUkU5Ri9kY1F2K20zVm93?=
 =?utf-8?B?c1ZSRDFVMUZvWjJXZUdsN1gxOGZNVEtVWjRhOGFGRE5LUFpoTkx2RlhtM241?=
 =?utf-8?B?ZGtiajBseWdlNkZWekwydGYzbXBTMkY2NE9RRzBxM3RkZWRraUhtaWFQNmxX?=
 =?utf-8?B?RzNGeU1FRCtQamFuTTY1b0kza0NzeHdqN2xCaFh0aCtwaVd6elNEZ3B2RXp2?=
 =?utf-8?B?c2VuUkM3clRiaDhDbVBtSndhbS81RSs0TEowOU4yTElBRTdrK2lhWFROQUpM?=
 =?utf-8?B?bzdFeUZVTGVjWnhBTlZIcWU2NUI2aHpsSThscVpjN1FtMVRtRkxCekg2KzFV?=
 =?utf-8?B?VDd2V2ErWXhVNi9SWXRkYzltTyt1MjVQMi9VRVp5YU82SFFQbVY4UXppdFRZ?=
 =?utf-8?B?ZXJsd3I3d2NUVHp6Z3g4M2dHT3dxbStNdi8reERraHg4dFZGNHNaSTY2YXlz?=
 =?utf-8?B?ZU4zNXBxRkJPek9kdTZqNSt1SkFsUEMxQUk0cElPTHJoNm1YSXNvRWRHTndk?=
 =?utf-8?B?SXJmTUdBUXZ0ZGJHSVZNMTk4Z1N2NXpVdmk1QVcva0EwM2NoZDQrc045T2Q1?=
 =?utf-8?B?RnZtWlpwT0Y4WXpUZHpBS0VqMmxiTEcwQU1pM2oyaVp4TWdISEx5Tjg3QTJu?=
 =?utf-8?B?WGtxR09pRGw1RjNteGxXR29lZ2JyRmtxb3hkWUpWU3lYRmo4YW83blhubGFa?=
 =?utf-8?B?RXdjZzZQTmwxdENuUktHenhVVTQ2UU9CdEpMSDlRaUhLek9JQXZGSXJQc2dO?=
 =?utf-8?B?Z1pQM1dVZDZRTG12OTF5anFQaEFsa1hibWkvUThyZC80dmFTVUpLZEd0RHhi?=
 =?utf-8?B?T0lPUGo5RFF0S2RnYVYrWkhhZkIvUmVWdy9aazBoM1JUdi9NVHNCS0pDc1M3?=
 =?utf-8?B?MGlaelh2WXQ4OGh0MjFIc21IdnRNQXVGY2l2aHloSnJGM0tFTlBSQlZnQUdl?=
 =?utf-8?B?OGlpYlpSL2Zad1RzU0ZudWRiV3dWaHNPYkNKSjlLS3ZTQzRJQmlJSkhSblNj?=
 =?utf-8?B?amNoS3p3RmdSQ09CZytCMm04NythR3Rpd0orUlJnWHc3VVZUdUNHbzlEU3Q0?=
 =?utf-8?B?MXhORmQyVWJWb3dUMy9USG4vbTV0M09LcHZIbzZmNkFoK0ljWGlSK1M2dnNQ?=
 =?utf-8?B?MzdhYUt3d2pqT3Z3WmdRZWVKOFVkQ0tGS015ZDh1WTdERFIrV1pzMUJid3VI?=
 =?utf-8?B?VGFTYldJQzhsVUtHbG04WXYzQTZDbjMwd000SEtKN3VlVHV5WHdJY3VESXAz?=
 =?utf-8?B?S3ZsY2RsNFp5K2hmUWlVOTkwRFlvSFpZRnFmeEl6WHJmdnRZMlJnZlQ0ZkEv?=
 =?utf-8?B?VTdFSjNmM0V4WHBtS1dtaTJrZFVuak1HanZxRURwMlA4b2NtenNxeW9sam02?=
 =?utf-8?B?ZGZzTFcrRWhJRTE2bHlNTVRDN0dGUXRlb0lRQkd1ZW9JaVdxN0p6YjY5eGxm?=
 =?utf-8?B?U2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a446da-bfe3-4ebe-bb2b-08de21c1c0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:01:58.1927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGYY/n3ikM1rO1Zwnh8n/jf5Ul0/ICDXV9skhMWMdYEirWKhoy/CnRHBNxPPMdaXShQ+Nwk534AB6fsc1Fvikxf2fStnSnTecKst7+9ixfn6WvWqDh0uqiPYSd6I4+Ju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBjNGUxYWMwOWVlMWM3NTA4OTBlMzZj
YjFmODQxZjI1NTE4ZjIzNTg5Og0KDQogIHdpZmk6IG13bDhrOiBpbmplY3QgRFNTUyBQYXJhbWV0
ZXIgU2V0IGVsZW1lbnQgaW50byBiZWFjb25zIGlmIG1pc3NpbmcgKDIwMjUtMTEtMTEgMTE6Mzg6
NTcgKzAxMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQog
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkv
aXdsd2lmaS1uZXh0LmdpdC8gdGFncy9pd2x3aWZpLWZpeGVzLTIwMjUtMTEtMTINCg0KZm9yIHlv
dSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDFhMjIyNjI1YjQ2OGVmZmQxM2QxZWJiNjYyYzM2YTQx
YzI4YTgzNWE6DQoNCiAgd2lmaTogaXdsd2lmaTogbWxkOiBhbHdheXMgdGFrZSBiZWFjb24gaWVz
IGluIGxpbmsgZ3JhZGluZyAoMjAyNS0xMS0xMiAwOTo1NDo0NiArMDIwMCkNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
aXdsd2lmaSBmaXhlczoNCg0KLSBhdm9pZCBsaW5rIHRvZ2dsaW5nDQotIGZpeCBiZWFjb24gdGVt
cGxhdGUgcmF0ZQ0KLSBkb24ndCB1c2UgaXRlcmF0b3Igb3V0c2lkZSB0aGUgbG9vcA0KDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpKb2hhbm5lcyBCZXJnICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogZml4IGJl
YWNvbiB0ZW1wbGF0ZS9maXhlZCByYXRlDQoNCkp1bmppZSBDYW8gKDEpOg0KICAgICAgd2lmaTog
aXdsd2lmaTogZml4IGF1eCBST0MgdGltZSBldmVudCBpdGVyYXRvciB1c2FnZQ0KDQpNaXJpIEtv
cmVuYmxpdCAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGFsd2F5cyB0YWtlIGJlYWNv
biBpZXMgaW4gbGluayBncmFkaW5nDQoNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL21sZC9saW5rLmMgICAgICAgfCAgNyArLS0tLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQuYyAgIHwgMTMgKysrLS0tLS0tLS0tLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3RpbWUtZXZlbnQuYyB8IDE0ICsrKysr
KystLS0tLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdXRpbHMu
YyAgICAgIHwgMTIgKysrKysrKysrLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25z
KCspLCAyNiBkZWxldGlvbnMoLSkNCg==

