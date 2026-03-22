Return-Path: <linux-wireless+bounces-33663-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OxcDg3iv2ml9wMAu9opvQ
	(envelope-from <linux-wireless+bounces-33663-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 13:35:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CED2E93AB
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 13:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4703008D32
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916B2F546D;
	Sun, 22 Mar 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXdB5kaW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638F2AE68
	for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774182547; cv=fail; b=Mt5pR5gvDJcJSRuiDvjVz0cak/99ZURvuSxGLrvel7c9pKNqbIToxBc1G6Wi7QHOuDPBEx90nU3MA0iwON7Jn9IKZ0MMVkEIjmhbQwXPsIZsSfa4NL6gvce97sNE+ARCbep5R8JptZ6WijbCfpLpXcERiXZYB5kNX4ey9bw8i4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774182547; c=relaxed/simple;
	bh=BshxO1wbW60XbLY6Hs1744SBEVol5Zb7UvH2MGdBigs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYtzQL055KU1gMI5WNoQ5EgOan8bOMp/b6x9epd/0AsuEuvNNWca0rqZY1pgcOdNB4iPo5mSe1y6wivq1GdESBPCm/7Nr8vd15sABqs5gqFTFGSyNfMkf8Y/bi+JvDGJ8bRAI8jytOK6/zZHUnHefkCaoQT/l8j6Llaj7/q8jIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXdB5kaW; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774182544; x=1805718544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BshxO1wbW60XbLY6Hs1744SBEVol5Zb7UvH2MGdBigs=;
  b=JXdB5kaWRPoV5TF2km6Hxq3MvchfZuJKoN/+JOuW7L/IR53hWxk7+gyk
   L/ptu3yukuJnhA08R9DoJiMKeGtNZycTQUFKvRvJVW9k7K7ROv6LW1riU
   FQ86qJz3gYdbPQe2F5AhvPA+r6T6hG+ZInKlYvA8STAktxmP61YzmLh0T
   ZxY3thDYiMJJOCk8vePSPd9reULARVtQaMUfVWk5PLgKO3VREVyWuLzVB
   0HGP4HS9GPZoB5XkssZMFl0jXAzVEIGYoDFkrbf4HJUdp+CekoV/X/Lza
   5FZjrojDSO7TfzaSdXp4DfKKGUSxMqa8YMfPYZ7ZJXXtanpRKIkLMquIv
   g==;
X-CSE-ConnectionGUID: 7IUydPvuQaaJjUGAP0dXTQ==
X-CSE-MsgGUID: vl/HAHNFSSyPhVDzCu83Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75230722"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="75230722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 05:29:03 -0700
X-CSE-ConnectionGUID: MQq9PTHER3i0ojyyTcp+2Q==
X-CSE-MsgGUID: y0Rt9NRaQYadCGkdtwOyIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="254235614"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 05:29:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 05:29:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 05:29:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 05:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ+fEaoycIGKU9X1COjo99uUXVq3N3dvqrAD6yemKNsjvu9fZ0xgK10bnCGiCMzr5HNapyrJZy0x0HtHmWZ2Vd/2IWPUWQs2HLR8kqQjSAsHtxlBKP0QR7emWwcazao8CRt7UZDdUyOnupnO1DYoRzboB/pmUXunyKK59HyNuBh2qol200aK3ZzLhwumPHRyOegoTystKRhJWGnN9GpFR3uCtDIoe2b40W8W8/4Ko9uxKVPgKcsqca1IBqYhMdDmWyJB/6diTslzZN3XgmhZTK3kw7i7mhg6cOW4vzZhbA9FdLCWlxsvKQKDd5OJyxab5A7jbpaiY+ORXyZS+GkSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BshxO1wbW60XbLY6Hs1744SBEVol5Zb7UvH2MGdBigs=;
 b=bHx4FIu1VsIHZPI+Z47zV5SDiG3oAtG3fb6cWJ4VEUKSc0m2/bc1wj8k/IqtAc1CHKboHKr+GEs5/9BfcB24Gv9doiIhqxd5dgcwaF+os3/8JvTncunPjpvwGDDu7Jq1wg98fQWxcuceVn3rKifW259wGm/DO8jNO1EeFFR5t8rQdX9gDlOh3CfpsDrnENDaGxFJC6qKGPaRQQSVNBhZMSunqxyhkl79sYRaFUdIDPtlYdZhOuM9BjsvsIyAYkFGlZLCX/VOyTMSDhPAQlyY/LIL44clG1WVUi3IeNSI8tiqb0ZJjdiBGWJsgrKt2LxHfp2prbvVsHoKOi4XvUfivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SJ2PR11MB7427.namprd11.prod.outlook.com
 (2603:10b6:a03:4c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 12:29:00 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Sun, 22 Mar 2026
 12:28:59 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Cole Leavitt <cole@unwrap.rs>, "greearb@candelatech.com"
	<greearb@candelatech.com>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/1] wifi: iwlwifi: mld: fix TSO segmentation explosion
 when AMSDU is disabled
Thread-Topic: [PATCH 1/1] wifi: iwlwifi: mld: fix TSO segmentation explosion
 when AMSDU is disabled
Thread-Index: AQHcoOWJR8NjAW3o5EeI230PhPrkSLW6q4Aw
Date: Sun, 22 Mar 2026 12:28:59 +0000
Message-ID: <DM3PPF63A6024A9BA611072406902332461A34AA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <9edde56d-bfdc-40f6-862c-b69950cc2f25@candelatech.com>
 <20260218144723.31699-1-cole@unwrap.rs>
 <20260218144723.31699-2-cole@unwrap.rs>
In-Reply-To: <20260218144723.31699-2-cole@unwrap.rs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SJ2PR11MB7427:EE_
x-ms-office365-filtering-correlation-id: c43b329a-5672-495a-1838-08de880e984a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: OPXB3rJTD6xT9tTBuMN+sFixCXAqrOERVk8fmfMH/BDQK69hMQnE9DT3B4tSmuFvD0qPnpn6wKCehWvPl8rezwS4WKiGPiXyYZYFikRy9n3XllgBLg0sNzcb21c6faMvTE0s4SLYrHLRaeyl2uZ5mZ1vPQVftaFZTtal4zTvsNs30I0CsPflH7uWK/uguCF4sM4TAutvnxmHMyKAeEjf/ww1arHs3JMD4+xtKNyA2MYkGSgkSp6jeGy2lCEtWdTP26T+3kup3vsdGa+P6aUzZzJHg0FStcD/zabpxAbJm1mQRfXhYufF7X1ejmDQTe52znXj4f9xtMTUCD52rdX8rKfFkM7zmauKJIPXgHnNmpmDkUmB6KZmcbQ4R8qX8bG2/jR+wllpz0gtSBkQlo0ZjwEnnMq0RQ6DU8z7XKWBI5QTvwrKYUUn716z6m74/cJL3pe8V4ouysJBA3v5HjByku5P7jnRTXuAY6yj9A08T21lTSkG+DB5Iffnq/zgLwgwmstasANgaTSQrXF8buB+Sk9bgs8nZBEE2AmvbIKgqpiyWcun9wyF0fbJY6PaP1HwPoEv0c5vIKcY4Xg2iILr9fPRlRBVLyyKJ1SOvvaZIQNceNIQd/0uZvUg2K+CEZGcyIdeqRbhbrgccG9X/bNW3T2ud9zw5D016BpQXIZY6ZcE70EtnWl0wnNgxUzz5MgLexXNCjbJDpjy89OiZcSvsq+QguceIgHAHrGHHCLhx4qcy9rL34CX9E3HQeuIwtd6olKVbfiCTEv2c6BUasy7L+DdMpYdTHkt+ioUCh4cdus=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzVDL3VMSlNFQUhPSm5rUlFoOXdpaG5CRFJ4dUNYaEdVdmtmZmJsZFRUZFdu?=
 =?utf-8?B?Z2dCd2Y2TjdURXBtNzREbk80UmxoRExKaEVtM0JHNnkzTU9LODMvbGFvYkdL?=
 =?utf-8?B?TEhaQktFK2VKM2NBbitlVVlmRWxUc0tVM3ZqMlh2NWJzTlRCSFZBMzBJWVZn?=
 =?utf-8?B?eXRaQTgrNFc5Q3RMUTZpTFFUUWdubkwvZDBLRS9VcDBzN2dOWUc4MHlIQWdZ?=
 =?utf-8?B?SmhKNStqZWo4Z3g4cGdLdkh1Vkw0SXlndElhRUN4V0o3aWRQZmNHU1NseFg1?=
 =?utf-8?B?VGNQYzFQQ2I5WWs4MlBOSTIrUy9uYkEzZEppaDhCVWJ5dkZLQy9PMlgrREFi?=
 =?utf-8?B?WTdsZ0hXVS9BdzA3T2NtbmZUT3NPWlhlZVA3djJNbFN3RktxNzBGQU94cXFm?=
 =?utf-8?B?ZjN6RnltR3lNWEJRUHlsMXFTOWRZZ0wrei90TXZKNGs1TnVneHhlV1JiVEt5?=
 =?utf-8?B?djhPVW5OMytVRXEvRC9aYjkvMzlHRTRYRXhLd3JCRC96RE91TDVpOU11ai9a?=
 =?utf-8?B?VjZIQXhPY1ArVThBMkt1TVI5aDdzSGZhM1lpVDNlQUZ1a3RnTDdLUU5QaVJT?=
 =?utf-8?B?M1hKbFBqZWYwRUlSYmJuQVBaWWZGRnllMU40QTB1Y1FZNXhaNkNDY2psWGxU?=
 =?utf-8?B?bUROY2xhcng5RXBheXEzVXRkWk84QVRobEJlVUdmVFBpeWJzOUQ4ZjZudmZB?=
 =?utf-8?B?RWQwQnFwekVEUHpZYjhIbUZ0TTFPOGlOdGxScnVCamthTGo3SHNZVHk1ZXEr?=
 =?utf-8?B?SG1ydDJjSUF6YlNVVFhsb0NzUzFXa3Q1TVVDVlZDTFNiOGFpbFZTS3U0ZHRa?=
 =?utf-8?B?Wm9NR1RKeFJLZEtXc0FzZlpFZkVMaS81U2xVYnk1R01xSWVid1F3QmlXdVZ5?=
 =?utf-8?B?SGFhc3E5cDZpUk9MajhwVnhrMUdMOE5yS0dDekxJdFpDVHJIaW5wcUZRcVJP?=
 =?utf-8?B?SU5KbVU5Z3NHck15M1pTRkZaQlQ3TGIwWXVTMURRL0c3TCszTUdQaVl4ZnJ6?=
 =?utf-8?B?TklvSDErU1ZwMHN3QVg4Z2tra21RTndROHRrZjV0U0JYbndVS0YzT0wzNURw?=
 =?utf-8?B?KzRiVmp4VXpLNmJaWkpkeG5uZmpoMUk4dmNkZ3hKK0lJdFZvOTNnQ1BTS2w5?=
 =?utf-8?B?MTRlMHFUcEhBUm9ORkI4VXl5UWZqUkJYYlduQWhZbi91WTNnK3Irb25IREFQ?=
 =?utf-8?B?T1RKT09KYUM0Ri9ybXBwa1hlWkt4dkFKTVl1M1BtK2p3L01WVmZEQ2hwaEYr?=
 =?utf-8?B?Ui96OUovUmdta1ZYcVNHcG00V2dnbjk3ZWt2Z0tHVUh1NHNqZ0tCOGJtaXR3?=
 =?utf-8?B?a1Bmc0prdDFJbFNiMjVsVDg1NGFIZEdZNDREQ3lwd2FhOExNNyswWnI4NUQ0?=
 =?utf-8?B?aFVCdUQ1OWhwZHRidnZ6KzNzZnlGL3hTK2w0SDU1NnZhcE9tYVZramFJMEk3?=
 =?utf-8?B?a1NzOUFSeitYWGh4Tk5yb0wxdnVaTi9FQjV4ZlRjTXlPdVNmYzUvN09jTzhT?=
 =?utf-8?B?YXFGUlBvakpPMjBkL3NLQ3FGT0VndU8vcC94N1lpTU9za1h5NTg4UlA3c21O?=
 =?utf-8?B?d21lWTBhUVRNelBGSW5ORS9RaEZYcC9XbnU4SnJvRGlOaWlSQ25yWityamZF?=
 =?utf-8?B?KzZRVXBJUTZ2cmdLWmNHTFJoUTVPWDJCRHhjSUFTeUZVR1hvOG01dHRWMmdD?=
 =?utf-8?B?WVZ2dHFBdXFuYU40Z3Fsbnp5VWg5NTVmYlB1d3dGenc1MEZCQnpKZmEwVnpH?=
 =?utf-8?B?VVpDSm56bUtIdHRGVVZWWDFYNnd5TngvNHd5TWFkbzQrOEpwSnFLdWZQNDNE?=
 =?utf-8?B?Sm01ZkVwRkw2d2xYOUh6YmVqSk5zekxzS3hOaDNiaVB3Lzc3d2xxcHA3Rytl?=
 =?utf-8?B?WUNhdEIvMHowYzNiNXFtRFdwT04zK1BjQ0lYUDdMck1Ob3NwazlsZGFtdXFw?=
 =?utf-8?B?eWxxY1BJMGVQQTNEbENTN2w0TnZlcjBMV2tUcmZmNzQzNVhteXdpU0VFUk5N?=
 =?utf-8?B?R1NZb0FVbm03YjRMbGhUTUFlN1NUV1FBNXJmcHVXbHlaY0QybHNpVVFtNEVi?=
 =?utf-8?B?NSt2d3BjUGNXUWpKaDRHbUJaNCtDdVFuUk5IeWJvd1I0SXBBRllKcEFWOXpK?=
 =?utf-8?B?ZG4yTzI4OURMTUtaRFhOdEY2S0lYSWlPbU03VnRxODJxL2M3MVBSMU1KNWNk?=
 =?utf-8?B?ZDU4U2g5VGdlNUdOU3hqeDQ5WFdhUmZIbFJVODRGeVZYU3VBa0xsUjBPQU8y?=
 =?utf-8?B?eU15ZGFrWEtCL24xa1N2aExHZUVHTUFPQ1NiZHFnMjVsWXlBdHRvUHd3NXdt?=
 =?utf-8?B?alNjbC96ZHpzK01Td3lkYm1jOEkwUndubDFucldOa0d0aFNuR3ExZGVWaVAw?=
 =?utf-8?Q?rTs8gdxrRnTKoFO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iIAoFlJnkhOk/cAnj8D9o5AiPA6P7CyjBejWOsjgIdsWeJZWT7wbihd/vg66HCOzEDiS0FPt0jltFJKI603mTUK/e43xz/txHHsbBHjy8IGr5k3QKUt6Sstw58soLzwJGiqpWIFs7g5gUCfJVqrbyQByEI/6ReDuUM0BHRkJ77XAIlTt6ZxwZMvN+ZsGiotmuVpPVEWYslczqu9rB/Tg4hheFWWBLdYYwjatipk6N/NtH843rZbjbONiD3VHYa7VNdpN/dRvBo5d7Vv07Nq5qOiyydFPWTRLc4tMjDr7RFQ3sMy+urw0T6eq/ujOCEJDO6ifN2ftjfLw6pyw7XBljA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43b329a-5672-495a-1838-08de880e984a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 12:28:59.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToSmWPtVsNNLdB1zVEdiOPCbgJvLIueJcho0luA+faikxNEs5opN+AfXPCQNqNopiVkDMABu/Asc+JTNonFrzHYMs0tZT8nJmrBzZ5C3mEzmyPUbgdGyKMcVsDZnXwXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33663-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,candelatech.com:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unwrap.rs:email,intel.com:dkim,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 84CED2E93AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29sZSBMZWF2aXR0IDxj
b2xlQHVud3JhcC5ycz4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxOCwgMjAyNiA0OjQ3
IFBNDQo+IFRvOiBncmVlYXJiQGNhbmRlbGF0ZWNoLmNvbQ0KPiBDYzogam9oYW5uZXNAc2lwc29s
dXRpb25zLm5ldDsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBLb3JlbmJsaXQsIE1p
cmlhbQ0KPiBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IENvbGUg
TGVhdml0dCA8Y29sZUB1bndyYXAucnM+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzFdIHdpZmk6IGl3
bHdpZmk6IG1sZDogZml4IFRTTyBzZWdtZW50YXRpb24gZXhwbG9zaW9uIHdoZW4NCj4gQU1TRFUg
aXMgZGlzYWJsZWQNCj4gDQo+IFdoZW4gdGhlIFRMQyBub3RpZmljYXRpb24gZGlzYWJsZXMgQU1T
RFUgZm9yIGEgVElELCB0aGUgTUxEIGRyaXZlciBzZXRzDQo+IG1heF90aWRfYW1zZHVfbGVuIHRv
IHRoZSBzZW50aW5lbCB2YWx1ZSAxLiBUaGUgVFNPIHNlZ21lbnRhdGlvbiBwYXRoIGluDQo+IGl3
bF9tbGRfdHhfdHNvX3NlZ21lbnQoKSBjaGVja3MgZm9yIHplcm8gYnV0IG5vdCBmb3IgdGhpcyBz
ZW50aW5lbCwgYWxsb3dpbmcgaXQgdG8NCj4gcmVhY2ggdGhlIG51bV9zdWJmcmFtZXMgY2FsY3Vs
YXRpb246DQo+IA0KPiAgIG51bV9zdWJmcmFtZXMgPSAobWF4X3RpZF9hbXNkdV9sZW4gKyBwYWQp
IC8gKHN1YmZfbGVuICsgcGFkKQ0KPiAgICAgICAgICAgICAgICAgPSAoMSArIDIpIC8gKDE1MzQg
KyAyKSA9IDANCj4gDQo+IFRoaXMgemVybyBwcm9wYWdhdGVzIHRvIGl3bF90eF90c29fc2VnbWVu
dCgpIHdoaWNoIHNldHM6DQo+IA0KPiAgIGdzb19zaXplID0gbnVtX3N1YmZyYW1lcyAqIG1zcyA9
IDANCj4gDQo+IENhbGxpbmcgc2tiX2dzb19zZWdtZW50KCkgd2l0aCBnc29fc2l6ZT0wIGNyZWF0
ZXMgb3ZlciAzMjAwMCB0aW55IHNlZ21lbnRzDQo+IGZyb20gYSBzaW5nbGUgR1NPIHNrYi4gVGhp
cyBmbG9vZHMgdGhlIFRYIHJpbmcgd2l0aCB+MTAyNCBtaWNyby1mcmFtZXMgKHRoZSByZXN0DQo+
IGFyZSBwdXJnZWQpLCBjcmVhdGluZyBhIG1hc3NpdmUgYnVyc3Qgb2YgVFggY29tcGxldGlvbiBl
dmVudHMgdGhhdCBjYW4gbGVhZCB0bw0KPiBtZW1vcnkgY29ycnVwdGlvbiBhbmQgYSBzdWJzZXF1
ZW50IHVzZS1hZnRlci1mcmVlIGluIFRDUCdzIHJldHJhbnNtaXQgcXVldWUNCj4gKHJlZmNvdW50
IHVuZGVyZmxvdyBpbiB0Y3Bfc2hpZnRlZF9za2IsIE5VTEwgZGVyZWYgaW4gdGNwX3JhY2tfZGV0
ZWN0X2xvc3MpLg0KPiANCj4gVGhlIE1WTSBkcml2ZXIgaXMgaW1tdW5lIGJlY2F1c2UgaXQgY2hl
Y2tzIG12bXN0YS0+YW1zZHVfZW5hYmxlZCBiZWZvcmUNCj4gcmVhY2hpbmcgdGhlIG51bV9zdWJm
cmFtZXMgY2FsY3VsYXRpb24uIFRoZSBNTEQgZHJpdmVyIGhhcyBubyBlcXVpdmFsZW50DQo+IGJp
dG1hcCBjaGVjayBhbmQgcmVsaWVzIHNvbGVseSBvbiBtYXhfdGlkX2Ftc2R1X2xlbiwgd2hpY2gg
ZG9lcyBub3QgY2F0Y2ggdGhlDQo+IHNlbnRpbmVsIHZhbHVlLg0KPiANCj4gRml4IHRoaXMgYnkg
ZmFsbGluZyBiYWNrIHRvIHNpbmdsZS1zdWJmcmFtZSBUU08gKG51bV9zdWJmcmFtZXM9MSkgd2hl
biB0aGUNCj4gQU1TRFUgbGVuZ3RoIGxpbWl0IGlzIHRvbyBzbWFsbCB0byBmaXQgZXZlbiBvbmUg
c3ViZnJhbWUuDQo+IA0KPiBGaXhlczogZDFlODc5ZWM2MDBmICgid2lmaTogaXdsd2lmaTogYWRk
IGl3bG1sZCBzdWItZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogQ29sZSBMZWF2aXR0IDxjb2xl
QHVud3JhcC5ycz4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L21sZC90eC5jIHwgMTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvdHguYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxk
L3R4LmMNCj4gaW5kZXggZmJiNjcyZjRkOGM3Li4xZDQ3MjU0YTQxNDggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3R4LmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvdHguYw0KPiBAQCAtODQ2LDYgKzg0
NiwxNyBAQCBzdGF0aWMgaW50IGl3bF9tbGRfdHhfdHNvX3NlZ21lbnQoc3RydWN0IGl3bF9tbGQg
Km1sZCwNCj4gc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gIAkgKi8NCj4gIAludW1fc3ViZnJhbWVz
ID0gKG1heF90aWRfYW1zZHVfbGVuICsgcGFkKSAvIChzdWJmX2xlbiArIHBhZCk7DQo+IA0KPiAr
CS8qIElmIHRoZSBBTVNEVSBsZW5ndGggbGltaXQgaXMgdG9vIHNtYWxsIHRvIGZpdCBldmVuIGEg
c2luZ2xlDQo+ICsJICogc3ViZnJhbWUgKGUuZy4gbWF4X3RpZF9hbXNkdV9sZW4gaXMgdGhlIHNl
bnRpbmVsIHZhbHVlIDEgc2V0IGJ5DQo+ICsJICogdGhlIFRMQyBub3RpZmljYXRpb24gd2hlbiBB
TVNEVSBpcyBkaXNhYmxlZCBmb3IgdGhpcyBUSUQpLCBmYWxsDQo+ICsJICogYmFjayB0byBub24t
QU1TRFUgVFNPIHNlZ21lbnRhdGlvbi4gV2l0aG91dCB0aGlzIGd1YXJkLA0KPiArCSAqIG51bV9z
dWJmcmFtZXM9MCBjYXVzZXMgZ3NvX3NpemU9MCBpbiBpd2xfdHhfdHNvX3NlZ21lbnQoKSwNCj4g
KwkgKiB3aGljaCBtYWtlcyBza2JfZ3NvX3NlZ21lbnQoKSBwcm9kdWNlIHRlbnMgb2YgdGhvdXNh
bmRzIG9mDQo+ICsJICogMS1ieXRlIHNlZ21lbnRzLCBvdmVybG9hZGluZyB0aGUgVFggcmluZyBh
bmQgY29tcGxldGlvbiBwYXRoLg0KPiArCSAqLw0KSGF2aW5nIDAgc3ViZnJhbWVzIGRvZXNuJ3Qg
bWFrZSBzZW5zZSBhbmQgd291bGRuJ3QgaGF2ZSBoYXBwZW4gaWYgbm90IHRoZSBidWcuLi4NCg0K
SSB3b3VsZCBoYXZlIGNoZWNrIGlmIEFNU0RVIGlzIGRpc2FibGVkIGZvciB0aGUgVElEIGluIHF1
ZXN0aW9uIGJ5IGNvcnJlY3RpbmcgdGhlIGNoZWNrIHRvICIgbWF4X3RpZF9hbXNkdV9sZW4gPT0g
MSINCg0KVGhlbiwgd2UgY2FuIGV2ZW4gd2FybiBvbiBpZiAoIW51bV9zdWJmcmFtZSksIHRvIGF2
b2lkIG1vcmUgYnVncyBsaWtlIHRoaXMgaW4gdGhlIGZ1dHVyZS4uLg0KDQpBbHNvLCBJJ2QgbWFr
ZSBzdXJlIHRoYXQgbGlua19zdGEtPmFnZy5tYXhfdGlkX2Ftc2R1X2xlbiBjYW4ndCBiZSAwICh0
aGVyZSBpcyBvbmx5IHNvbWUgZXJyb3IgY2FzZSB0aGF0IG5lZWRzIHRvIGJlIGFkanVzdGVkKS4N
Cg0KPiArCWlmICghbnVtX3N1YmZyYW1lcykNCj4gKwkJcmV0dXJuIGl3bF90eF90c29fc2VnbWVu
dChza2IsIDEsIG5ldGRldl9mbGFncywgbXBkdXNfc2ticyk7DQo+ICsNCj4gIAlpZiAoc3RhLT5t
YXhfYW1zZHVfc3ViZnJhbWVzICYmDQo+ICAJICAgIG51bV9zdWJmcmFtZXMgPiBzdGEtPm1heF9h
bXNkdV9zdWJmcmFtZXMpDQo+ICAJCW51bV9zdWJmcmFtZXMgPSBzdGEtPm1heF9hbXNkdV9zdWJm
cmFtZXM7DQo+IC0tDQo+IDIuNTIuMA0KDQo=

