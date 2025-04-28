Return-Path: <linux-wireless+bounces-22145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B8A9F445
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5623AFCEB
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF711D63C0;
	Mon, 28 Apr 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HH6WtjfK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907626C39E
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853599; cv=none; b=VAsvZIQwg8alSxjoW92co28rzbZN/AWxndCUY7LOyGz84T5LvE94GVBH930CXvj08ZMxeFzlDia4lyVqdB3PgLeFrf6wvh5I8CB5taHI6KbXi4/k4jY8Dcm+VjzbOFvjza05zohXBUmHyt7GQMcb2gU6YcUl2OyTeqkf3k91Gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853599; c=relaxed/simple;
	bh=bJ+0a7T//qsP5vso+QXJAjdBS+iqYELUH46VflvgzgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCjE1sAOlNUIQTRFgUK3aNqSk8r1nW2urqgeMPFQe3CSSeNMrS/w0OOJp81/HAy9E7QOXkbEGclnD7U/XuiZBq0wm69fQchBsxbqgA/mMGr/t6Z6qI/nPv9QXzlC2WxFTea+XTbi5N16yc71wPlGc88fCah81ssM1RduB7fnIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HH6WtjfK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S99Y50021850
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lnJ2hYZEY+C
	9abKGNANThMZDQlSXnCbi/4KX5tD/DtI=; b=HH6WtjfKzL1JFT25e+7XfatlVLx
	1Com5e3hZW5AVWk1Oh8rADPH2+4o79YivnLVzqIskjLAcLuh+8I+OP9bNHeVgVim
	rBnp+BB0WtBPGEStXQhGwp8xuhGagYHvIKVDZimAKAw0VDdDhI9FtG2U4vWV0NvT
	rY9HNKZ+f9l6EOpaDk+YOwGSB3DIsr6rKb7Qf121F2HrQ9d6lFFk+NFuOckm6P2D
	5MRmLOnX6OrzXCoWcLC8A1kj64fRXcgyrO7l0grAXp7R6PTKph82hfBHeuy3xxDI
	hAOoUhlq4MI+ChuMEoQ+DXPg9csxyKdavCSNOmDDdr5Fx2+u8qtzRsluPcQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468r8hrh9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 15:19:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b15e08f1eb4so2737136a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 08:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745853596; x=1746458396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnJ2hYZEY+C9abKGNANThMZDQlSXnCbi/4KX5tD/DtI=;
        b=e6RfRMkrR4RP1n3/cZOwSx/DuC7rt9AWks84izBB0fKSr5FHH5TWPV1VOiT4h9n2kl
         GKWDWcet02rQsB281Sz5SBL8RN2KbL+j8gOJsnZ+Je4iECblsYgS7HKoD4pXGzf2r+Eb
         m8fZyF4MrLh1fsdk56dZDDEgIrd7J5TR050Go0C+arY51J8m1q95rpPA8qQbF/K4CISj
         PKrz0t4xGOS5QHWHDaJSh/0Oapaq9OG0noOgQWgvtfuTAqLyWVrayDk5rpLyH6yeMLPp
         rBTyGpHZ/7Dt5i/6UvlGoryzRmu+XDKwps4n81CEjgHPWF16McIeAfkQOCWscZH4IxxZ
         0zuQ==
X-Gm-Message-State: AOJu0Ywcx4y9eHGF3xqwkf/8L9fMVMhez3+3VkznfOrQ2NeASMVUopg6
	D97USZFNHUrh2KVSlwuvNtwB3Xr1bHKwz0A1wxERJSIm+a6KBoyuezLavw7D1aq28cI17rEn+/C
	qXCwRMbEDpeppyvXy7BMrhN/fvTaJ+L3OcfwhG0X8+dW/B1mQYX4e5VN54H8avQWmYA==
X-Gm-Gg: ASbGncvJ2MsUw3V5j+fW6DlVJ7/YhuKLRdw9wQwSsLKXf26k8V7/7F+MuUAJYWKWKoz
	PBkC4Gi3BeWLq11ianWmM/m22MhzbpyzyWnHtrONx38kwgBGTs3pfWAX/YdS7pmj8BnZcvgZ+nJ
	GoHXivraFdHpp+nTQW2SPZ3ovk4Rjng2Y9/jDBzqQonx1yVsgfP63wa/dfzP4HS0qXOeGSCt4Xb
	meSZcqjMUdjkMEJkebnfJy0mBxYo88+cjNOPwEmS7pAVqk6z74LcE9QqrkbYohFxQwIwbwmCexr
	e4br/oqbwh/rHE+Xa+micJwwQWRtV/MhhGLRmCyhhKFvlAhjiVZuWMLq9ktAaZ94YsRjYdvkMtl
	VYWp6Wkb+aszOyRVM8gxL+EsfR/L/QtHtepPlJSRH
X-Received: by 2002:a17:903:3bcb:b0:215:bc30:c952 with SMTP id d9443c01a7336-22dbf4dc1d0mr155375245ad.6.1745853595748;
        Mon, 28 Apr 2025 08:19:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB5eA/ZTNxYCtM//3uhLUuvf4IIw2MP2Ze0TgoYN5D26Y2lavI+mPf4C+8z+8FDqNYszRWRQ==
X-Received: by 2002:a17:903:3bcb:b0:215:bc30:c952 with SMTP id d9443c01a7336-22dbf4dc1d0mr155374905ad.6.1745853595270;
        Mon, 28 Apr 2025 08:19:55 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c13sm84134515ad.162.2025.04.28.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:19:54 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Vignesh C <quic_vignc@quicinc.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: Split scan request for split band device
Date: Mon, 28 Apr 2025 20:49:27 +0530
Message-Id: <20250428151927.1169783-3-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250428151927.1169783-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hjwkd9G0y08o32juPN3KelgcrpopoZRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNSBTYWx0ZWRfX2HbL2EvTUKz1 AvAd8MdOJqWoIs88aDc0v2DccgSEYH4g2mvneHNi5TLkOn+Ul2/KBv6Tv9JU/202leXXiti6s3A HpaHuLgKPw+u/geer+8FGu2UazWwxfw3DhwF/sD3NuW4RslAd8mXnih/R1Qd3rC9X8UzDfreDDu
 3gqKtZiuErTTaj34Ar9yTAGSxavzv0xRzcedVXSGbROQUfkpOQKeU8z+aJTulzN8siRvSCGb6NL VQW+8Jj3DFOkX4/TNk3psn2BJ0p8xXn39Ms6KSnXXW+884vUD8grTkxrgyR+e7dgA+cQcFV3gir t47tKZnm4SJOLeBHQmInriM4HUQGtYFW3CxATWxJr9jSI2nM3tCFswy3jLU9Ilbtnz9kthMt8Nb
 t+Dae4icGil58z8kThM56MkaWyPvOb2yQdUy08npV5JMcP0NdB/LZGnB8vYTF574m4iQIV3D
X-Authority-Analysis: v=2.4 cv=cfzSrmDM c=1 sm=1 tr=0 ts=680f9c9c cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=BBq-wa7h3OHIyVUFt-wA:9 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hjwkd9G0y08o32juPN3KelgcrpopoZRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280125

When two split-phy devices having supported frequency range in same band
(as mentioned below) are combined into an ath12k HW group, they will be
part of same wiphy and hence the channel list (wiphy->bands[]) will be
common for all of the radios (ar).

1 - 2.4 GHz + 5 GHz Low band
2 - 5 GHz High band + 6 GHz

When a scan is triggered with frequency list containing frequencies of
both  5 GHz low and 5 GHz high, mac80211 generates a single scan request
to driver with both the frequencies. This is because mac80211 splits the
scan request based on band.

ath12k checks the first frequency in the requested scan frequency list and
initiates scan to corresponding radio's(ar) firmware with all the
frequencies. Firmware rejects this scan as some frequencies in the scan
request are not supported, resulting is scan failure.

Fix this by splitting the scan request into multiples scans in driver
based on the supported frequency range of different radios in a band and
schedule scans in parallel to them.
Finally send scan completion/abort notification to mac80211 after all the
radios complete their scheduled scan.

Also, last_scan_link is not needed anymore as ath12k internally schedules
multiple scans, remove the same and use ahvif->links_map to identify
scan links when scan is cancelled.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Co-developed-by: Vignesh C <quic_vignc@quicinc.com>
Signed-off-by: Vignesh C <quic_vignc@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   2 -
 drivers/net/wireless/ath/ath12k/mac.c  | 148 ++++++++++++++++++++-----
 2 files changed, 118 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0d512818ee96..c8fd0b29aaa1 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -353,8 +353,6 @@ struct ath12k_vif {
 	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link vif created in FW */
 	u32 links_map;
-	u8 last_scan_link;
-
 	/* Must be last - ends in a flexible-array member.
 	 *
 	 * FIXME: Driver should not copy struct ieee80211_chanctx_conf,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6dab2f3a9e0d..236e3ee22d4d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4249,6 +4249,23 @@ static void ath12k_scan_timeout_work(struct work_struct *work)
 	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 }
 
+static void ath12k_mac_scan_send_complete(struct ath12k *ar,
+					  struct cfg80211_scan_info *info)
+{
+	struct ath12k_hw *ah = ar->ah;
+	struct ath12k *partner_ar;
+	int i;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	for_each_ar(ah, partner_ar, i)
+		if (partner_ar != ar &&
+		    partner_ar->scan.state == ATH12K_SCAN_RUNNING)
+			return;
+
+	ieee80211_scan_completed(ah->hw, info);
+}
+
 static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ath12k *ar = container_of(work, struct ath12k,
@@ -4287,7 +4304,7 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
 				    ATH12K_SCAN_STARTING)),
 		};
 
-		ieee80211_scan_completed(ar->ah->hw, &info);
+		ath12k_mac_scan_send_complete(ar, &info);
 	}
 
 	ar->scan.state = ATH12K_SCAN_IDLE;
@@ -4506,12 +4523,14 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
 	return ATH12K_FIRST_SCAN_LINK;
 }
 
-static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_scan_request *hw_req)
+static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_scan_request *hw_req,
+				       int n_channels,
+				       struct ieee80211_channel **chan_list,
+				       struct ath12k *ar)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
 	struct cfg80211_scan_request *req = &hw_req->req;
@@ -4525,13 +4544,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	arvif = &ahvif->deflink;
 
-	/* Since the targeted scan device could depend on the frequency
-	 * requested in the hw_req, select the corresponding radio
-	 */
-	ar = ath12k_mac_select_scan_device(hw, vif, hw_req->req.channels[0]->center_freq);
-	if (!ar)
-		return -EINVAL;
-
 	/* check if any of the links of ML VIF is already started on
 	 * radio(ar) corresponding to given scan frequency and use it,
 	 * if not use scan link (link id >= 15) for scan purpose.
@@ -4634,8 +4646,8 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		arg->scan_f_passive = 1;
 	}
 
-	if (req->n_channels) {
-		arg->num_chan = req->n_channels;
+	if (n_channels) {
+		arg->num_chan = n_channels;
 		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
 					 GFP_KERNEL);
 		if (!arg->chan_list) {
@@ -4644,7 +4656,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		}
 
 		for (i = 0; i < arg->num_chan; i++)
-			arg->chan_list[i] = req->channels[i]->center_freq;
+			arg->chan_list[i] = chan_list[i]->center_freq;
 	}
 
 	ret = ath12k_start_scan(ar, arg);
@@ -4662,13 +4674,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac scan started");
 
-	/* As per cfg80211/mac80211 scan design, it allows only one
-	 * scan at a time. Hence last_scan link id is used for
-	 * tracking the link id on which the scan is been done on
-	 * this vif.
-	 */
-	ahvif->last_scan_link = arvif->link_id;
-
 	/* Add a margin to account for event/command processing */
 	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
 				     msecs_to_jiffies(arg->max_scan_time +
@@ -4689,25 +4694,108 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_scan_request *hw_req)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ieee80211_channel **chan_list, *chan;
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	unsigned long links_map, link_id;
+	struct ath12k_link_vif *arvif;
+	struct ath12k *ar, *scan_ar;
+	int i, j, ret = 0;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	chan_list = kcalloc(hw_req->req.n_channels, sizeof(*chan_list), GFP_KERNEL);
+	if (!chan_list)
+		return -ENOMEM;
+
+	/* There could be channels that belong to multiple underlying radio
+	 * in same scan request as mac80211 sees it as single band. In that
+	 * case split the hw_req based on frequency range and schedule scans to
+	 * corresponding radio.
+	 */
+	for_each_ar(ah, ar, i) {
+		int n_chans = 0;
+
+		for (j = 0; j < hw_req->req.n_channels; j++) {
+			chan = hw_req->req.channels[j];
+			scan_ar = ath12k_mac_select_scan_device(hw, vif,
+								chan->center_freq);
+			if (!scan_ar) {
+				ath12k_hw_warn(ah, "unable to select scan device for freq %d\n",
+					       chan->center_freq);
+				ret = -EINVAL;
+				goto abort;
+			}
+			if (ar != scan_ar)
+				continue;
+
+			chan_list[n_chans++] = chan;
+		}
+		if (n_chans) {
+			ret = ath12k_mac_initiate_hw_scan(hw, vif, hw_req, n_chans,
+							  chan_list, ar);
+			if (ret)
+				goto abort;
+		}
+	}
+abort:
+	/* If any of the parallel scans initiated fails, abort all and
+	 * remove the scan interfaces created. Return complete scan
+	 * failure as mac80211 assumes this as single scan request.
+	 */
+	if (ret) {
+		ath12k_hw_warn(ah, "Scan failed %d , cleanup all scan vdevs\n", ret);
+		links_map = ahvif->links_map;
+		for_each_set_bit(link_id, &links_map, ATH12K_NUM_MAX_LINKS) {
+			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+			if (!arvif)
+				continue;
+
+			ar = arvif->ar;
+			if (ar->scan.arvif == arvif) {
+				wiphy_work_cancel(hw->wiphy, &ar->scan.vdev_clean_wk);
+				spin_lock_bh(&ar->data_lock);
+				ar->scan.arvif = NULL;
+				ar->scan.state = ATH12K_SCAN_IDLE;
+				ar->scan_channel = NULL;
+				ar->scan.roc_freq = 0;
+				spin_unlock_bh(&ar->data_lock);
+			}
+			if (link_id >= ATH12K_FIRST_SCAN_LINK) {
+				ath12k_mac_remove_link_interface(hw, arvif);
+				ath12k_mac_unassign_link_vif(arvif);
+			}
+		}
+	}
+	kfree(chan_list);
+	return ret;
+}
+
 static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	u16 link_id = ahvif->last_scan_link;
+	unsigned long link_id, links_map = ahvif->links_map;
 	struct ath12k_link_vif *arvif;
 	struct ath12k *ar;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-	if (!arvif || arvif->is_started)
-		return;
+	for_each_set_bit(link_id, &links_map, ATH12K_NUM_MAX_LINKS) {
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		if (!arvif || arvif->is_started)
+			continue;
 
-	ar = arvif->ar;
+		ar = arvif->ar;
 
-	ath12k_scan_abort(ar);
+		ath12k_scan_abort(ar);
 
-	cancel_delayed_work_sync(&ar->scan.timeout);
+		cancel_delayed_work_sync(&ar->scan.timeout);
+	}
 }
 
 static int ath12k_install_key(struct ath12k_link_vif *arvif,
@@ -8917,7 +9005,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 					.aborted = true,
 				};
 
-				ieee80211_scan_completed(ar->ah->hw, &info);
+				ath12k_mac_scan_send_complete(ar, &info);
 			}
 
 			ar->scan.state = ATH12K_SCAN_IDLE;
-- 
2.34.1


