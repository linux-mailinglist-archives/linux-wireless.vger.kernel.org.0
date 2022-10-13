Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7F5FE32C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJMUR2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 16:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMUR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 16:17:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0F4C626
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 13:17:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DJdDoN031353;
        Thu, 13 Oct 2022 20:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3kgg5bSTIzW7cbB9iUyBrzYk0w1V6YuhaD8JYRcqW38=;
 b=FqrATT8ITl4O7cjhdSVAzg0BEZTgghzScUiumMht89gEtBAGJwYJKLonwGrDbyW53xE/
 dTALs4CrCZlo2XwbAJr0emlatYHvyv/xNDglPSb+aj2xd6mQX+pgXSFbrjT0RdKMfrYV
 CVVAnmu4OIt3J3ShfAtGuvME7WGbETGW5aiPbZTbTawMqe9EYzOVIiMrEXEWuwyzLDUa
 k9K7GZO2CxsFKR/rBRAT4El3fOo8PwA8nzNjqvZ5+BzAARDvRHjy2pCnOa1ogdZ84DJX
 e6/SSCR7amPWLCisFC6f+C0BCJyqZDTYMFfpDu24/P4QXSlPX/UOsaTVoZDTHBVNSVMS Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6br7tcc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 20:17:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29DKHHwd026315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 20:17:17 GMT
Received: from [10.110.65.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 13:17:16 -0700
Message-ID: <8c3127db-85f8-c5ce-7939-7151060887e2@quicinc.com>
Date:   Thu, 13 Oct 2022 13:17:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 11/50] wifi: ath12k: add dp.c
Content-Language: en-US
To:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-12-kvalo@kernel.org>
 <65a4750f-1798-a624-0a2e-96930f8ec816@quicinc.com>
 <CH0PR02MB82123C176B0E05156B66C9F1F6229@CH0PR02MB8212.namprd02.prod.outlook.com>
 <94e894a8-a262-959e-a6ab-869dcba9e0fa@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <94e894a8-a262-959e-a6ab-869dcba9e0fa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cNgs7FlYvpKMO6ORE7gnxooGHx3fTXIl
X-Proofpoint-ORIG-GUID: cNgs7FlYvpKMO6ORE7gnxooGHx3fTXIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=921 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130114
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/13/2022 9:30 AM, Pradeep Kumar Chitrapu wrote:
> 
>>> +                                     work_done =
>>> +                                     ath12k_dp_mon_process_ring(ab,
>>> + id, napi, budget,
>> descendant is not indented from the first line, making it difficult to 
>> see the code structure
>>
>>> +                                                                flag);
>>> +                                     budget -= work_done;
>>> +                                     tot_work_done += work_done;
>>> +
>>> +                                     if (budget <= 0)
>>> +                                             goto done;
>>> +                             }
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     if (ab->hw_params->ring_mask->tx_mon_dest[grp_id]) {
>> this block of code has the same issues as the RX block. in fact it 
>> seems that this block is identical to the block above other than the 
>> flag and the tx_mon_desc vs rx_mon_desc, so I'm curious if it could be 
>> refactored into a single function that could be used by both tx and rx 
>> instead of duplicating code
> 
> Hi Jeff
> 
> Thanks for your review..
> 
> Although, rx and tx mon rings processing blocks can be moved to common 
> function, this causes lot of variables to be sent to function using pass 
> by reference, hence avoiding this gerrit for tradeoff. Please let me 
> know if this is ok?

yes, that is ok. it is always a tradeoff and different folks will weigh 
the tradeoffs differently, and nobody is "right". As log as the code 
works :)

