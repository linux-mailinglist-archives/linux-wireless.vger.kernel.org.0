Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9C7718A7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Aug 2023 04:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHGC6U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Aug 2023 22:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHGC6T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Aug 2023 22:58:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160811BCE
        for <linux-wireless@vger.kernel.org>; Sun,  6 Aug 2023 19:57:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3771gqsu021787;
        Mon, 7 Aug 2023 02:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FKw1svoSZ+oIO2/i4JhRj7Tru9ZeZtNo1ovahurHt/s=;
 b=goE52STz5/ZWUIfXbv73vmhZ17XGHuG/4YOwfNlLbm1Ktt+CgE5DD2mUfiXetdaNDX7N
 IkT5Z/0WhHYvT1dbGnykG5xCkLa7w9HbUgl+bA/8U1ji8VdGdbxcj9adVEbvc4DCwTpn
 SRdIo1Kakf0oB7uNv9phJKLYpdg8q4tiLD/pVUbdA5CGOgo7L3vYvmH3sLlUohOBreKg
 hNhN05I4WEcNWpszPcolI/NPG28S3HHrJq0BUNr/H3nBLJw529/yT1ukrSWFpLt6bc9n
 8oemwC/5LDehwKFsjZKMszeh3fnmEXvlit6zve81PekBW+p+gt0XpXHrx0dASdU+/0qR CQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9e16tdvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 02:56:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3772uGVO008127
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 02:56:16 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 6 Aug
 2023 19:56:15 -0700
Message-ID: <afac3a79-d4b0-967c-ef04-f8fdbd123eaa@quicinc.com>
Date:   Mon, 7 Aug 2023 10:56:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/3] wifi: ath12k: configure RDDM size to MHI for
 device recovery
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230721055305.20420-2-quic_wgong@quicinc.com>
 <169105464227.894438.15435946207134709277.kvalo@kernel.org>
 <1bbe5e90-1f37-3926-98f7-a685578fef8f@quicinc.com>
 <87msz8tl8e.fsf@kernel.org>
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87msz8tl8e.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i1en1LnM91vzXvdAPUpxJ69dJD9Avhvm
X-Proofpoint-ORIG-GUID: i1en1LnM91vzXvdAPUpxJ69dJD9Avhvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-06_24,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=711
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070025
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/3/2023 7:32 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> On 8/3/2023 5:24 PM, Kalle Valo wrote:
>>> Wen Gong <quic_wgong@quicinc.com> wrote:
>>>
>>>> RDDM is RAM DUMP DEBUG module, it is used to debug issues when firmware
>>>> encounters an error.
>>>>
>>>> The rddm_size is needed by firmware while MHI enter RDDM state. Add it
>>>> to support device recovery when ath12k receive MHI_CB_EE_RDDM message.
>>>>
>>>> Tested-on: WCN7850 hw2.0 PCI
>>>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>>>
>>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>> I'm not sure what "support device recovery" means exactly. How does this patch
>>> change functionality from user's point of view?
>>>
>>> No need to resend because of this, I can add that to the commit log.
>> Device recovery means SSR(subsystem restart), when firmware happen
>> crash, ath12k
>> will receive the RDDM event, and then ath12k/mac80211 begin to
>> re-start wifi/firmware,
>> after that, the wifi become normal again.
>>
>> This patch is to let firmware report RDDM event correctly to ath12k.
>> Without this patch,
>> firmware will not report RDDM event to ath12k correctly, then ath12k
>> will not begin SSR
>> process.
>>
>> I think it should be changed like this:
>>
>> The rddm_size is needed by firmware while MHI enter RDDM state. Add it
>> and then firmware will report MHI_CB_EE_RDDM correctly while firmware
>> encounters an error, then ath12k could start the device recovery process.
> How about this:
>
> "RDDM is Ram Dump Debug Module which is used to debug issues when the
> firmware encounters an error. The rddm_size is needed by the firmware
> while MHI goes to the RDDM state. Provide the size to MHI subsystem so
> that the firmware restart works when the firmware crashes."

Thanks.

Yes, it is OK for me.

