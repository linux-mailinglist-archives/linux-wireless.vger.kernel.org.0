Return-Path: <linux-wireless+bounces-25777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAEB0D001
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7761C21C0F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622BE28B7E1;
	Tue, 22 Jul 2025 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rk8PvtVH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4AD28B4F8
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153635; cv=fail; b=d14MABP330MjF3+ayqRO3V4SPgCHxFPuycsyDGPfGfQM17et3c5ARX+QonPEj7eNl0UT7QDd3h/vSJ95TbRUblKV3M5EC3elCHrVfQAY8h8JgNlODUElncXi1kNJrzYMPCU1LjroM3N7RbOZ6FJucsxi5AQwekO0DHw9wK3+qjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153635; c=relaxed/simple;
	bh=3zc+XGwt2OAUDZPVBe9nQzTtT8YRwSIADR1byIh8yY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHcyyzZI+AvyRoZM0ZJId6tp73f6a6CCpfD4n/UqTVynStqX+0Mw6WjdjC6FB01QSKnKqj5KEpbjSEx+XdYKtylwuSRkaaOIUcQMoYhfQYwk40Bq5fiyP+ocJYYNqFa8b9WNLij4QGPMi9p0qVKPuCel83mExnR1IcEkr/KSC44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rk8PvtVH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753153633; x=1784689633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3zc+XGwt2OAUDZPVBe9nQzTtT8YRwSIADR1byIh8yY8=;
  b=Rk8PvtVHqsiXQVOmyukiVq57gieyrqQABCyrHeYYdM8kHEkobWemLCvt
   kq645u4jOpY+hwhN+iX4fpZGKT5AQnthDQwmueiQa718DZhQ22Nw9eMKt
   IwR2+PdjZPIwACwKhV0Wi2YoviDszL+MKN/MJw61RiGKy7E/M2b2yrXdY
   LgToCg0n/bQ/EbQ6e1/APOrNVYZ/crqJ3f+YsD+jyKj6LLjahygEpY0g7
   tFi4UAFOmOhC8lrIzjcRKeTtbORLvnoy4c3HVNg7Vi7HXa5vZek8rPR/z
   Xw8wS6G3cP10A8JKtZ/gFtvLavhF4WhAJlB0EIznHpPubM76lKVWvR9vU
   Q==;
X-CSE-ConnectionGUID: Ov4QsfsHS9eefkKFClbvyQ==
X-CSE-MsgGUID: IzdG5Gs+ThupqZDxU3R2nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55343776"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55343776"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:07:13 -0700
X-CSE-ConnectionGUID: 1G9v8k3JRiGt8NqxO8Ro4Q==
X-CSE-MsgGUID: JXXswVD3TCqaLpGO97x7mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="158310925"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:07:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 20:07:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 20:07:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 20:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1DNZ0ktX/XSFqnQ9hGBucVo9nAXnqpFdXajUWuKQ8mT2FfOpDEH3C+Ja4khfskeGbe5NYBCNTTsUh6bET/UCeFvSp425jw+8LQfajuG4Z90hksjbvcbCfIgwmLggszfPqISLNAsRgzuOYkvvEHLCy9opuQ3mN/aplC42hX6iQIOy2N7oe5lriNtTmvQNfv4KRCb75K1Pwg0+EeBRP5ipJtQ91is3N6cewL8LQFJwqjgSA/61KsSzvIbWUu51AqFe7AlMlG1TwP6xFrfplxXqJeeb9Jg5OByMx0jJzkaYlH7d6WVzb/RKwLV4QMYCmQLde+EVBdm/i1VWN44p5xkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zc+XGwt2OAUDZPVBe9nQzTtT8YRwSIADR1byIh8yY8=;
 b=oPS0nkrT9jXXblA5Q8E6oNhgM00NIjFhNolL4B0D8ReEkcn5UnDkgrPDQYlhVhDpgymV44kRG+jk8g7SVFuC+tOs4R0oOVNdZMSAju0GZo5WzTemBUNIdmC8i0Suoz7bM1wS6yNs9wzgVt+fv1Gue8iD15L5wYgA1fTjMK+N6XEons5sfSLxBnwUnqk7WTvcmzhB+d5rekyGXXG2FtNh/CJiQ7I9PxxLFfTG745EqnKqbHptmrApEfuGRA5Bpl3rasdGU4A+j75djibY7WjHT5iG7Hn8I0qhATR9exippbdohcs86k0loM8GXr92/ppDQO/ItUGZ3x4eV7BGYQArIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CY8PR11MB7011.namprd11.prod.outlook.com
 (2603:10b6:930:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 03:07:08 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::9ce0:77f1:dff6:ada1%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 03:07:08 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "Berg, Johannes" <johannes.berg@intel.com>
Subject: RE: [PATCH wireless-next v2 1/1] wifi: mac80211: don't require cipher
 and keylen in gtk rekey
Thread-Topic: [PATCH wireless-next v2 1/1] wifi: mac80211: don't require
 cipher and keylen in gtk rekey
Thread-Index: AQHb+nB6CUtnVNFbk024ZAQEojjDgLQ9cesAgAAD/vA=
Date: Tue, 22 Jul 2025 03:07:08 +0000
Message-ID: <DM3PPF63A6024A99A52D871F6B7B060DE66A35CA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20250721185049.634010-1-miriam.rachel.korenblit@intel.com>
 <20250721214922.3c5c023bfae9.Ie6594ae2b4b6d5b3d536e642b349046ebfce7a5d@changeid>
 <5bb337eb86924d538939b4bb967289a2@realtek.com>
In-Reply-To: <5bb337eb86924d538939b4bb967289a2@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|CY8PR11MB7011:EE_
x-ms-office365-filtering-correlation-id: 1406e80a-446e-4957-c641-08ddc8ccd87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vmd5bzQxY3pXbHExUlQvbzNtU0FpNUd1TFpEeC8rMnAreWxpTTQ2YTM2a3lI?=
 =?utf-8?B?dUZQOTNMamtmazZVT3ltU2NkMXNmN3NmRk94a0RpQ3RjaGdrTXh4RG5qOHBH?=
 =?utf-8?B?TWVYdVZONS9vN0U1aWt2cDY3NzdrRG9MM09YZ3J5OXBsUkxUa20wNXBvdFB5?=
 =?utf-8?B?YzcxcXFrYnlwdE5EL2dXVDF3dnd2VHhkU1JhVENLRDRMejNqV1M2aWphQjVV?=
 =?utf-8?B?d2ZhZ1JST04rbDRvTkQ0SDdkdUJUTk1Na1JtcXA1NDNjK1dBamJWbUFVOXRM?=
 =?utf-8?B?aGw1SEFZRVFFaTR5aFZhTnNGd1oyM2xjU2NndHJLSTA5SzZBeDY1YTkvcjNV?=
 =?utf-8?B?c0xJVHE0VHJBNXB1Q3JhcEl3T3oxaWM4NWJ6dnhDRnJ4eU92cytyUEVaNU4y?=
 =?utf-8?B?RnN2UmJndEJsSHlTTEhVMElZK3orbVVCdFBFVUxXYXlTUGhHeFFpbGE2d1oz?=
 =?utf-8?B?ckU3bzVCRFBhdlN1L3FsaWVJU1hITXdKYWozRWlvczFtdEtxdm03ZDV0ZStt?=
 =?utf-8?B?TFpTU3lRUzZwN0VtWEVCQ1JtemV6OG8vTzY5S3gzY2RnYWFCaFl0SmltZ3NK?=
 =?utf-8?B?WjN3KzFTcTRUMEhtUzFpOEV4Z2RMckRST2YvN3Z0RlNBTDNsYk9vUm9xV3Q0?=
 =?utf-8?B?OW1QS3Y1S0s3YmE1Y2pKQTdEb25ockFQWDRjNVUrWTErMHFSdGdERE1jNlhL?=
 =?utf-8?B?WUE1aVJlQzQyekE1Y2xab3lVblBRekprV0F6eGgzQzN6ZXMvVVBKSEtsQ3h0?=
 =?utf-8?B?OGV2dEx6Rml2MDZZcEIvZk8wV1I0MG9pVEF2VFVqQmJGNjI3YUZVUTN4cjN2?=
 =?utf-8?B?RDBVMU52cndYWFBOUWkyeUhJVHUvdk1EZ3RiWEVXZkNoZm9HTGN0aHJKd1c3?=
 =?utf-8?B?elBudGtVOWhvY0ptMmtmMHZ5UEcwVUpEamZUUjNJMXFjTVFVbWgrZTFONnVu?=
 =?utf-8?B?N0xGekphVVdhYzRuN1dVdWhmQUpVWXl4WEFFZVNhRzNXSk5pcmFkVi91UzE1?=
 =?utf-8?B?akgwaUZMcW1nS3hnOERKK1NhK1dhcnJFbTZFRmh4cGh6RzE1U052T3Y5MUcx?=
 =?utf-8?B?dnBUazg5bmJnMk9oeEFCTmVVejBtSTV3eUZLc1hGR1RJTEF2endYaWVSM0Rr?=
 =?utf-8?B?enNiSGhCbU1HY1hLNE5nSnpPQTBxcVNGUGg5QnNQcmJsR2VNL2lwaS9DUm9Y?=
 =?utf-8?B?N0NJaEk3bFh0TDZsUDRNWDlEZFc4cTIwUEV4UDExSmxlZEZrL1p3Mk1vMGIr?=
 =?utf-8?B?dnpzN3dHUmpoVFZjUEppQmMrK2E0aytlMlk3bnQ3WVo2bjh5UHZ2M0RFUnU2?=
 =?utf-8?B?aGVqaFEyd3pyeFZqeXFCdHFRd1BtY1JmRlFsSWZiVUhoYjErZUw1OHd5V1Ex?=
 =?utf-8?B?TjAyY09vNzhkaEtBSjV4cS9EL3lmT0xpZ1VtazgxTDgxUklIenNEWDRwMEMz?=
 =?utf-8?B?UDhFMzlibFlNMklQMDNrRHl2dE9OY2ZaR0FOR1JsTTN3cm9rbm9XaGl2OHJH?=
 =?utf-8?B?SFFHaDU5eTdicExPZUZaUk1JSEZqQXc2ZndZSExhd0E1SEtMcDNkeFFndytl?=
 =?utf-8?B?OHk2RTV2ZjB0WXNSYkZlc25IZTlLNWJkdWVJTjBEV3F0Kzg4YjBrMUJkMnJV?=
 =?utf-8?B?L0JtR0gyWXJZRjllZFoxM0thL1ZzMkZIODE5SEtUdHhna2NsVmNzTkxURzBn?=
 =?utf-8?B?TUtrcWMwN3lSWVcrdldDNHlKVzJLcEZKSDkyVzY2c3BNU3ZuQlQvTnBjT2Nr?=
 =?utf-8?B?akVOWWtsWkJVMkdpYUl1S1hZUHNyR1BCMFR3TytZajZrWlQ5SE1uV3pFVkY0?=
 =?utf-8?B?QlJORWhyT0ltMFdyUE85ZzNPb01ERWNuZXJMSVFKNDV2RU9FREUya2NYUkVH?=
 =?utf-8?B?RGt1QW5LSzF5bnVZc0xwanNxdFBaVlFkSi9wTW53WnAwdmpQQ2IrQXd4Y2JX?=
 =?utf-8?B?SHNDUEluOVBkWjFKK0wyakFqM0d2WHFLMEdPZUdqLzZ0d25JZWN6LzQ2ZGRD?=
 =?utf-8?B?M29oc3VpRHNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjZRU3lTZkJlbS92ZnVLOWFWdHNxRzcwZ0VuaUs0bUVscTVMRlNzamlvbjF3?=
 =?utf-8?B?dGJBVjNsakFsQmE1MUhhdFJTZi9XcitzL3VxOWQ5MUhCUWN0Rm1SYUVBUVVp?=
 =?utf-8?B?U1dZNWptSjhsSWdVaEllMFd5WkhNaThYTEFPRzgybm9qbittdWFFVGZQclFH?=
 =?utf-8?B?bkJVanZQQTJwNjZ0cDltSTlaK09RZ3ZPZW5RVHVLV0VDSytmcUtWQVpoRmtS?=
 =?utf-8?B?S2E2TXVVakVnSElaUFdJVzNkV1RHQk1rQUQ3cVJIUEdBdXQ5eWc1OTZHVUJ4?=
 =?utf-8?B?TG5HbnBuc0lTSlRvWUdUQ0NVRmVsSXAxOTdYTTZGd1NHWUx2bm5qVkQ3RldW?=
 =?utf-8?B?LzBtQ2lRaHhVb3VGekswM2ZzalVZQ0F2UzE0ZVdUZC8zQXdoM2RDZ2g5L1M0?=
 =?utf-8?B?L3BaOGtLVWlUQW1iQ2tVZEZ4T0pKODNyRE5zQXptaFhEV211ckZtazcyTjVO?=
 =?utf-8?B?RmFQdlNkK2dWSmVSKytlSTFJMUVQb0ZlVm0xcVliNi9YSERjVk1GYmFXYm5K?=
 =?utf-8?B?dkMzcVpQLzFwK25tWTg4NE00RmJ6RnBMa3VMZWp1bzU2dmpMaWFQS1p1YTVj?=
 =?utf-8?B?VEZjYU9tTzdtcWVqcmcrRk0rWUpvT3VMM05Cc1lLOXF6TjdzeW1pdU12YTdX?=
 =?utf-8?B?Y3U0VnlKbDVNemdkT1E1UlAwcFNBU2RGeXJ2SVZVUlphYisyNDFpbUw2dDJH?=
 =?utf-8?B?WWJUSjVZK0NTakt3NTk4elJmMTdINU9xQjhMRkFoVnB5OERvenMvVjJHdVpX?=
 =?utf-8?B?YVcrL04wSFcvcTdqS3hVUDVJN1FTZXFGdDlySWdLcDdnSHk5Z1hldVEvUFE5?=
 =?utf-8?B?NFU4NGZGZHo5MVg1VC9nYS9qUEMrU0llKzgrTEVHenVEVXZGdUpnbHBaYWVS?=
 =?utf-8?B?TmRIWE5vQk5ILzRHOVRsSUR5RjVOU2IwWGxjd08yK3BweWFPSTQxdlFxRENC?=
 =?utf-8?B?TGl5b0s3RW1ZWGFreVlzQlJlcFpXQ2x4L0FoMXJIaGpJTnd1MnNUMEhSUUgy?=
 =?utf-8?B?SVpkT3NTK2hiV2p3MUExMVFCTnQxUGdXMUoweTBlR3p0cUdmSFFvcTQ2YVFu?=
 =?utf-8?B?dXV1bFlucFU3TzJKMVRTMTY3SGNrWERJYk5TaXcxMmZwTWw4c2FiVStPM2hD?=
 =?utf-8?B?TDlkYUxEenI3S0hZSGNrUm1vamxCLy9RVWFKSVN2UTl4NWlLeC9WWUN5Yi9o?=
 =?utf-8?B?QTR4UTFxamR4Mjg2SVQvOWEvc1hBVk8xMmZGelJkODNFQjZJSTkrN2VkMEpG?=
 =?utf-8?B?OXBTOWZHa1BselJ5TUN3TC9zdFBXRzNzZ2xlTmpmQlo3ZElzQlc2V0sxb3Z2?=
 =?utf-8?B?Mkg1WCtuTEtYdXBIZldnOEx4TS9hQUduZ2FjdkMwVWlkbXNiQTVLWHRkTEIw?=
 =?utf-8?B?blcxMnhIa1NRQWtUYnNSN0VkTCsvUFhVZmVnTkpoQWt2am9hYUxtaDhacmFj?=
 =?utf-8?B?QWg3SWpuMm1oT2xqaDNYWUQ1cTN6TGFSVUQ0UmNpK1JyMUlVeUY1ZWFJcE53?=
 =?utf-8?B?Q3YvQkYwMXdGMXJud1lRL2ZLTjlRM2o1YVJwSzRqZDA4cTNMd0VOTjd4QXQv?=
 =?utf-8?B?WS91NDh4MXZ0am1hRnhyLzVYNDhOQUxFYWFVb3A4bVhSb2J4SjZNd1ZRWEw5?=
 =?utf-8?B?cXdzcFFEZlphRUhJODdrUGJUY1ZTUWxJek0rUXllbjFrcnJXajFxbVdPZ3lo?=
 =?utf-8?B?Qmp4N0d1anVQZWdGWXpOaWFobjVIbVlQa2tDWVZrRWtLb2w3WFYyUEpteURv?=
 =?utf-8?B?NlVqc3IwR3hON3RRc0Z5T0NyVDVreEZZVSttQUxObWl5aks5M2owSkhWRDli?=
 =?utf-8?B?cTBIVGZtYU1TVUM4T2ZIbVczYXBuL3prTFhsUVRxY1FURSsxT2pTOTRWSUV0?=
 =?utf-8?B?QmZrb1ZTTnJTOXRKaWJYdHFvUUR4dWZxY3prZGFPLy9vRk9BQkZscUI4M1V4?=
 =?utf-8?B?VHY3TStmekpNN3h1MC9ZcjZTTEhFb1RRQVRDQStrMkxLdFBSMEZRQVQ4RSt0?=
 =?utf-8?B?MkYyVlhJV3l0ak5kUW1JMEE2YUluTDdIS2FIWDM3Y2h1NHh3VndPWWo5M2xY?=
 =?utf-8?B?Q0tYVWczenUyckFVVGFMd2lxbjBpTmt4U1crdGVyelRlQWttWVg2em0zcGZY?=
 =?utf-8?B?SVEzL2NJYytpSDYyTlliSWJETlUvSm5LYmZZMlIwNXNGR25tS0VlNWZrRGRM?=
 =?utf-8?B?NVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1406e80a-446e-4957-c641-08ddc8ccd87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 03:07:08.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7RrAye/9bj40lCJxQw1JHfWUZzTC/kcevw5Q8uBi9J96li5l1IQ3dNaZJhJmJz2HrLAkDKbgviGEfLR7Xb3uhCxm4t/JZ/0YVlAcfi8Hsc6udahb9rY+LEvahpmqU4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDIyIEp1bHkgMjAyNSA1OjUxDQo+
IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGlu
dGVsLmNvbT47IGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEJlcmcs
IEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRD
SCB3aXJlbGVzcy1uZXh0IHYyIDEvMV0gd2lmaTogbWFjODAyMTE6IGRvbid0IHJlcXVpcmUgY2lw
aGVyDQo+IGFuZCBrZXlsZW4gaW4gZ3RrIHJla2V5DQo+IA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS93b3cuYw0KPiA+IGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS93b3cuYw0KPiA+IGluZGV4IDA3MWM3NTc3ZGY1Mi4u
NWJiN2MxYTQyZjFkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvd293LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5L3dvdy5jDQo+ID4gQEAgLTYxOSw5ICs2MTksMTIgQEAgc3RhdGljIHN0cnVjdCBpZWVlODAy
MTFfa2V5X2NvbmYNCj4gKnJ0dzg5X3dvd19ndGtfcmVrZXkoc3RydWN0IHJ0dzg5X2RldiAqcnR3
ZGV2LA0KPiA+ICAgICAgICAgICAgICAgIGZsZXhfYXJyYXlfc2l6ZShyZWtleV9jb25mLCBrZXks
IGNpcGhlcl9pbmZvLT5sZW4pKTsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGllZWU4MDIxMV92aWZf
aXNfbWxkKHdvd192aWYpKQ0KPiA+IC0gICAgICAgICAgICAgICBrZXkgPSBpZWVlODAyMTFfZ3Rr
X3Jla2V5X2FkZCh3b3dfdmlmLCByZWtleV9jb25mLCBydHd2aWZfbGluay0NCj4gPmxpbmtfaWQp
Ow0KPiA+ICsgICAgICAgICAgICAgICBrZXkgPSBpZWVlODAyMTFfZ3RrX3Jla2V5X2FkZCh3b3df
dmlmLCBrZXlpZHgsIGd0aywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY2lwaGVyX2luZm8tPmxlbiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcnR3dmlmX2xpbmstPmxpbmtfaWQpOw0KPiA+ICAgICAg
ICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAgICBrZXkgPSBpZWVlODAyMTFfZ3RrX3Jla2V5X2Fk
ZCh3b3dfdmlmLCByZWtleV9jb25mLCAtMSk7DQo+ID4gKyAgICAgICAgICAgICAgIGtleSA9IGll
ZWU4MDIxMV9ndGtfcmVrZXlfYWRkKHdvd192aWYsIGtleWlkeCwgZ3RrLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaXBoZXJfaW5mby0+bGVuLCAt
MSk7DQo+ID4NCj4gPiAgICAgICAgIGtmcmVlKHJla2V5X2NvbmYpOw0KPiANCj4gRm9yIHRoZSBy
dHc4OSBwYXJ0LCB0aGUgbG9jYWwgYWxsb2NhdGUvZnJlZSBpbnN0YW5jZSBvZiByZWtleV9jb25m
IGlzbid0IHVzZWQNCj4gYW55bW9yZS4gUGxlYXNlIHJlbW92ZSBpdCBieSB0aGUgd2F5Lg0KDQpK
b2hhbm5lcyBhc2tlZCBtZSBub3QgdG8gZG8gbXVjaCBkcml2ZXIgY2xlYW51cHMgYW5kIGhhdmUg
dGhpcyBjb21taXQgc21hbGwgYXMgcG9zc2libGUgd3J0IHRvIGRyaXZlciBjaGFuZ2VzLg0KVGhp
cyBwYXRjaCBpcyBvbmx5IHRvIG1ha2UgdGhpbmdzIHdvcmsuIENsZWFudXBzIGNhbiBiZSBkb25l
IGxhdGVyLg0KSm9oYW5uZXMsIHVubGVzcyB5b3UgY29uc2lkZXIgdGhpcyBjbGVhbnVwIHNtYWxs
IGVub3VnaD8NCg0KPiANCj4gPiAgICAgICAgIGlmIChJU19FUlIoa2V5KSkgew0KPiANCg0K

