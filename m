Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85036B1065
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 18:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCHRr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCHRrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 12:47:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F225A6D2
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 09:47:22 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328FqAiM026171;
        Wed, 8 Mar 2023 17:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9bVfWmP7dQ1iPTYuCGJKSBblrMwCayFQm/7fjNNa6O8=;
 b=G2w35mxrYLgTG9YYc0KRA2c/sFtjVt8+3b06YN8YLL6F73byDkqDqaaiL2Qg5KdOLaod
 4TyK/gQbxfCYgj6aIwQ5saGm455lAGjXC+iYExoB2J9BvLtzFzvsRogockSTaN/gD+KE
 qxKwRDlkhIwdAC6rziOwNSLj2L/NNbLAVh7esvWTm9fGAJjz/D2c0wNP96rsu3fZXRSl
 wBRYeCbucSJdccs7clKuLdEBnvTzAv4a+A4/tnxKqQUe8Ua5HzdnqjHXxFEwQGLMYT1c
 k4Xc4xN/xfqz27mvKAZR1ExGW/vniMoROP0Hbkzvrv7u5UxaAPv07YkglaGi9RzkJf1w TQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6wcmg9u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 17:47:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328HlDgl017801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 17:47:13 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 09:47:13 -0800
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: bug fixes in tx offload and stats
Date:   Wed, 8 Mar 2023 09:47:01 -0800
Message-ID: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7EQhiMBGj4fkYWi_RWolFYVoAHmCY8JX
X-Proofpoint-ORIG-GUID: 7EQhiMBGj4fkYWi_RWolFYVoAHmCY8JX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_11,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=777 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080152
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes bugs in ath11k in peer stats and TX encapsulation offload
cases.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

Pradeep Kumar Chitrapu (2):
  wifi: ath11k: fix null ptr dereference when tx offload is enabled
  wifi: ath11k: Fix incorrect update of BCC counters in peer stats

 drivers/net/wireless/ath/ath11k/dp_tx.c  | 26 +++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/hal_rx.c |  4 ++--
 drivers/net/wireless/ath/ath11k/hal_rx.h |  2 +-
 3 files changed, 26 insertions(+), 6 deletions(-)


base-commit: 1a304987a22c9f383f163f93beb47e89080d1cee
-- 
2.17.1

