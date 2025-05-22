Return-Path: <linux-wireless+bounces-23279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599BFAC07D9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DB83BF6E5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BC5288C91;
	Thu, 22 May 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A6y58wj1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B21288C11;
	Thu, 22 May 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904099; cv=none; b=jr77VX53QxGviAoRww1JwMAPi30YVk35rS+huL8TZjGwT3uBQuIH8OJlqx9mEWGr6N+sBoVxmO5Cvl9g6IR/1BbMiqvR/LNXNxl1Tiprhc/kCLVGsq4/v65IPJr3JyuqQCja9y8CHFjxuCvl/o62dqT4KLbqOF4yaOccPGqVDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904099; c=relaxed/simple;
	bh=y8G9w+0FXgi3PbSqR5mIX+Un1hXpbbgM0AoJfoorWyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qTZDVSpXNOMeYhsYpGDjZIrVappsGbmAZIeZn7oWnuY/VwLHHCrA4WM1L3BxLqVxqVVBHAYWaSoKIEWvnhiCfuUV5Q0vlnaO6CBqvZllmttrmVF1sVrBmyq3v7mjLae/rSS1YL1NwMjviIcXBtOXJNPeu0Fwwj1R1YZvHoJt1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A6y58wj1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7b1Ux027623;
	Thu, 22 May 2025 08:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	55cUKihThhrflhBcT5pYp8BTgB92Ih8pF7VUIWhd/Uk=; b=A6y58wj1f1rH8CVU
	VCKCu22y1E1DggWcNCCCxt9gVN8vpAdjmbv8jMeNRMOh5iaB2kIMtqZGRbvDi01u
	oJb9Rs/xcvuDNj1O8HcC9s5i288YFZZ248LIAtIJKieg5vaQjxXiyj6koiUPEXLB
	oVpx/dOkWOsY1/g7izF1RZgvQup/N2NF4j2Wmh0NzZBvlQvJCGPLxNhAOKjhucWq
	R01l2dVp+GRfVLNp5sURAjqhb8LLT9lGYNOr6Kv41lsRvsjZReIHr6LEhJqApcwR
	NZEUjWqZNoSUH6F30bAFTZjuiPaJ6dKs99GpsXQDBpEDBFMdezTG9QhsEcB9wLOh
	gEFPRg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9dmww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8smgc020630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:48 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 01:54:46 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 22 May 2025 16:54:12 +0800
Subject: [PATCH ath-next 3/6] wifi: ath12k: update freq range for each
 hardware mode
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250522-ath12k-sbs-dbs-v1-3-54a29e7a3a88@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WLyG-o2C9L-X6LIhWX9LgoD0W7ObaohS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfXzZ4M83/Z7UnA
 MgC/wxwsIJvRsrKbvOJTcf6fOeBuhfAA1PfWRUFFODx3Pw8zn8qhRoFaMyb05kSAocT+FJv4DPg
 Fy5w4Cf926GkAueTmz5Dp5YArd+zGlLyYQztD+LveJ4Q69ZHeF2Tr88PnI8tRXneVA8PXht+tWc
 l0DK9AO2xpxj5faVjjnOs754/Qd8++0bG43axMbTxJizPd4IwlJQe9GxBfGPM94g60e9h8hg5xq
 ZIb/kkovpDKoJXr33Ap5RqqD1V1w1vKIoI+RUxuan9Ijof1Wa9CiTFmNdmxFKFWBmwLbNGJTL8G
 /kiauYOD9wlViWQbee9OxtRvSs1gMxkkX0zH6P2A3okMjzV/fyMEb3C7PJW78//hFMfb5f7HxSB
 dYjejoNuPr9zPlZP6gK+Uwj43xGn31573Viyhivm8eYMA+PZ9qOTV4HGEQA6b/AqkFrJJcqh
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682ee659 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=dwg9ZaVGp5ZRBSIs-eEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WLyG-o2C9L-X6LIhWX9LgoD0W7ObaohS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220089

Previous patches parse and save hardware MAC frequency range information
in ath12k_svc_ext_info structure. Such range represents hardware
capability hence needs to be updated based on host information, e.g. guard
the range based on host's low/high boundary.

So update frequency range. The updated range is saved in
ath12k_hw_mode_info structure and would be used when doing vdev activation
and link selection in following patches.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 446 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  27 ++
 2 files changed, 473 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 44c03d6657843a5c9324d7787aa069de295456bb..4f016f5912066fa8ed0ac7e77c87fa625870015e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4992,6 +4992,444 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 	return 0;
 }
 
+static void
+ath12k_wmi_update_freq_info(struct ath12k_base *ab,
+			    struct ath12k_svc_ext_mac_phy_info *mac_cap,
+			    enum ath12k_hw_mode mode,
+			    u32 phy_id)
+{
+	struct ath12k_hw_mode_info *hw_mode_info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *mac_range;
+
+	mac_range = &hw_mode_info->freq_range_caps[mode][phy_id];
+
+	if (mac_cap->supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
+		mac_range->low_2ghz_freq = max_t(u32,
+						 mac_cap->hw_freq_range.low_2ghz_freq,
+						 ATH12K_MIN_2GHZ_FREQ);
+		mac_range->high_2ghz_freq = mac_cap->hw_freq_range.high_2ghz_freq ?
+					    min_t(u32,
+						  mac_cap->hw_freq_range.high_2ghz_freq,
+						  ATH12K_MAX_2GHZ_FREQ) :
+					    ATH12K_MAX_2GHZ_FREQ;
+	}
+
+	if (mac_cap->supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
+		mac_range->low_5ghz_freq = max_t(u32,
+						 mac_cap->hw_freq_range.low_5ghz_freq,
+						 ATH12K_MIN_5GHZ_FREQ);
+		mac_range->high_5ghz_freq = mac_cap->hw_freq_range.high_5ghz_freq ?
+					    min_t(u32,
+						  mac_cap->hw_freq_range.high_5ghz_freq,
+						  ATH12K_MAX_6GHZ_FREQ) :
+					    ATH12K_MAX_6GHZ_FREQ;
+	}
+}
+
+static bool
+ath12k_wmi_all_phy_range_updated(struct ath12k_base *ab,
+				 enum ath12k_hw_mode hwmode)
+{
+	struct ath12k_hw_mode_info *hw_mode_info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *mac_range;
+	u8 phy_id;
+
+	for (phy_id = 0; phy_id < MAX_RADIOS; phy_id++) {
+		mac_range = &hw_mode_info->freq_range_caps[hwmode][phy_id];
+		/* modify SBS/DBS range only when both phy for DBS are filled */
+		if (!mac_range->low_2ghz_freq && !mac_range->low_5ghz_freq)
+			return false;
+	}
+
+	return true;
+}
+
+static void ath12k_wmi_update_dbs_freq_info(struct ath12k_base *ab)
+{
+	struct ath12k_hw_mode_info *hw_mode_info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *mac_range;
+	u8 phy_id;
+
+	mac_range = hw_mode_info->freq_range_caps[ATH12K_HW_MODE_DBS];
+	/* Reset 5 GHz range for shared mac for DBS */
+	for (phy_id = 0; phy_id < MAX_RADIOS; phy_id++) {
+		if (mac_range[phy_id].low_2ghz_freq &&
+		    mac_range[phy_id].low_5ghz_freq) {
+			mac_range[phy_id].low_5ghz_freq = 0;
+			mac_range[phy_id].high_5ghz_freq = 0;
+		}
+	}
+}
+
+static u32
+ath12k_wmi_get_highest_5ghz_freq_from_range(struct ath12k_hw_mode_freq_range_arg *range)
+{
+	u32 highest_freq = 0;
+	u8 phy_id;
+
+	for (phy_id = 0; phy_id < MAX_RADIOS; phy_id++) {
+		if (range[phy_id].high_5ghz_freq > highest_freq)
+			highest_freq = range[phy_id].high_5ghz_freq;
+	}
+
+	return highest_freq ? highest_freq : ATH12K_MAX_6GHZ_FREQ;
+}
+
+static u32
+ath12k_wmi_get_lowest_5ghz_freq_from_range(struct ath12k_hw_mode_freq_range_arg *range)
+{
+	u32 lowest_freq = 0;
+	u8 phy_id;
+
+	for (phy_id = 0; phy_id < MAX_RADIOS; phy_id++) {
+		if ((!lowest_freq && range[phy_id].low_5ghz_freq) ||
+		    range[phy_id].low_5ghz_freq < lowest_freq)
+			lowest_freq = range[phy_id].low_5ghz_freq;
+	}
+
+	return lowest_freq ? lowest_freq : ATH12K_MIN_5GHZ_FREQ;
+}
+
+static void
+ath12k_wmi_fill_upper_share_sbs_freq(struct ath12k_base *ab,
+				     u16 sbs_range_sep,
+				     struct ath12k_hw_mode_freq_range_arg *ref_freq)
+{
+	struct ath12k_hw_mode_info *hw_mode_info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *upper_sbs_freq_range;
+	u8 phy_id;
+
+	upper_sbs_freq_range =
+			hw_mode_info->freq_range_caps[ATH12K_HW_MODE_SBS_UPPER_SHARE];
+
+	for (phy_id = 0; phy_id < MAX_RADIOS; phy_id++) {
+		upper_sbs_freq_range[phy_id].low_2ghz_freq =
+						ref_freq[phy_id].low_2ghz_freq;
+		upper_sbs_freq_range[phy_id].high_2ghz_freq =
+						ref_freq[phy_id].high_2ghz_freq;
+
+		/* update for shared mac */
+		if (upper_sbs_freq_range[phy_id].low_2ghz_freq) {
+			upper_sbs_freq_range[phy_id].low_5ghz_freq = sbs_range_sep + 10;
+			upper_sbs_freq_range[phy_id].high_5ghz_freq =
+				ath12k_wmi_get_highest_5ghz_freq_from_range(ref_freq);
+		} else {
+			upper_sbs_freq_range[phy_id].low_5ghz_freq =
+				ath12k_wmi_get_lowest_5ghz_freq_from_range(ref_freq);
+			upper_sbs_freq_range[phy_id].high_5ghz_freq = sbs_range_sep;
+		}
+	}
+}
+
+static void
+ath12k_wmi_fill_lower_share_sbs_freq(struct ath12k_base *ab,
+				     u16 sbs_range_sep,
+				     struct ath12k_hw_mode_freq_range_arg *ref_freq)
+{
+	struct ath12k_hw_mode_info *hw_mode_info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *lower_sbs_freq_range;
+	u8 phy_id;
+
+	lower_sbs_freq_range =
+			hw_mode_info->freq_range_caps[ATH12K_HW_MODE_SBS_LOWER_SHARE];
+
+	for (phy_id = 0; phy_id < MAX_RADIOS; phy_id++) {
+		lower_sbs_freq_range[phy_id].low_2ghz_freq =
+						ref_freq[phy_id].low_2ghz_freq;
+		lower_sbs_freq_range[phy_id].high_2ghz_freq =
+						ref_freq[phy_id].high_2ghz_freq;
+
+		/* update for shared mac */
+		if (lower_sbs_freq_range[phy_id].low_2ghz_freq) {
+			lower_sbs_freq_range[phy_id].low_5ghz_freq =
+				ath12k_wmi_get_lowest_5ghz_freq_from_range(ref_freq);
+			lower_sbs_freq_range[phy_id].high_5ghz_freq = sbs_range_sep;
+		} else {
+			lower_sbs_freq_range[phy_id].low_5ghz_freq = sbs_range_sep + 10;
+			lower_sbs_freq_range[phy_id].high_5ghz_freq =
+				ath12k_wmi_get_highest_5ghz_freq_from_range(ref_freq);
+		}
+	}
+}
+
+static const char *ath12k_wmi_hw_mode_to_str(enum ath12k_hw_mode hw_mode)
+{
+	static const char * const mode_str[] = {
+		[ATH12K_HW_MODE_SMM] = "SMM",
+		[ATH12K_HW_MODE_DBS] = "DBS",
+		[ATH12K_HW_MODE_SBS] = "SBS",
+		[ATH12K_HW_MODE_SBS_UPPER_SHARE] = "SBS_UPPER_SHARE",
+		[ATH12K_HW_MODE_SBS_LOWER_SHARE] = "SBS_LOWER_SHARE",
+	};
+
+	if (hw_mode >= ARRAY_SIZE(mode_str))
+		return "Unknown";
+
+	return mode_str[hw_mode];
+}
+
+static void
+ath12k_wmi_dump_freq_range_per_mac(struct ath12k_base *ab,
+				   struct ath12k_hw_mode_freq_range_arg *freq_range,
+				   enum ath12k_hw_mode hw_mode)
+{
+	u8 i;
+
+	for (i = 0; i < MAX_RADIOS; i++)
+		if (freq_range[i].low_2ghz_freq || freq_range[i].low_5ghz_freq)
+			ath12k_dbg(ab, ATH12K_DBG_WMI,
+				   "frequency range: %s(%d) mac %d 2 GHz [%d - %d] 5 GHz [%d - %d]",
+				   ath12k_wmi_hw_mode_to_str(hw_mode),
+				   hw_mode, i,
+				   freq_range[i].low_2ghz_freq,
+				   freq_range[i].high_2ghz_freq,
+				   freq_range[i].low_5ghz_freq,
+				   freq_range[i].high_5ghz_freq);
+}
+
+static void ath12k_wmi_dump_freq_range(struct ath12k_base *ab)
+{
+	struct ath12k_hw_mode_freq_range_arg *freq_range;
+	u8 i;
+
+	for (i = ATH12K_HW_MODE_SMM; i < ATH12K_HW_MODE_MAX; i++) {
+		freq_range = ab->wmi_ab.hw_mode_info.freq_range_caps[i];
+		ath12k_wmi_dump_freq_range_per_mac(ab, freq_range, i);
+	}
+}
+
+static int ath12k_wmi_modify_sbs_freq(struct ath12k_base *ab, u8 phy_id)
+{
+	struct ath12k_hw_mode_info *hw_mode_info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *sbs_mac_range, *shared_mac_range;
+	struct ath12k_hw_mode_freq_range_arg *non_shared_range;
+	u8 shared_phy_id;
+
+	sbs_mac_range = &hw_mode_info->freq_range_caps[ATH12K_HW_MODE_SBS][phy_id];
+
+	/* if SBS mac range has both 2.4 and 5 GHz ranges, i.e. shared phy_id
+	 * keep the range as it is in SBS
+	 */
+	if (sbs_mac_range->low_2ghz_freq && sbs_mac_range->low_5ghz_freq)
+		return 0;
+
+	if (sbs_mac_range->low_2ghz_freq && !sbs_mac_range->low_5ghz_freq) {
+		ath12k_err(ab, "Invalid DBS/SBS mode with only 2.4Ghz");
+		ath12k_wmi_dump_freq_range_per_mac(ab, sbs_mac_range, ATH12K_HW_MODE_SBS);
+		return -EINVAL;
+	}
+
+	non_shared_range = sbs_mac_range;
+	/* if SBS mac range has only 5 GHz then it's the non-shared phy, so
+	 * modify the range as per the shared mac.
+	 */
+	shared_phy_id = phy_id ? 0 : 1;
+	shared_mac_range =
+		&hw_mode_info->freq_range_caps[ATH12K_HW_MODE_SBS][shared_phy_id];
+
+	if (shared_mac_range->low_5ghz_freq > non_shared_range->low_5ghz_freq) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI, "high 5 GHz shared");
+		/* If the shared mac lower 5 GHz frequency is greater than
+		 * non-shared mac lower 5 GHz frequency then the shared mac has
+		 * high 5 GHz shared with 2.4 GHz. So non-shared mac's 5 GHz high
+		 * freq should be less than the shared mac's low 5 GHz freq.
+		 */
+		if (non_shared_range->high_5ghz_freq >=
+		    shared_mac_range->low_5ghz_freq)
+			non_shared_range->high_5ghz_freq =
+				max_t(u32, shared_mac_range->low_5ghz_freq - 10,
+				      non_shared_range->low_5ghz_freq);
+	} else if (shared_mac_range->high_5ghz_freq <
+		   non_shared_range->high_5ghz_freq) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI, "low 5 GHz shared");
+		/* If the shared mac high 5 GHz frequency is less than
+		 * non-shared mac high 5 GHz frequency then the shared mac has
+		 * low 5 GHz shared with 2.4 GHz. So non-shared mac's 5 GHz low
+		 * freq should be greater than the shared mac's high 5 GHz freq.
+		 */
+		if (shared_mac_range->high_5ghz_freq >=
+		    non_shared_range->low_5ghz_freq)
+			non_shared_range->low_5ghz_freq =
+				min_t(u32, shared_mac_range->high_5ghz_freq + 10,
+				      non_shared_range->high_5ghz_freq);
+	} else {
+		ath12k_warn(ab, "invalid SBS range with all 5 GHz shared");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void ath12k_wmi_update_sbs_freq_info(struct ath12k_base *ab)
+{
+	struct ath12k_hw_mode_info *hw_mode_info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *mac_range;
+	u16 sbs_range_sep;
+	u8 phy_id;
+	int ret;
+
+	mac_range = hw_mode_info->freq_range_caps[ATH12K_HW_MODE_SBS];
+
+	/* If sbs_lower_band_end_freq has a value, then the frequency range
+	 * will be split using that value.
+	 */
+	sbs_range_sep = ab->wmi_ab.sbs_lower_band_end_freq;
+	if (sbs_range_sep) {
+		ath12k_wmi_fill_upper_share_sbs_freq(ab, sbs_range_sep,
+						     mac_range);
+		ath12k_wmi_fill_lower_share_sbs_freq(ab, sbs_range_sep,
+						     mac_range);
+		/* Hardware specifies the range boundary with sbs_range_sep,
+		 * (i.e. the boundary between 5 GHz high and 5 GHz low),
+		 * reset the original one to make sure it will not get used.
+		 */
+		memset(mac_range, 0, sizeof(*mac_range) * MAX_RADIOS);
+		return;
+	}
+
+	/* If sbs_lower_band_end_freq is not set that means firmware will send one
+	 * shared mac range and one non-shared mac range. so update that freq.
+	 */
+	for (phy_id = 0; phy_id < MAX_RADIOS; phy_id++) {
+		ret = ath12k_wmi_modify_sbs_freq(ab, phy_id);
+		if (ret) {
+			memset(mac_range, 0, sizeof(*mac_range) * MAX_RADIOS);
+			break;
+		}
+	}
+}
+
+static void
+ath12k_wmi_update_mac_freq_info(struct ath12k_base *ab,
+				enum wmi_host_hw_mode_config_type hw_config_type,
+				u32 phy_id,
+				struct ath12k_svc_ext_mac_phy_info *mac_cap)
+{
+	if (phy_id >= MAX_RADIOS) {
+		ath12k_err(ab, "mac more than two not supported: %d", phy_id);
+		return;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "hw_mode_cfg %d mac %d band 0x%x SBS cutoff freq %d 2 GHz [%d - %d] 5 GHz [%d - %d]",
+		   hw_config_type, phy_id, mac_cap->supported_bands,
+		   ab->wmi_ab.sbs_lower_band_end_freq,
+		   mac_cap->hw_freq_range.low_2ghz_freq,
+		   mac_cap->hw_freq_range.high_2ghz_freq,
+		   mac_cap->hw_freq_range.low_5ghz_freq,
+		   mac_cap->hw_freq_range.high_5ghz_freq);
+
+	switch (hw_config_type) {
+	case WMI_HOST_HW_MODE_SINGLE:
+		if (phy_id) {
+			ath12k_dbg(ab, ATH12K_DBG_WMI, "mac phy 1 is not supported");
+			break;
+		}
+		ath12k_wmi_update_freq_info(ab, mac_cap, ATH12K_HW_MODE_SMM, phy_id);
+		break;
+
+	case WMI_HOST_HW_MODE_DBS:
+		if (!ath12k_wmi_all_phy_range_updated(ab, ATH12K_HW_MODE_DBS))
+			ath12k_wmi_update_freq_info(ab, mac_cap,
+						    ATH12K_HW_MODE_DBS, phy_id);
+		break;
+	case WMI_HOST_HW_MODE_DBS_SBS:
+	case WMI_HOST_HW_MODE_DBS_OR_SBS:
+		ath12k_wmi_update_freq_info(ab, mac_cap, ATH12K_HW_MODE_DBS, phy_id);
+		if (ab->wmi_ab.sbs_lower_band_end_freq ||
+		    mac_cap->hw_freq_range.low_5ghz_freq ||
+		    mac_cap->hw_freq_range.low_2ghz_freq)
+			ath12k_wmi_update_freq_info(ab, mac_cap, ATH12K_HW_MODE_SBS,
+						    phy_id);
+
+		if (ath12k_wmi_all_phy_range_updated(ab, ATH12K_HW_MODE_DBS))
+			ath12k_wmi_update_dbs_freq_info(ab);
+		if (ath12k_wmi_all_phy_range_updated(ab, ATH12K_HW_MODE_SBS))
+			ath12k_wmi_update_sbs_freq_info(ab);
+		break;
+	case WMI_HOST_HW_MODE_SBS:
+	case WMI_HOST_HW_MODE_SBS_PASSIVE:
+		ath12k_wmi_update_freq_info(ab, mac_cap, ATH12K_HW_MODE_SBS, phy_id);
+		if (ath12k_wmi_all_phy_range_updated(ab, ATH12K_HW_MODE_SBS))
+			ath12k_wmi_update_sbs_freq_info(ab);
+
+		break;
+	default:
+		break;
+	}
+}
+
+static bool ath12k_wmi_sbs_range_present(struct ath12k_base *ab)
+{
+	if (ath12k_wmi_all_phy_range_updated(ab, ATH12K_HW_MODE_SBS) ||
+	    (ab->wmi_ab.sbs_lower_band_end_freq &&
+	     ath12k_wmi_all_phy_range_updated(ab, ATH12K_HW_MODE_SBS_LOWER_SHARE) &&
+	     ath12k_wmi_all_phy_range_updated(ab, ATH12K_HW_MODE_SBS_UPPER_SHARE)))
+		return true;
+
+	return false;
+}
+
+static int ath12k_wmi_update_hw_mode_list(struct ath12k_base *ab)
+{
+	struct ath12k_svc_ext_info *svc_ext_info = &ab->wmi_ab.svc_ext_info;
+	struct ath12k_hw_mode_info *info = &ab->wmi_ab.hw_mode_info;
+	enum wmi_host_hw_mode_config_type hw_config_type;
+	struct ath12k_svc_ext_mac_phy_info *tmp;
+	bool dbs_mode = false, sbs_mode = false;
+	u32 i, j = 0;
+
+	if (!svc_ext_info->num_hw_modes) {
+		ath12k_err(ab, "invalid number of hw modes");
+		return -EINVAL;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "updated HW mode list: num modes %d",
+		   svc_ext_info->num_hw_modes);
+
+	memset(info->freq_range_caps, 0, sizeof(info->freq_range_caps));
+
+	for (i = 0; i < svc_ext_info->num_hw_modes; i++) {
+		if (j >= ATH12K_MAX_MAC_PHY_CAP)
+			return -EINVAL;
+
+		/* Update for MAC0 */
+		tmp = &svc_ext_info->mac_phy_info[j++];
+		hw_config_type = tmp->hw_mode_config_type;
+		ath12k_wmi_update_mac_freq_info(ab, hw_config_type, tmp->phy_id, tmp);
+
+		/* SBS and DBS have dual MAC. Up to 2 MACs are considered. */
+		if (hw_config_type == WMI_HOST_HW_MODE_DBS ||
+		    hw_config_type == WMI_HOST_HW_MODE_SBS_PASSIVE ||
+		    hw_config_type == WMI_HOST_HW_MODE_SBS ||
+		    hw_config_type == WMI_HOST_HW_MODE_DBS_OR_SBS) {
+			if (j >= ATH12K_MAX_MAC_PHY_CAP)
+				return -EINVAL;
+			/* Update for MAC1 */
+			tmp = &svc_ext_info->mac_phy_info[j++];
+			ath12k_wmi_update_mac_freq_info(ab, hw_config_type,
+							tmp->phy_id, tmp);
+
+			if (hw_config_type == WMI_HOST_HW_MODE_DBS ||
+			    hw_config_type == WMI_HOST_HW_MODE_DBS_OR_SBS)
+				dbs_mode = true;
+
+			if (ath12k_wmi_sbs_range_present(ab) &&
+			    (hw_config_type == WMI_HOST_HW_MODE_SBS_PASSIVE ||
+			     hw_config_type == WMI_HOST_HW_MODE_SBS ||
+			     hw_config_type == WMI_HOST_HW_MODE_DBS_OR_SBS))
+				sbs_mode = true;
+		}
+	}
+
+	info->support_dbs = dbs_mode;
+	info->support_sbs = sbs_mode;
+
+	ath12k_wmi_dump_freq_range(ab);
+
+	return 0;
+}
+
 static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 					 u16 tag, u16 len,
 					 const void *ptr, void *data)
@@ -5054,8 +5492,16 @@ static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 			ath12k_dbg(ab, ATH12K_DBG_WMI, "sbs_lower_band_end_freq %u\n",
 				   ab->wmi_ab.sbs_lower_band_end_freq);
 
+			ret = ath12k_wmi_update_hw_mode_list(ab);
+			if (ret) {
+				ath12k_warn(ab, "failed to update hw mode list: %d\n",
+					    ret);
+				return ret;
+			}
+
 			parse->dbs_or_sbs_cap_ext_done = true;
 		}
+
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index e69d53054f6d863e5d02358175ccc0a23012a829..f2a04a7bd91aba31edd2b5503fbbe89d6f62cd25 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5083,6 +5083,32 @@ struct ath12k_svc_ext_info {
 	struct ath12k_svc_ext_mac_phy_info mac_phy_info[ATH12K_MAX_MAC_PHY_CAP];
 };
 
+/**
+ * enum ath12k_hw_mode - enum for host mode
+ * @ATH12K_HW_MODE_SMM: Single mac mode
+ * @ATH12K_HW_MODE_DBS: DBS mode
+ * @ATH12K_HW_MODE_SBS: SBS mode with either high share or low share
+ * @ATH12K_HW_MODE_SBS_UPPER_SHARE: Higher 5 GHz shared with 2.4 GHz
+ * @ATH12K_HW_MODE_SBS_LOWER_SHARE: Lower 5 GHz shared with 2.4 GHz
+ * @ATH12K_HW_MODE_MAX: Max, used to indicate invalid mode
+ */
+enum ath12k_hw_mode {
+	ATH12K_HW_MODE_SMM,
+	ATH12K_HW_MODE_DBS,
+	ATH12K_HW_MODE_SBS,
+	ATH12K_HW_MODE_SBS_UPPER_SHARE,
+	ATH12K_HW_MODE_SBS_LOWER_SHARE,
+	ATH12K_HW_MODE_MAX,
+};
+
+struct ath12k_hw_mode_info {
+	bool support_dbs:1;
+	bool support_sbs:1;
+
+	struct ath12k_hw_mode_freq_range_arg freq_range_caps[ATH12K_HW_MODE_MAX]
+							    [MAX_RADIOS];
+};
+
 struct ath12k_wmi_base {
 	struct ath12k_base *ab;
 	struct ath12k_wmi_pdev wmi[MAX_RADIOS];
@@ -5103,6 +5129,7 @@ struct ath12k_wmi_base {
 
 	struct ath12k_svc_ext_info svc_ext_info;
 	u32 sbs_lower_band_end_freq;
+	struct ath12k_hw_mode_info hw_mode_info;
 };
 
 struct wmi_pdev_set_bios_interface_cmd {

-- 
2.25.1


