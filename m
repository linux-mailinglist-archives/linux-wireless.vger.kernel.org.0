Return-Path: <linux-wireless+bounces-37805-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rmWXESquL2rUEQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37805-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:47:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C76844E7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:47:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=fEZcTYuv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37805-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37805-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91F6301FD59
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BE35AC12;
	Mon, 15 Jun 2026 07:45:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0630C17B;
	Mon, 15 Jun 2026 07:45:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509530; cv=fail; b=b+6bgAk3291/W0Rae/NgynovBfJXHcTHYrXfjILhLdL5+4xg91XdECdZJ6//7blTWC62yEcblVdaKcFT/p81/QH0/IKHgOnut3D4NuLLCA+bpFPzvfONfZdmigY1zVxFbaKgnEpmlxTGgWDY2ht9CzWMBNAGay1EgypuAbsJQEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509530; c=relaxed/simple;
	bh=XqBVLPlTcMmJtsVTPb3Ha6TT/wgOTJb/9fjtWfexcmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tA812j24QzJi/vS/+9FHl07kRLav3YQRdSHTJwqEpo7MJFPzM9dcg4AJLGGnBid2yA3kRywW0MZql8/NMfcrLDV0wf9qH4+FIaz9kRhbQXZtOGOQvVJ/TK6UYp4rlwYA72nLoROEL1+D8mR0ggmG8jlVz5c8F+fkGHkGDoRyO2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fEZcTYuv; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VD5dnuuUheHPp/AKW4VBu7CM4Hsue0gN0ay5axOwbj1pfdPudvv8EXCc8SDvumw0VaheVwOTWG7d+Wt+3yRHF+3Pk5pxvdKnaldGXNxAz/ZRIfheyy2V4KIfhi8C6E9VOd/Mko/hVLOPDKSIuyW8vJWL7Ld9jtBBWDh8Ta9uwnicEqdjel2lGuQ7wQR4disZJRmd+gY+Grp3e+u+3lvQQvWIQrr3DLipsodmRkdygGnmTebrC2+0UZi7JmHh7G4kNNkWuyGSdGiJ5RKvctZSrfGklzhlajVN2TNclQqLtNHIiV5BwbCn0D5AcUvT9agp2oIPBuo/ddMH9c2UGl8wGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amimOA5PiDQC0cqClFKI92XABeGiGOanr/jSMYskzTE=;
 b=BlJGIL+xJZnIwehOoFLdjC6y1X9AIDhP70zEawOvPbOaO/qjK+HiFqMIk3a78nExA89NMxHgnDz+ngUXnhDxYDj9OnvlObqVPrZFq7cuJMabwmugU2D8jmchNVnP+nZtXGvqY5IHtRHcHytHYqHXwK/KgEnaaXB6aBbE5XX5Cn4EQ4eVd/hhFTS4LedG/XKPkY1rcnK2Du9csH+gqprD0fwzRZZMbmhlFJUO6XhIzcyHHidXbBzRWVhBF0VQAAPjM82QDB7XNthnrYO4Djy/dF2W6cphmhafvLSSvDlylMpNpFQqTLM/3N+VDbLaT5D36zeR1jUXi/dIuam8EWC/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amimOA5PiDQC0cqClFKI92XABeGiGOanr/jSMYskzTE=;
 b=fEZcTYuvKb7h+bjDG1GAWHP4Pd6m1JbRBWn537GlkiraalHi32wo6eDESErt0Nnn+sUoiUruU345JHmq7Q4hlk4rAu4DJM6YDFS3nNJIi0S9zu+lRCeKHmkXDdWvTY+DI4QAXdD7r+EeM2QL861EcnmJO5h/DRZb0JQ/tVY1ndW91R5JwJx7J48MYIhl7t1WlCDqXI61VdNE2CBbn3iHd4WZapXRspjkgFO6zAiKJ666wI0Olq1c5Jz2uW8hpf8nWeazFxnu4r8pvVHUH7p/0ZbsqPF2S79PvctJoipnPn/506pBc6AOk4WbeUflb5Vf48yP0z4ZYQkcmYyFcOMSEg==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:45:25 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:45:25 +0000
Date: Mon, 15 Jun 2026 15:45:44 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Rafael Beims <rafael@beims.me>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next v1] wifi: mwifiex: fix permanently busy
 scans after multiple roam iterations
Message-ID: <ai+tqAb/kCkwbh7l@nxpwireless-Inspiron-14-Plus-7440>
References: <20260612122547.1586872-2-rafael@beims.me>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612122547.1586872-2-rafael@beims.me>
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 2587e5ca-1d97-4b16-32e8-08decab20ff7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 Uk8CArJbsFh+VzViZHUs19C3turum4HJXHgcNyhDjUkiVESNNIXdaeWDJjl0Dt66jsQh3kSyyQGPDD4mkL2QL5gENqqN4Fl/Heq1ei+IwbUQ7vOcBBuK80dOdoT1TC9jlZoRQxv70IdAAbplyDChkMZIVrn6w4HJwKShQXJLv/u2wphsVoMI6zf7YWG1qAkkVZo8R4Ey8NEFIllR20zp1tYzy++gfgIo62ssQLNRONLQqH/5zxUsOjqxFhLg2TJQ+0mdFqzdOMeGJv0loeoeVVoS6s7SOSpgrR1lvFkh72g/nDbeK3XoXm9SwNNAVxzxA9mB+eiGywLmBWqcIWCcR1fqeBn0oAFEtAB8AgpJZZY8yOepvi+gbDj83zmmwxzgkvC3IpC9av8j0phkDviIdKL3MR8SzHR7tCrzGI0GYR6KczXq+TZnon973kSKqwKawS9WgDyT0anOBB5GaUs9IgUlcvkuo76qac8dUDR1Jip9r/POkzJLehUjscjOBsdV1n17PodSqcnaPtNBNljtzQHiP8t8KOFEtN9LVZeOzcy8ZcI3v3D48jEUwnBR+BtvR/ko0aQoBUnkfihUqV+UlPAYVoE3NtdQxNft3uZqAIYbbk65uB+jIMDfeLfLazQZjs/nm5F0UsyvCK3dH/zsl86fdp1E6v9RBls3LMgvHQ3ljKAQOj4KYJxtAYK2LabxmN3nD1pm+Xovxglj3lPa/F6+Rh1G/391dXRWtcXzf/9LVOQzwc4OIhnivPjZhP6q
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(38350700014)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?enJnZHRLVm1jV1o3c3EzUWZYTE1LOUNzWEo0c3N3SGxhUHp0U0d4YytVK09W?=
 =?utf-8?B?Q1JQSmdzZmRvbmpvOHZHM1RaTWRxYkhRb2FMVmtDMkU3ZXhtdktPSkpqRzB4?=
 =?utf-8?B?bUg2TWFVRVFVRVQwOWRUazlWK29VM1huYVF1R216aFY0Q083UEJSVmNqWG1u?=
 =?utf-8?B?amp5ckdVSThZSnZIYWU0UVpkaGlFKzUyNVA0N2U3cVdSWE04QWE1emYxN251?=
 =?utf-8?B?TGxyemlVanN5TWQ5bkhrWHNQV1NiZ3NjMm9SRWRYM2hJMWR2d1cvMzQrZE5M?=
 =?utf-8?B?K20rSGdZT0R3U1hFNGRzN0hIbk5JcHUyMHZnTzljRzNtTFBwRnN5OWZyVkFp?=
 =?utf-8?B?WGFqVDZ6K0gyUC9oOU5mZ1VGQUd2Q3FhQWJUSHl0RnJBUEN1SEtROUt3QjhM?=
 =?utf-8?B?SG02dWQvVkRjV3ZWb2toUmV4V1daclREL2k0aDZMaUc2TVpORE1TNlVMcFAz?=
 =?utf-8?B?d3NzTjh6OFdzUG9xcEFZc2loUTBzbXhOMlk5SVBZeXlxWDEvOGNpODdWQzRl?=
 =?utf-8?B?Q3BOZm0wTjR6VWdOZnBYaVVoTTA5djhVS1VqRStsWEdtWGtsZWJ5cGgxQ05z?=
 =?utf-8?B?KzFWc1hOS2ZTZDlyeWlFODIrUTdXanllejAvWVpoY3lZVE5xWXRCa2ZCVTBy?=
 =?utf-8?B?a1cyL1lBS2RqbGNPdE9iU1R6enBoRDdCR2VtTmFEWkRhRmtRalhJTlZXcFMz?=
 =?utf-8?B?cjRYVzhGZWNaQjUrOE5vZjVQYjE0cGlBM0NBSGMwR2k1SEl4Wml1eXJXSDNk?=
 =?utf-8?B?SmJMKzhIUkxneUlzU1dia3Z1Um9lRXY5bkQ1Z3BnbDBjbzY4UmdaZWVJMjZu?=
 =?utf-8?B?UlZzemorZi9Eb2RsMCtZMlk5VkpoSXNYOHBPT0RNN2MrS1FlU3NLY3B3cExu?=
 =?utf-8?B?SEJMWW52RUkwUXFaZlBPYk12ZDVLMUNoVHY2UWFzbUhuRDg0SE9QbmZ1WlZC?=
 =?utf-8?B?eWFSd3VwSGd0V2h4enlTRjV6cUErbzlnQ1g5WFZ0eCs0dDBldW5sOWY1YlJO?=
 =?utf-8?B?VmsyVkVibU9nSkZtd1BML0hOQVBpRGhVOUt1dSt5cStWMnVnWGJHUXF1QW8z?=
 =?utf-8?B?dHVNbVFmaUV6em5kRnFPL25RN0J4eUZKUXN2WEY1b2h3VVB0aHFOa0pRdzhT?=
 =?utf-8?B?RDBSREgrRFVJWVpRK0FhMFdSaUJLYjgydk9JNDNHQUVGR1VZeUdHTFFXSlQw?=
 =?utf-8?B?clhjSlN6QUNFZTZkMXJJbnQzOEdkTG1JRXhXNjYvenRYQ2ZQenkwa1c1SlVq?=
 =?utf-8?B?Y0QrYUgvUXBuenhFcXkwOEN3UjFkMUtmNmgvU1oxcmVxYkYxZnhxdlZXR20y?=
 =?utf-8?B?bC85U3pqR2NoeStjWHU3RWRDako2OTU3ZmlsczFyS0ZNQmwrREhZczZYdUFw?=
 =?utf-8?B?djVJcHcxc1dWSFU4Q21nWGUvcEFHVTV1L1BMa3NmYVNQVnpTSmdYQTl1MnZ0?=
 =?utf-8?B?OXlVUmpSOHFjMTNiSUtmc1dTay8wV1QwbmFSZm81UHQreXB1a0pqdU5KOFIw?=
 =?utf-8?B?dmRwVERKZGZsSXFlWVZubW5KOG1nTmoycFlNbG5qUytYVUYreC9nYVJvZzdI?=
 =?utf-8?B?UmprZm9Gc25BT3JDb3h2VnlCcVpFdko0ZmRvelhIWFZRaHFUcnRJNTMyUXd1?=
 =?utf-8?B?K0JvWlY5VXV1aEF2cFYwQ04vMjJpNEg5bTRGWHNPQnpaT0I3OTJHMExPQitr?=
 =?utf-8?B?aW1GNWpCT0hTZm5qOEZ6VjlGeStPK3gzZ3lWMkhnNlJqVW9oVzVCdTlLMC9n?=
 =?utf-8?B?bUszczhzUklWbnI5R09PT0RXVS9ENndtdTY0L0h6QkhjbzdqOWZPQ0RIRTR4?=
 =?utf-8?B?aEhvT2ROVnlCVzM3VEI0VXpyTzdROHlhS2wrdGJ5ejBjNmZ1SEtnaGQrZ1Yx?=
 =?utf-8?B?MkF2Y1Jia2dvZTRPNXk0Y0RHRW9NK3ErNHRabEdUYUdISnBtV1ppb0YreVRn?=
 =?utf-8?B?QW5CVkhKODhPVC9EVjRDWElSakduMkhuWVM4UUJrZ3JTOXVtNm5PcG9yQm5m?=
 =?utf-8?B?c0ZETXd0YVRLblppMk04ek1PNk1xeTNrcXB1Y0RYbWhSZ1ZUdERaQnFEb29I?=
 =?utf-8?B?eDhaMzU5bWhBd1BqcEJhbmpxT3pnSlFGaFI4dVE5ZzY2Q0tzd1I1Y0FkcXFR?=
 =?utf-8?B?VGUvWnBOcThualNvWTdCOW9sN1VsOWhIVEU0eVFJUEZJRU5rNXFjWDJvL0Qv?=
 =?utf-8?B?ZE9HVldnNWpleGk0U3FZK1pvSHNSUmJsMUhpRHhtQkkvYlQ5cXVOenl1enBQ?=
 =?utf-8?B?VW01QjR0dExKOFZEdmUxdEx5UXJud1NoMmpDcUhxVTFudW14Um1NK2FETlNF?=
 =?utf-8?B?RGxGYmN6dzhFNlN6M0M0MzlGc3o2V3doYW5kVUhNMjN6Y0NBMXR1QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2587e5ca-1d97-4b16-32e8-08decab20ff7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:45:25.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogFvM3pcnbQjWRSf5MPCIAcBWkynTBM7VpXZLZ3PNEIzdOqGlyAe4aQLXSB1pSW6Lsm6N+DOTmCgCsR+Ewh7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37805-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rafael@beims.me,m:briannorris@chromium.org,m:francesco@dolcini.it,m:rafael.beims@toradex.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxpwireless-Inspiron-14-Plus-7440:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B69C76844E7

On Fri, Jun 12, 2026 at 09:25:46 AM -0300, Rafael Beims wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> 
> After testing on both IW412 and W8997, I could only trigger the bug on

I don't think there's an IW412 in NXP's lineup — did you mean IW416?

> the IW412 and observed the firmwares behave differently. On the IW412
> the firmware still sends EVENT_SLEEP while the authentication /
> association process is ongoing. A W8997 under the same
> conditions seems to suppress power-save for the duration of the
> association, so PRE_SLEEP never coincided with the association response
> even after extended periods of testing using the loops
> described below (>12hours).
> 

