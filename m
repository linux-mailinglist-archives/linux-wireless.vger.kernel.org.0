Return-Path: <linux-wireless+bounces-37421-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EUnOCJD3Imp5fwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37421-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:21:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A1649B65
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:21:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=NQRduRKg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37421-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37421-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDF130414B3
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F813ECBC4;
	Fri,  5 Jun 2026 16:13:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA713EDABA;
	Fri,  5 Jun 2026 16:13:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676029; cv=fail; b=C9aUmezjvikJ/v6SR4MYZjwATWZOxw0tV13iAdVrM/ZOGX/HChG72ZZrDs1TnqHSCuKreqO2oODDrVX6on6euuwjOBLQmP2cQOgJ+WGvERgW9m+IjbFblPkdks0QA8xo2H8vqwoqPKL2+2BPJbcwWOMbwo8ZXLa9kvBcAmwf9Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676029; c=relaxed/simple;
	bh=CaClEMalSwZAF1L8bF7L/h3qZrCwKmSrJQ9ByUR9UeA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U6Pjj2Utp7YdqEXwmXc5aPpRMFiHc4tiVWWB00Y4j8dpPP5A8y44QXZSXEb9gSm5IGsv9ONxaXOuQyomOIJ7wbNacIaLc00lzuQzNGrQj/N7Jba91/9nTfMsIPhz+fe1RRu4TNWLWx8IIVFfd8iW27BwZjhMr413xwmF7Q4Bcw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NQRduRKg; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekWJYoVBIQ1tZN6r+boMgdC58iwu7BATNpUBEa80vdj6hhx0TjEZ0GDugOG7Uz0ty5IRFWqVNusdQcNpQns1uyetTEFPNqx+gGNdb0ggHb0geMi6pkCBS3Z0Kv9Tep/xXQgFbDQOZRlPOX19uAUQcybG6THsO/IiX73RJFcDtytoi4QIKZYungDwDOiY75qGSLX7PJaOfEVtFD9HgPTZ6R5T1FT9G2rDkOF9mnjnME4xvkiX2/6KcJyzs4HMPypUYqUmhW76FRBMhbSO+/nV444l6B4rTN5yUaAaeoOBhF8LTxZ2ywglS/KkT6FNIW5tZRCqlsQK+6sX5GeaCb5K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAuNqcQHPEGS3OiVTJWGhuC3/xwM+mOn4AU1cPQpDow=;
 b=AgvsvWnYG0/BbZKmWC3UZDxHmL2jDhh9iO34MsVd6SiNA8swiZBTwnw5EkHsmpBw4UL8R7gn/N4v22nv2Abun3OxafFoyhf13UgsaSeP9WoqKG1jtyj79t/VD3ysgpZ8dgHZP2G8y4pi67I4cwLL1JSsKwOU074bFOJUSa0jzjbcDwGmSq3M4dKWfmmfTiViysNYjoqHhsJUOlcaUpOLu44zLHejh71fMirYfaj0eMEN2ClMqEHGKFJEvuhaaBID2Dm2r6bIvzmXiftDw2XEA6KKrCCcGFevTC32CR2j6k6dnmoOdyUQcVlvMbCMht8mVXi+T86vJ82Hgvc/+3Q9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAuNqcQHPEGS3OiVTJWGhuC3/xwM+mOn4AU1cPQpDow=;
 b=NQRduRKg3FIV4l3aD6dGwZp06Lc/03iXI5mgtDPjP3Fj+3KRgGeQihowOv4Om3mfhkzXX5GB5tXbogNn2mLn5XIow9ovcCZVMzFr0jorIfOOxoicU0Xmy2PZa+mlSjeXfAnNIJZPYSZ5iEb/7PvHF7QgU9CRYbfVkQmBS/pcA1pcZbbkp79AMp3oKH7+hXn8IqvS1D0nbpvEjPmg1FxnyjgdZ7Vc1d2I69XtntpFrO5L1kfzmzI61ZRuFe8Kz6rL/gc8uhezGwiqblVmy9/N0h6mkXTF75aEn3s8LvCu1tw+uZfI/rO+RG3Gj3ERgBSrgctMr+aqC2HCnRF3Sh+dWQ==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:13:43 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:13:43 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	ulf.hansson@linaro.org,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v12 00/22] wifi: nxpwifi: create nxpwifi to support 
Date: Sat,  6 Jun 2026 00:13:13 +0800
Message-Id: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcbbc25-cf74-4bd9-b4e9-08dec31d69b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|11063799006|5023799004|56012099006|6133799003|18002099003|3023799007|38350700014;
X-Microsoft-Antispam-Message-Info:
	nOWKfojUOCs55EldkPXYMrGWIiEg7T0xf4fTJrjHfV0Pqc+fUxMPrhHffabygAuGr8v1pmQ+tPgsoN8b3Ab9hYj5xJL6YO67iV/g5U5zp4UmmAg9R0EIk7s9kSuDVm/Khz0BgwJ50Yf+Nz/ODfWnPr75pI6/jlkVssNCKA9a8G6BO5SQjAfkxHgE6O9IARm6Q5KA6YCI+W+J2GsbDEep04PEvI1fMKlbLXZ9rNdl2ew/yxLZLiyfOVYupQhcaywopd/yhbU3vC2jXa7OeTch5GldJMjX747yeeiydHs+CNDTK8KGR4voeIV/YzAHBQ6ygBaBZ4qIyhdUmfMlsfJzR2exksvaI947HKa/d+oB8wCnU2OJmGi9D8te53W+wW4LUmhU0A+mHALDx+VEdtWq8IvP1tBf1Stf50SCJqT66If86Quh8Ou877A0egmeGDOxdVbess8Z3AAcxKeiima9nJ3YoqzsLl623B3DlmJGnY00zprZW4KXrqWWng5YmkRBwxetMzYeITrLRERnI3FRSK7ezWJQfnEsomDOYKeCBQFfcsoHX+ebu0XvvGekr4teqDJ1E4ggxXfglfYsT+j7sifrqE/tqHlWGEFHRNX3xTsm60ppoBqagJP/KN6DEbefzVDEecgHxONcdlkNScCbNKY8UpjzkfiHolsEgsrtR7a//YRoPwgTMPeMRvfkug0WlEO7gnHm/YoYQfb4FTZaVbnB5sLMdPJs95pp+FpEfAGdRp7PCqeH8telp2hK2p7J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(3023799007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0lRL0lUbFNnWjgrUXQvcGJNZlQ3MDFKUDlSMU5yYTZrQ3R5TTZ0VWxaUC9M?=
 =?utf-8?B?Szl2RWJ6WUlvV296bjZ3bFRtSEw5b01ld3Y3RGRyRGZSVzAvWGQ0MHZYVkcv?=
 =?utf-8?B?K0Njd3V1V256c0VHWTRpc0IxMWtYWUxkZTQ5MkdnVVRVUjdNck5mamxRWDB5?=
 =?utf-8?B?b0lsdlJpU3A0amhVZjlLZ0lkcmZTTVFKeEYzMm5kOFJKOE53QW1COVlIZnpG?=
 =?utf-8?B?T0xVZlppUjNNbVRrSk5PZDdaVlhzdnFYQmVrdkZvaFFiYTVNM3ZTdDhPY2ZB?=
 =?utf-8?B?ODJTcGxUbmNra0tuTjBqald3L2M1ZENRRDFZUi9yK2Jud0NsTTRvQk04RGVZ?=
 =?utf-8?B?MkRnaTR3TWwvTXBkMEhDZHNBWEJLZExZeGh6UmFDeTZPK0libUlaYzZyQ2tR?=
 =?utf-8?B?bmNrV21oamdMK3JMUmtkS3JWdWdLYWcyT1JlTzB2aEloTHF2bXprcjRhNTB1?=
 =?utf-8?B?T214TDk0S1RtU1ZtazlhSG40S2IyRHdlcFBocXdQMStkWTY2OER5UlpkNkN2?=
 =?utf-8?B?clB1cVQ5Z0M5ZXhiM1lqYWt0R2ZGNCs5Nzc4NHBOYlpnL0hJcE45QTRqdExR?=
 =?utf-8?B?WXBUVlVFN3h4MzczckljQTRBN2IxOHZpaDRLdFBmbm9PbUhORTl5M2U4MVE4?=
 =?utf-8?B?M0ZNTnlpL2ZBSTkyNkJsVjVKZGRvZWZ3Vi8rUnBlUHh2NXFyZWZYN2lHY2dN?=
 =?utf-8?B?b0x1MWJ6SHN2SG1mN2RndURPVDcrenVWVnBSSW56ak1TMXpydkVnTTErbkp3?=
 =?utf-8?B?NUJhdjFQbFVkY2pFZ251TlhxZzZMVW5FSkhBOGNWQk9ianM3WXBnbEZFd3BI?=
 =?utf-8?B?V3FmY0ZxYUJZWDdhRlRMNE1NWnNSNFZqbkgySlJlbjdyREo1TVZwRjlubHBy?=
 =?utf-8?B?SG9kN3RLaUttNTBSLzlnRy84TlY1bk54SE5EYUowWS9tYndlZWhOZ000U01k?=
 =?utf-8?B?dys4RG9UbVZuVkZ3dUNCS3dQZ0RNWXU3Y05mMi80aHBQUkZMSGRONC9RMXJZ?=
 =?utf-8?B?ZHdPanZCNUxaMmpjWGlWSFBnNElxeW5idXhCZnAwT201akg3eWRrcU0ydTJ4?=
 =?utf-8?B?L3VhNFAzdm42S29OVURQUHU5OXhyTi9pd2lObHhMeUJhcFg3VUZESDVxcGIw?=
 =?utf-8?B?WjIwQVladVZhQUdleWZ0TDlBbkxHYXBZa3JVTkt4WXJnYlFBVlJ3MTRuVjU0?=
 =?utf-8?B?L20wemkvRTBiL2V0UFhMd2ZqcXlKYU5rSTBNU1UwZytFa0lVbWQwOG5LV3Rt?=
 =?utf-8?B?dHNpWkZ2UVJrNXkzU21paFlzSmxDem93MnhjVEZZNEcwcFlvTlhUemtpTXd2?=
 =?utf-8?B?SFlwQ3JqMG9KckNaTDYwQWo3dTBnSlFrcHZCYjg0cVNLdmFjR01ydjZrVys0?=
 =?utf-8?B?dVY0UkZ6cTZwWWplVlFjbDVLNm4yczhBbU5oQmlveVpBTDJUWnBQVlo1SkF3?=
 =?utf-8?B?QVluRk0zbWUrQWlkdmVRRFcwMWFrNmREeWFXNUNYM0sxSU9CVVFZQldlV2lM?=
 =?utf-8?B?QlY0dkRVMDRPMXFBQnlUamlqcGFWTXlnR1hIVndoMXhnMGZVRVRRNk5MN1ZZ?=
 =?utf-8?B?L1pmNENjVFlEODF6bEszS1NOUWRvdUFiMkhVcjc4MTBQeGFhOVVVNFRtditr?=
 =?utf-8?B?M0hRMFlzZFIrK2UvenNOTkdPc3JncFExVUlFSFNOWDZiMWg4V2RBbTN5SU9N?=
 =?utf-8?B?V0gzUjY1aWZPem96SXBONjloVE5ES0lFVllXdGJMYXFweC9kMHFLTHJLS3lI?=
 =?utf-8?B?QzNpZWV5djJkV2w5MjhKWVVSeGdoT1JXMnFWZlU4Y0hGbW9yZklnOW00Y0Vt?=
 =?utf-8?B?NSt1TDUwWHQyN3dSUEkvdkp6RndkNjEreHowb0JlYjJsRjluVWErV0MvRXRh?=
 =?utf-8?B?OGRXUE9sSjRmTU9iWExoV2R0cWZBdzlsVTBnNzdubWZiYjZJenNmVE42b3hm?=
 =?utf-8?B?R2lSOENkY0JSWXluVU9RYnEwbWFTTS9IK0MvUkFzc0ZCcUtPMFZGeDNsZEV5?=
 =?utf-8?B?TGs1KzdTcUZWazgySnppOTI2UDV1cVdIdHo0WHZxbCs5UWxXaFpuMXlaMFAx?=
 =?utf-8?B?NXBtSG85VWQrOW0rU1FmM2dCZVN4RkFQVnRYdjc2SlFkMVFicEFxQ0kwMGVk?=
 =?utf-8?B?SHZrb2JCWmVJUFYzdWJoNzI2Rm5sRHZkbkVad3ZwQityNXAwVnVrTHN2YjRW?=
 =?utf-8?B?TEV3NXRYa2J6L1djaFV3ZVYxQW9Vazd0ZzJlVzNlcEN5Y1VRZDhpb01zVkIy?=
 =?utf-8?B?SFA2MEIvV3BOM3ByMFhHcVpHRnduWkFYbDFVaWlreG9QM3lvN2JvWUN4TkpJ?=
 =?utf-8?B?V0lyOXRWQkNvWStjVTFpMCtMR01UK0U2VHhQLzFBMUw3YkhtZm5UZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcbbc25-cf74-4bd9-b4e9-08dec31d69b5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:13:43.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cJhtEscEMYqQHnrfM13gZeQfqDAFE1Fb9w0VkU9k2SI+Yk3QiUXpochFh/E0pafAiWN7g4QTq7ABG4ChY/27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37421-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 732A1649B65

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

v12:
  - Fix 32-bit build failure reported by kernel test robot.
    The failure was caused by 64-bit division in the legacy
    radiotap path, which is removed by the refactoring.

  - Restore the original series subject to ensure b4 diff works
    correctly across revisions.

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
  mmc: core: add NXP IW61x base ID and block size quirk

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
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 3931 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   18 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  458 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1310 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |  122 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1094 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2459 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  480 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  607 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  787 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1673 +++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1427 ++++++
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
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1381 ++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  155 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1313 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   77 +
 include/linux/mmc/sdio_ids.h                  |    1 +
 50 files changed, 35728 insertions(+)
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


base-commit: a26c2a22e7e88b2b5afb1349f3994fc564c988b1
-- 
2.34.1


