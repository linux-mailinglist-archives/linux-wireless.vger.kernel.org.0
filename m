Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61237C84C2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 13:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjJMLoz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjJMLoy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 07:44:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E663AB7
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 04:44:52 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DBZjoh024365;
        Fri, 13 Oct 2023 11:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=skxm0gwkNJrU8mIYIxdP+vhqHG5evVTTxNfvWfaVd/0=;
 b=D3by6f+ImqpoNiGLUbgCMk5kmZo8E14ljDigjNjBisVlWdJyNyKQbaK+7TuzAk/mUbTe
 WR1xeBjiwWiQOtnC3or7JdPS2eJEY/aIA3Jy3qIcktParqkhIIji+LEw4nhikTKK/jkF
 sVJHYrQc7aANuZ2h8zXbDIEgP3kcby5k+cyDFEKxsVVD47kNugGHh86jzWIlkCgh0KfV
 t1wyA/zbVhIkI/RXxNx1tOMqr2+arg5FPAajLhN/pbwvW5FChPA3gUhNBGSZgWt0m7cp
 DMSY3zCozOAGmPnN/I93/brHc6cgbyN78l3rmOjpFgVGSeCB60swjowAVljDLkW9VrRb nQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tq2sr8b5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:44:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DBik43015892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:44:46 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 04:44:45 -0700
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v7 0/4] wifi: ath12k: implement some functionalities through reading ACPI Table
Date:   Fri, 13 Oct 2023 07:44:30 -0400
Message-ID: <20231013114434.81648-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ASDV55XMPMy7gm6sMPBmUe-WQBmXB9RD
X-Proofpoint-ORIG-GUID: ASDV55XMPMy7gm6sMPBmUe-WQBmXB9RD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=578 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130096
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

v7:
1.adjust the length of line
2.add cpu_to_le32()

v6:
1.remove code that is not called

v5:
1.rebase to the latest tag

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
 drivers/net/wireless/ath/ath12k/acpi.c   | 364 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h   |  60 ++++
 drivers/net/wireless/ath/ath12k/core.c   |   6 +
 drivers/net/wireless/ath/ath12k/core.h   |  13 +
 drivers/net/wireless/ath/ath12k/hw.c     |  10 +
 drivers/net/wireless/ath/ath12k/hw.h     |   4 +-
 drivers/net/wireless/ath/ath12k/pci.c    |   6 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 277 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  45 ++-
 10 files changed, 785 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h


base-commit: 7cd4c7979139b8d5a61226af1fe2548887364712
-- 
2.34.1

