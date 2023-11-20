Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976707F100E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 11:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjKTKQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 05:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjKTKQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 05:16:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CD8F0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 02:16:10 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7igFm030716;
        Mon, 20 Nov 2023 10:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=uj7mYuruhzmFSeRMTe7qL0xzEeLtaoTcbb2EDHnDZg0=;
 b=mHUUNesxm4pusAWvGtqkwjNSDdnj65hVn3GgPar/kJvMxKwy+qhVA1JvXowwI6Wz4VUY
 QvFnpQV5u9zlmN96XQguPAENIiii5SKHx/nW2Puc5O46heX/LqBjFiUixZwNg0xYBBBU
 mAGEa8UNEt05+ag9cj6fWUYc1rjQN6OngvKiriUYXHaYZGLLoTWxbhl4nxt2RmRpnSM3
 A1lL3x7no4LDlt+5wVTlxHsToXu19XciF03YQ6vd84To9I0HfclSqG7V3jZm3+OENjWg
 IuYrBn4AsqkOcwKOJnJzoM6BFuwyz66Q/HcnhsXmXvsdFXtf31tbptBnma9+Dl6M9VHX wA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem80kqrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:15:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKAFwb0018285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:15:58 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 02:15:57 -0800
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 0/7] wifi: ath12k: support one MSI
Date:   Mon, 20 Nov 2023 18:15:36 +0800
Message-ID: <20231120101543.4369-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C9v3Z_f2GTP8dPLEif9SdSPb2Q3T_KzE
X-Proofpoint-ORIG-GUID: C9v3Z_f2GTP8dPLEif9SdSPb2Q3T_KzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_07,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=394
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch set is to support one MSI vector for WCN7850.

Kang Yang (7):
  wifi: ath12k: get msi_data again after request_irq is called
  wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler
  wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ
  wifi: ath12k: refactor multiple MSI vector implementation
  wifi: ath12k: add support one MSI vector
  wifi: ath12k: do not restore ASPM in case of single MSI vector
  wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector

 drivers/net/wireless/ath/ath12k/core.h |   2 +
 drivers/net/wireless/ath/ath12k/mhi.c  |  16 ++-
 drivers/net/wireless/ath/ath12k/pci.c  | 180 +++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/pci.h  |   2 +
 4 files changed, 172 insertions(+), 28 deletions(-)


base-commit: 9a36440d929d134c56030a8492405708a143f580
-- 
2.34.1

