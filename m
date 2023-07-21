Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191A275BC55
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 04:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGUCfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 22:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGUCfN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 22:35:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B38271F
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 19:35:08 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L0oxu7006767;
        Fri, 21 Jul 2023 02:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=xdB3HCkQK/4WR/kMTZeZ3SvbLyyXK0Lqg0JvsGOnMwU=;
 b=nW2wNNa6VSYHvrUZDz+jNZIxspiFb6+3xcxRfwUkkDhI9iFoQm2gpFqZQ4QZmtJ5NHDv
 z1+oM2epPVSu7ea+NXtToT4BaIK95nnJyLu7yvxlDv7/vSji5jLH6J6/KSVRsPZiqhPA
 AlIUxnZYySH3EL6HWebcWSYt6FeUgYAM70Loa3Z1kLdn1j0lf1A9RqUEDTBbaoFAOAmA
 dNvKmPGT0cDHkNWPK82epH8uV9XmvYG8T/p+xAfqDY8qsnhT5/Itu8P8OUgI4mI53vIx
 TiwOtpuaISsLipuWt2IgSkcFnxylAqk8NaaYqNYF+UniLnFIV81Md2s1ZGPD5C7PDvUl Hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxqv2mkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2Z0eB011455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:00 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 19:34:59 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 0/3] ath12k: Make suspend/resume work for WCN7850
Date:   Fri, 21 Jul 2023 10:34:43 +0800
Message-ID: <20230721023446.3706-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T47WrBlhrsDAog_vz4Ndqh9N_OK9GbA0
X-Proofpoint-GUID: T47WrBlhrsDAog_vz4Ndqh9N_OK9GbA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=402 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch set flushes all data and management packets before
suspend, so the 500ms delay workaround in ath12k_core_suspend
is not needed and removed.

Due to MHI bugs, at the moment we are not able to shutdown and
fully power off the device. As a workaround we put firmware to
WoW state to make sure no unexpected activities while host is
in suspend.

With all suspend/resume functionality implemented, we change
supports_suspend to true for WCN7850 to make it work.

Baochen Qiang (3):
  wifi: ath12k: Flush all packets before suspend
  wifi: ath12k: Put firmware to WoW state during suspend
  wifi: ath12k: Turn on suspend/resume switch for WCN7850

 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/core.c   |  31 ++++-
 drivers/net/wireless/ath/ath12k/core.h   |   4 +
 drivers/net/wireless/ath/ath12k/hw.c     |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c    |  44 ++++--
 drivers/net/wireless/ath/ath12k/mac.h    |   1 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 107 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    | 165 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c    |  74 ++++++++++
 drivers/net/wireless/ath/ath12k/wow.h    |  30 +++++
 10 files changed, 442 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h


base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
-- 
2.25.1

