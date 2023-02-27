Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7684A6A3F9D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 11:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjB0KnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 05:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjB0Km6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 05:42:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515EC1FCA
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 02:42:51 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R4VKB8015582;
        Mon, 27 Feb 2023 10:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r8Bna+XeVO4+Lk2sTnSdQBRvqlkpHA7+Xe+z1Ny4jLc=;
 b=Zq3hFHkvklLMCYe1FQOLX+Ds3TqZLbJT0vnYaRdZrYi3yZTE4OKHbraPSRKqWm+sVsvA
 auGtg6BhtELc2s+WQilNS0oCxyNnZGg6FincLejL5ni5yo1ZsPZDnhcXfIvZQ6uK+TWg
 FUtQgzi5Ce2D80Hb8oGCRf0h28hHURbN72pWGGSotDqljt4lRmlcV8l9YVCAAxaTRQ1Z
 QozdWHzWtHiG1qrnFXtF6dQva+u8uOTANk2nPCXsOameX4T+CS2OF95YFUZiY1Y9YnfS
 5T4xBjZgE9UQTJSFht36+or2mnb7QN0kdYmyLb2ILWXxYVv4niLnEudltB2hNtmNYJO1 Rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny9bfcnjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:42:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RAgfRD009610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:42:42 GMT
Received: from [10.206.66.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 02:42:40 -0800
Message-ID: <2f559252-c76e-7b3a-2b90-eea0261fdbb3@quicinc.com>
Date:   Mon, 27 Feb 2023 16:12:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 3/3] ath11k: Enable low power mode when WLAN is not
 active
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
 <20230203060128.19625-4-quic_mpubbise@quicinc.com>
 <87h6vbruig.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87h6vbruig.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dHpBDuld1Yfh20NUGIBONn6cVNIZtGo0
X-Proofpoint-ORIG-GUID: dHpBDuld1Yfh20NUGIBONn6cVNIZtGo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=754
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/24/2023 8:16 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Currently, WLAN chip is powered once during driver probe and is kept
>> ON (powered) always even when WLAN is not active; keeping the chip
>> powered ON all the time will consume extra power which is not
>> desirable for a battery operated device. Same is the case with non-WoW
>> suspend, chip will never be put into low power mode when the system is
>> suspended resulting in higher battery drain.
>>
>> As per the recommendation, sending a PDEV suspend WMI command followed
>> by a QMI MODE OFF command will cease all WLAN activity and put the device
>> in low power mode. When WLAN interfaces are brought up, sending a QMI
>> MISSION MODE command would be sufficient to bring the chip out of low
>> power. This is a better approach than doing hif_power_down()/hif_power_up()
>> for every WiFi ON/OFF sequence since the turnaround time for entry/exit of
>> low power mode is much less. Overhead is just the time taken for sending
>> QMI MODE OFF & QMI MISSION MODE commands instead of going through the
>> entire chip boot & QMI init sequence.
>>
>> Currently the changes are applicable only for WCN6750. This can be
>> extended to other targets with a future patch.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> This is still crashing for me every time with WCN6855 on a NUC x86
> device when I rmmod ath11k. Interestingly enough QCA6390 on a Dell XPS
> 13 9310 does not crash.
> 

Surprisingly enough, I was never been able to reproduce the problem on 
my device which has WCN6855.

> I investigated the crash more, the crash happens in
> ath11k_dp_process_rxdma_err() on this line:
> 
> 	srng = &ab->hal.srng_list[err_ring->ring_id];
> 
> Here are the debug messages before the crash (first and last are my
> own messages):
> 
> [  226.766111] rmmod ath11k_pci
> [  227.003678] ath11k_pci 0000:06:00.0: txpower from firmware NaN, reported -2147483648 dBm
> [  227.082283] ath11k_pci 0000:06:00.0: qmi wifi fw del server
> [  227.195760] ath11k_pci 0000:06:00.0: cookie:0x0
> [  227.195843] ath11k_pci 0000:06:00.0: WLAON_WARM_SW_ENTRY 0x15b894d
> [  227.216022] ath11k_pci 0000:06:00.0: WLAON_WARM_SW_ENTRY 0x0
> [  227.216086] ath11k_pci 0000:06:00.0: soc reset cause:0
> [  227.236170] ath11k_pci 0000:06:00.0: MHISTATUS 0xff04
> [  227.270816] ath11k_pci 0000:06:00.0: ext irq:167
> [  227.271231] ath11k_dp_process_rxdma_err() 4187 ab ffff888145520000 err_ring 00000000000001d0
> 
> So we get irq 167 which is:
> 
>   167:          0          0          0          0          0          0          0          0  IR-PCI-MSI-0000:06:00.0   14-edge      DP_EXT_IRQ
> 
> But in ath11k_pcic_ext_interrupt_handler() ATH11K_FLAG_EXT_IRQ_ENABLED
> is still enabled so the irq is processed:
> 
> 	if (!test_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
> 		return IRQ_HANDLED;
> 
> It looks like that, after applying this patch 3, whenever
> ath11k_pci_remove() is called we are not calling
> ath11k_hif_irq_disable() anymore. I checked that without patch 3
> ath11k_hif_irq_disable() is always called. So this patch is definitely
> breaking something fundamental, but I ran out of time to invetigate
> further. I hope this still helps.
> 

This definitely helps, thanks a lot for the direction. I'll check what 
is missing here.

> Do note I have concerns about this patchset, it just changes quite a lot
> of the driver logic and I'm worried what else this breaks. Also we
> should definitely test with another AHB device like IPQ8074, this
> patchset needs extensive testing.
> 

Noted.

Thanks,
Manikanta
