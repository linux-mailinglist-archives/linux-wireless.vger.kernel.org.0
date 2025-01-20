Return-Path: <linux-wireless+bounces-17734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D2A16770
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 08:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC77A2369
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D40190058;
	Mon, 20 Jan 2025 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IN82brUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778217E015;
	Mon, 20 Jan 2025 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358806; cv=fail; b=XUmSbZinxjTXtEsaYZ6M7OIkQTs3z+gRsY57HVwlEON9Xj5188kRoQ7olTFU7N3hAz4kH4Ed8a/WpVd7T7+JVQLOmSDjwSkMM9ClykVQwwnAmhrtX3zIsBGIaplyL/pGB0DOEKirQ3d1/jqE231rcWtX5+gYZ97aAAsgCYNaRRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358806; c=relaxed/simple;
	bh=RtATQ9lKHQ2RDIWdstGAHB20JPm7KqF4194qyD7SS08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKb6SKVQS8YKEzABccVQ/yYB/fX0JuRgBOjXsEPkhvKp7/rjUNXNKtqv0kMAuc8+hrXzJS1jPWHwh4hykxBNmBLTTTzEIlVyzn/OfNPvVU9+b9Wkw92e6TgvfJCvGBNXchOY2K0VP50w1U5QUMOrmuRqGmSWpq9Ny7jTo1N/kCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IN82brUZ; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz7irse9acPEz0ZnwRlWDi588hCXL8/aFWppj7ZTm1Xy/AiThRXEowG2XEZojzJlE+ZstzQs/B+n6lE8OnuK4FBepdCGSbFW4gy5f3Y+hVET51+cJUP21h8EErhUfA0H4xps3byqeRWtYrpb5qhKGAEnCw04a8tSjgUFgG65vVxfm8aZRglIz1XzJjsZvV5o4HJ3vxScGzfGNInKSXw92omTjiIAs3ntbmxfcUjjKPIlW/zR8+jUICaJqM4jCk3WMjGn1CjvN0Jnj30eCaTjyQeLYKVjvxWb9asFtGWclCEV2r8u5QUfknWSIuzBpTaDdrD0HqBDMO2vG78WA4w8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ika9GaVnWrN7Au3JxRyHM1sAwjnZ+hPDYeuYOwjjt0=;
 b=v3vZkvBfNA7Bbvep8y2CGB6x7Hd9bGPRWuFMh63K8tPtsG7ZnbfeJnO29NPKq0msImJoTRDCTh5Jq8w5vsmMvF+wE5xEAXvBVtib/3efs4PkS7iJbE10ENzs1fm4XkAdAYmMtM6O8zWYjg1qSEognEZQpBE3ceFkz5w28031oBABzelXd/Bi4IwNwgAjJJXxgmf8DZCjP1bi4D+J2NcnujoNTai1gJXjEbHQ6JaBMQywS3jt9X4wiq6WWYrOwS9SludrRpi4Oo6R1tEP87NLZhxhgm7PtRFoWwhg1QYTv5NriYU/HUGvgYgSB0MWkG+uWk0AU3EdaFfinsbkKsRakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ika9GaVnWrN7Au3JxRyHM1sAwjnZ+hPDYeuYOwjjt0=;
 b=IN82brUZ33CpBGXrzK2M8bz91PoUelfpGmX4DdLfhs91Mu0bAY5n4829gCUaQtqMm+GP+JUozRR9hHJS9BKcsE6Jk6EhNUe8Dpf4C8qssh898JPvAAkwbRE7Qm4zCLcUCedqBNaktV3dqeNQHhiFd5x/AdlmhbFKC3gyBNFH55V3hv/LQuj3dYQOA6XjTrL9fHBekSVLHaqcAZ11h2uXsMPSKLS+9ERhH1SsWMFyExnNvuqYZMwOEVVipNuR1DsyYdj4JUjgnVrG73VHNmvrGEWi2KvRkiwPvnV66m9lYOLROoNyXixvmJZ36EwPrF01ilNmIH0uAL/9jPiFV0Udww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by PA4PR04MB7679.eurprd04.prod.outlook.com (2603:10a6:102:e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 07:40:02 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%4]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 07:40:02 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware setting for HT40.
Date: Mon, 20 Jan 2025 15:40:11 +0800
Message-Id: <20250120074011.720358-2-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120074011.720358-1-jeff.chen_1@nxp.com>
References: <20250120074011.720358-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|PA4PR04MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: fce6c88c-e3d4-4d13-17ae-08dd3925a64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMM0QZnkFkdlReN1KD9xWg+6RCA51pJLugHqiV5zaf1dWhRZFhll+Jt7+jJp?=
 =?us-ascii?Q?CwgIiIgqzNXl3XBF82g+nUHGIep/3xhiMORA2pMyemcEdbBmqrM2eoqS36yw?=
 =?us-ascii?Q?ZJ3iNw+IBdJEj0Mk/4eWUrNrCRv0ayynLHhj/CtSqpISISIxw5O8W0ysTsWE?=
 =?us-ascii?Q?P/VcZ8Gs5kSN9aKvWQKplHixd1rybLpwpo32NxWMy84TSsbsHpG0or0rWfmE?=
 =?us-ascii?Q?VpccbSdVQwE/unqbqZu2ve9dzuGmha4P5giKCE6GMMt4J0wrIvhtQuTrx4lh?=
 =?us-ascii?Q?2VSgw3YCH5FhXWt62HH1zQ8h9XuvxGlu3VF93jknjmETz9Jdp8FdAsyokxZ5?=
 =?us-ascii?Q?YkggNUicxZq5xlgglsq2hhNUdHtR0IPxq407X3q9o0EeRZlCHZ3lHp32V31w?=
 =?us-ascii?Q?qFZLn0p2hcIlxIpjyK0MUwxCXUa+itiRHntDvbJlGYyq7kW5i9DG8vbg7Usa?=
 =?us-ascii?Q?ZliEKVzBUVPHH6XyRHgahWRFKIDQn+BCeLVuoOJxvqWGyIwSRQnY785dy6gC?=
 =?us-ascii?Q?sWzAeHRUyX1Zrg4/kgQTUm+f2SNfjJn2wRWQO4fEshzIno5zYqgMfCMuuzE9?=
 =?us-ascii?Q?skElUitQQ/eCG9syIWW++mam9GkDyPxcgUdd0jP6yGGL0+1hloeEqyBZ0RZY?=
 =?us-ascii?Q?Wa6w+t066tpRQ737Z1RZpnxnGbYwX3frSqx6+/drkj6DaxL5gqSPMf3BBNFT?=
 =?us-ascii?Q?KHWmqvDg8Bi2JNlPIdTolKHboQKvmd5u5bGuhY9C8oDLFI228l9EGWTEoEhT?=
 =?us-ascii?Q?K0LLoReliw18jA2i7iphCi7iYLsOa7+k2pM3Us4nCgg3ZHhRgV7wzApk5Ni4?=
 =?us-ascii?Q?DQSbvBmDVlfrmguCKm/P2ykUb2c48bBYU7oOkkYOxjZm7sBV9+cblCAk8Wcr?=
 =?us-ascii?Q?wvl7DyLbSB1DrT4eGlzOpT4iMYQXwLwAlo0qZwrXAjrflD2WrG5g3cOVTP8/?=
 =?us-ascii?Q?leUhUypdQPnrzJcJy1hi70nFg1bMChQ7/suXdSSUn6kWp5omsc1FISSmwwuG?=
 =?us-ascii?Q?EfMjktR022nDM9w0g0RrHbr9GVCDWGKXXjyYFsinp6LNWHknWLBFCfZmU5gH?=
 =?us-ascii?Q?PH8A3ZljM6PbOWdETHvWbrX30NRPanml7BGwSWs6xfrFrufw95cXwWDfhNth?=
 =?us-ascii?Q?9mJDd04rxLY5ku4LEWyDmYnkcYI2+Gn6IZc0ejnftQym4b0OYnXvs73mYRpl?=
 =?us-ascii?Q?Z5g2ouulZk6WKLItlR6C2Vy4kHuvoN302GObTT6XpnZZqiRF3mJKNzvCsUoc?=
 =?us-ascii?Q?QlOlZVgR2ePFJt2EqbZzLTtEO4Ejy1ncaX636QysJeCmKOHn/DjuEn3Hgcbr?=
 =?us-ascii?Q?bMqtIogVvuO+Flk2L+efgZB0ZZWeOHkIK4bmGAenSJnNAPtxKJxsvpLgjPjX?=
 =?us-ascii?Q?maFJU5aomTkhz1K8LI4G6/HykPSDxBCLi6Hq71MfwbIwgd5rBllvVoaz9T7L?=
 =?us-ascii?Q?q2i5uoe5AT/TQK1MbIMz9IpWYtmKcWgZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CwKsBVMYxARXEPD+W++k9wJvMCM/Qtw0q1FD3bdajQUheEVFNVLoAEp0PieK?=
 =?us-ascii?Q?LdDRVnio3VmZKI2pCVS+rFFlyLZw4TzVX4HYeh81VgGS+Tmw6EoaM/hm/qfO?=
 =?us-ascii?Q?Dd+XqdWUJ6KTFSaAZfrHemSligFMimtKCv/C+fpZrf1j30bGYOcdMWl+j6/n?=
 =?us-ascii?Q?TSw9yPSD52R6phILNq6y70iJmVf5ExZT4GnhY42Iqxt7GjSIMCkTRzBBl1Vb?=
 =?us-ascii?Q?rJTcI4w+em6WqJT3jptKzq8yUjWYoulH7vJPIeFwGGcIBItwyd4gnzx5BBLx?=
 =?us-ascii?Q?3QIVBU0Xkq7s8/AyTgT8+52h9xmRstAKesb+ZQM2eLNTiuYRZVceRZ2Jz7aq?=
 =?us-ascii?Q?935KgwyfBLbAIJJLh+RwrGrYWy+EDN528AgpKaKOQ8rNGwKzSexOKFt369u9?=
 =?us-ascii?Q?7kTLKax//nmeTkDYnnmnJITIWqA8RpQp/Cj6Pd/obgYObaeh3cW9g0wFdtP5?=
 =?us-ascii?Q?g2NybuaWQbBopz8gp9kRLjdOXINmIKS+WlVavuRfMK4S/yDNbXZg14rQzZmM?=
 =?us-ascii?Q?1zT4+ha1t0HgoYyjPtKMgMy7Wogbks0d9u+tdtX2elljZrdbLyHVmostwxXm?=
 =?us-ascii?Q?1FX9z25EyI/CJc82UvH3NyM/N/l4SkaMitSKPBEwEs9qFP+xH/KHvJaJeyHu?=
 =?us-ascii?Q?DdwYF58J9Pl7xbaLbeZnk4kW13dJX6QTugIen6RA4VpjmxmQCNrZv/bqyl/Z?=
 =?us-ascii?Q?zq8TmA+yGRa+DmQjCkQ5aHNSDRG2O8BXuc1RZHfSqFSAZRTQGJdq43tOr/ct?=
 =?us-ascii?Q?GbhNsY/OsavC54Hk4XG7feMvPZNxHZrx5kA+/hnI2+J+3KIY3Dp3O8rAqLRj?=
 =?us-ascii?Q?APm30aufV0AV/V6dv5zdBnEU0inJHshe/nz7i8vpyCKazUhcTmihCaN0DirC?=
 =?us-ascii?Q?j5v19m/6EE1sucxJ9PM7drWEDKVOjrJa9OTFn9KzzlKEDcyypq43nX6PtvQW?=
 =?us-ascii?Q?La6YQmtFdONOY8EbwUzO/J0mAau5D1DzXLTL+6FG1k/stZUi0d2d7lOYaXHN?=
 =?us-ascii?Q?1xlMxfrK5ozuzGhuIeJtWrGQKqWkkpbABW+OId/3NgXf4ulZIetzE/SD4gYu?=
 =?us-ascii?Q?oeoSWbljk4nL/HQLbhxm333sXEC6t6dRTAK15PvUCjqGygQQtSE2Q1cbSD8E?=
 =?us-ascii?Q?CqQfqhL0JUqVds9suzo98QKkCI5XdIRnpt/nsJRoFJpo9D4909JqURteOMs6?=
 =?us-ascii?Q?s0SDD6tGGVf4D9EoG/XNmKKTSofUzn0IZ2+HPU7wu0M9eO44TN/NgzmFgwer?=
 =?us-ascii?Q?sjfIrlbIjlne81Hm0zgKJyta4bBgfeGhY1GF7ChK4mPEghxToCeubjJuC+Fx?=
 =?us-ascii?Q?Xr34yUHs+VAMQ18k0bCIbbDMVFwCqvZ0pbTXw/puoJdij6yIyLmk6QDrHUPy?=
 =?us-ascii?Q?SSLtR7ao2t1ZN4BIbRnOmGClyz9sN9eStgRpBnHyBSXg5jBOorY9pV6iE2dD?=
 =?us-ascii?Q?RIGpukkji0YuUQ+YlohqobrKaD0EqG343+iB8tC5HOJewJa1G/wIt7pSB4aM?=
 =?us-ascii?Q?SNV3GqOf8GvfBRf81ouWfcJ+hq67HTEE1BpfQTyUYbBg44TSv+ShjS9twvbq?=
 =?us-ascii?Q?PU8yVDDvNWmACbgFNsqgP1f6gOWZDY2Q4n5JRGUs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce6c88c-e3d4-4d13-17ae-08dd3925a64f
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 07:40:02.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga/8iBcEzkWUw/ImHAlasSOWTUj4wvTF3AD3PBOuBm/VnXpEj3Fvxy073EWMN8Wh+zoQsdp/OaDNUzFY2lVRUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7679

Add the missing bandwidth configuration for HT40.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 66f0f5377ac1..4ae0b4aaa09a 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -308,7 +308,7 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 	int ret_len = 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee_types_header *hdr;
-	u8 radio_type;
+	u8 radio_type, secch_offset;
 
 	if (!buffer || !*buffer)
 		return ret_len;
@@ -401,13 +401,15 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 		chan_list->chan_scan_param[0].radio_type =
 			mwifiex_band_to_radio_type((u8) bss_desc->bss_band);
 
-		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
-		    bss_desc->bcn_ht_oper->ht_param &
-		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
-			SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
-					  radio_type,
-					  (bss_desc->bcn_ht_oper->ht_param &
-					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
+		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
+			if (bss_desc->bcn_ht_oper->ht_param & IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
+				chan_list->chan_scan_param[0].radio_type |= (CHAN_BW_40MHZ << 2);
+				secch_offset = bss_desc->bcn_ht_oper->ht_param &
+				IEEE80211_HT_PARAM_CHA_SEC_OFFSET;
+				SET_SECONDARYCHAN(chan_list->chan_scan_param[0].radio_type,
+						  secch_offset);
+			}
+		}
 
 		*buffer += struct_size(chan_list, chan_scan_param, 1);
 		ret_len += struct_size(chan_list, chan_scan_param, 1);
-- 
2.34.1


