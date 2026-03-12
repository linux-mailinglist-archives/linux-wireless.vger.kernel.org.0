Return-Path: <linux-wireless+bounces-33158-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMa8IoIqs2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33158-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:05:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08972279BEE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC79230120D7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B95240DFBA;
	Thu, 12 Mar 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVG4KUB2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF23382F1
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349504; cv=fail; b=SyvCNq3eHWkp5ltExafY2iFQ0A8MbvcvoHCyVJDNBK+NJH1b5EfKYfI/bzsfABvS6ZY6VF014lAkdYeFTHfWWqnsJgFjwfm3I5b8ktPHFxNboRf3tTHTS1ej/B4SNuGufv684jj6p1yx9Fp9WTPLKGU+Xwur3CkMjRHEyFgY+g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349504; c=relaxed/simple;
	bh=TET4AIWLxSAHsdTV6QN1zp3I3t9TYW/IaS6PPIMUEWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvJGMMmTwEJmvUa97G+v5k53PSMdI9A7WxYcSYRMLpDaiblPOyP6Nhd8mjhn43RIpuUH+ZKZ5QyRKZD3nW1ME3A4TTPzoPVcLVtJNGcLzVFaF9HR6c/NiuYgKnZU80efjxXOxfdvDOpyBBEEULFI6SXpdOVB/dcfXuEHwbm9x5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVG4KUB2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349503; x=1804885503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=TET4AIWLxSAHsdTV6QN1zp3I3t9TYW/IaS6PPIMUEWw=;
  b=OVG4KUB2kixhE6ivwMoZgjJvQyw10HVTa7NVM9rNA1tTY2arganISVsr
   R0EYwUmpDlvNdEJ0Trg+HfSnUEIKKUdemEe/ol7DIymfjnDW5ZjEPNVaS
   s8y/eKCHiF4VrKPPr9XsiFFeWgUs3bDU2isj1N4LVdOLxE/ctwY4m+w6Z
   2XnYmGvW+Znd+BJGuqljvUxacBDohH22G8LO4o0hX/PRe8c0fMHCDqFmG
   WMZ9b4lR7s7fP3RQwwEqYfPqN+JzEA4AdWFZqb+RzrSPDA7vcGLkAz85e
   7eFXXXQ8NIP+ZBoj4c2dUcRsJmsBqKv4jw06fQ537E9u7gjqogyhJo2I4
   g==;
X-CSE-ConnectionGUID: /qGS81flTjidacOro3aYjw==
X-CSE-MsgGUID: orpY6IrzTxOGioDGqDCt/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78306694"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78306694"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:05:03 -0700
X-CSE-ConnectionGUID: AInnuJuXQxagL0Y8dn54hQ==
X-CSE-MsgGUID: A4fVArsITp2jhQzs6TXwwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="225416242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:05:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:04:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:04:57 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcjAsBJxdLXEpq2YkohTjgHYThm4yMYAuIfvY5MAENJ6ra3WMYz6jTLXcmEiEnqeES6fiDIji4qKHXoE7tz/WLRMOa8C3QHQIaADsD64zQbNFuqB6nE6h7afZcgYf9Ji/cq2OIen1j39prh8+2PJ5MGxcjDfqeHrAXddk+p55nHJWcuAn6r/URZm+qNHdItLH+I6at7DJICMu4KHB01NkYpx0/LdtuAjWDAdLU23/yGAtQMdZDA44IxG9wrBto+VKJwQTPoA7t6/BE7uY1r/YxqO+9OHztwu5kBAfRQW/jq6FHgXo5KEANFDBngnK4yBf6td3jasgPbbv6w1rycl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnETc74At0FX1vMXLgpE+k9zqBClxom/0t0RMzrH4D0=;
 b=OM1T7Il8njuUj9ZgVy2tOA6ZrNBfQp/KZiYw1AJsceX/nrXUqflBAiJQ/Wur4bHT35Ywwi513Ezs+cWdJNGc//g9JFiqbmeA1NHinRYLFGbnj9MLb/RPN5c1a3OR4RpkCgK2D/KpiJVpk4C/nJp2iPOc961e/ofXLKCLJahdDKhCES0e6kT4QEasG1KKkCTf3CN5KpsHQ6rqIHvBqCJuRPviLLrWPgF8us6WUmYdcFTkdVQwPhsJ8xYBV521h7uxaRUcGGa3e6jIXJJE+dPjbQvPDVAt1dppeyEU0+MlCrZQ8NWc6Sz/Zdjz3FOJtSoCiRCajym+l/BxaCA0EB/AHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SJ5PPFC295640A5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::852) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:04:55 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:04:55 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 02/15] wifi: cfg80211: cancel
 pmsr_free_wk in cfg80211_pmsr_wdev_down
Thread-Topic: [PATCH wireless-next v3 02/15] wifi: cfg80211: cancel
 pmsr_free_wk in cfg80211_pmsr_wdev_down
Thread-Index: AQHcr8tfguV+jISLV0GSeqCa0jusubWrZ7Lg
Date: Thu, 12 Mar 2026 21:04:55 +0000
Message-ID: <CH3PR11MB83834872AA2767B19587549DFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-3-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-3-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SJ5PPFC295640A5:EE_
x-ms-office365-filtering-correlation-id: 8269b415-fb04-4992-b2c7-08de807b0320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: s1oyU3iacOCsqD395+qXInl4Nl+f7cPnWX8tpE/9AwM+oxtabECyJ3wDJLDc/X79y/caZfUBuQr6FtrnJm0cumJlTcDqbqk5WxngQN/dwy10EuEq7ZOooKcUR11eEO7jiKldE2kvmnQCK5dheaeAtYB4euVkT91qkzGAJ0vZ1EwgRTDHEgk1wN5ekWBet7PxP8JR4V2uEJLaTYAKMa+yoAmg+GVJvUn4uToOmVc/z4Rq6WOpSkYljrNSQy3B+r+2AZF24xXUrKJML7B77gYskkOwooYsirwKoEeURCh/iskh+P5MZGkqqjUW9BUxO7rZSddOI1V0bAdaDbHI9tbdj6pFdVYAMzXJEEyKSOr8tocQ+8lsfSdn0XK1hm9lL+Kxb7tUKKdFaF85oku2OAH7boEb8zqmOV1hV5+V6RaNYOmiQ7EvG5kji8ShCZwZHsVb1FR4K0OHYbejkOSJmd0KGV4HwseQFlPMq2UpYaw7MUQxIngoyafDjqaDg64jyLTbP/FmbIWJCEusSM+mw3xHUU56URQxUXGF3YZ+GAG+JzbxcBuujweVQrKDYsXoXsBPT/ekppL1wORB87Tb5gilvXjVsnvdU6Zdbg6cIJPBWu089B/6+ek7+sA6acQGiEsV9DAEdYfpEuvFno0Ex/EC12qNmxcouw/znDuJTwdo0v+fAmZCTRILux03wFywhnL9FHuWUo7OOc+al3oLGs8V3H4L0NtNNwS9weDy3m/or9g6JKdOiTb1qPfQ1Ct0MNGM5Dd+iiXa8uir+GFVjdAfwgiLMgr+oIrk6VKxHSiHT04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uznU7QTdUzvxjcjXLs404F0sDcUOkOWqSu4u0/GxO1gEqA9hceA2ulxG1U7N?=
 =?us-ascii?Q?pa+a4YY5zbV12zYOTEfX0G4UMcx84yBY4iOkkTd4T1HGcpyjhsProgYEOJxx?=
 =?us-ascii?Q?AakcR+bIsN7QI2jNPxOfjmmW5171pMVrxxAR09LkI4Zp/vpGV3jpoqKPBi3p?=
 =?us-ascii?Q?uMHE6RFFpZ2yNi1rjZHnX5F2O+M4XJdP1ZexTLXCXsOa0DDeQhKizecg64pU?=
 =?us-ascii?Q?USpQJd4QQcu/RchYrfjoTDQuKDLhGwU/cuP9nhHcn/iGnfHkCorDlsCNfry+?=
 =?us-ascii?Q?4Pv5pFSqJ/BENBZGEqDcixgpS7R9w6KdQjnRQroOaZ3ifcdOETIQ9bILmRYx?=
 =?us-ascii?Q?6TgAI6pdCuLDCLHSaRX85spDSblW/QMA+GKWiq0ok02TGTUtQb5xFnXnJUVp?=
 =?us-ascii?Q?Q0yu/1ID05ZS6IUmmsnbBY/zBtYEsRiGHerkt7ceO5UKiehNByoo7nQwfm+Z?=
 =?us-ascii?Q?LgTLy4VNDwBTXE6hDhkqjl7ilbXdUP718ZWssC//BYduIr3EjC2ZqZO9+/Vo?=
 =?us-ascii?Q?/IfvVoy17fq4z/HZvSHOiIyc51rY28ajBOCg4c7D4WfKKJAsaNAWrmsSrQZJ?=
 =?us-ascii?Q?nMEINSg/Dpm+pWxBJCwR7q7ADJ6kS29+qaol40N283cI82YFW5twIweN9B1g?=
 =?us-ascii?Q?Hz9rs7rE67llsQm0pa/wv80bMttlX2O+4GqMeA+g+LusbTt5kwYZXgZYjIE6?=
 =?us-ascii?Q?iYLn2FCZTYUOGQKkQYWN+NOy6pCirjTaf/Un/2Y4Tq+InbIyBMkEih2vzJ8S?=
 =?us-ascii?Q?rqnzOztPcOSdbGm/C9gOPfBsYrQADd466o0/soLESigr68fFGNroa8n/Br10?=
 =?us-ascii?Q?yWZ6GV54dCJ7lgs1URus3xyDpB+6FD97CfomOtXS51EIhz7uSPABznu+7g9z?=
 =?us-ascii?Q?9A3UyRsjxKL6uwLcvHvtsbZyEEDS26e08YW28aJGPT7ccovtm5H40lpogh/x?=
 =?us-ascii?Q?ey6TCYSTyQ27LPst9AcTOwhvyXFP8+PMZii4CeNC98lMHxZ9GAOnC+vHA+oq?=
 =?us-ascii?Q?xJ17FUFM07YO368RUZZFhY7wKi/Aw1y34g1RX/u8XdFuj9KIZbbGImSJp7NQ?=
 =?us-ascii?Q?3TfpB0YY+4rUEmh4V8ezbQ1n1B/BFd5TksD1gJxYEKR6FTbxUZc+42GfYaa1?=
 =?us-ascii?Q?1M2162ofUhhf7Qyok1ZxFBXgKq0bNTXWBWMszlZuZAIDvgEVLh6jQMKKa9Jj?=
 =?us-ascii?Q?fz4c3yWo2zUvN0FfSTMyy8lBe2shTWqb6jK6efyLbx6YG4uPGuhANBFeJzPk?=
 =?us-ascii?Q?pLzGMLlMaiW81kJaEKeFuqoZlumCC1hl8mxajK+hez6IPOjlE98h7I5p1yZm?=
 =?us-ascii?Q?sLrcQ+TuG9lB1nQghyLon02olSTVdkYETwafP6gcJJbDxUqy9Fq+uU8vWfbP?=
 =?us-ascii?Q?wjPI07GoqCjC9dCtAmYCc9ckU1KUqSWLKG16nfbFTXzAS0MmU/dLa+ltVFtT?=
 =?us-ascii?Q?TFYCAfP7QhL/V6OVUEI0EBYlp15dTYbDevdhG1vwxAKcH8c7wnpPU+w795H0?=
 =?us-ascii?Q?Djmw8Mzsx7Ila85+oPGD5KBZU3HX1dz+RL0s3ziCZ4IlA0KYXyGgfnJTGytY?=
 =?us-ascii?Q?F61D5uECQ/GT/S+eweQYMZIgqMlAykA8taBK2qICl6B2dLlFMz4YDvSvjWRA?=
 =?us-ascii?Q?YQim62Iu9dLWn+OwIHZdFCPDlGanX4z47KmtrFZgiY2dMu/dgpq84FfMLlKx?=
 =?us-ascii?Q?HPc4GllhjYVyPCpPG3K99z3QfuimjXD7+ukeNzJiTuVVMt0brkfjP96IqpRS?=
 =?us-ascii?Q?lMxxqZtY0vfhFLBiYxZzGHkjbIH9IQryo3UcXijywF0O62Fx5jdPVJPfCUL5?=
x-ms-exchange-antispam-messagedata-1: LNPABINMDZOn+Q==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nxWT54XaA6zxpUZGY9a0SduOg4GHfC8lt6tsiwvMON4tsBHbF53NJxOZRcfsnx+ZUvKPdU80eaf7wugWngn/44BTnqztFfisopvDXpxZNDFhNnaKETOczDXOsVolwYtgrgWrx2ktiNy6uWS26Bkokcx0e6IToux5EvpOzcoRBlmNK11RJlCNX05pFBn6EWnzMInvnvr4fU+ZJMhCvCVoQmYiCmctmeCRufhBkZINpSUH+txCrJbiLWcgcu2armA4cVHlSWw5ucjlmQETcgZb0QWzVGijR1rB1nG2iiNGjgOAbW9iVdY6+T1LAA+0F9v1zIVasxRxRyMPuvIzFIaQ/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8269b415-fb04-4992-b2c7-08de807b0320
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:04:55.4961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clOa/i7S34er1xIZFIaIAqkcl8oJ8IB2vz8cRoZ83zXyZoXykiqxOGFtlRmXCVhdMBuS+iVMFwbqVmo2zxyjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC295640A5
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33158-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 08972279BEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> =

> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 02/15] wifi: cfg80211: cancel pmsr_free_=
wk in cfg80211_pmsr_wdev_down

> When the nl80211 socket that originated a PMSR request is closed, cfg8021=
1_release_pmsr() sets the request's nl_portid to zero and schedules pmsr_fr=
ee_wk to process the abort asynchronously. If the interface is concurrently=
 torn down before that work runs, cfg80211_pmsr_wdev_down() calls
> cfg80211_pmsr_process_abort() directly. However, the already- scheduled p=
msr_free_wk work item remains pending and may run after the interface has b=
een removed from the driver. This could cause the driver's abort_pmsr callb=
ack to operate on a torn-down interface, leading to undefined behavior and =
potential crashes.

pmsr_free_wk work is cancelled on NETDEV_GOING_DOWN, so this makes sure wde=
v is still valid when it runs.
Why isn't it sufficient?


---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


