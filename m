Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7B5AB22B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiIBNwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiIBNwG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 09:52:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ED135D32
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:26:26 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282CbkqB023857;
        Fri, 2 Sep 2022 13:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HvVuk5CFSLsA001yFTCkvdzI8+aIWGTJFjsiSNEcWdA=;
 b=k30vMATiqbQmilBk2CkxAPwhHig2MpWROYLsBFU2DQ7SRTBfphbgcE/5efkc2NVazkq2
 PBXHNlkJbZ4yCqEjTisLGwg86f4IGsqppv8ZdsKM47NR0TthgB9cASnMZLjLZ9JEY6KT
 UzECtP6gCqUpq98WwMdhhxbCdANbuzH+eugj80MleouOC5VoIW5DGGkgf3Ygwtm/uiNh
 bVg78g21TjjAxxA27NxE+HOsG67z0+FT9jJZlEuvSyDwb+F/3kuYtLVQHBEX8rABL2tA
 BJe4An8M0KKnlyuhGw4Pyj7jpeBJuiA/e2SBDp/H2/Z3aBThyiUWpNRsQLWBLEgl63tE uA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbj0m03a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 13:25:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282DPX1G014422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 13:25:33 GMT
Received: from [10.216.25.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 2 Sep 2022
 06:25:32 -0700
Message-ID: <f5283344-a39d-f2f5-faa3-3fd11c3c70af@quicinc.com>
Date:   Fri, 2 Sep 2022 18:55:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/4] ath11k: Enable low power mode when WLAN is not
 active
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
 <20220825111818.30869-4-quic_mpubbise@quicinc.com>
 <874jxsdeov.fsf@kernel.org>
 <c10d7988-099b-cd10-64aa-41daca1ce12b@quicinc.com>
 <874jxpc3t8.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <874jxpc3t8.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nmt7-7kV0-23qIZl4dU9TN5Kvrs_oUCt
X-Proofpoint-ORIG-GUID: nmt7-7kV0-23qIZl4dU9TN5Kvrs_oUCt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=421 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/2/2022 6:48 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> On 8/31/2022 1:31 PM, Kalle Valo wrote:
>>
>>> With this patch 3 my regression tests on WCN6855 panic:
>>>
>>> [  109.009427] rmmod ath11k_pci
>>> [  109.437120] kworker/dying (1560) used greatest stack depth: 24704 bytes left
>>> [ 109.446051] general protection fault, probably for non-canonical
>>> address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
>>> KASAN
>>> [ 109.446133] KASAN: null-ptr-deref in range
>>> [0x00000000000001f0-0x00000000000001f7]
>>> [  109.446211] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-rc2-wt-ath+ #683
>>> [ 109.446315] Hardware name: Intel(R) Client Systems
>>> NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339
>>> 05/28/2021
>>> [  109.446393] RIP: 0010:ath11k_dp_process_rxdma_err+0x1c8/0x810 [ath11k]
>>> [ 109.446486] Code: d2 48 63 d8 48 8b 4c 24 38 48 8d 04 5b 48 c1 e0
>>> 04 48 8d bc 01 f4 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
>>> c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2
>>> 0f 85 aa
>>> [  109.446557] RSP: 0018:ffffc90000007b90 EFLAGS: 00010203
>>> [  109.446619] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>> [  109.446677] RDX: 000000000000003e RSI: 0000000000000000 RDI: 00000000000001f4
>>> [  109.446734] RBP: 0000000000000000 R08: ffff88814c0e1470 R09: ffff88814c0f6678
>>> [  109.446792] R10: dffffc0000000000 R11: ffffed102981ecd0 R12: 0000000000000000
>>> [  109.446903] R13: 0000000000000040 R14: 1ffff92000000f81 R15: ffff88814c0e0000
>>> [ 109.446961] FS: 0000000000000000(0000) GS:ffff888233600000(0000)
>>> knlGS:0000000000000000
>>> [  109.447020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  109.447080] CR2: 000055570fe84cc8 CR3: 0000000152540006 CR4: 00000000003706f0
>>> [  109.447136] Call Trace:
>>> [  109.447194]  <IRQ>
>>> [  109.447257]  ? ath11k_dp_process_reo_status+0x3ce/0x560 [ath11k]
>>> [  109.447349]  ? ath11k_dp_rx_process_wbm_err+0x17d0/0x17d0 [ath11k]
>>> [  109.447442]  ath11k_dp_service_srng+0x358/0xab0 [ath11k]
>>> [  109.447536]  ath11k_pcic_ext_grp_napi_poll+0x40/0x1d0 [ath11k]
>>> [  109.447628]  __napi_poll.constprop.0+0x97/0x350
>>> [  109.447690]  net_rx_action+0x7bf/0xbb0
>>> [  109.447749]  ? __napi_poll.constprop.0+0x350/0x350
>>> [  109.447831]  ? ktime_get+0x101/0x2f0
>>> [  109.447911]  __do_softirq+0x1ca/0x897
>>> [  109.447989]  __irq_exit_rcu+0xdb/0x180
>>> [  109.448049]  irq_exit_rcu+0x5/0x20
>>> [  109.448109]  sysvec_apic_timer_interrupt+0x8a/0xb0
>>> [  109.448168]  </IRQ>
>>> [  109.448226]  <TASK>
>>> [  109.448284]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>>> [  109.448343] RIP: 0010:cpuidle_enter_state+0x1ef/0x9a0
>>> [ 109.448407] Code: 00 00 8b 73 04 bf ff ff ff ff e8 8c f0 ff ff 31
>>> ff e8 75 16 47 fe 80 7c 24 08 00 0f 85 a1 01 00 00 e8 75 7d 6a fe fb
>>> 45 85 f6 <0f> 88 6f 02 00 00 4d 63 ee 4b 8d 44 6d 00 49 8d 44 85 00
>>> 48 8d 7c
>>> [  109.448477] RSP: 0018:ffffffffb9407db8 EFLAGS: 00000202
>>> [  109.448540] RAX: 0000000000124987 RBX: ffff888114966400 RCX: 1ffffffff738a3e1
>>> [  109.448600] RDX: 0000000000000000 RSI: ffffffffb8a71bc0 RDI: ffffffffb8bec9c0
>>> [  109.448659] RBP: ffffffffb986efa0 R08: 0000000000000001 R09: ffffffffb9c54717
>>> [  109.448715] R10: fffffbfff738a8e2 R11: 00000000000002ec R12: 000000197b7a6a19
>>> [  109.448774] R13: 0000000000000002 R14: 0000000000000002 R15: ffff888114966404
>>> [  109.448871]  ? cpuidle_enter_state+0x1eb/0x9a0
>>> [  109.448947]  ? finish_task_switch.isra.0+0x120/0x870
>>> [  109.449006]  cpuidle_enter+0x45/0xa0
>>> [  109.449065]  cpuidle_idle_call+0x274/0x3f0
>>> [  109.449125]  ? arch_cpu_idle_exit+0x30/0x30
>>> [  109.449187]  ? tsc_verify_tsc_adjust+0x86/0x2d0
>>> [  109.449247]  ? lockdep_hardirqs_off+0x90/0xd0
>>> [  109.449306]  do_idle+0xe0/0x140
>>> [  109.449363]  cpu_startup_entry+0x14/0x20
>>> [  109.449423]  rest_init+0x135/0x1e0
>>> [  109.449482]  arch_call_rest_init+0xa/0xb
>>> [  109.449542]  start_kernel+0x391/0x3af
>>> [  109.449606]  secondary_startup_64_no_verify+0xce/0xdb
>>> [  109.449671]  </TASK>
>>> [ 109.449729] Modules linked in: ath11k_pci(-) ath11k mac80211
>>> libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
>>> [  109.449846] ---[ end trace 0000000000000000 ]---
>>> [  109.449927] RIP: 0010:ath11k_dp_process_rxdma_err+0x1c8/0x810 [ath11k]
>>> [ 109.450073] Code: d2 48 63 d8 48 8b 4c 24 38 48 8d 04 5b 48 c1 e0
>>> 04 48 8d bc 01 f4 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
>>> c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2
>>> 0f 85 aa
>>> [  109.450147] RSP: 0018:ffffc90000007b90 EFLAGS: 00010203
>>> [  109.450212] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>> [  109.450275] RDX: 000000000000003e RSI: 0000000000000000 RDI: 00000000000001f4
>>> [  109.450337] RBP: 0000000000000000 R08: ffff88814c0e1470 R09: ffff88814c0f6678
>>> [  109.450401] R10: dffffc0000000000 R11: ffffed102981ecd0 R12: 0000000000000000
>>> [  109.450465] R13: 0000000000000040 R14: 1ffff92000000f81 R15: ffff88814c0e0000
>>> [ 109.450531] FS: 0000000000000000(0000) GS:ffff888233600000(0000)
>>> knlGS:0000000000000000
>>> [  109.450595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  109.450661] CR2: 000055570fe84cc8 CR3: 0000000152540006 CR4: 00000000003706f0
>>> [  109.450723] Kernel panic - not syncing: Fatal exception in interrupt
>>> [ 109.450794] Kernel Offset: 0x34e00000 from 0xffffffff81000000
>>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>> [  109.450837] Rebooting in 10 seconds..
>>
>> Thanks for the report. From the logs, I see the system crashed during
>> rmmod ath11k_pci. I have run rmmod & insmod tests several times on
>> WCN6855 before sending the revised version. Probably some tests before
>> rmmod would have led to this crash. Could you please let me know what
>> tests does the regression suite covers? I'll try repro the bug.
> 
> This is early in the tests, IIRC there was only insmod followed by
> rmmod. Do you have KASAN etc enabled?
> 

I see. I do not have KASAN enabled. Let me try enabling it.

Thanks,
Manikanta
