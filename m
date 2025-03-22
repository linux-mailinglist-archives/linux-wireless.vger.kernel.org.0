Return-Path: <linux-wireless+bounces-20703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA8A6CB79
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 17:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DEE1887911
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F81870809;
	Sat, 22 Mar 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rTjevRn1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011036.outbound.protection.outlook.com [52.103.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0AF507;
	Sat, 22 Mar 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742661167; cv=fail; b=DdXCILVwQ/sGR4i4ry6nUoY3QdvLCiqRSkYSjuxEuh1NiJyrmI0R83PMzGNoC5rh3tlYUMd2Yd2tpSxboPCjXn2Hr4GsRTqrAbwLWhywdWbKbWEwbWBPpyrSC3uOObft46DfBpLwaQvXlwN1E6+GZmc75vC0FGS9TxrEo/xXsSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742661167; c=relaxed/simple;
	bh=MVznLIYz/yysg3IkOs67TykdB8ktBKX9xGLbSM2GE/c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YRlGn4zD5R/mOodTpjdWZot031l0qeBwdn6px/l50Zfid2csC0aTp9dRiKtRckJYyOeKpsUgvAldbupuSFOngH5/xwfZE6F/wp/OZS95DoOZbLKkIEvBbYijNO2UfbXpAr3ySB9xRZX8pKuYKloo9XeSYQsY81gKx+Ztfeowvzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rTjevRn1; arc=fail smtp.client-ip=52.103.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHbpBmwxd+BeifOrSOTQKg65BuT25vA7OmGoM+mqaw/sXAwCTUijx1fhIgewa+vpWzb0VRRqiBX7V1hV9zbWLIwBIE8q6UxUfKpPvQCPUKYS8BncD0McBDO0+QEUDKcihRrCBlVijtWKESwZIMqlKC/tdAVXPKFAzCms98PaOiGaf+r97qKq+RdW9AoDz7JUw8vvxnUryfC9IQd3pnXlJT2I1ORc4u0QNV1iyi1QvZDcX3qzw1GVT7yVD3vLaSEPHSJyHzgt4NEnXiE9A4Qwk4OUP6/p+EMWz4i5YQO+NRkku2vb6azHMNhnwoPliNZDXpXNHhz5GGy6o/KbCBr6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hex12HAcJCp/iZW2x6jkGpzrUZb2jyaRs1SV8ledlsA=;
 b=fQM1bcjKqspiwtBEWRka9Lfg5BSTfceVSvGclHSciTglvdjXTEoaFVL3pcgYviUJPqSs5Nrk/46M55tSirUlknfp0MnVwuAupARwqF5as/qmX0Q81+ZfjNHBGhSJ62dV0AMWd2LH7oBhQn6XBdab505Uv/t2d0LNgYiqHkBcz1gRLSRYiMRueDqB8t0vjS1ZOp8IG9PxZP+QnJU4cvSBenY3pN6E7ZlchA2KBur0ptlOKXesmpavsQFTmmmRdt7q6fEsiKaBRLF6FLBf6zzl2hhQsxwxy7KkhmQAyWz2ysRKpntD9jlKSUynnczibKQ1NP4iZCNtkBVr2rNAEt/JVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hex12HAcJCp/iZW2x6jkGpzrUZb2jyaRs1SV8ledlsA=;
 b=rTjevRn1rOjwlvY+5nmg5U2JwvGDJ84bn9F0bUFphFX91N7myO/NfpUosTucW35ION+DBtCoegS4ZqJUFjbM0RPqg7dkK8ytlj0UJ0uhehi75SussE9XWrnwCcRCXGf9Xh37BgpzagMi9d5OLPEM7v2gQ5cl8CweZJBPyhpn3/ttkZgkSOKFRRo/hFTdtOoDFCPXbBSGmwab8viEnSey3j78VdmpxL9OWbFikc66XNnEJQJki9EWPfPWzYRsKrCrY+bBiBrOI8AR4SgnuMQRhVpsnDtL+Qa0TWEg4IP1iap1iFBm+4Vcp4ehI99ifualv+NRJWAXr3tAYuohKQY7kw==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYWPR01MB7186.jpnprd01.prod.outlook.com (2603:1096:400:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 16:32:41 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8534.038; Sat, 22 Mar 2025
 16:32:41 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	pkshih@realtek.com,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v3] mt76: mt7915: wed: find rx token by physical address
Date: Sun, 23 Mar 2025 00:32:35 +0800
Message-ID:
 <TYCPR01MB8437AFFB5560D622C8EB017B98DA2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:300:41::18) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250322163235.8655-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYWPR01MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1920e3-2dc2-4ab6-95f6-08dd695f2a30
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|461199028|7092599003|5072599009|19110799003|15080799006|8060799006|3412199025|440099028|13041999003|4302099013|10035399004|19111999003|14041999003|41001999003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0L44cEY7yhbNmFg8u+Vbc+ur8qIAauFViozMNRkCBDfy07Zed88c0XAQAgWO?=
 =?us-ascii?Q?Hfnv5m6FSj9G8BB816T3hrhxhRquAHGpQxjoS3nQwk32el4IbByo49R0bhEd?=
 =?us-ascii?Q?64W1h6ylofzfb6EK4a7SsLdyOyyG2wao7/ZzVT8hk7q28PjCm2+c8e6JjYBi?=
 =?us-ascii?Q?qzMcCMPG5Jm7O4669K+4YsST8Wuiq9Q1g8shUaWLnnyE7mCW66RnHSFs1Ylq?=
 =?us-ascii?Q?uWg+0jUm3anKYT0+r/KKsYsVi7nADPf351ITuwbKlSzzoEarJE23XKbPzn7K?=
 =?us-ascii?Q?icKmsDbaQYXUsUfH6dxgHLytV5CYsJ2qaB1MJgtnNrilmJvuqwtkQPqPjTBe?=
 =?us-ascii?Q?3Rof0TvpUjIKu2Z+XQkbUtRoQvWU/K8YhBeCkN6F27T05KEBNBLZhED0Wz+z?=
 =?us-ascii?Q?TVgtoFGuSEQ46fX9ey3+OnABHyDaRww4zJI/tUjIs6wBxP7Yctq2MDVGKKkj?=
 =?us-ascii?Q?wEV6n6QJ3c1HkfaJPZRzU+UdvJzOPyRERpG668cpOLMAFJ+aY/lhQ7ed2Ug1?=
 =?us-ascii?Q?jVZDdSp0m7vHC6AfT6aBC0f6ibuDajbgev8gpT51vGKwjoVt/z0P6TA/nPgL?=
 =?us-ascii?Q?fjk1YnO0yR/CU0g8QYxdmsQA/F8Udvf0Ps8F6dOm+5qko9gKcoxwoxwW26Yb?=
 =?us-ascii?Q?HYvNRKdWD6czkjbj7hSsLSHuhoVZEb3iV8ESaqG1h/5fFuhSqCkP3FqGRvOT?=
 =?us-ascii?Q?pBqfE42U9Wo9jcUCLpTOFoG3O8pd/fGARc7fhgYVbx/cGeF7RUioeG3CcESN?=
 =?us-ascii?Q?S/s57FUxsGCCa1RB6r/TJfh51P7u8fo6YxGQR2tJXgUnqnSphB/IB6NyPmQc?=
 =?us-ascii?Q?yfNflVhVTK96qRK6zm0h39F0TDS/sTB54u7EVKPyXQp1giVgSQkUS/5AJTSN?=
 =?us-ascii?Q?Ux6peRLkekX40yaiOTazldQSJs+MCsj4UO3lyuZdkGm44tm6+xHzYkx40f4h?=
 =?us-ascii?Q?FBluMhzshS1VmcPYpAtNAKuYdngZdk4z/qPhJgj+UpNMEGIWeN0pSw5qB2lm?=
 =?us-ascii?Q?GJ5XXCRU/0Un+hbCGp6nxFfOvqP39fWb08/PKomFXVLbnrzNs2IEt+E/xl1b?=
 =?us-ascii?Q?18K9i1MgaSnXkB9ErkCVgM17ZJJYXpwERXzCpnxnWxB4yRZVE1i0+rbliS7q?=
 =?us-ascii?Q?1aVCkTL5PnyAIL4CNO3ZG/C+KnJ9pziLs2/BQXcVbe5Zj2uM73zdeNFnliHN?=
 =?us-ascii?Q?CQZf8tV/B9a9Oz41CXKA8IWqDH2AbxguJf/EZV8dGcy3uKg06+pJFtI/1t3H?=
 =?us-ascii?Q?IRF0DQqCCcXGO3zCpaLN5N9HV7w0wqy+r0Y53ADrqWyC0Y49D6uqANKaVNGF?=
 =?us-ascii?Q?W1crdX7G+qBhHCzN3dQcQ3fhUtO82XYTzI0RaZiAR0E/k1hBnuDEKrqxnNly?=
 =?us-ascii?Q?8CVWK56UMZf25jCf0eWksvjtoNj9S4Hy3ASOFLfFy8SjIYTXQw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHgPjO+hZfMhNMHUtNi565xKkBZzEP5Ha/v1mmnH/4EOFDtWZKeOJeyHe8a+?=
 =?us-ascii?Q?YbZ+mSKQXifSXtKh3A6n4luVptmXlUdbQI7jA5OaXIV4TzGFlwQNwwoOzviE?=
 =?us-ascii?Q?L7ia/UxfnG8gVE8Rf3+9UBSv/SMXGA7hoNOqlbRbT0t79Zyd2KqbKdAVx42D?=
 =?us-ascii?Q?lXJpGCvsUYuau1fW8hsu+l+UZ0l+PAUSm3t4DaPLF2qSRts+TDzTXw+zxbnq?=
 =?us-ascii?Q?6EVHP4BE/fO4Da2qhrx/DrrukWV4K4zi9QXc99QjQ1s8oMz7BP8/MSjnK9pH?=
 =?us-ascii?Q?ciuORhmQaOPPlHHBKzxuxIiHZWZ2PCbdpCHZYkdjkDGqpAGHuvRY5v7HCKif?=
 =?us-ascii?Q?ikExGSuL7oehBvteKpIDOt5jdXuLYmnPrX53NtX00zmib6uxGQ7p6TNmkdiC?=
 =?us-ascii?Q?O+uoGif6YcgCBgWcLl0e+X2lf0W2sBxbMoXRXa9w37uaBqd6d0IqTLBemTZi?=
 =?us-ascii?Q?F9jefVmLU/FKpl1Qtii2//fEGc7EbxrPeMKV7tYQ2FYbEA/SAo2IP7EZtZjV?=
 =?us-ascii?Q?ZTG+b1GPiLPpZ6P/03nOcIyOBjccf9R5+BP28ggdld1SF2aZXcChIvEv2xz/?=
 =?us-ascii?Q?2wiWbRjTXCC5YBtSbub4+l/VEEUSbLhhDSOpEK9+8Mt9IxONWRU9aGZIRbOa?=
 =?us-ascii?Q?2mvHMBdJgxbYHUtj8KAUSjZq2nzy5j4YJQ4N/7oyv1HS5xu3oWgBXLTjh9MO?=
 =?us-ascii?Q?N88cLgZrnXnD21kAG06SRarqKK0MnL+On9bOdUG1prQeSCTx+nPSm1hEfm3D?=
 =?us-ascii?Q?HTmdfqxXrAV/ZyD7ne0StRBknYhLZ/GLa2G5PtpqtVhHH2S1Obx2sMLSDmWC?=
 =?us-ascii?Q?8BFNFVBFnR9ntVoiYdpJSepvXOTVYsMG11SiXw1LCGPypqL0zshJLjJ1udFd?=
 =?us-ascii?Q?wbbh6cExWhdq8B2jdaT/2V7LndTt+9ik4rjOA3sLkveJaBquy8YYuLHF5QV6?=
 =?us-ascii?Q?hEF7RT77k25PHyY53228GQ6zUwXRD6IXzEatt5yHfSuxtvlru6wprviP31eP?=
 =?us-ascii?Q?qq+JtqpGZrJXIIBoI4IvinVrjKKQbRuFTYrvqOvhFbV86ICVrBR8WQPZfyrr?=
 =?us-ascii?Q?p5QT8HKzlBAS91kxjw5zb/SqqLLjB1MoSfRBYAf7sVHT0qzouuMg97kZiLUh?=
 =?us-ascii?Q?zGoh4cyIsb8slQOtDkvoog9IylVrZcPO4bK5/BIYfP37Tdp7B649DS9KWDAJ?=
 =?us-ascii?Q?Qhrj55xESk5snyMksJXLXeRRDBsbM2PWFdHc4ORK1rL1F24sb0mjre41obpe?=
 =?us-ascii?Q?0Gfj9RQnyZrt4JT++r2rIiGzI4Ik7S8NuAW1yXmBhLCE8O+FjUp02TkGTOoK?=
 =?us-ascii?Q?Tbo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1920e3-2dc2-4ab6-95f6-08dd695f2a30
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 16:32:41.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7186

The token id in RxDMAD may be incorrect when it is not the last frame
due to WED HW bug. Lookup correct token id by physical address in sdp0.

Downstream patch link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/737340322ab22b138fd200e020d61ffdbe3e36a9/autobuild/autobuild_5.4_mac80211_release/mt7988_wifi7_mac80211_mlo/package/kernel/mt76/patches/0062-mtk-wifi-mt76-mt7915-wed-find-rx-token-by-physical-a.patch

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
Changes since v1:
 - Reordered code sequence to reversed Xmas tree order
 - Renamed some variables
Changes since v2:
 - Assigning true to variable "found" instead of 1
---
 drivers/net/wireless/mediatek/mt76/dma.c | 26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 844af16ee5513..d5649c52c669a 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -445,8 +445,32 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 
 	if (mt76_queue_is_wed_rx(q)) {
 		u32 token = FIELD_GET(MT_DMA_CTL_TOKEN, buf1);
-		struct mt76_txwi_cache *t = mt76_rx_token_release(dev, token);
+		struct mt76_txwi_cache *t;
+		bool found = false;
+		u32 id;
+
+		if (*more) {
+			spin_lock_bh(&dev->rx_token_lock);
+
+			idr_for_each_entry(&dev->rx_token, t, id) {
+				if (t->dma_addr == le32_to_cpu(desc->buf0)) {
+					token = id;
+					found = true;
+
+					/* Write correct id back to DMA*/
+					u32p_replace_bits(&buf1, id,
+							  MT_DMA_CTL_TOKEN);
+					WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
+					break;
+				}
+			}
+
+			spin_unlock_bh(&dev->rx_token_lock);
+			if (!found)
+				return NULL;
+		}
 
+		t = mt76_rx_token_release(dev, token);
 		if (!t)
 			return NULL;
 
-- 
2.49.0


