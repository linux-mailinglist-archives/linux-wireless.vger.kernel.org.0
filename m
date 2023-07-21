Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAF75BE08
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 07:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGUFyD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 01:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGUFxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 01:53:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BC130F3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 22:53:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5TuIP017823;
        Fri, 21 Jul 2023 05:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ZcklBnkdW6IClXUd1leKPU+5yt3YcsSG6TSic81OuZU=;
 b=cRi/9dmQeYHb+KrYVKkrr4s+F/IDw0pGqwkovaZeds8fTvmTDF77FeJ8MepQ3nyMblnv
 8XlO6rNhyh4UeS0hfFhVm08aK5ZAe8Cj1GLRQRsgNXt9ZWg3jA1qttBP0tVmGJ6NTzUG
 UhR22voic+8J+VXSIyzlrJnurVLGTYBALNV0SKQbGbUr3Xd0fGwAUtzHCajwqQc0LlQu
 PQpKRRjCxIVL4s3yTgW3Q+ra4Anjuf3x+Xk9a1eKntK1ywzydKqxzmIQZOw8WKNX3IEn
 zxxyai5zAqwooMVNia4KD58zm+DHt5Cf0Y6KrZm7HdlDxzR6vV16M2VAkkNDJwoCXBnF Zg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryb0411tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:53:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L5rKw4007911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:53:20 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:53:19 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 0/3]  wifi: ath12k: add support device recovery for WCN7850
Date:   Fri, 21 Jul 2023 01:53:02 -0400
Message-ID: <20230721055305.20420-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VD3JWJ_9Wqj0sIq4CRF3NbOGw21rI0ri
X-Proofpoint-ORIG-GUID: VD3JWJ_9Wqj0sIq4CRF3NbOGw21rI0ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=639 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for device recovery, e.g. firmware crashed.

depends on MHI patch which has applied to mhi-next:
[PATCH v4] bus: mhi: host: Skip MHI reset if device is in RDDM
https://lore.kernel.org/all/1684390959-17836-1-git-send-email-quic_qianyu@quicinc.com/

v2: change subject and commit log of "wifi: ath12k: configure RDDM size to MHI for device recovery"

Wen Gong (3):
  wifi: ath12k: configure RDDM size to MHI for device recovery
  wifi: ath12k: add ath12k_qmi_free_resource() for recovery
  wifi: ath12k: fix invalid m3 buffer address

 drivers/net/wireless/ath/ath12k/core.c | 1 +
 drivers/net/wireless/ath/ath12k/hw.c   | 3 +++
 drivers/net/wireless/ath/ath12k/hw.h   | 1 +
 drivers/net/wireless/ath/ath12k/mhi.c  | 1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 7 +++++++
 drivers/net/wireless/ath/ath12k/qmi.h  | 1 +
 6 files changed, 14 insertions(+)


base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
-- 
2.40.1

