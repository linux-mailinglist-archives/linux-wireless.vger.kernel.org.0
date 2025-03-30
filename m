Return-Path: <linux-wireless+bounces-20960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFADA75891
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 06:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199DA166E79
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 04:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A142E40E;
	Sun, 30 Mar 2025 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmaLL689"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663B8489;
	Sun, 30 Mar 2025 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743310198; cv=fail; b=ZOqOZe3fxPHnD2DbbP+CS0VFQdzlPxNchvG2vsT2r3G3ge3iS4v+R0WcLZQbcjfVqnKvMm7i/yxKIt0ZCbscwFF3r7q65/S9czwCeQ8GlsgnbkCqsVoV/uvQelfhDqp/fn99vi83luu+hB2wVPV9Dm8DHb03qjtK36XCbbOz/jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743310198; c=relaxed/simple;
	bh=FFNKqzP/f+mFBQgooXQJMMSO128wsh0kkWIrE8Lt8YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sbyzId9iP7+68ngMrOk6ECTM7h5sBG2wUgAtr75At84tyqd+1FgaAS/ZkckmKpAcUv4ML6Y4ePR4hnCQ6mb01MR1RBpt1AU9N6mnyI0BIBtIbIo85xeSzE+OajU/RKEvjM0+4z7igjC8n1ULob5tLovXVeLpFXZ7SvW2EIx147c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmaLL689; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743310197; x=1774846197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FFNKqzP/f+mFBQgooXQJMMSO128wsh0kkWIrE8Lt8YY=;
  b=nmaLL689ucLTQiB3PI3SfNRjKQkSa04w/5dAQNHpsJ6b1SNvf277L97a
   /7LOo3AWx3uSnyqMNiYLkKhRhlJMEkQgkt6KFmSFpP9uqntTN0MdC7fAs
   E/x28/7V2LeDAf6QXIyepA9tzRUbHkXMAexHRucVgos0+VXMwCLmiZn+L
   cs3vKcG9vMXyeOPFFb3SYM78n3sxsNPnFBsfTZnZdrcGkCGYuL/NDHcMh
   PSL9gunrDzk1l4BAAY4G36iJNOiNIC0JGr6L6usswi1+q7647rooQZyfY
   VhvJlbvTAf6cWBBem5OKbqqgsNVYUUMSngEhyePeNLilmljX6MkjyFTBr
   Q==;
X-CSE-ConnectionGUID: +XU0lVYARMCcDL/UopT9iw==
X-CSE-MsgGUID: Q/UCCxvITZqYbf3PUmwTog==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="62021577"
X-IronPort-AV: E=Sophos;i="6.14,287,1736841600"; 
   d="scan'208";a="62021577"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 21:49:56 -0700
X-CSE-ConnectionGUID: Lj/ja2iSQBGks1wwVZS6kA==
X-CSE-MsgGUID: HwN8OfMJRcWg1bDN271f9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,287,1736841600"; 
   d="scan'208";a="126707183"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 21:49:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 29 Mar 2025 21:49:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 29 Mar 2025 21:49:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 29 Mar 2025 21:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2+bERpDHWLx4I83lm8kAZWBq/YswbVSNB+QqaQYWcEidtSihBXlb0IoGyffzM82Ygng89mJEIllAUptPdbFifBlgfkNNuOUhL0i8mgeF7WaL60Fo/hrBbeayssxcSg1jZ+mqSVqyIVXrvwBe101GTqq/BvOXWzQc8k0k08kbj5LkvXnyKD4pKpYtKt2efn/RHPrQq5WFGD3bXL8PWKRLofVsR7IstNwGgEGpMcf5wLZiXUWs514jiReREZRfa/2NDAbyXRSZW159iPgA0+0Zi7QubfmvQmUdXBCjldEfTf+Gt1fk1w5XEvlXKf5e/FNiI+0PfO0ENCGa4neYpgsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFNKqzP/f+mFBQgooXQJMMSO128wsh0kkWIrE8Lt8YY=;
 b=Xcrgv0pC7uz4fsoT3XqJmx2xzbjhtY/aV6JI5s1LDAmwNpKAOfwL4ArtZQnfifptKBB82jPRqHCSG0+t8Y2o3SIE47he4kJB83z+JaOHtDmivpnAXpdXWJXUtjMxGp2r5+7eWlrlxGZ/gExiV1t8ZX5uR5YtCvJcQen0QtbX77rPEAtjQCyW4RTiqZJzEbwUl945Fi8ya8uld4RuCCzUJJEEMD/JaSD9ALhDg3qESh+PhULiZq6g9VYq5qbnKZ2Rl4nKjmDzXTk+XgI1No5mOvzE/ihWLX1seG77ZXRdLXunMFnd3vkrSjdDtWzjvzYPbyNzbCEP0I1/WFpN+6rj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sun, 30 Mar
 2025 04:49:38 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 04:49:38 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, "Berg, Johannes" <johannes.berg@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, "Berg, Benjamin"
	<benjamin.berg@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iwlwifi: mld: fix building with CONFIG_PM_SLEEP disabled
Thread-Topic: [PATCH] iwlwifi: mld: fix building with CONFIG_PM_SLEEP disabled
Thread-Index: AQHbnWIOkeOxI3g5d0a0bkEQAnBp07OLIvxQ
Date: Sun, 30 Mar 2025 04:49:38 +0000
Message-ID: <MW5PR11MB58106D6BC6403845C330C7AAA3A22@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250325084340.378724-1-arnd@kernel.org>
In-Reply-To: <20250325084340.378724-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH8PR11MB6856:EE_
x-ms-office365-filtering-correlation-id: 9a309274-33ad-4ad5-0a59-08dd6f4646b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RDJrdzQxaURveFdySStMd2JzOHFpOW5MZUpBLytDTE4vNWJhNXRaWkgrZ0NG?=
 =?utf-8?B?VlpwSXZnS3pPS1prd3pzajJOUXB0Um14ZTFaN3dNa3BsWTJua0pqeDNwYnlq?=
 =?utf-8?B?ZnFuSGFoQzI5SW9rcEZRZ0c1QXh0Q2lReGEyU1M0QzNMSWdMaFoxd2RzMnY3?=
 =?utf-8?B?TyswVG42Q0R5cE5sSUhFSTRMTDN3TDYydkRlNE91eCtaSFFLVUczZ1pnYXVL?=
 =?utf-8?B?dUtRazJIVi9leERLdEx2K2FwV2tmUWkrRnBOd3Vmd01EK0xUdmFDZWMwak1B?=
 =?utf-8?B?TkluY3VocEFMQ2xUeWphVnlpOCtuNk0yT2ZsWnUrVVJ4RGlxTENFUEtrdHk3?=
 =?utf-8?B?MjdzVUc0ZytSNDd5bVlwQUZ6cGhUQXJwMzVuclZJK2RoeUVoWHJIRldwS0hL?=
 =?utf-8?B?Vjd6c3ZRQ3dld3pNR29aU29LUEhMSGo1eWtrb045MitBWUdyd3kzZzhXWk9p?=
 =?utf-8?B?OXg4WlVFc08vMDdQRjFWVDhZQUZHZ1ZqSlZuZXA3Wm1MVFc2ekswWnZ0U1hm?=
 =?utf-8?B?a21PNlVwRUNYNER5cnlKMU11QmtBaklHVElIczRSRk0zUmEwdU5rZEVxVFQr?=
 =?utf-8?B?aGdwWWpsQ0lqejF0V3g5UzVERFRpWURWUU1xMWdvQ1FZVXlWWVlIVlpvaGdp?=
 =?utf-8?B?V2I3NkhBWGFkcGROSWxtR1o3cmhqMGFhQnZ3bXZmaXVUYWRkVEF6N1JDZ2Vn?=
 =?utf-8?B?VEZjMzNJTThpdUkwNmthVDM0b0NKYVk2OUhPcUVQVTVrcXlJZG9sTUJBeU5m?=
 =?utf-8?B?NzZWVWNEaVdlM2pabjJBVXBtVUk5M211a2t6bTlOakxCd25IM3lMdUcwd2gz?=
 =?utf-8?B?QU13SmlDbEZYdVlGRkpRRkxPbW56c2R2Tmx1UjJlNkpMM1hLRm9XYS9nTDBM?=
 =?utf-8?B?MTJTbzFYb0J0eWhFSFZPSnYrUjhBd3JGM052VkVrS0c1VGhMSFRXb1JBUlE1?=
 =?utf-8?B?UFl6R3c1ZlQrbytsSUhZcnptdHFCMUhtZHlWYzdjV1hkUG1taDByU3Rydzlx?=
 =?utf-8?B?TmxLUXFXWDl2UDBXb05oQlVKbmRYSUJ0bURybUsyeW4xbEcyYkd2ZWNvWjY5?=
 =?utf-8?B?TndFQ1VmQStaS2k4NS80WCtjSzhVaE5kVENlVTJWY2pZWVlyaFFvME4rUW9l?=
 =?utf-8?B?dmFqd0t5OE8wNExXU1JBVGw5YmllVThqYmtTWXVpT01ZeCtmS0ZiWGpmRWEy?=
 =?utf-8?B?cVRkbW5lWCs5RWQ1M2JZRVM3NmhRbGJBSUhoM2tkM3R2NFZNc2RNem1GWmJq?=
 =?utf-8?B?R0N3Ulc5d2Vxa0RGajNJQW94UmwvK0JlZWR1YkR1bDFXY2dqZlZEQ0hLRjFp?=
 =?utf-8?B?YTY1V0diL3ZXTlRMQWxCbGtmRUtzL0pKaytNR25uWFZqelgrOTBoMGZZYXJw?=
 =?utf-8?B?YkYzV25aZE9GanRYY2xFa0pnWm9KWStmV2E2V3pmTThqcUZ2R3VLNDF2Z0kz?=
 =?utf-8?B?cE5RemRnQjJiMGxXcXIxR3VjTk41SkpPdDY3M3pLcGZ4bkhFcy82SHNVRnFL?=
 =?utf-8?B?RkZPdHFQZG5GbGJrSFhOUzl1M3hVckJpOThpUnJ4bDViaXRoSHlEc2JUL2Z6?=
 =?utf-8?B?ZnpOSzRLS0lleTU0d2dRMzV3WWVpOGZwM0h2aG5nWi9PLzBaQ1pwVnM2YXJu?=
 =?utf-8?B?di9jaXFMck41V2RQTnJQN0dGL29XSGR6S0sycDJIQ1N1amdMT2FPczN3R0JN?=
 =?utf-8?B?a0xDdmNOSkEzbmNnMGI4TzR2Y2JhOWsxMkMxREF3OFgxVXdiNWpOUmE2Q01G?=
 =?utf-8?B?VzZqb05rMG1TaWR6RXFvS0tSQ2lKc3kzOVZMME5CQjQwNWZnVXNrbVJBdlhC?=
 =?utf-8?B?aWtTKzlXQUUwTVRqSGtvYjhBN1dCdUVTZkdVTXpESkZ4U2xWemk1OXdtZkw0?=
 =?utf-8?B?TGxmRmR3UzRKdVNXTElWSjdzSnJhQmlVdTRuc2dEQVp2OEVMVWtEbVJnY2tM?=
 =?utf-8?Q?XXGH2hld+R+uUbo8rTT/pNCjnhYlGe0j?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mi8yYlI1RHU5UlN5MHJYWndYS2NFcVBIQUxvWWxGWjVIUHh6N3A0U0xhQS9h?=
 =?utf-8?B?aENIajJYRCttTWh2OFV1Wjc5am4vYlc0dXJod01CSlZ0dVJtV0lLS2JVcDF6?=
 =?utf-8?B?UWRaRmJMaHhtWlRVVjFPZ1hZSFNyK0M4ZEl3NzBUYUxkWkhrWjRJVlR0NHRt?=
 =?utf-8?B?ZFdQeE9qeDdlaW9HYWtFY2VWY2dQS1YycWZ5UlVoSFB3b21NUVlzOWhMa3ll?=
 =?utf-8?B?ejJ3c0QzNi93S2drQlFURzJmY2dTUnNPbC9OSG9VWGgvTzVDSjcvVzR2VklU?=
 =?utf-8?B?Y2haSTRLdjZoUjZNWjN4RUxPS2tIZ3RtRnlNU1daemZtUFdJNHF3L053NkdP?=
 =?utf-8?B?Z2J0ZStkWDMzTkRzOEFxb0FSRmhnMXR1dk0rUHhaNTVGOGh5R2tMTGNXcHlH?=
 =?utf-8?B?UFZOYkZUMzhtbzdrNHM5ejdhZ3NQZnp6eWNiYUNON0pLajVzQVEvQU1KK0xn?=
 =?utf-8?B?RkJxN0JETXBKK1VSS2k1RUJwZGpDQlVBVExLNWczeTNLdDJiY1gwdGRvbE1m?=
 =?utf-8?B?RmxnN0dPdk1zNDF1NmxUQjJDajNCcmp1aTBrKzBHTnhjUGIzcHFQZldKejNI?=
 =?utf-8?B?RW11eTFxY0E5UXg2cjNhNnBBaERQSkxnOU1IVVVod3NqVk9aRGMxMlpvcXJR?=
 =?utf-8?B?eTdZOWVlRzZiei9ycXhHQmU4cEp0OEFhbWdOejlwNmNxMStZMWQvZXp2WXp6?=
 =?utf-8?B?UE1pb1Y2OEdpT1BEUTI0K3JDd3FTb1M3LzNtN3Fmb1Y4Y1YrdVdkQ0dBTGRJ?=
 =?utf-8?B?UUV2VEwzZjdzejdPcGF4Ym5jaS85U3BtU1lYNGNscnJ4M04vSmxxN0Z1T2tp?=
 =?utf-8?B?TGN0b2hWZUx4RDRMSUVaaUk1Und2VlBrQ210ZVdGMUE4UTY4eFhZVkVMMG51?=
 =?utf-8?B?anMyazczaUkwZlFUemowcUZ5amZ2Wm1FWi9wb1VZWmlCdkc5THV1QVI2ZTJM?=
 =?utf-8?B?eU1odHYyekl5TlFFUEYza1V4Rk9QK0w3WnJ0YlgzeThXdnJZZlQ3bDlZYWp6?=
 =?utf-8?B?WE9VS3loTlFmcUd6MTkvakNSUTN6OHV4UFY3K0x4TlJSUTJkKy9sS0NIZnh6?=
 =?utf-8?B?YmJ4d045Mjk5c0ZPS1JaKzBhZ0E3Q3RGNjZ0T2poV0NPTG9FS1JJeUd3dHcz?=
 =?utf-8?B?UW5idnpHamhNWEEyZkxqU2R0SjVJbXNhMTJPMGEwdmhuejNiU1MzaitZeXBq?=
 =?utf-8?B?SlEvT3I1NHJVR1R3bCtnbG90QlMyU0preWhJOHB1TEhJaGgxQ0lEZnJUaFNy?=
 =?utf-8?B?MklzaTg0VHdMWDFmRTZTVWVvTWkwZi9CREJ2ZkhLNWZnNEFHMkt1TkZKSUdH?=
 =?utf-8?B?MkUxdi8rZWQ3TmQrNWN6b1orUkxVSW40NkRNQUpTbEhvMzlpeHJzSksxVDNX?=
 =?utf-8?B?S2RoRWhuYmRSZHJ4dWhlQ1ZWK2JjSWdiZmI5M1JFM05xbHJGRUV5My9SblEz?=
 =?utf-8?B?SVRSVXgyczhFNC9lZHV4ZzB1cklPM0JtVW04ejZ4VTZxOGlGNHNyOS9ZQi8v?=
 =?utf-8?B?cHNydXcvcEw2NDhzd1piYmV5dHFWVGpIaHBvdVd0Qys0Q2VPclZabmJWOEFx?=
 =?utf-8?B?cjA3dFRWZjF0aVF1MkZ3S09PR3ZOZllKK1hVb2trY0laNS8vOEkyeUhPeFhv?=
 =?utf-8?B?WVB0NSs0SHpmOHdmeWRZeFE1OCt0eDJqSTcrekxCNk1vb1NNUHhLbTR1dVZS?=
 =?utf-8?B?UnBjNmJpeTJlU0MvVVZWV2lzY2ZORmhzT2JUYTVVdDhUZlp0S05rN1J1MWJz?=
 =?utf-8?B?VVNvU3hWSCtYVGcyQlloNjF2RVMvRFJJcWttOUFmbDFsOUJCYk1iOFFvK1FH?=
 =?utf-8?B?eGJYVkROd3YyRCszajY1Wjc2RmVRMnRDdEUzUlFORDZubjIxbk04a3BESkRL?=
 =?utf-8?B?Y0NNNG5IQ1N0aktWS0E2aGo0RWh1THQxa0QrV2VJdjk3L2p6ZU9QS2hVVEdO?=
 =?utf-8?B?TkVFZlE2YXRCZDloaExmSk1pODdSaVUwMi9QNThOeWZnSUlvZzB4aFVaMi9Y?=
 =?utf-8?B?MU1Rck5UV3plczhCdVZMMHpkdjVrczgzT2dZUDlvcVBGNFZXQXpERDBLd2R5?=
 =?utf-8?B?enovbWxxOFFMK3c4SGtCVndaWWwxRUd4bS8zcTkwQ2FibzA4OGNHaklvdE5q?=
 =?utf-8?B?V2lrSitpK09VTXg4L1dzMTFwRkhvWmxmRXlia2JXV2MwbWYxZ0JuVktMYmQ4?=
 =?utf-8?Q?BOjKpwxoTS64rBK8FSt7vbM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a309274-33ad-4ad5-0a59-08dd6f4646b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2025 04:49:38.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlvzXJTq50da02uf2yb8wgtGrXT6foA3PVJPMCVxqMCUPsByfOQ5nwBO5lgUzdfFfPcqkDUh440f79n0BjzG1I8oLQYoYlwCe5Es23X99AKuoboUpNZRPJASZFLPk/QN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAyNSBNYXJjaCAyMDI1IDEwOjQ0DQo+
IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGlu
dGVsLmNvbT4NCj4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBCZXJnLCBKb2hh
bm5lcw0KPiA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+OyBHcnVtYmFjaCwgRW1tYW51ZWwNCj4g
PGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT47IEJlcmcsIEJlbmphbWluIDxiZW5qYW1pbi5i
ZXJnQGludGVsLmNvbT47DQo+IEFuamFuZXl1bHUsIFBhZ2FkYWxhIFllc3UgPHBhZ2FkYWxhLnll
c3UuYW5qYW5leXVsdUBpbnRlbC5jb20+OyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gaXds
d2lmaTogbWxkOiBmaXggYnVpbGRpbmcgd2l0aCBDT05GSUdfUE1fU0xFRVAgZGlzYWJsZWQNCj4g
DQo+IEZyb206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBUaGUgbmV3bHkg
YWRkZWQgZHJpdmVyIGNhdXNlcyBtdWx0aXBsZSBidWlsZCBwcm9ibGVtcyB3aGVuIENPTkZJR19Q
TV9TTEVFUA0KPiBpcw0KPiBkaXNhYmxlZDoNCj4gDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvbWxkL21hYzgwMjExLmM6MTk4MjoxMjogZXJyb3I6DQo+ICdpd2xfbWxkX3Jl
c3VtZScgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiAg
MTk4MiB8IHN0YXRpYyBpbnQgaXdsX21sZF9yZXN1bWUoc3RydWN0IGllZWU4MDIxMV9odyAqaHcp
DQo+ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jOjE5NjA6MTogZXJyb3I6DQo+ICdpd2xf
bWxkX3N1c3BlbmQnIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1mdW5jdGlv
bl0NCj4gIDE5NjAgfCBpd2xfbWxkX3N1c3BlbmQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0
cnVjdCBjZmc4MDIxMV93b3dsYW4NCj4gKndvd2xhbikNCj4gICAgICAgfCBefn5+fn5+fn5+fn5+
fn4NCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEuYzox
OTQ2OjEzOiBlcnJvcjoNCj4gJ2l3bF9tbGRfc2V0X3dha2V1cCcgZGVmaW5lZCBidXQgbm90IHVz
ZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiAgMTk0NiB8IHN0YXRpYyB2b2lkIGl3bF9t
bGRfc2V0X3dha2V1cChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgYm9vbCBlbmFibGVkKQ0KPiAg
ICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jOiBJbiBmdW5jdGlvbg0KPiAnaXdsX21s
ZF9tYWM4MDIxMV9zdGFydCc6DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bWxkL21hYzgwMjExLmM6NTA0OjIwOiBlcnJvcjogJ3JldCcgaXMgdXNlZA0KPiB1bmluaXRpYWxp
emVkIFstV2Vycm9yPXVuaW5pdGlhbGl6ZWRdDQo+ICAgNTA0IHwgICAgICAgICBpZiAoIWluX2Qz
IHx8IHJldCkgew0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICBefg0KPiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jOjQ3ODoxMzogbm90ZTogJ3Jl
dCcgd2FzDQo+IGRlY2xhcmVkIGhlcmUNCj4gICA0NzggfCAgICAgICAgIGludCByZXQ7DQo+ICAg
ICAgIHwgICAgICAgICAgICAgXn5+DQo+IA0KPiBIaWRlIHRoZSB1bnVzZWQgZnVuY3Rpb25zIGFu
ZCBtYWtlIHN1cmUgdGhlICdyZXQnIHZhcmlhYmxlIGlzIG5vdCB1c2VkIGJlZm9yZSB0aGUNCj4g
aW5pdGlhbGl6YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bWxkL21hYzgwMjExLmMgfCA3ICsrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbWxkL21hYzgwMjExLmMNCj4gaW5kZXggNjg1MTA2NGI4MmRhLi4w
YjViYzVhYmI4MmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbWxkL21hYzgwMjExLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tbGQvbWFjODAyMTEuYw0KPiBAQCAtNTAxLDcgKzUwMSw3IEBAIGludCBpd2xfbWxk
X21hYzgwMjExX3N0YXJ0KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KPiAgCQlpd2xfbWxkX3Jl
c3RhcnRfY2xlYW51cChtbGQpOw0KPiAgCX0NCj4gDQo+IC0JaWYgKCFpbl9kMyB8fCByZXQpIHsN
Cj4gKwlpZiAoIWluX2QzKSB7DQoNClRoZW4gd2hlcmUgZG8geW91IGhhbmRsZSB0aGUgaW5fZDMg
JiYgcmV0IGNhc2U/DQoNCj4gIAkJcmV0ID0gaXdsX21sZF9zdGFydF9mdyhtbGQpOw0KPiAgCQlp
ZiAocmV0KQ0KPiAgCQkJZ290byBlcnJvcjsNCj4gQEAgLTUzNyw3ICs1MzcsOCBAQCB2b2lkIGl3
bF9tbGRfbWFjODAyMTFfc3RvcChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywNCj4gYm9vbCBzdXNw
ZW5kKQ0KPiAgCS8qIGlmIHRoZSBzdXNwZW5kIGZsb3cgZmFpbHMgdGhlIGZ3IGlzIGluIGVycm9y
LiBTdG9wIGl0IGhlcmUsIGFuZCBpdA0KPiAgCSAqIHdpbGwgYmUgc3RhcnRlZCB1cG9uIHdha2V1
cA0KPiAgCSAqLw0KPiAtCWlmICghc3VzcGVuZCB8fCBpd2xfbWxkX25vX3dvd2xhbl9zdXNwZW5k
KG1sZCkpDQo+ICsJaWYgKCFzdXNwZW5kIHx8DQo+ICsJICAgIChJU19FTkFCTEVEKENPTkZJR19Q
TV9TTEVFUCkgJiYNCj4gaXdsX21sZF9ub193b3dsYW5fc3VzcGVuZChtbGQpKSkNCj4gIAkJaXds
X21sZF9zdG9wX2Z3KG1sZCk7DQo+IA0KPiAgCS8qIEhXIGlzIHN0b3BwZWQsIG5vIG1vcmUgY29t
aW5nIFJYLiBPVE9ILCB0aGUgd29ya2VyIGNhbid0IHJ1biBhcyB0aGUNCj4gQEAgLTE5NDMsNiAr
MTk0NCw3IEBAIHN0YXRpYyB2b2lkIGl3bF9tbGRfc3RhX3JjX3VwZGF0ZShzdHJ1Y3QNCj4gaWVl
ZTgwMjExX2h3ICpodywNCj4gIAl9DQo+ICB9DQo+IA0KPiArI2lmZGVmIENPTkZJR19QTV9TTEVF
UA0KPiAgc3RhdGljIHZvaWQgaXdsX21sZF9zZXRfd2FrZXVwKHN0cnVjdCBpZWVlODAyMTFfaHcg
Kmh3LCBib29sIGVuYWJsZWQpICB7DQo+ICAJc3RydWN0IGl3bF9tbGQgKm1sZCA9IElXTF9NQUM4
MDIxMV9HRVRfTUxEKGh3KTsgQEAgLTE5OTQsNg0KPiArMTk5Niw3IEBAIHN0YXRpYyBpbnQgaXds
X21sZF9yZXN1bWUoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+IA0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiArI2VuZGlmDQo+IA0KPiAgc3RhdGljIGludCBpd2xfbWxkX2FsbG9jX3B0a19wbihz
dHJ1Y3QgaXdsX21sZCAqbWxkLA0KPiAgCQkJCXN0cnVjdCBpd2xfbWxkX3N0YSAqbWxkX3N0YSwN
Cj4gLS0NCj4gMi4zOS41DQo+IA0KDQo=

