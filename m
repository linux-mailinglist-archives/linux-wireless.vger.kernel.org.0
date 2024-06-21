Return-Path: <linux-wireless+bounces-9368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341A911D62
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268471C216BA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DBF16D335;
	Fri, 21 Jun 2024 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OUOD3ZKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B216D9D2;
	Fri, 21 Jun 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956369; cv=fail; b=lQ7H2Dbyl59sTLXqdw4eyKuAcf6h0ngWk2DGXCLIUXNo0kj/mdGaejhb8Y5vQJ/tRxUjXpVvAj1vEmNOaXjZIWyOB7FmCfcYIRRhODb6inn3pkhYi/jDd5gyGi1GcdYnzWCqVk7DefRybAL+XJChV1X1bke+hwCp44CnVJY0v5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956369; c=relaxed/simple;
	bh=6RZarGx0ac+AyKPisDSefWR9U63H2PaXoFIouV4D2U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlQSrOddqDYVSh6mSCALrlxxgm+yDvK4HA9UXJxk8YkVc1NlHIasNIeWwbW8Cx6OH9rY4MQPckIuR/rf3ub1oMuCcz1skIdTVCOhmks1eqnMBxfhoN0Bvn2hG7+ykXto7RExEE5slp+KL+Xnan6wflQzBxVtnudaof7IgAHxHNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OUOD3ZKh; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRZWIzKGQdOzN432Wbrp0JYBDkH7wF4e4Nx9s8j8G26ptHqPLQBk90GVhHyxpex5+GGf4sON0lgGy+4UW01YAyDYd+3oEAyDQTSxDJBp6/h2G8pvaAmUdgx2sj8YlG6ozzg/XcvJij9Xl/Pg7pWb8YjSVMIal/1RVLii8C3iLEPsx1y03bTDzGQgs4M338hAohCgqtAVm8/URRz4CqnCM2eci6Grsy44eo2UY4C/ZsRfSYzsi6ctbnEkFT2K+8L6f8rlL+HsIav66fefoVfZVjrNQLoPBpnpBphCgX0pSKlWhrKxeko+MYoNCCS2u8f4cppHBbFlTDanetJFkN7BNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPyQ3+F5mqca036GLWj2FtjCHg1aWCq/qapY2jDNlX0=;
 b=VnwGEw7RWfMBsrTUH0TqBeTU2yNLZeeaZRBpg/l8GtZxMSEVMpPNxWkJf6PNZhFVMORXQV7bB2meNoXcOd66nADmgNog0vyuWyk4uB3Xb6B5jp1uxUj+jZtvdsk6H/z/7qhtxmMJbryKmdydyNvchUQ415EYq1+mISl9bYGghwBEbFZ6dCqrfUv6hpZNAf0M7Gz5aQmkshgpK7E+sdQvW6x3MrsjZtasuzcglzdYonkfkDYOcNvhewNaZ8yDGfBhHIkKHX1ajmlQShLsd9w6cWd8GdmGmSjGiIcY19uJbVqKgVs3/T5tZQiqHDfLVBO+q9DEQ3Sz6qp68rItfz/CEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPyQ3+F5mqca036GLWj2FtjCHg1aWCq/qapY2jDNlX0=;
 b=OUOD3ZKhf1zp1qZBY2JogVsQw9ty+J0YLeyBq4ZKV00D2DRumlxqOu0ny/jblaQQc+FsLqivqWimJ+CqE1o2z7OiSjtJSTyezofCccc1eyTqkLA+FCxBwLetjrJlNHbpzc7+CIwWxCowFu2PhQl9XAsrxFYjAgeK59HRYEya3bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:45 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:45 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 04/43] wifi: nxpwifi: add 11n.c
Date: Fri, 21 Jun 2024 15:51:29 +0800
Message-Id: <20240621075208.513497-5-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DB9PR04MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e8e84f-1991-4802-18f6-08dc91c7224b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1hbOmztGHaOxOEx/fdpoGg/+iOucYoxEsXJCyinKePq3UI9GoqHKSSgaRSM?=
 =?us-ascii?Q?PWKBm6Jgn6gvA3bxS4//CA7B1lKhHvAKZNtzkPFw2AA87kimAkenNVIiEfkW?=
 =?us-ascii?Q?T+SfN3a/MK2HiaT/U7TPQwuPRH+V/Ew5M/kuSIvGhuFSpza5fPpCO9rR0ffp?=
 =?us-ascii?Q?DNbgq07nWY9CMIJ6pbGdFIwkXEnSAjZwvKwFi5xuISEc5NOQQEDhgb0NJ30P?=
 =?us-ascii?Q?cNk9y8qCw/W/bHeEnogB8Ep83mJxaLPEDfmDdOFuYOvQrIaGiy7yOFX837KS?=
 =?us-ascii?Q?CE6BBdLgIhshawAoB2KtOtsDv7WUd59Hmcqn8DOUHhSmMIRmVEbecM8Z4NVJ?=
 =?us-ascii?Q?cyvBalwgtx21HsxuuXFHgbXMNCsIH27D89Q1fO+EpNwVgC/ZbywDutHLjpE+?=
 =?us-ascii?Q?A+yg/9w+ZLHx3u2naLL2Jk73xKvXiigE9f4d25w41nkdxYUkx3iDoYFcnhOy?=
 =?us-ascii?Q?ifJiZF4U1qD/pyaXf5QruxfSpP5UoBXNm00AnOO2i74GkJE+o1+xCaxxKZgy?=
 =?us-ascii?Q?n1gWAI1qa6CKiY2ugoZtk6w25amgDtXWvlUBH5Cbyyk2wVZURjGZy9NAWNFF?=
 =?us-ascii?Q?3RqCpC3Rc5aG4l5/TxD9uyNAcusgonTuTd2mjqt4zARTAQGrgbmB14I86ejw?=
 =?us-ascii?Q?PbnheUai/8Fw9vmIek3Rj/2K2YQQF8aCLib0yOsxYxuwmHAPxPe1QWyFTT6u?=
 =?us-ascii?Q?95sW1UWVU3jmveSXnfGJmNuzIYz/X5oPnarEdLdspoUsnc0f/bhRHwyIRTrS?=
 =?us-ascii?Q?OUClRpF1tM8lCZs+sTj1Xjvw+6E386Z4hZ70s0jMbI9kgPNn8SmMAZxfC4ex?=
 =?us-ascii?Q?AsS1muRlRPe+kPjstk0l08tSNKK9b90cJkOuC5UdPFRkEQDxqVZgCCefmS0X?=
 =?us-ascii?Q?FtuyGYAV3yaiQMpo9a2+GejAhR2ZfnLrkseslZS5DEA+XnmPESho+Q2S3HhM?=
 =?us-ascii?Q?Pt6r1M8o8oJ031S1rN5pyXw9X5eB+3kuqou3+eNImWCARazbmPN2ltJu+sGt?=
 =?us-ascii?Q?bSwZttWKvaFUIdugOeGVD8hIsj3aDftTOlPGSjYm+ZiJ0OS7GLKLADCnT45c?=
 =?us-ascii?Q?lOP/wb70+dX2OHtSyJUKiIAlE3/yiDCGSkX0S1k0LZdaqebm8mKClgmR0IP2?=
 =?us-ascii?Q?tJYdkggaNkPeITIU/FY+M3QnyW4FWTrHBeK8/Vu54y5T8tieNDsCWh7FU32k?=
 =?us-ascii?Q?+W02kIjCuyrj5ej3zr9BJnL58tW/1Ql1VPYIYlaA52eeE6ozBJQaS76KDGXR?=
 =?us-ascii?Q?xpMUfmy1Js8cTrmxzW2RZxC09myf6xLybqWXyRxYkPYlrZ9hkxfuS7eB/ma1?=
 =?us-ascii?Q?qEIPcpeN+XAH+1P4QeKao1PTxm1RmbKoEz48/avnNTra44ih6hcheQByAabl?=
 =?us-ascii?Q?qCMy2oQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XiALGpBSxLvEj/LzObbAiYDZHjDt3r1zuFD202Fv0Ix/El015oZptbktghVK?=
 =?us-ascii?Q?34peOVMpmQUawSJr1Zt0xmQOIkK8pKg4AMniEHV3RaqBhs0mhFovPWl2eVCp?=
 =?us-ascii?Q?asGjXZAn1M5lUiBfFmlHUZ8Y55J2aXHVxwLzZT7vutaMvP6hoNcjf+fQ3Hmy?=
 =?us-ascii?Q?ngyfXgDYM7cSUTKz4R1fFgg49yD7XExS4VXGuyaMMC2rkNbLq17h06RxJ6qI?=
 =?us-ascii?Q?I9kurYe1bMiNofp41Fyb4I8y8W2SoMGzbo3eBR8JThER9DElgTF0+81TvGrS?=
 =?us-ascii?Q?nHXkcHK7jzuaEl0xDCBXXxtYZ4n6yJqWqlCJ9qDfiPygv2e19/VZrkkbcbBz?=
 =?us-ascii?Q?HSj25+6uGaMyDpE5ICtD6+d6V3ZVeoDCa77B7vJ+TVxw2h/15ap742X9h5V7?=
 =?us-ascii?Q?CngCRnVG/r0hsdxu8pWpgqcoJqRtUsbkEbi8Om9ehv45g7BB5T5XItRkmMCl?=
 =?us-ascii?Q?fGOTvlmO/lukMMjn84yFeCRW5rhMgtCVLvnF12p641pQ+JshYCGEq65pQVYy?=
 =?us-ascii?Q?k1AQiklNIsLY6YznH3aOjVeAXrPuEUY1G236KsaCCT7GT0KR2zCfd8I6kkY4?=
 =?us-ascii?Q?DqLQ9CN8FSyDj606dRH6q0Vy2enQMw4BZD9ys3f3Oudzo348cIVM/auOTK/h?=
 =?us-ascii?Q?z+NF4YB0kEuKvm3sxl9J/pY5yuX6M5zq/+hYU40v9QHrAxE16/afzmClEsLR?=
 =?us-ascii?Q?b7YHFLrOoxCbykr3VOgVSM05sDNWUj/3GDgFkTghyqNnk5ZiYHmDiBpoJxuh?=
 =?us-ascii?Q?NBlQRDBgjlMeM7+AgBS1gFayrsOfdEnbrPLTbqKFbd5lp5ZM1Ps564cdQMiV?=
 =?us-ascii?Q?tEJneWnzhIyeLpljhoDZA3+Ts/pWiAOoRbkfPPcpYa6VV1c86+V5Zxr/1GBc?=
 =?us-ascii?Q?KTfFxd1FoYAGESayi6QQnQRGQCpi7FCHSUYQJXRyNmL6hUmS4+aQK2a5pFRD?=
 =?us-ascii?Q?kdqMb3VvB3s8E3noK1Rc02u8t88njnhF2alvIbGv+hLPeh11tV82gHgoYKjl?=
 =?us-ascii?Q?JZW3zq4bb6xRir4bKtJq6wnNtTpYLigqhQJM7lkAhXDskg4VPdrwcxyHk9v0?=
 =?us-ascii?Q?8pGshMNYVhFDtDvpEr8UH96HCRCDYNeFMJWVfj8OGEwM0i3Ut0Zn+mY4Wa7L?=
 =?us-ascii?Q?ucRjmreibXsWh0kDXLk6qRqmWtv9bI2ykjE/ZTI5HFDWcDsdnhNjmq0wtWjH?=
 =?us-ascii?Q?pEHgnl7SwGWCh4giFhRaToqQB1UKaa6rwYciJjL3a1m29smx0ev4AlXYmpv5?=
 =?us-ascii?Q?8WI9rKuh07d36PfsEshLf03tj3WYFLDIFuU+8ylvY/0wI9kPkXnBiMcEPjr0?=
 =?us-ascii?Q?K9wAo5YkCTR+ZcdpTdBHx5NeFCKGTVq7f1+jinbETUaiFR4fPNpnw2KAuqpa?=
 =?us-ascii?Q?RC8XjzSiBCviDci1v8lutqmApfPEoJHsu1dggfS/h2BZ41o42ARsjF8nUvqP?=
 =?us-ascii?Q?fD1SDtt4C7lZh8elBwEdNdop7wzZFvDECZw+7W5k2RSWx2QB9DMBrR+N7akW?=
 =?us-ascii?Q?CFZgRcd3IWtWBRkWwO63+4e9Q8XQTPYXOcT5E6dcoHK48IpOdTx6XNh4hqeZ?=
 =?us-ascii?Q?AVpTRQChtmL1ioo4ObgXVV24eNIzb+1jf9f7X52a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e8e84f-1991-4802-18f6-08dc91c7224b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:45.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWRv1wqU5BzQNeRztleqXKwKa5/O13gkxmo9bPm7iQyC1UPc7nD+7Ss530eLGmFXYM3nIAvPzQgk1BJIqB3pjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11n.c | 851 +++++++++++++++++++++++++
 1 file changed, 851 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n.c b/drivers/net/wireless/nxp/nxpwifi/11n.c
new file mode 100644
index 000000000000..76f01fa6387f
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n.c
@@ -0,0 +1,851 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11n
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
+
+/* Fills HT capability information field, AMPDU Parameters field, HT extended
+ * capability field, and supported MCS set fields.
+ *
+ * HT capability information field, AMPDU Parameters field, supported MCS set
+ * fields are retrieved from cfg80211 stack
+ *
+ * RD responder bit to set to clear in the extended capability header.
+ */
+int nxpwifi_fill_cap_info(struct nxpwifi_private *priv, u8 radio_type,
+			  struct ieee80211_ht_cap *ht_cap)
+{
+	u16 ht_cap_info;
+	u16 bcn_ht_cap = le16_to_cpu(ht_cap->cap_info);
+	u16 ht_ext_cap = le16_to_cpu(ht_cap->extended_ht_cap_info);
+	struct ieee80211_supported_band *sband =
+					priv->wdev.wiphy->bands[radio_type];
+
+	if (WARN_ON_ONCE(!sband)) {
+		nxpwifi_dbg(priv->adapter, ERROR, "Invalid radio type!\n");
+		return -EINVAL;
+	}
+
+	ht_cap->ampdu_params_info =
+		(sband->ht_cap.ampdu_factor &
+		 IEEE80211_HT_AMPDU_PARM_FACTOR) |
+		((sband->ht_cap.ampdu_density <<
+		 IEEE80211_HT_AMPDU_PARM_DENSITY_SHIFT) &
+		 IEEE80211_HT_AMPDU_PARM_DENSITY);
+
+	memcpy((u8 *)&ht_cap->mcs, &sband->ht_cap.mcs,
+	       sizeof(sband->ht_cap.mcs));
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION ||
+	    (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+	     priv->adapter->sec_chan_offset != IEEE80211_HT_PARAM_CHA_SEC_NONE))
+		/* Set MCS32 for infra mode or ad-hoc mode with 40MHz support */
+		SETHT_MCS32(ht_cap->mcs.rx_mask);
+
+	/* Clear RD responder bit */
+	ht_ext_cap &= ~IEEE80211_HT_EXT_CAP_RD_RESPONDER;
+
+	ht_cap_info = sband->ht_cap.cap;
+	if (bcn_ht_cap) {
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+			ht_cap_info &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_SGI_40))
+			ht_cap_info &= ~IEEE80211_HT_CAP_SGI_40;
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_40MHZ_INTOLERANT))
+			ht_cap_info &= ~IEEE80211_HT_CAP_40MHZ_INTOLERANT;
+	}
+	ht_cap->cap_info = cpu_to_le16(ht_cap_info);
+	ht_cap->extended_ht_cap_info = cpu_to_le16(ht_ext_cap);
+
+	if (ISSUPP_BEAMFORMING(priv->adapter->hw_dot_11n_dev_cap))
+		ht_cap->tx_BF_cap_info = cpu_to_le32(NXPWIFI_DEF_11N_TX_BF_CAP);
+
+	return 0;
+}
+
+/* This function returns the pointer to an entry in BA Stream
+ * table which matches the requested BA status.
+ */
+static struct nxpwifi_tx_ba_stream_tbl *
+nxpwifi_get_ba_status(struct nxpwifi_private *priv,
+		      enum nxpwifi_ba_status ba_status)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tx_ba_tsr_tbl->ba_status == ba_status) {
+			spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+			return tx_ba_tsr_tbl;
+		}
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+	return NULL;
+}
+
+/* This function handles the command response of delete a block
+ * ack request.
+ *
+ * The function checks the response success status and takes action
+ * accordingly (send an add BA request in case of success, or recreate
+ * the deleted stream in case of failure, if the add BA was also
+ * initiated by us).
+ */
+int nxpwifi_ret_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp)
+{
+	int tid;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tbl;
+	struct host_cmd_ds_11n_delba *del_ba = &resp->params.del_ba;
+	u16 del_ba_param_set = le16_to_cpu(del_ba->del_ba_param_set);
+
+	tid = del_ba_param_set >> DELBA_TID_POS;
+	if (del_ba->del_result == BA_RESULT_SUCCESS) {
+		nxpwifi_del_ba_tbl(priv, tid, del_ba->peer_mac_addr,
+				   TYPE_DELBA_SENT,
+				   INITIATOR_BIT(del_ba_param_set));
+
+		tx_ba_tbl = nxpwifi_get_ba_status(priv, BA_SETUP_INPROGRESS);
+		if (tx_ba_tbl)
+			nxpwifi_send_addba(priv, tx_ba_tbl->tid,
+					   tx_ba_tbl->ra);
+	} else { /*
+		  * In case of failure, recreate the deleted stream in case
+		  * we initiated the DELBA
+		  */
+		if (!INITIATOR_BIT(del_ba_param_set))
+			return 0;
+
+		nxpwifi_create_ba_tbl(priv, del_ba->peer_mac_addr, tid,
+				      BA_SETUP_INPROGRESS);
+
+		tx_ba_tbl = nxpwifi_get_ba_status(priv, BA_SETUP_INPROGRESS);
+
+		if (tx_ba_tbl)
+			nxpwifi_del_ba_tbl(priv, tx_ba_tbl->tid, tx_ba_tbl->ra,
+					   TYPE_DELBA_SENT, true);
+	}
+
+	return 0;
+}
+
+/* This function handles the command response of add a block
+ * ack request.
+ *
+ * Handling includes changing the header fields to CPU formats, checking
+ * the response success status and taking actions accordingly (delete the
+ * BA stream table in case of failure).
+ */
+int nxpwifi_ret_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp)
+{
+	int tid, tid_down;
+	struct host_cmd_ds_11n_addba_rsp *add_ba_rsp = &resp->params.add_ba_rsp;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tbl;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	u16 block_ack_param_set = le16_to_cpu(add_ba_rsp->block_ack_param_set);
+
+	add_ba_rsp->ssn = cpu_to_le16((le16_to_cpu(add_ba_rsp->ssn))
+			& SSN_MASK);
+
+	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
+	       >> BLOCKACKPARAM_TID_POS;
+
+	tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+	ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down,
+					      add_ba_rsp->peer_mac_addr);
+	if (le16_to_cpu(add_ba_rsp->status_code) != BA_RESULT_SUCCESS) {
+		if (ra_list) {
+			ra_list->ba_status = BA_SETUP_NONE;
+			ra_list->amsdu_in_ampdu = false;
+		}
+		nxpwifi_del_ba_tbl(priv, tid, add_ba_rsp->peer_mac_addr,
+				   TYPE_DELBA_SENT, true);
+		if (add_ba_rsp->add_rsp_result != BA_RESULT_TIMEOUT)
+			priv->aggr_prio_tbl[tid].ampdu_ap =
+				BA_STREAM_NOT_ALLOWED;
+		return 0;
+	}
+
+	tx_ba_tbl = nxpwifi_get_ba_tbl(priv, tid, add_ba_rsp->peer_mac_addr);
+	if (tx_ba_tbl) {
+		nxpwifi_dbg(priv->adapter, EVENT, "info: BA stream complete\n");
+		tx_ba_tbl->ba_status = BA_SETUP_COMPLETE;
+		if ((block_ack_param_set & BLOCKACKPARAM_AMSDU_SUPP_MASK) &&
+		    priv->add_ba_param.tx_amsdu &&
+		    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+			tx_ba_tbl->amsdu = true;
+		else
+			tx_ba_tbl->amsdu = false;
+		if (ra_list) {
+			ra_list->amsdu_in_ampdu = tx_ba_tbl->amsdu;
+			ra_list->ba_status = BA_SETUP_COMPLETE;
+		}
+	} else {
+		nxpwifi_dbg(priv->adapter, ERROR, "BA stream not created\n");
+	}
+
+	return 0;
+}
+
+/* This function prepares command of reconfigure Tx buffer.
+ *
+ * Preparation includes -
+ *      - Setting command ID, action and proper size
+ *      - Setting Tx buffer size (for SET only)
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_recfg_tx_buf(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd, int cmd_action,
+			     u16 *buf_size)
+{
+	struct host_cmd_ds_txbuf_cfg *tx_buf = &cmd->params.tx_buf;
+	u16 action = (u16)cmd_action;
+
+	cmd->command = cpu_to_le16(HOST_CMD_RECONFIGURE_TX_BUFF);
+	cmd->size =
+		cpu_to_le16(sizeof(struct host_cmd_ds_txbuf_cfg) + S_DS_GEN);
+	tx_buf->action = cpu_to_le16(action);
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: set tx_buf=%d\n", *buf_size);
+		tx_buf->buff_size = cpu_to_le16(*buf_size);
+		break;
+	case HOST_ACT_GEN_GET:
+	default:
+		tx_buf->buff_size = 0;
+		break;
+	}
+	return 0;
+}
+
+/* This function prepares command of AMSDU aggregation control.
+ *
+ * Preparation includes -
+ *      - Setting command ID, action and proper size
+ *      - Setting AMSDU control parameters (for SET only)
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_amsdu_aggr_ctrl(struct host_cmd_ds_command *cmd,
+				int cmd_action,
+				struct nxpwifi_ds_11n_amsdu_aggr_ctrl *aa_ctrl)
+{
+	struct host_cmd_ds_amsdu_aggr_ctrl *amsdu_ctrl =
+		&cmd->params.amsdu_aggr_ctrl;
+	u16 action = (u16)cmd_action;
+
+	cmd->command = cpu_to_le16(HOST_CMD_AMSDU_AGGR_CTRL);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_amsdu_aggr_ctrl)
+				+ S_DS_GEN);
+	amsdu_ctrl->action = cpu_to_le16(action);
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		amsdu_ctrl->enable = cpu_to_le16(aa_ctrl->enable);
+		amsdu_ctrl->curr_buf_size = 0;
+		break;
+	case HOST_ACT_GEN_GET:
+	default:
+		amsdu_ctrl->curr_buf_size = 0;
+		break;
+	}
+	return 0;
+}
+
+/* This function prepares 11n configuration command.
+ *
+ * Preparation includes -
+ *      - Setting command ID, action and proper size
+ *      - Setting HT Tx capability and HT Tx information fields
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_11n_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_ds_11n_tx_cfg *txcfg)
+{
+	struct host_cmd_ds_11n_cfg *htcfg = &cmd->params.htcfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_11n_cfg) + S_DS_GEN);
+	htcfg->action = cpu_to_le16(cmd_action);
+	htcfg->ht_tx_cap = cpu_to_le16(txcfg->tx_htcap);
+	htcfg->ht_tx_info = cpu_to_le16(txcfg->tx_htinfo);
+
+	if (priv->adapter->is_hw_11ac_capable)
+		htcfg->misc_config = cpu_to_le16(txcfg->misc_config);
+
+	return 0;
+}
+
+/* This function appends an 11n TLV to a buffer.
+ *
+ * Buffer allocation is responsibility of the calling
+ * function. No size validation is made here.
+ *
+ * The function fills up the following sections, if applicable -
+ *      - HT capability IE
+ *      - HT information IE (with channel list)
+ *      - 20/40 BSS Coexistence IE
+ *      - HT Extended Capabilities IE
+ */
+int
+nxpwifi_cmd_append_11n_tlv(struct nxpwifi_private *priv,
+			   struct nxpwifi_bssdescriptor *bss_desc,
+			   u8 **buffer)
+{
+	struct nxpwifi_ie_types_htcap *ht_cap;
+	struct nxpwifi_ie_types_chan_list_param_set *chan_list;
+	struct nxpwifi_ie_types_2040bssco *bss_co_2040;
+	struct nxpwifi_ie_types_extcap *ext_cap;
+	int ret_len = 0;
+	struct ieee80211_supported_band *sband;
+	struct ieee_types_header *hdr;
+	u8 radio_type;
+
+	if (!buffer || !*buffer)
+		return ret_len;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	if (bss_desc->bcn_ht_cap) {
+		ht_cap = (struct nxpwifi_ie_types_htcap *)*buffer;
+		memset(ht_cap, 0, sizeof(struct nxpwifi_ie_types_htcap));
+		ht_cap->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		ht_cap->header.len =
+				cpu_to_le16(sizeof(struct ieee80211_ht_cap));
+		memcpy((u8 *)ht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_ht_cap,
+		       le16_to_cpu(ht_cap->header.len));
+
+		nxpwifi_fill_cap_info(priv, radio_type, &ht_cap->ht_cap);
+		/* Update HT40 capability from current channel information */
+		if (bss_desc->bcn_ht_oper) {
+			u8 ht_param = bss_desc->bcn_ht_oper->ht_param;
+			u8 radio =
+			nxpwifi_band_to_radio_type(bss_desc->bss_band);
+			int freq =
+			ieee80211_channel_to_frequency(bss_desc->channel,
+						       radio);
+			struct ieee80211_channel *chan =
+			ieee80211_get_channel(priv->adapter->wiphy, freq);
+
+			switch (ht_param & IEEE80211_HT_PARAM_CHA_SEC_OFFSET) {
+			case IEEE80211_HT_PARAM_CHA_SEC_ABOVE:
+				if (chan->flags & IEEE80211_CHAN_NO_HT40PLUS) {
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16
+					(~IEEE80211_HT_CAP_SUP_WIDTH_20_40);
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16(~IEEE80211_HT_CAP_SGI_40);
+				}
+				break;
+			case IEEE80211_HT_PARAM_CHA_SEC_BELOW:
+				if (chan->flags & IEEE80211_CHAN_NO_HT40MINUS) {
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16
+					(~IEEE80211_HT_CAP_SUP_WIDTH_20_40);
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16(~IEEE80211_HT_CAP_SGI_40);
+				}
+				break;
+			}
+		}
+
+		*buffer += sizeof(struct nxpwifi_ie_types_htcap);
+		ret_len += sizeof(struct nxpwifi_ie_types_htcap);
+	}
+
+	if (bss_desc->bcn_ht_oper) {
+		chan_list =
+			(struct nxpwifi_ie_types_chan_list_param_set *)*buffer;
+		memset(chan_list, 0, struct_size(chan_list, chan_scan_param, 1));
+		chan_list->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
+		chan_list->header.len =
+			cpu_to_le16(sizeof(struct nxpwifi_chan_scan_param_set));
+		chan_list->chan_scan_param[0].chan_number =
+			bss_desc->bcn_ht_oper->primary_chan;
+		chan_list->chan_scan_param[0].radio_type =
+			nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+
+		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+		    bss_desc->bcn_ht_oper->ht_param &
+		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
+			SET_SECONDARYCHAN
+			(chan_list->chan_scan_param[0].radio_type,
+			 (bss_desc->bcn_ht_oper->ht_param &
+			 IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
+
+		*buffer += struct_size(chan_list, chan_scan_param, 1);
+		ret_len += struct_size(chan_list, chan_scan_param, 1);
+	}
+
+	if (bss_desc->bcn_bss_co_2040) {
+		bss_co_2040 = (struct nxpwifi_ie_types_2040bssco *)*buffer;
+		memset(bss_co_2040, 0,
+		       sizeof(struct nxpwifi_ie_types_2040bssco));
+		bss_co_2040->header.type = cpu_to_le16(WLAN_EID_BSS_COEX_2040);
+		bss_co_2040->header.len =
+		       cpu_to_le16(sizeof(bss_co_2040->bss_co_2040));
+
+		memcpy((u8 *)bss_co_2040 +
+		       sizeof(struct nxpwifi_ie_types_header),
+		       bss_desc->bcn_bss_co_2040 +
+		       sizeof(struct ieee_types_header),
+		       le16_to_cpu(bss_co_2040->header.len));
+
+		*buffer += sizeof(struct nxpwifi_ie_types_2040bssco);
+		ret_len += sizeof(struct nxpwifi_ie_types_2040bssco);
+	}
+
+	if (bss_desc->bcn_ext_cap) {
+		hdr = (void *)bss_desc->bcn_ext_cap;
+		ext_cap = (struct nxpwifi_ie_types_extcap *)*buffer;
+		memset(ext_cap, 0, sizeof(struct nxpwifi_ie_types_extcap));
+		ext_cap->header.type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		ext_cap->header.len = cpu_to_le16(hdr->len);
+
+		memcpy((u8 *)ext_cap->ext_capab,
+		       bss_desc->bcn_ext_cap + sizeof(struct ieee_types_header),
+		       le16_to_cpu(ext_cap->header.len));
+
+		if (hdr->len > 3 &&
+		    ext_cap->ext_capab[3] & WLAN_EXT_CAPA4_INTERWORKING_ENABLED)
+			priv->hs2_enabled = true;
+		else
+			priv->hs2_enabled = false;
+
+		*buffer += sizeof(struct nxpwifi_ie_types_extcap) + hdr->len;
+		ret_len += sizeof(struct nxpwifi_ie_types_extcap) + hdr->len;
+	}
+
+	return ret_len;
+}
+
+/* This function checks if the given pointer is valid entry of
+ * Tx BA Stream table.
+ */
+static int
+nxpwifi_is_tx_ba_stream_ptr_valid(struct nxpwifi_private *priv,
+				  struct nxpwifi_tx_ba_stream_tbl *tx_tbl_ptr)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tx_ba_tsr_tbl == tx_tbl_ptr)
+			return true;
+	}
+
+	return false;
+}
+
+/* This function deletes the given entry in Tx BA Stream table.
+ *
+ * The function also performs a validity check on the supplied
+ * pointer before trying to delete.
+ */
+void
+nxpwifi_11n_delete_tx_ba_stream_tbl_entry(struct nxpwifi_private *priv,
+					  struct nxpwifi_tx_ba_stream_tbl *tbl)
+{
+	if (!tbl && nxpwifi_is_tx_ba_stream_ptr_valid(priv, tbl))
+		return;
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: tx_ba_tsr_tbl %p\n", tbl);
+
+	list_del(&tbl->list);
+
+	kfree(tbl);
+}
+
+/* This function deletes all the entries in Tx BA Stream table.
+ */
+void nxpwifi_11n_delete_all_tx_ba_stream_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_tx_ba_stream_tbl *del_tbl_ptr, *tmp_node;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry_safe(del_tbl_ptr, tmp_node,
+				 &priv->tx_ba_stream_tbl_ptr, list)
+		nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, del_tbl_ptr);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+
+	INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr);
+
+	for (i = 0; i < MAX_NUM_TID; ++i)
+		priv->aggr_prio_tbl[i].ampdu_ap =
+			priv->aggr_prio_tbl[i].ampdu_user;
+}
+
+/* This function returns the pointer to an entry in BA Stream
+ * table which matches the given RA/TID pair.
+ */
+struct nxpwifi_tx_ba_stream_tbl *
+nxpwifi_get_ba_tbl(struct nxpwifi_private *priv, int tid, u8 *ra)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (ether_addr_equal_unaligned(tx_ba_tsr_tbl->ra, ra) &&
+		    tx_ba_tsr_tbl->tid == tid) {
+			spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+			return tx_ba_tsr_tbl;
+		}
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+	return NULL;
+}
+
+/* This function creates an entry in Tx BA stream table for the
+ * given RA/TID pair.
+ */
+void nxpwifi_create_ba_tbl(struct nxpwifi_private *priv, u8 *ra, int tid,
+			   enum nxpwifi_ba_status ba_status)
+{
+	struct nxpwifi_tx_ba_stream_tbl *new_node;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	int tid_down;
+
+	if (!nxpwifi_get_ba_tbl(priv, tid, ra)) {
+		new_node = kzalloc(sizeof(*new_node), GFP_ATOMIC);
+		if (!new_node)
+			return;
+
+		tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+		ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down, ra);
+		if (ra_list) {
+			ra_list->ba_status = ba_status;
+			ra_list->amsdu_in_ampdu = false;
+		}
+		INIT_LIST_HEAD(&new_node->list);
+
+		new_node->tid = tid;
+		new_node->ba_status = ba_status;
+		memcpy(new_node->ra, ra, ETH_ALEN);
+
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+		list_add_tail(&new_node->list, &priv->tx_ba_stream_tbl_ptr);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+	}
+}
+
+/* This function sends an add BA request to the given TID/RA pair.
+ */
+int nxpwifi_send_addba(struct nxpwifi_private *priv, int tid, u8 *peer_mac)
+{
+	struct host_cmd_ds_11n_addba_req add_ba_req;
+	u32 tx_win_size = priv->add_ba_param.tx_win_size;
+	static u8 dialog_tok;
+	int ret;
+	u16 block_ack_param_set;
+
+	nxpwifi_dbg(priv->adapter, CMD, "cmd: %s: tid %d\n", __func__, tid);
+
+	memset(&add_ba_req, 0, sizeof(add_ba_req));
+
+	block_ack_param_set = (u16)((tid << BLOCKACKPARAM_TID_POS) |
+				    tx_win_size << BLOCKACKPARAM_WINSIZE_POS |
+				    IMMEDIATE_BLOCK_ACK);
+
+	/* enable AMSDU inside AMPDU */
+	if (priv->add_ba_param.tx_amsdu &&
+	    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+		block_ack_param_set |= BLOCKACKPARAM_AMSDU_SUPP_MASK;
+
+	add_ba_req.block_ack_param_set = cpu_to_le16(block_ack_param_set);
+	add_ba_req.block_ack_tmo = cpu_to_le16((u16)priv->add_ba_param.timeout);
+
+	++dialog_tok;
+
+	if (dialog_tok == 0)
+		dialog_tok = 1;
+
+	add_ba_req.dialog_token = dialog_tok;
+	memcpy(&add_ba_req.peer_mac_addr, peer_mac, ETH_ALEN);
+
+	/* We don't wait for the response of this command */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_11N_ADDBA_REQ,
+			       0, 0, &add_ba_req, false);
+
+	return ret;
+}
+
+/* This function sends a delete BA request to the given TID/RA pair.
+ */
+int nxpwifi_send_delba(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		       int initiator)
+{
+	struct host_cmd_ds_11n_delba delba;
+	int ret;
+	u16 del_ba_param_set;
+
+	memset(&delba, 0, sizeof(delba));
+
+	del_ba_param_set = tid << DELBA_TID_POS;
+
+	if (initiator)
+		del_ba_param_set |= IEEE80211_DELBA_PARAM_INITIATOR_MASK;
+	else
+		del_ba_param_set &= ~IEEE80211_DELBA_PARAM_INITIATOR_MASK;
+
+	delba.del_ba_param_set = cpu_to_le16(del_ba_param_set);
+	memcpy(&delba.peer_mac_addr, peer_mac, ETH_ALEN);
+
+	/* We don't wait for the response of this command */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_11N_DELBA,
+			       HOST_ACT_GEN_SET, 0, &delba, false);
+
+	return ret;
+}
+
+/* This function sends delba to specific tid
+ */
+void nxpwifi_11n_delba(struct nxpwifi_private *priv, int tid)
+{
+	struct nxpwifi_rx_reorder_tbl *rx_reor_tbl_ptr;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_for_each_entry(rx_reor_tbl_ptr, &priv->rx_reorder_tbl_ptr, list) {
+		if (rx_reor_tbl_ptr->tid == tid) {
+			dev_dbg(priv->adapter->dev,
+				"Send delba to tid=%d, %pM\n",
+				tid, rx_reor_tbl_ptr->ta);
+			nxpwifi_send_delba(priv, tid, rx_reor_tbl_ptr->ta, 0);
+			goto exit;
+		}
+	}
+exit:
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+}
+
+/* This function handles the command response of a delete BA request.
+ */
+void nxpwifi_11n_delete_ba_stream(struct nxpwifi_private *priv, u8 *del_ba)
+{
+	struct host_cmd_ds_11n_delba *cmd_del_ba =
+		(struct host_cmd_ds_11n_delba *)del_ba;
+	u16 del_ba_param_set = le16_to_cpu(cmd_del_ba->del_ba_param_set);
+	int tid;
+
+	tid = del_ba_param_set >> DELBA_TID_POS;
+
+	nxpwifi_del_ba_tbl(priv, tid, cmd_del_ba->peer_mac_addr,
+			   TYPE_DELBA_RECEIVE, INITIATOR_BIT(del_ba_param_set));
+}
+
+/* This function retrieves the Rx reordering table.
+ */
+int nxpwifi_get_rx_reorder_tbl(struct nxpwifi_private *priv,
+			       struct nxpwifi_ds_rx_reorder_tbl *buf)
+{
+	int i;
+	struct nxpwifi_ds_rx_reorder_tbl *rx_reo_tbl = buf;
+	struct nxpwifi_rx_reorder_tbl *rx_reorder_tbl_ptr;
+	int count = 0;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_for_each_entry(rx_reorder_tbl_ptr, &priv->rx_reorder_tbl_ptr,
+			    list) {
+		rx_reo_tbl->tid = (u16)rx_reorder_tbl_ptr->tid;
+		memcpy(rx_reo_tbl->ta, rx_reorder_tbl_ptr->ta, ETH_ALEN);
+		rx_reo_tbl->start_win = rx_reorder_tbl_ptr->start_win;
+		rx_reo_tbl->win_size = rx_reorder_tbl_ptr->win_size;
+		for (i = 0; i < rx_reorder_tbl_ptr->win_size; ++i) {
+			if (rx_reorder_tbl_ptr->rx_reorder_ptr[i])
+				rx_reo_tbl->buffer[i] = true;
+			else
+				rx_reo_tbl->buffer[i] = false;
+		}
+		rx_reo_tbl++;
+		count++;
+
+		if (count >= NXPWIFI_MAX_RX_BASTREAM_SUPPORTED)
+			break;
+	}
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	return count;
+}
+
+/* This function retrieves the Tx BA stream table.
+ */
+int nxpwifi_get_tx_ba_stream_tbl(struct nxpwifi_private *priv,
+				 struct nxpwifi_ds_tx_ba_stream_tbl *buf)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+	struct nxpwifi_ds_tx_ba_stream_tbl *rx_reo_tbl = buf;
+	int count = 0;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		rx_reo_tbl->tid = (u16)tx_ba_tsr_tbl->tid;
+		nxpwifi_dbg(priv->adapter, DATA, "data: %s tid=%d\n",
+			    __func__, rx_reo_tbl->tid);
+		memcpy(rx_reo_tbl->ra, tx_ba_tsr_tbl->ra, ETH_ALEN);
+		rx_reo_tbl->amsdu = tx_ba_tsr_tbl->amsdu;
+		rx_reo_tbl++;
+		count++;
+		if (count >= NXPWIFI_MAX_TX_BASTREAM_SUPPORTED)
+			break;
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+
+	return count;
+}
+
+/* This function retrieves the entry for specific tx BA stream table by RA and
+ * deletes it.
+ */
+void nxpwifi_del_tx_ba_stream_tbl_by_ra(struct nxpwifi_private *priv, u8 *ra)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tbl, *tmp;
+
+	if (!ra)
+		return;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry_safe(tbl, tmp, &priv->tx_ba_stream_tbl_ptr, list)
+		if (!memcmp(tbl->ra, ra, ETH_ALEN))
+			nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, tbl);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+}
+
+/* This function initializes the BlockACK setup information for given
+ * nxpwifi_private structure.
+ */
+void nxpwifi_set_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+						NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+						NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+						NXPWIFI_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+						NXPWIFI_STA_AMPDU_DEF_RXWINSIZE;
+	}
+
+	priv->add_ba_param.tx_amsdu = true;
+	priv->add_ba_param.rx_amsdu = true;
+}
+
+u8 nxpwifi_get_sec_chan_offset(int chan)
+{
+	u8 sec_offset;
+
+	switch (chan) {
+	case 36:
+	case 44:
+	case 52:
+	case 60:
+	case 100:
+	case 108:
+	case 116:
+	case 124:
+	case 132:
+	case 140:
+	case 149:
+	case 157:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_ABOVE;
+		break;
+	case 40:
+	case 48:
+	case 56:
+	case 64:
+	case 104:
+	case 112:
+	case 120:
+	case 128:
+	case 136:
+	case 144:
+	case 153:
+	case 161:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_BELOW;
+		break;
+	case 165:
+	default:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_NONE;
+		break;
+	}
+
+	return sec_offset;
+}
+
+/* This function will send DELBA to entries in the priv's
+ * Tx BA stream table
+ */
+static void
+nxpwifi_send_delba_txbastream_tbl(struct nxpwifi_private *priv, u8 tid)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_stream_tbl_ptr;
+
+	list_for_each_entry(tx_ba_stream_tbl_ptr,
+			    &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tx_ba_stream_tbl_ptr->ba_status == BA_SETUP_COMPLETE) {
+			if (tid == tx_ba_stream_tbl_ptr->tid) {
+				dev_dbg(adapter->dev,
+					"Tx:Send delba to tid=%d, %pM\n", tid,
+					tx_ba_stream_tbl_ptr->ra);
+				nxpwifi_send_delba(priv,
+						   tx_ba_stream_tbl_ptr->tid,
+						   tx_ba_stream_tbl_ptr->ra, 1);
+				return;
+			}
+		}
+	}
+}
+
+/* This function updates all the tx_win_size
+ */
+void nxpwifi_update_ampdu_txwinsize(struct nxpwifi_adapter *adapter)
+{
+	u8 i, j;
+	u32 tx_win_size;
+	struct nxpwifi_private *priv;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (!adapter->priv[i])
+			continue;
+		priv = adapter->priv[i];
+		tx_win_size = priv->add_ba_param.tx_win_size;
+
+		if (priv->bss_type == NXPWIFI_BSS_TYPE_STA)
+			priv->add_ba_param.tx_win_size =
+				NXPWIFI_STA_AMPDU_DEF_TXWINSIZE;
+
+		if (priv->bss_type == NXPWIFI_BSS_TYPE_UAP)
+			priv->add_ba_param.tx_win_size =
+				NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE;
+
+		if (adapter->coex_win_size) {
+			if (adapter->coex_tx_win_size)
+				priv->add_ba_param.tx_win_size =
+					adapter->coex_tx_win_size;
+		}
+
+		if (tx_win_size != priv->add_ba_param.tx_win_size) {
+			if (!priv->media_connected)
+				continue;
+			for (j = 0; j < MAX_NUM_TID; j++)
+				nxpwifi_send_delba_txbastream_tbl(priv, j);
+		}
+	}
+}
-- 
2.34.1


