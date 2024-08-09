Return-Path: <linux-wireless+bounces-11180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26C794CD89
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319471F222CF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9D191F6E;
	Fri,  9 Aug 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D2MR9Bnm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B21922EF;
	Fri,  9 Aug 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196765; cv=fail; b=e0KMFkwTarcfUPzoGYNw+Ew2B+F1IsnvcGgaarADyPvxJNDkZVdP9MEmA/Viuw4TfEucMsrRfVcL2a+dWnM3QhvkymqaOGEoI24sebL0zlL+AgoCWUFPzXWSD1oxh7osBrMucvapeiMtgbcW6k5T+YbEhPs7IYqk6JijgtgYC+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196765; c=relaxed/simple;
	bh=GgaKPoPlrHgrzHO0t8ngKmKKqPQwHU5uQ5IIBRevfgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipruKcBivv0LB/6tiVCtWsXNRYJlPdgoW7SICQRekisFD0IkTBP9Di0Ne2YWo7vArY8eznWh+m0CkBSDHfEGgBpWtbizRG0+VAkAsCVbDv1LgwSHOHIGBVxtrZll+LIbq9I1QuyD1unXmblye6ptfdw4qnS2A8oZeblDTrWcRcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D2MR9Bnm; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLhf+HRudi9owxFIoXEIGbMjlw5Jo/DKg7fzxvyQrz6kkV8ZyziYNtIvWhrwVO0m2DDDqprbFqqUslOFu8N0dxa6ySIlgseQPYX1ZsWH6sQDK/a66HjyDb+J1x5Mh4UN8KPzM5TqSuSuCTjtthQpbHYR2ndcU94x65OzR9vZLjFRHzXGZveKO4CQlg00SUVB/AcWJpt6SIe92y8ragKiXiGOwee15XJhE74ygaC6BBGzCEexDHXMSSn1MtLBiZ/FXqg1iuPbenD0QKCz28ymvIvZa2pHplqrWyR//yQGLuyka2KW7o2IORWy7aItJ+52uomi0TTLu9zSbMM1kCY2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5fmHESFm0OpZJJtiuZv0GbuylV9Y2S0aS5AQa1v2Zc=;
 b=fD2NQe7DlRURE6rN5Ej2Ld41C2ZQiOiQxQNFZ0gIYOOQa3J9PeVVhIALtR0FCEYqey748kWDEmIviL5Xh/K9XwSlkunXdK+EBaQcnMetAL68x5Pt3hK2e1WmsnM9ZMl3zFNP2092bi8ePk1kw6dUu5KVkMfYxt6vWoM6kwBSqtNCMwh5uHHvDVhmyfutA1kODj3UDgqKuTgq8RYOLFc9D+qMaZ+ArED0YaiVr4fJGenOIrMZylTYftbAHq9XEb4D9jO24wnQk6EqjVsFUzfHwMhJh5tM6jDwvt8GcXQ2lq1YVyyeftjWp28RzAsEoKUiq5Rz2cKAxGwfvIjXta0ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5fmHESFm0OpZJJtiuZv0GbuylV9Y2S0aS5AQa1v2Zc=;
 b=D2MR9BnmhJ9KPPjphKxMZJOsddwu03YANic7RjdCM1pPB9p8IvjPJeH44aYn9dl77WQ94rV/KY0XfDujXd5Qs/seCXvOeecfi8vd5lfaBFpMYSnMHs6Pg2r4sa1T1349bG4IQIbcrsIcRxndPxrfjjjMhZ1sxf+1/xH45v65sEW2mP8xWVCA3g5YDa80Yr3LhLRxdYVGv2hoeY2oR2rjIjyLHFd1xwK/G1xrXoAY0Sc/PiRJrh3FROikxbmuuWimfw1qn7NufAbOFFQgJdKhTsSxoWH6tNYecVeC1HKtK3s7KBhNAEMEmq0SBEAYQ7GS0q6nve1Hq9CuABXxlltSng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:00 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:00 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 03/43] wifi: nxpwifi: add 11h.c
Date: Fri,  9 Aug 2024 17:44:53 +0800
Message-Id: <20240809094533.1660-4-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: f35bf027-12ba-46b3-58fe-08dcb858134a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+wekley2HDAIgj83k4bEJZqD+pAhzsCw2ceOOwmc5n0MhW99ivKAGRSgJlLr?=
 =?us-ascii?Q?lMgA8KtZvqjrCdYlBkOsa5B2/y3XjNp8388c10UTwQWL7EcS67vPO2LBaKK3?=
 =?us-ascii?Q?FIx0/+WoiZuEumaNyAugY3gKyCDJg0cCD42hfvNwBjT1rKzTmIa82ZFAz9P2?=
 =?us-ascii?Q?FN9JiMYT9tfnE+mk22AGyiu1q3jVovGfdEhkIRp0pNe9GJD8lPmeAG25HaAG?=
 =?us-ascii?Q?fPI1uaxW7zR9u8wbEzgvEwQcx2uoj/0euGWFJCnBGv+E0GD95lyFCxMVZMlk?=
 =?us-ascii?Q?b3IjMIrDdDsweSivDCsmLx/NiSQFgAm3e/s1C4ZKkZxqZoTheswPihUGrPYT?=
 =?us-ascii?Q?JPZ8M0NVBlqQWGEtY09WEZ2ZAYmmrY3z9IQp1ttda/usHZRZJBoJfJSfh415?=
 =?us-ascii?Q?kNg8c04XxvIqaQWkqw4pcDtK+DC3IZsEagj+MMSarzllvYPspsBMQY1QB6PA?=
 =?us-ascii?Q?4Yyzt3qdT5ammR2smHe0aCYmn8sQrgBep1v8kg2pP1BOodho5lwimNVRCztl?=
 =?us-ascii?Q?hiobmcCRhi36EDcktaDguNd2j6mv/4yllzd9f8Bu78t2w/q25gW4vcSjDAD8?=
 =?us-ascii?Q?eBGoTuLvwk8OZHCwcI+CetlDXiNwVGOe7XHedvSNKYsWoax6KAzzHT+ixO/C?=
 =?us-ascii?Q?9sbjx9ZSkmtttYYiwMsgH395agqwYjwIa14aGJ4vsH/Ssv+Qzfy7Rdeo2wt+?=
 =?us-ascii?Q?AAxJk/hZ3IWWoB64sD4OTyyUB4nvUcGi5x/VNwh/BALv7sp7oph7BBLUQ/ls?=
 =?us-ascii?Q?S8qw3WpnV8NpseKRIM5N3LXkmtf1mDJy45Qwgx1Cvlxd6If2zKYLjJT4aFMx?=
 =?us-ascii?Q?pRRW8br7dm5RALWd0/62/pBJ5aKxVzKpCsMFcZQP18kFBbseBqq1EalqHwEi?=
 =?us-ascii?Q?o5SG6e1noPqFJf/2MOasBLBLuiL9ScOvy6/si4lVVLYCAN/XbftENGtRSdjV?=
 =?us-ascii?Q?lMbTJPJ9anJAFkTTq2NPCyvvMmibfS6/T3dWuTQS8C04i2slyTPONAAUkxko?=
 =?us-ascii?Q?lO1oTb3PjGqIYSztn+ujLwc3oaGioDIzuoNYMVnzv0otuCm9btNZbU2rC4nM?=
 =?us-ascii?Q?OZaLduzAupwMdZu87JOUk2J30Fdm+cctvTz1FU1VvrCDxBbsYSzJcElhzf5q?=
 =?us-ascii?Q?kwz7MCrddpFixdkdb/uskRDE4k8RvaIXpIApFnBXYkHPU7uu0xHV77xbJJ7+?=
 =?us-ascii?Q?NblaKbTMFVt8SA520NkZPWWurawMDiH1kvm4geJooRwKhJekBkfP9CZp/BPJ?=
 =?us-ascii?Q?u/tD038sPgXy/Egw6Xe1qOJ6Q5vZ4ppXahrejXo/Nj0JRwOtGW55leSlBVJ5?=
 =?us-ascii?Q?dI/5RxgVWrNssh79ckrgLO8I9q5KlLEKUZRgZ1YpfinC1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEUayJID/jcznK//dQOtXx8a/D9Ah/wuks6HJLM+4gQKP+RiG0SeS9Gmh6Tj?=
 =?us-ascii?Q?R7sL0CStZ7OX8X2P0NrPQEttH+GnkZimq1NR9GBgAgWBdhMgj+pa+KMNCL8R?=
 =?us-ascii?Q?Jphp6XeBZG3TOxpq38Mcdi7s8iXYatBokJqW/wgQ22GfD+QHnwT0toiHWRMc?=
 =?us-ascii?Q?l9WWthNUwA88u4slG39MkPKMSSwN5kVbhLVcN7ww3EsaSmZT2I8KqxNm41yV?=
 =?us-ascii?Q?KddQRupnGb73UmkToOiakvZbqZeaCrDo5yuEVEfMtlhXV0woYZwDibaOZImU?=
 =?us-ascii?Q?9YQPZkdwvii0pX1D4I+1ZXBIJsba0ysIPi204piJa7yd17q6eOg20jQe0Bjv?=
 =?us-ascii?Q?WHZFaQYcpQcwCaQrZvf6y9CSvEqwljGgzEgz/Pnu3Z6fXHL80u5HNRvVyTcF?=
 =?us-ascii?Q?rddJgh8usS3BRVuBh8c+16RFcO/YXK77jhxxyP9n1RUFayAFZ/XrqwMbYeoX?=
 =?us-ascii?Q?dAuNTS5CCQmBW7mIHLeVon5FoVbBLeegPBQqOqEPs1/jHTXDR9Mw2W/Biraq?=
 =?us-ascii?Q?jV/dI1rC5MQ8FK7eTwFtcusZTe/VFAiOcgl3+R6pXYXkcmbsmXfLFsQgIcpB?=
 =?us-ascii?Q?fCT5MvfHFk+k3hx0xf32KBmQYgrOorM9CtQgQv3CSCW8EE7U9SsLZW18IIBF?=
 =?us-ascii?Q?CKy1gC4a+jbu+/RvXwre1Wm8DL2qKqFzw4D3K3DwcppzG0P127ku9li1xgqK?=
 =?us-ascii?Q?kDdHZw8bBFn4OfXFnEpT+8eP4V3M905wFxnoowi3VNDR2YpgyRCeDihkDk94?=
 =?us-ascii?Q?PAZlLAES6xBDGYaT9UAtiS6GFim5HG273c2AUyFTpNmutIv0U1sFnPICA81w?=
 =?us-ascii?Q?VFjvUhsqCvXpKinAVTicwwN/2MkcCGS38HuiP1/y+IKrJw2jOAAQvpMezes5?=
 =?us-ascii?Q?Zf1tnl0Pg5aYyCQNxA+sjPyjkeH5CheCK/I68Z50M93Nqko7MjQcAk8V39qJ?=
 =?us-ascii?Q?TDt/Z91LycNaRNpntcgbnTcJgaOFDYzAn4UyrG9ZIpTMdMuBB1RxlG7L72Lz?=
 =?us-ascii?Q?QSa3jzy+Jg9hFOOR7S7nxYwIRyMVfB85qbn0cTC6ONYh6h7yoc32yvCMzsPR?=
 =?us-ascii?Q?hmkoeKkkjmlNzgzsLmL3c1qvPMRWuSQkq+gebVlPTo30hvz+Ib4pjggtDZ4c?=
 =?us-ascii?Q?MHm90cnD0zY+OHegbxNBQoFfcILmIW+zMjTAp/wxpKHqVjE8Fz8yRLVU6fME?=
 =?us-ascii?Q?RBUxeV5hwm4KDM4LZhejpFfxWk08euG/Z8MRELd51AbVou20oVs1ojeZkltG?=
 =?us-ascii?Q?fLEzuGEx1R2nyViyDVEU1//8q3ybhG1sxR4QHcSBmspDOYTEMRPRMqLxYMTs?=
 =?us-ascii?Q?JDkRV4eIZtUk9kv+EsHvllZfCfRGqTrA1w2BS5btIuT06kejIuvYUbDd31Dn?=
 =?us-ascii?Q?N5p5comOrouKvWGIGeSv17g7orAyP5AqNIYqarmHaN9BygI1ag3tU1zClnnG?=
 =?us-ascii?Q?VFBsBeGkz1REDIAhYoA5hGrF8kLkQ5I0a3tft1p8m3vMDaEGJUoFKMIjVokl?=
 =?us-ascii?Q?fkv9xAKVAW34ANqp0ilg6oegnx4zHwSwv875nKNdndmb4ElHUAfm89we49R5?=
 =?us-ascii?Q?tN8ixTO02Md+WKM1QvDtCQuEY3xlleRXsuor1OKZD1QQQTu+VfhU2yWn3vhP?=
 =?us-ascii?Q?BLtMbUvzuX7MwVC1mrfxvzXKpZGKocWyu9etsjmBDyC1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35bf027-12ba-46b3-58fe-08dcb858134a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:00.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDyNeJI9S7luREuMhNo+w9jdyI8AROQLEaMUV6c706M/VhswzKKu1X4YvUNYEbFKFglSJ2GyAymkCvd6ZHCJhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 433 +++++++++++++++++++++++++
 1 file changed, 433 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..b8f41b304510
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11h
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "fw.h"
+#include "cfg80211.h"
+
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv)
+{
+	priv->state_11h.is_11h_enabled = true;
+	priv->state_11h.is_11h_active = false;
+}
+
+inline int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* This function appends 11h info to a buffer while joining an
+ * infrastructure BSS
+ */
+static void
+nxpwifi_11h_process_infra_join(struct nxpwifi_private *priv, u8 **buffer,
+			       struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_header *ie_header;
+	struct nxpwifi_ie_types_pwr_capability *cap;
+	struct nxpwifi_ie_types_local_pwr_constraint *constraint;
+	struct ieee80211_supported_band *sband;
+	u8 radio_type;
+	int i;
+
+	if (!buffer || !(*buffer))
+		return;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	cap = (struct nxpwifi_ie_types_pwr_capability *)*buffer;
+	cap->header.type = cpu_to_le16(WLAN_EID_PWR_CAPABILITY);
+	cap->header.len = cpu_to_le16(2);
+	cap->min_pwr = 0;
+	cap->max_pwr = 0;
+	*buffer += sizeof(*cap);
+
+	constraint = (struct nxpwifi_ie_types_local_pwr_constraint *)*buffer;
+	constraint->header.type = cpu_to_le16(WLAN_EID_PWR_CONSTRAINT);
+	constraint->header.len = cpu_to_le16(2);
+	constraint->chan = bss_desc->channel;
+	constraint->constraint = bss_desc->local_constraint;
+	*buffer += sizeof(*constraint);
+
+	ie_header = (struct nxpwifi_ie_types_header *)*buffer;
+	ie_header->type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+	ie_header->len  = cpu_to_le16(2 * sband->n_channels + 2);
+	*buffer += sizeof(*ie_header);
+	*(*buffer)++ = WLAN_EID_SUPPORTED_CHANNELS;
+	*(*buffer)++ = 2 * sband->n_channels;
+	for (i = 0; i < sband->n_channels; i++) {
+		u32 center_freq;
+
+		center_freq = sband->channels[i].center_freq;
+		*(*buffer)++ = ieee80211_frequency_to_channel(center_freq);
+		*(*buffer)++ = 1; /* one channel in the subband */
+	}
+}
+
+/* Enable or disable the 11h extensions in the firmware */
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag)
+{
+	u32 enable = flag;
+
+	/* enable master mode radar detection on AP interface */
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && enable)
+		enable |= NXPWIFI_MASTER_RADAR_DET_MASK;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				HOST_ACT_GEN_SET, DOT11H_I, &enable, true);
+}
+
+/* This functions processes TLV buffer for a pending BSS Join command.
+ *
+ * Activate 11h functionality in the firmware if the spectrum management
+ * capability bit is found in the network we are joining. Also, necessary
+ * TLVs are set based on requested network's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability
+		 * bit
+		 */
+		nxpwifi_11h_activate(priv, true);
+		priv->state_11h.is_11h_active = true;
+		bss_desc->cap_info_bitmap |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+		nxpwifi_11h_process_infra_join(priv, buffer, bss_desc);
+	} else {
+		/* Deactivate 11h functions in the firmware */
+		nxpwifi_11h_activate(priv, false);
+		priv->state_11h.is_11h_active = false;
+		bss_desc->cap_info_bitmap &= ~WLAN_CAPABILITY_SPECTRUM_MGMT;
+	}
+}
+
+/* This is DFS CAC work function.
+ * This delayed work emits CAC finished event for cfg80211 if
+ * CAC was started earlier.
+ */
+void nxpwifi_dfs_cac_work(struct work_struct *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_cac_work);
+
+	chandef = priv->dfs_chandef;
+	if (priv->wdev.cac_started) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "CAC timer finished; No radar detected\n");
+		cfg80211_cac_event(priv->netdev, &chandef,
+				   NL80211_RADAR_CAC_FINISHED,
+				   GFP_KERNEL);
+	}
+}
+
+static u8 nxpwifi_get_channel_2_offset(int chan)
+{
+	u8 chan2_offset = SEC_CHAN_NONE;
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
+	case 165:
+	case 173:
+		chan2_offset = SEC_CHAN_ABOVE;
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
+	case 169:
+	case 177:
+		chan2_offset = SEC_CHAN_BELOW;
+		break;
+	}
+
+	return chan2_offset;
+}
+
+static void nxpwifi_convert_chan_to_band_cfg(u8 *band_cfg,
+					     struct cfg80211_chan_def *chan_def)
+{
+	u8 chan_band = 0, chan_width = 0, chan2_offset = 0;
+
+	switch (chan_def->chan->band) {
+	case NL80211_BAND_2GHZ:
+		chan_band = BAND_2GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		chan_band = BAND_5GHZ;
+		break;
+	default:
+		break;
+	}
+
+	switch (chan_def->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		chan_width = CHAN_BW_20MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		chan_width = CHAN_BW_40MHZ;
+		if (chan_def->center_freq1 > chan_def->chan->center_freq)
+			chan2_offset = SEC_CHAN_ABOVE;
+		else
+			chan2_offset = SEC_CHAN_BELOW;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		chan2_offset =
+			nxpwifi_get_channel_2_offset(chan_def->chan->hw_value);
+		chan_width = CHAN_BW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+	default:
+		break;
+	}
+
+	*band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
+		     BAND_CFG_CHAN2_OFFSET_MASK) |
+		    ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
+		     BAND_CFG_CHAN_WIDTH_MASK) |
+		    ((chan_band << BAND_CFG_CHAN_BAND_SHIFT_BIT) &
+		     BAND_CFG_CHAN_BAND_MASK);
+}
+
+/* This function prepares channel report request command to FW for
+ * starting radar detection.
+ */
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf)
+{
+	struct host_cmd_ds_chan_rpt_req *cr_req = &cmd->params.chan_rpt_req;
+	struct nxpwifi_radar_params *radar_params = (void *)data_buf;
+	u16 size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REPORT_REQUEST);
+	size = S_DS_GEN;
+
+	cr_req->chan_desc.start_freq = cpu_to_le16(NXPWIFI_A_BAND_START_FREQ);
+	nxpwifi_convert_chan_to_band_cfg(&cr_req->chan_desc.band_cfg,
+					 radar_params->chandef);
+	cr_req->chan_desc.chan_num = radar_params->chandef->chan->hw_value;
+	cr_req->msec_dwell_time = cpu_to_le32(radar_params->cac_time_ms);
+	size += sizeof(*cr_req);
+
+	if (radar_params->cac_time_ms) {
+		struct nxpwifi_ie_types_chan_rpt_data *rpt;
+
+		rpt = (struct nxpwifi_ie_types_chan_rpt_data *)((u8 *)cmd + size);
+		rpt->header.type = cpu_to_le16(TLV_TYPE_CHANRPT_11H_BASIC);
+		rpt->header.len = cpu_to_le16(sizeof(u8));
+		rpt->meas_rpt_map = 1 << MEAS_RPT_MAP_RADAR_SHIFT_BIT;
+		size += sizeof(*rpt);
+
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "11h: issuing DFS Radar check for channel=%d\n",
+			    radar_params->chandef->chan->hw_value);
+	} else {
+		nxpwifi_dbg(priv->adapter, MSG, "cancelling CAC\n");
+	}
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef)
+{
+	struct nxpwifi_radar_params radar_params;
+
+	memset(&radar_params, 0, sizeof(struct nxpwifi_radar_params));
+	radar_params.chandef = chandef;
+	radar_params.cac_time_ms = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REPORT_REQUEST,
+				HOST_ACT_GEN_SET, 0, &radar_params, true);
+}
+
+/* This function is to abort ongoing CAC upon stopping AP operations
+ * or during unload.
+ */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+	}
+}
+
+/* This function handles channel report event from FW during CAC period.
+ * If radar is detected during CAC, driver indicates the same to cfg80211
+ * and also cancels ongoing delayed work.
+ */
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb)
+{
+	struct host_cmd_ds_chan_rpt_event *rpt_event;
+	struct nxpwifi_ie_types_chan_rpt_data *rpt;
+	u16 event_len, tlv_len;
+
+	rpt_event = (void *)(skb->data + sizeof(u32));
+	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event) +
+				sizeof(u32));
+
+	if (le32_to_cpu(rpt_event->result) != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error in channel report event\n");
+		return -EINVAL;
+	}
+
+	while (event_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		rpt = (void *)&rpt_event->tlvbuf;
+		tlv_len = le16_to_cpu(rpt->header.len);
+
+		switch (le16_to_cpu(rpt->header.type)) {
+		case TLV_TYPE_CHANRPT_11H_BASIC:
+			if (rpt->meas_rpt_map & MEAS_RPT_MAP_RADAR_MASK) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "RADAR Detected on channel %d!\n",
+					    priv->dfs_chandef.chan->hw_value);
+				cancel_delayed_work_sync(&priv->dfs_cac_work);
+				cfg80211_cac_event(priv->netdev,
+						   &priv->dfs_chandef,
+						   NL80211_RADAR_CAC_ABORTED,
+						   GFP_KERNEL);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
+			}
+			break;
+		default:
+			break;
+		}
+
+		event_len -= (tlv_len + sizeof(rpt->header));
+	}
+
+	return 0;
+}
+
+/* Handler for radar detected event from FW.*/
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+	if (priv->wdev.cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+	}
+	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
+			     GFP_KERNEL);
+	nxpwifi_dbg(priv->adapter, MSG, "regdomain: %d\n",
+		    rdr_event->reg_domain);
+	nxpwifi_dbg(priv->adapter, MSG, "radar detection type: %d\n",
+		    rdr_event->det_type);
+
+	return 0;
+}
+
+/* This is work function for channel switch handling.
+ * This function takes care of updating new channel definitin to
+ * bss config structure, restart AP and indicate channel switch success
+ * to cfg80211.
+ */
+void nxpwifi_dfs_chan_sw_work(struct work_struct *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_chan_sw_work);
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (nxpwifi_del_mgmt_ies(priv))
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
+
+	bss_cfg = &priv->bss_cfg;
+	if (!bss_cfg->beacon_period) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: AP already stopped\n");
+		return;
+	}
+
+	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+			     HOST_ACT_GEN_SET, 0, NULL, true)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (nxpwifi_cfg80211_change_beacon_data(adapter->wiphy,
+						priv->netdev,
+						&priv->beacon_after)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
+	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
+
+	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to start AP after channel switch\n");
+		return;
+	}
+
+	nxpwifi_dbg(adapter, MSG,
+		    "indicating channel switch completion to kernel\n");
+	wiphy_lock(priv->wdev.wiphy);
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+	wiphy_unlock(priv->wdev.wiphy);
+
+	if (priv->uap_stop_tx) {
+		if (!netif_carrier_ok(priv->netdev))
+			netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


