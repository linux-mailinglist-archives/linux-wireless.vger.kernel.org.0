Return-Path: <linux-wireless+bounces-34736-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEDkBmH33WlolgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34736-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 10:14:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A73F706C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69720306A8D8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A83932CE;
	Tue, 14 Apr 2026 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIk0r/Tc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CED396B67
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154330; cv=fail; b=DBeErw5LU8oupCaAN7DlS7chkuBMRa/Vii96ontT2pnQ3jixII87HaZDodNaQhveOtNmEqajBdf+BEYOEYiaBWFB71HyudOlouPlrZG9vOZ8GAP+ZE7meU1OBMInn58pa56r1WMF27W7rFi+G6wsNhCl2tMi0p8mtQBv1/A40bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154330; c=relaxed/simple;
	bh=NQY3jCU/haP90lJWkVn6xPhzIH2fia/8XFhYSpEUy3Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F1eWIH4Yp+ygHNdEUT76hN4hqzqpLZSBZqTi987kKOqviiFTTjp9TGMGyRt1p26ey5kGCei7M0YaaMWpHztTVxkfJcE6OLRxlBF3nZ3i3WTXy1v8IKFEN+xfnNSuEJu/7BpACGExWVaVw3O+R8Bz+WAAoXEN+QI2GhB4gkU84oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIk0r/Tc; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776154329; x=1807690329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NQY3jCU/haP90lJWkVn6xPhzIH2fia/8XFhYSpEUy3Q=;
  b=JIk0r/TcYLk29abt8SxgQOALp9CvRs/rbHr6wghot2brGLUwtbrWAS/7
   +SMD5ktkjirG6zYIeQF6DmIaSzBLKtQYPUYVRAvz9g9WWYShK+42TacaV
   oImis3rmqyZFwAOtcTOg0hfpkml3sCeN5PXfSu9Aimc/tHuuAr3seSw3k
   N/p1AuLNBFhj58w9t0ZuYd3m/ytbDvIuxnqnx5KkR/IDE/vN6eCBX2rK9
   /NQmQi8rIexcNN+nwq4jbQp+Zsh438DZXgSd1C3bmUClRMojXMh0HxsMR
   qvAUrIixLpFBJjJ0ch2V4h30G+dldlWibKRju7hgZJshcxXJkRZCnXOf2
   Q==;
X-CSE-ConnectionGUID: Zs4tbpiER5uwleCvxjlncQ==
X-CSE-MsgGUID: xx4hKciqTPyTbczDdLxITg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76267556"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76267556"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:12:08 -0700
X-CSE-ConnectionGUID: Q4yhQ0J5Qb6ll/ZV2IWiaw==
X-CSE-MsgGUID: HL2SLlutTFG1w1NoigO1Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223529011"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:12:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 01:12:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 01:12:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 01:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krpljiKHTPmHyYyNOttNFiXtdsj2PKpoU/kDlRs8b8wUwhl557FIUo9kfaU35BLEgbd+C9APXL05C3jJRIYRM5HJv2px0VUrHnswB6tXos3J6YjxwzX8X5prDFBQyzmteowJpHkyg4AKfFdNO8wxtEDVHXZsrhgoy+ZQ1ah3rmbiVjUV0C9vRcaRQThgLh8uKNVUCbvzuwW+0LFZKO3Bp/5zDEHvHhn3QNMdsIEBMSlCg2/GOwzcqlFhcJPm1XzdK0ZpauqSGxii6Fh2BIXQaKasvb1nPsSvtWT2ZM5DlgvY/+RwWBFvf+VPWn0OwrlPSHhATc3uU4gGCIBDFC6tIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAkYdGENgHNwsfW7WdDSUIOoNBOfx1w4eEjRDzBCTxM=;
 b=od6fwCOf6H6vrGFty9urEi2y854LXhkxy3uzU4ksMMgEjSgTTFmqtt0V7fyvEcyi/C1OXZCBzdDR2dTxN2TNmFtRrQaZf79quR8zgFUf4oIou12ASINuIWmH4EgFrKu2ms7ZZXgTBcTRlVk5y6jm0By1IM5jMaTjZ377UKkEni9KXrEUtK167g1qstcsWmX2ao6tb3hrSziNXV7xgc6bRUi15DA4+YPaQy+zyU6BHVJ1C6/L4NnH/wxJBC6c3xVx3ns+B5HWQnnswwCVh8V2r7a8Gh2QXUKjz2KWaxPWU9xlWR61j3/cBJwNJRBl/3OIlmI1MIfQ6TrVYx8jITgEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:12:05 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:12:05 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: "peddolla.reddy@oss.qualcomm.com" <peddolla.reddy@oss.qualcomm.com>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH wireless-next v4 10/14] wifi: cfg80211: add ingress/egress
 distance thresholds for FTM
Thread-Topic: Re: [PATCH wireless-next v4 10/14] wifi: cfg80211: add
 ingress/egress distance thresholds for FTM
Thread-Index: AdzL5byk9UfqiEA8RVqqIf6pIqnueA==
Date: Tue, 14 Apr 2026 08:12:05 +0000
Message-ID: <CH3PR11MB8383BE4757B5B0CA7C3AA114FF252@CH3PR11MB8383.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CH0PR11MB5235:EE_
x-ms-office365-filtering-correlation-id: 9702438c-ebea-4755-f92e-08de99fd844e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: bX0RBSBMBeCMpXqBAfTTKeWo8Ryrr7f1F+WTjUCZZDspIkMF1yDG1RZpo2ZUEPgz49B9/STVEv4utyR6W1ec+WQCUY3wUkDlbgDiz9TR+yQR2IEh1ybK9GVKqN2Vp4a5SZHpXbe49ZdEgU3kQOM+a7ibK0cbadIdT7ju5NvpnNe3KeQjl/ZsxL2KjI1otWh09Yi1Eah3IxWDjpnWKyo94TWs6d7MDaj6a+Vxuod/qHp8k+bfvRaD4Eqoisx5KTNLacQteY/JLMlFzPsysXw929RgqNr+VkQEkFMECSP6mZfynkzOvKzEuEt6wUrxxyXVJam/lR5cAdT6NCMxFcwKmJgMLcGzUiDyC/60Sc4qnG/Jtx0hgatdMjc6sNySUxfZH3H7+aifklOCp23D9O2hvlIkEiy9ymdrq0cFXAvvmbN6pMlO2m9u+AIEmcmnDbeS5zhGRbr6rcjVM3KlQoKEit7/I6HFKChAqtdxumHsvFYUnEtWaHakQU/4xz2cMHKbWs0Z3XYX3l1OkgX3btten0ifwz9MKW8oDyPrTBqn8KatYlaD12D2GlxxT4l9deZgcSyEPKs/tFLHPoHp+k980Q60CF/qHMYnGPaRd+jQd1uM6xpenTgqycm7ecmq5D6I/FPUL8QyBOhfQzhn5fNLOH9Q4VNRUHbbgRt3MiPpi3WCG6S552Unr/oU74FEvSXZnIe5tXHnMwUVMWjJcWt3bxYxGcbAaDYZ3DiDTOHzqMHnqbDrtMlPEe3B3d0VIcbMjPm2NWYrYU3zowJyr3R7yN0ddd5OAeFq9aT292qBoFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tn6anz1bbjKaG0w5YWUU6aWBiuOS4eDIv4uqd8Tca4LiojHghBFPyC+e9VMb?=
 =?us-ascii?Q?ghvXcADCsrVGEMar+QHRf1sojaloqemPVt+F7hLdtIQX4hHPK7DMfwG6oTHg?=
 =?us-ascii?Q?nKfw3OgPDchwgkmQz6Fy2htuo7Yry0maTymHPiuJOk86a3dPwJDMf2Z7Cw9m?=
 =?us-ascii?Q?qY02t+EWoAE3MmgRFtICVSxJlaUl4x3fdJO60Y2EzaQD0mnG21usLw2sPM3C?=
 =?us-ascii?Q?OAaIUXur8sQj/OpWC8Rj4q9gU4yNpfbBvjjSXvqVT9xzDeDs1F2qqJRmMV0o?=
 =?us-ascii?Q?r1y0MZ70HjhVhtDV+42eRSvJNjcPRYqy5bsWsXG7ADAlvXOrx5DFMYEK9v+J?=
 =?us-ascii?Q?uFpsYhpe+/CFNFcnhDy8aN5CnATZCSac6l9DMuwSFbYSH3jZQfk3pSNYniGh?=
 =?us-ascii?Q?H2A2wbRBQp61MMx/E3aH88vOq7SEBb2g2p2ed5r0z13xyv7Jpvc2n1pq+b1h?=
 =?us-ascii?Q?uIfInhf3weIs1WVyyDgQHE9xdnIQVb+MMtZKckoc3OQ1upszbXgqyZNhMCN6?=
 =?us-ascii?Q?8+lrSf/VZWqMf5Ou18VsjNXGH+PNoaevpPTni+M+Hr2ZIWMQ7htR96RaSd+2?=
 =?us-ascii?Q?lyxtmDz11zxz4DVRbQxJnHb/PfkAqYUV9yFx2KECouWSQS0IDESuVMfA4aA0?=
 =?us-ascii?Q?4EtWFSlkXNEcicMoT5cvGL4zMt9MSGsBWDaND+9FbJDHVSOsaAHeEhApn+R+?=
 =?us-ascii?Q?QMsqgmWncfDXG5kFmkDBJZ8BkpZ5I6qV61KLAc5qT0aRwFSQ5ViBmXl4cbC9?=
 =?us-ascii?Q?gLNU01z9niioA62kIQneUufo/yb+c3y+ZAwaN6R08+PVkwaB4IbLlG+Kn8Ou?=
 =?us-ascii?Q?UCPWZCCF2bNvuqlNB0D5gEj3l24fMZXXKHcXQR09MfJkW5bjAlopD6uCXPcH?=
 =?us-ascii?Q?KlrU62f6krgtInsn0t/uW1a84ZLnb3Fvjjjc/G/6dYg7N/AhdjJHeb9NF5eX?=
 =?us-ascii?Q?HaD55/HQjloEAIawUb1qwjws6YtM4bZpMLBgQLXPEqc4oBDUUWi+oGDMhYkA?=
 =?us-ascii?Q?Tn930lXCy5nwePEfldnLq+yu6nL1DfKrSn7Cr+4Sv4g7szSc4vbg+VkAwE4X?=
 =?us-ascii?Q?k2pQcXlnHNlaDzG0pNk0VE1yk2lo6tJ6FHyDfg4nzjZ3ChfSBiXiKWpkF++i?=
 =?us-ascii?Q?aThHEo1f1IXdzRHrZOUVcvKUgNMIHW554d+mmD7kY2InwQFV48pPaUaMhu/z?=
 =?us-ascii?Q?ifUek+UaRJXnkFZ1roaB3EzzE+oM2Em8Tp8A3prQhW9rUlyJ8AyTEIdY/9g3?=
 =?us-ascii?Q?vOqdK9VBW6Y+4a9OSHP+ngwQZ3t7AYkrhwjeUo3EgprUf3uy8kubDM4JYh7n?=
 =?us-ascii?Q?CziGppqYTmQb7hTWIFn6L1BDMWmIjX5tQFGEy+IANr5OXvi/b0vgpi/9xrs+?=
 =?us-ascii?Q?uH4WFkgibcf+XO/7JP0GU8LvaGuspBeVkBBLBv/x0gb6YpnHCeXnllWXFh0t?=
 =?us-ascii?Q?FfJoVBdodlHoJ9TtkmcPMtuL5P9+blUkyS/UJaB377+YcG8B57MYBwHjUG/Y?=
 =?us-ascii?Q?wKhh5iR3wrDVuSn2BVcjdIAorwFqxzO3Ekf0mnpKgPnI/fXKtS6fVGpSNYvL?=
 =?us-ascii?Q?r9asguRSOqh6RmMDHTBxK5htLSIi1+pncQQOstSqfpLMZv2JsjK7et2ILuwv?=
 =?us-ascii?Q?SGWOBcBxTsghbuK+Io476kLXEmKg8axnlLZkW8Q6DQn9jgpHx65x9Yn4v2cj?=
 =?us-ascii?Q?sHzJckZuYSLmvCstsB21sLPoSaYgLcAeyypbC6gowXb0R1KPWBXXbTvInrau?=
 =?us-ascii?Q?xmUeydC/DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DIlcW+CHXEFGoru9UO/RMrOJKPxFn9FA4QT5eX1eHhv2ngA4t6jpddlKWhXC8ssEolfB9xhldO2/xHCifjbL6pz9S/nAso0cI5p30tuu9nDU/8gFTZJOExyqyHQq+Z5zdNIb7DxNXCZAeA9UHXIjf0FnB82ATIAmmExdGYCmk5F9FhEmWRklw2cwvarQ+ZVcF2y/IMhDMr4U2Bp5tfO6csDnDEOnLBqo4uhWViXrQ49eeX2BbCE/hduFxyVkrUG3xYe0O6xnU8aihq7Ob1YAvwpF+xrG25ZvUy6RSq4xthFhdVlIzcJoPr7lRrCRtE9GafKsBwGUYzpgcULhuoKfyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9702438c-ebea-4755-f92e-08de99fd844e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:12:05.8607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgRUatusKSk12Ik2LYoYG/pm5r4j4vnCIsrUxctwU4LzcdcSuwmyIlcmy0g/r/OEbmtqydeDhJwW6Lejt98xIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34736-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A79A73F706C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


+ * @  <NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the pe=
er
+ * <	needs to be indicated in case the device moves into this range.
+ * <	(units mm, u64).
+ * @ <NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer
+ * <	needs to be indicated in case the device moves out of this range.
> + *	(units mm, u64).
Please specify that these are optional, and what is the expected behavior i=
f none/only one is specified.
---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


