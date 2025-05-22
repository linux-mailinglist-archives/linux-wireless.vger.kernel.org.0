Return-Path: <linux-wireless+bounces-23278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BDAC07DA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DFA7AE185
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F05288C82;
	Thu, 22 May 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SIqfdw0N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B91288C12;
	Thu, 22 May 2025 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904099; cv=none; b=ob6h39wmMX9sxKE675Efmc84cfYaQ6jnOUw8vL31iQ3QUOATSHK0OEH9DoC3zRwliedUoKOjFkW6uNbB9oXhSjf7LGF0q7rSU2qev0knjgM8C6U3/4cqziM7PpO93RyId09gqAJZvf7nv0e3rq6gFfKBmRE0BDEJ3lJhVMPRQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904099; c=relaxed/simple;
	bh=RNYZ8NSjTHwMUtXcpziJZwNa1jdc3AFNHMjIDpVmOK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZCd5C/0fNFqMr6cNe6G1roH00wcP6Rnie0bZyx+5gQlB7E8CnEdkFHPC2h52x6bflkII8PrWaKjN+EusTiAkxvu2VaD4O0nLBKbZYYK45l3igQnEbzQZpF77/EocRKmb4wkB6H5DAlJga2yTKli7F8N8rKn/1s+r05+pi8PI1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SIqfdw0N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M6JDZY020559;
	Thu, 22 May 2025 08:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+u4rIYU9LoTxKfsY4kTN2jIWG3p7WfmyMFc9DmkQ5Gc=; b=SIqfdw0Nv4M331QK
	V1siaijkYeXgZiTWEARKpjiuVcldZz0SHsh9t8vPd7Os0hr/YID0jOeMFR8hhYHh
	2euXYklyJsmIS/GpoNP2jg0uGlGSwpoiUtGLYFCLhgG8LyHFTkyNikkSi74x9b0m
	k1wd1Qq0/zz/I2wAPhTjA98Yeklfy7X+LUMm5n5cLM4ddHfavhmIfF7ejFor92kF
	sYuwvxGNlCQEyLSkCvKX/NKB7oJ2wFKFlJ6gHCJEQ3sTTVUkHOucas5onKglK36R
	jnsrxpNncxf3PU+BbolIDOsKpfCJzzWn5VK2JlqYIE90jc9xUje7yscMKOQvs9lg
	mM4++g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6wn71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8soKn001143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:50 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 01:54:48 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 22 May 2025 16:54:13 +0800
Subject: [PATCH ath-next 4/6] wifi: ath12k: support
 WMI_MLO_LINK_SET_ACTIVE_CMDID command
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250522-ath12k-sbs-dbs-v1-4-54a29e7a3a88@quicinc.com>
References: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
In-Reply-To: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
To: Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YC9DmFzHz6Cu1n6UwkbXLXms44nwyyx1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfXxCHSf/7RlFdL
 8LtWVnn4hSl6Lroo9T0HATVCbxKQ8HcPOY+PWhVy6y6yFql+kA5gXR97oK25lPVdHD4DsjfkZ1h
 72THD4wxp7/koQHzE9/DpZaY3t3UEDDvFwX6/2soZ0bO55Jz98JAswOPdx97+zxcPfwmigstSaF
 sSW04zEZWFXQZHOG9p9ny+/WkJM7Mh8wXuAoQqtBCVij3NfkpkO3dQ20HRKiA1IjYsQpf9wty28
 7wpsjx+K2KHdhEw/qNhTMdT7mJRQeqzt0QVMAsdmc93nqLV2N690s9QV2cixiuwjNWUJDQxD04+
 Afx9T/0zvYXm1FGYy0bthIkaids2OapwIiz5iXXt3XQfY5mn80fPx9d0xr+16pJEcrrBk1xiWJQ
 GYlJ43kTSWzeT4JZmpRPl4wiBW9kW+8FM7cQC1zhWGpWHT9Xoxw46edqt9RKjghXa3cAyp6O
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682ee65b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=6is3i1eodVJ-4nelyAoA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: YC9DmFzHz6Cu1n6UwkbXLXms44nwyyx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=992
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220089

Add WMI_MLO_LINK_SET_ACTIVE_CMDID command. This command allows host to
send required link information to firmware such that firmware can make
decision on activating/deactivating links in various scenarios.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 221 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 116 +++++++++++++++++-
 2 files changed, 336 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4f016f5912066fa8ed0ac7e77c87fa625870015e..d887bc92da1700d5847746c7be03d630cc4d0078 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -10445,3 +10445,224 @@ int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
 
 	return 0;
 }
+
+static int
+ath12k_wmi_fill_disallowed_bmap(struct ath12k_base *ab,
+				struct wmi_disallowed_mlo_mode_bitmap_params *dislw_bmap,
+				struct wmi_mlo_link_set_active_arg *arg)
+{
+	struct wmi_ml_disallow_mode_bmap_arg *dislw_bmap_arg;
+	u8 i;
+
+	if (arg->num_disallow_mode_comb >
+	    ARRAY_SIZE(arg->disallow_bmap)) {
+		ath12k_warn(ab, "invalid num_disallow_mode_comb: %d",
+			    arg->num_disallow_mode_comb);
+		return -EINVAL;
+	}
+
+	dislw_bmap_arg = &arg->disallow_bmap[0];
+	for (i = 0; i < arg->num_disallow_mode_comb; i++) {
+		dislw_bmap->tlv_header =
+				ath12k_wmi_tlv_cmd_hdr(0, sizeof(*dislw_bmap));
+		dislw_bmap->disallowed_mode_bitmap =
+				cpu_to_le32(dislw_bmap_arg->disallowed_mode);
+		dislw_bmap->ieee_link_id_comb =
+			le32_encode_bits(dislw_bmap_arg->ieee_link_id[0],
+					 WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_1) |
+			le32_encode_bits(dislw_bmap_arg->ieee_link_id[1],
+					 WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_2) |
+			le32_encode_bits(dislw_bmap_arg->ieee_link_id[2],
+					 WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_3) |
+			le32_encode_bits(dislw_bmap_arg->ieee_link_id[3],
+					 WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_4);
+
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "entry %d disallowed_mode %d ieee_link_id_comb 0x%x",
+			   i, dislw_bmap_arg->disallowed_mode,
+			   dislw_bmap_arg->ieee_link_id_comb);
+		dislw_bmap++;
+		dislw_bmap_arg++;
+	}
+
+	return 0;
+}
+
+int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
+					    struct wmi_mlo_link_set_active_arg *arg)
+{
+	struct wmi_disallowed_mlo_mode_bitmap_params *disallowed_mode_bmap;
+	struct wmi_mlo_set_active_link_number_params *link_num_param;
+	u32 num_link_num_param = 0, num_vdev_bitmap = 0;
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_mlo_link_set_active_cmd *cmd;
+	u32 num_inactive_vdev_bitmap = 0;
+	u32 num_disallow_mode_comb = 0;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	__le32 *vdev_bitmap;
+	void *buf_ptr;
+	int i, ret;
+	u32 len;
+
+	if (!arg->num_vdev_bitmap && !arg->num_link_entry) {
+		ath12k_warn(ab, "Invalid num_vdev_bitmap and num_link_entry");
+		return -EINVAL;
+	}
+
+	switch (arg->force_mode) {
+	case WMI_MLO_LINK_FORCE_MODE_ACTIVE_LINK_NUM:
+	case WMI_MLO_LINK_FORCE_MODE_INACTIVE_LINK_NUM:
+		num_link_num_param = arg->num_link_entry;
+		fallthrough;
+	case WMI_MLO_LINK_FORCE_MODE_ACTIVE:
+	case WMI_MLO_LINK_FORCE_MODE_INACTIVE:
+	case WMI_MLO_LINK_FORCE_MODE_NO_FORCE:
+		num_vdev_bitmap = arg->num_vdev_bitmap;
+		break;
+	case WMI_MLO_LINK_FORCE_MODE_ACTIVE_INACTIVE:
+		num_vdev_bitmap = arg->num_vdev_bitmap;
+		num_inactive_vdev_bitmap = arg->num_inactive_vdev_bitmap;
+		break;
+	default:
+		ath12k_warn(ab, "Invalid force mode: %u", arg->force_mode);
+		return -EINVAL;
+	}
+
+	num_disallow_mode_comb = arg->num_disallow_mode_comb;
+	len = sizeof(*cmd) +
+	      TLV_HDR_SIZE + sizeof(*link_num_param) * num_link_num_param +
+	      TLV_HDR_SIZE + sizeof(*vdev_bitmap) * num_vdev_bitmap +
+	      TLV_HDR_SIZE + TLV_HDR_SIZE + TLV_HDR_SIZE +
+	      TLV_HDR_SIZE + sizeof(*disallowed_mode_bmap) * num_disallow_mode_comb;
+	if (arg->force_mode == WMI_MLO_LINK_FORCE_MODE_ACTIVE_INACTIVE)
+		len += sizeof(*vdev_bitmap) * num_inactive_vdev_bitmap;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_mlo_link_set_active_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_LINK_SET_ACTIVE_CMD,
+						 sizeof(*cmd));
+	cmd->force_mode = cpu_to_le32(arg->force_mode);
+	cmd->reason = cpu_to_le32(arg->reason);
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "mode %d reason %d num_link_num_param %d num_vdev_bitmap %d inactive %d num_disallow_mode_comb %d",
+		   arg->force_mode, arg->reason, num_link_num_param,
+		   num_vdev_bitmap, num_inactive_vdev_bitmap,
+		   num_disallow_mode_comb);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+					 sizeof(*link_num_param) * num_link_num_param);
+	buf_ptr += TLV_HDR_SIZE;
+
+	if (num_link_num_param) {
+		cmd->ctrl_flags =
+			le32_encode_bits(arg->ctrl_flags.dync_force_link_num ? 1 : 0,
+					 CRTL_F_DYNC_FORCE_LINK_NUM);
+
+		link_num_param = buf_ptr;
+		for (i = 0; i < num_link_num_param; i++) {
+			link_num_param->tlv_header =
+				ath12k_wmi_tlv_cmd_hdr(0, sizeof(*link_num_param));
+			link_num_param->num_of_link =
+				cpu_to_le32(arg->link_num[i].num_of_link);
+			link_num_param->vdev_type =
+				cpu_to_le32(arg->link_num[i].vdev_type);
+			link_num_param->vdev_subtype =
+				cpu_to_le32(arg->link_num[i].vdev_subtype);
+			link_num_param->home_freq =
+				cpu_to_le32(arg->link_num[i].home_freq);
+			ath12k_dbg(ab, ATH12K_DBG_WMI,
+				   "entry %d num_of_link %d vdev type %d subtype %d freq %d control_flags %d",
+				   i, arg->link_num[i].num_of_link,
+				   arg->link_num[i].vdev_type,
+				   arg->link_num[i].vdev_subtype,
+				   arg->link_num[i].home_freq,
+				   __le32_to_cpu(cmd->ctrl_flags));
+			link_num_param++;
+		}
+
+		buf_ptr += sizeof(*link_num_param) * num_link_num_param;
+	}
+
+	tlv = buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32,
+					 sizeof(*vdev_bitmap) * num_vdev_bitmap);
+	buf_ptr += TLV_HDR_SIZE;
+
+	if (num_vdev_bitmap) {
+		vdev_bitmap = buf_ptr;
+		for (i = 0; i < num_vdev_bitmap; i++) {
+			vdev_bitmap[i] = cpu_to_le32(arg->vdev_bitmap[i]);
+			ath12k_dbg(ab, ATH12K_DBG_WMI, "entry %d vdev_id_bitmap 0x%x",
+				   i, arg->vdev_bitmap[i]);
+		}
+
+		buf_ptr += sizeof(*vdev_bitmap) * num_vdev_bitmap;
+	}
+
+	if (arg->force_mode == WMI_MLO_LINK_FORCE_MODE_ACTIVE_INACTIVE) {
+		tlv = buf_ptr;
+		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32,
+						 sizeof(*vdev_bitmap) *
+						 num_inactive_vdev_bitmap);
+		buf_ptr += TLV_HDR_SIZE;
+
+		if (num_inactive_vdev_bitmap) {
+			vdev_bitmap = buf_ptr;
+			for (i = 0; i < num_inactive_vdev_bitmap; i++) {
+				vdev_bitmap[i] =
+					cpu_to_le32(arg->inactive_vdev_bitmap[i]);
+				ath12k_dbg(ab, ATH12K_DBG_WMI,
+					   "entry %d inactive_vdev_id_bitmap 0x%x",
+					    i, arg->inactive_vdev_bitmap[i]);
+			}
+
+			buf_ptr += sizeof(*vdev_bitmap) * num_inactive_vdev_bitmap;
+		}
+	} else {
+		/* add empty vdev bitmap2 tlv */
+		tlv = buf_ptr;
+		tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, 0);
+		buf_ptr += TLV_HDR_SIZE;
+	}
+
+	/* add empty ieee_link_id_bitmap tlv */
+	tlv = buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, 0);
+	buf_ptr += TLV_HDR_SIZE;
+
+	/* add empty ieee_link_id_bitmap2 tlv */
+	tlv = buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, 0);
+	buf_ptr += TLV_HDR_SIZE;
+
+	tlv = buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+					 sizeof(*disallowed_mode_bmap) *
+					 arg->num_disallow_mode_comb);
+	buf_ptr += TLV_HDR_SIZE;
+
+	ret = ath12k_wmi_fill_disallowed_bmap(ab, buf_ptr, arg);
+	if (ret)
+		goto free_skb;
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_MLO_LINK_SET_ACTIVE_CMDID);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to send WMI_MLO_LINK_SET_ACTIVE_CMDID: %d\n", ret);
+		goto free_skb;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "WMI mlo link set active cmd");
+
+	return ret;
+
+free_skb:
+	dev_kfree_skb(skb);
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index f2a04a7bd91aba31edd2b5503fbbe89d6f62cd25..c640ffa180c88b75d49e5c96a6ff3625f36a6d37 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1974,6 +1974,7 @@ enum wmi_tlv_tag {
 	WMI_TAG_TPC_STATS_CTL_PWR_TABLE_EVENT,
 	WMI_TAG_VDEV_SET_TPC_POWER_CMD = 0x3B5,
 	WMI_TAG_VDEV_CH_POWER_INFO,
+	WMI_TAG_MLO_LINK_SET_ACTIVE_CMD = 0x3BE,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
 	WMI_TAG_DCS_AWGN_INT_TYPE = 0x3C5,
 	WMI_TAG_MLO_TX_SEND_PARAMS,
@@ -6061,6 +6062,118 @@ struct wmi_vdev_set_tpc_power_cmd {
 	 */
 } __packed;
 
+#define CRTL_F_DYNC_FORCE_LINK_NUM GENMASK(3, 2)
+
+struct wmi_mlo_link_set_active_cmd {
+	__le32 tlv_header;
+	__le32 force_mode;
+	__le32 reason;
+	__le32 use_ieee_link_id_bitmap;
+	struct ath12k_wmi_mac_addr_params ap_mld_mac_addr;
+	__le32 ctrl_flags;
+} __packed;
+
+struct wmi_mlo_set_active_link_number_params {
+	__le32 tlv_header;
+	__le32 num_of_link;
+	__le32 vdev_type;
+	__le32 vdev_subtype;
+	__le32 home_freq;
+} __packed;
+
+#define WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_1 GENMASK(7, 0)
+#define WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_2 GENMASK(15, 8)
+#define WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_3 GENMASK(23, 16)
+#define WMI_DISALW_MLO_MODE_BMAP_IEEE_LINK_ID_COMB_4 GENMASK(31, 24)
+
+struct wmi_disallowed_mlo_mode_bitmap_params {
+	__le32 tlv_header;
+	__le32 disallowed_mode_bitmap;
+	__le32 ieee_link_id_comb;
+} __packed;
+
+enum wmi_mlo_link_force_mode {
+	WMI_MLO_LINK_FORCE_MODE_ACTIVE			= 1,
+	WMI_MLO_LINK_FORCE_MODE_INACTIVE		= 2,
+	WMI_MLO_LINK_FORCE_MODE_ACTIVE_LINK_NUM		= 3,
+	WMI_MLO_LINK_FORCE_MODE_INACTIVE_LINK_NUM	= 4,
+	WMI_MLO_LINK_FORCE_MODE_NO_FORCE		= 5,
+	WMI_MLO_LINK_FORCE_MODE_ACTIVE_INACTIVE		= 6,
+	WMI_MLO_LINK_FORCE_MODE_NON_FORCE_UPDATE	= 7,
+};
+
+enum wmi_mlo_link_force_reason {
+	WMI_MLO_LINK_FORCE_REASON_NEW_CONNECT		= 1,
+	WMI_MLO_LINK_FORCE_REASON_NEW_DISCONNECT	= 2,
+	WMI_MLO_LINK_FORCE_REASON_LINK_REMOVAL		= 3,
+	WMI_MLO_LINK_FORCE_REASON_TDLS			= 4,
+	WMI_MLO_LINK_FORCE_REASON_REVERT_FAILURE	= 5,
+	WMI_MLO_LINK_FORCE_REASON_LINK_DELETE		= 6,
+	WMI_MLO_LINK_FORCE_REASON_SINGLE_LINK_EMLSR_OP	= 7,
+};
+
+struct wmi_mlo_link_num_arg {
+	u32 num_of_link;
+	u32 vdev_type;
+	u32 vdev_subtype;
+	u32 home_freq;
+};
+
+struct wmi_mlo_control_flags_arg {
+	bool overwrite_force_active_bitmap;
+	bool overwrite_force_inactive_bitmap;
+	bool dync_force_link_num;
+	bool post_re_evaluate;
+	u8 post_re_evaluate_loops;
+	bool dont_reschedule_workqueue;
+};
+
+struct wmi_ml_link_force_cmd_arg {
+	u8 ap_mld_mac_addr[ETH_ALEN];
+	u16 ieee_link_id_bitmap;
+	u16 ieee_link_id_bitmap2;
+	u8 link_num;
+};
+
+struct wmi_ml_disallow_mode_bmap_arg {
+	u32 disallowed_mode;
+	union {
+		u32 ieee_link_id_comb;
+		u8 ieee_link_id[4];
+	};
+};
+
+/* maximum size of link number param array
+ * for MLO link set active command
+ */
+#define WMI_MLO_LINK_NUM_SZ 2
+
+/* maximum size of vdev bitmap array for
+ * MLO link set active command
+ */
+#define WMI_MLO_VDEV_BITMAP_SZ 2
+
+/* Max number of disallowed bitmap combination
+ * sent to firmware
+ */
+#define WMI_ML_MAX_DISALLOW_BMAP_COMB 4
+
+struct wmi_mlo_link_set_active_arg {
+	enum wmi_mlo_link_force_mode force_mode;
+	enum wmi_mlo_link_force_reason reason;
+	u32 num_link_entry;
+	u32 num_vdev_bitmap;
+	u32 num_inactive_vdev_bitmap;
+	struct wmi_mlo_link_num_arg link_num[WMI_MLO_LINK_NUM_SZ];
+	u32 vdev_bitmap[WMI_MLO_VDEV_BITMAP_SZ];
+	u32 inactive_vdev_bitmap[WMI_MLO_VDEV_BITMAP_SZ];
+	struct wmi_mlo_control_flags_arg ctrl_flags;
+	bool use_ieee_link_id;
+	struct wmi_ml_link_force_cmd_arg force_cmd;
+	u32 num_disallow_mode_comb;
+	struct wmi_ml_disallow_mode_bmap_arg disallow_bmap[WMI_ML_MAX_DISALLOW_BMAP_COMB];
+};
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -6259,5 +6372,6 @@ bool ath12k_wmi_supports_6ghz_cc_ext(struct ath12k *ar);
 int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
 				       u32 vdev_id,
 				       struct ath12k_reg_tpc_power_info *param);
-
+int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
+					    struct wmi_mlo_link_set_active_arg *param);
 #endif

-- 
2.25.1


