Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507B65B5771
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiILJt4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiILJtz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 05:49:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154B12D2E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 02:49:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C8VQ9k026206;
        Mon, 12 Sep 2022 09:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=dXs9pfn6TO23ohh9IUm5JgvhvDIhx6vI4dT7SVtSjZ8=;
 b=CPzPdQz4e8dtYdBJK0VxBLPj4HkL9TqrjNz1Wyk3Bhawl0eccw1EdWLSu9Uv8awp99el
 Tr6bmZULIggu5sfJ85RcUAxERtZBaqzYpjdPeQLs+jVN2uF6fgykSMl17EgzhRxE5mDQ
 y5JeDYSjyU0VUhtDyek7Z5Ghh1fcjBMOe644h7mPpQH7VB2KDZfmbzCWM7aDM7MmHhwQ
 5xoBQfhQqOQ9AfIhiFrWqeTBeDcsudcB2n0zSp8LklOCcJWIuJhEEWru3ekOmhLayMhH
 ENBAL3OqjKP8NilcnemmyjPahA6qHNgD6u24USYn02sMOrxboxdtPzX+xWVA6mw8F69i lw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk0dbw2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 09:49:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28C9apot002477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 09:36:51 GMT
Received: from [10.253.8.149] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 02:36:49 -0700
Message-ID: <24df3a0c-a312-d9b6-5840-1eacd79d824b@quicinc.com>
Date:   Mon, 12 Sep 2022 17:36:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
From:   Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: mac80211: RCU-ify link STA pointers
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0rxJOHafjPyn2veD0bn0yeUKqCTpab97
X-Proofpoint-ORIG-GUID: 0rxJOHafjPyn2veD0bn0yeUKqCTpab97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_06,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Currently for MLO test, the others links's rx_nss of struct
ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
becaue they are not pass into ieee80211_sta_set_rx_nss() in
mac80211 except the deflink which means the primary link.
This lead driver get nss = 0 for other links. Will you fix it
or is it design by default?

Only primary link has valid rx_nss value which is not 0 by below call stack.
ieee80211_assoc_success()->
     rate_control_rate_init(sta);

commit:c71420db653aba30a234d1e4cf86dde376e604fa
wifi: mac80211: RCU-ify link STA pointers

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index c58d9689f51f..7947e9a162a9 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -37,7 +37,7 @@ void rate_control_rate_init(struct sta_info *sta)
      struct ieee80211_supported_band *sband;
      struct ieee80211_chanctx_conf *chanctx_conf;

-    ieee80211_sta_set_rx_nss(sta, 0);
+    ieee80211_sta_set_rx_nss(&sta->deflink);

      if (!ref)
          return;


