Return-Path: <linux-wireless+bounces-33664-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIRQGLLgv2ml9wMAu9opvQ
	(envelope-from <linux-wireless+bounces-33664-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 13:29:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4E2E935A
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 13:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC9983005582
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0102EC08C;
	Sun, 22 Mar 2026 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFHjUCHK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF312AE68
	for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774182574; cv=fail; b=tY3Db8DT2Ok4Oy/8bO+a9WuWJ830k7/G1iArYNV+u+ANTZ+o+e3ViX6avhBxMji/+Oi2QEke7EHrXj2NunOxiI5nC5fWsMw04zg3w96B3Vh2gLgH1quWcjAzZDNP3Nt08ZeenO4z6v4fkaI+00nuXjxv4f/APCgxTfF6Ng3uJw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774182574; c=relaxed/simple;
	bh=GF558Zanj8QSjn5sJ0VfAKJSmGWvYOE3wlgviAfYyGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UE8LhbEiIuMvdZgsKAplRzo8DlPXNqEgkfl1nitaaNW55P/vykN8jPaodz/lBR5C28YA2KPhCEZQv6fSuDCbmxG8Ekv4uTnWQie5aKcjheZSbhjA/CGLLxswPnHzg0ZhYZ/9xF7q5IDooiPwidm3Ep86t7/T2Op6sAmtFftXO4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFHjUCHK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774182573; x=1805718573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GF558Zanj8QSjn5sJ0VfAKJSmGWvYOE3wlgviAfYyGE=;
  b=AFHjUCHKPcGk7C2NrGWho0B9gaN6xKG2UDL3B7Q29S+1dqnzRe/1J2F3
   3uSvKMtJutZYUJ8UolULr2PlfIG+7cZEwdlTAlXH+7JrPwMSZ8HKXtYjQ
   pdLGBOPddLWN0KGzstrTBEpGzQevLKH5EdpsGULBfK0KSngbrNARE2Anf
   QlqcE+JaHB8LmQMM4eaeIWFy+iRAtRmi/c/DsuN/N7nNL7ynHJv6jXoSb
   9Y0kQJBAUICy4Rf5IJ8edK0pBXHeBhO5+Ivg6nBMB88qg8kej0328Wl/A
   14evYtct/lrjXulMxg2sIvTLDqYD9jnbmfse5kQZW0dlIgwCNsguaCuDo
   Q==;
X-CSE-ConnectionGUID: oz9cYD36QtO6ET3FRUC6SQ==
X-CSE-MsgGUID: b3f61bC9SCmlurpUZtF7Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="85902783"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="85902783"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 05:29:32 -0700
X-CSE-ConnectionGUID: 8p0srnr+RACelBdSztAiNw==
X-CSE-MsgGUID: 0BuYK+ifTOqb5gep1O7vvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="219006108"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 05:29:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 05:29:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 05:29:31 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 05:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMhM/9e6BKav39yM56gqXYblIZ2QyRpbfn7di8fWh9Rp7JNpv3/IPWLriQRWkCMSwyPI3qsD3TB7PKI44B+SlCtSFSWN02wdn+tlvQc3TMKAl5jfJ+KnaG89xZAXm4qCh1sWEaEO/rAjDfCPzuii73cZ0Zapi/Y87oL5XC1mUhtGdhuJiSCsBwwzANvfd7XYo6R5wXl7NTFVsEia9KjjqtJxBAxq0f8SxgXhVRri3dP2q+Ydvwg1ute5V8dLLrjfnA2b2oxbI6FPtYhlylgjLA6wsGQXyH3vG5M3GEIDfwQnHAbdKBiEnRWZ/cHIXcKJHRgwnaSKs62yfWe9+mwl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF558Zanj8QSjn5sJ0VfAKJSmGWvYOE3wlgviAfYyGE=;
 b=dH3WXECOe4z7jj/XDjIFBk0vlFequ6rBm1fIXBpEuSKXTT93iml8/pksEhkFnM/uAsaiI3BftvlRKhASHkBF26WmQGl/sRqJjc/yXyfiKEYrG5ttEtYx6kx8dIIbvjKG3DQk+rd5js5+LGvwJ3xks7CFNTBwtmzgE3fhYSDu3cM34shtb0Wkjj5vPylP+PbhWN0es2SjhoVrBtB0DQPPw4ThmFKbTsrjwVVu4tBPbL7lep2ORJN1jLg7iSRpQAEBYGZ5gkt7Kaa+Mj0W3ccDzD7kEI79kAe7OgDwOI+frGMGC585JV1420GucPA/K62dP+CDSP/YMpnJz3m5WrLBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SJ2PR11MB7427.namprd11.prod.outlook.com
 (2603:10b6:a03:4c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 12:29:29 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Sun, 22 Mar 2026
 12:29:29 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Cole Leavitt <cole@unwrap.rs>, "greearb@candelatech.com"
	<greearb@candelatech.com>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/1] wifi: iwlwifi: mld: fix TSO segmentation explosion
 causing UAF
Thread-Topic: [PATCH 0/1] wifi: iwlwifi: mld: fix TSO segmentation explosion
 causing UAF
Thread-Index: AQHcoOWLAIlAtgQffUGQ3JRLXb/XSLW6rSFg
Date: Sun, 22 Mar 2026 12:29:29 +0000
Message-ID: <DM3PPF63A6024A9EBDFBD21B924D24F3D0BA34AA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <9edde56d-bfdc-40f6-862c-b69950cc2f25@candelatech.com>
 <20260218144723.31699-1-cole@unwrap.rs>
In-Reply-To: <20260218144723.31699-1-cole@unwrap.rs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SJ2PR11MB7427:EE_
x-ms-office365-filtering-correlation-id: acc5f21a-c67b-4af9-0801-08de880eaa2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: zEti/YqizrNk7aKcCJlE2/0UrEtQLPTHbbyI+0p8i+TmodGzff748Fc4+32TG3mOael9ZhqlgH6iZp1r8Ra5Us1zPn3WZOL4n4qmZLeQdJgoQiK9A47QAvWdIFHwoEmm292PfbwS4C1etnvrito2xUnVECT+3QRoGiz5jYYQm5gk4LRFNd3DNAUGwXCjMdKbzdxRoZfK2fCSYrSQSq5DCiWLsZzOuKrdVOC9QYuYfUl0gHDVm6YGsX/7oA0WUnALmS0Aps3sbt1NmgKjog6jBYE9uaHQytS5vdD1G6RsZ3CV4QfSPgHwAxFJRPWHh9WQNhe1sm1tW2BeFFLHeTGZkcidqyZm5ZhjNE372zxWGYROYqXQ51SxW/U3uB93ERrfb6i4cIpOj2JRrehxb0plkOVTZMTjWhig9AHoBlwEUzEtsTpvkZo+/gCeEDxTuRZhDslJ99gYgBJ8Xau2EoI15K4QblMPnuIjq5f/Mpha8RzWRKQ9RDunDlU9k5rsuJuEU6UZj/+3gC99lZTOSHbLwcQL4lQ5GHA+0681DpeF2VhtMfHP+cSpcNWuUjIeMaTGrz09y2YG7qiag4MTeZbS8FrOMrlfdOhTGVUzhF2YcXQHXBztDVjhCk9R/DBT/OeCMs3i6RPA8Bs1Tmfz9g/Zs/UPLk3zmr2GwPAY5aNAGc2rWIPBVpnb8lURxVLrIjw32o1NFm4psJ0nYgK3+WTlnpvOCfw10YqHG/zzWlCX3uQu31YpYV9iTuSOAtr3/tDguf6DgZIqE3ZvS9eDuKAJCAQDneG/CSjR4dqraYZGGHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnEvTnV4SlRSZEZxL29pczVBbkplRE5DZ2FLUExEWTFSNlhMaTgwL0c3SDVR?=
 =?utf-8?B?L0Z2ZjBLSkZJYm9LcytueEZXaVdzYTZGMzZmVzRqTVVZSDB4dzd2ZzBmUDB2?=
 =?utf-8?B?WncxaTFtekwzTlpUVmdDVFhMLzlGaU9lNUZvNkZEVlZQaXhrTXY0Qys1REhQ?=
 =?utf-8?B?OXVPWEpneE04OW1HcDYwU3Y0QXdXT2taQXBZQzV5YmVySEZtT3g4T2NWOXE5?=
 =?utf-8?B?bm82Q1hxQW5lY3R1RUVQVHYwVnplM1FBVlQ2QkJ1VEhYTit1cU1jMzRZUnIr?=
 =?utf-8?B?bW1DbGtJeE43YWd5OVJCK3dnRDhjMWttWTh6Z2ZNc01wT0tJczdhMjVJTWoz?=
 =?utf-8?B?bTJaYXpSc1lPN2pEOVJja2NVcnprNTQ3VVc2TUMrN003WjBGelN5ZGdhQ201?=
 =?utf-8?B?MWtlVWV1MjMzN3JXdjhLanA5QlEwRmNHeHhNUDBqUVRkWVZ3bUZPOGMzemVE?=
 =?utf-8?B?NVJESDdxdlcvcW5ydjh0eXZ0eU1wR1oySEIyL1NhMTRWdG51S1Brb3lRMUlC?=
 =?utf-8?B?TXZuaHZDamhGVmJEaWwyQXFpbXFLK2U1MldSYmJrSUtCeEI5QnRwak16d0FM?=
 =?utf-8?B?U01JdUlQQTNxajFGL1BLbU1iM3hmTjJxN2p1NTV0NlFLeVhPdUZmcVI0ejUx?=
 =?utf-8?B?K20yOXVORkt0dHlvazByWGJDR1NGRWJkaE5IZjNkSXExVW9VcXRndmZEcDNx?=
 =?utf-8?B?aHBTNFVnZ1pIaXNGRFk0bGlKY0JtZTBGdXdQdEdhemRITEdLcjhQTk9JL3ZH?=
 =?utf-8?B?bTUzb09VM2R6WERDSUV4V09QU1I1NkVCOHRYc2lyTzkvMHF2ZXdPR3o0djZr?=
 =?utf-8?B?dS9RMXRsdXlta1QvaVFqbzZuQWJ5VVF3WGwvNUk1SjRvMldhb1g0aGMzeTY4?=
 =?utf-8?B?MDNVckVhbVZwTWxoWGE2dUxadFltTWRPSHQwcDRuTGYxdHoyOUZHVXVoNU1E?=
 =?utf-8?B?UFhUZWV6bmVGYUZKNGJ0Um5NSnpKejhqWFVIeUJESTI3ZmRUbHdEWVd1SThi?=
 =?utf-8?B?TGZFbVdYaGhXeURsd2MzSFJTOXJVRldtUGo0a2U5SU5NTElrWDh2MS9zcmlS?=
 =?utf-8?B?YnRTK1VOb1RGL3hSNzN4V2s5bFJEanA4bTlmc2oxbVlrRHFMVjB3N1RnY2hJ?=
 =?utf-8?B?Z2ZYY054V0R2eHp2RFlHUW9MakQxZHFlMGpTb1RSa2I5SmRIWERSQmhoTy8x?=
 =?utf-8?B?eHR0NHVhMVZNUEZVWGlJU0d5SGRRdk8wNEFQcW9yTVB3eTVTUzhyc0lqRTZl?=
 =?utf-8?B?WTAyc1puM0wwQWFYdjZMZ0tibmpYbGRYR21sTStkeDlYcXM3YjBueG1Fb3Rm?=
 =?utf-8?B?ZHYxWUYxbXZjMXRSSmRNeUZLek9MRlA2Uk5zR3M4ZmN6MTBNYWR6SWJ0NjJr?=
 =?utf-8?B?N2xzR1N2K2NaODRWZDY5d3pFbUI5Tm9SeHVrUU9wYWRUWmYrTzdGZlZBK21H?=
 =?utf-8?B?NkZ3NTZtTXdWZHhTRmdFaWtGRjZQS1NaN2kwd05rZDFmWmpPWHc3M1ptOWZx?=
 =?utf-8?B?bEdiYWpnOVV0ZEFUUnVJZExYc3hQSkc5ZXRxb3QvN1J5cEZmaWh6K2Fvc0RN?=
 =?utf-8?B?NUhSNDdQQytFNFRBQ2hlbHN1WXMveFViSUFaZHlwY3A4OEliVkRqK3E5MWxG?=
 =?utf-8?B?Q0VBTnpuSHdyS0xYcWVMQlR0RHYwSk5XV2FHaUFPYjZWTTZqOHQvWGt1bDl0?=
 =?utf-8?B?eWZoSmNZZVArLzRPN3hmYXBGalR2dlVzN1NIWTFISi9ueE9ZbDZPc1NkTFVP?=
 =?utf-8?B?ZDFleHhWTHhzS21DUG1ob0pmTVNkanA2SUFTREY5Vkh1VVVHU3I1a3pVai92?=
 =?utf-8?B?R1pNTDVtYVhsV0hGcnU2NmQ5dEphZGJCSWpjbHJoL2JNSGh6a3lqNXhqM3Bl?=
 =?utf-8?B?MFlJRldnbkdrSzN4anlnRnVUZ3p5dzgzbnNZNGRSQkVBT0I2S1pPRE1uYmJQ?=
 =?utf-8?B?bGxGM1ZOMUg4UkpSWXZrSVVpYTNGeVRZT0drZVdqVGVCM2dORmFkekFHc3RQ?=
 =?utf-8?B?cUpETTQzVkN4L2NxRzhFbjF6S0d2dk5iMTRLRGlaRzU3UUxwcnR0V0dxOXpP?=
 =?utf-8?B?dHY5QnBrNXMxREdrd2RlZlI0Y0lyNWpCWVR1ajZOT3QwRGdPazhmYThLS3dx?=
 =?utf-8?B?T2RiSVBDbnUzRXVlS3hPUHMxRWpBQmFKNjVCZ0QxMVJBS29CeGZzdVdxdllK?=
 =?utf-8?B?MXRtcFdpMjNkK1BERjBiM0t2TDhGL1RnSlNqS28ySEJwbWY0U01PS3VpVlRt?=
 =?utf-8?B?aWw2WHUxWk1YblFGaU1SbUdmb09UWFNqd3lydktHTG1JQi9yQmNlR2RQMGxj?=
 =?utf-8?B?TVZTR0dBUWViMTdQNXBJbFhlSHNjR3Ivc0RlTjk4UjRGWGVNSUFFZ3BiMTRx?=
 =?utf-8?Q?or6YxXfLZm547ZCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mcAffDeGmeLfiOvu2Q87ZFQWpWvl2Y5KbOxNUzSYCgKRQTyK+Q/hGdfEG9ECcRxwwYtOnGwitWjIcEdfJ5VeGclkp4Y9nbDg9EIGhAEhN/BwwM+QNFOP+f8ZcLD4ghMvZKd8aCBAAl+hfBKErBqjMxy/ntmq5QpLNEMvkt0SA/vnQNu2YeIa+a0ArVMYzwmcJCWpEA8DHmD69Rgu0RRSziozzYFW68NfSna6oBBhT8RVWET3+CjaenIa/nEbxUYCfJdn6yS7LPTUAA1aWqZ4FNklTFy82et5H8on2gmko6add/gqJMUtHTKK6/LglzDirYi4hgKIH587t1XhKTSePw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5f21a-c67b-4af9-0801-08de880eaa2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 12:29:29.9067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJd84wTaTF6TVDm3aeRhpYKvrpDNtaoncave0w/aLAKvRXPWeSRTa4jihp4qtX0uYMkOKSK724+Xq5ZC1RhG1vfrVmu2Bc0TxQ7IdJgTXlwusFZjF4nFSHgHwJQzEQmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33664-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:email,candelatech.com:email,unwrap.rs:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8AC4E2E935A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29sZSBMZWF2aXR0IDxj
b2xlQHVud3JhcC5ycz4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxOCwgMjAyNiA0OjQ3
IFBNDQo+IFRvOiBncmVlYXJiQGNhbmRlbGF0ZWNoLmNvbQ0KPiBDYzogam9oYW5uZXNAc2lwc29s
dXRpb25zLm5ldDsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBLb3JlbmJsaXQsIE1p
cmlhbQ0KPiBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT47IENvbGUg
TGVhdml0dCA8Y29sZUB1bndyYXAucnM+DQo+IFN1YmplY3Q6IFtQQVRDSCAwLzFdIHdpZmk6IGl3
bHdpZmk6IG1sZDogZml4IFRTTyBzZWdtZW50YXRpb24gZXhwbG9zaW9uIGNhdXNpbmcNCj4gVUFG
DQo+IA0KPiBCZW4sDQo+IA0KPiBJJ3ZlIGJlZW4gZGlnZ2luZyBpbnRvIHRoZSB1c2UtYWZ0ZXIt
ZnJlZSBjcmFzaCB5b3UgcmVwb3J0ZWQgb24geW91cg0KPiBCRTIwMCBydW5uaW5nIHRoZSBNTEQg
ZHJpdmVyICh0Y3Bfc2hpZnRlZF9za2IgcmVmY291bnQgdW5kZXJmbG93LCBmb2xsb3dlZCBieQ0K
PiBOVUxMIGRlcmVmIGluIHRjcF9yYWNrX2RldGVjdF9sb3NzKS4gSSB0aGluayBJIGZvdW5kIHRo
ZSByb290IGNhdXNlIC0tIGl0J3MgYQ0KPiBtaXNzaW5nIGd1YXJkIGluIHRoZSBNTEQgVFNPIHNl
Z21lbnRhdGlvbiBwYXRoIHRoYXQgbGV0cyBudW1fc3ViZnJhbWVzPTANCj4gcmVhY2ggc2tiX2dz
b19zZWdtZW50KCksIHByb2R1Y2luZyB0aGUgMzJrKyBzZWdtZW50IGV4cGxvc2lvbiB5b3UncmUg
c2VlaW5nLg0KPiANCj4gSGVyZSdzIHRoZSBmdWxsIGNoYWluOg0KPiANCj4gMSkgbWxkL3RsYy5j
Ojc5MCAtLSB3aGVuIGZpcm13YXJlJ3MgVExDIG5vdGlmaWNhdGlvbiBkaXNhYmxlcyBBTVNEVSBm
b3INCj4gICAgYSBUSUQgKGJpdCBub3Qgc2V0IGluIGFtc2R1X2VuYWJsZWQpLCB0aGUgTUxEIGRy
aXZlciBzZXRzOg0KPiANCj4gICAgICBsaW5rX3N0YS0+YWdnLm1heF90aWRfYW1zZHVfbGVuW2ld
ID0gMTsNCj4gDQo+ICAgIFRoaXMgc2VudGluZWwgdmFsdWUgMSBtZWFucyAiQU1TRFUgZGlzYWJs
ZWQgb24gdGhpcyBUSUQiLg0KPiANCj4gMikgbWxkL3R4LmM6ODM2LTgzNyAtLSB0aGUgVFNPIHBh
dGggY2hlY2tzOg0KPiANCj4gICAgICBtYXhfdGlkX2Ftc2R1X2xlbiA9IHN0YS0+Y3VyLT5tYXhf
dGlkX2Ftc2R1X2xlblt0aWRdOw0KPiAgICAgIGlmICghbWF4X3RpZF9hbXNkdV9sZW4pICAgLy8g
PC0tIG9ubHkgY2F0Y2hlcyB6ZXJvLCBub3QgMQ0KPiAgICAgICAgICByZXR1cm4gaXdsX3R4X3Rz
b19zZWdtZW50KHNrYiwgMSwgLi4uKTsNCj4gDQo+ICAgIFZhbHVlIDEgcGFzc2VzIHRoaXMgY2hl
Y2suDQo+IA0KPiAzKSBtbGQvdHguYzo4NDcgLS0gdGhlIGRpdmlzaW9uIHByb2R1Y2VzIHplcm86
DQo+IA0KPiAgICAgIG51bV9zdWJmcmFtZXMgPSAoMSArIDIpIC8gKDE1MzQgKyAyKSA9IDANCj4g
DQo+ICAgIEFueSBtYXhfdGlkX2Ftc2R1X2xlbiBiZWxvdyB+MTUzNCAob25lIHN1YmZyYW1lKSBw
cm9kdWNlcyAwIGhlcmUuDQo+IA0KPiA0KSBpd2wtdXRpbHMuYzoyNyAtLSBnc29fc2l6ZSBpcyBz
ZXQgdG8gemVybzoNCj4gDQo+ICAgICAgc2tiX3NoaW5mbyhza2IpLT5nc29fc2l6ZSA9IG51bV9z
dWJmcmFtZXMgKiBtc3MgPSAwICogMTQ2MCA9IDANCj4gDQo+IDUpIGl3bC11dGlscy5jOjMwIC0t
IHNrYl9nc29fc2VnbWVudCgpIHdpdGggZ3NvX3NpemU9MCBjcmVhdGVzIDMyMDAxKw0KPiAgICB0
aW55IHNlZ21lbnRzLCB3aGljaCBpcyB0aGUgZXJyb3IgeW91J3JlIHNlZWluZzoNCj4gDQo+ICAg
ICAgInNrYnVmZjogRVJST1I6IEZvdW5kIG1vcmUgdGhhbiAzMjAwMCBwYWNrZXRzIGluIHNrYl9z
ZWdtZW50Ig0KPiAgICAgICJpd2wtbXZtLXR4LXRzby1zZWdtZW50LCBsaXN0IGdzby1zZWdtZW50
IGxpc3QgaXMgaHVnZTogMzIwMDEiDQo+IA0KPiA2KSBtbGQvdHguYzo5MTItOTM2IC0tIHRoZSBs
b29wIHF1ZXVlcyB+MTAyNCBvZiB0aG9zZSBzZWdtZW50cyB0byB0aGUNCj4gICAgVFggcmluZyBi
ZWZvcmUgaXQgZmlsbHMgdXAsIHRoZW4gcHVyZ2VzIHRoZSByZXN0LiBUaGlzIGNyZWF0ZXMgYQ0K
PiAgICBtYXNzaXZlIGJ1cnN0IG9mIHRpbnkgZnJhbWVzIHRoYXQgc3RyZXNzIHRoZSBCQSBjb21w
bGV0aW9uIHBhdGguDQo+IA0KPiBUaGUgTVZNIGRyaXZlciBpcyBpbW11bmUgYmVjYXVzZSBpdCBj
aGVja3MgbXZtc3RhLT5hbXNkdV9lbmFibGVkIChhDQo+IHNlcGFyYXRlIGJpdG1hcCkgYXQgdHgu
Yzo5MTIgYW5kIHR4LmM6OTM2IEJFRk9SRSBldmVyIHJlYWNoaW5nIHRoZQ0KPiBudW1fc3ViZnJh
bWVzIGNhbGN1bGF0aW9uLiBNTEQgaGFzIG5vIGVxdWl2YWxlbnQgLS0gaXQgcmVsaWVzIHNvbGVs
eSBvbg0KPiBtYXhfdGlkX2Ftc2R1X2xlbiwgYW5kIHRoZSBzZW50aW5lbCB2YWx1ZSAxIHNsaXBz
IHRocm91Z2guDQo+IA0KPiBUaGlzIGV4cGxhaW5zIGFsbCB5b3VyIG9ic2VydmF0aW9uczoNCj4g
LSA2LjE4IHJlZ3Jlc3Npb246IEJFMjAwIG1vdmVkIGZyb20gTVZNIChoYXMgZ3VhcmQpIHRvIE1M
RCAobm8gZ3VhcmQpDQo+IC0gQVAtc3BlY2lmaWM6IHRoZSBwcm9ibGVtIEFQIGNhdXNlcyBmaXJt
d2FyZSB0byBkaXNhYmxlIEFNU0RVIGZvciB0aGUNCj4gICBhY3RpdmUgVElEIChvdGhlciBBUHMg
ZW5hYmxlIGl0LCBzbyBtYXhfdGlkX2Ftc2R1X2xlbiBnZXRzIGEgcHJvcGVyDQo+ICAgdmFsdWUg
ZnJvbSBpd2xfbWxkX2dldF9hbXNkdV9zaXplX29mX3RpZCgpKQ0KPiAtIDI4bWluIGdhcCBiZXR3
ZWVuIFRTTyBleHBsb3Npb24gYW5kIFVBRjogdGhlIH4xMDI0IG1pY3JvLWZyYW1lIGJ1cnN0DQo+
ICAgY3JlYXRlcyBtYXNzaXZlIGFsbG9jL2ZyZWUgY2h1cm4gaW4gdGhlIHNrYiBzbGFiLCB3aGlj
aCBjYW4gY29ycnVwdA0KPiAgIFRDUCByZXRyYW5zbWl0IHF1ZXVlIGVudHJpZXMgYWxsb2NhdGVk
IGZyb20gdGhlIHNhbWUgY2FjaGUNCj4gLSBObyBmaXJtd2FyZSBlcnJvcjogZmlybXdhcmUgaXMg
ZmluZSwgdGhlIGJ1ZyBpcyBwdXJlbHkgaW4gTUxEJ3MgVFNPDQo+ICAgcGFyYW1ldGVyIGNhbGN1
bGF0aW9uDQo+IA0KPiBUaGUgZml4IChpbiBwYXRjaCAxLzEpIGFkZHMgYSBndWFyZCBhZnRlciB0
aGUgbnVtX3N1YmZyYW1lcyBjYWxjdWxhdGlvbiAtLSBpZiBpdCdzDQo+IHplcm8sIGZhbGwgYmFj
ayB0byBzaW5nbGUtc3ViZnJhbWUgVFNPIChudW1fc3ViZnJhbWVzPTEpLCB3aGljaCBjb3JyZWN0
bHkgc2V0cw0KPiBnc29fc2l6ZT1tc3MuIFRoaXMgbWF0Y2hlcyB3aGF0IE1WTSBlZmZlY3RpdmVs
eSBkb2VzIHZpYSBpdHMgYW1zZHVfZW5hYmxlZA0KPiBjaGVja3MuDQo+IA0KPiBDb3VsZCB5b3Ug
dGVzdCB0aGlzIGFnYWluc3QgdGhlIHByb2JsZW0gQVA/IFR3byB0aGluZ3MgdGhhdCB3b3VsZCBo
ZWxwIGNvbmZpcm0NCj4gdGhlIHRoZW9yeToNCj4gDQo+IDEpIEJlZm9yZSBhcHBseWluZyB0aGUg
Zml4LCBhZGQgdGhpcyBkZWJ1ZyBwcmludCB0byBzZWUgdGhlIGFjdHVhbA0KPiAgICBtYXhfdGlk
X2Ftc2R1X2xlbiB2YWx1ZSB3aXRoIHRoZSBwcm9ibGVtIEFQOg0KPiANCj4gICAgICAvLyBJbiBp
d2xfbWxkX3R4X3Rzb19zZWdtZW50KCksIGFmdGVyIGxpbmUgODQ3DQo+ICAgICAgaWYgKCFudW1f
c3ViZnJhbWVzKQ0KPiAgICAgICAgICBwcl93YXJuX29uY2UoIml3bG1sZDogbnVtX3N1YmZyYW1l
cz0wLCBtYXhfdGlkX2Ftc2R1X2xlbj0ldSAiDQo+ICAgICAgICAgICAgICAgICAgICAgICAic3Vi
Zl9sZW49JXUgbXNzPSV1XG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgbWF4X3RpZF9hbXNk
dV9sZW4sIHN1YmZfbGVuLCBtc3MpOw0KPiANCj4gMikgQWZ0ZXIgYXBwbHlpbmcgdGhlIGZpeCwg
cnVuIGFnYWluc3QgdGhlIHByb2JsZW0gQVAgZm9yIDErIGRheSBhbmQNCj4gICAgY2hlY2sgaWYg
Ym90aCB0aGUgVFNPIGV4cGxvc2lvbiBBTkQgdGhlIFVBRiBhcmUgZ29uZS4NCj4gDQo+IEkgYWxz
byBub3RpY2VkIGEgZmV3IHNlY29uZGFyeSBkZWZlbnNlLWluLWRlcHRoIHJlZ3Jlc3Npb25zIGlu
IE1MRCdzIFRYDQo+IGNvbXBsZXRpb24gcGF0aCB2cyBNVk06DQo+IA0KPiAtIE1MRCdzIGl3bF9t
bGRfdHhfcmVjbGFpbV90eHEoKSBoYXMgbm8gcGVyLVRJRCByZWNsYWltIHRyYWNraW5nDQo+ICAg
KE1WTSBoYXMgdGlkX2RhdGEtPm5leHRfcmVjbGFpbWVkIGFuZCB2YWxpZGF0ZXMgdGlkX2RhdGEt
PnR4cV9pZCkNCj4gLSBUaGUgdHJhbnNwb3J0LWxldmVsIHJlY2xhaW1fbG9jayBwcmV2ZW50cyBk
aXJlY3QgZG91YmxlLWZyZWUsIGJ1dA0KPiAgIE1MRCBpcyBtaXNzaW5nIE1WTSdzIGV4dHJhIHNh
ZmV0eSBjaGVja3MNCj4gDQo+IFRoZXNlIGFyZSBwcm9iYWJseSBub3QgZGlyZWN0bHkgY2F1c2lu
ZyB5b3VyIGNyYXNoLCBidXQgd29ydGggbm90aW5nLg0KPiANCj4gQ29sZSBMZWF2aXR0ICgxKToN
Cj4gICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGZpeCBUU08gc2VnbWVudGF0aW9uIGV4cGxvc2lvbiB3
aGVuIEFNU0RVIGlzDQo+ICAgICBkaXNhYmxlZA0KPiANCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbWxkL3R4LmMgfCAxMSArKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKykNCj4gDQo+IC0tDQo+IDIuNTIuMA0KDQpUaGFuayB5b3UgZm9y
IHRoZSBjbGVhciBhbmFseXNpcyENCg0KTWlyaQ0KDQoNCg==

