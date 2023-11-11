Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74A17E893D
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 05:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjKKEkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 23:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjKKEj7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 23:39:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0781BD
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 20:39:55 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB4dqhR014398;
        Sat, 11 Nov 2023 04:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NF1psM1ph7nkvGvJobxjjWwwmINSyvaEpcj/51y76ns=;
 b=cgqt6tOVS+3Zpp/yAYDCaP4deAqch+7v/ar8jQvFC0x3wN0vHzpk/feHlYAKPI1a7sQo
 5kvPi9Vq2THLsSXVQVEYDSx92UPn+cgqobafxZqATXkIAfS6UTGUnUazEr4p7j2dCOAi
 qAYk1EFKl+X+A7oYze2iod/zVc+ESGkRANvM7QMDi5PWJeIm/UkZzeaH/jYSKxazwGdd
 AERDi6m/LOQ/Jpi0S6H64E7ehy+uRztL3a5IR9qDMvUEhLfJ6ovIs+2Lrn/AYJmLi3Q6
 PKJb4Hc8TwmgaAstAZM7fYbWUpwgtdoKxFI/bl5dbVoY+Q2x0q+iVUn7z5yE7jK2r+ab 5w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2cnr101-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 04:39:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AB4dpdK004696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 04:39:51 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 20:39:49 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/4] ath12k: Refactor Rxdma replenish arguments
Date:   Sat, 11 Nov 2023 10:09:30 +0530
Message-ID: <20231111043934.20485-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bYDVgwaat5owJgR5cxM0-7QdECHDJhGl
X-Proofpoint-ORIG-GUID: bYDVgwaat5owJgR5cxM0-7QdECHDJhGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=3 adultscore=0 spamscore=3
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=156 bulkscore=0 clxscore=1015 mlxscore=3
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311110036
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid the explicit arguments of Rxdma replenish to optimize the per packet
rx data path CPU cycles. Also refactor the Rxdma ring structure.

Karthikeyan Periyasamy (4):
  wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
  wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
  wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
  wifi: ath12k: refactor DP Rxdma ring structure

v2:
  - Changed the copyright year

 drivers/net/wireless/ath/ath12k/dp.c     |   6 +-
 drivers/net/wireless/ath/ath12k/dp.h     |  13 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  12 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 145 ++++++++++-------------
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   8 +-
 6 files changed, 82 insertions(+), 106 deletions(-)


base-commit: 553d0057523dc1d6935160613f1fbf9bb8db88f6
-- 
2.17.1

