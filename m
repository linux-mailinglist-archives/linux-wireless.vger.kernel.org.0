Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C5D7F3E46
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjKVGkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVGkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:40:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCC51A4
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:40:00 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5W8kI015327;
        Wed, 22 Nov 2023 06:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=oIavnNmrxOGK6W8+sL2Y2u3L5GHYFMOv93RZAzeaqAg=;
 b=abyWJyMWwx5UO84mAKI3gHmFCQwvlzlCFftKGTY2+YV1E49zHSElTLmlVT9IewDqsqkz
 POPZF4fdFQVOJ9oSgCBg3hdaZ065yFtB2jejkULddrGa6sYlD8V2HYAMYk4fQ4+FT3IF
 cz8b3AQmovtvHOhEtAuTnefPAZW6qkSs+7ZOVh93IHfUUandJ+2HJF849pRVHhH67XDP
 Xbgi2B0UH1Kq/fvZI+XTgL5WsjKzxH78XcHS7lZ9M6gRC7sdOcPUYyVuGmKwgxK6ivEi
 Vpndj/IV6lFpvM0vFMRIqwDNjyr0hqZx2eFvt6pHkf5tITQF3qWJjmVjMSKgkyqQwelC pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhbjvg58s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM6dqr7010425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:39:52 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 22:39:50 -0800
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Remove unsupported and unused ring configurations
Date:   Wed, 22 Nov 2023 12:09:29 +0530
Message-ID: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V2RuGsJGvw0fQuLaGKykk6g61-sMan7w
X-Proofpoint-ORIG-GUID: V2RuGsJGvw0fQuLaGKykk6g61-sMan7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=660
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in driver doing memory allocation for tx_monitor, tcl_cmd_ring
and tcl_status ring. Here driver support for tx_monitor mode is not
there and memory for tcl_cmd and tcl_status rings are allocated by
firmware and it uses that memory instead of host allocated. So avoid
these unused ring setup configuration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Tamizh Chelvam Raja (3):
  wifi: ath12k: fix calling correct function for rx monitor mode
  wifi: ath12k: Remove unsupported tx monitor handling
  wifi: ath12k: Remove unused tcl_*_ring configuration

 drivers/net/wireless/ath/ath12k/dp.c     | 16 -------
 drivers/net/wireless/ath/ath12k/dp.h     |  2 -
 drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 57 ------------------------
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 43 +-----------------
 drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
 6 files changed, 2 insertions(+), 157 deletions(-)


base-commit: 9a36440d929d134c56030a8492405708a143f580
-- 
2.17.1

