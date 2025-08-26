Return-Path: <linux-wireless+bounces-26633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D261DB36488
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2B2466E47
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D9A14B950;
	Tue, 26 Aug 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H/pvYz14"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012061.outbound.protection.outlook.com [52.101.126.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ABE29D28A;
	Tue, 26 Aug 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214965; cv=fail; b=oI4MaSN8HVEnOjbcKWWGNO0INoxv9wj4HmtcfPLxyjOOrZQAXSauK+rvXgb+vMjLJeR0vzLYd3QKre4/ps3vnVuMGfe6BQu/UkM5X8RzT051QsbxPjpk20PyJ1/DuNv828Xz4aDPMtSKX8VIcDZTOhxo96iNxYZ8WCy0EY8jYfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214965; c=relaxed/simple;
	bh=Si/uhF07+Uyj2P967RXELWIC6adp3YASMXtqebDuIkY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Teixa3hXhSKk02hOP7C6H1y4ffHji7vp2Oipyd9kaW5ux/2XjRb2M8AP7hIDy7VyN6ChvxtFi1Illr+zedegjAtaHn8wFw34UCITGlsKzhVNrqsZOXOqn4opVduoZovJSVi3Lggq0dNCHPTUUCx6eLsl6Rupnirv8yJpY4voxwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H/pvYz14; arc=fail smtp.client-ip=52.101.126.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvmVhALFoS8Fd69YRhKEw5cpLnrS5PzIBXolhpfFPGEiequxwFvQmsMpogVYmzNiXphV7mw4v3d8ZpLgt6Sz0q8gFT8p6w7lwjdv1N/jeUcN3uLUXam3nlu09QEtHWaO5kV8eFf46zd5NNNgL+LbkW3TvfZMIomFxQwbhFUaCSL2/JlearMoWQCpLgLvO3lWfjXBt94U9eqVGr4O2SpeUo+cqpYeXCMUKLketnyX18ac00Np36wvTTCxBGqNnZL2R6QnCHK9V3aiOtPNQCh988PyRF7BdZVDOqTF7aDmKGWM0eVyf9AnaTHqi4ADfACzatlo+sDv32etGTURcRMDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuTDTVemiwezxFSlMYn1VUizDXjHZql8bOBvb4qRtRg=;
 b=dTTq9MkS7/KV/UkTEwXZBZ6WUYSbyPVDX/+agxaJgqiZnK2q94j1Nvli0jFDCLWfKHiHPQgr5njUXOb64cnt8zEyHFcB3V41OGYTE8OrHA3+buzI+tHp2IHKm/rDx80qOBN4Xa1O0OBuINfXaV66BPFbjlagUW/rRQ5R0mPeApYmMLiSjmD4MhdpRvoiisnaRKl1XLxIgLx7V8wBmNPnwwC8LFVVR4Sj7um7Zc7OOrBSwVBhV2S3wGIFBDPWZBVRRY64a5uOrU4w1XhRrm1Kvpo6VMJDHhKdtkjbvWPLSRjMdKzlpCQ5Lsj7CK++bGWkYs0AVqM9pQlaGYPB4IE7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuTDTVemiwezxFSlMYn1VUizDXjHZql8bOBvb4qRtRg=;
 b=H/pvYz14HEFQAEzyGBqM9UFrhSh0oxYRtekoDdvO6ASLjEDPi51xjqAT1CAlMRYoWBozYlX+bSMAAqMgcxYE9iI18DwraJMxI/ROEhSdOV7K7gQxZxaqep+VE8guRtQuA6Io+8hwPrb0tfXQ72jbLN/4Hqjzp/+ONvQbi8nSmITJNg2QcrM97PA7LaL99AJhdebzGbHgKNpE1JznHnnh27StStvRGuZdSg7DqulqAsWMdO9/Y2jtQaDOp8sMQCzJQDl2Gx2+I9/us+T6fTa966jhN1yyG5RUR4eleQsHHAdv7jCMUpMxU93rQdy2bxIkT8Knn9sD5gZhWQ7pLfiX6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5158.apcprd06.prod.outlook.com (2603:1096:101:5a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 13:29:18 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:29:17 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] wifi: rtw89: use int type to store negative error codes
Date: Tue, 26 Aug 2025 21:29:04 +0800
Message-Id: <20250826132905.501755-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::35) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: c68c8ed9-9b26-43db-33b8-08dde4a48ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ijOOPTm3Z8DAm92IJdp7VYuh/F8F4AurkaGpLFA/rYoQBXQyLjIDmnznybG8?=
 =?us-ascii?Q?pqzGCSRp3taiT6+eptDWJPp4cazqAmBrjlG4YLv/0g+4MsoSNgVGZWl8xL8V?=
 =?us-ascii?Q?hWsCQq77SMJz08QBIxUxZ9S68NXkZZZdn80GUaFRFGYNrcuHYMG8TmYG9CC6?=
 =?us-ascii?Q?Z/MfAj89MVmhM58+8kzBAqCNeTopecfClgYtzcA9ofSLka0cl+p/AVG+64d0?=
 =?us-ascii?Q?b+AkSmQggt/2PTILGmiwIBsHjXeYU4CqOjFpr2wKH4Gc1hM3TlJL1KMnu51e?=
 =?us-ascii?Q?ujJTFpSR/GJWb9qdrnfRqZoD6DbC7p/WyrfvOY2lJ97WAZX19fdEGTAr7ecJ?=
 =?us-ascii?Q?p/ik/nAhYqdouGSap1OprJzNgW1lZJyRq1+YBcKhSNvLBH6ji5i72kb/o4EB?=
 =?us-ascii?Q?UrU8MKoj1Zo1zPR/9czkC/Lvggq7ec9pacQJSKNjuZ+kG+joDwResFyoe9/J?=
 =?us-ascii?Q?SBVE3DM+RiINs3lOp7kT0H14XYPc3REdTvCttFTps+UzVd/nqKMcmuwX1CzE?=
 =?us-ascii?Q?2zfewSzO3yyh8jN0bfM9S9gLT+KGzGSrkeJRQe52mNnFLbBys472CF+JFT/b?=
 =?us-ascii?Q?kJ3gMphSMQp5e6DoP6SzWOvjkVOKimz9W4bsIMKMBF1RffI9mG41hDl0Rawt?=
 =?us-ascii?Q?ZWugEN99OY2SRp/aijBPTEDwljR1TzUOp52JacGQraIn99AISJPeEnKgY+3k?=
 =?us-ascii?Q?iYRZV9qkn4ps+QfssbTr1s9gvap8ezfBUaRngGjRSEJpqMckrmGLLJwUBfmI?=
 =?us-ascii?Q?kHMfXuswfdgTisPWrwFVHEK6ggahUHbT/w50HZHyCq3KyajyRsyu4JtVgQwV?=
 =?us-ascii?Q?0KpbYvdGPFe1rK9gl/O/NnOBrEdXCKL5/rXp5JqVtVTK25Iz8E/xJV6LLBfN?=
 =?us-ascii?Q?Z6qtf8IrOcHZwQZhgRyrIMyUzkvn++zpIkbLAsHmPj8zKV6lpgh6jxjuNZUX?=
 =?us-ascii?Q?D4OaSKN7w/1KIbYvGhJ9uer0Q4hKVPq7tYNoltJI5HOJHFEmSjF7eo8nubIR?=
 =?us-ascii?Q?80pk1nPCtDlQqkfta5FE7Ba6a9PjO2T8vmhcUOeY7fjkda1SB9HCCHUA3bRv?=
 =?us-ascii?Q?JzLCQcDMbVGVCV+Atg7DiMm1s3YmIAYnpSee23EXZ60fSLsRBox7gsapkiYy?=
 =?us-ascii?Q?IDOAt2vgPdKrcHvuavJexXPprQqN66uZplriP9jPDknqXpSdwiWc7/Dr5SFh?=
 =?us-ascii?Q?vqVO7vzehpUxchWMYaWp6Z8RVD42/du5xVAh6/BifkG5GSKIpjLcbCR2h7uq?=
 =?us-ascii?Q?n8BiRCGYW6qEy8pOjd7ky5pYFJMu5tpI+kKqSRE/G9W00n4cl76xPs0fTU9y?=
 =?us-ascii?Q?zMWfN3rSQByn7Qwg+RitlpGPqBPyN2ryp/beBAEYyP7dSkfokdNT7A1Psgtf?=
 =?us-ascii?Q?IRpC8Zhqx96btbteYNy3VVK+DHvY5SYQ5qiyTCJ7Mg+DOIGNWpxmq0pHmrcJ?=
 =?us-ascii?Q?Iakx9BPXLAkM2MpMdACMyRQQbGtHZ6c9gRkm3fUCyCik8jk5etQ2bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9lvXcZZD3ZvYfkrWrRZac02KMvN0bb0MnT+lCiLmSGM0dzaWfEg9G58dysP6?=
 =?us-ascii?Q?5GscUe4jt3O46fnp/UP2AYmNbkzRi2geApE5mrdjqaWA+jD+ElWp1NnbFLcF?=
 =?us-ascii?Q?rntzQqd5ldzKj+XwFhGCHCi94gOHra4QvdvJEq+wkJR6ZgTB1KYSHzUoPuuC?=
 =?us-ascii?Q?TOQhNG4hy+Zcj4p1tFqB3bPVkFj03HwqbEa3A6nfY9bBwPo0qFo7IObK5mYG?=
 =?us-ascii?Q?f/U7O21yd0Et14eSsS6ZDhGg/4c87vl7en1zLe/3/N4+xU7GAUZ5nAaTuE+m?=
 =?us-ascii?Q?+xLE4OpWXAfWJEvd/WIg+xA+NLDs2xJsid9Z/Ae2JZOxH+N2q1zD9zwQVeJR?=
 =?us-ascii?Q?o/QwT+7MWtQYMNUZl8jG0mWLpRtlqf/1r+y7nfJBy6bgcHtGRwPXW7s1r+25?=
 =?us-ascii?Q?BjWZMg5+5a5t/QJtXiYu3ZjBZJVgMbdaDpERKtHdKnAfr6OmFQkTzLeqpP9M?=
 =?us-ascii?Q?x0Dy41jq96NigRumngmV+XSGIihbO1tDnBkLQuOnhkhbhp1hMoSlh8R2rtru?=
 =?us-ascii?Q?62aXEtKtyxzFVTs8mhozi6VRhjXFFMfU6swCIJwjlgY6q8v/TwkdLKumGAqv?=
 =?us-ascii?Q?6xrkEq004P+snLEM2s0jVOmwYzLfxl/9vGCoitXmZDWSk1OpksL5GNoNlWSq?=
 =?us-ascii?Q?dcKxqBPP5BmVSoWFn0p3KcNnRZL6234Fm5tk70ekJygYS3bU9wO4iZC6qPqP?=
 =?us-ascii?Q?sokiqpqiaf/eFi9QwB76ZaY6iue0WVYH4wkVTym9mXCtmYjQMizLENFgW3X8?=
 =?us-ascii?Q?HgsfkKnNyjuZVgAb2uE4cYe7nYMDLE6e1YSnqLeNPvnbn+a3Nt2Fb4v9BjLb?=
 =?us-ascii?Q?/pxbO6qi+48qOxPt7r/xah6pTUsBPga9AwYL0wAYi3yd69ep2p5XKHR30lKU?=
 =?us-ascii?Q?oIXHURbvr7qoxK4aTTZVn935X3sxQQU/9FBG6pamvj1DinVsAwE5DPtrqIE9?=
 =?us-ascii?Q?EuWnk0QXXITP1X0abaZ6sxtPZxHZyr8SZ2ngy0PI4LCJpAEvSpkxHJZgobcr?=
 =?us-ascii?Q?pVaN6FoYg4EeYUjdIj/7RhvyimapHgcGTX4i0js22NNJJ61RC6njTQnCrdTQ?=
 =?us-ascii?Q?m/slcTZbElIXqD8TGh8wry1VEucb0/xOP1zfek+zd5XGCxz5kdU3d/mcNMn3?=
 =?us-ascii?Q?nznnoVpAcYxJJPfmMyHlimUyP7XnanmshPwT8HM+Fjywy2UYqHusEuLmzCjG?=
 =?us-ascii?Q?wRctCAuQYjlLzIA7BKqW2Ocoudg5ZpUZYTqDGQqEu09UD8N9NahgoqCWjM06?=
 =?us-ascii?Q?c8muREZIObo6Prci4aGVoLZAXD2AJ2d011gw+nkUfFf/ScW+LPgIB3nmRSM+?=
 =?us-ascii?Q?ryzNJQGzpl6G+Noco7caFX+HgAdZ1CjrhdKfC8lDkehiNkAOdo0h1IDRLN+q?=
 =?us-ascii?Q?lGMbWO9jtmkacmhEI9C4Zy+2HGdIejeJyycplBmsI8z2X41tSaCeql7rM8Z/?=
 =?us-ascii?Q?PoOVGHezKponea+txqbPRqJ+Ey+IIH1oWxNWkpd4dkqI4j61PZO8PPV3mdGR?=
 =?us-ascii?Q?NWtUWYrP4jl1lGzRHEqLfCf/8Z2gQWzhcCWPwMbM0Sdii+kXwzW013sjKrVm?=
 =?us-ascii?Q?Vcbr2xEwLMox3iJp3eDCT881TgnkWn7xkBUi+XWc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68c8ed9-9b26-43db-33b8-08dde4a48ea3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:29:17.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oylNjDP40sKYqTd50BfKO3m+PJVswdf4yNm/jLrocEDX7VaLFobA8oG4mBktebhCxuK0VHpcMRGBqiNDlX+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5158

The 'ret' variable stores returns from other functions, which return
either zero on success or negative error codes on failure.  Storing
error codes in u32 (an unsigned type) causes no runtime issues but is
stylistically inconsistent and very ugly.  Change 'ret' from u32 to
int - this has no runtime impact.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  7 ++++---
 drivers/net/wireless/realtek/rtw89/mac.c | 16 ++++++++--------
 drivers/net/wireless/realtek/rtw89/pci.c |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 16e59a4a486e..01d53f7c142d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1537,7 +1537,7 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
 	struct rtw89_fw_hdr *fw_hdr;
 	struct sk_buff *skb;
 	u32 truncated;
-	u32 ret = 0;
+	int ret = 0;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -6826,7 +6826,8 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const u32 *c2h_reg = chip->c2h_regs;
-	u32 ret, timeout;
+	u32 timeout;
+	int ret;
 	u8 i, val;
 
 	info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
@@ -6865,7 +6866,7 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
 		     struct rtw89_mac_h2c_info *h2c_info,
 		     struct rtw89_mac_c2h_info *c2h_info)
 {
-	u32 ret;
+	int ret;
 
 	if (h2c_info && h2c_info->id != RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE)
 		lockdep_assert_wiphy(rtwdev->hw->wiphy);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5a5da9d9c0c5..9e4d666f15f7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -177,7 +177,7 @@ int rtw89_mac_dle_dfi_qempty_cfg(struct rtw89_dev *rtwdev,
 				 struct rtw89_mac_dle_dfi_qempty *qempty)
 {
 	struct rtw89_mac_dle_dfi_ctrl ctrl;
-	u32 ret;
+	int ret;
 
 	ctrl.type = qempty->dle_type;
 	ctrl.target = DLE_DFI_TYPE_QEMPTY;
@@ -985,7 +985,7 @@ static int hfc_upd_ch_info(struct rtw89_dev *rtwdev, u8 ch)
 	struct rtw89_hfc_ch_info *info = param->ch_info;
 	const struct rtw89_hfc_ch_cfg *cfg = param->ch_cfg;
 	u32 val;
-	u32 ret;
+	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
 	if (ret)
@@ -1177,7 +1177,7 @@ int rtw89_mac_hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_e
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 dma_ch_mask = chip->dma_ch_mask;
 	u8 ch;
-	u32 ret = 0;
+	int ret = 0;
 
 	if (reset)
 		ret = hfc_reset_param(rtwdev);
@@ -2413,7 +2413,7 @@ static int addr_cam_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 static int scheduler_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
-	u32 ret;
+	int ret;
 	u32 reg;
 	u32 val;
 
@@ -2954,7 +2954,7 @@ static int rtw89_mac_read_phycap(struct rtw89_dev *rtwdev,
 	struct rtw89_mac_h2c_info h2c_info = {};
 	enum rtw89_mac_c2h_type c2h_type;
 	u8 content_len;
-	u32 ret;
+	int ret;
 
 	if (chip->chip_gen == RTW89_CHIP_AX)
 		content_len = 0;
@@ -3105,7 +3105,7 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
 				  u16 tx_en_u16, u16 mask_u16)
 {
-	u32 ret;
+	int ret;
 	struct rtw89_mac_c2h_info c2h_info = {0};
 	struct rtw89_mac_h2c_info h2c_info = {0};
 	struct rtw89_h2creg_sch_tx_en *sch_tx_en = &h2c_info.u.sch_tx_en;
@@ -6720,7 +6720,7 @@ int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
 	u8 mac_idx = rtwvif_link->mac_idx;
 	u16 set = mac->muedca_ctrl.mask;
 	u32 reg;
-	u32 ret;
+	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 	if (ret)
@@ -6862,7 +6862,7 @@ int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
 {
 	struct rtw89_mac_h2c_info h2c_info = {};
 	struct rtw89_mac_c2h_info c2h_info = {};
-	u32 ret;
+	int ret;
 
 	if (RTW89_CHK_FW_FEATURE(NO_WOW_CPU_IO_RX, &rtwdev->fw))
 		return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index a669f2f843aa..5f58a954ccc7 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2725,7 +2725,7 @@ static int rtw89_pci_poll_rxdma_ch_idle_ax(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_poll_dma_all_idle(struct rtw89_dev *rtwdev)
 {
-	u32 ret;
+	int ret;
 
 	ret = rtw89_pci_poll_txdma_ch_idle_ax(rtwdev);
 	if (ret) {
@@ -4158,7 +4158,7 @@ static int rtw89_pci_lv1rst_stop_dma_ax(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_lv1rst_start_dma_ax(struct rtw89_dev *rtwdev)
 {
-	u32 ret;
+	int ret;
 
 	if (rtwdev->chip->chip_id == RTL8852C)
 		return 0;
-- 
2.34.1


