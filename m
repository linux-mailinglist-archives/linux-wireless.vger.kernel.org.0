Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5385FAD8C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJKHbw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJKHbu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:31:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C5862ABD
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:31:49 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B6xIrj023988;
        Tue, 11 Oct 2022 07:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BHBaq3Uuo6QUQVT/cgnzVQ0KYE7RuX9+tzISy8fkgt4=;
 b=acksfAXfhxgd6GzwnHMJLYfPu9PUyDAsPaoG43Zhs4r2ojL3LSkp9fgt7GXntjSQQNCa
 wuHvKePYnCrhb7CihIn+ohFUkWfmXBDRBesu3e591KCp1cVQnxq4vXBCbVnB5iYUfpOy
 ZXbhxfhsQWhHr8XTVdZt0LhlpCs9SaJiVbBsy/+2m5tolLF2hkeGFaViBCo2ueWpt1oB
 eapfwqUEZzuwtATsvJVxjRTMqzgCnhpgX5qosiRyVvr6zutGSLyQgANu7IaqypY89yIg
 p1GALz4MngZ4HVRL9eQXi3DOEzjjLgpxsoabJbVe5apxqzio3CWNdQo3Iua16GjVidcC hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx4hfmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:31:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B7Vd3w011755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 07:31:39 GMT
Received: from [10.253.78.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 00:31:37 -0700
Message-ID: <2f37209c-8b40-c06b-1c56-0cb4c27e6f45@quicinc.com>
Date:   Tue, 11 Oct 2022 15:31:34 +0800
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
 <f50c94b9-252f-25ab-4650-bed52762bc4d@quicinc.com>
 <0526d034-2cb9-527e-b338-f73db0ed005b@quicinc.com>
 <87czazoub5.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87czazoub5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l0MocCM3syOfAM99-UHW9TAa1KAqJPA6
X-Proofpoint-GUID: l0MocCM3syOfAM99-UHW9TAa1KAqJPA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210110041
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/11/2022 12:31 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> On 10/11/2022 11:53 AM, Wen Gong wrote:
>>
>>> On 10/11/2022 2:09 AM, Kalle Valo wrote:
>>>> Wen Gong <quic_wgong@quicinc.com> wrote:
>>>>
>>>>> When switch to connect to a new AP for station which is already
>>>>> connected
>>>>> to an AP, the time cost is too long, it arrives 10 seconds.
>>>>>
>>>>> The reason is when switch connection, disconnect operation happened on
>>>>> the 1st AP, then 11d scan start command sent to firmware, and then a
>>>>> new hw scan arrived for the 2nd AP. The 11d scan is running at this
>>>>> moment, so the hw scan can not start immediately, it needs to wait
>>>>> the 11d scan finished, it increased the time cost of switch AP and
>>>>> even happened scan fail as log below after apply the incoming patch.
>>>>>
>>>>> [ 1194.815104] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>>> [ 1196.864157] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>>> [ 1198.911926] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>>>
>>>>> Change to set 11d state while disconnect, and the 11d scan will be
>>>>> started after the new hw scan in ath11k_mac_op_hw_scan(). Then the
>>>>> time cost of switching AP is small and not happened scan fail.
>>>>>
>>>>> Tested-on: WCN6855 hw2.0 PCI
>>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>>>
>>>>> Fixes: 9dcf6808b253 ("ath11k: add 11d scan offload support")
>>>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>> I still see warnings:
>>>>
>>>> [ 3627.691737] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>> [ 3715.435608] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>> [ 3860.333214] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>> [ 4542.000955] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>> [ 4604.018451] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>> The failed log is now happened frequently as before, I will change
>>> it again to suppress the failed log.
>> change typo.
>> The failed log is NOT happened frequently as before, I will change it
>> again to suppress the failed log.
> Please think about this more, ignoring errors doesn't sound like a good
> solution.
Yes, I have sent v3, it is not ignoring errors directly.
