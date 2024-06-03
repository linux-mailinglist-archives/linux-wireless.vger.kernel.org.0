Return-Path: <linux-wireless+bounces-8406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6248D7C58
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3742822ED
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6640847;
	Mon,  3 Jun 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbKy+ACO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743B48CC6;
	Mon,  3 Jun 2024 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399271; cv=fail; b=jggWRjtZauwi7QNvfkEkd5u55WHzMGgFgBI7XYZH4y9lGf2/UV+NnA2I02FqYR4CaLWtvyY0O057MdtfMoRcKl5Hb226gX7eUUK7/zKG+K26pwbeSM9rlnNUXaRoafhq+3jQuoQKYknD42JkXVvtcpto643XH3BhIBN0WQuNFOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399271; c=relaxed/simple;
	bh=s+DlywGaVIoHDRJtp7Eb0YEGmn9TgA6lZPS301mIuqE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ut5H0xAMUWRfk+yqphvFwdA50lZxp7ZtUd4w1m7pPQy303UI6G77KNBNTillQsIXawzzY7q0iU4u7xxmYHujztkm1kRcofADpkp9KbMabBcPOpqqA7vP7/Oa0Jmu4oA+cPbWOOJMTsc57KVPaYe89VULpbWs0ULteplZQbN7jGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbKy+ACO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717399268; x=1748935268;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=s+DlywGaVIoHDRJtp7Eb0YEGmn9TgA6lZPS301mIuqE=;
  b=lbKy+ACOG//BQVJLiMyRHb0wcq6I0MG+2wEiFhSzUiE4bV5bCKqJoi7q
   LZfRMWtBZGs/j4geiPnZXg3SKrC17CGm0xrxQ2NiwFNwIDqQUPYZEOvsD
   RZsuZMpWKLwLC5jtB9YEFNvwol3nbW+81P5LK/vgskRMOqnRwApmNn6b3
   pC+SLJFvZHxAu+Uq0g6d3ZnH05SXsbz1xlh8wRdnQERHS+0TX6NDbQ8Np
   n0bGR+1qQloOwYOpxgWjqggJKHWHf8C+dyMKZslJdXRtwbbCOexoeibjG
   Q4DIhpdvKiS9jwOrxQTLCo4MZYl828W8HTenTwz8qw6Jf2JymBuRA8WBE
   w==;
X-CSE-ConnectionGUID: UGHo72bvR/6wuPl2uVxL2A==
X-CSE-MsgGUID: KALJt7W3T42V9RrkyxSwOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14039304"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="14039304"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:21:08 -0700
X-CSE-ConnectionGUID: 9spVlBG/SbGnw9mMlGAuKQ==
X-CSE-MsgGUID: 719kk609RlSp4+MBjfxe8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="37388505"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 00:21:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 00:21:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 00:21:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 00:21:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 00:21:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpvrUmpxMLzNaDZQGhYaVCnQPiIaPJbPSAOFm5Im55kvvhZlsGKQMrJ5ORiI6EzsX/zLtjoIP/uhA1UqfgCiXk66pcUHEl0ItNd3d6r9ALbrKY6clNp0izaGQC/Sxm+dUnJiXIcyX7OhfxJT0+4YO0DZw7hG3PIPGp/+3hePUGetfimxC2m883M6TFgh3i43xfgdNRb+k7kCHFJH6FWF4I+4g+lwVrWCAPmDvZcRXXoy9NthWA0v7RpRR1p+79o9Vn1CYVOAqKsY3/L+RBTnMQTaitaJ0HUrZKte6DyJaz8wGUHflDBEoik7aVCuFwDb4mD/0uhBI82aV1etb+qocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MqsarY+MV6U8OAY0qbzc+kTzXVqTPKXkanPda5OWwg=;
 b=XwPaYRPNB2lUhYtsrlc+Faq5LCUg65uRAOpCdou8MODbFLF26EmDQAY2riLxzUABSZOBsy4d48B4o0H2FQw26GAO5h6g1DVMCXtbTAaN1QAMinqhAuBK9hcW2gc3a6y3DAtahdabJTUliuqCK4CCn7kDjQ+Z+DntoPelKtG59kYySZMq0a7QTgW4Z6KXUL+CeaAdiC9c+pF35F7mU578szamSD/FhmN7fSQLxDndRAMOaFkuitIVY6T8NPeyGw5BD3iz3/3477O/PemtF94X6xyjB4Nmwp6AJcO4khJOR+J86EUIgTRYZRRBk7Sgj87A3KEpaUL6jt80hzMHEXDtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 07:21:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 07:21:04 +0000
Date: Mon, 3 Jun 2024 15:20:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kenton Groombridge <concord@gentoo.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Kees Cook
	<keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
	<johannes@sipsolutions.net>, <concord@gentoo.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2] wifi: mac80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <202406031527.5530f205-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240517145420.8891-1-concord@gentoo.org>
X-ClientProxiedBy: TY2PR06CA0036.apcprd06.prod.outlook.com
 (2603:1096:404:2e::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a0be18-68dc-486d-1b49-08dc839dba95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EojBqrYoftR9ii21u8pZJeEF/s4q/PjbA63WYXev+wdJgWouiYZSIYrvu0SU?=
 =?us-ascii?Q?jmdmwyu0Ja5Ntj4SvSQOe6rLVocFWeumTqHYinkTVJgWSU7A3iW9L7T5Vqw/?=
 =?us-ascii?Q?aIQJHpAm8gUXdedeBs+yoSt6XHaHYUgEhhe+L2HsQRN89ToPV7dCoZdFqchl?=
 =?us-ascii?Q?sTZLgHAZv6f1Q/5D8ojH6NWD50Oupy7CbFcqiggUTkdnzjDyaqCvNotzG6Lj?=
 =?us-ascii?Q?34RFwsdblX9XcWefHi/b2ajPgypCx6ZS4/6bPUs2hZN2LDtjBl+Fw9O2CkkN?=
 =?us-ascii?Q?LwIaaaPCESf9CsIinF48XhbxSg307n+/d43Kox9yw6dIkcCus68qWsgsLTFW?=
 =?us-ascii?Q?rtHEgHJ0pzFvhsXLbV5W5AcEgo2jawwy+4PzfkHBghD8mTYZJQWSEHnts86J?=
 =?us-ascii?Q?WphyaQ8mOrlMGsgIDPnGKEGdIqjkhZqGSEmIBqWKX9HMmrxt2Jaj4nShGfDG?=
 =?us-ascii?Q?HV9SdytPMdfxjtch72/XSVb6W4Icw4tIGIOHErH3KJvXg1j2fDBg7jpZe4uz?=
 =?us-ascii?Q?IqQPz/rtrcx6FxyL4AaW0jjv7l/KrylON6VW8bUfrDHpc7X4gWEvRCSIhw9I?=
 =?us-ascii?Q?cjN50Q0q5qK11uJZe+JN28ClhCPumB+0BqWCE9B6/qZqLzQ0bDAROmGmxgOj?=
 =?us-ascii?Q?iMFpGOjQgsUpdehM+jE+WkJesZBVKo71BkclR2P05Rm3gdXntw6DcM8Ok3Af?=
 =?us-ascii?Q?xf2wflAdL3cqOFvL17zYwD+7xPf13Js5rkgd090xWaKGLJ7WO1GAhZfD6slf?=
 =?us-ascii?Q?CUq63vj50/zoWnTRypoBuTf1Y74lgR9UetZCr1svzLVIVseYSnwJALTKJmoB?=
 =?us-ascii?Q?O6HCktTOCFuKvL9YFD8NCZSKupRAZzawDo347ZL3YCKINMXcp51PvFL3ypLg?=
 =?us-ascii?Q?oo4SHx/m70yWZYmjriJppHqNjWDzcNKPqH0DEsjhTKRJ+FrT2aIcayKV6IDR?=
 =?us-ascii?Q?jYtWxpCyRxkZjTsEJOtpYtJKXKy1Xaf0Mk0HTvj3BypbaBscRe3EMDmC7XeY?=
 =?us-ascii?Q?xMwYXPqxHDL/SY3qYjWV8REjnpnc/h0k1hPLfAF8pZ0zBqLlmeuyGAJ8rTWG?=
 =?us-ascii?Q?KcRCTjH+CELgfw/UIWFyD5YpGNxKVO3v2xnZJntx6s0XmP/uOIO1RlsS7ykc?=
 =?us-ascii?Q?FrP75FGAnK/488Ea30b2s6L+bXaydEP2vqA4Pt27u40bwuRt3AKMG4nUtdwF?=
 =?us-ascii?Q?y9eTrmxpjAK0ztzIOVzB5N4+QL60+LZ5bDoVh1ufqQTo6xw48rsWW5Qi5vc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oAM4XtVlS/y+L0SaRC1LkAXkftuwBTIGLidSgHL64xUi5ObZIC9M8T7/kZFM?=
 =?us-ascii?Q?NNY1b/lCugVCfbQcyRDzJ8/C1AHXv5ifTVtPspkr0b+NTFMQFxhjCv3n8YXF?=
 =?us-ascii?Q?BWVneLrbhwg97HMaHi7BG9KhZt9tFbtDWQRTJwdHlWhNcEVXOotmLNz1wVJv?=
 =?us-ascii?Q?tQKwvgK+kwht3gubplRUsYkp8/Sh2uswozvkUE6cAKo8ubCzVmlJHS9IVhW6?=
 =?us-ascii?Q?cB7M6zau5A/2b60rOZ0K7Opo+qHRdbF+KCETz7RrBcnClYbATm+lJe+CgiW4?=
 =?us-ascii?Q?BS4vmPakgWQtqisv5q7tDsNwcBxcW8wfa0BYVaJr+CTCD1wUCylHDUZxeowM?=
 =?us-ascii?Q?MqGwy2MB0AnZcIm1drkNu0mAxpuXwTeZhfvqeCLrHVcw5g036xAxyqzemLkj?=
 =?us-ascii?Q?odt+eJoFxNUXanOmy9TdEoEg0v0sJbEQlzGR05EqfuT5m1cuzmCNnl2DdBrY?=
 =?us-ascii?Q?UGJmFfUCwNbludrMHTeXJ14vXcgyn2cjJ0dCaaa8Gtr9enV6kvqqqnBSIY1p?=
 =?us-ascii?Q?7D71IafJYA7RQMGICYJUDPT9wbdckUktqzY8chOMhx85MGhh0i/kZXr4O5HU?=
 =?us-ascii?Q?zNMcNFY17q3/DdEh/GR9MKmEZV2fWp6H7zOavzoMiZyTSf0Gb/mvtd8cB1jH?=
 =?us-ascii?Q?WCWnK4GcPdfe/ZVZBDH164TqgKo8q4othUhpHqa6luT2f6qkS8st3SJZXING?=
 =?us-ascii?Q?konCM3bX8c9lVrFp7rxrTuvKIJ74VoaNX5Dh9aMQhBRcQPO8Qtt8TSd+rRrf?=
 =?us-ascii?Q?cBmV5FWnt5aRCaM0ioxKwdycSy8YB2WjWlx7iEJI93ZaPEv5FGMG9XilkW08?=
 =?us-ascii?Q?+14Mn8RjNyDp6uJTe9kT3QyNv5bdUh9Cz30ZwaQ27ImFJYiNHpydpx+LgdKW?=
 =?us-ascii?Q?tFlZO3KwDpuGHwhlbxMxS3tmvChHDR5GB2zHqhBOAKjjltGUxqsPYMgC5jsX?=
 =?us-ascii?Q?bk0HxE3UnYY9naVNMIHY6YKKBQJQ4vfdQLOJQRpBcU17+NAJ5xp2pZmHAdCG?=
 =?us-ascii?Q?TUM9EE/I52KMUgzNST6oLOZ3qkwgomEj8Ip2ZyCsVnTqJ7Uq0tFTfPeE3Utn?=
 =?us-ascii?Q?MAZ60zu/GTaYadjsZl8rHsqpB0kjmDo0RtFoNUHf7buZSAEJBEX6mrA+QBjm?=
 =?us-ascii?Q?J8mWSVqUhYl42s0i/02wi1K/SVP20Ateqcc7uVRf9Wia7r7/MgwFHhjLBvMv?=
 =?us-ascii?Q?0Nsq0v7s7QXKQsrXYjLz53ssDBLzbOeehDJrRTa2Sz3k/TG/PMoa4N5i4ssR?=
 =?us-ascii?Q?hR6LZ0ZkO1NodKKDvNaNWDhi/B5CLS8irKZcWq/Y9JNJ6GVYjOOtSHbEoY8m?=
 =?us-ascii?Q?NOfyPqNQaErvFXsqOVsBYpaFmBpxvGqvImXqa3Cvv/EjpEWACMCHz3u2siCk?=
 =?us-ascii?Q?tkPZbXZZVuh6cAtVyaZfrKTKx/mIqm+b77uMUDsDFzgFVl3rFsZINVMk0jhC?=
 =?us-ascii?Q?Yj2KLmO/sn2FnJ6lJrZWKVdeYC6gLXvbegRmLA5JlRAqDfT+OUK6/WaeiBYi?=
 =?us-ascii?Q?bnJJjU4vgUFEqlJlpPXNB8yfA2a7q89T87OrereSmVgnZqzuCx/0ajif2hlH?=
 =?us-ascii?Q?jCci38PPEceO5EM0VwzDuUiJBEY+pBNXZsrSrAJOH1KOp7ypamPgqWLw8F3T?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a0be18-68dc-486d-1b49-08dc839dba95
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 07:21:04.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BobLyQN942fEmMkBIC6fQjoDhouK5Iy3F47u+yr1T8u8bc57/yUMKexM9VXURSD6snOQgBGTgqwTEw7vGL9p2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.autogo_force_diff_channel.fail" on:

commit: f68b86b282be59dcb687700c3b9ede5cd16e36cf ("[PATCH v2] wifi: mac80211: Avoid address calculations via out of bounds array indexing")
url: https://github.com/intel-lab-lkp/linux/commits/Kenton-Groombridge/wifi-mac80211-Avoid-address-calculations-via-out-of-bounds-array-indexing/20240517-230100
base: https://git.kernel.org/cgit/linux/kernel/git/wireless/wireless-next.git main
patch link: https://lore.kernel.org/all/20240517145420.8891-1-concord@gentoo.org/
patch subject: [PATCH v2] wifi: mac80211: Avoid address calculations via out of bounds array indexing

in testcase: hwsim
version: hwsim-x86_64-07c9f183e-1_20240402
with following parameters:

	test: group-14



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406031527.5530f205-oliver.sang@intel.com



2024-06-01 05:33:00 ./run-tests.py autogo_force_diff_channel
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_force_diff_channel 1/1
Test: P2P autonomous GO and station interface operate on different channels
Starting AP wlan3
Connect STA wlan7 to AP
Connection timed out
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_channel.py", line 444, in test_autogo_force_diff_channel
    wpas.connect("ap-test", key_mgmt="NONE", scan_freq="2412")
  File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 1153, in connect
    self.connect_network(id, timeout=timeout)
  File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 506, in connect_network
    self.wait_connected(timeout=timeout)
  File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 1437, in wait_connected
    raise Exception(error)
Exception: Connection timed out
FAIL autogo_force_diff_channel 29.021569 2024-06-01 05:33:42.767850
passed 0 test case(s)
skipped 0 test case(s)
failed tests: autogo_force_diff_channel



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240603/202406031527.5530f205-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


