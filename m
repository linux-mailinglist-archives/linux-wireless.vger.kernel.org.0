Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D5773CD7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHHQKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjHHQIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 12:08:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9362376AD
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 08:46:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3784v3cw029152;
        Tue, 8 Aug 2023 05:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fba6K9Q3uuGERCgjltObNFtYzuy2qZ5f5kNSyET8KQE=;
 b=AMdNHwG/cZLD4UAw34bKJECgwn3kI4IObx0do9JJGSL96RoKjXKrwfArYTNwMhQdXRH+
 MEHUVOvC82QcScWMFZIn7Ew/lUuqzg+64cPR8pYqwS+b+vQagZRSy4HiCoKh5WXLTYSK
 x0M53K260YUNShQwsRBjDO+9SISQ76bXE6M6qSMNmN+GheTboyfsJx3JxJ1tTXVGWeAq
 KnAX7mgCBFn/A8Y42M6eOXLFVYTsS4W7FyoygqMpKa+h0ZZnvYVrJhohOnIn1O3e0gmV
 rhyPY/An4x09eVxK6X7UdzZUsBh85XratlshO4DRKnI3bHoflh0IZUuuMmb2i8pGPVbR 0A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sb7bb8sa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 05:07:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37857rxh016905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 05:07:53 GMT
Received: from [10.252.212.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 22:07:51 -0700
Message-ID: <4720b820-523a-477a-436c-72fceb4a6a12@quicinc.com>
Date:   Tue, 8 Aug 2023 10:37:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] wifi: ath11k: fix boot failure with one MSI vector
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230601033840.2997-1-quic_bqiang@quicinc.com>
 <87fs70hlel.fsf@kernel.org>
 <545cc8e8-481d-85b2-5692-43580936b48d@quicinc.com>
 <897b61ea-36d2-1ab4-9c60-9bdfd2d9cad7@quicinc.com>
 <fa70ca5e-001b-3c6b-dbc2-2853f8fc2f72@quicinc.com>
 <fcb783b4-95e9-24d8-a656-b273a79598a0@quicinc.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <fcb783b4-95e9-24d8-a656-b273a79598a0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bXXus_wXxlZN_3oboTdn0x7QLxye6xom
X-Proofpoint-ORIG-GUID: bXXus_wXxlZN_3oboTdn0x7QLxye6xom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_03,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=766 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080045
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/7/2023 8:59 PM, Jeff Johnson wrote:
> On 8/7/2023 3:16 AM, Manikanta Pubbisetty wrote:
>> No impact on WCN6750.
>>
>> Tested-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> Can you provide a Tested-on: flag that Kalle can add to the commit text?
> 

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1

Thanks,
Manikanta
