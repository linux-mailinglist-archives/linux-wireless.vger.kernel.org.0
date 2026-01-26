Return-Path: <linux-wireless+bounces-31178-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LJvLZpxd2m8gAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31178-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 14:52:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D35CD891CF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 14:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EE943011527
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2497F33A710;
	Mon, 26 Jan 2026 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9r3Vn2r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C2339868;
	Mon, 26 Jan 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435160; cv=fail; b=RA9dxBtyvHGc2Vu+FaqAExQZLhNtfzJpZrk0Mnzeox9syvy6hINmy3ojyFgGGfaXEttmP783abkgx0z5sP5SdL8u19qmCxWFq1R558O0MQHkkukytrqX24NCT805uACRBKVejNsjW+f5iIz24/pLc4psQexPdsJHlvnwGtZABkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435160; c=relaxed/simple;
	bh=JA7h2fn4mVzld8N+WGdwaxadSKDNXS7m9uUQxx8Hy3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOQK3cuZ5pkixZHGOsqFqg6rqShc6o0u2V7RQW1lSb6vjuvfx6pQ0SjMwABvPvsvIwHaUAjgZC1nCyoGwVPuFOVCjuYi0wleUEQmuURMOMhxthjxVC7kmWCNXkrhmQ3rY0ZR1/18t2ORqwZjsAx3y7otghMVEogFS5DP6xg9oBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9r3Vn2r; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769435157; x=1800971157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=JA7h2fn4mVzld8N+WGdwaxadSKDNXS7m9uUQxx8Hy3M=;
  b=h9r3Vn2r6SRuiSYFrH3hWwOkdxXB/wkrlwB7LbjzuAH3ybts2ys840wK
   AXEKe5bBMFqOKlxlgthoPqVkbB/NvxFy1ckjPwcR/a3dGDuW54ekDkVtc
   ObjZDTbffSBUBa/KurJYJjVPKFmrgnpAdprKncTSUiPSQP9Nzx8/YVccL
   1iJgNHtXMd3Nd+4zXgleTJb1Tp7Z/oVIsyecNr5clBPnrOjgoDYc0Gktn
   QG/3hGtDX7/sW8AI63GhppBMHEjIfcnGbuLDUXPXB0IC0RmzIsA9bqPUI
   GmSEerweno8U3mfIAeLcjb4KMcH/XaYm/5RYkFKAWoS92354qa2D8G6ti
   g==;
X-CSE-ConnectionGUID: 0jiHWNAgQROq6XrZq6rGPw==
X-CSE-MsgGUID: ZxoTVOqSTQKR1ie2YrcVnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="69632852"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208,223";a="69632852"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 05:45:56 -0800
X-CSE-ConnectionGUID: RDqQi2pkTHidBBY/bpmSIg==
X-CSE-MsgGUID: weCQO65qTg2Fs7Vv71R2Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208,223";a="238359313"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 05:45:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 05:45:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 05:45:55 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 05:45:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJ8kzbw9A/fluAd1zMX7ACu2UWCrHU/Rz8M0jxhSA+6Q255gKxaec8xhc7+ANWanf9KJGrjDBAM1zb51vqfWPR7Tnw9znRaefmYeKVEvYaT+3bvxjNq8l+TkQ0hhtpWc4tqrCiT69pMZI8oSroQSS1PeN+9IsYNc/yxOahGdQGZO+7FWdA0eIOxKIt26neKhw6ly35R0zM6PuHxM8K4Jk5+xqjWLbX3Y9YxNgRLddo5flo0e963jgtkgVo4kA6TTGGmIAX4nzmDYqNsBuUEXyzFt9h2saGFVQga+kfZf5fRG1VRLjYfhBrsiNUPTCYybxM64QgeBbTj/dEsVnwGJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN5j16PII5f1lWXzXn/g9tRECm9gq58Yp0NCaVzJLrA=;
 b=iaFKdLNJkzQStqQM/g6wDncdVzCfNFWAbvhX4D7DDTchB6PMV6I6RpBuFMD+U5EiQDX1ahWErh3Ftyj64GB8fW4Y7Rm0Mv7TFpYelOSsHnljjtzEeYj+iRJ58F+y8rcOeWT1rdqlH/YWNoXYC0BUb/Sfwzo7fT8Mz8vZ3ehn6aa1FznY/OQY+KMmPTtWauP3a3Ho7k2pVL0epuRk2BnZSWMW0r/QqWGBO6N5hazIEUTb8f6bMNuyrxiERLW/N7vTSO1WBsjGMDxvlJWe5SVBjXU100+x7sl8L67pr01CispboiCz2w7XZDnW4OU+gvzEvzUEr+RvT37CgOxwu1Vu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 13:45:52 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 13:45:52 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Thread-Index: AQHcjlMSDsDNaO3QzkSRZaUB0ZOqB7VkClEAgAAYLQCAAFS+8A==
Date: Mon, 26 Jan 2026 13:45:52 +0000
Message-ID: <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
In-Reply-To: <aXcovK8uhsiaHumT@debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DS4PPF814058951:EE_
x-ms-office365-filtering-correlation-id: eb8b3c30-ec81-4c9a-4853-08de5ce138c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|4053099003;
x-microsoft-antispam-message-info: =?utf-8?B?N1Jlb1lHZnFZMU9rWmVRN1dhSHBqNG9mVWdLZnpSWXQybUl2ak5Gbmg2N0gr?=
 =?utf-8?B?NXV2ejF1MTJzZmRqQkpCTXA1S2tTVHRqYjdvbkdQZEpMVVJpRi9LTXpVWWk5?=
 =?utf-8?B?S0dqdVFOQnVjamd6Z2F4MXlxTTF2VUlNSzRKMFgwdlQ2SXFvZFRvdHE4aCtX?=
 =?utf-8?B?VlRJR2VGTHd4M1d4ODB4b1VnRGRFUTdEUW9LZlBvWE15VWxnSytrZlJQcVFR?=
 =?utf-8?B?ZnY2VUkwRFVrVGx3cmJWUjBYVjZickdJRU91R2RnVGF5eVFxTGxQbEpCWk8x?=
 =?utf-8?B?anNOVCtrYnVFQnhmMjVWaVlnNXBQSW1qdHg4QUR4MUhhYkxIWjRhV1NLem9y?=
 =?utf-8?B?QkhUdVg2dWlTL28zMWhoQjdvZFo1SU8wbkVSY1BUdmNxRjFCSVFRNThVeFpT?=
 =?utf-8?B?QjZnMkJpWGJwL2JBQVZFd1ZHSVkwV3RiMWdBY01udS9xOFZLcjNxaExiUUdD?=
 =?utf-8?B?WUNXL3YvaW1IK2ltRk1CR29ZcVFxZC9JWDJRZXpndFArY2FqNXYrOG1YZkRS?=
 =?utf-8?B?OEFWY3RWeHNIREpVZ0M2NU9KNG1WbDJyVi9MQmtxeDNIK2k1Wmw5bVRYQmR4?=
 =?utf-8?B?OENVdWtVNWh3SVB1eGpDcmtIblUwWi84MUxwN1oyNTQ4bVZWaG5HYy8ydy9j?=
 =?utf-8?B?YmhqajhmdTA2QmtRK0VtNUhlMkFIdWk3djM0em5yVzFOZTE5bHpHb3NKeEdI?=
 =?utf-8?B?Y09CdXdQajU3b1RqcjJXbU9IQXZlMkdpamJ3Y3FXTVBTTmFiRFpReUIwWWRz?=
 =?utf-8?B?TDVVb3NpWWJzb0ovd1JUa1B4ekhISmdSRzJraVdiLzR1QUgyYk8xYjVJODRk?=
 =?utf-8?B?RnUvR2RxclFXY1cyNzduQk5RT3h6dUlCMEVpZ3lWQldMNmQzT1o2RjVNWWdQ?=
 =?utf-8?B?Nm5nUnZ6RVR0RGV6ZjZhSFF2QXNtRnlZSWp2R0hDYmJCYUdxUFRrSitSY1Q2?=
 =?utf-8?B?Zzh3emptM2xBTjEyTUFCejZmUytYUGRLMEthL1k5T2xJcWZmVHdZYjZsSzI2?=
 =?utf-8?B?YzRFRCtXVW45TEZBYkU1TGdCOXVXeThyZjZQazZNZXE2bGlROTg0NldyVzBG?=
 =?utf-8?B?YmcvdFp5VDYrUnY1M0U4ekVDVWVzOVV4ME9zTmZmc1ZFKzZMLzlGNFRIaDRV?=
 =?utf-8?B?QkdENjEzeHBYektuNXFtc0g3T3ByY0xXb3kyUjFKOWo2SU5UTjNXdXp6TnUr?=
 =?utf-8?B?dUcxa2ZRd3N5MXVxMTBqRXlrRjkvaUZKZHhLZjIySTF1dzVzb1hnZ1pDT3dG?=
 =?utf-8?B?SU1sVWpPVzRqaDN3N3JqNkh3cjJNMUxmUEFibm5BWExjbEEvTFpRcU15aXF4?=
 =?utf-8?B?THYvdkxFRnB3SlVvS1RJTFRKZ0JxdWg2NUNiQjYyRWVUaTJzRUVldGJITWZ1?=
 =?utf-8?B?bkF1Ujg3bm5YV2JoT0t2Tk9Melg2Wi9KR0VWZm5hdE1McE5LelVnblZTKy9v?=
 =?utf-8?B?eGxTY1hTNy9EWUJqa3FTK0R6dHFoWHJKRDNqRFhmQWd2Wm9qSkF2STdJSmNa?=
 =?utf-8?B?cStjTitKUG1CQ3lQNkhZektpYVg4V1ZTNWpORVAxTlpKNTJ1ZFlRUUpmVnd1?=
 =?utf-8?B?cGozRVY3RzVuZWI5M1hxSVFGR0ZEakZPVXdxYjVZSzdDdHZNa0xGMW02elQ3?=
 =?utf-8?B?MEU2QUt4a0VNc3dsamNRQVgyNEwrTit2dnJlS2ZrTXRKT01LL3dwM29IYVZs?=
 =?utf-8?B?YjArTFd5OVN4UWRsWGE5VENzV1c4b2haclcwbkQxUnBnYW5ISENIeXVqUzJI?=
 =?utf-8?B?TWRhdWZXTEtqOUREd2tKVXlSZTN3NVp5R01YRGVxaDVuYlluQ3JGYk5QUVZQ?=
 =?utf-8?B?SVhieitBUDVSOTBuU1RGdWJhdEhWM1hFL1JFUEZjcTJscXhFenRnWXhsT1lz?=
 =?utf-8?B?ZDl3WXM5YmF0TnRMQ3BnNEdNdWJKTzNaaWJWWlhPWEJSRktROHJScm9SNWtV?=
 =?utf-8?B?U2lENkRwNm1GRTluUFRjdWJ1eXVCaUJmYnliVlM4TytKVXZadG5tR0x1R1FG?=
 =?utf-8?B?b2Q5aGRhVEtaeURNWVBpVjlLQUs3RDZuZUIrd1NjRDVvemdlSDdSQUlxL1RM?=
 =?utf-8?B?bTcxUkNsSHN5REhFOS9TbkdBWGtsYVhKVHpURklpWGJEMnB2bzI3azExMkJH?=
 =?utf-8?B?eHZjRUpnWlNNMHNkV1c0TWtqNHRzdWFtREJleCt0cmZoem50Rkx3WndLSG9w?=
 =?utf-8?Q?IBSVMPlzNZsmfuzn4x9Mcak=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVhUTTZPY3ViQlR5Y1R0bW82Z2ZDZGZGbEFUZHQwNnZiNE1OeGlVUWg1aWRw?=
 =?utf-8?B?Wm8wYXQ1MGo1N2pWTWNyVVZhM3Nzek9SRzdsS09NdEJCbGJ5VTZNSFJVVHlw?=
 =?utf-8?B?YUt2Y21KWlJHQ05tOUt0K2hjK2ZocDY1ZUZEY3g4ZTkwSlUyZ1AzQU9RK0FD?=
 =?utf-8?B?cUtYSnRNQThFZ3ZWQVNPL2FPVk5XeC9yMTBKNUVYSXA0NkszK0RoSDU2ak9u?=
 =?utf-8?B?ZXRzWG0wbk1pSUR2cWo1YXo5MkV4ODEzSHRGOHJqTGx5Q1RUL2VlN2ZQQnpF?=
 =?utf-8?B?d3JadllEVUswR2Vjc3NwUmRxZTF6aUJ1VHoxTHg0R1hXMTIxREV6dGJ4bDkz?=
 =?utf-8?B?WTNOS3drd0d4YWFrWXc3VURGK2h0TkVnMzZyYUwvREpJdkN4cHJ3aVQ1Z2pE?=
 =?utf-8?B?d3UvYWNRbnM3ZUNJZFNvMEdjU3RVUkg4c2V6TzJkNFU2TjlmY05HQzFReEQ0?=
 =?utf-8?B?NGlwWEp2SmtQU1oxZEpSRDB0eUNFMlZxK0NEZ056MTFCZ2ZLNTFsaUhxRGc0?=
 =?utf-8?B?ODFKKy81Zk44MCtqSEZ1MC8xUFJlNVhKWWZrQWNiaGwzaXJuSjh0Q2thU3M2?=
 =?utf-8?B?ZGdUeDRlbnViUDRtRW92d25GUkNnOXNFUVVuTGpJRXVnNW9TSFhLcklmRkoz?=
 =?utf-8?B?MGcvVnk2Ni9pZDdPcXU0N1p2TjVTampUNTBxWmtyLzlGek94MjNsTDlKUmVu?=
 =?utf-8?B?N3RGTUh4TVN3Sldtam1PMWFvZzUzNkduSGczVWhsb2JwNVVnOXVIOW5BeHV1?=
 =?utf-8?B?N1p5Y3dOWFlkNGM3cHdlcDBHZWRmTjJ6TFRianlYTTdBQVpCaGViZmFwUzV3?=
 =?utf-8?B?bzRMNUNHZFA3UEpzOGN6d3FiYit5c3pmYXdaV0JMV05YZldMMm5CalBWWEJi?=
 =?utf-8?B?dGUwQjF1b0t4L2pyUURGQWxEMEVYbVgzZHpLVThMQWxjNGtOblc3aWdndSsw?=
 =?utf-8?B?RkZHRWVwRXJRV2RRY29KeURnZTNvenBiT3hOZlh0V3BxbEl3QUNZazc3SjBr?=
 =?utf-8?B?VzNXMCtMUHVtaVhpNnN1YmZGR3l0QUJuRk8rR3BKNWxWcGMxMkdWZWxOS2pl?=
 =?utf-8?B?eWdIY3N5ZFF1NFNwMmFjQWFCS29yOVlucjZMc081cG5wWWZSMjlZUTVENktw?=
 =?utf-8?B?VGxoTE1YMzI3VnI2bU52anVpcnNsVGJERXVoRk9PQzB4UnA1bUJJMTVtNjVX?=
 =?utf-8?B?TEQ5YXQzTDBxSWh0RVJnR0Jxd2czU1loaVVRVEpGc0RuL3VNb0JUNGRXeUpV?=
 =?utf-8?B?aS9EdmFqbnNXSmhPMmladGkvcDdnYkM4THpCWEM5T0lvdnVYa0FVcWI2NlVv?=
 =?utf-8?B?K1A3MExoYVRqcG1oZFVzS00rd24yQjdDakFiRjVKSVpWZWhCanhJUi92NFFj?=
 =?utf-8?B?UXF1NGhOeDVuZll1bEtKMk9UMEtrZUMzaGRhZ0wyVkJLd0JXQnVSZTlEWHBo?=
 =?utf-8?B?RUJ3bC9xRDZsNlZkNjNpd2lwWnlHR1pWNEdETXM1WnRUS0UwRVBVYllmUW5w?=
 =?utf-8?B?Nm9GZzhtdXplcGVqbGZrSUQrTklJRmNYQnl1U3hSQWJOUzBCTkZTQks0V1Jh?=
 =?utf-8?B?ZTFudDVWV0lVY0h4NDhpdWFYcVU4QlV1eVNsQWlCeVZhQ0dFc0FCT3RrVUhD?=
 =?utf-8?B?TW9RWmlPWC9ZL2ZPdzVpSGdXdTJNNkZPejRoSmY2Y3ozcmdqOUg2azVub1lH?=
 =?utf-8?B?TTQ4NmFTRDB1QWVITldNMXNiOENXTUR3UEVkb1p6MUJZTms5REpuVWc1TVdR?=
 =?utf-8?B?Rjl3b1BJOXhpcmJqLzY0bE1NY3NXOFRXdFJPMnRBVUlNYnlzeHd1ODRIQWtM?=
 =?utf-8?B?cWZsTThSOHJSaVd5bWdaVXIvdnlDUFViNnkxUWdGWnFuUVFDWnZRVXlYbmhU?=
 =?utf-8?B?aVVIb1llR0dCemxqUGR4YXE5QVQyZUZ3bEpwTEZXOXhtMGE4TlJMQzk4Z2VS?=
 =?utf-8?B?d3FjU3J1TGtnVlczOE1NcGlCRk1EZUlWUHl1UjJKZUgrVDVVZzhQbEFCc25K?=
 =?utf-8?B?bEt2M3VFSGZzQTQrRjVjL2ZSTm03QnZqTmhWWW5nTTRDK3V2UkRWT2cwdUVl?=
 =?utf-8?B?TEZMZk9CUHpNRnl1MGQ5VWxWVEhBL2djRzVpWHNBSnU5R0Jma3drV3dDRVJt?=
 =?utf-8?B?eGw3dW53cllUYlZGTWN6L1pOMW1oalNDTjFLM2Y5T2xvYnBrcm1FRU1sV00v?=
 =?utf-8?B?bmptQmR0NlN0Y1k1TTdVWmx0cklrdDZvcFRIOURKcnFxdnRTZGRMQXpwd3R3?=
 =?utf-8?B?UElhS1JpaWtZSlVFeHFuTHNzYkJqV1owZWY4VGJ3REZjM2ZNL29GdnBpOEZj?=
 =?utf-8?B?NHpDakF6M1VuWUxsK05qd3ZWL21qaHhoOStaWnlnZHdKM2FrZ1Y5TmRkNmVX?=
 =?utf-8?Q?wlZOSL8V2OXgp844=3D?=
Content-Type: multipart/mixed;
	boundary="_002_DM3PPF63A6024A907097A88AEB32669C1E5A393ADM3PPF63A6024A9_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8b3c30-ec81-4c9a-4853-08de5ce138c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 13:45:52.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EujDlRN6hDQYerCkWRIAZfM9gN9AkHs2sGfrPh5DK2LLPIvSqucJa/BfuJAO3FvgBAlvw2UOxG5mrSbKFWph0I3N3i0t1DfuN+GA+HfupebhYn1sPth6LIZ6cL67TYXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF814058951
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31178-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,sipsolutions.net:email,intel.com:email,intel.com:dkim];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D35CD891CF
X-Rspamd-Action: no action

--_002_DM3PPF63A6024A907097A88AEB32669C1E5A393ADM3PPF63A6024A9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgQmFpbmJyaWRn
ZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAy
NiwgMjAyNiAxMDo0MiBBTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0u
cmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo+IENjOiBrdmFsb0BrZXJuZWwub3JnOyBCZXJn
LCBKb2hhbm5lcyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+Ow0KPiBiZW5qYW1pbkBzaXBzb2x1
dGlvbnMubmV0OyBndXN0YXZvYXJzQGtlcm5lbC5vcmc7IGxpbnV4LWludGVsLXdpZmlAaW50ZWwu
Y29tOw0KPiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJldmVydCAid2lmaTogaXdsd2lmaTogdHJh
bnM6IHJlbW92ZSBTVEFUVVNfU1VTUEVOREVEIg0KPiANCj4gT24gTW9uLCBKYW4gMjYsIDIwMjYg
YXQgMDc6MTU6NTRBTSArMDAwMCwgS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIHdyb3RlOg0KPiA+
DQo+ID4gSGkgQ2hyaXMsIGNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB0aGUgZnVsbCBsb2c/DQo+
ID4NCj4gPiBNaXJpDQo+IA0KPiBTdXJlLCBmb3IgNi4xOC4wIHNlZSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC0NCj4gd2lyZWxlc3MvYVREb0RpRDU1cWxVWjBwbkBkZWJpYW4ubG9jYWwv
DQo+IA0KPiANClRoYW5rcyENCg0KY291bGQgeW91IHBsZWFzZSB0ZXN0IGlmIHRoZSBhdHRhY2hl
ZCBwYXRjaCBlbGltaW5hdGVzIHRoZSBwYW5pYz8gDQo=

--_002_DM3PPF63A6024A907097A88AEB32669C1E5A393ADM3PPF63A6024A9_
Content-Type: application/octet-stream;
	name="0001-wifi-iwlwifi-mvm-cleanup-IWL_MVM_STATUS_IN_HW_RESTAR.patch"
Content-Description: 0001-wifi-iwlwifi-mvm-cleanup-IWL_MVM_STATUS_IN_HW_RESTAR.patch
Content-Disposition: attachment;
	filename="0001-wifi-iwlwifi-mvm-cleanup-IWL_MVM_STATUS_IN_HW_RESTAR.patch";
	size=1754; creation-date="Mon, 26 Jan 2026 13:44:20 GMT";
	modification-date="Mon, 26 Jan 2026 13:45:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MjQ5MGJhN2U5YWRlY2QzYTRmNjdmM2FhNzQ4YjU4NjhjOTBiZDQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJs
aXRAaW50ZWwuY29tPgpEYXRlOiBNb24sIDI2IEphbiAyMDI2IDE1OjM2OjI0ICswMjAwClN1Ympl
Y3Q6IFtQQVRDSF0gd2lmaTogaXdsd2lmaTogbXZtOiBjbGVhbnVwIElXTF9NVk1fU1RBVFVTX0lO
X0hXX1JFU1RBUlQgaW4KIHJlc3VtZQpPcmdhbml6YXRpb246IEludGVsIElzcmFlbCAoNzQpIExp
bWl0ZWQKCkluIHN1c3BlbmQgd2l0aG91dCB3b3dsYW4sIGlmIHdlIGhhZCBhbiBhc3NlcnQgYmVm
b3JlIHJlc3VtZSwgdGhlbgpyZXN0YXJ0X3dvcmsgaXMgcGVuZGluZyBhbmQgSVdMX01WTV9TVEFU
VVNfSFdfUkVTVEFSVF9SRVFVRVNURUQgaXMgc2V0LgoKU2luY2UgcmVzdGFydCB3b3JrIGlzIG9u
IHRoZSBzeXN0ZW1fZnJlZXphYmxlX3dxLCBpdCB3aWxsIG5vdCBiZSBleGVjdXRlZApiZWZvcmUg
dGhlIHJlc3VtZS4KCkluIHJlc3VtZSwgbWFjODAyMTEgY2FuY2VscyB0aGUgcGVuZGluZyByZXN0
YXJ0IHdvcmssIGJlY3Vhc2UgdGhlIHJlc3VtZQpwcm9jZXNzIHJlc3RhcnRzIHRoZSBodyBhbnl3
YXkuCgpUaGVuIGRydl9zdGFydCBpcyBjYWxsZWQsIGluIHdoaWNoIGl3bG12bSBzZXRzCklXTF9N
Vk1fU1RBVFVTX0lOX0hXX1JFU1RBUlQsIGJ1dCBkb2Vzbid0IGNsZWFyIGl0IGFueXdoZXJlIGlm
IHdlIHdlcmUKYWJsZSB0byByZXN0YXJ0IHRoZSBody4KCkZpeCBpdCBieSBjbGVhcmluZyBJV0xf
TVZNX1NUQVRVU19JTl9IV19SRVNUQVJUIGFsc28gd2hlbgppd2xfbXZtX21hY19yZWNvbmZpZ19j
b21wbGV0ZSBpcyBjYWxsZWQgd2l0aCBJRUVFODAyMTFfUkVDT05GSUdfVFlQRV9TVVNQRU5ELAph
bmQgbm90IGp1c3Qgd2l0aCBJRUVFODAyMTFfUkVDT05GSUdfVFlQRV9SRVNUQVJULgoKU2lnbmVk
LW9mZi1ieTogTWlyaSBLb3JlbmJsaXQgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNv
bT4KQ2hhbmdlLUlkOiBJNjQzNTEwMGM4ODA5NzVjZTk1Y2FjMmRiZGY1ZWMxNjAwOThhMjI5MQot
LS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmMgfCAy
ICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmMKaW5kZXggZDgwNmI4ZTUwZWMw
Li5hNmQwYzUzYjk0ZTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL21hYzgwMjExLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vbWFjODAyMTEuYwpAQCAtMTQ2Nyw2ICsxNDY3LDggQEAgdm9pZCBpd2xfbXZtX21h
Y19yZWNvbmZpZ19jb21wbGV0ZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywKIHsKIAlzdHJ1Y3Qg
aXdsX212bSAqbXZtID0gSVdMX01BQzgwMjExX0dFVF9NVk0oaHcpOwogCisJY2xlYXJfYml0KElX
TF9NVk1fU1RBVFVTX0lOX0hXX1JFU1RBUlQsICZtdm0tPnN0YXR1cyk7CisKIAlzd2l0Y2ggKHJl
Y29uZmlnX3R5cGUpIHsKIAljYXNlIElFRUU4MDIxMV9SRUNPTkZJR19UWVBFX1JFU1RBUlQ6CiAJ
CWl3bF9tdm1fcmVzdGFydF9jb21wbGV0ZShtdm0pOwotLSAKMi4zNC4xCgo=

--_002_DM3PPF63A6024A907097A88AEB32669C1E5A393ADM3PPF63A6024A9_--

