Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786486F2045
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 23:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbjD1Vvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 17:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjD1Vvg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 17:51:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D092D48
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 14:51:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SJ8Zoj001993;
        Fri, 28 Apr 2023 21:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DA0cuG7nLBg2BApgK8BpmTcdubLUEDaaFzpGpk4P5Uc=;
 b=bW+Gop1oiAB6Wn5of/YclGP2X5yrzds+npxMx6qiduNwTCtDyIe0uFcQGozTZ5UfFer8
 CqLmudYwgS1WI2CmtQE9SlYoZFJKNtvL6KMIMKQQPASdjbIBTcAYbOlezTCfD2Au0QBJ
 umlkxaBItDFkSGOF3t9ez6RIqTfZSE9bIXnrhiIZookCS477sprtSn2Fmg4ZwjFfuZio
 L2sBz8+VOB7roYXalMl6RnL6Cryojyjyv8t7uTgIzmY5C8jDwiYpDEIFcxpfxzkpa8U1
 JzSDzK2R2KxAc6iOf4IaXzku46XBd8yVF5QiKtc/KbLmk7flVmHlCcQo7QS7NBngIJYZ OQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8jun8fn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 21:51:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SLp1Ar014986
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 21:51:01 GMT
Received: from [10.110.11.241] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 28 Apr
 2023 14:51:01 -0700
Message-ID: <e09feed6-1f5e-ab4c-b943-9386fed3d29a@quicinc.com>
Date:   Fri, 28 Apr 2023 14:50:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 00/11] wifi: ath12k: (v3) EHT support
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230413215156.2649-1-quic_alokad@quicinc.com>
 <87ildjtc1c.fsf@kernel.org>
 <759bf2e8-ce51-b882-7d26-7ae57b8cf571@quicinc.com>
In-Reply-To: <759bf2e8-ce51-b882-7d26-7ae57b8cf571@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rxRqN116ytMv7W6NIMkUZfdKK8E9ExeI
X-Proofpoint-ORIG-GUID: rxRqN116ytMv7W6NIMkUZfdKK8E9ExeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280181
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/26/2023 9:49 AM, Aloka Dixit wrote:
> On 4/25/2023 11:03 PM, Kalle Valo wrote:
>> Aloka Dixit <quic_alokad@quicinc.com> writes:
>>
>>> Add driver support to bring AP up in EHT mode, configure a preamble
>>> puncturing bitmap and associate with an EHT client.
>>>
>>> v3: Modified patches 6 and 9 to fix some issues,
>>> changelog included in the respective patches.
>>> v2: This version modifies only few commit descriptions,
>>> changelog included in the respective patches.
>>>
>> This breaks WCN7850 support:
>>
>> [  144.039164] ath12k_pci 0000:06:00.0: BAR 0: assigned [mem 
>> 0xda200000-0xda3fffff 64bit]
>> [  144.039315] ath12k_pci 0000:06:00.0: enabling device (0000 -> 0002)
>> [  144.046220] ath12k_pci 0000:06:00.0: Hardware name: wcn7850 hw2.0
>> [  144.118539] mhi mhi0: Requested to power ON
>> [  144.118716] mhi mhi0: Power on setup success
>> [  144.222303] mhi mhi0: Wait for device to enter SBL or Mission mode
>> [  144.627712] ath12k_pci 0000:06:00.0: chip_id 0x2 chip_family 0x4 
>> board_id 0x104 soc_id 0x40170200
>> [  144.627945] ath12k_pci 0000:06:00.0: fw_version 0x1005bc12 
>> fw_build_timestamp 2022-10-11 12:13 fw_build_id 
>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>> [  144.959196] ath12k_pci 0000:06:00.0: failed to parse tlv -22
>> [  144.959317] ath12k_pci 0000:06:00.0: failed to parse ext2 event tlv 
>> -22
>> [  150.263567] ath12k_pci 0000:06:00.0: failed to receive wmi service 
>> ready event: -110
>> [  150.276547] ath12k_pci 0000:06:00.0: failed to start core: -110
>>
> 
> I have started seeing ETIMEDOUT on QCN9274 as well, AP bring up fails in 
> vdev sync. It works if the sync timeout is increased.
> 

Just an update, this is the timeout fix required for QCN9274:
https://patchwork.kernel.org/project/linux-wireless/patch/20230428091041.20033-1-quic_rgnanase@quicinc.com/

There are also some changes required from WCN side as well.
Will update here with a link when those are available.
Thanks.
