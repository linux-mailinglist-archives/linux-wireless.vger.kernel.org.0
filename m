Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3991B668ED7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 08:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbjAMHGq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 02:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjAMHGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 02:06:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFE77AF4
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 22:55:01 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D6hqZk011487;
        Fri, 13 Jan 2023 06:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JtVpsKj4nc9eRg9XgHtoHlSj3I39NaFSNzx6h7rrpYY=;
 b=pO4xxIXcuDn1vvSD6qh4BX6r8KHPt7pIg9gQ6AqtFm2Yql3erOEDgd6BuFcXEkcu4HHS
 9iIqElq9Yl4qzRoSnm4VUwrttA5fDjBqcvSKkCxPI8DsYzbJPuHPhUhvvZPUVjwQzkx9
 hUhwUIDsD7vOld5cnUQZrH79HeWAGAviq8KMl3LuMEdeyLYgcc/W6C1kKkW81ddHs0CZ
 JGBquBfLMtG5ghrxf2ZUVYvNnsNKKaifQtxWe5bPNbbsdmTygT0d0UHpdBSxUD+sKDCT
 jSrPEijUtmhvRmsax51rnLedqow4ebuCD+CVlikk04spqnIVhgehvZOax9IJdNW4+v0P Ug== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2jghsvkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 06:54:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30D6srgc017912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 06:54:53 GMT
Received: from [10.253.13.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 12 Jan
 2023 22:54:52 -0800
Message-ID: <73908049-4a69-e65c-665b-97d068f1fef7@quicinc.com>
Date:   Fri, 13 Jan 2023 14:54:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 2/2] wifi: ath11k: reduce the timeout value back for hw
 scan from 10 seconds to 1 second
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20221011072408.23731-1-quic_wgong@quicinc.com>
 <20221011072408.23731-3-quic_wgong@quicinc.com> <8735atg335.fsf@kernel.org>
 <cd96eea8-dce0-bcb9-e8ce-05fa0e0f22fb@quicinc.com>
 <e7e34c3d-8b73-f7d5-9ce8-5ed346ca9d28@quicinc.com>
 <7bcd1a12-fb60-98cd-1a29-f55efa8d1499@quicinc.com>
In-Reply-To: <7bcd1a12-fb60-98cd-1a29-f55efa8d1499@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3qy1KTm5ZvedPstTWpC14X6mKceKTiw3
X-Proofpoint-ORIG-GUID: 3qy1KTm5ZvedPstTWpC14X6mKceKTiw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_02,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Should I change commit log with below explanation and send v4?

On 12/16/2022 11:08 AM, Wen Gong wrote:
> Hi Kalle,
>
> Should I change commit log with below explanation and send v4?
>
> On 11/23/2022 11:41 AM, Wen Gong wrote:
>> On 11/18/2022 6:29 PM, Wen Gong wrote:
>>> On 11/8/2022 6:20 PM, Kalle Valo wrote:
>>>> Wen Gong <quic_wgong@quicinc.com> writes:
>>>>
>>> ...
>>>> [...]
>>>>
>>>>> @@ -3682,7 +3677,12 @@ static int ath11k_mac_op_hw_scan(struct 
>>>>> ieee80211_hw *hw,
>>>>>         ret = ath11k_start_scan(ar, &arg);
>>>>>       if (ret) {
>>>>> -        ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
>>>>> +        if (ret == -EBUSY)
>>>>> +            ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
>>>>> +                   "scan engine is busy 11d state %d\n", 
>>>>> ar->state_11d);
>>>>> +        else
>>>>> +            ath11k_warn(ar->ab, "failed to start hw scan: %d\n", 
>>>>> ret);
>>>>> +
>>>>>           spin_lock_bh(&ar->data_lock);
>>>>>           ar->scan.state = ATH11K_SCAN_IDLE;
>>>>>           spin_unlock_bh(&ar->data_lock);
>>>> This feels like a hack to me, for example will these failed scans now
>>>> cause delays is connection establishment? IMHO it's crucial from 
>>>> user's
>>>> point of view that we don't delay that in any way.
>>> It will not delay connection.
>>> After wlan load, the 1st hw scan will arrived to ath11k, and then 11d
>>> scan will be sent to firmware after the 1st hw scan. It means the hw
>>> scan for connection is run before 11d scan, and then connection could
>>> be started immediately after the 1st hw scan finished. It means no
>>> delay for connection.
>>>> I would rather fix the root cause, do we know what's causing this?
>>> In firmware, hw scan and 11d scan are all running in the same queue,
>>> they can not be run parallel.
>>>
>>> When 6 GHz enabled, the 1st hw scan cost about 7s and finished, and
>>> then 11d scan cost the next 7s. After the 14s, the each hw scan arrived
>>> to ath11k will be run immediately. If the 2nd hw scan arrived before
>>> the 11d scan finished, for example, it arrived 7.1 seconds after the
>>> 1st hw scan, at this moment, the 11d scan is still running in firmware,
>>> then the 2nd hw scan will not receive scan started event untill the 11d
>>> scan finished, and meanwhile, the 2nd hw scan is holding the 
>>> ar->conf_mutex
>>> in ath11k_mac_op_hw_scan(), it is not good to hold a lock for some
>>> seconds because ar->conf_mutex is widely used. So reduce the 10s to 1s
>>> to avoid holding ar->conf_mutex for long time.
>>
>> Hi Kalle,
>>
>> Should I change commit log with above explanation and send v4?
>>
