Return-Path: <linux-wireless+bounces-39020-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EFUtHBj/VWpqxgAAu9opvQ
	(envelope-from <linux-wireless+bounces-39020-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:19:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADECC752C02
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=smu.edu.sg header.s=selector1 header.b=fcy2+L+J;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39020-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39020-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=smu.edu.sg;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28485301F8C8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A93F9F5E;
	Tue, 14 Jul 2026 09:19:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022077.outbound.protection.outlook.com [52.101.126.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B82DB7BD;
	Tue, 14 Jul 2026 09:19:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020756; cv=fail; b=c5otyO0CCp/FqGko6YFD0soqsut3ng2zoDVdxmQQL0gpHVQWZ6j/le1Vg/3W8g9gg/BS5zHncPWIyhtMr88j/oGRyUqi+zbtJtt+/ic1Z/T1W9toBuMsxmaQpovn+kVWOXhtQmuuKozx8PFY6eC1Rdl8P4nS9H0LKmRS6scBd2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020756; c=relaxed/simple;
	bh=Cx5lg4j784fg62doZ0WootStYcgiz/YdvWhb2d2ogto=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tsLJ85ww1kxPMeXmwUrzvfgLfcHMGm+NSi8e0RXqkv6t8kVICCeR6hyruUioC7tAr0IytZVKlZ7B+L/jwfDcnwlGwM7BWUAWzeieo2RITvpB9Kl2s2UUKi8QGmn1X4NUoMOaY8PrmgjR+B4WkFjVj3Hxwmhe3xL2T66K2rrOFZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smu.edu.sg; spf=pass smtp.mailfrom=smu.edu.sg; dkim=pass (2048-bit key) header.d=smu.edu.sg header.i=@smu.edu.sg header.b=fcy2+L+J; arc=fail smtp.client-ip=52.101.126.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x99NGkXRq/BhL92KnJDI6Ql10GOkwQenH25rAStq2dIBXKnfERMhSdwgtPoCsgsce8Y3vaoia0SXCkhfRYZTIE0nLNV99sjW1oQs9RoI8ZC2LfYy7TGeQZ7mGNRSLzt50uGDLahwcJ7opuiZTNwacncwPMbnac6VBslpQunarKqBhSjFFElU+wRFQDjOd5XxB0pFim7SwN9EgYXDeRHmqzdgaN5ENqeVvwq6U2O/Ff0o0TTEgh+46gDAtZ0V4aiJ80EG9tQPWXLDPiW/d/pGcHEpQJzyrOGgWUTeUfu0p+tU79Z5F3KiPJ9Z6O/vt++RPksa+i2GHy24Ehx2EIJwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFEPdT5nteN2CBLjqqc5IuMFb8hVYbt1UJf5qfE8+fI=;
 b=UXaq9i3g/bgALocrA+d6jCRSIcOwb8+rfwgQ/CXSoxwM9/eLpXfgoDdiX/Tkw7dhXPs2f2wq/yeaBbJs8R1FXZUP7E95oMF7WtzEOc+c8ysILtOgySLgfAibOnsJSR92X5im5nv3B0YyJKmTSyRl5QK6AyYco1DjX41xxwdhTW7yU3vdF0inCSjeRrVOu6EYW1sdirURJDAvq6lDN2RHSWUC4h+niZ3enTS4QMnjegAiHt5vbj8NSb3fm+1kL3A/7NrS3XLVJYiZ5Sy67oPCkkiU3Zr24DEuxUagOg4a80Mf+D15DbsXB9AQXXaJ1YBGBqLPSN4zgAWRXe4KsQuTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smu.edu.sg; dmarc=pass action=none header.from=smu.edu.sg;
 dkim=pass header.d=smu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFEPdT5nteN2CBLjqqc5IuMFb8hVYbt1UJf5qfE8+fI=;
 b=fcy2+L+JyzMG57sL5eLz5ZZoTgLpcodcYxiwZBWL64CbFqvrN82KuOSXhZZfZm3xP4YFBhO7KTXMBP4nekaOcZBEA0DwaT7U8LbpN2JJDIpaBXuliyOT48UTWkCRFF+msu+hy/XZnabcNHLjVpQ4FQKAAeJeMSzmlfL6fU3RZlG/yVHLJjT1aSF/1YIwd6bb4bJIL38RpydNx/nOQdQdUz+UW0RdW5GY5kTBJohs4DvH4zmAJmzgsl66aryxgZxQQBQ+rNxLg6ZA0L9eFmsrccRcc/HDEklgdxOo3EMYQUVY/H0PvZAlEtlpw4MHGi/ib1R8rLK5FQQEKnEA6q0u2g==
Received: from KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:3f::9) by SG2PPFA603A64E4.apcprd01.prod.exchangelabs.com
 (2603:1096:f:fff6::440) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 09:19:06 +0000
Received: from KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 ([fe80::6bd0:d704:7d90:a595]) by KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 ([fe80::6bd0:d704:7d90:a595%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:19:06 +0000
From: Huihui Huang <hhhuang@smu.edu.sg>
To: linux-wireless@vger.kernel.org
Cc: Huihui Huang <hhhuang@smu.edu.sg>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: wilc1000: validate assoc response length before subtracting header
Date: Tue, 14 Jul 2026 17:17:58 +0800
Message-ID: <20260714091811.3596126-1-hhhuang@smu.edu.sg>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:4:297::19) To KUXPR01MB7791.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:3f::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR01MB7791:EE_|SG2PPFA603A64E4:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f313fe8-f327-4fc8-7477-08dee188f42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|786006|366016|52116014|376014|23010399003|11063799006|56012099006|18002099003|3023799007|38350700014;
X-Microsoft-Antispam-Message-Info:
	e5plu51BadXL6WO3ucaSjoSKTBBsDAw5YpOCBz2uLPHxcppWqO3t+L5SOIq8FBB9HnNGu8bkiVFFPIn07UtDpHTr7tQUU5YSIjKxJ+IDLvw1aseeDcj0R4bDEYWK4SBcA3unpOCNB/m6CuHSujhPNnJQytooz/aRo/hTfEGzGH9C/hVO6A8az6pw8rb7znqrE7BNzhyRedjPSnVN7tAAnub5WGdeWa57Y+7BpL03iN5Ht9jtyQwOd3UE3f/esIWZMGOdo8eP7KxgoutCUqxY85nQBEhpfO2g33tCLtTvSnFsTnQ7deozlxodj8Z78l0SwTtmO0Fxq9GMdl8jKNZgI8s5Z6f1wTy2lVuWlZkXods0ogYTA7UA+rWTPamThwe3sg3SOrTg7/QDYQBOodrK05tHzJs4Q2yS8+WWx1ruJyPoW5f9/+gXNoken7kotzr68i9LV7TES16LAzYSnB6ZMItK/GK1inhJHvW/GpruNp0+WTwDs8AWK3HixyHwhBIgXKaZEJc6BTo7SYTNaorSjP1Qv+T/iMDFBZD/8+LQJvGtsbRDaiV6MVdNF/uuxxuWbI+OUypCsIky9i44rHpsy4pBqlRKcDjW8F9T8L122I670lATYdEht5aywCpWLLnKuqootaII4iNS9eDgbeZjZBO352kLIOjqpzsCtF+DAX6MGClHEOSnVtVTR9VtXC1k8Y/OCdVHpSWyBIhBIeJ8wcTD8RkrNIoa5WJORzYTidQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUXPR01MB7791.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(366016)(52116014)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(3023799007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iml3W1VX12ARo2/bYVqvqvujksvFyeQGwexKNlOvA9jEfwkjDXUG1g2Mj+fB?=
 =?us-ascii?Q?g/+eKsculispi6kdm4IplWLRSk44RZhGZadbdoLvvOA16xIoKfcFBonHvL5h?=
 =?us-ascii?Q?W674y4ACiC9JixwxDHlGwXR8BnO/+JMfDup8CXE7f6tBfB0w/4i1QRxarX9Z?=
 =?us-ascii?Q?sSu6TINIJ+erHNv/XeT1VJKpacV9nDToKDmAm+JsYMf/iXWpfzntb6uPVEE7?=
 =?us-ascii?Q?zOsejv3lkXm2plCbocUuEhprCFm6Gj+t1jPX9rDIuJlL8/oHhnKtHz4vZpO3?=
 =?us-ascii?Q?cmVfo4Lnkm+8cw1Rxb2kvXLQm6JAKeXeXNXMa+ENDvSpwyZfoUPT8EfSE/Ek?=
 =?us-ascii?Q?9lB+UCvIJ+8Lg3UYUnlSU2iFsSodMnr6TKF5Dpm0pjYLIYthX4NK0/d2zati?=
 =?us-ascii?Q?5YzM84HAYxUE2vZgpudU128P9ZbNBm4567RHrUganXj4He80SV4wpvC/8aTY?=
 =?us-ascii?Q?NaxjFVKY9livBfXC2GYNuyYdIjenfWE8TsbtqB7wij3H2iPRzuqk6/FpSAu7?=
 =?us-ascii?Q?0evaEe6ZwmtvmkQma65dH4bq2rtuyb6m7rFypSydudsMb7T50yMtPsCW9lcx?=
 =?us-ascii?Q?sijkVrj0pShhPdUFBotFDib25p+hoR5S2ZbtVFLsTykENA6bAyLGBOniFZhh?=
 =?us-ascii?Q?GchkqRaKI0RVorBhietnz1ZsrngUctBej10VV4unLo0ggd33jqpjK1TVznSC?=
 =?us-ascii?Q?8MDJVvCbfO7B5zn76uZYVvQJk+Y19ySOcsOcspeSvsTQP91ZqQ+1LjsraTm+?=
 =?us-ascii?Q?+zhNWWDcMM5G7w+N7RhyD3ZkHNydVjUw1s3+SL9A7DMrYrlZAI6R8ipVavhR?=
 =?us-ascii?Q?992s23uR1krXvSGQt5uSXmdS9TzrrZNCBFw55aGxvVjVhjYk46HGiicoTjFE?=
 =?us-ascii?Q?xg2fnTQ905vy3ixqRlbFx7DN+KN4P625YOtnSHL14d7XI4qOCL6AAgE4okNe?=
 =?us-ascii?Q?XhDbtUleaDKblZ96wtRIWD8OzDvVmJRhs4Tt9kWYX0xhiBrPyk4yZ9DkzfBw?=
 =?us-ascii?Q?PKfRrrwZPfaD3VExi+Mx05+eh6Ooi1vkPRjL0bOihGD69D0KXvsybnFSo1yy?=
 =?us-ascii?Q?CYYgLJjrwkC449L1apxDqSKMcroQqzSPKXkuxTSXQWO5dJzZjPsysfbokPCx?=
 =?us-ascii?Q?nIezjaJNVmp2kGCk2ZIbbEIJ40J2qSV60OViGFAoCFDRYW/Keej2MkPg9zNp?=
 =?us-ascii?Q?NmDtF4WmXCL1VTfYAs6/IYXFOZlyojMmqbUSYLPZd7GUwvJn4DPAUyORn0ec?=
 =?us-ascii?Q?MlNZDEAqYfcJ2rLwwHWUmmIZp2CDf9b3sZdUWIbUvSclGCisoPI0fG6rCFKe?=
 =?us-ascii?Q?+FRI+0b/ZRyUCSoOrGMEYB02/+tSUVzDyxURkNAJAA/YYNX/ynW0HpfVya8E?=
 =?us-ascii?Q?p4YWK/e2N5InyxIr4vtTn8t4zoVziZGOJEz5rUbWT7xTyRE/rqDnw+/5ZBRn?=
 =?us-ascii?Q?VqKqu69UXniXX9QcXCZLynHuAw5mBPIjqmv0oNBAolByPWTlGTaMTeFYeZtO?=
 =?us-ascii?Q?vIOf9zBVj/xIZlCSkRG4uSsOUuTBU9VlBrZTm/NcSvrymgClkj9/Y18hLHG5?=
 =?us-ascii?Q?pSIAY7nw/gjgWXCyLS2YxYeZD9GLmJXv4MRyooOZJZbl0lWfbk+V5ZCHbN0i?=
 =?us-ascii?Q?YUfSv+X7kPVBELldkqbSqP8wKEmUFJ+wwvlao8JDeKykivbc5Ih3zlXTQJQs?=
 =?us-ascii?Q?7iWjcovRUSJilUJU+dUy/BgrZxmrd1c1qT/BbUyKvR7GIVGwdB3/GQMqsMNd?=
 =?us-ascii?Q?CqoBXpQpyw=3D=3D?=
X-OriginatorOrg: smu.edu.sg
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f313fe8-f327-4fc8-7477-08dee188f42b
X-MS-Exchange-CrossTenant-AuthSource: KUXPR01MB7791.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:19:06.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c98a79ca-5a9a-4791-a243-f06afd67464d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJwE+ygbK4fERQjSaUNFNLgbh4lu0NOXzWuienbZ9FSMl+uXxh0e/KG1M2/BzYg8x1WaI9el8qoYl1bIinjIuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PPFA603A64E4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smu.edu.sg,quarantine];
	R_DKIM_ALLOW(-0.20)[smu.edu.sg:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39020-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hhhuang@smu.edu.sg,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:hhhuang@smu.edu.sg,m:ajay.kathat@microchip.com,m:claudiu.beznea@tuxon.dev,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuang@smu.edu.sg,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[smu.edu.sg:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smu.edu.sg:from_mime,smu.edu.sg:mid,smu.edu.sg:email,smu.edu.sg:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADECC752C02

wilc_parse_assoc_resp_info() computes the trailing IE length as

	ies_len = buffer_len - sizeof(*res);

without first checking that buffer_len is at least sizeof(struct
wilc_assoc_resp) (6 bytes). buffer_len is the length reported for a
received association response (host_int_parse_assoc_resp_info() passes
hif_drv->assoc_resp / assoc_resp_info_len straight in) and must be
validated before the driver accesses the fixed header.

For a frame shorter than the 6-byte fixed header, the subtraction wraps.
For a four-byte response the result is truncated to a u16 ies_len of
65534, so kmemdup() then attempts to copy 65534 bytes starting at
buffer + sizeof(*res), beyond the valid association-response data
(CWE-125). A response shorter than four bytes can also cause an
out-of-bounds read of res->status_code at offsets 2 and 3.

Reject frames too short to hold the fixed header before touching the
header or computing ies_len. Also set the connection status to a failure
on this path: the caller falls through to a
"conn_info->status == WLAN_STATUS_SUCCESS" check after the parser
returns, so leaving the status untouched could let a malformed short
response be treated as a successful association.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Huihui Huang <hhhuang@smu.edu.sg>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 5 +++++
 1 file changed, 5 insertions(+)

Confirmed on Linux v7.2-rc2 with a temporary KUnit test that calls the
static wilc_parse_assoc_resp_info() on a 4-byte association-response frame
(status_code zeroed, i.e. WLAN_STATUS_SUCCESS). Verbatim KUnit output
(timestamps stripped):

  before this change:
    # wilc_assoc_resp_short_frame_test: ret=0 resp_ies=ffff888008890000 resp_ies_len=65534 (want -EINVAL / NULL / 0)
  after this change:
    # wilc_assoc_resp_short_frame_test: ret=-22 resp_ies=0000000000000000 resp_ies_len=0 (want -EINVAL / NULL / 0)

So a 4-byte frame drives a 65534-byte kmemdup() over-read before the fix,
and is rejected with -EINVAL after it. The test also asserts the rejected
frame does not leave conn_info->status at WLAN_STATUS_SUCCESS.

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 009c477..60fe5f0 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -600,6 +600,11 @@ static s32 wilc_parse_assoc_resp_info(u8 *buffer, u32 buffer_len,
 	u16 ies_len;
 	struct wilc_assoc_resp *res = (struct wilc_assoc_resp *)buffer;
 
+	if (buffer_len < sizeof(*res)) {
+		ret_conn_info->status = WLAN_STATUS_UNSPECIFIED_FAILURE;
+		return -EINVAL;
+	}
+
 	ret_conn_info->status = le16_to_cpu(res->status_code);
 	if (ret_conn_info->status == WLAN_STATUS_SUCCESS) {
 		ies = &buffer[sizeof(*res)];

base-commit: a0d82fb8505326cbc53dc9a0c08f97d11197bb30
-- 
2.50.1


