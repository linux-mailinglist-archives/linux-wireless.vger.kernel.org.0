Return-Path: <linux-wireless+bounces-23277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E24AC07D7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB93B88B4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2DC2882C7;
	Thu, 22 May 2025 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hHVjG572"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA92882B2;
	Thu, 22 May 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904096; cv=none; b=eeeknbtohvXkO/agjS7fLeZQ7yNlEMH7JribRohb+PrCKUIS184uRTQB/m4ZMrVo/tVdRkLHAJ/Gxd28jAsocPSj4i7qVITHpGJUJx1uP8trB3cVmPDXJnfnwm2Cx7ifoRjPgc3aDa2Na1iCIuMK0I7xEEYPSfOyY7qpMt4ji8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904096; c=relaxed/simple;
	bh=ziZ1uJd3i+gVN8sRZcN63ECYGxw8eOrFbSfR0SfhKn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pL+smpb+GUy8yWjNGwWheaDifuahHBIccz6LtYb8o1+Vx6AMqjEnvgAnBj+b72GK8kOahM6a5ibJUfjx7d0akdzGvWwG4Pwh/NbOKIlsXiaPt+gBkNfFmpxbNX+XYLwz+RA+r0W5eO4nFbiqg/5rGmy42I6/OZaxNSfv1adnxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hHVjG572; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M849xl010335;
	Thu, 22 May 2025 08:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	13udXdGvp/sWyqVQcCI0INzXmz+6L+Bqht8dD/AR41I=; b=hHVjG572n2YRzSac
	jV8nalOtXInd2l9RIWko1fymgVM5bxXjz/YyxT2R656ysZF+ONEj3QXcwtiENpb7
	AfnXD1RLSPORsks2CeVPjuLLxMZEWpWQjojrAEnR2eXW8qlXMP1dJtHhmvmVUMzs
	oi2yhNvhJFJYlWHe51jWnFaZxgyQ0wqPrhBk0kGVOH/8tnf3QciC/BmfmtG7JFlu
	ue7QjaUar4P1mw3+JcivcUpwN5JFy9aSV0wzQjSk90E6yYLlxvuXhiFHLkD8YvIv
	nmmQ/o3wh7OpvHMeIBBRq83wcmvaGSf3GHt5Gtw50A5lGTBT3kKb98fn05dBBJW3
	tEWgTg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9wqcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8skmk020058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:46 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 01:54:45 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 22 May 2025 16:54:11 +0800
Subject: [PATCH ath-next 2/6] wifi: ath12k: parse and save
 sbs_lower_band_end_freq from WMI_SERVICE_READY_EXT2_EVENTID event
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250522-ath12k-sbs-dbs-v1-2-54a29e7a3a88@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682ee657 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=M8GWZWT4-IjaPc7Le1UA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: tq8IhhxfNBQWYc1IDf3WZyfpNgaymb27
X-Proofpoint-GUID: tq8IhhxfNBQWYc1IDf3WZyfpNgaymb27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfXzweI9pq1SZM+
 cKsePtcssvkjFafPixatFKVq/CELl2jHA3kUFZnTPnBvkbso2dEMmQVSU61t9Xzq6CYl8oORlgt
 fS0ZpveQ3ekRidtfzVu1D9CsAlgxC60+qLA4AdunRp4IPly/DE7HxAx+v2SgXUKikRIEKIf08OX
 vlVtLyOWv0he4AOD6iQFyxUxTfQKqA/1PvjW9xrIuU7RGgsaCP+gQ8Z30q599Z8gS1FlGBqWJjk
 M8hK1fZlUnzPhsC1/Y9YPfQlGrti7QT1SdQhr9vpPA/+v1/wIZd3N0V+kJSvfA9aJs9yzvhvZWN
 IMEA6Iq+1vhg5mrEgm88RXQHPcc6pJ/2PLIchiixlj4b5rybSnLwLIe/kyBm7LF1IbnbdQCAplI
 HrlitHEYiCuZjiS8ErSlqUDrSBzui9eSUzwXcnCx/yfxpjQhaJQ91smfQRYywyHvy3zUzQW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220089

Firmware sends the boundary between lower and higher bands in
ath12k_wmi_dbs_or_sbs_cap_params structure embedded in
WMI_SERVICE_READY_EXT2_EVENTID event. The boundary is needed when
updating frequency range in the following patch. So parse and save
it for later use. Note ath12k_wmi_dbs_or_sbs_cap_params is placed
after some other structures, so placeholders for them are added
as well.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 23 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 056bee8023a085dbc7c9be8177105b66e29eaeed..44c03d6657843a5c9324d7787aa069de295456bb 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -91,6 +91,11 @@ struct ath12k_wmi_svc_rdy_ext2_parse {
 	bool dma_ring_cap_done;
 	bool spectral_bin_scaling_done;
 	bool mac_phy_caps_ext_done;
+	bool hal_reg_caps_ext2_done;
+	bool scan_radio_caps_ext2_done;
+	bool twt_caps_done;
+	bool htt_msdu_idx_to_qtype_map_done;
+	bool dbs_or_sbs_cap_ext_done;
 };
 
 struct ath12k_wmi_rdy_parse {
@@ -4991,6 +4996,7 @@ static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 					 u16 tag, u16 len,
 					 const void *ptr, void *data)
 {
+	const struct ath12k_wmi_dbs_or_sbs_cap_params *dbs_or_sbs_caps;
 	struct ath12k_wmi_pdev *wmi_handle = &ab->wmi_ab.wmi[0];
 	struct ath12k_wmi_svc_rdy_ext2_parse *parse = data;
 	int ret;
@@ -5032,6 +5038,23 @@ static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 			}
 
 			parse->mac_phy_caps_ext_done = true;
+		} else if (!parse->hal_reg_caps_ext2_done) {
+			parse->hal_reg_caps_ext2_done = true;
+		} else if (!parse->scan_radio_caps_ext2_done) {
+			parse->scan_radio_caps_ext2_done = true;
+		} else if (!parse->twt_caps_done) {
+			parse->twt_caps_done = true;
+		} else if (!parse->htt_msdu_idx_to_qtype_map_done) {
+			parse->htt_msdu_idx_to_qtype_map_done = true;
+		} else if (!parse->dbs_or_sbs_cap_ext_done) {
+			dbs_or_sbs_caps = ptr;
+			ab->wmi_ab.sbs_lower_band_end_freq =
+				__le32_to_cpu(dbs_or_sbs_caps->sbs_lower_band_end_freq);
+
+			ath12k_dbg(ab, ATH12K_DBG_WMI, "sbs_lower_band_end_freq %u\n",
+				   ab->wmi_ab.sbs_lower_band_end_freq);
+
+			parse->dbs_or_sbs_cap_ext_done = true;
 		}
 		break;
 	default:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 96c31b7820ec14ec8df2fa0d060da6d257d7a083..e69d53054f6d863e5d02358175ccc0a23012a829 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2747,6 +2747,11 @@ struct wmi_service_ready_ext2_event {
 	__le32 default_num_msduq_supported_per_tid;
 } __packed;
 
+struct ath12k_wmi_dbs_or_sbs_cap_params {
+	__le32 hw_mode_id;
+	__le32 sbs_lower_band_end_freq;
+} __packed;
+
 struct ath12k_wmi_caps_ext_params {
 	__le32 hw_mode_id;
 	__le32 pdev_and_hw_link_ids;
@@ -5097,6 +5102,7 @@ struct ath12k_wmi_base {
 	struct ath12k_wmi_target_cap_arg *targ_cap;
 
 	struct ath12k_svc_ext_info svc_ext_info;
+	u32 sbs_lower_band_end_freq;
 };
 
 struct wmi_pdev_set_bios_interface_cmd {

-- 
2.25.1


