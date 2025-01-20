Return-Path: <linux-wireless+bounces-17733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7587A1676E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 08:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B862164060
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DE218FDAA;
	Mon, 20 Jan 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LyZPUXlP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17617E015;
	Mon, 20 Jan 2025 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358794; cv=fail; b=p2RmPuPyWqlGvN7iDpW7Tw5AcruZXjBDlr1Ho4zCgrffpwMeifbDvQUlki9Y3C833Yix0v1NmF5Jynm/6tfPPvBKSLbNDUjhpWPV3uaM3yruqdnUY/Vr8tNhbhx2EzaLlvV8M+jaVH2QCvxFjSblffRI8sUP4MAo3EcxBjscv1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358794; c=relaxed/simple;
	bh=e1I5er6Jf0qfKebO54zjQabJq6PPOQZ7xjv9euqNgJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QLxUz39/8JaVp1R31M5aS7h8k0B1ENubk3mVV51bAlXOsyjWlmO78ECgd4BIHUqDtLiOY/Rj8D7yVK40CYX6aTjyhKjU7aWXBf+4CbJpBuUPCE1SiDaL1Jh4EoZV5IQwI4YXeguGS3uSuWHhs287R2yLzXs/iFQo6zoxGS+dbVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LyZPUXlP; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ5Wd6LoJugfUe/dymI/wQHp4E/pIiKSWgfLDJ8QhMhgMpmWJLKHFO0llCJQJj1zXSl5IKyRWFKVVH8c95R0UBaJ1dncO1+3ZLtCZr0l5CYypTHpRg2W2pti/+mY/IdtN6pyluCaHP+EyyeVk6NZ0v1H+7LWJy2Xx5hoxthc8BZVCXG/U+2WwYl/rXnXopRZCEgNyvF+FnGiD9jOXaY6uhhRyjrGQzkEbjju8lVqafS1zSdW6kEvVjgNI3/ZFhUa+rhjlrQzruvBdwZVUsWOJZhreaVww9GlselYNL4wJ+N7/m+9j6/7scvrOW5cST+vZQooChZ3kPfhKEHIqqHgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EltfHQWvSWzSd0Vl8prVl4gUAAKwQWK2Ki79zZt+mbA=;
 b=fijuS1hnhQ0I+q2HMsLtUUGe27A9uyLMCOwAg2nclnsNEdaVTIslMzdanv9pHzY5+sECSsLVvE16QJocV3nLkAPmII7GPEcjZZLaPzhIhTk+ptBNyohDvyJb1mzC5JM8oHPNkHVmh/g2uA14YZve2HaRJHLxrLaenfk8knyq39RIZVn3M+Ek0EFwX014X36C/9ZAuf7Dz5xlPM5fq+4CYufcNMaQfva0q/jBrA0cKORCe9rg8Nbv3IlrxOg+6nnUsxgeeIzAjlVkr/bQVRMLM4PNhpVyLuMIciEIc4zJHbGC5/x3NPFQCUy1SoUt9yZTl5RbiaxVaFb9g9US57KUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EltfHQWvSWzSd0Vl8prVl4gUAAKwQWK2Ki79zZt+mbA=;
 b=LyZPUXlPa8EMfcCGBbE/QW1Khpv5SmdKGm8MNQFNBlwi8JdYLJ22eU4REO31IXvlzD+Bobim4OmW+OMRvJ+RNDGhchNo6/zHOosC/o1G0VF1ME3c3IS3XGXeFWGZ1YaxIFeWa/0NTvppRQ016zGR4FUlpSJbCR4MAmkoSYF1Jx+yYuGd/+u8bTpYB8eu97RGhbG34zi2kLYT6AUxduLtTOIYQc1Z6LPC9qYtVOMrqtaZIVhyisUv/G77fs2EIOs4Tlga5DVYAwPXFktqHxYu3uhhk9z/HAJahkESPrb+7A9VPvKoKCNFLftdNPPq3v6dib/aLy2yUzk3N586A5zJXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by PA4PR04MB7679.eurprd04.prod.outlook.com (2603:10a6:102:e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 07:39:49 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%4]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 07:39:49 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH] wifi: mwifiex: Resolve the failure in downloading calibration data.
Date: Mon, 20 Jan 2025 15:40:10 +0800
Message-Id: <20250120074011.720358-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 576a1a63-51b4-447b-493e-08dd39259e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vw0tAxo7oPsruLMRmS0qrHQ5eaoIgl+OcaWS2zyvhYEe17j9WJXqOfzQIyoO?=
 =?us-ascii?Q?bp5JfnQjgIoBlxr6acW1LJ9aK0l61Go3cgTGgBcLgFDRu4m2UA2I+9TZCAo5?=
 =?us-ascii?Q?Wg/h1OhD03Nm6GhuVuQdt31aE0CnCmym1CtEdXAN0HMj+/7Jgy6VX9gYZNaZ?=
 =?us-ascii?Q?McO/2XRBvfTy3oqkHxOsTJ7ypiufclAq0H/tOYS0nuF7Pk3QZ4QLlyEgag8Y?=
 =?us-ascii?Q?j0Y0WzXo7lCqA8zcNVXE/QLyGc2xcrnLEY3ePXjeiRdFLr77KOylHZ22Gbs8?=
 =?us-ascii?Q?W8uZS61AWGu3KRQMJBiGgvCy+gY+s9FJNhI9+k5VVA7ftiG1MXn0AIbtCxpV?=
 =?us-ascii?Q?wsxJiE8y4Fxk4em4v+YMVXefmh7dp1OuZON49qoxkHmdhQimFoPOAKetiHDg?=
 =?us-ascii?Q?Y6A52nM1cU2/g+N6jIT9pnQF/cv9VcJ2mMYlfzgpX6KS/MegV1INj9gI5cIb?=
 =?us-ascii?Q?M0qPoRrnAIx6doJkSNNiIiJbePZfdd2sD41HDi/flPVR9x514gIpC+SIOyJs?=
 =?us-ascii?Q?o3iE1yevZMGuFh82dvqR1KeCguhsgSJ9Q+MtDu+9jkb9p+3btRixmR3Y+sr2?=
 =?us-ascii?Q?xRzjlkRyC59F0bITzpUpVrrs6KQa5hUagrjvYI2SYssbv97qnSIUEL8U5KD2?=
 =?us-ascii?Q?vjiOGDAhTZ4DDWWuPr9ioYnkzeYw0hHP4DOhTazc1kdojgf0CA/6S/U+UkwY?=
 =?us-ascii?Q?aIYyc0MG6Ozm8V3+pUnPPWIaFGsajSfBx9of+4pdpmmycpQ6KiA9tLa1FOax?=
 =?us-ascii?Q?CG0YK5iOWqfSo6IBUpYJ+uR5xfejHDTUbN60koc6/rxDMbL+p0PPEmNiinhN?=
 =?us-ascii?Q?qMD34kKTx6KxfdiX0cLq+e5nUngiNorqA7BApnouk7moYp84WJwZurSi8H6c?=
 =?us-ascii?Q?+a0bWmRyaZVQ+jM3xZ02/M5FC4aVaHhiFzJtFuy/teM2XPj6yoo3nBd+RF2K?=
 =?us-ascii?Q?oQ62DTTHizXo7YlOu8R4x+qYEeef+KUActQ4aDRXNS/o09h8AmGdSQMnwrWv?=
 =?us-ascii?Q?5mZ7/iGKkW9ykyBPUqLa1bINHOELtYHxCDwRt8t3wGrmZvJGDMXBYyY7Bd6m?=
 =?us-ascii?Q?78w4+8cFmgeeqsJnN5yGYoiNr0hm69alSl9UxcN96uX91gh9E+7h0TP+e2De?=
 =?us-ascii?Q?hrRPI5TohkyfGVvuKByLramkj9I7BLfzzuvcgbBqENdD4OzoA0ATgo30TUBh?=
 =?us-ascii?Q?lsl6QZtAMiGeZvfus2zAAD9M++OuadbKS3sUZEQUYxhU9Di8CT2l+uPnoZ1p?=
 =?us-ascii?Q?ojYBWp+4UQq4TYZVj2b/rrZWbccddFXLFq7Lt7n/RBQEkIAOqTciuA3SdK2D?=
 =?us-ascii?Q?c2NB8XYMpCGURdK+E4BJaqQIMAZ5QJzAumx6kF6RlZl52+CbBUaNfmA+cH77?=
 =?us-ascii?Q?Y5vl3cEksZ33hks5ZocqQabeFyV92rh8xuezarHs5CE5Lg8AKq1x67cxnNMz?=
 =?us-ascii?Q?0/DliA1AZwdesnPEijH4SdRdHO5tFGDT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YenAIpnchO6W2R0PCN12g7NrwGWdgxFbavNOUXGTN1wVkw9vi2r5g6MBcco5?=
 =?us-ascii?Q?CnZoOk9UzUv9fngjBgpG3SCeo7ggKzg7PIxHPxWkVKjjpCgUvkJ1vQpBkJ3k?=
 =?us-ascii?Q?eZFwLL+R4Ot416Sbaj3GWe6h8EDYG1wLkKuW5wqZxazi8M3CYATEfkUXfJKj?=
 =?us-ascii?Q?0o8DUf6q3ahR6S0xKkEQ3yzRn9+ckqd1shxoulgIxnSmD/89nsNbiJSy0mqZ?=
 =?us-ascii?Q?30YZ3yrGr1aiQhCM/+2tnihibJVVVtqmawtIyYDsvMnesZoJKIe7XInWFfy3?=
 =?us-ascii?Q?f9eSiZXjiXwC649HRfQStvmupEenozHs/CftaGGRiiBdTjno7GjpRL2lKTge?=
 =?us-ascii?Q?XtkflmE/Ll/AhFRi9RFiVBNjP0DeYs/WcLaguwnvfecvgnjIPQM5z8qt40c2?=
 =?us-ascii?Q?xMaj6f4MqhgG1DuIQ6YOwwSoM6VNlGPWf7e/8Qsplp1inOdtYINl2cMnoNJq?=
 =?us-ascii?Q?dL6lEOccidcXI5Dy9h0nSu1fDXi40OYMOuXCAmb52c05EUmXwzr4saXiZKdb?=
 =?us-ascii?Q?bKkZnU5c2mcWgPfeUrfgNL38S989frewSb9pwmKP4aX+JEwPUd5xpsIR82G2?=
 =?us-ascii?Q?uGTAU2FApDsseCbihtlxUcuGsKa+tzyb/3HYYlahZEGBTcp2iAsW8QINbZPV?=
 =?us-ascii?Q?B8Bec+Eu0Q2AVSXysSPDO5xs5vUtPPjdzzaqeN4Tg6wd6tqzFZ9JY6Nd9QOW?=
 =?us-ascii?Q?4bl/k+IGSOQSAfZyC7pdpnx6uKC6RuBQKu/RTREFe07sW351ZIz6WuXTG/CK?=
 =?us-ascii?Q?3whteesNp0nf6ofX0cl84FKX3y3XE0JdaWTj1z1eB1alqkr2NyKUTMy6sZ6K?=
 =?us-ascii?Q?POx+L4SJ10+OqFSZXqaV9/0Ne0ouZwSMdIq+dUcD232Q9tjDq7bSYwQVMZwi?=
 =?us-ascii?Q?A7GiHJuMpKzoXZFFjGkMr9LTwt20m9HUVFHjoeMt4p4+ZUEpjy/dOqcaYxKD?=
 =?us-ascii?Q?y1pqSABNpFtzpUhHnQ9UftiGgDWgA3wIY9Nen5yP4sWz0Z86/fP94tKz+ik3?=
 =?us-ascii?Q?FqwLDKfyMyBVshsfpTFZeb6jPk0xxTlslPwRYtXDZLFz/ShJJaNm4A/etMgs?=
 =?us-ascii?Q?lXtbVNhPFINk02Weak1lRkWIKevOlWfWuWKhMrXKL4TUPOZoBqYx8t6W615S?=
 =?us-ascii?Q?jO7U2FQF430OqGhmTm+i2ZcWb1IQA/jq8ZP5iszXJgKt15He8fIuIk6Y9DYJ?=
 =?us-ascii?Q?T6G9X0eqZQUty/P2TGSSIU4AYRGoiBMO0alJ6xxlx6igPyer0Jo427tHyon9?=
 =?us-ascii?Q?f4DcvmiCfEE81z7WfrE1WdlxOm2ZpwNpwSTVDAaRb0RFZsIXfmwUlo/yFolt?=
 =?us-ascii?Q?aKI84xXdiEDBj4k97umPfQq9s3pnV1AOgufQmj6CTI3+OHBG3XtQe75mJ6PK?=
 =?us-ascii?Q?AVmU0p/e/LUgLpy5PRFPhWkb0mx5v3A987ooT1TrzKJvDr1fQh1Lt8gK85bH?=
 =?us-ascii?Q?wmBAQUQ9+Btd3Ig2MZ/MyqpwLTo0KhEO+8gW2iQV1oxEKK8VEuPEEAs46CCS?=
 =?us-ascii?Q?adporH38Viqq6dTFpqjyzwJ4Y4/octVYiJ35/wGMJimlLoZMN/BpHKoJ35hr?=
 =?us-ascii?Q?04wbDFP3PJXHwfxZ3WWfXmrVDT3lKdV0hyxfrTtz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576a1a63-51b4-447b-493e-08dd39259e6e
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 07:39:49.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CLwlzvsu7fHhOGjrbtrb7AQ//7LaEgELMlC19pHFiqzqsNiJcYq/13IGMiEAKN/xs5yZcnEv9sHEBciz3DO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7679

Correct the command format for downloading calibration data.

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
index 855019fe5485..80fc6d5afe86 100644
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
-- 
2.34.1


