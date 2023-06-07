Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7225725FF2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 14:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbjFGMrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbjFGMr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB701FE8
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 05:47:14 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357CaRAS009624;
        Wed, 7 Jun 2023 12:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=p8kCR4yZTmd2nVUTUQzqDo5PTw5dfuNA8lg0QyOYiqI=;
 b=SEPUK0YX0pYMP+9y99TcBopd20gvwPZ6zfZw5Koq78DI/f9Wk5QhDMca0LDvhmF4pIrZ
 DjqUNyxdRNOXCtyuVVYQIHy0KCpzeEg7ZqwvMfUINcVYtJ8KPj0b3CQ0h7GVxqH+BLMI
 2jgvjt3kzM0VsNuoIgm5xMI996PhLP6FvFMKjExjNcscN1CM0f0MSmCnkfQp6vW1RUA3
 XHPt3G1EQCZzaJg/aUSalBGlLf1YnSVJl7P4/xo0ZMSAcat8EL1e6yiydiV6qLm300Ei
 yYPE4DSGodNb+39oRr3Lbv4J4swKHWBxEwH+3QNMuqsGpVeG2ZeJT8VBZbl1BaGFClMd Fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2rbtg7b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 12:47:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357Cl3Q2007757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 12:47:03 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 05:47:01 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Aditya Kumar Singh" <quic_adisi@quicinc.com>
Subject: [PATCH 0/3] wifi: ath11k: fix CAC running state 
Date:   Wed, 7 Jun 2023 18:16:44 +0530
Message-ID: <20230607124647.27682-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YjTPK63VGR4OWNspQ4Y1hBniIX4Kkd4f
X-Proofpoint-ORIG-GUID: YjTPK63VGR4OWNspQ4Y1hBniIX4Kkd4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=833 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently CAC running flag in ath11k is not set if DFS radar is required in
secondary channel. This is due to the fact that only primary channel's DFS
state and CAC time is being checked before setting the flag.

Fix this issue by checking the DFS state of all the sub-channels inside a
channel definition and not just the primary channel.

Also, make minor change in debug prints to show the CAC time

Aditya Kumar Singh (3):
  wifi: cfg80211: export DFS CAC time and usable state helper functions
  wifi: ath11k: fix CAC running state during virtual interface start
  wifi: ath11k: fix Tx power value during active CAC

 drivers/net/wireless/ath/ath11k/mac.c | 27 +++++++++++++++++++--------
 include/net/cfg80211.h                | 24 ++++++++++++++++++++++++
 net/wireless/chan.c                   |  2 ++
 net/wireless/core.h                   | 17 -----------------
 4 files changed, 45 insertions(+), 25 deletions(-)


base-commit: a4756ac34a7002861c9bdf8cf45aec53a77fb78d
-- 
2.17.1

