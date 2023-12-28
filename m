Return-Path: <linux-wireless+bounces-1307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79081F902
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909DE1C219B4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D678826;
	Thu, 28 Dec 2023 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/B9ZrSD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200E882E
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703773009; x=1735309009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9R5CCwPskwu/CSqA2mU2eXSlSSBfb3ftIlpKbkyBJLI=;
  b=N/B9ZrSDLKDMVZ10FJpSeNFYGH/1vhQYfGTxCmv0igT9lici4Js9m+iP
   zaCzKVrSqBezmyMmrefXRy0rhvpTKMprkUig55P/bC+7EtO8kRvtKhHSe
   NdRfviL2Yg+uD37MRjh87uYSIbpTHEa0Xw3z6SX3JMCjnMB3qAxM2lsk2
   9nwmM3IOBU8B2y3UshlVInO+1v80brWZtDfc2p9UeZVq2aTWjP8lErNf6
   b5ATjs9SnDiKX9IJj/KE/7bVS1yxRlEONitWUMk/m9KBxZfYaSElXU/jU
   r/C8QdjS53vY6D1LUrDym4xspDBobxVAkqeitsVgIawWzALRPBAIA6Dy2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="460870758"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="460870758"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 06:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1109898001"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="1109898001"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 06:16:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 06:16:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 06:16:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 06:16:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 06:16:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCEec6kvPiw4JWzRO/LhYP3jpYl4riuEbpXKn1fHH7AM2ACTJcfCVW7Ut/m4DKoVxQqhjXl3p3R5DmuKg0GwaQHJLbroYdlxvAi7SbpFLv108+b+8JO7dpp1e+uzPUA83wKltx9UjD54FMfjz5P0U7+/40H5Xv2Lsr6y3ZQyHftsZ0M57CfX9r2P+1egPupFwHkD5iRV3MdGxAH/vOwIxEmYovsgDrEMsxaC/SSFaw4jrqHt+Na1DK/cu58pceKNmIbqHcsi9kZBd1I3xrEqqenzn+dp6ZmLg6ZrAMZ5I/P5NEZs1FYTeJbnHmn0SGfghY459Czr/xGptOlbcwuOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDySgJoFAbngkpfgJKzdwSMf17fdEOE9obeYP1obv5Y=;
 b=OOEowZkU8fhogO+Hf3ILIDBqpkvvWQp6RV6wir01cIZwKcpliWHTnxXWZ0AFsts0ooDMs0dXwiheqioEo0wZdsVoMut4KFGoO/LNNm9utWgNSPmt4qTOOlFW7TKrTSDO9ZSjk4SD+CgCRUcBd3y5j8CsFuFJ03rUuz4okuB/znhv8vFo6p1N9oqj5VhlN+JBg2PYBpeeI4Q3ST9D6C3BOd7kZ6K5+rNVT1ozo7eCb5p2wSPOEeM9Ciqa9BQ21yr4fAgJThFjnfgd+UxjaeyGEKSvreLIbVbasKejB1yTe50lyrEQJpHTmoeZeceenCJe9+UlfCAKLCZIse9HI8ImCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Thu, 28 Dec
 2023 14:16:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 14:16:45 +0000
Date: Thu, 28 Dec 2023 22:16:36 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Gregory Greenman <gregory.greenman@intel.com>,
	<linux-wireless@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [wifi]  ce10e8653f: hwsim.prefer_eht_20.fail
Message-ID: <ZY2DRJWIzeXz5wGe@xsang-OptiPlex-9020>
References: <202312271555.3fbe1cf4-oliver.sang@intel.com>
 <4274b2d3892f548f3a56fd6040d4a9c1109069d8.camel@sipsolutions.net>
 <ZYzPwEPSpnV46QeY@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYzPwEPSpnV46QeY@xsang-OptiPlex-9020>
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW5PR11MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: a554da59-d0d5-4ba6-7f23-08dc07af9ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FMdHhxsvaGRj1GNDt1g59/Mx0V0ioeiICUO6CXWvVoe2/L6o6cweeg9TMfuK9Q/WfSrlWddfM6BYUsHLS2vTn97u9cG7mA/fEEFEl2yLYa2GpjnTBKoTltOD8KMK46U1ny4sp6KMB9Gw9IuG4/wwt6OH0L0nboIgdzJV4JiA4xXSD/yln2x/rLvFZtrACsB5iVvUKnoLEfxjFljUZww7dITbz2dcFRVSkxYyYA1sJAErxZdZbmPwHtjwfmahaEwBC+X7frsffqq+alI99uPKWTgBCk9aH3Li7l96hUj1wUo6REIQUpARtzQ2pIgvBh5u4F7w0tiZPClyFwSRpGYYDa/K045sJOPGcQ1uY7MAUwd4HVVytpHUagwdFHuMIOCdFPyek9NiOXR4IbgCaRkKj6K+gYDh0cYvDggXHbNwIEZBbwP3jefFvhvFUBQf+7VIaUWJKq9pSy1DRjZUb7M/1FKw1bQ0wdtefdp17bA/uy4aZiVea5cocq0o5vPShmtBYvEquVpJdL01r8ccUNPk//bdbNoqA0pQg6osJKj3HU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(107886003)(6666004)(6512007)(9686003)(83380400001)(5660300002)(44832011)(4326008)(8676002)(33716001)(41300700001)(4001150100001)(2906002)(4744005)(8936002)(6486002)(966005)(478600001)(6916009)(54906003)(66476007)(66556008)(66946007)(316002)(86362001)(82960400001)(38100700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4qe/qviaDii2EPosk+JFbJZBPdWpvRCcO1fI+Ah/vfmMiCfOZl89dr25Iyv0?=
 =?us-ascii?Q?uw36dV2oGiHHnL+W7NEFEl2fPqT82zM1yGD50fzb8kdUMl9ez1/rFsXhvXJR?=
 =?us-ascii?Q?1taguB5IaPWL2awrrM29oX8rJmlWcghSrbclXQG41wtPDKF3TezApw7hxqAr?=
 =?us-ascii?Q?xCh3Vqh514FGaZ3iEpZDagvPDCCl7qTye6oehiAL69QS4Hab/yAf34wO+OWS?=
 =?us-ascii?Q?ebf+hLlfiJYw1Tu7Mn9Jcayq/LJNcDh4bWnpeD8lYm6wf6YYwTH67ksBzG3s?=
 =?us-ascii?Q?rnI1tOLgKNmr3kjqiy7aO26JizpnNi+FjBNLxngx3F7+drudn1Z1hrqFF0Q6?=
 =?us-ascii?Q?vxT0EYMrYtxn755almxRhnIGAvqhs39l/65bl8MP4QWV+RtbW2z+jgtRZjDg?=
 =?us-ascii?Q?83P5nQt+qaDxv3IzSIE9++trQ8rF2WJpius76Br4RjObbYDqEHatF7BFloti?=
 =?us-ascii?Q?8Go1OxV2OKJ8d+wsylqBqfK+SHRMjjpbFniGpZdE9j0zV6JV3/9tJ+uJOgfb?=
 =?us-ascii?Q?O9s4h+/q3sI65A5W3q/bOIUEoU0g4GgUBSf16E5teBh8a2i9ovvEGBxR2Iuv?=
 =?us-ascii?Q?rDc8sENmgBsIgb8EetIX6TtlmfYzEn8D3VMnFMr3Wyi4kr+QyAW5RH64USd/?=
 =?us-ascii?Q?jPbUs+PR0CfoFaoWKkSgd/wUTCErkEiKoI7GpQhw1kx91TVWnhTPLIL8tiuH?=
 =?us-ascii?Q?IZM/Zs3+sfRTfXjcZkk9UnqCNOr8z9WQNb2m0U9U0OdfLD+jEcplu9avsbAU?=
 =?us-ascii?Q?9hssY0xOZ6p0a+VTNYbifUQfVfmMpKkjO2KOs/scG592ug6m1RtbMJgjMfiU?=
 =?us-ascii?Q?v16EOlB4yG9VD9EcVLl2R/1eQbXojg7qP5uWlq7A4gyUuWab9Gdd7yUII6Lj?=
 =?us-ascii?Q?/Vbick5/NgEmGCN0pdF9joXh5EgAtBtRKYwntzxj7bTwKRX0ZJtwa9JDbxkK?=
 =?us-ascii?Q?1TFNxqxxSVZRW4jVMdXQinscxMwg56rqMvsH9teVo4q0rT2789ypR/7Z7C2U?=
 =?us-ascii?Q?+3ih5uJCOSCU4VvQV1OgSJKAX6z1D8mHiWlaJ9LcQWd+0YeYt0PUVjLKIQsQ?=
 =?us-ascii?Q?+yheeb9k4xJBcbQ0mFyP12uuR71CVdMBl+lAniMrjczVfnagAy34tUmB/gip?=
 =?us-ascii?Q?80X8Lc5+w5et5AuyKOahqzYvGjwynmsXkilJDMw2IBX0wILsxR7gbVR2Pbeo?=
 =?us-ascii?Q?k7Hbn24rXo7jYzofjNIWdtDfOYHzMokTJnNWltPSt5P0wJKr0GOmlllFNf+Z?=
 =?us-ascii?Q?oZgkEYlw83PcXFptW2l3O7vnhr6lpfwwsMOAVUBliapNPfd/7V5MawXTX0lK?=
 =?us-ascii?Q?TSnk+ZwROvUvFa9a65YaEHQWsOYB5tZVjz//L9Yqu3KUoR1F3vUuE3nSeXza?=
 =?us-ascii?Q?5Q5dxPgy+8q/erzNmnzJqwIZtxpmv9iuF63qVFt9HjbFQl0OvhpQC28rOvUK?=
 =?us-ascii?Q?4t6/Cg0Ag7qFSzoX5Kyoismu8cIPiKN40s9j0laMpwb7aHAETR0Aa6vz/R56?=
 =?us-ascii?Q?D36gTcs9TVnmpnZ1NNi8fXrkwL1+7IV0ta6FX9FU34NnDJdDz+mJEdHzT+LW?=
 =?us-ascii?Q?7giiOPH5jUtkbVyWlz3UZVx0YPNyMG62XJiUuxis?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a554da59-d0d5-4ba6-7f23-08dc07af9ef6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 14:16:45.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHtNSaH6Dd5dQstGPPh2NEHAo8Hluk4fLavaoQFUBC4uDXDeRxqmLBax5Y0Vjtj7B8ouI9DC9WNwbcDzQz0+BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com

hi, johannes,

just FYI, after updating hostap, the test PASS now. thanks again.

On Thu, Dec 28, 2023 at 09:30:40AM +0800, Oliver Sang wrote:
> hi, johannes,
> 
> On Wed, Dec 27, 2023 at 08:18:25PM +0100, Johannes Berg wrote:
> > On Wed, 2023-12-27 at 15:41 +0800, kernel test robot wrote:
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "hwsim.prefer_eht_20.fail" on:
> > > 
> > > commit: ce10e8653f8b6569ea5d4f96917b5eaee7437072 ("wifi: mac80211_hwsim: support HE 40 MHz in 2.4 GHz band")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > 
> > Known issue, should be fixed in hostap master.
> 
> thanks a lot for information! we will update hostap.
> 
> > 
> > johannes
> > 

