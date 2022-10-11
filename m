Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567555FB2D8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJKNFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJKNFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 09:05:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49701FCE6
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 06:05:10 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BBjKB6019254;
        Tue, 11 Oct 2022 13:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=I1/gCtkfa7CgIRoxO3wfAR33NNRUjl2+/cjtCGvu19w=;
 b=GQAAUXJQTm37PnX+sDV7uHTfTAiPrabjbO4FEmxjmJ5EczBGpuOUII7vD9AfWfuWHAXq
 H1Mt2ezRV7BKWwCCv3MFbp7f/6PYoqDlDK17vtZy5FyBkjGlqzsb1vgWfAX8Ytr6zVr4
 S/8MVrCdQD0QSNgoXwqf3kBwartZwUNVyL1TP8cgsZKbMrxBMyeo3k1SWAiulPT4cwii
 BJdig0XOEK+6uNx5FwJqIN2oYbxdyXT4vPCchHSJQtI6gs9xzcv2YAEwaxybuZ/EzozZ
 vCF2G8cN8iIdDfBu2lRLqu0QQ/ZV+fEKJMVoHpd8TdciwnmqKOUJrXZzVyGna+Yl0310 Uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx4t5da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 13:05:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BD56x1012919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 13:05:06 GMT
Received: from paulz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 11 Oct 2022 06:05:05 -0700
From:   Paul Zhang <quic_paulz@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v1] cfg80211: Fix bitrates overflow issue
Date:   Tue, 11 Oct 2022 21:04:28 +0800
Message-ID: <1665493468-24774-1-git-send-email-quic_paulz@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QD1cMWxSzdyJfFD_v-dQu27OxNa9DtpV
X-Proofpoint-ORIG-GUID: QD1cMWxSzdyJfFD_v-dQu27OxNa9DtpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_07,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=707
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When invoking function cfg80211_calculate_bitrate_eht about
(320 MHz, EHT-MCS 13, EHT-NSS 2, EHT-GI 0), which means the
parameters as flags: 0x80, bw: 7, mcs: 13, eht_gi: 0, nss: 2,
this formula (result * rate->nss) will overflow and causes
the returned bitrate to be 3959 when it should be 57646.

Here is the explanation:
 u64 tmp;
 u32 result;
 …
 /* tmp = result = 4 * rates_996[0]
  *     = 4 * 480388888 = 0x72889c60
  */
 tmp = result;

 /* tmp = 0x72889c60 * 6144 = 0xabccea90000 */
 tmp *= SCALE;

 /* tmp = 0xabccea90000 / mcs_divisors[13]
  *     = 0xabccea90000 / 5120 = 0x8970bba6
  */
 do_div(tmp, mcs_divisors[rate->mcs]);

 /* result = 0x8970bba6 */
 result = tmp;

 /* normally (result * rate->nss) = 0x8970bba6 * 2 = 0x112e1774c,
  * but since result is u32, (result * rate->nss) = 0x12e1774c,
  * overflow happens and it loses the highest bit.
  * Then result =  0x12e1774c / 8 = 39595753,
  */
 result = (result * rate->nss) / 8;

Signed-off-by: Paul Zhang <quic_paulz@quicinc.com>
---
 net/wireless/util.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index f09d528..59d4947 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1557,10 +1557,12 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
 	tmp = result;
 	tmp *= SCALE;
 	do_div(tmp, mcs_divisors[rate->mcs]);
-	result = tmp;
 
 	/* and take NSS */
-	result = (result * rate->nss) / 8;
+	tmp *= rate->nss;
+	do_div(tmp, 8);
+
+	result = tmp;
 
 	return result / 10000;
 }
-- 
2.7.4

