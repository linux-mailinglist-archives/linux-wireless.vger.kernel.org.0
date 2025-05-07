Return-Path: <linux-wireless+bounces-22721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16AAAEC71
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 21:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2A71C06032
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 19:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5228E5F1;
	Wed,  7 May 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BVAmXWbq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDA28E5FF
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647342; cv=none; b=NePVL6Wb8t7Yh7teBgJSiIx/U3FG6xCRWPHPS9Z8w0z2K9Hz1oOwQKfHLIowPo1rXMDKdEyhSSuApn7LlY+UcnZ55jhPCe8np+3Phm8xXnCPIGhumnBW1EdCn999foLnD21fdCkqyJPmREkuAl2ymocUzemCAAa4vCWDgAWY7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647342; c=relaxed/simple;
	bh=mqKb6vXZ/d0JGmPPWpfjzb6vfzyZ7XCtOrw1UXfDShw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMwBwcGCN89Rq7vwRdjrgZerGr0teSA7ahwz7mDxdFoHCtbjikCSOdeywsdu6rCyowf9Zits8msYZHzFOOCIQ36Yhur/eog+AL8SbDu3UvHV4aNFkm2OIJN7Lo1C2Kb7KzS0EPfLYVtbBn5fvAcHN0s7RuREPj0RkET0rMv0NK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BVAmXWbq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547D8T4u014546
	for <linux-wireless@vger.kernel.org>; Wed, 7 May 2025 19:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aajyCbehm0M
	wKmyxwGdAZ66JyvVeNNg/vMHTnIceKTs=; b=BVAmXWbqoW532gQDn4L+Qs3ZJM2
	xIAoLE16LwBsmcWwsoV4xopBKY96FmfE+YOddxgTGL74nV4/fr0Z20C6hh2wAE6R
	QJFrRM9xiOs/+t76Wsu3QrhBPCFYV+oOe3vn9njAxUhMIOcpbeoi87Sm6Q1J57nL
	9S//rrhiTtBR+D0od3vaaX+DTnfeMq93h7x36egvIv2dJ0gCPkBuHOrPkMvLR6sI
	3dY3RHv1HtCEBgwppruJrhAjO76lY+pws21dY0rmFOSZrrhhgVa8LwAnNu3sy+hC
	XsRBO5y7QtxPRZ59OlQE595irYVkqNrvZSo3GS1Q0OvduVF3XV5QAt7BYvw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46g0kh2gpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 19:48:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7394772635dso200111b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 12:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746647338; x=1747252138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aajyCbehm0MwKmyxwGdAZ66JyvVeNNg/vMHTnIceKTs=;
        b=P3A9nUle0aPmSj3en61RM329thwSKbgNtLAPvI+u/xNyin0hWwiBdqpIB2LHC+O8mN
         IyBt2AVdlHXxCx9dJ0d710mDzoAyv44g/kPjMxD9nJOAC2To5ANuI/2coM544BtjvZ9k
         ZJhd9i1rX1lOJIs2b9AtXEQ4OAVMPyHWp1yXm6jml1Itz6V3fF/4B/nEitIwG+OpZk7B
         sYgLDn2/NJaJpFOa+jdqTTObFwKlsGYLQYAPWLhiTxF4XPZ2ZxcrOyZ5ii/c2U4pP5SK
         Q4E2DlNxVq7/Uh038GrbnXfyIWoyZ75z1Ip4gevC5r368oRUWeikYbYyAtCcx5HP60Ur
         /ZFw==
X-Gm-Message-State: AOJu0Yw+B8nVWRSKeAZHG+1Skj8A96xKEejjXBjZanohkwli70oWjrav
	iAmYiWB2NtqYmsFFvQ9B3PA1NPHDbcz/ze9NSGK4vV9pNRad6+iWdYM5izefDi66pKloeqiu3wW
	1eOwkd0kHPPs25dptXiTXguEW54hP5AQiqvsjCaXPGfTXM44SohBbAr6jFKkg+ecIWA==
X-Gm-Gg: ASbGncsuV7aaCHNJc8m/x0fG6b0h+W3ZzU27H8nzJif6pqKTiJ8O6dLdZoXnwdjGKMH
	TO3S6cCPMOiF7+ASG/y4XohuEzB4tfKVQVSbxviMdF4ZfqZkue6lBvi3TRtqPr5JzDNyXeQmGuj
	jsPK9NxnF3S2k5/NUlsEJk9LwVKgLYXKlUoNmSd7LTDeXncU/r9RAEmONPlWndocuLhHIaVUl3S
	VCa5BETuN15uEhNzxhiDe0Gt/KKrKlP5aDTdKkZ6ZUhjoDG79/MgB1Zo+bkpul/mEywFoFcT0nL
	//Sw0Av8TerbheJiXIbyhY6DBy60wL0eJVgSbFnDfhVP1BrEnr0+xb4kRluFwi1lBLTXtrsPJg2
	+sW5MBkiy3c8WygNW91UQRJJFXDNQWNhmIRNezb88
X-Received: by 2002:a05:6a20:9f8e:b0:1f5:8e94:2e81 with SMTP id adf61e73a8af0-2148b0189e3mr6439145637.9.1746647337733;
        Wed, 07 May 2025 12:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4TYuk97KTtTsyO/NrO0CTbCTThvoFpjlTpol8SdKog7Ft5aya/JjpPjX6sexqYyYk4Jd4NQ==
X-Received: by 2002:a05:6a20:9f8e:b0:1f5:8e94:2e81 with SMTP id adf61e73a8af0-2148b0189e3mr6439104637.9.1746647337170;
        Wed, 07 May 2025 12:48:57 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3920074sm9972704a12.11.2025.05.07.12.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:48:56 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Vignesh C <quic_vignc@quicinc.com>,
        Mahendran P <quic_mahep@quicinc.com>
Subject: [PATCH ath-pending v2 2/2] wifi: ath12k: Split scan request for split band device
Date: Thu,  8 May 2025 01:18:32 +0530
Message-Id: <20250507194832.2501668-3-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507194832.2501668-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250507194832.2501668-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE4MSBTYWx0ZWRfXx1/62cN3qub2
 EiYH0Ct6qjL/Frz4fJeALr+5mMS32HeLttIFpvqwFzgUMAad1UK0aOlU7n+cEGSJN7KPQuaguOI
 l2uT4SDdXJ+7DJWIQ01+gfH2RlP79y4X4TpCanV1i717HGtKAefv7J2ejk9DoJfRAafpYrnqNYa
 aaOttA/6WnYjn/zPO5mrAmHgEwhAVfekBkRPb4xGsXqqib1L3FMKbzGu1AIdW0VGvzE4enRQaFc
 Zpm/BuKhcxXFaaJKz4zzrf7npyV1h4081359ZpWBkwL9+mTtJUDrJKkOmSsENiUvjbdujZDnvKc
 W51eJlarZkpruqoqV3ZLZF1XNZHwu/8I8De9W+R6tSfNkRCgClBFc5zX7ytwBz6Y2ZZwG2oyl/B
 MX3lL95pMWqIk/RoQxNwKYfTjpVeCPGtLxe8D4ngK26g90FxVe6lIrg7u/ae43GU0mAK3NDZ
X-Authority-Analysis: v=2.4 cv=PNUP+eqC c=1 sm=1 tr=0 ts=681bb92b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=BBq-wa7h3OHIyVUFt-wA:9
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: l8pGc-XNQsoTgDnUvmLD-CWZgvqL8ceO
X-Proofpoint-GUID: l8pGc-XNQsoTgDnUvmLD-CWZgvqL8ceO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070181

When two split-phy devices having supported frequency range in same band
(as mentioned below) are combined into an ath12k HW group, they will be
part of same wiphy and hence the channel list (wiphy->bands[]) will be
common for all of the radios (ar).

1 - 2.4 GHz + 5 GHz Low band
2 - 5 GHz High band + 6 GHz

When a scan is triggered with frequency list containing frequencies of
both 5 GHz low and 5 GHz high, mac80211 generates a single scan request
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
Reviewed-by: Mahendran P <quic_mahep@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   2 -
 drivers/net/wireless/ath/ath12k/mac.c  | 148 ++++++++++++++++++++-----
 2 files changed, 118 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 570bbe4aecd5..0e69811627da 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -381,8 +381,6 @@ struct ath12k_vif {
 	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link vif created in FW */
 	u32 links_map;
-	u8 last_scan_link;
-
 	/* Must be last - ends in a flexible-array member.
 	 *
 	 * FIXME: Driver should not copy struct ieee80211_chanctx_conf,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b80ae1476f5e..562f8b170a1a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4683,6 +4683,23 @@ static void ath12k_scan_timeout_work(struct work_struct *work)
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
@@ -4721,7 +4738,7 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
 				    ATH12K_SCAN_STARTING)),
 		};
 
-		ieee80211_scan_completed(ar->ah->hw, &info);
+		ath12k_mac_scan_send_complete(ar, &info);
 	}
 
 	ar->scan.state = ATH12K_SCAN_IDLE;
@@ -4940,12 +4957,14 @@ ath12k_mac_find_link_id_by_ar(struct ath12k_vif *ahvif, struct ath12k *ar)
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
@@ -4959,13 +4978,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
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
@@ -5068,8 +5080,8 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		arg->scan_f_passive = 1;
 	}
 
-	if (req->n_channels) {
-		arg->num_chan = req->n_channels;
+	if (n_channels) {
+		arg->num_chan = n_channels;
 		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
 					 GFP_KERNEL);
 		if (!arg->chan_list) {
@@ -5078,7 +5090,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		}
 
 		for (i = 0; i < arg->num_chan; i++)
-			arg->chan_list[i] = req->channels[i]->center_freq;
+			arg->chan_list[i] = chan_list[i]->center_freq;
 	}
 
 	ret = ath12k_start_scan(ar, arg);
@@ -5096,13 +5108,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
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
@@ -5123,25 +5128,108 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
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
@@ -9465,7 +9553,7 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 					.aborted = true,
 				};
 
-				ieee80211_scan_completed(ar->ah->hw, &info);
+				ath12k_mac_scan_send_complete(ar, &info);
 			}
 
 			ar->scan.state = ATH12K_SCAN_IDLE;
-- 
2.34.1


