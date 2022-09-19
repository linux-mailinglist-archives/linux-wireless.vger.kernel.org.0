Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C065BC174
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 04:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiISCln (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 22:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISClm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 22:41:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD413F9F
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 19:41:41 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J106Je014975;
        Mon, 19 Sep 2022 02:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=0EJFaAwrnby/NH3jt3OY6cQTpc8wcIkiGSrgk1uminc=;
 b=BO0u+V8AC6LY4POX5OywXqI+5cfHJEBemfhO69YGmjWTcRhmd1S6Wgja6oahlsIFjK78
 ONnoWxywFJFYLteC2BaHyfdzbUuWq4N2mAP4syhzxmb+3nV5v4MVqX8TPMCdmyrYNTbe
 5ZszKNl+Zn1OpDFXw5LwQ/5el40iPm5PRzeVmaMkojU/dxQFEwp4adhXmc6qSFwbFF5r
 ZzL60td8hUEzI9tQDK7Za6UGizhO/rh+S5g3H/qKwYuMz+TFeYN4kyGTRmn2mTu1FQNp
 nJvtG1uuN+8Y0f7SrRAO/WpthBIw9p+0ND7LQIEbrMYCfh+fwK+wUDa/lvxO2av03yHF nQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6f8337x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 02:41:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28J2fZOU002062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 02:41:35 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 18 Sep 2022 19:41:34 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath11k: reduce the timeout value back for hw scan from 10 seconds to 1 second
Date:   Sun, 18 Sep 2022 22:41:21 -0400
Message-ID: <20220919024121.24820-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k1kcrfnBlTDOYex1PIAvl5PIGBAeSNwm
X-Proofpoint-ORIG-GUID: k1kcrfnBlTDOYex1PIAvl5PIGBAeSNwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_01,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190017
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For 11d scan, commit 9dcf6808b253 ("ath11k: add 11d scan offload support")
increased the timeout from one second to max 10 seconds when 11d scan
offload enabled and 6 GHz enabled, it is reasonable for the commit, it
is because the first 11d scan request is sent to firmware before the
first hw scan request after wlan load, then the hw scan started event
will reported from firmware after the 11d scan finished, it needs about
6 seconds when 6 GHz enabled, so increased it from one second to 10
seconds in the commit to avoid timed out for hw scan started. Then
another commit 1f682dc9fb37 ("ath11k: reduce the wait time of 11d scan
and hw scan while add interface") change the sequence of the first 11d
scan and hw scan, then ath11k will receive the hw scan started event
from firmware immediately for the first hw scan, thus ath11k does not
need set the timeout value to max 10 seconds again, and this is to set
the timeout value back from 10 seconds to 1 second.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4218211afa30..8a6dd4b04176 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3560,7 +3560,6 @@ static int ath11k_start_scan(struct ath11k *ar,
 			     struct scan_req_params *arg)
 {
 	int ret;
-	unsigned long timeout = 1 * HZ;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -3571,14 +3570,7 @@ static int ath11k_start_scan(struct ath11k *ar,
 	if (ret)
 		return ret;
 
-	if (test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map)) {
-		timeout = 5 * HZ;
-
-		if (ar->supports_6ghz)
-			timeout += 5 * HZ;
-	}
-
-	ret = wait_for_completion_timeout(&ar->scan.started, timeout);
+	ret = wait_for_completion_timeout(&ar->scan.started, 1 * HZ);
 	if (ret == 0) {
 		ret = ath11k_scan_stop(ar);
 		if (ret)

base-commit: c6d18be90f9b0c7fb64c6138b51c49151140fb57
-- 
2.31.1

