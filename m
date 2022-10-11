Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5F5FAD65
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJKHY6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJKHY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:24:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92042140BA
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:24:55 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B7DJ7E002297;
        Tue, 11 Oct 2022 07:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=I2KOBFFNummN2yYwexN9QcGc9ucCqI7BM68vKmqXJCg=;
 b=MoV8mHkC3SUOPPtLSetWC9rd7tfNsmZrq23NFcYOtw+abk0uY8dDExyQWfwEtBE+oPyd
 g6SHGmKXBbVT8ic7BiK3uTZNz3Q/CvzoAvCpqCF/S6D/ofXrwybjfcAG0FzZ8HNwj1Nj
 onH90zD6pw/Hz+mRsqxjqL5gOxmhI9S2xKnJl2R6oE2RfvCq9Fi2007etIVtQgHS9j2/
 PU3FnlupNuUiuXpit++M9q+AbnWSrRHUwy2/HxfKEb02DQvxHx4LQ9lW7d1A6L6DTkX/
 y4EZ78IKCLh1HjlP1kY0E4LSk4aPkxAhlX048Bi642gXcoQQV6tBCeQIKsWJEHp2HOAH 4g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx19fbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:24:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B7OgAx031122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:24:42 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 11 Oct 2022 00:24:41 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath11k: reduce the timeout value for hw scan
Date:   Tue, 11 Oct 2022 03:24:06 -0400
Message-ID: <20221011072408.23731-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S2cg6KYt7x5ZMM7HYwXngE84amHlbM3j
X-Proofpoint-GUID: S2cg6KYt7x5ZMM7HYwXngE84amHlbM3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=650 clxscore=1015 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v3:
change code and log of "wifi: ath11k: reduce the timeout value back for hw scan from 10 seconds to 1 second"
to handle the "failed to start hw scan: -110" correctly.

v2:
add "wifi: ath11k: change to set 11d state instead of start 11d scan while disconnect"

Reduce the max timeout for hw scan started.

Wen Gong (2):
  wifi: ath11k: change to set 11d state instead of start 11d scan while
    disconnect
  wifi: ath11k: reduce the timeout value back for hw scan from 10
    seconds to 1 second

 drivers/net/wireless/ath/ath11k/mac.c | 28 +++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)


base-commit: c6d18be90f9b0c7fb64c6138b51c49151140fb57
-- 
2.31.1

