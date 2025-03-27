Return-Path: <linux-wireless+bounces-20878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3C5A72898
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 03:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABB516C73D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 02:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FE845C14;
	Thu, 27 Mar 2025 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JlCwOhOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9126ACC
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743041163; cv=none; b=HulRrYrBaGuKUHbqgtnnkOCpXly6FwO7s3oQW3iIpOurk6SGLUwMoHOt3I2tQe03dwH/5Nxaz5z4WV1Xnf+HAa6y59bCJb+UpEAdLX0Zy07qGr0fHWrffImLnX9MlujsdV/1Qw/htHznWKFqCX5uEr/ljcEtqgVXQYtc0AAd1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743041163; c=relaxed/simple;
	bh=1VwEoDT+I5KkGDudMWQcpydDUMrBMYlhYPfyaAmcWxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwFS3vYhKQ+Eml5pzy7Ya1LQIpz66LQn3AXRRZD38hAXsxeDBuIgHNHuCZQL2Km8yp+iamDOfOKoFrkX52O/2+7blwsrWINz1pU+0OcVe5cGt/iPmXQ7tVGTH4ru2xNWBINWZkhCTTx1pqtU/CuLrEyVZO2REJFkmlh5UJMBe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JlCwOhOq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFH9oq023554;
	Thu, 27 Mar 2025 02:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3uvI1bm2Ie6UoM19tKVGVCz49oDY61WJTbUbX5+2Asw=; b=JlCwOhOqrBqRL5wr
	9GUEF5TTtP0loXm/EiUp3afecRCdNo8RPIdgyb2TTSZ5fPXt/vvtOiqnTjff1S5r
	uC2qJzUz7oYNFu6jInvHbtHeLQ6sOxDhh5g72s3TZUMTUXZhui4sxKX0PboQSjx9
	ozEySmOo0rwyksuwGcJN0twlgpKW93kIyyNlDJV5Xg/vsO/nJwe7XLAg7ijN4sjp
	13/ML6b2R04iQMrUascrq7YBOdf7M1ZA2AMuKuR4VnUtbfsLLiR19lAAq0dkIya/
	rlWS1Re/WOyzN3sBJta6BEYowffnSQrp3gOG/ENJjom6OS66jdFLBOi9EiA+TulA
	VC3w2w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m7nf3q6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:05:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R25wl7012119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:05:59 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 19:05:57 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>, <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath-next v14 1/4] wifi: ath12k: add configure country code for WCN7850
Date: Thu, 27 Mar 2025 10:05:24 +0800
Message-ID: <20250327020527.1527-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250327020527.1527-1-quic_kangyang@quicinc.com>
References: <20250327020527.1527-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2CoC7IZYOwv_kprR8YyBAqdo-KFT5h4F
X-Proofpoint-GUID: 2CoC7IZYOwv_kprR8YyBAqdo-KFT5h4F
X-Authority-Analysis: v=2.4 cv=IMMCChvG c=1 sm=1 tr=0 ts=67e4b287 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dteaqZCelaTq9PlF0Q8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270013

From: Wen Gong <quic_wgong@quicinc.com>

Currently, WMI_SET_INIT_COUNTRY_CMDID is used to set country code for
WCN7850 and QCN9274.

But WMI_SET_INIT_COUNTRY_CMDID is not the correct command for WCN7850.

Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware, which
is used for WCN7850 to update country code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 13 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 04dd307ebfc4..c9022ecbade4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3332,6 +3332,42 @@ int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
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
index 1ba33e30ddd2..8a8504ccdc02 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4110,6 +4110,16 @@ struct ath12k_wmi_eht_rate_set_params {
 #define REG_ALPHA2_LEN 2
 #define MAX_6G_REG_RULES 5
 
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
@@ -5990,6 +6000,9 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
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


