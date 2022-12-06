Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDEE643A6F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 01:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiLFAu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 19:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiLFAu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 19:50:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A71B1D1
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 16:50:53 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B60AiIK004370;
        Tue, 6 Dec 2022 00:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=vJZq1s0qniYpHG2YReT9XwqiJm0jzCFqhxhqexnmBS0=;
 b=RdO9vn6CaGGcqZwyDUxnFXVq39csV1r5q4n0hCZY+rtS7zboVvYqOTI6ML0RSRoW6Caw
 ETMQaspl6fWduwl0IW2SA0SS6alwl8Bex5Vy15mGHVoiv09aSxkCndvVSdqfaRLhOIWQ
 gp5M+D8EF23D0FjXmnVGJvUdJOS4bd43vutBx7xmkC+UeA+tZ12UyL6J8yn8+S+DO84P
 VgZ7HMQ3uwRT4mkJxQjTp3Soe4JAhQxPKh5phSmkk7wMIvi62LwyxMmoJM+Ka+UuSM3F
 TcbMRJDWaz0s0rY59vTbAs/cIba64B9rbQHSX5NpzPKxPMnRrUwS+YTplS7IUZFAY4CQ Pg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9trk03as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 00:50:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B60omCM013292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 00:50:49 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 16:50:48 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/4] v3: EMA and HWSIM support in AP mode
Date:   Mon, 5 Dec 2022 16:50:36 -0800
Message-ID: <20221206005040.3177-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nOAkZt3lsENrYBMWiVnAuV42yVaAP0MK
X-Proofpoint-ORIG-GUID: nOAkZt3lsENrYBMWiVnAuV42yVaAP0MK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=783 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for EMA AP beacon generation and mac80211_hwsim to
test MBSSID and EMA in AP mode.

v3:
- Added a missing NULL check for mbssid_ies in patch #1/4.
- Hostapd hwsim tests using the changes from this version are mentioned
in the corresponding patches and these are already merged in hostapd.git.
- Dropped ath11k patches.

Aloka Dixit (4):
  wifi: mac80211: generate EMA beacons in AP mode
  wifi: mac80211_hwsim: move beacon transmission to a separate function
  wifi: mac80211_hwsim: Multiple BSSID support
  wifi: mac80211_hwsim: EMA support

 drivers/net/wireless/mac80211_hwsim.c |  83 +++++++++++-----
 include/net/mac80211.h                |  68 +++++++++++++
 net/mac80211/cfg.c                    |  11 ++-
 net/mac80211/ieee80211_i.h            |  10 +-
 net/mac80211/tx.c                     | 134 +++++++++++++++++++++++---
 5 files changed, 263 insertions(+), 43 deletions(-)


base-commit: 65e6af6cebefbf7d8d8ac52b71cd251c2071ad00
-- 
2.34.1

