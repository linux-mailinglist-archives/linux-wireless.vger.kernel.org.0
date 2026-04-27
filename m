Return-Path: <linux-wireless+bounces-35420-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAnGC4jY72koGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35420-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:43:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E198547ACCB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0619C30416AD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED6B3A1A21;
	Mon, 27 Apr 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QEnn3k+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D63A1D0C;
	Mon, 27 Apr 2026 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326139; cv=fail; b=Gk7LagKwOfwXPt4JwZiEFDHVqcIxFAB+nRUcb0qADA4r7ZOceYECpUlPtYFnOCmFgFIBAl47/7ETImUr83fSlwK+j28bWlJ4kzAYKucH/wnvCay//yHvCW0wyvN7YmdyKkHjN1pn1zMJDX1qpKVbeGv8PBpfMWlLR7mNOSwebrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326139; c=relaxed/simple;
	bh=iTpF4KIxXNzM3ZLXR4PlU3PeEE/HIHQ8pPxIAOapRlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRmEIThmQ5SxiVyQrqzFuqzpOaukH8jF9s6KMGOVrs7V1EP9u3HZESg4+zor7uz32EjwsaL5UAH1UAAmGCUf+mpDgGrcMjCH9aUVYCtx4tPLIXP8Qo9kJSIYNn/+Kr5WZ0zbEMBHepwwFsdGi2EMEYR7NC3AHFV5gGhAhRzV3XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QEnn3k+3; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYLOh2Q+S8z5ORnFMHIqurqZv8+oH/PHa1QDvqVtRYjUQbji/GPHBN4p3Fxq+258XsWDl5xVg0DNZ6riXqH7brPbvnq1Ov3xIcF9QsKa4p3MTHAMiIC8wKoeUitULZ7bGfyq9XGPJj1bZXI7a5qxqiAQQQLoIUZ/PHSb+pGq153Y69gxsI3VnfVcgW76eVwrpSunIKrmvjf9jf5mJO6g2RgqfO3r3sgqoDFVh6ZMcdVJPkRsX0YA5RfsnZ48ayhBpas4O5gso3amVx1I0R4VgfvUzJ17r6tNQ6McLt+PsV8HxN5WqUJZerqRMiBve2Ey8Sw3UUn/HVKQbo1xylHm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S00wv2lseA9XleGekVV/RmNTBFbFEnxGNyFbpxThubU=;
 b=uPO9cZoRWM+WvcXyeRq4+RZNJ4+T0MCUzHS7jfQ3ersEViJ9xuGmYPc0ybHwU42SQD5Cdy+2OSuA0g85kifgdgQ/378jzKCy40FAEvvoDEWgtmiQX0adYrvPKSruzPAW87c5lk0EuFDmh4i6gqWN4r/GJTFmmfAsSYwvI1TYlSMOWSV2ju6hRnjLzLjCgU3wZDGvkb30djj1JNrjtHyB9bsyID4/AhO1Tw4wbTvAw4+3TKYQYcYDxHuifgg007Q4PNw5UhkduCCXjZigyqFQ7elfH3k8Zry54C8ECcXZBw79weV7Ssjn2oVaa0P66TrnFutp4sKFrabEf4NNp11pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S00wv2lseA9XleGekVV/RmNTBFbFEnxGNyFbpxThubU=;
 b=QEnn3k+395kZH40raBFRZD9UBgzElz8uY/s3BXpWuZGt85l+xa41/Jg0gjN2c+0mRfQGqGPXAA2I08JMdtlEsKOXSbLvtikXgdyjgEDcYKRG6IZADnwygmDcyVbQ0VJ9O+U5CSuGW8dxbIrgD+CankASz57wM44IiHlfMc7Z2M3AbrNxMsdKARkxgg+lpw44usRHmgXZDTftP+zzzH/dWq+U9LhgF7MOal+aRLfs42Y+6L9TKJin1wiCByTv5kQivyot5CDipuShUst7wnqQ59EB9mp5Fwe9N9akITV+EB3L5IVrfcBolsUQNt1xSb7PZrC0zyIqJCzRIcOD2oy2ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 21:42:00 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 21:41:59 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Laight <david.laight.linux@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Ben Collins <bcollins@watter.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Date: Mon, 27 Apr 2026 17:41:24 -0400
Message-ID: <20260427214127.406067-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427214127.406067-1-ynorov@nvidia.com>
References: <20260427214127.406067-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:408:fe::26) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 5976cd16-0353-4024-bf71-08dea4a5cfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AdWjq4zC3uD+CLU0s6C9DA7Fqi5VNLPQZcP1wL6NY+jIGkSUk2f72/P+gE2rWVyLa5WtWgeex09nr+9wpR5V3erannQ3dKycsU3mz5RonzB4d1qAqBeyZMuXNyVZFI0KO1fgkacG3KjUOqzccLwhP7qYvxHbxyOHf2dAjlJMx65q/LWBaxp5vHVhJkPSgvZU8Hfina1NqNC+6uce/7b5al2GtkQ2cevZmPK94w9Cz9tM6k2114PZ6BbQAhlXMiFa0U0XUwqe7DmnzN7JnmcCYpAlql46trXnrPpZWpWnOk4jcmFKoljzG0mSsTiyzoPV9YKSP77Yk8yDd82EkuLuoBBCubu+0EpJ0ZcXCGbfMrZn/IZVoqT4BjC7X8rp7URA5BmfwnE4Z8BFfiK4y0F4DoBy4CNh4SP2p+bNE6swLfgReYCvxQxtJlF2WWi98rPVcZQHlWA/CJshd4JFMI9gsOyT0/2bqHcpAITSJ0iJZsXTisaFnPDf5gS3pSM/LQ4Iit/zkBwqAE5zYyzjXIRrFX5uIZh66BbHAW1M9wEKJJsM8kFxmAWsnfukyFod0LUu/hbLlpFwlIn78ZT2x0eVPC8sKp+wM0BsJkWAzhaO7TIyhoXH7Zd6pq2B5kNXz6kBGhjCQBTcH7FjENiF3HC3Bkr0SSDo/DjJcYaFSYphT/lVoC6ZLsPD7mhBdvhNZcu5lPmx2b03Wo0x7ceCUsMVXbM2JW/RlYXrgmFz3ZUn1fKegPlIFzxEdVCwLWbDmmzq1rqgeTMeerHfIZtIzW7vlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tMnzDyUzuUSOTrZ8Mb7wUVHVjOfd3jYGj7iSznZBnwsgL4Gf5UOLTTYvZX8U?=
 =?us-ascii?Q?iGEAZhgJs1Gk8mcdCqnooTv7cCiWfbjQSK4ikZDg64a1FtUtRdegcSkbhnQr?=
 =?us-ascii?Q?8DWABL9WUTCJJejH2GklF7Hwz1mE3hHmqYKpmYTi4vVGhniJOBh/Gdr5vXly?=
 =?us-ascii?Q?VQmXaw4rJ4WE2GMRpdWd12VtUesSstshuNRxPoX3HpKUJ9QNNGhGNm+64mKq?=
 =?us-ascii?Q?ggDsAypIf+zGjekvgix5AqTZuGuNmnQkDYNpyl3rw/MHodBizAGOuM84puOu?=
 =?us-ascii?Q?KIVAVX6ipTjicgKNl3UOpEXhAR266Tsan/+dOLBny/dfoPWM23mscM+3o9Nr?=
 =?us-ascii?Q?d31s1v3d6bC0ec6bXkrM+BvfyOgN2avbR4nCGsLXCnlKCNwrJMsgTYfmY4pQ?=
 =?us-ascii?Q?GS6+EtLHB6rKh2Gk2l64rgMaBtFSqJZBOtIYHdilfCLsQfQ8kB4dm4lqvsZD?=
 =?us-ascii?Q?qedXAPOTyk1H4sCRl6NzfYWepCpz6mzEmxcDPt4dxLYRIzcFabzOGQa6K1AC?=
 =?us-ascii?Q?OKE/SZJWqtKY+o0qWVPGwMbLMbBxxlF3eV7wcqh6krSZZZskPN0c/cEOMDUP?=
 =?us-ascii?Q?Dt01bZ5jBy1Fco6iphp5vYu+fgIDgz0xZgaNEuXToEKpb7FgL44P87186yE0?=
 =?us-ascii?Q?WyZu+R5JqZvpJQavSaRIrub7snFhIQtwDfxzFcANL+XcfJOkaN2DkYwMVRjI?=
 =?us-ascii?Q?WNX9nAWBXVUgcq6PJOiNiO77SE+2a29H8EjsbtvqANGBX63EZYBDUrWD6qJT?=
 =?us-ascii?Q?+elnJKGRtBajRIIBteKa9BEN3kf4fvj4yj0YCM6YYzSQwCgLZVTFf7UvNnnc?=
 =?us-ascii?Q?99D992uUYH6hMJ5BqR2eapfxtNJz3FMoOnpgclsYLTsp/rlLuLbQZ+1dsQSx?=
 =?us-ascii?Q?j4Csz56SSVybyT5IjTjZcgdJ+jRM0H6BnuqNzRXKA/kwlOa72HQkvjPQyZZ4?=
 =?us-ascii?Q?ulDi03E08krlPis9lByZUhoSWw4PJnq7ax0UmQk3EgTVgyynGrPC1xNlg//r?=
 =?us-ascii?Q?WXX3Bk9hcfpHQx+ren5KOwKRrcbVbHb2CBHxVDU3MuAPuEpRrnBks3RyIlre?=
 =?us-ascii?Q?Bx8BsUpqnqxAVbZauzGEiFQ87Ov9k5iWMtvMXO12oG/AVGqXKq+WMy3Hl1SM?=
 =?us-ascii?Q?0M1JW4347nnb0CehFSC7omvjKu0vASVzxnwzzCz5FnvFJkLBEVdHQaOJezw9?=
 =?us-ascii?Q?7bNELqogxIMFq55sGWdgSSo5PzCzzE3Rp7NcAjEC2Z49AdRbRiH/VfOUB5/w?=
 =?us-ascii?Q?0TkXD8czM6seeG2e76zwIpCuObofNKGAJchIAlHqoeiDkcWuAqVP8wPj9jop?=
 =?us-ascii?Q?TZDvM8wHKpLyYEJ1up/9l8Ghu4NNh5svcTQxWIUcb90GvgDMG/P9MirT30UQ?=
 =?us-ascii?Q?XQkB332PmKAeHHaWo/QjrIOotUGdijONzS/GeLGCutl2YgpKAkQ0jXkX+2ny?=
 =?us-ascii?Q?B1Frhsn0Tr/Ny5k/gAGPJTTSMLPajeP3unJ/Cje2+0PBG0tlijPYVH9GKHvx?=
 =?us-ascii?Q?rxjozDBiQfXtoFQUzVHIPesy3AlT0UzXUeVk8+6yh0HSSPuECuZv6PNG2KKS?=
 =?us-ascii?Q?Iu7BbewHbYaw8e1t8dpKJUA048bN5KSUxiDDtVGmzIi+QCSmbc2MAbvc6izo?=
 =?us-ascii?Q?+D/LOkdb9+Gi5vjJCaaUYHXTPoumRwO1g9sfA/dctQ6SnwSO7sOHmtp9tHaJ?=
 =?us-ascii?Q?XW2NJEYas8nMnfQH+QjOTJ/gQeWN3grygPVJSiaJx8BW7HvPP+yueaq4dXfC?=
 =?us-ascii?Q?oeh9QByINA8Z8f69VR9GUuAZwMkqJByAXQMEt/WSs9KcxOY2o0G5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5976cd16-0353-4024-bf71-08dea4a5cfce
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 21:41:59.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Via0rZI41zyW+UkwUJj0VY8ECtQX07Mqfe2vkjb93C+oPj33QMcIZvwbTlScT+Ka8yLAh7Rua/HuEQ/pfCQdJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
X-Rspamd-Queue-Id: E198547ACCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35420-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,sipsolutions.net,gmail.com,analog.com,realtek.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]

Switch from sign_extend32(FIELD_GET()) to the dedicated
FIELD_GET_SIGNED() and don't calculate the fields length explicitly.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c    | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c    | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c        | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 463399413318..8679b21fd3fd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -334,8 +334,8 @@ static void _check_addc(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 
 	for (i = 0; i < ADDC_T_AVG; i++) {
 		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
-		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
-		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
+		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
+		dc_im += FIELD_GET_SIGNED(0xfff, tmp);
 	}
 
 	dc_re /= ADDC_T_AVG;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 65b839323e3e..df5fbae50ff5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -206,9 +206,9 @@ static void rtw8852bx_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
 {
 	if (high)
-		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
+		*high = FIELD_GET_SIGNED(GENMASK(7,  4), data);
 	if (low)
-		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
+		*low = FIELD_GET_SIGNED(GENMASK(3,  0), data);
 
 	return data != 0xff;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 70b1515c00fa..8db6ea475128 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -497,8 +497,8 @@ static void _check_addc(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 
 	for (i = 0; i < ADDC_T_AVG; i++) {
 		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
-		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
-		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
+		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
+		dc_im += FIELD_GET_SIGNED(0xfff, tmp);
 	}
 
 	dc_re /= ADDC_T_AVG;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 40db7e3c0d97..32eecd184b7c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -517,9 +517,9 @@ static void rtw8852c_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
 {
 	if (high)
-		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
+		*high = FIELD_GET_SIGNED(GENMASK(7, 4), data);
 	if (low)
-		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
+		*low = FIELD_GET_SIGNED(GENMASK(3, 0), data);
 
 	return data != 0xff;
 }
-- 
2.51.0


