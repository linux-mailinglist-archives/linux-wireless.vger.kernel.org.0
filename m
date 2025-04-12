Return-Path: <linux-wireless+bounces-21469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13477A86C4B
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 11:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B02F7AEFFD
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7519D891;
	Sat, 12 Apr 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cx2AgcaL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010013.outbound.protection.outlook.com [52.103.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06E13AD1C;
	Sat, 12 Apr 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744451364; cv=fail; b=tZRuXff/hGWeFgj+4hfL1q7J67H1rbsq2gwxLMhUBHZfz46BV4LHuzxMWbakVFmlWFpOZVy2gm4J9f5V8+TqC9DF82RvdbkPG91xR0f7ZwS+cgxrwPArLkWF3PEhfzpQDUrAUR4PN1uise0n6H5bUMaIO0pcsi8gyzGFwQOixbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744451364; c=relaxed/simple;
	bh=UaJKJkZiJAph5LRws2/72BVkSFg8J/TYUkBPtzxoU/I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GhC/pqrqfn5KfJoPzSr37mDkiuZ/2pYmhXIxkwaR9xnp3A0+uIzSPwYZe9NkfRa2GWWHmO+/ZFOvEpB1pIc7tdz1JWUvueLk6jvbPrbMLjTEu1+E/pr02Catr7NXBDzFmm7CWHr3Ajj63At1I+/GKyT90FZvJvM1kV73zVqajeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cx2AgcaL; arc=fail smtp.client-ip=52.103.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEopiyXHpoiF37V4Mr8k4S0M4kUmBChtRSwVLsBoaDvIWed3QsoTSEC/rlYr/xmZRT9Zt0xuZpHxIZcAZh7B4jCUjlD+8yS143ECyfAc3tZZUCiq4vVDjxmILz/TU1mQf4dhPntLZxKJ3i8NZwF/NHULvZfFoko6pezdmtWTgg+J6kQWP2mT9bjDYN8qppOfWOjRLIzaNlDhZ1S6/zEk9l+b6RTvAof+ebNTcBsvBH+KxsGQcfUnzdB/u7HQE2rF584Suhyy+IRDPH6tAuTQEIfs56sFhi0V8cLQcp+7pqBbUMP7cqjsshoXYtnCdiihR7NMfmNx/+nXJ48icp7v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRIsL7AuWochSBHQl19aNLtei9ojbuBN+CRI7MECEuY=;
 b=QwapGmDTWtMenptupnG0PAGlqWkRydKQkXJL+RNpv0t+jogDz7Mo88Mic6qsuG++aH0Wu8x9VdmpP+QCEnAfV7/iW8SXlffsFa3c5GA6Wo8N2/lcR7NEEXVkEBKthz/bENfsd+zpJ8WIQq/TIJCxQyWmF+8/XMDs8oy4OVPWJne6W82RqFSS5hyCY1ObA0nfRw1mP8zrQs8b4x4SX9cQu666kkpO7O4TjetiJj0mYGVBJTYJnZyxd2xZ8bLAYvpCAS/z8dOIsGct/JbM6oWXux//Q3k/apGGu5pHdWQFLS5UV4UhInB4Y7e6NdQB3J454nyNY6/ZNv8qWKTEG6LIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRIsL7AuWochSBHQl19aNLtei9ojbuBN+CRI7MECEuY=;
 b=cx2AgcaLMvLwe5+m4yxwDrtMr/nX2nINTfau4xHx77Q5ldq1e/8ENg0gPPjtPgClIRfkQaFCQ/yl3fjrtEECoiB+8SUrshMlSKCcC64AtthoHGoCcVrg46/DLlhNVdO/V3jnceday2cFDfxCm3OF3tOdrxgW0tr0++MD0lWLhRjjinSBidACX2KSfatYEFobEZBeMZoypgIPTyOj+mCdGucNxDJj/kQ5FBTa9Jfg0H0pM9LUvvwCABbd5dMR8KEbQKfZsjxjotDl9jIqI85CrLuxVmERIDX3Y4BrrI+HFlR5FB+LKtv5MvGwonFzfdjJYpWKzvK+HoG0KowefO1atQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS9PR01MB15785.jpnprd01.prod.outlook.com (2603:1096:604:3d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Sat, 12 Apr
 2025 09:49:11 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8606.033; Sat, 12 Apr 2025
 09:49:11 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johannes.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	nicolas.cavallari@green-communications.fr,
	christophe.jaillet@wanadoo.fr,
	benjamin-jw.lin@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	quic_adisi@quicinc.com,
	deren.wu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	bo.jiao@mediatek.com,
	gustavoars@kernel.org,
	razvan.grigore@vampirebyte.ro,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH v10 RESEND] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Sat, 12 Apr 2025 17:49:06 +0800
Message-ID:
 <TYCPR01MB8437C59A31294E474A95A89998B12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250412094906.22248-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS9PR01MB15785:EE_
X-MS-Office365-Filtering-Correlation-Id: c459f17c-a763-45ea-7bd6-08dd79a746bd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|461199028|19110799003|5072599009|5062599005|8060799006|15080799006|440099028|3412199025|12091999003|26104999006|19111999003|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FSWFN6/cEUDDo3+9dFH8vf8Z4NDFs143Ib6BUm+bgUlw5IdMEg4AT1iMpXZw?=
 =?us-ascii?Q?q1Exqs1UyXgiH5F0HGqDzNk27ZOM2eXcq8fTPUdnUioZy3uDQDJBudsl4dFF?=
 =?us-ascii?Q?zpxhp/i6j5x8zxIggoRhl5njokiW9mEUfqKann34+11KpU6KdiHy6dnZZ085?=
 =?us-ascii?Q?p0aReP1rzeeKOTtwVJ56FzFYFl41OaFAMD99ihDaaOwxWqcZoVhfptP7BzXz?=
 =?us-ascii?Q?8T/qFJYScclqy/YlXVn3VKyT0cNPjfRA3iCCkRlL61peq7Ntcx/YeGRsFZQM?=
 =?us-ascii?Q?Pg0alO4WJHw5RW4Evgw6b3Ays2neIgIqG+HUSokXyGv1tdUUwAtvHAhdYVxc?=
 =?us-ascii?Q?Zc6gKntAO07mbusuP4KEieNHgieNbCVpNmunEKQ51Y/oJkQYO58Zw/aB5cgj?=
 =?us-ascii?Q?l7uje4hMDKfX0saa5GlcVFrmY5ZsOTF/2kGOJX4p7pF71AUFGCWs8eOdDSXf?=
 =?us-ascii?Q?4ulULBriAkJYnvoZcTzbfiuLtopqu6cAER7KxpD/SLe5H3Y6YDXI0j2xV1e6?=
 =?us-ascii?Q?mOmh94vXIIapaH0XNFUaYyYSwDZWHQTnGYqcQ1DfJvtvB6ytyc2IDhpCfGhe?=
 =?us-ascii?Q?pZrmnWnpDiYyQqol+ZZTlf5HGbscv7gkuMmeUD6wUGwrAWinH0AYhq8bytVj?=
 =?us-ascii?Q?03g78AHtWaqWqbLOt8yzUCQBPnloSWHcnuNgHXxQ/35YiLz2J33Gyqj76wA2?=
 =?us-ascii?Q?TTitnELYf52HN2+FVA5aP7hF9Lx/hO6uc1efSu3JjDxFiJSrZcEMoUHydox2?=
 =?us-ascii?Q?G018muzGmXsexsCelchcsV5uR3GSrW4YT4LHPYex7nqbO6Nvvelg3BZH4ZtA?=
 =?us-ascii?Q?y+oC7bQy3Du7M0PLE0DFe9C+ZRRQ+Y+XJf6xvscJfGvCaaVp1O0m5QwiRF9y?=
 =?us-ascii?Q?AKTVEo1znWXwi7uxczNtLz3lbj88JbqF6fpE6vBHE1EYBixI5sZS84muoKN8?=
 =?us-ascii?Q?jHTmaW0eT7VGo0HpAYSea5jxA6+/6ctee8gjUMOC3cFvcJfrD7M1EgrRJvPP?=
 =?us-ascii?Q?WjhoORzIzZbUGf4KSSIrE2JofEHMj1xI0b3LPhRPb++17GACKME+xq1eFluq?=
 =?us-ascii?Q?/r1tBz9qSUabmIAZWBjX3kUL1/rt+VAEghqChX+Is+C15bGhfQK/VC0f6RRG?=
 =?us-ascii?Q?pOyBNJCfPnaoZkL2Ayp6a1D4tDxQPr0UZ4+YGGHs5DT5stYIeQ+mFe69BYX3?=
 =?us-ascii?Q?RvLmQGGhoDGObI73GHxkntM7v8BiRPEpcDdy936oqJ9iV9jfy3tzzjM6Zig8?=
 =?us-ascii?Q?tEAXLp6a5jaNkpoAONYd+ThsPD5s2PJvVOtizewFbKL8So9OByPCU80Bntas?=
 =?us-ascii?Q?hR8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7HkgWkbH1ZrLgX5iPC1MgwJoqC/2d6QiM0adAjeEtKugOwgrNKW7eS0WmBP?=
 =?us-ascii?Q?uv3gdyJY5geil0CHjxaiy0B44vi1et7WIx+3fBSdARupHUPRcYPOPWqZ3liE?=
 =?us-ascii?Q?aDIhAANH8UmCSYOXBXIs6qhvWw2O1BKCNpZoBgVOmpdFqLxh8mu1vTv9P/gD?=
 =?us-ascii?Q?ePsLE8zTFOHwtzlL7delCU0BgONt8y1fv6/CNlBlVMHQCo21s8t1frXw//tM?=
 =?us-ascii?Q?NH8DM7uiZUP/SySiFFCW43eT3aW+L74jo9JzU8RO4J0AAszcz77rgoLOCSle?=
 =?us-ascii?Q?03edNcomIXVg8aqd1RBGSy4V4LVwWwh379pUpeIO1w004chbUpmnv/jO9s+D?=
 =?us-ascii?Q?r3gY6b2tLBSFZ3C6mV6+VmAAE3b54huFIdh3VxuAvL9EzS3UvibQ1s3bfRo3?=
 =?us-ascii?Q?GQDdB9OjhHtGzZ4uW8QmG7Jirg043FeEFuu0DK6peBro5aSbs9Amvuh9UDM4?=
 =?us-ascii?Q?lIKtzkTYO+Xk0cIafu4g3f5MOzlbaEbe1DoS2c0z6Sy25lQKyw/HfF+2zESs?=
 =?us-ascii?Q?AzQlb3VXhV1Du/XjtNJgRyBcpDQa6Lv5gVhSkldRw2DqVaV6i5JurHQ26A/e?=
 =?us-ascii?Q?TBBIAyNJ55HxxwC7nF90IUZFbMFhcuq/o/yhZGmCTrf8lOUtZ7APJiAEZf+w?=
 =?us-ascii?Q?edtGk4ImJTgN3/VYXN03CQXc5ewP6XDuwvtREX2dYFbt1kumSbXClfraR289?=
 =?us-ascii?Q?wrlvrelB6MzXJaqy6EBLuS4P8wSvLVlptoKe1vHcfS1BCRXV4YVSNzqrCSGv?=
 =?us-ascii?Q?qb0cTgRHCXhakBczcgGqCNnhasKKWqUQCro7zvavbGUHDgidpjA5fUKB7Qqq?=
 =?us-ascii?Q?n1dZHE/hUBg0bwv62t/rIrfvV8Nx/VmBB4NyOupJjdK2TbGfg5UgEesk9n+H?=
 =?us-ascii?Q?dw4fANjxcRHa1V73Njwq4fodBQQMVRuV4OsPoJjoh5jxUZAiZGF8+s4/Y7FJ?=
 =?us-ascii?Q?I4mmtjazYAgMoEEXv2AJQ5tmScIolijFL1p3aU1m3L/77nMHOfsOlCim+Row?=
 =?us-ascii?Q?YGc/Ug8SkKEHII6pJC3jgAcSSDamm6E1li4EVHrIU9JRx8kHQBEMYJSyAtGa?=
 =?us-ascii?Q?C90uKTR2lh4+jD+dDhjWOrOqMxyoHrNW47IHUHtqhOk7ZJtEr0IrMwR6/g+w?=
 =?us-ascii?Q?odtaENVugCOE6okrok9XgFMT5D/Tv5E1dAoMsJJIhGNWBU9U1rc26ggzdCRl?=
 =?us-ascii?Q?359FNPCcOpog7daXBryM6ZWR7HfjWCGHY6+/pNt4okry9wd+vAB/G0Q+keBw?=
 =?us-ascii?Q?sY953M/CkR9f7bPLP8Fi6EP2/BoTwmpdXMRRZWjz4R8m+UQ/5HG5KYIXFszU?=
 =?us-ascii?Q?Voc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c459f17c-a763-45ea-7bd6-08dd79a746bd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 09:49:11.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15785

The current WED only supports 256 wcid, whereas mt7986 can support up to
512 entries, so firmware provides a rule to get sta_info by DA when wcid
is set to 0x3ff by txd. Also, WED provides a register to overwrite txd
wcid, that is, wcid[9:8] can be overwritten by 0x3 and wcid[7:0] is set
to 0xff by host driver.

However, firmware is unable to get sta_info from DA as DA != RA for
4addr cases, so firmware and wifi host driver both use wcid (256 - 271)
and (768 ~ 783) for sync up to get correct sta_info.

Currently WDS+WED config is completely broken on MT7986/7981 devices if
without this patch.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Changes since v1:
 - Drop duplicate setting in mmio
 - Reduce the patch size by redefining mt76_wcid_alloc
Changes since v2:
 - Rework wds wcid getting flow
Changes since v3:
 - Rebase to next-20240703
 - Sync with downstream patch
Changes since v4:
 - Rebase to next-20240802
Changes since v5:
 - Fixed build test error reported by robot
 - Rebase to next-20240805
Changes since v6:
 - Fix potential race conditions on tx/rx packets during the transition
 - Rebase to Felix's newest codebase
Changes since v7:
 - Fix build fail
Changes since v8:
 - Changed code as Shih advised
Changes since v9:
 - Changed code as Shih advised
 - Moved mt76_wcid_alloc to mt76.h
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 15 ++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 53 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 18 +++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  2 +-
 6 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d7cd467b812f..7f590854959e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -28,6 +28,9 @@
 
 #define MT76_TOKEN_FREE_THR	64
 
+#define MT76_WED_WDS_MIN    256
+#define MT76_WED_WDS_MAX    272
+
 #define MT_QFLAG_WED_RING	GENMASK(1, 0)
 #define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
 #define MT_QFLAG_WED		BIT(5)
@@ -73,6 +76,12 @@ enum mt76_wed_type {
 	MT76_WED_RRO_Q_IND,
 };
 
+enum mt76_wed_state {
+	MT76_WED_DEFAULT,
+	MT76_WED_ACTIVE,
+	MT76_WED_WDS_ACTIVE,
+};
+
 struct mt76_bus_ops {
 	u32 (*rr)(struct mt76_dev *dev, u32 offset);
 	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
@@ -1169,6 +1178,12 @@ void mt76_wed_dma_reset(struct mt76_dev *dev);
 int mt76_wed_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct net_device *netdev, enum tc_setup_type type,
 			  void *type_data);
+
+static inline int mt76_wcid_alloc(u32 *mask, int size)
+{
+	return __mt76_wcid_alloc(mask, size, MT76_WED_DEFAULT);
+}
+
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size);
 int mt76_wed_offload_enable(struct mtk_wed_device *wed);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6..fcbf4f971026 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -744,9 +744,16 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
+	u8 flags = MT76_WED_DEFAULT;
 	int idx;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76)) {
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+		       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+	}
+
+	idx = __mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA, flags);
 	if (idx < 0)
 		return -ENOSPC;
 
@@ -1271,6 +1278,11 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int min = MT76_WED_WDS_MIN, max = MT76_WED_WDS_MAX;
+	struct ieee80211_sta *pre_sta;
+	struct mt7915_sta *pre_msta;
+	u8 flags = MT76_WED_DEFAULT;
+	int tmp_idx;
 
 	if (enabled)
 		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
@@ -1280,6 +1292,37 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	if (!msta->wcid.sta)
 		return;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76) &&
+	    (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
+		pre_sta = kmemdup(sta, sizeof(*sta) + sizeof(*msta), GFP_KERNEL | __GFP_ZERO);
+		if (!pre_sta)
+			goto error_alloc;
+		pre_msta = (struct mt7915_sta *)pre_sta->drv_priv;
+
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+			MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+
+		tmp_idx = __mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA, flags);
+		if (tmp_idx < 0)
+			goto error_wcid;
+		pre_msta->wcid.idx = (u16)tmp_idx;
+		mt7915_mac_sta_add(&dev->mt76, vif, pre_sta);
+		rcu_assign_pointer(dev->mt76.wcid[tmp_idx], &msta->wcid);
+
+		tmp_idx = msta->wcid.idx;
+		msta->wcid.idx = pre_msta->wcid.idx;
+		pre_msta->wcid.idx = (u16)tmp_idx;
+		rcu_assign_pointer(dev->mt76.wcid[tmp_idx], NULL);
+
+		synchronize_rcu();
+		mt7915_mac_sta_remove(&dev->mt76, vif, pre_sta);
+
+error_wcid:
+		kfree(pre_sta);
+	}
+
+error_alloc:
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1726,15 +1769,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
 
-	if (msta->wcid.idx > 0xff)
+	if (msta->wcid.idx > MT7915_WTBL_STA)
 		return -EIO;
 
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->mt76.idx;
-	path->mtk_wdma.wcid = is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
 	path->mtk_wdma.queue = phy != &dev->phy;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ||
+	    is_mt7915(&dev->mt76))
+		path->mtk_wdma.wcid = msta->wcid.idx;
+	else
+		path->mtk_wdma.wcid = 0x3ff;
 
 	ctx->dev = NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 427542777abc..61a854d2c416 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2403,10 +2403,20 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 
 	mt76_connac_mcu_del_wtbl_all(&dev->mt76);
 
-	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-	     is_mt7915(&dev->mt76)) ||
-	    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		if (is_mt7915(&dev->mt76) ||
+		    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
+						0, 0, 0);
+		else
+			ret = mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
+						MCU_WA_PARAM_WED_VERSION,
+						dev->mt76.mmio.wed.rev_id, 0);
+		if (ret)
+			return ret;
+	}
+#endif
 
 	ret = mt7915_mcu_set_mwds(dev, 1);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 086ad89ecd91..989f24cb49eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -278,6 +278,7 @@ enum {
 	MCU_WA_PARAM_PDMA_RX = 0x04,
 	MCU_WA_PARAM_CPU_UTIL = 0x0b,
 	MCU_WA_PARAM_RED = 0x0e,
+	MCU_WA_PARAM_WED_VERSION = 0x32,
 	MCU_WA_PARAM_RED_SETTING = 0x40,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 95b3dc96e4c4..e80bef2b33a1 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,8 +42,10 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(____mt76_poll_msec);
 
-int mt76_wcid_alloc(u32 *mask, int size)
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flag)
 {
+	int max = MT76_WED_WDS_MAX;
+	int min = MT76_WED_WDS_MIN;
 	int i, idx = 0, cur;
 
 	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
@@ -53,16 +55,45 @@ int mt76_wcid_alloc(u32 *mask, int size)
 
 		idx--;
 		cur = i * 32 + idx;
-		if (cur >= size)
+
+		switch (flag) {
+		case MT76_WED_ACTIVE:
+			if (cur >= min && cur < max)
+				continue;
+
+			if (cur >= size) {
+				u32 end = max - min - 1;
+
+				i = min / 32;
+				idx = ffs(~mask[i] & GENMASK(end, 0));
+				if (!idx)
+					goto error;
+				idx--;
+				cur = min + idx;
+			}
+
 			break;
+		case MT76_WED_WDS_ACTIVE:
+			if (cur < min)
+				continue;
+			if (cur >= max)
+				goto error;
+
+			break;
+		default:
+			if (cur >= size)
+				goto error;
+			break;
+		}
 
 		mask[i] |= BIT(idx);
 		return cur;
 	}
 
+error:
 	return -1;
 }
-EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
+EXPORT_SYMBOL_GPL(__mt76_wcid_alloc);
 
 int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 260965dde94c..fe95a847182e 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -27,7 +27,7 @@ enum {
 #define MT76_INCR(_var, _size) \
 	(_var = (((_var) + 1) % (_size)))
 
-int mt76_wcid_alloc(u32 *mask, int size);
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flags);
 
 static inline void
 mt76_wcid_mask_set(u32 *mask, int idx)
-- 
2.43.0


