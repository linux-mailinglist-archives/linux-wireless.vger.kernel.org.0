Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA844DF2F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 01:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhKLAiT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 19:38:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40270 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbhKLAiS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 19:38:18 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AC0ZGksC001113, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AC0ZGksC001113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Nov 2021 08:35:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 08:35:14 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 12 Nov
 2021 08:35:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tiwai@suse.de>,
        <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 1/3] rtw89: update partition size of firmware header on skb->data
Date:   Fri, 12 Nov 2021 08:34:51 +0800
Message-ID: <20211112003453.5073-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112003453.5073-1-pkshih@realtek.com>
References: <20211112003453.5073-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/12/2021 00:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzExIKRVpMggMTA6MzA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/12/2021 00:15:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167215 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;bugzilla.opensuse.org:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/12/2021 00:17:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The partition size is used to tell hardware the size of piece we are going
to send a firmware. The old code updates the size in constant buffer of
firmware, and leads system crash.

To fix this, update the size on skb->data after we copy the firmware data
into skb.

Buglink: https://bugzilla.opensuse.org/show_bug.cgi?id=1188303
Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 drivers/net/wireless/realtek/rtw89/fw.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 212aaf577d3c5..65ef3dc9d0614 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -91,7 +91,6 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 	info->section_num = GET_FW_HDR_SEC_NUM(fw);
 	info->hdr_len = RTW89_FW_HDR_SIZE +
 			info->section_num * RTW89_FW_SECTION_HDR_SIZE;
-	SET_FW_HDR_PART_SIZE(fw, FWDL_SECTION_PER_PKT_LEN);
 
 	bin = fw + info->hdr_len;
 
@@ -275,6 +274,7 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 	}
 
 	skb_put_data(skb, fw, len);
+	SET_FW_HDR_PART_SIZE(skb->data, FWDL_SECTION_PER_PKT_LEN);
 	rtw89_h2c_pkt_set_hdr_fwdl(rtwdev, skb, FWCMD_TYPE_H2C,
 				   H2C_CAT_MAC, H2C_CL_MAC_FWDL,
 				   H2C_FUNC_MAC_FWHDR_DL, len);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 7ee0d93233107..36e8d0da6c1e7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -282,8 +282,10 @@ struct rtw89_h2creg_sch_tx_en {
 	le32_get_bits(*((__le32 *)(fwhdr) + 6), GENMASK(15, 8))
 #define GET_FW_HDR_CMD_VERSERION(fwhdr)	\
 	le32_get_bits(*((__le32 *)(fwhdr) + 7), GENMASK(31, 24))
-#define SET_FW_HDR_PART_SIZE(fwhdr, val)	\
-	le32p_replace_bits((__le32 *)(fwhdr) + 7, val, GENMASK(15, 0))
+static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
+{
+	le32p_replace_bits((__le32 *)fwhdr + 7, val, GENMASK(15, 0));
+}
 
 #define SET_CTRL_INFO_MACID(table, val) \
 	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0))
-- 
2.25.1

