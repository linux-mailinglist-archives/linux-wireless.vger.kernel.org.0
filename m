Return-Path: <linux-wireless+bounces-36934-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFd6LzYXFmrOhQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36934-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:57:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740F5DD009
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 23:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B8A6309544F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739993C3BF6;
	Tue, 26 May 2026 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrQAtd+u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA05379EDA;
	Tue, 26 May 2026 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832408; cv=fail; b=qhPS6YW6GeIRxGlJn/5zSli9iQxsv4sN4tmlm9W841LCi7olPsKZ8GqKLoreBYSOTUMlBUfYAvN2P/IUfD8dSU20C9sEVcxGLEbdu0WLeycPTaYIEz5iOZQdqzP2plwUv492O/GJSSAMt58k0vbmMNoxk6HtVgzmCiWcGrH3pNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832408; c=relaxed/simple;
	bh=Ehpq5MMJ78x3kY6o+isS8MWpCiwhOWFQUu1qPysZH+Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IsTU4FZISomMS1LztowFwoUhMdLCtypbuxckxqf7NQnugKYa6AU98EHi9OB4fFFKOry6zD3N1IfsgQIvhrdhX2+qR8aLCXyxFGzE3+xPgBeOqmKsJ18hFvrGdGCoWjYJytyg73IxL4WpoE1gtpH3qVRHAVLyvIBQJj7+MzVil2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrQAtd+u; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779832407; x=1811368407;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ehpq5MMJ78x3kY6o+isS8MWpCiwhOWFQUu1qPysZH+Q=;
  b=mrQAtd+uHroDnw9etzaFQ+qIVzR7V6lfl15ZBfHo1AvVR6MjLWpzzqci
   ji/z4R7jaI5P9aTkvmo9kq35w/71zQVjR5SVzb0mB5ze6jCF6Dg9O2Pdy
   8LZ/yN5Ov1AE7aO54gx5TzmF4t9VNHr7zkOuUHErfNzlYQxdVkQwWFdj3
   4Pa+cJAaIFzwoCXClNxEuyHctPdMuhinX4nLYOGQKeqOMVZpMMw8PM3YB
   R5nT4jpU9U6HxXQmAaUhfOUeBvCAQGrkArw+w6HhQA6/LhWq6RtS+3rpY
   nJKNdSCO6Ta9fbErL3Z/UQ+Hgawk430NiAS8ZMXVjaTnCmkMeKIqmD8sq
   A==;
X-CSE-ConnectionGUID: 6rl4DyNKTS2ty+ucIIIv8Q==
X-CSE-MsgGUID: yFNmvLDtQLe4jrN6hDmnVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80690929"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80690929"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:51:34 -0700
X-CSE-ConnectionGUID: OJwx9vI8SguGo4pm/+GW8Q==
X-CSE-MsgGUID: xrVOy99nRbKI3yW/2ubO4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241884609"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:51:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:51:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 14:51:32 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 14:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+g5Sl3V7TZ9yYpU0UmqYJwquYgnuMXIQJRKF0aLkzmFF6G53qUzJ3LMty9Nvn/rmIeAVsT5fA9n+GCcSdbnBb2XvSg+gU1aZGLAjd0jEmMUsEbtdszEwhEoqOQPuXtcgbg8XrZdIDst9NT2l2+yZ2edKuel8yvrpC87QCaxk6FHjZE7yqf0q0V9Xcc2e7grfElR7UNNUHSo38+oRlfswR2OOMqfhyHXOoSK1WzYTk5BjKLSpzfoYPXXLmowH1ogKNQVqOTrIfqOT2/hRGwJjzSlWtce2knhlu7rP7m5iBKd+XCdB81RXG+qndpFrVtXg138fCJehCpdDI2v/JE3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT4AWX/94iElNwSTJnq1v0b26qqTaJFlSPWg3VoiDyM=;
 b=MzEsrrb9DLrifTelB8cUC/JDehJLO35cYZvolgFy0XQphwDIPfOnzRvuj/U/d+JPfz9RJaxnT8sXkT6YWPLAJGwCdolHzrMYTBPo3Cf5/cnJ4zbpI6QHjHBjevZKpkoqJVID+RvzLRkysLmFZYJmo3VXd85l836asof1mckzWnTrYN/wxCMhQuRiP9vzykZbP9D0angA8jBeIhPOHiFFKHrQmoxLXUetGKBHFymFFdnSwoTvciKD01sPx2s2yT8sJVLsnWCDGt4o5p8czSTCcBW8M4yHQFw33KLse6lQCXxe5SqC01WMjbNmzI6pH5xKXwsfPY02a1AdfGafTu4MNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:51:26 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 21:51:26 +0000
Message-ID: <9e6cf709-c59f-47ca-96ff-cfe3ea1a2e94@intel.com>
Date: Tue, 26 May 2026 14:51:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 13/24] ice/ptp: Use provided clock ID for history snapshot
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar
	<mlichvar@redhat.com>, John Stultz <jstultz@google.com>, Stephen Boyd
	<sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, <thomas.weissschuh@linutronix.de>, "Arthur
 Kiyanovski" <akiyano@amazon.com>, Rodolfo Giometti <giometti@enneenne.com>,
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, <kvmarm@lists.linux.dev>, Oliver Upton
	<oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-wireless@vger.kernel.org>, <linux-sound@vger.kernel.org>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.670955218@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260526171223.670955218@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: f2607674-d946-4282-9a8e-08debb70efa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: /JC1Q/T2zlHTUaJe2pQS3Tt96l7dfmNK8Ftz/+rYJETuKdPMLfRNndSXHFPx2B2bBztbWfEkrIeFhGxQEFXIfU9CJdWnGi1i8O3CLTqKWCFUcpttYw/howIxI8MHLIUgkBC5lF4H56qtrjt031nshyLtO1cq/0DuIP6wcq/StHSxjME6j3GX1XF0zEO9dHuqBhMifVzKNs9Q7OeNYXp/bYa5UQ8dZvvZyVQ8KbA9cGnuRdbgfX9wvZtBl48K2uD033NnnkuhB434UMCspoE47Tsti8wddn83e6IQ9ECMZmF3UuJC8ddYFoykHksK8xql/gS/3qPimKcVUZOuK2q5uUIWgA8Dw2XXkACgr6kv56exfJ1Qjtc68oprUT6+v4BJ/90HVNRW9f4l2Hda1JHqKNwXviNW3JDeWRRQGRPjLA5y9DCHJWH3gnkoeDf0WKMRVgn05KnrjrO3C1sH5a8Shn9nWM4o9Vp7BvN3SkPOE0EewpruZmopgABDVyjhSbKcs0h/clQPAw63982bco1ywdupoidFeXkqg2Up4dSGWB85auu3y8CZIDUdyFx6Tdm/XWVYJYtspOkupj8r5JNv0xLQ4qYWnaS0W53BEJSMCS6AciO7nfeMgCY3rLbW+lEp9koymeejFr3r9HNYAfGh5/6vRCLdfrpGlLqRTWP0QaD+BOmGh5MfBgyCFnPJn9Ci
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlN6YmNGUnN0cjRKVjZucS9VUHFjbGdpZE1Hc1VuN2dIWXhGUmJuTThaUDdr?=
 =?utf-8?B?M1dpRnZPUWI0Zm9ROUY2Yk9aMEd1OFJzemQyM0FKQ0xEWUJua2taMTZjQVBC?=
 =?utf-8?B?NTRwb3JubUVGRjdVWTFrZlMzZmxWeW1SeWt3V3FRQ2xFNWQwRFBaR3Z3YllF?=
 =?utf-8?B?Tk5kbFJYRjZKWENNV05ycjlDT1ZQTmphSWs5RDAvN2d0K1Jpc2dRVGpXSmNl?=
 =?utf-8?B?bDRzMlRwTjNQMW96ZWNacEIrc3A0S2UwditUNDk3WGZMWlV0NGVWL3ZQdkhr?=
 =?utf-8?B?WW5EcGJOY2xJejdYMVNvYjBtSHdEYWZXUVVUMU5PMGgwaGhyQWpLaWNtc1Nn?=
 =?utf-8?B?emU3bjBOa1RveWVIVCswK0daY2phKzRYVlcvSTBFeGlTUEY2eFE4MVY1R0xK?=
 =?utf-8?B?cjViQXV1bTdVY2pNTVpLeFlsN2kxUVZyNzFCYWJZbTFJa0VoZ0toYW5US1lN?=
 =?utf-8?B?Y08rdGo2QmVBTlVLNWh2NDhkWmd0RXJ3YXJOczQ4cVBCd3JraG1DY1NSSHZi?=
 =?utf-8?B?ZUNURHBKV0RMWGJMWDBpT2UvQ3kxeTlHVlcrTXU1b1pkdFlTb3lZcjJ1Q1Y1?=
 =?utf-8?B?T2pZNi9wVHBaNzYxcHVzQW5lMXlNeWxGV0pleXFRUHMvT09SYXJkTkM4bWFQ?=
 =?utf-8?B?L24rM2J0TFJKOXVYeXNueEl6YjNDdFVRTERWd29jOG4vOTNLNEcvZmJnODJL?=
 =?utf-8?B?MC9zK0k4OERRYXBZbXhOc0VGQlIveCthdzJtZ0xSazh4YUp4RXcrT2UrOEtL?=
 =?utf-8?B?b2FwMDJOVE5SeUpxUmtUbGhKZkhHYW1qNE5oTVFvMFVvQmtsN2lRMWc2QnFD?=
 =?utf-8?B?UFNxeXFQRVZaRzZPb1hLK01LNGM3Um5TS0I2QlYxNEprK1NOQnZVak9DTFow?=
 =?utf-8?B?NnBMT011RlJDRThvU3FITnpLY21Pb1E3ZlU1UU0xMk5ubDZGL1pPL0pRSFY0?=
 =?utf-8?B?aUJ6YlJTK1B3QzhoUk1aeC9MWnZkUkRFWGZQZ3pPSDdJdE15cjY3ZDBScmtO?=
 =?utf-8?B?dVc1dlBSWTlnZEt2U3IzWisrci9kNXVEMEZpYWFFc1ZYdUtiem5CaXQxQ1F0?=
 =?utf-8?B?NVU5WDB1a015UFE4N1BJTWhYTU1US0JaLzR6TWVBMGo3am91bzhSL0JYYVdP?=
 =?utf-8?B?aWpWMjZEMjRtRmVjZjhmaXVEOG9kQ1dxMVFPNnJ4L0VhNUVDenM5YkY0QmRE?=
 =?utf-8?B?MWU1aXBRN25xNGowNmRPRjJXN1I1VGR6MjNoVmMrVHJWMGJ3TnJKMXR0c25V?=
 =?utf-8?B?QzdISFJiRVFldWw1Q0g2LzJybGVDb2tkWHpSTDZSUDlkV1pzVzU2Q241d0pI?=
 =?utf-8?B?bGxacHBnRm1hSjNIQVE5dXBGRXdCa3E0TzMwODltbDA4TVZKWE41UG9MNFlr?=
 =?utf-8?B?YjM2RHZGNkIzSGRGYzI2ZGY3QUdIdTM5VmhhczhzdmZUUHljRlcycVpvVGdW?=
 =?utf-8?B?b1FzZmF2aU9CWkdIVnU1K2t6YUJZa0d1ek9XMHdEL2lFa2t4SHhzNTJySFlj?=
 =?utf-8?B?UjJOMzJNdXdHa3FuWWUxZTNSTm1neCtDT0VmV0QrZ3lrS3ZKN0l6eUttcDMz?=
 =?utf-8?B?aW5CWUlURGo1MGNLWUZ2VmpneDduelBsSW5XTElqUUZ4T1NHbGloQ0Y0VThs?=
 =?utf-8?B?ckwrZzJWak1iQXZLRWhETzI0dmg3dEp4WnhoOEtCNG9iN0E1azNxS0R5WnZ3?=
 =?utf-8?B?MGdCL2dlbFdMN1U2cTZjYWZZNG92MVR3U1psdzdhZExSR3diTEdZSnUyRVFK?=
 =?utf-8?B?RXlVeVRlK3diRkFuY1R2dGZMdkJZS3h0bnh5Wndkamw3a2hOSi9qdEN5ME9k?=
 =?utf-8?B?cUQ2T1I1ZjdOQmhYcHVHQUtleDhJL2RFcVY3ZzBkU0xaUFRiSitOdGFRSG9Y?=
 =?utf-8?B?dUZWL05rV2hhd3dtc3FKVGQySENmQkRwSFZIcmN4ZXFWOVZGRURMb3JSUmEv?=
 =?utf-8?B?a0lJK2pZVDFpWC9ZQmtsVHc1ZFlHdWVqSGo1aU9pNjMzZ01wcWxwM1FNL3B2?=
 =?utf-8?B?VWlZa3h2dk02WjUwUzJlb0ZXRHpkTmNyd1NuNzBXYUZGSW9tMld1NG1oT2Vu?=
 =?utf-8?B?dDRYNUhiN04xMXpmbEFYZnlrdUxpNjVhRlhOUXhmdVI2K3MzN2dKMVRoTFNo?=
 =?utf-8?B?QWhtMDlFaCs3U3ZaUEdockh1eXIvOXU2cnFrbzh0ZmhHZUFtZCtQNTQ0NEor?=
 =?utf-8?B?dm9FYllQdUFpMmFnMjkzaVlDbmtOcDA4N1ZzdGFHU0U1cFJvWWtXaU05a3dM?=
 =?utf-8?B?UWRnM3dWOFdjQkdKblRyVCtZTkFGeXZGVTZsNGZGQXdHUFRRZzFxcm5teVps?=
 =?utf-8?B?VWVrMkNOWEV0Vk5zVHVnajdkcGx1amtLby9zSGxUZWpRdHduZnUzUT09?=
X-Exchange-RoutingPolicyChecked: i2Ytn8yFA3C6BrHpmIqmQuNR+GKhDLfQ/7dyse7kkAQ3S0evPPe3sTJ5YQsRrfeDqqplUw2+PONAY8WnTdvndNaK4O7E6mIJAJ1VGXRT46/CwQHoG241Y+Gww7ZzNz54OCH981Kr4rcDvuEMbUe/zZxzYI/BwY6QU+PHEasea6kbvPSTgE0Yhq6rIjc9yMSyYkcXBkdmNs9xU6ZhYUqtR5r7zOLR3Er7YpXmRJ8IOlMwoblMZEu1TnoF/bpllmlR/RK6uEC1Ah2igEGkLqSSch3OrwntwBwb+FtxLU/bwU5EzHJp/EgG8EA+5gLKDNYTM8iQEMbZjI6uB/X1zMZDJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2607674-d946-4282-9a8e-08debb70efa3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:51:26.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/vwxSWCTjWnchT3TppAZg6lMeiQOHDIdYtJDo1B9FEagYh8yx1I9i+80ZqJi39tAYYDsZIV3j1W2kKw595CmVX6dNSYloHEAKu4spwdbs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-36934-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7740F5DD009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 10:14 AM, Thomas Gleixner wrote:
> The PTP core indicates in system_device_crosststamp::clock_id the clock ID
> for which then system time stamp should be taken. That allows to utilize
> hardware timestamps with e.g. AUX clocks.
> 
> Save the provided clock ID and use it in ice_capture_crosststamp() for
> taking the history snapshot.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Jacob Keller <jacob.e.keller@intel.com>

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

