Return-Path: <linux-wireless+bounces-37665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cT6rJzaDKmoBrgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 11:43:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBA67085C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 11:43:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=kiNuRvCQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37665-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37665-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA8C53037B94
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52C30C629;
	Thu, 11 Jun 2026 09:43:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171928C2BF;
	Thu, 11 Jun 2026 09:43:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170995; cv=fail; b=A2n/Pyi51kEesK+0OCignrmWNcVz1l8tHoIsnoOIkj5kOzyvu5RF0Tv5qiYzL7nPIjMT8fKbZYoNOhngWI4e+Vfzb6T6J7LINGgAqKs6dyNefZBcAwEZ1WyHskeLgw2jfZO6yn199sePxs54rqcyp6pngYIir+LvrEtf4+o9100=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170995; c=relaxed/simple;
	bh=5spiWRA4vVQtpUNqjDjNLE77dbqleEJ7UggMUhCNZ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rXzYOBwKfMKpcuLJp15Ag/KGPdPvGFGJoSClwWN2KEA2FIrA8MbYALOI1DhMgGUFeKEfS/58zwak2/9/5YOwkcCCZd0t/r0f9ZxN+ehy2FVmw2S29k+WKKzjl58/asbwQ7yQEm8s5OnaWpghA5rcy3GuTlTL8vpLXZovKr1K0x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kiNuRvCQ; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X20oaXjX3fFYgtbQXWQMGfNMUbw7q1LPOyAf9h3Tbsudbb43ku2qVMhaDQv4biEMNtluoeaSVhfbz7I9DyjsPB8Lf+IlsJoRvniL7oFxiKAUGqS89HeQw20VkvdbYciDKJDdNRyEK9sW/N8/dfIb1aR1noVPTlHPSLPyV7jlxByw/Ba+MDy5Izq4+4jIUEh9b/1oubyuqciDPM052V/gIdG6jAaswttCJBMzsIUZzuzpujkhcXFlkQifKnqG9OU9SEyGKyihVeak+aUcjTFM+NjFse05utZOl49sdNYfHG45/XIZVnIu40A8gXRvb5Mk/C3BteMn0VMrPllwLs7AXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi6Zbzt3CgHVGGipPAgYUuCnKk4PkAh/5uYkqeTYA+c=;
 b=FzcAxfHMobw/UqYDUe3s0q5N0YSC0RA1nf6IESgYjFE/t7ohe2RYRUfK8kecUGv56W0wTIbY0TQVmLQNMkboFg2l4PloCXNjOzqYDbK70bWBQGNK1rWGYvF/Wrc+UBLny4kio8EmXobTfB2CZnPI+0w1npMu1s0E9ZxteJ7hO0PZuNXnuuKyUPR9GbzxbVtpnIpGbuvXCm7p8HGw3YpGl5O39CSIyl3YgoXS/vmeuzs1fRiUg7TtNnIiorFKUgznHhCt/g3pM5qJkRmnf/pUyJ9A7kEDcLXry3UxxxZjzjnBpD/7bbQhhBNRTGgiNn1XKmIJZweK0x3Gr15Sh8Hv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi6Zbzt3CgHVGGipPAgYUuCnKk4PkAh/5uYkqeTYA+c=;
 b=kiNuRvCQwpOf9dKnqzy+Brn7BqIw6OixTVlLmNRDJC8IXSsBf4tOp2kcQ1Tbu7k1EYbctO8GNnpZEFgDbme2emZJ5KQFeZH95WQ+NGzjyhSVILTcCo/MMNjJDXvpEJLVYOZDOaAuGqnpxhqbe/CAg5kU50aT1E44hhXOqnYHztwOyQEeVNniaTZn0LQijvEoHT+7WYdbYQD9HUpFAdHXtcxqLdNwSLrBKHpYTMkqNVMZziWD6nZH4LAJOM6UEfjdQZoh7tjEnMnGcSpaaCbahw61pczDLdDnpfiDuAEiTz7d7kvjGGk5ffO+l+mr3wNX07JmEgpTspzULTpEXZbq1A==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB9511.eurprd04.prod.outlook.com (2603:10a6:20b:44b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 09:43:11 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 09:43:11 +0000
Date: Thu, 11 Jun 2026 17:43:26 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Rafael Beims <rafael@beims.me>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, wyatt.hsu@nxp.com, s.hauer@pengutronix.de,
	ulf.hansson@linaro.org
Subject: Re: [PATCH v12 10/22] wifi: nxpwifi: implement cfg80211 ops for STA
 and AP modes
Message-ID: <aiqDPh5IzPRgH/8o@nxpwireless-Inspiron-14-Plus-7440>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
 <20260605161335.2415583-11-jeff.chen_1@nxp.com>
 <aimMeKc7yODvwNOT@burns.beims.me>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aimMeKc7yODvwNOT@burns.beims.me>
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS8PR04MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ea6beb-60a5-4f98-4b7d-08dec79dd93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|52116014|1800799024|38350700014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g5ti0C5HZndBeZjcUGx+ospWgRcW3iKafnxtxn5WmTDuLEy8iCqTApj81N9kMHCI4+iSIHYmwj8SQ6XiI/KaqDrlIJ9VLXx0+ITf6jy8+1dyC5M/xriwBLCr4Mdmqf7fKlm03FeAitvVKSBHJ9Gr4Yb543SgXDmhJdY7H7DAJx+8iKY2OmOXbSqyB/Sm01EZ9zLQG6KvwoKhnsXZce/iHidsqIi9exWdRPRxHk4sGsgeL/jT7kmOz7lpPe/+aPS5y2SsmUKm7LdPbl5jS8UadsPxC8aVdZfqJYgD2q0l26MrPjDh5Iv4igB4XLtkfUwSStX15v4yjyskX8r4CMyL/DLiJoDYMYffvXkLA/TFPtXkl/frdoe+6V291Cu3WGwXiKXo3JuqUvoD+QXgKAxjHh77ElYwgXtd5wLyVEyOQc+ww1VE6kGoy6p/LFwDzoJ/C4fdl7Orb6dxMp7BokNKzJHtmxudTbLGWPD3rwD36/ZvvTVS6noqmxbBPyUR8Po0WD/b2BSLB96TRj0l4Tnrs4IYr+m6T+lPZwMJHT1wN4FGuuaHonGQniUUzAOMmltqg3kh/29QtUeZ9yYY6SxNSgsADgI9U/we/KYE7jpg8K/qIHI2IA+bF/JuzyNFhae3wg5khuQz8L6RfkZv6NjHHjYd1zQdIyxJ7bNR/ZklnX0dIfgBQGTxNAydNWmfIuls7hnj0KWgINPFI/Ub34FjUAfg6NiIYNNRaZKPFDslRSA9QCuwvEsrOxJoYTrNwT8I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(52116014)(1800799024)(38350700014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OURBNmk4RHp1THFTdXBJd2ZQTUd0QmJmM0c2Z1h2aFpoU05FMlRRaUJRWEll?=
 =?utf-8?B?ZzIzWDRKMnFsMWFTZEdHUnBTeXVia2FuNVEwenhBUnVEaVNVeVlIMGs0TU94?=
 =?utf-8?B?OXA5amM5cDRzOHQxK0dOZUl0SWhJSENaODkwOVFhUllwMEtpMkYyeHFQc0Ev?=
 =?utf-8?B?ZExPZDFFQm56c0MyU05HMzlCanVndDkrb1VLektTZmE0WHRIMWFkaUs3QWY5?=
 =?utf-8?B?N3JhY2orNlhMbDZVVnhRUmJBT1lOS1hiN0NWQ2JNYkJCS0U1YW9nOGFpZTMy?=
 =?utf-8?B?RitjVmZvYWVac1R1MGpyWW9pRHdSM0ZLOE4xYlF0RjN4OE85Z1ZoakZZelcr?=
 =?utf-8?B?b0ozNjA0WjY5UU1lQkltTGJIWkc1N2xWL0pMdHFzempFbDZUQ3BzcTN0em1i?=
 =?utf-8?B?OXJZZUVIV2MxMWRmQXZubU9NdlF2blNDeGVaZGcrY0RHbC9TZWk4VDZVN0Z5?=
 =?utf-8?B?cDdDNlI1eUpxLzVGbDZlYUhkL1hXU3RPNEF0TDV0WUdjcTBpNVhwVk5YU2dy?=
 =?utf-8?B?WWNPZVFCUXlRZnFDUWpod2JPeU1LTXZDb2dGTDBDMUVNcStsWk9rQkpBUGl4?=
 =?utf-8?B?WUdWMS9qOTZRMDBMN3JyRFR6OWRpZ1dJZDdzTXBaYXNiQzh5a2pZSW9IQVRn?=
 =?utf-8?B?OUdTeEhZamNBTXFaU2J1dHNOUmgvVWg3ZDhTNHBkelVjM1d2K3NqR0g1dUZP?=
 =?utf-8?B?cjl2Mlg5c3IzVURENUcwVHlkc1Fwekk3WHE5SFRHMUswTmJHRTVQSmYrS01o?=
 =?utf-8?B?TDRXVURTaVFsTDk2WGRiWkJOQ1A3TUxISDhoN2FNc0VMcUhaUG5hc0lVY2lz?=
 =?utf-8?B?TG01UVNsSjdMVERZblFqZ09qUjY1U1VMUHpiMWh3VENjYlhmazFQeTVOaVVq?=
 =?utf-8?B?anV4ckNpTjVMWk5nZUI1cXhDQ3pnVEFDdW5NZHJuZy9wWklIZTZkUDE5K0Z5?=
 =?utf-8?B?cFUwTnlGU0hzZ3RSTnhlK1ZKNTZkc0xJM1VzRVNOcWtsVElyV2NhblVDN0wr?=
 =?utf-8?B?ZnRTNE1QWEhEcGRSSFdxNmp3OVhUZ2JIS2NQOEdVeFUzY3prdWpIYWhKcDEr?=
 =?utf-8?B?Ym1RSDZNZ20vazg5MWpQMWtxSU9vdmlpZkZCWmdoVmZjNXhDQ2JyWDJzNnBi?=
 =?utf-8?B?azlNZkxGbi9aQUkxbDBUa3N2UzNiMkhiNXZQUVo0VUFjRXhLQmxwNjQrWUY2?=
 =?utf-8?B?ZGNFUFpTTldHakUybFA1aXJLeHQzelkydHR4UkRWUDJabVVPdUVEQVZVOWpy?=
 =?utf-8?B?MWQwOE4xYzBLTnBiVVBZMUNIcWV3QjdKNWZwaUtlNVJVVjRmRTAvcjdEeHNk?=
 =?utf-8?B?RlY4RUw5SnFnaDRpQjYwdkFGdVlnbVBEYUp3QjllUGNtYzh4UysycGl4OGNO?=
 =?utf-8?B?blVKZm02MzQxZ3hlUmhRUzdjaVErZkZMSGRTajI1U2t6OGNNY3FxdVRUZ1dh?=
 =?utf-8?B?aFRMdzRaOFNEdXJocW9PWGo4bnYzcDEyd0xpYk56OWlJU2g0bTVYUmlxMTRB?=
 =?utf-8?B?WFgzeHhpSHEzK0ZUNnpGeEc4cmYvSnZtSHBOeVpCQlJSNUx2OHlnZzlpV2w4?=
 =?utf-8?B?V3Z4SVNTMkR0QjI4MU9RR3BHcmxtT0dHa3BHS0ZuVFFxM0dETXF0SjdHekRZ?=
 =?utf-8?B?eC9wbk1Kb2RLUy9VS1BWM3JKbUd6WGZyUGptaXlSNnJDOFpFZkxwTG9HRkM3?=
 =?utf-8?B?cWpFbkxyRE9oR2ZmMU1YWklOanJTSnczUXVhbVFUbVNETlh4ZzV0RDRTdG01?=
 =?utf-8?B?WEJpcTFTcUlhOW9na3RaMExzQk8vWmphQkZOUzR6S05GTjQxWm9zbjMxb1kw?=
 =?utf-8?B?VURGUnRXU3VSYjdUOWtiZmpjcHo0TVBZM1paK0hUeGllcXdDWW1WeTNsMEpL?=
 =?utf-8?B?Kzk1UEErWWFLbEp0OUVCdUdZZWdDQVNoMWQvcWVYME5DcG1sWklYang5Y2pm?=
 =?utf-8?B?eERNbkk0Njk2WEljc0hYdThLR256Um4vaUJwVnBkY0RWRnl5NllpaHZza3Vh?=
 =?utf-8?B?ZnJ5MXNZUFVySXkreStteGVwLzlpQlI3SjJLRy8vaFRLbjUvRk81ajRPY0J2?=
 =?utf-8?B?bld2NlRWRFI1d0w3cnJQUVlUREVTRjZGNE5nR1k2OFVMSWpwUmM3UXNGV2pL?=
 =?utf-8?B?MjA2RGxROUcwVndiYXE1SnUvT21vOTVsd3krN1pUbWNJVDdYa3Q3dE1pWEp1?=
 =?utf-8?B?RWVWSFErek1XL21QcitwbUM1d29ETmF6T0ZEblF4VDlnbnNMditzeXRNUVNB?=
 =?utf-8?B?TVVhVUFFVGZLK3ROZTJxTHBKMHlPREMrdVBBaXdFeVBXbWlkOU52MDgxOFI2?=
 =?utf-8?B?RmhDaFZHSEdzUm0wR0czT2xOMi9QQ0lNQ0JyUkVmcUdYKzBCNmgwUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea6beb-60a5-4f98-4b7d-08dec79dd93c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:43:11.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3ccTOJTHX9Vn5Xm1nenbDQofwG47qvl7AmEDMpYOtJzOPZsm+aW5fvtjM1S74232wd0NM4BZ9diEld8Jjwa/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9511
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37665-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rafael@beims.me,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:from_mime,nxpwireless-Inspiron-14-Plus-7440:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFEBA67085C

On Wed, Jun 10, 2026 at 01:10:32 PM -0300, Rafael Beims wrote:
> After a quick check, it seems that this patch contains the same
> problem being fixed here:
> https://lore.kernel.org/all/20260610150021.1018611-1-rafael@beims.me/
> 
> Maybe it would be worth it to confirm and fix it before sending the pull request.
> 
> Rafael
> 

Hi Rafael,

Thanks for the analysis. I’ll incorporate this into nxpwifi as well.

Thanks,
Jeff

