Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA296D2DC6
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 04:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjDACuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 22:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjDACuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 22:50:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEBF11E82
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 19:50:08 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3312NK1U021598;
        Sat, 1 Apr 2023 02:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5W3MYYqKTnUUsN/LGdJR8AHOs2iU7R0OVx/q3OmrBxw=;
 b=f+n1G1UccSWjATuk9f/Wm7kP1nWWs1FOWd40tMtVDOVIYVk5gQDLbz8DIrEB+Wb1vc/s
 Q128VqCCi4ZKZCRJ0ajdlsUBf1pgkbAMtgIkcjAsdAkuStwQLguhWhelXt4Wivg0/4Ae
 3+oNvOZzvnZ7+qRWO/795rknl1tVSzrJjrpVBuQ1nltCcJBljiFoPYXlgWxkEtLh/+07
 xpEFM8PY9GMh39wXwj3SOeWPPvLOlouYHfwJK6+Mp3noTB+BdB3Y4sU0gkhzsfnFeqVs
 zP/EtTrc6x9tqvLJEOolfkqijNSFsV7HvB5Wty7uGsoFaxSiL3QcdeNzMuPwl2VGxMb3 Mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pp29sseyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Apr 2023 02:50:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3312o13X019396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 02:50:01 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 31 Mar 2023 19:50:00 -0700
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH V2 0/2] wifi: ath11k: bug fixes in tx encap offload and ppdu stats
Date:   Fri, 31 Mar 2023 19:49:30 -0700
Message-ID: <20230401024932.11722-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Q0KJM8QizWnKg3kVJkOpxhEQdbeF1FI
X-Proofpoint-ORIG-GUID: 6Q0KJM8QizWnKg3kVJkOpxhEQdbeF1FI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=621 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304010023
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes bugs in radiotap fields and tx status reporting in TX
encapsulation offload cases.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Pradeep Kumar Chitrapu (2):
  wifi: ath11k: fix tx status reporting in encap offload mode
  wifi: ath11k: Fix incorrect update of radiotap fields

 drivers/net/wireless/ath/ath11k/dp.h     |  3 +++
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 29 +++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.h  |  1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c |  4 ++--
 drivers/net/wireless/ath/ath11k/hal_rx.h |  2 +-
 5 files changed, 35 insertions(+), 4 deletions(-)


base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.17.1

