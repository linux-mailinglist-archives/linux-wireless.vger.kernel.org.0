Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB4D762296
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 21:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGYToV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 15:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYToT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 15:44:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642651FF3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 12:44:18 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJdFen026133;
        Tue, 25 Jul 2023 19:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PNuRfmOT8KhHU3Wfu3lF2YLZ/va6SuJ2gN7OEqI7FJI=;
 b=Dla6FG6XiYt5i5TY8cfwfNZFhxELwHXcfxA82efvbrEW4jUN3QuH7bMXhPwOhxPtHsk/
 d0ebD5Xfrz/Az4B4zM4NQ2QunaPkNaM+StPmznevLBG8Y37c6OfmDIGKPElDhZ7S1UQw
 I4nDySqqOLnxhlR+A9q0xy1VbhlmBhjCw/gvyOVg+aLBoPW7Edz05ykI9NI2wnuMulpl
 b0Fs9KXLn4zI3YNeOdwiiUxZUZRdQJE/qddWNiJOsqwW9K842NSZzMUdMqNLWAProQTO
 E1plN/uKIGJTHvNWlRSvMeWPPPCTUvCBf2D9bV2djMQsI+nfVI6f7mB9PLlfUTzqQBjM Ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s29xmhq0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:44:11 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PJiAOW021188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:44:10 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 12:44:10 -0700
Message-ID: <35c86c8e-afdb-adb6-f331-af74c99d3a02@quicinc.com>
Date:   Tue, 25 Jul 2023 12:44:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 03/11] wifi: ath12k: WMI support to process EHT
 capabilities
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
 <20230602235820.23912-4-quic_alokad@quicinc.com> <87ttv9aqtn.fsf@kernel.org>
 <dc0ae263-e5f6-b876-842a-7b598caf68fa@quicinc.com>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <dc0ae263-e5f6-b876-842a-7b598caf68fa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u2y0msoTWnKJhQkGA4I6oPXuwH6V_P-J
X-Proofpoint-GUID: u2y0msoTWnKJhQkGA4I6oPXuwH6V_P-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=806 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250168
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/25/2023 3:51 AM, Wen Gong wrote:
> On 6/15/2023 7:49 PM, Kalle Valo wrote:
>> Aloka Dixit <quic_alokad@quicinc.com> writes:
>>
> [...]
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
> Currently ath12k has single_pdev parameter, it impact the interface 
> number of wifi.
> 
> For single_pdev=ture, ab->num_radios is set to 1 and all capbility of 
> 2.4 GHz/
> 5 GHz/6 GHz is saved into ab->pdevs[0] in 
> ath12k_wmi_ext_soc_hal_reg_caps_parse().
> ath12k_mac_register() will call only one time into 
> __ath12k_mac_register(), and
> ieee80211_register_hw() is called only one time, and only one wifi 
> interface in
> the result of "iw dev/ifconfig", the interface support 2.4 GHz/5 GHz/6 
> GHz. Actually
> there hare more than one PHY in firmware, firmware maintain the all PHY 
> data and
> provide a single pdev/soc interface to ath12k, then ath12k do not need 
> to consider
> the PHY info such as channel/BAND<->PHY mapping relationship, it is 
> convenient for
> ath12k to support 2.4 GHz/5 GHz/6 GHz.
> 
> For single_pdev=false, ab->num_radios is more than 1, ab->pdevs[] has 
> muti valid
> element, each element only support one BAND. Firmware do not provide a 
> single
> pdev/soc interface, so ath12k need to maintain the PHY data such as 
> channel/BAND<->
> PHY mapping relationship, and ath12k_mac_register() will call muti-time 
> into
> __ath12k_mac_register(), and ieee80211_register_hw() is called 
> muti-time, and muti
> wifi interface in the result of "iw dev/ifconfig", and each interface 
> only support
> one BAND, for example, wlan0 only support 2.4 GHz, wlan1 only support 5 
> GHz, and
> wlan2 only support 6 GHz.
> 
> For single_pdev=ture, ath12k also need to know some info about the PHYs 
> sush as
> pdev_id/phy_id/supported_bands in this patch, so ab->fw_pdev is used to 
> store the
> PHY data.


The new struct ath12k_fw_pdev is anyway going to have as many elements 
as the num_radio, right? Then there must be a way to reuse the common 
struct ath12k_pdev instead as it done for QCN devices. I understand this 
it will need changes to all the existing code for the single-pdev where 
it might have hard-coded pdev[0] for the original structure. Something 
to think about in a separate patch-set.

For now I will send new version with comments (as far as I understood 
it) because without this patch WCN devices show a crash during boot-up.

Thanks.
