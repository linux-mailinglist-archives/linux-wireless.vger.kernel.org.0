Return-Path: <linux-wireless+bounces-9386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F5911D95
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F771C211CA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988AB172BBE;
	Fri, 21 Jun 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GU8wrCfh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2046.outbound.protection.outlook.com [40.107.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE417276D;
	Fri, 21 Jun 2024 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956435; cv=fail; b=YRh7TTP797RSGy+ytqTDtDuez4WSFQyfZxXDVCJ3fK15wezL2ctQ5yOY8q/1kJItQHeE6ZOz5TqKk/aNIIJdgDhirGO8poe0fJ5s7C367e3D9HNkNGY9mo6N/M5Ga8oCnJqYFUs2EoDSDQJnVvUdSaOOp0sHTBNBtO5x22op560=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956435; c=relaxed/simple;
	bh=X+9VxM65+O9aRIiGka3xGpgSCoUHsm6ZFi6q5V1+CxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJCBe7PclQYSH4u3fVZsvFMeIaBh4CtACs6a5mwev32mQziknstry3wnSfoTkp7IEsD+kNp70ZVJhRPuzvhkMNSnqZye/z+thiSFfAt+c+mZC9eGktu1ZMN+Z4SlFDNx0O8u61ToSNwWGcsbJJpMdcSM+0cg5jh0C6QWHulSvEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GU8wrCfh; arc=fail smtp.client-ip=40.107.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuceImCKFy0K1eIZaJjzgdQ+h9gYzJ9Z1G+jienYf3OUI78O78sf0NjIlIbe4xSCcp5+gyFLe5g7tTAIhXgdM5+W/B6//UAdUBkECnimw9L3DyfgGXQiXJW50r+q7NVZJGNtk3Z0EqwweLqcTFd2nW2fXcNux2bnkk3gqXbW8Ndojm9pC/Dt+k7FB/tjw6WxEZMf+lVhY0ZMQgpPj0fpZtOhZyV+t8t2g/z7PzlSPF1ZxoYZLNrvRbuUNNoXl5fcTVPO/xoAYVUKfuFJPstl+oIUg6VX958Px3/KLsNrLyUqYJiVvgoR023f7/8iq0t/kcXMjnM2OoA+k3YHiPGAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=491aHzeYwgNPJtrgU9rlL8s0tBKa++vzVk9oOfO/2mc=;
 b=WX+MEH347sKG+RYrPBF1wAOwLkg5ZbpC/nONU6onnWcITAOJANGQnBqD20bE4btbO0mqxcVphnO1A4NYiXvQ4NTHwlrbM2K8nz4e0wKdFj/dMiVRxDHGEbNfiTh2/RS+nRLZl8cVIRGnOPb0ejkGyy3afQdUjk92yDiBrUjLehy/kR7W3D8ybZayOmWAJzGGcMW/3fkqqZ+A/BBrLccgKEUwgKFnML+DRQUbXjRN9ePtEkE9r+V/a8sCC8RCwvfkBMMNhy4xmJYJro6imSmMeRHk7h3c8Xvbjw3TaNrP0jnSF9LN+7b/I/A/zZTyHePgzzqcpKlzBEq63UFxpg8kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=491aHzeYwgNPJtrgU9rlL8s0tBKa++vzVk9oOfO/2mc=;
 b=GU8wrCfhZhwy26YpbpRw+wEHdAUE8a3ceZHvQAxOO1itam7Hd/gtO6B3OdSRSsy9MK4gdpVtbIZFBG1u2GM1OQFOO2aeoaaK1yB26nhbd2kEy3MNfeoFoClmU/WfwkNZE18pcL8G3KjlLQzOzK6NJqtOcpUvLGmsIUY2njEIxxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:53:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:47 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 22/43] wifi: nxpwifi: add join.c
Date: Fri, 21 Jun 2024 15:51:47 +0800
Message-Id: <20240621075208.513497-23-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 59dbe823-9fc3-4713-d87c-08dc91c7481e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZAdab7D/xsRr0Xogj4Hy6aUc3tapKXGOb20Kh8Y5zgB4Gy4Y0QW+hI/5FCQ?=
 =?us-ascii?Q?qinZ/uuueWcDvZnTz+R+/cARB5vbO024nZtdaiAorhZLXGOYCZJjuN9/0GBV?=
 =?us-ascii?Q?RH2gjbT1iMb0jjsEti4hnAoT1Aa83SP82zzwMcFVnmfPDjZHWEuon8vR4Oek?=
 =?us-ascii?Q?402SXsh/yi2YhAVV/XrjYfTbykGShkWt1wdAcv/NA41nMjfLXGP2lZ1wkT8p?=
 =?us-ascii?Q?eZJ9fQsDNZZljoAy9wX3sYrn+O0vpaFk651XtSAmERr+6e0JtdMRjntlSilC?=
 =?us-ascii?Q?PS1I2sCzrY5uRzzFioMY7ynTJJh6koB2ITodJwpMW7TNj28s/uf1VXxfQfMB?=
 =?us-ascii?Q?YSn+GiJpCQPNh/8AAEJ+ZYjyiU/tEmByhIlTs+3BZktvQFccSN01hfRn8FqS?=
 =?us-ascii?Q?WGz/4qVx3dIQTXTj/fmciCOy9Mh8OfuOk6BEid0jlD1X8Bkt3kJjZEknaCxh?=
 =?us-ascii?Q?8s45+DA+hxynm/t1cdZk0BwHN7asE0wqUk6lOdGjlQKprYkWwW2vmGzXaF+m?=
 =?us-ascii?Q?bCOSyssVQB+hLM0sMg7vA1SmRgEnUbKkJqrrKZ8S23117FADFyln9dMLp944?=
 =?us-ascii?Q?tXz3lk5zOLKtXKwak34NjrN8jdurS5v27f+o6IVEL0kOHujAgV2syTbSZFgl?=
 =?us-ascii?Q?a8t0nI25HBdJtH/5eVLxsEgMAlE3A3vKJt9TOoNY9+I7daJjcPgV+OXa4w9W?=
 =?us-ascii?Q?1osHz/e1ZuI0jRk1/N+7ozGQcEsWnOUhHwong+MdW49OYfESbnsZdpAsegjh?=
 =?us-ascii?Q?Iq+oFzwrRdh5iP73+fI8pgJOaVyx7XYW8max/U0Op5c6p75SJr3jbyvCox7F?=
 =?us-ascii?Q?jK0gKox3e4yEj5A/N7XQneRnAWrga6cm7yr9vOTIT8SM4aJ9niqEOnj21KiH?=
 =?us-ascii?Q?p1NhR2zxOltfebNynV6SROGp45LjvUEky4GapTkIvG01KdMmn3HcDWRrTaM4?=
 =?us-ascii?Q?8KeGvzYZe16HGT1BoigaLkX98bA0exVTsqVYg6E29BfsjQKdyqPDn7q+Hid/?=
 =?us-ascii?Q?GQhX64JeN9hf77fRdPy/vHhNSf3NQWiXoQosKPeNrsOg1P+laqV7KVJioDCn?=
 =?us-ascii?Q?c4xpC6jv7UZD6QhzivJ1GMa9L9R+laJsgtQw+I2GilwrCnrnpY86S8Sb1DwH?=
 =?us-ascii?Q?zSSMu10tJwSLuZdwsmZ/i5UDc18K1KXJA5JydhgyGGZO5S8Joe5vcV+/SVJB?=
 =?us-ascii?Q?BcmgbTwIGKGy79zeuL0m4+MrUIZNLMbN3mqKBpBrt0KICQlQDfIDSLTjpF4+?=
 =?us-ascii?Q?byyYEc0EggjvhvM4SE8+NjDixeaQUtS3k7/z3Kqy95TVZDTItqOX3CqSqvWz?=
 =?us-ascii?Q?aMARGQ+Pdqj+Ka2vb+btpKvGIGg9FFYisCAqVJyGTIiXK9kN9s8RpuxjYNCu?=
 =?us-ascii?Q?BmWJINQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CcU8hykDo/4gp5+YP/ZmVHseQd0nJBVKr2oAYLXZIcfom5I+LmP11RaY9q3q?=
 =?us-ascii?Q?TRTInA5NoLSbkfgXX6KJErqGkMHCwbJoB2Cz76IlR8IBELFeZqM1nc+fRWvL?=
 =?us-ascii?Q?XfDXOCvCQNRmYF5rKMYbG2ERd2Wh398LWp3RHGWsZ/HLBsXzHrZhJiMvWH3w?=
 =?us-ascii?Q?JI96Gy6KstmxouEaQkNylHHDCy83n8TMSRVUPT+YVvD+iPiGjw9D+VmfbCzd?=
 =?us-ascii?Q?RTY0QuMT4HXq22Deiaj08KFsAu0EIFF389hl23foYtTsVuLbJAZQXDhBshuN?=
 =?us-ascii?Q?ZYtz0YgDhPwK+FLyv8FexRsBaKK1LILqiHPc/7tVDgi25jp7H8Vfroey2tDl?=
 =?us-ascii?Q?+5+CQTBoW9FXFixm6FjiffzhggeMDFkVproNW1r6G9cWbhKPtosRBtIv1T37?=
 =?us-ascii?Q?lIa5hJQ+2C7YtEIwuxOnHoHVoRj4+yjkXiHik5WAandTUnJD/myMNfkerO91?=
 =?us-ascii?Q?apn+Uq4YPTJu6UGE5qaJTkOjXtlZ3dMIpfG69r489cQDh5MsNBmX3yJOKNdg?=
 =?us-ascii?Q?WIWsE2IaW89LUle3IGfPhOlT3s+CfSDQ54OBtdldfdkloc9ag2wb2fH1314x?=
 =?us-ascii?Q?zt7gZJxLqsDAKuULDDAmrKhU+2K6vQgvT2rY2XvuBoQPmZqSLGniO/doCkRz?=
 =?us-ascii?Q?j27e9AMuuDDmrYGl9NOcYPkTrF0R3sU1Y8gV7Xob6SeKlTXDa1Xi1qq0kbsW?=
 =?us-ascii?Q?2JPCD3ZDBlmchRbdnZTpPE6RXub0UyhzszwUqH4305KcqaAaEK2eRvX/ZFtp?=
 =?us-ascii?Q?hOX9PtHvH3jEqogulzAPxbF9RmVr03MhbpqL/xYXYpNzMbK37eaEDT47SXmC?=
 =?us-ascii?Q?K2jkixSGn9so8eA64dJ49PEcjtWrINeoV6ADXT+zYECdVFjTkbymw8eXtTr3?=
 =?us-ascii?Q?8Ssv85OsszxIZkKnRfjVa4jPxv9dKChzI7X+CgdyV3eETJC4qzYilikDOYmM?=
 =?us-ascii?Q?ArKTuMZEyIVOP5QBVNlN2KP951KpvWmAZczjRlLY9axRBa1DfbbciIdHOEcF?=
 =?us-ascii?Q?jYwOoTPsOMDMv7UfR4uJSKgAOFFYgONHv96ZU4GPGgSP0Jku1pBL8RSazi0I?=
 =?us-ascii?Q?xu19/cyAyxntOjoOtRkQzpq6RN60PcIhDnfAzB1E+qX3J1qwQq0/zKqEomWm?=
 =?us-ascii?Q?yd14X94mxpewSVa6vf7vgJ5dbdoa/xy/Vilgg9SSfSi0jBds/EECwMbgCfGU?=
 =?us-ascii?Q?dZ6Q/PHeLa42xOb7QPLjWtSWSqEbGJQfwoX9eHfRa1q839RKFygKgGtjXO/J?=
 =?us-ascii?Q?Jm2YDcqhcSKoUKXx5Ze7iHuP8O1H/u1GfJBmVcjicG0qQIb22pKqsbK7vnv7?=
 =?us-ascii?Q?BvaY/W9/PD+PDBRVA2DC3O5K6h51N3m/1j8H5A+PyOU2wcjZEeLo+M6uzw39?=
 =?us-ascii?Q?Bw3f2wSD9WT3FSZee3g6krCQ5A6s2S5/1HytZipaytv5UGv4phQ3H94XCYE7?=
 =?us-ascii?Q?HxvACEQIFn2gdTjQOYHFXbV3ZiWTnwgeMogZioBh5xBJqZ1r0IlSD6ZI6fLP?=
 =?us-ascii?Q?Ed41Xw9+tW5WObhl4DLzpfd0lLsCH05J9YYq0XZBpgY4xh+pUe6fL0b76tPh?=
 =?us-ascii?Q?9t3Uyxe3TLqPQwts2Hg0ZtDK9+WN36xzvCmZEk3d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dbe823-9fc3-4713-d87c-08dc91c7481e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:47.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfOAYJ3DY3OcnaqcJ3Oz9fqlV+YCofTDs9HWevP7kgenIr8vsUOXPQnwiQ/XidH1mRPYUgGcXBBu3TIJIGsGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/join.c | 910 ++++++++++++++++++++++++
 1 file changed, 910 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/join.c b/drivers/net/wireless/nxp/nxpwifi/join.c
new file mode 100644
index 000000000000..a492821dd87a
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/join.c
@@ -0,0 +1,910 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: association and ad-hoc start/join
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+#include "11ac.h"
+
+#define CAPINFO_MASK    (~(BIT(15) | BIT(14) | BIT(12) | BIT(11) | BIT(9)))
+
+/* Append a generic IE as a pass through TLV to a TLV buffer.
+ *
+ * This function is called from the network join command preparation routine.
+ *
+ * If the IE buffer has been setup by the application, this routine appends
+ * the buffer as a pass through TLV type to the request.
+ */
+static int
+nxpwifi_cmd_append_generic_ie(struct nxpwifi_private *priv, u8 **buffer)
+{
+	int ret_len = 0;
+	struct nxpwifi_ie_types_header ie_header;
+
+	/* Null Checks */
+	if (!buffer)
+		return 0;
+	if (!(*buffer))
+		return 0;
+
+	/* If there is a generic ie buffer setup, append it to the return
+	 *   parameter buffer pointer.
+	 */
+	if (priv->gen_ie_buf_len) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: %s: append generic ie len %d to %p\n",
+			    __func__, priv->gen_ie_buf_len, *buffer);
+
+		/* Wrap the generic IE buffer with a pass through TLV type */
+		ie_header.type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+		ie_header.len = cpu_to_le16(priv->gen_ie_buf_len);
+		memcpy(*buffer, &ie_header, sizeof(ie_header));
+
+		/* Increment the return size and the return buffer pointer
+		 * param
+		 */
+		*buffer += sizeof(ie_header);
+		ret_len += sizeof(ie_header);
+
+		/* Copy the generic IE buffer to the output buffer, advance
+		 * pointer
+		 */
+		memcpy(*buffer, priv->gen_ie_buf, priv->gen_ie_buf_len);
+
+		/* Increment the return size and the return buffer pointer
+		 * param
+		 */
+		*buffer += priv->gen_ie_buf_len;
+		ret_len += priv->gen_ie_buf_len;
+
+		/* Reset the generic IE buffer */
+		priv->gen_ie_buf_len = 0;
+	}
+
+	/* return the length appended to the buffer */
+	return ret_len;
+}
+
+/* Append TSF tracking info from the scan table for the target AP.
+ *
+ * This function is called from the network join command preparation routine.
+ *
+ * The TSF table TSF sent to the firmware contains two TSF values:
+ *      - The TSF of the target AP from its previous beacon/probe response
+ *      - The TSF timestamp of our local MAC at the time we observed the
+ *        beacon/probe response.
+ *
+ * The firmware uses the timestamp values to set an initial TSF value
+ * in the MAC for the new association after a reassociation attempt.
+ */
+static int
+nxpwifi_cmd_append_tsf_tlv(struct nxpwifi_private *priv, u8 **buffer,
+			   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_tsf_timestamp tsf_tlv;
+	__le64 tsf_val;
+
+	/* Null Checks */
+	if (!buffer)
+		return 0;
+	if (!*buffer)
+		return 0;
+
+	memset(&tsf_tlv, 0x00, sizeof(struct nxpwifi_ie_types_tsf_timestamp));
+
+	tsf_tlv.header.type = cpu_to_le16(TLV_TYPE_TSFTIMESTAMP);
+	tsf_tlv.header.len = cpu_to_le16(2 * sizeof(tsf_val));
+
+	memcpy(*buffer, &tsf_tlv, sizeof(tsf_tlv.header));
+	*buffer += sizeof(tsf_tlv.header);
+
+	/* TSF at the time when beacon/probe_response was received */
+	tsf_val = cpu_to_le64(bss_desc->fw_tsf);
+	memcpy(*buffer, &tsf_val, sizeof(tsf_val));
+	*buffer += sizeof(tsf_val);
+
+	tsf_val = cpu_to_le64(bss_desc->timestamp);
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: %s: TSF offset calc: %016llx - %016llx\n",
+		    __func__, bss_desc->timestamp, bss_desc->fw_tsf);
+
+	memcpy(*buffer, &tsf_val, sizeof(tsf_val));
+	*buffer += sizeof(tsf_val);
+
+	return sizeof(tsf_tlv.header) + (2 * sizeof(tsf_val));
+}
+
+/* This function finds out the common rates between rate1 and rate2.
+ *
+ * It will fill common rates in rate1 as output if found.
+ *
+ * NOTE: Setting the MSB of the basic rates needs to be taken
+ * care of, either before or after calling this function.
+ */
+static int nxpwifi_get_common_rates(struct nxpwifi_private *priv, u8 *rate1,
+				    u32 rate1_size, u8 *rate2, u32 rate2_size)
+{
+	int ret;
+	u8 *ptr = rate1, *tmp;
+	u32 i, j;
+
+	tmp = kmemdup(rate1, rate1_size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	memset(rate1, 0, rate1_size);
+
+	for (i = 0; i < rate2_size && rate2[i]; i++) {
+		for (j = 0; j < rate1_size && tmp[j]; j++) {
+			/* Check common rate, excluding the bit for
+			 * basic rate
+			 */
+			if ((rate2[i] & 0x7F) == (tmp[j] & 0x7F)) {
+				*rate1++ = tmp[j];
+				break;
+			}
+		}
+	}
+
+	nxpwifi_dbg(priv->adapter, INFO, "info: Tx data rate set to %#x\n",
+		    priv->data_rate);
+
+	if (!priv->is_data_rate_auto) {
+		while (*ptr) {
+			if ((*ptr & 0x7f) == priv->data_rate) {
+				ret = 0;
+				goto done;
+			}
+			ptr++;
+		}
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "previously set fixed data rate %#x\t"
+			    "is not compatible with the network\n",
+			    priv->data_rate);
+
+		ret = -1;
+		goto done;
+	}
+
+	ret = 0;
+done:
+	kfree(tmp);
+	return ret;
+}
+
+/* This function creates the intersection of the rates supported by a
+ * target BSS and our adapter settings for use in an assoc/join command.
+ */
+static int
+nxpwifi_setup_rates_from_bssdesc(struct nxpwifi_private *priv,
+				 struct nxpwifi_bssdescriptor *bss_desc,
+				 u8 *out_rates, u32 *out_rates_size)
+{
+	u8 card_rates[NXPWIFI_SUPPORTED_RATES];
+	u32 card_rates_size;
+
+	/* Copy AP supported rates */
+	memcpy(out_rates, bss_desc->supported_rates, NXPWIFI_SUPPORTED_RATES);
+	/* Get the STA supported rates */
+	card_rates_size = nxpwifi_get_active_data_rates(priv, card_rates);
+	/* Get the common rates between AP and STA supported rates */
+	if (nxpwifi_get_common_rates(priv, out_rates, NXPWIFI_SUPPORTED_RATES,
+				     card_rates, card_rates_size)) {
+		*out_rates_size = 0;
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot get common rates\n",
+			    __func__);
+		return -1;
+	}
+
+	*out_rates_size =
+		min_t(size_t, strlen(out_rates), NXPWIFI_SUPPORTED_RATES);
+
+	return 0;
+}
+
+/* This function appends a WPS IE. It is called from the network join command
+ * preparation routine.
+ *
+ * If the IE buffer has been setup by the application, this routine appends
+ * the buffer as a WPS TLV type to the request.
+ */
+static int
+nxpwifi_cmd_append_wps_ie(struct nxpwifi_private *priv, u8 **buffer)
+{
+	int ret_len = 0;
+	struct nxpwifi_ie_types_header ie_header;
+
+	if (!buffer || !*buffer)
+		return 0;
+
+	/* If there is a wps ie buffer setup, append it to the return
+	 * parameter buffer pointer.
+	 */
+	if (priv->wps_ie_len) {
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: append wps ie %d to %p\n",
+			    priv->wps_ie_len, *buffer);
+
+		/* Wrap the generic IE buffer with a pass through TLV type */
+		ie_header.type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+		ie_header.len = cpu_to_le16(priv->wps_ie_len);
+		memcpy(*buffer, &ie_header, sizeof(ie_header));
+		*buffer += sizeof(ie_header);
+		ret_len += sizeof(ie_header);
+
+		memcpy(*buffer, priv->wps_ie, priv->wps_ie_len);
+		*buffer += priv->wps_ie_len;
+		ret_len += priv->wps_ie_len;
+	}
+
+	kfree(priv->wps_ie);
+	priv->wps_ie_len = 0;
+	return ret_len;
+}
+
+/* This function appends rsn ie tlv for wpa/wpa2 security modes.
+ * It is called from the network join command preparation routine.
+ */
+static int nxpwifi_append_rsn_ie_wpa_wpa2(struct nxpwifi_private *priv,
+					  u8 **buffer)
+{
+	struct nxpwifi_ie_types_rsn_param_set *rsn_ie_tlv;
+	int rsn_ie_len;
+
+	if (!buffer || !(*buffer))
+		return 0;
+
+	rsn_ie_tlv = (struct nxpwifi_ie_types_rsn_param_set *)(*buffer);
+	rsn_ie_tlv->header.type = cpu_to_le16((u16)priv->wpa_ie[0]);
+	rsn_ie_tlv->header.type =
+		cpu_to_le16(le16_to_cpu(rsn_ie_tlv->header.type) & 0x00FF);
+	rsn_ie_tlv->header.len = cpu_to_le16((u16)priv->wpa_ie[1]);
+	rsn_ie_tlv->header.len = cpu_to_le16(le16_to_cpu(rsn_ie_tlv->header.len)
+							 & 0x00FF);
+	if (le16_to_cpu(rsn_ie_tlv->header.len) <= (sizeof(priv->wpa_ie) - 2))
+		memcpy(rsn_ie_tlv->rsn_ie, &priv->wpa_ie[2],
+		       le16_to_cpu(rsn_ie_tlv->header.len));
+	else
+		return -1;
+
+	rsn_ie_len = sizeof(rsn_ie_tlv->header) +
+					le16_to_cpu(rsn_ie_tlv->header.len);
+	*buffer += rsn_ie_len;
+
+	return rsn_ie_len;
+}
+
+/* This function prepares command for association.
+ *
+ * This sets the following parameters -
+ *      - Peer MAC address
+ *      - Listen interval
+ *      - Beacon interval
+ *      - Capability information
+ *
+ * ...and the following TLVs, as required -
+ *      - SSID TLV
+ *      - PHY TLV
+ *      - SS TLV
+ *      - Rates TLV
+ *      - Authentication TLV
+ *      - Channel TLV
+ *      - WPA/WPA2 IE
+ *      - 11n TLV
+ *      - Vendor specific TLV
+ *      - WMM TLV
+ *      - Generic IE
+ *      - TSF TLV
+ *
+ * Preparation also includes -
+ *      - Setting command ID and proper size
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct host_cmd_ds_802_11_associate *assoc = &cmd->params.associate;
+	struct nxpwifi_ie_types_host_mlme *host_mlme_tlv;
+	struct nxpwifi_ie_types_ssid_param_set *ssid_tlv;
+	struct nxpwifi_ie_types_phy_param_set *phy_tlv;
+	struct nxpwifi_ie_types_ss_param_set *ss_tlv;
+	struct nxpwifi_ie_types_rates_param_set *rates_tlv;
+	struct nxpwifi_ie_types_auth_type *auth_tlv;
+	struct nxpwifi_ie_types_sae_pwe_mode *sae_pwe_tlv;
+	struct nxpwifi_ie_types_chan_list_param_set *chan_tlv;
+	u8 rates[NXPWIFI_SUPPORTED_RATES];
+	u32 rates_size;
+	u16 tmp_cap;
+	u8 *pos;
+	int rsn_ie_len = 0;
+
+	pos = (u8 *)assoc;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_ASSOCIATE);
+
+	/* Save so we know which BSS Desc to use in the response handler */
+	priv->attempted_bss_desc = bss_desc;
+
+	memcpy(assoc->peer_sta_addr,
+	       bss_desc->mac_address, sizeof(assoc->peer_sta_addr));
+	pos += sizeof(assoc->peer_sta_addr);
+
+	/* Set the listen interval */
+	assoc->listen_interval = cpu_to_le16(priv->listen_interval);
+	/* Set the beacon period */
+	assoc->beacon_period = cpu_to_le16(bss_desc->beacon_period);
+
+	pos += sizeof(assoc->cap_info_bitmap);
+	pos += sizeof(assoc->listen_interval);
+	pos += sizeof(assoc->beacon_period);
+	pos += sizeof(assoc->dtim_period);
+
+	host_mlme_tlv = (struct nxpwifi_ie_types_host_mlme *)pos;
+	host_mlme_tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+	host_mlme_tlv->header.len = cpu_to_le16(sizeof(host_mlme_tlv->host_mlme));
+	host_mlme_tlv->host_mlme = 1;
+	pos += sizeof(host_mlme_tlv->header) + sizeof(host_mlme_tlv->host_mlme);
+
+	ssid_tlv = (struct nxpwifi_ie_types_ssid_param_set *)pos;
+	ssid_tlv->header.type = cpu_to_le16(WLAN_EID_SSID);
+	ssid_tlv->header.len = cpu_to_le16((u16)bss_desc->ssid.ssid_len);
+	memcpy(ssid_tlv->ssid, bss_desc->ssid.ssid,
+	       le16_to_cpu(ssid_tlv->header.len));
+	pos += sizeof(ssid_tlv->header) + le16_to_cpu(ssid_tlv->header.len);
+
+	phy_tlv = (struct nxpwifi_ie_types_phy_param_set *)pos;
+	phy_tlv->header.type = cpu_to_le16(WLAN_EID_DS_PARAMS);
+	phy_tlv->header.len = cpu_to_le16(sizeof(phy_tlv->fh_ds.ds_param_set));
+	memcpy(&phy_tlv->fh_ds.ds_param_set,
+	       &bss_desc->phy_param_set.ds_param_set.current_chan,
+	       sizeof(phy_tlv->fh_ds.ds_param_set));
+	pos += sizeof(phy_tlv->header) + le16_to_cpu(phy_tlv->header.len);
+
+	ss_tlv = (struct nxpwifi_ie_types_ss_param_set *)pos;
+	ss_tlv->header.type = cpu_to_le16(WLAN_EID_CF_PARAMS);
+	ss_tlv->header.len = cpu_to_le16(sizeof(ss_tlv->cf_ibss.cf_param_set));
+	pos += sizeof(ss_tlv->header) + le16_to_cpu(ss_tlv->header.len);
+
+	/* Get the common rates supported between the driver and the BSS Desc */
+	if (nxpwifi_setup_rates_from_bssdesc
+	    (priv, bss_desc, rates, &rates_size))
+		return -1;
+
+	/* Save the data rates into Current BSS state structure */
+	priv->curr_bss_params.num_of_rates = rates_size;
+	memcpy(&priv->curr_bss_params.data_rates, rates, rates_size);
+
+	/* Setup the Rates TLV in the association command */
+	rates_tlv = (struct nxpwifi_ie_types_rates_param_set *)pos;
+	rates_tlv->header.type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+	rates_tlv->header.len = cpu_to_le16((u16)rates_size);
+	memcpy(rates_tlv->rates, rates, rates_size);
+	pos += sizeof(rates_tlv->header) + rates_size;
+	nxpwifi_dbg(priv->adapter, INFO, "info: ASSOC_CMD: rates size = %d\n",
+		    rates_size);
+
+	/* Add the Authentication type */
+	auth_tlv = (struct nxpwifi_ie_types_auth_type *)pos;
+	auth_tlv->header.type = cpu_to_le16(TLV_TYPE_AUTH_TYPE);
+	auth_tlv->header.len = cpu_to_le16(sizeof(auth_tlv->auth_type));
+	if (priv->sec_info.wep_enabled)
+		auth_tlv->auth_type =
+			cpu_to_le16((u16)priv->sec_info.authentication_mode);
+	else
+		auth_tlv->auth_type = cpu_to_le16(NL80211_AUTHTYPE_OPEN_SYSTEM);
+
+	pos += sizeof(auth_tlv->header) + le16_to_cpu(auth_tlv->header.len);
+
+	if (priv->sec_info.authentication_mode == WLAN_AUTH_SAE) {
+		auth_tlv->auth_type = cpu_to_le16(NXPWIFI_AUTHTYPE_SAE);
+		if (bss_desc->bcn_rsnx_ie &&
+		    bss_desc->bcn_rsnx_ie->ieee_hdr.len &&
+		    (bss_desc->bcn_rsnx_ie->data[0] &
+		     WLAN_RSNX_CAPA_SAE_H2E)) {
+			sae_pwe_tlv =
+				(struct nxpwifi_ie_types_sae_pwe_mode *)pos;
+			sae_pwe_tlv->header.type =
+				cpu_to_le16(TLV_TYPE_SAE_PWE_MODE);
+			sae_pwe_tlv->header.len =
+				cpu_to_le16(sizeof(sae_pwe_tlv->pwe[0]));
+			sae_pwe_tlv->pwe[0] = bss_desc->bcn_rsnx_ie->data[0];
+			pos += sizeof(sae_pwe_tlv->header) +
+				sizeof(sae_pwe_tlv->pwe[0]);
+		}
+	}
+
+	if (IS_SUPPORT_MULTI_BANDS(priv->adapter) &&
+	    !(ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n &&
+	    (priv->adapter->config_bands & BAND_GN ||
+	     priv->adapter->config_bands & BAND_AN) &&
+	    bss_desc->bcn_ht_cap)) {
+		/* Append a channel TLV for the channel the attempted AP was
+		 * found on
+		 */
+		chan_tlv = (struct nxpwifi_ie_types_chan_list_param_set *)pos;
+		chan_tlv->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
+		chan_tlv->header.len =
+			cpu_to_le16(sizeof(struct nxpwifi_chan_scan_param_set));
+
+		memset(chan_tlv->chan_scan_param, 0x00,
+		       sizeof(struct nxpwifi_chan_scan_param_set));
+		chan_tlv->chan_scan_param[0].chan_number =
+			(bss_desc->phy_param_set.ds_param_set.current_chan);
+		nxpwifi_dbg(priv->adapter, INFO, "info: Assoc: TLV Chan = %d\n",
+			    chan_tlv->chan_scan_param[0].chan_number);
+
+		chan_tlv->chan_scan_param[0].radio_type =
+			nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+
+		nxpwifi_dbg(priv->adapter, INFO, "info: Assoc: TLV Band = %d\n",
+			    chan_tlv->chan_scan_param[0].radio_type);
+		pos += sizeof(chan_tlv->header) +
+			sizeof(struct nxpwifi_chan_scan_param_set);
+	}
+
+	if (!priv->wps.session_enable) {
+		if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
+			rsn_ie_len = nxpwifi_append_rsn_ie_wpa_wpa2(priv, &pos);
+
+		if (rsn_ie_len == -1)
+			return -1;
+	}
+
+	if (ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n &&
+	    (priv->adapter->config_bands & BAND_GN ||
+	     priv->adapter->config_bands & BAND_AN))
+		nxpwifi_cmd_append_11n_tlv(priv, bss_desc, &pos);
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n && !bss_desc->disable_11ac &&
+	    priv->adapter->config_bands & BAND_AAC)
+		nxpwifi_cmd_append_11ac_tlv(priv, bss_desc, &pos);
+
+	/* Append vendor specific IE TLV */
+	nxpwifi_cmd_append_vsie_tlv(priv, NXPWIFI_VSIE_MASK_ASSOC, &pos);
+
+	nxpwifi_wmm_process_association_req(priv, &pos, &bss_desc->wmm_ie,
+					    bss_desc->bcn_ht_cap);
+
+	if (priv->wps.session_enable && priv->wps_ie_len)
+		nxpwifi_cmd_append_wps_ie(priv, &pos);
+
+	nxpwifi_cmd_append_generic_ie(priv, &pos);
+
+	nxpwifi_cmd_append_tsf_tlv(priv, &pos, bss_desc);
+
+	nxpwifi_11h_process_join(priv, &pos, bss_desc);
+
+	cmd->size = cpu_to_le16((u16)(pos - (u8 *)assoc) + S_DS_GEN);
+
+	/* Set the Capability info at last */
+	tmp_cap = bss_desc->cap_info_bitmap;
+
+	if (priv->adapter->config_bands == BAND_B)
+		tmp_cap &= ~WLAN_CAPABILITY_SHORT_SLOT_TIME;
+
+	tmp_cap &= CAPINFO_MASK;
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: ASSOC_CMD: tmp_cap=%4X CAPINFO_MASK=%4lX\n",
+		    tmp_cap, CAPINFO_MASK);
+	assoc->cap_info_bitmap = cpu_to_le16(tmp_cap);
+
+	return 0;
+}
+
+static const char *assoc_failure_reason_to_str(u16 cap_info)
+{
+	switch (cap_info) {
+	case CONNECT_ERR_AUTH_ERR_STA_FAILURE:
+		return "CONNECT_ERR_AUTH_ERR_STA_FAILURE";
+	case CONNECT_ERR_AUTH_MSG_UNHANDLED:
+		return "CONNECT_ERR_AUTH_MSG_UNHANDLED";
+	case CONNECT_ERR_ASSOC_ERR_TIMEOUT:
+		return "CONNECT_ERR_ASSOC_ERR_TIMEOUT";
+	case CONNECT_ERR_ASSOC_ERR_AUTH_REFUSED:
+		return "CONNECT_ERR_ASSOC_ERR_AUTH_REFUSED";
+	case CONNECT_ERR_STA_FAILURE:
+		return "CONNECT_ERR_STA_FAILURE";
+	}
+
+	return "Unknown connect failure";
+}
+
+/* Association firmware command response handler
+ *
+ * The response buffer for the association command has the following
+ * memory layout.
+ *
+ * For cases where an association response was not received (indicated
+ * by the CapInfo and AId field):
+ *
+ *     .------------------------------------------------------------.
+ *     |  Header(4 * sizeof(t_u16)):  Standard command response hdr |
+ *     .------------------------------------------------------------.
+ *     |  cap_info/Error Return(t_u16):                             |
+ *     |           0xFFFF(-1): Internal error                       |
+ *     |           0xFFFE(-2): Authentication unhandled message     |
+ *     |           0xFFFD(-3): Authentication refused               |
+ *     |           0xFFFC(-4): Timeout waiting for AP response      |
+ *     .------------------------------------------------------------.
+ *     |  status_code(t_u16):                                       |
+ *     |        If cap_info is -1:                                  |
+ *     |           An internal firmware failure prevented the       |
+ *     |           command from being processed.  The status_code   |
+ *     |           will be set to 1.                                |
+ *     |                                                            |
+ *     |        If cap_info is -2:                                  |
+ *     |           An authentication frame was received but was     |
+ *     |           not handled by the firmware.  IEEE Status        |
+ *     |           code for the failure is returned.                |
+ *     |                                                            |
+ *     |        If cap_info is -3:                                  |
+ *     |           An authentication frame was received and the     |
+ *     |           status_code is the IEEE Status reported in the   |
+ *     |           response.                                        |
+ *     |                                                            |
+ *     |        If cap_info is -4:                                  |
+ *     |           (1) Association response timeout                 |
+ *     |           (2) Authentication response timeout              |
+ *     .------------------------------------------------------------.
+ *     |  a_id(t_u16): 0xFFFF                                       |
+ *     .------------------------------------------------------------.
+ *
+ *
+ * For cases where an association response was received, the IEEE
+ * standard association response frame is returned:
+ *
+ *     .------------------------------------------------------------.
+ *     |  Header(4 * sizeof(t_u16)):  Standard command response hdr |
+ *     .------------------------------------------------------------.
+ *     |  cap_info(t_u16): IEEE Capability                          |
+ *     .------------------------------------------------------------.
+ *     |  status_code(t_u16): IEEE Status Code                      |
+ *     .------------------------------------------------------------.
+ *     |  a_id(t_u16): IEEE Association ID                          |
+ *     .------------------------------------------------------------.
+ *     |  IEEE IEs(variable): Any received IEs comprising the       |
+ *     |                      remaining portion of a received       |
+ *     |                      association response frame.           |
+ *     .------------------------------------------------------------.
+ *
+ * For simplistic handling, the status_code field can be used to determine
+ * an association success (0) or failure (non-zero).
+ */
+int nxpwifi_ret_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct ieee_types_assoc_rsp *assoc_rsp;
+	struct nxpwifi_bssdescriptor *bss_desc;
+	bool enable_data = true;
+	u16 cap_info, status_code, aid;
+	const u8 *ie_ptr;
+	struct ieee80211_ht_operation *assoc_resp_ht_oper;
+	struct ieee80211_mgmt *hdr;
+
+	if (!priv->attempted_bss_desc) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: failed, association terminated by host\n",
+			    __func__);
+		goto done;
+	}
+
+	hdr = (struct ieee80211_mgmt *)&resp->params;
+	if (!memcmp(hdr->bssid, priv->attempted_bss_desc->mac_address,
+		    ETH_ALEN))
+		assoc_rsp = (struct ieee_types_assoc_rsp *)&hdr->u.assoc_resp;
+	else
+		assoc_rsp = (struct ieee_types_assoc_rsp *)&resp->params;
+
+	cap_info = le16_to_cpu(assoc_rsp->cap_info_bitmap);
+	status_code = le16_to_cpu(assoc_rsp->status_code);
+	aid = le16_to_cpu(assoc_rsp->a_id);
+
+	if ((aid & (BIT(15) | BIT(14))) != (BIT(15) | BIT(14)))
+		dev_err(priv->adapter->dev,
+			"invalid AID value 0x%x; bits 15:14 not set\n",
+			aid);
+
+	aid &= ~(BIT(15) | BIT(14));
+
+	priv->assoc_rsp_size = min(le16_to_cpu(resp->size) - S_DS_GEN,
+				   sizeof(priv->assoc_rsp_buf));
+
+	assoc_rsp->a_id = cpu_to_le16(aid);
+	memcpy(priv->assoc_rsp_buf, &resp->params, priv->assoc_rsp_size);
+
+	if (status_code) {
+		priv->adapter->dbg.num_cmd_assoc_failure++;
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "ASSOC_RESP: failed,\t"
+			    "status code=%d err=%#x a_id=%#x\n",
+			    status_code, cap_info,
+			    le16_to_cpu(assoc_rsp->a_id));
+
+		nxpwifi_dbg(priv->adapter, ERROR, "assoc failure: reason %s\n",
+			    assoc_failure_reason_to_str(cap_info));
+		if (cap_info == CONNECT_ERR_ASSOC_ERR_TIMEOUT) {
+			if (status_code == NXPWIFI_ASSOC_CMD_FAILURE_AUTH) {
+				ret = WLAN_STATUS_AUTH_TIMEOUT;
+				nxpwifi_dbg(priv->adapter, ERROR,
+					    "ASSOC_RESP: AUTH timeout\n");
+			} else {
+				ret = WLAN_STATUS_UNSPECIFIED_FAILURE;
+				nxpwifi_dbg(priv->adapter, ERROR,
+					    "ASSOC_RESP: UNSPECIFIED failure\n");
+			}
+
+			priv->assoc_rsp_size = 0;
+		} else {
+			ret = status_code;
+		}
+
+		goto done;
+	}
+
+	/* Send a Media Connected event, according to the Spec */
+	priv->media_connected = true;
+
+	priv->adapter->ps_state = PS_STATE_AWAKE;
+	priv->adapter->pps_uapsd_mode = false;
+	priv->adapter->tx_lock_flag = false;
+
+	/* Set the attempted BSSID Index to current */
+	bss_desc = priv->attempted_bss_desc;
+
+	nxpwifi_dbg(priv->adapter, INFO, "info: ASSOC_RESP: %s\n",
+		    bss_desc->ssid.ssid);
+
+	/* Make a copy of current BSSID descriptor */
+	memcpy(&priv->curr_bss_params.bss_descriptor,
+	       bss_desc, sizeof(struct nxpwifi_bssdescriptor));
+
+	/* Update curr_bss_params */
+	priv->curr_bss_params.bss_descriptor.channel =
+		bss_desc->phy_param_set.ds_param_set.current_chan;
+
+	priv->curr_bss_params.band = (u8)bss_desc->bss_band;
+
+	if (bss_desc->wmm_ie.vend_hdr.element_id == WLAN_EID_VENDOR_SPECIFIC)
+		priv->curr_bss_params.wmm_enabled = true;
+	else
+		priv->curr_bss_params.wmm_enabled = false;
+
+	if ((priv->wmm_required || bss_desc->bcn_ht_cap) &&
+	    priv->curr_bss_params.wmm_enabled)
+		priv->wmm_enabled = true;
+	else
+		priv->wmm_enabled = false;
+
+	priv->curr_bss_params.wmm_uapsd_enabled = false;
+
+	if (priv->wmm_enabled)
+		priv->curr_bss_params.wmm_uapsd_enabled =
+			((bss_desc->wmm_ie.qos_info_bitmap &
+			  IEEE80211_WMM_IE_AP_QOSINFO_UAPSD) ? 1 : 0);
+
+	/* Store the bandwidth information from assoc response */
+	ie_ptr = cfg80211_find_ie(WLAN_EID_HT_OPERATION, assoc_rsp->ie_buffer,
+				  priv->assoc_rsp_size
+				  - sizeof(struct ieee_types_assoc_rsp));
+	if (ie_ptr) {
+		assoc_resp_ht_oper = (struct ieee80211_ht_operation *)(ie_ptr
+					+ sizeof(struct ieee_types_header));
+		priv->assoc_resp_ht_param = assoc_resp_ht_oper->ht_param;
+		priv->ht_param_present = true;
+	} else {
+		priv->ht_param_present = false;
+	}
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: ASSOC_RESP: curr_pkt_filter is %#x\n",
+		    priv->curr_pkt_filter);
+	if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
+		priv->wpa_is_gtk_set = false;
+
+	if (priv->wmm_enabled) {
+		/* Don't re-enable carrier until we get the WMM_GET_STATUS
+		 * event
+		 */
+		enable_data = false;
+	} else {
+		/* Since WMM is not enabled, setup the queues with the
+		 * defaults
+		 */
+		nxpwifi_wmm_setup_queue_priorities(priv, NULL);
+		nxpwifi_wmm_setup_ac_downgrade(priv);
+	}
+
+	if (enable_data)
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: post association, re-enabling data flow\n");
+
+	/* Reset SNR/NF/RSSI values */
+	priv->data_rssi_last = 0;
+	priv->data_nf_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_nf_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->rxpd_rate = 0;
+	priv->rxpd_htinfo = 0;
+
+	nxpwifi_save_curr_bcn(priv);
+
+	priv->adapter->dbg.num_cmd_assoc_success++;
+
+	nxpwifi_dbg(priv->adapter, MSG, "assoc: associated with %pM\n",
+		    priv->attempted_bss_desc->mac_address);
+
+	/* Add the ra_list here for infra mode as there will be only 1 ra
+	 * always
+	 */
+	nxpwifi_ralist_add(priv,
+			   priv->curr_bss_params.bss_descriptor.mac_address);
+
+	if (!netif_carrier_ok(priv->netdev))
+		netif_carrier_on(priv->netdev);
+	nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+
+	if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
+		priv->scan_block = true;
+	else
+		priv->port_open = true;
+
+done:
+	/* Need to indicate IOCTL complete */
+	if (adapter->curr_cmd->wait_q_enabled) {
+		if (ret)
+			adapter->cmd_wait_q.status = -1;
+		else
+			adapter->cmd_wait_q.status = 0;
+	}
+
+	return ret;
+}
+
+/* This function associates to a specific BSS discovered in a scan.
+ *
+ * It clears any past association response stored for application
+ * retrieval and calls the command preparation routine to send the
+ * command to firmware.
+ */
+int nxpwifi_associate(struct nxpwifi_private *priv,
+		      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	/* Return error if the adapter is not STA role or table entry
+	 * is not marked as infra.
+	 */
+	if ((GET_BSS_ROLE(priv) != NXPWIFI_BSS_ROLE_STA) ||
+	    bss_desc->bss_mode != NL80211_IFTYPE_STATION)
+		return -1;
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n && !bss_desc->disable_11ac &&
+	    priv->adapter->config_bands & BAND_AAC)
+		nxpwifi_set_11ac_ba_params(priv);
+	else
+		nxpwifi_set_ba_params(priv);
+
+	/* Clear any past association response stored for application
+	 * retrieval
+	 */
+	priv->assoc_rsp_size = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_ASSOCIATE,
+				HOST_ACT_GEN_SET, 0, bss_desc, true);
+}
+
+/* This function deauthenticates/disconnects from infra network by sending
+ * deauthentication request.
+ */
+static int nxpwifi_deauthenticate_infra(struct nxpwifi_private *priv, u8 *mac)
+{
+	u8 mac_address[ETH_ALEN];
+	int ret;
+
+	if (!mac || is_zero_ether_addr(mac))
+		memcpy(mac_address,
+		       priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+	else
+		memcpy(mac_address, mac, ETH_ALEN);
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_DEAUTHENTICATE,
+			       HOST_ACT_GEN_SET, 0, mac_address, true);
+
+	return ret;
+}
+
+/* This function deauthenticates/disconnects from a BSS.
+ *
+ * In case of infra made, it sends deauthentication request, and
+ * in case of ad-hoc mode, a stop network request is sent to the firmware.
+ * In AP mode, a command to stop bss is sent to firmware.
+ */
+int nxpwifi_deauthenticate(struct nxpwifi_private *priv, u8 *mac)
+{
+	int ret = 0;
+
+	if (!priv->media_connected)
+		return 0;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+	priv->host_mlme_reg = false;
+	priv->mgmt_frame_mask = 0;
+	if (nxpwifi_send_cmd(priv, HOST_CMD_MGMT_FRAME_REG,
+			     HOST_ACT_GEN_SET, 0,
+			     &priv->mgmt_frame_mask, false)) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "could not unregister mgmt frame rx\n");
+		return -1;
+	}
+
+	switch (priv->bss_mode) {
+	case NL80211_IFTYPE_STATION:
+		ret = nxpwifi_deauthenticate_infra(priv, mac);
+		if (ret)
+			cfg80211_disconnected(priv->netdev, 0, NULL, 0,
+					      true, GFP_KERNEL);
+		break;
+	case NL80211_IFTYPE_AP:
+		return nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+					HOST_ACT_GEN_SET, 0, NULL, true);
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/* This function deauthenticates/disconnects from all BSS. */
+void nxpwifi_deauthenticate_all(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		if (priv)
+			nxpwifi_deauthenticate(priv, NULL);
+	}
+}
+EXPORT_SYMBOL_GPL(nxpwifi_deauthenticate_all);
+
+/* This function converts band to radio type used in channel TLV.
+ */
+u8
+nxpwifi_band_to_radio_type(u8 band)
+{
+	switch (band) {
+	case BAND_A:
+	case BAND_AN:
+	case BAND_A | BAND_AN:
+	case BAND_A | BAND_AN | BAND_AAC:
+		return HOST_SCAN_RADIO_TYPE_A;
+	case BAND_B:
+	case BAND_G:
+	case BAND_B | BAND_G:
+	default:
+		return HOST_SCAN_RADIO_TYPE_BG;
+	}
+}
-- 
2.34.1


