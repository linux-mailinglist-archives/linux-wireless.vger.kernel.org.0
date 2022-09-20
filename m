Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9245BE2A4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiITKGl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiITKGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:06:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1561703
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:05:49 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xkEH003441;
        Tue, 20 Sep 2022 10:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+ZUNOp+ii3f76ZX7ecrwsYhNG5DBFifaGnTQBCkEx9Q=;
 b=fYiYYIm6GooOZUqatd4qFFDlbbQSrueGsVv1HqtM73rMhTVVxrNgMMFZqfR6Szy6dR8v
 hIznuHpVcKKVpJw1MojW8H7VjsNARMIBgUhoeMTOGa1P4/KZ0HFTiSt9t/+BCjWiCCPm
 QD1ryrFN/LXxXGB2uNn4koO3Om8ZRbZMPQdoYgv8R5UF/9/p9HbCE7GQWcgm38axRY2M
 stWhrrVbB77Dku/7rUxsbjUMdtipgNZvERrFhYuu+nG0z7Jsz+WVrM4GE8dyghKTygKh
 Yr7+GNbWFsmlqwNcB7B18/ASz8JCLX84HOyDTSqwDV5ACinYBsK9eDXyesbCuARFw5V0 Xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpw78ana0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:05:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KA5gKH012328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:05:42 GMT
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 03:05:40 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 1/4] wifi: cfg80211: Add provision to advertise multiple radio in one wiphy
Date:   Tue, 20 Sep 2022 15:35:15 +0530
Message-ID: <20220920100518.19705-2-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B_SvgrCHHgeegoqhbKCn6QbQQkX6yLJh
X-Proofpoint-GUID: B_SvgrCHHgeegoqhbKCn6QbQQkX6yLJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The prerequisite for MLO support in cfg80211/mac80211 is that all
the links participating in MLO must be from the same wiphy/ieee80211_hw.
To meet this expectation, some drivers may need to group multiple discrete
hardware each acting as a link in MLO under one wiphy. Though most of the
hardware abstractions must be handled within the driver itself, it may be
required to have some sort of mapping while describing interface
combination capabilities for each of the underlying hardware. This commit
adds an advertisement provision for drivers supporting such MLO mode of
operation.

Capability advertisement such as the number of supported channels for each
physical hardware has been identified to support some of the common use
cases.

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 include/net/cfg80211.h |  24 +++++++++
 net/wireless/core.c    | 109 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e09ff87146c1..4662231ad068 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5088,6 +5088,18 @@ struct wiphy_iftype_akm_suites {
 	int n_akm_suites;
 };
 
+/**
+ * struct ieee80211_supported_chans_per_hw - supported channels as per the
+ * underlying physical hardware configuration
+ *
+ * @n_chans: number of channels in @chans
+ * @chans: list of channels supported by the constituent hardware
+ */
+struct ieee80211_chans_per_hw {
+	int n_chans;
+	struct ieee80211_channel chans[];
+};
+
 /**
  * struct wiphy - wireless hardware description
  * @mtx: mutex for the data (structures) of this device
@@ -5297,6 +5309,15 @@ struct wiphy_iftype_akm_suites {
  *	NL80211_MAX_NR_AKM_SUITES in order to avoid compatibility issues with
  *	legacy userspace and maximum allowed value is
  *	CFG80211_MAX_NUM_AKM_SUITES.
+ *
+ * @hw_chans: list of the channels supported by every constituent underlying
+ *	hardware. Drivers abstracting multiple discrete hardware (radio) under
+ *	one wiphy can advertise the list of channels supported by each physical
+ *	hardware in this list. Underlying hardware specific channel list can be
+ *	used while describing interface combination for each of them.
+ * @num_hw: number of underlying hardware for which the channels list are
+ *	advertised in @hw_chans.
+ *
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5445,6 +5466,9 @@ struct wiphy {
 	u8 ema_max_profile_periodicity;
 	u16 max_num_akm_suites;
 
+	struct ieee80211_chans_per_hw **hw_chans;
+	int num_hw;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5b0c4d5b80cf..4163602a1b9a 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -653,6 +653,110 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
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
+	/*
+	 * for now same channel is not allowed in more than one
+	 * physical hardware.
+	 */
+	for (i = 0; i < chans1->n_chans; i++)
+		for (j = 0; j < chans2->n_chans; j++)
+			if (chans1->chans[i].center_freq ==
+			    chans2->chans[i].center_freq)
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
+	bool found;
+	int i, j;
+
+	for (i = 0; i < chans->n_chans; i++) {
+		found = false;
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
+	/*
+	 * advertisement of supported channels in wiphy->bands should be
+	 * sufficient when physical hardware is one.
+	 */
+	if (wiphy->num_hw < 2)
+		return -EINVAL;
+
+	for (i = 0; i < wiphy->num_hw; i++) {
+		for (j = 0; j < wiphy->num_hw; j++) {
+			const struct ieee80211_chans_per_hw *hw_chans1;
+			const struct ieee80211_chans_per_hw *hw_chans2;
+
+			if (i == j)
+				continue;
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
+		if (!cfg80211_hw_chans_in_supported_list(wiphy, hw_chans)) {
+			WARN_ON(1);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 int wiphy_register(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -908,6 +1012,11 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 	}
 
+	if (cfg80211_validate_per_hw_chans(&rdev->wiphy)) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < rdev->wiphy.n_vendor_commands; i++) {
 		/*
 		 * Validate we have a policy (can be explicitly set to
-- 
2.17.1

