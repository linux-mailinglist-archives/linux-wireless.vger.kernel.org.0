Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E9A7A749C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjITHpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjITHpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:45:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8BE5
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:52 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7iiwB7803319, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7iiwB7803319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 20 Sep 2023 15:44:43 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: load TX power related tables from FW elements
Date:   Wed, 20 Sep 2023 15:43:22 +0800
Message-ID: <20230920074322.42898-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920074322.42898-1-pkshih@realtek.com>
References: <20230920074322.42898-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The following FW elements are recognized, and then the valid entries
in them are loaded into SW struct case by case.
* TX power by rate
* TX power limit 2 GHz
* TX power limit 5 GHz
* TX power limit 6 GHz
* TX power limit RU 2 GHz
* TX power limit RU 5 GHz
* TX power limit RU 6 GHz
* TX shape limit
* TX shape limit RU
One single firmware file can contain multiples of each of the above FW
elements. Each of them is configured with a target RFE (RF front end)
type. We choose one of the multiples to load based on RFE type. If there
are multiples of the same FW elements with the same target RFE type. The
last one will be applied.

We don't want to have many loading variants for above FW elements. Even if
between different chips or between different generations, we would like to
maintain only one single set of loadings. So, the loadings are designed to
consider compatibility. The main concepts are listed below.
* The driver structures, which are used to cast binary entry from FW,
  cannot insert new members in the middle. If there are something new,
  they should always be appended at the tail.
* Each binary entry from FW uses a dictionary way containing a key set
  and a data. The keys in the key set indicate where to put the data.
* If size of driver struct and size of binary entry do not match when
  loading, it means the number of keys in the key set are different.
  Then, we deal with compatibility. No matter which one has more keys,
  we take/use zero on those mismatched keys.
  If driver struct is bigger (backward compatibility):
  	e.g. SW uses two keys, but FW is built with one key.
	Then, put the data of FW(keyX) into SW[keyX][0].
  If binary entry is bigger (forward compatibility):
  	e.g. FW is built with two keys, but SW uses one key.
  	Then, only take the data of FW(keyX, keyY = 0) into SW[keyX]

Besides, chip info setup flow is tweaked a bit for the following.
* Before loading FW elements, we need to determine chip RFE via efuse.
* Setting up RFE parameters depends on loading FW elements ahead.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  15 +-
 drivers/net/wireless/realtek/rtw89/core.h |  90 ++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 530 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 130 ++++++
 drivers/net/wireless/realtek/rtw89/phy.c  |   1 -
 drivers/net/wireless/realtek/rtw89/phy.h  |   3 +
 6 files changed, 761 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f9467adf0a14..03704c4752a5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4027,8 +4027,8 @@ static void rtw89_core_setup_rfe_parms(struct rtw89_dev *rtwdev)
 	sel = chip->dflt_parms;
 
 out:
-	rtwdev->rfe_parms = sel;
-	rtw89_load_txpwr_table(rtwdev, sel->byr_tbl);
+	rtwdev->rfe_parms = rtw89_load_rfe_data_from_fw(rtwdev, sel);
+	rtw89_load_txpwr_table(rtwdev, rtwdev->rfe_parms->byr_tbl);
 }
 
 static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
@@ -4052,7 +4052,6 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_core_setup_phycap(rtwdev);
-	rtw89_core_setup_rfe_parms(rtwdev);
 
 	rtw89_mac_pwr_off(rtwdev);
 
@@ -4084,20 +4083,21 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	ret = rtw89_chip_efuse_info_setup(rtwdev);
+	if (ret)
+		return ret;
+
 	ret = rtw89_fw_recognize_elements(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to recognize firmware elements\n");
 		return ret;
 	}
 
-	ret = rtw89_chip_efuse_info_setup(rtwdev);
-	if (ret)
-		return ret;
-
 	ret = rtw89_chip_board_info_setup(rtwdev);
 	if (ret)
 		return ret;
 
+	rtw89_core_setup_rfe_parms(rtwdev);
 	rtwdev->ps_mode = rtw89_update_ps_mode(rtwdev);
 
 	return 0;
@@ -4309,6 +4309,7 @@ EXPORT_SYMBOL(rtw89_alloc_ieee80211_hw);
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev)
 {
 	kfree(rtwdev->ops);
+	kfree(rtwdev->rfe_data);
 	release_firmware(rtwdev->fw.req.firmware);
 	ieee80211_free_hw(rtwdev->hw);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4ab7abfa8b1f..ac09785c21a6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3400,6 +3400,95 @@ struct rtw89_rfe_parms_conf {
 	u8 rfe_type;
 };
 
+#define RTW89_TXPWR_CONF_DFLT_RFE_TYPE 0x0
+
+struct rtw89_txpwr_conf {
+	u8 rfe_type;
+	u8 ent_sz;
+	u32 num_ents;
+	const void *data;
+};
+
+#define rtw89_txpwr_conf_valid(conf) (!!(conf)->data)
+
+#define rtw89_for_each_in_txpwr_conf(entry, cursor, conf) \
+	for (typecheck(const void *, cursor), (cursor) = (conf)->data, \
+	     memcpy(&(entry), cursor, \
+		    min_t(u8, sizeof(entry), (conf)->ent_sz)); \
+	     (cursor) < (conf)->data + (conf)->num_ents * (conf)->ent_sz; \
+	     (cursor) += (conf)->ent_sz, \
+	     memcpy(&(entry), cursor, \
+		    min_t(u8, sizeof(entry), (conf)->ent_sz)))
+
+struct rtw89_txpwr_byrate_data {
+	struct rtw89_txpwr_conf conf;
+	struct rtw89_txpwr_table tbl;
+};
+
+struct rtw89_txpwr_lmt_2ghz_data {
+	struct rtw89_txpwr_conf conf;
+	s8 v[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
+	    [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+	    [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
+};
+
+struct rtw89_txpwr_lmt_5ghz_data {
+	struct rtw89_txpwr_conf conf;
+	s8 v[RTW89_5G_BW_NUM][RTW89_NTX_NUM]
+	    [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+	    [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+};
+
+struct rtw89_txpwr_lmt_6ghz_data {
+	struct rtw89_txpwr_conf conf;
+	s8 v[RTW89_6G_BW_NUM][RTW89_NTX_NUM]
+	    [RTW89_RS_LMT_NUM][RTW89_BF_NUM]
+	    [RTW89_REGD_NUM][NUM_OF_RTW89_REG_6GHZ_POWER]
+	    [RTW89_6G_CH_NUM];
+};
+
+struct rtw89_txpwr_lmt_ru_2ghz_data {
+	struct rtw89_txpwr_conf conf;
+	s8 v[RTW89_RU_NUM][RTW89_NTX_NUM]
+	    [RTW89_REGD_NUM][RTW89_2G_CH_NUM];
+};
+
+struct rtw89_txpwr_lmt_ru_5ghz_data {
+	struct rtw89_txpwr_conf conf;
+	s8 v[RTW89_RU_NUM][RTW89_NTX_NUM]
+	    [RTW89_REGD_NUM][RTW89_5G_CH_NUM];
+};
+
+struct rtw89_txpwr_lmt_ru_6ghz_data {
+	struct rtw89_txpwr_conf conf;
+	s8 v[RTW89_RU_NUM][RTW89_NTX_NUM]
+	    [RTW89_REGD_NUM][NUM_OF_RTW89_REG_6GHZ_POWER]
+	    [RTW89_6G_CH_NUM];
+};
+
+struct rtw89_tx_shape_lmt_data {
+	struct rtw89_txpwr_conf conf;
+	u8 v[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
+};
+
+struct rtw89_tx_shape_lmt_ru_data {
+	struct rtw89_txpwr_conf conf;
+	u8 v[RTW89_BAND_NUM][RTW89_REGD_NUM];
+};
+
+struct rtw89_rfe_data {
+	struct rtw89_txpwr_byrate_data byrate;
+	struct rtw89_txpwr_lmt_2ghz_data lmt_2ghz;
+	struct rtw89_txpwr_lmt_5ghz_data lmt_5ghz;
+	struct rtw89_txpwr_lmt_6ghz_data lmt_6ghz;
+	struct rtw89_txpwr_lmt_ru_2ghz_data lmt_ru_2ghz;
+	struct rtw89_txpwr_lmt_ru_5ghz_data lmt_ru_5ghz;
+	struct rtw89_txpwr_lmt_ru_6ghz_data lmt_ru_6ghz;
+	struct rtw89_tx_shape_lmt_data tx_shape_lmt;
+	struct rtw89_tx_shape_lmt_ru_data tx_shape_lmt_ru;
+	struct rtw89_rfe_parms rfe_parms;
+};
+
 struct rtw89_page_regs {
 	u32 hci_fc_ctrl;
 	u32 ch_page_ctrl;
@@ -4582,6 +4671,7 @@ struct rtw89_dev {
 	struct rtw89_hci_info hci;
 	struct rtw89_efuse efuse;
 	struct rtw89_traffic_stats stats;
+	struct rtw89_rfe_data *rfe_data;
 
 	/* ensures exclusive access from mac80211 callbacks */
 	struct mutex mutex;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0f6ac26870b5..f5e7475af381 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -601,6 +601,49 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 	return -ENOMEM;
 }
 
+static
+int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
+				      const struct rtw89_fw_element_hdr *elm,
+				      const void *data)
+{
+	const struct __rtw89_fw_txpwr_element *txpwr_elm = &elm->u.txpwr;
+	const unsigned long offset = (const unsigned long)data;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw89_txpwr_conf *conf;
+
+	if (!rtwdev->rfe_data) {
+		rtwdev->rfe_data = kzalloc(sizeof(*rtwdev->rfe_data), GFP_KERNEL);
+		if (!rtwdev->rfe_data)
+			return -ENOMEM;
+	}
+
+	conf = (void *)rtwdev->rfe_data + offset;
+
+	/* if multiple matched, take the last eventually */
+	if (txpwr_elm->rfe_type == efuse->rfe_type)
+		goto setup;
+
+	/* without one is matched, accept default */
+	if (txpwr_elm->rfe_type == RTW89_TXPWR_CONF_DFLT_RFE_TYPE &&
+	    (!rtw89_txpwr_conf_valid(conf) ||
+	     conf->rfe_type == RTW89_TXPWR_CONF_DFLT_RFE_TYPE))
+		goto setup;
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "skip txpwr element ID %u RFE %u\n",
+		    elm->id, txpwr_elm->rfe_type);
+	return 0;
+
+setup:
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "take txpwr element ID %u RFE %u\n",
+		    elm->id, txpwr_elm->rfe_type);
+
+	conf->rfe_type = txpwr_elm->rfe_type;
+	conf->ent_sz = txpwr_elm->ent_sz;
+	conf->num_ents = le32_to_cpu(txpwr_elm->num_ents);
+	conf->data = txpwr_elm->content;
+	return 0;
+}
+
 struct rtw89_fw_element_handler {
 	int (*fn)(struct rtw89_dev *rtwdev,
 		  const struct rtw89_fw_element_hdr *elm, const void *data);
@@ -624,6 +667,42 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_RADIO_D] = {rtw89_build_phy_tbl_from_elm,
 					 (const void *)RF_PATH_D, NULL},
 	[RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm, NULL, "NCTL"},
+	[RTW89_FW_ELEMENT_ID_TXPWR_BYRATE] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, byrate.conf), "TXPWR",
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, lmt_2ghz.conf), NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, lmt_5ghz.conf), NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, lmt_6ghz.conf), NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf), NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_5ghz.conf), NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf), NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf), NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		(const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf), NULL,
+	},
 };
 
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
@@ -4666,3 +4745,454 @@ int rtw89_fw_h2c_mcc_set_duration(struct rtw89_dev *rtwdev,
 	cond = RTW89_MCC_WAIT_COND(p->group, H2C_FUNC_MCC_SET_DURATION);
 	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
 }
+
+static bool __fw_txpwr_entry_zero_ext(const void *ext_ptr, u8 ext_len)
+{
+	static const u8 zeros[U8_MAX] = {};
+
+	return memcmp(ext_ptr, zeros, ext_len) == 0;
+}
+
+#define __fw_txpwr_entry_acceptable(e, cursor, ent_sz)	\
+({							\
+	u8 __var_sz = sizeof(*(e));			\
+	bool __accept;					\
+	if (__var_sz >= (ent_sz))			\
+		__accept = true;			\
+	else						\
+		__accept = __fw_txpwr_entry_zero_ext((cursor) + __var_sz,\
+						     (ent_sz) - __var_sz);\
+	__accept;					\
+})
+
+static bool
+fw_txpwr_byrate_entry_valid(const struct rtw89_fw_txpwr_byrate_entry *e,
+			    const void *cursor,
+			    const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->band >= RTW89_BAND_NUM || e->bw >= RTW89_BYR_BW_NUM)
+		return false;
+
+	switch (e->rs) {
+	case RTW89_RS_CCK:
+		if (e->shf + e->len > RTW89_RATE_CCK_NUM)
+			return false;
+		break;
+	case RTW89_RS_OFDM:
+		if (e->shf + e->len > RTW89_RATE_OFDM_NUM)
+			return false;
+		break;
+	case RTW89_RS_MCS:
+		if (e->shf + e->len > __RTW89_RATE_MCS_NUM ||
+		    e->nss >= RTW89_NSS_NUM ||
+		    e->ofdma >= RTW89_OFDMA_NUM)
+			return false;
+		break;
+	case RTW89_RS_HEDCM:
+		if (e->shf + e->len > RTW89_RATE_HEDCM_NUM ||
+		    e->nss >= RTW89_NSS_HEDCM_NUM ||
+		    e->ofdma >= RTW89_OFDMA_NUM)
+			return false;
+		break;
+	case RTW89_RS_OFFSET:
+		if (e->shf + e->len > __RTW89_RATE_OFFSET_NUM)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static
+void rtw89_fw_load_txpwr_byrate(struct rtw89_dev *rtwdev,
+				const struct rtw89_txpwr_table *tbl)
+{
+	const struct rtw89_txpwr_conf *conf = tbl->data;
+	struct rtw89_fw_txpwr_byrate_entry entry = {};
+	struct rtw89_txpwr_byrate *byr_head;
+	struct rtw89_rate_desc desc = {};
+	const void *cursor;
+	u32 data;
+	s8 *byr;
+	int i;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_txpwr_byrate_entry_valid(&entry, cursor, conf))
+			continue;
+
+		byr_head = &rtwdev->byr[entry.band][entry.bw];
+		data = le32_to_cpu(entry.data);
+		desc.ofdma = entry.ofdma;
+		desc.nss = entry.nss;
+		desc.rs = entry.rs;
+
+		for (i = 0; i < entry.len; i++, data >>= 8) {
+			desc.idx = entry.shf + i;
+			byr = rtw89_phy_raw_byr_seek(rtwdev, byr_head, &desc);
+			*byr = data & 0xff;
+		}
+	}
+}
+
+static bool
+fw_txpwr_lmt_2ghz_entry_valid(const struct rtw89_fw_txpwr_lmt_2ghz_entry *e,
+			      const void *cursor,
+			      const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->bw >= RTW89_2G_BW_NUM)
+		return false;
+	if (e->nt >= RTW89_NTX_NUM)
+		return false;
+	if (e->rs >= RTW89_RS_LMT_NUM)
+		return false;
+	if (e->bf >= RTW89_BF_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+	if (e->ch_idx >= RTW89_2G_CH_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_txpwr_lmt_2ghz(struct rtw89_txpwr_lmt_2ghz_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_txpwr_lmt_2ghz_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_txpwr_lmt_2ghz_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.bw][entry.nt][entry.rs][entry.bf][entry.regd]
+		       [entry.ch_idx] = entry.v;
+	}
+}
+
+static bool
+fw_txpwr_lmt_5ghz_entry_valid(const struct rtw89_fw_txpwr_lmt_5ghz_entry *e,
+			      const void *cursor,
+			      const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->bw >= RTW89_5G_BW_NUM)
+		return false;
+	if (e->nt >= RTW89_NTX_NUM)
+		return false;
+	if (e->rs >= RTW89_RS_LMT_NUM)
+		return false;
+	if (e->bf >= RTW89_BF_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+	if (e->ch_idx >= RTW89_5G_CH_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_txpwr_lmt_5ghz(struct rtw89_txpwr_lmt_5ghz_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_txpwr_lmt_5ghz_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_txpwr_lmt_5ghz_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.bw][entry.nt][entry.rs][entry.bf][entry.regd]
+		       [entry.ch_idx] = entry.v;
+	}
+}
+
+static bool
+fw_txpwr_lmt_6ghz_entry_valid(const struct rtw89_fw_txpwr_lmt_6ghz_entry *e,
+			      const void *cursor,
+			      const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->bw >= RTW89_6G_BW_NUM)
+		return false;
+	if (e->nt >= RTW89_NTX_NUM)
+		return false;
+	if (e->rs >= RTW89_RS_LMT_NUM)
+		return false;
+	if (e->bf >= RTW89_BF_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+	if (e->reg_6ghz_power >= NUM_OF_RTW89_REG_6GHZ_POWER)
+		return false;
+	if (e->ch_idx >= RTW89_6G_CH_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_txpwr_lmt_6ghz(struct rtw89_txpwr_lmt_6ghz_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_txpwr_lmt_6ghz_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_txpwr_lmt_6ghz_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.bw][entry.nt][entry.rs][entry.bf][entry.regd]
+		       [entry.reg_6ghz_power][entry.ch_idx] = entry.v;
+	}
+}
+
+static bool
+fw_txpwr_lmt_ru_2ghz_entry_valid(const struct rtw89_fw_txpwr_lmt_ru_2ghz_entry *e,
+				 const void *cursor,
+				 const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->ru >= RTW89_RU_NUM)
+		return false;
+	if (e->nt >= RTW89_NTX_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+	if (e->ch_idx >= RTW89_2G_CH_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_txpwr_lmt_ru_2ghz(struct rtw89_txpwr_lmt_ru_2ghz_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_txpwr_lmt_ru_2ghz_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_txpwr_lmt_ru_2ghz_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.ru][entry.nt][entry.regd][entry.ch_idx] = entry.v;
+	}
+}
+
+static bool
+fw_txpwr_lmt_ru_5ghz_entry_valid(const struct rtw89_fw_txpwr_lmt_ru_5ghz_entry *e,
+				 const void *cursor,
+				 const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->ru >= RTW89_RU_NUM)
+		return false;
+	if (e->nt >= RTW89_NTX_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+	if (e->ch_idx >= RTW89_5G_CH_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_txpwr_lmt_ru_5ghz(struct rtw89_txpwr_lmt_ru_5ghz_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_txpwr_lmt_ru_5ghz_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_txpwr_lmt_ru_5ghz_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.ru][entry.nt][entry.regd][entry.ch_idx] = entry.v;
+	}
+}
+
+static bool
+fw_txpwr_lmt_ru_6ghz_entry_valid(const struct rtw89_fw_txpwr_lmt_ru_6ghz_entry *e,
+				 const void *cursor,
+				 const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->ru >= RTW89_RU_NUM)
+		return false;
+	if (e->nt >= RTW89_NTX_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+	if (e->reg_6ghz_power >= NUM_OF_RTW89_REG_6GHZ_POWER)
+		return false;
+	if (e->ch_idx >= RTW89_6G_CH_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_txpwr_lmt_ru_6ghz(struct rtw89_txpwr_lmt_ru_6ghz_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_txpwr_lmt_ru_6ghz_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_txpwr_lmt_ru_6ghz_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.ru][entry.nt][entry.regd][entry.reg_6ghz_power]
+		       [entry.ch_idx] = entry.v;
+	}
+}
+
+static bool
+fw_tx_shape_lmt_entry_valid(const struct rtw89_fw_tx_shape_lmt_entry *e,
+			    const void *cursor,
+			    const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->band >= RTW89_BAND_NUM)
+		return false;
+	if (e->tx_shape_rs >= RTW89_RS_TX_SHAPE_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_tx_shape_lmt(struct rtw89_tx_shape_lmt_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_tx_shape_lmt_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_tx_shape_lmt_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.band][entry.tx_shape_rs][entry.regd] = entry.v;
+	}
+}
+
+static bool
+fw_tx_shape_lmt_ru_entry_valid(const struct rtw89_fw_tx_shape_lmt_ru_entry *e,
+			       const void *cursor,
+			       const struct rtw89_txpwr_conf *conf)
+{
+	if (!__fw_txpwr_entry_acceptable(e, cursor, conf->ent_sz))
+		return false;
+
+	if (e->band >= RTW89_BAND_NUM)
+		return false;
+	if (e->regd >= RTW89_REGD_NUM)
+		return false;
+
+	return true;
+}
+
+static
+void rtw89_fw_load_tx_shape_lmt_ru(struct rtw89_tx_shape_lmt_ru_data *data)
+{
+	const struct rtw89_txpwr_conf *conf = &data->conf;
+	struct rtw89_fw_tx_shape_lmt_ru_entry entry = {};
+	const void *cursor;
+
+	rtw89_for_each_in_txpwr_conf(entry, cursor, conf) {
+		if (!fw_tx_shape_lmt_ru_entry_valid(&entry, cursor, conf))
+			continue;
+
+		data->v[entry.band][entry.regd] = entry.v;
+	}
+}
+
+const struct rtw89_rfe_parms *
+rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
+			    const struct rtw89_rfe_parms *init)
+{
+	struct rtw89_rfe_data *rfe_data = rtwdev->rfe_data;
+	struct rtw89_rfe_parms *parms;
+
+	if (!rfe_data)
+		return init;
+
+	parms = &rfe_data->rfe_parms;
+	if (init)
+		*parms = *init;
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->byrate.conf)) {
+		rfe_data->byrate.tbl.data = &rfe_data->byrate.conf;
+		rfe_data->byrate.tbl.size = 0; /* don't care here */
+		rfe_data->byrate.tbl.load = rtw89_fw_load_txpwr_byrate;
+		parms->byr_tbl = &rfe_data->byrate.tbl;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->lmt_2ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_2ghz(&rfe_data->lmt_2ghz);
+		parms->rule_2ghz.lmt = &rfe_data->lmt_2ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->lmt_5ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_5ghz(&rfe_data->lmt_5ghz);
+		parms->rule_5ghz.lmt = &rfe_data->lmt_5ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->lmt_6ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_6ghz(&rfe_data->lmt_6ghz);
+		parms->rule_6ghz.lmt = &rfe_data->lmt_6ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->lmt_ru_2ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_ru_2ghz(&rfe_data->lmt_ru_2ghz);
+		parms->rule_2ghz.lmt_ru = &rfe_data->lmt_ru_2ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->lmt_ru_5ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_ru_5ghz(&rfe_data->lmt_ru_5ghz);
+		parms->rule_5ghz.lmt_ru = &rfe_data->lmt_ru_5ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->lmt_ru_6ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_ru_6ghz(&rfe_data->lmt_ru_6ghz);
+		parms->rule_6ghz.lmt_ru = &rfe_data->lmt_ru_6ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->tx_shape_lmt.conf)) {
+		rtw89_fw_load_tx_shape_lmt(&rfe_data->tx_shape_lmt);
+		parms->tx_shape.lmt = &rfe_data->tx_shape_lmt.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->tx_shape_lmt_ru.conf)) {
+		rtw89_fw_load_tx_shape_lmt_ru(&rfe_data->tx_shape_lmt_ru);
+		parms->tx_shape.lmt_ru = &rfe_data->tx_shape_lmt_ru.v;
+	}
+
+	return parms;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index f965e2423447..d4db9ab0b5e8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3417,10 +3417,46 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_RADIO_C = 6,
 	RTW89_FW_ELEMENT_ID_RADIO_D = 7,
 	RTW89_FW_ELEMENT_ID_RF_NCTL = 8,
+	RTW89_FW_ELEMENT_ID_TXPWR_BYRATE = 9,
+	RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ = 10,
+	RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ = 11,
+	RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ = 12,
+	RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ = 13,
+	RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ = 14,
+	RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ = 15,
+	RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT = 16,
+	RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU = 17,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
 
+#define BITS_OF_RTW89_TXPWR_FW_ELEMENTS \
+	(BIT(RTW89_FW_ELEMENT_ID_TXPWR_BYRATE) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU))
+
+#define RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS (BIT(RTW89_FW_ELEMENT_ID_BBMCU0) | \
+					     BIT(RTW89_FW_ELEMENT_ID_BB_REG) | \
+					     BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
+					     BIT(RTW89_FW_ELEMENT_ID_RADIO_B) | \
+					     BIT(RTW89_FW_ELEMENT_ID_RF_NCTL) | \
+					     BITS_OF_RTW89_TXPWR_FW_ELEMENTS)
+
+struct __rtw89_fw_txpwr_element {
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rfe_type;
+	u8 ent_sz;
+	__le32 num_ents;
+	u8 content[];
+} __packed;
+
 struct rtw89_fw_element_hdr {
 	__le32 id; /* enum rtw89_fw_element_id */
 	__le32 size; /* exclude header size */
@@ -3441,6 +3477,7 @@ struct rtw89_fw_element_hdr {
 				__le32 data;
 			} __packed regs[];
 		} __packed reg2;
+		struct __rtw89_fw_txpwr_element txpwr;
 	} __packed u;
 } __packed;
 
@@ -3778,4 +3815,97 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 		rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(rtwdev);
 }
 
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_txpwr_byrate_entry {
+	u8 band;
+	u8 nss;
+	u8 rs;
+	u8 shf;
+	u8 len;
+	__le32 data;
+	u8 bw;
+	u8 ofdma;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_txpwr_lmt_2ghz_entry {
+	u8 bw;
+	u8 nt;
+	u8 rs;
+	u8 bf;
+	u8 regd;
+	u8 ch_idx;
+	s8 v;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_txpwr_lmt_5ghz_entry {
+	u8 bw;
+	u8 nt;
+	u8 rs;
+	u8 bf;
+	u8 regd;
+	u8 ch_idx;
+	s8 v;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_txpwr_lmt_6ghz_entry {
+	u8 bw;
+	u8 nt;
+	u8 rs;
+	u8 bf;
+	u8 regd;
+	u8 reg_6ghz_power;
+	u8 ch_idx;
+	s8 v;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_txpwr_lmt_ru_2ghz_entry {
+	u8 ru;
+	u8 nt;
+	u8 regd;
+	u8 ch_idx;
+	s8 v;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_txpwr_lmt_ru_5ghz_entry {
+	u8 ru;
+	u8 nt;
+	u8 regd;
+	u8 ch_idx;
+	s8 v;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_txpwr_lmt_ru_6ghz_entry {
+	u8 ru;
+	u8 nt;
+	u8 regd;
+	u8 reg_6ghz_power;
+	u8 ch_idx;
+	s8 v;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_tx_shape_lmt_entry {
+	u8 band;
+	u8 tx_shape_rs;
+	u8 regd;
+	u8 v;
+} __packed;
+
+/* must consider compatibility; don't insert new in the mid */
+struct rtw89_fw_tx_shape_lmt_ru_entry {
+	u8 band;
+	u8 regd;
+	u8 v;
+} __packed;
+
+const struct rtw89_rfe_parms *
+rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
+			    const struct rtw89_rfe_parms *init);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 03e79d80e32c..6e1f4d6c345c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1535,7 +1535,6 @@ static const u8 rtw89_rs_nss_num[] = {
 	[RTW89_RS_OFFSET] = 1,
 };
 
-static
 s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
 			   struct rtw89_txpwr_byrate *head,
 			   const struct rtw89_rate_desc *desc)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d6dc0cbbae43..4684feac97b2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -613,6 +613,9 @@ void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
 u32 rtw89_phy_read32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			 enum rtw89_phy_idx phy_idx);
+s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
+			   struct rtw89_txpwr_byrate *head,
+			   const struct rtw89_rate_desc *desc);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
-- 
2.25.1

