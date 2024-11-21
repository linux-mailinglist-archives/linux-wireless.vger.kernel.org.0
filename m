Return-Path: <linux-wireless+bounces-15573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACD59D53BB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 21:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8DC1F220DE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515E1BD9EC;
	Thu, 21 Nov 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSJsuKkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3E43AA1
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732219921; cv=fail; b=u38wHmy/pcWaWCurAw9J77zhL1NFPU7xZjIAmuVXcbsqQnjri8ogWey02D0a+MnlBd4af3B1zFB0WDgwtB3bi58j7w6IFSeTn6H/Z70Z6i85FYwz2Z/xwlBesK9XL08kBCeU0gcJ4hC7cMjFMLcYs/ZpScWLv9+eh5jIiU8Nzyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732219921; c=relaxed/simple;
	bh=Z1JFJr+aIXTKBE72wrLKqh0gBgJ5bDPfH9QWQBzytFU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RGYdfn0kEq+S7cMHNpRLn7fo4snI2yHVyZl3yrx1YfVIHTWfMGwfVm66rzVvdaV3WKucmiMkJE/ESEKsQcwjw82Humn0HeoxU1WA0PhsFvmUx950/H3xpimY29nf91+8CooTjahqdUhfI4cGfLpnAbFCJlUU/W2Bwaam5A9d330=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSJsuKkd; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732219919; x=1763755919;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Z1JFJr+aIXTKBE72wrLKqh0gBgJ5bDPfH9QWQBzytFU=;
  b=fSJsuKkdtdeHHTfaW3ZEkt2k0LYB+aTP2MgJpLgbXh6iolclMj2jn1Ot
   A/d5nNetvdpIXqK+sR/HMYssIdHVsc/2fKND4ovcSiQemKbsqJmw7//6H
   QnYW/SpISS7XRi+yGXt/CIIENSrn1SUeorPEKaPsqM1BP15JZP4gr7d2j
   7D4wmN+JQxqtmEg40K26q6exAjPv1yahM/VEzR7rrNBE9nbe6OMisls2/
   bEeYLf9qzNKpf/CeGzE88vjexEOEwWyqTpqdi17MbM9L4iKqkuuT1Xl25
   S0QYXh1dRPeDhXGNoIf+p+9IrVhMYRLyGgDYgnGIzKp+hCHuQURfTMo7b
   g==;
X-CSE-ConnectionGUID: 60vW2oSXRLeGxlrt/etXDg==
X-CSE-MsgGUID: V6Rq5q8uRma2syj5Nw/Kmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="35218073"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="35218073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:11:59 -0800
X-CSE-ConnectionGUID: MgTjhFvhQK+cZzjdZhNc6A==
X-CSE-MsgGUID: YUqDNUEOR9eWNOkcaylXUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="89999291"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:11:59 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:11:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:11:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:11:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/RyvtXFnBWVRifT7hR9yH8gaqgHCVFRO4zJYvuBczZ0nzKZ17t2ibr+VK45wYPWl5eQhD9aTSyeARrILrDm+QIKAHuFbckdzs3RPExxi6rAXEGoFWQkUrS4YCuOe6DxFnR2PBEJalZG2aexe+cyuhY+6GpewVRGZM96ydGvlP1IDnxUULGlV6W7BEwjD1E+RurIUq+XSr2WOFC+M5FbuQIjXE/K6iKDJcc6pUey3FMUPqTIlTezkmNu+8wcEngaVOqm7UxMRS/6Vd6X/9SXGSnjevtndG2U6y94ZtQtG5TttfRsaItQ8yHQlqsqKp3OdUgsIrGiRZyIw1TpHhPgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1JFJr+aIXTKBE72wrLKqh0gBgJ5bDPfH9QWQBzytFU=;
 b=yxzA4qWN+ML7KKpAziNR1vR2Dn5oV6VX6wFPpjBzqYgU+Mm802KUDjQO1FaS9cRX6Fu3AB4svfMg7G324Cum7dwlwOnaKbNVd3H8K90uUpm/YZdxKXeDey6t1hpOZVAoqgz394V3CX3B/bYPlskYeq7Oea1ps3R3k3cIA1whPJO7wkGAWB8Xi3eSiiaV5ZX0UnPD0X+Mj9yxydHt7I2PedAP+VwCEOCaAku1MPvt1ZNjBQbzmlofA5PFAP3SOdoKK/bDUR0pYfO4gmg03ojhNgHa+Odfi3OTZ5AcuuGQH7afU4NzCy3/uR4Ht1nMvWEejUA0d9EjU0sWzIMpudRPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 21 Nov
 2024 20:11:51 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8158.021; Thu, 21 Nov 2024
 20:11:50 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "greearb@candelatech.com" <greearb@candelatech.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: iwlwifi:  Fix eMLSR band comparison.
Thread-Topic: [PATCH 1/2] wifi: iwlwifi:  Fix eMLSR band comparison.
Thread-Index: AQHa+Yib6kshiuWzZEmXFDBCi2kHY7LCrlQg
Date: Thu, 21 Nov 2024 20:11:50 +0000
Message-ID: <MW5PR11MB5810BAD7A2731D2DDACF5F7BA3222@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20240828202630.2151365-1-greearb@candelatech.com>
In-Reply-To: <20240828202630.2151365-1-greearb@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|DS0PR11MB7557:EE_
x-ms-office365-filtering-correlation-id: 5ef36b12-ffe2-4c0e-d22c-08dd0a68bc59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFViUHdCSnk3RnhxVDNQT1RrTjh5TlhXNGZacnA2YkdhYlFFejJBK0J3S1cr?=
 =?utf-8?B?ZUZZS0h0KzdocnlyZ0RlUFFpVjFYUUg2ZzF5RnV1aWZkY1Byd2xpUWtGaEFV?=
 =?utf-8?B?T0NDb1NuenRTYkRETEFFcitkaXpMRTNZNm55N1U2RmxLbXhCVkxIV3g3NGlO?=
 =?utf-8?B?MldsZ2t3UHk1U1dXZFNZaUxZQ2phVkZPSGZGMXhDcHdXRlp3S3FMUnZDMTkr?=
 =?utf-8?B?V25pQUcwWkM0WVRnYUlodlY4UWZBQUdTVG84ZGlqeXBlWXY3emcxNXNDSTRV?=
 =?utf-8?B?ZzVnLzUrY3dqN2YxcGxSVmQ5VXAzUDA5S0toUzRFeTZiMmxBLzZZdHR5dW80?=
 =?utf-8?B?dGZMWFZPa21LZjFNd3drdzJGbTllSU1KMVlKaXI5ZGVYeEtra0I4OWVSWHZv?=
 =?utf-8?B?bWlURHZWNkdqbEt5ZURYUjFmTEFSUFV4M2V0dzRwbXNwMjhweVhja1JOczd0?=
 =?utf-8?B?a0pRY2pNVHE3SzBIcTlUZE94ZGVwRjBoNE5wUDJuZ3crcDNCNFZoSElVUThu?=
 =?utf-8?B?QTlVcUZ0VWlDWDlSYWxVS01VaWlqendyMkZCWGVVTThsNlJsSFNiZVp2R0JZ?=
 =?utf-8?B?eUlFTkdHQTd2MTBackdEeVZsQlh6WEs1bFU2dGlnK01PSWVLd3FpUEdtTWF4?=
 =?utf-8?B?RmxvTzVnWkIvS1orVmcybUNOeWtJN0dzR0dPNXRJM3FtRUtudUp4NVBEYjhw?=
 =?utf-8?B?enVqSzN2L2VjZHRaQ2FQbFZETG5NOW05NkR6blhtekNNWEw2K2NWR2tWZGpN?=
 =?utf-8?B?eVZEOEFMVC9iWUNlSDVkMTZ1dzloLzJQNGpCS2ErYk9vbmw5L28wT3F5dzlq?=
 =?utf-8?B?K1BFbzdSZHNxK1RudVpIN2RuM1p1U3hkY0UyaGYvcS9aSk52YlU2NjhUd2ky?=
 =?utf-8?B?QzF1aTkwZVllbTFjZVh1MEZBdGZtMkpHUkJNOGxBTG1ZSlpGOG1xcExPcnBZ?=
 =?utf-8?B?cmZ0TyszbHdzUFlYVk9lNml1bTZMcmlqL0FNNmlNbTY0bThmUTB4TG9pSGFu?=
 =?utf-8?B?VysvTXoydXhJa0tYekpNMUlZLzArRmRIRzBCT0lMMTdvSmd2Z3k3YWVMbk93?=
 =?utf-8?B?YzJUbEZySFpmOHNYQWJGcWxSV01PbDJPblhFMWhINGVoYWhBczNDT2R5cGth?=
 =?utf-8?B?eWgxUTdoYmJ5M1JjbEYvVEVSSUJlSDFSck1Qajh5Zmk4VFBlbHBGMzdQV2ZJ?=
 =?utf-8?B?SlB4eVA0UWF2Qnd1cmE0TTdhUE9xMzNXMnFld0NCUGNsaTdmQXBpTUd2Yk1Y?=
 =?utf-8?B?UkZVa095QjFUaXFGSmdSMlV1bVJianc1djJUZ093aGliWEtWT09Ic3N3VDlP?=
 =?utf-8?B?YVhWTGFGaE91Q1FJS1hqUW9rMWJzRmZ6RTBOZ1RHVTlPTHBTaDhQa2RJZWR4?=
 =?utf-8?B?aUI4TjFRS0N5a2N2VDdCMlBHcE9jVk9PQk9JT2F3R0VpRFplN24vdEd5Uy8z?=
 =?utf-8?B?Y0p3RkZCZnA2N01HcjltTnlXWjl5ME0wUG11KzlQeUtVTUNIMkF1cmhwYkZR?=
 =?utf-8?B?dTZMSFZUaGp0Y0t0ZGFwZ1BzdndxZXM2V2hXSEhxNG9TK1dsLzh1TlZtUUxy?=
 =?utf-8?B?UngvWXAxVjNYNzRXQUVPM0Job0RMemQrbGlROHFMSnloNVBKQ2dFYkVoeFBT?=
 =?utf-8?B?TjN4cHZiSjZ6Qk1Jcy9kejA1bTJhaS9HT0sxZmF3RUw1KzEwYjVpWFgzU1B6?=
 =?utf-8?B?U1FhRXZ2ejY1NE54dGhielBEVkJ3N2N3RFNHWnFDWnlYbXFMamJFYkNmWFBK?=
 =?utf-8?B?ZTM3YndvQnozS0gxRnpoNmtZaGFUbnJSSSszaFBOa3JEOW5KZEhEMVBlODNH?=
 =?utf-8?Q?O+q4YtPZzpQiHJX2vI96SZJZlQH6yDO5DtUi4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjEyblB5TWxNR3dEbjM5dVE4cnZ2SVFLNnZLOHJPWHBWTko3RmhTU0RUaG9h?=
 =?utf-8?B?UlZXM0ZYbC9iRFB3VXRXbEdKcEM3NzVPeng2NEVoNlFXb3hRRW8xQUpSbVdy?=
 =?utf-8?B?elBlNEIvbGdWM1pYQjRwQmRLWEtLcDc4aUJ4VGJJQXYyekduQU5QY2l2ZVpF?=
 =?utf-8?B?dUFDazJrZ1gxYXpUSUF3VERGVjAwWkpkeWlWaU5GeDBsUDloaXlnd2lIZ3lN?=
 =?utf-8?B?RDhOSkVmM3pyMXplcnJPd1ZRRDZ1MjVxMysxMFBVSTVpc2F0Szh1SmJwYlk2?=
 =?utf-8?B?NjNIRFBNdm5nQXpBSmFzalBSdVpWdVNzQ0RrTVIwdHZNRlNVZmNjc0dqTEoy?=
 =?utf-8?B?elRMaE9CaS9NbnJFUXEwNWxSYVRZNzNKMlU4QXhLSXBYUTV6Rlh6cHVNbGJo?=
 =?utf-8?B?bEpaY09taysxOUNQMW9hVnNocElaaTkwYVJ1SlZldVVha0V0M2VseVRCRGk2?=
 =?utf-8?B?blFhZFNicGF4YkFmcUlPM3NFOTNZYjM4TWw1SDByYytKQmVVUG1tVzhsY0tH?=
 =?utf-8?B?aEZXa3U1aHZJZzVGUlNhd2R5VUtmQk9abXl4T0ZacEg1SG10MldiQzVXZHpn?=
 =?utf-8?B?VzFEZzZaSW9qbTRramhZTjlUTElVNFZoVTVXWTZpNVg4ZXk0aVFhWkErY0Nw?=
 =?utf-8?B?djNnQjVLQVI1Y3BzUEI4ZjlkRGNBeEpla0JncHRzTWRGeUk2RW5KZDkvUHRX?=
 =?utf-8?B?ay82NmpsL0dkcjdhN203RHlrSTBNS2tkemhGSC82U3RkQjVrVHA4T0ExaTFB?=
 =?utf-8?B?MnBjd21BSnZrOXRRZm9Kak9NaDNNUm5zWC9wWFNpRDRENW1CUXpRUTN4Mjlo?=
 =?utf-8?B?ZFNhUEJiYkRscWZKTmhJSHRxZHh4RUpSK2l5ZE5UbkpycUNHbmxJdzNheEtn?=
 =?utf-8?B?cFB1TTFkNmJVeFNzUXVKTC9zWEdTTHRvS3FJNnhkbmQrQm9kR1drZUE3VlJK?=
 =?utf-8?B?QkpFamxVVjZic0Mwemg4SGZlNktlVE45MU9WOWt4U1M1ZFllVFIzaWlTZVJp?=
 =?utf-8?B?Q3Q2Sk1MZTIvZlR0TVFmbndzczVISDRwQzVXS1JmMzllejBJbGdNTlV4aGJZ?=
 =?utf-8?B?bjY3dHJnbGlZaEpqME0rQTZBUVU0TEJSRFM3NVJFSlcwYWJqVm1EQ3N5ZUVX?=
 =?utf-8?B?NzMrTHZ5Nm9HRXd6RzhNK25YaHVBNTJyczVNdCt4Qk5QTG42VCt4ejZnTEVw?=
 =?utf-8?B?WmwyUnhhcFMrZCtnbTdMdXJmbnE4cURXRC8xWWhuNmV3QUxGTWdqSzlLZUVI?=
 =?utf-8?B?a3A5L25mc0p0bGJTL3M2NkpTemxhRGx6cDdFTUhBTVVFVkFrM1ZYSDNMKzJw?=
 =?utf-8?B?TkZDb2EzZzJCdEdOaWs0ZW9ZK0VQakVBamRkYm1yRzRIRFhNR0VMdDFkZ1Y3?=
 =?utf-8?B?ME02QkJNMUQzYkQrV1VJbzVaakJ1TE40aXdoQmNwTWlYYm9HUnUzcHFUd3ph?=
 =?utf-8?B?VWVyTFA4VmdXeXBrSXVBQXhzRlpLVS83bUt0SG9oMlhsMU8vYVFvUXlWei81?=
 =?utf-8?B?VnZWSTlIR0R2NjNOT05XUWpxWk0wTTZTL0s5a3RaYXV2SFcyQUdjUWMxdHFZ?=
 =?utf-8?B?TEFpYTltRXFicnU4TjBMT0lnV3VOd1p2Mm5hb2xjcmJyV2VKdy9aRzlabWxW?=
 =?utf-8?B?dVhobEdVWU1DazFsS3JPTmZybGdCb0x6aXh1L0cwZGNqSE1uTG1MZ3NWVlc1?=
 =?utf-8?B?UWlReUFpRGlwbzYxSHVZZE16S1pqamN3Y1NnOUZ2aG5vR2hXYlhxZHU3TnV1?=
 =?utf-8?B?L3RiT0xQS3lRdjBuazdRb0RVU2UyR3dBRTZQUm9NcCtwM25HdnpvUGJPam5B?=
 =?utf-8?B?MXJQVnlrUzF0ZkpqSnpmdW1zT01ZNFFpK25kOGoyanpENDF1UXlVTlZpRy96?=
 =?utf-8?B?UTFGZzB3UEtxYTc1R25vUmc5dHBWK1pkc3Z1NXlkbC8rUG5WV1JMWXpTcjIr?=
 =?utf-8?B?emQwaTI5Z1IvM2tMU2xQTmduMjhOSzMwZEZrdGNONEVwQm1nK1UzTjA3SlV3?=
 =?utf-8?B?Z0plbWVualBUaXBIOEhrdkVVeU9HcGNQSTVSK2pEN0puOUo3eXBIbXhzaFl5?=
 =?utf-8?B?SDdWMnR4YU9SbkpNVDMyQ09vMnNmTDdoTVhkWVFLeEFKZVlja2FmbkZUNEEz?=
 =?utf-8?B?dHNiQ2YxV3Fidkl1WnRkMDIzK0JuZnAwOGp0Uk9xdjFlMlZEU0J4dHFLUFN3?=
 =?utf-8?B?K0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef36b12-ffe2-4c0e-d22c-08dd0a68bc59
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 20:11:50.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHxr1eXpX0RcCiSGhWNsZuAR9bCUBf2/N/l3ZS1u0q5UVfwWtxtSsyjeVONkdGzzBbpsGECmx4WNmEhOTjAz3wIepvyo962PysPyDWM+3UKdotvN+syAwMnK/N8tc0pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ3JlZWFyYkBjYW5kZWxh
dGVjaC5jb20gPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDI4
IEF1Z3VzdCAyMDI0IDIzOjI2DQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggMS8yXSB3aWZpOiBpd2x3aWZpOiBGaXggZU1MU1IgYmFuZCBjb21wYXJpc29uLg0KPiAN
Cj4gRnJvbTogQmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IA0KPiBEbyBu
b3QgbWFrZSBhc3N1bXB0aW9ucyBhYm91dCB3aGF0IGJhbmQgJ2EnIG9yICdiJyBhcmUgb24uDQo+
IEFuZCBhZGQgbmV3IHJlYXNvbiBjb2RlIGZvciB3aGVuIGVNTFNSIGlzIGRpc2FibGVkIGR1ZSB0
byBiYW5kLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxh
dGVjaC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
dm0vbGluay5jIHwgMTMgKysrKysrKysrKy0tLQ0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS9tdm0uaCAgfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2xpbmsuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL2xpbmsuYw0KPiBpbmRleCBiYjNkZTA3YmM2YmUuLmYzZmIz
N2ZlYzhhOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tdm0vbGluay5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bXZtL2xpbmsuYw0KPiBAQCAtMTYsNiArMTYsNyBAQA0KPiAgCUhPVyhFWElUX0xPV19SU1NJKQkJ
XA0KPiAgCUhPVyhFWElUX0NPRVgpCQkJXA0KPiAgCUhPVyhFWElUX0JBTkRXSURUSCkJCVwNCj4g
KwlIT1coRVhJVF9CQU5EKQkJCVwNCj4gIAlIT1coRVhJVF9DU0EpCQkJXA0KPiAgCUhPVyhFWElU
X0xJTktfVVNBR0UpDQo+IA0KPiBAQCAtNzUwLDExICs3NTEsMTcgQEAgYm9vbCBpd2xfbXZtX21s
ZF92YWxpZF9saW5rX3BhaXIoc3RydWN0DQo+IGllZWU4MDIxMV92aWYgKnZpZiwNCj4gIAkgICAg
aXdsX212bV9lc3JfZGlzYWxsb3dlZF93aXRoX2xpbmsobXZtLCB2aWYsIGIsIGZhbHNlKSkNCj4g
IAkJcmV0dXJuIGZhbHNlOw0KPiANCj4gLQlpZiAoYS0+Y2hhbmRlZi0+d2lkdGggIT0gYi0+Y2hh
bmRlZi0+d2lkdGggfHwNCj4gLQkgICAgIShhLT5jaGFuZGVmLT5jaGFuLT5iYW5kID09IE5MODAy
MTFfQkFORF82R0haICYmDQo+IC0JICAgICAgYi0+Y2hhbmRlZi0+Y2hhbi0+YmFuZCA9PSBOTDgw
MjExX0JBTkRfNUdIWikpDQo+ICsJaWYgKGEtPmNoYW5kZWYtPndpZHRoICE9IGItPmNoYW5kZWYt
PndpZHRoKQ0KPiAgCQlyZXQgfD0gSVdMX01WTV9FU1JfRVhJVF9CQU5EV0lEVEg7DQo+IA0KPiAr
CS8qIE9ubHkgc3VwcG9ydHMgNWcgYW5kIDZnIGJhbmRzIGF0IHRoZSBtb21lbnQgKi8NCj4gKwlp
ZiAoKChhLT5jaGFuZGVmLT5jaGFuLT5iYW5kICE9IE5MODAyMTFfQkFORF82R0haKSAmJg0KPiAr
CSAgICAgKGEtPmNoYW5kZWYtPmNoYW4tPmJhbmQgIT0gTkw4MDIxMV9CQU5EXzVHSFopKSB8fA0K
PiArCSAgICAoKGItPmNoYW5kZWYtPmNoYW4tPmJhbmQgIT0gTkw4MDIxMV9CQU5EXzZHSFopICYm
DQo+ICsJICAgICAoYi0+Y2hhbmRlZi0+Y2hhbi0+YmFuZCAhPSBOTDgwMjExX0JBTkRfNUdIWikp
IHx8DQo+ICsJICAgIChhLT5jaGFuZGVmLT5jaGFuLT5iYW5kID09IGItPmNoYW5kZWYtPmNoYW4t
PmJhbmQpKQ0KPiArCQlyZXQgfD0gSVdMX01WTV9FU1JfRVhJVF9CQU5EOw0KPiArDQo+ICAJaWYg
KHJldCkgew0KPiAgCQlJV0xfREVCVUdfSU5GTyhtdm0sDQo+ICAJCQkgICAgICAgIkxpbmtzICVk
IGFuZCAlZCBhcmUgbm90IGEgdmFsaWQgcGFpciBmb3IgRU1MU1IsIGEtDQo+ID5jaHdpZHRoOiAl
ZCAgYjogJWQgYmFuZC1hOiAlZCAgYmFuZC1iOiAlZFxuIiwgZGlmZiAtLWdpdA0KPiBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oDQo+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmgNCj4gaW5kZXggYWM0ZTEzNWVkOTFiLi4y
MmJlYzljYTQ2YmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL212bS5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL212bS5oDQo+IEBAIC0zNjgsNiArMzY4LDcgQEAgc3RydWN0IGl3bF9tdm1fdmlmX2xp
bmtfaW5mbyB7DQo+ICAgKglwcmV2ZW50aW5nIHRoZSBlbmFibGVtZW50IG9mIEVNTFNSDQo+ICAg
KiBASVdMX01WTV9FU1JfRVhJVF9DU0E6IENTQSBoYXBwZW5lZCwgc28gZXhpdCBFTUxTUg0KPiAg
ICogQElXTF9NVk1fRVNSX0VYSVRfTElOS19VU0FHRTogRXhpdCBFTUxTUiBkdWUgdG8gbG93IHRw
dCBvbiBzZWNvbmRhcnkNCj4gbGluaw0KPiArICogQElXTF9NVk1fRVNSX0VYSVRfQkFORDogRXhp
dCBFTUxTUiBkdWUgdG8gaW5jb21wYXRpYmxlIEJhbmRzDQo+ICAgKi8NCj4gIGVudW0gaXdsX212
bV9lc3Jfc3RhdGUgew0KPiAgCUlXTF9NVk1fRVNSX0JMT0NLRURfUFJFVkVOVElPTgk9IDB4MSwN
Cj4gQEAgLTM4Miw2ICszODMsNyBAQCBlbnVtIGl3bF9tdm1fZXNyX3N0YXRlIHsNCj4gIAlJV0xf
TVZNX0VTUl9FWElUX0JBTkRXSURUSAk9IDB4ODAwMDAsDQo+ICAJSVdMX01WTV9FU1JfRVhJVF9D
U0EJCT0gMHgxMDAwMDAsDQo+ICAJSVdMX01WTV9FU1JfRVhJVF9MSU5LX1VTQUdFCT0gMHgyMDAw
MDAsDQo+ICsJSVdMX01WTV9FU1JfRVhJVF9CQU5ECQk9IDB4NDAwMDAwLA0KPiAgfTsNCj4gDQo+
ICAjZGVmaW5lIElXTF9NVk1fQkxPQ0tfRVNSX1JFQVNPTlMgMHhmZmZmDQo+IC0tDQo+IDIuNDIu
MA0KPiANCkhpIEJlbi4NCg0KSXQgaXMgYWN0dWFsbHkgcmVxdWlyZWQgdGhhdCBhICh0aGUgYmV0
dGVyIGxpbmspIHdpbGwgYmUgb24gNiBHSHogYW5kIGIgb24gNSBHSHoNClJlZ2FyZGluZyB0aGUg
bmV3IGV4aXQgcmVhc29uLCBpdCBpcyBub3QgcmVhbGx5IG5lZWRlZCBhcyB3ZSBjYW4gZWFzaWx5
IGRpZmZlcmVudGlhdGUgYmV0d2VlbiB0aGUgY2FzZXMgKGZyb20gb3RoZXIgbG9ncykNCg0KTkFD
Sy4NCg0KVGhhbmtzLA0KTWlyaQ0K

