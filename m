Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C64685FCE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 07:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBAGeX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 01:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBAGeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 01:34:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C00F474F4
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 22:34:17 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3115t5Qh021598;
        Wed, 1 Feb 2023 06:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=UH1WNIN3XmXvsWywoyQHz2pBchS6fZsZFQX4SGJ1Z68=;
 b=NQ5eVs/P46d0j/n58lnq5V5sU4Y4bXACU/HXzgkjzjMhP18nNuh2wSFWHX4anYR2UCaz
 FsEvzp0pC721YFyQAb+Jj/ihM5MT1LalstoKoll2zjzg0b4d/PMdVSdrJNk3dIkTFgBp
 /8GQNVvogELOuIzWng+hkvyqAEJ6crUhM/89nMG1cZElUJ0YtizjEEsy0isWT5uQW355
 b/h+GKmbuZuvluax42IY4S/B7Fsaqzlv+CblrMKASktZRKCnveRG1M2LKOyYtUuvzp2H
 tyWgZ+O1X/zRlxdFxg0Ea2wSOQoi1ofEaPr3Q+yWYs06R611e8YEo9dWp7Hm151fmv5p Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3netx4k77n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:33:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3116XxZh024919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 06:33:59 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 22:33:57 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 0/3] wifi: Add support to enable/disable bss color collision detection
Date:   Wed, 1 Feb 2023 12:03:30 +0530
Message-ID: <20230201063333.11747-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4bMX9-_srlcIjxFgo29xXqKoyAyneRRn
X-Proofpoint-GUID: 4bMX9-_srlcIjxFgo29xXqKoyAyneRRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=589 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds configuration option to Enable/Disable 802.11ax BSS
color collision detection.

Changes since v1:
- Split nl80211 patch(patch 1/2 on v1) to two patches.

Rameshkumar Sundaram (3):
  cfg80211: add support to enable/disable bss color collision detection
  mac80211: Avoid BSS color collision detection if its disabled
  ath11k: add support to enable/disable BSS color collision detection

 drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
 include/net/cfg80211.h                | 2 ++
 include/uapi/linux/nl80211.h          | 3 +++
 net/mac80211/rx.c                     | 3 ++-
 net/wireless/nl80211.c                | 3 +++
 5 files changed, 14 insertions(+), 2 deletions(-)


base-commit: 4ca69027691a0039279b64cfa0aa511d9c9fde59
-- 
2.17.1

