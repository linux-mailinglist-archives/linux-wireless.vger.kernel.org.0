Return-Path: <linux-wireless+bounces-28783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65123C46CA1
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9113A3AE52C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E21DF759;
	Mon, 10 Nov 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Osm6+rDm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13391E2307
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780202; cv=fail; b=Hl0MJMYfvhBwiMadjqOB/d0jLPYRXcM/nBcICntJ9uuzTi/G7X6wYc+Ejbh5jyt/FJP4CtRCX6kb42ZDSjwitYCoGC7rpjJsdEyUUE3cyHk8uJQOQrc0SySOarGTGDlUNYyVnK86x/1wiWzkFQbrkuOK2f0gJTBvWPeoQ9uv4C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780202; c=relaxed/simple;
	bh=gyJ0wZS8K3gcp0Qks5+yXZpCzp7FPNKPqPYNaa6Vd5M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ekc4hGg9HrBUhRMBY/04cK4ZJF4HAyDfuo2qVAtARqjji9Chbt7nDbHEqjDqEgACp3uTHUO4+jGQanWIYUYkE4cIVIOxZchuY8jp45bpYCLkhK6zHBqT9TBqbJCODGosGWqP3nDcX+D29E2qDXC1+CKRrNrgG3+IOyoY2LFlh54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Osm6+rDm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762780200; x=1794316200;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=gyJ0wZS8K3gcp0Qks5+yXZpCzp7FPNKPqPYNaa6Vd5M=;
  b=Osm6+rDmOc96Ich+q2iC/jOpQmBuEe+2xvy2flwZjrN4iwt8sQGfCIMR
   g8nsy02tpVwR8dgSVF8Ybg91t2HZw/Jm7uBW+5OQNVW4UqDiHJeKQjoOU
   pXHZnHvKjPKTOMbfKRY7p78NIgdIaLnxGbpIlWIS2eSHAt+niXNnqXOqC
   r5r4MLko4MTalzUegLxp7TRaqebnzP2GNwHfUpPyV3//34R1gsEREIIoA
   e2i+OJf2KEyGEACo410dSKkEVQ+uSvS30bw3RP6rs4M9h/v+TTJFhvJPj
   7MYkpjTP0lfbaQBJsBg7yXJOXiBY1P9JuqMflJvjSHJ6zXHvxUwORY54O
   A==;
X-CSE-ConnectionGUID: 5Pw0BnC6R1yFBGfE8+bwug==
X-CSE-MsgGUID: 7E8hrIT8TQi9d2fnFmqY7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64738396"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64738396"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:10:00 -0800
X-CSE-ConnectionGUID: JeICW3uiTK2awMIVDd+1/Q==
X-CSE-MsgGUID: mMLI8q+JRjSMp1A5yjfHOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188311580"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:09:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 05:09:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 05:09:58 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 05:09:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YahxW2+ZC0xsByQIeRwc9ffWS+EBIQAM7CVagzFExb7fpgLOEV8N2/6JB9D8rYRIuyIqO8cs1Q6mRxMM6TR2weTMeWc7DKUwYBSF3JKCURB6RBrcW9/tP5YT8ZT0MJWZLkxOapCXW3Mt2qZBTjJENG41oaJAl2ssE2tFWExyZ/utC8xBUzslA8HDmUqklNggJhZdiAEKbuod7oGdNonr1QqMTXImiVvpCVNKCos8OIZH61Wo8U/NEZibZxqn3YC2dc/4H7b3i0EZbG9UVkkyuP1oBXtHJbNUFjDtHvOv73UkM6SyL/cgxlh+xiJ8qnDCOHOrCHhrA4AjR/dtE++TRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyJ0wZS8K3gcp0Qks5+yXZpCzp7FPNKPqPYNaa6Vd5M=;
 b=K0uNibn7wk4LGOmT0QJYCVfYSDTrdzmodH9XS/pZvX6NkjoVGWJbWBjvUjenD05qy9BAt5WIsILp2x6r8xiNw2DN2P8/vmcijt8xf3CMYNBtkrciFkgZjNRkCNDiZsmobh+FdwHxP+TvVnx50wmfZZeB7mPQbnCE13EJj7D/5IhWDoycbCTynnG5jAPEYvYdQTX3X0kzMZue3CWEjf/a2eze3JibHy4GKMjL2H3UiKYBshEgAJoN9bJva9ZMhcPZrhLpKaHPwIpT0mRO5Df3rXGyOZ0olhz1DR44dy07xQkutiG1hQDyIHa7HPzaLckqPjG+V57dbMP6ed3+Yj9bNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SJ2PR11MB8588.namprd11.prod.outlook.com
 (2603:10b6:a03:56c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:09:56 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%8]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 13:09:56 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 02/21] iwlwifi: drop unused BITS()
Thread-Topic: [PATCH 02/21] iwlwifi: drop unused BITS()
Thread-Index: AQHcRc4YJvT3oow4nkKniFkw84o1hbTr+omQ
Date: Mon, 10 Nov 2025 13:09:56 +0000
Message-ID: <DM3PPF63A6024A93A3E4744A241AD130291A3CEA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
 <20251025164023.308884-3-yury.norov@gmail.com>
In-Reply-To: <20251025164023.308884-3-yury.norov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SJ2PR11MB8588:EE_
x-ms-office365-filtering-correlation-id: fa87dbe0-ece4-4739-ccbd-08de205a71f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ckNpeFNvL1BldkczWUdzUExkQ2o1SnpRamFMbjhmQzdwaTF1VnQ1a3ZCOXM2?=
 =?utf-8?B?Rmd2U3VGeGhCeC9oTHJPNno0RWpqMGIzY1lXeHNmOCt3aUhhcHdpam9WV0k5?=
 =?utf-8?B?YVM5eE1yQ3Jvb1c2SkVCN0YrVzBENisyT3R0TTVXNVZSdThDSzd2bm5IK3RG?=
 =?utf-8?B?OVZ6YnFhbGFJM1VoT1lmQk15Q0pzcGowM2tJWlZEUlZoQ0dmQWY4OWZQV2Y4?=
 =?utf-8?B?eVM3WFJKOTZBZG9pV2RSc3MrRG9CSXY5cmNycUNBTDFQNkpwN0p6TGYzTnpD?=
 =?utf-8?B?R1JzeVZmMXpQc0NTZXg3ZEQwWnZOMDNCcy8yRGVLSjBTeURhVmxSTFdNK1Fo?=
 =?utf-8?B?ek4wOFVzNUJOV0NoOElMekFYdW9WM2VqenNZMzR5aDdKZlgvQmVYUGJaeGUw?=
 =?utf-8?B?dnRxaDVIZlZac2cvRWxKbmN3Y0RFV3hUQ2hEc1kxbVBmMlpUWXFxaDVSTEZ1?=
 =?utf-8?B?bURubjBQaGdFQk5LdkZLZWtYVklQb1U0aTAvN041eVdKQmowUXRPNUk3czBU?=
 =?utf-8?B?NUhndElnYVV0UXUwdFNiYmNld2ZnamtvYkxxY3VtcjRWWkdIUklpOVpkOUpj?=
 =?utf-8?B?MWFVeFg1dDBjWXE1czFqeW1VSXoyKzFrd2FQV1RRZmtubHlTSU50bStWMy93?=
 =?utf-8?B?UDlhSE1oNE0zZTN6SXF2SUE2Z2JHaDF5OWRxcVlYalExMHNBZmJnU09NWkhw?=
 =?utf-8?B?QXh6elRpaGl1M0lrdm1iYllsSENCRnY5eWtrdG9nT3ZFcVdGMHVkQkZHSTMv?=
 =?utf-8?B?NEVlcVl5UFFDcnZjSkF3RjVYWFpPYjZUdWdEd08zbVd5endmbUdaa2ZWN1Ja?=
 =?utf-8?B?dlJaTWhyTGRDekpuZWtpb0srSHVsYmlPWDdHRjM4d1pRNk4rU2tIWC9RTDVL?=
 =?utf-8?B?d1RQeU1WWFZTVkxzYlN1OHFjNkZZUUJDeVZBd3d4TDFIa1dwbXhGcGwrOXcx?=
 =?utf-8?B?akJQbkpYcTE5OUQ3aXRIVkZnU0pVNGh4NUxaUjF6b3U4QVZlVWd6Y1FQcUty?=
 =?utf-8?B?c2ptVi9OQWdEL1ZPZ1dyNFJsWm0vNHpRekhUeFZxdmJOK1ZEMjdNTDExQmRI?=
 =?utf-8?B?VlJHRytDMjVKMENhRWVwZlN0YjYwR01Kd0R6c3BFcnNOekhnMTUzTVU0NEZC?=
 =?utf-8?B?T2krb2ZRZlQzaFl1dHQ3UWNjdzhxV3dXZnIrVG5jbXc3UWp1VUFMVVJQUTRq?=
 =?utf-8?B?UUgxVUxIQ3NnTkJZVEhTVURjaVMxQ3NLOXg4RTZYMmV4QWxHZDZmOWtEUzNL?=
 =?utf-8?B?SmV0NG9sYXVybVc5WlJ5SmU1cWhic1hhaVFma2x5Mzc5MGV0Q1NzWVcwdVA5?=
 =?utf-8?B?R0NlYUcwdFM0Yi94U3ZoSmUxaFhXd3R5NFVIZ1ZqWVhXeDBqdUJQTFVNZ0NI?=
 =?utf-8?B?VkZTSE43TklkS0N3eFpFemE1UWJWaS9IcWw0a0prLzUvYnRaSkVLc0hkWWdF?=
 =?utf-8?B?allhR1VTazJuaVA2M1VmWE1rRVlJY0FtSkVzMVV1MDUwUmF5Y2tKNnBVV3ZU?=
 =?utf-8?B?VXhhM2d6L2hub0FFMktnRHhEQk40ckNGY1dCTVN0S1MrS3JIbi9pRGROVERI?=
 =?utf-8?B?NDJoKzhDMFF1N2FKUlMvdDZ2K2FPYkVIcW1RTU8wVlNvT1p3OWFUb0psQkN2?=
 =?utf-8?B?ZmZ6VTV0aGtMV2M1QlpRamxMSUxHN0s3NGNTcTFnZ2dtZ0lUMHByR1NhNHJ4?=
 =?utf-8?B?S3lML25sSUd5UTdDTUgzV3J1VHNYU3dwanZoK3BFcXdPRVkwRHA4V1Ziaml4?=
 =?utf-8?B?Z1d1a09zT3lpVG1wZU1sdHppVkF3M1o1TUNjc2U1SmhTYk9qb2V6UVRyMFFI?=
 =?utf-8?B?WGJScGMwcVEvWXhBa1h1TEZRb21RSzNIYjlUdEY4dUErb2ppNzJVMktqUlZ5?=
 =?utf-8?B?WExUM1p2RjhBbU1kWVRlUGdNUFEyeERGYlNzc0hDKzZFVXV3UjZFbmxWZW9F?=
 =?utf-8?B?K1FqeVBuZG53cWRuWG41QVFjQlV6UUREM2k1YVJqWkxKKzY4WkUzS3NzTE1k?=
 =?utf-8?B?OGd2MncyN091aE1QRTZiZHVaZVAxRkRTYzhsaDJ6dEhyMjhkZE9tUmVkdDNv?=
 =?utf-8?Q?zLkxMP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHJXb1V4cENSR2hsakxoKytjQTRUZkxuVU9sYXAyRXhhRVNVdlg3Z3c1R0ds?=
 =?utf-8?B?NWxXL2psUEJsdzF5OHpYbi9uNzd3WjZwVVBnalQxYjhvNG9tUnpOdDRGTzBJ?=
 =?utf-8?B?WjgxZ3ZhR2g5djRhT2tjckZBVmVqbXdDdnRHTHduU2FEZ0RCSlRzR0JhcHRs?=
 =?utf-8?B?TlNPSzQvK0FTVVc2RDkvZENIcWw4SW1JR2pnQVQ5dG56L282aisxOTF1WU5V?=
 =?utf-8?B?bzBDUGl0QUhIOXIybU43bVYrM2NkR3F6RU1hSUtXeUZ5WDN2MXYzRno0VjNU?=
 =?utf-8?B?VjZSMzc0SzdOU3MvV1JIZHVudWZ1bDRrbEdjR3ByQjFEa01GVDZYVi9SMi8r?=
 =?utf-8?B?cXo3dDA4K1BUZzBycnVmSW45NjFJVnRsSHMwZlhuN3I4ck1NZ1h2TFlaZE1S?=
 =?utf-8?B?WkR5UCtVRlBVamt5enBLUzI3L3Y4aFA2aGQ3KzBJWXFEVmd0QjBhdkU3QUpa?=
 =?utf-8?B?Tnh5UFNwNlF4VnVYNU5qNUN1T3RveVFoSGZIMUxxbzFDRGRlSFdqc2JiNFFh?=
 =?utf-8?B?dmhaZG9zVTM3S043S3kwdytTa2U0TXFFcFV2MU1yM2gyTktGaUFtbzVQU3g1?=
 =?utf-8?B?ODkrRWpycDBaeFd0Ri9uNEkwVHBpNnk0dGdGaXJNQWlKNFlTNlgvYmF0MGhF?=
 =?utf-8?B?aXRxTytjUVlsU3JSeXFDMWhRcmkrT0tnVFJwQWRzYWZXZXNsVVFlaEtSQVBj?=
 =?utf-8?B?dFR3WkxNTXhuUnNWdVl0WXA1cGxHdjBQZTJpTzZiN1VvK0F4RXlTNVhFNHZm?=
 =?utf-8?B?bWJLY3Rya250SzZ5UTJOdXJWNExBNGNOejdaeHpoZ2x6VlMzLytGbmdRVzVk?=
 =?utf-8?B?Y0dDOXFyRzdFamRzK1Vsa1NkbTIyMnpuUkpvRy90ODFJVkUyd0szajVxUTI0?=
 =?utf-8?B?QWh5dUdRcE9vNmhXS1orbDVpTU5XQnM4WkR2bmhSbFFxaWZ2MHNhS1hucWlk?=
 =?utf-8?B?V2I2WUdyb0VHS3ozNVdkUThIeTV4MFJFSUxVYnRDdjRMODhsRkxsNlBtYWRp?=
 =?utf-8?B?Y3huNVQ4aGJtR3hxbDhMTkRIMitmcm1zU2ljRWFJUE51TlBTZU44d0dZdkQ5?=
 =?utf-8?B?bTBsQU1KYi9nMWdRYUhkU0JJU1k1RVJ5WVFuczZPYVV3SlBmZWFoTTFvclRI?=
 =?utf-8?B?WWN1aUdNR0RqcSt5S1FNZDFSZFVFM3VHWXdVa0JQLy9WdkdJMGdDbTBaMXBB?=
 =?utf-8?B?QnFyekU3bUJvaTJnV0JvNXNudUo1VDVnZXZqRWxpcXdpQWVxQWhFd0NPcVE4?=
 =?utf-8?B?ekZhbGJPQ0plWFNpOEVnNmpkL2dNSDhBL0RuVHZKWGdqVU1mVENxWmxlVHFi?=
 =?utf-8?B?YUlqbkN5a011dzBKY2V6QzJLVFBjdCtvalk4OXRiRjFUcTZibjJGd2NXaVFQ?=
 =?utf-8?B?cHdQM2lEZmhrWFQyRUZOeVZPejF2YjN5aTN1UTloK2tsN0N3WHlXOUpjcDQ3?=
 =?utf-8?B?NnR0SVFmRmhucVhBdUM2VlE5bFdzd3VDcGNDdWF2ZGJhOVpTanZTd1NGZ3VF?=
 =?utf-8?B?ZTltS0UvQ3VYNHNFTkN1c2lmTDkvREJEMnJqaUU5Mlk1U1Z3K0hlWmNiekJa?=
 =?utf-8?B?Sm5DTmhyMVMwY29XajFnQU9wbzY1NGhBcEJwdTE5bUh2UER6YlBOSUxEM0xG?=
 =?utf-8?B?TnNNTm8xeEYybG5UWXhEcjdUazF5YXVtTjFTQlRmNzUrbGhuUXZ0c1VNWmdC?=
 =?utf-8?B?blZKUFhIY1NNUElYQXNuMXAvYnRFY0MwVHh0cFRBR3hjNkppeDY0OXVGaUgz?=
 =?utf-8?B?RDBVN1hYNVUySU1qaUZjUnRZSGJsenk1SGJMU1FGdEh4WUZuUERUd0xKZkMz?=
 =?utf-8?B?MFMreWFkTFpJaGFxYTNTSHlCSnp1QWlCSWplWVFNTjVXaXE1a2drUnhOanFV?=
 =?utf-8?B?eUlNenZqNzJRU2N5K1V2YzNrajl6bW9tdHZIQmZQUkwxSzRoTzZMQmdaNmkz?=
 =?utf-8?B?Y2NsS0FwY2J5cC9oRE91aGhGS2xGUUlBb2dEM0RrSTlHTG0yVlJvSmZ6K2xY?=
 =?utf-8?B?VUN3NFpnUEVhSFRuVGxvUW9XN2FOYWFtUFdJc1g1bkRTK2p2V2RLVWg4TnRa?=
 =?utf-8?B?dytmUnphc2tCVUxQWUs5UFBqL0V1ckc0QmxUZm93dGhnWnd5bWtUSURMejlB?=
 =?utf-8?B?T3hVTnlEc0N5YlY4dmZraWV5Y0hscDRwcjhjdWcyVWdzVHU0dThFQWtUU3VM?=
 =?utf-8?B?clE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa87dbe0-ece4-4739-ccbd-08de205a71f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 13:09:56.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJZ/WLPdJmuf2tBSsNwtSEJ4TQViFiLUGWN0QV24919titUUIQw422kQKLpNrC/px2JNPiUjcbJX9LNhd6b0py8OwyOouGGhu+u9HRso21mvltf2YINBqAG+BekqNnQC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0ggMDIvMjFdIGl3bHdpZmk6IGRyb3AgdW51c2VkIEJJVFMoKQ0KUGxl
YXNlIHNlbmQgdGhlIHBhdGNoIHRvIGl3bHdpZmktbmV4dCAoW1BBVENIIGl3bHdpZmktbmV4dF0g
Li4uKQ0KPiANCj4gQklUUygpIGlzIHVudXNlZCBpbiBpd2x3aWZpLiBEcm9wIGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogWXVyeSBOb3JvdiAoTlZJRElBKSA8eXVyeS5ub3JvdkBnbWFpbC5jb20+
DQoNCg==

