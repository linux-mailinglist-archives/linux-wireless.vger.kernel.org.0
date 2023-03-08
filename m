Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B476B04E6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 11:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCHKq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 05:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCHKq0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 05:46:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04355126E4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 02:46:21 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328372Y2006687;
        Wed, 8 Mar 2023 10:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=xZM1HY6qJQ3fvyf5jAI8AtKirb9pND5Dfaue6X6uQeQ=;
 b=D4NtN7ypSfyop/AI2awzNgojwMFx8hmkmhzk4ribfC1UBKYLfOSGqO7b1KsfPoVM34r6
 EBFvtctkEdP5Atyb4CHZW41hzRHLL8FS6N5Co7THSW7omdsoUa6ezofIT0pmGeBd1xOj
 R7Wd8hKmGgZZ9u1IPBgB84ck5h8MoHT0lfP1c12T9rTFX9hSpMcRBOI72/ym0C7KOArO
 GNmbn/U4hZCskt8c9QpE2zzZl7AxOBvTLmKKfgqpyvKrh9OdOWry7f3aO76J5rfcGQL/
 BJrTUr5qKM9O613kveh5r77iZ/5/+sZSKFXOEK6U6VXBJvV4+ByLcwKt5dGE2vaPBlar VQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fga1aep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 10:46:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328AkG8C024712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 10:46:16 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 02:46:14 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] wifi: nl80211: Update the documentation of NL80211_SCAN_FLAG_COLOCATED_6GHZ
Date:   Wed, 8 Mar 2023 16:15:56 +0530
Message-ID: <20230308104556.9399-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XFjwLZ5nE496i1C3o8JEXsr4Zm5k0Uuq
X-Proofpoint-ORIG-GUID: XFjwLZ5nE496i1C3o8JEXsr4Zm5k0Uuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_05,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=794 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently when NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in the scan flags,
in addition to the co-located APs, PSC channels in the 6 GHz band would
also be scanned if the user space has asked for it. In other words, the
scan would happen on PSC channels & co-located 6 GHz channels that were
reported in the RNR IE.

Update the documentation of NL80211_SCAN_FLAG_COLOCATED_6GHZ flag to
reflect the above said behavior.

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 include/uapi/linux/nl80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9a0ac0363f1f..14e958a32b84 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6544,7 +6544,9 @@ enum nl80211_timeout_reason {
  *	channels on which APs are expected to be found. Note that when not set,
  *	the scan logic would scan all 6GHz channels, but since transmission of
  *	probe requests on non PSC channels is limited, it is highly likely that
- *	these channels would passively be scanned.
+ *	these channels would passively be scanned. Also note that when the flag
+ *	is set, in addition to the colocated APs, PSC channels would also be
+ *	scanned if the user space has asked for it.
  */
 enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_LOW_PRIORITY				= 1<<0,

base-commit: da1185449c669076276027c600666286124eef9f
-- 
2.17.1

