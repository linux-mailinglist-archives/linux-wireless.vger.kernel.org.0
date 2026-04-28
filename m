Return-Path: <linux-wireless+bounces-35513-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLrYMaoN8Wn1cAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35513-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:42:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE048B41C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE51307F9C2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC2383C65;
	Tue, 28 Apr 2026 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bF9XRR5B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C234D915;
	Tue, 28 Apr 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405275; cv=fail; b=YqADyyUGJg0pljoBRzxv5tlfbM5KCN7vNMNeGdttXfKd7OkgBtkgrNr5sQZg+aoNcgyDIsvPCDO7irzy6cB0GvL03EgM4kaJoL88MTulN+OwLDM6Xyh4w0ejBD2y1i/pRoXNzanuX5UBcRt8Ky8GC+K9b3ormSVl8spayVbOCtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405275; c=relaxed/simple;
	bh=EsBcT4gkDDdzBLgAUanpr/OCx/do5y7WSNODoFdvNiM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EwB5KNtNlO9QJ4AJ/NZA4kmHU7ldHMKQiClnCiSth56nIdeMMJzHMWM0LUD+UD0d/P1e379iyIsvXPWO+Y6fg/tVK8elTUo1lw3fai+QgwTgMHlMpTkJ4VLrj9UG+Fr9cyoRW/thkb1tNnYrU8zYMFHH/8ujJZtHOoKYPPtw/CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bF9XRR5B; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmQqXwwAjxuPrP/oxaZidkr3noHIyvJcIOBcC7U0ZUbDTSTQr0Pwx0vcyv9hh964WNjQuRo5QOQtPqnQVSW367rbsQ5Z03veTjw8lkDpbK+DcG2edCIHqAXv0bZf5T/9cAByYOzKhP6ahP+EWlCGUFwjz/VUR0yPq1A2+Phn1JOJjv0Hw49hQHvAv5RRR8rrQKpfPGmvVXhzDJRu0DSCf6yjEfo3XREHGO0LROm6D5lKTpLAlNFlKaXNM2rUmrsdvWotGgyrh4m/fVVLoOCF269BmQglbNs3TeLUqkf+5cK7QgfIKx3OBmBu9J1XUl/chBl27muqeCwkkK0jrICkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQF2QS61iy1QIrVoeL+NxZH+x30TBejXk2exrxcSNPY=;
 b=xY6RCafE0j8FMfSJl1FBjo2+ol9sNVX9dyycXuxpcJSeJyENZxyZfP5Ag8W3YpZz0TWBASVDUGQG8/cjNFxtcH4V+kRMnAcnJlWhwlibJ7lYWfAK/DkyYE+OQ1t0b9U7Keiy0qCt1dqDUr09Er3T6QqD0p74tJmpzWxhK3/kaYJOEI7tOkSXJHAzYzC581VhSim9yAufbaBfEB2TCn5sKsdekpX6nLsNfYKXQIBgXPeyVKJP2Yxia3jOJUGlQS0SpruFSH3rbiTirFa6eXVS1fcy+TLr/i0j1WXPYBu74trpNg7TlMIXBGVdNMo9vFTzeHe5XB9+IfLD/5b7R/1MVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQF2QS61iy1QIrVoeL+NxZH+x30TBejXk2exrxcSNPY=;
 b=bF9XRR5BuqIDPXpLtYNcXqqCiapYLEdn2kqmOc/kTDxTOSmzRMwoqbMOqo+hiKvjCCl7Cb50LhwBKoCCW77KT5zbyvdzqumOIQbjeuIsyLkgxpAsMc1e0vyxWHVSwBNIB3IC/XY/9D+rlzSBP5l34s3GTbyNnaE4Who8H6OYVvQOEh9vQ7rZqzvaid57bHFaPuDMJaqJi11AygwZtpu08cHdx+6YkevuzpmOEvkEsP/2modmMEryJcFePaxRMmjl8s+/u9H+WajgMtvo/GCfJm8CZv2/5dEfGx5pAw/oXfUudlyuNsJFubmVvRZUQO0Sc333NHn434UU8BpCrEMaeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS5PR04MB11371.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 19:41:07 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:41:07 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Date: Wed, 29 Apr 2026 03:39:59 +0800
Message-Id: <20260428194021.785252-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS5PR04MB11371:EE_
X-MS-Office365-Filtering-Correlation-Id: 742698e2-4214-4d50-c0f4-08dea55e1721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	AVqXrnbvF9aUcdrycLOy3joVYzNGv69GWOz+kHwREPhQ/PSVMVCjZGBRMJiSVoibMcXu1TeqGbrD1VTsmMx/T+zVc+KWvDC2QIMvCd1Hdw/S3nm5jO72CKS0WnOe8s8P04DIfF1KJjO7HOroAimLQwP6IcBnZ3DfmALowvfZARJLizv8BqypraxFvzYqTlCoX5DRf5RTO9tPUWUbYSxfkLmpq7sGd7t4oeIJ8lABUmctOFTOyAs8YwF4GGTkpkt0JjHMmxX1dCCWxaAQUVYIpg372Dmifosi/oZ60I2QFpllawhMVJ3VPI7arFez8wEgLDCRehMTVgMj8lRDfaMA0Ypb370OIxxXWSqAYv+oF8Fd8pzV9szmJBvO+NMxVVasV3SpkraZgXdXFuNYF/xDV57OD80mTwiVEhw368HptTxyrnrcWZLNG61+30PwFGxznVvlIFTgR77z/FJfE72/cnHokTcYRn7j8LU5WnifAOc5hN1lu01X9JmJ3xRib7rMyrf0PcPJYLNHKtG0vxsGLX+6jtdkq9YsmuhxSSGQpyRkwar3nrDtb/NQKtfjfiJ/pTNxrjdEevn15WOi5LWtptNlmKib5duE0n0Y5lgj7GuNb01hlQDPIPbXQbcs3XqvMFdx4xne7F6/+knR/k5LPaXt3DYvBVCXsPBWBft8dYj0G/Coy1YwGNxLLCL6z0RZGZKIUHxdY/BR3ARPFPTL9kvr9mukr5buKv91PxTGmWsRRY5zunQbDtrA/F7wBq9Jljexwab5gkM153xCituXWM51bM/masjTDDu2DcPlYvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWsxZkpHTzR4ZGxhSVhWV21kRTRFdkZBaVFSMmhzVHhodm8vVi9iVXQ4ODM0?=
 =?utf-8?B?L0xjYjVVRVo0VTBXbG1SOWlVNC8xY1dCYXc5bEZianRoVWJiSUZtallTSDZG?=
 =?utf-8?B?VzBjK3pOakdrZ1V6VHViWlkwTXN1eXdnRDZLa0g1RHZVN0V5MHBjN3E3ZkZx?=
 =?utf-8?B?cVQzcUdmU2xKclgxRnNiZjhaYlkrTWNka1dITkNDS0JRREFyRjN3ZDlQakg4?=
 =?utf-8?B?c3puMHJZWW9CaHhlRktqOC9ZdU1EdFFqKzdxMUlnSkRMMzdWTm04UWhNaHEv?=
 =?utf-8?B?ZitPOWdxOGRsaFE2Y1lPVzdBR3hZdzE5eFdoMmRlNFZRc3FNeFlycDY3cXVZ?=
 =?utf-8?B?S1VEWnNNUENtTTFkdkVWYzBpNmFyeXZOaS9Ha0tHaWdUYW5kWkoyU2kwTTQr?=
 =?utf-8?B?V0pENHMxZ1Z0MDBQcUtZT1hEVjd1QUtJcFlzUWltd2RYVHMrZzZBaEdPclpD?=
 =?utf-8?B?dlhzMDBsbytYVlcxZm9ERXZZNS95SU03WDdPMCt6Q0JOUS9IYXQ1WEdDUUF0?=
 =?utf-8?B?dk1NLzJwRFBFSFpIT09tVDB5VCtjcVVIMWc2dXBacmJ0aEVORCtYRm9uZEha?=
 =?utf-8?B?bktCZnpqUzlHL1F2Y1lpQW9uNGlVNzBDLzF3cmd1K2ovNUNpclJLUnR0a2pB?=
 =?utf-8?B?NjlzbXhIdkpTOE4zdjVJK25kVldnZEh5YXZpRWtXaWdpSXZicHNUb2ljREl3?=
 =?utf-8?B?bjZ0N0dydmQ4emkyMVlreWtEWUFzakhEcjJueXFIQkFoYXFUUURGZnlPMEt0?=
 =?utf-8?B?ZU9LaEhrV2pLRkJPQlpYNzQzQmFQMzlmUzAvVzZ3RWN1UGhFYnhtM09aM0xL?=
 =?utf-8?B?MzR1bzUyUnRDOUFRUDhHOGkxSE05bkhyWVR3cTkyNEF5dUtoTHFhVldNS016?=
 =?utf-8?B?UVhDcjkyUEpTdzNXd0s4aXpteVdpcDUrRU9RSXBWZUpmWHZycEgxV1hhU29G?=
 =?utf-8?B?Nlk1V242cVliUXVqeXNFMnhEOGV2VjJMMmR3amF3S0d1RENVYktzOXFIYWVZ?=
 =?utf-8?B?bmhualVneHA2VWFrdmkzOStFcTBveFdPd3dEYmxzekZTeVJwYzErb1JZZ3Nu?=
 =?utf-8?B?elZVazRDK3d2RTlWVFFBWkMxQzQ1ZyttRE5VdEx6eWdXZXFQMVR2NmJDbVRX?=
 =?utf-8?B?NFAydG5DZnhjd0Z6d0dmWkh1NFhFaXYrcFo4UlVxU01nY0U3ZmhuL2psZnp1?=
 =?utf-8?B?dGx2V2VzeFp2bURLZjYzeG1qT0YyYms2cUlBTDFQZDk5all0Q2RHd0didFl4?=
 =?utf-8?B?cVJHRWNCa2RKM25FeHV0b1Z3bjFLWlpDU1NyVitOaUdWQ3R3c0M1M3ZFS1po?=
 =?utf-8?B?RUpLQVBwZkpyVytkYmlreHQ5cXVhTkhqQnZRUVRWM1lBVElnWmp0YnRHNVhr?=
 =?utf-8?B?c0J0SGkwRGYxVVB5OVB1MTRiTDVRelNCWjQ5VEUxWmdYbDdUaHN2L0pYQzU2?=
 =?utf-8?B?Y3dDdVhCb3lkejhTMUVpcEI1d2ZRU0R6WTRCY2xsU082Y2NJQWsvNVlJUlZW?=
 =?utf-8?B?NWo0K1NPczdvOGRrNytDWnRHR2JTUE9mVlIwL09vMDVlaWRod2RqWkE1TFJm?=
 =?utf-8?B?dWhNQUtEcjR5MHg4ZXJJZ09wQWk5TmVKc3o0T0JZcC9hNzF2N1ljZElpYk8z?=
 =?utf-8?B?N2c4a25iN3hqZldtYk84SVRCTGJzYmRjMG9idzU5bUVVSHJIRHcyK2FLUy95?=
 =?utf-8?B?NWNmUk5YeE5CNDFNUks2aFFvTkJKRGVRd3VWKzJrUmhsbGNRNnpEUGppRnR6?=
 =?utf-8?B?ekpVV1dEalZGVXY0dzVndFU2OHFhQWRQTzNWL2xZTTBneFVncys1eURCdUZm?=
 =?utf-8?B?Qzc3UjBJVEZvenUxeVJCQW9MN3MxR3pyeU8vbnd6Tmg3bGV1ZHdSMWs3QkdK?=
 =?utf-8?B?SzVNcE5CSXJzbDdoSUdhRU50ZE9WaTBDb2dSLzA2R0wvTjhkaUIrODdPK0hW?=
 =?utf-8?B?SEc4MnRzdndUK2tJZEdrcXdWOHE3WHZ1M0V0TVl3UVFyWGJ2U1BSVnA3MDhT?=
 =?utf-8?B?NFlwM0hwbFljdHJiWTlabm9WK2lHa0dabENrWkZZV2VpemJ4NzNta3JPQzhv?=
 =?utf-8?B?WE5pNmtlUTRoMHdpcjJMU3lKbjM3U3hHeVZjRlE0b05qcGhnYUZvTGFPNW5q?=
 =?utf-8?B?Q21Eb0tMTnFabnk0bFl6RkxZL2RmMHZmZ2o3Zi92WHRRTldScFNjY2xxS3E5?=
 =?utf-8?B?bHAvdCtXZS9QLzMzbmtHbDdnbGxiamtzUEt1UEp6UWpqeVl1Z01NTFdwQ2RX?=
 =?utf-8?B?YnQ4KzllQVVmUmdOcHh0ZlJpRzhRSit4Ym9vd3hUbVc0OVVLeGl3VENjNUdT?=
 =?utf-8?B?RGtBQXhqWWNSZk1DeWZ1SklYWkxiVXBZMmpWdzZEWCt5YjBKcG4ydz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742698e2-4214-4d50-c0f4-08dea55e1721
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:41:06.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCXMVh3j2hDNaeVSo7GcSOMtd5cVhHh5ECWEM685iM7b9r+C7Xhu2uiE8pSAp+lb6wWG3bZda6JKwpGWnMS5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11371
X-Rspamd-Queue-Id: 5BCE048B41C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35513-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:url,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

v11:
  - Added MMC core support for NXP IW61x base SDIO card ID, ensuring that the
    MMC_QUIRK_BLKSZ_FOR_BYTE_MODE quirk is applied at the card level rather
    than from the SDIO function driver.
    This addresses the IW61x SDIO identification behavior, where the base card
    reports one ID during initial bus scan while the WLAN function reports a
    different ID, and aligns quirk handling with upstream MMC architecture.

  - Cleaned up legacy ioctl-style command usage in cfg80211 paths by removing
    direct nxpwifi_send_cmd() invocations and routing these operations through
    explicit driver helper functions. This reduces duplicated control logic,
    clarifies command ownership, and aligns nxpwifi with the expected
    cfg80211-based control flow.

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
    (e.g., Dimensions -> Dimensions, interfacces -> interfaces).
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

Jeff Chen (22):
  mmc: core: add NXP IW61x base ID and block size quirk
  wifi: nxpwifi: add 802.11n support for STA and AP modes
  wifi: nxpwifi: add initial 802.11ac support for STA and AP modes
  wifi: nxpwifi: add initial 802.11ax support for STA and AP modes
  wifi: nxpwifi: add 802.11h (DFS/TPC) support
  wifi: nxpwifi: add WMM support
  wifi: nxpwifi: add scan support
  wifi: nxpwifi: add join and association support
  wifi: nxpwifi: add channel/frequency/power (cfp) support
  wifi: nxpwifi: add configuration support
  wifi: nxpwifi: implement cfg80211 ops for STA and AP modes
  wifi: nxpwifi: add firmware command and TLV definitions
  wifi: nxpwifi: add command and event handling infrastructure
  wifi: nxpwifi: add data path support for STA and AP modes
  wifi: nxpwifi: add debugfs support for diagnostics and testing
  wifi: nxpwifi: add ethtool support for Wake-on-LAN
  wifi: nxpwifi: add utility functions and element handling support
  wifi: nxpwifi: add driver initialization and shutdown support
  wifi: nxpwifi: add core driver implementation
  wifi: nxpwifi: add initial SDIO bus driver support
  wifi: nxpwifi: add Kconfig and Makefile for kernel integration
  wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver

 MAINTAINERS                                   |    7 +
 drivers/mmc/core/quirks.h                     |    3 +
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
 drivers/net/wireless/nxp/nxpwifi/cfg.h        | 1019 +++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 3929 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   18 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  458 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1310 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |  122 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1094 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2380 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  480 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  607 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  787 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1673 +++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1776 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2695 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2327 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1165 +++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3387 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  862 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  242 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  190 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  352 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1256 ++++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  488 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  478 ++
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1523 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  155 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1313 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   77 +
 include/linux/mmc/sdio_ids.h                  |    1 +
 50 files changed, 36138 insertions(+)
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


base-commit: 7baf5857e15d722776898510a10546d6b2f18645
-- 
2.34.1


