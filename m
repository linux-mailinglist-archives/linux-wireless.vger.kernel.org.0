Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47175B6705
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 06:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIMEiS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 00:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIMEhp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 00:37:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2DFD31
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 21:37:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D2gLCq005362;
        Tue, 13 Sep 2022 04:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=itC7PnvgnfUNIeHDfDsf2M96qNlAteZt2oe8k4pBR9k=;
 b=ia6zkg8xdhSzjTyuGMQ+qu32LfyJq+f3D1R2dXdEM7mqepHSnVd/rnU0LLY3NFq2fAq/
 WxhayrU+Vqt9LXA3fILUC3Dp6zMECOgAJ93S8kmOWbxkCPC5Qvfa7XjQiUIi11aFbNLX
 67CdQzP7iHChxkVfbsl1ytNSbVXBa4MAbSjoBDQ8hkn6wyRkcyx7C0TqQg1z4CLUy8hM
 3R/GI1R6THmPSR4lIcX/WAFzuHyD5Tb2dVK0ITaFYd3QqaBVbxwPUKs/fgA+sRTSfvjB
 cluz/EAEeV+QxiFj97iwdm2RENsKXpLXXqcYpVRBNGXS89U3di0/E1nR2Vf84PKsTpC7 bw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjh9tg7gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:37:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D4bLix032041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:37:21 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 21:37:19 -0700
Message-ID: <913ee04f-a16f-f765-96c2-0586282831b4@quicinc.com>
Date:   Tue, 13 Sep 2022 12:37:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
From:   Wen Gong <quic_wgong@quicinc.com>
Subject: mlo rx nss value 0 of wifi
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vfd04XiTQqNSo2vFPy-k745W6caqvisU
X-Proofpoint-GUID: Vfd04XiTQqNSo2vFPy-k745W6caqvisU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=799 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130020
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
mac80211 except the deflink which means the primary link in
rate_control_rate_init(). This lead driver get nss = 0 for
other links. Will you fix it or is it design by default?

Only primary link has valid rx_nss value which is not 0 by below call stack.
ieee80211_assoc_success()
     ->rate_control_rate_init(sta);
         ->ieee80211_sta_set_rx_nss(&sta->deflink);
