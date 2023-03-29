Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703866CD614
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjC2JNA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjC2JM5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 05:12:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B215E10E
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 02:12:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9CiYU019165;
        Wed, 29 Mar 2023 09:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=rBzsJ2Fjt0lxg7MVtcSmTGPQazPHglu4/PSquNXVTGI=;
 b=S1LCVsA9U0j8X6/JEmRzbZ5I6o3y+CU2IWwkRJKMz/nu1snVpyk0QFn1MX3q+Ape++G8
 itbZwkJk7sipLJWq/byJUyVNVOdNQIYR7C0tiCaoBbZuEWvCD3IGZyvUVkPoJhXY4DOW
 D0KH00PF7rwJy7VBie1MYnbMwBPXYmNdQfpsMThb3oDOCHeEuTa1NUnzP4u++V13Rcic
 CJDP7D3iJ0SZjlt4LKlpv+x805Uh//nLkyXNQsAE1UnsHu1xNw7EimR3ms9m8IHMpbPl
 21SIOFYGRg3YWGq7idQc6D+LESTuZFtHIPY2uNKsZHznfHh/tEa+6KRFPMu0wufgaFly 6A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmbs88ugu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 09:12:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T9CqXh028929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 09:12:52 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 29 Mar 2023 02:12:49 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: fix data out of sync for channel list for reg update
Date:   Wed, 29 Mar 2023 05:12:32 -0400
Message-ID: <20230329091235.19500-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CgPrcZR3rxUeR93niKDqh_wgaRn9bnGJ
X-Proofpoint-GUID: CgPrcZR3rxUeR93niKDqh_wgaRn9bnGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=937 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290075
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently there are two threads to updating/fetch data of channel 
list, and there are no synchronization for the data, it leads data out 
of sync for channel list for reg update.

So change the call flow to make sure the fetch data running after the 
update data finished, then data of channel list become synchronization.

Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")

Wen Gong (2):
  wifi: ath11k: move update channel list from update reg worker to reg
    notifier
  wifi: ath11k: move udpate channel list to worker for wait flag

 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/core.h |   4 +
 drivers/net/wireless/ath/ath11k/mac.c  |  13 ++++
 drivers/net/wireless/ath/ath11k/reg.c  | 100 ++++++++++++++++---------
 drivers/net/wireless/ath/ath11k/reg.h  |   1 +
 drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
 6 files changed, 86 insertions(+), 34 deletions(-)


base-commit: 5aa9ff08c0b71be15a607341fa5344546e19ceb2
-- 
2.31.1

