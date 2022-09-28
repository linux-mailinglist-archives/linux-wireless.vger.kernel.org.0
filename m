Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0125ED76D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiI1IPl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiI1IOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:14:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F277A260B
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:14:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5XP2b012413;
        Wed, 28 Sep 2022 08:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Q1iHjZ27nnbdTmkae/B1TUP+c75TPKX6ACNPufstok0=;
 b=MwELVL+J1TSsvyUQFNgA2EMwwEF8Ry+NODnvjcc8+CklRXZiF2BJOnK7kr3JzpXDUjjb
 AISNNf0J9rN6OtWdpnKRYn69fvRpWEQanQTDCLR/aO6YAW8wXM+HZ4T+F93Bld0/HWbz
 jB6mlJgL1IKrfE+yX/wOZlKlwjtCIbORX82Fud2+z4MJ4E7NumESJDol2c//GxAsNiIc
 dvJyEstL7mpWy85HMIb2HISytCrH4aVUJN6EpE6aaG9ouMHhefNOI4RC5/DYvnBO85na
 9BUgjrxFDjJ2xaT26Mhe8UshlVmsEITF2pgW0mgBFtaVf7rNY+7xusUFz9edtqWVhRGP Tg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jv28a3dk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:14:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28S8EVds024766
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:14:31 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 01:14:30 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath11k: reduce the timeout value for hw scan
Date:   Wed, 28 Sep 2022 04:14:11 -0400
Message-ID: <20220928081413.27339-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cERUvsyD_1yFqhrUHD2r5W9_zPhPpyay
X-Proofpoint-GUID: cERUvsyD_1yFqhrUHD2r5W9_zPhPpyay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_03,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=566
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2: 
add "wifi: ath11k: change to set 11d state instead of start 11d scan while disconnect"

Reduce the max timeout for hw scan started.

Wen Gong (2):
  wifi: ath11k: change to set 11d state instead of start 11d scan while
    disconnect
  wifi: ath11k: reduce the timeout value back for hw scan from 10
    seconds to 1 second

 drivers/net/wireless/ath/ath11k/mac.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)


base-commit: c6d18be90f9b0c7fb64c6138b51c49151140fb57
-- 
2.31.1

