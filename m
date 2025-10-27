Return-Path: <linux-wireless+bounces-28297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C98C0D1F5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BCB188F30C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903614386D;
	Mon, 27 Oct 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMwTP/nv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036AF7404E
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563839; cv=fail; b=Yn2kUItZWnttukJgpt22xZoNakj6Mr58UPZgvIOiROisRJuPaEJCjfCrIq1+hP5ozuOg3BrNIefpagvO/HiWBkAD59/AhVsxyI+6TBd+jXkTNBxNvDpYaEY9NHaCmyvf7jfcW4FeuF8/kjOyXA/lRJxUjAOqgBbTYk/VKl07LPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563839; c=relaxed/simple;
	bh=UwIsJyRR/WGDLYOejD+fEZkCHHuaIBzKQ4wXDWst0oE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AKFuEPJOp6aqprYIMh03B4B9Z/VrdPSFN8+4JODpUHz0RxgVkjtry7fY5gxckpEEqVkbJvQ/NEmttBlBssUMyWXE3Ru69+1E1Nu8bT+eaYOmeXUuoH7Q66fIjdgVgKld6jc0mIukKTqoVLtWHTh8eChle0mUI2X4k3b6Qxg/d2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMwTP/nv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761563839; x=1793099839;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=UwIsJyRR/WGDLYOejD+fEZkCHHuaIBzKQ4wXDWst0oE=;
  b=DMwTP/nvwFLQD4+7fBoToe7ZLfcQ4oxiANbv1ehBJURqgDIvPheyZBYl
   OYPm5iv4Ur5Yt4WigcO1bwCbN4I+p4huJjHIlv/Dqd6w4fnATBvlsZBDD
   IR2X9c4v9UF3Shh/M6iNYb1Fc2c6nQ5j8b3YhB8AN5jzWjB7EcTdWZ7uf
   ZeMemwVHjzJfZs+3XtL7VZaeTkDy1n+00JAOxcwGVvwHoGG39cLlUEet7
   SCu/LEF9snqbX1T7b+m3c+cHrN4Ao4hKhtkyGVeiew3Czs6FSsJOodONe
   aJoiCluqAHcryHio9A1pbUzM+tYhRgkjJUPX4kD4Ok/EmBuFr3wKqQPAb
   g==;
X-CSE-ConnectionGUID: pnFTS2Y7THujx02yt82d/Q==
X-CSE-MsgGUID: kyqJaKrFR/O1lH7Lp7gnAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75086349"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="75086349"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:17:18 -0700
X-CSE-ConnectionGUID: SRRzFyoNRCWlzLTUlm+kIg==
X-CSE-MsgGUID: RL0NQhhjRcyOfKtriw7d1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="222228069"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:17:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 04:17:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 04:17:16 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 04:17:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDeRn9gGwUkXdktBx107WcBvYUgzhkpSSptkbseEhpkVQBIF2jPbfEamPewdW/dsj39sVAaFhFa2c6VfIbuR6CfR9sfSc/88lbes+NkFXeK49JeMwZg1kfwoE8UHt5pLAJk1ah04RbgrUWBfX/G4I50vSxvUvS0WV8W+QMAF5zSgZ07K020OQsb2sQq9/pRe+TO7zfRpq/MIpu9TnGwRZDr7KtIm/NI4BkmxML+bfpGe5AAbO/Nid32HibzHjz+cEI8mfkt8NhyTZAuoWtGtjLNmyki1R/wDdqM1vqb3lgUjxwVZJZ3/au0bR+EguM7LiSNmryYIsUDbcIzJ5LvYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwIsJyRR/WGDLYOejD+fEZkCHHuaIBzKQ4wXDWst0oE=;
 b=vgSQB6cHtwgkJKofNAG1iZz9FxIo5sWvP2r4GDJv2RQvhcDxEwLZYGfsVMUO1dmrtIkVb2Zc2PZkzf7RFv8NoOVdntxwHHEKbdVc8F2jVBpvTWmus8Opmz088CbJ0T57jdvaLlKOs+2huu6JXSWFWcbbZ/rMr8F8vpbajt40m0VydMiB6EX9RpgniKWEXndgmeVp2rTpNnSi/LIfQGktT+ykyStV3KVpOe2eMYhHNBXZ5F9QPzLprfIcxGOU7J3zhWY8P0cHL2oSGzk44EXiOef+kI7eG2r+oO2KYttFCmz0HIA5JAXqmZZUCLW5eprYt9p1fsSinNhImWbf+7zZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MW6PR11MB8312.namprd11.prod.outlook.com
 (2603:10b6:303:242::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:17:14 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%8]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 11:17:14 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Linux Wireless <linux-wireless@vger.kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>
Subject: pull-request: iwlwifi-next-2025-10-27
Thread-Topic: pull-request: iwlwifi-next-2025-10-27
Thread-Index: AdxHMxs1Bg1rvWbuSZ6L/Ex4QhrSLg==
Date: Mon, 27 Oct 2025 11:17:14 +0000
Message-ID: <DM3PPF63A6024A978F4287C4E7D79D5427DA3FCA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MW6PR11MB8312:EE_
x-ms-office365-filtering-correlation-id: c81a3cb4-ba91-4bff-12a6-08de154a61a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cVJWL25ISEl4MFFvbm9TZnNLSFBRTUgvVmc3aEdpanRzeVd6RStZOGdqRXNM?=
 =?utf-8?B?dVlCY1pIK2NwT2paZHA0dkNGOEIzUEwzcVJNZW5EVUhMYzhGSmhKa3l6bDFG?=
 =?utf-8?B?NGRuYkc4QTRYeTBSZWlxTnFrQ0NVQ2IwUmZSeDUxTkp1QUUrbHY5dU5BNnVn?=
 =?utf-8?B?NHJ6cW54NTlEUWkrb29MUnA5bmhDb0Y2UG55NmlFanBrVk1EazB1cHlkaXEw?=
 =?utf-8?B?MXhuSVdEcmdFNjhlNGlSR1ZmYXd5MGdYRDVzRWVKd3NISktrYzdzam5tU0xF?=
 =?utf-8?B?SExSVmhMSWNrdS9tQW5OSFlmZTlvUGV0bysva2RVeFU0WkJ6c3E4dmFkeFIv?=
 =?utf-8?B?cUJOMjltbjFrQ1ZFTHRyYStGYmVOWk1GWDdWZE03cGhDdmdmYytkK2NpOTBl?=
 =?utf-8?B?QXR2UFlNV1BEeTRIWnhaczJ0bjhObWtGVjNGVUZDa2pqYnFWdFBBaXliT0xJ?=
 =?utf-8?B?c2g5OWpIM3J0UlVKOGZJMDk1RktnVmdGQ05NSXlSQ0V5ZUNPVTI3d0hlNzlI?=
 =?utf-8?B?OU5XN1dQa21tWW00c2dHMXM1RHE5d3R1NGhqcmt5RkszbXFFUkF0QUpRbGti?=
 =?utf-8?B?cERodVl4blpmK0NVQ015b1Vub2wzM2RGdCtmVFU1Qkx0cUZ3TEhGcnNEVkEr?=
 =?utf-8?B?T2VLUklPaDk3YWpkSElvVDhMYXBDUHMweTQ0Q082UkhMQ0tBdFMwakI0cWcr?=
 =?utf-8?B?bVY2bk4ydWFSTUFxUmdNYjlhMzRwdzRzVm5MRjUrbURydjFqeGY4eUd1YWpm?=
 =?utf-8?B?NzNOZmVqeWlGS2NFUFRWeFR2cm13NWVGSTBiWFI1OGpWcnltNWZsaVZDRG90?=
 =?utf-8?B?VUV2d05QTUlIRERvVmxlTkNzTUtsRXNxV3EveXVwSU1iVGtCMUJEWHJrc1k1?=
 =?utf-8?B?aUhJMTVpZnpGellYOCtBbG1VYkRKUzBRVmdPMEthWnNhd2RJdmdXV0VRbGpa?=
 =?utf-8?B?dUxUVmJ3TmdsbE5hck1pZGNXNGFKR3ZIaTh3KzZLb1J6Q2ZBSk1jNGduT3VO?=
 =?utf-8?B?M0EvZG1mcmRMVjdlYjBFeDZIcFd4dGZzbUVOVmsrTHhqT0JsdFI1ZWtsVjNZ?=
 =?utf-8?B?RWlSeHMrMFBhNUJ1Lzd0REd4VHFxUlpxZ1I2RUVkQWUwOHhrbjFZOG1mQ1Qy?=
 =?utf-8?B?SStmdHZjUXNoNURGbmcyU2I2Ukt4ODB3dlc1NzQ5UnVrVUQybUdPL2tqYnBS?=
 =?utf-8?B?UEg5ZUFSL2FMKzF1b2Q2dm9XdGtyMy8wZEoxQzNDOTExU0lmK1pyM21TeGtl?=
 =?utf-8?B?b1ErL1ZWcitHSTZWUkdsVjUxWVFXSVJ0U2hHdnJ2RW1zUDkvTDdDTjZ4NW9W?=
 =?utf-8?B?ME50dmtzdXQwQWlIKzg1Y2ZoNjVHZDZ4L2w1Q3kveEtIR29BckZhVmtsREJE?=
 =?utf-8?B?dFhmcWh4OGw2SENPVjhUVGE3UW54cXNGb3JPcnFQOTFjdFBrbVIwVjE5ZDF6?=
 =?utf-8?B?Q3Y1akRkMEFKTWNjcTZEcVkxeHJsNy83R1A1YXNKamg2NUx0TTRVZjFCeStM?=
 =?utf-8?B?c1VucXRlc1RYdXlqVVJkcVNzTFEzMFdrZVVPSjVxQm1TSDBHODBYN1d5eUlX?=
 =?utf-8?B?RnpPL1Z4VzdnYkRRUy9RU29PbVlDL09KYW9QRHdZaCtEa0JXMXZWcE5pTjA1?=
 =?utf-8?B?UFY3MjYyS2ZUQnBuMDd1b0pRM0xWNVpaQ1hDN3JONWlBRmJHVXVMMSt0ZW5u?=
 =?utf-8?B?MTdMVDc5Qm5PMjNmOXJRNml2TGJOZHFiUDZEVGFHWmptNXZocmFMSHpMdGph?=
 =?utf-8?B?TDdOM2thMlFwMExpSFU2ZUUzVWtqZExoaldHOE5jMzFZcERMZ1pFcVAzQnNY?=
 =?utf-8?B?bHJ0MXhnVytvWURxUk1CdmVpNEQwa0ZNV1pIWWNCTzJVaFk3TXJuMzExaUlz?=
 =?utf-8?B?Y3pYQk1yaTZQZ2dVY1hzbFBaWmExMWZhc1RpbjhzODc4b1hZWWNKQ1pEVjhm?=
 =?utf-8?B?OFkxdjFtb0dpYmxaK1hzQ01ZRWhXbjRBcDIxT0JGSHE0bVlXMTM0aVMzWmt2?=
 =?utf-8?B?M25tQWx1ZmZkek4wYlVsUmZ2VWVLb0t2RWtPbElkQVdZMVljalpBTm82Y0oy?=
 =?utf-8?B?dTgwREpLaWp6Q1d6V1lrSHkvaUl1Vm5JUWkrdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2d2RkdReXVIcGN2T2NyZEJyU0tvQ2VOekRpWUd2Q082NEZDZjlXMkNrcXV4?=
 =?utf-8?B?ZjNBdENsNjlodnQzVFc5YkptL1M5dzdES2hRLzlPb3FNTDV2NTlLcFlVcnlt?=
 =?utf-8?B?RnJuMXBWTUU1b2xYZVNuc01raStFU2dlcU5vZEx6K3NjUDYvZHA1dWRtMGFp?=
 =?utf-8?B?aThrZVFEV0NEbTR2ZzdtKzRMcG8xcy9MTlNjWVF1amc3Nng4RkZaaWkyc0Uv?=
 =?utf-8?B?Q3lVWWlEM0hWdSt1ODByK1hjNVZnY0NGek4wZmRlSy9TY0I1Y1FoTmRPTDFn?=
 =?utf-8?B?dHRuT1V6ZHlXZkhORzgvSkEzM3poNFIweVlKQnBNT1JaUWN3WjRPaXNSZDhO?=
 =?utf-8?B?WmZKamlrNW8wNEZSQ2JDOTkxWlVMbUVoQ1Y5a04rNEwyRmxlWE5NRGZveEVi?=
 =?utf-8?B?ZUMxZ3M2aWhUSVg2dXpKRERnUGV1ang3TUMzV0hyRld2OWZlanMvYnpkbFI5?=
 =?utf-8?B?OVJsclkyTlByaDFwMmlUS2I5RnlnVXVmUVZEN1MrU3BWMSt5SmJRL21GVDIx?=
 =?utf-8?B?cU0rQU5sekxXK3IzQzFoV1RhUXlXazJyakJCRHdXMFhiZTk5L3d3WW1pcVEy?=
 =?utf-8?B?OHppRDQzUElRbCtYSUowV0d0QU5BZy96SUxmQ2NIdmZOMkloOStlS2xLZmpM?=
 =?utf-8?B?dVBMUlRaeDA1bGZkVEdkTEF4RjNRalF3SkZpcllJcmtwd1BwT2J0VnlCV0xF?=
 =?utf-8?B?OUwxcHZoR3krR2dSOHgxUStyTGJ6SjdZQU0yeEh1TEhjMWwrUm5nN2I2UGwz?=
 =?utf-8?B?MzZtTHc4NHhVQWVld29qNWVJelhsR0k1YjZ1RkRlcjVHQTF5N2wwS3FPVEt4?=
 =?utf-8?B?d2x5UXlDMVFpT1lSVzZBL0VTNFBjZGZqVGIvTkpFVzNWRkdpaHhHZzFQN0tm?=
 =?utf-8?B?ZGlDZDNCSndBV1hDUlFqb1NMQmZnT29aYzkwVlJlaFpmanZXNDEvZCthQzNK?=
 =?utf-8?B?NjBLV1Jxalk3SVVOZG5ZRlJnNzJDTXFOaytxelJBN1lGemIyRjh0QjdHSUtO?=
 =?utf-8?B?blRYZFkxRytFYll3c1dvY01OVisvVGplUWlubXVndWhIdm5FMXN3Uzhmdm81?=
 =?utf-8?B?bTNmT1BGaFdBMUd4SE9NakpQc2VLM3htOXdwYW0vSWtZdGxyaWxNY1JsMUlv?=
 =?utf-8?B?ZGlaclNRZ2NvTWdxcjNtaWZCUmhFZG1YWFl6NlRoSDQrd0J1SDRYbFB1SzJt?=
 =?utf-8?B?SS8rRmdhZVN3Mjd5SC96NGNvVkZVVkVmcDdieGVhSUI4WVdtK3NSaDhhQ2xU?=
 =?utf-8?B?WGdqWDg0bGxDU2xaVm5MVEFsNmpRTklMVkNWdlFPalRhTExIVU1FWW5PdXVT?=
 =?utf-8?B?QVQydHhOSWN0VVhmZTlnSFhzaW5MMThWU0dUTW8wdTBCTGZVTGloQlFtYldZ?=
 =?utf-8?B?ZHV2T251WWVWK1NCcDcyZ0F4czk2WTlTZ1ZNa0ltWk1PRE5FUXBJWGNTK1Jo?=
 =?utf-8?B?RHZZNjJ3T1VWUGE5NTZXVWQ1TUZCM3E4L1FsaU1xTjRIU2hGYzh4aGV4NkJx?=
 =?utf-8?B?RFZOdFdRbDN4MDQ0RWpYc2NMN2QvREFGbTRXQ1AwVDFFVnpqWTNUSjZ2eEJB?=
 =?utf-8?B?cWI4TFRydWZ4WngwWWEreXFuZWxPYkwrREJCNzNyZWZ2SERwZitVN3NmaGJ1?=
 =?utf-8?B?T1ZMZnlOUEtzSHZhNmF3TkFjMmNUeXIvSVFCYXZtVEo4aGJpamlZQVUrNXJU?=
 =?utf-8?B?aE8xMTdOWXNqbXFhQ1Z5blhhNGJnZmlzeFFVZmU4NVc2QWd2YXVseUg1UUlo?=
 =?utf-8?B?YmtyZWFLTUdsUnBMa0NKcDBzNmZBbldmVVl5L3pjZjlrbDdhMERIK0lOc3Vk?=
 =?utf-8?B?ODJGV0NFVFJFQ2dNMUJHNzNCbTgyZE1Ec004UXBIcFE1UXpIMnpRenZURTkz?=
 =?utf-8?B?dE9CSlJTTytvaTc3NmFMTnYzY0dqZHo0b0Z4ckcydzB0aE16TzBpN2VPdG1R?=
 =?utf-8?B?MzVkbkJwTkwycEhpYWJkdzN0bG1wQXhHVG1KVU5BaU1MUm9qa3JTbUVBZ0U0?=
 =?utf-8?B?ODVOZVFENk1RQUQ2ZW50SGM1MzFWRW0wUzBqcVZvcW9xZUpSdGR3bWlHNTJo?=
 =?utf-8?B?Y21USXZma0Jjb1BrNjJuOGxFRTFIc3NOQUdKNjhaNVJvSURWZEJyZnZRTGhP?=
 =?utf-8?B?VGhScHE2eEljSUc4aUVvbTY3MDFwYlFId2I1Mk9QSncxN1IwTnlqMlRmWS9Q?=
 =?utf-8?B?M3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c81a3cb4-ba91-4bff-12a6-08de154a61a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 11:17:14.2479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a55VvYRmELhN7qOUeSHzPYmheeufFEYR4Mx1FAcoJw+VupgWW9T0RbH7YCcyeaKbgkc4fbvquc6jg+/E++2SPMrc7qCXcwcF9TJIFI4gpI7AE6EiU6HAAQXIgNUSUvBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2ZjRmOGFiYWQ0ZjJlNGY2NzlkODhl
YWUwNGRjYjY5YjJhZDdiZDE0Og0KDQogIE1lcmdlIHRhZyAnaXdsd2lmaS1uZXh0LTIwMjUtMDkt
MDknIG9mIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3
bHdpZmkvaXdsd2lmaS1uZXh0ICgyMDI1LTA5LTEwIDE1OjA4OjU1ICswMjAwKQ0KDQphcmUgYXZh
aWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3bHdpZmktbmV4dC5naXQvIHRh
Z3MvaXdsd2lmaS1uZXh0LTIwMjUtMTAtMjcNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIGE0OTg1ZGQ5MDJjMmZhNTFkMWM2NjAwMmVmYWIyZDgyZjI1OTU5Yjk6DQoNCiAgd2lmaTog
aXdsd2lmaTogbWxkOiBhZGQgbnVsbCBjaGVjayBmb3Iga3phbGxvYygpIGluIGl3bF9tbGRfc2Vu
ZF9wcm90b19vZmZsb2FkKCkgKDIwMjUtMTAtMjAgMTU6MDM6MzggKzAzMDApDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cml3bHdpZmkgZmVhdHVyZXMuIE5vdGFibHk6DQoNCi0gVW5zdXBwb3J0ZWQgQVBJcyBjbGVhbnVw
DQotIE5ldyBzbmlmZmVyIEFQSQ0KLSBzbWFsbCBidWdmaXhlcyBhbmQgZmVhdHVyZXMNCg0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KRW1tYW51ZWwgR3J1bWJhY2ggKDUpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBz
dXBwb3J0IGdldC9zZXRfYW50ZW5uYQ0KICAgICAgd2lmaTogaXdsd2lmaTogYmUgbW9yZSBjaGF0
dHkgd2hlbiB3ZSBmYWlsIHRvIGZpbmQgYSB3aWZpNyBkZXZpY2UNCiAgICAgIHdpZmk6IGl3bHdp
Zmk6IHN0b3AgY2hlY2tpbmcgdGhlIGZpcm13YXJlJ3MgZXJyb3IgcG9pbnRlcg0KICAgICAgd2lm
aTogaXdsd2lmaTogZGlzYWJsZSBFSFQgaWYgdGhlIGRldmljZSBkb2Vzbid0IGFsbG93IGl0DQog
ICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGNoZWNrIGZvciBOVUxMIHBvaW50ZXIgYWZ0ZXIga21h
bGxvYw0KDQpKb2hhbm5lcyBCZXJnICgxMik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IG1v
dmUgcmF0ZSBjb252ZXJzaW9ucyB0byB1dGlscy5jDQogICAgICB3aWZpOiBpd2x3aWZpOiBjZmc6
IGFkZCBuZXcgZGV2aWNlIG5hbWVzDQogICAgICB3aWZpOiBpd2x3aWZpOiB0ZXN0czogY2hlY2sg
bGlzdGVkIFBDSSBJRHMgaGF2ZSBjb25maWdzDQogICAgICB3aWZpOiBpd2x3aWZpOiBmaXggcmVt
YWluaW5nIGtlcm5lbC1kb2Mgd2FybmluZ3MNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogdXBk
YXRlIHRvIG5ldyBzbmlmZmVyIEFQSQ0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBpbmNsdWRl
IHJhdyBQSFkgbm90aWZpY2F0aW9uIGluIHJhZGlvdGFwDQogICAgICB3aWZpOiBpd2x3aWZpOiBm
aXggYnVpbGQgd2hlbiBtdm0vbWxkIG5vdCBjb25maWd1cmVkDQogICAgICB3aWZpOiBpd2x3aWZp
OiBidW1wIGNvcmUgdmVyc2lvbiBmb3IgQlovU0MvRFINCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12
bS9tbGQ6IHJlcG9ydCBub24tSFQgZnJhbWVzIGFzIDIwIE1Ieg0KICAgICAgd2lmaTogaXdsd2lm
aTogbWxkOiB1c2UgRldfQ0hFQ0sgb24gYmFkIFJPQyBub3RpZmljYXRpb24NCiAgICAgIHdpZmk6
IGl3bHdpZmk6IGJ1bXAgY29yZSB2ZXJzaW9uIGZvciBCWi9TQy9EUg0KICAgICAgd2lmaTogaXds
d2lmaTogY2ZnOiBmaXggYSBmZXcgZGV2aWNlIG5hbWVzDQoNCkxpIFFpYW5nICgxKToNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG1sZDogYWRkIG51bGwgY2hlY2sgZm9yIGt6YWxsb2MoKSBpbiBpd2xf
bWxkX3NlbmRfcHJvdG9fb2ZmbG9hZCgpDQoNCk1pcmkgS29yZW5ibGl0ICg3KToNCiAgICAgIHdp
Zmk6IGl3bHdpZmk6IGFsaWduIHRoZSBuYW1lIG9mIGl3bF9hbGl2ZV9udGZfdjYgdG8gdGhlIGNv
bnZlbnRpb24NCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogcmVtb3ZlIHN1cHBvcnQgZnJvbSBv
ZiBhbGl2ZSBub3RpZiB2ZXJzaW9uIDYNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogcmVzY2hl
ZHVsZSBjaGVja190cHRfd2sgYWxzbyBub3QgaW4gRU1MU1INCiAgICAgIHdpZmk6IGl3bHdpZmk6
IGl3bG1sZCBpcyBhbHdheXMgdXNlZCBmb3Igd2lmaTcgZGV2aWNlcw0KICAgICAgd2lmaTogaXds
d2lmaTogbXZtOiBjbGVhbnVwIHVuc3VwcG9ydGVkIHBoeSBjb21tYW5kIHZlcnNpb25zDQogICAg
ICB3aWZpOiBpd2x3aWZpOiBtbGQ6IHNldCB3aXBoeTo6aWZ0eXBlX2V4dF9jYXBhYiBkeW5hbWlj
YWxseQ0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBjaGVjayB0aGUgdmFsaWRpdHkgb2Ygbm9h
X2xlbg0KDQpOaWRoaXNoIEEgTiAoMik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBmdzogcmVtb3Zl
IHN1cHBvcnQgb2Ygc2V2ZXJhbCBpd2xfbGFyaV9jb25maWdfY2hhbmdlX2NtZCB2ZXJzaW9ucw0K
ICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBNb3ZlIEVNTFNSIHByaW50cyB0byBJV0xfRExfRUhU
DQoNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy8yMjAwMC5jICAgICB8
ICAgIDEgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnLzgwMDAuYyAg
ICAgIHwgICAgMSAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvOTAw
MC5jICAgICAgfCAgICAxIC0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Nm
Zy9heDIxMC5jICAgICB8ICAgIDEgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvY2ZnL2J6LmMgICAgICAgIHwgICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvY2ZnL2RyLmMgICAgICAgIHwgICAgMyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvY2ZnL3JmLWZtLmMgICAgIHwgICAgMSArDQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvcmYtcGUuYyAgICAgfCAgICAxICsNCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9yZi13aC5jICAgICB8ICAgMjQgKw0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL3NjLmMgICAgICAgIHwgICAgMyArLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYWNwaS5oICAgICAgIHwgICAg
MSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvYWxpdmUuaCAg
fCAgICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvY21k
aGRyLmggfCAgICA0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9h
cGkvY29leC5oICAgfCAgICA0ICstDQogLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3
L2FwaS9jb21tYW5kcy5oICAgfCAgICAyICstDQogLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL2Z3L2FwaS9kYXRhcGF0aC5oICAgfCAgICA1ICsNCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvZncvYXBpL2RiZy10bHYuaCAgICB8ICAgMTQgKy0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9kZWJ1Zy5oICB8ICAgIDIgKy0NCiAuLi4vbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL2xvY2F0aW9uLmggICB8ICAgIDggKy0NCiAuLi4v
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL252bS1yZWcuaCAgICB8ICAxMzQgKy0N
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9wb3dlci5oICB8ICAg
IDUgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9yeC5oICAg
ICB8ICAyODYgKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBp
L3NjYW4uaCAgIHwgICA3OCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZncvYXBpL3N0YS5oICAgIHwgICAgNiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvZncvYXBpL3N0YXRzLmggIHwgICAzOSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvZncvYXBpL3R4LmggICAgIHwgICAgMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvZncvZXJyb3ItZHVtcC5oIHwgICAgNCArLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvZmlsZS5oICAgICAgIHwgICA3NCArLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvaW1nLmggICAgICAgIHwgICAxMiArLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvcmVndWxhdG9yeS5jIHwgICAy
NiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvcnVudGltZS5oICAg
IHwgICAyMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWNvbmZp
Zy5oICAgIHwgICAxMSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXds
LWRiZy10bHYuaCAgIHwgICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvaXdsLWRydi5jICAgICAgIHwgICAyOSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvaXdsLWRydi5oICAgICAgIHwgICAgOSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLW1vZHBhcmFtcy5oIHwgICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLW52bS1wYXJzZS5jIHwgICAgMiArLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLW52bS1wYXJzZS5oIHwgICAxNyArLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLW9wLW1vZGUuaCAgIHwgICAgMSAr
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuaCAgICAgfCAg
ICA2ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvY29uc3RhbnRz
LmggfCAgICAyICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9kMy5j
ICAgICAgICB8ICAgIDQgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxk
L2Z3LmMgICAgICAgIHwgICAxNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbWxkL2lmYWNlLmMgICAgIHwgICAxMyArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tbGQvbGluay5jICAgICAgfCAgIDE2ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEuYyAgfCAgMTAzICstDQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWxkLmMgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbGQuaCAgICAgICB8ICAgMjUgKy0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbG8uYyAgICAgICB8ICAxMDAgKy0N
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9ub3RpZi5jICAgICB8ICAg
IDQgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9yb2MuYyAgICAg
ICB8ICAgIDQgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9yeC5j
ICAgICAgICB8IDE2OTEgKysrKysrKysrKystLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL21sZC9yeC5oICAgICAgICB8ICAgIDUgKy0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9zdGEuYyAgICAgICB8ICAgIDIgKy0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jICAgICAgICB8ICAgMTUgKy0NCiAu
Li4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21sZC1tYWM4MDIxMS5jICB8ICAgIDMg
LQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oICAgICAgIHwg
ICAgNSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcGh5LWN0eHQu
YyAgfCAgIDI0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcnMu
YyAgICAgICAgfCAgMTY0IC0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
dm0vcnMuaCAgICAgICAgfCAgICAzIC0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS9yeC5jICAgICAgICB8ICAgIDIgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvbXZtL3V0aWxzLmMgICAgIHwgIDE2NCArKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyAgICAgIHwgICAxMCArLQ0KIC4uLi9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi90cmFucy5jIHwgICAgOSArDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS90ZXN0cy9kZXZpbmZvLmMgfCAgIDI5ICsNCiA2NSBm
aWxlcyBjaGFuZ2VkLCAxODY1IGluc2VydGlvbnMoKyksIDE0MDAgZGVsZXRpb25zKC0pDQo=

