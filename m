Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9064CC8B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiLNOoF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 09:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiLNOoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 09:44:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6032E66
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 06:44:01 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEE5klj019528;
        Wed, 14 Dec 2022 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EAmFcBuQ6nWSaRR7eUJIid/0GgI8maiIz4OkRd1pkfE=;
 b=bKjnC6uYEfjp5OCyzVgNl/aJ/wAIYpYRcl2kQn5mHrHRejqE+Gqgbe8iqLKdQDCgZlNM
 w4+8mvO2ND2oimRinwiHO/4nemiNJcNlqhgFYSgBuvk+ex24ozf4yFQoC4B7nDheSZ6s
 y5KtjCi5Jej3WgyS/Ah6g9pqOKCr/euqMgObFMTSHidxWUlG8Jr4oITTKqsbdxZByeeJ
 bgUikhsVYmtELFskjer9gOF9VUFBalGzXGYb3i1Y/agFnUjklaVExaB1KI5xPyaaEEg7
 m8ZcS306YZ7YygHOJIWGHC1XlIcEtyfsl7TJTbXzxvoyC8cRjFAVt/Xs9pK9iWNImltx ig== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rehe14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 14:43:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEEhnZc001534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 14:43:49 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 06:43:47 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 0/3] wifi: ath11k: add support to parse new WMI event for 6 GHz
Date:   Wed, 14 Dec 2022 20:13:31 +0530
Message-ID: <20221214144334.13812-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ePO-sFZ1evr1CkQ8KuvRL-3dyOUXy3vc
X-Proofpoint-GUID: ePO-sFZ1evr1CkQ8KuvRL-3dyOUXy3vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=936 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212140117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 In order to support different power levels of 6 GHz AP and client,
 new WMI event for regulatory - WMI_REG_CHAN_LIST_CC_EXT_EVENTID is
 added in firmware. This event provides new parameters required for
 6 GHz regulatory rules.

 Firmware advertises its capability of handling new event in WMI
 service ready event. Based on that, host needs to set
 host_service_flags in WMI init command to indicate that host supports
 processing of new WMI event. Based on advertised host capability,
 firmware decides to send old event WMI_REG_CHAN_LIST_CC_EVENTID or
 new event WMI_REG_CHAN_LIST_CC_EXT_EVENTID.

 Add support for parsing 2.4 GHz, 5 GHz and 6 GHz reg rules and other
 parameters from WMI_REG_CHAN_LIST_CC_EXT_EVENTID.

Aditya Kumar Singh (3):
  wifi: ath11k: use proper regulatory reference for bands
  wifi: ath11k: add support to parse new WMI event for 6 GHz
  wifi: ath11k: add debug prints in regulatory WMI event processing

---
 drivers/net/wireless/ath/ath11k/reg.c |  58 ++-
 drivers/net/wireless/ath/ath11k/wmi.c | 573 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h | 332 +++++++++++++--
 3 files changed, 874 insertions(+), 89 deletions(-)


base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
-- 
2.17.1

