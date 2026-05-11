Return-Path: <linux-wireless+bounces-36231-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODHRC2nkAWoEmAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36231-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:15:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3150FDD1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCFEB30A902C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ACA3F9F49;
	Mon, 11 May 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zba9H2B8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1653FB069
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508050; cv=fail; b=Cmhna8DI69OIvt1d+OWjYLZ6SASRlocomT/O6y1B8KcbnV/H3cmTYJ50AsJt/XgKolO/r8lFc1GLMPjLpW4fCx5CIHwNPf5A3q3ji2czO9NYVbOtgrLYt0MVqEywc4KBQ50cO2SqIEq6ICDdErBhvFwH5AS3tueSM/VXG94Pgkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508050; c=relaxed/simple;
	bh=/lhy3eoS/er29hT5ZYQh5frGWRixo9AFC2S2iOi3D58=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pq/E7PCE1zEBG8ZBoHcZgKUysU5YYrXnZfp4JFQYmbmDFIoHcufQSMxVs8p7T3dp1WuHsY3N7PqHCWji63qFsUHWr52JCNBwIxugzBF7wrqn6hgMW1I2126oL0rvyK4eyYYCMsXHn2ADNoSMQiwcrSKk+3Ce75iTuogei/eTS2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zba9H2B8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778508048; x=1810044048;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/lhy3eoS/er29hT5ZYQh5frGWRixo9AFC2S2iOi3D58=;
  b=Zba9H2B87fQiz7a7Ln6XdE3xDal6jBx/9aXU97gax6/KQYA5IKFgB4kL
   aEsay3zWcKfYHgKcvmU4xSazzYrwaIKAZW7gvGcvwt6TiEaz/VDq4qmao
   TAPYmkfPjAnwSetJGEHDwflsZwpPDJFYZgrShUUtZ1g2UZKzSI5yYmFgz
   Ne5wXzFrguXiN5rkAuThtxjhKYlNsiexSZ4cCEVPz1tZRbtSP3ZFT4Nvi
   VATq6HYmUm9FgCjxfcggre4m7A3B/JMyj8IWZBKIZWAUDkRnDgBtTb/91
   XaymhXrFkmZDgPNPRVckR/q8X4WZ0Fki3yUHvz5kuIwpe2IHDm/NhRdHb
   w==;
X-CSE-ConnectionGUID: bUx2OW3tT4yMYSUL3Jopeg==
X-CSE-MsgGUID: UZSLQuQVRmmmzUkwOa3Nlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90494768"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90494768"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:00:48 -0700
X-CSE-ConnectionGUID: qBfEHV1ZQ1eZhoCJ4sk+IA==
X-CSE-MsgGUID: xria6zmtQGKARce8dJpRDQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:00:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 07:00:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 07:00:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 07:00:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovc50hjDq8A5a/yU8SPPEB7LCY+SaE0QbyxM0KC4ncQZM6GvShY4pWusBCffXXUwxT4ogEJcl3XiIrLYH6YwWoj/ODs5oEK/zU7POQZF3m75isFxW6WfUOK88WwHwS0vOuVFiTmFd2whrAbKutbkdjCz61T0VXL8u6awIsPw1TzQ3jkkXErcQQg1fJFjPrMNfjbFxANI2BZPLMWrvJMIJ/fEFi4t3bnfN/LTY6WQzIt0AvBojv2ztTdaDHObSABqLXZ7NwxO+MiaO9k1ofkR2zC7sniiEM4r3ZcQ5tyTi5dFrRVQt13CSx+fnY9wec2oYgMf8bVW9A+YoIthvsE4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaHVQlVJ65xwL0//La2nqb+nPInMyyVu/DnYBbnDoV4=;
 b=ZB/U+z8B3n3T5Zp9st6U2WsFgMXfReiDm7pfDv7pgWpBHMwWKvAG7tmNsp+cVbBFa9O8Tkr+NL16oJlqK23RD+7u8A+TfeU7dMJuyMS252TFMq7oKICPA8tIRV0pP6VI7j7TFx4RYvUFINYFi4YETdQqEAgh3YTNDrlLAYhmvaFVeAgjR7+rDaxhk1lbm+/Qsg1De/JByqjpllfOrJsnYsx1s6a0x/ge2ZH8OARufszjFGKT8v0QXoPc6EnRMtIiCYwS2840Z7drnghEplrhfevyBKwybMNk4rezBtTGQhNkHy6y5amLi9d02LXflbre4IgOukkVNt38w214BJ0jzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 11 May
 2026 14:00:44 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 14:00:44 +0000
Date: Mon, 11 May 2026 22:00:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Johannes Berg
	<johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  43ef5856bd:
 hwsim.nan_sync_srf_mac_addr_8.fail
Message-ID: <202605112140.63585f81-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU0P306CA0018.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::19) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH7PR11MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: b600d677-cb18-433b-f27e-08deaf65b156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|3023799003|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: JHSJ72J2iEKDqdP5p427E5Nm3/lvE+N9EGG8+PD6ImfZJIzzNbBVNO5e85ObsaQv46GzeDIoJEjLIY7Y1Z/srjB92KcMIUYyqE2riW8d4gs9eZnt13AOXaDiOCi390qEJBAWN+2rxZJ1wkJF6x3I/sJiTP/liCs7yh3hOTW6Xn1t0kAaf8x490UENzuUZHJU57gfNPwLLqyKstpocpy1qWfz1jQwGhNZDrZpoTDTq5u2akhpOo1DIwxEWoRdAQIwncOCPgUNgyUc/3GBIDMRm+//ls7TzpbKUexG6HCKBf6nrzN3DG5h6pAS7RvUoNrfoXZxCfG02pAgBir6C43+vk0oNdmLWbLGzS1Q9ZDGyy2nd1AWBUiihuEOPX8fM1V/tOedqHYO7Vfeb4YYFfHzKGALDgmIra9187/wet57gVqWS7e8aQnxYPAh9rDsozIuajI1H0Ufu3BG7i+8b7DgQgq/JBDUMvBfeNPsCmqHZRaKwq6b7mbVw1NqKw/D7cTh320dvyPRRiv227l8ObhT5+f2kQifAPM/OpnXjCITgtg53jYov8GRxQ5S2uuUdBQILeEuKuvs1HW3CDO/iV0idfMH8KU3Z7+It1Mik3Wh1hAMDT53uGcVcBvVhWfJ2AeCD05gmEl2iruZfuaE4oYN+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3023799003)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gdbk4gX+dalAEG0ijF2QihMGlHn7Lg8dDgNI2KxG0d+2SOioQ+SpN7h7hxMt?=
 =?us-ascii?Q?AHRBLGuQlla36uLbgHwO453DWGoazSXgz+iKzfg2DOmcHMmuEB5QIdTjfgLi?=
 =?us-ascii?Q?pBYkMf6MGovGPr0+GTC1Z9WRrPfsAZZ8meV/UR2O+yKjONGhClPz1bE9KfNV?=
 =?us-ascii?Q?oHqenAIPVv57oTE8KFu32lxN40KHu+nHK+MOtQisuD2kQi4xfbAKfJUTln0R?=
 =?us-ascii?Q?oR0sfDF8YELLT/OQILwFrlkSDvnfSNLNBoy6jW/r9gwsBVzMSR8Wlg/KS/lZ?=
 =?us-ascii?Q?NFh+93xUZsfVUEUPeRSn1rjRFQVgwH7ZaGMDNlTlMNYXdcllMD4fZWy+ohAL?=
 =?us-ascii?Q?Cks6DClKpNmauON0bCcuN82yBwFDEOn6cdscHo4+GzsiO8JK3LJ/oTvz+UWr?=
 =?us-ascii?Q?eRIq8Ux+oVKEY+d6uVGe8BjplDLnZtYoV3+l1E2THrcu0F8ZjllJVc1V2Dao?=
 =?us-ascii?Q?4c12rO1sbA5RojFeTUPnRWvdwQCktkxn7rN04qlEYE+3ybwllkisnbD5/ztA?=
 =?us-ascii?Q?n7AlK2boG4SZnnxttxoXTMKWSP+6xN7x/kjqG6mZQW/pachc1lLsMYoalndL?=
 =?us-ascii?Q?LfkihJJ5R+F9lXzOfvx9ubu+9niOd1B+TrD0/rmJ6ESksk96yPvmTMylKgAR?=
 =?us-ascii?Q?zf6um54cB+b2LeyToI8iuzpG61WWExzowXi3cD/8wFL8eQqIL4n0+pLXS2co?=
 =?us-ascii?Q?1YxSjIHif0MprrMLEkYppEvVJ74YVAg/U+3ELv6uITXxsO1PosYjOHa0rMfP?=
 =?us-ascii?Q?Aa8f6KlnaPj2jcFXZe/2q+4yL0k0FSXb/nFBN8vQLOcWdIiazdPicriCqHjs?=
 =?us-ascii?Q?Cy3mJNNHq3EnBpw7xc0p2EfsokbFTLzBm5qG5J7Y2S61fzMh/hASA9fI0zsi?=
 =?us-ascii?Q?lbj5yANVYlJVlRdYriZBbHA/T1smHxE1utMXzjI2wG9bvplqeS8BSEthQ8c/?=
 =?us-ascii?Q?Z8awch9E3t2OH+gBHtt79s+iq8zstmjztZch64l3PuIzmqdbA8boDUemN5Oe?=
 =?us-ascii?Q?ipA8QW+XnCWUuH0m+qOMtjOjpcfLttJMXyxcID88+fj6Ge54YhMHUQbm/vCB?=
 =?us-ascii?Q?Ydf3L/b4L2imvUzvzW/HwbNM2qH8VK1InTrJUijLqsfjWskP104ZD2l4BGNn?=
 =?us-ascii?Q?RO8iHS42QBJfRhogy5LjOTgaMZ0BpyHLTGy5/W5Epzk+cxab0qn0BX72xsnP?=
 =?us-ascii?Q?eQDbJDAHF+CTh2qD8+Ng/mo99Ib1R1CBFmQpSTt0LkjB/LBiiFlUmwqayNF/?=
 =?us-ascii?Q?6caqjvoOX4EWPXP2j/xzsHJ+77H2KwH9midj4A/BZEqEDYU81rZEQE1rTPfB?=
 =?us-ascii?Q?IJ7bGhq3moKqcoAxVnhfzJYZjzsfRv7cGOWFkLMSlWvV8ydsrKni6f58fW9g?=
 =?us-ascii?Q?89ojF2oF3W5PcAdHhyDRciLlt7YrR3CtGAzPpG9Q2Smi43zHjTihokRygyh0?=
 =?us-ascii?Q?rv17WEhNEZVXhU5jbQhthfVKO3c6Yb9JfyVoxedS1hBiSGT7PmS+RpqSuGFr?=
 =?us-ascii?Q?nesUqkMYtrAJ4zQKiRLdXV+bw2F5wIFhuk23DU7WknnV+HhKZd8mQJ6O0lnf?=
 =?us-ascii?Q?y1zFj0C+ktUHdaFl7oRQgE5AS5PkgPgnN81ASlPvSjctE3E7l2wty6Tw2ScB?=
 =?us-ascii?Q?hu4k+l3Sy77VbtKLvEXDgBsM7gpixD6yblY8tbM7/fATfNt2IVAD1yM+GKY4?=
 =?us-ascii?Q?hW2/LbDJoBVRePe1fxXfmjzWti4ERCBvPI0FL7tchiX0/H+txWiOlkaNTV71?=
 =?us-ascii?Q?aaGLAFF+Ag=3D=3D?=
X-Exchange-RoutingPolicyChecked: ITVaIvYsR9ckSPPcjiCFV8uc5G/NmMfM5MNfzW7Ivv6+ZzqvEOhOCbmQ3hPX95WWQ6tg5CHwtpsOTtYVK4E4SsBmrstXxaiAPQKFCTlhktb7x+I2AVUccE3p5ZO5+QAW3Ml+YCym0+c95MG4D4bOXIZY8IOCPgqVTcV57xpQPaKgscnUF4hmgmR/TJ0AeJqrgA4IAyW5zsGCG1i6zuUESM7Tpy6kPZwpyEMcitYX1PSOMXiFgAmCparIjxx50W8z/bJDYWHTTkdrq6ECiO97epfxPZEzaae3H1JEovpeEsJdcATqxfM2GC8EOuYpuAWoG2BjMs5y/e/7baPJaUwgAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b600d677-cb18-433b-f27e-08deaf65b156
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 14:00:43.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75MW3foALQANrZLDJ+tee5Q7Z0G5T34jQMX41pCQDNhWEx0Tf3oeW6nnEtAFTlr01az/gxDgO2Bj9FWtF3eiow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 31B3150FDD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36231-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "hwsim.nan_sync_srf_mac_addr_8.fail" on:

commit: 43ef5856bdab300acc90ea2c3c437f5535a5f66f ("wifi: mac80211: track the id of the NAN cluster we joined")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 17c7841d09ee7d33557fd075562d9289b6018c90]

in testcase: hwsim
version: hwsim-x86_64-d255d20c8-1_20260426
with following parameters:

	test: group-30



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605112140.63585f81-lkp@intel.com


2026-05-08 01:31:52 ./run-tests.py nan_sync_srf_mac_addr_8
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nan_sync_srf_mac_addr_8 1/1
Test: NAN synchronized active subscribe and solicited publish with MAC address in SRF
NAN capabilities: USD NAN
NAN device starting on nan0
Setting master_pref to 10 on nan0
Setting dual_band to 0 on nan0
NAN device started on nan0
NAN capabilities: USD NAN
NAN device starting on nan1
Setting master_pref to 10 on nan1
Setting dual_band to 0 on nan1
NAN device started on nan1
Cancelling publish with ID 1 on nan0
Cancelling subscribe with ID 1 on nan1
NAN device stopping on nan1
NAN device stopped on nan1
NAN device stopping on nan0
NAN device stopped on nan0
Exception during test execution: NAN-DISCOVERY-RESULT event not seen
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 633, in main
    t(dev, apdev, params)
    ~^^^^^^^^^^^^^^^^^^^^
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_nan.py", line 665, in test_nan_sync_srf_mac_addr_8
    _nan_sync_srf(wpas2, pub, srf_include=0, srf_mac_list=srf)
    ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_nan.py", line 560, in _nan_sync_srf
    raise Exception("NAN-DISCOVERY-RESULT event not seen")
Exception: NAN-DISCOVERY-RESULT event not seen
FAIL nan_sync_srf_mac_addr_8 3.097871 2026-05-08 01:31:55.539483
passed 0 test case(s)
skipped 0 test case(s)
failed tests: nan_sync_srf_mac_addr_8



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260511/202605112140.63585f81-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


