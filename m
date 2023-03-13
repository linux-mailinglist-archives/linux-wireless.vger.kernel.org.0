Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137106B700A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 08:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCMHT5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 03:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCMHTt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 03:19:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7442210C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 00:19:48 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D2lNgT027230;
        Mon, 13 Mar 2023 07:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uo0TYIVHwvkxJheXCnQ2pQ3vo9L0zIr3Z28HG5mr+U0=;
 b=GZIP3sD4iImLj5OwAX93i9IA+6CXQGH6hLx8RMRbRmXDYo0tvaIIjbbtdhfq/xKGEfx+
 CzUgmnyE24FRc4pDApfI6eywLrpo4V3E9YSmOKCP8QahMRudFoJa/9+llsamRamap1sr
 TyJYNgY4o35BalWNlVJKU+vMcNnqrtmmDuELaEohnORHq9oMK23MbAiqBfL7EuAoDBjU
 wvQnc6QtLe7bDU9JGUnGIwOJJhxVKhZgBramcvQqWxtlUPRf/PBfqOVBznJu+4A+6sFI
 lwBWMQFqiKtl1idXwwf+zacovsK550UkkiXsW4O3qGFEQXK1v2canjLhKePzTHeDnCVJ QQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p8jtwv2a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 07:19:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32D7JbOv001865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 07:19:37 GMT
Received: from [10.206.66.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 00:19:36 -0700
Message-ID: <2777d841-21e3-8223-5f1c-e62319cd57ce@quicinc.com>
Date:   Mon, 13 Mar 2023 12:49:33 +0530
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _LWyzgm5ahE8tjvfULORjshkhtMqEZ95
X-Proofpoint-GUID: _LWyzgm5ahE8tjvfULORjshkhtMqEZ95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Hi Kalle,

I was checking the logic around this and have added some debug logs to 
check if all the de-init APIs are getting called in the rmmod path.

This is the function call flow with WCN6855 on my machine,

ath11k_pci 0000:06:00.0: Manikanta: ath11k_core_pdev_destroy
ath11k_pci 0000:06:00.0: Manikanta: ath11k_thermal_unregister
ath11k_pci 0000:06:00.0: Manikanta: ath11k_mac_unregister
ath11k_pci 0000:06:00.0: Manikanta: ath11k_pcic_ext_irq_disable
ath11k_pci 0000:06:00.0: Manikanta: __ath11k_pcic_ext_irq_disable
ath11k_pci 0000:06:00.0: Manikanta: ath11k_dp_pdev_free
ath11k_pci 0000:06:00.0: Manikanta: ath11k_dp_rx_pdev_free
ath11k_pci 0000:06:00.0: Manikanta: ath11k_dp_rx_pdev_mon_detach
ath11k_pci 0000:06:00.0: Manikanta: ath11k_pcic_stop
ath11k_pci 0000:06:00.0: Manikanta: ath11k_dp_pdev_reo_cleanup
ath11k_pci 0000:06:00.0: Manikanta: ath11k_dp_free
ath11k_pci 0000:06:00.0: Manikanta: ath11k_pci_power_down
ath11k_pci 0000:06:00.0: Manikanta: ath11k_mac_destroy
ath11k_pci 0000:06:00.0: Manikanta: ath11k_reg_free
ath11k_pci 0000:06:00.0: Manikanta: ath11k_pcic_free_irq
ath11k_pci 0000:06:00.0: Manikanta: ath11k_pci_free_msi
ath11k_pci 0000:06:00.0: Manikanta: ath11k_hal_srng_deinit
ath11k_pci 0000:06:00.0: Manikanta: ath11k_core_free

In stark contrast to your observations, from the above call flow, I see 
that ath11k_hif_irq_disable() is getting called and the IRQs are getting 
disabled. ath11k_pcic_ext_irq_disable() is registered for hif_irq_disable().

I even tried the single MSI vector configuration suspecting that could 
be the difference. Even in single MSI case, I don't see any crashes 
during rmmod.

I'm completely clueless as to why the same code is behaving differently 
with the same hardware.

How can we take this forward, could you please suggest?

I'm thinking to keep these changes specific to WCN6750 for now.

Thanks,
Manikanta


