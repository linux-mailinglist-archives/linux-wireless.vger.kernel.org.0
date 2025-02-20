Return-Path: <linux-wireless+bounces-19166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FEA3D142
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D076417644A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C51E2845;
	Thu, 20 Feb 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UC6c+cNQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF341E25FA;
	Thu, 20 Feb 2025 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032090; cv=fail; b=B4YcsYjMtswJY0pcrRhofURT347WCz66qU6do4B1Gfx73E0X0CcDkwdAxdoR2XCaoPN7IBUhXVliCla97HkgT1tzDy+pdjt7S/6/rjIy1JIPCUnc3CpAiJ5obvFU7n7Icrruvq/SoAolmwrBPrEeGcqr4DJoPGM250co3pfvXJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032090; c=relaxed/simple;
	bh=GlR6eIZ2Zcy8IQY8ZY9EbUGt2DZPsZSOQxIzFYdhIvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KT4946hWqroVVG/kFuzK+F9pkAGoIVULF+JesfQ+5+HCVuiBkQtObER8T8HtFh0OpxiLGknOTArItSilVrKdxHcgoDT3oyZwaLwFpTNhjZx++Eo/xre76s7u83cmtqhQpPSFAxyHtGFNQpFc1qTmq+TmD2Wa1hNW7WJP9dcCdPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UC6c+cNQ; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGXyvqrgyVAKYv+d2wC4AIJGxeAz9kbmzP5SClYDbhIDcFAa4OgwS+7idxPRTs+JJ4fPSxLn25znoPvknrAVWHPJ7aF9Z/8tDks+hMAeXFwTieXoIg6kv6zo0kEvO/f8H0GYtoALNADYBou8uZy5eZhv2Q8v8lu0ZCSzr6jtLOGvVuvCRzuprYVl+uCdFpuQdULAHRXBdxl1HbbB1GWKa1XA73/i0ZvlAzigHCJqnWgLzesHVatrn5e7zX4LreP+RdDdsPbkJz8727ebbvcQxsmOFmZcdpOf9KO/K0B3gxz3UENqhDjpbhTBAo848rz3S/PuAIf+xE1eUnLCRoxOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktyi36l/FLgD7kKRY5wjaUegUkWBr8R8cXtYD8KHUnA=;
 b=xs01Oev+7tMmOIdgG0Gvr6nV6CIhPoo2suzhQGOmmc8rfFbELykAN8iUR3STumfXYtTeIR2HENTneaz4yzjrYz0tHv2otcGh3hOSRR8MweevPDErTf+rs0vOugJW8h04pvEqHwhjHW8PC0N7VDBqRzsg0k/FsWkbvQt6mlzwOspQU+8qsn9IbhAmaINLKNxt7qwxAAfmQvh2RlaUPJYAqKyRodoaerGsSsAVe/lzEazVGTwBzvhzK1Fyip0v1C2l393TMHV7T2mGHf+04hkQ0DGHgz45LzmhJyQ0Q2YfBaFCRwEFoFq/ueyMppjAuowggb0FO+yYDI3KfSwJg+Lz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktyi36l/FLgD7kKRY5wjaUegUkWBr8R8cXtYD8KHUnA=;
 b=UC6c+cNQDJ3C75SQlHIPJr9xxhQB9mvKSXPmg/cowvx9oNYszNyYfzIZNIchnhUgJr0f3XgdYFqcMGpCZog2dykgx+NzNeQCo2r4cS7iaGAuWgaD5ICwOEaEyVIOpC6pE8idJSqKgxOoviFjsekYA1V09OIq7bRdxPM4lwXxfEPcd18r1ts8k2pYlnfoKcoVe0sGbc87CsapcawX3FmYJBPaEVeBhI9ROKKj6RV0vdHZp/cUKy9hJmdnZS7t4x1KPWB8qz2CnB2KVDsF8oJMeMpdGUNQAk1Ye3az+YQTMmJkBwXeakofMnl4mpmbBbCdP/vM16vzuv3Rm9/MP+bSDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 06:14:46 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:14:46 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v3 1/2] wifi: mwifiex: Part A of resolving the failure in downloading calibration data.
Date: Thu, 20 Feb 2025 14:11:42 +0800
Message-Id: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eed19c0b-7b4e-4ba7-e72e-08dd5175df6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O59tLFoG0HMK4RtrR95/sheHCivOE/AwhUpcpTB0ODPsgrZb0Qxun7UxIhFg?=
 =?us-ascii?Q?MFHmsRp6neWRkcutWpjRjMmafWJH4BzvTTfUIxoHsXvRHSORJMNA77VHdS63?=
 =?us-ascii?Q?gpcIKgLuHE6yIYNCAdMqUHmHObXKjO/yL8feOJW3OkpK55GutOkCT6zQ02NI?=
 =?us-ascii?Q?S/Vnt4iruZ+Cxunl+qO3Uf6Fi4Cnjzu9RWZsEAZUrQSVZ2EHpFRRqnW4I8iP?=
 =?us-ascii?Q?Mk5t0vV7qNKDSP5Ow//5LX0DsNt1GhRkdL3w4Ksp3cZf0iWPPr0EJHEQN6yd?=
 =?us-ascii?Q?iqCv4NJ3/p+ighxC0qkeSWadDwXlHgpGdZWUnpxF7XKEVs0tGQUluVP1aLhe?=
 =?us-ascii?Q?ilOG0i5xQl+8uF7HsN9+lCl7FNJ0MekTttZPwzlRZk1OQ3PNH4uIG61KVEMo?=
 =?us-ascii?Q?9B4eXnOZnzFeXSVVlRgy0iDDHRer7u2YmD7cAc8DEz2UDN65G4gphQEQpMsK?=
 =?us-ascii?Q?WYqgjE15mF5Fs27ZFz+aBuQu0Jvu2BhmNIUPuyxtjAH8cXjFPk+kCPPWRZgJ?=
 =?us-ascii?Q?xcrwSbWMNqqFCZdnxId/nGD58X09fVkRITEYJyhVrq1+X6BmMZ8QNEigTEPH?=
 =?us-ascii?Q?AQiwOObXxYC1pyYQP9vEv5upC4GTi4EA5zLaTWWiHOzMsBVhhVIfTnRFfvM5?=
 =?us-ascii?Q?LpZLxgVGnYX//34bi8fbT12FKLEkxXtp2bEaSXdXIVqKfHljK508BzWn8IRC?=
 =?us-ascii?Q?d6TRTK2ImqQYvIag51tf8VRa1552j2wZRfLEy7vJQuWqn+teiE5DuaDQiJpl?=
 =?us-ascii?Q?kdzSy7oUQPJdVp3wnzlCv3UYrQrVyQosR4sV7pGTMyWtVqbsrEqRDDSu4vuF?=
 =?us-ascii?Q?V02xKoYTFopx5SFkzFK+E8Zz2RqQPsPuwNAuNSgcJnNhu7R7r2WH4TLk3F1j?=
 =?us-ascii?Q?07uZNvVN/+C4Z/XiYchMbGAXmZNR4tc9BymVVjRZi+kGqRxVYc4VCK4h8UvP?=
 =?us-ascii?Q?g/06kEkkp8/7uI8VHphPZmXyo4qPvjDygUYGwwFNIWKNv+RtUkHP3SI032vf?=
 =?us-ascii?Q?hIxqkKbqFduzaOsBEn//kLhGEVRycsM2lnjgpsnHcDJuSXjTtWOLtXAQcjSK?=
 =?us-ascii?Q?9b/F5N4kUKZ/RRcg6JQ/3LbY/RxGVWXaQoeLdz6b2kg42Xifs+ZpZLbNsssL?=
 =?us-ascii?Q?/zcD4ezg2pUJHf3GhfO6+eSlYFEOeACE5gNpv4JMIdxiOuigpEBcjCbMv4SU?=
 =?us-ascii?Q?Iyq+0Ow9FAMBOp3UIgiwZ5xZRVEw4jhedDwPwp7OyqWMkkWMEb5s/JHFVWUC?=
 =?us-ascii?Q?Jxkt+PKN7QZhBNyWRvMK65xcuzigq+uEoQ28NnvWz656yYOD0/IXwU2gv84H?=
 =?us-ascii?Q?ohMrdHTALaVQgNALdnxYk1YynUKw00tjF/HXAsoIHqEGox78dv1c0/ui3tP0?=
 =?us-ascii?Q?EfUPmKmepDVwAOdKShJqDZhxgZuZxOqX3t+G0W2Xx+wnsjxPXDazp3OCeod9?=
 =?us-ascii?Q?rs7YItpgJ1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFxHZmaKB5nhhCIedf9vEeRpzwT55V8zQ5b0g3Meb22bbsNIf/UCUrxHJtYb?=
 =?us-ascii?Q?lTP2DlnavX9XrhvVebYUEvMjIvUq8FN7WCsI0u/lQ19qooENZP3ooiVMyTo2?=
 =?us-ascii?Q?3rrcMTpvbcMXFOgLxjVW0t8JUs/g2OpgroNq6XC9Uf4P+lth/VVAjW+kBPVl?=
 =?us-ascii?Q?cZdLxgiJbh2RI0fIAeQhBtMdk4wy5CtNCwye7fevMVo7f1kfRWNEZ+QvE85K?=
 =?us-ascii?Q?z10WRefZ273NW+EPkikrThvOL5v3R5euKNIFREPrT1ojilhnpRKFd24WJFuy?=
 =?us-ascii?Q?zjmW/Wq4QXsmn/A5T19mmepGaQsgJUdzFYs+rq7n9nqNmrQWGSMTSq73txqj?=
 =?us-ascii?Q?Bzs7qVVkjfK11YzaVpPZ8VwHeVeW8IGRnTyfY1DJ57RRtoLg21nUvY1EOmRv?=
 =?us-ascii?Q?bsfR2IuH1XnbWcL/Z/dff6n2vxx6fZVEw8WtSJrA+TEt+ErwyK86n7bDJaDv?=
 =?us-ascii?Q?26RqcOfoqvPoOCTB9jd/vy1UKxu7HFUTuT3Uu8SY1nVlHuAHiCkOFnlnEV3Q?=
 =?us-ascii?Q?GtlqnNyEJ1T8zv0CTYYkyJjVYsQ4gEAswl+rjTyNx0tcI5F8f0aQCK/g/RQ4?=
 =?us-ascii?Q?A4f7waPldKZ31rWp4uX81xUyfh9xl0c9y8R19Rq5T1AXaXMvSRFdQKwTFXqH?=
 =?us-ascii?Q?URynBA4ugBvQlTOXszHj1LmutWG5qvmYA6CP/yAP9RtcHElvdWWGkJXOtCbV?=
 =?us-ascii?Q?XXxO/gISRNSsrSZMjQFVv3Hm7yGKYbng99bNFctWiniD7DifEAShKwr2JtB4?=
 =?us-ascii?Q?FL97nh3yru9yx2BgdCErG3JEsYNmNtsJAcv081TLY0hY89e3M9YEW9PKJYMC?=
 =?us-ascii?Q?+XHQowqzTkbB3kWGu6FxygKZUS/6k9SFYOU2xwmOZvDvmCExphJ4tRbnbnkG?=
 =?us-ascii?Q?h+tHhfX4Yy7tUfD0LN1fe4heZIWtX+wtcN0hjuLEztWENux7uNg4hlyMKQjO?=
 =?us-ascii?Q?9o0tDRot6ERA0vrcqbqs2JaVW2COMhWkjC2rZtp8pfQR1f95tbJto2GkT/K/?=
 =?us-ascii?Q?huQv3nqQ45wFzM5ZBP95+YQSQ3JEQQXbGb62JbMxahL+pwwM+Ws2+v7TwuL8?=
 =?us-ascii?Q?nGcuYY6FmxY4/1+T6kwMr5eRU2Q1JeqjtDzzKpEGPjEiURiglKNBISN2vNFd?=
 =?us-ascii?Q?T/88Pg17+hQT4jke+HUNkzJuaFA38S7nz5UB/EDqdzeXqT6M6ofuYD/oRZpX?=
 =?us-ascii?Q?v8aCOt5ynPof0K1B6vxDearPsd9z6dUgFU5/C5UlCqpsKakZbOxnS6J4UTaG?=
 =?us-ascii?Q?auouy99IhlTQic7w25YuGM6zP718qOW76BH2aXoaPSWb/trIfuef66zEyZcL?=
 =?us-ascii?Q?3WVM8AeSM2mvOQWRb2frrIlKiwYz+9uh0tkJTQWEwChMzwIQ0zwPi5T8DuES?=
 =?us-ascii?Q?y07d2YjROxvyAlcbSYgH93IpzUZ55jGDQJHIKSdV1FYBdGY+wHvWp7L3klfA?=
 =?us-ascii?Q?8dvASoBHlHM4JvgygwrovF/eF46UjgahyrpVyX6ejNqruKqm8OYNDQW2ku8m?=
 =?us-ascii?Q?eTsIoiFbyrvFW4FRZTZPR5P6S+0cftxqLIh/dhGPyaqULIDbEiOkVfMAGMq3?=
 =?us-ascii?Q?wpb2cuNTfKExiEkolXhzjJW7knbZb/lRYHxVzvRR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed19c0b-7b4e-4ba7-e72e-08dd5175df6b
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:14:46.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2z+0WQ+M/Mvo094PVPHUTjNQ7tMa0yJWYET8YR99BxO7BEgiVrtqGcopH3DfnpvHqL+4bM18boGNd0O8BkT18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

This patch corrects the command format used for downloading RF
calibration data to the firmware.

This patch is a split from the previous submission.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/fw.h      |  7 +++++++
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 14 +++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

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
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index e2800a831c8e..6e7b2b5c7dc5 100644
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
-- 
2.34.1


