Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8B68206F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 01:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAaAMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 19:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjAaAMp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 19:12:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F91A947
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 16:12:44 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UMfOFL020631;
        Tue, 31 Jan 2023 00:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ycnUmSbRloOcph9cIJYG+VfPZEOyP0D86bI13Q/28DU=;
 b=HsbQ1pUIYz2mx7dXdSwb0oz0h7uEBFk9VC1ZDHQiHe6b0FaIoLlkg0gLXUdVJl8qMtOl
 uBgrcwy8cgZpns/+Lz7fGvzo4vcPfMGMIs6fzYzmZJGNIRE2sR+PwMcCPQRP7AGQZFSp
 d54YkOcpVUl1jnRqaXGqb/vgj3GDkdSZCdEY73Bs3ZL1XIPBnviPHyC6Gaxay3l5ryT5
 mJdT5/i0YZIKuMgMXQNNamEvGg2+hLX2qtA8+AQ9x81oqX1MW0iRzjPAOD0TcNRhrmCt
 P7ibMyZlX/v/Nuet9odIRyYG9691/lwXq+IYHSbtB4ApT7+71tqbs+3K6CPVOMn7vNJY TA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctqgnapg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V0CeNM018025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:40 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 16:12:39 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v4 0/4] v4: Puncturing support in AP mode
Date:   Mon, 30 Jan 2023 16:12:23 -0800
Message-ID: <20230131001227.25014-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VrLUIszxdWtzfQek8qtGZINXR4-LENXz
X-Proofpoint-ORIG-GUID: VrLUIszxdWtzfQek8qtGZINXR4-LENXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_18,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=795 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Moved bitmap validation from MAC80211 to CFG80211.
- Combined start_ap() and switch_channel() patches for a given module.
- Changed the order of patches.

Aloka Dixit (4):
  cfg80211: move puncturing bitmap validation from mac80211
  wifi: nl80211: validate and configure puncturing bitmap
  wifi: cfg80211: include puncturing bitmap in channel switch events
  wifi: mac80211: configure puncturing bitmap

 drivers/net/wireless/ath/ath6kl/cfg80211.c |  2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c |  2 +-
 include/net/cfg80211.h                     | 26 +++++++-
 include/net/mac80211.h                     |  3 +
 include/uapi/linux/nl80211.h               | 12 ++++
 net/mac80211/cfg.c                         | 23 ++++++-
 net/mac80211/mlme.c                        | 77 +++-------------------
 net/wireless/chan.c                        | 69 +++++++++++++++++++
 net/wireless/nl80211.c                     | 58 ++++++++++++++--
 net/wireless/trace.h                       | 24 ++++---
 10 files changed, 205 insertions(+), 91 deletions(-)


base-commit: 4ca69027691a0039279b64cfa0aa511d9c9fde59
prerequisite-patch-id: f3e39c8c03c23c977baa8946066285e597b93c7e
-- 
2.39.0

