Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD475FDFC
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGXRmf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGXRmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 13:42:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E442E55
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:42:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ODtY8l027365;
        Mon, 24 Jul 2023 17:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5aAMJ0frHNn0nF9pSsO5x3K2otUuxAETSGfw6+7bMDo=;
 b=THzU4AcsEu9rvCh1lyPPhFM9rcC+LvrYFzjzwxU0NeFAhIHQEP4SWrABsfrqDFF0VNjD
 G8ICJQHMkbutGhI4O3Bz6MRcu1GpOIrCPwn/OYfz3+ou3WugDK8TlJKiSpXPUMwpSo4i
 GUhiLU/o0ulwCq6JIHkjj3aphYk0VtzSD2FcFDvrWWPzTUdIQ4BxYq9WjM8PyXnBVS6W
 YkqvAlZnI0aGWNPF3Sb5mjSoK6eM8vJbyHlx0dUethfAHrPXpIV5E/oO1ha4dhTPot12
 gVB22/M97FtBDXWUM/Nnc+AHQDpKX1ZUHWdo5SNSqtN7nmRCR/vU2hRW2RkKrXOpm8b7 fw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qass173-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 17:42:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OHgOIS014766
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 17:42:24 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 10:42:23 -0700
Message-ID: <a95b1a2c-a218-972a-4b60-14ff48b9efd6@quicinc.com>
Date:   Mon, 24 Jul 2023 10:42:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 03/11] wifi: ath12k: WMI support to process EHT
 capabilities
To:     Wen Gong <quic_wgong@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <20230602235820.23912-4-quic_alokad@quicinc.com> <87ttv9aqtn.fsf@kernel.org>
 <844a2d71-d003-abd0-4cf2-f279a1b62ac7@quicinc.com>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <844a2d71-d003-abd0-4cf2-f279a1b62ac7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L-20drruhXI6vHiTL8bQQZrVFXJZqXof
X-Proofpoint-GUID: L-20drruhXI6vHiTL8bQQZrVFXJZqXof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=968 adultscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240156
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/16/2023 3:50 AM, Wen Gong wrote:
> On 6/15/2023 7:49 PM, Kalle Valo wrote:
>> Aloka Dixit <quic_alokad@quicinc.com> writes:
>>
>>> Add WMI support to process the EHT capabilities passed by
>>> the firmware. Add required EHT specific definitions in
>>> structures ath12k_band_cap and ath12k_wmi_svc_rdy_ext_parse.
>>>
>>> For single_pdev chip such as WCN7850, only one pdev is created
>>> and only one hardware is registered to mac80211. This one pdev
>>> manages both 2.4 GHz radio and 5 GHz/6 GHz radio.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI 
>>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
>>> Co-developed-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>> Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> [...]
>>
>>> +struct ath12k_fw_pdev {
>>> +    u32 pdev_id;
>>> +    u32 phy_id;
>>> +    u32 supported_bands;
>>> +};
>> So we have now two very similar structures, ath12k_pdev and
>> ath12k_fw_pdev. It would be good to document above the structs their
>> purpose. Any ideas what I could add?
> 
> For single_pdev, the ath12k_pdev is always one pdev.
> 
> and ath12k_fw_pdev is more than one for single_pdev.
> 
>>

Okay will add a comment in the next version.
