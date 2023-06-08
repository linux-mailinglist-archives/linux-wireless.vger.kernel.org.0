Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A55727835
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 09:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjFHHIj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjFHHIi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 03:08:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4704B2694
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 00:08:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3584k6F9028168;
        Thu, 8 Jun 2023 07:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=SkAOiS0krWaUnd3fysrk308RWuoAvv04xv/9Jaqy5Qo=;
 b=MqPmH8K0qO+7lgITj4EjtDyfPTa2F7mPGO5z6KLfstQMUfMXMsDolL3zue0rm5AOakQs
 gHIYM7XAbWXslPm+YWHTUIFbhBSxtGSunzoooOA52JASByLRbUeXreu8O8eDJR5oNiVG
 ak1Jx0jz/fXWzjHy5mbB/cmRgbAIBigPFBKk5YlLtu6rUJE6nc7qFNdHGdr3Ak2Kdzbk
 at5gNlu4T4O9Brlfh3TmHPy6LP2YRvjdPn2txeJRqAqBerNXjmiBUchoZVyyRwvlhnVd
 rKB59JiePbbDI5GAGPqvgzINVLcO96eTEvmZSiEtywdmL7Lz+eLie0UflRF44mbIwxyj 3A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r33uygk7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 07:08:18 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35878HLS022163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 07:08:17 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 00:08:16 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH v2 0/3] Enable TKIP when using encapsulation offloading
Date:   Thu, 8 Jun 2023 12:37:51 +0530
Message-ID: <20230608070754.7161-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uda-LFsA09y8hzPHzuNsWUWEr2Er3aY8
X-Proofpoint-ORIG-GUID: uda-LFsA09y8hzPHzuNsWUWEr2Er3aY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=553
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TKIP was disabled on encap offload mode since if TKIP MIC error
reporting is not capable by the driver using encap offload mode,
then TKIP countermeasures would not work.

Enabling back TKIP bring-up in encap offload mode to leave the
control with the driver to disable hw encap when it is not capable
of TKIP MIC error reporting.

Sathishkumar Muruganandam (2):
  wifi: mac80211: Fix tkip encrypted packet transmission path
  wifi: ath11k: add 802.3 undecap support to fix TKIP MIC error
    reporting

Thiraviyam Mariyappan (1):
  wifi: ath11k: Fix tkip encryption traffic failure

---
v2:
 -Send to ath11k mail list.
---

 drivers/net/wireless/ath/ath11k/core.h  |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 54 ++++++++++++++++++++++---
 net/mac80211/tx.c                       |  3 +-
 3 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.17.1

