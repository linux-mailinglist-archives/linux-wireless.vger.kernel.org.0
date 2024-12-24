Return-Path: <linux-wireless+bounces-16752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CEE9FBB96
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 10:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7443C188698F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43241922FD;
	Tue, 24 Dec 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jl0LWF88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60D1B4148
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033682; cv=none; b=C3lykQP1Ui9ABBDsrOH01sKsxtKLdAFFLG/8YxW1mcsIa8Rhfe5C9zTKHok0rwD0Q9FYf47Qr//o66Y8wgiuO2w/KLgFMSk3hj4D8FWOQJalttgCUyzLo1HdEQcy6R4qNQ5TEaqn5wfcX1a1M4sCU7Hy9u29/ZvaJoxEVvghrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033682; c=relaxed/simple;
	bh=An70SPzNfBJ7RARgacRzK7zoGh1KE4TeFWsza3bcHM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Peprlugat/hM+FRQO5h5osKKA56BU9U7yIxxxA1ei+OfnBWhrcYhe9E7OXEUeIXIdzbgMWaJnDjfon3/Jmh1wzj8e+prBRNCYqfeMNa5VFKiZ9ij9AZNEulNXTPwjohpUmItHmBbUs1zBGEmsPtsnAiww4bPJ3ie50I/bT3d1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jl0LWF88; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO9XTre028792;
	Tue, 24 Dec 2024 09:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eX27WkkeD87m/iJi0uHFtxrSAgpOY/d+pgixogM8e/U=; b=Jl0LWF8827vdS3vY
	UYwCoJ7KviJ2KFxlWu3d99QpvcO5NGtRyDnFFm3kjpWx0G8YXGuNw+j4rrQfeI8J
	aP39Xv1pV9rGaI2f3eK7e6c1sW/THk7kNoZDrpK8P98ekfPMDKbdYa/gYOmZElGP
	zc8QgJaY+hhioqiM/n1lQTSFPwG1mSSa4jmEPGjwNeMmGKJz6SQU5RskurT7jgUF
	ZrGu93V8wET71Lc+8VJFlg4NuAwQvN9uajDPbyS6TFFm18jTIQZkqPZFEr52BXUf
	TIPFwJSXjpPB4FLIusrOR5nJGS+Jv7nXGamD2ZQ0HNXVGXZoLgVlLBufQGqI5PQD
	g2BtRQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qee0jev9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 09:47:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BO9lvl9007720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 09:47:57 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 01:47:56 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v7 1/4] wifi: ath12k: add configure country code for WCN7850
Date: Tue, 24 Dec 2024 17:47:13 +0800
Message-ID: <20241224094716.530-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241224094716.530-1-quic_kangyang@quicinc.com>
References: <20241224094716.530-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ElGUqYePk4GnVfj3VfLxj4tBi78gDVPe
X-Proofpoint-GUID: ElGUqYePk4GnVfj3VfLxj4tBi78gDVPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240083

From: Wen Gong <quic_wgong@quicinc.com>

Currently, WMI_SET_INIT_COUNTRY_CMDID is used to set country code for
WCN7850 and QCN9274.

But WMI_SET_INIT_COUNTRY_CMDID is not the correct command for WCN7850.

Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware, which
is used for WCN7850 to update country code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 13 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 562b0615ed06..26be74b3d654 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3251,6 +3251,42 @@ int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
+					    struct wmi_set_current_country_arg *arg)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_set_current_country_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_set_current_country_cmd *)skb->data;
+	cmd->tlv_header =
+		ath12k_wmi_tlv_cmd_hdr(WMI_TAG_SET_CURRENT_COUNTRY_CMD,
+				       sizeof(*cmd));
+
+	cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
+	memcpy(&cmd->new_alpha2, &arg->alpha2, sizeof(arg->alpha2));
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_SET_CURRENT_COUNTRY_CMDID);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "set current country pdev id %d alpha2 %c%c\n",
+		   ar->pdev->pdev_id,
+		   arg->alpha2[0],
+		   arg->alpha2[1]);
+
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to send WMI_SET_CURRENT_COUNTRY_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int
 ath12k_wmi_send_twt_enable_cmd(struct ath12k *ar, u32 pdev_id)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index b6a197389277..367fbe87bcf4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4075,6 +4075,16 @@ struct ath12k_wmi_eht_rate_set_params {
 #define MAX_6G_REG_RULES 5
 #define REG_US_5G_NUM_REG_RULES 4
 
+struct wmi_set_current_country_arg {
+	u8 alpha2[REG_ALPHA2_LEN];
+};
+
+struct wmi_set_current_country_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 new_alpha2;
+} __packed;
+
 enum wmi_start_event_param {
 	WMI_VDEV_START_RESP_EVENT = 0,
 	WMI_VDEV_RESTART_RESP_EVENT,
@@ -5715,6 +5725,9 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
 					    u32 vdev_id, u32 bcn_ctrl_op);
 int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
 				     struct ath12k_wmi_init_country_arg *arg);
+int
+ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
+					struct wmi_set_current_country_arg *arg);
 int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
 					   int vdev_id, const u8 *addr,
 					   dma_addr_t paddr, u8 tid,
-- 
2.34.1


