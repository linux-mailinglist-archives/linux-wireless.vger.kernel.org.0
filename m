Return-Path: <linux-wireless+bounces-38752-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TwAYBafwTGpNsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38752-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:27:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A976E71B545
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:27:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Lj8WH2C7;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38752-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38752-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D87F6303EA8C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F2401A0A;
	Tue,  7 Jul 2026 12:27:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020078.outbound.protection.outlook.com [52.101.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908423FFF85;
	Tue,  7 Jul 2026 12:27:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427223; cv=fail; b=qvZ2jPjE0aSRbu63yA8Uyb3rik95P9Pli5+Zz8WNAietYPpiFXatKTd7kOXmJqIOLV+a1pC+QaPcjuF/qrmtR3s6cyIM71IJQ+IlbICcO6JA7Wb70ixnF6ePXEfqQpVHwmPLgl1D/Giz9hFcOjwqdLBTQFf50T+6OxCCY3lEIV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427223; c=relaxed/simple;
	bh=9IzFoPq4V3Z7TwiHHEN0xyIYYm4BOZwBCQu5gs+z5G0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BUrsxY/Vt24twdWqfyRAqVMst7OtuSfe4BlR7XC2ymvI+M5E7whb+AtpuqkyHM/7a/RRcd1syWC/hLzDqE6sFpbSS5IuRbakCiAEme0GS4vE95VXARaR0iOoDOFiRXwQjhWd3Gbp6UfzRf9N0xPvVpgNiquBPLsIKBYQrzFgl2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Lj8WH2C7; arc=fail smtp.client-ip=52.101.195.78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTnBjMDGOBpa6UEuF+uU7OFVd+TWK4/tz3GWSCdsSEYN3aZJr1i2+/M8lJS64+B6opyATTcZ3dmmvxIHhCBGOo0d19Hha9cbGZtkjkwK0zFUvwUxmxxrF2CtAALWB9RvBhr+Hnp9LYsuwIQIui+KasE+pCo12PusSFvwWfTBjaHXUQvRB8lpDRzszflWS+ftv9I+QUwZz1fe3ZjN8kegeSqTJF9Xq/qtx4RFL6TLvtKEhkdQZlmBrILAUxS5FF9QnzIgCm7heGsCEeDw+cLYG+9/bFMiBWxItd1RuwK766eUouQnPA9X1kYwYfAq05dZEqrirkqlMFlLXFgSQhcN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtgwQVaJXlDUIpdX9JwkVeJX3PHffHmv/2dBPFGjK0M=;
 b=v+QmhMlD9bMfhB0LHmur/DserkiGdw2NgjkqgLdIvGSOf7lv4j7l0C/7r8gAZUEauXyVRtrQnj2c2Zt25fIjFeSt95MZYAzWSBfEtgHVvz4GDAN78lmeZUW66HHecYUvpzOfGHZn6kocP3SiGH4t3Dayx4csNTdcQ8ikewKElfwio1Q3cKaSvFhKtTeDbJuY1R6kcuFE5OeabYXg8b4YRhjvEh2dhP99iFifLR4F3BZq/k39WCcwewiPacPI6kXbb5NIndM+9aQwclng/8PKMdjClNJyf96GGWJ4kAYiSaxbwH8aJE2vG6Y6YlKlpvXz66L7Cqq9ak5JuJ6AcEdJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtgwQVaJXlDUIpdX9JwkVeJX3PHffHmv/2dBPFGjK0M=;
 b=Lj8WH2C7bSsjxqYuFWFE+x1zUsuiTJGa5cm9/7kbejSRqVPtK2Ob0N2ztPYcxGdweYAu6318Veb6iF3lp/QV/hFwEHjdJynoliLVsdsMqA3CEW4qYiGCMdhVw4rI7e6ML188qqtqEHarDKe0gY2k0k7DAaJU3cM3h8eYK8b2kJ4=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB7369.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:33e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 12:26:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 12:26:58 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 07 Jul 2026 13:26:43 +0100
Subject: [PATCH v2 4/7] media: as102: do not rely on id table address
 comparison
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-usb_dyn_id_uaf-v2-4-632dcf3adfba@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=3994;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=9IzFoPq4V3Z7TwiHHEN0xyIYYm4BOZwBCQu5gs+z5G0=;
 b=BzioJqoXyLQbZlaP8dKa4mLMdNwAYOj5lJKpgPqYE0df+LSwSt6tX8VXEcr2VPdRejsho/E6+
 xMoOhbA9apUBNzys0j8pZfhLkVstKTNsA1EgEclvK7ryZ71SGcixs46
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8c561e-2ee1-4169-143e-08dedc2309c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	pXlH6HLoj0eeilc3/ptW0c0puHxtmut11IqM0PbUzGZlJbaawmudsBa26ZKdMC89cM309V9M8BGLvA2P1jOtvQU11j0VADE9AYyDs00Zkg0QNpZdYXVCkwUo5IlfBDz3JkJGCM2+zyR8yrYPmujvT3kgJnyyAl10MA7b587HqT0SoY0p2qQ8wJwPMv57o2pBp4+Bb9iZojAD+tKYYF/tzcGvYRHEGjO2IcTdZiNhWrCIi56qWQTsSZCRVNVjMVtYuHZA63NMlAZGg+o3XPATRPLMSGBEbrRwCU0r0V6LomGL8FNSLGG/pqlO+w723j/YN+tmji8eco91FD/GrGYYCqgL+hdo8Cg6wfCsizKFS6ixPpfD7IEv0TO+XSmUN2NmJAi+wE5twKh/JuWCHN6VbrGO/RFOYMDOtFfOxO0Y1/YTMtgs2NiUKf9P/sGw+dUjnDMWR1sA3vd/Rfp3vb0eXKVcnUylYCDo4kdJvdK7Y+c1ETNEoYPorDfHcD4M0vMu1HQY9nAZKmI4m7aOfblqvc9za2eOsdBKvdp5/888oLFuykMd5ax9bqpmEep5f1klBk9DLp+wuNmC0ofnQOnelFWzE8kb7vEJDxwzWeq58sIjyX9jtJ2cQp1JDVwoLBiJWb11VbNZRbl9wTjovd+NZDFyUustjb57ZNchU5krLXIF7MPxLIq7FhjCXytpU178+sccm4anxOx6Fbi511LXRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU9GMm9lNE1RR1ZmV2JkWUl3eHNxSkhHY01ZYmFGQjQzNVNBcFcxU1VhYW9z?=
 =?utf-8?B?Yzk2LzVoSlV1bVBwN3JrZnN1Z0hlOThxRklsU1NHdFdkKzNxVEoyZnVGVU15?=
 =?utf-8?B?Tzg5d0pvWWp6REtFN0FoL2ZUaE1lMzB4MW1mSmhoOExzK0RNUStxU25lWW4y?=
 =?utf-8?B?K2xUR0RVcWZOU3hHekxjVkpHeWEzcGNNOEZEcVByMzZkWnZnMFpyV3pnWkRL?=
 =?utf-8?B?SWhURTUvNHlYakpDWXlkN2R2ZXo1SHUvTHMyeEtDc0w3VWJrSUIvNGVzenY0?=
 =?utf-8?B?UUR3TS9jNmJtc0dOV3BvbW1ReTRHejZrczJUbzlFais3dW91OE5DdklOdEdR?=
 =?utf-8?B?YWN0Z1UyUE03MzF6UUhCM2loR1dKS2Z4MHRTZW8xVHJISjJ5dXIzVDR4V3F4?=
 =?utf-8?B?SytoK3JIVnlGZ1JMQnF3SmR0Y2ttZVR0d0dWVzFoOEI1N1p6clpGL3hpeHNO?=
 =?utf-8?B?UGRqY2tEODJKUk1qUVQ1NjNNZnk3TDVqK0RvcmNqVzcvRi95TGw5cGpkVVg4?=
 =?utf-8?B?N1h5TVBnK3NIOXI3TTNFVzdyOVVtcENuTEJhdUZ2aDNCS3BVRXlrVTNaenQ5?=
 =?utf-8?B?YmUyQW5WdG9LcFZZRUs4SUhWdkJwaE9CTGw0c3Q1LytNM0RpdDNRVVExTURV?=
 =?utf-8?B?SGpCbHk2RWp4SEtURW1LNFZqY1gzYlBleEFWN2JLb2Njc0FPbXQ5YTRJR2ZX?=
 =?utf-8?B?UDNtNDhUL2ZxMi9BSjFWdWNzQVJBcnBiOGhuT3JUK1RYMklQQ0Rkck83Ujdz?=
 =?utf-8?B?WWQzRTBsZlkzRjQyRjVBUTh6QkRkanY3SlhjVS8vOVoyV0VCREphRTE3U1lm?=
 =?utf-8?B?NGRzZzNkR1htZFpHS0R2QkMxNHlTVTZLeWUzNWNCRmFPbkR3ZGdWaTZrUDZQ?=
 =?utf-8?B?U2E0NE9QQXVkWWVxV08vTTlkc2h6TDUvM0Vvd0paRzBDQkpsazRWS2xrelUw?=
 =?utf-8?B?NGErWXB4enlaS1FINDUyUEsybmFkajJ3SlA0QWxZTGdVTk42QnFXN0JsQTB4?=
 =?utf-8?B?V2ZtVnlDWERvelNEMy96VUlwSzFZRlA3UjJ1OEhqam82Yk5TZWljMVd3eG5K?=
 =?utf-8?B?WGRsVWlIUEllUnpOaFhqOE9IZ0xQVXZ5dkFKdndJbHh1V0M4MGpHTzcvdklR?=
 =?utf-8?B?aG1MWWhxM21tODJEUVIxTE9xYnV5ek9zK1BuTW40ZWFJL1F0WlBvalUwc0pO?=
 =?utf-8?B?YXNjMWR1MjZSVFhkcXFkVWoxc2VZZVM5UllaaXdMM1dJdXdVZVBjcjQvckk2?=
 =?utf-8?B?Uko1bWNxS0tDQ21ySFFyWmhVcWtnMWx2RVB0RmpIaUxqWjNDYVVsVGtpSzAy?=
 =?utf-8?B?alhNazdhTEQrVXNkSy8zYU1sMkRJSENYdE5LSVZmd2MzL1U3M2ZLdE02eGht?=
 =?utf-8?B?U1FtR0x5cDhxUFoyUlhGS1RnVXd5ZTFGVzBLU1VXVjdKbi9FR3huMU9XTUFi?=
 =?utf-8?B?RUZtaHhaZTNyRmlnQmJWYmVmYlRoQmxHeHNVTXV1NlR3Q1N6WW5Cd2lzcUdH?=
 =?utf-8?B?MnNtZ2orRVViNXZpd1dZQUx5b1VmVXE0d3VYYXhWcFl5VXFrRVZpOXF6bmZO?=
 =?utf-8?B?NHBZdEU5QzFaZ0NhdEJoRXlnd0FwM3hiTzJBOFAveVhCOVhqRWV6cUZWWWlQ?=
 =?utf-8?B?UU5JWWtKd0Ixb1FIb2xVYTB5RWl2YU9HMk02aW9hN3c4TktDdHBlSDNSLzlG?=
 =?utf-8?B?TnVZRkp5SU9WOEZmWHlzZXV1U0dua3VSaE0ycWIxRUw3Qmx3ZDVUVG9oVGcy?=
 =?utf-8?B?dnRseGFkQWVqdDZDRnoydHhCZ1J6NzNlTjQ2L1U5V0FINnhqSFNjVVNFN2NX?=
 =?utf-8?B?SkxDZHllbURSMjNPZ0t5R3ptTUJmTWQ2WVdmRGl0YmJGd0FQZkQ0c21USFl4?=
 =?utf-8?B?RGZwejBCTUNXQURjcVY1QUJTa0tPemk3YTNybkFURGx6UnM0Nm9WSjM3SE4r?=
 =?utf-8?B?VlFGNDNyclp4ZGdUU3ZTKzdEN1oyMXhHYzUzcGw0eGczaEdtVWZNd0NIckRV?=
 =?utf-8?B?WDRtbTlQSzcyZm5hVWtXbjl3Y3BHWDlmbkx5WDZrNFNmaENHdGl1UFB1WXB5?=
 =?utf-8?B?a21zK1NTUjFNcDZsK1FLOXMyQ1A5N0srcVN3L1dSYko1TTlvbnM5ZzFjT0cw?=
 =?utf-8?B?aFMxT09UeEJrMTBqYU1pcktybWJSM3pxaXlmYjMzazl2a3kwMTRReUhKdmVV?=
 =?utf-8?B?VURHMUs5R21wVHdDb0kzbXdKMlNxUjV5RWsvMU9WVVIvM3NQeFZLRDk2RmRO?=
 =?utf-8?B?R3QyZFBUT1NZeDYwS1F0TlRwS05FTW5JYXR6VW9yYkYyMFd0VWxQTVl2THlG?=
 =?utf-8?B?MHVvdUR4Z3EyWXBEaVJKaTdhYk14SEo2cGhzSEZWQ3A3OGt0YTI0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8c561e-2ee1-4169-143e-08dedc2309c8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:57.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhEkZe9Y+p6DtsN1o5dbBK7eUZNxbjyfveEVd+yRokltlTEW74MDJN8iyXDkE8ykcMD4wlMjBTzbeu1IMVM9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7369
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38752-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A976E71B545

The driver info should be retrieved using the driver_info field, not by
address comparison.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/media/usb/as102/as102_usb_drv.c | 73 ++++++++++++++-------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/drivers/media/usb/as102/as102_usb_drv.c b/drivers/media/usb/as102/as102_usb_drv.c
index a11024451ceb..be2f8be560fa 100644
--- a/drivers/media/usb/as102/as102_usb_drv.c
+++ b/drivers/media/usb/as102/as102_usb_drv.c
@@ -24,35 +24,33 @@ static void as102_usb_stop_stream(struct as102_dev_t *dev);
 static int as102_open(struct inode *inode, struct file *file);
 static int as102_release(struct inode *inode, struct file *file);
 
-static const struct usb_device_id as102_usb_id_table[] = {
-	{ USB_DEVICE(AS102_USB_DEVICE_VENDOR_ID, AS102_USB_DEVICE_PID_0001) },
-	{ USB_DEVICE(PCTV_74E_USB_VID, PCTV_74E_USB_PID) },
-	{ USB_DEVICE(ELGATO_EYETV_DTT_USB_VID, ELGATO_EYETV_DTT_USB_PID) },
-	{ USB_DEVICE(NBOX_DVBT_DONGLE_USB_VID, NBOX_DVBT_DONGLE_USB_PID) },
-	{ USB_DEVICE(SKY_IT_DIGITAL_KEY_USB_VID, SKY_IT_DIGITAL_KEY_USB_PID) },
-	{ } /* Terminating entry */
+struct as102_dev_info {
+	const char *name;
+	/*
+	 * eLNA configuration: devices built on the reference design work best
+	 * with 0xA0, while custom designs seem to require 0xC0
+	 */
+	uint8_t elna_cfg;
 };
 
-/* Note that this table must always have the same number of entries as the
-   as102_usb_id_table struct */
-static const char * const as102_device_names[] = {
-	AS102_REFERENCE_DESIGN,
-	AS102_PCTV_74E,
-	AS102_ELGATO_EYETV_DTT_NAME,
-	AS102_NBOX_DVBT_DONGLE_NAME,
-	AS102_SKY_IT_DIGITAL_KEY_NAME,
-	NULL /* Terminating entry */
-};
+#define DRIVER_INFO(dev_name, dev_elna_cfg) \
+	.driver_info = (kernel_ulong_t)&(const struct as102_dev_info){ \
+		.name = (dev_name), \
+		.elna_cfg = (dev_elna_cfg), \
+	}
 
-/* eLNA configuration: devices built on the reference design work best
-   with 0xA0, while custom designs seem to require 0xC0 */
-static uint8_t const as102_elna_cfg[] = {
-	0xA0,
-	0xC0,
-	0xC0,
-	0xA0,
-	0xA0,
-	0x00 /* Terminating entry */
+static const struct usb_device_id as102_usb_id_table[] = {
+	{ USB_DEVICE(AS102_USB_DEVICE_VENDOR_ID, AS102_USB_DEVICE_PID_0001),
+	  DRIVER_INFO(AS102_REFERENCE_DESIGN, 0xA0) },
+	{ USB_DEVICE(PCTV_74E_USB_VID, PCTV_74E_USB_PID),
+	  DRIVER_INFO(AS102_PCTV_74E, 0xC0) },
+	{ USB_DEVICE(ELGATO_EYETV_DTT_USB_VID, ELGATO_EYETV_DTT_USB_PID),
+	  DRIVER_INFO(AS102_ELGATO_EYETV_DTT_NAME, 0xC0) },
+	{ USB_DEVICE(NBOX_DVBT_DONGLE_USB_VID, NBOX_DVBT_DONGLE_USB_PID),
+	  DRIVER_INFO(AS102_NBOX_DVBT_DONGLE_NAME, 0xA0) },
+	{ USB_DEVICE(SKY_IT_DIGITAL_KEY_USB_VID, SKY_IT_DIGITAL_KEY_USB_PID),
+	  DRIVER_INFO(AS102_SKY_IT_DIGITAL_KEY_NAME, 0xA0) },
+	{ } /* Terminating entry */
 };
 
 struct usb_driver as102_usb_driver = {
@@ -336,29 +334,18 @@ static int as102_usb_probe(struct usb_interface *intf,
 {
 	int ret;
 	struct as102_dev_t *as102_dev;
-	int i;
-
-	/* This should never actually happen */
-	if (ARRAY_SIZE(as102_usb_id_table) !=
-	    (sizeof(as102_device_names) / sizeof(const char *))) {
-		pr_err("Device names table invalid size");
-		return -EINVAL;
-	}
+	const struct as102_dev_info *info = (const struct as102_dev_info *)id->driver_info;
 
 	as102_dev = kzalloc_obj(struct as102_dev_t);
 	if (as102_dev == NULL)
 		return -ENOMEM;
 
-	/* Assign the user-friendly device name */
-	for (i = 0; i < ARRAY_SIZE(as102_usb_id_table); i++) {
-		if (id == &as102_usb_id_table[i]) {
-			as102_dev->name = as102_device_names[i];
-			as102_dev->elna_cfg = as102_elna_cfg[i];
-		}
-	}
-
-	if (as102_dev->name == NULL)
+	if (info) {
+		as102_dev->name = info->name;
+		as102_dev->elna_cfg = info->elna_cfg;
+	} else {
 		as102_dev->name = "Unknown AS102 device";
+	}
 
 	/* set private callback functions */
 	as102_dev->bus_adap.ops = &as102_priv_ops;

-- 
2.54.0


