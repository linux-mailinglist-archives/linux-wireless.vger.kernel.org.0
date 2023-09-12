Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF65979C636
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 07:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjILFTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 01:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjILFTk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 01:19:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D807AA
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 22:19:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C4QOkW028316;
        Tue, 12 Sep 2023 05:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TJbAoEQqo6+uWPfCRClZYQfwe1JwyrzoVgw97CEUR+Q=;
 b=MDMl3Dv2xD1x0T5MpcIPYPompHgyvu11xDQLt1BbrmAdRdIZAkFZraRIod35y2Cp+4XD
 MGSqUa77Z+GeFi51FA2gN5uLQsm6wvh9qUvck735OXdiJtMX9xBCywuoKZbx+/yFpWSi
 ZDdhVWOnBzisuUDs2wFWEeYe8Pf4tqKLiCtIXf/L377bY4gq/B9dsa0ykxLYgCyyfIFD
 F5T7YI0e08hlaTDdPW+I/B03YfpRriKaV1s11xuRf5twIYyIkce8DD6ABxXikHwcMuU6
 mixjR+KO4Zxz8pCm+4IJdAQ1ZCgSu5q8RuItKLhYWDBH0SdaE0kXGjOC3qDne0vzu/Tk Sg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2f3yr8s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:19:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C5JRRI030837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:19:27 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 22:19:25 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Aditya Kumar Singh" <quic_adisi@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath11k: fix CAC running state
Date:   Tue, 12 Sep 2023 10:48:54 +0530
Message-ID: <20230912051857.2284-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qv9nUkGH93U-HRKFt-bnTEB2s4D5ZxLy
X-Proofpoint-ORIG-GUID: Qv9nUkGH93U-HRKFt-bnTEB2s4D5ZxLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=862
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120043
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
---
v2: rebased on ToT

---
 drivers/net/wireless/ath/ath11k/mac.c | 27 +++++++++++++++++++--------
 include/net/cfg80211.h                | 24 ++++++++++++++++++++++++
 net/wireless/chan.c                   |  2 ++
 net/wireless/core.h                   | 17 -----------------
 4 files changed, 45 insertions(+), 25 deletions(-)


base-commit: 0263687f4441d5a5eab8074d56b4693c8f0acf85
-- 
2.17.1

