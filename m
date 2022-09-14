Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182FD5B7F99
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiINDo7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINDo5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:44:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF024F1B4
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:44:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2WXm4022024;
        Wed, 14 Sep 2022 03:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=o6RB6A0kpfsIefD+sTPm1sGlkCN0lI6Kz9AXWfCogaA=;
 b=gnl+YFTJs5T4WKlfS5jdg8oka67Khas/WzzgZCZDtAgOMRJ8RUNjsVK9FuodFQScddKI
 wXDe6jDVVYV9NkiOaVkxz28vlvx1Z8D7x6fPsqGsekxaja8TU8qhoTgsNLOMqJJ0HVVw
 Mz+9G4fqhaGlWvgVEfaOVo/RRDtnCdu4WH5V28cNYaChMuE9JHA/ayyhJctQ5NaF9ph1
 /Hy4eVBO0cfoK7MPnylTlNcVm1qK1lEU5/4Uccrd3yIURNnn14lg/z7Vu6laqGV5jwet
 TE6CWwt5s1QEfBwfxE5esAI3tsv/JAeiLjmGTLir9f+f4aSxICpl1dzKqop0DuM1Bw9Z XA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxys14t4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 03:44:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E3DTZF009823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 03:13:29 GMT
Received: from [10.253.15.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 20:13:28 -0700
Message-ID: <e1c5fbac-7e6e-c643-f24d-32cec779f2d3@quicinc.com>
Date:   Wed, 14 Sep 2022 11:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
From:   Wen Gong <quic_wgong@quicinc.com>
Subject: unicast probe response bssid changed by "wifi: mac80211: do link->MLD
 address translation on RX"
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5fHklR2gwj1hwg5rSl67vcDrkX9hr4yp
X-Proofpoint-GUID: 5fHklR2gwj1hwg5rSl67vcDrkX9hr4yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 adultscore=0 mlxlogscore=603 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140016
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

The mac addr of unicast rx packet all changed to the MLD address by 
below patch.
Now the probe presponse which is unicast packet is also changed mac 
address here.
I found bssid which is the MLD address of my test AP in cfg80211_get_bss().
For example, if the AP has 2 mlo links, link 1 is 5 GHz band, link 2 is 
2.4 GHz band,
then the 2 probe reponse will be changed to a same one.
seems we should skip probe presponse for the mac address change here, right?

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=42fb9148c078004d07b4c39bd7b1086b6165780c
wifi: mac80211: do link->MLD address translation on RX

