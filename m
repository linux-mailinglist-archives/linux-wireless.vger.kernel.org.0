Return-Path: <linux-wireless+bounces-21791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875AA95210
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03D61884D67
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37994266581;
	Mon, 21 Apr 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GqE+IbCD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010006.outbound.protection.outlook.com [52.103.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B327463;
	Mon, 21 Apr 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243737; cv=fail; b=TZ6nPhHUlwomFGqzphQzd1r5s7r+5uHENNwGJqo5fTQZ77R9G6/B/jUm2yxSeakNTDLiYsyx+aZ70QISca8Z2xXA8OUS4Vgoo5p6TlKjh9v80MY9+6uG2HAMaE+qHMVBlDeZvZ3IJ12A1a9QUYmRm9/QWuyMBYBVTN48n/sY7/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243737; c=relaxed/simple;
	bh=MuiwTqHQnVve5lPIYonNIsebAA/G/DXs6eFqwbJpnrI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HZa7uFuMSN7sZGP3hlWdwnQbqNRXc75Ksyv+H3orlSHDu2jog22ZLTOgneMBwhgBTtrMwhH/e7WF/NacOV3ueJhCTKu6O+aslesHpUAyE+KHEQhA8qb3LiZTySOJ5p22aB7dSGzFnp0Y7ryiRAoqjeKalo2bgJHzE8/pCxQfB8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GqE+IbCD; arc=fail smtp.client-ip=52.103.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYjtgYLW+HlnwKv6A0uOkyigv+5IC87JBG1PjP9KRdiEKbYbh15kosudhd5BPYRxegp3bUOWTm80bcnZ/0NtMB0iq+Q0LDL/45Hz26hSFdJzUTOSOwQuBo2QAjj4wjMS4yHjDUd4wuaf/63Z/HoaEaAwtk8BAthGVtcH2j+X9X6IN6dEEz2KaBzVkugKlCMkUcCHYM2Wg80E0KUgP8p5HaeHH0TORr7+sANWBQT3bj7zb9ogXrxlgydCD2dgUjKo5HL5Al9Ty3pU92opVx6vtP5SoNzmQoIhu8jE38VAg2Xlr2QncASnqnYX2k7TAVM6/AW1W9sX6R4HTX0PKwGMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLnSTS1+RYL5zAKFh6wtyrw55gewGxtJWuuTvwwSaaw=;
 b=iledgcIridMZXx641L79THUW+W9uMVejRMtKNqpZS5ahdcwH9297imTtvzZveQdfM7BifOM2Zd0hj4wHYNBAflzmkXgAr29bdOMPkVEqNKW5PzCAONuCexcN3RDfsXN7utf8q0kO+2DPEJL+6XiHtGDkdQjYZ/sK14qquYz6Ka2jraI2LgGfQ5V8ucpoLcjd6/vScoYdSHnNRE6GELv8JtTw5lr3AVzgBNmld618VYVjLYR3g2oX/dqUP+kLsliy2YAPDUjuAyxwSArzDYX0U+GO5YY7mP+3KKfLLO1ftOybVTpe77nclkn2gJBJJQ6XOLbMwliPur27tjTAHvFGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLnSTS1+RYL5zAKFh6wtyrw55gewGxtJWuuTvwwSaaw=;
 b=GqE+IbCDUj/Cv8tMCTWqe2hG+OxSi4oH+3We+sdv8zViRcBwsbELOu6PW3Qe2d8rhcKHI1VAoOu7MsREylWFi6v1RqsiY94K/CMX4XrzxeT4KKpnY3YRbI74G8uAhLx0/3qocJsKgj1yvOSjRkwQrpwVY03h81CjBUf8APFhj11NMd1+jZJO8DaDt8ru/8ztiap1VtiKknM0xpILsFBqixkQ3xXtki/xWeb9QHpOlLhf4GDCAQbqylRLnW4WEjae6n2MNMOCHMd2kmJk0xHvoawfwRy0tI1PowTEyFYW+roUei4+ZnI30vYsx72cWp93SWgsOqB1uN3qz74JOF9anA==
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com (2603:1096:604:183::12)
 by TY4PR01MB14781.jpnprd01.prod.outlook.com (2603:1096:405:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 13:55:27 +0000
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7]) by OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7%5]) with mapi id 15.20.8655.022; Mon, 21 Apr 2025
 13:55:27 +0000
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
Subject: [PATCH v3 RESEND] mt76: mt7915: wed: find rx token by physical address
Date: Mon, 21 Apr 2025 21:55:15 +0800
Message-ID:
 <OSZPR01MB84343FD3E9B6594643B426A098B82@OSZPR01MB8434.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To OSZPR01MB8434.jpnprd01.prod.outlook.com
 (2603:1096:604:183::12)
X-Microsoft-Original-Message-ID: <20250421135515.1120-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8434:EE_|TY4PR01MB14781:EE_
X-MS-Office365-Filtering-Correlation-Id: a69c30b8-b754-4796-a8c0-08dd80dc2b84
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQA0FA2wMw7ykrjEzak0iSdAZHaYfB6e3k1c9vd5xdgobsGMxNHQ+MbZv4IK1acXUaH1TKo2HFPQqE2YMvirSkKpSJNnyhyGvh5dwyms05O/RwMkSuTThu6irQfKc0rFOSgeTRldao/ofsp+0Drk/8ypim9t/IyWH2uSTyRbfG3wUrS/1ru+FsbQ22/IKHs00ZHEweHdk/0J5uwTPd0ByWmT6YVuDEE6gWTve7j9JAwYAmZxuumpvi7sxzqIFyeKZeXOQFyNthfC44DBMjot/ky0BhAc7pinqhz1glhNSY8tbnxWAYgmVtBuZEp1i+4vjdL0ZP8lzkTBpwGoEhNkaZ7tfTpOuC95w11Ur1vsCQQ7k2zdyVCwZMfxFkrvWYLpdCSX/uC62SmhtmMunq1MHHT5+n7U33T2fHN3E3wpeC+88swNJdqn8qqY87Ua7t5CjrCrJxDIDwMhRfh790dOIJfcxN2Z6cSBeF5OwhJe7QOQ94kUVYwPdDNBt4LabXB98rXrk7+plxpf9hNCkDvCwBMZW7l/7ieja2ELi+xMBibby69vyG545i9qnkfj8dodyf0ZRVQ89dLhuTI0C25afr8BMhP9rGQlu6DYqIN/UXswZInx48bMWhciNZ1+hPHv3imqBwHNFnPBa/NYCTGhc+EuISHP1u+d03okLGK3++6SRfSGLX7wBj7ffUKpXpkKxuI1ohIJS07JJ9E1CSMvA50xHE0zdfg0KKedWstpLb0Q91/qw4TsDBnBEALxTqC+PfviQBCwqRsEk3KHfi04GKCFgnWdIqOPh1X+VdSq2yuTiILcdEf4I8ct
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|7092599003|15080799006|8060799006|5062599005|1602099012|4302099013|10035399004|13041999003|440099028|3412199025|26104999006|41001999003|14041999003|19111999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LN7Zn0wo4TdasPdpXtYU62/Xh268oeIlwkwA6jTZMUmk/lz0XSEb+2KEFgcY?=
 =?us-ascii?Q?ut+n4b2jJbH4FgHQzFtOngicOu4fNZ8WJFoI4jSML9ysCB8shOZQoKD2pIbY?=
 =?us-ascii?Q?Zzm20hu+ByDHjrRG2BhqNyvkP9HFTJ5OYLw3Ox6WIC2wfDUhlXJ5OYNOOBBI?=
 =?us-ascii?Q?BJVOUZmgcDjQjQflkExCtbgAALUHL6Hr/89PN9f5i1KrTaUAnVwtzQJd/Hgx?=
 =?us-ascii?Q?PvgD0IqzHKZDvpKv65C5KQgkv3W1ytyzKhoff1KXpNB1RWTUVz2Xd0H5TEIf?=
 =?us-ascii?Q?hMPYAnn52FH3djtQJJVHVyJhMI6fwny4fBHxttar6CR5u6RGkFM8h4WFuerr?=
 =?us-ascii?Q?LXo88qJIQChdW389A3csf9lNtLHV3JJrVcJwPYPdzKLsR1qBX508Bf3PFjhc?=
 =?us-ascii?Q?FAsyr8FE830eRc5CiW6HWJ8JWT49n93aJ2TkVTk4LVi/9iVu/xhrVKt80vBu?=
 =?us-ascii?Q?zIuq3Uk0PlUFGesl3j6MKFsxAZTIDVNeA0w2Xo4EStr+k4Ujm6oBvyWIH+fC?=
 =?us-ascii?Q?hOdE2oB28BbNnCUt9mnpJjJm2H6tuwnWrdvOtcnGv64O0n1w3oHGfQ977JFd?=
 =?us-ascii?Q?RXnv+LFPm4H5N5pIbpSA9UvrNvp8CPSE2gDMDxHkEcUgB9wYFOnoqGCSjIgu?=
 =?us-ascii?Q?qONZg7jeID1QzcJ15FnTFWJdFeJdAgBM35EizRi/5tnspG853YagRzF3fXqn?=
 =?us-ascii?Q?C4grJJYml1lJxHvbMFJb+rJeuRAqgubxWO5WFgQzEaoiYGuwk2HCQ4kbhnjI?=
 =?us-ascii?Q?KR/ZOU5SpnqWyE4tX+mo1q9oyNqBJ+saqdBKXz7V8+iVJbtPaGF9AqTk2co7?=
 =?us-ascii?Q?XVGn9QYL6vYld3JhCYG7JAXa39KvDP/ZYIV7U7PfvHIAm9T+AmhCIbVT83v4?=
 =?us-ascii?Q?itgIsmDvZtQx4Jw9Akmj7GaQ4kUoYq0qvKHz8ZsAOLyjx6VPKU4gaX88a3+o?=
 =?us-ascii?Q?imRhN8z++AGPgkq81mrvzjS7Z9UczEUmXXSvGPZCcF7vTo0yR8j87ni17cSW?=
 =?us-ascii?Q?ZSHxu4sBIT/HodviGAo0h2m6W0V42wBTozwMYksxQ8+enoDD203cHCe7HR6x?=
 =?us-ascii?Q?P7SmX/FIjVWp1ER2jSDKZSrtQ1X+0wE3qN6t5jfApu2PIBLqb4Gv1j0lsPjE?=
 =?us-ascii?Q?7O3LhqybnOj7FyphDUPiBMCNE4cBIfpJJxUrq7DVHbfiHyMw20DAPN7LgAfg?=
 =?us-ascii?Q?9mtIluKoJxbhP+gPt7bcxmlT7CxmHJNOe+ttyjFeHvtnj4vDcxeeLJYdMthR?=
 =?us-ascii?Q?LoLPYczb9iIbh5qCdjQNsGcTE3mbuwzMEv0yN36vBmUaYCRQ0NWOP9ydo7fU?=
 =?us-ascii?Q?97lL8uNaOMFc0AuxVoKJtfszSKBXJnNYrtrH9R1hC12TRPooS+DYiw+k3tJT?=
 =?us-ascii?Q?/rmRImrFuCscWjgUUDuGDJ8/3iMkLI9vG9A+oA69F3B04t6xABwhrio1MBhf?=
 =?us-ascii?Q?6EsOzUSzNOrdNl5Osm+Ki0rrErfNmJwv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JThb/6j1LVwSaDp/6004FHkMioAWvy5X/JOgO76prcLZi+EjYdqW2cJCfLJQ?=
 =?us-ascii?Q?XBx7oKLARCoYny6GScbsDVOJp2HhBA/qRLaJNTgoFKL4xFD3zo0XqeN7oLGO?=
 =?us-ascii?Q?8QppoUw7SZeP/mwS1VrOZGUUSQb1HOv2wZxcWYFK3Gqek+xCgZK5bfyWPNg4?=
 =?us-ascii?Q?Q7+S7pnlQVlmGpI63dxJWSbXORx1LLH+NimTgtsF52Ka3sMh2I/dTAXKeDzg?=
 =?us-ascii?Q?D+GmMvPTBwGBTANq7zV0IifmDy75lVBMKhPqksNv/o9Y/g4q7HB7/fTMHkt+?=
 =?us-ascii?Q?qs8vXKR0wV3T65GtNWbwMPfB/mmTqliW14vlcX0Wk03O2UYpsjYeJT7xiHdg?=
 =?us-ascii?Q?tf5izue1eQnRywPfYRkXvRBmml0PNFbWBVNceFzxkMYC6JcWA1TO6tQuIjr8?=
 =?us-ascii?Q?kgCPqeR0kmZHMVzIudsI/OYpEB+giP3bUgNRexTVwVz/ZtsZ5yt3Eu9K24lq?=
 =?us-ascii?Q?iTyspHT9FH837MqYs+akOMjsGVUXwndGcl4DElepSBsID/4JYAqrz2Eaujwy?=
 =?us-ascii?Q?lyCj+sLwYCrIerEXmFCF/j/uZrmP0VcUhJbh0BxFc8RWeBUxyVqupyHmC0le?=
 =?us-ascii?Q?inFgF4cgsm/+j5kGDhwiX4+wHtSRP36sVYMfH2Vm6mKC7WXYn6KBkHjmhqiQ?=
 =?us-ascii?Q?UEXuI7mGM3+9GIH+FyVYxRWeA8TrssHbamny1aqlWmdrt08b1CyH9xnQLHLW?=
 =?us-ascii?Q?mQH3WH2P8UDX/jBvqFRCsLwxUK9Oh755Z1cULrDE8e8eWqQTZIKKD0u5GC0f?=
 =?us-ascii?Q?hgkQHOoMxV46g5qcOrdpSf6FJwehqF5ByslRwjOKuBuCgxA9hGbRJMGoFhHt?=
 =?us-ascii?Q?Ysi50wnvVMEesz+iMm+MbIUtOqOeas6EUwigNoqSHsxstlJjVVGZ3I27Gn/H?=
 =?us-ascii?Q?odXaNPonfoiQoO6PVtabaQ2GN89f6sxJaDdV2zqSBembQaGoLjM1EKFYFZDU?=
 =?us-ascii?Q?osJN12O8X/42cgVfeUWoih1/6ywliHRfoXSU5nH7EtruW0r5PataVumLTnub?=
 =?us-ascii?Q?oVNfLeUnvb9CJw89HCkqJw18sOvypkDdKi5axc7MWYjTwYzKkbAU5zTW11Ta?=
 =?us-ascii?Q?31T4l71uIY8GeOqzj3OUFl6RgrTaPaeosKrFQhKParmPGZ6eGe0ELwlBV68h?=
 =?us-ascii?Q?C9P3fj7ZO2HVJX1d5lz0tehY8EKs7EvCyEc5L/VMmVfsXyaChXNHU78Hjm1W?=
 =?us-ascii?Q?3gDccohDUbr20CQbbP5aS+WXDxESev6nYViN/ZFby0U0A8NHCGoGLmrFGAM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69c30b8-b754-4796-a8c0-08dd80dc2b84
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8434.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 13:55:27.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14781

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
index 844af16ee551..d5649c52c669 100644
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
2.43.0


