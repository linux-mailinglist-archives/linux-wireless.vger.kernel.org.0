Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB825A4C89
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 14:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiH2MzC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiH2Myd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 08:54:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460091093;
        Mon, 29 Aug 2022 05:44:01 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T8dT7I003396;
        Mon, 29 Aug 2022 12:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Jo31vLlbUctrQVF1f986Wlcc9jNBj7EkWo68l9qM/Fs=;
 b=Rm3txSUMbrY2OXnjt5AB1Qh/AMlvQC7mqEf32aLcLgSz3hNCBh6DMAKYyYyd9nDWcxVN
 QmWXaUcQizQabwNsmZh/OFdFLwjmgSVINjGKRe15qIxhGuKgKxeVSU9c6fpSb2Jlzvab
 U1ISNGtX6hFxQpMRylVsaHs70Tk2BEcgXGdeJC26ytBV2ZAWXmDQZtp3KnrY6bufY9N6
 +6XP3fB2v7EkNaEXrf1LzllJgEdzQWrLLs/X6zp7eDGegE9KNNIcbQVjdPWIIRT5tNY2
 PBZLO4NjHS3xfHTxd+0aP7IB7hpps1yznMRYpZooZO+oEoiXw2rMMQWKV3dZcpGqMh9q gQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j8t1b0m40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 12:43:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27TChiWo028834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 12:43:44 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 29 Aug 2022 05:43:41 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 0/2] Add WoW support for WCN6750
Date:   Mon, 29 Aug 2022 18:13:21 +0530
Message-ID: <20220829124323.26874-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aFj98tMPSexHccKuhBm-HSx8YCGzsQx4
X-Proofpoint-ORIG-GUID: aFj98tMPSexHccKuhBm-HSx8YCGzsQx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208290059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add WoW support for WCN6750.

Unlike other chips where WoW exit happens after sending WoW wakeup
WMI command, exit from WoW suspend in the case of WCN6750 happens
upon sending a WoW exit SMP2P (Shared memory point to point) message
to the firmware.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Manikanta Pubbisetty (2):
  dt: bindings: net: add bindings to add WoW support for WCN6750
  ath11k: Add WoW support for WCN6750
---
V2:
- Replaced shift/mask operation with u32_encode_bits() before sending SMP2P message
- Rebased on ToT COMMIT SHA-ID: f60b230094cbf88c73808709e4f9c1cf09eb0b01

 .../bindings/net/wireless/qcom,ath11k.yaml    |  17 +++
 drivers/net/wireless/ath/ath11k/ahb.c         | 123 +++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h         |  16 +++
 drivers/net/wireless/ath/ath11k/core.c        |   7 +
 drivers/net/wireless/ath/ath11k/hw.h          |   1 +
 drivers/net/wireless/ath/ath11k/pcic.c        |  32 +++++
 drivers/net/wireless/ath/ath11k/pcic.h        |   4 +
 drivers/net/wireless/ath/ath11k/wow.c         |   8 ++
 8 files changed, 207 insertions(+), 1 deletion(-)

-- 
2.37.1

