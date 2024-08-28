Return-Path: <linux-wireless+bounces-12123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502096218E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B489D1F25BDD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEB161321;
	Wed, 28 Aug 2024 07:41:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBE15E5DC;
	Wed, 28 Aug 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830887; cv=fail; b=sThBTBgM3fDafU5YGxMiY9+Rfw+fII07seoa/IionE+7ICH4Z1gLfNq3yaha5L+bNpH6QXoU7Np/tA/GXOrDG3kJNoGjtgmpPW9LQvIMxoYx5Fz0+rpVCb+tvzK6Azjh+mkfPgP7yWGeDZghXxp+se0azAMBeF7H0RfyScYICXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830887; c=relaxed/simple;
	bh=1EIqUH68e2yHYUoqfpobt6Hzt4qoimWdTYOf3QUUDbM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zlyr7j2skr3z0rDDH1CNxhKGkdSa7YB0QUNW4AuReKK+rQ5Fs2FR+cfBvY2+AZDVFlTvmWj3LHLLXZhLxjk5V9clUPY3n1pzgI95gQweMLrfOljvVtHmI/ohofGS8BOsLzEQwM7yHgYGJ7GOjRro2Qi1AqVFPwtQvCytxHiwmeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDXH4E7wJyx3mKmeqbEmSuAy2Tp/784dwZnXvg1+UF8B6NPBOk5il1l0xDXAqyWY8SYVOsTZcdg30jUrzRKuOLjutXv7igeTDBo+k0LxpbrYJ1j4nxpAr4rfSBSwX37IJcnzELNHpxGaeacCRGF6nDxnAIYELvVNYfgjWcYro0lkCKU3YWpWRLDMfk4/UHDlUaMQcKqZ66PMGVe9TeXgXMhGZ3p0o0EBiucnETl5x27LQQzKAJfE831qedq8G5Y8qtbXU8yk2gl8pm0D1KvfgRY7YmCcGL8lmJBVOc15ft5sADoRgBA06YqUp7Iaip3VXCwIdQpD/iP1iz6/a16+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlpp3oox8tLYxz6TyL3i7Joq2cepMbm6CkxqGzFixa8=;
 b=HH6Bv6DzrhykAkYJh7KRuc3HZB36z02SbNfSYNUN1vWjvg6cOuzTOrcEo+je3YFP3U6iK03/j7NSK4BLbplBvgXPEfvKvP2lV1HlcUQMpGKnnsoKeEo3ULZwK3iTmM4FEFc+bBcQTtwwPz7/i/TVVfZRe+hmeqM/7u3MxyRsb07Ijf1zNZE8m87f2Vfxftuk2/m08E0gHftCZcgcCX+q8NKhpr44iRgL+tKqQ+RJni0OyD6NG7XtcBdCQ9pXPavOp2YTPMR1+pgl/1DPo9bYyYm0gRne11mqNGCj9+TT+bX0G5zbumQd1RA3WzrR8USA1RjL2fPU5dpA+Y2l4oz/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:41:19 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:41:19 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 15:40:51 +0800
Subject: [PATCH v12 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v12-4-9064ac7acf1d@wesion.com>
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
 Jacobe Zang <jacobe.zang@wesion.com>, Ondrej Jirman <megi@xff.cz>, 
 Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724830868; l=10253;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=1EIqUH68e2yHYUoqfpobt6Hzt4qoimWdTYOf3QUUDbM=;
 b=OxKV0cu8Ty/Fbd2PhjlpUjPVUTIh+eph+/peCxTe93A6LF/sUsfkHknsMRsmL67qu/5lqcbjD
 ggiYgQa298JATgyYec7I1L1pc8TXq1U6LmTweIYpDqX/zcJDR/i1pDQ
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
X-MS-Office365-Filtering-Correlation-Id: bfef1b6c-e23b-4adf-a280-08dcc734ce45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3l0RTRrV2VmbFc2VCtlRmtiU1BxNzkwdllzcVlRL0F3VzlFYW9KN3dNUzBp?=
 =?utf-8?B?amtpWmdvRlE3NGpGL1BZVGhMWDVYdGI1NmFYOG9aNzNqUmtjZFpKRHZuRDEw?=
 =?utf-8?B?WU80WkU2aW1JZnY0ZysxOENuZEVJdmdBcHBxak9zZ2JPcUlqSjdYQUZWMmFL?=
 =?utf-8?B?bVo5THhjUldnOENKNEQwR3l0bVVBb1Y5aGo4MWRCaVNrTXlMTm9NUnZINGsv?=
 =?utf-8?B?TEJPT0dBVHo3R3VLRSs3VUYxN3BGVXo2VzNUY2VUS1JnOUlVSVRKRGo3YitF?=
 =?utf-8?B?WXRka3kxclFZL1UxWTdRbVIzU2JDWFRZRFlLZTlYQnQ0RFdwc1NPQlZiODRv?=
 =?utf-8?B?bU13SURDV1cvaTlhaC9DU2pGZGNscm5zRXo1VkJQb2J2ZjdoWEdBN1ZBNzdj?=
 =?utf-8?B?VlFkZ2lidTBLQ0FoYWc3RGVTY3RCRW1PT2JzTFZzZ1V3QzNJdWZOQjZZNTN3?=
 =?utf-8?B?SmYvVXpjVG5XMU13dko3R3c1OHZheFBjL1V1YzhvQm1DRVJOL0ZaZmhUdU11?=
 =?utf-8?B?ZURSekI3Q1lxOVdpTHpHUnhvOUxiNldHeVdYcVFDbHI2ajlYNkFpbkFocmN2?=
 =?utf-8?B?bWcxNlRGRnp1YktGM09WZVN1d3NSMFJ3ZkZaTlh3YkMwT2tVNVlyTCtuS0Yy?=
 =?utf-8?B?RjM1R20zR0F2eTg3SlVvMXQ5MnZEU1YxeDNVZUdNNXJvNGxDVWd3bDJNZzZI?=
 =?utf-8?B?aUlSWVkyZmtLd3puelVNczVpdm1qTkMxZHljU0VXZERnTXg5TGkzSjd5NjRB?=
 =?utf-8?B?TGRqQldIblJyOGY1aFNMMTZjZTB2d1JWYmtnMVVEaUpZc0RCelhuWlAxMnZw?=
 =?utf-8?B?S2thbmFqVmhTV24xVk1HNUlXRmg1eWNrK3Z3cllORlZUTEFGcm0rMlIyKzlJ?=
 =?utf-8?B?QXFWOEJyV2MvZ3p1R3RKOU1PWEFQSWdyWlcxdG5KcmR0OGdrOUh4QWVHRDIw?=
 =?utf-8?B?WU0reFpzNWlrUnM4QWgzUFhQQWNaTTN5Wm5kdWoyV1IyWDVvTlpuZXNTTUds?=
 =?utf-8?B?NW9XTWYyR1lkSFlzRVBUNFBlOVNOQkVVUk5wOS9ubmJxNDdOcFA0Z0dyZzJp?=
 =?utf-8?B?OUpCSDVidWpMNkpCbG95Nnc4VWRMTjllcmx3M05DZkFwdThZV2lrWE5za3RG?=
 =?utf-8?B?bnhRbUpyRHhXdWQ4Qm11UGw3cDc4djVRY0hZTEdBQVRBdHFoK2t2V1FDWExW?=
 =?utf-8?B?TWFlTzNTT2ZRcUdoWFJNeTBWRlFZYUZrTU84OEw5bWs3ZzFaRlVhS1BtZW1o?=
 =?utf-8?B?dUNVT3Fka3dTVys4anBOcGk2YXdkYjIwZllpSFRWNzRSa3Exbm9GdEtDYy9D?=
 =?utf-8?B?WHNub1lTdnArcGIyQ0RVYTNiS1FFbWVCQ2hTbWpCOXFIeGV3aDF0eHBxTEdz?=
 =?utf-8?B?QnczM3R3YzJNTmtDUFlGRWhBREJ3eTFKSEpZQ0FycVA3VXlZalYvQ053Z2NB?=
 =?utf-8?B?RFVUdzRsQ2hyM3EwTklRa3dFV29zZDNucmRZWS9YZDJoVStZV1NXakM3dnVo?=
 =?utf-8?B?aFFFNlBJVVcrM2tMb0orb1EwamIwNkFxU0NnUFdhOFk0STgwOWp3Wm1KWVdS?=
 =?utf-8?B?NG9jaXZXZjFsYXJVSUVkd0daZngyS2kwdGw3UTQ3TGxmOEVSS1lrTU9Hb2Y5?=
 =?utf-8?B?RGp6aXlwRFphM2NQQUxQSlEwM095eEpocEFqMzlHRXdTM2ZBbDRKcjJKeHRJ?=
 =?utf-8?B?b2xQQU5Tamt5UmU3cnlSLzNxaU5XQVNkQmtnNG5FNnQ3elhoUzJJUmZVL3lk?=
 =?utf-8?B?MW83cmcrY3lReFU0cUQ2YnBpbitnMVA3S3VUZGpCalRZczE3ck83QVVhaGYz?=
 =?utf-8?B?VGVLcWd3aWJndjQ0SzNMUGpNQXhqZzE0TEs3aWY3dEZtTEU3c3J4WFFVUlV0?=
 =?utf-8?B?MHFiR3BUY3lNbUxmR1FVOXJvSzV2bmhkL2hDOWdTeHhPcW51MjlCRWNyczJS?=
 =?utf-8?Q?gd7Wx6fmZDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUxRcS9LZHJwbGdoNWh1aHVDci9QM01QWk8vbVFMRWxjNlBzZ1VaZUFlLzR2?=
 =?utf-8?B?UjdtcjJrc1pxdTRPSzM4QndUeUdJWmtwZGkwc0MxZjVkR0VFbG5LYXN1K0ln?=
 =?utf-8?B?MHkzcVlPbFNzSnRtam1pbElYNEJVRnRRK3VUTkVXOWVrazZHQmp4ZTJnOHNQ?=
 =?utf-8?B?WjRvMXROS1VJeVJibXNoMUo4SDhvT2orTkNpeXpMR2RSbXk5Q3VjOTNnM0M0?=
 =?utf-8?B?SXpKK2NiVU0xdzBRWkpPS2diRnIvc09GWW1kTklRejBDb2ZkUElQNVZxbGg5?=
 =?utf-8?B?c0o2TkM1cFBhRE16N0ZCb3JyVjNlbnRWZjdnUkhnbkhCbURqaFNtQW1aMmVS?=
 =?utf-8?B?b2hSMDREcldZdXRQSklnYm5mTTNQQWY2WHZXSTQ0N3NWQWppcFhEVFhEelFK?=
 =?utf-8?B?UFhJUHRMT0FGU3JzNTk2cjAvVGxiZE1XZHYyUVo4WHFKUFpYWHp1TmdKZ21C?=
 =?utf-8?B?M0VGWVhCNU9vVTlmNGVnTnpmNGtScEEzc25IYWVLQ29iaTNleE1HWmwxWXVP?=
 =?utf-8?B?WlNGN1RSOUFnMzExa2pPZENCZWo0QktsUUZFZ1kwYVpFQ1ZKUjA4OVp3dE5k?=
 =?utf-8?B?MEdoWFZHcjJnN3ozUHRJUllFSUwxbmYzUnpVZ0JVaUpQMzJtVURjeUxRQzhS?=
 =?utf-8?B?UjBoWWtybVdSOW13bW0ydmhMTlZuVlFjOVJVRzhUZFVGemIvOUFUcHdabC9i?=
 =?utf-8?B?aDQzb2tnZUFVTStFenZMUXVwKzF3bWFYbmJQUU9OMWtkS3pxZFdUaEVpbVRk?=
 =?utf-8?B?UnpudWVyMWMwVzhGOUZrY2xpTmlldlczTzl0RDVsQS9DTzVtU05zR0w1K1BB?=
 =?utf-8?B?MFEyNUMwR2JSUENMeS9FVllhaDhJQzNzbXdYVXB4QmxEamJWSS90OXFUcC9x?=
 =?utf-8?B?R2ExcTRlVTVNK1J2WTZVQ2svdng1VDFFNTdQVVZCeHFSQzErNWY5T0lEdmFu?=
 =?utf-8?B?YXlGWW5xZXBZMDhkZHRreUlWL0RUZzB6UUNBUTcvbHI3R2p5L2ZGNlhaeEhT?=
 =?utf-8?B?YkJ2MFlJWVFzWmNIQ2xkRFJoaUpqV2JCVVR4cnRIZmJOd2JaZ0pSZHNQaE9I?=
 =?utf-8?B?ZDlVbEVDUW5LbVpKMkVXbGdHS0lTeGIvdVdJWTdjaFpOQmxPZEJ3RTNiaWhU?=
 =?utf-8?B?R0pqNjFYaHBSaGRVeDZIYXc5WEU4OFhMWW9KYmhmUGkzVkZOZ0RDYTRHdWdz?=
 =?utf-8?B?c1prVmRJMWE4WU90d1k3OW12d1NqWDI4WHF4a2JOaG9BUlgzNlZtV25lM0xi?=
 =?utf-8?B?TGNhYTlBSkhFZGhPaHdxclpjM3VLU0RnZnRaVkFuOWQxTzBUdmd1N1VOYUdn?=
 =?utf-8?B?SFUzQWcrOWdxVDFyS1F0ZW1RV2xkVlMwVVp2c0I0T3VVY2JJS2tzRGNjZnVZ?=
 =?utf-8?B?WHRMTnZiem1VbnZpbngvaFhKOHo5OUNRcVAzd05DdDBYbUxiWGU1RzYxRG5R?=
 =?utf-8?B?TVlNbTRqMk9GdkZYQkVzTERPK1ZrWStZcXZMZUZrUGFYbXJjWXhVUnUxYzBt?=
 =?utf-8?B?L0FOTkR1a3FjNzlUenhqWU5jL1hDcGRGVFVQQkljblRGMFRScldYRHUwQVpz?=
 =?utf-8?B?QzFnY2c3NFU2K3dFaExIR1k1SmpCbmxUOWJNQzM3Z1JoejV6UWFoVXYyaGF3?=
 =?utf-8?B?ZVN1aG1ieTdVZG1lb3R5RFc4dFAzNHFQMDFtSlMxTVJXU1lvL3NhTGZudDJw?=
 =?utf-8?B?WE5Zd01SK29wZ3djSk42VTBpbENLM2pOOUlURTd2VGZnVkRSUnRTdXN1eUgy?=
 =?utf-8?B?QnlvM010b0NxMlZNM3Vsd2l1TjM2OUFtTzZUbWYxamYvbTArWTQ2aWdvUitT?=
 =?utf-8?B?WkJIZ1ZJME9pOE9pVGpJR3Vuc0wxYm9RMC83UXNDR05CSkZrbmpnMFlWL2VD?=
 =?utf-8?B?d2JBREFiSVdKbjlmL3NERjlCKzNUY3RHdWJDVFl4eFhMNkZmMXBzMkFUdWg0?=
 =?utf-8?B?VEp4WTFsdWlTeUlodXZCZmFuQTJMZVV5MS9CQ2x3RWlxbHpDRldkVzA0cmhv?=
 =?utf-8?B?L29DS2QxdTRzejhNem9zRElYaEUwNHNJV3ZRa1lRckFldXAzckU1SnpIN3I2?=
 =?utf-8?B?czVxd0lrNmhxMGsxK3lHenhGYjg1emd6eisxYnRHQ0VMYk1vYVU2N2hHekg3?=
 =?utf-8?Q?6CfyAysJknLoB+1MgS7PqHYGt?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfef1b6c-e23b-4adf-a280-08dcc734ce45
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:41:19.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoHdBJhJwJzdUsPP6QPHBTbSgFOo2A2IImOh9BmVCMsUYsvMeqjmrkLsKgmZ5218kke928BZ3UYh3U+NICfFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values that will be
send to bus when error occurred.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 +--
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 ++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 29 +++++++++++++++-------
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++++---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  3 +++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 20 +++++++++------
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 +++
 7 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d35262335eaf7..17f6b33beabd8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* try to attach to the target device */
 	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (!sdiodev->bus) {
-		ret = -ENODEV;
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
 		goto out;
 	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..58d50918dd177 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,7 +561,8 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
+		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
 		brcmf_acpi_probe(dev, bus_type, settings);
 	}
 	return settings;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f657561056..c1285adabf72b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,18 +66,22 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
 	struct of_phandle_args oirq;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
 	u32 irqf;
 	u32 val;
 
+	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
+		return 0;
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -106,7 +111,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -114,33 +119,39 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
-
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
 	of_get_mac_address(np, settings->mac);
 
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
+	clk_set_rate(clk, 32768);
+
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+		return 0;
 
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
 	if (of_irq_parse_one(np, 0, &oirq))
-		return;
+		return 0;
 
 	irq = irq_create_of_mapping(&oirq);
 	if (!irq) {
 		brcmf_err("interrupt could not be mapped\n");
-		return;
+		return 0;
 	}
 	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
 	sdio->oob_irq_flags = irqf;
+
+	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337e..ae124c73fc3b7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,11 +3,12 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings);
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-			   struct brcmf_mp_device *settings)
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+			  struct brcmf_mp_device *settings)
 {
+	return 0;
 }
 #endif /* CONFIG_OF */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e90..190e8990618c5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2452,6 +2452,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1461dc453ac22..59c77645e2183 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_buscore_ops = {
 	.write32 = brcmf_sdio_buscore_write32,
 };
 
-static bool
+static int
 brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 {
 	struct brcmf_sdio_dev *sdiodev;
@@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	u32 reg_val;
 	u32 drivestrength;
 	u32 enum_base;
+	int ret = -EBADE;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
@@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 						   BRCMF_BUSTYPE_SDIO,
 						   bus->ci->chip,
 						   bus->ci->chiprev);
-	if (!sdiodev->settings) {
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
 		brcmf_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
 		goto fail;
 	}
 	/* platform specific configuration:
@@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	/* allocate header buffer */
 	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
 	if (!bus->hdrbuf)
-		return false;
+		return -ENOMEM;
 	/* Locate an appropriately-aligned portion of hdrbuf */
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
@@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	if (bus->poll)
 		bus->pollrate = 1;
 
-	return true;
+	return 0;
 
 fail:
 	sdio_release_host(sdiodev->func1);
-	return false;
+	return ret;
 }
 
 static int
@@ -4452,7 +4454,9 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	/* Allocate private bus interface state */
 	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
 	if (!bus)
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
@@ -4467,6 +4471,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
@@ -4474,7 +4479,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	ret = brcmf_sdio_probe_attach(bus);
+	if (ret < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,7 +4552,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 8afbf529c7450..2821c27f317ee 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);

-- 
2.34.1


