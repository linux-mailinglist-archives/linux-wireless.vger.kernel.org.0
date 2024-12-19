Return-Path: <linux-wireless+bounces-16620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C419F7DE1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 16:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB2165FB4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353F22540A;
	Thu, 19 Dec 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLcR1VoQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A2221440;
	Thu, 19 Dec 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621838; cv=fail; b=CmZDWj5dLvsehgL5fj/tP7VdKEi3qrIa2kCaJzD8sNd7kjKhYukge5Ej+qE70FkutN4ggGE/gMFh5ARjg18uChOjbtjrJRk67eR41TYrKjlTNB2p2+H0aG2S6q1q6w/Id3dj2AWWhBwrumyccQJ91CBcmZsbIuWgleAssincReQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621838; c=relaxed/simple;
	bh=3FHErkw/Q0gZRMQJzSHs7Rs6ScB5TqAo/w5AxXPOqgk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JBoX3D4MFRljskI6D4lCR9kFhtMPWxYw7kVeV8bcrRdXVP0miAOQw8pDnncEyLy+Q5VBW32EN7i78DZGztM0PP48FFMPwe7JNA/JojfoZPhiaYa0kI+qvsIngvpijX9m7KdNHHk89AtRxLI5Q++cWPcd5bIADBOZYaqPFq+496E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLcR1VoQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734621837; x=1766157837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3FHErkw/Q0gZRMQJzSHs7Rs6ScB5TqAo/w5AxXPOqgk=;
  b=GLcR1VoQ8mRr77aDqzv/H9kve6RXBbSTsN/PG9+uI6TkFpsrPW2yC3zK
   MsZnP/Os7zDaq1NOK1Qw9vh092pnBpNrMNw6NAHbIifKsqMG4iqKS/e5+
   Eg4kCAPyLSAccN2EirHdMmenMtqSnRxkRbqQ8iDnnEmSpU2ReYxgD5sAg
   R3EaoW/g+bd7fxgg+//iDIoGTEScoNZse5ss95kY0DcYvpvtUYtkEFw3g
   M+GKrO7SBX4vfplqUrPGldhb4uiTNBJJT+rDKLr4Ly9lA88Hlo8BCBm/j
   RtKiN8BX9c5Mn/dbtQTFiTnIGg7FXmcJzoHaPNyJARDBY28EIzjIskewz
   g==;
X-CSE-ConnectionGUID: vycFhWNqSUGeE2X+MOeNHA==
X-CSE-MsgGUID: 7Si442XKTJKdjGSdVcpD5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46144766"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="46144766"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 07:23:55 -0800
X-CSE-ConnectionGUID: 35JBrvV5S/+x7hN2j/yQLQ==
X-CSE-MsgGUID: rTqE5nJ6QrOb7A/Fg3FMYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98700545"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 07:23:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 07:23:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 07:23:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 07:23:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZhOvdtcoePNs23PuBvQlv1pjtu7yjA1nyelRMKpwFg2uvcHdzROYSrWHvbN0qxY64vYHTgJKyCWI2DOdaoVW40aChvalbQauHdL1gohmRO0cgILz8Y6OsHEpMkyqzVLbwfa86k9lco8+/zRxQv0C3LhEN55BxX0MI7Zjiz/oX2cLQZ3IA7h8NCxMhnDw8k9xKyfCOHr0CXVjK9RCIuBRRdHONot8fYCcEI1BQ/IM9E2SlyhpeYrEq4VGgSfzF09pA60BfCZBccA+M85T3wtASiXJVfvyJYTcrpfIA5CPpSQzduWV6r7/vygiQeils10Z9V4ZJeOobf5uaBFdHOiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7sy1etfkqnd8OWz2m/To9Rlt05OV2XtaeEKZsWh+Ak=;
 b=VR7rcLtMUPZNn1ujNS2aI/b33LX91OrccKnSQK4yFDeVCYRYBV0B8ALAOacUVWJDpU++vaYeT163bMeeFC2rTsIRlog7aJlEQ9sE9m92k5avsSMI9cHRtbN5fZsb+HwMHZ0r1q8m1oA9bGVtp1+f8X0GipuaoOoHhJxIHYAxI0/U51KSfpsYeBUHU9wKnEJqRN1tiRgJtfVSdfRSXcJN1lRrc2CFyVPmcGj/IJnezmwHtsMA09jV49KjXWENQkV0HCLBFm1uEZZ+bPsXMPijooSIPijyVh7STVc0jSTlqZaGgpoYxEV5Cb5oQgUmJfhYkZqGE+P5kgrfvoHO+wMsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 15:23:50 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:23:50 +0000
Message-ID: <531681bd-30f5-4a70-a156-bf8754b8e072@intel.com>
Date: Thu, 19 Dec 2024 16:23:02 +0100
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
 <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
 <5DB5DA2260D540B9+359f8cbf-e560-495d-8afe-392573f1171b@uniontech.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <5DB5DA2260D540B9+359f8cbf-e560-495d-8afe-392573f1171b@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e658d7-500a-4083-82d7-08dd204123c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGg4cHl2VVlzZ25mZm5CdmhlS1c0TE04dlExcnpBUzdKdzBMc0JwcUwzT1Zq?=
 =?utf-8?B?R3Y5d2VCdFBWU0ZIOWxWM1F6dlhuSUtWdjdHU01kV2s3ZGwycFVKem5iTW9p?=
 =?utf-8?B?Q3Z3ZWxucTB6WkJVaU16TnhVRm80KzFZYnMzV3BSWVAwaEhsSXEyNkR5Sk1K?=
 =?utf-8?B?dnZGN3ZIbWhySFo5SDM4YlozSjNYMU4wL0Y1K3duOUFubFdNTHFQVnRDU3pR?=
 =?utf-8?B?NnlqV0plVnBJWHJuS1o2NVFJZ3ZzV2o4bVV5YW5HblYvUjhWYWRpQ0FJMm1L?=
 =?utf-8?B?ZXh6SCtEOUcrVHp5NTJhQ3pkS1ZhYVZCNXV3dENkM05VL3NEenI4ajdwb0ll?=
 =?utf-8?B?Y2ZpbDZOZmxjbEtlTmt6d2lpM3JJbDlRSmowQkxzT0sxMlhvQlpFMzcwSXZI?=
 =?utf-8?B?M2QxeFhoYWdaM0dXbUhPOVh3Lyt1L3B3dnF1OFNyTWZxSy9NLytCVVRJajgz?=
 =?utf-8?B?QzJwcDk5UnJ0dXB0d29CcGZNdWlVK2svOFV4cjNybUVjNlU5S1B3cXhhR1Yy?=
 =?utf-8?B?Ny9NTnd2cTV2dVFBY1pHNFFFY3lUUXRMc3lYcERFcjRkeDAvcXZKVDAxS0ta?=
 =?utf-8?B?b1h4YXJ1WGd0NmdBQitNcXhYVlp6T0RxK2NJOVFuL25DUVdrTzVMMm9jVUcz?=
 =?utf-8?B?NjR6cGJUQ2tTa3AreE5VMUNsMnI2UFMxN0RlOW4xT1gvcE95OHpXK2gwb04w?=
 =?utf-8?B?OFNmc0s4QTkzVGk3cDF5eGZ5K3pXMXNFRTkrbVYyampJdmVtcmMwZ1FtOFZi?=
 =?utf-8?B?aUFPcDh1cWdlL042Z0oyVnhVZ0ZibDdJeTRCdXVjdk9EbEZLSFhCM051anZ5?=
 =?utf-8?B?dzZJbS94MjIrK2QvL3NmdzE3WWI0dDNtL1RucnR6czdvZXBkTC82bmNYZVJo?=
 =?utf-8?B?bUFrU2FHSFBxQmkzZ05sb2xzMkZpK29CbWlUb2pRUVBzb0VCTlN2cGVuais1?=
 =?utf-8?B?SkFxbklCckttT1lnSDZtd3B1TVk0ZVdGTnBWNnVWSTdKTGNYSWVJdXlHeC8v?=
 =?utf-8?B?NVFnZ3NVN25kY1dOZ0F6NXBmb1pwNmN2V2trUG9yOGx6c0ZUK2VpNTkzeU44?=
 =?utf-8?B?ZDRsck1OT0V3dm9QcU83QkM0MGJRVTZ3NDJEUnJjeFZuaWU2ekVhSW9DaEpK?=
 =?utf-8?B?cDNGWGFIRWtEbklnRlYzU2pyd05WWUxndTlkVE1zSU5YTEdibWdKMzA2QjMw?=
 =?utf-8?B?NEp5MFNHWXZNNXQzTXR4OTFGNlJORkcwWm1RSXFZZFlkVzZLY3kvOTRXL2lP?=
 =?utf-8?B?YjVlZkF3T05qblJ1bThxNloxaWR4bGRxK0VmOHA2c2Q3VVRyZ056ZG8wTC9l?=
 =?utf-8?B?NkVJRUxkOWFmL3h3V3Flamd4Mlk2YXVkT3JVNlpySzRPUGNEYzNpRTZteEd2?=
 =?utf-8?B?bklJc3lCaUl2emNNOXNXL1NjQ1hQMURzbFR6YU1XQUpTN1JFOERtMHZScGZN?=
 =?utf-8?B?UU1TVVdiMzhucFYwSGFOYlM0UWVQTFlnTnA2VTlvbkVzb3NiL0tLU0NsNitB?=
 =?utf-8?B?eTF4NzJpT1ZNUEtYaDdaQUJGRjhsOEwxSHRONEhENWhGRUF1Nm9INzI3bUNH?=
 =?utf-8?B?a3ozVld5WXRQNVN1Wlhxb21TRUZ5Z21jK25qTnlpVzV5KzQ0bzlGbk9aNWZj?=
 =?utf-8?B?UXB3b3dXM0VtT09yTG12eUQ0Mnc3NFBCcDUrOFQrYmRhT1lFVmI1YUFad2h2?=
 =?utf-8?B?Rm5DL2t2blJoOCtxb0g1bGRoSGZldlM2YldKckF3bFU5V2RNN0t3ZUlxRzRm?=
 =?utf-8?B?cnlJSWo4S3RRVGtxa1R6QjRjMFljaERsWS9QY2ZkYkxvS0lib29DZTBHL0lr?=
 =?utf-8?B?UEkremhpVmJDdEZyZTRUUnllMlpINFhlMHNyUWp2WjM0aTFwbkxuYnRFeTZj?=
 =?utf-8?Q?jQWDt00i/2io1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdNRitpeWNnTlhhdlJ0WlFRTnV2aE0xRllweXlHM2F5RHV3ZWZhamdUM1NB?=
 =?utf-8?B?a3dtazFMSFdpcTBzMnZZNDJRbm0zZ3hER3dBK3B0am94VXQ5ZlNNODRKREIr?=
 =?utf-8?B?MlBBSjRWaVV4RnlWUUZraGJ1UFN5enZ1WVlrdVNtRkdyTjVtazh6SXZoZ0VM?=
 =?utf-8?B?QnJlTklMTzU4K3FSYlloVndQYUsvcVc1NzArZS9kN3lUWk5RTUhqUUpXa2lL?=
 =?utf-8?B?Tk41UkpYVC8xZnJTSjdmbmwyQm9xMllLaHJlVGtaQ0gyOGoxWW5nMUFpKzFh?=
 =?utf-8?B?Z0k2ZTZJVFZuNzdVUzVqUkE5RWYrTVVyRWI0VlZBNUJ1WjlkMEIwcGxLdEhn?=
 =?utf-8?B?U05WcTIrRkhlYm1kcngxMmVpR3puM2taekVsR0YwYURMQ0J0dDdrYzE0bHVa?=
 =?utf-8?B?aFplSUlkbEFnalpPZ1RJVEgwNkd1ZnJKMUhkNHFxN0FsN1AvQ2MxTk5RWm83?=
 =?utf-8?B?dStmL3A0czlKWWxhRGJWU0doYnRiL0tDV1JGRjZYT2tiR2pxNUdya1Brb09z?=
 =?utf-8?B?Tm1reFI4ak8xU1pITkJjbXA2bHRWRlZySHJKQnlZclVvTWVZN2d0RWNON25J?=
 =?utf-8?B?bC9NKzBLRDQzWkFHZE1jMXVqRGhVS1dUY0Y0N3BpZTQxYnB1dlZ4RENDMXRU?=
 =?utf-8?B?WFR1NkgwczBjZEV6TXVZdDIrRCtWZEU1MHpIYTZmWWtoSnlQWE80Z1ZnME9q?=
 =?utf-8?B?RUhlU0t0Vzg0ZEp1U3QrNUtiWFdLdFJZKzVDVzJmZUEyOGdwRFJKRU1OMzFm?=
 =?utf-8?B?TjRxdWJMZWJIUEtNQk9uaWJjYVhKcXhkbFFCSCt0enB2R3RPTGlGWTJ4WWs4?=
 =?utf-8?B?aXE3WktMQWVvM29iRklSRzdOb1R3YmpLdDdjamIrV0lZTkVpM1BKZGh6dFhT?=
 =?utf-8?B?bmxtZVkydkN1WkVPYjFmRXl3RTJRa3EyQWNDaHkwYXltdVhTby9sUHV6Q0Iv?=
 =?utf-8?B?NHJZY0RxajI4Sk50K2o4Y2lhZ0k4Sy96dFBwSzdMVEE0dUNsWlY1ZEN2aTE0?=
 =?utf-8?B?ZGJERTArMVNROFRoT2RwdmY3bkk5UzBzcFVFMEFsQXkzZWtZQjJLZDFwdi9P?=
 =?utf-8?B?VWNPVml4bzZuWmlCVUkrT255OFZ0UTBUaUxqeDZoYmhtSW1PRTZLTG1vMzFX?=
 =?utf-8?B?RmJVNzBjaFZscjBRZVZlWFV5L2xzN0ZTTTM1VDd5b093a2V5bDNpaEE1dkRK?=
 =?utf-8?B?QTVwOXFYTnRKWXRPanV0c2pZZ2l4UkhpVEErQ0NqTVBPM3FyYWJCcERKeHZa?=
 =?utf-8?B?ZWZwV3cxN2NjWlBlYWZtazFScmlYdDhCT2dwaVQ1TWc2dHFSUC9sejZ6K2Vi?=
 =?utf-8?B?K3FWVHRJTS84SkxMdTRRZWhBeVZyZDQ0bk5jS3BDVUl6akdiMklBbXlXSXZj?=
 =?utf-8?B?NXQzOTk0NVl3NUhzM0lCQ1Q4M2E2aEtzM1hVUy9HVDIzTDRIaHM1dGJEczIy?=
 =?utf-8?B?QU1mdE1oR0NqNWVLaVJpQVRLMzdhVmNsMDBuSmRRalBaejBDeHVsMHN5WHdt?=
 =?utf-8?B?dWlIV1V0dys0RzZLbFBMbTR2TndtaCtRYzkxSXZWVlMzdmVvUys4YjNBSmVU?=
 =?utf-8?B?ejVOZVpjQS9KUy8wNzRTOUtkZ1I5NnMwMnROcE53bzArL014cHRUSHVUWjla?=
 =?utf-8?B?Nzc4NkxqVngyQnlXVHVzTHpxU0xrNnZnbW1ZWGdxcHRnV1BzZCtGSFR1dzlq?=
 =?utf-8?B?cGIwQXRBZmVuRW80YktrY05iN1p0ZXc1eGphMTArMnlrYWFLR09oYlUzbVBm?=
 =?utf-8?B?VmZSRU5OR1orRG50ZEtIWVR3Vi9lY2ZFOXppMjhlaDdLdTNyMWdGaklOakhD?=
 =?utf-8?B?ZmRDUFpWVUZxQm54WlJJMVpuZklYN08yQllSTkFlYkRCT2JCTHljd3FWUkFI?=
 =?utf-8?B?Qyt5U0xnS1JTaGFXcFJYYjJoVm4zQmdRd21tWkZtQWp6Rk5oOTlWY3RrUk9P?=
 =?utf-8?B?Rk52RW54RVQ0ZEVBMUFIRktpcjhtdG84Vnl1VXpvZFRQL3FoNE8wUFkrdm9B?=
 =?utf-8?B?OVZ3RU01ZUJkZW5qVDVoK0FwQWhEeWYyQUN5YUx2ZDB5cURXSTliOXZnK0ox?=
 =?utf-8?B?c2ZleHNGOWJnRmhFTm1mbm96NlN0ZEV5TWw2VTM3a3NSQ0NsUXRyRy8zZmVh?=
 =?utf-8?B?ZXlLSXFvYkhNQXVFNDNPVjBBYkNSYndnT0ZXeUE1KzlGOEN4TTI1ZnJSVDcz?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e658d7-500a-4083-82d7-08dd204123c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:23:50.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ArDApV1IZVxZ0/5ROF5clSPRCJ8psZXywg6LO7TIB4ufhTNyaTolvufdxd6Dha6B6l1RSgnvsUXOMYRgQnFRo2WyTNEb1kC/L/41w8P+b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com

From: Wangyuli <wangyuli@uniontech.com>
Date: Thu, 19 Dec 2024 15:11:24 +0800

> On 2024/12/19 00:10, Alexander Lobakin wrote:
> 
>> Is it a fix or an improvement?
>> You need to specify the target tree, either 'PATCH net' (fixes) or
>> 'PATCH net-next' (improvements).
>  It is a fix not an improvement.

So you need to add the correct tree and/or subject prefix and specify
"Fixes:" tag with the commit this change fixes.

>> How do other drivers handle this?
>> Can -EPROTO happen in other cases, not only unplugging, which this patch
>> would break?
>>
> When initializing the network card, unplugging the device will trigger
> an -EPROTO error.
> 
> The exception is printed as follows：
> 
>         
>         mt76x2u 2-2.4:1.0: vendor request req:47 off:9018 failed:-71
>         mt76x2u 2-2.4:1.0: vendor request req:47 off:9018 failed:-71
>         ...
>         
> 
> It will continue to print more than 2000 times for about 5 minutes,
> causing the usb device to be unable to be disconnected.  During this
> period, the usb port cannot recognize the new device because the old
> device has not disconnected.
> 
> There may be other operating methods that cause -EPROTO, but -EPROTO is
> a low-level hardware error. It is unwise to repeat vendor requests
> expecting to read correct data. It is a better choice to treat -EPROTO
> and -ENODEV the same way.
> 
> Similar to commit （mt76: usb: process URBs with status EPROTO
> properly）do no schedule rx_worker for urb marked with status set -
> EPROTO. I also reproduced this situation when plugging and unplugging
> the device, and this patch is effective.

I'm not a wireless expert, from my PoV sounds good. Just describe
everything in details in the commit message, so that it will be clear
for everyone.

> 
> Just do not vendor request again for urb marked with status set -EPROTO .
> 
> 
> Thanks,
> 
> -- 
> WangYuli

Thanks,
Olek

