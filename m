Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FE62F290
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 11:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbiKRK3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 05:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiKRK3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 05:29:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4852716F
        for <linux-wireless@vger.kernel.org>; Fri, 18 Nov 2022 02:29:35 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI9uI9h031832;
        Fri, 18 Nov 2022 10:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GiHEF5dV2KVSqC69lRuMtCY71E0Dcp9oocwYhqMtKdE=;
 b=R1W9wfd32nR5fIfbaY4rE5J+EFs6zcWd754uqBgzlEPGdZ/qekCHRgwOCd/4Fn8rpOw+
 AV26FVQGx/ilZvHjsiQvfSOwhQg7V3XGpqssJjwLDL2qbMe6PuCABh/aho9HpK/QPKuy
 Cdc5Qbl8DNHx+kqQMyNi4fMZGQpphn2xA969kE7SOaP1v3tarzadyXOfL6XHJ+XxIeik
 u5RK5MLaIYHAVmPbeTT0BOgZsUJZHmLz6TA7fKwyXvgOHBcAkyAuKJ3gAM/XVhdnf63e
 hLtRFJyDMZp8k1Iz6DxHyo9VnwGYjvdtYZp4dOldAolxyhk+VzWCqEf26yZLzvZBhGaq tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0ra9bdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 10:29:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AIATQQB028950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 10:29:26 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 18 Nov
 2022 02:29:25 -0800
Message-ID: <cd96eea8-dce0-bcb9-e8ce-05fa0e0f22fb@quicinc.com>
Date:   Fri, 18 Nov 2022 18:29:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] wifi: ath11k: reduce the timeout value back for hw
 scan from 10 seconds to 1 second
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20221011072408.23731-1-quic_wgong@quicinc.com>
 <20221011072408.23731-3-quic_wgong@quicinc.com> <8735atg335.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <8735atg335.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KQh0TAfKxqRp9oqshfrI3S-_DLHSQojH
X-Proofpoint-GUID: KQh0TAfKxqRp9oqshfrI3S-_DLHSQojH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/2022 6:20 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
...
> [...]
>
>> @@ -3682,7 +3677,12 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
>>   
>>   	ret = ath11k_start_scan(ar, &arg);
>>   	if (ret) {
>> -		ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
>> +		if (ret == -EBUSY)
>> +			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
>> +				   "scan engine is busy 11d state %d\n", ar->state_11d);
>> +		else
>> +			ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
>> +
>>   		spin_lock_bh(&ar->data_lock);
>>   		ar->scan.state = ATH11K_SCAN_IDLE;
>>   		spin_unlock_bh(&ar->data_lock);
> This feels like a hack to me, for example will these failed scans now
> cause delays is connection establishment? IMHO it's crucial from user's
> point of view that we don't delay that in any way.
It will not delay connection.
After wlan load, the 1st hw scan will arrived to ath11k, and then 11d
scan will be sent to firmware after the 1st hw scan. It means the hw
scan for connection is run before 11d scan, and then connection could
be started immediately after the 1st hw scan finished. It means no
delay for connection.
> I would rather fix the root cause, do we know what's causing this?
In firmware, hw scan and 11d scan are all running in the same queue,
they can not be run parallel.

When 6 GHz enabled, the 1st hw scan cost about 7s and finished, and
then 11d scan cost the next 7s. After the 14s, the each hw scan arrived
to ath11k will be run immediately. If the 2nd hw scan arrived before
the 11d scan finished, for example, it arrived 7.1 seconds after the
1st hw scan, at this moment, the 11d scan is still running in firmware,
then the 2nd hw scan will not receive scan started event untill the 11d
scan finished, and meanwhile, the 2nd hw scan is holding the ar->conf_mutex
in ath11k_mac_op_hw_scan(), it is not good to hold a lock for some
seconds because ar->conf_mutex is widely used. So reduce the 10s to 1s
to avoid holding ar->conf_mutex for long time.
