Return-Path: <linux-wireless+bounces-19668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A70A4B28D
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F863AAE6F
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF91E833F;
	Sun,  2 Mar 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="gazyj67A";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="M0RPPXDg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A011E7C32;
	Sun,  2 Mar 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740928453; cv=fail; b=X7OmMYo3b+Brha3ZXhwvcHf+FojrW4JBobM29GcGEdIoOcbp8oNn2jyLEQTjOIqS/IsebGdnyxezvBaC9SBwg9JFv6C7jxrlcU9DP4SO/nZNH3YWIi/WyQ9uCUVJFRb+Dnk5MZD4Z43dXOtOyXEnrJIqrwp9WHu4XLTz+5Poa0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740928453; c=relaxed/simple;
	bh=Y7nZfjL2kJo/qDn4BvJiNX/nKF7CDCYzO7hZ8P09Mb4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c3nT9WR7uHSOwSVZOlr8I006s4kx8Cb69vxTNjUjRjphDGKotFNn4WL9kvP6Uzdsm4S92ZSmPY9PrlMP9FsRTgPObarMR8VWS8sTduGYsMWGs17Q7SvVX/Fl0lxG4O3AEfLsXK2vYnFwXzeQff9n3jD006LMkiX7Z7JeDWob+YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=gazyj67A; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=M0RPPXDg; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522CkTdn030131;
	Sun, 2 Mar 2025 08:48:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps12202023; bh=Y7nZfjL2kJo/qDn4BvJi
	NX/nKF7CDCYzO7hZ8P09Mb4=; b=gazyj67AbopvwIDh8P0ieqcE7ZgfTED7EatW
	vD4IPR5I5U9MJN/v8K9ZVgZlIxsRrxAFBA11pnCbW86/YjFX0/dcMSW5VySspyzH
	mqTMau2YTr5FTdk+IoV7iOJJqvb04fACM7SqPTUel/lIocrRrbImoepR3VPFgP9s
	WKnGSJ9f1sBD16ZltmcLKqGKi3yiOrtdEQ4r4uCopVOyXg4Fp6sNu4duSIbQtKUY
	mpR6SEPW3DPJjh9qCXeXQ/mTy75YEUiIYcHDoHXAJtMJa81owSTEDQ1LSzpLwFBC
	jZ0Lp6FcvDym7oPt5Xh1ge8YbPrDvKke5w3T654hlGx477tEgg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegh96k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 08:48:12 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWo8AriZS2+OMepNRxdUhs1Maz1JDvCyCY3wgFfvXIafNtNmeiLO9GVEjDSRY/gUcl2GEg6VP8+9fpeQ4g9TqgwmU+hztoKFe3h8Rq8cH3Xn0kvf/qqJzKywEQsw/Ac3hIAmErKAMAbyzzr0AsjpiCfcu9k5Fldzuyucu0zVSq+OiluzMwQ3GjK3VrRz5nrsvanMTyv3+zJwk7Vvntmc5pq5If/DtBmQpmNOZCmu9ZZfnHRa3SU7vmF919BtIDyyuDA0wBIqhVpn1WWffPRRZsuUo22m6+FUpjsv4Mk9sQUYuymHuj9bfKxIGncMOE+o8qCcKyGghtyjnae2QYNW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7nZfjL2kJo/qDn4BvJiNX/nKF7CDCYzO7hZ8P09Mb4=;
 b=Pa0Hl2LPcfX1SbnN5AeXCo+qS8ZKXLXGxrq6JH2buI1TS/KWnm2z1WxSht/8X5RLIlbuHsjBW0qvdA6li8UlGtwuPk3YQHjqCxgdMb9Gob5gCVd+X8dyRbcHsRJyYpLAx/WhnHKbKjbTYM8X2W9yeNnSZn5Eer9RyeJjl7wkpotwcuD8V8RD/UecR4yxBkr1LTmPt4iYXszoxGFCWmEJAZeJTJXItyWkHzBXtEpR9eD4jv/zReOwgZwltMyrtlULwm6fI5eMfLRIReDLqlIUXXVIbnSpCy0g062BoQuyzfYDKxf2lQ5qsv0QMo1Z/TVE34A9l3GOov56UhqHt/GoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7nZfjL2kJo/qDn4BvJiNX/nKF7CDCYzO7hZ8P09Mb4=;
 b=M0RPPXDgyHo14bMcF2WzXzTB75RCM7PmpHQRmuySQVsDCkkmJcsvCvajY/SH5GlxQ6ApQK3lA84x0J5VQH1IcS82xtxogmVpsIBLyvvqlTiZ1qEh5bhSgeBbk87kGjr1pCGqR7v+4qg3Q9X/xZT4gJAK4O7ZGm5ekErkUDSRbCg=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 14:48:09 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:48:08 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
Date: Sun,  2 Mar 2025 15:47:26 +0100
Message-Id: <20250302144731.117409-1-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PA7P264CA0241.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::7) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: b60ee328-9041-4449-55ad-08dd59993f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c25DRnZCem1xdm5SNktEWjg3RXdFdTNiWlFlTnFnRXdEcmZxUWIxYnhMYnZW?=
 =?utf-8?B?L1g0Y2Z0VGlibVF2RFE4TmRkZ0s4SHpadEZHNy9KR3hrT2hPQUhxZXZKSnZo?=
 =?utf-8?B?YnBoWEdXdmV0ellNZ0NBZEpZNSs4UkVTUHgwMzJCNjMvaHF0MXVTS0cwYlhC?=
 =?utf-8?B?alRYb01SRGhnUUxIOFpqQVBIc21jb1p2dkREeXlFdmVRZVBuMTBGTVdpNGk2?=
 =?utf-8?B?UUNHcHZnVkxLK29KQ2hGWGs1YU5uclpqOW5BL2VnOXFvSi95TVZFa3AzQjJG?=
 =?utf-8?B?Y1VsQWZNV2dhK2VJQjVRTTNBS1VNZmVaY1lRN3lFQmE4NFpGeHRIUnl5K3R2?=
 =?utf-8?B?Nm9QSDhNdkpmL0JuVXBHTFNWajN1UVhCOWNnSklPL3FtQ05OQm1FYndZb1Z1?=
 =?utf-8?B?QWVOQ0NVV0F5dGpCNlMxcUpoOTJMSVBCNHkxWDUwUC9MWFFDYUZ3WmE2Smc4?=
 =?utf-8?B?RUlWaFRSNDRkV0ROMGV6NzlEbXBjQ0UzUUJqMG9wZERvdGo4aTh5K0dLQmdT?=
 =?utf-8?B?cTNnVmwrcnNxYitkZ3U5K0lkb2dFRGREbjBheDc0TFNvMTA4alM4T256a2hX?=
 =?utf-8?B?TkRGK0RlZTgvTTNCMGhadExBc0lhN0FHdUVsalI2MmViWTFiMmpsOE5hckZU?=
 =?utf-8?B?R2NwZWYza2xraC9GcHNvd0R6VUNYYXQvUU9jVEhIVmRZZ0M0b0dyM0F6eVhF?=
 =?utf-8?B?Z214TkY3cHRJdzVCQmVPN0sydXJWb2ovSWxHM2M1UUI3L1dyTjJCT0RFOVQ3?=
 =?utf-8?B?bG8wTmVBd0RIVUdQRkVwcFJOMmphKzBYaklhalh2blQzRUQwMnByZ0NOZndO?=
 =?utf-8?B?eDAycmdCZnB0NCt3UWpWa2VEUU0xSGlPM0hEN0V2dnRaMWU0OTZqTlZrdjNE?=
 =?utf-8?B?WVFwaVBtQlN1TDZFeU80c20zdjV3QnY0czZ5YnZQb2poelQzVWpZR2M0R1F0?=
 =?utf-8?B?SGZxRjhyMUF3WENvN2dDcDdvWFkzalVHOE5RVFlaa2l6a0UveHlPVTQ0RzVp?=
 =?utf-8?B?VGVBaU1sbVhwYmpPWHI4T0tMbTV0YnV6cFd5ZEdSa2g4OW5weEd4MG53NDVZ?=
 =?utf-8?B?c0RNT1FzQm04V3RGS1hNVTNzNUcxekVDSEJncjgxWmQzVWJkTVhHeEt3QUJO?=
 =?utf-8?B?Q09adHF3NGZjL0p6eTcxOC9Pb0IreXlsbC9IMHA3ZDA0Y3k1aUZWSVNMQldZ?=
 =?utf-8?B?M1FDK1c0OHllWWl2b0ZSYTZnbTZQcmM1aVY1Vm5KbFRPR0o3dnlkNUxxanpJ?=
 =?utf-8?B?OFhFTVN1emZlQ2tITDNieVprTVdaaFFNTCtJK3F0NVVrbHZZVjgreHZsT2lU?=
 =?utf-8?B?T0VkQXRGdUFDeWNPVkhONWtYNkxCYUxwbnpLQ2ZjZWhUMzB5dWtaUWFPSEtU?=
 =?utf-8?B?MzVRdjlNdys1UGN5MGtEa3NHNnBxSlhZUlpvVmtsOUZzdnRpT29pV0pOZjBL?=
 =?utf-8?B?ZVc4L1R6ck9ZRk1jZ3Jpa1BkUm5RT09Lazk4WFRXdXN3eVhGYU1Gb3FBdjFI?=
 =?utf-8?B?VVRMSHlIUlpiakV3SmtqeVUyTTB2QjIyQmpWLzBjT3hhbU1pUDJPdU90VlpR?=
 =?utf-8?B?d2pQNk9wc3p2OUJMNmVCY3pnSUtzQ2tENU1NamkzSHo5Y3dXQXZYOGZwOFF3?=
 =?utf-8?B?NVFtV3hEUXJMS285WUpRdEJLVVJDVkJLc09QMXp5VzY5aW1JQ3VNZDh4YXRC?=
 =?utf-8?B?V3lPOFB3YjNnQmtCV2UvdnowY09GbklTMDhLbmNTN1BhK1ViRUNUR29aMnVy?=
 =?utf-8?B?TDI1SUx2TE5SYkhVSS95RnAwMjdjV2FwUXl4OHZSMUZGUEVaY2E2cmpwTU1x?=
 =?utf-8?B?dVFjWGpPY2tWZUFZMjdlZlltNGl4QkRGN3NzWGZnUnJ1RnhrZU1wRGpTOGMw?=
 =?utf-8?Q?uCCbX+a8gfXq7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFh5SzRudWhQOXlTV0hNNmJlQzBkSUgvTnA4bEMxTkR5WUxZU2JBOE5IWlJU?=
 =?utf-8?B?STBoaHJuVFM3aG1xWHJPaTVSUFF0WVZLKzUzRG82TDZKWVNudWx3YnF5YUVw?=
 =?utf-8?B?VUZ2dkZrRndmNFM2dTMyaTZCYnhxVU5JTUJTOWMxK2g2WTVhd3RTSFZnWTRw?=
 =?utf-8?B?djdSUUVZZTFrMldDdzJ1Znd5aDcrTGUweEFWUndWY3RDSTlvc1loSS9vNUFB?=
 =?utf-8?B?c3JWSFdPNFc2UlgyYXhFSnJuMDNoQ2pyLzZOcEpDSy9kMXJERGMvaWxKaDNz?=
 =?utf-8?B?UnpHZDdWY2dVdWFJRThGQ3NBUXBpNTcxazRqZ29zWDBxWUdPVHBTV2NFU280?=
 =?utf-8?B?MVN0ejR5RnVyRUk1RFhGcXJKN1d3MFpkQU84c0QrMG51OUtmcitFdDB6OXpm?=
 =?utf-8?B?bVFkVFgxaGxIenJMc044RDFkdmhXNjlBOTFhczVIenhRcjhlK3NTYXllRXA5?=
 =?utf-8?B?S25JR0N4VXJTSmVLcFR5WU54dXRPeHlJQUQvZEFHNkxwUktaQnBxdC9ETldZ?=
 =?utf-8?B?TjAwTG1JQitDYytNV1lJcTRVMXNLUVllYnJScnZvcUhVeVZSaXRXUFJGWGFL?=
 =?utf-8?B?eVBSbHBSRkNrb2xFSDZpYVJVMUtaSGM1ejRoVmlZSkcyQjFRZ2FSeTJkQmNu?=
 =?utf-8?B?UHpYSzUwaUFZNlk3SHFWNUNrcTlxUmNHSWNsSEJTa1dTTWt6T3Bvc3RGYUtD?=
 =?utf-8?B?R05iK0lLWTFLMkxibjd2R09hWnc2YUxmcmR0aHE5aCtOMGVrUWtyUGttVlp3?=
 =?utf-8?B?aS8veFBDQnVLeG1Tc0xhYnlLV1hvakRFc0lGUnEwKzdxY3lQM04vNzZXUzBE?=
 =?utf-8?B?UXVObFFVM2xOdVJGYmJ1a1NHUXNyZk1lbnZPT3F1cit1aXlDcklqWHFyLzVY?=
 =?utf-8?B?d0pST1VOWG42aGdMYk90VzhBZ0wzZnhtQnFMZ0NOOWxCWURuN1Ezc2FCZkd2?=
 =?utf-8?B?d3AzT3BLTU9zdkVudkx4ekZvN1BHMXBUV1dsSWhXbFJJcWZBR1c1b0F3bzJj?=
 =?utf-8?B?OGhkREJ2MGFXbUhKeUI4c1YxeHZ3emwwdS9rZWRzbEo0dGJHWDFnZHZsRjF2?=
 =?utf-8?B?Y2FmODl0V1YvdGtBUlFDZFpVUVNjYUpaTGlsUFNDYm1mVWN0YTNLeUN1L29N?=
 =?utf-8?B?bmhxcm42ZjlRaXArTlo0cUcyRjBFOE5uZXVpMXUrQUh5RkVBNHhkNnJEQjNI?=
 =?utf-8?B?WnViWlZqdURIZ2hQenhMRmtBSUxycWg5Nk9tSURmcy9lYWlXRW9laWxEOUhJ?=
 =?utf-8?B?eXBDKzMrV3pvMGtCNDZibWhhRkhZL2pTOUhGd200dXoreTVHbUMzQ2dIUTJv?=
 =?utf-8?B?WjlqWGRERm53T0hCenVUcGNtSG5iRXc2RDdiMjVzZ2hXU2lzaUhkLzNDNERr?=
 =?utf-8?B?Nm95UUp6a3pSdGkxd0ppUnNuSnRBcFZFbmxuNVp4bXVjOEJJcVFCNGNuVHM1?=
 =?utf-8?B?M0hsN2JIR1lPZjh5YmNUS3VkN1FPQXk5YkxNdmRubUVkeUtBMFJreDZQL0t2?=
 =?utf-8?B?ZE50NWtOeEZMRFUxenRUTW1ZQjZQK3VLUHFWamduS1lORktjY1N5cmgyZzV6?=
 =?utf-8?B?dHN0clF4SnFYVGxJZ1RHcWwvUGxVbG1HNE5NTEtTVlZmU2pkNmI4THg4ZEtm?=
 =?utf-8?B?QUtYN0NpTS8rblRCSUp5dUd0MGlmZXhFcU9MQ21ySFIzdGJQL1NqNzhXOXJj?=
 =?utf-8?B?cmtYeW1QMC9Ea3J6R1hVQWRiMEREOFhCRklFNkR6UXMva0tvOTczQUV5MC9q?=
 =?utf-8?B?blROK0Z0NWhRVFROWmtTSng5Q2QxZ3AxNXVvd2VQTVJVMFJWazd0aFM0UnNR?=
 =?utf-8?B?b0ZRdVNrdFFSUW5DdXZSM05vdUYzdndxMjBMeEJIcDZKYk00SGxPeHRZOU1i?=
 =?utf-8?B?SXVldlBPTHEvcnZUbnp5RE4raldBdTJMcnNSTEdPVkVQZHdmV1NVWEhWZ3FY?=
 =?utf-8?B?RGFodUJ5dWloa1l2dGRQM0o1U0VJRlFjLzBSK2ZzQk0ydkgwVEVOeGlvZjdQ?=
 =?utf-8?B?bWs2TUdWK1RmUVNRVkJ2QmdSY3ZIT0srNDJ5TkZSb1h3aW1HZTJZVXFJK0xR?=
 =?utf-8?B?bzZKMjBGZUtESmVkanBOSElNWGRiUTkza1pDVHEvaUtHd3FQVVhLNmFKSEFO?=
 =?utf-8?B?TkNuLzhOMXBvbTdtckcrRkxrV1k2SDVwZnhtcmhWVytGdnhEMXpJK0ZzTits?=
 =?utf-8?Q?oqMu5FebnYnnq74BKXViLRN/RCAD3HI4LHAFaoz0SgdD?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60ee328-9041-4449-55ad-08dd59993f79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:48:08.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJRjLw++2iKeA9ZurEbJpB+O584TNXQ0eoTnbLl6Dc+J9L1xg/u2iDebvQaEuEht4wIhj3HyaOIDD0ajkW7JEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-Proofpoint-GUID: z0Kueq05s5VqL9rcVS74PnvYfAoS9ETF
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c46fac cx=c_pps a=o1gEiTSI8oSw7jzABoeZjA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VXklulzeiYJ0jjgIAQcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z0Kueq05s5VqL9rcVS74PnvYfAoS9ETF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_04,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=426 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503020120

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
ZSB0byByZXBvcnQgdGhlaXIgc3VjY2VzcyAob3IgdGhlaXIgZmFpbHVyZSkuCgp2MjoKICAtIEZp
eCBjb21waWxhdGlvbiBpc3N1ZSByZXBvcnRlZCBieSAia2VybmVsIHRlc3Qgcm9ib3QiWzFdLiBN
ZW1iZXIKICAgICd3b3dsYW4nIG9ubHkgZXhpc3QgaWYgQ09ORklHX1BNLgoKWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyNTAzMDIxMDU3LjVxQ09xcmFhLWxrcEBp
bnRlbC5jb20vCgpKw6lyw7RtZSBQb3VpbGxlciAoNSk6CiAgd2lmaTogd2Z4OiBhbGlnbiBkZWNs
YXJhdGlvbnMgYmV0d2VlbiBidXNfc3BpLmMgYW5kIGJ1c19zZGlvLmMKICB3aWZpOiB3Zng6IGRl
Y2xhcmUgc3VwcG9ydCBmb3IgV29XTEFOCiAgd2lmaTogd2Z4OiBhbGxvdyBTUEkgZGV2aWNlIHRv
IHdha2UgdXAgdGhlIGhvc3QKICB3aWZpOiB3Zng6IGFsbG93IFNESU8gZGV2aWNlIHRvIHdha2Ug
dXAgdGhlIGhvc3QKICB3aWZpOiB3Zng6IGFsbG93IHRvIGVuYWJsZSBXb1dMQU4gdXNpbmcgTkw4
MDIxMQoKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzLmggICAgICB8ICAxICsK
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NkaW8uYyB8IDUyICsrKysrKysr
KysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5j
ICB8IDQ1ICsrKysrKysrKysrKysrKysrLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
ZngvbWFpbi5jICAgICB8IDEyICsrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4
L3N0YS5jICAgICAgfCAyNSArKysrKysrKysrKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9zdGEuaCAgICAgIHwgIDMgKysKIDYgZmlsZXMgY2hhbmdlZCwgMTM0IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCgotLSAKMi4zOS41Cgo=

