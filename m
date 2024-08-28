Return-Path: <linux-wireless+bounces-12122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4D996218A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C5B20CEB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1EB15DBB6;
	Wed, 28 Aug 2024 07:41:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2115C14F;
	Wed, 28 Aug 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830884; cv=fail; b=p5ZlSFAVepWm1ZP6+oUH8XWQl2tEAVnsIz+ShkWbxIGHMNPRYXzPqB9JV5NWgOfxpoWbvRucH2st4vcSD/9vzP/VAeWlq0rfIWVe7x78zDFGdg8b7y6vcwu9OV3xLd+vYctdzySufWFAqifijI82oJEZA6f882JK7L87Jt1tj9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830884; c=relaxed/simple;
	bh=JsL/vIHDMaqpLADA0x3lqz9mV0Y31bnYSpXIcUwpmVE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AIomYMCEjiuhYDuGNIHBnttI0ptqNXUvWzhGUbg2d1zCkI+mO3Xad7PlSX4DR/rF71GC8XYo+IkRbOV+EfCYSLG7m49Xo6UzObhYR5CbCNpYtLeq8km7aEpiWBwh8zsg4fG4LGzd70ydkwAWHKv/+T+vDSPcm2bRKrEZYR8h+Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW/3S3mhWvTUqOWiKg/3JoWDPKMFaeMgqL8aJHvzTCVtIlJYSG4XMBoPAFGMa6vRuIUQBj8WAQ0T+/Den7EOBQZRsFaRm22ciVP2FzKhkRptumdO2Qg0UwRRczt+UcEl/cvc1FGRJlcUY1xEvAr12TyhwUjxKhnuIakxaA+JFVN8ozwCil8VIKXvmzJmBA8+jY5x5Np/tm/o8Zx6VUytpuZWsxzOEPbHwLOaq4HSLi+Ffyxcciykk6+CybmRspiGQjLxoWUTBaHJaJ9hgCqDN6Q3OALTAaTCxmLIS/MNfNxec4dQqz4qXSsygyQujDLQ09QclTnkD6XnzUcga9Rm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BGfZQm1BRaHSCcvnV1BQzz9wLf/fFARUUlFVnsNLzg=;
 b=q5esNEy5JIjZbq+iT7/av/5f3USkJUaOJi4qfEEnhHW4hfddiZPa4X/jgr3VXxMqyIxc5uorPebF3cK9B31xbtzRTwwlMbcDUWxKfN4tNIIWkZfIw8OkIhV24b5PfBQ84Gfdu50adPZhwncT2ot6bbEFnaZZfkDM6w1RQm34G1RTUXBVWUYxblEe6oH+l120AbBKaMDmLjoaU1j1WQqBo/ZBb9RbrXlDSOMJ5JsNNR7xV0NYIaffsZsQyKFikwmsL4SnOK6WA+eent0bgA+gnZ7Y6wSM38DU/mbokhl7hcOHyqn9B2/jVN28VBJDrLcIC6xNVtMg4o7tm+Bj9s1OHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:41:16 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:41:16 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 15:40:50 +0800
Subject: [PATCH v12 3/5] dt-bindings: net: wireless: brcm4329-fmac: change
 properties enum structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v12-3-9064ac7acf1d@wesion.com>
References: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
In-Reply-To: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724830868; l=1920;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=JsL/vIHDMaqpLADA0x3lqz9mV0Y31bnYSpXIcUwpmVE=;
 b=Wz+aw2ORpR/g+WNUpRYP7YontiquM9hUbAOOToJzMnR2y6t9DGNiU4XWCyUGs2/pqpEcTJI1M
 6rra8GLxj3TBGMOi38LE6bBt5F1gfe6Z0NJ9kv7sp71y5V52r99+35M
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: e9415c26-c14e-4a6d-6520-08dcc734ccca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUJVUjZkcEMxT1dIcTZwMHRiN0RyS04xaHBaQ056eFNwc3ptNG5WK3lGNUlG?=
 =?utf-8?B?NGVYakZNN3pqZmFyNG1YcldIaXdwOVZNWXFWR2dWaGExZ1l1QjFSMzdKODhs?=
 =?utf-8?B?MUVha0c1RU5RdWFhbFNHcDg1Q3V4Sy9Qa0JlTXBweG1vNlFpZmVrdzhRc2FE?=
 =?utf-8?B?MEdPTnFTaytNTjM0dEh6UWd4YVlVZ3BUN0oxaTNjV3RkbDNMYW9QQ2FRbE1U?=
 =?utf-8?B?SWFFRkRMWWVLQXRmcWtmeFBxY1NVZ1d3TGZrbGZQT1J1c1Jlakx4OFNVTVFH?=
 =?utf-8?B?TUQ4T0JIQWJ6R1gzVkx5Sm81ZVlXS0tFMU4vVVRZTU5uUlZzZUszSGZLSjJO?=
 =?utf-8?B?Z3d5aXRuaERRK1lDcnJNM0h5TUNpSzFIL2g2RnB4YS9XY3g0aXg3dythK2h1?=
 =?utf-8?B?RmpaQ2JOK1JJRlhTajA4SEdBNTFQU2tPUWxjdzJZR2t6dXhxKzdvdlJiSzA2?=
 =?utf-8?B?TDFPMURTeGNlKzlRUTlFZWZObzZxVkpSUGRoSy83eGU2Y1NPZjhrL281SDBy?=
 =?utf-8?B?T1hzblVwV2JLUVJhdTExb3RVT21PMi9wZGVXd095QmlHT1lGL0dSM2srNkNN?=
 =?utf-8?B?cmdvYUNsMENtMzEyRFNSTGE5RGhkWUdURDdIMkZWeUlqNnJWdXl1WEQ4Zkxj?=
 =?utf-8?B?YlIvWHBDbUljOEdob01kdkkyQ0RTMVkxS0JHSHZlRE12NEEzMWttdjEwM3NG?=
 =?utf-8?B?RzdnRytCOGx3NURHRkhzKzhTclR1TmZkSjBwemFJM0NPL0tYbEQwZ05Iellh?=
 =?utf-8?B?UEZUUFVuNlNrcjRkb0l0TVB3cTBpZ1dlZkNteDlQTWd6L2F5UCtLWnRlWk1T?=
 =?utf-8?B?eGJiMGx1ek0xQXE1bW51U3pzNk1YWCttemxRY1lKSVlZVStITEFaYnlOc3FK?=
 =?utf-8?B?Rno0UldtMGJzcWNyeUJyWDNHVE10cldxejJPU0tpQmJhVjgxTnA1TVN6czhu?=
 =?utf-8?B?L0FwMDJGZ1dmcDEvZk1VTFVJVkNSamdZbm5SQzc4c0lucEt5YWNObXJSWHFl?=
 =?utf-8?B?cUtWcCtKQTBXT29OeEZoTzFkL3NkelpvN2hkL1kvdjlCMzFUaEJsQWdwZUV0?=
 =?utf-8?B?eThCdGRMcVFMQWJYbXN1UTBEUHViQmRuNktrcExKM2RGQ2R2Q2FPMjM3eHlJ?=
 =?utf-8?B?QUtDUGVNb1ZTalR3VEhVMFRaYW14OHFTb0c1eTI0L0dwYVVRWUJTZnl6NU10?=
 =?utf-8?B?Z1RsQlJDSHhlTWg3b0Y1UW5MemowWXdDeHJnSVNHR1hVWEtNeTVBajc5OS9n?=
 =?utf-8?B?WmpWTGVvbThXRXVhL3pONVArdFMvdmFDOGdkUzlLQkpXN2V0UzVXV25zOVpW?=
 =?utf-8?B?WWNaRWtEWElmOUhNbGJkOGUreFJqSGU5QnM2SVp6c1lIZUw5NXp0a2w4bjlT?=
 =?utf-8?B?OGMzekNVbXUvd1JZbWJyYy85ak5VdXpLTnZlaVJVRFZOam11d1NoaHVaUXpF?=
 =?utf-8?B?Y0o4Q1RvOVpmV1JyTDEraXMrb2hlanc5TjhWODJwenhpZHJ5M3UxRzhnVnYr?=
 =?utf-8?B?dFM3dlU2d05wYlI5RCtZeXNybzJIeXVKYXROeFI1MzNsSFlkbWQ4YU45YSs1?=
 =?utf-8?B?RmFra244OHMyUWNXWjYyZCtGY2psQzFoMVNlNkNHcU94SEp4QytqSlBTSnY3?=
 =?utf-8?B?RllZaFNHb0RsUVJ6QXgwSkxndkp2aWd1M1A5N1pWVnBnd3Y5QVVEWmx3WE1X?=
 =?utf-8?B?UnVUdi96eEtOVTJ4VTM1RUpPR2ovejlGQURhREU0S25WakZQZ3M0VmlQVEY1?=
 =?utf-8?B?Q1lKNklMSXBvUUd0TnlDK3FlWGZBSmxWT3lFaFRxNW5IY0kvMjlSVUxHYVFM?=
 =?utf-8?B?QjBoakhWWko1cmpEMisyOG45b2kvaVhOQzFpR1g3SzRxYS9mRGR2TndSTXRa?=
 =?utf-8?B?S2JwbEtOUDFwbEM4K2FRMDNLOXhxb3ZjUFlWK1pQUGhPbHZhU1YwdThHRjNW?=
 =?utf-8?Q?lmLg0R/fCj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3pWVG1paDNDL3dLZnZ6VFRkd1RBcXVjRzRZemJTQ3RVTVhqVmNaRzVTVTk0?=
 =?utf-8?B?eXNPTXBXUnZ5VEY5TUx6R09mcXRtc090cTQwSHlrYmZEN3Nvc1VwNmRlVzNx?=
 =?utf-8?B?NXhVaWJGalFlaTUrTFpIbTVjZTBTbFgwcktrMzk2UTE2UFRFOXY4V3dzV3lS?=
 =?utf-8?B?SnRpeXBsRXBlcXd2MFBuOUhxZEVEbTF1cHgvTDBTOU5oeENRc3VIam94UkxM?=
 =?utf-8?B?SEhPQ1dTNEk4K2xtT3FvcnVWR2tsYTV3TUF0TXY3c3VhSE8rVWwxY0dBb2pi?=
 =?utf-8?B?d3FDaDFIcUxUeXBvMUVlQW92cUU5NnltOGJDM2UvUGpVbTJyUmV0NUlybVg5?=
 =?utf-8?B?MmFDWVRaS2Z0V0g2TGdQL3hoNEFPaytiTDdPODlxcFJlTzlnVWZuSHlWKy8y?=
 =?utf-8?B?b1NxdHgzclVoUWkzeklGaS9nYWhDTm50Rkk4MFNuVDNqdlVyZFRaUjNSRE94?=
 =?utf-8?B?ZWpXYnMrbzF1OE94WHI4WGJUdDZQWEhtZlozeXNXSlF0a05udGg5VG1RRWlG?=
 =?utf-8?B?U0swRW1Nem1ZQXdvL25WeUg4RXJrWEdpUkVtNERsVmdaclRFRGVKWkF5WGRP?=
 =?utf-8?B?bWIxcjZmcmJGWXlQRXpXTElSYXpveFNyQXdTYUZramtnUGxaZUlnMk14L21m?=
 =?utf-8?B?K213VkJRVlhYSTN5NGlQTEZ3dXhpcGlha3d2VXJTZWhyay9RbEdtOUltVWZE?=
 =?utf-8?B?OVlZNldsTGJUdzVDSlFnbFdvQ3I1Y0lvL1lzTy9tRWM2Vm1MOVBGY1ZBcFZK?=
 =?utf-8?B?S0loMGtiUkhEQlVHNVIzSHEzSHdxVGVCekl6UnJaQUpBRUhSeFNNM0dhTzJZ?=
 =?utf-8?B?U1g3Uy8yNjZuRStwNDFiMzhqV2diVHVPVXByU29UQlBWYWJUcjBEMTVYSFc2?=
 =?utf-8?B?VDNUZnhPRmhjUURDaHdUWXc3dDJId3dCdUtadm9PL1RuYm5zemxqc1FNRHJ4?=
 =?utf-8?B?cW0xem9VdUxzQ2lKR1o1ZERCY25HVHZkV002cEQ0c2RQUmhpTnZvMFNBTEZn?=
 =?utf-8?B?dklqNEo5QmRqajBveHRXT0JNb0ZTdjZOOCt5blo2ZTZQRUN3TmkwdlZPRmQr?=
 =?utf-8?B?dkFuay9DWExaR1RVYUYxQUU2MUxTd0RTaWIyY25renJKTlpCOUxpRDhyWnZa?=
 =?utf-8?B?L01vK0FqdGJ4RVUzVUFVQ3RHcEtZd0FjdEFGUlduTlAyeEJzcTc3ZENHY2NF?=
 =?utf-8?B?VWQ4Vld4cXlVd3YrZ1dJcXBwQXFDa1VycTJVOEU2RnE2ajBmNFJVbExxT00r?=
 =?utf-8?B?MnVhZm5VQjFLSFl1QjRnYlpmNmZ6NXNhdzVnWHZYREJQaG1qSTV0RTlHZnY4?=
 =?utf-8?B?VCt2RXFSd2kwWldMWkF5Sm0xd0xJL2lYT0lYYytWUlNReW9Ea29CdnlIajF1?=
 =?utf-8?B?elVyV3plZHlBQllWWWd5cWZFd3FSL09BSGhpUkU0SEtvQWQzNVdhTG84emJL?=
 =?utf-8?B?a0xPbUtKVjdQWFlJY3hGNVhrMFRXRDI5cDV3b1dPbWhFL3dhYnpwV3Fkd0pw?=
 =?utf-8?B?cHVaWmlUcHp4aVNXRWJyS25ncHREZDNJN2pXL1NFbFNBRmJqSHBOMmoxekQ5?=
 =?utf-8?B?WHhVZE5UalRLZ2FWa01LM210a3FMdVJyU21KUFFzRlRubmZ0OWhVcGg1S3F2?=
 =?utf-8?B?Q2JVMFBvTFgvVk1vRjdZZENoNDJsV0V5UWZITU9ZdkpVYzdmbTlrY3hsRkVN?=
 =?utf-8?B?Z1hhQzN5bGlPRDRHV2ZjNmZTSFROdXhvRkZGeHBlT2d1NkpWVzRZbDk1dGNo?=
 =?utf-8?B?WmZEWTRSeVdKSVdGWnJKbGFoS1RDNDRTRVQrK2gxY3BEb01obFBNV1pVbEVr?=
 =?utf-8?B?N004S0RkNmJCVGZTWU1HdEh4SGNnYUw2aTIvNXpEWmFrdERZVEMvMUpjN2F4?=
 =?utf-8?B?YjMvaXV3R0tmdTJPbzJpbFFSbUNYbCtjdElLZXdtOE51UVY5cFFPZGJFajVB?=
 =?utf-8?B?am1UVURsMTBnSlBGQ0FiNjdJSHc2RkNJY05tVzhvdmNvN0hnZSs5UUMzc2JI?=
 =?utf-8?B?RHF3dXA2OW1TSEZtZHB6VnZLRFM4dEkzdzZEL0dsT0ZjRnFNckRWZmhiMEdl?=
 =?utf-8?B?d25JclYvWUwzaTZMajljeVB3dG82TGg1dEZSaDRMRlNpMkIzb1RnQ1ZXN3ZL?=
 =?utf-8?Q?79jWUGezBi0ZHesNiqxdZasSC?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9415c26-c14e-4a6d-6520-08dcc734ccca
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:41:16.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2y7bBhPysL3fSkO3C9W0gJzIwul1o3SooeuuQvh1IsIS276JWSsbZI/1af80EeZuBLNItMCy6KDxpEHwG4vcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765

Add "brcm,bcm4329-fmac" as fallback compatible for wireless devices that
used PCI ID based compatible. So that can pass the compatible check in
driver.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml     | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index a3607d55ef367..4870caed5f75e 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -27,7 +27,6 @@ properties:
               - brcm,bcm4341b0-fmac
               - brcm,bcm4341b4-fmac
               - brcm,bcm4341b5-fmac
-              - brcm,bcm4329-fmac
               - brcm,bcm4330-fmac
               - brcm,bcm4334-fmac
               - brcm,bcm43340-fmac
@@ -46,14 +45,17 @@ properties:
               - cypress,cyw43012-fmac
               - infineon,cyw43439-fmac
           - const: brcm,bcm4329-fmac
-      - enum:
-          - brcm,bcm4329-fmac
-          - pci14e4,43dc  # BCM4355
-          - pci14e4,4464  # BCM4364
-          - pci14e4,4488  # BCM4377
-          - pci14e4,4425  # BCM4378
-          - pci14e4,4433  # BCM4387
-          - pci14e4,449d  # BCM43752
+      - items:
+          - enum:
+              - brcm,bcm4329-fmac
+              - pci14e4,43dc  # BCM4355
+              - pci14e4,4464  # BCM4364
+              - pci14e4,4488  # BCM4377
+              - pci14e4,4425  # BCM4378
+              - pci14e4,4433  # BCM4387
+              - pci14e4,449d  # BCM43752
+          - const: brcm,bcm4329-fmac
+      - const: brcm,bcm4329-fmac
 
   reg:
     description: SDIO function number for the device (for most cases

-- 
2.34.1


