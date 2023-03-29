Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4B6CF6B2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 01:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjC2XMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2XMF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 19:12:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384683596
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 16:12:02 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32THU2qE005487;
        Wed, 29 Mar 2023 23:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=RYPAU6ANILW/CzikItkl+7Nb5owRDYBVCaM86zZMZfE=;
 b=M8STbDI3Ys4gQui/65Zhv9Hk7qhVhkzpWrKsrQVMGT3KvTBWXJDMPo+ujEULYxWh/A7t
 O6VmZeOa9MGLxgpy4nZZWeoSsL7Uz1z4HeqURVwdsb+TSCnSPeoNxezfSWgY+hkBxsFB
 dRYOutzdNRv7Nm5sjpDc4wGEDF5V4U4W5eV34IlZ9MTlEYoXgpg8Prab1Ql/ye88HcUz
 6IwQcByEKGlcMkyt5EhCpRogHfCg2APFQlNOTyypIitiV8DmrPR4rBCwglz1QBSmKAux
 i5LRVub71GTkTedLblbklahk4zXTJ7N97PG7RO97XNf6IV2W56QBXXJoreVZNYBaHbK+ aQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmgpm2bmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:11:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32TNBvBH027600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 23:11:57 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 29 Mar 2023 16:11:57 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 00/11] wifi: ath12k: EHT support
Date:   Wed, 29 Mar 2023 16:11:34 -0700
Message-ID: <20230329231145.20171-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mcXIab2M80XXcx92lXKz3T-VSr22kWj-
X-Proofpoint-ORIG-GUID: mcXIab2M80XXcx92lXKz3T-VSr22kWj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_14,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=876 phishscore=0
 adultscore=0 clxscore=1011 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290173
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add EHT support in ath12k.

The patches are as follows:
Patches 1 - 4: Propagation of EHT capabilities from target to userspace.
               Patches 1, 2 refactor the existing code to make EHT
	       additions easier.
Patch 5: Addition of EHT phy modes.
Patches 6 - 9: EHT related additions in peer association.
Patch 10: Process the new WMI service ready ext2 event.
Patch 11: Preamble puncturing support.

Aloka Dixit (9):
  wifi: ath12k: rename HE capabilities setup/copy functions
  wifi: ath12k: move HE capabilities processing to a new function
  wifi: ath12k: process EHT capabilities from target
  wifi: ath12k: propagate EHT capabilities to userspace
  wifi: ath12k: prepare EHT peer assoc parameters
  wifi: ath12k: add WMI support for EHT peer
  wifi: ath12k: peer assoc for 320 MHz
  wifi: ath12k: parse WMI service ready ext2 event
  wifi: ath12k: configure puncturing bitmap

Muna Sinada (1):
  wifi: ath12k: add EHT PHY modes

Pradeep Kumar Chitrapu (1):
  wifi: ath12k: add MLO header in peer association

 drivers/net/wireless/ath/ath12k/core.h |   9 +
 drivers/net/wireless/ath/ath12k/mac.c  | 555 ++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h  |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 218 +++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  | 116 +++++-
 5 files changed, 790 insertions(+), 110 deletions(-)


base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.39.0

