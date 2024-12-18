Return-Path: <linux-wireless+bounces-16519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322919F5D8B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A1316AB22
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684DE14B06A;
	Wed, 18 Dec 2024 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="derevPub"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CD13D8A3;
	Wed, 18 Dec 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493316; cv=none; b=e5XDfozxrP5Bv56Hs6QyXxaLCR6wuEIZKNZfs7E7ZTG5TXYCnIieqFyM2OXVj8fhccYfL0QxAAfYvtjqzNwwBkioCUyXv9jtNOF0HA79sgwIMuyPrgC2Kobd0MNJy3z82N6LUwUJytGxV0Cae8g6LvaNwCyAY2bvMT+kuYC4Eao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493316; c=relaxed/simple;
	bh=8jK+Iq8sVk3YHSUEb7KnUntVtuFNQtKYws7HSe82IUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VXYczTLCj6PXW76ivwNVOQlPZx7SAaspquhFnIfjwCNBELwh/DTmYm0fBRS0OL0IzFy9zQPumFAUwaxWHK+k6R4xtZ/oY8/w/r5TTab8S9gn7X8rKvFEW0cTnHk+YvcmpvnHPm59itGhn/oKvHlC5H/zEqTV9Dz5JuksmzaDJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=derevPub; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHIJq12013339;
	Wed, 18 Dec 2024 03:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bih8oj4iR25DCzte9gmvw2zA9hXiB4JLQNfTMJZFo6E=; b=derevPub93ES7WQ0
	gRnAzWipkwUY8lqLC40mvU2ax6sZE8Wc+6tZUEomsqQAh4+TpVW8tcZzeE0gYkHF
	Ih6DjtdMmRKnL+rq1QaA5tecGqrXeRyaCIWQvhNepSXe15jlPfYZAbPn5ouXwBz9
	D0g4rhwU350qzcaQM7+pyeFl9syANM3TdGAbkmlDTYlSx6bmxenJ3XQvUnBLZARG
	qFtJTK79FY73BiDv9gE2Apt29KliI81MMHdCEXerrJI4OCh4Gq56oGjDRypFecbj
	dLueYLUfnL4U4RdKyRSVzHuM/loC3AMRd8AzoDtHNlFPpmvOAioNZu9vYdFHCS9k
	XUfOJA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kefxh24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BI3forW021668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:41:50 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 19:41:47 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Wed, 18 Dec 2024 09:11:33 +0530
Subject: [PATCH 2/3] wifi: ath12k: fix CAC running state during virtual
 interface start
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241218-ath12k_mlo_dfs-v1-2-058e783bcfc7@quicinc.com>
References: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
In-Reply-To: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rRPd5rjwVFnOS_FIeX3SjJGqJz7hK-fH
X-Proofpoint-ORIG-GUID: rRPd5rjwVFnOS_FIeX3SjJGqJz7hK-fH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180026

Currently, the DFS CAC time and the usable state of the primary channel in
the channel definition are used to set the CAC_RUNNING flag for the ath12k
radio structure. However, this approach is flawed because there are channel
definitions where the primary channel is not a DFS channel, but the
secondary channel is. For example, in 5 GHz band, channel 36 with 160 MHz
bandwidth. In such cases, the flag is not set correctly and hence places
where this flag is tested will not operate as expected. For example, Rx
packets will not be dropped.

To fix this issue, use the cfg80211_chandef_dfs_usable() function from
cfg80211, which returns true if at least one channel is in a usable state.
This will ensure the CAC_RUNNING flag is set properly.

Additionally, update the CAC running debug log message to include the CAC
time in milliseconds and also print the center frequency segment 1.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c61b1519cc91c6a476e1510b4cf13f80c89a793a..77518546259248c356556b07ae0ae1df428d01dd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5,6 +5,7 @@
  */
 
 #include <net/mac80211.h>
+#include <net/cfg80211.h>
 #include <linux/etherdevice.h>
 
 #include "mac.h"
@@ -8670,11 +8671,13 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 	struct ath12k_base *ab = ar->ab;
 	struct wmi_vdev_start_req_arg arg = {};
 	const struct cfg80211_chan_def *chandef = &ctx->def;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_bss_conf *link_conf;
+	unsigned int dfs_cac_time;
 	int ret;
 
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	link_conf = ath12k_mac_get_link_bss_conf(arvif);
 	if (!link_conf) {
@@ -8772,20 +8775,20 @@ ath12k_mac_vdev_start_restart(struct ath12k_link_vif *arvif,
 	ath12k_dbg(ab, ATH12K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
 		   ahvif->vif->addr, arvif->vdev_id);
 
-	/* Enable CAC Flag in the driver by checking the channel DFS cac time,
-	 * i.e dfs_cac_ms value which will be valid only for radar channels
-	 * and state as NL80211_DFS_USABLE which indicates CAC needs to be
-	 * done before channel usage. This flags is used to drop rx packets.
+	/* Enable CAC Running Flag in the driver by checking all sub-channel's DFS
+	 * state as NL80211_DFS_USABLE which indicates CAC needs to be
+	 * done before channel usage. This flag is used to drop rx packets.
 	 * during CAC.
 	 */
 	/* TODO: Set the flag for other interface types as required */
-	if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP &&
-	    chandef->chan->dfs_cac_ms &&
-	    chandef->chan->dfs_state == NL80211_DFS_USABLE) {
+	if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP && ctx->radar_enabled &&
+	    cfg80211_chandef_dfs_usable(hw->wiphy, chandef)) {
 		set_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
+		dfs_cac_time = cfg80211_chandef_dfs_cac_time(hw->wiphy, chandef);
+
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
-			   "CAC Started in chan_freq %d for vdev %d\n",
-			   arg.freq, arg.vdev_id);
+			   "CAC started dfs_cac_time %u center_freq %d center_freq1 %d for vdev %d\n",
+			   dfs_cac_time, arg.freq, arg.band_center_freq1, arg.vdev_id);
 	}
 
 	ret = ath12k_mac_set_txbf_conf(arvif);

-- 
2.34.1


