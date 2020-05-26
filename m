Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781111B35B9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 05:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgDVDqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 23:46:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37003 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgDVDqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M3kAzC5004569, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M3kAzC5004569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 11:46:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:09 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 1/8] rtw88: add legacy firmware download for 8723D devices
Date:   Wed, 22 Apr 2020 11:46:00 +0800
Message-ID: <20200422034607.28747-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422034607.28747-1-yhchuang@realtek.com>
References: <20200422034607.28747-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The WLAN CPU of 8723D device is different from others, add legacy
firmware download function for it. A new variable wlan_cpu is used to
decide which firmware download function we should use.

Legacy firmware file contains 32 bytes header including version and
subversion. When downloading to wlan cpu, header is excluded.

Firmware is downloaded via beacon queue to reserved page that is a part of
TX buffer. Since 11N WLAN CPU uses different control registers, this patch
introduces related control registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  21 ++-
 drivers/net/wireless/realtek/rtw88/fw.h       |  25 +++
 drivers/net/wireless/realtek/rtw88/mac.c      | 146 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.c     |  41 ++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  16 ++
 drivers/net/wireless/realtek/rtw88/reg.h      |  11 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   1 +
 9 files changed, 252 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 245da96dfddc..209853fdcb42 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1079,6 +1079,8 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	u8 bckp[2];
 	u8 val;
 	u16 rsvd_pg_head;
+	u32 bcn_valid_addr;
+	u32 bcn_valid_mask;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -1086,8 +1088,13 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 	if (!size)
 		return -EINVAL;
 
-	pg_addr &= BIT_MASK_BCN_HEAD_1_V1;
-	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2, pg_addr | BIT_BCN_VALID_V1);
+	if (rtw_chip_wcpu_11n(rtwdev)) {
+		rtw_write32_set(rtwdev, REG_DWBCN0_CTRL, BIT_BCN_VALID);
+	} else {
+		pg_addr &= BIT_MASK_BCN_HEAD_1_V1;
+		pg_addr |= BIT_BCN_VALID_V1;
+		rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2, pg_addr);
+	}
 
 	val = rtw_read8(rtwdev, REG_CR + 1);
 	bckp[0] = val;
@@ -1105,7 +1112,15 @@ int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 		goto restore;
 	}
 
-	if (!check_hw_ready(rtwdev, REG_FIFOPAGE_CTRL_2, BIT_BCN_VALID_V1, 1)) {
+	if (rtw_chip_wcpu_11n(rtwdev)) {
+		bcn_valid_addr = REG_DWBCN0_CTRL;
+		bcn_valid_mask = BIT_BCN_VALID;
+	} else {
+		bcn_valid_addr = REG_FIFOPAGE_CTRL_2;
+		bcn_valid_mask = BIT_BCN_VALID_V1;
+	}
+
+	if (!check_hw_ready(rtwdev, bcn_valid_addr, bcn_valid_mask, 1)) {
 		rtw_err(rtwdev, "error beacon valid\n");
 		ret = -EBUSY;
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index cdd244857048..2933ef741e53 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -19,6 +19,12 @@
 #define RSVD_PAGE_START_ADDR		0x780
 #define FIFO_DUMP_ADDR			0x8000
 
+#define DLFW_PAGE_SIZE_SHIFT_LEGACY	12
+#define DLFW_PAGE_SIZE_LEGACY		0x1000
+#define DLFW_BLK_SIZE_SHIFT_LEGACY	2
+#define DLFW_BLK_SIZE_LEGACY		4
+#define FW_START_ADDR_LEGACY		0x1000
+
 enum rtw_c2h_cmd_id {
 	C2H_BT_INFO = 0x09,
 	C2H_BT_MP_INFO = 0x0b,
@@ -192,6 +198,25 @@ struct rtw_fw_hdr {
 	__le32 imem_addr;
 } __packed;
 
+struct rtw_fw_hdr_legacy {
+	__le16 signature;
+	u8 category;
+	u8 function;
+	__le16 version;	/* 0x04 */
+	u8 subversion1;
+	u8 subversion2;
+	u8 month;	/* 0x08 */
+	u8 day;
+	u8 hour;
+	u8 minute;
+	__le16 size;
+	__le16 rsvd2;
+	__le32 idx;	/* 0x10 */
+	__le32 rsvd3;
+	__le32 rsvd4;	/* 0x18 */
+	__le32 rsvd5;
+} __packed;
+
 /* C2H */
 #define GET_CCX_REPORT_SEQNUM(c2h_payload)	(c2h_payload[8] & 0xfc)
 #define GET_CCX_REPORT_STATUS(c2h_payload)	(c2h_payload[9] & 0xc0)
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 7b245779ff90..6092604abfb9 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -650,7 +650,7 @@ static void download_firmware_end_flow(struct rtw_dev *rtwdev)
 	rtw_write16(rtwdev, REG_MCUFW_CTRL, fw_ctrl);
 }
 
-int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+int __rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 {
 	struct rtw_backup_info bckp[DLFW_RESTORE_REG_NUM];
 	const u8 *data = fw->firmware->data;
@@ -704,6 +704,150 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 	return ret;
 }
 
+static void en_download_firmware_legacy(struct rtw_dev *rtwdev, bool en)
+{
+	int try;
+
+	if (en) {
+		wlan_cpu_enable(rtwdev, false);
+		wlan_cpu_enable(rtwdev, true);
+
+		rtw_write8_set(rtwdev, REG_MCUFW_CTRL, BIT_MCUFWDL_EN);
+
+		for (try = 0; try < 10; try++) {
+			if (rtw_read8(rtwdev, REG_MCUFW_CTRL) & BIT_MCUFWDL_EN)
+				goto fwdl_ready;
+			rtw_write8_set(rtwdev, REG_MCUFW_CTRL, BIT_MCUFWDL_EN);
+			msleep(20);
+		}
+		rtw_err(rtwdev, "failed to check fw download ready\n");
+fwdl_ready:
+		rtw_write32_clr(rtwdev, REG_MCUFW_CTRL, BIT_ROM_DLEN);
+	} else {
+		rtw_write8_clr(rtwdev, REG_MCUFW_CTRL, BIT_MCUFWDL_EN);
+	}
+}
+
+static void
+write_firmware_page(struct rtw_dev *rtwdev, u32 page, const u8 *data, u32 size)
+{
+	u32 val32;
+	u32 block_nr;
+	u32 remain_size;
+	u32 write_addr = FW_START_ADDR_LEGACY;
+	const __le32 *ptr = (const __le32 *)data;
+	u32 block;
+	__le32 remain_data = 0;
+
+	block_nr = size >> DLFW_BLK_SIZE_SHIFT_LEGACY;
+	remain_size = size & (DLFW_BLK_SIZE_LEGACY - 1);
+
+	val32 = rtw_read32(rtwdev, REG_MCUFW_CTRL);
+	val32 &= ~BIT_ROM_PGE;
+	val32 |= (page << BIT_SHIFT_ROM_PGE) & BIT_ROM_PGE;
+	rtw_write32(rtwdev, REG_MCUFW_CTRL, val32);
+
+	for (block = 0; block < block_nr; block++) {
+		rtw_write32(rtwdev, write_addr, le32_to_cpu(*ptr));
+
+		write_addr += DLFW_BLK_SIZE_LEGACY;
+		ptr++;
+	}
+
+	if (remain_size) {
+		memcpy(&remain_data, ptr, remain_size);
+		rtw_write32(rtwdev, write_addr, le32_to_cpu(remain_data));
+	}
+}
+
+static int
+download_firmware_legacy(struct rtw_dev *rtwdev, const u8 *data, u32 size)
+{
+	u32 page;
+	u32 total_page;
+	u32 last_page_size;
+
+	data += sizeof(struct rtw_fw_hdr_legacy);
+	size -= sizeof(struct rtw_fw_hdr_legacy);
+
+	total_page = size >> DLFW_PAGE_SIZE_SHIFT_LEGACY;
+	last_page_size = size & (DLFW_PAGE_SIZE_LEGACY - 1);
+
+	rtw_write8_set(rtwdev, REG_MCUFW_CTRL, BIT_FWDL_CHK_RPT);
+
+	for (page = 0; page < total_page; page++) {
+		write_firmware_page(rtwdev, page, data, DLFW_PAGE_SIZE_LEGACY);
+		data += DLFW_PAGE_SIZE_LEGACY;
+	}
+	if (last_page_size)
+		write_firmware_page(rtwdev, page, data, last_page_size);
+
+	if (!check_hw_ready(rtwdev, REG_MCUFW_CTRL, BIT_FWDL_CHK_RPT, 1)) {
+		rtw_err(rtwdev, "failed to check download fimrware report\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int download_firmware_validate_legacy(struct rtw_dev *rtwdev)
+{
+	u32 val32;
+	int try;
+
+	val32 = rtw_read32(rtwdev, REG_MCUFW_CTRL);
+	val32 |= BIT_MCUFWDL_RDY;
+	val32 &= ~BIT_WINTINI_RDY;
+	rtw_write32(rtwdev, REG_MCUFW_CTRL, val32);
+
+	wlan_cpu_enable(rtwdev, false);
+	wlan_cpu_enable(rtwdev, true);
+
+	for (try = 0; try < 10; try++) {
+		val32 = rtw_read32(rtwdev, REG_MCUFW_CTRL);
+		if ((val32 & FW_READY_LEGACY) == FW_READY_LEGACY)
+			return 0;
+		msleep(20);
+	}
+
+	rtw_err(rtwdev, "failed to validate fimrware\n");
+	return -EINVAL;
+}
+
+int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+{
+	int ret = 0;
+
+	en_download_firmware_legacy(rtwdev, true);
+	ret = download_firmware_legacy(rtwdev, fw->firmware->data, fw->firmware->size);
+	en_download_firmware_legacy(rtwdev, false);
+	if (ret)
+		goto out;
+
+	ret = download_firmware_validate_legacy(rtwdev);
+	if (ret)
+		goto out;
+
+	/* reset desc and index */
+	rtw_hci_setup(rtwdev);
+
+	rtwdev->h2c.last_box_num = 0;
+	rtwdev->h2c.seq = 0;
+
+	set_bit(RTW_FLAG_FW_RUNNING, rtwdev->flags);
+
+out:
+	return ret;
+}
+
+int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+{
+	if (rtw_chip_wcpu_11n(rtwdev))
+		return __rtw_download_firmware_legacy(rtwdev, fw);
+
+	return __rtw_download_firmware(rtwdev, fw);
+}
+
 static u32 get_priority_queues(struct rtw_dev *rtwdev, u32 queues)
 {
 	const struct rtw_rqpn *rqpn = rtwdev->fifo.rqpn;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c851830132d0..b0dadff0dc7b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1042,11 +1042,43 @@ static void rtw_unset_supported_band(struct ieee80211_hw *hw,
 	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
 }
 
+static void __update_firmware_info(struct rtw_dev *rtwdev,
+				   struct rtw_fw_state *fw)
+{
+	const struct rtw_fw_hdr *fw_hdr =
+				(const struct rtw_fw_hdr *)fw->firmware->data;
+
+	fw->h2c_version = le16_to_cpu(fw_hdr->h2c_fmt_ver);
+	fw->version = le16_to_cpu(fw_hdr->version);
+	fw->sub_version = fw_hdr->subversion;
+	fw->sub_index = fw_hdr->subindex;
+}
+
+static void __update_firmware_info_legacy(struct rtw_dev *rtwdev,
+					  struct rtw_fw_state *fw)
+{
+	struct rtw_fw_hdr_legacy *legacy =
+				(struct rtw_fw_hdr_legacy *)fw->firmware->data;
+
+	fw->h2c_version = 0;
+	fw->version = le16_to_cpu(legacy->version);
+	fw->sub_version = legacy->subversion1;
+	fw->sub_index = legacy->subversion2;
+}
+
+static void update_firmware_info(struct rtw_dev *rtwdev,
+				 struct rtw_fw_state *fw)
+{
+	if (rtw_chip_wcpu_11n(rtwdev))
+		__update_firmware_info_legacy(rtwdev, fw);
+	else
+		__update_firmware_info(rtwdev, fw);
+}
+
 static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 {
 	struct rtw_fw_state *fw = context;
 	struct rtw_dev *rtwdev = fw->rtwdev;
-	const struct rtw_fw_hdr *fw_hdr;
 
 	if (!firmware || !firmware->data) {
 		rtw_err(rtwdev, "failed to request firmware\n");
@@ -1054,13 +1086,8 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 		return;
 	}
 
-	fw_hdr = (const struct rtw_fw_hdr *)firmware->data;
-	fw->h2c_version = le16_to_cpu(fw_hdr->h2c_fmt_ver);
-	fw->version = le16_to_cpu(fw_hdr->version);
-	fw->sub_version = fw_hdr->subversion;
-	fw->sub_index = fw_hdr->subindex;
-
 	fw->firmware = firmware;
+	update_firmware_info(rtwdev, fw);
 	complete_all(&fw->completion);
 
 	rtw_info(rtwdev, "Firmware version %u.%u.%u, H2C version %u\n",
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 74302181da53..380a670eeeee 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1056,12 +1056,18 @@ struct rtw_pwr_track_tbl {
 	const u8 *pwrtrk_2g_ccka_p;
 };
 
+enum rtw_wlan_cpu {
+	RTW_WCPU_11AC,
+	RTW_WCPU_11N,
+};
+
 /* hardware configuration for each IC */
 struct rtw_chip_info {
 	struct rtw_chip_ops *ops;
 	u8 id;
 
 	const char *fw_name;
+	enum rtw_wlan_cpu wlan_cpu;
 	u8 tx_pkt_desc_sz;
 	u8 tx_buf_desc_sz;
 	u8 rx_pkt_desc_sz;
@@ -1725,6 +1731,16 @@ static inline void rtw_chip_efuse_grant_off(struct rtw_dev *rtwdev)
 		rtwdev->chip->ops->efuse_grant(rtwdev, false);
 }
 
+static inline bool rtw_chip_wcpu_11n(struct rtw_dev *rtwdev)
+{
+	return rtwdev->chip->wlan_cpu == RTW_WCPU_11N;
+}
+
+static inline bool rtw_chip_wcpu_11ac(struct rtw_dev *rtwdev)
+{
+	return rtwdev->chip->wlan_cpu == RTW_WCPU_11AC;
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 911d8e75db77..89868ac0748f 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -77,19 +77,28 @@
 #define BIT_ANA_PORT_EN		BIT(22)
 #define BIT_MAC_PORT_EN		BIT(21)
 #define BIT_BOOT_FSPI_EN	BIT(20)
+#define BIT_ROM_DLEN		BIT(19)
+#define BIT_ROM_PGE		GENMASK(18, 16)	/* legacy only */
+#define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
 #define BIT_RPWM_TOGGLE		BIT(7)
+#define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
+#define BIT_WINTINI_RDY		BIT(6)	/* legacy only */
 #define BIT_DMEM_DW_OK		BIT(5)
 #define BIT_IMEM_CHKSUM_OK	BIT(4)
 #define BIT_IMEM_DW_OK		BIT(3)
 #define BIT_IMEM_BOOT_LOAD_CHECKSUM_OK BIT(2)
+#define BIT_FWDL_CHK_RPT	BIT(2)	/* legacy only */
+#define BIT_MCUFWDL_RDY		BIT(1)	/* legacy only */
 #define BIT_MCUFWDL_EN		BIT(0)
 #define BIT_CHECK_SUM_OK	(BIT(4) | BIT(6))
 #define FW_READY		(BIT_FW_INIT_RDY | BIT_FW_DW_RDY |             \
 				 BIT_IMEM_DW_OK | BIT_DMEM_DW_OK |             \
 				 BIT_CHECK_SUM_OK)
+#define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
+				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
 #define FW_READY_MASK		0xffff
 
 #define REG_EFUSE_ACCESS	0x00CF
@@ -197,6 +206,8 @@
 #define BIT_MASK_BCN_HEAD_1_V1	0xfff
 #define REG_AUTO_LLT_V1		0x0208
 #define BIT_AUTO_INIT_LLT_V1	BIT(0)
+#define REG_DWBCN0_CTRL		0x0208
+#define BIT_BCN_VALID		BIT(16)
 #define REG_TXDMA_OFFSET_CHK	0x020C
 #define REG_TXDMA_STATUS	0x0210
 #define BTI_PAGE_OVF		BIT(2)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index c25cabbab64d..5e8e0dd6456e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -511,6 +511,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
 	.fw_name = "rtw88/rtw8723d_fw.bin",
+	.wlan_cpu = RTW_WCPU_11N,
 	.tx_pkt_desc_sz = 40,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 9a2e18e7624f..ffee8111d145 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2408,6 +2408,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
 	.fw_name = "rtw88/rtw8822b_fw.bin",
+	.wlan_cpu = RTW_WCPU_11AC,
 	.tx_pkt_desc_sz = 48,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index ee0d39135617..8dd92136145d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4269,6 +4269,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
 	.fw_name = "rtw88/rtw8822c_fw.bin",
+	.wlan_cpu = RTW_WCPU_11AC,
 	.tx_pkt_desc_sz = 48,
 	.tx_buf_desc_sz = 16,
 	.rx_pkt_desc_sz = 24,
-- 
2.17.1

