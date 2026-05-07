Return-Path: <linux-wireless+bounces-36077-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKWOOnOx/GnlSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36077-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:36:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 652ED4EB2CA
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD6E30309BB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572D28A3FA;
	Thu,  7 May 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOysVIDc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3C39098C
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167972; cv=fail; b=b0igIqQB7nsw0Xr0g4QrLMm/z4KfvG/iwRtv/0wb6JFPju+yNuM5rgVVKTXI+GQGfUqCw/d6QTn+QSzsrGVlF0dbVckLYHkSLXvqD2OE43MdU6ct4xXnWMrZ6ugvCJ8Xk3Bdsvpa2lXuA7Jwbh5XpJy27L4H0wq5h9hsuzzWQCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167972; c=relaxed/simple;
	bh=fhmvolvlIbQ1w7lcup3D1eTncs3DTqWC5APdxEVaaXo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j83QV9mutojDr+VtA+O/gXaXGT4iFsy+ZwuOYrMCh+id3NdiQqB9UntQjs0vZHtndZr+uZW9++vhDl8in0iZnQjPuDIRDLuu6Llf80XydyjhljHlNqtwDqjc/3GveuYbsb3j9fFoDKjxofcbPfzAVO4k5YxNU8JzUKbdEAyzqkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOysVIDc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778167971; x=1809703971;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=fhmvolvlIbQ1w7lcup3D1eTncs3DTqWC5APdxEVaaXo=;
  b=dOysVIDckVRyGd2eHigLlzlBqs4efxkaHJoLXUzifBN2NCwHNo14N+ZH
   cAV8JEi/GE7ZU2bfLh81T0mkeEhQCgHv8R1ivESrDr1WAA60urMQMHHnT
   8OmBtyLCsfAYcy9dngr4rfZkUgNbTAFm8rZPAvKRao4GvW3QnWbq+32A2
   /YY58lPLfXFW+DPXfS7ZqtuxzBsURnCu7aeGRR1Y09oU9thbKa4znUFKa
   6FnENGrMH6PP4eP8H6jIGuTNBy8n7MbXJeBEJyoyDBRDWoxtKHEuYmFIz
   hdPC9G/8q/zPhl3I+25J0Lx71QZ4BPebK6FPkHDcyH8IL08NePZk064KF
   w==;
X-CSE-ConnectionGUID: xL0pMVtOR1CXfU1NAHgfQg==
X-CSE-MsgGUID: JhW+eO/AQzODndsj/TIOlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78972037"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="78972037"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 08:32:50 -0700
X-CSE-ConnectionGUID: evK63N7uS8W1z2SY3jpCKA==
X-CSE-MsgGUID: vHLIZnvERRqiwkyEESbgHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="235498554"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 08:32:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 08:32:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 08:32:47 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 08:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcHTbgAz0xHPw0XI0h6mWGPu/VUS+OgJljWa8GTPh0xBKysVdARg3ApopxNAtc5tBG562gQPPlg171kBPBNH05f6YI4RyJMgutYOhsoxCYipWDZfmI7ZNE8y/bDvk/T27ofADXofnwZpYlPsT1mFAnkEiR3fBe0YprSk4c3iYCM+nl3hmEjq+8Y8RVZy06y8UmWQ7DWwItV9pQKf/7Xp9hLCRogZRlq6g1WxyMFtSY0f3qjO3vJuXtF3G3rqWc86GlDEjzCgkaX9Fh+wDPGo9ce2Xk8hj/c1Cv0linhqSTl89FquOQBC9g1OREuV4sh5jj3jkuYh3f96FUN+QkYJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhmvolvlIbQ1w7lcup3D1eTncs3DTqWC5APdxEVaaXo=;
 b=QoroY2Mx5wlfQ2W9Y+ipASvZ6vqRbW87TKDZ73AXULJY3W8gE6ftEW5PQRpu/l/a5ZQ0YbovMWLuX/gh6ReFpcnNfzRfRqZAv/4IMkNKYe2X0+2xgNzWdI6Ap3q5dm2HMybu5WngSepCk+5kv2gTioEa6G7k9gPuq6o4gYmaiEsxMefOr/82xz7X/gqTmtAvASkEizD+ijJR2YZnbUCKpUW6ikoUKsE5isnIFG3cA/K8mj6/DvRBZldwgly9y2Pn1DZ35+7/2Gst6tr5VE7IXDkYs2IdUVUggSwD2cf5NIeZ57dVkYcW7QXrsPz0eSCSVI3QKjuesm0VXqD9xxnysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 15:32:39 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 15:32:39 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: wifi: iwlwifi: fixes - 2026-05-07
Thread-Topic: pull-request: wifi: iwlwifi: fixes - 2026-05-07
Thread-Index: AdzeNpyA8y+5fGBLSOuayZ0VlrvJOw==
Date: Thu, 7 May 2026 15:32:39 +0000
Message-ID: <DS0PR11MB7880644A829A023AE49B6FE2A33C2@DS0PR11MB7880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: 99825591-ec35-4bd3-3b04-08deac4ddf62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: C5Y8l2SxXE5qmpLyiyB6hZIxTTA2V55jRNpjFacxKuyjwLaW7/Hiqj7tkoJPql8PHq4N8FJQbVKa/r/VDdFqtwF3KuLbvMleSVnGXS7JSeNx7FoGrohES9BSzIMwbDCFu22XWQ2+lew1Vw3pr4sUVrMNJr3s2jITHG97PjEWJwn0KxDAySC4isQNMyv7l2Be1TCBcyh36vNQA/NGM8LlnJHeFVz3nK+SY0CoHdszCeJa4uR9AyqUbLPqx1oXGecVywCgvhtW5/YHJiLiIkFYSQtgun/9pBgxRlJPoQV+HBqc7d0T2plpugiB8+Z7Zxm0/Wii2kTBhfjrHutrFVVqLxMfudzPEASzFLWH/XbpYOUE27GPc/Xqqo2j1rAXefe7/FOxjorWXyzqTJZXQ+0DI1ED07gvybjgusBx/CLEWqjb8u6UqPzqJPivzczK/ay4XflZS82ykU6KGia0mEF4xePZ0ifGNCFayjD/TT/MPiiGRwuUIeM+P+NFL2QbYyOtx68BjmaYpeXZKmDeJvmQKNkYv9yPi76IYAKQOp2mbn1M0KkDBQ5/iCy3oMteKTjdpx9ISXmQU0fWAmvcDYj3hqJmMFZ8liOWujgTjJqWXrpZr7TiLMQzxiVO+44IliZmP7R9zzpCPhZFL6Go0vt3kxZ25EwYFcA7YxKw2N65ZkcIiR9+f+qyAkZ6MpkEdUfzugyHr//qDeoUl5SKC6QtRIjqHZskwagY4dxNrYBeGksx4/YSWRNvLcQK2BNURfkL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE1MM2Fod0hFaTY0bUh1NVlzaHVWUHdGTCtYM3BOdUE2Z3pFazUzcUhxZXpX?=
 =?utf-8?B?T0FSUTBMT1ZDM0hCbUpibFNMajV6OThWaTNIUmJpR0d3enVQSmUyNWRGdkVR?=
 =?utf-8?B?cDExclVvZjFIc0VScGZ6bWl3Wi9OdnAwQVZjRUxHTEdmZ3cxR2g4L3MvbVNL?=
 =?utf-8?B?RlBqNE9NVzVjOVZFaUhpRVR0US9ERnllZTNBRExMeWlVWkdrcmxtTVg2eWFV?=
 =?utf-8?B?Y0xNcHc2Y2QvTWVidkZINXpNN3NJOEZHY0ZhY3VhanYyaU5UbDVpNFlCNE5H?=
 =?utf-8?B?L1AvL2VxUFF5UFUybDNUK3N1SGM5ZzRnK1pncE94ZDlwaTBGQmp2KzYxRzhX?=
 =?utf-8?B?M1NueXZrcEVmL1JBL0RqY0VXUlBVZHZNUUc0TE9maTN3V1lSWmZSeXE0eGE1?=
 =?utf-8?B?WFBqSjlPVUNWSzJaczBpWDZjSFdCSkhzQ2JGQ3FmZ0t3TUxFcCtpSEI2ZENU?=
 =?utf-8?B?aTczdGp3VzFaSlZtaUUyWnc0Rk4vaHA2UUgvUmdvS3YwMjBaVFcrenh2RXdY?=
 =?utf-8?B?ZGw1cXUzWm1IL1VXMjNqWEdoM1FXanBsNDRpSXBaOXBtUG5QTVl4SXNnOU4v?=
 =?utf-8?B?SEk4TktBRUhZTUI5R0w4c3JqKzdNRDdXNTlNNlhIK3dndkJBRXdHSXJtNzRZ?=
 =?utf-8?B?WUZDZEk0QkxLdUJFRWpiVVlsYzdTSjRFKzdndVlVeW4yeGtKZHh6NDBZYmRQ?=
 =?utf-8?B?aGN3TGlTVW5BYi9WcVdINkIveEk1UHdadytocnEzU3duSTE2YVlIN1ExdmxG?=
 =?utf-8?B?RFFiWjEwNUI0SnVsQjhiaGpBUXJ6R2hsU2hlMVBTdlg1bFB0MUNWV0E1SEpn?=
 =?utf-8?B?V3VqbkRvU0prVFdNeUlOUnlRNEVkTEF5TWY0UG1aN282ZFpxYm1aR1lIVFFP?=
 =?utf-8?B?VzJjR3VwcVpsQThUMkpDRk5HYUtCN1AzS3Q3Tjdob1lMQ3EybWh1NzRXcnND?=
 =?utf-8?B?WUtvOGl3L0tuc0lkRG5ZcHJtNGgwRndxOUR4VVJEVlQwbnBhZ04wdVZzRi9S?=
 =?utf-8?B?S1BXWURsMEYvVkVJSjRyQ0xXdW02T2NJWjZDRkVhZm9MWUdNRW8xdzJ6YTJr?=
 =?utf-8?B?ZlVSVXVpWUhHdENmdmd6T2ZCT0Y0SzJaZDc5SFEreTJVV1VFTnBPdEVDK0M3?=
 =?utf-8?B?dkxCZE52YWpZWEhxZDBuOTJENmdtWDY4MlFicU45RHlFc1k1WldqK2NXRnB0?=
 =?utf-8?B?K2d4bXR3VncrdGU1VVo5N0gvWTNLckNpRk40TkRvRGdVQzhXZWxmanRrR0N6?=
 =?utf-8?B?Qk8wSFlDRlhZaS9reTlCNkE1bkNTN20yaUhxL2NMaXFiV1R4a0N5NSsrUmV3?=
 =?utf-8?B?WmVYcDE4NjFEVm5oUzVOSFVWdjFkUFpEY2Q5bTIvZHVqb3E5ZnJxaHFpTFdk?=
 =?utf-8?B?ZE4yeUFEajN2WGJkR0xlS0Rlbldydm51UHBKT0MxUjlRdGdJZEFEU1hCcDB6?=
 =?utf-8?B?dkRrdko5SGFXeXVnWG5SMWZMVjM4L0IrVWJuVUo3YVJXZUZKT1dtbS9TU2JR?=
 =?utf-8?B?TlRHRjcvNGlTYjdLTkgzYlFhMkpCYXRuSWtVYlZKNFdjN1g0dER3aklyUFRq?=
 =?utf-8?B?Sk5JaFk5cHB3MDJUYlY3RHpqZk5Kd0lSOFF1b1lJVURBUGtaVnM4QU9HZ0d1?=
 =?utf-8?B?d1JJOFhWUDF3WFhyNllqTEJpYUNqSDRXdlR4MlRmVVVWcmN2Q1JLQ0xUbThr?=
 =?utf-8?B?WXFvRWI4THBZdytqUTdKTGNQc0d2dmU3WjBDck52TVRyZ1VVRDlXNHhtWmRP?=
 =?utf-8?B?QlRUNFVMWXRYTndPclkxOC9aSFJrWExGSTZhQjlkeHgvZ1ZOakFGYURnYUdV?=
 =?utf-8?B?a1VvcElLOHo4MmVTenlIRVl4dUkwS3Ewb1NhNzNScnZpVDRGQ04xUStPcFhq?=
 =?utf-8?B?LzJJVU1na1NTY241cnRQcm55R254U2xZNDNlVGFqQ3FRZVp0NTlzb0cyUmgx?=
 =?utf-8?B?Lzh6Qm9QRjdDMkNIcS9EOWRiMXIyL3MwUnpzVWVjclMzOW1PaFUrbmtYRGtj?=
 =?utf-8?B?aTNpbjlyMWRyTW9Fa2UrNC8zVm1qdjNCU3JHSUVXbVNadmdTS0NTLzNJR2Yz?=
 =?utf-8?B?LzhqNkxXSytJMENra0NUVnJka0lmYlNrcEhidncxZzZxcm9qY2o2d2ZtdzdJ?=
 =?utf-8?B?U1ZKcUlJY3dXWEJlVFpwZkcxMGNtcUVJL0xJclRRdU1DcSt6OXNESTZ1MHpk?=
 =?utf-8?B?VHNwOVZldUthWkZ3YnlSOUJPSytEbkdpa1Juc00zUWYwMzZ3aTlTQUlhSHdi?=
 =?utf-8?B?S0RsbmpjdEVVYXZIRCtiaVpVYzQ2ZmFBMWI1cWhkWnQzR3VWM3BoeHQ5b09r?=
 =?utf-8?B?aUgxc2l6UXczeVpOck12THcrYTBDZUovQzRBZW54T0FqTm5ySlNZUlVoQjlt?=
 =?utf-8?Q?RQxGAeCH407EnBmV1UwXch01Uy7NZPOE5VXGh4Idp4mN8?=
x-ms-exchange-antispam-messagedata-1: zcw8BDKbxdy3vlisThReuldyfnEMERlXIa8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BLZr8+IAd0aSH1tzhN1vVSJokS28BmzccjiTaQ4BkwXLZIl3lhOEQM/HujHhXzabATeRUP5RNxDiH3Hgwdk1QtrfQJSNxbw0i3gHxxisHW/t9S1CZ6mGUDEDfIgFBKvRH1ViqIcChPIa6647Mb5T5HrzW7vOPYjU7B6Grg0h+bun8wkTpc+unsoLGnB4zfUYrxxxEcMFL+244EGEARaGoUYl/DHvh5X4OJvxavfgHpbvvHcLcf2sN5RPHX/7xQmloy/D/DB13hKAKDt0q0hXpjQwYLf88xG21s/F88+gu0kr70q9x0eI0bdPZEUAHrQgQKCwXNENK3ZPiDLr7QHaXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99825591-ec35-4bd3-3b04-08deac4ddf62
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 15:32:39.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Asd6897wyJLUPKADfnhVaQg2mx4sSBfbEmh23Ob7A2PhUXO6HrV26ilU3EOLDEgXR98aXewybJ4oQUD3M8h/y5x4qYqobn9D4gYB+I4SSDcf8nRYeUe+3Tb2AZ2JbGe4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 652ED4EB2CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-36077-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBmYTQ4OWE3N2UzMjY3ZTA1ZGY5NWRi
OTZiYTk4ZTE0MWVjMDdjYmQ5Og0KDQogIHdpZmk6IGNmZzgwMjExOiBFeHBsaWNpdGx5IGluY2x1
ZGUgPGxpbnV4L2V4cG9ydC5oPiBpbiBtaWNoYWVsLW1pYy5jICgyMDI2LTA0LTA5IDA4OjU0OjQz
ICswMjAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3
bHdpZmktbmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1maXhlcy0yMDI2LTA1LTA3DQoNCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA1OTgwMGJlNDhkYTQxOTMzZTMzMTY2ZmExMzAwNzMxMjMx
YmNiYzc1Og0KDQogIHdpZmk6IGl3bHdpZmk6IG1sZDogZml4IFRTTyBzZWdtZW50YXRpb24gZXhw
bG9zaW9uIHdoZW4gQU1TRFUgaXMgZGlzYWJsZWQgKDIwMjYtMDUtMDcgMTg6MjY6MDAgKzAzMDAp
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCml3bHdpZmkgZml4ZXMsIDIwMjUtMDUtMDcNCg0KLSBmaXggVFNPIHNlZ21l
bnRhdGlvbiBleHBsb3Npb24gd2hlbiBBTVNEVSBpcyBkaXNhYmxlZA0KLSBmaXggcmFjZSBjb25k
aXRpb25zIGluIFBUUCByZW1vdmFsDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNvbGUgTGVhdml0dCAoMSk6DQogICAg
ICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGZpeCBUU08gc2VnbWVudGF0aW9uIGV4cGxvc2lvbiB3aGVu
IEFNU0RVIGlzIGRpc2FibGVkDQoNCkp1bmppZSBDYW8gKDIpOg0KICAgICAgd2lmaTogaXdsd2lm
aTogbWxkOiBmaXggcmFjZSBjb25kaXRpb24gaW4gUFRQIHJlbW92YWwNCiAgICAgIHdpZmk6IGl3
bHdpZmk6IG12bTogZml4IHJhY2UgY29uZGl0aW9uIGluIFBUUCByZW1vdmFsDQoNCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9wdHAuYyB8IDIgKy0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC90eC5jICB8IDUgKysrKy0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYyB8IDIgKy0NCiAzIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg==

