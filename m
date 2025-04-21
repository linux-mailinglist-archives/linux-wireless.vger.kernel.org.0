Return-Path: <linux-wireless+bounces-21792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FAAA9526C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863DF7A36DB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9022612;
	Mon, 21 Apr 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cdcRMQ1o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010009.outbound.protection.outlook.com [52.103.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C9800;
	Mon, 21 Apr 2025 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244316; cv=fail; b=dwatI1mxjw9rYo93EynoxMu7cRBkXGi9qbuXImv790eDfq4Yo5p/LR7JL7zk2Dxx2NgWsEurMjboYr3SuiDxHLVU7dTI09Yg6uSPfQp+qXN5YOj2I7Vbr58+YRrKWUF/luqCkzFHEjVTixpvoYesGmi48Ivr6sy6l1PbauHXrcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244316; c=relaxed/simple;
	bh=UaJKJkZiJAph5LRws2/72BVkSFg8J/TYUkBPtzxoU/I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LbZxCkNNZrkKflcd+sEQ2nz3l3quOxdSWbT47coVd+pXezFarEkKHKVla80QzWYiG2ezeycufsKTKKBzsLJTYCtm1Fjzt88jRD+lGur9XxKLoyslxK1+uv+MigfMn4/Ax+/q6JjsE5YKJvhECo3mPVzjflmT2yCGnQ+1HnArnb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cdcRMQ1o; arc=fail smtp.client-ip=52.103.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtK1xgyidFVHwCMoYCfXmgLkspZHDYPgQNnGmO6j6kg731wMipH8D2aEUAFYYRngs6e8ne3aeFGc9GYkAxWx4LMJHlQR1KglpS3vwIWg/zFncYI0338Wn0vDsBGlOrAlto8VkI+BmJN+gq5bIjYXw8vMCaHiMQRmkuauY1370fRozttIltblUPezbRs1opI6ucW0YsBn3dqwuUvU02eNJAJIRRvImYVm7KwiNzZMfQy1ucLP92VUnJE2RB3J+svq6tAe0T8zkn4tnChHfrmol9okEINgJBg0F3QTVBaaY8Yj8mEzZ1zeMs923dMsWGCbiTcSHePAE3UYfXaV0aB2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRIsL7AuWochSBHQl19aNLtei9ojbuBN+CRI7MECEuY=;
 b=vOp2JDkAYm9hGgxagHEYmQ1uojxpjGS/QLVxw9vwM3hYG00WctrnMbe6lxhHe1NyekULZ5rKW1lEnWUVsl76px3nU21WK3tHfuCDSrEp5DCZU+G+wCeBcBQshR5e0R5Q6da6Dg680QsOY5ih8L5muLZlerFAoxkxzsqp7h/owDESgwacqryOyiwadN9JzRhGJIJdziy+qCfYK3myF1lwZPHpspfKh1VzbDODxlYIEDKDP/3IjL1ytHE1g6YQHa3qdDQWPWqot8NFiy6K2/beM0sfHwjDaVSzmkilR6WeyRxVcorrkJYqLjerNREVe7gZmJKH2v064TsKmONZBYXmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRIsL7AuWochSBHQl19aNLtei9ojbuBN+CRI7MECEuY=;
 b=cdcRMQ1oTC2db/fH3rhahF7UMs1NW8uBydSlPXUYLp5AgJhrFg2cYfMMfvHJRbGSBRARh11EGfiKYZCdkUvCeD3TMbuY+dFpOMe9gJpVgyVvKcaVAyGiYMYm7DHaqHBQ+Fq5N+nG8w1htc4SpmoB5xaB4zg9L7vObpGgLYIvvnG6GYHquzw4sxlwz2W0Ys9GVAObyEgC+v76+eI0p6+11nWRzjBFzcnImEmHig1+jlX9BBuUWhElUMDrjCfRhmPVTCfKOPS1MoTg1r7lg9UDs6Hv9UjWHIEf2NNL1XAmr1HS2MQlaqDZ0dcxWPlKJ9WhYrKgFFe4LOqhBSEMdi59LA==
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com (2603:1096:604:183::12)
 by TYYPR01MB15050.jpnprd01.prod.outlook.com (2603:1096:405:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Mon, 21 Apr
 2025 14:05:03 +0000
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7]) by OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7%5]) with mapi id 15.20.8655.022; Mon, 21 Apr 2025
 14:05:03 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	pkshih@realtek.com,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johannes.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	christophe.jaillet@wanadoo.fr,
	greearb@candelatech.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	deren.wu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	quic_adisi@quicinc.com,
	gustavoars@kernel.org,
	razvan.grigore@vampirebyte.ro,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	Bo Jiao <bo.jiao@mediatek.com>
Subject: [PATCH v10 RESEND] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Mon, 21 Apr 2025 22:04:57 +0800
Message-ID:
 <OSZPR01MB84342A0E21AAD111ED7AF6B198B82@OSZPR01MB8434.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To OSZPR01MB8434.jpnprd01.prod.outlook.com
 (2603:1096:604:183::12)
X-Microsoft-Original-Message-ID: <20250421140457.1221-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8434:EE_|TYYPR01MB15050:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c28306-4c48-485f-c853-08dd80dd82aa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|7092599003|5062599005|8060799006|461199028|440099028|3412199025|12091999003|41001999003|26104999006|19111999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jLN/at27f3ky2QZtSbLVK+zpGUbqFAUet9QWHmjNGZVnTPAcDJwPFOHNUoqB?=
 =?us-ascii?Q?H5yqE2OFvQY7mIvm6ih0cecwDWkk3hpcyswEJkLg1UgSB6FbjSQ1p/gb1bVD?=
 =?us-ascii?Q?3RPh1qTccIdFMaDbqg31G0iiKD+zjp/EQatVXyw8m7xqlt8Z6hk0JZQvHvTb?=
 =?us-ascii?Q?R63MfW4xCTsYBJAAjh8lQaeIpCIhuAM/BK2YQ/WDuFK7J++Oty4lxTIkomdX?=
 =?us-ascii?Q?vtbQ6M6C1qB9SkgtKhRxxlKAHeJCzM5A9corAHMqkSFADf70p/3MIhBFLi2+?=
 =?us-ascii?Q?DQeeMm+EpIW1FEoJ0mEgVIfqryWKeCYlHgxXTsaPlp1BYhLmxUmDbMGmrupZ?=
 =?us-ascii?Q?SKGCssz15KAFv0Gx6uleqzG52EinUTor6Wp4T8jD15q3P9DPLQv00OkogYGN?=
 =?us-ascii?Q?zm6lz9EdLRfWXZRbeQMo/Fn1MVIjahcooCZwnFIHo2FJQUdS9bsrHX99n5t3?=
 =?us-ascii?Q?XPwqZ9/EjV4dFUCY4SHr34u4igEJxgP/MwiIqKmyrVLCxnFKQgyR58ev63tB?=
 =?us-ascii?Q?SFu2nw8vePG7ylpxm2d4p3ZlqVR0CfUCEbv0oxV5KnccnAfljvj2FLDvozCw?=
 =?us-ascii?Q?6ehtXyh0DajMZaHuIEeniBu7pICKTJ2yID6KK2cvy861ZmaN5Oo9Dv0P9OtJ?=
 =?us-ascii?Q?01M2cB2uM3Me0qoVPbic6ajZDDyVOjPc07gJZJ06fTRGCZe9YIJN1sLggGhT?=
 =?us-ascii?Q?N7IS7AODXNIgwzKzFzkn+OOD+gLwT30K9Jundq/fbwyAtION/+tmQJXlgEMJ?=
 =?us-ascii?Q?zFXSDe4VPjior+j9vpIfrMeXXS4PodPguTtCL8VO9EBPP66B1jGBsIQOjPos?=
 =?us-ascii?Q?POfMsrsVaEbpERU6dQaorau74R3b+dnZkl1RLMXnA1ACeS864SOfrndYPkdc?=
 =?us-ascii?Q?2u2D/Ycs+AA0i9MMf6rtMrT28KIPNCQEoW7yvn9TY+C/s/NAar96HzvXAZT5?=
 =?us-ascii?Q?BV1Br/ItEKSzA1wddugjQoaMQ9oP2nw+GcW3xW1cW2cXdvm6DXBzV8enjgjk?=
 =?us-ascii?Q?6PK2jMO1qowGLhGOEv7Hr43kO9yU029w4ZRKuBe6TqYiW4gJ7aQVk595U4Fo?=
 =?us-ascii?Q?9Maoy4P7T52NaIE10Oq3qNZ8nWsWPLRCfwP6+IKA5XgrUq8N84EcVf8ULfuf?=
 =?us-ascii?Q?gekZYfHWOcfWnth/18EufbbLZ8NYQQjXIXu7xhEH3hd4WQwdZmiB6NQFKOmk?=
 =?us-ascii?Q?VongbHZKIch9+Wg7JIzFieJKT67EFU9WahGnL0UpfH9HUcMnpnVmpgul5i3K?=
 =?us-ascii?Q?b+atzXztSlN4egAzf+nL4JozrKUdMKR1V66+D6tncwbRamAHXsEOD5WeRY0w?=
 =?us-ascii?Q?ock=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRz+z1LZ74BG6OURyyp5bJv0m4v/J2eyUGZhweThrLvmaZC8MO8gb0+W0Hws?=
 =?us-ascii?Q?VOW4wjUWVfuWpi2CVor+7aBLMeu1eOhRVVCUKZGPEqxT/4Awvrt7ALAm7WXw?=
 =?us-ascii?Q?QIr/dVn2HHxwBnOSCa6j7zIFpdWjrF8ufz4K0pis8q8vXjSRadL4fEQ1e2Qf?=
 =?us-ascii?Q?Cl+SCK4xsF2Jwy73Qk5HlgxDW6hb2KUVR1V7VW1Vd8+jijcGmrb6lU0Fb1ml?=
 =?us-ascii?Q?XyZvHkhvOMLZR+lYTpChy7+XjomUalC7Cqka5hlRWKOCqpWxEBtLvcOuf2mD?=
 =?us-ascii?Q?5AxItbQFL6RXfluesLRz8RRleY7xThTH28vRYfoUnqH+8OsxPe9xaj3kXv9m?=
 =?us-ascii?Q?lxGqfT0kX0okD0tV1jNQUCEGJATCeGy2547Si1EZtgxUC7NfjayrT7ExS2vW?=
 =?us-ascii?Q?YNDZrrLnwPXtoeKrvLFGyONRnm9hlYUuVS0Oi38xHq/rMHutgpNcrOTlx3bR?=
 =?us-ascii?Q?XlPQCfKnt7+9rWrA8GUX5TKw4+8UZXpc99kWv/J+v7dRIs9GPk1RA0XJZuSt?=
 =?us-ascii?Q?3iTVSU59r6jemvAf5osRuelTw4cq8u2InLjxBmGsq3fNPfUgio2kgKwbjnfS?=
 =?us-ascii?Q?X2W+MoN7Jsz84EY9QfhoIjJ7/mevgHqx5iiaJgraDgAyh6aiJdRI30An+c6q?=
 =?us-ascii?Q?QgIcVB+XuFZ01bCLkGTGXR07lSeJm5hU6lPzYMMatYeQgtCnSP0qKtfOxWL6?=
 =?us-ascii?Q?zSA75l3ODXpLRg1p1sXmk6CSHvjX1YHzMsPbxoLfkmR0K6qiFTCf2dapjJbd?=
 =?us-ascii?Q?PxKnr1VUtRHAKuFr8iFE96KH60CXnMbDiAAUmP+TqT1omHuZQrhYcf7iJp8g?=
 =?us-ascii?Q?P5mQp80Ldu8tPxCK9UB74CnNrQVQS1x3Gp5b/4q2ha8vMr0czLP+d9acfnIs?=
 =?us-ascii?Q?Hd5fXEhvF3Z1jmAk8hkg5GIGAs/bz0NWU7DvRzZuDhVEb+kdIApZey4pSk1Q?=
 =?us-ascii?Q?T6mBAuFmwgSeGv/5eEtMlKOII3LFn08u2JkKF6gTSTRf6/23Vw/v+RLfweu4?=
 =?us-ascii?Q?GrRHIqAfYUDo3JwvMhfNW9MvkmRZO7gc9avQPi2ZoGsHqlSa+tPcFp1KqaLL?=
 =?us-ascii?Q?T819zWzYuTrtzLQdnAJKWkOnKR2DqobNEQsnkzWTYVJ9YLR8QoDv6uX8CrPO?=
 =?us-ascii?Q?V0ei3E3wZ0fYvPD14Z1ZqVhaSCABLjPncTOz4cbMCD1zOPibtvDyW7j0Oixc?=
 =?us-ascii?Q?x/VCS3/Klz2a3iVP5d/NW9r6TVlUVWGE86OF7B0KfUquu/1U7t0j1xPt5LM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c28306-4c48-485f-c853-08dd80dd82aa
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8434.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 14:05:02.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15050

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


