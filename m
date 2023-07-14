Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07866752F7B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 04:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjGNCic (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 22:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjGNCia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 22:38:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081582D6D
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 19:38:24 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E2IWmT016541;
        Fri, 14 Jul 2023 02:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=wqMn92bwDisnJAEhkyL7ZVF3DoytD+Rl1x6mpcpBkBE=;
 b=lmfG+jsFDCdYVV9MJ/lL3bOQ8NX7yZWV8Z88peMNCbXVOM0shJAFeGh8q7HWLwm8tUvf
 zATv7zZNpykw/1aHrOvJW1peYPR1mY+0DkGDALDygh/pS+zI8tx5xDHcS0hT5iE346kg
 GbRCJjv++fmpvz+6TuzBv3Wy+O0vntCoQ8+ut2EirU20aR9VAJvuTy53d/0j85FTEf79
 eX5pqCefHU4LjPk176YcFwe3Q8872opbD/rK8xRVVwsgcB/+0LFYNBsjir//gDnzh9Ko
 f0jWD2hEL4k9KhHbPE8uNbI5H1ePXDyCXRyAYOLu4DKw807+kiQDZedgxpgUuRUkx6mv EA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpts0p1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 02:38:17 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E2cH3G005887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 02:38:17 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 19:38:15 -0700
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: support 2 station interfaces
Date:   Fri, 14 Jul 2023 10:37:59 +0800
Message-ID: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IIT3c9cP7aBpMoDj5c0YlpzIKlaqz6Xz
X-Proofpoint-ORIG-GUID: IIT3c9cP7aBpMoDj5c0YlpzIKlaqz6Xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=586
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It reports 2 station interfaces and 1 AP interface and mesh interface to
upper layer if chip allows.

Report address list to upper layer for such chips. 

Carl Huang (2):
  wifi: ath11k: supports 2 station interfaces
  wifi: ath11k: reports address list if chip supports 2 stations

 drivers/net/wireless/ath/ath11k/core.c | 14 +++-
 drivers/net/wireless/ath/ath11k/hw.c   |  2 +-
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 88 ++++++++++++++++++++------
 4 files changed, 81 insertions(+), 24 deletions(-)


base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
-- 
2.34.1

