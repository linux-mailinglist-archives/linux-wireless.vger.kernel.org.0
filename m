Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2DC778995
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjHKJRu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHKJRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:17:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EEF1FF1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:17:49 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B5SDOo021061;
        Fri, 11 Aug 2023 09:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1d4cKS2h2HQFExZcyQWO78uzg8vVcrt2xkt1HqZchc0=;
 b=k24GEjbYP0uL8UK4EHKP14hAJSXN5i0wiz20MRcisIdrSArPe8WXXhDR8BVsCQ2tHRkL
 bqx5EBGSl2g6Too3SqMYz836KDna64354wHnezxd8aLx12xbDZFzyY1MtZpQZulSmTN7
 L9CmYmKkPhdGFQjWeqgtjTPNbxUqpa2p+BKunHiZ3USoHNeGSk80tpsTPn94WhkiOJ4R
 GtzbAGrJiehH4qXvzF7kWuq6wDLuB9P2qcTVaMf9t0LxVPn6u14xH9iwntWeFnNw55Bu
 i8NgkEzEAyv7adNZahkjs7/9G+0HmcfmIxcV+nAZOcHnC2MY0pFcV4kw6TO4fwJTRbQR Mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ywh74g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:17:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B9HjN4014702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:17:45 GMT
Received: from [10.201.206.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 02:17:43 -0700
Message-ID: <32e5e589-cb13-b27b-21e2-a9cffd160b3a@quicinc.com>
Date:   Fri, 11 Aug 2023 14:47:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 1/2] wifi: ath12k: Ignore fragments from uninitialized
 peer in dp
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230809042738.13394-1-quic_hprem@quicinc.com>
 <20230809042738.13394-2-quic_hprem@quicinc.com>
 <00af8b1a-40d4-469c-8646-d542db77b937@quicinc.com>
From:   Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <00af8b1a-40d4-469c-8646-d542db77b937@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dx9JytAPUNxwyUYMySoTVZ2wkVktVPW0
X-Proofpoint-GUID: dx9JytAPUNxwyUYMySoTVZ2wkVktVPW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=935 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110084
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/9/2023 11:41 PM, Jeff Johnson wrote:
> On 8/8/2023 9:27 PM, Harshitha Prem wrote:
>> When max virtual ap interfaces are configured in all the bands
>> with ACS and hostapd restart is done every 60s,
>> a crash is observed at random times.
> 
> nit: please fill the paragraph to 70+ columns
> 
>>
>> In the above scenario, a fragmented packet is received for self peer,
>> for which rx_tid and rx_frags are not initialized in datapath.
>> While handling this fragment, crash is observed as the rx_frag list
>> is uninitialised and when we walk in ath12k_dp_rx_h_sort_frags,
> 
> nit: s/uninitialised /uninitialized/
> 
>> skb null leads to exception.
>>
>> To address this, before processing received fragments we check
>> dp_setup_done flag is set to ensure that peer has completed its
>> dp peer setup for fragment queue, else ignore processing the
>> fragments.
>>
>> Call trace:
>>      PC points to "ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]"
>>      LR points to "ath12k_dp_process_rx_err+0x480/0xfcc [ath12k]".
>>      The Backtrace obtained is as follows:
>>      ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]
>>      ath12k_dp_service_srng+0x78/0x260 [ath12k]
>>      ath12k_pci_write32+0x990/0xb0c [ath12k]
>>      __napi_poll+0x30/0xa4
>>      net_rx_action+0x118/0x270
>>      __do_softirq+0x10c/0x244
>>      irq_exit+0x64/0xb4
>>      __handle_domain_irq+0x88/0xac
>>      gic_handle_irq+0x74/0xbc
>>      el1_irq+0xf0/0x1c0
>>      arch_cpu_idle+0x10/0x18
>>      do_idle+0x104/0x248
>>      cpu_startup_entry+0x20/0x64
>>      rest_init+0xd0/0xdc
>>      arch_call_rest_init+0xc/0x14
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
>> ---
> 
> actual code patch LGTM
> 
Thank you Jeff. Sure, will update the commit message.

Thanks,
Harshitha
