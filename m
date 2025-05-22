Return-Path: <linux-wireless+bounces-23281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B317AC07DF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CA217E05E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAF289376;
	Thu, 22 May 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kMCZWGwk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE66289805;
	Thu, 22 May 2025 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904103; cv=none; b=rieayA3leTe7DVJ2jRktwo0mYkN86r9gxGrE2YOxjO43qToxermxaMN+RUrSTApIfEsidtkuk9X0RiyxHZue0NI5s7kWKcXKGjMnl1JeC+YQ75iPh/FVrSVyT7BdHbTrer4xbYSeSfGoHGydzv/6NpEaGWELbfIXbsq5jMwHt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904103; c=relaxed/simple;
	bh=RmkmFcARMcuYC8m+DxwPLe8IiDbWT0O3bw28uIqZGK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c1iIpVOtIKtngaug7Mnrz1nCgdB17GNE7pp6epOc1YHXz/Qb7Lk7YEfrjApZxAHz5hQ397XbvyTvXG24V2l7isIcf3CuNhHIzPyQak8Ei82qHaLMqqFicp5ZRVt/zGPv8IHBnHyCErfA8Q5aI2P/ybZEZgTg95xIEDuHf0hhbv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kMCZWGwk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8o98p001723;
	Thu, 22 May 2025 08:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UAq+HuoZlwdEI4ILVEJ8SO/CUS526SeFFxZKEg/moko=; b=kMCZWGwk6+eEC+E9
	4mAM8QX0xX+QVJ0EjtYL2WMH07C2P7wQy3HdNUdJTbZFpT6vwF222C0MLnb3WvKQ
	fQMhZ0O2ebEgZvkMKTfpRoIg8BOGM5HdkGsi+dqOq2VJ+ThFGvv71ElGkStq8gKv
	/hMTpvfcANFSz8tYO2SgVbz4IZuQEdOyBKD0v+f5Wurj19rotSqDDTOi+Qkdyrgg
	jrZefAGmsiws/JGjU3tiZKQ1Oo8PTGLTaMoQUeFGnTaGnnXXotb0uKj92pcghWhM
	TQE6w4uRDYCLVg7ztBmS3H3DGoeMD6qaCFgd26z9PZtqS+MwuGIEXfRfDxmCYf4J
	3wZpIQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6wn77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8sski017271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:54 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 01:54:52 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 22 May 2025 16:54:15 +0800
Subject: [PATCH ath-next 6/6] wifi: ath12k: don't activate more links than
 firmware supports
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250522-ath12k-sbs-dbs-v1-6-54a29e7a3a88@quicinc.com>
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
X-Proofpoint-GUID: zvs_HzglwP581LvMpKCaT3uDK_1fJ7iz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfX9n5JD5eHEViA
 LUPV6jw4GQFkINNwORnBJo1B21nDLFK+MoJ6PyGhg3zrfm84tX7D9fwhqpEutM8k0wMCaesBp9+
 YuoR6YkA/6ksAF/K1AuO7iJr1UA9psDMhTYJ7+0NvJ8EHtKIiQMLvmPDK455gRpSPmx9JM46IHA
 v/f9vtY1LtZAKNE6WilEkKHfdnBbHo1ansVraa2Ru+iYLXZSicVXv21zPGmqPAen/28PFBvjjhV
 ABQ0vPLCAKlQO4E8YWQRJwnXGq6kd4S6FuQrATI7FQmsJvTKW4ofKz0GaP6M2wOC6Hpcp52yjaZ
 sfFcQqYlC6UkXG3JtDj5YUBNjOBrb1Chl05jssr70w9YNrc2NPxRGPywFBxlnqeS2X2hQaOMywR
 VOwhXBi7XHf2hRRoVB7Wb7kjP03YIxHEMRBkaxBFWPNSmkJjVkyeqOWq+qNFzWi0f0RLXi8q
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682ee65f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=jD5Ay6PlD5Khrx5U1CEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zvs_HzglwP581LvMpKCaT3uDK_1fJ7iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220089

In case of ML connection, currently all useful links are activated at
ASSOC stage:

        ieee80211_set_active_links(vif, ieee80211_vif_usable_links(vif))

this results in firmware crash when the number of links activated on the
same device is more than supported.

Since firmware supports activating at most 2 links for a ML connection,
to avoid firmware crash, host needs to select 2 links out of the useful
links. As the assoc link has already been chosen, the question becomes
how to determine partner links. A straightforward principle applied
here is that the resulted combination should achieve the best throughput.
For that purpose, ideally various factors like bandwidth, RSSI etc should
be considered. But that would be too complicate. To make it easy, the
choice is to only take hardware modes into consideration.

The SBS (single band simultaneously) mode frequency range covers 5 GHz
and 6 GHz bands. In this mode, the two individual MACs are both active,
with one working on 5g-high band and the other on 5g-low band (from
hardware perspective 5 GHz and 6 GHz bands are referred to as a 'large'
single 5 GHz band). The DBS (dual band simultaneously) mode covers 2 GHz
band and the 'large' 5 GHz band, with one MAC working on 2 GHz band and
the other working on 5 GHz band or 6 GHz band. Since 5,6 GHz bands could
provide higher bandwidth than 2 GHz band, the preference is given to SBS
mode. Other hardware modes results in only one working MAC at any given
time, so it is chosen only when both SBS are DBS are not possible.

For each hardware mode, if there are more than one partner candidate,
just choose the first one.

For now only single device MLO case is handled as it is easy. Other cases
could be addressed in the future.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   6 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 137 ++++++++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 941db6e49d6eaeb03783f7714d433259d887820b..efbd6e8ce275eaaa8c7bba7db7ae4674f9c2259a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -601,6 +601,12 @@ struct ath12k_sta {
 #define ATH12K_NUM_CHANS 101
 #define ATH12K_MAX_5GHZ_CHAN 173
 
+static inline bool ath12k_is_2ghz_channel_freq(u32 freq)
+{
+	return freq >= ATH12K_MIN_2GHZ_FREQ &&
+	       freq <= ATH12K_MAX_2GHZ_FREQ;
+}
+
 enum ath12k_hw_state {
 	ATH12K_HW_STATE_OFF,
 	ATH12K_HW_STATE_ON,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2fae4b01ec9071cada749b337a65f8cf8b02b292..b5b31cd8de99dfb0e477dc4805c719a22cbae4b7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6095,6 +6095,122 @@ static int ath12k_mac_mlo_sta_update_link_active(struct ath12k_base *ab,
 	return 0;
 }
 
+static bool ath12k_mac_are_sbs_chan(struct ath12k_base *ab, u32 freq_1, u32 freq_2)
+{
+	if (!ath12k_mac_is_hw_sbs_capable(ab))
+		return false;
+
+	if (ath12k_is_2ghz_channel_freq(freq_1) ||
+	    ath12k_is_2ghz_channel_freq(freq_2))
+		return false;
+
+	return !ath12k_mac_2_freq_same_mac_in_sbs(ab, freq_1, freq_2);
+}
+
+static bool ath12k_mac_are_dbs_chan(struct ath12k_base *ab, u32 freq_1, u32 freq_2)
+{
+	if (!ath12k_mac_is_hw_dbs_capable(ab))
+		return false;
+
+	return !ath12k_mac_2_freq_same_mac_in_dbs(ab, freq_1, freq_2);
+}
+
+static int ath12k_mac_select_links(struct ath12k_base *ab,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_hw *hw,
+				   u16 *selected_links)
+{
+	unsigned long useful_links = ieee80211_vif_usable_links(vif);
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	u8 num_useful_links = hweight_long(useful_links);
+	struct ieee80211_chanctx_conf *chanctx;
+	struct ath12k_link_vif *assoc_arvif;
+	u32 assoc_link_freq, partner_freq;
+	u16 sbs_links = 0, dbs_links = 0;
+	struct ieee80211_bss_conf *info;
+	struct ieee80211_channel *chan;
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *ahsta;
+	u8 link_id;
+
+	/* activate all useful links if less than max supported */
+	if (num_useful_links <= ATH12K_NUM_MAX_ACTIVE_LINKS_PER_DEVICE) {
+		*selected_links = useful_links;
+		return 0;
+	}
+
+	/* only in station mode we can get here, so it's safe
+	 * to use ap_addr
+	 */
+	rcu_read_lock();
+	sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
+	if (!sta) {
+		rcu_read_unlock();
+		ath12k_warn(ab, "failed to find sta with addr %pM\n", vif->cfg.ap_addr);
+		return -EINVAL;
+	}
+
+	ahsta = ath12k_sta_to_ahsta(sta);
+	assoc_arvif = wiphy_dereference(hw->wiphy, ahvif->link[ahsta->assoc_link_id]);
+	info = ath12k_mac_get_link_bss_conf(assoc_arvif);
+	chanctx = rcu_dereference(info->chanctx_conf);
+	assoc_link_freq = chanctx->def.chan->center_freq;
+	rcu_read_unlock();
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "assoc link %u freq %u\n",
+		   assoc_arvif->link_id, assoc_link_freq);
+
+	/* assoc link is already activated and has to be kept active,
+	 * only need to select a partner link from others.
+	 */
+	useful_links &= ~BIT(assoc_arvif->link_id);
+	for_each_set_bit(link_id, &useful_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		info = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
+		if (!info) {
+			ath12k_warn(ab, "failed to get link info for link: %u\n",
+				    link_id);
+			return -ENOLINK;
+		}
+
+		chan = info->chanreq.oper.chan;
+		if (!chan) {
+			ath12k_warn(ab, "failed to get chan for link: %u\n", link_id);
+			return -EINVAL;
+		}
+
+		partner_freq = chan->center_freq;
+		if (ath12k_mac_are_sbs_chan(ab, assoc_link_freq, partner_freq)) {
+			sbs_links |= BIT(link_id);
+			ath12k_dbg(ab, ATH12K_DBG_MAC, "new SBS link %u freq %u\n",
+				   link_id, partner_freq);
+			continue;
+		}
+
+		if (ath12k_mac_are_dbs_chan(ab, assoc_link_freq, partner_freq)) {
+			dbs_links |= BIT(link_id);
+			ath12k_dbg(ab, ATH12K_DBG_MAC, "new DBS link %u freq %u\n",
+				   link_id, partner_freq);
+			continue;
+		}
+
+		ath12k_dbg(ab, ATH12K_DBG_MAC, "non DBS/SBS link %u freq %u\n",
+			   link_id, partner_freq);
+	}
+
+	/* choose the first candidate no matter how many is in the list */
+	if (sbs_links)
+		link_id = __ffs(sbs_links);
+	else if (dbs_links)
+		link_id = __ffs(dbs_links);
+	else
+		link_id = ffs(useful_links) - 1;
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "select partner link %u\n", link_id);
+
+	*selected_links = BIT(assoc_arvif->link_id) | BIT(link_id);
+
+	return 0;
+}
+
 static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -6108,6 +6224,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	struct ath12k_link_vif *arvif;
 	struct ath12k_link_sta *arsta;
 	unsigned long valid_links;
+	u16 selected_links = 0;
 	u8 link_id = 0, i;
 	struct ath12k *ar;
 	int ret;
@@ -6179,8 +6296,24 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	 * about to move to the associated state.
 	 */
 	if (ieee80211_vif_is_mld(vif) && vif->type == NL80211_IFTYPE_STATION &&
-	    old_state == IEEE80211_STA_AUTH && new_state == IEEE80211_STA_ASSOC)
-		ieee80211_set_active_links(vif, ieee80211_vif_usable_links(vif));
+	    old_state == IEEE80211_STA_AUTH && new_state == IEEE80211_STA_ASSOC) {
+		/* TODO: for now only do link selection for single device
+		 * MLO case. Other cases would be handled in the future.
+		 */
+		ab = ah->radio[0].ab;
+		if (ab->ag->num_devices == 1) {
+			ret = ath12k_mac_select_links(ab, vif, hw, &selected_links);
+			if (ret) {
+				ath12k_warn(ab,
+					    "failed to get selected links: %d\n", ret);
+				goto exit;
+			}
+		} else {
+			selected_links = ieee80211_vif_usable_links(vif);
+		}
+
+		ieee80211_set_active_links(vif, selected_links);
+	}
 
 	/* Handle all the other state transitions in generic way */
 	valid_links = ahsta->links_map;

-- 
2.25.1


