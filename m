Return-Path: <linux-wireless+bounces-38757-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pFvEGa/yTGrBsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38757-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:35:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C271B687
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:35:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Ii9bOIak;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38757-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38757-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 332C730465A8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31241DEF0;
	Tue,  7 Jul 2026 12:27:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020124.outbound.protection.outlook.com [52.101.196.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55B40A943;
	Tue,  7 Jul 2026 12:27:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427230; cv=fail; b=tLxF21MQ164q/cy/209xS8n9uhq53gClnmtANvTFgunSixrRX6tr7WvjuSByJEBWuIpinbreNqGaE/7BTr3niX7hpYPZlaLZaL0qXmFa+DP/K75hK8bIE/h33DILbb+JOtqtelVw+Wmh8RE7HTU06unbqLfZBhFnnPfXPn5NyeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427230; c=relaxed/simple;
	bh=++nTjvaUlIlFlL8D8AcF4vnmvP7p2rLheSDLnLOiYcU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K42MJba3Y9T4Nrdl5cYvid/cxximpk2MxBNOOUYbfSW7ITmUf1yM3DzO756XDOhXElRzz9K/b20BZJ8oYG2rZn4CSkuemmnK0TyUn6rVMWCu3W0oYeSHc88gifwizrreOek5shhFu4hItJUDXVix3k/QfKBMufyW8eKsx+zonaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ii9bOIak; arc=fail smtp.client-ip=52.101.196.124
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/SuwLhjGR8uHBpf6f3oY97U4ZvHj1kxkfKmrH6rPargFkV25/WNCUcFwlkVHi5BImoguG/93vnE/JogXB6Vz6EIKrJ3Dl2MP5rWaPbfrKHtHCwcyUaf9s0fVkhdf5D/JsPjwje1ITJt4TpgdFCIyp4UGgfUmtL0vIF7PBgDznI/11WAzM6wkwjFOjkq4/N/qkeFFNJLJpsh6GOkaFkwCl2i3hfY8TEQeG58rljtdz8y2TyDFA5+4SOQ7re+SUON/7j3njn+LApuEnijmVG+vbDr4Wd3zvDxeNCAl4wDhSZMCD347fwVX+MhZXom/79HCaZ9CMnQKnSyuod5B1v8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcmrvPCu1eFMNzTDwg4KQVgOQZlZ+T1ehfcBf4+kdj4=;
 b=DBMb5/IrLRuUULAeVGTtJmJ1S+LxQO5lKgN9cDjNVFuxTor1V8+7yNeDPyKa52Ze4z/bWSQzMxyl9keFJeeIksFqLbryRBadPSHJKOOVPQYDRHtZtL0eupuzXn7RACK4Rm7bPNVdPrtY8j+9TIfZq2dbv1M8Beai/0bqCR9MfmE/si9lac3hPyAwvAbnLBGpPpDIW2mbUgfOVcAUvBWT52T5cfXkSNtseg6FNIrbU2Mo+yP6acSzZXhLw8EQ6p/7nskFL+rcZ5STEO//F1AhY9BMKu7dFxHqQxFswGBBeJl/s9iHj4emLUYZNpoyg61Ft1/D/2wgNijRng9OinwjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcmrvPCu1eFMNzTDwg4KQVgOQZlZ+T1ehfcBf4+kdj4=;
 b=Ii9bOIakE7dadlnm4i/nWPAi3shAKMUGERkhlrSaSsUmMOwP03agWByJZKSXNpeWsJsgqcFCEM5t6RmQsRWIOPhJ+faFbIoS+VXmSSrG3SS8NxfYSg1jlmCyqpC69sQlwsh7YFx23E9+D/61TMQKwqr2jWLB99nt89wvjzNxCX4=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 12:26:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 12:26:59 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 07 Jul 2026 13:26:46 +0100
Subject: [PATCH v2 7/7] usb: fix UAF when probe runs concurrent to dyn ID
 removal
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-usb_dyn_id_uaf-v2-7-632dcf3adfba@garyguo.net>
References: <20260707-usb_dyn_id_uaf-v2-0-632dcf3adfba@garyguo.net>
In-Reply-To: <20260707-usb_dyn_id_uaf-v2-0-632dcf3adfba@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Johan Hovold <johan@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Petko Manolov <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chas Williams <3chas3@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-wireless@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=3274;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=++nTjvaUlIlFlL8D8AcF4vnmvP7p2rLheSDLnLOiYcU=;
 b=dnz5iXX4/7k5x0lB+IMPVjTlSf0/sAMci3uHVlMmv2lhQSqqeWV3nl90BOgHll0GfWlegw7YO
 9fvJnP1wIrGCEgm72dwO7Suc5Tga23Nk4N39khDrwugsRA76Ec/X7CW
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: b668a805-e605-4d5d-55da-08dedc230a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	pkWAZT/X+f3Ry0wy1FnZ2Q6nTZM2BYjmm6tX+n9YUwnzEKEjlM6hjSwakJAbUoC4iL0MD4Iubq0tYS3pw+JS6yVxKH9tSXFxvkmnQZZPNR5lTawNot/TlxzcMhkN/190kdo6skonpRQ0Om9GlT4J54OelpDaHzzwffEc0zmu6JMyyuMF9x18MAt698w9zUbbvkwd5bTTDz01Lt9GsM1Fk3MDFg50nlVMpBzR7G35fbsXNzhrG1oL4ofHyMjijF0afIp2I3KK37xBMYyRZPYZzJiaKWYGFnEbBIOflAGXcX0ghsOrdGQ4j48MkZrx3/Wf4sFbDO8DjYjP5ZSE0N5QwQaFRzzat0UvGeaOaa/2kNgpKXwCXDmw6dZCXInCU2lX9ZD5btFlLReDMIavp1XDfguTAyB4qEh8a9PuzxQ6R82JgIPh4QftabfY6paMLQ0rMZr7qfrqyqF/NHrQRu/YXp5ogqaAbXqSlPbzWtXsTJXqikpIjjCor4AaNpoQDXT6v1hyZUMNco4/kCKK/RpCOhhuLYN9EhWWcLiBEQASeAnQh+CKV7GEk8dg2W+9DGQmHBkuS3p/N2Gqx6yTe2aq6e6eIOuzHFHqbXyAWL/U/L7o4xnB8CH6R5jj7iwqVbdKziVZiHv1oXqxq/KCAzJy1SJwiae6Az/unjtj9gpxRxPz7+7ReOi8tJBGVP8621vXd3JwCrxV5Y/DTIoZ8u2kfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UElIV2JJMmZHN3N1anhFTWVzaXRjL1p1LzlzWlBCeXNBWGJMNFlTQmhXRW9v?=
 =?utf-8?B?OFNuWjN0NkpoRTFENkY2d1ZpUFNpYzl3SDhzODlwWFFubVRiaGZXdFpwblVU?=
 =?utf-8?B?NFZaY0hCZW5uVHNqaHdocCtLeHc0dGhHMnB4dUpQWWxkN3BNck9hdk1UYkZF?=
 =?utf-8?B?N2JBa29wYnRrZHdwbW1LNnpSbGpkbk05aHBlTng0aWxTWk9hVWxXRTVSZ0xN?=
 =?utf-8?B?YWV4T2YrYjl1OHcyK3h1emxudElhdWNiVU1GVmpYem9acTV6MGhnUEFzZjIw?=
 =?utf-8?B?Sjh6aU51ZG44UG5sSDE4VW5XNXNHbGVQR3lxOFdFb0JQSnNvRGNzOVYzOFJ3?=
 =?utf-8?B?YkJrNVJlaGkvdklud216WE1ZbUdqYWtxKzl3bUxDcDRWMG1wbHpWWFIvS3Rx?=
 =?utf-8?B?aUd3aW1IbngwZTZkc3VBakk1YWQvVitCZC8xTEsrNDhzTlB0VzgvUXNuaWg4?=
 =?utf-8?B?K1Z6ZkdYVERrR0plMFVRLzBsdW1JMVRlMURrL1MvMXVZNFZKTG5LZ2JET2pN?=
 =?utf-8?B?Q3l0ZDhjNEZYc2x1cm04blZZUmlHMkMwZGVleWUrRTRlZDd6L05DeHpxOEwz?=
 =?utf-8?B?aFdORlBETDZmQWxuWVo5UjYwbzFiMHNTN1ZYRnlyKytVWU5sZVJMVk0wa3hE?=
 =?utf-8?B?ZGEyUktFQ2VpeGh0ZU0xOGNrS1FTcCtqU0VkYkhQbENubjVTQWJlSGE2OVQ4?=
 =?utf-8?B?by9lQTE3S0ovT3pURGlDN3NvVlg3UGRha1UvYlRiM0tyZHR1VEExbDRrekpO?=
 =?utf-8?B?QUNJRjBEUEd6SGN2ZDVFKy80Qk5ocnB2Um9SQ2tmRzBaS2QvV3NCdm9oYjBm?=
 =?utf-8?B?dVJWVXJMY3hCT1FFdkhyQzB3N2FHL29SSjlqend6azVTbHpyYWVVQUlPRFE4?=
 =?utf-8?B?eWlMVjQrWGJua2RUeFkvdmMxMFlVbWNDOVhoSTEwbnZLNE1ZcG5IaG05Vko2?=
 =?utf-8?B?LzQzQTN5N09oRWx0T0xzM2RPRWQ5d1c3UTJabitCRWR1cEVDbG5zNVlvVU5X?=
 =?utf-8?B?L0JpR00yVDlTcGF1bndkZndEOFFKN2JRM05kYjR0L3BsVlI5UnJBK1k2Um8r?=
 =?utf-8?B?RTJUMEhmMVVjL3lPZWNkMVlVZ1M0L1hiYkJyTENPQU5CNWR0TWgyeU02K29G?=
 =?utf-8?B?TDRrSlBvUnpqNUpRT0lNc1hRTEJQVVVoMy9MaFVMRDhmS1VqVzRDYTg2aS9x?=
 =?utf-8?B?ZHBEUVNNcVgraWNnTXlSZWY3aCt6WnVjY2drMzFFY29KVFRzbFN0c21JS1pY?=
 =?utf-8?B?amM2V2ZwazQvTTl4VFlFU01zMzZXZFljNWgrdHJGRXdoQ1JFZTdBQ3pEOExr?=
 =?utf-8?B?bGc3OG1uRk45UkkxUEs0aFNFMmEwVU50WVJnSFEwRzFtY2c1TVloRDJIV1dj?=
 =?utf-8?B?N1RKZXVwMlZVYktQUW5KdkNFNGhiL2ZacXlQSktTR21BNXlMZklZbGQ4QUhr?=
 =?utf-8?B?Y3Zkd2lrc01TdEowbU9NMllhY1ptY2RiWFJCMnd1UmxDK0JDeU1MUEJRT0c1?=
 =?utf-8?B?RDNXZVlqVjVtYWNnUEFVMzV3eS9vTTQzZURHWWJTbVdmdFJrb1RJcXFyNGRr?=
 =?utf-8?B?VHVWZjlJRStKaitOVU44cWZvYVcxOXNITk1SL2IvWlkyK3NHV283TzFIZmhI?=
 =?utf-8?B?T252c1lCV3B5am54WVgrL1RrTUM1OFY2ZS9ZUit6N09FOGJSS1lHOEphS3Zi?=
 =?utf-8?B?UUR1TUxXdVZDOTBsRmc3RStBUjE1M0NWTHlud292NFpGVVd5aVMvbzZRTTh2?=
 =?utf-8?B?QjlDWUpIeEVGWHBtY2RzTkJoemtTQm9EbDF2c0lRWU9kTVlySUQwOUZqQmgx?=
 =?utf-8?B?NXNsNDFKWmJRZk1ZQU50TXVoREdQaVc0UmxnWFp3RXpXQk95MzBjZDRJMFMw?=
 =?utf-8?B?S2hvVXVIVkpXek5Ub1JoRHZGZDQxMTI5b1ZsYmRBVnVEMHJobzVlejB1dGJJ?=
 =?utf-8?B?Qll5eFU0NjRlcXVLd3BZOU9KdEtMTGtrS0dKc2dyV2tLMDRWVFpBNVNmcTlU?=
 =?utf-8?B?UHhBTlVyK1hSaWltajNpTUxpNUxMNEE2NTFkVDJWbFZvUkh2NzFjK0hrU0FV?=
 =?utf-8?B?bFE4Sjl3SFJ2ck5HZ0NUdUthQU5mcjdjNXpxRUY2KzQrKzZZWVYzd1FFVElL?=
 =?utf-8?B?dWVTdldRdE1EL25JWUZoZ2wzMHF0UStQUU5aUndHY0krWHBsL1JySHhtR2xa?=
 =?utf-8?B?OUFLK1Q0cldHYzkwTHU3NzlFZmxvS0dBRWpWOTJvY3RGbElJdWpTSmhkdnBC?=
 =?utf-8?B?c1FHNGtFUUpWcjlHTFo2S0xadS9nKzN1NTJRV2dkQWF6S3psL0l5QkRicGN5?=
 =?utf-8?B?R2RSTjZTMmpLWDd0Sjl4bm1WMmJQRHR0OFZuVitzR0pucTNnRmRwQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b668a805-e605-4d5d-55da-08dedc230a8f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:59.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGsgTcxn7akOHePhETSc1Tt1aBPHYlDfANmayJ0oXBLVB2Jkx3AdXyH6xSeW41tDAcPgIgbmv+I/3v+8qQYzEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6339
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38757-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,toke.dk,nucleusys.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,rowland.harvard.edu];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:mchehab@kernel.org,m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:3chas3@gmail.com,m:stern@rowland.harvard.edu,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:usb-storage@lists.one-eyed-alien.net,m:linux-kernel@vger.kernel.org,m:gary@garyguo.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C6C271B687

Dynamic IDs are only guaranteed to be valid when usb_dynids_lock is held,
as remove_id_store can free the node. Thus, make a copy in
usb_probe_interface. Clarify the documentation that the id parameter is
only valid during the probe.

USB serial has the same pattern, but it does not need fixing as the IDs
cannot be removed via sysfs.

Fixes: 0c7a2b72746a ("USB: add remove_id sysfs attr for usb drivers")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/usb/core/driver.c | 12 ++++++++----
 include/linux/usb.h       |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f63004417058..7f33fe5ba03b 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -228,14 +228,16 @@ static void usb_free_dynids(struct usb_driver *usb_drv)
 }
 
 static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
-							const struct usb_driver *drv)
+							const struct usb_driver *drv,
+							struct usb_device_id *id_copy)
 {
 	struct usb_dynid *dynid;
 
 	guard(mutex)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
 		if (usb_match_one_id(intf, &dynid->id)) {
-			return &dynid->id;
+			*id_copy = dynid->id;
+			return id_copy;
 		}
 	}
 	return NULL;
@@ -321,6 +323,7 @@ static int usb_probe_interface(struct device *dev)
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_device *udev = interface_to_usbdev(intf);
 	const struct usb_device_id *id;
+	struct usb_device_id id_copy;
 	int error = -ENODEV;
 	int lpm_disable_error = -ENODEV;
 
@@ -340,7 +343,7 @@ static int usb_probe_interface(struct device *dev)
 		return error;
 	}
 
-	id = usb_match_dynamic_id(intf, driver);
+	id = usb_match_dynamic_id(intf, driver, &id_copy);
 	if (!id)
 		id = usb_match_id(intf, driver->id_table);
 	if (!id)
@@ -892,6 +895,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 		struct usb_interface *intf;
 		const struct usb_driver *usb_drv;
 		const struct usb_device_id *id;
+		struct usb_device_id id_copy;
 
 		/* device drivers never match interfaces */
 		if (is_usb_device_driver(drv))
@@ -904,7 +908,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 		if (id)
 			return 1;
 
-		id = usb_match_dynamic_id(intf, usb_drv);
+		id = usb_match_dynamic_id(intf, usb_drv, &id_copy);
 		if (id)
 			return 1;
 	}
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1da4ad1610bc..49ab8dbb885f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1185,7 +1185,8 @@ extern ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf);
  *	interface.  It may also use usb_set_interface() to specify the
  *	appropriate altsetting.  If unwilling to manage the interface,
  *	return -ENODEV, if genuine IO errors occurred, an appropriate
- *	negative errno value.
+ *	negative errno value.  The usb_device_id parameter is only valid during
+ *	probe.
  * @disconnect: Called when the interface is no longer accessible, usually
  *	because its device has been (or is being) disconnected or the
  *	driver module is being unloaded.

-- 
2.54.0


