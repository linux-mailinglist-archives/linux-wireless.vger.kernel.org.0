Return-Path: <linux-wireless+bounces-617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF180C109
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 06:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B07280C5B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 05:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2401F602;
	Mon, 11 Dec 2023 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfQB9UrE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B62B3
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 21:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702274155; x=1733810155;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bvUvrnG79HdOCH94BHG6YcwYBk9q/tyNhbr2nalPOKw=;
  b=JfQB9UrE6rET4Yr3otgu0JmC3eRMUitI1Ef78kzawGxcmilWcJ63rxfw
   yO1Sls0xMeYeET5SGMoRcsemM4/d/KSGO7wxEVpB2XgxpDCmJYmjlEIai
   1zff9kprfIRTs3rE1uXHHZL1RD3u1OtvWoAsogXSZEmLfXcPk3pjMSQTE
   z7NrfYmcfDfrAaQWt2fpzFgVM1Xm+82cvUDhBxSFrho1egAxAfn1uJUNg
   cQvzF1IwekFeBckO2VQSBz71ISEvIWcR4f4TMrCTN8EkNJupsuKSw0yDs
   qSrgxuf9Y753p1psCjnlCW4lBxs5wCVxil8dd6kZMNVnlg11sRU3+75Pr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="397385109"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="397385109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 21:55:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="916711183"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="916711183"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 21:55:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 21:55:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 21:55:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 21:55:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGi15bDfH4fBOGTjVcLJt9zxCIzeraTEDmNbfh1862Z45eiw36xj4jcrPVgrCig8LnwRjAGb0VCcRNzCKjCoG9oKFWq9WOvU+LiqqzQeFHeRoi+x8ONsmKyFExSQTOiIKZYdrfZpj47YL/uQbrMxel4C5PdNMFnyhC1/FF1YyBx38ZWVkbQ6hofdStGghDGhQ5oA/4XpM9DjZQWa42cxCp+5aRpgCFwXnqGNfBsC6VxpXfQxRfFik0YLqv8iD3SM05WqguG6j93FrZzeqMD5h/GstLvwSJHqHWi/zZLdBrBxFherwga+vXKocTtnX+IVtHg+i/s5nLUtlxkH2wu4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8EOHI/nwz3JhI8o98YDSjpMTN78jKoQjfZZa9LTaKM=;
 b=FMt+3u0gW17EheRq8kdywJxcKZviSZyZY7sJMthDaGhgDbjrJJ8aN4cwEGHzWlVNabGkm3+NEyrBd3/azCj20tT2tJSs3LV9o86+vAkLP3j8BKtkgrv3z2qRA4FVO3pIaLHxqXyMjJ5RK60xYOQUYbE9ZuA3a9ttoEFHEeWz8qhWjuA38wXGvlXBI5dP+DXi8OGB3Q1qgAMtFB1RdO07b/WTo/OLgpjVeWJy3m2znbDtzosJ+8uyMZXDSITmOb3OTIAoz0r3PCZHsEGdBWfXXTOz1pxkd9gfBpxC6FVsrHq9BSakSckPUpUEGW1At7ztIkKni4kYo4Ms86Zmh/DSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6556.namprd11.prod.outlook.com (2603:10b6:510:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:55:52 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 05:55:52 +0000
Date: Mon, 11 Dec 2023 13:51:22 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Kalle Valo <kvalo@kernel.org>
CC: kernel test robot <lkp@intel.com>, Johannes Berg
	<johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [wireless-next:main] BUILD REGRESSION
 db7fac15eaf0f09d675730d7002edabe27fe9e1d
Message-ID: <ZXajWhhIJlSjanrA@yujie-X299>
References: <202312090036.jwmcWv2Y-lkp@intel.com>
 <87cyvfn0jb.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87cyvfn0jb.fsf@kernel.org>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a8e1a9-48c1-437c-8b09-08dbfa0dd54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsp+qNXvDsyI2ur4bKZEGN0Ywwhnx+am1kQlmuh6aTTWjruaunsjNW40T5NBerPLe/oI9T1ntlLkLZHqrjbN6uguF2VebDWBCcWPbpob7Bo5vqvSatgf++F2TckyweDInwng255gSy306WGVAEpLqAhdWjR0SN85hxP9zqTU7GUSXvlXAq3CLLsjAQaixedLbm9m8lGMhKp6wqmbK7PqSsfhY4NtjYUgVGy/aOZj/rjFDTasIZmGTKHmod4QVcNYQXbUfIPnmmgVEfduu7OzbbG8W/waQ5PvkwGdoGc67P6693iVePO4Yov19WtCC6jswYRU0Zs898Gh6eanLc8qUen1/BBimAg1LauPxDOv4yGrFIV+SOipGoX7+ud9NVs5WOVRuXMJpdBcaOxUeAF0hyixFQEc/81BbxNa5y0Dc5bXTUSaF6m6xk1jM4sW+dxlKr5+zlE5lzbssH/UX5a1C3s4HAHYUGC0lRevf4YkvIn1EhnkS9flqN/f4PZWPhLozEbPYs2XVKdY+Hn4aS3ExMKRzjOdZkictopThnmMD+ymjUL3zYRewjS6lQzrL5doavofCclLPWawQpAd/BKlkrrVMmOZAe0Y0QHp0kjylpJ68msthryRipyheN+vQFzO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(136003)(376002)(346002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(9686003)(6512007)(33716001)(6506007)(5660300002)(26005)(44832011)(6916009)(54906003)(66476007)(66556008)(66946007)(6486002)(966005)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PtpVzLcN4IJAeYnjYKticErSs6pWW+zTwROfl/fxZ43HT7sfp2LDCUtsGtl5?=
 =?us-ascii?Q?C4/gHTDknNabClg1lBBJCO+rMisP9UPUe58eG64AAqaF4BiQnZ1LfUAReAdG?=
 =?us-ascii?Q?3o43AD0LWNe/1RclJBhhTE2nqBDLhcEw2AIkSQlFsLKgkDAmvkuRUYhDkmEa?=
 =?us-ascii?Q?2ebYFuwvdg7WSqlseQdEuB4k5nbtRULYxVB6PkdF9cda1ZU4evNJcxUHWsz4?=
 =?us-ascii?Q?gRcoyMjTXDxebL37FAXUNX625flUnm2e6oFp+vBz94XY9y+E7EpkH3zKcj/B?=
 =?us-ascii?Q?kYwKU4c/I6hj5+vd70AbvlElGSoqj9D6bmClCUEKnrfe0YhzOGy/ZZVmA3xs?=
 =?us-ascii?Q?G7fKuE4p8R318Eh2FetL1TLkskz+1nDpC1AKyM2ws9RiiII0XYdvdxVw0A5e?=
 =?us-ascii?Q?x+gDzH2AhpzLj7RbHwXfe5q5da7VYRHYVtpultxVo/DOjXylOXMkKH8Jn/kG?=
 =?us-ascii?Q?qpRekCE+/rJ8FGhYjP5XhlVrswsml/49xCKmmHrNJmAEE7ITVIwCJIK70vQY?=
 =?us-ascii?Q?gvhhnbLK7H3jKi5A8hOjz7eIY0sw5nnYD6aPAdANo3bQsFhG81JXXhXUTOv2?=
 =?us-ascii?Q?dbxnS/3RBgota7RX0oZGnuN5m9irRntkNKVEp1WOtBEXZZAftPpr2EkK7lqO?=
 =?us-ascii?Q?0NjEllBg44uSFNVTTI8snEgH+hQxaUCwt0V5gKFPJvi2ynQBaQcoO6/lFFV/?=
 =?us-ascii?Q?VKpx3copxHc7kI5wcwfH5/ALQfWbsaV4uu2FFpm9bhItfTl8gjxcAN/hhoLK?=
 =?us-ascii?Q?Qmyli6QUyKpT9wH8zI5IDtybONTJvns27gqFK6X9wATz3n6vrZwcBrGMfqCx?=
 =?us-ascii?Q?+vwypx1/zFRPtEt0+pqEFCREgXNx5V8gNaD+IKP3AgsXgDMi/TXCNlrgeetf?=
 =?us-ascii?Q?Jdgc2qpn/jlbOEdCy/biYnskon2MPMjt9NOybHxCZymqMbYGWazlUyw0sAda?=
 =?us-ascii?Q?ucMyJYpberf8iIBakccY5ZCDHZVVQPf1gdxldSVNtakJ45WXcDLP20h5iMO1?=
 =?us-ascii?Q?SmX1R6sn7ZMiMt8P0JBLzz6ya1bbLkxPg2I8rByja7N1kjlr8PZzVPuyFxWQ?=
 =?us-ascii?Q?2KeczE1z1dGCKT2fq7ZoWOdG5u1x+MaDjNw5gO1qOD/K3i33iszwc+7dYUYR?=
 =?us-ascii?Q?C3TqwFO1U/8j7zrR4+27YT3jdc1wl5uHVUxZbwKlxiOr+92m50EORxMaRlrV?=
 =?us-ascii?Q?T6AO8Ucha9u2odSrNTI1/s/YLsscPVIJ5AYeZqOZj17huOWDhvh7XTQLjBc5?=
 =?us-ascii?Q?mfboMu5vJu8u9v79A9K6wlwe1g5rwWSkn04wF9KXWz961qGC4S2eOYVjcibN?=
 =?us-ascii?Q?TMoMpxzYlXp6vNMWEFvNSXLToxOBY3OBcYBn0EhI/lsAh1rWZFU0aVkYVU6Z?=
 =?us-ascii?Q?vlOtBefALyng+QIWtdc+1LzGMK4AV6lq6MewtsDP04iVc2Nto3hnvE0N0UOv?=
 =?us-ascii?Q?mX+eSa3oas9Zw23qrJZnAY1WsYcDB2clFRgSeO6heDBX7qu+5SGOekf1m2gf?=
 =?us-ascii?Q?8239x9xWgliqolzGuYX4T1vWw4RyFtisdsT/Wl2DNEvRTQzC1pZnREpNAlRH?=
 =?us-ascii?Q?NxMS07R4YZvctY5rs0ZW3vUwNtja785LZBSaIW3U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a8e1a9-48c1-437c-8b09-08dbfa0dd54b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:55:52.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syVcnEJV12LKc2txVkmn5YzxQ1xLK6/ZMEqKmL2gr+DOOPDIbLSFCAo5Ni3kgeIH2ahH7BxeZ21/06ng8pDRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6556
X-OriginatorOrg: intel.com

Hi Kalle,

On Sat, Dec 09, 2023 at 12:16:40PM +0200, Kalle Valo wrote:
> kernel test robot <lkp@intel.com> writes:
> 
> > tree/branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
> > main
> > branch HEAD: db7fac15eaf0f09d675730d7002edabe27fe9e1d wifi: rtw89:
> > mac: refine SER setting during WiFi CPU power on
> >
> > Error/Warning ids grouped by kconfigs:
> >
> > gcc_recent_errors
> > `-- mips-allyesconfig
> >     |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
> >     |-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
> >     |--
> >     | main.c:(.init.text):relocation-truncated-to-fit:R_MIPS_26-against-__sanitizer_cov_trace_pc
> >     `-- main.c:(.init.text):relocation-truncated-to-fit:R_MIPS_26-against-_mcount
> 
> I assume this is a bug in build servers or elsewhere. I don't think a
> wireless patch could cause this.

Sorry this is a wrong info due to a bug of the bot. We've found the root
cause and fixed it just now. Sorry for the noise and please kindly
ignore it.

Best Regards,
Yujie

