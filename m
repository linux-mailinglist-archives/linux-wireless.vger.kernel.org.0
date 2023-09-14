Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE479FFAC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 11:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjINJJO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjINJJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EE1FC9
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 02:08:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E39vRg014441;
        Thu, 14 Sep 2023 09:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TyAJ7tqD+DaNWhmQstEJkOBpILLg2Nq1lcUBXfCWB6E=;
 b=OOa6ZQyhM8SzuUcKDY4RTdsS7slNB9lOfpZBUSKxces1hVfNtfvvpVSseopcPoNYBBx9
 iCdcjNlxtfvjMx4nrFzSAaFkcWxLf9whyxxjyDun7r0iIUzuIAdngsbIyew/NsecEO4G
 jcoHWGhCRc7uRiuk1asdfQgLolK3JFMeFvubiIvNf68Dl+NzZy+jvyTrQzYAvoI4+jP1
 8Ow4FiH0eKN3RItPZju5BhxmBpC2kxjYJkPx0tM9sCX+5HgPXJgADf71VGvQyvGTBReQ
 NgWVpXmEoJeWqmD2zG0SSYjZ4DNRsmkx3O7jhQlEb8VK6FzD41fiaO9KrPKatDhodhfH Tw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3dj8ajf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 09:08:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E98Dds006433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 09:08:13 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 02:08:11 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 4/4] wifi: ath12k: store and send country code to firmware after recovery
Date:   Thu, 14 Sep 2023 05:07:46 -0400
Message-ID: <20230914090746.23560-5-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914090746.23560-1-quic_wgong@quicinc.com>
References: <20230914090746.23560-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wzXSHHCws9Afed0FLiCzBhLYo3uXJLT5
X-Proofpoint-ORIG-GUID: wzXSHHCws9Afed0FLiCzBhLYo3uXJLT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140078
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ath12k does not send the country code to firmware after device
recovery. As a result the regdomain info is reported from firmware by
default. Regdomain info is important, so ath12k also need to restore
it to the value which was used before recovery.

This is only needed for platforms which support the current_cc_support
hardware parameter.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 1 +
 drivers/net/wireless/ath/ath12k/core.h | 1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++++++
 drivers/net/wireless/ath/ath12k/reg.c  | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 71450dc1f48d..4433d7701c67 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -696,6 +696,7 @@ static void ath12k_update_11d(struct work_struct *work)
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 
+		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
 		ret = ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
 		if (ret)
 			ath12k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e739869ded73..63586cc12a2e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -582,6 +582,7 @@ struct ath12k {
 	struct completion completed_11d_scan;
 	enum ath12k_11d_state state_11d;
 	bool regdom_set_by_user;
+	u8 alpha2[REG_ALPHA2_LEN];
 };
 
 struct ath12k_band_cap {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 740e8045a6f1..0df154c34f8f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6908,6 +6908,14 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		ar->state = ATH12K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
 
+		if (ar->ab->hw_params->current_cc_support &&
+		    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
+			struct wmi_set_current_country_params set_current_param = {};
+
+			memcpy(&set_current_param.alpha2, ar->alpha2, 2);
+			ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		}
+
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
 			ath12k_dbg(ab, ATH12K_DBG_BOOT, "recovery count %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 97c93a4901e6..eb46bfc2b2b9 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -82,6 +82,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	 */
 	if (ar->ab->hw_params->current_cc_support) {
 		memcpy(&set_current_param.alpha2, request->alpha2, 2);
+		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
 
 		ret = ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
 		if (ret)
-- 
2.40.1

