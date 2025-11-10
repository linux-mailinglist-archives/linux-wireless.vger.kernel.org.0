Return-Path: <linux-wireless+bounces-28784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C437C46D23
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6239C3A8553
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148530FC19;
	Mon, 10 Nov 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwAfQtgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D71EE7C6;
	Mon, 10 Nov 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780635; cv=fail; b=EAJ/4J5wFvZs2ucgASJfIvPXQMvy9WDYUOzjwJyBLgj0Tt2aa/xNhMtK35DGfyfnyjxVdqLna9/67qI2e4JiAMUTEvDirvBHqF/MQeAE3+SCBh/s7S/8ykSy05gq4ZfiLL4+aLHdzz56R1VkW5n2Q/y/AyVbUCb7SpTvuNn6f4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780635; c=relaxed/simple;
	bh=X+K6ZMTq63SSm4ftKGRC+udYBMZjg6EgvBMwEhFYL3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KsI5qVSwMSmJ9gXvDhqPes5JrF62KABjo/pwtTcyeO+V9X2eGeAn/JcHKjTEyuB+/yoRQJMafEbRKS92+anBZcPNSCa7/EILC5zdjonxdOiNveHg79fTYHRM+AXk6X5mi6cV6dhId3iYnVHQPFAGhSoc8Oi3pajrimbnw8ncTx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwAfQtgK; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762780634; x=1794316634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+K6ZMTq63SSm4ftKGRC+udYBMZjg6EgvBMwEhFYL3c=;
  b=gwAfQtgKA69rX3CenTBqv6WLqRmpVE6y3L+Q+a7EhJYZKXqN/KIg0ove
   MPAoE5sKixv9xeeFSeaP3IZHtn9Z9+hlUHtXN7s9oV0H195WN8N3D6+NV
   rQn+22cz9Q2hPbILriCTR/tsNV3ZB8XL+eqMZmxhSn2lCdKZoJBpdu8ko
   kSpl+Q+3Dl+ATTgFIiQIkrnz3LbQA9HSK4IgC9mxawt8Xa58M14uOeviY
   oqiVwxsZ/0ZC7Qk6R3kZaNCqf6VehtsX2BDJ3/DLJchwLqI/lAp95nf2/
   mCkE0qgMtlNzRPiEqFJUPtc3yJ+iNo+f3LKpCAvGAhLQWy4KXp2cisIMk
   A==;
X-CSE-ConnectionGUID: efAwjZdRS9GPYpS99Go0qw==
X-CSE-MsgGUID: 4RnU+Wb6Q++JJToG4nroOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75934429"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75934429"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:17:13 -0800
X-CSE-ConnectionGUID: f6qv1amARk+hWQkE8SPP4A==
X-CSE-MsgGUID: yJSZGWYPT8WXSe8uZJ4Egw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188508898"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:17:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 05:17:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 05:17:12 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 05:17:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLyctw31kO6xmv7UDHuBWKsHLxOOdVdG1AlewFVrJ5nfBdbgCZ5Eou4kFnCGBZDXBfvkSOpyNriOg59sIZjG5a9O2n1TxdOxhj1pfMxI9y5lfO/+/C6m0T1AkE8iAWd5mHx2Xd16g9MD28dyyoTc9GpzF7S61kCaP6rT9ax72qUySoFhx8rTLcUBnkQZpB/u0zQAQEEkiSLiuwaQ/qRsxiVcy+b0W3r73T2AEq8f1vNmNDc+BKpKcCH1bnT3WofVMDmr0UQwe43uGTL3UgHNrAk3pYvyBODkL3JA6p6cXcZ2s/s6nx9irVjoh68saRIVxu+xOmN8Ox/oOfq4Ac0A3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+K6ZMTq63SSm4ftKGRC+udYBMZjg6EgvBMwEhFYL3c=;
 b=Hllgzc643+rQcPOBOO6unlqSdm6V3C2DizYO5kc5UOQxHTa8x/6i0x8DXOk5gQvFffABNzJ6E2kyGNZmo/aaG0MFi53diY34y6YoZwQ94mj7j7WZrVdmg/QtvvAs908b3pXGrdoU9GK4ffzfmQEvsB+iCEqugskcRT4XcmBUARWT6pRLRwKAmlpyyTnYjUJEOn2KwOSagmWlmPBiunC3qPOl3G61/XbZ5WhEciRizOmlAt/MXcUmsO/aLkNr9dx4eyZgbYRC7qnu1A644wjlAYMUtfifyt8H7LiNtY5EHp8YEcBVYW928sLI51tJ51dW3tPM//j+mOQxQyUamoSyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA3PR11MB9424.namprd11.prod.outlook.com
 (2603:10b6:208:583::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:17:10 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%8]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 13:17:10 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ally Heev <allyheev@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: RE: [PATCH v2] net: wireless: fix uninitialized pointers with free
 attribute
Thread-Topic: [PATCH v2] net: wireless: fix uninitialized pointers with free
 attribute
Thread-Index: AQHcT71B3Jl2qhIBNEq4wwkByqsxNbTr55eQ
Date: Mon, 10 Nov 2025 13:17:10 +0000
Message-ID: <DM3PPF63A6024A9B5D5C1983918C785DA13A3CEA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251107-aheev-uninitialized-free-attr-wireless-v2-1-674fc3e5c78e@gmail.com>
In-Reply-To: <20251107-aheev-uninitialized-free-attr-wireless-v2-1-674fc3e5c78e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA3PR11MB9424:EE_
x-ms-office365-filtering-correlation-id: 7af9d507-7a77-47e9-7a0d-08de205b7491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z2FLaWdRekQvdWdlUWowdmlKaE5SRWJyckx1dUV4Z2lkRlE1MFYrazhzbVpI?=
 =?utf-8?B?VUo1WHFzOTRaV3RONVJSRFQvT2kyTldlL3UzdThIaVJja2dlbkNUNS94NmJm?=
 =?utf-8?B?WEdITEpxOUJ5QWFsNjVvMGxHaWhpMGtrK3JFTzJDc0JQaEo3N2U4NFJXN3dk?=
 =?utf-8?B?VnVYV2ozeDFtTDNHUno3cC9VKzFhM2tpQXczZTJQTDhxeVRPMHRYSlg4cWU0?=
 =?utf-8?B?VmtxcEFycnU5czk1ak02TFVMT0pDQWJweUowZDhPR0c1MEh6MUE2VmFDUVh4?=
 =?utf-8?B?dkt6cUhuZWk2MzdLZXFWRmVRQXlUUmhoTHR1TkZVMHBFenRNWE00cVk4d2dV?=
 =?utf-8?B?bVIyWmdHcy84YzkrdTc1aGp5a3N6YjVLUCtJek9SNTZmRTduNi9yUnBiaXIx?=
 =?utf-8?B?V0FVVTVob3hGN2diYUFXN0ttYlpOS2ozdUpyZEk5SDlnbDNramplSTl0MjhO?=
 =?utf-8?B?K2JBN0l2Rk9lUklma1VESUpRczJrdi9GblloOWlDZ2NUb0FMaUxkQjQvK1Ev?=
 =?utf-8?B?elltSDdvYmNKY2JrQTlBRTZRdHJYaUU5MlRDT216QzhyS2FDLzkyYm5XYlZm?=
 =?utf-8?B?TUt1bmlaZC91ZGFzcU9UdnlLa29XbHhyNGRzT3pOdFk4TmhRZzdVVitVeXFl?=
 =?utf-8?B?NkZGSkxCdEJDRW5ja3g3K3piU2QvdW94T3g3MEpFdndVVW1Ma3RYVHcrK0tw?=
 =?utf-8?B?VkwxK0FPV0VBMm1BalVhSmJmUnprRXMvTnpNQ2dvMmxIcUhsdi9jbEJjb09s?=
 =?utf-8?B?Y0owTGM1WW9XTFQ4MldkczBUclhBakx1ZzQxSWVJNTgrNzRvYmZPZFFlaVh4?=
 =?utf-8?B?bUJLTHgxZGJmR25JVDhLWFd2cWpKd3I1RHNCUlpwcWFDTHdjb1oyTHVVODk0?=
 =?utf-8?B?eUpKczNyN1FVMzJVSVNFWjR3TjBjNDhocGJpN0ZreTVYZkxLdlRRTy9EQlhG?=
 =?utf-8?B?SGUxMWhWTGgzbjNhRFRRN1BXVndJejZTbkJuSjc0T3AzcUg0QlVZcWVwd3Rl?=
 =?utf-8?B?UHRrdGJiZ0JGcHp5ZEFKUTdvTWI4emlCMnQ0VWhVK05sLzRJZmdiVmtCK3JC?=
 =?utf-8?B?dFFkelJiYzQ2SUVpMWlOL3VONkZIcE03dCtjRmhCeVUwMUJacEdycjFsK0NS?=
 =?utf-8?B?amNDb29MZHF1b0t3d1R5NURvaWJVZHZNZFdIa2dCTVZXVk95SjdQM2Q0YXQx?=
 =?utf-8?B?aXREY3ptNitpOVFWa0N1QitLczZrNXdIYk9PZEpjMjVxYk1RajFIQ0s1OVVO?=
 =?utf-8?B?ZnRLTlBwaHJ0cDdRSFFad1UzbHl0Ui9VdEd2bElVSHRHazJ4cERLQzVxRkx6?=
 =?utf-8?B?cDFpMnJEWk9FYXFyUGZ0UEUxQjFYSnhjSVNCMGNXK2ZPQkhFRCt0TVVuWTBs?=
 =?utf-8?B?YzdkeXdmUHNjcjBsZnAwT2NwYUk1UUlrZHlPQjF6ZURyc0dmYlRMUDJEM0hL?=
 =?utf-8?B?VXU4VEd5Wm5xWlNsTWhvVmxES2N1dWdPcGRlQnFDSldoSFY3MGRJUFkxM0tZ?=
 =?utf-8?B?L0FQaUUvR25GMWpvUGYrbmtkdWZVbTJFYTVoNFJtNjFHMXZHL2FyZHVOSGdE?=
 =?utf-8?B?cnFjc1dpQ1hOREwwc1RtNVhmeUllOEpmUjVSOUtuSTVuazFsTC9saDVCQ3BO?=
 =?utf-8?B?alZ3dFFoZ3RsU21MWWF5S0JXNUtacDZjalg2RFYwVTIvanZNVDRmdjNrelND?=
 =?utf-8?B?VEtQY0ZmT01QbFZ3V0l0QnJVaEtPbTlFZzJKM2Q2Y0hBNHo5ZEdzcmRRN2Nh?=
 =?utf-8?B?T3I5cStXTVFkZ1NLSEZ3VVFqQmowUkVJN1BnV2ErU2k1T014L1J3WUNqSFNh?=
 =?utf-8?B?ZUVFZWxWU3p1aUpQdU50K3loWm1kT3BQN0E3ZW9rd3ZPVlhmSTNjYTRPOHVD?=
 =?utf-8?B?YU82bTNYell1eHJLMzM5U1Y3K0Frc2VwQmhqWk5TLzIyT1VzdVJBZmY1TjRP?=
 =?utf-8?B?WnU3Ty9ucC9rR0JrMSt6THdZdURFc0dUc2xHTGZlWkRMRXdsNVB0Nm02eGlJ?=
 =?utf-8?B?R29NWU1JN29DOTBZTk4vZ1pjeVJtRjZuZWVubVk5emZlRDFIUzh2UlVYVytQ?=
 =?utf-8?B?SC9tZGhhVUoxZldhRzdSVEl4WjhLUDhxVGpmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmRDSlp3aXNYQStjc2UyNlpwUU1zaVM2NmRVV3dyTWpDL0VhYXcxN0pTcmFu?=
 =?utf-8?B?LzNhZEx4ZVVrQnRBWFhFd2pKNm14d2JSTWU1OWFibVB2Ukc1V2ZrWk9lQU5j?=
 =?utf-8?B?bnU3WlNOSG1COS96TWZSMityWnQwcHZtbEdYQlpqcXp1NWR0OHF0czluLzBx?=
 =?utf-8?B?QTVoaW9ORW9HMFpQV0JpT1RQUENPMzlMV1NRV2VzQ05wU1Bjb0IvNk9Ud0hQ?=
 =?utf-8?B?bGMvOVE1V3MxMmt5RHFWMnV5Zk9saEJVL05QRXNsMmcxSU1lTXNQTG8wRFR1?=
 =?utf-8?B?cklpWit4eEl4bUs4WE9JYllnMzJqTWk3T1NjWS9DQnhBQW9DMkZ3blFxZEQv?=
 =?utf-8?B?M0hJdmdIU2RzYndHb2d1VSs3bi9ZSC9wdEI0a2hWcEpzb01vMGJITHFlNE5V?=
 =?utf-8?B?RVR1dVpubE1Fb3UrRHpiR3ExZ3lhYlBJSDZYOHpsUHc5dnA5ZFdMNDBzRHVi?=
 =?utf-8?B?MGdwTytHcWhqWTMxYlR1YmlzODZQWWtwejFoU2NaWE1RNUxiUFd4aWp5WXZ6?=
 =?utf-8?B?NnRzS2xXOSt2SUN0U2lRWDRyQ1VBKzRmb3VHbm94cjVtWlJFYjhSRWJITXY5?=
 =?utf-8?B?eUFGOERGYjZ6NnFiTkxOa2lDZDhyQ0swcTVYYUo3U2N5MmQrdmdwNkVHMldq?=
 =?utf-8?B?a1N3bUZZMW03bm1ZQW5jNHlPakFWa2o4MnJsVTdkdmxaNk9kZE9NR3VUdVUw?=
 =?utf-8?B?MFVZU2NaK1pvNU92SDNFMzVzWDZHZlg2T3ZtdlllRE1aaVN0UUNaSkRsQllT?=
 =?utf-8?B?QzVpWnNhSlZIUlR5MFRjcS8vRktyMXczWHQwWFJKY0RGcEdyUnZTMWJuWndT?=
 =?utf-8?B?Y2xNeXJHa3JEbWNwQXBqN0t4blJEY3pHNWlHdWdQT01JWnV4N05pNjZnN1dq?=
 =?utf-8?B?d09WSU5peCtLanRUTVhFY3JWdEFtL01zcjRBWEJPOWhrRHBFU3VJU0Zhdktk?=
 =?utf-8?B?MW4wQ2xPbEM1NVB6QmxvNGhNQ0s2MmU0L0NSWmJjVmoyWHlENUVmVGdOaG03?=
 =?utf-8?B?R3FoMVppTzVhL1hPQW5vK1J0cTdaK1RwS05yMDgwZlJVeFBYVHg4UFA3ME9x?=
 =?utf-8?B?YWZwc2dMU3Q2ZnAyUGlPa0pscXB0SFB3RDhxaWlqMjVneFI1UEtvN0Q0MFRq?=
 =?utf-8?B?WnhFSEwzaHo5SS93TXRPNnlEa2JWeHZiK2lsQTV0UmRDRjdzRnpQVitneWdO?=
 =?utf-8?B?UzVVZTlsSldiUnZWV0FqbVVCUitjSWpta25MbGtvSFlaUnlyaXd2TDRYV0FX?=
 =?utf-8?B?TXpzbzA5Ty9yL05peW9SMVY2VVEvdm5DS3dQSllWc3c1U1hLVi9ZRWpJbHNN?=
 =?utf-8?B?eFRybzdyL3ZvMzFIa3hEKzA1MlRyUzRSSWRsY0p1Mjk0RW12MkNTUmxlWEJK?=
 =?utf-8?B?aDk3cGxnSjVoRzBYSWpvSkFYSmJuUUwvY3YzWi9HY0Z6UUE2bkl5TkxORWhq?=
 =?utf-8?B?SFNTbW9kL0o2dGRHZ0k4Z0wwVW5SWCtTMDBsek9HNjB6QmU3ejVPNXpZRzU1?=
 =?utf-8?B?czFkWCtlTldYbXc5QXBQb0hxYmdvTGRUWTIzV3d5VjVpVU0wOXB3aFBzZXlo?=
 =?utf-8?B?MlAyUFcxZk4yZlIyNlp0UzkxdUVSOHM2Y3g2M1NqSjZJMzFmZStwbkc5WXcx?=
 =?utf-8?B?RzlldkVESVcrYmNhOWNscHdWUGlzMmFYRDArUm5xNHNMS1dlMEd5cFdXOU84?=
 =?utf-8?B?aXBVYlhFMXpmT291Q0Fqa3FRL2xvQmh1LytOKzc4RXB4Z0R4c0o2R1NHSUxN?=
 =?utf-8?B?aGhNQk12MStZZXp0cTd5ZnFYOWdwcHE5UDRUQjRaRjdMNDJ4ZDVJQUFlRkRO?=
 =?utf-8?B?SGJVemNoMlpoRGxteVc2NVNKU2NaNHhRT1RrOUU1Yng3azVYQXZRYXlIU2Y5?=
 =?utf-8?B?MUJNVEZyYnFjM2x5em85WGlRMjV2clRUUzBpRk9kYlVSUmQ2M3pjL29vZ2Vt?=
 =?utf-8?B?VnpQVkFRMUExOXRyTGRJOWREQU5SYU1wMWEwcVduWnJLYnVBeVdkUUF5UXZi?=
 =?utf-8?B?RUhIdEJRWUZYbUxCUWhMcnJXeW5GOXhHb0hyazNaeTkxVkljY3JXT3lPUmJM?=
 =?utf-8?B?US9QWmRRbFFSenFnQ3VwN2UwRmVYUFNjNDI5MU9YV1NNNlFrYmRSMldwSXh4?=
 =?utf-8?B?MnFFMkFoNDdpSS9lQW41eDhtVTFLOW4yRXlWOExOWHovbmk2Nk5ZbEdlZVd6?=
 =?utf-8?B?Mnc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af9d507-7a77-47e9-7a0d-08de205b7491
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 13:17:10.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtBBhlEUZhQRY7/zfOygX1ybFgnMO7npDrnR/kjNhBx44ZmQyceZ3zkvXsTSHODFTqXTiYBE+2cNtiRJvRmwGN7BJ27Bkkp/QMBCHhMP7e5PYoFU+h3UlBUbSfkdwBvc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9424
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIG5ldDogd2lyZWxlc3M6IGZpeCB1bmluaXRpYWxpemVkIHBv
aW50ZXJzIHdpdGggZnJlZSBhdHRyaWJ1dGUNCg0KUGxlYXNlIHNlbmQgaXdsd2lmaSBwYXRjaGVz
IHRvIGVpdGhlciBpd2x3aWZpLW5leHQgb3IgaXdsd2lmaS1maXhlcyAoW1BBVENIIGl3bHdpZmkt
bmV4dF0gd2lmaTogaXdsd2lmaTogYmxhaCBibGFoICkNCkluIHlvdXIgY2FzZSBpdCBpcyBub3Qg
cmVhbGx5IGZpeGluZyBhbnkgYnVnLCBzaW5jZSB3ZSBuZXZlciByZXR1cm4gZnJvbSB0aGUgZnVu
Y3Rpb25zIHdpdGhvdXQgaW5pdGlhbGl6aW5nIHRoZSBwb2ludGVycy4NCj4gDQo+IFVuaW5pdGlh
bGl6ZWQgcG9pbnRlcnMgd2l0aCBgX19mcmVlYCBhdHRyaWJ1dGUgY2FuIGNhdXNlIHVuZGVmaW5l
ZCBiZWhhdmlvciBhcyB0aGUNCj4gbWVtb3J5IGFzc2lnbmVkIHJhbmRvbWx5IHRvIHRoZSBwb2lu
dGVyIGlzIGZyZWVkIGF1dG9tYXRpY2FsbHkgd2hlbiB0aGUgcG9pbnRlcg0KPiBnb2VzIG91dCBv
ZiBzY29wZS4NCj4gDQo+IEl0IGlzIGJldHRlciB0byBpbml0aWFsaXplIGFuZCBhc3NpZ24gcG9p
bnRlcnMgd2l0aCBgX19mcmVlYCBhdHRyaWJ1dGUgaW4gb25lIHN0YXRlbWVudA0KPiB0byBlbnN1
cmUgcHJvcGVyIHNjb3BlLWJhc2VkIGNsZWFudXANCj4gDQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2Fy
cGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+IENsb3NlczogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL2FQaUdfRjVFQlFValpxc2xAc3RhbmxleS5tb3VudGFpbi8NCj4gU2ln
bmVkLW9mZi1ieTogQWxseSBIZWV2IDxhbGx5aGVldkBnbWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFu
Z2VzIGluIHYyOg0KPiAtIGZpeGVkIHN0eWxlIGlzc3Vlcw0KPiAtIGlnbm9yZSB2MSBvZiB0aGlz
IHBhdGNoDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MTEw
NS1haGVldi11bmluaXRpYWxpemVkLWZyZWUtYXR0ci0NCj4gd2lyZWxlc3MtdjEtMS02Yzg1MGE0
YTk1MmFAZ21haWwuY29tDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9mdy91ZWZpLmMgfCAyICstDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbWxkL2QzLmMgIHwgNCArLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2Z3L3VlZmkuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvZncvdWVmaS5jDQo+IGluZGV4DQo+IDRhZTRkMjE1ZTYzM2UwZDUxMTk0ZDgxOGQ0
NzkzNDllN2M1MDIyMDEuLmMzMWExMTg3ZjUzYTc5YWViMDgzN2YwNjINCj4gNTA0MTBlZWM0ZTdl
YTZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3
L3VlZmkuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L3Vl
ZmkuYw0KPiBAQCAtODE4LDggKzgxOCw4IEBAIGludCBpd2xfdWVmaV9nZXRfZHNicihzdHJ1Y3Qg
aXdsX2Z3X3J1bnRpbWUgKmZ3cnQsIHUzMg0KPiAqdmFsdWUpDQo+IA0KPiAgaW50IGl3bF91ZWZp
X2dldF9waHlfZmlsdGVycyhzdHJ1Y3QgaXdsX2Z3X3J1bnRpbWUgKmZ3cnQpICB7DQo+IC0Jc3Ry
dWN0IHVlZmlfY252X3dwZmNfZGF0YSAqZGF0YSBfX2ZyZWUoa2ZyZWUpOw0KPiAgCXN0cnVjdCBp
d2xfcGh5X3NwZWNpZmljX2NmZyAqZmlsdGVycyA9ICZmd3J0LT5waHlfZmlsdGVyczsNCj4gKwlz
dHJ1Y3QgdWVmaV9jbnZfd3BmY19kYXRhICpkYXRhIF9fZnJlZShrZnJlZSkgPSBOVUxMOw0KPiAN
Cj4gIAlkYXRhID0gaXdsX3VlZmlfZ2V0X3ZlcmlmaWVkX3ZhcmlhYmxlKGZ3cnQtPnRyYW5zLA0K
PiBJV0xfVUVGSV9XUEZDX05BTUUsDQo+ICAJCQkJCSAgICAgICJXUEZDIiwgc2l6ZW9mKCpkYXRh
KSwgTlVMTCk7IGRpZmYgLS0NCj4gZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvZDMuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxk
L2QzLmMNCj4gaW5kZXgNCj4gMWQ0MjgyYTIxZjA5ZTBmOTBhNTJkYzAyYzgyODdlY2MwZTBmYWZl
MS4uZDNhMDM5NDBiMGEyYzZhNGIwMTA3MjY2Y2QNCj4gMmZjMTFlYzk3NDVlNDcgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2QzLmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvZDMuYw0KPiBAQCAtOTk2
LDggKzk5Niw2IEBAIHN0YXRpYyB2b2lkIGl3bF9tbGRfbWxvX3Jla2V5KHN0cnVjdCBpd2xfbWxk
ICptbGQsDQo+ICAJCQkgICAgICBzdHJ1Y3QgaXdsX21sZF93b3dsYW5fc3RhdHVzICp3b3dsYW5f
c3RhdHVzLA0KPiAgCQkJICAgICAgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZikNCj4gIHsNCj4g
LQlzdHJ1Y3QgaXdsX21sZF9vbGRfbWxvX2tleXMgKm9sZF9rZXlzIF9fZnJlZShrZnJlZSkgPSBO
VUxMOw0KDQpUaGlzIHJlbW92ZXMgYW4gdW51c2VkIHZhcmlhYmxlLiBQbGVhc2UgZG8gdGhhdCBp
biBhIHNlcGFyYXRlIHBhdGNoDQo+IC0NCj4gIAlJV0xfREVCVUdfV09XTEFOKG1sZCwgIk51bSBv
ZiBNTE8gS2V5czogJWRcbiIsIHdvd2xhbl9zdGF0dXMtDQo+ID5udW1fbWxvX2tleXMpOw0KPiAN
Cj4gIAlpZiAoIXdvd2xhbl9zdGF0dXMtPm51bV9tbG9fa2V5cykNCj4gQEAgLTE3ODUsNyArMTc4
Myw3IEBAIGl3bF9tbGRfc2VuZF9wcm90b19vZmZsb2FkKHN0cnVjdCBpd2xfbWxkICptbGQsDQo+
ICAJCQkgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KPiAgCQkJICAgdTggYXBfc3RhX2lk
KQ0KPiAgew0KPiAtCXN0cnVjdCBpd2xfcHJvdG9fb2ZmbG9hZF9jbWRfdjQgKmNtZCBfX2ZyZWUo
a2ZyZWUpOw0KPiArCXN0cnVjdCBpd2xfcHJvdG9fb2ZmbG9hZF9jbWRfdjQgKmNtZCBfX2ZyZWUo
a2ZyZWUpID0gTlVMTDsNCj4gIAlzdHJ1Y3QgaXdsX2hvc3RfY21kIGhjbWQgPSB7DQo+ICAJCS5p
ZCA9IFBST1RfT0ZGTE9BRF9DT05GSUdfQ01ELA0KPiAgCQkuZGF0YWZsYWdzWzBdID0gSVdMX0hD
TURfREZMX05PQ09QWSwNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogYzljZmMxMjJmMDM3MTFh
NTEyNGI0YWFmYWIzMjExY2Y0ZDM1YTJhYw0KPiBjaGFuZ2UtaWQ6IDIwMjUxMTA1LWFoZWV2LXVu
aW5pdGlhbGl6ZWQtZnJlZS1hdHRyLXdpcmVsZXNzLWJkZTc2NGZiZTgxYw0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiAtLQ0KPiBBbGx5IEhlZXYgPGFsbHloZWV2QGdtYWlsLmNvbT4NCg0K

