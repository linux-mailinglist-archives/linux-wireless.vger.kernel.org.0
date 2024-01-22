Return-Path: <linux-wireless+bounces-2310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC6835D6E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C753B28306
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC33B18E;
	Mon, 22 Jan 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X4WnLI46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A43A1D0
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913658; cv=none; b=F9TfhLUcwBbvuTmsnBP7GDk4P4oVyb3x2AF+yCOWTcbR9fLyU1MTIRljOB/2zoxUz5W2CXFdnQ8+iMen6ESMv4qPBUKHvsY4GQhZQEAty3HJJiC9TzgBtDqQ5SoRMeJMBedxEe79uMCWmTycZIoWUVyMRmlLY0zt5WGMjVPXW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913658; c=relaxed/simple;
	bh=T0Zdv3boN0RRkSJVFRVJzbt+KLDeUmTK68+CEoS0LAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPi62eeimo3uVuYRw11UbvDOKxEzohWUjACE+w0KKI4oBFmjZxQBfAfZUBNUe1cV3N6f1G+4jqqAEAcny29eH5HVyNBwcCYm/L62U6YwnuezkVP/t7KN2cVKIEEy90CkL5jQn7OgDy7VWuhHimQ50DT55MQAsP8NAzOGakUPI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X4WnLI46; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M4x6fQ020004;
	Mon, 22 Jan 2024 08:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=EwBrK9z4RbSk+oCwSWmJmRVPXHOrn8B/Aq6x7lYtMfE=; b=X4
	WnLI46GPltAbdse0OWfhl2AKO1MCXMroxSGtIf52jOYkR0ymO7j+kA0sI+Rt4yL+
	/WDD57MN2+DWTvJYx5yOEtMttRjRJyQs9ZU2JCYLdbpnFUwPti9/dMR8SJ0FKWgj
	ZTwA2mh5s8GOfBH01W1VaY06YqbFH0fJpSk7fiJxiGmyqgqk2RgnnHk8YEVYUj6W
	fAapmvjk4FqQyx7m04Dbnwd09WRglUid12PX5SSQSx+JJIECiw23OWg4sTYZrj9U
	s0PFH8iEPJ397DisKI2jq4pl0Hz7ncaNX5FgV4QaPZULhfI06H5Rz13a41iTBriN
	NFLUNDpugouoQWvYL2CQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr54wuf6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 08:54:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M8sBwY023489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 08:54:11 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 00:54:09 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath12k: add processing for TWT disable event
Date: Mon, 22 Jan 2024 03:53:36 -0500
Message-ID: <20240122085336.3985-3-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122085336.3985-1-quic_lingbok@quicinc.com>
References: <20240122085336.3985-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pyg44WRuSS9GbVky_VbOxIxANsCorE8E
X-Proofpoint-GUID: Pyg44WRuSS9GbVky_VbOxIxANsCorE8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=827 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220063

When ath12k send TWT disable command to firmware, firmware will return a
TWT disable event to ath12k. Through the analysis of TWT disable event
status, we can easily obtain the status of TWT disable command. It can be
more convenient to debug TWT.

This patch works with WCN7850 and QCN9274.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v2:
1.Change the call way of ath12k_wmi_tlv_parse_alloc() based on
wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()

 drivers/net/wireless/ath/ath12k/wmi.c | 35 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  5 ++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e6276d92ea73..0ed1eaee1a75 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -164,6 +164,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
 	[WMI_TAG_TWT_ENABLE_COMPLETE_EVENT] = {
 		.min_len = sizeof(struct wmi_twt_enable_event) },
+	[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT] = {
+		.min_len = sizeof(struct wmi_twt_disable_event) },
 };
 
 static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
@@ -6701,6 +6703,35 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
 	kfree(tb);
 }
 
+static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
+					 struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_twt_disable_event *ev;
+	int ret;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath12k_warn(ab, "failed to parse wmi twt disable status event tlv: %d\n",
+			    ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT];
+	if (!ev) {
+		ath12k_warn(ab, "failed to fetch twt disable wmi event\n");
+		goto exit;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt disable event pdev id %d status %u\n",
+		   le32_to_cpu(ev->pdev_id),
+		   le32_to_cpu(ev->status));
+
+exit:
+	kfree(tb);
+}
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -6799,10 +6830,12 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_TWT_ENABLE_EVENTID:
 		ath12k_wmi_twt_enable_event(ab, skb);
 		break;
+	case WMI_TWT_DISABLE_EVENTID:
+		ath12k_wmi_twt_disable_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
-	case WMI_TWT_DISABLE_EVENTID:
 	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
 		ath12k_dbg(ab, ATH12K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 7570ef7be38d..d9e8b10a3c3c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4802,6 +4802,11 @@ struct wmi_twt_enable_event {
 	__le32 status;
 } __packed;
 
+struct wmi_twt_disable_event {
+	__le32 pdev_id;
+	__le32 status;
+} __packed;
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
-- 
2.34.1


