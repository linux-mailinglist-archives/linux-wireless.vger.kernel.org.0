Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971D37829DD
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjHUND5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjHUND4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 09:03:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D259AB1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 06:03:54 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LCSbvS030682;
        Mon, 21 Aug 2023 13:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=yQe8WMB1y9pSJCfE+451M1ow9CxbYqQiMaULmvgv8bA=;
 b=fJqf4HNXud4PgDe7wrjTc1Ux9fKE9QuXjVr+koqVQ98jnodK9IIY1NgpovM2kIaJZZx0
 LQ3wbb6DLl8p5RlPqjIKFpwFQcMrzGBwiBhaBIVXdavJX+htwiaZYJsR/dsl+m5JvWAB
 xv62ACXseYew3OgQknbxCAVpTlGieJ2f83RSA306ph8KfN3t23/eJj9V81tWXb+Sg0Uq
 Lm0xb44hNu+gQRGgGxlugCESVcapHmA8fqOh+q7RSqYzN1ePXLa95UgCLtOrZfsAGyb6
 Oy3S9EaAiuEcXqVJJ6LpFs2rkVZWV3+yja8qqubpoQWKvDXPX8hC9v2AFb9QPU5GEYOy kw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm7jdg3wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 13:03:48 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37LCrm3O007264;
        Mon, 21 Aug 2023 13:03:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 3skytw4xp7-1;
        Mon, 21 Aug 2023 13:03:47 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LD3lKD021205;
        Mon, 21 Aug 2023 13:03:47 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 37LD3kkU021201;
        Mon, 21 Aug 2023 13:03:47 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 97049B003A3; Mon, 21 Aug 2023 18:33:45 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Ignore fragments from uninitialized peer 
Date:   Mon, 21 Aug 2023 18:33:41 +0530
Message-Id: <20230821130343.29495-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cav9WVtr-a2A8uC-QwKbMlQuzecw2-XX
X-Proofpoint-ORIG-GUID: Cav9WVtr-a2A8uC-QwKbMlQuzecw2-XX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=702
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210120
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When max virtual ap interfaces are configured in all the bands
with ACS and hostapd restart is done every 60s,
a crash is observed at random times in dp_rx path.

This patch series handles the following:
    1. Ignore the fragments of the peer which does not have its
       datapath initialized.
    2. Fix the undefined behavior of __fls which was found during
       this crash.

---
  v2: updated commit messages as per review comments from
      Johannes and Jeff
---

Harshitha Prem (2):
  wifi: ath12k: Ignore fragments from uninitialized peer in  dp
  wifi: ath12k: fix undefined behavior with __fls in dp

 drivers/net/wireless/ath/ath12k/dp.c    |  1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c | 11 ++++++++++-
 drivers/net/wireless/ath/ath12k/peer.h  |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)


base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.17.1

