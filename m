Return-Path: <linux-wireless+bounces-13678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6A0993E26
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A41328642C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D742A95;
	Tue,  8 Oct 2024 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m9XTfTkm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2823A6;
	Tue,  8 Oct 2024 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363866; cv=fail; b=INeJzsfAbhOWjG+OjBEgMYNaE2o6B53dACMDEbuvGct9zdGr58T4R3OYPE468wqV+v6trEbPhn9aPCzX2yyVIfIC5cMurva1mv31XlEE42yGoYALvtw920fjIVVfpvCUTrz6L5aq4+CgEi++RtfEiVRAsUYvwLTdhpj/04pYR3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363866; c=relaxed/simple;
	bh=TEn3ZQdlCGqhIhxA6D0CKz1GBjfN1sFjTHgThF2PZHc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iplWbGaHuYurt/5sqieKzJDamsNxBpVyVpTw0S3D+X17z70i6vaDS/P0zyWjEjTuhfGt6Vmi12U+EXyfjtXx6m1JzZgFLjf+9ki+UshtDq9EFcDrzg70MMtWtIuErdiR0FO30gXhuiqx4YCnKHckMyvZFGVEyMcSqtqD8I6uNqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m9XTfTkm; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRrw93x3XCljqhsAqVsIIwX4od5f3uFycRoVlp0s3tf/Bn+ujyok/6CD4S01mC/1hJsZ23WD9XUuAXLSgH3AAjflk2ajsP13gu8qEIQR55Po8xbaCk9LGRV00+eCSM21NHvxp7TzzZLHJ06zPoU07HGFhyZRFCA2sZOQEUT8NlMG2mx/MOjhRsCkvW6SvaHm3iIdQGbZL5kCAjh71oykolSVZqc2VzRitjzMYZhweCVF+mVjVWQTlu7nw/Y8CFtFP+0Mp2v2qB1h4QXnThdiy+7KGHluGSm8xZ5fDDr4E4GklAyzRWYObPsfRxS1AsmxpNdmbKXtbY2vfiP4wIACGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7khSzus4jCY37aCsRtllXyQRi4428rLFuOPqi5i1f0=;
 b=x/LHTgJCOoehIyDDo4HOsNqnQscaeLRSIicjvkU80Y3p3TlUpz6KcEHLV48fXh2T/IgSlfvxCTIJMPKpWNSbELZG1Ep8l/Wc7rgt2ZBtHkLZaKlwqzXeMX4LtrSsbQ/RxcRM00qKXT4b01j289mPiWmYQH2RfPlqiGEORFjc4RSw20vzKWgGGkMrAYXzurBFD+6flSpxKzz5blIXzKKvCdVkgfDGs7m6WMx6jfZX/2SxnZqR3JkbrPygKPGuJLjQyA/2gjKGkhgIEtmudusIeQcuIbH0gIfUBYrq0eMMVYBPc8Kc7U+OwDWqQ7f25OqEsR085g+d3xCfVPe9l7YWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7khSzus4jCY37aCsRtllXyQRi4428rLFuOPqi5i1f0=;
 b=m9XTfTkmbkf9JJBCLWJufKTdeRrAjdkXYDwlbyIvME1KtRHm+IeUSZlZ8LSSmoW3VzbqwYPTzLCTN8rO39TL5fwemMBr1Wqs7yO4US7uwXOfx0yGV1TsueJbZnHZXzNlFQehnNWjPk420EqRhXepOvA2eZbwTPPDSLTCsYeBYUQd6lgQFvD/eyJbzxRhQiFRt1k+y/FCK10WiZsLchEVhUIiPc0SamFzn4BEt1QKF4jFhZhVWpxk1GShuQIFPxTJAuNbF6P6GJ0Fg1/bXahqrmFNlKmoNHTWF+kHStsi8bTfOGM/QAeF0sy9TwNWNsAPdSB9jvd+/9pPBercMqMgtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:04:21 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:04:21 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3] wifi: mwifiex: avoid AP and STA running on different channel
Date: Tue,  8 Oct 2024 13:04:05 +0800
Message-Id: <20241008050405.6948-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc4b50d-8f67-47be-5404-08dce756ab78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C+RZGgCkq0f21qMiWOkPI3qVP2gTJhJg48ql8BdWxVbpLb3eP2ZQiQYKJCHy?=
 =?us-ascii?Q?tj5x39mMzOcXPHJTnh1QC252aH1ogdrJexfX7NJrBzUzBxw8sZ2GXgzj46H6?=
 =?us-ascii?Q?lVrcH+kG8NlOxbRC/SNGM7rpDF7UP4X+VYl1GlonrRMs0Yqonq3CucpD9SSn?=
 =?us-ascii?Q?4YxHuKPuLMgOz+rMY60Ry8wD97e2r7qxhEyusOZtNPdFsARHTXbze2xNkLXn?=
 =?us-ascii?Q?94MYEK1QXLrx/6JAbn2OJmnKzTFq02C0o06oB0ccwvsEm7J3+ROwxMzpDw92?=
 =?us-ascii?Q?VMT/xkOAQZfiUeKZPxG1n7+e2sa1lA+oZwY+Yr1okV4gHYf0juN30hulQOHZ?=
 =?us-ascii?Q?/GUEfICHbX/U2icXA0eStajUocA/0Hnh45wjAgyqvwLnfyHKis39xv/E5U4W?=
 =?us-ascii?Q?KsvpbueFYljpgmVcOSN9jyh0TfL+Lf+A1GbuzZtuE77eJVL5AG5ykuvatwjt?=
 =?us-ascii?Q?Ab5LwS1W2nM5NOrBF86OVyy2E5k9x1g9f949bKYET85uavB4mvhyyJkp5P3e?=
 =?us-ascii?Q?YO9xafvRLqIBj/9wTI2qTNHRGWE2zU8+rhQdJvBNsTtGQFxcBVgDz9kgYSLh?=
 =?us-ascii?Q?+gy7fzw2QeXn3INYKQUJOUnE3hff4Js+abN29yDSCSoJPuSqIUC0hDH14Nma?=
 =?us-ascii?Q?pDrGmNVxlDYoW0/ZEJ0xDjel4PvVOqKxPzNS9ctpZiHMR1ghNoBPUMRkT21I?=
 =?us-ascii?Q?i7hk4NGv5TnapY0V8/8bkNi8yhTuuED+94nwSvqWHelZzakXVf3NxMvCEIPq?=
 =?us-ascii?Q?JDk4+F2Kb2gQdBW7iqnjJxJHR0rXSCMi7MjBwKb1F7AfmMkAzGcvKlZzFMT6?=
 =?us-ascii?Q?sLOzD6WQk8CaU24SMuSxl1IgPLiIyTotBGIEn8J5w4tauHwv73G4eNWs8BSf?=
 =?us-ascii?Q?jWq0k2rgObTBOfYCdOOihoDi3fObI716AFfWWDMd/CfACz7tXptHkY7/xB/Q?=
 =?us-ascii?Q?erkuSjsdquBJminMVOb0yKDdawHRV10yoZuE5iK8hHYbmTTgK0uIzBJF/iTu?=
 =?us-ascii?Q?DAOB6KWQ6Ey9UjnAnw4P7EXj00bwLwJU3Gw8ORgk1ntgN/V5HH850V1FRwun?=
 =?us-ascii?Q?kTG5OIRF/xx21l2n3WgzLllUgbepZnIoIVRUcuNeO0hmj/nVLlySSduwOLgc?=
 =?us-ascii?Q?U6cZL5LU6n2O9SI7aKPCRDggqkp3+dANtJQ6pCy5+Yuk8MJwhUQPwvqrBLTO?=
 =?us-ascii?Q?vyH6p1dtfGFcJAj/3gby7Kj7GWmR5N1i1B4AOppua3SV2zLpDr/bzK0EaJgQ?=
 =?us-ascii?Q?1N4qCkc5xDxedQRVncCapKZsgw1v746VET/2kOsdc0rKnAbwsrsHWrVxo+8V?=
 =?us-ascii?Q?4f9gEYrKWoXgw8DFMqDioY517MsUHy1+uLqYpaEdUgbclg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VH4T6t4TxUhZ5l4pEjzk+z+kYem8ProH2eoxBzH+raZFiFtwCdqy1iPv8Sdj?=
 =?us-ascii?Q?0KTO4/ms4iWn3ywHPMDB5EqA8GPZ9lxlpdGJhMKHaTLhYUSVK5IbRpoJgvun?=
 =?us-ascii?Q?x9a6rmVcCDk2CQwk/WWZtaBDa13iTcqd9gBb/ZWnkl6wJKRguwB2BMeCnVNB?=
 =?us-ascii?Q?DZmDEYQ5QwNYHMITxpelNwNLBcpC7KR67DE1bkhq/MKW8N3kqpkZF3o+tb2r?=
 =?us-ascii?Q?QBW5lGoeA1+vIyIZCrNxMfJQF3+pMN0/at0fqTI2ekzziPLcXTZaF86qSxbx?=
 =?us-ascii?Q?j8kmXdyPEpu/BHeKN97hTTnRNJiq7jBrBkVxYCu4Ox83sJavpQAmVn3TNshe?=
 =?us-ascii?Q?XzXNkdm6sG1Q3DEhsgV2LeeaWcWHpNYMwrQMZm11B+nBdjyC2lfRIft3vY7h?=
 =?us-ascii?Q?ew/dxC/hTHg6TwT33wnsKsxLRbqtkn95lxv/YI2soQscQgylv8Q9sxGXSTCx?=
 =?us-ascii?Q?nW0zC26BtjqOlu1ct2yoS67q7KV4XLLOmmlmOr72MkvqlS6q2V5hden6/F5I?=
 =?us-ascii?Q?V9TGP2opYEU8QCWk8avCxA2Lzt4HVs3auddc8Q5kMWezmjfJSxsiCKGqxH4f?=
 =?us-ascii?Q?wo0cVzn8JvAN7MFIv312CIctkY/4o9aVfAbIYasXMq0cdXcRYhKRmQFIUqLs?=
 =?us-ascii?Q?3ZNrSaO49Vz/Tlj2Kipo4ifDD13kOiQUebGqwLet8xXBB5j5tvmS8EeFu2UK?=
 =?us-ascii?Q?c7ZCRsFn2vZSBPVXI/5rwltGcfjRosL/OgVQ47GA6yvWAnt5ykNfd23exJWH?=
 =?us-ascii?Q?7EWj/SzsLsNpaC6u1LYpN0tfs0c6sFadZ5JcBRYvUWOaGGRts6cbbTi1UpKG?=
 =?us-ascii?Q?R4dnM+sUKeBMe553LSfsvO09uADT78E7i36pyZ6TInBHIbIUGxjOr9aAlgJM?=
 =?us-ascii?Q?+sPJtciNq7Ua0fNyV0KzbeESN+BqYjEPCtrL5vjetrDkFr9D3qHIeRykSbQL?=
 =?us-ascii?Q?S3ho6vKv4DiDZ7PVTSk1+0Lzar+hB5ELyjEhYzmVPEk7IAn6fPLdVOyQwVeK?=
 =?us-ascii?Q?WStQpjL0zKQj7sCFgpiT3DZhnmjXRBBek3h566oJI/asMNnlJowOQgm9sb0C?=
 =?us-ascii?Q?JzbwRBZuCXUvoF1AEvOJpHZEOSWYOLHCoYJGJpQNpg6LlohI+YcFlHtHdl7G?=
 =?us-ascii?Q?5GOfxky9P1awsyTaAmblNcRW4KW3rNzl0NRWJJdX+xTZ8fa9VRIXQ9g/kmsl?=
 =?us-ascii?Q?O9l87PY2lKReLQCuROGa4nIPFZeKnPhIdTi5kHa80LLYeb8hzOsyq+EqxnHa?=
 =?us-ascii?Q?WFphE4giAlfxBNnZaMqy+WCTHAVVxN6bbLu6VXou2wascPwNjZrGvVciHmVt?=
 =?us-ascii?Q?fGQNjPg6knNbHcgpO1rPDY5IQOQVKzxQtAuJxpC7OKM87sxL/qb+wNOedkNx?=
 =?us-ascii?Q?ZqyLivMjOd0tB7TWf1FwJ6iRglLYtwe05ORyzdrrZzsCrAtw+SpBesRtG4jQ?=
 =?us-ascii?Q?4a4erEK+JJzPv82Y2hetBDiAenYBq0HAVEhHD2PC64Yf/kUNEjI6TnSmfiaA?=
 =?us-ascii?Q?T8DJXBzZeHEplb72PlJQHdZ/QbQ+RwENN54dYkZ862+hP/jY/mESx6O9X5xB?=
 =?us-ascii?Q?uMDL6dRODPuGEMysE2BGrolecRIMIk/F7dQHauSs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc4b50d-8f67-47be-5404-08dce756ab78
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:04:21.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26xXcG2Y9wBuZSZZ63LZYPLjpnKCtWL/JiBptI0G1bzK0rSpyiziqqbbfNTKtjfykHqOF9tvn/0UQibRXhCmRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

Current firmware doesn't support AP and STA running on different
channels simultaneously if DRCS is not enabled.
FW crash would occur in such case.
This patch avoids the issue by disabling AP and STA to run on
different channels if DRCS is not running.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---

v3:
   - add the check for DRCS mode.
   - add clean comment for wiphy parameters setting.

v2:
   - clean up code.

---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 32 +++++++++----
 drivers/net/wireless/marvell/mwifiex/util.c   | 47 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.h   | 13 +++++
 3 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index fca3eea7ee84..ebc891d5d6c6 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -746,13 +746,18 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 
 	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 
+	/* Because wiphy parameters are global setting, the setting for
+	 * the first interface will apply for other interfaces too.
+	 * If AP and STA are running at same time, these parameters must
+	 * be the same. If the first interface is running, it means wiphy
+	 * parameters are already set. The second setting should be dropped
+	 * without error return, otherwise AP and STA can't run at the same
+	 * time if wiphy parameters are setting.
+	 */
 	switch (priv->bss_role) {
 	case MWIFIEX_BSS_ROLE_UAP:
-		if (priv->bss_started) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cannot change wiphy params when bss started");
-			return -EINVAL;
-		}
+		if (priv->bss_started)
+			break;
 
 		bss_cfg = kzalloc(sizeof(*bss_cfg), GFP_KERNEL);
 		if (!bss_cfg)
@@ -781,11 +786,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 		break;
 
 	case MWIFIEX_BSS_ROLE_STA:
-		if (priv->media_connected) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cannot change wiphy params when connected");
-			return -EINVAL;
-		}
+		if (priv->media_connected)
+			break;
+
 		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
 			ret = mwifiex_set_rts(priv,
 					      wiphy->rts_threshold);
@@ -2069,6 +2072,9 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP)
 		return -1;
 
+	if (!mwifiex_is_channel_setting_allowable(priv, params->chandef.chan))
+		return -EOPNOTSUPP;
+
 	bss_cfg = kzalloc(sizeof(struct mwifiex_uap_bss_param), GFP_KERNEL);
 	if (!bss_cfg)
 		return -ENOMEM;
@@ -2463,6 +2469,9 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 		return -EFAULT;
 	}
 
+	if (!mwifiex_is_channel_setting_allowable(priv, sme->channel))
+		return -EOPNOTSUPP;
+
 	mwifiex_dbg(adapter, INFO,
 		    "info: Trying to associate to bssid %pM\n", sme->bssid);
 
@@ -4298,6 +4307,9 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
+	if (!mwifiex_is_channel_setting_allowable(priv, req->bss->channel))
+		return -EOPNOTSUPP;
+
 	if (priv->auth_alg != WLAN_AUTH_SAE &&
 	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
 		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 42c04bf858da..da5eef7b1dec 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -323,6 +323,53 @@ int mwifiex_debug_info_to_buffer(struct mwifiex_private *priv, char *buf,
 	return p - buf;
 }
 
+bool mwifiex_is_channel_setting_allowable(struct mwifiex_private *priv,
+					  struct ieee80211_channel *check_chan)
+{
+	struct mwifiex_adapter *adapter = priv->adapter;
+	int i;
+	struct mwifiex_private *tmp_priv;
+	u8 bss_role = GET_BSS_ROLE(priv);
+	struct ieee80211_channel *set_chan;
+
+	if (adapter->drcs_enabled)
+		return true;
+
+	for (i = 0; i < MWIFIEX_MAX_BSS_NUM; i++) {
+		tmp_priv = adapter->priv[i];
+		if (tmp_priv == priv)
+			continue;
+
+		set_chan = NULL;
+		if (bss_role == MWIFIEX_BSS_ROLE_STA) {
+			if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_UAP &&
+			    netif_carrier_ok(tmp_priv->netdev) &&
+			    cfg80211_chandef_valid(&tmp_priv->bss_chandef))
+				set_chan = tmp_priv->bss_chandef.chan;
+		} else if (bss_role == MWIFIEX_BSS_ROLE_UAP) {
+			struct mwifiex_current_bss_params *bss_params =
+				&tmp_priv->curr_bss_params;
+			int channel = bss_params->bss_descriptor.channel;
+			enum nl80211_band band =
+				mwifiex_band_to_radio_type(bss_params->band);
+			int freq =
+				ieee80211_channel_to_frequency(channel, band);
+
+			if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_STA &&
+			    tmp_priv->media_connected)
+				set_chan = ieee80211_get_channel(adapter->wiphy, freq);
+		}
+
+		if (set_chan && !ieee80211_channel_equal(check_chan, set_chan)) {
+			mwifiex_dbg(adapter, ERROR,
+				    "AP/STA must run on the same channel\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int
 mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 			  struct rxpd *rx_pd)
diff --git a/drivers/net/wireless/marvell/mwifiex/util.h b/drivers/net/wireless/marvell/mwifiex/util.h
index 4699c505c0a0..16f092bb0823 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.h
+++ b/drivers/net/wireless/marvell/mwifiex/util.h
@@ -86,4 +86,17 @@ static inline void le16_unaligned_add_cpu(__le16 *var, u16 val)
 	put_unaligned_le16(get_unaligned_le16(var) + val, var);
 }
 
+/* Current firmware doesn't support AP and STA running on different
+ * channels simultaneously in normal mode.
+ * FW crash would occur in such case.
+ * This function is used to check if check_chan can be set to FW or not.
+ *
+ * Return:
+ * %true if check_chan can be set to FW without issues.
+ * %false there is already other channel is set to FW, setting of
+ * check_chan is not allowable.
+ */
+bool mwifiex_is_channel_setting_allowable(struct mwifiex_private *priv,
+					  struct ieee80211_channel *check_chan);
+
 #endif /* !_MWIFIEX_UTIL_H_ */

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
2.34.1


