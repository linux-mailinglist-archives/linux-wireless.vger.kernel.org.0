Return-Path: <linux-wireless+bounces-26151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CAB1A69A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8876C3A2689
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3F27A908;
	Mon,  4 Aug 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OxvhfhbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBC27A139;
	Mon,  4 Aug 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322417; cv=fail; b=alsgdmKD0YTqW0zsijsehxOcq4bNZsHNgQTTcJFTh8NkYSpFNSOK69nLVOVWpL08OOSLY+4bXIapZaZPMd7kRwUMwdSMpgUd5B4yuVmYclmFkGrbsshFhtybUvttvj6230/2ghY7s1cEfXJ0unSo9bgT6V+V5Ivcsay84ZVvecc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322417; c=relaxed/simple;
	bh=LShs/VFzcKl3tNGMojKWvNRRaiSG6bjnbDtqYevjj6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9ZpJH1o4hCV30ya74UQZT9XxsDEKCiWA75UnbhZDPlBUK/EexokEhuS7CxNLHx0Dnry5aBOEkqpe8TW1fTN5yGzaDB8iaQbfKDHUoJdebUykK0zzkDe9MT6r9VFfn+MHYt9u6bu/gYGp7EOAdT5Ipf2OOaoeYheKvhuFgjvIZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OxvhfhbM; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZsn6OchEF9CGX4QGJ+waCvDsjT5FyiITajlTIFnIrfIw0pPhveKT+iw3Ukgpiq1njastZfTP8IX+HvwmdPdZJX6C0LZP1F39ArQincyx37TgCpVrXT2CkwR8i5S75mRQ82mYzd/e4WDmX2+X35icEbrIhFKEFJwO4Hl71Unn8Pfzz6yy55DSj1yBcpmvzDR31dHOW+zuMH13mFLx5BzBnCohKCuQDwyhWISVbe3wMwhmnbPoL90XpFnsYx4Fg+maFHDVJ4m8DlICbzkHwRRpjjTCBPPdyYnkuAj/JGG5bZgMHgcQf5VAnbDi/GZHpNR+PXOykXXs8KxoEHrur/BGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPOD0LYSwgSlny31QKnVE7wnJgqCHlzSufPzsDwzPio=;
 b=ZyyCY6xoN9QT/3wLSrLvd1rEJAKeuVLH6d5OCDFj+gkhl1uIUFKrcaGTdqO2WAy19Fe3vOab7uSzhE2pwLMr5xN1gEHkma6kLJHP0ifdNXKuWk6aarT9NIsHm5MTjU6BOPOOYdL9geLrjvt8qXau2vwGO1KaAsw4o/kCy4ys3tPhyX5EcY7wJqrj9K+oCHn45HPducuWM7lxn45JttRdkCIdmPmpMYiYPDk7cAlejo8MmnA8GVIW86Ka0yDpNpZNUp4TqM9xv8UxXLSKpTrb02lrl0GZsR+yDejtWPAyn6ZNDQSgBZpFUXDi9JV6Tr32z02Ed9Fiq5Uf/S0pbgmvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPOD0LYSwgSlny31QKnVE7wnJgqCHlzSufPzsDwzPio=;
 b=OxvhfhbM17KeP9+g+fhcvXDd/lsszezTG6UZEWY/EV5toajic9Zw7wOqbkoUwfV240B9VX7pgerFDtx5nAi/R5EHa6YKlZifp91186vlhDHHmT1l8wJwbEJTSCKklxyWryBZjsfdTgIHTXqsjJMD6rH10f4nJnVAlAb+KtUoHC456AK04VllJuEwSEXzjrLfxB9/fbgZV5zgFa4TQsxkU0EfHgnyBldaIa9POhrJGc+QvEyrx37geCxXJyDNcPV/twGPap+dadkQkGf7W+LIbUqBIdxgpIH0PkGHfD9El0VwR79/ceNT6N0EkE1axg32Jp5K4yCwdoxEKNE5E8n3VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB11432.eurprd04.prod.outlook.com (2603:10a6:102:4f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:46:46 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:46:46 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	brian.hsu@nxp.com,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v5 21/22] wifi: nxpwifi: add makefile and kconfig files
Date: Mon,  4 Aug 2025 23:40:17 +0800
Message-Id: <20250804154018.3563834-22-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB11432:EE_
X-MS-Office365-Filtering-Correlation-Id: 363209a2-5237-4826-8f3b-08ddd36e1e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSDXoLn2lEMyYemJdj1lk9sH3pARTuiG+2JntpnbyaL2I+NZf2/KYvI8p87I?=
 =?us-ascii?Q?O2cSnSClKmlc190D7xPTNPOPHQajCIS7jktKNVj4wK44dhBiwVbMZRDydNvr?=
 =?us-ascii?Q?JhYJByIPruB8/3u4EdJgMKDXJDAxnkSumNedKtMEv29Bf+vlPOBJ53WYAqor?=
 =?us-ascii?Q?Ic7X4PdYHLxgUOmHkv0rkaw7ZAGb+M1ihM5HwJ+AnmyVwWFAfPkq2DatFjli?=
 =?us-ascii?Q?22S11ohc78FFAgE44k/9N3Tp3IU+EX99cjw1Ebkjz2WTDkMoGewiTlE6wZoI?=
 =?us-ascii?Q?fEhFoi5sHT4hQ/5Zz4P7nuOFC93+hjNMRqh7+SizAj/aNByy6V9CU+JI3mwv?=
 =?us-ascii?Q?bmfepZjPLTCMtUe1jyOHcvYYd0+vVvGgf5OitHi/438j3IJVyZk6ecBh8LaD?=
 =?us-ascii?Q?FhDblKFvzOq4wRlKpoNREY0cX7lIlJN9TzXn5e/p/d+VXgauoiuGxdCZqTnB?=
 =?us-ascii?Q?Ibpcxcma/5CayPwF6XuJAP/aJAdgoQU5gn1+gBMBktBTBvAY3hIgjdaplV6t?=
 =?us-ascii?Q?/VDVykSEWkM6EPB2BSqnu2z13UpYTggfbUpLziy3L4CGHpM7Bo+ICA50K96B?=
 =?us-ascii?Q?bs+TvDq6n6apAJzIDL66eqqiwG+VkGo83sNx/hEkYBHgl9clkTX95y+NqMkL?=
 =?us-ascii?Q?tSPAQGJGj3SDVmHVnRvcPyHSqxn1yjozt85WScfeDqkSOTcS6xXXPJb2yGs3?=
 =?us-ascii?Q?mmwKe60ib0R++WXg4EJqW9oOczQ8mDTaFPu6/qRRxZnuBVqjva0zS6cPRhEP?=
 =?us-ascii?Q?LboX+AjEY2egyvEkg0Z26ysHLyqkWnCVYfARo+soDFte1N+q3kEpSz1w+wXD?=
 =?us-ascii?Q?mzoLKZuf61fTc0HYQgrOKcZoJJoZAvsgnfOV1/3PnWXMeIabMe/vZf9BeKJz?=
 =?us-ascii?Q?aSsBTY7naEOkTchsbE1+ZDD0iG+3PZ3877GgkOiUAyB8EwkpvaQflFvh8fhA?=
 =?us-ascii?Q?vCcWv/e71Bixlu7wvuXyfnGj0lRxnw3yoq583gxfqQBhLMQfpg8GT9yA1Euw?=
 =?us-ascii?Q?eXOt+Iq6iUZXP1BYog0HNOj4AHfM0FXw1HZFfRAZ0n/xiNwmX+7PyGHqDkNV?=
 =?us-ascii?Q?ZvUULSe2qd0CAW5DrIkZVSb+dqUwIe1rLU/DRA1gdFya9Sf6RlsspZDADhtr?=
 =?us-ascii?Q?W0d3oirXbO32KPzx0G3RCoBdLJt0AwzTwyM4/wGEA2UoSp6zw6KQpvqnoOoY?=
 =?us-ascii?Q?3M8TC4rUee8OkpdtKuByvGqG2OoE4gG6q8VhWso8o1GPkYSi2Y71cw2rf/jV?=
 =?us-ascii?Q?51eHjUcflEx/QLkzNOmfY3XsjsRxKfP9G1whzwr9RhjU+xSMzTbFFZHEM3b7?=
 =?us-ascii?Q?Fvjd0IrxRx2MN7+LKwrmKSN+006p7Oa/zwqyFbMQkEWKVXhZpGoUbyrvFwSE?=
 =?us-ascii?Q?str2m93dwEd83GxVC0jXKBwwwmYwzVbDIJznMvRclzLYKqjaOdzVJggeIkCI?=
 =?us-ascii?Q?ioQQDGMZ0Iubol+wyiwZlOicFhzeXMRraL17eL41e9pEG6nO2hnt6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjYn4wB8QBPD1OKJv/k9mlJRtcohO3k2MB+XenmboHxjFsM/LZ4fbB7LmqlO?=
 =?us-ascii?Q?czu+S/wTGauH+aO/vpKiGdaAA9txOp+dG78N4SfNQcDpSSUy5kuqCiY8KOcQ?=
 =?us-ascii?Q?YZS3RpRPg98/Kj0Q04ljsk4fnQHSoFawmtM/q34UD9lpGkMCLTEbuDBgaWfy?=
 =?us-ascii?Q?TEY8Ff+QMnfbXPuhxwYZhKrdx76H6ujvH0DRJXQqaXGqPi24cElYWxNjLObP?=
 =?us-ascii?Q?M38WyNkv8qajOE3m99cq9zH/8FqloLKGEna8vz/QrhB9RjfwZAQzGcAhDMPg?=
 =?us-ascii?Q?Pw/4+V6Mit5FLHGAcGRmk5x0SUVJCJUPRfHSjn1rH+HzFZGBE+AUqapU4dJj?=
 =?us-ascii?Q?An579TlTjaXXI48lADzSSUKbnmeUUaHH9njjw6xkbhzUU/LjWQzubFvZ2pR7?=
 =?us-ascii?Q?LS7wovSnptVvfK2imirkM5FYppCP03dzJ4V2Tj2DVrnSXIMDaDO0q+OFiCic?=
 =?us-ascii?Q?Fc+pbp15l0Lev+qnPMRHJWqdmWXeVAY1pO5KgpRSWyFsfaO13FHhOY9x+yUN?=
 =?us-ascii?Q?GhWjGXIbMobXlt6Cr3EGJxe9DgPFgs/5P6E8YoMv9kFkDKgm3xt7Htjz0cKw?=
 =?us-ascii?Q?I/i9V8SuM2M8kzQRZKdSG7kAjP5KX9ZODiiakBiZsB6YK6IVNXZ9Nzm7jZSn?=
 =?us-ascii?Q?uxwnNdvlLdnCVgsitklHlEmLKLSP7UUcpWp/LQ1xvAGreXxfj+gQkfAlC9Tg?=
 =?us-ascii?Q?pay7S5Gf91LGkTEdU9q2OHKbR+heik4A0jytDt80w28nQ+sK6z1N8u4QQHGZ?=
 =?us-ascii?Q?xCzEv5fz18PKpwtCcNNXJ3RDry49gbMSeB5gN1gpdWrWkA/iLQ0a9/Y21odz?=
 =?us-ascii?Q?mTngaIurhjwp3nhZli/2cyn04J5ij4B8M4B9rws8qk2ew9fme+da0yOSiTsx?=
 =?us-ascii?Q?ZmJFB4q3W9ebbSHYlj/J4ftaEBqW+ferifes4CidP6AR+hifTEvR9+1Pq2+V?=
 =?us-ascii?Q?ExZZ4SV4UxXji8LGrWONcoGAK4U7wYwQGPJmEAOFRzbIp7QJhvweYGTDLTz/?=
 =?us-ascii?Q?QANhPekhdJhYLndyzE9RL15ePweyEsQK8JTOlkf90ei/j5db15aYZFza9uZq?=
 =?us-ascii?Q?vFkH/PlH0dJqUoHlkimlzd48OQYnpjx5K7UD/nbpF56x6KI+t5y8y15UKsnn?=
 =?us-ascii?Q?B8VYI8WMS8pvQ++QdRTQfldwd7uogZZDXna5L9iM1NQlct6vpLdqj/0Fy1wv?=
 =?us-ascii?Q?gr+2/L5YiBy8VV04YFArnNXm56crvcVoO2SYnL5w6hjdUnB5HDXfz/SGBds+?=
 =?us-ascii?Q?lVLNeM13lY7ktWcYcNfHKcHrwXP7jVs7yQbTf8GxvJAXsbBa4+qCeOUbZI7f?=
 =?us-ascii?Q?UuGa70v3mp7bTCj4h4r9G+vWWI3dkxF6l0UvnjcO+2759fJl8gBuRFkbDTTk?=
 =?us-ascii?Q?gNdiAkvm95/QJ8qpArlADizZNv8zaxiscFuk3Pb/l+jiIKUgBu9/Uk+touFn?=
 =?us-ascii?Q?xmR0sOdUJst3WKa8kjnM8GnZQqOVS5Arjyp4FziV6lm7zgEfvSlKDhXkDZaY?=
 =?us-ascii?Q?BY6Wb0yZudTpfpOP4X7btKks2YLYiVp40Gbs9ed/1ta1BG1S6ZFNe/mG2+15?=
 =?us-ascii?Q?GyWuhPLDxhzTJQuT2/qPgEDIQVs9Bso7fYkdoUV3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363209a2-5237-4826-8f3b-08ddd36e1e70
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:46:46.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nQJ3jeEzB/DA5acuYtLS9oozR+O6dpQ3f+2H6ih59eJN4LZimT0JT92rxau2NA0w2vK4q3S5AXH2OVPfe5JCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11432

Let nxpwifi can be configured and compiled under
kernel source tree.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 39 +++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..4d7b81182925 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nxp/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..0c6b3cc719db 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NXP) += nxp/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nxp/Kconfig b/drivers/net/wireless/nxp/Kconfig
new file mode 100644
index 000000000000..68b32d4536e5
--- /dev/null
+++ b/drivers/net/wireless/nxp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_NXP
+	bool "NXP devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NXP
+
+source "drivers/net/wireless/nxp/nxpwifi/Kconfig"
+
+endif # WLAN_VENDOR_NXP
diff --git a/drivers/net/wireless/nxp/Makefile b/drivers/net/wireless/nxp/Makefile
new file mode 100644
index 000000000000..27b41a0afdd2
--- /dev/null
+++ b/drivers/net/wireless/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NXPWIFI)	+= nxpwifi/
diff --git a/drivers/net/wireless/nxp/nxpwifi/Kconfig b/drivers/net/wireless/nxp/nxpwifi/Kconfig
new file mode 100644
index 000000000000..3637068574b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NXPWIFI
+	tristate "NXP WiFi Driver"
+	depends on CFG80211
+	help
+	  This adds support for wireless adapters based on NXP
+	  802.11n/ac chipsets.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi.
+
+config NXPWIFI_SDIO
+	tristate "NXP WiFi Driver for IW61x"
+	depends on NXPWIFI && MMC
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  This adds support for wireless adapters based on NXP
+	  IW61x interface.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi_sdio.
diff --git a/drivers/net/wireless/nxp/nxpwifi/Makefile b/drivers/net/wireless/nxp/nxpwifi/Makefile
new file mode 100644
index 000000000000..8f581429f28d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2011-2020 NXP
+#
+
+
+nxpwifi-y += main.o
+nxpwifi-y += init.o
+nxpwifi-y += cfp.o
+nxpwifi-y += cmdevt.o
+nxpwifi-y += util.o
+nxpwifi-y += txrx.o
+nxpwifi-y += wmm.o
+nxpwifi-y += 11n.o
+nxpwifi-y += 11ac.o
+nxpwifi-y += 11ax.o
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_cfg.o
+nxpwifi-y += sta_cmd.o
+nxpwifi-y += uap_cmd.o
+nxpwifi-y += ie.o
+nxpwifi-y += sta_event.o
+nxpwifi-y += uap_event.o
+nxpwifi-y += sta_tx.o
+nxpwifi-y += sta_rx.o
+nxpwifi-y += uap_txrx.o
+nxpwifi-y += cfg80211.o
+nxpwifi-y += ethtool.o
+nxpwifi-y += 11h.o
+nxpwifi-$(CONFIG_DEBUG_FS) += debugfs.o
+obj-$(CONFIG_NXPWIFI) += nxpwifi.o
+
+nxpwifi_sdio-y += sdio.o
+obj-$(CONFIG_NXPWIFI_SDIO) += nxpwifi_sdio.o
+
+ccflags-y += -D__CHECK_ENDIAN
-- 
2.34.1


