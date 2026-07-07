Return-Path: <linux-wireless+bounces-38753-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avhrHsDwTGpUsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38753-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:27:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21071B559
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:27:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="oEt/4JPX";
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38753-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38753-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6ECE23042B8E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0823C414A10;
	Tue,  7 Jul 2026 12:27:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020078.outbound.protection.outlook.com [52.101.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41340D58D;
	Tue,  7 Jul 2026 12:27:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427225; cv=fail; b=AGSn7sKkJDqWEW7zApRjl1DJ9ls19Mj0vDEpdFMEd/xpbxxzZAqxhZdXof0dlNqTMg+ulWBsXE7YJG/BusxEE11+TJ3MEBRGCePH4RSiNncI5DrT5eYTJKXgN6SiZz6U+JeXlaY84BSuXt9BVebsw6kW3C9kt/4vbUvM9NDe/ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427225; c=relaxed/simple;
	bh=mQt4GX99A0rxCSX6TmR75VvpTMuybzpbb+lleSgOg0k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X3NhlwL/IpRLxsAtph/uxl/Nu0IrhxKwT2IycJ3B2QkL/KQiUYUUnEEdfKibwl48QxeCZF/Vv2HIN+cH4bDC9Bi3dPGR4Ig/+fEZl2C9/ndJtKerd2XyD8nNfXi/04frnc+hhezIQTNc7YoRdQ76C1fH9O1kdkhwWC3iisFlpR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oEt/4JPX; arc=fail smtp.client-ip=52.101.195.78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HujnRfVWCtT8Q+HrPZ7Yj5zl935w5cEb0deAtjyKsGMiLHu47XNPFAUVl+b/h/bgOvE0S4oTGFMxz/zocojRo66t3zEPLetMaQwinhfn6z12O06HvIQ65/SIKLrJNmG3tG1iLEl1oGpo6/WyKo+DMULdPHZzMEn2fx+WQkDDNVkg25lwSywb0Qx0OFepdUfX4Hq4NxVYL3WFQGaGIPv/LESf8oT2JHqC1zL2go+ikgrXEM4vGRvzIhw9aFBnw02N8+IgBTfmc9J53GVjWY8TBEJkrjhMpZriggLRfD8Q8En8DRqOamIugVLOUqEdjxLY/rkmcAzocOE7n3rESTcwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha8d1zmRJYHoxFwY7QskfF49lT/+G7XOz/+2aIwZx3A=;
 b=y9nsrBDSW46XJJqs5mef7mHceP5xz70OIHCS5P5G5IEfabUM2ULRqcRVbifQjcVuaiKSeB9vbKRgpJD00VzS9ZTLu1PalulRRkGHcBVTWNcmePxAjlrphjVeegMdYpkkzQ59Mz9cieoIdHhkNIve943BERjK6rIDU4966/OLubb+QDaRUBpzVCORZlfI50mCf3TTARJJemRjbndtTDPhXZqb+zHAmVQPqU+JslEqdqy61JZo6xrsPCbu+sVnU3goY0BQ/ua7K7hQQSnAVtBQZeaHWCTb/s5XFdjXzGC8n29x/qeWlw48XT87Mc6eG8WSJ5dJiiEE8SyvF2EbWSyRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha8d1zmRJYHoxFwY7QskfF49lT/+G7XOz/+2aIwZx3A=;
 b=oEt/4JPXu8dtUy52f8CN6tw5xx10pZ5eIX9RKcntBkiSNRZ31lqwXlGIvIsqV8Njm/DDEl5t8jkuC4otNuR2hreIalmWaoHfd4WeT8jDCbmBNr9i8RSOpM+UFtZPe14Gpytj5QKWNfgZjbRa7qbWHQVuHveHdWTW8ubBwoywO/Q=
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
Date: Tue, 07 Jul 2026 13:26:44 +0100
Subject: [PATCH v2 5/7] net: usb: pegasus: don't rely on id table pointer
 arithmetic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-usb_dyn_id_uaf-v2-5-632dcf3adfba@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=6903;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=mQt4GX99A0rxCSX6TmR75VvpTMuybzpbb+lleSgOg0k=;
 b=K2YgvVACGofbvIuTjS7w1s86oo7d8TVogZFLiVle7hwPgF7LYd8JreBHLIA4POvQ71UIj4pAQ
 wstgohiduLvC806MHI+D3tyx6Lel+DGyiWrh0zthBTtVCrQl+5z1WR0
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
X-MS-Office365-Filtering-Correlation-Id: e5c9010d-103f-4449-9c5d-08dedc230a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	0VDWJ6Y/BjGRuon8D2KL3wUpo49EzQ4Vwvp0ZkhTXWJbKZTEEk6t02U9NRL5FRw6iELBsS+PU8+84yA5IxFg6f3zzhYJj5wTtZykSg3/RH+zMq/f6Qs3wFAHA5MshvnkWRC3oytZ8e3dK5s14Uufw1Uhxf027XKHwQsaPmskHJrqNhK2cSFs2Jik0KOmcdxCPmAwLbOaA4Y8Aqa/tN7GK3QHTwii/I4K5OZRY4RqK/8tyR1TyZLuGmDzXLBWoNxNkw/94scdqGwuy23meSk/ifFRK4PKjdjDAUAK26czEV7PleAh7gs7Fi94SjmC8cRkDpBIfRu3m6HvAPEt9F0RpGHt5UY7qskuT9LA8NSK8BcbTKhrtLB38M1YtguFpLICvwhD9ckiasW+TlmmbKQtEr1OkEm0U1IPh6CB525ytHFz2NtujTK6jXlkRyIweAAIi8gYJvMq49Ab7q3IMysFKYzwwJGSSofq16syLaTcXc7ykTUDMvNn7NS8Xvnd3hZz57j47VuEUlOju5AuKAR3tuaiSZSHA0p69fJPlqlpFGA/FhXGdSiX0Qu6NbtIKHOmoowDBchzYzLFoWAiR/ahRWIzjp4x/C+9zyCDtbAfFq+WditCyLs8rAkeSEGSUC95Drc18jDlorz8He7WxeSxJ3sO7RriyRKVJENA24ySc/MtObRHyxVBr/+QKVjAKJV+pY89qrpNTLqfbKR5WqK62w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dURrSzIxTTAzN2hMZysxenp3aDBsby9hRHpKNGE1ZlNsVld2M2ZINlNpb2dx?=
 =?utf-8?B?WG1ZbmVoT0Y4aE1ydWk2eXlsQytUdktoRXlXUGg0KzhjUW1VKzFicWo4VjJu?=
 =?utf-8?B?Ri9CUThGcy8yczY0RHJ0L2laamJmS0o2YjB6MkZhTUdhNmY1T1M1K0xRZnFm?=
 =?utf-8?B?WGd3L1pzK2ZoTUNKQmZ2TFFBSDhKeEtmK0kzMS91UzhJLytpMGp5SjRaR0FO?=
 =?utf-8?B?TTlOaUEvTWI2YWJUOTg5Yk9KQURON3JYay9VSEMwNzArUHdhdFNDRGdnakZz?=
 =?utf-8?B?K3MveHp6Y1k5d083emZ3OGRYNmhOdDJtUWZGM1lvZTJIQ214Nk45SlRTYjIx?=
 =?utf-8?B?aFViV1VQVmQ3d2d0dXRiTnMyWGtMZngyVDVqWi9Lbks0bzVQUHorbFdHTThZ?=
 =?utf-8?B?K1duUmZGaUVFbHdwZFBnbHZLVTJ4RFVsYjlmbzNPQTNjTFdHZ0NxakF2eDRl?=
 =?utf-8?B?TjVpa0ptdHFtTGNlMnBmUWNqeHBaZXR6bGtBZEZla0dVZlMvV1hCU2xOS1JJ?=
 =?utf-8?B?K1NpdkwybGFjYk1Vcm9hdDhQZlYvd0hIN2Irc3QzVkdha0NPM0s2T3puSXhy?=
 =?utf-8?B?eXM4YVFPTmZlU1RIRXlHbHNwZVR1VkZ2WFdhODYzMGNERHRVOVdZbks2aU92?=
 =?utf-8?B?MWFBMW5rQXVkZjYyYkJGVFJhclB2SlNoSElrMjVMNEROVWFqVGxlajhCOWRT?=
 =?utf-8?B?a2RQcjdsVS9PaitGVWtoSUxLSHoyOVJUa2UxRW9aVFRrU1ZPMFdHVDQvZlRM?=
 =?utf-8?B?VmRjcms5S210UjVHbVNEU2JlblMzbG1hWUlzUlFET2JXVnMrbkEzZHd3MlJM?=
 =?utf-8?B?eVJRNXZjTUEwdFcrZit5bk9rMXdLU0svNGxnWmxnTXN1SGRIZXZjMURHa2tx?=
 =?utf-8?B?bDBNc0JiMEJmZzNEZ0VYQUgwSW8rVDh0cDJZd0NwK1B6ZDhydDUrZFh5OHND?=
 =?utf-8?B?UFZPaWgwckx0eG92U1hnKzYrTEU0cUVSWENyNXMya3p5SkZueG1paU1oOVp4?=
 =?utf-8?B?RUV6Q25SeUp5VFF5Q1RtTkdkVGFzQlBGa0I5Nm5uZzR4VjlaM0xmY29mNldV?=
 =?utf-8?B?ZGlyMFpXd3FxTTNpb29scHZuRTRQeCsyTjhNK2F2ODBTUmhTVGxyUnZQeUl2?=
 =?utf-8?B?NDJBeDIxVEZ2UG5ISnhJZitqbjhUWDNlbWNBNmdjYlk5S2FTQktEYS9sZlRQ?=
 =?utf-8?B?eDRqU0J1bjY1VVhBTERvL3FzTFd2N085QzBEYzFIN2p3aGttK0hIcG52YlhP?=
 =?utf-8?B?MWwyYkZtUks0SWE3c1pvMWNzUWlBMlVVRE9JanYxOUhNNGFUc08wTDlFVXdx?=
 =?utf-8?B?MGpMUll1d1pybmlMU1ZDSDk1QWliZWtDUXRVeCszdFZxT0pmWk51U2hheS9M?=
 =?utf-8?B?SnFIelduZnQ0Z2NGblpKbVZmdmxNK1FvWWs3RkdrZGdqbHBzd04xYWNSWUNN?=
 =?utf-8?B?dFN6UHFjejRDOVlLVVlkVktHMDFlRHVPZC9EQnNocE1pdk1SVGRFbVJHYWJN?=
 =?utf-8?B?VWliZUdVNzdmV3NnWnRYZFZHZnR5eG44ZGYvKzVNcURzbXMvdUhSWlREQ3Jl?=
 =?utf-8?B?NkExSXF1cEZpaGlUYXJXa1ZNWDVLNUpCRm9mVWxSbXNHaUtPb200VUY2WWVH?=
 =?utf-8?B?WjJkTkhrdHVWQ2ExRUZpcmNYU0xMNXRwanlrY2JKam04QndTTW5Rc0pTNS9V?=
 =?utf-8?B?QU92VlZiWno0MGkxL1ZsWXplVlZsTnlzV2I3bEFIQUVDSUJVdEo1TFQ3K2V4?=
 =?utf-8?B?dnpwU1poaVRwZHdUNFIrL3QyTnhacjJyYWpib0wvWVB1RXN4VlphTHlhdk5C?=
 =?utf-8?B?aTkveHF5bTdIQ2lWcU1TWERNS2lOVXBqSm9vWTBHQ0szQTRnM2Zva2NpeFVV?=
 =?utf-8?B?OVNqSktZZmkwdVdwQXM3dEpMN3krYmdVenAybEhJWXI4bjJUb1BmWFhtN3p5?=
 =?utf-8?B?ckt1ZStHOWFPdnltUndBeTNWaEJqbUtHUGJtU1lONjB5bkZwNW1hY1RRNG1I?=
 =?utf-8?B?WUYxYnJmcTM0bS9sbDFISE5GTFJFTmhhM3lSNDMzSkdLVXZ1Rmxua3JVZHBh?=
 =?utf-8?B?UWM3eUZuZTRMSmQ4TDJqNk5xbEt3bUlnazhiMXAvc2VjSWorV203WWI3OXhI?=
 =?utf-8?B?QS9wZzRTV1FMZmRZTmZHbWhrNTZSb2liMUJsM2pFQUtkV1dKZUtibVZ5Mko5?=
 =?utf-8?B?SldjeDNBUHVXcFFoZmFUOVNOM0ZSOUVkZjQxbGptVmVRVVVaWWI1L1hPRm9y?=
 =?utf-8?B?c0YyV3hQT2R0dWJEUkpRbUZJSFBTYzE3VnhJK0lJUTVMK2R2TTBrMWkwVnhG?=
 =?utf-8?B?UmJOZTJ1K0JzZ3k0KzVLOFpyVUVlaFE5R2picEhVbVF4Um5tWTFLQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c9010d-103f-4449-9c5d-08dedc230a07
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:58.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICsHmIHOkGYhT2mtsMmQ5y5B42P3o7zFcWh+BaM1S+DIjLdhnhot/90CW3UNgSAiC3PWU7mDLpDEGR3s6ev54A==
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
	TAGGED_FROM(0.00)[bounces-38753-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 0A21071B559

The current code is broken when dynamic ID is involved; in such cases
usb_device_id parameter of probe lives on the heap and the pointer
arithmetic will get an index that is wildly out of bound. Instead of
keeping a side table for additional information, use driver_info field of
the usb_device_id.

The dynamic ID parsing code needs to be updated for this; convert it to
just write to the reserved entry for dynamic ID and remove the weird loop.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/net/usb/pegasus.c | 54 +++++++++++++++++++----------------------------
 drivers/net/usb/pegasus.h |  3 ---
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 8700eeb8e22d..aba1a640fc26 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -43,21 +43,12 @@ static bool loopback;
 static bool mii_mode;
 static char *devid;
 
-static struct usb_eth_dev usb_dev_id[] = {
-#define	PEGASUS_DEV(pn, vid, pid, flags)	\
-	{.name = pn, .vendor = vid, .device = pid, .private = flags},
-#define PEGASUS_DEV_CLASS(pn, vid, pid, dclass, flags) \
-	PEGASUS_DEV(pn, vid, pid, flags)
-#include "pegasus.h"
-#undef	PEGASUS_DEV
-#undef	PEGASUS_DEV_CLASS
-	{NULL, 0, 0, 0},
-	{NULL, 0, 0, 0}
-};
+static struct usb_eth_dev dynamic_id_info = {};
 
 static struct usb_device_id pegasus_ids[] = {
 #define	PEGASUS_DEV(pn, vid, pid, flags) \
-	{.match_flags = USB_DEVICE_ID_MATCH_DEVICE, .idVendor = vid, .idProduct = pid},
+	{.match_flags = USB_DEVICE_ID_MATCH_DEVICE, .idVendor = vid, .idProduct = pid, \
+	 .driver_info = (kernel_ulong_t)&(const struct usb_eth_dev) {.name = pn, .private = flags}},
 /*
  * The Belkin F8T012xx1 bluetooth adaptor has the same vendor and product
  * IDs as the Belkin F5D5050, so we need to teach the pegasus driver to
@@ -66,7 +57,8 @@ static struct usb_device_id pegasus_ids[] = {
  */
 #define PEGASUS_DEV_CLASS(pn, vid, pid, dclass, flags) \
 	{.match_flags = (USB_DEVICE_ID_MATCH_DEVICE | USB_DEVICE_ID_MATCH_DEV_CLASS), \
-	.idVendor = vid, .idProduct = pid, .bDeviceClass = dclass},
+	.idVendor = vid, .idProduct = pid, .bDeviceClass = dclass, \
+	.driver_info = (kernel_ulong_t)&(const struct usb_eth_dev) {.name = pn, .private = flags}},
 #include "pegasus.h"
 #undef	PEGASUS_DEV
 #undef	PEGASUS_DEV_CLASS
@@ -402,12 +394,12 @@ static inline int reset_mac(pegasus_t *pegasus)
 	if (i == REG_TIMEOUT)
 		return -ETIMEDOUT;
 
-	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
-	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_DLINK) {
+	if (le16_to_cpu(pegasus->usb->descriptor.idVendor) == VENDOR_LINKSYS ||
+	    le16_to_cpu(pegasus->usb->descriptor.idVendor) == VENDOR_DLINK) {
 		set_register(pegasus, Gpio0, 0x24);
 		set_register(pegasus, Gpio0, 0x26);
 	}
-	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_ELCON) {
+	if (le16_to_cpu(pegasus->usb->descriptor.idVendor) == VENDOR_ELCON) {
 		__u16 auxmode;
 		ret = read_mii_word(pegasus, 3, 0x1b, &auxmode);
 		if (ret < 0)
@@ -445,9 +437,9 @@ static int enable_net_traffic(struct net_device *dev, struct usb_device *usb)
 	memcpy(pegasus->eth_regs, data, sizeof(data));
 	ret = set_registers(pegasus, EthCtrl0, 3, data);
 
-	if (usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS ||
-	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_LINKSYS2 ||
-	    usb_dev_id[pegasus->dev_index].vendor == VENDOR_DLINK) {
+	if (le16_to_cpu(pegasus->usb->descriptor.idVendor) == VENDOR_LINKSYS ||
+	    le16_to_cpu(pegasus->usb->descriptor.idVendor) == VENDOR_LINKSYS2 ||
+	    le16_to_cpu(pegasus->usb->descriptor.idVendor) == VENDOR_DLINK) {
 		u16 auxmode;
 		ret = read_mii_word(pegasus, 0, 0x1b, &auxmode);
 		if (ret < 0)
@@ -1153,7 +1145,7 @@ static int pegasus_probe(struct usb_interface *intf,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct net_device *net;
 	pegasus_t *pegasus;
-	int dev_index = id - pegasus_ids;
+	const struct usb_eth_dev *info = (const struct usb_eth_dev *)id->driver_info;
 	int res = -ENOMEM;
 	static const u8 bulk_ep_addr[] = {
 		PEGASUS_USB_EP_BULK_IN | USB_DIR_IN,
@@ -1178,7 +1170,6 @@ static int pegasus_probe(struct usb_interface *intf,
 		goto out;
 
 	pegasus = netdev_priv(net);
-	pegasus->dev_index = dev_index;
 	pegasus->intf = intf;
 
 	res = alloc_urbs(pegasus);
@@ -1206,7 +1197,7 @@ static int pegasus_probe(struct usb_interface *intf,
 	pegasus->msg_enable = netif_msg_init(msg_level, NETIF_MSG_DRV
 				| NETIF_MSG_PROBE | NETIF_MSG_LINK);
 
-	pegasus->features = usb_dev_id[dev_index].private;
+	pegasus->features = info ? info->private : DEFAULT_GPIO_RESET;
 	res = get_interrupt_interval(pegasus);
 	if (res)
 		goto out2;
@@ -1235,7 +1226,7 @@ static int pegasus_probe(struct usb_interface *intf,
 	queue_delayed_work(system_long_wq, &pegasus->carrier_check,
 			   CARRIER_CHECK_DELAY);
 	dev_info(&intf->dev, "%s, %s, %pM\n", net->name,
-		 usb_dev_id[dev_index].name, net->dev_addr);
+		 info ? info->name : "(unknown)", net->dev_addr);
 	return 0;
 
 out3:
@@ -1325,8 +1316,9 @@ static struct usb_driver pegasus_driver = {
 
 static void __init parse_id(char *id)
 {
-	unsigned int vendor_id = 0, device_id = 0, flags = 0, i = 0;
+	unsigned int vendor_id = 0, device_id = 0, flags = 0;
 	char *token, *name = NULL;
+	int dyn_id_index = ARRAY_SIZE(pegasus_ids) - 2;
 
 	token = strsep(&id, ":");
 	if (token)
@@ -1348,14 +1340,12 @@ static void __init parse_id(char *id)
 	if (device_id > 0x10000 || device_id == 0)
 		return;
 
-	for (i = 0; usb_dev_id[i].name; i++);
-	usb_dev_id[i].name = name;
-	usb_dev_id[i].vendor = vendor_id;
-	usb_dev_id[i].device = device_id;
-	usb_dev_id[i].private = flags;
-	pegasus_ids[i].match_flags = USB_DEVICE_ID_MATCH_DEVICE;
-	pegasus_ids[i].idVendor = vendor_id;
-	pegasus_ids[i].idProduct = device_id;
+	dynamic_id_info.name = name;
+	dynamic_id_info.private = flags;
+	pegasus_ids[dyn_id_index].match_flags = USB_DEVICE_ID_MATCH_DEVICE;
+	pegasus_ids[dyn_id_index].idVendor = vendor_id;
+	pegasus_ids[dyn_id_index].idProduct = device_id;
+	pegasus_ids[dyn_id_index].driver_info = (kernel_ulong_t)&dynamic_id_info;
 }
 
 static int __init pegasus_init(void)
diff --git a/drivers/net/usb/pegasus.h b/drivers/net/usb/pegasus.h
index a05b143155ba..ccdedcef52e7 100644
--- a/drivers/net/usb/pegasus.h
+++ b/drivers/net/usb/pegasus.h
@@ -85,7 +85,6 @@ typedef struct pegasus {
 	unsigned		features;
 	u32			msg_enable;
 	u32			wolopts;
-	int			dev_index;
 	int			intr_interval;
 	struct tasklet_struct	rx_tl;
 	struct delayed_work	carrier_check;
@@ -102,8 +101,6 @@ typedef struct pegasus {
 
 struct usb_eth_dev {
 	char	*name;
-	__u16	vendor;
-	__u16	device;
 	__u32	private; /* LSB is gpio reset value */
 };
 

-- 
2.54.0


