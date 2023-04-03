Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611536D50E0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjDCSmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjDCSmm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 14:42:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63692BC
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 11:42:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333HxLGY002592;
        Mon, 3 Apr 2023 18:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ioUrswl3B68mZAsmvX9rjJXB7MKaaJKCFq/LO0RjxeQ=;
 b=pHb01PCLjE1p/NeMgJmwCkkeiPg9FkR5Ft2zeW4nMR9UoHVcRA0QqELwjLsG38KRkyUy
 IzAVjQCSi8YY2CwXN+Fr3f2lAI2jWfxSFRi0XgNncOywuEQTtJTpn4qEeio+fEyLzCs2
 JNQZrOhxnruP663KA/tGKme6sLxyPKxPUwCEiC5r8jHG9ebFfzUDbBDE6prRNa94nrZo
 cJFmdjYshuICN2sXf3I5RWvR2zNvUF+2euK5RnikQNCKmVzVsAHvuYhzXgGAiDrgynYR
 2PjBUvm7+qfkElW0GSrnk752kj7QCPG+W9Ny5fX4RjTkVApUEpHf5Sr1irz/6TudnuK1 BQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqy620vff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:42:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333IgZbG003033
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 18:42:35 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 11:42:33 -0700
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: Ignore frags from uninitialized peer in dp
Date:   Tue, 4 Apr 2023 00:11:53 +0530
Message-ID: <20230403184155.8670-1-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7V9OD0PuMTu_B2rhpAjvKbsoAeUKaR-S
X-Proofpoint-ORIG-GUID: 7V9OD0PuMTu_B2rhpAjvKbsoAeUKaR-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=728 phishscore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030143
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When max virtual ap interfaces are configured in all the bands with
ACS and hostapd restart is done every 60s, a crash is observed at
random times in dp_rx path.

This patch series handles the following:
    1. Ignore the fragments of the peer which does not have its
       datapath initialized.
    2. Fix the undefined behavior of __fls which was found during
       this crash.

Harshitha Prem (2):
  wifi: ath11k: Ignore frags from uninitialized peer in dp.
  wifi: ath11k: fix undefined behavior with __fls in dp

 drivers/net/wireless/ath/ath11k/dp.c    |  4 +++-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 +++++++++-
 drivers/net/wireless/ath/ath11k/peer.h  |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1

