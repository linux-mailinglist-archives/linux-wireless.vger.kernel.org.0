Return-Path: <linux-wireless+bounces-20482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69783A6690F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 06:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE4417A797
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 05:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DC1D63CF;
	Tue, 18 Mar 2025 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q628SxOr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F71C700B;
	Tue, 18 Mar 2025 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274522; cv=fail; b=gYF2MnmojAtWzxNvuU90q2ZP1qd6NWCXN7Hk7iWrX2uoGGIrKp0VUDUxMdhCCTnB4sjA/JhezaURLeYCx0jFaNN3LmXKv5jUTnjDru4q++yOsmacT0Q2BPTcZWzOn9resNta2wp4uYDsvh8Iv2zUt95pR3j0IOTJxbO0v4QWm60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274522; c=relaxed/simple;
	bh=Ulw0LJWPDjTqn38zyFdN5mMBAdNTkR41njDpRYKlG2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1JU6LK281W45tI5fMzySB5m1o0p2j05Qhs/OZdxEUHOS0//YGDP6Lq0VRfED64hJpbvNkaUzClbq1NmIb4sKQZqXa+TRMLpMot+D7XLk88pUxvkpOu0+QyjydH3kSfeFnuz2uCMUetLvcmjSxoATtajFD/u9ZbA5/U7033838M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q628SxOr; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+8cJpRUXHMAZKTylnQvd6aS3YpZjvOngwPzxeOIRi6Z2Uz175vc0cC2a0OnMllh3OpkCcADhk2wzzhSHqXsqVc5wjmvVIJOg4qgExmtvUYFOiW7bzr8e61ZsoDnB6Ooxk3ek7msgQ4yjAQFgXoZSaHfD8BIOnpb5R3JsaJirJJh7qSmgZOHephw0lyWRLBV8nazAl2VSwa+yyOjJS8qTScG9jFoZXFkjoXzwmZ0zN16QfvPu1oiMZPEEyt8VycNmzhyOAjqEEmyBVI2w4osZKWticempYnJmXMx+1mebWhSyF4e0WTOZu5BSCOze8r9kNcka4Jt8Rme+EYIZtrftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUWZi7GNsvO1xvgnuy82RDD2l8HnY12mO7Sl9wj+cBU=;
 b=M0wBl0HznjsQly0/c9NRlPgYBooUWVvp6aRAsP3AiEJU/kw946h0SdO7N4bvFULu0V+TT6YDuvynbcr8kE1dG0nY5iMJQ0F5H7Cltmjuhn/iriNRHBRclVdIk6MVqjdbwUdxPx1K33jOqIOFiufSIbPCpN2j35Wgh0k2twbv9UHaqEoH/5e89Dr+jYk6xTaBIdUisnKj6I+JJyP5g2wyjqQ3g6O0SDuIEO2iiiLv9Zv6QlHW47L2Aijl8SskmLb/KVmLDoX+smykiybYhCPPHAa7HJX5hmhh9A2RfufMsvdJOQevOe5nmsZenvWT72Qcs8rqDSoPcIJSsrQBDTeatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUWZi7GNsvO1xvgnuy82RDD2l8HnY12mO7Sl9wj+cBU=;
 b=Q628SxOrH8MChddz5ymnwuai0PIrhy2YtTH8WykBDQdpQfP1pcXfbHJV6mI4FubkZPq3JoJBuKuojmo/2Z/YWb33qFGJoF8A08npfnEyqATcRbwtwPmd78Cu4sZq7SfgUnNPAnWen+nhAAUx7xQJ0EKfcKKdjk+rP14+4hFx/i978xocFHfyoQrv9jhm8VhS4h99lZajFIZb8sY7qMEddXAC51G7QN69ynqgZ1I2VUiRw7RWUJ+3PbW2xaw4MnSS6FIUpSVyboR8FIux9mCJ6p4+EoMhqAXiW8Qadob3nxlGdinAe6CJF3pXv2C2kSBWfU3E2sbpeihjcPXgqj1J+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:08:37 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:08:37 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data download from file
Date: Tue, 18 Mar 2025 13:07:39 +0800
Message-Id: <20250318050739.2239376-3-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::12) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|AS8PR04MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: cfec5761-00e5-4976-e637-08dd65daf0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HFx4RNI9Lbup5lHBbtXjZBd30saft0WZJeZPoOROmSC4J5EwOdOc2yr+XihR?=
 =?us-ascii?Q?WOqqAmEQ+Zg0JeBGmyyvQojGVlh4/isshCUjGtQyQs+BIS/xsfgJWQbbIPD5?=
 =?us-ascii?Q?x5r8/113FxSmZDXklEnPwLY8bqGIkBDl/Vgv6WTMPZTJxK1apt9E1YfYiB9N?=
 =?us-ascii?Q?la/p13kXp18oTFmKounUZ6pVyg4nS3WjlQfUfKKHTA5JrNG7IhQ8jm/0ITxk?=
 =?us-ascii?Q?ry/Wr3iFHzX+UdjtuzwrjaCsdYXo1kpoiyyBHQD788UB52DHHoGnjN2L6iP6?=
 =?us-ascii?Q?XkHNFYgUBGsp7nMu7n141rHbEfGIwNP8UuI4gHbwJ5q9RjJqgVNg7tkCszU7?=
 =?us-ascii?Q?MphVx28wKOA8mTv4UsTEjtTBoAwt8oWJ089p84yoc5oPNaExcvz4AcwowgSn?=
 =?us-ascii?Q?Paa7uWMBnLjtCCg8nIGSf/GSfduCD3ftxjp2UK/xC4+FEVixEVwnUbAKxN9s?=
 =?us-ascii?Q?62FU2wPOubFUh6ex/r5o+AycRd+cMmdY13GMNKmOFMLcXSAD1fclRYltSXFd?=
 =?us-ascii?Q?9KviIwLlA6NJ1fJTOwbt7eeT2FdlmBaXyU0UBavt0FeguVt4vB3gh0WN+HT2?=
 =?us-ascii?Q?YapPqXlXOt3K3bed/kjP/aeBiUYG8gTBA3P63APl4jjXVzFVUBiuQE3/VIsr?=
 =?us-ascii?Q?yHoG7uzqUqmkCq7FE8Ke1aurHq/t+ceCQ4r3oFv75H03d668KFD2w4gvHaF1?=
 =?us-ascii?Q?Fxqw+YmI7NeqIplPAgwf6LMpzmX0+9aIARF88+Fif6MFO+L55WY1uAS30EOH?=
 =?us-ascii?Q?QWZbFt010l2RAw671Ty/zPM08xx/CsITjjUaXt+ShLYMw67GpOMlRRYB0+e+?=
 =?us-ascii?Q?LCZhBd9SRByNsXj6A/Rt/BA4QlR+9rVs7rOzzfj2hVq9uLY407h1Lcq5ghV4?=
 =?us-ascii?Q?TwpE5JSd9JPTId1JxeyfpSUK4MwIJNFY7fYWxVDmfrV2T6SLMeryTLcP0WIO?=
 =?us-ascii?Q?MedbZIi7znZ6dm/PVHeF0CtD3jWMVZUgIJqZe0u0Sps4ubIWxtP1eOslDYbk?=
 =?us-ascii?Q?/HMNzIfCeDOLAwK7s9MeLKMQM+UOhGEBQiz82bYyxSPMXVyHYhsqYRF8JtZY?=
 =?us-ascii?Q?fZS6v7f7WRQI2IFBpwoUK+mXFJG0jujt0lhl9WPqSh9AzEzODZnacKvHKcZQ?=
 =?us-ascii?Q?5/2t9dVxKDL2/5O2SxM7EkAGJNru9eVJhOo2rlFhHHqw5PlFBn8/xfyO6o2N?=
 =?us-ascii?Q?QDnhVyobNrMA83OdFiRelVyADmA+j2qcnVIpaOMDH/GlTZ9Vhn66F0BA9Yuk?=
 =?us-ascii?Q?vQ7qVjX6NL77uRDfo5a6Sr9d3/G2oM3oKVQu8xuFx9pZR1f2M5z6ihKGZoXq?=
 =?us-ascii?Q?RMkIhgCkEngoARnAPtU0go7xnW4eQ4zsljW4WsLtjFxlQRK4f4Hy9R2UOtSN?=
 =?us-ascii?Q?rsej2rK0FPxYFbL+ajpv9ZKV7bHMh9v2SAHAQYkWEHP61RyMz/IbQtSPQ8f5?=
 =?us-ascii?Q?se4+sa7MJobIQnBmllWLeQwFNNNasp5m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xFEJAuTrXbf6eRedLlhKaPN8zsT9EgLuLmhqYGM0P9TFUWdqtSQjjrY/DQen?=
 =?us-ascii?Q?Vs35CQ5io/1FeF/mHAYc5rNdgzWZ7tnVoRxbtkD2KsOp6gXMv1URBi9gxSeM?=
 =?us-ascii?Q?gMmLWWQe8zn0UBL2hJz4ogkatPm3mN/MudsT2pzfMAPiM+22wVXuTyiMwBI8?=
 =?us-ascii?Q?YwoRXqimO3YBXGvh0h+xJNVRq42tUI7rlBw1acpoi0kb5H1OmAmB0W/cFTN/?=
 =?us-ascii?Q?GOBkaFStW8BsW+DThMORj6j8RpgBrDby3YtQZ+nrX+gVKDg07qZLoMFSh5PU?=
 =?us-ascii?Q?Ymqtj4waec5lYv2S5N7MyvoOCqDsi5wIpBXbwEbMUXaCRtlLocAG1imWEZbi?=
 =?us-ascii?Q?7KQFNAW00eDUoIfSJQhrSfZsWRc5yGWFaJW9Nt4JqfKJymHLtbCjWbi9TWHd?=
 =?us-ascii?Q?ToRNCW5IxLDX2CnZnU3/gmHsj3Vjd+NgfEC8XTehUeM76alWJysMrMiBnftq?=
 =?us-ascii?Q?fPBQZHuIVH38epDGrTzaI+zR5iZV9Qd67ka8WfWgx+Ru4DFK3xQMaS1Sur3p?=
 =?us-ascii?Q?IzhiWpxBqU1w0n+Agz+UIVPqF8Z7uLGSxMoa6UqtpxHCpjC4OO5cHUqfwy5h?=
 =?us-ascii?Q?4azIguNjTGXur1WvauvjkeYCKhEux2/oNV6nLXcWoqpRs2vzxBAnluuWuhBe?=
 =?us-ascii?Q?vP1k4a1EN+ZkOhRYkOwn/BWulVY3YXCLCf47kQ+MphRrRlL2P1ukUV/RwcC/?=
 =?us-ascii?Q?SOGWSC0Oyo7xI5jMzT1NQiYlPaWXg5t+X1/riWRB+/4TFgxznzuMgyFHQmdN?=
 =?us-ascii?Q?npJ/7o+VIye2EvUeKtKpl98cQGgqAfXxZXUDhg17IiYbdSUJMFDJqW1F1YRw?=
 =?us-ascii?Q?B7fie9iS+yr02gHY87oKBiLmHROXr1HxbuxBtlN64kWF8ltGii2Iz5xq971F?=
 =?us-ascii?Q?MErWPeha2Wa304QZX1p2Zv6RFPASKsDXIyb+3VAlzjyvlYYL4s0LlvnRt187?=
 =?us-ascii?Q?8lshtld3ak4UVpCKtAOlzX5yxQ+u1ZbLkBruTIp74eyq/n46BO6ZFwTDsfgc?=
 =?us-ascii?Q?AYgDAUYb9AkxFcxufOrMXddMWFjc0Hcl6mBGk+J6qMjnLJ9eDG7SNc4OJuzq?=
 =?us-ascii?Q?nwQGIpQY6iemyNBClZHxX9OL24htrcRVKGM5dja+C1uZmcm817fTLkL0vJik?=
 =?us-ascii?Q?NFeZkf+tFghIg3BufBVL0aw+SWMut22RLTfHDDu3KkDRmdc7KngyDhqWvfLp?=
 =?us-ascii?Q?UsAHtUzwozM5DSaW324Ny6COqWKHKLTc5PDX9bF5d0Uphi7pK3MyJi8KLsYg?=
 =?us-ascii?Q?uQXEVbiGmr48dGJz6iX3kLJ2JepNYVRWrJqZN8Il2yg5oYULvEBqO04pxykC?=
 =?us-ascii?Q?RU9UIM1CYK1Xq2zDdkvSoYID0th489Bc2oxvVANg0AgUAn/3haUPu4AxexCq?=
 =?us-ascii?Q?yHyT6oD4jWjkAwHqK4bTl+5B5Xgwyqxem8qpKeL8mM/0Y21oQECTrgLfW7NY?=
 =?us-ascii?Q?A8MToKiEwNp2XVQDV3I2E7PvAd0fRc3fmJpJRlY4LvrB+33ij2kP4hjPbXHO?=
 =?us-ascii?Q?cuacEin1HsRVQeC0KHiK3QF3bSHpnyPaIq5pubiDSvaxB2o7lY1Z5zJV4icW?=
 =?us-ascii?Q?O2LpSocz4X9gK78eIRAlh1a2d1pz+UqEncNShWgw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfec5761-00e5-4976-e637-08dd65daf0e4
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:08:37.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Yv+H++AyLEyUdZEhTZ37AmPfvh2824QVdhwD6Z6kzgrNJknROUgy1yyltdlBUBVln8d7MLiD7VWIKP4IUKNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

This patch resolves an issue where RF calibration data from a
file could not be downloaded to the firmware. The feature to
download calibration data from a file was broken by the commit:
d39fbc88956e.

The issue arose because the function `mwifiex_cmd_cfg_data()`
was modified in a way that prevented proper handling of
file-based calibration data. While this patch restores the ability
to download RF calibration data from a file, it may inadvertently
break the feature to download calibration data from the device
tree. This is because the function `mwifiex_dnld_dt_cfgdata()`,
which also relies on `mwifiex_cmd_cfg_data()`, is still used for
device tree-based calibration data downloads.

Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/fw.h      | 14 ++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 11 +++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 4a96281792cc..91458f3bd14a 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -454,6 +454,11 @@ enum mwifiex_channel_flags {
 #define HostCmd_RET_BIT                       0x8000
 #define HostCmd_ACT_GEN_GET                   0x0000
 #define HostCmd_ACT_GEN_SET                   0x0001
+#define HOST_CMD_ACT_GEN_SET                  0x0001
+/* Add this non-CamelCase-style macro to comply with checkpatch requirements.
+ *  This macro will eventually replace all existing CamelCase-style macros in
+ *  the future for consistency.
+ */
 #define HostCmd_ACT_GEN_REMOVE                0x0004
 #define HostCmd_ACT_BITWISE_SET               0x0002
 #define HostCmd_ACT_BITWISE_CLR               0x0003
@@ -2352,6 +2357,14 @@ struct host_cmd_ds_add_station {
 	u8 tlv[];
 } __packed;
 
+#define MWIFIEX_CFG_TYPE_CAL 0x2
+
+struct host_cmd_ds_802_11_cfg_data {
+	__le16 action;
+	__le16 type;
+	__le16 data_len;
+} __packed;
+
 struct host_cmd_ds_command {
 	__le16 command;
 	__le16 size;
@@ -2431,6 +2444,7 @@ struct host_cmd_ds_command {
 		struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
 		struct host_cmd_ds_sta_configure sta_cfg;
 		struct host_cmd_ds_add_station sta_info;
+		struct host_cmd_ds_802_11_cfg_data cfg_data;
 	} params;
 } __packed;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index c0e6ce1a82fe..52678e213050 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1507,6 +1507,7 @@ static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
 	u32 len;
 	u8 *data = (u8 *)cmd + S_DS_GEN;
 	int ret;
+	struct host_cmd_ds_802_11_cfg_data *pcfg_data;
 
 	if (prop) {
 		len = prop->length;
@@ -1514,12 +1515,19 @@ static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
 						data, len);
 		if (ret)
 			return ret;
+
+		cmd->size = cpu_to_le16(S_DS_GEN + len);
 		mwifiex_dbg(adapter, INFO,
 			    "download cfg_data from device tree: %s\n",
 			    prop->name);
 	} else if (adapter->cal_data->data && adapter->cal_data->size > 0) {
 		len = mwifiex_parse_cal_cfg((u8 *)adapter->cal_data->data,
-					    adapter->cal_data->size, data);
+					    adapter->cal_data->size, data + sizeof(*pcfg_data));
+		pcfg_data = &cmd->params.cfg_data;
+		pcfg_data->action = cpu_to_le16(HOST_CMD_ACT_GEN_SET);
+		pcfg_data->type = cpu_to_le16(MWIFIEX_CFG_TYPE_CAL);
+		pcfg_data->data_len = cpu_to_le16(len);
+		cmd->size = cpu_to_le16(S_DS_GEN + sizeof(*pcfg_data) + len);
 		mwifiex_dbg(adapter, INFO,
 			    "download cfg_data from config file\n");
 	} else {
@@ -1527,7 +1535,6 @@ static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
 	}
 
 	cmd->command = cpu_to_le16(HostCmd_CMD_CFG_DATA);
-	cmd->size = cpu_to_le16(S_DS_GEN + len);
 
 	return 0;
 }
-- 
2.34.1


