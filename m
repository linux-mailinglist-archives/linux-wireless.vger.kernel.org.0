Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDED8722564
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjFEMRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjFEMRx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 08:17:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B112A7
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 05:17:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BsZR8004582;
        Mon, 5 Jun 2023 12:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=D2jb3XKo2Xdn8s0gNnkJG4pXYovddMU9CCDV3GVtO7k=;
 b=IUnH/EkPXjC/o6v1dcA5kAuOTlGupnk+TVaqqT+1ftiKqsiuyatb8+L4vHDhy/Ps0z3r
 swCoT99O6BS4rQhV8YDKqzuSbHh0NCW8w992nXpja3bgXToIGbF3KsH2Lawb4G9TeaIJ
 e2ERAk86SKPbY/esVQKIxPDFZHXfpAc0NXP3tEVbiHnJhbk8HYAeBo6hQBatR2ptDlu8
 sEV/UY0LUzjrNCbJ55cKxRPjRy3/Z/LAFbDD3uZj22uqkglkQTHVlMQko0MSF1G8o2M5
 pdGY+LdlOVl99dQF7cHVRTxkUwHlsAw9GvJ3NG/HSakBkQcjE81y/uXNWMgjbBlO+46R CA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1ckb0bdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 12:17:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355CHg7I015683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 12:17:42 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 05:17:40 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH 0/3] Enable TKIP when using encapsulation offloading
Date:   Mon, 5 Jun 2023 17:47:19 +0530
Message-ID: <20230605121722.20797-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aiUB-uedeHOIc5MDh9ZpE4Qe_Hrga-Gl
X-Proofpoint-GUID: aiUB-uedeHOIc5MDh9ZpE4Qe_Hrga-Gl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1011 suspectscore=0 mlxlogscore=552
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TKIP was disabled on encap offload mode since if TKIP MIC error
reporting is not capable by the driver using encap offload mode,
then TKIP countermeasures would not work.

Enabling back TKIP bring-up in encap offload mode to leave the
control with the driver to disable hw encap when it is not capable
of TKIP MIC error reporting.

Sathishkumar Muruganandam (2):
  wifi: mac80211: Fix tkip encrypted packet transmission path
  wifi: ath11k: add 802.3 undecap support to fix TKIP MIC error
    reporting

Thiraviyam Mariyappan (1):
  wifi: ath11k: Fix tkip encryption traffic failure

 drivers/net/wireless/ath/ath11k/core.h  |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 54 ++++++++++++++++++++++---
 net/mac80211/tx.c                       |  3 +-
 3 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.17.1

