Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10D37939FE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 12:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbjIFKfd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 06:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFKfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 06:35:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52234CE2
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 03:35:28 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3869QqhP007229;
        Wed, 6 Sep 2023 10:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=DjRVxvL85VlD/zWd0EAa8JCvkD/VGvroPecUIbNfsQk=;
 b=oQ6OxqSsWp9eUqn7CluGGp/pqfe38u9l5VMdzXa2hk0rWpuj+1G9fBoWz3Oc7K/BksQm
 Fzvt/vnm0kXMyWyu7vS1gfAnVQbQZR7QUDrZ2F/PldsfBlB+6XA/L1GjH+VLckUdPKhY
 JvYvElingEXLlXx/mtowpZiKirkoHohj0iOv8Ds2+Y5y3RJ1WsuyTneeDfqgWSIY4Ihp
 r5hBcGg3hXo5JUri2TntxZECfns+v+9IJFYY/1pwtsGcGHxKm1k8r/C5CmddYj5Pmxg/
 JbizxfS4mB97jggc1XiWdc8YSGBncvDduXhCDYf8ZGWIHJK7D77Aj6xVxO48UnqO5Eus og== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxpt008ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 10:35:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386AZI2t030288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 10:35:18 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 03:35:17 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 3/3] wifi: mac80211: update link RX NSS by ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link()
Date:   Wed, 6 Sep 2023 06:34:58 -0400
Message-ID: <20230906103458.24092-4-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906103458.24092-1-quic_wgong@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dMAxWrup3Rz-CVJIFjk8lwBVIWq9YpAL
X-Proofpoint-GUID: dMAxWrup3Rz-CVJIFjk8lwBVIWq9YpAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently for MLO connection, only deflink's rx_nss is set to correct
value. The others links' rx_nss of struct ieee80211_link_sta is
value 0 in ieee80211_set_associated(), because they are not pass into
ieee80211_sta_set_rx_nss() in mac80211 except the deflink in
rate_control_rate_init(). This leads driver get NSS = 0 for other links.
Add the ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link(),
then the other links' rx_nss will be set to the correct value.

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 net/mac80211/mlme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1679d5011fb6..0a2fb660fa00 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4354,6 +4354,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	bss_conf->assoc_capability = capab_info;
 
 	ret = true;
+
+	ieee80211_sta_set_rx_nss(link_sta);
 out:
 	kfree(elems);
 	kfree(bss_ies);
-- 
2.40.1

