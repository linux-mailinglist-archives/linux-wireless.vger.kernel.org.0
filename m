Return-Path: <linux-wireless+bounces-32524-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJA/K5CXqWlKAgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32524-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:47:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B24213CC5
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B19A530E5A0C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329893A8FE0;
	Thu,  5 Mar 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MtCqDGla"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69093A7F72;
	Thu,  5 Mar 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721721; cv=fail; b=Q1HT8zr+I9mmDTXiqdtTesXPegFL3ZF9TRf7BxB/LZ7JxWBHvYOm9ffhpJuNmdJoktHwcJTZMZPZpQTIbZs77+bDaoxlX4eF4LlFQKEr+xLZlCproiGhjaPWKiPCIfGHL+s+adf796odYcPhutvkpNUbUyPwvqi48rbT4AJtqTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721721; c=relaxed/simple;
	bh=2b/20dgCQFBb1wCqTd7mIYzvS1UZVdbfPozk4f96LqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAWs0lOMaYREApWoK07RPGJiHg0VWpu31zeRynUDbPy7fa8VcZmFsNY+HBR+Lv5BTFc+0oGN9GANmijYhVAsUE/4ZnHEJHVq9ne9MirY3VW/PsVkETiI6jy7xhb2TxEaf4X1leMfFYOGA/tiWdA7SRiPoGQCG8bjctqNh38hq4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MtCqDGla; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf43MJiRmYleLknkDf8jA93r5BAejeh/X5m42UouLs6HudPuOO9FTMXPAqVivP5Pv/dmEw1HYXEdD5jlRfW0F8lmH1PBIdiCdFQO/7v8oTVAiUhGindQwMSH+pXQCKW/jVpqzULlxT5ojkU3HqsXtWIsGxJP/w1J+ua7aEDkLIxSd5KRWrRGoksNjz7VRLZG0mvczz5aSaScZLn5lLlzAxRNpFei8eQX6E2zSfn13n6P6qVNhGrMYR/bwLzLB1g9+pd3fZ9vo7pE5vNrAXYEWN6wnlB2sB5qdzh25AELw8NBCli68JNvdopEmSfoOU0I7bTJxsk3Wjqxtwy/QvUBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLak0qp5+AGWIHc0azANkh2VKF/nRvMyEidgRhdjzjU=;
 b=abeCIbM72sz20jy9AipMgdgBSBlmiayYaDGMPtX2SvErBwZ2zBM4UXMSQBXugy1IIHy0aSGICPe6VA67hP7mM+5VwdMehnnN9gw+LNDhO54TwOVYka5tLP07LwrtXHNcm6uL+GpVH+fTeVVIRg62JgZ9hIEZhz/XEIEBhIa2hQvjNGVmoqUwRkRCu737mJYboXaJuPHuIajRmPqZJ5ZNGKzgEpJwltHRyKe19Gs/VMXhJxZM24m1QikT9AMsxcHJq2SbJnt4egaYaHq82m5xO/UgjtNnjnsLlVAK69LP+9SFHkW1JTH4j5Qw7pd0+fnyc3F965ke2IV1+weAcQCeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLak0qp5+AGWIHc0azANkh2VKF/nRvMyEidgRhdjzjU=;
 b=MtCqDGlaxTlMgTMgJEvniSGiquE0JwOwpWEjCQ7jRLiDhCKYMpOeuiLaw+S8sgJuswUxppm0vIRinhQNsqO+YyLQEC7NAfahKLrx17mYSz27zX2W0gf2IIBk2qMYel2ndVUYemCqfB0fhfBgzB2ppptIMM/Ce8JVWaoT9OftbC+mjfyz8zgZu1QYlZJ4gOhkyloUckk6kMOuIHYxMeJQCdw9+bDNhiNpRAXnKu3Dn0D7zCg+6Xo4dxCV2x3nfJLLER8z8sxyQBSme2uFcBpA+ARuHCSjnEYNeXW8PhvGeP59qRYBH2tg4slcsy/O8DruA1CuuSY7PZylvPAta11V7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:41:56 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:41:56 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 03/21] wifi: nxpwifi: add initial 802.11ax support for STA and AP modes
Date: Thu,  5 Mar 2026 22:39:21 +0800
Message-Id: <20260305143939.3724868-4-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 949f7827-006a-4956-ff0b-08de7ac5593c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZWtPpREk97d/eVC4DPe74wS8Z4NDHiAYjrw5nEwvFl39fWCh7uAy4BVjYFyZtoaulO4UjweZSGl6dxeQSlw/fRU/64s2sog1a1LDbP7C2getLQzoffIsFNeYgdDjqc3reSPIWG0LLtduqC5MI6n9740ajZqFXpt5wcIU5sub8u/MGGALYFfOOK+/Ims16HccsUh1jMc8BrulMuExTRFtXb4gXLtIKLbQ9Jsz+DD2wfBECvwRvuAmwAQe/OA7cH58yjGZRD7L6vW4GxaWgjA66SM9uTJRmpzbxap/NE9fN3GER3WhzAwf8D/vOCbJz1GVQEgXT2UhTz6daWk4uWW3JQgywen7caRFv1p4fs6LM4gp64g3XqLqnD9aGsQEHr7SsTcIX69TuL3fN1b65XjGMxh/AUahB+hBkb49H3oDJi0UgeD7g/qbPgn7WH4UDMyVV3HYnOlCAR6c/HNiqcK44lWLQixxYcfbW/nmvD9zoV1+f039MPN/2jwNVfk4OUQJfEw/chH8WHhrjPqHSa8eiHJDjtb5/02vm9EUn35Zv/URt3j25Z0zjHefXu3KVSuwKqMo08t842PqL0T9uITEMXll4MTqiqq2WCC+HaYl/hMajT+zPSyoQGCBSJ1I4TidizNBoQ1wuEw/3jfVBbZmtj7cpBA4VqMx6Evi93YA+7ratFBITx7yuSOePo+E/tKBdTXe6lZc0ubA+ZDPB0LlxcDTDymfIfaPT/on6E6mzDDUju82LUa4kKBKfo+c/yCp1VE0Eue87stLKBeZKuqZvVGaZFkeLg5N+1ZFmLgPdO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiNQOr2ghoI0Pkl4cl+dDhD4dxGXJrfuqIHdEp4CS9XrvAbiDjxQzjWIZNBy?=
 =?us-ascii?Q?5N63I8fbEQ/ZYwJjNGPrA9CNfamwTNDM2jQW3Ee6KVdUV8s4UVxxT2y/2HMR?=
 =?us-ascii?Q?HrEblmXK+UCh+lyzkItWx3ujyIhhYZa0qmxehOdQSRB4quQDzRTG7TPesBDx?=
 =?us-ascii?Q?/qi27vOf2wzPb9a3RHRq8zNczUekwPR7Vs12hYZzf8TCTTjmFTSHeCf2hC+1?=
 =?us-ascii?Q?F0Z5qQxJg6mpWQviGkG4TB5mm2H9jlGrUwft5Ai5VKCFu9yGoKXG20E99VEl?=
 =?us-ascii?Q?sFHqKF8U6QuvS9jBISVJjBkWZnEkAkBKerH24LbgyzSnTZTM14KUmJpXKPzD?=
 =?us-ascii?Q?Z/MB7ptCIhA/VNEeRRfuzqfeaDKzcKGh3NJ4et3zVwQ9j+xdQNQpRp2l3d3Y?=
 =?us-ascii?Q?sXnMzgksVShuAeajlyVMZNP2ALpr0yL/oDHoFFuIsmXPyDs3A0XKMbytNKbe?=
 =?us-ascii?Q?8hbbGuDYQD57NM+pWed/b+ffzIIKlNetsYAEF9ZuA8J2h0jJHmhBf2VHLcYH?=
 =?us-ascii?Q?3v0MzqPWvRW2p9AVRrB5SIvQFTgMUYa6wMv4F6kRAxGQAfLrjiSfWemsjZ9H?=
 =?us-ascii?Q?QfqW3Cx+sevqez58misB49B9BTtWe7yBxcff6ahBt+V9g/AywgZlcZVrb9kB?=
 =?us-ascii?Q?+qTFzfbXMPosXNbAoxA8FiZE8DMqGnauUvmQ+FRW8mcDpOlyJLJ/UgL1D8z5?=
 =?us-ascii?Q?Kns3LFPySIE2+v8PYou9sZaehPpU+fPBsx7ktVE7RwSxHxlTEiD/x9WA8FGS?=
 =?us-ascii?Q?X8xfjOsCd/jS9obfBSACr4HYL0StImpxDGiSoOvMS9oiutvNPPW7o8vBld25?=
 =?us-ascii?Q?taKP8e4H6X6mkA/lmDuIeUQBU16F0+tu+ye9m3odj8IVrQAGQAH1cSllE+j7?=
 =?us-ascii?Q?xyJYe+vXoJQHk9Y+7DL0VcFR89rDliEzdkJB+LK+c4zMkkdwtgtB154EnWKE?=
 =?us-ascii?Q?VxlURPrUf0DMpHHQaKyYEVS5QsIW04p3pnnde+M9Yw+x7VA8h9fmSjhioPk/?=
 =?us-ascii?Q?aZ3FVdAOtqPCLmUTmrky0fkhUBdSzpLs99UW5dOjkges3kNpaUXvVTafqrAr?=
 =?us-ascii?Q?PwI5B8fSOLUVK7Nb7Ea9GhOkBhzRX3qzQsW3TBudZoESpm0yRNGMAZ92Spsw?=
 =?us-ascii?Q?CVFF2irrv9GkrMjZcY3xB4T9j1FbUQHyReI2FmxI7PXuVTJS3Lqvq8l1Rmq7?=
 =?us-ascii?Q?R1vSUyrKGqwERHnmHUQGL76d4efzKZieyaGA8hDS/RNFAyNWnGUzwovStxqV?=
 =?us-ascii?Q?F9b4rNzCB0UtiJwwJK5TK5jJXfww3al/g2j5nGs0UNmdxoBE2CyvSqSpR1bT?=
 =?us-ascii?Q?SGofuHW+bLE3x0m1eP2zzMpEqBfqpWLty1CG6s3lM0O+q7GypsaqB3JOkf3T?=
 =?us-ascii?Q?czJ4vL8Z73nsS7cuP3QYpIcAeYNJuyunu25i7216Pk+30qBaoS19acEUuhAl?=
 =?us-ascii?Q?2NM/Oc0l7ui1mBR9q5Zi7clPf01uilXRgU2ySFdQeJ4Z+HH/b8RvFQ7HdMVH?=
 =?us-ascii?Q?C0ExGQxaLs6w2gLKW8RfWuZ+qBW9XwGfNMqTiJz0KvaHAfuh+gkJgB2Vdfz9?=
 =?us-ascii?Q?o9lk8HgCXc8vFX0K5tk+sejiYnEVQgUeSnQto0TChOsBORCqFSZtAUwu78XQ?=
 =?us-ascii?Q?P6nt7tcAuCYc3ZtsOm/c37yCt0nQtaNLC6knj6uZ9EB/V+2jsqDPsl08KnzY?=
 =?us-ascii?Q?Y2cRVl46p1CfFatbMcVhzF7O8PCIzC64SDJUxOhpuEhDoZ1SE7xGWTVJ6Nlr?=
 =?us-ascii?Q?5WASEcx/zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949f7827-006a-4956-ff0b-08de7ac5593c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:41:55.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vp16VpJCnU5tSbYAe8nl5j3qCtuAG0VEmfzprdKUIwCviBRrp5fL0MlObx0kxu2tRLyWG+IRVjpNQx0s1lhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313
X-Rspamd-Queue-Id: 62B24213CC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32524-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Introduce initial 802.11ax functionality, enabling HE capability
negotiation and configuration for both STA and AP roles.

Convert HE elements from cfg80211 into firmware TLVs and append them to
HOST_CMD_802_11_ASSOCIATE when operating as a station. For AP mode,
convert HE elements into parameters for HOST_CMD_11AX_CFG and provide
them to the firmware for configuration.

Handle HE MAC/PHY capabilities, MCS maps, and Target Wake Time (TWT)
negotiation. Add support for additional 11ax-specific firmware commands,
including OBSS PD, beamforming, TXOMI, and broadcast TWT.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 594 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  73 +++
 2 files changed, 667 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..cc47c435eb70
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* nxpwifi: 802.11ax (HE) support
+ * Copyright (C) 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ax.h"
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *user_he_cap = NULL;
+	u8 header_len = sizeof(struct nxpwifi_ie_types_header);
+	u16 data_len = le16_to_cpu(hw_he_cap->header.len);
+	bool he_cap_2g = false;
+	int i;
+
+	if ((data_len + header_len) > sizeof(adapter->hw_he_cap)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hw_he_cap too big, len=%d\n",
+			    data_len);
+		return;
+	}
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)hw_he_cap;
+
+	if (he_cap->he_phy_cap[0] &
+	    (AX_2G_40MHZ_SUPPORT | AX_2G_20MHZ_SUPPORT)) {
+		adapter->hw_2g_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_2g_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_2g_he_cap_len);
+		adapter->fw_bands |= BAND_GAX;
+		he_cap_2g = true;
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability element ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability element ",
+				 adapter->hw_he_cap,
+				 adapter->hw_he_cap_len);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (he_cap_2g) {
+			priv->user_2g_he_cap_len = adapter->hw_2g_he_cap_len;
+			memcpy(priv->user_2g_he_cap, adapter->hw_2g_he_cap,
+			       sizeof(adapter->hw_2g_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_2g_he_cap;
+		} else {
+			priv->user_he_cap_len = adapter->hw_he_cap_len;
+			memcpy(priv->user_he_cap, adapter->hw_he_cap,
+			       sizeof(adapter->hw_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_he_cap;
+		}
+
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_RESP_SUPPORT;
+		else
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	adapter->is_hw_11ax_capable = true;
+}
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u16 bss_band = bss_desc->bss_band;
+
+	if (bss_desc->disable_11n)
+		return false;
+
+	if (bss_band & BAND_G)
+		return (priv->config_bands & BAND_GAX);
+	else if (bss_band & BAND_A)
+		return (priv->config_bands & BAND_AAX);
+
+	return false;
+}
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap = NULL;
+	u16 rx_nss, tx_nss;
+	u8 nss;
+	u16 cfg_value;
+	u16 hw_value;
+	int ret_len;
+
+	if (bands & BAND_A) {
+		memcpy(he_cap, priv->user_he_cap, priv->user_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_he_cap;
+		ret_len = priv->user_he_cap_len;
+	} else {
+		memcpy(he_cap, priv->user_2g_he_cap, priv->user_2g_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_2g_he_cap;
+		ret_len = priv->user_2g_he_cap_len;
+	}
+
+	if (bands & BAND_A) {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream >> 8);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream >> 8) & 0x0f;
+	} else {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream) & 0x0f;
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->rx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->rx_mcs_80, nss);
+		if (rx_nss != 0 && nss > rx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->tx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->tx_mcs_80, nss);
+		if (tx_nss != 0 && nss > tx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	int ret_len;
+
+	if (!bss_desc->bcn_he_cap)
+		return -EOPNOTSUPP;
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)*buffer;
+	ret_len = nxpwifi_fill_he_cap_tlv(priv, he_cap, bss_desc->bss_band);
+	*buffer += ret_len;
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &cmd->params.ax_cfg;
+	u16 cmd_size;
+	struct nxpwifi_ie_types_header *header;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CFG);
+	cmd_size = sizeof(struct host_cmd_11ax_cfg) + S_DS_GEN;
+
+	he_cfg->action = cpu_to_le16(cmd_action);
+	he_cfg->band_config = ax_cfg->band;
+
+	if (ax_cfg->he_cap_cfg.len &&
+	    ax_cfg->he_cap_cfg.ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+		header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+		header->type = cpu_to_le16(ax_cfg->he_cap_cfg.id);
+		header->len = cpu_to_le16(ax_cfg->he_cap_cfg.len);
+		memcpy(he_cfg->tlv + sizeof(*header),
+		       &ax_cfg->he_cap_cfg.ext_id,
+		       ax_cfg->he_cap_cfg.len);
+		cmd_size += (sizeof(*header) + ax_cfg->he_cap_cfg.len);
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &resp->params.ax_cfg;
+	struct nxpwifi_ie_types_header *header;
+	u16 left_len, tlv_type, tlv_len;
+	u8 ext_id;
+	struct nxpwifi_11ax_he_cap_cfg *he_cap = &ax_cfg->he_cap_cfg;
+
+	left_len = le16_to_cpu(resp->size) - sizeof(*he_cfg) - S_DS_GEN;
+	header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+
+	while (left_len > sizeof(*header)) {
+		tlv_type = le16_to_cpu(header->type);
+		tlv_len = le16_to_cpu(header->len);
+
+		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
+			ext_id = *((u8 *)header + sizeof(*header) + 1);
+			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+				he_cap->id = tlv_type;
+				he_cap->len = tlv_len;
+				memcpy((u8 *)&he_cap->ext_id,
+				       (u8 *)header + sizeof(*header) + 1,
+				       tlv_len);
+				if (he_cfg->band_config & BIT(1)) {
+					memcpy(priv->user_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_he_cap_len =
+						sizeof(*header) + tlv_len;
+				} else {
+					memcpy(priv->user_2g_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_2g_he_cap_len =
+						sizeof(*header) + tlv_len;
+				}
+			}
+		}
+
+		left_len -= (sizeof(*header) + tlv_len);
+		header = (struct nxpwifi_ie_types_header *)((u8 *)header +
+							    sizeof(*header) +
+							    tlv_len);
+	}
+
+	return 0;
+}
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &cmd->params.ax_cmd;
+	u16 cmd_size;
+	struct nxpwifi_11ax_sr_cmd *sr_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+	struct nxpwifi_11ax_beam_cmd *beam_cmd;
+	struct nxpwifi_11ax_htc_cmd *htc_cmd;
+	struct nxpwifi_11ax_txomi_cmd *txmoi_cmd;
+	struct nxpwifi_11ax_toltime_cmd *toltime_cmd;
+	struct nxpwifi_11ax_txop_cmd *txop_cmd;
+	struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd;
+	struct nxpwifi_11ax_llde_cmd *llde_cmd;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		sr_cmd = (struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		beam_cmd = (struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		htc_cmd = (struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		txmoi_cmd =	(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, txmoi_cmd, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		toltime_cmd = (struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		txop_cmd = (struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		set_bsrp_cmd = (struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		llde_cmd = (struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, llde_cmd, sizeof(*llde_cmd));
+		cmd_size += sizeof(*llde_cmd);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &resp->params.ax_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		memcpy(ax_cmd->param.sr_cfg.param.obss_pd_offset.offset,
+		       tlv->data,
+		       ax_cmd->param.sr_cfg.len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		ax_cmd->param.beam_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		ax_cmd->param.htc_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		memcpy(&ax_cmd->param.txomi_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.txomi_cfg));
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		memcpy(&ax_cmd->param.toltime_cfg.tol_time,
+		       he_cmd->val, sizeof(ax_cmd->param.toltime_cfg));
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		memcpy(&ax_cmd->param.txop_cfg.rts_thres,
+		       he_cmd->val, sizeof(ax_cmd->param.txop_cfg));
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		ax_cmd->param.setbsrp_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		memcpy(&ax_cmd->param.llde_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.llde_cfg));
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u8 nxpwifi_is_ap_11ax_twt_supported(struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct element *ext_cap;
+
+	if (!bss_desc->bcn_he_cap)
+		return false;
+	if (!(bss_desc->bcn_he_cap->mac_cap_info[0] & HE_MAC_CAP_TWT_RESP_SUPPORT))
+		return false;
+	if (!bss_desc->bcn_ext_cap)
+		return false;
+	ext_cap = (struct element *)bss_desc->bcn_ext_cap;
+
+	if (!(ext_cap->data[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
+		return false;
+	return true;
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap;
+
+	if (bss_desc && (!nxpwifi_is_ap_11ax_twt_supported(bss_desc))) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "AP don't support twt feature\n");
+		return false;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_he_cap;
+	} else {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_2g_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_2g_he_cap;
+	}
+
+	if (!(hw_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "FW don't support TWT\n");
+		return false;
+	}
+
+	if (!(user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "USER HE_MAC_CAP don't support TWT\n");
+		return false;
+	}
+
+	return true;
+}
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	u8 ret = 0;
+
+	if (ISSUPP_11AXENABLED(priv->adapter->fw_cap_ext) &&
+	    (priv->config_bands & BAND_GAX || priv->config_bands & BAND_AAX)) {
+		if (priv->config_bands & BAND_AAX)
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_he_cap;
+		else
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_2g_he_cap;
+		ret = user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	return ret;
+}
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &cmd->params.twt_cfg;
+	struct nxpwifi_twt_setup *twt_setup;
+	struct nxpwifi_twt_teardown *twt_teardown;
+	struct nxpwifi_twt_report *twt_report;
+	struct nxpwifi_twt_information *twt_information;
+	struct nxpwifi_btwt_ap_config *btwt_ap_config;
+	u8 i;
+	u16 cmd_size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_TWT_CFG);
+	cmd_size = sizeof(struct host_cmd_twt_cfg) + S_DS_GEN;
+
+	twt_cfg_cmd->action = cpu_to_le16(cmd_action);
+	twt_cfg_cmd->sub_id = cpu_to_le16(twt_cfg->sub_id);
+
+	switch (twt_cfg->sub_id) {
+	case NXPWIFI_11AX_TWT_SETUP_SUBID:
+		twt_setup = (struct nxpwifi_twt_setup *)
+			twt_cfg_cmd->val;
+
+		memset(twt_setup, 0x00, sizeof(struct nxpwifi_twt_setup));
+		twt_setup->implicit = twt_cfg->param.twt_setup.implicit;
+		twt_setup->announced = twt_cfg->param.twt_setup.announced;
+		twt_setup->trigger_enabled = twt_cfg->param.twt_setup.trigger_enabled;
+		twt_setup->twt_info_disabled = twt_cfg->param.twt_setup.twt_info_disabled;
+		twt_setup->negotiation_type = twt_cfg->param.twt_setup.negotiation_type;
+		twt_setup->twt_wakeup_duration =
+			twt_cfg->param.twt_setup.twt_wakeup_duration;
+		twt_setup->flow_identifier = twt_cfg->param.twt_setup.flow_identifier;
+		twt_setup->hard_constraint = twt_cfg->param.twt_setup.hard_constraint;
+		twt_setup->twt_exponent = twt_cfg->param.twt_setup.twt_exponent;
+		twt_setup->twt_mantissa = twt_cfg->param.twt_setup.twt_mantissa;
+		twt_setup->twt_request = twt_cfg->param.twt_setup.twt_request;
+		twt_setup->bcn_miss_threshold = twt_cfg->param.twt_setup.bcn_miss_threshold;
+		cmd_size += sizeof(struct nxpwifi_twt_setup);
+		break;
+	case NXPWIFI_11AX_TWT_TEARDOWN_SUBID:
+		twt_teardown = (struct nxpwifi_twt_teardown *)
+			twt_cfg_cmd->val;
+		memset(twt_teardown, 0x00,
+		       sizeof(struct nxpwifi_twt_teardown));
+		twt_teardown->flow_identifier =
+			twt_cfg->param.twt_teardown.flow_identifier;
+		twt_teardown->negotiation_type =
+			twt_cfg->param.twt_teardown.negotiation_type;
+		twt_teardown->teardown_all_twt =
+			twt_cfg->param.twt_teardown.teardown_all_twt;
+		cmd_size += sizeof(struct nxpwifi_twt_teardown);
+		break;
+	case NXPWIFI_11AX_TWT_REPORT_SUBID:
+		twt_report = (struct nxpwifi_twt_report *)
+			twt_cfg_cmd->val;
+		memset(twt_report, 0x00, sizeof(struct nxpwifi_twt_report));
+		twt_report->type = twt_cfg->param.twt_report.type;
+		cmd_size += sizeof(struct nxpwifi_twt_report);
+		break;
+	case NXPWIFI_11AX_TWT_INFORMATION_SUBID:
+		twt_information = (struct nxpwifi_twt_information *)
+			twt_cfg_cmd->val;
+		memset(twt_information, 0x00,
+		       sizeof(struct nxpwifi_twt_information));
+		twt_information->flow_identifier =
+			twt_cfg->param.twt_information.flow_identifier;
+		twt_information->suspend_duration =
+			twt_cfg->param.twt_information.suspend_duration;
+		cmd_size += sizeof(struct nxpwifi_twt_information);
+		break;
+	case NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID:
+		btwt_ap_config = (struct nxpwifi_btwt_ap_config *)
+				 twt_cfg_cmd->val;
+		memset(btwt_ap_config, 0x00,
+		       sizeof(struct nxpwifi_btwt_ap_config));
+		btwt_ap_config->ap_bcast_bet_sta_wait =
+			twt_cfg->param.btwt_ap_config.ap_bcast_bet_sta_wait;
+		btwt_ap_config->ap_bcast_offset =
+			twt_cfg->param.btwt_ap_config.ap_bcast_offset;
+		btwt_ap_config->bcast_twtli =
+			twt_cfg->param.btwt_ap_config.bcast_twtli;
+		btwt_ap_config->count =
+			twt_cfg->param.btwt_ap_config.count;
+		for (i = 0; i < BTWT_AGREEMENT_MAX; i++) {
+			btwt_ap_config->btwt_sets[i].btwt_id =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].btwt_id;
+			btwt_ap_config->btwt_sets[i].ap_bcast_mantissa =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_mantissa;
+			btwt_ap_config->btwt_sets[i].ap_bcast_exponent =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_exponent;
+			btwt_ap_config->btwt_sets[i].nominalwake =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].nominalwake;
+		}
+
+		cmd_size += sizeof(struct nxpwifi_btwt_ap_config);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "Unknown sub id: %d\n", twt_cfg->sub_id);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &resp->params.twt_cfg;
+	u16 action;
+
+	action = le16_to_cpu(twt_cfg_cmd->action);
+	twt_cfg->sub_id = le16_to_cpu(twt_cfg_cmd->sub_id);
+
+	if (action == HOST_ACT_GEN_GET &&
+	    twt_cfg->sub_id == NXPWIFI_11AX_TWT_REPORT_SUBID) {
+		struct nxpwifi_twt_report *twt_report =
+			(struct nxpwifi_twt_report *)twt_cfg_cmd->val;
+
+		memcpy(&twt_cfg->param.twt_report, twt_report, sizeof(struct nxpwifi_twt_report));
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.h b/drivers/net/wireless/nxp/nxpwifi/11ax.h
new file mode 100644
index 000000000000..2eda69f19763
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11ax support
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AX_H_
+#define _NXPWIFI_11AX_H_
+
+/* device support 2.4G 40MHZ */
+#define AX_2G_40MHZ_SUPPORT BIT(1)
+/* device support 2.4G 242 tone RUs */
+#define AX_2G_20MHZ_SUPPORT BIT(5)
+
+/* Get HE MCS map code for n spatial streams (0..3). */
+static inline u16
+nxpwifi_get_he_nss_mcs(__le16 mcs_map_set, int nss) {
+	return ((le16_to_cpu(mcs_map_set) >> (2 * (nss - 1))) & 0x3);
+}
+
+static inline void
+nxpwifi_set_he_nss_mcs(__le16 *mcs_map_set, int nss, int value) {
+	u16 temp;
+
+	temp = le16_to_cpu(*mcs_map_set);
+	temp |= ((value & 0x3) << (2 * (nss - 1)));
+	*mcs_map_set = cpu_to_le16(temp);
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct  nxpwifi_bssdescriptor *bss_desc);
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap);
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc);
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands);
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv);
+
+#endif /* _NXPWIFI_11AX_H_ */
-- 
2.34.1


