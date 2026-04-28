Return-Path: <linux-wireless+bounces-35514-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA0pFXsN8Wn1cAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35514-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:41:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82C48B3DA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B523045276
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023C3815C6;
	Tue, 28 Apr 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TCWchB7G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4EF379EF5;
	Tue, 28 Apr 2026 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405287; cv=fail; b=XkiznNgXZs9UPIruraPiHg08ZPzL598tUfo/2FTfaVKovMeDeMsDN+F3LNJ9kMxhDhYa4aX6LfeA9mkg+UcvhL/o4h6WXAewSZ8grgmSc8ufmv6BTS2CsqOYtcIipWTernsKpMLp2IPeldZr/UXBvOZk6JZRLNzPnlGIdOe4q5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405287; c=relaxed/simple;
	bh=JC64flI7qDW7jh7SiI612dsVxoAlVJjN+h2ME9oILsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1pbCajyskZNi/6Z/2pfrsH6n43FvPXc9PlrizIOVYVnW+ZzB8LHhAKU76qLySfSQV8GwuB0vRDSZcmzmT2X5okJN68mGlGKuks5UMLcNDEsn/yDyLImovSGSUaFHuwVynZHipUOxQUPoEj827x4ba6jClQ44bzlwIhjpUJKeEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TCWchB7G; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7IucPavFDZcd11d2Pet7oCD85eRCHMGr2Th/BTfZ1An3yMtv1mdqio/PM82MstCUOlkiIg5FA/lVJV2Yu0WofTnmQgwpZmwAFM5skmLRexVaFz9DAb3RNGkh103ANCcqrp7YA5iUUseRojsy1Ape+vuntawIJuOjrji29wRrRpIdeScEFIuN0BQrvcPlUlyNo3xgrErDM9P0hDCKBy7iZrJnY1fjuEH3L/SItppi+BXRTPAuWpnW3JdF7aaesrJ6NGefW4m9XQK/DWD//+Iu1KH8hRj5d/RO8FEbhIuCoDHkM2C0urEszlCybub5xXK99ccE1YG61y6hAtnovyMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x5FfiwCi1kW4TE1OgRWTQT9YYRwtzaJgkf+T7twPEQ=;
 b=DJozJW/yzzaz70CCwtKSiN6lbMsAXULbasC8L/0JTgCJPKer5YX6/2b68by7b0rzQac9AMgg4yDMuG7hA9ZwfXTQ9LpgEIFOrMBCOeJRQSq+9A5i2nigCFpFCPIHHgrj3NAM7AT4Xk0S6+yGGMQwvZn4Er//8BAIScx9R+v5prb6i5xlotMmTQrqes+o/um5fQk2emUa+F70DXE7PfZYag4XV7OPp1qonpIUTnf8UK3RMJeWxi+3qmFBeO9SdLx3n7s38Z9kOIhRNGMM+ZNXitscwvcP7A6z2dAJA7bBdSerWAAyw//v+fjt1C1mCQezLUJWVHL+X9nxPyfLtwtT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x5FfiwCi1kW4TE1OgRWTQT9YYRwtzaJgkf+T7twPEQ=;
 b=TCWchB7GGlhqp/qZUayiEqRPYXLMzpWXZcHbdbDlUzYfdIhLdSOrb8zhymGS8J+GbyYa2nT9Q46fqbS22kqH6TRGsJ46MdyWzwjzrWMcvVEXnqkE/wsa6Jx3f8s1xnuyoM7lSO6+gSxrMq8+PLSJgwrX5YJzCfyZJ0KQS4/mmKDg9FCOMkNep7TLaQxid/EpCNmMAbKRTmXvNgjDKBrCYdifYzeceVEhOPGAWIfOvdbvUxHpi0mYKalx63YTfEmtr7RtrycmMP0WA9x462URBEAFdJCWWc6swJfy7twrWoo9xLMw1tvbrrjZJVSo9OkhJxP4eG5LkvYpz74D6MsGrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS5PR04MB11371.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 19:41:23 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:41:23 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 01/22] mmc: core: add NXP IW61x base ID and block size quirk
Date: Wed, 29 Apr 2026 03:40:00 +0800
Message-Id: <20260428194021.785252-2-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428194021.785252-1-jeff.chen_1@nxp.com>
References: <20260428194021.785252-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: b2df7f45-672f-42a5-3b6a-08dea55e2102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	l6y0MnrLFtZwnVDq+vEv1uMAxb7UkfhioSkl1Og9uIZ7X8xGmvDgE82/7vLriBmD7vnz4Yi6YoxN6PCUMZ/6xebnu0WYhzr2iQv/zyoDZZqvjAT6bz+LmEIef/AmVmX3uDeDQ1az+rMYGslxixt9selnNn1fWCzHl0slBOK4QiZPVAHoPQ7NvXP6RhuGAlLoG02xDk9ws6eCz9a42utSGw6/WYxVpeKo0e7Klr5gU2jtmuNks3z7DwYTOaU05l+bqEUZWbQ5/oQg8OhyAi1c3KOlzuEd4jSEfJhSJ/aMLedXHqJ6z9VzWVrIiYT0e1pDUw2cHjiVPUw1oHGZniU5+DWKTQLS8KT4k4x4MtfvHt9dikSvXXRBVCwuQbOijEXf3J0PLjig0HsgU6m79EdM8M3VlGEyDsAHfMIpCNTFgiMeItKftMPEkWUNsZ29OkR4qMXAUJOlWGg0F0GIsSGsmVGjcoRyJUFnoyt8CMZYRMHaCP2ATx0qbYpunBPF94373QtUCD3Og14E9SpyNIcXT0z89X0ZAMqx0oFCwnXfI3uj+RPORg5aovr0FbubHjeKgOyh0F6jpQNyqKb1yJmTuyBfb/KroMmaV806gkv/11ESozkQdiz+WNk69konVaks0jVmRPGHemzUMxftwKnbAXZPEICxwv9Q0GwMJZGrr00NfSQNQdX+3z7n0qiUC6HGou/ada0Alm1pnmWb3U2/pvARIuHF0502fH3L3DKoji9y+8YzQnQC+mPsPF0mwpkutUqWdWuq6feBXmILdwSQjJIhdTYPYFoTl6JIjGn6xS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bDYbacJTVfngS1DB5BXzVrmIn4AUIVN4ZkaUk5Mds6y//ib/gqLNGJ5ZvNQ?=
 =?us-ascii?Q?lRXatoNU9tFZNdQwYvyJs5xFr77uNnH2Ui958UHpyUQmJ3G2jRLCGg7OZAnd?=
 =?us-ascii?Q?tqZ7FR6hsFPMb5FfyCNt+tqoRIjOVcDcoF50Z19xDN9v9ymdHn9L4HQd5CHt?=
 =?us-ascii?Q?QJ8faXmYALIWZtT0cKcnqYAPiEtlSgiujAhmVSZYww0X4DoaSWIksgBhoDr4?=
 =?us-ascii?Q?0AqY4HbK7NJcIkjIxk9FJ5ILzSO0fIh4WCmrmxJB+UCZqtPhha4S92l8u/hI?=
 =?us-ascii?Q?e+jRHbIuAa6KObv55/KuTEdTVOk3ixvdHQUfSAm6pgrRRPg+XHs618TgJJDZ?=
 =?us-ascii?Q?hg/npTFvR3Kh+Ps+HVb82lHCm46zHiYQ67ZT9rNfUOqfo7NvXhWVb27clfYl?=
 =?us-ascii?Q?7aVxxxS/chy8/FSQKmF1MBaK6Ot4Z48qjN4xyT4ZuMZib89aHsgrUuwYRA/1?=
 =?us-ascii?Q?/P0jwdMrxfDdJLnLD8Z/1gvFutjYsWGQEkHnqktaDeB1VERwwRhXZHqepA4t?=
 =?us-ascii?Q?kkAfKxfHZVMEmM8iCzfuFDbstqGSZYSDgd6EwZ/IpHhQBrW/VoWjd3IdIc4d?=
 =?us-ascii?Q?vEan9i6gXbXS1fSaIKVcZ6683hz1GDhbefOikSBuSiZ680aRM7kxn7H/4m+5?=
 =?us-ascii?Q?mCu0ES+UCbPpkaED9PuCkZLX8x4xmrJl9UrgQC5CH4Qx5pJ54jCACJvSciEu?=
 =?us-ascii?Q?dJqMHoP0NUK3b5RZ5WLUpBmrVueMnTjWbfJx5LHgKao3wUa+sucp0DcG84vp?=
 =?us-ascii?Q?PD0OEiqaQaPxX9GfcfMFfOUSPfdZfsbdfAchG6qtjkk1OPXXQqW4sMaB3IhQ?=
 =?us-ascii?Q?d/ke8AZ+yMBR83IPGpuLeRcaYcdysqnd1/w7XWTdLIGubmpE+F32BH0Pa8HS?=
 =?us-ascii?Q?B1ZfspwPlWTtWdvGlluV5H4K6HgkQJzzJcn35GWCIUPDhUe9jwniFRvqFABL?=
 =?us-ascii?Q?y6zKeL5oCoGWDg/ddRzYqe+bNo4pqVJKc8ZWnmrtdaeSMFlUiKFILpBJmb78?=
 =?us-ascii?Q?25OGZOOY9Du60oyszHK+Klg+FamDD1dmPuWUb+7wCusMkVXVKZdhUDCS7XwT?=
 =?us-ascii?Q?xUtG8m29xNzR+XWXa2HKKawY7//bkqKQ9WQexTpy0UgOkmE4LUj0cEdWv1eG?=
 =?us-ascii?Q?/XJrb7sh0uv2/EeFMiL8r1GaUUup7M/NL58eZs83lBqYDIjoL9k/Uzi45h86?=
 =?us-ascii?Q?euS+nVjwNNQ5cxggOJZ7GuF4/FLlWqNjmNol9UhJrYwmyGptqV/eF7blFWc4?=
 =?us-ascii?Q?2mgDoGIder0NEWDKfHluy8QD0D77bMUH4+FGceNJ8ur3Z4uhiQ4Ebtkib/Pb?=
 =?us-ascii?Q?1Dy1WSDXtxzY9PtM4nlXWVzkAERcoTcGCCf6CCHAM2eI404tbkDQE26jA5YA?=
 =?us-ascii?Q?V2IoX5zDtYnjZhnSPD8G92KgIFNfHJmEf+bRLFwwY2s28lEYwh42fE+Lu9rz?=
 =?us-ascii?Q?vNT2iuEzZoFBVya99ajFcv/3tu+kPg6RDlnMyGWpyOCSGZjJG9Rzl2AGGi6X?=
 =?us-ascii?Q?rquo/U4e0v55GgVhrv/Smct4PlsJI0JxH4A8g+2k4poG0cnB2HOpRgo78xv2?=
 =?us-ascii?Q?fnFsNq/PU5JwABco6vLV9EQ6sEoPMnwAMUbnHCag6pfVdXRQVDu5s9Aodr4f?=
 =?us-ascii?Q?tpV5kcz3gGVA4/RuMBCUcDB1mhL90rfvfjvG7/DSKvSR8ieyZmtuFTj5IJ2X?=
 =?us-ascii?Q?xKMaLg7uVozWsK7P2ZrRah1vGXn1ghg6h3c4O9RYkqbIYD326sI/+itzrgD9?=
 =?us-ascii?Q?xduEkpsrlg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2df7f45-672f-42a5-3b6a-08dea55e2102
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:41:23.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3JWSwPkAwN6vc4zD24jTSGTwjF9e68fvpOdhX1yxZ8gcwdye87vTBj/RAXU7zCVs038EgKuR1ySABuIIvPJZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11371
X-Rspamd-Queue-Id: EB82C48B3DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35514-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

The NXP IW61x series SDIO chipset identifies itself with a base card ID
(0x0204) during the initial MMC bus scan, while the specific WLAN
function reports a different ID (0x0205).

To ensure that the MMC_QUIRK_BLKSZ_FOR_BYTE_MODE quirk is correctly
inherited by all SDIO functions (including Wi-Fi), it must be attached
to the base card ID at the core level.

Add the SDIO_DEVICE_ID_NXP_IW61X_BASE definition and apply the required
fixup in the SDIO quirk table.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/mmc/core/quirks.h    | 3 +++
 include/linux/mmc/sdio_ids.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 940549d3b95d..ae3ece89d0aa 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -208,6 +208,9 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887_F0,
 		   add_limit_rate_quirk, 150000000),
 
+	SDIO_FIXUP(SDIO_VENDOR_ID_NXP, SDIO_DEVICE_ID_NXP_IW61X_BASE,
+		   add_quirk, MMC_QUIRK_BLKSZ_FOR_BYTE_MODE),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0685dd717e85..7dac5428afe0 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -118,6 +118,7 @@
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
 #define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X_BASE		0x0204
 #define SDIO_DEVICE_ID_NXP_IW61X		0x0205
 
 #define SDIO_VENDOR_ID_REALTEK			0x024c
-- 
2.34.1


