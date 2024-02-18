Return-Path: <linux-wireless+bounces-3737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E28594AA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 05:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA2A1C2136C
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 04:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE75672;
	Sun, 18 Feb 2024 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRisK83Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0535673
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708231930; cv=fail; b=egaUry1MWpHLpbc7f3g0RL25Jav5lg7zfHZnosSTD3xt33eryU+0hyxKNnJ9NdJRMnIoHKV3cr1hrjzwsevwQqdJTYRTQVwwR3Go2yeWuiKa9vZuB6dfAg13Hrp7U8pPYMxpt6s/0NvXUb4igViSOyQo7uG0KjxS3EWUxpRjL98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708231930; c=relaxed/simple;
	bh=kjWC0b87JcrZnZpc3//+RHLXDsQ7BEHbZtbOxkafeGA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Z+qijXTu9aiWzhYFKPRjzbY0QVY17TfWPWd8AwYYbrxrorYG2UCIGW2SXEUUPjT20gmZ0Wdsn9+oW2ih/OM6bzE8vkg1WEx2jgSMRR5wrIf+sekGOmdclYPvcW4xnJmFXFS3nOR+xXxEhOsQEUrXZhiw9jGRW3o3hentn9Q7N8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRisK83Z; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708231928; x=1739767928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kjWC0b87JcrZnZpc3//+RHLXDsQ7BEHbZtbOxkafeGA=;
  b=jRisK83Z2JzfVw1M37IZ4Ik20GZoUTZt/JueWKzQEbl5QnDJIsYVPKV2
   um8zn7OP4SDy3PvEBX6No5vZYZbkpylcoLQxWsomDcVm+HLZlWYi/ZeiH
   wzhPv8l9kqXnrY1sJUBVhmh+EPVJbhQ2mT+wv6y45Dw/DhTqzy8MadLNo
   il6i9Bi3quq2MvsJYOKegUFi6j2MlAPWymwKsEmBWIhKyqCZYbitbd+Lt
   Q25LN2qYS1xDEa8hu6hOhgO9DcxA/SvUJj9aMy6jW50ytGoEpy/WNiOt9
   6jIUeVqfGFWWqHe9GCwA9W/GK3JZMzjvH3LhfXS2D1JCIBIu5r26wPOsc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="19752501"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="19752501"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 20:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912653054"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="912653054"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2024 20:52:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 20:52:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 17 Feb 2024 20:52:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 17 Feb 2024 20:52:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+RiePYZ4Jay6i4L7pLc3e90Wu7mTryiLiINOq9QwqocGv3axlHspH9U/bqtsIMrBSnz/5ezsNLGMcd9tvIVVeaJbl1xXHjcejVxLY5+DJgG2o3/0bdinUZXVjYeMxv4ml7SQjUBt8MLttBIBzfSD001sKQ1bGRd7uGPHhTqNCI5VpUCnW8vgI3wjDcd9VvHZZa10yOoAfBxw3xofeg1bpRPNmDTrwNgNP67aFLE4jCUbknQkB5erIRfytJHavYb6lcIQBdDVwKgrELYFEhx9L8B7ayQkpxUogCGcizI2iGGtmpHZkUvp82BmFKsBKxORvJGJeJT/jrU4UKluSn/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaVe81AinqjgJoFsWKr81rxjTGLVnwej2gc/aS8vbMk=;
 b=AAw5SB/S8NVAf4o0i6H4Dzz7N18T9eK7G4FkAH73bXfwuQJkLuFnYfmzkmu6JwidtGY34tbIe0j0TLt4JhnPIc6KqUZB+szGdg5X4fqg7u3yI38+T7uXVWGSCaZ0vshKAbpBlhz6EdXu9PtEc9aE3gjkNMfCPgV9AnGObeu7ddbJwft/Vfn6vRTxMOOuTqboowS86CPAhY/oYsTvtBfJ/dl8fl4m5rAu//Wx79ypHlqfmPU5n4F0ulB/wKCAPHITp7TJXeBdW4Cb+bsXOfKJrbBYrtNjl8WjBqzi14ZjHJli7e+SSIr6aPBw7TaFCGNk0eA+LyUimOGkcEFbtzzC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 04:52:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 04:52:03 +0000
Date: Sun, 18 Feb 2024 12:51:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Ilan Peer <ilan.peer@intel.com>, "Miriam Rachel
 Korenblit" <miriam.rachel.korenblit@intel.com>,
	<linux-wireless@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [wifi]  310c8387c6: hwsim.autogo_chan_switch.fail
Message-ID: <202402181048.a07a087e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f90fdbd-02c6-4d91-0a74-08dc303d5940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5Ewf874Ku2fyzPQAH/CcuxeJh0803+oNHOBT6FwdGyv4zFCjWfoDYdHgC2JduAqWtGnm2kLJc/2RdNZKEXgEvgPaLHbVgu+OXt05niD4wApHbi5YyVdN4Z0l3ftlqoL4rbFH7inFt+ikAim0hBnIH8dp+wPRKdp9RrwhYAtPOCWx02VY0ULtYSSr/SHg1ilOUsEwvT8zlcmxxHRdWu3FKFZfIetI6zAqIkU5ZZD3XiZ7XOf3Fld7OKocdvVohUC+erY6LX9mwd+8ioCiMgzZLBmHunN1rVJ1DIlh2Ap0ZrTqde4JpXomQqnceFzAE2HkgHZaqTFONtz+PNr1jCnkkY9pdSPgnFcXLZguDaHOoRFImD2yLd9Jh08gynb31bCy+YevxNMzg2GwevsqCYkfa48AdgZa0uY5yT4AKmaUBBgZQM6kVhAhqnOcU0g7Gp/4fWaqETVks3bAIMjvCAtPcVSwAxkAkayeC5p3uXCnSUAXzNGoDRUgF4AHp8C1qJOVX1zjcxkagABHKyDlGVF7t4D9qRt2lryN9pr4eJFnQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(86362001)(82960400001)(83380400001)(38100700002)(6486002)(478600001)(966005)(316002)(6636002)(37006003)(54906003)(66476007)(66556008)(66946007)(26005)(2616005)(107886003)(6506007)(6666004)(1076003)(36756003)(6512007)(41300700001)(8936002)(6862004)(4326008)(8676002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d4SMzKlCP+zR+odjQiL/sb/o29J5l1tcaxf3SCx8kH+LqbaugiZxZ1LYm+FQ?=
 =?us-ascii?Q?BFvY4T+NfFFn9I4144rW4OpKgFuy1AfZqHRdtggZSm6hFRU12keqEzB7HXXF?=
 =?us-ascii?Q?FBY5CDUsRnDM4pR2nt0lPstd1/esevOIfosQ7f0nZeI0NjX93igTrmG7AwBl?=
 =?us-ascii?Q?ZvbSfpUBAQ3JKYR7LhObXUvRrSd81Hbg6Ud6jE4XYlDSYF/7c8WFlEwqDYau?=
 =?us-ascii?Q?xCVBdurc8qnBl3OxtZVSTce45jjt3smgYrdL15teawkqeM5KNIGQOgUg/OQ6?=
 =?us-ascii?Q?vl0Px/hUFSMYuAxwW+Ba5ZlpxCm1NlLpqo4e7KizfET1mt59MKPmOAY+x8Jg?=
 =?us-ascii?Q?c5FFbbVdHCDFSRM1eKj6d6LJoAbiAQYfwOnRSSMrvFA/DrVNgkI6S0dW59mo?=
 =?us-ascii?Q?DOPeLXXFUWwv5mVPLI5N+pchJXeKK56swKWUMiTWgOEpWMI01RTee1J25fci?=
 =?us-ascii?Q?4Rrs8nPXakKHfkzJDsoM1LEQDikOXrZo9hgtGJ0PcJgQOTNFXF4l467MMxk0?=
 =?us-ascii?Q?gObvgdrwXJLrix7CnxTfR+jbcfPWQdFlSZCA7wg225FbCpSGiFtnEVR8nYgT?=
 =?us-ascii?Q?SG69l9vKmMIgtcTobTTqfD9tHS8C/+hGfRVQNlgd3EIKh0+XQixD4fne5AK4?=
 =?us-ascii?Q?gCa+rx+1JSSbOogFP1lbuin3EV+qNJvjL6jvkCxy2e0NlFdWrdRhnLehofI1?=
 =?us-ascii?Q?449tRCh9dGFeW/hwdS83NoNjgsQy60GaewCGQIIDeihporsTc/dAuMIEsuNE?=
 =?us-ascii?Q?2nmPWSyEItiNA7IzBMvchdQn/fuUBWqrYCaqxBmqIlua4m9yALCYpkIn/rNc?=
 =?us-ascii?Q?4NxvToP3jlZXodteLI966bouvreOdgdxGW4dWEgX+YBHRokeJwph4NYNXdks?=
 =?us-ascii?Q?riQ92T17OlZ6KGSlSu8S+ZxS5Rw9YPnJ33AP5joFT6nuCZGoZ3shp5tZfjvC?=
 =?us-ascii?Q?I9eCwlvgR7nIM0aXSgAmbCYx3RIe0yPV1fnXuKh9Fzj+DX7NNgghDVtn59xB?=
 =?us-ascii?Q?H2KP3aVMUNBeP7ypWtDAKX/uz633ZFpEDnv8Oxuvz81l/Dgn+4ojVl3WWx5h?=
 =?us-ascii?Q?XN0A5aLhJtrqpkLJ2BNFoxQ9KCaNPBCfE3CPpoSB53Ddz5TL9SibARSLSiXq?=
 =?us-ascii?Q?A6i64Rvx3N8xLrUV2K5cTJYqY3JFwcSIC+oK9tU092k90BO0noVTG7sMNutc?=
 =?us-ascii?Q?Zh+TwhMSMeZUpFW2GA7ycbS05CKHDp23BKQ+MyHzyq6B9r/E2rb9bwb/prLP?=
 =?us-ascii?Q?nkeN5TN/RL1byvWpcIsqvwk+cbpdQVJsK41mtShqD8bK2DMpPMJxdHMp0GPh?=
 =?us-ascii?Q?hDYTwTw7l4AHZUe46nfMD3jLwfg9hyEcI7oxUrjANBZtK/dsZbsSKhF92sUI?=
 =?us-ascii?Q?Itg8FcwDHAcZMADRV2za11nKT9VJbE4dHbjzcxQwmjvLE00VMgDz4zMimSo+?=
 =?us-ascii?Q?vvG+vQBMdMhYKwuJl18b2+7Zih17H35ceGqCpUfcRfd0ren4TLnxSeKV5sOh?=
 =?us-ascii?Q?zMJte8dZrTfB77KkLyHtZusIf+qVQ/GkpP2IYoYVW2eGj2M/kfgvzXMTC6K7?=
 =?us-ascii?Q?L3qHlPbuI2e1ewqJOGLyw46EQhHGQFrC+TAYYNkjbN+e+dYN74sKchWmSV8g?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f90fdbd-02c6-4d91-0a74-08dc303d5940
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 04:52:03.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4v4w7uINsbFNnWv58+cvFQiNWi5nKoHwR9YG+6emBISepFUJnpRfqMPDSouD4aP4E0M5L2pFBayKosHfgojoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.autogo_chan_switch.fail" on:

commit: 310c8387c63830bc375827242e0f9fa689f82e21 ("wifi: mac80211: clean up connection process")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master ae00c445390b349e070a64dc62f08aa878db7248]

in testcase: hwsim
version: hwsim-x86_64-717e5d7-1_20231228
with following parameters:

	test: autogo_chan_switch



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402181048.a07a087e-oliver.sang@intel.com

group: group-20, test: autogo_chan_switch
2024-02-12 06:54:50 export USER=root
2024-02-12 06:54:50 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2024-02-12 06:55:43 ./start.sh
2024-02-12 06:55:45 ./run-tests.py autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
sending data without carrier won't work
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 539, in main
    t(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 357, in test_autogo_chan_switch
    run_autogo_chan_switch(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 375, in run_autogo_chan_switch
    hwsim_utils.test_connectivity_p2p(dev[0], dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 227, in test_connectivity_p2p
    test_connectivity(dev1, dev2, dscp, tos, dev1group=True, dev2group=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 217, in test_connectivity
    raise Exception(last_err)
Exception: sending data without carrier won't work
FAIL autogo_chan_switch 3.515491 2024-02-12 06:55:50.555970
passed 0 test case(s)
skipped 0 test case(s)
failed tests: autogo_chan_switch
2024-02-12 06:55:50 ./run-tests.py autogo_chan_switch_group_iface
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch_group_iface 1/1
Test: P2P autonomous GO switching channels (separate group interface)
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
sending data without carrier won't work
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 539, in main
    t(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 383, in test_autogo_chan_switch_group_iface
    run_autogo_chan_switch(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 375, in run_autogo_chan_switch
    hwsim_utils.test_connectivity_p2p(dev[0], dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 227, in test_connectivity_p2p
    test_connectivity(dev1, dev2, dscp, tos, dev1group=True, dev2group=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 217, in test_connectivity
    raise Exception(last_err)
Exception: sending data without carrier won't work
FAIL autogo_chan_switch_group_iface 3.427779 2024-02-12 06:55:54.579885
passed 0 test case(s)
skipped 0 test case(s)
failed tests: autogo_chan_switch_group_iface
2024-02-12 06:55:54 ./run-tests.py p2p_device_autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_device_autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels with cfg80211 P2P Device
Start autonomous GO wlan7
Try to connect the client to the GO
wlan1: Trying to discover peer 42:00:00:00:07:00
Client connected
sending data without carrier won't work
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 539, in main
    t(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_device.py", line 561, in test_p2p_device_autogo_chan_switch
    hwsim_utils.test_connectivity_p2p(wpas, dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 227, in test_connectivity_p2p
    test_connectivity(dev1, dev2, dscp, tos, dev1group=True, dev2group=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 217, in test_connectivity
    raise Exception(last_err)
Exception: sending data without carrier won't work
FAIL p2p_device_autogo_chan_switch 11.899132 2024-02-12 06:56:07.058467
passed 0 test case(s)
skipped 0 test case(s)
failed tests: p2p_device_autogo_chan_switch
2024-02-12 06:56:07 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240218/202402181048.a07a087e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


