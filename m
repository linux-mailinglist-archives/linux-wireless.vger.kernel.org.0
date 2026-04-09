Return-Path: <linux-wireless+bounces-34537-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aESZHqYb12ltKwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34537-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 05:23:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A633C602C
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 05:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41108301227B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 03:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C290A36CE1E;
	Thu,  9 Apr 2026 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MtMRLSR0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700636EA8F;
	Thu,  9 Apr 2026 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704995; cv=fail; b=IJn/6hQiv5tVZgMXlcBxxDlSsP08+uho7hiZ70mu86kJkG3GXKOZhK91DUcVCeqAK2ZCZyLG1BzUlY1si+DdO7TTzBW1fgQJYYtvePEIpV+E3/+KPWnDTm759FrLvmuC/EDOkZXNBfEsneAIvAMp7Z013MVrBpDVTpI9sgdAxsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704995; c=relaxed/simple;
	bh=Zc3EIO1vEp4v7syYqnkd8S7Jrx719jlFW838JgiCJlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gcWozXMMcza63c0hYt+aC23Gy4pFlgfEP9Vf1ObEFuthbb6MV6aZF2bj9tkIkwEfBUAnd90QmsWmVotx4qLOSjVSkgRmxHfJYOXHOziN7ya8AsEq4xbjvGSv+bt6lzXJiht0HOmqxgPyBT4F5pck/ZKh6gqrdAjuuV3imJMVvWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MtMRLSR0; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmoOaj6fArG9kJOn5KZqDsFm9Yfd8v1h9KtM8g4YsjoVvP7RbidrRrYShLj/RjV1HcLswEu0XWJ9u+gr2JGxfvCi9XBYLoGA+LGk4VvCBk+lKPY9VwC0KIWlh+MlcBC7YaHKqP+zxF8K74P9rnvHRkVGJIHLPgBd5YM8G/2cgP4nhoB6n8g4Vxj/DRbeApB8qMhMCwVuImA/kvIHyFRIXqFzYlGC23kjyl4zdWUFjKLljzeTpXh432qUmt1t62pn/Vy9/htsP//mBzmEwC0Ke618q79xkoLE0r2bgPcTQqFvwZwCJvCTL0dJzgSabamNGtk9ZjQgDFMAgHiarR7Lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRAFg+td2RP4Hn5Bkj9bfpxlNf65ByMGp1KrdBDIpt8=;
 b=cAx91lWD39c/z/cFiHDx4PmTMlH3fe5q3RrygwJ06IhaxOlSF8dgnBxL9J99lETDPihad4RhkYEnzPM91tT9F310Zo1iW3Sx6kiSt8gheGVaBtjwmGxPqKQst36943+ZBdv4RG9yYDK2UVGNFaJ9o1xqp1K/s2r+u9ohwM3H+HhHO//ySFcX6GJ7hxmHUzB1L/gID+bAl/X6dKbWQAILhGeX/VTQH9ByFU11DGX6WR1Qhg96TdRqhBdp0zs3oRElTx6FRZtUxBd4/a58LsqrBzM2iknorQk1bdYB6vxl4tmmwKWKn5Sxjzs30UBpy6XQOsC0xsxTJeNBZx62gmpQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRAFg+td2RP4Hn5Bkj9bfpxlNf65ByMGp1KrdBDIpt8=;
 b=MtMRLSR0iMd5cg0hU5tbauU6ewQVCxNuoZRI03R80hmyzi9YBpVK57pFDyVN/kzwUlo/iGyK0wI0rbeYSIoMmhTNeQQlnsE+pJneQ7j8COn2PZtOccW94WobtLZ6wRbBhhprBNhnFaR9ZsvUFE+Dh0dBfG6bijhcY93sRq3PzLLcHdtqVhdoGCaBi5n8mg3MviDVCTGb6E/f2nm7No75nfOK6ttiLFecw0q5zVac2nSBgEhFX8dzqn1aCwJTXxMM+xJQ7O8kc4yqsEbBB2yr2sjF/acTRVvrylg1070+ueawTev5KoB/ZOi5B4brYognyQ+nUOJG5LHy3jXAf/X3UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AMVPR04MB12627.eurprd04.prod.outlook.com (2603:10a6:20b:776::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 03:23:12 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%4]) with mapi id 15.20.9745.035; Thu, 9 Apr 2026
 03:23:11 +0000
Date: Thu, 9 Apr 2026 11:23:03 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v10 00/21] wifi: nxpwifi: create nxpwifi to support
Message-ID: <adcblxRaTTyEvVWN@nxpwireless-Inspiron-14-Plus-7440>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
 <9b0144261da2ce7f5ef0a533928732cc43459e40.camel@sipsolutions.net>
 <abDh2mBYTqbhKz/H@nxpwireless-Inspiron-14-Plus-7440>
 <8ebc201c976f11cce4802e9e34c1f479ee190ac8.camel@sipsolutions.net>
 <abJ/qONShVDAuyhI@nxpwireless-Inspiron-14-Plus-7440>
 <075c9a062664609a81a722883ee17e7c728b08bc.camel@sipsolutions.net>
 <acPm666IO+nso5to@nxpwireless-Inspiron-14-Plus-7440>
 <4ccf21800166b28cc28c72b0b1cf2672b43af8a9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ccf21800166b28cc28c72b0b1cf2672b43af8a9.camel@sipsolutions.net>
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AMVPR04MB12627:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f4f0f1-3ec3-4634-e9e5-08de95e7542f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	muBBONVtmr0xxLOvqs5EJ1SOZVpZottkNqhjENGP7FZ4dSF5uVHuR0HU7UHAY1ypr8AY1QxDBS7uEphovAmltmwMDqXYT7m7t/WOJ8wmPibzxufsjtb6pLNMX+Dkroq2MVObJUKL+DQW23xUMxf+CMrnoLblwSv2OagbOcBKMSwcppIqs6uwK2dNwhdgtaGc0GQFo/ojaCdu8L62hqe8pKYznKm8hwDdY91mdjvm5vw0/Nl+c3AIgCI+IYtQQdUcl06r8+rRdTXr/X5mnyY9uIZu8UIVQiOIcyDB/2j+y+14RhRO9Pttg3hSBjW26adri42rBfvzLhRceKIroOh9L8F6A2MMiFAGwklm34mL0W/vL3tgzTfrFrVs/ZaIoNKEhAn7nqtGpac5X5nmDCLPSWIl4CGHzSRpB2sI4ID0NO2pulAMcEqvtZH6ew617v1M4UIjuhW8hghis1dkEN73SBAtnCZ/trkVn2s5/f5Q14JT1IjSP6vkIbpdfOLc77tLzLi7Hl0l04qG6IYz2r9VsN2NDBJO3IoMZefkE0qalf4cVDTPZK+9B3wvetZ5gwCmQuNFmhW9e7D8QUmc+tZGj5Pqc197GgWfsgM4w43/PjVOonHaUUwp4EETYY/Ls2P/W24t0kJjFYc1FeMSBA/DJtKVsQLgbv5F3HqE6GSe2pQ0+RCn4ldfw1L89mQrHmwOMWApSfMvYrvFUgB/5j/U1+JqWJOVwpiMevR9bMT+lisq9aZcutifajY36qoDA72wCN9+XDGR92LGSEujOxAEtvKcC7BWWEvb50Zp7AS9rKQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGNCSEZDNGsyR0p1N0pFR3VickdjSk5BZnhxNTBEdWdFRWNvQi80aEdhanhv?=
 =?utf-8?B?dWpVVEV1emp5YWhTQVFNUUpmQW4rd3pZQzlKNkhjRG1BVW9uSEd1c0s3WXF3?=
 =?utf-8?B?UDlYamZFVEVMVks0akRKV0RjdHYxekFoYnB1TldLS2cwOEQyeWR3K29wK0px?=
 =?utf-8?B?RFpvcFNxTEtEclJrN2xLeEc1aHRXc0s2aFphNHNSOXJqTlFoM1h2bWZseGRF?=
 =?utf-8?B?UEoxZlU4K0dqaFAyL1VtcE5QVkltZ0VOTmluVGhPTW5jcnhBY0FnTDRWMkpn?=
 =?utf-8?B?aHpSc2VjWERSNFgva0ptQlBLbkJHRDNBQkI4TXV1SlN0bHlFZ0ZJU2hTbzZX?=
 =?utf-8?B?dkdmUGpoV2FBdHFZUmlRRVJtaEtPZk9HYWdnaVA2aVNHbURkVW5sWkJINTB2?=
 =?utf-8?B?dlJOK2pNMWhuMDlOUDNFZ0pVNEFZbyt1SW9vQ2huaHZiajg2MDVLR3AzdHRN?=
 =?utf-8?B?WjUxTHM2YzRKVnZKWElKWnkrNGxBOTJpTEJmWXlKeDdvUEgzMjVVRkhTT1VD?=
 =?utf-8?B?c0x3cktKbW82MW9taEY0bThYYXhZOEh1Mzh5Skh1WUhqL216VDAwWUJzUFE4?=
 =?utf-8?B?ck9XV3kySEJybjFOR2tXdVQ0ZDk3LzJ0NWVKdDJZWVVhTGpYRDJ5dXY5OUNr?=
 =?utf-8?B?RjBIRTMyeHgyWTRENGF4dEZURjdtQnNTU3JWSjNkbDdGYWZobzA0WmVyN0Rn?=
 =?utf-8?B?Tk5EeDJyOXNtanZzYmVZbnkwRlArOWJJcUdQVzVIVGNaZ1g3QlZwR094UHly?=
 =?utf-8?B?UnUrOFIxN1dieFBmZ2hyMmxZKzU0OHQ3WlVTNm9hQTd1eWZJRmlVZ3FKaGg4?=
 =?utf-8?B?QnVsNHBzaStzQUkzNkJ2dmJwY2czTXpEVXp6QjlmZWoxWGZnWGVzVEhZc20x?=
 =?utf-8?B?Y2V0VkpaMXdkNEZjODBaN2p5MHFQZk00NlpJc1BOaUxNeWpHNU41RjIzSEVz?=
 =?utf-8?B?bTJwUGxvbG42YXQ1TE0xRGs4RU1IQ2hlQnh1WlY4L3pieG55Ty9ycHVuYWdD?=
 =?utf-8?B?dkpLUUJlMGI5aHdTK3dFbVJiTXNlbkhwazlLQUxmVkNTdkkvNXFVdTVnaEZJ?=
 =?utf-8?B?VXRzNUZzRUVvQ01BWEdjQVAvVUcwVUFKNkk1WnlLUVZIRm52UnVUcjlyK0Jt?=
 =?utf-8?B?TlRmejhhUThtSVdNaEpnSFFUVzd4eTloTnVNYjRjdEFvdVFwY0tkQWY5cUUy?=
 =?utf-8?B?ZFltMldhMzNaNlRzeXVJa1VXMVFOS2Via25tMWFCUjdNLzFFOUZBblNCVHZu?=
 =?utf-8?B?amZNRW41d3NuR3ZxVXkrT3l6WFRMdTNMY2hYTXJ6ek1QZmFxZDRBWnVycFF2?=
 =?utf-8?B?VnRGb2tqZmcwN1hzaVh6azhBbEVralIrV0FERWF1NWxVckJWbVBubC9LdmxJ?=
 =?utf-8?B?c29kNSs0RTM4ZmhuSTN1ZW9QRzRUVkltNkxSTXA5anRFWUVFaSttTVQ3d3dT?=
 =?utf-8?B?VDNhL1hVZTU1SGpYaElVZmlGczZBU3N1Wk5jb1Y4RzY0bkhWVVFnWFNJWi9B?=
 =?utf-8?B?SjZBQzBRb2dBRFNjQk1iaXBCZ1JGYzdjZWltbU1nYVFwdHVsSyszdWsxWnd0?=
 =?utf-8?B?U1pMK1RlRCtRek5RSVpWOWRvNG5NR0o2QTljNyszNzZDNXB6OFpLekRodFhG?=
 =?utf-8?B?bWZlZVl5QWVUbExLRzBuZ2lndWl4YXQzTmE5V1krMDdpOVgwWVVDUHRjSnFK?=
 =?utf-8?B?Mm8wRld6S1BqVjJTdkl1K0U5d3RsVU82MkthYUVOL0xqKzN6OG4wRHB4MEZF?=
 =?utf-8?B?TEhjMk9pZ3UyTW5FSWF4ZjQ0blgwQU5zdSsrSGhyaWFtamFOdENhbmZiME1S?=
 =?utf-8?B?cFR5VVRGRHM2N2JVNTlCaFU5L2ZERHJnMW4xZ2dPcW5WaXdkcHdVRE1HTUJs?=
 =?utf-8?B?Y3JDZ3lmaGptSnA4MlYrR2pEb3lCaXFnZEhwMW5JdlZ1M2ZsUjZZV2Jhbko4?=
 =?utf-8?B?QzlSWURsSUNZM1loU1lPaTZQb3RGOXdrL0xoc0d2NzBCV2pUeUZMcytWUlox?=
 =?utf-8?B?QTNORlQxNHk1bUdTQXRSY2pvWXNNM1hBRnFEZWorT2VLTEVCdlpTdlF3MHpy?=
 =?utf-8?B?a2pJRVJKdndscEVYOWhhUFBtaURxZXdLMW13cmVSNnM5Y2plY0RFNXc5OUUy?=
 =?utf-8?B?OFh3Y2taR2pxMCtsK2ZMa3NKN2s2SkJuUStxTEVaQ1owWGFjK0x5R1N2Q2VX?=
 =?utf-8?B?ZEdQYklxc0pBUWR1VlIrcG1WRE5CYWRPQlZ4eUZPYy9FZEQ3ZWZhdVMyeGE2?=
 =?utf-8?B?UWdZdkRFbURXTWV2bWdjK29jbGhkTUx0aUZyZVRCcmoxUW9wSU5PcU5HNFMz?=
 =?utf-8?B?SEZEbGp0QWNMMDVBVDcvSUMzRXdPZElTYXB1dVlldjgrTUlzWmltdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f4f0f1-3ec3-4634-e9e5-08de95e7542f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 03:23:11.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtkUMQ3XswbNm61FYOnpP4pGrsStowUj2pI7ih8NOTPmvwtdqAGLs5M2SD0rLDqmkhjKMpkPMsU+r6qXky/0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR04MB12627
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34537-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0A633C602C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:06:36 AM +0200, Johannes Berg wrote:
> On Wed, 2026-03-25 at 21:45 +0800, Jeff Chen wrote:
> > Ulf prefers not to rebase or drop the SDIO ID patch from the mmc tree,
> > and his suggestion is for me to include an identical copy of that patch
> > in the nxpwifi series for wireless-next, so that the driver can build
> > independently during review. Since the change is trivial, he expects git
> > to resolve the duplication automatically when the wireless and mmc trees
> > are merged.
> > Would this approach be acceptable for wireless-next?
> 
> Yeah I guess we don't have a choice ...
> 
> > For reference, please see Ulf’s feedback here:
> > 
> > https://patchwork.kernel.org/project/linux-mmc/patch/20260113031517.244714-1-jeff.chen_1@nxp.com/
> 
> So I think we said before that for final merge you should send a pull
> request anyway instead of all the individual patches.
> 
> Can you include it in the pull request, as a precise cherry-pick from
> his tree?
> 
> johannes
>

Hi Johannes,

Thanks for the clarification.

I will keep the SDIO ID change in the current nxpwifi patch series so it
builds independently in wireless-next during review. For the final merge,
I will send a pull request and include a precise cherry-pick of the SDIO ID
commit from the mmc tree.

Best regards,
Jeff 

