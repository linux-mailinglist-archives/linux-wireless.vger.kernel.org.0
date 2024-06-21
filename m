Return-Path: <linux-wireless+bounces-9397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A7911DAE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705C4B23788
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3767178381;
	Fri, 21 Jun 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VxaWSuFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96103176AD8;
	Fri, 21 Jun 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956470; cv=fail; b=f8Bm84yfJTxW9adsxTQJkOCoqyELlonbvAQBNTAfiAYEIWbqigsCttnJzYTV+Ig+D9DUP7+riK/TUz8gjF/IAG6XdLy9Qomg5OO0O+bqRc+OrE6FU/jpnWpiy7o4E55fcellpzHSsE7rf16ivbxXqF/BkGQAFVjovMl7zBdMUUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956470; c=relaxed/simple;
	bh=atFQDYbzT2WJ/LTP1cKQpuzTxVuvbeo5mjzghx9wblg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POO6nfJvO4lhC29CZ956oyBcws9TbDb1/hD2gnJGGL4Ann7XjC3Aai5l9NZe0i02jH0ml484WHRK8b2v/s75f8F3kYwJjcCdXFUMiwWybBIIaBBTPJpactCK/C3qcqjNSGf2V2N9T2EHp6zFVeug1H5T2TaQlwwic+CzvvlIMr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VxaWSuFz; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuRy/wvSQsC4ASaJ7AxU0idekuPBtrfJGp3feVqkMdlRxEA+6OJT9OWfs7xxeqorzbKbWKrj7g6n9gNiL9atjxNVE1HURtuITYdwXoZzZaRVw412q0MW877FfEvoJ/jNXQFPerN/dMdEdQ09tCcKpbdUJ9b/zfNfVxL1itb+e2eHsi2T/BnyFo+wMaWbgm02sZWzucGGO2JHpu3fbDOnAdQSgnZudGt46IE/OquYUVTUcVgggcvRz8cu0sDH0WQzbUmsZPRu0wW5Y+Q7QYo4WvoWi2vNW8NB9OHbEiCYBI+zjO3iqrFIyNl5+xgt+300QrF0igUPWLGSBzcD7RRKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCoihKoL4wgcCd+is65bR+RLnTbXcmw3SKv5HMMmFCs=;
 b=khoHYcQh9Omec1zQ5xVMrsgc2d4USDzfAyFau5tGIKYo6W9fGL0njKqyG61GPSRMUPf8xOR3sGnZqP7IcFha5QMBGhC6bCXVl+druK9g+p2dnruO8DS1P4JxVLTxX9vki/etTu15bpVGP/fHoj99ELhaFMIXPpdRWsWfBlKGMutZ/Pqw8+rXoJC9kMGBJhxuTkpEcIDybgYJAH2jsbUFQweYZVfIdGAftjIxvuiPfptXVGUIdION65W+zFQTLzbVZmsH0BnFkmQd0QoFO6ssG5cyB6IDCIf4i4HY7OV1MpT3ZGtRGWpiRbO8v/7XSuKMxYpBMD8iuAqYV7AQ0qcFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCoihKoL4wgcCd+is65bR+RLnTbXcmw3SKv5HMMmFCs=;
 b=VxaWSuFzfKlr+K2Rgyx1YU978wZ2zPiRmTNxZDWISIYB78JIOOOHrMRD4lQTQGJef3oYKTbl87gjHKQtuVBl8dD0UMByGh+of+QdUmEQh7g7Jt/xt0gJxHa8Q8MvtCEyUXAbPbuVapk8SbaM3xU8OFJftTo2Bu5c9NiAhea0z3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:24 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:24 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 33/43] wifi: nxpwifi: add txrx.c
Date: Fri, 21 Jun 2024 15:51:58 +0800
Message-Id: <20240621075208.513497-34-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a289788-a376-4fd9-0328-08dc91c75de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jbHYW8s36awGKSuGaZdS/02QNyQFDVaPGCL6VCfrBjlkoMi6B/iaz99wTyGi?=
 =?us-ascii?Q?aguhRjIBjpxV2ADTokf0kmthBT7h3uh83dFghFC3RbfyDXuO2qp0CFD1avoW?=
 =?us-ascii?Q?+g9bpCaYtV64SB+9/kLHsbFCSS9JyeJGLeqstLxakoQrHQFqaUtCbIg3NpW5?=
 =?us-ascii?Q?h9QORRU82wS3i1NI2qBMGsWBvgc+ZyrezGJK6HmOYn3NpfBkwiVUwLihgfW0?=
 =?us-ascii?Q?g+87SFprxvmGknzK/wwO1jNt+oYd04R6pPhgO7hADaDcx1iO9tQ45I0q+64u?=
 =?us-ascii?Q?dYRlYcMt/YWF1feAJgwLJa1zj6A+f6YuUQ0gu0vv3btVougT68aaxq20L51w?=
 =?us-ascii?Q?FTpIEtYxVcbhvIfzV0zYMlWec9yS0X6Fcm+XmjoTgcBiDhmoFPZEeJPW4/qd?=
 =?us-ascii?Q?KYfgXbvs6+RgOTFxQ2Q9Dk0Ox4uHUOi4Pt434DVZvZyyLcWWsvInBk/sPHEq?=
 =?us-ascii?Q?1EfatqvgMvUdm8nt4YzzO34jCPHl+PT74X+q2+/pgdKkoEiz93NiaO9XYSmK?=
 =?us-ascii?Q?YF0FK2WuN5dIzCdfQPzmVWtfy+abSXsv99pCW2p/gYsHemsSVSIh+HAP+9bR?=
 =?us-ascii?Q?FlxbG16feI+ZqMLZJgqi7WDLWHUqshb4hIzpz1LqM3y08x4H2PoA/eqRN1f8?=
 =?us-ascii?Q?1IhqYjwz7cCLvJAn00vnFD+YV99ANaY/wgkMz+i0eWU9RnjCFTJa8PNIrm/U?=
 =?us-ascii?Q?3yrmbQ9M22geZstwD4BgBNnuzphPc5tYm7733o3UgLt96cJlRPGZ4TjiE9gw?=
 =?us-ascii?Q?aTgnEcy0C/5vdmAaZa5GxOx/UGFzaQB7Zgh1In47k288lpPzxovaT7ftcqcY?=
 =?us-ascii?Q?XwqvxkNqynJy/FRpdk/3ZqtEWckCQaJWvTZ4O28ybT81Yls/WyhTIRb5/Npj?=
 =?us-ascii?Q?ff+VhHt17Pw4kebxUDCGVSgWLzY4GMxJFC8QOvG0OTwlqypkecNSm9lsMU+Q?=
 =?us-ascii?Q?kjunlDTLmJn2HNuddUtnRs1APlrNYSi7rLrAfpsRHBQe13dqX6Gp5+94k9Ci?=
 =?us-ascii?Q?bT2GZ+GF4OyUw6CBb6rn0JPpculYPID4hTRp3eVoToY2IN5Vnvpm3UgEQXJ6?=
 =?us-ascii?Q?GP+dSxdhMx0j+sHqzNGaxlMRk+6s0Cyjq2amw/2INytAr24p5mKTcz4FVb+i?=
 =?us-ascii?Q?aPcnAYnHcSl0fjbITs4xEXB8avliQu2rSt5HqZAvWHNI8xAQbq/qO6NOpPzC?=
 =?us-ascii?Q?9dxfIf/Qz/MuclcIDiLzP07UG65GBwLW6W/3M6GTq8jHmYQSsZRlJidsr0Gp?=
 =?us-ascii?Q?wGSUGE2fqaeE1ZTIlO4jJzkiWzSQE9XlCzMG57xXEFsCUWzrYtjDFOQnR4g3?=
 =?us-ascii?Q?B7Exv9ipguA5k9GAtwcO7ui08oH92b+RJO9BcWmMajFkv9QGd46EztAzh1JM?=
 =?us-ascii?Q?+j2vQJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Qg2YvJ/05YItBtFc7NHcAIts+3eiSGUBLQTP3AMbGd7VTw68WkFOzU8leP5?=
 =?us-ascii?Q?k/n70Kc8G1MWWVh0IPOF37uMf25fwt0wR1MqTQIcrpf502j6iSqypCzd9mWV?=
 =?us-ascii?Q?RU97QrBvqxvuxu9eYyIWgr8ufzguXLNhKqjgfAEmcKMdee8zHV2dRMUjCVJ2?=
 =?us-ascii?Q?1PAbIFARaIx00qfhnkOCBS06o22uI83NDacS/P3rEWuIaLyteyvBbfKt29R2?=
 =?us-ascii?Q?fekwdprYE5Q3XFfObK8uYqBsDy0Q00QWo1tUkZt2/MCnryREA9ChohyfrIsP?=
 =?us-ascii?Q?NAlCwMzJOcM57brYKvbuxvtmWCF9npYbCgBAgt2Zr/bO83T7GKpnJjDFzrYz?=
 =?us-ascii?Q?AMpE5+qlgtYLPWdyUCUQF/diNO6WVduAFbzC5KEPXwkv/RIYB6YC9W5RaM4f?=
 =?us-ascii?Q?CbxTo5WtywaP9Zu9YGQuA8E5sEuI37R+PILXbc2O5XGO4+sp1AFLwU9eoURY?=
 =?us-ascii?Q?lL9rH7wSKYpJCcyUl8nRrUgscLcgswhS0rKu1N5WgTxFHm8cidyspAzIp71e?=
 =?us-ascii?Q?QYpEjwGwYVRavC16RPLwy7QOiQHUDcquPCrTRnORLLc0K5n47rPiGngM0lFH?=
 =?us-ascii?Q?zGBhYNkfgckIxomJNRoqjPZa+t8ed6yNLO/y9PoFeHt3XQ/kb1FO9f9mTlVf?=
 =?us-ascii?Q?UNso2fZM+S+iMROBAr/aeL2wP/8CjCgqZ2scGq4Ig3LHFQDNIJ3zGj3jc+n4?=
 =?us-ascii?Q?iD9VsrdOoMzDlPC6xoV6S53eSt5ws9ocUSM+17LoDSZuNzoVOeF5nvZHE9nq?=
 =?us-ascii?Q?jUQMrzC2onGyNdKYm2vIZwcpTA/LkAudZWhm7E9OXLunP4NalCP0IvRY6m+Q?=
 =?us-ascii?Q?WvbQdGfksWtSXpGEoFP+ulWprlIcmyPhKeJp4RDid9E5JsOuMw5n9aVh0bWe?=
 =?us-ascii?Q?InoTqFHPb6ZuhwbrfGPrEfKYKaEjAwWbTxpBDBOCqbMW6hoTnLPugH0rNL30?=
 =?us-ascii?Q?+DsNQsEfHHQA2wuKfwPwl1vj1yWBCEk5UnaSMpg0YPk+AvG5WEZVuRCUdMtk?=
 =?us-ascii?Q?hnvUAZdqjPINYrH/rxeDnNnl3W2sm47CFGMI1ApnSMlegBOWlFXLAUV+bGrr?=
 =?us-ascii?Q?ayAjUApZJKRrEUnQEBLkYarnaGPG8XdyqJTXpQNPs0C78vgKJF8jgX6E1CvI?=
 =?us-ascii?Q?mL37M9iApuIqmzFpIiklpq5ybjCGuHduxZ5AYbPaNm81uV3fCTHb9sr3mE6i?=
 =?us-ascii?Q?sXMNjgorSICMMYkWPDTW4XMlHAgTpZUkWsme9XPUogaTDVN/ZJnEnYR1Q5DO?=
 =?us-ascii?Q?8f4sgCceCnMolbnbk7UE/ISpIWszTKF8dr/A9GahskIIYi7eJLjy77pFSdji?=
 =?us-ascii?Q?XRRpadB7JGBV9Rs1n9L3WR08pQ7YBUI8KhDEK0cAMXr9af4hl+CtXrpnMzrd?=
 =?us-ascii?Q?+rBXDpf/PeFmLvqdh9Bcu1AnfQXyz1jmaRKTASZXCiKXEl1WWWeiuCvC1Y3i?=
 =?us-ascii?Q?c05/qJg8yNWTfq/Axo7b73wMTyaOyhTKanOClkKxq5OntqsdHzAbghID7l/G?=
 =?us-ascii?Q?6uD/fag7Socraz2eWH9nmEqRFfdv2xV6f3i1RbppRVNjKuraI+JZqQpL4hAA?=
 =?us-ascii?Q?81Li5WhZ7gvzc/xWIGgmBRHzodoFQa5DEsAiy94D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a289788-a376-4fd9-0328-08dc91c75de8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:24.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALmTL25Oa0TvAQ/PfoQPHIvgd2K/dYyjyCeJ3ExYL5SN/BiPkTokPppjwm7Laa91Xr8qFcDwZyFdO/rf2txE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/txrx.c | 362 ++++++++++++++++++++++++
 1 file changed, 362 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/txrx.c b/drivers/net/wireless/nxp/nxpwifi/txrx.c
new file mode 100644
index 000000000000..3fe1cbc880e2
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/txrx.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: generic TX/RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+
+/* This function processes the received buffer.
+ *
+ * Main responsibility of this function is to parse the RxPD to
+ * identify the correct interface this packet is headed for and
+ * forwarding it to the associated handling function, where the
+ * packet will be further processed and sent to kernel/upper layer
+ * if required.
+ */
+int nxpwifi_handle_rx_packet(struct nxpwifi_adapter *adapter,
+			     struct sk_buff *skb)
+{
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	struct rxpd *local_rx_pd;
+	struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+	int ret;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	/* Get the BSS number from rxpd, get corresponding priv */
+	priv = nxpwifi_get_priv_by_id(adapter, local_rx_pd->bss_num &
+				      BSS_NUM_MASK, local_rx_pd->bss_type);
+	if (!priv)
+		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop RX packet\n");
+		dev_kfree_skb_any(skb);
+		return -1;
+	}
+
+	nxpwifi_dbg_dump(adapter, DAT_D, "rx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+	memset(rx_info, 0, sizeof(*rx_info));
+	rx_info->bss_num = priv->bss_num;
+	rx_info->bss_type = priv->bss_type;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_process_uap_rx_packet(priv, skb);
+	else
+		ret = nxpwifi_process_sta_rx_packet(priv, skb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_handle_rx_packet);
+
+/* This function sends a packet to device.
+ *
+ * It processes the packet to add the TxPD, checks condition and
+ * sends the processed packet to firmware for transmission.
+ *
+ * On successful completion, the function calls the completion callback
+ * and logs the time.
+ */
+int nxpwifi_process_tx(struct nxpwifi_private *priv, struct sk_buff *skb,
+		       struct nxpwifi_tx_param *tx_param)
+{
+	int hroom, ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd = NULL;
+	struct nxpwifi_sta_node *dest_node;
+	struct ethhdr *hdr = (void *)skb->data;
+
+	if (unlikely(!skb->len ||
+		     skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hroom = adapter->intf_hdr_len;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP) {
+		dest_node = nxpwifi_get_sta_entry(priv, hdr->h_dest);
+		if (dest_node) {
+			dest_node->stats.tx_bytes += skb->len;
+			dest_node->stats.tx_packets++;
+		}
+
+		nxpwifi_process_uap_txpd(priv, skb);
+	} else {
+		nxpwifi_process_sta_txpd(priv, skb);
+	}
+
+	if ((adapter->data_sent || adapter->tx_lock_flag)) {
+		skb_queue_tail(&adapter->tx_data_q, skb);
+		atomic_inc(&adapter->tx_queued);
+		return 0;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(skb->data + hroom);
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+	nxpwifi_dbg_dump(adapter, DAT_D, "tx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+out:
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, DATA, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode && adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -1:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n",
+			    ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	case -EINPROGRESS:
+		break;
+	case -EINVAL:
+		nxpwifi_dbg(adapter, ERROR,
+			    "malformed skb (length: %u, headroom: %u)\n",
+			    skb->len, skb_headroom(skb));
+		fallthrough;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int nxpwifi_host_to_card(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb,
+				struct nxpwifi_tx_param *tx_param)
+{
+	struct txpd *local_tx_pd = NULL;
+	u8 *head_ptr = skb->data;
+	int ret = 0;
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop TX packet\n");
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+		return ret;
+	}
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(head_ptr + adapter->intf_hdr_len);
+
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, ERROR, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode &&
+		    adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		skb_queue_head(&adapter->tx_data_q, skb);
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+			atomic_add(tx_info->aggr_num, &adapter->tx_queued);
+		else
+			atomic_inc(&adapter->tx_queued);
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -1:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n", ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int
+nxpwifi_dequeue_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb, *skb_next;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_tx_param tx_param;
+
+	skb = skb_dequeue(&adapter->tx_data_q);
+	if (!skb)
+		return -1;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		atomic_sub(tx_info->aggr_num, &adapter->tx_queued);
+	else
+		atomic_dec(&adapter->tx_queued);
+
+	if (!skb_queue_empty(&adapter->tx_data_q))
+		skb_next = skb_peek(&adapter->tx_data_q);
+	else
+		skb_next = NULL;
+	tx_param.next_pkt_len = ((skb_next) ? skb_next->len : 0);
+	if (!tx_param.next_pkt_len) {
+		if (!nxpwifi_wmm_lists_empty(adapter))
+			tx_param.next_pkt_len = 1;
+	}
+	return nxpwifi_host_to_card(adapter, skb, &tx_param);
+}
+
+void
+nxpwifi_process_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	do {
+		if (adapter->data_sent || adapter->tx_lock_flag)
+			break;
+		if (nxpwifi_dequeue_tx_queue(adapter))
+			break;
+	} while (!skb_queue_empty(&adapter->tx_data_q));
+}
+
+/* Packet send completion callback handler.
+ *
+ * It either frees the buffer directly or forwards it to another
+ * completion callback which checks conditions, updates statistics,
+ * wakes up stalled traffic queue if required, and then frees the buffer.
+ */
+int nxpwifi_write_data_complete(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb, int aggr, int status)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+	struct netdev_queue *txq;
+	int index;
+
+	if (!skb)
+		return 0;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv)
+		goto done;
+
+	nxpwifi_set_trans_start(priv->netdev);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT)
+		atomic_dec_return(&adapter->pending_bridged_pkts);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		goto done;
+
+	if (!status) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += tx_info->pkt_len;
+		if (priv->tx_timeout_cnt)
+			priv->tx_timeout_cnt = 0;
+	} else {
+		priv->stats.tx_errors++;
+	}
+
+	if (aggr)
+		/* For skb_aggr, do not wake up tx queue */
+		goto done;
+
+	atomic_dec(&adapter->tx_pending);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	if (atomic_dec_return(&priv->wmm_tx_pending[index]) < LOW_TX_PENDING) {
+		txq = netdev_get_tx_queue(priv->netdev, index);
+		if (netif_tx_queue_stopped(txq)) {
+			netif_tx_wake_queue(txq);
+			nxpwifi_dbg(adapter, DATA, "wake queue: %d\n", index);
+		}
+	}
+done:
+	dev_kfree_skb_any(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_write_data_complete);
+
+void nxpwifi_parse_tx_status_event(struct nxpwifi_private *priv,
+				   void *event_body)
+{
+	struct tx_status_event *tx_status = (void *)priv->adapter->event_body;
+	struct sk_buff *ack_skb;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!tx_status->tx_token_id)
+		return;
+
+	spin_lock_bh(&priv->ack_status_lock);
+	ack_skb = idr_remove(&priv->ack_status_frames, tx_status->tx_token_id);
+	spin_unlock_bh(&priv->ack_status_lock);
+
+	if (ack_skb) {
+		tx_info = NXPWIFI_SKB_TXCB(ack_skb);
+
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS) {
+			/* consumes ack_skb */
+			skb_complete_wifi_ack(ack_skb, !tx_status->status);
+		} else {
+			/* Remove broadcast address which was added by driver */
+			memmove(ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16),
+				ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN, ack_skb->len -
+				(sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN));
+			ack_skb->len = ack_skb->len - ETH_ALEN;
+			/* Remove driver's proprietary header including 2 bytes
+			 * of packet length and pass actual management frame buffer
+			 * to cfg80211.
+			 */
+			cfg80211_mgmt_tx_status(&priv->wdev, tx_info->cookie,
+						ack_skb->data +
+						NXPWIFI_MGMT_FRAME_HEADER_SIZE +
+						sizeof(u16), ack_skb->len -
+						(NXPWIFI_MGMT_FRAME_HEADER_SIZE
+						 + sizeof(u16)),
+						!tx_status->status, GFP_ATOMIC);
+			dev_kfree_skb_any(ack_skb);
+		}
+	}
+}
-- 
2.34.1


