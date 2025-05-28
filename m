Return-Path: <linux-wireless+bounces-23471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C879DAC684D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 13:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE823BC168
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FA28151C;
	Wed, 28 May 2025 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IeKhaX1N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0728136B
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431470; cv=none; b=F3dtfIf1WR/IwIqlQZR0XkOqibH47gobLAHfekP/gWIbpeH8C5BYgG1bdRGCMNZ7CO526LkWM8PIKCCagEqLmlrlKGjlY8mYeWcQ5d9Rwd+dIabTSRkFsqWo96MqLkLRSkz0U1DiRpPmfgnmQN1vWf6njqPObivipedw3d0ky20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431470; c=relaxed/simple;
	bh=8/FgW69JxISLwNura1GmuAjcgN5CszRt4gEccDaBRuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWovWJtEKCOX1nRNcPCAiqXdE5t+k+uErj+O923Cc07V1uQVqVdvZP4Giab2nsqOfaAwTfJv1sl4WfKV54Jpicf/KuBV8tgIlCzx2GJrTWcXh4QyOuhuDjFo05UEWdSRkme/gPeT8pamreK/W022RBcNMohfx0ufYLQ23Prk7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IeKhaX1N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9lCYA013860
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 11:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XvXVrbB9uCBsREJVHQePUtbTeQk8uumQSbPwvo6V9AQ=; b=IeKhaX1NNWkAKW68
	OpWiXPpGYaJ1L27xXREghqeNO/SEV7mQS4gJoOfN7E8E1t5P5LScOs6zxYnFg1BZ
	/wHnrgkb9Rka10WE5wLFjrHT5EopT2yRegROSQHKe7ZkaUW8ygCbU7/4ryZM7jbk
	MEd7m54AsbMbNhw6ha8Tfj5izB1F+A2UPOsjFobg8VbvMphr+Due+RQtNX/t99TL
	wdaSytHoatrlM4BReoaljBCEMHzXfLVJ1mlb5uwllzrULuZLvZzZWFJMImWy0SSM
	x1wiAK1Z7TBrXPw+BNTIWqA67eyeqdXGh7Cg4McYkw6DVKREqY5WkENPCMJmMls6
	YJNAeQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691che7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 11:24:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-310a0668968so4092369a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 04:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748431467; x=1749036267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvXVrbB9uCBsREJVHQePUtbTeQk8uumQSbPwvo6V9AQ=;
        b=e/giVBN4SnY4nMtczmlTwhh/pvzE43GiS+joRFiOy3hMe7MvUkGNClPQzI3mPCh6fV
         b8ebv0rhOA1gjL6Ime9wsX/UFS+9khjBVNDbtr6OvNLe5+O4neKMNBYWkoKvBSnT48hv
         zoCKdIbXgKgpJhKHzf+CjGY2cO4B7IfC3DKB5Qz0O6z5OFCvwALosBrODBn2o4zdwfbj
         tsKFETgQB18Ms8y57SUDsHZ3uP8i79xQvAV56Hh1t05DIFx25XSjXTUzLvFJpyJowdYI
         9B39HXsQ/kxduPuwBP7FONJBD1RTQy6IEMnRR5IZpj02OSAlMtbnkCRX2URHYMiOJwwm
         XO0Q==
X-Gm-Message-State: AOJu0Yxswl4ipzJ9zoQiXCPJ9Sp/CbR1Mant0E7v8kRC5BqvXi55Gsml
	aCdWerdAl/NUSyt7qzuArZOY3LLlZgiirxEPR7sclcnniuv2ldcG5li+9om420yoWiSKgcsMjEv
	Q8JpQlhkBWHiV9wC3FgaKgqfGX4oLEaz6N0EcTlPrzyr+0wWZVBKQDk3Ewl/pgteOrJ1upg==
X-Gm-Gg: ASbGncsJ7sE87Afnw0A8jxVR4C7lDrcSPwmc8tAYs+ER2S/FIBRmsd3/6KmpSxT5TL5
	CkTxHGScrMwHV41k7n92xhq6zHMfBPqZRyUDT8e3/22JN+tnaLA8reWC18M9KoV9qgnBRifr6Dx
	BxoswhLvjwvPMSVzgOjicQDFSiiq5rfkMvSt3TBiP9oPBAHajk9Y7JrMxvWQPVApw/pwtjHoNcF
	Sl9U/1yhCF+xOc6CNACKCdvKKlGM3Yrg9np3VsmkCqC2AIGDJL9FuSlT9anWy9X1mRqBpyDquGt
	Tr03xsi2qUbwkXW1m+uifP21U0im9jwYwhdQOsZ0O5dPH+41tM90UBqKpbpfAkd8QodgdN8trkm
	pMfnXTFKiNxAYYXkX6uEau/BtTPZp6Lt65kEp
X-Received: by 2002:a17:90b:3911:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-311f30b0ff9mr1919847a91.4.1748431466940;
        Wed, 28 May 2025 04:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxrSxa32P/OBuY6Gyr562LgyJoCpcIkhZC7dFxORGWAL6m6RyIoGAXyay4CRbLtlLjYQKkYw==
X-Received: by 2002:a17:90b:3911:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-311f30b0ff9mr1919815a91.4.1748431466513;
        Wed, 28 May 2025 04:24:26 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e9b668ffsm954665a91.20.2025.05.28.04.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 04:24:26 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 28 May 2025 16:54:01 +0530
Subject: [PATCH ath-next 2/2] wifi: ath12k: use real noise floor instead of
 default value
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-support_real_noise_floor-v1-2-04507bd3bc76@oss.qualcomm.com>
References: <20250528-support_real_noise_floor-v1-0-04507bd3bc76@oss.qualcomm.com>
In-Reply-To: <20250528-support_real_noise_floor-v1-0-04507bd3bc76@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6836f26c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=14mRfNIsjSzQyU8rJgwA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: oPhwZK-vCWeJF-I6NBpfUXE59Xs7R7Gh
X-Proofpoint-ORIG-GUID: oPhwZK-vCWeJF-I6NBpfUXE59Xs7R7Gh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwMCBTYWx0ZWRfX05xniO6nCYS4
 cIGMdOPhrDNRmf5hJwMcnA4VDVyVhZUQT0ewBx0/QUv96rNPW6R89UZUJp6zkFsYUSd7ST84QCh
 C3QYZsyYbBJYBm+aNsyMUd8SI5Y8GEc6JEcXo3DIjGnpV6HoKggZWhTPtTSF/3NGz2mLPBaf6pP
 yuTGAzxXpx37X1puYOyHUUGa8qAOXK458pT2NqgGdFvarbvtbhK3nal5xS4pxLWqBvo/AYy2pGf
 ayNNT1dlhYbPxE7M76drxKwyAl4ILpq1wfeAf0ZE0kEAXxoP/7ylPl0jWc+mQbTBOLUkAfnt5Do
 vJveynOHIMsM6dz6nVT7282nTjf+Qc8XAFD/K9Qs+wBhFr/uZbAy8PI2iWxOesz/xqipnHkTHq+
 yAYuxMrLvh9XVsyxzXNVAGT9VeNmWFGdYvefPAFpiU8yTUB8otOcgdQabsW7chixFdm4FuCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280100

From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

ATH12K_DEFAULT_NOISE_FLOOR represents the approximate noise floor value
which is used for RSSI calculation. Commit "wifi: ath12k: handle WMI event
for real noise floor calculation" added support to get the real noise floor
value from the firmware. Add changes to use the real value now instead of
the default one.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Co-developed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c |  7 ++++++-
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 20 ++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.c    | 10 +++++++---
 drivers/net/wireless/ath/ath12k/wmi.c    |  7 ++++++-
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 28cadc4167f7875e56eb80407b35cb97d4b19ad2..326bcc94ffee6dbdd8e88d0cc63561e379b95690 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2146,10 +2146,15 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 					  struct ieee80211_rx_status *rxs)
 {
 	struct ieee80211_supported_band *sband;
+	s32 noise_floor;
 	u8 *ptr = NULL;
 
+	spin_lock_bh(&ar->data_lock);
+	noise_floor = ath12k_pdev_get_noise_floor(ar);
+	spin_unlock_bh(&ar->data_lock);
+
 	rxs->flag |= RX_FLAG_MACTIME_START;
-	rxs->signal = ppduinfo->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
+	rxs->signal = ppduinfo->rssi_comb + noise_floor;
 	rxs->nss = ppduinfo->nss + 1;
 
 	if (ppduinfo->userstats[ppduinfo->userid].ampdu_present) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index b6816b6c2c0400ea8a027ef4527eea307346bc1f..2d4867668d8c53333da41837a0c9ff9dd282ed73 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -554,6 +554,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	struct ath12k_vif *ahvif;
 	struct ath12k *ar;
 	struct sk_buff *msdu = desc_params->skb;
+	s32 noise_floor;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
@@ -592,8 +593,13 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 			info->status.ack_signal = ts->ack_rssi;
 
 			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
-				      ab->wmi_ab.svc_map))
-				info->status.ack_signal += ATH12K_DEFAULT_NOISE_FLOOR;
+				      ab->wmi_ab.svc_map)) {
+				spin_lock_bh(&ar->data_lock);
+				noise_floor = ath12k_pdev_get_noise_floor(ar);
+				spin_unlock_bh(&ar->data_lock);
+
+				info->status.ack_signal += noise_floor;
+			}
 
 			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 		} else {
@@ -775,6 +781,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
 	struct sk_buff *msdu = desc_params->skb;
+	s32 noise_floor;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -827,8 +834,13 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 			info->status.ack_signal = ts->ack_rssi;
 
 			if (!test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
-				      ab->wmi_ab.svc_map))
-				info->status.ack_signal += ATH12K_DEFAULT_NOISE_FLOOR;
+				      ab->wmi_ab.svc_map)) {
+				spin_lock_bh(&ar->data_lock);
+				noise_floor = ath12k_pdev_get_noise_floor(ar);
+				spin_unlock_bh(&ar->data_lock);
+
+				info->status.ack_signal += noise_floor;
+			}
 
 			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8ff470749f14545d1c726cc1dc26880e129277fa..e52de62c38e1ce46d3afd6493f1b51587dd3036f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11042,8 +11042,8 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
 	struct ath12k_fw_stats_req_params params = {};
 	struct ath12k_link_sta *arsta;
+	s8 signal, noise_floor;
 	struct ath12k *ar;
-	s8 signal;
 	bool db2dbm;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -11091,15 +11091,19 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	    !(ath12k_mac_get_fw_stats(ar, &params)))
 		signal = arsta->rssi_beacon;
 
+	spin_lock_bh(&ar->data_lock);
+	noise_floor = ath12k_pdev_get_noise_floor(ar);
+	spin_unlock_bh(&ar->data_lock);
+
 	if (signal) {
-		sinfo->signal = db2dbm ? signal : signal + ATH12K_DEFAULT_NOISE_FLOOR;
+		sinfo->signal = db2dbm ? signal : signal + noise_floor;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
 
 	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi);
 
 	if (!db2dbm)
-		sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
+		sinfo->signal_avg += noise_floor;
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e07f1e46ba418a0583a0feaa711ada7b6cd193e2..1287755d6df0c1269f61d91ea06ed9024e975cf6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6427,6 +6427,7 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 	struct ieee80211_hdr *hdr;
 	u16 fc;
 	struct ieee80211_supported_band *sband;
+	s32 noise_floor;
 
 	if (ath12k_pull_mgmt_rx_params_tlv(ab, skb, &rx_ev) != 0) {
 		ath12k_warn(ab, "failed to extract mgmt rx event");
@@ -6488,7 +6489,11 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
 		status->freq = ieee80211_channel_to_frequency(rx_ev.channel,
 							      status->band);
 
-	status->signal = rx_ev.snr + ATH12K_DEFAULT_NOISE_FLOOR;
+	spin_lock_bh(&ar->data_lock);
+	noise_floor = ath12k_pdev_get_noise_floor(ar);
+	spin_unlock_bh(&ar->data_lock);
+
+	status->signal = rx_ev.snr + noise_floor;
 	status->rate_idx = ath12k_mac_bitrate_to_idx(sband, rx_ev.rate / 100);
 
 	hdr = (struct ieee80211_hdr *)skb->data;

-- 
2.34.1


