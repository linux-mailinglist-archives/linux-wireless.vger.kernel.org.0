Return-Path: <linux-wireless+bounces-23559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD961ACC8CF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B8F3A7520
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2AC239090;
	Tue,  3 Jun 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrPB+IwV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB023958A
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959709; cv=fail; b=otIAN3UaI7jEGDMYn81HkJ1ffJdbWZFVZ+QHbg7Um9/i9yKeEjhVRKI7x0ca7hn+mEvnhgtpfyVL5Y8xF/o5cObvcvkwA46qbKswqS3yjdSbD4/5Llxbf6Sikv23yRH3b1BUoPOrhul8a6BaqxPCwyivWItlBzbCIMvF+1NTCIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959709; c=relaxed/simple;
	bh=xLqutD0N7QOTu6wHhMRPSoabAi5L4ZAu1uaEdQ5GeVM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jDUtWmzTXTQ3SwZ9D+CfyGUSfVvCLVfU+DN7ru8Wbm+uy1skzS02vMunVOPws1nPZdtrugM8b1mnIRI9rbuXeNGJquHcpCcVDQd3GhpipVBpQaGPIbgbC3tHfUP7MDhJoyW1hfmwkjH4xvs/KUYQWA3TzJuonC9KVIhbMXFhgK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrPB+IwV; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748959706; x=1780495706;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=xLqutD0N7QOTu6wHhMRPSoabAi5L4ZAu1uaEdQ5GeVM=;
  b=VrPB+IwVYmUXCzhfgwoSM2065wLFECtDtL0FFwbaN86zpXZ2c6TLzWFO
   FVJMp5d0zIGWAD/Zkvs1jVahisUKfRzGSsx5PctZzcYHrVPP8fm78hghJ
   2KEvEC+mLDq/AjTskKjb3ZLNkSTXhUUQswpTwnNBb94tuns2OmwcSn/Tw
   7m2vX4EUo21gH59s86Mn8LEIsWwFE8sJgUKvP9kbhxzZaFrAz4MQzGJri
   BYDerd0NnHg2F10lGPTfbfqjxzXIveGZA0Q8S3YhfuI3Pl9X79YQE0NVT
   ca9LJ9BjBxzk9Gtu9XAmeFDC5WgE0yw6p5FTreiwYsts+Nwujitxuc0RN
   g==;
X-CSE-ConnectionGUID: Q5VV0j/RRPe+/lupE+dYVg==
X-CSE-MsgGUID: IUlfFtQaRlKJqb3gxv4Lwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50696589"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="50696589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:07:31 -0700
X-CSE-ConnectionGUID: o9XTECweTeWizFUEUCJyQA==
X-CSE-MsgGUID: Jm2neJ5aRZ6tJJFD1CVc+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144849965"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:07:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 07:07:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 07:07:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.65)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 07:07:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgOWE1cgjaE+d0diub5ZDB2b0ZCnkHE/Nzstf+MhPQxqC4Jd02eWozBTOwI8kO1Cja3s/xsfzqwxY4lJb9DLU44YqwnMlYa3Waa61nQEc0NvLpXuxr2w+8tHxoXN1q55BMxXqUWPaT31lViPkq4FhKE2ISFebnM5YpxVETr5lZjF1ZPOChnXV5BqzyAHOpOI/oTzpnHHht7AHcpa0vcyqGCHpg+Aoo1SOiutOgmV5/6pUMmk61ICJN3yMv5HfLZwm2Naqby9XWYlOMQXIei1Kq4MUgBtXarGcSAv03SCt74riIFfzYciwyo8r9T4uB2tayzgVlqW64ksfbmDaq498w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hMLb0/L8QpnRJnYkyxsdsrlRurfk21sKNxlKEujwrs=;
 b=heq6OLwms6q8HzEDl+h080BHszr85HpB7+TS2FQVtSqEq6qlG/chJ8C1fgVTmKcO5bGtfev0HnpmArIqeWFw1g5WPVc2XzMpC1ycOYY/ZZQRVh7zWtwed+P4AfsYAkbV/l3ZZ+kfX63RiBnVu+G/9OdBBegarBN+fJmbIainuh93vAMxdDc9H/BqPTYO0QwtjHy+Vo4lIagyfkAhJD/sPrCdSD7tZqz+h6WXSoStOUx4fW8sRkIcsD+XH5EW75VdtTbJ1kGZ0ns8LfT7E5NPd8Rf43xalMhuUUt88+KSjVIvAO5Xf0J67zoQ7EoJcebMJMWWiJ3SdOXD255QplTCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 14:07:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 14:07:27 +0000
Date: Tue, 3 Jun 2025 22:07:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>, "Maharaja
 Kennadyrajan" <maharaja.kennadyrajan@oss.qualcomm.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH wireless-next v3 2/2] wifi: mac80211: process group
 addressed Rx data and mgmt packets on intended interface
Message-ID: <202506032129.39ad1ab-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250523115838.481402-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-ClientProxiedBy: MEVP282CA0057.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:203::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: b64ae03d-ddba-459f-8b14-08dda2a7f876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gJWpPwjkRk9hnDt7eug8wGssWoYqS0m+DkN1MS3Rs6ZMqpGY4RnyRbNQFhpm?=
 =?us-ascii?Q?dAeEgpVutiN15KdnN/rUSZv/8XKr5SIj4ihBKA1VqjTBHPEQ7UKjhnZ26YYW?=
 =?us-ascii?Q?L6iqYTMG88RWn7TrSnW5WsrSGTYis9PR46w/9z8gWz6OkLMEVyuepAGo6Ef0?=
 =?us-ascii?Q?ivj/JzVbFvglXRLPaA6wBuWJmNC7lPgjQiN9sHQEffBrXqnr5ZFA2YKgDmnO?=
 =?us-ascii?Q?mYvsu0hIPzrVWnqFPUSYPI9a3gA//mKD1tmAoPSZ8LOOMoXnAixwl3qKW7jQ?=
 =?us-ascii?Q?D1mQKeI5LKW+wVJDli7Kz5fIUZdtwYR0JYf4/LzF1iW2TskL8+QBDlDv4x1N?=
 =?us-ascii?Q?vO6N5LtxDqECs+1KMH/SEtIoquMYsaLT1yyKhXclYH+eQZKZspbKP0a9GGtQ?=
 =?us-ascii?Q?WXaSioU1TnKu0soF7gF+2SA9nn98cMT2Q35xjTmi4W8aesJCvNOrM6hSLC96?=
 =?us-ascii?Q?rmlA1Auhxeh+B2ubT+G+k04btaMArsXtdjclJI/ipb1utuwip/1+hOL6oLFh?=
 =?us-ascii?Q?NlXnvdoS2CTvc8HsSryfqsSEosThcLtrymj2gXjur2Ar1mTAaA/EqXMFg9sG?=
 =?us-ascii?Q?SIIQBkunD8MIUgLfUSS6NKqqThhk51hT19iOGZI8FyLfi1sKXLnFiBIHk2OK?=
 =?us-ascii?Q?HGWyIDiBsudIWsmyQZcpkjNZ9SnYUWxVCb2kPYC9wIYm11SQgmkjiv9N4jiX?=
 =?us-ascii?Q?nYuCQl0MCn4ed5gNwZgqc3uO/ro8xbaKaFaijxm30ZNH53J971JpvMV+QBZb?=
 =?us-ascii?Q?KrYzxm6W/XAAmwzn5CxI/2F9m6WJyowos6ULUt7Dgxqx/0Vc6D6MhC2P4Q60?=
 =?us-ascii?Q?6f4XEnJFmwXrspJXLW1BSuaxlgui7ftmkBx5A5Jx2gqulDREmOpmWp7sNpWF?=
 =?us-ascii?Q?HdCb5GNT4NvKJ96L+XbGkajy2dDBN92f+QcU/kpFe0fX5Fd97ji2YsKbsU8l?=
 =?us-ascii?Q?Sz6u15gE3HZTqYiEEZoaHidW1vnd4ILJ7zxmoTF3uSUHI1WWgXqX1Y8V9uDs?=
 =?us-ascii?Q?L9PZAFfYHYrxqtJMlXT7/tAWfNZa+qSdjxrcEW1bHm94QTGEHDSpeAjhM1lA?=
 =?us-ascii?Q?wh6YChwya6Wc/ygqWrtkLLQ5heV8qlaCtXD8NvbXTAVAcUbGL++STyoRTons?=
 =?us-ascii?Q?yFu2hMtNnD38koz1dzmt3+vSbHGDGDUHXgunKiYXmVaU8MmngShVSLcERHgR?=
 =?us-ascii?Q?dmDvWHcMzfEOTnn97XNU9w0bOlwdfy0q2tIVCjzIurZesVG+bj8SfQFcxCi2?=
 =?us-ascii?Q?1nryeBAEjsQpTAIQSwj47FRQKecnXMPMk29yYCwAivOH1vYqFHonOaEmbWEn?=
 =?us-ascii?Q?XXbHZ4RkC6gje2d0x4g5QwtvHFBhP974U2Co2hYM4HCmXYLqfuaIcZIDe1DS?=
 =?us-ascii?Q?lH+X4kQoBRX+c+uaTK9Hf61oqS8O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LsFNCLDvJ6Bpnicr8S0MNKxl2tdDYCwYCQsZ/655fuPFIf4agEuMAejoczcX?=
 =?us-ascii?Q?N/todmRz0shtCOzDxPDbSPcAwiGfTKDIO5dY5s8Qtg18VQXLCVBI6BkXYIOf?=
 =?us-ascii?Q?zJbkBdu0cP6Z5w1uxhxIi3BWGd6LpVG3TLjvWGtDOAdvnlTO/OqAkcRVbAs3?=
 =?us-ascii?Q?U0AFiRZkZnVPDW3tjy28PoYLTeiCe1Z/haq3vmP94gPMLRn72eMVqYJxD4oF?=
 =?us-ascii?Q?K1rQVRdSZPAzlPDjttpS/pxvnyDTMhrkwmuU5y97dAdTBPRVEvKfwEouM95G?=
 =?us-ascii?Q?JW1eXYBirrgCHHd0RDHG1+kQxDq/Aui0h6caL+1VuylyP0pv8YK/IvDmh/sn?=
 =?us-ascii?Q?JLQJFgYU4pK7M/QLzeivhEY73sk4lmpzNB4/ABk3cFitJaxYYdL1UJqZtV9d?=
 =?us-ascii?Q?PDMnVDUEwugChh8W+zeiLDKO+cHJ2cG8siWCSlBP/D0lDMKsMTnIFdou3/kp?=
 =?us-ascii?Q?Gd7dWoR2cp7nYKIJW0k0qw6eTA21Ra3zG4q0L4lU5GV6+QPy/Vu3ImFi+Ygn?=
 =?us-ascii?Q?xPc5I102NE6J7wg5TLYNTTY4v9qTo2bb3SrBD4oqaJeUJLm/QofmZPPpF9ra?=
 =?us-ascii?Q?yIY6EvqAZMFyFSLkJm44blgIkPLnEpB7sogLjFe2rHwq/sHUHqYQrDyYhBgi?=
 =?us-ascii?Q?4SLTDqhz3iIUQmG17UpHnJWdXHJkJgf66o8B94u6d9flNhW7oulI1eOUIZRI?=
 =?us-ascii?Q?u9upRnXQ7l86eGy0DCGY2hriSsgmmIXdam14/gv5da6F9jZtVScungpNWlMd?=
 =?us-ascii?Q?DqBDtRbpdK5CUC3wpMgQSps1AutnRS8J+521NGroBTN6d+0G6tCNly+WMB6k?=
 =?us-ascii?Q?6OV/z4QxUvYiZegaHEdyDsYY4vn41WNBPHwQ3JfWGhl0/ANMeV+upSpxbhNA?=
 =?us-ascii?Q?hwsMPBocSU0kfQfth1DAOVr4hf2lSDsfmR/BjWecwHDr9a7jxH8ty3xsvXry?=
 =?us-ascii?Q?gucS7lER7frV2yI1eGnvpPyqo/lMK3/2lLQDQ4ai61bfOqzd/CapBhy5gCEl?=
 =?us-ascii?Q?QsF+vskgoKrvJy5NsJi3n2KI5zA10DasBsv7GF1PgQZVaTeFWklRX4PkxGS1?=
 =?us-ascii?Q?yQ2uOGPw5IWM7nA6jkDLdmQYUdiii80sOvfa8N2bDy+9eTF8a8d4YxneUJNy?=
 =?us-ascii?Q?lKYjZePdFKBB9bLXb00C0pyuNTOtUO50yeNpvV5aTmF/kifLqYEzb77kBJ+Z?=
 =?us-ascii?Q?0+lbZvgTm+AmXGR+RjtxnFiv53z/tHMqdrSoUtZYLn77e64PS3ZXeP5isxdA?=
 =?us-ascii?Q?+ZlRN6vy7vZiJsN6TYOYFMxjE+xbfAEPMmP9SCOlCTiN5tuLG+KpI6ZyAQ0I?=
 =?us-ascii?Q?FK/5s3GdWaAaLHTrzOHlPHFReLdScxReTQKQ+Vq6utpZ7T/yKztLVU9FnKr4?=
 =?us-ascii?Q?fgCyYoX+YrUDQNKqU9eFTUE3R0hmg+8y/n/C6mi7zwDLDg5g47Em15lfI33n?=
 =?us-ascii?Q?MztVLwGL2b0oqs+HfB49NDv0DSVyiLepDh0lsNRQwRLWN8GPXWOIy83iW4Op?=
 =?us-ascii?Q?MWP+i7Nl1sKPj8eMpsuhIyOY/I5TaIlPGNR3yd5dbEY0oG0T/kOWdGT6SgoY?=
 =?us-ascii?Q?S+jm/emvUDMpmiZfYSC8z/VCqp5ZLEuq+VDm64qBdUPYjFchKoVfEtbdNPHO?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b64ae03d-ddba-459f-8b14-08dda2a7f876
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:07:27.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7HmYglBXw8zCp+s5U1wJcxK612oGmYEgA20YF6U0nlfVUvcHNmDFeAKP2CvjiQo8zz9pvnt+KNzB0FhcQ2y1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.pasn_kdk_derivation.fail" on:

commit: 9b295898d736daa9f3287430f4bef5481ee0e99c ("[PATCH wireless-next v3 2/2] wifi: mac80211: process group addressed Rx data and mgmt packets on intended interface")
url: https://github.com/intel-lab-lkp/linux/commits/Maharaja-Kennadyrajan/wifi-mac80211-update-ieee80211_rx_status-freq-documentation-for-multi-radio/20250523-195936
patch link: https://lore.kernel.org/all/20250523115838.481402-3-maharaja.kennadyrajan@oss.qualcomm.com/
patch subject: [PATCH wireless-next v3 2/2] wifi: mac80211: process group addressed Rx data and mgmt packets on intended interface

in testcase: hwsim
version: hwsim-x86_64-4b8ac10cb-1_20250525
with following parameters:

	test: pasn_kdk_derivation



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506032129.39ad1ab-lkp@intel.com

group: group-34, test: pasn_kdk_derivation
2025-05-30 22:20:38 export USER=root
2025-05-30 22:20:38 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2025-05-30 22:21:27 ./start.sh
2025-05-30 22:21:28 ./run-tests.py pasn_kdk_derivation
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START pasn_kdk_derivation 1/1
Test: PASN authentication with forced KDK derivation
Starting AP wlan3
Starting AP wlan4
PASN: unexpected status
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_pasn.py", line 925, in test_pasn_kdk_derivation
    check_pasn_akmp_cipher(dev[0], hapd0, "PASN", "CCMP")
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_pasn.py", line 122, in check_pasn_akmp_cipher
    raise Exception("PASN: unexpected status")
Exception: PASN: unexpected status
FAIL pasn_kdk_derivation 3.876573 2025-05-30 22:21:33.773779
passed 0 test case(s)
skipped 0 test case(s)
failed tests: pasn_kdk_derivation
2025-05-30 22:21:33 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250603/202506032129.39ad1ab-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


