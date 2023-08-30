Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566B078D1F0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjH3CHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 22:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbjH3CHi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 22:07:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBD1AD
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 19:07:35 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U1FNus001077;
        Wed, 30 Aug 2023 02:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=w/lNLWPJCUWjpYCP0FZyhe1O7ownFSGSc9kI8Y77gcY=;
 b=YCefNfYJgXSmTcEP4+EO0FVtMUAh4URzYkuCaTofZvBBVtYYrufsLTzAz4PnQTGWa11U
 0Po1xS6GokojUDQsR0g6tjScibjZXAKIO/1V+K/ftBwBzUWYAiJCUE8Dw0uy7AD2ASnP
 H7TJxrz+/5s/mmxe9yLfc9TKKbDRKKBzVxpvRBaPbkLs/dnfdG4SK1rSqX6Oq6WGVq0j
 8G8o8GP1+NcHCIY02EUPGloepkPasNdw2McCkfJKjq72eDx3bQr/iLkAHTaU9982iS5q
 rPGvgdk4uArVAYMvHUBDL6enSjjRranZciDyS+hiKb+PPxG233sbM89vt94KWeDtSEhG LQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss3fr3b3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 02:07:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U27TWY026705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 02:07:29 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 19:07:28 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: fix possible out-of-bound write in ath12k_wmi_ext_hal_reg_caps()
Date:   Wed, 30 Aug 2023 10:07:16 +0800
Message-ID: <20230830020716.5420-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uw39XZoZEKKKMJJ5Gn6QYZ1O2LpAeg32
X-Proofpoint-ORIG-GUID: uw39XZoZEKKKMJJ5Gn6QYZ1O2LpAeg32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=655
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

reg_cap.phy_id is extracted from WMI event and could be an unexpected value
in case some errors happen. As a result out-of-bound write may occur to
soc->hal_reg_cap. Fix it by validating reg_cap.phy_id before using it.

This is found during code review.

Compile tested only.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ef0f3cf35cfd..a8a7fa9f71cf 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3876,6 +3876,10 @@ static int ath12k_wmi_ext_hal_reg_caps(struct ath12k_base *soc,
 			ath12k_warn(soc, "failed to extract reg cap %d\n", i);
 			return ret;
 		}
+		if (reg_cap.phy_id >= MAX_RADIOS) {
+			ath12k_warn(soc, "unexpected phy id %u\n", reg_cap.phy_id);
+			return -EINVAL;
+		}
 		soc->hal_reg_cap[reg_cap.phy_id] = reg_cap;
 	}
 	return 0;

base-commit: a62b0aeb556839fb6abb9835874443b08fe95598
-- 
2.25.1

