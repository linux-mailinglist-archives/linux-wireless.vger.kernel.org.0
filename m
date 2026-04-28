Return-Path: <linux-wireless+bounces-35517-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM+lC3oN8Wn1cAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35517-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:41:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9D48B3DB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DB4130074F6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9838B14C;
	Tue, 28 Apr 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hlkDHt95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007C38E129;
	Tue, 28 Apr 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405299; cv=fail; b=dxyaycXmCbVTknYtdvm6m9n6ikrTglbxkvXHEvAeoFcY3mNY5p0157fmSwALOPj8TZ9/uvlHOw7fFtFNEutFpaHR0z1reWWphL7263hLp4eSQ/mfLdBgK7dP2fehAvxJT/cJtl+s5S2XWO04QdyvWRyB7dovK2xvBOpAm1vHlKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405299; c=relaxed/simple;
	bh=60MqhPRuzB9CiHYYSDg4ssMiD1wT19GxCWy1XKa/NjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VL7HHpyeTgLrdFqs8d75msCXdzQPOCryGPdx8/DtJLMxdmKhn5OwM6+Fy8WwHjZ81qkEdFXAuL805QDoNtSxMNHWds5T84oF3msUuorbPruQDTAh2CVC4KJT57SqmVrUY7dR/2Li94ltqKgxhC3V/zmfm5Mq/0tuKekipTLxPb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hlkDHt95; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8VsmjhGjw0DrKeg3LtyEwXs8xP+MH2IA/kkW2usblDL9FH1M51TNsT0mIOc49A7/Lb459ftMCmPWeQ5mpAO5L3szaymJbxRN0xOtRbvaJozo+hDooiMEbzgI/kCgvnoIV0M+bSi9qD1IYlQcbnx1QXCXPapLXb3WfE3e+Z24gscFy6OtsTC+gcSezOdpNhRqa5hvl8bZqSMOObMV6I0+P9SW3VD83PBnP0evHn00aD0j87QA/QfVCd+oknTzizIutMwRDVJwl9e1UuWz+W/Tb3sNDnI7jO/sWmb6gG0FgtHgvhifJ10X5lFLlK8fB3Q/P+DcrXyjhkqjmHeB5myDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfxj13TPePDgcxIWEXBSHhxACDRRIan6tPWyoe7S1KY=;
 b=o7jB7U74Y8ySbLchLkrEkPycB/Hfrlnh6N1gyvRaVMrnylvt93UVjtL/3zzwtNe8SBJXftjjaD9qy48udcf/KURtWL726eY8DSH3BYMssEpHzUiGrf5bpjxCcGXCTK5WadPgOURool4s5S5PVm0wTuJpXKXtYFn2aQKJCu20q6mWyw6swTjvHF/4izhq72KKoOukYIpCwvUmNBAHXVwyKei/8WGTsv3pkyWOLEHKrY55mxcIqiDkTW22tMsNd7RQK/mVfcwQLGeNPHFHVzPDFeI5xXoR7+DjMIpB6OLFTQCZf4+jNnP83FhmXmJy8tjywM+Wf5/0kUqS9vsW2ONULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfxj13TPePDgcxIWEXBSHhxACDRRIan6tPWyoe7S1KY=;
 b=hlkDHt958nDLtXZCfOTsrQfLjeEj25yrkG+GXO352e29X47I/3oPNMXqmb+qV82VAlVg0PCU2ZFhC+JS7Dek4F0X1l4h7zRzBurDldleI+rQioHwyKso9TgJ9UD69YmZ/Eq71NjLJWpkDszd7Ltx+qvwa5lUpI4P7WclY4QRFNi8+cNwRPyupaVWYap7Ob78o6QuuthrrnN7daeA4RmdnTNQv+ZoKYIG8JhU2qesxXlKTFTYaC+CubCDDcQJcx90GeNoaviXH9M8RkqSSMdiV0cbs6TZ1868Fgagg/7V8QsxC+HwLU2hdBa4EIPQYTg3mWd/Pzmk4rttHAwgUV+LQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS5PR04MB11371.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 19:41:32 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:41:32 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 04/22] wifi: nxpwifi: add initial 802.11ax support for STA and AP modes
Date: Wed, 29 Apr 2026 03:40:03 +0800
Message-Id: <20260428194021.785252-5-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc9e7963-1da1-4fe0-69bd-08dea55e2616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	9+WYzyvusa0Gf8JofTvwx8lilUiVDKTjITwM4KYLKMo/vQNHHNuuD/4gYURnCMWeLcFudSbINjI4vuS8/p3QdPuGq3fmMHrWcXv8Q/JHykL6f+wSNNMGQO7fiCOIdv911HuFYPQBIoVMt8UqWbyoAGEq2cUhrdrn/6SZZgRfjgEJGrZ7jNH5IGbe/bgrCgDm5omycopQRKCxwGV9vJ5GcibxtdfvvroCUGf4DwQWlSortbDp9kPYPTKEGVQ0EjbCg+hUi4JzLKCfyJI3fGikUaJXZOOYfq0Dlr9h2c8mNmPAZLZw+r2zhBIrSMs07Ii9v9eIjxYWSfttmMXj8iGLw16Xb3FxdZDGrw0xxfVg0uR/V2F5ExDNSSeg2gVMDdQFcM9AQ+O3Qu4XskuTzoYQzMBBqlizltU2m8LaUDt9k6Qqp//XnFoUPUXLroAzgm7+on7s/UzWZYMLzRl1a5BC4VsaBmfGShwHoPXKNhqQFz8HPhWQNA65ozlP6yOURnwrxqB4mzPNgyIXbBXX/oimGfxgrzuphIEPfvuC8HTFYTEgYgioRes5t3bruCpg6MAjyFjhCocz9I9qSKHdWijj6Y175w5ODDHf7m3jGoe84SijTrE6Tk3Af/fEoQtFUP2lVLw+WkBhTXQqZd1fvUBY45f8y7Pmx60unJrT2rpSxM3CeRolT7zwD+MqabmMaElcqbqVusQiCzKMvIWYqM2ojtDWa9NmoXPcwxXz0+RmMUm+IKyNluW4ti6pplfcifyCwvRBnAfgqo8Zj+iruembuDy1YTJcRofDK48BY2yUMD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tnq0LtJW2hMJjU3vZILGcVl0xD3RyFJjFCvZXVzHVJPelzBhin/N9hOzuK7H?=
 =?us-ascii?Q?QJAaIAqbDwO2efIfXCsMC5X1opUfBxu/F5yfTBmycLkL0h5kWx9dPuu61MFl?=
 =?us-ascii?Q?dUr7fHZk1tY00l0K0JxAQE3c7qbv3pSLPTQ7LXlOmrVHbcV4Rs+RHJDQcXo3?=
 =?us-ascii?Q?w6SPGjv3J6CcZpHvZ9W1/vVpMUtNf48tZ3o0Fg4SHJwtNsvzFqPQUUO7/fP9?=
 =?us-ascii?Q?k5kXD2h+SWBePVUBZuGa07m5z1xEVX2MuAVQ2QIoVIzu7Tc8KR71K3TjTA8Q?=
 =?us-ascii?Q?l2cCLwW3+yTEj9VFmK27RC3F14lYQh8OFwnmpM/aioqUME5gnyBI0l1FWR0d?=
 =?us-ascii?Q?Ep7pLMucaAKaeXtsSQxLMGnr9jD72t1bqwPSnZfxkEWqlNMUe1wTu5KR7Uz1?=
 =?us-ascii?Q?oe92N3eo6VDzZAzCocdJiBmsXX6pdjcc5D0Ayi6kpeEC3dWhukENWfMD6k31?=
 =?us-ascii?Q?8m59b/3/hH2Y6FDL/+0rmRDow9VS2ObJKPgQ1aCK53/DbwHJVTf1syEQSS3Y?=
 =?us-ascii?Q?xEzZ+E4e1CMFC/Fyox14odMV72WopQlhgJnu6zlJiwZRs+GyIVzpoXjMGhlG?=
 =?us-ascii?Q?1qBsz9K6TOROY9NULHiCmiVrSv5pGRQdUEkgRMIaZ8OZ6Ht/6lQ7+ED85QUi?=
 =?us-ascii?Q?D6Pf48Q4MsvL2NbaL6Ldc6/5xoVuWCxy3s085EjZiHGHZxv+8T81BGdN/afs?=
 =?us-ascii?Q?8XRUVoNQkvrBFmbIKW9DRcZUgKa1VqfE6VaKhiuig9s9dP+dNwfFAXyWbDTn?=
 =?us-ascii?Q?1CS1T8ci+LwpBPTyQCNk/sbfgjyNN/oCGycPAeX8y6hGFovs63wfEb5NDixN?=
 =?us-ascii?Q?IDU5vj8vqGZiXeH3xdg7/dMhT9z9jKsD6kwBWO/bXwmY6LKFIODR/saDTWYL?=
 =?us-ascii?Q?5SwuqLkGf3SSi4Z5s8K34aWTXQKIId2n1ft+0BCD1F5FZdoUgymOLJw1bWU9?=
 =?us-ascii?Q?zzYMWDqiIU0bW3Duq+NeARMUnSXb/bPhI5wJg30Ocfh7awH/206wwxFxrL3l?=
 =?us-ascii?Q?4yEY9UuHTZfj+qcUNBWrC4KT+a3K+NgBN0t/K6QWp74nH1RzwLYBIWzR91Pg?=
 =?us-ascii?Q?mOXVv2w2yBMyRDifzGOCpHX+GJqEc2PGBjMeKKg9E2INrwWvFCmBXI79nS2c?=
 =?us-ascii?Q?8H07S4ZweM7Q7cYAZQ/YtSzwYDWgPW1c/YoTrxsG7VLupD0WY8tlk8zMfPe3?=
 =?us-ascii?Q?ANZHDOFzMDPpak4kj5QECxl8QLmlO3UtybwU7o6OxxYgOpB8/34vxzpyjrfG?=
 =?us-ascii?Q?hsSka+yVYo2Po/4/c35clpESmM0lBnWxXXsO/QKPkEhJ4qbPGDBYwKn8NFB/?=
 =?us-ascii?Q?wG+HnMqWBndW0IS7X02Wh+D1TbH0rDzJ+50YaO0BZ05LRQKmGUy0nEotVfoG?=
 =?us-ascii?Q?xZqEBEVOIFXTRJuksCwuK72yXvCeHHh/awjPtDTDGVdjofLTTroqMF0Cnp57?=
 =?us-ascii?Q?/0tS9dKsEuFAaw3344ya+lbvyfG3DJCflXYwLD8bUljj7IQbepcPEXlGeHPd?=
 =?us-ascii?Q?9HvS7OGY8Vq0WiG3thQQYPz9rQnaW1Ty1uUh6MJn3am4T1lwWvIqst+yOOcX?=
 =?us-ascii?Q?M+RmpecdQitV8QF6PJyZHJoTe3Nv+yVGGw0AngZNFUV5kGyvgbHEsrTgdTG0?=
 =?us-ascii?Q?XqXLR1oCElCCYnSPj8nne4+DOIVDammt6dmJtZqAk1LZNp711B8b7M2tajjL?=
 =?us-ascii?Q?+JVttnBbBSUyIF0CrZfM2ggYRsaJW2M4j2bIm5Xk7VsTj5k+2jI7bduQe7JF?=
 =?us-ascii?Q?SZuBt0nN+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9e7963-1da1-4fe0-69bd-08dea55e2616
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:41:31.9501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUOvh7XoJq4ixt458LSju7tG1TL3YM3BKWptePO1gaGi/V5PxZdxS1hMSmNGHgwQJOe6LonEfDcLwPJOeep6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11371
X-Rspamd-Queue-Id: 5DE9D48B3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35517-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Add initial 802.11ax support for both station and AP roles, enabling HE
capability negotiation and configuration through firmware assisted
commands.

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


