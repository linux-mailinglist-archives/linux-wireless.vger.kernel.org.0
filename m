Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB755FDE58
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJMQiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 12:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJMQhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 12:37:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799514D1D4
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 09:37:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DEVHxg022486;
        Thu, 13 Oct 2022 16:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ayBcLUGEvmjIcvKQXrurvsUcP+i2UteOpC69eBEB8cE=;
 b=GUkwPLvB2/HhMcJA4RBU9tIAHe4htlu7SGvcDE0bYKz9Mhlg2eXWboNeoXR8ZPjEa/Dt
 sjJXu/TL0gIFCmw6CurWLw8GtZo/5ib132IgKQkW7KRbFMUHAyafCQUYgj87Ew9TZ4YA
 l41gURE5RDEhgozrg32As+oj9p6xJ6hsRzjsG/DcJ63jYDeKI6xWchom8ew8pEitkYfE
 ilcJlMuJfdgAPBfSvxMW4WInhwIVZPAYgYAQP7rlObLKWhrVeDGvDU/M1vH6RA1O/fm5
 3ogjNJh78OWAmDFavLfMrD3p4YiZRFBS36F/ABAhqI++7qLWQQo/SqTS1j982ohZS2k2 ng== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6bj722vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 16:37:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29DGblTg001000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 16:37:47 GMT
Received: from [10.50.51.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 09:37:45 -0700
Message-ID: <c74d25e7-1947-6a4b-6e97-f1ab6f75cc89@quicinc.com>
Date:   Thu, 13 Oct 2022 22:07:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 11/50] wifi: ath12k: add dp.c
Content-Language: en-US
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-12-kvalo@kernel.org>
 <65a4750f-1798-a624-0a2e-96930f8ec816@quicinc.com>
 <CH0PR02MB82123C176B0E05156B66C9F1F6229@CH0PR02MB8212.namprd02.prod.outlook.com>
 <94e894a8-a262-959e-a6ab-869dcba9e0fa@quicinc.com>
In-Reply-To: <94e894a8-a262-959e-a6ab-869dcba9e0fa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YkPeJxCWUeguBVEcSJzt8cUpVMTV_3sU
X-Proofpoint-ORIG-GUID: YkPeJxCWUeguBVEcSJzt8cUpVMTV_3sU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=984 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130095
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/13/2022 10:00 PM, Pradeep Kumar Chitrapu wrote:
>
>>> +                                     work_done =
>>> +                                     ath12k_dp_mon_process_ring(ab,
>>> + id, napi, budget,
>> descendant is not indented from the first line, making it difficult to see the code structure
>>
>>> +                                                                flag);
>>> +                                     budget -= work_done;
>>> +                                     tot_work_done += work_done;
>>> +
>>> +                                     if (budget <= 0)
>>> +                                             goto done;
>>> +                             }
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     if (ab->hw_params->ring_mask->tx_mon_dest[grp_id]) {
>> this block of code has the same issues as the RX block. in fact it seems that this block is identical to the block above other than the flag and the tx_mon_desc vs rx_mon_desc, so I'm curious if it could be refactored into a single function that could be used by both tx and rx instead of duplicating code
>
Hi Jeff

Thanks for your review..

Although, rx and tx mon rings processing blocks can be moved to common 
function, this causes lot of variables to be sent to function using pass 
by reference, hence avoiding this gerrit for tradeoff. Please let me 
know if this is ok?

I will address rest of the comments in next revision of patch.

Thanks

Pradeep

