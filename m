Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494F568066B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 08:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjA3HXF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 02:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbjA3HXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 02:23:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD2B11E9F
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 23:23:00 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U7FgRV028471;
        Mon, 30 Jan 2023 07:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6tptTBIRh4/nfbVOSuPUtRlwDHSpbgVuM89d3ovff5A=;
 b=LCX+P4ZhR+/PQ7tdSGWdlf9Mbr2owKQ3xJpXcCHxaWaI68Omel40vdKlI+te8DqVhbDo
 DrmqIBXF1GKRYdSsnBbNR3NLaxUYHC7MxE2cUSP5jA/Fx081mAQ3492YVxi6MD38dARI
 8z+HnhZnODlccfwkHfvPzY3WUl10waQ3wXqbZzNPSVykFnfsSuJihPt8Sds0lqsm4CGr
 yWLR/y6bmh/+4qSeAzjkfLaypf79TAN8Udl5TS4qofK+RsqAH33rXfoj5Aaebp8p9bD7
 Rrhy37DEXzPmwDGQ8p4xJJK9KtjApOk9vkWSAYIWmUmLUo5onpaEfGPAdMj3291uvVWv fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncs2x3e7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7MoT1008622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:50 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 23:22:50 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3 0/6] Puncturing support in AP mode
Date:   Sun, 29 Jan 2023 23:22:33 -0800
Message-ID: <20230130072239.26345-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: slWc0RgNKLIbqCVYp58sm6IRJY2ZCUvj
X-Proofpoint-GUID: slWc0RgNKLIbqCVYp58sm6IRJY2ZCUvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=808 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add preamble puncturing support in AP mode.
This series is based on top of following:
https://patchwork.kernel.org/project/linux-wireless/patch/20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/

And it is next version for:
https://patchwork.kernel.org/project/linux-wireless/list/?series=625836&state=%2A&archive=both

Aloka Dixit (6):
  wifi: nl80211: configure puncturing bitmap in NL80211_CMD_START_AP
  wifi: mac80211: validate and configure puncturing bitmap in start_ap()
  wifi: nl80211: configure puncturing in NL80211_CMD_CHANNEL_SWITCH
  wifi: mac80211: configure puncturing bitmap in channel_switch()
  wifi: cfg80211: add puncturing bitmap in channel switch notifications
  wifi: nl80211: add puncturing bitmap in channel switch events

 drivers/net/wireless/ath/ath6kl/cfg80211.c |  2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c |  2 +-
 include/net/cfg80211.h                     | 16 +++++++-
 include/net/mac80211.h                     |  5 ++-
 include/uapi/linux/nl80211.h               | 13 ++++++
 net/mac80211/cfg.c                         | 28 +++++++++++--
 net/mac80211/ieee80211_i.h                 |  2 +
 net/mac80211/mlme.c                        | 14 +++----
 net/wireless/nl80211.c                     | 48 ++++++++++++++++++----
 net/wireless/trace.h                       | 24 +++++++----
 10 files changed, 124 insertions(+), 30 deletions(-)


base-commit: 4ca69027691a0039279b64cfa0aa511d9c9fde59
prerequisite-patch-id: f3e39c8c03c23c977baa8946066285e597b93c7e
-- 
2.39.0

