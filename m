Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335D7A588F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 06:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjISEuC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 00:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjISEuB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 00:50:01 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 10F2B128;
        Mon, 18 Sep 2023 21:49:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 74091602F96CC;
        Tue, 19 Sep 2023 12:49:52 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     loic.poulain@linaro.org, kvalo@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH v2 wireless-next 3/9] wifi: wcn36xx: remove unnecessary (void*) conversions
Date:   Tue, 19 Sep 2023 12:49:25 +0800
Message-Id: <20230919044925.523403-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No need cast (void *) to other types such as (struct wcn36xx *),
(struct wcn36xx_hal_update_scan_params_resp *), etc.

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c      |  6 +++---
 drivers/net/wireless/ath/wcn36xx/smd.c      | 20 ++++++++++----------
 drivers/net/wireless/ath/wcn36xx/testmode.c |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 9013f056eecb..d405a4c34059 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -180,7 +180,7 @@ static int wcn36xx_dxe_init_descs(struct wcn36xx *wcn, struct wcn36xx_dxe_ch *wc
 	if (!wcn_ch->cpu_addr)
 		return -ENOMEM;
 
-	cur_dxe = (struct wcn36xx_dxe_desc *)wcn_ch->cpu_addr;
+	cur_dxe = wcn_ch->cpu_addr;
 	cur_ctl = wcn_ch->head_blk_ctl;
 
 	for (i = 0; i < wcn_ch->desc_num; i++) {
@@ -453,7 +453,7 @@ static void reap_tx_dxes(struct wcn36xx *wcn, struct wcn36xx_dxe_ch *ch)
 
 static irqreturn_t wcn36xx_irq_tx_complete(int irq, void *dev)
 {
-	struct wcn36xx *wcn = (struct wcn36xx *)dev;
+	struct wcn36xx *wcn = dev;
 	int int_src, int_reason;
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_INT_SRC_RAW_REG, &int_src);
@@ -541,7 +541,7 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, void *dev)
 
 static irqreturn_t wcn36xx_irq_rx_ready(int irq, void *dev)
 {
-	struct wcn36xx *wcn = (struct wcn36xx *)dev;
+	struct wcn36xx *wcn = dev;
 
 	wcn36xx_dxe_rx_frame(wcn);
 
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 17e1919d1cd8..2cf86fc3f8fe 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -576,7 +576,7 @@ static int wcn36xx_smd_start_rsp(struct wcn36xx *wcn, void *buf, size_t len)
 	if (len < sizeof(*rsp))
 		return -EIO;
 
-	rsp = (struct wcn36xx_hal_mac_start_rsp_msg *)buf;
+	rsp = buf;
 
 	if (WCN36XX_FW_MSG_RESULT_SUCCESS != rsp->start_rsp_params.status)
 		return -EIO;
@@ -1025,7 +1025,7 @@ static int wcn36xx_smd_switch_channel_rsp(void *buf, size_t len)
 	ret = wcn36xx_smd_rsp_status_check(buf, len);
 	if (ret)
 		return ret;
-	rsp = (struct wcn36xx_hal_switch_channel_rsp_msg *)buf;
+	rsp = buf;
 	wcn36xx_dbg(WCN36XX_DBG_HAL, "channel switched to: %d, status: %d\n",
 		    rsp->channel_number, rsp->status);
 	return ret;
@@ -1072,7 +1072,7 @@ static int wcn36xx_smd_process_ptt_msg_rsp(void *buf, size_t len,
 	if (ret)
 		return ret;
 
-	rsp = (struct wcn36xx_hal_process_ptt_msg_rsp_msg *)buf;
+	rsp = buf;
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL, "process ptt msg responded with length %d\n",
 		    rsp->header.len);
@@ -1131,7 +1131,7 @@ static int wcn36xx_smd_update_scan_params_rsp(void *buf, size_t len)
 {
 	struct wcn36xx_hal_update_scan_params_resp *rsp;
 
-	rsp = (struct wcn36xx_hal_update_scan_params_resp *)buf;
+	rsp = buf;
 
 	/* Remove the PNO version bit */
 	rsp->status &= (~(WCN36XX_FW_MSG_PNO_VERSION_MASK));
@@ -1198,7 +1198,7 @@ static int wcn36xx_smd_add_sta_self_rsp(struct wcn36xx *wcn,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	rsp = (struct wcn36xx_hal_add_sta_self_rsp_msg *)buf;
+	rsp = buf;
 
 	if (rsp->status != WCN36XX_FW_MSG_RESULT_SUCCESS) {
 		wcn36xx_warn("hal add sta self failure: %d\n",
@@ -1316,7 +1316,7 @@ static int wcn36xx_smd_join_rsp(void *buf, size_t len)
 	if (wcn36xx_smd_rsp_status_check(buf, len))
 		return -EIO;
 
-	rsp = (struct wcn36xx_hal_join_rsp_msg *)buf;
+	rsp = buf;
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "hal rsp join status %d tx_mgmt_power %d\n",
@@ -1481,7 +1481,7 @@ static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	rsp = (struct wcn36xx_hal_config_sta_rsp_msg *)buf;
+	rsp = buf;
 	params = &rsp->params;
 
 	if (params->status != WCN36XX_FW_MSG_RESULT_SUCCESS) {
@@ -1849,7 +1849,7 @@ static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	rsp = (struct wcn36xx_hal_config_bss_rsp_msg *)buf;
+	rsp = buf;
 	params = &rsp->bss_rsp_params;
 
 	if (params->status != WCN36XX_FW_MSG_RESULT_SUCCESS) {
@@ -2476,7 +2476,7 @@ static int wcn36xx_smd_add_ba_session_rsp(void *buf, int len, u8 *session)
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	rsp = (struct wcn36xx_hal_add_ba_session_rsp_msg *)buf;
+	rsp = buf;
 	if (rsp->status != WCN36XX_FW_MSG_RESULT_SUCCESS)
 		return rsp->status;
 
@@ -2654,7 +2654,7 @@ static int wcn36xx_smd_trigger_ba_rsp(void *buf, int len, struct add_ba_info *ba
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	rsp = (struct wcn36xx_hal_trigger_ba_rsp_msg *) buf;
+	rsp = buf;
 
 	if (rsp->candidate_cnt < 1)
 		return rsp->status ? rsp->status : -EINVAL;
diff --git a/drivers/net/wireless/ath/wcn36xx/testmode.c b/drivers/net/wireless/ath/wcn36xx/testmode.c
index 7ae14b4d2d0e..e5142c052985 100644
--- a/drivers/net/wireless/ath/wcn36xx/testmode.c
+++ b/drivers/net/wireless/ath/wcn36xx/testmode.c
@@ -53,7 +53,7 @@ static int wcn36xx_tm_cmd_ptt(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	buf = nla_data(tb[WCN36XX_TM_ATTR_DATA]);
 	buf_len = nla_len(tb[WCN36XX_TM_ATTR_DATA]);
-	msg = (struct ftm_rsp_msg *)buf;
+	msg = buf;
 
 	wcn36xx_dbg(WCN36XX_DBG_TESTMODE,
 		    "testmode cmd wmi msg_id 0x%04X msg_len %d buf %pK buf_len %d\n",
-- 
2.30.2

