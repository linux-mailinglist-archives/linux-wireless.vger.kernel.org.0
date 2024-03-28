Return-Path: <linux-wireless+bounces-5438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE388F8BB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3B1298C42
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D050A63;
	Thu, 28 Mar 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UxQcZTOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8904E1D1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611018; cv=none; b=aOi9bsOP28PWb/YI+qHGxL0Te5+Q7N4tWQ16utRUnRJ+mFQjpAkWCbB93/Eut0F1jpazmUZel0RdWKDX7GPWDbkDQA6laWYfJEYrmbiBLc//XACwKlZiC0F0Gwww05ONIOz3XA43pVQHQdf4DDHNlG8NuIjN++hXGCVuEjXCbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611018; c=relaxed/simple;
	bh=yuFCxM2KrYFnO9kHj8KW9Y6PTLlOFvICfyJNhddE6aE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXJ/omxJUTMCXAnSLIdohIw6O+dhkQBpwQIP/977tW23gq708+51ZlPIKJkIMnJxqqFCgQpOEapN4wCAZaO3QHFgD3l9O7E+CPtXmZDQCnuj2uJmjdAz+BHTDq7bQQTgIKpey0ZSzA//cu3yaKRX8CBUIyJLaPGPXOQCzsEpqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UxQcZTOq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S52okD008246;
	Thu, 28 Mar 2024 07:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=sf7XQrn8OOpzfAnWC78Bzf3fNIIO26Kb7m5W2QlOTsU=; b=Ux
	QcZTOqM9vggr+9yIjmOzn7nn9aFVaA16PysK8iuDfpAxwHN5PMG4yAdj6iIIUzf4
	rnPeP+X+DKmFz9yJ5EXTRAg+20CPOoR8WjCcNsDFwX54E6W6pzCyChakLBDqE80m
	zBbKRMSiIC9ITs6rck1UeMdLhG0rM4bCsdflpN5aWXYbdWNegcSxVIQSq2Eb8GaC
	jWAvobYTU5XzaE+ohmsgsHt+7wnjBsOo3oyNNC5ocy5OV8bo4rVgCOD0PXNvo4HZ
	/tSNwImoZ1hmgQ+UMT44f0RfktwKrcOb8S+vzgv005eRs6t/IeegG39ABtHufOYL
	Q1bHjsO7xH7lLadReICw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wjb2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7TjQj012638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:45 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:29:43 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple radio in one wiphy
Date: Thu, 28 Mar 2024 12:59:04 +0530
Message-ID: <20240328072916.1164195-2-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: iC8DXTC_-GQr-yHgugZ9RYewSFrPLKWm
X-Proofpoint-ORIG-GUID: iC8DXTC_-GQr-yHgugZ9RYewSFrPLKWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

As originally discussed in the RFC [1], the prerequisite for MLO support
in cfg80211/mac80211 is that all the links participating in MLO must
belong to the same wiphy/ieee80211_hw. To meet this expectation, some
drivers may need to group multiple discrete hardware, each acting as a
link in MLO, under one wiphy. Though most of the hardware abstractions must
be handled within the driver itself, it may be required to have some sort
of mapping while describing interface combination capabilities for each of
the underlying hardware. Add an advertisement provision for drivers
supporting such MLO mode of operation.

Capability advertisement such as the number of supported channels for each
physical hardware has been identified to support some of the common use
cases.

[1]: https://lore.kernel.org/linux-wireless/20220920100518.19705-2-quic_vthiagar@quicinc.com/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 include/net/cfg80211.h |  24 ++++++++++
 net/wireless/core.c    | 100 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2e2be4fd2bb6..dde129e61b60 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5394,6 +5394,18 @@ struct wiphy_iftype_akm_suites {
 
 #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
 
+/**
+ * struct ieee80211_chans_per_hw - supported channels as per the
+ * underlying physical hardware configuration
+ *
+ * @n_chans: number of channels in @chans
+ * @chans: list of channels supported by the constituent hardware
+ */
+struct ieee80211_chans_per_hw {
+	u32 n_chans;
+	struct ieee80211_channel chans[];
+};
+
 /**
  * struct wiphy - wireless hardware description
  * @mtx: mutex for the data (structures) of this device
@@ -5610,6 +5622,15 @@ struct wiphy_iftype_akm_suites {
  *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
  *	supports enabling HW timestamping for all peers (i.e. no need to
  *	specify a mac address).
+ *
+ * @hw_chans: list of the channels supported by every constituent underlying
+ *	hardware. Drivers abstracting multiple discrete hardware (radio) under
+ *	one wiphy can advertise the list of channels supported by each physical
+ *	hardware in this list. Underlying hardware specific channel list can be
+ *	used while describing interface combination for each of them.
+ * @num_hw: number of underlying hardware for which the channels list are
+ *	advertised in @hw_chans, 0 if multi hardware is not support. Expect >2
+ *	if multi hardware is support.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5760,6 +5781,9 @@ struct wiphy {
 
 	u16 hw_timestamp_max_peers;
 
+	struct ieee80211_chans_per_hw **hw_chans;
+	u8 num_hw;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3fb1b637352a..119937d0f2e0 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -690,6 +690,103 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 	return 0;
 }
 
+static int cfg80211_check_hw_chans(const struct ieee80211_chans_per_hw *chans1,
+				   const struct ieee80211_chans_per_hw *chans2)
+{
+	int i, j;
+
+	if (!chans1 || !chans2)
+		return -EINVAL;
+
+	if (!chans1->n_chans || !chans2->n_chans)
+		return -EINVAL;
+
+	/* for now same channel is not allowed in more than one
+	 * physical hardware.
+	 */
+	for (i = 0; i < chans1->n_chans; i++)
+		for (j = 0; j < chans2->n_chans; j++)
+			if (chans1->chans[i].center_freq ==
+			    chans2->chans[j].center_freq)
+				return -EINVAL;
+	return 0;
+}
+
+static bool
+cfg80211_hw_chans_in_supported_list(struct wiphy *wiphy,
+				    const struct ieee80211_chans_per_hw *chans)
+{
+	enum nl80211_band band;
+	struct ieee80211_supported_band *sband;
+	int i, j;
+
+	for (i = 0; i < chans->n_chans; i++) {
+		bool found = false;
+
+		for (band = 0; band < NUM_NL80211_BANDS; band++) {
+			sband = wiphy->bands[band];
+			if (!sband)
+				continue;
+			for (j = 0; j < sband->n_channels; j++) {
+				if (chans->chans[i].center_freq ==
+				    sband->channels[j].center_freq) {
+					found = true;
+					break;
+				}
+			}
+
+			if (found)
+				break;
+		}
+
+		if (!found)
+			return false;
+	}
+
+	return true;
+}
+
+static int cfg80211_validate_per_hw_chans(struct wiphy *wiphy)
+{
+	int i, j;
+	int ret;
+
+	if (!wiphy->num_hw)
+		return 0;
+
+	if (!wiphy->hw_chans)
+		return -EINVAL;
+
+	/* advertisement of supported channels in wiphy->bands should be
+	 * sufficient when physical hardware is one.
+	 */
+	if (wiphy->num_hw < 2)
+		return -EINVAL;
+
+	for (i = 0; i < wiphy->num_hw; i++) {
+		for (j = i + 1; j < wiphy->num_hw; j++) {
+			const struct ieee80211_chans_per_hw *hw_chans1;
+			const struct ieee80211_chans_per_hw *hw_chans2;
+
+			hw_chans1 = wiphy->hw_chans[i];
+			hw_chans2 = wiphy->hw_chans[j];
+			ret = cfg80211_check_hw_chans(hw_chans1, hw_chans2);
+			if (ret)
+				return ret;
+		}
+	}
+
+	for (i = 0; i < wiphy->num_hw; i++) {
+		const struct ieee80211_chans_per_hw *hw_chans;
+
+		hw_chans = wiphy->hw_chans[i];
+		if (!cfg80211_hw_chans_in_supported_list(wiphy, hw_chans))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int wiphy_register(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -927,6 +1024,9 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 	}
 
+	if (WARN_ON(cfg80211_validate_per_hw_chans(&rdev->wiphy)))
+		return -EINVAL;
+
 	for (i = 0; i < rdev->wiphy.n_vendor_commands; i++) {
 		/*
 		 * Validate we have a policy (can be explicitly set to
-- 
2.34.1


