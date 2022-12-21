Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCE653126
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 13:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiLUM5C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiLUM47 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 07:56:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E523303
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 04:56:59 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL8i8uf015471;
        Wed, 21 Dec 2022 12:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vvaiUbkWrouE/hBrcPGBsJpV4BrM+h3KrWhBkheetH8=;
 b=IxC8KvGrQFmPMIh6bdNfkHe0jpQqIIu5xwxec8FRHUpd1avfOY16+8hmHW/3zlRZ5LHU
 lM4WEhm1qirdyBsZ3NBhfFWgHcWJVTU1Cx6seHE7Y53PDPQCHxoWJmzHDM4VcR0TjnGr
 xcxtmnt7vC12RFcImGujmjvLTIeNWQpzV1i6pfTDlaziyT/5l9B7NU+5wwtY/I2a64fa
 OUgJwGyNOWbQ2bXYwB46jVbQXNPrpza2NjgUOhp5QCI3x62rXTk7UaiDfoYFAAx0UNQa
 UfkXIkvQrvQIjIT+ZCjg8rDRL666pO5dSkmjFh/NKvnVmd37D54AUzIwx2ittZZ03h16 ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjyk54b1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 12:56:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLCuprL002439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 12:56:51 GMT
Received: from [10.242.243.166] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 04:56:49 -0800
Message-ID: <cf9ce566-04d2-dd5f-95a3-13045fcf5439@quicinc.com>
Date:   Wed, 21 Dec 2022 18:26:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 3/3] wifi: ath11k: add debug prints in regulatory WMI
 event processing
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20221214164639.31542-4-quic_adisi@quicinc.com>
 <167162718423.23347.17706545802283934057.kvalo@kernel.org>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <167162718423.23347.17706545802283934057.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5iu0byiqUtkCDgouuX0x9StpjslX93gx
X-Proofpoint-ORIG-GUID: 5iu0byiqUtkCDgouuX0x9StpjslX93gx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_06,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210106
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/21/2022 18:23, Kalle Valo wrote:
> Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:
> 
>> Add some more debug prints in processing regulatory WMI event in order to
>> increase more debuggability.
>>
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> I see new warnings also here:
> 
> drivers/net/wireless/ath/ath11k/wmi.c:5494: line length of 111 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wmi.c:5495: line length of 110 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wmi.c:5496: line length of 112 exceeds 90 columns
> 
> Please run ath11k-check.
> 
Okay let me fix this.

