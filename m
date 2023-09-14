Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1479FFA9
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjINJJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbjINJIt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 05:08:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF383584
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 02:08:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E7sb4j007867;
        Thu, 14 Sep 2023 09:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=eZ1ib4AcYbH+yG2b+X4LpEAJJzSFbX7AX1tg7HNj/Mg=;
 b=W27WYenUNNuNphfWKw9uyx7ep2afe5uNEwxsxj8As3uBjkuN1uvWYOMm1roBYfq8xg16
 U8JjPn9/x4/92A5C00MPIE93DfKePHnvwsMQhU1kbNFm3a469sEwWBlRnBeNc11PF8e0
 z2KxcwyApmkV0D6h/5Ake6pQ/FuMutDymgcAg86MrZOuRYMzrrhRgaSNv+iCuoh9ns13
 CCk1RYcdbkhUomQOTh26dUs44m7bmV+ZBkn4I95K6AAbGM7bYuffNO+5CBMC3oRZfcjU
 bbc3lgYpBqiI/25lbxxuyY1GN3/lDYv+MGPkX6QNFb5Doj99MdOpFD5+nP7vS6UC6W32 wQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3x6mr5y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 09:08:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E984NX018133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 09:08:04 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 02:08:03 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
Date:   Thu, 14 Sep 2023 05:07:42 -0400
Message-ID: <20230914090746.23560-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NUOOu6JXmfyc98ezbHi1Y12YAbo6ctiH
X-Proofpoint-ORIG-GUID: NUOOu6JXmfyc98ezbHi1Y12YAbo6ctiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=695 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140078
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2: change per Jeff.
    1. change alpha2 length from 3 to 2.
    2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.

Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID which is needed for 
11d scan offload to firmware. And add support for 11d scan offload for 
WCN7850.

Also fix firmware crash for country code set for WCN7850 and store country
code for device recovery for WCN7850.

Wen Gong (4):
  wifi: ath12k: add configure country code for WCN7850
  wifi: ath12k: add 11d scan offload support
  wifi: ath12k: avoid firmware crash when reg set for WCN7850
  wifi: ath12k: store and send country code to firmware after recovery

 drivers/net/wireless/ath/ath12k/core.c |  36 ++++-
 drivers/net/wireless/ath/ath12k/core.h |  17 +++
 drivers/net/wireless/ath/ath12k/hw.c   |   3 +
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 178 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   7 +
 drivers/net/wireless/ath/ath12k/reg.c  |  67 ++++++++--
 drivers/net/wireless/ath/ath12k/reg.h  |   3 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 159 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
 10 files changed, 489 insertions(+), 20 deletions(-)


base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

