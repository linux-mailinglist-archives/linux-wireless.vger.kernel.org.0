Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9B4AB712
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbiBGIyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 03:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbiBGIsF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 03:48:05 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:48:03 PST
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2362C043188
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 00:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644223683; x=1675759683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+kxGVk8Yq81h+qzAYzmK0L2vwR5G3uvWsWiwCq+dTgw=;
  b=u+/vVgnhJny31heXok7GgoTUVCeabBrd49nCywDYXCVzM/v9Qsh/R/Ub
   Hwjo4HI6rHdLoWNp2NbBLKeGdVDylPTO/LR5rbcezpIu4BJcGRL+Ch1bE
   n4S1ZjC1UHysXMWM21sjoNNONHiB3PpA+6s4ZmxjckS13h8jeWt7fCGiU
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Feb 2022 00:46:01 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 00:46:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 00:46:00 -0800
Received: from FUZHOU.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 00:45:59 -0800
From:   Cheng Wang <quic_chengwan@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_chengwan@quicinc.com>
Subject: [PATCH v2] ath11k: add register read debugfs interface for WCN6855
Date:   Mon, 7 Feb 2022 16:45:40 +0800
Message-ID: <20220207084540.3661100-1-quic_chengwan@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add debugfs interface reg_addr/reg_value and use these two interfaces
to read register value.
For example, execute the following commands to read WCN6855 HW register of
“memtype=0xa offset=0x3a00d0”:

$ echo 0xa 0x3a00d0>reg_addr
$ cat reg_value
0x10200000

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Cheng Wang <quic_chengwan@quicinc.com>
---
v2: change per comments from Kalle
    fixes new warnings.

 drivers/net/wireless/ath/ath11k/core.h    |   2 +
 drivers/net/wireless/ath/ath11k/debugfs.c | 169 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.c     | 137 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/qmi.h     |  39 +++++
 4 files changed, 347 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 4eda15c56b04..910479427f55 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -454,6 +454,8 @@ struct ath11k_debug {
 	u32 pktlog_peer_valid;
 	u8 pktlog_peer_addr[ETH_ALEN];
 	u32 rx_filter;
+	enum qmi_allocram_arena mem_type;
+	u32 mem_offset;
 };
 
 struct ath11k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 215b6014c0ef..ec2f8c91063a 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1113,6 +1113,160 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static const char *ath11k_memtype2string(u32 mem_type)
+{
+	const char * const mem_type_str[] = {
+		[QMI_ALLOCRAM_HRAM_ARENA] = "hram",
+		[QMI_ALLOCRAM_HCRAM_ARENA] = "hcram",
+		[QMI_ALLOCRAM_HREMOTE_ARENA] = "hremote",
+		[QMI_ALLOCRAM_HCREMOTE_ARENA] = "hcremote",
+		[QMI_ALLOCRAM_REMOTE_ARENA] = "remote",
+		[QMI_ALLOCRAM_SRAM_ARENA] = "sram",
+		[QMI_ALLOCRAM_SRAM_AUX_ARENA] = "sram_aux",
+		[QMI_ALLOCRAM_PAGEABLE_ARENA] = "pageable",
+		[QMI_ALLOCRAM_CMEM_ARENA] = "cmem",
+		[QMI_ALLOCRAM_TRAM_ARENA] = "tram",
+		[QMI_ALLOCRAM_HWIO_ARENA] = "hwio",
+		[QMI_ALLOCRAM_CALDB_ARENA] = "caldb",
+		[QMI_ALLOCRAM_M3_ARENA] = "m3_arena",
+		[QMI_ALLOCRAM_ETMREMOTE_ARENA] = "etm_remote",
+		[QMI_ALLOCRAM_EMUPHY_ARENA] = "emu_phy",
+	};
+
+	if (mem_type < ARRAY_SIZE(mem_type_str))
+		return mem_type_str[mem_type];
+
+	return NULL;
+}
+
+static ssize_t ath11k_read_reg_addr(struct file *file,
+				    char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	u8 buf[64];
+	size_t len = 0;
+	u32 mem_type, mem_offset;
+
+	mutex_lock(&ar->conf_mutex);
+	mem_type = ar->debug.mem_type;
+	mem_offset = ar->debug.mem_offset;
+	mutex_unlock(&ar->conf_mutex);
+
+	len += scnprintf(buf + len, sizeof(buf) - len, "0x%x 0x%x\n",
+			 mem_type, mem_offset);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t ath11k_write_reg_addr(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_base *ab = ar->ab;
+	char buf[64] = {0};
+	ssize_t ret;
+	int rc;
+	u32 mem_type, mem_offset;
+	char sep[] = " ";
+	char *token, *cur;
+	const char *mem_type_str;
+
+	if (*ppos != 0 || count >= sizeof(buf) || count == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	if (ret < 0)
+		goto out;
+
+	/* drop the possible '\n' from the end */
+	if (buf[*ppos - 1] == '\n')
+		buf[*ppos - 1] = '\0';
+
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "%s: %s\n", __func__, buf);
+	ret = count;
+	cur = buf;
+
+	token = strsep(&cur, sep);
+	rc = kstrtou32(token, 0, &mem_type);
+	if (rc) {
+		ath11k_warn(ab, "%s convert error: mem_type %s\n", __func__, token);
+		ret = -EFAULT;
+		goto out;
+	}
+
+	mem_type_str = ath11k_memtype2string(mem_type);
+	if (!mem_type_str) {
+		ath11k_warn(ab, "%s invalid mem type value %d\n", __func__, mem_type);
+		ret = -EINVAL;
+		goto out;
+	}
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "%s mem_type %d %s\n",
+		   __func__, mem_type, mem_type_str);
+
+	token = strim(cur);
+	rc = kstrtou32(token, 0, &mem_offset);
+	if (rc) {
+		ath11k_warn(ab, "%s convert error: mem_offset %s\n", __func__, token);
+		ret = -EFAULT;
+		goto out;
+	}
+
+	mutex_lock(&ar->conf_mutex);
+	ar->debug.mem_type = mem_type;
+	ar->debug.mem_offset = mem_offset;
+	mutex_unlock(&ar->conf_mutex);
+
+out:
+	return ret;
+}
+
+static const struct file_operations fops_reg_addr = {
+	.read = ath11k_read_reg_addr,
+	.write = ath11k_write_reg_addr,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_read_reg_value(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_base *ab = ar->ab;
+	u8 buf[64];
+	size_t len = 0;
+	int ret_read;
+	u32 reg_value;
+
+	if (ar->debug.mem_type >= QMI_ALLOCRAM_ARENA_MAX) {
+		ath11k_warn(ab, "%s mem type error %d\n", __func__, ar->debug.mem_type);
+		return -EINVAL;
+	}
+
+	ret_read = ath11k_qmi_wlanfw_athdiag_read_send(ab, ar->debug.mem_type,
+						       ar->debug.mem_offset, &reg_value);
+	if (ret_read < 0)
+		len += scnprintf(buf + len, sizeof(buf) - len,
+				 "failed to read reg, err=%d\n", ret_read);
+	else
+		len += scnprintf(buf + len, sizeof(buf) - len, "0x%x\n", reg_value);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_reg_value = {
+	.read = ath11k_read_reg_value,
+	.write = NULL,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
@@ -1152,6 +1306,21 @@ int ath11k_debugfs_register(struct ath11k *ar)
 				    &ar->dfs_block_radar_events);
 	}
 
+	switch (ab->hw_rev) {
+	case ATH11K_HW_WCN6855_HW20:
+		debugfs_create_file("reg_addr", 0600,
+				    ar->debug.debugfs_pdev, ar,
+				    &fops_reg_addr);
+		debugfs_create_file("reg_value", 0400,
+				    ar->debug.debugfs_pdev, ar,
+				    &fops_reg_value);
+		break;
+	default:
+		ath11k_warn(ab, "reg_addr debugfs not support hardware: %d\n",
+			    ab->hw_rev);
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d0701e8eca9c..fc2fe84fc646 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1628,6 +1628,86 @@ static struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
 	},
 };
 
+static struct qmi_elem_info qmi_wlanfw_athdiag_read_req_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x01,
+		.offset		= offsetof(struct qmi_wlanfw_athdiag_read_req_msg_v01,
+					   mem_offset),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_wlanfw_athdiag_read_req_msg_v01,
+					   mem_type),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x03,
+		.offset		= offsetof(struct qmi_wlanfw_athdiag_read_req_msg_v01,
+					   data_len),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static struct qmi_elem_info qmi_wlanfw_athdiag_read_resp_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_wlanfw_athdiag_read_resp_msg_v01,
+					   resp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_athdiag_read_resp_msg_v01,
+					   data_valid),
+	},
+	{
+		.data_type	= QMI_DATA_LEN,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_athdiag_read_resp_msg_v01,
+					   data_len),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= QMI_WLANFW_MAX_ATHDIAG_DATA_SIZE_V01,
+		.elem_size	= sizeof(u8),
+		.array_type	= VAR_LEN_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_athdiag_read_resp_msg_v01,
+					   data),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
 static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_host_cap_req_msg_v01 req;
@@ -3025,3 +3105,60 @@ void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_qmi_deinit_service);
 
+int ath11k_qmi_wlanfw_athdiag_read_send(struct ath11k_base *ab, u32 mem_type,
+					u32 mem_offset, u32 *out)
+{
+	int ret;
+	struct qmi_wlanfw_athdiag_read_req_msg_v01 req;
+	struct qmi_wlanfw_athdiag_read_resp_msg_v01 *resp;
+	struct qmi_txn txn;
+
+	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	req.mem_type = mem_type;
+	req.mem_offset = mem_offset;
+	req.data_len = sizeof(u32);
+
+	ath11k_info(ab, "%s start, mem_type %d offset 0x%x\n",
+		    __func__, mem_type, mem_offset);
+	ret = qmi_txn_init(&ab->qmi.handle, &txn,
+			   qmi_wlanfw_athdiag_read_resp_msg_v01_ei, resp);
+	if (ret < 0)
+		goto out;
+
+	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
+			       QMI_WLANFW_ATHDIAG_READ_REQ_V01,
+			       QMI_WLANFW_ATHDIAG_READ_REQ_MSG_V01_MAX_LEN,
+			       qmi_wlanfw_athdiag_read_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		qmi_txn_cancel(&txn);
+		ath11k_warn(ab, "qmi failed to send wlan diag read request, err = %d\n",
+			    ret);
+		goto out;
+	}
+
+	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
+	if (ret < 0) {
+		ath11k_warn(ab, "qmi failed wlan diag read request, err = %d\n", ret);
+		goto out;
+	}
+
+	if (resp->resp.result != QMI_RESULT_SUCCESS_V01 ||
+	    !resp->data_valid ||
+	    resp->data_len != sizeof(u32)) {
+		ath11k_warn(ab, "QMI request failed result=%d, error=%d, valid=%d, len=%d\n",
+			    resp->resp.result, resp->resp.error,
+			    resp->data_valid, resp->data_len);
+		ret = -EINVAL;
+		goto out;
+	}
+	*out = *(u32 *)resp->data;
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi read reg pass, resp.data = 0x%08x\n",
+		   *(u32 *)resp->data);
+
+out:
+	kfree(resp);
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index ba2eff4d59cb..2cd6a3043d59 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -181,6 +181,43 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
+#define QMI_WLANFW_MAX_ATHDIAG_DATA_SIZE_V01	512
+#define QMI_WLANFW_ATHDIAG_READ_REQ_V01	0x0030
+#define QMI_WLANFW_ATHDIAG_READ_RESP_V01	0x0030
+#define QMI_WLANFW_ATHDIAG_READ_REQ_MSG_V01_MAX_LEN	21
+
+enum qmi_allocram_arena {
+	QMI_ALLOCRAM_HRAM_ARENA,
+	QMI_ALLOCRAM_HCRAM_ARENA,
+	QMI_ALLOCRAM_HREMOTE_ARENA,
+	QMI_ALLOCRAM_HCREMOTE_ARENA,
+	QMI_ALLOCRAM_REMOTE_ARENA,
+	QMI_ALLOCRAM_SRAM_ARENA,
+	QMI_ALLOCRAM_SRAM_AUX_ARENA,
+	QMI_ALLOCRAM_PAGEABLE_ARENA,
+	QMI_ALLOCRAM_CMEM_ARENA,
+	QMI_ALLOCRAM_TRAM_ARENA,
+	QMI_ALLOCRAM_HWIO_ARENA,
+	QMI_ALLOCRAM_CALDB_ARENA,
+	QMI_ALLOCRAM_M3_ARENA,
+	QMI_ALLOCRAM_ETMREMOTE_ARENA,
+	QMI_ALLOCRAM_EMUPHY_ARENA,
+	QMI_ALLOCRAM_ARENA_MAX,
+};
+
+struct qmi_wlanfw_athdiag_read_req_msg_v01 {
+	u32 mem_offset;
+	u32 mem_type;
+	u32 data_len;
+};
+
+struct qmi_wlanfw_athdiag_read_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	u8 data_valid;
+	u32 data_len;
+	u8 data[QMI_WLANFW_MAX_ATHDIAG_DATA_SIZE_V01];
+};
+
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54
 #define QMI_WLANFW_IND_REGISTER_REQ_V01				0x0020
 #define QMI_WLANFW_IND_REGISTER_RESP_MSG_V01_MAX_LEN		18
@@ -492,5 +529,7 @@ void ath11k_qmi_event_work(struct work_struct *work);
 void ath11k_qmi_msg_recv_work(struct work_struct *work);
 void ath11k_qmi_deinit_service(struct ath11k_base *ab);
 int ath11k_qmi_init_service(struct ath11k_base *ab);
+int ath11k_qmi_wlanfw_athdiag_read_send(struct ath11k_base *ab, u32 mem_type,
+					u32 offset, u32 *out);
 
 #endif
-- 
2.25.1

