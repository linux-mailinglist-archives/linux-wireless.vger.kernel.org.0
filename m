Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C567C771A18
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Aug 2023 08:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjHGGSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 02:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjHGGSN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 02:18:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4099F10F9
        for <linux-wireless@vger.kernel.org>; Sun,  6 Aug 2023 23:18:12 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3775nZhe013240;
        Mon, 7 Aug 2023 06:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=1shZU4r7MHTWFWwwrx85UxfDWH63nSNO7+YRtIbaE7w=;
 b=b36wKR00G99wyyp8EqwogxMI42ZrcN7SrTO1sBxlFfpc7jXp/xGk32IDWyl9zYXnj+EX
 +xRw6oX/jti3dRnceJU3NPf0Vce+P8N/0Qy2UOzBEGu5GnmhsxWPAZC5Ep2gX/xZtih9
 mdS4SIo7XGTbz7cVSPjfVNF3cktZjPw9omo+GBIHlngz0JXuA/n3O+eMaAmr+Vv4YQSK
 rNYTeQ4Kb25yznhgzWs1TNV4B5ER94vTALO+qpvfIyhg+aUnyBw1DWZc6A3ND2GrClQq
 NbNp8/O1dIuyutNqswDZ8nFzUFSiJxhEI8hE2FBPqrkJu7vx6fyEx4woBMHUxgDg8ldL vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9c4nturv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:18:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3776I6CN031444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 06:18:06 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 6 Aug 2023 23:18:05 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] wifi: ath11k: add support for QCA2066
Date:   Mon, 7 Aug 2023 14:17:47 +0800
Message-ID: <20230807061749.9404-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UFR65nIlvW1bxJLC1t_jU9QTtmBgTNBM
X-Proofpoint-GUID: UFR65nIlvW1bxJLC1t_jU9QTtmBgTNBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=838 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308070057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCA2066 is a PCI based DBS device. It is very similar to WCN6855
overall: they share the same PCI device ID, the same major and
minor version numbers, the same register address, and same HAL
descriptors etc. The most significant difference is that QCA2066
supports 3-antenna configuration while WCN6855 doesn't. To
differentiate them, subversion numbers are used. Currently four
numbers are used by QCA2066: 0x1019A0E1, 0x1019B0E1, 0x1019C0E1
and 0x1019D0E1.

In order to read subversion register, pci.ops needs to be ready
at that time, this change is done in the first patch.

The second patch enables support for QCA2066.

Depends on:
Carl Huang: public review
  wifi: ath11k: supports 2 station interfaces

Baochen Qiang (2):
  wifi: ath11k: move pci.ops registration ahead
  wifi: ath11k: add support for QCA2066

 drivers/net/wireless/ath/ath11k/core.c | 84 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 42 +++++++++----
 drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
 5 files changed, 128 insertions(+), 11 deletions(-)


base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
prerequisite-patch-id: 640366721125b1adea0eeabd5cdfca5e91476e7c
-- 
2.25.1

