Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA76EEF73
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 09:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbjDZHkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbjDZHkb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 03:40:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A0423E
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 00:40:20 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q4f98E002228;
        Wed, 26 Apr 2023 07:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/wn+UXvrkEcudbHBgVVgpcXn1/etkPr2gofIOA2w5fA=;
 b=Rz7zpAlTVAcHUUDWUZRbo3uKe/KquuiP0jUVDWWfrh+3LYYOiUx94EVqJkxakfdqlgGK
 ADh7TeVUmeGEIcuSbuRqNYMHA39V7tOdm5Zqi9Mp3vUq1MUM72RpHNc3GJgz90hLlW/l
 i7QAElrF+aQz6dnJa1xyIr/4xIFMNeRPejJ8wbdQpUCX5vVTthVc3TKvkY7dphUjL791
 3cOX76xIFZd78Gx0Xmy2KH9Tch7vP3ghZXGnMA7rkBiOYD+whhQE5v73sP8l+el0I2hY
 EIGGf/c/Fz94pr+uwbM+574kzFJlrocWNejPxlSoh1MC5NbXrWExYrk6eIq7V2REYcy4 Iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6kw09e8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 07:40:11 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33Q7eAwW029366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 07:40:10 GMT
Received: from [10.242.242.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 26 Apr
 2023 00:40:08 -0700
Message-ID: <763c41bb-7452-1ded-ace5-8cda9ca64788@quicinc.com>
Date:   Wed, 26 Apr 2023 13:09:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: ath11k: update proper pdev/vdev id for testmode
 command
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
References: <20230424092420.12794-1-quic_rajkbhag@quicinc.com>
 <87a5yvt831.fsf@kernel.org>
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <87a5yvt831.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n0BOrkUZLRU66NWJzGI6YnrYVJdKL9eN
X-Proofpoint-ORIG-GUID: n0BOrkUZLRU66NWJzGI6YnrYVJdKL9eN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_02,2023-04-26_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=912
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260069
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/26/2023 12:59 PM, Kalle Valo wrote:
> Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:
> 
>> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>>
>> User can extend test mode command support to set vdev and pdev params
>> for debug purpose at run time by sending vdev/pdev param set command
>> through the testmode command interface.
>>
>> Fill the proper pdev/vdev id in driver since, pdev/vdev id details may
>> not be available at user space. It will make sure that the proper
>> vdev/pdev ids are sent to firmware.
>>
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>
>> Depends-On:
>> 	[v3,3/4] wifi: ath11k: factory test mode support
>>
>> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
> 
> Please add 'Depends-on' after the '---' line. This is for future
> patches, no need to resend because of this.
> 

Thanks for pointing this. Will take care for future patches.

Thanks,
Raj
