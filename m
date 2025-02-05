Return-Path: <linux-wireless+bounces-18479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDAA2814F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E26163475
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F012288E2;
	Wed,  5 Feb 2025 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J5B3437E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287422839A;
	Wed,  5 Feb 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718915; cv=fail; b=XWvvEBWT6ylx96usQ6C39XA/qiMypXFr4J/pnWMjidtZ/+XwX+DLiD1dqvPGJxexFGqWcQPcPLG3CCwr1zp0N/46/nAjOMO8NRHw/WtqBEs4VLP/GyfFhAxMWqya79R+DWKpyx0i6xsEV5LbRmEIr82HqU8GblkV8Kw750FNDAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718915; c=relaxed/simple;
	bh=o1b05TGmbXqGhC8X6JJ5S22uKG8bfCRjvkYBUVDZofw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jJLqjnPcIcagucPqgvS99p4IWcji8uLyzV0pJ/ehEXwY4mNRFjaonVbdrpUBW1SFxUE+in6bDAXFWLS60/KETd/lIBOxCVL3YYEFPj6TWBthbdneZ5RH7zEnS102Yi4L82hP6u2brQZ5XNgEaW0tpF8++/+I7c/ybI8trCVRGBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J5B3437E; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gawdvviwABFo7JNMdbTPkGlONXjbOw6jhvKwZbQxdBzbna5xLJiNgtbQ74u44nUtle4a8uhhuPCAGbSP21f84DqQfJkW/RLaTrVFoOvysZqGtPeIkx/wPE0KpQ5ayyoKekxdGql1GFnIVp72qYYlQgJBgvweaYOg7MBzJBsFYRqmHy2xIFzu2x4jnRG4pnMzVX+NNBelyWQe9O2veXeGh8o0X4ir/HNP23vFbofuFlgT19UiG8qovzGuTFce44O3ggD0PognG+R3aAZFj5R7K01ZKxLl2OggzSdVV7ydbmE3tihCgwlOMqi83APZyHZcm0WsJ0qIaQ1v9GDxVl6dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgblfDXOlczqSLdwEZI5a3p5qKLrjKs9un2HRbWQ9UI=;
 b=JHkB0e2GVYCT6oxcd6hayiotK/63A/BL5GLD9edUWlBOFjtcFpTwmmBJ5nyHR4QsRQBZVouDAuqUSjwFri9YT0Nbf6T7TqBqpq1cvsWoSIZM4CE5jOen+M1C1vbtjoc+5OWKmMkefS3rkMi2ZRqNNFQs8hS6ihUl/jpQSDoUeS01jvA+wei3pu+8g0Gl5M7cjlCyODKGHxGagZk12oum+PfNqwyxAvWgcKRyBA6xBIhpuoGCcaeGkwxUbHZVOutc3WNgyEiQvGmGn86Ey75l+8HaGUqW9/RLNZ2UPdLNAyBe1pPJy3WrpJhEc5Dmk60pE8YogSBInUaeTGN2Nh59Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgblfDXOlczqSLdwEZI5a3p5qKLrjKs9un2HRbWQ9UI=;
 b=J5B3437EmjooQYLviaU2fUPiK3Gckbg2Hw1etrpogXH8ioiJYy5MDQXHmaYcspXYh1+To85Fgx5qMimGxwwxASxFokQlnsNmMaVYNgoda+SIb+NjRV9t78T/JW9kQQH9sDiSF3NBjChhzYi3b6hS4WxQ73nRrkGo34uTbIyqQFNj06KCK0poHKH2KeZAwWIqpDOExhvBUX88v4kJ+jugVdx+OqM25Omboad5JKE9sOfSMUTklnFpuNcKBVcoBx1TRmDNVgjwyqZl1bLheAktEPUtOpgVWSDVrOShGWKsprhNjt9Q/2wxPIQ0HSLi1WK0b0GmIg06z0V2PRtEHAFKAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AM9PR04MB8841.eurprd04.prod.outlook.com (2603:10a6:20b:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 01:28:30 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 01:28:30 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v2 1/2] wifi: mwifiex: Resolve the failure in downloading calibration data.
Date: Wed,  5 Feb 2025 09:28:42 +0800
Message-Id: <20250205012843.758714-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::39) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|AM9PR04MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c67fce-72b8-4c55-e39c-08dd4584655c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zo6aPGCjgQSXH9d50/7NmbTfUq81CoL1LvZBczqQBTm7y4rXYCSoe4iGw1M7?=
 =?us-ascii?Q?HPa/E9fA5tT+42vGysKRhLm7TdWVl5Qg5m6oVwEGnNqeAjfMp4bA5FK0Ulou?=
 =?us-ascii?Q?ECy9rCVecr0TabBTpfXU4Jz/t+shKPULeOFomYZGNncVPb8b8sj3K/kqV8kr?=
 =?us-ascii?Q?j6+hUaXBlvMjKGnbFMIr9f7VX9d/fVgtjURliSG3IC0zjdAqu3gUoZTnqHlF?=
 =?us-ascii?Q?9kpiAkCgst0sR5O+aPn3sa/yZBLaYVAuegNDMsnT5Os416wfPqP+ZPlja5m8?=
 =?us-ascii?Q?HSSEZI5Mi5BayOEFO8djToT3Vn2QGUX34sF1nNi1iV53z/2GTu9D85rezoRc?=
 =?us-ascii?Q?sE/dkV0MgRGBZt3hCdIydHvA1k0V5Bvmc0WnTMsD18+XIOMCZIVVqFToJ6Ot?=
 =?us-ascii?Q?VAYnavYkQWc290T7Ludz3NCskdjRSnXPnEQl/VCJkP3t4UooI0N/hwiW5Ios?=
 =?us-ascii?Q?BnmYQTw6LwtpA5UKkVmb/PGvB8FLXhzJcdJv/7C23wYRM0Om555Pn8zAYUNZ?=
 =?us-ascii?Q?IqN2MkG2emvEQDfkUfzev4bbcnLV9WmSFVBTSAIjphNHDBtSJAfgWnGdilZR?=
 =?us-ascii?Q?55AB9Jmj8DGWvtgCW49oUcWGnoco77WkXfFabHkCanZgqLxtxcZ5n7Vk7eZK?=
 =?us-ascii?Q?+j4JmqTMCMk1cjIUyz+bMvOSGmjEusdeb3PjP42r0eTmD4PNmmcX73EvRWWt?=
 =?us-ascii?Q?+WZwbUen8RKpzD9wUC/LFwfOpjVprvGm8C1j8zIKEWfOKB0E3Ll+5Sv0tDze?=
 =?us-ascii?Q?rR/mlHGHwEcxbp31gUW9XK3ferZzjCcMu8Og9LSPeMqC4j40iLtL2tKr8u+J?=
 =?us-ascii?Q?dw0ayUek8bYRmkpsi7K55NOxww6q11JKX43eJ4oLc8KpJ5T3gsHzhirgoeS1?=
 =?us-ascii?Q?sQDhrMovhyZ041hYZfGSTgfJ6rVcS9SJEnQF12uB61Op59uSyu3Y9srgWwb5?=
 =?us-ascii?Q?307fiQ8cASwtb6svcccQScmasaIZUggTf4NQ8pLRBsXMYqLtFCB4LNBBlclX?=
 =?us-ascii?Q?iQSlc/oSYEC0djW9Eooc6ZDY5IdjRdC5Yr3w1vwUEsXTWDRJ+VGECfqN+ZL6?=
 =?us-ascii?Q?reqMjuds8USvGnqG12xsLE1xqPdblmpAIALKD5KCQBtgd/lG3RE/8S7X7gL1?=
 =?us-ascii?Q?uk3Q9Uc924EmJ2JSzFI5OswZhYKvaSPBqP+yrN2EF0L9w+SnRcSbTsv/XBkn?=
 =?us-ascii?Q?IUiDgB5Wm6zaKuPI2gUjPQwRCAjhbvE8OdOpBC0fbcFfsivhPlau7MAqITZy?=
 =?us-ascii?Q?Al9GG5oTONyMBUlLuqjBFmawIBrW4TrBjc3VqIJIk8ymgxSSFjXCPgur33kn?=
 =?us-ascii?Q?gOtIGAgTyoui2Kc/as879ER4aN5UPDUkjPINAbDUsuEue1+ZuHC5lfhc7H/R?=
 =?us-ascii?Q?tSS1PK1YtUE1tuiJKpPO7E7pzBCcLPOuIbfA92x7AOJUoIfHhkcaG+7VsLK3?=
 =?us-ascii?Q?RTgto7GAbVbqIMgjGSjMoLqVxOVioPMy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xBT+gk6/0Ddg3z/1JXt24+c+KkiFeHd+9uDvj8o0gGvjY15F7OqBrUvWTB2A?=
 =?us-ascii?Q?BZBi1ukU3e4S96yFFVn3J/6nifQxCI09HHaYR99uUZG89S5A4UcVr7qoEBRO?=
 =?us-ascii?Q?WoGLkcNZ3t0D/ck+b4lsUCv8PCWJy4gci3EuqBL17d9epTnOq8lhKhJoh1mJ?=
 =?us-ascii?Q?3zd2DSl6cYnOr4IH9NAUceX67XKH+RfVuIgl72bjEVVgSDFDLLu+sE2e8pi9?=
 =?us-ascii?Q?tjwvjHzrhOzCBlbAHsuCAwRl6E6mmJaOm0FPII/IwvVyvrmbr2OGgOONPTPc?=
 =?us-ascii?Q?Ph2/jAvCRD2RfwjyuL+TnhGYZCUNVb1ZfDBYAwxbRMdeThwZ6ZRPsKEnpQ7k?=
 =?us-ascii?Q?qDKkXD6jmelVcqYUEiP1gRNDG6975fS9RuFy1u2KwAsz9Ciurqc/avQRW2HZ?=
 =?us-ascii?Q?3aSVCQ0ArmNDMSg4XZFEJGwJ08UQcNVD/0wb+hDL0Iw97vsiOvEQuFHddig2?=
 =?us-ascii?Q?HvEZP2zP5kHZ48W68xzVpvohf5K2ioJDhKKEc70+c5oKZ7jaMpYOmo4IcGxD?=
 =?us-ascii?Q?MVCduyUBj8Drvw0o9C6RAttyofy9fw8SWha+vNiQhhJfgSqBL8XNzRja2L8h?=
 =?us-ascii?Q?68fC0Cgb9oPK/MhGrv2Fekg7iqfXYq4Mlg4abXz0ZCBATZJO/SGkr5YbDvJH?=
 =?us-ascii?Q?shKps82GAPspYJs9dhtkyp49fIZg971CD3MZscrJjYMMNHeRL85exoQSVHj+?=
 =?us-ascii?Q?JkffPy6IN+CoZByjVOBKFPTlzT+VVFT9+v/FsCamjMZNZOr8bFSeJgaJZmFt?=
 =?us-ascii?Q?rkVy7XmbnNykGmysiBP+zUbx1D48Yf2yibAA3qCk38L79dlDTo9giTXMWD7Y?=
 =?us-ascii?Q?T/WL8vNV+DMsNyNnJ4IyyZGhnOkSI1m7PZv6f5zc3tQgPnyMuPEgnhrMbY3v?=
 =?us-ascii?Q?vhZz1zSfOXycc9LEDOyyDa7QDeQ9eIQI3yZbCoRe6Tp9mJHc2sUiHt1C5YZY?=
 =?us-ascii?Q?LlctCmgUxHcf6lvwruRTVTtW76LuUJlaHaRCUmmygPxiMHxk1n38c1zHodIY?=
 =?us-ascii?Q?6RjSzb47uf7Xe39LNucEoHAzfCrfBUjtr4sVZ5A9dlYQND3GNtIWM9Jcc99H?=
 =?us-ascii?Q?ASA6hQwhFvmkaBIyghu/iUsuX+IyFmAYRSZ6TLlG7veA3ohAwVXlHCZFGSbm?=
 =?us-ascii?Q?GVXFKYwFid+X1mBw28b+TmUqTYDbTpASUJayuurPF647wt6TjWCSvfeYFZZ9?=
 =?us-ascii?Q?LIGzv4FzRiuL+Zc6/DWnzJHKx6ODSNMXV8PpBnFZTrf15Q3mmK1qt1DH2D5V?=
 =?us-ascii?Q?hMgPgLvSYMbE4t5sw8pFG/8kza2ULpQTcy84Lem6UckLhD1paPyi6HGFx4iC?=
 =?us-ascii?Q?9GGSqsrZAKo1meGIimn3uL335sGaDfXkbFj/x7p7sPb+IpGGW03OXMs0z8v+?=
 =?us-ascii?Q?FW9W3y3DsAUEtpAM8bJPVE+B04CAy4tFu0aMRIUq1LDk5U73s49SF6TZKqGK?=
 =?us-ascii?Q?BOHgujege9mbFp/i0JGmlzFxy+Xddv+fdYr1ZF1chJWxXGZ8z82fduikN3es?=
 =?us-ascii?Q?l+xgpngZ6Eh8rBo1VV9sxrAU7Tdxue+4KTDQrTTSNPlynQ9+5RkGb0eINymz?=
 =?us-ascii?Q?+b5B5RtENfoDVwDZDLzkoE/B8L9PSZgL23UXY2c7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c67fce-72b8-4c55-e39c-08dd4584655c
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:28:30.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVXJB29sb28Hn6Bl3e9XSAAZ4CvoVJ6s1H/2q+Mt0EqvLUU4BKpe73cQ5xaCO2BJdJH83s34z8pRSWV4RthzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8841

This patch corrects the command format used for downloading RF
calibration data to the firmware. Additionally, this patch resolves
an issue where calibration data was being released before the
download process. Without this fix, the calibration data would not
be downloaded at all.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/fw.h     |  7 +++++++
 drivers/net/wireless/marvell/mwifiex/main.c   |  4 ----
 .../net/wireless/marvell/mwifiex/sta_cmd.c    | 19 +++++++++++++------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 4a96281792cc..0c75a574a7ee 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -2352,6 +2352,12 @@ struct host_cmd_ds_add_station {
 	u8 tlv[];
 } __packed;
 
+struct host_cmd_ds_802_11_cfg_data {
+	__le16 action;
+	__le16 type;
+	__le16 data_len;
+} __packed;
+
 struct host_cmd_ds_command {
 	__le16 command;
 	__le16 size;
@@ -2431,6 +2437,7 @@ struct host_cmd_ds_command {
 		struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
 		struct host_cmd_ds_sta_configure sta_cfg;
 		struct host_cmd_ds_add_station sta_info;
+		struct host_cmd_ds_802_11_cfg_data cfg_data;
 	} params;
 } __packed;
 
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
index e2800a831c8e..027555211a99 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1500,18 +1500,19 @@ int mwifiex_dnld_dt_cfgdata(struct mwifiex_private *priv,
 
 /* This function prepares command of set_cfg_data. */
 static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
-				struct host_cmd_ds_command *cmd, void *data_buf)
+				struct host_cmd_ds_command *cmd, void *data_buf, u16 cmd_action)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
 	struct property *prop = data_buf;
 	u32 len;
 	u8 *data = (u8 *)cmd + S_DS_GEN;
 	int ret;
+	struct host_cmd_ds_802_11_cfg_data *pcfg_data = &cmd->params.cfg_data;
 
 	if (prop) {
 		len = prop->length;
 		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
-						data, len);
+						data + sizeof(*pcfg_data), len);
 		if (ret)
 			return ret;
 		mwifiex_dbg(adapter, INFO,
@@ -1519,15 +1520,18 @@ static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
 			    prop->name);
 	} else if (adapter->cal_data->data && adapter->cal_data->size > 0) {
 		len = mwifiex_parse_cal_cfg((u8 *)adapter->cal_data->data,
-					    adapter->cal_data->size, data);
+					    adapter->cal_data->size, data + sizeof(*pcfg_data));
 		mwifiex_dbg(adapter, INFO,
 			    "download cfg_data from config file\n");
 	} else {
 		return -1;
 	}
 
+	pcfg_data->action = cpu_to_le16(cmd_action);
+	pcfg_data->type = cpu_to_le16(2);
+	pcfg_data->data_len = cpu_to_le16(len);
 	cmd->command = cpu_to_le16(HostCmd_CMD_CFG_DATA);
-	cmd->size = cpu_to_le16(S_DS_GEN + len);
+	cmd->size = cpu_to_le16(S_DS_GEN + sizeof(*pcfg_data) + len);
 
 	return 0;
 }
@@ -1949,7 +1953,7 @@ int mwifiex_sta_prepare_cmd(struct mwifiex_private *priv, uint16_t cmd_no,
 		ret = mwifiex_cmd_get_hw_spec(priv, cmd_ptr);
 		break;
 	case HostCmd_CMD_CFG_DATA:
-		ret = mwifiex_cmd_cfg_data(priv, cmd_ptr, data_buf);
+		ret = mwifiex_cmd_cfg_data(priv, cmd_ptr, data_buf, cmd_action);
 		break;
 	case HostCmd_CMD_MAC_CONTROL:
 		ret = mwifiex_cmd_mac_control(priv, cmd_ptr, cmd_action,
@@ -2293,9 +2297,12 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 						"marvell,caldata");
 		}
 
-		if (adapter->cal_data)
+		if (adapter->cal_data) {
 			mwifiex_send_cmd(priv, HostCmd_CMD_CFG_DATA,
 					 HostCmd_ACT_GEN_SET, 0, NULL, true);
+			release_firmware(adapter->cal_data);
+			adapter->cal_data = NULL;
+		}
 
 		/* Read MAC address from HW */
 		ret = mwifiex_send_cmd(priv, HostCmd_CMD_GET_HW_SPEC,

base-commit: 22f3551b60be7d126db9233998d262edfc577d0b
-- 
2.34.1


