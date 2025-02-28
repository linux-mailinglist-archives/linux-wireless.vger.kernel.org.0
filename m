Return-Path: <linux-wireless+bounces-19605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC05A4A0E2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9D33BBEA4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25712512E4;
	Fri, 28 Feb 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="AP2fgitM";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="M3rWSwP+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528321C1F20;
	Fri, 28 Feb 2025 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765157; cv=fail; b=X4mZmKZIcmXYOgGfN6k0GHXHg4scVjhf018JV+m58GDVWNjiPJUx4y7hY3r6dtmLUP3Nd3M/yjOGeq7/8YcagFYqWlBOJXDLbn1R2xne+NyN/0O1g43s+FV5t8574PyAd/2ftNBS63KdooL0OLCjEqeZR444kRsHEky4SvSceQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765157; c=relaxed/simple;
	bh=7c8oBdfIQAiGtq7dH1h3fZZUszPxUEZJm2bUJVmAt9A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tTP08KK+pWvvoJu1I2sGPp1sM0H9DBKeoARcg7f8j/dFcNA/YamvQ/KXXTlK/sj8L7GpNblUo3EQIgec49O5fAeRUW1r/8qLD7tA3+v1E9pICXFjifMZNbFoJYd5liDrs+khYyusJVucVTpkK9XK1XmtOvlhmzYOigQs2RoAnsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=AP2fgitM; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=M3rWSwP+; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S8EhYI012718;
	Fri, 28 Feb 2025 11:15:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps12202023; bh=7c8oBdfIQAiGtq7dH1h3
	fZZUszPxUEZJm2bUJVmAt9A=; b=AP2fgitMAlrWKoQE454FZIq7wf4voom9W/6N
	VDHtDU7k0/eQWSCF5lzIdJdqVtrhhfb8G45y6fArwNHb8PV+21ZfwmbubkMJmONU
	cqNkFXEv6A5J79oTGq1FrdVgmBo/Q0ePsefbuzEBGGbQw+app9G61qcayEV7kvI6
	N1LNZKmE4gB9K9pKMV06YuvkaSBY8AiXki5RUv2C8ZvQvGz3Qa4aVGoOAOpis0A4
	8X/75mmVIWxt2XYou/8AObkbdNxSYKuWgt4ZINv5ZdM1w+ST0tTQJAR+j5SglIyt
	vfSLQs6oIT1DH2Tacs5aA/G/wIzhXbZmxltfbshdA+QS7aVx5Q==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4539fbrujd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 11:15:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIhi4eOPm9DqgmYC2Hayww+jFQ6tRCMcaG+Y0QYxKnFdjOVtrHirWXe0U4dtLPCp0nFfWjzY2Jt33huwTtUrHTYsNOhUzXstZFSTi75LxXoznlOTUdtGZhAxT2c89TlTNDAK4KKmU2/qwvb+XrEOcBcVprUph/EVCZn/dkO7LnSn4mih9jn4bVdxDOfP38VqrmykHT14gTQ4/fU2ogXDmmpmxu2eolonGApr617WxIvaRl2/q8GongB/wUS/Y1myRoruaaOx10o/1RrLgnGWPSho1eFGkPKt84DbS4lxOAQpU1IWkKzr1Hl1iXBpAvzw/1zzaHhtyfXbaApUDtHkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c8oBdfIQAiGtq7dH1h3fZZUszPxUEZJm2bUJVmAt9A=;
 b=oLzOApSEZQPtub6gai4WpJi4PUbsSk8ZggtVW06SURMwm7fz0WgIEz+ypZ15hbzwnq9+qPgw6KatHFrTCrQfYmO/N3vU0KGYOUdkzJoz9rluQJSYcQXzjtQMVqytt9t/dg238Mr+C7MT7TldNIRxRSM+i17HcVUfJVO82CVoKBQPVwZzMAoquKBJhYt3dmgW1JSa01wRSrj+yhAj9Z/H7umsdk/BlKO2gnUPhbFv5Dq77IcRujaEurGCTDWcLlB9lhdqXuLTyZn8H2GCYh3IVUAmGdVgsiYiMMdE37KmYJT+ORqQogcjwqAU4OJTvpJxblHsuyETVkROcylST5xO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c8oBdfIQAiGtq7dH1h3fZZUszPxUEZJm2bUJVmAt9A=;
 b=M3rWSwP+On0gkt8KFMT3zWrZ5BG2thTKNYxaQDKHxeKq1mzQwa+8NTa7X4GLMILVMvoNQJHEtJbQin+xh58e+9r0EQvgOyd4WbMhE/lktTdlKWHY8dvfcTkZvgDiYTM7A7BmmwlmAK3EtxMfFRL8azCNkeRa7yhvuf48Gu+CLl8=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:14:53 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:14:53 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH 0/5] wfx: add support for WoWLAN on Silabs WF200
Date: Fri, 28 Feb 2025 18:14:36 +0100
Message-Id: <20250228171441.109321-1-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR1P264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::12) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SJ2PR11MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: cbea728b-7631-47fd-bfcf-08dd581b6a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkZoOGIxa3MyWC8vZFVKMFlDNVZiL05TaVZnRzBEUURjRmtCekFHUUovNWll?=
 =?utf-8?B?RFRkVGNRdmJkdTRYT0VQeThGdUYxcENoWUxSd0ZSZHEzelJydDdpVjNTeUlq?=
 =?utf-8?B?UCtDZ1NlKzdkNC9Ua3dqSlcvRVhJbTlvTmc3U2ZJbVB2QWs0OHRjR2VBUmRB?=
 =?utf-8?B?bURidVBubGJkMU1KTGZybmYwRldiMTBidUo4VUQ5Yml3ZHVicGZMdHloRTM0?=
 =?utf-8?B?Q0dlWHNzeThPMVR5TGdqNVYvaGdwaXRNTEIwU25wei93NU1Zcm9NUkFKN1k3?=
 =?utf-8?B?dE5WNjR6Nkw2ZzVpbUlNQlZ0K1VkcXJKdmNtMWNTRTZrWWRXZVN2TFF0SklD?=
 =?utf-8?B?cVJpVDYzeGJ6QjEyWVpPRGNGYjk0Y0U1SThzUFZSdVdlczUrUXFFWlZ0aEVo?=
 =?utf-8?B?ajc2TWtUZTkvMWtqWHJDMHhXaWsxV3lPenQ2N2ZJYWpZMU5XN1l5a1U4MlRF?=
 =?utf-8?B?Q3ErdEhMU2VXL1pRVzd5NWdYTlpRczFGck5UWi9CeDNTRkxadG1QTHNZL293?=
 =?utf-8?B?b2ZJTSsyYXlVbjdINjFXc0lRekJONDNZU3ROUEdIMXc1SWh5ZWRzTGZSYW5k?=
 =?utf-8?B?c2loei9pVUNFekxWMk54Ylp1Y0gvREFTT3gyNnIxM1RLTDRsc3l3MER5Z0tm?=
 =?utf-8?B?U21iVkR6dzJ5dHBkd2Q2bFgvcXc1TUhtMlZSODM1NUZIcXZuTk8yU2dzZ21G?=
 =?utf-8?B?UkltMmhJaUVHeVRWRlM4NFc3WGtKL3UvMnJVNGNsbVhiclAvcERPZzRRZUlP?=
 =?utf-8?B?YWZ1Syt0Ync5b2pqZHArOTE4Y0RKZ3JlUkppQVJOZmxxRWlFVlcxY21NYlE2?=
 =?utf-8?B?L3B5UmxCOUY2QnVqTXk2eGlJclQ1SHc0d0NKcFpNTzl6NmVlMGhka04vdUZ6?=
 =?utf-8?B?dUw2MHRhZmtnUFM4N3FuY0dUVWRabU1iTGM0K25pSjB1SDhiN2JYWnEveVVB?=
 =?utf-8?B?dVZXRlk0Y2VHSzBoWjh2TGVNZEYxd05aT1FiVTZpM1dPNGl3UHVFM3IzTzVa?=
 =?utf-8?B?UnBOeDF6TnlGa3A0ZVpQSXpZelA2L2FvcmZrdXRNaEs3dktFY0hTcktVUXJP?=
 =?utf-8?B?RFJkSnNOcW9iOUZCakZhVFJzSDNkQnFPaGpuaE1yakdYeWY1dldFS0psOHZh?=
 =?utf-8?B?SzFXdDdCankxTWRuQ3ZqajFtc1FMWU42dGcxRVpCM0svNWd1K0w4WnEyWjNp?=
 =?utf-8?B?WllDc0l5NWV4anVvSUJmMUJxcjFFTHNjM2t5OGdlUHBaZVFodzkyNS9Wbjkv?=
 =?utf-8?B?aGwvSHEvNmlZRHhvOVdIZmVmL25jK2l0VHZNMTJ4MjVWcXpIYzFCY0dkdWMz?=
 =?utf-8?B?MVZtOFk2YXNjczU3MnNpK0lmTkNueFFORFYyUzJIcWozYWhkZ0tPWTQ0N09p?=
 =?utf-8?B?bmZ6N1VHWHEvSFJiN3ZyUXNKSFhLTkc2WE90WGhWTlpoSnVXR2FmcGR3bk5n?=
 =?utf-8?B?d05DbjZENDJ1RkRBY1J2SC9oMm55cmszTzl5Vit1L0pVSGp6Y1lRTTFHSkIy?=
 =?utf-8?B?cWo0UmhHUlhqdTJRVnBOSHIxYWZFdDc2Yi9ZZGtUSlVxeWlVSkowWEFheFBN?=
 =?utf-8?B?Z3JrbmlySC9zQ3ZwNUN1ODk0Y2dRMmxsVjVHNmRwVDFHcUdHN2lqemttN1Vs?=
 =?utf-8?B?dE5zRi9sZ3Qrc0VHZXNhMGt4NnBhY0RTZG9BM2tBOGkyNGhvZjVrTlhZN0Mr?=
 =?utf-8?B?dUIrZkxHV2I3NWIwLytYeWloUXZqRzFLTXA3Ri9YVTBpWGVsbWV5NHltNlpE?=
 =?utf-8?B?WlVYUHBZOENCMTF6YTk4aWpJendKTHlrK2thakhRbGVvUkw2a3hVNnBUZEdD?=
 =?utf-8?B?OXJaMmRqQXVBMVpidWtlSFYyejdEdjRsdWdRdVR5WTdHZmtrTXUraTE0Y3Vl?=
 =?utf-8?B?NjR2NXptUGVJNmdzUW9sakRHc2lRcGgzcW1mTGVadGIzLzlieXcvUUowTC9G?=
 =?utf-8?Q?cHlVmHlvFFX9MdJmXPLqSEZJmuV9yEh6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkQrTEEvaVZ4bGdRdWRDSlZ1OHNuSFgvRnhGTmxPNnZaK3N1SEtxUnFMUDJC?=
 =?utf-8?B?bmFRMEVBQTVYVkh3c3VpZmR6OXE0cy9YbVFJbWIvRWZTdUZqMzdVY1pjd1c4?=
 =?utf-8?B?ZmVOaUpxeENDYlJSNDVYZ1E0V1VzbTZTa0FKbERGdWhPajRURXlmMTNHS2k3?=
 =?utf-8?B?Yk8rZkZ1VGtuc0hpeDYyUVluNnM4anEvVlBUR0hEQ1RBdlJrTjAreDhqYUVE?=
 =?utf-8?B?cnM1NFp2OG40MUNKQ0hMOE52WU41eDVEcno0VndrUmRXQVdscDBOTzhUWjZ6?=
 =?utf-8?B?d0kxR1JCblQrZmdOSlgwYjR1dEtBdDNpOWhjWlQxV2NuWlV5bnpBVjh3Wkk3?=
 =?utf-8?B?cnZmYTFkRkduS2pBRkI1aWU1MGU1T3pFTUxleVp3ZUpQdlNEZHRQbXQwQVpH?=
 =?utf-8?B?T1ZYTG9OMy9IUHgrNTdEaHRWeUdoa2R3bkpZaWJjQXFwZHY0R3cvd3QxSVJz?=
 =?utf-8?B?R2xjaS96c2hYZktTZ0prcHRtYXkvQ25nUHdwYS9DM0FidVM2QjF4MzNNQmdE?=
 =?utf-8?B?eGtIMDF0ZXljcFVnRUZGa1JVaWl2VmRxUHpFRHhkWGxsVjFrS2hBMjdxbFNP?=
 =?utf-8?B?WFhZdTVRVEhScDNCME40NHRQR3N3dmtkMU1UMHBNQ3R3TGt4b1Qvc1dyOENk?=
 =?utf-8?B?QmRTQi9LU1NOVVdGNnB0Rlc5Mzhicjh2MVozTXlONVAvK2VBcW1UdjFXcndU?=
 =?utf-8?B?bnQxL01lanVGWkFvbUJmY1Y0OXN0RUNtTXNkMCtHSThnZkd6aDRTV3FJYmJC?=
 =?utf-8?B?THltN1hPZ25LRUg2blUyRU54WGVzVlpTdVcwMURiL0FaclZPSjhIOWRTS2hW?=
 =?utf-8?B?WmQrYTltMFdQZFJzODZVUVc2L1ViMGtMVVpmSmtzSzh1TStuc1MxUUtCWFFE?=
 =?utf-8?B?d2xZM0Rud0txdFFTZUVTNlhvMERoa3Z3cUduTU02UlMyUUd0QnI0QXBkMldK?=
 =?utf-8?B?NWVSekhoWG8rSUxLVWtmaHlpZ2lxOGo2blR4SmhoM3NDY0EvYlBxWC9QMXp1?=
 =?utf-8?B?UlczM2lSNTVUNHAva1VwQXRDTUxpN3lBSlhsU1QvVGZKdkdEZXo0REw2WERN?=
 =?utf-8?B?SWt1bzYyNGdiY29SNGJwSjh5eVMwWG1icUFRZXhCc21GYkJGWFZ1cUZKMHFn?=
 =?utf-8?B?aW1uUFFSMS84U09majFiQW1DVlZORW9wQVc3cE5EeUhNTlNtR0dkbE5vd0F0?=
 =?utf-8?B?NUFYT1ZmaDdpRlBjbjl0cTlSZjFkOTUzQWw3RnRnZkpzSzViY29qTjlHQVBy?=
 =?utf-8?B?emtCR2d4a2N1TzdqU2tualJmUmFYQ0g0MjRMUUNvR2tURW9wd3U4bE5JbVMr?=
 =?utf-8?B?RitwbGVISllCM0pyVDNCZkFCbXE5QWJSdUp5dzNEOHZrTHpoOTNmVWMrNUlx?=
 =?utf-8?B?YThQNEEvanVlSDhiMVhGZmU5aEJlVlNKZGRQSFhMV0YzK0lSbmxwdGp2OU9i?=
 =?utf-8?B?U3hOWVpkRXREeWc1QUQ1ZHNhbTZLU1FwSFlPN2xnTlo0Rnd0cllLU0FHbVE1?=
 =?utf-8?B?S2VPcElDc3ZUWjlENWRYdExzV29QZ2VCMXdkVUZEWHFlUEJXeXUzRlFkSDRQ?=
 =?utf-8?B?UTlhUlJzdUtoNU9rcjZKZmZoWGE0RXhXaW5TckxQWHpnTGpJRnJCenk0U0V3?=
 =?utf-8?B?RE9qTC9lb0NCLzNxRG9TUzJ0d3hvbkJQV1hJV0xNS0FBUTJQdlRrRG5BSTRS?=
 =?utf-8?B?MFFmMDF6Qm51cDdVVC9WRkZZRUFDNXBRb3hZRy9iR0RObGVDUWd4RVU4Q2dp?=
 =?utf-8?B?OGNERTBvRUE5eEtLQW1ZdnlxT2hiVTB4ZUZTM2tpd2VxdlpqbVNJem02ZXkr?=
 =?utf-8?B?MXcvK09XemdqZUozUlh1TXZDS0tnZlBKV0VMTlgzUktCc05SbnJROVcrWVJm?=
 =?utf-8?B?dFI0NU5IUXNhdnd2SmRwbGsrOTVPK1Fzajh5VC9HMGZWOVpKYlFhSnNXQk02?=
 =?utf-8?B?KzZOVG5uNmxoM0JISGpMd3lzZUZBTGlvajExUDREUktTeFVPc2oyVncxNVhZ?=
 =?utf-8?B?SURQZXdKMjd4L085eTRkSVNsMGlTNFF5OEMzV3RHR0xsK3V4cXY0UThYc3Va?=
 =?utf-8?B?UUNuOWZmaHZHeVdEUWdDTnNQUkpoeFMzaVVNTmxNZ2pyczBzbTJCclBHV3Zz?=
 =?utf-8?Q?mIg0aweq+SsJdMAvTAWeGaRng?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbea728b-7631-47fd-bfcf-08dd581b6a88
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:14:53.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l39dIB9jEJiSKKXYgjLhNsneopQ/lCWpMhqsRH8nqBiHJuUgAPMW2g2Bf6ZZ6bjt/ym8LlZVLzeF8pKP/8MkJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-Proofpoint-GUID: dh8MTjZYNXFimTn_jHPiinJx0xurh4_D
X-Authority-Analysis: v=2.4 cv=BptnwZX5 c=1 sm=1 tr=0 ts=67c1ef14 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=VXklulzeiYJ0jjgIAQcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dh8MTjZYNXFimTn_jHPiinJx0xurh4_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=522 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502280126

VGhpcyBpcyB0aGUgaW5pdGlhbCBzdXBwb3J0IGZvciBXYWtlLW9uLVdMQU4gb2YgU2lsaWNvbiBX
RjIwMCBjaGlwc2V0LiBUaGlzCnZlcnNpb24gZm9jdXMgb24gdGhlIHBvd2VyIG1hbmFnZW1lbnQg
Y29udHJvbC4gRm9yIG5vdywgdGhlIGZpbHRlcmluZwpjYXBhYmlsaXRpZXMgb2YgdGhlIGNoaXAg
YXJlIG5vdCBleHBvc2VkLiBTbyBhbnkgbXVsdGljYXN0IGZyYW1lICg9IGFueSBBUlAKcmVxdWVz
dCkgd2lsbCB3YWtlIHVwIHRoZSBob3N0LgoKSSBoYXZlIHRoaXMgc2VyaWVzIG9mIHBhdGNoZXMg
aW4gbXkgZ2l0IHRyZWUgZm9yIGEgd2hpbGUuIEkgaGVzaXRhdGVkIHRvCnNlbmQgaXQgYmVjYXVz
ZSB0aGUgY29kZSBpcyBiYXNlZCBvbiBhIHByb29mIG9mIGNvbmNlcHQgYW5kIEkgZG9uJ3QgaGF2
ZQphY2Nlc3MgdG8gdGhlIGhhcmR3YXJlIGFueW1vcmUuCgpUaGVyZWZvcmUsIHRoaXMgZmVhdHVy
ZSBpcyBleHBlcmltZW50YWwuIEhvd2V2ZXIsIHRoZSBvbmx5IHdheSB0byByZWFjaAp0aGlzIGNv
ZGUgaXMgdG8gcnVuICJpdyBwaHkgcGh5MCB3b3dsYW4gZW5hYmxlIiBvciBleHBsaWNpdGx5IGVu
YWJsZSBpdCBpbgovc3lzLiBTbywgSSBiZWxpZXZlIGl0IG1ha2VzIHNlbnNlIHRvIG1lcmdlZCBp
dCBpbiB0aGUgc3RhYmxlIHRyZWUuIFRodXMsIEkKaG9wZSBzb21lIHVzZXJzIHdpbGwgYmUgYWJs
ZSB0byByZXBvcnQgdGhlaXIgc3VjY2VzcyAob3IgdGhlaXIgZmFpbHVyZSkuCgoKCkrDqXLDtG1l
IFBvdWlsbGVyICg1KToKICB3aWZpOiB3Zng6IGFsaWduIGRlY2xhcmF0aW9ucyBiZXR3ZWVuIGJ1
c19zcGkuYyBhbmQgYnVzX3NkaW8uYwogIHdpZmk6IHdmeDogZGVjbGFyZSBzdXBwb3J0IGZvciBX
b1dMQU4KICB3aWZpOiB3Zng6IGFsbG93IFNQSSBkZXZpY2UgdG8gd2FrZSB1cCB0aGUgaG9zdAog
IHdpZmk6IHdmeDogYWxsb3cgU0RJTyBkZXZpY2UgdG8gd2FrZSB1cCB0aGUgaG9zdAogIHdpZmk6
IHdmeDogYWxsb3cgdG8gZW5hYmxlIFdvV0xBTiB1c2luZyBOTDgwMjExCgogZHJpdmVycy9uZXQv
d2lyZWxlc3Mvc2lsYWJzL3dmeC9idXMuaCAgICAgIHwgIDEgKwogZHJpdmVycy9uZXQvd2lyZWxl
c3Mvc2lsYWJzL3dmeC9idXNfc2Rpby5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKwogZHJp
dmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc3BpLmMgIHwgNDUgKysrKysrKysrKysr
KysrKystLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMgICAgIHwgMTAg
KysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgICAgICB8IDI1ICsr
KysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oICAgICAgfCAg
MyArKwogNiBmaWxlcyBjaGFuZ2VkLCAxMzIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Ci0tIAoyLjM5LjUKCg==

