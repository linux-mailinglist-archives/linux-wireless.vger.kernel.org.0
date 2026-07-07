Return-Path: <linux-wireless+bounces-38755-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XAV0CPfwTGpqsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38755-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:28:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C371B58D
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:28:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=AhmtHp3D;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38755-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38755-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A0F23058F77
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4941930F;
	Tue,  7 Jul 2026 12:27:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020078.outbound.protection.outlook.com [52.101.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9E414A22;
	Tue,  7 Jul 2026 12:27:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427228; cv=fail; b=Ptbz5RnzP/uC873t+irZuXNgUEpUrO/0VUFIduuBVWXO7pv1t1DND3CwwDsUAF2ZiU+niowKgeEvrgsdJ3Dynsl5RwuqSvBiB+xLVxC87k8DCr/n+jMgI9L+Kas0F2UdrW7NWB2kpSMPcCueEaOXDBS3WRDP1k5/dMmuU/Ui+Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427228; c=relaxed/simple;
	bh=bGNGx/Pqz/dMHsHlRYZxTN/Xro5PB9TMed2dxLbQkrw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ryyS4+9kSOrAiKsTZMZ4sniAojXaeX8Ijk4ntv49u3tJ2Mcd9FbZP1PPikYcdaGaqwJemTKKPoMFm471F1sk+bUkGz19VQNRwQBrJD2SdftRD95a5FJ6V70zFjfcJ5eVTdxbQYwd8s1eeEFKMvhdoD1Ouj58PAalQVAxkgHuT5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=AhmtHp3D; arc=fail smtp.client-ip=52.101.195.78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBlS1fMyIcUm0vLUrVNh4rnmfpAnyhiNVxeFHMR//wZuQ6NF48ArmcHGT9GcafaFKFigfSDi5suX15iZX3+V7Mg2jnz+mjVQPu6wrJzl41cv/ZhNtAiJCL6NH+olFwC4jhPJS9Nc9RVFZtQdY7yZ1eg/yrZUFgzoSBqiDu8LaquBBA2Y3bvMnQo8VP8yFLcdtngJaLh8dx7fbgdJdDDL1isjPiO/n5BSMaYRZhXIUjXQ7ZUdbpk2kLQcjgzhf2EVDOTx+izOPgaRyTx556FuusaJZXe6MPfP9IaR68j2N2J4yLiZkBJFSFyGqI1D5Od9/AOf0nXDtAMqaEIuPoayUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqwwzOYOStFtXTj/Pif0JcuM2QAoi+rH/5+Zid+CsUE=;
 b=vDSN2/tjhO3BmOPucEEN+TOMBILiqeqBo2HOyK0fKoFaxhUE0CZYArqVElDnBGaK5bpytq7Pasn/guUWOa0UWs0EgqjazV6GUgX5istn+aYMiHTaPvRnzBAhBQBPu/sehYQLMFvYf8f3sRWUkQfOmHc7+NO1aePbQBBCozA4tolMPegI+TgAd0ICMkz5GVQ8nV1qmo9cWkhZ19HAlFzrB9CDCv6VIKVCKhUwFo1eBA+ck4VFujGfXMfmuK3Zt9Wm2sVwpzriYzTvQ5x4IuUw3H32OG9jpBNqsTBw6GLpiIrj4DZIzJEbaFJK8NambFp+O5z9G8F14gG2PPY6YrDMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqwwzOYOStFtXTj/Pif0JcuM2QAoi+rH/5+Zid+CsUE=;
 b=AhmtHp3DP1H+9KHeZHDuCo5UrBEXoGGWKngBKaYdNZHFQsj2/c7c4c95kiHS1UrjgQUaHsY6fd27xix1L67uU7c3SjvdH2O8BcH5l0WrbecYk8ClDwe9QttspHGJ7d+93YMf0ckGHeuzP6YsJG8oFHfv20WIWSC5+MEA8L/YzuU=
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
Date: Tue, 07 Jul 2026 13:26:45 +0100
Subject: [PATCH v2 6/7] usb: xusbatm: don't rely on id table pointer
 arithmetic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-usb_dyn_id_uaf-v2-6-632dcf3adfba@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=1821;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=bGNGx/Pqz/dMHsHlRYZxTN/Xro5PB9TMed2dxLbQkrw=;
 b=s5v9BenMs7Vgz9bmemAB7Dd2sItCz9Uj4XhkdIifoefBnleKBE9irHAg1ikR2BbaObPqa6jj+
 ZsE3bMf9Tt2AAsa8u9jMHgIaFiN4qBM6wJgUrJhuMqIrHawXzAHIK2x
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
X-MS-Office365-Filtering-Correlation-Id: c688fbde-9639-494a-27a6-08dedc230a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	eiGV25/CqnTuIzC/jAp0aUAfh/DUhGM9yxXz/rywpPMbfz8h2IoRDeh40ogcq7dtkVZDbGFrDZ1BCus+Kx2u3ZQs1wCXgpR0gsWoW4gRZdTg0u9WKZF6x2GWFzgOlREmkLlvWVmV04mtYmJuzgINd7h3ikXFRPaV05Xc4yyLyx2zvlYUrPxoloov1HIE+Fhdx6EtpiD3QAfM56FBSei4yt5wa5WXOSCQW7riEKI0VL0a233T6kOJemjOkb1ac2MN7uzumOa6/7PmVuoonxmNfFeYV5BEqgcSCXvHqJh58nHAFIAOCeVl25AL8KxGpBvHxfWLE9ajwfKaGITKLx1KlkhT0MhHpGcFPkQvWpsyRaEBH00ELVc96qLHhS323U2rfl/mUzH/l5O27yiyd0Vswwz/8FnkpWkecUhGnR85mUT92POPyAO7MabHyBBHrJvkqIC93yCKjH31iG1iESZQRfPltXc0A3IE2p0odvs9vCiV3isSZKiAcv5CpYoolOHrwneQSgBUCmePlV/nPAyrjNXBEcdGWqWzo5/iEJ4wZMsw1QDWIAdi2woeLTXKQdOTw5/5iNKqFqsbMFS0OZuR8dmjigYtoIonxLxRoERXNJ2rzdyUZ52ZxUUtK5h0b13UMuHGxjiassz3QlaLvv9MC52R5D6bbqyFUAp0VPbaW7NAp2eoHaYDA4p730alufc2WsI9px1ZQwa4wQd3Gm5Yug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0o5UVV3OGVXUWF0SjNkU240YmJqN2lTYVFQL2syNXRkVG9mT2wzbUJKZEd0?=
 =?utf-8?B?MGFXa3NGNzN1TWRyazZxeUN6VSs3MWZHSGlkL0lMN1NRT21NZ3VEeWllVHFu?=
 =?utf-8?B?dXY5aXdLMDllSit1ZEFvZnZvZm1MOFBJRjdHRG5aNTVEelZlMlUvRDZZUlpR?=
 =?utf-8?B?dFVUQ0UrcHROakVDUTExSlMvNzEvdVUxaTFqMGw2dVVrUWEvcUV1WEpuVVBm?=
 =?utf-8?B?TUtMSGd3YUpIdUpTRER2NmRsOVQ3M2NJai90cnVtY2tsTXcwNWxFQk8vT3I4?=
 =?utf-8?B?cDdzYzZ1QWszajdyYmxmSjZZR1ovOStva2dGcXVmRG9sWVg3MzNxbnFZQzZM?=
 =?utf-8?B?ZVJHK0Z0QUxRYUlHSkhUcm9ZakVJYlVFemhUdzFndFE1QnBjS1JDcVJFMXdu?=
 =?utf-8?B?OEZDaEp1OS9ra0YzbEV0RXUwZmhuZDZnTnVCamxiS2haaDV5ZXcvckxSRGwr?=
 =?utf-8?B?Vi9pelZ6bmQzaXJ6Q1ZhZnE2d0tGWS9qbk1xdVdnSXNFTW95cVExMnQ3clZV?=
 =?utf-8?B?SmxicnlMY3F6amxZbkk3UjBDL0NmMU1ubFR3bjlaYUlNa3pHQ0ViM3J6Zzht?=
 =?utf-8?B?VHhkL0JsUTlISFJSN0FtajhQQWo2NkJYbnY1MGlOYnEyWnhZZkJDS01HMTRh?=
 =?utf-8?B?aGFERHV3cjJYY0lnbjNNeHViUTc5V2dVQUdrM25ITi8vN3ZoK0ZPWEZMdU5T?=
 =?utf-8?B?NXJqekRKdjlud3pBMTZPQ2xZRFo4ZzEyVnBDTmNxMFpabmdLNmlzcm1ZOFVU?=
 =?utf-8?B?bnZHcWFwYWdGalZlSUdMTzcycDVzSk5VSlNvWkRoSVN4YnRVSkQ2WGZ2U0pk?=
 =?utf-8?B?MFNrQk84aTVibE9DSWR1L0pIUUhpQ2tIL1AzRTVmb2szZXg3TlAzVlpTaEpI?=
 =?utf-8?B?QjhGUEtUUk8ybGpuaXNyZTJGVGJ5K1FtMFpzNFQvMlpIcEJ3aDFqMzVDQTRV?=
 =?utf-8?B?TzFwdkRLLzd3YTAwU05RZXkvRWVRc3N0aFl5aVhjWm82ZXZTbFZ3MGc4aEN2?=
 =?utf-8?B?RXBseGNsd3dwTEpJTUYrSGJlN2svYmhOZDdTS2FhMGNrdnh3ajY1TUZ0RmhS?=
 =?utf-8?B?NkFDeDgvVWhHZmZoakRpV2NZZnJXMU0xQyszbmpNVmlMaUY4WDNiV1FNVVlN?=
 =?utf-8?B?eTVvSitEZWV1Z2J4b2xnek0yVWZyT242TTdlMkVYY3o4UmlvdmVyRHNodUh3?=
 =?utf-8?B?NkFqY0hLV2l4WDNLakFOd0huU3BTamV4NnpBRkZ4QVlKbWVKRmlqWXpUNi83?=
 =?utf-8?B?b0ozeThBekg4aVVjdlJUYTB2cjR1dGs3NS95VndHTzBHMnFwNXBRU0E4Smpu?=
 =?utf-8?B?RnVBeTRpdnpEU2hCUTBjS09razErZU1RTXlEVmt4SnpxbmVIV0h4WHd6aWxv?=
 =?utf-8?B?SUFsbmthTk1KaEpPUGFKTC9CQ2tjeTBjcnRmaXkyNVNNVEFoaEFVOFZEWHNS?=
 =?utf-8?B?S0ZDYkxaWFh6MGJiR3BVU3RNZTJHMVBiS1c0aENtY3BwUnNRTy9yVnF3TmZs?=
 =?utf-8?B?VVczVm9oYWR0MU9NWDYxTkk0ci9vN1pOMllzRUpqSXZNMWc2TytEb1p5eGh6?=
 =?utf-8?B?KzdLSDZxWHIyUUtqRnF4YWJMMVdtUGp4cmRXMjRoQWc4aUxBeSs0T0F3RkN0?=
 =?utf-8?B?dFNqNWRjVWNRdjNmTUdTN1FkM2FCRGMyMGphTWUza2FzRjl5VFgvc3Vlb3Zr?=
 =?utf-8?B?Qyt5d0gxTTAxNHJUMGVKdTFBSm90QWtVK1BZOEROOWx4QkYvcWZEVGZoQm04?=
 =?utf-8?B?TlZrZjhxNzBoWHEzRkpvT0ZEbitkWCtNenZQdm55SGlNaFN4azNMb09kNFVC?=
 =?utf-8?B?RTBna3RlTmp2NXZIUHErZ2VSRHk5RGhCaXpDMkZhTksrTFBCU0VFYkZ3Um43?=
 =?utf-8?B?WDI4RFBpL1ZVemVMVStlK0hmVzVZZkF1S0g4U01mdjUvK1Bobko2eGxTK2lW?=
 =?utf-8?B?bTNTZ1dIZ0t4eThrcm4zUU5pTTkvQjhFZEhxdFNISHB0enBySmcraW1DUjhX?=
 =?utf-8?B?SkhpKzRiRzFmVDNGSDBMVWgzTjlrYkF4V1dUSlQvNGVvaDhReUh6dUhZUUs3?=
 =?utf-8?B?Y0lkZ1BPLzVrYUJqT0hIaDQ4bE80OVd0KzQ5K0hkZ3VWOGkzWVMyQkNIdmJz?=
 =?utf-8?B?eXZzQUxQRk1xd3A4UTZ6MVFlbnFLaEE4MElWZ2I1MUxVVWJyVFNHMjhMQTcx?=
 =?utf-8?B?cFVJQWMwdGtnZHRobWw3T04xTVc0WkFnMGU2ZkdBOG1BK0lEVzRGamdMYnl2?=
 =?utf-8?B?a0xLbXpJN29kcmE5UjZMOW5lb0w5Q0JjOGlWSFhRd2d4MTJGUm43ZGkrT29u?=
 =?utf-8?B?aUgwdS9rK1ZzOWpwZVk3S0R1aGJCVVZndEZINlV4OTNwNVkvRmpQZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c688fbde-9639-494a-27a6-08dedc230a4d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:58.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dp6M73q9IWO3TUFUuVr+VdscODzSNbKYczB4GP4SX5FEIxPpEZutDaj7XPPeKG/MZuvF9VgMLRf9wSUDXZiOmw==
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
	TAGGED_FROM(0.00)[bounces-38755-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 9F4C371B58D

The current code is broken when dynamic ID is involved; in such cases
usb_device_id parameter of probe lives on the heap and the pointer
arithmetic will get an index that is wildly out of bound. xusbatm
initialize the USB device IDs dynamically so it can just use driver_info
too.

Even with conversion, xusbatm still cannot support dynamic IDs, so also set
no_dynamic_id.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/usb/atm/xusbatm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/atm/xusbatm.c b/drivers/usb/atm/xusbatm.c
index 0befbf63d1cc..5c1e1f521555 100644
--- a/drivers/usb/atm/xusbatm.c
+++ b/drivers/usb/atm/xusbatm.c
@@ -79,7 +79,7 @@ static int xusbatm_bind(struct usbatm_data *usbatm,
 			struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
-	int drv_ix = id - xusbatm_usb_ids;
+	int drv_ix = id->driver_info;
 	int rx_alt = rx_altsetting[drv_ix];
 	int tx_alt = tx_altsetting[drv_ix];
 	struct usb_interface *rx_intf = xusbatm_find_intf(usb_dev, rx_alt, rx_endpoint[drv_ix]);
@@ -168,7 +168,8 @@ static struct usb_driver xusbatm_usb_driver = {
 	.name		= xusbatm_driver_name,
 	.probe		= xusbatm_usb_probe,
 	.disconnect	= usbatm_usb_disconnect,
-	.id_table	= xusbatm_usb_ids
+	.id_table	= xusbatm_usb_ids,
+	.no_dynamic_id	= 1,
 };
 
 static int __init xusbatm_init(void)
@@ -190,6 +191,7 @@ static int __init xusbatm_init(void)
 		xusbatm_usb_ids[i].match_flags	= USB_DEVICE_ID_MATCH_DEVICE;
 		xusbatm_usb_ids[i].idVendor	= vendor[i];
 		xusbatm_usb_ids[i].idProduct	= product[i];
+		xusbatm_usb_ids[i].driver_info	= i;
 
 		xusbatm_drivers[i].driver_name	= xusbatm_driver_name;
 		xusbatm_drivers[i].bind		= xusbatm_bind;

-- 
2.54.0


