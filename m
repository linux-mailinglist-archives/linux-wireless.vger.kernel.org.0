Return-Path: <linux-wireless+bounces-9405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C18911DC2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A03287BA9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933817C7C6;
	Fri, 21 Jun 2024 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pJrAaHch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EA17C7AB;
	Fri, 21 Jun 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956494; cv=fail; b=a78n9755VEbNrHmqsDSKzJ2b/GTzUuZrDCx+QolZMRQvtbD18dgREkQAXN7bpe+SRuckkILji14s3woV0lfr3BEUqyCK5XWCrckmAf0+rw9//6O7kGx5+zxzZ2fGKmeYAfs6qhsUiv8QdSmY/7iPLyEcuCP4Wx+amK8BECZU2JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956494; c=relaxed/simple;
	bh=n17QDADJXrjc3wuFOUIEeEJWZL+PpjoYbwMv0BO0H3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFEVj+zR3Ysbx5yAm0bYPuz5v3IpxkEOBjCu5IcOy9IBc1Kp/xl1QLIxUla8CTShLe9IKfQwHKPTXFfAk2E7kfjMzQcNQ29BYnKmci07EyyTkSUMz8mQCW773XNGQn37GiHLF6dt9/8dBoofRO+dcy3wtuTt9K08v2GcY1VcnlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pJrAaHch; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZV2AqoQrW9xM+65tgzdMDPGn3Np8JvvKzrbe/x0SuXHsomg85aIkRWCAJTMhRze+YsOi7dZiJ2FuqnSZ6zjDtI7qOIa5C8oVn15Y5q25zH9Y1y0hZm/10v9ju5PHGLonv+LYE1H3hHRWWvl5KLdfrrNhmvaNt/8CGNDKwnpN/n1x5Wbr+KvyLmbKiQAdNObTwzF2TSVQtSkGKSugvZWhjKZf/VJn8EigWwY0Wf/zgECu2voSu8jCWXdWUWQXJI2rDKJHAFLYoZtxJjeJHTVqbJCv7ZfazUX/q3qw4+0cDiTgHzvcVh/D+SesSy6kMAIzgGE+kE13xFvAqyy9f9tVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7MeuOgQrbSP0BuVj0rjMFxdtU8YgEfcffhYnh1ojkU=;
 b=dL43LMxs3J9ScDLmRbCIzKS2Li//wE4WeFzp5RHZsi6BTSk6ZAuCdrwCgdrgkhJQc/Y0SRZqtcKEZOacfa/vdOTmvKYPRo7HXtuDENUICM11moZowGJUEwX5Yl2n+ZV+fn8uerv1KzUUKX7ZxsC0FS3pnMfK5HPivDvRL953Y0l9fZtXo6qoG8P5j+8Ckc69gr+tjQYY8UI3fFKePM6jsFfV5u82aQrnFEDakHx9jmtHP23EC5bG0axYPhfg4G1fin1xE2YmvWONJhUX8G+x3hhk48XnT/HxupcVqCC/fEV+Hzlur2ilN8cV8jQo/rv5JBTgru9s+kEKJyMelrY8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7MeuOgQrbSP0BuVj0rjMFxdtU8YgEfcffhYnh1ojkU=;
 b=pJrAaHchrhzxM1xLNyzs0VyMP95dyIsnb5hXvODaylX+7RE7tJkxyosKgVt1Iy5gJdNfGHvNT5tXG7dakG4NwpZnSh8ksfTLTccRMX0OBrifG0GL22kfPtmyzL8o1dOYY+lt0TE8biFh+RhFHIwbtPLYfFM3/mcJqpi77P1vwoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:49 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:49 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 41/43] wifi: nxpwifi: add nxp sdio vendor id and iw61x device id
Date: Fri, 21 Jun 2024 15:52:06 +0800
Message-Id: <20240621075208.513497-42-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 49007c16-0564-4ba5-5a25-08dc91c76c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P26wOFSNUr/S4E+3uuTNO2RFqL//kvNOWu0cd4zAh2KqWSiBBWdMh+PKnOIW?=
 =?us-ascii?Q?ilAOxtvNdhOP2ZcSeP48IhItChQzy47EPqs+r6TRhNMYc5M8vxzY6vdxwEHC?=
 =?us-ascii?Q?owNvOmTCAj8slRXcpG9HTuZ3PzAVxMt97YLYOxHjZImlaFGbgnU/mwwt6/CX?=
 =?us-ascii?Q?ypHJB3W/IU/aM7nipjpQ2vbyEh7oE65SjNSv3+VMHaeNJegrD5/cgGzqm7Bx?=
 =?us-ascii?Q?sQB3IvfgAMjhg5rRto6qpK+cHRzZZt9l2F1xYIqZxkFaj2u/QCpEBp70YHDC?=
 =?us-ascii?Q?czm0xzgQ3+hhemeCPafnf6tQwiMqvq+2LWLeDhcFRYH3WbKKPX0v4SqpYYSy?=
 =?us-ascii?Q?LjFkjYBW8D2A3woMmfQG+9JaOkjuQ3sJKjwCFhEMKlY1xvyJaFbciWWFQbjH?=
 =?us-ascii?Q?lofLcSdAve7WcixcgRUWJxO0/y0gsvFkuxv7ZGUwTIeokAT6G/IIA69JclKB?=
 =?us-ascii?Q?R+pUcHQfSq34noqWw8zuaRFixigHbIwOvWCoG3wNgI5w4rtg9PJKTTt4cJzT?=
 =?us-ascii?Q?I4GrAVAlhJCOuXnviPmxUDYscumd609XFWaalL3dEnYFhqW5fpQX4FHXWkQk?=
 =?us-ascii?Q?bBXiWf9uq/kKV7dbhLWMHBX3ZSS+uZuaLktaZoM4ZcXzUDEM7+tQREQvhHHb?=
 =?us-ascii?Q?oHNZbHkNO4Rb0FnPZWfq5fsyQI1DeCO4mS/bq4i6XpY5ZFIdnPLceZtEXgii?=
 =?us-ascii?Q?n17Axh6kX/SvAffDkCaNyUyoINkTERajgzrHFNcg+g6JKZZZqNqic5ef74eQ?=
 =?us-ascii?Q?1ZyiLiGSkInhkJAPMPRIlfnr9KNoIUDyujUsOZNHaB0msLj6uSD0JIaO0yy8?=
 =?us-ascii?Q?2jpkswphESGV4btoeoetsn6udxxxYjqM3FIa1sh4J8IQ8pRjir4vWV/vWPtk?=
 =?us-ascii?Q?jYI6UxAjHMQUM6f7TVaWb3uiZ9SeUYt+ABfULl41Iz9txRXHqIz82jK8Ka/l?=
 =?us-ascii?Q?NRh97TWdbHUYLvBLPVoF44UIWa9DsSQ+M8WWohRUkw9h7RoeoM7tflErENDD?=
 =?us-ascii?Q?yKy5RCBWFAIm5IPIAgQNUbevBlAJVyM2NYgi5brTCccSZs1AxDBxNXZ37XTJ?=
 =?us-ascii?Q?bpYXK0pERHXCgbGYsjj2ADBeLpWFrsKmXvv4Q4JVhNgbr2pgvVEnDFSfejGP?=
 =?us-ascii?Q?D8ks/shs6x+tnvm274Oisw+u1SrOpJ3CwOlBDmtHiv7ieHJ0IKpEP/dYY0kV?=
 =?us-ascii?Q?cZUeTfUbUCnFizprgfVzE7MtbyfkBW5zwYSfwxC0HdgPzV5KVl9g+yM0uKxy?=
 =?us-ascii?Q?+RYgfC+PcMEaCJxhMoofFGhA9shMND/a4MrqSXCKrSSbiXH1ol+fpPSIkz0R?=
 =?us-ascii?Q?Pmn4f/cA6rXTvCgl6ddVhbTHvjXCvPAu76HH7sa6q9TKBOaP9RwWtNjUtbkY?=
 =?us-ascii?Q?E2v9HBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9IX8oTw6tVRTbyuXg4EDaIdECW+4IW75cOehRBXheDU4dyiYBVAUwlxEgKb?=
 =?us-ascii?Q?phdAuKeLCpR0/qVYUxzbC3bcU/QJfP47f4NDwdsPfTjTSt3isJDOWEppw9uE?=
 =?us-ascii?Q?lyRIR9xbT0kQWS9uqcTgVmDFMcZ/7w1IbbvUHSE4BOdi+KiZGOjesCjB1/x8?=
 =?us-ascii?Q?P3/PkXlATp5PkMC65iiDgQI6o31U/HVn958TjaV1YyxnYlP2E9TfMzMXgiyR?=
 =?us-ascii?Q?n6X8MyRq4KkdxcApyJ+1E4RW68tq8hqCCZ1ltm3MclQV4nmLZv7Kk6DuyMv2?=
 =?us-ascii?Q?lBZyFXErjwxKBFle8/iX8+0gZQ7QCCXhkwNjfPebME1Y5cT7+YqywIlp7grr?=
 =?us-ascii?Q?xRfM63qjmVqc5/kfjmt0ZuEqDzPPDWdLqVpTTncBrwK8Ws0JOKdKR5vUWjmK?=
 =?us-ascii?Q?ZESJ6ZiXgmtKJvkamM8u8rSdVntX+ysylcLuomd71/kRUj4WL1AG+lPY3WvJ?=
 =?us-ascii?Q?mEPTKeSOn8P1Ef0A4hUOKu8NM878DI3QK93XpE6dhfK3GP/EXQk9zKq6Zv1b?=
 =?us-ascii?Q?TQAL4/Ih5XvSydtHc70iCI9t/3YG/bySFB6+2xzLLLcJmWpvfcamofu2vwiX?=
 =?us-ascii?Q?9GPjm8jm1lVGPH9Pl/Jg/NgMKEq7ALTVyi3U++pL/NCHidZrBw6Y4s4+uugv?=
 =?us-ascii?Q?0YpJ/n+f3bPFa/NK0DMU8Gc+4Bv+WN6hb3gQyt5kGlU1ce/IUaujAtjB7T8x?=
 =?us-ascii?Q?bWGNJ2YBHAvgiCu/lNJ1X/mzcBhAVIb0N9xyIOoVlfU/+EzqIqbTBvdJDtAG?=
 =?us-ascii?Q?I0WXR9xgfkeb3qYkabupk/GR8uCs8JIjWiH6+CoK179nwyY2nc25HphYtS4J?=
 =?us-ascii?Q?oDYX4NFfcCmBy6RKO0AhVvKSSoi3IfvsmTzO6h2T+4hSsCb3TK0hPznHF2+1?=
 =?us-ascii?Q?gnCHkLt0VMLw88zN+9Hqy34ZnjTg5RjBL+zwbboRTs2g3F8Qtgj3iC9g/yvS?=
 =?us-ascii?Q?/Cj8IliVqJOC3ohIUxYHPQKWTqNSVP/pwIj6G9+jz5UGYM4J0977GWWS7wJf?=
 =?us-ascii?Q?zsNNrNQb/5DaLdwzp/cGsvuMRcFb+NveKhPO5Afa+H0f7euWsKu5peoTND1/?=
 =?us-ascii?Q?BKdCMffvo8RQMb1HKGQpK6chP7RcSvwhwR97tufLYlBpL+md//MxVus0OZXJ?=
 =?us-ascii?Q?KnQ8fdRR1AOjBlZlRTPnj5D7h+YEcP5F61/fw+cNPR6AyyE89Mnlv+j5eOaZ?=
 =?us-ascii?Q?aDi5DOUH9kBUEtcxR8EhD7rSCN0eAZdH15xJ21GvDyDOgxikydbQwbVOfYUH?=
 =?us-ascii?Q?quLd2n9vhFHdCn+DPV+ECjIb6BlbIMQUTw+zpKSroj24cvTFXW/s7qUr4AeR?=
 =?us-ascii?Q?a+ItMInhnAWS+HFhCU6jHN6I+wGtTEDKrqBaHcafxlky0DxGJtl/bXwRS8Ni?=
 =?us-ascii?Q?pEYpCsj1CJuPFDT7ZRxzQRBt5vunc1Y8tfCtWbgR9Jjw4arGkw/+huShdeGt?=
 =?us-ascii?Q?nzo5Tnu5TONBPoS1gVQdaEPC9rEcLGFowUbzzPVKRrMQ8jzPFZ60xJc6V50p?=
 =?us-ascii?Q?PyzyudBTzxw8XRja9+vX5KSGf+Io+jcH1pYFKd5WPDV7n0TAtALgXFtSX6Kb?=
 =?us-ascii?Q?MJSJLxx6s9eQ5UJ5cUMnZynLxuHG2ac3bKLBTeCF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49007c16-0564-4ba5-5a25-08dc91c76c72
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:49.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmmWHbVuJchHdgNnqBNNFsMJM3GfLRuH5COmcsyhr6qc9Str/+pIZIvaOZGa+opXv1wOvflqlA/be+cRphV33w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f57..8446841d62ef 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -115,6 +115,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1


