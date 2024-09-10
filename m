Return-Path: <linux-wireless+bounces-12721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB69972774
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA9FB232A8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC317C211;
	Tue, 10 Sep 2024 03:05:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E56170A2B;
	Tue, 10 Sep 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937547; cv=fail; b=Gp14JbdAf+LuCwiAqb7Yd6sO0jtXtpYlD7Ep9Oi4lRPPUmCv70usBZH1ZPJk8zzVDUiXf1kFFEfAUEqXTTzoUYItMQXbYl4SAhQ80LujJ/3me5bf7JqkfVcTxEYZF7GPKPvVmeTmBk2bgJySbrEvVfblXgCgotisJDVIj9mstHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937547; c=relaxed/simple;
	bh=m4jywguzwzc9q75AMLYOPix+C0ZE5a5MGA4IZ7EIp5c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qDV5HV3qaHd8VRK4mBLrJ5EKgVD8VhcdX0eKvNwiI8jvzjJWt0iap9cvDHWM2WEPMr52O6LjIsjy1hTySU0YTRG8PTkG6t4OkK5gSVyK7+ote0XPDAEyCyA5MBGOWoO1ovUdhy1cZKrpF1TxoRiUS0uZ8ON4wkvUz0ZF0DvUYms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7bHjCssArMXzS031WwPXt3bVjo2GQgBviE5bb3Y9Tbm1jzTGWYTUZHdOgWmaxqRyzADmJlOK2xZ2tind3szhPAyE1gR1v5vqaXIvKI0Ck4BhqwmjBNxzA3J5r4nMTBAy+SKH0j/shJqh4+0I7RqDzgnN3M0SDubiVkUhWbE0yTxPYESBaF7bYQjK78hTVdHzL0wlUPN2o3EHaml+axZdg84xGp+ZDqZBS3mDzhfTOMrbom1fLr9qADlDHSPP3+JN+Z70OqWfKjdnVcN0ROr+XmYDkq8bQYNscjoZoduyMjfGrrARl0KI2CDJAc1t+4b1UOUZAOuw0GNAHVCyAC7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/E0WGgE6Ehzy8g7GiG6jEMXz/oYkQ2gd4cyn/tSzSs=;
 b=F5MleNkzSztdUlATgeEdzVARh25izUiNHo000JQtWT8I9j+upp6OAtzr9nKqJf6PV/NdXuoNXDYp6u0fJyNJDaGynGuxfv6IO02xuawd+XWKv0+aKIYUUSxKTFW3sMlK1ysDA+kAVDe4tYzkCjRW7Lr2vF4FFyP5wO+2LsGw9HKw3Ne7cQCF4U04N7+TNFrjVOwPBDdV/6tMHuX5JMYprkeG6svlad7vamjFfkAM2Icz/Kwb3ONR+4AevQ6SkpJnabxZ/ebfV/szc9N0J0U3Ie74JjO+7czguWbvXeGLsE+WUFWBBMc/Uc0DSVVLesNORzkVWE+g5DORINBLRDZ2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB8442.apcprd03.prod.outlook.com (2603:1096:101:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:05:39 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 03:05:39 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Tue, 10 Sep 2024 11:04:12 +0800
Subject: [PATCH v14 2/4] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-wireless-mainline-v14-2-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
In-Reply-To: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 nick@khadas.com, Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725937530; l=1192;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=m4jywguzwzc9q75AMLYOPix+C0ZE5a5MGA4IZ7EIp5c=;
 b=SGPu7TWBt5M3JRtTaRdT+RbbOrcEPX4I5WRryJxvw+I+uh7tmVavdWXdJ7FNXTAkjJWr8EpOJ
 82vnJv1bvdtCTYl25lhV6EU2wHM8wnIzLvikM0CUI4yBBaUviJaj5Ym
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf8d827-ac9a-4181-c6aa-08dcd1457314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjlKVmJtMTJORUxzWTFodHhQbXhkcVRwWVRlN1NYdzJFQnJjaXRTenBhOXht?=
 =?utf-8?B?OEQ4aC8xWENLek80NkZlTkRkeHpFZjBZR2VjU2JWSVdZYmVzTWhlSUtjT1cv?=
 =?utf-8?B?ZUZwRVNHcFg4SkFLYkdtYmVOd2xkUVRTMzU1Q2NUYTF2OGxwMkR2QmhJVzEr?=
 =?utf-8?B?WHJSUlQvRFdpR1dZZjdMdmUxZUUrYlZqYjlCdy9IT3NVT3VrRjNJQk5mNVJu?=
 =?utf-8?B?ckg1VHNUV1hJVDEwVVpnRWdjYVlrZFJ6NTgvUVdFajJxSjByOU4zYnpkSjhO?=
 =?utf-8?B?dUFpOWN1VUo2a3BXNWMvMnE4M1lZVDZJVyt6dVhiUWVITGx4aGxRUTUzQXBl?=
 =?utf-8?B?b2lIN3YzMnhYVElzREtZT1A2ZHhjWndJMHRURlJ3L0FyN3RNcHZaZEg4L2di?=
 =?utf-8?B?ek1UbWZsNEZRakhUR3JkT3djM0Irc3R6aFhZdlFmSGg5UWFVaXl4emd4eXVh?=
 =?utf-8?B?T0NSV2NKTVNvRDAwQk9FOU1kaGIyMGZ3M2M1T3cyWTZPOFhLWUxwT0wrZWJ0?=
 =?utf-8?B?WXpXQ1RaWTVEaVdFUUJpS2QzeC9JdkMzVWRWdENMVW1iaGhmdElJeVNrVnUz?=
 =?utf-8?B?QTl0dmJkbnc5NGVSdGtxN2lUUytCOE9aOEZGNHVMVld6SlpCdmVvdTNoL094?=
 =?utf-8?B?alZ0aVg2MStGQWY5bVZwQWR3U1NJMFRVdlZMNTk3VzZpWDFPeldYVGNTNS9M?=
 =?utf-8?B?cDdYVFA1V3pxV3RuZktxdUFIaWMybituZmZWYm0rOHIrYVVWdk9PK3Y5NnZK?=
 =?utf-8?B?aUVmRlIxOStqem11bUVleU40VDZQS25VandFTWxrbXdjOGI2bVBxa2ZrQTc0?=
 =?utf-8?B?NG5aL2VGejl2ZTMvUENXT21hZXFQZS9tb2phUlVkQXEvT0QvTGZ0KzBSZ3Fx?=
 =?utf-8?B?U2tkV0FVVC9mRys3Z1ordEJjYXFpWEhjY3JxRTFCZzVVdldYd2F2UmpwVktD?=
 =?utf-8?B?aEgxYjU0a2Erd0kxZ0c3a0ZkbzhaV0x0QmtENTZrdHVqYXVIdGJXTzB4bDhm?=
 =?utf-8?B?REg2V1lPTFF4VDVmNmdzMld2dUVaVEdQZkZpdG1kWGJORkhVYlhuWXJpeFJF?=
 =?utf-8?B?N1ppUmQ1M0lZVjBYUUJRQXM0SGlLbTd0OGV4eDcyTFpiUitrU3FqY0d0c3Q2?=
 =?utf-8?B?YWZURnRhc241bFZzUFN6Z0dtNHo4ZlUyS1VoSGpmL2owUC81MGppVFFHbHdh?=
 =?utf-8?B?LzliZHRIWWEvRnRzSEZwQmtVRmR6dTdwWUJpVUVQUC9XenVUczRmazgxQ25i?=
 =?utf-8?B?YnZ4NmFnaURyRmNkSytZd0paakM3RC9pMjdIaGlVSEVFczdnVHB1NjRVUEM0?=
 =?utf-8?B?aFZ5TEFCWEM1MUVUV1FJN2R2QmwzUmRhbGNQZFV4cGJGbW1OOW5rbm9tOEMx?=
 =?utf-8?B?T05jTjNBS2d4VDlEdXovK3RBcGtnYWxHcnkyL0NNSm91SFZYYmVWTU5aZlQ3?=
 =?utf-8?B?d1FhblBlaXdzcVBUdE9hYVlmR3dTSnpLQm1ORHRoTE02WDFhZmxKdW5qclFI?=
 =?utf-8?B?TGYzVjc0NEJRMmZBVDJ6K0ZsS2J5ZkFxRG55UWYza2FSVHFKN01zV1dZcFNM?=
 =?utf-8?B?eU12ODlGb3IvbVhSdXpKZTN6NzkxdW1xUUJMMDFFTEpSNko5emwvNmFvWVpP?=
 =?utf-8?B?ckZNeHpRSG5SWitLeHhHVHdWdEg5MURjQ2x0ZGhSb1hyKzJnZkY2NFJneE1D?=
 =?utf-8?B?VzZXRmVQdy9tSlIvbWZSV2d6VnJaelpZeXhmbnJUVVEvc2FFNmQrWXBsWWJB?=
 =?utf-8?B?bDVXd0ZvSjVVb0tZRDZLODhuQzJtcWwzSDlUMFpXYmtZQjFBWEdReUZVcGZi?=
 =?utf-8?B?NDJVaGtsUFRBS1FPVUQyOGtHbEVKWTJnYURCSWZyQ2luSjVVRXZ5K0ZMUGpL?=
 =?utf-8?B?dS9ua0h2QjUxQjdyZkYydVJXUG1DbURoL3hsN2pJQi96T2M4SlMza0xmRGpw?=
 =?utf-8?Q?mP+cGjLe77M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHQxbHJkTUppNWRjb1Q5Nkl5em5lcGNsTDdBVVFBbmpJcmhNdDVYbGF4Nlg1?=
 =?utf-8?B?WmpteWxHdDBhYnlkSE1ncldUSFd4N0tRaXVQWlhtU2xLVFJaREhCY3NKUGRB?=
 =?utf-8?B?NEhTb0JxdGNUY3lZMTRmT1ZYemppdHZ6c1hVNGxOR0g0eGo2eWk3VXpxeXA3?=
 =?utf-8?B?VVJUZGhhZXlUNlg3YXdKTUNBVFluWjdNYWo4SWJmdWpjbU1GVkV6enVZVjJT?=
 =?utf-8?B?SjEzeEJnK29GUHg2RDRmdWJ4RlNsVCttU3RpVXkzVHRqQWt2blFOa01iWXFL?=
 =?utf-8?B?V2ZKYVJJT0M2ak0wVnYyekFqSVN2emZVNFdQdGFENFZTSFlMMnh0bms3ZDZo?=
 =?utf-8?B?U24yY01TWThPRURpVm9jNXdxK0hZK2EyeXJVZDNSQUszRHpwZG5kNy85M3hN?=
 =?utf-8?B?bktnTFhqMUZlK01CY04zMEcwT2pmNUNMLzNqQ0hJTFJNclpna2FVNm1kcDRO?=
 =?utf-8?B?V0NCampieUxwclo5SkJnejEvamtMVmlJY2k5ZStXS2pqOG11YkZGMlFxV3Fa?=
 =?utf-8?B?N3NYa2VmZzhTZllrdVVXdHh2VWFqYVhCQXZEZDgwbXlOdXk3UVptTWdTdCtw?=
 =?utf-8?B?VUJBMFpxLytjMXhLQ09jVWVvcGFGVGswdmFoTitlOUVaWVBkMHpGODdkajB6?=
 =?utf-8?B?TjhDTndLTFFud3RXZ2ZMVmhTT0laRG15bmswVVNhTU5BK3pYZ3JrOXhWVk1j?=
 =?utf-8?B?TWtyU2k1V2Ura1k1aFhvNW5RRGhDVC9sV201NzFEUUhRemJ6Z1BKV1k5RDRI?=
 =?utf-8?B?cFlhUDFVdWJjdkkwUS9qU2hPZ0g4bWpZUXZUS2ovRTVRODVoNHI1Z0JZVUNU?=
 =?utf-8?B?MUVGRDFnRjNrcWdGOGVYV2NTcnJBazhyVEQyODNrL1ZsMlAzK1loTGhHNytU?=
 =?utf-8?B?dzAzMFN5S1FZYSt1alY5VXBucHNmZGs3ZXpBWEQ0NHRZM08xcW5Tby9jL3l6?=
 =?utf-8?B?WDV5WXEvM1l1bWpjUjF2TnR5bGpQSzRLSWZxWE95bEllRSt3cXlwSlBWWURy?=
 =?utf-8?B?RzYxc09JbDN5NjlJT2VONEd3NThCa1gvUXVZc2pUVnUvS1djbXVpck1PaG1D?=
 =?utf-8?B?bzEyVU9lYk4rK211Vm8xOTdTM1ByYVNHdXdTTUIwWmJqYU5Dbm5Rd2V4Z3Fq?=
 =?utf-8?B?azVhbFBJWTIxRXVkbEhRRWNVUjRBd0g5aDBDQ3VwWlViSEdtTEFuVmg4QmFD?=
 =?utf-8?B?cVh3ZFdSSkVCWHFoR3d6Qm1HTTBpamN6M2xwVDZZU0FTRHhmaThUSG9TeFFa?=
 =?utf-8?B?bUVMZ0JFa1FoNk5raE9XY0YxZ1hKd1AvM2tST2lxa0ZPL0Z2WGpUZURMYVor?=
 =?utf-8?B?RDZucm84d0MycEtOSTlneW1TV1NOZ2QxdnhJOTFMQzc1SjdKNUVJYVpFbDVY?=
 =?utf-8?B?ckhzQ3NoMlY4YTVKQlNsWmRMMDR3ZFFYMHVSWHc5RmJ2eXZFVTA1SkZaNlEv?=
 =?utf-8?B?VmkyeW5pTk0wOHNnRVNHdjUyWHAxUWlQeUJvajVwcjl4eUJOSG4rUjliUk9y?=
 =?utf-8?B?UGthUHFjb1dWZytOODYrUGtUYkJaMEZqOU91UUtEeWZGSzRoL1FNeklGZlps?=
 =?utf-8?B?UDB0L0NLK1NNNUdycVN3V3IvUk1YamFMeWNOVEQwOVAvM1VMQ1g4NXRZZVpv?=
 =?utf-8?B?NzNuZlovcmRHblNQSmJyMUhWVHBzYzdLd0ZzcldvbDkybUJHL3I3eDU3R3pk?=
 =?utf-8?B?TEd2VTVTbTdlZUQrMDNndDJta2thQ0t2UnhuWjB5WHNnN01vOXlTUzJncWtV?=
 =?utf-8?B?SFU2VExDWEdzZ3pCOHNZelF6TjF5TXhhOG9rb0tPajZzOVNHY2F6bXQ2M0M4?=
 =?utf-8?B?RkZxTk55d2RiSkpUTmtMMlgzaTEyVnFKYk9LT3dpTXdJSjlDbzJJbTZkTVMr?=
 =?utf-8?B?ejdBTS9PS3llQVRYVUw4ZFlNY05tMHpuTDBSenc1TkdWSmNOZS93QnIyQlRz?=
 =?utf-8?B?Tk9xMStjWHh0YmEvZlUwMk11UnVNTE1ScEJEVWVoY01BMVIxZkZSQlc0aHlE?=
 =?utf-8?B?SEpTUUlyV3RZMDB0NjI2UGVhQU9WU3RETnlmSjhkOHM2YUhHMkpuMmtlcW1C?=
 =?utf-8?B?MEQvY05vS3Njem1vVmwwZzNzUVcxaHpTSERMRUJ6MEpkL29WWElZQ3dlR1J2?=
 =?utf-8?Q?14rsmdzQo+PIYti80Z1H7yKk/?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf8d827-ac9a-4181-c6aa-08dcd1457314
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:05:39.4602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sEg6QZ2CIzPc4fs06uGSR0qfLmATMypz6/ZFBP9csgR+XOE1cUimaXxHc9E0+cmDWuw+e3zDq2kL2Pnl7gphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8442

Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
external low power clock input. In DTS the clock as an optional choice in
the absence of an internal clock.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..a3607d55ef367 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: External Low Power Clock input (32.768KHz)
+
+  clock-names:
+    items:
+      - const: lpo
+
 required:
   - compatible
   - reg

-- 
2.34.1


