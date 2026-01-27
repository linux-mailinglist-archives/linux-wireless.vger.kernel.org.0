Return-Path: <linux-wireless+bounces-31227-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHO6CD68eGn6sgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31227-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 14:23:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8804394D90
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 14:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC38303A93D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB768356A3A;
	Tue, 27 Jan 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaUBz35S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67828356A0A;
	Tue, 27 Jan 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520135; cv=fail; b=oueLGwYZD7K1YLs0BunBQuHVKiBYTP0Z9eSCa0mD18IoShSPeeme+AOdMxK5T8uagQRb5wgI+CntgiC2uqjv0dBfQ1OuJgONbXg+MqYpdzOXZ3HuQECFZCj9bItrY8X5KvbIvhHRHxRNalbRsail/MgadSepAIv1c0J1TXxyhSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520135; c=relaxed/simple;
	bh=aQZYLNitgOvB6akL/xM3eg/8VPUftLA5lzFN6lRpMr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N1FzyEhXD1ZyYjYujFJwPimRj3TLdoXOPGn7YhiuNbGf+i2d8gwxh1GXzzVgvC2rnz1uC6rnBju3+nW08KuVysItShYniMGSema85H61bhsnLakOS7MqEoP11xlQGuX6aV3tWIc0nmbHyxqvSI5yun4REGq6w3xIEik1zkj/mQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaUBz35S; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769520132; x=1801056132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aQZYLNitgOvB6akL/xM3eg/8VPUftLA5lzFN6lRpMr8=;
  b=BaUBz35SxQKgKAksSckKQfCm02T/ZFqGRP+aeWhjd8iSoDk5kEMtuKb3
   SsfOWrhNUttOQDaD0a5D98crltU6YNcz3SOOZ42RDd9N7R5igDjE6td0S
   p4i1M9Lsk2cuoj0fFI+sBu856WYXhgg/eBaqFjlvSFT0tCENVqKbhbWHS
   HRfZM4WSgzu6VPtEYxv0boWK+vWWwOH7/VW+f0vqFulgSuek4lFgVivC1
   fzhuJexRM6yJN4OrPhHFK7k26VbXj1XH/OLa4h1d/MI2PsbkCxX0s/oB7
   oYTsxvpxvYuVua5Li1j10Yasf2KJ3F3CKGvHqwUvuJvV9ud/WCNSbn/MH
   w==;
X-CSE-ConnectionGUID: C0AkYm68RqKOCeVie9QdHA==
X-CSE-MsgGUID: +v04b4f6ReSX5GGm+pUBUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74559753"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="74559753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:22:10 -0800
X-CSE-ConnectionGUID: SmPRGhwPS8yxXVqB0apMEg==
X-CSE-MsgGUID: KOLE1JK7RvuKy/+U8HkFDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212945185"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:22:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 05:22:09 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 05:22:09 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 05:22:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeIbh2GZrQY9apa3C5yYGReELbb2QzNjxdRtbCZ1gbwH+Vh7LQckEmoTNXFQwJpRTzcTlGydDpR7X8fDvMffWDAi6dN3AdHiptXMHO1Ty0aT+rdQ8o7FP6LKSi/TzfRn4N7336dLe9+AIS5eQc//G4DdjtMdqGUH5XTtQSNt0Z4xBmhWF91HMlG9qphxrIbz4cTxDAywCIFrmk38khe0gOXaZPzGNwq1UUpX/r+6f7YWatdnY3hg8mXfZYwq8zfIvrzXdIzqFVn/kvKxGS5nrx2zki629uHz9Ypx1Ih7wBLwdJSG12/jIS1wNxpdpjq16Xp2fidn555uTSstaujVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQZYLNitgOvB6akL/xM3eg/8VPUftLA5lzFN6lRpMr8=;
 b=x7yTJ6H+6IC4N2rZttwfqGMvDN+NdYAKtJN+kESUcUS3OMM7dFmwEGgce82egGl730Go6d3eu9TT7ITEC1qJKR2zhLRyIZxqdZ6qCSxi16rndagQmqBMk6Zwt3fqVKiemKA7tBsgKor+g9nYb8PKkipNBlkNeuJWLVZ434GWWmRYdMg6wc54iz+jHTETrWV6Ic3D3h8T9XthD3vMUafFgSVsyNxTUHKD6YWNElI8n0NcQMlwupxktfESKgxbFMOdk1aVHSEayez6rIwxxV67hYRHkWfCtFf+jGy1DJZ12Oiy9IlezBmWl+vBYV4LybjarjuKYBOdE0tbG9j6BPie7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MW3PR11MB4634.namprd11.prod.outlook.com
 (2603:10b6:303:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 13:22:07 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 13:22:07 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Index: AQHcjlMSDsDNaO3QzkSRZaUB0ZOqB7VkClEAgAAYLQCAAFS+8IAAi5yAgAB00nCAAHrBgIAAEIlQ
Date: Tue, 27 Jan 2026 13:22:06 +0000
Message-ID: <DM3PPF63A6024A91EFB76D52F9590E82C30A390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
 <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
 <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXit5795WQLL290t@debian.local>
In-Reply-To: <aXit5795WQLL290t@debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MW3PR11MB4634:EE_
x-ms-office365-filtering-correlation-id: 34b2f13a-8707-4c27-183e-08de5da711a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZnptOUNRWTVMbENQYWFtS2tqaVg1MXJlU0FTeFdXTjIrdE02T3daUWxNZzhF?=
 =?utf-8?B?SWhkUTVPc3Iva3BPY0psUEdUb05GcXFoSVdOWXJuT1Z0clA4ZkFocUpJYklu?=
 =?utf-8?B?T2w5TkVEaVhQSmZJbVVOU1FiSjRvVjlKTXVzeHorYWFrNG5NMitsdzlJblVt?=
 =?utf-8?B?d2VsT2FFVzVwR0JXSnRGQXFzYmVtVS9lOGhuRHFQSnd1a2Z5cFJqQVlMbDFJ?=
 =?utf-8?B?QU50UytpZzNwT29XRk1zUFBaQm9oT3dkSzdkMGNHUkwyT2xwekVyNDErRDBP?=
 =?utf-8?B?L1RraERuSW9GRy9RenBNS0RXVWRkTXVIenNHa0JicmJsMTRQNFpKWmxIa3lO?=
 =?utf-8?B?c1lLaW9FVVJWdHRxZ0RQdEFNdGVHLytOMklveEU5ditjRTdPeHpoTjhxZFBE?=
 =?utf-8?B?QktIMGNITm5hemE2bXQvY2xLYzRvcUsrREpVSWt0aWwzVjFOUEl2MnVmQXZZ?=
 =?utf-8?B?ckhRa3hUdzhHei9XYUhkSDU4Tlh6UUIxMk5BS09uZFJPOW92cUdzQzR0QnpZ?=
 =?utf-8?B?T0tVRDlYN3p2SXFaUmxVdnFrMHdLanlJOWdUcVkrenNZRFdjOGlhdUI3cmow?=
 =?utf-8?B?cm13ZGRTRnFaSGZ2TDAzWkdBU1VZSUFwcm9RVHJlRG5tSVRoZ1l4M1hMU1ZI?=
 =?utf-8?B?WmYzK2xKSUJ3Mm91d09zS2NvL2lucFZxaGtxN01RQXNUSzlFSC9tZExVcktL?=
 =?utf-8?B?TzQyYW5VU0xvdlAvOWdsZU9qaFNZMGdramxqM2JJMWtQREVIamZLMjFsN0g3?=
 =?utf-8?B?Ny80a2k0WWVzbk56bWw4bWZvc2lMNWtVbWltblRvdkI5RGk0U2g5aDAzQVVC?=
 =?utf-8?B?ZlVOS3YwSWRKQS9nVWxJZDlSV2JUaW9TNFhIZ0dTbU9KamR6UkdDM1J5TUEz?=
 =?utf-8?B?S3lRSWFNVmZlTHYzREh0M2ptWG1uRUc0VDhET1JjdHpXbWkwbXFKL0FCWlp5?=
 =?utf-8?B?aWthN0twOGNpRVdPYUh1c2N1MW9qSnR1aHpHanEzMHdxSWNoWWIzY1R1Wmcw?=
 =?utf-8?B?L25iV0ovbUM3YmdMbmdnbE1ueElnd3h4TmZyNVdQcnl5OUpvazVDZXZGdkdP?=
 =?utf-8?B?L0RTWjEyZTV4TCtHcCtLNXdLM0NmYzNBblczZmxjZmJoc2hsYjZhZ0x6TTZ1?=
 =?utf-8?B?Vko1OWp4b3NJcTdYQzFuaHIvYlNISHpybFZOOFBaQlZDeXhkU083VkQ1R2hq?=
 =?utf-8?B?OERsY0hGRHlsY3IwMHlKVzcxQnB0MTUwb1pzTXp1SHV5aVJkcW5tNmtQM3Z1?=
 =?utf-8?B?MWJPZ1RNMkpGME1ybzdRVG1wYlE4MjArR0Q0MWl2bVVKa0NiVVRZeUVTc3I4?=
 =?utf-8?B?cVJxWHZ2djNUREJacUoyWEtacnFXN0ZaYkhzWUNkS2NqOFpJV0VnK09OTHJ1?=
 =?utf-8?B?K3FLdWpGMjV3dnFOL1JoVGNsL3ZVeUVzNWhIRmd6MnA3dWx3WGVvbU1WT29E?=
 =?utf-8?B?Ui9wdVkyQWZjSjVYMVVqbTE2QzdJVUxVbzd4bllLNXZYQWVteHg5MytXNVpz?=
 =?utf-8?B?VUFzcjVWK0RaN1Qwd0J0NWhFd1U5aGsrOGFkVE54OGs5VVM1RFA0djVDQUVa?=
 =?utf-8?B?SjdjQzdkSnBwejY1dXFsUHc1a2ZETHdSVUw5WEY3SnNBMENqTmRRazJ0aUdj?=
 =?utf-8?B?NzcraGU3WnRveThlaWx6V3QzeldaRVVHMTJqRkJwNHRBRFBIQldZWU9oYXVi?=
 =?utf-8?B?RnJ4TElibWc1c055TUx5Nkg1RFpkekJSRlJXY2d2cGlQK2pGZ2FOcTBMcFlD?=
 =?utf-8?B?aytJa0lrb1JWTnlEZmZ4OVpmckF6aHpScGpydWxabndEV3VJbFl3aE9EVjRO?=
 =?utf-8?B?UGVocFFKTnArVTRkamRyZThieFl6RU1vMGdZZmdQRjIraiswN1V6bzhuczJ3?=
 =?utf-8?B?SE5lWkFsblVvblFOVFdxamtlcHF3OERvUDlaNHJaU3ZqWG5OWXhUWEhuTnNY?=
 =?utf-8?B?SGpCdnBidHhuUWVJMlJybG9RS2R0Q2tSVHhZelJML1NPMlE5ZzIreTUyTTE0?=
 =?utf-8?B?OWJiUHZ0Q1h4Tyt5NllBSnBXVWU3ZXdCaFFSNVRoeWZMaG9lOFFyZWZUTkQv?=
 =?utf-8?B?MGtCZUdoM2lESGpYTC9lQndPS05YN2pCVWU3SHlxSE1OOGZBYStJQmhmZkJ0?=
 =?utf-8?B?VGpVK3JRN3hhZXpXYURvcEthb3VGLzUrd1RGUHgzU2VlMStFWE53Qkx5SE9h?=
 =?utf-8?Q?9IStBMqYcBpTTFSG3qW/IPc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2NOQTNVOG9CNzRlTjBRck54azJWT1pkQXpJSVhsaEVWYXgrc0xkQ1NvK0dm?=
 =?utf-8?B?emF1SmR3L3MrYWdLcDRTK0tRMXBCSFdIVWU5eUxhWHZZdTlYNklLLzQzcTZh?=
 =?utf-8?B?VU1sbGhxaWZYemdaWlBSU2hzellUeFRUTFBzcDZ3YXdKVEd6QzgwYlQxeGRZ?=
 =?utf-8?B?Y0tVYVNLb1prMTNmc0xTbENIWnVLb2NiRFlyOHE4OGhtQXlXeW1OZ1huU3Zy?=
 =?utf-8?B?KzBiUFVXbmgyTG5xNnJMQ3Q2cWU1aER0SmhMUEpVT2NjUHRoVHpQMzZlNkh5?=
 =?utf-8?B?MXRaTWY1TjlHejRyaUZ2Rk5HeDV0b0tGdVhtbjFzNWNVRkRlbmk0NFFMNFZB?=
 =?utf-8?B?aVZDNWM4cXoyUDJsUGNGM2twS2NjejBuWC9yd0JTbmJOYnU5Q0cxNjl0UEFq?=
 =?utf-8?B?cUFiYUdidDVDeDk5VWM5MUx4Qjl5a3k3VHd6dC9hMDllaE1VUXJDY0x6S29a?=
 =?utf-8?B?Y1A1YVpzcDc3SW5kVUE0cmNwb0loSHE2bmJtMjVlS1ZzMDc3TXVsMU5aMGNv?=
 =?utf-8?B?MkJ0UjZ4dk9CQVNzMWdBY25nb2N4SlJTWTN3Vi9uQkdySEc2QXh2QXpOYVMr?=
 =?utf-8?B?Qk5MbkVxVjhPUENNODI3QjZZM0xZL0lBbWFJZEVHWGxEZ2c5Z2VIN2VkUTZk?=
 =?utf-8?B?V0NWajFhQkFQaS9MaDEzcFlKQTcyYlp2NlBNMy92dFpBd0xXZlFtN3FrdnRS?=
 =?utf-8?B?WE9lUy9mMjhyVVBBdnVTMDVRbW9OL1VYL3JJcU9WSktrMVJzYjRDank1SmQr?=
 =?utf-8?B?czRuaXVPZHhVZGt5Rm5QaWFaek4vYkdzR3Zzb3dMaGdiZE9kakswMWg0c09V?=
 =?utf-8?B?djBnb0dMcHpHWEpvUDhiQXFXRDlSL24weVBzaGtyVExWZVpJVG5zZE9FczJD?=
 =?utf-8?B?T2xDVkYveEpRVlJjQWpRdEpJakVCeDRrRGY1OCthcHZmcXREOVp3K1lGaGwv?=
 =?utf-8?B?REM2Wk9FZ2VWNm1FT2l3NzZ5YlJJVmV6OEJES2FSb2pkVW52VU9BNWhVN1JJ?=
 =?utf-8?B?TGQzRUtnc1JtaVNYcmZYSzZHcnhxNWZFaFlsOHVzYlBud2ZQeEhCUXZST1pE?=
 =?utf-8?B?Zmc5OXFrYUp6VGVFalVIUnA2TzBaRGM0SGN2OWRjeDMvMTNZalVXeFNMRUEz?=
 =?utf-8?B?UHpkMjdzSE1oTnpiVll3cVZUQ2pFUmZHdnozRko2eWp3c2lpbCtFbTJzV1hn?=
 =?utf-8?B?ZVVhRkJtYVdITExtZFZWaWw2cE12WkpXK0xMMmFvNmRZdXRmQlNxUUN0ZDRM?=
 =?utf-8?B?akhrclVZYktZd2RzS1hDelk5OHZDS1FzenZKaS9uenFMS3NybWJFbmdFTGlE?=
 =?utf-8?B?SXRVOE1iWk9MaDBabTR3VjBFVjhZdUU4RWgwUFRmalJnOC9aQmxvTTdVS21R?=
 =?utf-8?B?d1JVdDBzTWxSeU9jeUIzRXNtR3F5RDdQbWRnYURxS1NORTYzMVV3b3A2RWNx?=
 =?utf-8?B?eGRhMTQ1bWVoWVBVVVJ6YkhsNmlaYVM0NWJ2NytHbzZQejJvcHplT21OaVc1?=
 =?utf-8?B?WWE1RjNvUFRhVjBBak1xTWdqbzNoRnV5enFIWXVGOVRsNElLNm1KM2ttYW9o?=
 =?utf-8?B?NHNGOFljNjgzWnZ6TzJBYXdZTnN2ZlBDbTZqT2EyaTJ5YUN4SjdVcFVPNUV4?=
 =?utf-8?B?S01KRkw5WWt1MW1kNFhaT1haa0s0WEw5UzJ3NWtta2x2bzJLd09TM0RxQlB4?=
 =?utf-8?B?RUFiZUg0MlV6VUo0R1J0VUxXbGdJZFEzdE5SdmdObE1FNWd6ZjE1bnc5cVVB?=
 =?utf-8?B?cnlTQ1J2QStQRU5UbHFtNUdDSXdmQ0VqSnE2MTlsQnpxRGpmcURRU3o3U1Y2?=
 =?utf-8?B?anNYd09TREhVT0c0Ry9aV3FneCs0T3hxVnF1a0hwbHRpczZPYXBURFN3aUxq?=
 =?utf-8?B?a1BlbEtkcHVSTnlpeGRrZFpvUDhRYmxjNHVWSUdVV0JwbWZmc0RJTzNZMVZ4?=
 =?utf-8?B?Q2xCMnlOUXBpWE45Y2RualhrT3N6TUNVeExMR0ZJQ0g2RzBKSGw0MDh4eVRH?=
 =?utf-8?B?YTJZZU9Ed0Y2NmtGRCtYdnpQbzhrQkc1OEN4bm44ZkVSYUttSldPVFA2eHk2?=
 =?utf-8?B?dTk5NmtaVzI0d0gzbThqL3BqanFEcDdBRkVYZXpZTXlsa1BaYTdSVnppWkRI?=
 =?utf-8?B?a3ZiRVJDV01EbUhFK2dmVTIrTG9nRDkrWkVHcjJWQ1lsOHpUYnlrNElMNGcr?=
 =?utf-8?B?WFBwSHE5eG45bk5HcGhXN0NXc1RKaWRKdzZ2RlBnUUt4TjNpdnlGYWZlT1Q4?=
 =?utf-8?B?cUZueG45QVFxRENYalJMOVlZR3g5Q3Njby9QbTZEbEk4WUxTODZRLy8zanlt?=
 =?utf-8?B?U1RoalB6VGl5cVIxQ3R3MGdBUmlMZ3Q2TGFCYjA5NExCNCtOd0hrODhXZ0Jo?=
 =?utf-8?Q?hRNaMQAL87tqQHBY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b2f13a-8707-4c27-183e-08de5da711a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 13:22:06.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GsFQe5Z2agmWTNZDT3YLnHFMTQLOOxcKfHpuTLc9RD+rYihpX/LFfYyghWoZYE4TBkAXfMCKgnQ0JtOj3ht0O4tjSG2lR9YWHxIGztl5jvbQcqY4OOC7RNqSdGlLoVa1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31227-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8804394D90
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQmFpbmJyaWRn
ZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkg
MjcsIDIwMjYgMjoyMiBQTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0u
cmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo+IENjOiBrdmFsb0BrZXJuZWwub3JnOyBCZXJn
LCBKb2hhbm5lcyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+Ow0KPiBiZW5qYW1pbkBzaXBzb2x1
dGlvbnMubmV0OyBndXN0YXZvYXJzQGtlcm5lbC5vcmc7IGxpbnV4LWludGVsLXdpZmlAaW50ZWwu
Y29tOw0KPiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJldmVydCAid2lmaTogaXdsd2lmaTogdHJh
bnM6IHJlbW92ZSBTVEFUVVNfU1VTUEVOREVEIg0KPiANCj4gT24gVHVlLCBKYW4gMjcsIDIwMjYg
YXQgMDU6MDU6MzFBTSArMDAwMCwgS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIHdyb3RlOg0KPiA+
DQo+ID4gSnVzdCBtYWtpbmcgc3VyZTogaGF2ZSB5b3UgYmVlbiBhYmxlIHRvIHJlcHJvZHVjZSB0
aGUgYXNzZXJ0DQo+IChBRFZBTkNFRF9TWVNBU1NFUlQgaW4gdGhlIGxvZyksIGFuZCB0aGVuIHRo
ZSBwYW5pYyBkaWRuJ3QgaGFwcGVuPw0KPiANCj4gWWVzLCB0aGUgQURWQU5DRURfU1lTQVNTRVJU
IHdhcyBsb2dnZWQgYnV0IHRoZXJlIHdhcyBubyBzdWJzZXF1ZW50IG51bGwNCj4gcG9pbnRlciBk
ZXJlZmVyZW5jZS4NCj4gDQo+ID4gSWYgeWVzLCBwbGVhc2UgdGVzdCB0aGUgYXR0YWNoZWQgcGF0
Y2gsIHdoaWNoIGlzIHN1cHBvc2VkIHRvIGZpeCB0aGUgYXNzZXJ0IGl0c2VsZi4NCj4gV2l0aCB0
aGlzLCB5b3UgYXJlIG5vdCBldmVuIHN1cHBvc2VkIHRvIHNlZSBhbiBhc3NlcnQuDQo+IA0KPiBJ
IHJhbiB0aGlzIHRocm91Z2ggMTUgc3VzcGVuZC9yZXN1bWUgY3ljbGVzIHdpdGggbmV0d29yayB0
cmFmZmljLiBUaGUNCj4gQURWQU5DRURfU1lTQVNTRVJUIGRpZCBub3Qgb2NjdXIsIHNvIGl0IGxv
b2tzIGxpa2UgdGhlIHBhdGNoIGRvZXMgZml4IHRoZQ0KPiBTWVNBU1NFUlQuIFRoZXJlIHdhcyBh
IHdhcm5pbmcgbG9nZ2VkIG9uY2Ugb3V0IG9mIHRoZSAxNSBjeWNsZXM6DQo+IA0KPiBJIHRoaW5r
IHRoYXQgdGhpcyBpcyBwcm9iYWJseSBhIGRpZmZlcmVudCBidWcgdGhvdWdoIC0gY2hlY2tpbmcg
cHJldmlvdXMgbG9ncyB3aXRoDQo+IGpvdXJuYWxjdGwsIEkgc2VlIHRoZSBzYW1lIHdhcm5pbmcg
b2NjdXJyZWQgb25jZSB3aXRoIDYuMTcuMC0wNjg3MS0NCj4gZ2Y3OWU3NzIyNThkZiB3aGljaCBw
cmVkYXRlcyB0aGUgInJlbW92ZSBTVEFUVVNfU1VTUEVOREVEIg0KPiBjb21taXQuDQoNClRoYW5r
cyBmb3IgdGhlIGhlbHAhDQoNClJlZ2FyZGluZyB0aGUgd2FybmluZywgcGxlYXNlIG9wZW4gQnVn
emlsbGEgdGlja2V0IGZvciB0aGF0DQoNCk1pcmkNCg0KDQo=

