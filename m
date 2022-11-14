Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C24628D2C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 00:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiKNXHz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 18:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiKNXHb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 18:07:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAED1CB1E
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 15:04:50 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AELkQCf023750;
        Mon, 14 Nov 2022 23:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=QRToJZdZVKUhRTQV5e7EgrEA8RrSB1JXv6E57i5sALw=;
 b=GWPQ3atioQHsfY1RA8DvjV3qdp21wwiaN/bKa2mX+P/DYaz/o8I1g+2XFVgGluCaITFP
 5C8IALHRrgfPugqfK/j+D+JRXepIKFlTlwUHiOxTQHt1AAFTulKwAN+z5enSOgTUH2NK
 qIFMvFt0h5uM1Sc39qJbJAgudc5BnetNju5C1njcoHGNE8eAu/xGVxNjUg/t5/UBI/2u
 WfLA4TbRU+fyudmZdG0CljTWZ7alBz4dV0KEvU0Yk/NbAV1VOT1qYuzYlqDaKu19MlfR
 XCo159buAAuS0BxLei41zXpSUPX6/ZtaA2TvdCXQkBU1jHgAi+6DkYZI5mN+Jtc0Jjxh IQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kusm28w45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:04:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEN4Pt7000475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 23:04:25 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 15:04:25 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] RNR for EMA AP 
Date:   Mon, 14 Nov 2022 15:04:14 -0800
Message-ID: <20221114230416.20192-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IIeB2SJDZDKsHtWNrZA4z2XnSU2Apg6s
X-Proofpoint-GUID: IIeB2SJDZDKsHtWNrZA4z2XnSU2Apg6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=539 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prerequisite patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20221114201912.22893-2-quic_alokad@quicinc.com/

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


base-commit: 901c247f9687b5aecc950a931a3b0e1930d02bfd
prerequisite-patch-id: ee07532847cf9c473ca00649746ad1cf737c6bf6
-- 
2.17.1

