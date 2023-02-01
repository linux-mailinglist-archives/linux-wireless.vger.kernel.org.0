Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3A686004
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBAG51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 01:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBAG51 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 01:57:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74D30E8
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 22:57:25 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114xTDV006599;
        Wed, 1 Feb 2023 06:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=76v1rIiywSV0o+p9SmRe3jtdlUq91efHCYJJqp+mTxY=;
 b=XNo5NDKjNG6hVafRhMOW+Qh3JiPaXshUo72rIMozV8yUAk02VyWcm82/IUd0ETxzxINs
 Z46qgnn0yWhkxZCQHHv8sdmBz/RS/4nI2P5siUys01NjVd/einnkSNuBc7fWhGoV8jmd
 fP96QPNdKemgVUcNpWT5We0Vq94s++x7/7taqQzPzjrfzLZEqcsIGKyA7jITYC2FnOhY
 qZHCDs0SaGPvBbBUIHAO538VI/6FGFuunoJmQKlyxrC9w/JT5wjgRNYYGVGRPpqv+NTa
 Lg1kU/mDzzb3RIJEoAtVRRUhPjrTQb+xdCvZwSjO//XYlGZB+y/6Pu/bIs0MYzEBxY9x Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nexn8jnv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:57:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3116vGNf026376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 06:57:16 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 22:57:14 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v3 0/3] wifi: Add support to enable/disable bss color collision detection
Date:   Wed, 1 Feb 2023 12:26:35 +0530
Message-ID: <20230201065638.25990-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ooQhdnNXGNT2a87N2a_L-svzTwB2ozf4
X-Proofpoint-ORIG-GUID: ooQhdnNXGNT2a87N2a_L-svzTwB2ozf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=592 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds configuration option to Enable/Disable 802.11ax BSS
color collision detection.

Changes since v2:
- Updated wifi prefix

Changes since v1:
- Split nl80211 patch(patch 1/2 on v1) to two patches.

Rameshkumar Sundaram (3):
  wifi: cfg80211: add support to enable/disable bss color collision
    detection
  wifi: mac80211: Avoid BSS color collision detection if its disabled
  wifi: ath11k: add support to enable/disable BSS color collision
    detection

 drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
 include/net/cfg80211.h                | 2 ++
 include/uapi/linux/nl80211.h          | 3 +++
 net/mac80211/rx.c                     | 3 ++-
 net/wireless/nl80211.c                | 3 +++
 5 files changed, 14 insertions(+), 2 deletions(-)


base-commit: 4ca69027691a0039279b64cfa0aa511d9c9fde59
-- 
2.17.1

