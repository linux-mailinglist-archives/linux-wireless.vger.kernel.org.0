Return-Path: <linux-wireless+bounces-11864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506D95D41F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 19:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB19328424E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2427188A1A;
	Fri, 23 Aug 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="neZsiqKp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AE18C908
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433381; cv=fail; b=em6/SecjeTnGsE/fkkY79rri1NkH4bQJEjyDnVTdUP1+GGHy09uErdTfpuunJHgPp003z/Gcqz+Mc90rqJLnWSN3jF6w7/HuTiLAklPvD9SGHyL4IxFXMSOvKE7wL1KUMSGa+IDeUeGOuz7Do3oAZhC2XYgZTIDjXiacgokjzog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433381; c=relaxed/simple;
	bh=ZqJ3qVS9GuwtLW42rzpj19OD0LEpSDYM/EtGRkr6vvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQZqR8lGl34OHm1bX3y9C1sXxA0rhv88n0jETuVVpBtrGA5AZtXivwobmz5azuaTkrDdin+ZEzWFA9SNF/duAQ87pegc5VPq3+pRWOvlgbKcv4ue0jnSmTOjFjvlYanafnlnpoQcdQe9AP759xXbI7w4QixJfkGuh/KpJo/sE64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=neZsiqKp; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDTh438B6kCeJQAsHRZ4+31N7XAC14j6Pzpnjzzz6PZ0SKrpHux/LR65NVyLWwh2mCoaZ9YyEKsvnS5LKrvaeQnxhiqelIfev6dsgLjE/x9EZHlW0ot/sweJheV5XAVJhrvAztdH68LszFEtaUvtrRf+ho6uFsPIBf1cF6Qdk/+jtrEVmpxCp96XiGRvtgiXLpZIZS9X2XleAsM+xWPSxvpw3yZO0RlDzC1AsZ8J7Crqz/CLi8gT++2grWHFWN0z8y8olDMqrB7PAuv0ke1AupWZOza7XBPzl7HLs5Au5u+DjjE0+RpgcwfjRgqou28/t5Mie0VtyEJabgraa0Ay3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqJ3qVS9GuwtLW42rzpj19OD0LEpSDYM/EtGRkr6vvU=;
 b=AKvEePCSpV8EZhfFsBqXXT+OOucuWbtZhBYlSRK95yqpx41b1eTz/uVQEVccudpKMJEwvJ731Pzwy0+7RckUPxLc9oIf3fBUEgiMAtXrfsmqV/lrJFobz0fchHbJkfmc9CL7Ra6/qxOMcz4ztW+Z+hXjyvagHkRUnj0x5W0UoJM8CgoQBIcl78yAxWT3MwFxHFdnW7K7XWGgTiqWq0OLygdNxTNmiDhpCEIhoE9eY+s4MAKPIE1EHBPsA2+B7JW2vHVtRQOAGxVM6A5/lxk9rXJKrf4bZy/M3tM+gXwMHFUtQxqS49r8zx+B5MfqhogDkwMV8zU9xuClVDGBn1ZKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqJ3qVS9GuwtLW42rzpj19OD0LEpSDYM/EtGRkr6vvU=;
 b=neZsiqKp/K8JHlAPB6EI8cg7M0g7VUPzTKQ0pluQ09aUCWGvWCgq24OeCmAUyNZFhZ0VUot4S1tilVqV/+mR954iEpk/KBdTn19mW+vE2jsurNWi1AQv0Cubwu6WGu6IijxQX74WUAwb0eGjjnNSQzzxj13dAuTAI4n6GfTVal5qE0GMeJ2ajGToKX85ihLjEPazYbyRh4s93f6h1y/+UjfU3X4zDFFKDE3kCfKG4Ef59b6XVl2R3uG0VIJEBoa0TCbJy+Qs+AD68nYwN/aHPNeyXPuhuMTeneEcixreP60d2OK/ccx3VLiqi85lq+7Y7rN9lpE1i9W+eDUMUzhFBA==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 17:16:16 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%4]) with mapi id 15.20.7897.020; Fri, 23 Aug 2024
 17:16:16 +0000
From: <Ajay.Kathat@microchip.com>
To: <marex@denx.de>, <linux-wireless@vger.kernel.org>
CC: <alexis.lothore@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<kvalo@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: Do not operate uninitialized hardware
 during suspend/resume
Thread-Topic: [PATCH] wifi: wilc1000: Do not operate uninitialized hardware
 during suspend/resume
Thread-Index: AQHa8/kaF0pdTcX5m0KSM0r3Wz8vXLI1GF+A
Date: Fri, 23 Aug 2024 17:16:16 +0000
Message-ID: <05ada8d8-d5b5-4b9b-88dd-bdbd9aea65ce@microchip.com>
References: <20240821183639.163187-1-marex@denx.de>
In-Reply-To: <20240821183639.163187-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CY8PR11MB6939:EE_
x-ms-office365-filtering-correlation-id: 7384442e-086a-4b0d-206b-08dcc3974c25
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkRmTm44ejM2bzNkbnZOd1Z2WndTV0VrV3NNZEtlbVNxWVNiSWtzY051NHg4?=
 =?utf-8?B?U1diRVlmc2lYTUdMK1pkNE1lc1Z3c0Y3aUJnOWNYNGMramhNT1R3MUZ6V2x6?=
 =?utf-8?B?UXVoam80dG5Zb2xkc3dzaVNZT21JdG1EOVZLNkwvVWl4VW5Ed1AraTd3aHEx?=
 =?utf-8?B?dmV0U2d5aEZUZnR4NFdNR2grNE92Tlh0VjJOa1hET0tiNTFUWnpEWmV2VlhS?=
 =?utf-8?B?U245dzJMVVJRZ2FEWVZ4QUt2eUVaU3dQaVZwQk9yU3JIVzc2Qkd2TyttN2xy?=
 =?utf-8?B?Z3RJbmFGeXlvRENMemZFM1YxTnhlWGMrbTZnWkxqWWgzQzBZbjM3RE4zSytk?=
 =?utf-8?B?STJsR2U2L1ZGVjR0WENCamlQY1J1aExZUzJwUi9QNElnSFo2QmY2SHpFeVpW?=
 =?utf-8?B?N1BpcFh5U2NibmVaWlZxdElDR1VTUVBUQmQvWmsvWGNyUE9nYktTSEI5TGJC?=
 =?utf-8?B?TElnWmI3ZWhIc1RQYlY2Z1BuUjlrRTBualBKNG4vN0gydEg5K05HcTlPRFRJ?=
 =?utf-8?B?TVRjaCsvTUI1c1RjU20zL0ppUkkvVjhOamhTdnQ4UWU5ZFZ6bnEwVW9vdWIr?=
 =?utf-8?B?RlRnWXlQbExndUxvUFNqMnRDelc4TlhyV1N1YlB2a3FzN00vSkRnUjdEb3BH?=
 =?utf-8?B?LzFmK2JqWmd3ZzgrV2g3dVVmK2VpUEZGZlpVSEZpbGp0ODdSaXRRZnRyWjlx?=
 =?utf-8?B?T1hGWFE5Z3l3a0ExTGNSRWNPTnZYL0JjN1NXR01HZWFnUFJZdnh1NmVGSEl0?=
 =?utf-8?B?ZExQQXBuNnVpR1ltUjcvS1pTSmlvRm9IaW8vbHhoTGNFaDFGdWVrQmpVZDZw?=
 =?utf-8?B?ZElNVHAvUktoejdFUThRSjY5SnNxRmpKUUtTLzhSSFdHSDkyYmRBOGEwVEg1?=
 =?utf-8?B?REg5OEhvcVlwMDUwdXNCTmdpOWw0dE1ONXNtbDJGN2tBbzUrUFFWai9ZaGEr?=
 =?utf-8?B?TlJrS2VUb0o4ZFRDOFlvOFFpQllTcHJpRFFJRE01eis3dUFzaW9DSzZ2ZG0y?=
 =?utf-8?B?KzdsSXdGVXVxNzhucHg3aFE3MFMzSzJKNXdpYVhITVd4Zmx1K3ZJcU9XUFpo?=
 =?utf-8?B?b2djeUVRamtTa0FpZldOZ0NpTlhTdE51VFgvUWdaQmU1MmM3NEpXODRaN0NC?=
 =?utf-8?B?d0VlZG9uc2lmZFBtL0owUmRocTNZcEE4a3QzdytIOGFFdHRkTGw2aHJXQmNs?=
 =?utf-8?B?N1licjhnZGxMb3d4WDJOQXp0bUx0UURtbDBneUpFNkdhaWFOdDBTZ2w0S252?=
 =?utf-8?B?SU5FSTRFU1d3cnk2Vi9Pcys2Rm5XRlNQVU5yUDFuN01COHZycmpoNWUwdWdx?=
 =?utf-8?B?dURJS3NObWtkTEhiYU83cUdWRzRFSWlRaFZxbkVNenIzdTJpUVRXS25XQWFs?=
 =?utf-8?B?Y2tqMnRVY2RJTDlBVExqSXlwcVVDTnZ2R0dGSUhpZDJxcGtUSTZNN1F0ZGRx?=
 =?utf-8?B?R2NqTVk1MDV2RlNFWHJ6VDJSdHZVZklLWEU0aS92UklkelVWYnNZa21paFI3?=
 =?utf-8?B?dWZ6Szh4cyt6bEJkVUxBbVR1aFp6Um02L0tpOFc1OTZMSVZMTVA3anRQbyt0?=
 =?utf-8?B?TGprQUY2MTJqeE1ZUkFYYjhuQmIxL1QzcHNmZ01JTmVVbGN6RU8rN2dJbGxs?=
 =?utf-8?B?bG5QQTNqMGkyRXdVZ0E1OFVpK3MxMGxjYUk4YytqQWpGaWxqSGFGdmFHNVZt?=
 =?utf-8?B?YTYwaml4dmtWUUpsQlArd04wU1k5TG01dG1ER2JuQytXd2JDclNOeWxjV1dV?=
 =?utf-8?B?Y2QvMEhEZEV3cWxyR3hCOTJTaUs4SWJIQnJIbmpkRGRGbUw1OC95WmVHbGRl?=
 =?utf-8?B?Z2VTUUkvWXpLVVNqVjZGZTY2T0E0emhLZFB5dHNsN2UyaHRsSHNqNm5WMlZ2?=
 =?utf-8?B?ZFdyQ2JueHhxSkFSNlczSHYrUUNoZDlsT0NTTm1yRnhUeWc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N05DNDQvK3Q3YVYvWmRuQkZDWmZDSTJMUmx0dllpUFdFaWM1UzlPMDFIMHBn?=
 =?utf-8?B?bm1aOEtQRXBCaUk4TkVlT3p1STBvYlR5aDd2S0JKVFc2aWxmK1llaWthdk8z?=
 =?utf-8?B?MjhwaTFlTHUzZWxPWW13U0xES1pkN2hHUkMwTzIzdXpQNjRwQThldXg4dkM5?=
 =?utf-8?B?S01kV0hkaDdqcEVzbUdUZm9xb2VqR3JiMzQ4cXc0TUJXYWpGTXhLYVF0SzJ1?=
 =?utf-8?B?S2xYZStaeW9ybzRIN2hka0VKc3hDWDRoNk8vN2ZzcTlzSUpCaitIcGViNVJx?=
 =?utf-8?B?Q3ZKZjFkdTZDSUFPa3FCZis1YnFIbzZUNjV2VjlrMVFlbTZRaE91SEZFbWgz?=
 =?utf-8?B?Tytld29NUmFubGtYc0drUWp3ajZ2S01TQWNoWHpsWDI3SzJWSjlyVldyTGkx?=
 =?utf-8?B?elNUdDlkbytEbEdvem9jUnNRejZVWTRmYnl1RHdPRktTcytBYXNpdjFacklm?=
 =?utf-8?B?MTJNdWhYMjdldVNzdXF3SkNzeTZtMXB5UnpDSjhBdGJpWlEvQmtsRWRQbUtk?=
 =?utf-8?B?eXNpOHV1SWpYcjZjYWFldEV4NzdXNlBqbHR5dytkUzdZUE90SDBNWThwb1dY?=
 =?utf-8?B?WGRFaG13Q2d3WEVhN1ZvdXJyRWtEekRZVllqQnN5amFpcGlOSkFJa0xOdHFw?=
 =?utf-8?B?QVloNW1tZGE2Z0NraVJ6M2tQZUhDQ0JmRHBxZ3d1Q2R5eUQ0SSt1VHJXelVs?=
 =?utf-8?B?ZTRzUm5MOWV0U0FYYUJUaGlZY2x0cUZ6bmRlbFhJQkRBMm1DVVJkaUFRTWVK?=
 =?utf-8?B?OEs5eXlDREp6OUFSY3FXNDJGd2lvRmVGZmEvakVsaVY5RTVjVityRS8vL09I?=
 =?utf-8?B?dnJkWGtEY1VrTmc3M3hSVlZFckl0b003T1RNUkhLRGovQitUelkrZ01rZGNo?=
 =?utf-8?B?WmJyK1dBYVFYVVlaRnhqNUtYZ1k0TSs1ZFloOVRKQlp1Rjk5MVpWeVhHK2VD?=
 =?utf-8?B?WnNkOWY3NGxOdWlyc202QWtGREcyMVh5elRsMHJFTVVyOGFCbTVBMmN6WU9H?=
 =?utf-8?B?MFg0WVp2NlJKMFJ5TzBKcXpjdFJvRXduVlJIWjlWS0VLVEc4QmMrdTdwZHgy?=
 =?utf-8?B?K3kzU0Q2UjQxNWlYOFRHNllwNDVqelZlWFlUWDFjaXpmdDgzaGlnL1FVWmZr?=
 =?utf-8?B?Yng5L08rUENVTmxjdk41aDFTdGR6VlFUcWlJZ0ZvME81RlZYU3hoTmw1TVk0?=
 =?utf-8?B?bE5rZHJoam9jYjJabmZWaWMwdkRaNTlsblhNemFkaDRXS0dTNFJJaFRCMXRV?=
 =?utf-8?B?ZDB1TklYZHJIbEJsK1ZjTnNuUGxmYUYzZld1ZE1lM3VmZmZybkgxZnRxVldN?=
 =?utf-8?B?R0QrdW5kZDg2MUNycENqeG9abGF5aXZnZ0tpYzBiU1BHZ1NYWFJQekV4REpi?=
 =?utf-8?B?cHhHS29rdTNZRXhDVEpYZFltaUNyNEtLbzBpMHZ6a0RBcDl3SkFPVU1WS3c3?=
 =?utf-8?B?RmNYRU9TcWxLdzg1b1pabHRUZUxZNTZ2ZnVBbk5YSlNiNXhudFJGUGQ0ZnNw?=
 =?utf-8?B?RjNkNlUyTndiTmQxMHdIYjM1RlV6dEJ2OVdNNFFYczhkY2Yra1p1ci9SUllK?=
 =?utf-8?B?TTFwTTFza0dyclhvS3laWVlZUGgwQ0V2UVVBVHZJeVVLejFvak4yaFNreGhK?=
 =?utf-8?B?NWFtMmFzaHJxVG9HQnJtSVF2NmVIV2tjb2hrYzlFQXlhTU5ndmd6V1dvL0x1?=
 =?utf-8?B?VkFJY1ZYMlpMYkFNQWVoTCtIQUdQdUc5aE16MldZTnZsNVNtMEFDc2U5SGZw?=
 =?utf-8?B?YUloUmhiS0Q4R0pSYlNIZm9vYitVMkRCWUpSbGtGTVZPbnNROUlDRkVIZGxT?=
 =?utf-8?B?dUE3dEhQS3I1QjJ4ekJVU1pvb0V2bTF1ZUdPeWVkdjVlOXFMeVBWUFF1NTA0?=
 =?utf-8?B?T1ZoVjE0cCtmU2JNWElvdWlwZ1hvWEVGUWswT0duTUxxTGdPcnVjY0dMcnRY?=
 =?utf-8?B?bFNnVk53bERHdVpSTnpCLzF4TytkYnNweVlqVGlXemtjZDgyN1N2V3Fub0JN?=
 =?utf-8?B?WWFnbHdZbjI4WTFBdStnektwNGtKdllIMndFWlVGYTdrVzl5Qm81MGprdXk4?=
 =?utf-8?B?QVVzYi83eEZRMXlwRU54RkdVTkkxZWdLTXpFYk9QN0JzK2Z2KzN3VlpDc0J3?=
 =?utf-8?Q?gVBo/iXbaR32oR2fDQkjMzsY7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B85439AE2F8BC94F94DFD768D4A89FB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7384442e-086a-4b0d-206b-08dcc3974c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 17:16:16.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dG9YTuIhvbb6/sqfWCXPp9urkrRhn7w5yGjfxvSoYOxJwvbSzbY8ILABfklcShxzBHu5O/v83MKsZOdnwWTg/7wQhwi1Yx00bnUo9H5YDSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939

SGkgTWFyZWssDQoNCk9uIDgvMjEvMjQgMTE6MzYsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEluIGNhc2UgdGhlIGhhcmR3YXJl
IGlzIG5vdCBpbml0aWFsaXplZCwgZG8gbm90IG9wZXJhdGUgaXQgZHVyaW5nDQo+IHN1c3BlbmQv
cmVzdW1lIGN5Y2xlLCB0aGUgaGFyZHdhcmUgaXMgYWxyZWFkeSBvZmYgc28gdGhlcmUgaXMgbm8N
Cj4gcmVhc29uIHRvIGFjY2VzcyBpdC4NCj4gDQo+IEluIGZhY3QsIHdpbGNfc2Rpb19lbmFibGVf
aW50ZXJydXB0KCkgaW4gdGhlIHJlc3VtZSBjYWxsYmFjayBkb2VzDQo+IGludGVyZmVyZSB3aXRo
IHRoZSBzYW1lIGNhbGwgd2hlbiBpbml0aWFsaXppbmcgdGhlIGhhcmR3YXJlIGFmdGVyDQo+IHJl
c3VtZSBhbmQgbWFrZXMgc3VjaCBpbml0aWFsaXphdGlvbiBhZnRlciByZXN1bWUgZmFpbC4gRml4
IHRoaXMNCj4gYnkgbm90IG9wZXJhdGluZyB1bmluaXRpYWxpemVkIGhhcmR3YXJlIGR1cmluZyBz
dXNwZW5kL3Jlc3VtZS4NCg0KSXMgdGhpcyBiZWhhdmlvciBvYnNlcnZlZCB0aGVuIHBvd2VyLXNh
dmUgaXMgZW5hYmxlZCB3aGVuIGludGVyZmFjZSBpcyBub3QgdXAuDQpJZGVhbGx5IHJlZ2lzdGVy
cyByZWFkL3dyaXRlIGNvbW1hbmRzIHNob3VsZCBwYXNzIGFzIHNvb24gdGhlIHdpbGMgbW9kdWxl
IGlzDQp1cC4gQnV0IGFueXdheSwgaXQgaXMgZ29vZCBoYXZlIHRoaXMgY2hlY2sgdG8gYXZvaWQg
dGhlc2UgY29tbWFuZHMuIGlmDQpwb3NzaWJsZSwgcGxlYXNlIGFkZCB0aGUgc2ltaWxhciBjaGVj
ayBmb3Igd2lsY19zcGlfc3VzcGVuZC9yZXN1bWUoKSB0byBoYXZlDQpzaW1pbGFyIGJlaGF2aW9y
Lg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4g
LS0tDQo+IENjOiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPiBDYzog
QWxleGlzIExvdGhvcsOpIDxhbGV4aXMubG90aG9yZUBib290bGluLmNvbT4NCj4gQ2M6IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+IENjOiBLYWxsZSBWYWxvIDxr
dmFsb0BrZXJuZWwub3JnPg0KPiBDYzogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IENj
OiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc2Rpby5jIHwgNyArKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NkaW8uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMC9zZGlvLmMNCj4gaW5kZXggMDA0M2Y3YTBmZGY5Ny4uNzk5OWFl
Yjc2OTAxZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL3NkaW8uYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2ls
YzEwMDAvc2Rpby5jDQo+IEBAIC05NzcsNiArOTc3LDkgQEAgc3RhdGljIGludCB3aWxjX3NkaW9f
c3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IA0KPiAgICAgICAgIGRldl9pbmZvKGRldiwg
InNkaW8gc3VzcGVuZFxuIik7DQo+IA0KPiArICAgICAgIGlmICghd2lsYy0+aW5pdGlhbGl6ZWQp
DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAgICAgIGlmICghSVNfRVJS
KHdpbGMtPnJ0Y19jbGspKQ0KPiAgICAgICAgICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KHdpbGMtPnJ0Y19jbGspOw0KPiANCj4gQEAgLTk5OSw2ICsxMDAyLDEwIEBAIHN0YXRpYyBpbnQg
d2lsY19zZGlvX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgICAgICAgc3RydWN0IHdp
bGMgKndpbGMgPSBzZGlvX2dldF9kcnZkYXRhKGZ1bmMpOw0KPiANCj4gICAgICAgICBkZXZfaW5m
byhkZXYsICJzZGlvIHJlc3VtZVxuIik7DQo+ICsNCj4gKyAgICAgICBpZiAoIXdpbGMtPmluaXRp
YWxpemVkKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gICAgICAgICB3aWxj
X3NkaW9faW5pdCh3aWxjLCB0cnVlKTsNCj4gICAgICAgICB3aWxjX3NkaW9fZW5hYmxlX2ludGVy
cnVwdCh3aWxjKTsNCj4gDQo+IC0tDQo+IDIuNDMuMA0KPiANCg0K

