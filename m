Return-Path: <linux-wireless+bounces-23280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54FAC07DB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B29E1777
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05605288CB3;
	Thu, 22 May 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iodPKW3Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E39288C1E;
	Thu, 22 May 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904099; cv=none; b=iKa9wNtTvepxjVerPpIcWlqwDyAEkbblfELrdvmCnsPA6TzfqHGEarktpyJaPwQRKhwnedO8c5MtWXuVFWxeSeWTY5i1dp69z6H+OyuAj9VJ1OH1JrUBTx8WBzQPGRB5XY5P0cYIIOnl6uQ82BnQpdh3QaeonRuuOv92g0tQX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904099; c=relaxed/simple;
	bh=KgDWM2VrpPlbJ/zosod746JNo0UJRh8YFQpbyUFfi/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WKFTwtB6ku5Q0o8sO9t2Udgk+Du+mJxaEt9RqCzqlOJXuqRaYQeFICtVAe3ooKaiuSPHszgSegeP7CrOgVfZzT+cf66V8SWM2+x7/B+fvhTMbPtRuRkVUNLwHM6nb0L12sXGlLBj7OGWscclLhv0H7+OGuJAfxccRvmtyBL2rlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iodPKW3Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7kijw020952;
	Thu, 22 May 2025 08:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FvSA4tlzy7a2JDs1H1eOF342LA2unoDrbetGw0uYqh8=; b=iodPKW3ZiwSuJpVa
	Rqgp5B6xzmucvQC3eAGwB621vcq3FtMbXAmUNLioHYf5j6Ons+vci3YNX6JHkbWH
	1BK2l/Lf6IKwXT4q/EYj5aPSg7S9xyESgQS8SXpm4reTyMQguLL26/Ysa2DZb9Sh
	+NP+Nl4lYW+Lmcxtg7ReLaN5VnWF76xsLW33ehavKsEOEIZzqRR9TgG5ySsW6RWj
	QPiffsM06O7m0wbfQm8Oprrbf8Q/L8W0uRm0yQ0a4XtvAX0RKE4HATLejdYMK9ky
	Ek5z93qJRFs1DQNjXcMq53f0LloVExZ96+4ka20542kI9pQ4aNxISxzKqqk+G2yT
	TGwDdg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf05u77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8squc017229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:52 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 01:54:50 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 22 May 2025 16:54:14 +0800
Subject: [PATCH ath-next 5/6] wifi: ath12k: update link active in case two
 links fall on the same MAC
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250522-ath12k-sbs-dbs-v1-5-54a29e7a3a88@quicinc.com>
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
X-Proofpoint-GUID: 72XcT3waV5U8uoLXJK2ioIX5eIk0Dnf8
X-Proofpoint-ORIG-GUID: 72XcT3waV5U8uoLXJK2ioIX5eIk0Dnf8
X-Authority-Analysis: v=2.4 cv=ZP3XmW7b c=1 sm=1 tr=0 ts=682ee65d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=aC1lMeXp0nqnQfCt:21 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=COk6AnOGAAAA:8 a=-a1V2HCe8negCmoMgDMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfXzDY883X4I+MI
 fjYtS6lrIuRiKoZp/hHiG7MU8bVvTe9xuyLwF4o9ZlHYzcclYIiXFw+malgafizN2srqmLUklCI
 f8HbqvoYo6KRWGIfL7G528d/+TXX/pR1Bh2CC7akjwDlmRbosTSYBcLuvE6z3/2oze0c/ztcUZV
 Btw8+aAxwFwLLOggjRcupvIrH7gVAMLOIIM1TqReIPoW207L+FT+7gpJXK8+i64iEBXFC6necz6
 DXMboWqkbPci/Y6wd7pGlcU2CJWCLCkYmVJwY4kjMWKFopX2ghBsDTo/6aTsu1L36Sh7hhqqvup
 40vju//z4GTF4pNKUuhaxpNKdiSuJtNigp9hrfR4CykAx9DoDtK++85iWnEF6OWkmYncP7gBdFc
 rMbDVvWJBve8KfbcR5Te9YP+OhgEyjc1S+pXPlqLCpDUKUAFb1rhXz/rzhWcwtgJ5K6aWX/2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220089

In case of two links established on the same device in an ML connection,
depending on device's hardware mode capability, it is possible that both
links fall on the same MAC. Currently, no specific action is taken to
address this but just keep both links active. However this would result
in lower throughput compared to even one link, because switching between
these two links on the resulted MAC significantly impacts throughput.

Check if both links fall in the frequency range of a single MAC. If
so, send WMI_MLO_LINK_SET_ACTIVE_CMDID command to firmware such that
firmware can deactivate one of them. Note the decision of which link
getting deactivated is made by firmware, host only sends the vdev
lists.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 227 +++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h |   2 +
 2 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87af8b48cb3fafcd364fd9ced4ff197..2fae4b01ec9071cada749b337a65f8cf8b02b292 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5890,6 +5890,211 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static bool ath12k_mac_is_freq_on_mac(struct ath12k_hw_mode_freq_range_arg *freq_range,
+				      u32 freq, u8 mac_id)
+{
+	return (freq >= freq_range[mac_id].low_2ghz_freq &&
+		freq <= freq_range[mac_id].high_2ghz_freq) ||
+	       (freq >= freq_range[mac_id].low_5ghz_freq &&
+		freq <= freq_range[mac_id].high_5ghz_freq);
+}
+
+static bool
+ath12k_mac_2_freq_same_mac_in_freq_range(struct ath12k_base *ab,
+					 struct ath12k_hw_mode_freq_range_arg *freq_range,
+					 u32 freq_link1, u32 freq_link2)
+{
+	u8 i;
+
+	for (i = 0; i < MAX_RADIOS; i++) {
+		if (ath12k_mac_is_freq_on_mac(freq_range, freq_link1, i) &&
+		    ath12k_mac_is_freq_on_mac(freq_range, freq_link2, i))
+			return true;
+	}
+
+	return false;
+}
+
+static bool ath12k_mac_is_hw_dbs_capable(struct ath12k_base *ab)
+{
+	return test_bit(WMI_TLV_SERVICE_DUAL_BAND_SIMULTANEOUS_SUPPORT,
+			ab->wmi_ab.svc_map) &&
+	       ab->wmi_ab.hw_mode_info.support_dbs;
+}
+
+static bool ath12k_mac_2_freq_same_mac_in_dbs(struct ath12k_base *ab,
+					      u32 freq_link1, u32 freq_link2)
+{
+	struct ath12k_hw_mode_freq_range_arg *freq_range;
+
+	if (!ath12k_mac_is_hw_dbs_capable(ab))
+		return true;
+
+	freq_range = ab->wmi_ab.hw_mode_info.freq_range_caps[ATH12K_HW_MODE_DBS];
+	return ath12k_mac_2_freq_same_mac_in_freq_range(ab, freq_range,
+							freq_link1, freq_link2);
+}
+
+static bool ath12k_mac_is_hw_sbs_capable(struct ath12k_base *ab)
+{
+	return test_bit(WMI_TLV_SERVICE_DUAL_BAND_SIMULTANEOUS_SUPPORT,
+			ab->wmi_ab.svc_map) &&
+	       ab->wmi_ab.hw_mode_info.support_sbs;
+}
+
+static bool ath12k_mac_2_freq_same_mac_in_sbs(struct ath12k_base *ab,
+					      u32 freq_link1, u32 freq_link2)
+{
+	struct ath12k_hw_mode_info *info = &ab->wmi_ab.hw_mode_info;
+	struct ath12k_hw_mode_freq_range_arg *sbs_uppr_share;
+	struct ath12k_hw_mode_freq_range_arg *sbs_low_share;
+	struct ath12k_hw_mode_freq_range_arg *sbs_range;
+
+	if (!ath12k_mac_is_hw_sbs_capable(ab))
+		return true;
+
+	if (ab->wmi_ab.sbs_lower_band_end_freq) {
+		sbs_uppr_share = info->freq_range_caps[ATH12K_HW_MODE_SBS_UPPER_SHARE];
+		sbs_low_share = info->freq_range_caps[ATH12K_HW_MODE_SBS_LOWER_SHARE];
+
+		return ath12k_mac_2_freq_same_mac_in_freq_range(ab, sbs_low_share,
+								freq_link1, freq_link2) ||
+		       ath12k_mac_2_freq_same_mac_in_freq_range(ab, sbs_uppr_share,
+								freq_link1, freq_link2);
+	}
+
+	sbs_range = info->freq_range_caps[ATH12K_HW_MODE_SBS];
+	return ath12k_mac_2_freq_same_mac_in_freq_range(ab, sbs_range,
+							freq_link1, freq_link2);
+}
+
+static bool ath12k_mac_freqs_on_same_mac(struct ath12k_base *ab,
+					 u32 freq_link1, u32 freq_link2)
+{
+	return ath12k_mac_2_freq_same_mac_in_dbs(ab, freq_link1, freq_link2) &&
+	       ath12k_mac_2_freq_same_mac_in_sbs(ab, freq_link1, freq_link2);
+}
+
+static int ath12k_mac_mlo_sta_set_link_active(struct ath12k_base *ab,
+					      enum wmi_mlo_link_force_reason reason,
+					      enum wmi_mlo_link_force_mode mode,
+					      u8 *mlo_vdev_id_lst,
+					      u8 num_mlo_vdev,
+					      u8 *mlo_inactive_vdev_lst,
+					      u8 num_mlo_inactive_vdev)
+{
+	struct wmi_mlo_link_set_active_arg param = {0};
+	u32 entry_idx, entry_offset, vdev_idx;
+	u8 vdev_id;
+
+	param.reason = reason;
+	param.force_mode = mode;
+
+	for (vdev_idx = 0; vdev_idx < num_mlo_vdev; vdev_idx++) {
+		vdev_id = mlo_vdev_id_lst[vdev_idx];
+		entry_idx = vdev_id / 32;
+		entry_offset = vdev_id % 32;
+		if (entry_idx >= WMI_MLO_LINK_NUM_SZ) {
+			ath12k_warn(ab, "Invalid entry_idx %d num_mlo_vdev %d vdev %d",
+				    entry_idx, num_mlo_vdev, vdev_id);
+			return -EINVAL;
+		}
+		param.vdev_bitmap[entry_idx] |= 1 << entry_offset;
+		/* update entry number if entry index changed */
+		if (param.num_vdev_bitmap < entry_idx + 1)
+			param.num_vdev_bitmap = entry_idx + 1;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC,
+		   "num_vdev_bitmap %d vdev_bitmap[0] = 0x%x, vdev_bitmap[1] = 0x%x",
+		   param.num_vdev_bitmap, param.vdev_bitmap[0], param.vdev_bitmap[1]);
+
+	if (mode == WMI_MLO_LINK_FORCE_MODE_ACTIVE_INACTIVE) {
+		for (vdev_idx = 0; vdev_idx < num_mlo_inactive_vdev; vdev_idx++) {
+			vdev_id = mlo_inactive_vdev_lst[vdev_idx];
+			entry_idx = vdev_id / 32;
+			entry_offset = vdev_id % 32;
+			if (entry_idx >= WMI_MLO_LINK_NUM_SZ) {
+				ath12k_warn(ab, "Invalid entry_idx %d num_mlo_vdev %d vdev %d",
+					    entry_idx, num_mlo_inactive_vdev, vdev_id);
+				return -EINVAL;
+			}
+			param.inactive_vdev_bitmap[entry_idx] |= 1 << entry_offset;
+			/* update entry number if entry index changed */
+			if (param.num_inactive_vdev_bitmap < entry_idx + 1)
+				param.num_inactive_vdev_bitmap = entry_idx + 1;
+		}
+
+		ath12k_dbg(ab, ATH12K_DBG_MAC,
+			   "num_vdev_bitmap %d inactive_vdev_bitmap[0] = 0x%x, inactive_vdev_bitmap[1] = 0x%x",
+			   param.num_inactive_vdev_bitmap,
+			   param.inactive_vdev_bitmap[0],
+			   param.inactive_vdev_bitmap[1]);
+	}
+
+	if (mode == WMI_MLO_LINK_FORCE_MODE_ACTIVE_LINK_NUM ||
+	    mode == WMI_MLO_LINK_FORCE_MODE_INACTIVE_LINK_NUM) {
+		param.num_link_entry = 1;
+		param.link_num[0].num_of_link = num_mlo_vdev - 1;
+	}
+
+	return ath12k_wmi_send_mlo_link_set_active_cmd(ab, &param);
+}
+
+static int ath12k_mac_mlo_sta_update_link_active(struct ath12k_base *ab,
+						 struct ieee80211_hw *hw,
+						 struct ath12k_vif *ahvif)
+{
+	u8 mlo_vdev_id_lst[IEEE80211_MLD_MAX_NUM_LINKS] = {0};
+	u32 mlo_freq_list[IEEE80211_MLD_MAX_NUM_LINKS] = {0};
+	unsigned long links = ahvif->links_map;
+	enum wmi_mlo_link_force_reason reason;
+	struct ieee80211_chanctx_conf *conf;
+	enum wmi_mlo_link_force_mode mode;
+	struct ieee80211_bss_conf *info;
+	struct ath12k_link_vif *arvif;
+	u8 num_mlo_vdev = 0;
+	u8 link_id;
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		/* make sure vdev is created on this device */
+		if (!arvif || !arvif->is_created || arvif->ar->ab != ab)
+			continue;
+
+		info = ath12k_mac_get_link_bss_conf(arvif);
+		conf = wiphy_dereference(hw->wiphy, info->chanctx_conf);
+		mlo_freq_list[num_mlo_vdev] = conf->def.chan->center_freq;
+
+		mlo_vdev_id_lst[num_mlo_vdev] = arvif->vdev_id;
+		num_mlo_vdev++;
+	}
+
+	/* It is not allowed to activate more links than a single device
+	 * supported. Something goes wrong if we reach here.
+	 */
+	if (num_mlo_vdev > ATH12K_NUM_MAX_ACTIVE_LINKS_PER_DEVICE) {
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	/* if 2 links are established and both link channels fall on the
+	 * same hardware MAC, send command to firmware to deactivate one
+	 * of them.
+	 */
+	if (num_mlo_vdev == 2 &&
+	    ath12k_mac_freqs_on_same_mac(ab, mlo_freq_list[0],
+					 mlo_freq_list[1])) {
+		mode = WMI_MLO_LINK_FORCE_MODE_INACTIVE_LINK_NUM;
+		reason = WMI_MLO_LINK_FORCE_REASON_NEW_CONNECT;
+		return ath12k_mac_mlo_sta_set_link_active(ab, reason, mode,
+							  mlo_vdev_id_lst, num_mlo_vdev,
+							  NULL, 0);
+	}
+
+	return 0;
+}
+
 static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -5899,10 +6104,12 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k_base *prev_ab = NULL, *ab;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_link_sta *arsta;
 	unsigned long valid_links;
-	u8 link_id = 0;
+	u8 link_id = 0, i;
+	struct ath12k *ar;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -5997,6 +6204,24 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (ieee80211_vif_is_mld(vif) && vif->type == NL80211_IFTYPE_STATION &&
+	    old_state == IEEE80211_STA_ASSOC && new_state == IEEE80211_STA_AUTHORIZED) {
+		for_each_ar(ah, ar, i) {
+			ab = ar->ab;
+			if (prev_ab == ab)
+				continue;
+
+			ret = ath12k_mac_mlo_sta_update_link_active(ab, hw, ahvif);
+			if (ret) {
+				ath12k_warn(ab,
+					    "failed to update link active state on connect %d\n",
+					    ret);
+				goto exit;
+			}
+
+			prev_ab = ab;
+		}
+	}
 	/* IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST:
 	 * Remove the station from driver (handle ML sta here since that
 	 * needs special handling. Normal sta will be handled in generic
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index e6e74b45bfa426c92dcc7dafaeb032a8a1520b6e..cc81b1f5680f41c2ed59220e396e9e6b1c38d2c4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -54,6 +54,8 @@ struct ath12k_generic_iter {
 #define ATH12K_DEFAULT_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
 #define ATH12K_NUM_MAX_LINKS		(IEEE80211_MLD_MAX_NUM_LINKS + 1)
 
+#define ATH12K_NUM_MAX_ACTIVE_LINKS_PER_DEVICE	2
+
 enum ath12k_supported_bw {
 	ATH12K_BW_20    = 0,
 	ATH12K_BW_40    = 1,

-- 
2.25.1


