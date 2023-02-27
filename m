Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20BB6A3FB1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 11:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjB0KuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 05:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0KuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 05:50:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B972CC3C
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 02:50:04 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RAnI9B017902;
        Mon, 27 Feb 2023 10:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8zZz7+KLT2jaOK03BBPpTPgfJZAJLRgBTGoo0IrtCMU=;
 b=EBLxxO848eBEiz5KSbNPgOpOcwcBsSE19S7xqpr+EQ637Qm8+MZhlu+dSbC/IxKuEZNp
 03tjPNJztYYounvr4qnVNqUBTgCXuiBlEC7SLVJasYWjmar5xN6oNErWf53JF0r4t1bz
 ay51TV7gwlKEvGiuOirwNrR0J6BwTbhdUSS209uUQEDNO1UHLFqKWSgr6Vi669xVxEbL
 kMH43Q/45Kejdca6duBnS4z9tJss3TQ3GFoVUEiz/u2dadRLdibiPuQtlK0VgsiATI7u
 WkpVOQ0E6wNCgRfE0jdH9B9QC8utA3pJp15QTMP65h9vb+6NtxPXa3D4z1Ioa+yhvkrf zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p0u3jr022-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:49:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RAnvJU017085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:49:57 GMT
Received: from [10.206.66.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 02:49:55 -0800
Message-ID: <8deddc68-3aa0-fc1b-5cec-1c74935a0333@quicinc.com>
Date:   Mon, 27 Feb 2023 16:19:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/3] Enable low power mode when WLAN is not active
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
 <878rgnru59.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <878rgnru59.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qaajmIxwAsqgLM8RN-COCjtRFqMri7xc
X-Proofpoint-GUID: qaajmIxwAsqgLM8RN-COCjtRFqMri7xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/24/2023 8:24 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Currently, WLAN chip is powered once during driver probe and is kept
>> ON (powered) always even when WLAN is not active; keeping the chip
>> powered ON all the time will consume extra power which is not
>> desirable for battery operated devices. Same is the case with non-WoW
>> suspend, chip will not be put into low power mode when the system is
>> suspended resulting in higher battery drain.
>>
>> Send QMI MODE OFF command to firmware during WiFi OFF to put device
>> into low power mode.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>
>> Manikanta Pubbisetty (3):
>>    ath11k: Fix double free issue during SRNG deinit
>>    ath11k: Move hardware initialization logic to start()
>>    ath11k: Enable low power mode when WLAN is not active
> 
> Please add "wifi:" to all patches.
> 
> And please add "wifi: ath11k:" to the cover letter.
> 

Sorry, I have missed adding the prefix. I'll fix this.

Thanks,
Manikanta
