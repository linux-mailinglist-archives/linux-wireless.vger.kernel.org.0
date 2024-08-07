Return-Path: <linux-wireless+bounces-11087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE394A93F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909A11C22470
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23285200131;
	Wed,  7 Aug 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5X3ExJg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410D1DE84C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039203; cv=fail; b=ktHU/NnyhjjJGUxb5w7JsXpqynFHKhO9vZo4peOSgajlJMZ5kN4rLvdNbVflJtOqTEXGyAQAphGArekU3StmaBCagNMfFISAZeQey3HK6NsH7II+flvtJPfwX0g1W2IRS2+a8Sz/wN+Vcs41DFjFcEh1yedCb+zQmvI7/HZi0is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039203; c=relaxed/simple;
	bh=qIEgCaO7i4uezM056d1qGR3NKFTo+PnMOc+GkvCuY6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JDmf0JNiSBjrUsI2nWp4MDBG60bWtah6d2vgbn6RfETe56VOk4GK4URo/M6CZdWhY1BUHDgzjZDE7lvCztXW7+xN0aiaiDFQ2jNDtjz15H/lumrAnSuSustPLF5C8tBizVF1HxJgw9ec6aQ2ahgBbins4vK7hZzxv+6oEZGO7Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5X3ExJg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723039202; x=1754575202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=qIEgCaO7i4uezM056d1qGR3NKFTo+PnMOc+GkvCuY6k=;
  b=i5X3ExJgEHjPwG6ntc6SRb8rQSAwtDyCOdwAWve4mnGKnMtBJ2qtoJKS
   Hbw7x/pjIWAM1su+0ulT/uWWaY/1ovzkYUagzkk2fQKG1HyxFKhtfb6Kj
   5CY5pjT9vd0PxSN0hR7TcMwt0VYbUWn7647Z9dwa1ejS0B5o4MF086gJt
   qg/O0JnAP2yknp9Rlr2r1Y89gZIPoXNz7UnwAzS6eyJACnhKL/REw0Qgr
   VPJFyFo0FGXLvzu6lUrJCIvNwbSA+522jHRurPjzHHwQN18TGP30iSyrb
   cd10+mug6+vKNB7ItRYqt5CxnurqKYas0eNvkrxLdC9lR4NIHbmQo+24J
   Q==;
X-CSE-ConnectionGUID: j/wWMXXwQN6ezCwKKOQy4Q==
X-CSE-MsgGUID: ET0h38yjSuK/kHrD8GZj7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38564875"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="38564875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:59:59 -0700
X-CSE-ConnectionGUID: a25RC9ucQ/y89tEpfeGW4A==
X-CSE-MsgGUID: kIFIYk9BQKijHjk6OQgc7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="61681688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 06:59:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 06:59:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 06:59:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 06:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v44pD0MszK+bMWoV9gKxUdc+wkN06gatqCl4moLs5fo2yGZX+WPgDJPL6FuVgwz+SsMQWIhsx0IWeGCsE3c9zPxVwHxuQzkuXWwuVjp2pLOtVASTFlSp6MqXL9Jn8eUGkjck+7NS+m3SeaW/LkH7SaRZc7acw7rtQrkeF2TkCMCwd9fVp8Vr1cZXRpnznxgiZ0urU3WpZXG+N2UmqTG1lxmlFjtmppp/0zjSNSiwj537tHv079hZM5RiDG0Pf1RYvLamRx7NuDxUoe2lQXOv8p4WMsOSpEUE9FAxREuc+DrLsHXec8np0+627pCeHnCe8/plVh2zxuvgrpe5vynRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9jQWJlk4Khwxdm9yEwx4SwaX/gYjRFpRSxIuhGKluc=;
 b=smYG0NhdsHu4MNdZcH9ekjde0h8t/kuFZOERYjtv9uzdUBItZM7Su/ibGdyJQfAdboTFW+pkXt05uwdtBgq2EaRBthjq46tNhQYliE1oQ54CgKlqkJ0cbbwpR9pYH+s9hDHhw7lpMA0KdmgWpm64mcvaIhVr9jsCcMcVwIVhwK6Pu/W/kh9UigYKQK2Ss5/lNbBxS6VfmdmyRe4S7abP5G38T66NeAQkFoEtk0yMNtPTULdT6zOEF7v+gXF0FG/uDo0fzHrkvRXgfF/h+Ibfw554N5FmIDYUsUvH1lNSS5h8NaIeyO0MbIoyEVXOW/TiJObhpdjLLWAgeUOGkw/ZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 13:59:55 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%5]) with mapi id 15.20.7828.016; Wed, 7 Aug 2024
 13:59:55 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>, "chris.bainbridge@gmail.com"
	<chris.bainbridge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] bisected: iwlwifi: use already mapped data when
 TXing an AMSDU
Thread-Topic: [REGRESSION] bisected: iwlwifi: use already mapped data when
 TXing an AMSDU
Thread-Index: AQHa6LfKJi5SWPHcN0Wv5RiEy1CaarIbtDncgAAGrQCAABUEg4AAAs4A
Date: Wed, 7 Aug 2024 13:59:55 +0000
Message-ID: <a98208c8123695c225ecf09915377fa19cb0fa0a.camel@intel.com>
References: <ZrNRoEbdkxkKFMBi@debian.local> <87le18ile6.fsf@kernel.org>
	 <CAP-bSRboZLWg4pzHHrD66NFeKKbsX0z-wUcxJS4OYmzcHXdG1w@mail.gmail.com>
	 <87o7644f4j.fsf@kernel.org>
In-Reply-To: <87o7644f4j.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|SN7PR11MB7020:EE_
x-ms-office365-filtering-correlation-id: 6bee34ee-2cb6-429e-a18b-08dcb6e9379d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TUNPVkk4d1c4Z1VPbmJWUURucWZOMElFSHYzN0RmNVgyU0RRR1FJYk96b0Ex?=
 =?utf-8?B?Uk1Nc3UvVG1jNEhOVm1Eb2RaQXBGcmROUHVuNktLUHZEZm5uT28vTjVuY3dt?=
 =?utf-8?B?TEtESmpmcU1Ka1RJMGJQVmZCMUhhTVZkSXRGenZxZkozditVaTd4UERxWWRZ?=
 =?utf-8?B?OUlBYmp3MmtLb1dNdzlQYlhQWHJ1TW5xUEFLdFVydCtMNjBDMUFEZlVST0ti?=
 =?utf-8?B?OXJZN2ZEcVRlQ2g2K09qd3BHL3lCRzY0VGNYZG1NSFlNL1pwL3hranRiZmFM?=
 =?utf-8?B?MEJTOXNsRTFPd2pDU1FCNUU2UWJJYVNXY1E1c2JkOXFHZjRZeldWd3FrK3hX?=
 =?utf-8?B?Skd5bWpLd2NwMHRsNWwzSjdOY2VSTmRubUsydzFwS0JTWjJuZHlJdlNKZ1Rm?=
 =?utf-8?B?Nlhqd2FLdjR4NkkvOTJkNG1PM2gxT2tmOGM1cnZoUkNDN2kyc0JqUkJDM013?=
 =?utf-8?B?dGtMOHpreTNwbURFRTNrOHkwa3VING05TTBPUmZEZ3REUmFlNjJpVE1SMHpM?=
 =?utf-8?B?S3MyVzI0TDNXeC9RMm9hUkVMU1BhdTZBOGtpdHR5QjBUQ2VudGZ6ZUJkd0VS?=
 =?utf-8?B?ODU1QW9jaTQ4WUlNTEZYOFducUVYOGkwN0hPWUY1RlVDVGpXak50MkFGNzMy?=
 =?utf-8?B?M1NUVWV6ZzBVTXVXT0EyVXR2SUFHUHhJa3NBUTROajN2VGdRSHQ1YUt2b1d4?=
 =?utf-8?B?R3c3dUM2TnRVSHAzdHMxUkwyNzVKM21uUUZMc1Vwa1ZzYmlPZkoxQUUzcjI0?=
 =?utf-8?B?RGgrNGpsRVVmY2lmcEdId2VoTkJ5SmZYenNESHJXQ1doWFBQTTBYNnNCcTUr?=
 =?utf-8?B?eGZFM3I1NnRtSU1JaDhxcmczajVUby9vSkdqMVRTZEo2aVQ0cEY4TE5FR05L?=
 =?utf-8?B?SkF3VG5NRDFZYjZoQVFabzZ2cytMV0dxV1lDOGdiRUlpS2N1RjZXckExTWs1?=
 =?utf-8?B?THZObXF5RlhnWm9wRHUzYzduZnZSVmw3Zk5qajAzWXBVd2kyOXBmcHZqcVpM?=
 =?utf-8?B?WVRqNFB0czBNS3FHd01kMmZVeUVLQzZQVmFYQmFnd2lQSE1ONFY2UG1KZHJF?=
 =?utf-8?B?STBuYWZUVit5Rjhoc1RmTFFKcnk5alR1QU84KzVpbE14Qi9qZU1PaEJ5d2l6?=
 =?utf-8?B?Z0IwRzRJUm9BNUJiVXlvUWo4THNMVENpM1NQWElkZGlQMC9qL3hBY3l5cUlu?=
 =?utf-8?B?ZkE3bUhpSGJrVUpQeVU3cVBpMFNDbkhTVzMzQ21vK2k5VEZia0dJWjZ1UFhI?=
 =?utf-8?B?VUJuQnJNNHpvcjZSY2d6azZJWUhDNGcwZndZWUJ2SUowQWhjejVnZ2pWbjBS?=
 =?utf-8?B?Y0VyRzI4akdXbTJkSmNhaFdiL3UxWDVZcUVENWhMbm5WS29mQm43c3JzR0lC?=
 =?utf-8?B?em1FSE54M3orVFRWMEhmT0NUcTRYNmtka2MveE52SC9mRTdyZzRqbmZQQU5B?=
 =?utf-8?B?SUdwZTZ0S3ZVeHVIbWpGSDhYNWRlVGlydkdFRS9kMmZDUjk2ZE5VbDNVeHFp?=
 =?utf-8?B?OUhGdy8xalZHYjlvQlJzVXJCc0ljVGw4em1adTV1bkltYlV3b256TFlGNVJZ?=
 =?utf-8?B?aTlNVlJOWEVaYUVEaG5jMDU5L2dRQWhEcEZMRFdZRjBucnJzbFlicUZxaXF2?=
 =?utf-8?B?NTc4SitEV1BkOEUwYWcvVE9Vb0NDdm9hbVFGNHR6Z3YxZzlmTDZyeDhwSnBh?=
 =?utf-8?B?VVBsSnNZR2s3emR6NkR3b0hKZEF5WlY0ZFhZZEtCVFZwQ1NTaXFqRDdZcXhj?=
 =?utf-8?B?L0xIclk0SDJZa0cyMTNrVWtWUUpHcytieWtlaXNXTlJMQWw0Wnd2cUtNMTg0?=
 =?utf-8?B?MU01VFIyNWk2Sm55TWE5bUdNdHRVeWFUWG5SV1M2TUdDNGpjS0xSanJTQTFB?=
 =?utf-8?B?SzNSVzB1YVd2OXkyOE02bzhXV0VITWhrOHJjSllMcWY0emc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjdsSkxTWlBmUVJ0U2tyaWI5MWdZNDQ4Qi8yaFNZclRUdXgycEZyb1cyODda?=
 =?utf-8?B?am52TmZkaE1tZ2pCS3dML3hwazM4bjNVcUwvdDk4aThKWUFHa3VlZ1N4Wnll?=
 =?utf-8?B?SC9HZ3JhVHZmZDNJZDIrVnBOZXdKVWNvNk1QQ3FOdTNveUwzL04wSmNhdlcy?=
 =?utf-8?B?UFZLQnRKWjhwNUozSWgrdW5hUE55azdZTTZwQ2RLS2dyZmp6bmdXeGZqZkRS?=
 =?utf-8?B?cFNYdksrTUR6L2xwaVMzeCswbkhFWHUvY0hZYjU0QnE2ZlozeFVMUGw1L0xs?=
 =?utf-8?B?dDYvQnErc1VOZjFlQjF6NWRqK0lWMFVDL1dENm1nMWE5R00ySkdJRjFIM1BW?=
 =?utf-8?B?bFhxcFdxaGZRNWt5OW5SSkEzRDA3NWNnL0phcTlSSGM5N00xRHBQOUFFNEQ3?=
 =?utf-8?B?aHJYeHVCOUF0ZWo4dWZNSVhpblhrMC9pU1BsSk9paVdYZTdSZGxCMW9STDFC?=
 =?utf-8?B?eC9Oc254MTNxUjBKTXpvcG1iTGIwd2crZE5WVzk2ZTJsL0hpbkdhdjB2ZXJI?=
 =?utf-8?B?WWp5d2RPSXpHLytVd1BJMnQ0MjdEeU5WRTZnQVJvNzMxOEtQY0RCU2xVRFFn?=
 =?utf-8?B?MTBJaloyRzhkcWlOU1lKaGcrTndrS1poSlBBZEF3eVdzdmpNUDllY21xR2Rz?=
 =?utf-8?B?VTJic3luOGdabVdXa0ZXK2FpcEVFSXBHcWxkcFF4TmJvaDBLQVRjVXVPazBV?=
 =?utf-8?B?YktoQmxqSE5QZjAxcFVHc0ttOFAzYXhIVzh6UXZYR201VDVzWHppcm9uK20x?=
 =?utf-8?B?NVV0UkRDSUVYUHZqQm9nek1MbmRFc3NudU5MbEhkcTNIdXA5N1cxZ1B4RUJS?=
 =?utf-8?B?dXlnaWFDVWh3cEp5dExtZW56eTFKUCtTWm13Y3A5OGNocFpZM3M2OUpjbUlC?=
 =?utf-8?B?WjJaSklPQ1FvSHNoUW4yR0gvenlwSHN3bU4zL2JkQXJOalFEeFBrOU5Zc2dt?=
 =?utf-8?B?Ync4QWwraXQwS2svZEtLd0hEOTBQQXpZVjdZVHVhU051cTdnZVlpYkN6bzBF?=
 =?utf-8?B?eUhObmlZelc0dE1zOXUzM3ZPSlFHRmJmVzZZZjdjak1URTI3STc0RERQUXFl?=
 =?utf-8?B?MHFDWkFDR3FFQ1dLbXJqYitjamJ1RXJFcll6SUVXMUVpTnc5M0VuN1F6SHJZ?=
 =?utf-8?B?OVZaQy9JUEdSSHpsNXUwSmNpdFZsaVA1S2dDNXZmblY1Wlk0RnJUN0F4YUdG?=
 =?utf-8?B?MUNnUGxvSG4vc3dBdGZSZVhQemdxUzVBcUZ1NlJpcFlWVnMzbDM4Vk9VcnZH?=
 =?utf-8?B?OFdNZjFMbGg1NzF2K0F0MnpXOWE1bGM1aWl2YnNSeC91aHRKQnhuYXBIczFu?=
 =?utf-8?B?Y2c0eGhoQTZEb1ltMm9kbk12ODBUVzI4RmU3UjFWd0ZnOHhkTlI2dUI3b015?=
 =?utf-8?B?c2cwY3hrSmxJNjJ3bjZmZjl5dXNBUXZSSGowVDhXOHordDV5SXlOeGtsMU55?=
 =?utf-8?B?dnVwREtDYVRrNEJZMFFORnFvR1FGMGVjLzBHWExjWjhVQ1NNajh1L1NmVnZP?=
 =?utf-8?B?RUo4SEdaeitJR3M1cXRudkNjNCtZQXpXczNXMGJBNTRCcE5EMytYNjlwbXQz?=
 =?utf-8?B?cGpTbmp3ZmpPbjZpOXdkUGhmZkQ4VXFBNFArNmhMWjJuZ0FsQWt2SjVsYXhS?=
 =?utf-8?B?OWhnQmNJMExHNWxEMXM4RVhVSUx1VUZFR1AvZzRybUJHUjM2WFF4WFFWazNI?=
 =?utf-8?B?a2xRTnRqNnpUM0pjRnZ5UE9qRlpOSlRlVDVmQnVQcCswNEJVRWpEUzVieVo1?=
 =?utf-8?B?dlNlUENLWUROOXN5ZXlLbE5iMXpKcXRZczQ0MEd0cDM4ODF1NlNCNmVzU3I0?=
 =?utf-8?B?eVI1Tmk1Wm1NaUkrM1NtSkNkRDk5cHozKzRRNjJnbUVVOFEweUdTVHZ4T1Ux?=
 =?utf-8?B?MlZQQ3p3d1U3OWlYdVZGcWNxNW9QbFJ3SXVGejZ2Vk8zendWWm1lVjd5V3Rh?=
 =?utf-8?B?SGhrTkl6eEdFelB3YkVtMEhaWFROS1pxSDlHazNnN0lCejhpdUNDZW1SaTRz?=
 =?utf-8?B?Z3p5b2tPcXErb2kxVVQ2eldZNkhKdER5bWE4S0xsQVc5eHR6UGxGTzdsUi9R?=
 =?utf-8?B?TERsL2NVTnIreVNSWlBObmZEdHJmKzhzRUF6azdRaURjcHcyM3ZYVEZFd0RK?=
 =?utf-8?B?OVN2QzJtUUFHRi9xTS8xbkloelZhY2h6ZEhFOHlRTVJ0dkJrNlpSZkhNYVN6?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12E6DC67DDB01441BF391A073302D043@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bee34ee-2cb6-429e-a18b-08dcb6e9379d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 13:59:55.5869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x172scsD9hVkNFp6xJ2wUeQUSDPWDZba7s0oFEM2GNJgGb14MJWQKhktSNgxVQL0m3BvFyvf5AOieY+Mdh58bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCk9uIFdlZCwgMjAyNC0wOC0wNyBhdCAxNjo0OSArMDMwMCwgS2FsbGUgVmFsbyB3cm90
ZToNCj4gQ2hyaXMgQmFpbmJyaWRnZSA8Y2hyaXMuYmFpbmJyaWRnZUBnbWFpbC5jb20+IHdyaXRl
czoNCj4gDQo+ID4gT24gV2VkLCA3IEF1ZyAyMDI0IGF0IDEzOjEwLCBLYWxsZSBWYWxvIDxrdmFs
b0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+IFtTTklQXQ0KPiA+IE5vdCByZWFsbHkuIEl0IGlz
IGZ1bmN0aW9uYWwgYnV0IHR4IHRocm91Z2hwdXQgaXMgc2V2ZXJlbHkNCj4gPiBkZWdyYWRlZCwN
Cj4gPiBpcGVyZiBzaG93cyB+MW1iaXQvc2VjIGluc3RlYWQgb2YgdGhlIHVzdWFsIH42MDBtYml0
LiBSeCB0aHJvdWdocHV0DQo+ID4gKG1lYXN1cmVkIHdpdGggYGlwZXJmIC1jIC4uLiAtUmApIGRv
ZXNuJ3Qgc2VlbSB0byBiZSBhZmZlY3RlZC4NCj4gDQo+IE9rLCBzbyBhIHF1aXRlIHNldmVyZSBp
c3N1ZS4gSG9wZWZ1bGx5IEludGVsIGNhbiBmaW5kIGEgZml4LA0KPiBvdGhlcndpc2UNCj4gd2Ug
bmVlZCB0byBjb25zaWRlciBzaG91bGQgd2UgcmV2ZXJ0IGNvbW1pdCA5MGRiNTA3NTUyMjggKCJ3
aWZpOg0KPiBpd2x3aWZpOiB1c2UgYWxyZWFkeSBtYXBwZWQgZGF0YSB3aGVuIFRYaW5nIGFuIEFN
U0RVIikgZm9yIHY2LjExLg0KDQpZZXMsIGlmIHdlIGRvIG5vdCBoYXZlIGEgZml4IHNvb24gd2Un
bGwgbmVlZCB0byByZXZlcnQuIElmIHNvLCB0aGVuIHdlDQpzaG91bGQgYWxzbyByZXZlcnQ6DQoN
CndpZmk6IGl3bHdpZmk6IGtlZXAgdGhlIFRTTyBhbmQgd29ya2Fyb3VuZCBwYWdlcyBtYXBwZWQN
CndpZmk6IGl3bHdpZmk6IG1hcCBlbnRpcmUgU0tCIHdoZW4gc2VuZGluZyBBTVNEVXMNCg0KYXMg
d2VsbCBhcyB0aGUgcmVsYXRlZCBidWdmaXg6DQp3aWZpOiBpd2x3aWZpOiBjb3JyZWN0bHkgcmVm
ZXJlbmNlIFRTTyBwYWdlIGluZm9ybWF0aW9uDQoNCk90aGVyd2lzZSB0aGVyZSBpcyBhIHBlcmZv
cm1hbmNlIGltcGFjdCBhcyBETUEgbWFwcGluZyBpcyBlZmZlY3RpdmVseQ0KZG9uZSB0d2ljZS4N
Cg0KQmVuamFtaW4NCkludGVsIERldXRzY2hsYW5kIEdtYkgNClJlZ2lzdGVyZWQgQWRkcmVzczog
QW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55DQpUZWw6ICs0OSA4OSA5OSA4
ODUzLTAsIHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3JzOiBTZWFuIEZlbm5lbGx5LCBK
ZWZmcmV5IFNjaG5laWRlcm1hbiwgVGlmZmFueSBEb29uIFNpbHZhDQpDaGFpcnBlcnNvbiBvZiB0
aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5p
Y2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5MjgK


