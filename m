Return-Path: <linux-wireless+bounces-1294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEF81F396
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 02:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A8EB2148C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 01:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1CEA9;
	Thu, 28 Dec 2023 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3YhqkNW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EE15BE
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703727059; x=1735263059;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e0zv2Usxb/ik3v0+zS2rRpOJun0albQ1D0LpwgZp4Uw=;
  b=Y3YhqkNWs4IpmVGIlDgae7phK0WXPDb1PRJtDwxQr4OEMwE1S9wWWT4T
   +2ZL7fPdg86LibZvQq6ooSGMzY7/GWgOdBqw93IIUCaymqrHwuEEv53lb
   JTp5/quluAuez7gLSUl35tDpp1SbHL9JadoBfhU+9hFO8lhAn02lqxiy1
   lf5cGHhw2bmKcio8uaoxEtE7hVJrIqPWzuRYylrRoXzlglq8KQnvlmaav
   USHmWkjLoVcQGpkd5+IqU3wKsarxUg/o12gf7fCLN/9akOVPawKuzigZS
   drKhAMECAwqlBJ7/81PZ1po+AtOZ+Z93srFtJzeVt6Upzx6Q28dD/7LDy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="15166276"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="15166276"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 17:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868999450"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="868999450"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 17:30:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 17:30:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 17:30:57 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 17:30:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihl24Khy2xeiXA5lhmpxVJ/VdBdzEvCkn+QO3iwmhMPuux7fwnAkWGQEG4jEWc3Ty1dMTY5S7TcTqi71U3XmAIKu7GtXunQAmqlm9SOeppe+jIfgNtQrTvYVo2ufSMVrVI1EtSZr6B06EvFa4pPyU97lnnge2UmKaCvzCEy1nfh1GZRWg4hlQ36cmdTE7XJKGZbKFcgI3xMffiyTa87SvyiIdJnuezqidEfS4xxbSWfth0Mt1TupWHSiNKKUQj3iOhKeojEXVedcpNqkZIoYU01ItuQDqzm0LSIK2Aw3/YM68ReJ/KN2WSCwu8CH41im5FaORAOVnqlreZUN2gk/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlHyRnYiTQoorhg3BEOKbSIk6gBae1cSSTHsPPIiW7E=;
 b=jC9cLE2+B5KLT5BETdSB8rHmb4Nd+K5F5RQoHt9Wtar1xOLFeiWZ5vv1JyC7TbTw8k2HAgTkKi9F5ssGyaCBDGnlRhpz+4tCxQs5XPdG2CLLj09+pqLldb/tj07coTv0kjsAKqd6Hhjwm4azHr1QEFrhncPRa4i1f4mqZmLvuO1gPhMMCGQoA+h+IEANfVQ5wcE9gsMnoDFCxNiITNUm/8JgHMZd0bmNhbrpouJH9HXxszIAdsXsQPPFH3nfNfGdhnccFI5ieAVyOMNfB4T3hyRdsP1CaO/EjjwzkhCqkfvcHyCUY3zE5mirLaNp9McoQcJrXH92syeBt3fe+lj/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by IA1PR11MB7388.namprd11.prod.outlook.com (2603:10b6:208:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Thu, 28 Dec
 2023 01:30:48 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4ad0:937f:995f:3c95]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4ad0:937f:995f:3c95%6]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 01:30:48 +0000
Date: Thu, 28 Dec 2023 09:30:40 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Gregory Greenman <gregory.greenman@intel.com>,
	<linux-wireless@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [wifi]  ce10e8653f: hwsim.prefer_eht_20.fail
Message-ID: <ZYzPwEPSpnV46QeY@xsang-OptiPlex-9020>
References: <202312271555.3fbe1cf4-oliver.sang@intel.com>
 <4274b2d3892f548f3a56fd6040d4a9c1109069d8.camel@sipsolutions.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4274b2d3892f548f3a56fd6040d4a9c1109069d8.camel@sipsolutions.net>
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|IA1PR11MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 926294b5-fff8-488b-8341-08dc07449e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUSEEZvT+9btmoUEy79DpyKsMWY2Pxm0ZqGYLAoD38LuSeAhFyXFDKBHcsV98qsuqisf4YEyPMSQlWe0CGB/NiqDbWNSGX36x4JSnLk+8vwD/Cyd1yS3NDxLEjkziTHUP27DlIXUnPFQC+SORwxCpEMuzJccYDDjyFbsXaX0C0yiJcJV35aPeeJH5nzJdA6WuHiWSaQpRuEPDNllyCD209BXANCcDMi/5eY221zCx/wSay+IbK5MuQLYg5h7AH1rbUyVBtVQeFbVJrFgbQPXWDo7aT5jPGBFeVOd35kZlLF8JbQF2oqu3b2BGdNeGskzDwu4Zz16VoRZY9psqF2xK61yqzSKoPVM0Nm3nrEmb3KtlCrrjILfr/DTpImpbUJc9j+KjdZYuMJFX28iN/nXO9NDTj9sKsqnX3kPT4QuUWXRQ0Ue0/AwAtM9CRC8cKoHrZ4klNHlybh9R5dV2g2Tc7FNCQQHurflFLOL2nfc0ImoHROoahVldFJS5rUzZDnxeuslrdQd25rFctIGHkUb/u/Gw24dlJ9ClBTfF9qFFE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82960400001)(316002)(33716001)(83380400001)(6916009)(66476007)(66556008)(66946007)(54906003)(9686003)(8936002)(4326008)(8676002)(6666004)(6506007)(6512007)(44832011)(107886003)(478600001)(966005)(26005)(41300700001)(6486002)(38100700002)(4001150100001)(5660300002)(4744005)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HlByKK9uX33VtZvK+Erx46HvYdWJJLq4cvGGuEDiCqChfb+M40FKWM6yYKZV?=
 =?us-ascii?Q?l9BkBJ3RF/97Zi4sBADxkqztrQp0SEVI1RlXF8hdheQZC9BDaCxCnBLvcMC2?=
 =?us-ascii?Q?p2qGh106gfwLsKpoxeP9EhGfCH1ifierFDbNss0Ddgtu39VLR2/Hs1DO6UmK?=
 =?us-ascii?Q?KXaxWBdcBoK+hKBA3jwudk6Xk1MHghCdljtD+Quezq8k4KpqWn6hRIC1xy9n?=
 =?us-ascii?Q?uNJSoLkZV3uTJ/qkNouUaLNlzp9aN/ELght+Irl/Vantce5/pykR2ocruhJK?=
 =?us-ascii?Q?wzdu3AiC37zMZbWph7Pwtk0/cJ75bNUw+il3G8IqNLlCOiNGByjlGNk1i0ds?=
 =?us-ascii?Q?enKb5xHBhZPhTg34OQ8srbo+xftbqGnkmi2JAKfOM2QzxTN48b5Z9VbtHI4n?=
 =?us-ascii?Q?bPHsvd7BhomTzJ85IDYIUcQ/8/1xwnz5BA6kpPOml5YXoGSnTs4kkhGOVsAY?=
 =?us-ascii?Q?8i6wD2T2DKzOelbn2UYMAZ4OcxGUCvPIeZP8YYlwrrhGimb8qmQLHWkOiC+3?=
 =?us-ascii?Q?k4otewEFRxnzgzqT6aq+E2/MVpvoZlbYgGTxkceHfhrz2Gvu5cvUxaDwj/dc?=
 =?us-ascii?Q?8zs+JVsk4stDqC//0WLmTwb/StRAkOMwwDnyYi6SYcI1v5sZuDhgDLZ8JyZu?=
 =?us-ascii?Q?dqZZ8qKAJEb+CUJEzvjXrQXcroYfifmk+z18gc4BV3l54PRAlxHG2l98mOst?=
 =?us-ascii?Q?1J4gotcsasOKQ2ywKf22DsbLrAh2/k+JxDEql+pRddFJqWtZTO8fh9EQIOPJ?=
 =?us-ascii?Q?3Rblm4wz4SJFWtByfbsOYLHYTfEOzzshyWIGesGe/dn6lFvGKHMzP4SkqO/J?=
 =?us-ascii?Q?BemI/5nzl2gCi/5Mb0e1LnmlnFUAt+bL3MspVpdfCqkJee6HgKBX6ogosVuh?=
 =?us-ascii?Q?YLwaj19wJQ1icnIHmXBHB1zvkZ415d55wpa3/jQhTtG/8C1pNC0wuFS4+6xm?=
 =?us-ascii?Q?oiaJcJiASYqZhsf0qJKTFx1LrAZq1a5Y9uLuIEfPotH+WvXrHXCk21/LWxDd?=
 =?us-ascii?Q?hhGaBdDqapMdVPeOCO5jq20HQKLUTXFivU3fovUFtshME1DwJYGKMWTHToW3?=
 =?us-ascii?Q?QlBPIgpjTZm3+wbmZSjB2c1UQ+Zd0EaWImVgSiMNFqOsKPoIfdPfd8HoqGP0?=
 =?us-ascii?Q?u8yMNpyiSaoSYoYo8kWWCBQqkbwNsN6dTHhX0bxlHn+ZXWGFXLaDkBvKHe9g?=
 =?us-ascii?Q?798fHDqZFbna8JYzEtxe2G0TIAzuZ6/L9Ycj9U3dZfjiJOvZ96mU4xy44r2B?=
 =?us-ascii?Q?40NjyV8uV/lUTq5t3rNO5WvzP1qm+++00gR0ywPLHSJ/eVfrQZ3Zod6XugNz?=
 =?us-ascii?Q?1QvlsijRw5Ldm4UtcyJMERwqxaE34TjipPFQjRI/92Qri45OOvsAx0gno0is?=
 =?us-ascii?Q?PjiRv4XIw0DCtIc3QkqI7IlNZqngbCrlyGRqrM0dvpkJRXw60an0lGtCCy+1?=
 =?us-ascii?Q?6ZyAx8ZMdlVcWOSrfF8m0ynHNj5t4e4MCltl9GEWcCTC/DxkaSjr7AwAyykf?=
 =?us-ascii?Q?xV+bmP2ppmpaQiT8Axv4LDm90H5OXDKcgMz9rvzgEn0wDtNj50Qkymb4EeyO?=
 =?us-ascii?Q?aGfrF6TT5t3yFYlnv1zBGQxsVdAbZrFRCoF1nFrPBDGAShQ8AYyH4TIg62P8?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 926294b5-fff8-488b-8341-08dc07449e7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 01:30:48.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMGrS9lvzAUHEt3BvQ/+5WEKoa/56C0cKiAL9NvyqXGqGVXfpHER6eF8XxLavsTgrEoiHAqM8afQ8LHHSa2Hsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7388
X-OriginatorOrg: intel.com

hi, johannes,

On Wed, Dec 27, 2023 at 08:18:25PM +0100, Johannes Berg wrote:
> On Wed, 2023-12-27 at 15:41 +0800, kernel test robot wrote:
> > 
> > Hello,
> > 
> > kernel test robot noticed "hwsim.prefer_eht_20.fail" on:
> > 
> > commit: ce10e8653f8b6569ea5d4f96917b5eaee7437072 ("wifi: mac80211_hwsim: support HE 40 MHz in 2.4 GHz band")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> 
> Known issue, should be fixed in hostap master.

thanks a lot for information! we will update hostap.

> 
> johannes
> 

