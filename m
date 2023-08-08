Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7505F774902
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjHHTqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 15:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbjHHTqK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 15:46:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD59159EC
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:49:13 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3787SNHL013044;
        Tue, 8 Aug 2023 10:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CTlCVNrnLOZbC2Bp8ihc1hVt9SYK5pZEPHJRtPEyOro=;
 b=IpS6X5JgJlqcTUGL42PYvhfSnruJ1W7ZEV5fRwAVB7jiJEz8d6BPn5yzJYpmjkJSufLa
 ORwZB0vYa4IRT96KeWEiMJ+dBAMt2xj+Nw8aG7UXBizSnMEyHwkTVdhZo9OYdvjDHIDD
 Mzji+3BETosf5FzyhgkhoqwhXQ2pi7nbe5A4e1HbjDJtFXRvcnWGms0ypFHJtzSsxAYx
 U7bO8Vf3YeeGZ+9Rq7MwoAZrBU1/DugYW6QxtrQ1/NF231/ZsJBOF3pp4Vsn1Do1Bgjw
 bpzbpynatULaDD2sasERn7CyHoQ0KqtYBloIsBdfvYM96ylNz3aIIoZZhvbV5Wj4N0J6 aQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sawbgargy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 10:26:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 378AQUsT015122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 10:26:30 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 03:26:29 -0700
Message-ID: <40034bde-5512-8df5-a19d-48487102c003@quicinc.com>
Date:   Tue, 8 Aug 2023 18:26:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] wifi: ath12k: fix WARN_ON during
 ath12k_mac_update_vif_chan
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Manish Dharanenthiran <quic_mdharane@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230802085852.19821-1-quic_mdharane@quicinc.com>
 <20230802085852.19821-2-quic_mdharane@quicinc.com>
 <54733de9-db66-f1c4-9ad5-4d1f31529c05@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <54733de9-db66-f1c4-9ad5-4d1f31529c05@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T0JCaUQKC_FfLJX8RmFWqNHn8dYWPRCk
X-Proofpoint-GUID: T0JCaUQKC_FfLJX8RmFWqNHn8dYWPRCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=725
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080093
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/2/2023 10:59 PM, Jeff Johnson wrote:
> On 8/2/2023 1:58 AM, Manish Dharanenthiran wrote:
>> Fix WARN_ON() from ath12k_mac_update_vif_chan() if vdev is not up.
>> Since change_chanctx can be called even before vdev_up.
>>
>> Do vdev stop followed by a vdev start in case of vdev is down.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
>
> Has this been tested on WCN7850? My understanding is that firmware may 
> expect vdev down and then vdev restart
>
For WCN7850, firmware do not expect vdev down for station vdev type here.

And this patch only take effect when arvif->is_up is not set,

it is hard to happen that for MCC station mode.

Because this function is entered for channel switch for MCC station mode,

it means station is connected to the AP, then arvif->is_up is set, then 
this patch not take effect.

[...]

>
