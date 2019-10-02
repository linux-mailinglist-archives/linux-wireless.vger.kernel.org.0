Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F013C47D8
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfJBGfv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57725 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfJBGft (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:49 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926Zhrv013103, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926Zhrv013103
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:43 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:42 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 12/14] rtw88: use struct rtw_fw_hdr to access firmware header
Date:   Wed, 2 Oct 2019 14:35:29 +0800
Message-ID: <20191002063531.18135-13-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This commit doesn't change logic at all, just use struct rtw_fw_hdr to
access fixed part of 64 bytes header. Since remaining part is variable
length data of actual firmware, we don't define them within the struct.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.h  | 45 +++++++++++++++---------
 drivers/net/wireless/realtek/rtw88/mac.c | 37 +++++++++----------
 2 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index fd34986a13d2..4f7999394235 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -11,22 +11,6 @@
 /* FW bin information */
 #define FW_HDR_SIZE			64
 #define FW_HDR_CHKSUM_SIZE		8
-#define FW_HDR_VERSION			4
-#define FW_HDR_SUBVERSION		6
-#define FW_HDR_SUBINDEX			7
-#define FW_HDR_MONTH			16
-#define FW_HDR_DATE			17
-#define FW_HDR_HOUR			18
-#define FW_HDR_MIN			19
-#define FW_HDR_YEAR			20
-#define FW_HDR_MEM_USAGE		24
-#define FW_HDR_H2C_FMT_VER		28
-#define FW_HDR_DMEM_ADDR		32
-#define FW_HDR_DMEM_SIZE		36
-#define FW_HDR_IMEM_SIZE		48
-#define FW_HDR_EMEM_SIZE		52
-#define FW_HDR_EMEM_ADDR		56
-#define FW_HDR_IMEM_ADDR		60
 
 #define FIFO_PAGE_SIZE_SHIFT		12
 #define FIFO_PAGE_SIZE			4096
@@ -116,6 +100,35 @@ struct rtw_rsvd_page {
 	bool add_txdesc;
 };
 
+struct rtw_fw_hdr {
+	__le16 signature;
+	u8 category;
+	u8 function;
+	__le16 version;		/* 0x04 */
+	u8 subversion;
+	u8 subindex;
+	__le32 rsvd;		/* 0x08 */
+	__le32 rsvd2;		/* 0x0C */
+	u8 month;		/* 0x10 */
+	u8 day;
+	u8 hour;
+	u8 min;
+	__le16 year;		/* 0x14 */
+	__le16 rsvd3;
+	u8 mem_usage;		/* 0x18 */
+	u8 rsvd4[3];
+	__le16 h2c_fmt_ver;	/* 0x1C */
+	__le16 rsvd5;
+	__le32 dmem_addr;	/* 0x20 */
+	__le32 dmem_size;
+	__le32 rsvd6;
+	__le32 rsvd7;
+	__le32 imem_size;	/* 0x30 */
+	__le32 emem_size;
+	__le32 emem_addr;
+	__le32 imem_addr;
+};
+
 /* C2H */
 #define GET_CCX_REPORT_SEQNUM(c2h_payload)	(c2h_payload[8] & 0xfc)
 #define GET_CCX_REPORT_STATUS(c2h_payload)	(c2h_payload[9] & 0xc0)
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 75f35a97dca7..aa1f15e18c7a 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -312,15 +312,16 @@ void rtw_mac_power_off(struct rtw_dev *rtwdev)
 
 static bool check_firmware_size(const u8 *data, u32 size)
 {
+	const struct rtw_fw_hdr *fw_hdr = (const struct rtw_fw_hdr *)data;
 	u32 dmem_size;
 	u32 imem_size;
 	u32 emem_size;
 	u32 real_size;
 
-	dmem_size = le32_to_cpu(*((__le32 *)(data + FW_HDR_DMEM_SIZE)));
-	imem_size = le32_to_cpu(*((__le32 *)(data + FW_HDR_IMEM_SIZE)));
-	emem_size = ((*(data + FW_HDR_MEM_USAGE)) & BIT(4)) ?
-		    le32_to_cpu(*((__le32 *)(data + FW_HDR_EMEM_SIZE))) : 0;
+	dmem_size = le32_to_cpu(fw_hdr->dmem_size);
+	imem_size = le32_to_cpu(fw_hdr->imem_size);
+	emem_size = (fw_hdr->mem_usage & BIT(4)) ?
+		    le32_to_cpu(fw_hdr->emem_size) : 0;
 
 	dmem_size += FW_HDR_CHKSUM_SIZE;
 	imem_size += FW_HDR_CHKSUM_SIZE;
@@ -569,14 +570,13 @@ download_firmware_to_mem(struct rtw_dev *rtwdev, const u8 *data,
 static void update_firmware_info(struct rtw_dev *rtwdev,
 				 struct rtw_fw_state *fw)
 {
-	const u8 *data = fw->firmware->data;
+	const struct rtw_fw_hdr *fw_hdr =
+				(const struct rtw_fw_hdr *)fw->firmware->data;
 
-	fw->h2c_version =
-		le16_to_cpu(*((__le16 *)(data + FW_HDR_H2C_FMT_VER)));
-	fw->version =
-		le16_to_cpu(*((__le16 *)(data + FW_HDR_VERSION)));
-	fw->sub_version = *(data + FW_HDR_SUBVERSION);
-	fw->sub_index = *(data + FW_HDR_SUBINDEX);
+	fw->h2c_version = le16_to_cpu(fw_hdr->h2c_fmt_ver);
+	fw->version = le16_to_cpu(fw_hdr->version);
+	fw->sub_version = fw_hdr->subversion;
+	fw->sub_index = fw_hdr->subindex;
 
 	rtw_info(rtwdev, "Firmware version %u.%u.%u, H2C version %u\n",
 		 fw->version, fw->sub_version, fw->sub_index, fw->h2c_version);
@@ -585,6 +585,7 @@ static void update_firmware_info(struct rtw_dev *rtwdev,
 static int
 start_download_firmware(struct rtw_dev *rtwdev, const u8 *data, u32 size)
 {
+	const struct rtw_fw_hdr *fw_hdr = (const struct rtw_fw_hdr *)data;
 	const u8 *cur_fw;
 	u16 val;
 	u32 imem_size;
@@ -593,10 +594,10 @@ start_download_firmware(struct rtw_dev *rtwdev, const u8 *data, u32 size)
 	u32 addr;
 	int ret;
 
-	dmem_size = le32_to_cpu(*((__le32 *)(data + FW_HDR_DMEM_SIZE)));
-	imem_size = le32_to_cpu(*((__le32 *)(data + FW_HDR_IMEM_SIZE)));
-	emem_size = ((*(data + FW_HDR_MEM_USAGE)) & BIT(4)) ?
-		    le32_to_cpu(*((__le32 *)(data + FW_HDR_EMEM_SIZE))) : 0;
+	dmem_size = le32_to_cpu(fw_hdr->dmem_size);
+	imem_size = le32_to_cpu(fw_hdr->imem_size);
+	emem_size = (fw_hdr->mem_usage & BIT(4)) ?
+		    le32_to_cpu(fw_hdr->emem_size) : 0;
 	dmem_size += FW_HDR_CHKSUM_SIZE;
 	imem_size += FW_HDR_CHKSUM_SIZE;
 	emem_size += emem_size ? FW_HDR_CHKSUM_SIZE : 0;
@@ -606,14 +607,14 @@ start_download_firmware(struct rtw_dev *rtwdev, const u8 *data, u32 size)
 	rtw_write16(rtwdev, REG_MCUFW_CTRL, val);
 
 	cur_fw = data + FW_HDR_SIZE;
-	addr = le32_to_cpu(*((__le32 *)(data + FW_HDR_DMEM_ADDR)));
+	addr = le32_to_cpu(fw_hdr->dmem_addr);
 	addr &= ~BIT(31);
 	ret = download_firmware_to_mem(rtwdev, cur_fw, 0, addr, dmem_size);
 	if (ret)
 		return ret;
 
 	cur_fw = data + FW_HDR_SIZE + dmem_size;
-	addr = le32_to_cpu(*((__le32 *)(data + FW_HDR_IMEM_ADDR)));
+	addr = le32_to_cpu(fw_hdr->imem_addr);
 	addr &= ~BIT(31);
 	ret = download_firmware_to_mem(rtwdev, cur_fw, 0, addr, imem_size);
 	if (ret)
@@ -621,7 +622,7 @@ start_download_firmware(struct rtw_dev *rtwdev, const u8 *data, u32 size)
 
 	if (emem_size) {
 		cur_fw = data + FW_HDR_SIZE + dmem_size + imem_size;
-		addr = le32_to_cpu(*((__le32 *)(data + FW_HDR_EMEM_ADDR)));
+		addr = le32_to_cpu(fw_hdr->emem_addr);
 		addr &= ~BIT(31);
 		ret = download_firmware_to_mem(rtwdev, cur_fw, 0, addr,
 					       emem_size);
-- 
2.17.1

