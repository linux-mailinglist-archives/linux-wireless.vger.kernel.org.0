Return-Path: <linux-wireless+bounces-25013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2CCAFDD6F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77071C24F27
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16151A8F97;
	Wed,  9 Jul 2025 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TJiZk/V1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012010.outbound.protection.outlook.com [52.101.126.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096519E806;
	Wed,  9 Jul 2025 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027847; cv=fail; b=GOxtcOTiuu13FzMxbBBbGXuBKMoFCIq8/sviBUoGZ00KDWIArOnpPRJzyvnWUY06SSJbFZ8EOwXuqSARY4nD+i6rhSaFftK5dJ0R0mzQ1BK2+od5YAXyW+efxSRFL/RdsfBxFMUBwTpCCaox9XMQqPgYAAa6FGad5ukZpkpdjeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027847; c=relaxed/simple;
	bh=LhjJEL3jzZnXNpu23ich/72gc2eILfgqPurkTAj4OSM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGIgBZ1w5mkVVbTCF1zOaKgpKPCL6qzgWNK0pcCIWyNAghrtQHMZdKo6yFnBW5Uhrz0W0jR8/2losJQ25YWJ3SXSwUAmEqQlS59n+eyzmouxQsnbNlgVeJM1fJBX9J2JMyurRlnCRlM0JuFIubybY0R+gZFrznzwUTZezH+3f9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TJiZk/V1; arc=fail smtp.client-ip=52.101.126.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjigbhmqWdgJa4Cj17Qy/jDrW2RChN++U0PVv/bNpDF9SKkos7PEA+4lAHjjwmp1MMlakYRkpPcSP1rpdpqmXW4/KezFkuEWsiyLCMLgQ2u+3GDAbCYdIBGPnpCkBZmmhzro+OcWKCB+fYFfWCn9gh1uy5LIdXBDW26vBLkPadahPrdpA8yEg/K9t4B9I7t9Ez9B6fXr9EwVh0j0MDKkkNl4oNkY/Ww3+SPJf1Z/bdj4TWw++fEi04mS6q6NouYBx0dFv9izjPS84kukd6oyGrWaOmY6tlhv8GlvJrddQGaLNH7UGzcRDifotY24KdDoNdR6nOvPxH8dYzyLyEKCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHwTIyX6Thb01MtKX3qFkV3lGi3dJzh//1qkDeftCGw=;
 b=J8aodJPCo3ZmyFK95+HTLQmhx3Fl9TmaYFG1y34BIqtF45EusylBd3m5brXWl7J0aFzZgdgH8e22lqfXCxiBBdGtUL4U35zb9sId1tD3HBqJjJU2Lg5GMyLGf41GApJ4qz10NKp2NZ6KJbTxRBjvnCcj3lr8UhHhl9owM793cEeSSuB758H2QcfX2SlAz/GjNJXG7WjiJYOLDOvCvEtquNN9jmHXIH4RZEVFQdtik4EzoEPYA7XZcysuPE5v4NK7KCuy2wk2TQnAhcyTZUeyNMuHIkdwzfnkKlCqMUG1FfoeOTtUyEFrDZPTHUZYRA5VW3G2oYodYDiwChg1v4+6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHwTIyX6Thb01MtKX3qFkV3lGi3dJzh//1qkDeftCGw=;
 b=TJiZk/V1otUJJDdoWbGBBfY+FL6kCZIx8WAxqbK4ovzLP7LcBTnX8i1f6ynMzJlgOeQ5Gxrv4Far/mC3DwuYrDudsillyyVl7b6dr1nPv4Kh0RnXWK5y2cUJ3CTEudb0pZKN4mjxzruCRCGqNoTpnxEfTY3YfnE9K6eb38/yo32DAk7OD+K7R5H3Brb730kyVWwfNi8Qz9aeIBAam8QKXu0LpXN1g0oBzNNDbE2NjDAMPkA98ZSOspIcYISV7oDQz9/WLCcOXmYzkf6Ax4wi1s9To2XKDO/XPzwGdQ8uK9X3ggK2bzVjrLXlfFnQY6icoGuaS0IpfWGuAveenLQNVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:24:02 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:24:02 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-wireless@vger.kernel.org (open list:MARVELL MWIFIEX WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/12] wifi: mwifiex: Use max() to improve code
Date: Wed,  9 Jul 2025 10:21:38 +0800
Message-Id: <20250709022210.304030-11-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 936c4c0a-86bd-4c2b-7380-08ddbe8fab2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9dj0r5GQsvSL3awdeu4e0ba4kWXOWHpP3JyOLZg/IcZF2wtryUMNUXvgqcwF?=
 =?us-ascii?Q?WZVwyeOXIptsouJvyyoY5JwjBhlurVcQKYw6pXSUrPSG8LSmPsuZEsOa2ztC?=
 =?us-ascii?Q?V5k9jMWEnjnim5RqygwvktkMaHmEvgk2B1N2A/3vtcYb4blUrf4Cry2AfwSZ?=
 =?us-ascii?Q?nM/nrsXWKS2GHMtWlS3XY6fIxM9a5PzsiOmjgbNA19r43cJbCpZ2Ypk/G4Aq?=
 =?us-ascii?Q?HCHsvYczHbtgjdAegGNcTKRy4FMtHiAlndAx7M7/hkGgRF2gmKj00Cm5j/Wo?=
 =?us-ascii?Q?eAsXiln4bYvZ9iU4n9RWd4KQbL/h5CFcsha1NcumZk9i8oPjy/LnuuwneDQp?=
 =?us-ascii?Q?fgndye5AhJIszPu6QHt0trU4jL4jm6BpSuTNUxu8o8EpAf5C4Ts5LTTPFRLG?=
 =?us-ascii?Q?ULt+XAQrVBKJhO9gPoHJ9yTgGDELtzrlU6l6tt/ts55GxSu8pqsc5erBW+84?=
 =?us-ascii?Q?eSD2+zHzp2CtSXpn2TAgPI9wXphWBaaktFNH8fg0kjNOMAibVH90x8boEqlz?=
 =?us-ascii?Q?0MNQ73alB8RvlCyiL0/Y6/36PSIFRm3nJ23o12YOozCEMvl5bEBgnQ6oE9kN?=
 =?us-ascii?Q?d9hG5LgvTg0YrPMi6Rg1B1hYtpLPWFGWtXhwGqpiQFastBU83BtREs3zhpYD?=
 =?us-ascii?Q?hSwXcSWGExvHRg/kjNxVC360t2hbWi88GvDg76PM2yMgr/Y37ccxQeooxWf6?=
 =?us-ascii?Q?g8SxfHkZlZtOXs//WjBjI8Z6A/G069Pp1ombUSfdQncrQvGkBvcdi+fOqhbt?=
 =?us-ascii?Q?YzpYSCf4mP3Ar22o4ZBaxJL0uvqzPS2ntf9PPvZb0TpjGx5Gr4QLQjjQxykb?=
 =?us-ascii?Q?hjYCC4/BStHCBLJR5BJCBfwxJPJmp0mxmGyqsh1p+xVjjYsJj/whiBTN7awL?=
 =?us-ascii?Q?QIpX7YOd5v6jALdoE4B5T02PB0CeTZtBi0zxYd4BzWOB3dpIdV+DKPpBpuq0?=
 =?us-ascii?Q?KYgmnOmkVqzNOF5zXXNGWbjwPzE2LRlnbogCaCFyxDVo7J9AHn8mA2BycUVd?=
 =?us-ascii?Q?NaYC6SEfBsaFvccnvZPQEgxlerNzUhNXcaxqrkCDpSlkKR1u8mDkwNbFlwFo?=
 =?us-ascii?Q?p4l6PBgWp7QfhDybUcOLsO7tADbbxQRVJLVA57w/LxDCe+PqbbOexrJ2Yqwl?=
 =?us-ascii?Q?DIM+1BsJTdXdxnWLITk95AsfwatMvwmhsbmC6VZASv4Ucox2ScrFDibgQ7w2?=
 =?us-ascii?Q?OFaysNOY7g9cyt5Gj5xlwIYa1vk73Vqu8bxiwdslZIynFdWYgc1D9F9CPHqI?=
 =?us-ascii?Q?/rbt1KexnKYUmiBrBO0CfAxHiupQDGRsAD63JB53SPdz+k+f54aMWIWuPAB/?=
 =?us-ascii?Q?9jCbi8f+xEacWV+UIIrjLHVb7UDaAmxvCtZg9hLoG+QbthoOfyv+6OS5j0Po?=
 =?us-ascii?Q?pc9yfeeyZ2qCLqw+YzkiqM267vIOYa+HHaDbnyjf9wX7wW/1idje52evi4v+?=
 =?us-ascii?Q?Hr46T+JQGEYaIBKZ/W3ubVi5SePJdehU+zlqiK7nLjoPiRg60PpUc1QL0LGY?=
 =?us-ascii?Q?BlvPJ0n9YTtSoII=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aruWCAySiAnyLRluQoV4Ui1ihIbamTfTYxS33H/Ysn+Uyqukm9ivn4TXsmta?=
 =?us-ascii?Q?H9FAY1LwiRV07B7Dr2XtD+tE6FTN6cQtU3T2RetmLebBroBgPH9PlT4yFBa3?=
 =?us-ascii?Q?OW302m+cUvtM7Ws94KQytjwnJXuWMNw9eQPfkjDCYKKmcpZSCJ2c9z8Mz+He?=
 =?us-ascii?Q?1+CwksuJmMHCoHgM2EArHNsdkMd+L+stdYx372k7kkwfy5aAqJeXNK05aPrm?=
 =?us-ascii?Q?IOWCfM/OMeCbTfOW8m3Y4a2v1hOMICwTj0lQc3gzHPDi6kyePkXo2w4lrmU5?=
 =?us-ascii?Q?7+txynKF0yYMkFJcCmcAxjcImsCc7W7zDzYqmEnMVxFMlZroiOUynstNcf1Q?=
 =?us-ascii?Q?1wmrQoUtwLcIFdxq2B6b5yieEgIwQasr093xGMgVlM3DSrZT8A8Q5dQHWZdL?=
 =?us-ascii?Q?rJHqxYYqcAzta18ncFdR0k/Fg3lC0eeUCeQ3FyIvIli4R+Lo3JymNbDL7bhS?=
 =?us-ascii?Q?GI22bnpG6hheUyzohgmwHI0NrUgWTx8CgpTpU226buh/4TrWCR0JgbRef3cl?=
 =?us-ascii?Q?EWnBVdhD7kR6KsaBSNnjNC8LqEzI3eVo55rH+hQbypWSM5IUCKb8innfUxui?=
 =?us-ascii?Q?+u/a29aYYXNf5IVQ9mItRJ9FWsF7YEmtU48Nl4L4RccLvow4bTM57vDcdmWp?=
 =?us-ascii?Q?I4zFfUd3JGPHOCf1ZKenvnd1Ijp5og8UsfGnY4rdJHcAnPJ0L365adwTYFt3?=
 =?us-ascii?Q?wAqbI9oRpsDwhqbVWalx4JyvJ06hFNKu5YNaAQqG7owQ3AQCh8amCUPCDBLX?=
 =?us-ascii?Q?jM2WQKiQ8cdF7QSSohpFG4VchvVAY7u/b54x8eJlsXUswnCmIh3q/y+eX9lZ?=
 =?us-ascii?Q?e80HoVxObcWunHjv8VVHMTXGrMBh7tpbHyw0jshDJewSp+LE35XbG3gayGhn?=
 =?us-ascii?Q?7myS7Xkdlcg5a884c1rlJKraEgtq5zfRKqALI2fHWqgbzU14yHITBOOcNvQa?=
 =?us-ascii?Q?aCZh96lMruszXk8KC0Xk0x3Y1S/dB/F9AvnSK/REyPSrWAaBtLIciBnLTr6g?=
 =?us-ascii?Q?H/0fCZOEJZuRWMO5ce2TFBZib+PPmArbZUMyOq4vrx4S2+NyYHxZC4adZ8a3?=
 =?us-ascii?Q?Lk+w6EuYRwMIcnUYLKUQTcQLjCuKkMxde3eliDckfiZxpHwEnLp5Wk6LNKsi?=
 =?us-ascii?Q?tFnkP5K+VXwKYhnXEx1fcFDP5myx+T/8wtztE9cuLhewm8sIIBWdsb2Zb2P8?=
 =?us-ascii?Q?c9nttSjpm3uMtaehnGQlW/pjeaAN0fNiwU3GbxI4NDk8EYJ4y69TeKtTb7vl?=
 =?us-ascii?Q?y0tKfMDMYUECGXq8IJoY82dgFwcMVxAkMczoySUzWZHdKUn+Z+jtncMU0A2X?=
 =?us-ascii?Q?gw4EY/zGbco0LiuM82Eixxa+e/lmYSemrWFn0ChoBEp6NQCmnsqEmhWKAGjz?=
 =?us-ascii?Q?KuCFSzGMwLh2wi2pvcYwVPe8VfU9bhdcqC/E29cmDzkRh2SFVZy6UjMVQUE+?=
 =?us-ascii?Q?lR9fQmDejtMe+0jEz6Yv6noogfnPF7aTmtfWh4DsWZGkIRkdS/itoLPncBuv?=
 =?us-ascii?Q?n22QoqVm4f5IG+neXsgapqgsk5JD/NNPOQfD3+Oilvait6RINr9e8ZJANWgs?=
 =?us-ascii?Q?VXi8CKydXrjdQmhc1/YkLLOl/TnshSaoev6DCt1+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936c4c0a-86bd-4c2b-7380-08ddbe8fab2e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:24:02.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ysTHRVe9fpbmHZYJiCDHFDZoKBuKHsEb4oHWrVGy7Q4BpXM8RuHJbF6bz8agCdnAs9RsYeGFiZdwRSZg3Rvrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use max() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 286378770e9e..d81db73ac77f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4783,10 +4783,8 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 		wiphy->iface_combinations = &mwifiex_iface_comb_ap_sta;
 	wiphy->n_iface_combinations = 1;
 
-	if (adapter->max_sta_conn > adapter->max_p2p_conn)
-		wiphy->max_ap_assoc_sta = adapter->max_sta_conn;
-	else
-		wiphy->max_ap_assoc_sta = adapter->max_p2p_conn;
+	wiphy->max_ap_assoc_sta = max(adapter->max_sta_conn,
+				      adapter->max_p2p_conn);
 
 	/* Initialize cipher suits */
 	wiphy->cipher_suites = mwifiex_cipher_suites;
-- 
2.34.1


