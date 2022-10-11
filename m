Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF085FAB71
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 05:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJKDxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 23:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKDxW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 23:53:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85333E027
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 20:53:21 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B3BOJl023795;
        Tue, 11 Oct 2022 03:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M/ulPx5lMLRRg3CDFasPu9OrO7retqKWObnoFd7r1LY=;
 b=cKEJ15f4iojA7uAHZC2gZeGWWdbKO5A9/Vju5GjP7jmyRLn18hC3ssyPpsrGWEBixcx0
 9ZoOc1geJsUZutXBqsC8cJ7qFVahY7OUp1omGSlRPmqTEzzL5A383v4fkz0pBkVc1swj
 ATJUqZfGJHe4st3WkyLMxoEQB4J9S7S2nfg6VS17afB04ZpIJA/xiHTVouafnoE4mwvg
 B7An/GQBMJmyPfq8SAOm2PFdAmOHA6FxxNgfqCvvXdLQ7oe3EyNYpIw/iaO5vUyE4fpe
 yhxnS/KjGCdrF/SFQaZaG+5JsPIT7YveVH3MyHaTBOoZHMpXE8Rn95kTtQ0LQD0yrbhH Gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rxa0y23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 03:53:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B3rCkn017198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 03:53:12 GMT
Received: from [10.253.78.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 20:53:11 -0700
Message-ID: <f50c94b9-252f-25ab-4650-bed52762bc4d@quicinc.com>
Date:   Tue, 11 Oct 2022 11:53:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] wifi: ath11k: change to set 11d state instead of
 start 11d scan while disconnect
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220928081413.27339-2-quic_wgong@quicinc.com>
 <166542536986.511.1244496445875563981.kvalo@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <166542536986.511.1244496445875563981.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gqjrnhS7kuiDi70YT9mkDYJAW9fApUk9
X-Proofpoint-GUID: gqjrnhS7kuiDi70YT9mkDYJAW9fApUk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_01,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210110020
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/11/2022 2:09 AM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
>> When switch to connect to a new AP for station which is already connected
>> to an AP, the time cost is too long, it arrives 10 seconds.
>>
>> The reason is when switch connection, disconnect operation happened on
>> the 1st AP, then 11d scan start command sent to firmware, and then a
>> new hw scan arrived for the 2nd AP. The 11d scan is running at this
>> moment, so the hw scan can not start immediately, it needs to wait
>> the 11d scan finished, it increased the time cost of switch AP and
>> even happened scan fail as log below after apply the incoming patch.
>>
>> [ 1194.815104] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>> [ 1196.864157] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>> [ 1198.911926] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>
>> Change to set 11d state while disconnect, and the 11d scan will be
>> started after the new hw scan in ath11k_mac_op_hw_scan(). Then the
>> time cost of switching AP is small and not happened scan fail.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>
>> Fixes: 9dcf6808b253 ("ath11k: add 11d scan offload support")
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> I still see warnings:
>
> [ 3627.691737] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 3715.435608] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 3860.333214] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 4542.000955] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 4604.018451] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
The failed log is now happened frequently as before, I will change it 
again to suppress the failed log.
> 2 patches set to Changes Requested.
>
> 12991768 [v2,1/2] wifi: ath11k: change to set 11d state instead of start 11d scan while disconnect
> 12991769 [v2,2/2] wifi: ath11k: reduce the timeout value back for hw scan from 10 seconds to 1 second
>
