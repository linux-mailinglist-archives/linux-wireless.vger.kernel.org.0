Return-Path: <linux-wireless+bounces-11212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9694CDCC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3118C282410
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBB19D076;
	Fri,  9 Aug 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1bnE84F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4819CD0C;
	Fri,  9 Aug 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196873; cv=fail; b=mj54fnlCyW+r3dPQ3VI5qdXOrHdEc6Crej2xjQa8+8uf7ZryT0LcTQVVu9fuIUhqR0jlWsVZUOBY3r72d8XRP6O0Juy2BH1gET1RUOUpuTNxNvVEu1BVkwl8emvn+OUdVdJxMtuGHNrkh1Nkl0d2XZNaCabM8HlfzACRgYR3+Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196873; c=relaxed/simple;
	bh=nmm00EqlvqqB9ONFL77FJ4LIqEcU0BeA2BVvF6WjoQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjaXx+0kNazw4OWwVaPBmyvZIcr8rqL6m1DipAr5qlPmIljw1au7WgLeFPs8zp2IY088VsJ+WzokkfUnZAVM8BV6jgVNT05LffAHCc4WZY0kbNBm9NAu/9RMfzYR+bhiL9akldDlbBOXm879O9FEjgbhT8nrG7nElwS5Y+3iUDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i1bnE84F; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCOGkSJSLR9m5m4mr2GVSmkoMTfZwUpsGP0b//a+wrDJlcNh+cYCM/SnCu14MWGYdbTwI/9ZymJGhjdCKrKGCi9Gr31JWa+i+1oD3uaSp81D1ZNy0VmIgriTRP0zasfVyHYA4T8ImL+VrH3C3B/YbC78DCWpxZy+y2GYmfMrVaPFj79uPZzyQAyw7j5RQJOw2jATK1g4sK1KnmUNN/JIHHADrc5PRck6+VCHeqq4KzoefWf98mcrkDO8Jhf7lv3Dy4EIbpc9qgsH71k4omcDqQcSYHN1BiPENww/Ba9B2adpTjeRQc6ubiE78C75y1iL5vBdJxHAX8XKJsj6GyWZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ceh7Hex2+aHv5fXQbSM5/PyD7L3CEEGXLz4AOSwpD4=;
 b=cbHSSKH4DxD6WMqNUAO9/vTVltXBlEN0HHaiS51WwmH90hsZO1qszN0N6H599NyGROyQ0UEVHKnZH/GmppN/gqu+6c9DUNHMs6AAuTBA/sY3oBDWUkhVA28GQ2optXhyXtajgqWSQQnW0FrW5XvozzkTQQ2igZnhiSIsjEbNs88iCo5Z4BlqApNE4/A8S4CtpXgnkQFrNWc3xVq+gWTWII5rudA7iEAEzOoKqnw+o4GscOInC5yDgR9/wXNDUE5QbK9bzwYO6UxvYfvunhQMC1J9Ea6bl5sEa9admKBcszuM8aw2BtiBHCHbui45V/59TqXWjBv0k/aNmVbVge5GlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ceh7Hex2+aHv5fXQbSM5/PyD7L3CEEGXLz4AOSwpD4=;
 b=i1bnE84F31/n1XxmP+tICX/PGMl74PaSVtfQmDbBISSs55JmlIDRKvO7sjKJlOgr3d6uSYX1G+78tQfGQcuCShjNelSaQPmnYKf0XUsBBUMTeZHvoTxt91qQaaEMGwTrdMVwGbRlKN3k+dPj9D0U6EPkXe54CtTfACEUTNRCKFFxtZe9f8mRtjcF5V3r9qWrrqTNPtnbOMChvfE6TY6LXccXwOyIGcq/HXsULG9lpE1qsY79mS3mc27Hf96gm40fJAb8sYY7bSIlq7ZgtuFq2Xvtv3Hc3GdWJ3tf5DNLWOaVXXJcC5CAIHv7qSZ50r0SsO0tBIPgjm1IRajm1i6XHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:46 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 35/43] wifi: nxpwifi: add uap_event.c
Date: Fri,  9 Aug 2024 17:45:25 +0800
Message-Id: <20240809094533.1660-36-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: c300eef7-6901-4d1e-88ab-08dcb85852cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?45VpfvGGKeVV+iNkiKkI4VmshDW4ChfSpLFQUkA/hRG3gXIxlz1++DaHrwK0?=
 =?us-ascii?Q?A0kAI4azVoIG25j/8wWllUi6oFX0M14AJD5LJwMWiRXuqIG/PJP8TRar7qla?=
 =?us-ascii?Q?0qkoE7dRPB5seA2Ng3X1HafsJi1lT989yxb+bXnT6ZPGQxsy4hk/S6I/ia1i?=
 =?us-ascii?Q?EpG3Zj+wM+PgE3GFvwD/p7+vwJkxcjP+taZWx2niZs5orRrKB9yty7x+ZIXv?=
 =?us-ascii?Q?zFov0Ey2l2ij22qUMwS7s4yFsl63SA2yHGoBI07/Hx5LtU7Fl+Xi0n2RkG4Y?=
 =?us-ascii?Q?t3nxtSgqgKpTUlqZgItG9NwRbl+7lqG0XkFoXs0vo1rbjrvsB+zIG58mhhT6?=
 =?us-ascii?Q?aDmFYUfJlrLJ0PpUaHN8HaQBQpniKZR7OnfUfnWDmKvXw3Ya/7R6wBy/aF1C?=
 =?us-ascii?Q?s2Pz8Im3w2cCdUyUV5yfq/fFD6I5voVqMdWrbwpFzSg7ZnHsrG5BhkMn5ZBS?=
 =?us-ascii?Q?6O9ndVG1BXPtxSdIXhQIhrjL12JNkydj3U+q5ZN11FQvAiCBNyEryuiK/Jcl?=
 =?us-ascii?Q?WaL8+RVPrhQ03EyG0qGnv0mDe2D7iZbudBMmqbOHPoJ5WAj2zwqyPTJLvPGQ?=
 =?us-ascii?Q?e3+4epHTuUZsCe1SPfF+WJBU0hPJwPszuHt7T11GuDBdywGaWHdYtqiOiBoU?=
 =?us-ascii?Q?wMbqXyB+Djcioq5ISGiEME5qKmyYJVHY+W1n82/79oyJQfjyBrWuJPf2tAv/?=
 =?us-ascii?Q?DlzzcFynW+Zx5Ogf2cNA8wgEHIXZVdvHQRre6G0s60JZX3Ede0ZzNMtzEOlH?=
 =?us-ascii?Q?/P4ezNk+hLcfZqVPzm2V3v1Fpp1QItLmqZbhyzvefY85lhUhjY0b0WCX1o8D?=
 =?us-ascii?Q?DGXZFge3Av9/jZ4thLb9EIF2jogdIKb8j99HAO3Nh4yN8T9ylusbx6PoPk7+?=
 =?us-ascii?Q?2BPnRr5tR/aMjEmNX159Q2EVa0OVr1yI+0iwLI9g/SW3XpmjBiDfQXqFhPCn?=
 =?us-ascii?Q?xHrPGM5E7ABgjDm1KpPYyJ8Zd0hL348c4OFAk39LrEIxdQdBe0qX9WPj+A7S?=
 =?us-ascii?Q?NPGLE/warIZi63CNnOR8sILOcTyCql921TSsvWMwRlzyc0NuyZPsK1CyXvDJ?=
 =?us-ascii?Q?dQo0Fms37kXvjSoSU7tu/TAlN1L7CRll4eTJFb+EP9pLWgjlRk1KHsTVuMLs?=
 =?us-ascii?Q?B2eoBJt34wKFmtyPqqntDOrw6xA6t+RcryqRyspkKYutm5UxldGcSd+aDxxW?=
 =?us-ascii?Q?+QcIy6UGaN47PGMenKYwWo49Jq4Y7OoePQsPgjw2nqUEoCaYvG5ROAvUYzt3?=
 =?us-ascii?Q?9Ofb4zgUOYSDrlQ0agGZJB+ec978mh1Y9yEPUqPNJTRXnIn85+YhTDjtFY+s?=
 =?us-ascii?Q?L2/z2QXOGAZxk32nQxwE2o9+98P3W7uxBULGyj0dYKHgKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l1wnm4uquqMAiG4Eqn5t9hOTbabLqzz/I6fFh2x7B5MZkuaMM2CLZreG0wXp?=
 =?us-ascii?Q?+Apca3qmrFQnMZy6A5tYEagw8IqabLEpnTsd1AVPHpl8iXDRf7egX70RSsTN?=
 =?us-ascii?Q?/qQJ8LGDkNDnCOcXQ2F/Yd8Id6i3++20/M1QS/u2O3vjMxJkFrk1o+j+dZ1E?=
 =?us-ascii?Q?U4Y6pP79aMXI4+Gi78WaE8rJGgRCWPn3yqH8Y8q5vS3/x6FxWjyMLmbw3FJs?=
 =?us-ascii?Q?slGF5UxSC9KU+kdWuXxy2elfLL8Z8oGxRPcv9ml4yUX5DpXrSjqyTqepZk9S?=
 =?us-ascii?Q?Q8mWtjOI2ol/zrw0H39/diU00zOKoJY4jiv1y8s8qSi9DIJWhDpn4+jerAH0?=
 =?us-ascii?Q?fggC0BqF6WYIxWDFL7CVKoeZORHHeNfJA5iBVb13lLEsKPl+hyoCaKfze56y?=
 =?us-ascii?Q?auqfst36vvr1uROKx7s5i2DZXk6EPODa8iW/axuvQlVwD8+X8jc3sfd1L4Qu?=
 =?us-ascii?Q?jEIJsePTx1I4Dw3Uia9d91jbyYwq+K9ba5XlX7PA2PWY8ab1L3ByiTxJd+lR?=
 =?us-ascii?Q?60qCxgwrHoe34KtwPwVKxyqRxlTxNesXvmMy+zMvill8RuPvKxHG7+eRIzMY?=
 =?us-ascii?Q?u/y/OQTDqCZX+D9xQ9VsQvvPvpfFsehhT39WAw+6JuYxR4P5uO0bUFTj42Uq?=
 =?us-ascii?Q?lXEKaQGjvvkqioUS/6xRX/tQt18La+jT/W5Ss7mhmOYT7GYdZpNFbG4kM2wg?=
 =?us-ascii?Q?Wyod1+uYTVU9Ep8ba05T1f7MI5JcqOnUdQwvAJAHCQqOi4YmXNXnXtVJGokR?=
 =?us-ascii?Q?9idzZAq9nVi/fFy1wZ6l7clLfhWxidJvDOyWKdwIM/Vatjy5wHoGnvwc0HsV?=
 =?us-ascii?Q?WivKRPPtlW3x0GB+A5ktv/H4f2Q+mAYK0/Yzommm5XMjkZ2tIpTmbF16b1oB?=
 =?us-ascii?Q?HvfQjAab5jcy5gbrGqb0OfgpdRXhZESz9x+0ccE7Zh2+F34Z7MHgJmejCmwm?=
 =?us-ascii?Q?lZtFcX4r3PDgS7Qjh661oNXgRhZUWzfWdmj5vKZw9VKkkXa6A9YXb8qyOh1K?=
 =?us-ascii?Q?Lv8zjhIkwORxP1cyYvI7V8NjH71CFcpIRefDUJ9m0yP6QjWiD6rp8OZ3aBqn?=
 =?us-ascii?Q?mfti0rqIx5l5hdLn2PDHEGtCDdOkl33Al5FV5MJTHRhvvqeAYvsWhzkoivJl?=
 =?us-ascii?Q?dSRwXtA6nT+AUJLQ2yjQB/KxAnnyjNNr8WjI5d7xmwfNxighHHhmhHR6uOBz?=
 =?us-ascii?Q?SrmIazvxTuF8bBTxS0+XKtfdFAb7dvhlWaupV57bnxmy97gyJ1zpZJIfmEyM?=
 =?us-ascii?Q?ZxtpMmuL3HTYjE1yBKFQCBVKfC3vM9U3RhqWTNiqVbvZa2hVtkaPv1buwDU6?=
 =?us-ascii?Q?tIVoYY1I21nnJVLdykfPTx7rGRWfdVSUlZYCodKOcSxNt0ArzzA+vp9lhLPL?=
 =?us-ascii?Q?XJJF3bfileuei2PcZIXD+Dylw5APEF6uqMmZKgQu1IHQhtx4avR5IiybCCEl?=
 =?us-ascii?Q?eiDJt0+BZw0daDfxMQLGyIYnU7MyaJnDiAoZxeIqbRjCItKFgleBLyfPXEjP?=
 =?us-ascii?Q?GuD9z2dgU1IY440NtVBNDww3lFbfR8kCkcfh5nh/FqLfckbe4p/MQFguxVnv?=
 =?us-ascii?Q?QfikVNaT0d3YylKeNUwpGabAlW6rDo2UBFKJS1J9fnyLpsG0ZucLUIEgIw8d?=
 =?us-ascii?Q?Y88CZOgZi44MC3osDS8oCheIe76Y1BXAcFnkSufunxSR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c300eef7-6901-4d1e-88ab-08dcb85852cd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:46.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvXtBXTi2/El42YSl7XNbjMyr0zkp0C6loGJFUJC52qpv0m7PvMnd8+rEXyeF/2aKWaz22bvKRoWTJp9W6DoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

---
 drivers/net/wireless/nxp/nxpwifi/uap_event.c | 491 +++++++++++++++++++
 1 file changed, 491 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_event.c b/drivers/net/wireless/nxp/nxpwifi/uap_event.c
new file mode 100644
index 000000000000..9fb0abdf5b3c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_event.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP event handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "11n.h"
+
+#define NXPWIFI_BSS_START_EVT_FIX_SIZE    12
+
+static int
+nxpwifi_uap_event_ps_awake(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (!adapter->pps_uapsd_mode &&
+	    priv->media_connected && adapter->sleep_period.period) {
+		adapter->pps_uapsd_mode = true;
+		nxpwifi_dbg(adapter, EVENT,
+			    "event: PPS/UAPSD mode activated\n");
+	}
+	adapter->tx_lock_flag = false;
+	if (adapter->pps_uapsd_mode && adapter->gen_null_pkt) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			if (adapter->data_sent) {
+				adapter->ps_state = PS_STATE_AWAKE;
+				adapter->pm_wakeup_card_req = false;
+				adapter->pm_wakeup_fw_try = false;
+			} else {
+				if (!nxpwifi_send_null_packet
+				    (priv,
+				     NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
+				     NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET))
+					adapter->ps_state = PS_STATE_SLEEP;
+			}
+
+			return 0;
+		}
+	}
+
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->pm_wakeup_card_req = false;
+	adapter->pm_wakeup_fw_try = false;
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_ps_sleep(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->ps_state = PS_STATE_PRE_SLEEP;
+	nxpwifi_check_ps_cond(adapter);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_sta_deauth(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 *deauth_mac;
+
+	deauth_mac = adapter->event_body +
+		     NXPWIFI_UAP_EVENT_EXTRA_HEADER;
+	cfg80211_del_sta(priv->netdev, deauth_mac, GFP_KERNEL);
+
+	if (priv->ap_11n_enabled) {
+		nxpwifi_11n_del_rx_reorder_tbl_by_ta(priv, deauth_mac);
+		nxpwifi_del_tx_ba_stream_tbl_by_ra(priv, deauth_mac);
+	}
+	nxpwifi_wmm_del_peer_ra_list(priv, deauth_mac);
+	nxpwifi_del_sta_entry(priv, deauth_mac);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_sta_assoc(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct station_info *sinfo;
+	struct nxpwifi_assoc_event *event;
+	struct nxpwifi_sta_node *node;
+	int len, i;
+
+	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+	if (!sinfo)
+		return -ENOMEM;
+
+	event = (struct nxpwifi_assoc_event *)
+		(adapter->event_body + NXPWIFI_UAP_EVENT_EXTRA_HEADER);
+	if (le16_to_cpu(event->type) == TLV_TYPE_UAP_MGMT_FRAME) {
+		len = -1;
+
+		if (ieee80211_is_assoc_req(event->frame_control))
+			len = 0;
+		else if (ieee80211_is_reassoc_req(event->frame_control))
+			/* There will be ETH_ALEN bytes of
+			 * current_ap_addr before the re-assoc ies.
+			 */
+			len = ETH_ALEN;
+
+		if (len != -1) {
+			sinfo->assoc_req_ies = &event->data[len];
+			len = (u8 *)sinfo->assoc_req_ies -
+			      (u8 *)&event->frame_control;
+			sinfo->assoc_req_ies_len =
+				le16_to_cpu(event->len) - (u16)len;
+		}
+	}
+	cfg80211_new_sta(priv->netdev, event->sta_addr, sinfo,
+			 GFP_KERNEL);
+
+	node = nxpwifi_add_sta_entry(priv, event->sta_addr);
+	if (!node) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "could not create station entry!\n");
+		kfree(sinfo);
+		return -ENOENT;
+	}
+
+	if (!priv->ap_11n_enabled) {
+		kfree(sinfo);
+		return 0;
+	}
+
+	nxpwifi_set_sta_ht_cap(priv, sinfo->assoc_req_ies,
+			       sinfo->assoc_req_ies_len, node);
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		if (node->is_11n_enabled)
+			node->ampdu_sta[i] =
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			node->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
+	}
+	memset(node->rx_seq, 0xff, sizeof(node->rx_seq));
+	kfree(sinfo);
+
+	return 0;
+}
+
+static int
+nxpwifi_check_uap_capabilities(struct nxpwifi_private *priv,
+			       struct sk_buff *event)
+{
+	int evt_len;
+	u8 *curr;
+	u16 tlv_len;
+	struct nxpwifi_ie_types_data *tlv_hdr;
+	struct ieee80211_wmm_param_ie *wmm_param_ie = NULL;
+	int mask = IEEE80211_WMM_IE_AP_QOSINFO_PARAM_SET_CNT_MASK;
+
+	priv->wmm_enabled = false;
+	skb_pull(event, NXPWIFI_BSS_START_EVT_FIX_SIZE);
+	evt_len = event->len;
+	curr = event->data;
+
+	nxpwifi_dbg_dump(priv->adapter, EVT_D, "uap capabilities:",
+			 event->data, event->len);
+
+	skb_push(event, NXPWIFI_BSS_START_EVT_FIX_SIZE);
+
+	while ((evt_len >= sizeof(tlv_hdr->header))) {
+		tlv_hdr = (struct nxpwifi_ie_types_data *)curr;
+		tlv_len = le16_to_cpu(tlv_hdr->header.len);
+
+		if (evt_len < tlv_len + sizeof(tlv_hdr->header))
+			break;
+
+		switch (le16_to_cpu(tlv_hdr->header.type)) {
+		case WLAN_EID_HT_CAPABILITY:
+			priv->ap_11n_enabled = true;
+			break;
+
+		case WLAN_EID_VHT_CAPABILITY:
+			priv->ap_11ac_enabled = true;
+			break;
+
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Point the regular IEEE IE 2 bytes into the NXP IE
+			 * and setup the IEEE IE type and length byte fields
+			 */
+			wmm_param_ie = (void *)(curr + 2);
+			wmm_param_ie->len = (u8)tlv_len;
+			wmm_param_ie->element_id =
+						WLAN_EID_VENDOR_SPECIFIC;
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "info: check uap capabilities:\t"
+				    "wmm parameter set count: %d\n",
+				    wmm_param_ie->qos_info & mask);
+
+			nxpwifi_wmm_setup_ac_downgrade(priv);
+			priv->wmm_enabled = true;
+			nxpwifi_wmm_setup_queue_priorities(priv, wmm_param_ie);
+			break;
+
+		default:
+			break;
+		}
+
+		curr += (tlv_len + sizeof(tlv_hdr->header));
+		evt_len -= (tlv_len + sizeof(tlv_hdr->header));
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bss_start(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	priv->port_open = false;
+	eth_hw_addr_set(priv->netdev, adapter->event_body + 2);
+	if (priv->hist_data)
+		nxpwifi_hist_data_reset(priv);
+	return nxpwifi_check_uap_capabilities(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_uap_event_addba(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->media_connected)
+		nxpwifi_send_cmd(priv, HOST_CMD_11N_ADDBA_RSP,
+				 HOST_ACT_GEN_SET, 0,
+				 adapter->event_body, false);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_delba(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->media_connected)
+		nxpwifi_11n_delete_ba_stream(priv, adapter->event_body);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_ba_stream_timeout(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_11n_batimeout *ba_timeout;
+
+	if (priv->media_connected) {
+		ba_timeout = (void *)adapter->event_body;
+		nxpwifi_11n_ba_stream_timeout(priv, ba_timeout);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_amsdu_aggr_ctrl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 ctrl;
+
+	ctrl = get_unaligned_le16(adapter->event_body);
+	nxpwifi_dbg(adapter, EVENT,
+		    "event: AMSDU_AGGR_CTRL %d\n", ctrl);
+
+	if (priv->media_connected) {
+		adapter->tx_buf_size =
+			min_t(u16, adapter->curr_tx_buf_size, ctrl);
+		nxpwifi_dbg(adapter, EVENT,
+			    "event: tx_buf_size %d\n",
+			    adapter->tx_buf_size);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bss_idle(struct nxpwifi_private *priv)
+{
+	priv->media_connected = false;
+	priv->port_open = false;
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_del_all_sta_list(priv);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bss_active(struct nxpwifi_private *priv)
+{
+	priv->media_connected = true;
+	priv->port_open = true;
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_mic_countermeasures(struct nxpwifi_private *priv)
+{
+	/* For future development */
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_radar_detected(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_11h_handle_radar_detected(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_uap_event_channel_report_rdy(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_11h_handle_chanrpt_ready(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_uap_event_tx_data_pause(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_process_tx_pause_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_ext_scan_report(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	void *buf = adapter->event_skb->data;
+	int ret = 0;
+
+	if (adapter->ext_scan)
+		ret = nxpwifi_handle_event_ext_scan_report(priv, buf);
+
+	return ret;
+}
+
+static int
+nxpwifi_uap_event_rxba_sync(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_11n_rxba_sync_event(priv, adapter->event_body,
+				    adapter->event_skb->len -
+				    sizeof(adapter->event_cause));
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_remain_on_chan_expired(struct nxpwifi_private *priv)
+{
+	cfg80211_remain_on_channel_expired(&priv->wdev,
+					   priv->roc_cfg.cookie,
+					   &priv->roc_cfg.chan,
+					   GFP_ATOMIC);
+	memset(&priv->roc_cfg, 0x00, sizeof(struct nxpwifi_roc_cfg));
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_multi_chan_info(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_process_multi_chan_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_tx_status_report(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_parse_tx_status_event(priv, adapter->event_body);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bt_coex_wlan_para_change(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_bt_coex_wlan_param_update_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_vdll_ind(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_process_vdll_event(priv, adapter->event_skb);
+}
+
+static const struct nxpwifi_evt_entry evt_table_uap[] = {
+	{.event_cause = EVENT_PS_AWAKE,
+	 .event_handler = nxpwifi_uap_event_ps_awake},
+	{.event_cause = EVENT_PS_SLEEP,
+	 .event_handler = nxpwifi_uap_event_ps_sleep},
+	{.event_cause = EVENT_UAP_STA_DEAUTH,
+	 .event_handler = nxpwifi_uap_event_sta_deauth},
+	{.event_cause = EVENT_UAP_STA_ASSOC,
+	 .event_handler = nxpwifi_uap_event_sta_assoc},
+	{.event_cause = EVENT_UAP_BSS_START,
+	 .event_handler = nxpwifi_uap_event_bss_start},
+	{.event_cause = EVENT_ADDBA,
+	 .event_handler = nxpwifi_uap_event_addba},
+	{.event_cause = EVENT_DELBA,
+	 .event_handler = nxpwifi_uap_event_delba},
+	{.event_cause = EVENT_BA_STREAM_TIEMOUT,
+	 .event_handler = nxpwifi_uap_event_ba_stream_timeout},
+	{.event_cause = EVENT_AMSDU_AGGR_CTRL,
+	 .event_handler = nxpwifi_uap_event_amsdu_aggr_ctrl},
+	{.event_cause = EVENT_UAP_BSS_IDLE,
+	 .event_handler = nxpwifi_uap_event_bss_idle},
+	{.event_cause = EVENT_UAP_BSS_ACTIVE,
+	 .event_handler = nxpwifi_uap_event_bss_active},
+	{.event_cause = EVENT_UAP_MIC_COUNTERMEASURES,
+	 .event_handler = nxpwifi_uap_event_mic_countermeasures},
+	{.event_cause = EVENT_RADAR_DETECTED,
+	 .event_handler = nxpwifi_uap_event_radar_detected},
+	{.event_cause = EVENT_CHANNEL_REPORT_RDY,
+	 .event_handler = nxpwifi_uap_event_channel_report_rdy},
+	{.event_cause = EVENT_TX_DATA_PAUSE,
+	 .event_handler = nxpwifi_uap_event_tx_data_pause},
+	{.event_cause = EVENT_EXT_SCAN_REPORT,
+	 .event_handler = nxpwifi_uap_event_ext_scan_report},
+	{.event_cause = EVENT_RXBA_SYNC,
+	 .event_handler = nxpwifi_uap_event_rxba_sync},
+	{.event_cause = EVENT_REMAIN_ON_CHAN_EXPIRED,
+	 .event_handler = nxpwifi_uap_event_remain_on_chan_expired},
+	{.event_cause = EVENT_MULTI_CHAN_INFO,
+	 .event_handler = nxpwifi_uap_event_multi_chan_info},
+	{.event_cause = EVENT_TX_STATUS_REPORT,
+	 .event_handler = nxpwifi_uap_event_tx_status_report},
+	{.event_cause = EVENT_BT_COEX_WLAN_PARA_CHANGE,
+	 .event_handler = nxpwifi_uap_event_bt_coex_wlan_para_change},
+	{.event_cause = EVENT_VDLL_IND,
+	 .event_handler = nxpwifi_uap_event_vdll_ind},
+};
+
+/* This function handles AP interface specific events generated by firmware.
+ *
+ * Event specific routines are called by this function based
+ * upon the generated event cause.
+ */
+int nxpwifi_process_uap_event(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 eventcause = adapter->event_cause;
+	int evt, ret = 0;
+
+	for (evt = 0; evt < ARRAY_SIZE(evt_table_uap); evt++) {
+		if (eventcause == evt_table_uap[evt].event_cause) {
+			if (evt_table_uap[evt].event_handler)
+				ret = evt_table_uap[evt].event_handler(priv);
+			break;
+		}
+	}
+
+	if (evt == ARRAY_SIZE(evt_table_uap))
+		nxpwifi_dbg(adapter, EVENT,
+			    "%s: unknown event id: %#x\n",
+			    __func__, eventcause);
+	else
+		nxpwifi_dbg(adapter, EVENT,
+			    "%s: event id: %#x\n",
+			    __func__, eventcause);
+
+	return ret;
+}
-- 
2.34.1


