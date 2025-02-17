Return-Path: <linux-wireless+bounces-19027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B34A37976
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 02:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893881676D2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED3C944E;
	Mon, 17 Feb 2025 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rE+z0Hnz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010002.outbound.protection.outlook.com [52.103.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF2847B;
	Mon, 17 Feb 2025 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739755886; cv=fail; b=BSn/M8dlsh1lkJvNNKoZKrY2F8etX/w+/yiDXRDwuVSseMTJKWKvwWEO8bkhlsGgCJmlNUvB7N/em2fChg/l5pErX6G77R5XZStE1t4S/MuEuZl0xQUBwCCqNq80xCWOObpd1APPM/E/XXwYjhX5EMHUgV5IoFSUiHfKeebgaDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739755886; c=relaxed/simple;
	bh=DQFQJbirAtJq/VG1Bli/hh4kWPO/LHTFHv49G7dF4MY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gz76S8BHjMQ6egn5WBWsMedxSVCrFA8Vzqn44fwH4W8bmMu+8mS+9NPI1TeNRN/eBSoSUnMjCBG8/LRAlPI0+eqGyx1VjJUqgzMmsGIm0+RG/qH+DRfDG0WC6NfHw40xMO9IBLd3+fuF4NBJI4ZFmzQTg9GodISAblxF7KvMYAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rE+z0Hnz; arc=fail smtp.client-ip=52.103.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+OnqEYjqGQhFNCGdkGbqDCAhY7MyoiYr7U6nhilzMOgUaRIcDZq59MusDB8SMA7LH1y+ssU/OwO058JG8MDvVvzAk8v/v4VQ873irdUO2vRyIdS/WXyXgnrBledcVCF8ZViRprF8TUcHLyaOWwzNrQSsJiN/Rjp6MpgtKS99ypyVmTKEfPtINEh5NRyJykcTPADz/6TXBruuvk586Zzuso15ZEx3e87apnIUMiQW4hYGXevwa3MoozUiqRVWTdOJTHvEGsp9VK5l/bT3usbCwLR0LAvcK2MuSmJhomRCCSSE8FburSgW90n3ycZv+nBy4ApG+SzXI2LQ/3BNQLZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwayPmoXlOJEZW5J0oJYVpzMJDaIbRa3Etu7G1dG2ZM=;
 b=BKaxwO2WUdPKwf1wxbuWgRIHtrvPt0siVluRqf67bl0LgWfJ3cQMxz6YEAdslHwjhzkbquzM80PTMshiQuMdflAShukwEn4ymo7y9RfJAYvivi/+otMkAYE0fu+RqIGfdV+0iSotfAdumd9wKyo9E4ZV+dG1DKBQWPX16rJHrn9sg+hMbkePCUrDJHuAws7kZetsIzJ5B34up8jrMFbPxpqV1AkaatyQFRCeYUkDlTZKiql4E8msrUcTeuPOTqv3o1CrBtNoq+6PVLcDaNwdWsv/GqeVkZRERV6gOKPCyMheu50l0fiX6bwcXDTKWXh8gDOxZxT3mBJwnxKtGA1RWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwayPmoXlOJEZW5J0oJYVpzMJDaIbRa3Etu7G1dG2ZM=;
 b=rE+z0HnztWgW5iOEZrwtlP/blpZbWqX92vw6vJizcvY8Qvyu+f2GVcfm0xh+S+nK4P4ySggOw6usmZHxhO8zdK4hKGtoZNV9oJc27YR8upP9WIwAyVI/ejUb9bcopYpUlL+cCmdkL7pxAsLIp36+uTFuDTu0fhEp3oq+5/kKgn9jyvCQm4/9cmfLzQb5XPKq9/7AQZ5u5e7qBf2cv+N4puo1lNmPEWhvkkOGmuGxLG+wO6w1trMRNWErkiN6Ui28unxeXLazyw2o7gB8UNK6WCnO+N/SkFCJIvfrXDSbgpy096ii+VEPOtAHICuqJ7v0JIc5pF/TEhtFgMMiA78pNw==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYVPR01MB11315.jpnprd01.prod.outlook.com (2603:1096:400:366::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 01:31:18 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 01:31:18 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johannes.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	chui-hao.chiu@mediatek.com,
	howard-yh.hsu@mediatek.com,
	nicolas.cavallari@green-communications.fr,
	emmanuel.grumbach@intel.com,
	mingyen.hsieh@mediatek.com,
	deren.wu@mediatek.com,
	quic_adisi@quicinc.com,
	sujuan.chen@mediatek.com,
	bo.jiao@mediatek.com,
	gustavoars@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v7] wifi: mt76: mt7915: add wds support when wed is enabled
Date: Mon, 17 Feb 2025 09:31:11 +0800
Message-ID:
 <TYCPR01MB843795562219C8037ED3C00E98FB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250217013112.441-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYVPR01MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: 817dbb26-dfd7-4f0c-c028-08dd4ef2c684
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|461199028|15080799006|8060799006|5062599005|19110799003|5072599009|440099028|3412199025|12091999003|41001999003|19111999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bttEZdeJCBplfcyPyI03SYbGDyBkcsjfERJwUJLVZgt9e/tCcz68fCUyxzAl?=
 =?us-ascii?Q?0V8HMqf2y3KLew4T0aeKezofLvDK3tPDSKWVofectRg1ZdAa0AGyUIAoNafm?=
 =?us-ascii?Q?yHucvfTS0AUciwd4PXSfgDkoOTCfYzhn1z7dT5+QkfHRQ9IQgZmCIajL0TMh?=
 =?us-ascii?Q?06Xv+1neK0TqvQ+m4pIfTt+L2q/TrfXzAyFbgz3V1ZNYjAwy1JjmLnFcQqGp?=
 =?us-ascii?Q?zaBC8CgggDi+Ez6cPWH7Nq+wKSXsIJXJgqlf+CBGOG4UpZWrs23aNH7//2r9?=
 =?us-ascii?Q?XJA93p2BummkBMjLTjMdnxNFdz0S3AoXk3YbLyIjFP2GlGk3sy6VBuxEAg9N?=
 =?us-ascii?Q?KNP1QFjNL3CCFOFkqkqZUK7TAr7cj/kJbJnjHWhdKgwjgkAJ0usT+68IO1Ly?=
 =?us-ascii?Q?aaKfBg6XgPo/6Cw4jd3JNH8zV7renayEOElA7TsctWDIGvS5pvZL119BGXn3?=
 =?us-ascii?Q?MgWqqev+xo3zU6sBjtINMvYfWWYWeDvnnIKu271I+SwNCEit8Ybn39x/LE2W?=
 =?us-ascii?Q?X3eOLDdNTmQFSGZ8Mj5O0aI4LHPuv52UIixgcpBxgLK1Pa/a+Y1dJy/X9V4p?=
 =?us-ascii?Q?trdnXxdpLiOQWG7Fk8KdOjnSgWss0qTTglctoJ/8yOch43IXCvjRtbEpnYl2?=
 =?us-ascii?Q?bOqzK0YkTkLmfybdTZjsAtm8Qdu5hsTfTMaLYqRQwNWNWhM0SJ/2E6IMFNY+?=
 =?us-ascii?Q?m02DJW5IiGkQvXkV3fhm5OaNwtAB4+hTaH9UFEy9FighATixJd2TRykVZMN5?=
 =?us-ascii?Q?eh+OPeSRU8sTPQyg36qeSLakxJcrtwLG1Upr7pFcHAjwRBuHpvAThHnW2588?=
 =?us-ascii?Q?w2aUWnEvjS3XosFZ1eoOlsfcbkXtfwvfhNKpqLhqKP9BrUlAG9cM2zycu24U?=
 =?us-ascii?Q?/Ni2Zy5/piyZHruwqaSzcV2vVFay4MzdBurrxPl5zp8mvFkHId5EPnWM8Gle?=
 =?us-ascii?Q?elH6tjc/HNyWZpeCksiI9fA9KP/TprB0Y8EzSdvPfwuCfFMbB1ycGQsjr09A?=
 =?us-ascii?Q?ma7ShdLQrqmWxKin7qxZV1L6xHkNj6rCu0wIqJ460yblFV5cr6dCEIgs3Gkt?=
 =?us-ascii?Q?hUieqnou9HQJOC6rfO7dpN8jLEiLEpZraHyw9SceaP7LquKWfsL2anzrQ6J2?=
 =?us-ascii?Q?UnsakUJNIU2NV1sVnUqCQNqhsZgaWrsmAKHkoCUOTbxGGshL/N4QxBtVTDFn?=
 =?us-ascii?Q?pmglZe1R05IVqt2gxT0xi+ArhZFZK4TdAtlyFPfIl/CeaW4Bb/TFetNcAl8?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qvLEJL8XDBY1q2Vt+0oJwM8rbiyDieRg/qbpq2+DkacDBolzpg+MEuW2zisX?=
 =?us-ascii?Q?7XjL1GbfSGrZ1D7RHUioWEsj42IrqcP7022sjCnOQjV0aW3GaIYZqIi0jq1L?=
 =?us-ascii?Q?eXyPgRtMsJvcRUBfywdfhHg1GcHbOGvmAyooqfw8SyUSdZI+zyh4Feu1HYSQ?=
 =?us-ascii?Q?PkavbNmO1RAKTvvr+79J/KCohCSs/TtCvQXqtYV339xsRBkyEOTC2/xB5ujs?=
 =?us-ascii?Q?JvJuESjpQLcT8QIWkY6PVTQOg0XOqN/albw83KWif5JTPwO0TnslQWw7qjYQ?=
 =?us-ascii?Q?JBJBMPCFW82uDGE40z683DwjVSFSVUvw13siKH1h7CGMfVnvFONdJRuyn2dc?=
 =?us-ascii?Q?3PonDeZoYh7WBNyyqDzdVrchya9ts34obL2PJ1BN0K2yD6GN+vzFPNz5dm6A?=
 =?us-ascii?Q?D0pazi9kQAJZ4c3p87hP6YaRw5NWBrDnJM6KCwoBJZTnq3JdaZ1EZf00UDrx?=
 =?us-ascii?Q?R3SkL85knnZRpO49Og5KCCgROVPwEx34sKLK2x9S9NmHXWoJmnwEW0EyS0cJ?=
 =?us-ascii?Q?34Ce2atlDQ1ts8cawkkcYPkJubaBXFL+Gn59H4bmL5eOyCAPup52rRI4LfrP?=
 =?us-ascii?Q?o2wUAQu0Tnsua2+YCjBSczcX/pDlYUS/ZbItZj5pDoCTQ3d/gMocGjnMg7Q7?=
 =?us-ascii?Q?ZFshHyTYKwLJJKP+uh8JfkOif808mEXnqECL/W2OmBpJ80uwyjHeIyYZ906Z?=
 =?us-ascii?Q?IcH6CvHOs/J8nhrRxwoTu7KjV6fhRd+jWlNWqDIVY26G8koietGBUpYyf83h?=
 =?us-ascii?Q?2MWIxfAyzpbCQIzJjyHmQ8IgeQZ+yIq2TLh6lwsp/slViI0hqcslcIXHohYC?=
 =?us-ascii?Q?PyH52MovVfUiKNhOemmqaB7lC1enYbicMVTZkZNjUIqN02QgRzQswjXeEnu4?=
 =?us-ascii?Q?D5PAWDwjbyyCEKxx9hLcREjhCIHK0shtHcZqHTE7SPJkVTh6rwVjk2xQseHP?=
 =?us-ascii?Q?T06kEA6GmDt0UwsCuHZ3DWvBXbDPaTr93nvll8rh7IE6W+TfvLzT6Xv1ke4+?=
 =?us-ascii?Q?KxsRHGfB6PQT+bX6dJ65TN+JnmfFIJxxs1eAbNB/qDaoN9i+oRVpXjLVWm8w?=
 =?us-ascii?Q?YnxTFLrME0XxoVSKFyxW3QSRECih4lbqiXwXDCp36s/LciX65k4TQSGXcaqZ?=
 =?us-ascii?Q?+z98FDwbvusWu9j2wEgGUdKHgEbkNAh4rs5fBlleZF2whdPqT8yh7E92MgV5?=
 =?us-ascii?Q?p42mFbsOLXu+91lkb/M5J/nkpRYBH2401WsERLmz5Vz3fQA0mOuJvJU7fd9q?=
 =?us-ascii?Q?U7f8kmLagiVbgQfcpqxJrS3IQMC++yU9ZAYslUWQsvF3twpH7uFjbpidq91E?=
 =?us-ascii?Q?/Ck=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817dbb26-dfd7-4f0c-c028-08dd4ef2c684
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 01:31:18.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11315

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
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 ++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 45 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 18 ++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 drivers/net/wireless/mediatek/mt76/util.c     | 37 +++++++++++++--
 drivers/net/wireless/mediatek/mt76/util.h     |  7 ++-
 6 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b107..638ee9fae0c7 100644
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
index 3aa31c5cefa6..9b045e4edde1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -745,8 +745,15 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
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
 
@@ -1271,6 +1278,10 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int min = MT76_WED_WDS_MIN, max = MT76_WED_WDS_MAX;
+	struct ieee80211_sta *pre_sta;
+	u8 flags = MT76_WED_DEFAULT;
+	int temp_idx;
 
 	if (enabled)
 		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
@@ -1280,6 +1291,30 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	if (!msta->wcid.sta)
 		return;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    !is_mt7915(&dev->mt76) &&
+	    (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
+		pre_sta = kzalloc(sizeof(*sta) + sizeof(*msta), GFP_KERNEL);
+		memmove(pre_sta, sta, sizeof(*sta) + sizeof(*msta));
+
+		flags = test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ?
+			MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
+
+		temp_idx = __mt76_wcid_alloc(mdev->wcid_mask, MT7915_WTBL_STA, flags);
+		((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx = (u16)temp_idx;
+		mt7915_mac_sta_add(hw, vif, pre_sta);
+		rcu_assign_pointer(dev->mt76.wcid[temp_idx], &msta->wcid);
+
+		temp_idx = msta->wcid.idx;
+		msta->wcid.idx = ((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx;
+		((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx = (u16)temp_idx;
+		rcu_assign_pointer(dev->mt76.wcid[temp_idx], NULL);
+
+		synchronize_rcu();
+		mt7915_mac_sta_remove(hw, vif, pre_sta);
+		kfree(pre_sta);
+	}
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1726,15 +1761,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
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
index 9d790f234e82..32c5aa1a361e 100644
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
index 95b3dc96e4c4..7fac9c79ebdf 100644
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
index 260965dde94c..99b7263c0a20 100644
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
2.43.0


