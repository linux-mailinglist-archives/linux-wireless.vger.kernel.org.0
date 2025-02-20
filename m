Return-Path: <linux-wireless+bounces-19167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772EAA3D145
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432433AA3FC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40EA1E47C2;
	Thu, 20 Feb 2025 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jz/b5MpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6A1E47A8;
	Thu, 20 Feb 2025 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032096; cv=fail; b=KjhTmajbklCCgE0Nj1VqgS5BZCCSEoOJ/EW7TJXqeBs7UfOYZc1DobSR8lvaR0alKLEPkFS5+qDxhFl3YibTp0bilYReBrBcr/GnLefz/LthnS8GBbXi2CLr1j+Pq8QEclmeibnQamL2j2lsp3mu13FZH6YkQ53uWEHpURvltkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032096; c=relaxed/simple;
	bh=zeigNLkO7heE5VSHAVgElaDOcjJjlgNUHNAEaVrsTog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGSuswgm9qHuvV73yE4DVKUc/755KRUxnCwYOQm61Bt9vgI34CATSUZ51/sM1KyovIxeJ0BuODlGCqDl5SExpn7yO87Vo7IeVjniS/W3Dxp6ZFI8mPNx2m5m0QyCwJmqHLnn4/SF6G7f7CXQ2C7UB+smlBi7f/GoAlH/47xfOJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jz/b5MpZ; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQQX2XXQMG/+jSgZ+T6CrcpyejFC3z4KmBwBGC0c5nSAYCO/7x9+swpqUEbZMoo8pFzufttndcQjU1cUdREho4c+YfyPE55LLhtg0CkxE7AwRSTuhUdP82LMWYQ2tYgz5W+Wnb6ZqwA0cDbkK6Uz0Ahv4HT27IxZ4BMXGkXZdW3/89alTzdhzKMR1DY1b7ufRIOBpSjBAJ9d4XXNPfetR0+nhILXdxjcphFyK0UNHEfO5hjWTLsbMLY2ipQtTWvdMkbtuzUsdVKWYU0USE1BE2MX1sBBXmnLXAkjajlI7NaGZxR1n6EYX74f8K3v8b00Kd6h6zPa3r5H9QjA05DBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf1qmo/M/ZFuhT6hUPg8ykpyOoOhth80j0MRwnrylPY=;
 b=PBBXKeu3vKF+XDotqCOuXrGhay3Teu3GQB+2gDSglvcRbA6K2L3Mw8QhTCWeGy4C+Xg+P4ikFf0YMXHUNtwSztOXNtcUcZHfGVjkYzYTH3ufHXeDxJxDo3FC27Id2Rit66CbaZoVz1dA8DUwjdOKD15QGGggL0HodXNReArSuqyQZmwCX/dT1EMpK1t0FjToVDygMynaiJJ10U8kbY3jqXQZrPDYlxI6x3SfeqYHrfkRBt3nKe9A8Y0Z99EvQ/guTLDftfr7nnBX7DHBA9YsiBORNYHxmscVw4PhHcFd7r+7Md75XukI4Zb30ESyGGGCiOtkomrcxDPhrlwAhdOG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf1qmo/M/ZFuhT6hUPg8ykpyOoOhth80j0MRwnrylPY=;
 b=Jz/b5MpZAnLxqXH+ZomH4BeVKFq+XB7DmqRfMMnkRocICG4MUrtzwGn8xq8cySRoHFPkF7k0QISnfvaOOl3eVtfqKhjE1jXcDCf/khoHZp5d9sgQ51Y6hhdo29iJ2bk5w1pRyzLJQ9+44A6iRE9CpwY3GIRYNKOem07Dl05YUW2uORh3UKHwB3B4KUqtRanFF7xIR2rfWfa8gAhhwu7udqZZiehz2UkKpYIYNS3g2vXfWpJ9hukuv60JF0CO0edhzPQGLFsCuWZLwFUTE3aNlOrlyaS7oTxhK+2D16hGYre8IHGvR/0KnXlsLCOg/PmQ+XmVFEDnYRL7XAw3iCRXnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 06:14:52 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:14:52 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v3 2/2] wifi: mwifiex: Part B of resolving the failure in downloading calibration data.
Date: Thu, 20 Feb 2025 14:11:43 +0800
Message-Id: <20250220061143.1417420-3-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061143.1417420-1-jeff.chen_1@nxp.com>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
 <20250220061143.1417420-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|GVXPR04MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c0ce23-26ea-4c6b-1207-08dd5175e323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFTpAGHH9nAJIoP2+Djwl49iU0FXbENlR35D/vK/6NzfMi2HvJwSfifJAMfs?=
 =?us-ascii?Q?3C9h9NgxjXTj1CL3d3MDHbEEhpkU4+o5TEP4ddRo/Nq1CR38YqF5OvqiBego?=
 =?us-ascii?Q?voH7y7zWsLmKet/GYQpjwNWnwvtUH/2TdVMwqSYFtKv1iaVkrthbVmLyxdF0?=
 =?us-ascii?Q?myqlQSDhE9zWrHPk32UjZJUeMtR5MtwZS90hRJcohInNlNB4NBawlrisfhvP?=
 =?us-ascii?Q?1J+ee5DUGqgbb0igQZZq0gAeZ/sfu1aOxlb+N0iVR7bcqoV4fHAlPvq+Elca?=
 =?us-ascii?Q?I0AfF3a6FssbPBKvcMUvjQfJrcqm1o9uceIJyfdXkMAKQH01rHrEKqUX9LcH?=
 =?us-ascii?Q?xJqYXYv7/JURvwOOG24QqldSSGzM8Ah3Zu83Y627BgEBzvhAEAxsmjOwwrdH?=
 =?us-ascii?Q?3dCmaISe7qyM2vYo2e29shkpXtuJqSp357ND85rHK75NA49pPO6NN7I/ykxY?=
 =?us-ascii?Q?/VjFQ9wihfwg6Zh/YR81Bc14ES5F8+vMcPgqhmGj+xoPCdAkv0QSbvW3vQty?=
 =?us-ascii?Q?rO+vgT+DWHv62bKAyPZjumWk0cTEu0kN+CuiGTPXtSHaynSC9j8qF4pcKCl4?=
 =?us-ascii?Q?mxUJ5jSHevLmIjuSqhjKj0b88+1SxLpxCRUTHAW8B0ugrQErGse8nEY1h87c?=
 =?us-ascii?Q?/KaTjV9Xh/2NOKR/LIcD3ePX154/LKUMfa9JTk/TYtvz6VcuBiLODzqD6CIY?=
 =?us-ascii?Q?3IrAC03dD4qBRVm+EFvl4NIaBLQY6ZtvAMT4BFmTf7gIHj7MQtGSQLr6t0BB?=
 =?us-ascii?Q?nGYwDAds/ZvAN9MnSH7Q4QGPu8buJ2KT7MpAiYb5HJBY98DcIDbZzl2I/WYn?=
 =?us-ascii?Q?87XHm4mL5X1k1xwoaFzvngxtb8Xq1pR6AgMNSerlrBjprSURwholWNPk0077?=
 =?us-ascii?Q?FA5prs/MsfkatdjIY5DyXu4AiUMYBq11M0TNFvbdMWPyv8F20+33anpmTOVf?=
 =?us-ascii?Q?joKqOI12Z4FSVBuJs5JbiXNR7XCOGUTezIhSgcCjmUlIzIz4wzph2Metzlo6?=
 =?us-ascii?Q?FVj0FOZoHFq15/z/ry6tUc/+AVDfPX4NR8yDTV0fHlRWgQbY1c+d3TPxxOo6?=
 =?us-ascii?Q?cBZs3hm7WX8uscTwyJRInee86/4aH+k2sbyikWChfwQn+KPSeHdILDKQjCrr?=
 =?us-ascii?Q?qGpAGVcilijqrf32XcmyE2L+a9PT3OGJ8N81XVyOSbWshBYv1XDsD1DXqi8B?=
 =?us-ascii?Q?BwuPuKvHYK5ng+LPJUxNxPN7IiyDGsAWUBUhnuq+emg9XtygX96PhO1LfsVn?=
 =?us-ascii?Q?d/DOlOaH3FufAz5MFHvaKrq9vjwQbL8JAbfcj84UyW0sJYj3hVU6NAVf7kfd?=
 =?us-ascii?Q?j/k3zpfVAHwxj6rDABgnb2m9Fz201tH90EYc1FtHhWzDMunb8Aa3ke6wULM2?=
 =?us-ascii?Q?lVCbaNZoKDAHj4IQ+a1hP1ssXWl/xSfrKHXH/g71p4hHL6TUHT0WV+g8VrUx?=
 =?us-ascii?Q?HigC4vrZVP+svSJNtxLPsBZ3IRNg0PTP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1xOfm4X9kmdvPY4ZK1BO/B1hwxkEBkF+v9SqCWqDDMDiAD66OwDNVgWW3fhC?=
 =?us-ascii?Q?bQ3MyRD12gEbbB9B4TFnAm9DKpIv0HjoqzJ/iDQD3t2WOLqXKSSVar8EEnVz?=
 =?us-ascii?Q?877FY4sfeGfyeimboMs7WbJTCDH70r7X4KWDP1reZ7V8jfUYfP1OoMJcCO4R?=
 =?us-ascii?Q?H8NKAKybXDhuwyLKc38bi4I7CS00YSJR/sBySB4Fv+R6Vo4pzicr7uPG+8FP?=
 =?us-ascii?Q?aGthSus8sETP2xwr96IGEIJ7mLX2OFzyZfvgHm6ak1iUIBiTyMfqTfiz9kG5?=
 =?us-ascii?Q?BtF3NWKIg0yYLwfg+l7kxnyJNpE1B8ddVihldmtP6F+J26v3cScWsZu3jr+0?=
 =?us-ascii?Q?pqo6K4YOZx52UnhuuF7TDn4fAMq6Lp9B+jUXpRlt2wR8o/3TVau2AQMK3C5d?=
 =?us-ascii?Q?CawBzbQLCLFdOA25b67cKtMHl1MOUonKpU0+sEO6qF01aIaZ5Fl/sabFt5I+?=
 =?us-ascii?Q?AMwEzFZlQ3x+dQcxFLyhfmRrhnRnj2yzYBS6dPDjkEODUUoIGgkdJ9zybbjc?=
 =?us-ascii?Q?BvJgmpfwQ29nPUe/gVnpsuquScUm90w4O6ZXscAYWj5WRMzlqS+vwwToZiei?=
 =?us-ascii?Q?Ytm+OZee7OEU9BMsnqJlpWX1H8yK3f8hJZiNcaKeUoi3v5mOONo2FNJM4H1Y?=
 =?us-ascii?Q?5lpbbJNmVQHuEvPYP14b42oDuia19V0aqkTBWowCD33g/sjzK9dcj2jg2skl?=
 =?us-ascii?Q?Z/T2iRPWs18simx6Mmw4ipwzsoui8JenfrimpCU0iJ3eGPcIfgM+Ifm0W57Q?=
 =?us-ascii?Q?IDN0MKYT+DeNVjH7+Q6zcjSGE7IQZiOFHU5utUfJuGTh7LIiIdhTYM2Mo5CO?=
 =?us-ascii?Q?FkCXH9XLngv9vO9fD3Z9yPU6dcv3kfJ203o88FNQ8bwXVNsxSldGo0klE3vQ?=
 =?us-ascii?Q?Z0n70+dTmUunD4cR6UGDq6qpedJi9xUpFNmH9DV2cM9bcw3B7iOnzfgKFVdI?=
 =?us-ascii?Q?I1/TQDcMk8ejwJDOzAwBZ9mt7h+KzErkrsJVx+kkNaN1DQMn44g/QnT1E/XR?=
 =?us-ascii?Q?Kb9wM9ZdcTWR46bPCeiggKHYvhWH3CczY/qkyin6sHk3X4FLC8SQV5VPRQII?=
 =?us-ascii?Q?WcELqshWXs98PEn6uDuA32pxw1J8dxCFQgtpqcYO4SbZTjcXG1Rc8Zr3BOIh?=
 =?us-ascii?Q?arkM+Gb8PMQJXl7Gev+yjpnUn8SRNcYk4WEX7tkT7zujLoIjlPK5Z9Z6DEUR?=
 =?us-ascii?Q?4G61felxNEyTRWuFKvQabRcuLYOd7jHqWFEVM4iZOUk8UKROl1CNFjYEfF5R?=
 =?us-ascii?Q?O6iHMxpkNHezDBkUNjF95Ug83Y20FcUXwHPDMwMUzfpP4r8zAMXGlBNlNxjK?=
 =?us-ascii?Q?ZqRBSRobsGKX9Mj8WFA62GdtLmBBcuZDmeRvQ5PIknhprJq6VVCGJYJFNO9v?=
 =?us-ascii?Q?dgYYzuXyAWNIkyS92WMq6ZIhRk7oW6tWHulGAKVs+yIp/szNfBF5yb+pN3c0?=
 =?us-ascii?Q?OsOasOcmxStoexp1F6JVmUOjYA50vL9vBQILHnVhaVPXAnEEqk7VH8ARQJrB?=
 =?us-ascii?Q?h40JFgio799GAV8CCKrele5uodvWSWTjpZeg8+w+BnBOKgLXY1duHoxrlp3T?=
 =?us-ascii?Q?BW2hUX7Hb4KKNwuu42588UKhRb86zfsdLwJJ8fSS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c0ce23-26ea-4c6b-1207-08dd5175e323
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:14:52.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bQ2PlVD1QJpSk29+pBXNHGeQZdf3zNJlQyoch21VKF/ZIX7xzJL6rDlJq734cgDquR8xrJkb74cuXUjzJa9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

This patch resolves an issue where calibration data was being
released before the download process. Without this fix, the
calibration data would not be downloaded at all.

This patch is a split from the previous submission.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c    | 4 ----
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 45eecb5f643b..b07cb302a00c 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -691,10 +691,6 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 
 	init_failed = true;
 done:
-	if (adapter->cal_data) {
-		release_firmware(adapter->cal_data);
-		adapter->cal_data = NULL;
-	}
 	if (adapter->firmware) {
 		release_firmware(adapter->firmware);
 		adapter->firmware = NULL;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 6e7b2b5c7dc5..2ba5269b0f3a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -2297,9 +2297,13 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 						"marvell,caldata");
 		}
 
-		if (adapter->cal_data)
+		if (adapter->cal_data) {
 			mwifiex_send_cmd(priv, HostCmd_CMD_CFG_DATA,
 					 HostCmd_ACT_GEN_SET, 0, NULL, true);
+			release_firmware(adapter->cal_data);
+			adapter->cal_data = NULL;
+		}
+
 
 		/* Read MAC address from HW */
 		ret = mwifiex_send_cmd(priv, HostCmd_CMD_GET_HW_SPEC,
-- 
2.34.1


