Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA66D4D2E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjDCQGm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 12:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjDCQGY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 12:06:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A368B2D49
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 09:06:10 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333D2Znh027799;
        Mon, 3 Apr 2023 16:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YBpa6PgIfuaR3CUTds9+lf9MsRdZK3byd0HnFJXvPEQ=;
 b=Bc2XiK9chRqI9lFMVWwsmKZ4wtgXkDdfusAkSFd//kJSp1Dw1d9MfZBTgpE8s6Yl/3L0
 bW3eCTEu4AX/ong3qJlPtlR/1p8EMtFStfzxaycLr5jkYpg9Ux24C1xvCjntVZb+O6jA
 wCix4Q03asKdub+bctBFKWiaHLjrJUGzUOFTSQ9YhZbPtbyIehmDqtnCSNyWa36MtPLg
 IREYoxtRIYJ1ahjKqzh7V0pL4491ANvDdM0/yGVn5kgbIjAJPzUZcfueqckv4zOFts26
 YfVCYNdlVcQHdf2hUxl/1r2BupKHeoQugCSx/yKMg9dEpCeihO7xb+BLVWcx7Kv2EpuB ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqwdrru8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 16:06:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333G62Ca000562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 16:06:02 GMT
Received: from [10.110.28.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 09:06:01 -0700
Message-ID: <667a38b0-b058-6083-6fa9-9b6d13c0c09e@quicinc.com>
Date:   Mon, 3 Apr 2023 09:06:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 0/2] wifi: ath11k: bug fixes in tx encap offload and
 ppdu stats
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230401024932.11722-1-quic_pradeepc@quicinc.com>
 <87edp1ba3j.fsf@kernel.org>
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <87edp1ba3j.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eXPdY_LBV9U6ek1qoAIg2XS2SKsK49xR
X-Proofpoint-ORIG-GUID: eXPdY_LBV9U6ek1qoAIg2XS2SKsK49xR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_13,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=864 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030118
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/3/2023 2:15 AM, Kalle Valo wrote:
> Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:
>
>> Fixes bugs in radiotap fields and tx status reporting in TX
>> encapsulation offload cases.
>>
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>
>> Pradeep Kumar Chitrapu (2):
>>    wifi: ath11k: fix tx status reporting in encap offload mode
>>    wifi: ath11k: Fix incorrect update of radiotap fields
> No changelog. What has changed since v1?

Thanks Kalle. Sorry about missing changelog. let me send V3 with updated 
change log..

changes are : avoid using ieee80211_tx_status_8023 and use 
ieee80211_tx_status_ext instead,
and fix commit description inorder to address previous review comments.

