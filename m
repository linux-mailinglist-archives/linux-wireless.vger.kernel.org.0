Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA7278072
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 08:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgIYGTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 02:19:34 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39824 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIYGTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 02:19:33 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P6CNvR4010490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P6CNvR4010490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 14:12:23 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 25 Sep 2020 14:12:22 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <yhchuang@realtek.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] rtw88: add dump fw crash log
Date:   Fri, 25 Sep 2020 14:12:18 +0800
Message-ID: <20200925061219.23754-5-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925061219.23754-1-tehuang@realtek.com>
References: <20200925061219.23754-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

This patch adds a function which is able to dump firmware fifo when
firmware crashes. If firmware needs more than one time to dump all logs,
it will set a bit called "more bit" in the header of the first log, and
driver needs to set a register to inform firmware that it is ready for the
next dump.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.h   | 14 ++++++
 drivers/net/wireless/realtek/rtw88/main.c | 61 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h |  4 ++
 drivers/net/wireless/realtek/rtw88/reg.h  |  2 +
 4 files changed, 81 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 9c4863c011ba..08644540d259 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -507,6 +507,20 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define SET_NLO_LOC_NLO_INFO(h2c_pkt, value)                                   \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
 
+#define GET_FW_DUMP_LEN(_header)					\
+	le32_get_bits(*((__le32 *)(_header) + 0x00), GENMASK(15, 0))
+#define GET_FW_DUMP_SEQ(_header)					\
+	le32_get_bits(*((__le32 *)(_header) + 0x00), GENMASK(22, 16))
+#define GET_FW_DUMP_MORE(_header)					\
+	le32_get_bits(*((__le32 *)(_header) + 0x00), BIT(23))
+#define GET_FW_DUMP_VERSION(_header)					\
+	le32_get_bits(*((__le32 *)(_header) + 0x00), GENMASK(31, 24))
+#define GET_FW_DUMP_TLV_TYPE(_header)					\
+	le32_get_bits(*((__le32 *)(_header) + 0x01), GENMASK(15, 0))
+#define GET_FW_DUMP_TLV_LEN(_header)					\
+	le32_get_bits(*((__le32 *)(_header) + 0x01), GENMASK(31, 16))
+#define GET_FW_DUMP_TLV_VAL(_header)					\
+	le32_get_bits(*((__le32 *)(_header) + 0x02), GENMASK(31, 0))
 static inline struct rtw_c2h_cmd *get_c2h_from_skb(struct sk_buff *skb)
 {
 	u32 pkt_offset;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index ba16da557363..1434a90edbd0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -317,6 +317,56 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		 sta->addr, si->mac_id);
 }
 
+static bool rtw_fw_dump_crash_log(struct rtw_dev *rtwdev)
+{
+	u32 size = rtwdev->chip->fw_rxff_size;
+	u32 *buf;
+	u8 seq;
+	bool ret = true;
+
+	buf = vmalloc(size);
+	if (!buf)
+		goto exit;
+
+	if (rtw_fw_dump_fifo(rtwdev, RTW_FW_FIFO_SEL_RXBUF_FW, 0, size, buf)) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "dump fw fifo fail\n");
+		goto free_buf;
+	}
+
+	if (GET_FW_DUMP_LEN(buf) == 0) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "fw crash dump's length is 0\n");
+		goto free_buf;
+	}
+
+	seq = GET_FW_DUMP_SEQ(buf);
+	if (seq > 0 && seq != (rtwdev->fw.prev_dump_seq + 1)) {
+		rtw_dbg(rtwdev, RTW_DBG_FW,
+			"fw crash dump's seq is wrong: %d\n", seq);
+		goto free_buf;
+	}
+	if (seq == 0 &&
+	    (GET_FW_DUMP_TLV_TYPE(buf) != FW_CD_TYPE ||
+	     GET_FW_DUMP_TLV_LEN(buf) != FW_CD_LEN ||
+	     GET_FW_DUMP_TLV_VAL(buf) != FW_CD_VAL)) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "fw crash dump's tlv is wrong\n");
+		goto free_buf;
+	}
+
+	print_hex_dump_bytes("rtw88 fw dump: ", DUMP_PREFIX_OFFSET, buf, size);
+
+	if (GET_FW_DUMP_MORE(buf) == 1) {
+		rtwdev->fw.prev_dump_seq = seq;
+		ret = false;
+	}
+
+free_buf:
+	vfree(buf);
+exit:
+	rtw_write8(rtwdev, REG_MCU_TST_CFG, 0);
+
+	return ret;
+}
+
 void rtw_vif_assoc_changed(struct rtw_vif *rtwvif,
 			   struct ieee80211_bss_conf *conf)
 {
@@ -373,6 +423,17 @@ static void rtw_fw_recovery_work(struct work_struct *work)
 	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
 					      fw_recovery_work);
 
+	/* rtw_fw_dump_crash_log() returns false indicates that there are
+	 * still more log to dump. Driver set 0x1cf[7:0] = 0x1 to tell firmware
+	 * to dump the remaining part of the log, and firmware will trigger an
+	 * IMR_C2HCMD interrupt to inform driver the log is ready.
+	 */
+	if (!rtw_fw_dump_crash_log(rtwdev)) {
+		rtw_write8(rtwdev, REG_HRCV_MSG, 1);
+		return;
+	}
+	rtwdev->fw.prev_dump_seq = 0;
+
 	WARN(1, "firmware crash, start reset and recover\n");
 
 	mutex_lock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 06bdc68555e7..ffb02e614217 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1621,6 +1621,9 @@ struct rtw_fifo_conf {
 	const struct rtw_rqpn *rqpn;
 };
 
+#define FW_CD_TYPE 0xffff
+#define FW_CD_LEN 4
+#define FW_CD_VAL 0xaabbccdd
 struct rtw_fw_state {
 	const struct firmware *firmware;
 	struct rtw_dev *rtwdev;
@@ -1629,6 +1632,7 @@ struct rtw_fw_state {
 	u8 sub_version;
 	u8 sub_index;
 	u16 h2c_version;
+	u8 prev_dump_seq;
 };
 
 struct rtw_hal {
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 9a696ac17d69..86b94c008a27 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -619,6 +619,8 @@
 #define BIT_ANAPAR_BTPS	BIT(22)
 #define REG_RSTB_SEL	0x1c38
 
+#define REG_HRCV_MSG	0x1cf
+
 #define REG_IGN_GNTBT4	0x4160
 
 #define RF_MODE		0x00
-- 
2.17.1

