Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9586BB4A0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjCON3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjCON3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2B98C81A
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:39 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FAMS3A012014;
        Wed, 15 Mar 2023 13:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=p6r2L/y+sHWOHtnO5ltvrBx6yVEp1zIcqMpxiPavqCg=;
 b=pSIoZg9WdJUQmvVYEUtAz64HXr75i/f7vmjZcqD15TV5gvaNIGLhaVtSukzXrbDm8sxi
 ndpz8GySR/uPufqvdw1XRiQSFRhwbpid40J0j99QdmVovO/Fx1u3IvrcGudV3tFlFjuV
 w/+FsSkmEVJHP2wCX3jytrFVqbv7mKPYwzIez8kytF8pDgC5CGyKb6wwR5viTgydO1s1
 9WkYiOTD6fSrv0Xd72iqz4NQhbL4uvwV5hR+Tkie8uMi7JliKxc+v72d3jgC7om8F0VX
 RgHAgPChaQL0ZsgXrm3K5gvexVMlihIcRFIQ/XUQ7+xRcB60lA7qhz4zUJ5MLY6b9y2/ yw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2cshp0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTZ3p000858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:35 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:34 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 8/9] wifi: cfg80211: fix chandef identical logic for 6 GHz chandefs
Date:   Wed, 15 Mar 2023 18:59:03 +0530
Message-ID: <20230315132904.31779-9-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D0M49tHd1OFa7vjKQ-j-TpSOkE2enAb8
X-Proofpoint-ORIG-GUID: D0M49tHd1OFa7vjKQ-j-TpSOkE2enAb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=971
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, two chandefs are identical if they point to the same
ieee80211_channel as well as other members of the chandef are same.
However, with 6 GHz regulatory power modes changes, now 6 GHz channel
can be picked from different channel pool and hence there can be a
scenario where chandefs are actually idenatical but the channels are
from a different pool (for example - AP-STA concurrency case).
In this situation, the above logic will fail.

Hence, for 6 GHz, instead of comparing the pointers, members inside
ieee80211_channel can be compared and if they are same along with above
condition then chandef can be assumed to be identical.

Fix the same for 6 GHz channel comparison.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0120a520c58e..2f11b2451efe 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -903,6 +903,31 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 			     struct ieee80211_channel *channel,
 			     enum nl80211_channel_type chantype);
 
+/**
+ * cfg80211_6ghz_channel_identical - check if two 6 GHz channel definitions are
+ *				     identical
+ * @channel1: first channel definition
+ * @channel2: second channel definition
+ *
+ * Return: %true if the channels are identical except for the flags and power
+ * related settings, %false otherwise.
+ */
+static inline bool
+cfg80211_6ghz_channel_identical(struct ieee80211_channel *channel1,
+				struct ieee80211_channel *channel2)
+{
+	if (!channel1 || !channel2)
+		return false;
+
+	if (channel1->band == channel2->band &&
+	    channel1->band != NL80211_BAND_6GHZ)
+		return false;
+
+	return (channel1->band == channel2->band &&
+		channel1->center_freq == channel2->center_freq &&
+		channel1->freq_offset == channel2->freq_offset);
+}
+
 /**
  * cfg80211_chandef_identical - check if two channel definitions are identical
  * @chandef1: first channel definition
@@ -915,11 +940,17 @@ static inline bool
 cfg80211_chandef_identical(const struct cfg80211_chan_def *chandef1,
 			   const struct cfg80211_chan_def *chandef2)
 {
-	return (chandef1->chan == chandef2->chan &&
-		chandef1->width == chandef2->width &&
-		chandef1->center_freq1 == chandef2->center_freq1 &&
-		chandef1->freq1_offset == chandef2->freq1_offset &&
-		chandef1->center_freq2 == chandef2->center_freq2);
+	bool same_chan = chandef1->chan == chandef2->chan;
+	bool same_chand_def_prop = chandef1->width == chandef2->width &&
+				   chandef1->center_freq1 == chandef2->center_freq1 &&
+				   chandef1->freq1_offset == chandef2->freq1_offset &&
+				   chandef1->center_freq2 == chandef2->center_freq2;
+
+	if (!same_chan)
+		same_chan = cfg80211_6ghz_channel_identical(chandef1->chan,
+							    chandef2->chan);
+
+	return (same_chan && same_chand_def_prop);
 }
 
 /**
-- 
2.17.1

