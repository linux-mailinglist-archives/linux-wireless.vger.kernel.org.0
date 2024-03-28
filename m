Return-Path: <linux-wireless+bounces-5443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65988F8C0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7571D298C38
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A552F6C;
	Thu, 28 Mar 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E1ovLLg5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305D5427E
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611023; cv=none; b=N7Z2+FOLc541JNqfQfEjVaQA9h6saoE428pPFGm5/xtTds5qPtg/CbXfYiiJ6O/S046TM8NhbuvamFl186LMqJK1N+hbsk/yNCBUG04QuQKvXCUnwc2Zd3hHQ64mW0qJ2gMUDphzNL48Of22fIACvoE5sS7ayspQ5eBXe41vAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611023; c=relaxed/simple;
	bh=pZrxSuKWz5Z3mCUoHB7BqLhhk76yUNAi2dwuOA8WZfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozsmtt9Gepw5O4BrBbfM9VyHgmgmq/C8nqoRTIDs+q57M7eBgUuHfXOuMuk3oa1C7qLALP2PAJKPDuHgjjsbtDzplDjNwkA+GHAzPAYGW14BiLexZHv2rGPx8/mp7PZAnVYC8uQ+pH0MH18WjhR4WGMQ7GHlHVmejZpNtbv1jAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E1ovLLg5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S7EZd1019132;
	Thu, 28 Mar 2024 07:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+RIBdnw0vwx2Tq+khsrWtyptD39yTzsKamSP4/IYk0Q=; b=E1
	ovLLg5dxRV4YAePyLTus+Fv4EtHtn2FXHhCpd89IKhw3OLwIe45vqJodM8iyyjYu
	T9jW+3oqS6g30ZwDqZ32YJS6uEYqtrei5lrgMOUB0QSATuwsXfE+4s11APdA/Tp/
	Bzo7mL+Oo+F43GbV4RkfChac/tWs7ew8UNd3XWeSumGpV38uEH/yaxDuyA+sXq1T
	DZCNA2RAOUs49N+CYALqMlEmCu6Nioyy//irh6irMDw3si4pYm6zjUloMIhUNxsD
	KixoIzvTynr+hb/za0rzldSWWv+dJmQubY2g/Nb9Sg0DlF3letQ9ZIZ1auX2DlEX
	upfDOb8ce/bC6rc18kQw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wt9f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7UEJG000713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:14 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:30:11 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 13/13] wifi: ath12k: Advertise multi hardware iface combination
Date: Thu, 28 Mar 2024 12:59:16 +0530
Message-ID: <20240328072916.1164195-14-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZwcF98HMWFacUr1UTBOD1GHNB5JqPeF6
X-Proofpoint-GUID: ZwcF98HMWFacUr1UTBOD1GHNB5JqPeF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=746
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

From: Harshitha Prem <quic_hprem@quicinc.com>

The prerequisite for MLO support in cfg80211/mac80211 requires that all
the links participating in MLO belong to the same wiphy/ieee80211_hw.
The driver needs to group multiple discrete hardware each acting as a
link in MLO, under one wiphy. Consequently, the driver advertises multi
hardware interface combination capabilities with a list of supported
frequencies.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 128 +++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 44c8bf6eb6ae..3d0cae8d883a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7781,10 +7781,126 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 	return is_enable;
 }
 
+static
+struct ieee80211_chans_per_hw *ath12k_setup_per_hw_chan(struct ath12k *ar)
+{
+	struct ieee80211_chans_per_hw *chans;
+	struct ieee80211_supported_band *band;
+
+	if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP)
+		band = &ar->mac.sbands[NL80211_BAND_2GHZ];
+	else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
+		 !ar->supports_6ghz)
+		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
+	else if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
+		 ar->supports_6ghz)
+		band = &ar->mac.sbands[NL80211_BAND_6GHZ];
+
+	chans = kzalloc(struct_size(chans, chans, band->n_channels),
+			GFP_KERNEL);
+	if (!chans)
+		return NULL;
+
+	memcpy(chans->chans, band->channels,
+	       sizeof(*band->channels) * band->n_channels);
+	chans->n_chans = band->n_channels;
+
+	return chans;
+}
+
+static void ath12k_mac_cleanup_hw_channels(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+	int i;
+
+	for (i = 0; i < ah->num_radio; i++)
+		kfree(wiphy->hw_chans[i]);
+
+	kfree(wiphy->hw_chans);
+}
+
+static int
+ath12k_mac_setup_hw_channels(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+	int i, ret;
+
+	wiphy->hw_chans = kcalloc(ah->num_radio, sizeof(*wiphy->hw_chans),
+				  GFP_KERNEL);
+	if (!wiphy->hw_chans)
+		return -ENOMEM;
+
+	for (i = 0; i < ah->num_radio; i++) {
+		wiphy->hw_chans[i] = ath12k_setup_per_hw_chan(&ah->radio[i]);
+		if (!wiphy->hw_chans[i]) {
+			ret = -ENOMEM;
+			goto cleanup_hw_chan;
+		}
+	}
+
+	wiphy->num_hw = ah->num_radio;
+
+	return 0;
+
+cleanup_hw_chan:
+	for (i = i - 1; i >= 0; i--)
+		kfree(wiphy->hw_chans[i]);
+
+	kfree(wiphy->hw_chans);
+
+	return ret;
+}
+
+static void
+ath12k_mac_cleanup_per_hw_iface_comb(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+
+	ath12k_mac_cleanup_hw_channels(ah);
+
+	kfree(wiphy->iface_combinations[0].iface_hw_list);
+}
+
+static int
+ath12k_mac_setup_per_hw_iface_comb(struct ath12k_hw *ah,
+				   struct ieee80211_iface_combination *comb)
+{
+	struct ieee80211_iface_per_hw *iface_hw;
+	struct ieee80211_hw *hw = ah->hw;
+	int i, ret;
+
+	ret = ath12k_mac_setup_hw_channels(ah);
+	if (ret)
+		return ret;
+
+	iface_hw  = kcalloc(ah->num_radio, sizeof(*iface_hw), GFP_KERNEL);
+	if (!iface_hw) {
+		ath12k_mac_cleanup_hw_channels(ah);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ah->num_radio; i++) {
+		iface_hw[i].hw_chans_idx = i;
+		iface_hw[i].num_different_channels =
+					comb->num_different_channels;
+		iface_hw[i].max_interfaces = comb->max_interfaces;
+		iface_hw[i].limits = comb->limits;
+		iface_hw[i].n_limits = comb->n_limits;
+	}
+
+	comb->iface_hw_list = iface_hw;
+	comb->n_hw_list = hw->wiphy->num_hw;
+
+	return 0;
+}
+
 static void ath12k_mac_cleanup_iface_combinations(struct ath12k_hw *ah)
 {
 	struct wiphy *wiphy = ah->hw->wiphy;
 
+	if (ah->num_radio > 1)
+		ath12k_mac_cleanup_per_hw_iface_comb(ah);
+
 	kfree(wiphy->iface_combinations[0].limits);
 	kfree(wiphy->iface_combinations);
 }
@@ -7794,7 +7910,7 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 	struct wiphy *wiphy = ah->hw->wiphy;
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
-	int n_limits, max_interfaces;
+	int n_limits, max_interfaces, ret;
 	bool ap, mesh, p2p;
 
 	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
@@ -7857,6 +7973,16 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 						BIT(NL80211_CHAN_WIDTH_40) |
 						BIT(NL80211_CHAN_WIDTH_80);
 
+	if (ah->num_radio > 1) {
+		ret = ath12k_mac_setup_per_hw_iface_comb(ah, combinations);
+		if (ret) {
+			kfree(limits);
+			kfree(combinations);
+
+			return ret;
+		}
+	}
+
 	wiphy->iface_combinations = combinations;
 	wiphy->n_iface_combinations = 1;
 
-- 
2.34.1


