Return-Path: <linux-wireless+bounces-16544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82B9F6ACD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A8716C160
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 16:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D41E9B39;
	Wed, 18 Dec 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpxF4+uu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E52130499;
	Wed, 18 Dec 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538365; cv=fail; b=GPRsq2HNSfEcFO0FrdHnWpkYJ3w3ngB5pyruknWDQX+PgaQuB/Of4Lbd2LgNJOYQuXw4hjtGODv/oKEIkbhyfydsNp/VePkyb8FkMUu9a5UKzvFt/gRn0zbYDBxDvXeX0DgnX1FBxYqrltIPpGXSPH9S/h1TDtpaY2xP3INcJTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538365; c=relaxed/simple;
	bh=ZmE0wZQTQe9Q1fhUhpuU0WCyd4xO4WBTLX9eyevm9uE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9Jmd1ZNcnYFP2Nsy6KukJAIj+Bq//Ba4da48WLqTCb+AgO6wGrRg4w0NTUNHzb60RZ2aEOjOFXOIaItBdqTFUGMvJwMT41fnIq7C6y3ZfjGy2N170gAix+zULiUwWaUhWYOdGa5nkJvhkksk82mK40piluQpeJ9h4zRy4ajg4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpxF4+uu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734538364; x=1766074364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZmE0wZQTQe9Q1fhUhpuU0WCyd4xO4WBTLX9eyevm9uE=;
  b=YpxF4+uupgwCLhm61rMK6w2e8Gm2CSXkXI1az1vZW/7x8pViz5oLEYRh
   wYdnJdhcvyLZtHKqDBkTzupN0JYA1n4uL3i7RVl3LJ9yX5+MJQDtSbt0X
   9Lqg9WCTUIWupt+5jmj9ofUiOJwwE1OzeeKumfRE3/kcF6QtVaW2Tf7UY
   ghUzmTdIzTzRDZhs0tNZkJqKERDCodI4pp4s8mo4428wbOKqA2veHP2/a
   zPOcU7O+tSi0SAO+ampkgZascvKsvZEfH0VqTrGvn1iXunpR3+UaAA2sI
   tXgV/bnPwhCYeTWrr/MZzyXaZQ538W20zRdG2IBq/253rsmatOoFa6Ob/
   w==;
X-CSE-ConnectionGUID: LcdSP86dRvecSu8Ve8/pBw==
X-CSE-MsgGUID: AX22Ic+HS8+LrRXA9fviHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52548163"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="52548163"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:12:41 -0800
X-CSE-ConnectionGUID: XANxcwVjRR+sN3kJkw5ZFQ==
X-CSE-MsgGUID: VNF1XGorSS6BovxoxlnpRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102910659"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 08:12:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 08:12:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 08:12:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 08:12:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khdrRY+2n59SlsvE8mlzCdLqdmYDlOLdAlhKZujjNQytEpxlcJbRQWmzvkcWgqwPeaDL5HOBR7CUjXKCNI6VwNvJ2Y5TlXX8j1xJ0w8Hzg7i8eN9SQz5di8wIq7bx5AwDZsoaUsuKdj0ykzvylJw5JBlYkgHbOo0yQyY1QYIlRiaV4rzvnkmsDpeJg7y9WrasMRQu8X3X4ycMLQS1flrzwnZ0v3DVrVpZM+myJ8LjqbMgQE0UT7w1VwG4vcZSKAamNYwVsG41JFYkHddLsDVTlOWTH0WRwWiFgecLnFdhXrFKDtGyFYU8AsJMXY1gMpU0HhSK09y+HKdE1cNV6lUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJOXIlxTitbgwGkbG29Xs7xd4zOr4yOqsalLJ7SmFbg=;
 b=VaL+XhEM8gKO4ff25d7Mq1KMxSRybELWif7083kRMyzTX/7pTGzKCz1KaxSRA1gkkWXJQdop2xtYfbgJ5skGH+znBwp4b5hjFjWoncyO0rRfuMgj8tE1JuGdincmmYP+xmeTpsDx7dcvqkRMFNTOFIAQ2rnUv8B+9TE7fhYEZ8DtSzjiA3hs/8XCcdITRLTIHvueqha2fq/GARKmfODbbbIwjoMBk2kxTK74hyZGI+ZKTViDb4jAfE92l1440uuKS6Fo/Wg5CEgHocU1nZuZVEtTKrzl4soNLz2+AMp1ezlm27cLRiz3e/5+9SAOivSEwgp6WLV+m2PR+yDv0n7RrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 16:11:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 16:11:33 +0000
Message-ID: <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
Date: Wed, 18 Dec 2024 17:10:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error
 messages when -EPROTO
To: WangYuli <wangyuli@uniontech.com>
CC: <nbd@nbd.name>, <lorenzo@kernel.org>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <sean.wang@mediatek.com>, <kvalo@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alexander.deucher@amd.com>,
	<gregkh@linuxfoundation.org>, <rodrigo.vivi@intel.com>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<raoxu@uniontech.com>, <guanwentao@uniontech.com>, <zhanjun@uniontech.com>,
	<cug_yangyuancong@hotmail.com>, <lorenzo.bianconi@redhat.com>,
	<kvalo@codeaurora.org>, <sidhayn@gmail.com>, <lorenzo.bianconi83@gmail.com>,
	<sgruszka@redhat.com>, <keescook@chromium.org>, <markus.theil@tu-ilmenau.de>,
	<gustavoars@kernel.org>, <stf_xl@wp.pl>, <romain.perier@gmail.com>,
	<apais@linux.microsoft.com>, <mrkiko.rs@gmail.com>, <oliver@neukum.org>,
	<woojung.huh@microchip.com>, <helmut.schaa@googlemail.com>,
	<mailhol.vincent@wanadoo.fr>, <dokyungs@yonsei.ac.kr>,
	<deren.wu@mediatek.com>, <daniel@makrotopia.org>, <sujuan.chen@mediatek.com>,
	<mikhail.v.gavrilov@gmail.com>, <stern@rowland.harvard.edu>,
	<linux-usb@vger.kernel.org>, <leitao@debian.org>, <dsahern@kernel.org>,
	<weiwan@google.com>, <netdev@vger.kernel.org>, <horms@kernel.org>,
	<andrew@lunn.ch>, <leit@fb.com>, <wang.zhao@mediatek.com>,
	<chui-hao.chiu@mediatek.com>, <lynxis@fe80.eu>, <mingyen.hsieh@mediatek.com>,
	<yn.chen@mediatek.com>, <quan.zhou@mediatek.com>, <dzm91@hust.edu.cn>,
	<gch981213@gmail.com>, <git@qrsnap.io>, <jiefeng_li@hust.edu.cn>,
	<nelson.yu@mediatek.com>, <rong.yan@mediatek.com>, <Bo.Jiao@mediatek.com>,
	<StanleyYP.Wang@mediatek.com>
References: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: d3085d07-0b1e-4b0d-72f4-08dd1f7ea3e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2lhNG9mb3hoYkF3cGxtZUVVUEM2SUxUa0VsY0tVWVpNdEZjVlF2V0hWQ25V?=
 =?utf-8?B?ZnNXeGY5ZkRCYkowR2cvNUZUQ2g3QWhRTVBXbm1oRTBVWDVSaUw5V0VSZ0p2?=
 =?utf-8?B?M2N5bWhqNDZack9uZUMzWEY0ZTVCUDZUaTZ2VE0yM2hhTEJlUVNFWUdmbzhl?=
 =?utf-8?B?S0pvY0tmRlJxT2xqZ0pLR29ZeEZ2dWVBTVE2Z0N1cGt3RnVmb0VuWkJWTmxo?=
 =?utf-8?B?ckVmRktVVUtnYnQvWThtZm8wSVFJbnJjQVVsV1RFSitqRkRJRzA0YW5HaGVk?=
 =?utf-8?B?dHlHVGF6KzVsQlBFcE1Ic0VLMzRPTjA1Y29LbEVHV1FUVENQNkFMKytqaHRO?=
 =?utf-8?B?VS8xUjNVUlFtN212U0VHMU55azFJeXBKaGJOZlVINUk1Ni9xaHZub2ZJTkJp?=
 =?utf-8?B?UFMzZmF0cmdYaWV0SDJNTmZSUXp0L0hmVkVwV0NHU2YrTzV6cW9IL0YzdU9q?=
 =?utf-8?B?OUM4VEZ1bUtrbFZEaVQvNHo3ODMxLy9NcnVZR1pYREpnWGREbmgyN3NQRVRw?=
 =?utf-8?B?TnpmOTN5Y1hqOHlneG42d0FjVFljTi9JRzJXUlRQa1lSZ0Q1ck9PZzg2SnFK?=
 =?utf-8?B?dkxsb1Bnaml5ZVI3Vkw5UWZyZUtRb2tSbzRvSEE4blVJeFQzVlByWDNEUUxm?=
 =?utf-8?B?b1BMOVdwVllOOHdIcVMrOHgxb3pJbC9SMDVLZC85aTRjaGExZnNTQ3VqRlB5?=
 =?utf-8?B?cTYrdCttUlBvUk9JZEdkVFdHSEhMbUs3MW9lUCtPWHJMTGwrbFpOdktyWGlM?=
 =?utf-8?B?YitIek9jeUZGL0hvRmdYWWRBQUtvNUs0S0NYQlgyRUptSUI4MUM1NGpWQWpl?=
 =?utf-8?B?aUJNZS9rZjJHT1MwWXdBRFJBVWw3eVhxa0xFL3ppUktKZEtTaXBLckdSN0sv?=
 =?utf-8?B?ZGk3cTAvbjlaL1VCL1ZiRVo2Q2dVRFlnY3dOT0cxTGpoUzZNL1BmOTlTTi82?=
 =?utf-8?B?YkpzNWF3N21wUnl0bVJWRlNZbFVZUVV4dnk5TXNYdmFid2VIcFo3bkl2TEpL?=
 =?utf-8?B?S1BTdWdiQjBEN1NySml6V3U5T2xIZnlVZ1NtelErYTROaHpFZ1N0MjhMc3cr?=
 =?utf-8?B?Vkc2U1RQeHBOYTdXZHBZbWlOYWpwNVdZRmdWS2NKczZQVWpPS0N4bFRUc1ZQ?=
 =?utf-8?B?ZkxNcTczNXZCV1B4cmI4bmtRTDFvY3dpKzdPankyM3gwdFNaRTVlVW82TVZK?=
 =?utf-8?B?YjZYMzJVUjhsMnpjc3ppRDViMU1jQm5tblhYMlJ6ajAwN0pqbENsMUM4WUpF?=
 =?utf-8?B?SFNNTzRNYmxnOTBWVmtrU1lYVmJkWGVMTmxyTjA3aSsrOEtLU2hYSE04N3Bo?=
 =?utf-8?B?TjZyOVhyRFphSHMyMmRlTFNlYVJTNDBaQUY0Y1ovM0RneDJKWjJWOFdRL0lU?=
 =?utf-8?B?YlY1bW9LM0s2MU9mZURQc3NCeEhvc3g5VEkrYk84Z3J6WGZmRFd0TGJ5RU43?=
 =?utf-8?B?UXJmN3JGaG1MMERybjJHM1UrTGZZUWNwQVZzQ2IzSXE4UHJ5VVdkRVJSWjBL?=
 =?utf-8?B?cGZvY1RGY2dNVHFBVjNKbFFoOVZqWXVNZHJzZnVPdlI3L3VnSDlNd2ZodDZD?=
 =?utf-8?B?QS9yOVluTzUzb01WL1IxN2gxdXVKLzVvNGlGUjB2aUpiMUp5SFpXZWlKcVBt?=
 =?utf-8?B?dGpnQU1XSGVld3VIaUZHclc3YytiRWR3ZzdjZnpkSnA2QlJRUGxlVWNKSW5L?=
 =?utf-8?B?TGRhT3lKaE9NcENtaE9FYXgwNUJ6d3dsc0NuakU4azZaQWNreEdZVTdiUEJD?=
 =?utf-8?B?bXhDUzJvOU82Z3l5aWVtWEhseFQ4eWNrYVZqQmoyYndTMmwyWE03ZDJhc3RS?=
 =?utf-8?B?UzVBNk5kaCt3Mys1QzkxRWROVi9PckJDM3ZQeU5qbmxiRUZhWW1sNjZid3kx?=
 =?utf-8?Q?oK8YJKohX3Fas?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhXOEpJNURSd3pWU0VMR3k3RXQvL1NKQ0ZoWXBDa2d5bDlyZnpiNXpFeFNq?=
 =?utf-8?B?aHlaOU13dXhoSlJpdXNCTVpvSkFTdm9sT3dMVmk1ZWswNHEvRnNrZjhqckJN?=
 =?utf-8?B?ZmFENlFMa3k2NGZ1U05JVmVHL28yRGJDUStOeHo0NExTMGN4VzRpbThMQkJW?=
 =?utf-8?B?Zmh1SzQ1RGhlY2RnV2JpQWtrclRyZjgxcU1xUDRsdG1IWlQxclAvQzJpWVNY?=
 =?utf-8?B?NWtieDVKMWhuUTRQNVI0NXQzdnE0MlBFaDY0ZjRsSzk3eitpQ2h5TktyeFJL?=
 =?utf-8?B?Nlo4c2taOHlFZENUc0t5SXVyc0FBLzJYNERieFp2UjRiaVdUdno3SlVJQ0JK?=
 =?utf-8?B?Y0NUSmp0Y0ViQkNwdiszN3FROXhLTEdTUWdzVGt3VzU1QzhWd05GSVYzSDZk?=
 =?utf-8?B?Z0s3Q0xwVFhuNDJ1RUpoYmxrcW9mRHdkd3pseUkvWmliZThUVG1YWW13cjZs?=
 =?utf-8?B?RTZyUzhpMnRuWHRKYkx1VU55VHR4Nml5YmV4NFI3bnlJNnQvYWNtUWkxbTJm?=
 =?utf-8?B?RWM1MWRUVUs5Qk9BVzhnRGtnMm1VV24ycFNkYWUvVkF1dnVUTzJaM25RSWVl?=
 =?utf-8?B?d1hpT3hrYzNuRS8vaTF6UWYvZnRZc0RDbEZQbnpBTnIzUWIvdUFvcTZ4RUh5?=
 =?utf-8?B?T1A0cWlVQUhLTFhGRHVtMlBsajF4TnJrb3BuNXoyN1h1Y1pqNFYrc2RuTXVF?=
 =?utf-8?B?UWt4WUxDVmRlN2dybGV2aTNrNE5MV3Yvdkc3clNwa3EyUERnRzRzSkpGeUx2?=
 =?utf-8?B?QkJyT21nUDhMYnJjYmkxUjZaM09waThsUGM1cGdUenZQM2RHRDRoeXlRK2lJ?=
 =?utf-8?B?WGlVSGYzVm9pTWhUQzROR21EZ0k1aVhKeGpRSWVlZFJiOHY4dEpXM2VtdkQ1?=
 =?utf-8?B?bEQ2dnBOajZRMEwxSlRXYlJRZzUzcHJ2ZXNHUTlUeHd3NVNPaW5UMmZuVmVV?=
 =?utf-8?B?dWVRNlJPVW5YS2ttNmpDR0RXMGtaYzB4b3RtMlhKc2x4UEtGVmZBNDNtR2tW?=
 =?utf-8?B?NTBtbUZmMWxoejNNaGJBRFdFamJ5QXh2UzV1WXhlYjgvWjdtaHpLNTAwRHhC?=
 =?utf-8?B?QXRFcjl5eHFJeHh0Z1Q5dTM2elVEVHozRUR1eVU0ZkdXaVNIM21OWUlGTXB3?=
 =?utf-8?B?NHRRbk9temg3Q0ZUaHZGSkVmSytYR2dhZnpXY0w4Y0tLMmZVUzNDd2xhZkt1?=
 =?utf-8?B?dkoxTEpCeXgrSE5abzc3SE9SQmEvQ1lTdjdGcTAzWEZuQ2xQRFJmMTU4Y3h3?=
 =?utf-8?B?Zk9WSHczaHVtTk5IcEVsaVp0VFNrVjlocEVLcnpIVXh0OHdlYUZzd1l3L0xu?=
 =?utf-8?B?TTdwV0llV1ltb0ZiUXBwakRubGhXeU45T1NHcXB6anVwcU13UStZbEMvVnp3?=
 =?utf-8?B?M3NJcVVpb2l2bDcrUUhpUENuUUwvZDJxVUE1YU1jS0RDam5ET2RtVldxS3RL?=
 =?utf-8?B?MDRoTUsvMC94RmV3SzZneHhpZmthRW9wemlBUkVTbWozUUdaSUxZTVcvdXZu?=
 =?utf-8?B?TVpmaVV5ZFZ3eHZyMm41WWRVYjZheHhGUmZxMW9oTkJKODRmWGdZM0c1NGxp?=
 =?utf-8?B?cnBnbnNOYVEwUVJJSXFkTlMzUXMvUlNRaFkvdGdNT1NrRXhmZXY0a0JLeVF5?=
 =?utf-8?B?OFdxc2JTQVdpM1hzNEs2U3RNTkUySzBLV2RtdHZwL0RxQkhJSlQrRXVER2Jt?=
 =?utf-8?B?VHFrRk45aG5FZlB5c1UrWVZyaSs1ZW03K2V6cU4zb2srSGVqMlpIbkJIR0VF?=
 =?utf-8?B?a2NVSDRUd3QwU0dLMmV2WWZYZ3cxK2JBZ2F2TXdNbUVWT3d2R2tDejBnbEVY?=
 =?utf-8?B?aEdxZWRmZ0JOYzBIVVNlem9HeHI1UWx3QVdpdnZUSDRLRFE5SWxEMW5TTGFy?=
 =?utf-8?B?dHZZcG9pV05zSjdQbzNyWXdCLzhMMkZ3UzRKcmNRUHNRemcxaHB2bEs2cmF5?=
 =?utf-8?B?UXBWcmZ4ZjRQWEFOZTRDMmtwMXppV1BaNUJ4ckhuVUpubjBKWjgyTzFJakJM?=
 =?utf-8?B?c2lJb2hrL1M0L1F6SXhraDFNY0JWaFJ0ZER3N29EV0tBeWlXdUpzcnBmUXNn?=
 =?utf-8?B?UHBiMHlWSFcvdDcza3ZUdWcyMjZYYWpLczJjNHJjRVZXRFRyODkyVFZvRXBi?=
 =?utf-8?B?WkJWaGR6dWZoTjl1T3FVZFFQdW5iUFVlcVZmQkRNNUU2OHJ0M1lXZ282dDBI?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3085d07-0b1e-4b0d-72f4-08dd1f7ea3e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 16:11:33.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ii1YSLHRGyoUU2Tg4qtNW1wyKTLzG5pUUXBbqrVEdvxY7XtiClgn99rwbmUEMi2HtBkgDQXcxyxEKRiMn4/ky0M5BXbw2nqMDbZwFeW17sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-OriginatorOrg: intel.com

From: Wangyuli <wangyuli@uniontech.com>
Date: Wed, 18 Dec 2024 17:08:33 +0800

> [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error messages when -EPROTO

Is it a fix or an improvement?
You need to specify the target tree, either 'PATCH net' (fixes) or
'PATCH net-next' (improvements).

The '.' after 'RESEND' is not needed.

> When initializing the network card, unplugging the device will
> trigger an -EPROTO error, resulting in a flood of error messages
> being printed frantically.
> 

If it's a fix, you need to have a 'Fixes:' tag here.

> Co-developed-by: Xu Rao <raoxu@uniontech.com>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> index 58ff06823389..f9e67b8c3b3c 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -33,9 +33,9 @@ int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
>  
>  		ret = usb_control_msg(udev, pipe, req, req_type, val,
>  				      offset, buf, len, MT_VEND_REQ_TOUT_MS);
> -		if (ret == -ENODEV)
> +		if (ret == -ENODEV || ret == -EPROTO)
>  			set_bit(MT76_REMOVED, &dev->phy.state);
> -		if (ret >= 0 || ret == -ENODEV)
> +		if (ret >= 0 || ret == -ENODEV || ret == -EPROTO)
>  			return ret;
>  		usleep_range(5000, 10000);

How do other drivers handle this?
Can -EPROTO happen in other cases, not only unplugging, which this patch
would break?

Thanks,
Olek

