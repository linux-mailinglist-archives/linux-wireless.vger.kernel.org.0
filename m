Return-Path: <linux-wireless+bounces-33345-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAYDNsY1uWmcvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33345-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:06:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1342A875D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 688ED3020530
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E01134DCD1;
	Tue, 17 Mar 2026 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="I9sJnY7R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013081.outbound.protection.outlook.com [52.103.33.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7D3A5E72
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745604; cv=fail; b=LWaAwEjg5s2cvA3KeJHK5hhFN3pB+ydI3nlAmo8fy3CWqTXSFMXmyGEUyR86BLE7RQJejrUaKK+KUlPiLBd8MiEWB1jG/Jo60xhwp2rfvu8mfkIywK2XPwlrnEt3GHe5BjUooHraz+D89FrPfE8z2N3B2ARaplxPJyfxR8ECOLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745604; c=relaxed/simple;
	bh=T+vLjeK3k4jMZFivSIDsYvRKR+Omnw89VheJmhpSuGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEPGFUYIYp0KRaTGsvoP6Qi8nBaPO6uPG0QLlwakm/hDoHBpv68ogMEbA/VCP11oQ2OKqardHEk/elKHdfp02wwecIOLYl6r5/IkukP6uM8XnlQ5SF+QeR9A1NunmIulGxSggwvFcSsDeYrzKkVt+5lhsyoY3A0QD5R1XMIYEdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=I9sJnY7R; arc=fail smtp.client-ip=52.103.33.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKtX8spAbD+eNFFNvghi6ATf1XG+eyJTC91B5Kdq206ecIigRyxnRTlt/DAsNc6pCwEXnFrT1qMQKqHkio9SldLPN6Neb8d8u10/9kYERwlPLzu/zLXx/faggT3OXO6CEm9BMjzaXWiWWkk0JYpDzOhcfdWkbAq90T5FjCtt3TbSJqo8w401SyGglSN6e/EPvD4OlXLRMIq10BReOT3ngroNxwxHC3zzaobwTvunjoY+EgWlNcg37Q/o4M0r7BCL6+l0XA0uHN0y1TbrDCSwwmedSuSUThHRLbgU2yYjXxa1Os29b0Xy98AVInhpUhUuEr8XaDPlsp3VubdPeK+p+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9QlqslVqhbUF9QAKMrQWROIVQtnNvcHpt2k3tXv1GY=;
 b=N/b5m9DRh9h9dA4ROZHTN3uvi0tn7EKJJuiOtImbDxjVbPrtiIjWHvPgrONweMoeBMjDWziI8dlFTEZmrLR5XmGuOkMMqhsws2URhbirCuezuU6hN2p5O5VoWuefk1VatgcWwLzVmkVDKx2g2QJS8Olreidz+MWa+3/GNiRmVrrQrsfBjM3nbbs0FInVcki7AU7DcdyKjgip3q9wire99GBu2lLYiVMonEMAN05IGZ6jSxXxbfP32fqW4zN86O3yqWhth+hfi+pcL0xXvkiwfguuPfQ7KF5X4Iz5iNXEiApb0U1f3aeQLg87BF7D9GGCEe4e4P4zpsNH1mn6WICmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9QlqslVqhbUF9QAKMrQWROIVQtnNvcHpt2k3tXv1GY=;
 b=I9sJnY7RfGc3Ch5d2Z8VYngT+RTaQVQyMuECeM3GibfXVBrEBGs/Fbbehi5eGNTMFyYlcIF/iAETFulcTH6SyXuVbgZ8CkjZ2gqGlPzT3eCcXMREUag62OVHfC4Sbpkk1MOZp4idWHx9lqGd7YNZE/G8w99myL6KXXJ/TUs5cD6SnobpPUDJIKB9e25MY6q8BMrLAVPo6Mq07IWU83JqKPmOrdGtQQqX/+71eMiRinjWj4oZNJ5CYwu2hJSyjx/I6qeooYYFXMUdxqbh59miPKT/bL1ssWgWoH3DbvBp109K4K7/YaGjrN+pnvi6c9M+IP3xRTuF5yjIcHEASOA3lg==
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851) by AM9P251MB0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:412::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:06:42 +0000
Received: from AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb]) by AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 ([fe80::596d:6ad8:b60c:c9eb%4]) with mapi id 15.20.9700.020; Tue, 17 Mar 2026
 11:06:42 +0000
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Masi Osmani <mas-i@hotmail.de>
Subject: [PATCH 16/16] carl9170: cmd: downgrade transient register I/O errors to wiphy_dbg
Date: Tue, 17 Mar 2026 12:06:34 +0100
Message-ID:
 <AM7PPF5613FA0B67FB95CB5305CEF9DAA209441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317110634.70347-1-mas-i@hotmail.de>
References: <20260317110634.70347-1-mas-i@hotmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::851)
X-Microsoft-Original-Message-ID: <20260317110634.70347-4-mas-i@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PPF5613FA0B6:EE_|AM9P251MB0007:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a35bb5-5924-4248-46a1-08de84154540
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|461199028|41001999006|15080799012|5072599009|6090799003|23021999003|19110799012|51005399006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWZsbStiZWJ6aC9rMHNwYnRtK1p3UEdSRjkzYVlJS3A5THZhbzRrY0ZmVkxE?=
 =?utf-8?B?cTlXVXV5UmJMYVFBWlRKWUtPRFlXazFvcFpEU3BGY0pNWUhtL1o3Q0RFN2Q1?=
 =?utf-8?B?aUlCTmNIV3lZY09JMGJhbWYyd29zL2tyK2p5RE1qeSswbnAzYlpTMWZNeFlU?=
 =?utf-8?B?T3ZWK2ZxdC9xQ1N6TkVwYm1wYjZrOWszWVlQTnNHcGdVeDRiVG5Dak5YcG92?=
 =?utf-8?B?RnZQTnVMSFo0R3o5dzgwOUlhSFVmRGxpdkhna3FLTUpxbFFUdHdhZnViRWNQ?=
 =?utf-8?B?L3FZQUNiS1RiZjJUTll6dTU5OC92RGtEM2pJZERBd2Z1VjlPaklIZ1ZDc1Iv?=
 =?utf-8?B?ZXExL2tFZE5uRXFqV2FrSzhCRnVxbzVGRkNWYXM1SUlZT25xWjlhWXc1NUMv?=
 =?utf-8?B?VEJXeGJ2M0VoaTQxdGtzZWgveDNtbHlDYmZPam1xN2JJVEdQNzUyd0Q2MWEx?=
 =?utf-8?B?dlFNL0NjTHZoczJWRE0rUHYyRFhOb3VJMU9VUVdnUEcxZmxmOWY3OFU3Ynhl?=
 =?utf-8?B?M1NwV2U4Umw1WXgveXByYnlDTU82dk5OYkhrMWdleWY1c0NCanFLbDIxbjNw?=
 =?utf-8?B?RXZLT2RQcTFLcDJpQnZ4N0t2NnVJdWk2a1pHUTdlekxqZy9zWWxnMGdUQXVW?=
 =?utf-8?B?bmtIT0hkRWZZZ0pGRFNlVVBXN3huZ1gxRlQzQStCM1lFV04yb3gwcDdLdlRo?=
 =?utf-8?B?a1RWRFZmRjFjVGZpcjlvOGZGbE1uQlpjRUt0cmwyRVltMmxad1JIdzI0eWty?=
 =?utf-8?B?THoyRzBiOEdnTW9GUTYrOXQ0ZEVqanptTDB2YnZGcGwxdkhqd2FuT2o3K2ZR?=
 =?utf-8?B?b2hHVEg2N2s2elRoNGdNa0c5M1FETTNrZmRMeGpwanNqTVFibDJuUTdtNVBC?=
 =?utf-8?B?OXVDZHRIdUViU1pxMTF1S0M5NlRCblp3clJLZGxObHdaQjNMYVpHRmxMbGxZ?=
 =?utf-8?B?cFZnL3JmZ1h6NlR3QkJMeWdEazFPbHJqNEZPQ012S2NVL3lEejk5eUhENktK?=
 =?utf-8?B?UGRrRFlEU3Z4QnlqalNFdTBDRzlhVFdORHVwSEtQbTVtQkMrY2dmSXZlSE0v?=
 =?utf-8?B?YzNnY3ZCVFpXbmhYSFgwbW4wRWxlbWVwWnBPbWllbjhOZG0zb1YyVVI4RHJu?=
 =?utf-8?B?b2xJTExIcStzNEU0Vm9iR0V6ZXBIZXZKR2YreTZlWHJscW5RRk1mMENkQlJz?=
 =?utf-8?B?NWdsQVZZVVJuUUJIWE1kQXMxellpQ2tibjVwbmZUOVppMW5uOGd1Tk0rWGZn?=
 =?utf-8?B?ZlNsQnRRSnZqY3JKckw3eERJb1IvWnU1MnJnZlpad3c2WVpuMENtNkJPa24w?=
 =?utf-8?Q?ZATrg62Rk8+Ul+oJ0PMUI+8Y5/HgQ9RfLF?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MCswWFMreDdJczdPTmlDYVNSY3FmcTdoRW5yYUs4anNoaFZrdUkwbCtlclJK?=
 =?utf-8?B?K0tQc1daSCszYVpOVVNmbFdBWHFpMzRrN3ZBQ1k4WlE3aHZiL1NaV05LcTk5?=
 =?utf-8?B?S1h4d0JPcUh6SDVxQ0VTMFh0dTRUMHNBRTB6Z1orMlFnTVJuQnhQd3BSVHdj?=
 =?utf-8?B?dllPSHhodVZ2U0NzRXFXV01SSTZIOHpyU0JiNkN4OGludFF2UWF4NW1pM2FP?=
 =?utf-8?B?M2cxY0xnd1psYWhZSzJTcVZFRG5SOHhsVGYvZkd2a2hXOWMyVWZCaVkySld0?=
 =?utf-8?B?QWY3aWlFSDZScUY5WmxlTUdBK1VQSkZpM1RyZ2lMT2VWay9xNzJxUDNFT3I2?=
 =?utf-8?B?NkJ2U3kxVWZlV2V0ZU9RcmpiK0p0YTFrNXpzYnNlTDZ4djFzS2d4NmF6ckRD?=
 =?utf-8?B?a1hpbjl4R2t2cTNCWCtOalRwam11bDJFb3F1aUpUTTlNbjhSMkNMOWNIeGxw?=
 =?utf-8?B?b1gzL1dVM3NNMVdkaFQzSWQvb2swOTVYcDNBTEV0OEZ1R3A4cGFMc2lNWmZh?=
 =?utf-8?B?T3N4UGJTQUljSUJWY2d4bWxuaUZLUk1DM2F4QzhRbFdSdGU5TjYrN2dteXgz?=
 =?utf-8?B?TmhvYTBGVjNIT1BKTk11TTh3NVMwZ2pPYXkzeDhHRXI4TmwreHFvWjBlTTg0?=
 =?utf-8?B?THA2MVlsTXBQbmxvTHFZblVkL1ZmYk13RU81b3NRSGtHQ2xsLzk2ZFQ0T2ZF?=
 =?utf-8?B?ZXlucElYUnlRcE1PZXZUQkpUSkxLM1BQTVRkYUE4Vk41MzY4ZkpwTFVhVVZ0?=
 =?utf-8?B?WlcrYmNmdGFDVXZHUGxocXpqTjNYcjJqY3VCR3oxMmlaRFBpUmRtY3FJYzBN?=
 =?utf-8?B?WGxrK3oyOHpsTHF2YitmUlNxU0kvSUxDMjBjQUR4UmRwZVpwWmdvUVZzMStY?=
 =?utf-8?B?QWlxZGIvdlZYTEdmczQ2MmQvc3lLck1KeENwTGJMSnczRDJ1eDRySGNiYnJC?=
 =?utf-8?B?VmZhZnlla0tIYVlva21ZN2MzaCtKdFpMM0U2RjhPRjY2bzFXcFRiQkZFem9E?=
 =?utf-8?B?MWo5MTAyKzdNR1VybWVLY0crbUhISmNqQXVnZ3B5c0xwazQ0WlJ4YmhwaS9y?=
 =?utf-8?B?cEc5Rytoclk4elV6M0tmaXJPL2V3bERzOVZMWkhiaVV6d1NJOVdUeXNxRlly?=
 =?utf-8?B?WDVOYmV5MkdpaWJqV1ZsbVpmd3F0bUJrakxSRUdIemdMV2g5OTVRamlnUi9V?=
 =?utf-8?B?NCtkZE5vVk4rQ0RGdzNMOHE3Q1FJeUVzRmZXSEwyRkNLWGhIdzRZYndqRTZy?=
 =?utf-8?B?V2hZQWJ3dmNSMGp0eW9uMGxDbitWd2E0YzJ0L1VZSDFMNkFWTm92WGhNckZF?=
 =?utf-8?B?NGJkVE5Rby9XQmlld2pVUXVnQlgxdWN3dEpDbE9aeFB5RTBBbklPVFd2RXZG?=
 =?utf-8?B?OTA5VlRkWDlEakF0TStMdjR6cElqWHdTbTlSdElvSzVPSUppeFRaWDJSb3Rn?=
 =?utf-8?B?WkxseUpSd1c5TjJMOVY4cWc4TjVObHBRZ3VtMmtXZ2FnRnY2ZXIvUnpDNnRm?=
 =?utf-8?B?OXA3N0thRzlUbHhlZDJlbnRxcDJpVFY3ak0xT051bjBmRDZmKzd4YzhBNWJu?=
 =?utf-8?B?TzhIbFRqMWtRSkkyZVQzbnZlME5PZ0dzM25HdDczRG91UlJCbllscEhST2oy?=
 =?utf-8?B?ajNhWC9MY3lEL29OV3ZJcFZxQnpNWTJTZnBveUl6SCtiRE9qRHY1SGV5VHB6?=
 =?utf-8?B?STF3NDFrcStDV3pwcS9pRkdsUGdSbTNLYStNUmx6ZnpjYkJYZ2lvK1ZtRHBL?=
 =?utf-8?B?emozeU9kK0d4aTQ0L2dCME9HWmppV0xuSHNxUWVpVFpTMzNYcjk3UURDUEdM?=
 =?utf-8?Q?PuEM+eDsqe+YRtht63teboSlN9HyxHACc31LI=3D?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a35bb5-5924-4248-46a1-08de84154540
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:06:42.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P251MB0007
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33345-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.de];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,HOTMAIL.DE:dkim,AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 7F1342A875D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register read/write failures during deauth/teardown transitions are
harmless — mac80211 tries to read survey stats or write slot_time
while the firmware is in a transitional state.  The command times
out with -EIO but the adapter recovers and re-authenticates normally.

Downgrade both "writing reg ... failed" and "reading regs failed"
from wiphy_err to wiphy_dbg to reduce dmesg noise.  The errors are
still visible with dynamic debug enabled for investigation.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/cmd.c b/drivers/net/wireless/ath/carl9170/cmd.c
--- a/drivers/net/wireless/ath/carl9170/cmd.c
+++ b/drivers/net/wireless/ath/carl9170/cmd.c
@@ -52,7 +52,7 @@
 				(u8 *) buf, 0, NULL);
 	if (err) {
 		if (net_ratelimit()) {
-			wiphy_err(ar->hw->wiphy, "writing reg %#x "
+			wiphy_dbg(ar->hw->wiphy, "writing reg %#x "
 				"(val %#x) failed (%d)\n", reg, val, err);
 		}
 	}
@@ -78,7 +78,7 @@
 				4 * nregs, (u8 *)res);
 	if (err) {
 		if (net_ratelimit()) {
-			wiphy_err(ar->hw->wiphy, "reading regs failed (%d)\n",
+			wiphy_dbg(ar->hw->wiphy, "reading regs failed (%d)\n",
 				  err);
 		}
 		return err;

