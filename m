Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F807DB514
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJ3I2T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3I2R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 04:28:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A6A7
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 01:28:14 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U5qRvl018071;
        Mon, 30 Oct 2023 08:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=1224riGAY2pl3uI1iYhXwTc6iUN5iq+Jta9Y0ikdI3g=;
 b=fQXLQ2OMAaNTORJi0wEe2vtJJatneCoM0qwsjC86PBatpzJOf8aHYHjzwrJUyQkEHxRk
 zWrdeZvJMhflf88U7/32D91aYo+JenIZA6N0ca0aBr1U3O78G9OWXoMc/6TJiR1MOYHd
 Lf9C0UwILjOxUj5ftOyUGDfiiPIrx3ER98s0auzqnME+sByMNeQc1VSq/rn6ZoD1Cs43
 cwgYfs/GKFOrt0nOav4CjmG0tJq0EvSVkfu/CzvCZbZ5Ay3NrPMVUPcmY1pJckrkTK26
 i6RBh0mHFomrmSP3Q2pXy7UwEyXK2O08Q33evU7u81Ie0Wb+k1ku5wGYHRc7tsFb3bXF Yg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0qnuuhya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 08:28:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U8SA1S010966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 08:28:10 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 01:28:07 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH 0/4] ath12k: Factory test mode support
Date:   Mon, 30 Oct 2023 13:57:45 +0530
Message-ID: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9DWX8vR6rA1GXU7cdGXWPH-a5tkfL5vK
X-Proofpoint-GUID: 9DWX8vR6rA1GXU7cdGXWPH-a5tkfL5vK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=944 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Device is booted in factory test mode for calibration.
The commands are sent from userspace application, which
is sent to firmware using wmi commands. Firmware sends
the response to driver as wmi events and driver sends
these events to the application via netlink message.

Also added changes related to correct pdev id access for
fw test cmd.

Aaradhana Sahu (3):
  wifi: ath: create common testmode_i.h file for ath drivers
  wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
  wifi: ath12k: add factory test mode support

Rajat Soni (1):
  wifi: ath12k: Fill pdev id for fw test cmd

 drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/core.c        |  19 +-
 drivers/net/wireless/ath/ath12k/core.h        |  13 +
 drivers/net/wireless/ath/ath12k/debug.h       |   1 +
 drivers/net/wireless/ath/ath12k/dp.c          |   3 +
 drivers/net/wireless/ath/ath12k/mac.c         |  13 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   1 +
 drivers/net/wireless/ath/ath12k/testmode.c    | 413 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/testmode.h    |  42 ++
 drivers/net/wireless/ath/ath12k/wmi.c         |  38 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |  22 +-
 .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
 13 files changed, 624 insertions(+), 72 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)


base-commit: 0263687f4441d5a5eab8074d56b4693c8f0acf85
-- 
2.17.1

