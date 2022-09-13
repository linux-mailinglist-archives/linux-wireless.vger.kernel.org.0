Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D411C5B68B5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIMHcm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiIMHck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 03:32:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B202F58B4B
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 00:32:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D5nUjc015254;
        Tue, 13 Sep 2022 07:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VZexL1FZCEAp4Pjz4fDVX9RU38e2PCSwwVn1c+b9fN8=;
 b=dzdb/OXbQ/V1mEgNtHPjwgyhD2nh+KGpklNRHMCEMdihz547LddR/czEJi+elvhEvy4j
 2c979AgJWnT2ChQ84FK7HrAEijD3CmzIkOXL/Gm6Tuzix8jRYIasEBlyTIdLNgnB6Osl
 JkaDslLokOiAZ0BmAS06jaLo8wgRqNgjjqHArQU7EOmDC9uDo7jZGG/CwNu+ziamWTDe
 bQZQqeWSCTC1CuzfQIS+KIipzV0SduDLlqf3u2zbhoWOZM0yFtRXhf7pOI9+tXXh/xXI
 GP89RHB5ZVPOkJLRRZzcQHakFbz+WSojGqbiQKOoX+MiMeC5tBjpLt5hCvs8aiM4Zjiq +A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjm1wr882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 07:32:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D7WEhH007414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 07:32:14 GMT
Received: from [10.253.33.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 00:32:13 -0700
Message-ID: <cfef10f1-9b1d-091e-da66-a724e3fbe204@quicinc.com>
Date:   Tue, 13 Sep 2022 15:32:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] wifi: ath11k: Implement sram dump interface
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220802075533.1744-1-quic_bqiang@quicinc.com>
 <20220802075533.1744-3-quic_bqiang@quicinc.com> <87fsh0962e.fsf@kernel.org>
 <0e64e270-77c3-5c1a-08bc-577a82c8abac@quicinc.com>
 <87pmfz7nll.fsf@kernel.org>
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87pmfz7nll.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0YfKRH_MoTBPdt9TMUjHo0YkYiFNqQOi
X-Proofpoint-ORIG-GUID: 0YfKRH_MoTBPdt9TMUjHo0YkYiFNqQOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130033
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/13/2022 3:14 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>>>> +	u32 i;
>>>> +
>>>> +	/* for offset beyond BAR + 4K - 32, may
>>>> +	 * need to wakeup the device to access.
>>>> +	 */
>>>> +	wakeup_required = test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
>>>> +			  end >= ATH11K_PCI_ACCESS_ALWAYS_OFF;
>>>> +	if (wakeup_required && ab->pci.ops->wakeup) {
>>>> +		ret = ab->pci.ops->wakeup(ab);
>>>> +		if (ret)
>>>> +			ath11k_warn(ab, "%s: failed to do wakeup: %d\n", __func__, ret);
>>>> +	}
>>> I changed the error handling so that if wakeup() fails we do not
>>> continue and just return an error.
>> I prefer to keep the original design, because in that case we still
>> have something to check after firmware crashes.
>>
>> I admit that the dump content may be invalid if wakeup fails, but we
>> can know that by checking kernel log, so we can avoid misleading.
> Too late now, I already applied the patch. You need to submit a new
> patch to change the logic. And if we really want to ignore the wakeup
> failure there should be a proper comment in the code explaining the idea,
> and maybe improve the warning message to make it more understandable for
> the user.
Sure Kalle, I will send a new patch for that.
