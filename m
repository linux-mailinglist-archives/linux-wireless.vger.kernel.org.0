Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518467754D6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjHIINF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHIINE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 04:13:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF91986
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 01:13:00 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3794bQ0k023884;
        Wed, 9 Aug 2023 08:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=gDSpu8sk6T6WZQ5BWUBLmk+h2mrrdSK5/drneC3ck0k=;
 b=heyLDr2IUrXHI1AHoGNIKsHa1ZcfuMue1mBotrEmh6PKj82MM7Htz6XjJsphzIv06OK/
 6H+Pf5vzJQ8J1vhqXId98Cr8udGTiHsyoQ5jaAzctTTBO01mADm5x5PCKMrdHcZDEnm3
 r/ImPB6GhdraYu168XFGsCh5dtEP+dgYKVnuuZd/HqGRmBrEzx9hZ17LiIwyJ6gn91o7
 dvJoWXLm0EDb5e+axsty6UP8hSFGH1j8tSis6VIqU7xbAFPW4xRhXiRJyJDtTJ2SpWCV
 WJecALzZu289r+H6Q6hg5GVZbAxAoMmfj7uMUsmQ+zLUzK5pRx8KUEJMUpnA4l/JWzGl SQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbcacu5w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:12:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3798Ctor021442
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 08:12:55 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 01:12:53 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Fix buffer overflow when scanning with extraie
Date:   Wed, 9 Aug 2023 04:12:41 -0400
Message-ID: <20230809081241.32765-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8-2i9UXMESzSziI8z18lwDnNuo2dbaOR
X-Proofpoint-ORIG-GUID: 8-2i9UXMESzSziI8z18lwDnNuo2dbaOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_06,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If cfg80211 is providing extraie's for a scanning process then ath12k will
copy that over to the firmware. The extraie.len is a 32 bit value in struct
element_info and describes the amount of bytes for the vendor information
elements.

The problem is the allocation of the buffer. It has to align the TLV
sections by 4 bytes. But the code was using an u8 to store the newly
calculated length of this section (with alignment). And the new
calculated length was then used to allocate the skbuff. But the actual
code to copy in the data is using the extraie.len and not the calculated
"aligned" length.

The length of extraie with IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS enabled
was 264 bytes during tests with a wifi card. But it only allocated 8
bytes (264 bytes % 256) for it. As consequence, the code to memcpy the
extraie into the skb was then just overwriting data after skb->end. Things
like shinfo were therefore corrupted. This could usually be seen by a crash
in skb_zcopy_clear which tried to call a ubuf_info callback (using a bogus
address).

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: seperate to another patch per johannes.

 drivers/net/wireless/ath/ath12k/wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9ed33e2d6da0..cc9a377c06fd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2221,8 +2221,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	struct wmi_tlv *tlv;
 	void *ptr;
 	int i, ret, len;
-	u32 *tmp_ptr;
-	u8 extraie_len_with_pad = 0;
+	u32 *tmp_ptr, extraie_len_with_pad = 0;
 	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
 	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
 

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

