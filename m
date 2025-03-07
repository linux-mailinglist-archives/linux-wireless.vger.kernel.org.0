Return-Path: <linux-wireless+bounces-20005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F95A57035
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C891719A1
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 18:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60923A9A5;
	Fri,  7 Mar 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vHW2aXRO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010007.outbound.protection.outlook.com [52.103.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C9192B8A;
	Fri,  7 Mar 2025 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371224; cv=fail; b=VlGemhOOW0VaXpBV5wGvbHYyUbP3WxY2vqIMc1hpw207Wa4p7KttwrSwFOLBFd+tJBTHo0d47fEMhhMUOXWRzRVuEVEEtnY9ZscJEaCKOPGPnCe730LNHMRL8VAZlszViPK94sIYXPBZPN0RbTPFGeXPUfZVOPzOSrFnhLWii5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371224; c=relaxed/simple;
	bh=g79WNZ17gJ/h6lxO1k3rphuscz/g6+qMI9fgxntWs/I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Arm5bfdlZQoPGsxtrJbtftZV5v+0auKzVrSUTGvbAj78OAkh1bLX8kPV/NBn5eGFqI/hDARFdELwQuso+MycVB51VH4WRXjaOSSISv9LiY7kkDY9wBAedDJYu7Yt43JNEPCSK7W7GsVt3yTU1KOLqNlTmh5uplGZRphCx/VHJKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vHW2aXRO; arc=fail smtp.client-ip=52.103.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKgVYJc8eXeKz+1+Cqi+4DgToaRTuaucRioSIwczmwAYkBlcjZTtXwDNQIQf1L2+4+9cps1p/Co/uRIvbp/N94yUkGMlRFpPm89uA64pjIOsN41BG92zfrNeGhiyOfX9dq9Kw6o9rABfsIedWG2iwLoDY1upUKid8OScT1LGFB++r9HC0PKIUj9Myr6bOX1k2q1+F9WDHeTwd8VjjbKT1uRls0q99GPb1mALK+yCV46syOwttbWsRQw05fTn3hIfZzKwrzDO2+ZmSJGTfKKpAKvIAv0sO68DQUS+wAwm1ceG8a8ZFr+XWFB9Jq/ackkjp/JD/qvxBWtgGHAwXFLeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4ePzwdCHg1j2xs5FDUVg98gV+GOeb4l8I5FVGkwgQo=;
 b=BYKPXSmBoD+D4mASqwb5YrvUInPcsGLQtS7udhuYUGnNYIPRWRuFLuTpPNsEPTtpqz6Rc4mx95GkeKNAn8C1+Vxa9wTPwNCqGfViBkLi0J9GZF8F75Va6vckIdoxbDLH+dfJfqxR9k91qwnQoUKaJUFttH0Om1ZBk13XB5ErW2yvaFEuOubp16u5/q7RcyyQHqY399rEg7I6YgXEa2RvX6yu3fiJ3h35G42/F81Lwzwer6QK997uq6UoLB2tgqcEeWdOb4elrhdpC3ndNNjaRZ2AMW+imAnNfwNnTj5yQzyODJrf4hiXM47GQPoa323qjo9qshKYLZFzdHkQttAPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4ePzwdCHg1j2xs5FDUVg98gV+GOeb4l8I5FVGkwgQo=;
 b=vHW2aXROm53y/V0Rs38frB2zmT+mLqrux3IX+T+/3qE9Bs8q3bKt+WKCT4Fohil3M879WBgdp2TMKTmF9UJcX7itJqUkLqgcAADm+fjthfT1iswKIjko31sBaeEqM/5GZmyW7cW6aX1CAb3L/R6BK4DokUIuEehoXqZtkcJnXfKf4GL8Gu93MSnkIjPOShZUhjWqEcLQcu3tYnfOj5QmfcrGNs36UXSP67CXCZBgroKFY+TfWq+5Rtuqa70t4XlZO1/nWxUmg6Bqf+7JOkFI36mluTVZCbpiIfmTW6b2jkqOGe4rcZ9Zlmuk1EMobxaLWoL0Qd+rNlHjpfuoM2M6Eg==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYYPR01MB15150.jpnprd01.prod.outlook.com (2603:1096:405:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 18:13:37 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 18:13:37 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	pkshih@realtek.com,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	miriam.rachel.korenblit@intel.com,
	michael-cy.lee@mediatek.com,
	sujuan.chen@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	emmanuel.grumbach@intel.com,
	howard-yh.hsu@mediatek.com,
	nicolas.cavallari@green-communications.fr,
	chui-hao.chiu@mediatek.com,
	quic_adisi@quicinc.com,
	deren.wu@mediatek.com,
	gustavoars@kernel.org,
	bo.jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v9] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Sat,  8 Mar 2025 02:13:31 +0800
Message-ID:
 <TYCPR01MB8437EEEB9227381FAB0BD7D998D52@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::33) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250307181331.18355-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYYPR01MB15150:EE_
X-MS-Office365-Filtering-Correlation-Id: b65677fc-7ca7-4ff5-c6db-08dd5da3c7bf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|15080799006|7092599003|461199028|8060799006|5062599005|3412199025|440099028|41001999003|12091999003|19111999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADv0HJAVZzbolQ4TY1I4Jj0ADPnfssQgEtwZvDo73YHs1IHncXmjtQ0tg2Wf?=
 =?us-ascii?Q?+uTY03KCRBJ5+iIjdgB4RWRjeoU7DhWAXQlzrHBEufd1FA8je2lSuuNyZaiM?=
 =?us-ascii?Q?omKNL+l2tKEBsyyYIR3bg/4SS/o6OEU+zz8cfaEKXTkYpqAbr5OdrMeiXt27?=
 =?us-ascii?Q?WzZpTsvnHWk8Xq5NMjoCt8PX9Ch02m1HBPB8TN36y6g/SwyK3zYUkmL3R4oa?=
 =?us-ascii?Q?Cf+YOscJLkPtEtrN7beoKFzfSewm2bEVWO4//n5/4ASCNamNuZx/1GdIcvZt?=
 =?us-ascii?Q?zPr9y+Z6Np1CUW9T61Navdtzh/FHzrnIK6Zljha2vGXha3L4HLW4Yb00yrWJ?=
 =?us-ascii?Q?lQAyuDlrQFAhC6ss8o4p4QmujwD61nahWqmC/m0FVAvyJ51BVby3cBCmSuYA?=
 =?us-ascii?Q?PZdCgiNZyQCU6njpFVNbjpTWeVPJPykeLoZRsk6u+Lf6PfNWUkDOnPsCVZvL?=
 =?us-ascii?Q?sgumkFHAX0ADIyXhiH5/Ef/Tb6Zit40XE3WFXZSh6f/R4yXUvmOn16LNROBs?=
 =?us-ascii?Q?umF0F1mdD6K+5zBoM7NT9OYY13LwrKerTyI1sxup0a4A53a1EPgcJe+Da659?=
 =?us-ascii?Q?6dHTIvQhJ41/bsM6kvIw0tBvFiVhon98Wd5WNMOWnhR3lbf757qCeaALG6q3?=
 =?us-ascii?Q?e0t8mhOK4S0ErYOvBlHhgPDK7hF33+bg8PoFQIK1QzmQSm/PEHhmlTifbyGa?=
 =?us-ascii?Q?St2voDsfWGNAQikmUwoDqsWrKPazRDAeleurT44bD6iuZ96JNBQvS6dZkrkX?=
 =?us-ascii?Q?34GThPW6OuS/wn3RgBK0z8I1liRta6P7wJinx00WMOdwoH5cGMatbJUjDx97?=
 =?us-ascii?Q?C+cfPzew9799s3mei6op55vgXG/lRwCDCogDOIh3U11PvyfXQacz21V74+gz?=
 =?us-ascii?Q?22mO5MTpds87TM9Sjr393Twi3ErcazH6UkKATtdCSqIzc3mgeldMeHgQFqvT?=
 =?us-ascii?Q?azyKVAYwRx9HLhCAp2FW6ddJ5ocdLmjMLaoShShmDetRseWQTznGCV1q7mZO?=
 =?us-ascii?Q?0VfqjXbAdtAihG+X32NbWS2k3L9eaRBBu2O/mjGVmyAg98NM+G6DSiVOyIfF?=
 =?us-ascii?Q?wzPFHRlfyBEapv39dTtb+D1srGy1ackJ3XpRXn+fOC2M3l9Skx/wYpKXJRE3?=
 =?us-ascii?Q?Xr31bV2B9sxhx1OPCkcWhmKt+Yy6kin6bPkpBdWM/ZK+RY5WM/7mFbnKNjSB?=
 =?us-ascii?Q?69ij2O0DpO874yseTGijStdNWbAKTuANwad3ZImmyNAHmuTX1Pj+X+5Gb+8?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tmaLMiSyrPNssjQtEkv3MQj9wzTLQ4JhqrsLsUzyCjeXFKEyMjasd4aYEsdP?=
 =?us-ascii?Q?ptuiNPmsjJrmir4VdpM+nTYB1e1WBLEvnVVTVc5obS4XRkPiLokBwAtE60eJ?=
 =?us-ascii?Q?+fmF/ne/GkTpxjCSOwrJFYDLb/vKchQGI5/yc3WuaRVOUl779xrbbv5txYwv?=
 =?us-ascii?Q?xndp3UJhA519mWE9kDlHr4SjPotetE2cha23MFBw1JKh30MPrajaIwycGgsH?=
 =?us-ascii?Q?Km1lAcCpgqMMnqoAhS5ZgyHZVx/MxHVk2/CqoWL48xv9s2S+0J/VsGnt+qI2?=
 =?us-ascii?Q?B75ubVblns+PZz43lU1lTSg0Jt3pWdDgJ6Q1OZtBzSS3eX0l/r4xg14RIpdS?=
 =?us-ascii?Q?xFghe3XLfl7TCFHcz2J7+NGBJshBWlbxS0ftXEAZ2+2+vg2wrqOqlsj+u9W9?=
 =?us-ascii?Q?ixrAwj6+PTVMegVWIP1nMeg2XSUiAQs0HDCXZievRIAY6rmt0hOyDMJtuCwR?=
 =?us-ascii?Q?vjAAkwBWMDUmzepYk5w1vX6ZeD2988UEtb638A4crnXo8bvgxob3ak+mc3Ty?=
 =?us-ascii?Q?QRVCIpaRR763S+/X9eFfsXW0IKHnLCguPI+LwUIK88k3/88TKa4RvBEiytDX?=
 =?us-ascii?Q?yOuEW9nP08FzfObWInVauPd952SM6O7uGzYHlZdQlRJtptb7pO/Dj5HKM6Ad?=
 =?us-ascii?Q?P/dZphMukK0j1CpKPEBMHVE4UUJmgkRIpFcUV9Hpyoq0rHPIgIHB17WusPUh?=
 =?us-ascii?Q?KZPP3Rem+JM8HfgTMDS10onh5VzGn81Ozk6PEsMUblCRwSJkdjnjfMlMpIjC?=
 =?us-ascii?Q?GWhTM+JQUtGsbkp+TAp+ORmi+y3vkXu6T41pn5S+wxGMW6eICK2E6U+jb0IM?=
 =?us-ascii?Q?Af6uditnQrjAvFWYInZorEjWod+ux8jqEKLzmenJpF7RfPGtz0ukaPai0UCx?=
 =?us-ascii?Q?D1/i6WKgcpSN/Z1klGXmT3m14hDjAwwd6nWOHt1jZyYZsuFEa4IHl3fqO5fV?=
 =?us-ascii?Q?4+k5J2cbftZL+fb73KIouzGdiUIZZsIJvMEDhe70s/GMFT0CuPSypS5mI27d?=
 =?us-ascii?Q?H/a48/RdLJXKvoD5PmxP+8IFmGHuwS7vXX5ogsIkiJKzJjwMyfpcMVCkdDaJ?=
 =?us-ascii?Q?YiTpbTNX6ZIwXQbXBamkdhe6tcJFfPn9iqOirdo+qQ2rTNXt7mf9zwfcvcIK?=
 =?us-ascii?Q?aeoVbdaWgbK8apCCmbMVgI8sVNbsFSafp2nZK1fqx9K0Aieui7oL7WsOGNKb?=
 =?us-ascii?Q?A3+ONaeKpGQrpuT10JWMabLNvXCHq84vTAwbjW+362W3NaGauul3oGeCMwCA?=
 =?us-ascii?Q?AIaYhsQ0x25GzlnefQYbZEu6enWB+95g/iBBkKE9eKlDsaZg+OT3jq9VdKR/?=
 =?us-ascii?Q?sTs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65677fc-7ca7-4ff5-c6db-08dd5da3c7bf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:13:37.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15150

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
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 ++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 51 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 18 +++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 ++++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  7 ++-
 6 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b1070..638ee9fae0c73 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6a..c951675f907b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
+#include "linux/fortify-string.h"
 #include <linux/etherdevice.h>
 #include <linux/platform_device.h>
 #include <linux/pci.h>
@@ -745,8 +746,15 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
 	int idx;
+	u8 flags = MT76_WED_DEFAULT;
 
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
 
@@ -1271,6 +1279,11 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
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
@@ -1280,6 +1293,34 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	if (!msta->wcid.sta)
 		return;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76) &&
+	    (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
+		pre_sta = kmemdup(sta, sizeof(*sta) + sizeof(*msta), GFP_KERNEL | __GFP_ZERO);
+		pre_msta = (struct mt7915_sta *)pre_sta->drv_priv;
+
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+			MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+
+		tmp_idx = __mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA, flags);
+		if (tmp_idx == -1)
+			goto error;
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
+error:
+		kfree(pre_sta);
+	}
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1726,15 +1767,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
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
index 9d790f234e82c..32c5aa1a361e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2385,10 +2385,20 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 
 	mt76_connac_mcu_del_wtbl_all(&dev->mt76);
 
-	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
-	     is_mt7915(&dev->mt76)) ||
-	    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
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
index 49476a4182fd1..c3dd0cb4a5d38 100644
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
index 95b3dc96e4c45..7fac9c79ebdf3 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -42,9 +42,11 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(____mt76_poll_msec);
 
-int mt76_wcid_alloc(u32 *mask, int size)
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flag)
 {
 	int i, idx = 0, cur;
+	int min = MT76_WED_WDS_MIN;
+	int max = MT76_WED_WDS_MAX;
 
 	for (i = 0; i < DIV_ROUND_UP(size, 32); i++) {
 		idx = ffs(~mask[i]);
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
index 260965dde94cf..99b7263c0a205 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -27,7 +27,12 @@ enum {
 #define MT76_INCR(_var, _size) \
 	(_var = (((_var) + 1) % (_size)))
 
-int mt76_wcid_alloc(u32 *mask, int size);
+int __mt76_wcid_alloc(u32 *mask, int size, u8 flags);
+
+static inline int mt76_wcid_alloc(u32 *mask, int size)
+{
+	return __mt76_wcid_alloc(mask, size, 0);
+}
 
 static inline void
 mt76_wcid_mask_set(u32 *mask, int idx)
-- 
2.48.1


