Return-Path: <linux-wireless+bounces-37443-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FihFKWf5ImrkfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37443-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:29:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3708649C66
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:29:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=g3t+J04u;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37443-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37443-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43351314515C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41FA40BCB6;
	Fri,  5 Jun 2026 16:15:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEC40863D;
	Fri,  5 Jun 2026 16:15:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676104; cv=fail; b=TN19BDSYSB9oIQwFlsLx01zUUocIw/sxa2dBr7nrjhtczHXEJcVO5EavS5DJ5eDtvRWHSBHm9pDgZOWfqs/ekE2sYFOUeY6AsSG8hPIxXYi33cdBm16b95HMFy1Rb0ybRjEZRq2EucIA3P6HwEuqpVuqE/j1JL2yELakjYEDX9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676104; c=relaxed/simple;
	bh=JC64flI7qDW7jh7SiI612dsVxoAlVJjN+h2ME9oILsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOgBCg17WPVeBk9YBIrsW1gNBeawmYZ/n4iY54AOC3W+FQA6CRlPqf4xCZm7njXVH32zXydRZLajyQFAFaSypIasR0uQy4w60+fTaEgBX4c1E4hI/q2Eczcx/eMTLwAJsgN3A5s24wMZmHVJRuPYVA4Su2NleYgyLV5uRtO/vCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g3t+J04u; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8K5i5Z2NGGh8NGsEhdOkgSg6wopKoFjkMPZ3TTvJQUeRnM6z+idmssZM1pzrREI8ISo3fRsYLjJ1VWW61pv4vHQqqA8IQNoqnYFllPwVqr3slwtsHyG8UfkQUjoaHoutIOr1RsNjVIyj5Dt6C0cUe475VN4UwsIODOuWqShKry8bSiJvlwDxHYpY9UTIhlh0NTtzDDHtMlP9+3PPGDoAzM4jDv/YfOi98zxEaDdn9Tv6cL8fn6gnCxeS0FSKhdTDXVpceQyBdY6Eh/V0qG3zn166OiMhGIePJ6zFW71xiUlF1taEAmTR1XutVSxglJpfne+h1HE4KQEWy9a/1H1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x5FfiwCi1kW4TE1OgRWTQT9YYRwtzaJgkf+T7twPEQ=;
 b=DM5k0alhAlvAbkyi6SZnkhWICrkzMN4bIdmhpgnhaM1Qn+HQ2pub4o0U1ePA9TbgScqt6KVPScLkRQDpBDwyCTBP7Ev9owB5vNMixpKPeLU0Hlmq2mhjx2FCf/9V88Seu7gkNUf8H8BXB69ihgZXYxoBfkPFa+kY98ZDnwlJ9R2KAubslUdXu1bM2uoTluEiSHz/KZeWydnnfNIEOJWAsSa2mZ2V55Jx/3b0U4rc8k8Kx2WxajzQ0abXy1ADItOaoW1KHmEiuFRK1ekhPJG7XoTecGV3dNXs2L+ULBstWDFE9MSD74ozpkaNr+aF38sjvqP3E7ECGeKeryFKVys4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x5FfiwCi1kW4TE1OgRWTQT9YYRwtzaJgkf+T7twPEQ=;
 b=g3t+J04uamzzLm3ZrGYsSk7jYHmsshn0cdkGQN7u0vOiHByzH5TpbUlRlbd/MOIidwlPKnc9NORyP+ovEo5mmInF5G16RmMfanh6s+jLCHiPrxRGXR9EkHNb8Ui/Q/dRJ140+HzktkRaDRwywnxoUE86NJVjahvFgl+05s9hJzoI5hH1x2b4xeYlOsLGmDb0WNWREqMQFBFFD9sZghKvObjIqE9zLRauv+dvqKxUtL7NRHq2SpE/lKTEyGcm0fSMvwyXVmCpNwN7EU8nGEX2ZlSuhz3VXG2slcBP46LkO2hHkAPIYli4Jmu/Nkrbe2A2p4RBlKkohhVm3dn+nx4nCA==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by DU0PR04MB9225.eurprd04.prod.outlook.com (2603:10a6:10:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:14:51 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:14:51 +0000
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
Subject: [PATCH v12 22/22] mmc: core: add NXP IW61x base ID and block size quirk
Date: Sat,  6 Jun 2026 00:13:35 +0800
Message-Id: <20260605161335.2415583-23-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|DU0PR04MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: fad7885e-5218-481b-d93b-08dec31d9274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZFtdChOu0DotUwWKWys5ZAeWte6+UPTZ6HZrNuA+bw4QZpiSRIJ3cO9CMtxvcS0l7eVf39tnP9YlmfpHxbrZ8Mwm5VTrliQySq8S/RIz8ULB0OtZ+hLjER2c4CCSJBGbJ8aQYsSX7p4dwER0yLOWbMX2XY35Wn/o1eS4efP/HKNReJgn/f1ZBOz6+LU4hkJhXmUMOLAeYK8pOONnIkVm1m/F9ZW+878uQP869gz+ln16C/4gOqWnBQD5ELJfjxrMGGEAD8rJ0gFvZTTqrACAL0alecpwvAWSYJNvICkseTk1QSm/FCSpP5dAtoL600gGSCFStDPI9iE1aGzk4LAe4JHJGzKZpsO4yNm3LT5nJSw2f4ZDc52190vOrHNHDJcBJ7eK5xGGl7O5uCxlsoLSZNUhwsgXX4Hk20rjuKaA3h5vP5ISFkxwjwy8jNwtxvdFi7E8hKkPSGMXMYlRotFFO+ajDroip6tqDaFl9RgwGDMO6UuspEFIv4Sa4hjFVIVVBQOXc/mQq/Cmg6Q06CGrjVwpph6f870WxoEGK1H6h+L4HQ5adFP6WHIXND8tx8p31vfeyEZoxy+y+vvT800v00JPaoRm/6jvKXUqKqXx+D9DWtc8RUwbFBQwEw5G6dOiReohemt0O5AH9A6OvT6r7/qJ5fapE6HtL3EDtPI4RCfFGuLF4WVrYto5Bt/lvS5SVs+JNu4NKpbKNKesyTXc6OtbUGA3a39EADIwFEs8TkypwbszoStGhF1E8BzPz1E2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hu8tgI4n1VvPCXt9EdxVLjzCCfJZK6ENhxMvscVKU+s0HRqLGQL3HpjnOaEh?=
 =?us-ascii?Q?wFN9szk2Jlszsr4wOlVCb6IcCC0EnX+DerJjQyI8syLngcoqsoJvmRSoPKKM?=
 =?us-ascii?Q?KFGfL8eB63k53ss/QE1TdIAaoYk/W6myGzrBgDEYW4Mz7cM1AYEWwEP96uXE?=
 =?us-ascii?Q?v+4JDzDv6NBwBSyRaQTW+k3iYinl2J3CTqpUSciqBNxeg2rlwJne98Edclqt?=
 =?us-ascii?Q?Vr57Ow4oIhEVgpGg7eVdePoGfk4vu9q0A/qD5YJ/Xyh2ZaUx+g2TYy8ZIlQ4?=
 =?us-ascii?Q?z7SuYNVvQb4bpu24eIF/lhmT0vEOaJmtdRY2q/Ivv6Ovh6+CBw5cYxuPYllC?=
 =?us-ascii?Q?n1Nw5R4rcFpvGN2o8qnVrGLU0j1VThiBNCYRnRyHC/oeMf9XtviPGQ1GPY/7?=
 =?us-ascii?Q?rwWE6S5dLDefWztA+Q3YGes13G5EwsD8y9BOrgNDs6P6Fc2JmE3Gph+JB2cr?=
 =?us-ascii?Q?BiSeFCiYjGyjAzpm1x59hvUZKsSDZZvxJrJ+eyHftGKPzUj4IsuC7f0rT5RC?=
 =?us-ascii?Q?qipZyn+SMB1NzlBfaj01405Bf2Ms3iry8VLkkxsp3mORVb2BiPMGBQxy5hIq?=
 =?us-ascii?Q?hoWhjpL5FR3Ds8oAotfVrHQRXYDG62YGgCKm1vbHkSfEuh1PSsKjPrP7WgYT?=
 =?us-ascii?Q?CO097xKBhNqOC268iZgk43mbnM5Owt2MLIVGxmW9YVleSsMOuPNw8xUcPf0k?=
 =?us-ascii?Q?EUyiCH461DiAnQ8bZnyN+TNKColBBR0vKuOxcmUroym1ULUctfPWokOQaWIA?=
 =?us-ascii?Q?UI8MlHk/eNgZA5UGuBZ/HSpULhi/Jsbr8J7qv2DivpFwvGhy/MmtDWTOWrYU?=
 =?us-ascii?Q?wKNEBtl9dXyxNuBqsgHUHc7AnhqAQDJSoHts9QCSF19Al5/ye4pgbInZSNcF?=
 =?us-ascii?Q?PMIa9GRQjKqzqEw0CjeMzeqOkeMhfM+asc9kUgLSiCVoW44X2bayksL90/fN?=
 =?us-ascii?Q?jYMV3+H/82rTguuOQbdNTEkw9gqu8f/3m74JiP4ATfdnecTx96fkric8l/gX?=
 =?us-ascii?Q?NvfDpbZAfgzR5C1kKN/T0HOqmNNOZjF4m0BkiW7IuqEqQkjReRqssaxroDBM?=
 =?us-ascii?Q?7Ru9E6vhCUoaGj/gbDz5js6OFbrMtQwGcEfu82hk2tYXlf8dB6FA+w4fOn7N?=
 =?us-ascii?Q?xdsZ9LJXHH0mMjlGDY5La7eOSmOP+3ZLgVafOn88fUl+Y5ORH8rIBIUEiu+A?=
 =?us-ascii?Q?BQ/uTvpFWKVhnc3NnGyaeXJRlbdRlKwgAES4lPfY4nuXxUO3Cbl2GRLKZn9p?=
 =?us-ascii?Q?WsMX7wc6ifrIX15lvKmj96bLH/DFV5zB2ZZlAYOs91ogKiohiY1T6E5geMT6?=
 =?us-ascii?Q?RvILNCXlY5MAd3aAQxBKjJwjdHb0MokdUu5GPt8EBbPMuCb5ERSRtiNLE8oq?=
 =?us-ascii?Q?rdtRcSnRWxHwOfcj+ON6u7POSeEai005fY0/0t9EMYa/Ptz/r7M/4IgL8wd0?=
 =?us-ascii?Q?+DMWVcVyEwyoGUaydtf1ljbwkpsS8E5n8gT5pwt7o5QSFH3EXUYyc2oQye0b?=
 =?us-ascii?Q?ONgbWdTdxOD+ApVdkErKRnAqPfMNUdwDpAY5O8YUv3Ezd08yuoKrHhq6Ag48?=
 =?us-ascii?Q?8xSlOYGc6ib1DVyogb0SKdt3ANDh/gtMp1FLvI7wr7obHDIEAY8rz58p4nVb?=
 =?us-ascii?Q?FQVlx1cZRUZ7CzK7Dl4ZgOFUkSsGxyB/yOoqMNztGOvUgqZb8XUrkVlLu2Z4?=
 =?us-ascii?Q?g7kuNJW6mDfzhrGwasNgisNb/PsddxKvy2X+6LIcINJTSlkNYRoUKEhMpBNM?=
 =?us-ascii?Q?vJOJce+R5A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad7885e-5218-481b-d93b-08dec31d9274
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:14:51.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrMX7vpc9uSl79k2zo4xLHjCdtFn75jcNfANSLttYoDzhWNI3GnX3yRg5YS6EvZy/Zie+Vyty+cC8C4Mz3ajmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9225
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37443-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3708649C66

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


