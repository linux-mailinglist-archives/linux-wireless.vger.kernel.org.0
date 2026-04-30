Return-Path: <linux-wireless+bounces-35709-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGMpB11Q82lnzQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35709-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 14:51:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793834A2EA0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07FAD302F590
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455D40B6C5;
	Thu, 30 Apr 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6zsQ3pC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45113FF8A7;
	Thu, 30 Apr 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553430; cv=fail; b=K53WOOvmRcuy6O0V0KcrwRRsa9rfNlvRUn4ac2eGRXOFPHw3MNU8K2NtCDyBAj53BlMA5N7AKokDqFRHC1uwYESsAa8Ibm94uUrYCEmS04KRjIIaSfXRfmkYaBVhMpLouAVoUCpo1hsYplL6lWXNWsybQWtxRWeO+Vr3+I9Q9eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553430; c=relaxed/simple;
	bh=FwT/2FEAKHIhICDxyUseokQifhT/v6ENKFH472DQEAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FbupYbX9nClrAQ84yKV1TjjvaIJJdcggMvjYzXphawMU8F/P6EzqZ18qzU4Qc2AGVIH/ueudOVUWy18QyV4x5iOWv9HlB6OFQ5KMoD2+UcPVQXxL7cxoC6xOh0ZfSftmqj91e9WI6s9LiblJsb0QYduidrFcIJvRVdyYdAOa0aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6zsQ3pC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777553427; x=1809089427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FwT/2FEAKHIhICDxyUseokQifhT/v6ENKFH472DQEAM=;
  b=b6zsQ3pCdmGITsiKM5rpS3M0/x7P84gdsI9KR4Ym+fEz7p7fuzTNnDMk
   wCLd4XlZLdjsI82OrRIEr0km/zQsffk099GgEvegmRmit7HM2Ey8XhFTw
   nCWXS56Mb+0ou4JxbhaDM0gEy4FIHKNtm59tVwmLc2g+F7drE3oouSMNO
   /jceCC2dcqdgFIjM69ImsY7RzTrL6gzZl/Gw3gtCBBqFd01IZ/75R99vA
   Tqb6xs5UnzqrUOIZ3IhLu6KoVIINUH9ry/t7dFT16JCQfTeK3wGBgLb7V
   KrjhPSYRFWq/m+Y181IYilHx6xioHQ/A33MdLXFaSK/33SLPhna2R+19E
   A==;
X-CSE-ConnectionGUID: IoskupjxQrKWWjEkmBohog==
X-CSE-MsgGUID: WaqEJVFUTDOYGM8dqsALBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78210717"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78210717"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:50:25 -0700
X-CSE-ConnectionGUID: /yVo+6Q5Q8ybq3OLn0D+pg==
X-CSE-MsgGUID: H7GEO4L7RL+1oohGYmhlCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="238891426"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:50:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 05:50:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 05:50:23 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 05:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6pDAB1WreYMIMzs5F34LFw5sGDTFXgqFExDN5026Fdd5puMzQ1Qz1RYhVIsAe/jp1l16ofSxpNYm/1R81Dz3HvZRO8yAMYPlJbDWoYk/9TP+Geon/3JoLLv7B2cUeGclVgqpU+Xm0xc5w9AyTcHakzvXnuc7SoCb6wMO7jJ0bpjaH45gjroe0oIgiv6Sh8HY05cDAYw1/GxuAe/TohAlkBd9iXAaFKNQBjRqjde01inrR6BSLRF7t87+Z+9xL7ZH7w9NomDZxH8OMutiMc6zaDZRkVfn0n5mqkb4DoIe9S2j92VkcRrbsq1b5hxAzH0PWQhs8jVQQ+rGdh5pTJ7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwT/2FEAKHIhICDxyUseokQifhT/v6ENKFH472DQEAM=;
 b=lnDO6RdlkHrjBPuqBJtNAoStMzbi9NBpVRBLWL4cIop7VqzBdE1+HWsiVHeY6ISuA+5TnXcGtPBRw6r/aQZiVUHOhsuLfR7PswjmQyAE2rDVhBy6wW71VAbJNCvqMXJ4LpPYtdyJnmsLdB/NIs7hBMbqPyA7biie8psgzpQtW3MHQRnGOeQELyl5BwXQLNywEAIbNsRvMefP/un2417WD65CmnZtmUelBJYYGKW3Wxe1SWdVseHj4KnFFPsLA2jxDq2g29uSeilesDFsFMQ1alqJAQ7vYQ9oy4be0aUv0kmZoi2x62+u1YxGVRwe+/NtjSADLT248HuIecQ8RQ89rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5973.namprd11.prod.outlook.com (2603:10b6:408:14e::14)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 12:50:20 +0000
Received: from LV2PR11MB5973.namprd11.prod.outlook.com
 ([fe80::70b7:ecee:9b29:6a13]) by LV2PR11MB5973.namprd11.prod.outlook.com
 ([fe80::70b7:ecee:9b29:6a13%4]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 12:50:19 +0000
From: "Bhatt, Avinash" <avinash.bhatt@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "Guetta, Kobi"
	<kobi.guetta@intel.com>, "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: RE: [PATCH 1/1] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
Thread-Topic: [PATCH 1/1] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
Thread-Index: AQHc17AzW7QxlE0Jj0ChlyNh16qzK7X1slaAgAHdi8A=
Date: Thu, 30 Apr 2026 12:50:17 +0000
Message-ID: <LV2PR11MB5973C8853F837F65D30E2D47E0352@LV2PR11MB5973.namprd11.prod.outlook.com>
References: <20260429081403.46087-1-avinash.bhatt@intel.com>
 <20260429081403.46087-2-avinash.bhatt@intel.com>
 <4fda911e-df77-43bd-9248-e55ed587d040@kernel.org>
In-Reply-To: <4fda911e-df77-43bd-9248-e55ed587d040@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5973:EE_|DM3PR11MB8733:EE_
x-ms-office365-filtering-correlation-id: 15e9a91c-ea83-4dbb-d12f-08dea6b70822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: axJmSCb7O20S7JO4hm/zz7frqZ1xpcB9vJtVFkxa5cX2b4s/bEzGFuHWbWTn8i66ffBF9MpBNXm9YmZDNFTgySazVzs+adqi/OXLaUdiCmPnEll30BOwe1sxCqImhxFBRT3kG5DXA9th8qm3gVodr+RsSqm9suqOkBKfICr7oRgzHr4k/Pp3FC/CIS+FYwvO4ufZq/9ehjwxjaPFhKqUF6w/Oz7gDp/5Ti3f5D/3kQZUWHfVfaRfm04BJCZsMQxmQd0Vxd0ZnIoZ4gJgA99wd7wbwHTw6RXfwOxcYKzsVf9HBMAEJ4WJL9DvkWyrsr2f+eY5IfIrmK4k2Trh+nh+fCkAqDWr2nr5gRQiV9DJdjyX/DET5J++PnRp1HR4xdchzEHY+9O3kq4LxzohnhlNxUpyr/51tJ6XOIfoYyVv/mWDdhSXrkuKaVWmoeiZ0v6F1x5Ndvq7ippBt4oGwW8sMte4SGQrSNP5OAgIaplMsplU6qj19+QPLQVTigZiTr3SUKKyn0sRCCWOZEUofRbNmsW+pZOlBrkdTJPLFXy17SR3IhFQYQrw2t6bdOu+VrSYuWru9N8wMprj+lw4Mf0PAEWZ11ZrbotRAT0UMHe5Q+Zc+Lh79XyN2j0mw79xHxX1yFvn+875rgADAgpFlkbGp4R9AyXiLMVZzjT4kdYDFqsvSJILXcHQR1lHbQ4/SO6T0Wct9TXoOIdXr4T4NRjefE82V7oPHQMt3l8w9DCxN9LP3EVIZmiM0gZqdApSyWa8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5973.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFhqdytrUmdYbC9YOHpNUE9hMEx4MTRydDNUb1U4Qnp5T3hHU09nSHM0QmRv?=
 =?utf-8?B?WDJ1eXpyMituUE4weTFneTkrWWg0elBUNktDQStuTi9UbHdySnBEYms3SUpO?=
 =?utf-8?B?SkE1QkwvclVmZktGU3FnSkwyWmphNFZzOGJiS0xML2h1VXFremJhcTZad3kx?=
 =?utf-8?B?c0N6MzNKaktSQjBDa0hVcGNNSklDL0R2Q1RwREFjeVNjMmZTcHMweEtPNlI2?=
 =?utf-8?B?eGtlRXRISzRmR05MUnc3OXZ3bGFZT0cyUjY5S0NIQnpvZlBoNFJuQnE3VUNJ?=
 =?utf-8?B?c2FjSE40R1AyMlJDWE0waDRqc1hCS1UzUzdZQzlTQ3hGK2ZCajNORUJEMVE2?=
 =?utf-8?B?UDZmekdDV2xKUXROMVFQQWg2WlErTG9WYlhzQlZLWnFpVWI3cmNNcEhGbi8v?=
 =?utf-8?B?TUV6RlVrZy9YTkpXQXZkRTRHcFhkTENCZXlEQUxvU080TU5mTVVqU3ZkS2Uv?=
 =?utf-8?B?eklhMjJiaThBbkZVNHh0cVlBWEpSd040SGZSYzR2b2xIZmhSNjBKYVNEWE9r?=
 =?utf-8?B?eTBUb1dLOEg0dzBJSXE3V1BqMGtSOE5kKzN5SFI2dzZueTI5NlI4T3BMYjd6?=
 =?utf-8?B?d0syRkd0dG9OLzl6STk2cjEzU0tnS29yQUQzd05aZENpcGZBdVRRelUxbE9n?=
 =?utf-8?B?Wjc3TTFOQmxDRFZDNkFTSWZPRWVtNTlYak56ZE56R0NUbk10bGtyRm9zMHBJ?=
 =?utf-8?B?SGdRZjcxRW9jaUtON2hjVzBadDB0TnpQQzRyN0dONERSOXZXNmJzRTZON3FM?=
 =?utf-8?B?SWFMeDJxeWIvTFN2MFZ5MkVYZ3RRR0ZXUDFXNlJRek1oS0dJbHZVVGtYenk1?=
 =?utf-8?B?ZVA4NUx2RHNLTm1icEJObW85QlpwdVVPN28rVy83ck9vejBWZ1p5NXhST0tj?=
 =?utf-8?B?bHRSZHpaVnkxSTZzVWRVYmwzNHFwcUdpYTdmRTVvbm1kOHpSdVRuZnBNd2dS?=
 =?utf-8?B?U1dRMkJJdE5DQ1dTcnlmZVR5enFOa3k5VjVIT01COHY1TlRhQTF2QWpFOTdS?=
 =?utf-8?B?emhCM3F3dGNhUDdOU09XUEtBcEl1NkhRai9SK2RUZTFkRWF6ZHJKMFFGYXd1?=
 =?utf-8?B?dy9tV1duOWpvcmV2OVBsWTZYb0dXckFRbDlkNW9VSmxaMldWeXg0V0wwQ3hq?=
 =?utf-8?B?VEZGZFlvc1FqOUtUUjF4Ui9rKzRBcVphSTJzaXo1V3pmUHh3SThwM0YrRER2?=
 =?utf-8?B?RmhLQUhMc3FDalpST0haSU9IeTBiQStMNnlxeTlPbU5Qa0ZPZmxaejVibThC?=
 =?utf-8?B?Z2ZGZStkNGVqYWozQ0luaytmRWFyQW1HNkFodFlJK1d1TUdlNzNMd0g4ckQz?=
 =?utf-8?B?OVpMWTN2eFhGYUkzRnhUV0E0S1lQdlVEU01ucG9VMzBqbVdHd2pnMlFPUFVF?=
 =?utf-8?B?RWxxNXFsQ2dHS0xzMnRWNUFyUzNNZFIzMnBldW5jb2VEeGxLdW5PcHlLRjZX?=
 =?utf-8?B?WllGWmg5di9hYkZnMnNuQzRBZU9jd29BSXl2blc4bG5LaERPNCtGK1JHUjVl?=
 =?utf-8?B?dmowTmxwNHE1L2VRaWJzZGRQaWl0U3c3N3VrZWpCczQvTURLcVJnYk1KZjBk?=
 =?utf-8?B?SWR0eG5XQmdLZzI2UFFzNkwxTEx6RlFIZk1TcXAvRWp3N0tVdmczcGpUcVZ6?=
 =?utf-8?B?Z0N4cWhhTFg1dmxBbmxrc0ZPVG5ncnFKT0pmYzBWQy96bDg1YXJzZG9WKzhD?=
 =?utf-8?B?bXJVNTE3VDgwZVpxMVlZMEIwYnphclA5cVB0eC91eXNLaWxDTFdFdHU4bW5m?=
 =?utf-8?B?bWtSMVZPZzh3L2tVRkUvQnVONjBwS2Q3RXVUcDN6bUpnb1hGVXdxTER3YVJi?=
 =?utf-8?B?enM0aWQ1VDZIeGxCK0U1N0EvWlJtc2ZoYlY4MXM1RS92OHhlTUF0MjVvSXRp?=
 =?utf-8?B?ZDdLK252RkhjZnNzd2kva1RlOHdXOG5qem41bmVGY0FqR3NzbWZtYUNyOXRi?=
 =?utf-8?B?M1V1cjNENzZFQStzUFAyczlwanRBaGdKZDl0cTc4UkVyOFNtWkY3NXplaFdW?=
 =?utf-8?B?d2daWW9SNlpvYXpQRkt1cElCbUZaSkliQ3Q4Z0E1dWlQMkhqcTBNVlVGenhP?=
 =?utf-8?B?VUt4OUZkaHJZeGdKdGErNHFldktUY2JjTDEvSjNIbE9weUZwR3kvRjBwSHFh?=
 =?utf-8?B?WkNkQUY1L2I3T3dMMkU4NkFSR2tLZ0RUd2tFTThnY3BwNEUzbis5L2hOSWwy?=
 =?utf-8?B?dHI0eDNoRENKaTZ5TG1STE9NQ2FuU3EwdnNsN1JoODhPQnFCRGNxbkZ2ZmNw?=
 =?utf-8?B?RHNLWlZMTUQyTm1Hb0M3T3p1WFgrMlU4dTJUZjV2LzZ5Wk5MQzMzb2NNTC9l?=
 =?utf-8?B?Ui83dXc0bFZzNjVGcWJva25JdTlCMGdvV1V3LzN0N2VaVm8ycCt4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fEI/tTOu3DAzMvtZC72Nhdc+N07mCfnYUHNUpVlrPlsvKQW/PNPkF1aXWtRoICXYA3JL6s27Gp7YF4CQD0R0qbNDxXAfNuxSzmvJSniExviUhUBgG/t5pS8hxHixLQZCxam9m5gmXKZ1zh3gqiP+rLK+m6r4KGm0lhg3kC58ilJMw5S8TdC2yb0sybnYKfdiFcvM5DUi4lDj8A82uC7isgU/o59ljxcsTZ8ChfpJRERG1VlYhLnP9xnpe8H4cp1w0R5CT92snio3XRyZNntbdQxa/dLdd4V5hCku1IB2RJNeEbV9o9SSiPXNwrQtfHCM9+8xh1Kq4TjnjAWnx1RpVA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5973.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e9a91c-ea83-4dbb-d12f-08dea6b70822
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 12:50:17.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJwy1f9GqSzEzMvnoZqu0dRtC1cHvMtFhOSLqtlbYbLAzhySGkPJik6kMc3qdzLwgPpYh3CyV4tygMrEkPJDzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 793834A2EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35709-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,LV2PR11MB5973.namprd11.prod.outlook.com:mid,devicetree.org:url];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIFJlc3BvbnNlcyBpbmxp
bmUuDQoNCk9uIDI5LzA0LzIwMjYgMTA6MTQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
IE9uIDI5LzA0LzIwMjYgMTA6MTQsIEF2aW5hc2ggQmhhdHQgd3JvdGU6DQo+PiBBZGQgYSBkZXZp
Y2V0cmVlIHNjaGVtYSBiaW5kaW5nIGZvciBJbnRlbCBkaXNjcmV0ZSBXaS1GaSA3IEJFMjAwIFBD
SWUNCj4+IGFkYXB0ZXJzLg0KPg0KPiBXaHk/IFdoZXJlIGlzIGFueSB1c2VyIG9mIHRoYXQ/DQoN
ClRoZSBkcml2ZXIgaW1wbGVtZW50YXRpb24gY29uc3VtaW5nIHRoZXNlIHByb3BlcnRpZXMgZXhp
c3RzIGFuZCB3aWxsIGJlDQpzdWJtaXR0ZWQgYXMgYSBjb21wYW5pb24gc2VyaWVzIHRvZ2V0aGVy
IHdpdGggdjIgb2YgdGhpcyBiaW5kaW5nLg0KDQo+PiArICAtIGxpbnV4LXdpcmVsZXNzQHZnZXIu
a2VybmVsLm9yZw0KPg0KPiBEcm9wIHRoaXMgb25lLg0KDQpBY2suIFdpbGwgYWRkcmVzcyBpbiBQ
QVRDSCB2Mi4NCg0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgSW50ZWwgaXdsd2lmaSBJRUVFIDgw
Mi4xMWJlIGRpc2NyZXRlIFdpLUZpIGFkYXB0ZXJzIGNvbm5lY3RlZCBvdmVyIFBDSWUuDQo+DQo+
IFBsZWFzZSB3cmFwIGNvZGUgYWNjb3JkaW5nIHRvIHRoZSBwcmVmZXJyZWQgbGltaXQgZXhwcmVz
c2VkIGluIEtlcm5lbA0KPiBjb2Rpbmcgc3R5bGUgKGNoZWNrcGF0Y2ggaXMgbm90IGEgY29kaW5n
IHN0eWxlIGRlc2NyaXB0aW9uLCBidXQgb25seSBhDQo+IHRvb2wpLiBIb3dldmVyIGRvbid0IHdy
YXAgYmxpbmRseSAoc2VlIEtlcm5lbCBjb2Rpbmcgc3R5bGUpLg0KDQpBY2suIFdpbGwgYWRkcmVz
cyBpbiBQQVRDSCB2Mi4NCg0KPj4gKyAgVGhlc2UgYmluZGluZ3MgcHJvdmlkZSBPRU0gcGxhdGZv
cm0gY29uZmlndXJhdGlvbiBmb3IgcGxhdGZvcm1zIHRoYXQNCj4+ICsgIHVzZSBEZXZpY2UgVHJl
ZS4NCj4NCj4gRHJvcC4gRGVzY3JpYmUgaGFyZHdhcmUuDQoNCkFjay4gV2lsbCBhZGRyZXNzIGlu
IFBBVENIIHYyLg0KDQo+PiArICBpbnRlbCxhY3RpdmF0ZS1jaGFubmVsOg0KPj4gLi4uDQo+PiAr
ICBpbnRlbCxmb3JjZS1kaXNhYmxlLWNoYW5uZWxzOg0KPg0KPiBJIGRvbid0IHNlZSBob3cgdGhp
cyBpcyBhIERUIHByb3BlcnR5LiBBY3R1YWxseSBtb3N0IG9mIHRoZSBwcm9wZXJ0aWVzDQo+IGRv
IG5vdCBsb29rIGVpdGhlci4gRG8geW91IHdhbnQgdG8gc2F5LCB0aGF0IGlmIEkgZ28gd2l0aCBt
eSBkZXZpY2UgZnJvbQ0KPiBFVSB0byBVUyBvbiBhIGJ1c2luZXNzIHRyaXAsIEkgd2lsbCBuZWVk
IHRvIHJlY29tcGlsZSBEVEI/IE9idmlvdXNseQ0KPiBuby4uLg0KDQpUaGVzZSBwcm9wZXJ0aWVz
IGRlc2NyaWJlIGhvdyB0aGUgV2lGaSBOSUMgd2FzIGludGVncmF0ZWQgaW50byB0aGUNCnN5c3Rl
bSBieSB0aGUgT0VNIOKAlCBzcGVjaWZpY2FsbHksIHdoaWNoIHJlZ3VsYXRvcnkgY2VydGlmaWNh
dGlvbnMgd2VyZQ0Kb2J0YWluZWQgZm9yIHRoaXMgaGFyZHdhcmUgU0tVIGF0IG1hbnVmYWN0dXJp
bmcgdGltZS4gVGhhdCBpcyBhIGZpeGVkDQpoYXJkd2FyZSBwcm9wZXJ0eSBvZiB0aGUgYm9hcmQs
IG5vIGRpZmZlcmVudCBmcm9tIGRlc2NyaWJpbmcgYW50ZW5uYQ0KY29uZmlndXJhdGlvbiBvciBS
RiBmcm9udC1lbmQgY2FwYWJpbGl0aWVzLg0KDQpUbyBjbGFyaWZ5IHRoZSB0cmF2ZWwgYW5hbG9n
eTogdGhlIHJlZ3VsYXRvcnkgZG9tYWluICh3aGljaCBjb3VudHJ5IHRoZQ0KZGV2aWNlIGlzIGN1
cnJlbnRseSBvcGVyYXRpbmcgaW4pIGlzIGRldGVybWluZWQgYXQgcnVudGltZSBieSB0aGUga2Vy
bmVsDQpyZWd1bGF0b3J5IHN1YnN5c3RlbSwgaW5kZXBlbmRlbnRseSBvZiB0aGVzZSBwcm9wZXJ0
aWVzLiBXaGF0IHRoZXNlDQpwcm9wZXJ0aWVzIGVuY29kZSBpcyB3aGF0IHRoZSBoYXJkd2FyZSBp
dHNlbGYgaGFzIGJlZW4gY2VydGlmaWVkIGZvci4NCkZvciBleGFtcGxlLCBiaXQgMCBvZiBpbnRl
bCxhY3RpdmF0ZS1jaGFubmVsIG1lYW5zICJ0aGUgT0VNIG9mIHRoaXMNCmJvYXJkIG9idGFpbmVk
IEVVIGluZG9vciBjaGFubmVsIGNlcnRpZmljYXRpb24gZm9yIHRoaXMgU0tVLiIgVGhhdA0KY2Vy
dGlmaWNhdGlvbiBkb2VzIG5vdCBjaGFuZ2Ugd2hlbiB0aGUgZGV2aWNlIHRyYXZlbHMg4oCUIGl0
IGlzIGEgcHJvcGVydHkNCm9mIHRoZSBoYXJkd2FyZSwgbm90IG9mIGl0cyBsb2NhdGlvbi4NCg0K
VGhlIHBlci1jb3VudHJ5IGdyYW51bGFyaXR5IGV4aXN0cyBiZWNhdXNlIHJlZ3VsYXRvcnkgY2Vy
dGlmaWNhdGlvbnMgYXJlDQppc3N1ZWQgaW5kZXBlbmRlbnRseSBieSBlYWNoIGNvdW50cnkncyBh
Z2VuY3kgKEZDQyBmb3IgdGhlIFVTQSwgSVNFRA0KZm9yIENhbmFkYSwgZXRjLiksIHNvIGVhY2gg
Y291bnRyeSdzIGVuYWJsZW1lbnQgaXMgYSBzZXBhcmF0ZSBPRU0NCmRlY2lzaW9uIHJlZmxlY3Rl
ZCBpbiB0aGUgYm9hcmQgZGVzaWduLg0KDQoNCkJlc3QgcmVnYXJkcywNCkF2aW5hc2gNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtA
a2VybmVsLm9yZz4gDQpTZW50OiAyOSBBcHJpbCAyMDI2IDEzOjQ5DQpUbzogQmhhdHQsIEF2aW5h
c2ggPGF2aW5hc2guYmhhdHRAaW50ZWwuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcN
CkNjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBr
ZXJuZWwub3JnOyBqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0OyBLb3JlbmJsaXQsIE1pcmlhbSBS
YWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IEd1ZXR0YSwgS29iaSA8
a29iaS5ndWV0dGFAaW50ZWwuY29tPjsgR3J1bWJhY2gsIEVtbWFudWVsIDxlbW1hbnVlbC5ncnVt
YmFjaEBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gZHQtYmluZGluZ3M6IG5l
dDogd2lyZWxlc3M6IGludGVsLGl3bHdpZmk6IGFkZCBiaW5kaW5nDQoNCk9uIDI5LzA0LzIwMjYg
MTA6MTQsIEF2aW5hc2ggQmhhdHQgd3JvdGU6DQo+IEFkZCBhIGRldmljZXRyZWUgc2NoZW1hIGJp
bmRpbmcgZm9yIEludGVsIGRpc2NyZXRlIFdpLUZpIDcgQkUyMDAgUENJZSANCj4gYWRhcHRlcnMu
DQoNCldoeT8gV2hlcmUgaXMgYW55IHVzZXIgb2YgdGhhdD8NCg0KPiANCj4gVGhlIGJpbmRpbmcg
ZG9jdW1lbnRzIE9FTSBwbGF0Zm9ybSBjb25maWd1cmF0aW9uIHByb3BlcnRpZXMgZm9yIA0KPiBw
bGF0Zm9ybXMgdGhhdCB1c2UgRGV2aWNlIFRyZWUgaW5zdGVhZCBvZiBwbGF0Zm9ybSBmaXJtd2Fy
ZSBtZXRob2RzLiANCj4gQWxsIHByb3BlcnRpZXMgbWlycm9yIHRoZSBleGlzdGluZyBlcXVpdmFs
ZW50cyBpbiBzdHJ1Y3R1cmUgYW5kIA0KPiBzZW1hbnRpY3MsIGNvdmVyaW5nIFNBUiBwb3dlciBs
aW1pdHMgKGludGVsLHdyZHMpLA0KPiA2IEdIeiBBUCB0eXBlIHN1cHBvcnQgKGludGVsLHVhdHMp
LCBzdGF0aWMgcG93ZXIgbGltaXQgKGludGVsLHNwbGMpLCANCj4gY2hhbm5lbCBwdW5jdHVyaW5n
IChpbnRlbCx3Y3BlKSwgMzIwIE1IeiBwZXItTUNDIGVuYWJsZW1lbnQgDQo+IChpbnRlbCx3YmVt
KSwgRVRTSSBTUkQgY2hhbm5lbCBjb25maWd1cmF0aW9uIChpbnRlbCxzcmQpLCA2LTcgR0h6IFVI
QiANCj4gY291bnRyeSBlbmFibGUgYml0bWFzayAoaW50ZWwsNmUtdWhiKSwgYW5kIGFkZGl0aW9u
YWwgcmVndWxhdG9yeSANCj4gb3ZlcnJpZGUgcHJvcGVydGllcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEF2aW5hc2ggQmhhdHQgPGF2aW5hc2guYmhhdHRAaW50ZWwuY29tPg0KPiAtLS0NCj4gIC4u
Li9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvaW50ZWwsaXdsd2lmaS55YW1sICB8IDQ0NSANCj4gKysr
KysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDQ1IGluc2VydGlvbnMoKykNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC93aXJlbGVzcy9pbnRlbCxpd2x3aWZpLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgDQo+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9pbnRlbCxpd2x3
aWZpLnlhbWwgDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJl
bGVzcy9pbnRlbCxpd2x3aWZpLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5kOTdiZTZjYzM1ZDgNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL2ludGVsLGl3bHdpZmku
eWFtDQo+ICsrKyBsDQo+IEBAIC0wLDAgKzEsNDQ1IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgIyBDb3B5cmlnaHQgDQo+ICso
YykgMjAyNiBJbnRlbCBDb3Jwb3JhdGlvbiAlWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9uZXQvd2lyZWxlc3MvaW50ZWwsaXdsd2lmaS55YW1s
Iw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQo+ICsNCj4gK3RpdGxlOiBJbnRlbCBpd2x3aWZpIFBDSWUgV2ktRmkgZGV2aWNlcw0KPiAr
DQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBBdmluYXNoIEJoYXR0IDxhdmluYXNoLmJoYXR0QGlu
dGVsLmNvbT4NCj4gKyAgLSBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCg0KRHJvcCB0
aGlzIG9uZS4NCg0KPiArDQo+ICtkZXNjcmlwdGlvbjoNCj4gKyAgSW50ZWwgaXdsd2lmaSBJRUVF
IDgwMi4xMWJlIGRpc2NyZXRlIFdpLUZpIGFkYXB0ZXJzIGNvbm5lY3RlZCBvdmVyIFBDSWUuDQoN
ClBsZWFzZSB3cmFwIGNvZGUgYWNjb3JkaW5nIHRvIHRoZSBwcmVmZXJyZWQgbGltaXQgZXhwcmVz
c2VkIGluIEtlcm5lbCBjb2Rpbmcgc3R5bGUgKGNoZWNrcGF0Y2ggaXMgbm90IGEgY29kaW5nIHN0
eWxlIGRlc2NyaXB0aW9uLCBidXQgb25seSBhIHRvb2wpLiAgSG93ZXZlciBkb24ndCB3cmFwIGJs
aW5kbHkgKHNlZSBLZXJuZWwgY29kaW5nIHN0eWxlKS4NCg0KPiArICBUaGVzZSBiaW5kaW5ncyBw
cm92aWRlIE9FTSBwbGF0Zm9ybSBjb25maWd1cmF0aW9uIGZvciBwbGF0Zm9ybXMgdGhhdCB1c2Ug
RGV2aWNlIFRyZWUuDQoNCkRyb3AuIERlc2NyaWJlIGhhcmR3YXJlLg0KDQo+ICsNCj4gK3Byb3Bl
cnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgZW51bToNCj4gKyAgICAgIC0gcGNpODA4
NiwyNzJiDQo+ICsNCg0KLi4uDQoNCj4gKw0KPiArICBpbnRlbCxhY3RpdmF0ZS1jaGFubmVsOg0K
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBJbmRvb3IgY2hhbm5lbCBhY3RpdmF0aW9u
IGJpdG1hc2suIFNldHMgc3BlY2lmaWMgZnJlcXVlbmN5IGJhbmRzIHRvDQo+ICsgICAgICBhY3Rp
dmUgKHJhdGhlciB0aGFuIHBhc3NpdmUgb3IgZGlzYWJsZWQpIHdoZW4gdGhlIHBsYXRmb3JtIGlz
DQo+ICsgICAgICBjb25maXJtZWQgdG8gYmUgb3BlcmF0aW5nIGluZG9vcnMuDQo+ICsNCj4gKyAg
ICAgIExheW91dCAoMiBjZWxscyk6DQo+ICsgICAgICAgIFswXSByZXZpc2lvbiAtIHN0cnVjdHVy
ZSByZXZpc2lvbiwgbXVzdCBiZSAweDAwDQo+ICsgICAgICAgIFsxXSBiaXRtYXAgICAtIHBlci1y
ZWdpb24gaW5kb29yIGFjdGl2YXRpb24gZmxhZ3M6DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGJpdCAwID0gZW5hYmxlIEVVIFUtTklJLTEgKDUuMiBHSHopIGZvciBpbmRvb3JzIG9ubHkNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgYml0IDEgPSBlbmFibGUgSmFwYW4gVS1OSUktMSAoNS4y
IEdIeikgZm9yIGluZG9vcnMgb25seQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBiaXQgMiA9
IGVuYWJsZSBDaGluYSBNYWlubGFuZCBVLU5JSS0xICg1LjIgR0h6KSBmb3IgaW5kb29ycyBvbmx5
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJpdCAzID0gZW5hYmxlIFVTQSBVLU5JSS00ICg1
LjkgR0h6KSBmb3IgaW5kb29ycyBvbmx5DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJpdCA0
ID0gZW5hYmxlIFdXIFUtTklJLTEgKDUuMiBHSHopIGZvciBpbmRvb3JzIGluIGFueQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvdW50cnkgd2hlcmUgdGhlIGJhbmQgaXMgcGVy
bWl0dGVkDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJpdCA1ID0gZW5hYmxlIENhbmFkYSBV
LU5JSS00ICg1LjkgR0h6KSBmb3IgaW5kb29ycyBvbmx5DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGJpdCA2ID0gZW5hYmxlIFVTQSArIENhbmFkYSArIFdXIFUtTklJLTQgKDUuOSBHSHopIGZv
cg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZG9vcnMgb25seQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBiaXRzIDctMzE6IHJlc2VydmVkLCBtdXN0IGJlIDANCj4gKyAg
ICBhbGxPZjoNCj4gKyAgICAgIC0gJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvdWludDMyLWFycmF5DQo+ICsgICAgICAtIG1pbkl0ZW1zOiAyDQo+ICsgICAgICAgIG1heEl0
ZW1zOiAyDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6IDANCj4gKw0K
PiArICBpbnRlbCxmb3JjZS1kaXNhYmxlLWNoYW5uZWxzOg0KDQpJIGRvbid0IHNlZSBob3cgdGhp
cyBpcyBhIERUIHByb3BlcnR5LiBBY3R1YWxseSBtb3N0IG9mIHRoZSBwcm9wZXJ0aWVzIGRvIG5v
dCBsb29rIGVpdGhlci4gRG8geW91IHdhbnQgdG8gc2F5LCB0aGF0IGlmIEkgZ28gd2l0aCBteSBk
ZXZpY2UgZnJvbSBFVSB0byBVUyBvbiBhIGJ1c2luZXNzIHRyaXAsIEkgd2lsbCBuZWVkIHRvIHJl
Y29tcGlsZSBEVEI/IE9idmlvdXNseSBuby4uLg0KDQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YN
Cg==

