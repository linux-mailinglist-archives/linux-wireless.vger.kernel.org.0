Return-Path: <linux-wireless+bounces-23920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CEAD30D0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B65188C5AF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972328134C;
	Tue, 10 Jun 2025 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbjTVC7Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFBC27FB35
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545336; cv=fail; b=R6QbQZNrrA19RPpFurTeHuUEjy4Kp9Yf/ry+81Qay5H2rPMESd10JhLQ7HTFHHnZJXxCJ35uCi+pFvbmPDqAoTcUkr/qY1npkLLQDbBBzSWPcC9YL7tvLxrTeJwlKOMug/ZQ2v46ZgZ/1XJUYWj80XDgL7EZbelmS85UHvZ0Xsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545336; c=relaxed/simple;
	bh=BQfaOrqzBSiW1dwsG517DvlT7c6eC6BPzPHDPy5b2C8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E7qIYg3kEyIAJyNCNypsLkA6t6bZ5Q7w+o1gOGTkcTTcuted3obfzRTc/SLcDlcSnKaHVpbbFGOA9YJsDs4JhKAoTU242zs1YUkSX/kbwSLUP/7NKGhDGcZOYaQ7knDfsEghygQxPOvyp5ZGq9itJty4feYoA//Pqx2709eBK7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbjTVC7Q; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749545335; x=1781081335;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=BQfaOrqzBSiW1dwsG517DvlT7c6eC6BPzPHDPy5b2C8=;
  b=DbjTVC7QqnUDi0YUyW6NF5/B28mIdUvH77Ky450mMAbMp/1mdN4l9Jbk
   ++XW/HjprFzTYUhGGT4YL0qQfo3U57NnhxfmXkwbPhcIide6L5SLx8X1U
   SZCi+JK2hWOUNCISK0ZrA9fMu2dFneTyT0PvH8fo3MF9TzTjUIBVeHGjY
   2/kpMpLLdRs+HWFh6FA9rbtmwIjGAjsr1mbWvKcS4CvX8ApX7x9H9EBLJ
   F/z0z+aKoI5znzJwHva+zdB2n8GsMIk0hBZLnEG6PbvsU3tBpgwv3ExgN
   YMw6Jjr2JP3PEOaRcHi7mo2jtJEMIcxcku0b6QDilIgQSgmy4kCHfc2xu
   w==;
X-CSE-ConnectionGUID: kmOtdBXWRPyt0uepKyNkyw==
X-CSE-MsgGUID: iGFuLJBsSyuuIwKIUgDsMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51354349"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51354349"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 01:48:54 -0700
X-CSE-ConnectionGUID: GFD6zT9RTgqa6YkTKc703g==
X-CSE-MsgGUID: X6nqiutmRzGzV96Rf2XTTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146685074"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 01:48:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 01:48:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 01:48:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.69) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 01:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3t/TLBRW+KEAtxZfSNPep1tQ0BZ3jhM1XbT/NBqqGiCp9iWgOeYWaeFPvFBDmKcnGFoO/58AZWFAP9pWPDunlAvSf9L8h6V7G+fVl6fvU4yuGpdX7+FHCXZFB7lK7Nt0ARHjN0WPqVuazU8POZcgMhTW1TBrWvFpWJZ4RQDWdV8X0KVwShKEF4ZbcQcq+LXA1rnE2QTctQ4R1RS7dx2KwFh1q0Xe98CgwgjkqnU9wOwb/cv5/S5kz1k7AaYOWAB8Fwcj3pPpc6AJabwkv2WPcd/OjBDDZrueyNDiGuhPhNWOyTAJMG9EqfIZkkeh3JNUzhwq5hc4V9Qt50o5ATiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jc8+RabKzZBfJgBGhVDR+oDprAE6qtz/TzuXUIgjKc=;
 b=pl4q986Uh/671ZtR1eTzD/y6sxufkhhQ7hO11SZzL4sexNJHX9C/uIu6XL4hbS0UFfuwR0qczlSoHfm7oS4RjKkTP6i72ulvd+QiosLpUzKftwmaIq4y7ctPWSfBQSXgxlnxvSR70jUSjyxk0WnrRe0F9pY6HLChEag9gih1VxtIgTQhD883/hX+F4/T4NZN4pWWqZHwm21aZX4SL7EEtd6tYiJH3B8L+xbv5NL1xmG8/HytHOREmMxmcl2m34IREbzp+aIZ2BdbUjiYBXOYDfyvysQu9J+BmRDacFv1Fgy9HL9BMUoRt4NtyrF+QI1/Is0OwlihkdUOTn/c9rN7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Tue, 10 Jun
 2025 08:48:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 08:48:08 +0000
Date: Tue, 10 Jun 2025 16:47:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>, "Roopni
 Devanathan" <quic_rdevanat@quicinc.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH wireless-next v14 4/4] wifi: mac80211: Set RTS threshold
 on per-radio basis
Message-ID: <202506101647.943b7c9c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250605111040.3451328-5-quic_rdevanat@quicinc.com>
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 5546d113-8685-456c-8fac-08dda7fb8641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mH+TiGYZMJ9awHfb5Y59GvLEli1JLD9Tej17grkL1l8a9xu/PGMLZbLwm/iE?=
 =?us-ascii?Q?r/lpZyymRpF9vmBaQZu8lr+XQASM11poug6HdBfGg3BbWSezyuSdlEDHA/U7?=
 =?us-ascii?Q?17eRRRmtLcsMN198T5Dy6Hh7dt9rwcq4aFPiyDTOAWj/ZQL4SfmDkoD1O1Kq?=
 =?us-ascii?Q?Ytfeacbb1M5NWW7/FteHjkar0UyvT2HFm1gkiglDvXm0SxTcRrGOWKWCkMJj?=
 =?us-ascii?Q?iFfwZ2skmfzo5zHHHqqOEHv5Y/klEIzQRsG509Ef3G6yCSgSrN9VYnXSWi2a?=
 =?us-ascii?Q?x32cFOtir/rlIStYiraXO4o9Id4Ulxs7p9KOEPnwgwaUvW1CXyhKc++WhjlN?=
 =?us-ascii?Q?qmjUZQ+ohAqgF+2HoF4fKKQSlJsHtShjswfse314dXfhKIfxLFFbMEdsZlsQ?=
 =?us-ascii?Q?9X5kF5YiB6NDB1ArJ1tt+dFhOQPTjQM69/oRo4H+lzY7muH2dyuQxHZXvH6A?=
 =?us-ascii?Q?a3Q2DHNvQki/PBO19L8jeGzavSRuzDW0GREeJ+LscUL454gxt1/Z0UWaTo8n?=
 =?us-ascii?Q?mSIqibwgc7yWoBjgkwoLWKUJHgHLxxt5wO79DfVN29AyAnkCv+hdxyDwXtz6?=
 =?us-ascii?Q?YAZ6JV6VagsZRUiO6Z7O+/OgmnngbJZc3v2hBxqVq7El3XPIg3tn+9LvmhWM?=
 =?us-ascii?Q?5kjjy/YPV29nMfnEBDsm834vBdqh9h3mhU3j1uuRryw3qH2L+AewO+QzxyPO?=
 =?us-ascii?Q?nIwfcC3CAtko2XwYYp8kYD9wpGmBzbmxgTUDV3829881qkWvLxPJHULR+nfp?=
 =?us-ascii?Q?TXFqyiWTdO/PqP2IDRtetfHOkodw+Z12YVIVWT7iLBSW1fBG+6zBEkePiiVs?=
 =?us-ascii?Q?A1TCkBJBtkL5KbSD69N7IOqrxOgayu56lATGGG5LQlKGn4f3eHsFaD2BvZpx?=
 =?us-ascii?Q?XfOwY1tXuVCsAlr4+WqQ7rK11LyjBdsxE7aUwGW2egE60yAcqDXedX4KbF4f?=
 =?us-ascii?Q?JQnCoASW2cIyjJe+BRX4bhNQbueL5YYBz+iJw9G0F+oUsHMMWSvZp0CpiYNz?=
 =?us-ascii?Q?DfMp5x7VvsoNirSq+csWSKjt4xxp5QIIp004Et++mjeBoUEY8ny3uRk42viL?=
 =?us-ascii?Q?D3ZerVniXhofsTBFU78J6bsgLZAFqVSoyJ+iLMwXZQndw2/Fivmit0Hph0lV?=
 =?us-ascii?Q?4cH2i8cwnUgaTqQkr7oGEuusJXfm/v7ldskDU9s6sZCUK51anwijRUxizPVh?=
 =?us-ascii?Q?RIvkODwhh83PUqsOT2FU4Ej0laCvjh5ailCmIJp4z8YYnvXCdsE60iattBs3?=
 =?us-ascii?Q?HZGPnZL6g8j6FZC8+UYCtivdKe4CVu0t8RDGYeUcghiQ1lAVrzUfdhaurWia?=
 =?us-ascii?Q?bmm7WWJ+1XvJpqmnzpktnnhrkEFg01BCLDE42sCGjOvk5rN3Zl6uovmWS4lO?=
 =?us-ascii?Q?u5g4WsZx5XQrP4ldUVZfIVMBFpsT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/kDHyRFnrI1kF3oS9v7RdZbMicec7oFdv3TZiIZnZuLUxm/Qi0tM9DvBNAB?=
 =?us-ascii?Q?8cKrLvS+9cNjANtdVzFCN4ZxtTnJYKcwkgFFE6lOgCobTodFhvYeSyoDcS0Y?=
 =?us-ascii?Q?+ZJjSugqQAMmigJIxI64liww2YmDXrRq9zv/mPijRhor2wqVteEOLkqOGCVM?=
 =?us-ascii?Q?odJ2/Hic7rp/5m4N7ccidCGSsIEouuyNOLC4Gtes3To1NyrOrnPKVNAza4Z1?=
 =?us-ascii?Q?3QgjFj8pxYx0ea1W4p6hdAwP9ljk+FszMqDcHjEvQVd1M9vsxT+5a0hYCzjX?=
 =?us-ascii?Q?8z0T82aX/zebatKaJCVxtG5207HPL+LuMFixLXfT2+/istK/bs6Hcx3O1yBe?=
 =?us-ascii?Q?xhsBJoUyw+gnDcCSUV9hoFzNS7+9h2Wpgt9jlMI9MAGfNIESW4VnYV66l7WW?=
 =?us-ascii?Q?e94SCQgTLs/rILlQFiRxN/VgnqvOqE1HgYsFGfVyw4/jRcr/aNosufxxsXqM?=
 =?us-ascii?Q?CcnDdYdm5/32cHTrO3csamoIAdMGsXtNt2Hr/ZfWjlk7KpXfMYL4QbWX7ubZ?=
 =?us-ascii?Q?YT0L7bRjggZkrCP83u/UvSiNdBJeiSSA2wI5mCm+AmrJ4nJVTg4SGXuLy7Fx?=
 =?us-ascii?Q?GcgVmtZSFQPpb1po0/UwUByPcFVa7BK3oPW5M3N6EaC+bgcsqb2Isq9HkNru?=
 =?us-ascii?Q?+86BzT3NCEmzPu/1e2PekV6cEjnmScbwKTAe+56fn54foZRw6LNeyP0i3AWZ?=
 =?us-ascii?Q?36iQyWBqpPpkjlT87LyMFYviwTdXdUdM76iPk5KrtKCF07wep2g4ZlMqrkwD?=
 =?us-ascii?Q?EJLQd8kSlfgk5ZLQIDTS/BTqc01zKFFZgB3MkQv7wzqNx9h2xAwDhVMaLP8V?=
 =?us-ascii?Q?KJxnfco3Ov7cJwr/1ZI+D6lfG4+l/7XFbjfHgS9ZKsY8i7eRXJRVfH8R2CKd?=
 =?us-ascii?Q?GzwZmOsOEKRnMsSYUZYxyRK1+N+OVwJiyQOsAgnIUUeBwsj1BeaRzvrWsLw8?=
 =?us-ascii?Q?fTANq/nN+mU3SL+1kbJXEYRzLiuDjDhrTrJbwO3m5H6HfoBMtlYQw/3SrK6g?=
 =?us-ascii?Q?liPDcUEpVpMN+RdRQ7hipOUxezIaPC2xVuCbFohoU0qeLbQMWdSMCjJq/EjN?=
 =?us-ascii?Q?LZaDir5R0FwkJ4nFHdqtkabPcYzBcSDTa0wJgkOT6/QaNfns1snSkQwiNlGs?=
 =?us-ascii?Q?8fk/qFl6pvlgkaNhyFRmjiq/rW5B0R3nucPAnmaJx4YHwX56tyArjLmaMJB5?=
 =?us-ascii?Q?B5IHxpBT4YggARhwePv9ZWcJXdYmeZolMRhjV9fYaNWoQc4/u1trkqq32iLM?=
 =?us-ascii?Q?6cKDh38j3i9YAZ9dNDMm9NHoNKacaoaIwo36e2SxiNfHAp0H4D9LU9I+u6OT?=
 =?us-ascii?Q?a6QpzRm3pSntiUMrVZkpqNuGN0hkzKtS35QSgus49/Cv5YrEb1uxlcVUiQ7i?=
 =?us-ascii?Q?/3dNidg7dz37Vq7M7a7XMxvRulsvpss322dzCAecOoJ8z7Qlq2ysxyzfv4B8?=
 =?us-ascii?Q?20Y11BVpd7F3CvRq14Y4K6YaS3n+b7Wkk2oOaMwFrtETeHidbnJJZZzXdl3F?=
 =?us-ascii?Q?97hg4OY6iZ+uuH7nEUNWPhIEpKvXnMy2JpdBwBxbvmeZpQUhDOKBa/N60KUL?=
 =?us-ascii?Q?kuqxrfhqJceS0PbBcauoRzrnQpxhx+KyX7yPti+Q8nb0rtXRO+Gi3GX/nCXQ?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5546d113-8685-456c-8fac-08dda7fb8641
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:48:08.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Zgde2XmpRmk+gPfL9gu0kzOHImm68/xsLnO4IAmAlJdRQR4LkJf5qUNI1NrCUrvBb94zX864+H3Zh0MdGm6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 2d9436a4ecd84c9924c6c7c9f0d7ecf70846d085 ("[PATCH wireless-next v14 4/4] wifi: mac80211: Set RTS threshold on per-radio basis")
url: https://github.com/intel-lab-lkp/linux/commits/Roopni-Devanathan/wifi-cfg80211-mac80211-Add-support-to-get-radio-index/20250605-191329
patch link: https://lore.kernel.org/all/20250605111040.3451328-5-quic_rdevanat@quicinc.com/
patch subject: [PATCH wireless-next v14 4/4] wifi: mac80211: Set RTS threshold on per-radio basis

in testcase: hwsim
version: hwsim-x86_64-b01c4843b-1_20250601
with following parameters:

	test: group-23



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506101647.943b7c9c-lkp@intel.com


[   96.637922][ T5597] BUG: unable to handle page fault for address: fffffffffffffffc
[   96.645465][ T5597] #PF: supervisor read access in kernel mode
[   96.651272][ T5597] #PF: error_code(0x0000) - not-present page
[   96.657079][ T5597] PGD 19b873067 P4D 19b873067 PUD 19b875067 PMD 0
[   96.663409][ T5597] Oops: Oops: 0000 [#1] SMP KASAN PTI
[   96.668616][ T5597] CPU: 5 UID: 0 PID: 5597 Comm: hostapd Tainted: G S                  6.15.0-rc7-01662-g2d9436a4ecd8 #1 PREEMPT(voluntary)
[   96.681254][ T5597] Tainted: [S]=CPU_OUT_OF_SPEC
[   96.685852][ T5597] Hardware name: Dell Inc. OptiPlex 9020/03CPWF, BIOS A11 04/01/2015
[ 96.693733][ T5597] RIP: 0010:ieee80211_set_wiphy_params (net/mac80211/cfg.c:3068) mac80211 
[ 96.701124][ T5597] Code: 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 0f b6 14 02 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 5a 03 00 00 <44> 8b 7d 00 e9 a1 fb ff ff 65 8b 2d 58 0e 33 c4 89 ed be 08 00 00
All code
========
   0:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   7:	fc ff df 
   a:	48 89 ea             	mov    %rbp,%rdx
   d:	48 c1 ea 03          	shr    $0x3,%rdx
  11:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
  15:	48 89 e8             	mov    %rbp,%rax
  18:	83 e0 07             	and    $0x7,%eax
  1b:	83 c0 03             	add    $0x3,%eax
  1e:	38 d0                	cmp    %dl,%al
  20:	7c 08                	jl     0x2a
  22:	84 d2                	test   %dl,%dl
  24:	0f 85 5a 03 00 00    	jne    0x384
  2a:*	44 8b 7d 00          	mov    0x0(%rbp),%r15d		<-- trapping instruction
  2e:	e9 a1 fb ff ff       	jmp    0xfffffffffffffbd4
  33:	65 8b 2d 58 0e 33 c4 	mov    %gs:-0x3bccf1a8(%rip),%ebp        # 0xffffffffc4330e92
  3a:	89 ed                	mov    %ebp,%ebp
  3c:	be                   	.byte 0xbe
  3d:	08 00                	or     %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	44 8b 7d 00          	mov    0x0(%rbp),%r15d
   4:	e9 a1 fb ff ff       	jmp    0xfffffffffffffbaa
   9:	65 8b 2d 58 0e 33 c4 	mov    %gs:-0x3bccf1a8(%rip),%ebp        # 0xffffffffc4330e68
  10:	89 ed                	mov    %ebp,%ebp
  12:	be                   	.byte 0xbe
  13:	08 00                	or     %al,(%rax)
	...
[   96.720506][ T5597] RSP: 0018:ffffc90000a5f0f8 EFLAGS: 00010246
[   96.726398][ T5597] RAX: 0000000000000007 RBX: ffff88817b9783c0 RCX: 1ffffffff85c10a0
[   96.734194][ T5597] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff88817b978530
[   96.741990][ T5597] RBP: fffffffffffffffc R08: 0000000000000001 R09: fffff5200014be00
[   96.749787][ T5597] R10: ffffc90000a5f007 R11: 0000000000000000 R12: 0000000000000008
[   96.757578][ T5597] R13: 00000000ffffffff R14: ffff88817b978920 R15: 0000000000000000
[   96.765371][ T5597] FS:  00007f4aad0fa740(0000) GS:ffff8881acccb000(0000) knlGS:0000000000000000
[   96.774116][ T5597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   96.780529][ T5597] CR2: fffffffffffffffc CR3: 00000000572c8005 CR4: 00000000001726f0
[   96.788325][ T5597] Call Trace:
[   96.791453][ T5597]  <TASK>
[ 96.794234][ T5597] nl80211_set_wiphy (net/wireless/rdev-ops.h:587 net/wireless/nl80211.c:3982) cfg80211 
[ 96.800233][ T5597] ? __mutex_unlock_slowpath+0x260/0x2e0 
[ 96.806737][ T5597] ? __pfx_nl80211_set_wiphy (net/wireless/nl80211.c:3646) cfg80211 
[ 96.813055][ T5597] ? __pfx_netdev_run_todo (net/core/dev.c:11350) 
[ 96.818182][ T5597] ? nl80211_pre_doit (net/wireless/nl80211.c:16887) cfg80211 
[ 96.824076][ T5597] genl_family_rcv_msg_doit (net/netlink/genetlink.c:1117) 
[ 96.829455][ T5597] ? __pfx_genl_family_rcv_msg_doit (net/netlink/genetlink.c:1088) 
[ 96.835349][ T5597] ? security_capable (security/security.c:1142) 
[ 96.840035][ T5597] genl_family_rcv_msg (net/netlink/genetlink.c:1195) 
[ 96.844979][ T5597] ? __pfx_genl_family_rcv_msg (net/netlink/genetlink.c:1160) 
[ 96.850440][ T5597] ? __pfx_nl80211_pre_doit (net/wireless/nl80211.c:16797) cfg80211 
[ 96.856668][ T5597] ? __pfx_nl80211_set_wiphy (net/wireless/nl80211.c:3646) cfg80211 
[ 96.862981][ T5597] ? __pfx_nl80211_post_doit (net/wireless/nl80211.c:16899) cfg80211 
[ 96.869295][ T5597] ? stack_trace_save (kernel/stacktrace.c:123) 
[ 96.873980][ T5597] genl_rcv_msg (net/netlink/genetlink.c:65 net/netlink/genetlink.c:1211) 
[ 96.878231][ T5597] netlink_rcv_skb (net/netlink/af_netlink.c:2534) 
[ 96.882829][ T5597] ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1201) 
[ 96.887686][ T5597] ? __pfx_netlink_rcv_skb (net/netlink/af_netlink.c:2511) 
[ 96.892803][ T5597] ? __pfx_netlink_lookup (net/netlink/af_netlink.c:514) 
[ 96.897833][ T5597] ? _copy_from_iter (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:141 lib/iov_iter.c:55 include/linux/iov_iter.h:30 include/linux/iov_iter.h:300 include/linux/iov_iter.h:328 lib/iov_iter.c:249 lib/iov_iter.c:260) 
[ 96.902689][ T5597] genl_rcv (net/netlink/genetlink.c:1220) 
[ 96.906506][ T5597] netlink_unicast (net/netlink/af_netlink.c:1314 net/netlink/af_netlink.c:1339) 
[ 96.911103][ T5597] ? __pfx_netlink_unicast (net/netlink/af_netlink.c:1324) 
[ 96.916218][ T5597] ? kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[   96.920904][ T5597]  ? 0xffffffff81000000
[ 96.924896][ T5597] ? __check_object_size (mm/memremap.c:421) 
[ 96.930531][ T5597] netlink_sendmsg (net/netlink/af_netlink.c:1883) 
[ 96.935128][ T5597] ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1802) 
[ 96.940253][ T5597] ? __import_iovec (lib/iov_iter.c:1444 lib/iov_iter.c:1459) 
[ 96.944935][ T5597] ? _inline_copy_from_user (arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:141 include/linux/uaccess.h:178) 
[ 96.950150][ T5597] ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1802) 
[ 96.955263][ T5597] ____sys_sendmsg (net/socket.c:712 net/socket.c:727 net/socket.c:2566) 
[ 96.959863][ T5597] ? __pfx_____sys_sendmsg (net/socket.c:2512) 
[ 96.964979][ T5597] ? __pfx_copy_msghdr_from_user (net/socket.c:2492) 
[ 96.970613][ T5597] ? xas_load (include/linux/xarray.h:175 include/linux/xarray.h:1264 lib/xarray.c:241) 
[ 96.974694][ T5597] ? filemap_get_entry (mm/filemap.c:1852) 
[ 96.979640][ T5597] ___sys_sendmsg (net/socket.c:2622) 
[ 96.984066][ T5597] ? _inline_copy_from_user (arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:141 include/linux/uaccess.h:178) 
[ 96.989268][ T5597] ? __pfx____sys_sendmsg (net/socket.c:2609) 
[ 96.994296][ T5597] ? __pfx_copy_from_sockptr_offset (include/linux/sockptr.h:46) 
[ 97.001230][ T5597] ? folio_wait_stable (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/pagemap.h:309 mm/page-writeback.c:3194) 
[ 97.006001][ T5597] ? netlink_setsockopt (arch/x86/include/asm/bitops.h:60 (discriminator 1) include/asm-generic/bitops/instrumented-atomic.h:29 (discriminator 1) net/netlink/af_netlink.c:1703 (discriminator 1)) 
[ 97.011032][ T5597] ? __pfx_netlink_setsockopt (net/netlink/af_netlink.c:1633) 
[ 97.016406][ T5597] ? _inline_copy_from_user (arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:141 include/linux/uaccess.h:178) 
[ 97.021608][ T5597] ? copy_from_sockptr_offset (include/linux/sockptr.h:51) 
[ 97.028106][ T5597] ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 include/linux/atomic/atomic-instrumented.h:50 fs/file.c:1152 fs/file.c:1166) 
[ 97.031927][ T5597] __sys_sendmsg (net/socket.c:2652) 
[ 97.036349][ T5597] ? __pfx___sys_sendmsg (net/socket.c:2637) 
[ 97.041293][ T5597] ? __pfx_netlink_setsockopt (net/netlink/af_netlink.c:1633) 
[ 97.046666][ T5597] ? do_sock_setsockopt (net/socket.c:2265) 
[ 97.051695][ T5597] ? __pfx_do_sock_setsockopt (net/socket.c:2265) 
[ 97.057069][ T5597] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
[ 97.062530][ T5597] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
[ 97.066867][ T5597] ? __pfx___fsnotify_parent (fs/notify/fsnotify.c:239) 
[ 97.072157][ T5597] ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 include/linux/atomic/atomic-instrumented.h:50 fs/file.c:1152 fs/file.c:1166) 
[ 97.075977][ T5597] ? __sys_setsockopt (net/socket.c:2321) 
[ 97.080749][ T5597] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
[ 97.086210][ T5597] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 97.090722][ T5597] ? __pfx_vfs_write (fs/read_write.c:665) 
[ 97.095320][ T5597] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 97.099833][ T5597] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/file_ref.h:215 fs/file.c:1189 fs/file.c:1211) 
[ 97.104085][ T5597] ? ksys_write (fs/read_write.c:736) 
[ 97.108335][ T5597] ? __pfx_ksys_write (fs/read_write.c:726) 
[ 97.113019][ T5597] ? ksys_write (fs/read_write.c:736) 
[ 97.117270][ T5597] ? __pfx_ksys_write (fs/read_write.c:726) 
[ 97.121955][ T5597] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
[ 97.127417][ T5597] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 97.131929][ T5597] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
[ 97.137391][ T5597] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 97.141903][ T5597] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 arch/x86/mm/fault.c:1488 arch/x86/mm/fault.c:1538) 
[ 97.146415][ T5597] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   97.152149][ T5597] RIP: 0033:0x7f4aad2edbc0
[ 97.156403][ T5597] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 21 fa 0c 00 00 74 17 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
All code
========
   0:	00 f7                	add    %dh,%bh
   2:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
   6:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   d:	eb b7                	jmp    0xffffffffffffffc6
   f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  16:	00 00 00 
  19:	90                   	nop
  1a:	80 3d 21 fa 0c 00 00 	cmpb   $0x0,0xcfa21(%rip)        # 0xcfa42
  21:	74 17                	je     0x3a
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	ret
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	89                   	.byte 0x89
  3f:	54                   	push   %rsp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	ret
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	89                   	.byte 0x89
  15:	54                   	push   %rsp


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250610/202506101647.943b7c9c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


