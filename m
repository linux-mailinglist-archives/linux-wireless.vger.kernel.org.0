Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957D6CD610
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjC2JM7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjC2JM6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 05:12:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81F1717
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 02:12:56 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9CrYD025224;
        Wed, 29 Mar 2023 09:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=/oHC4/xiP/Q5paDkxkFr2SSyGWd5ReRH1UbCEja/DLc=;
 b=Aux1VtFFkwbIH1mFVOyDXTEFHxFMhGHEhntFR6/ASIn5j92iI5hGRI5I5ZkUIRT76E4g
 g/ZUqTy2y+3nA3IoLkNFP++VJdkjgJtcZhxps71/UeMut1hiB6q2zWw3CgOHUkDUdT/f
 OEpBB2kO+DH2QSisHTJL21vUVXxfTIud3wS+osWMSq9ys1r/3FU5iuuuidk2OUx4pMCa
 xdxOmOTUZnlvfE0F4EdxfX5ICBI5VERJCXbGD6yfb6xTsTA+DHBkyNBZV02geIIpqNcK
 qw6ThkeAvovCOOX8eyrtKxPL8EDp9n2kiwUIhx3G/kpHqoxFJCqdJJc3vMh+CfkfGbbT Cw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pky0xaxt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 09:12:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T9CqJu021000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 09:12:52 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 02:12:51 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 1/2] wifi: ath11k: move update channel list from update reg worker to reg notifier
Date:   Wed, 29 Mar 2023 05:12:33 -0400
Message-ID: <20230329091235.19500-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230329091235.19500-1-quic_wgong@quicinc.com>
References: <20230329091235.19500-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1R5a1tzquFBXuyvoekZ3lDlCWQwfy6E_
X-Proofpoint-ORIG-GUID: 1R5a1tzquFBXuyvoekZ3lDlCWQwfy6E_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290075
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ath11k call regulatory_set_wiphy_regd() in ath11k_regd_update()
to notify the reg domain change to cfg80211, and then ath11k update the
channel list to firmware by ath11k_reg_update_chan_list() immediately in
ath11k_regd_update(), they are running in two threads, it leads the channel
list data out of sync caused by muti-threads without synchronization.
cfg80211 calculate the flags of ieee80211_channel asynchronously in its
reg_work, it is calculated by the callstack below and ath11k get the
flags of ieee80211_channel in another thread without synchronization
for the channel list data.

callstack:
handle_channel_custom()
handle_band_custom()
reg_process_self_managed_hint()
reg_process_self_managed_hints()
reg_todo()

ath11k_reg_update_chan_list() need to use the flags calculated by the
reg_work, they are two thread and have no synchronization for the flags,
then ath11k_reg_update_chan_list() maybe get the wrong flags value before
the calculation finished.

The correct flow is ath11k_reg_update_chan_list() should be called after
the flags finished calculation by reg_work. reg_call_notifier() with
initiator type NL80211_REGDOM_SET_BY_DRIVER will be called by
reg_process_self_managed_hint() after the calculation finished.

So change to update channel list in ath11k_reg_notifier() for initiator
type NL80211_REGDOM_SET_BY_DRIVER, then the calculation of flags of
ieee80211_channel has already finished and ath11k_reg_update_chan_list()
will use the correct value of flags.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 6fae4e61ede7..f50740219202 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -55,6 +55,17 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ath11k_dbg(ar->ab, ATH11K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
 
+	if ((request->initiator == NL80211_REGDOM_SET_BY_DRIVER) &&
+	    (ar->state == ATH11K_STATE_ON)) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+			   "dynamically updated by driver\n");
+		ret = ath11k_reg_update_chan_list(ar, true);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to update channel list: %d\n", ret);
+
+		return;
+	}
+
 	/* Currently supporting only General User Hints. Cell base user
 	 * hints to be handled later.
 	 * Hints from other sources like Core, Beacons are not expected for
@@ -294,12 +305,6 @@ int ath11k_regd_update(struct ath11k *ar)
 	if (ret)
 		goto err;
 
-	if (ar->state == ATH11K_STATE_ON) {
-		ret = ath11k_reg_update_chan_list(ar, true);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
 err:
 	ath11k_warn(ab, "failed to perform regd update : %d\n", ret);
@@ -743,6 +748,7 @@ void ath11k_regd_update_work(struct work_struct *work)
 void ath11k_reg_init(struct ath11k *ar)
 {
 	ar->hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	ar->hw->wiphy->flags |= WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER;
 	ar->hw->wiphy->reg_notifier = ath11k_reg_notifier;
 }
 
-- 
2.31.1

