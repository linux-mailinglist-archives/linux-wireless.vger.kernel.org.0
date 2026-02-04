Return-Path: <linux-wireless+bounces-31569-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMYYMFeLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31569-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:09:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF70EB6F0
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84D88302578F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90D43635C;
	Wed,  4 Feb 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DIlPRvWU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5042846F;
	Wed,  4 Feb 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228364; cv=fail; b=gMmulm5BlGg7J1wnQxqPQQYiZWb6+m8yrtBQmflkQ/JCPSyWSPsXhERXYMQJ6vsIuJMAQwUDGYEFIGjexs8ve4UrSh4vE5MPARnMf0N2jm1MJl5UuhFOJ8giGZ/6s3Yh1QbcSqnRaFQ/L/xSL+E85as+Hzyr4CzsBnuptUt/aro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228364; c=relaxed/simple;
	bh=rjFAqmGAunq+A2rVobUf29rfxL8J2FaKZJh3XTvufAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r207TjxXhZ+CkLk6g5zi522bmIVHNFA0Mywjpa3iIT/vr/1poE2kpmwIIAtRKDlLizo81Tk+LkroNnLbNqEgRugfUTAfyM26FcClF57cTmuD4SUsv1lf2Av24kvc7PUnqVIIBZUEXo1E4u5bpqeikmqOmcV4SvlF2vpNxPlXSg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DIlPRvWU; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxk+0DoliBmzDIZa88DzyTIgeGajeDwSN0pfh390LrpD3PKOr+6iwb35ole4p0nDHV1rDC6ymIPfH83vHX6p3heqehbSRFV/w5IIKHbJWvsNUcrMfg71zZ7SBOTv5V/N0upftbOe2zZCkoKXxoLGINitRhNc2KZ3luD92yMi5RCB9btiU3EjWtYzhvb99xK3DSQxqi1db0zeEypbWoMqrhAD21AeU4CXmK4svMMVIZ639HMplZKkpkzD+pcEMHdVrd4RAfPJJRuNoPPSDraQ/flUoC4Vb1scXiSEOTRH5j2cSGyRvXDBV64cC+Wcn1vYij2JMTZzx0qsMyXJEPeChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=RmqM9edeDe2ZZ3I6nzUF4gnT+P7peRPP2bU5c/QzSo7DPxV2cnvTSlxoLnLPGX8vJ2TCUQV+JFjG/dWmBdBoYN/a2vWcGVGhMXd0H+TdVb8tD3cx09OjNRORxmryLy3YWKn6B+5T4VB/6pcWvBSPULbHKwxZQ5cv7oI4LDV7JrpXcnWBWtZYmM5mfzyoAomo9GAY+1RSPcGBTHe9bksaSl3/qCmg5M+uk3Y4bvf2S1TIzh10m1bG0r1SwneqGX8XgOFVfhXz+1nzLJzU3puZHm8hb+UVeNnWbFHVvk0tkJaJhyZv+S9MH40bcqQLiqxAjOVTL7Q+DkHDrRlrVinMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=DIlPRvWU+QV7JgZum3WR0JECBkGiBAmWXypY6ofkg+UWODJzZACtKUGeOQiShcxHo3WZ27bZmnYE1oYdOFW5d8SWGvBx4yOIokPaZ/f1+3LX1zFHzzSYJsq3FUw0mOJL082nWd/P05XJz3ll48X1o65xfeuKnnajz8pMUsxS9ycgDfD0vuRdUjie+h1DhKO4teqX6iPgw8sfq8bugsyxIjui1mwu4jXkctILDw19Stf8U3dLH2xzZDZf4rY15iDfkZUoi5notDjtKHNeMMCuvYzca4eJox2PbV6vjK+ptwfb/xenMtkrCIUMbitN3p4twX2pM+09vMm5D1hcyQB9kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV2PR04MB11980.eurprd04.prod.outlook.com (2603:10a6:150:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:06:01 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:06:01 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 20/21] wifi: nxpwifi: add Kconfig and Makefile for kernel integration
Date: Thu,  5 Feb 2026 02:03:57 +0800
Message-Id: <20260204180358.632281-21-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204180358.632281-1-jeff.chen_1@nxp.com>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GV2PR04MB11980:EE_
X-MS-Office365-Filtering-Correlation-Id: 728d029b-f9fc-4069-d0c1-08de64180ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1FaU6cm98KvmGBBJPmuC6te7U6GNXWpuilOzWuHjlWaQYx+4J0Z6dQYxq61?=
 =?us-ascii?Q?bWKKmrmurG7sHGbIcQbLTmpkqartb01MykP+N/gcCo6P3dRk18bbPeigOWtA?=
 =?us-ascii?Q?HFVHWV9jCHae9VCIhL+c/szEBIKI2yy24zrbzydRE2RHCT+9TGNjn0oDA6SN?=
 =?us-ascii?Q?kUkzx7GJqvmobl+brJFonF1xtGAsjewTkTTWecEEvPoSteRaHwjNFUsM9fYr?=
 =?us-ascii?Q?tBhnRTmxE5mLt60sCbELpgEp2T5JuQMu4EeZ3GQix00gIiCZsVYJ1Chp5EC1?=
 =?us-ascii?Q?LVe6NVqwrRD+W1e2CBuOjNZ+TW61m5aWnePtpvPpEmZkJJDh4l0QZYZ+R6Gr?=
 =?us-ascii?Q?O6v1h8Wk5AXO5KFrleeKtKi/f3i4fHpOT5zVuk47PVE7YzCHzJA3s/+DwYEm?=
 =?us-ascii?Q?NIfF3HzS5G0jeVrSwPY//gGY2mrofgSEPx1Cw9fGsLhWOHnPuY+dMpPw6vj5?=
 =?us-ascii?Q?GfNBSQq80ODnI/ksRm+JaDBWEgLsXdKk93oAapodLwvVJ4hGNA2E8RcoKs8F?=
 =?us-ascii?Q?PT6Yr9pkN/Ctw0jfgMjji5dnYbfZcjaHbTMWfby373X8xLNo/qzbnS0sdSdw?=
 =?us-ascii?Q?JkhwCIgOFiLxSS3KOIYU5TYHYbF10GU11/empCyR6rGPM4vHo+qhfuxOHDVc?=
 =?us-ascii?Q?AFpnasrP3JKflRnN/h7Jr2yu7cqO70jjjptP0HMJJZZ7NYcI8JwuWcVI3KEO?=
 =?us-ascii?Q?Vo8KsXIm1XacYb6EGso8JKBUj3lghNoWDI+ssShBAAUwfz5bWKPfB2aX1+vm?=
 =?us-ascii?Q?94VC2kjNB3RTixZ7ofnKDD8+SZp4HSDUmh/f1FtLTH0hyIwOTJmOxawNazLT?=
 =?us-ascii?Q?gK5ncBev7lTQKST9EjxuuN/DKBLP7Y/jyrJ8UzKx5WDV5ZfU0GMVD01+WIGp?=
 =?us-ascii?Q?pIqSlg/95YJYY/pacn+cybm1xZjSb2VfYg+E9hNWgz/xHzURyijWdRG5ssXw?=
 =?us-ascii?Q?PIJWz4wb+GxpSUzfHh8P07S4DKDFC8s8YNdTjA6BdDpNEFhcMhb/C3MoMmv0?=
 =?us-ascii?Q?gJiRPizBzk1JNIyXptHCwN0zM6KAMIK9HhAZz3keFqtNiYAanA4EW2oXtt4v?=
 =?us-ascii?Q?2M0xx2BIby6ZNHNgJV9A9ajE0gvg2TN/nS888GIkhvAU0DGsc2Xql1Qizb7r?=
 =?us-ascii?Q?XE1Nh1bcSV/VaEWlDjwXcJLE7uJVR5JTvaA6Y8BChfIJnzxZB8L3W1oX2O/H?=
 =?us-ascii?Q?k6ZdJFc6mo649fzThi49xqSjJAu6Aix8CNsr25iNsgS1HLhPISpAim90MIV2?=
 =?us-ascii?Q?Znn4gLwALqvKXAxxaBkUw2TgO3Xf4kDrDcF3Rep+lUZGq9zUTLy+DqxPd61U?=
 =?us-ascii?Q?HVe4MJfOfcaIQ1XDa43MqsovgL/6Vs/Nc+vSaSfcnrOrMfHDlXiLtobF6pGi?=
 =?us-ascii?Q?U5MDjXWC3oNwLlYI9zoCRSuJC/LfdvSQNG5vcnaph4cB5rHCDD+dglAHTla7?=
 =?us-ascii?Q?MIqBmLz8H6WN2bO81BnSxa1Se1tWLGOW7SMEO36A0VaRM9EaBK/Ao+P8DpiL?=
 =?us-ascii?Q?sKZ6A1gOwU9RbcfnbZAnr5VT2bzKetehRXocy045kmnu7KaRKjNqEJwvaUvn?=
 =?us-ascii?Q?UIOiHU/s9sd5LqOUIKFVR89nCW41ljZPxha+WrcpzRzKbHs7DOaPInIdGyl9?=
 =?us-ascii?Q?nAI9tVj7TKwBhAEv8ympjdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qYv6RlWEImp790lWEkmUh0P04aGmkjEDt5y69OS4uSXQChkKBcxTAMHhHi5D?=
 =?us-ascii?Q?byodh84FbEdAo/fuhCOp2DiRL7UDKlSuujsaLXT7G65phQWBWSjPvra5ANb2?=
 =?us-ascii?Q?MuAv+GQ4uCTM/ZdT/cHggIArqDbEOG7mtzQ0qMN7rfPdIKTEd7/gIDU7QWAg?=
 =?us-ascii?Q?/jqR7ElYt8svGgF9p8p4eDybhgTE16qOLSisoEFlBSg3OdHejKsqpNJ6qANz?=
 =?us-ascii?Q?RQCR1r2DOwmtDGhJ6ilJu4RC75WZRPl+0hIMaZicJgNAKE7VW+QwSWhcNu/r?=
 =?us-ascii?Q?oIK179bhoV6nIyzchkNwwrrgT9LVWeJ6wFZiJ2etk2xjxZtbe48/WGQ1Jpt7?=
 =?us-ascii?Q?s/s/jbJFdgzGeif8LRWhZRXjM4d1Zp/XVYeLaYjTP147TKTLd198crCEAG0j?=
 =?us-ascii?Q?6fzeHEArjGJbhcrtyuVG/ytmmhK+B/hekQbZ1TU67Vv3HWgZvF+fFuvS1tLJ?=
 =?us-ascii?Q?AGzt45oMqKrSri1reJCQeOhArYs4f+Wrsb0uXL+OFYCqyEQf9Q+i/MgWcAIy?=
 =?us-ascii?Q?eItVtR974wQpSwLfN/bOJyv3KvT373qmNSnWBdrByBVKUgGuGblD6i/fgk7D?=
 =?us-ascii?Q?VTDtPAlnSpKINegS065+/5SJ4bv+GOWvu2xtG03U0yPkx81ms9lw6Fc6DJzg?=
 =?us-ascii?Q?friabeJvwlxUQu4nZ0am6/IXdHqddZwLVcrzdOiqtthZ3UGq3UaI/PBX3QJx?=
 =?us-ascii?Q?tKuKnKVRl6GT5+kr5E5EpXXLLkGKqR/Eo5o4G49XHnP7yP3ro+uxqGwT69dP?=
 =?us-ascii?Q?zx/E4ZfeFtgH9BJp2318YHsmHpRwnxrtyhOfY/tbjGacrt+0FP8Ppj2LBCqf?=
 =?us-ascii?Q?e7JG2zXHTjMTSR7JXyadvR7hMdt3HBEO6ZrrIUE8UIDn//r5LhMCtu44A8zy?=
 =?us-ascii?Q?cBoCOXnr80xu/vnjj0Fk1Y6UW3LavP8NcHjAF5fLRlKWNx2MViJc0ZPVVoH0?=
 =?us-ascii?Q?lbe7jtCkt+1od4gU7NgPVIAuKEZMDNFva3gY3NMBZihod7HwO4S5tDPhjFQf?=
 =?us-ascii?Q?pkM3LKKtZcmvMZanvPGwcfMspuX+taAp5amvD/D0uosE6EmdkRKv8OXfc9su?=
 =?us-ascii?Q?aKX3ESlKUyqT9eeNkji3ilE6571JYh5wVM2QiDu8tKQTZdNE+rrnjkaTY+cW?=
 =?us-ascii?Q?jlIZfe6H9Fn21Ckf9SE+j08r3VJCEvOmyjJ9/ko1+zfYc6UNBBDp6yck8sNU?=
 =?us-ascii?Q?4rgT4Db1kbWzmgBGynq1bpnoRbDC8E8P7c5kcmMg5RTm1MkGSV56yp2kbDKI?=
 =?us-ascii?Q?zpT+oGZL79xnJvBsrQF7Ih5seUSJhDDI4rbwZ8xLfJYP1cKCg3zh+dbGK7LF?=
 =?us-ascii?Q?9qtdKEmMfw2GEO/GfejRGFkApnctai16mtTUUE2nRYEU/GJoTfgEXv9Toqgz?=
 =?us-ascii?Q?0Ed4I9gYByJDe3ao9+WICEK0TChfuYutaROaLG0utnYvouDqxYczI9NxHfPJ?=
 =?us-ascii?Q?jT45xhBhtVS5TBuNm4OR5P5eKq7c0EJcxdu6R5O+yHZJdcUyexWPUJZmALrn?=
 =?us-ascii?Q?nYpg7HzbOlnDaKXLcKimKdfBjP4YwGacYT0A6fGnf+PJKytxMAUmxOErgDY3?=
 =?us-ascii?Q?X9wZDg4QOxQDzRcaeeUdphmlBEfL6XCKbhXYRXSmjNF9P1uabmfgEFEUVJpl?=
 =?us-ascii?Q?gx695XOlX1CdcNn82F20HO1UvNZMd5EMhILnDtaE9tzbsN0O+UYjHEMoBLRg?=
 =?us-ascii?Q?P8R2ABba1f0YZ4xdAnNixVCusjIShSvpCK8CGFKT4bRfyW2vmfkzwtpnzXIu?=
 =?us-ascii?Q?yOkYoppy+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728d029b-f9fc-4069-d0c1-08de64180ddb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:06:00.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjO14VvGt9+g69q9biDGND4AIUyOTfU3oF4O6mB6GVZ0j3N+Pmju8f54BrO9amdktTMiESQL1L6IMzfJa9oOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31569-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6CF70EB6F0
X-Rspamd-Action: no action

Introduce Kconfig and Makefile entries to integrate the nxpwifi driver
into the kernel build system. This allows the driver to be configured
and compiled as part of the kernel tree.

Changes include:
- Adding WLAN_VENDOR_NXP entry under drivers/net/wireless
- Defining NXPWIFI and NXPWIFI_SDIO config options
- Creating Makefiles for nxp/ and nxpwifi/ directories
- Registering nxpwifi and nxpwifi_sdio as build targets

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 39 +++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..4d7b81182925 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nxp/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..0c6b3cc719db 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NXP) += nxp/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nxp/Kconfig b/drivers/net/wireless/nxp/Kconfig
new file mode 100644
index 000000000000..68b32d4536e5
--- /dev/null
+++ b/drivers/net/wireless/nxp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_NXP
+	bool "NXP devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NXP
+
+source "drivers/net/wireless/nxp/nxpwifi/Kconfig"
+
+endif # WLAN_VENDOR_NXP
diff --git a/drivers/net/wireless/nxp/Makefile b/drivers/net/wireless/nxp/Makefile
new file mode 100644
index 000000000000..27b41a0afdd2
--- /dev/null
+++ b/drivers/net/wireless/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NXPWIFI)	+= nxpwifi/
diff --git a/drivers/net/wireless/nxp/nxpwifi/Kconfig b/drivers/net/wireless/nxp/nxpwifi/Kconfig
new file mode 100644
index 000000000000..3637068574b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NXPWIFI
+	tristate "NXP WiFi Driver"
+	depends on CFG80211
+	help
+	  This adds support for wireless adapters based on NXP
+	  802.11n/ac chipsets.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi.
+
+config NXPWIFI_SDIO
+	tristate "NXP WiFi Driver for IW61x"
+	depends on NXPWIFI && MMC
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  This adds support for wireless adapters based on NXP
+	  IW61x interface.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi_sdio.
diff --git a/drivers/net/wireless/nxp/nxpwifi/Makefile b/drivers/net/wireless/nxp/nxpwifi/Makefile
new file mode 100644
index 000000000000..8f581429f28d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2011-2020 NXP
+#
+
+
+nxpwifi-y += main.o
+nxpwifi-y += init.o
+nxpwifi-y += cfp.o
+nxpwifi-y += cmdevt.o
+nxpwifi-y += util.o
+nxpwifi-y += txrx.o
+nxpwifi-y += wmm.o
+nxpwifi-y += 11n.o
+nxpwifi-y += 11ac.o
+nxpwifi-y += 11ax.o
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_cfg.o
+nxpwifi-y += sta_cmd.o
+nxpwifi-y += uap_cmd.o
+nxpwifi-y += ie.o
+nxpwifi-y += sta_event.o
+nxpwifi-y += uap_event.o
+nxpwifi-y += sta_tx.o
+nxpwifi-y += sta_rx.o
+nxpwifi-y += uap_txrx.o
+nxpwifi-y += cfg80211.o
+nxpwifi-y += ethtool.o
+nxpwifi-y += 11h.o
+nxpwifi-$(CONFIG_DEBUG_FS) += debugfs.o
+obj-$(CONFIG_NXPWIFI) += nxpwifi.o
+
+nxpwifi_sdio-y += sdio.o
+obj-$(CONFIG_NXPWIFI_SDIO) += nxpwifi_sdio.o
+
+ccflags-y += -D__CHECK_ENDIAN
-- 
2.34.1


