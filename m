Return-Path: <linux-wireless+bounces-26133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB0DB1A65F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627E018914F9
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544152727ED;
	Mon,  4 Aug 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qk7umgjs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AF2594B4;
	Mon,  4 Aug 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322354; cv=fail; b=GfsglxIuybxJxbB+yDILeUkT5H1jLdm7mVcSTbXE/qLpuBkdEINwHYvyxRdLY2k1z7qxRC4XlOEakaIoDw4ZNhTerxuAmgxi6wMr8derleKmhhDcY8W2OAtMWrgzP1O2jNCTwCM9eHCItbeGFEBGTeNFiFvxaJsWndD8fNjA7wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322354; c=relaxed/simple;
	bh=zJbdhZ8lWW3MyIqQgLkaWn7JnpDmJk3LxllFFQ9nhP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RoBCdC0W4zk5GvtSnAxeSE84UqFaQu0xY4n+GtTm7seg+x/BPS7wvrWLoNDezjQFkisW539IJrj39F5AUI09RTFsAgJLU8uxwBfaGR3aTMTxm96/pEXcRdiXKpPn0oroRCnMQKSK3ypPGjS5Nd42u0Su+wYLG/Ws4u6uLyvCPBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qk7umgjs; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7RSlFxhXOMTdYEK3oXKEmBpMzKdlgLXCzWMoVOMd0cdsXGgttDMKv1IEVTnzR9mvuiWGG53oHVh/a5edhuSqPZXJ28Eez67Cnxa+rHBvAH92oOEJIjWBHUy0n4Sjr6jXihvuCPYw+kjZxhHTBkUppIXKw/2ldrHYBzDzaUjtq7ctdijw7PtFDWy4fl+iIOMS63+op3D6aMfa5PdZLiTIDEl3C1GA0o/qqAnDFivxm3ptOBRWlzltcy8UXd1z9if9Q3vHAFLFHhnpCerdVv52zB+MJ8SHJl/nI4ZEpS4+bZ37p0W3+xpqrR55TICQh2hsz/ABVqqt/SY/gv03SxIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAyh8Al+/n/SdwLSfE8tT65+ZJ340kZ5x5eczZ15x+k=;
 b=laAHUMghAiax/t+GraQAe44OLfY/JJZvRcvX6vNsKqpe0cge9jeXRjAGwQ3Hs+VjbXyEAQ5LjG1sTvsTL6Zq2tg1s/hhtsjHfUGbOAEfCL+CasoATEBzdPkN9c5um0FaqLNznoMrSPqu3Rknwniqijh3XD+xji43K6Gi3sm3EKj5DvQPmQi2avMuyHzIpUePhYCQRngbG+z4Hy1BP50Pp8jpIcVZNvBkbSf9poqyDP8CWKeyx/e3EVibJhtKxHqBDXtn/Z+Nf3mQl+vhvYinsd58i7kkXe7yqjBG2mQiS6uQphhMIs2XicMWjbcBfOeR6rOO3udZeyEDjaUMWq5bvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAyh8Al+/n/SdwLSfE8tT65+ZJ340kZ5x5eczZ15x+k=;
 b=Qk7umgjsQLRofm1fLYa56qoZ8Mol9V4UX626PTaB1Sde3P+fZ8gbIuuXgWXGPQRE6Cv89wrlaEiQxtVJjtTsy0BmsEfIo920x876RtVOaZHDkTQICTQQx8naHkYsiIvCEjInMjCE0hcJUsWQ8Xqm2zLE959mro8kgSM1q7Niq0TnsuR1WRr1DF3gfP1FChydEaKiVr8aVXN+ecJDqGVlVrtZeBC6tkPbZenn+t7tQlwQEfCf5wj+IHuKa3zdI1ifmvIA49wS9xc06wamiy/d8WqTNmF1KgbvxxN/0ij/6c51JizjYVegusjLGyonajrB91nVyq1yEeIFjF/H4PBpew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:45:49 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:45:49 +0000
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
Subject: [PATCH v5 03/22] wifi: nxpwifi: add 802.11ax files
Date: Mon,  4 Aug 2025 23:39:59 +0800
Message-Id: <20250804154018.3563834-4-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c5dacb-2fc1-4990-c144-08ddd36dfc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g5IhAy9AWQtAdQPuH3w4JJy9dJIyePz3owU7hWse0mlfJlPIuAxu2dYeGGJe?=
 =?us-ascii?Q?B9fk7yTs+S5a8/W9GLn2KQvTNEXsNDL8YDeqwmComz/oMmW8kWNyCAv1I5dV?=
 =?us-ascii?Q?iKEizOrmkWHqO2e9VNzLjiuU/9F1L0K8hiPhS0zSRys2aqFeZKi6taKhvLz/?=
 =?us-ascii?Q?aJyfsZ1zpLew63y/bMC0e1piGjBgD91Y3891aRArcaTmpQTrZaZha0DtM2PZ?=
 =?us-ascii?Q?1l9RJPj2uzmH72XYPP/PNN2/LaPYOuttBw5JJ+XiGDkHZru1faJcB200Mkd/?=
 =?us-ascii?Q?FPz7jMwXoPXl5A06xRXIe6zYKi6xLSsy5LUVB85tP3UmjWrzX2XJ5DVwf9yv?=
 =?us-ascii?Q?cvAJvPGElG82tz8fQNNxJBMkTF1t8uivjFPqeS/ENzeEw50ZMuSjQV9uFUMp?=
 =?us-ascii?Q?ormqDdTM0N960byehSlJNBAX8fraBLL7EiDYwpvimHmHHOV3fnYng3Ehs5GP?=
 =?us-ascii?Q?skzMQuX/lY9oOi77r3kNZcWz/o1LrFo+Kul6eGH/u3YFgWUSwBJ0D2vDqmJ3?=
 =?us-ascii?Q?0wbefs+Y0AOgSC+5WF8KkSSN7wZjBmp6gmbwdkjPl3VkGqlIUQMLyvKBchfS?=
 =?us-ascii?Q?rmNpdI6pj/ucBmNsv9lvlRT2Y9WkreoPR68oL32fp3peDHZqQQMBHUTlp+Au?=
 =?us-ascii?Q?XttIXCNxhJE4wlF1qIex9ncTLXrnFBHS0GaoL7e5oHlH3gIrw8571IfdCryF?=
 =?us-ascii?Q?e4a3wG7nUaEvb+uBbiKVgqIt+rBo/thfzF/P4eMhfsudi5cRoELcGmwVQpud?=
 =?us-ascii?Q?uCOSu+w3+o7QlALKa9NbDcAHitxjVLtFCs/xbVVNeVaAc8Lf0sWChI34taB6?=
 =?us-ascii?Q?FT9hdULXtpcOzRgjrVD+TKZIrJTK+YaraOWnNlds4HwWAxywmdGhH3rhegrv?=
 =?us-ascii?Q?US44spwRdTkQWO8zgxQ+sKGCHQTQe2aP369bMVQZRzgpJlcA5RSVuo1QCZaZ?=
 =?us-ascii?Q?Qj98cJ4Pni/67Ban0k2ZKzxcch5Z/dWjVbg2RKBwJNPXiDlpGyoNXcBcRKl5?=
 =?us-ascii?Q?qmMudIc6Aia5pB+O1Bt15UoZAMDBo9Xvuq0g1BKENIygdBAOiHVj5QV/Ujrw?=
 =?us-ascii?Q?0kFubU4onKDA9maCafNAVKFydr8v2xJuOXwWWFyMcx+EvmgNR080LKOC8+86?=
 =?us-ascii?Q?FaPMr/hA6HDzOinwhorMZqUSXzL4t2XJD0ChVwDtT+K0E+eNyCHFYQhGSYV2?=
 =?us-ascii?Q?ePoqLVTDoVGNhpLD+YdWtxNp6lP67UWDt/VIGfTLDoPQ8cIazxq22N3kzRan?=
 =?us-ascii?Q?i2shgvXYiXOktY8ZPQKPBQe2lTKb2BfZdmBzLI3E/HfdzUkPmYu8QT0U5hD0?=
 =?us-ascii?Q?3d2rJDP2jDnC1zNzLUwBC9NS+IQ+v3tUpWZt4OKSfFUkpLDn2Y6lcvU1ZI8k?=
 =?us-ascii?Q?sZJvii4Mbvb/YPvnlCdIPpp5/qCRKW/bc7jQh672rDGQejFkAocgq/fAg+Za?=
 =?us-ascii?Q?ztKvO4WBqFYJGdgeFGwxXg33Jno5bLcWR+FDlIcYuEGHdzNsQ7ECQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6NZ2yoOgDTnNshWUX9zGAKI71t+S1NuRlqC7VOaWjvE8kK4ib5Wav6XJZbtu?=
 =?us-ascii?Q?TP4xBAEv8pRfQJx+xrvVxUXr6h9FJfo4MJkfm2msJ7Am34ldopb8IG3kBALK?=
 =?us-ascii?Q?ykSVWJYlIr3KO1yhZEVO9BbT+JBdWvYgAPv1d05mF4juqbpNMtepvUMLRfWP?=
 =?us-ascii?Q?UFJL4J7HjnuDoE3lsYrw1pRcdPX1S11zqjPvDx6qz+USQ/H+eSBcTaz0C5FD?=
 =?us-ascii?Q?mjXSqv8UFAtxLcVusyMlKvj/tIw8Wv89pDd3yZmm3E6Q39DuupO4ToqprE7r?=
 =?us-ascii?Q?sbJ1pXsZoSgQ63znc3ryI3/ew18sfxOprdzLfIvVuIxw0g92dDYPyilL3TvP?=
 =?us-ascii?Q?M772ngQY8ut1NQ+Eaa7rSJBlJEt4XrBnNo1G99fCy614Af62LqJCy/O64F88?=
 =?us-ascii?Q?wavObhpobvcSfPd9NPW0YrUzGiAYti4LH/OGravsDzG8L3WcdrG1eSt94ZjN?=
 =?us-ascii?Q?sKF13FBh0gqCwgc+nZONNZrnogcm1BuF6rcCHXrUVA8naMOO//kmECm7nk9Q?=
 =?us-ascii?Q?r2BuYXIzBM7cuU8wgEA/Yol2edfpS5pkdfu24IfflXfNtLV8zw+5VnopqwPJ?=
 =?us-ascii?Q?ZxL+/gurYRy5lIsQe30Qj3A87MdZnRNlno2VZHMS/TYpa+QRbGw/h7FZnzsU?=
 =?us-ascii?Q?BDKp3AzcS/tRqLd9zPTseU+TLtchuXkmyhtFMtOi1MS6BYjhKK08Fa8f7KCt?=
 =?us-ascii?Q?74SDkR8hb8UOzCo4wNBm9olSa0QvtctQFWsVxBV96ELzefbE0PymPOFHwo0M?=
 =?us-ascii?Q?TPfX+je4nF1EJIOMOg9LUDnkm8ZqQb9ugxlnxKUgeykotUVmtPc9G4Qfn0bf?=
 =?us-ascii?Q?vKdMwXZ5AUzfqABUM29tYv4eyVtPjpC69+BRRmj3/pzaMBK4lcGtzBT7sLbp?=
 =?us-ascii?Q?p6x30EmAyzNVa/Vl13sjS6HCF/4iNauZOjFoo5XebjvGUSDnELlgRJh0xDVE?=
 =?us-ascii?Q?kmZU5SYCPELqmgZhZb/SYcY0+S8IPz6FAhUMoPu00YOMzEejV2tTEqkQWeDb?=
 =?us-ascii?Q?aieTjU4iJ7y/Na9rQxyIqvsCCAPzt0W56MOw6KLK9hElrC1jHIj/PSd/3jw9?=
 =?us-ascii?Q?wtFpyPRJ0W6OGdqLVESiTUYI+uZS/jA1wFXdpCQxYXZMh5FHAj/7awH/1yop?=
 =?us-ascii?Q?eHHjwFUu0SDiVAYmsVx82dOs9nsRxCAfJrZ0L0/jWu0+WgmHq4ljni8YhSs6?=
 =?us-ascii?Q?oJEjTKNSoMGrPIcZHvjf8mLlGPH9RpVguLs3QCU2D+ojLuYQFkC3lC8ep3wB?=
 =?us-ascii?Q?lb0RWX3XtEU4RnoYyno9p75JAsikx6OAFXjb1fs7/Al3U5trYevZ9NpYbv//?=
 =?us-ascii?Q?z+v85q5yXZSnIFp4ZGLso1emzcKRTRI44khxQDqaI8tOlbtQQCbdZyGULLAd?=
 =?us-ascii?Q?E2lrhLMsUgvqxWPiaPI1d2d5xPXlDKHg+eeMxmovujOzZerf0d44UBGk9M8H?=
 =?us-ascii?Q?h/LOdxRopTcfW9QvDTHl1u7JTC05FFDUqTsoMKl1xQHcVdhpeiD11Oy18pzO?=
 =?us-ascii?Q?JKFSmJ+kdTvVyPYS6oGh0fvn0Al0WEgl90Y9BQX+p5O/RFkXnZLeKXEVSMmz?=
 =?us-ascii?Q?JXsbv3venFxKQeLZmpFStqZQEcTLd8QemRnCGDBu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c5dacb-2fc1-4990-c144-08ddd36dfc44
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:45:49.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZz43tUWF6oZNrNqJHtNrQd+Czr7HP6tlXoQz6QuwL3n8jevwzkwOVYSLx9w6vcJeVfDEnoTUKQ215+kpxqpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

For client mode, NXP firmware will help association process via
host command HOST_CMD_802_11_ASSOCIATE. IEs for 802.11ax should be
converted from parameters passed from cfg80211 to TLVs appended
to host command HOST_CMD_802_11_ASSOCIATE.

For AP mode, IEs for 802.11ax should be converted from parameters
passed from cfg80211 to host command HOST_CMD_11AX_CFG.

Files in this commit will support 802.11ax features based on above
descriptions.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 590 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  72 +++
 2 files changed, 662 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..3862dbc5b56c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
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
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability IE ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability IE ",
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
+				HE_MAC_CAP_TWT_RESP_SUPPORT;
+		else
+			user_he_cap->he_mac_cap[0] &=
+				HE_MAC_CAP_TWT_REQ_SUPPORT;
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
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap = NULL;
+	int ret_len;
+	u16 rx_nss, tx_nss;
+	u8 nss;
+	u16 cfg_value;
+	u16 hw_value;
+
+	if (!bss_desc->bcn_he_cap)
+		return -EOPNOTSUPP;
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)*buffer;
+	if (bss_desc->bss_band & BAND_A) {
+		memcpy(*buffer, priv->user_he_cap, priv->user_he_cap_len);
+		*buffer += priv->user_he_cap_len;
+		ret_len = priv->user_he_cap_len;
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			adapter->hw_he_cap;
+	} else {
+		memcpy(*buffer, priv->user_2g_he_cap, priv->user_2g_he_cap_len);
+		*buffer += priv->user_2g_he_cap_len;
+		ret_len = priv->user_2g_he_cap_len;
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			adapter->hw_2g_he_cap;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
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
+		if (hw_value == NO_NSS_SUPPORT ||
+		    cfg_value == NO_NSS_SUPPORT)
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
+		if (hw_value == NO_NSS_SUPPORT ||
+		    cfg_value == NO_NSS_SUPPORT)
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
+	left_len = resp->size - sizeof(*he_cfg) - S_DS_GEN;
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
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_11ax_sr_cmd *sr_cmd =
+			(struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+		struct nxpwifi_ie_types_data *tlv;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		struct nxpwifi_11ax_beam_cmd *beam_cmd =
+			(struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		struct nxpwifi_11ax_htc_cmd *htc_cmd =
+			(struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		struct nxpwifi_11ax_txomi_cmd *txmoi_cmd =
+			(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txmoi_cmd->omi, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		struct nxpwifi_11ax_toltime_cmd *toltime_cmd =
+			(struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		struct nxpwifi_11ax_txop_cmd *txop_cmd =
+			(struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd =
+			(struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		struct nxpwifi_11ax_llde_cmd *llde_cmd =
+			(struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &llde_cmd->llde, sizeof(*llde_cmd));
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
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_ie_types_data *tlv;
+
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
+	struct nxpwifi_ie_types_extcap *ext_cap;
+
+	if (!bss_desc->bcn_he_cap)
+		return false;
+	if (!(bss_desc->bcn_he_cap->mac_cap_info[0] & HE_MAC_CAP_TWT_RESP_SUPPORT))
+		return false;
+	if (!bss_desc->bcn_ext_cap)
+		return false;
+	ext_cap = (struct nxpwifi_ie_types_extcap *)bss_desc->bcn_ext_cap;
+	if (!(ext_cap->ext_capab[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
+		return false;
+	return true;
+}
+
+u8 nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				 struct nxpwifi_bssdescriptor *bss_desc)
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
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &cmd->params.twt_cfg;
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
+		struct nxpwifi_twt_setup *twt_setup;
+
+		twt_setup = (struct nxpwifi_twt_setup *)
+			twt_cfg_cmd->val;
+		memset(twt_setup, 0x00,
+		       sizeof(struct nxpwifi_twt_setup));
+		twt_setup->implicit =
+			twt_cfg->param.twt_setup.implicit;
+		twt_setup->announced =
+			twt_cfg->param.twt_setup.announced;
+		twt_setup->trigger_enabled =
+			twt_cfg->param.twt_setup.trigger_enabled;
+		twt_setup->twt_info_disabled =
+			twt_cfg->param.twt_setup.twt_info_disabled;
+		twt_setup->negotiation_type =
+			twt_cfg->param.twt_setup.negotiation_type;
+		twt_setup->twt_wakeup_duration =
+			twt_cfg->param.twt_setup.twt_wakeup_duration;
+		twt_setup->flow_identifier =
+			twt_cfg->param.twt_setup.flow_identifier;
+		twt_setup->hard_constraint =
+			twt_cfg->param.twt_setup.hard_constraint;
+		twt_setup->twt_exponent =
+			twt_cfg->param.twt_setup.twt_exponent;
+		twt_setup->twt_mantissa = cpu_to_le16(twt_cfg->param.twt_setup.twt_mantissa);
+		twt_setup->twt_request =
+			twt_cfg->param.twt_setup.twt_request;
+		twt_setup->bcn_miss_threshold =
+			cpu_to_le16(twt_cfg->param.twt_setup.bcn_miss_threshold);
+
+		cmd->size += sizeof(struct nxpwifi_twt_setup);
+		break;
+	case NXPWIFI_11AX_TWT_TEARDOWN_SUBID:
+		struct nxpwifi_twt_teardown *twt_teardown;
+
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
+		cmd->size += sizeof(struct nxpwifi_twt_teardown);
+		break;
+	case NXPWIFI_11AX_TWT_REPORT_SUBID:
+		struct nxpwifi_twt_report *twt_report;
+
+		twt_report = (struct nxpwifi_twt_report *)
+			twt_cfg_cmd->val;
+		memset(twt_report, 0x00, sizeof(struct nxpwifi_twt_report));
+		twt_report->type = twt_cfg->param.twt_report.type;
+		cmd->size += sizeof(struct nxpwifi_twt_report);
+		break;
+	case NXPWIFI_11AX_TWT_INFORMATION_SUBID:
+		struct nxpwifi_twt_information *twt_information;
+
+		twt_information = (struct nxpwifi_twt_information *)
+			twt_cfg_cmd->val;
+		memset(twt_information, 0x00,
+		       sizeof(struct nxpwifi_twt_information));
+		twt_information->flow_identifier =
+			twt_cfg->param.twt_information.flow_identifier;
+		twt_information->suspend_duration =
+			cpu_to_le32(twt_cfg->param.twt_information.suspend_duration);
+		cmd->size += sizeof(struct nxpwifi_twt_information);
+		break;
+	case NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID:
+		u8 i;
+		struct nxpwifi_btwt_ap_config *btwt_ap_config;
+
+		btwt_ap_config = (struct nxpwifi_btwt_ap_config *)
+				 twt_cfg_cmd->val;
+		memset(btwt_ap_config, 0x00,
+		       sizeof(struct nxpwifi_btwt_ap_config));
+		btwt_ap_config->ap_bcast_bet_sta_wait =
+			twt_cfg->param.btwt_ap_config.ap_bcast_bet_sta_wait;
+		btwt_ap_config->ap_bcast_offset =
+			cpu_to_le16(twt_cfg->param.btwt_ap_config.ap_bcast_offset);
+		btwt_ap_config->bcast_twtli =
+			twt_cfg->param.btwt_ap_config.bcast_twtli;
+		btwt_ap_config->count =
+			twt_cfg->param.btwt_ap_config.count;
+		for (i = 0; i < BTWT_AGREEMENT_MAX; i++) {
+			btwt_ap_config->btwt_sets[i].btwt_id =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].btwt_id;
+			btwt_ap_config->btwt_sets[i].ap_bcast_mantissa =
+				cpu_to_le16
+				(twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_mantissa);
+			btwt_ap_config->btwt_sets[i].ap_bcast_exponent =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_exponent;
+			btwt_ap_config->btwt_sets[i].nominalwake =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].nominalwake;
+		}
+
+		cmd->size += sizeof(struct nxpwifi_btwt_ap_config);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "Unknown sub id: %d\n", twt_cfg->sub_id);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd->size);
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
index 000000000000..1b68831e3af9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AX_H_
+#define _NXPWIFI_11AX_H_
+
+/* device support 2.4G 40MHZ*/
+#define AX_2G_40MHZ_SUPPORT BIT(1)
+/* device support 2.4G 242 tone RUs */
+#define AX_2G_20MHZ_SUPPORT BIT(5)
+
+/* 0 indicates support for HE-MCS 0-7 for n spatial streams
+ * 1 indicates support for HE-MCS 0-9 for n spatial streams
+ * 2 indicates support for HE-MCS 0-11 for n spatial streams
+ * 3 indicates that n spatial streams is not supported for HE PPDUs
+ */
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
+u8 nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				 struct  nxpwifi_bssdescriptor *bss_desc);
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
+#endif /* _NXPWIFI_11AX_H_ */
-- 
2.34.1


