Return-Path: <linux-wireless+bounces-363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF33D802CE1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7943C280EA5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AAEFBEC;
	Mon,  4 Dec 2023 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hz9fNmmd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D570D3
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:13:49 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B47R5DF025217;
	Mon, 4 Dec 2023 08:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QzLajvh9qmHfN0lck1O7zEJa9P8NR+m47iPVMprcgBQ=;
 b=Hz9fNmmdL+Urwss5enqMlhY0HnK7MMBH7Fqq8ZxfcnDG1K4NFXu4GOp9XaV4H3W88gzM
 DzbxzVeiMJpfYX5UcwUnxJcLIZl4IE5JUOZcFR61WYfJmiDlWVPDKrI3gchPX+HwRgfC
 EdgOVzU7BrxAyA/4IN4Bh4IoaISVPShBWKs5jvrnsaAvjUrIy0Sa4zwQ7R+K4/jKgPbG
 xNUklrcwtBzKLUMzA/g69fJ7YQzGkM5fG9TimGrFZNtrHgTdYzoz02Tl5/CsGspFz3sE
 AHMPJDN5jXDH9Cr048j4Boj4xuQLdp+3fr3iMS3Yj+CJBiHsf4Gok61DyUBHxjZdT8MR pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqwbqk9d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 08:13:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B48DkZG020839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Dec 2023 08:13:46 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 00:13:45 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v8 08/12] wifi: ath11k: save max tx power in vdev start response event from firmware
Date: Mon, 4 Dec 2023 16:13:19 +0800
Message-ID: <20231204081323.5582-9-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204081323.5582-1-quic_bqiang@quicinc.com>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VG6aDHpdEHNqU5Fe83lk0FelcT1WaIUn
X-Proofpoint-GUID: VG6aDHpdEHNqU5Fe83lk0FelcT1WaIUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 mlxlogscore=955 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040061

From: Wen Gong <quic_wgong@quicinc.com>

Save the max tx power received in the vdev start response event from
firmware. A subsequent patch will use this to calculate the final power
value for WMI_VDEV_SET_TPC_POWER_CMDID.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v8:
 add s-o-b tag
v7:
 no change.

 drivers/net/wireless/ath/ath11k/core.h | 1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 3 ++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7774e487abcf..bc125a2c1eac 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -777,6 +777,7 @@ struct ath11k {
 	/* protected by conf_mutex */
 	bool ps_state_enable;
 	bool ps_timekeeper_enable;
+	s8 max_allowed_tx_power;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 9a0568676a74..3f6026f5fab8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5033,6 +5033,7 @@ static int ath11k_pull_vdev_start_resp_tlv(struct ath11k_base *ab, struct sk_buf
 	vdev_rsp->mac_id = ev->mac_id;
 	vdev_rsp->cfgd_tx_streams = ev->cfgd_tx_streams;
 	vdev_rsp->cfgd_rx_streams = ev->cfgd_rx_streams;
+	vdev_rsp->max_allowed_tx_power = ev->max_allowed_tx_power;
 
 	kfree(tb);
 	return 0;
@@ -7427,7 +7428,7 @@ static void ath11k_vdev_start_resp_event(struct ath11k_base *ab, struct sk_buff
 	}
 
 	ar->last_wmi_vdev_start_status = 0;
-
+	ar->max_allowed_tx_power = vdev_start_resp.max_allowed_tx_power;
 	status = vdev_start_resp.status;
 
 	if (WARN_ON_ONCE(status)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index fa85e6eb4ab4..a9a7d81236cb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4119,6 +4119,7 @@ struct wmi_vdev_start_resp_event {
 	};
 	u32 cfgd_tx_streams;
 	u32 cfgd_rx_streams;
+	s32 max_allowed_tx_power;
 } __packed;
 
 /* VDEV start response status codes */
-- 
2.25.1


