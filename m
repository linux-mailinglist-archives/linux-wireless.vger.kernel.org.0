Return-Path: <linux-wireless+bounces-26570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38762B333F0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 04:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121E81B2062D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 02:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BC1C861D;
	Mon, 25 Aug 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jVeud3PM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012001.outbound.protection.outlook.com [40.107.75.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D59393DCC;
	Mon, 25 Aug 2025 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756088968; cv=fail; b=HOH2n6ARgj12El/zfSOCuUwQD4VsjOD3YxNuVgA/2okY/rkmRqNU8ce19epUKjWCgjFvdpQOaqhPRJj48YObo0Xp/5aArKPnPD8wezUFEvLGiqGMhEC/lG1X5949WY+Y3gXL9D3r2nBwFQtGtU+Mf1eQa0sA9MkMhw2V5Q/GRjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756088968; c=relaxed/simple;
	bh=Y4lyMrt0LkD1bt7RDLWQ1RISFd/AkPABBKpww9pMSlw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Yo9VgEfwFRDZog0OetBfgKxgINxznqUowP+iE6QyvGzInsXZZe0nyCIF9dUZgZfs4OFyec65gb1BR2sSxxhEYQdx4h1aIYPh6mhdF1vBNGDcKUjTRou25KRkXCwnguBLwfhtFaKf2H6T3eZu7R9efub3qDTC3AGL/bJqROc2MPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jVeud3PM; arc=fail smtp.client-ip=40.107.75.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmgM1KxFf0r0+luYdtEwdsBrqub2sjEshkw+j44QPEAUZvuq7K21XWZB1gwrrB2ueUxassLcTFjeP+5AQZwNgLI7taQEn9/22bjMlXwLGXxW+0jrl6oW5vH8YFmbxg5SKsTQLoJ0xw/b1Undku0PqqdCwLjcWpY1R2iVs2Pzrqwuz30XVUodL0VctksAwHOm6moe7uMs5qk7itOW6dKRgobj/OuoMgPWs0Q92tR0cRdhCU15Z42KrEc3pPnphiup6+fr3vnkg+kBXE8s58PjWeg/cXXDF8U+mLNCZltPQugnNg1RJMEWQoo+thml53N2Js/UehekKF3U2VDFG0xGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL8SLGnDGPDg1pC6sZ8TgW1DiCvoi4xP900gkvy+nEo=;
 b=LhE5AsRdCEpIY6F+gD4PH0VYJ0Xve5a5t4fEuNHWU+2HLkJnMY7xdo0kFTgQUZBrchw3JjaPEDkXuZtNgHV9YD/IjTzEMFTEM7PbaJwhUAbADrL4TnOglKF7KZmr55zHkQNQlaD1HORCvjtriYv4SqPV9lAP9x/0BonGnvq9e/CHld57ztXdedf0R+0QgqWdvPF/5cup20uJWKDtRLda97ED8FIHW3cQSzmtF98IKepTH5r9CUGhFhTF5ShbU3lrlWGROy/q4rg18iYZL6k9fLe1aRJ7Ke5PZ6Z96FioVYpdqT2nUTXnfCyjXef6AD8F1B0FJ0ZEolotkmL/Q/5tgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL8SLGnDGPDg1pC6sZ8TgW1DiCvoi4xP900gkvy+nEo=;
 b=jVeud3PMwt1j8pbGubSQQLYdQ3226aRGjV/+KLAKWSKqTvFlL3wJb5dUJJT832/I7mxdj1Gh1uWaX5beJNYHm7ZdCm3JR538Tcg4h1ZAS6yHDczfQvUHHN6bss/MooEe0vHtBSpdzgeWqw86LikLznyT/Xb/ZoqwOS08YKwJDH7r+5v1EmFqCHbiZpGES/oWcTs562na5PBoGqJC19fNAF5lIE2UDo3c6BBw+3rOBibPmuSUVGkpDmWBalCv6th/V+tiMhelbFkHFWGbfN7u+zW9cfHt74K/+mgrnT3/ol4ynOiZpVzBsw9zYOCOGHWOBd66sAo1OQmPRdWIFc29qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SE1PPF50B2D80A0.apcprd06.prod.outlook.com (2603:1096:108:1::415) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Mon, 25 Aug
 2025 02:29:22 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 02:29:21 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org (open list:MAC80211),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] wifi: mac80211: fix incorrect type for ret
Date: Mon, 25 Aug 2025 10:29:11 +0800
Message-Id: <20250825022911.139377-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::13) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SE1PPF50B2D80A0:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e63a5e-b8a2-4541-834f-08dde37f3328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JCogM54VgioTpTqvdKkC/Bk6OcQeRGB4OgmeAvbWAwDxUSj4NrkOVsBNuvYQ?=
 =?us-ascii?Q?9duWZ411KpZ9g3CsIp+LSQQhcQCT8T8lXMQ8TDfeiOiCJhZTLT1JdX+ht6iI?=
 =?us-ascii?Q?2xJ1O/j32w7tLa+CIAHXY5u0bVd4OmxnwCJZkha3QI2++9u5jkPKBCh3k9a2?=
 =?us-ascii?Q?SQgfyR0xtGcEQJeoVBAvj4HtxIeidIhwXXA0yH/TS0usP2Iy7r3ZLAw5mae9?=
 =?us-ascii?Q?aw+u8kiInT6ZEAOWuG3V7RcYvlNmQLSuI9FwRR8/uXTQBucegeugwMNmJ8wE?=
 =?us-ascii?Q?V8D5OKBx7Eo61vm4UzoLgPAS8klEoTlltiDTS8rueqpfZpMVvZ69cR/vDIpr?=
 =?us-ascii?Q?OZKfTppQCsu3UK/5PZ5M1zAzYIr4R/loW3iJVfpFI7cqD6neWkBYQOhcf/Nf?=
 =?us-ascii?Q?+Wb2rsj/Jk4/4sXzl14d0UzTzT0YcKhG69Tt4dKDIGSfw3llf2jZOUk3fjPE?=
 =?us-ascii?Q?8VVhD8xsgnnirqVA1fd+zczjRiWvKYXA15t8fEY+W3/ct5RTkRR9ATQ93q0N?=
 =?us-ascii?Q?KBPuEaDRoGUlS/B3dbpJL6NcoIx4eBVfGKDVArkCU6GIkutZbDlPjZb+mdlR?=
 =?us-ascii?Q?MqVivjncKuCfCzcvx5tIkP9eAu7m2pAS6cXbBCBOY243XXNKyPMi6LHgBI7o?=
 =?us-ascii?Q?2HgFGm4F+xsbCBjGXYdshBd5oIiDHPp7Gpp+yZjiLIeazlMyCcm2UH71E5sJ?=
 =?us-ascii?Q?Yib1U0NV7X5Z9ZM2HHFpDYtYfGsD1B5YLXHsQKsWY8ZbmbyjMGNeQrMA7NKJ?=
 =?us-ascii?Q?rNNFJr8ujn8KzaJ7Clk5g/Flxs1zwt5PLegzitXvdp+lIgFNShvE2xyP8xY3?=
 =?us-ascii?Q?N5S55bj+8DtCFRy/qXJhzKVC6ZhTQQ9EKJyAUAZxZomEAWFZVQEsaje4426c?=
 =?us-ascii?Q?yaItqp7hV9XXtRNlxHkxMkV8Kq6qqwfUKLjOK4em2p6b8sRmypWwo3Od2sma?=
 =?us-ascii?Q?t9RLCzHnesFvwEpepDICuWwomzovld5SqAeDzZSOJ4lVivIFNxBTcd9fSXP8?=
 =?us-ascii?Q?1MUkLGdrJzKsfMCLcrq3KGeIiikxd3QXczuS5XKW5i5IimquPDG7/qkEsOOK?=
 =?us-ascii?Q?xtAjUNqKW3MUj9iVpXuJPAycT2gO0uFp0oW6VS8DJaff2EHJdKTQUBJBa+vA?=
 =?us-ascii?Q?7I8id55eoIaNa1hX9p5V+A/gRz9qd2YjubxuKLde1g2krRr+/H4lPT0z4rew?=
 =?us-ascii?Q?L7tLtrvt9gJJHLXRj88+rHQgIbMvaH6HM0AJByu/FAZxwn6SDnk7r78AB4Qp?=
 =?us-ascii?Q?nt9/rQxXqnaJwypay7YNO2f1Bx3zG3wfW7s3YAnj8m1UzE6fTUa2hXz/MoQa?=
 =?us-ascii?Q?FuBkN3Je5zQinKLqw+v9pXBAlTLGE3+2WlKQTnwzfTk+oqw4zE8ImD10gkKe?=
 =?us-ascii?Q?Szap4q0MgQVdUrcDtKv1uHVug36rJOcOcGv2VuMUh/dToIqU0+M7HXNjUULe?=
 =?us-ascii?Q?xCubGmw0AkcSSCTixnfhwMMuw7jexFp38/CdNhb83dJZ41LxQn2L5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSeHM2rx0bojb5Yi0jeJa3C+RFjiHlMTSLADoy79jW1p/R1k+S/ywYw2phnU?=
 =?us-ascii?Q?mEorge5yyRMU6doxddazDXC5sC/1R8CkvNz6ey6LRNl2sPRmEActwgET55Zm?=
 =?us-ascii?Q?+w5rGFxBUYQ9CHVe6YIVG1lKfckhJBZgEC6zHzIKGabI+AT+vGfC5r8f+8qk?=
 =?us-ascii?Q?GXAvT4Vx0B/B10FewZPlCjjwvmUmX9z6ZVxnV5Hh2K3dBaxi9ZMmvRC84Z2D?=
 =?us-ascii?Q?u9lD7BewXGFzCyNPWaK2IMCpKRCbTSSzbIXuKhFCHjfAhHz0VrTxKI3wHdxf?=
 =?us-ascii?Q?wD0MEzU1Ble5s+prsxgBz19T/GLifiwkri1aX1i+xjcUUNxPAT0wLCbxcOyt?=
 =?us-ascii?Q?ul0+r9WdZ12Sde8k1NVSSs0qNMVnZM10z+sxCwok9ZfKgKIA8jnxqEY9BwUh?=
 =?us-ascii?Q?Jel/1yXZaSMko9yOdByJLWSllJNwInNtnJZOJTU5sodfBEn1CnnAeLIKROfX?=
 =?us-ascii?Q?HsE20U6fgoS6rn6kdFhMd6yFR7XHwnhqL3Ce4v6jAmRjEezksvWsaik8AWPl?=
 =?us-ascii?Q?vPgezRKCa5X/qNwb0LG/Ymqngql/Lo+WQk/zoRZmHrpi/3oXN7xupccbiH3D?=
 =?us-ascii?Q?TkwaVVaN07WSN2lDyRUj64ai0KEcaS41fYJCz+ziAm0EeMWnkdEu+XF5JNSf?=
 =?us-ascii?Q?kefzk2qfrYgB5ZEHvR9jkhjQAQJIJbxWaA+RTBSGwkc16KyrJJWiVuN+4Lby?=
 =?us-ascii?Q?z5TXOT9R89eFFOmhXKNRs/bJFRSevbX1xe7WW+09pEGrBeNHRDyBWBvGJEMN?=
 =?us-ascii?Q?iq3p+6V0A0xTmVU+0iqtPpugq+JHQfpEM7YDKUrIedWbB2dplOCkRLf/ygx7?=
 =?us-ascii?Q?qhkQj4SuSPayUkUPsRvBWSZmu8WV3JnnPeHcS2wFf+q/1E88eKoZj8xE5Af9?=
 =?us-ascii?Q?FYnvmQDzcovJQTg5sPEYnlNn0A+cdgZ5nqu9EwabhCf2q//d/GnIEEB7+RMi?=
 =?us-ascii?Q?mGIV7YdgkI3vxHaTEPimkiiBqZUI3drnNe8ogn0igAAqhktRMo6b96dJAqGI?=
 =?us-ascii?Q?IRMeGqqIsaBaqFZ+Iv2FIDSrJG8akfzzSHSYhE7+VdHVqC4Eg2xnW0swNv2g?=
 =?us-ascii?Q?w1yrOFIM0J8G1LuR6G9nFMBbuvpSdQf7daAL7ZIcZaZ9iqhynaL57np7trnU?=
 =?us-ascii?Q?RwsV2SIUDS+6ss4tbBC9HdoU/Nuj7oKA0NW7NhoyakJM9ATl87DkS7szE9As?=
 =?us-ascii?Q?9ZjTI4mjHTRsPJd+qTMcu6beIBDhauCYNlpfe3MAJFTn5taaHOAHc+OZTd+J?=
 =?us-ascii?Q?eSUqgjSN5RSudFgPXSA5UWmSKBYTFAzWnH1RrLBNuQukoM4Ic84I8OvesxwJ?=
 =?us-ascii?Q?DgeJur6yLOXsepcsNxgYhUwZqBihfa9yPQCjsTjOm8zFlNLdJ/MGtNF/toMm?=
 =?us-ascii?Q?b7LzV8/7mJLnHVXlqKRpPQ3gCnDk2ktluOoydR55js5HmPhHl3yaQ+iru/mn?=
 =?us-ascii?Q?AhLKvg3HFom0TbZXxSGS3qj0e8gQCQ/XfFf4LNdqswODUCUGqEMrPugSetBQ?=
 =?us-ascii?Q?X3P0+06lu1yoIxyhOEE9xpP/pLPwQTeyuAJyh2weyeFsP6oZqpaRffDxTCxt?=
 =?us-ascii?Q?qiQttEBjx9/NmhagUaU8MqMBdOjjxifGm8Ff+OUC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e63a5e-b8a2-4541-834f-08dde37f3328
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 02:29:21.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFmq/lATcqF6KVRucknbl/J9rD+pX4TcwTIe+zJQF96mqsJT0PL96CQ2a7zdxlZCW51ui0RCaIXURw+TkLhUeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF50B2D80A0

The variable ret is declared as a u32 type, but it is assigned a value
of -EOPNOTSUPP. Since unsigned types cannot correctly represent negative
values, the type of ret should be changed to int.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 net/mac80211/driver-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 181bcb34b795..55105d238d6b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1416,7 +1416,7 @@ drv_get_ftm_responder_stats(struct ieee80211_local *local,
 			    struct ieee80211_sub_if_data *sdata,
 			    struct cfg80211_ftm_responder_stats *ftm_stats)
 {
-	u32 ret = -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
-- 
2.34.1


