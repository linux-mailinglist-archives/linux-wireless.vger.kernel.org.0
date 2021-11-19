Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C762E4569D6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 06:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhKSFtF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 00:49:05 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51316 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhKSFtF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 00:49:05 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AJ5jnRI3019489, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AJ5jnRI3019489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Nov 2021 13:45:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Nov 2021 13:45:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 19 Nov
 2021 13:45:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tiwai@suse.de>,
        <Larry.Finger@lwfinger.net>
Subject: [PATCH v3 2/3] rtw89: add const in the cast of le32_get_bits()
Date:   Fri, 19 Nov 2021 13:45:11 +0800
Message-ID: <20211119054512.10620-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119054512.10620-1-pkshih@realtek.com>
References: <20211119054512.10620-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/19/2021 05:32:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzE4IKRVpMggMTA6MzA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/19/2021 05:29:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167351 [Nov 19 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/19/2021 05:32:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 'const' to be clear that this is a read-only access, and this patch
doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtw89/fw.h   | 68 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/txrx.h | 46 +++++++--------
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 36e8d0da6c1e7..2a9953d1ae0cd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -252,36 +252,36 @@ struct rtw89_h2creg_sch_tx_en {
 #define FW_EDCA_PARAM_AIFS_MSK GENMASK(7, 0)
 
 #define GET_FWSECTION_HDR_SEC_SIZE(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(23, 0))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(23, 0))
 #define GET_FWSECTION_HDR_CHECKSUM(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 1), BIT(28))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), BIT(28))
 #define GET_FWSECTION_HDR_REDL(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 1), BIT(29))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), BIT(29))
 #define GET_FWSECTION_HDR_DL_ADDR(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr)), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(fwhdr)), GENMASK(31, 0))
 
 #define GET_FW_HDR_MAJOR_VERSION(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(7, 0))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(7, 0))
 #define GET_FW_HDR_MINOR_VERSION(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(15, 8))
 #define GET_FW_HDR_SUBVERSION(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(23, 16))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(23, 16))
 #define GET_FW_HDR_SUBINDEX(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(31, 24))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(31, 24))
 #define GET_FW_HDR_MONTH(fwhdr)		\
-	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(7, 0))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(7, 0))
 #define GET_FW_HDR_DATE(fwhdr)		\
-	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(15, 8))
 #define GET_FW_HDR_HOUR(fwhdr)		\
-	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(23, 16))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(23, 16))
 #define GET_FW_HDR_MIN(fwhdr)		\
-	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(31, 24))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(31, 24))
 #define GET_FW_HDR_YEAR(fwhdr)		\
-	le32_get_bits(*((__le32 *)(fwhdr) + 5), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 5), GENMASK(31, 0))
 #define GET_FW_HDR_SEC_NUM(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 6), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 6), GENMASK(15, 8))
 #define GET_FW_HDR_CMD_VERSERION(fwhdr)	\
-	le32_get_bits(*((__le32 *)(fwhdr) + 7), GENMASK(31, 24))
+	le32_get_bits(*((const __le32 *)(fwhdr) + 7), GENMASK(31, 24))
 static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
 {
 	le32p_replace_bits((__le32 *)fwhdr + 7, val, GENMASK(15, 0));
@@ -1170,49 +1170,49 @@ enum rtw89_btc_cxdrvinfo {
 #define RTW89_C2H_HEADER_LEN 8
 
 #define RTW89_GET_C2H_CATEGORY(c2h) \
-	le32_get_bits(*((__le32 *)c2h), GENMASK(1, 0))
+	le32_get_bits(*((const __le32 *)c2h), GENMASK(1, 0))
 #define RTW89_GET_C2H_CLASS(c2h) \
-	le32_get_bits(*((__le32 *)c2h), GENMASK(7, 2))
+	le32_get_bits(*((const __le32 *)c2h), GENMASK(7, 2))
 #define RTW89_GET_C2H_FUNC(c2h) \
-	le32_get_bits(*((__le32 *)c2h), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)c2h), GENMASK(15, 8))
 #define RTW89_GET_C2H_LEN(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 1), GENMASK(13, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 1), GENMASK(13, 0))
 
 #define RTW89_GET_C2H_LOG_SRT_PRT(c2h) (char *)((__le32 *)(c2h) + 2)
 #define RTW89_GET_C2H_LOG_LEN(len) ((len) - RTW89_C2H_HEADER_LEN)
 
 #define RTW89_GET_MAC_C2H_DONE_ACK_CAT(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(1, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
 #define RTW89_GET_MAC_C2H_DONE_ACK_CLASS(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(7, 2))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 2))
 #define RTW89_GET_MAC_C2H_DONE_ACK_FUNC(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 #define RTW89_GET_MAC_C2H_DONE_ACK_H2C_RETURN(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(23, 16))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
 #define RTW89_GET_MAC_C2H_DONE_ACK_H2C_SEQ(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(31, 24))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 24))
 
 #define RTW89_GET_MAC_C2H_REV_ACK_CAT(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(1, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
 #define RTW89_GET_MAC_C2H_REV_ACK_CLASS(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(7, 2))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 2))
 #define RTW89_GET_MAC_C2H_REV_ACK_FUNC(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 #define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(23, 16))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
 
 #define RTW89_GET_PHY_C2H_RA_RPT_MACID(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(15, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 0))
 #define RTW89_GET_PHY_C2H_RA_RPT_RETRY_RATIO(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(23, 16))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
 #define RTW89_GET_PHY_C2H_RA_RPT_MCSNSS(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(6, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(6, 0))
 #define RTW89_GET_PHY_C2H_RA_RPT_MD_SEL(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(9, 8))
+	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(9, 8))
 #define RTW89_GET_PHY_C2H_RA_RPT_GILTF(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(12, 10))
+	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(12, 10))
 #define RTW89_GET_PHY_C2H_RA_RPT_BW(c2h) \
-	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(14, 13))
+	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(14, 13))
 
 /* VHT, HE, HT-old: [6:4]: NSS, [3:0]: MCS
  * HT-new: [6:5]: NA, [4:0]: MCS
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index f1e0fe36107de..5570d8ccf136a 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -140,52 +140,52 @@
 	le32_get_bits((rxdesc)->dword5, GENMASK(7, 0))
 
 #define RTW89_GET_RXINFO_USR_NUM(rpt) \
-	le32_get_bits(*((__le32 *)rpt), GENMASK(3, 0))
+	le32_get_bits(*((const __le32 *)rpt), GENMASK(3, 0))
 #define RTW89_GET_RXINFO_FW_DEFINE(rpt) \
-	le32_get_bits(*((__le32 *)rpt), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)rpt), GENMASK(15, 8))
 #define RTW89_GET_RXINFO_LSIG_LEN(rpt) \
-	le32_get_bits(*((__le32 *)rpt), GENMASK(27, 16))
+	le32_get_bits(*((const __le32 *)rpt), GENMASK(27, 16))
 #define RTW89_GET_RXINFO_IS_TO_SELF(rpt) \
-	le32_get_bits(*((__le32 *)rpt), BIT(28))
+	le32_get_bits(*((const __le32 *)rpt), BIT(28))
 #define RTW89_GET_RXINFO_RX_CNT_VLD(rpt) \
-	le32_get_bits(*((__le32 *)rpt), BIT(29))
+	le32_get_bits(*((const __le32 *)rpt), BIT(29))
 #define RTW89_GET_RXINFO_LONG_RXD(rpt) \
-	le32_get_bits(*((__le32 *)rpt), GENMASK(31, 30))
+	le32_get_bits(*((const __le32 *)rpt), GENMASK(31, 30))
 #define RTW89_GET_RXINFO_SERVICE(rpt) \
-	le32_get_bits(*((__le32 *)(rpt) + 1), GENMASK(15, 0))
+	le32_get_bits(*((const __le32 *)(rpt) + 1), GENMASK(15, 0))
 #define RTW89_GET_RXINFO_PLCP_LEN(rpt) \
-	le32_get_bits(*((__le32 *)(rpt) + 1), GENMASK(23, 16))
+	le32_get_bits(*((const __le32 *)(rpt) + 1), GENMASK(23, 16))
 #define RTW89_GET_RXINFO_MAC_ID_VALID(rpt, usr) \
-	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(0))
+	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(0))
 #define RTW89_GET_RXINFO_DATA(rpt, usr) \
-	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(1))
+	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(1))
 #define RTW89_GET_RXINFO_CTRL(rpt, usr) \
-	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(2))
+	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(2))
 #define RTW89_GET_RXINFO_MGMT(rpt, usr) \
-	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(3))
+	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(3))
 #define RTW89_GET_RXINFO_BCM(rpt, usr) \
-	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), BIT(4))
+	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(4))
 #define RTW89_GET_RXINFO_MACID(rpt, usr) \
-	le32_get_bits(*((__le32 *)(rpt) + (usr) + 2), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), GENMASK(15, 8))
 
 #define RTW89_GET_PHY_STS_RSSI_A(sts) \
-	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(7, 0))
+	le32_get_bits(*((const __le32 *)(sts) + 1), GENMASK(7, 0))
 #define RTW89_GET_PHY_STS_RSSI_B(sts) \
-	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(sts) + 1), GENMASK(15, 8))
 #define RTW89_GET_PHY_STS_RSSI_C(sts) \
-	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(23, 16))
+	le32_get_bits(*((const __le32 *)(sts) + 1), GENMASK(23, 16))
 #define RTW89_GET_PHY_STS_RSSI_D(sts) \
-	le32_get_bits(*((__le32 *)(sts) + 1), GENMASK(31, 24))
+	le32_get_bits(*((const __le32 *)(sts) + 1), GENMASK(31, 24))
 #define RTW89_GET_PHY_STS_LEN(sts) \
-	le32_get_bits(*((__le32 *)sts), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)sts), GENMASK(15, 8))
 #define RTW89_GET_PHY_STS_RSSI_AVG(sts) \
-	le32_get_bits(*((__le32 *)sts), GENMASK(31, 24))
+	le32_get_bits(*((const __le32 *)sts), GENMASK(31, 24))
 #define RTW89_GET_PHY_STS_IE_TYPE(ie) \
-	le32_get_bits(*((__le32 *)ie), GENMASK(4, 0))
+	le32_get_bits(*((const __le32 *)ie), GENMASK(4, 0))
 #define RTW89_GET_PHY_STS_IE_LEN(ie) \
-	le32_get_bits(*((__le32 *)ie), GENMASK(11, 5))
+	le32_get_bits(*((const __le32 *)ie), GENMASK(11, 5))
 #define RTW89_GET_PHY_STS_IE0_CFO(ie) \
-	le32_get_bits(*((__le32 *)(ie) + 1), GENMASK(31, 20))
+	le32_get_bits(*((const __le32 *)(ie) + 1), GENMASK(31, 20))
 
 enum rtw89_tx_channel {
 	RTW89_TXCH_ACH0	= 0,
-- 
2.25.1

