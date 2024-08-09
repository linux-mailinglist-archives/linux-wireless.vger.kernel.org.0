Return-Path: <linux-wireless+bounces-11211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E490494CDCA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F5E1F21D18
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2CD19CCFB;
	Fri,  9 Aug 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fvL1mIBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70B19B3C4;
	Fri,  9 Aug 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196869; cv=fail; b=u9xd6Cwherb1m7p3QeWPNfROjyMrrPrDza+coz+P2Sx6OTTuL4gMJpuO31iCh7VwHSxOl2bdqmD3L2yE8FLY7zkbyIEXeFpig8Yu8ZZaaQR5GWWQjmp7EbInAfSkMHvcqlBE1Ko3PfU5Xru22G3hP+TmQRqZ1RmUg8e+DME1bDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196869; c=relaxed/simple;
	bh=mQMlMVVESn0FnuvfHDNqswYDdHOrIVEn+RNZKqsKAAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qoHu9moiGGA0c31E+JL622gXdckrvb27nq7wwbA6dCbXj08lqecfRKFL6PcmTZoTOemiCzkdqnoTgToxjNxb22lVM0qnbrpKncf/+VfOfgwK7M+70qud31HP7c57xm2fMnp+j5dLP3JNzGUysnq310LPqQgFQTawT0JcQsTY8Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fvL1mIBk; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxyXeEKyk4u/To6GEE6MTw0rsRYL460CsoNyQov4huNcwHg4YCcCrCG08ETxrrsTlrcNSMgs94FgtPbSHicW8P0kOxkZihV4D/INvrp5CDfPion/pbPhL6d/SeG/s36kceUXS3fkJEphSt/7PnXpq6Y2AY4p/q3bmP1+NY1HIlIJ57wKPFFwUEreWfcTZDshiHz/beBALT6w5fWDEyK+LDw/BcXT7jfflGWYj3piuhISmDF52merKb9u2sIDf9D43CSY56B84E/xCO7CYZ3hiQJMCG3R6JMAUW6Q540VKHtsEtJ+aOBXFt15+d0+t4VyJ1JCQq0ibJ0GBUBpfmIGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edEx4pIjp0el0wyJGuwFGwTxMJwWiWDH+qpmn5Srf3Q=;
 b=IRq4D8Gae/VB/ci8qISW++5oHqUJc37Hph/drBVy6QoTRVQPeG5jvet/Ae1EejkdO8fI3VW155O3+iKXAxuFspleW1+uvcCsc8G7YZmpwVOvR/CLL1rdLvraW3UrYOeihJZJTx8CftZxV4kzT0Z0oyqu7UwWXBcgGX3YuI5QmuoSi4vubVV2X06Do8FrO9+Y5vk12/YEU5BZJhQxLjmnTEz0EdFdPVVjx0TzI6eSGJrpX/SSLqE/8QBuf80xeqG78lrljMSNjfSYZsa4eXPd0rHizovFWrtOlfhoYRqC+lbsUS6/riBLPNhBvB1iS4s5atQ41ATQgdyh6Dc1cDYwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edEx4pIjp0el0wyJGuwFGwTxMJwWiWDH+qpmn5Srf3Q=;
 b=fvL1mIBkrwI3GQFu0d5vXNst8JL4+62rd0+wG0IG/4Wnl0MxRFpktg26mZhKtKtkorIgRfY9C2L90aPW/nJqM/DHybFn2s1g2JorAqmkM4pBDXDeO2fCCKvR3TulHvx8uyc0sV9/4W6Tsm6szofFtpWd3ZGcKEuPI+TcTbCSuldzt3CS7aSTg0wHnL17FLU/q25mVHSjfEoHqs+U7b1mtyzfl3jJz0svsFc77SLA75y/oS5bHkI3/jGleddYDyUboNRgcTshr2ecrul6ajnOwK5r8VPXN47/l/vkM2GvJeAEnGLI5mENKXCkAAiK1kZTdNeNZnTOt3g5WEGhpx/GsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:43 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:43 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 34/43] wifi: nxpwifi: add uap_cmd.c
Date: Fri,  9 Aug 2024 17:45:24 +0800
Message-Id: <20240809094533.1660-35-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GVXPR04MB9949:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e03b6d-baf4-438f-dbaa-08dcb85850d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CksC0cQPgOhv2s0HH2zaaeryw06F69T3dHdCtKBpte9yfKYYX+1gDuxkovb8?=
 =?us-ascii?Q?3PgFqQkeeS1sqNab0Ry7D6VuYPKjXAz2S/r7RUhVv1xJ3e1LFCsOPvWyEJ68?=
 =?us-ascii?Q?2qOqwg2VuQJ8yuBbDYZ+dFO6XN/ENxveTYq8g68z5QrgnIxwD1v8Q0Yqg7a4?=
 =?us-ascii?Q?qqZPTUMx9ByJ0aFlj9/+nJPSE8VyQzz1t5JnkNLPisjGWi3fB4OAkzS0EBv7?=
 =?us-ascii?Q?2q4yKCbJxKcl4QOvCIIAXbOjreBlSzwz9d5WH2YWToswqaSXLWwykT2DTKKO?=
 =?us-ascii?Q?NtSZVJHRDFUfzwQTA1XGQ3EYTIC4CTRkC2kIKZIi0Tge9J8eTc0Xo6kPVCfU?=
 =?us-ascii?Q?1V1RPbHDC5hFWQdbxpGes/CTRZjfnVobgsy4cvk7MseAlwXORbS2+x7ThAKe?=
 =?us-ascii?Q?bVaT2GiC7NUu+KNtHdgDocnIAe7IOSkgjRETIL6H5hgf6gRCT8oD1xZNmUDa?=
 =?us-ascii?Q?fRBPQkFuTJspb81LgFKQ/2t7q+30n7oj1SZoFRWXbCo4Dhd9vcAB+Nzcu58P?=
 =?us-ascii?Q?yVBaVbwIIFqtHFdkpAcfzT97ktYjJgpcdGv8BlRBTgVDGmD6An2zHHsqKQib?=
 =?us-ascii?Q?CZZv1z/GMGRI/Ix1KCO7CPt0S/PnWvUBro69QsBlsbLGR0OP5LyjKvgtCMPk?=
 =?us-ascii?Q?OHsYxsY9ogKag7jEqzrO3OgNChA8l2wjqAK5EIIk9nlaAC/R67MhnUlPTk08?=
 =?us-ascii?Q?2BwxsboHij/NAaFGDE7G2l/g9Fwpj2uHXJ6lQQ/yKnAeThypDuXv1ZB5xuz8?=
 =?us-ascii?Q?O2DmxcHuJiLmBr5SHep4ufYWv10yRWTukbBY3xi3Rw657alRUiws4kZrfvk9?=
 =?us-ascii?Q?L5xFUuCZsDnO/Wm0WgW+2rA4ZjxOTEt0j9gAmSZ+opfl/lprt7cpyrG3nNl0?=
 =?us-ascii?Q?HDrUb/ztpBXoDIiPuOSjJG6riS7dTEDxYYafQbxhUFHh3qI708ALtoQKRgs2?=
 =?us-ascii?Q?V83r32QgFaIc9zovgEI/xn8Y5byrCSguW5RQfv+xHBrvYwY3+pK5BWIWVeYc?=
 =?us-ascii?Q?UTG2/o3pwJf1Zqf6O0XC26UlMfU2A6a5Axk/3QPJ44aWfti1nNnqcI5QOVqL?=
 =?us-ascii?Q?mXGnBUl4QJRFGfPZLLtCQnNzWt5ZMbxzqpHE5xqdjIDDi33A655glKcGJ2GM?=
 =?us-ascii?Q?aqqoAV2QhBi2JDR9d8kEuTfpGohCxmPc9LVSx7j/cUHQY4CoT04KeL5Z4vzE?=
 =?us-ascii?Q?FQWxQbOfNv+R146NZ1ujcaCVfOYfETcIXhVx8R84B8cdPgseiCrqrvgocNlO?=
 =?us-ascii?Q?bPCTtMg8DS3I/ORTb8kTQyqW6vhDYkbZjRcxL4ZSCSidXaDIwaQ8r48/e2b5?=
 =?us-ascii?Q?/ZghoI4PV89dtLFu+3yCGFX4Hl0iRcMtbC7OF+lKwLUHYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zpr6oICATnLR9UyuaWM8lYVmSzbyNwHzltlnrYZGUlidZ2Ddpq/qvZNbCoJ6?=
 =?us-ascii?Q?FDf+3dPtu4MZQObvvhE6JJnBo+Qyq3xq6jUcwC2PEgNpUTIpWTKkSWik81iA?=
 =?us-ascii?Q?0B7Ieo60j16xDCKckTFE21TRGwImt5vvsTvtQuPiCh5VZIkrkhJIqKB550e3?=
 =?us-ascii?Q?7xS56Bojx0lUBm9YXf3AWSPjdFRK/OA/3X1sOuboyL68dyQVHhJ/knLUvmCk?=
 =?us-ascii?Q?e4rypAR3EsXrBLaA2Tcj3Vrs8m/8WVM/SyFhZnA4hvlAZmQ9WP2mjDBSDbXc?=
 =?us-ascii?Q?KZ7lsYMu8sRYslSVNOLvD31YZfLk/CI/fERm2Zo+eG4ns2Je9jxWIbJrucvn?=
 =?us-ascii?Q?b7qqOW5GoR3UB6oLU+IcBIupCISJ2S44cqXDnXy/iSwprZQPxeP5NYX/D/pW?=
 =?us-ascii?Q?u+61EWlnD8SjvUTkLPsh3tDoIrDOfnd01tCKRYj30uemebTLdrYeWLX7XfaK?=
 =?us-ascii?Q?wmryrRLAWUu9xJgXUXDUpAErj18O0hBFiVEjQbbS++gZ0c33UUcP9RgNqS/a?=
 =?us-ascii?Q?nM4ZiJfFk+FvXevXBuMfkncn1mQPnnPib13sFobRl0HnCsFcFiU68RQ4wGY+?=
 =?us-ascii?Q?NMkvVvNvTTEV4nh3130H1yi91fOUpUKfqRU4K7gfB7oHtgji4GTXvYLh+4/u?=
 =?us-ascii?Q?mwJgCpm/AgMgOuRoBOpc+t2rG4Ttt0ogJc+8o+3+cWAEl4MtOrc3phQc9YWX?=
 =?us-ascii?Q?0RcknR8+wXhVxNgWHwY+VtGt8+pSJkOLL4ZWy8w/cGEOc6Zb6J4mNfK5OuCe?=
 =?us-ascii?Q?grh6tfcme5Fw1jfis+d0Vul8dz4odv3FZbBFPVQJ9LEKjKocmb68UyrXmKTV?=
 =?us-ascii?Q?3oEV5gnlMkmuYHxOVyCWm5piTjEs4X77SDJRZRrcA8cNGrWI5UH6EeKwjqYs?=
 =?us-ascii?Q?sOwtiIF4r/O29PuUD82p9Y0egY17WdcVmYquTzFrDoWaOmsbIqStvqL4T9LO?=
 =?us-ascii?Q?3khSFCKE+UzN5qx4FLGMhRhVWmK/cZ05i6kipuGTGPIkvvnCoWiY2fwwZrbW?=
 =?us-ascii?Q?F2YnGm+9YCM36XxBMsbo5mCjWdPQbVEiXHvD54YzrLt4UVXNRp9apEse59Yo?=
 =?us-ascii?Q?yz6i9WReqJOBfYKI5CZlb+4mcVki+HO7X09deZwq/L2oOIDvcTaKQ0NZu0ih?=
 =?us-ascii?Q?fcH2gM2JXqZS0VHSOfqUnBhzbQVOWGPZ8JF49pMAPTOhz3vnbIEiIVhVqP7N?=
 =?us-ascii?Q?rhi98DTSiiT9dHEC8B6nR+TjjQY81F9kczv3IJh7doOBFyt5meD80W3YfocQ?=
 =?us-ascii?Q?19ks1r+Rj9IZdXGBm2AXEvZ37vm5zvVgA14pwta/B0fINj8s67d4/UM8rNSm?=
 =?us-ascii?Q?MXOOMVEpT7J0ayYD+Y5WAYq4X7xnvtrTClapQ903WaXKmrie9k26I2codWMU?=
 =?us-ascii?Q?33wktLrM+nEKnfhsH2rL1wsELvCrkD8g4O7rvAcqeobjbubh8wvzO0oKghpN?=
 =?us-ascii?Q?0bKYD2ZvhjLJvbSHt1gi6bqGMPw5bVYI2Z9V42t7HSKSrBTnyiZ4YOObG507?=
 =?us-ascii?Q?XYInL076FHvFH5w2x+oHLIXxUTKWuLt9TKQ6WA4pNefQ4lwJrxSwjQSYwg2q?=
 =?us-ascii?Q?nidAsDvyETn1sX47N7+RpUczR7q0/xZ42MbtB3OqFGW9i5STeOboAEpiQ1M6?=
 =?us-ascii?Q?i68KK6Taou5yTi9FnKnNOA54s/4XRsQDLjzpTuUApp9U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e03b6d-baf4-438f-dbaa-08dcb85850d5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:43.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PFmreIi2lu5WS9o7q+c0c/xATMKp1XFWaIC6kT1tm9Vebwl/bgVGLRoF2vFskbamSzl84wNhyqFYJxO8YJsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c | 1169 ++++++++++++++++++++
 1 file changed, 1169 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_cmd.c b/drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
new file mode 100644
index 000000000000..0b50f842c8f4
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
@@ -0,0 +1,1169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP specific command handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "11ac.h"
+#include "11n.h"
+
+/* This function parses BSS related parameters from structure
+ * and prepares TLVs specific to WPA/WPA2 security.
+ * These TLVs are appended to command buffer.
+ */
+static void
+nxpwifi_uap_bss_wpa(u8 **tlv_buf, void *cmd_buf, u16 *param_size)
+{
+	struct host_cmd_tlv_pwk_cipher *pwk_cipher;
+	struct host_cmd_tlv_gwk_cipher *gwk_cipher;
+	struct host_cmd_tlv_passphrase *passphrase;
+	struct host_cmd_tlv_akmp *tlv_akmp;
+	struct nxpwifi_uap_bss_param *bss_cfg = cmd_buf;
+	u16 cmd_size = *param_size;
+	u8 *tlv = *tlv_buf;
+
+	tlv_akmp = (struct host_cmd_tlv_akmp *)tlv;
+	tlv_akmp->header.type = cpu_to_le16(TLV_TYPE_UAP_AKMP);
+	tlv_akmp->header.len = cpu_to_le16(sizeof(struct host_cmd_tlv_akmp) -
+					sizeof(struct nxpwifi_ie_types_header));
+	tlv_akmp->key_mgmt_operation = cpu_to_le16(bss_cfg->key_mgmt_operation);
+	tlv_akmp->key_mgmt = cpu_to_le16(bss_cfg->key_mgmt);
+	cmd_size += sizeof(struct host_cmd_tlv_akmp);
+	tlv += sizeof(struct host_cmd_tlv_akmp);
+
+	if (bss_cfg->wpa_cfg.pairwise_cipher_wpa & VALID_CIPHER_BITMAP) {
+		pwk_cipher = (struct host_cmd_tlv_pwk_cipher *)tlv;
+		pwk_cipher->header.type = cpu_to_le16(TLV_TYPE_PWK_CIPHER);
+		pwk_cipher->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_pwk_cipher) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		pwk_cipher->proto = cpu_to_le16(PROTOCOL_WPA);
+		pwk_cipher->cipher = bss_cfg->wpa_cfg.pairwise_cipher_wpa;
+		cmd_size += sizeof(struct host_cmd_tlv_pwk_cipher);
+		tlv += sizeof(struct host_cmd_tlv_pwk_cipher);
+	}
+
+	if (bss_cfg->wpa_cfg.pairwise_cipher_wpa2 & VALID_CIPHER_BITMAP) {
+		pwk_cipher = (struct host_cmd_tlv_pwk_cipher *)tlv;
+		pwk_cipher->header.type = cpu_to_le16(TLV_TYPE_PWK_CIPHER);
+		pwk_cipher->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_pwk_cipher) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		pwk_cipher->proto = cpu_to_le16(PROTOCOL_WPA2);
+		pwk_cipher->cipher = bss_cfg->wpa_cfg.pairwise_cipher_wpa2;
+		cmd_size += sizeof(struct host_cmd_tlv_pwk_cipher);
+		tlv += sizeof(struct host_cmd_tlv_pwk_cipher);
+	}
+
+	if (bss_cfg->wpa_cfg.group_cipher & VALID_CIPHER_BITMAP) {
+		gwk_cipher = (struct host_cmd_tlv_gwk_cipher *)tlv;
+		gwk_cipher->header.type = cpu_to_le16(TLV_TYPE_GWK_CIPHER);
+		gwk_cipher->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_gwk_cipher) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		gwk_cipher->cipher = bss_cfg->wpa_cfg.group_cipher;
+		cmd_size += sizeof(struct host_cmd_tlv_gwk_cipher);
+		tlv += sizeof(struct host_cmd_tlv_gwk_cipher);
+	}
+
+	if (bss_cfg->wpa_cfg.length) {
+		passphrase = (struct host_cmd_tlv_passphrase *)tlv;
+		passphrase->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_WPA_PASSPHRASE);
+		passphrase->header.len = cpu_to_le16(bss_cfg->wpa_cfg.length);
+		memcpy(passphrase->passphrase, bss_cfg->wpa_cfg.passphrase,
+		       bss_cfg->wpa_cfg.length);
+		cmd_size += sizeof(struct nxpwifi_ie_types_header) +
+			    bss_cfg->wpa_cfg.length;
+		tlv += sizeof(struct nxpwifi_ie_types_header) +
+				bss_cfg->wpa_cfg.length;
+	}
+
+	*param_size = cmd_size;
+	*tlv_buf = tlv;
+}
+
+/* This function parses BSS related parameters from structure
+ * and prepares TLVs specific to WEP encryption.
+ * These TLVs are appended to command buffer.
+ */
+static void
+nxpwifi_uap_bss_wep(u8 **tlv_buf, void *cmd_buf, u16 *param_size)
+{
+	struct host_cmd_tlv_wep_key *wep_key;
+	u16 cmd_size = *param_size;
+	int i;
+	u8 *tlv = *tlv_buf;
+	struct nxpwifi_uap_bss_param *bss_cfg = cmd_buf;
+
+	for (i = 0; i < NUM_WEP_KEYS; i++) {
+		if (bss_cfg->wep_cfg[i].length &&
+		    (bss_cfg->wep_cfg[i].length == WLAN_KEY_LEN_WEP40 ||
+		     bss_cfg->wep_cfg[i].length == WLAN_KEY_LEN_WEP104)) {
+			wep_key = (struct host_cmd_tlv_wep_key *)tlv;
+			wep_key->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_WEP_KEY);
+			wep_key->header.len =
+				cpu_to_le16(bss_cfg->wep_cfg[i].length + 2);
+			wep_key->key_index = bss_cfg->wep_cfg[i].key_index;
+			wep_key->is_default = bss_cfg->wep_cfg[i].is_default;
+			memcpy(wep_key->key, bss_cfg->wep_cfg[i].key,
+			       bss_cfg->wep_cfg[i].length);
+			cmd_size += sizeof(struct nxpwifi_ie_types_header) + 2 +
+				    bss_cfg->wep_cfg[i].length;
+			tlv += sizeof(struct nxpwifi_ie_types_header) + 2 +
+				    bss_cfg->wep_cfg[i].length;
+		}
+	}
+
+	*param_size = cmd_size;
+	*tlv_buf = tlv;
+}
+
+/* This function parses BSS related parameters from structure
+ * and prepares TLVs. These TLVs are appended to command buffer.
+ */
+static int
+nxpwifi_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
+{
+	struct host_cmd_tlv_mac_addr *mac_tlv;
+	struct host_cmd_tlv_dtim_period *dtim_period;
+	struct host_cmd_tlv_beacon_period *beacon_period;
+	struct host_cmd_tlv_ssid *ssid;
+	struct host_cmd_tlv_bcast_ssid *bcast_ssid;
+	struct host_cmd_tlv_channel_band *chan_band;
+	struct host_cmd_tlv_frag_threshold *frag_threshold;
+	struct host_cmd_tlv_rts_threshold *rts_threshold;
+	struct host_cmd_tlv_retry_limit *retry_limit;
+	struct host_cmd_tlv_encrypt_protocol *encrypt_protocol;
+	struct host_cmd_tlv_auth_type *auth_type;
+	struct host_cmd_tlv_rates *tlv_rates;
+	struct host_cmd_tlv_ageout_timer *ao_timer, *ps_ao_timer;
+	struct host_cmd_tlv_power_constraint *pwr_ct;
+	struct nxpwifi_ie_types_htcap *htcap;
+	struct nxpwifi_ie_types_wmmcap *wmm_cap;
+	struct nxpwifi_uap_bss_param *bss_cfg = cmd_buf;
+	int i;
+	u16 cmd_size = *param_size;
+
+	mac_tlv = (struct host_cmd_tlv_mac_addr *)tlv;
+	mac_tlv->header.type = cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
+	mac_tlv->header.len = cpu_to_le16(ETH_ALEN);
+	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
+	cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
+	tlv += sizeof(struct host_cmd_tlv_mac_addr);
+
+	if (bss_cfg->ssid.ssid_len) {
+		ssid = (struct host_cmd_tlv_ssid *)tlv;
+		ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);
+		ssid->header.len = cpu_to_le16((u16)bss_cfg->ssid.ssid_len);
+		memcpy(ssid->ssid, bss_cfg->ssid.ssid, bss_cfg->ssid.ssid_len);
+		cmd_size += sizeof(struct nxpwifi_ie_types_header) +
+			    bss_cfg->ssid.ssid_len;
+		tlv += sizeof(struct nxpwifi_ie_types_header) +
+				bss_cfg->ssid.ssid_len;
+
+		bcast_ssid = (struct host_cmd_tlv_bcast_ssid *)tlv;
+		bcast_ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_BCAST_SSID);
+		bcast_ssid->header.len =
+				cpu_to_le16(sizeof(bcast_ssid->bcast_ctl));
+		bcast_ssid->bcast_ctl = bss_cfg->bcast_ssid_ctl;
+		cmd_size += sizeof(struct host_cmd_tlv_bcast_ssid);
+		tlv += sizeof(struct host_cmd_tlv_bcast_ssid);
+	}
+	if (bss_cfg->rates[0]) {
+		tlv_rates = (struct host_cmd_tlv_rates *)tlv;
+		tlv_rates->header.type = cpu_to_le16(TLV_TYPE_UAP_RATES);
+
+		for (i = 0; i < NXPWIFI_SUPPORTED_RATES && bss_cfg->rates[i];
+		     i++)
+			tlv_rates->rates[i] = bss_cfg->rates[i];
+
+		tlv_rates->header.len = cpu_to_le16(i);
+		cmd_size += sizeof(struct host_cmd_tlv_rates) + i;
+		tlv += sizeof(struct host_cmd_tlv_rates) + i;
+	}
+	if (bss_cfg->channel &&
+	    (((bss_cfg->band_cfg & BIT(0)) == BAND_CONFIG_BG &&
+	      bss_cfg->channel <= MAX_CHANNEL_BAND_BG) ||
+	    ((bss_cfg->band_cfg & BIT(0)) == BAND_CONFIG_A &&
+	     bss_cfg->channel <= MAX_CHANNEL_BAND_A))) {
+		chan_band = (struct host_cmd_tlv_channel_band *)tlv;
+		chan_band->header.type = cpu_to_le16(TLV_TYPE_CHANNELBANDLIST);
+		chan_band->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_channel_band) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		chan_band->band_config = bss_cfg->band_cfg;
+		chan_band->channel = bss_cfg->channel;
+		cmd_size += sizeof(struct host_cmd_tlv_channel_band);
+		tlv += sizeof(struct host_cmd_tlv_channel_band);
+	}
+	if (bss_cfg->beacon_period >= MIN_BEACON_PERIOD &&
+	    bss_cfg->beacon_period <= MAX_BEACON_PERIOD) {
+		beacon_period = (struct host_cmd_tlv_beacon_period *)tlv;
+		beacon_period->header.type =
+					cpu_to_le16(TLV_TYPE_UAP_BEACON_PERIOD);
+		beacon_period->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_beacon_period) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		beacon_period->period = cpu_to_le16(bss_cfg->beacon_period);
+		cmd_size += sizeof(struct host_cmd_tlv_beacon_period);
+		tlv += sizeof(struct host_cmd_tlv_beacon_period);
+	}
+	if (bss_cfg->dtim_period >= MIN_DTIM_PERIOD &&
+	    bss_cfg->dtim_period <= MAX_DTIM_PERIOD) {
+		dtim_period = (struct host_cmd_tlv_dtim_period *)tlv;
+		dtim_period->header.type =
+			cpu_to_le16(TLV_TYPE_UAP_DTIM_PERIOD);
+		dtim_period->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_dtim_period) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		dtim_period->period = bss_cfg->dtim_period;
+		cmd_size += sizeof(struct host_cmd_tlv_dtim_period);
+		tlv += sizeof(struct host_cmd_tlv_dtim_period);
+	}
+	if (bss_cfg->rts_threshold <= NXPWIFI_RTS_MAX_VALUE) {
+		rts_threshold = (struct host_cmd_tlv_rts_threshold *)tlv;
+		rts_threshold->header.type =
+					cpu_to_le16(TLV_TYPE_UAP_RTS_THRESHOLD);
+		rts_threshold->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_rts_threshold) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		rts_threshold->rts_thr = cpu_to_le16(bss_cfg->rts_threshold);
+		cmd_size += sizeof(struct host_cmd_tlv_frag_threshold);
+		tlv += sizeof(struct host_cmd_tlv_frag_threshold);
+	}
+	if (bss_cfg->frag_threshold >= NXPWIFI_FRAG_MIN_VALUE &&
+	    bss_cfg->frag_threshold <= NXPWIFI_FRAG_MAX_VALUE) {
+		frag_threshold = (struct host_cmd_tlv_frag_threshold *)tlv;
+		frag_threshold->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_FRAG_THRESHOLD);
+		frag_threshold->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_frag_threshold) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		frag_threshold->frag_thr = cpu_to_le16(bss_cfg->frag_threshold);
+		cmd_size += sizeof(struct host_cmd_tlv_frag_threshold);
+		tlv += sizeof(struct host_cmd_tlv_frag_threshold);
+	}
+	if (bss_cfg->retry_limit <= NXPWIFI_RETRY_LIMIT) {
+		retry_limit = (struct host_cmd_tlv_retry_limit *)tlv;
+		retry_limit->header.type =
+			cpu_to_le16(TLV_TYPE_UAP_RETRY_LIMIT);
+		retry_limit->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_retry_limit) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		retry_limit->limit = (u8)bss_cfg->retry_limit;
+		cmd_size += sizeof(struct host_cmd_tlv_retry_limit);
+		tlv += sizeof(struct host_cmd_tlv_retry_limit);
+	}
+	if ((bss_cfg->protocol & PROTOCOL_WPA) ||
+	    (bss_cfg->protocol & PROTOCOL_WPA2) ||
+	    (bss_cfg->protocol & PROTOCOL_EAP))
+		nxpwifi_uap_bss_wpa(&tlv, cmd_buf, &cmd_size);
+	else
+		nxpwifi_uap_bss_wep(&tlv, cmd_buf, &cmd_size);
+
+	if (bss_cfg->auth_mode <= WLAN_AUTH_SHARED_KEY ||
+	    bss_cfg->auth_mode == NXPWIFI_AUTH_MODE_AUTO) {
+		auth_type = (struct host_cmd_tlv_auth_type *)tlv;
+		auth_type->header.type = cpu_to_le16(TLV_TYPE_AUTH_TYPE);
+		auth_type->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_auth_type) -
+			sizeof(struct nxpwifi_ie_types_header));
+		auth_type->auth_type = (u8)bss_cfg->auth_mode;
+		auth_type->pwe_derivation = 0;
+		auth_type->transition_disable = 0;
+		cmd_size += sizeof(struct host_cmd_tlv_auth_type);
+		tlv += sizeof(struct host_cmd_tlv_auth_type);
+	}
+	if (bss_cfg->protocol) {
+		encrypt_protocol = (struct host_cmd_tlv_encrypt_protocol *)tlv;
+		encrypt_protocol->header.type =
+			cpu_to_le16(TLV_TYPE_UAP_ENCRY_PROTOCOL);
+		encrypt_protocol->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_encrypt_protocol)
+			- sizeof(struct nxpwifi_ie_types_header));
+		encrypt_protocol->proto = cpu_to_le16(bss_cfg->protocol);
+		cmd_size += sizeof(struct host_cmd_tlv_encrypt_protocol);
+		tlv += sizeof(struct host_cmd_tlv_encrypt_protocol);
+	}
+
+	if (bss_cfg->ht_cap.cap_info) {
+		htcap = (struct nxpwifi_ie_types_htcap *)tlv;
+		htcap->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		htcap->header.len =
+				cpu_to_le16(sizeof(struct ieee80211_ht_cap));
+		htcap->ht_cap.cap_info = bss_cfg->ht_cap.cap_info;
+		htcap->ht_cap.ampdu_params_info =
+					     bss_cfg->ht_cap.ampdu_params_info;
+		memcpy(&htcap->ht_cap.mcs, &bss_cfg->ht_cap.mcs,
+		       sizeof(struct ieee80211_mcs_info));
+		htcap->ht_cap.extended_ht_cap_info =
+					bss_cfg->ht_cap.extended_ht_cap_info;
+		htcap->ht_cap.tx_BF_cap_info = bss_cfg->ht_cap.tx_BF_cap_info;
+		htcap->ht_cap.antenna_selection_info =
+					bss_cfg->ht_cap.antenna_selection_info;
+		cmd_size += sizeof(struct nxpwifi_ie_types_htcap);
+		tlv += sizeof(struct nxpwifi_ie_types_htcap);
+	}
+
+	if (bss_cfg->wmm_info.qos_info != 0xFF) {
+		wmm_cap = (struct nxpwifi_ie_types_wmmcap *)tlv;
+		wmm_cap->header.type = cpu_to_le16(WLAN_EID_VENDOR_SPECIFIC);
+		wmm_cap->header.len = cpu_to_le16(sizeof(wmm_cap->wmm_info));
+		memcpy(&wmm_cap->wmm_info, &bss_cfg->wmm_info,
+		       sizeof(wmm_cap->wmm_info));
+		cmd_size += sizeof(struct nxpwifi_ie_types_wmmcap);
+		tlv += sizeof(struct nxpwifi_ie_types_wmmcap);
+	}
+
+	if (bss_cfg->sta_ao_timer) {
+		ao_timer = (struct host_cmd_tlv_ageout_timer *)tlv;
+		ao_timer->header.type = cpu_to_le16(TLV_TYPE_UAP_AO_TIMER);
+		ao_timer->header.len = cpu_to_le16(sizeof(*ao_timer) -
+					sizeof(struct nxpwifi_ie_types_header));
+		ao_timer->sta_ao_timer = cpu_to_le32(bss_cfg->sta_ao_timer);
+		cmd_size += sizeof(*ao_timer);
+		tlv += sizeof(*ao_timer);
+	}
+
+	if (bss_cfg->power_constraint) {
+		pwr_ct = (void *)tlv;
+		pwr_ct->header.type = cpu_to_le16(TLV_TYPE_PWR_CONSTRAINT);
+		pwr_ct->header.len = cpu_to_le16(sizeof(u8));
+		pwr_ct->constraint = bss_cfg->power_constraint;
+		cmd_size += sizeof(*pwr_ct);
+		tlv += sizeof(*pwr_ct);
+	}
+
+	if (bss_cfg->ps_sta_ao_timer) {
+		ps_ao_timer = (struct host_cmd_tlv_ageout_timer *)tlv;
+		ps_ao_timer->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_PS_AO_TIMER);
+		ps_ao_timer->header.len = cpu_to_le16(sizeof(*ps_ao_timer) -
+				sizeof(struct nxpwifi_ie_types_header));
+		ps_ao_timer->sta_ao_timer =
+					cpu_to_le32(bss_cfg->ps_sta_ao_timer);
+		cmd_size += sizeof(*ps_ao_timer);
+		tlv += sizeof(*ps_ao_timer);
+	}
+
+	*param_size = cmd_size;
+
+	return 0;
+}
+
+/* This function parses custom IEs from IE list and prepares command buffer */
+static int nxpwifi_uap_custom_ie_prepare(u8 *tlv, void *cmd_buf, u16 *ie_size)
+{
+	struct nxpwifi_ie_list *ap_ie = cmd_buf;
+	struct nxpwifi_ie_types_header *tlv_ie = (void *)tlv;
+
+	if (!ap_ie || !ap_ie->len)
+		return -EINVAL;
+
+	*ie_size += le16_to_cpu(ap_ie->len) +
+			sizeof(struct nxpwifi_ie_types_header);
+
+	tlv_ie->type = cpu_to_le16(TLV_TYPE_MGMT_IE);
+	tlv_ie->len = ap_ie->len;
+	tlv += sizeof(struct nxpwifi_ie_types_header);
+
+	memcpy(tlv, ap_ie->ie_list, le16_to_cpu(ap_ie->len));
+
+	return 0;
+}
+
+/* Parse AP config structure and prepare TLV based command structure
+ * to be sent to FW for uAP configuration
+ */
+static int
+nxpwifi_cmd_uap_sys_config(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type)
+{
+	u8 *tlv;
+	u16 cmd_size, param_size, ie_size;
+	struct host_cmd_ds_sys_config *sys_cfg;
+	int ret = 0;
+
+	cmd->command = cpu_to_le16(HOST_CMD_UAP_SYS_CONFIG);
+	cmd_size = (u16)(sizeof(struct host_cmd_ds_sys_config) + S_DS_GEN);
+	sys_cfg = &cmd->params.uap_sys_config;
+	sys_cfg->action = cpu_to_le16(cmd_action);
+	tlv = sys_cfg->tlv;
+
+	switch (cmd_type) {
+	case UAP_BSS_PARAMS_I:
+		param_size = cmd_size;
+		ret = nxpwifi_uap_bss_param_prepare(tlv, data_buf, &param_size);
+		if (ret)
+			return ret;
+		cmd->size = cpu_to_le16(param_size);
+		break;
+	case UAP_CUSTOM_IE_I:
+		ie_size = cmd_size;
+		ret = nxpwifi_uap_custom_ie_prepare(tlv, data_buf, &ie_size);
+		if (ret)
+			return ret;
+		cmd->size = cpu_to_le16(ie_size);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int
+nxpwifi_cmd_uap_bss_start(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *cmd,
+			  u16 cmd_no, void *data_buf,
+			  u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_ie_types_host_mlme *tlv;
+	int size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_UAP_BSS_START);
+	size = S_DS_GEN;
+
+	tlv = (struct nxpwifi_ie_types_host_mlme *)((u8 *)cmd + size);
+	tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+	tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
+	tlv->host_mlme = 1;
+	size += sizeof(struct nxpwifi_ie_types_host_mlme);
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_uap_bss_start(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp,
+			  u16 cmdresp_no,
+			  void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->tx_lock_flag = false;
+	adapter->pps_uapsd_mode = false;
+	adapter->delay_null_pkt = false;
+	priv->bss_started = 1;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_uap_bss_stop(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 u16 cmdresp_no,
+			 void *data_buf)
+{
+	priv->bss_started = 0;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_apcmd_sta_list(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *resp,
+			   u16 cmdresp_no,
+			   void *data_buf)
+{
+	struct host_cmd_ds_sta_list *sta_list =
+		&resp->params.sta_list;
+	struct nxpwifi_ie_types_sta_info *sta_info = (void *)&sta_list->tlv;
+	int i;
+	struct nxpwifi_sta_node *sta_node;
+
+	for (i = 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
+		sta_node = nxpwifi_get_sta_entry(priv, sta_info->mac);
+		if (unlikely(!sta_node))
+			continue;
+
+		sta_node->stats.rssi = sta_info->rssi;
+		sta_info++;
+	}
+
+	return 0;
+}
+
+/* This function prepares AP specific deauth command with mac supplied in
+ * function parameter.
+ */
+static int nxpwifi_cmd_uap_sta_deauth(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      u16 cmd_no, void *data_buf,
+				      u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_sta_deauth *sta_deauth = &cmd->params.sta_deauth;
+	u8 *mac = (u8 *)data_buf;
+
+	cmd->command = cpu_to_le16(HOST_CMD_UAP_STA_DEAUTH);
+	memcpy(sta_deauth->mac, mac, ETH_ALEN);
+	sta_deauth->reason = cpu_to_le16(WLAN_REASON_DEAUTH_LEAVING);
+
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_sta_deauth) +
+				S_DS_GEN);
+	return 0;
+}
+
+static int
+nxpwifi_cmd_uap_chan_report_request(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *cmd,
+				    u16 cmd_no, void *data_buf,
+				    u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_issue_chan_report_request(priv, cmd, data_buf);
+}
+
+/* This function prepares AP specific add station command.
+ */
+static int
+nxpwifi_cmd_uap_add_new_station(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				u16 cmd_no, void *data_buf,
+				u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_add_station *new_sta = &cmd->params.sta_info;
+	struct nxpwifi_sta_info *add_sta = (struct nxpwifi_sta_info *)data_buf;
+	struct station_parameters *params = add_sta->params;
+	struct nxpwifi_sta_node *sta_ptr;
+	u16 cmd_size;
+	u8 *pos, *cmd_end;
+	u16 tlv_len;
+	struct nxpwifi_ie_types_sta_flag *sta_flag;
+	int i;
+
+	cmd->command = cpu_to_le16(HOST_CMD_ADD_NEW_STATION);
+	new_sta->action = cpu_to_le16(cmd_action);
+	cmd_size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
+
+	if (cmd_action == HOST_ACT_ADD_STA)
+		sta_ptr = nxpwifi_add_sta_entry(priv, add_sta->peer_mac);
+	else
+		sta_ptr = nxpwifi_get_sta_entry(priv, add_sta->peer_mac);
+
+	if (!sta_ptr)
+		return -EINVAL;
+
+	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
+
+	if (cmd_action == HOST_ACT_REMOVE_STA) {
+		cmd->size = cpu_to_le16(cmd_size);
+		return 0;
+	}
+
+	new_sta->aid = cpu_to_le16(params->aid);
+	new_sta->listen_interval = cpu_to_le32(params->listen_interval);
+	new_sta->cap_info = cpu_to_le16(params->capability);
+
+	pos = new_sta->tlv;
+	cmd_end = (u8 *)cmd;
+	cmd_end += (NXPWIFI_SIZE_OF_CMD_BUFFER - 1);
+
+	if (params->sta_flags_set & NL80211_STA_FLAG_WME)
+		sta_ptr->is_wmm_enabled = 1;
+	sta_flag = (struct nxpwifi_ie_types_sta_flag *)pos;
+	sta_flag->header.type = cpu_to_le16(TLV_TYPE_UAP_STA_FLAGS);
+	sta_flag->header.len = cpu_to_le16(sizeof(__le32));
+	sta_flag->sta_flags = cpu_to_le32(params->sta_flags_set);
+	pos += sizeof(struct nxpwifi_ie_types_sta_flag);
+	cmd_size += sizeof(struct nxpwifi_ie_types_sta_flag);
+
+	if (params->ext_capab_len) {
+		u8 *data = (u8 *)params->ext_capab;
+		u16 len = params->ext_capab_len;
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_EXT_CAPABILITY,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+	}
+
+	if (params->link_sta_params.supported_rates_len) {
+		u8 *data = (u8 *)params->link_sta_params.supported_rates;
+		u16 len = params->link_sta_params.supported_rates_len;
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_SUPP_RATES,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+	}
+
+	if (params->uapsd_queues || params->max_sp) {
+		u8 qos_capability = params->uapsd_queues | (params->max_sp << 5);
+		u8 *data = &qos_capability;
+		u16 len = sizeof(u8);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_QOS_CAPA,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+		sta_ptr->is_wmm_enabled = 1;
+	}
+
+	if (params->link_sta_params.ht_capa) {
+		u8 *data = (u8 *)params->link_sta_params.ht_capa;
+		u16 len = sizeof(struct ieee80211_ht_cap);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_HT_CAPABILITY,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+		sta_ptr->is_11n_enabled = 1;
+		sta_ptr->max_amsdu =
+			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
+			IEEE80211_HT_CAP_MAX_AMSDU ?
+			NXPWIFI_TX_DATA_BUF_SIZE_8K :
+			NXPWIFI_TX_DATA_BUF_SIZE_4K;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		u8 *data = (u8 *)params->link_sta_params.vht_capa;
+		u16 len = sizeof(struct ieee80211_vht_cap);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_VHT_CAPABILITY,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+		sta_ptr->is_11ac_enabled = 1;
+	}
+
+	if (params->link_sta_params.opmode_notif_used) {
+		u8 *data = &params->link_sta_params.opmode_notif;
+		u16 len = sizeof(u8);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_OPMODE_NOTIF,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+	}
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		if (sta_ptr->is_11n_enabled)
+			sta_ptr->ampdu_sta[i] =
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			sta_ptr->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
+	}
+
+	memset(sta_ptr->rx_seq, 0xff, sizeof(sta_ptr->rx_seq));
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+static const struct nxpwifi_cmd_entry cmd_table_uap[] = {
+	{.cmd_no = HOST_CMD_APCMD_SYS_RESET,
+	.prepare_cmd = nxpwifi_cmd_fill_head_only,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_UAP_SYS_CONFIG,
+	.prepare_cmd = nxpwifi_cmd_uap_sys_config,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_UAP_BSS_START,
+	.prepare_cmd = nxpwifi_cmd_uap_bss_start,
+	.cmd_resp = nxpwifi_ret_uap_bss_start},
+	{.cmd_no = HOST_CMD_UAP_BSS_STOP,
+	.prepare_cmd = nxpwifi_cmd_fill_head_only,
+	.cmd_resp = nxpwifi_ret_uap_bss_stop},
+	{.cmd_no = HOST_CMD_APCMD_STA_LIST,
+	.prepare_cmd = nxpwifi_cmd_fill_head_only,
+	.cmd_resp = nxpwifi_ret_apcmd_sta_list},
+	{.cmd_no = HOST_CMD_UAP_STA_DEAUTH,
+	.prepare_cmd = nxpwifi_cmd_uap_sta_deauth,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_CHAN_REPORT_REQUEST,
+	.prepare_cmd = nxpwifi_cmd_uap_chan_report_request,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_ADD_NEW_STATION,
+	.prepare_cmd = nxpwifi_cmd_uap_add_new_station,
+	.cmd_resp = NULL},
+};
+
+/* This function prepares the AP specific commands before sending them
+ * to the firmware.
+ * This is a generic function which calls specific command preparation
+ * routines based upon the command number.
+ */
+int nxpwifi_uap_prepare_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node,
+			    u16 cmd_action, u32 type)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 cmd_no = cmd_node->cmd_no;
+	struct host_cmd_ds_command *cmd =
+		(struct host_cmd_ds_command *)cmd_node->skb->data;
+	void *data_buf = cmd_node->data_buf;
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(cmd_table_uap); i++) {
+		if (cmd_no == cmd_table_uap[i].cmd_no) {
+			if (cmd_table_uap[i].prepare_cmd)
+				ret = cmd_table_uap[i].prepare_cmd(priv, cmd,
+								   cmd_no,
+								   data_buf,
+								   cmd_action,
+								   type);
+			cmd_node->cmd_resp = cmd_table_uap[i].cmd_resp;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(cmd_table_uap))
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: unknown command: %#x\n",
+			    __func__, cmd_no);
+	else
+		nxpwifi_dbg(adapter, CMD,
+			    "%s: command: %#x\n",
+			    __func__, cmd_no);
+
+	return ret;
+}
+
+/* This function parses security related parameters from cfg80211_ap_settings
+ * and sets into FW understandable bss_config structure.
+ */
+int nxpwifi_set_secure_params(struct nxpwifi_private *priv,
+			      struct nxpwifi_uap_bss_param *bss_config,
+			      struct cfg80211_ap_settings *params)
+{
+	int i;
+	struct nxpwifi_wep_key wep_key;
+
+	if (!params->privacy) {
+		bss_config->protocol = PROTOCOL_NO_SECURITY;
+		bss_config->key_mgmt = KEY_MGMT_NONE;
+		bss_config->wpa_cfg.length = 0;
+		priv->sec_info.wep_enabled = 0;
+		priv->sec_info.wpa_enabled = 0;
+		priv->sec_info.wpa2_enabled = 0;
+
+		return 0;
+	}
+
+	switch (params->auth_type) {
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		bss_config->auth_mode = WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		bss_config->auth_mode = WLAN_AUTH_SHARED_KEY;
+		break;
+	case NL80211_AUTHTYPE_NETWORK_EAP:
+		bss_config->auth_mode = WLAN_AUTH_LEAP;
+		break;
+	default:
+		bss_config->auth_mode = NXPWIFI_AUTH_MODE_AUTO;
+		break;
+	}
+
+	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
+
+	bss_config->protocol = 0;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+		bss_config->protocol |= PROTOCOL_WPA;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+		bss_config->protocol |= PROTOCOL_WPA2;
+
+	bss_config->key_mgmt = 0;
+	for (i = 0; i < params->crypto.n_akm_suites; i++) {
+		switch (params->crypto.akm_suites[i]) {
+		case WLAN_AKM_SUITE_8021X:
+			bss_config->key_mgmt |= KEY_MGMT_EAP;
+			break;
+		case WLAN_AKM_SUITE_PSK:
+			bss_config->key_mgmt |= KEY_MGMT_PSK;
+			break;
+		case WLAN_AKM_SUITE_PSK_SHA256:
+			bss_config->key_mgmt |= KEY_MGMT_PSK_SHA256;
+			break;
+		case WLAN_AKM_SUITE_OWE:
+			bss_config->key_mgmt |= KEY_MGMT_OWE;
+			break;
+		case WLAN_AKM_SUITE_SAE:
+			bss_config->key_mgmt |= KEY_MGMT_SAE;
+			break;
+		default:
+			break;
+		}
+	}
+
+	for (i = 0; i < params->crypto.n_ciphers_pairwise; i++) {
+		switch (params->crypto.ciphers_pairwise[i]) {
+		case WLAN_CIPHER_SUITE_WEP40:
+		case WLAN_CIPHER_SUITE_WEP104:
+			break;
+		case WLAN_CIPHER_SUITE_TKIP:
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+				bss_config->wpa_cfg.pairwise_cipher_wpa |=
+								CIPHER_TKIP;
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+				bss_config->wpa_cfg.pairwise_cipher_wpa2 |=
+								CIPHER_TKIP;
+			break;
+		case WLAN_CIPHER_SUITE_CCMP:
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+				bss_config->wpa_cfg.pairwise_cipher_wpa |=
+								CIPHER_AES_CCMP;
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+				bss_config->wpa_cfg.pairwise_cipher_wpa2 |=
+								CIPHER_AES_CCMP;
+			break;
+		default:
+			break;
+		}
+	}
+
+	switch (params->crypto.cipher_group) {
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		if (priv->sec_info.wep_enabled) {
+			bss_config->protocol = PROTOCOL_STATIC_WEP;
+			bss_config->key_mgmt = KEY_MGMT_NONE;
+			bss_config->wpa_cfg.length = 0;
+
+			for (i = 0; i < NUM_WEP_KEYS; i++) {
+				wep_key = priv->wep_key[i];
+				bss_config->wep_cfg[i].key_index = i;
+
+				if (priv->wep_key_curr_index == i)
+					bss_config->wep_cfg[i].is_default = 1;
+				else
+					bss_config->wep_cfg[i].is_default = 0;
+
+				bss_config->wep_cfg[i].length =
+							     wep_key.key_length;
+				memcpy(&bss_config->wep_cfg[i].key,
+				       &wep_key.key_material,
+				       wep_key.key_length);
+			}
+		}
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		bss_config->wpa_cfg.group_cipher = CIPHER_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		bss_config->wpa_cfg.group_cipher = CIPHER_AES_CCMP;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* This function updates 11n related parameters from IE and sets them into
+ * bss_config structure.
+ */
+void
+nxpwifi_set_ht_params(struct nxpwifi_private *priv,
+		      struct nxpwifi_uap_bss_param *bss_cfg,
+		      struct cfg80211_ap_settings *params)
+{
+	const u8 *ht_ie;
+
+	if (!ISSUPP_11NENABLED(priv->adapter->fw_cap_info))
+		return;
+
+	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, params->beacon.tail,
+				 params->beacon.tail_len);
+	if (ht_ie) {
+		memcpy(&bss_cfg->ht_cap, ht_ie + 2,
+		       sizeof(struct ieee80211_ht_cap));
+		if (ISSUPP_BEAMFORMING(priv->adapter->hw_dot_11n_dev_cap))
+			bss_cfg->ht_cap.tx_BF_cap_info =
+				cpu_to_le32(NXPWIFI_DEF_11N_TX_BF_CAP);
+		priv->ap_11n_enabled = 1;
+	} else {
+		memset(&bss_cfg->ht_cap, 0, sizeof(struct ieee80211_ht_cap));
+		bss_cfg->ht_cap.cap_info = cpu_to_le16(NXPWIFI_DEF_HT_CAP);
+		bss_cfg->ht_cap.ampdu_params_info = NXPWIFI_DEF_AMPDU;
+	}
+}
+
+/* This function updates 11ac related parameters from IE
+ * and sets them into bss_config structure.
+ */
+void nxpwifi_set_vht_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params)
+{
+	const u8 *vht_ie;
+
+	vht_ie = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, params->beacon.tail,
+				  params->beacon.tail_len);
+	if (vht_ie) {
+		memcpy(&bss_cfg->vht_cap, vht_ie + 2,
+		       sizeof(struct ieee80211_vht_cap));
+		priv->ap_11ac_enabled = 1;
+	} else {
+		priv->ap_11ac_enabled = 0;
+	}
+}
+
+/* This function updates 11ac related parameters from IE
+ * and sets them into bss_config structure.
+ */
+void nxpwifi_set_tpc_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params)
+{
+	const u8 *tpc_ie;
+
+	tpc_ie = cfg80211_find_ie(WLAN_EID_TPC_REQUEST, params->beacon.tail,
+				  params->beacon.tail_len);
+	if (tpc_ie)
+		bss_cfg->power_constraint = *(tpc_ie + 2);
+	else
+		bss_cfg->power_constraint = 0;
+}
+
+/* Enable VHT only when cfg80211_ap_settings has VHT IE.
+ * Otherwise disable VHT.
+ */
+void nxpwifi_set_vht_width(struct nxpwifi_private *priv,
+			   enum nl80211_chan_width width,
+			   bool ap_11ac_enable)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_11ac_vht_cfg vht_cfg;
+
+	vht_cfg.band_config = VHT_CFG_5GHZ;
+	vht_cfg.cap_info = adapter->hw_dot_11ac_dev_cap;
+
+	if (!ap_11ac_enable) {
+		vht_cfg.mcs_tx_set = DISABLE_VHT_MCS_SET;
+		vht_cfg.mcs_rx_set = DISABLE_VHT_MCS_SET;
+	} else {
+		vht_cfg.mcs_tx_set = DEFAULT_VHT_MCS_SET;
+		vht_cfg.mcs_rx_set = DEFAULT_VHT_MCS_SET;
+	}
+
+	vht_cfg.misc_config  = VHT_CAP_UAP_ONLY;
+
+	if (ap_11ac_enable && width >= NL80211_CHAN_WIDTH_80)
+		vht_cfg.misc_config |= VHT_BW_80_160_80P80;
+
+	nxpwifi_send_cmd(priv, HOST_CMD_11AC_CFG,
+			 HOST_ACT_GEN_SET, 0, &vht_cfg, true);
+}
+
+/* This function finds supported rates IE from beacon parameter and sets
+ * these rates into bss_config structure.
+ */
+void
+nxpwifi_set_uap_rates(struct nxpwifi_uap_bss_param *bss_cfg,
+		      struct cfg80211_ap_settings *params)
+{
+	struct element *rate_ie;
+	int var_offset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
+	const u8 *var_pos = params->beacon.head + var_offset;
+	int len = params->beacon.head_len - var_offset;
+	u8 rate_len = 0;
+
+	rate_ie = (void *)cfg80211_find_ie(WLAN_EID_SUPP_RATES, var_pos, len);
+	if (rate_ie) {
+		if (rate_ie->datalen > NXPWIFI_SUPPORTED_RATES)
+			return;
+		memcpy(bss_cfg->rates, rate_ie + 1, rate_ie->datalen);
+		rate_len = rate_ie->datalen;
+	}
+
+	rate_ie = (void *)cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
+					   params->beacon.tail,
+					   params->beacon.tail_len);
+	if (rate_ie) {
+		if (rate_ie->datalen > NXPWIFI_SUPPORTED_RATES - rate_len)
+			return;
+		memcpy(bss_cfg->rates + rate_len,
+		       rate_ie + 1, rate_ie->datalen);
+	}
+}
+
+/* This function initializes some of nxpwifi_uap_bss_param variables.
+ * This helps FW in ignoring invalid values. These values may or may not
+ * be get updated to valid ones at later stage.
+ */
+void nxpwifi_set_sys_config_invalid_data(struct nxpwifi_uap_bss_param *config)
+{
+	config->bcast_ssid_ctl = 0x7F;
+	config->radio_ctl = 0x7F;
+	config->dtim_period = 0x7F;
+	config->beacon_period = 0x7FFF;
+	config->auth_mode = 0x7F;
+	config->rts_threshold = 0x7FFF;
+	config->frag_threshold = 0x7FFF;
+	config->retry_limit = 0x7F;
+	config->qos_info = 0xFF;
+}
+
+/* This function parses WMM related parameters from cfg80211_ap_settings
+ * structure and updates bss_config structure.
+ */
+void
+nxpwifi_set_wmm_params(struct nxpwifi_private *priv,
+		       struct nxpwifi_uap_bss_param *bss_cfg,
+		       struct cfg80211_ap_settings *params)
+{
+	const u8 *vendor_ie;
+	const u8 *wmm_ie;
+	static const u8 wmm_oui[] = {0x00, 0x50, 0xf2, 0x02};
+
+	vendor_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+					    WLAN_OUI_TYPE_MICROSOFT_WMM,
+					    params->beacon.tail,
+					    params->beacon.tail_len);
+	if (vendor_ie) {
+		wmm_ie = vendor_ie;
+		if (*(wmm_ie + 1) > sizeof(struct nxpwifi_types_wmm_info))
+			return;
+		memcpy(&bss_cfg->wmm_info, wmm_ie +
+		       sizeof(struct element), *(wmm_ie + 1));
+		priv->wmm_enabled = 1;
+	} else {
+		memset(&bss_cfg->wmm_info, 0, sizeof(bss_cfg->wmm_info));
+		memcpy(&bss_cfg->wmm_info.oui, wmm_oui, sizeof(wmm_oui));
+		bss_cfg->wmm_info.subtype = NXPWIFI_WMM_SUBTYPE;
+		bss_cfg->wmm_info.version = NXPWIFI_WMM_VERSION;
+		priv->wmm_enabled = 0;
+	}
+
+	bss_cfg->qos_info = 0x00;
+}
+
+/* This function enable 11D if userspace set the country IE.
+ */
+void nxpwifi_config_uap_11d(struct nxpwifi_private *priv,
+			    struct cfg80211_beacon_data *beacon_data)
+{
+	enum state_11d_t state_11d;
+	const u8 *country_ie;
+
+	country_ie = cfg80211_find_ie(WLAN_EID_COUNTRY, beacon_data->tail,
+				      beacon_data->tail_len);
+	if (country_ie) {
+		/* Send cmd to FW to enable 11D function */
+		state_11d = ENABLE_11D;
+		if (nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				     HOST_ACT_GEN_SET, DOT11D_I,
+				     &state_11d, true)) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "11D: failed to enable 11D\n");
+		}
+	}
+}
+
+void nxpwifi_uap_set_channel(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg,
+			     struct cfg80211_chan_def chandef)
+{
+	u8 config_bands = 0, old_bands = priv->adapter->config_bands;
+
+	priv->bss_chandef = chandef;
+
+	bss_cfg->channel =
+		ieee80211_frequency_to_channel(chandef.chan->center_freq);
+
+	/* Set appropriate bands */
+	if (chandef.chan->band == NL80211_BAND_2GHZ) {
+		bss_cfg->band_cfg = BAND_CONFIG_BG;
+		config_bands = BAND_B | BAND_G;
+
+		if (chandef.width > NL80211_CHAN_WIDTH_20_NOHT)
+			config_bands |= BAND_GN;
+	} else {
+		bss_cfg->band_cfg = BAND_CONFIG_A;
+		config_bands = BAND_A;
+
+		if (chandef.width > NL80211_CHAN_WIDTH_20_NOHT)
+			config_bands |= BAND_AN;
+
+		if (chandef.width > NL80211_CHAN_WIDTH_40)
+			config_bands |= BAND_AAC;
+	}
+
+	switch (chandef.width) {
+	case NL80211_CHAN_WIDTH_5:
+	case NL80211_CHAN_WIDTH_10:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		if (chandef.center_freq1 < chandef.chan->center_freq)
+			bss_cfg->band_cfg |= NXPWIFI_SEC_CHAN_BELOW;
+		else
+			bss_cfg->band_cfg |= NXPWIFI_SEC_CHAN_ABOVE;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+		bss_cfg->band_cfg |=
+		    nxpwifi_get_sec_chan_offset(bss_cfg->channel) << 4;
+		break;
+	default:
+		nxpwifi_dbg(priv->adapter,
+			    WARN, "Unknown channel width: %d\n",
+			    chandef.width);
+		break;
+	}
+
+	priv->adapter->config_bands = config_bands;
+
+	if (old_bands != config_bands) {
+		nxpwifi_send_domain_info_cmd_fw(priv->adapter->wiphy);
+		nxpwifi_dnld_txpwr_table(priv);
+	}
+}
+
+int nxpwifi_config_start_uap(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg)
+{
+	int ret;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_UAP_SYS_CONFIG,
+			       HOST_ACT_GEN_SET,
+			       UAP_BSS_PARAMS_I, bss_cfg, true);
+	if (ret) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to set AP configuration\n");
+		return ret;
+	}
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_START,
+			       HOST_ACT_GEN_SET, 0, NULL, true);
+	if (ret) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to start the BSS\n");
+		return ret;
+	}
+
+	if (priv->sec_info.wep_enabled)
+		priv->curr_pkt_filter |= HOST_ACT_MAC_WEP_ENABLE;
+	else
+		priv->curr_pkt_filter &= ~HOST_ACT_MAC_WEP_ENABLE;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MAC_CONTROL,
+			       HOST_ACT_GEN_SET, 0,
+			       &priv->curr_pkt_filter, true);
+
+	return ret;
+}
-- 
2.34.1


