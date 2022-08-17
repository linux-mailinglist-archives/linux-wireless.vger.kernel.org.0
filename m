Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB0596CF2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiHQKmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 06:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiHQKml (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 06:42:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295AA6C77A
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 03:42:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HAVoeh001126;
        Wed, 17 Aug 2022 10:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=dxxHSDgGWaMHAU7o1+WnFRqhevhQ6WphcGgsCPxb6+s=;
 b=Uy+rz157ngFTAHdlYzwu6JEsjEXKwCnx/8kbAWj/V9jwUNTiWebzcmDVNgZeLU8gfwUz
 eBixAzGeyNJtcdNwvPtpWVvpLhUyhSxXYT0GhYwdgjtADPGY83MM4Z4o1knSCbd2JzgJ
 kKClS3aHXOVM7Q/iByzLLPP/k+GOvB3qucm8c34dtQ9WD7PKfay88AbdLArBoUxKoPJg
 Zc2zkcUDVVuReban4AhtVK7qYOXe95vjsNye+GLSwemHdXZpPenARSu5wpIKAZQb36sS
 Z0O4oxLpx+nmuNTyNbURyjgo+TWJyhwHmawPxG1uhrWh8j3ua14NJo0TW2G98/5yeGZ/ 4g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j0r7chjcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:42:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27HAgadh017216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:42:36 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 03:42:35 -0700
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 03:42:34 -0700
From:   Vasanthakumar <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211:  extend rx API with link_id for MLO connection
Date:   Wed, 17 Aug 2022 16:12:11 +0530
Message-ID: <20220817104213.2531-1-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wDTH6qMUi2eEEHDXkxC76u39FThcPZb1
X-Proofpoint-ORIG-GUID: wDTH6qMUi2eEEHDXkxC76u39FThcPZb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=5 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=5
 mlxlogscore=128 clxscore=1015 suspectscore=0 spamscore=5
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208170040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

In MLO, the frames can be received on any of the affiliated links.
When the address translation for rx frames are done in fw/hw, it
is very important to have an explicit link information reported
for every rx frame to mac80211. Per-link processing includes
stats update, GTK/IGTK/BIGTK retrieval and so on. This patch
set only tries to use the link at the top level APIs, deep
rx handlers are yet to be changed to use the respective
link accordingly.

This series is prepared on top of the latest mld branch.

Changes from RFC:

- Re-arranged the code changes across the patches
- Add a valid flag for link_id in rs_status
- Remove logic involving unspecified link_id

Vasanthakumar Thiagarajan (2):
  wifi: mac80211: add link information in ieee80211_rx_status
  wifi: mac80211: use the corresponding link for stats update

 include/net/mac80211.h |   5 ++
 net/mac80211/rx.c      | 130 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 128 insertions(+), 7 deletions(-)

-- 
2.17.1

