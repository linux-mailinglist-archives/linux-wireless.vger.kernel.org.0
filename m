Return-Path: <linux-wireless+bounces-32521-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM8ZOlGXqWlKAgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32521-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:46:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65525213C4A
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34E483053CC3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709A3A7F47;
	Thu,  5 Mar 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TfG7p2f3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96295274641;
	Thu,  5 Mar 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721712; cv=fail; b=jQA/ga513Cb0A177bHsj/BqieXokZ8g0AGGCOBI11fNyuswIzA7uaIqD15+oxTuEEjoucprCJuBjAG8edgRtuFxgwvB1VYX/vJ1Jp0KwHsAbG+FHX03Pp1Tx8jSx1/xJwf1jvnsqhlXwLIKZHLdzqal4RBjXtzizZhK7VTWfjpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721712; c=relaxed/simple;
	bh=xDCAt2e4oQ/NRnYA1MhmxHUoRJGeFwrGiF9tKZcbnz0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dma3YFo3vgo+/JGE/e2NtbL28T46UVYHX6NGrPLDa27SQD/+H5mmHibPNCklEyDs4NuyOrw9GC6CpjpVwx3LLqtmbYkTXOGlEbrvqLSddSYlL79SipHBIL4xj4qOG/tV5371LKgdxIjouw2xm+bQjHn1TQTFepe6ISj9QDawiqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TfG7p2f3; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkwomCmcrwYYfJbpr8nODJU41xum5h3n8gxEEz3IQ4xyV5n6Vp40jTY471m/363MGzoEh2ZJlz4Of+Fpunzqxzky2xGNAeeBr2VMIqp5cMNWMzs5PNJICbnzXxh+xk7OvrxA167gOrViy+eP9PQVyG+uAB0tafTM/bZDRlpjilfmyx+PXbyLwimwAP/dePxf+OjXqhwkzXOtA2k9JPYw2WxqrwpBRhczMNFE0jG7DWRCECyTI0+tzSeLbRKaEzc0TIgzhj48rKVRzdU9UjSeVw0YytllzRxmXl4s20/pJ8KWEAWLMamyGoCkt3j0Bkhbi3hIHtWHX7K+JPrrTc2cDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti32s2NWuMAhmgjNOeKEXL3qyM2eB9u1gwSW+PY5ym0=;
 b=IIoIjz/grmb9icRL3ZVT+zlRodaQivFMPG7PAbh23YGdoAKw/Vuw0tcZyOMSsWsh/Km1hYrzsH2n5XAlQ8AyCIbMdgWmoxENDKpCfRAe1/GomOUe5b72Ys4tSoHFc9jllBBrE8O9kGp/2gKP55bbzdVUpJO8MAVxdLW2FmJ6pQdauPUTXydyXFz8ahR7JZXIsYngivzT4MyNssoYW6uhDx2k7iLAfh1paNat9ui/ZYVZZboCSZbdnuGRhizwriGy5zKngZnLorYYB7uRvI8y9rtl0EKRl/MAH2XJTmDdewkUsY965+lmSg8lYf2jCujRESgAowoHdQGuETOuvpdBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti32s2NWuMAhmgjNOeKEXL3qyM2eB9u1gwSW+PY5ym0=;
 b=TfG7p2f3P8OdK14TK4Y/m7BBZJKIGi5OY0C3YoH64Si6s8iQZsfuOf+KJtDD2DJUBnDUwzdbscoxRy/PCKSdieKMEbDvEcPrKKHllMljR6tVgPgGnnWDomS9UL9rCv4fYiCedZ5LuxdnO3bJ7spMJhGY+tcsEnxRAL/cLkF4GE5y32TVGvIhLuS5W3N1mGbqo9AcOY7S4Msu5t4STcBh7jV7gik5Wr6/HC/+7tnPiPjfcv5OlDdkHscP8pKBo5EblLnN6HPdYfTKCKViC7kXF5Vdl4EY8EQTqIgD+hj+W5WYJH4iSHJJpnmpwBDSURSKiVaoBiZieaemAHQ3pX48qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:41:47 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:41:47 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 00/21] wifi: nxpwifi: create nxpwifi to support
Date: Thu,  5 Mar 2026 22:39:18 +0800
Message-Id: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7375a60b-4ba1-4dba-65b2-08de7ac5544e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	4/HCxfJk/LBWKgC+lL3Gh/VB977pf1s+8yi6DRi0yYNmE/Xe6G+bAarka6wreUnFJ6IyCAoKQRrhWoXH6dzLjXstnF8k37KFLJgNvkgHsqNzxXhvNipHOLZwLAWjySNZKLtyJi+INdiu55NOPUxbHUWoHWT2PWn7eEn5vxx0ACQ3R1OAjd0/o32hm8BIfFdxwKpQDpX3tIUw4L0IgSLc7sNJOEPU6n5q8Nh+Rrdt2RbIlkAIYezf2U6ALL8OgyQflTgiJPs3TEMJYfdfNEDaGvqLcNPa/iH+uLhI8KHjITFW/V5szZUACZ1OEV8sJjhLW45mwqUQGlqKwdl8d3104gfSYGuqv8XMYo8tfEHz9wMdQGt05++KloJ6v28KWcYq7rxbgou7sk5UrZl62I+V7HVnHZi/KkS71+WjCb/5buYlrwdDITUY2AvQu5m2xR6VvaPTdvVNVoks8PTH/WDrnUmg+FXsyRWJBLcYq1hTRah0NhbqojzXLdW5/2wVso9KuxG/gh5nL53h+fFTnslSPC8K9qi1Huxj76Gfr2llKxjiUlZd7dlDqs654567oaWShyLIPTuBlfVGEL6ezkj51MrLiSVNsLIlLBhMy2I6wmuENRTZ0FzD3k9B/K09bFbgv8kM4/7xKOAd4deDOHPAA22pUfe6DUn/gip1ZSDgOfAp6GDUxnRAXZYxnNuu0+ZKXrquh5iTLIRUoF9YZrKlU5O1n8/7eUndjDOJyiDOLQGXtzinxS1qRaprAqo+3if3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2taU0FzUWhnRlBXak1ZNW1HVVIrTU5TMFpTZEg0NXUwM2xYU0x4SG9EWVJr?=
 =?utf-8?B?Z3VuVGt6NS9hTWNlZTM4b0lEOEVpbStnR25YV1dVTms2aUtDbjBRMEw5eDN2?=
 =?utf-8?B?UzhpcG1aRzRJNG5LWTBrTDcrNi8vRlF4enZCbEYxdzFPTDY4YnlZeExmQks1?=
 =?utf-8?B?UmgwSmRxTTFTQ2c4eHBBV3R4bEZvQnZEaHkyZE1mU2V5dUUyb3Blb2dYb25H?=
 =?utf-8?B?RHpEZ2h1SHlSQ1lxWE9CbldZd08rLzBESGVjMTRNbUtZY2o1eit2L0ZtMnYx?=
 =?utf-8?B?YytlQU9NcXBCN0RiRHRrNTYxM2hhcHJLRkJ0eGc3RlVOMzh1T2VjVWF0U0pS?=
 =?utf-8?B?QW96KzZ6Vmg5ZTBQeFJUbWRPKzBYQ0hWYlNhR0lDLytFM0xMR0VNS2w2SEc4?=
 =?utf-8?B?M09mWXd3ZVZvNTVmb1JUc2VIU0x6WmpwRmVSNUZ2QXoyM1FPazhpTXdHYllt?=
 =?utf-8?B?Z0VTdkZoQTlDaUpabW1FQ205bHBOUmF1SjlBbWJoa0RkUVpENVBNQldNMEdy?=
 =?utf-8?B?L0IzZlVYaTBpT2NEQzNBdWUyOTVEbkNPWGFTcnZWeHVmTG81YVJBUUFKMzdK?=
 =?utf-8?B?UEZkY01VTmV6d1VqWFIzK01PUWJZTWhmdmNOYlU5dHNlQmZqZFlQUjlnSkNl?=
 =?utf-8?B?WEF6R3RhWU5BbjVWUGlQejVraGVOeklqbG91bnRYQ3l5ZXFXWk5QaDJvcU55?=
 =?utf-8?B?QlpwVFZkUW13WTJoa0hkcWF0U1d4L2dMV0RGUCtJMFpsWmYrM29vR3g0ZUpO?=
 =?utf-8?B?bUpsNTcreWE0NmRwUVVtS0NqOGR6UHE4c3p3bzZZRlBtWHJHdzd3ajJUQjNF?=
 =?utf-8?B?bkwrZEd1ck1MaEpybVV6R0doZ2VsMGFNc29ST1dQREhHZWhkeU5SRUI4Vktr?=
 =?utf-8?B?NlUrQVZxYVhrbEMvUlF6THJhTlY2QXhISi93Vkw0a0s2eHBkLzM1Qk1kcGFk?=
 =?utf-8?B?aDhuTVpMUlRUaXU3TTZiMkZzV1E0MzRTZkRTVndyWnB0U2FBVXRDcE5pN0FJ?=
 =?utf-8?B?WGYvSE5TR1pBTVRPUkQwQjFrTTViRkJZWEZkKzFmVks5SGVha1h1cXhodjFT?=
 =?utf-8?B?LzczV1FoMFdtMnZNT2w1eFlqR3VaV3R1cDQ2cWs0TXFuUGQ0YmRGbVFmSS8v?=
 =?utf-8?B?N2JibFVtc1JOOXA2QWNadEh5SjBidXBYOFVnN2lrb1F3TVVOMEhmSDBCMVB1?=
 =?utf-8?B?N0RzNGhlZGI1WTBlVUZpKzJ4TVkrV2VrdE1TZ0MxQ3E4dElzbnpLVDNXbXQ1?=
 =?utf-8?B?SzkwcjE4eVAvNUEvOUZJVFlwSzkrTzZ4alZZcDY0TS9WS0txSDNSN2FybXUr?=
 =?utf-8?B?V1JmelpvWjkrWUk3TVVCZ0JFNGh0SkhOZDROL1RlTmJWbm44YkxGdFlibHVu?=
 =?utf-8?B?VGxaQU9hM2d0R1dyWmoyZFN4WFVRVGxMQzR3UUlkZ2VyTnJSdjBtbW5aOW5M?=
 =?utf-8?B?TEYrTHFPY2I0dnViRk0xeUNWeXhXeG5OdEt1dzdFUzlBcmt2TFFYVkd1R2w0?=
 =?utf-8?B?NHk1blpiM0ROYTUvT0tVcVRKbVd2d0tPQ3N0bXptbHYzc1gzL1BGbkFDM0p5?=
 =?utf-8?B?MjlRaGE4RXZrUFRpVFpYTDZiZXkvNGFrUnEzbUlsa1NDTU82RXNZMlVnQVZi?=
 =?utf-8?B?NUwxSXhxbkJYZ25iUzBBaFVnd1U1aHAvWThMK2MxcFVHT1BLN21yRTFudmZ0?=
 =?utf-8?B?SytKY2ZLRmROZTBmUGxia2w5bXk5MnFnb3pzRmo1ZFI3cFNxc2labWVIQ1Rx?=
 =?utf-8?B?Rm1oRlNZdnVtY0lOTFgwenI3eXlVNmpZRzVYdXN0VmpHdTRhT3pQeWdqamh1?=
 =?utf-8?B?TmxqMkQzU2JyNzRGdGJjUHpZd2NQZ21jbXBZYUtDZjl0QmdiK1g0NmpyL0t2?=
 =?utf-8?B?K0U2T1FUL2VXcmlUd05sS1BrQk1jcW4xT3ZYT0syMTRWYW5pc1ptY3FqY0lF?=
 =?utf-8?B?TFdGdG04R2JiemJORjUwVThwTU9iTkJtNFVtK2FNa1g2UFB1ZkVlU3VCSCs0?=
 =?utf-8?B?NHphUzZ5VnBCRlJYdklUQ1JMNDZTVlFNSkJiRjFiVjE4ZVBYdUJpWHBpSm9n?=
 =?utf-8?B?Yk5xRURZd2dnS3ZWcXFYNFVJNWQyR3pxQ0ZpdzRXUzAwR2VtL0x0dzlVZWdI?=
 =?utf-8?B?TEpiSStZQVlXZ0d1MkFCc0xFZXJ5NTZ2MjJhMEh5WTdiOGs5Z0YrZmhnNy9J?=
 =?utf-8?B?M01TVk9CN2ZlTkdoeXJGM0NjckZab1l4cEZESG5UTUc0WjdWZkg5K0NEMUMz?=
 =?utf-8?B?eGVxeDU5aHZBUGkvc1NJNnU0bWNKNlk2MzZmbWFiTmRpekcySG9uTjBsK3Rn?=
 =?utf-8?B?aGtTVTBKd3hsMGhIWmRtak9GTXNQR3JmbzZvNUJwVGFLQm1xSUZZUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7375a60b-4ba1-4dba-65b2-08de7ac5544e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:41:47.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghE1Q+CVlpW84dj6dlDj/OZGln4glV/ol3T3fKQkDZgy6IemnOhURFug3XUZKK+nBz+sg2wreEmkFTZwf3zssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313
X-Rspamd-Queue-Id: 65525213C4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-32521-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Action: no action

This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP
IW611/IW612 chip family. These chips are tri-radio single-chip solutions
with Wi-Fi 6(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4.
Communication with the external host is via SDIO interface. The driver is
tested on i.MX8M Mini EVK in both STA and AP mode.

This driver is not based on mac80211. It derives from mwifiex, but due to
significant differences in firmware architecture, host command interface,
and supported features, it was not feasible to extend mwifiex without risk
of regressions. Thus, a new driver is introduced. Future NXP Wi-Fi chipsets
will also be supported under `nxpwifi`.

The driver passes checkpatch. WPA2/WPA3 personal/enterprise is currently
handled in host via wpa_supplicant/hostapd.

v4 adds support for TWT, monitor mode, WPA3 Enterprise Suite-B, and various
fixes and improvements. See below for full changelog.

Data sheet is available at:
https://www.nxp.com/docs/en/data-sheet/IW612.pdf

Firmware binaries can be obtained from:
https://github.com/nxp-imx/imx-firmware/tree/lf-6.12.34_2.1.0/nxp/FwImage_IW612_SD/

Change history:

v10:
  - Removed all remaining OF code, since DT bindings were dropped and
    OF usage is not allowed without a corresponding schema.
  - Updated all commit subjects to imperative mood and fixed non-imperative
    wording in several commit messages.

v9:
    SDIO updates (addressing v8 review feedback)
    --------------------------------------------

     - Dropped mandatory Device Tree matching in SDIO probe. DT parsing is
       now optional and no longer affects probe success. All unused OFi
       match logic was removed.
     - Removed pr_debug() and all probe()/remove() entry/exit prints. SDIO
       now stays silent on success, consistent with kernel expectations.
     - Removed legacy assignment of MMC_QUIRK_BLKSZ_FOR_BYTE_MODE.
     - Dropped deprecated `.owner = THIS_MODULE` from struct sdio_driver.
     - Reworked SDIO comments to follow current kernel style guidelines and
       removed verbose “This function …” comment blocks.
     - Modernized firmware-ready polling using read_poll_timeout().
     - Rate-limited intermittent ISR error messages.
     - Replaced sprintf/mdelay/memmove with scnprintf/msleep/memcpy.
     - Added missing return value checks to sdio_enable_func() and
       sdio_set_block_size().
     - Removed the dependency on include/linux/mmc/sdio_ids.h.
       This ID table belongs to MMC/SDIO subsystem and is handled separately;
       nxpwifi no longer requires this header and the update will be
       submitted as an MMC patch.

    Devicetree bindings note
    ------------------------

    The previous version included a devicetree binding document for
    `nxp,iw61x.yaml`. Since Device Tree support for this device is optional
    and not required for current SDIO-based bring-up, the binding has been
    dropped from this series. A proper schema will be submitted separately
    once DT usage becomes relevant, so that binding review can be handled
    in the correct subsystem and without blocking this driver introduction.


    Initialization path cleanups (aligned with upstream mwifiex)
    ------------------------------------------------------------

    This series ports three upstream mwifiex cleanups which remove obsolete
    asynchronous initialization scaffolding:

     - Based-on: c2095eb63319 ("wifi: mwifiex: remove mwifiex_sta_init_cmd() last
       argument")
       Dropped the unused “init” argument from the STA init command helper.
     - Based-on: f996f434aa78 ("wifi: mwifiex: drop asynchronous init waiting code")
       Removed all asynchronous-init waiting logic (init_wait_q, last_init_cmd,
       INIT_DONE transitional state). Initialization now completes strictly when
       the last synchronous command returns.
     - Based-on: 659d609bdda5 ("wifi: mwifiex: remove unnecessary queue empty check")
       Removed the redundant “command queue empty” check after init; retained
       only a WARN_ON() for future regression detection.


    General cleanups
    ----------------

     - Numerous comment style fixes across SDIO, HE, VHT/HT, and main files.
     - Reduced verbosity across the driver to align with upstream expectations.
     - Small structural cleanups and dead-code removals.

v8:
  - Standardized multi-line comment style across nxpwifi driver files to Linux kernel
    convention.
    /*
     * ...
     */
    No functional changes.
  - Fixed workqueue cleanup and error path ordering in nxpwifi_add_card(): ensure
    proper termination before resource free to avoid race conditions.
  - Corrected spelling mistakes in source code and comments for better readability
    (e.g., Dimentions -> Dimensions, interfacces -> interfaces).
  - Added Device Tree binding schema for NXP IW61x SDIO devices (nxp,iw61x.yaml),
    including properties for compatible, reg, interrupts, wakeup pin, and optional
    calibration data.

v7:
   - Addressed review feedback from v6
     - Removed unused variable `ext_rate_info` in `nxpwifi_rxpdinfo_to_radiotapinfo()
     - Radiotap handling fixes:
       - Converted fields to `__le16`/`__le64`
       - Applied `cpu_to_le16()`/`cpu_to_le64()` for endian correctness
       - Replaced `jiffies` with `ktime_get_ns()/1000` for timestamp
       - Validated channel frequency conversion and removed redundant code
   - General cleanup of endian conversions and Sparse warnings
     - Improved HE capability setup via `_ieee80211_set_sband_iftype_data()`
     - TWT configuration fixes:
       - Updated structs to `__le16`/`__le32`
       - Corrected debugfs write helpers for endian conversions
       - Removed redundant conversions in `nxpwifi_cmd_twt_cfg()`
     - Scan handling fixes:
       - Changed OUI variables to `__be32`
       - Used `le16_to_cpu()` for `ext_cap->header.len`
       - Moved element pointer declaration outside `switch`
     - HW spec parsing fix:
       - Added `le32_to_cpu()` before `GET_MPDU_DENSITY()`
     - Cfg80211 handling fix:
       - Moved `legacy_rates[]` definition outside `switch` block

v6:
   - Removed custom locking (main_locked, main_proc_lock, more_task_flag)
   - Refactored main process to rely solely on workqueue
   - SDIO interrupt now only queues main_work; avoids direct call to nxpwifi_main_process()
   - Introduced atomic iface_changing flag to block main process during interface transitions
   - Split monolithic main process logic into helper functions for better readability
   - Improved exit logic to avoid lost-kick scenarios and ensure all pending tasks are processed
   - Replaced rcu_read_lock()/unlock() pairs with guard(rcu)() for modern kernel style
   - Code cleanups based on review feedback

v5:
   - Fixed build errors introduced in v4.

v4:
   - Added support for TWT (STA mode)
   - Added support for Monitor mode
   - Added support for WPA3 Enterprise Suite-B
   - Bug fix: In BGN/AN HT40 mode, throughput was 50% lower than expected
   - Bug fix: In STA 2.4G HE40 mode, throughput was 80% lower than expected
   - Use wiphy work instead of general workqueue for cfg80211 ops
   - Introduced RCU protection for ba, rx_reorder, and sta_lists
   - Used per-TID spinlock for tx_ba / rx_reorder lists to improve
     concurrency
   - Replaced mutex_lock with wiphy_lock
   - Reverted "use tasklet for Rx" (back to workqueue)
   - Refactored HE capability handling for better clarity and
     maintainability
   - Used standard kernel helpers for MAC address handling
   - Replaced proprietary nxpwifi_ieee80211 with standard ieee80211_mgmt
     structure
   - Used u32_get_bits() for VHT capability field access
   - Replaced LOW_PRIO_TID with TC_PRIO_BESTEFFORT for skb priority
   - Removed static WPA/RSN OUI table; now derived from cipher suite ID
   - Removed redundant helper functions: has_vendor_hdr and has_ieee_hdr

v3:
   - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
   - Extend driver version string with hotfix number.
   - Remove Rx mlme work.
   - Remove all useless check of netif_carrier_ok().
   - Merge decl.h to cfg.h.
   - Remove unnecessary check for wiphy parameters setting.
   - Synchronize following commits from Mwifiex:
     wifi: mwifiex: replace open-coded module_sdio_driver()
     wifi: mwifiex: Fix interface type change
     wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
     wifi: mwifiex: increase max_num_akm_suites
     wifi: mwifiex: duplicate static structs used in driver instances
     wifi: mwifiex: keep mwifiex_cfg80211_ops constant
     wifi: mwifiex: Fix uninitialized variable in
                    mwifiex_cfg80211_authenticate()
     wifi: mwifiex: remove unnecessary checks for valid priv
     wifi: mwifiex: Fix memcpy() field-spanning write warning in
                    mwifiex_cmd_802_11_scan_ext()
     wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()

v2:
   - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
   - Remove useless header file semaphore.h.
   - Use static variable for cookie.
   - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
   - Use error number for error code.
   - Remove unnecessary private ie definitions.
   - Remove mutex async_mutex and related code.
   - Remove unnecessary work queue.
   - Add the support for PSK SHA256.
   - Use tasklet for Rx.
   - Remove unused functions.
   - Remove compile warning.

Jeff Chen (21):
  wifi: nxpwifi: add 802.11n support for STA and AP modes
  wifi: nxpwifi: add initial 802.11ac support for STA and AP modes
  wifi: nxpwifi: add initial 802.11ax support for STA and AP modes
  wifi: nxpwifi: add 802.11h DFS/TPC support for 5 GHz operation
  wifi: nxpwifi: add WMM support for QoS-based traffic handling
  wifi: nxpwifi: add scan support
  wifi: nxpwifi: add join and association support
  wifi: nxpwifi: add channel/frequency/power support
  wifi: nxpwifi: add configuration support
  wifi: nxpwifi: implement cfg80211 ops for STA and AP
  wifi: nxpwifi: add firmware command and TLV definitions
  wifi: nxpwifi: add command/event handling support
  wifi: nxpwifi: add data path support for STA and AP modes
  wifi: nxpwifi: add debugfs support
  wifi: nxpwifi: add ethtool support for Wake-on-LAN
  wifi: nxpwifi: add utility and IE handling support
  wifi: nxpwifi: add init and shutdown support
  wifi: nxpwifi: add core driver implementation
  wifi: nxpwifi: add initial SDIO bus driver support
  wifi: nxpwifi: add Kconfig and Makefile entries
  wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver

 MAINTAINERS                                   |    7 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  280 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  594 +++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   73 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  339 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  837 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  158 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  251 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  826 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  993 +++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 3962 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  458 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1149 +++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   96 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1094 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2373 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  480 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  607 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  788 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1673 +++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1773 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2763 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2327 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1165 +++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3387 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  862 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  242 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  190 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  352 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1197 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  488 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  478 ++
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1523 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  128 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1308 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   77 +
 48 files changed, 35923 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

-- 
2.34.1


