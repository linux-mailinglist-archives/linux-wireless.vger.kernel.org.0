Return-Path: <linux-wireless+bounces-11728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D529B95972F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77563281335
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A91B3B3D;
	Wed, 21 Aug 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ty7KSoNg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2067.outbound.protection.outlook.com [40.107.117.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91821B3B3A;
	Wed, 21 Aug 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228646; cv=fail; b=q4KhUMoVL6myp/XVd6OQjJMPpTV242ERfXtkMMoUTHfppwULFHjr7OpDkBP5/h2WSC3I9grwlFS5CFd2P9kI1v2rAon8HNlsKhwhxP8tebEpQ9CPJhaO9Yu0tPtqC6gpsber5/W+bbDCTQi5/I0UjYAUZ79Nm12UcplKSTu3s7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228646; c=relaxed/simple;
	bh=+pz7RFZ/INiP9v/4TXwcslRGm9cRrM8iVILgCFC1RTE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dp57dm4Vrg8DIzRqOBJsQNPqsNBMVmwTRN9QeWJojMfTr0Dj5wsxPyzpUd0YVHOR0Oa+eeJ2uWtQ5IJeUCm/jyz1PakhhpMSX40aGg3QmazZHkQEzNfsRJdw3GBJYgcYq/EefHfvf5WTBn2RMrxhTood3E2g8I4/0apgQXwthQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ty7KSoNg; arc=fail smtp.client-ip=40.107.117.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U61lyE9Rp7tunEbC5ne3iOehi5RvuP8hqPA9+l05ksXDE7CCnkUsfdScO8MagKw+5DXhXYZNZFA2Z4HQIPvSavuJmH15Gy/DWt7vSNE1/ne8zFl6y/hxkOwtJAqgLGFab4v/ShlvChC+We7UjcQ/ZofRuDQByT0zo5DdfwdUx8uG4+wg0X2NxeIszrxLWMFllbj17MZGq89nsBV/5spA2VqfvZtf0jnSYe7uY+pBG823vyHEFdL3kA76TXhVQUvBUIUTPpXXD86nggxYkmDkKE1U23gbfniyaAVfOpLmmZa4E6PaqG9s0QW5a+brTj5vlysYxUn0AtI25NwgffTD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p6QXMM1OYggoSlXDzctKQAD8JfdqbCwORdkZrGlzwA=;
 b=Qphw/9eqNEwSxVJydto9dWO6VSRBycA/SSmEfBWBfz/IHOIsHy1kZeuWGtQiE9jT+0O6WDrh0PjQDe9rp0QG7c5gPzU4cmX3ghzp3tsnNwYwRNL+3T7bcbk9eLQCQ+JKoHkyivvkPAtzKeIaJ1dWRrANOtynQBCsJRutn0m+LZR8vID76lBvCHgrik0PFn4ajChrEx1DbtFWR72zBWxx3N14UUq6zwAUameJi1GgXnKw8HfGMcNHii0asm+p8HovX4VwOiy11ujxxdLQL1AkoByd/uDDlwEJ4EOtut/i6urPMuUSrVLBZ7nwzQA4IwM3nHMN3ghNwa7j/kC32hwY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p6QXMM1OYggoSlXDzctKQAD8JfdqbCwORdkZrGlzwA=;
 b=Ty7KSoNgK2t1hC3iwNPwZKTXmC2Pi5MoU+o60xSFaHHfKXgk2fiSt+EFVbkeE4tTuLVeUXGyU2wBbSNd6xzhgH8r/PZ1FCsxGNhkPebA3sv/IhkElz0Z4Lp4UhvqYwwH+a387cJnPQxUyMavPSfTZxAP9NPXDUtxiy9b8PfNiXkgNBZ3tTQGE9cYqz5DBaipapbHfEb7xj+7nyB9BXpKF3eOl+3PMwhBsaCqkhioj8UEbycHD4OT+Qm2y9dCc5ZO3dTg0XjlxiWXbnV9BZQyr8yCDAha80WEDL/6WFwwRciDQm63FWNfwP3P8TREPXIxBzq1ctLbvwCfSgDU+yR/Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYSPR06MB6315.apcprd06.prod.outlook.com (2603:1096:400:40f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.27; Wed, 21 Aug
 2024 08:23:59 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 08:23:59 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Yang Ruibin <11162571@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:mei:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 04:23:42 -0400
Message-Id: <20240821082348.13026-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYSPR06MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f88b682-f18b-495c-2313-08dcc1ba9aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ueWL30EoLazCznBNqYbcTDYH6IP4NnXGBC6vOc3WCqoBwaLsJR9TyMODXCcr?=
 =?us-ascii?Q?yILeDoa4HIrWdFcIMCafPM3IUSV8SKYSif70EAaJnonnYOviFOtpRpBKBGqn?=
 =?us-ascii?Q?TAkYnQc1Eb5S06rwdCJeeAJTIa46d/fR0PljfuIOwrFuYSEDa03X9K+wvIHg?=
 =?us-ascii?Q?bPvvxiRhvr8Wj/w+tkSE9oxEyiIZP28EnR/q1BTudXTF/BISd7pmKlOPF6NU?=
 =?us-ascii?Q?JQ/AGl/7p2mhqJGbDvXYGMFFTwuoIGprjQTjIrzkO7/LiQLtqsODMblYD3nR?=
 =?us-ascii?Q?12Kw1eeMeJocjP+FrADC6FvN52AIpAltwUQM+vZXzH6+qA9YhiHDgNU2Qv0u?=
 =?us-ascii?Q?frx0qklErU+/VUAriVtfvthbqGN3kwnjWPMv0pJkSo1ZVidhdN+7MZeDEuyF?=
 =?us-ascii?Q?vU7RsPc8TGs5IdoHoteDCqVLsbIBsTxphfvrWl/gTrtkb2KhvZijqi2c5iaf?=
 =?us-ascii?Q?bumhjf+gi6j5CqoaJa0/7gB6EHCEuFpD6ds5ag77BI2t/BZhbBkGmM4uyzW0?=
 =?us-ascii?Q?YqFnW01MVCpPhYdirrZo9gciW64xgiF+TfAZgcptEEAcp/7pthtO8ZBfZax6?=
 =?us-ascii?Q?vxF8N4LikkNok6gKmFxNJxvBYdLCLK/egNAA4R50hsIpMDOZIls8CJ3pSxbu?=
 =?us-ascii?Q?3t9r2h/PPb+PN3k0LLTlWoFOia59r+ICtP5OgvB2AWDY/fL2/z2aDNE+ssNO?=
 =?us-ascii?Q?FppYrJpG1NSA0agSqMMxXYpkRDk6kxbkSnsUetC1LQnPISrLHmJqNhpQccDg?=
 =?us-ascii?Q?I85gKR8sLav8xCteOhXey5Ia0hb3GRsPBi/5dv9tnsEQI1zM6iW4rymbUd51?=
 =?us-ascii?Q?p3SBl229qfpjFQwX/DhOVHH5LlGXxePxdSuyaGRpQUzgOa6TMDYWeoYqkX72?=
 =?us-ascii?Q?4iEm4VTklgYYS0eFtfVltPwdBKxW3j0k8oWb9JNSVftE3VsQmsIKuLd1V1Fy?=
 =?us-ascii?Q?+PaR7VYAoFtPZd/euEGeeDQQNCglUAL4aLh3LalTVCrIGuczx5QQWBVg8Y0D?=
 =?us-ascii?Q?gLeqLS4QJWSidJ+tufBnnHqiTNcBmt18+g4o6f+3VQBn18KlsaRqTIUB34gI?=
 =?us-ascii?Q?VFA0WozcgB5cpKaYjHXZQmduZsuPgSRsXZhXo77qlWHfjMtYCnDYYGpF5wcc?=
 =?us-ascii?Q?TKxgEDEu1legR4/6WmYfullCXiO3TlV8njEQpn6rKBl1Sw62MVnnuIDGbufL?=
 =?us-ascii?Q?dOmCEOpUokHkAmeBSNzt988MBLNxZkvHSo6+QEgBDt0BsKHiUtQWK/aVT/7f?=
 =?us-ascii?Q?gVNYUVeOkGMjSvf9Evy6znjYsjWMkdVOGXFCdIZt9uem0lTEf11iBEfRCP18?=
 =?us-ascii?Q?Wl5hw5zDr5WUKG1isp5jLwj7DheCMNx5n2SZOCMuWBwjc6WhvdVg0xDZ6H5M?=
 =?us-ascii?Q?yTaqPFy17CJOV6Ix8GLijTONaJuefMHg2BN9HctQAajAO+Jjg7wM6OHSJUyO?=
 =?us-ascii?Q?2aBHpiPW7ps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NpLDW6Wg+mV770iqP/XDHjABxlqXY6nLytJjaIn65lGD8QC3uX/lHawXdvbT?=
 =?us-ascii?Q?8qgBruNj8eV2MiTMhF5J/d3hA73FnMnOdPgxThgPrxATlSO6W4GXG2wMHUXK?=
 =?us-ascii?Q?CAbF2dgkPBXJeMhICoEqh+TK9zVpBxo3eBPYP74SbWK+ZZ0+PVO9yRcs4Ury?=
 =?us-ascii?Q?o/W7zZlp7aPLeiH5w0GLDmapx7O/rv/Ie1y4emsDbDIuZu92N56RwXtEcumE?=
 =?us-ascii?Q?6euFEbA9cKSDgb/IDkLRRgpEqHMFr3SRab35ExlpKuCvT59dCwi2TrcfDLFN?=
 =?us-ascii?Q?Le86iaI48S7PMw2opIxJ4kU/RVW9EdvptbjDp0K9HstS/GgUu3wid2CS2ktv?=
 =?us-ascii?Q?K3ovwtsRmZd26QTTtOUe96TvQlHWxBJ45iJ3eOPwgBpJ9Vtm24nnFKnOpCai?=
 =?us-ascii?Q?Dp82ZKesJgV4qAHja7RxNWQrQkZipVhqzhxU2qB/0xE6i/ZwO/4seSkBT7fN?=
 =?us-ascii?Q?JwoebuEIfeGDINs+WdwSllkkoBnYXIruIN/1vu5nfPFImx/EWOs0P91GHBua?=
 =?us-ascii?Q?Taatodwjqw3dizFi61hm6Zqjdr9Qp47Qd96b1AAeM8oL/1yQiiJfhPHGZbwf?=
 =?us-ascii?Q?RB/pfVw4Ry1MP2JlG1McyU8C2v9KaFl2kG/vSyAGGhPQsLHU3d6CMNhK0E5P?=
 =?us-ascii?Q?3n8EC3Jch7lfsbtWK1NB1XY2BkXPNea6Uu9FR/u6lHvCeoindFa6CpffYMIV?=
 =?us-ascii?Q?IawYPzERA3ePDXkv90i6xT+YxlXuAANPxoCXEkC8fMmr75JITqem1AwPgAo4?=
 =?us-ascii?Q?bh50WRqWZe0gJpADBVQdQy5IG+ftqZyYA0zWYbQo9cENYeHE1Ta+z03oAST3?=
 =?us-ascii?Q?EwxP1r3E6boqO6Z5TIxiqDPyJe4RCi2pD1w8r6P0YjMdGau1hCOjY3NvZTzv?=
 =?us-ascii?Q?QZLsxxXpIeXHrZ7KxYX0MoZiLakGHzXUC/vlVklHJy0DjnRee/QcItVq4jJR?=
 =?us-ascii?Q?QjXPSwbAS5zQo4zbSB/7as9YLET2v7uYkmtG8i+4SGbCI4cTwClJfM/NXAZH?=
 =?us-ascii?Q?r0ECKWvCjMEdVQWIsoacyORpjbOoxadK0VsIZmSwX97BzlHXcCzaeY1mADyh?=
 =?us-ascii?Q?hsjzMJ9VUCCuqsZEmBdxWTHdXH18hNXQLpjEIeK5X62X4HPhvIi491JP+gi8?=
 =?us-ascii?Q?lGUfqw1gbxeFY4pZ2XW9v2z2+VKpF8jjP+KxtiVUpRX9e1vZzcMB6I7reJIw?=
 =?us-ascii?Q?9Zk1UMLf/aXiDoKPS+TOzsMlRUQzkaAdMNsQxTliZkoV59HogIuJkLjKzjdG?=
 =?us-ascii?Q?3NiKeK8VVRIuPoZwJQ9JzbfHUKi4BjW6hdIhKviHaOZVmANnPlowytpLnUaZ?=
 =?us-ascii?Q?+Lt8GWu5O+ep5Gg3S0a4IHUHUbzrOEesTiJ/4TJ0AzXgsoyCEgB4j0o+7YTH?=
 =?us-ascii?Q?t5M2/JAeflvk5RlFcpm8agj0ecWex1stVzwjZsf4gawmtMckgIulH4oXHTDb?=
 =?us-ascii?Q?LoGUI8JL7b1eD4XmZf5N6qFsHokSlsI7RC3DXrQegGhwP5s/lpxYyG2cAOGX?=
 =?us-ascii?Q?ymnfcbLZCFwXh4FHJT6vLvVaPIQQCFPQfNgBmvJSkzQnIJy+ES8qJxy6WqUK?=
 =?us-ascii?Q?TlPfgeoqIafR0kGC33iJYD68NKf+L+/OrK+3M34K?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f88b682-f18b-495c-2313-08dcc1ba9aff
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:23:59.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtbWC9ZRgB1darc+rXEAizHFHmWIQ007uST5fAlGWxWp51lP7KzlThr77FbCqokeyr4+GjBZwTgmZoteMbbvWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6315

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 1dd9106c6513..d0438f9a9ab8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1894,7 +1894,7 @@ static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
 {
 	mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	if (!mei->dbgfs_dir)
+	if (IS_ERR(mei->dbgfs_dir))
 		return;
 
 	debugfs_create_ulong("status", S_IRUSR,
-- 
2.34.1


