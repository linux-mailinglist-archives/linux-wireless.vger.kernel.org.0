Return-Path: <linux-wireless+bounces-26425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901EB299E4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 08:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350257A9A90
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC427056B;
	Mon, 18 Aug 2025 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nUYJ2rt/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012055.outbound.protection.outlook.com [40.107.75.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492A26E711;
	Mon, 18 Aug 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499299; cv=fail; b=CEJOtbBnjbX6h1XDm6Shm2Jn/X2PGY0djjhuVTLmXua9y9GqWVNUM2c32YgRIWDE1mMpDG7I663aFQkwFRnPyGPxtdTAoi4iH1LnGWAqjAfeE4wN/nHawwlJU2CjzHvPSEPZ+tjugPiEH+Dop+kgFEZFt2LizNZwe+tCnPLJ9Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499299; c=relaxed/simple;
	bh=hyakFotN/Tn9YWPY54VTN+HmhZ74py0mr3Tn6B/cVi8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MawUJMhIB9Lo7/+CjcezCKIuss7+y7kxpLhDjeT0VCBUCj8zTzRsU3Gydeg2/1j85t22CcCha1MolJJVv5euiyBSGUj68gGwf5JHjWCqv7k7c/btyrETg/uAblKFiCn6M2HIpjcs5jUtJNeSqREvHkVdRRZwzC0146nzXeYQ3YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nUYJ2rt/; arc=fail smtp.client-ip=40.107.75.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMN9p17v8DKRkVqLuHpA3suiWubtiP0qAsaoefXwbEpmBO68cBmV0hPOk9WQVbLOKdzq1CEj+7IDz3XN3quLV5akXDEXmpeiN4tOyMjv8ZkAZSEB4fqVz4L2yMIh4s/1xlqQnsB7DT+3Q99r7qjPr6eS2dEs6SagANU69CI8lNUmT/uyUrydS/8AhPJlrelNQa1iFMhUC644IsDMpUHwztlYd7BSRF2z/36dVSqJE835oOqOVcmDyW/UiUfftDuxztJF8MgCjEyJfLJjr81uhjDKUD6F4iUkwc8F0qwiMQpafT/l7WjHkIRj1R3nF+190BUgAWHLthxSTsz67RvmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnKk4TG4dpHWkY8CKQHt4rdBcdtenoFj0KzkwRYL+Vo=;
 b=TyoG22s++pfqrSCIz/qWDCBuoNK5LTQxZ0y0IKoqnIzfzSlCiDzQ1SIVwRLZN15O1dFj70aRoKv4X8OSx4WFL5Q0feYSy5Fkj6yivf4H7KoQc3QyqqpiHLZBpZnybkJgZsE3HA4VUPYNW7yihs6FvXVWP+uMRtBDuh6wyQNLjNYNiUGZuhy5XN/n0UbaAOAlwxlTTIY+38S+o/iciJ+rBIa6jICrOPmtKZw1LVgP/jnjTnSy29Yg2CS0sr/OGdVc8AqNwR5RHS56Kj2OZidW4INuWEJGAQV1LYuzmGZe/IQxl/JZRx7LbKnocOBdxvOOmhqH4g6O0vVwBP0keBiO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnKk4TG4dpHWkY8CKQHt4rdBcdtenoFj0KzkwRYL+Vo=;
 b=nUYJ2rt//EYPbba2iOSlgBB9SMQpo/qEnoZt9wrmTAOnivrHh9x88fSK1KRW8/QJwDjO+62rL8T31fY+UESYhqcdtI5joOND+wBPrGKyRt1iyhlfAoU412XZDmCq3MoqAAcv8DkCq5lJ0Ujso7W0778F/MIvEFs4iCaGNWTfrXPupVifravyiwa92OVBKFfn+q100e2LZt3GOyX6lVxNL+/PJgrQc1NaSaWoW2ONVwHnl459biZ9Kb5s/NKk++Z01xhoPx4MNq25P//helVriSehdFXZrTlvjhPEEt7JLLvXfN3EF1zhCMf37/tgL7hclOy0BNJlxagdMGdppelB1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYSPR06MB7157.apcprd06.prod.outlook.com (2603:1096:405:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:41:31 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:41:31 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] wifi: ath11k: Simplify unnecessary if-else conditions
Date: Mon, 18 Aug 2025 14:41:11 +0800
Message-Id: <20250818064111.447765-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYSPR06MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 174db26d-89ab-4514-3b30-08ddde22442d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ThWAj3TP4WlE4iJSGRgPgWvZWOwrugHpimnLcljMrbXNCPxZSqyj6t3frNn?=
 =?us-ascii?Q?4/V4ov5nZOTgUfvBn/C3WBcw2faaxBhLq8dBx9XD3lWFhgj3kBjhj7ElpBRB?=
 =?us-ascii?Q?HP2bcE/wHnfUzLe3tU6dHxO7Sqbudec/XNV1YNI7D62X4IE8NaIZAOgMFV0Q?=
 =?us-ascii?Q?OdsUr6GCmrDUzYmI0XEWcQP7FkLIQP5hiwMhX+LXzbO5/xF5js+EIpvYnwMu?=
 =?us-ascii?Q?n2UTRjYWG9EHPPn3On37AgnNDuyyllUKk7dUPQoIGojM9+2nF9nVFMD8iqVl?=
 =?us-ascii?Q?PzjBC4Y3/de7MsA3862rM4iN/30IyN44gQgfEZvT67qtpzML8HnAM1POtXOP?=
 =?us-ascii?Q?/4+xxehyYGGMrf89GQTPPavD9FjzS8xFgwXQ0GIBTqtJ0N7yLhIdcuiwxDSl?=
 =?us-ascii?Q?S0KHpnIv9o4RPMeeak66N1ZdGwiCB8P7V4MwVNnl9ygSOVwIImtOyjc1HQZi?=
 =?us-ascii?Q?kQJA+gXa2ZAbi8NecXC/SO68zsJV+VS8fegY8nBLxU8UW3RkmFHKUrd/BN36?=
 =?us-ascii?Q?psIxrWIk3CBU4YKel5AKFM8Z2UzdrKy4U8YiGilrUAKk9PCOYyo4mzjJ5x3k?=
 =?us-ascii?Q?BSGnszuz7SZvNZDrRB95fnlg0QJNlZiKedi3HQkdG6oMX2OCJS7CU0coDnzo?=
 =?us-ascii?Q?EfRrp3ImJ/UGv9WXfBpMgoqQw4ZwDB27y6UyRASyS9Od2GZH6hwc8aB5Ztpn?=
 =?us-ascii?Q?ojK/56bBhXvqKDpOnq1AVeUPOzFvRUl45YL9K1JGB7NJK1BLPOYsOSGWW57l?=
 =?us-ascii?Q?4YG23nqEqONjvnucy5SOJMtDZyvlmzj/Sc2BLlxDjK3q4W62YFjQZQDnMEdw?=
 =?us-ascii?Q?tnvllSIrT1z1+3s04A0D0+W4NL3vho3OuBd8RP8MxsAKEt5eFnjwiBKrUIN7?=
 =?us-ascii?Q?AoK4nvsT0S01HxcnGnTJaGslvDs5huqZRlzmsTQS0kHtH5B2fUpUjEQ9nLrp?=
 =?us-ascii?Q?U1TjVZ6VuKal3m5L/Rdw55LjX60GujymAg6KHcKH3tErRjn4xdGq2oOkz/U4?=
 =?us-ascii?Q?ZiHy6EvHStG6ziaxrezvK3cC1ZBegQZk4kBWBAj1+H3J0l5XfHWkgwFKPoKR?=
 =?us-ascii?Q?x9T73sR+UVhHFFxYQbPU1J4zRu4H/9R6PgeeRhEU1N/OFkmkpmhT9PYu9z//?=
 =?us-ascii?Q?yiwgPJI6QQfDyZE+M0wYUkG4lN1tw5QRQQoI9UHeAmE77gcGnvTcB6Y+lD2U?=
 =?us-ascii?Q?4SMDxxSP9Tgek2ub3Vkvp4xFV/PYerdSZ7jLtfjazAiPSFpBr0oIljoXMPOG?=
 =?us-ascii?Q?3YqMJoUVH2e+LKCZPMnvHNJdyNZ2YnEObQ+7nI5sfGZCBPxYQJ5iPXCJTjDz?=
 =?us-ascii?Q?W3IowIzmhMcOAcAxf9ymlAju77352qMCcsKg8UKPc5Wv3+OKsegyOwGJDXyi?=
 =?us-ascii?Q?xJniBHUU4h+3mpITLpn7auhjbyF9SfX/IAPUKdgHRcwa6bNC+EIb47pjWY+m?=
 =?us-ascii?Q?CR1THGNJBX+FjNgWZPMBmAWynPwV5ZoiBM4GVZzvtwyn3gtP/4BYJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23z3ajeFRogOFVjYXA/XEsxomA5fPJTxvkL//2hkUVbtqG8rkNCnqz9O/u+I?=
 =?us-ascii?Q?lkcvfcFxIYnZzn/E4UXg6kjpO4YcAoIWqa9EMIEFwmx2XnePQI4ilegj0Mm0?=
 =?us-ascii?Q?GUm8m7beA2hqd8CFtDcm2vzatwlhojiXCB8TYpuZsNwghoF2zwFlUDMul5DB?=
 =?us-ascii?Q?CR362lCFBCotobOkqZ3TuWLAywE9RuhIfFhPdKQSsLQwunheoAwcZQXwA7qg?=
 =?us-ascii?Q?+4mPU67p0TDtMDhh3980NcnwrqG3oZPSO0ZJ+1yKIRlOBTrC3yTGvMSjiOpj?=
 =?us-ascii?Q?vwwT7Nf57PBH3E/47+DBYH5bWcGnaadOe9lrbTYBG5DeQisZ6aYr8Pp0tZZY?=
 =?us-ascii?Q?IYuarXARNHAxZhorGzMEFzlkWsgXb2AIMNFFvTjqNSIZ5DyCzbIHUmetz48e?=
 =?us-ascii?Q?4MX0kIQQ9fl0wJeSBAyL2oqQPhrIzXIo8vyiOfS8KAEQFQoag8xoBcCufTme?=
 =?us-ascii?Q?OMOXdGFKflaBzUy82npDy5J/LZ5Ezs6L9dnGqvyuazOe/TvQZmPObypwSsoO?=
 =?us-ascii?Q?FasHq4At97SRMkVSXsAXW+20aPUFGW7ZgH39QS4RtIPUEj4rw6JqRZ4MuDCn?=
 =?us-ascii?Q?G6qB7Eh6+EZ83OGXaW0ncd7j8oQdHG/FFRKOUgM9M92AX8zc//6joujTxB8y?=
 =?us-ascii?Q?yfVkLMlsEAHiifEyVfIK9+3CLnXe9THjgC3VtQUW1QtyoIr1unv9dT1Rh6iT?=
 =?us-ascii?Q?SIV2Mu6hlbFmPg25CB4QHD66lOoHXS+mya4jZd9xIsYEI1Zw6DM0ra37CUzn?=
 =?us-ascii?Q?DbOLteQrIcpRUkpsPiB0lQKOXBo982Q23C0pZQBz0c4zi+s9f8TgwSVvbyBz?=
 =?us-ascii?Q?exv5mQ6skRAN3vkhSc2NfzyhGhjsui3VU5j1zkFIeJwxhJ01E09qzSSEoe4X?=
 =?us-ascii?Q?+YvfGVgfylIIWFostd5EaNjbgKbVo/OwQYcbWkfGOctta8nUI9pBbsnvS1hx?=
 =?us-ascii?Q?iUveymZrYI/jVLXSPMAlLPxCU0L6q+vKsF8sX/QP6EWKIAFsq0dRmIBqR4/1?=
 =?us-ascii?Q?BK9+yP53HdNF0iMHqPHAhB3Zo5/LTt83cZj2Zg2yR7Hif8KMVyhaRApW7o8m?=
 =?us-ascii?Q?0kGOdW2bk0rhotyaDypLFBtTmbAO3+j9rf2xIS8I5IeVBxeUSKl5N9v3H3by?=
 =?us-ascii?Q?M8nDs1Us+vyQGAxAAg+D/VFFahZ0qliG7s6H6erRJhQK/lSBle5m5rYL8F/s?=
 =?us-ascii?Q?HFypdOcO8pRx6iOwwS4rnTSecwQ/nNuPoyEIWRz+A/TaL8qV3SzLdpjEAioo?=
 =?us-ascii?Q?LXBeVSB0F/q5tORRnO3inq1DbcUjm3+Uq3ufhIENAQVXqZl2GL9VpQ6SbIkX?=
 =?us-ascii?Q?rmWMRc1dRoq98ar8HR/HadvG3U5DOqg3c+ZsssNvEUPOrfYi92neO/lX5tJc?=
 =?us-ascii?Q?565iY5rdwK0LzPMIxnbltO1LT9SZy9iwsnHmpUHWMsycbC6yHpoIoUcXxNh8?=
 =?us-ascii?Q?Fh5Ejk8QJae2vWJMaChsm5VajvRLMHm961wOHQDFwaqu8KfJ8dlWu8t9Y16m?=
 =?us-ascii?Q?M0BlSDYuC8w30yJBKGjHcz/BHI9+OxUbwZf6O9VABXd10nXJyANV5RPIz4XG?=
 =?us-ascii?Q?z+86aNo+f6XDfPr66P56iqAksylhnrd80ucdLsK+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174db26d-89ab-4514-3b30-08ddde22442d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:41:31.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHemvCyELOCpIACmXSMKv+ynbFILElaiPhMQ4OEFknmZitxDGq/MPQHpFVaVSWEhuXK8i+f4Bl9dr4OgLreiOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7157

Some simple if-else logic can be simplified using the ! operator to improve
code readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1fadf5faafb8..328df27116ce 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7936,10 +7936,8 @@ static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
 			    "no transmit power envelope match client power type %d\n",
 			    client_type);
 		return;
-	} else if (!reg_tpe_count) {
-		use_local_tpe = true;
 	} else {
-		use_local_tpe = false;
+		use_local_tpe = !reg_tpe_count;
 	}
 
 	if (use_local_tpe) {
-- 
2.34.1


