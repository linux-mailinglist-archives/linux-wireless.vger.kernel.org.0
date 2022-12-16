Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196B64E79C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 08:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLPHNP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 02:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLPHMm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 02:12:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC436BCBD
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 23:09:36 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG6AAJ1019069;
        Fri, 16 Dec 2022 07:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=KNU4YWCFe+rW8ohocJ1OkdkrY4HGa5ZYFckqm24YfIc=;
 b=iEmMZ10Pfc08EjLmNb5UZPXnyfXie+znNiK763AeKsiwRHYxJuEN/pMK9l7LvULZ/d4z
 073BjWBtPx/P4wvL95N/0xMz0FKS+K7TCQvpCfA9YBqSy7WCd2B3dAMaQG7SFwoRJA/7
 1e8DNfUwcg9G4WvRz4r1H3BjhuQGVt9OHR8Z56ytv3qrHDBKe8yhQBTPqQL31NKh92r+
 KYjfWZt8WjaHhGMTqQVPIUgcY8tZWdpHpNZZHD1YjXEZqmuDg+ZTNgNgPbABQIeMF3il
 hujUc3JlWSQXHGsDFY6Op1xuWgDlgc5prnx/n/DUGsty8y9igvWaGrB7/TICTKMWUduM pw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg8e69m0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 07:09:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BG79Wgp019844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 07:09:32 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 23:09:29 -0800
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: Radar bitmap support during radar detection
Date:   Fri, 16 Dec 2022 12:39:16 +0530
Message-ID: <20221216070918.5969-1-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bk4D0tKn00S7L66Wj19uXgACQcEMjHch
X-Proofpoint-ORIG-GUID: bk4D0tKn00S7L66Wj19uXgACQcEMjHch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_04,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=978 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212160062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With the current implementation when radar is detected, the whole
configured DFS channels are moved to "unavailable" state(NOL).
However to move only the radar affected channels alone to NOL,
introducing two unsigned 16bit variables "cf1_radar_bitmap" and
"cf2_radar_bitmap" which denotes the radar(with a granularity of
20 MHz) in the first and the second part of the channel respectively.
The "cf2_radar_bitmap" value will be valid only when the
"center_freq2" is available.

The LSB of the radar bitmap corresponds to the lowest 20 MHz channel
of the configured channel bandwidth. Each bit set to "1" in this radar
bitmap indicates that radar is detected in that sub-channel. Based
on this radar bitmap the radar affected channels alone will be moved
to NOL. Advertise these radar bitmaps using new NL attributes
"NL80211_ATTR_CF1_RADAR_BITMAP" and "NL80211_ATTR_CF2_RADAR_BITMAP"
with the existing "NL80211_CMD_RADAR_DETECT". Once these are
advertised and the needed dfs state propagation is done, reset these
radar bitmap values as they are not valid until there is another
radar detection.

With these radar bitmaps, we can support bandwidth reduction and
RX puncturing in the DFS Channels.

Nagarajan Maran (2):
  wifi: cfg80211: DFS radar detection support with radar bitmap
  wifi: mac80211: radar bitmap support during radar detection.

 drivers/net/wireless/ath/ath10k/debug.c       |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath9k/dfs.c          |  2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  2 +-
 drivers/net/wireless/mac80211_hwsim.c         |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 drivers/net/wireless/ti/wl18xx/event.c        |  2 +-
 include/net/cfg80211.h                        |  6 +++++
 include/net/mac80211.h                        |  5 +++-
 include/uapi/linux/nl80211.h                  | 11 +++++++++
 net/mac80211/ieee80211_i.h                    |  2 ++
 net/mac80211/util.c                           | 10 +++++++-
 net/wireless/chan.c                           | 24 ++++++++++++-------
 net/wireless/mlme.c                           |  4 ++++
 net/wireless/nl80211.c                        | 11 +++++++++
 net/wireless/reg.c                            |  3 +++
 22 files changed, 80 insertions(+), 24 deletions(-)


base-commit: 58e4b9df840cad439a4c878f81bc105cac2197a7
-- 
2.17.1

