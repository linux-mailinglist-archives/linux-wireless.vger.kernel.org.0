Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2554E6D51A9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjDCT5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjDCT5v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 15:57:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D91FDA
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 12:57:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333IhFVP006525;
        Mon, 3 Apr 2023 19:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=VJ5WyWw6L+61DCHFW2rf+TotT/Dyd8PH4oj6SEThTXg=;
 b=HFkFqdGjdvbMjLsB4k9QZLKZJ3El4HigcwPev2EM5epPbvHuJNt2KvvjJDQEs1d7kDuV
 P1Xy/DhotmZsn9PSpVTcOzxYxul6PevbBxgPrHoYQn5Gz6sxKXDah2A04y2KR3SooTp5
 X07yYGGbXndrDEYvH+5tn5W7MAB2MRP0JPJxozSYHmJ9TlrAZlVuYzT/RO5d5CX2d7GN
 J+4UG+g1po763ccTM/nl5PiX+lG+Eg2JQaIPBwxruhw1ehZ++VFvFEI65nqkTxWc/buJ
 spYSNh5clqnRDXPaEywFTMbM6G4UH6c4t7QbEfRpBrVecnak7nwu0tzXsskwT+1ndHye Hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqy6210t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 19:57:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333JvmUa007326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 19:57:48 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 12:57:47 -0700
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH V3 0/2] wifi: ath11k: bug fixes in tx encap offload and ppdu stats
Date:   Mon, 3 Apr 2023 12:57:36 -0700
Message-ID: <20230403195738.25367-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F--SuGtBCa_AxTdVzefs0fBl5y3PKBjn
X-Proofpoint-ORIG-GUID: F--SuGtBCa_AxTdVzefs0fBl5y3PKBjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=630 phishscore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030154
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes bugs in radiotap fields and tx status reporting in TX
encapsulation offload cases.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Changes in V3:
	- update change log

changes in V2:
	- use ieee80211_tx_status_ext instead of using
	  ieee80211_tx_status_8023 when tx encapsulation offload
	  is enabled. This helps avoiding different callbacks for
	  different frame formats.(Thanks Felix)
	- fix subject and commit description inorder to address
	  previous review comments. 

Pradeep Kumar Chitrapu (2):
  wifi: ath11k: fix tx status reporting in encap offload mode
  wifi: ath11k: Fix incorrect update of radiotap fields

 drivers/net/wireless/ath/ath11k/dp.h     |  3 +++
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 29 +++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.h  |  1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c |  4 ++--
 drivers/net/wireless/ath/ath11k/hal_rx.h |  2 +-
 5 files changed, 35 insertions(+), 4 deletions(-)


base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.17.1

