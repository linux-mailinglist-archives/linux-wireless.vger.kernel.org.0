Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7876E6445CF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 15:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiLFOhj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 09:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiLFOhh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 09:37:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E66A2724
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 06:37:35 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6DwxWJ026416;
        Tue, 6 Dec 2022 14:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=1Wk/A2pEaenrPwN3TLLBYBK8jk1iR/qbLM9RsUBRO/Y=;
 b=BnpHNoqIXan+lGfwpxKrA+pTIfKcx2zJdOVNWhcAyDolVLtJtHUbhDmuhjixnBpEVJ5K
 7aYy3Do0ODZVRKj5HREGkLoXWB3V8Vysm6G+tRUzqSahJsoKSuKykCF9th1AigzWIPKb
 G6+1D7+fF/lm0pKHBMCMcDFUQk2BDCakE11nYAcbsApa7IIECYUw4AG6ro9ikTVqh8xG
 pwQ95/4xtudMm/h9d8zy2FKlKYe4cM8Ihl7TWblGoB1SxpmcAB4KfLm7El43m7ka4RsS
 l3qHrD8kA2ppYHkqCUSLLlfMGJD4QOJNp9NOp6OQpERcyaJjjuPl+W0Mdr8TsxP8hWA4 lQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9qyn222y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 14:37:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B6EbVU8031083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 14:37:31 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 06:37:30 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] wifi: Support higher length KCK key in GTK offload
Date:   Tue, 6 Dec 2022 20:07:13 +0530
Message-ID: <20221206143715.1802987-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GJkmpXGKkvVark0qPZsk-FYHZUiGQo0Q
X-Proofpoint-ORIG-GUID: GJkmpXGKkvVark0qPZsk-FYHZUiGQo0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_09,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=476 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series contains changes needed to allow KCK key with more than 16
bytes length in NL80211_CMD_SET_REKEY_OFFLOAD.

Shivani Baranwal (2):
  wifi: cfg80211: Fix extended KCK key length check in
    nl80211_set_rekey_data()
  wifi: cfg80211: Support 32 bytes KCK key in GTK rekey offload

 include/net/cfg80211.h       | 3 ++-
 include/uapi/linux/nl80211.h | 1 +
 net/wireless/nl80211.c       | 6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.25.1

