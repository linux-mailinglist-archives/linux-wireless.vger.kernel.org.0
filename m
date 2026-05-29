Return-Path: <linux-wireless+bounces-37154-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI5HEFf5GWqN0QgAu9opvQ
	(envelope-from <linux-wireless+bounces-37154-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:38:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9E6089DF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5424530BF329
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D6423A63;
	Fri, 29 May 2026 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJ+xOYgg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BBE3769EB;
	Fri, 29 May 2026 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086800; cv=fail; b=pVJlzyr76Fb5HkZpHG86RbVvx/1fy1avjOoIMvmmKL4dD+aylxDunZMx099EVZKdA6+EJ88I0lnKNQCrLpuKFXdp+0cvIy9gskpnjWr5k7zmUNJqLX8TZBohXmLS90g1Eq0gjFN55UY9GCuybgHzngVMmPcLo2QLlC/rEv32LAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086800; c=relaxed/simple;
	bh=Fg7Xg8ggNBgir7l78UMdeeUIIg7MpK6UiuSR8I5BJ3s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPlFIao3yG3dLfLSx7Q7qTl+rds1VxPErKZ1G0r13Xi+lLi/Mtf/muIb1huIEb0Tv548lSYScAPejINQ9g60K9bXJ3G6pWs5rLx+CVxkLw8ST5BPX/QBR+nKoZ+BUjMsM7q4pIpGGDjpuy1nXqt9Ca6NyE/zbnuTT8vsn7un7cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJ+xOYgg; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780086799; x=1811622799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fg7Xg8ggNBgir7l78UMdeeUIIg7MpK6UiuSR8I5BJ3s=;
  b=jJ+xOYggRwfWzG9v2qFr+RExt0VwyTd0dgEy4AgBBNjuerp3kqyWh0Qq
   MR0t6w2t1Yy5Yj/6nxMP6sZaNS1jRzzLRmsuIIUkezkCwP/yEZVclQGx8
   emyVI1sUZ7yc0m9TTlq0iU7Lye68bCEUyHQ/w7E2VY+cW34V+bh9hAOZs
   H8tlCDWEEIbSutGDZoIjtgxACO+cf1oDfrz8icBSQpcEvo0FrHOdnEvA/
   g3/sLrH8on2CRCX/ST2iKx7kg+ThVSpEutxfXmKVhqAuf2/mCOPIBgdrX
   ZoKJHeDyGzdmuyPDaUFTj6pPbbcdQL+OaYp2mgzVDBp1kTmyhHZiVYVD1
   g==;
X-CSE-ConnectionGUID: rYY46fTPQcSZJ+7lAnpomg==
X-CSE-MsgGUID: ANprM0xTTl24CZ8jBDD0nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80673806"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="80673806"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 13:33:18 -0700
X-CSE-ConnectionGUID: 3wSFklu+Rwab8LFXe2y75Q==
X-CSE-MsgGUID: 3M6MXzY4QGeJvvmzj12rvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="247878411"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 13:33:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 13:33:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 13:33:16 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 13:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjng4dlOEmv+eVEuxJGDpx9Pdz2PlldUkevDyzUN2w6KijO6Rfhf5CRm+h1x3j+QBLBAYVlu3/Oe4GWGF/T6zNNMEgVwx0PDxmCLPGVoSnRTbE8zMEeew1wKq7kvQ2kPFxZnExbtX1rndwwZS7uksDBA3SPwlBjqWHpvXjIrfxt88xq0DLFyutIxxC5OfUtKAuVQGioEIqIPyp1Ni5pzE7vuTaFoza2dlQQHXtze5y9C8c6/PyVe8EAGgouAEZoU3L8LPsTcDeMVnN63KSQS/BXmIYALXxTJGytGM7c052lKfAm+siVNqfB9j1IKPyp53ILjBnOVkZKhUqxR+hRBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KwNwBynGFczESokgQedkuIWHMfVSIpWr66Ig4jXaHM=;
 b=W69EZDjKbcFFlkz5xGoxE0b7b+L2/0Bulb1ZbMLOucAM8rzG2cNmpylfGLKmkHg0neNX8xSGoTs3OqGc0e40xr3h/CzUw6QU5NkWO0dZ6wzfsXl7k0y7Ze4Z1mD0ThGNIUSD+m9oHd62ZuawwcllstrOWUXgdRNHQsnR+3bsvfroI89RGIOhXyOOYZ93dgCWtayrwwpZyc8e3T4UXDNXsSitdhCu+pM2AMrgNNijg7FumW45ty1ORUaqmrFAdx/4oV0D5Z12fPXbryfdwxDPfGVIjvHy6gsqcrDCbgKOvdItOKFFfmw3IxrwfeH5OHUB1xn0AUrfNWV/JmH7isz4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 20:33:11 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 20:33:11 +0000
Message-ID: <994a314b-65a9-41f1-9ca7-04b00a11b6f4@intel.com>
Date: Fri, 29 May 2026 13:33:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 00/25] timekeeping/ptp: Expand snapshot functionality
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
	<linux-wireless@vger.kernel.org>, <linux-sound@vger.kernel.org>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20260529193435.921555544@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260529193435.921555544@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA0PR11MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: d19e8869-838b-42d4-5a95-08debdc18013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iUE9fxwok2LR1+4K0jvxA7XJgpFbQE3BzNjp+gE4CtK1wXEY8S0ikzEtrG8mIERMvYhEcm+/u9BvUOFyUg/PbRdey5fSqinga1VYRCSti0HB26KJRsz0f4JpnZqzjHLF25ZJR3DnvCZtTF/8A0/pW/Uy4VbkdOakzOgqXhuCqWyZ2k3kCrAYu0WDb/uXOiVx82bsAFX5KcFiOOaNGO4lPZd3PpGNhowiemtFO73FpO+crn7uy0a36IN5+AknpwiW/Ab06+iV5wHnyrLqElhUZ50hEB5nXTNEXm8BL1A4oFHiPhMANjk0A7UF7Eyn49vughxod1gVXRmoc8PATFCyX6VMHdpLYea/UchjnmO3XWCH3IjypsC14ERQVRLpJMyfAE/sOdAFCPSKe0NYdKZggL2uMADU/VC8EDk3vn5BD1XFGi/3asuRVJhS8XYCxTjNIFp/kZsuqdPaEYWLDodO3mAKtb1z/mAIBdTezWQJNISt0XB5EFl9ClZHTcxQukfr4dM3B6VOsKXpqNjNeG34Wd8rzHxZbG8gON566bhikUQEsyZG26+GlbNNaFNfBRjpCiHLjM/wJh0Mz4ZI1Sj2zEQOOSsbXKhy/K589GkOEGPyetpP7w7f5erKWm9oVR8mAX8QxO2fQv/OKq0E/lPXOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFQL1Nrb05qbUFyUThWUXEyMWFSMWZoVXpOTms4cnZvTE02V0diYnVVWDgr?=
 =?utf-8?B?KzRNZXY4Z00rWWhkV21SeTR3dDdMRFlaMEtXYnVkQ1dWYmM5RHdxcWhQNW1T?=
 =?utf-8?B?VnJkdCtKT28zblZqUFh6b1I3WkZFV3FmaThHcW50YUt4dHJ0aGx1cUg4QjN3?=
 =?utf-8?B?T2RMTEN5SWJnOEVVZ0FTaEZBak5qSVBtbElScTZyWWNFQlJiUjhCQ0plOGZx?=
 =?utf-8?B?TnBaYUpxRUFxcitpNHBpZ2ZDQStsVEhqcmpIclFuRzdZNnlIWU1JSE5vR2s2?=
 =?utf-8?B?UTNvakJjSnJkdmtxZDZMdmlUUDI1MERuVzViZS9xanBhVENlOFdCVUIrK3FE?=
 =?utf-8?B?QjlTQ1AvbUl0bm4vZ3R3NDE2TlFFUER0a1ZidFVYS1EvRitGN1ByamtiOEl2?=
 =?utf-8?B?S0EzNmxMTFRHZXRaTEd1cmZVT3hNMkhPamp5cHdiQzVVV1JDbTFuYUkvYjk4?=
 =?utf-8?B?L21EbzdFZXd4cmdHeVhWanVUT1EvRlIzVk5JdDAzRjd3VXdOTW5QcWwzcHM5?=
 =?utf-8?B?ZEtSWHY4dGVtRmgwdTBFRUxSQWpkZXUyc2EzbHRrcHl6ZFRjRGtmaVBZN050?=
 =?utf-8?B?S3ZGRENnSmdTeHhRa1RTVDMxdjVnVmpuSGliLzhZWmI1dW1GZ2xBRWk4SFNa?=
 =?utf-8?B?c256OXhNZHQ0NVZUdk5scExPZUs5ZE1nSGRkeE5vRnhoUGsvQUhtQlBJTXp4?=
 =?utf-8?B?ZFBEQkgycDBwM1RCd2JodzRKcXljK0JuWHlqZGpSbUsvTzNsbnJSQitNMnMr?=
 =?utf-8?B?dGxkYUQ5Q1YrRkVkK09FSXF4SzBBYlp2eFBGN2JRbWxycWZSMHVrN2dITWtR?=
 =?utf-8?B?bi9ad1MxL0hOblhLSm4wc1dvSi8wbmZHY2F0NjFJc3N1dzZXZHJWTU85eXIw?=
 =?utf-8?B?bnlVWGJWa3BlbFNQdVRVeDEzUmF0b1hSZnQ1OTcrdk1PdWlhRmJWMVQ4NW1E?=
 =?utf-8?B?R3h5VXBsZjJwYmtHMDJrQ1ZDTi8yWHpxaERmbllIb21iSE1sTjg2cWV3blpZ?=
 =?utf-8?B?RWVKc0p4a3VGemE5L3JLanA1YzVsbjNkd3VyVTJHeFRTeUxkUUhoUlVVeFN6?=
 =?utf-8?B?WVVtKzhrdjRuVG9taDZwd1RIdnhpVnZtUkp4MWNRdDFFSkE4TU9JME9HQ3Vr?=
 =?utf-8?B?QnJJNHNoUk4xQnlpeUdUZHU1NjREN1BkRXJQZGNqeHZHd3UwOGs2ZGdPV3pm?=
 =?utf-8?B?cTlHMTY5R1JINFNiRjduTERmSzdDZjBQWG1oc05CRXFWTE9rbTYzdUJGTUg5?=
 =?utf-8?B?aEVWb3FnQ2EwVW5mdkdmb0RYaStSNjU1eGZZTVE2VVlGOXptNmMxUW5SdVVs?=
 =?utf-8?B?QnIwL2VWaVN0c2hBeHlLS3kwWEpIQzdOUFU3QWdqT0c2TXFYK3JxTWZmT3R1?=
 =?utf-8?B?WXpkbkdSTzZCYTZUYTgzSHFWQUgyNmpDMXlDQWIrYytiRS9hN29VR2lQdUQ3?=
 =?utf-8?B?S0ZaQTJyYVBURmo2N1UzNVpKUjhTNVE4WjNZUE5mVm1LRmRNWHE4OGdqT2dN?=
 =?utf-8?B?YUlaazFBNkkwYVRsVWlDSk5OcnJHZ09UMEFISFliWE9vL1ZDOStFUUx6MWps?=
 =?utf-8?B?SFFzWVpxTW1WV3RtRzhBUXVkQmlWSEF1cWZnWXE3L2MrZnN3UHkzUTg1OVZp?=
 =?utf-8?B?RjhUR2M4U2MyQmdyRDhGN1J5Z2ppcGFocjAwQndNNENkUlVuTzhCMkQvYU4x?=
 =?utf-8?B?d2ExbzhyUmthRmZ5bEZSNXk2VDlDRlQxbkQ4TVlobzMzam1aWDRXM3NmUnAy?=
 =?utf-8?B?TnVmbFoxTTNMM09zZXg2c0lIQzdkbU5JdlFwdmJxRWtFaUpUemt3K3BEZTFt?=
 =?utf-8?B?SFR6dWpFaWkxYm5kS1o3WEFlWDhQb2ltaDM5ZmRTUWFYMFZ4STRvRWtlYUsv?=
 =?utf-8?B?dnB6MWZxaUVabUd1RGZraDdZTGVTQW5VTktIbFgwLzdPdVpxNUQ4aG52YTdQ?=
 =?utf-8?B?KzRjQTJXRmFHamIvdkpQTkhWSWNadFlaaWU5WElDMEQxRnRUNGNQcjUrTHBt?=
 =?utf-8?B?TDFiMUdpaytkRjM4Vjhackp1b3JBWStiMFZkUFhKZGdxZjNnWUdlVmFDM29Q?=
 =?utf-8?B?Q3hhQVhRWjdEUVdyV0t2Q2dBWmdIcVlOWHl6WjYrdTUyNElrazdjUWE1NU9m?=
 =?utf-8?B?TVF4a1dDRUo4dit4d29wMXlGa3EyRzdPYk9pajZ4d1RacHpEM1U0cWhCV3Vs?=
 =?utf-8?B?VU9MM0FvTS8zNmVXeG0vL2hLdEwxWWVQMTZndTE1bHdSYjNJMlF1K2d2eHZs?=
 =?utf-8?B?TEJzNmorQ09nbmRLbmFDQXN3ZTljSGllVUlSNGJvRUtIb0lTUXhtY2xFR2py?=
 =?utf-8?B?bkRwYW5BOVdyc0xNdGZFeTFxRXdLNDhSVGJlVlFjN1Rmd2ljUUkrUT09?=
X-Exchange-RoutingPolicyChecked: dyiUEXqh3fc75sjIhfwgS/xEHflWEPhhzeTdwYskcgF5QV+KFP3pRDuX6SYZ/Pp63IIjxl9AQNdo1v9Bq1/jdkDCcNP432JJEfge7lq8H+3w3F89i9FmdHRPHSRozfXj4TbCe1ujlUhh2PkaLw6heGIUjFMD1r4lLoTC45oVFM7qa+ELEW07Euhmw+sQbkdffns5IBzF1TIRg2305fEBFW2KRyaHQV0sfsmN97Qc1Z+yzIs9hwE/QIRdEPOGAgcM/zem0a7uqfmWkabfGaLSpuSa3Oq6ELwe0KpPvA1gTqIK4Mwr7r2Pn0wRROdfpcwemwenduptN2FbMrqMj2i8CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d19e8869-838b-42d4-5a95-08debdc18013
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 20:33:11.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvXJHIG+WFZeLs+sw7c7VrRWOO8czqLBJASWx2drba6wI8nVbdIe14MMtqCjuqUaBhI3rg8X2JTDQqt8p4+OF0m4uIJYc2QcmtcPOVCNDlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-37154-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 66C9E6089DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/2026 12:59 PM, Thomas Gleixner wrote:
> This is an update to V1 which can be found here:
> 
>    https://lore.kernel.org/lkml/20260526165826.392227559@kernel.org
> 
> PTP wants to grow new snapshot functionality, which provides not only the
> captured CLOCK* values, but also the underlying clocksource counter value.
> 
>    https://lore.kernel.org/20260515164033.6403-1-akiyano@amazon.com
> 
> There was quite some discussion in seemingly related threads how to capture
> these values and how to provide core infrastructure so that driver writers
> have something to work with
> 
>    https://lore.kernel.org/20260514225842.110706-1-hramamurthy@google.com
>    https://lore.kernel.org/20260520135207.37826-1-dwmw2@infradead.org
> 
> This series implements the timekeeping related mechanisms to:
> 
>      1) Capture CLOCK values along with the clocksource counter value for
>      	non-hardware based sampling
> 
>      2) Expanding the hardware cross time stamp mechanism to hand back the
>      	clocksource counter value, which was captured by the device, along
>      	with the related CLOCK values
> 
>      3) Adding AUX clock support to the hardware cross timestamping core
> 
>      4) Add support for derived clocksources to the snapshot mechanism (New
>      	in V2)
> 
> Changes vs. V1:
> 
>   - Fixed the ptp_ocp typo - 0-day, Jakub
> 
>   - Renamed the system_time_snapshot members sys and raw so systime and
>     monoraw to make them less ambigous.
> 
>   - Fixed the error case return values of get_device_system_crosststamp()
> 
>   - Made ktime_snapshot_id() void as there is no point for the return
>     value, which is nowhere checked and cannot be propagated.
>     system_time_snapshot::valid has to be evaluated at the call sites
>     anyway. - Jacob
> 
>   - Picked up the first patch from Davids follow up series, which extends
>     the snapshot mechanism so that derived clocksources (like kvmclock and
>     Hyper-V scaled TSC) can return the actual underlying hardware counter
>     value (TSC for the two examples).
> 
>   - Collected Reviewed/Acked/Tested-by tags
> 
> Delta patch against v1 below.
> 
> The series is based on v7.1-rc2 and also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timekeeping-ptp-extend-v2
> 
> Thanks,

The changes in v2 are great! Appreciate it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

