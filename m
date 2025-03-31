Return-Path: <linux-wireless+bounces-20998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E4A76418
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFCC3A5B57
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A91DF27D;
	Mon, 31 Mar 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdfWL/yA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B342049;
	Mon, 31 Mar 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416709; cv=fail; b=CPCgeRAu8I2/jR5isy8jkZshPRlvOZ0cHmieDVDKmkyDsIY1LtBuhfEpo6T7qfr8lhHytVLfih4YGbcqunYJs6Mqm38sI+Y/dWfUfiubXztQibaxKpfWZVhu9wgjbPhR3+anDZkHp5se8sgD3R4pikIv1g5H+RmsO+BP158LJy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416709; c=relaxed/simple;
	bh=K0eaHGfHrM8per3W5cZQRB9h4oKR739PamQif5+HNJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppcGE3QR5WYZxK5XL6VYqIT6a9NgHhDa80p0rgl/JMtD6XqhlZsganOtPdSGFHbowiGFm7YBR8ct5sOccjyBMlkRUzYkQs8JDYHtu9N/9sPMpFH6RUmUI5yUzwi4q2A1YXHWW0QEJJ/36YKDRabxU/iGfXJdKzHu3VyVVh6avY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdfWL/yA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743416708; x=1774952708;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K0eaHGfHrM8per3W5cZQRB9h4oKR739PamQif5+HNJA=;
  b=BdfWL/yASdNGvZi/GqnzLyoJa94Eez25HPXTqkGObHmQJgTtqaRrz5Gh
   BcHT0xR3KHrkykjq/tJuvv1v5JwUPo0X+86RVqm2bkyPljJ4yRZH17aOo
   YVfrVS/7fjhAREUZBzpaE54TDN3ChULMBL42/aeRxV0eoOJS7H6YF+5WF
   G13XxSSZjrEciM7K31O7DKSRbynRGKXoOTJ1x2jl9lEo3zx7lEZKc1/7p
   p4w2vx8mBb4LDHZ03qgdONdiXsUPGqT4hLxTE/so3T1qae0KkgDmLuqZz
   H1ElI8Q+wfSzUn1jeEZgT8L9trvJfI5EsX2EgE4rvdZ58KhBXiCM52DVa
   g==;
X-CSE-ConnectionGUID: dZ7qlWoMS0+ajYiNxu4MKA==
X-CSE-MsgGUID: ncvHYIrvR1KxfxS8RhpPyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="48571019"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="48571019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:25:07 -0700
X-CSE-ConnectionGUID: jQFU1BSTT62sCzBwONSZZQ==
X-CSE-MsgGUID: fJ1Qbj4MQti5m9DoJZeJeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="125812434"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 03:25:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 03:25:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 03:25:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 03:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ058kuLY7xbpWErIqPI/SLQnqpCOmlya4xlMiLKLtYgiVuWVOZMMTmRPKiSYwCg2lCmXcplWgVHmeHKOYEKJRqrzR4GGU5HncHc5MrEHXPvRVIyr3GsMu7LkgNpszypdQTw60RONFLRMd28qO1nj9CNMTrjRF5F8aOWz6+BZP89Wc6hxQzPEXzz0ZIzIMkxQ8i+h1X4P+i8l/mSvBmncsaZEZI6J/RxKolG7xdYnPG4dJPD2NVTsPn0Oe4f/h7tD6n5xV2mOuLKcE8W/qztO4dHAmNbofwCAjNjxotJN6op7EHazSDPwFN+eRaV2KbLq7xSJoYg+7tCsRq3dHQa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0eaHGfHrM8per3W5cZQRB9h4oKR739PamQif5+HNJA=;
 b=NEbGvkdSdPS63T2UvF+VWm55kSQ9Wcjd37cDoSVd+UijwdVfgUz44mJXnfReWNnfCyvTT7YL2PqWz4SC5fUg/hCj3kjPuhJ5eyTxStkfxl97uwecSrPW0UsqHIv34U9jRQLenb6yTUDeTdjFeJCAzYtKRqMQsdAjdtNg7jwSHaBk2yTSKWtXqY7n3V6lLPpavEiYCXGEPkzCE2g/Mq/a90252dHO4xhAVhJT+zDJbtRrUAHvnIdSwk/u2gU18OkNawz7IxJErSDZqwRFSk9zEgkto3rnA/EA0iXBi7dZojEUtmb03E4bzIz4fHgZy1CKHKHZS9+6e57/rFKUU+8JAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:25:04 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 10:25:03 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Berg, Benjamin"
	<benjamin.berg@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: iwlwifi: mld: silence uninitialized variable
 warning
Thread-Topic: [PATCH next] wifi: iwlwifi: mld: silence uninitialized variable
 warning
Thread-Index: AQHbmm6cHvhF4i1dQE6HqN4sn5hk7rONGW6Q
Date: Mon, 31 Mar 2025 10:25:03 +0000
Message-ID: <MW5PR11MB5810DF9944097F37229CCA6EA3AD2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <add9c9e2-3b44-4e0a-a4aa-7326f6425baf@stanley.mountain>
In-Reply-To: <add9c9e2-3b44-4e0a-a4aa-7326f6425baf@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|DM4PR11MB8180:EE_
x-ms-office365-filtering-correlation-id: e0c7d907-2ae4-4285-a591-08dd703e4d0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?akFrS3ZzTVl5QzFpWXlJZ2djOC9BM0ppdUNTRlpIS1N6VTVzTTRYOHJpczRW?=
 =?utf-8?B?YjVWVDM5VlE3N1pqL0w2dmZDM01RdU5rZ0pJK2dHVEdiSWZYTStWTXAzaTJ6?=
 =?utf-8?B?LzA3ZUhBb0ZRMGNqUDZENFpwWElHR3VWTm1uT1BzZllFZXdjSlNDZkN2K1oy?=
 =?utf-8?B?OFNjemRGcENibFlISVdRb095ZXFCbUJnaG9RenlIUFNpRHlod3Q5Q1RHY3E0?=
 =?utf-8?B?R044Tnp5czBXMURwdklLeHNubysxelRxbmZoaDNyRE5pRm1xaHNCcVRRRlpW?=
 =?utf-8?B?Zm9JZUpOR3E3cEVuK0dsNFRwRjVpREY3TEgwZEdFMy9SQVV2RU4wOHpnVXlw?=
 =?utf-8?B?ZmNCVjMrL0RHbThXT2JVWExDYmdkUW9WczQ0MWYxWXM0WHBQanZZNWVyRGxD?=
 =?utf-8?B?NmZJOCt0Q04vS1dtV0VqQjhaSk1CWTl0SmxTTjFVNVU4Tnppd0d1VDQ0cE1C?=
 =?utf-8?B?d2kyNXZvazVMdFA3SURtdlhmcU9NRENBZUxUUjQ2YktQOG1wL2ZpUE1HOEZS?=
 =?utf-8?B?K1BrQ0tUUEFGeE9tUlZBOHV3RFd5d2ZETU5QbHo4VWFya1dtL3F4azgxTlpQ?=
 =?utf-8?B?aEV2RTVkelZGdzMyWUlRYnRORktiU3dyT1lGMjhab1RSZFUvY0Y3cjdMRVMv?=
 =?utf-8?B?U2IvMzliVXQyQ1AwSnJxVUlFandETVIwT0FkZTBxL3d1bTA3QUEwYjFvbExS?=
 =?utf-8?B?Q1E4SEhFY1pBOEpXUGNJOGtNeVlKbEgwTmZXWk43c2x4V1l1aDUvMmlHQ1NM?=
 =?utf-8?B?bWRYYTlHMGl6bE15ZFRFTCt5NnZscWdsdCs2ekU3RGJVcWxZTjhEcExiN0pl?=
 =?utf-8?B?V2NsbzJMSzJHU2JFWER5SVlvcVp2aTRBMGhHNEdGOUJrbmtUYmQ5R09Td2dV?=
 =?utf-8?B?d0dlaGtTQ2h5VDFsdzFpT3F6dmt5WTZYczhFQjIrc2N3aktsUGs4dXN0UlVD?=
 =?utf-8?B?RnZjc042MXBsREZiZXdFZ1dOSm1uZy83ck1Sb1pDREF1TUVQSkFCaVVvcVBL?=
 =?utf-8?B?dnIyNi82TU1sNmVkMlJlZXhFL3gwUjArOTBWVkl0V04vMFVlQUpYaG9nWTJm?=
 =?utf-8?B?RHl6ckJjZ1lKa1ZlMUMzSE94bEROSmRhMjBkYytSNzh3bkVQNnQ1NENpU3Fw?=
 =?utf-8?B?ZzBSODdPRERkci9WY1U3OWMzV2pKaHNSajNNQlRXcTcvVXQwVG9RMFV1QmZG?=
 =?utf-8?B?TjV6ZVBrbTQ1YWJRY2RDdExKZkhGSTE1UG1tNGpJRUg5d3kwVkN6amh5cmxV?=
 =?utf-8?B?bEMwMm5mcW9xdFJUV2E2T0xYaFNvMUYzOGJldTBMcGdDeDNJODA1cHYrZllB?=
 =?utf-8?B?dVB2eFdXZzBiL0JMY0RSbVA2d09jRG13SFg4UHliZWtlbVJVMGM0NDF6TlN6?=
 =?utf-8?B?Q1MxVVVmZWJjbFJMc1U4YnFvdHNBY2pkUFdzOWwxSGV4NzcrQ1R3TURZRDlG?=
 =?utf-8?B?d0p6MlFCTlZHMkhwcTFBU1JEbjZxc0lBR1ZCcWJFczd4NkpWbkNMVGxLOTRs?=
 =?utf-8?B?SkpSUGY1aVZqaC9zM2ZOZ0JtcUVrdXRweWZ1NHhTWERYN2ZHUWcybjNpdTBH?=
 =?utf-8?B?eDRBZnpKUi96d0pmVDhUTEVNYVc2WitiaGRzQzhJcEN2S09jY1ZmVUpnRTBY?=
 =?utf-8?B?RjlYYnQwaDJmc2x6L0kyUURBdGtLdS8yUDdWWVdLZ1RYeW9JVWtEQVduZ2pK?=
 =?utf-8?B?bFJiU1YxckRVQm1nb1k0MC9EZFlOZWFRR1pMTjY3cTRXWFRidGdkNEc5alZn?=
 =?utf-8?B?dENjdjhKM3VKZjdyUnhBVWFONWFvR0lqd2lkck5UeldMYlFMVVRIdFd6b1FJ?=
 =?utf-8?B?ak90bjV1YkU5aUwrZkdPTVpJWW1MNlV6QUdPZjFnWkplM1YrZW9mdjlETjl0?=
 =?utf-8?B?bUNaVkNQbGM3YTZQUXlrb3JKNUdhMkNyWEIvVG9oNTcvU2lyR2ZYZFRybjNK?=
 =?utf-8?B?cWhWc1REaDNFS2s2Zzh3WEd1Y0dGakNCNFRaaDNkQlpsR1cwUW1VTmphUzhJ?=
 =?utf-8?Q?8o4O4NnRu45kz6PeVgv2hfRltzPrlU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFFwOGZNdGRaNmpUYWhVVUZVelJsQzJuUmI0cVZ1eG0rVFpsaFk3RGpiV21E?=
 =?utf-8?B?Zk5TSEppZkFkUEkwNlh3TmRwRC9uNDFONVJPRHhEc1l3TXAzYk1xUm1hbzBz?=
 =?utf-8?B?QmJCNTRDU0xlcjlTWmVYVk1NRnFMYVpKWWFJMU9LeGVDOHlLR3g2SGVlbFdv?=
 =?utf-8?B?NHBtTHJnUXdUZlE0KzJoTXVQRDVXNC9yYyt2NklrSVRmR05ZR1lVZ0ZtT2VC?=
 =?utf-8?B?dEp0YzEyREJxY0Y2ek0rL3hkREhFMmMzWjYxbWZkcGRKNWdKckt6N3RrNmF3?=
 =?utf-8?B?N3FNYmlJVWtjbHVhcm1HZ2FTVncxYVR4a1JzL1FyK2VYSWIzREFsUVN3L2FI?=
 =?utf-8?B?T0NWMUlkUC9aZFlEZnBhQXpJRFd0U3huNUp2VytPc1F1K2JMS3VwU0hPd2pm?=
 =?utf-8?B?ZUU3czZtL29tWVpnNTdOcjN2UUlsRkVwSDhzN3A2R2IxT0p2MWI1MmVGWkhu?=
 =?utf-8?B?Z1grcktHTkxDNVJhWnNwMWtHRW00TWVwR2c3alV5NmtUcnNXS2pjbFpvNmhI?=
 =?utf-8?B?TitTM2dxWmpvUWcveEFRZUFFUHlrL1ZseDdsaWZ1aEVvSm1ybmJpS0FkUjRW?=
 =?utf-8?B?b2NPc1hoTjZldE9FSEtSNHZsWTJWVGxpU3lhVmVvRWF6L3Btb09TSSsvcmtm?=
 =?utf-8?B?Qm55c3NVQWFoaVZ6c3ZHTExsa0ZlNlJ5d3hUSkxFcytXVi9TWUVDaHg0THFq?=
 =?utf-8?B?VUdsWW5ubnlzUnhiKzdBRTJCR1ZRZGFEaUh0QnhDdHFFQ1FtUnpiZFRoalIv?=
 =?utf-8?B?UVRyK2RnSkIzZkp2RlJBMjc2TmE2aG9hYlJGL2RHZjJmVmxxMmx5N2hTR1dv?=
 =?utf-8?B?b1I5b2VlanpnMGpPQWhwVTc4bWt3VlFVOTYzblptaWpROXZsK2FLVENheG9y?=
 =?utf-8?B?SmV1V1U0TUp6K045NTFReU1PazRmWmUzRG9ZY3l2eFZXUkl2VW9XNWg5VGNj?=
 =?utf-8?B?aHBLSUxvaktkT2tsd0ZhWU0xUjlUUzZQVW1nT2paVTBuZElmUjUzK3VjRUZM?=
 =?utf-8?B?ZEtxdkUzTnFqZVJIbDVocmxYY1pJUTBVQ2Ewc05KeDYyTGg2TXhxYmVZUC84?=
 =?utf-8?B?QW5lRGVjTEx2WC9EeU5UUklRSnpYZ1BxTExnY2hLSWR2Q21mYW8wNzlsU2hm?=
 =?utf-8?B?TFdIUkQ1Z2l4dmI3RGpBWVBnQytQQWljTEZKOC96MHdPaGJuZVphcCtFQTRo?=
 =?utf-8?B?UUtzUXdhc3liZmVFaTY4TGphWS96ajcxQ1pCKzM1eWg4ODlqbmlSTSt4a1RY?=
 =?utf-8?B?bm8rK0wvUVBFZGdkQllNVnY5blp0M2xaVWtnSHJOcGh3VVdJYUkyN1cvZXZy?=
 =?utf-8?B?ZnNReHJ3V2QrUGJ0bmlVeFIvckFZUUlBRkNtVHJWSDRXeWc1TlJtTXBuUWN0?=
 =?utf-8?B?MXlKU2R6R2ZLWERobjMzcFZVWXZNeXVSNFAxSUpydEw3L0JyUUJUU3ZGdnla?=
 =?utf-8?B?QWNBdGtaTUFycmpMY3ZxT3NGQUVibFlUdXZLZGVYaTA3bWphekFtd3RlVmJU?=
 =?utf-8?B?N2xuSEdTQVVjeXRoTnlSc0RBTE9FaGQvUCtxUkZKOHJWeDdLWnlUc1htd0Zo?=
 =?utf-8?B?Sk9jR1BBcGsybTdNSWJOWlJaYitDQmFwVFFsVm5ML05aQlVyTExRNjlMc083?=
 =?utf-8?B?emJNQ3ZVWWNLSUdDUzlNMFJtemg0c3p1QStyTU1tVktoNWRuRkhxbHF1NFVh?=
 =?utf-8?B?cnhmMHhLNGVqdzQrbmlFcVQ5TGxHakc1RzVXZmZWTDVkK1pucVZUUjdRUGs1?=
 =?utf-8?B?TW84T1dPRjl2dGRTbzBsNzB0UmZLRWh3YmRjTU5KUXdaNUdaZkNSdnlPUnVJ?=
 =?utf-8?B?N29iakQxZklabWZRc2dnQlFUSFZ5TGRqTlRvb3MwaG5zS1k3SlF6azNYNGRv?=
 =?utf-8?B?c3A2M3c3RUxqOXVBdnVNTm9mdnlXOFlWZks4cFc0VHQya01wbldNUGVCTUI2?=
 =?utf-8?B?RVVmNVkwbXV6ZFZPeDdPcmhINUJYWjNoMU5talQydXR5NzMzOGgzQWNWVFFi?=
 =?utf-8?B?cTRIVlZPcDEveURCekt6b0FEcVdBaForSENQNXM0K3EwdC9ZYjBQOWZlMFJU?=
 =?utf-8?B?bkdaTVZ4aE1uRjlnS0ZJZnA2MGhxajdLL1dzZktXQjAraVEvb3A0aUZJbkM1?=
 =?utf-8?B?dFY5SUVrcy9PWWxuSDh5UHhVT283VVpyOXlSZnRPMzlvQUE2eHU2QnhpZGlq?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c7d907-2ae4-4285-a591-08dd703e4d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 10:25:03.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/Z1cmMwp0sedosU9QZ3AGc1nedJc/YkLS9LUwqRPCs7lbU0rpOUmSfSb+Yr/KOTmrENTAZJO5LqgZagIR5DbHqdEGsB/Gmi4oHZBWFXxQskPszjHqOyL8zn5oRLYWVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIDIxIE1hcmNoIDIwMjUg
MTY6MzYNCj4gVG86IEFuamFuZXl1bHUsIFBhZ2FkYWxhIFllc3UgPHBhZ2FkYWxhLnllc3UuYW5q
YW5leXVsdUBpbnRlbC5jb20+DQo+IENjOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlh
bS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IEJlcmcsDQo+IEpvaGFubmVzIDxqb2hhbm5l
cy5iZXJnQGludGVsLmNvbT47IEJlcmcsIEJlbmphbWluDQo+IDxiZW5qYW1pbi5iZXJnQGludGVs
LmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW1BBVENIIG5leHRdIHdpZmk6IGl3bHdpZmk6IG1sZDogc2lsZW5jZSB1bmluaXRpYWxpemVk
IHZhcmlhYmxlIHdhcm5pbmcNCj4gDQo+IFRoZSAicmVzcF9sZW4iIGlzbid0IGluaXRsaWF6ZWQg
aWYgaXdsX2RoY19yZXNwX2RhdGEoKSBmYWlscy4NCj4gDQo+IEZpeGVzOiBiNjExY2Y2YjU3YTgg
KCJ3aWZpOiBpd2x3aWZpOiBtbGQ6IGFkZCBzdXBwb3J0IGZvcg0KPiBESENfVE9PTFNfVU1BQ19H
RVRfVEFTX1NUQVRVUyBjb21tYW5kIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbWxkL2RlYnVnZnMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2RlYnVnZnMuYw0KPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2RlYnVnZnMuYw0KPiBpbmRleCA0NTNjZTJiYTM5
ZDEuLjg5ZDk1ZTliNGYzMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tbGQvZGVidWdmcy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvbWxkL2RlYnVnZnMuYw0KPiBAQCAtMzk2LDggKzM5Niw4IEBAIHN0YXRpYyBz
c2l6ZV90IGl3bF9kYmdmc190YXNfZ2V0X3N0YXR1c19yZWFkKHN0cnVjdA0KPiBpd2xfbWxkICpt
bGQsIGNoYXIgKmJ1ZiwNCj4gIAkJLmRhdGFbMF0gPSAmY21kLA0KPiAgCX07DQo+ICAJc3RydWN0
IGl3bF9kaGNfdGFzX3N0YXR1c19yZXNwICpyZXNwID0gTlVMTDsNCj4gKwl1MzIgcmVzcF9sZW4g
PSAwOw0KPiAgCXNzaXplX3QgcG9zID0gMDsNCj4gLQl1MzIgcmVzcF9sZW47DQo+ICAJdTMyIHN0
YXR1czsNCj4gIAlpbnQgcmV0Ow0KPiANCj4gLS0NCj4gMi40Ny4yDQpBY2tlZC1ieTogTWlyaSBL
b3JlbmJsaXQgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT4NCg==

