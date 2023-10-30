Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697DD7DC26B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjJ3W1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3W1p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:27:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB62DD
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMKi6j012551;
        Mon, 30 Oct 2023 22:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=f9M8oj5m8gGqnMvsMmHrXaaJJyCI/3BkI++OL43xR3Q=;
 b=dmVbvjFn/a7BdV2xHIAHH319LMxbTxGYEMhNefhNqj1PMKmTK0nfKY7uWz/FRZVg3dUm
 EPB8QSG/qMiu4FhRr2aS968vOJ3jxVEfjA50jLGuMMZjD9rUog9Y15UCStWqizTo4tlT
 so4DmyEN3ibi/W9nfFrcc1hs8fAq2+P/L0dsZMm6qjcdltzLPoHuJdkfyCvyDtvcrLg2
 O79rzjKXnBABQtSuxZTD9W0GcahKEEePcE4IQt+Q/r8U9eotEVWx3iS3i5fCG3PnCpvO
 aDJLzH1B8EuAzVhTG0IcJdwGu5G4Z8bIQ/vD5FRpBVCIserRmkPd6uUz8Si5Akq9ElZB fQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0sw7w3ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRX7s032102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:33 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:31 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 00/13] wifi: ath12k: QCN9274 dualmac bring up
Date:   Tue, 31 Oct 2023 03:56:47 +0530
Message-ID: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9BZv49GD7IuutbGE4dheJP98RNn7ReAx
X-Proofpoint-GUID: 9BZv49GD7IuutbGE4dheJP98RNn7ReAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=688 clxscore=1011
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series add the basic support for QCN9274 dualmac bring up.
It also add support for word based RX TLVs subscription for
QCN9274.

Aaradhana Sahu (1):
  wifi: ath12k: fix firmware assert during insmod in memory segment mode

Ganesh Babu Jothiram (1):
  wifi: ath12k: Read board id to support split-PHY QCN9274

Harshitha Prem (1):
  wifi: ath12k: add support for peer meta data version

Karthikeyan Kathirvel (1):
  wifi: ath12k: subscribe required word mask from rx tlv

Karthikeyan Periyasamy (1):
  wifi: ath12k: add MAC id support in WBM error path

P Praneesh (2):
  wifi: ath12k: Add logic to write QRTR node id to scratch
  wifi: ath12k: fix PCI read and write

Raj Kumar Bhagat (3):
  wifi: ath12k: fix fetching MCBC flag for QCN9274
  wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
  wifi: ath12k: remove hal_desc_sz from hw params

Rajat Soni (1):
  wifi: ath12k: Update enum wmi_direct_buffer_module

Sowmiya Sree Elavalagan (1):
  wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID

Sriram R (1):
  wifi: ath12k: indicate NON MBSSID vdev by default during vdev start

 drivers/net/wireless/ath/ath12k/core.c    |  29 ++
 drivers/net/wireless/ath/ath12k/core.h    |   5 +
 drivers/net/wireless/ath/ath12k/dp.c      |  15 +
 drivers/net/wireless/ath/ath12k/dp.h      |  14 +
 drivers/net/wireless/ath/ath12k/dp_mon.c  |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 161 +++++----
 drivers/net/wireless/ath/ath12k/dp_tx.c   |  20 ++
 drivers/net/wireless/ath/ath12k/hal.c     | 406 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal.h     |  17 +-
 drivers/net/wireless/ath/ath12k/hw.c      |   8 +-
 drivers/net/wireless/ath/ath12k/hw.h      |  29 +-
 drivers/net/wireless/ath/ath12k/mac.c     |  12 +-
 drivers/net/wireless/ath/ath12k/mhi.c     |  21 +-
 drivers/net/wireless/ath/ath12k/pci.c     |  78 +++--
 drivers/net/wireless/ath/ath12k/pci.h     |   4 +
 drivers/net/wireless/ath/ath12k/qmi.h     |   1 -
 drivers/net/wireless/ath/ath12k/rx_desc.h | 114 +++++-
 drivers/net/wireless/ath/ath12k/wmi.c     |  31 +-
 drivers/net/wireless/ath/ath12k/wmi.h     |  59 +++-
 19 files changed, 878 insertions(+), 151 deletions(-)


base-commit: f473b4a72b7cccfc1d0110b55dce1edaa5bbce9e
-- 
2.17.1

