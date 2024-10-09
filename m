Return-Path: <linux-wireless+bounces-13751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34738995F71
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E421F233EF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D57158DB1;
	Wed,  9 Oct 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YkAcXY5B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5D55E53;
	Wed,  9 Oct 2024 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454042; cv=fail; b=rfyo5Z23gSUkRB+g4Gwupn3LbWTUZol2mmJJp59RvE0cEsPJJcAoKz0PVkBYBW3U6lZIw82VqVJ15ZptDH1wQcG9Pylte9Kyg4nEtlN/yUP49fUBaLls6C49l6z5AKa8P9r5Dqs67vmTqvAHnt37WzZjwpc31i1AsVEJDV7IPso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454042; c=relaxed/simple;
	bh=faLvdIoR2soD9fbx0WvTnf9133zgE6Dd+XP/ODaLHYA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=btNJQKQRSDgEANxEv615JB4zaINvqcXCKyADatqdcm6kGszxvTYuGAr+bcSwUqIM/m/QwsDwNLo+XTOgtnN0AEMHWQHGOvQyseVzFxoIKxDCC1KbtMLFTDMWTeQLKkqlnkDTEyYFYDRkLuI/DCgDUbn7sXCbaKirJk2qHsQ8uQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YkAcXY5B; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Gh+SaCvUITdMA2q1dVHq/0z9XQfafmvS6R/g8frCtkHdHWWJ5PZ0nDIKfdwV8AFFNlUqqOqhxOFuID7Zq8LziORQqnWMGte+yHguj6ThPVfeHNGnMMi0ZeQdTYqPc+pGYNblHIwOOQM4c/WiR/BGUw28t3G7F2CwX0HbxhSV70KFNQ5hT/qk3CyEv6CdBsFGPcYv1buFyLY5lp2GDIDQe24UHGAKH5SGYvhHU0xfz7/BCWDbiXeXwtbI+K2pQ8EGxJpFDXsqLSBSFur2BC1+NuBX5mpjOVromj5I0+w/ukVckw7o/ue71f8yazh3cy34afha7HbSX4f/8YHEbizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpZrs/qVlxuAqVawTB3Bd4sKyVVFyoNz5gpQYQ0mSRQ=;
 b=fg2H0m6/pVVewOKIg3wPheLqpQGDxaibLVsP9J52dN2grOosxBJzM7QX0aEDpqmgE9xLnqh36lF7AYDU+/miJBNmhAOwLNUx3r38KBNgBYWRyHWnMglCODj6LdFRppY60sBzBIYHFx/H8mDp2YHqm5JnwrgnnpuFCjOm937HwbfnsCeIsygavgrDsset0KYeAFwFP9wg/t4jXZWLLnRBpBayvdRVmy4akhLTIkr3IaGAM75pcIj6IPCqHcLMlR5i181bAJop2IgA6JQ0LIChfSkuzz4DeZouCah3uHyN1XzZSDzpEgoUUjTgVRyOLqx8RYVqvVVM7Vb5DaVcu8KU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpZrs/qVlxuAqVawTB3Bd4sKyVVFyoNz5gpQYQ0mSRQ=;
 b=YkAcXY5BRwuQ33gpXGEUWbvLwGD7BI5gphFBNv/1Q35etgR4EccfH27ZG4QbKGiuf9CY3RlcKYXUXXAi/SmXp3pVmAvJjuBdJzngzicyleJvW1Z0d5OWK9mShvQgjdsdpzzYO5wQlWif8cESydrwYZejauBZv7JGLsC8UFLcq4do1mN0kq64XIkYRMEBaDIhOB+Z9VnFUY1z/fkAwRJ1RUZ3RvVD8TpXCs9sF0rYP152gxqz8OZg5bET53wGYwd9DfuVduMGuBI9keiXtMlh1w/93M8JY5c7eQ8tH9hmAMB5FAjQfKAoq2OwxkZlxvXunkl2bQ5i2agOk+IOANND9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 06:07:16 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:07:15 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2] wifi: nxpwifi: fix firmware crash for AP DFS mode
Date: Wed,  9 Oct 2024 14:06:58 +0800
Message-Id: <20241009060658.8998-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0016.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::21) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI1PR04MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fefafa-f60b-4930-088d-08dce8289faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbXglx+7rdtQ2twQYWVPPE2qvBy7S3Ef5YPQIPnZsQeC/zB0OH9Yio1zR5jC?=
 =?us-ascii?Q?UUMcSalrjKMdmgrCpHnNl5PkLglUuCJSybTDbT3L8YkSQWC9rnQKP+xFYdvv?=
 =?us-ascii?Q?0YYFzvvuCB4xSueMoemfeWJXZLuQX0/t4HmZk6+EG7dVx2gJpM6Ry5tLl6oR?=
 =?us-ascii?Q?HwJ/12r8eY0JXHFW52k1TvPAfHdK2mJvu98b0tICd9ws361hMIUy9BVuVOYv?=
 =?us-ascii?Q?Bv6AnQcHepr8jUgw307g2d+m/EUljU1b7IlhQ8nglL6TGCTFYQP4aG302Xdo?=
 =?us-ascii?Q?ERb/AH4HxOPMAihwamfcZ/mwfscu5wx8UjoCd7BRtio74j9E5yPNtbIYVplR?=
 =?us-ascii?Q?NUXvKXpCao0FVqwiorW1e2jdF1s9bCVZ14xOYl5RwI6PhKHKno9sRpVDgzu0?=
 =?us-ascii?Q?CWDTipM5sVYenjX+an2FK/7miDNXEQX8N1dce/HhUziZ1nZ46m4pmoisRn7t?=
 =?us-ascii?Q?sO2SeGe+lzEiLm8kQRpF/BWBVsBy8TKVSiFvPC/EBOETCfGbhcxXMhjIoE/+?=
 =?us-ascii?Q?FvmjCrddK/zscrhKY0Uf/7eqohe5s/x7S8W+gMx84RmaAERNJ8502TgXUbWu?=
 =?us-ascii?Q?FMIzubUC3WUPYJfHhSriw5H6qwLnNPXlX4H7IOOqWaLbCw1ujGKrL21umdIv?=
 =?us-ascii?Q?rZ/RLpoNUVb6imfL3FRDPz0HcZ+NOVsCbjXsUeIHtHMvwgbPd1aC08++xLGd?=
 =?us-ascii?Q?KVVENrwnRJIN34DUv6BMFgaFSgNU/XkL5nwqwFh5tOqHhk5ZPUEJs3F7MjiQ?=
 =?us-ascii?Q?zAbCK9XzupDsNjLDy/tz2Nyf4/zj4tiDzepUHeIO5OUIFHMNt2x+64OzF37C?=
 =?us-ascii?Q?X8Q4qbvmdD1LTqKYp09lKz4iFHGBfxvXEGkshPHoelz9f9klN8Gha/fm5LCN?=
 =?us-ascii?Q?B6A+X155ge9aLiOnDKUxT7flpMm83RJoz8wfCYV9AAzzDUBAAQPzf3sKifDG?=
 =?us-ascii?Q?Bb4xPa8Jg6WgV/D5fQRcp95ssS0wq+b+DRGJFF7q90z8HiRpkdejlknMNt7F?=
 =?us-ascii?Q?d8biMPclof/4L2g2AuwMS5gigh+ZyAGMhb8WsXh8gxfnsblz7PpG/XYtUtU6?=
 =?us-ascii?Q?Bjdo2GRJCMz2/apVqLKlEEfi0Mx7ooCCdFia2HcC7cbZdZ9QR8PUg01UDgJa?=
 =?us-ascii?Q?z9LROTSsghaD4MFtXxNEALNfrPg2cAHni7BIkUPYng+enS2G/EiiepNnWsHR?=
 =?us-ascii?Q?bcfzaC7oRbLnz5YUJdoA+vg5ipDOA3ICrM1fHo/t2UYxfJFus97ftG1QzXkc?=
 =?us-ascii?Q?c7s13W2i0wNoq9Nwn90ySYM86dMuzwRNPTLXOvnM3vgoWD3daSTd/WkRhXgd?=
 =?us-ascii?Q?7PDm61jN3nudk7x+ZQs7zMizbhMbT7FLeKzeQMbTWHEplw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWUzwHoTIwwIIUQ+s1wDUxWmySLHXVIz4gZbJFx3OCFEgCZ1p0hOkhffMu9a?=
 =?us-ascii?Q?M3GEsf5gjPs9vZVW7ZlauTt930kFP0GrWIvCpTmUdL8oLNF26DifdqSFDyUK?=
 =?us-ascii?Q?sP/plnm9UtkP0arB9yQsV/It8dsYSB1YIT+xMV3F5YSq2T1pc1WpWw9mDm5i?=
 =?us-ascii?Q?W8bybozPK0m0iFL++CPhK3dOpFFyjT0wOFWK5tVWsS+7Eb9hOM8aMhKOiiJ1?=
 =?us-ascii?Q?IHZKfGawESMJRx824pmzrpL6YWxZDHXDspAL/QIpXsQAv9ljNLt5DzdZdXRX?=
 =?us-ascii?Q?ujsD1DN6bcMy3cAyO0JEaVbHbfWNKb/h0clP0Ov9zL+KCvCS8KYIcy1lyZKU?=
 =?us-ascii?Q?QPqYzYj9W8iiT2cScwmuts0TI11rBXhiTq5ZmkHxe+3yL/9X9euyxHb4dwIt?=
 =?us-ascii?Q?ASoDYSrx6gwGAIAmk5EZ8+KeEZonjgdaz09t3NRbH9CZRUAK/4AFTUgNE2v3?=
 =?us-ascii?Q?SPBpdoN6DBF3LONjjpp7271+4GzQhql4F2vpmUSqbO6STGQe3rFL7/Zm21Rv?=
 =?us-ascii?Q?sFLIswrtHjNuTuJgbZWATG73FKNwZFTTR7XfM6haKcitAKitXw0yZ2jpiUzh?=
 =?us-ascii?Q?QjqyYNilAFT+Oq5NkdRZNAkj+eIrLQg+pyGCTMwM909tLPcxS4Ynv0IcZn0b?=
 =?us-ascii?Q?MS3XUlNTnzok7QMEN72AEtXu+vTdH7FQr+2VguG3dBxjTtTXCfuAfPU7zw8E?=
 =?us-ascii?Q?esOgMW9ddzikpfKpnNs8dV9jcJmLr3W0hxnhkrI7/qwODnB64VKJhFB9sZME?=
 =?us-ascii?Q?1KinhuI4aUz1mKhQZ+LOMsu+Ni9VZ9TnLstyJ22bbWnP5SEcq047IrKOazLV?=
 =?us-ascii?Q?oNe77WG/TE8ErjZHgbdz1Xkge0iKSCYdh68+TvusFIU6GW0phiO955RBC7Pw?=
 =?us-ascii?Q?FVOlI/kHuDXMnHMVlKGeSi8b98GUDZr2dD1L1uG8gG5Ss4xYR/IGao4zFUb9?=
 =?us-ascii?Q?dwMvo0iABT6Ayy/m0mYH+cz9vudgAUninwnPgsc+EE43FSSd1xJtNoMFjHpE?=
 =?us-ascii?Q?SRwlIuZ3L7bo3HvSx9WQ+Ld1tgy71EHDUR4ubvVA4Yabtrk2RfrbuEIP0CJw?=
 =?us-ascii?Q?5QwQbwVu8uPm31qJJVvYGusdISjtdxQp6DzSyKtYqjAauYcod4GTeTygrFEE?=
 =?us-ascii?Q?n/dkmxDOxSPC9ynhXym6z3qQOmNALuthkOPWaqNUh22w7PkbX9TT6ChJBSko?=
 =?us-ascii?Q?NZ2fn6ea48C4hcYz36Zs7MTywlaivJPzO6kvN7UGQ5d7bXzE5y3kQHu1PV2e?=
 =?us-ascii?Q?siXpBwuQf2szIAD+6a93ulbAiiYf4lrrJCEy3/d70EC9JPdP6sdHj5UfqaqT?=
 =?us-ascii?Q?UjGKeYH55aloiZUd0/8UkxmoR9gDZfg3tIiSfyytP6GCSltdJhjJ7oSbAJ0m?=
 =?us-ascii?Q?hag/Lan1PLiQ7h/OD8RQWfFN5iUc2fler3sQXzCb6c45jkNJGTmdbS6L28bY?=
 =?us-ascii?Q?rtH7zYVV+jxoDAqII+kbzI+ZHm/1M8t3YfOipGJdr0TBrpb0TW7E7opjnfb9?=
 =?us-ascii?Q?CeDpydhBTQ3H052czupUGLyVFzWYTGYRKHex9g3FR0iwVsWQ5vW46bsWFR8y?=
 =?us-ascii?Q?S9lSnKHDZA0CQzb98YFPbcBYNmPD0kC1bgskH0XV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fefafa-f60b-4930-088d-08dce8289faf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:07:15.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erl0p9Wx7FRy/UBRenXBL2mvaJ0lHGIbcS4k+bC2gW0z2Txf/yo5hub7TSCiFdlPDbvQg5FcAVTDV5BiKhYqcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813

When AP mode is running on DFS channel and radar detection happened
during or after CAC, firmware will crash due to the code of mwifiex
is too old to handle DFS process. This patch fixes above issue and
had been tested with IW416.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---

v2:
   - remove clean up for adapter (from priv->adapter to adapter).
   - remove useless check of netif_carrier_ok().
   - just return directly for mwifiex_cfg80211_change_beacon().
   - remove debugfs file "fake_radar_detect".

---
 drivers/net/wireless/marvell/mwifiex/11h.c    | 49 ++++++++++++++++---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 49 +++++++------------
 .../net/wireless/marvell/mwifiex/cfg80211.h   |  4 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  1 +
 drivers/net/wireless/marvell/mwifiex/main.h   |  1 +
 5 files changed, 66 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index 032b93a41d99..3d8f6c610bca 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -7,7 +7,7 @@
 
 #include "main.h"
 #include "fw.h"
-
+#include "cfg80211.h"
 
 void mwifiex_init_11h_params(struct mwifiex_private *priv)
 {
@@ -221,8 +221,11 @@ int mwifiex_11h_handle_chanrpt_ready(struct mwifiex_private *priv,
 				cancel_delayed_work_sync(&priv->dfs_cac_work);
 				cfg80211_cac_event(priv->netdev,
 						   &priv->dfs_chandef,
-						   NL80211_RADAR_DETECTED,
+						   NL80211_RADAR_CAC_ABORTED,
 						   GFP_KERNEL, 0);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
 			}
 			break;
 		default:
@@ -245,9 +248,16 @@ int mwifiex_11h_handle_radar_detected(struct mwifiex_private *priv,
 
 	mwifiex_dbg(priv->adapter, MSG,
 		    "radar detected; indicating kernel\n");
-	if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "Failed to stop CAC in FW\n");
+
+	if (priv->wdev.links[0].cac_started) {
+		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
+			mwifiex_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+
 	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
 			     GFP_KERNEL);
 	mwifiex_dbg(priv->adapter, MSG, "regdomain: %d\n",
@@ -268,8 +278,12 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	struct mwifiex_uap_bss_param *bss_cfg;
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct mwifiex_private *priv =
-			container_of(delayed_work, struct mwifiex_private,
-				     dfs_chan_sw_work);
+		container_of(delayed_work, struct mwifiex_private,
+			     dfs_chan_sw_work);
+
+	if (mwifiex_del_mgmt_ies(priv))
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
 
 	bss_cfg = &priv->bss_cfg;
 	if (!bss_cfg->beacon_period) {
@@ -278,6 +292,21 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 		return;
 	}
 
+	if (mwifiex_send_cmd(priv, HostCmd_CMD_UAP_BSS_STOP,
+			     HostCmd_ACT_GEN_SET, 0, NULL, true)) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (mwifiex_cfg80211_change_beacon_data(priv->adapter->wiphy,
+						priv->netdev,
+						&priv->beacon_after)) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
 	mwifiex_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
 
 	if (mwifiex_config_start_uap(priv, bss_cfg)) {
@@ -291,4 +320,10 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	wiphy_lock(priv->wdev.wiphy);
 	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
 	wiphy_unlock(priv->wdev.wiphy);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		mwifiex_wake_up_net_dev_queue(priv->netdev, priv->adapter);
+		priv->uap_stop_tx = false;
+	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index fca3eea7ee84..40f51e62b2e7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1858,16 +1858,12 @@ static int mwifiex_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy,
 	return 0;
 }
 
-/* cfg80211 operation handler for change_beacon.
- * Function retrieves and sets modified management IEs to FW.
- */
-static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
-					  struct net_device *dev,
-					  struct cfg80211_ap_update *params)
+int mwifiex_cfg80211_change_beacon_data(struct wiphy *wiphy,
+					struct net_device *dev,
+					struct cfg80211_beacon_data *data)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct mwifiex_adapter *adapter = priv->adapter;
-	struct cfg80211_beacon_data *data = &params->beacon;
 
 	mwifiex_cancel_scan(adapter);
 
@@ -1877,12 +1873,6 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
-	if (!priv->bss_started) {
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "%s: bss not started\n", __func__);
-		return -EINVAL;
-	}
-
 	if (mwifiex_set_mgmt_ies(priv, data)) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "%s: setting mgmt ies failed\n", __func__);
@@ -1892,6 +1882,16 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
 	return 0;
 }
 
+/* cfg80211 operation handler for change_beacon.
+ * Function retrieves and sets modified management IEs to FW.
+ */
+static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
+					  struct net_device *dev,
+					  struct cfg80211_ap_update *params)
+{
+	return mwifiex_cfg80211_change_beacon_data(wiphy, dev, &params->beacon);
+}
+
 /* cfg80211 operation handler for del_station.
  * Function deauthenticates station which value is provided in mac parameter.
  * If mac is NULL/broadcast, all stations in associated station list are
@@ -4027,10 +4027,8 @@ static int
 mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				struct cfg80211_csa_settings *params)
 {
-	struct ieee_types_header *chsw_ie;
-	struct ieee80211_channel_sw_ie *channel_sw;
-	int chsw_msec;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	int chsw_msec;
 
 	if (priv->adapter->scan_processing) {
 		mwifiex_dbg(priv->adapter, ERROR,
@@ -4045,20 +4043,10 @@ mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				       &priv->dfs_chandef))
 		return -EINVAL;
 
-	chsw_ie = (void *)cfg80211_find_ie(WLAN_EID_CHANNEL_SWITCH,
-					   params->beacon_csa.tail,
-					   params->beacon_csa.tail_len);
-	if (!chsw_ie) {
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "Could not parse channel switch announcement IE\n");
-		return -EINVAL;
-	}
-
-	channel_sw = (void *)(chsw_ie + 1);
-	if (channel_sw->mode) {
-		if (netif_carrier_ok(priv->netdev))
-			netif_carrier_off(priv->netdev);
+	if (params->block_tx) {
+		netif_carrier_off(priv->netdev);
 		mwifiex_stop_net_dev_queue(priv->netdev, priv->adapter);
+		priv->uap_stop_tx = true;
 	}
 
 	if (mwifiex_del_mgmt_ies(priv))
@@ -4075,7 +4063,7 @@ mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(&priv->beacon_after, &params->beacon_after,
 	       sizeof(priv->beacon_after));
 
-	chsw_msec = max(channel_sw->count * priv->bss_cfg.beacon_period, 100);
+	chsw_msec = max(params->count * priv->bss_cfg.beacon_period, 100);
 	queue_delayed_work(priv->dfs_chan_sw_workqueue, &priv->dfs_chan_sw_work,
 			   msecs_to_jiffies(chsw_msec));
 	return 0;
@@ -4814,6 +4802,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
+	wiphy->max_num_csa_counters = MWIFIEX_MAX_CSA_COUNTERS;
 
 	if (adapter->host_mlme_enabled)
 		wiphy->flags |= WIPHY_FLAG_REPORTS_OBSS;
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.h b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
index 50f7001f5ef0..0a12437f89f2 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.h
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
@@ -13,5 +13,7 @@
 #include "main.h"
 
 int mwifiex_register_cfg80211(struct mwifiex_adapter *);
-
+int mwifiex_cfg80211_change_beacon_data(struct wiphy *wiphy,
+					struct net_device *dev,
+					struct cfg80211_beacon_data *data);
 #endif
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 84603f1e7f6e..9ece61743b9c 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -19,6 +19,7 @@
 
 #define MWIFIEX_BSS_COEX_COUNT	     2
 #define MWIFIEX_MAX_BSS_NUM         (3)
+#define MWIFIEX_MAX_CSA_COUNTERS     5
 
 #define MWIFIEX_DMA_ALIGN_SZ	    64
 #define MWIFIEX_RX_HEADROOM	    64
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 566adce3413c..58e8a3daba4a 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -678,6 +678,7 @@ struct mwifiex_private {
 	struct delayed_work dfs_cac_work;
 	struct workqueue_struct *dfs_chan_sw_workqueue;
 	struct delayed_work dfs_chan_sw_work;
+	bool uap_stop_tx;
 	struct cfg80211_beacon_data beacon_after;
 	struct mwifiex_11h_intf_state state_11h;
 	struct mwifiex_ds_mem_rw mem_rw;

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
2.34.1


