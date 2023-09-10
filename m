Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98759799D0C
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Sep 2023 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346483AbjIJI2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Sep 2023 04:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJI2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Sep 2023 04:28:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2D918F
        for <linux-wireless@vger.kernel.org>; Sun, 10 Sep 2023 01:28:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38A8QtEN029456;
        Sun, 10 Sep 2023 08:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=SJu6xWRLmRKtH+eWKqYLUH8qK3tbM3UBoz/ZYGCv9fA=;
 b=grhel92YSJusy+2JFSa0vpKDjRxvs5aHzdjU7ONSo9b7SL3FbHf+DAkXWaA4nRLwrpcW
 B65Hp+wla/+F0SvL+dF1HuYLgEfz1rmLJMWr2TK/dzpke//rD79HQ0+i8Ua5+RlKc1+N
 gkFcXFuso6ijjNP0aevzNps7YYpAO3gcajvdRSw4ijKqBXZPkzSo4pEBIa3BXlAu6aEC
 CLM8r4wE13Fb6rzHwyGwFgeM6WebcuZvwLwXbui+lMFpuaXdCBLs9MUJzeZr9zcaqnhr
 eLm69ewRzBjFgKsx/GcPfQ84s6uRD2Oo0Zf/rT1ZR0M/ex0vNr4Blm8RGopCPIlrUaan lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0hfqhgvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 08:28:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38A8SNJI006827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 08:28:23 GMT
Received: from lingbok-HP-EliteBook-8460p.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 10 Sep 2023 01:28:21 -0700
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 0/4] wifi: ath12k: implement some functionalities through reading ACPI Table
Date:   Sun, 10 Sep 2023 16:27:58 +0800
Message-ID: <20230910082802.9198-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xzd4-ntkT7x37FPwCazEI8CmFDD0IrXZ
X-Proofpoint-GUID: Xzd4-ntkT7x37FPwCazEI8CmFDD0IrXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-10_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=636 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309100073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Through reading ACPI table, implement Time-Average-SAR(TAS), BIOS SAR,
configuration of CCA threshold and band edge channel power functionalities.

v4:
1.revise commit log using imperative voice
2.delete guid_is_null()

v3:
1.remove unnecessary cpu_to_le32()
2.adjust the order of the macros
3.apply jeff's advice

v2:
1.put <linux/acpi.h> in the include guard

Lingbo Kong (4):
  wifi: ath12k: add TAS capability for WCN7850
  wifi: ath12k: add BIOS SAR capability for WCN7850
  wifi: ath12k: add adjust configuration of CCA threshold value for
    WCN7850
  wifi: ath12k: add set band edge channel power for WCN7850

 drivers/net/wireless/ath/ath12k/Makefile |   3 +-
 drivers/net/wireless/ath/ath12k/acpi.c   | 365 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h   |  60 ++++
 drivers/net/wireless/ath/ath12k/core.c   |   6 +
 drivers/net/wireless/ath/ath12k/core.h   |  13 +
 drivers/net/wireless/ath/ath12k/hw.c     |  10 +
 drivers/net/wireless/ath/ath12k/hw.h     |   4 +-
 drivers/net/wireless/ath/ath12k/pci.c    |   6 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 252 ++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  47 ++-
 10 files changed, 763 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h


base-commit: 1b5b69a51bb4909844e4003920af09ca1cc6bb0e
-- 
2.34.1

