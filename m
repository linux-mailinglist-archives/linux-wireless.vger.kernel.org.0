Return-Path: <linux-wireless+bounces-25473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2CB059D9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA726741D6D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24D2DE700;
	Tue, 15 Jul 2025 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WNfgnKhD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A772CCC5;
	Tue, 15 Jul 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581920; cv=fail; b=WFx8mZsXJt1cQnJFL+16tOHK8TJCi3BBESdp+aSifEhH+KlcRkmOYmDJXwldjrkezqgFutfnxKJfiAyhDBvM9J0BvrJWIvovGG3FbCL02jmyvEB1gih31e2PbMG7KoUxgqn6G1uyFLp5gHs+LHmcdOpVQylZ807oADUX1OhcBaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581920; c=relaxed/simple;
	bh=Vprd88rDnwOu9qwNr6dNYzeCFVrA75m/Pl6juAC78yM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vixzh4DRcQF1DrV0sI1qVstk8ikPnGdGW0I2N+FJ24K3q2QxyvZxEf05UbmmkBd8ePy9Q/7AWPAT26ifJDDRdbQ1HNvzgHdrds7kxVm1fY/BesUf4T3gOvQ5pDxgnX1qK0dKBtmUky2KJjIVUNt1F4sOl3YLyp40puJukULdcfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WNfgnKhD; arc=fail smtp.client-ip=52.101.126.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2NmtJXtIsNc4jCiEd0/vrjaNFnN8Vj5jahCuLA9LdK7Z3OaRh1hy4NVf2ITYXZULNMfTJaeODl99kM1yZ47QQATWflNFsz0c8G41CBl0GZTQjWzkF7Zuho7QCDAA6JeZ1HdcH4CogSbVXbF8zE+QVh1Z97X6Q0dB6Ep98PxwSSNfan2chWirzW2ohjrKBCkUpV/afuDiA6bqI1V9vaJQKYMemfSZbQTHmNueSVhZpf4fkHInoxscpncfospaZyVfhESWQ5geWkNNS6tthFfCOpq3aT/0oPwgTPUxtRUZvvqf7LkD+4bq10FB6JGkMncCzN99ZwdNF288jVZEwlzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrbNFdpu+ggr0nErNlkjoT/55vhjOofJSKTcf/QocxQ=;
 b=wW3i2FuvEjd5bAlgWWZKy1Z3WToK2U1xReYIWipGlw/9oggoirJ2bGVWXYzzUg23jHzN5/zNdDAQuXF2rXyHJ6yq6HPJCrpqkHGksu4dxhJfJn3LhhuPyCEGV0BowEZqMYjTl6zo0RiLYnkKj/3hTizLq2vABvNArMW/iRKCMF3Hz9PUN/3PMio51h1T1SdhtLASt+w96/HLnnyyzFAuuPwJkoE2WOK2Ifgwq/pnngj8YkOulLyOJxKJtuWw3Xw6DYAJnN0lv8M8qT3t+P10UJU5lfkEV0VJ2Z3COpoTPWwzUI9mYbP9DqQgXAMsF8i6zUIb+B89d+XNsAukl1L3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrbNFdpu+ggr0nErNlkjoT/55vhjOofJSKTcf/QocxQ=;
 b=WNfgnKhDumYPEaq01utkD9LhAxwSPMtrBSTRB03AYBRl27lD5+chwg222olC4nycy8SH0RifRX/8jc0vT0DOdXMUVE7QwuR5IkpGEd9v2i8DD/IJTcg5KjJIaeNfKXIyySfl6kfE0inR/S2Orwn8hEZ8D7foEA1RI/YhpWOGJ0S5JRT1f9TRQcHznfn6yMq5Ro2+KtH4ZCbqwDooV/8UC8tkcCgozYFRvng9OgFLtaQZ3Ki1jImbRXXirJJAip7pKiXKO0GxkMzox522ADNzbvhRvRrTbKs4NSenbzbwdoVn74O2vSBbw/ZDWD4j7dAfAeEkEFb2bhJ9ztJeMfqRNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:18:35 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:18:35 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtlwifi family)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/7] wifi: rtlwifi: Use min()/max() to improve code
Date: Tue, 15 Jul 2025 20:16:53 +0800
Message-Id: <20250715121721.266713-8-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715121721.266713-1-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e54a5fb-3471-40c3-54d9-08ddc399b8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hRVow4Q24SflF8qMiZ7fQMZwsDEpJb62hgXRYV4RtQxcX1OlHF6830QT3Cnx?=
 =?us-ascii?Q?WWsSeHanuZKPgmC6oW1CS/4uFvwrom5LV+rymRv2tHlnYUxVL/30P2Ue4WV/?=
 =?us-ascii?Q?5Tb3UZ8fONfYQausXIdmN+Wrg/2M0YFD40o8BQFcmlluXublJGE+IqWFerMi?=
 =?us-ascii?Q?/FG0/eTsfOaS+4E6MbsC+KoZK2dFyiBI6fDquOgJFMh+Lk2tCV9+1pL7MVnl?=
 =?us-ascii?Q?60KG3SUpwtxmNyhG1THK+TA4yZRm+anTyfUreznTMws+NtakXOwWOKcrf48W?=
 =?us-ascii?Q?9CIFIlh68H8LfEE7rypB8IwZbp+znzijqBho7B5Kw3tyM3jfn/9YpjBPKWqO?=
 =?us-ascii?Q?odYFWTbwqYHoP4Db0dP16O6qOdmJNFkqHqLiIjhTflLsdahDZyjRQOWFtTv+?=
 =?us-ascii?Q?0ZLH1SGnfQhwW50FNY2o6cNVw552EqAw7eQYkRTs1Od5t3WLwEEo9mk5f3Nm?=
 =?us-ascii?Q?lmdTO2T1e9DdyFCnQR6dfc+1CYIFHMRYM/fpnfWUCJr1gykrVITGlI/XBPk0?=
 =?us-ascii?Q?UjNJS02YJfD2fdH0Ve6c+6b3r5lc789m8lMBkhTCfGAmZJbVdV2jueEkKCzz?=
 =?us-ascii?Q?zUJHgvRbdBeeaUMYiMKSCNla2TIRuQGjQMtZ8wlmixZIx+afDIUmFlyaxHO/?=
 =?us-ascii?Q?zs3I8DR4qFXOizRB0y4otVLNCz8bpznRPEa1yzkTI/348ViGHlKfkeR/0gGR?=
 =?us-ascii?Q?HsBUFpjKbmHBK2hUFVjIoY5VonuF2gMGFGeiM62DBQCX1z+lvlJnOgTmlccK?=
 =?us-ascii?Q?BKjNLtLEg6NRPidqXys1HYARGUBSALeWYi2AazgO+a5kste8kWZFXdtBNoQG?=
 =?us-ascii?Q?usuJgxOrEYwwAmD3OJH2tBL4yTsKJaX9S8wq3WGdhhtl7jjBQgTbE93FGKXD?=
 =?us-ascii?Q?u9YyGfTMkBTaFDvzwe6JByGAvCY03k2diiL1RAT4Ugq7oBAc+wIz3H27CxUr?=
 =?us-ascii?Q?+vRp/PPTk6eBpuhgfxo5H9KEnMvC8cEE859abXDeUPGRZ4M6IFnAZqnKR5a8?=
 =?us-ascii?Q?MSPFDtI2evlBANXwdlBEdMrJL5hn69xwEFqWZ0xnBnylJPp9Of57+e98/Yav?=
 =?us-ascii?Q?MGLptRmSE+euDrKOQgTiKIOhKGIDg/OXYjaivF4MOQd71Yg0LCQzLA9CI7B2?=
 =?us-ascii?Q?7+RRUoZOEoWu873+7/xIs4E7bFFVZU88ImZ9c9iTZXmTkyodkjFg7tK1fqNG?=
 =?us-ascii?Q?nqnqzsBuoyAxZnWVgbPMO0UGOH9BtIO/1fISxcIYkft5Hb8rlMnJ3QxPiTkQ?=
 =?us-ascii?Q?ONZcoXYU+COB0jVN33TeUu4EbQEaapkKUXc3qhM5ii9Hn6v5jEiAT2qnBuf3?=
 =?us-ascii?Q?yeeDAtiX7ENKpYFgl/Gk9VJGqCO3Yv78fcvbsrGmSoAapZz9jWcO0AioQ3kh?=
 =?us-ascii?Q?aJYsBD317ijCvRHJ30/vNShitISgMp88mDLSNFdq4duWLR4rlTxs7ExzGXzg?=
 =?us-ascii?Q?5bL4o0ivdpD8umtzIxYo9M4OLDv1i5zRqdd/UZ32lgm6et+j2G/pEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iKdQfDRF0SSQ+j55bCGsCqN/KxKnRCVpj77NWlGWuvu5+mTdqasdBMtN9ufo?=
 =?us-ascii?Q?hrRBiuY6ndUPr9oOj0u7A5B9hV58niHl9M7MfWym14uD9YcaG6eFPIBC0mC1?=
 =?us-ascii?Q?XCYDauvcWrqzwuv3GUXbywNrWHG5AYNWVbpERXMgE5Sr38MEIF8FfIjgudHQ?=
 =?us-ascii?Q?/zChwHD/ovqBp3alqUoO8+ekzPtFTt4xsr/xxVX3GKAr6LzWYYVrpcuzq4UB?=
 =?us-ascii?Q?dlCsdzVuYgC+81e9U1buGRQdl10yWUwRm4E/6sR1aNNdhEfqaz+jH1ivZybC?=
 =?us-ascii?Q?Zy058+EmxlroAPYUJfNM5yOQS2bnwDPaJbTqObXb0hdRz5i4pP0R8klD5uGQ?=
 =?us-ascii?Q?07LCElv9qET2VUUA7gxXXhdQvlk1CkJ8Pxrq9rVEHq6XfIew175NS/7rpWIE?=
 =?us-ascii?Q?GfWw00W2gQSU4GxAppLQZGbpt83rcpGAeK/Ae3ZN2QpeNEzNXPW6XsrrELHS?=
 =?us-ascii?Q?a8lfQk+2uKOhkz/un8t8kDbf0lrDJYdhpUgptoQ0kvMmTsAoVXjGu8bxKYrv?=
 =?us-ascii?Q?oCewt+LgTpcFEFMehyXm/DyXuuscVuuG/+fZZGoNkEZ6RT7PzpnfZ/zfhymu?=
 =?us-ascii?Q?n3IUv5YRMqonjhs6SByi2nyJoYXcrnhplXnpaWeM49hvPlRLTv4bdSTXcm4t?=
 =?us-ascii?Q?TItinD2BUAH+CsAqBSG27MBEUvg4fWOJmasCHY8m10g36Lg3CPbCmDVmRUnp?=
 =?us-ascii?Q?M/YsqT23mOwGldbOo0G9yeXZIk1HBw8tQexrNE3cVBjDwzqvLR5XC7d0R1RZ?=
 =?us-ascii?Q?Y4/iNmPkshVD3FM3nxLpmQJrcyjH+xAMKz5AjaiFeas4mKji0jPR4ED7zJob?=
 =?us-ascii?Q?AOFNRDg1jgsT7+1PyP12QvIRGe300FwURbckZ7+t2IaKJGVepZ1WnpEdet9m?=
 =?us-ascii?Q?/w4srJP9/7rbCfrji7HtiWB0CNaUAlYatNzTCSDn0JuzxTBcwu6/8RRuiRDS?=
 =?us-ascii?Q?z9vZnUq4cXl7hS7csrtDNZgcpvFb9dYgYYU9VXkWf6gGe0T7VMvGqM5z6wEY?=
 =?us-ascii?Q?yZt5EbtzFKYz2tAuvDrKF7K/bwKJ3jXad2LtXrH9CZpjQHk4yJJAqiF/OEwL?=
 =?us-ascii?Q?LbqlEuKFdHfOWbsBf9OTEif/wJEnywPdR5mh1YDXGbfFyv3IaMyUBhenaWaq?=
 =?us-ascii?Q?6JbSQC78zUSnpkCq4iQGs4CM9Ruq7m+CgKo8cuKoBw6uwkOz6gN1bY8F8/8E?=
 =?us-ascii?Q?qxDJCzlim7Asq/nSbWKF1Z+p5zrvkzXWSCYebRi3AXbwUkQ9UGV9dWvgNVab?=
 =?us-ascii?Q?5QxKf2eseE+KHj2xdg47QbXIEOdAFZwRzrrZCL7HBh83kXjYqbJ+fsjLKSEY?=
 =?us-ascii?Q?gZX7fdqF8s4hhqa67ofqg6AO44XHU037B5G/sxsOCgoCNb6w8jXuZdsixSln?=
 =?us-ascii?Q?bBVpJRyx6m2tghe1bmSOmz5vkOhbvypWpiL5zn74NdYo4BnCiuKE3JNouydw?=
 =?us-ascii?Q?fF7a72wCnb2rEK+bzx/xFeiFJGXaRp8RLIt3Ky73YvwEeJiod1cTWj8tt5YX?=
 =?us-ascii?Q?d66OnkMOJeFKtcXNYzuQXAVh3Ye7pRYd7Ir/yo6xBVAvbsGMcgBl2jRBT2a0?=
 =?us-ascii?Q?Hf4UB+zC1zO1FgXDPE6sgbuQIj7cbfLZNcxgVgpq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e54a5fb-3471-40c3-54d9-08ddc399b8b8
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:18:35.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uplGpPpjaX4mw5CRNhTKzqvH313btz09GgpivVtiXKVw5OVSaE3FyZV+pT3Wi/oj1wR9gjn9FEMZFVWt5xRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use min()/max() to reduce the code and improve its readability.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 19 +++----------------
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 17 +++--------------
 .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 15 +++------------
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |  5 +----
 6 files changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
index 5ca6b49e73c7..4354ae67a379 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
@@ -1487,22 +1487,9 @@ _rtl92ce_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
 			rtlefuse->txpwrlevel_ht40_1s[rf_path][i] =
 			    rtlefuse->
 			    eeprom_chnlarea_txpwr_ht40_1s[rf_path][index];
-
-			if ((rtlefuse->
-			     eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
-			     rtlefuse->
-			     eprom_chnl_txpwr_ht40_2sdf[rf_path][index])
-			    > 0) {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
-				    rtlefuse->
-				    eeprom_chnlarea_txpwr_ht40_1s[rf_path]
-				    [index] -
-				    rtlefuse->
-				    eprom_chnl_txpwr_ht40_2sdf[rf_path]
-				    [index];
-			} else {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] = 0;
-			}
+			rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
+				max(rtlefuse->eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
+				    rtlefuse->eprom_chnl_txpwr_ht40_2sdf[rf_path][index], 0);
 		}
 
 		for (i = 0; i < 14; i++) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index ec5d558609fe..989e7cff8e20 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -163,20 +163,9 @@ _rtl92cu_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
 			rtlefuse->txpwrlevel_ht40_1s[rf_path][i] =
 			    rtlefuse->
 			    eeprom_chnlarea_txpwr_ht40_1s[rf_path][index];
-			if ((rtlefuse->
-			     eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
-			     rtlefuse->
-			     eprom_chnl_txpwr_ht40_2sdf[rf_path][index])
-			    > 0) {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
-				    rtlefuse->
-				    eeprom_chnlarea_txpwr_ht40_1s[rf_path]
-				    [index] - rtlefuse->
-				    eprom_chnl_txpwr_ht40_2sdf[rf_path]
-				    [index];
-			} else {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] = 0;
-			}
+			rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
+				max(rtlefuse->eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
+				    rtlefuse->eprom_chnl_txpwr_ht40_2sdf[rf_path][index], 0);
 		}
 		for (i = 0; i < 14; i++) {
 			RTPRINT(rtlpriv, FINIT, INIT_TXPOWER,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index 17486e3f322c..0108850bb9e5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -223,10 +223,7 @@ static void rtl92ee_dm_dig(struct ieee80211_hw *hw)
 
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (bfirstconnect) {
-			if (dm_dig->rssi_val_min <= dig_maxofmin)
-				current_igi = dm_dig->rssi_val_min;
-			else
-				current_igi = dig_maxofmin;
+			current_igi = min(dm_dig->rssi_val_min, dig_maxofmin);
 
 			dm_dig->large_fa_hit = 0;
 		} else {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index 21b827f519b6..bd45d9bd40bb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -1449,18 +1449,9 @@ _rtl8723e_read_txpower_info_from_hwpg(struct ieee80211_hw *hw,
 				rtlefuse->eeprom_chnlarea_txpwr_ht40_1s
 					[rf_path][index];
 
-			if ((rtlefuse->eeprom_chnlarea_txpwr_ht40_1s
-					[rf_path][index] -
-			     rtlefuse->eprom_chnl_txpwr_ht40_2sdf
-					[rf_path][index]) > 0) {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
-				  rtlefuse->eeprom_chnlarea_txpwr_ht40_1s
-				  [rf_path][index] -
-				  rtlefuse->eprom_chnl_txpwr_ht40_2sdf
-				  [rf_path][index];
-			} else {
-				rtlefuse->txpwrlevel_ht40_2s[rf_path][i] = 0;
-			}
+			rtlefuse->txpwrlevel_ht40_2s[rf_path][i] =
+				max(rtlefuse->eeprom_chnlarea_txpwr_ht40_1s[rf_path][index] -
+				    rtlefuse->eprom_chnl_txpwr_ht40_2sdf[rf_path][index], 0);
 		}
 
 		for (i = 0; i < 14; i++) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
index c53f95144812..c65d14fb914f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
@@ -468,10 +468,7 @@ static void rtl8723be_dm_dig(struct ieee80211_hw *hw)
 
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (bfirstconnect) {
-			if (dm_digtable->rssi_val_min <= dig_maxofmin)
-				current_igi = dm_digtable->rssi_val_min;
-			else
-				current_igi = dig_maxofmin;
+			current_igi = min(dm_digtable->rssi_val_min, dig_maxofmin);
 
 			dm_digtable->large_fa_hit = 0;
 		} else {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index 76b5395539d0..f8b159c74658 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -756,10 +756,7 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
 			"DIG AfterLink\n");
 		if (first_connect) {
-			if (dm_digtable->rssi_val_min <= dig_max_of_min)
-				current_igi = dm_digtable->rssi_val_min;
-			else
-				current_igi = dig_max_of_min;
+			current_igi = min(dm_digtable->rssi_val_min, dig_max_of_min);
 			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
 				"First Connect\n");
 		} else {
-- 
2.34.1


