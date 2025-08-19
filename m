Return-Path: <linux-wireless+bounces-26459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1529B2C2CE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 14:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D131BA3366
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765DC217733;
	Tue, 19 Aug 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RCfORTzf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012036.outbound.protection.outlook.com [52.101.126.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204E3375D7;
	Tue, 19 Aug 2025 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605556; cv=fail; b=iv0vuzz695xNu+z9Dk72KRgx0MyfOb1z1QdUO8Nbo9gknxUEqLab7qpfurd7NJOfhVopvuXqmbpq26He6y0PJY6l8kPY4yQrT0ZUAlyCSwIGq5EJWl/i3KVJHmZywmj2/x/SSASoyhwBvtQcQ20Qz5viPGfvByKeCivm2wcdr2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605556; c=relaxed/simple;
	bh=MKNM1IuTkCKdOGZ4IuiKRxYbScug0Oiev/wwQlTJkvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhIV1Qlp19NlrhDP7Nchw4jmnyzjDhftvvZWBGtXkB7AGpMFIQFo0n9NFaVq6Ee3MFEot737xhbtfTTcG6F9kfec2mEDKhxKHyodUGV1O7QphjU9fIkLnI+p//cGPGlHrUPFxPf8/JpNWNLNF6UIO46sooJnbwZ+5aYBfME4rIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RCfORTzf; arc=fail smtp.client-ip=52.101.126.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu9TaL7vHR9xrGN/q2R+yJA4XebpHOJ1vFrwMVozi9y5ih4JUmCFgmWD15KRYpfPRsaaqgTL1UdFdD1h1/9Uy/zKFYj9E67swOsiqP0hDXBpchxCt6Bfbe1te7rBb9iUQ8N8as+AzTzi3zNLBe3IXhsY5QZG8hTh/1RtYjvefwEVzRh0NMPoekjhQIoWa+S2N8busMIp5HuXdCRGUcDIz9qITNz5e2m9Mg1wtLbwEWEV6yeBWyUIBT8b2D3X6IB66x4+fWTE//+yARoCQRZsK+SRjdFUx4E0rwgWoRgwbyc7m6ArTA5qP5gfssusVn5X9UlOCK48uEOLpaR8d1Kd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHrzpy4jB6ZSJV0IqReKR+TrEIZbQMpHdqBw/iBmUWs=;
 b=YLvLjzOMuLxDG0udCfhtGocmM2VNHb+Qf9NWFXH1iUFwC8PaCQ2BQfi9CPMn8JSwm+KfqeGhHKqKssTepdnUUP05OoY/oe0T7WXHxl+jKg2nxZO0IZw+o1h8bmH5TPMQayTwipBAUvp42GuB7MBjfYorDyAJhbHVe6zWUBq9LSeRsQKns4WK1fSjcmG2HMXvG05vbSET1ZVdvso1sUy5TsvqgPpjn5E/lTcIFU3P42UoICJBKUbQfaGxvXkDiecGTk8/s1HotcLAWQJ8+YOA+IdFqjUyKDDdkLpv+ra8psYYFpmhFn35QaKq7w26QECwgKrcznfluT+vym3pfWEISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHrzpy4jB6ZSJV0IqReKR+TrEIZbQMpHdqBw/iBmUWs=;
 b=RCfORTzf8xAAE3lTqUxlSa3Wmw/BHAxuuNNMpw5YNmFf2fEIsWjzIaZc/75UvyKIhndrJIsmd8oZwZAdee/iSX0EPZZvRmAL88JBpQ/NlF18E6A+XzlD0iARECSezkkl5uTOtixaMTan4XjaUSnE977QVMpSs/4yS5hGHZMCFlTCpm2Y1riP8t4uO9By5a+XkU/6ikYlDfT0rKDYJaCOUDSBs0RXCt/Jt86gySuY/WXxbWkEg404ms1OSCTTczPHum3oQsYRFgUdz2vf0A0rFtZun8ZdtJSkLHTYPk+SIUt7s/swQJEAi2fJpnRyYMWtjpu9JMqsxx511S8/hOCFeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB6828.apcprd06.prod.outlook.com (2603:1096:405:1d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:12:31 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:12:31 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK (iwlwifi)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 1/2] wifi: iwlwifi: Remove redundant header files
Date: Tue, 19 Aug 2025 20:11:51 +0800
Message-Id: <20250819121201.608770-2-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819121201.608770-1-liaoyuanhong@vivo.com>
References: <20250819121201.608770-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a15f5f-fee2-46a8-3be5-08dddf19ac0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q4qsZB65F/npjCyyC6B32Gw4yuMusXvQHTGOkBU1AvHHyAmcpwbvOIeYCsAz?=
 =?us-ascii?Q?rskrUGB/BlmqqMTntIYAygas7LVmzzTtlJs9hLcK5UIZijs8BRH5tMBcm3P2?=
 =?us-ascii?Q?e4zlGBlDm+fVx4otEKteLlQCWhE03+VfkNx1COYwZTm8XcAB7s6Ozf8BqzJG?=
 =?us-ascii?Q?PrFbz4PBtQrYFsRCSW0RhpYXFn1H12/CtqDneQQFHsTA8kEm0RI5o9C+BMdo?=
 =?us-ascii?Q?WzDQ5wREtY49Zpju1YaCBCdXrSL0/qQ1eu3fSP99YEtDcnJ/W8LGsBqG82ao?=
 =?us-ascii?Q?TnCIwsjeOIE/Shy+rbUhfq0sO2552BYye/aw3IwioGERjW1gSowKwmVJLl3Q?=
 =?us-ascii?Q?WmXUYd3uLX9/1Z7VpYcsLWxPsLEzBXvEupKb8AN8j9siq+Osd6Kb2Geui8z4?=
 =?us-ascii?Q?mRpsBOZ02BWocIpMSR4xA42GsA/GFFWyKcNxyvA9Fa8xN4ZgcSxlImp/RJXp?=
 =?us-ascii?Q?GPFiaIKWKCSm4WUtqJUfbMp7Xuv/baOflnMzKNjiSKMkEmM4/YXcaWuoBf+s?=
 =?us-ascii?Q?FRyqTbx/ylFGkQ3z6boNnmTPyt4uxSpSvhX83FMMbdtCBJosrX1xNwrVpchh?=
 =?us-ascii?Q?hdisyPYwa/pD4Gudld8WBfMhzgGTpLUgNtI9WYSjYnJVdE5fYgldOmGRpn1d?=
 =?us-ascii?Q?9mgqGFutwc4Hmv/J/auxvqregyYlKBT+6vPuE/5IpjMtyXMDy5x5iDdrGIB+?=
 =?us-ascii?Q?4V5wxD87CpjtGGlHydjTV1tvEK0hMIpeyskuMTVzELbdd78GXbwhtD+TeGKf?=
 =?us-ascii?Q?yRbh0bkyV7edqbF1uEqufv61KBWpOz5Lg002yR1y89oj0rw+gNzk6FQfxdIF?=
 =?us-ascii?Q?iK4RTK9AoDkKwTUod4qvxbLc3MH4bkssp5Y6aBmkhioJPOGiv9FiMbwcmSZp?=
 =?us-ascii?Q?bPaRXCz8+8mv5Js9cIrJmRPNT68JzxYy9YpYeV3NzjHD2r6/uEr7jcOblH/l?=
 =?us-ascii?Q?WwSbPS7F0KxtH9A0GxN+7nQq1+F18s21RG0FokixuOurgRCpBDgF0eOCl7M7?=
 =?us-ascii?Q?L8WJ4zSUUD91++M57IhH1Il7fZw2jDe6s8j3fjnX485RoRj/JpnARESnOeR6?=
 =?us-ascii?Q?SY84F0WPdfcU2ycoE4N3LfxzA6JH1djKPGQh2CPmFjqz/yfSCVMEdnGTd0Uq?=
 =?us-ascii?Q?yANVP9FjkoiHCJej/Gvaic1c3dNf7BhgGRtJG8/d48LSZvPdz5NB39goJGdH?=
 =?us-ascii?Q?l/UAuln412gLnPGdyARzzqQHE5SGhzFJ25cdebHGCHE76dG/4iE3N9QKYY2M?=
 =?us-ascii?Q?8EsVT4b1ayXsbqjhSSIDHpRD/5Lv3tQvoltNxC//Nq/jxsm+Kfg1SBVB9jGn?=
 =?us-ascii?Q?BimgYdOY5ZSHp+78MpDMxGJG+lr+Ln6xT6Ct39ZHds4sGg4sGX+TiQvdD2a4?=
 =?us-ascii?Q?4JTFo6PylkTYDGXl04/o54ag4DOTWWeUdcGkLIKDg/KamDnUJd27LDXefSMW?=
 =?us-ascii?Q?7eAGCPchMai6oahHd5U09NSbFNVby2NC4yPbCiYOcJMp8GzewqSQKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2MMai1aczKtjvGwCUTJDOnYWQ91RTk11VB+jZR0FcYHfviNNj4KjGxQ24X1x?=
 =?us-ascii?Q?f/frZfpfo144GbOwV/7d3Ffsx+Sdx57zjrhEWfMe1VtVGAzBPLrFkZl3sJcR?=
 =?us-ascii?Q?upAY+xfe9uu81cqgLbMsmQDTaq+PBpycKf9SyVpMf7cbPNrVycfyZ0YYaak7?=
 =?us-ascii?Q?EdS5QdNJoKkVsgfzCYyEzlXj++5LNREsd0H6ZyGLoPzTlo/QOtKXYLJaqVBm?=
 =?us-ascii?Q?7zL5yAlnDJHPkdfxQ224HKiE03zy645rkmOVL50+SkYPwU+9mVLPASspI1Yc?=
 =?us-ascii?Q?H3pKvYmHnPlYIp/ViO680aOT3gcU6Nf+6Eybv0UORlbHaiqKksGanI5XxfeM?=
 =?us-ascii?Q?SF3F3l9jI3L0EVFKYZuuenGHV1llTM99g9sbVHf81D76jLu9IzFdCctjH7xy?=
 =?us-ascii?Q?LvGwyEaG7QNv3Fm0fTLdM8qOum5BL2BV0kPvrw3hvI8dlYuKWYPwxj6YGTZN?=
 =?us-ascii?Q?Qv5tQZiOrf3UcncEld0YxeylMwW3FX28dcn/lVr/ZhNM+UyS3S4vVSa+fzkd?=
 =?us-ascii?Q?J369gFQsbpOXEFI7xV9rdgD7V7Ehf5AAGrnlfHAKBdgqSyY4GWbWyVBF84cR?=
 =?us-ascii?Q?8kvzE/7EVlMkvN/CKfzGvhnf+jNwlV34HPB1WkwPptM1TeB3LNcEGZg0hNw7?=
 =?us-ascii?Q?ob8zeMrhMfpTdDVIdHLWJGoV+D+oQVRlxqaL2XxfqdOGhYxl26OajOw7eqsb?=
 =?us-ascii?Q?de7n0S6czfnPLkNRv7+Rq13WOWYq1OZQPe8ZKshoVTb2irmWjp4/BBDmdjaA?=
 =?us-ascii?Q?I59cNmRlnMAxJLQjfvOqdVw+VGbj3NsbnapjbKiIRSK5+n/QwQImUIEoDr0j?=
 =?us-ascii?Q?U5SSXPAOo+yxkTXOd6K1CBxdJfP4T2D/CH3ISduqLbhKZ4ze2T4E3YcPJWZ1?=
 =?us-ascii?Q?sJYwHerVo5MmtN8NweTk+V2jPTYjMlFgs5k5YOCC9NgtWiW8V9XY5clWkxg2?=
 =?us-ascii?Q?6Xw504LP/5ZnlWngng94EzyHwNRmBmYhi/zyXmcBWSOo73ptKehdIr4mQjJf?=
 =?us-ascii?Q?/H/zpB/vB+qddyjPyqTTKvMik/4A1sgdM9pPi8aFOWhj5dHgeDERSM5qieD3?=
 =?us-ascii?Q?BU/e4N98KTGJXZnquomoPBqBXstRTQ0T2j4oYwigrFS1EhznHc8+9V2J1LNc?=
 =?us-ascii?Q?vGfAbi6IfWlWaym5ytBinjWlYm49HvL/sGl/qk0kPML7ko7k0EJCa9yyddKA?=
 =?us-ascii?Q?rEQDj0nm61tMp3ECw9WP+ZXVtRNvW7+eXooqklmxjpZvUIFKrUtc+db1/2OX?=
 =?us-ascii?Q?szWQGBf3OLEPGhew1Jf9qzfneEzJjZmDQNHEzziEwVfZahMvzxPksek+ypfk?=
 =?us-ascii?Q?7CQbdxFTVbfXga/D+h6VLhbSgFiBOxMv1lOm+4kwKI1nuwbHrUXoR9/VRCwa?=
 =?us-ascii?Q?ukM3a8IZeMj3EDL1d7jSZ8UHxtgpTIfAMowKdgtxWDiyBPVwWj5ZeVzflqo/?=
 =?us-ascii?Q?axk4sAtTQZPviG4N59cu5v4oKw9AH1JHvkRQV2FklPPcmiVpod01ZBRBzQDy?=
 =?us-ascii?Q?ZgmHpEe/VffelGa3FQo80Ylm2XTBjsDG8lCAsNeu/IZYcLhHpFh2K9bahIle?=
 =?us-ascii?Q?xET1xaCzLn4yfEQNkbvIGeCCYWX4i2GorJQ3KQ/D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a15f5f-fee2-46a8-3be5-08dddf19ac0e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:12:31.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXeKxHa1jpnteLtQwo8WeijtqwxXa7xmOf6Gd690+y0SXwy8S0Op3vo+tt7DdXYmSVnNODlVl7N52qYGXFTubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6828

The header file "fw/img.h" is already included on line 9. Remove the
redundant include.

Fixes: 2594e4d9e1a2d ("wifi: iwlwifi: prepare for reading SAR tables from UEFI")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index a07c512b6ed4..735482e7adf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -12,7 +12,6 @@
 #include "fw/api/phy.h"
 #include "fw/api/config.h"
 #include "fw/api/nvm-reg.h"
-#include "fw/img.h"
 #include "iwl-trans.h"
 
 #define BIOS_SAR_MAX_PROFILE_NUM	4
-- 
2.34.1


