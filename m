Return-Path: <linux-wireless+bounces-33-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDEA7F6CCB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83DCB20DC8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE08F52;
	Fri, 24 Nov 2023 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0449D73
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7IGwjC3551174, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7IGwjC3551174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 24 Nov 2023 15:18:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: mac: functions to configure hardware engine and quota for WiFi 7 chips
Date: Fri, 24 Nov 2023 15:17:03 +0800
Message-ID: <20231124071703.132549-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124071703.132549-1-pkshih@realtek.com>
References: <20231124071703.132549-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add functions to configure HCI, DMAC (data MAC), DLE (data link engine),
HFC (HCI flow control), PLE (payload engine) and etc for WiFi 7 chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 390 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 264 +++++++++++++
 2 files changed, 654 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 612baa8b83d9..ec394f02a8ca 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -57,6 +57,297 @@ static const struct rtw89_port_reg rtw89_port_base_be = {
 		    R_BE_PORT_HGQ_WINDOW_CFG + 3},
 };
 
+static void hfc_get_mix_info_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
+	struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
+	struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
+	struct rtw89_hfc_pub_info *info = &param->pub_info;
+	u32 val;
+
+	val = rtw89_read32(rtwdev, R_BE_PUB_PAGE_INFO1);
+	info->g0_used = u32_get_bits(val, B_BE_G0_USE_PG_MASK);
+	info->g1_used = u32_get_bits(val, B_BE_G1_USE_PG_MASK);
+
+	val = rtw89_read32(rtwdev, R_BE_PUB_PAGE_INFO3);
+	info->g0_aval = u32_get_bits(val, B_BE_G0_AVAL_PG_MASK);
+	info->g1_aval = u32_get_bits(val, B_BE_G1_AVAL_PG_MASK);
+	info->pub_aval = u32_get_bits(rtw89_read32(rtwdev, R_BE_PUB_PAGE_INFO2),
+				      B_BE_PUB_AVAL_PG_MASK);
+	info->wp_aval = u32_get_bits(rtw89_read32(rtwdev, R_BE_WP_PAGE_INFO1),
+				     B_BE_WP_AVAL_PG_MASK);
+
+	val = rtw89_read32(rtwdev, R_BE_HCI_FC_CTRL);
+	param->en = !!(val & B_BE_HCI_FC_EN);
+	param->h2c_en = !!(val & B_BE_HCI_FC_CH12_EN);
+	param->mode = u32_get_bits(val, B_BE_HCI_FC_MODE_MASK);
+	prec_cfg->ch011_full_cond = u32_get_bits(val, B_BE_HCI_FC_WD_FULL_COND_MASK);
+	prec_cfg->h2c_full_cond = u32_get_bits(val, B_BE_HCI_FC_CH12_FULL_COND_MASK);
+	prec_cfg->wp_ch07_full_cond =
+		u32_get_bits(val, B_BE_HCI_FC_WP_CH07_FULL_COND_MASK);
+	prec_cfg->wp_ch811_full_cond =
+		u32_get_bits(val, B_BE_HCI_FC_WP_CH811_FULL_COND_MASK);
+
+	val = rtw89_read32(rtwdev, R_BE_CH_PAGE_CTRL);
+	prec_cfg->ch011_prec = u32_get_bits(val, B_BE_PREC_PAGE_CH011_V1_MASK);
+	prec_cfg->h2c_prec = u32_get_bits(val, B_BE_PREC_PAGE_CH12_V1_MASK);
+
+	val = rtw89_read32(rtwdev, R_BE_PUB_PAGE_CTRL2);
+	pub_cfg->pub_max = u32_get_bits(val, B_BE_PUBPG_ALL_MASK);
+
+	val = rtw89_read32(rtwdev, R_BE_WP_PAGE_CTRL1);
+	prec_cfg->wp_ch07_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH07_MASK);
+	prec_cfg->wp_ch811_prec = u32_get_bits(val, B_BE_PREC_PAGE_WP_CH811_MASK);
+
+	val = rtw89_read32(rtwdev, R_BE_WP_PAGE_CTRL2);
+	pub_cfg->wp_thrd = u32_get_bits(val, B_BE_WP_THRD_MASK);
+
+	val = rtw89_read32(rtwdev, R_BE_PUB_PAGE_CTRL1);
+	pub_cfg->grp0 = u32_get_bits(val, B_BE_PUBPG_G0_MASK);
+	pub_cfg->grp1 = u32_get_bits(val, B_BE_PUBPG_G1_MASK);
+}
+
+static void hfc_h2c_cfg_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
+	const struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
+	u32 val;
+
+	val = u32_encode_bits(prec_cfg->h2c_prec, B_BE_PREC_PAGE_CH12_V1_MASK);
+	rtw89_write32(rtwdev, R_BE_CH_PAGE_CTRL, val);
+}
+
+static void hfc_mix_cfg_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
+	const struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
+	const struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
+	u32 val;
+
+	val = u32_encode_bits(prec_cfg->ch011_prec, B_BE_PREC_PAGE_CH011_V1_MASK) |
+	      u32_encode_bits(prec_cfg->h2c_prec, B_BE_PREC_PAGE_CH12_V1_MASK);
+	rtw89_write32(rtwdev, R_BE_CH_PAGE_CTRL, val);
+
+	val = u32_encode_bits(pub_cfg->pub_max, B_BE_PUBPG_ALL_MASK);
+	rtw89_write32(rtwdev, R_BE_PUB_PAGE_CTRL2, val);
+
+	val = u32_encode_bits(prec_cfg->wp_ch07_prec, B_BE_PREC_PAGE_WP_CH07_MASK) |
+	      u32_encode_bits(prec_cfg->wp_ch811_prec, B_BE_PREC_PAGE_WP_CH811_MASK);
+	rtw89_write32(rtwdev, R_BE_WP_PAGE_CTRL1, val);
+
+	val = u32_replace_bits(rtw89_read32(rtwdev, R_BE_HCI_FC_CTRL),
+			       param->mode, B_BE_HCI_FC_MODE_MASK);
+	val = u32_replace_bits(val, prec_cfg->ch011_full_cond,
+			       B_BE_HCI_FC_WD_FULL_COND_MASK);
+	val = u32_replace_bits(val, prec_cfg->h2c_full_cond,
+			       B_BE_HCI_FC_CH12_FULL_COND_MASK);
+	val = u32_replace_bits(val, prec_cfg->wp_ch07_full_cond,
+			       B_BE_HCI_FC_WP_CH07_FULL_COND_MASK);
+	val = u32_replace_bits(val, prec_cfg->wp_ch811_full_cond,
+			       B_BE_HCI_FC_WP_CH811_FULL_COND_MASK);
+	rtw89_write32(rtwdev, R_BE_HCI_FC_CTRL, val);
+}
+
+static void hfc_func_en_be(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
+{
+	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
+	u32 val;
+
+	val = rtw89_read32(rtwdev, R_BE_HCI_FC_CTRL);
+	param->en = en;
+	param->h2c_en = h2c_en;
+	val = en ? (val | B_BE_HCI_FC_EN) : (val & ~B_BE_HCI_FC_EN);
+	val = h2c_en ? (val | B_BE_HCI_FC_CH12_EN) :
+		       (val & ~B_BE_HCI_FC_CH12_EN);
+	rtw89_write32(rtwdev, R_BE_HCI_FC_CTRL, val);
+}
+
+static void dle_func_en_be(struct rtw89_dev *rtwdev, bool enable)
+{
+	if (enable)
+		rtw89_write32_set(rtwdev, R_BE_DMAC_FUNC_EN,
+				  B_BE_DLE_WDE_EN | B_BE_DLE_PLE_EN);
+	else
+		rtw89_write32_clr(rtwdev, R_BE_DMAC_FUNC_EN,
+				  B_BE_DLE_WDE_EN | B_BE_DLE_PLE_EN);
+}
+
+static void dle_clk_en_be(struct rtw89_dev *rtwdev, bool enable)
+{
+	if (enable)
+		rtw89_write32_set(rtwdev, R_BE_DMAC_CLK_EN,
+				  B_BE_DLE_WDE_CLK_EN | B_BE_DLE_PLE_CLK_EN);
+	else
+		rtw89_write32_clr(rtwdev, R_BE_DMAC_CLK_EN,
+				  B_BE_DLE_WDE_CLK_EN | B_BE_DLE_PLE_CLK_EN);
+}
+
+static int dle_mix_cfg_be(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg)
+{
+	const struct rtw89_dle_size *wde_size_cfg, *ple_size_cfg;
+	u32 bound;
+	u32 val;
+
+	wde_size_cfg = cfg->wde_size;
+	ple_size_cfg = cfg->ple_size;
+
+	val = rtw89_read32(rtwdev, R_BE_WDE_PKTBUF_CFG);
+
+	switch (wde_size_cfg->pge_size) {
+	default:
+	case RTW89_WDE_PG_64:
+		val = u32_replace_bits(val, S_AX_WDE_PAGE_SEL_64,
+				       B_BE_WDE_PAGE_SEL_MASK);
+		break;
+	case RTW89_WDE_PG_128:
+		val = u32_replace_bits(val, S_AX_WDE_PAGE_SEL_128,
+				       B_BE_WDE_PAGE_SEL_MASK);
+		break;
+	case RTW89_WDE_PG_256:
+		rtw89_err(rtwdev, "[ERR]WDE DLE doesn't support 256 byte!\n");
+		return -EINVAL;
+	}
+
+	bound = wde_size_cfg->srt_ofst / DLE_BOUND_UNIT;
+	val = u32_replace_bits(val, bound, B_BE_WDE_START_BOUND_MASK);
+	val = u32_replace_bits(val, wde_size_cfg->lnk_pge_num,
+			       B_BE_WDE_FREE_PAGE_NUM_MASK);
+	rtw89_write32(rtwdev, R_BE_WDE_PKTBUF_CFG, val);
+
+	val = rtw89_read32(rtwdev, R_BE_PLE_PKTBUF_CFG);
+
+	switch (ple_size_cfg->pge_size) {
+	default:
+	case RTW89_PLE_PG_64:
+		rtw89_err(rtwdev, "[ERR]PLE DLE doesn't support 64 byte!\n");
+		return -EINVAL;
+	case RTW89_PLE_PG_128:
+		val = u32_replace_bits(val, S_AX_PLE_PAGE_SEL_128,
+				       B_BE_PLE_PAGE_SEL_MASK);
+		break;
+	case RTW89_PLE_PG_256:
+		val = u32_replace_bits(val, S_AX_PLE_PAGE_SEL_256,
+				       B_BE_PLE_PAGE_SEL_MASK);
+		break;
+	}
+
+	bound = ple_size_cfg->srt_ofst / DLE_BOUND_UNIT;
+	val = u32_replace_bits(val, bound, B_BE_PLE_START_BOUND_MASK);
+	val = u32_replace_bits(val, ple_size_cfg->lnk_pge_num,
+			       B_BE_PLE_FREE_PAGE_NUM_MASK);
+	rtw89_write32(rtwdev, R_BE_PLE_PKTBUF_CFG, val);
+
+	return 0;
+}
+
+static int chk_dle_rdy_be(struct rtw89_dev *rtwdev, bool wde_or_ple)
+{
+	u32 reg, mask;
+	u32 ini;
+
+	if (wde_or_ple) {
+		reg = R_AX_WDE_INI_STATUS;
+		mask = WDE_MGN_INI_RDY;
+	} else {
+		reg = R_AX_PLE_INI_STATUS;
+		mask = PLE_MGN_INI_RDY;
+	}
+
+	return read_poll_timeout(rtw89_read32, ini, (ini & mask) == mask, 1,
+				2000, false, rtwdev, reg);
+}
+
+#define INVALID_QT_WCPU U16_MAX
+#define SET_QUOTA_VAL(_min_x, _max_x, _module, _idx)			\
+	do {								\
+		val = u32_encode_bits(_min_x, B_BE_ ## _module ## _Q ## _idx ## _MIN_SIZE_MASK) | \
+		      u32_encode_bits(_max_x, B_BE_ ## _module ## _Q ## _idx ## _MAX_SIZE_MASK);  \
+		rtw89_write32(rtwdev,					\
+			      R_BE_ ## _module ## _QTA ## _idx ## _CFG,	\
+			      val);					\
+	} while (0)
+#define SET_QUOTA(_x, _module, _idx)					\
+	SET_QUOTA_VAL(min_cfg->_x, max_cfg->_x, _module, _idx)
+
+static void wde_quota_cfg_be(struct rtw89_dev *rtwdev,
+			     const struct rtw89_wde_quota *min_cfg,
+			     const struct rtw89_wde_quota *max_cfg,
+			     u16 ext_wde_min_qt_wcpu)
+{
+	u16 min_qt_wcpu = ext_wde_min_qt_wcpu != INVALID_QT_WCPU ?
+			  ext_wde_min_qt_wcpu : min_cfg->wcpu;
+	u16 max_qt_wcpu = max(max_cfg->wcpu, min_qt_wcpu);
+	u32 val;
+
+	SET_QUOTA(hif, WDE, 0);
+	SET_QUOTA_VAL(min_qt_wcpu, max_qt_wcpu, WDE, 1);
+	SET_QUOTA_VAL(0, 0, WDE, 2);
+	SET_QUOTA(pkt_in, WDE, 3);
+	SET_QUOTA(cpu_io, WDE, 4);
+}
+
+static void ple_quota_cfg_be(struct rtw89_dev *rtwdev,
+			     const struct rtw89_ple_quota *min_cfg,
+			     const struct rtw89_ple_quota *max_cfg)
+{
+	u32 val;
+
+	SET_QUOTA(cma0_tx, PLE, 0);
+	SET_QUOTA(cma1_tx, PLE, 1);
+	SET_QUOTA(c2h, PLE, 2);
+	SET_QUOTA(h2c, PLE, 3);
+	SET_QUOTA(wcpu, PLE, 4);
+	SET_QUOTA(mpdu_proc, PLE, 5);
+	SET_QUOTA(cma0_dma, PLE, 6);
+	SET_QUOTA(cma1_dma, PLE, 7);
+	SET_QUOTA(bb_rpt, PLE, 8);
+	SET_QUOTA(wd_rel, PLE, 9);
+	SET_QUOTA(cpu_io, PLE, 10);
+	SET_QUOTA(tx_rpt, PLE, 11);
+	SET_QUOTA(h2d, PLE, 12);
+}
+
+static void rtw89_mac_hci_func_en_be(struct rtw89_dev *rtwdev)
+{
+	rtw89_write32_set(rtwdev, R_BE_HCI_FUNC_EN, B_BE_HCI_TXDMA_EN |
+						    B_BE_HCI_RXDMA_EN);
+}
+
+static void rtw89_mac_dmac_func_pre_en_be(struct rtw89_dev *rtwdev)
+{
+	u32 val;
+
+	val = rtw89_read32(rtwdev, R_BE_HAXI_INIT_CFG1);
+
+	switch (rtwdev->hci.type) {
+	case RTW89_HCI_TYPE_PCIE:
+		val = u32_replace_bits(val, S_BE_DMA_MOD_PCIE_NO_DATA_CPU,
+				       B_BE_DMA_MODE_MASK);
+		break;
+	case RTW89_HCI_TYPE_USB:
+		val = u32_replace_bits(val, S_BE_DMA_MOD_USB, B_BE_DMA_MODE_MASK);
+		val = (val & ~B_BE_STOP_AXI_MST) | B_BE_TXDMA_EN | B_BE_RXDMA_EN;
+		break;
+	case RTW89_HCI_TYPE_SDIO:
+		val = u32_replace_bits(val, S_BE_DMA_MOD_SDIO, B_BE_DMA_MODE_MASK);
+		val = (val & ~B_BE_STOP_AXI_MST) | B_BE_TXDMA_EN | B_BE_RXDMA_EN;
+		break;
+	default:
+		return;
+	}
+
+	rtw89_write32(rtwdev, R_BE_HAXI_INIT_CFG1, val);
+
+	rtw89_write32_clr(rtwdev, R_BE_HAXI_DMA_STOP1,
+			  B_BE_STOP_CH0 | B_BE_STOP_CH1 | B_BE_STOP_CH2 |
+			  B_BE_STOP_CH3 | B_BE_STOP_CH4 | B_BE_STOP_CH5 |
+			  B_BE_STOP_CH6 | B_BE_STOP_CH7 | B_BE_STOP_CH8 |
+			  B_BE_STOP_CH9 | B_BE_STOP_CH10 | B_BE_STOP_CH11 |
+			  B_BE_STOP_CH12 | B_BE_STOP_CH13 | B_BE_STOP_CH14);
+
+	rtw89_write32_set(rtwdev, R_BE_DMAC_TABLE_CTRL, B_BE_DMAC_ADDR_MODE);
+}
+
 static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -206,6 +497,90 @@ static int rtw89_fwdl_check_path_ready_be(struct rtw89_dev *rtwdev,
 					rtwdev, R_BE_WCPU_FW_CTRL);
 }
 
+static int dle_buf_req_be(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id)
+{
+	u32 val, reg;
+	int ret;
+
+	reg = wd ? R_BE_WD_BUF_REQ : R_BE_PL_BUF_REQ;
+	val = buf_len;
+	val |= B_BE_WD_BUF_REQ_EXEC;
+	rtw89_write32(rtwdev, reg, val);
+
+	reg = wd ? R_BE_WD_BUF_STATUS : R_BE_PL_BUF_STATUS;
+
+	ret = read_poll_timeout(rtw89_read32, val, val & B_BE_WD_BUF_STAT_DONE,
+				1, 2000, false, rtwdev, reg);
+	if (ret)
+		return ret;
+
+	*pkt_id = u32_get_bits(val, B_BE_WD_BUF_STAT_PKTID_MASK);
+	if (*pkt_id == S_WD_BUF_STAT_PKTID_INVALID)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int set_cpuio_be(struct rtw89_dev *rtwdev,
+			struct rtw89_cpuio_ctrl *ctrl_para, bool wd)
+{
+	u32 val_op0, val_op1, val_op2, val_op3;
+	u32 val, cmd_type, reg;
+	int ret;
+
+	cmd_type = ctrl_para->cmd_type;
+
+	reg = wd ? R_BE_WD_CPUQ_OP_3 : R_BE_PL_CPUQ_OP_3;
+	val_op3 = u32_replace_bits(0, ctrl_para->start_pktid,
+				   B_BE_WD_CPUQ_OP_STRT_PKTID_MASK);
+	val_op3 = u32_replace_bits(val_op3, ctrl_para->end_pktid,
+				   B_BE_WD_CPUQ_OP_END_PKTID_MASK);
+	rtw89_write32(rtwdev, reg, val_op3);
+
+	reg = wd ? R_BE_WD_CPUQ_OP_1 : R_BE_PL_CPUQ_OP_1;
+	val_op1 = u32_replace_bits(0, ctrl_para->src_pid,
+				   B_BE_WD_CPUQ_OP_SRC_PID_MASK);
+	val_op1 = u32_replace_bits(val_op1, ctrl_para->src_qid,
+				   B_BE_WD_CPUQ_OP_SRC_QID_MASK);
+	val_op1 = u32_replace_bits(val_op1, ctrl_para->macid,
+				   B_BE_WD_CPUQ_OP_SRC_MACID_MASK);
+	rtw89_write32(rtwdev, reg, val_op1);
+
+	reg = wd ? R_BE_WD_CPUQ_OP_2 : R_BE_PL_CPUQ_OP_2;
+	val_op2 = u32_replace_bits(0, ctrl_para->dst_pid,
+				   B_BE_WD_CPUQ_OP_DST_PID_MASK);
+	val_op2 = u32_replace_bits(val_op2, ctrl_para->dst_qid,
+				   B_BE_WD_CPUQ_OP_DST_QID_MASK);
+	val_op2 = u32_replace_bits(val_op2, ctrl_para->macid,
+				   B_BE_WD_CPUQ_OP_DST_MACID_MASK);
+	rtw89_write32(rtwdev, reg, val_op2);
+
+	reg = wd ? R_BE_WD_CPUQ_OP_0 : R_BE_PL_CPUQ_OP_0;
+	val_op0 = u32_replace_bits(0, cmd_type,
+				   B_BE_WD_CPUQ_OP_CMD_TYPE_MASK);
+	val_op0 = u32_replace_bits(val_op0, ctrl_para->pkt_num,
+				   B_BE_WD_CPUQ_OP_PKTNUM_MASK);
+	val_op0 |= B_BE_WD_CPUQ_OP_EXEC;
+	rtw89_write32(rtwdev, reg, val_op0);
+
+	reg = wd ? R_BE_WD_CPUQ_OP_STATUS : R_BE_PL_CPUQ_OP_STATUS;
+
+	ret = read_poll_timeout(rtw89_read32, val, val & B_BE_WD_CPUQ_OP_STAT_DONE,
+				1, 2000, false, rtwdev, reg);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]set cpuio wd timeout\n");
+		rtw89_err(rtwdev, "[ERR]op_0=0x%X, op_1=0x%X, op_2=0x%X\n",
+			  val_op0, val_op1, val_op2);
+		return ret;
+	}
+
+	if (cmd_type == CPUIO_OP_CMD_GET_NEXT_PID ||
+	    cmd_type == CPUIO_OP_CMD_GET_1ST_PID)
+		ctrl_para->pktid = u32_get_bits(val, B_BE_WD_CPUQ_OP_PKTID_MASK);
+
+	return 0;
+}
+
 static bool rtw89_mac_get_txpwr_cr_be(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      u32 reg_base, u32 *cr)
@@ -469,8 +844,23 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 			B_BE_BFMEE_HE_NDPA_EN | B_BE_BFMEE_EHT_NDPA_EN,
 	},
 
+	.hci_func_en = rtw89_mac_hci_func_en_be,
+	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
+	.dle_func_en = dle_func_en_be,
+	.dle_clk_en = dle_clk_en_be,
 	.bf_assoc = rtw89_mac_bf_assoc_be,
 
+	.dle_mix_cfg = dle_mix_cfg_be,
+	.chk_dle_rdy = chk_dle_rdy_be,
+	.dle_buf_req = dle_buf_req_be,
+	.hfc_func_en = hfc_func_en_be,
+	.hfc_h2c_cfg = hfc_h2c_cfg_be,
+	.hfc_mix_cfg = hfc_mix_cfg_be,
+	.hfc_get_mix_info = hfc_get_mix_info_be,
+	.wde_quota_cfg = wde_quota_cfg_be,
+	.ple_quota_cfg = ple_quota_cfg_be,
+	.set_cpuio = set_cpuio_be,
+
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
 	.fwdl_get_status = fwdl_get_status_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 31b65322368c..61b79e8a2c07 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4123,6 +4123,53 @@
 #define B_BE_HCI_RXDMA_EN BIT(1)
 #define B_BE_HCI_TXDMA_EN BIT(0)
 
+#define R_BE_DMAC_FUNC_EN 0x8400
+#define B_BE_DMAC_CRPRT BIT(31)
+#define B_BE_MAC_FUNC_EN BIT(30)
+#define B_BE_DMAC_FUNC_EN BIT(29)
+#define B_BE_MPDU_PROC_EN BIT(28)
+#define B_BE_WD_RLS_EN BIT(27)
+#define B_BE_DLE_WDE_EN BIT(26)
+#define B_BE_TXPKT_CTRL_EN BIT(25)
+#define B_BE_STA_SCH_EN BIT(24)
+#define B_BE_DLE_PLE_EN BIT(23)
+#define B_BE_PKT_BUF_EN BIT(22)
+#define B_BE_DMAC_TBL_EN BIT(21)
+#define B_BE_PKT_IN_EN BIT(20)
+#define B_BE_DLE_CPUIO_EN BIT(19)
+#define B_BE_DISPATCHER_EN BIT(18)
+#define B_BE_BBRPT_EN BIT(17)
+#define B_BE_MAC_SEC_EN BIT(16)
+#define B_BE_DMACREG_GCKEN BIT(15)
+#define B_BE_H_AXIDMA_EN BIT(14)
+#define B_BE_DMAC_MLO_EN BIT(11)
+#define B_BE_PLRLS_EN BIT(10)
+#define B_BE_P_AXIDMA_EN BIT(9)
+#define B_BE_DLE_DATACPUIO_EN BIT(8)
+#define B_BE_LTR_CTL_EN BIT(7)
+
+#define R_BE_DMAC_CLK_EN 0x8404
+#define B_BE_MAC_CKEN BIT(30)
+#define B_BE_DMAC_CKEN BIT(29)
+#define B_BE_MPDU_CKEN BIT(28)
+#define B_BE_WD_RLS_CLK_EN BIT(27)
+#define B_BE_DLE_WDE_CLK_EN BIT(26)
+#define B_BE_TXPKT_CTRL_CLK_EN BIT(25)
+#define B_BE_STA_SCH_CLK_EN BIT(24)
+#define B_BE_DLE_PLE_CLK_EN BIT(23)
+#define B_BE_PKTBUF_CKEN BIT(22)
+#define B_BE_DMAC_TABLE_CLK_EN BIT(21)
+#define B_BE_PKT_IN_CLK_EN BIT(20)
+#define B_BE_DLE_CPUIO_CLK_EN BIT(19)
+#define B_BE_DISPATCHER_CLK_EN BIT(18)
+#define B_BE_BBRPT_CLK_EN BIT(17)
+#define B_BE_MAC_SEC_CLK_EN BIT(16)
+#define B_BE_H_AXIDMA_CKEN BIT(14)
+#define B_BE_DMAC_MLO_CKEN BIT(11)
+#define B_BE_PLRLS_CKEN BIT(10)
+#define B_BE_P_AXIDMA_CKEN BIT(9)
+#define B_BE_DLE_DATACPUIO_CKEN BIT(8)
+
 #define R_BE_LTR_CTRL_0 0x8410
 #define B_BE_LTR_REQ_FW BIT(18)
 #define B_BE_LTR_IDX_FW_MASK GENMASK(17, 16)
@@ -4144,6 +4191,13 @@
 #define B_BE_LTR_CMAC1_RX_USE_PG_TH_MASK GENMASK(27, 16)
 #define B_BE_LTR_CMAC0_RX_USE_PG_TH_MASK GENMASK(11, 0)
 
+#define R_BE_DMAC_TABLE_CTRL 0x8420
+#define B_BE_HWAMSDU_PADDING_MODE BIT(31)
+#define B_BE_MACID_MPDU_PROCESSOR_OFFSET_MASK GENMASK(26, 16)
+#define B_BE_DMAC_ADDR_MODE BIT(12)
+#define B_BE_DMAC_CTRL_INFO_SER_IO BIT(11)
+#define B_BE_DMAC_CTRL_INFO_OFFSET_MASK GENMASK(10, 0)
+
 #define R_BE_DLE_EMPTY0 0x8430
 #define B_BE_PLE_EMPTY_QTA_DMAC_H2D BIT(27)
 #define B_BE_PLE_EMPTY_QTA_DMAC_CPUIO BIT(26)
@@ -4174,6 +4228,88 @@
 #define B_BE_WDE_EMPTY_QUE_CMAC0_MBH BIT(1)
 #define B_BE_WDE_EMPTY_QUE_CMAC0_ALL_AC BIT(0)
 
+#define R_BE_WDE_PKTBUF_CFG 0x8C08
+#define B_BE_WDE_FREE_PAGE_NUM_MASK GENMASK(28, 16)
+#define B_BE_WDE_START_BOUND_MASK GENMASK(14, 8)
+#define B_BE_WDE_PAGE_SEL_MASK GENMASK(1, 0)
+
+#define R_BE_WDE_QTA0_CFG 0x8C40
+#define B_BE_WDE_Q0_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_WDE_Q0_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_WDE_QTA1_CFG 0x8C44
+#define B_BE_WDE_Q1_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_WDE_Q1_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_WDE_QTA2_CFG 0x8C48
+#define B_BE_WDE_Q2_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_WDE_Q2_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_WDE_QTA3_CFG 0x8C4C
+#define B_BE_WDE_Q3_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_WDE_Q3_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_WDE_QTA4_CFG 0x8C50
+#define B_BE_WDE_Q4_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_WDE_Q4_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_PKTBUF_CFG 0x9008
+#define B_BE_PLE_FREE_PAGE_NUM_MASK GENMASK(28, 16)
+#define B_BE_PLE_START_BOUND_MASK GENMASK(14, 8)
+#define B_BE_PLE_PAGE_SEL_MASK GENMASK(1, 0)
+
+#define R_BE_PLE_QTA0_CFG 0x9040
+#define B_BE_PLE_Q0_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q0_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA1_CFG 0x9044
+#define B_BE_PLE_Q1_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q1_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA2_CFG 0x9048
+#define B_BE_PLE_Q2_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q2_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA3_CFG 0x904C
+#define B_BE_PLE_Q3_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q3_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA4_CFG 0x9050
+#define B_BE_PLE_Q4_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q4_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA5_CFG 0x9054
+#define B_BE_PLE_Q5_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q5_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA6_CFG 0x9058
+#define B_BE_PLE_Q6_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q6_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA7_CFG 0x905C
+#define B_BE_PLE_Q7_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q7_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA8_CFG 0x9060
+#define B_BE_PLE_Q8_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q8_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA9_CFG 0x9064
+#define B_BE_PLE_Q9_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q9_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA10_CFG 0x9068
+#define B_BE_PLE_Q10_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q10_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA11_CFG 0x906C
+#define B_BE_PLE_Q11_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q11_MIN_SIZE_MASK GENMASK(11, 0)
+
+#define R_BE_PLE_QTA12_CFG 0x9070
+#define B_BE_PLE_Q12_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q12_MIN_SIZE_MASK GENMASK(11, 0)
+
 #define R_BE_PLE_DBG_FUN_INTF_CTL 0x9110
 #define B_BE_PLE_DFI_ACTIVE BIT(31)
 #define B_BE_PLE_DFI_TRGSEL_MASK GENMASK(19, 16)
@@ -4182,6 +4318,72 @@
 #define R_BE_PLE_DBG_FUN_INTF_DATA 0x9114
 #define B_BE_PLE_DFI_DATA_MASK GENMASK(31, 0)
 
+#define R_BE_WD_BUF_REQ 0x9800
+#define B_BE_WD_BUF_REQ_EXEC BIT(31)
+#define B_BE_WD_BUF_REQ_QUOTA_ID_MASK GENMASK(23, 16)
+#define B_BE_WD_BUF_REQ_LEN_MASK GENMASK(15, 0)
+
+#define R_BE_WD_BUF_STATUS 0x9804
+#define B_BE_WD_BUF_STAT_DONE BIT(31)
+#define B_BE_WD_BUF_STAT_PKTID_MASK GENMASK(11, 0)
+
+#define R_BE_WD_CPUQ_OP_0 0x9810
+#define B_BE_WD_CPUQ_OP_EXEC BIT(31)
+#define B_BE_WD_CPUQ_OP_CMD_TYPE_MASK GENMASK(27, 24)
+#define B_BE_WD_CPUQ_OP_PKTNUM_MASK GENMASK(7, 0)
+
+#define R_BE_WD_CPUQ_OP_1 0x9814
+#define B_BE_WD_CPUQ_OP_SRC_MACID_MASK GENMASK(19, 12)
+#define B_BE_WD_CPUQ_OP_SRC_QID_MASK GENMASK(9, 4)
+#define B_BE_WD_CPUQ_OP_SRC_PID_MASK GENMASK(2, 0)
+
+#define R_BE_WD_CPUQ_OP_2 0x9818
+#define B_BE_WD_CPUQ_OP_DST_MACID_MASK GENMASK(19, 12)
+#define B_BE_WD_CPUQ_OP_DST_QID_MASK GENMASK(9, 4)
+#define B_BE_WD_CPUQ_OP_DST_PID_MASK GENMASK(2, 0)
+
+#define R_BE_WD_CPUQ_OP_3 0x981C
+#define B_BE_WD_CPUQ_OP_STRT_PKTID_MASK GENMASK(27, 16)
+#define B_BE_WD_CPUQ_OP_END_PKTID_MASK GENMASK(11, 0)
+
+#define R_BE_WD_CPUQ_OP_STATUS 0x9820
+#define B_BE_WD_CPUQ_OP_STAT_DONE BIT(31)
+#define B_BE_WD_CPUQ_OP_PKTCNT_MASK GENMASK(27, 16)
+#define B_BE_WD_CPUQ_OP_PKTID_MASK GENMASK(11, 0)
+
+#define R_BE_PL_BUF_REQ 0x9840
+#define B_BE_PL_BUF_REQ_EXEC BIT(31)
+#define B_BE_PL_BUF_REQ_QUOTA_ID_MASK GENMASK(19, 16)
+#define B_BE_PL_BUF_REQ_LEN_MASK GENMASK(15, 0)
+
+#define R_BE_PL_BUF_STATUS 0x9844
+#define B_BE_PL_BUF_STAT_DONE BIT(31)
+#define B_BE_PL_BUF_STAT_PKTID_MASK GENMASK(11, 0)
+
+#define R_BE_PL_CPUQ_OP_0 0x9850
+#define B_BE_PL_CPUQ_OP_EXEC BIT(31)
+#define B_BE_PL_CPUQ_OP_CMD_TYPE_MASK GENMASK(27, 24)
+#define B_BE_PL_CPUQ_OP_PKTNUM_MASK GENMASK(7, 0)
+
+#define R_BE_PL_CPUQ_OP_1 0x9854
+#define B_BE_PL_CPUQ_OP_SRC_MACID_MASK GENMASK(19, 12)
+#define B_BE_PL_CPUQ_OP_SRC_QID_MASK GENMASK(9, 4)
+#define B_BE_PL_CPUQ_OP_SRC_PID_MASK GENMASK(2, 0)
+
+#define R_BE_PL_CPUQ_OP_2 0x9858
+#define B_BE_PL_CPUQ_OP_DST_MACID_MASK GENMASK(19, 12)
+#define B_BE_PL_CPUQ_OP_DST_QID_MASK GENMASK(9, 4)
+#define B_BE_PL_CPUQ_OP_DST_PID_MASK GENMASK(2, 0)
+
+#define R_BE_PL_CPUQ_OP_3 0x985C
+#define B_BE_PL_CPUQ_OP_STRT_PKTID_MASK GENMASK(27, 16)
+#define B_BE_PL_CPUQ_OP_END_PKTID_MASK GENMASK(11, 0)
+
+#define R_BE_PL_CPUQ_OP_STATUS 0x9860
+#define B_BE_PL_CPUQ_OP_STAT_DONE BIT(31)
+#define B_BE_PL_CPUQ_OP_PKTCNT_MASK GENMASK(27, 16)
+#define B_BE_PL_CPUQ_OP_PKTID_MASK GENMASK(11, 0)
+
 #define R_BE_HAXI_INIT_CFG1 0xB000
 #define B_BE_CFG_WD_PERIOD_IDLE_MASK GENMASK(31, 28)
 #define B_BE_CFG_WD_PERIOD_ACTIVE_MASK GENMASK(27, 24)
@@ -4204,6 +4406,68 @@
 #define B_BE_MAX_RXDMA_MASK GENMASK(3, 2)
 #define B_BE_MAX_TXDMA_MASK GENMASK(1, 0)
 
+#define R_BE_HAXI_DMA_STOP1 0xB010
+#define B_BE_STOP_WPDMA BIT(31)
+#define B_BE_STOP_CH14 BIT(14)
+#define B_BE_STOP_CH13 BIT(13)
+#define B_BE_STOP_CH12 BIT(12)
+#define B_BE_STOP_CH11 BIT(11)
+#define B_BE_STOP_CH10 BIT(10)
+#define B_BE_STOP_CH9 BIT(9)
+#define B_BE_STOP_CH8 BIT(8)
+#define B_BE_STOP_CH7 BIT(7)
+#define B_BE_STOP_CH6 BIT(6)
+#define B_BE_STOP_CH5 BIT(5)
+#define B_BE_STOP_CH4 BIT(4)
+#define B_BE_STOP_CH3 BIT(3)
+#define B_BE_STOP_CH2 BIT(2)
+#define B_BE_STOP_CH1 BIT(1)
+#define B_BE_STOP_CH0 BIT(0)
+
+#define R_BE_HCI_FC_CTRL 0xB700
+#define B_BE_WD_PAGE_MODE_MASK GENMASK(17, 16)
+#define B_BE_HCI_FC_CH14_FULL_COND_MASK GENMASK(15, 14)
+#define B_BE_HCI_FC_TWD_FULL_COND_MASK GENMASK(13, 12)
+#define B_BE_HCI_FC_CH12_FULL_COND_MASK GENMASK(11, 10)
+#define B_BE_HCI_FC_WP_CH811_FULL_COND_MASK GENMASK(9, 8)
+#define B_BE_HCI_FC_WP_CH07_FULL_COND_MASK GENMASK(7, 6)
+#define B_BE_HCI_FC_WD_FULL_COND_MASK GENMASK(5, 4)
+#define B_BE_HCI_FC_CH12_EN BIT(3)
+#define B_BE_HCI_FC_MODE_MASK GENMASK(2, 1)
+#define B_BE_HCI_FC_EN BIT(0)
+
+#define R_BE_CH_PAGE_CTRL 0xB704
+#define B_BE_PREC_PAGE_CH12_V1_MASK GENMASK(21, 16)
+#define B_BE_PREC_PAGE_CH011_V1_MASK GENMASK(5, 0)
+
+#define R_BE_PUB_PAGE_INFO3 0xB78C
+#define B_BE_G1_AVAL_PG_MASK GENMASK(28, 16)
+#define B_BE_G0_AVAL_PG_MASK GENMASK(12, 0)
+
+#define R_BE_PUB_PAGE_CTRL1 0xB790
+#define B_BE_PUBPG_G1_MASK GENMASK(28, 16)
+#define B_BE_PUBPG_G0_MASK GENMASK(12, 0)
+
+#define R_BE_PUB_PAGE_CTRL2 0xB794
+#define B_BE_PUBPG_ALL_MASK GENMASK(12, 0)
+
+#define R_BE_PUB_PAGE_INFO1 0xB79C
+#define B_BE_G1_USE_PG_MASK GENMASK(28, 16)
+#define B_BE_G0_USE_PG_MASK GENMASK(12, 0)
+
+#define R_BE_PUB_PAGE_INFO2 0xB7A0
+#define B_BE_PUB_AVAL_PG_MASK GENMASK(12, 0)
+
+#define R_BE_WP_PAGE_CTRL1 0xB7A4
+#define B_BE_PREC_PAGE_WP_CH811_MASK GENMASK(24, 16)
+#define B_BE_PREC_PAGE_WP_CH07_MASK GENMASK(8, 0)
+
+#define R_BE_WP_PAGE_CTRL2 0xB7A8
+#define B_BE_WP_THRD_MASK GENMASK(12, 0)
+
+#define R_BE_WP_PAGE_INFO1 0xB7AC
+#define B_BE_WP_AVAL_PG_MASK GENMASK(28, 16)
+
 #define R_BE_CMAC_FUNC_EN 0x10000
 #define R_BE_CMAC_FUNC_EN_C1 0x14000
 #define B_BE_CMAC_CRPRT BIT(31)
-- 
2.25.1


