Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3806F683E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEDJYM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjEDJYK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 05:24:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F1C49C3
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 02:24:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3449NhWK001438;
        Thu, 4 May 2023 09:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=U1zMZzPrvGfv84Zps+Dnkr3c9elj2CUX/+Piidq2f90=;
 b=lonVkg+WcQYwhhTSNs2QEMd88mC8eZkn8OwDxG/0WakJnpJNfFAmcgaKn4z32R4hT4+Z
 VKR9VV8vGLYNNILHa6yd5L8kQkrCP0l8bd6PnGWmlVdRIUSIEda2dXx25fFdoi1Dei3I
 d8HNf5E//dpBBMnSlu6suzbN2nR7ZLrfncQMthnqUsYlyVosiRoRkguz9T+cQ4VjYMeE
 oR80fQ4ICTpzPKtw1wbWbO4xExkgPXmu5g7BDhD10y7f7sVs1My9+S9qPRWp9oaSq4vc
 bVwMPKHMtLhbDno+X1IscSVkZczNGlcrdPYRa1xWQKOWof62DejK7P5b86bjd4Lm+OYs xw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbvghhffq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:24:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3449O7vq031474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 09:24:07 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 May 2023 02:24:05 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH 0/2] ath11k: Send HT fixed rate in WMI peer fixed param
Date:   Thu, 4 May 2023 14:53:49 +0530
Message-ID: <20230504092349.3542530-1-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iCMkK-13YkoM-rtU2E5EN3luBUmq-ukA
X-Proofpoint-GUID: iCMkK-13YkoM-rtU2E5EN3luBUmq-ukA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305040076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Due to the firmware behavior with HT fixed rate setting,
HT fixed rate MCS with NSS > 1 are treated as NSS = 1
HT rates in the firmware and enables the HT fixed rate of
NSS = 1.

This leads to HT fixed rate is always configured for NSS = 1
even though the user sets NSS = 2 or > 1 HT fixed MCS in the
set bitrate command.

Currently HT fixed MCS is sent via WMI peer assoc command.
Fix this issue, by sending the HT fixed rate MCS in WMI peer
fixed param instead of sending in peer assoc command.

Maharaja Kennadyrajan (2):
  ath11k: Relocate the func ath11k_mac_bitrate_mask_num_ht_rates() and
    change hweight16 to hweight8
  ath11k: Send HT fixed rate in WMI peer fixed param

 drivers/net/wireless/ath/ath11k/mac.c | 93 ++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 17 deletions(-)

-- 
2.25.1

