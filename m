Return-Path: <linux-wireless+bounces-31046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOggK17LcGkNZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 13:49:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25B570F4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7964760001F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A7B3F23CD;
	Wed, 21 Jan 2026 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCZYDdOj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803C3A9602
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999215; cv=fail; b=sgFPMDkU10MdlbARBoMs3neL6w1sUS3KBYJvLH3cbc/4hziGLgIdALM26smSZcyGRoT92TWz8t1YaHd5q16W+X3Su8ya5HlGPaIG97FbzOT1037FXlEjIfybmUhtKwz5J5bK7zy2j9Dthwkoo6CxMxngrBe04eVhTFyIQC1wAuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999215; c=relaxed/simple;
	bh=sX1xZTwlUFRKil4TQFVv07qHKkBcx987thJ7yRIqUp4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XwhTaIR1HN41h3CRtyOVcssgvDypPfwLy/9c+HEdJIv2/5BUfQPdpLxdiTIynksQJ3N2u3HHTAPVnSL5YwevqPDdLO9nc/izx5ml6XA+OQnVTNfwZCvSjpM529PTBErhurpC0rMLF+etN0M90eoNkDYxvPk2sMJGjMtwQ9TpawA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCZYDdOj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768999212; x=1800535212;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sX1xZTwlUFRKil4TQFVv07qHKkBcx987thJ7yRIqUp4=;
  b=bCZYDdOjkEgdtBEehOibbvq4wliDFa2Dxaag3A1t1cS/1RXvsxX2Eq41
   Ycn+W9s0v2NF1EcEpo6s3u6M0RrwxgRfjYJQ7r1ueh6ZH/ZE7U+0NziYh
   G1qFIxJXcg9p8gg6/nxAUIDoMy50tZzC//3LyvnSUjkz+kZHyGtL/BNMA
   BFaNG80TPewXE7/ZCK02ntgu1IkXTEU8Yu2MLs7lkvi61+U7ddKCUvCNr
   A+BPjYLy7CEdejn8k9JYoBRYsLc2EPaZuNb/AXta9l0Us0crMEiu97pIc
   12eXndAfOwZWUlaVgEwmyA5Y0sIJVJNrz9q3s0yY5ckGuUF0cZq5fzUeC
   g==;
X-CSE-ConnectionGUID: LwLCRznARLqubgP01L8zFg==
X-CSE-MsgGUID: dkf6coiiSxKfu/sBJA1xig==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70317663"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70317663"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:40:11 -0800
X-CSE-ConnectionGUID: Wz4jjiSWTCenI45XCl+xFQ==
X-CSE-MsgGUID: t7s36U7nQkCeuw7D4M5D0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211449121"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:40:11 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 04:40:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 04:40:10 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 04:40:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRMWKOE0XpF806YHMLMD5BOQs/+9i+WxcNiRVKCA/hndI/wUv2NdWkC39N8F51WYO5Quzrrk8dmTfvynqcQLZu15KLeeIzzYS/DuKWworOvspr6U/dUiPKxLKV3EKrioL0RFCXlfYh9PRvnyIplvObH7kdg+3S/JSl0p8e5kJMeeXsLRm8uM9FMhIPefVDHI70cXnffSWy8wXPH8PxWE39wPtRzDnBWkpaBuw6ZaROevFJHq6B6QfONEZ8L8z93RQTSNEG2Hukr8yBnYk/Rq6h1S/48wqaXPsKwvI9mxSywSyc7ZRqpZG0UhpWNFP6MOHa7x3evcuyYUqhDNTH7SbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX1xZTwlUFRKil4TQFVv07qHKkBcx987thJ7yRIqUp4=;
 b=a3L4pLqwmmsX1irdUW9WEvOTvty+0np5DtBCAuHBLWhyDWsZcTe+S+OBbli3mNcef85YcgzvosThYfkl6Iz99j37+l1gc2kI+thyfd968q4MP49QjhLRHHz5yAGMnxXgh0w2sB2AGyE4sPbQlcPYRtHZ0kwjFssVq5NyBEXzIuFgncR8/mqfcBIYGWyAROw9YgEwFTycutHs7hslsUZioXVFmj162qKhljVgdokaYFpStEj58+RqWPZGR9gaOee1GpJdYajgdTrjNI1hVwvn7VOPtuc1aqhT4Ll3+GmqtJBxNC0dnHPR8lQ3OXnAcvPDAV0LUx1Wl/ptG9rxrKfD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MN2PR11MB4566.namprd11.prod.outlook.com
 (2603:10b6:208:24e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:40:03 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%2]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:40:02 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Linux Wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-2026-01-21
Thread-Topic: pull-request: iwlwifi-next-2026-01-21
Thread-Index: AdyK0p06jblxX5VDRKGY+qF5uebTOQ==
Date: Wed, 21 Jan 2026 12:40:02 +0000
Message-ID: <DM3PPF63A6024A9E5E5DFC8A95A05384B7EA396A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MN2PR11MB4566:EE_
x-ms-office365-filtering-correlation-id: da700421-8d41-4cf8-6db9-08de58ea3254
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eDc0ckxUQVJUdGNXUmw2ODUxSDRiMmRwUUR4ZEJvVVNJdzhBT3o2Q1QyYnVj?=
 =?utf-8?B?WlMwQlJNZzRNMXREQ05VNG5QOTVpR09ocGJRdmQ5TG1ZaTdwZUxOdWNFYmth?=
 =?utf-8?B?aDR5Qjd0bFdwN1hMbXV2Mm5XVGx5WGs0djJjT1VVVlFuNHNUbE81VmNuUkdy?=
 =?utf-8?B?R0IrZnViL3hRWUhPcnpqTU1Ddlo0RFR3MlZIUGh4ZWFleUoweGVORXVteFho?=
 =?utf-8?B?ZUhUMkNGZisyQ00rTCtvb0RPbjRXeUF1MlhVeGpDc0JUS1dpU3BRbTFaQkVp?=
 =?utf-8?B?cXZSSFJieTJHMjVHNWFkNFdUZjRDQ1FvM0w0M1JhQi9WNUtFc1dBL25oamhN?=
 =?utf-8?B?enE3TmRvUjV4K0d6NFVnYVAyb05weEt0RFhYK3o4VkFSSXpNN0hKdy9TOXFa?=
 =?utf-8?B?clJrNmdsejdBc084d3dOVFlJSzR4Q0NPdzRxVTRydCtqZUQwbllnbGxEV0U4?=
 =?utf-8?B?Y1pmUjhZd0p5WElLQjF4ellFaGpvMlhsandLK2N1U2V3TVdUY05lM093dmg4?=
 =?utf-8?B?OEI4bXNMZUZWTzlYamV2L28zektKeUhnNUgxMUpYeTdqUmg5TW1nT0JGT1RB?=
 =?utf-8?B?TkJmM29BazgrWjJGMUJXMjd0bHBteDNWMDY5MFY4a2I0RnI3UkxSZHBwVVN3?=
 =?utf-8?B?ZkZLWGd3N01OUEhVTGZyNkVQSlMwd3F4d0cyV1IvZVkzb1ZGR2lqeDFrb3Vx?=
 =?utf-8?B?dVFEbURHcmduWEpVQWRHanp3TUJtUGVhUTlvaEZkM2V4MTU1T1FUVHljZmg0?=
 =?utf-8?B?TWdLb21oK1g2emxWRjB4cG1aNy9Bb1lNVXk5SjN6UnIvbW5CZ2xaTlJyS1lB?=
 =?utf-8?B?dlBMZFQvR2dEZUJIUU5jOERkd2R0cGFBdzN3Tml5M0dJdVFwNUtCNWc0bmR3?=
 =?utf-8?B?bjY0VlNRZzV3aE5BclIzZ1V1Nk9yU3BCSlB4bjYwcU84Qys2cXg3VmhZdFBE?=
 =?utf-8?B?cGxpbEN2cDNWOWFUQkdUVEtHcDdNYm5LazJlZU9ZS1pZQjl4Mno1ZVkrVGY2?=
 =?utf-8?B?VThaTVJLQ0JjK0pVSHRHYm5sSnM2Y1QwUys3TGZwVVp2VlB6N2Z3aEllV3d5?=
 =?utf-8?B?L3BkWXJIQlZTbGJrcGFjWXFHVmVJdjdqY2hteHNGaDYvZEp2OWRvdXdaU1BX?=
 =?utf-8?B?RENRU3A0UHFwc0V6c0kwVzlmNGNOejZYb2pHcjB2dC9mcSsrY204UG5nTkV6?=
 =?utf-8?B?MURncXJ3N3g5V2lhSURXTE92TmpIczhjUGpOYUFXZlAyOHRLT1M2UW53SEdG?=
 =?utf-8?B?eCt3eUFMczA1YWw1MVdnem1HSkNoNnd2NTNOT0thbzZ1UzV2Zllaa0NOSHVr?=
 =?utf-8?B?WmJSMmFrQzVOdVg3OGh1TXh4cGovNXFyZHJDeldyZndKOENZditzay9zWU1K?=
 =?utf-8?B?YTBUTVVoY1B1WXVuNCtPandTYkhqeXZuYUd1RWtuQm9RakpLYmpXWDhKUXp0?=
 =?utf-8?B?Rzk5U3Vza2NDYlQ5R2xQVkhlZ1JtSXFSNW1YOWc2Q2YwQSt3azJ3YWVRUkJI?=
 =?utf-8?B?dzhqSVlHQ0IrVU1PdU90S1FTUzN3OXdRWE4ybm5icENOZWY4Tlk4ZGIvUFBz?=
 =?utf-8?B?bnpSRlJjSXNxTE1hekhNT0k5czk3eXRjSlRRMHI1QzN2T0t5K2xQSk1Felpn?=
 =?utf-8?B?RktYdTJGU2E5UjUrczdpT0FvejAwN2k5SXRNdG91MVFNSTV6WmJ2K090R3ZG?=
 =?utf-8?B?ZGl6ZTlhc3V1ellaNXBkU1Y0SzJqRWZsdkxZVW1ZOERLbWVZbUVWWHZNTjJR?=
 =?utf-8?B?c0lpbzdpNU83Mkt5YjBKNURMb29ZeGluUmhBUkV0TWpZWUtOU3JKUVhDdkJt?=
 =?utf-8?B?dXVkTHdyTVFqaVE1T0pTaGE2bk1JRHhkUGdDeitkRFc3NDFoV3FyVmNaYjNY?=
 =?utf-8?B?WWZRakovY2hkdGtJdk04TmJNN1F4YSttYnhzVTF0TGxMR25zdHkrNE1GZXJi?=
 =?utf-8?B?RkZwRnVRS09PWFczR1JTSndWVStsaXZuOFRrYkE4dzB6OFpkY3lLSEpBVGVG?=
 =?utf-8?B?SEJRZ1ZxMFNGQ1N1cHhGb3BVRWxlazIyZHV1enV1NXNNUDlrczF6NXB2Sm0x?=
 =?utf-8?B?aFc5bnpwaVhudTduUXl2aVNUajlMb3NJc3E5ZUhHM1NVdm9EY0RJYitSY0hF?=
 =?utf-8?B?S2gxOEdmS3IzOWlGUThobEkxNGgyckt3ZkF0dDNDZlZyc2E3ZWhGRmh6S1VD?=
 =?utf-8?Q?QmID1VYejjfBBYMh9g8Eo3Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TENVejFhbmVwTDRVVzBHSC9nZmxkYnFqM2puRm5zU1JZRkwwVndMMVU3U0JN?=
 =?utf-8?B?ZXlydWFMNEtoekFSWWdXYmNwZWVSQ2NTMW5kUlloWFVVMG1wZGNjbXlYMEhO?=
 =?utf-8?B?azYwMWRZQkw1R25vOTk4bjRxWlZ6MGlwYU1lTFNLY241MzBJQXNhWXQzUStr?=
 =?utf-8?B?QU5MM3VhQlZhT2FzaTQ1T1lMUHVhYWIrV3pYWjJRNHRCQmJXbkhESXo1ZWt3?=
 =?utf-8?B?dmd1UnlFM1Rwb3RyUnlPNndnTWUwbFV6eWJzTmpvb0d0clh3Uk04Y0h5WEVK?=
 =?utf-8?B?OTBEc0RsYWtLZHVGaUpzT2lUNjNQN0FNL1FmbFRTaDVYaC9rcjJ3YktHM0Q5?=
 =?utf-8?B?RHMrcHhHSVdlVUM3Rk1wU1g2ckkzYUx4TnU5eWc1VGFvT0dRT2h2aG8yeW9V?=
 =?utf-8?B?dC92bCtaSDRMeUJwemZhUmtzR2Q4RzNpZVIyWFFtcXZvdDQ3RW5QOGxQN3NC?=
 =?utf-8?B?WlpOQ2xjRTE5eWs1Ylc1UDhISGE2ZGpQcGlsUkNJSFVOaDJTVjF4ZlFJOEww?=
 =?utf-8?B?ZkVMdkRZNHJLSi9WZVkyb1RPRCtXRHd4TzBrdlZ1RTk1R2pDNzZuWDZob2p3?=
 =?utf-8?B?cjVFYXVoQkhidndRZUJMZmZTNktMbTVqMWtET3d5YmdZcUp3VG00NVhPR1Ro?=
 =?utf-8?B?MzQwek1JMnJGTGlzdE8wK0l5V1dZQjNadzdYaE5KaGlzekw4V2dERTNvejdm?=
 =?utf-8?B?OHAzR2NlNHBTdkQ0Ymh3OFNLdDJFRUgvMXJYQm5WRWpjbnM2bktNSG1yV0ZT?=
 =?utf-8?B?UmRVc2oxcmd2anFuMExVQkZhMllFc2UxK0p1My9weWNnYzRuRk9DWTZvY2V5?=
 =?utf-8?B?Ukc0SWt2N0FKMW1OKzhwUmkyejBzUmxnU2xuRGlneWdORjFpNWJZWDBoNjI1?=
 =?utf-8?B?d0RYZWtIWFFNdVBqUDYyUnE0clhkTE9ZVjBaQklUbDJiUFRDYzhtVmM0QTMy?=
 =?utf-8?B?d2szL21XMzZGL2x6ZXdjdElVNjYxbDhPNTJ1TDN0b2Z1dHVoN2dlZlRTaW1M?=
 =?utf-8?B?ZUQxYmdNL0F5WkpFcERaZWV1bFZtZ282Sk45OC9OdXI4aE1uU0N2cUhKT0ZS?=
 =?utf-8?B?NDVSQkpWYUFVajlVUlMyVzlyZitvNkhnSnJyS3l5Q0Q5NlA4WWtlM0hJOWdz?=
 =?utf-8?B?Um1XYkQzOWdsZXhmaTRmZjBqNkdKTnNKZkxZN1A4Vkh2S0dYMnJiaU5WYk5L?=
 =?utf-8?B?SFJYaUdZZ2lNbUtTRjJjZkZNeEpKUlRpV1VNemljanBCcDl5VEhYSFhFcTBR?=
 =?utf-8?B?OGc0YS9Nbi9wSmhwMDZiaG4vc0RjazZNaXhLR09yeTdCQ1c1Tk1MZ1R6dnEr?=
 =?utf-8?B?SHFDejhJOWtjTVhqTldTMUZVQWhwTnFrWXI1VURtUTJHclF0OVM4MitOOEJZ?=
 =?utf-8?B?UytsYW9qV3JFUVA1MlYwU3ZWWlFJb3F1dUVHVlNHemNhY2FXSTZ1aG5yWHYr?=
 =?utf-8?B?M21kbnBEcEVCVE5QNUxHSGExM09MTGRGYW9mTndUeTk0VUROVWZKVnZMMWZY?=
 =?utf-8?B?OW9LeUc5MWYwd1E5Qm12Zjk1aHM1dzRyT25ObU5oU3dKTktZZEVTTUVVT1Vv?=
 =?utf-8?B?cDlNaURSTVQyblZQYTY0ckxKRjZjc2FlUkIrNkhKSWNBRkxta0JYUm05dnVl?=
 =?utf-8?B?WDBTT0NvdE50UmF3Ymp4QUJTL0xlSjVWVlpJUEwxRU5hUHBCZXdFbmkyOW0y?=
 =?utf-8?B?OTJuWEJSMHBqaUlZY2d6YUxpR1VVT3Q2VTgyOGVGM0YvblcwbnRwVWJtcVJH?=
 =?utf-8?B?a0U0Z1FWM1E2TW5lY1lLTTVSUFNxWkJ0Z01Ta3NzaXMrVFFnSm5jSmhzdEp5?=
 =?utf-8?B?SElSSkVvYllnQ3JBSk4vcU5pQ1FDdkU5VzBNejE1bDlHdkdaQ0pMZWtNeHJM?=
 =?utf-8?B?eFpjcXQ4VzR0YWliQ1EwQlZ4YjFVMUFTcVVQbndhQ0dZZC9NY3ZaOXgybjlI?=
 =?utf-8?B?VlBzaDVVbEJ2cG1vQ3hTSFNkRlMyOEppTFQxSU1YSEV3M3ZZTzk5MTRUUElz?=
 =?utf-8?B?OFU1QnBnSnZvQlpYWVBDNU5IYmVKVUtLai9ldkxVc1hYQmt2cmo2dFVONVh1?=
 =?utf-8?B?eFlTRUFkSmZuYmxOeCtvUEFDb1hxQndHTWNSM2NJU05rL1hzZHF0S0x3dzNq?=
 =?utf-8?B?T09hQnJQVkNJeDJML1pSQUY3aVpMOEZTd1BObFRMRG9aMVF1RmgvUUpOOGFX?=
 =?utf-8?B?Y2hweU0raW81YzExdHNSSGVBL0NBSTFkSlRxUjY3NTdFVXJlRitHSzZ6QWNK?=
 =?utf-8?B?U0c0Y3JIS204MERtMnRkcTRCUkk5UmRMRnlueTRxYnFXczFXeUNYczUvNUQ4?=
 =?utf-8?B?dUhSNlFqcEkvbjlpbGNUbW5kN1hEelB0aW1qYmZDWDNlSVBaOC8xbkRjRHZ3?=
 =?utf-8?Q?a5dPsGyhqtkhb0Ss=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da700421-8d41-4cf8-6db9-08de58ea3254
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 12:40:02.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+6d7mRu/P15N0JZSzf5AV6FtiMX/a+XBybsAa6kx3BPLVD+sU4HILTC2JLgPg39JhhA5MVoNBIC5DxGr8dTOLO51sfxJOpQ2tfMsMJ1cPZz4KdUoYGJPNwrNmRyJVaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4566
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31046-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:dkim];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6D25B570F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAxZTFkZDllZWFhYjM5MDg3NDZkMWRj
ZTVkYjZiMGMyOWUwZDI4ZDZkOg0KDQogIHdpZmk6IG1hYzgwMjExOiBtYXJrIGlmYWNlIHdvcmsg
U0tCcyBhcyBjb25zdW1lZCAoMjAyNi0wMS0xOSAxMDoyMjozNSArMDEwMCkNCg0KYXJlIGF2YWls
YWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0LyB0YWdz
L2l3bHdpZmktbmV4dC0yMDI2LTAxLTIxDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byA2NmFmOGFjNTJkMTBlYTIyOWQ1NzU1Yjg3MDBlMmZlODZmYzAzN2Y3Og0KDQogIHdpZmk6IGl3
bHdpZmk6IHJlbmFtZSBzdHJ1Y3QgaXdsX21jY19hbGxvd2VkX2FwX3R5cGVfY21kOjpvZmZzZXRf
bWFwICgyMDI2LTAxLTIxIDE0OjIzOjAzICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3aWZpIGZlYXR1
cmVzLiBOb3RhYmx5Og0KDQotIFBhcnRpYWwgTkFOIHN1cHBvcnQgLSB3aXRob3V0IERBVEENCi0g
SW5pdGlhbCBVSFIgc3VwcG9ydA0KLSBVTklJLTkgc3VwcG9ydA0KLSBFSFQgY29kZSBjbGVhbnVw
IGluIGl3bG12bQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpBbGx5IEhlZXYgKDEpOg0KICAgICAgd2lmaTogaXdsd2lm
aTogbWxkOiByZW1vdmUgdW51c2VkIHZhcmlhYmxlIGluIGQzLmMNCg0KQmVuamFtaW4gQmVyZyAo
Mik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGRlY29kZSBWSFQgaW5mb3JtYXRpb24gZm9y
IHNuaWZmZXINCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogY2hhbmdlIGNsdXN0ZXJfaWQgdHlw
ZSB0byB1OCBhcnJheQ0KDQpEYW5pZWwgR2FiYXkgKDIpOg0KICAgICAgd2lmaTogaXdsd2lmaTog
bWxkOiBSZW1vdmUgd3JvbmcgY2hhbm5lbCBmbGFncyBpbiBzY2FuIGNtZA0KICAgICAgd2lmaTog
aXdsd2lmaTogbXZtOiBSZW1vdmUgZmV3IHJlZHVuZGFudCA2IEdIeiBzY2FuIGNoYW4gcGFyYW1z
DQoNCkVtbWFudWVsIEdydW1iYWNoICg4KToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogdHJp
Z2dlciBhIGR1bXAgdXBvbiBub3RpZmljYXRpb24gaWYgbmVlZGVkDQogICAgICB3aWZpOiBpd2x3
aWZpOiBtb3ZlIGxhcmkgaGVscGVyIGZ1bmN0aW9ucyB0byB0aGUgb3BfbW9kZQ0KICAgICAgd2lm
aTogaXdsd2lmaTogbW92ZSBpd2xfZ2V0X2xhcmlfY29uZmlnX2JpdG1hcCB0byB0aGUgb3BfbW9k
ZQ0KICAgICAgd2lmaTogaXdsd2lmaTogYWNwaTogY2FjaGUgdGhlIERTTSBmdW5jdGlvbnMNCiAg
ICAgIHdpZmk6IGl3bHdpZmk6IHVlZmk6IGNhY2hlIHRoZSBEU00gZnVuY3Rpb25zDQogICAgICB3
aWZpOiBpd2x3aWZpOiBzcGxpdCBiaW9zX3ZhbHVlX3UzMiB0byBzZXBhcmF0ZSB0aGUgaGVhZGVy
DQogICAgICB3aWZpOiBpd2x3aWZpOiBzdXBwb3J0IFYxMyBvZiBpd2xfbGFyaV9jb25maWdfY2hh
bmdlX2NtZA0KICAgICAgd2lmaTogaXdsd2lmaTogcmVuYW1lIHN0cnVjdCBpd2xfbWNjX2FsbG93
ZWRfYXBfdHlwZV9jbWQ6Om9mZnNldF9tYXANCg0KSWxhbiBQZWVyICg2KToNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1sZDogQWRkIHN1cHBvcnQgZm9yIE5BTg0KICAgICAgd2lmaTogaXdsd2lmaTog
bWxkOiBIYW5kbGUgcmF0ZSBzZWxlY3Rpb24gZm9yIE5BTiBpbnRlcmZhY2UNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1sZDogRGVjbGFyZSBzdXBwb3J0IGZvciBOQU4gY2FwYWJpbGl0aWVzDQogICAg
ICB3aWZpOiBpd2x3aWZpOiBtbGQ6IEV4dGVuZCB0aGUgTkFOIGNvbmZpZ3VyYXRpb24NCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG1sZDogU3VwcG9ydCBjaGFuZ2luZyBOQU4gY29uZmlndXJhdGlvbg0K
ICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBBZHZlcnRpc2Ugc3VwcG9ydCBmb3IgbXVsdGljYXN0
IFJYIHJlZ2lzdHJhdGlvbg0KDQpKb2hhbm5lcyBCZXJnICg3KToNCiAgICAgIHdpZmk6IGl3bHdp
Zmk6IGZpeCAyMjAwMCBzZXJpZXMgU01FTSBwYXJzaW5nDQogICAgICB3aWZpOiBpd2x3aWZpOiBh
ZGp1c3QgTElOSyBjb250ZXh0IE5QQ0EgQVBJDQogICAgICB3aWZpOiBpd2x3aWZpOiBhZGQgVUhS
IFRMQyBtb2RlDQogICAgICB3aWZpOiBpd2x3aWZpOiBmdzogYXBpOiBhZGQgVUhSIGRhdGEgZGVm
aW5pdGlvbnMNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogZml4IEhFIFNJRy1CIE1DUy9EQ00v
Y29tcHJlc3Npb24NCiAgICAgIHdpZmk6IGl3bHdpZmk6IGZ3OiBhcGk6IGFkZCBIRSB0eXBlIGZv
ciBVSFIgRUxSDQogICAgICB3aWZpOiBpd2x3aWZpOiBjZmc6IHJlbW92ZSBpd2xfYmUyMjFfbmFt
ZQ0KDQpNaXJpIEtvcmVuYmxpdCAoNik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IGNoZWNr
IHRoZSB2YWxpZGl0eSBvZiBub2FfbGVuDQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IHN1cHBv
cnQgVExDIGNvbW1hbmQgdmVyc2lvbiA2DQogICAgICB3aWZpOiBpd2x3aWZpOiBjZmc6IG1vdmUg
dGhlIE1PRFVMRV9GSVJNV0FSRSB0byB0aGUgcGVyLXJmIGZpbGUNCiAgICAgIHdpZmk6IGl3bHdp
Zmk6IG1sZDogZml4IGNoYW5kZWYgc3RhcnQgY2FsY3VsYXRpb24NCiAgICAgIHdpZmk6IGl3bHdp
Zmk6IG1sZDogYWRkIGFuIGhlbHBlciB0byB1cGRhdGUgYW4gRU1MU1IgYmxvY2tlcg0KICAgICAg
d2lmaTogaXdsd2lmaTogbWxkOiBwcmV2ZW50IEVNTFNSIHdoZW4gTkFOIGlzIGFjdGl2ZQ0KDQpO
aWRoaXNoIEEgTiAoMyk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IEZpeCBwcmltYXJ5IGxp
bmsgc2VsZWN0aW9uIGxvZ2ljDQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IENsZWFudXAgTUxP
IGNvZGUNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogUmVtb3ZlIGxpbmtfaWQgZnJvbSB0aW1l
X2V2ZW50cw0KDQpQYWdhZGFsYSBZZXN1IEFuamFuZXl1bHUgKDIpOg0KICAgICAgd2lmaTogaXds
d2lmaTogZnc6IGZpeCBkb2N1bWVudGF0aW9uIHJlZmVyZW5jZSBmb3IgYXBfdHlwZSBmaWVsZA0K
ICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiByZWZhY3RvciBBUCBwb3dlciB0eXBlIHNldHRpbmcN
Cg0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnL2J6LmMgICAgICAgIHwg
IDEyIC0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9yZi1mbS5jICAg
ICB8ICAxMiArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvcmYtcGUu
YyAgICAgfCAgIDEgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYWNw
aS5jICAgICAgIHwgMTE3ICsrKysrLS0tDQogLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L2Z3L2FwaS9tYWMtY2ZnLmggICAgfCAxNTkgKysrKysrKysrKy0NCiAuLi4vbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvZncvYXBpL252bS1yZWcuaCAgICB8ICAzNCArKy0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9wb3dlci5oICB8ICAgMiArLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3JzLmggICAgIHwgIDQxICsrLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3J4LmggICAgIHwgIDk1
ICsrKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2ZpbGUuaCAg
ICAgICB8ICAgMiArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9yZWd1
bGF0b3J5LmMgfCAyMDYgKy0tLS0tLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2Z3L3JlZ3VsYXRvcnkuaCB8ICAgOSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvZncvcnVudGltZS5oICAgIHwgIDE3ICstDQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9zbWVtLmMgICAgICAgfCAgIDggKy0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L3VlZmkuYyAgICAgICB8ICA3MiArKystLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvdWVmaS5oICAgICAgIHwgICAyICst
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtY29uZmlnLmggICAgfCAg
IDEgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL01ha2VmaWxlICAg
IHwgICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvZDMuYyAg
ICAgICAgfCAgIDIgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2Rl
YnVnZnMuYyAgIHwgICA2ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
bGQvaWZhY2UuYyAgICAgfCAgMjEgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL21sZC9pZmFjZS5oICAgICB8ICAgMiArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tbGQvbWFjODAyMTEuYyAgfCAxMTQgKysrKysrLS0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbGQuYyAgICAgICB8ICAgMyArDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWxkLmggICAgICAgfCAgIDMgKw0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21sby5jICAgICAgIHwgIDU5ICsrLS0NCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tbG8uaCAgICAgICB8ICAgNSAr
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbmFuLmMgICAgICAgfCAy
OTkgKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvbmFuLmggICAgICAgfCAgMjggKysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9ub3RpZi5jICAgICB8ICAxMyArDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tbGQvbm90aWYuaCAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbWxkL3Bvd2VyLmMgICAgIHwgIDM3ICsrLQ0KIC4uLi9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvcmVndWxhdG9yeS5jICAgIHwgIDY2ICsrKystDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvcnguYyAgICAgICAgfCAxNDIgKysr
KysrKysrLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3NjYW4uYyAg
ICAgIHwgIDEyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvc3Rh
LmMgICAgICAgfCAgIDMgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21s
ZC90bGMuYyAgICAgICB8ICA4NSArKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL21sZC90eC5jICAgICAgICB8ICAxMSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vZDMuYyAgICAgICAgfCAgNTEgKy0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmMgICAgICAgIHwgMjAyICsrKysrKysrKysrKystDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbGluay5jICAgICAgfCAgMjIg
LS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jICB8
ICAyNSArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjEx
LmMgIHwgIDY4ICstLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0v
bWxkLWtleS5jICAgfCAgIDYgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS9tbGQtbWFjLmMgICB8ICAyOSAtLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tdm0vbWxkLW1hYzgwMjExLmMgIHwgMTkzICstLS0tLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tbGQtc3RhLmMgICB8ICAyOCArLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oICAgICAgIHwgIDYwICstLS0tDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcnhtcS5jICAgICAgfCAgIDgg
LQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3NjYW4uYyAgICAgIHwg
IDE4ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdGRscy5jICAg
ICAgfCAgIDQgKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3RpbWUtZXZl
bnQuYyAgICB8ICAzOSArLS0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3Rp
bWUtZXZlbnQuaCAgICB8ICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL3R4LmMgICAgICAgIHwgIDUxICstLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS91dGlscy5jICAgICB8ICAgNCAtDQogNTUgZmlsZXMgY2hhbmdlZCwgMTU5
MSBpbnNlcnRpb25zKCspLCA5MjUgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL25hbi5jDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL25hbi5oDQo=

