Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCAC6DCC02
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 22:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDJUDu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDJUDt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 16:03:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5AF9C
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 13:03:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJK2vA015471;
        Mon, 10 Apr 2023 20:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=YT1Q1+rPL+NgFO6Xug3AcFu5qXusdthn0jWzcEd4TXE=;
 b=mcBybXwnfRh8kp0XZyw0u/rzSXzb41DzfiWBu1VdMTffWjKkzNnP3dqJNdhOfGw8BhRx
 DIgKTZYrbhtEctjSPTYkhjjyhGVnUxyWLeWHDutC9DEX8v5Zap9s9T8rIqd0yphFKvXW
 3bzuvq4wyjEGo3w4h/9XkpNYoakCS/BPB2RgNOZSz7N2XovMO6xewHiStYPhiJKnpiOF
 xMdjTxQeLLp4pwu5Qe3BhDSwPCrdRFgcZMB/PLA380KtgGlhj+v9WqJZMfVNv3Dv3byb
 afkmF2UBSGto/YjptRYVkNscgjRd0X4xRYgNAB/ZZZvL6fpK1OBSW03v7VyDYHoqFPH4 hA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvgmes6x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 20:03:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AK3iuO007838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 20:03:44 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 13:03:43 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3] mac80211: set EHT support flag
Date:   Mon, 10 Apr 2023 13:03:32 -0700
Message-ID: <20230410200332.32265-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p9FYmdm-wRPZj9evGoyIOCmvApVI1e-V
X-Proofpoint-ORIG-GUID: p9FYmdm-wRPZj9evGoyIOCmvApVI1e-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=961
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100173
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set 'eht_support' flag if EHT capabilities are present.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---

v3: This is the next version for the following patch,
https://patchwork.kernel.org/project/linux-wireless/patch/20220323225443.13947-3-quic_alokad@quicinc.com/
Retained only the must-have changes in this version from cfg.c.
Rebasing v2 added modifications from bss_conf to link_conf.

v2: Rebased on top of wireless-next git repository

 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 473915606715..7317e4a5d1ff 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1342,6 +1342,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (params->eht_cap) {
+		if (!link_conf->he_support)
+			return -EOPNOTSUPP;
+
+		link_conf->eht_support = true;
 		link_conf->eht_puncturing = params->punct_bitmap;
 		changed |= BSS_CHANGED_EHT_PUNCTURING;
 

base-commit: b536f32b5b034f592df0f0ba129ad59fa0f3e532
-- 
2.39.0

