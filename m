Return-Path: <linux-wireless+bounces-26704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD32B385BF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069B93BB1A8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB59271468;
	Wed, 27 Aug 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nU3UD424"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012038.outbound.protection.outlook.com [40.107.75.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09424270557;
	Wed, 27 Aug 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307196; cv=fail; b=Iq6jFmgCzp/O0qwz/e0nluPmSQOUffvgnafYCR1i/EMCHgaWXtfE2wdgk7EFarUNfojnZ9d1zXsduBRPrZW19/XuipZU/PWxrKNM+ItKmrQ1DWTi45eopuM+ez8M+gURXMVyMqYIem9KWeirDvgXIeGVNvcdu9rzbysGTSMHRVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307196; c=relaxed/simple;
	bh=85eZZmlyw20e3L86RK670BGiZa1Ftc0bHgOHbWZHjsU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qg3JFz9+xSfeUH7zUmFjd6mHClnIthQ2KewMfSAG4j55qM/vpBMi6fqpIT9d1OGlNKMbePtu2yagOggyLFkd8eTTdyTFicMVU2NfJCelgaGDpA/GsyHmW2d/e1fu8UioG7yMWsGXjY7DAS2vM7lkv7kTcxGQ7mehZKBu9+CInXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nU3UD424; arc=fail smtp.client-ip=40.107.75.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiUsLIcfAl8qDUTQwpF6vEH8DoocdA2NAvvZ6u2LAUq4+R4yOoTOUtUqmKMds9q7DKYatgMLXKBZzDHzPWxT1+UPz6scZd6g5FBS1uq5Hvr0X9LTOANxbgw/6DHCQN4VQhyB1kAzcouAn3kZLmcrUxNXcC7k/RTAkAY2ZzHfs9YPMqrIjujKlCi8s2pxr4GgbIZy0nwaeJ5NHyD3xkFDkajik7v6rqWujigfM0Tn7SCYiPSYH7kybKMS7T7TF6oxMhdA2QYfBZfR2mlJHX/VZVZS7bAB2kOehrUn99fb7KzAFGIkRK7GQHlvPTu21H0ArQ+BOw7w3BlkKH8shNL9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9gd+zg+2MAbHQj5fLosxyc/TEPDz73O8eTDVY7pfJQ=;
 b=uUQPlLppKYBi1RivgR9p1HtbaZ/jTMrUUhwnrgcu8MW0/ZaFpvNKX1B2FTsbbUk1WFUkiIjz4p1/6s2WUiqHkhlm45R9Qis0yKL6btee0TR4SFq9D2KZBnSr9QY7QLulAX9pP5gaA8+jZDuCNREPTdogniJ5ySQBBa7R+b+MPCAFD+iiJPhKkNXXo7mzPiksKK7yOPuosn4p5VfRdMgDpojwnrKcZDdsYI1mKUBiJGgkToL4gMdLNBRDW/xzRd5v3CZ8/XgeQvC7cyAMskXDLsutqO80X9NxoSpo5buC7J+ZP2gWrng0oA+cV+rJUkJle95pExe41U+v9Zc5pZGkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9gd+zg+2MAbHQj5fLosxyc/TEPDz73O8eTDVY7pfJQ=;
 b=nU3UD424Gr54yZzQoJjtqZYyBiln/7BnoQuzt5J30XTeyCE8q1HDB6YPV8dOywPcYkoGfijQipP+VFk+Sb4wSHCnMr+0cRJ6ULonnFcS3NqvQ1LxunEUWUAtuxPdDTVIiXe0pna2hLGSDQhM0nOynvS0bknbCorY7O+Z42FWYxa+jCcamlyi9TYozB9+6jSxjZi1b1rd0kZyHz72wBw0vi9o58yiA1514u7M+PXdA2qXoYmjtRiUtKXK6qAkvsCW2wUnPkDtQ/D1frQd6TUAX6+0ax3Pn76qy9/KZI1BpHRmF8LQA0t3V6L2X0KglnPMFkGy5wcF6FqDKW1PC5rx3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SI2PR06MB5409.apcprd06.prod.outlook.com (2603:1096:4:1ec::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Wed, 27 Aug 2025 15:06:30 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 15:06:30 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] wifi: rtw89: use int type to store negative error codes
Date: Wed, 27 Aug 2025 23:06:19 +0800
Message-Id: <20250827150620.550641-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SI2PR06MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: afa94ad1-5e6b-4008-20ba-08dde57b4d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbgcYrT+SKjineodicdXg77HWNPZgsJGLM/v6vWnYKK6XYgb/K6Tk4TBMCJS?=
 =?us-ascii?Q?GdAkpalT5ntdDpugx0bSf3vf/ggRZK/vWKVdGBKFE3N8X4yQ7KlmwnqaZcOi?=
 =?us-ascii?Q?9DI4uK9ZOIhznnzGza2oOoRV4vk7QnM5i8yeB3MMTDWjf7zM+vHXxqioAlgG?=
 =?us-ascii?Q?H94XA8+FHMPJK44D3NWChqu5jFLELZwEc+tl9yuVlVL++ICGzV+X0SfvFj/F?=
 =?us-ascii?Q?fy2J70s6z9WtchoasWnAjKuabdkoAXBTw5zBE0z5QSPWL8jLNX4AjOi8knE5?=
 =?us-ascii?Q?2V2ps7g9yTdFF9Hnb66EzTI52DBlGz24Pz+3d4durA3rOLWViBPrT1+1tScg?=
 =?us-ascii?Q?OG65IZEXbSzAGBiwEvNqN1m3iodO6l/xqY80IxfnxHA5MX4LP0e1D+umszhv?=
 =?us-ascii?Q?fCMe/Q3Umowj6dUoAzJvX15/fVXjnKhxa7LJIeJSBr8yHoEe1yRN2oUKDt/r?=
 =?us-ascii?Q?cTZyvBdT/PnLOA+cTkD0Gu+HbNbNUSIAtOcc7mhnBoitlpoNmAqoIPd+S6RN?=
 =?us-ascii?Q?/Jznn5DFgzBd0fAFR/SVBWluqrPB1DSBsbeaDgGZCBQcUZPIbY/qg+L0R88V?=
 =?us-ascii?Q?ljzX24R0u9Klv6GzFMk/JBWzPqwXUXZfM3aLFOKlFjaSAy0YLT0nD+7SXXC9?=
 =?us-ascii?Q?WYcHbz/A/CWwl/5nzx2NGSj4SehH2TUtLxwcfQEO55xJPvtrk4Mb9+RZhaeB?=
 =?us-ascii?Q?1T7ZS775oD1OAEFr0x82uhuclPGzC1iyuvbaf1EGTfu9qVEyCpEf9BJySGC/?=
 =?us-ascii?Q?lX5eaosQH6qzsp8UXBhMB/MTE5GTbxk9L/L4loeU66GbMoB55/smRwQfn2yf?=
 =?us-ascii?Q?xrz/C6oX/1TXeX+XFme+x4XRKLlTd4OTNz4FrsFcyJmmjPrR1Khzi6I4ZAsX?=
 =?us-ascii?Q?9ceGhPMrcwCCmM13vNuv+SW2hU6Y4RRiP+ZufboBDW4GGJLDyiGy2AwyT+e4?=
 =?us-ascii?Q?KjyaEe9SzpUIHzQoyhc+fxrK/Yh+rZeX6ejJm/uH2lLSnLfQ6Yb2s1KCMJ7m?=
 =?us-ascii?Q?hBvpRWuq4D6M+GPet+DqMYyjyPGBEIhRXWlpv+YaglFzB6qler66zAfe1FMA?=
 =?us-ascii?Q?bGjV3qXu4gNRdbISRkaEulrUS4ogdhYcjOp1ylLUq8G69VTyz5wQAm4pIi6y?=
 =?us-ascii?Q?gXjH8LErLdlHC6+7CbnSTs21NKEK5qOR9bxjrET/+c4BA7LIGDEdwg5OOp8M?=
 =?us-ascii?Q?OxEFMLKNoA6/JDnsjyyVpaugq4GEe4RUyMtD0keCliIDCKPDxDpSASWqcK/D?=
 =?us-ascii?Q?SLr8k8EJwK7TKdvGgUlb1DAhpEzRDdwZyVHDq8hX3AACcrGtdEo7d5U0M7rm?=
 =?us-ascii?Q?Bla+e8aPE3fl89INZdVR+VxvST+wGPxS0ycOwqkPrX9DcBUyfQ5O9QjP+03T?=
 =?us-ascii?Q?E698i/Uk4T7d/Ph9aZYkeVoCEdZEaBa2z5V3VAT6gRyU3bEsirJS9F44uLvo?=
 =?us-ascii?Q?E9CTByohMdXo7FkfFyCd484vR7vLjGcTC2Q4kVfQocN+tBWsmXxmzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8ldORKhvvIojmStSSfgOP7mRSQ/Eooc5VABA8Glk1c0ADmxDwVec7rhlhUz?=
 =?us-ascii?Q?OGGt3ud4XGgeYjGagCR19+4P9O//QrB5PHIdLDg/DOTgmGRTtNhO1RQoeN1A?=
 =?us-ascii?Q?OqBIB2VIY6gnosWpw5L147bYgPVYeLcvaDl/whIWkStQ34h/TkvFXlW2auyh?=
 =?us-ascii?Q?v21w1rsTTi4Mipyt5nJG6EUE+bwfqtBSbk0xrXSOXa6mpT3RK0yP9kSUU4nP?=
 =?us-ascii?Q?0VvO+KzVGt9QUqU3Pai8uSTiYlRbd1ewtYHqsmnrnBRU+av/LIb5qNYfGSYT?=
 =?us-ascii?Q?08sLxRo6gIhP685RbG1N/vTh7wkTemgk75SGnVle5g8/EguFDMuASyPknDqh?=
 =?us-ascii?Q?YUoXvNUMeA9zsl/frLKDFjcKr+tNu8QECGciT3FtZaoa5yf/gaYa+N0c/DWz?=
 =?us-ascii?Q?P3EqtbNFjPSDSdS6gEKK785pGkhsswie2XOPFrSBltwlgsxAKWnz04qZsuWJ?=
 =?us-ascii?Q?AJlgFAixmk7OnPvSENGQbJtRBptLTeiAk60TGeFEWN8sVlKVA4THvo/h1mPm?=
 =?us-ascii?Q?Sni80NsSFbprf7mTV3x7dRNlEhRyQizHwNZj4nQr0gJKfVByfoledRM1E5tX?=
 =?us-ascii?Q?EGJ0WanfUgFOOyuzCMQBh5I0iQBkwvfNLqD4Rm4D9fGq6BcfEhFUSmVzytTe?=
 =?us-ascii?Q?4wh0U0qqiI68p+yWcnvc1EBt54JAYXUmuQpN3bFNzVyp8fz3v0P//qOOdglm?=
 =?us-ascii?Q?omYhoPLnmAv8VzFRHsVcNekNrhs7bRJb9LwBnWM3ELOaVykAAH5yQ5DO5Ixf?=
 =?us-ascii?Q?NCW8oIH/Koc1iSTanbw47CyEwGISegXY9++E88t4ZALo1oHojFyxYRP0ULwn?=
 =?us-ascii?Q?Uw6TSrAEqGbOOubK9DhAcfNXTCEkz+vFUuNoeDPgM+sN9zuoZHvDW3WtpLg8?=
 =?us-ascii?Q?OJ8kvWfAZ5wN5yz0IhK0xTCEFT/YO88qVKa9jSyP3xmFNDGaoiTwgyAP+I3v?=
 =?us-ascii?Q?iHMz2ytFAnmY2PuSemYH5UPrw4Lyw9JNlglj0icj8E/cTDJDqsWSvIG/GthT?=
 =?us-ascii?Q?73Fgl3xmgPP5qOMR/aoeAt57J3PrpLOmlkjkax7GxyChJs430f0C/nZ/XUou?=
 =?us-ascii?Q?GaStkfWGSELFbBnWGxsdya28tutq/Dk3UjSxgvxx6XTPRDO+Wz9qhRSCkgGX?=
 =?us-ascii?Q?WndEsogla4e2cuRayRWiUJRf7eVby7Vm5pB/2N4VPT/IPplH8/50MDisIfK2?=
 =?us-ascii?Q?/bLWFCIxhz4n1Ij65pH5HSkkpJMUH7+4U/04Mf5XJoQUoaOWa2d3++gOSO+R?=
 =?us-ascii?Q?nRF8llTLeQI2mViGwm7CR7UYP1lPig/1uCbiOJcmfg0L1kbiTOjKC3c+gjJw?=
 =?us-ascii?Q?U7RNytEzbwb20u6P5LWCa64jUHmp/VRsbcc/YEM6sFSO0Jyb6yGWSCHkl3vG?=
 =?us-ascii?Q?PFIyfO/3oaAMyBI8/7ag2oWb9Eltm31FPOy/Q/g7VC7f+63SBNaE/x2pnAIK?=
 =?us-ascii?Q?FcZEslsKAPBqsh8jo7QixY06tLl8DBen3r83eWLyofea/2IJC2cPkGfDSv4t?=
 =?us-ascii?Q?+8hQE4sZ8fm/HoK7sSrO3jKa/xx54OsXsChepOk3tK103lq5kCvjTWsJx6pf?=
 =?us-ascii?Q?gRJsX5jbdFYZAo2S6LbZk1oFgNdP5tvgedMxtGBg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa94ad1-5e6b-4008-20ba-08dde57b4d81
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:06:30.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xibZAWDmraaBIHZrxIi3Tk9WO26l3vFjMM7A4sXk25FdFAfM7e3L6rwJI/1m1IT7poPA+Ris/QO/GC7N7qFegg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5409

The 'ret' variable stores returns from other functions, which return
either zero on success or negative error codes on failure.  Storing
error codes in u32 (an unsigned type) causes no runtime issues but is
stylistically inconsistent and very ugly.  Change 'ret' from u32 to
int - this has no runtime impact.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Adjust the position of the 'ret' definition to maintain reverse
    X'mas tree order.
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  7 ++++---
 drivers/net/wireless/realtek/rtw89/mac.c | 16 ++++++++--------
 drivers/net/wireless/realtek/rtw89/pci.c |  6 +++---
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 16e59a4a486e..804039d709f9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1537,7 +1537,7 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
 	struct rtw89_fw_hdr *fw_hdr;
 	struct sk_buff *skb;
 	u32 truncated;
-	u32 ret = 0;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -6826,8 +6826,9 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const u32 *c2h_reg = chip->c2h_regs;
-	u32 ret, timeout;
+	u32 timeout;
 	u8 i, val;
+	int ret;
 
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
index 5a5da9d9c0c5..876e3cf7250c 100644
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
@@ -1176,8 +1176,8 @@ int rtw89_mac_hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_e
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 dma_ch_mask = chip->dma_ch_mask;
+	int ret = 0;
 	u8 ch;
-	u32 ret = 0;
 
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
@@ -3105,10 +3105,10 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
 				  u16 tx_en_u16, u16 mask_u16)
 {
-	u32 ret;
 	struct rtw89_mac_c2h_info c2h_info = {0};
 	struct rtw89_mac_h2c_info h2c_info = {0};
 	struct rtw89_h2creg_sch_tx_en *sch_tx_en = &h2c_info.u.sch_tx_en;
+	int ret;
 
 	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_SCH_TX_EN;
 	h2c_info.content_len = sizeof(*sch_tx_en) - RTW89_H2CREG_HDR_LEN;
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
index a669f2f843aa..d0dd56c47339 100644
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
@@ -4172,7 +4172,7 @@ static int rtw89_pci_lv1rst_start_dma_ax(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_pci_ctrl_dma_all(rtwdev, true);
-	return ret;
+	return 0;
 }
 
 static int rtw89_pci_ops_mac_lv1_recovery(struct rtw89_dev *rtwdev,
-- 
2.34.1


