Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2054C6C66CC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 12:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCWLiZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 07:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjCWLiX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 07:38:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE66305D6
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 04:38:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N8wxcW010913;
        Thu, 23 Mar 2023 11:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=AxmzIU7zUKoMT0Wbd99EUpKr2TiQ4BZq6sCDCRBpQR0=;
 b=LiIcCprODcoPfaG27Q/GibgInaDmwk8S8oRXCrjFs0nBLhTcj4pmJrQo6XSpfnUNJZBY
 CA/Y2P0Oc6oe8RgB1gn+6CTAAkVcoyk3qrdmuggsZk88HS3jPU+8p0Hy3dmSsjkVWIPg
 APwB6/L1SbUW/h9kYMpDvsw2UqKmfn0VnE/su3KOD2UG41Eeb8d3kEQ32MvJlmqtxbFa
 W2Vmd8JV4QAEX8joFGu5adUOhuXWGHec12gmDFnqEN4XA7i/P2gU/pjLm/XTzqctsm0S
 9qM/oO/h09Z7neGPlsBf1JTwwqmS5tIjXQTdJre5WJaYh6j4W1xV/6ZXPHit+5lugkde EA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg64k251y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:38:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NBcCGb025943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:38:12 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 04:38:11 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 0/2] RNR for EMA AP
Date:   Thu, 23 Mar 2023 04:37:59 -0700
Message-ID: <20230323113801.6903-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HHCOhMe7TIENtG-qX_7OfzLPVZvN7jMe
X-Proofpoint-ORIG-GUID: HHCOhMe7TIENtG-qX_7OfzLPVZvN7jMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxlogscore=677 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230088
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As per IEEE Std 802.11ax-2021, 11.1.3.8.3 Discovery of a nontransmitted
BSSID profile, an EMA AP that transmits a Beacon frame carrying
a partial list of nontransmitted BSSID profiles should include in
the frame a Reduced Neighbor Report element carrying information for
at least the nontransmitted BSSIDs that are not present in
the Multiple BSSID element carried in that frame.

Add new attribute NL80211_ATTR_EMA_RNR_ELEMS to support the above.
Number of RNR elements must be more than or equal to the number of
MBSSID elements. This attribute can be used only when EMA is enabled.
Userspace is responsible for splitting the RNR into multiple elements
such that each element excludes the non-transmitting profiles already
included in the MBSSID element (%NL80211_ATTR_MBSSID_ELEMS) at
the same index.

MAC80211 will generate EMA beacons by adding MBSSID and RNR elements
at the same index. If the userspace provides more RNR elements than the
number of MBSSID elements then these will be added in every EMA beacon.

Aloka Dixit (2):
  cfg80211: support RNR for EMA AP
  mac80211: support RNR for EMA AP

 include/net/cfg80211.h       | 19 +++++++++++
 include/uapi/linux/nl80211.h | 13 ++++++++
 net/mac80211/cfg.c           | 63 +++++++++++++++++++++++++++++++++---
 net/mac80211/ieee80211_i.h   | 21 ++++++++++--
 net/mac80211/tx.c            | 10 ++++++
 net/wireless/nl80211.c       | 50 ++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+), 8 deletions(-)


base-commit: 0dd45ebc08de2449efe1a0908147796856a5f824
-- 
2.39.0

