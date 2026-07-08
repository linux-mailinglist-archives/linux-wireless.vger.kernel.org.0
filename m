Return-Path: <linux-wireless+bounces-38786-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zcQ5LKxTTmoTKwIAu9opvQ
	(envelope-from <linux-wireless+bounces-38786-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 15:42:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E1726E5D
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 15:42:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=D5O0e8ku;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38786-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38786-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2755F302A69B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21037DEBF;
	Wed,  8 Jul 2026 13:38:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BE37C925;
	Wed,  8 Jul 2026 13:38:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517902; cv=fail; b=D7AUBMYE0TdNWrDhnF9dnSY7WGKiK/bhevVE0xq5m6uHepw7ZY7mc3XJ0bwXYt+cgWaEJP2dPVfo+uqSF8mnzzCuqDMuGYamdQtu3q+u1dRK8NUt1TMV1e5q5GN/Rn0ZjUx9vrHycCVFcwp/YTDmiSzgJDlhq3AWJyGV6QSUeSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517902; c=relaxed/simple;
	bh=LfEor8WV/jDwgi7i/qwkqmWw+wew2ooQPENfpGAqIDU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ep1kse+0KmuSpwEyOIknUKkb6qI/bAr52bOhEhr+Tk/LtVzxmnqxEOkt2KbAkpgKIRUjkJt7YzpBI0MNh5WBy3Gm8z0+DoAlKrIyZzMV73qwxCUnwbqeEGcUb2XVEWjrbGkUTJtLXd81ZzFjbwY+C2P8Y8YyLJ15ufOZ0uxXLLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5O0e8ku; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783517901; x=1815053901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LfEor8WV/jDwgi7i/qwkqmWw+wew2ooQPENfpGAqIDU=;
  b=D5O0e8kulZFHNQBJlVqYqfHfld8VJuGdtXwSK9Oe9mcx8QIj8dNDjnPQ
   ul6cHg+v/H/3cpvfeiJpsyq9NPjo5t/7XCrNZWkZtqkwdT1Y9RDj/48j8
   RSEO9jL8Itbiver41GEVSfkzdXSpZxjO/RaSKBfJ5UYfIiCFM1Xu9+q7v
   LNCk7RYTQEO5lx4IPNxU9RP6RhUC0qemfdeQ/19m4wzVBWiHDpF/jWo3t
   Gkht9pUE7/WzS+E+v7cgDvBBXHmlPXQK5PYUrHfvP0tKfomarmlN2sxif
   5sjOY9Nd1npVNmifg8C5PagrqCS4Kk8PhEbyv8Z/CsBrT6tsz41t08qJy
   A==;
X-CSE-ConnectionGUID: hDN5YV85T4CO5d00Q/A2pA==
X-CSE-MsgGUID: 85Rr3PC0RWuHj3KF1BNzSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84370673"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84370673"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 06:38:19 -0700
X-CSE-ConnectionGUID: WQWibec4SJKkODCKonM1CQ==
X-CSE-MsgGUID: 0AZu+V2qSFieOxPWtlDp4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292484740"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 06:38:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 06:38:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 06:38:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 06:38:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRNuDuRlAXDvoKfh91OLoY/L3oEr7kHuirGb3HC6Pp9xjdc0U/5kk0mwQD68rRpwFwxXJM0S04eWZMX0weLcAhu8nRPy3S66WcypLyS9lVMhmDAOf9PXa6yFqF+wDFUCtwFECjAtNa6OUpaDLV8cFY8jHFGU/4KFfVXo7vdomdOjeMzeMPAbOBRwMiWivC22Y5WrNrnglmPeXDO2FsnE6Ytrj+qLcGgTZ00RKhprWkGj+miWpbFxmroF9oKHoDyUpaTQaeMHEMRSQTofFjazugMqA+EcBBU3EjgEjY7H725QS0oCuF1phjvGWskMYviqWUD6hUSBDJFL2rELxl/c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM0x6259x7dlWDRCudIZKzO3e6niKKRlBHGl6Nbeibc=;
 b=XNEpAqiIWy00vj7IOzvOer2ZKhrMVwB9xES4PAjtCDSby2CsPFDBmYcuXFQ/DfDwW5V5CiunB/fvVjIsxOedlS8C2NHVaBlqi04Kx3nWqfcE3ePgjZ8tHSHgFuUXq/EApxNxJdAxtjolcBLgjPTYHyEiA3suofZh5gDOtpAlmYsnX6bJwLd+Ng9OuqcCVOEU6qJU2R2lGag0oxj+g4ZXctBJzVm8VEnINLAXMYEfUfjAdkcKxAKGL47RveZmrakoKnF/6QIIVFjySYyu4Yf0FwRddRd510W7kW2L9iH2P5S877EQhGWzLmpKRTx4kIKjT4dmzytwAzbHWvlB+XK9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 13:38:14 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 13:38:14 +0000
Date: Wed, 8 Jul 2026 21:38:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [wifi]  43ef5856bd:
 hwsim.nan_stopped_on_iface_removal.fail
Message-ID: <202607081635.d6385138-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|IA1PR11MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 5049308f-f0ae-40d9-d088-08dedcf6290a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: tLeOmpet0Km9yU0xT/zUJtAgobWreZVT4X1uT4NkVrKl5MvK3rDy9VvoY4H3AmH1yV2hyZNZ+crjjvF14OmT7BHBjt9aE9TfjKUCDGVjBykK8V+uMyxWx3g2dl76vT8AOLmCw0comuZQp6ja3EU9Lt/wx6G7IyabnNSedevJWo4V1a8m215/tmIHKYwH0+yMrtkTiPvNqh3cPmkKtKdOyVIkS/taUpJQreebvkI/waJ1rcwEZuhTdXB0ucASy3CeniGAy9LznoaMQuRLJDjUZ75kdKsuMFREs7MRA5UL1nKf98r+Bw1teMWT3PQHEg5mv8Gzu9F3ta4RT/NMV2++CUWo7mCL9L9zCCk86CEjnji+Z7JIX9UhD4sYbpE7qXss9cEAN1LJYyxX3VjKwp8h07sjB7CUH5L3Ls/giHKPiVV9H//04U8INRJkU0ePMs7azVSVjJDV2rH5IK46jxUT1SgRpFvJHS3HR0Q3F7DTqyeLtFQwD8J28k+qPObtRMwPkdm2zCyXi4CXs/BQxry9pX3GISkO8szYqX41rtM9i2Ryo8uj30LqKLVBHP1cPnF2uoFi3zE11BvCbHW+DKgeMbf2gDFpxP6GNnJMjrjrnd2CgOcoZpHnZ30oCHMhzc3A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Cpyxojxu8SVo0QIIp5YEFZPfl7mteV2qhDeOtp1BDO9W1VnGBpNcqo742ON?=
 =?us-ascii?Q?VaabH9+n5tbVRTGpBp1Bhe4fzWcBn+st+Mcb/1/CldgbrvUeykJokaZjq4N6?=
 =?us-ascii?Q?brsR9f0QnKP1XCQr7zNmV7p5ICHV7uywjc01lAxG8o5c0BSTMtjl5Rscui3a?=
 =?us-ascii?Q?QlUXwspVVTTCzVOMxcQrFiP6hTBt9bxHqPJplyQrlisdnutLbbmNndUGtZEz?=
 =?us-ascii?Q?D4VKMHDm8PL805U49G/Gfjj6g6I86Z5cC/loDzBa7Aj9A8WyAJ6IH6iZRdXC?=
 =?us-ascii?Q?QRX+6F2Tew7YskDK97PujkUWc4ahm9qLoqOl9ombP4ccSUEN9pzTUo857gFq?=
 =?us-ascii?Q?4MdUctbkfBuvOaxY8rI3y0u5sViclvNEjBhbgalxQHgeGYRZjjYf3WcoFMMp?=
 =?us-ascii?Q?XjfylS8oxIGh2TVvozy99p1T05LN/8qpVO2NJwYh2+/TaGk6sTlGc0oC0aPL?=
 =?us-ascii?Q?CvQEiCeFH73Xi10X3/RWqNNQq8QRp2NVxX3usCa/uGZqxDvPqBFArqxBaaLJ?=
 =?us-ascii?Q?gr2o7R34QpdtXwrXhR8Ln1/3Wdvn+DFrYqZxsvMG+w2x6iMvkNxZuMawdeCe?=
 =?us-ascii?Q?Go98La8eKWjeDbwCm9jxh6DmW8iLpcjocdiHRxOGUdKQh+SCslcnhiZe6MP3?=
 =?us-ascii?Q?BEe3HplZWxcw3u3yLy51xqxKYFVciqunTMdhaiG8gWlQom8g58VsnN9dpVdI?=
 =?us-ascii?Q?+vzbcsEP6LbqmRygfM+n5aqZOtzlVhFbv8OhjhhU7R6PhRUMB2PAUpxYSx8N?=
 =?us-ascii?Q?QcbbFEvER1AXDR769x0ECLRLrw+q1Cg5SP+qPbSbK0pHOdJ1b4spsDxX+VoT?=
 =?us-ascii?Q?kvKg/M8Uscn4CcPHqc1oVNzzcmnsSd+A4R6eJrQLKczjqt80YDr0vmX6q74l?=
 =?us-ascii?Q?di7g1Loi2lRSU+Cko5XYGMkNYNaiFGR1sbUbz2kUdSyl39k3D5emBg84hAwv?=
 =?us-ascii?Q?a+H9mkGQ1aA81AMclk0p43PDaKVA0Uu+5HaTfktq1NQ2ws6ncT1E8fcvrI15?=
 =?us-ascii?Q?pwOtmLy4NdrZsWrJqlNpkJUoIQc/z1tWUVDEFuaErfDK4rsfDY+ToJF9GHZL?=
 =?us-ascii?Q?e5f2U78G+lCC4T9vbmgOPh9OykEsa6Nq/y8mZLkGby04OrFVSIXLQEiqwESp?=
 =?us-ascii?Q?wBWhBg3GRGjgOJDSjOUGaShejrleeZANgw7xgPmbl1+y/J6IBJaToD5TV0YI?=
 =?us-ascii?Q?gZBNvBLV5vO2AkuN+DilaSi3UOu+2PDOBzaecCs7YjHIW3y7FdUfiYEQ1tyV?=
 =?us-ascii?Q?fjOEKa3EMT71q0gBJEqV/vFfdxtbvtDMvy0K5JPAiBoNAxx5LKuwxkrs3kDA?=
 =?us-ascii?Q?3VxcJonh2G/hp3bDJuo0SORShsH4mzvD6Tw4Wi8uOoNbDE/cnqJZNvc4qIEL?=
 =?us-ascii?Q?nWcGjoaZ6Vnrzb8cZxtOXY9LS8jEaxuRn6/hX5gkd4/P6Zx+xVZE0wggHHtc?=
 =?us-ascii?Q?FeUAx99FOxd9HdLDIiygtvMCKPfHqx2UHO62MQ3iuOVpwCX0Cfx4e8UkWzYR?=
 =?us-ascii?Q?vS6iWOMHi/ymPS7bUIVfr2ITeMlYhp8/0FcZWUPo1ZFs0eW/2cbrmkEsHF+p?=
 =?us-ascii?Q?O4r1fFtCyMLHPAFQXf431scjZnIkOyoXb+uct72KXORwRVov9sLcIC6GV0Oj?=
 =?us-ascii?Q?pCRVZQdlsl30vBZ0aZqfHAaeDeUQhzr7kN50aEWNxhG2IELAlbqLn4hzizgC?=
 =?us-ascii?Q?ii0Mj2jfBJFRt2KZii433yseLVZ6WZwlzieYOlWPZap+ExCyjWAHT+6e8Oqi?=
 =?us-ascii?Q?jPndmXSbDg=3D=3D?=
X-Exchange-RoutingPolicyChecked: fmjzQ8DwrYJTTe7xXZsLDiPDhY37h5+pF8IM9DwttxKJ+Vnw3RqaU+roCS439LOF56EcLPY4z46UyrMYGKlotydcusltTT07W1epcFy9/GU6DKGintFJhJJcA8sbPOK2wmM75b5C5ZPYMQ5YHooCOqjE9+bT8TE0S2Bja5vadciIT9VFkKMlMeEgxg7OLCy9U5fLYxC6n2qHYQplJh41aWLg8hKEYigGtNgmuSQVSSXgPWDQppBi2K7QqW+D1X+HlGYggJxBjJCqseMjlUj8qDQO0ZyBP5HyRM+U9nNYdNt+TAFyJXlwbZoyhlJ0ZX+fT+fuCWA6/grYpNUsnk+DAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5049308f-f0ae-40d9-d088-08dedcf6290a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:38:14.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz8Gf9Z+npqJiYREEFggXPsU8/PGYbeiYeKufwymkEkh8jgVTalDumD4qOUVg/hY6Em1q2uXipQP8aumzEEwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38786-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:linux-kernel@vger.kernel.org,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:oliver.sang@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B5E1726E5D



Hello,


we reported
"[linux-next:master] [wifi]  43ef5856bd: hwsim.nan_sync_srf_mac_addr_8.fail"
in
https://lore.kernel.org/all/202605112140.63585f81-lkp@intel.com/
when this commit is in linux-next/master

now we noticed the commit merged in mainline and we captured it cause more
hwsim test failures which can pass on parent.

below is just one example FYI.



kernel test robot noticed "hwsim.nan_stopped_on_iface_removal.fail" on:

commit: 43ef5856bdab300acc90ea2c3c437f5535a5f66f ("wifi: mac80211: track the id of the NAN cluster we joined")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      dc59e4fea9d83f03bad6bddf3fa2e52491777482]
[test failed on linux-next/master 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc]

in testcase: hwsim
version: hwsim-x86_64-890d573a1-1_20260622
with following parameters:

	test: group-18


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607081635.d6385138-lkp@intel.com


2026-06-30 08:17:46 ./run-tests.py nan_stopped_on_iface_removal
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nan_stopped_on_iface_removal 1/1
Test: NAN cluster and discovery followed by radio destruction reports NAN-STOPPED
Starting NAN on publisher
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
Verifying service discovery
Publish ID: 1, Subscribe ID: 1
NAN device stopping on nan1
NAN device stopped on nan1
Exception during test execution: NAN-DISCOVERY-RESULT event not seen
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 633, in main
    t(dev, apdev, params)
    ~^^^^^^^^^^^^^^^^^^^^
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_nan.py", line 2195, in test_nan_stopped_on_iface_removal
    nan_sync_discovery(pub, sub, "test_service",
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^
                       pssi="aabbccdd", sssi="ddbbccaa")
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_nan.py", line 396, in nan_sync_discovery
    raise Exception("NAN-DISCOVERY-RESULT event not seen")
Exception: NAN-DISCOVERY-RESULT event not seen
FAIL nan_stopped_on_iface_removal 3.09572 2026-06-30 08:17:49.477478
passed 0 test case(s)
skipped 0 test case(s)
failed tests: nan_stopped_on_iface_removal



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260708/202607081635.d6385138-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


