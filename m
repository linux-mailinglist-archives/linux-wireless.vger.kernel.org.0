Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A785EE088
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiI1Pdx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiI1Pde (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 11:33:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506606A48F
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 08:33:33 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SBxnY4012741;
        Wed, 28 Sep 2022 15:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=obeRdzhQRRY0RF4Sz+3Z6xgRfmUfdlwLmml6UOVHXeQ=;
 b=lK8Zumk97WtLAqtf9GL2wdkg3H7Eug8F/Kcsiv1hUimKoBwJJb42NZ0zpi94YjmPvurv
 Q/XAg1N2cg+S1xfHjZgDEo+uwclFPPDVGi8vEEVxOSPqoaYaWLHMmyqRmmqqJbhDkL4j
 NKdiQxZcrooGKnhAUdUFJH2E5uTVQLf9pI2biSRItc8s48agDLQ6nCUGmAsp7b2rB57S
 Rp7SqI+Ta9QXlWg+y0WiXW44Y88aAX69W6a9a282oobc4dpzJAb0AnwmgsnuWkEwvqRP
 QB7mAPr+IaBDHDzUDbIxL2OEXfyyoTdft7Eq6kVK50OlgXnxbqF8zsTlELE3C2Be0QXp Jg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jva41jn41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:33:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SFXRPr016956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:33:27 GMT
Received: from [10.253.33.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 08:33:26 -0700
Message-ID: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
Date:   Wed, 28 Sep 2022 23:33:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>
From:   Wen Gong <quic_wgong@quicinc.com>
Subject: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cYdTk8vdQ9ALhRcE8V8pXHehGhUJ0ww7
X-Proofpoint-ORIG-GUID: cYdTk8vdQ9ALhRcE8V8pXHehGhUJ0ww7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=738
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280092
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

May I know the status for below work which is written in the patch below?
I think it is needed in 
ieee80211_assoc_config_link()/ieee80211_assoc_success(), right?

Extending that to multiple links will require
* work on parsing the multi-link element with STA profile properly, 
including element fragmentation;
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=81151ce462e5
