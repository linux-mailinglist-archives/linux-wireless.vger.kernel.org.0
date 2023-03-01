Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6BB6A6955
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCAJDG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCAJDD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:03:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0062A5FE
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:03:02 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3215V2K0014914;
        Wed, 1 Mar 2023 09:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Mfp5IdVj8Zpc/ABjF/cpxUOl3mlW2v7VhyyntE4ax6k=;
 b=K39EEx5I+xQZGnwTSC8aMTpcbMef6ViKifIga3MKsEW7ffk3P++gOqNhQBtXlU2BWxoc
 Q71QIaZajQZ7B9X6aAw2hGKU+bW360ZO16gBdu1PCX66Kidbw+lnpSA92Ble95CmPWpT
 mXUrHylPgS7IcTynNyfTcgwUN2ejSDg/EJWHCMG15ZEItRPNStdPj4pAkdw/H9xX4Y1e
 DjW0RmholV2Fxps56fGYwJcPQKeyOx7jtVeOci70RDwwTdClzW94jLOOWTNlGbsuCPqd
 Bw9e9EAbXYycAjgf0dR56WbwqglD+bhshDHaVjRU14x7pbpU7W3qKN7mS8fNwUf2+LnZ Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p20j2gr1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 09:02:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32192w3O012515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 09:02:58 GMT
Received: from xinyling-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 01:02:57 -0800
From:   Xinyue Ling <quic_xinyling@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] nl80211: Add 4/8/16 MHz BSS control channel width definitions
Date:   Wed, 1 Mar 2023 17:02:39 +0800
Message-ID: <20230301090242.1613672-2-quic_xinyling@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301090242.1613672-1-quic_xinyling@quicinc.com>
References: <20230301090242.1613672-1-quic_xinyling@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DSfqUBBxDiOUM_AkMou3XtZCdSq-l93I
X-Proofpoint-GUID: DSfqUBBxDiOUM_AkMou3XtZCdSq-l93I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=518 priorityscore=1501 impostorscore=0 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add definitions in enum nl80211_bss_scan_width to support
4/8/16 MHz BSS control channel width defined in IEEE Std
802.11ah-2016.

Signed-off-by: Xinyue Ling <quic_xinyling@quicinc.com>
---
 include/uapi/linux/nl80211.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8ecb0fbee721..3f15ac05f581 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4903,6 +4903,9 @@ enum nl80211_chan_width {
  * @NL80211_BSS_CHAN_WIDTH_5: control channel is 5 MHz wide
  * @NL80211_BSS_CHAN_WIDTH_1: control channel is 1 MHz wide
  * @NL80211_BSS_CHAN_WIDTH_2: control channel is 2 MHz wide
+ * @NL80211_BSS_CHAN_WIDTH_4: control channel is 4 MHz wide
+ * @NL80211_BSS_CHAN_WIDTH_8: control channel is 8 MHz wide
+ * @NL80211_BSS_CHAN_WIDTH_16: control channel is 16 MHz wide
  */
 enum nl80211_bss_scan_width {
 	NL80211_BSS_CHAN_WIDTH_20,
@@ -4910,6 +4913,9 @@ enum nl80211_bss_scan_width {
 	NL80211_BSS_CHAN_WIDTH_5,
 	NL80211_BSS_CHAN_WIDTH_1,
 	NL80211_BSS_CHAN_WIDTH_2,
+	NL80211_BSS_CHAN_WIDTH_4,
+	NL80211_BSS_CHAN_WIDTH_8,
+	NL80211_BSS_CHAN_WIDTH_16,
 };
 
 /**
-- 
2.25.1

