Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53675A487
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGTCw7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 22:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGTCw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 22:52:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A126172A
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 19:52:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K0GJiD010106;
        Thu, 20 Jul 2023 02:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=gOMwF+WkE1Ry0Q+u1W1672r5b4JrZGRM7pXj9vnUB8w=;
 b=WIW4tH9EZqdgW2h6F9tneYo3Ee7fmwO9amTnV3HloYJ5KCN59VnoECga0N26JP6KuYoW
 5SFjdIx0Uz+e2F3vfrLhgxPc7b2Djq0AOu4E7o/h/uo9p5ibxjIQnkwyU4KWP+DSW59z
 ehNAFLGU5OL6UCF2r7kDvQpLlh75/OckOf4ERYQYMF2OF+9n4V7eWuuaflgEqcabIEGV
 lcBYOmYX1gU8c+VuDIyYkVjx8iHpw9M2SiHhzP8xSI+nal8ID0G9ukVj/15PKXEC8vGP
 2DLj0lVqHzfbDTy3dFRQwETWZ3tD21UDmdxR+SPNcBG8lAV2ncBvFcV7v+oDYLLHPtb7 KA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxpyqrg0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 02:52:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K2qlhM002952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 02:52:47 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 19:52:46 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: add support device recovery for WCN7850
Date:   Wed, 19 Jul 2023 22:52:29 -0400
Message-ID: <20230720025232.7701-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sTwnNf-U8cflEkStaQzrR0EXbZDk05r7
X-Proofpoint-ORIG-GUID: sTwnNf-U8cflEkStaQzrR0EXbZDk05r7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=629 malwarescore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Wen Gong (3):
  wifi: ath12k: configure RDDM size to mhi for device recovery
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

