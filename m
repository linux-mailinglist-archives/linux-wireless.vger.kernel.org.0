Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5C7E9E95
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 15:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjKMO1E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 09:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMO1D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 09:27:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED4D5E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 06:27:00 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADEQOn5013712;
        Mon, 13 Nov 2023 14:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kxa0v6rsK62hSA77IhoXhkBpBXYgkTMF3T7bmHgOOj8=;
 b=ck+zig0GwQDBuUY+qJZgPX+Hn8lXyVK262lAcPJzJ98Q7Gv6SkJKYehR11k7jHQ5Uqq4
 enPqLy9nBIVze8UUzKAMs4jAjKVWizl88O3EwIIRZXFhezC3FFYLasALnYHYTp9KEVZf
 YBYlBXQfONeY+QiQTgDQd+kEBNvWbISz8K0lYGS36JgFzemGXmjyBAY7Cq/sLOLqpKsW
 9xjCUBTyOz5hnM3sXYXGQplQH++dOgMdWEwXEnAosoZTJfOaBlSiM4tyoScVjJ1dpvQ9
 Huwf3UUTQ0aWDRYGk+0fAWfyEvWBR1JaTwtIDHc2V6Ei39VWPThYSnA+kq8zCqhXPsfD zQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2wfksj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 14:26:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ADEQl5m000586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 14:26:47 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 06:26:47 -0800
Message-ID: <fb3709a6-95d2-711f-3ca1-0107fa159c62@quicinc.com>
Date:   Mon, 13 Nov 2023 07:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH RFC 4/8] wifi: ath11k: remove MHI LOOPBACK channels
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     Baochen Qiang <quic_bqiang@quicinc.com>, <mhi@lists.linux.dev>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
 <20231110102202.3168243-5-kvalo@kernel.org>
 <f56bce13-bba8-40d2-1dfc-210478ff63d6@quicinc.com>
 <e2ad1380-d55f-42bd-9f40-ef8aa6e0f105@quicinc.com>
 <818fddb9-b59e-7a6f-6605-2ba016d0db60@quicinc.com>
 <87msvhu4d5.fsf@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <87msvhu4d5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N_oti0dSwLYzqAaf4SYfVnX_0rcXhlbF
X-Proofpoint-ORIG-GUID: N_oti0dSwLYzqAaf4SYfVnX_0rcXhlbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=903
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130117
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/13/2023 7:15 AM, Kalle Valo wrote:
> Jeffrey Hugo <quic_jhugo@quicinc.com> writes:
> 
>> On 11/11/2023 9:24 PM, Baochen Qiang wrote:
>>
>>> On 11/11/2023 12:54 AM, Jeffrey Hugo wrote:
>>>> On 11/10/2023 3:21 AM, Kalle Valo wrote:
>>>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>>
>>>>> There is no driver to match these two channels, so
>>>>> remove them. This fixes warnings from MHI subsystem during suspend:
>>>>>
>>>>> mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
>>>>> mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting
>>>>
>>>> This feels like just masking a real issue.
>>>>
>>>> If LOOPBACK is not being consumed, then the channel should never go
>>>> into the start state.  Why would we be trying to transition to the
>>>> reset state then?
>>>>
>>>> -Jeff
>>> That is because, with patch 'bus: mhi: host: add new interfaces to
>>> handle MHI channels directly' in this patch set, ath11k is able to
>>> call mhi_unprepare_all_from_transfer(), which will reset all
>>> channels.
>>
>> that implementation is flawed if it is causing this.  Looks like you
>> never check to see if the channel was prepared in the first place.
>>
>> If you go fix that, then it looks like this change is not needed.
> 
> BTW what do these loopback channels do? I didn't notice any difference
> in the functionality so I'm wondering the reason for these.
> 

The loopback channel is defined as a service where any data the host 
sends to the device is immediately sent back to the host, unmodified. 
The typical usecase is smoke test and performance profiling.

I do not object to the removal of the channel from the atheros devices, 
assuming suitable justification.  Not having a use for the channel seems 
like good justification.  Working around a bug seem more like a hack 
than proper justification.
