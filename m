Return-Path: <linux-wireless+bounces-20134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F324A5B888
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 06:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1BD3AB24B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 05:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8D1EB9E5;
	Tue, 11 Mar 2025 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ko0Y01iN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011027.outbound.protection.outlook.com [52.103.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625991E9B1A;
	Tue, 11 Mar 2025 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670964; cv=fail; b=uWwGOVi456Qi+RAOC4NjE+++HM4wFdLmoT6KNh8L/VB9gUWR56qQU0z2/qcAYklADTAxTZq/dFYWzkXRRWjUULquMHbsPFvdan6l0zpIUrTiro+iHkkcNCcTZ3ns2Ur2wgJT60dX6YqfnxEfIEpUiOklfntOIC9nMPVsaRdYGng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670964; c=relaxed/simple;
	bh=JtpVUSlZlyhuY4xpsBT1eUOAGVEAukMOk4Rphlgxurg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dZordMxXFxPNGSGfS1PJQoRziEYcTvTnWaeRv8fvlu8ExouZe3VRIHANWMMrOoPVuColgt7RIw67SnL1o2gOUfYUxq5P/Ip1ETACAdm41UPwF1CC3h1Eu5xBV4kHLX4BXUy1kipA6TMzo4z9sozqGLOXs4tlGXejVsZAn3aDAR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ko0Y01iN; arc=fail smtp.client-ip=52.103.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyRQjhOdMLLtB/Bm7h9kHlqC4wkVHH4MAJL6qrlJ2GlXwsNOzlIGsFw6eGfN+/XrLgx2e5+YslnSxoueGmSoMDPV+kONuHututHKD/tb2Ax/8PJsWMg0fzTwgwlH/9imQou01be/ULZXnPAR/+cldEubJwpv9W98XIPcqeoayr3qTkCDWlbA8fX/ti1/M30oQNVKC7Y4BMyl7DmIlCpi/h/RkbvO/mpmZzJ9GS5nnx6fzuchF0EvtnouibBD/4m1rlZq4NmKLXHVuyuJosyjV3B32VPoJhKv9DoWGstg+kj1AFfPVvqVZSUC6X6wmINCKRruUTfqK+uqwLEWNRlANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vYfCshVrGXk/Z65lIGFK8q4umen+cwFMLUrR4l/KP4=;
 b=rcCNvPmuVS7N7dtdRW4ad70N8cWWVtYkRc+kao2p1z0S+iJCMtS7JrS/cGgj31tm1Dex3Ecww/ICl95wcR2/qWtQ1VZoIm34F8/lA+jv29U+ezVyrELgJG+xevSqjgLkrcdueEKA4QwXxUBBKwVnAmVGs9Lv0fGchXkK9K2N4mpqq7MlhY/JOd4eRzSfwf7Prja240dyY8nbWOB35CGrhIAZagEah/9KTfW40I3jixXyEaH7ThYFCk4VoxUUZ6jT7+W92AFyuPnHeBp+faEPaOzI41sBPWKOg3qXNB7yj/Fy3ojYDwVFhpe8jp+0RYy0TuW016fwT0kAfx2tFbbVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vYfCshVrGXk/Z65lIGFK8q4umen+cwFMLUrR4l/KP4=;
 b=ko0Y01iNxOeK9YfPF8wpFZ2O5nsntM0s4C1JODhcuHpvA+acDa2wcee06bwvimQpuJPJ5ITbjqPWf0mZOgyKXYrHrbhBxKUCj0Xd9ncWNy2az/sGTW4KDIxKB3G/vsSrcflvRmfY8IGeeBJ5+6tRkPMBEoYFk5nZkk8yozruSVZo9A1igZBbT2fSxm1Z1EbYe0ScfM7d0UbwWgg+5uJYN0CVNFHJrTZCHuM+rkQ7OSOZ/hcaEXBD9iJFYnl3j+kflWN7lKI2kOhDKotYy4Jv60LZ0DsjCuTWkIiz08+Y4Of8BMFNSrcFmn86gx9ePcZwP4yCh30koAXcPWDIGitL1A==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS3PR01MB7407.jpnprd01.prod.outlook.com (2603:1096:604:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 05:29:16 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 05:29:16 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	pkshih@realtek.com,
	angelogioacchino.delregno@collabora.com,
	miriam.rachel.korenblit@intel.com,
	greearb@candelatech.com,
	michael-cy.lee@mediatek.com,
	nicolas.cavallari@green-communications.fr,
	emmanuel.grumbach@intel.com,
	christophe.jaillet@wanadoo.fr,
	mingyen.hsieh@mediatek.com,
	chui-hao.chiu@mediatek.com,
	quic_adisi@quicinc.com,
	gustavoars@kernel.org,
	sujuan.chen@mediatek.com,
	bo.jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v10] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Tue, 11 Mar 2025 13:29:03 +0800
Message-ID:
 <TYCPR01MB84376878FE505F773182062B98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250311052903.96382-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS3PR01MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 1731f785-1258-4a1a-99cc-08dd605daa5d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|7092599003|461199028|15080799006|5072599009|5062599005|19110799003|440099028|3412199025|41001999003|12091999003|19111999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pej006bMjuUmYdB14BQ6qvrmr5raj6IHRfPuVewuZu12P92uZq7rOy1Zxf1S?=
 =?us-ascii?Q?XG5As1FPEEQZKdM7kBrruO46SXNfj+on6U0vwf4NoZrozDGqPanDUJL3FxsW?=
 =?us-ascii?Q?1Mz9zJzuniDk444Taj9FepluiotgOXX4LICLm2VCI9T1zbAAY7jE9sbOjchV?=
 =?us-ascii?Q?oZLy2PNWg6HmPQwoR65gZQyC5hgsWhlsf/RmHyOb1wmPLFzGucg6b6yrWbWK?=
 =?us-ascii?Q?tpo0SOXwEXa/QEhYgnMdG0zyaXGrvnCIasZ+FVoFhy23F7G1j68kXbYM/KoD?=
 =?us-ascii?Q?Nce2pdsAhH5yWuT6J4i20XG14vnoSDPMxMc7Yywq+xA+IOplEkZ4+NTo+XlS?=
 =?us-ascii?Q?cVHha7rueKh0inT2iuXdUscImR7U49Z+HdMMycS/IYg0EHSElORH0yC6n4Gl?=
 =?us-ascii?Q?OI9J6LuEOq23m34DOJI4FabFGAbJjWaOQI0Yf5CWFPkznXdc4vtxWHK7D/pZ?=
 =?us-ascii?Q?tYnVp0LRxpqZf1+ifBHc1cvSAsMYUUjdxpPWAVpOi/EZdK3dUuVB0ylcMZzj?=
 =?us-ascii?Q?AM4SjykED/+DqmyYNwu2Aw/FJR5E9ExgEFR7Ys5Bkg3A3/qooab7KNdNcdeo?=
 =?us-ascii?Q?zMnY7yRkMoWyYS6Id5SA+Xgd6PYo64Q0nghU7j9fqlonMjuLc0/MeW+c8Ghq?=
 =?us-ascii?Q?DKrgsYaqJ1Ye+BFaLKzi6kFncswUk+OvYZEQwWS7vDsx0etl8aBsvDPdtI4K?=
 =?us-ascii?Q?s3pUaowYqmglrL40CydMY2khT18IRNRol3F+mesXAzcpnYzu7opL4GsTlxpS?=
 =?us-ascii?Q?eEzBxIEZHk8HhLClxWJvuPSxu+GdyboZ4IdqQP5x73BO6pv86YnzS6C77bvj?=
 =?us-ascii?Q?QLWNFJPQ+93FGnpHqn7XW3nZ1d4rOQatv5Svd0fcJy9z4QSjhKXJ6xTMXPHG?=
 =?us-ascii?Q?HSx7plssMJUDaip4jJg4vFrn5G8MQr/fmW5kdQiFZBI8Oe77OdFK9GZ4FKwz?=
 =?us-ascii?Q?lDf8I9cUzdb6LMsD8zcMo2+o++u5VEdxQZLozhuZzQ5CA4mimvIZSJ53NvHk?=
 =?us-ascii?Q?PMCNsFDMKWq1+CZfizTl5UzUXaU6lyxj/jzdYOyUZA8SRop9NVgLvQaYbI9y?=
 =?us-ascii?Q?jmzn1L0pv5FfTnt8GDIPb0qX+4xmqottBbMCExdW3UT+B8Q3miQ7om72YcAh?=
 =?us-ascii?Q?H+cj7/X+UghucVncC1ySEvfVrdFT8nxQA8UUu6ZLDgF/BIy+52cN1ecUL5b4?=
 =?us-ascii?Q?hm56nGLHzAv+mrSZK33kTav4aMcVUjO0MZfo9NIXh7DO+moVJz2oC4rUYlE?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GoGoP7GL4ev6DGD7BplL0S/bldlQWx4co7HT8OBJoh0t5hjl9iV5n27YDUWZ?=
 =?us-ascii?Q?8nXNhO6qsknyZPJnk67uXnfCf1q1+8Rfm4k4MJkvMpZHH9T686WfVwOyiM18?=
 =?us-ascii?Q?S7y4jedpmCVLmcGT9ne57E9VffXrBKtMtO35SFXSKXahbMnqKrzaWUaOqD1J?=
 =?us-ascii?Q?dnuqMMvwg3y2F75qh7TwPEgPxqzqNuUM9BQH/d6O8g1oykKzcK7cJmL4sKs+?=
 =?us-ascii?Q?OHUPRZmLYJkjl2jjnJFkH1854k4gQ/BL6CAnfVsMB4fjk3Wmy3jDQrLo3G1c?=
 =?us-ascii?Q?/Q8X7Ue2bvOJMSFo2Q1qvWjHohZeaY59e4bAFy9Tc9mP0Q4yTwsEutczWfMj?=
 =?us-ascii?Q?qr+mXC9Ec8Pa3+SX4LXIzWJZF13kllH2XY3T8mU5U8ovjTEGVR+jMcuOCiYP?=
 =?us-ascii?Q?fCWjVa1+w9xAxx6d+vS4IflB3s5GL/o57751IeUPKRBSliOL/46gGuW0kDNO?=
 =?us-ascii?Q?LQnynar5s+eI0XieeQ+UQunAsWF29CMhYsdSj860E2uT4fGfxpNUS98csUWh?=
 =?us-ascii?Q?XKcwsR/sUSP0a1b/z/MUgw+AbkkU/qo+Mje4B/J4vWfCW6izsci6RqfWnGSq?=
 =?us-ascii?Q?h4rIOgOWlkSA1aEOhrP0InOE58FEzbtUA0QFTL7zpK6cMtuuVVrAbmCTVi1R?=
 =?us-ascii?Q?xxaIu35/6R0C9lsh0LCp9mspCC5kPKH9KoXjj2NzCFw56AB0/32PBkwtop08?=
 =?us-ascii?Q?WWIdl61Mu2L6N7ujEviTEi+qaunhmOd8eu0iHEiLJNni3VyqIcRfprXtPBjL?=
 =?us-ascii?Q?h5G49nspw6FtcC9sGYgLkVilJEcXszeRltowxf+WGxdMjlvZ0NnGPRRjN2dE?=
 =?us-ascii?Q?bTyv+/ZxrIY5sx96/Wqhy88Y9jDqkO4ipQhN+WBp5YfDTEcd0QpVGX7JQzRo?=
 =?us-ascii?Q?bAUQ4I3WvP78ta9M72aOEnZAo01lckUrSsVh5ukn6HMhkJZVdv4R0QvJmXkG?=
 =?us-ascii?Q?GJ5sOXj7Rgf4eugnjtWMoxjSz6ynzLLvALXi2Z4olOKPf1Hc23OkAmVbEJJO?=
 =?us-ascii?Q?or3TgdopZf/vczRBORtKxW6ZRuMel0EhSzm5aQgkRCTqxflUWc84aZxlDIhb?=
 =?us-ascii?Q?vvAQ/ZG/ViJmO9HVTAr+QaL3+xAzHzwWH6WpEDq373+St1vHatN9DRW2Fbyc?=
 =?us-ascii?Q?wREKNNQhUfdzN4YBFmblrWG0aGB0PehGu1vYvOTvOCz8anHk61Vy+clJbo1J?=
 =?us-ascii?Q?7BGbZ8AHGvOwFvzN08Fo3bwzGLvSl7AAT9JsDOdT5BfviqrQ4/5vqTealw6A?=
 =?us-ascii?Q?KNDB1s1lI6AzjKLoE4mlyTShxQdoE64+kYSV3VtVEG3pC5tIyt3sWD/qvRLx?=
 =?us-ascii?Q?RtY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1731f785-1258-4a1a-99cc-08dd605daa5d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 05:29:16.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7407

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
index 132148f7b107..f9f11ce1f3fc 100644
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
@@ -1165,6 +1174,12 @@ void mt76_wed_dma_reset(struct mt76_dev *dev);
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
index 9d790f234e82..191f966c3f32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2385,10 +2385,20 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 
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
index 49476a4182fd..c3dd0cb4a5d3 100644
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
2.48.1


