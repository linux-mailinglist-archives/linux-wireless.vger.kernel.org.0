Return-Path: <linux-wireless+bounces-6534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E898A9FEC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29246B24088
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35FA1635A6;
	Thu, 18 Apr 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgMCbZqt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97F16F918
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457224; cv=none; b=hxEyS7xqAi7aZRRL265svH73ILxD2e5y97HQrdUr9tKWAFdaFfvRzdomu5IGT98xWnuwC2QBeJTbxQhrA0VHvcHSdpQmYqB5CX0ozn/HsUoG8TdHVYAKI/td+afLT2Z3Qllo44u2FsP0R76ByD49QyKUJbCRYXowVxJL5bCK3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457224; c=relaxed/simple;
	bh=fb7SIt8QOxTT+dW+Xj7raVp3qo8QImB0dmu1ugfLjMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bMR4mn0K9lso3zK41/0sF7fI+bJA+svVKcaTG+z56eh64zsp20s/VdxkxdDVw6ZaagnrR/Y+ij4w7LXP44JX1p8G5aeJ5tbrZf7T8RfwPV4ecj6esAtgJ2Cnd3h4Kwl7CUpW40EcNAGe0Tz6TUyGdciqB/rzj+2zpRWn6JmVshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgMCbZqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB6DC3277B;
	Thu, 18 Apr 2024 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713457224;
	bh=fb7SIt8QOxTT+dW+Xj7raVp3qo8QImB0dmu1ugfLjMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgMCbZqt0Y7r0psVs2pWdDVlLImGvSuQhbu4Xqk7d4Pr+SJ8ToV2Wmwt2Nuklc9Mj
	 aGCJNGcPw7NxRtSXqU8oddtlMY/EE3FSdjlbZmVExVaLB3P5Xr2OwxpbyibYQLxFpZ
	 fop//NQbrdxefjIoYowS4++BE/zgJzso+RJGU3D9w6JSUJFfMJstfVwh9pVMIylhuj
	 u8wFTC1XuBGVagO5USOwnCLc4YS48SfUr/C5on131H40LX4VQHi2lGUtok/jSit8Wf
	 4cknB0TpwcL4FDG7Pg1zOV23pH91opf6TW1OdhUyNoEOMOsoSoeu4pyBpFs2Pdc4tk
	 tMIWTl1mIUxhA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v8 2/4] wifi: ath12k: ACPI SAR support
Date: Thu, 18 Apr 2024 19:20:17 +0300
Message-Id: <20240418162019.1246749-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240418162019.1246749-1-kvalo@kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lingbo Kong <quic_lingbok@quicinc.com>

In order to enable ACPI SAR (Specific Absorption Rate), ath12k gets SAR and GEO
offset tables from ACPI and sends the data to firmware using
WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID and WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID
commands.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c | 105 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h |  18 +++++
 drivers/net/wireless/ath/ath12k/core.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c  |  99 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  19 +++++
 5 files changed, 244 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 5904ff0a6f9c..b6d6187bc347 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -55,6 +55,30 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 			memcpy(&ab->acpi.tas_sar_power_table, obj->buffer.pointer,
 			       obj->buffer.length);
 
+			break;
+		case ATH12K_ACPI_DSM_FUNC_BIOS_SAR:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE) {
+				ath12k_warn(ab, "invalid ACPI BIOS SAR data size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(&ab->acpi.bios_sar_data, obj->buffer.pointer,
+			       obj->buffer.length);
+
+			break;
+		case ATH12K_ACPI_DSM_FUNC_GEO_OFFSET:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE) {
+				ath12k_warn(ab, "invalid ACPI GEO OFFSET data size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(&ab->acpi.geo_offset_data, obj->buffer.pointer,
+			       obj->buffer.length);
+
 			break;
 		}
 	} else {
@@ -93,6 +117,25 @@ static int ath12k_acpi_set_power_limit(struct ath12k_base *ab)
 	return ret;
 }
 
+static int ath12k_acpi_set_bios_sar_power(struct ath12k_base *ab)
+{
+	int ret;
+
+	if (ab->acpi.bios_sar_data[0] != ATH12K_ACPI_POWER_LIMIT_VERSION ||
+	    ab->acpi.bios_sar_data[1] != ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG) {
+		ath12k_warn(ab, "invalid latest ACPI BIOS SAR data\n");
+		return -EINVAL;
+	}
+
+	ret = ath12k_wmi_set_bios_sar_cmd(ab, ab->acpi.bios_sar_data);
+	if (ret) {
+		ath12k_warn(ab, "failed to set ACPI BIOS SAR table: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void ath12k_acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
 {
 	int ret;
@@ -119,6 +162,40 @@ static void ath12k_acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
 		ath12k_warn(ab, "failed to set ACPI TAS power limit data: %d", ret);
 		return;
 	}
+
+	if (!ab->acpi.acpi_bios_sar_enable)
+		return;
+
+	ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_BIOS_SAR);
+	if (ret) {
+		ath12k_warn(ab, "failed to update BIOS SAR: %d\n", ret);
+		return;
+	}
+
+	ret = ath12k_acpi_set_bios_sar_power(ab);
+	if (ret) {
+		ath12k_warn(ab, "failed to set BIOS SAR power limit: %d\n", ret);
+		return;
+	}
+}
+
+static int ath12k_acpi_set_bios_sar_params(struct ath12k_base *ab)
+{
+	int ret;
+
+	ret = ath12k_wmi_set_bios_sar_cmd(ab, ab->acpi.bios_sar_data);
+	if (ret) {
+		ath12k_warn(ab, "failed to set ACPI BIOS SAR table: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath12k_wmi_set_bios_geo_cmd(ab, ab->acpi.geo_offset_data);
+	if (ret) {
+		ath12k_warn(ab, "failed to set ACPI BIOS GEO table: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int ath12k_acpi_set_tas_params(struct ath12k_base *ab)
@@ -184,6 +261,28 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 			ab->acpi.acpi_tas_enable = true;
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_BIOS_SAR)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_BIOS_SAR);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI bios sar data: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_GEO_OFFSET)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_GEO_OFFSET);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI geo offset data: %d\n", ret);
+			return ret;
+		}
+
+		if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_BIOS_SAR) &&
+		    ab->acpi.bios_sar_data[0] == ATH12K_ACPI_POWER_LIMIT_VERSION &&
+		    ab->acpi.bios_sar_data[1] == ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG &&
+		    !ab->acpi.acpi_tas_enable)
+			ab->acpi.acpi_bios_sar_enable = true;
+	}
+
 	if (ab->acpi.acpi_tas_enable) {
 		ret = ath12k_acpi_set_tas_params(ab);
 		if (ret) {
@@ -192,6 +291,12 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 		}
 	}
 
+	if (ab->acpi.acpi_bios_sar_enable) {
+		ret = ath12k_acpi_set_bios_sar_params(ab);
+		if (ret)
+			return ret;
+	}
+
 	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
 					     ACPI_DEVICE_NOTIFY,
 					     ath12k_acpi_dsm_notify, ab);
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index 785758b1e999..24a4c981e8de 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -9,9 +9,13 @@
 #include <linux/acpi.h>
 
 #define ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS	0
+#define ATH12K_ACPI_DSM_FUNC_BIOS_SAR		4
+#define ATH12K_ACPI_DSM_FUNC_GEO_OFFSET		5
 #define ATH12K_ACPI_DSM_FUNC_TAS_CFG		8
 #define ATH12K_ACPI_DSM_FUNC_TAS_DATA		9
 
+#define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
+#define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
 #define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
 #define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
 
@@ -20,10 +24,24 @@
 
 #define ATH12K_ACPI_TAS_DATA_VERSION		0x1
 #define ATH12K_ACPI_TAS_DATA_ENABLE		0x1
+#define ATH12K_ACPI_POWER_LIMIT_VERSION		0x1
+#define ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG	0x1
+
+#define ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET	1
+#define ATH12K_ACPI_DBS_BACKOFF_DATA_OFFSET	2
+#define ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN	10
+#define ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET	12
+#define ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN	18
+#define ATH12K_ACPI_BIOS_SAR_TABLE_LEN		22
 
 #define ATH12K_ACPI_DSM_TAS_DATA_SIZE			69
 #define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
 
+#define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE (ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET + \
+					      ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN)
+#define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE (ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET + \
+					    ATH12K_ACPI_BIOS_SAR_TABLE_LEN)
+
 #ifdef CONFIG_ACPI
 
 int ath12k_acpi_start(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d724ce32d0b6..dac4a6cd60f1 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -908,8 +908,11 @@ struct ath12k_base {
 		bool started;
 		u32 func_bit;
 		bool acpi_tas_enable;
+		bool acpi_bios_sar_enable;
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
+		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
+		u8 geo_offset_data[ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE];
 	} acpi;
 
 #endif /* CONFIG_ACPI */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index dc09b7a9022c..c0ead7da9866 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2767,6 +2767,105 @@ int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
 	return 0;
 }
 
+int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_sar_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, sar_table_len_aligned, sar_dbs_backoff_len_aligned;
+	const u8 *psar_value = psar_table + ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET;
+	const u8 *pdbs_value = psar_table + ATH12K_ACPI_DBS_BACKOFF_DATA_OFFSET;
+
+	sar_table_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_TABLE_LEN, sizeof(u32));
+	sar_dbs_backoff_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN,
+					      sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + sar_table_len_aligned +
+		TLV_HDR_SIZE + sar_dbs_backoff_len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_sar_table_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->sar_len = cpu_to_le32(ATH12K_ACPI_BIOS_SAR_TABLE_LEN);
+	cmd->dbs_backoff_len = cpu_to_le32(ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE,
+					 sar_table_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, psar_value, ATH12K_ACPI_BIOS_SAR_TABLE_LEN);
+
+	buf_ptr += sar_table_len_aligned;
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE,
+					 sar_dbs_backoff_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, pdbs_value, ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0],
+				  skb,
+				  WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_geo_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, sar_geo_len_aligned;
+	const u8 *pgeo_value = pgeo_table + ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET;
+
+	sar_geo_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + sar_geo_len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_geo_table_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->geo_len = cpu_to_le32(ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, sar_geo_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, pgeo_value, ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0],
+				  skb,
+				  WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to send WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID %d\n",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath12k_wmi_delba_send(struct ath12k *ar, u32 vdev_id, const u8 *mac,
 			  u32 tid, u32 initiator, u32 reason)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ad9cdd3d69aa..8ace566f7eb5 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -353,6 +353,8 @@ enum wmi_tlv_cmd_id {
 	WMI_PDEV_DMA_RING_CFG_REQ_CMDID,
 	WMI_PDEV_HE_TB_ACTION_FRM_CMDID,
 	WMI_PDEV_PKTLOG_FILTER_CMDID,
+	WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID = 0x4044,
+	WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID = 0x4045,
 	WMI_PDEV_SET_BIOS_INTERFACE_CMDID = 0x404A,
 	WMI_VDEV_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_DELETE_CMDID,
@@ -1926,6 +1928,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
+	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
+	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD = 0x3D9,
 	WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD = 0x3FB,
 	WMI_TAG_MAX
 };
@@ -4806,6 +4810,19 @@ enum wmi_bios_param_type {
 	WMI_BIOS_PARAM_TYPE_MAX,
 };
 
+struct wmi_pdev_set_bios_sar_table_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 sar_len;
+	__le32 dbs_backoff_len;
+} __packed;
+
+struct wmi_pdev_set_bios_geo_table_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 geo_len;
+} __packed;
+
 #define ATH12K_FW_STATS_BUF_SIZE (1024 * 1024)
 
 enum wmi_sys_cap_info_flags {
@@ -4966,6 +4983,8 @@ int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
 int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
 			    const u8 *buf, size_t buf_len);
+int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table);
+int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
-- 
2.39.2


