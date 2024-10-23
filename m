Return-Path: <linux-wireless+bounces-14351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A95789ABE4C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A3DB24AE7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D68C145FFF;
	Wed, 23 Oct 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P8h7Nkhh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5839145B1B;
	Wed, 23 Oct 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663477; cv=none; b=ptAT6f2Df9DCaaXITtjM5Figs7km/eG4MGkJKFT+3Y629wzG78VDRsJ4ZNsfw5yGxe6Kak6bLJCVx+etSQL6nQV1EMKwJRwcCxISCyJ68NnDyt5v8jnnP9D5IFP9E9HeFdIMm1v3wMyQTW/6YGZE+/wFN9WwB1RdMuCTJiEa388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663477; c=relaxed/simple;
	bh=fQwZY89RsxHfLqwsTYd6uN0mUiHnqqplXWDCUXtDT5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H29tC8iKCWCZrvAQwh2tibyEViglSJYJAH4BPKg3HQFODpclbXV1NISH0mT29Iyxk2nk6cCWdQSA04TRUZnsHjxFTeMV8mNVtVzWhV9JCPDTCGhhnT01il77hKE5pYYzlpQe/jDC+s80qAD+desNPAYxLAXFu54/lmAdcnMELrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P8h7Nkhh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLejUe018635;
	Wed, 23 Oct 2024 06:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gzWrTatuMnIeEeP+iJiyK8aHdkKFKKlqQNYSM8pc2qw=; b=P8h7Nkhh/6VnIuhe
	LZJW2KLp/8oydv8FjObxF0webGt/bJ2IYQJVtjX4YGaabWh0/Bi8orCk8FuzpkRb
	sSj2FB3PywkUDu4TgrHNxdIZvdF5Iv/hwo+MBblLBh6q39om05i7flh/ISoMxlK9
	58kjOkOPfDGMFSqDvVh8ArJyOqu041l449PIyU6B50xy4z5jdF1lmnl/TFOW5o4A
	x7gPsyyURaERS/tE+itBLfMHcjWc9uZhEnW+PkkSjN1/7QmIOOYs2c70FpuNAVX+
	yUY8gCgStnTrKdniaLP34TJVXuHaJhGxjhPPfh2kBg5sa/bBWw/JmPcT1V8y42cS
	1+ff4w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em6691g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N64UFw017585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:30 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 23:04:25 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
	<quic_kvalo@quicinc.com>
Subject: [RFC PATCH 3/6] wifi: ath12k: parse multiple device information from device tree
Date: Wed, 23 Oct 2024 11:33:49 +0530
Message-ID: <20241023060352.605019-4-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tmW-yvm3k45P6V7vEcs6YQNQE5baTuNG
X-Proofpoint-GUID: tmW-yvm3k45P6V7vEcs6YQNQE5baTuNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230035

From: Harshitha Prem <quic_hprem@quicinc.com>

Currently, single device is part of device group abstraction but for multi
link operation, multiple devices have to be combined together. Information
of how many devices involved in grouping can be parsed from device tree and
it would have the valid group id information as well.

Add changes to parse devices involved and group id from device tree file
to form device group

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Co-developed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 106 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h |   2 +
 2 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3f0f44cbdb4c..b7b2d552205c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1403,6 +1403,7 @@ ath12k_core_hw_group_alloc(u8 id, u8 max_devices)
 	ag->num_devices = max_devices;
 	list_add(&ag->list, &ath12k_hw_group_list);
 	mutex_init(&ag->mutex_lock);
+	ag->mlo_capable = false;
 
 	return ag;
 }
@@ -1417,23 +1418,94 @@ static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
 	mutex_unlock(&ath12k_ag_list_lock);
 }
 
+/* This function needs to be used only when dt has multi chip grouping information */
+static struct ath12k_hw_group *ath12k_core_hw_group_find_by_id(u8 group_id)
+{
+	struct ath12k_hw_group *ag;
+
+	/* group ids will be unique only for multi chip group */
+	list_for_each_entry(ag, &ath12k_hw_group_list, list) {
+		if (group_id == ag->id && ag->num_devices > 1)
+			return ag;
+	}
+
+	return NULL;
+}
+
 static struct ath12k_hw_group *ath12k_core_assign_hw_group(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag;
-	u32 group_id = ATH12K_INVALID_GROUP_ID;
+	u32 group_id = ATH12K_INVALID_GROUP_ID, num_devices;
+	struct device *dev = ab->dev;
+	struct device_node *mlo;
 
 	lockdep_assert_held(&ath12k_ag_list_lock);
 
-	/* The grouping of multiple devices will be done based on device tree file.
-	 * TODO: device tree file parsing to know about the devices involved in group.
-	 *
-	 * The platforms that do not have any valid group information would have each
-	 * device to be part of its own invalid group.
+	/* The grouping of multiple devices will be done based on device
+	 * tree file.
 	 *
-	 * Currently, we are not parsing any device tree information and hence, grouping
-	 * of multiple devices is not involved. Thus, single device is added to device
-	 * group.
+	 * The platforms that do not have any valid group information would
+	 * have each device to be part of its own invalid group.
 	 */
+	mlo = of_get_child_by_name(dev->of_node, "wsi");
+	if (!mlo) {
+		goto invalid_group;
+	} else {
+		if (of_property_read_u32(mlo, "qcom,wsi-group-id", &group_id)) {
+			ath12k_err(ab, "wsi-group-id not found\n");
+			goto invalid_group;
+		}
+	}
+
+	if (of_property_read_u32(mlo, "qcom,wsi-num-devices", &num_devices)) {
+		ath12k_err(ab, "wsi-num-devices not found\n");
+		group_id = ATH12K_INVALID_GROUP_ID;
+		goto invalid_group;
+	}
+
+	if (num_devices > ATH12K_MAX_SOCS) {
+		ath12k_warn(ab, "num_devices advertised %d is more than limit %d\n",
+			    num_devices, ATH12K_MAX_SOCS);
+		group_id = ATH12K_INVALID_GROUP_ID;
+		goto invalid_group;
+	}
+
+	if (of_property_read_u32(mlo, "qcom,wsi-index", &ab->wsi_index)) {
+		ath12k_err(ab, "qcom,wsi-index not found\n");
+		group_id = ATH12K_INVALID_GROUP_ID;
+		goto invalid_group;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT,
+		   "WSI info: group-id: %d, num-devices: %d, index: %d",
+		   group_id, num_devices, ab->wsi_index);
+
+	/* Currently only one group of multiple devices are supported,
+	 * since we use group id ATH12K_INVALID_GROUP_ID for single
+	 * device group which didn't have dt entry, there could be many
+	 * groups with same group id, i.e ATH12K_INVALID_GROUP_ID. So
+	 * default group id of ATH12K_INVALID_GROUP_ID combined with
+	 * num devices in ath12k_hw_group determines if the group is
+	 * multi device or single device group
+	 */
+	ag = ath12k_core_hw_group_find_by_id(group_id);
+	if (!ag) {
+		ag = ath12k_core_hw_group_alloc(group_id, num_devices);
+		if (!ag) {
+			ath12k_warn(ab, "unable to create new hw group\n");
+			return NULL;
+		}
+		goto exit;
+	} else if (test_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags)) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "group id %d in unregister state\n",
+			   ag->id);
+		group_id = ATH12K_INVALID_GROUP_ID;
+		goto invalid_group;
+	} else {
+		goto exit;
+	}
+
+invalid_group:
 	ag = ath12k_core_hw_group_alloc(group_id, 1);
 	if (!ag) {
 		ath12k_warn(ab, "unable to create new hw group\n");
@@ -1441,10 +1513,16 @@ static struct ath12k_hw_group *ath12k_core_assign_hw_group(struct ath12k_base *a
 	}
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "Single device is added to hardware group\n");
 
+exit:
+	if (ag->num_probed >= ag->num_devices) {
+		ath12k_warn(ab, "unable to add new device to group, max limit reached\n");
+		group_id = ATH12K_INVALID_GROUP_ID;
+		goto invalid_group;
+	}
+
 	ab->device_id = ag->num_probed++;
 	ag->ab[ab->device_id] = ab;
 	ab->ag = ag;
-	ag->mlo_capable = false;
 
 	return ag;
 }
@@ -1511,6 +1589,14 @@ static void ath12k_core_hw_group_cleanup(struct ath12k_hw_group *ag)
 		return;
 
 	mutex_lock(&ag->mutex_lock);
+
+	if (test_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags)) {
+		mutex_unlock(&ag->mutex_lock);
+		return;
+	}
+
+	set_bit(ATH12K_GROUP_FLAG_UNREGISTER, &ag->flags);
+
 	ath12k_core_hw_group_stop(ag);
 
 	for (i = 0; i < ag->num_devices; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cde35616ba56..09fc1c29368f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -211,6 +211,7 @@ enum ath12k_scan_state {
 
 enum ath12k_hw_group_flags {
 	ATH12K_GROUP_FLAG_REGISTERED,
+	ATH12K_GROUP_FLAG_UNREGISTER,
 };
 
 enum ath12k_dev_flags {
@@ -1026,6 +1027,7 @@ struct ath12k_base {
 	struct notifier_block panic_nb;
 
 	struct ath12k_hw_group *ag;
+	u32 wsi_index;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
-- 
2.34.1


