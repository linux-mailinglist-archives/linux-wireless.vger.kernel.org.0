Return-Path: <linux-wireless+bounces-27177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115EB4AB01
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC16716BB34
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7374731C571;
	Tue,  9 Sep 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RM4a9bNi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5067317709
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415499; cv=fail; b=j11u/I1Ra8PFqcv96B0t+i3OAaffEGqowP7SX2PhPgvXZIfRiY0oL0gH1bSCm0XXXkXCcWgOUcFLTL1NXAE985qav7En+KK0qGG9hCvKLTSHyWofIlsN0hQt9OY9fcpbjHuURYXeqMRLQUohO/jSWCrDAs0eOUJ99SY/Aaa6aOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415499; c=relaxed/simple;
	bh=nApOXB239z5LgB/2Y824fMc0Wp8e956UVsQfX4kmHD8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=myhv0Vi08a5/h6+QvqFR7WdLahOer27nqCDEcvBod4I+1GpEPQczF7oUoxVHdw7N9IUXkbJS5ZfBCKaITPBnsm0e14SdgC9R9GJJA9n+k40v+pIqcw315TZcYBAq9DnRRioc/UfKbXukoj/0hxHQnCWnRRVfyD3KCAeWn1OPJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RM4a9bNi; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757415497; x=1788951497;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nApOXB239z5LgB/2Y824fMc0Wp8e956UVsQfX4kmHD8=;
  b=RM4a9bNirOIj2Z5mJu3G67nDDeAyG8JWHWha0VoNP5YEWou++lEKF9ey
   RLFPjE6scFahfgw8u62eWm5UCqRPKglEL9z1/J4RwbCnrzrzxz4etLR5c
   9zUWGZMMmcQA23gr+Xfv1XNTPtEcS4Lla6yi0uhqt+9WNxovAxIRoWRKX
   R6CIX6RwCiL+jvYTPIVtufpaUKjekX88Ys9Zu1fJcVyxFSTK+DxI78iaO
   dPFl8d6a5zDw7dnhfHNs/bAOTto1cRWCC+Atg5L6JpUT5W+SYzceMOKTU
   rD3nzHZ51f2vTlzKcFfy5yDA+HsCZIDnhzrz7yYqRxKo3wzXcV8K3+8DT
   g==;
X-CSE-ConnectionGUID: zROaH5uUShG1sTq3lW7xZw==
X-CSE-MsgGUID: Y4ZXh6jtRsyl/b+sR6IVnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59390210"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="59390210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 03:58:17 -0700
X-CSE-ConnectionGUID: EjbdMvNsTAyRCZYtbKcinA==
X-CSE-MsgGUID: D8eSg0JYRumrugyvfO6KeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="210209777"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 03:58:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 03:58:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 03:58:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.84) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 03:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjgFtjJT/JoGP+9fyDr/r0jkEiBfAOKjf7v4HdjV3rPz6IQBSSogLSjoh/sOCDgdeMVvo8g24V4aJyIe9C2VTvcHXbw0nkGr0SlwAUKKN8kZN8rHnXebNFk4N9RvJIHBvECVXPZ0nXgmnqavS02KNi/QYyILHz96GHrp7aZhV9eEAA/p9llnVbf0Jq+KYaqZGxvgLqCOLNmzWBV0/zCYMeBGcyeSwF0wXC2Imw3DHiUvcdCmYVKYL/EXQ4uU02GIRPmBBP7b3c3zG5p26BgMzgEj12xsiLx5iYbVj0k3pGOnNmR7WIh9zkhue+ym9s+Uw6IDNikAqIgatFZW12lMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nApOXB239z5LgB/2Y824fMc0Wp8e956UVsQfX4kmHD8=;
 b=igQvUm/hbDMbwzrmy7ePpOjmnlkMCD1EAEV4HvMnngMq+HY/O5VR1wUzXkc+HEopouKcwOIPdvL6nUbsHXYCPDyjZQBGB0+d4/o0wIj33OWFRV5eoG2X68jXiw5wv2l4uSfD+UusV8gS3UZR60kua7pAWIaqVUEeBIcxr2tu9v391SnJYGDZ1IuEoAVsSWwg/6ApW5S3J2UXZ5Z0XKwIJ4Q4tEr/yevPMqoprNYfWFX7FkQL+KWAC38WGjG9m5AcM+iuuFvC1bSC1OnksMD4gRL0+C4FxuirbPRkKiXnKUG9wBB2bT8HIZJASVAXFf6B/dNvuy+iimasaMGmL/ovGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CH3PR11MB7324.namprd11.prod.outlook.com
 (2603:10b6:610:14f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:58:14 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:58:14 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Berg, Johannes" <johannes.berg@intel.com>, Linux Wireless
	<linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-fixes-2025-09-09
Thread-Topic: pull-request: iwlwifi-fixes-2025-09-09
Thread-Index: AdwheKIX8Jt3cE1vTkKfBFHv17QoAw==
Date: Tue, 9 Sep 2025 10:58:14 +0000
Message-ID: <DM3PPF63A6024A9E286CB9A1A92DA18D5E5A30FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|CH3PR11MB7324:EE_
x-ms-office365-filtering-correlation-id: 9e542e46-3e56-4d4d-ab55-08ddef8fc65b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eTN6MEl6dk1ETHhaK3E1Zk1EbDJDWUpvNEN6YjlMSk1iaUdlNExEUkE1WDBa?=
 =?utf-8?B?a0VqTWJCZXNNMUpqOER2SzRSZ2QrazU5MFJMWWM2cE9PK2FwS242WVZkMmZ1?=
 =?utf-8?B?Ky9SNXdmQTE3L1cxR2o5OUp2bWk0NHFhNGxDUTFlU0VKeGdnbnpZNTViWFpU?=
 =?utf-8?B?MkUwWXgzUEhraTFJR3pORng5a1IzWG4vMlA0RUJIaTUrVzFRWFBEL2RKMkJx?=
 =?utf-8?B?Q29jL1ZmTE1uNURPOEdHTXVlWXArenNSQUpiN3ZidlVGdUJQUXVMclJIc3Vi?=
 =?utf-8?B?amF1NnFDb3VvTEsya1M0c3A5eEtodXpEWFBaa2JxeXNmL3psU0V0YWZEUlI1?=
 =?utf-8?B?dDNzOHB5UVRrV0s5NFc5d0pNajFvMEd1bWpCVmpPZlJBcDZRbjFMTVkreURo?=
 =?utf-8?B?QjVyV2x2RFYvZHlmSEdxL3VON0Z6Nmo0V1VkbjZXci91VEFwdU84TmxzOUl5?=
 =?utf-8?B?ZnUvVUIwaUxVVE1JNWp3NnRrWHFiekx6QzVqMHZWVGVNWVNGaFJXMm52L0pW?=
 =?utf-8?B?d1dIclFzeUo0NnlmN0ZnMFlBT2ZBdVMyS1I5TUJZcWR2SnBZcHBkdW10a0VZ?=
 =?utf-8?B?RkUySE5OeEZJU2taK3IxcFErWTdPZHJFdTlLMThmQm81dDRzUFBoWEFnQ0tT?=
 =?utf-8?B?RlFpd0dLK3VWYk40eFlOOElEeWZxRFJsbW1kNnZGUVo2ZVV3NStKTGZjRHh0?=
 =?utf-8?B?Sm93MUhYN1dBbUI5RGx4aXdMRTNOUG9WNEdPdzAxUGZHaFB3dFkyVEo5WFQz?=
 =?utf-8?B?MS9PMytXU1Fta3gxUVJMMmJwb0hTc3RoL3YwcjJMc3RnOVpjeS9DRWlueU9h?=
 =?utf-8?B?Smg1WXJrRS9jUEVDM0tadnp1U2crUTBGTzA3aTBJR2g5VENSZU0xVndEMVU1?=
 =?utf-8?B?aktJV2poOUhXdk51ajAxbHQyQVY0UCtqZ2ZwaDQxbHZMUVJIMlJ3NGtENjdt?=
 =?utf-8?B?WW5QNmxnbUk3SFViUC9zRDlBL2V1eHlrOHc2cmRwcWZxMUNKQzV3aEpSb3Yx?=
 =?utf-8?B?dkQ0N1NSUXhnV1Nqa2MzYk1vTnoxcFFSdTFmVDVkNy92UkdBbDBnV1h1OXBo?=
 =?utf-8?B?R0QzY05kNXpncE41THZBTnV2Uk5YSE5QMFlYNjFGRXhmcXl6U0YvNi8wWWV6?=
 =?utf-8?B?SmtEU2NsNm82RGU3OWZNT0RIV3NPRU93dWZjNTFLMno4K1pDRXBpODIwdEFa?=
 =?utf-8?B?clNwaGVLQlp0Q2c1N2tDNTNybHQ0ZTIvejF4T2NSOFQyRExMaUlkeUZGNnBr?=
 =?utf-8?B?Ykt2Tk9FUWVtbHMvQjh5TUZubnZVVTdBc2ZIR2ZJYy81bGhiWnlubmhjQ0lC?=
 =?utf-8?B?Z25IK2wrd1ZkS3FSbmtwTnZDMDJxbGRnVUQ3SzdoT2JyVy8zMzNGeXFvdFFK?=
 =?utf-8?B?Z2RCSzNhQTRiaFlOUGRJRGRTbUxpS0ZLaE5YTTladmV0RWlrYjg5OGhOcXcx?=
 =?utf-8?B?RVFIeklZajBBQndkRFQ3S2tpdXlUZTlVdnNiVEx6TDk2b2VJcFJmMmsyTkFY?=
 =?utf-8?B?VWdyOFZQd01DZ2hJdlBIRXBHUmRDckpSbFVTbFBNTkdiVWRRZTRreTcxTzlV?=
 =?utf-8?B?b21RWlAwSnVhRTlEeTFQRXROTkthWEpoQnlZUThSZEQ1RDdDSEZqMFMwa1ZE?=
 =?utf-8?B?N1Z1MnM3SFdISERlUFlOOFRYY0krdUpZM2hjTjJ2dFBUTXdzdnpWYStHenJR?=
 =?utf-8?B?QjVCM0pWbmYyNS9BMkg2TWc1UUZiQUpkbW02S3luV2huTUx6Smw4SkNDMXRE?=
 =?utf-8?B?UTE1RkNXaFVUVHFpaldGZHdaK3Z5VlZjS204TlR2WjJIVFhDOVZNaDhOb0JU?=
 =?utf-8?B?dW1iYTJTVjF5bE4xYnRRNEU0U1FrdFgxSzhveDVNVzdjQ1VTempnYkRoNE44?=
 =?utf-8?B?TEUxM2pWY0NlQzkxSEt1WUxPQ1VTV0dmRkZKTzhvekd4aGJ3djhLdkFDbHBJ?=
 =?utf-8?B?Vm9zQkh6d0FiT0dHTmV2aEkwSU5LK2Y1bmtXTk1OMElyN0MxQWdnSWRKUDJr?=
 =?utf-8?Q?w3G7yqIFnmzX5aLNtbWxZiEpRu351E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjlvdnMwalNhVDh4TmtUME10TmVHN09oSjZZUFU0VENMMVFkTHE3YUM3cUJy?=
 =?utf-8?B?TktkQmhxNHMvN3VoOUdLMlAvcjFGV1dXRFFkRGNrelkvcmJXRWcrT3F1UDRa?=
 =?utf-8?B?dEs1d3pGU2ZOUVFjZjZaUW84U0FTNFBjOUpTak9HcHBSaWhQNWhnR2Job2o3?=
 =?utf-8?B?akJqWjFsdHBaRXptZEcrajdMeE15QUZhMEJxZHIxVWNCbjRjVVczRGlGRkZX?=
 =?utf-8?B?UkVXSkppaTdGamJGSTloUWVGcGpObGwvZUNOOTFrdzNLdnA4QVJlVXpyTlgv?=
 =?utf-8?B?cVdHNi9DY0ltdkEwUlBSell5R2JHaFAxTFBJNUE1Q3BqV01qaG04djJlbjk4?=
 =?utf-8?B?QnVCQVg1c0RXWXF3NFlPQTNua1cvSDNJbUR0KzJiYU9KMkhBRHdtWkZlcW1P?=
 =?utf-8?B?ckRpZmErVkltQzAzcGFsdHdsRDdsWHlQWXdNM014S05ZWnlPaHR3WGdmYzdy?=
 =?utf-8?B?clhBNVo4L1owVDNOSGYyOW1HZHliL2JwdGtESk9EOE16ZlplNTNoSFhrbFF4?=
 =?utf-8?B?aVdJZGdOcDlBSGdEWjcweXRVZUUvSkN1NC9CbXJ4SFcwaEN2S2NNNHU2SEgr?=
 =?utf-8?B?REp4bTdYem9EUk9YUVp6dUl5RktzbkgzdWl6cFF5TndLRDJKYjVXVTFDYnhw?=
 =?utf-8?B?ODdGdEZtTDhUR1NMeTZGQ28xUElFSXJKRHBoaEtVcUJhNnVGS0w2eUgxVFM0?=
 =?utf-8?B?ZTBpajlxbG9vUEZmSzZDSDhETjMyZnBpcEx4ZFd6TEV1L0lLRFFOd0lRbVFJ?=
 =?utf-8?B?SFVWalJ5dUg1ZG0rSG1mVkxOZUtPRmU3YmtIZitRRk40cE9sU1lsWDFkNlB6?=
 =?utf-8?B?end0bHcrOGdUWkFDZ2FQSnpzWFR4L20wckM0UXg2VFgwckR6ZUF1UFo3aFN6?=
 =?utf-8?B?YnZ2bFAzWjBDcjdaTEc4VVUyOCtWL2ZoZXpWbGc2TFBuTHBiRTRuYndSbmor?=
 =?utf-8?B?alBTNU5jWS9NMzNON3Y1QTNyY3RJVWdWNGJSVHBNNzR6TlRiQlRDeVZ1VCtC?=
 =?utf-8?B?VkxzaFRWcHhzb0Z2dFYzeHdaQlZBRW1CdE5HVlpjaSt3QW5udlR4RVQxMkh3?=
 =?utf-8?B?dXNWejJZK3hwWEtvOCtCSDAzeENYbThwTkhPeCtpRCsrNk10UWRvNW9CZWw3?=
 =?utf-8?B?Umt2TTNNWmFjSytVVVdVQUJscnpMZ3BiK09LemxCU3Y1NGdIeEJNM0xTQTF3?=
 =?utf-8?B?Ym45ZXVGMjlGeENRaUNjY2ZKMS93Ny82eVh3VjQ3Z0tGZE9hMFNZQmQzL0l0?=
 =?utf-8?B?VDZXMmE0K0luNXM0ZGQ1VE5DaDhNYTV1YUx4c0VTb0diYzczZkJwdmRObldx?=
 =?utf-8?B?aTJtRldXTUZiL1BTaFhhcUt6aDhxYSs4enBpY0dlU1Z6SUtMUDAxZ2djY2Iy?=
 =?utf-8?B?LzkrQUNISzQxRy82Y0U4c1NSU29vNC9YZGFwQ3ZxZHViRTRqSkRTYlF4a3Z1?=
 =?utf-8?B?ZlZUSFNqQUVta09saGdYWTFZRTYxT3l0NXNpVG10NlJpdzM2MmlKZXAyeXpE?=
 =?utf-8?B?aDdPVHd0YVBpSnZHbTY4MjIxSFVPMzdiS0c2aFVRMjN3Q3NFRVkvUlRlUGRM?=
 =?utf-8?B?ekp3dTl1cUY5RDQvMW5WMUFwSU8zRm5BUG9ZMWtOYVVJVjhCUnVlVEtxYUU4?=
 =?utf-8?B?Z3QzMzNpbGNkU0RobERvb05vRnZncFFFRXRvcGc0WHBMZytHMklyWEhQemN4?=
 =?utf-8?B?MEpvZFJwMTVaaGRZMk9HcytQYnhGT3pCbDhncWFLZXFiWWFia1FST05mNEF4?=
 =?utf-8?B?N3ZWM3Vudk5RR0VtaEJuNHU5OE9HNjJmRWJ1SHdQUnIxM3ZrdXpGY2J1ZGhT?=
 =?utf-8?B?S2lsQlRHTncrQ2daNjVpZnA3cFN2ZEZZSmVKN3hjU09lcVU1Y0IweXFRWVQ5?=
 =?utf-8?B?ZVJhSEdFc1ArVWRqRTJaVHI3QnFoUXR0Vm9Kd3VKZS9uSkV3NTlyOE1CMW9K?=
 =?utf-8?B?VlNTYTZBYkJvVVZqV0FRVlAzMjVidHRSYzBuOW1sT1RHZ0lkSTl2TWNNRXRN?=
 =?utf-8?B?a2NjT1RuSERkQnYyNlByd2ErTWlVd3ZFMzd1WFlaeXhpTWQ2UUZHL2E1NklL?=
 =?utf-8?B?aHQ1WVNqQklnWEduaitoY2Q5RG5wcVQ3Y0NZWEQwc3cwdkxuTlU2aEZxZGtY?=
 =?utf-8?B?NkwzU1diVVZTNnA2YzVBS252RDdlRTlCTzdscG9MdXA3eWVSdlVPVFI0dnZQ?=
 =?utf-8?Q?BVy9g10M8rc23tBrfTbN/ns=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e542e46-3e56-4d4d-ab55-08ddef8fc65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 10:58:14.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJrkGZiisjYAiGG3gui1f4rXiv+N76EFhINCZCwBpqZP+JBt3hHfSX/tKcJFPUBIOftkeTEtJ7SgBM1xiaAIcYjqSkdYVKcJeJzW6AG9zpsdgyK6fcbwfQj/CSV3SaCe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkNjllYjIwNGMyNTVjMzVhYmQ5ZThj
YjYyMTQ4NGU4MDc0Yzc1ZWFhOg0KDQogIE1lcmdlIHRhZyAnbmV0LTYuMTctcmM1JyBvZiBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldCAoMjAy
NS0wOS0wNCAwOTo1OToxNSAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdzL2l3bHdpZmktZml4ZXMtMjAyNS0w
OS0wOQ0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMjY4MmU3YTMxNzUwNGE5ZDgx
Y2JiMzk3MjQ5ZDQyOTllODRkZmFkZDoNCg0KICB3aWZpOiBpd2x3aWZpOiBmaXggMTMwLzEwMzAg
Y29uZmlncyAoMjAyNS0wOS0wOSAxMzo1NDoyNiArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaSBm
aXgNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KSm9oYW5uZXMgQmVyZyAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBm
aXggMTMwLzEwMzAgY29uZmlncw0KDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9wY2llL2Rydi5jIHwgMjYgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo=

